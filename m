Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB96CD7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAL2-0003Ar-A4; Mon, 02 Dec 2024 12:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAKz-00039w-Tm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:35:57 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAKy-0002xh-Ff
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:35:57 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ea5a7a5e48so2070347b6e.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160955; x=1733765755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQaS6G5sWjWl5o89iyiD/S3VMa8218keGp35CHhEoGo=;
 b=ZF9VsbhfIGnZPvRcdOpOuhAedow4t0DzYvujjJ7agTEtPAtQRjOcna3yPS6p01OxeB
 2gjhaZRcrR5cn0MUoN7Y+bPUOqrB91w1XcuooBRAn8oKCPLKXZKl2QjSWlz63KPX3Dds
 XgqFKoH6Mj4CIcK4lIyVVPklcNtA95arRntoZJCbvTsyW7LFi1RLYOiRddKm+HgCZkZk
 U9/SS2v0MqJySze5aTjjkouqf7RpfW58zXfjnU+omWq56JeQaD4cs4ihQHrzordN9tP6
 nTGJAG0uAWwc/L15he1+h7jsXEoD1fN2YgKSTltKGWBuE1rOEDBFI/XDiScSSgp0sKJl
 kG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160955; x=1733765755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQaS6G5sWjWl5o89iyiD/S3VMa8218keGp35CHhEoGo=;
 b=eAkVCiaEBtT5PG1Y4BHbAyRsoKZsAgExmYZDuzoDZWj7emAjKMKJq1JnqfdB8nPNya
 5CiOH0UbkN6Frk2QUVxf/wyAwC53pkNDj4mSOGvCSGETCeEnQ1YmYRXTQ/LLmp9Xq2ke
 lDxMNtQTWnhydvwIlJAW6ilHnoeG5zxTNLbeD1nEMv+E+d+48TveQJ4ftAqCGTlnA/K3
 mdc8GPHW0lfF4PDdY2F7FSH/R2mHOA7PBIYyxbkkyhq7ixQT0v/obGQN2GkSjPUad/EH
 SvYHo70K28QhSC9UpRdcHiib7WSrN0lvMmLdpmYyU6PTD6KbRXqt6oQzGDwpA9EMreLT
 Q4LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH1D1ZOAQMcd39Vt3A8ciunXcVwLwpD4QMuobL6I6IaZ6vPKBB2AbxOf6NUfFACPuSMxCSEUppv/l6@nongnu.org
X-Gm-Message-State: AOJu0Yz0WNVOGKk/56YJ1kNuhRbiKl5l3r2PQmherERLoYvblro1iDM9
 fHcBQjfTy0c2lmZb9lexi8JiO1ZZA9XNrdBJKVvjik0aUqAqQGB3CQtqOOilwg6Oj81xAL2wLDK
 tFGE=
X-Gm-Gg: ASbGnct1bYTkNLwDkT4HUoMMFnMNA2dUZfIXAdrv1HSVvC0HRwX96/8CveEOxcN9Faf
 H+wg/RFDay+CyIefGLUpSl/F7RYMzvFVo6Z0E0yt8v2ud+6Efi/iVcFYdcR9t/rwhN+iDRp3ayy
 CXCcKjhyP+wnzyGSckyw4IFVfqETUR2eyZ+rdzhH3+xa9CWw01Dvo5FtYk/xIFvw+eZkJaO5ZzJ
 Epy7h4aSSHHHsnpxTqpGVNoPxTdLB7Uz8NJAEDA4XdveMN44yeqi3kyXBJR9qCHz4ou6gA=
X-Google-Smtp-Source: AGHT+IEFOfZzA6JDT6CibGBIHYQ87eMyj2t6FDBIIlnySe9NOUGOgfoviraXRcKyGFVq7Zbp5QxXLw==
X-Received: by 2002:a05:6808:1a28:b0:3ea:5413:1a24 with SMTP id
 5614622812f47-3ea6dbcea00mr20139775b6e.13.1733160955332; 
 Mon, 02 Dec 2024 09:35:55 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86095b6fsm2327506b6e.15.2024.12.02.09.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:35:54 -0800 (PST)
Message-ID: <cbbbeab8-bc05-48b6-94d2-409b62327a1a@linaro.org>
Date: Mon, 2 Dec 2024 11:35:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 48/54] target/s390x: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-49-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-49-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for s390x.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/s390x/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index e74055bad79..adb27504ad5 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -209,6 +209,8 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
>           set_float_3nan_prop_rule(float_3nan_prop_s_abc, &env->fpu_status);
>           set_float_infzeronan_rule(float_infzeronan_dnan_always,
>                                     &env->fpu_status);
> +        /* Default NaN value: sign bit clear, frac msb set */
> +        set_float_default_nan_pattern(0b01000000, &env->fpu_status);
>          /* fall through */
>       case RESET_TYPE_S390_CPU_NORMAL:
>           env->psw.mask &= ~PSW_MASK_RI;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

