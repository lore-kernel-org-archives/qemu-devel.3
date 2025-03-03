Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15027C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 18:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpAhG-0008CK-N1; Mon, 03 Mar 2025 13:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpAhB-0008B3-ED
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:39:17 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpAh7-0002dA-TG
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:39:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so33104795e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 10:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741027149; x=1741631949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w32dCrkcvDLe4oi32yZecHDC2js3vcYPvpgqDZV+MO0=;
 b=Zp3+ACqiU1wIvjsqZk3vEaNdNH1hAmpEgXX2hOs/YUCGKNID5WItoRao3Ky7c6MygB
 +yYjrzjEwBAwFHw8NMMoN2i/f/l31uOO3xsT/B5Id5pgQFlrWx0uYtfOVac7uNgbejrC
 j+v9Fy4/uK/mIAqnrW446AEliKve6hSN40YAg4qhFtGmCINyV/kxAx0nq/JpcjEhnb7y
 La4Ez/lpCL2ebdA9Za5Di8AIv0l3bsJ0jSE66Gqp/1KdVBKyKRHXTTbJXPok4yrlXKey
 y0BNW3Hx0wbv2Ot7WMSjWap3aFb1asiqKFMtknp/7LnBYdF8dmmOtXlkxJGHAuma44cx
 koQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741027149; x=1741631949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w32dCrkcvDLe4oi32yZecHDC2js3vcYPvpgqDZV+MO0=;
 b=oAXeDMMzsoRDDeCw/T95HKBdx7xtATT5BzSMqPMrky5ffLbXunEtDgwzum8ZPPRrrp
 QgeT2rprYY4D6T2XrqMQP2TmOFlqnSUvLxi+0ljApPp6tY0A3TklTXTbGi5gyVk4cs5K
 365jBHwRNbsfB24X6Eme1MhcV473q5yEHau6Ds4yniq0QSwzfW+uTMsW/NoPIxVTe2sd
 NOgqOX8YTHLIFP8+EMrXAB3d36Qur28oJI7vJm/Sb4UBlqkOxS2eB1QbpisnM3rCwYcc
 CvLIuDT4qU54kRIUly4CSylnaHkYtRNRkLUjV+s9bUB0RqFQOOGLPgoLpYgueLpi2kKB
 JR8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXoN7geG4SUz1HJHB2lMol97xiAiFrBfp3vcZU6Z7ZdiP03edKxBa2QN/O8cIZV/FC0LUdjd/RzZiL@nongnu.org
X-Gm-Message-State: AOJu0YzCqESZlOcoTxtNk3HpojgE1K7Q/CYLcPOv/rDxV+KzErPt/gMB
 rosow0+lgvy/yWjLl+cyOEERbdqaLsSF+diDN+LLY+Xu8TuHRUmYdZZCZ1bt1T8=
X-Gm-Gg: ASbGncteX0e/VVbc7czaV3FNFiy+/UweDMlqEykbsD+JL2zPbsoyuo8RdHn1LOyjWC9
 B/xV7OCwXOkrjEOW/LbFqYYuAFAowywCJPgVwPVooE7RwFwHmaC4IKXWpCZRTz1oVspbAdzA3H7
 JI1X2PizBD33P8AjhGwYNf4JKEMLL6UkVFNvZXpz9xQbp26EVoVdoC6zscQrnVcdXGHmQTv1uIx
 4VJtwQM9MD/945nUt7GRSe5+aqMQwlTJHfmD5OiQncy3gVvK8GieFI9CT2lNfOq4gNxBECqPC9V
 HPwKoyxvEu3qMAO8Mp9GRW5W/B1Al1BM5+WU15QQYVpBlTwm+2uISoK+wXSqkA2dXIwONlbNf/S
 p80/lCJn9S3r5
X-Google-Smtp-Source: AGHT+IF/Qu7i4/oxJS928om4YsKC7Dq4AjcW0AlWl4z1cz4AT1f8D6gkqjElUwSNxRKbbHGn340tRg==
X-Received: by 2002:a5d:64cf:0:b0:38f:2ffc:1e99 with SMTP id
 ffacd0b85a97d-390eca268f9mr11377734f8f.49.1741027149468; 
 Mon, 03 Mar 2025 10:39:09 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbf2edf84sm55232375e9.40.2025.03.03.10.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 10:39:09 -0800 (PST)
Message-ID: <81d01563-8a5d-4002-81e0-1b34108bfce3@linaro.org>
Date: Mon, 3 Mar 2025 19:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/24] target/m68k: Implement FPIAR
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20250224171444.440135-1-richard.henderson@linaro.org>
 <20250224171444.440135-25-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250224171444.440135-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Richard,

On 24/2/25 18:14, Richard Henderson wrote:
> So far, this is only read-as-written.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2497
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/cpu.h       |  1 +
>   target/m68k/cpu.c       | 23 ++++++++++++++++++++++-
>   target/m68k/helper.c    | 14 ++++++++------
>   target/m68k/translate.c |  3 ++-
>   4 files changed, 33 insertions(+), 8 deletions(-)


> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 6e3bb96762..bc787cbf05 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -45,8 +45,8 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
>           return gdb_get_reg32(mem_buf, env->fpcr);
>       case 9: /* fpstatus */
>           return gdb_get_reg32(mem_buf, env->fpsr);
> -    case 10: /* fpiar, not implemented */
> -        return gdb_get_reg32(mem_buf, 0);
> +    case 10: /* fpiar */
> +        return gdb_get_reg32(mem_buf, env->fpiar);
>       }
>       return 0;
>   }
> @@ -69,7 +69,8 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
>       case 9: /* fpstatus */
>           env->fpsr = ldl_be_p(mem_buf);
>           return 4;
> -    case 10: /* fpiar, not implemented */
> +    case 10: /* fpiar */
> +        env->fpiar = ldl_p(mem_buf);

Should we consider target endianness?

>           return 4;
>       }
>       return 0;
> @@ -91,8 +92,8 @@ static int m68k_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
>           return gdb_get_reg32(mem_buf, env->fpcr);
>       case 9: /* fpstatus */
>           return gdb_get_reg32(mem_buf, env->fpsr);
> -    case 10: /* fpiar, not implemented */
> -        return gdb_get_reg32(mem_buf, 0);
> +    case 10: /* fpiar */
> +        return gdb_get_reg32(mem_buf, env->fpiar);
>       }
>       return 0;
>   }
> @@ -114,7 +115,8 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
>       case 9: /* fpstatus */
>           env->fpsr = ldl_be_p(mem_buf);
>           return 4;
> -    case 10: /* fpiar, not implemented */
> +    case 10: /* fpiar */
> +        env->fpiar = ldl_p(mem_buf);

(ditto)

>           return 4;
>       }
>       return 0;


