Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01408C54FC6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIXu-0004nG-Q8; Wed, 28 Aug 2024 09:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjIXs-0004lZ-WF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjIXr-0007z5-Go
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724851026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TgtqdjKCvWtZAewbSEHHFCTAFowGaw5CywnmWY6G8o=;
 b=QoQ22abjO5k819TF5nPNXeaBu7ryMqgNPwJYlW/Q8yNzDvCAOWKpJIvcloK1XQjuBqyyvH
 Z4HvfvV3mm+kb3GUGFL4BI2VuA7k4DCbNt+ke7hvWoqaeNfvPwGwT4HYvQzes4zT+HEWAn
 XZlIxcsdf2GJrUjfvnmxIIePaYNmW8s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-xg62V1oaMYKhzctZzJuAYA-1; Wed,
 28 Aug 2024 09:17:01 -0400
X-MC-Unique: xg62V1oaMYKhzctZzJuAYA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82E481955D52; Wed, 28 Aug 2024 13:17:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E39E919560A3; Wed, 28 Aug 2024 13:16:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE1BB21E6A28; Wed, 28 Aug 2024 15:16:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-trivial@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>,  kvm@vger.kernel.org,  qemu-devel
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 1/2] kvm: replace fprintf with
 error_report()/printf() in kvm_init()
In-Reply-To: <E66A6507-F348-49F9-8887-1CE24A5827EF@redhat.com> (Ani Sinha's
 message of "Wed, 28 Aug 2024 18:10:24 +0530")
References: <20240828075630.7754-1-anisinha@redhat.com>
 <20240828075630.7754-2-anisinha@redhat.com>
 <87ikvkriw3.fsf@pond.sub.org>
 <E66A6507-F348-49F9-8887-1CE24A5827EF@redhat.com>
Date: Wed, 28 Aug 2024 15:16:55 +0200
Message-ID: <874j74rdmg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ani Sinha <anisinha@redhat.com> writes:

>> On 28 Aug 2024, at 4:53=E2=80=AFPM, Markus Armbruster <armbru@redhat.com=
> wrote:
>>=20
>> Ani Sinha <anisinha@redhat.com> writes:
>>=20
>>> error_report() is more appropriate for error situations. Replace fprint=
f with
>>> error_report() and error_printf() as appropriate. Cosmetic. No function=
al
>>> change.
>>=20
>> Uh, I missed this last time around: the change is more than just
>> cosmetics!  The error messages change, e.g. from
>>=20
>>    $ qemu-system-x86_64 -nodefaults -S -display none --accel kvm
>>    qemu-system-x86_64: --accel kvm: Could not access KVM kernel module: =
Permission denied
>>    qemu-system-x86_64: --accel kvm: failed to initialize kvm: Permission=
 denied
>>=20
>> to
>>=20
>>    $ qemu-system-x86_64 -nodefaults -S -display none --accel kvm
>>    Could not access KVM kernel module: Permission denied
>>    qemu-system-x86_64: --accel kvm: failed to initialize kvm: Permission=
 denied
>
> You got this backwards. This is what I have:

I do!  Sorry %-}

[...]


