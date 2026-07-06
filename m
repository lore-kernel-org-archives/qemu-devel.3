Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F64FC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgZGD-0002UL-2v; Sun, 05 Jul 2026 22:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZGB-0002S7-Ef
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:40:39 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZG9-0007sQ-TJ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:40:39 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso4162721a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 19:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783305636; cv=none;
 d=google.com; s=arc-20260327;
 b=ncYgsNcUzbpVGFxMcPQeflHTg7+zsBGExu2YspauJa/itmXy86/qabqIcPvScHNeso
 JjWuXW1w/C6vE5hoym61Urd5I3CoshdE6IufqCBb+lmswS3o9Vi2owrCH3O+bO5oMxcv
 MsgUsz+VEtTcqWZrndRmlSTTYxconcAaKG84c5znlfVKF9kzRx4kfTjLFlsYP3oM+acc
 d4L9EbJQ633bJuHiGgTD6Zm+u2Mne2bsOp+FIqJDk65ffw0gSRf3lswpfTn9LEg6dPZh
 cgRIzT0xQUFoiGvfirJjsfsXVAToxETp0SopZqR9hlM6ZJAGLZRn5ap4f37D3dHyUKX9
 lZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TjWdQKwOQpOYEu0iBnBkOGVpSpN1dx6eBdCbU/HeHYI=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=dNgzX746W0C5xw493cty4kKlwgSz07jIhPRW5YIFH/pF8o+wsStJEuq62rTm0bXGJv
 D8OeMfsxVqzDKRJNi9XypvVPY17mjYlWPPepR3plloJhBowmYsP2DqD1YqE/rYyr3bA9
 yYQgKpUJ6qvvkIA3vxGDHs9IFk7qeH4F7yehW9J9oVUyQoKTKda3eQgjyFyBLPAI7DAT
 XnM/zReYBAocIib0x2BQrVQEXTTdOZMNfZ+FkjouJAZG6/fnASJiRok6kfzOKVgAImJ4
 sLoAHlbTN6xL39G5Z74dBaLS0N0pDW6YM7tn+IMlgVgL6pkQOSZ+xtASRkCMqzFgVwq5
 E8FA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783305636; x=1783910436; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjWdQKwOQpOYEu0iBnBkOGVpSpN1dx6eBdCbU/HeHYI=;
 b=aGJrCLzoRaqnRQ0ogj+9HESSPBy/6UxjvOjLOFq2QARgDUBz7na3VuOau9A05380/u
 wGSarE8QDrp4eV9lYo92XdGXgt5hT/CxqJCP7uEplO+0flfGJmcXNPXPr77cbAxfjRqg
 QXQkYWxF5v9uFOw09AE/+/8ylmoo9LtQGgjfok4jiU/jO6ICZPadvym29okjKrwqDtde
 jypkUnxGo95ft6VmH7+uKqe+T1bfO4w24Cx6e1PvCZPhY80DmG5Bz62Cm0AOos/3u4Vs
 siuVWlzRekQ9QW77erFMAVOl8HzOBL0fQWxV+RQ2VsZryzS3tYLPFycsm8AB3daALjt9
 9AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783305636; x=1783910436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TjWdQKwOQpOYEu0iBnBkOGVpSpN1dx6eBdCbU/HeHYI=;
 b=rlr6avITy6xRrzmFN6YaGRuDUm3NRgXM3h4x0kuDNWWXYojtvTtcwemYAk1MUbEmL4
 qfpaObqRyRWvnm8/Z64IGHYWc68qetVkNFC2ChhXnEQSjoqL/8n+KyWcd6ToInFKGEZN
 nZL43gzyydwneDucl7MmknwDtytt3PXUlAboodqP+RQRlo6PLDWh+xQrEqdB4XZ6vQvC
 aggp0cND7D3ySyC0+jIV3PlDS076SL91n7G+VvaYK4IRDf5szJeSWmxilWNchuWSezhV
 Lb4MrA5KvzDQRsFgUhej/bfSRPOHmfypt2kBPZF9q9vSP4rJhGiSV+Z6VkrjwB8FIZ9W
 9Pag==
X-Gm-Message-State: AOJu0YxixlYpmoJEBaM7HH0liC94Xm75JA9Y7bRmwXx+VYqCElj/q/AS
 HZWaQha0wMjA+WSNusH//UXJ59u9FEHq5HR5DFwExCm4gzx+9hP8tPDDsXS+MGnSlau40ZaNFp+
 zhm8MBBJn2l4qthW6wf/gFurHpsv4zuo=
X-Gm-Gg: AfdE7cmzfdvm5nReHYJmGHOasqjf/S63ixblFsp4UkrHhsZD/b9AZ6LamkOTkxdZ6Rx
 VRjxoMcXSfXp06iDxIaa72LavJyi1ceyKYMww5FWis6NAZdR3GzO7cEUlNuHzz7HU6C3EvqbV1B
 teEkR5w4AW5ut+WFdRAopevFJw2IeMzoTgKTn/rX5Xl23j3517ZikqD5ARbJoARytpLqdmnOILl
 OU5nBq5ctdFWdMyQBE91x+9rdtASUrI1w/hHph6RtyIN3BoupCMH5URdsKBhL2/ddMZQAwWtEa8
 +mhaD5o+hC8EOkzyxbVloWgWnrsVx/3Odjnx9g==
X-Received: by 2002:a05:6402:34c6:b0:699:fbe4:16d5 with SMTP id
 4fb4d7f45d1cf-69a1a24b446mr2603213a12.1.1783305636446; Sun, 05 Jul 2026
 19:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260630104350.748267-1-frank.chang@sifive.com>
 <20260630104350.748267-5-frank.chang@sifive.com>
In-Reply-To: <20260630104350.748267-5-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 12:40:10 +1000
X-Gm-Features: AVVi8Cf8Yx6Q4VFdK-gMpWpoaUEYbUOUGcA9_lyTEc1IFQkJLnSORh0HL9RWTQ8
Message-ID: <CAKmqyKPwQ_TgTNF=k6h_H+o9EE9F+97gyDDuPFY1hXnNdq7_OQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] target/riscv: Enable Zicclsm for the compatible
 CPUs
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Tue, Jun 30, 2026 at 8:46=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Now that Zicclsm is supported, let's enable it for the following
> compatible CPUs:
>
> - Base 32 CPU (to be backward compatible)
> - Base 64 CPU (to be backward compatible)
> - XuanTie (T-Head) C908
> - Tenstorrent Ascalon
> - Ventana Veyron V1
> - XiangShan Kunminghu
> - MIPS P8700 (ISA doesn't include Zicclsm, but their datasheet claims tha=
t
>   it has unaligned load/store support in hardware)
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index bff3ed5de14..a3cccdfed3c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3021,6 +3021,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zicbom =3D true,
>          .cfg.ext_zicbop =3D true,
>          .cfg.ext_zicboz =3D true,
> +        .cfg.ext_zicclsm =3D true,
>          .cfg.ext_zicntr =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.ext_zifencei =3D true,
> @@ -3093,6 +3094,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zicbom =3D true,
>          .cfg.ext_zicbop =3D true,
>          .cfg.ext_zicboz =3D true,
> +        .cfg.ext_zicclsm =3D true,
>          .cfg.ext_zicntr =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.ext_zifencei =3D true,
> @@ -3179,6 +3181,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zbs =3D true,
>          .cfg.ext_zkt =3D true,
>          .cfg.ext_zbkc =3D true,
> +        .cfg.ext_zicclsm =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zihintpause =3D true,
> @@ -3222,6 +3225,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zicbom =3D true,
>          .cfg.ext_zicbop =3D true,
>          .cfg.ext_zicboz =3D true,
> +        .cfg.ext_zicclsm =3D true,
>          .cfg.ext_zicntr =3D true,
>          .cfg.ext_zicond =3D true,
>          .cfg.ext_zicsr =3D true,
> @@ -3270,6 +3274,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>
>          /* ISA extensions */
>          .cfg.mmu =3D true,
> +        .cfg.ext_zicclsm =3D true,
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.pmp =3D true,
> @@ -3329,6 +3334,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>       * The RISC-V Instruction Set Manual: Volume I
>       * Unprivileged Architecture
>       */
> +    .cfg.ext_zicclsm =3D true,
>      .cfg.ext_zicntr =3D true,
>      .cfg.ext_zihpm =3D true,
>      .cfg.ext_zihintntl =3D true,
> @@ -3385,6 +3391,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
>          .priv_spec =3D PRIV_VERSION_1_12_0,
>          .cfg.max_satp_mode =3D VM_1_10_SV48,
> +        .cfg.ext_zicclsm =3D true,
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.mmu =3D true,
> --
> 2.43.0
>
>

