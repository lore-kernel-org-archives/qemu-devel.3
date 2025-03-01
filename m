Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4908BC282C5
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 01:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toBFU-0001Ru-Q6; Fri, 28 Feb 2025 20:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuqin12@gmail.com>)
 id 1toBFS-0001RC-G3; Fri, 28 Feb 2025 20:02:34 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kuqin12@gmail.com>)
 id 1toBFQ-0002Np-E6; Fri, 28 Feb 2025 20:02:34 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6e8992f9a45so16874186d6.0; 
 Fri, 28 Feb 2025 17:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740790949; x=1741395749; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SQlSNoHmWACKiW0B8FvbEITjcLevPe4EgEizJSu8Ex0=;
 b=h/F20yOHRSL/x+Q2/TwJmJERPjmO7CsyEgZU+GB6FCzqj1A/InaHfCj620uk6Np6S2
 jfLUxntNTJXBQ8Q9nvMV7G9TdRF6r2H16zMPreW3GLpa0GWCMArmr6MWO5ANrsZBsPW6
 DOpLx8ywLhm4M4/utS+adaBFrDaSRdTAZKtq8Oejezykv4cDwN0OhUhzr+4cleZGYjaQ
 55OtnkxrgLrg4Q/Zmfsi3C+b0+2mgpEz/Rt4nYthNjdy1FSTPx4EWmEIqNpe5M08qHQS
 Sx14gIbG1Rnfbvgi/xCK62+RodOd5q14KIR9MhnCPwfiRMmLsOK/iRVLaw5M7E/Z9V6e
 GjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740790949; x=1741395749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQlSNoHmWACKiW0B8FvbEITjcLevPe4EgEizJSu8Ex0=;
 b=RQNON7I5sNTCrbw84js7/XVAz/EcEP/ivkGlCr0LlaO1bKe03CjwwJTcXeOQpe0qQL
 uzVpOwYTyh72Woq56YQh4gP5r43Pmvs7Scjcfe0ngNCsu2IehPVaMdPh9C9zv4l2oY21
 +j2hSRYPdgL9ehpFB7gZH882Es4y99+CTZ0VqVQ5fjleyo1BOxPRKwKGz1QjaCabgVJH
 Mmlm+upW36d9WMDTNFXxW6RgjgXeu3/jalKQJRI7vkMJZKO5eL8iE9lnDoI6ItVEnVZM
 YhL+9KBo3TWT6syHfHje7FTfgEWkQ9eb1MV9a6iDzAuTjHlcWpUylQmd6hAu3/hvG2CK
 ifdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBh52AZepecbO/bw/93ifNXfHFN48kbA53V0RlIQxyphlpWfI2Fy8as9CJ5l84QvZss3MRq/TQGw==@nongnu.org
X-Gm-Message-State: AOJu0YwI+YV0UXEQCtotUbp2/8/r9jPH3EIB+98mAcVVYqa/P+H5Juqw
 AkORu4uKYPdr1lkZq8vTxGvl7UvgITEUSw1TpllPOiccrojedytQ9+v/K44knFCG5QiaGaL9iss
 iX3xFTlfxDyJDib4MLxjRuVJw0us=
X-Gm-Gg: ASbGncv/12H52gY5g3fBB/bSKS2JvkzZjruXiMP0eD6DKZuwInONbfMnU93nwHOAYfV
 VPBIlxBrLJQhYBeFdLUGnXa60ZP4rq6ccBY2fabolY6UfU8qOw2/xjzbNCPhh1wK+TwCLuNyHnB
 hleTsZouF/MG2wtkawwHB6AXZ5YOdbAyqHErgXqB9rUfh9yzVCuf9TURI=
X-Google-Smtp-Source: AGHT+IEYwENjJxwmSNbBCuLIEPt795yjneYsfoO7cSfPY3E/RYl7J5JrKMVQ8ChUUNHWUODO+1KD11gaYXt745WqJIA=
X-Received: by 2002:ad4:5ba3:0:b0:6e4:4274:aaf8 with SMTP id
 6a1803df08f44-6e8a0d01c27mr84585336d6.17.1740790948794; Fri, 28 Feb 2025
 17:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20250225074133.6827-1-kuqin12@gmail.com>
 <20250225074133.6827-2-kuqin12@gmail.com>
 <f9400b1e-e36d-486c-bea7-115a742befd4@xora.org.uk>
In-Reply-To: <f9400b1e-e36d-486c-bea7-115a742befd4@xora.org.uk>
From: Kun Qin <kuqin12@gmail.com>
Date: Fri, 28 Feb 2025 17:02:18 -0800
X-Gm-Features: AQ5f1JqtxKaMBG7_Pq0Mi83aeI5dJwWzfKv_RatWiITqQd3YR2Q--s_6MQFw1dc
Message-ID: <CABhrWrSwD8b-CapYsogwKkab08NDoDZc8t6HoxMROCK6uWPLUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: Adding TPM support for ARM SBSA-Ref
 machine
To: Graeme Gregory <graeme@xora.org.uk>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kun Qin <kuqin@microsoft.com>
Content-Type: multipart/alternative; boundary="000000000000219af1062f3d7a5c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=kuqin12@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000219af1062f3d7a5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Graeme,

Thank you for your review. Could you please let me know if there is
anything else I need to do or wait on before merging the change?

Any input is appreciated.

Regards,
Kun



On Thu, Feb 27, 2025 at 7:16=E2=80=AFAM Graeme Gregory <graeme@xora.org.uk>=
 wrote:

>
> On 25/02/2025 07:41, Kun Qin wrote:
> > From: Kun Qin <kuqin@microsoft.com>
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2625
> >
> > This change aims to add a TPM device for SBSA ref machine.
> >
> > The implementation adds a TPM create routine during machine
> > initialization.
> >
> > The backend can be the same as the rest of TPM support, by using swtpm.
>
> This looks sensible to me.
>
> Reviewed-by: Graeme Gregory <graeme@xora.org.uk>
>
> > Signed-off-by: Kun Qin <kuqin12@gmail.com>
> > ---
> >   hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index e720de306419..93eb3d1e363b 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -28,6 +28,8 @@
> >   #include "system/numa.h"
> >   #include "system/runstate.h"
> >   #include "system/system.h"
> > +#include "system/tpm.h"
> > +#include "system/tpm_backend.h"
> >   #include "exec/hwaddr.h"
> >   #include "kvm_arm.h"
> >   #include "hw/arm/boot.h"
> > @@ -94,6 +96,7 @@ enum {
> >       SBSA_SECURE_MEM,
> >       SBSA_AHCI,
> >       SBSA_XHCI,
> > +    SBSA_TPM,
> >   };
> >
> >   struct SBSAMachineState {
> > @@ -132,6 +135,7 @@ static const MemMapEntry sbsa_ref_memmap[] =3D {
> >       /* Space here reserved for more SMMUs */
> >       [SBSA_AHCI] =3D               { 0x60100000, 0x00010000 },
> >       [SBSA_XHCI] =3D               { 0x60110000, 0x00010000 },
> > +    [SBSA_TPM] =3D                { 0x60120000, 0x00010000 },
> >       /* Space here reserved for other devices */
> >       [SBSA_PCIE_PIO] =3D           { 0x7fff0000, 0x00010000 },
> >       /* 32-bit address PCIE MMIO space */
> > @@ -629,6 +633,24 @@ static void create_smmu(const SBSAMachineState
> *sms, PCIBus *bus)
> >       }
> >   }
> >
> > +static void create_tpm(SBSAMachineState *sbsa, PCIBus *bus)
> > +{
> > +    Error *errp =3D NULL;
> > +    DeviceState *dev;
> > +
> > +    TPMBackend *be =3D qemu_find_tpm_be("tpm0");
> > +    if (be =3D=3D NULL) {
> > +        error_report("Couldn't find tmp0 backend");
> > +        return;
> > +    }
> > +
> > +    dev =3D qdev_new(TYPE_TPM_TIS_SYSBUS);
> > +    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp)=
;
> > +    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
> sbsa_ref_memmap[SBSA_TPM].base);
> > +}
> > +
> >   static void create_pcie(SBSAMachineState *sms)
> >   {
> >       hwaddr base_ecam =3D sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> > @@ -686,6 +708,8 @@ static void create_pcie(SBSAMachineState *sms)
> >       pci_create_simple(pci->bus, -1, "bochs-display");
> >
> >       create_smmu(sms, pci->bus);
> > +
> > +    create_tpm(sms, pci->bus);
> >   }
> >
> >   static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int
> *fdt_size)
>

--000000000000219af1062f3d7a5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Graeme,<div><br></div><div>Thank you for=C2=A0your=
 review. Could you please let me know if there=C2=A0is anything else I need=
 to do or wait on before merging the change?</div><div><br></div><div>Any i=
nput is=C2=A0appreciated.</div><div><br></div><div>Regards,</div><div>Kun<b=
r><div><br></div><div><br></div></div></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 27,=
 2025 at 7:16=E2=80=AFAM Graeme Gregory &lt;<a href=3D"mailto:graeme@xora.o=
rg.uk">graeme@xora.org.uk</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><br>
On 25/02/2025 07:41, Kun Qin wrote:<br>
&gt; From: Kun Qin &lt;<a href=3D"mailto:kuqin@microsoft.com" target=3D"_bl=
ank">kuqin@microsoft.com</a>&gt;<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/262=
5" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2625</a><br>
&gt;<br>
&gt; This change aims to add a TPM device for SBSA ref machine.<br>
&gt;<br>
&gt; The implementation adds a TPM create routine during machine<br>
&gt; initialization.<br>
&gt;<br>
&gt; The backend can be the same as the rest of TPM support, by using swtpm=
.<br>
<br>
This looks sensible to me.<br>
<br>
Reviewed-by: Graeme Gregory &lt;<a href=3D"mailto:graeme@xora.org.uk" targe=
t=3D"_blank">graeme@xora.org.uk</a>&gt;<br>
<br>
&gt; Signed-off-by: Kun Qin &lt;<a href=3D"mailto:kuqin12@gmail.com" target=
=3D"_blank">kuqin12@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 24 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c<br>
&gt; index e720de306419..93eb3d1e363b 100644<br>
&gt; --- a/hw/arm/sbsa-ref.c<br>
&gt; +++ b/hw/arm/sbsa-ref.c<br>
&gt; @@ -28,6 +28,8 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;system/numa.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;system/runstate.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;system/system.h&quot;<br>
&gt; +#include &quot;system/tpm.h&quot;<br>
&gt; +#include &quot;system/tpm_backend.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;exec/hwaddr.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;kvm_arm.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/arm/boot.h&quot;<br>
&gt; @@ -94,6 +96,7 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SBSA_SECURE_MEM,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SBSA_AHCI,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SBSA_XHCI,<br>
&gt; +=C2=A0 =C2=A0 SBSA_TPM,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0struct SBSAMachineState {<br>
&gt; @@ -132,6 +135,7 @@ static const MemMapEntry sbsa_ref_memmap[] =3D {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Space here reserved for more SMMUs */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[SBSA_AHCI] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x60100000, 0x00010000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[SBSA_XHCI] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x60110000, 0x00010000 },<br>
&gt; +=C2=A0 =C2=A0 [SBSA_TPM] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 { 0x60120000, 0x00010000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Space here reserved for other devices */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[SBSA_PCIE_PIO] =3D=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{ 0x7fff0000, 0x00010000 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 32-bit address PCIE MMIO space */<br>
&gt; @@ -629,6 +633,24 @@ static void create_smmu(const SBSAMachineState *s=
ms, PCIBus *bus)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void create_tpm(SBSAMachineState *sbsa, PCIBus *bus)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Error *errp =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *dev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 TPMBackend *be =3D qemu_find_tpm_be(&quot;tpm0&quot;);<=
br>
&gt; +=C2=A0 =C2=A0 if (be =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Couldn&#39;t find tmp0=
 backend&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev =3D qdev_new(TYPE_TPM_TIS_SYSBUS);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_link(OBJECT(dev), &quot;tpmdev&quot=
;, OBJECT(be), &amp;errp);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_str(OBJECT(dev), &quot;tpmdev&quot;=
, be-&gt;id, &amp;errp);<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &amp;erro=
r_fatal);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, sbsa_ref_memmap=
[SBSA_TPM].base);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void create_pcie(SBSAMachineState *sms)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr base_ecam =3D sbsa_ref_memmap[SBSA_PC=
IE_ECAM].base;<br>
&gt; @@ -686,6 +708,8 @@ static void create_pcie(SBSAMachineState *sms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_create_simple(pci-&gt;bus, -1, &quot;boc=
hs-display&quot;);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create_smmu(sms, pci-&gt;bus);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 create_tpm(sms, pci-&gt;bus);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void *sbsa_ref_dtb(const struct arm_boot_info *binf=
o, int *fdt_size)<br>
</blockquote></div>

--000000000000219af1062f3d7a5c--

