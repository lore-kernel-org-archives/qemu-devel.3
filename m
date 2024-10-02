Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AE0CF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzdD-0002AN-TY; Wed, 02 Oct 2024 09:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1svzdA-00029m-L8
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1svzd9-0001nS-11
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727876580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Fb/y5yvx0N7qhYFWCGLS6xYK9c5/NuNTUJKmqX+Cuc=;
 b=ZAQAgY3wicmKFSipNK4WzkXVBbCfgMEzzrZG0fQY4LgzFbpYDv/+K9vsJtutMEy8yAUw4D
 vQG6v97MvlCz0MVwSHia8OqhaVpUE/yFXx+ambHHquVkx18+hoNIAj6HrH0wqNtjmDRoaw
 wKxn+DcDUiA9OW7NkfiAKebg/atnilw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-5JLUlNadM2q8xmAwOmLmDw-1; Wed,
 02 Oct 2024 09:42:57 -0400
X-MC-Unique: 5JLUlNadM2q8xmAwOmLmDw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A18631944F07; Wed,  2 Oct 2024 13:42:53 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69C1C1956054; Wed,  2 Oct 2024 13:42:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>, Ganapatrao Kulkarni
 <gankulkarni@os.amperecomputing.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, darren@os.amperecomputing.com
Subject: Re: [PATCH V3] arm/kvm: add support for MTE
In-Reply-To: <f3da8f58-615b-42ed-a99d-20bfd9ec6b56@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240920073725.410373-1-gankulkarni@os.amperecomputing.com>
 <87tte3sxkx.fsf@redhat.com>
 <f3da8f58-615b-42ed-a99d-20bfd9ec6b56@linaro.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 02 Oct 2024 15:42:49 +0200
Message-ID: <87a5fmsjs6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 26 2024, Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Cornelia and Ganapatrao,
>
> On 9/25/24 14:54, Cornelia Huck wrote:
>> On Fri, Sep 20 2024, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>> +
>>> +        /*
>>> +         * Clear MTE bits, if not enabled in KVM mode.
>> Maybe add "This matches the MTE bits being masked by KVM in that case."?
>
> Clearing the MTE bits is also necessary when MTE is supported by the
> host (and so KVM can enable the MTE capability - so won't mask the MTE
> bits, but the user didn't want MTE enabled in the guest (mte=on no given
> or explicitly set to =off), so this comment is not always true?
>
> How about something like:
>
> "If MTE is supported by the host but could not be enabled on KVM mode or
> MTE should not be enabled on the guest (e.i. mte=off), clear guest's MTE 
> bits."

s/e.i./i.e./ :)

Otherwise fine with me.

>
> I do assume MTE is supported by the host (i.e. MTE bits >= 2 in the host)
> because otherwise condition "if (cpu_isar_feature(aa64_mte, cpu)) { ... 
> }" is not
> taken; and at this point cpu->isar->id_aa64pfr1 is set from the host's 
> bits via
> kvm_arm_set_cpu_features_from_host() and kvm_arm_get_host_cpu_features ().
>
>
>>> +         */
>>> +        if (kvm_enabled() && !cpu->kvm_mte) {
>>> +                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
>>> +        }
>>>   #endif
>>>       }


