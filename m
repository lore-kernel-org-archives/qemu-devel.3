Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB7DC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZYg-0000ht-OX; Thu, 27 Aug 2026 08:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wzZYf-0000gr-BJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:50:17 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wzZYc-0000HL-Ir
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:50:17 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so2881324fac.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787835013; cv=none;
 d=google.com; s=arc-20260327;
 b=JWou8+4Ao8YdtKOsc6wfZG0dYZXHaQ7aLGrqL4a5EWRR8oJP8kEqkiWdW0B3zyr7gH
 jWAHZJQKB3lNkpM2ypEQQlxVAkGan5zlL/d3kOX6hmmbjBsUfpL/37kZPqsTkVzReOn4
 yu1IiutITp3zcb/X0K2phwjY5evIuXxVfyhKV3vxzsXmDo3xFSRFG57FMyEyCT2ZkdB7
 LSSStIkSez0Dij4FicFMd2g8dfV6VoAkL4y6tEv7rsWJHVs7tohXnqn1KtecJ7EBhrKd
 HADAKwgd+MEs5xp59MfqlQKIV7ZMVizqEh+TwKudRevG5J4sWo+X/wlBJjZ7Em40essb
 S/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jM2UHpB7frC1o8FlAEjLgLQniaKbP22sZS4mgkujvE8=;
 fh=JeXTv4jbWftE16iY0FdY2hdnmVPXh+3bs0k5dGJSyJw=;
 b=ZR7aK3/HpQUHG3/E4ju43DDiz3uv9YpjeKjuDhyIFJknvEfYe86IONqnKDjJlntGuT
 D4OeM1JiFUdpPgo72QUGT01cuozk//Q6vjiLaEJlbcTKMqWxC4G+mZgyS2jUwU04ju9i
 lh5AP6L0oNUgdhu14ieler2BypzVUHvXssaYh0t4Szu+3icdXXIOHjK5fT9xBz/W3pH7
 jjVciTIyZY28N1mixKVnM1ZZv1LDSsLV2ubjwt2ScvtBogWr6kjYFuVxPN1l3yUT07Yd
 JIg4aDg/OuzW3RhJXxDLDtIZ2ZI0dUp7m6sX442lW4MAJNfZOAJ2dD4gJ30jCQ3qHrzf
 OPTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1787835013; x=1788439813; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jM2UHpB7frC1o8FlAEjLgLQniaKbP22sZS4mgkujvE8=;
 b=GEtaxTGoLP13ix3WjPxyMERa64HHrTCwDiyCqGa08xVKbu+BenamQCJ2JdfOyz1FmW
 aoebAN1VJkBz7WZ6WnKR19/wO+7L/DX2fUNzf3X2tphFl2ALAO0sYDrzxXrolFwGKptZ
 mW7B0Fj/3UNVXU0CoG9+5T7Bw5gMh2WIcriirPX2hVYSSIvwwyM9V5pPAAoil9JOuKx3
 ubdYcaimy/99ay7mhIz2ktIX2t7FMrEHPVxCMML58L7XLm8qzUIChQYU+qJDz3fCD8g1
 0JRbvbfjPRYu8PPtv0Pmn/9A/CTTsVZu7RR1cNPf3egf4zlnnjCD5oKHxLReQVwYl4iQ
 zqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787835013; x=1788439813;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jM2UHpB7frC1o8FlAEjLgLQniaKbP22sZS4mgkujvE8=;
 b=Xr6quVjyvSFlVpIOtzbl4pOCQfKbiMX+nb30DjjfuQ22OcAPEsSt5Xcal7TSOGK8Fp
 0seU4ZDpervQFm0oOhukxumRIThUii8Vyi6tmmVFMkTelzKXPwgq3pu6Bp5D2JU27Rpt
 DzhpmmhF6Xe6Ci+1/8iNrh0IG5/An+G9tyHCIti8BGXg6Mc4RnbalkLlJK9W9rTtooPt
 mJut4HWcw5gSQzjOfcQen75pcMSTkacBAQacMpjvEbM9Tm1wBmb1Nn9p+CZETzywrQCQ
 BkeyV5qDB+RDRL0N3vR2BtOnxnPlfPEhOQIcR7CrxXhyg2JAs4JG/vJPN7eIZqlksfiQ
 fyhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqUPP1JPDflLfP6mAowLsTbg9GspdsVCML35aREm37MuMNQQvf+/7/NzLGJt4jRAbw3rg1enBonHmM@nongnu.org
X-Gm-Message-State: AFuF++k4eZDdE+19pAwIMpRT4T+xM57/aY2YDR5VPaiwR5K2U+Ka2HW6
 jCqZuP33PSnrJjBQ8hjvGaCb8+hGb+UHv8p3WKCoHnL9qG5pFPmnMfVO6FHgAYQOsapLfXQcWln
 TSuS3A1+dsAlcrXSq6K018yfdTNilbds+DiFmBv4yGg==
X-Gm-Gg: AR+sD10seoOkwYeYyMa3PLoI2IyHPOm8T5Q2gEBg/qsQtPPnJQld6+idN/OCv/3Szyz
 f2EOUfLHyDHqnSQTvm4N7lt4UhW/tXjut6nZY1Z+Z56a3KUgs6sfH9JasMZBYHsbziimxOULgfg
 rsk4lRO7im0VTmb1u7MDoFkNmvNDyKq7r27LaEwH6nt8sJCjc4bqoO2ndiK56wcvT0ibYrwLu4r
 KgsQzJf5JMZqZL1O7rb0UryF1c3RlcmnSEm+CEEbrMzUAG0DYuN3fbFoN4jut/TiGnHsMJLpLlg
 q4iEPsW7VoZlusSMoRrnFNvxqKN8KF61hisUCgUHh9ggFZNDYMbqJINq6txlyJrsOO7g1mGlsVU
 lL2mjK08yjki8Y2Lxm0/MFXq7zUbJGhJZLQU=
X-Received: by 2002:a05:6820:a513:20b0:6aa:e854:d05d with SMTP id
 006d021491bc7-6b1a03b11bdmr11271009eaf.3.1787835012897; Thu, 27 Aug 2026
 05:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260812174417.2468981-1-max.chou@sifive.com>
 <20260812174417.2468981-6-max.chou@sifive.com>
 <5ff4a05fc85d926c1a3352289a84d071220d871f.camel@wdc.com>
In-Reply-To: <5ff4a05fc85d926c1a3352289a84d071220d871f.camel@wdc.com>
From: Max Chou <max.chou@sifive.com>
Date: Thu, 27 Aug 2026 20:50:01 +0800
X-Gm-Features: AcwNN1W2SG6jJzE6odJLakbJ61tArNzn9Wp2-mrdiw5GCiWt-fo7Lb-DXkhYDU4
Message-ID: <CANiaA1ts8nAf8cbntPBqm53Bp32EBGJzCocQ6tgT282qibmcPQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] disas/riscv: Add disassembler support for
 Xsfvqmaccdod/Xsfvqmaccqoq
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "chao.liu@processmission.com" <chao.liu@processmission.com>, 
 "jason.chien@sifive.com" <jason.chien@sifive.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000dc6b68065a06c662"
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=max.chou@sifive.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000dc6b68065a06c662
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 12:32 Alistair Francis <Alistair.Francis@wdc.com>
wrote:

> On Thu, 2026-08-13 at 01:44 +0800, Max Chou wrote:
> > From: Jason Chien <jason.chien@sifive.com>
> >
> > Add disassembler support for all SiFive custom int8 matrix-multiply
> > instructions: sf.vqmacc{u,,us,su}.4x8x4 and
> > sf.vqmacc{u,,us,su}.2x8x2.
> >
> > These instructions share opcode 0b1011011 and funct3 0b010, and are
> > distinguished by funct6: 60-63 for the 4x8x4 (Xsfvqmaccqoq) tile and
> > 44-47 for the 2x8x2 (Xsfvqmaccdod) tile.
> >
> > Signed-off-by: Jason Chien <jason.chien@sifive.com>
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > Reviewed-by: Daniel Henrique Barboza
> > <daniel.barboza@oss.qualcomm.com>
> > ---
> >  MAINTAINERS       |  1 +
> >  disas/meson.build |  3 +-
> >  disas/riscv-xsf.c | 79
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  disas/riscv-xsf.h | 18 +++++++++++
> >  disas/riscv.c     |  2 ++
> >  disas/riscv.h     |  1 +
> >  6 files changed, 103 insertions(+), 1 deletion(-)
> >  create mode 100644 disas/riscv-xsf.c
> >  create mode 100644 disas/riscv-xsf.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9c9f9bd645a..02ca1682099 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -398,6 +398,7 @@ S: Supported
> >  F: target/riscv/xsf.decode
> >  F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
> >  F: target/riscv/tcg/xsf_helper.c
> > +F: disas/riscv-xsf*
> >
> >  RENESAS RX CPUs
> >  R: Yoshinori Sato <yoshinori.sato@nifty.com>
> > diff --git a/disas/meson.build b/disas/meson.build
> > index 42977a1f74d..91357162682 100644
> > --- a/disas/meson.build
> > +++ b/disas/meson.build
> > @@ -8,7 +8,8 @@ common_ss.add(when: 'CONFIG_RISCV_DIS', if_true:
> > files(
> >      'riscv.c',
> >      'riscv-xthead.c',
> >      'riscv-xventana.c',
> > -    'riscv-xlrbr.c'
> > +    'riscv-xlrbr.c',
> > +    'riscv-xsf.c'
> >  ))
> >  common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
> >  common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
> > diff --git a/disas/riscv-xsf.c b/disas/riscv-xsf.c
> > new file mode 100644
> > index 00000000000..8f752657a7c
> > --- /dev/null
> > +++ b/disas/riscv-xsf.c
> > @@ -0,0 +1,79 @@
> > +/*
> > + * QEMU RISC-V Disassembler for xsf (SiFive vendor extensions).
> > + *
> > + * Copyright (c) 2023 SiFive, Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "disas/riscv.h"
> > +#include "disas/riscv-xsf.h"
> > +
> > +typedef enum {
> > +    /* 0 is reserved for rv_op_illegal. */
>
> This will need a rebase as this isn't required any more
>

Thanks for the suggestion.
I=E2=80=99ll send new rebase version to handle this part.

rnax


> Alistair
>
> > +    xsf_op_sf_vqmaccu_4x8x4 =3D 1,
> > +    xsf_op_sf_vqmacc_4x8x4 =3D 2,
> > +    xsf_op_sf_vqmaccus_4x8x4 =3D 3,
> > +    xsf_op_sf_vqmaccsu_4x8x4 =3D 4,
> > +    xsf_op_sf_vqmaccu_2x8x2 =3D 5,
> > +    xsf_op_sf_vqmacc_2x8x2 =3D 6,
> > +    xsf_op_sf_vqmaccus_2x8x2 =3D 7,
> > +    xsf_op_sf_vqmaccsu_2x8x2 =3D 8,
> > +} rv_xsf_op;
> > +
> > +const rv_opcode_data xsf_opcode_data[] =3D {
> > +    { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
> > +    { "sf.vqmaccu.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0,
> > 0, 0 },
> > +    { "sf.vqmacc.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0,
> > 0, 0 },
> > +    { "sf.vqmaccus.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0,
> > 0, 0 },
> > +    { "sf.vqmaccsu.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0,
> > 0, 0 },
> > +    { "sf.vqmaccu.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0,
> > 0, 0 },
> > +    { "sf.vqmacc.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0,
> > 0, 0 },
> > +    { "sf.vqmaccus.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0,
> > 0, 0 },
> > +    { "sf.vqmaccsu.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2, NULL, 0,
> > 0, 0 },
> > +};
> > +
> > +void decode_xsf(rv_decode *dec, rv_isa isa)
> > +{
> > +    rv_inst inst =3D dec->inst;
> > +    rv_opcode op =3D rv_op_illegal;
> > +
> > +    switch ((inst >> 0) & 0b1111111) {
> > +    case 0b1011011:
> > +        switch ((inst >> 12) & 0b111) {
> > +        case 0b010:
> > +            switch ((inst >> 26) & 0b111111) {
> > +            case 60:
> > +                op =3D xsf_op_sf_vqmaccu_4x8x4;
> > +                break;
> > +            case 61:
> > +                op =3D xsf_op_sf_vqmacc_4x8x4;
> > +                break;
> > +            case 62:
> > +                op =3D xsf_op_sf_vqmaccus_4x8x4;
> > +                break;
> > +            case 63:
> > +                op =3D xsf_op_sf_vqmaccsu_4x8x4;
> > +                break;
> > +            case 44:
> > +                op =3D xsf_op_sf_vqmaccu_2x8x2;
> > +                break;
> > +            case 45:
> > +                op =3D xsf_op_sf_vqmacc_2x8x2;
> > +                break;
> > +            case 46:
> > +                op =3D xsf_op_sf_vqmaccus_2x8x2;
> > +                break;
> > +            case 47:
> > +                op =3D xsf_op_sf_vqmaccsu_2x8x2;
> > +                break;
> > +            }
> > +            break;
> > +        }
> > +        break;
> > +    }
> > +
> > +    dec->op =3D op;
> > +}
> > diff --git a/disas/riscv-xsf.h b/disas/riscv-xsf.h
> > new file mode 100644
> > index 00000000000..b8462c356e2
> > --- /dev/null
> > +++ b/disas/riscv-xsf.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * QEMU disassembler -- RISC-V specific header (xsf*).
> > + *
> > + * Copyright (c) 2023 SiFive, Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef DISAS_RISCV_XSF_H
> > +#define DISAS_RISCV_XSF_H
> > +
> > +#include "disas/riscv.h"
> > +
> > +extern const rv_opcode_data xsf_opcode_data[];
> > +
> > +void decode_xsf(rv_decode *, rv_isa);
> > +
> > +#endif /* DISAS_RISCV_XSF_H */
> > diff --git a/disas/riscv.c b/disas/riscv.c
> > index 7f1b2627737..032cd31e35c 100644
> > --- a/disas/riscv.c
> > +++ b/disas/riscv.c
> > @@ -27,6 +27,7 @@
> >  #include "disas/riscv-xthead.h"
> >  #include "disas/riscv-xventana.h"
> >  #include "disas/riscv-xlrbr.h"
> > +#include "disas/riscv-xsf.h"
> >
> >  typedef enum {
> >      /* 0 is reserved for rv_op_illegal. */
> > @@ -5454,6 +5455,7 @@ static GString *disasm_inst(rv_isa isa,
> > uint64_t pc, rv_inst inst,
> >          { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
> >          { has_XVentanaCondOps_p, ventana_opcode_data,
> > decode_xventanacondops },
> >          { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
> > +        { has_xsf_p, xsf_opcode_data, decode_xsf },
> >      };
> >
> >      for (size_t i =3D 0; i < ARRAY_SIZE(decoders); i++) {
> > diff --git a/disas/riscv.h b/disas/riscv.h
> > index 379e642ec84..66683201b9d 100644
> > --- a/disas/riscv.h
> > +++ b/disas/riscv.h
> > @@ -280,6 +280,7 @@ enum {
> >  #define rv_fmt_vd_vs2_imm_vm          "O\tD,F,im"
> >  #define rv_fmt_vd_vs2_uimm            "O\tD,F,u"
> >  #define rv_fmt_vd_vs2_uimm_vm         "O\tD,F,um"
> > +#define rv_fmt_vd_vs1_vs2             "O\tD,E,F"
> >  #define rv_fmt_vd_vs1_vs2_vm          "O\tD,E,Fm"
> >  #define rv_fmt_vd_rs1_vs2_vm          "O\tD,1,Fm"
> >  #define rv_fmt_vd_fs1_vs2_vm          "O\tD,4,Fm"
>

--000000000000dc6b68065a06c662
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">On Tue, Aug 25, 2026 at 12:32 Alistair Francis &lt;<a hre=
f=3D"mailto:Alistair.Francis@wdc.com">Alistair.Francis@wdc.com</a>&gt; wrot=
e:<br></div><div><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Thu, 2026-08-13 at 01:44 +0800,=
 Max Chou wrote:<br>
&gt; From: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com" target=
=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
&gt; <br>
&gt; Add disassembler support for all SiFive custom int8 matrix-multiply<br=
>
&gt; instructions: sf.vqmacc{u,,us,su}.4x8x4 and<br>
&gt; sf.vqmacc{u,,us,su}.2x8x2.<br>
&gt; <br>
&gt; These instructions share opcode 0b1011011 and funct3 0b010, and are<br=
>
&gt; distinguished by funct6: 60-63 for the 4x8x4 (Xsfvqmaccqoq) tile and<b=
r>
&gt; 44-47 for the 2x8x2 (Xsfvqmaccdod) tile.<br>
&gt; <br>
&gt; Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.co=
m" target=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" tar=
get=3D"_blank">max.chou@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Daniel Henrique Barboza<br>
&gt; &lt;<a href=3D"mailto:daniel.barboza@oss.qualcomm.com" target=3D"_blan=
k">daniel.barboza@oss.qualcomm.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +<br>
&gt; =C2=A0disas/meson.build |=C2=A0 3 +-<br>
&gt; =C2=A0disas/riscv-xsf.c | 79<br>
&gt; +++++++++++++++++++++++++++++++++++++++++++++++<br>
&gt; =C2=A0disas/riscv-xsf.h | 18 +++++++++++<br>
&gt; =C2=A0disas/riscv.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++<br>
&gt; =C2=A0disas/riscv.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +<br>
&gt; =C2=A06 files changed, 103 insertions(+), 1 deletion(-)<br>
&gt; =C2=A0create mode 100644 disas/riscv-xsf.c<br>
&gt; =C2=A0create mode 100644 disas/riscv-xsf.h<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 9c9f9bd645a..02ca1682099 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -398,6 +398,7 @@ S: Supported<br>
&gt; =C2=A0F: target/riscv/xsf.decode<br>
&gt; =C2=A0F: target/riscv/tcg/insn_trans/trans_xsf.c.inc<br>
&gt; =C2=A0F: target/riscv/tcg/xsf_helper.c<br>
&gt; +F: disas/riscv-xsf*<br>
&gt; =C2=A0<br>
&gt; =C2=A0RENESAS RX CPUs<br>
&gt; =C2=A0R: Yoshinori Sato &lt;<a href=3D"mailto:yoshinori.sato@nifty.com=
" target=3D"_blank">yoshinori.sato@nifty.com</a>&gt;<br>
&gt; diff --git a/disas/meson.build b/disas/meson.build<br>
&gt; index 42977a1f74d..91357162682 100644<br>
&gt; --- a/disas/meson.build<br>
&gt; +++ b/disas/meson.build<br>
&gt; @@ -8,7 +8,8 @@ common_ss.add(when: &#39;CONFIG_RISCV_DIS&#39;, if_tru=
e:<br>
&gt; files(<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &#39;riscv.c&#39;,<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &#39;riscv-xthead.c&#39;,<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &#39;riscv-xventana.c&#39;,<br>
&gt; -=C2=A0=C2=A0=C2=A0 &#39;riscv-xlrbr.c&#39;<br>
&gt; +=C2=A0=C2=A0=C2=A0 &#39;riscv-xlrbr.c&#39;,<br>
&gt; +=C2=A0=C2=A0=C2=A0 &#39;riscv-xsf.c&#39;<br>
&gt; =C2=A0))<br>
&gt; =C2=A0common_ss.add(when: &#39;CONFIG_SH4_DIS&#39;, if_true: files(&#3=
9;sh4.c&#39;))<br>
&gt; =C2=A0common_ss.add(when: &#39;CONFIG_SPARC_DIS&#39;, if_true: files(&=
#39;sparc.c&#39;))<br>
&gt; diff --git a/disas/riscv-xsf.c b/disas/riscv-xsf.c<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..8f752657a7c<br>
&gt; --- /dev/null<br>
&gt; +++ b/disas/riscv-xsf.c<br>
&gt; @@ -0,0 +1,79 @@<br>
&gt; +/*<br>
&gt; + * QEMU RISC-V Disassembler for xsf (SiFive vendor extensions).<br>
&gt; + *<br>
&gt; + * Copyright (c) 2023 SiFive, Inc.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;disas/riscv.h&quot;<br>
&gt; +#include &quot;disas/riscv-xsf.h&quot;<br>
&gt; +<br>
&gt; +typedef enum {<br>
&gt; +=C2=A0=C2=A0=C2=A0 /* 0 is reserved for rv_op_illegal. */<br>
<br>
This will need a rebase as this isn&#39;t required any more<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for the s=
uggestion.</div><div dir=3D"auto">I=E2=80=99ll send new rebase version to h=
andle this part.</div><div dir=3D"auto"><br></div><div dir=3D"auto">rnax</d=
iv><div dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><br>
Alistair<br>
<br>
&gt; +=C2=A0=C2=A0=C2=A0 xsf_op_sf_vqmaccu_4x8x4 =3D 1,<br>
&gt; +=C2=A0=C2=A0=C2=A0 xsf_op_sf_vqmacc_4x8x4 =3D 2,<br>
&gt; +=C2=A0=C2=A0=C2=A0 xsf_op_sf_vqmaccus_4x8x4 =3D 3,<br>
&gt; +=C2=A0=C2=A0=C2=A0 xsf_op_sf_vqmaccsu_4x8x4 =3D 4,<br>
&gt; +=C2=A0=C2=A0=C2=A0 xsf_op_sf_vqmaccu_2x8x2 =3D 5,<br>
&gt; +=C2=A0=C2=A0=C2=A0 xsf_op_sf_vqmacc_2x8x2 =3D 6,<br>
&gt; +=C2=A0=C2=A0=C2=A0 xsf_op_sf_vqmaccus_2x8x2 =3D 7,<br>
&gt; +=C2=A0=C2=A0=C2=A0 xsf_op_sf_vqmaccsu_2x8x2 =3D 8,<br>
&gt; +} rv_xsf_op;<br>
&gt; +<br>
&gt; +const rv_opcode_data xsf_opcode_data[] =3D {<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;illegal&quot;, rv_codec_illegal, rv_fmt_no=
ne, NULL, 0, 0, 0 },<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;sf.vqmaccu.4x8x4&quot;, rv_codec_v_r, rv_f=
mt_vd_vs1_vs2, NULL, 0,<br>
&gt; 0, 0 },<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;sf.vqmacc.4x8x4&quot;, rv_codec_v_r, rv_fm=
t_vd_vs1_vs2, NULL, 0,<br>
&gt; 0, 0 },<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;sf.vqmaccus.4x8x4&quot;, rv_codec_v_r, rv_=
fmt_vd_vs1_vs2, NULL, 0,<br>
&gt; 0, 0 },<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;sf.vqmaccsu.4x8x4&quot;, rv_codec_v_r, rv_=
fmt_vd_vs1_vs2, NULL, 0,<br>
&gt; 0, 0 },<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;sf.vqmaccu.2x8x2&quot;, rv_codec_v_r, rv_f=
mt_vd_vs1_vs2, NULL, 0,<br>
&gt; 0, 0 },<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;sf.vqmacc.2x8x2&quot;, rv_codec_v_r, rv_fm=
t_vd_vs1_vs2, NULL, 0,<br>
&gt; 0, 0 },<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;sf.vqmaccus.2x8x2&quot;, rv_codec_v_r, rv_=
fmt_vd_vs1_vs2, NULL, 0,<br>
&gt; 0, 0 },<br>
&gt; +=C2=A0=C2=A0=C2=A0 { &quot;sf.vqmaccsu.2x8x2&quot;, rv_codec_v_r, rv_=
fmt_vd_vs1_vs2, NULL, 0,<br>
&gt; 0, 0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +void decode_xsf(rv_decode *dec, rv_isa isa)<br>
&gt; +{<br>
&gt; +=C2=A0=C2=A0=C2=A0 rv_inst inst =3D dec-&gt;inst;<br>
&gt; +=C2=A0=C2=A0=C2=A0 rv_opcode op =3D rv_op_illegal;<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0 switch ((inst &gt;&gt; 0) &amp; 0b1111111) {<br>
&gt; +=C2=A0=C2=A0=C2=A0 case 0b1011011:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch ((inst &gt;&gt; 12)=
 &amp; 0b111) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0b010:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sw=
itch ((inst &gt;&gt; 26) &amp; 0b111111) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se 60:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 op =3D xsf_op_sf_vqmaccu_4x8x4;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se 61:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 op =3D xsf_op_sf_vqmacc_4x8x4;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se 62:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 op =3D xsf_op_sf_vqmaccus_4x8x4;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se 63:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 op =3D xsf_op_sf_vqmaccsu_4x8x4;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se 44:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 op =3D xsf_op_sf_vqmaccu_2x8x2;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se 45:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 op =3D xsf_op_sf_vqmacc_2x8x2;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se 46:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 op =3D xsf_op_sf_vqmaccus_2x8x2;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se 47:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 op =3D xsf_op_sf_vqmaccsu_2x8x2;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<=
br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0 dec-&gt;op =3D op;<br>
&gt; +}<br>
&gt; diff --git a/disas/riscv-xsf.h b/disas/riscv-xsf.h<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..b8462c356e2<br>
&gt; --- /dev/null<br>
&gt; +++ b/disas/riscv-xsf.h<br>
&gt; @@ -0,0 +1,18 @@<br>
&gt; +/*<br>
&gt; + * QEMU disassembler -- RISC-V specific header (xsf*).<br>
&gt; + *<br>
&gt; + * Copyright (c) 2023 SiFive, Inc.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef DISAS_RISCV_XSF_H<br>
&gt; +#define DISAS_RISCV_XSF_H<br>
&gt; +<br>
&gt; +#include &quot;disas/riscv.h&quot;<br>
&gt; +<br>
&gt; +extern const rv_opcode_data xsf_opcode_data[];<br>
&gt; +<br>
&gt; +void decode_xsf(rv_decode *, rv_isa);<br>
&gt; +<br>
&gt; +#endif /* DISAS_RISCV_XSF_H */<br>
&gt; diff --git a/disas/riscv.c b/disas/riscv.c<br>
&gt; index 7f1b2627737..032cd31e35c 100644<br>
&gt; --- a/disas/riscv.c<br>
&gt; +++ b/disas/riscv.c<br>
&gt; @@ -27,6 +27,7 @@<br>
&gt; =C2=A0#include &quot;disas/riscv-xthead.h&quot;<br>
&gt; =C2=A0#include &quot;disas/riscv-xventana.h&quot;<br>
&gt; =C2=A0#include &quot;disas/riscv-xlrbr.h&quot;<br>
&gt; +#include &quot;disas/riscv-xsf.h&quot;<br>
&gt; =C2=A0<br>
&gt; =C2=A0typedef enum {<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 /* 0 is reserved for rv_op_illegal. */<br>
&gt; @@ -5454,6 +5455,7 @@ static GString *disasm_inst(rv_isa isa,<br>
&gt; uint64_t pc, rv_inst inst,<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { has_xtheadsync_p, x=
thead_opcode_data, decode_xtheadsync },<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { has_XVentanaCondOps=
_p, ventana_opcode_data,<br>
&gt; decode_xventanacondops },<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { has_xlrbr_p, rv_xlr=
br_opcode_data, decode_xlrbr },<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { has_xsf_p, xsf_opcode_da=
ta, decode_xsf },<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 };<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 for (size_t i =3D 0; i &lt; ARRAY_SIZE(decode=
rs); i++) {<br>
&gt; diff --git a/disas/riscv.h b/disas/riscv.h<br>
&gt; index 379e642ec84..66683201b9d 100644<br>
&gt; --- a/disas/riscv.h<br>
&gt; +++ b/disas/riscv.h<br>
&gt; @@ -280,6 +280,7 @@ enum {<br>
&gt; =C2=A0#define rv_fmt_vd_vs2_imm_vm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &quot;O\tD,F,im&quot;<br>
&gt; =C2=A0#define rv_fmt_vd_vs2_uimm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;O\tD,F,u&quot;<br>
&gt; =C2=A0#define rv_fmt_vd_vs2_uimm_vm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &quot;O\tD,F,um&quot;<br>
&gt; +#define rv_fmt_vd_vs1_vs2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;O\tD,E,F&quot;<br>
&gt; =C2=A0#define rv_fmt_vd_vs1_vs2_vm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &quot;O\tD,E,Fm&quot;<br>
&gt; =C2=A0#define rv_fmt_vd_rs1_vs2_vm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &quot;O\tD,1,Fm&quot;<br>
&gt; =C2=A0#define rv_fmt_vd_fs1_vs2_vm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &quot;O\tD,4,Fm&quot;<br>
</blockquote></div></div>

--000000000000dc6b68065a06c662--

