Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F50CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPhRZ-0006j1-LX; Wed, 20 May 2026 09:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPhRI-0006gr-08
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:58:27 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPhRE-0006jp-3b
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:58:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so4021072f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779285496; x=1779890296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6o2khAvW3lEZPhUnIImNulf53cY6xn5kqxuBlsdDrNQ=;
 b=KMNm6eJ5HTzwARwb5ny9u0q+g36HVsVXlXz98A3e/tnEwcNzh5KXBEl4pHUdehGSa/
 NxB2xWsaNzrt/nwDe83Yid6jC6V1etT7JoC/06u4Cnlx2BzIPqjWsqtyAd2giPIKqVj7
 O+WAKoxfbTHpQdzIJKO5+0gROLnMW684lK3oCqcT9XvOm1ESjt+ZOnDF7froS1XqSxsu
 QYufrYxDzFqhzbUzJHFSpun6fiXsf0whPmpLmYyF+fxmXv9OPDjca7pJQ98PTIgTpWuP
 PyeEFZ6HEALA7gQditnGZH+LraaaB4bYuWaySPbW8Nb5vqofaK7ooZ0BIiP7RkTdaKTo
 ajeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779285496; x=1779890296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6o2khAvW3lEZPhUnIImNulf53cY6xn5kqxuBlsdDrNQ=;
 b=lKjskQ6Xgeob6iz6hUU0BQBscG9Hsy6ZLWar1g18/7q+VFsImcCMLGFJcpIhV+PVvi
 wjZ5LYQ/C8S+ah4U1nq8qRhMwKL5n2Wg2Q5Ul8Hjgh15Meo3iM3gRLqrVfltqXgk/D1Q
 He1X4gMzRCOLcNwSFO3izmJ2E38f/Xu4DKXF8zC5qZwOoNrcIx063rhdJsUe3p3MILFw
 GoPmhByIe6Rf+lWm1DpQT0UOeI/4WPff5o3o6nDIpILKScdNHMfT6tm7eL/SkmgjCDZT
 TqyyeOEDDJH6mxKmWG1bQsOWKX2Xi3ytyK6a47vSQvVb3Wj+GTTNMhJUndGK8bDA/iid
 vkqg==
X-Gm-Message-State: AOJu0YzeqhSEc6BOUZ3kK6QJQ+/p8KIPr3ZfihBfaBIKcn58+awuR7ep
 kx6z7UUSrbnyozLamvAtHVt2rwwpGaLt/ijMtTTg1QsAA2bKALp2S9QGb6uoww7/E9IibVC7dfe
 JT3+BQDA=
X-Gm-Gg: Acq92OHO2WkU/BwCUg7H1qYgNQe2yrJgODTzYD8AAww2H6F0Ubc/daqYyf8tCH4Pxvc
 fZzQL36vxhN9kBGgD1zNy2+Ch33FnHV5C5gOYEZBG/Ggls/joo5nPmjgLvsb0GsYtlZIT0YKaXr
 y8xhcC5wOEQ2jZ45lxdJ+mlyD7vFJkcLYe6dupI1mY6Ctwu0dRlEy3K8O0L2+ytF6sOeWhkCviy
 RTYSqMIyvmFrs9SGA/8U4k06excYe0Oe3EpQwno2xi8z/14gWQFFYcaxh2dbAkVVr8HduKcs9T+
 ZTyXFewNysfFJj8WiewF+4Xp/E1LVLxCUkhdngDfo53NwjeiJf/bdw3z6mGPe18SxbE+VDITxwJ
 c0uko+H1zAUJFq5rPxra8whDDpoaTdul6Q2dRKgeBonlO6wnYTuhrkgMcLxOfU//G7W6kcakrXB
 ueVakrE8boWqsqxQ0JbfcVIAc1n8AT1w4PLnWu1MHosB9Joi6kCjXcLmI4Ap1pNyaq2Q==
X-Received: by 2002:a05:600c:33a3:b0:488:7d5b:125d with SMTP id
 5b1f17b1804b1-48fd63333f7mr256797105e9.7.1779285495708; 
 Wed, 20 May 2026 06:58:15 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9adc2209sm51070938f8f.0.2026.05.20.06.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 06:58:14 -0700 (PDT)
Message-ID: <95f50fd5-9463-4108-b7a8-5b21804cbb27@linaro.org>
Date: Wed, 20 May 2026 15:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 24/24] target/mips: add Octeon LA* atomic instructions
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-25-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 20/5/26 12:18, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> Implement the Octeon LA* read-modify-write atomic instruction family:
> LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.
> 
> These operations are architecturally distinct from SAA/SAAD and are used
> by existing Octeon user-mode code for atomic counters, bit operations,
> and exchange-style updates.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      | 17 +++++++
>   target/mips/tcg/octeon_translate.c | 75 ++++++++++++++++++++++++++++++
>   2 files changed, 92 insertions(+)


> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index 684236b1a87..eff46c30a09 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -177,6 +177,68 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
>   TRANS(SAA,  trans_saa, MO_32);
>   TRANS(SAAD, trans_saa, MO_64);
>   
> +static bool trans_la_fetch_add(DisasContext *ctx, int base, int add_reg,
> +                               int rd, int64_t imm, MemOp mop)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +    TCGv_i64 value = tcg_temp_new_i64();
> +    TCGv_i64 old = tcg_temp_new_i64();
> +    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
> +
> +    gen_base_offset_addr(ctx, addr, base, 0);
> +
> +    if (add_reg >= 0) {
> +        gen_load_gpr(value, add_reg);
> +    } else {
> +        tcg_gen_movi_i64(value, imm);
> +    }
> +
> +    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
> +    gen_store_gpr(old, rd);
> +    return true;
> +}
> +
> +static bool trans_la_xchg(DisasContext *ctx, int base, int add_reg, int rd,
> +                          int64_t imm, MemOp mop)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +    TCGv_i64 value = tcg_temp_new_i64();
> +    TCGv_i64 old = tcg_temp_new_i64();
> +    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
> +
> +    gen_base_offset_addr(ctx, addr, base, 0);
> +
> +    if (add_reg >= 0) {
> +        gen_load_gpr(value, add_reg);
> +    } else {
> +        tcg_gen_movi_i64(value, imm);
> +    }
> +
> +    tcg_gen_atomic_xchg_i64(old, addr, value, ctx->mem_idx, amo);
> +    gen_store_gpr(old, rd);
> +    return true;
> +}
> +
> +static bool do_la_imm_add(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
> +{
> +    return trans_la_fetch_add(ctx, a->base, -1, a->rd, imm, mop);
> +}
> +
> +static bool do_la_reg_add(DisasContext *ctx, arg_laa *a, MemOp mop)
> +{
> +    return trans_la_fetch_add(ctx, a->base, a->add, a->rd, 0, mop);
> +}
> +
> +static bool do_la_imm_xchg(DisasContext *ctx, arg_la *a, int64_t imm, MemOp mop)
> +{
> +    return trans_la_xchg(ctx, a->base, -1, a->rd, imm, mop);
> +}
> +
> +static bool do_la_reg_xchg(DisasContext *ctx, arg_laa *a, MemOp mop)
> +{
> +    return trans_la_xchg(ctx, a->base, a->add, a->rd, 0, mop);
> +}
> +
>   static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
>   {
>       TCGv_i64 addr = tcg_temp_new_i64();
> @@ -418,3 +480,16 @@ static bool trans_QMACS(DisasContext *ctx, arg_QMACS *a)
>       tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
>       return true;
>   }
> +
> +TRANS(LAI,  do_la_imm_add, 1, MO_SL);
> +TRANS(LAID, do_la_imm_add, 1, MO_UQ);
> +TRANS(LAD,  do_la_imm_add, -1, MO_SL);
> +TRANS(LADD, do_la_imm_add, -1, MO_UQ);
> +TRANS(LAA,  do_la_reg_add, MO_SL);
> +TRANS(LAAD, do_la_reg_add, MO_UQ);
> +TRANS(LAS,  do_la_imm_xchg, -1, MO_SL);
> +TRANS(LASD, do_la_imm_xchg, -1, MO_UQ);
> +TRANS(LAC,  do_la_imm_xchg, 0, MO_SL);
> +TRANS(LACD, do_la_imm_xchg, 0, MO_UQ);
> +TRANS(LAW,  do_la_reg_xchg, MO_SL);
> +TRANS(LAWD, do_la_reg_xchg, MO_UQ);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Alternatively passing the atomic function by argument to TRANS():

-- >8 --
+typedef void AtomicThreeOpFn(TCGv_i64, TCGv_va, TCGv_i64, TCGArg, MemOp);
+
+static bool do_atomic_ld(DisasContext *ctx, AtomicThreeOpFn *atomic_fn,
+                         int base, int add_reg, int rd, int64_t imm, 
MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (add_reg >= 0) {
+        gen_load_gpr(value, add_reg);
+    } else {
+        tcg_gen_movi_i64(value, imm);
+    }
+
+    atomic_fn(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, rd);
+    return true;
+}
+
+static bool do_atomic_la(DisasContext *ctx, arg_la *a, AtomicThreeOpFn *fn,
+                         int64_t imm, MemOp mop)
+{
+    return do_atomic_ld(ctx, fn, a->base, -1, a->rd, imm, mop);
+}
+
+static bool do_atomic_laa(DisasContext *ctx, arg_laa *a, 
AtomicThreeOpFn *fn,
+                          int64_t imm, MemOp mop)
+{
+    return do_atomic_ld(ctx, fn, a->base, a->add, a->rd, imm, mop);
+}
+
+TRANS(LAI,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_SL);
+TRANS(LAID, do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_UQ);
+TRANS(LAD,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_SL);
+TRANS(LADD, do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_UQ);
+TRANS(LAA,  do_atomic_laa, tcg_gen_atomic_fetch_add_i64,  0, MO_SL);
+TRANS(LAAD, do_atomic_laa, tcg_gen_atomic_fetch_add_i64,  0, MO_UQ);
+TRANS(LAS,  do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_SL);
+TRANS(LASD, do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_UQ);
+TRANS(LAC,  do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_SL);
+TRANS(LACD, do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_UQ);
+TRANS(LAW,  do_atomic_laa, tcg_gen_atomic_xchg_i64,       0, MO_SL);
+TRANS(LAWD, do_atomic_laa, tcg_gen_atomic_xchg_i64,       0, MO_UQ);
---

