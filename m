Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF982E77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 02:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUcYc-0003Pu-UT; Sun, 05 Jan 2025 21:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcYb-0003PE-3l; Sun, 05 Jan 2025 21:09:29 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcYY-0003Xb-7A; Sun, 05 Jan 2025 21:09:28 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4affbb7ef2dso9477352137.0; 
 Sun, 05 Jan 2025 18:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736129364; x=1736734164; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bpku/GlJhPT7ZDSadY0Vf8Pz4R9+iLv8jDicNXxcnzE=;
 b=eOMsBxzrBS4UJ3md7nGRoovucf1HTOl2E72nwO4wiYzra4JKqKeWZ4MScsRhtU4unu
 ayvsrppgTkAdBsCKHY6zLJSuCKaK8gPU6u9A1OaiVp3bVwCW6dYDfRgevbcGU6R+5d3K
 GGpKufDsGNJ++EqrROhT0d7n/vPa7nfINGVGTnmNWbyc17fg9cRLKnmdrZ+hOXtNt7DP
 dm1xg2dldPgd35XMsgVCnmyNV/pzQvhZOdjZtwETBXkoUUcd0kFtOcfE8nj5CbPRh3nA
 RsXLlH8R0wlxMPQEGzDMTn15SpI7kEXqhaNibbzsDnf1lF4BnLoWeVaCBC7fyh/73n7C
 28QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736129364; x=1736734164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bpku/GlJhPT7ZDSadY0Vf8Pz4R9+iLv8jDicNXxcnzE=;
 b=mC4/1wUN+p2MHcBisqXYHzrnrOReyUCnRHkIqQxpTYjeC23ynVUfa1/MAVRCDZSc4i
 g9uXI1t30oACu5xFH/y3c60fktlplKz5ZjqowezkE8GNP4Pt8eIf9Emipkdz6LU7USX1
 dWc7KOxQTz3ZaeN6EC61tm7HN/0izTRdUapNnEN7jAFxLtgyY6Bpd37XRkXrlTAGDsQv
 /lYT5EhongMgznmQGU2sDhOY6pFMCtG6MGHJ+j3GP5OWUMnSG1+MO1qlDYZfLWTRgo3y
 FXmO1W9RyJJjBFQHUs9q1jLR/caPWQ/j1slQD6NfHTd+YO1vF5b1kylxafZ5HgiBc6XT
 E1OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGM0zST1kNpK4CGl+PASlv9ZxWG3eRfw6wTZTZabmtlhNovbAX5gu6MOhMaItcKumFPDxzuS2pdKgMVg==@nongnu.org,
 AJvYcCW4smmtnrLsRwTgOsu2G7B9N+daid2uKiDaTwcn0+w4yKlAZ3ezGDSqgsuyAHI21jqw/bzTuOpY+lXW@nongnu.org
X-Gm-Message-State: AOJu0Yw/H+vuqzSvW9UGbblHlAsHtIKez7DtOZKRBwEPrUc/67vjrgCJ
 zv97EUy8bKx/2NzqahSI7Ga6AkpplKggKG/Xl0mzuMjWACOu4c7t66aYnQi5OBmECT/hoPVo8Ua
 QoB74OjhBVn3ibmMmTaL2NQUFjAE=
X-Gm-Gg: ASbGncvjvNhJWxI1rFhkDfUd5PskDyik5vbCGkyRnMtMyhhjr2lXAc7wcdsSamF/I0D
 pS8O219n+2MXu64Jjh2Sr0RxAijulLeTpSgWrQg8Oy6sAYIkjnpk8x+gkjfWUms261ks=
X-Google-Smtp-Source: AGHT+IGEORcWNP4jeEN2O3gZRUil0Z/A6eXOeEzgMu66JjmDY7+OJKvLOiBB5n6+PXGXinImWpwxrY5q6d2P+z6k/TQ=
X-Received: by 2002:a05:6102:fa5:b0:4b2:adfb:4f93 with SMTP id
 ada2fe7eead31-4b2cc4540cemr49408076137.17.1736129364256; Sun, 05 Jan 2025
 18:09:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1734424581.git.lc00631@tecorigin.com>
 <0b9e98cf4003198bda24ac56e128e4393682963e.1734424581.git.lc00631@tecorigin.com>
In-Reply-To: <0b9e98cf4003198bda24ac56e128e4393682963e.1734424581.git.lc00631@tecorigin.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 12:08:57 +1000
Message-ID: <CAKmqyKPFYxhK8PANOVzV3FMWxd79wZSJYLWkKOAgEMt_b2KvZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/riscv: Fix handling of NOP for vstart >= vl
 in vext_vx_rm_2()
To: Chao Liu <lc00631@tecorigin.com>
Cc: bmeng.cn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 zqz00548@tecorigin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Dec 17, 2024 at 6:46=E2=80=AFPM Chao Liu <lc00631@tecorigin.com> wr=
ote:
>
> fix: https://lore.kernel.org/all/20240322085319.1758843-8-alistair.franci=
s@wdc.com/

Can you include a commit message of what this fixes?

Instead of linking to the pull request there should be a fixes tag
here, like this

Fixes: df4252b2ecaf "target/riscv/vector_helpers: do early exit when
vstart >=3D vl"

> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> ---
>  target/riscv/vector_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a85dd1d200..54bac5922a 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -2154,8 +2154,6 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *v=
s2,
>               uint32_t vl, uint32_t vm, int vxrm,
>               opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
>  {
> -    VSTART_CHECK_EARLY_EXIT(env);
> -
>      for (uint32_t i =3D env->vstart; i < vl; i++) {
>          if (!vm && !vext_elem_mask(v0, i)) {
>              /* set masked-off elements to 1s */
> @@ -2179,6 +2177,8 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *v=
s2,
>      uint32_t vta =3D vext_vta(desc);
>      uint32_t vma =3D vext_vma(desc);
>
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>      switch (env->vxrm) {
>      case 0: /* rnu */
>          vext_vv_rm_1(vd, v0, vs1, vs2,
> --
> 2.47.1
>
>

