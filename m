Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9A3F36B97
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0xn-0002ht-5M; Thu, 09 Apr 2026 21:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0xl-0002hU-Q2
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:47:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0xk-0004Qc-8X
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:47:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-66bd4e0560fso2006950a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:47:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775785630; cv=none;
 d=google.com; s=arc-20240605;
 b=gEvDLk5VANvJVOTuK9RZOY/975L6lizosirM0AhmxjzDjx63TRGiK8H1cWY+Va/ZPG
 nXKLtLHl8huyhrcWiShASki2FfXxYo/pf/k0Yt84x7FQne28oqEDRZVUz0dypw6/f5TN
 9IJEU4lOF5k0W9mctMEO03iCVVN+fI0HZS7b8hhKHhzqYIipjiB/y2nsT4Mfc95PdFSY
 RLXlpr55G6VBELXgqTr0TFqskaYujJDC944dgtIzsM8mi4E0Ny6zRk/dR+KunrnUvots
 XjGBXi20M4AtxlyjK/Nf+qlHDwABWN5VN2PdvBn4rk1F0H7IZaKdTGhd0OYIkzIvBe03
 4oOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S+bUn4Z5nOt0Mxyff/J/d30eTpNQWwXXzdsf4LaqeZY=;
 fh=cWfiSq/oFyTN/DKvcJSgQUgJ4u5YSKmpf6by/WUOfgI=;
 b=UCfj0JrvdFTcXt6SRu8p8oI4FZ7zSOKxK+Btg21HYPfSlw85QP0YsT8/tdaeTxXpha
 9TELm2sqSCeV1EsHkyynoVY1X1ZMUQb+ORhSYXjhuoIM57wV3JzcWRwzS5sPNAYDjaOn
 +9aN9CQ/DcBOKywbPCNjhKTSfM6F0WHqJF4n49vxuB/AosBKCTN5wgnE/JInJL3ceUOU
 7YCAzDGzP3uwGqqHj9+dMj4KUYlIy6KkO1fdj9njudgM0dCZpCIYRZ3Oo+iNZQiM9UjZ
 WVQOKy/tBioCteRbcOvyeyTrWcKtwyl4/8qEoy7mDu4A/ojuz5k++4MJMyvFqRiNg4Ox
 KxqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775785630; x=1776390430; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+bUn4Z5nOt0Mxyff/J/d30eTpNQWwXXzdsf4LaqeZY=;
 b=W1FQC8nA+81bUtkC+AZR+5MluE14haQaGJfqB2EMvSKp9XT7ILanpsEQicFpmJbnzP
 KqOG2oU0Kxi+gg2VY2Grt6jh2R77UaxFpq1zrA1lDW49myC9hPAfMh+eF78zrOe6zre0
 /mrM8c6eCpmSPcbd2ZMziqb+d37yPjwNgVP1eyRj7Mi9m6sqiperAZ5dbNCHC8B/jOlk
 320vL/5tihLdN2xkQoMBXVWpJjaw3zhOaWWHPoRl0hop1GkxdRpQJfesydqm2dKSi/5X
 Oig6f12Zr1sB2+hXzC8MnQ0vwcDasPkc2jl6NbGuEPCaAuMnR//8rDVLvC70oEwMDyRy
 g8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775785630; x=1776390430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S+bUn4Z5nOt0Mxyff/J/d30eTpNQWwXXzdsf4LaqeZY=;
 b=PD57LFuTAO2RP7HpldCU7AGrW8gDcsGAuPWuHjKonw+DfMMWCL9WsmmbH6fDBL7JyU
 /mj7kXpVkqXlYg9beltD3vKf1cZ1Li7TBf+MN9FLSnBr6097O/JQDzKu6MY3Rt0Uk1rp
 7NQ6GwlXbicXYLRHDAUY6aiWjhce9CLpAuku2VicQ1MoN8d/KlCx7eAb+/f0Taazvvo2
 XpU7p9D4uxqkK2+eia6giHFdpM/N37A5wWLrUJkc1g74+WDbDA3VL5S/0oCsSb4GU5/c
 Mb/f44ZIWfA2iqTe39S22MljARGXoN1wHRB8nMTExEkIvmxaTOkYUl6h5SsKiM/T8k4l
 f4hg==
X-Gm-Message-State: AOJu0YwgrejDIWaCsMjGJ9FDXfiB+Dwr6x04bfX9aFGp11bkSj80gqWC
 qEj3I3CRvLqd69+p/LHVlgHIkbTVraZlhCAQK5pz5Xa22fAcIwUHLx2vB2XErmCdLNq0cErvgMt
 ftJWKAF58X9Iu7Eke7Z6IHqFOfYrp/yQ=
X-Gm-Gg: AeBDiesn0fHXMWAFHxVaZjjVBA9I/S8ICBEDzXfyH75nTxkjB4TqRO3SxRc5fys2Nbj
 Omsvs4nMH+X1ZmQAiZwoSYCLNZ2oMIA82k6wJrYlDutaKBHGDVbxn/OYqVpjQocjLiMXg8C/xTY
 3/Ua8oP8xAqiXMsfPPxKf6bEKNWtjOM9ll+PULEDMOjXzezMo4O+toA+x+u3b6ijHlgASyrnVLz
 7XyAbrHTPaEpBt6HMwKDA6586M8qJMvnk2BZtbOyu5rZPOift+9rq/IR8faz9UkF3AD941URF3J
 +BBnYY5JuxyINbG7/eNxSJzZ8oAjykU1qC4dTA==
X-Received: by 2002:a17:907:940a:b0:b9c:bf69:8b54 with SMTP id
 a640c23a62f3a-b9d76d6d812mr50481066b.18.1775785630189; Thu, 09 Apr 2026
 18:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-7-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-7-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:46:43 +1000
X-Gm-Features: AQROBzCjD1UV49a7YY0YtxJpDD85oPkjv9EpMcbE6xfqG6lrPjdfhrr1uZBVCGk
Message-ID: <CAKmqyKMryrNgfo8bp-FOj1F0B63WLv1Shsjwj=euptjVr7auVQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] target/riscv: Enable SMMPT extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, 
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Thu, Apr 9, 2026 at 12:09=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:

Can we add a link in this commit to the spec version please?

Alistair

>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cb4ccd001d..1e49465eeb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -225,8 +225,10 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> +    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),
>      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>      ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
> +    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
> @@ -1379,6 +1381,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
> +    MULTI_EXT_CFG_BOOL("x-smmpt", ext_smmpt, false),
> +    MULTI_EXT_CFG_BOOL("x-smsdid", ext_smsdid, false),
>      MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>
>      { },
> --
> 2.43.0
>

