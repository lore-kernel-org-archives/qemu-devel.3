Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0BDC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXdD-0001Cm-Qi; Mon, 29 Jan 2024 14:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUXdB-0001Cc-VE
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:49:21 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUXd9-0007SN-Lh
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:49:21 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-783d4b3a00bso293703385a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 11:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706557757; x=1707162557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FisFwHpxUgCQNixc4GJGk8RZ0MJsp73+zkbVKosq7M=;
 b=GVMg0PjdT7ANUyu7M85KG0GbbDM4beCdA7M13fPtnJiwMvzTCNZ522aQwhUBngicpe
 JTbKzX7bZ45LPaIpr7XS9Tf2B0/fWs1BhJVZUvk3LXoFWyJJra8IPVDhAMZHAwerSBfQ
 G1yNDLrukAdr0mGQkvs4CGvY0x5Ni5ZRp7jIblzPw/YfVyxaST/jEnETXpsfhjQH7E8h
 6tJotNQRvB/rp+tqVT6yjCocbjmw2GGbpc8KFwHOHw89cIhaci63Wpst8LBXUzKzCzUi
 zxBmB28E5sYgJk1DA7AEHvlSRYRKevnuHeLYYCnH2LWPoaLllAvfSscdET6mB6C804QZ
 2QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706557757; x=1707162557;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FisFwHpxUgCQNixc4GJGk8RZ0MJsp73+zkbVKosq7M=;
 b=ojnTBBhfX18Ncqqj494Ta4BD0pNLn2Z8NVTQiQAKHXnwnCIV053JPxwkJ9DaV+EvF5
 sll2o3v3Zbr0vqgaMlYUI/ndcR4BHduDsbUOWfEsvIoeP46Xa9oHUogkIU0bfyIUvx/2
 5BFYLsPhZhLYXZHbjDGSQIJ39rPGDrsCWZ19cgMPfgCVwOkmnTYQXaeXFKgW8UippdSc
 gSARFywzcH4nbBXmsRinph+WRB8+8cr0gG2yknG/OVJgrhoWiV4UDiub56uFZRodmnge
 ZVI553CdbwNFm702PRAE2uNiqE79cbokJpWFi4sBaadWrLKm9GhYM7t0rgOPneTNs8pF
 98Qg==
X-Gm-Message-State: AOJu0YxQy0PkVBpPTjCt5QF2G0vpKUmUyw8CXfGxafJ9uLsuY25jb3Nq
 P2xqvt7ZLpNh7ZjFtYesZMn/YVuoVyScrPkWQ3+xQiVKe0Tzxp6t+70jBlpB
X-Google-Smtp-Source: AGHT+IFpvdvTGwTX3NhWKo4OxxAHKkXvibApuVwyqM2iRqw3hICIdFXi1hzazMwFARi0SpUarFSsVw==
X-Received: by 2002:a05:620a:4081:b0:784:887:958d with SMTP id
 f1-20020a05620a408100b007840887958dmr566370qko.11.1706557757160; 
 Mon, 29 Jan 2024 11:49:17 -0800 (PST)
Received: from [127.0.0.1] ([45.156.240.113]) by smtp.gmail.com with ESMTPSA id
 x12-20020a05620a098c00b00783f6f7e4b2sm1719317qkx.41.2024.01.29.11.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 11:49:16 -0800 (PST)
Date: Mon, 29 Jan 2024 19:49:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
CC: philmd@linaro.org
Subject: Re: [PATCH 2/4] isa: extract FDC37M81X to a separate file
In-Reply-To: <20240129133751.1106716-3-pbonzini@redhat.com>
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <20240129133751.1106716-3-pbonzini@redhat.com>
Message-ID: <AE14AC8A-AA67-4F69-8D45-640C93217935@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=shentey@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 29=2E Januar 2024 13:37:46 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>isa-superio=2Ec currently defines a SuperIO chip that depends on
>CONFIG_IDE_ISA, but not all users of isa-superio=2Ec depend on that
>symbol=2E  Extract the chip to a separate file so that there is an
>obvious place to select IDE_ISA=2E
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> hw/isa/fdc37m81x-superio=2Ec | 37 +++++++++++++++++++++++++++++++++++++
> hw/isa/isa-superio=2Ec       | 19 -------------------
> hw/isa/Kconfig             |  5 +++++
> hw/isa/meson=2Ebuild         |  1 +
> hw/mips/Kconfig            |  2 +-
> 5 files changed, 44 insertions(+), 20 deletions(-)
> create mode 100644 hw/isa/fdc37m81x-superio=2Ec
>
>diff --git a/hw/isa/fdc37m81x-superio=2Ec b/hw/isa/fdc37m81x-superio=2Ec
>new file mode 100644
>index 00000000000=2E=2E5ad769b69e8
>--- /dev/null
>+++ b/hw/isa/fdc37m81x-superio=2Ec
>@@ -0,0 +1,37 @@
>+/*
>+ * Generic ISA Super I/O

Replace this description=2E=2E=2E

>+ *
>+ * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter=2E
>+ * See the COPYING file in the top-level directory=2E
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/isa/superio=2Eh"
>+
>+/* SMS FDC37M817 Super I/O */

=2E=2E=2E with this one?

>+static void fdc37m81x_class_init(ObjectClass *klass, void *data)
>+{
>+    ISASuperIOClass *sc =3D ISA_SUPERIO_CLASS(klass);
>+
>+    sc->serial=2Ecount =3D 2; /* NS16C550A */
>+    sc->parallel=2Ecount =3D 1;
>+    sc->floppy=2Ecount =3D 1; /* SMSC 82077AA Compatible */
>+    sc->ide=2Ecount =3D 0;
>+}
>+

Don't we prefer a macro for below code? While touching the code we could u=
se it=2E (Sorry I can't recall its name from the top of my head and I don't=
 have access to the code right now)=2E

Best regards,
Bernhard

>+static const TypeInfo fdc37m81x_type_info =3D {
>+    =2Ename          =3D TYPE_FDC37M81X_SUPERIO,
>+    =2Eparent        =3D TYPE_ISA_SUPERIO,
>+    =2Einstance_size =3D sizeof(ISASuperIODevice),
>+    =2Eclass_init    =3D fdc37m81x_class_init,
>+};
>+
>+static void fdc37m81x_register_types(void)
>+{
>+    type_register_static(&fdc37m81x_type_info);
>+}
>+
>+type_init(fdc37m81x_register_types)
>diff --git a/hw/isa/isa-superio=2Ec b/hw/isa/isa-superio=2Ec
>index 7dbfc374da3=2E=2E80e0c34652e 100644
>--- a/hw/isa/isa-superio=2Ec
>+++ b/hw/isa/isa-superio=2Ec
>@@ -187,28 +187,9 @@ static const TypeInfo isa_superio_type_info =3D {
>     =2Eclass_init =3D isa_superio_class_init,
> };
>=20
>-/* SMS FDC37M817 Super I/O */
>-static void fdc37m81x_class_init(ObjectClass *klass, void *data)
>-{
>-    ISASuperIOClass *sc =3D ISA_SUPERIO_CLASS(klass);
>-
>-    sc->serial=2Ecount =3D 2; /* NS16C550A */
>-    sc->parallel=2Ecount =3D 1;
>-    sc->floppy=2Ecount =3D 1; /* SMSC 82077AA Compatible */
>-    sc->ide=2Ecount =3D 0;
>-}
>-
>-static const TypeInfo fdc37m81x_type_info =3D {
>-    =2Ename          =3D TYPE_FDC37M81X_SUPERIO,
>-    =2Eparent        =3D TYPE_ISA_SUPERIO,
>-    =2Einstance_size =3D sizeof(ISASuperIODevice),
>-    =2Eclass_init    =3D fdc37m81x_class_init,
>-};
>-
> static void isa_superio_register_types(void)
> {
>     type_register_static(&isa_superio_type_info);
>-    type_register_static(&fdc37m81x_type_info);
> }
>=20
> type_init(isa_superio_register_types)
>diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>index 7884179d08b=2E=2Eaf856af052d 100644
>--- a/hw/isa/Kconfig
>+++ b/hw/isa/Kconfig
>@@ -23,6 +23,11 @@ config ISA_SUPERIO
>     # Some users of ISA_SUPERIO do not use it
>     #select IDE_ISA
>=20
>+config FDC37M81X
>+    bool
>+    select ISA_BUS
>+    select IDE_ISA
>+
> config PC87312
>     bool
>     select ISA_SUPERIO
>diff --git a/hw/isa/meson=2Ebuild b/hw/isa/meson=2Ebuild
>index 2ab99ce0c6b=2E=2Ef650b395071 100644
>--- a/hw/isa/meson=2Ebuild
>+++ b/hw/isa/meson=2Ebuild
>@@ -4,6 +4,7 @@ system_ss=2Eadd(when: 'CONFIG_ISA_BUS', if_true: files('i=
sa-bus=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio=
=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_PC87312', if_true: files('pc87312=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_PIIX', if_true: files('piix=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-supe=
rio=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-supe=
rio=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_VT82C686', if_true: files('vt82c686=2Ec'))
>=20
>diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>index ab61af209a0=2E=2E94b969c21db 100644
>--- a/hw/mips/Kconfig
>+++ b/hw/mips/Kconfig
>@@ -1,7 +1,7 @@
> config MALTA
>     bool
>+    select FDC37M81X
>     select GT64120
>-    select ISA_SUPERIO
>     select PIIX
>=20
> config MIPSSIM

