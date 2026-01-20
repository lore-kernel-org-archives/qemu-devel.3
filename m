Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C63CA5FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG5N-00078C-It; Tue, 20 Jan 2026 13:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG51-0006eF-0G
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:52 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4y-0000UP-L4
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:50 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so4804253f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768932227; x=1769537027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0ZMXUtic4MuRKS7Dby22dacdT6+N9i2g5JnhZrBGrY=;
 b=DqqYywy6J8hRy8ZrLXIRrwgWM8xYBRzt78drH6gIX626+8/H5kg3XDviE+xHd+Boos
 NE3ihhHB2XnQ+GL8mCWLx6vtGMjH3L9aJhCcIA+dh367SOSZlfMnID/gCtJD75m01Mup
 OhuylGN0haZSWMMFxfZZ/+5ySDsGbE9gELIMuoVeKf3ZxK6n8JioeCTM50RPF7JFEAyW
 H5kq0dqkNcH1C6vo0/H4GD96w62RLsSpI3vckcdrTJhiqU5vymWFH4/XZxeLmi9f+nzY
 sYM/lnv5NGEVzoKNjhIP6JEbLUfCoG5wPYxONXULZizgCYC0nBGb0pHLkeAy5ZLi4N23
 xtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932227; x=1769537027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L0ZMXUtic4MuRKS7Dby22dacdT6+N9i2g5JnhZrBGrY=;
 b=NoBQJogjNRVccxo1ioSXeCVWTwJ045ZuseCRko7ZDHZEa4W9UgmG3OBREL12e5XHud
 Lt8O71+o5/GYPvfL8dSjmJsHDzYYvhdyzoLw0hvZSoGfxLBxRpT3IEz8nJm0r3YP6Nvf
 fLlXYgugay4EQKEZAk3MYUBX9uQyc0VGSDgZtfb5bXFFk7za2G6leTQwSLylpR04jd3p
 llrGoSxMbyv1LzHF1m+7UnkNsth96Y7UC9EvftL2Tr9mU4Vi0uCwLwTOlZ4DN/2V/Icq
 C/YGugf/jOFeuiuAbCJ9T4jd6OcKpyoUm+aHyJxSoYHjLpl2lXv8Fi+8FZtZloORh7wI
 ll0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyndV5edoczukUltdguQ3o/rUL8eNv0tEw+cWuzSQX50q1hprjgEoW58oEYXlU6jxVscxHvxU2x5CO@nongnu.org
X-Gm-Message-State: AOJu0YwIlkDGLXwZemxnAMUc3XF43Uy7Px7/zSujFNxn+GYlBFI2NiYG
 ibFLEHlBM2qj7nZTOHlMFOUo9D4h9m5FNlnrhSKqOINpM3ucfadqBn0mrvE6VA3hso0=
X-Gm-Gg: AZuq6aKWHhejZXyPJ3tbvf8XzPRQ8XGXratrlyKMXLwMVnBIOHCDNO63yCmpS17k2lN
 WLncAX4gq6MkG4/sP+weK2MgEknCFvZIFDWcDlDhRGwaP02B8ctiWUPfODSksBZQ7ESU/h/pycx
 wSTaWpNx4BpmEN9BEyOh8Fan3ewhoIIvff/vcqbt62VK7qlP5xryIbRPjyHdDHnkNA+teJyEz/N
 ZKTlp0Cbas9OvlHjtF2SdLeGYdIAc/qGix2vfHejISR3l0OVNgMRb0aojwoV2t+STCrxJ99PDrA
 KXzYoydJUVkhlDujBs0ZmPmgxuB8vf3CYRln1wLPko1/Yy7NpUn8tqIzVgnT2+3o10tR2vVJdp7
 f90eomeLDlXlTWWAOMUHmfOqcLKJOiZZDTuIFreHx+01KmvzdN4ty4q5QRdnpz8djSpy3qG9zY5
 FQLozhIz5ZpA7lvfZmm2uP3silWTvaR/VOX82p95NNxanSlkZL2bzN6zZDUEaRkIQ=
X-Received: by 2002:a05:6000:4383:b0:433:24c7:880e with SMTP id
 ffacd0b85a97d-4358ff26a86mr4252941f8f.33.1768932225035; 
 Tue, 20 Jan 2026 10:03:45 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf58sm31310889f8f.22.2026.01.20.10.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:03:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 4/4] hw/arm/virt: new "msi" property
Date: Tue, 20 Jan 2026 18:03:39 +0000
Message-ID: <20260120180339.1416328-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120180339.1416328-1-peter.maydell@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The virt board currently only supports either a GICv2 with a possible
GICv2m for handling MSI interrupts, or else a GICv3 with a possible
ITS for handling MSI interrupts.  There is one board property, which
lets you say "its=(off|on)" and controls only whether there is an ITS
or not.

This is awkward for macOS HVF, where you get a GICv3
without ITS and MSI handling needs a GICv2m.

Create a new board property "msi" which gives the user clearer
control over how MSI interrupts are handled:

 - msi=its : create an ITS
 - msi=gicv2m : create a GICv2m
 - msi=off : do not create any MSI handling device
 - msi=auto : create the best MSI handling device available
              for the GIC version and accelerator

The default is 'auto'.

The existing 'its' property becomes a deprecated property
kept for compatibility. Existing users of "its=on" should
prefer "msi=auto"; users of "its=off" should use "msi=off".

The backwards compatibility cases we need to support are:
 (1) TCG, virt-6.1 and earlier: no_tcg_its is set
   -- you can have a gicv2 (always with a gicv2m)
   -- if you specify gic-version=3 you get a GICv3 without ITS
 (2) TCG, virt-6.2 and later:
   -- gic-version=2 still has gicv2m
   -- gic-version=3 by default gives you an ITS; if you also
      say its=off you get GICv3 with no ITS
   -- there is no case where we provide a GICv3 and are
      unable to provide an ITS for it
 (3) KVM (any version):
   -- gic-version=2 has a gicv2m
   -- gic-version=3 gives you an ITS by default; its=off
      will remove it
   -- there is no case where we provide a GICv3 and are
      unable to provide an ITS for it
 (4) HVF:
   -- only gic-version=2 works, you get a gicv2m

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 21 ++++++++++++-
 hw/arm/virt.c            | 64 +++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h    |  1 +
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e5570773ba..4cc54e38db 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -167,9 +167,28 @@ gic-version
     with TCG this is currently ``3`` if ``virtualization`` is ``off`` and
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
+msi
+  Specify the MSI controller to use to handle MSI and MSI-X interrupts
+  from PCI devices. Valid values are:
+
+  ``its``
+     ITS, which can be used with a GICv3 or better.
+  ``gicv2m``
+     The GICv2m; this is typically used with a GICv2, but it is possible
+     to use it with a GICv3.
+  ``none``
+     Do not provide any MSI controller. MSI and MSI-X interrupts will
+     not be supported.
+  ``auto``
+     Pick the best available controller. This will be an ITS if the
+     GIC and virtualization accelerator support it, and a GICv2m if not.
+     This is the default.
+
 its
   Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  for machine types later than ``virt-2.7``. This is a deprecated option;
+  instead of ``its=on`` use ``msi=its`` or ``msi=auto``, and instead of
+  ``its=off`` use ``msi=none``.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b65f571532..471852e4b1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -957,6 +957,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     case VIRT_MSI_CTRL_GICV2M:
         create_v2m(vms);
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2084,6 +2086,23 @@ static void finalize_msi_controller(VirtMachineState *vms)
      */
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
+    if (vms->msi_controller != VIRT_MSI_CTRL_NOSEL) {
+        /*
+         * User specified an "msi" option: check what they
+         * specified, and use it.
+         */
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS &&
+            vms->gic_version == VIRT_GIC_VERSION_2) {
+            error_report("A GICv2 cannot use an ITS");
+            exit(1);
+        }
+        return;
+    }
+
+    /*
+     * Pick a "best available" MSI controller, including handling
+     * the legacy "its" option and the no_tcg_its compat flag.
+     */
     if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
         if (!kvm_irqchip_in_kernel() && vmc->no_tcg_its) {
             vms->msi_controller = VIRT_MSI_CTRL_NONE;
@@ -2092,6 +2111,8 @@ static void finalize_msi_controller(VirtMachineState *vms)
         }
     } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
         vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+    } else {
+        vms->msi_controller = VIRT_MSI_CTRL_NONE;
     }
 }
 
@@ -2881,6 +2902,36 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     }
 }
 
+static const char *msi_option_values[] = {
+    [VIRT_MSI_CTRL_NONE] = "off",
+    [VIRT_MSI_CTRL_GICV2M] = "gicv2m",
+    [VIRT_MSI_CTRL_ITS] = "its",
+    [VIRT_MSI_CTRL_NOSEL] = "auto",
+};
+
+static char *virt_get_msi(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    assert(vms->msi_controller >= 0 &&
+           vms->msi_controller < ARRAY_SIZE(msi_option_values));
+    return g_strdup(msi_option_values[vms->msi_controller]);
+}
+
+static void virt_set_msi(Object *obj, const char *value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(msi_option_values); i++) {
+        if (!strcmp(value, msi_option_values[i])) {
+            vms->msi_controller = i;
+            return;
+        }
+    }
+    error_setg(errp, "Invalid msi value");
+    error_append_hint(errp, "Valid values are off, its, gicv2m, auto.\n");
+}
+
 static char *virt_get_iommu(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -3056,6 +3107,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        default:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3454,7 +3507,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                    virt_set_its);
     object_class_property_set_description(oc, "its",
                                           "Set on/off to enable/disable "
-                                          "ITS instantiation");
+                                          "ITS instantiation. Deprecated; "
+                                          "use the msi option instead");
+
+    object_class_property_add_str(oc, "msi", virt_get_msi, virt_set_msi);
+    object_class_property_set_description(oc, "msi",
+                                          "Set to configure MSI handling. "
+                                          "Valid values are auto, its, gicv2m, and off");
 
     object_class_property_add_bool(oc, "dtb-randomness",
                                    virt_get_dtb_randomness,
@@ -3514,6 +3573,9 @@ static void virt_instance_init(Object *obj)
     /* Default allows ITS instantiation */
     vms->its = true;
 
+    /* Default to autoselection of MSI controller */
+    vms->msi_controller = VIRT_MSI_CTRL_NOSEL;
+
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 577b4b3362..53f1dc2199 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -103,6 +103,7 @@ typedef enum VirtMSIControllerType {
     VIRT_MSI_CTRL_NONE,
     VIRT_MSI_CTRL_GICV2M,
     VIRT_MSI_CTRL_ITS,
+    VIRT_MSI_CTRL_NOSEL,
 } VirtMSIControllerType;
 
 typedef enum VirtGICType {
-- 
2.47.3


