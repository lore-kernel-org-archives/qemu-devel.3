Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A350CC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 23:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sal2R-0003aw-B1; Sun, 04 Aug 2024 19:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sal2P-0003YU-Cy; Sun, 04 Aug 2024 19:53:21 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sal2N-00025M-HI; Sun, 04 Aug 2024 19:53:21 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4f51551695cso3608348e0c.3; 
 Sun, 04 Aug 2024 16:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722815598; x=1723420398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIA0veUAnu2yT0jDBl6LFKBz+GVjO7RrpvzCHhVvTBE=;
 b=cbWqze2wLXzKmsri1oIEmXOwfsUXNcr08XlgREyhEJFadA+nBCcwMUT492gOOQ/NpZ
 0UsNaPVqMmBGPGqTPxEXDlerK7kIILQnOH2kIAwJz2AdV2os+exMZQ9lP7Z5Lp973Qn2
 P38XhIr8rM8COKdvytOInga3GQblrWxDe4GXVi+W+3efpm77NqHvBxM2UHAolRMB7rnr
 WVjMGtZTIV1X4pd+YCYe+Ol6q+U5tjxCw187RKd0u3QHY0uS5MB0hMBWi0UvfsK78Ubz
 wZGVESBqtS53v3Qg1Ad98I7jrgJi/eYXG4L9LgRBEmtmzTGG4nqkFI9FKYc23hAMfukE
 nurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722815598; x=1723420398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIA0veUAnu2yT0jDBl6LFKBz+GVjO7RrpvzCHhVvTBE=;
 b=XCakowlO6/9ps5tjTEmXHshC8fpikUmTruI/EMJ76qiij8bYBVi1dPeF4vVxpE9NIo
 3H1bAzkopCKSG7em8ooIs6bvnDn1Nn0sfR5B9rqSSisxZCraiqj4+TviqVKLGJXFyJeL
 YfyRe/mMV11dECHJ30Guv+Vuj1tW2W0jP7XNkzqM3kD8Rxckpq2j8uJbSgjV59XxpbLA
 SA3DfU5xdTH/Q2YS1qW9/UPKxpq7PpPzQ21uwKQsbDG13GJWluJOtnFlCGfeIZtyWZVi
 UnuwWsHIWtEbtW6fJxe6VRae8L+W4DwqIg74Akg5JRWVlfJUArZFUFnzymbZjetPROCW
 F8CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLjzknEW2M3h7Q+Cu9B6+8kl3p/pZA8d8IVSdA7ziRyyfjE/lPlvlEacVXQ6WtFnaVrP3QzcbiQ37lF6Bon1KYJ4dEang=
X-Gm-Message-State: AOJu0YzT6ZFg5zGo+EQTv1oGTB4YNhcdp2J91ghc6gSDXZ/Da4Pvz2IL
 3itGxFLDsz+eGuhlIsnK3TWiRpVDVUD+mdENCMa4vlLzcgERnmKZRHoHfNr04SFFTQZvehHe9Nf
 UwFJS3EJCoFjXqe/jpBvnh+EIaNg=
X-Google-Smtp-Source: AGHT+IGFehEi0MIKXABccrkothNH6B8S0DhRZxdPsHhZmJeFn1NKjNGCFAeJCL672clsnWqk7FMBvMRmPujK+jsswoA=
X-Received: by 2002:a05:6122:c91:b0:4f2:a973:8ae with SMTP id
 71dfb90a1353d-4f89ff6c5f2mr11049089e0c.5.1722815597693; Sun, 04 Aug 2024
 16:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
 <20240802072417.659-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240802072417.659-2-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 09:52:51 +1000
Message-ID: <CAKmqyKPoHZmwu-=A8wfKM6V=k3Zb2__6erTFULm_A6fg2n7dhw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/riscv: Remove redundant insn length check
 for zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Fri, Aug 2, 2024 at 5:26=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> Compressed encodings also applies to zama16b.
> https://github.com/riscv/riscv-isa-manual/pull/1557
>
> Suggested-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvd.c.inc | 4 ++--
>  target/riscv/insn_trans/trans_rvf.c.inc | 4 ++--
>  target/riscv/insn_trans/trans_rvi.c.inc | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_=
trans/trans_rvd.c.inc
> index 1f5fac65a2..0ac42c3223 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -47,7 +47,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
>
> -    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +    if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> @@ -67,7 +67,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
>
> -    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +    if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_=
trans/trans_rvf.c.inc
> index f771aa1939..0222a728df 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> -    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +    if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> @@ -70,7 +70,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
>
> -    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +    if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 98e3806d5e..fab5c06719 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -268,7 +268,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
>  {
>      bool out;
>
> -    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +    if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>      decode_save_opc(ctx);
> @@ -369,7 +369,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb =
*a, MemOp memop)
>
>  static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>  {
> -    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len !=3D 2)) {
> +    if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
>      decode_save_opc(ctx);
> --
> 2.25.1
>
>

