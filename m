Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B6BD7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAOH-00061L-Tm; Mon, 02 Dec 2024 12:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAOC-0005tC-D5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:39:16 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAO9-0003ub-Qd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:39:15 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d888fc8300so17849606d6.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733161152; x=1733765952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=14lhA4IecdZToZLCZyVZO9FUMdsvdBZO5Q2nT6uYm6U=;
 b=vwme4qqD6gVat275/ohr7xTwIsT7iXIKGxdDS9OzDqDe86ze1YFZVGacGTLqefoPvr
 XcWjyODuVBCgbteI9U0FYKsiFAylivb9is1wxqOA+ZbfpoaoPC0/rcu27+kEHb0T+SYM
 MZyFRJl5kvuCRyb1VqjI1ckiniZOkDthky2FtZwycVca5eoFxRbO+pqdab1TgZdFAgPp
 9CR0I2s7VY7BjvMnYAdSrHNAOWM4ka0MHEk/dZHuuNtUrl9jqfKHETHf115jq9LsVkWU
 P4oQjp5kjTMPKFkutlGkfxWUnsh3cjE3Wyi7tqm0DF23Za2InazGTI6I1LLS6ZgJOY/Y
 4+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161152; x=1733765952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=14lhA4IecdZToZLCZyVZO9FUMdsvdBZO5Q2nT6uYm6U=;
 b=IQL6QojMCfKkIRy1SN5croYz3zOIDwO1fQ/I5b2AAhxqR0z6FiI99ErMG5wz1vFRwZ
 MnUMRmcsJx4MfBpfs5No5e7PWyM4M4amdTkA+VsOraBVyArYaoztvhMsd29fWQoOn/ZH
 2ffqNHuCjzdBN59FdhzuLR0HxoUMDiwOus84ypgjVV3sJHdx17OInhnHTF66dYRrHlb0
 l3TMeaUDqp1hUYk6PKO1G68oJLCpwQ3ZTIfteFDyOeODIzh/DOiuCEuG/rF6CRTkO6K/
 DeKdV86YofgrR2hRZbJhOpFzmExv6U7qytlT57YHn978963qqDM9+zMM5OBvtlvV62n1
 WbuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1M401B3x2tNMioDd62xbRDqvrg3eQB+lM3Mx/6vEB5W4K9MH4+HSv0ciKzhghI5uOL/zgDpVLXkZ1@nongnu.org
X-Gm-Message-State: AOJu0YxLTKr8w0drzcQgiqCZ4Y/8o0hPm4urBnq/ZCJehdUom641jAA1
 sEMFhtdHWAmti22iZmESXtY71XtfE0GZ4fy8TT7H/24Jk/4iyWAFz4DCHor8ovw=
X-Gm-Gg: ASbGnctZhMkjd1VWGfcVMzM27+cRMa4F4t3UqYmhhR4ExlVrTPGtdHSzFqwbuq0wGXG
 4cYHSy+6xUAifqVALUUhI2MCO0t9FlrC0a+MMoZIeFC+Ldvje22AwDIaxMGnAthJLMjR5hJgpqn
 EeYxNyugCBVT3LLnYnjnSzufyAfCmqnAL4ldDEO32Px7nBquNu+RPEuZ1NuV0URvnCt46mKcJz5
 mmSuhj+Tsx4J6+EY1rfJFLmml2/c8R8W7yWV7RoucsJQ+le3Yppkuu5FsGLZ4DU6qyhruk=
X-Google-Smtp-Source: AGHT+IE5H9HshsxsuLVezvmTV/cvxnKfVvZUOit4TDXKk7161MEBgGM7cf5SBxmhBG1WcBYKCGoFfw==
X-Received: by 2002:ad4:5ec9:0:b0:6d4:2646:108a with SMTP id
 6a1803df08f44-6d864d1ee4amr380222746d6.12.1733161151962; 
 Mon, 02 Dec 2024 09:39:11 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8891117c3sm37853716d6.45.2024.12.02.09.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:39:11 -0800 (PST)
Message-ID: <8c8e86c1-b04a-45e1-a40c-d46eb4d486b1@linaro.org>
Date: Mon, 2 Dec 2024 11:39:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 53/54] target/tricore: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-54-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-54-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf30.google.com
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
> Set the default NaN pattern explicitly for tricore.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/tricore/helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index 7014255f77c..e8b0ec51611 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -117,6 +117,8 @@ void fpu_set_state(CPUTriCoreState *env)
>       set_flush_to_zero(1, &env->fp_status);
>       set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
>       set_default_nan_mode(1, &env->fp_status);
> +    /* Default NaN pattern: sign bit clear, frac msb set */
> +    set_float_default_nan_pattern(0b01000000, &env->fp_status);
>   }
>   
>   uint32_t psw_read(CPUTriCoreState *env)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

