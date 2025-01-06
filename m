Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F514E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUv7a-0004Jz-IF; Mon, 06 Jan 2025 16:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUv7Z-0004Jp-Aw
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:58:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUv7X-0006UG-Gz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:58:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso141350025e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736200726; x=1736805526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oanee+OcTgnhIcgrNBnHFmw6/6q8/gBTJrc0NyRKLF8=;
 b=suqIMbndJ6M7qWhsD3JQafiACMnRoTsiKQf8mUICC1gdeMSeh4B3TB3Epc++ikMFn7
 /J9UChZMNFEuwJYaZpw3P8yDUFscn/rpY1bR0fDduJw4I4ZLIWPr0TOYIe7rVh9KQzeb
 OUuyktNyYIrqjDPUWgrFJhL5SqM+Y2MXjC/k0BggGyWqesRuH3PBXiwdcszHx/p+l57g
 Qp5pc0IbOWEAO15dynhnzllcE8FVVlaUAxtMc7IimXvne7bKr6aQz2jbECviQ6d9hp7I
 mhC4F2W+jJNOB2xOulIH7gkOcOPo4HGX3BNIb3D/nRlspJnKUaPF4wkruGPE3yADvH3u
 79/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736200726; x=1736805526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oanee+OcTgnhIcgrNBnHFmw6/6q8/gBTJrc0NyRKLF8=;
 b=uWtFVDY7nZ3QRCUGwL8sW2zysSxFX2OA/l452owmbp6ZkJyQ3wSa17l7AufsSpswbX
 VgLcfGpsWVax9hVQMCIVTc0IV5V+/NM3zIZ8gSCIgImA0zHHzupJtLxmfyCeDtM73CRL
 DYZQnhrd70O65/X2K9A6hltsMSAUdLpnx6MFJ2Csw7OuJmlZ3AEn1zjM74uh+Keo8bHR
 zVfutnsuh/6CYaUJbcbLvR7MB8MLPhI8zEXWkcTR0OreryNc8heYIaQarPaviDl5+7fw
 6rYcP/h6T4603jR8XWP3Qc7VUBFPK0Eb3KCbCKsmVQJ5PFoVPfaoFTzVlzuA/rBrDSfE
 U/Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ve+ILK7snJZ2QgFQ6JHixgZfqLv8B3nkg6aCCwWeFkq4thrKsNYCkX0lmIvOFNSsZvrAcHroqkuK@nongnu.org
X-Gm-Message-State: AOJu0Yx4IG27auNEUp5ZkXoz2cF7OCYnXb+mfQ4CZivTUXCinSF51/bh
 tyRpO/jN3h8Z7egha9/0XBj/SokQwwx3/PgwnfhP3bgxPSpZRTXckTbQfx2ynIE8oEoviBNvTbs
 JnQw=
X-Gm-Gg: ASbGncsWduKBTL45iki2lTBZUn3eRr2lyjuikUbQn5y1IgBp+dTGjaTOS3krpLRkIx6
 z+77ViuFD934C16hh5m2mF2UPtbGOlUmepTUvsMUhZ2CjKLdRNhrrDM4TR3fdpREo4fTEM13DBX
 tR6jdkKWf7mtzQCOeTX+rgZsRNbgglbYXNkAoxTEj/Fr7VRThZidR5JhWJupVj23Jix74hEl2nA
 0bGF0lLZHp0kQVY5kypPtjx99t4Sy8VdABiH3FwxtYv6ipGfNs6sipl/jPCbUJuD+lsXH9+sWdt
 3Qrs8QBSYDpLGfEvID2AR+NU
X-Google-Smtp-Source: AGHT+IHHXfa22lPW/pkYUuoMwelaAjxHc4Xe6GkV+YlYeHGozR/YP5nxMNAxBER6Pew479Qquh1viA==
X-Received: by 2002:a05:600c:1c1a:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-43668646aebmr560338445e9.15.1736200725780; 
 Mon, 06 Jan 2025 13:58:45 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c639sm573853285e9.31.2025.01.06.13.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:58:44 -0800 (PST)
Message-ID: <ecf37359-62d0-483d-a9b2-08bd32489a16@linaro.org>
Date: Mon, 6 Jan 2025 22:58:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/73] tcg: Merge TCG_TARGET_HAS_{muls2, mulu2, mulsh,
 muluh}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  16 ++---
>   tcg/aarch64/tcg-target-has.h     |  12 ++--
>   tcg/arm/tcg-target-has.h         |   8 +--
>   tcg/i386/tcg-target-has.h        |  12 ++--
>   tcg/loongarch64/tcg-target-has.h |  12 ++--
>   tcg/mips/tcg-target-has.h        |  12 ++--
>   tcg/ppc/tcg-target-has.h         |  12 ++--
>   tcg/riscv/tcg-target-has.h       |  12 ++--
>   tcg/s390x/tcg-target-has.h       |  12 ++--
>   tcg/sparc64/tcg-target-has.h     |  12 ++--
>   tcg/tcg-has.h                    |   4 --
>   tcg/tci/tcg-target-has.h         |  14 ++--
>   tcg/tcg-op.c                     | 115 +++++++++++++++++--------------
>   tcg/tcg.c                        |  24 +++----
>   tcg/tci.c                        |   8 ---
>   15 files changed, 125 insertions(+), 160 deletions(-)


> @@ -3099,58 +3099,73 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>   
>   void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
> -    if (TCG_TARGET_HAS_mulu2_i64) {
> -        tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
> -    } else if (TCG_TARGET_HAS_muluh_i64) {
> -        TCGv_i64 t = tcg_temp_ebb_new_i64();
> -        tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
> -        tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
> -        tcg_gen_mov_i64(rl, t);
> -        tcg_temp_free_i64(t);
> -    } else {
> -        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> -        tcg_gen_mul_i64(t0, arg1, arg2);
> -        gen_helper_muluh_i64(rh, arg1, arg2);
> -        tcg_gen_mov_i64(rl, t0);
> -        tcg_temp_free_i64(t0);
> +    TCGv_i64 t;
> +
> +    if (TCG_TARGET_REG_BITS == 64) {
> +        if (TCG_TARGET_HAS_mulu2(TCG_TYPE_I64)) {
> +            tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
> +            return;
> +        }
> +        if (TCG_TARGET_HAS_muluh(TCG_TYPE_I64)) {
> +            t = tcg_temp_ebb_new_i64();
> +            tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
> +            tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
> +            tcg_gen_mov_i64(rl, t);
> +            tcg_temp_free_i64(t);
> +            return;
> +        }
>       }

Should we mention the new logic fallback in commit description?

> +    t = tcg_temp_ebb_new_i64();
> +    tcg_gen_mul_i64(t, arg1, arg2);
> +    gen_helper_muluh_i64(rh, arg1, arg2);
> +    tcg_gen_mov_i64(rl, t);
> +    tcg_temp_free_i64(t);
>   }
>   
>   void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
> -    if (TCG_TARGET_HAS_muls2_i64) {
> -        tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
> -    } else if (TCG_TARGET_HAS_mulsh_i64) {
> -        TCGv_i64 t = tcg_temp_ebb_new_i64();
> -        tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
> -        tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
> -        tcg_gen_mov_i64(rl, t);
> -        tcg_temp_free_i64(t);
> -    } else if (TCG_TARGET_HAS_mulu2_i64 || TCG_TARGET_HAS_muluh_i64) {
> -        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> -        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
> -        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
> -        TCGv_i64 t3 = tcg_temp_ebb_new_i64();
> -        tcg_gen_mulu2_i64(t0, t1, arg1, arg2);
> -        /* Adjust for negative inputs.  */
> -        tcg_gen_sari_i64(t2, arg1, 63);
> -        tcg_gen_sari_i64(t3, arg2, 63);
> -        tcg_gen_and_i64(t2, t2, arg2);
> -        tcg_gen_and_i64(t3, t3, arg1);
> -        tcg_gen_sub_i64(rh, t1, t2);
> -        tcg_gen_sub_i64(rh, rh, t3);
> -        tcg_gen_mov_i64(rl, t0);
> -        tcg_temp_free_i64(t0);
> -        tcg_temp_free_i64(t1);
> -        tcg_temp_free_i64(t2);
> -        tcg_temp_free_i64(t3);
> -    } else {
> -        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> -        tcg_gen_mul_i64(t0, arg1, arg2);
> -        gen_helper_mulsh_i64(rh, arg1, arg2);
> -        tcg_gen_mov_i64(rl, t0);
> -        tcg_temp_free_i64(t0);
> +    TCGv_i64 t;
> +
> +    if (TCG_TARGET_REG_BITS == 64) {
> +        if (TCG_TARGET_HAS_muls2(TCG_TYPE_I64)) {
> +            tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
> +            return;
> +        }
> +        if (TCG_TARGET_HAS_mulsh(TCG_TYPE_I64)) {
> +            t = tcg_temp_ebb_new_i64();
> +            tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
> +            tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
> +            tcg_gen_mov_i64(rl, t);
> +            tcg_temp_free_i64(t);
> +            return;
> +        }
> +        if (TCG_TARGET_HAS_mulu2(TCG_TYPE_I64) ||
> +            TCG_TARGET_HAS_muluh(TCG_TYPE_I64)) {
> +            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +            TCGv_i64 t1 = tcg_temp_ebb_new_i64();
> +            TCGv_i64 t2 = tcg_temp_ebb_new_i64();
> +            TCGv_i64 t3 = tcg_temp_ebb_new_i64();
> +            tcg_gen_mulu2_i64(t0, t1, arg1, arg2);
> +            /* Adjust for negative inputs.  */
> +            tcg_gen_sari_i64(t2, arg1, 63);
> +            tcg_gen_sari_i64(t3, arg2, 63);
> +            tcg_gen_and_i64(t2, t2, arg2);
> +            tcg_gen_and_i64(t3, t3, arg1);
> +            tcg_gen_sub_i64(rh, t1, t2);
> +            tcg_gen_sub_i64(rh, rh, t3);
> +            tcg_gen_mov_i64(rl, t0);
> +            tcg_temp_free_i64(t0);
> +            tcg_temp_free_i64(t1);
> +            tcg_temp_free_i64(t2);
> +            tcg_temp_free_i64(t3);
> +            return;
> +        }
>       }

Ditto, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    t = tcg_temp_ebb_new_i64();
> +    tcg_gen_mul_i64(t, arg1, arg2);
> +    gen_helper_mulsh_i64(rh, arg1, arg2);
> +    tcg_gen_mov_i64(rl, t);
> +    tcg_temp_free_i64(t);
>   }

