Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BAAE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOK15-0005gL-Ql; Thu, 19 Dec 2024 12:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOK13-0005g8-7L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOK10-00052u-QZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734628125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Eg2wUNdtaL4kmVQAk0GWvYcQ9MBYiq3VF2WXBhPOtA=;
 b=XQfHAZP8wEWsJnkw8rJTDfZ92HO7PyXZ0xNSNJrB5Fr7B390aWso8Jz62nogXPuHyeutjX
 AKYyRMYTrvxLtJBkO3kHvhT2CVAh6+rDubZr7+jG9zVGS6joyOIqF+k6arvqi1eMjTT68e
 uHxx+OKAPRbUA0VPNKFjEybVI0Pz6BI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-zT82nKIOMTqTMbpE4tzJ-g-1; Thu, 19 Dec 2024 12:08:43 -0500
X-MC-Unique: zT82nKIOMTqTMbpE4tzJ-g-1
X-Mimecast-MFC-AGG-ID: zT82nKIOMTqTMbpE4tzJ-g
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa698b61931so100269166b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628122; x=1735232922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Eg2wUNdtaL4kmVQAk0GWvYcQ9MBYiq3VF2WXBhPOtA=;
 b=Lz/BS/oJJxgiy8s80rxE5UYFYAD/9w5OsNfGvL3ggFOAKBs4HUj/+4ptjlcbClfiig
 AP8SoDZoSQUReB2Csvp8zlK9TJMWTZS0hL90WWVrpM+5PAVRmZHyLMxPxJPu/DlyePVy
 /7mNqLBWy4P6UpfwginPOMy7bnKzqnIKGDgudPG1UEg9Vrh2LiUPDKP//xlCflTU1Os7
 VPleDH1wPGUii3+yGv2IvVTpxJnoLkfETN4C36TNxpbdeFawIJ31F7ElfTc+nXTaB5+t
 MB0N5hI1m6z+I7GcRiiYHCYygcp/vDgAF1leNwYI16v7KcQK16X1RSy77dFENqY0//Tm
 tMWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqsS7WD3iAxHErJVsd6B/6xzunLs2Lq7QE/1ZPccpIDYk5xj0PfJcyK+wnxMyxWuXWdEFbeQkq4tqb@nongnu.org
X-Gm-Message-State: AOJu0YxgfBxZowL3ttBeYCSGUO8k7AOVrmWMHGikW2Vhdc1hYP1qru34
 wdg+w/L0BFWCS+4ysmdY8uASufMSaGE/VLTD37tdsdt8JDXNYRp1mTHBIMZz9IiZ8lMxelWzKgT
 XT/IrTCIXfMZ9HIxzf/2GlPUuCyPjwiZNZnVm4v88eLyXlFNVE5lKWAD/b+sR/f3Gi8wjhpaB1t
 WVd1IV8+494YhhopMsnWXEMjTL1L4=
X-Gm-Gg: ASbGnctxSZgRSC5zJog8b5qp5uIhXtsL8EXz2M5xDp5EvswNRS8w1kz2VnSCvghYjau
 dOd2RH1NFPNaXSf/4OCzdODyNDKTDh4JfuHL5rtg=
X-Received: by 2002:a17:907:97d2:b0:aa5:27d4:980a with SMTP id
 a640c23a62f3a-aac2369962emr12543766b.49.1734628121701; 
 Thu, 19 Dec 2024 09:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuLtlaq1Opv5+aFUWJubqIZo7Kw06lA6KEBs0UAd9DT+RER0Bs6VhrEQFE/m6dYLrA5/bx6aAMWP3ZIz60LYs=
X-Received: by 2002:a17:907:97d2:b0:aa5:27d4:980a with SMTP id
 a640c23a62f3a-aac2369962emr12537766b.49.1734628121205; Thu, 19 Dec 2024
 09:08:41 -0800 (PST)
MIME-Version: 1.0
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
 <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
 <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
In-Reply-To: <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 19 Dec 2024 22:38:28 +0530
Message-ID: <CAK3XEhNN9EO75vgsdRboMZ7nwZbaL0eenSwSy-7Hze-ukyTZsQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fb709a0629a29491"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000fb709a0629a29491
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec, 2024, 10:21 pm Philippe Mathieu-Daud=C3=A9, <philmd@linaro.=
org>
wrote:

> On 19/12/24 17:16, Ani Sinha wrote:
> >
> >
> > On Thu, 19 Dec, 2024, 9:22 pm Philippe Mathieu-Daud=C3=A9, <philmd@lina=
ro.org
> > <mailto:philmd@linaro.org>> wrote:
> >
> >     On 16/12/24 12:48, Ani Sinha wrote:
> >
> >      > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> >      > index d02d96e403..4c5bdb0de2 100644
> >      > --- a/hw/misc/meson.build
> >      > +++ b/hw/misc/meson.build
> >      > @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA',
> >     if_true: files('mac_via.c'))
> >      >   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true:
> >     files('mips_cmgcr.c', 'mips_cpc.c'))
> >      >   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true:
> >     files('mips_itu.c'))
> >      >
> >      > +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true:
> >     files('vmfwupdate.c'))
> >
> >     FW_CFG_DMA is offered by multiple targets ...:
> >
> >     $ git grep -w FW_CFG_DMA
> >     hw/arm/Kconfig:19:    select FW_CFG_DMA
> >     hw/i386/Kconfig:82:    select FW_CFG_DMA
> >     hw/i386/Kconfig:113:    select FW_CFG_DMA
> >     hw/loongarch/Kconfig:22:    select FW_CFG_DMA
> >     hw/riscv/Kconfig:59:    select FW_CFG_DMA
> >
> >      > diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> >      > new file mode 100644
> >      > index 0000000000..1e29a610c0
> >      > --- /dev/null
> >      > +++ b/hw/misc/vmfwupdate.c
> >      > @@ -0,0 +1,157 @@
> >      > +/*
> >      > + * Guest driven VM boot component update device
> >      > + * For details and specification, please look at docs/specs/
> >     vmfwupdate.rst.
> >      > + *
> >      > + * Copyright (C) 2024 Red Hat, Inc.
> >      > + *
> >      > + * Authors: Ani Sinha <anisinha@redhat.com
> >     <mailto:anisinha@redhat.com>>
> >      > + *
> >      > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >     2 or later.
> >      > + * See the COPYING file in the top-level directory.
> >      > + *
> >      > + */
> >      > +
> >      > +#include "qemu/osdep.h"
> >      > +#include "qapi/error.h"
> >      > +#include "qemu/module.h"
> >      > +#include "sysemu/reset.h"
> >      > +#include "hw/nvram/fw_cfg.h"
> >      > +#include "hw/i386/pc.h"
> >
> >     ... however ...
> >
> >      > +#include "hw/qdev-properties.h"
> >      > +#include "hw/misc/vmfwupdate.h"
> >      > +#include "qemu/error-report.h"
> >      > +
> >      > +static void fw_update_reset(void *dev)
> >      > +{
> >      > +    /* a NOOP at present */
> >      > +    return;
> >      > +}
> >      > +
> >      > +
> >      > +static uint64_t get_max_fw_size(void)
> >      > +{
> >      > +    Object *m_obj =3D qdev_get_machine();
> >      > +    PCMachineState *pcms =3D PC_MACHINE(m_obj);
> >      > +
> >      > +    if (pcms) {
> >      > +        return pcms->max_fw_size;
> >
> >     ... this code depends on x86/PC.
> >
> >     Could it be wiser to add a new VM_FWUPDATE Kconfig
> >     symbol, having it depending on FW_CFG_DMA && I386?
> >
> >
> > There is no reason why vmfwupdate would be limited to x86 only. There i=
s
> > minimal support needed from hypervisor side for this mechanism. That
> > mechanism has little dependency on specific platform.
>
> OK, then please remove that PCMachineState use


That is used because the max_fw_size property only exists for pc machines.
Do you have a better idea to get this value in a platform agnostic way?
Like I said in the previous reply I do not know how to get this value
reliably for all machines. If anyone has better ideas, I'm all ears.

.
>
> What about the FW_CFG_DMA dependency?
>
>

--000000000000fb709a0629a29491
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, 19 Dec, 2024, 10:21 pm Philippe Mathieu-Daud=
=C3=A9, &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"n=
oreferrer">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">On 19/12/24 17:16, Ani Sinha wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, 19 Dec, 2024, 9:22 pm Philippe Mathieu-Daud=C3=A9, &lt;<a href=
=3D"mailto:philmd@linaro.org" rel=3D"noreferrer noreferrer" target=3D"_blan=
k">philmd@linaro.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:philmd@linaro.org" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 16/12/24 12:48, Ani Sinha wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/misc/meson.build b/hw/misc/me=
son.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index d02d96e403..4c5bdb0de2 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/misc/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/misc/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -148,6 +148,8 @@ specific_ss.add(when: &#3=
9;CONFIG_MAC_VIA&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0if_true: files(&#39;mac_via.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0specific_ss.add(when: &#39;CONFIG=
_MIPS_CPS&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;mips_cmgcr.c&#39;, &#39;mips_cpc.c&#39;)=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0specific_ss.add(when: &#39;CONFIG=
_MIPS_ITU&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;mips_itu.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +specific_ss.add(when: &#39;CONFIG_FW_CFG_DMA=
&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;vmfwupdate.c&#39;))<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0FW_CFG_DMA is offered by multiple targets ...:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ git grep -w FW_CFG_DMA<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/arm/Kconfig:19:=C2=A0 =C2=A0 select FW_CFG_DMA<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0hw/i386/Kconfig:82:=C2=A0 =C2=A0 select FW_CFG_DMA<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/i386/Kconfig:113:=C2=A0 =C2=A0 select FW_CFG_DMA=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/loongarch/Kconfig:22:=C2=A0 =C2=A0 select FW_CFG=
_DMA<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/riscv/Kconfig:59:=C2=A0 =C2=A0 select FW_CFG_DMA=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/misc/vmfwupdate.c b/hw/misc/v=
mfwupdate.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 0000000000..1e29a610c0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/misc/vmfwupdate.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,157 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Guest driven VM boot component update dev=
ice<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * For details and specification, please loo=
k at docs/specs/<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmfwupdate.rst.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright (C) 2024 Red Hat, Inc.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Authors: Ani Sinha &lt;<a href=3D"mailto:=
anisinha@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">anisin=
ha@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:anisinha@redhat.com" r=
el=3D"noreferrer noreferrer" target=3D"_blank">anisinha@redhat.com</a>&gt;&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This work is licensed under the terms of =
the GNU GPL, version<br>
&gt;=C2=A0 =C2=A0 =C2=A02 or later.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * See the COPYING file in the top-level dir=
ectory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;sysemu/reset.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/nvram/fw_cfg.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/i386/pc.h&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0... however ...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/qdev-properties.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/misc/vmfwupdate.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void fw_update_reset(void *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* a NOOP at present */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static uint64_t get_max_fw_size(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Object *m_obj =3D qdev_get_mac=
hine();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PCMachineState *pcms =3D PC_MA=
CHINE(m_obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (pcms) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return pcms-&gt;=
max_fw_size;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0... this code depends on x86/PC.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Could it be wiser to add a new VM_FWUPDATE Kconfig<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0symbol, having it depending on FW_CFG_DMA &amp;&amp=
; I386?<br>
&gt; <br>
&gt; <br>
&gt; There is no reason why vmfwupdate would be limited to x86 only. There =
is <br>
&gt; minimal support needed from hypervisor side for this mechanism. That <=
br>
&gt; mechanism has little dependency on specific platform.<br>
<br>
OK, then please remove that PCMachineState use</blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">That is used because the max_fw_s=
ize property only exists for pc machines. Do you have a better idea to get =
this value in a platform agnostic way? Like I said in the previous reply I =
do not know how to get this value reliably for all machines. If anyone has =
better ideas, I&#39;m all ears.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">.<br>
<br>
What about the FW_CFG_DMA dependency?<br>
<br>
</blockquote></div></div></div>

--000000000000fb709a0629a29491--


