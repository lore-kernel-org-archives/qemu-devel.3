Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8A2C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLLU-0000kF-Ey; Mon, 27 Jan 2025 04:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcLLL-0000jl-9M; Mon, 27 Jan 2025 04:23:43 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcLLJ-0003LB-KQ; Mon, 27 Jan 2025 04:23:43 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso578109466b.3; 
 Mon, 27 Jan 2025 01:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737969819; x=1738574619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdp6qM5HkNGE6pm93Ya34vtciW0eBxcidQ8OmMD0mDI=;
 b=kvaIxQT5gL6V4wJ3CBY8feJmhgUeyZ3Lz6qs6fVMtL+gaEc381iu9Wi7UzTAJiU4Rw
 Z85QmkCmYqop6YDTJZ9lMuCQ464CcRPdjhm6h41dVizZQrXXK1ChttCs34UX8DmcHER3
 KaIEdsqY9CnKhO4dDCFVpPl2PjhyMUyOoHLB4Ak2palmk5JTu/qSTSH/cPQgWvw3ZDVp
 9m8IF6dPp+HQP7EFQLwMY5XTAnT98fJwTFGe9dnjqyOSz/GSES6BaDadzcua/3bBzNAJ
 SjHksutgGsycH6+w1NIpnt1+Oa7Q20Lyab0NqQmv/CoM9bKrGNyM3Tc7COqVr0iPrwL2
 P2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737969819; x=1738574619;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdp6qM5HkNGE6pm93Ya34vtciW0eBxcidQ8OmMD0mDI=;
 b=jDD1LAUciBn5xze1RysgoeVWRdnBXCQgDK09YiIGNQtHEycVSmqTClwl5UPo3EgfpB
 GavAF+xsf+2RobDILoGSOF97gNb+/urDJnoX6HdwsmsQ/+cHIGbKM2R25Wigv/Kto7lo
 Qo6qMKhjYPO7ohV5OOF4pT2lRZAxTL9KO85RiPA1SrcwZJk3kfnKwzLJxmHvNN6e8uQl
 zmDpCSG0eoJYUGbzGd1FTKNyvzH88dcsquk6yW9KMTjufelANypg9pSdXx5Hcw6nQQHi
 tArm+Lhulndsqsab5IgK7xkeGsgBKmQwEKKlBWnIlWnF2ZyeaOvZsB96piNqIh4a4UPG
 OXtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAod53ziElVOI24F4h/YMGJ9TlmXiy83OiHxFbDb4F0oZH7G+hn/oSgjTurG8Ap57YrB4ieawEGkOw@nongnu.org,
 AJvYcCXRd6GHJ292AkJvQUReNh9FFUFDjMgRHNDb9xxIBx4+Ek1CxnykqEvYm96NpxPsHE6InwsQYr1s7VA=@nongnu.org
X-Gm-Message-State: AOJu0YwxNwbue4nvCA5Uy1vCs2Md8oUozmY7pKN49Z3CM1HHakEHIMrd
 QkQ/g31aMPwe7kpbuRQ5/DZAHmFcMZCn4lv0D9TNiQqKxQ8O8mne
X-Gm-Gg: ASbGncsbZ9+UYKLnnvoWXsCNWyxGoi/+PmavBKJ4fuGrR09ZIMjpXPhiP82HVzaMMst
 uGihSW26uy9mMcaZPSyPHJ/V4fGw50b6o3fbcy2VNEhEGabaJYk8Oe+3hXeYFCGlSUeDya5GCOh
 Q+FyOBGj0BRB+ohQG/ToxYINtclmbS1wNRA9ZHyB8R1ekVERhy35C9bE4WL/qBnB16jPP+fIhEd
 U6hTno4wyrDge8x0xS5fFrZfXGV0FWmf6vRSxq3BTTxu1FAA+GlcbaX7uv8oHCkhnisuS2E/Nml
 +TKbWtZg1fkv2sc1PYPbbSC3s8EgQiQGo0rYCUzTrs0Fe6uifpRJtjpQ
X-Google-Smtp-Source: AGHT+IGGdDiQNlIruAHADHHYWkF49cOK1bT139jWgdCV4iDBjNSzB0gu/pftWQhhkzbn6APXXw+Bbw==
X-Received: by 2002:a17:907:3602:b0:aaf:74b3:80db with SMTP id
 a640c23a62f3a-ab38b0b90f1mr3823978866b.3.1737969819097; 
 Mon, 27 Jan 2025 01:23:39 -0800 (PST)
Received: from [127.0.0.1] (dynamic-093-128-047-181.93.128.pool.telefonica.de.
 [93.128.47.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab675e1373esm546856666b.1.2025.01.27.01.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 01:23:38 -0800 (PST)
Date: Mon, 27 Jan 2025 09:23:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?ISO-8859-1?Q?Cl=E9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/9=5D_hw/sysbus=3A_Declare_?=
 =?US-ASCII?Q?QOM_types_using_DEFINE=5FTYPES=28=29_macro?=
In-Reply-To: <20250125181343.59151-3-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-3-philmd@linaro.org>
Message-ID: <003404AB-0220-474C-B9DC-4CD88225C420@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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



Am 25=2E Januar 2025 18:13:36 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>When multiple QOM types are registered in the same file,
>it is simpler to use the the DEFINE_TYPES() macro=2E In
>particular because type array declared with such macro
>are easier to review=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/core/sysbus=2Ec | 39 +++++++++++++++++----------------------
> 1 file changed, 17 insertions(+), 22 deletions(-)
>
>diff --git a/hw/core/sysbus=2Ec b/hw/core/sysbus=2Ec
>index f713bbfe04f=2E=2E306f98406c0 100644
>--- a/hw/core/sysbus=2Ec
>+++ b/hw/core/sysbus=2Ec
>@@ -80,13 +80,6 @@ static void system_bus_class_init(ObjectClass *klass, =
void *data)
>     k->get_fw_dev_path =3D sysbus_get_fw_dev_path;
> }
>=20
>-static const TypeInfo system_bus_info =3D {
>-    =2Ename =3D TYPE_SYSTEM_BUS,
>-    =2Eparent =3D TYPE_BUS,
>-    =2Einstance_size =3D sizeof(BusState),
>-    =2Eclass_init =3D system_bus_class_init,
>-};
>-
> /* Check whether an IRQ source exists */
> bool sysbus_has_irq(SysBusDevice *dev, int n)
> {
>@@ -306,15 +299,6 @@ static void sysbus_device_class_init(ObjectClass *kl=
ass, void *data)
>     k->user_creatable =3D false;
> }
>=20
>-static const TypeInfo sysbus_device_type_info =3D {
>-    =2Ename =3D TYPE_SYS_BUS_DEVICE,
>-    =2Eparent =3D TYPE_DEVICE,
>-    =2Einstance_size =3D sizeof(SysBusDevice),
>-    =2Eabstract =3D true,
>-    =2Eclass_size =3D sizeof(SysBusDeviceClass),
>-    =2Eclass_init =3D sysbus_device_class_init,
>-};
>-
> static BusState *main_system_bus;
>=20
> static void main_system_bus_create(void)
>@@ -337,10 +321,21 @@ BusState *sysbus_get_default(void)
>     return main_system_bus;
> }
>=20
>-static void sysbus_register_types(void)
>-{
>-    type_register_static(&system_bus_info);
>-    type_register_static(&sysbus_device_type_info);
>-}
>+static const TypeInfo sysbus_types[] =3D {
>+    {
>+        =2Ename           =3D TYPE_SYSTEM_BUS,
>+        =2Eparent         =3D TYPE_BUS,
>+        =2Einstance_size  =3D sizeof(BusState),
>+        =2Eclass_init     =3D system_bus_class_init,
>+    },
>+    {
>+        =2Ename           =3D TYPE_SYS_BUS_DEVICE,
>+        =2Eparent         =3D TYPE_DEVICE,
>+        =2Einstance_size  =3D sizeof(SysBusDevice),
>+        =2Eabstract       =3D true,
>+        =2Eclass_size     =3D sizeof(SysBusDeviceClass),
>+        =2Eclass_init     =3D sysbus_device_class_init,
>+    },
>+};
>=20
>-type_init(sysbus_register_types)
>+DEFINE_TYPES(sysbus_types)

Can now omit the "qom/module=2Eh" include=2E With that changed:

Reviewed-by: Bernhard Beschow

