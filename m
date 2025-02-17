Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94406C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjw5E-0002Gl-28; Mon, 17 Feb 2025 03:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw4u-0002CY-EC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:02:08 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw4s-0007va-I4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:02:08 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2212a930001so18899495ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779324; x=1740384124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/+NQ5MUhbCkdNGlkbiq7WpuJMGqvYJOu2QLbCK68wp8=;
 b=ta8+pnDtkXGuhIhjL1T3uaMhlkvAZy7Fyx/UXrpVSI5mZ8KA8c6gwbGRAoSyheYY0s
 vJxfPboSG0hp2bjzTYYM2o/wgQZ2Q8e7DPCl+OLkzzKI38eVEURN34E/TvIg8v0dKJE6
 W1vhI46bMfMweqLDROwRWLKPRw6pwpmC6ePu9ogA1rwDuSOODJD+brvvFdWtKw2KckDE
 r6YzD1q7L0pc7IBncc1S3IY4kab1Elwe+JMEmWO1S+Mw1iimOSgZTbGoEl6uwBQ5UprB
 8IdqEmweUSLY/OBRIaWG3moXOhLsKKljxnwJT7JSi3arXbFm7nc+4Xj41l4YCtYcv4h4
 hzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779324; x=1740384124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+NQ5MUhbCkdNGlkbiq7WpuJMGqvYJOu2QLbCK68wp8=;
 b=Y/CVBxCZ/L4mxnL6iDc5P2np8Xx4l6inpSqP9jTcB8KpZtRbjtLWxP4Zqornv/bo9m
 IZENoLFS1eIZwzVWv1KYQwVWIx3qbKhwxGLfPRAmNimWv3TxdL8mIcQp/a8S+Dpmd0Vx
 CVNjFrGfUQaAL97CxAVMW4eL4d34rYHJ0mCRu2zTr5SAF6FQnt9mXHNOVjq9wpyxunLO
 hRzfi4r/cffs2rVUJNoSO0YrRGAP8dAqz3pWaPYNjDMJwhgEPZqRcEm5Im8cOaxh5byK
 UQr3jKqkWog/G+lxDRXu7Fz9fsJuv9ZOq7+4ZzfaWaXxEEMlJzJThe3YnM3+B4myUk3+
 LSQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYNvLz+Jz9CnlcFVy1lcZdSIxWq84FxmxqlPLpxY9aOn1aOYfSE7sAe7/zGlG+iZwlvXzwQDYDvW+s@nongnu.org
X-Gm-Message-State: AOJu0YyDJhqslBy2ZzjZr00ikmGfL7nx/jtqwzlz0aEaQfyitNvox89O
 NOoBjZ29EVWZEwbsOqa4rkK2j0WkYfDKnXLniba0rS8J+XOC/rDYF1ptisn8shY=
X-Gm-Gg: ASbGncsxeHAXNhuJJP3kXkWXzh2m85HqPE8JO2icbNF3IotCY1+WKAP3xKYLqeAROCr
 Wup2IOxGbyOQd6ABDqUcNg7kIVPI74fezZ9L3JrCb3rQoQKdfSqjaVrDDzfChdGkJKu9U2DRknx
 AaYc7Af7mkR+UFNJE2yc8Gt2NtO/VC35V9n12Q02EYM0bEEyyRo/2kbC4FobDzNt1MFaGDUiXxl
 zs+9q8WLFW8775iy5tDW8gz863HO1/XYgKs8rtDAXF23TjVF5owqvKT5YZAx3uE9f1q03h9B0iw
 tdPmqDRvb+RomWP8YZJeADDfNqG6Ow==
X-Google-Smtp-Source: AGHT+IF+QMM+xCG3dEhbRCLvc3QNzOIZiMb1dgrhQGCjPhNXKrlb8p1mXuZWegRz7n8ZGooudaF5gQ==
X-Received: by 2002:a17:903:2351:b0:215:a964:e680 with SMTP id
 d9443c01a7336-2210404fc53mr131556535ad.25.1739779324628; 
 Mon, 17 Feb 2025 00:02:04 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm66120245ad.28.2025.02.17.00.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:02:04 -0800 (PST)
Message-ID: <098ef8b4-6808-482f-b13e-2f8faef56bd3@linaro.org>
Date: Mon, 17 Feb 2025 09:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 066/162] tcg: Merge INDEX_op_ctpop_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-67-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-67-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           |  9 +++------
>   tcg/tcg-op.c             | 21 ++++++++++-----------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  6 ++----
>   docs/devel/tcg-ops.rst   |  6 +++---
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 22 insertions(+), 31 deletions(-)


> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index db0e79059b..0eeec47b83 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -765,8 +765,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>           tcg_temp_free_i64(t2);
>           return;
>       }
> -    if (tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0) ||
> -        tcg_op_supported(INDEX_op_ctpop_i64, TCG_TYPE_I64, 0)) {
> +    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
>           t = tcg_temp_ebb_new_i32();
>           tcg_gen_subi_i32(t, arg1, 1);
>           tcg_gen_andc_i32(t, t, arg1);
> @@ -791,7 +790,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
>   {
>       if (arg2 == 32
>           && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
> -        && tcg_op_supported(INDEX_op_ctpop_i32, TCG_TYPE_I32, 0)) {
> +        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {

s/TCG_TYPE_REG/TCG_TYPE_I32/ ?

>           /* This equivalence has the advantage of not requiring a fixup.  */
>           TCGv_i32 t = tcg_temp_ebb_new_i32();
>           tcg_gen_subi_i32(t, arg1, 1);


