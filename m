Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA82C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11JD-0001ZA-RH; Mon, 31 Aug 2026 08:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x11JC-0001Yw-C1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 08:40:18 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x11J8-0007Bx-LQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 08:40:18 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so5657403a12.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788180013; cv=none;
 d=google.com; s=arc-20260327;
 b=NRqLjdFQpDECTlW9cfjQ+i2On18XPCvmLWvNvIUdzzTiSvDiugwA065iD4o8L10fht
 8yMKY3LqQhOz6Pb9wcH9u38F26uPSu+uiMYRpYEL9HxhUyn9Xvd1d3yj6zzaNfEZOMx6
 xDoAI9zkSOTYIH057FPXM0V1C1Fdo9XEPGGcNvNUZUy1BmroCCe8uqO2mtEauxHVpAkV
 tPnrR7ee5UlvupMGtSDEqXUQ+makmcQHlvkIUhne6VEeoA6zkQuY57N7NIgNAjtBXSEj
 5U0iZZWpdfU/Xrtm5+pflHYKluB6F75JnVaxZ8+q6+BU2xy2le3jQafHt5/rQWAL0Jxw
 PR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=soSeJq2N5/o8XmiRV+I41Q4C9E0TJBUMI/Xdb40gWww=;
 fh=dLrxXhNFLYOe0h//qW0yf246b4AxzSerEDHU468ijm8=;
 b=BDqzIpELYhDazQEmyXUP93FiEhDaels6kOb5UXurdIuFC5p1ozpUGikcMsOMe8MJmG
 RquXYMOUb82qWSjCUiIKQbdhX0HgvasGovHoQsUskJC4nMxD/u7aO9N5Knh9KMU0fl7P
 z4wMcd+oFb8wag3BQKfFTD7XkqxM9iMMh/z8Du/cZwUEClY8cueqBIoDkBFTM8x+5QJx
 j1pKSuPmuQDAOOaWFebfRszyXiburRvEOtzNY8bLFitV2irfDShOnwhST2FhpKCS8L2a
 JheqjT+Aq1fYJc/ttsFrmCwCqOm0X/hwbm0N4f2U7zYaefsjHbg0Hct+5TyXLX7i26Wi
 Dl8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788180013; x=1788784813; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=soSeJq2N5/o8XmiRV+I41Q4C9E0TJBUMI/Xdb40gWww=;
 b=SCZod/1qNaJxuc8MUVZcVxdI0MVvxS5xqUXR7gTcyxEdoWjIDiTGKPQND7kajR5p3R
 /SEssdh0YZVJnyCDHqmmA8oGItKkMGo3wZQEUu3T9AAXw1hUZ1y9cK61EDGB5VDVr1kE
 f+/EhxVFFMvl8vQXwxwH2/Ukl0OU7VZbsvWa3LXW1ZWm0lQP5LFITILk1MtfpBfEUqB2
 VJedu2EM+AByoHdgOWkfBMu98/MsVKzmr4lUwl37NPtF045k/EzyTGZLJLIQEk4waYLT
 BRXu49JhcBsOZSVasc+7k3BlVKf+Ep2GCOrXGOJy06QccCQa2z6IfS9gKmjRdZxcvxB0
 6i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788180013; x=1788784813;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=soSeJq2N5/o8XmiRV+I41Q4C9E0TJBUMI/Xdb40gWww=;
 b=NF92jCkT2tLzMOd/HypKPwzsET+ZoMwmYEPJ4rqLCEIlEuMNNxiA4CJ7wODE8q0v4i
 G1MmIaoqX/1cROc6RxAOPtkjpyQoI/hCII48vKK7+d7dthKCkPGeaNN+TidazzPck4GY
 3Yu7MF2yoZ49izctRExSW1Vq5B2a7OlXVVXVrIzCCJlrBYJq2DO6ppRTo6QFdsI5ivxk
 tAA65ZIwSDyUdeya6zEws0h4qJI6rqcxla7+oFeXQeFl+lldob3q/OCSb633ebfS7nqZ
 TqOFQclpybr6H6IyKwmiUi6zakg8nlag7R5yTWFNZ7AS5kZFNAHjMRiii0cJh+5mcTt9
 lqvA==
X-Gm-Message-State: AFuF++kCSR/fMLvDAnApktHxoCXUsG1JxK8yy2X0TlWfQHof8i2Z/SbF
 KnqHTU2UIEH2rn4GjRXCHqBdZoo5epTfmEHpopVhyL08Uh9h/9+N8jqXirchWrUgHu3J2+Kq1Qz
 sCGI0vd/UXmRVpE+iPPZaY0syHu2iIL4/shqUeTI=
X-Gm-Gg: AR+sD13ZyfivmgFFV+0KygJhfo8EMX+0WhzFFBq6JrZj54Y8FYqVfIMF/9YwNP4I7UG
 pxXkT+wjBCNPdWw6R0bm0ksv1FPOFHhP7Cov3BidAL06h/khxvl4InWewJ5qwvVIBp9dnHZ9G/G
 uD/TURFi4mK2shZhALm7/uSlYGQ23f+llnl7cMboocpD/Q8RclW4ToWF1GyaNQ/Ym8jV/BAE4Rj
 O//YhLwRwQIIETP0DgjVnqWIiR9Vt5fGhvyvKSeKqlscdWyW1BCoEchuSSKzVJtpeqLt4bPtUr/
 0nyis9xNJqhLHylpIL+8QajEKwLxfrT9AUBlQo9ipmg4
X-Received: by 2002:a17:907:3ccc:b0:c25:d04:72f4 with SMTP id
 a640c23a62f3a-c255742f4a9mr1948722666b.15.1788180012855; Mon, 31 Aug 2026
 05:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-34-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-34-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 31 Aug 2026 20:39:58 +0800
X-Gm-Features: AcwNN1VVjinj_Cdk8Pn_Q_i-_Z6kJPhl7Zb_-i4GfPM7jkkCtKCPvKHE_k3gWe8
Message-ID: <CAE2XoE8sGoz9pJcPgqDVKgWa=WbZ1eMk91u6AkEZ4BcRVyyNew@mail.gmail.com>
Subject: Re: [PATCH 33/47] system/vl: add new option -target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, anjo@rev.ng, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000765ee8065a571a0a"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x536.google.com
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

--000000000000765ee8065a571a0a
Content-Type: multipart/alternative; boundary="000000000000765ee6065a571a08"

--000000000000765ee6065a571a08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would suggest to handle the condition and argv0 and target name
consitencely, here is my patch summary:
- Parse -target with QEMU_OPTION_nouserconfig, right after
  MODULE_INIT_TARGET_INFO, because later init depends on TargetInfo.
- target_info_qom_set_target() takes Error **errp. A name comes from
  -target or from argv0 (qemu-system-aarch64).
- Define SYS_EMU_TARGET_UNSPECIFIED as SYS_EMU_TARGET__MAX. Bare
  qemu-system with no suffix and no -target binds a dummy TargetInfo.
  qemu-system-* still selects from the argv[0] suffix.
- -M help lists the union. Starting a real board without a target
  errors; -M none is allowed.
- qemu_arch_available() is true when unspecified. query-target errors
  instead of emitting an invalid SysEmuTarget.
- Fuzz passes TARGET_NAME instead of relying on a unique TargetInfo.

and patch is attached to replace this commit and next commit



On Sat, Aug 29, 2026 at 7:04=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> This commit adds a new option -target, which can be allowed to set
> current target, or retrieve list of targets available with 'help'.
>
> This option is the first we need to handle, as all the rest of
> initialization depends on it.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  include/qemu/target-info-qom.h |  1 +
>  qemu-options.hx                |  8 ++++++++
>  system/vl.c                    | 34 +++++++++++++++++++++++++++++++++-
>  target-info-qom.c              | 33 ++++++++++++++++++++++++++++++++-
>  4 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu/target-info-qom.h
b/include/qemu/target-info-qom.h
> index 91be415ed33..87f3a51ccd4 100644
> --- a/include/qemu/target-info-qom.h
> +++ b/include/qemu/target-info-qom.h
> @@ -26,5 +26,6 @@ typedef struct TargetInfoQomClass {
>  OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>
>  void target_info_qom_set_target(void);
> +void target_info_qom_set_target_from_name(const char *name);
>
>  #endif /* QEMU_TARGET_INFO_QOM_H */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 562c4c2b035..68d0c1d42da 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -24,6 +24,14 @@ SRST
>      Display version information and exit
>  ERST
>
> +DEF("target", HAS_ARG, QEMU_OPTION_target, \
> +    "-target target  selects the target architecture ('-target help' for
list)\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-target target``
> +    Selects target architecture ('-target help' for list)
> +ERST
> +
>  DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "-machine [type=3D]name[,prop=3Dvalue[,...]]\n"
>      "                selects emulated machine ('-machine help' for
list)\n"
> diff --git a/system/vl.c b/system/vl.c
> index f7f8aabd122..60c5ce85580 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -281,6 +281,15 @@ static QemuOptsList qemu_accel_opts =3D {
>      },
>  };
>
> +static QemuOptsList qemu_target_opts =3D {
> +    .name =3D "target",
> +    .implied_opt_name =3D "target",
> +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_target_opts.head),
> +    .desc =3D {
> +        { /* end of list */ },
> +    },
> +};
> +
>  static QemuOptsList qemu_boot_opts =3D {
>      .name =3D "boot-opts",
>      .implied_opt_name =3D "order",
> @@ -2891,6 +2900,7 @@ void qemu_init(int argc, char **argv)
>      qemu_add_opts(&qemu_semihosting_config_opts);
>      qemu_add_opts(&qemu_fw_cfg_opts);
>      qemu_add_opts(&qemu_action_opts);
> +    qemu_add_opts(&qemu_target_opts);
>      qemu_add_run_with_opts();
>      module_call_init(MODULE_INIT_OPTS);
>
> @@ -2900,7 +2910,26 @@ void qemu_init(int argc, char **argv)
>      os_setup_limits();
>
>      module_call_init(MODULE_INIT_TARGET_INFO);
> -    target_info_qom_set_target();
> +
> +    /*
> +     * Identify target: first from option, then from argv[0].
> +     * This happens even before handling --help option, because it may
contain
> +     * entries that are target specific.
> +     */
> +    for (int idx =3D 1; idx < argc;) {
> +        if (argv[idx][0] !=3D '-') {
> +            idx++;
> +        } else {
> +            const QEMUOption *popt =3D lookup_opt(argc, argv, &optarg,
&idx);
> +            if (popt->index =3D=3D QEMU_OPTION_target) {
> +                target_info_qom_set_target_from_name(optarg);
> +                break;
> +            }
> +        }
> +    }
> +    if (!target_info()) {
> +        target_info_qom_set_target();
> +    }
>
>      module_init_info(qemu_modinfo);
>      module_allow_arch(target_name());
> @@ -2948,6 +2977,9 @@ void qemu_init(int argc, char **argv)
>                  exit(1);
>              }
>              switch(popt->index) {
> +            case QEMU_OPTION_target:
> +                /* handled previously, ignore it here */
> +                break;
>              case QEMU_OPTION_cpu:
>                  /* hw initialization will check this */
>                  cpu_option =3D optarg;
> diff --git a/target-info-qom.c b/target-info-qom.c
> index 6965e4d1169..a2f506c15ef 100644
> --- a/target-info-qom.c
> +++ b/target-info-qom.c
> @@ -9,6 +9,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qom/object.h"
> +#include "qemu/error-report.h"
>  #include "qemu/target-info-impl.h"
>  #include "qemu/target-info-init.h"
>  #include "qemu/target-info-qom.h"
> @@ -50,6 +51,36 @@ void target_info_qom_set_target(void)
>                                   "no target-info is available" :
>                                   "more than one target-info is
available");
>      }
> -
>      target_info_ptr =3D TARGET_INFO_CLASS(targets->data)->target_info;
>  }
> +
> +static void list_targets_available(void)
> +{
> +    printf("List of targets available:\n");
> +    g_autoptr(GSList) targets =3D
object_class_get_list_sorted(TYPE_TARGET_INFO, false);
> +    for (GSList *elem =3D targets; elem; elem =3D elem->next) {
> +        const TargetInfo *ti =3D
TARGET_INFO_CLASS(elem->data)->target_info;
> +        printf("- %s\n", ti->target_name);
> +    }
> +}
> +
> +void target_info_qom_set_target_from_name(const char *name)
> +{
> +    if (!strcmp(name, "help")) {
> +        list_targets_available();
> +        exit(0);
> +    }
> +
> +    g_autoptr(GSList) targets =3D object_class_get_list(TYPE_TARGET_INFO=
,
false);
> +    for (GSList *elem =3D targets; elem; elem =3D elem->next) {
> +        const TargetInfo *ti =3D
TARGET_INFO_CLASS(elem->data)->target_info;
> +        if (!strcmp(name, ti->target_name)) {
> +            target_info_ptr =3D ti;
> +            return;
> +        }
> +    }
> +
> +    error_report("target '%s' is not available", name);
> +    list_targets_available();
> +    exit(1);
> +}
> --
> 2.43.0
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000765ee6065a571a08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I would suggest to handle the condition and argv0 and targ=
et name consitencely, here is my patch summary:<div>- Parse -target with QE=
MU_OPTION_nouserconfig, right after<br>=C2=A0 MODULE_INIT_TARGET_INFO, beca=
use later init depends on TargetInfo.<br>- target_info_qom_set_target() tak=
es Error **errp. A name comes from<br>=C2=A0 -target or from argv0 (qemu-sy=
stem-aarch64).<br>- Define SYS_EMU_TARGET_UNSPECIFIED as SYS_EMU_TARGET__MA=
X. Bare<br>=C2=A0 qemu-system with no suffix and no -target binds a dummy T=
argetInfo.<br>=C2=A0 qemu-system-* still selects from the argv[0] suffix.<b=
r>- -M help lists the union. Starting a real board without a target<br>=C2=
=A0 errors; -M none is allowed.<br>- qemu_arch_available() is true when uns=
pecified. query-target errors<br>=C2=A0 instead of emitting an invalid SysE=
muTarget.<br>- Fuzz passes TARGET_NAME instead of relying on a unique Targe=
tInfo.<br><div><br></div><div>and patch is attached=C2=A0to replace this co=
mmit and next commit</div><div><br></div><div><br><br>On Sat, Aug 29, 2026 =
at 7:04=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@=
oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<=
br>&gt; This commit adds a new option -target, which can be allowed to set<=
br>&gt; current target, or retrieve list of targets available with &#39;hel=
p&#39;.<br>&gt;<br>&gt; This option is the first we need to handle, as all =
the rest of<br>&gt; initialization depends on it.<br>&gt;<br>&gt; Signed-of=
f-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.=
com">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0in=
clude/qemu/target-info-qom.h | =C2=A01 +<br>&gt; =C2=A0qemu-options.hx =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A08 ++++++++<br>&=
gt; =C2=A0system/vl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 34 +++++++++++++++++++++++++++++++++-<br>&gt; =C2=A0targ=
et-info-qom.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 33 ++++++++=
++++++++++++++++++++++++-<br>&gt; =C2=A04 files changed, 74 insertions(+), =
2 deletions(-)<br>&gt;<br>&gt; diff --git a/include/qemu/target-info-qom.h =
b/include/qemu/target-info-qom.h<br>&gt; index 91be415ed33..87f3a51ccd4 100=
644<br>&gt; --- a/include/qemu/target-info-qom.h<br>&gt; +++ b/include/qemu=
/target-info-qom.h<br>&gt; @@ -26,5 +26,6 @@ typedef struct TargetInfoQomCl=
ass {<br>&gt; =C2=A0OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, =
TARGET_INFO)<br>&gt;<br>&gt; =C2=A0void target_info_qom_set_target(void);<b=
r>&gt; +void target_info_qom_set_target_from_name(const char *name);<br>&gt=
;<br>&gt; =C2=A0#endif /* QEMU_TARGET_INFO_QOM_H */<br>&gt; diff --git a/qe=
mu-options.hx b/qemu-options.hx<br>&gt; index 562c4c2b035..68d0c1d42da 1006=
44<br>&gt; --- a/qemu-options.hx<br>&gt; +++ b/qemu-options.hx<br>&gt; @@ -=
24,6 +24,14 @@ SRST<br>&gt; =C2=A0 =C2=A0 =C2=A0Display version information=
 and exit<br>&gt; =C2=A0ERST<br>&gt;<br>&gt; +DEF(&quot;target&quot;, HAS_A=
RG, QEMU_OPTION_target, \<br>&gt; + =C2=A0 =C2=A0&quot;-target target =C2=
=A0selects the target architecture (&#39;-target help&#39; for list)\n&quot=
;,<br>&gt; + =C2=A0 =C2=A0QEMU_ARCH_ALL)<br>&gt; +SRST<br>&gt; +``-target t=
arget``<br>&gt; + =C2=A0 =C2=A0Selects target architecture (&#39;-target he=
lp&#39; for list)<br>&gt; +ERST<br>&gt; +<br>&gt; =C2=A0DEF(&quot;machine&q=
uot;, HAS_ARG, QEMU_OPTION_machine, \<br>&gt; =C2=A0 =C2=A0 =C2=A0&quot;-ma=
chine [type=3D]name[,prop=3Dvalue[,...]]\n&quot;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selects em=
ulated machine (&#39;-machine help&#39; for list)\n&quot;<br>&gt; diff --gi=
t a/system/vl.c b/system/vl.c<br>&gt; index f7f8aabd122..60c5ce85580 100644=
<br>&gt; --- a/system/vl.c<br>&gt; +++ b/system/vl.c<br>&gt; @@ -281,6 +281=
,15 @@ static QemuOptsList qemu_accel_opts =3D {<br>&gt; =C2=A0 =C2=A0 =C2=
=A0},<br>&gt; =C2=A0};<br>&gt;<br>&gt; +static QemuOptsList qemu_target_opt=
s =3D {<br>&gt; + =C2=A0 =C2=A0.name =3D &quot;target&quot;,<br>&gt; + =C2=
=A0 =C2=A0.implied_opt_name =3D &quot;target&quot;,<br>&gt; + =C2=A0 =C2=A0=
.head =3D QTAILQ_HEAD_INITIALIZER(qemu_target_opts.head),<br>&gt; + =C2=A0 =
=C2=A0.desc =3D {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ /* end of list */ =
},<br>&gt; + =C2=A0 =C2=A0},<br>&gt; +};<br>&gt; +<br>&gt; =C2=A0static Qem=
uOptsList qemu_boot_opts =3D {<br>&gt; =C2=A0 =C2=A0 =C2=A0.name =3D &quot;=
boot-opts&quot;,<br>&gt; =C2=A0 =C2=A0 =C2=A0.implied_opt_name =3D &quot;or=
der&quot;,<br>&gt; @@ -2891,6 +2900,7 @@ void qemu_init(int argc, char **ar=
gv)<br>&gt; =C2=A0 =C2=A0 =C2=A0qemu_add_opts(&amp;qemu_semihosting_config_=
opts);<br>&gt; =C2=A0 =C2=A0 =C2=A0qemu_add_opts(&amp;qemu_fw_cfg_opts);<br=
>&gt; =C2=A0 =C2=A0 =C2=A0qemu_add_opts(&amp;qemu_action_opts);<br>&gt; + =
=C2=A0 =C2=A0qemu_add_opts(&amp;qemu_target_opts);<br>&gt; =C2=A0 =C2=A0 =
=C2=A0qemu_add_run_with_opts();<br>&gt; =C2=A0 =C2=A0 =C2=A0module_call_ini=
t(MODULE_INIT_OPTS);<br>&gt;<br>&gt; @@ -2900,7 +2910,26 @@ void qemu_init(=
int argc, char **argv)<br>&gt; =C2=A0 =C2=A0 =C2=A0os_setup_limits();<br>&g=
t;<br>&gt; =C2=A0 =C2=A0 =C2=A0module_call_init(MODULE_INIT_TARGET_INFO);<b=
r>&gt; - =C2=A0 =C2=A0target_info_qom_set_target();<br>&gt; +<br>&gt; + =C2=
=A0 =C2=A0/*<br>&gt; + =C2=A0 =C2=A0 * Identify target: first from option, =
then from argv[0].<br>&gt; + =C2=A0 =C2=A0 * This happens even before handl=
ing --help option, because it may contain<br>&gt; + =C2=A0 =C2=A0 * entries=
 that are target specific.<br>&gt; + =C2=A0 =C2=A0 */<br>&gt; + =C2=A0 =C2=
=A0for (int idx =3D 1; idx &lt; argc;) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (argv[idx][0] !=3D &#39;-&#39;) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0idx++;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const QEMUOption *popt =3D lo=
okup_opt(argc, argv, &amp;optarg, &amp;idx);<br>&gt; + =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (popt-&gt;index =3D=3D QEMU_OPTION_target) {<br>&gt=
; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_info_qom_=
set_target_from_name(optarg);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; + =C2=A0 =C2=A0}<br>&gt=
; + =C2=A0 =C2=A0if (!target_info()) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0target_info_qom_set_target();<br>&gt; + =C2=A0 =C2=A0}<br>&gt;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0module_init_info(qemu_modinfo);<br>&gt; =C2=A0 =C2=A0 =
=C2=A0module_allow_arch(target_name());<br>&gt; @@ -2948,6 +2977,9 @@ void =
qemu_init(int argc, char **argv)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0switch(popt-&gt;index) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0case QEMU_OPTION_target:<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* handled previously, ignore it here */<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case QEMU_OPTION_cpu:<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* hw initializa=
tion will check this */<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cpu_option =3D optarg;<br>&gt; diff --git a/target-info=
-qom.c b/target-info-qom.c<br>&gt; index 6965e4d1169..a2f506c15ef 100644<br=
>&gt; --- a/target-info-qom.c<br>&gt; +++ b/target-info-qom.c<br>&gt; @@ -9=
,6 +9,7 @@<br>&gt; =C2=A0#include &quot;qemu/osdep.h&quot;<br>&gt; =C2=A0#i=
nclude &quot;qapi/error.h&quot;<br>&gt; =C2=A0#include &quot;qom/object.h&q=
uot;<br>&gt; +#include &quot;qemu/error-report.h&quot;<br>&gt; =C2=A0#inclu=
de &quot;qemu/target-info-impl.h&quot;<br>&gt; =C2=A0#include &quot;qemu/ta=
rget-info-init.h&quot;<br>&gt; =C2=A0#include &quot;qemu/target-info-qom.h&=
quot;<br>&gt; @@ -50,6 +51,36 @@ void target_info_qom_set_target(void)<br>&=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;no target-info is av=
ailable&quot; :<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;more than one target-info is available&quot;);<br>&gt; =C2=A0 =C2=A0 =C2=
=A0}<br>&gt; -<br>&gt; =C2=A0 =C2=A0 =C2=A0target_info_ptr =3D TARGET_INFO_=
CLASS(targets-&gt;data)-&gt;target_info;<br>&gt; =C2=A0}<br>&gt; +<br>&gt; =
+static void list_targets_available(void)<br>&gt; +{<br>&gt; + =C2=A0 =C2=
=A0printf(&quot;List of targets available:\n&quot;);<br>&gt; + =C2=A0 =C2=
=A0g_autoptr(GSList) targets =3D object_class_get_list_sorted(TYPE_TARGET_I=
NFO, false);<br>&gt; + =C2=A0 =C2=A0for (GSList *elem =3D targets; elem; el=
em =3D elem-&gt;next) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0const TargetIn=
fo *ti =3D TARGET_INFO_CLASS(elem-&gt;data)-&gt;target_info;<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;- %s\n&quot;, ti-&gt;target_name);<br>=
&gt; + =C2=A0 =C2=A0}<br>&gt; +}<br>&gt; +<br>&gt; +void target_info_qom_se=
t_target_from_name(const char *name)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0if (=
!strcmp(name, &quot;help&quot;)) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0lis=
t_targets_available();<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);<br>&gt=
; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0g_autoptr(GSList) targe=
ts =3D object_class_get_list(TYPE_TARGET_INFO, false);<br>&gt; + =C2=A0 =C2=
=A0for (GSList *elem =3D targets; elem; elem =3D elem-&gt;next) {<br>&gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const TargetInfo *ti =3D TARGET_INFO_CLASS(elem=
-&gt;data)-&gt;target_info;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcm=
p(name, ti-&gt;target_name)) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0target_info_ptr =3D ti;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; + =C2=A0 =C2=
=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0error_report(&quot;target &#39;%s&#39=
; is not available&quot;, name);<br>&gt; + =C2=A0 =C2=A0list_targets_availa=
ble();<br>&gt; + =C2=A0 =C2=A0exit(1);<br>&gt; +}<br>&gt; --<br>&gt; 2.43.0=
<br>&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=
=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0=
 =C2=A0 sincerely,<br>Yonggang Luo</div></div></div>

--000000000000765ee6065a571a08--

--000000000000765ee8065a571a0a
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-system-vl-add-new-option-target.patch"
Content-Disposition: attachment; 
	filename="0001-system-vl-add-new-option-target.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mth876ay0>
X-Attachment-Id: f_mth876ay0

RnJvbSAxMDM0MWY4NzlhMTBkYTcxNTIzMGUxZDZhZTY0ODE3NWM4MjQ1MzI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nZ2FuZyBMdW8gPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4K
RGF0ZTogTW9uLCAzMSBBdWcgMjAyNiAxNDoyNjo1MSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHN5
c3RlbS92bDogYWRkIG5ldyBvcHRpb24gLXRhcmdldAoKLSBQYXJzZSAtdGFyZ2V0IHdpdGggUUVN
VV9PUFRJT05fbm91c2VyY29uZmlnLCByaWdodCBhZnRlcgogIE1PRFVMRV9JTklUX1RBUkdFVF9J
TkZPLCBiZWNhdXNlIGxhdGVyIGluaXQgZGVwZW5kcyBvbiBUYXJnZXRJbmZvLgotIHRhcmdldF9p
bmZvX3FvbV9zZXRfdGFyZ2V0KCkgdGFrZXMgRXJyb3IgKiplcnJwLiBBIG5hbWUgY29tZXMgZnJv
bQogIC10YXJnZXQgb3IgZnJvbSBhcmd2MCAocWVtdS1zeXN0ZW0tYWFyY2g2NCkuCi0gRGVmaW5l
IFNZU19FTVVfVEFSR0VUX1VOU1BFQ0lGSUVEIGFzIFNZU19FTVVfVEFSR0VUX19NQVguIEJhcmUK
ICBxZW11LXN5c3RlbSB3aXRoIG5vIHN1ZmZpeCBhbmQgbm8gLXRhcmdldCBiaW5kcyBhIGR1bW15
IFRhcmdldEluZm8uCiAgcWVtdS1zeXN0ZW0tKiBzdGlsbCBzZWxlY3RzIGZyb20gdGhlIGFyZ3Zb
MF0gc3VmZml4LgotIC1NIGhlbHAgbGlzdHMgdGhlIHVuaW9uLiBTdGFydGluZyBhIHJlYWwgYm9h
cmQgd2l0aG91dCBhIHRhcmdldAogIGVycm9yczsgLU0gbm9uZSBpcyBhbGxvd2VkLgotIHFlbXVf
YXJjaF9hdmFpbGFibGUoKSBpcyB0cnVlIHdoZW4gdW5zcGVjaWZpZWQuIHF1ZXJ5LXRhcmdldCBl
cnJvcnMKICBpbnN0ZWFkIG9mIGVtaXR0aW5nIGFuIGludmFsaWQgU3lzRW11VGFyZ2V0LgotIEZ1
enogcGFzc2VzIFRBUkdFVF9OQU1FIGluc3RlYWQgb2YgcmVseWluZyBvbiBhIHVuaXF1ZSBUYXJn
ZXRJbmZvLgoKU2lnbmVkLW9mZi1ieTogWW9uZ2dhbmcgTHVvIDxsdW95b25nZ2FuZ0BnbWFpbC5j
b20+Ci0tLQogaHcvY29yZS9tYWNoaW5lLXFtcC1jbWRzLmMgICAgICB8ICA4ICsrLQogaW5jbHVk
ZS9xZW11L3RhcmdldC1pbmZvLXFhcGkuaCB8IDIyICsrKysrKysrLQogaW5jbHVkZS9xZW11L3Rh
cmdldC1pbmZvLXFvbS5oICB8ICA4ICsrLQogcWVtdS1vcHRpb25zLmh4ICAgICAgICAgICAgICAg
ICB8ICA4ICsrKwogc3lzdGVtL2FyY2hfaW5pdC5jICAgICAgICAgICAgICB8ICA0ICsrCiBzeXN0
ZW0vdmwuYyAgICAgICAgICAgICAgICAgICAgIHwgMzEgKysrKysrKysrLS0tCiB0YXJnZXQtaW5m
by1xb20uYyAgICAgICAgICAgICAgIHwgODcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tCiB0ZXN0cy9xdGVzdC9mdXp6L2Z1enouYyAgICAgICAgIHwgIDIgKy0KIDggZmlsZXMgY2hh
bmdlZCwgMTUzIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3
L2NvcmUvbWFjaGluZS1xbXAtY21kcy5jIGIvaHcvY29yZS9tYWNoaW5lLXFtcC1jbWRzLmMKaW5k
ZXggNTQzZGQzMjAxYjUuLjJmZDEwNjEyYTIxIDEwMDY0NAotLS0gYS9ody9jb3JlL21hY2hpbmUt
cW1wLWNtZHMuYworKysgYi9ody9jb3JlL21hY2hpbmUtcW1wLWNtZHMuYwpAQCAtMTY1LDggKzE2
NSwxNCBAQCBDdXJyZW50TWFjaGluZVBhcmFtcyAqcW1wX3F1ZXJ5X2N1cnJlbnRfbWFjaGluZShF
cnJvciAqKmVycnApCiAKIFFlbXVUYXJnZXRJbmZvICpxbXBfcXVlcnlfdGFyZ2V0KEVycm9yICoq
ZXJycCkKIHsKLSAgICBRZW11VGFyZ2V0SW5mbyAqaW5mbyA9IGdfbWFsbG9jMChzaXplb2YoKmlu
Zm8pKTsKKyAgICBRZW11VGFyZ2V0SW5mbyAqaW5mbzsKIAorICAgIGlmICh0YXJnZXRfdW5zcGVj
aWZpZWQoKSkgeworICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJxdWVyeS10YXJnZXQgcmVxdWly
ZXMgYSBzZWxlY3RlZCB0YXJnZXQiKTsKKyAgICAgICAgcmV0dXJuIE5VTEw7CisgICAgfQorCisg
ICAgaW5mbyA9IGdfbWFsbG9jMChzaXplb2YoKmluZm8pKTsKICAgICBpbmZvLT5hcmNoID0gdGFy
Z2V0X2FyY2goKTsKIAogICAgIHJldHVybiBpbmZvOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11
L3RhcmdldC1pbmZvLXFhcGkuaCBiL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1xYXBpLmgKaW5k
ZXggZDVjZTA1MjMyMzguLmNiMmNjNjY5ZDk0IDEwMDY0NAotLS0gYS9pbmNsdWRlL3FlbXUvdGFy
Z2V0LWluZm8tcWFwaS5oCisrKyBiL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1xYXBpLmgKQEAg
LTEyLDEzICsxMiwzMyBAQAogI2luY2x1ZGUgInFhcGkvcWFwaS10eXBlcy1jb21tb24uaCIKICNp
bmNsdWRlICJxYXBpL3FhcGktdHlwZXMtbWFjaGluZS5oIgogCisvKgorICogU2VudGluZWwgd2hl
biBjb21iaW5lZCBxZW11LXN5c3RlbSBoYXMgbm90IGJvdW5kIGEgVGFyZ2V0SW5mby4KKyAqIE5v
dCBhIFFBUEkgU3lzRW11VGFyZ2V0IG1lbWJlciBhbmQgbm90IGEgaGV0ZXJvZ2VuZW91cyBWTSBt
b2RlLgorICogT25lIHBhc3QgdGhlIGxhc3QgZ2VuZXJhdGVkIGVudW1lcmF0b3IuCisgKi8KKyNk
ZWZpbmUgU1lTX0VNVV9UQVJHRVRfVU5TUEVDSUZJRUQgU1lTX0VNVV9UQVJHRVRfX01BWAorCiAv
KioKICAqIHRhcmdldF9hcmNoOgogICoKLSAqIFJldHVybnM6IFFBUEkgU3lzRW11VGFyZ2V0IGVu
dW0gKGUuZy4gU1lTX0VNVV9UQVJHRVRfWDg2XzY0KS4KKyAqIFJldHVybnM6IFFBUEkgU3lzRW11
VGFyZ2V0IGVudW0gKGUuZy4gU1lTX0VNVV9UQVJHRVRfWDg2XzY0KSwgb3IKKyAqIFNZU19FTVVf
VEFSR0VUX1VOU1BFQ0lGSUVEIHdoZW4gbm8gdGFyZ2V0IGlzIHNlbGVjdGVkLgogICovCiBTeXNF
bXVUYXJnZXQgdGFyZ2V0X2FyY2godm9pZCk7CiAKKy8qKgorICogdGFyZ2V0X3Vuc3BlY2lmaWVk
OgorICoKKyAqIFJldHVybnMgdHJ1ZSBpZiB0aGUgcHJvY2VzcyBoYXMgbm8gc2luZ2xlIHNlbGVj
dGVkIFRhcmdldEluZm8KKyAqIChTWVNfRU1VX1RBUkdFVF9VTlNQRUNJRklFRCkuIENvbWJpbmVk
IHFlbXUtc3lzdGVtIHVzZXMgdGhpcworICogd2hlbiBhcmd2WzBdIGhhcyBubyBhcmNoIHN1ZmZp
eCBhbmQgLXRhcmdldCBpcyBvbWl0dGVkLgorICovCitzdGF0aWMgaW5saW5lIGJvb2wgdGFyZ2V0
X3Vuc3BlY2lmaWVkKHZvaWQpCit7CisgICAgcmV0dXJuIHRhcmdldF9hcmNoKCkgPT0gU1lTX0VN
VV9UQVJHRVRfVU5TUEVDSUZJRUQ7Cit9CisKIC8qKgogICogdGFyZ2V0X2VuZGlhbl9tb2RlOgog
ICoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1xb20uaCBiL2luY2x1ZGUv
cWVtdS90YXJnZXQtaW5mby1xb20uaAppbmRleCA5MWJlNDE1ZWQzMy4uMjBkY2IyMTRiZjIgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1xb20uaAorKysgYi9pbmNsdWRlL3Fl
bXUvdGFyZ2V0LWluZm8tcW9tLmgKQEAgLTEwLDYgKzEwLDcgQEAKICNkZWZpbmUgUUVNVV9UQVJH
RVRfSU5GT19RT01fSAogCiAjaW5jbHVkZSAicWVtdS90YXJnZXQtaW5mby1pbXBsLmgiCisjaW5j
bHVkZSAicWFwaS9lcnJvci5oIgogI2luY2x1ZGUgInFvbS9vYmplY3QuaCIKIAogI2RlZmluZSBU
WVBFX1RBUkdFVF9JTkZPICJ0YXJnZXQtaW5mbyIKQEAgLTI1LDYgKzI2LDExIEBAIHR5cGVkZWYg
c3RydWN0IFRhcmdldEluZm9Rb21DbGFzcyB7CiAKIE9CSkVDVF9ERUNMQVJFX1RZUEUoVGFyZ2V0
SW5mb1FvbSwgVGFyZ2V0SW5mb1FvbUNsYXNzLCBUQVJHRVRfSU5GTykKIAotdm9pZCB0YXJnZXRf
aW5mb19xb21fc2V0X3RhcmdldCh2b2lkKTsKKy8qCisgKiBJZGVudGlmeSB0YXJnZXQ6IGZpcnN0
IGZyb20gb3B0aW9uLCB0aGVuIGZyb20gYXJndlswXS4KKyAqIFRoaXMgaGFwcGVucyBldmVuIGJl
Zm9yZSBoYW5kbGluZyAtLWhlbHAgb3B0aW9uLCBiZWNhdXNlIGl0IG1heSBjb250YWluCisgKiBl
bnRyaWVzIHRoYXQgYXJlIHRhcmdldCBzcGVjaWZpYy4KKyAqLwordm9pZCB0YXJnZXRfaW5mb19x
b21fc2V0X3RhcmdldChjb25zdCBjaGFyICpuYW1lLCBFcnJvciAqKmVycnApOwogCiAjZW5kaWYg
LyogUUVNVV9UQVJHRVRfSU5GT19RT01fSCAqLwpkaWZmIC0tZ2l0IGEvcWVtdS1vcHRpb25zLmh4
IGIvcWVtdS1vcHRpb25zLmh4CmluZGV4IDU2MmM0YzJiMDM1Li42OGQwYzFkNDJkYSAxMDA2NDQK
LS0tIGEvcWVtdS1vcHRpb25zLmh4CisrKyBiL3FlbXUtb3B0aW9ucy5oeApAQCAtMjQsNiArMjQs
MTQgQEAgU1JTVAogICAgIERpc3BsYXkgdmVyc2lvbiBpbmZvcm1hdGlvbiBhbmQgZXhpdAogRVJT
VAogCitERUYoInRhcmdldCIsIEhBU19BUkcsIFFFTVVfT1BUSU9OX3RhcmdldCwgXAorICAgICIt
dGFyZ2V0IHRhcmdldCAgc2VsZWN0cyB0aGUgdGFyZ2V0IGFyY2hpdGVjdHVyZSAoJy10YXJnZXQg
aGVscCcgZm9yIGxpc3QpXG4iLAorICAgIFFFTVVfQVJDSF9BTEwpCitTUlNUCitgYC10YXJnZXQg
dGFyZ2V0YGAKKyAgICBTZWxlY3RzIHRhcmdldCBhcmNoaXRlY3R1cmUgKCctdGFyZ2V0IGhlbHAn
IGZvciBsaXN0KQorRVJTVAorCiBERUYoIm1hY2hpbmUiLCBIQVNfQVJHLCBRRU1VX09QVElPTl9t
YWNoaW5lLCBcCiAgICAgIi1tYWNoaW5lIFt0eXBlPV1uYW1lWyxwcm9wPXZhbHVlWywuLi5dXVxu
IgogICAgICIgICAgICAgICAgICAgICAgc2VsZWN0cyBlbXVsYXRlZCBtYWNoaW5lICgnLW1hY2hp
bmUgaGVscCcgZm9yIGxpc3QpXG4iCmRpZmYgLS1naXQgYS9zeXN0ZW0vYXJjaF9pbml0LmMgYi9z
eXN0ZW0vYXJjaF9pbml0LmMKaW5kZXggMWFkMmYzZDZmNzguLjYwYTUzYjQ3OGExIDEwMDY0NAot
LS0gYS9zeXN0ZW0vYXJjaF9pbml0LmMKKysrIGIvc3lzdGVtL2FyY2hfaW5pdC5jCkBAIC0yNCw5
ICsyNCwxMyBAQAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKICNpbmNsdWRlICJxZW11L2Jhc2Ut
YXJjaC1kZWZzLmgiCiAjaW5jbHVkZSAicWVtdS9iaXRvcHMuaCIKKyNpbmNsdWRlICJxZW11L3Rh
cmdldC1pbmZvLmgiCiAjaW5jbHVkZSAicWVtdS90YXJnZXQtaW5mby1xYXBpLmgiCiAKIGJvb2wg
cWVtdV9hcmNoX2F2YWlsYWJsZSh1aW50MzJfdCBhcmNoX2JpdG1hc2spCiB7CisgICAgaWYgKHRh
cmdldF91bnNwZWNpZmllZCgpKSB7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KICAgICBy
ZXR1cm4gZXh0cmFjdDMyKGFyY2hfYml0bWFzaywgdGFyZ2V0X2FyY2goKSwgMSk7CiB9CmRpZmYg
LS1naXQgYS9zeXN0ZW0vdmwuYyBiL3N5c3RlbS92bC5jCmluZGV4IGY3ZjhhYWJkMTIyLi42MGI0
YmM5OGYxMiAxMDA2NDQKLS0tIGEvc3lzdGVtL3ZsLmMKKysrIGIvc3lzdGVtL3ZsLmMKQEAgLTI4
MSw2ICsyODEsMTUgQEAgc3RhdGljIFFlbXVPcHRzTGlzdCBxZW11X2FjY2VsX29wdHMgPSB7CiAg
ICAgfSwKIH07CiAKK3N0YXRpYyBRZW11T3B0c0xpc3QgcWVtdV90YXJnZXRfb3B0cyA9IHsKKyAg
ICAubmFtZSA9ICJ0YXJnZXQiLAorICAgIC5pbXBsaWVkX29wdF9uYW1lID0gInRhcmdldCIsCisg
ICAgLmhlYWQgPSBRVEFJTFFfSEVBRF9JTklUSUFMSVpFUihxZW11X3RhcmdldF9vcHRzLmhlYWQp
LAorICAgIC5kZXNjID0geworICAgICAgICB7IC8qIGVuZCBvZiBsaXN0ICovIH0sCisgICAgfSwK
K307CisKIHN0YXRpYyBRZW11T3B0c0xpc3QgcWVtdV9ib290X29wdHMgPSB7CiAgICAgLm5hbWUg
PSAiYm9vdC1vcHRzIiwKICAgICAuaW1wbGllZF9vcHRfbmFtZSA9ICJvcmRlciIsCkBAIC0yODU4
LDYgKzI4NjcsNyBAQCB2b2lkIHFlbXVfaW5pdChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAg
Y29uc3QgY2hhciAqb3B0YXJnOwogICAgIE1hY2hpbmVDbGFzcyAqbWFjaGluZV9jbGFzczsKICAg
ICBib29sIHVzZXJjb25maWcgPSB0cnVlOworICAgIGNvbnN0IGNoYXIgKnRhcmdldF9uYW1lX29w
dGlvbiA9IE5VTEw7CiAgICAgRklMRSAqdm1zdGF0ZV9kdW1wX2ZpbGUgPSBOVUxMOwogCiAgICAg
cWVtdV9hZGRfb3B0cygmcWVtdV9kcml2ZV9vcHRzKTsKQEAgLTI4OTEsNiArMjkwMSw3IEBAIHZv
aWQgcWVtdV9pbml0KGludCBhcmdjLCBjaGFyICoqYXJndikKICAgICBxZW11X2FkZF9vcHRzKCZx
ZW11X3NlbWlob3N0aW5nX2NvbmZpZ19vcHRzKTsKICAgICBxZW11X2FkZF9vcHRzKCZxZW11X2Z3
X2NmZ19vcHRzKTsKICAgICBxZW11X2FkZF9vcHRzKCZxZW11X2FjdGlvbl9vcHRzKTsKKyAgICBx
ZW11X2FkZF9vcHRzKCZxZW11X3RhcmdldF9vcHRzKTsKICAgICBxZW11X2FkZF9ydW5fd2l0aF9v
cHRzKCk7CiAgICAgbW9kdWxlX2NhbGxfaW5pdChNT0RVTEVfSU5JVF9PUFRTKTsKIApAQCAtMjkw
MCwxMyArMjkxMSw2IEBAIHZvaWQgcWVtdV9pbml0KGludCBhcmdjLCBjaGFyICoqYXJndikKICAg
ICBvc19zZXR1cF9saW1pdHMoKTsKIAogICAgIG1vZHVsZV9jYWxsX2luaXQoTU9EVUxFX0lOSVRf
VEFSR0VUX0lORk8pOwotICAgIHRhcmdldF9pbmZvX3FvbV9zZXRfdGFyZ2V0KCk7Ci0KLSAgICBt
b2R1bGVfaW5pdF9pbmZvKHFlbXVfbW9kaW5mbyk7Ci0gICAgbW9kdWxlX2FsbG93X2FyY2godGFy
Z2V0X25hbWUoKSk7Ci0KLSAgICBxZW11X2luaXRfc3Vic3lzdGVtcygpOwotCiAgICAgLyogZmly
c3QgcGFzcyBvZiBvcHRpb24gcGFyc2luZyAqLwogICAgIG9wdGluZCA9IDE7CiAgICAgd2hpbGUg
KG9wdGluZCA8IGFyZ2MpIHsKQEAgLTI5MjEsMTAgKzI5MjUsMjAgQEAgdm9pZCBxZW11X2luaXQo
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQogICAgICAgICAgICAgY2FzZSBRRU1VX09QVElPTl9ub3Vz
ZXJjb25maWc6CiAgICAgICAgICAgICAgICAgdXNlcmNvbmZpZyA9IGZhbHNlOwogICAgICAgICAg
ICAgICAgIGJyZWFrOworICAgICAgICAgICAgY2FzZSBRRU1VX09QVElPTl90YXJnZXQ6CisgICAg
ICAgICAgICAgICAgdGFyZ2V0X25hbWVfb3B0aW9uID0gb3B0YXJnOworICAgICAgICAgICAgICAg
IGJyZWFrOwogICAgICAgICAgICAgfQogICAgICAgICB9CiAgICAgfQogCisgICAgdGFyZ2V0X2lu
Zm9fcW9tX3NldF90YXJnZXQodGFyZ2V0X25hbWVfb3B0aW9uLCAmZXJyb3JfZmF0YWwpOworCisg
ICAgbW9kdWxlX2luaXRfaW5mbyhxZW11X21vZGluZm8pOworICAgIG1vZHVsZV9hbGxvd19hcmNo
KHRhcmdldF9uYW1lKCkpOworCisgICAgcWVtdV9pbml0X3N1YnN5c3RlbXMoKTsKKwogICAgIG1h
Y2hpbmVfb3B0c19kaWN0ID0gcWRpY3RfbmV3KCk7CiAgICAgaWYgKHVzZXJjb25maWcpIHsKICAg
ICAgICAgcWVtdV9yZWFkX2RlZmF1bHRfY29uZmlnX2ZpbGUoJmVycm9yX2ZhdGFsKTsKQEAgLTI5
NDgsNiArMjk2Miw5IEBAIHZvaWQgcWVtdV9pbml0KGludCBhcmdjLCBjaGFyICoqYXJndikKICAg
ICAgICAgICAgICAgICBleGl0KDEpOwogICAgICAgICAgICAgfQogICAgICAgICAgICAgc3dpdGNo
KHBvcHQtPmluZGV4KSB7CisgICAgICAgICAgICBjYXNlIFFFTVVfT1BUSU9OX3RhcmdldDoKKyAg
ICAgICAgICAgICAgICAvKiBoYW5kbGVkIHByZXZpb3VzbHksIGlnbm9yZSBpdCBoZXJlICovCisg
ICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgICBjYXNlIFFFTVVfT1BUSU9OX2NwdToK
ICAgICAgICAgICAgICAgICAvKiBodyBpbml0aWFsaXphdGlvbiB3aWxsIGNoZWNrIHRoaXMgKi8K
ICAgICAgICAgICAgICAgICBjcHVfb3B0aW9uID0gb3B0YXJnOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0
LWluZm8tcW9tLmMgYi90YXJnZXQtaW5mby1xb20uYwppbmRleCAwZmZiMGMwNDRlMy4uNjBmMmFl
ZDhlM2UgMTAwNjQ0Ci0tLSBhL3RhcmdldC1pbmZvLXFvbS5jCisrKyBiL3RhcmdldC1pbmZvLXFv
bS5jCkBAIC03LDEwICs3LDEzIEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNp
bmNsdWRlICJxZW11L2hlbHBfb3B0aW9uLmgiCiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgogI2lu
Y2x1ZGUgInFvbS9vYmplY3QuaCIKKyNpbmNsdWRlICJxZW11L3RhcmdldC1pbmZvLmgiCiAjaW5j
bHVkZSAicWVtdS90YXJnZXQtaW5mby1pbXBsLmgiCiAjaW5jbHVkZSAicWVtdS90YXJnZXQtaW5m
by1pbml0LmgiCisjaW5jbHVkZSAicWVtdS90YXJnZXQtaW5mby1xYXBpLmgiCiAjaW5jbHVkZSAi
cWVtdS90YXJnZXQtaW5mby1xb20uaCIKICNpbmNsdWRlICJody9hcm0vbWFjaGluZXMtcW9tLmgi
CiAjaW5jbHVkZSAiaHcvcmlzY3YvbWFjaGluZXMtcW9tLmgiCkBAIC0zNywyMSArNDAsOTMgQEAg
REVGSU5FX1RBUkdFVF9JTkZPX1RZUEUodGFyZ2V0X2luZm9fcGFyZW50X3R5cGUpCiAKIHN0YXRp
YyBjb25zdCBUYXJnZXRJbmZvICp0YXJnZXRfaW5mb19wdHI7CiAKKy8qCisgKiBGYWxsYmFjayB3
aGVuIC10YXJnZXQgaXMgb21pdHRlZCBhbmQgYXJndlswXSBpcyBxZW11LXN5c3RlbSAobm8KKyAq
IGFyY2ggc3VmZml4KS4gcWVtdS1zeXN0ZW0tKiBhbHdheXMgZ2V0cyBhIG5hbWUgZnJvbSBhcmd2
WzBdCisgKiAocWVtdS1zeXN0ZW0tYWFyY2g2NCAtPiBhYXJjaDY0KSwgc28gaXQgbmV2ZXIgc2Vs
ZWN0cyB0aGlzLgorICovCitzdGF0aWMgY29uc3QgVGFyZ2V0SW5mbyB0YXJnZXRfaW5mb191bnNw
ZWNpZmllZCA9IHsKKyAgICAudGFyZ2V0X25hbWUgPSAidW5zcGVjaWZpZWQiLAorICAgIC50YXJn
ZXRfYXJjaCA9IFNZU19FTVVfVEFSR0VUX1VOU1BFQ0lGSUVELAorICAgIC5sb25nX2JpdHMgPSA2
NCwKKyAgICAuY3B1X3R5cGUgPSAiIiwKKyAgICAuZW5kaWFubmVzcyA9IEVORElBTl9NT0RFX0xJ
VFRMRSwKKyAgICAucGFnZV9iaXRzX2luaXQgPSAxMiwKKyAgICAucGFnZV9iaXRzX3ZhcnkgPSB0
cnVlLAorfTsKKwogY29uc3QgVGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm8odm9pZCkKIHsKICAgICBy
ZXR1cm4gdGFyZ2V0X2luZm9fcHRyOwogfQogCi12b2lkIHRhcmdldF9pbmZvX3FvbV9zZXRfdGFy
Z2V0KHZvaWQpCitzdGF0aWMgdm9pZCBzZXRfdGFyZ2V0X2luZm8oY29uc3QgVGFyZ2V0SW5mbyAq
Y2hvc2VuKQoreworICAgIHRhcmdldF9pbmZvX3B0ciA9IGNob3NlbjsKK30KKworc3RhdGljIHZv
aWQgbGlzdF90YXJnZXRzX2F2YWlsYWJsZSh2b2lkKQoreworICAgIHByaW50ZigiTGlzdCBvZiB0
YXJnZXRzIGF2YWlsYWJsZTpcbiIpOworICAgIGdfYXV0b3B0cihHU0xpc3QpIHRhcmdldHMgPSBv
YmplY3RfY2xhc3NfZ2V0X2xpc3Rfc29ydGVkKFRZUEVfVEFSR0VUX0lORk8sIGZhbHNlKTsKKyAg
ICBmb3IgKEdTTGlzdCAqZWxlbSA9IHRhcmdldHM7IGVsZW07IGVsZW0gPSBlbGVtLT5uZXh0KSB7
CisgICAgICAgIGNvbnN0IFRhcmdldEluZm8gKnRpID0gVEFSR0VUX0lORk9fQ0xBU1MoZWxlbS0+
ZGF0YSktPnRhcmdldF9pbmZvOworICAgICAgICBwcmludGYoIi0gJXNcbiIsIHRpLT50YXJnZXRf
bmFtZSk7CisgICAgfQorfQorCisvKiBxZW11LXN5c3RlbS1hYXJjaDY0Wy5leGVdIC0+IGFhcmNo
NjQ7IHFlbXUtc3lzdGVtWy5leGVdIC0+IE5VTEwuICovCitzdGF0aWMgY29uc3QgY2hhciAqdGFy
Z2V0X2Zyb21fYXJndjAoY2hhciAqYmFzZSkKK3sKKyAgICBpZiAoZ19zdHJfaGFzX3ByZWZpeChi
YXNlLCAicWVtdS1zeXN0ZW0tIikpIHsKKyAgICAgICAgcmV0dXJuIGJhc2UgKyBzdHJsZW4oInFl
bXUtc3lzdGVtLSIpOworICAgIH0KKyAgICByZXR1cm4gTlVMTDsKK30KKwordm9pZCB0YXJnZXRf
aW5mb19xb21fc2V0X3RhcmdldChjb25zdCBjaGFyICpuYW1lLCBFcnJvciAqKmVycnApCiB7CiAg
ICAgZ19hdXRvcHRyKEdTTGlzdCkgdGFyZ2V0cyA9IG9iamVjdF9jbGFzc19nZXRfbGlzdChUWVBF
X1RBUkdFVF9JTkZPLCBmYWxzZSk7CiAKICAgICBzaXplX3QgbnVtX2ZvdW5kID0gZ19zbGlzdF9s
ZW5ndGgodGFyZ2V0cyk7Ci0gICAgaWYgKG51bV9mb3VuZCAhPSAxKSB7Ci0gICAgICAgIGVycm9y
X3NldGcoJmVycm9yX2ZhdGFsLCBudW1fZm91bmQgPT0gMCA/Ci0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAibm8gdGFyZ2V0LWluZm8gaXMgYXZhaWxhYmxlIiA6Ci0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAibW9yZSB0aGFuIG9uZSB0YXJnZXQtaW5mbyBpcyBhdmFp
bGFibGUiKTsKKyAgICBnX2F1dG9mcmVlIGNoYXIgKnByZ19iYXNlID0gTlVMTDsKKworICAgIGlm
IChudW1fZm91bmQgPT0gMCkgeworICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJubyB0YXJnZXQt
aW5mbyBpcyBhdmFpbGFibGUiKTsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKworICAgIGlmICgh
bmFtZSkgeworICAgICAgICBjb25zdCBjaGFyICpwcmcgPSBnX2dldF9wcmduYW1lKCk7CisgICAg
ICAgIGlmIChwcmcgJiYgcHJnWzBdKSB7CisgICAgICAgICAgICBjaGFyICpkb3Q7CisKKyAgICAg
ICAgICAgIHByZ19iYXNlID0gZ19wYXRoX2dldF9iYXNlbmFtZShwcmcpOworICAgICAgICAgICAg
ZG90ID0gc3RycmNocihwcmdfYmFzZSwgJy4nKTsKKyAgICAgICAgICAgIGlmIChkb3QgJiYgZ19h
c2NpaV9zdHJjYXNlY21wKGRvdCwgIi5leGUiKSA9PSAwKSB7CisgICAgICAgICAgICAgICAgKmRv
dCA9ICdcMCc7CisgICAgICAgICAgICB9CisgICAgICAgICAgICBuYW1lID0gdGFyZ2V0X2Zyb21f
YXJndjAocHJnX2Jhc2UpOworICAgICAgICB9CisgICAgfQorCisgICAgaWYgKG5hbWUpIHsKKyAg
ICAgICAgaWYgKGlzX2hlbHBfb3B0aW9uKG5hbWUpKSB7CisgICAgICAgICAgICBsaXN0X3Rhcmdl
dHNfYXZhaWxhYmxlKCk7CisgICAgICAgICAgICBleGl0KDApOworICAgICAgICB9CisgICAgICAg
IGZvciAoR1NMaXN0ICplbGVtID0gdGFyZ2V0czsgZWxlbTsgZWxlbSA9IGVsZW0tPm5leHQpIHsK
KyAgICAgICAgICAgIGNvbnN0IFRhcmdldEluZm8gKnRpID0gVEFSR0VUX0lORk9fQ0xBU1MoZWxl
bS0+ZGF0YSktPnRhcmdldF9pbmZvOworICAgICAgICAgICAgaWYgKCFzdHJjbXAobmFtZSwgdGkt
PnRhcmdldF9uYW1lKSkgeworICAgICAgICAgICAgICAgIHNldF90YXJnZXRfaW5mbyh0aSk7Cisg
ICAgICAgICAgICAgICAgcmV0dXJuOworICAgICAgICAgICAgfQorICAgICAgICB9CisgICAgICAg
IGVycm9yX3NldGcoZXJycCwgInRhcmdldCAnJXMnIGlzIG5vdCBhdmFpbGFibGUsICIKKyAgICAg
ICAgICAgICAgICAgICAidXNlIC10YXJnZXQgPyB0byBsaXN0IGF2YWlsYWJsZSB0YXJnZXRzIiwg
bmFtZSk7CisgICAgICAgIHJldHVybjsKICAgICB9CiAKLSAgICB0YXJnZXRfaW5mb19wdHIgPSBU
QVJHRVRfSU5GT19DTEFTUyh0YXJnZXRzLT5kYXRhKS0+dGFyZ2V0X2luZm87CisgICAgLyogTm90
IHJlYWNoZWQgZm9yIHFlbXUtc3lzdGVtLSo6IG5hbWUgY2FtZSBmcm9tIHRoZSBhcmd2WzBdIHN1
ZmZpeC4gKi8KKyAgICBzZXRfdGFyZ2V0X2luZm8oJnRhcmdldF9pbmZvX3Vuc3BlY2lmaWVkKTsK
IH0KZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2Z1enovZnV6ei5jIGIvdGVzdHMvcXRlc3QvZnV6
ei9mdXp6LmMKaW5kZXggYTNhMTMxYzgwZjguLmM5OTJmYWI0MDc5IDEwMDY0NAotLS0gYS90ZXN0
cy9xdGVzdC9mdXp6L2Z1enouYworKysgYi90ZXN0cy9xdGVzdC9mdXp6L2Z1enouYwpAQCAtMTc0
LDcgKzE3NCw3IEBAIGludCBMTFZNRnV6emVySW5pdGlhbGl6ZShpbnQgKmFyZ2MsIGNoYXIgKioq
YXJndiwgY2hhciAqKiplbnZwKQogICAgIC8qIEluaXRpYWxpemUgcWdyYXBoIGFuZCBtb2R1bGVz
ICovCiAgICAgcW9zX2dyYXBoX2luaXQoKTsKICAgICBtb2R1bGVfY2FsbF9pbml0KE1PRFVMRV9J
TklUX1RBUkdFVF9JTkZPKTsKLSAgICB0YXJnZXRfaW5mb19xb21fc2V0X3RhcmdldCgpOworICAg
IHRhcmdldF9pbmZvX3FvbV9zZXRfdGFyZ2V0KGZ1enpfYXJjaCwgJmVycm9yX2ZhdGFsKTsKICAg
ICBtb2R1bGVfY2FsbF9pbml0KE1PRFVMRV9JTklUX0ZVWlpfVEFSR0VUKTsKICAgICBtb2R1bGVf
Y2FsbF9pbml0KE1PRFVMRV9JTklUX1FPTSk7CiAgICAgbW9kdWxlX2NhbGxfaW5pdChNT0RVTEVf
SU5JVF9MSUJRT1MpOwotLSAKMi41Mi4wLndpbmRvd3MuMQoK
--000000000000765ee8065a571a0a--

