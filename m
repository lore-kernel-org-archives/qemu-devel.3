Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635CBCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 03:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3nwU-0003gp-Bo; Tue, 30 Sep 2025 23:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1v3nwR-0003g3-Ad
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 23:55:47 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1v3nwI-0005x5-IZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 23:55:47 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-33082aed31dso7383428a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 20:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1759290930; x=1759895730; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRb/EQVVAt4Z9iqVWo64yM7U3qF/C6UR3l1d5tHGQFo=;
 b=GkXBO9eMr7Zpci0bUBQvPSe+PRlYotzBjUo0K8cp5etPpr84GWkjlLDpHeRy73UTE3
 S//SEczWrVtaHjTmWiltjD+ZXxCt8x6n4rRoElndhN97WOl52ZZE3p9WpGO5BzRsrbjQ
 qGUnf2rZWVedziqFR5OhOrLvK4Luib5j1E8tbKs9LSzP6BCaeFgye3QTVlV5G30iCS+K
 qzm5j54gL9p5KokAcOx1+CJp11xdTP548+PNZ6vLMrhqVT0EzJfw6q/7WxYWQojC+QEF
 f+VjXRyGA4IF1NPxBqGKDVGpF4Pv86E6iAoi7G5jSSbmsxVphG9VJp7UwPzziy9F98Bw
 IDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759290930; x=1759895730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRb/EQVVAt4Z9iqVWo64yM7U3qF/C6UR3l1d5tHGQFo=;
 b=MbFM3UymLn7UqXs7diLLi47JwHMxk5Pew/MKh1YC+S82ffFSruLY7gojA4Rw4kImqV
 EaVONSkcAV/b19inPVCvrUq9/ki5oK+KH/KZDfra90Lobg10vtMu1DGt0MbudZMydkNI
 aQ8XMUqzJ8TGuq0Q/11nABt9yiIbBHze+sihOnvtfSuag+m9ETJ/5m0VdhohN6XzMVsl
 qGKBRHItTGCD7uHv/hDzI4CdjTlAFuR6dkv8+r5WQWSwxgyXHc0JTKxz/Y434QEmDNMF
 NqE5bbvrEo00O1xHC8UUS4CJWb4PbBwhZoA0okiDVrG7j1R9uWEHx5sOLWCVv41BNzEh
 SGuA==
X-Gm-Message-State: AOJu0YytRw8ubUbZ0wB5Yoai7PCLCO8oIQGMZkTxbhM3WSGjM9cdASPe
 HOi6zIDJxi1tmiPzJbZAIIrSkfG+JGv9KgsEPibotfKYbZ7Lxqx9UgPeH3qd7A6NEp1YMH9fjbL
 guAEgDg+UDh8ITw/w9qbfBWwMUbGNf0RfQbg1CC6wSL9PS94FK5RMfnOb+Xk309oYFsx/4ULo5u
 U/ZZAaaKIyClKdxGhJXRSVOhN5nJ+hsqy4wKu/FKs39NJtDg==
X-Gm-Gg: ASbGncv1X3JexqNeSAJhmlXUC3FUF+zzaagkNWxktWiKQl589OEq4oqDJjRHFT/1+Wb
 FiUd3LzWR3Bx09F+wORs4lush+TI5a9Z9vjIXfcHiT0oHygwVD4dLKiT6bvrV4urNcgS7hGR5dY
 oADW5jYNYBacaYjlRo7Gs9QBONjcQw477gwcTo4cBdcuIreh+4W5AXOpb9hKaprV4sHL3ucUhvx
 dJHPbBKY45A9g3+FE2paT6OEqfrYkfbA2IP3KQSXPAYZrqPt0p6RCBeJsXJWVVLxs0Q2Tf7uf/n
 i3aoOlf8jdpsZNhVJpzCV3e6Z+rHgvcCX9VfKcAvMinWBOr6jK5O4LsXKc6uNlRXadsK2MQiu2P
 +SBAOAt7cdgNLQUebvBNFEQ6D8sit4oIrDY4jrzBFM/Xel8cGxJzWe3p1M5gLSLZlxYGaf2sBaV
 deyDqWrBqLMxBPr+s=
X-Google-Smtp-Source: AGHT+IE/3nbmNpL/LRR/5p3K5tldESpsyFxzbxm+yDxgtTrMd61KUqp+yqZc1CiTI7UgZbswa+f6hA==
X-Received: by 2002:a17:90b:3e88:b0:31e:c95a:cef8 with SMTP id
 98e67ed59e1d1-339a6f71f90mr1890059a91.32.1759290929690; 
 Tue, 30 Sep 2025 20:55:29 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com.
 [209.85.214.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a70246c1sm1079098a91.24.2025.09.30.20.55.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 20:55:28 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-28e7cd34047so9377615ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 20:55:27 -0700 (PDT)
X-Received: by 2002:a17:903:2ce:b0:275:7ee4:83bc with SMTP id
 d9443c01a7336-28e7f2f5b43mr24870785ad.2.1759290927459; Tue, 30 Sep 2025
 20:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250930083359.27637-1-jay.chang@sifive.com>
 <20250930083359.27637-3-jay.chang@sifive.com>
In-Reply-To: <20250930083359.27637-3-jay.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 1 Oct 2025 11:55:16 +0800
X-Gmail-Original-Message-ID: <CANzO1D3rQCg-mn2zhjojxkeeAxnqCSvQ0tT-54W9Qhxu7OTy6A@mail.gmail.com>
X-Gm-Features: AS18NWDkalFNRrpVX5IxPzBUCOa5QvWHwaTC0wXasqaE97-K7a8M07RmDxXH_hA
Message-ID: <CANzO1D3rQCg-mn2zhjojxkeeAxnqCSvQ0tT-54W9Qhxu7OTy6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Make PMP CSRs conform to WARL
 constraints
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Jay Chang <jay.chang@sifive.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This patch ensure pmpcfg and pmpaddr comply with WARL constraints.
>
> When the PMP granularity is greater than 4 bytes, NA4 mode is not valid
> per the spec and will be silently ignored.
>
> According to the spec, changing pmpcfg.A only affects the "read" value
> of pmpaddr. When G > 2 and pmpcfg.A is NAPOT, bits pmpaddr[G-2:0] read
> as all ones. When G > 1 and pmpcfg.A is OFF or TOR, bits pmpaddr[G-1:0]
> read as all zeros. This allows software to read back the correct
> granularity value.
>
> In addition, when updating the PMP address rule in TOR mode,
> the start and end addresses of the PMP region should be aligned
> to the PMP granularity. (The current SPEC only state in TOR mode
> that bits pmpaddr[G-1:0] do not affect the TOR address-matching logic.)
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>  target/riscv/pmp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 72f1372a49..d5cd76df3a 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -108,6 +108,17 @@ static int pmp_is_invalid_smepmp_cfg(CPURISCVState *=
env, uint8_t val)
>          g_assert_not_reached();
>      }
>  }
> +/*
> + * Calculate PMP granularity value 'g'
> + *
> + * The granularity value 'g' is defined as log2(granularity) - 2, where
> + * granularity is the minimum alignment requirement for PMP regions in b=
ytes.
> + */
> +static inline int pmp_get_granularity_g(CPURISCVState *env)
> +{
> +    return __builtin_ctz(riscv_cpu_cfg(env)->pmp_granularity >> 2);
> +}
> +
>
>  /*
>   * Count the number of active rules.
> @@ -153,6 +164,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32=
_t pmp_index, uint8_t val)
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "ignoring pmpcfg write - invalid\n");
>          } else {
> +            uint8_t a_field =3D pmp_get_a_field(val);
> +            /*
> +             * When granularity g >=3D 1 (i.e., granularity > 4 bytes),
> +             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> +             */
> +            if ((riscv_cpu_cfg(env)->pmp_granularity >
> +                MIN_RISCV_PMP_GRANULARITY) && (a_field =3D=3D PMP_AMATCH=
_NA4)) {
> +                    return false;
> +            }
>              env->pmp_state.pmp[pmp_index].cfg_reg =3D val;
>              pmp_update_rule_addr(env, pmp_index);
>              return true;
> @@ -199,6 +219,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_=
t pmp_index)
>      target_ulong prev_addr =3D 0u;
>      hwaddr sa =3D 0u;
>      hwaddr ea =3D 0u;
> +    int g =3D pmp_get_granularity_g(env);
>
>      if (pmp_index >=3D 1u) {
>          prev_addr =3D env->pmp_state.pmp[pmp_index - 1].addr_reg;
> @@ -211,6 +232,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32=
_t pmp_index)
>          break;
>
>      case PMP_AMATCH_TOR:
> +        /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching lo=
gic. */
> +        if (g >=3D 1) {
> +            prev_addr &=3D ~((1UL << g) - 1UL);
> +            this_addr &=3D ~((1UL << g) - 1UL);
> +        }
>          if (prev_addr >=3D this_addr) {
>              sa =3D ea =3D 0u;
>              break;
> @@ -577,6 +603,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>
>  /*
>   * Handle a read from a pmpaddr CSR
> + * Change A field of pmpcfg affects the read value of pmpaddr
>   */
>  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>  {
> @@ -585,6 +612,25 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, ui=
nt32_t addr_index)
>
>      if (addr_index < pmp_regions) {
>          val =3D env->pmp_state.pmp[addr_index].addr_reg;
> +        int g =3D pmp_get_granularity_g(env);
> +        switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg))=
 {
> +        case PMP_AMATCH_OFF:
> +            /* fallthrough */
> +        case PMP_AMATCH_TOR:
> +            /* Bit [g-1:0] read all zero */
> +            if (g >=3D 1) {
> +                val &=3D ~((1 << g) - 1);

You should use 1UL here, too, as val is target_ulong type.

> +            }
> +            break;
> +        case PMP_AMATCH_NAPOT:
> +            /* Bit [g-2:0] read all one */
> +            if (g >=3D 2) {
> +                val |=3D ((1 << (g - 1)) - 1);

Same here.

Regards,
Frank Chang

> +            }
> +            break;
> +        default:
> +            break;
> +        }
>          trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
>      } else {
>          qemu_log_mask(LOG_GUEST_ERROR,
> --
> 2.48.1
>
>

