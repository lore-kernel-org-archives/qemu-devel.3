Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C562CFC268
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 05:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0aW5-0004MT-S6; Tue, 15 Oct 2024 01:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t0aW4-0004MB-Fj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 01:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t0aW2-0007iQ-Kc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 01:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728971680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=qKoM5VE0nPxM3TMqsZZHR3RZneqgTrsMgRideuoyNB4=;
 b=B7sZyo7mehj05Um3LnU5UjDuA6qhdwScseBSOZJJSATlblrkiUDf9fHkULo1jneDsAYrQt
 bzk99BiJxJwXb2ZX3XweH1UELqynyVlc83bMIxL83AxIGOCshupz9xsQ0q/KXC+faF1R4t
 iCxUaLsVxI12Siievo0gEEWq4x/zLEg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-pQXUDesKOUe5gb73cW1PoQ-1; Tue,
 15 Oct 2024 01:54:36 -0400
X-MC-Unique: pQXUDesKOUe5gb73cW1PoQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E55F19560A1; Tue, 15 Oct 2024 05:54:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4870819560AE; Tue, 15 Oct 2024 05:54:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CCDE721E6A28; Tue, 15 Oct 2024 07:54:29 +0200 (CEST)
Resent-To: michael.roth@amd.com, xieyongji@bytedance.com,
 Coiby.Xu@gmail.com, eduardo@habkost.net, mark.cave-ayland@ilande.co.uk,
 philmd@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 15 Oct 2024 07:54:29 +0200
Resent-Message-ID: <87y12prjvu.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  xieyongji@bytedance.com,  kwolf@redhat.com,
 hreitz@redhat.com,  Coiby.Xu@gmail.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,
 mark.cave-ayland@ilande.co.uk,  michael.roth@amd.com,
 kkostiuk@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 5/7] target/i386/cpu: Improve errors for out of
 bounds property values
In-Reply-To: <17b2cfbf-3434-4e30-9c46-47406dc1de4b@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 11 Oct 2024 12:11:50
 -0300")
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-6-armbru@redhat.com>
 <eed14342-3b79-450c-a617-533d3256a241@linaro.org>
 <878quvg3p6.fsf@pond.sub.org>
 <17b2cfbf-3434-4e30-9c46-47406dc1de4b@linaro.org>
Date: Tue, 15 Oct 2024 06:45:12 +0200
Message-ID: <878quqrn3b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 10/10/24 16:25, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> On 10/10/24 12:01, Markus Armbruster wrote:
>>>> The error message for a "stepping" value that is out of bounds is a
>>>> bit odd:
>>>>       $ qemu-system-x86_64 -cpu qemu64,stepping=3D16
>>>>       qemu-system-x86_64: can't apply global qemu64-x86_64-cpu.steppin=
g=3D16: Property .stepping doesn't take value 16 (minimum: 0, maximum: 15)
>>>> The "can't apply global" part is an unfortunate artifact of -cpu's
>>>> implementation.  Left for another day.
>>>> The remainder feels overly verbose.  Change it to
>>>>       qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=
=3D16: parameter 'stepping' can be at most 15
>>>> Likewise for "family", "model", and "tsc-frequency".
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

[...]

>>> Confusing:
>>>
>>>      qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=
=3D-1: parameter 'stepping' can be at most 15
>>
>> For better or worse, visit_type_uint64() with the string input visitor
>> parses -1 modulo 2^64, i.e. as 2^64-1, just like strtoul() & friends.

I wish we had avoided that design mistake.  Likely too late to fix now.
The JSON parser gets it right.

> Would "parameter 'stepping' must be between 1 and 15" be clearer?

It might be clearer and would be wronger: zero is a valid value.

I could do "must be between 0 and 15".  But "stepping" is a *counter*.
A negative stepping makes no sense to me.

Same for model and family.

More so for tsc-frequency.

Thoughts?


