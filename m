Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7D3C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11Mu-0002PH-5S; Mon, 31 Aug 2026 08:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x11Ms-0002Ou-BY
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 08:44:06 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x11Mp-0007sn-T9
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 08:44:06 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso685923666b.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788180242; cv=none;
 d=google.com; s=arc-20260327;
 b=Z8FoheSs0zli6rFdb2ivKqdPU1Zvs6qh67uTqTiIOlXipS+7wrhHo3FhPCkY0MZEMS
 NzuKoGmdcIh/IwkYJxjncWUHuTopLen/m+JjT19dlsOylU4o+sfHhk74VVWpV0kYgv1Y
 yzHvSuUYWQvQFUrsUZh43WcHNoWNIg1fZbyUMVfQquf+okNTR64jukEDB0kWorcliKj/
 EEonptzKr0rMEtP/oQX60Csv0PT6LuaIeI7gDjfCREXiL1NknArSgZ+lAHKciMaYk4q7
 ghR4KDUGcPaXKDkbWnUBSr81wq0XMD1XZORLMyCxR8kWSCM4l6Ne9LtQgz46Ff+99/aP
 0Hcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iNkHgJ9cHGW5jB20Epwmf6KRy0gJMH4B4lr9ZGqaXJk=;
 fh=dLrxXhNFLYOe0h//qW0yf246b4AxzSerEDHU468ijm8=;
 b=dMr0My2FEtkF1V+BuxD/X68VAuFmzEHxpczwmKBQ4+IOvKYEUYoc6jUMrF6bD/7/C4
 7133+jb1gfy4OYo+Ij250ouWA4bO2PqAaH1jLFc9X9zkORjUmRELes15Q+z0haEpSOm/
 tPMoNRj2eSu2Ht+8LEFdqbpvZg3lcUr3KLifsiQICSWp0resRN4Xt0nG9RPU+j7UnW3A
 OAQ2rsyAOBFoHNBTtZl/Heclb91nHhiFbgTyZj69wcqaQ9qTpze5UniwBXQPgIPCvDi2
 Z6uY9U76ZU8jFh+Fpc/BnZx/OSERqJheDoa9iuJSfzZfaLIiWrETnzdrVE/ZLHUPRDZX
 6oUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788180242; x=1788785042; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iNkHgJ9cHGW5jB20Epwmf6KRy0gJMH4B4lr9ZGqaXJk=;
 b=s6cfcipRvPNwm6Xu0iiH+lh0HfYNdHx8eqt6ZUyNXB54EcupczmWAbhSLI6FjYWzw2
 yDPgYEpPMvYAPUWOeTcT8bAc2ApenTpeqdACcqy/o8YCg9woMWsCiA+eX8Gf9CtNVS3x
 GfUfEebtfAhcMN1JNzuGqsj8SHS+oUhrqMNUcb60wqRFyrbveqsIuMzk39Sa6lxDwCgw
 NmDuflP5tec3Jqn5YhNyTNzlL1PoQSjp0z6AxP2bUZvdJLNIDJMcsRja/MAMfA0WSeVZ
 XS/d6qR5UI5SWcNiaOWl7HjHM+ZZ1W+j/NyrlozIrSrxR8NyIA3uJNzWNUkWBtOBUExR
 ZjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788180242; x=1788785042;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iNkHgJ9cHGW5jB20Epwmf6KRy0gJMH4B4lr9ZGqaXJk=;
 b=adp8B1i/1dvEPczbl08Vi1BQqmomBNk/6j9bgFI7ZioIQIxgS98gfd+M9xZ4EKz99O
 samp7EeW2m7SBuBiTHLq58V+Z275rPHRGsU2j1RYusoIKPXVK36cBf5egy4JoS/uYC1D
 g78IiNLXCZ+oKU8PjAmyQt9YX6f1+cqiNCuSKDz7UWYeRtKM6MCAJb4A5qYMYwWRUWS+
 IetTyUooi7pJ7PDrtirLnHiasXeJFq+oy5OKAvYTwH/NTAn5EANG3BDhxIrBh0+ZRp68
 IGtrywD1Pd0sA46r8YIp9bgyr6xPcCDMHdp/oxdEko36JU3KLtrY2sFyCgtPTwZiFAcz
 sugA==
X-Gm-Message-State: AFuF++nEllgpzkT64UMeF5r5krnTdRcidiupPtxeiim1ME/2V7M8lEu4
 /m1ML4Hax/aIwjppiN+Ea5TUluDZgf4e59dfetYXK3vMl4QxhBWPamOOMCqb6ljSpgkcZZxcMUv
 F+PctqbFlEEu1a6eiJjcholrrDxANwdU=
X-Gm-Gg: AR+sD10SniUQz+Dx8zqYG58aVbMfKLdJUnXEqB3fVG424AzPtf6AhZgjoJaCH2O7cTw
 Db3bcpDgtnJgTY6YmDgf4eGw6zQjwnRLFm4jI4ouKkH5UNSedCXyWVZ6dt/9nWCPxZa5ojx17Bg
 P8r5Dz6eyxXOl2ehopsJqiTfFaBi4SLButUULFz/X3B/9ozMMt5/2hrdQuOtNLnGWqQAS/x2qdl
 JAMlNhcWhkylLZvurmjh0srlCczGH+8Sc5b7vUwOcIHY62/iv23osTOo0kScD94iOVGd+CPEhAu
 2wOgGwxagJz/3cQAoT6lmg7C0H+WTgAe7u1OV2poH9VxmA==
X-Received: by 2002:a17:906:99d4:b0:c25:3e36:acc8 with SMTP id
 a640c23a62f3a-c25966d7ff6mr474060766b.4.1788180241982; Mon, 31 Aug 2026
 05:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-38-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-38-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 31 Aug 2026 20:43:49 +0800
X-Gm-Features: AcwNN1XcH8X4eoeeyGDBiwJ-Yl-P66faMaW8VArd6SjC-5yG6db5lcZiRVtJw84
Message-ID: <CAE2XoE9NXdtkgAAL_B2842aOoOU=2cc1vEdprb5QDQSY9Rwy-Q@mail.gmail.com>
Subject: Re: [PATCH 37/47] hw/core/boards.h: add available callback to
 DEFINE_MACHINE_EXTENDED
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, anjo@rev.ng, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001e36ac065a572882"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x631.google.com
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

--0000000000001e36ac065a572882
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This change is minimal, I think it's can use proper target_is_* in this
patch(maybe). so we have no need change it twice.

On Sat, Aug 29, 2026 at 7:03=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  hw/arm/bananapi_m2u.c    |  2 +-
>  hw/arm/cubieboard.c      |  2 +-
>  hw/arm/integratorcp.c    |  2 +-
>  hw/arm/mcimx7d-sabre.c   |  2 +-
>  hw/arm/musicpal.c        |  2 +-
>  hw/arm/orangepi.c        |  2 +-
>  hw/ppc/pegasos.c         |  2 +-
>  include/hw/core/boards.h | 10 ++++++----
>  8 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> index 8f59111fd4e..7b86986efb1 100644
> --- a/hw/arm/bananapi_m2u.c
> +++ b/hw/arm/bananapi_m2u.c
> @@ -153,4 +153,4 @@ static void bpim2u_machine_init(MachineClass *mc)
>  }
>
>  DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
> -                        bpim2u_machine_init, false, NULL)
> +                        bpim2u_machine_init, false, NULL, NULL)
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index ae27056938f..da45bb2be52 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -134,4 +134,4 @@ static void cubieboard_machine_init(MachineClass *mc)
>
>  DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
>                          cubieboard_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 382ea7850d8..6314bbb6c13 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -705,7 +705,7 @@ static void integratorcp_machine_init(MachineClass
*mc)
>
>  DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE,
IntegratorcpMachineState,
>                          integratorcp_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
>
>  static const Property core_properties[] =3D {
>      DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
> diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
> index db8a62e5f6c..2c884b5c78f 100644
> --- a/hw/arm/mcimx7d-sabre.c
> +++ b/hw/arm/mcimx7d-sabre.c
> @@ -87,4 +87,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc=
)
>
>  DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE,
Mcimx7dSabreMachineState,
>                          mcimx7d_sabre_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index e1a336e861a..52805e41892 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1365,7 +1365,7 @@ static void musicpal_machine_init(MachineClass *mc)
>
>  DEFINE_MACHINE_EXTENDED("musicpal", MACHINE, MusicPalMachineState,
>                          musicpal_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
>
>  static void mv88w8618_wlan_class_init(ObjectClass *klass, const void
*data)
>  {
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 7a19732f5df..87ed2ef4b69 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -134,4 +134,4 @@ static void orangepi_machine_init(MachineClass *mc)
>
>  DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
>                          orangepi_machine_init, false,
> -                        NULL)
> +                        NULL, NULL)
> diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
> index 9d7e279123b..ad8aca85ab3 100644
> --- a/hw/ppc/pegasos.c
> +++ b/hw/ppc/pegasos.c
> @@ -788,7 +788,7 @@ static void pegasos2_machine_class_init(ObjectClass
*oc, const void *data)
>  }
>
>  DEFINE_MACHINE_EXTENDED("pegasos", MACHINE, PegasosMachineState,
> -                        pegasos_machine_init, true, (const
InterfaceInfo[]) {
> +                        pegasos_machine_init, true, NULL, (const
InterfaceInfo[]) {
>                          { TYPE_PPC_VIRTUAL_HYPERVISOR },
>                          { TYPE_VOF_MACHINE_IF }, { } })
>
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index a436d48c8e5..2e2acdb6867 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -514,7 +514,8 @@ struct MachineState {
>   */
>
>  #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
> -                                machine_initfn, ABSTRACT, ifaces...) \
> +                                machine_initfn, ABSTRACT, available_cb, =
\
> +                                ifaces...) \
>      static void machine_initfn##_class_init(ObjectClass *oc, const void
*data) \
>      { \
>          MachineClass *mc =3D MACHINE_CLASS(oc); \
> @@ -526,6 +527,7 @@ struct MachineState {
>          .class_init =3D machine_initfn##_class_init, \
>          .instance_size =3D sizeof(InstanceName), \
>          .abstract =3D ABSTRACT, \
> +        .is_available =3D available_cb, \
>          .interfaces =3D ifaces, \
>      }; \
>      static void machine_initfn##_register_types(void) \
> @@ -536,14 +538,14 @@ struct MachineState {
>
>  #define DEFINE_MACHINE(namestr, machine_initfn) \
>      DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState,
machine_initfn, \
> -                            false, NULL)
> +                            false, NULL, NULL)
>
>  #define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn,
ifaces...)\
>      DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState,
machine_initfn, \
> -                            false, ifaces)
> +                            false, NULL, ifaces)
>
>  #define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
> -    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
> +    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, NULL, \
>                                          (const InterfaceInfo[]) {
__VA_ARGS__ })
>
>  /*
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

--0000000000001e36ac065a572882
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This change is minimal, I think it&#39;s can use proper ta=
rget_is_* in this patch(maybe). so we have no need change it twice.<br><br>=
On Sat, Aug 29, 2026 at 7:03=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mai=
lto:pierrick.bouvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a=
>&gt; wrote:<br>&gt;<br>&gt; Signed-off-by: Pierrick Bouvier &lt;<a href=3D=
"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.co=
m</a>&gt;<br>&gt; ---<br>&gt; =C2=A0hw/arm/bananapi_m2u.c =C2=A0 =C2=A0| =
=C2=A02 +-<br>&gt; =C2=A0hw/arm/cubieboard.c =C2=A0 =C2=A0 =C2=A0| =C2=A02 =
+-<br>&gt; =C2=A0hw/arm/integratorcp.c =C2=A0 =C2=A0| =C2=A02 +-<br>&gt; =
=C2=A0hw/arm/mcimx7d-sabre.c =C2=A0 | =C2=A02 +-<br>&gt; =C2=A0hw/arm/music=
pal.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A02 +-<br>&gt; =C2=A0hw/arm/orangepi=
.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A02 +-<br>&gt; =C2=A0hw/ppc/pegasos.c =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A02 +-<br>&gt; =C2=A0include/hw/core/boar=
ds.h | 10 ++++++----<br>&gt; =C2=A08 files changed, 13 insertions(+), 11 de=
letions(-)<br>&gt;<br>&gt; diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bana=
napi_m2u.c<br>&gt; index 8f59111fd4e..7b86986efb1 100644<br>&gt; --- a/hw/a=
rm/bananapi_m2u.c<br>&gt; +++ b/hw/arm/bananapi_m2u.c<br>&gt; @@ -153,4 +15=
3,4 @@ static void bpim2u_machine_init(MachineClass *mc)<br>&gt; =C2=A0}<br=
>&gt;<br>&gt; =C2=A0DEFINE_MACHINE_EXTENDED(&quot;bpim2u&quot;, MACHINE, Bp=
im2uMachineState,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bpim2u_machine_init, false, NULL)<br>=
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bpim2u_machine_init, false, NULL, NULL)<br>&gt; diff --git=
 a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c<br>&gt; index ae27056938f..da4=
5bb2be52 100644<br>&gt; --- a/hw/arm/cubieboard.c<br>&gt; +++ b/hw/arm/cubi=
eboard.c<br>&gt; @@ -134,4 +134,4 @@ static void cubieboard_machine_init(Ma=
chineClass *mc)<br>&gt;<br>&gt; =C2=A0DEFINE_MACHINE_EXTENDED(&quot;cubiebo=
ard&quot;, MACHINE, CubieboardMachineState,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cubieb=
oard_machine_init, false,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL)<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, =
NULL)<br>&gt; diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c<br=
>&gt; index 382ea7850d8..6314bbb6c13 100644<br>&gt; --- a/hw/arm/integrator=
cp.c<br>&gt; +++ b/hw/arm/integratorcp.c<br>&gt; @@ -705,7 +705,7 @@ static=
 void integratorcp_machine_init(MachineClass *mc)<br>&gt;<br>&gt; =C2=A0DEF=
INE_MACHINE_EXTENDED(&quot;integratorcp&quot;, MACHINE, IntegratorcpMachine=
State,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0integratorcp_machine_init, false,<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL)<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL)<br>&gt;<br>&gt; =C2=A0static =
const Property core_properties[] =3D {<br>&gt; =C2=A0 =C2=A0 =C2=A0DEFINE_P=
ROP_UINT32(&quot;memsz&quot;, IntegratorCMState, memsz, 0),<br>&gt; diff --=
git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c<br>&gt; index db8a62e=
5f6c..2c884b5c78f 100644<br>&gt; --- a/hw/arm/mcimx7d-sabre.c<br>&gt; +++ b=
/hw/arm/mcimx7d-sabre.c<br>&gt; @@ -87,4 +87,4 @@ static void mcimx7d_sabre=
_machine_init(MachineClass *mc)<br>&gt;<br>&gt; =C2=A0DEFINE_MACHINE_EXTEND=
ED(&quot;mcimx7d-sabre&quot;, MACHINE, Mcimx7dSabreMachineState,<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mcimx7d_sabre_machine_init, false,<br>&gt; - =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL)=
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0NULL, NULL)<br>&gt; diff --git a/hw/arm/musicpal.c b/hw=
/arm/musicpal.c<br>&gt; index e1a336e861a..52805e41892 100644<br>&gt; --- a=
/hw/arm/musicpal.c<br>&gt; +++ b/hw/arm/musicpal.c<br>&gt; @@ -1365,7 +1365=
,7 @@ static void musicpal_machine_init(MachineClass *mc)<br>&gt;<br>&gt; =
=C2=A0DEFINE_MACHINE_EXTENDED(&quot;musicpal&quot;, MACHINE, MusicPalMachin=
eState,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0musicpal_machine_init, false,<br>&gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0NULL)<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL)<br>&gt;<br>&gt; =C2=A0static voi=
d mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)<br>&gt; =
=C2=A0{<br>&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>&gt; =
index 7a19732f5df..87ed2ef4b69 100644<br>&gt; --- a/hw/arm/orangepi.c<br>&g=
t; +++ b/hw/arm/orangepi.c<br>&gt; @@ -134,4 +134,4 @@ static void orangepi=
_machine_init(MachineClass *mc)<br>&gt;<br>&gt; =C2=A0DEFINE_MACHINE_EXTEND=
ED(&quot;orangepi-pc&quot;, MACHINE, OrangePiMachineState,<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0orangepi_machine_init, false,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL)<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL, NULL)<br>&gt; diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegaso=
s.c<br>&gt; index 9d7e279123b..ad8aca85ab3 100644<br>&gt; --- a/hw/ppc/pega=
sos.c<br>&gt; +++ b/hw/ppc/pegasos.c<br>&gt; @@ -788,7 +788,7 @@ static voi=
d pegasos2_machine_class_init(ObjectClass *oc, const void *data)<br>&gt; =
=C2=A0}<br>&gt;<br>&gt; =C2=A0DEFINE_MACHINE_EXTENDED(&quot;pegasos&quot;, =
MACHINE, PegasosMachineState,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pegasos_machine_init, true,=
 (const InterfaceInfo[]) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pegasos_machine_init, true, NU=
LL, (const InterfaceInfo[]) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ TYPE_PPC_VIRTUAL_H=
YPERVISOR },<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ TYPE_VOF_MACHINE_IF }, { } })<br>&g=
t;<br>&gt; diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h=
<br>&gt; index a436d48c8e5..2e2acdb6867 100644<br>&gt; --- a/include/hw/cor=
e/boards.h<br>&gt; +++ b/include/hw/core/boards.h<br>&gt; @@ -514,7 +514,8 =
@@ struct MachineState {<br>&gt; =C2=A0 */<br>&gt;<br>&gt; =C2=A0#define DE=
FINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \<br>&gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_initfn, ABSTRACT, ifaces...) \<br=
>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_initfn, ABSTRACT, avai=
lable_cb, \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ifaces...) \<br>=
&gt; =C2=A0 =C2=A0 =C2=A0static void machine_initfn##_class_init(ObjectClas=
s *oc, const void *data) \<br>&gt; =C2=A0 =C2=A0 =C2=A0{ \<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0MachineClass *mc =3D MACHINE_CLASS(oc); \<br>&gt=
; @@ -526,6 +527,7 @@ struct MachineState {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.class_init =3D machine_initfn##_class_init, \<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(InstanceName), \<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.abstract =3D ABSTRACT, \<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0.is_available =3D available_cb, \<br>&gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0.interfaces =3D ifaces, \<br>&gt; =C2=A0 =C2=A0=
 =C2=A0}; \<br>&gt; =C2=A0 =C2=A0 =C2=A0static void machine_initfn##_regist=
er_types(void) \<br>&gt; @@ -536,14 +538,14 @@ struct MachineState {<br>&gt=
;<br>&gt; =C2=A0#define DEFINE_MACHINE(namestr, machine_initfn) \<br>&gt; =
=C2=A0 =C2=A0 =C2=A0DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState,=
 machine_initfn, \<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0false, NULL)<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0false, NULL, NULL)<br>&gt;<br>&gt; =C2=A0#define DE=
FINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...)\<br>&=
gt; =C2=A0 =C2=A0 =C2=A0DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineSt=
ate, machine_initfn, \<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0false, ifaces)<br>&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0false, NULL, ifaces)<br>&gt;<br>&gt; =C2=A0#defi=
ne DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \<br>&gt; -=
 =C2=A0 =C2=A0DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, =
\<br>&gt; + =C2=A0 =C2=A0DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machi=
ne_initfn, NULL, \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(const InterfaceInfo[]) { __VA_ARGS__ })<br>&gt;<br=
>&gt; =C2=A0/*<br>&gt; --<br>&gt; 2.43.0<br>&gt;<br>&gt;<br><br><br>--<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div>

--0000000000001e36ac065a572882--

