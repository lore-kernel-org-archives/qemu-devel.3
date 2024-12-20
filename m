Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE50E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tORt6-0001ZY-3r; Thu, 19 Dec 2024 20:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tORt3-0001ZF-MQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tORt1-0007qj-9Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734658380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmEliLdIe0QSgVv7hFYjszT4WehYmbWktJrUWaA5FYM=;
 b=PXzkBDtUeO7JpUekECjEvMOI5MQRT0ylUAlezgJ9BnxSId7eBXuVBH1pW6qRI66wKjuaDR
 CKAe8fmx9fxC6rrv7mZIowTw0IOYVxAgIuaxH/ZWzkZb7q3XTf089LQzTzEB+IFWKPu4Vy
 dcNLVlgG56ZT5rN9SG1L109z76D2d5U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9wXIibnlPkihOp5FDyBHYQ-1; Thu, 19 Dec 2024 20:32:58 -0500
X-MC-Unique: 9wXIibnlPkihOp5FDyBHYQ-1
X-Mimecast-MFC-AGG-ID: 9wXIibnlPkihOp5FDyBHYQ
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa69e84128aso108746766b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734658378; x=1735263178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WmEliLdIe0QSgVv7hFYjszT4WehYmbWktJrUWaA5FYM=;
 b=AIEjNtmbYAIClvuwc6nI/Ino/nwPVt/XHonshICi7eW2I+NimMSGuxcgaGQVduwZny
 AhXgXY1hFTeHAbPCD7lnQZ0Vw3H5/lVD44/hIYxDk6gNn0hjzxDkb405WIaQ/BZtF9h5
 pymLZN4TA460xWQyqRBMCMWK9ZxyMWgKZGV1geu2DigXtP0mwPbNtuUjLHudIrUBHn6s
 zFUe7qhIBhm085umemV2CJe58uAYuY7JL6nTX5+qV8UJaHSnCb8Uj93huoKWyBf21TQs
 dLo/ssHg+fYg29fL4r7sMY0XnC+RFTR3tIyPSICBAdutNrqNJBhtYAXJJZ0ViPF7QD3a
 lLkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTufneSW2KucHADkFLeAfLJf/mnpBhJxdXUW9QOhNLUqWlPCx3+visixZ/G+Y7UCtfVloTcizNa4Ew@nongnu.org
X-Gm-Message-State: AOJu0YyROKakcOxGSShV8onwbnvP5HQ9A8vKyeHj8aZBbkQXV7F/mNGR
 3jSm4Mp4WWkGZ5R+Mp2wkaLQXo7VySk7QLBHn1YpfDdUGMKlU/Dx3v8CAfCdJSYuvI3jBha3unn
 JZcUdLUAEjN9dX2uKdfia5VlKgq6BIe3XVuXrv3HuRxyL3+xj/uFMitOSAGLIx9eKAmRjXnhXo8
 lS/MSBJYWMW1NgxouxJ4cMGRWJudk=
X-Gm-Gg: ASbGnctY/MHY2i8NCwUxFlR33awnOMDwUnpDrvo69GTySmcMIJjXudwe3WbeuIOEXvZ
 Ouq8pirEUi+Qypf1w5/RYWUyPGQ8N6UtM1eU=
X-Received: by 2002:a17:907:c2a:b0:aa6:79fa:b480 with SMTP id
 a640c23a62f3a-aac2713135bmr76204266b.10.1734658377621; 
 Thu, 19 Dec 2024 17:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9JKIvbxOsSPu14R4V6YRlj8tgDbh0vmCcRUc+86AzP0ucqBe+K6Y42PYsCGBOiUZTivS8Ip6yt+oWSOyyw4k=
X-Received: by 2002:a17:907:c2a:b0:aa6:79fa:b480 with SMTP id
 a640c23a62f3a-aac2713135bmr76202766b.10.1734658377259; Thu, 19 Dec 2024
 17:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
 <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
 <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
 <CAK3XEhNN9EO75vgsdRboMZ7nwZbaL0eenSwSy-7Hze-ukyTZsQ@mail.gmail.com>
 <7c1a7e86-8996-43ab-aa07-6763387b2bc5@linaro.org>
In-Reply-To: <7c1a7e86-8996-43ab-aa07-6763387b2bc5@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 20 Dec 2024 07:02:44 +0530
Message-ID: <CAK3XEhOZ50Co0hAS31KYyQA+mgwXSoGCxMu_vhZXmpP0RwT6Mw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Thu, Dec 19, 2024 at 10:46=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 19/12/24 18:08, Ani Sinha wrote:
> >
> >
> > On Thu, 19 Dec, 2024, 10:21 pm Philippe Mathieu-Daud=C3=A9,
> > <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >
> >     On 19/12/24 17:16, Ani Sinha wrote:
> >      >
> >      >
> >      > On Thu, 19 Dec, 2024, 9:22 pm Philippe Mathieu-Daud=C3=A9,
> >     <philmd@linaro.org <mailto:philmd@linaro.org>
> >      > <mailto:philmd@linaro.org <mailto:philmd@linaro.org>>> wrote:
> >      >
> >      >     On 16/12/24 12:48, Ani Sinha wrote:
> >      >
> >      >      > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> >      >      > index d02d96e403..4c5bdb0de2 100644
> >      >      > --- a/hw/misc/meson.build
> >      >      > +++ b/hw/misc/meson.build
> >      >      > @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA=
',
> >      >     if_true: files('mac_via.c'))
> >      >      >   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true:
> >      >     files('mips_cmgcr.c', 'mips_cpc.c'))
> >      >      >   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true:
> >      >     files('mips_itu.c'))
> >      >      >
> >      >      > +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true:
> >      >     files('vmfwupdate.c'))
> >      >
> >      >     FW_CFG_DMA is offered by multiple targets ...:
> >      >
> >      >     $ git grep -w FW_CFG_DMA
> >      >     hw/arm/Kconfig:19:    select FW_CFG_DMA
> >      >     hw/i386/Kconfig:82:    select FW_CFG_DMA
> >      >     hw/i386/Kconfig:113:    select FW_CFG_DMA
> >      >     hw/loongarch/Kconfig:22:    select FW_CFG_DMA
> >      >     hw/riscv/Kconfig:59:    select FW_CFG_DMA
> >      >
> >      >      > diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> >      >      > new file mode 100644
> >      >      > index 0000000000..1e29a610c0
> >      >      > --- /dev/null
> >      >      > +++ b/hw/misc/vmfwupdate.c
> >      >      > @@ -0,0 +1,157 @@
> >      >      > +/*
> >      >      > + * Guest driven VM boot component update device
> >      >      > + * For details and specification, please look at docs/sp=
ecs/
> >      >     vmfwupdate.rst.
> >      >      > + *
> >      >      > + * Copyright (C) 2024 Red Hat, Inc.
> >      >      > + *
> >      >      > + * Authors: Ani Sinha <anisinha@redhat.com
> >     <mailto:anisinha@redhat.com>
> >      >     <mailto:anisinha@redhat.com <mailto:anisinha@redhat.com>>>
> >      >      > + *
> >      >      > + * This work is licensed under the terms of the GNU GPL,
> >     version
> >      >     2 or later.
> >      >      > + * See the COPYING file in the top-level directory.
> >      >      > + *
> >      >      > + */
> >      >      > +
> >      >      > +#include "qemu/osdep.h"
> >      >      > +#include "qapi/error.h"
> >      >      > +#include "qemu/module.h"
> >      >      > +#include "sysemu/reset.h"
> >      >      > +#include "hw/nvram/fw_cfg.h"
> >      >      > +#include "hw/i386/pc.h"
> >      >
> >      >     ... however ...
> >      >
> >      >      > +#include "hw/qdev-properties.h"
> >      >      > +#include "hw/misc/vmfwupdate.h"
> >      >      > +#include "qemu/error-report.h"
> >      >      > +
> >      >      > +static void fw_update_reset(void *dev)
> >      >      > +{
> >      >      > +    /* a NOOP at present */
> >      >      > +    return;
> >      >      > +}
> >      >      > +
> >      >      > +
> >      >      > +static uint64_t get_max_fw_size(void)
> >      >      > +{
> >      >      > +    Object *m_obj =3D qdev_get_machine();
> >      >      > +    PCMachineState *pcms =3D PC_MACHINE(m_obj);
> >      >      > +
> >      >      > +    if (pcms) {
> >      >      > +        return pcms->max_fw_size;
> >      >
> >      >     ... this code depends on x86/PC.
> >      >
> >      >     Could it be wiser to add a new VM_FWUPDATE Kconfig
> >      >     symbol, having it depending on FW_CFG_DMA && I386?
> >      >
> >      >
> >      > There is no reason why vmfwupdate would be limited to x86 only.
> >     There is
> >      > minimal support needed from hypervisor side for this mechanism. =
That
> >      > mechanism has little dependency on specific platform.
> >
> >     OK, then please remove that PCMachineState use
> >
> >
> > That is used because the max_fw_size property only exists for pc
> > machines. Do you have a better idea to get this value in a platform
> > agnostic way? Like I said in the previous reply I do not know how to ge=
t
> > this value reliably for all machines. If anyone has better ideas, I'm
> > all ears.
>
> Either add the I386 dependency or don't use PC_MACHINE, because on
> non-x86 targets PC_MACHINE(qdev_get_machine()) will crash.

Ah this is where we have a disconnect. I assumed that
> pcms =3D PC_MACHINE(m_obj)

would return NULL on non-x86.

Seems a better way to do this (as is done in vga.c) is to use
object_dynamic_cast()
How about

diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
index 0e90bd10e1..19d042b929 100644
--- a/hw/misc/vmfwupdate.c
+++ b/hw/misc/vmfwupdate.c
@@ -32,9 +32,11 @@ static inline VMFwUpdateState *vmfwupdate_find(void)
 static uint64_t get_max_fw_size(void)
 {
     Object *m_obj =3D qdev_get_machine();
-    PCMachineState *pcms =3D PC_MACHINE(m_obj);
+    MachineState *ms =3D MACHINE(m_obj);
+    PCMachineState *pcms;
-    if (pcms) {
+    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
+        pcms =3D PC_MACHINE(m_obj);
         return pcms->max_fw_size;
     } else {
         return 0;

As I said before, if this is not the best way, please suggest an
alternative to get max_fw_size for any platform.

>
> >     What about the FW_CFG_DMA dependency?

If you read the spec,

+ The ``fw-cfg`` interface must support the
+     DMA interface. It may only support the DMA interface for write operat=
ions.

So we need that.

> >
>
> I wasted enough time on this so I'll stop reviewing this work.

Well up to you but I have tried to incorporate most of your
suggestions here (as it has been with other patches that you review).
I am off for the year-end break so won't be sending any more versions
of this patch in the next few days. So if you change your mind, feel
free to comment.
Have a good year-end break.


