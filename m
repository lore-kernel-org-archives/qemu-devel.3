Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D2DE83847
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 00:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs9DS-0001iv-AK; Mon, 16 Feb 2026 19:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vs9DG-0001iE-CO
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 19:45:16 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vs9DC-0001Xk-FH
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 19:45:12 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so1902724a91.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 16:45:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771289108; cv=none;
 d=google.com; s=arc-20240605;
 b=ExmOaiE9o94hJWPUuqwyIxxXC31Ls1Yl6zTA57I6IkFNYP+97/0jYjVuRrdNoeMJUu
 G016N3zNFQrdIP9sYEo2MrBbjUDrKGydkDlETOc/y/4iriQPA3UNM680s546sWCws0fY
 u+CNQeUiJrANkg7Hnn3Bnt9kj+UXQbroxuzZmb91zDjNBD3OApPki+k19gYAPYREQHYX
 Eyi7FvcdXt5xOtYMy++HRJazbg42N3vle+bAFwb1QdahvtRj4SZBPXg3lw2dEE8tRRB8
 Xn8qwmKfl0PcYYMEk7uxkboaHUGcS/BIVTtH78SyVR9laKaXo9/tin4TNEcfv83NXbDY
 cj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v5FI7CAAdE4lwiZemwN1IPXV/9S2M/aQKCB4WrhaCD8=;
 fh=1CYvNObfo4jq90HtGYf42Wh+iAUT/qO8Wac6PonGhMA=;
 b=XYNDKcN2J74/1BX8bS6OwZ4FXOIkqzoRDNd3IVH9NFfuqFZMV9vPImlKVeOvQDDQcn
 hQ6Y3M2EldEad0KNg6faVAUoCPxrMal6wWWvRhOg/YJQKtImFOU38YE+zGvtUrVYYqrX
 Bcs6R8oDsSsJswood1bORuup2/LSJbLJ7/0tmMVHhU/qN2KNnFckNBBUS0Ss7ugPLu3o
 xAklJcCAq/W9DWy7gWoYT3GHrsm2cmzc97wrZFkYTqouMeh6SIIpDs3Gao4N8uVK8Ux4
 bG5JoclQ0bCNLlJgeTkAGwM0vKfBKnXDo2Lpw1iwD50F8H4veNhwcLERVOF0TB1Mtpz/
 MA1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771289108; x=1771893908; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v5FI7CAAdE4lwiZemwN1IPXV/9S2M/aQKCB4WrhaCD8=;
 b=eTB3kKlxqTsFDeBFfAEz2dDvz8u3lLW+EpVzyKeEwujwg9ij3DKS3v1Ic8czWy1xtt
 qhwsZ49Z+8hbE+EMwXcJXCxr7PfCodE/QE8nx2ynSUJArGDPIqGsgNHPzZdJ15Pn7xTL
 C3J/d0QAc7b68GbIOzEKUIaBgAmIGGGLCOx6Ih6ewF+nbTGqanWBd1S02PUGsxXa/QAS
 Gare3ZKxaFFJe3j23ukZkkJJYcJmyP7JXS+Y6q/OeBhjM7V2Ixaqh1vIVhb+rrSAbcfV
 HV+sVrJb9CzCwO55wTBI06peFer9+EtR59AkR29QI8bTdAjsP/hbPr2G7sQIN0CaTfW6
 Sxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771289108; x=1771893908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5FI7CAAdE4lwiZemwN1IPXV/9S2M/aQKCB4WrhaCD8=;
 b=wMUN1o5qYvSrBlyte+K/4BF2K0+sL3okk+EtvtyjcDdX5MjQI79z+CfQ8nnAvte73G
 T79OrXODr8kvOr2aB0qs3n793ZrFUC2D3Hf1g/QuBVxJfdxsSGQZB7lge1K4laEfxfuz
 6Obj5nJ73xogbpIWeFSvPXMQiwJtx1rCs2Y/05Ym6nu80vH8FJnOaHjJykTb3eoPU2BR
 ttAb8mKv+7OaOlFXyD0c2F7TTPMLXMnYZ3K/GIIZlW7ym19I2e9xHm4LcoODKNiku6Me
 I4E2nPAw315VG6DbOJcLbOamxCdylRYtEEmY55v+pYSbYfxd1aZDEXn+wOCwB7shWG8l
 MlSA==
X-Gm-Message-State: AOJu0YzrpzeeMTgr4J9kULxEzepJpE1pPtDD1uQBvCOrdDRm+6gpS/FC
 NDJI9W9/GIO+0aDz35S17znfhZDY6JANF37tWElz9LKUZDM925OviY3CSys+b1JvgloM9r0MIEl
 kpCtlCVzTKF/AxktlyQbMu9Vam05QvdM=
X-Gm-Gg: AZuq6aLCIXxa3C/oN7OvtObXNf+Gsb/tUd0wNH7w/1mKtOvkYKZ9/kLp7JiPWEX7HVt
 SrbVOVxK1vgiJsDb3RF6tY5b7FkQC4boy3JZd1eMeBrGWCNaYlO01zocfOpmI5YpBwR2cnmo+gz
 OjEPuM+6LT8DttNXGume9SsCu+gSzn0BMLuEqtGebbUWnCMmR/bl4h6AZ28NXUpGf9DaBUHJ7hI
 W+tAkF0QuE2GFXu1B2RRfRpvEHZF6FA9Op196iWBwcAqOjEN+y2cT9Jk+IB4OJB3dQLtOxm8DBm
 Fg7p4L+HoQDSJ5rsW9I6PaXdGYjjGEvFsVTTuAE=
X-Received: by 2002:a17:90b:4d86:b0:341:315:f4ed with SMTP id
 98e67ed59e1d1-356aabcbd11mr9648829a91.10.1771289108486; Mon, 16 Feb 2026
 16:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
 <20260215220422.212249-2-ltaylorsimpson@gmail.com>
 <aZMoaxVW2U7BokDu@hive.localdomain>
In-Reply-To: <aZMoaxVW2U7BokDu@hive.localdomain>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Feb 2026 17:44:57 -0700
X-Gm-Features: AaiRm50lrjYgY46FFLfg3g9iDfgsQqPLfS_-tYhYPOQAIZQ3ze5CuyFvXvdoosY
Message-ID: <CAATN3NqEDX6B9Z+uUiFfz-EuOwe=yT5vMmfR6C6UGrp=7Mpg7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] Hexagon (target/hexagon) Properly handle Hexagon
 CPU version
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org, 
 philmd@linaro.org, ale@rev.ng
Content-Type: multipart/alternative; boundary="0000000000001b1f42064afa6275"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102b.google.com
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

--0000000000001b1f42064afa6275
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 8:01=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote=
:

> On 15/02/26, Taylor Simpson wrote:
> > Add the following CPU versions that were previously missing
> >     v5
> >     v55
> >     v60
> >     v61
> >     v62
> >     v65
> >
> > Create an enum with the known Hexagon CPU versions
> > Add a field to HexagonCPUClass to note the Hexagon CPU version
> >
> > Co-authored-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> > Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  target/hexagon/cpu-qom.h | 23 +++++++++++++++++++++++
> >  target/hexagon/cpu.h     |  2 ++
> >  target/hexagon/cpu.c     | 28 ++++++++++++++++++++++------
> >  3 files changed, 47 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
> > index 0b149bd5fe..d2f98c683a 100644
> > --- a/target/hexagon/cpu-qom.h
> > +++ b/target/hexagon/cpu-qom.h
> > @@ -11,11 +11,34 @@
> >
> >  #include "hw/core/cpu.h"
> >
> > +typedef enum {
> > +    HEX_VER_NONE =3D 0x00,
> > +    HEX_VER_V5 =3D 0x04,
> > +    HEX_VER_V55 =3D 0x05,
> > +    HEX_VER_V60 =3D 0x60,
> > +    HEX_VER_V61 =3D 0x61,
> > +    HEX_VER_V62 =3D 0x62,
> > +    HEX_VER_V65 =3D 0x65,
> > +    HEX_VER_V66 =3D 0x66,
> > +    HEX_VER_V67 =3D 0x67,
> > +    HEX_VER_V68 =3D 0x68,
> > +    HEX_VER_V69 =3D 0x69,
> > +    HEX_VER_V71 =3D 0x71,
> > +    HEX_VER_V73 =3D 0x73,
> > +    HEX_VER_ANY =3D 0xff,
> > +} HexagonVersion;
> > +
> >  #define TYPE_HEXAGON_CPU "hexagon-cpu"
> >
> >  #define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
> >  #define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
> >
> > +#define TYPE_HEXAGON_CPU_V5 HEXAGON_CPU_TYPE_NAME("v5")
> > +#define TYPE_HEXAGON_CPU_V55 HEXAGON_CPU_TYPE_NAME("v55")
> > +#define TYPE_HEXAGON_CPU_V60 HEXAGON_CPU_TYPE_NAME("v60")
> > +#define TYPE_HEXAGON_CPU_V61 HEXAGON_CPU_TYPE_NAME("v61")
> > +#define TYPE_HEXAGON_CPU_V62 HEXAGON_CPU_TYPE_NAME("v62")
> > +#define TYPE_HEXAGON_CPU_V65 HEXAGON_CPU_TYPE_NAME("v65")
> >  #define TYPE_HEXAGON_CPU_V66 HEXAGON_CPU_TYPE_NAME("v66")
> >  #define TYPE_HEXAGON_CPU_V67 HEXAGON_CPU_TYPE_NAME("v67")
> >  #define TYPE_HEXAGON_CPU_V68 HEXAGON_CPU_TYPE_NAME("v68")
> > diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> > index 85afd59277..2b8e761c4d 100644
> > --- a/target/hexagon/cpu.h
> > +++ b/target/hexagon/cpu.h
> > @@ -117,6 +117,8 @@ typedef struct HexagonCPUClass {
> >
> >      DeviceRealize parent_realize;
> >      ResettablePhases parent_phases;
> > +
> > +    HexagonVersion hex_version;
> >  } HexagonCPUClass;
> >
> >  struct ArchCPU {
> > diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> > index 58a22ee41f..09a0de3c2f 100644
> > --- a/target/hexagon/cpu.c
> > +++ b/target/hexagon/cpu.c
> > @@ -27,12 +27,22 @@
> >  #include "exec/gdbstub.h"
> >  #include "accel/tcg/cpu-ops.h"
> >
> > -static void hexagon_v66_cpu_init(Object *obj) { }
> > -static void hexagon_v67_cpu_init(Object *obj) { }
> > -static void hexagon_v68_cpu_init(Object *obj) { }
> > -static void hexagon_v69_cpu_init(Object *obj) { }
> > -static void hexagon_v71_cpu_init(Object *obj) { }
> > -static void hexagon_v73_cpu_init(Object *obj) { }
> > +#define HEX_CPU_INIT(NAME, VER) \
> > +static void hexagon_##NAME##_cpu_init(Object *obj) \
> > +{ HEXAGON_CPU_GET_CLASS(obj)->hex_version =3D VER; }
> > +
> > +HEX_CPU_INIT(v5, HEX_VER_V5)
> > +HEX_CPU_INIT(v55, HEX_VER_V55)
> > +HEX_CPU_INIT(v60, HEX_VER_V60)
> > +HEX_CPU_INIT(v61, HEX_VER_V61)
> > +HEX_CPU_INIT(v62, HEX_VER_V62)
> > +HEX_CPU_INIT(v65, HEX_VER_V65)
> > +HEX_CPU_INIT(v66, HEX_VER_V66)
> > +HEX_CPU_INIT(v67, HEX_VER_V67)
> > +HEX_CPU_INIT(v68, HEX_VER_V68)
> > +HEX_CPU_INIT(v69, HEX_VER_V69)
> > +HEX_CPU_INIT(v71, HEX_VER_V71)
> > +HEX_CPU_INIT(v73, HEX_VER_V73)
> >
> >  static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
> >  {
> > @@ -395,6 +405,12 @@ static const TypeInfo hexagon_cpu_type_infos[] =3D=
 {
> >          .class_size =3D sizeof(HexagonCPUClass),
> >          .class_init =3D hexagon_cpu_class_init,
> >      },
> > +    DEFINE_CPU(TYPE_HEXAGON_CPU_V5,               hexagon_v5_cpu_init)=
,
> > +    DEFINE_CPU(TYPE_HEXAGON_CPU_V55,              hexagon_v55_cpu_init=
),
> > +    DEFINE_CPU(TYPE_HEXAGON_CPU_V60,              hexagon_v60_cpu_init=
),
> > +    DEFINE_CPU(TYPE_HEXAGON_CPU_V61,              hexagon_v61_cpu_init=
),
> > +    DEFINE_CPU(TYPE_HEXAGON_CPU_V62,              hexagon_v62_cpu_init=
),
> > +    DEFINE_CPU(TYPE_HEXAGON_CPU_V65,              hexagon_v65_cpu_init=
),
> >      DEFINE_CPU(TYPE_HEXAGON_CPU_V66,              hexagon_v66_cpu_init=
),
> >      DEFINE_CPU(TYPE_HEXAGON_CPU_V67,              hexagon_v67_cpu_init=
),
> >      DEFINE_CPU(TYPE_HEXAGON_CPU_V68,              hexagon_v68_cpu_init=
),
> > --
> > 2.43.0
> >
>
> Hi,
>
> IMO adding a HexagonCPUDef struct and using TypeInfo::class_data,
> similar to RISCV/SPARC, is a neater approach and easier to extend
> if you plan to add more model-specific configuration options at
> some point.  So something like
>
>   /* cpu.h */
>
>   struct HexagonCPUDef {
>       HexagonVersion version;
>   };
>
>   struct HexagonCPUClass {
>       ...
>       const HexagonCPUDef *def;
>   };
>
>   /* cpu.c */
>
>   static void hexagon_cpu_class_base_init(ObjectClass *c, const void *dat=
a)
>   {
>       HexagonCPUClass *mcc =3D HEXAGON_CPU_CLASS(c);
>       /* Make sure all CPU models define a HexagonCPUDef */
>       g_assert(!object_class_is_abstract(c) && data !=3D NULL);
>       if (data) {
>

Don't need this check given the assert above.


>           mcc->def =3D data;
>       }
>   }
>
>   #define DEFINE_CPU(type_name, version)         \
>       {                                          \
>           .name =3D type_name,                     \
>           .parent =3D TYPE_HEXAGON_CPU,            \
>           .class_data =3D &(const HexagonCPUDef) { \
>               .version =3D version,                \
>           },                                     \
>       }
>
>   static const TypeInfo hexagon_cpu_type_infos[] =3D {
>       {
>           .name =3D TYPE_HEXAGON_CPU,
>           .parent =3D TYPE_CPU,
>           .instance_size =3D sizeof(HexagonCPU),
>           .instance_align =3D __alignof(HexagonCPU),
>           .instance_init =3D hexagon_cpu_init,
>           .abstract =3D true,
>           .class_size =3D sizeof(HexagonCPUClass),
>           .class_init =3D hexagon_cpu_class_init,
>           .class_base_init =3D hexagon_cpu_class_base_init,
>       },
>       DEFINE_CPU(TYPE_HEXAGON_CPU_V5,               HEX_VER_V5),
>       DEFINE_CPU(TYPE_HEXAGON_CPU_V55,              HEX_VER_V55),
>       ...
>   };
>
> and this way you don't need the HEX_CPU_INIT() macros.
>
> --
> Anton Johansson
> rev.ng Labs Srl.
>

Thanks, that makes sense.  I will make the change.

In addition, we should use "const HexagonCPUDef *" instead of
HexagonVersion in DisasContext and pass it to the various functions that
need it.

Taylor

--0000000000001b1f42064afa6275
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 16,=
 2026 at 8:01=E2=80=AFAM Anton Johansson &lt;<a href=3D"mailto:anjo@rev.ng"=
>anjo@rev.ng</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 15/02/26, Taylor Simpson wrote:<br>
&gt; Add the following CPU versions that were previously missing<br>
&gt;=C2=A0 =C2=A0 =C2=A0v5<br>
&gt;=C2=A0 =C2=A0 =C2=A0v55<br>
&gt;=C2=A0 =C2=A0 =C2=A0v60<br>
&gt;=C2=A0 =C2=A0 =C2=A0v61<br>
&gt;=C2=A0 =C2=A0 =C2=A0v62<br>
&gt;=C2=A0 =C2=A0 =C2=A0v65<br>
&gt; <br>
&gt; Create an enum with the known Hexagon CPU versions<br>
&gt; Add a field to HexagonCPUClass to note the Hexagon CPU version<br>
&gt; <br>
&gt; Co-authored-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:mathe=
us.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qu=
alcomm.com</a>&gt;<br>
&gt; Co-authored-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualco=
mm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/hexagon/cpu-qom.h | 23 +++++++++++++++++++++++<br>
&gt;=C2=A0 target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0| 28 +++++++++++++++++++=
+++------<br>
&gt;=C2=A0 3 files changed, 47 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h<br>
&gt; index 0b149bd5fe..d2f98c683a 100644<br>
&gt; --- a/target/hexagon/cpu-qom.h<br>
&gt; +++ b/target/hexagon/cpu-qom.h<br>
&gt; @@ -11,11 +11,34 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt;=C2=A0 <br>
&gt; +typedef enum {<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_NONE =3D 0x00,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V5 =3D 0x04,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V55 =3D 0x05,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V60 =3D 0x60,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V61 =3D 0x61,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V62 =3D 0x62,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V65 =3D 0x65,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V66 =3D 0x66,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V67 =3D 0x67,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V68 =3D 0x68,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V69 =3D 0x69,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V71 =3D 0x71,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_V73 =3D 0x73,<br>
&gt; +=C2=A0 =C2=A0 HEX_VER_ANY =3D 0xff,<br>
&gt; +} HexagonVersion;<br>
&gt; +<br>
&gt;=C2=A0 #define TYPE_HEXAGON_CPU &quot;hexagon-cpu&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define HEXAGON_CPU_TYPE_SUFFIX &quot;-&quot; TYPE_HEXAGON_CPU<b=
r>
&gt;=C2=A0 #define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFI=
X)<br>
&gt;=C2=A0 <br>
&gt; +#define TYPE_HEXAGON_CPU_V5 HEXAGON_CPU_TYPE_NAME(&quot;v5&quot;)<br>
&gt; +#define TYPE_HEXAGON_CPU_V55 HEXAGON_CPU_TYPE_NAME(&quot;v55&quot;)<b=
r>
&gt; +#define TYPE_HEXAGON_CPU_V60 HEXAGON_CPU_TYPE_NAME(&quot;v60&quot;)<b=
r>
&gt; +#define TYPE_HEXAGON_CPU_V61 HEXAGON_CPU_TYPE_NAME(&quot;v61&quot;)<b=
r>
&gt; +#define TYPE_HEXAGON_CPU_V62 HEXAGON_CPU_TYPE_NAME(&quot;v62&quot;)<b=
r>
&gt; +#define TYPE_HEXAGON_CPU_V65 HEXAGON_CPU_TYPE_NAME(&quot;v65&quot;)<b=
r>
&gt;=C2=A0 #define TYPE_HEXAGON_CPU_V66 HEXAGON_CPU_TYPE_NAME(&quot;v66&quo=
t;)<br>
&gt;=C2=A0 #define TYPE_HEXAGON_CPU_V67 HEXAGON_CPU_TYPE_NAME(&quot;v67&quo=
t;)<br>
&gt;=C2=A0 #define TYPE_HEXAGON_CPU_V68 HEXAGON_CPU_TYPE_NAME(&quot;v68&quo=
t;)<br>
&gt; diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h<br>
&gt; index 85afd59277..2b8e761c4d 100644<br>
&gt; --- a/target/hexagon/cpu.h<br>
&gt; +++ b/target/hexagon/cpu.h<br>
&gt; @@ -117,6 +117,8 @@ typedef struct HexagonCPUClass {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 DeviceRealize parent_realize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ResettablePhases parent_phases;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 HexagonVersion hex_version;<br>
&gt;=C2=A0 } HexagonCPUClass;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct ArchCPU {<br>
&gt; diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c<br>
&gt; index 58a22ee41f..09a0de3c2f 100644<br>
&gt; --- a/target/hexagon/cpu.c<br>
&gt; +++ b/target/hexagon/cpu.c<br>
&gt; @@ -27,12 +27,22 @@<br>
&gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt;=C2=A0 #include &quot;accel/tcg/cpu-ops.h&quot;<br>
&gt;=C2=A0 <br>
&gt; -static void hexagon_v66_cpu_init(Object *obj) { }<br>
&gt; -static void hexagon_v67_cpu_init(Object *obj) { }<br>
&gt; -static void hexagon_v68_cpu_init(Object *obj) { }<br>
&gt; -static void hexagon_v69_cpu_init(Object *obj) { }<br>
&gt; -static void hexagon_v71_cpu_init(Object *obj) { }<br>
&gt; -static void hexagon_v73_cpu_init(Object *obj) { }<br>
&gt; +#define HEX_CPU_INIT(NAME, VER) \<br>
&gt; +static void hexagon_##NAME##_cpu_init(Object *obj) \<br>
&gt; +{ HEXAGON_CPU_GET_CLASS(obj)-&gt;hex_version =3D VER; }<br>
&gt; +<br>
&gt; +HEX_CPU_INIT(v5, HEX_VER_V5)<br>
&gt; +HEX_CPU_INIT(v55, HEX_VER_V55)<br>
&gt; +HEX_CPU_INIT(v60, HEX_VER_V60)<br>
&gt; +HEX_CPU_INIT(v61, HEX_VER_V61)<br>
&gt; +HEX_CPU_INIT(v62, HEX_VER_V62)<br>
&gt; +HEX_CPU_INIT(v65, HEX_VER_V65)<br>
&gt; +HEX_CPU_INIT(v66, HEX_VER_V66)<br>
&gt; +HEX_CPU_INIT(v67, HEX_VER_V67)<br>
&gt; +HEX_CPU_INIT(v68, HEX_VER_V68)<br>
&gt; +HEX_CPU_INIT(v69, HEX_VER_V69)<br>
&gt; +HEX_CPU_INIT(v71, HEX_VER_V71)<br>
&gt; +HEX_CPU_INIT(v73, HEX_VER_V73)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_mo=
del)<br>
&gt;=C2=A0 {<br>
&gt; @@ -395,6 +405,12 @@ static const TypeInfo hexagon_cpu_type_infos[] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size =3D sizeof(HexagonCPUCla=
ss),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D hexagon_cpu_class_in=
it,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V5,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hexagon_v5_cpu_init),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V55,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_v55_cpu_init),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V60,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_v60_cpu_init),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V61,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_v61_cpu_init),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V62,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_v62_cpu_init),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V65,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_v65_cpu_init),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V66,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_v66_cpu_init),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V67,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_v67_cpu_init),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V68,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_v68_cpu_init),<br>
&gt; -- <br>
&gt; 2.43.0<br>
&gt; <br>
<br>
Hi,<br>
<br>
IMO adding a HexagonCPUDef struct and using TypeInfo::class_data,<br>
similar to RISCV/SPARC, is a neater approach and easier to extend<br>
if you plan to add more model-specific configuration options at<br>
some point.=C2=A0 So something like<br>
<br>
=C2=A0 /* cpu.h */<br>
<br>
=C2=A0 struct HexagonCPUDef {<br>
=C2=A0 =C2=A0 =C2=A0 HexagonVersion version;<br>
=C2=A0 };<br>
<br>
=C2=A0 struct HexagonCPUClass {<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 const HexagonCPUDef *def;<br>
=C2=A0 };<br>
<br>
=C2=A0 /* cpu.c */<br>
<br>
=C2=A0 static void hexagon_cpu_class_base_init(ObjectClass *c, const void *=
data)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 HexagonCPUClass *mcc =3D HEXAGON_CPU_CLASS(c);<br>
=C2=A0 =C2=A0 =C2=A0 /* Make sure all CPU models define a HexagonCPUDef */<=
br>
=C2=A0 =C2=A0 =C2=A0 g_assert(!object_class_is_abstract(c) &amp;&amp; data =
!=3D NULL);<br>
=C2=A0 =C2=A0 =C2=A0 if (data) {<br></blockquote><div><br></div><div>Don&#3=
9;t need this check given the assert above.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mcc-&gt;def =3D data;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 }<br>
<br>
=C2=A0 #define DEFINE_CPU(type_name, version)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D type_name,=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_HEXAGON_CPU,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_data =3D &amp;(const HexagonCPUDe=
f) { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .version =3D version,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 static const TypeInfo hexagon_cpu_type_infos[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_HEXAGON_CPU,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_CPU,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(HexagonCPU),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_align =3D __alignof(HexagonCPU=
),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D hexagon_cpu_init,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size =3D sizeof(HexagonCPUClass),=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D hexagon_cpu_class_init,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_base_init =3D hexagon_cpu_class_b=
ase_init,<br>
=C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V5,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HEX_VER_V5),<br>
=C2=A0 =C2=A0 =C2=A0 DEFINE_CPU(TYPE_HEXAGON_CPU_V55,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 HEX_VER_V55),<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 };<br>
<br>
and this way you don&#39;t need the HEX_CPU_INIT() macros.<br>
<br>
-- <br>
Anton Johansson<br>
rev.ng Labs Srl.<br></blockquote><div><br></div><div>Thanks, that makes sen=
se.=C2=A0 I will make the change.</div><div><br></div><div>In addition, we =
should use &quot;const HexagonCPUDef *&quot; instead of HexagonVersion in D=
isasContext and pass it to the various functions that need it.</div><div><b=
r></div><div>Taylor</div><div><br></div></div></div>

--0000000000001b1f42064afa6275--

