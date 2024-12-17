Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ABAE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeQf-0003PJ-B1; Tue, 17 Dec 2024 15:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeQe-0003OS-1x
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:44:28 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeQc-00045J-Bc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:44:27 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2165cb60719so46535025ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468265; x=1735073065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1WAMynQiXEBUwINbKBwk7K34whFxzXvtlFtlSJJXars=;
 b=vC/pusvMRnN+NQD5Wvz/AFgXfmz0qp9L60/XWJ5ZdWP3GDu9DHief97iMBF3/SU1fI
 Id7XPVB+WbW9Tf5YlS9wcI3ctC5Tsp5h8RWRVlesFLSMD1pD89lIb80ar3Z9O5Iv1MrO
 uO/fpe7ibKtoJXC1BmCG28UZKyYsJFagg6hP8ch/Um7iG2G1k5VPLcvWn/ZF1cMcpemZ
 ZKNsAbbWqKTktk+tushZL4N1ybBUo5BO09rVgBiDSWG2UNE+RxuEM4+hC2gPtfc/slZf
 QH1Xksj2KY+0jYjU1KfEi8Pu6scKSRXkhKzddCwYHzgsTWIPxnqqgWe2+Yj3DEdB8bBS
 /JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468265; x=1735073065;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1WAMynQiXEBUwINbKBwk7K34whFxzXvtlFtlSJJXars=;
 b=WamHTD7d7nxfDPtb80ECn+xnVbuy8A6vre0jzokhCZJwDXqVa4Ktm36NlcdfHOx2Bm
 ZOiut/yCMATetEJOxe4sipAHeWTszC4cxZhJxxArbs+8vWS+pPW2SrFEf7CORTUhXy/q
 F6CuNK4U8gUZJ8P9kEjNgdGWv1+C8/P7MyJXybR20u/SvfZP7EjdyzUkVUw0NhuHeY3i
 D5RCmoSYVAxgat96g/b2HY2C4PpEDMlyfiCjaJ7eJAHwSjro9pJAE8FMzefayE3hNhkj
 4gUNIK8MjShe2AnB1k1dfcbCio1IrZpefliWEWMA9FFH///9d5choIZArbR8Y/wYwd9k
 y/PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdsnFHPws1+SHCFiJD/fcfWJcnHF5tpg6h10W2bZ3pB3kEjmS/b4gDDAFiLibqrXi7DQRbRQvfw0Z3@nongnu.org
X-Gm-Message-State: AOJu0Yyy7h9Bmqed6rQuYEJ6Suvb12ZGD+bJWKKOG9c6vGKKnyGpH/Ep
 RJBo8O/w22cWfWJzS2Am41VeT6wfCrIRTR1h6iPV5mLY7wj64LF8ILUsW58cMTg=
X-Gm-Gg: ASbGncuzMD0fCObuIr6mjn/CPM4yzPc7hAob5uEKn/vVPwzGll6gp1uCPVoPfVBMn1D
 SLvoYqUXY6rO1NWUxohQSwr8BFf1hfmqpnrDqhIu64ZURZ523v65fRLs6DbrvUtja/Chgd5NqgI
 LJtbk50ghJdNa8VrJSVP25qSlO17gENOPmZU5PB0IabzZnmmjswwDAbBGcJrttQclw3qrytFiWJ
 LTME7WfzSFTuc1H/+htMFPmVEYP6esLd7PV0yYWB6wa5TjfkX88Oy/ciHGnPYcsN8uinw==
X-Google-Smtp-Source: AGHT+IHB77rws/dCYZq/SqjwPsg4wmCSSV64Sq74WA/7kYhMa0NsSI992ujaekNolRwmFLmgkBLZNw==
X-Received: by 2002:a17:902:e5ca:b0:215:4394:40b5 with SMTP id
 d9443c01a7336-218d724abe7mr2934285ad.43.1734468264873; 
 Tue, 17 Dec 2024 12:44:24 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e64161sm63544345ad.221.2024.12.17.12.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:44:24 -0800 (PST)
Message-ID: <ba202b0f-daf1-4b72-8242-0e88c873a3c3@linaro.org>
Date: Tue, 17 Dec 2024 12:44:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/46] tcg/optimize: Use fold_masks_zs in fold_tcg_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-40-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 6412d5df37..4cccb3b0cf 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2636,33 +2636,35 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t z_mask = -1, s_mask;
> +
>       /* We can't do any folding with a load, but we can record bits. */
>       switch (op->opc) {
>       CASE_OP_32_64(ld8s):
> -        ctx->s_mask = MAKE_64BIT_MASK(8, 56);
> +        s_mask = MAKE_64BIT_MASK(8, 56);
>           break;
>       CASE_OP_32_64(ld8u):
> -        ctx->z_mask = MAKE_64BIT_MASK(0, 8);
> -        ctx->s_mask = MAKE_64BIT_MASK(9, 55);
> +        z_mask = MAKE_64BIT_MASK(0, 8);
> +        s_mask = MAKE_64BIT_MASK(9, 55);
>           break;
>       CASE_OP_32_64(ld16s):
> -        ctx->s_mask = MAKE_64BIT_MASK(16, 48);
> +        s_mask = MAKE_64BIT_MASK(16, 48);
>           break;
>       CASE_OP_32_64(ld16u):
> -        ctx->z_mask = MAKE_64BIT_MASK(0, 16);
> -        ctx->s_mask = MAKE_64BIT_MASK(17, 47);
> +        z_mask = MAKE_64BIT_MASK(0, 16);
> +        s_mask = MAKE_64BIT_MASK(17, 47);
>           break;
>       case INDEX_op_ld32s_i64:
> -        ctx->s_mask = MAKE_64BIT_MASK(32, 32);
> +        s_mask = MAKE_64BIT_MASK(32, 32);
>           break;
>       case INDEX_op_ld32u_i64:
> -        ctx->z_mask = MAKE_64BIT_MASK(0, 32);
> -        ctx->s_mask = MAKE_64BIT_MASK(33, 31);
> +        z_mask = MAKE_64BIT_MASK(0, 32);
> +        s_mask = MAKE_64BIT_MASK(33, 31);
>           break;
>       default:
>           g_assert_not_reached();
>       }
> -    return false;
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
>   }
>   
>   static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


