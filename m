Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FCDC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUy4-0004Ik-TY; Fri, 21 Feb 2025 10:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tlUy2-0004IM-Oh
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:29:30 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tlUy0-0007mo-W8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:29:30 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5deb956aa5eso2785688a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740151766; x=1740756566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZP0luUtVsEUjAC3KAgWqXCf1eK7iCM+a/A7Gr584v+A=;
 b=gRHt1cx6NRi6A45EG5XA1RrmYaZDPkPKg1W/KBXutTYbM+2wsVmhvhVkiaT/IfE/qy
 Zak+CAGr7HnkcuhgmyMCKux1m8RfYUHezfvIej75IIXyS4AzTKOvd8LKHky02qB7XKns
 fkEsuHpqv2b7mlNF3Bq1dY97Wnh4cOxU3NJTyQ9FQeJgaqL/cX09sMzZN+b+EdIta1CP
 NuteIkL5XUY+rc/mX7vk4zAauZqw0L5ByU1tZrgs8mooVFWorZ066zaZzhDrlV+zPlBr
 03weQ5y2tsz+0i4DrNVN11dmeFDL/M4D87Mvea/I5mjvmBD767xwm+x0m5TP4lc56KRK
 evZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740151766; x=1740756566;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZP0luUtVsEUjAC3KAgWqXCf1eK7iCM+a/A7Gr584v+A=;
 b=VeMopcMcizZI7Xr31uu46AobI12vhSnK8QJwaf7ZVfPSR5wqGoYzjB4wnx57xdw9Wu
 miG+D6wMMe9TxmwkEmjiodbGiqo5iQrerXj0j3bIGxOgCWh84OUCQ6tMS5WUJ7PzqQ6a
 hTeU/9G4QSEIDHgAjtx7ijGI0eyvg7PxI0TIQM91kvI+KDDJoRvtvOyIv7rxwrzjdwq9
 2QwB/J0s2gNn5FnOBiIlqnavcBweTaXJG6Y/seCeFP3CiwegD9GWpTsiZmwZtB8VP8os
 SDmVkBTx6yztuB8RHnzAy20Z62WXW9J3m3AfUiP9cee9Y8hb2foPdRMO8mxEC+NSstPi
 zF6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb8NwhMZZy2HcpAgMB6WLVPDS3zr38IXJW/OAqv4s2KDtCNsLD8A6EH3SOlCeErcZkWBIjls9pS8gZ@nongnu.org
X-Gm-Message-State: AOJu0Yy60DyL3XPpjxIAA21xfSY2E0dtuS0S+O/1pgS+R+Zs3yVPURwF
 Lgg3zrWOaN/bGvfZjym0OnEyZPKe9AO0rsa6KLjrkc5cCh8xxuamFUG3b5dhyPk=
X-Gm-Gg: ASbGncswYy33ZcA+kl4wc7OfAbZB916q0Ja+k5M5Uclb/F/juVVftrcEkBncPvApsNA
 E1bU4ntZpPDikRSwNVaK6XUmRsm9JyS0xtf25N3v5H4C8s7XpYquCyVbzaCZyuEuFlpnm6BRU85
 rd3B/Rbn1DcAgWQ5aeygWBfOQThwWPftfdU/TKfX3HjIt461GsrWxi0haVC5yG3f/0qANURKSvi
 9zdDbIUxxXTr9QrDAK0MVEkhGjHwirg42hgUdCN6lL1PvGpEPge0NsnHQNoYAcEgVPrU/GH/Nge
 yWeaB8Hc1cxsOJB+5B93QVVD9DuA
X-Google-Smtp-Source: AGHT+IELxTM2yLIZq9vD5Y+XLUe26qOjEFjBPK0FHcA1sGR0lhiDjmpX24Dg+iDX72S098Eumwo7aQ==
X-Received: by 2002:a05:6402:388c:b0:5e0:7cc4:ec57 with SMTP id
 4fb4d7f45d1cf-5e0b7266ba5mr6734749a12.31.1740151766092; 
 Fri, 21 Feb 2025 07:29:26 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb98640619sm1036057166b.54.2025.02.21.07.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 07:29:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A7655F8C8;
 Fri, 21 Feb 2025 15:29:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Leif
 Lindholm <leif.lindholm@oss.qualcomm.com>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] tests/functional: Bump some arm test timeouts
In-Reply-To: <12ff6477-7cd5-4ada-b7a8-97a3add814c3@redhat.com> (Thomas Huth's
 message of "Fri, 21 Feb 2025 15:25:21 +0100")
References: <20250221140640.786341-1-peter.maydell@linaro.org>
 <12ff6477-7cd5-4ada-b7a8-97a3add814c3@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Feb 2025 15:29:24 +0000
Message-ID: <87eczriaej.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 21/02/2025 15.06, Peter Maydell wrote:
>> On my local machine, for a debug build, sbsaref_alpine takes
>> nearly 900s:
>> $ (cd build/x86 && ./pyvenv/bin/meson test --setup thorough --suite
>> func-thorough func-aarch64-aarch64_sbsaref_alpine
>> )
>> 1/1 qemu:func-thorough+func-aarch64-thorough+thorough /
>> func-aarch64-aarch64_sbsaref_alpine
>>                        OK 896.90s
>> arm_aspeed_rainier can also run close to its current timeout:
>>   6/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspe=
ed_rainier
>>                        OK 215.75s
>> and arm_aspeed_ast2500 and arm_aspeed_ast2600 can go over:
>> 13/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspee=
d_ast2600
>>                        OK 792.94s
>> 27/44 qemu:func-thorough+func-arm-thorough+thorough /
>> func-arm-arm_aspeed_ast2500
>>                   TIMEOUT 480.01s
>> The sx1 test fails not on the overall meson timeout but on the
>> 60 second timeout in some of the subtests.
>> Bump all these timeouts up a bit.
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This at least gets 'make -j4 check-functional' to passing for me
>> for an arm/aarch64 debug build, apart from the gpu test hang which
>> we're discussing in a different thread. Whole thing takes 25 mins...
>> ---
>>   tests/functional/meson.build     | 8 ++++----
>>   tests/functional/test_arm_sx1.py | 6 +++---
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>> diff --git a/tests/functional/meson.build
>> b/tests/functional/meson.build
>> index b516d21cba1..effa31701cf 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -15,16 +15,16 @@ test_timeouts =3D {
>>     'aarch64_raspi4' : 480,
>>     'aarch64_rme_virt' : 1200,
>>     'aarch64_rme_sbsaref' : 1200,
>> -  'aarch64_sbsaref_alpine' : 720,
>> +  'aarch64_sbsaref_alpine' : 1200,
>
> I wonder whether we should disable that test with @skipSlowTest() by
> default, since it's really very slow...?

The pauth subtest is marked as @skipSlowTest() - but I think we can drop
test_sbsaref_alpine_linux_cortex_a57 and
test_sbsaref_alpine_linux_max_pauth_off because we don't actually verify
anything so its wasted cycles booting something that we know already
boots.

>
> Anyway, for this patch here:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

