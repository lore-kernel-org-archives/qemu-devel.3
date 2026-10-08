Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4297ECA6004
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 02:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEdYi-00054v-W3; Wed, 07 Oct 2026 22:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEdYX-00052L-7W
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:08:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEdYS-0006io-QI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:08:23 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6af9befd04cso6339707a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 19:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791425298; cv=none;
 d=google.com; s=arc-20260327;
 b=hKZKmU4jApDTD0nRxY1YiwF60GvcgeJWQ0H49qt/pYOH/Qk+FY5hHZ3OUCK7ujl2FX
 DrpXEeN/Ig/9q9FH8PzdVUueD1uFLZ8drrTtoep4m/nkghKl4EM7J7YR+JOiPpanpXhk
 bDmoVMCgcmPICC1SoIGgJ/fgqNjsD7vM2a7UGP5u1r89dxTqxIZ0nwhBfLQf//vB3MY1
 n0TRcSEKjuechCO+8ZUK/9m3qImCsY2w4SQdjPTY0twelRbzHGHqNA9ytVurGKJtedPO
 LQ4iDNdy9a2YJHwF77MafUTyIGTT0ZUHw+UdVbkdkCN0eFv62RUZy4GUkl32LbgF9Fur
 hNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qSrzfFb0X15GyzEAJXVEk07Y++jM+QdLCglM2n4l3QM=;
 fh=4/wcS88II3VX6Ye4PZnRAhk86dIgygccFhqjRWP+6KY=;
 b=sfXTyn0kp6681cjnuMjqMkz76YqP7OUyIra+OYLJzJuCtVOAiOw9+b+DULa3V2P+kW
 lOgXhIm8aMthRiXRFVgY3Xt99OkvV1E+AxD/OSs7bkIutZWghdplwhO1fKwqIpn9oPzh
 AH9IA7dlBGDoOvCEJskBUjnmxPBS3EI1d7pjNewXsosa2+u7JSP+w+DwKsiAnYdbmlB3
 MjxhHEd6u0a7Ujw0DCM1lNGMYJYMz+JYVhJFGq5+z1g8BsTIAFnVhuGDEy5QTKNSnifI
 alXyF/VNvCuTEZeAegZPMBXkzcCjJCH5+ZcX6vDiFQml69RmpLEn4waTdjNIMO1J0KME
 4YzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791425298; x=1792030098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qSrzfFb0X15GyzEAJXVEk07Y++jM+QdLCglM2n4l3QM=;
 b=nR0E6fGMNWCx9+mWPdFReisiKhBL7LGQN2LPfla8/33DCeamF0M7ZrUTLdB+iMsNBr
 3yq7gPj0Ame4wn5c2VI0HiogaiImG2LdU4DtkzgNpfJQTES3yze0N8mWpSedJtzkuzNl
 J6cJzhqVvrR5loFMWLx82+ksKMzCLtAOYq6rHepiXVWgiaBJsThVvfCdKDnkZ/pfNCaJ
 nM1RJv8il+oV/itnhIcI7riCSmzFxX6zLCPM4QEchqjAMugFdzXIgawmODPf76WcrP8m
 kTjHC4N1OiYVvyzhRdAJAQH3WuX2K0YXnYbLutHXgz+ZSjbcwUbiDwrJVnVUtJsxHe8g
 Lr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791425298; x=1792030098;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qSrzfFb0X15GyzEAJXVEk07Y++jM+QdLCglM2n4l3QM=;
 b=2J3odfMoTIJu/nDX0Ix/d4HduDwyOvo41qOuica+R+Ebc5VllYtlcaRNbcTDB1hbEW
 IjBxaFQf/FN3As9YiHu4qf9wS5VVHgeJYzNjIOZuKEuLL4AulQ+Ln9QABJfqd0vPmhsU
 hS3yn5mCckBBd5tkxF6X+qxWfZLqcweaFtpz5GcmRUMgqBe+WQm9JX609y4/5p038Yjr
 ip5NCZGp5GT/4BH18N63lmrKmN2yVZv2oRYP47D8Ajt+6ORUkFgSVOPOV2EGDsXFE+fg
 KktSt6aUiLjIWCYJM7IaQRp+1QE4cUBU+9Ksg22t6caV/V5ofz9UYBrS/sHgyz5/k0Wg
 3O/w==
X-Gm-Message-State: AFq9FYL9iT53Q5oOmAMMZZZzTH96G/JPZFw+6NnMzHDOQaWZ1RoXwyyM
 8KDWRwkLSbrZOxue/72orbiemyYVr6Be7meNCs+7UPr7FBw43EjaBfmb23AUezqhF3yg9FXFBIr
 kDt7gvANr7qBaRPT6XScT3PcYetjzwNQ=
X-Gm-Gg: AYBFou0579Ch3umXbd2bzP68pdJnGxD9no85BoWilfqpwH+/YbSi9F3kqjeJjWaXgAb
 /tCPZdjraXzUAtK27p36DgBYs56guQwMQo5LseeFQaYOEW4FOjeMVYkB/xMYL1S1Q5YWE9tOKYW
 jGOdmg7WCa4hWN9uhtLx1RKmIs/ckcGbDt2VA9eAxlq0XUhq68DIZp2cT4hdDw77lXo1WpxFKMG
 hsn8SIF0mCPnT6UDyCW6rMu5UUQsYXDyueXh+ZgpUl0Rab34WqSPrDUeCcPsjXBkwbciLXnnFvr
 tLfqRKIGJwXNeGYk8/8fG7CWqjIPiY4wv07/C4CEbmV2Ol9ZL1G6WI0=
X-Received: by 2002:a05:6402:1ece:b0:6ac:a828:c0cc with SMTP id
 4fb4d7f45d1cf-6aff27b0449mr4186874a12.4.1791425297440; Wed, 07 Oct 2026
 19:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-9-luoyonggang@gmail.com>
 <7fc0d377-a994-41f4-aa98-7ed56db11447@oss.qualcomm.com>
 <CAE2XoE8K+3e8h6H9NrPk1WWMmJfG807bN_Kh5qje-5pKWUUg5w@mail.gmail.com>
 <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
In-Reply-To: <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2026 10:08:04 +0800
X-Gm-Features: AclHuK_ka4Log0rcFdoI3Se7Wr5Boou6rb7bzwYDa0CeTBiNxl10Vr0RSYQJlJY
Message-ID: <CAE2XoE-qDvOUG2+1yTTvBUyBLxoxCPPy464KQVLgSFx+tuQ2XQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] qom: pass TargetInfo to is_available for later use
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 8, 2026 at 8:00=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/7/2026 2:42 PM, Yonggang Luo wrote:
> > On Thu, Oct 8, 2026 at 4:44=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> >>> Change TypeInfo.is_available to the new TypeIsAvailable type, which
> >>> takes a const TargetInfo *. Registration passes target_info(), so
> >>> behavior is unchanged. object.h only forward-declares TargetInfo.
> >>>
> >>> Switch the existing users (raspi, raspi4b, ast27x0 evb and fc) and th=
e
> >>> generated machine parents to the matching target_is_<arch> helpers.
> >>>
> >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>> ---
> >>>  hw/arm/aspeed_ast27x0-fc.c  |  2 +-
> >>>  hw/arm/aspeed_ast27x0_evb.c |  4 ++--
> >>>  hw/arm/raspi.c              |  4 ++--
> >>>  hw/arm/raspi4b.c            |  2 +-
> >>>  hw/arm/virt.c               |  4 ++--
> >>>  hw/m68k/virt.c              |  4 ++--
> >>>  hw/or1k/virt.c              |  2 +-
> >>>  include/qom/object.h        | 12 +++++++++++-
> >>>  qom/object.c                |  3 ++-
> >>>  9 files changed, 24 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> >>> index 73362b60d2a..8a7c6a116ac 100644
> >>> --- a/hw/arm/aspeed_ast27x0-fc.c
> >>> +++ b/hw/arm/aspeed_ast27x0-fc.c
> >>> @@ -234,7 +234,7 @@ static const TypeInfo ast2700fc_types[] =3D {
> >>>          .parent         =3D TYPE_MACHINE,
> >>>          .class_init     =3D ast2700fc_class_init,
> >>>          .instance_size  =3D sizeof(Ast2700FCState),
> >>> -        .is_available   =3D target_aarch64,
> >>> +        .is_available   =3D target_is_aarch64,
> >>>      },
> >>>  };
> >>>
> >>> diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.=
c
> >>> index 460c9ff0d2e..02a8cff1d9d 100644
> >>> --- a/hw/arm/aspeed_ast27x0_evb.c
> >>> +++ b/hw/arm/aspeed_ast27x0_evb.c
> >>> @@ -75,13 +75,13 @@ static const TypeInfo aspeed_ast27x0_evb_types[] =
=3D {
> >>>          .name          =3D MACHINE_TYPE_NAME("ast2700a1-evb"),
> >>>          .parent        =3D TYPE_ASPEED_MACHINE,
> >>>          .class_init    =3D aspeed_machine_ast2700a1_evb_class_init,
> >>> -        .is_available  =3D target_aarch64,
> >>> +        .is_available  =3D target_is_aarch64,
> >>>      },
> >>>      {
> >>>          .name          =3D MACHINE_TYPE_NAME("ast2700a2-evb"),
> >>>          .parent        =3D TYPE_ASPEED_MACHINE,
> >>>          .class_init    =3D aspeed_machine_ast2700a2_evb_class_init,
> >>> -        .is_available  =3D target_aarch64,
> >>> +        .is_available  =3D target_is_aarch64,
> >>>      }
> >>>  };
> >>>
> >>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> >>> index fadbacb2534..22b06c6ca22 100644
> >>> --- a/hw/arm/raspi.c
> >>> +++ b/hw/arm/raspi.c
> >>> @@ -403,12 +403,12 @@ static const TypeInfo raspi_machine_types[] =3D=
 {
> >>>          .name           =3D MACHINE_TYPE_NAME("raspi3ap"),
> >>>          .parent         =3D TYPE_RASPI_MACHINE,
> >>>          .class_init     =3D raspi3ap_machine_class_init,
> >>> -        .is_available   =3D target_aarch64,
> >>> +        .is_available   =3D target_is_aarch64,
> >>>      }, {
> >>>          .name           =3D MACHINE_TYPE_NAME("raspi3b"),
> >>>          .parent         =3D TYPE_RASPI_MACHINE,
> >>>          .class_init     =3D raspi3b_machine_class_init,
> >>> -        .is_available   =3D target_aarch64,
> >>> +        .is_available   =3D target_is_aarch64,
> >>>      }, {
> >>>          .name           =3D TYPE_RASPI_MACHINE,
> >>>          .parent         =3D TYPE_RASPI_BASE_MACHINE,
> >>> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> >>> index 566d64572db..a1dc477f25e 100644
> >>> --- a/hw/arm/raspi4b.c
> >>> +++ b/hw/arm/raspi4b.c
> >>> @@ -121,7 +121,7 @@ static const TypeInfo raspi4b_machine_type =3D {
> >>>      .parent         =3D TYPE_RASPI_BASE_MACHINE,
> >>>      .instance_size  =3D sizeof(Raspi4bMachineState),
> >>>      .class_init     =3D raspi4b_machine_class_init,
> >>> -    .is_available   =3D target_aarch64,
> >>> +    .is_available   =3D target_is_aarch64,
> >>>  };
> >>>
> >>>  static void raspi4b_machine_register_type(void)
> >>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >>> index 9d192515d85..18160f7fad3 100644
> >>> --- a/hw/arm/virt.c
> >>> +++ b/hw/arm/virt.c
> >>> @@ -132,7 +132,7 @@ static void arm_virt_compat_default_set(MachineCl=
ass *mc)
> >>>          .name =3D MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
> >>>          .parent =3D TYPE_VIRT_MACHINE, \
> >>>          .class_init =3D MACHINE_VER_SYM(class_init, virt, __VA_ARGS_=
_), \
> >>> -        .is_available =3D target_base_arm, \
> >>> +        .is_available =3D target_is_base_arm, \
> >>>      }; \
> >>>      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
> >>>      { \
> >>> @@ -4430,7 +4430,7 @@ static const TypeInfo virt_machine_info =3D {
> >>>           { TYPE_HOTPLUG_HANDLER },
> >>>           { }
> >>>      },
> >>> -    .is_available =3D target_base_arm,
> >>> +    .is_available =3D target_is_base_arm,
> >>>  };
> >>>
> >>>  static void machvirt_machine_init(void)
> >>> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> >>> index e52546e4fab..ad2a43ef3fb 100644
> >>> --- a/hw/m68k/virt.c
> >>> +++ b/hw/m68k/virt.c
> >>> @@ -327,7 +327,7 @@ static const TypeInfo virt_machine_info =3D {
> >>>      .parent       =3D TYPE_MACHINE,
> >>>      .abstract     =3D true,
> >>>      .class_init   =3D virt_machine_class_init,
> >>> -    .is_available =3D target_m68k,
> >>> +    .is_available =3D target_is_m68k,
> >>>  };
> >>>
> >>>  static void virt_machine_register_types(void)
> >>> @@ -355,7 +355,7 @@ type_init(virt_machine_register_types)
> >>>          .name =3D MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
> >>>          .parent =3D MACHINE_TYPE_NAME("virt"), \
> >>>          .class_init =3D MACHINE_VER_SYM(class_init, virt, __VA_ARGS_=
_), \
> >>> -        .is_available =3D target_m68k, \
> >>> +        .is_available =3D target_is_m68k, \
> >>>      }; \
> >>>      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
> >>>      { \
> >>> diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
> >>> index a3ff903839b..89fb786641f 100644
> >>> --- a/hw/or1k/virt.c
> >>> +++ b/hw/or1k/virt.c
> >>> @@ -559,7 +559,7 @@ static const TypeInfo or1ksim_machine_typeinfo =
=3D {
> >>>      .parent     =3D TYPE_MACHINE,
> >>>      .class_init =3D openrisc_virt_machine_init,
> >>>      .instance_size =3D sizeof(OR1KVirtState),
> >>> -    .is_available =3D target_or1k,
> >>> +    .is_available =3D target_is_or1k,
> >>>  };
> >>>
> >>>  static void or1ksim_machine_init_register_types(void)
> >>> diff --git a/include/qom/object.h b/include/qom/object.h
> >>> index 4c0645817a5..7d52a15f6b8 100644
> >>> --- a/include/qom/object.h
> >>> +++ b/include/qom/object.h
> >>> @@ -17,6 +17,7 @@
> >>>  #include "qapi/qapi-builtin-types.h"
> >>>  #include "qemu/module.h"
> >>>
> >>> +typedef struct TargetInfo TargetInfo;
> >>>  struct TypeImpl;
> >>>  typedef struct TypeImpl *Type;
> >>>
> >>> @@ -117,6 +118,15 @@ typedef void (ObjectUnparent)(Object *obj);
> >>>   */
> >>>  typedef void (ObjectFree)(void *obj);
> >>>
> >>> +/**
> >>> + * typedef TypeIsAvailable:
> >>> + * @ti: TargetInfo to test.
> >>> + *
> >>> + * Returns whether a type is available for @ti. Typical implementati=
ons
> >>> + * are target_is_*().
> >>> + */
> >>> +typedef bool (TypeIsAvailable)(const TargetInfo *ti);
> >>> +
> >>>  #define OBJECT_CLASS_CAST_CACHE 4
> >>>
> >>>  /**
> >>> @@ -498,7 +508,7 @@ struct TypeInfo
> >>>      void (*class_base_init)(ObjectClass *klass, const void *data);
> >>>      const void *class_data;
> >>>
> >>> -    bool (*is_available)(void);
> >>> +    TypeIsAvailable *is_available;
> >>>      const InterfaceInfo *interfaces;
> >>>  };
> >>>
> >>> diff --git a/qom/object.c b/qom/object.c
> >>> index 96498f3d001..253b9562b41 100644
> >>> --- a/qom/object.c
> >>> +++ b/qom/object.c
> >>> @@ -15,6 +15,7 @@
> >>>  #include "qom/compat-properties.h"
> >>>  #include "qom/object.h"
> >>>  #include "qom/object_interfaces.h"
> >>> +#include "qemu/target-info.h"
> >>>  #include "qemu/cutils.h"
> >>>  #include "qemu/memalign.h"
> >>>  #include "qapi/visitor.h"
> >>> @@ -167,7 +168,7 @@ static TypeImpl *type_register_internal(const Typ=
eInfo *info)
> >>>          abort();
> >>>      }
> >>>
> >>> -    if (info->is_available && !info->is_available()) {
> >>> +    if (info->is_available && !info->is_available(target_info())) {
> >>>          return NULL;
> >>>      }
> >>>
> >>
> >> ```
> >> info->is_available(target_info())
> >> ```
> >>
> >> or
> >>
> >> ```
> >> is_available() {
> >>   TargetInfo ti * =3D target_info();
> >>   ...
> >> }
> >> ```
> >>
> >> Are doing the exact same thing today.
> >>
> >> So what is the future goal requiring to introduce this?
> >
> > From Daniel P. Berrang=C3=A9's
> > requesthttps://lore.kernel.org/qemu-devel/apAszS1ewxM0Y1XU@redhat.com/
> >         I forgot to mention that this is also pretty important for maki=
ng
> >         introspection work, as we need to be able to say
> >
> >           'qemu-system --machine none -qmp ...'
> >
> >         and connect to QMP to introspect the binary. Having to add a
> >         '--target <name>' into that mix is undesirable, as it creates
> >         a chicken & egg problem. You don't know what targets are built
> >         into qemu-system without introspecting it and you can't
> >         introspect it without selecting a target to introspect.
> >
> > From Pierrick's review
> > https://lore.kernel.org/qemu-devel/557262df-b8e7-49b5-a245-ae46b8885b30=
@oss.qualcomm.com/So,
> > for existing binary: -M virt works as before.
> >
> >         For new multi binary:
> >         $ qemu-system -M virt:
> >         Multiple machines were found, select one among:
> >         - aarch64-virt
> >         - riscv64-virt
> >
> >         Does it matches what you would expect?
> >
> > From Daniel's review
> > https://lore.kernel.org/qemu-devel/aro93NuZBXYGbD33@redhat.com/
> >         We already have  'QemuTargetInfo' struct which is used
> >         with 'query-target', that should also be used with the
> >         new 'query-targets' command.
> >
> >         We need to add the 'endianness' field to QemuTargetInfo.
> >
> >         I don't think that we need to report machines though.
> >         We already have 'query-machines' which gives much broader
> >         information on the machines. "MachineInfo" needs to
> >         gain
> >
> >         "targets": ["SysEmuTarget"]
> >
> >         to list which target(s) a machine can be used with.
> >
> >
> > To achieve these, we needs add TypeInfo parameter to it so that we can =
do
> >
> > static void report_unsupported_machine_type(const char *name, Error **e=
rrp)
> > {
> >     g_autoptr(GSList) machines =3D machine_class_get_list(true);
> >     g_autoptr(GString) targets =3D g_string_new(NULL);
> >     TargetInfoNode *node;
> >     GSList *el;
> >
> >     error_setg(errp, "unsupported machine type: \"%s\" for target \"%s\=
"",
> >                name, target_name());
> >     QLIST_FOREACH(node, target_info_list(), next) {
> >         for (el =3D machines; el; el =3D el->next) {
> >             MachineClass *mc =3D el->data;
> >
> >             if ((!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)=
) &&
> >                 object_class_get_is_available(OBJECT_CLASS(mc))(node->i=
nfo)) {
> >                 g_string_append_printf(targets, "  %s\n",
> >                                        node->info->target_name);
> >                 break;
> >             }
> >         }
> >     }
> >     if (targets->len) {
> >         error_append_hint(errp, "Available for targets:\n%s", targets->=
str);
> >     }
> > }
> >
> > That is we can iterate on all target-list, and check if it's can be fit=
lered.
> >
>
> Ok, I finally see where this is going.
>
> So, based on all the previous conversations, we agreed to have a
> qemu-system binary with all the QOM types available (for all targets).
>
> I personally think that if we go this way, we should not have any
> -target option, and even less a -target none option.
>
> The current is_available() approach was made with filtering per target
> in mind, which predates where things are now. So, it's a good time to
> reevaluate how to do it.
>
> This leaves us with (at least) two options:
> - keep the callback and add TargetInfo parameter (what is done here)
> - remove is_available, and adopt a more declarative approach
>
> How about we (re)-explore the second one?

Indeed, I am doing

- preserve is_available(TargetInfo*), and adopt a more declarative approach

/* Generated by scripts/gen-target-info.py. Do not edit. */

static const TypeInfo target_machine_types[] =3D {
    {
        .name =3D TYPE_TARGET_BASE_ALPHA_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_alpha,
    },
    {
        .name =3D TYPE_TARGET_BASE_ARM_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_arm,
    },
    {
        .name =3D TYPE_TARGET_BASE_AVR_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_avr,
    },
    {
        .name =3D TYPE_TARGET_BASE_HEXAGON_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_hexagon,
    },
    {
        .name =3D TYPE_TARGET_BASE_HPPA_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_hppa,
    },
    {
        .name =3D TYPE_TARGET_BASE_I386_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_i386,
    },
    {
        .name =3D TYPE_TARGET_BASE_LOONGARCH_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_loongarch,
    },
    {
        .name =3D TYPE_TARGET_BASE_M68K_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_m68k,
    },
    {
        .name =3D TYPE_TARGET_BASE_MICROBLAZE_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_microblaze,
    },
    {
        .name =3D TYPE_TARGET_BASE_MIPS_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_mips,
    },
    {
        .name =3D TYPE_TARGET_BASE_NONE_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_none,
    },
    {
        .name =3D TYPE_TARGET_BASE_OR1K_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_or1k,
    },
    {
        .name =3D TYPE_TARGET_BASE_PPC_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_ppc,
    },
    {
        .name =3D TYPE_TARGET_BASE_RISCV_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_riscv,
    },
    {
        .name =3D TYPE_TARGET_BASE_RX_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_rx,
    },
    {
        .name =3D TYPE_TARGET_BASE_S390X_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_s390x,
    },
    {
        .name =3D TYPE_TARGET_BASE_SH4_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_sh4,
    },
    {
        .name =3D TYPE_TARGET_BASE_SPARC_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_sparc,
    },
    {
        .name =3D TYPE_TARGET_BASE_TRICORE_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_tricore,
    },
    {
        .name =3D TYPE_TARGET_BASE_XTENSA_MACHINE,
        .parent =3D TYPE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_base_xtensa,
    },
    {
        .name =3D TYPE_TARGET_ALPHA_MACHINE,
        .parent =3D TYPE_TARGET_BASE_ALPHA_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_alpha,
    },
    {
        .name =3D TYPE_TARGET_AARCH64_MACHINE,
        .parent =3D TYPE_TARGET_BASE_ARM_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_aarch64,
    },
    {
        .name =3D TYPE_TARGET_ARM_MACHINE,
        .parent =3D TYPE_TARGET_BASE_ARM_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_arm,
    },
    {
        .name =3D TYPE_TARGET_AVR_MACHINE,
        .parent =3D TYPE_TARGET_BASE_AVR_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_avr,
    },
    {
        .name =3D TYPE_TARGET_HEXAGON_MACHINE,
        .parent =3D TYPE_TARGET_BASE_HEXAGON_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_hexagon,
    },
    {
        .name =3D TYPE_TARGET_HPPA_MACHINE,
        .parent =3D TYPE_TARGET_BASE_HPPA_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_hppa,
    },
    {
        .name =3D TYPE_TARGET_I386_MACHINE,
        .parent =3D TYPE_TARGET_BASE_I386_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_i386,
    },
    {
        .name =3D TYPE_TARGET_X86_64_MACHINE,
        .parent =3D TYPE_TARGET_BASE_I386_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_x86_64,
    },
    {
        .name =3D TYPE_TARGET_LOONGARCH64_MACHINE,
        .parent =3D TYPE_TARGET_BASE_LOONGARCH_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_loongarch64,
    },
    {
        .name =3D TYPE_TARGET_M68K_MACHINE,
        .parent =3D TYPE_TARGET_BASE_M68K_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_m68k,
    },
    {
        .name =3D TYPE_TARGET_MICROBLAZE_MACHINE,
        .parent =3D TYPE_TARGET_BASE_MICROBLAZE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_microblaze,
    },
    {
        .name =3D TYPE_TARGET_MIPS_MACHINE,
        .parent =3D TYPE_TARGET_BASE_MIPS_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_mips,
    },
    {
        .name =3D TYPE_TARGET_MIPS64_MACHINE,
        .parent =3D TYPE_TARGET_BASE_MIPS_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_mips64,
    },
    {
        .name =3D TYPE_TARGET_MIPS64EL_MACHINE,
        .parent =3D TYPE_TARGET_BASE_MIPS_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_mips64el,
    },
    {
        .name =3D TYPE_TARGET_MIPSEL_MACHINE,
        .parent =3D TYPE_TARGET_BASE_MIPS_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_mipsel,
    },
    {
        .name =3D TYPE_TARGET_NONE_MACHINE,
        .parent =3D TYPE_TARGET_BASE_NONE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_none,
    },
    {
        .name =3D TYPE_TARGET_OR1K_MACHINE,
        .parent =3D TYPE_TARGET_BASE_OR1K_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_or1k,
    },
    {
        .name =3D TYPE_TARGET_PPC_MACHINE,
        .parent =3D TYPE_TARGET_BASE_PPC_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_ppc,
    },
    {
        .name =3D TYPE_TARGET_PPC64_MACHINE,
        .parent =3D TYPE_TARGET_BASE_PPC_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_ppc64,
    },
    {
        .name =3D TYPE_TARGET_RISCV32_MACHINE,
        .parent =3D TYPE_TARGET_BASE_RISCV_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_riscv32,
    },
    {
        .name =3D TYPE_TARGET_RISCV64_MACHINE,
        .parent =3D TYPE_TARGET_BASE_RISCV_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_riscv64,
    },
    {
        .name =3D TYPE_TARGET_RX_MACHINE,
        .parent =3D TYPE_TARGET_BASE_RX_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_rx,
    },
    {
        .name =3D TYPE_TARGET_S390X_MACHINE,
        .parent =3D TYPE_TARGET_BASE_S390X_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_s390x,
    },
    {
        .name =3D TYPE_TARGET_SH4_MACHINE,
        .parent =3D TYPE_TARGET_BASE_SH4_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_sh4,
    },
    {
        .name =3D TYPE_TARGET_SH4EB_MACHINE,
        .parent =3D TYPE_TARGET_BASE_SH4_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_sh4eb,
    },
    {
        .name =3D TYPE_TARGET_SPARC_MACHINE,
        .parent =3D TYPE_TARGET_BASE_SPARC_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_sparc,
    },
    {
        .name =3D TYPE_TARGET_SPARC64_MACHINE,
        .parent =3D TYPE_TARGET_BASE_SPARC_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_sparc64,
    },
    {
        .name =3D TYPE_TARGET_TRICORE_MACHINE,
        .parent =3D TYPE_TARGET_BASE_TRICORE_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_tricore,
    },
    {
        .name =3D TYPE_TARGET_XTENSA_MACHINE,
        .parent =3D TYPE_TARGET_BASE_XTENSA_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_xtensa,
    },
    {
        .name =3D TYPE_TARGET_XTENSAEB_MACHINE,
        .parent =3D TYPE_TARGET_BASE_XTENSA_MACHINE,
        .abstract =3D true,
        .is_available =3D target_is_xtensaeb,
    },
};
Other than these base machines, other machines are children of these
base machines.

See these changes
https://gitlab.com/lygstate-qemu/qemu/-/commit/c71da20c2483cdf577fd2a5548a8=
0ca1e5099676
https://gitlab.com/lygstate-qemu/qemu/-/commit/252b8763fd74ec57f5762bf9c57e=
19d8d9e5a146
https://gitlab.com/lygstate-qemu/qemu/-/commit/252b8763fd74ec57f5762bf9c57e=
19d8d9e5a146
https://gitlab.com/lygstate-qemu/qemu/-/commit/252b8763fd74ec57f5762bf9c57e=
19d8d9e5a146
For ARM:
https://gitlab.com/lygstate-qemu/qemu/-/commit/c42d5eb333fd3a7cab899c8df953=
75dfc79aba40

These base machine type is auto-generated in this MR.
You can see at the branch
https://gitlab.com/lygstate-qemu/qemu/-/commits/single-binary-arm-riscv?ref=
_type=3Dheads

And the inherit is done by commits
qom: inherit is_available and filter after MODULE_INIT_QOM:
https://gitlab.com/lygstate-qemu/qemu/-/commit/cb66474a36e03b4353c2f525ce78=
21f2af779ea1
qom: register late types through module_call_init_fn:
https://gitlab.com/lygstate-qemu/qemu/-/commit/ba6a3d3fb6e4bfe35d88d3845abf=
7b0ec8fbc337
module: add before/after hooks and module_call_init_fn:
https://gitlab.com/lygstate-qemu/qemu/-/commit/86c635f45e283b6d0f714a1a3a9d=
9521b17d5152

And the gitlab-ci is already passed


>
> It's what we did in the past
> (https://gitlab.com/qemu-project/qemu/-/commit/5de9216064d32eaac125dac4de=
1878486c16d73e),

Somewhat alike except I do not introduce many interface types. Just
base machine types.

> and that I removed recently, in favor of is_available.
> My rationale was that it was incomplete, since we needed to filter types
> per config also, and not only target.
> Now that direction is to not filter anything, filter per config is
> unneeded, and switching back to declarative instead of callback makes
> total sense. Using interfaces like we did has its own issues, and I
> would not like to see this coming back.
>
> I'll do one very concrete proposal:
>
> ```
> How about letting machines (and machines only first), have a new field
> 'targets', being a uint32_t mask with an array of EMU_TARGET?
> machine->targets =3D EMU_TARGET_X | EMU_TARGET_Y;
> ```

From my experience at
https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?=
ref_type=3Dheads
this is not enough, we still needs is_avaible, because for those
machines that binding to
KVM/WHPX and other accels, we need to use target_kconfig to handle
them. That's why I choose to use a unified
is_avaible(TargetInfo*).

This new field only works if is_availbe still be a member of TypeInfo.
machine->targets are not generic. Indeed CPU and ACCEL(kvm/whpx/hyp)
types also need filtering.

>
> @Daniel, IIUC, this is exactly the approach you proposed a few weeks
> ago, just before I got frustrated and lost my patience against you. I
> think it's more clear for me where you wanted to go. Sorry it took such
> a large detour.
>
> Yonggang, does that sounds good for you?
> Daniel, does that sounds good for you also?
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

