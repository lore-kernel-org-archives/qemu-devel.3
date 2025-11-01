Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837C9CCFA02
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 20:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFIRI-0000LT-1G; Sat, 01 Nov 2025 16:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFIRG-0000K2-0f
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 16:43:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFIRC-0004ff-BU
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 16:43:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-429bb95a238so2051913f8f.0
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762029779; x=1762634579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9lLTegtzap79vr7kWSGBK4I2Emf+K2DNbL9nkfz3Iw=;
 b=OT4pJtpWvenMsWcrM1Szwg7eKEDEyanHazzXewR/q5VuXUYUOvUpQRQw++LKl1tCUt
 rO1uBtUk77KnhCMot1MTqVFF72kL/YFBLVlP/gP/60Lk56T0GZJRHNBXZx8jrPMQzvRK
 M4/cDXY/tk0irlhkkRk+1OD2thMSRcqbH3G1W0WfLhQvNsU2+kBJnZvK3JH+gcrMspqY
 RSlNX6NGuoQEZA6+/0FtozM2CeivcgBTvPzjTBvAeRllGiuDO+EpOKR2Aq87B/eU67fT
 dxk4zHGttBX6kfhJ/91thZYYWcTyOKaXbZIQE0P02C9u3vMGR4vrrpa0eDEXj0dDS8o/
 xubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762029779; x=1762634579;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9lLTegtzap79vr7kWSGBK4I2Emf+K2DNbL9nkfz3Iw=;
 b=pi0F9EPOFpoBfxgVVqIsfvSG2OFY+h90ZuOKJ79x7RlcOPltksOncUTqZlc/C0qUQA
 g4L5gqpfrkeD0EWJvteU3dV8l56SAIJNep+01ZwOhlvo/dLHW3n+gnv7gUWf9sSTaniY
 nxXi5ZNDHLdZnZ88JZrL306P8MmK1LhjhB/yVM3/W1aQpZG5KVoyoKfynqRRsMFBSmkW
 htHGV06Nj5SVBkz6oL7enAIKEKyqRzmL5sOAGs9HdZZpSQj2aDQ6Zl5MdAuTy3NRMdmC
 7GrrSEwfq5U02Z7KX+zVZLPWaoo2KeKxhUu9S4ENY8/gPFg6BJdAz2GjhtuU7905CZgQ
 mK+Q==
X-Gm-Message-State: AOJu0YwXdBW+aBXgYtTdUL3QRXx0JynUjDKHevE5nejsZKSWjcpTR8Dx
 qD4MR1TJs7HYdsQJZ4y5d+2STE3uVTkPQex9jL5R7paXbJjqTGsU6rZPkGGKhg==
X-Gm-Gg: ASbGncvT0Wp3xSTmCBM95fg446aPol3LvucL/vkdl0zQI17pOK4Nqay5hDk502QEr2V
 woD5/GUw2KALzGGxY4CYLXxdPV86wg6Lcs8gPzPZC33LE4wEIl1ZX7+1Qz3Tyzv4EC71mhyV8DB
 2c9bmU+HI4JQytXF9soV7AvxGvJ/khfky7HzDfVj+iTZnBL02jRKefPNHcu1CkzbAx+/eTycdAd
 i+KmBxE2FqralslsQ8FwtvJxlHYh2o3NJOhDbvLvCgsPqQlfmGftHLMnm+/NIpMVhqt1d84Z0ey
 wFdQ87DlO5VNsYsS5Cm0Lt09mxGKDsFpYO5pcZ8X6PgIgwn9aSzcZ6SopvBNVO+YOYiBWlaq+Tc
 fGRXAEKLaBgogNaxHEr2N05xJpnd3UJuSqiPv/QmhTcvRM3fhzKZ9RiasEhqTUJxrAyi84YnfrR
 G/0ud72r+Z/+itONX78H6o7orWo+EoCqzXWJEirBpO8hPj3COnF5fOJ9lnJJ0oLGhc2gshhZ/8
X-Google-Smtp-Source: AGHT+IHoKqVqIRFiFpLeGFkOnVsSLT038NZc85waEaD4OvEv3SML6AbeRmiqApcl8+pzNt75vMpAdw==
X-Received: by 2002:a05:6000:18a8:b0:429:cbdc:86e with SMTP id
 ffacd0b85a97d-429cbdc0cc4mr1148601f8f.18.1762029778546; 
 Sat, 01 Nov 2025 13:42:58 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400bdbc21c775fcdd84.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:bdbc:21c7:75fc:dd84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114ca0csm12307623f8f.21.2025.11.01.13.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 13:42:56 -0700 (PDT)
Date: Sat, 01 Nov 2025 16:45:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 mohamed@unpredictable.fr
CC: Pedro Barbuda <pbarbuda@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v10 16/28] hw: arm: virt: rework MSI-X configuration
In-Reply-To: <20251029165510.45824-17-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
 <20251029165510.45824-17-mohamed@unpredictable.fr>
Message-ID: <2C77B523-2599-49B4-9B94-3313A77B886C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 29=2E Oktober 2025 16:54:58 UTC schrieb Mohamed Mediouni <mohamed@unpre=
dictable=2Efr>:
>Introduce a -M msi=3D argument to be able to control MSI-X support indepe=
ndently
>from ITS, as part of supporting GICv3 + GICv2m platforms=2E
>
>Remove vms->its as it's no longer needed after that change=2E
>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>---
> hw/arm/virt-acpi-build=2Ec |   3 +-
> hw/arm/virt=2Ec            | 110 +++++++++++++++++++++++++++++++--------
> include/hw/arm/virt=2Eh    |   4 +-
> 3 files changed, 93 insertions(+), 24 deletions(-)
>
>diff --git a/hw/arm/virt-acpi-build=2Ec b/hw/arm/virt-acpi-build=2Ec
>index 8e730731ca=2E=2Ea6a56455a9 100644
>--- a/hw/arm/virt-acpi-build=2Ec
>+++ b/hw/arm/virt-acpi-build=2Ec
>@@ -961,8 +961,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>         }
>     }
>=20
>-    if (!(vms->gic_version !=3D VIRT_GIC_VERSION_2 && virt_is_its_enable=
d(vms))
>-     && !vms->no_gicv3_with_gicv2m) {
>+    if (virt_is_gicv2m_enabled(vms)) {
>         const uint16_t spi_base =3D vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_=
BASE;
>=20
>         /* 5=2E2=2E12=2E16 GIC MSI Frame Structure */
>diff --git a/hw/arm/virt=2Ec b/hw/arm/virt=2Ec
>index dbf9a28b8d=2E=2E6978d4e867 100644
>--- a/hw/arm/virt=2Ec
>+++ b/hw/arm/virt=2Ec
>@@ -964,12 +964,12 @@ static void create_gic(VirtMachineState *vms, Memor=
yRegion *mem)
>=20
>     fdt_add_gic_node(vms);
>=20
>-    if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && virt_is_its_enabled(=
vms)) {
>+    if (virt_is_its_enabled(vms)) {
>         create_its(vms);
>-    } else if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && !vms->no_gicv=
3_with_gicv2m) {
>-        create_v2m(vms);
>-    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>+    } else if (virt_is_gicv2m_enabled(vms)) {
>         create_v2m(vms);
>+    } else {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>     }
> }
>=20
>@@ -2716,32 +2716,93 @@ static void virt_set_highmem_mmio_size(Object *ob=
j, Visitor *v,
>=20
> bool virt_is_its_enabled(VirtMachineState *vms)
> {
>-    if (vms->its =3D=3D ON_OFF_AUTO_OFF) {
>-        return false;
>+    switch (vms->msi_controller) {
>+        case VIRT_MSI_CTRL_NONE:
>+            return false;
>+        case VIRT_MSI_CTRL_ITS:
>+            return true;
>+        case VIRT_MSI_CTRL_GICV2M:
>+            return false;
>+        case VIRT_MSI_CTRL_AUTO:
>+            if (whpx_enabled() && whpx_irqchip_in_kernel()) {

Under x86_64 Linux whpx_irqchip_in_kernel() isn't found during linking=2E

Best regards,
Bernhard

>+                return false;
>+            }
>+            if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>+                return false;
>+            }
>+            return true;
>+        default:
>+            return false;
>     }
>-    if (vms->its =3D=3D ON_OFF_AUTO_AUTO) {
>-        if (whpx_enabled()) {
>+}
>+
>+bool virt_is_gicv2m_enabled(VirtMachineState *vms)
>+{
>+    switch (vms->msi_controller) {
>+        case VIRT_MSI_CTRL_NONE:
>             return false;
>-        }
>+        default:
>+            return !virt_is_its_enabled(vms);
>     }
>-    return true;
> }
>=20
>-static void virt_get_its(Object *obj, Visitor *v, const char *name,
>-                          void *opaque, Error **errp)
>+static char *virt_get_msi(Object *obj, Error **errp)
>+{
>+    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>+    const char *val;
>+
>+    switch (vms->msi_controller) {
>+    case VIRT_MSI_CTRL_NONE:
>+        val =3D "off";
>+        break;
>+    case VIRT_MSI_CTRL_ITS:
>+        val =3D "its";
>+        break;
>+    case VIRT_MSI_CTRL_GICV2M:
>+        val =3D "gicv2m";
>+    default:
>+        val =3D "auto";
>+        break;
>+    }
>+    return g_strdup(val);
>+}
>+
>+static void virt_set_msi(Object *obj, const char *value, Error **errp)
> {
>     VirtMachineState *vms =3D VIRT_MACHINE(obj);
>-    OnOffAuto its =3D vms->its;
>=20
>-    visit_type_OnOffAuto(v, name, &its, errp);
>+    if (!strcmp(value, "auto")) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_AUTO; /* Will be overriden=
 later */
>+    } else if (!strcmp(value, "its")) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_ITS;
>+    } else if (!strcmp(value, "gicv2m")) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>+    } else if (!strcmp(value, "none")) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>+    } else {
>+        error_setg(errp, "Invalid msi value");
>+        error_append_hint(errp, "Valid values are auto, gicv2m, its, off=
\n");
>+    }
> }
>=20
>-static void virt_set_its(Object *obj, Visitor *v, const char *name,
>-                          void *opaque, Error **errp)
>+static bool virt_get_its(Object *obj, Error **errp)
> {
>     VirtMachineState *vms =3D VIRT_MACHINE(obj);
>=20
>-    visit_type_OnOffAuto(v, name, &vms->its, errp);
>+    return virt_is_its_enabled(vms);
>+}
>+
>+static void virt_set_its(Object *obj, bool value, Error **errp)
>+{
>+    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>+
>+    if (value) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_ITS;
>+    } else if (vms->no_gicv3_with_gicv2m) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>+    } else {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>+    }
> }
>=20
> static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>@@ -3068,6 +3129,8 @@ static void virt_machine_device_pre_plug_cb(Hotplug=
Handler *hotplug_dev,
>             db_start =3D base_memmap[VIRT_GIC_V2M]=2Ebase;
>             db_end =3D db_start + base_memmap[VIRT_GIC_V2M]=2Esize - 1;
>             break;
>+        case VIRT_MSI_CTRL_AUTO:
>+            g_assert_not_reached();
>         }
>         resv_prop_str =3D g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
>                                         db_start, db_end,
>@@ -3451,13 +3514,18 @@ static void virt_machine_class_init(ObjectClass *=
oc, const void *data)
>                                           "guest CPU which implements th=
e ARM "
>                                           "Memory Tagging Extension");
>=20
>-    object_class_property_add(oc, "its", "OnOffAuto",
>-        virt_get_its, virt_set_its,
>-        NULL, NULL);
>+    object_class_property_add_bool(oc, "its", virt_get_its,
>+                                   virt_set_its);
>     object_class_property_set_description(oc, "its",
>                                           "Set on/off to enable/disable =
"
>                                           "ITS instantiation");
>=20
>+    object_class_property_add_str(oc, "msi", virt_get_msi,
>+                                  virt_set_msi);
>+    object_class_property_set_description(oc, "msi",
>+                                          "Set MSI settings=2E "
>+                                          "Valid values are auto/gicv2m/=
its/off");
>+
>     object_class_property_add_bool(oc, "dtb-randomness",
>                                    virt_get_dtb_randomness,
>                                    virt_set_dtb_randomness);
>@@ -3514,7 +3582,7 @@ static void virt_instance_init(Object *obj)
>     vms->highmem_redists =3D true;
>=20
>     /* Default allows ITS instantiation if available */
>-    vms->its =3D ON_OFF_AUTO_AUTO;
>+    vms->msi_controller =3D VIRT_MSI_CTRL_AUTO;
>     /* Allow ITS emulation if the machine version supports it */
>     vms->tcg_its =3D !vmc->no_tcg_its;
>     vms->no_gicv3_with_gicv2m =3D false;
>diff --git a/include/hw/arm/virt=2Eh b/include/hw/arm/virt=2Eh
>index 997dd51678=2E=2E99db8607e7 100644
>--- a/include/hw/arm/virt=2Eh
>+++ b/include/hw/arm/virt=2Eh
>@@ -101,6 +101,8 @@ typedef enum VirtIOMMUType {
>=20
> typedef enum VirtMSIControllerType {
>     VIRT_MSI_CTRL_NONE,
>+    /* This value is overriden at runtime=2E*/
>+    VIRT_MSI_CTRL_AUTO,
>     VIRT_MSI_CTRL_GICV2M,
>     VIRT_MSI_CTRL_ITS,
> } VirtMSIControllerType;
>@@ -149,7 +151,6 @@ struct VirtMachineState {
>     bool highmem_ecam;
>     bool highmem_mmio;
>     bool highmem_redists;
>-    OnOffAuto its;
>     bool tcg_its;
>     bool virt;
>     bool ras;
>@@ -219,5 +220,6 @@ static inline int virt_gicv3_redist_region_count(Virt=
MachineState *vms)
> }
>=20
> bool virt_is_its_enabled(VirtMachineState *vms);
>+bool virt_is_gicv2m_enabled(VirtMachineState *vms);
>=20
> #endif /* QEMU_ARM_VIRT_H */

