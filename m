Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFE3EA8553
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 05:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSlw-0002Ri-4m; Mon, 09 Mar 2026 01:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSlh-0002Ny-Kl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:03:07 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSlg-0006sR-3h
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:03:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-661f8ea8a2bso2500568a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 22:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773032578; cv=none;
 d=google.com; s=arc-20240605;
 b=gQDHVeKdCXrhgdyWrZanFHJeSeSNi9Bh3ZJSKkyFQ2WDkepUPlo3QIokEGOIiKmtV4
 jnNrbF+/zAT7ER03et/qEwF0Ttz66c5n2l39hps+ndlgca5n5hmmt17cSDMD8r78+8wG
 Lq6oyYy95b+4g92Hn7v+oODTP3sfC4XB5xctDkeCyL0m9CFDS+OvigzgMgSUy3MBiN3o
 JZxF8aiGLdV6RrZqnVmCSFNa+zBeXb49lofwUIoxyyWFdzPfFr0HZemZFfkgnqBFPuJa
 v2URz/4Y2LGi2IdTH1u0ngIuXj3zAaVWYvgsGHWYw3hjc1TS+dhTJVzuIqW6QJo+PUcf
 +twA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EUBgIvvK1cIt8zq3+yztPDfisqSvSX2J2OQoTlv6HLY=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=Q95mXoJgdbfCe5B6PVJ98lrVeoiNHy9cUvqmEVR5AKqvt701kmcerHqLzrLn9bcJgi
 Im+yElgMJ9Pq3i024NGunKXyjbtpD7SoSyUmZZUenUHTr+7kjtnni9zOMlDf9pttFtc2
 rVYHDJqD92oA4vwgwyzOZUeNeaKley6YyOoU6OMzci6EqDehD6cGInv6mM+llMRGV8ar
 sh7CVeOV9FuaaCHBC8Wb/1qs3v7e2AV47qAVt0uWxhZUsOMp9Ib2OSVxbWjebY7rC2JY
 cC83nHgjy5mN4UGxJE1FvdkQ7hkVqv0c+F5xeDVIm1hWpP1xF7cirxJAA9K6Hty8VZIC
 fP5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773032578; x=1773637378; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUBgIvvK1cIt8zq3+yztPDfisqSvSX2J2OQoTlv6HLY=;
 b=E8RHnRDVoS9Q/EVxpp0xJVaNpSM1E9E821sClSC23ybrL3HVdb412b5f5nPC0kwb6k
 6ew+8iW8JN/K5Yq8b1yx8PnuRA+fK8QdDJqd+CrZAkZ2qlNhhlerEiW8SS3RX8zOO/Ug
 2IdMYlRIAPu0DWkrtAx7AJXIVqbFtb8/myv75gQMkqyTp0EQIyXoB0msEHwoiryPnoLM
 Y0K1zZNt4pNSa+c3mmlTDbvjo0ecp/hwCT9HuuusFjbzSkGF+72MBYls6h9Ad3mCG5aa
 ytWOoDTOywGANM+HU4EFEaL4w49ADTCBNyVwtV+5VA0nVRY3g1sfYkhIl6lBvEaSpzvg
 R5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773032578; x=1773637378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EUBgIvvK1cIt8zq3+yztPDfisqSvSX2J2OQoTlv6HLY=;
 b=qdKkYHiCRrYm9vXZhv8EVZO3X+RAGu2oktFjanNXJJfve/H4epCBWad94KTBd92O91
 cVLmeZX6xLUGcO5dBk4qpGOzGmJcIveaXxEhsfJ6sEYPtEEHT49e/46yjXfWxMfWNmm2
 br7bJoeB5bqvMGta1wk17BiOtbb/vKbft+v95Oqgw95m/sJH61lUpr0bzezH6R6BCDO1
 WoN1YwhnJV+Sxcy/yvHezE16TXIZyqhrdQqw1lAQgfHtg1X9yrY5lbcrqzEFx8XMwFRh
 Ve+J4HBTvjdJvz60ew+IbTgI41Etvk4fGQ0E2Yc60kl5dBoyfc4kdFGuZHvHPN5WCetj
 77Ew==
X-Gm-Message-State: AOJu0YwS2uJ8JxZnibd/u3SnsZpeZWvGC8YFGahGJxavB22MvNtcTNx+
 09g0BP+ToRjbDRFRjRCywyxhtYpTkmKzYJiZD9PdgjBN+LznpEjsd+immmI9db0lH3ulpsDqL9m
 B1MT4/QEer4ag0jqvnG5e9tzqnklVmnJ78I8Zz/k=
X-Gm-Gg: ATEYQzw1sN4ZrGDZqqdtqGvNYFsQS2NDclsGuQ91ZKMbMxjdJR9elDAQxaaOEZY8kxH
 oaUE6WH8XFI3j4ApYCH1IoMzAuz6emYPm7XUPA/0Ysm3DF9uhcNXt5/oktGUJcauzJM1qgpwVhP
 G72ZW10DRW7K1VBMpeouEGiHNg91vgMYG1lbpHyfsi4cv7DbHZ5yxUmC83uLqgcybCsnSLD6MRu
 V9nVQIktpElF7LdJ5240tCgRm43SDsvdYmUh0X7RKIo8IOSlQ6hxs55Z0GSQ+1D8wXVJCYQtY8v
 we7RVLhzMgRsZRaPT4eo+N4mmwqM8NlApvweUg==
X-Received: by 2002:a05:6402:1ecb:b0:65f:bad8:9c6 with SMTP id
 4fb4d7f45d1cf-6619d46b306mr5918556a12.12.1773032578071; Sun, 08 Mar 2026
 22:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-7-max.chou@sifive.com>
In-Reply-To: <20260306071105.3328365-7-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 15:02:31 +1000
X-Gm-Features: AaiRm53_imt4Is1UsL2NckFupN5_C1XWwJpEE-1xSszKcumRH9RdS_U8V9MhIF4
Message-ID: <CAKmqyKMJ8G9ozGsja=VvoRxR5T6O6bYJrytLAD3j3zwSxWfDsw@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] target/riscv: Introduce altfmt into DisasContext
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> wrote=
:
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index cb4f443601..89d4f6fe67 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -101,6 +101,7 @@ typedef struct DisasContext {
>      bool cfg_vta_all_1s;
>      bool vstart_eq_zero;
>      bool vl_eq_vlmax;
> +    bool altfmt;
>      CPUState *cs;
>      TCGv zero;
>      /* actual address width */
> @@ -1307,6 +1308,7 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cs);
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      uint32_t tb_flags =3D ctx->base.tb->flags;
> +    uint64_t ext_tb_flags =3D ctx->base.tb->cs_base;
>
>      ctx->pc_save =3D ctx->base.pc_first;
>      ctx->priv =3D FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
> @@ -1326,6 +1328,7 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      ctx->cfg_vta_all_1s =3D cpu->cfg.rvv_ta_all_1s;
>      ctx->vstart_eq_zero =3D FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZER=
O);
>      ctx->vl_eq_vlmax =3D FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
> +    ctx->altfmt =3D FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
>      ctx->misa_mxl_max =3D mcc->def->misa_mxl_max;
>      ctx->xl =3D FIELD_EX32(tb_flags, TB_FLAGS, XL);
>      ctx->address_xl =3D FIELD_EX32(tb_flags, TB_FLAGS, AXL);
> --
> 2.52.0
>
>

