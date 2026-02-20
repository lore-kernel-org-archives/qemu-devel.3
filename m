Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C184C55ABC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 11:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtP6O-0003ey-0w; Fri, 20 Feb 2026 06:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtP6L-0003eZ-TU
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 06:55:17 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtP6J-0001VK-SE
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 06:55:17 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c20dc9577so3594715a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 03:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771588513; x=1772193313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+ea69BD6Zx9C+7ujIFRrVS1k1IdY+Arhg1wnLwoi7E=;
 b=u9iEWFRb8Az2wed487n8lHDNcJH4z/uQRNIWYaSJ1MgPMdCSJesvx7TY5O9iEiKedT
 lHWI0TxPlzr1ME0uVWGkc9WgrfxPe2m0em7D33z14S6uCG6+Qm3FzdKS14z3xW7pRHgn
 pBo3yTVFxZ7BWKqM4CvhC95s+zr+uDpaWtn5te/SFwKkUwnPp84Nu//bnsgPJMspsZcF
 cScrCHEviEE161kOp+Ce2Lq3bo32uIVaChqeFHlvAR8rRWb8kn9C2XK6MkwCyq84lB39
 w9mMZpCAR396Mzm5VjplLweYiyCOxlr1AEyH7lv2J8xt1Sd/kA9eGVBbvLoJOw6L9So1
 gcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771588513; x=1772193313;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+ea69BD6Zx9C+7ujIFRrVS1k1IdY+Arhg1wnLwoi7E=;
 b=JsgV95wnMKmfErNOj+wnhrVRLNn1aafD2va3RgNhW2b7INm//MiZYwnW3Ebl8wDcZa
 B7FfTHbsddO0fKVgwq7p3U1GiODUMfCmIakhVJtuXeB3plymYuOM2PTt9NHkMG6InPwD
 M4TjhHf2hTJp+KW1nVZ/OLZ839UWz+7N0rBkrPs3WYWAK972hAAXtFDx8q/qDDjI5TCB
 5O9F3/6pZkEbq/v5e1rIRYRDagy66A6AsI3ROCamJArwDlUFa9wQ9/b2cjmRAKPVCdKv
 zheTQ2O4Mfx0F6Zbe/O0YL64TXjiRFpLbW11sO66rI5wKQpiOea0oRG8cM/khOFfSQHX
 l5iQ==
X-Gm-Message-State: AOJu0Ywkooyxo4wcWxD/tHuy9RRQ2vGb/8MJa2ZJwfrtk3vn1/yXVqSe
 02Y8P3N+BiqDVI/UhkNrL6H42FOivNgrhhEuOrbGAP7m56EHUPHumPTxt3cHb7xWGuw=
X-Gm-Gg: AZuq6aK6Q7HS4QoomXDa3YavKUOSHZ6GFLBC8LwYbjIfpPPlvtLK35coPJkNbJLk8TN
 kj91/zpzK19gpbmBSuSie0hvzwjm0urp47VW12n+MwYKmnv1y7oK0dl74Jz37lG78JQVOzy9ivq
 B+N0SDimu1G1Y2UYThNHk4y8gGx89Jl+HgZGsJ63AqRAGiqcitijzD3okv/RMDBgoHjxzaKB6im
 UxjcdDdJqtidASQ4N6kUNg9N79jgliddesQMsH8qkzMf33ml1ETnL+27HoNk5wQcvUtSbMJDrWB
 9RUq3O/WyTCu2A+NuBl9VqnETFQz6OsPdqaN2dq1LiErqC4cdiFvuzfB284kj4zoZnscKGX0OlV
 ICpXvczZUi45k9fa2xuruBp4aQHjTb5ysgCHbf36rL/7ao1YOynyQ/zeUV4+E55s2WkgPpt/r1l
 6ehYfp2dVIWE8wsV1oAzQnup4=
X-Received: by 2002:a05:6402:3506:b0:658:d1b0:9970 with SMTP id
 4fb4d7f45d1cf-65e80499ce6mr1003597a12.5.1771588513514; 
 Fri, 20 Feb 2026 03:55:13 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad3e356asm4719563a12.16.2026.02.20.03.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 03:55:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 97C925F838;
 Fri, 20 Feb 2026 11:55:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Yoshinori Sato <yoshinori.sato@nifty.com>,
 qemu-arm@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Thomas Huth
 <huth@tuxfamily.org>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Aurelien Jarno
 <aurelien@aurel32.net>,  Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Peter Maydell
 <peter.maydell@linaro.org>,  Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Jiaxun
 Yang <jiaxun.yang@flygoat.com>,  Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC PATCH v2 09/14] target/tricore: move cpu_reset from
 tricore_cpu_realizefn
In-Reply-To: <6e90ab90-f726-4fe3-83ba-cf3aa799062c@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 20 Feb 2026 11:56:11
 +0100")
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-10-alex.bennee@linaro.org>
 <6e90ab90-f726-4fe3-83ba-cf3aa799062c@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 20 Feb 2026 11:55:09 +0000
Message-ID: <87y0kn634y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 19/2/26 18:18, Alex Benn=C3=A9e wrote:
>> Implement a proper cpu reset handler for tricore cpus.
>> Message-ID: <20260108143423.1378674-11-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   target/tricore/cpu.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>
>
>>   static bool tricore_cpu_has_work(CPUState *cs)
>>   {
>>       return true;
>> @@ -120,8 +127,8 @@ static void tricore_cpu_realizefn(DeviceState *dev, =
Error **errp)
>>       if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
>>           set_feature(env, TRICORE_FEATURE_13);
>>       }
>> -    cpu_reset(cs);
>>       qemu_init_vcpu(cs);
>> +    qemu_register_reset(tricore_cpu_reset, cs);
>
> Per commit 9f1c70a2543 ("hw/core: Add documentation and license comments
> to reset.h"):
>
> "In general this function should not be used in new code where possible"
>
> Shouldn't we use qemu_register_resettable()?

Yes - I thought I checked them all but I must of missed tricore - will
fix on next iteration.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

