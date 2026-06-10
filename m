Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ED4CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQYC-0003Vb-BW; Wed, 10 Jun 2026 17:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXQY6-0003VM-V0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:33:23 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXQY5-0002br-Gg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:33:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2bf36a6905cso52017225ad.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781127199; x=1781731999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VbqsXvGw3ygt3HBfsQWgFkBivVvb3LCoMLUpfPoOBPI=;
 b=eCt8cNNGEJAAt2oBROyybdTXjl4kwyDOlJSqvu4UIjW3T4mgiQxVqFn1IbVYp52Opd
 SfcvRwp+G7KjtPoWaPrmqgtVYpCzf5Rtm97n3P2J3TQ8wcgunxueufppRw/ZZM57yRel
 OW8SwRVN6yTM8X/dxLDda6bO7gIjGKj5hcz0Q/+Dd/SOLj07eTzKES9vT0a+JlSLrBY4
 Ns2H4k9rbBL0/Qs+gCKFmaFqF1NT6wL0RiOptddSpzBfVmNll5272juLwAgF8c+xKekf
 3+utwmO9RktEUBDCT2UmbFgx7T35f2WSUl7vIhFNCaurgzXZjBLckxcMqs5Jrw8N3yOW
 +x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781127199; x=1781731999;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbqsXvGw3ygt3HBfsQWgFkBivVvb3LCoMLUpfPoOBPI=;
 b=ZQUmKs8dn7dzTnTPfyTZXS25tYyrNX8t3+g0MGGWIur++2lWwgxVWP6vh1afF733U8
 M4/6ugfrGcL8F2KmQItcplD4/saEshY8M2muhYYzIurW4s+EoF0+8HHiYJ7jI184NUnb
 0hhBxLCwOl6iCEOKHhSGwqTbbPGI3umH99rWtAR6KSMJSoEADN5vOBG8t6/8JGa+9ilG
 yyCAMtDGcH4UNCzOwFzK7bc5sJaJog/Ep1CepaOP5k0TK5VrvnvO7Y2gHOyMtif3h102
 qRj/FgUKsl4T7YZZb3v2wWY21H5sDR75qMJiS8EySmqkFK1h/M6Yi0yz+ZNJzX62fMcJ
 xJQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AeZwZ+0jZt3eFzAFOxvvKy2FRuHX0vfibq98qnVe4W281EjMbpbjeNUGTt1w7A2GVk9NU8JjEA+2e@nongnu.org
X-Gm-Message-State: AOJu0YyRcceBVXCvn8slylJifrL6KBBeffYxSN7jguvVqLbPNpLAHKJ1
 TtPUrC0l+LcIiDketGqKiNk1g+UwtOB+1gx3MtIXB+lcCqvwlLI6ZzMfkpsP9io9lqA=
X-Gm-Gg: Acq92OGpQhkVyVGYNlknfJC8WQQIeuQekXhSr+/fj3qxbdAMyvHES9Y/Kv2Ara+nOa6
 1UYaoI0N/UQYPZOELRrGDrgq1wInEAtXO5m01AS0MOB87Vg4kjUvfJxg2OclK18S7wB5jQvK8GP
 Cv9lrbBZGlWGmwtCcb7LhUCdTJ7wbNMcMuMFgLQDJ0ZIeYd6z+pU6vBi7mqeSWalUr219EyTddI
 Qw0Y9xCe3OGbVsaCmt6+HxXira4bYkN3OhNth2SXNXho7tgENeezETUozgBsQd3BlnIlFdG3Tpr
 U4AmZ+FgvpUGTFBO7l5GLBHQH/2IpGNtKp+a2HrPf7HgEjqfBtqiOcfALF8XsLbflFfAUk5h3pq
 EzwpYwJxxB2i2g/B5qmnwHSJ0ggsUTUrEX/+B0XvDKAuzq1q5ofwNh/kYAvkSuXLX9Hj9CbYxmE
 P9uNeEdmDyvuZe2DsnbuQfA9DErEL8WP6kLhKW9jOgQMBDd+oOwbu0D/FMBA==
X-Received: by 2002:a17:902:c40e:b0:2c1:e9f8:758d with SMTP id
 d9443c01a7336-2c2a1c65e95mr113500655ad.22.1781127199547; 
 Wed, 10 Jun 2026 14:33:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6d2bbsm272273095ad.1.2026.06.10.14.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 14:33:19 -0700 (PDT)
Message-ID: <27ef2bdc-0502-4920-b3ef-168f4db82fef@linaro.org>
Date: Wed, 10 Jun 2026 14:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] target/arm: gate check on scr_el3 behind
 ARM_FEATURE_EL3 check
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260610204322.828645-1-alex.bennee@linaro.org>
 <20260610204322.828645-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260610204322.828645-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 6/10/26 13:43, Alex Bennée wrote:
> We shouldn't be reading SCR_EL3 unless ARM_FEATURE_EL3 is enabled for
> this system. If it is not there cannot be any offset so just return 0.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/helper.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 22f5117ee54..8946d2aad28 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1413,6 +1413,10 @@ void gt_rme_post_el_change(ARMCPU *cpu, void *ignored)
>   
>   static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
>   {
> +    if (!arm_feature(env, ARM_FEATURE_EL3)) {
> +        return 0;
> +    }
> +
>       if ((env->cp15.scr_el3 & SCR_ECVEN) &&
>           FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV) &&
>           arm_is_el2_enabled(env) &&

No, like this:

     if ((!arm_feature(env, ARM_FEATURE_EL3) || (env->cp15.scr_el3 & SCR_ECVEN))
         && FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV)
         && arm_is_el2_enabled(env)
         ...


r~

