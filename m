Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5542BC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyZvH-0002KP-PX; Mon, 24 Aug 2026 15:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wyZvF-0002Jx-BF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:01:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wyZvC-000256-BF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 15:01:29 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so693264166b.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787598084; cv=none;
 d=google.com; s=arc-20260327;
 b=p9Go5kYZEcG5wPCj3sjT5HORB4IyqeLADC69QuEorhs9AwpLdLDydpMUvxXQNqajhz
 gOOF+NT1/WnscKj+HkhsS8eAgR1QEbSeFxdnU7hwL07txoaWGmXeW+ao/O8+RwRX/0gu
 MzON4fZDoOPXqngWhQrwAhU8JZvS2olmZgV3ieuX4wxnvwCqqp7vojafa51YWq8P5nsH
 CpiwS2j89H+8acwrZNjOIbDNeuegGVzuMPICxGe1u2eVnIrcSzYKL1ENmfyMsyNzWrIg
 rG4pG6Y/2OcOz6aNvVCCT89bdrAA4K0eFSQgdl6jlYteAfbsqjZC9uPeDUlAGP+uNXLK
 ubAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JYgmYKSBzpHjuILPXZy2t6dnqI+P7ctsDprRPK/PISw=;
 fh=U+gPunCadylYwWuJXQyIApXFNCiyehfSfCYRAw8NMtI=;
 b=ICin3FXShzqomg+pPpBxPhl01BiQQ2aJGUZMYmeAneCbrtnm8LiR0+K32nZqhtzxAx
 +R3wBwkEWE81x1zhjPkxNV2EjAfWTClJhX7k6VsOXQ/4Zdjf4YnH5j8nfYCMlbnIY/jf
 cprQm2nVeb4/IklIurgi4BZsasG84ECgQnSziAaICbM1VqcTNXUM5qmZ9dVJDYVKUdbV
 l3HVqfXE5jFuFZyWBUCyqymHIuiW/gE7qlDuNjyO1Lsj7uLFJgiTLqovxKisMAUzoAS5
 fJloAw1gAx54Igj46RMplBGoL+D/aQPtzDE/uWX8WjhLTZCYhOxV0snIg6t1m8kYIdg2
 2pqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787598084; x=1788202884; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JYgmYKSBzpHjuILPXZy2t6dnqI+P7ctsDprRPK/PISw=;
 b=gwqCatvKgPBfpqHJjk88KEIdCRtNddjZJCYcJ/BW6uoQeDPmFrKFzbHG5KfJf8w/ab
 oxVPlbyxR2sg+P7C1HviFEoS54r98F7/RMHnf9SOW5jCUg0qWB+f8XNISHuikN4tzuUr
 w53S6IYhOC1zuu9SSNkD2MtWDjpt9iLPUG+hqipjgCkXtN+C1Sfz/LkTNoXoMB96mQEo
 WtcwEUNEhcKPOa8Ikfy9Can9p0vF+GYZrKRWPpsiT93iAqw1V89ir69PHIjZwKbzljXj
 EbIEBYmhxHQ6/z9fCw/5cogS0uiIOeW6oxtwJ3fzQhIlFp9jsaEt78a4cNMUFO1K+nxq
 amyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787598084; x=1788202884;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JYgmYKSBzpHjuILPXZy2t6dnqI+P7ctsDprRPK/PISw=;
 b=RSgnI+e9A4GvfAhNcmpR4Y+OIXBjZ1oGOAIN+ur+BDQhwNAA2exWMHw5i9gUmDLkxL
 C9i/hWQOk4OPvfx4iKfdblnEqoYiEdSdqo7dUX3OirhaJmv6sNEZshQiDxamRqMXebTW
 Q2zwhTHK6Mx4mVtBQUjyQdOXP3onlHhFvGspDg3yHxMXnZVlpKjExLNLo1dpS05sQV5D
 EwRs5c5SgA64RKqeVf4eORXGokguNYBvZxFbV1BQM+29WSkKc2Z3rKS9YhvWxD/NH5Dy
 zJDdy/7gaY7ijVKTwdZbKPhvoZBm6NF+jn017E8klIU7YeSdD84qLsuc3Hq+aH6KPixr
 oSUg==
X-Gm-Message-State: AFuF++l2PFIpTIiSKWJWyIwcptRq8A1nD2hnZoiqpmMelCZUtiyQD4vE
 Ry+2c/lHPI1rIfz+aQUpEiGYNG71Xrb9YdpZ2TpATO6opJV6aspMPOL4T3kxy9M0AnAKWP/pce2
 mb1y9zNyDGIM4+eX267zv4bwSEAhkAKQ=
X-Gm-Gg: AR+sD12Jxa5emj2YmtWo75TkLqwKousW5VT1cX4d1QzC46xbJL4rrAtm/5+NlpxXiNJ
 h7urUpDW2DvRFqKjGzmzTOKB6d+OzQGuRYEfb1sHWn5rMpcU1drMP1li7YnCxfszbdly7CBlQcp
 hGHVhkGOVloOOsP1YB//2MOVY5bbJdoB/fcBm9ot45pKS1QqAtgcLvLEVMgOPNQw19p5fWOvV5a
 abChyTL33lfSWCkfUZrOL6JqLUvK3LXAuxIjYdcchrWlNR2CLX7hzu98nxD7hzK2Tpth3kj8WBU
 nJsI2WCaB9PclW5YsA2zUGobVNoJrvkbr6qxaoS0bJ5K
X-Received: by 2002:a17:907:a0c9:b0:c20:3402:bd35 with SMTP id
 a640c23a62f3a-c24925e3909mr1983709466b.12.1787598083923; Mon, 24 Aug 2026
 12:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-10-luoyonggang@gmail.com>
 <9b5a4586-be66-4d69-8d08-fc1796336b2c@oss.qualcomm.com>
In-Reply-To: <9b5a4586-be66-4d69-8d08-fc1796336b2c@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 25 Aug 2026 03:01:11 +0800
X-Gm-Features: AcwNN1U0qAGghu7cfUXwy87iQ4Gt_W5EKZ_MKmbl9dTsifq_Hfbm_BdIRLkLefI
Message-ID: <CAE2XoE99hEfbdKEqW-kF7YLeSatPGe0v-Azb9TMXa-sm31TyWg@mail.gmail.com>
Subject: Re: [PATCH 09/12] target-info: register le and be TargetInfo variants
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>, 
 Alistair Francis <alistair.francis@wdc.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: multipart/alternative; boundary="000000000000cb25200659cf9cf0"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62f.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000cb25200659cf9cf0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 12:22=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 8/23/2026 8:07 AM, Yonggang Luo wrote:
> > - Register target-info-<name>-le and -be from one system
> >   target-info-def.c unit, sharing arch fields.
> > - Mark is_default from TARGET_BIG_ENDIAN so riscv/arm stay LE and
> >   ppc/s390x stay BE when -target is omitted.
> > - Pick the unique default in target_info_qom_set_target() when more
> >   than one TargetInfo is registered. Leave user-mode as a single
> >   target_info().
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  include/qemu/target-info-impl.h |  6 ++++
> >  include/qemu/target-info-init.h | 29 +++++++++++++---
> >  target-info-def.c               | 61 +++++++++++++++++++++++++--------
> >  target-info-qom.c               | 33 ++++++++++++++----
> >  4 files changed, 104 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/qemu/target-info-impl.h
b/include/qemu/target-info-impl.h
> > index de329ec2b86..b4222e4455e 100644
> > --- a/include/qemu/target-info-impl.h
> > +++ b/include/qemu/target-info-impl.h
> > @@ -23,6 +23,12 @@ typedef struct TargetInfo {
> >      const char *cpu_type;
> >      /* related to TARGET_BIG_ENDIAN definition */
> >      EndianMode endianness;
> > +    /*
> > +     * True on the endian variant that matches this translation unit's
> > +     * TARGET_BIG_ENDIAN. target_info_qom_set_target() uses this when
> > +     * more than one TargetInfo is registered and -target is omitted.
> > +     */
> > +    bool is_default;
> >      /*
> >       * runtime equivalent of
> >       *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY :
TARGET_PAGE_BITS
> > diff --git a/include/qemu/target-info-init.h
b/include/qemu/target-info-init.h
> > index b7024c9faef..25d00adcc66 100644
> > --- a/include/qemu/target-info-init.h
> > +++ b/include/qemu/target-info-init.h
> > @@ -37,15 +37,34 @@ const TargetInfo *target_info(void)     \
> >  #include "qemu/target-info-qom.h"
> >  #include "qom/object.h"
> >
> > -#define target_info_init(ti_var)
     \
> > -static const TypeInfo target_info_qom_target_type_info =3D {
     \
> > -    .name =3D  TYPE_TARGET_INFO"-"TARGET_NAME,
     \
> > +/*
> > + * QOM type names are target-info-<TARGET_NAME>-le and -be so both
> > + * endian variants can be registered from one system translation unit.
> > + */
> > +#define TARGET_INFO_QOM_SUFFIX_0 "-le"
> > +#define TARGET_INFO_QOM_SUFFIX_1 "-be"
> > +
> > +#define TARGET_INFO_QOM_NAME(sel)
      \
> > +    TYPE_TARGET_INFO "-" TARGET_NAME glue(TARGET_INFO_QOM_SUFFIX_, sel=
)
> > +
> > +#define TARGET_INFO_QOM_TYPEINFO(ti_var, sel)
      \
> > +static const TypeInfo glue(target_info_qom_type_, sel) =3D {
     \
> > +    .name =3D TARGET_INFO_QOM_NAME(sel),
     \
> >      .parent =3D TYPE_TARGET_INFO,
      \
> >      .instance_size =3D sizeof(TargetInfoQom),
      \
> >      .class_size =3D sizeof(TargetInfoQomClass),
      \
> >      .class_data =3D &ti_var,
     \
> > -};
     \
> > -DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
> > +}
> > +
> > +#define target_info_init_le_be(ti_le, ti_be)
     \
> > +TARGET_INFO_QOM_TYPEINFO(ti_le, 0);
      \
> > +TARGET_INFO_QOM_TYPEINFO(ti_be, 1);
      \
> > +static void do_qemu_init_target_info(void)
     \
> > +{
      \
> > +    type_register_static(&target_info_qom_type_0);
     \
> > +    type_register_static(&target_info_qom_type_1);
     \
> > +}
      \
> > +module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
> >
> >  #endif /* CONFIG_USER_ONLY */
> >  #endif /* COMPILING_PER_TARGET */
> > diff --git a/target-info-def.c b/target-info-def.c
> > index 5d38e405735..6722c43a08f 100644
> > --- a/target-info-def.c
> > +++ b/target-info-def.c
> > @@ -28,39 +28,72 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) !=3D
sizeof(CPUState));
> >  QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
> >  #endif
> >
> > -static const TargetInfo target_info_def =3D {
> > -    .target_name =3D TARGET_NAME,
> > -    .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
> > -    .long_bits =3D TARGET_LONG_BITS,
> > -    .cpu_type =3D CPU_RESOLVING_TYPE,
> > -    .endianness =3D TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG :
ENDIAN_MODE_LITTLE,
> >  #ifdef TARGET_PAGE_BITS_VARY
> > -    .page_bits_vary =3D true,
> >  # ifdef TARGET_PAGE_BITS_LEGACY
> > +#  define TARGET_INFO_PAGE_BITS \
> > +    .page_bits_vary =3D true, \
> >      .page_bits_init =3D TARGET_PAGE_BITS_LEGACY,
> > +# else
> > +#  define TARGET_INFO_PAGE_BITS \
> > +    .page_bits_vary =3D true,
> >  # endif
> >  #else
> > -    .page_bits_vary =3D false,
> > +# define TARGET_INFO_PAGE_BITS \
> > +    .page_bits_vary =3D false, \
> >      .page_bits_init =3D TARGET_PAGE_BITS,
> >  #endif
> >
> >  #ifndef CONFIG_USER_ONLY
> >  # ifdef CONFIG_MULTIPROCESS
> > -    .config_multiprocess =3D true,
> > +#  define TARGET_INFO_CONFIG_MULTIPROCESS .config_multiprocess =3D tru=
e,
> >  # else
> > -    .config_multiprocess =3D false,
> > +#  define TARGET_INFO_CONFIG_MULTIPROCESS .config_multiprocess =3D fal=
se,
> >  # endif
> >  # ifdef CONFIG_NITRO
> > -    .config_nitro =3D true,
> > +#  define TARGET_INFO_CONFIG_NITRO .config_nitro =3D true,
> >  # else
> > -    .config_nitro =3D false,
> > +#  define TARGET_INFO_CONFIG_NITRO .config_nitro =3D false,
> >  # endif
> >  # ifdef CONFIG_XEN
> > -    .config_xen =3D true,
> > +#  define TARGET_INFO_CONFIG_XEN .config_xen =3D true,
> >  # else
> > -    .config_xen =3D false,
> > +#  define TARGET_INFO_CONFIG_XEN .config_xen =3D false,
> >  # endif
> > +# define TARGET_INFO_CONFIG \
> > +    TARGET_INFO_CONFIG_MULTIPROCESS \
> > +    TARGET_INFO_CONFIG_NITRO \
> > +    TARGET_INFO_CONFIG_XEN
> > +#else
> > +# define TARGET_INFO_CONFIG
> >  #endif
> > +
> > +#define TARGET_INFO_COMMON
     \
> > +    .target_name =3D TARGET_NAME,
      \
> > +    .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
     \
> > +    .long_bits =3D TARGET_LONG_BITS,
     \
> > +    .cpu_type =3D CPU_RESOLVING_TYPE,
      \
> > +    TARGET_INFO_PAGE_BITS
      \
> > +    TARGET_INFO_CONFIG
> > +
> > +#ifdef CONFIG_USER_ONLY
> > +static const TargetInfo target_info_def =3D {
> > +    TARGET_INFO_COMMON
> > +    .endianness =3D TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG :
ENDIAN_MODE_LITTLE,
> >  };
> >
> >  target_info_init(target_info_def)
> > +#else
> > +static const TargetInfo target_info_le =3D {
> > +    TARGET_INFO_COMMON
> > +    .endianness =3D ENDIAN_MODE_LITTLE,
> > +    .is_default =3D !TARGET_BIG_ENDIAN,
> > +};
> > +
> > +static const TargetInfo target_info_be =3D {
> > +    TARGET_INFO_COMMON
> > +    .endianness =3D ENDIAN_MODE_BIG,
> > +    .is_default =3D TARGET_BIG_ENDIAN,
> > +};
> > +
> > +target_info_init_le_be(target_info_le, target_info_be)
> > +#endif
> > diff --git a/target-info-qom.c b/target-info-qom.c
> > index 68ad734049c..2c1c57b05fd 100644
> > --- a/target-info-qom.c
> > +++ b/target-info-qom.c
> > @@ -90,13 +90,34 @@ const TargetInfo *target_info(void)
> >  void target_info_qom_set_target(void)
> >  {
> >      g_autoptr(GSList) targets =3D
object_class_get_list(TYPE_TARGET_INFO, false);
> > -
> > +    const TargetInfo *chosen =3D NULL;
> >      size_t num_found =3D g_slist_length(targets);
> > -    if (num_found !=3D 1) {
> > -        error_setg(&error_fatal, num_found =3D=3D 0 ?
> > -                                 "no target-info is available" :
> > -                                 "more than one target-info is
available");
> > +    size_t num_default =3D 0;
> > +
> > +    if (num_found =3D=3D 0) {
> > +        error_setg(&error_fatal, "no target-info is available");
> > +    }
> > +
> > +    if (num_found =3D=3D 1) {
> > +        target_info_ptr =3D
TARGET_INFO_CLASS(targets->data)->target_info;
> > +        return;
> > +    }
> > +
> > +    for (GSList *l =3D targets; l; l =3D l->next) {
> > +        const TargetInfo *ti =3D TARGET_INFO_CLASS(l->data)->target_in=
fo;
> > +
> > +        if (ti->is_default) {
> > +            num_default++;
> > +            chosen =3D ti;
> > +        }
> > +    }
> > +
> > +    if (num_default !=3D 1) {
> > +        error_setg(&error_fatal, num_default =3D=3D 0 ?
> > +                                 "no default target-info is available"
:
> > +                                 "more than one default target-info "
> > +                                 "is available");
> >      }
> >
> > -    target_info_ptr =3D TARGET_INFO_CLASS(targets->data)->target_info;
> > +    target_info_ptr =3D chosen;
> >  }
>
> Is it representing existing targets, or adding new ones per endianness?
> I'm not sure if the goal is to add new binaries, or mimic existing ones
> with specific parameters.


Is optional now, not a force requirement, this is needed when we use GDB
debug qemu riscv-be, as gdbstub are depends on target_info


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000cb25200659cf9cf0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Aug 25, 2026 at 12:22=E2=80=AFAM Pierrick =
Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.b=
ouvier@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; On 8/23/2026 8:07 AM=
, Yonggang Luo wrote:<br>&gt; &gt; - Register target-info-&lt;name&gt;-le a=
nd -be from one system<br>&gt; &gt; =C2=A0 target-info-def.c unit, sharing =
arch fields.<br>&gt; &gt; - Mark is_default from TARGET_BIG_ENDIAN so riscv=
/arm stay LE and<br>&gt; &gt; =C2=A0 ppc/s390x stay BE when -target is omit=
ted.<br>&gt; &gt; - Pick the unique default in target_info_qom_set_target()=
 when more<br>&gt; &gt; =C2=A0 than one TargetInfo is registered. Leave use=
r-mode as a single<br>&gt; &gt; =C2=A0 target_info().<br>&gt; &gt;<br>&gt; =
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0includ=
e/qemu/target-info-impl.h | =C2=A06 ++++<br>&gt; &gt; =C2=A0include/qemu/ta=
rget-info-init.h | 29 +++++++++++++---<br>&gt; &gt; =C2=A0target-info-def.c=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 61 ++++++++++++++++++++=
+++++--------<br>&gt; &gt; =C2=A0target-info-qom.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 33 ++++++++++++++----<br>&gt; &gt; =C2=A04 files=
 changed, 104 insertions(+), 25 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff=
 --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h<=
br>&gt; &gt; index de329ec2b86..b4222e4455e 100644<br>&gt; &gt; --- a/inclu=
de/qemu/target-info-impl.h<br>&gt; &gt; +++ b/include/qemu/target-info-impl=
.h<br>&gt; &gt; @@ -23,6 +23,12 @@ typedef struct TargetInfo {<br>&gt; &gt;=
 =C2=A0 =C2=A0 =C2=A0const char *cpu_type;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0/* related to TARGET_BIG_ENDIAN definition */<br>&gt; &gt; =C2=A0 =C2=A0=
 =C2=A0EndianMode endianness;<br>&gt; &gt; + =C2=A0 =C2=A0/*<br>&gt; &gt; +=
 =C2=A0 =C2=A0 * True on the endian variant that matches this translation u=
nit&#39;s<br>&gt; &gt; + =C2=A0 =C2=A0 * TARGET_BIG_ENDIAN. target_info_qom=
_set_target() uses this when<br>&gt; &gt; + =C2=A0 =C2=A0 * more than one T=
argetInfo is registered and -target is omitted.<br>&gt; &gt; + =C2=A0 =C2=
=A0 */<br>&gt; &gt; + =C2=A0 =C2=A0bool is_default;<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0/*<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 * runtime equivalent of<br>&=
gt; &gt; =C2=A0 =C2=A0 =C2=A0 * =C2=A0 TARGET_PAGE_BITS_VARY ? TARGET_PAGE_=
BITS_LEGACY : TARGET_PAGE_BITS<br>&gt; &gt; diff --git a/include/qemu/targe=
t-info-init.h b/include/qemu/target-info-init.h<br>&gt; &gt; index b7024c9f=
aef..25d00adcc66 100644<br>&gt; &gt; --- a/include/qemu/target-info-init.h<=
br>&gt; &gt; +++ b/include/qemu/target-info-init.h<br>&gt; &gt; @@ -37,15 +=
37,34 @@ const TargetInfo *target_info(void) =C2=A0 =C2=A0 \<br>&gt; &gt; =
=C2=A0#include &quot;qemu/target-info-qom.h&quot;<br>&gt; &gt; =C2=A0#inclu=
de &quot;qom/object.h&quot;<br>&gt; &gt; <br>&gt; &gt; -#define target_info=
_init(ti_var) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; -static const TypeInfo target_info_qom_t=
arget_type_info =3D { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>&gt; &gt; - =C2=A0 =C2=A0.name =3D =C2=A0TYPE_TARGET_INFO&qu=
ot;-&quot;TARGET_NAME, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; +=
/*<br>&gt; &gt; + * QOM type names are target-info-&lt;TARGET_NAME&gt;-le a=
nd -be so both<br>&gt; &gt; + * endian variants can be registered from one =
system translation unit.<br>&gt; &gt; + */<br>&gt; &gt; +#define TARGET_INF=
O_QOM_SUFFIX_0 &quot;-le&quot;<br>&gt; &gt; +#define TARGET_INFO_QOM_SUFFIX=
_1 &quot;-be&quot;<br>&gt; &gt; +<br>&gt; &gt; +#define TARGET_INFO_QOM_NAM=
E(sel) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>&gt; &gt; + =C2=A0 =C2=A0TYPE_TARGET_INFO &quot;-&quot; TARGET_=
NAME glue(TARGET_INFO_QOM_SUFFIX_, sel)<br>&gt; &gt; +<br>&gt; &gt; +#defin=
e TARGET_INFO_QOM_TYPEINFO(ti_var, sel) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>=
&gt; &gt; +static const TypeInfo glue(target_info_qom_type_, sel) =3D { =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; +=
 =C2=A0 =C2=A0.name =3D TARGET_INFO_QOM_NAME(sel), =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0.paren=
t =3D TYPE_TARGET_INFO, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0.instanc=
e_size =3D sizeof(TargetInfoQom), =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br=
>&gt; &gt; =C2=A0 =C2=A0 =C2=A0.class_size =3D sizeof(TargetInfoQomClass), =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0.class_d=
ata =3D &amp;ti_var, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; -}; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; -DEFINE_TARGET_INFO_TYPE(targ=
et_info_qom_target_type_info)<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt; +=
#define target_info_init_le_be(ti_le, ti_be) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>&gt; &gt; +TARGET_INFO_QOM_TYPEINFO(ti_le, 0); =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; +TARGET=
_INFO_QOM_TYPEINFO(ti_be, 1); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; +static void do_qemu_init_target_info(v=
oid) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; +{ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; + =C2=A0 =C2=A0type_register=
_static(&amp;target_info_qom_type_0); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; + =C2=
=A0 =C2=A0type_register_static(&amp;target_info_qom_type_1); =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>&gt; &gt; +} =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; =
+module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)<br>&gt; &gt=
; <br>&gt; &gt; =C2=A0#endif /* CONFIG_USER_ONLY */<br>&gt; &gt; =C2=A0#end=
if /* COMPILING_PER_TARGET */<br>&gt; &gt; diff --git a/target-info-def.c b=
/target-info-def.c<br>&gt; &gt; index 5d38e405735..6722c43a08f 100644<br>&g=
t; &gt; --- a/target-info-def.c<br>&gt; &gt; +++ b/target-info-def.c<br>&gt=
; &gt; @@ -28,39 +28,72 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) !=3D si=
zeof(CPUState));<br>&gt; &gt; =C2=A0QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS &lt;=
 TARGET_PAGE_BITS_MIN);<br>&gt; &gt; =C2=A0#endif<br>&gt; &gt; <br>&gt; &gt=
; -static const TargetInfo target_info_def =3D {<br>&gt; &gt; - =C2=A0 =C2=
=A0.target_name =3D TARGET_NAME,<br>&gt; &gt; - =C2=A0 =C2=A0.target_arch =
=3D glue(SYS_EMU_TARGET_, TARGET_ARCH),<br>&gt; &gt; - =C2=A0 =C2=A0.long_b=
its =3D TARGET_LONG_BITS,<br>&gt; &gt; - =C2=A0 =C2=A0.cpu_type =3D CPU_RES=
OLVING_TYPE,<br>&gt; &gt; - =C2=A0 =C2=A0.endianness =3D TARGET_BIG_ENDIAN =
? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,<br>&gt; &gt; =C2=A0#ifdef TARGET_PA=
GE_BITS_VARY<br>&gt; &gt; - =C2=A0 =C2=A0.page_bits_vary =3D true,<br>&gt; =
&gt; =C2=A0# ifdef TARGET_PAGE_BITS_LEGACY<br>&gt; &gt; +# =C2=A0define TAR=
GET_INFO_PAGE_BITS \<br>&gt; &gt; + =C2=A0 =C2=A0.page_bits_vary =3D true, =
\<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0.page_bits_init =3D TARGET_PAGE_BITS_LEG=
ACY,<br>&gt; &gt; +# else<br>&gt; &gt; +# =C2=A0define TARGET_INFO_PAGE_BIT=
S \<br>&gt; &gt; + =C2=A0 =C2=A0.page_bits_vary =3D true,<br>&gt; &gt; =C2=
=A0# endif<br>&gt; &gt; =C2=A0#else<br>&gt; &gt; - =C2=A0 =C2=A0.page_bits_=
vary =3D false,<br>&gt; &gt; +# define TARGET_INFO_PAGE_BITS \<br>&gt; &gt;=
 + =C2=A0 =C2=A0.page_bits_vary =3D false, \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0.page_bits_init =3D TARGET_PAGE_BITS,<br>&gt; &gt; =C2=A0#endif<br>&gt; =
&gt; <br>&gt; &gt; =C2=A0#ifndef CONFIG_USER_ONLY<br>&gt; &gt; =C2=A0# ifde=
f CONFIG_MULTIPROCESS<br>&gt; &gt; - =C2=A0 =C2=A0.config_multiprocess =3D =
true,<br>&gt; &gt; +# =C2=A0define TARGET_INFO_CONFIG_MULTIPROCESS .config_=
multiprocess =3D true,<br>&gt; &gt; =C2=A0# else<br>&gt; &gt; - =C2=A0 =C2=
=A0.config_multiprocess =3D false,<br>&gt; &gt; +# =C2=A0define TARGET_INFO=
_CONFIG_MULTIPROCESS .config_multiprocess =3D false,<br>&gt; &gt; =C2=A0# e=
ndif<br>&gt; &gt; =C2=A0# ifdef CONFIG_NITRO<br>&gt; &gt; - =C2=A0 =C2=A0.c=
onfig_nitro =3D true,<br>&gt; &gt; +# =C2=A0define TARGET_INFO_CONFIG_NITRO=
 .config_nitro =3D true,<br>&gt; &gt; =C2=A0# else<br>&gt; &gt; - =C2=A0 =
=C2=A0.config_nitro =3D false,<br>&gt; &gt; +# =C2=A0define TARGET_INFO_CON=
FIG_NITRO .config_nitro =3D false,<br>&gt; &gt; =C2=A0# endif<br>&gt; &gt; =
=C2=A0# ifdef CONFIG_XEN<br>&gt; &gt; - =C2=A0 =C2=A0.config_xen =3D true,<=
br>&gt; &gt; +# =C2=A0define TARGET_INFO_CONFIG_XEN .config_xen =3D true,<b=
r>&gt; &gt; =C2=A0# else<br>&gt; &gt; - =C2=A0 =C2=A0.config_xen =3D false,=
<br>&gt; &gt; +# =C2=A0define TARGET_INFO_CONFIG_XEN .config_xen =3D false,=
<br>&gt; &gt; =C2=A0# endif<br>&gt; &gt; +# define TARGET_INFO_CONFIG \<br>=
&gt; &gt; + =C2=A0 =C2=A0TARGET_INFO_CONFIG_MULTIPROCESS \<br>&gt; &gt; + =
=C2=A0 =C2=A0TARGET_INFO_CONFIG_NITRO \<br>&gt; &gt; + =C2=A0 =C2=A0TARGET_=
INFO_CONFIG_XEN<br>&gt; &gt; +#else<br>&gt; &gt; +# define TARGET_INFO_CONF=
IG<br>&gt; &gt; =C2=A0#endif<br>&gt; &gt; +<br>&gt; &gt; +#define TARGET_IN=
FO_COMMON =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; + =C2=A0 =C2=A0.target=
_name =3D TARGET_NAME, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; &gt; + =C2=A0 =C2=A0.target_arch =3D =
glue(SYS_EMU_TARGET_, TARGET_ARCH), =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; + =C2=A0 =C2=A0.long_b=
its =3D TARGET_LONG_BITS, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; &gt; + =C2=A0 =C2=A0.cpu_type =3D CPU_RES=
OLVING_TYPE, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>&gt; &gt; + =C2=A0 =C2=A0TARGET_INFO_PAGE_BITS =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>&gt; &gt; + =C2=A0 =C2=A0TARGET_INFO_CONFIG<br>&gt; &gt; +<=
br>&gt; &gt; +#ifdef CONFIG_USER_ONLY<br>&gt; &gt; +static const TargetInfo=
 target_info_def =3D {<br>&gt; &gt; + =C2=A0 =C2=A0TARGET_INFO_COMMON<br>&g=
t; &gt; + =C2=A0 =C2=A0.endianness =3D TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG =
: ENDIAN_MODE_LITTLE,<br>&gt; &gt; =C2=A0};<br>&gt; &gt; <br>&gt; &gt; =C2=
=A0target_info_init(target_info_def)<br>&gt; &gt; +#else<br>&gt; &gt; +stat=
ic const TargetInfo target_info_le =3D {<br>&gt; &gt; + =C2=A0 =C2=A0TARGET=
_INFO_COMMON<br>&gt; &gt; + =C2=A0 =C2=A0.endianness =3D ENDIAN_MODE_LITTLE=
,<br>&gt; &gt; + =C2=A0 =C2=A0.is_default =3D !TARGET_BIG_ENDIAN,<br>&gt; &=
gt; +};<br>&gt; &gt; +<br>&gt; &gt; +static const TargetInfo target_info_be=
 =3D {<br>&gt; &gt; + =C2=A0 =C2=A0TARGET_INFO_COMMON<br>&gt; &gt; + =C2=A0=
 =C2=A0.endianness =3D ENDIAN_MODE_BIG,<br>&gt; &gt; + =C2=A0 =C2=A0.is_def=
ault =3D TARGET_BIG_ENDIAN,<br>&gt; &gt; +};<br>&gt; &gt; +<br>&gt; &gt; +t=
arget_info_init_le_be(target_info_le, target_info_be)<br>&gt; &gt; +#endif<=
br>&gt; &gt; diff --git a/target-info-qom.c b/target-info-qom.c<br>&gt; &gt=
; index 68ad734049c..2c1c57b05fd 100644<br>&gt; &gt; --- a/target-info-qom.=
c<br>&gt; &gt; +++ b/target-info-qom.c<br>&gt; &gt; @@ -90,13 +90,34 @@ con=
st TargetInfo *target_info(void)<br>&gt; &gt; =C2=A0void target_info_qom_se=
t_target(void)<br>&gt; &gt; =C2=A0{<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0g_auto=
ptr(GSList) targets =3D object_class_get_list(TYPE_TARGET_INFO, false);<br>=
&gt; &gt; -<br>&gt; &gt; + =C2=A0 =C2=A0const TargetInfo *chosen =3D NULL;<=
br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0size_t num_found =3D g_slist_length(target=
s);<br>&gt; &gt; - =C2=A0 =C2=A0if (num_found !=3D 1) {<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0error_setg(&amp;error_fatal, num_found =3D=3D 0 ?<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;no target-info i=
s available&quot; :<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;more than one target-info is available&quot;);<br>&gt; &gt; + =C2=A0 =
=C2=A0size_t num_default =3D 0;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0=
if (num_found =3D=3D 0) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0error_s=
etg(&amp;error_fatal, &quot;no target-info is available&quot;);<br>&gt; &gt=
; + =C2=A0 =C2=A0}<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if (num_found=
 =3D=3D 1) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0target_info_ptr =3D =
TARGET_INFO_CLASS(targets-&gt;data)-&gt;target_info;<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return;<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; +<br=
>&gt; &gt; + =C2=A0 =C2=A0for (GSList *l =3D targets; l; l =3D l-&gt;next) =
{<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0const TargetInfo *ti =3D TARGET=
_INFO_CLASS(l-&gt;data)-&gt;target_info;<br>&gt; &gt; +<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (ti-&gt;is_default) {<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_default++;<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0chosen =3D ti;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; +<br>&gt; &gt; + =C2=
=A0 =C2=A0if (num_default !=3D 1) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0error_setg(&amp;error_fatal, num_default =3D=3D 0 ?<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;no default target-info is availabl=
e&quot; :<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;more t=
han one default target-info &quot;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;is available&quot;);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0}=
<br>&gt; &gt; <br>&gt; &gt; - =C2=A0 =C2=A0target_info_ptr =3D TARGET_INFO_=
CLASS(targets-&gt;data)-&gt;target_info;<br>&gt; &gt; + =C2=A0 =C2=A0target=
_info_ptr =3D chosen;<br>&gt; &gt; =C2=A0}<br>&gt;<br>&gt; Is it representi=
ng existing targets, or adding new ones per endianness?<br>&gt; I&#39;m not=
 sure if the goal is to add new binaries, or mimic existing ones<br>&gt; wi=
th specific parameters.<br><br><br>Is optional now, not a force requirement=
, this is needed when we use GDB debug qemu riscv-be, as gdbstub are depend=
s on target_info<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=
=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0=
 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000cb25200659cf9cf0--

