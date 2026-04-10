Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F73F36B97
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0wp-0001sN-38; Thu, 09 Apr 2026 21:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0wl-0001rZ-Fh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:46:11 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0wj-0003vs-NW
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:46:11 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9bfcbaa81eso243229366b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775785568; cv=none;
 d=google.com; s=arc-20240605;
 b=iB3AZbkYt0nq0AV5JWmo+yMLPhGlRNPSZIiEKktgpGKDfntLWDMzIsrKxQpDRmdGVl
 R8fZbjpo4PU/BA876LBveqdieG66OT1RhVSmazJKxtbZos2gWpFvvk3NFHm3ANjdQoIo
 NVJmhODrtxRDo45C0WfiradDyXjnGzoCVjk+cjHDVSo4hv33xdjlxxCzacwqRlsd71Wv
 LfrUyLlUi1JhJYoxH/PyCXZVug7kh4GLLWB2aRL1o07t180EE8CSBRi75JloUd7O+5h7
 wUJjURwWslg7tbin3FhH4gnxbbAN6nu9gw2FiJG1rNVMdXUPLgq/jN+3R5KJTkZHE7x+
 x7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=48O1IHH1DQP+ZObYjU1/cjoGrzQ06gIxprk0HEWRSPc=;
 fh=cWfiSq/oFyTN/DKvcJSgQUgJ4u5YSKmpf6by/WUOfgI=;
 b=S8qd7W40uBzsaEwfheig2GgC7K2FFNZsV2qHzUyxEqhBmBciiw+iAMjueoK68cCc9L
 xhanutMS+4Syeo4PRQxgCh4J/8P3VjocOyAsNUfbCNG9jy7uY3BKbVufaEziextsbqE+
 uXtGNgU7NpwfxzQaZ5D2XVMwvBdOAgU1igwCJCEVw3N8yTINl6HaHpxnpIffocGpJLyE
 VsMgZ9SWPduMa3QxZjYkckreX4xom+s1e0W7drwfGpgTCW4mJAY0y3HTbACHX9VqnhEa
 NUzSTJStQfOTjdFIju3htMwq1rvu8GOvtcz+7c0QjqLCR33IgtlfjjrjzDN5Kapwe0Uf
 1CNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775785568; x=1776390368; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48O1IHH1DQP+ZObYjU1/cjoGrzQ06gIxprk0HEWRSPc=;
 b=kA/fTHYRRdYzP8A0YD1j6pKFHCHZKaF0lQ5T6Eb3K8t1KK0nFlh8s7BpT/XqzGo6L6
 5KoJuhKG0NOKCODb1CQTHscz0o3mThLRyWB107gUWmE2KjtEGFIcWXU1JeG/x4Uzt6X6
 4gdc2v33cm/bBv8Pbn76XS2NfGJA8Jp4DLEgL9tfLZxJ8TGW/MzGP7fmUMV7t3YnP3IJ
 AaDwxMhDvAAcykTLLDEmzZ2kj4Ko0uZwBfcCEbKOu3DOELf1jwojNjaXafH/v1nxzaps
 rPaLYWN1e8o9EJyVYa0vEzESLXUoCK4pGUvsr8eTmi1Oa0QZLp9jrmNzyXeZavcZZX5f
 qa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775785568; x=1776390368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=48O1IHH1DQP+ZObYjU1/cjoGrzQ06gIxprk0HEWRSPc=;
 b=q6Di3Pq37F16W/5gwP3NpKGQnSgkGHbqDv7HtQX7XzvF0yD7LvOCHVDWha1Q66qt4f
 pNimEhCSLn2CO7rUtpkpDr/W/ZnqH6VlWDr3X9LDdv8RmgNm8ONuySmRxfrfmH174q76
 0rwJE7pLnt+r9poNsh6X0cNDNN9Rvjrffp6lyKAJNoPlmYTtr6TluiTmGqmQkhFczbLF
 yaKLBSuDLZtLbhnu/mk+wm4xAE8gR92aKhcIDBZT5AAvz0zxxJ3PsGaTnXruEIC4HA/E
 0+IvSSHb41Nt3JyFDqPBNCwNxvAbndc/JXV7L5Rirgh+00olEgtgmsPj9MIbsM5KTBdP
 qPWQ==
X-Gm-Message-State: AOJu0YyNeu5kRM8rN3AVERGsSPTJ5PEa1Mn+o0ulD3ispypazCEZVm5f
 mLl4CHcNhygxhW/h050gkSgz26/mRO/f0lwxB9E6Iqf+wqwcvWH55O+tKoY2+J+mXof69ivJOd3
 t1oaLDLLiTXJpgBmN+jqOoRrU4SflOv4=
X-Gm-Gg: AeBDietcGrEgSJetAj5GD26wBFiC+I+mEs69Pd2if8Utsuex9/ReBey9qa3hyibpjT5
 2cAuR/UZ9aMJhci8x1aQOBmlwm0+vhO2BKDrYFjTgLMQRkTxC0GSo0qr6d/H+Ifj6j3vMTbXBA+
 kfKSAkbJ3iWXpH5acXB+OHcvT5HhoPwO9rvywmRxv2j6jFF4gf61dsn/zZF//9dMa3XGgWlpPwk
 mVlrE40sh9X5R1IKD7tl3lfSETC7Xj2b8UCc2k9TbCqgy69tEhCceuvyg5+QOLLvjhs+7c080Mw
 47fcUlO+XkNmcQW3IQ311nXunulxy8e41qPtjg==
X-Received: by 2002:a17:907:a806:b0:b9c:3ba2:2da8 with SMTP id
 a640c23a62f3a-b9d72aeb9b9mr88133866b.52.1775785567624; Thu, 09 Apr 2026
 18:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-5-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-5-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:45:40 +1000
X-Gm-Features: AQROBzBqoJ7tXl5khSC8HqlK8OpR3lOGe-7FZWCcwcHu5D8d8xnu26uNKatFtxU
Message-ID: <CAKmqyKNHFSEQfWJ2eygX=KSRQQvjAEDvi-f51SknW3zrSFZksA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] target/riscv: Implement SMMPT fence instructions
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, 
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 9, 2026 at 12:08=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> This patch completes the SMMPT implementation by adding support for the
> new fence instructions: `mfence.spa` and `minval.spa`.
>
> According to the specification, these instructions act as memory ordering
> fences for MPT updates. In QEMU's TCG model, this is conservatively
> implemented by flushing the entire TLB, which ensures that any subsequent
> memory accesses will re-evaluate permissions and see the effects of any p=
rior
> MPT modifications.
>
> The instructions are privileged and will cause an illegal instruction
> exception if executed outside of M-mode.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn32.decode                    |  2 ++
>  .../riscv/insn_trans/trans_privileged.c.inc   | 30 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..84cec57daf 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
>  mret        0011000    00010 00000 000 00000 1110011
>  wfi         0001000    00101 00000 000 00000 1110011
>  sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> +mfence_spa  1000011    ..... ..... 000 00000 1110011 @sfence_vma
> +minval_spa  0000011    ..... ..... 000 00000 1110011 @sfence_vma
>
>  # *** NMI ***
>  mnret       0111000    00010 00000 000 00000 1110011
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index 8a62b4cfcd..5ec6bf5991 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -160,3 +160,33 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_=
sfence_vma *a)
>  #endif
>      return false;
>  }
> +
> +#define REQUIRE_SMSDID(ctx) do {          \
> +    if (!ctx->cfg_ptr->ext_smsdid) {      \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool do_mfence_spa(DisasContext *ctx)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    REQUIRE_SMSDID(ctx);
> +    if (ctx->priv !=3D PRV_M) {
> +        return false;
> +    }
> +    decode_save_opc(ctx, 0);
> +    gen_helper_tlb_flush_all(tcg_env);
> +    return true;
> +#endif
> +    return false;
> +}
> +
> +static bool trans_mfence_spa(DisasContext *ctx, arg_mfence_spa *a)
> +{
> +    return do_mfence_spa(ctx);
> +}
> +
> +static bool trans_minval_spa(DisasContext *ctx, arg_minval_spa *a)
> +{
> +    return do_mfence_spa(ctx);
> +}
> --
> 2.43.0
>

