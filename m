Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9F8CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXITg-00086I-Ra; Wed, 10 Jun 2026 08:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXITd-00085E-OX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:56:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXITb-00067H-28
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:56:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so85492015e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781096169; x=1781700969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iz0ngY1sXeTCS93/5xcUXu2WeIGooCazJt0AoK12xig=;
 b=i9ZF9aV3sVI6T8jvjXf3JH9L46jzvoLPjbnBHzH+2I2dIEFqsJxWWpemGhIqU0vtAz
 B1sRZKauxW8CkZ7B7V3Su8x3mbGlDMtJrP9OeGgYq6g3LT8xhdrNbbL6q8bPYNzts1RW
 khR2KJljgG7rz/6kuKApIGm3mWREEG0eQaEe5xWaidULYkXHzU3PbL4Vs9IIcg/2Idf+
 N8grKxxBPLfF/j4J6IOkuAhB2qpeJ/TDh0hlaL779I1keoLVkCIW04UtbXb9PpbcOQOJ
 TxA0zE/qO2/xhWzrYTAlTm8OE0MpE1BIIeg8nv+u51DpRAMpRwE3K2aW5I9rzLwY78RA
 7h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781096169; x=1781700969;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iz0ngY1sXeTCS93/5xcUXu2WeIGooCazJt0AoK12xig=;
 b=UcBO74Ux6leKJ4UuOJZuKIOG54kZbcuRDELdJspiFsxW4dO6aB+GwarCVnEGMEMvQc
 ZRS4UzO8lHBp5dlh+mwVS9EZkvuUYbJkB/Z0BhI8CPKSPz0hAbO4W34ba6Ol2XSqrfpH
 OYAbf7ZAMR5V9QFhd37tgAfKy8RjY4xBD+RkApS+sz4Az63XXqpUDDUiM4OOF+xv+jzC
 69c96nslsHWgosGRU7XqfwJFZjZ+pLO+EovViUFnT3PNLyr5mwtXhSkfy7qUtqQFtl2p
 93psUPTsYN/rjWV9jRZ0BtA0aC0YUO3ye9l+lQ3UfFg0b+StzOkSMufNK2L/e/AHcdul
 hlbw==
X-Gm-Message-State: AOJu0YzJyr8FvFgJt0FrhHYXBb+Ksqdf7GLakJJFCXi2NEPWn2hCIcBT
 KpxQup20NuuPGjWARUoXosVir13HLxsFeZUZH3NPfBSRm/9vrBlubWNGqhMdkm6OtH8=
X-Gm-Gg: Acq92OHwF3cNvVBV2CN/f+JtQcLW9VwV8CxlkO0fisykHLss+UtlrWSggZJIdJxwWZk
 0P49/7B8RmvFtFh92yTbLT1jE+80EnGJktPnw0UeGurdhwwtUP2NN693BRhr+xKm2oxZ4p1s0GW
 hEaU741cSi/73iIy2MYztzYo09lfFl0HNIBWg4bD0ln/h1YRLc5cRhXta2Tne/uEqkRJSMYkkBN
 K1V5xsAEiKHuwnor8e5rk5cOYqGP9r27ofP+BEOj2U7HWXEIFVFOg6fXnXtHXibtZeGI+GDFx28
 H2LywQFIFzxw0YoI1brob2Yjyqy3M3U3GeejjNZFyMmAfsLTFzJyG6S0W16kA8oUsIo9sEVy/0Z
 tWMqlxxvzI8tqYM7HUL1MEkgZa+VieCjw5XhmVKgXTO0O6ovHm90gTk7FzGYHqfZDazboKDTY6H
 TDOms31gwi+E8oKgFIhwFMYhOB7mFX/WgnwA==
X-Received: by 2002:a05:600c:4e45:b0:490:c01a:5f10 with SMTP id
 5b1f17b1804b1-490c257f8cdmr407492185e9.15.1781096168567; 
 Wed, 10 Jun 2026 05:56:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490dca9f4b2sm42812845e9.2.2026.06.10.05.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 05:56:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 01DDF5F833;
 Wed, 10 Jun 2026 13:56:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] target/arm: trigger timer recalc on SCR:ECVEN change
In-Reply-To: <7914fe09-fdb4-4f5b-a283-aa364d0c4525@linaro.org> (Richard
 Henderson's message of "Tue, 9 Jun 2026 10:46:27 -0700")
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
 <20260609140008.3206970-4-alex.bennee@linaro.org>
 <7914fe09-fdb4-4f5b-a283-aa364d0c4525@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 10 Jun 2026 13:56:06 +0100
Message-ID: <87wlw6ftax.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

> On 6/9/26 07:00, Alex Benn=C3=A9e wrote:
>> Toggling the ECVEN state affects the offset calculated in
>> gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
>> change.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   target/arm/helper.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 5c640853060..22f5117ee54 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -37,6 +37,9 @@
>>   #include "qemu/plugin.h"
>>     static void switch_mode(CPUARMState *env, int mode);
>> +#ifndef CONFIG_USER_ONLY
>> +static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
>> +#endif
>>     int compare_u64(const void *a, const void *b)
>>   {
>> @@ -821,6 +824,12 @@ static void scr_write(CPUARMState *env, const ARMCP=
RegInfo *ri, uint64_t value)
>>       changed =3D env->cp15.scr_el3 ^ value;
>>       env->cp15.scr_el3 =3D value;
>>   +#ifndef CONFIG_USER_ONLY
>> +    if (changed & SCR_ECVEN) {
>> +        gt_recalc_timer(cpu, GTIMER_PHYS);
>> +    }
>> +#endif
>> +
>>       /*
>>        * If SCR_EL3.{NS,NSE} changes, i.e. change of security state,
>>        * we must invalidate all TLBs below EL3.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> As an aside, gt_phys_raw_cnt_offset is missing a check on EL3
> existing, before the check for ECVEn set.

Not many of the references to cp15.scr_el3 seem to have those checks
(although I guess that may be inferred from higher up the call chain).

I can add a arm_feature(env, ARM_FEATURE_EL3) in front or maybe we want
something similar to arm_is_el2_enabled?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

