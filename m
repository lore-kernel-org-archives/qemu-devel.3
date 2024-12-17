Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACE4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeSu-000703-2x; Tue, 17 Dec 2024 15:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeSr-0006xM-Jy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:46:45 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeSp-0004a2-Qv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:46:45 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2164b1f05caso53511165ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468402; x=1735073202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=36GKyGBdY5+6QyQM1TRKaV59ZJc6zhvnvauVlnYaxiE=;
 b=F9S41YUfq8brgEs+Aer9kUZUCTDdYlP+HkXFNMLpK9zbax03UMvHmUzmDZR/rIs5Ob
 on4UV5JFTuoGf9/X27q86FobImNheZ/SXhmrKA6sbC9vq5s5XuR1dpG0e94SV7l3kAAr
 gGEPOqmJ73XCOB7eS81W0pppAeSkNHtI7586NKwSP55CHktjCVwOdmZdMg6znBiVYrnX
 xEXhV2dsh6iQGbspBxG3iCJeMvACVFySqZfHhjV2j09n1SDYiXN54sB70yaIfrd1tqrl
 YtgdV+IQN6pnFQdGpuynkJk68M8fYUueTO76C51tHCIloN+EsURMAj2fKfgc8WXl4GTQ
 Yz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468402; x=1735073202;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=36GKyGBdY5+6QyQM1TRKaV59ZJc6zhvnvauVlnYaxiE=;
 b=rnPOGYdOjssKWoPgBv2A8KQDBPoqRLjh0XYY0iGvDqSKx7NVzFNdv8l2ZnqYq6nE8y
 yrd3nLQeOFpNNTp0YXndHVl7DIyn7JtW6EzcdNRsG7QODXSQwl9kDgWAKChrRnNyeAwG
 VPsNCGkTRSyulPLKh3uBqchCorS1c+fJTIQIv8cqp7LiTqQcQMgoTsBPZ5nV7tUJc9uE
 JrionivHOVdN55+lU6DcQHO9T3XcRRgH3i3Au1WHFc9fRCSOZce9RrycRRQnqA+s+wm8
 yP1eQj8jcAgRgNcyUhVgLHWrTzENnrcA78RFEDQPOIuAanFs9/bY6j8p6esmi6niZNu+
 nzQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtbYPPf6B6xGUp3B7ruLP+cdQhXuMwgFRbLor25D77y+T6mhNqXyntWO25KmjQwuLqX1StxkVRAxbg@nongnu.org
X-Gm-Message-State: AOJu0YwK5E73KhkKTR5h+5uB/c8MOb+ekhTblSxzG6zHab2VfvdV0NyU
 kPbw0kWua7SoHYBO+pmFLWVIwnef9yQHOv80tTLPTyVVRdem1SCtTSJyMPELnFM=
X-Gm-Gg: ASbGncsHYL8le+/bHYTIazlROtCYZw941j9T51eLBfQjcJVY0sEQoRVaPO2vHoq2TwD
 WvAMC62WC+j3gmxVmrjOEYChFStXcgRpg7VFG8qk6D1dbhQ57RAwP2UnX5F6xaOj3XCbyB1Sx4v
 2co1Vhu243jrSku1Z2D5kFz5y/YcLMfq1gb1cccRj4pRp1vLmqfOjItsvMTTfM4alBcA9MUWvSE
 sFcEpgRNY5MjIbvLI9XZm6OV5h0Y/h2QKm6CBbSdWkNsrBubrI0/ufyk+X/SDX7CfQNqg==
X-Google-Smtp-Source: AGHT+IHBHsFBcZJzSXMcWSA8+UrncCchyHbIlWft7EfeUbIUP/LDmv+oJdVp5lIF1gYLTfAw/nJ7Pw==
X-Received: by 2002:a17:902:eccd:b0:215:7b06:90ca with SMTP id
 d9443c01a7336-218d70d9630mr3484685ad.17.1734468401785; 
 Tue, 17 Dec 2024 12:46:41 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e5011bsm63618455ad.152.2024.12.17.12.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:46:41 -0800 (PST)
Message-ID: <c0ec0837-4f74-4d58-8b12-8c4264cce3a4@linaro.org>
Date: Tue, 17 Dec 2024 12:46:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/46] tcg/optimize: Remove [zsa]_mask from OptContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-45-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> All mask setting is now done with parameters via fold_masks_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 94e942e1cf..eb6e93809e 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -64,9 +64,6 @@ typedef struct OptContext {
>       QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
>   
>       /* In flight values from optimization. */
> -    uint64_t a_mask;  /* mask bit is 0 iff value identical to first input */
> -    uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
> -    uint64_t s_mask;  /* mask of clrsb(value) bits */
>       TCGType type;
>   } OptContext;
>   
> @@ -987,14 +984,6 @@ static bool finish_folding(OptContext *ctx, TCGOp *op)
>       for (i = 0; i < nb_oargs; i++) {
>           TCGTemp *ts = arg_temp(op->args[i]);
>           reset_ts(ctx, ts);
> -        /*
> -         * Save the corresponding known-zero/sign bits mask for the
> -         * first output argument (only one supported so far).
> -         */
> -        if (i == 0) {
> -            ts_info(ts)->z_mask = ctx->z_mask;
> -            ts_info(ts)->s_mask = ctx->s_mask;
> -        }
>       }
>       return true;
>   }
> @@ -2867,11 +2856,6 @@ void tcg_optimize(TCGContext *s)
>               ctx.type = TCG_TYPE_I32;
>           }
>   
> -        /* Assume all bits affected, no bits known zero, no sign reps. */
> -        ctx.a_mask = -1;
> -        ctx.z_mask = -1;
> -        ctx.s_mask = 0;
> -
>           /*
>            * Process each opcode.
>            * Sorted alphabetically by opcode as much as possible.

Great!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


