Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B23EF9002
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxowO-00016e-Fp; Wed, 04 Mar 2026 11:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxowI-00013m-JU
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:19:12 -0500
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxowG-0002m6-Ig
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:19:10 -0500
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1270adc5121so8840769c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772641147; x=1773245947; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CQs5VidEEHQNfPFJ09QrLg7dX2wXfjhQsVlvbGH650k=;
 b=dbWhMA/0R3m+hmf1T6ykigX5IKvWPR5O5QWYJSkdRSu2lwMc3Cv3Qa0obp9i6O7THQ
 6h5mBCq4j3GNaTnm5gbBsjY+PZsSSS9OY5ROx8pvtx5+DYUed+ALNCmXOxKRziQQjazQ
 u2LozDTOBn1nJqyNkObg46+n0wweC03OBztYYC8c54OMAR8EftXnVAQkDKqPMMLLDC8f
 O/EIFpKO9jWfSXnelZmH9vaIRFPMcJkUDfe0zOI4oLbqYDWhUXs+3t7jX/x84nAdeCwB
 A63QaMZBE5UFWTGkNgPr8KUX6wwH2dYDSCbq6KTdHl/jBWzSscnbifdIQiSLU6JbSUGz
 kSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641147; x=1773245947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQs5VidEEHQNfPFJ09QrLg7dX2wXfjhQsVlvbGH650k=;
 b=kicyBAZAJvBF2UkQhrdGxuFIv2v1dDgBerKTWIb1NU6FeTNuJiTGjyKnIRMMhAr72b
 +LSR2+YT/s5EAWhCIfUoxk3qPv0fLrpP1wAmRTbnrz90t6/p9PB87hXJ4NONH1sGkMdQ
 5hociUCbDw/kHMtx3cxnEk3VUzqoQA78Dinxrga8rc8wdgtsYrHE3miWW89t9vTAbfOX
 W5A0DPNsZ/VJ4ZaUlPwf5Ayz3XrRKKicPCqGgGoM2ycmc7eHcGtHvh/au815O5MEpgw1
 r0h4SjP57zzzaBb+A2AXiBt76b6iEZEMA1ffrYjum9a7HDmVMg1e3asjzX0ROro15kbT
 1x5A==
X-Gm-Message-State: AOJu0YwpOTKEDq9tV5A7gF1h/FcuHEvQUUjgNJE4QnGjiNIEsalGTnXc
 97ebS520lz6hM2h+09+43kuR2db62vV8uu6j7YJGLtPn06ZgMwK8nim7
X-Gm-Gg: ATEYQzy81fPilp5ZFB6+iXkFm9QSN7EN6TZ/LYN9gwgW+L2Diyt0GZKWoY/nfMucyry
 EWUZQ0ytTtW8A8vJDmbS8NOvs3DnXDIFvWVr9kfRLGuaFEDgQMhWtt7l+u682gsmNUVeFXNpFPr
 QRPAHJ6lt7Fi5sze1nFErUz4HfYP+YwCfQbuxtiokcJRdoQM5WHb/8AJ5W72gT2v05Qndl65PEZ
 PezgOTBLSMu8S7pXniwlLsPLsZowCxQLKQV0H6O9zm95IYVJ4yGWUtGHZe+GOhr+tVgvKMRzzEb
 rvoTgbbIwvYzHvlOic02/JbK/QyY1y7KrvTeqWr6Gq/6xTfeTtg8MtLvCpNYkPrm3oGA43bvl9H
 cBcTH2PY1n3YPgyBcAqO+UWDhgTG61pWCjjRQQHQQnJ15153k51XX9k6kPHLTBrqdalshtFpaI9
 IQSfIwZHr53BeJG5o6k+ETzcks/Nr3ScHOhnSN8tbv4F24cKzl9LwftwjHnmjXGAOEZM/GhSVpQ
 omQDQKvuj9PW8ZmqVqF5ko3AkakoWk=
X-Received: by 2002:a05:7022:6629:b0:11d:bea3:c93d with SMTP id
 a92af1059eb24-128b70dfb3amr875206c88.29.1772641147109; 
 Wed, 04 Mar 2026 08:19:07 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1279cbd1993sm10007894c88.2.2026.03.04.08.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:19:06 -0800 (PST)
Date: Thu, 5 Mar 2026 00:18:40 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v4 3/9] target/riscv: rvv: Add new VTYPE CSR field - altfmt
Message-ID: <aahbQsYMurRqsgMI@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-4-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-4-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Mar 04, 2026 at 09:25:07PM +0800, Max Chou wrote:
> According to the Zvfbfa ISA spec v0.1, the vtype CSR adds a new field:
> altfmt for BF16 support.
> This update changes the layout of the vtype CSR fields.
> 
> - Removed VEDIV field (bits 8-9) since EDIV extension is not planned to
>   be part of the base V extension
> - Added ALTFMT field at bit 8
> - Changed RESERVED field to start from bit 9 instead of bit 10
> 
> When Zvfbfa is disabled, bits 8+ are treated as reserved (preserving
> existing behavior for altfmt bit). When Zvfbfa is enabled, only bits 9+
> are reserved.
> 
> Reference:
> - https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc
> 
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.h           |  4 ++--
>  target/riscv/vector_helper.c | 39 +++++++++++++++++++++++++++++++-----
>  2 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 35d1f6362c..962cc45073 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -191,8 +191,8 @@ FIELD(VTYPE, VLMUL, 0, 3)
>  FIELD(VTYPE, VSEW, 3, 3)
>  FIELD(VTYPE, VTA, 6, 1)
>  FIELD(VTYPE, VMA, 7, 1)
> -FIELD(VTYPE, VEDIV, 8, 2)
> -FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
> +FIELD(VTYPE, ALTFMT, 8, 1)
> +FIELD(VTYPE, RESERVED, 9, sizeof(target_ulong) * 8 - 10)
>  
>  typedef struct PMUCTRState {
>      /* Current value of a counter */
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index caa8dd9c12..7575e24084 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -33,6 +33,22 @@
>  #include "vector_internals.h"
>  #include <math.h>
>  
> +static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
> +{
> +    int xlen = riscv_cpu_xlen(env);
> +    target_ulong reserved = 0;
> +
> +    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> +        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> +                                           xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> +    } else {
> +        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_ALTFMT_SHIFT,
> +                                           xlen - 1 - R_VTYPE_ALTFMT_SHIFT);
> +    }
> +
> +    return reserved;
> +}
> +
Good -- when Zvfbfa is disabled, altfmt (bit 8) is
treated as reserved, preserving backward compat.
The ill_altfmt switch/case logic is also correct.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
>  target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                              target_ulong s2, target_ulong x0)
>  {
> @@ -41,12 +57,10 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
>      uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
>      uint16_t sew = 8 << vsew;
> -    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
> +    uint8_t altfmt = FIELD_EX64(s2, VTYPE, ALTFMT);
> +    bool ill_altfmt = true;
>      int xlen = riscv_cpu_xlen(env);
>      bool vill = (s2 >> (xlen - 1)) & 0x1;
> -    target_ulong reserved = s2 &
> -                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> -                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>      uint16_t vlen = cpu->cfg.vlenb << 3;
>      int8_t lmul;
>  
> @@ -63,7 +77,22 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>          }
>      }
>  
> -    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
> +    switch (vsew) {
> +    case MO_8:
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        break;
> +    case MO_16:
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    if (altfmt && ill_altfmt) {
> +        vill = true;
> +    }
> +
> +    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
>          /* only set vill bit. */
>          env->vill = 1;
>          env->vtype = 0;
> -- 
> 2.52.0
> 

