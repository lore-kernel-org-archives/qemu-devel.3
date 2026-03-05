Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B29EFCE5A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 03:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxzAr-0007CQ-3H; Wed, 04 Mar 2026 22:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxzAl-0007Bn-MY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:14:49 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxzAj-0000UA-Gp
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:14:47 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6611f41eebcso1154185a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 19:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772680482; cv=none;
 d=google.com; s=arc-20240605;
 b=N7MW5rCGUD9KZVgbvp+ds+CH6HLomuEJvO7Pb/auyvm5dr/5QptJkIrmvYoxMRlFiI
 cZoCuLQN/jLUzTlErmngVpwCl98+zF0ae0TqKsEeb8B/MPwOf2fF10JxuPhDtJVMLDxU
 lBR/X+aD39nKaPHAvtjiDaidQXKodS2NMk/FN+oxgztRhX8jiuEQxmAIRB/++AjlR88/
 v0Gs9GGpUYcg9OZQJ5lNSmaE+KFqkCVnR7eVEcbw9i8AUQhZMQMCl/2T2CpdQjU3hitG
 iWKrKZB17rv5QEuybg/MOYst6IwtYUIB2IDEnJKB6cA/8qRBVpz+zqts1NDx9Y9/c2Dw
 ekqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EEZ7DBINRG9Ek3nvcYR9sNUbiDaI1qwgou2XmCGfR0Y=;
 fh=Ug5ikdOLwSxRuA0aSetRr9yn4eERkjTGssWFMxYIL6k=;
 b=DHKGHVIZ/EFxCs6aLFfDE5VPv6PCd1qdQ1timYXzV6jqkWRyJpsl46/3JCV8+YSU8c
 lnihWKX7cUYqXICjPVIvI2eJYEdTsh6n0U1vH9m2WiDAwVMwisKw7otZnnMlmpBQN6FD
 USEQ2+aGjVfqVxCkaasfnPSJZoWPt/dLU1QBzDw0KtPwsVFoS4NYxOxop3a1gVGMuVin
 AOIu3Gbg4DFjsPPLKzJGN5th/XTZnEkQoFAfG8n/GoKkdcgIglFGfKjnFJ0ndVWoKpWD
 YbheXgwpDpuWKJR59Cs9kSZYJBgjPPFU+ojcPLwSMmvapf9/Kq3qMhixkKJmP7fd9IjT
 ShhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772680482; x=1773285282; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEZ7DBINRG9Ek3nvcYR9sNUbiDaI1qwgou2XmCGfR0Y=;
 b=GhWPOesSDfRcVkRFSuKa049qz3Ty8UaOHXebHJd2oEB1x25bQePwV9QkjbG5h6y77w
 NJSq4KvQLumEnjTf+8+fN5NMUIgHslvOHHJapbH/RJAIrOEl8OMfnsaBuAYkSeINfPIT
 8ogmXeMn0rg5C1eYUeMd5Tazqb6q4ERyei2dMuHaHaO9HF5aTmj9cLVszYvWarwJEDiy
 o9jYdBpNetTt4BGkIdoOphbJTG5x+Oey0Fq96aDGtFFbvLHMXFfmCa7ZAkH7NFKFex50
 26lE9qfToD9IZBOlXw+YthT4fqTO1SRtVJdlu6sdgf6sC7krMkJgOs9U10e5/ZTHcMqq
 MDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772680482; x=1773285282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EEZ7DBINRG9Ek3nvcYR9sNUbiDaI1qwgou2XmCGfR0Y=;
 b=GmRKsltzfm9/XGj9Mo/xM1Q7jgo71kZ4p+Z3e8AaeF2Ulwg/Ns0h8Ty5Fnxf6a8O+O
 mQ9ipHNGym9UE9pMP0bg9mhinDxWB0V7Z72ik3tKEhbaxN/D5mor8pk5jl+OeRzU+G96
 sQTTLAq1taq88LJ8gk0LoQq0G3i9KEGpmNnk+DFxfPg3+9/DGlMrZF7z0OWnjK1MI26O
 K60+/4kfH6NOYtEWrVY0ECpDH07cwC+0uLu9a15UzKHx4pG7F7rEVzgR0kPQLhF96x1M
 QKd2LIN+hm+5UV6R1/RwaSk0ymcDyQFmFT2RFNVoEsKWomFOP+RB1Sz9rHXZOmmLtFGo
 EOBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtjvUBDi0DjeyvY8qCJPE9TGVSLWAvWegc5I7DAlkY3s4x3bsAObae3AkeB78bGr32X0vq78Zfbhsm@nongnu.org
X-Gm-Message-State: AOJu0YxnMaoGZT7fE7zusR+CTzHqAYNOuQscSBImY58ZwB5mSs3uIeWW
 qhpRZ1iZklraresofI2qal8jwHrdkTI8l61ka0wakqix1U/iiaxgKasg6sqop8wTLi8kwW729NC
 hhu/7yz9L5rUm8//WbwDxcJj5+uuJScE=
X-Gm-Gg: ATEYQzxOR1fG8Rla1hzGt03pYYID8E8JL8u35lcEC8MwwmwzC9Vf9vUstVeCnE1Twlz
 oL+wTyDDHdHOM5qXcu/4XMAmip20jha/IC0Jm6rlOqvjtjNW56zbXapoZbJkwk1AGizGXHjCE3o
 viGHlCDXjhcJOa5ZTNO3xEooZJKrjZ6HQggiqdgkC6SS9fF7twYOcAJsaTMF+4ChpVHr3gnyHnx
 olFP07XmOEd3mHZ0+MDc5JVKqylvlFOxess64wdzsn0twILWX8C5Yra0rGVdK0bcXA3lIp/jGyZ
 jgJd5zwnsZjjm0HN5eciym8MYrVqUUhuTpE/ng==
X-Received: by 2002:a05:6402:1e93:b0:65c:22a9:93d with SMTP id
 4fb4d7f45d1cf-660f02c4e50mr2306540a12.19.1772680481887; Wed, 04 Mar 2026
 19:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20260304121113.117299-1-james.wainwright@lowrisc.org>
 <20260304121113.117299-3-james.wainwright@lowrisc.org>
In-Reply-To: <20260304121113.117299-3-james.wainwright@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2026 13:14:14 +1000
X-Gm-Features: AaiRm528JQL1oI411clYgzQX3QMQO5kTZctqhueI_CVsiIfYB9ZuxIzD1SdH3sU
Message-ID: <CAKmqyKN6szjMFhctNsV7EvLXnXanERRFoE8ri3woALrnCHL93Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv: add unratified RISC-V Zbr0p93 ext
To: James Wainwright <james.wainwright@lowrisc.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Thu, Mar 5, 2026 at 12:11=E2=80=AFAM James Wainwright
<james.wainwright@lowrisc.org> wrote:
>
> This extension was not ratified with the Zb[abcs] bitmanip extensions.
> This is the latest draft version (0.93) as implemented by the Ibex core.
>
> These instructions are in the reserved encoding space but have not been
> ratified and could conflict with future ratified instructions.

Looking at https://github.com/riscv/riscv-bitmanip/issues/188 I assume
that these instructions will never be ratified.

We don't have a policy on what to do with deprecated draft extensions,
but I'm reluctant to add these. At some point in the future they will
conflict with a ratified extension, which will cause all sorts of
issues.

These should probably just be a vendor specific thing

Alistair

>
> Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
> ---
>  target/riscv/bitmanip_helper.c            | 20 +++++++
>  target/riscv/cpu.c                        |  4 +-
>  target/riscv/cpu_cfg.h                    |  3 ++
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/helper.h                     |  2 +
>  target/riscv/insn32.decode                | 12 +++++
>  target/riscv/insn_trans/trans_rvb.c.inc   | 37 +++++++++++++
>  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
>  tests/tcg/riscv64/test-crc32.S            | 64 +++++++++++++++++++++++
>  9 files changed, 147 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/riscv64/test-crc32.S
>
> diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/bitmanip_helpe=
r.c
> index e9c8d7f778..1156a87dd3 100644
> --- a/target/riscv/bitmanip_helper.c
> +++ b/target/riscv/bitmanip_helper.c
> @@ -23,6 +23,8 @@
>  #include "exec/target_long.h"
>  #include "exec/helper-proto.h"
>  #include "tcg/tcg.h"
> +#include "qemu/crc32.h"
> +#include "qemu/crc32c.h"
>
>  target_ulong HELPER(clmul)(target_ulong rs1, target_ulong rs2)
>  {
> @@ -129,3 +131,21 @@ target_ulong HELPER(xperm8)(target_ulong rs1, target=
_ulong rs2)
>  {
>      return do_xperm(rs1, rs2, 3);
>  }
> +
> +target_ulong HELPER(crc32)(target_ulong rs1, target_ulong sz)
> +{
> +    for (target_ulong i =3D 0; i < sz; i++) {
> +        rs1 =3D crc32_table[rs1 & 0xFF] ^ (rs1 >> 8);
> +    }
> +
> +    return rs1;
> +}
> +
> +target_ulong HELPER(crc32c)(target_ulong rs1, target_ulong sz)
> +{
> +    for (target_ulong i =3D 0; i < sz; i++) {
> +        rs1 =3D crc32c_table[rs1 & 0xFF] ^ (rs1 >> 8);
> +    }
> +
> +    return rs1;
> +}
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e56470a374..b83efb210e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1377,6 +1377,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
>      MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
> +    MULTI_EXT_CFG_BOOL("x-zbr", ext_zbr, false),
>
>      { },
>  };
> @@ -3056,7 +3057,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zba =3D true,
>          .cfg.ext_zbb =3D true,
>          .cfg.ext_zbc =3D true,
> -        .cfg.ext_zbs =3D true
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_zbr =3D true
>      ),
>
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cd1cba797c..2f18d16de2 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -70,4 +70,7 @@ MATERIALISE_EXT_PREDICATE(xtheadmempair)
>  MATERIALISE_EXT_PREDICATE(xtheadsync)
>  MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
>
> +/* Extensions that are not yet upstream */
> +MATERIALISE_EXT_PREDICATE(zbr);
> +
>  #endif
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 70ec650abf..38cb512010 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -11,6 +11,7 @@ BOOL_FIELD(ext_zbc)
>  BOOL_FIELD(ext_zbkb)
>  BOOL_FIELD(ext_zbkc)
>  BOOL_FIELD(ext_zbkx)
> +BOOL_FIELD(ext_zbr)
>  BOOL_FIELD(ext_zbs)
>  BOOL_FIELD(ext_zca)
>  BOOL_FIELD(ext_zcb)
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index b785456ee0..7722c590bd 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -84,6 +84,8 @@ DEF_HELPER_FLAGS_1(unzip, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_1(zip, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_2(xperm4, TCG_CALL_NO_RWG_SE, tl, tl, tl)
>  DEF_HELPER_FLAGS_2(xperm8, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> +DEF_HELPER_FLAGS_2(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> +DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl)
>
>  /* Floating Point - Half Precision */
>  DEF_HELPER_FLAGS_3(fadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..97bf9687b7 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -847,6 +847,18 @@ binvi      01101. ........... 001 ..... 0010011 @sh
>  bset       0010100 .......... 001 ..... 0110011 @r
>  bseti      00101. ........... 001 ..... 0010011 @sh
>
> +# *** RV32 Zbr Experimental Extension ***
> +crc32_b    0110000  10000 ..... 001 ..... 0010011 @r2
> +crc32_h    0110000  10001 ..... 001 ..... 0010011 @r2
> +crc32_w    0110000  10010 ..... 001 ..... 0010011 @r2
> +crc32c_b   0110000  11000 ..... 001 ..... 0010011 @r2
> +crc32c_h   0110000  11001 ..... 001 ..... 0010011 @r2
> +crc32c_w   0110000  11010 ..... 001 ..... 0010011 @r2
> +
> +# *** RV64 Zbr Experimental Extension (in addition to RV32 Zbr) ***
> +crc32_d    0110000  10011 ..... 001 ..... 0010011 @r2
> +crc32c_d   0110000  11011 ..... 001 ..... 0010011 @r2
> +
>  # *** Zfa Standard Extension ***
>  fli_s       1111000 00001 ..... 000 ..... 1010011 @r2
>  fli_d       1111001 00001 ..... 000 ..... 1010011 @r2
> diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/insn_=
trans/trans_rvb.c.inc
> index e4dcc7c991..59db8b047f 100644
> --- a/target/riscv/insn_trans/trans_rvb.c.inc
> +++ b/target/riscv/insn_trans/trans_rvb.c.inc
> @@ -36,6 +36,12 @@
>      }                                            \
>  } while (0)
>
> +#define REQUIRE_ZBR(ctx) do {                    \
> +    if (!ctx->cfg_ptr->ext_zbr) {                \
> +        return false;                            \
> +    }                                            \
> +} while (0)
> +
>  #define REQUIRE_ZBS(ctx) do {                    \
>      if (!ctx->cfg_ptr->ext_zbs) {                \
>          return false;                            \
> @@ -569,3 +575,34 @@ static bool trans_xperm8(DisasContext *ctx, arg_xper=
m8 *a)
>      REQUIRE_ZBKX(ctx);
>      return gen_arith(ctx, a, EXT_NONE, gen_helper_xperm8, NULL);
>  }
> +
> +static bool gen_crc(DisasContext *ctx, arg_r2 *a,
> +                    void (*func)(TCGv, TCGv, TCGv), TCGv tsz)
> +{
> +    REQUIRE_ZBR(ctx);
> +    TCGv dest =3D dest_gpr(ctx, a->rd);
> +    TCGv src1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
> +
> +    func(dest, src1, tsz);
> +    gen_set_gpr(ctx, a->rd, dest);
> +
> +    return true;
> +}
> +
> +#define TRANS_CRC32(NAME, SIZE) \
> +    static bool trans_crc32_##NAME(DisasContext *ctx, arg_r2 *a) \
> +    { if (SIZE =3D=3D 8) { REQUIRE_64BIT(ctx); }; \
> +      return gen_crc(ctx, a, gen_helper_crc32, tcg_constant_tl(SIZE)); }
> +#define TRANS_CRC32C(NAME, SIZE) \
> +    static bool trans_crc32c_##NAME(DisasContext *ctx, arg_r2 *a) \
> +    { if (SIZE =3D=3D 8) { REQUIRE_64BIT(ctx); }; \
> +      return gen_crc(ctx, a, gen_helper_crc32c, tcg_constant_tl(SIZE)); =
}
> +
> +TRANS_CRC32(b, 1);
> +TRANS_CRC32(h, 2);
> +TRANS_CRC32(w, 4);
> +TRANS_CRC32(d, 8);
> +TRANS_CRC32C(b, 1);
> +TRANS_CRC32C(h, 2);
> +TRANS_CRC32C(w, 4);
> +TRANS_CRC32C(d, 8);
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv6=
4/Makefile.softmmu-target
> index eb1ce6504a..f0bf4fa124 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -36,5 +36,10 @@ run-plugin-interruptedmemory: interruptedmemory
>           $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
>           $(QEMU_OPTS)$<)
>
> +EXTRA_RUNS +=3D run-test-crc32
> +comma:=3D ,
> +run-test-crc32: test-crc32
> +       $(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-zbr=3Dtrue $(QEMU=
_OPTS)$<)
> +
>  # We don't currently support the multiarch system tests
>  undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/test-crc32.S b/tests/tcg/riscv64/test-crc3=
2.S
> new file mode 100644
> index 0000000000..70d70b16a9
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-crc32.S
> @@ -0,0 +1,64 @@
> +/*
> + * Copyright (c) 2026 lowRISC CIC
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#define crc32(op, rd, rs1) .insn r 19, 1, 48, rd, rs1, x##op
> +
> +#define crc32_b(rd, rs1) crc32(16, rd, rs1)
> +#define crc32_h(rd, rs1) crc32(17, rd, rs1)
> +#define crc32_w(rd, rs1) crc32(18, rd, rs1)
> +#define crc32_d(rd, rs1) crc32(19, rd, rs1)
> +#define crc32c_b(rd, rs1) crc32(24, rd, rs1)
> +#define crc32c_h(rd, rs1) crc32(25, rd, rs1)
> +#define crc32c_w(rd, rs1) crc32(26, rd, rs1)
> +#define crc32c_d(rd, rs1) crc32(27, rd, rs1)
> +
> +       .option norvc
> +
> +       .text
> +       .globl _start
> +_start:
> +       lla t0, trap
> +       csrw mtvec, t0
> +
> +       li      t0, 0x34e24a2cd65650d4
> +
> +       crc32_b         (t0, t0)
> +       crc32_h         (t0, t0)
> +       crc32_w         (t0, t0)
> +       crc32_d         (t0, t0)
> +       crc32c_b        (t0, t0)
> +       crc32c_h        (t0, t0)
> +       crc32c_w        (t0, t0)
> +       crc32c_d        (t0, t0)
> +
> +       li      t1, 0x68167e78
> +
> +       li      a0, 0
> +       beq     t0, t1, _exit
> +fail:
> +       li      a0, 1
> +_exit:
> +       lla     a1, semiargs
> +       li      t0, 0x20026     # ADP_Stopped_ApplicationExit
> +       sd      t0, 0(a1)
> +       sd      a0, 8(a1)
> +       li      a0, 0x20        # TARGET_SYS_EXIT_EXTENDED
> +
> +       # Semihosting call sequence
> +       .balign 16
> +       slli    zero, zero, 0x1f
> +       ebreak
> +       srai    zero, zero, 0x7
> +       j       .
> +
> +       .data
> +       .balign 16
> +semiargs:
> +       .space  16
> +
> +trap:
> +       csrr t0, mepc
> +       addi t0, t0, 4
> +       mret
> --
> 2.48.1
>
>

