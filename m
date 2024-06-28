Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533A6C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDKR-0001wI-67; Fri, 28 Jun 2024 11:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNDKP-0001vs-Ow
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:15:57 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNDKN-0007Bm-PD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:15:57 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a729da840a8so303999166b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719587754; x=1720192554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QEeZ8SJ0ctZoKPpOjo6vvO42BxsIkxrX7QSRp3KFdwM=;
 b=hWOrTKW/QEyAkYKxbjmjNau/JYBBPMwmoO5C0mF/4FvYCsqnVkgmxClePuWdib2I9d
 juYP6boQ0nZRhOg9oWrsWUMSTDFMe5nOMnsfGVLWR/qtfd6uxKkNCApYUHjxsAn9ZSdX
 rhrKwEDPrU1QSUwEb02wkT6OHesvzuAGHZWpojDbcCRb16ehnnbpgf1cQlgdA5VNgIpw
 +1RGYXY49H6jpIbfpzY0G9t2RWQ9IDP7+OnaXs1RlY7wy/FpNbqiTELhXAXwDHUJIDQh
 74u55guorydIcTitgCUP6HQZVrtVFx8SmcmFn3oEqY4YkbBhiufLEaPU1Ho2kzvMRR7W
 MMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719587754; x=1720192554;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QEeZ8SJ0ctZoKPpOjo6vvO42BxsIkxrX7QSRp3KFdwM=;
 b=mP5XaR9bdYnUWQdbnkE47edrUMOYr0QVhDKujJzGeDbcMbidEvVjt8hooe82iDQoK1
 EfL9HG8A/xRi7Ilh5CNOjAr2HVvjUjU6RxBGIuRoRNpws52WHQhNJtKMxrCdF/WSxQIf
 6vr7h1+EgVNmcU8GaTL/s8P1neJ5U0WGPY2Kvk4bSBy2/037/1IzYeZ8DqEzZ0C4tR/H
 wIljM6wxllJlgrARZtAnSPEbNGLLZsGI9onGA7NDTX/hoydM7chx0h+NMJrFOx0LWgnZ
 3Yv6i6M9VMCyyAeGdT9b+v/P+1V4kHjeJN4bjihUpxnOpYG+E5qfEJj1JZq7s3OeXvOw
 SjPQ==
X-Gm-Message-State: AOJu0Yw29SywaqdS0X6iK+AKILfeCgO2L9dUsff9lDO0o4kDsMsUXgPq
 xS2nRRWlzqEg5y3oWT6uYdqYzKQaibcfDlc2uZWmZwLyQpupq1RTu05JBm4Y5Dg=
X-Google-Smtp-Source: AGHT+IH6M1U6P+5oyuyPQQbY0xrg71Swgf8ARTdq01MF2sR/XLt6wO0F0O+UodndFx66Lff/pjVI0g==
X-Received: by 2002:a17:907:2d1f:b0:a72:634d:d843 with SMTP id
 a640c23a62f3a-a72aef66f40mr198713566b.34.1719587753628; 
 Fri, 28 Jun 2024 08:15:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf633desm87892066b.73.2024.06.28.08.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 08:15:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36AFF5F7A1;
 Fri, 28 Jun 2024 16:15:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 richard.henderson@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE
 TCF0 field
In-Reply-To: <be8b6f51-300e-3ae8-b2c3-f85f70b0ad46@linaro.org> (Gustavo
 Romero's message of "Fri, 28 Jun 2024 11:55:44 -0300")
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
 <87zfr5nu0z.fsf@draig.linaro.org>
 <be8b6f51-300e-3ae8-b2c3-f85f70b0ad46@linaro.org>
Date: Fri, 28 Jun 2024 16:15:52 +0100
Message-ID: <87a5j5nlnb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Alex,
>
> On 6/28/24 9:14 AM, Alex Benn=C3=A9e wrote:
>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>=20
>>> Factor out the code used for setting the MTE TCF0 field from the prctl
>>> code into a convenient function. Other subsystems, like gdbstub, need to
>>> set this field as well, so keep it as a separate function to avoid
>>> duplication and ensure consistency in how this field is set across the
>>> board.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   linux-user/aarch64/meson.build       |  2 ++
>>>   linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>>>   linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>>>   linux-user/aarch64/target_prctl.h    | 22 ++----------------
>>>   4 files changed, 63 insertions(+), 20 deletions(-)
>>>   create mode 100644 linux-user/aarch64/mte_user_helper.c
>>>   create mode 100644 linux-user/aarch64/mte_user_helper.h
>>>
>>> diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.=
build
>>> index 248c578d15..f75bb3cd75 100644
>>> --- a/linux-user/aarch64/meson.build
>>> +++ b/linux-user/aarch64/meson.build
>>> @@ -9,3 +9,5 @@ vdso_le_inc =3D gen_vdso.process('vdso-le.so',
>>>                                  extra_args: ['-r', '__kernel_rt_sigret=
urn'])
>>>     linux_user_ss.add(when: 'TARGET_AARCH64', if_true:
>>> [vdso_be_inc, vdso_le_inc])
>>> +
>>> +linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [files('mte_user_he=
lper.c')])
>>> diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/=
mte_user_helper.c
>>> new file mode 100644
>>> index 0000000000..8be6deaf03
>>> --- /dev/null
>>> +++ b/linux-user/aarch64/mte_user_helper.c
>>> @@ -0,0 +1,34 @@
>>> +/*
>>> + * ARM MemTag convenience functions.
>>> + *
>>> + * This code is licensed under the GNU GPL v2 or later.
>>> + *
>>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>>> + */
>>> +
>>> +#include <sys/prctl.h>
>> Aside from missing the osdep Phillipe pointed out including prctl.h
>> here
>> is very suspect as its a system header. I assume if we need
>> PR_MTE_TCF_SYNC we should hoist the definition that linux-user uses into
>> a common header.
> Other .c files include <sys/prctl.h> for other PR_ definitions. For examp=
le,
> syscall.c and elfload.c. Is this really a problem?

If your building on an arch that doesn't natively have MTE but you'll
run an aarch64 linux-user guest.

> I see that would be a
> problem when trying to build, for instance, aarch64-linux-user target on a
> BSD host, but we don't support it. Building *-linux-user target is only
> supported on Linux host, no?

True, but multiple libcs. Anyway I've fixed up and posted the maintainer
tree.

>
>
> Cheers,
> Gustavo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

