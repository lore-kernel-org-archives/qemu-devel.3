Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21478EC1E88
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnw2x-0005jU-TN; Thu, 05 Feb 2026 04:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vnw2w-0005jM-Kw
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vnw2u-0003u7-Jy
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770285185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDJzsWPv1ZnBRrec5irSjpHWoi212XZm/rbMef5DNyc=;
 b=gE/90ljHyaGPTXdwdB3UKguE6yIevZpaQaWrcuonoFXliiq4/55fFUQSs54cEUCRDySUS7
 n6Pa6rxMLLdMMWBzugj5oP0pJgMQwemqommuevhSrYH9kCsa0XHCTOqXw3H6hV7U2M4wXj
 mVJVlyRpT8LWaFf1621GdTiUwkDq6rs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-LyWwfR6xOH61-ox0BnW53g-1; Thu,
 05 Feb 2026 04:53:01 -0500
X-MC-Unique: LyWwfR6xOH61-ox0BnW53g-1
X-Mimecast-MFC-AGG-ID: LyWwfR6xOH61-ox0BnW53g_1770285180
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 163C4195608F; Thu,  5 Feb 2026 09:53:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95AA11800465; Thu,  5 Feb 2026 09:52:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2653721E692D; Thu, 05 Feb 2026 10:52:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] target-info: set target_arch statically
In-Reply-To: <e1495603-4ac2-44bb-8b0d-74c45e5f2e66@linaro.org> (Richard
 Henderson's message of "Thu, 5 Feb 2026 08:22:11 +1000")
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
 <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
 <e1495603-4ac2-44bb-8b0d-74c45e5f2e66@linaro.org>
Date: Thu, 05 Feb 2026 10:52:57 +0100
Message-ID: <877bsr34au.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/5/26 02:36, Pierrick Bouvier wrote:
>> On 2/3/26 5:36 PM, Richard Henderson wrote:
>>> On 2/4/26 05:41, Pierrick Bouvier wrote:
>>>> target_arch() function will reparse target_name() every time if it was
>>>> not set to a proper SYS_EMU_TARGET_* value (when using
>>>> target-info-stub.c), which is not efficient.
>>>>
>>>> Since we want to preserve the constness of TargetInfo but C doesn't gi=
ve
>>>> us flexible compile time expressions, we simply set target_arch using a
>>>> static constructor once instead.
>>>
>>> A static constructor isn't static initialization.
>>> That said, we can do better with some extra help from meson; see attach=
ed.
>>>
>>> I'm mildly annoyed with openrisc vs or1k.=C2=A0 We really ought to fix =
that, but I haven't
>>> looked into what API breakage we get from selecting one or the other.
>>>
>> This was my first approach, and I noticed the or1k issue + missing hexag=
on in SYS_EMU_TARGET enum. Having a hack for target name in meson.build is =
*really* ugly IMHO.
>
> I agree.
>
> I assume the qapi string is the one that should take precedence; everythi=
ng else appears to be merely qemu source level strings.  Marcus, can you co=
nfirm?

What exactly would you like me to confirm?

I *guess* it's about the messy part of the patch you posted upthread.
There, you have to normalize TARGET_ARCH value 'openrisc' to 'or1k'.

>> At the moment, hexagon is only linux-user, so I thought it didn't make s=
ense to add it to SYS_EMU_TARGET, and I didn't want to go down the rabbit h=
ole to rename or extend this qapi definition, as the initial goal is just t=
o define a field before main, which I consider to be static initialization,=
 even though you might prefer to call it differently.

I figure this is about adding 'hexagon' to SysEmuTarget even though it's
not actually a system emulator target now.

The fact that adding it there helps indicates SysEmuTarget has leaked
into user emulators, and its name has become misleading.  Is this true?

> I was only going to ask you to change "statically" to "at startup" there.
>
> On the other hand, system-mode patches for hexagon have been on the list =
for a while, so I don't think it's jumping the gun too much to include it i=
n SYS_EMU_TARGET at this time.
>
>> I'll let you upstream whatever changes you prefer, and I drop this patch.
>
> Ok, will do.
>
>
> r~


