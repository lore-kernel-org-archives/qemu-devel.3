Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30170E74AD1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZQx-0004O1-Rd; Tue, 03 Dec 2024 15:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tIZQw-0004Nc-KB; Tue, 03 Dec 2024 15:23:46 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tIZQu-0006BQ-OT; Tue, 03 Dec 2024 15:23:46 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so4459122f8f.2; 
 Tue, 03 Dec 2024 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733257423; x=1733862223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWr3B4C8bAj6BivScsjyL8ezvL1IyxopWhrxQL4rFc0=;
 b=AdoQt1+vqnwEFz5/CihrWVGOuWiShIz1pjtRjy31u8/F6T3ZzeJB8Ui9ZoNc8ziHxv
 e1sdG1zflsI9qYco5vuiPFj1G+9dt9VqicTVfSGMLsCpLnQYXgvcFtCilEq/CounkXNs
 aqO7F+dSLnulWccUEeATCHKGqIBRfGvjGOlNinCCBgisZKVK6M9RA8ZFtHwxygCf+016
 d5LSkUGviCpM6zGZmkPyHyRNL1EQIPmf914fSPLUIhWlzYOwhKZ+4ToKRIKDCZ1hgXWC
 BHVdLrvZgkWsFHPJ7IlYgxe94AZNnhOpL4Udze9rHOSMWAEahRlihLYXXQk6AQGIIxkv
 5OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733257423; x=1733862223;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWr3B4C8bAj6BivScsjyL8ezvL1IyxopWhrxQL4rFc0=;
 b=XHHQ9O/Ll4bMUad9pn1+qSm2rABgQ7WbUv68YbgKTGgZ01hdbMnkBe3EWpvUwhu2/b
 6fa27YaWBUChrDCA2V6o05cMM9ydSXQCYnpyFL8Wq6oHATNoEWcmM8eTKQaplgrx5Oza
 7etGEbFfZoPbOrkpQ8l3kyRjxL82aJ25vrZr3YGmZtDm7uxO1q56mkrgzNGTqcA9Mv1/
 pa7Q3KJcMahqBoXLvxCNTXd5+2pd4afhAHQgfE7kadqm/kEJuqIyDY30KdURX20PR1/D
 NbocbRqsTOrjwy6/aDoL1NAySiw7KpLFlo6VhbRs7OPPkfHvaRaV86Infc5O8dDcorth
 dQOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQQJdoam/jh0FndJ3sARujxzwclZZMn7UtBXRmdJtUpaqLuyxGC4sV831ymkZXYYLSC0SVVGcLjg==@nongnu.org,
 AJvYcCW+aIq9HPYl1h+CaDOVRUhXheRrF5dyv4mXNF+JeKLLOx2TvLh2hQ8RsKeGDK1E64eSRFTGHfiWRQygMw==@nongnu.org
X-Gm-Message-State: AOJu0YxmpiwGSQXbGiAamtr2WlnqL5j2f9I0qEEyFAxhIpS0kMMFpYbN
 a0lphAp6iGK7ufaaKev96CcUKoNQJ5Qf6DZfkv+xyBjztYvkne0ObN8wQA==
X-Gm-Gg: ASbGncvm+bXDf0zGO2V7N0u29c/u6LmpRIq0JOumug6+cDUWSxY7xZJQIMT7QTnbJ0a
 0mK9krKcFFnC35OW9zC9kDY+U+y+jjjvFCQp5tq8lq/SF8t4Uq02KG3BgwEUMf0zHVxknCCptV7
 4OQ/ueajfRavUHPxDqtlZBSlhHBdJmSr4cJeRmIQGNineq2zXE7KZncJdFkhZhJP/aobJH60/uN
 NevUEpurBql2VwpZiUnGZdkeSGRVsZxCblb/oFfsXAhE53ivXvlqB8+hYvUAa4yklT2BqmWncJv
 HGLnxp/G6QH5hh097wntkT0=
X-Google-Smtp-Source: AGHT+IE2VK1egadmLfqT9AZwTvVt10/zBqtRrvmSY1jD61vRGH9/CoH6AgdjMpaPVl7emCoPUXbLLw==
X-Received: by 2002:a05:6000:2aa:b0:385:f349:fffb with SMTP id
 ffacd0b85a97d-385fd42a35fmr3288219f8f.45.1733257422614; 
 Tue, 03 Dec 2024 12:23:42 -0800 (PST)
Received: from [127.0.0.1] (dynamic-002-242-014-218.2.242.pool.telefonica.de.
 [2.242.14.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e17574ebsm12074198f8f.30.2024.12.03.12.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 12:23:42 -0800 (PST)
Date: Tue, 03 Dec 2024 20:23:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, Jamin Lin via <qemu-devel@nongnu.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: jamin_lin@aspeedtech.com, troy_lee@aspeedtech.com,
 yunlin.tang@aspeedtech.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/6=5D_hw=3Asdhci?=
 =?US-ASCII?Q?=3A_Introduce_a_new_=22capareg=22_?=
 =?US-ASCII?Q?class_member_to_set_the_different_Capability_Registers=2E?=
In-Reply-To: <20241203021500.3986213-4-jamin_lin@aspeedtech.com>
References: <20241203021500.3986213-1-jamin_lin@aspeedtech.com>
 <20241203021500.3986213-4-jamin_lin@aspeedtech.com>
Message-ID: <94E62126-BB97-465A-9021-2FB365E677A8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
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



Am 3=2E Dezember 2024 02:14:57 UTC schrieb Jamin Lin via <qemu-devel@nongn=
u=2Eorg>:
>Currently, it set the hardcode value of capability registers to all ASPEE=
D SOCs
>However, the value of capability registers should be different for all AS=
PEED
>SOCs=2E For example: the bit 28 of the Capability Register 1 should be 1 =
for
>64-bits System Bus support for AST2700=2E
>
>Introduce a new "capareg" class member whose data type is uint_64 to set =
the
>different Capability Registers to all ASPEED SOCs=2E
>
>The value of Capability Register is "0x0000000001e80080" for AST2400 and
>AST2500=2E The value of Capability Register is "0x0000000701f80080" for A=
ST2600=2E
>
>Signed-off-by: Jamin Lin <jamin_lin@aspeedtech=2Ecom>
>---
> hw/arm/aspeed_ast2400=2Ec      |  3 +-
> hw/arm/aspeed_ast2600=2Ec      |  7 ++--
> hw/sd/aspeed_sdhci=2Ec         | 72 +++++++++++++++++++++++++++++++-----
> include/hw/sd/aspeed_sdhci=2Eh | 12 +++++-
> 4 files changed, 78 insertions(+), 16 deletions(-)
>
>diff --git a/hw/arm/aspeed_ast2400=2Ec b/hw/arm/aspeed_ast2400=2Ec
>index ecc81ecc79=2E=2E3c1b419945 100644
>--- a/hw/arm/aspeed_ast2400=2Ec
>+++ b/hw/arm/aspeed_ast2400=2Ec
>@@ -224,7 +224,8 @@ static void aspeed_ast2400_soc_init(Object *obj)
>     snprintf(typename, sizeof(typename), "aspeed=2Egpio-%s", socname);
>     object_initialize_child(obj, "gpio", &s->gpio, typename);
>=20
>-    object_initialize_child(obj, "sdc", &s->sdhci, TYPE_ASPEED_SDHCI);
>+    snprintf(typename, sizeof(typename), "aspeed=2Esdhci-%s", socname);
>+    object_initialize_child(obj, "sdc", &s->sdhci, typename);
>=20
>     object_property_set_int(OBJECT(&s->sdhci), "num-slots", 2, &error_ab=
ort);
>=20
>diff --git a/hw/arm/aspeed_ast2600=2Ec b/hw/arm/aspeed_ast2600=2Ec
>index c40d3d8443=2E=2Eb5703bd064 100644
>--- a/hw/arm/aspeed_ast2600=2Ec
>+++ b/hw/arm/aspeed_ast2600=2Ec
>@@ -236,8 +236,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>     snprintf(typename, sizeof(typename), "aspeed=2Egpio-%s-1_8v", socnam=
e);
>     object_initialize_child(obj, "gpio_1_8v", &s->gpio_1_8v, typename);
>=20
>-    object_initialize_child(obj, "sd-controller", &s->sdhci,
>-                            TYPE_ASPEED_SDHCI);
>+    snprintf(typename, sizeof(typename), "aspeed=2Esdhci-%s", socname);
>+    object_initialize_child(obj, "sd-controller", &s->sdhci, typename);
>=20
>     object_property_set_int(OBJECT(&s->sdhci), "num-slots", 2, &error_ab=
ort);
>=20
>@@ -247,8 +247,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                 &s->sdhci=2Eslots[i], TYPE_SYSBUS_SDHCI)=
;
>     }
>=20
>-    object_initialize_child(obj, "emmc-controller", &s->emmc,
>-                            TYPE_ASPEED_SDHCI);
>+    object_initialize_child(obj, "emmc-controller", &s->emmc, typename);
>=20
>     object_property_set_int(OBJECT(&s->emmc), "num-slots", 1, &error_abo=
rt);
>=20
>diff --git a/hw/sd/aspeed_sdhci=2Ec b/hw/sd/aspeed_sdhci=2Ec
>index acd6538261=2E=2E93f5571021 100644
>--- a/hw/sd/aspeed_sdhci=2Ec
>+++ b/hw/sd/aspeed_sdhci=2Ec
>@@ -148,6 +148,7 @@ static void aspeed_sdhci_realize(DeviceState *dev, Er=
ror **errp)
> {
>     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>     AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
>+    AspeedSDHCIClass *asc =3D ASPEED_SDHCI_GET_CLASS(sdhci);
>=20
>     /* Create input irqs for the slots */
>     qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_ir=
q,
>@@ -167,7 +168,7 @@ static void aspeed_sdhci_realize(DeviceState *dev, Er=
ror **errp)
>         }
>=20
>         if (!object_property_set_uint(sdhci_slot, "capareg",
>-                                      ASPEED_SDHCI_CAPABILITIES, errp)) =
{
>+                                      asc->capareg, errp)) {
>             return;
>         }
>=20
>@@ -218,13 +219,66 @@ static void aspeed_sdhci_class_init(ObjectClass *cl=
assp, void *data)
>     device_class_set_props(dc, aspeed_sdhci_properties);
> }
>=20
>-static const TypeInfo aspeed_sdhci_types[] =3D {
>-    {
>-        =2Ename           =3D TYPE_ASPEED_SDHCI,
>-        =2Eparent         =3D TYPE_SYS_BUS_DEVICE,
>-        =2Einstance_size  =3D sizeof(AspeedSDHCIState),
>-        =2Eclass_init     =3D aspeed_sdhci_class_init,
>-    },

Why not just extend this array? It's made for registering multiple types, =
exactly what this patch is introducing=2E

>+static const TypeInfo aspeed_sdhci_info =3D {
>+    =2Ename           =3D TYPE_ASPEED_SDHCI,
>+    =2Eparent         =3D TYPE_SYS_BUS_DEVICE,
>+    =2Einstance_size  =3D sizeof(AspeedSDHCIState),
>+    =2Eclass_init     =3D aspeed_sdhci_class_init,
>+    =2Eclass_size =3D sizeof(AspeedSDHCIClass),
>+    =2Eabstract =3D true,
>+};
>+
>+static void aspeed_2400_sdhci_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    AspeedSDHCIClass *asc =3D ASPEED_SDHCI_CLASS(klass);
>+
>+    dc->desc =3D "ASPEED 2400 SDHCI Controller";
>+    asc->capareg =3D 0x0000000001e80080;
>+}
>+
>+static const TypeInfo aspeed_2400_sdhci_info =3D {
>+    =2Ename =3D TYPE_ASPEED_2400_SDHCI,
>+    =2Eparent =3D TYPE_ASPEED_SDHCI,
>+    =2Eclass_init =3D aspeed_2400_sdhci_class_init,
>+};
>+
>+static void aspeed_2500_sdhci_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    AspeedSDHCIClass *asc =3D ASPEED_SDHCI_CLASS(klass);
>+
>+    dc->desc =3D "ASPEED 2500 SDHCI Controller";
>+    asc->capareg =3D 0x0000000001e80080;
>+}
>+
>+static const TypeInfo aspeed_2500_sdhci_info =3D {
>+    =2Ename =3D TYPE_ASPEED_2500_SDHCI,
>+    =2Eparent =3D TYPE_ASPEED_SDHCI,
>+    =2Eclass_init =3D aspeed_2500_sdhci_class_init,
> };
>=20
>-DEFINE_TYPES(aspeed_sdhci_types)
>+static void aspeed_2600_sdhci_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    AspeedSDHCIClass *asc =3D ASPEED_SDHCI_CLASS(klass);
>+
>+    dc->desc =3D "ASPEED 2600 SDHCI Controller";
>+    asc->capareg =3D 0x0000000701f80080;
>+}
>+
>+static const TypeInfo aspeed_2600_sdhci_info =3D {
>+    =2Ename =3D TYPE_ASPEED_2600_SDHCI,
>+    =2Eparent =3D TYPE_ASPEED_SDHCI,
>+    =2Eclass_init =3D aspeed_2600_sdhci_class_init,
>+};
>+
>+static void aspeed_sdhci_register_types(void)
>+{
>+    type_register_static(&aspeed_sdhci_info);
>+    type_register_static(&aspeed_2400_sdhci_info);
>+    type_register_static(&aspeed_2500_sdhci_info);
>+    type_register_static(&aspeed_2600_sdhci_info);
>+}
>+
>+type_init(aspeed_sdhci_register_types);
>diff --git a/include/hw/sd/aspeed_sdhci=2Eh b/include/hw/sd/aspeed_sdhci=
=2Eh
>index 057bc5f3d1=2E=2E8083797e25 100644
>--- a/include/hw/sd/aspeed_sdhci=2Eh
>+++ b/include/hw/sd/aspeed_sdhci=2Eh
>@@ -13,9 +13,11 @@
> #include "qom/object=2Eh"
>=20
> #define TYPE_ASPEED_SDHCI "aspeed=2Esdhci"
>-OBJECT_DECLARE_SIMPLE_TYPE(AspeedSDHCIState, ASPEED_SDHCI)
>+#define TYPE_ASPEED_2400_SDHCI TYPE_ASPEED_SDHCI "-ast2400"
>+#define TYPE_ASPEED_2500_SDHCI TYPE_ASPEED_SDHCI "-ast2500"
>+#define TYPE_ASPEED_2600_SDHCI TYPE_ASPEED_SDHCI "-ast2600"
>+OBJECT_DECLARE_TYPE(AspeedSDHCIState, AspeedSDHCIClass, ASPEED_SDHCI)
>=20
>-#define ASPEED_SDHCI_CAPABILITIES 0x01E80080
> #define ASPEED_SDHCI_NUM_SLOTS    2
> #define ASPEED_SDHCI_NUM_REGS     (ASPEED_SDHCI_REG_SIZE / sizeof(uint32=
_t))
> #define ASPEED_SDHCI_REG_SIZE     0x100
>@@ -32,4 +34,10 @@ struct AspeedSDHCIState {
>     uint32_t regs[ASPEED_SDHCI_NUM_REGS];
> };
>=20
>+struct AspeedSDHCIClass {
>+    SysBusDeviceClass parent_class;
>+
>+    uint64_t capareg;
>+};

The struct seems not AST-specific and could be turned into a base class fo=
r all SDHCI device models, no? That way one could also add further device-s=
pecific constants other than capareg=2E

Best regards,
Bernhard

>+
> #endif /* ASPEED_SDHCI_H */

