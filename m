Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3BCE8384B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 01:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs9VR-0007Ka-5m; Mon, 16 Feb 2026 20:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vs9VP-0007KA-3M
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 20:03:59 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vs9VM-0006if-RP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 20:03:58 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so2760643a91.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 17:03:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771290235; cv=none;
 d=google.com; s=arc-20240605;
 b=Y9AECG7vGrQLuSvPX6u3G5fFyKQH0aF6tHQRtmp5ELtZrQot+2QHumNFAKpo4KSIc3
 kjZ7KkNDhMadmzlogbeW6tyXlFZFr8QhtRt8W3knRyMJ4Tc9JcFHqcz/pa+Lnt/f8iQq
 4wReCPvvYPJyu1BAMacSr5B2EZSXA37JKD0mugTF7+jDtSlXaJJh/UwW8m9MMo2mtyQt
 5gvLNx64NieiKbp/MJ5GyeL49SUGl3Jx1cgqmS6uCnis8vg+wSsOlGE67DNYVwl59Xl2
 gsqM1Is0de5/RbQd8iySyoHkjju1EoHPDQFrtQqsiFobNCZgQUAVPZpm6pEt/9o8hbCl
 lcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2GCrUxZYOtcQM2fJBo0iB5JJDMdg3m+LR+Mf6ux91xY=;
 fh=1CYvNObfo4jq90HtGYf42Wh+iAUT/qO8Wac6PonGhMA=;
 b=O1HaEzNDk1uEjYLcn1mu3D6YOCVQGpScBhP6MoxkeD+BZeYLi1nOabOPtAYooRjVWP
 Yt25E7ApQHY8XeuXnme3Bk1rtMQloASifvgIHF7O3nyIBPkHAUqGCQKUJdafeya7VLfX
 CciIB0C+kqRMUlqDchr0vn76aw2u3VXZyGq0B7NdxkncfSUP/uHsRlldqjub3Jqha+7T
 hB5Chst22YyTM7KQ628uFKyLBGrfDUJFKrowrWocpixm8nQ5SBrL4mqDXYNKBBZ4snNb
 UaZ0qNLK+fOYALx4hDhX9CYRp9UbEY/PqugiVBWPxZW+Fb079XVDVQ8D7j5QGRgDNEag
 56HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771290235; x=1771895035; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2GCrUxZYOtcQM2fJBo0iB5JJDMdg3m+LR+Mf6ux91xY=;
 b=MzMfgIKK33yq8HQuHnr7/z5ox2zHblhOFZaOEoOvCK+NMH+vK9RFpg9MoSPPlCzK6k
 ktxovY39RpBIACCSVqttUNFYVYlmis5Fm84E8kpnwJs55IVGyGH101p8A9uEXpbKEUSs
 JvODlEBzaUt5t9AQpnvmXRv+lZhTjZAuAqc81mRDrKc2fTOI+gKt4El7LeYS1iXoEBhC
 3YRT3V8FaDUYX9NRg5VXZ7435jTTw7TBd9QF9Hy7YMlxHM/Wcj/rgIi0+KlViTWcBwVu
 w1tHKWt64f5prJ4xYNe+mFQJ9ZDLMuV7jRGmH7gcizYAB9jLFq/GXk0nsvKiOt4Fe+pO
 IdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771290235; x=1771895035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GCrUxZYOtcQM2fJBo0iB5JJDMdg3m+LR+Mf6ux91xY=;
 b=PbPfPfm1gTGyeZAjRkEnJ9pahY7afqNZr5p5ixsm7XYGG70IzG+WIebaoeMoqytlmq
 rLZeXfNLplcBc9rQewTHfSiDq7iNXQGOixJ1mouHNf2M6VEa8e8BzG+0DuYEy9RCbJgy
 KHlQeDoUzv0ftL9sqGV0SFVOlWXn4Zor1Q6OsYjAAxdLd4hfg4QcXoXxQft9uGtj7mLZ
 IK+IBXU+cWH47xXjz5ysv72IFIs/spq7crsrfUJMmGsS+M88juarnI8PwC2TPMvgK84e
 s5YGCWpOfGygoE+ItLkLYZ/gypJkgJj/0iJ4H494MW2/nLZXY2ygGVfO8ml2L4CkmoP3
 8cjw==
X-Gm-Message-State: AOJu0YwOmWg9vepr33iX1ltzojwC6jBHI4sbZ3pqGzX83khaRdMrV+ns
 yfye0GOLmze2DELk2RSFmTDZNRAnlt37lWNdzHYiXxCjiTLuV2aIudWInmkKFnxYx6KfZFX7xf2
 fxHcGiqxn6Wm2x40R5055j7kgoZvG3Ao=
X-Gm-Gg: AZuq6aLrNOLtLRhdjhqzOswThLvnLLpWrDxrKRHyJ5Rh+4DgfDW79h+RnBlJxFE+oA7
 yCYbG/PvfrjuotlPRKKR2/SVY/BtYsMpSxnaRbNOCt8Qy/vWV9rAHUOyK4PO7SA77gC4tomGLM3
 F8k/9bT/g9xsWEFjAKLT6l61HWQIPYrbDgI0uV8HdvafvInqfJE+Jcn21sk8mClhv4k1QoKkcKc
 MEDpoRSu7Znjg/JrxTNe4eT/KE31we5Zjky7e1mXg8bTzaAULCX3os3v9AuJNxrSRdctvBOQdbI
 irk1+Xr2kziyp2LyINyScJqEtJOCym1CLqjqjww=
X-Received: by 2002:a17:90b:4b0a:b0:356:282e:7eb7 with SMTP id
 98e67ed59e1d1-356a777f41dmr13555099a91.12.1771290235194; Mon, 16 Feb 2026
 17:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
 <20260215220422.212249-7-ltaylorsimpson@gmail.com>
 <aZM2v8J4RP7RgB_u@hive.localdomain>
In-Reply-To: <aZM2v8J4RP7RgB_u@hive.localdomain>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Feb 2026 18:03:44 -0700
X-Gm-Features: AaiRm53g0Sny9JRHn8vm5ISr83uvsJ8mCWFh6V4PWWA9N_dIsQzMQzNsGhPzeWQ
Message-ID: <CAATN3Nr9Jo3uZO9+uD=-W2_Mw5WhzdZOa=5obhEY6N9=mcagXQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] Hexagon (target/hexagon) Disassembly of invalid
 packets
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org, 
 philmd@linaro.org, ale@rev.ng
Content-Type: multipart/alternative; boundary="000000000000434feb064afaa551"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000434feb064afaa551
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 9:00=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote=
:

> On 15/02/26, Taylor Simpson wrote:
> > We pass the Hexagon CPU version to disassemble_hexagon.  This allows
> > decode_packet to know if the opcodes are supported.
> >
> > Note that we print valid instructions in a packet when one or more is
> > invalid.  Rather than this
> > 0x0002128c:  0x1eae4fec       {       <invalid>
> > 0x00021290:  0x1c434c04               <invalid>
> > 0x00021294:  0x1e03edf0               <invalid> }
> >
> > We print this
> > 0x0002128c:  0x1eae4fec       {       <invalid>
> > 0x00021290:  0x1c434c04               V4.w =3D vadd(V12.w,V3.w)
> > 0x00021294:  0x1e03edf0               V16 =3D V13 }
> >
> > Co-authored-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> > Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  target/hexagon/cpu_bits.h  |  4 +++-
> >  target/hexagon/printinsn.h |  3 ++-
> >  disas/hexagon.c            |  3 ++-
> >  target/hexagon/cpu.c       |  3 +++
> >  target/hexagon/decode.c    | 22 ++++++++++++++++++----
> >  target/hexagon/printinsn.c |  9 +++++++--
> >  6 files changed, 35 insertions(+), 9 deletions(-)
> >
> > diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> > index 19beca81c0..80d99f5df9 100644
> > --- a/target/hexagon/cpu_bits.h
> > +++ b/target/hexagon/cpu_bits.h
> > @@ -19,6 +19,7 @@
> >  #define HEXAGON_CPU_BITS_H
> >
> >  #include "qemu/bitops.h"
> > +#include "cpu-qom.h"
> >
> >  #define PCALIGN 4
> >  #define PCALIGN_MASK (PCALIGN - 1)
> > @@ -65,6 +66,7 @@ static inline bool is_packet_end(uint32_t endocing)
> >      return ((bits =3D=3D 0x3) || (bits =3D=3D 0x0));
> >  }
> >
> > -int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
> GString *buf);
> > +int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
> GString *buf,
> > +                        HexagonVersion hex_version);
> >
> >  #endif
> > diff --git a/target/hexagon/printinsn.h b/target/hexagon/printinsn.h
> > index 2ecd1731d0..d437d35005 100644
> > --- a/target/hexagon/printinsn.h
> > +++ b/target/hexagon/printinsn.h
> > @@ -18,10 +18,11 @@
> >  #ifndef HEXAGON_PRINTINSN_H
> >  #define HEXAGON_PRINTINSN_H
> >
> > +#include "cpu-qom.h"
> >  #include "insn.h"
> >
> >  void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
> > -                         target_ulong pc);
> > +                         target_ulong pc, HexagonVersion hex_version);
> >  void snprint_a_pkt_debug(GString *buf, Packet *pkt);
> >
> >  #endif
> > diff --git a/disas/hexagon.c b/disas/hexagon.c
> > index c1a4ffc5f6..9a18f12854 100644
> > --- a/disas/hexagon.c
> > +++ b/disas/hexagon.c
> > @@ -31,6 +31,7 @@
> >
> >  int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
> >  {
> > +    HexagonVersion hex_version =3D (HexagonVersion)info->target_info;
>
>
> Don't store the HexagonVersion directly in the pointer, clang gets
> angry, just take the address of hex_version
>
>   ../disas/hexagon.c:34:34: error: cast to smaller integer type
> 'HexagonVersion' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast=
]
>      34 |     HexagonVersion hex_version =3D
> (HexagonVersion)info->target_info;
>
>
Per my previous comment, I'll change it to "const HexagonCPUVersion *".


>
>
>
> >      uint32_t words[PACKET_WORDS_MAX];
> >      bool found_end =3D false;
> >      GString *buf;
> > @@ -58,7 +59,7 @@ int print_insn_hexagon(bfd_vma memaddr, struct
> disassemble_info *info)
> >      }
> >
> >      buf =3D g_string_sized_new(PACKET_BUFFER_LEN);
> > -    len =3D disassemble_hexagon(words, i, memaddr, buf);
> > +    len =3D disassemble_hexagon(words, i, memaddr, buf, hex_version);
> >      (*info->fprintf_func)(info->stream, "%s", buf->str);
> >      g_string_free(buf, true);
> >
> > diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> > index 09a0de3c2f..4b16214ace 100644
> > --- a/target/hexagon/cpu.c
> > +++ b/target/hexagon/cpu.c
> > @@ -314,8 +314,11 @@ static void hexagon_cpu_reset_hold(Object *obj,
> ResetType type)
> >  static void hexagon_cpu_disas_set_info(const CPUState *cs,
> >                                         disassemble_info *info)
> >  {
> > +    CPUState *cs_nonconst =3D (CPUState *)cs;  /* so we can get hex_cp=
u */
> > +    HexagonCPU *hex_cpu =3D env_archcpu(cpu_env(cs_nonconst));
> >      info->print_insn =3D print_insn_hexagon;
> >      info->endian =3D BFD_ENDIAN_LITTLE;
> > +    info->target_info =3D (void
> *)HEXAGON_CPU_GET_CLASS(hex_cpu)->hex_version;
> >  }
>
> Take the address of hex_version here.
>

Ditto.


>
> The const cast is a bit sad, took a look at other targets and riscv uses
> the object cast macros instead, so something like
>
>   static void hexagon_cpu_disas_set_info(const CPUState *cs,
>                                          disassemble_info *info)
>   {
>       const HexagonCPUClass *mcc =3D HEXAGON_CPU_GET_CLASS(cs);
>       ...
>       info->target_info =3D (void *)&mcc->hex_version;
>   }
>
> but I don't know if assuming Object * =3D=3D CPUState * =3D=3D ArchCPU * =
is any
> better..  Maybe someone else can comment on this.
>

Here is what riscv does
    const RISCVCPU *cpu =3D RISCV_CPU(s);
    const CPURISCVState *env =3D &cpu->env;

    info->target_info =3D &cpu->cfg;

So for Hexagon, it would be
    const HexagonCPU *cpu =3D HEXAGON_CPU(cs);
    info->target_info =3D HEXAGON_CPU_GET_CLASS(cpu)->hex_def;

--=20
> Anton Johansson
> rev.ng Labs Srl.
>

--000000000000434feb064afaa551
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 16,=
 2026 at 9:00=E2=80=AFAM Anton Johansson &lt;<a href=3D"mailto:anjo@rev.ng"=
>anjo@rev.ng</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 15/02/26, Taylor Simpson wrote:<br>
&gt; We pass the Hexagon CPU version to disassemble_hexagon.=C2=A0 This all=
ows<br>
&gt; decode_packet to know if the opcodes are supported.<br>
&gt; <br>
&gt; Note that we print valid instructions in a packet when one or more is<=
br>
&gt; invalid.=C2=A0 Rather than this<br>
&gt; 0x0002128c:=C2=A0 0x1eae4fec=C2=A0 =C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;invalid&gt;<br>
&gt; 0x00021290:=C2=A0 0x1c434c04=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;invalid&gt;<br>
&gt; 0x00021294:=C2=A0 0x1e03edf0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;invalid&gt; }<br>
&gt; <br>
&gt; We print this<br>
&gt; 0x0002128c:=C2=A0 0x1eae4fec=C2=A0 =C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0 =
=C2=A0 =C2=A0&lt;invalid&gt;<br>
&gt; 0x00021290:=C2=A0 0x1c434c04=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0V4.w =3D vadd(V12.w,V3.w)<br>
&gt; 0x00021294:=C2=A0 0x1e03edf0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0V16 =3D V13 }<br>
&gt; <br>
&gt; Co-authored-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:mathe=
us.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qu=
alcomm.com</a>&gt;<br>
&gt; Co-authored-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualco=
mm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/hexagon/cpu_bits.h=C2=A0 |=C2=A0 4 +++-<br>
&gt;=C2=A0 target/hexagon/printinsn.h |=C2=A0 3 ++-<br>
&gt;=C2=A0 disas/hexagon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 3 ++-<br>
&gt;=C2=A0 target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
&gt;=C2=A0 target/hexagon/decode.c=C2=A0 =C2=A0 | 22 ++++++++++++++++++----=
<br>
&gt;=C2=A0 target/hexagon/printinsn.c |=C2=A0 9 +++++++--<br>
&gt;=C2=A0 6 files changed, 35 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h<br>
&gt; index 19beca81c0..80d99f5df9 100644<br>
&gt; --- a/target/hexagon/cpu_bits.h<br>
&gt; +++ b/target/hexagon/cpu_bits.h<br>
&gt; @@ -19,6 +19,7 @@<br>
&gt;=C2=A0 #define HEXAGON_CPU_BITS_H<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/bitops.h&quot;<br>
&gt; +#include &quot;cpu-qom.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define PCALIGN 4<br>
&gt;=C2=A0 #define PCALIGN_MASK (PCALIGN - 1)<br>
&gt; @@ -65,6 +66,7 @@ static inline bool is_packet_end(uint32_t endocing)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ((bits =3D=3D 0x3) || (bits =3D=3D 0x0));<b=
r>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GStr=
ing *buf);<br>
&gt; +int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GStr=
ing *buf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 HexagonVersion hex_version);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/target/hexagon/printinsn.h b/target/hexagon/printinsn.h<b=
r>
&gt; index 2ecd1731d0..d437d35005 100644<br>
&gt; --- a/target/hexagon/printinsn.h<br>
&gt; +++ b/target/hexagon/printinsn.h<br>
&gt; @@ -18,10 +18,11 @@<br>
&gt;=C2=A0 #ifndef HEXAGON_PRINTINSN_H<br>
&gt;=C2=A0 #define HEXAGON_PRINTINSN_H<br>
&gt;=C2=A0 <br>
&gt; +#include &quot;cpu-qom.h&quot;<br>
&gt;=C2=A0 #include &quot;insn.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *wo=
rds,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0target_ulong pc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0target_ulong pc, HexagonVersion hex_version);<br>
&gt;=C2=A0 void snprint_a_pkt_debug(GString *buf, Packet *pkt);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/disas/hexagon.c b/disas/hexagon.c<br>
&gt; index c1a4ffc5f6..9a18f12854 100644<br>
&gt; --- a/disas/hexagon.c<br>
&gt; +++ b/disas/hexagon.c<br>
&gt; @@ -31,6 +31,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info =
*info)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 HexagonVersion hex_version =3D (HexagonVersion)info-&gt=
;target_info;<br>
<br>
<br>
Don&#39;t store the HexagonVersion directly in the pointer, clang gets<br>
angry, just take the address of hex_version<br>
<br>
=C2=A0 ../disas/hexagon.c:34:34: error: cast to smaller integer type &#39;H=
exagonVersion&#39; from &#39;const void *&#39; [-Werror,-Wvoid-pointer-to-e=
num-cast]<br>
=C2=A0 =C2=A0 =C2=A034 |=C2=A0 =C2=A0 =C2=A0HexagonVersion hex_version =3D =
(HexagonVersion)info-&gt;target_info;<br><br></blockquote><div><br></div><d=
iv>Per my previous comment, I&#39;ll change it to &quot;const HexagonCPUVer=
sion *&quot;.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t words[PACKET_WORDS_MAX];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool found_end =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GString *buf;<br>
&gt; @@ -58,7 +59,7 @@ int print_insn_hexagon(bfd_vma memaddr, struct disas=
semble_info *info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 buf =3D g_string_sized_new(PACKET_BUFFER_LEN);<br>
&gt; -=C2=A0 =C2=A0 len =3D disassemble_hexagon(words, i, memaddr, buf);<br=
>
&gt; +=C2=A0 =C2=A0 len =3D disassemble_hexagon(words, i, memaddr, buf, hex=
_version);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (*info-&gt;fprintf_func)(info-&gt;stream, &quot;%s=
&quot;, buf-&gt;str);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_string_free(buf, true);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c<br>
&gt; index 09a0de3c2f..4b16214ace 100644<br>
&gt; --- a/target/hexagon/cpu.c<br>
&gt; +++ b/target/hexagon/cpu.c<br>
&gt; @@ -314,8 +314,11 @@ static void hexagon_cpu_reset_hold(Object *obj, R=
esetType type)<br>
&gt;=C2=A0 static void hexagon_cpu_disas_set_info(const CPUState *cs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0disassemble_info *info)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs_nonconst =3D (CPUState *)cs;=C2=A0 /* so w=
e can get hex_cpu */<br>
&gt; +=C2=A0 =C2=A0 HexagonCPU *hex_cpu =3D env_archcpu(cpu_env(cs_nonconst=
));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;print_insn =3D print_insn_hexagon;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;endian =3D BFD_ENDIAN_LITTLE;<br>
&gt; +=C2=A0 =C2=A0 info-&gt;target_info =3D (void *)HEXAGON_CPU_GET_CLASS(=
hex_cpu)-&gt;hex_version;<br>
&gt;=C2=A0 }<br>
<br>
Take the address of hex_version here.<br></blockquote><div><br></div><div>D=
itto.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
The const cast is a bit sad, took a look at other targets and riscv uses<br=
>
the object cast macros instead, so something like<br>
<br>
=C2=A0 static void hexagon_cpu_disas_set_info(const CPUState *cs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di=
sassemble_info *info)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 const HexagonCPUClass *mcc =3D HEXAGON_CPU_GET_CLASS(c=
s);<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 info-&gt;target_info =3D (void *)&amp;mcc-&gt;hex_vers=
ion;<br>
=C2=A0 }<br>
<br>
but I don&#39;t know if assuming Object * =3D=3D CPUState * =3D=3D ArchCPU =
* is any<br>
better..=C2=A0 Maybe someone else can comment on this.<br></blockquote><div=
><br></div><div>Here is what riscv does</div><div>=C2=A0 =C2=A0 const RISCV=
CPU *cpu =3D RISCV_CPU(s);<br>=C2=A0 =C2=A0 const CPURISCVState *env =3D &a=
mp;cpu-&gt;env;<br><br>=C2=A0 =C2=A0 info-&gt;target_info =3D &amp;cpu-&gt;=
cfg;</div><div><br></div><div>So for Hexagon, it would be</div><div>=C2=A0 =
=C2=A0 const HexagonCPU *cpu =3D HEXAGON_CPU(cs);<br>=C2=A0 =C2=A0 info-&gt=
;target_info =3D HEXAGON_CPU_GET_CLASS(cpu)-&gt;hex_def;</div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
Anton Johansson<br>
rev.ng Labs Srl.<br>
</blockquote></div></div>

--000000000000434feb064afaa551--

