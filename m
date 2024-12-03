Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F196E6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMgO-0001zd-Jc; Tue, 03 Dec 2024 01:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tIMgM-0001yq-ML; Tue, 03 Dec 2024 01:46:50 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tIMgJ-00023M-HQ; Tue, 03 Dec 2024 01:46:50 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa52edbcb63so1074721166b.1; 
 Mon, 02 Dec 2024 22:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733208404; x=1733813204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEmizadDx6J+cd+C8N8GvCofp2vnx235szKbmoXfH9c=;
 b=NlDjSpKzdl5eTmzsKqToM+iJ6DZ6bbNdMamaDyNBQHFCvZkjbyE2Kq65NjNQfeUnBY
 nGl1BYA642jp2iNf+/EjCafkdu09+NJQ1jEvPzGig4aGyZbWslEBvF5yOmKuvGdRJIN6
 0EcJB8tCKCYVny6SC3agh+parAmuzg4vmb6wLJxBy9PIP1upJ48HmKxY4KOwCfH7RskK
 VY4N9K0X/RaXGAwkKnqN3/faK1bf0IQlEHFOvVXXA81DQU37ynX/ptd8I6sJ5KTFgu2t
 7dA8JcfrsuFdAl9YxhftpD85wzFsmQ3sj21K5DYFsSyCfiVFtSa1Nu+1N7iAZ3sxY55I
 oHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733208404; x=1733813204;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEmizadDx6J+cd+C8N8GvCofp2vnx235szKbmoXfH9c=;
 b=eI1V8He0HcpHH8grvShQ39RivBMjsK/W00kD53dohjCZYfTba+jMjD7hYYBzWDS943
 v+aGKDPNeLMoW201rlIm2Hzq4k7QcKcSsLAjP0YKTciqYONTa3luSoxCpUu1/+G+1oza
 PsZl+LW/9XZjlPSmigtHRVEnKrYlXLnZVtYD8ZCCtUgHpEbPnIsm6/K4vb/m6mqIaGy0
 zQ8PSmS4NakHUcnM7ssMiJy4R50jKyN3AH5XUz2/zQ8BU1QdkMGh2i0x4Pb7rS5r0AbI
 Q0FfVZ27LjIwgh32swTcNN5PyTDCztSkODce7ulFO3ygPNvuLV8wq9iLKBt4K0uodTLh
 XvaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFxQXxoft0cVc9Ii3VfiB9uTmgbBcAUqHJnffbUv/nEDSNl81liZqiaKmmQp1OwpqqCDRRZexn3CKgpg==@nongnu.org,
 AJvYcCWgGRz1faNYwKAfwqQrS1rRzylCGAbjPP3I75IZRiR275KuCtIq6v7n4MesaHpUN3IM1t7fHXj73hm0@nongnu.org
X-Gm-Message-State: AOJu0Yxt/mGhDUOA1nZI7pQHmY00/Ellm6/Q+Ci6yBO5w6OMYi22ATew
 dx68G5b6HNSOxyQF0Io2dZ/J7T0OAQfPyV9xeVwebC2mXYrQR8Fw
X-Gm-Gg: ASbGncswps0uSOLBzspf67eOuJbJNCO9hiqUUaQLMQvhGJZFTNYeeCeozdqQh5Dv6dU
 OtY0M743mq/rH8CJAYIiexBduoafRrwVrRduZP0fA33oKlUm4Gsb/UiYcqIOS6CyMAL0aSPjFIl
 95TcCQmSlsOtwsfjzJw51L7S5So7UZPQeZKw8i65GJea3HCpiwO5A+EEKTeIzPFQ07i73mB6J7g
 g6yYOjvo0qmdLQE3fua3hYP2Hgo4/zBjkvDlscGlX4wIjz/udZqKCflj/tBVckP3zHDFiYYZBkH
 nUVBQEbJrejFkXPkGli07e8=
X-Google-Smtp-Source: AGHT+IFNvKAE9yf/l7vRgS4axRmA3zBenwc8kfyEGC5yTolzK5PsxEVmNiNWzTtrjxFh9u3ihcwz4Q==
X-Received: by 2002:a17:906:292a:b0:aa5:c9c:31c5 with SMTP id
 a640c23a62f3a-aa5f72cc7f6mr115996166b.17.1733208403906; 
 Mon, 02 Dec 2024 22:46:43 -0800 (PST)
Received: from [127.0.0.1] (dynamic-002-242-014-218.2.242.pool.telefonica.de.
 [2.242.14.218]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996c19b5sm576589866b.5.2024.12.02.22.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 22:46:43 -0800 (PST)
Date: Tue, 03 Dec 2024 06:46:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] hw/ide/ahci: Check for PCI device once in ahci_init()
In-Reply-To: <20241121100152.65476-1-philmd@linaro.org>
References: <20241121100152.65476-1-philmd@linaro.org>
Message-ID: <D1B09E85-E00F-4E8F-8332-51CB33A97E44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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



Am 21=2E November 2024 10:01:52 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>object_dynamic_cast() is expensive; IRQ helpers are certainly
>a bad place to call it=2E Since the device type won't change at
>runtime, resolve it once when the AHCI context is initialized
>in ahci_init()=2E
>
>Reported-by: Peter Xu <peterx@redhat=2Ecom>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> include/hw/ide/ahci=2Eh |  2 +-
> hw/ide/ahci=2Ec         | 17 +++++------------
> 2 files changed, 6 insertions(+), 13 deletions(-)
>
>diff --git a/include/hw/ide/ahci=2Eh b/include/hw/ide/ahci=2Eh
>index ba31e75ff9=2E=2Ef6d977610d 100644
>--- a/include/hw/ide/ahci=2Eh
>+++ b/include/hw/ide/ahci=2Eh
>@@ -37,7 +37,7 @@ typedef struct AHCIControlRegs {
> } AHCIControlRegs;
>=20
> typedef struct AHCIState {
>-    DeviceState *container;
>+    PCIDevice *pci_dev;
>=20
>     AHCIDevice *dev;
>     AHCIControlRegs control_regs;
>diff --git a/hw/ide/ahci=2Ec b/hw/ide/ahci=2Ec
>index 0eb24304ee=2E=2Ef2eb3b527b 100644
>--- a/hw/ide/ahci=2Ec
>+++ b/hw/ide/ahci=2Ec
>@@ -181,14 +181,10 @@ static uint32_t ahci_port_read(AHCIState *s, int po=
rt, int offset)
>=20
> static void ahci_irq_raise(AHCIState *s)
> {
>-    DeviceState *dev_state =3D s->container;
>-    PCIDevice *pci_dev =3D (PCIDevice *) object_dynamic_cast(OBJECT(dev_=
state),
>-                                                           TYPE_PCI_DEVI=
CE);
>-
>     trace_ahci_irq_raise(s);
>=20
>-    if (pci_dev && msi_enabled(pci_dev)) {
>-        msi_notify(pci_dev, 0);
>+    if (s->pci_dev && msi_enabled(s->pci_dev)) {
>+        msi_notify(s->pci_dev, 0);
>     } else {
>         qemu_irq_raise(s->irq);
>     }
>@@ -196,13 +192,9 @@ static void ahci_irq_raise(AHCIState *s)
>=20
> static void ahci_irq_lower(AHCIState *s)
> {
>-    DeviceState *dev_state =3D s->container;
>-    PCIDevice *pci_dev =3D (PCIDevice *) object_dynamic_cast(OBJECT(dev_=
state),
>-                                                           TYPE_PCI_DEVI=
CE);
>-
>     trace_ahci_irq_lower(s);
>=20
>-    if (!pci_dev || !msi_enabled(pci_dev)) {
>+    if (!s->pci_dev || !msi_enabled(s->pci_dev)) {
>         qemu_irq_lower(s->irq);
>     }
> }

By always triggering the "irq" property, it might be possible to push out =
the above two methods to the caller, i=2Ee=2E the parent PCI device=2E This=
 would make this device model independent from PCI, essentially turning it =
into an "IP block"=2E At the same time this eliminates the need for the dyn=
amic casts and AFAICS would also fix the missing PCI dependency in the Kcon=
fig file=2E I could send a patch=2E

Best regards,
Bernhard

>@@ -1608,7 +1600,8 @@ static const IDEDMAOps ahci_dma_ops =3D {
>=20
> void ahci_init(AHCIState *s, DeviceState *qdev)
> {
>-    s->container =3D qdev;
>+    s->pci_dev =3D (PCIDevice *)object_dynamic_cast(OBJECT(qdev), TYPE_P=
CI_DEVICE);
>+
>     /* XXX BAR size should be 1k, but that breaks, so bump it to 4k for =
now */
>     memory_region_init_io(&s->mem, OBJECT(qdev), &ahci_mem_ops, s,
>                           "ahci", AHCI_MEM_BAR_SIZE);

