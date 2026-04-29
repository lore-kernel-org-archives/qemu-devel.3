Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E31FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7w-0003WQ-Bj; Wed, 29 Apr 2026 16:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QX-0008KH-Py
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:12 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QV-0007if-Bp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so9244876f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471085; x=1778075885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dISlLOgELyvKWF7YlFcG2dTrk3AD7+Q7q5PPE/Lrnp4=;
 b=AY1XTYdY7q6ngV4c/WA1GN6v1TNY8SZUOuypAlo/qOH1dARMzQcJhL1adKyeULerQf
 hImhofaznjYfd9GYENlHHAHCE6mazZR3DN33PNMxqUeBaa+FbgPTeEB3YQNI+cTKuXXd
 xOQnOu9X8lUKxwnafiJYR4Hs1FV7OCSdnDKN36Edo7A0mndYYp7p4E7rFObEF4ey8jJ0
 fVuPSPCQmNdhbCnRQ5GKYHAzy1S71ER/OtdDUGBkmyzLBxZE+kZr4MXswxiZlnuE1aMb
 3zVm0luerjVFvEvmGbrSUWguVMyPMhlK8uMtRt4pUUnnmxtnXMA/esGvkbbBGWeKZsIC
 VjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471085; x=1778075885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dISlLOgELyvKWF7YlFcG2dTrk3AD7+Q7q5PPE/Lrnp4=;
 b=LuOug9YPl72J6Q4ikTvvDL2lZ21khIYgMAWJK4oqUn2j8+wn4O6nfDqAbBKk9y/32v
 Lf39oPbbHXuEM0/xXlQztgBC0CeAiDZy6h2iRhRFBuTymNDcXFUBxErbmzvjcBiANSs5
 qGF/zSJIawdA+HIEF+PdNiPkAMAzZ1yogfHIBr9FRMUayl578tQcYa1QyS7u8OnlC/JY
 cAbi4ui8QoXGAImhpT4+DyYoOL+PCtopXvER4iTHhAQ02uugOb1tv9xgBxu7TWaZ8Cmv
 +oSpUZY66D4+XzZg+5hL42SL3ygHGukMCPA9QB4SjR/QNUy0pVuf10xtbUCH3pjyfIXr
 ePiw==
X-Gm-Message-State: AOJu0YxNZ9/xvYGtqp6KHtMOEvIoIfIztYRGUvn83/zhDxUihaQ14UQh
 d/3qf2nvYAVdcTQUdXk+k3Ysy7qpIElekV6QICTaJk79PPekPRHjB06U
X-Gm-Gg: AeBDiestvrpmztxWSzJoYpiJJlJ5qj19nb0WMYzwGquDUVbew9M6e+QdTiLl7u0DAks
 94YR9XT+Xi+pZaRq18YjXs1LAcK0rVmnWKDum/CQPG9WvudQHUiPTMPBULBCDgVvHzJxnloeSd5
 EFmqbLE9x7XrwgFbJE77BMqmXHv0dRB+MLuqP/uxE4wbJ80Rzrkb7MMmXUwOTIrKu6IfpEYxmp6
 A3sfZ7i7eNPESgUk6LLIturFhCvAaoayHmrjVxto7DjCefqAwfsV9MIAXSoy9T+6pzhm/s3W6Wm
 xVfOeIzCSIJTyN0eVM15mpS64+ymRieAkvSBN2ZSjX2VeTrBNXgSkY+K63eLoeHWe4w7SEbY3c6
 PFB4daZ9lrDfvXCgujAdD5LTlikARl2QTl3kFX7NrKE6FDNKlzXGPDK9Lgfd2EM1N6AWzzeDssK
 zewe6GVRIcKoA/Fng0HfjrOGooc6nzfK/2xa7yBUUSJAAR8Q3uFT13q/GsoKTzPHMy2nyS2EdL8
 AL/IS5VDXk=
X-Received: by 2002:a5d:5848:0:b0:441:2473:c30a with SMTP id
 ffacd0b85a97d-446496d79aemr13966246f8f.31.1777471085059; 
 Wed, 29 Apr 2026 06:58:05 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:58:04 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 08/10] cxl-cci-mailbox: Add support for targeting a
 VCS switch
Date: Wed, 29 Apr 2026 14:48:42 +0100
Message-ID: <20260429135717.3048713-9-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=joshualant@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:14 -0400
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

Allows a cci mailbox and mctp device to target a cxl-vcs-switch. The
target needs to be changed from a PCIDevice to a more generic Object,
since the target can now also be a cxl-vcs-switch, as well as USP or
type3 device. The VCS is an object which is composed of many
PCI devices, but cannot be classed as one itself (since it is busless).

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 44 +++++++++++++++++++++++--------------
 hw/cxl/switch-mailbox-cci.c | 33 ++++++++++++++++++++++------
 hw/usb/dev-mctp.c           | 23 ++++++++++++++++---
 include/hw/cxl/cxl_device.h | 10 ++++++++-
 4 files changed, 83 insertions(+), 27 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f12e42a648..779138cdc8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4600,22 +4600,24 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     /* forbid any selected commands while the media is disabled */
-    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
-        cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
-
-        if (cxl_dev_media_disabled(cxl_dstate)) {
-            if (h == cmd_events_get_records ||
-                h == cmd_ccls_get_partition_info ||
-                h == cmd_ccls_set_lsa ||
-                h == cmd_ccls_get_lsa ||
-                h == cmd_logs_get_log ||
-                h == cmd_media_get_poison_list ||
-                h == cmd_media_inject_poison ||
-                h == cmd_media_clear_poison ||
-                h == cmd_sanitize_overwrite ||
-                h == cmd_firmware_update_transfer ||
-                h == cmd_firmware_update_activate) {
-                return CXL_MBOX_MEDIA_DISABLED;
+    if(cci->d) {
+        if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+            cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+
+            if (cxl_dev_media_disabled(cxl_dstate)) {
+                if (h == cmd_events_get_records ||
+                    h == cmd_ccls_get_partition_info ||
+                    h == cmd_ccls_set_lsa ||
+                    h == cmd_ccls_get_lsa ||
+                    h == cmd_logs_get_log ||
+                    h == cmd_media_get_poison_list ||
+                    h == cmd_media_inject_poison ||
+                    h == cmd_media_clear_poison ||
+                    h == cmd_sanitize_overwrite ||
+                    h == cmd_firmware_update_transfer ||
+                    h == cmd_firmware_update_activate) {
+                    return CXL_MBOX_MEDIA_DISABLED;
+                }
             }
         }
     }
@@ -4909,3 +4911,13 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
 }
+
+void cxl_initialize_vcs_mctpcci(CXLCCI *cci, CXLVCSSwitch *vcs, DeviceState *d,
+        DeviceState *intf, size_t payload_max)
+{
+    cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
+    cci->vcs = vcs;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 223f220433..73f76484cc 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -16,6 +16,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "hw/cxl/cxl.h"
+#include "include/hw/cxl/cxl_vcs_switch.h"
 
 #define CXL_SWCCI_MSIX_MBOX 3
 
@@ -32,17 +33,26 @@ static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
     CXLDeviceState *cxl_dstate = &cswmb->cxl_dstate;
     CXLDVSECRegisterLocator *regloc_dvsec;
     CXLUpstreamPort *usp;
+    CXLVCSSwitch *vcs = 0;
 
     if (!cswmb->target) {
-        error_setg(errp, "Target not set");
+        error_setg(errp, "No target or vcs has been set...");
         return;
     }
-    usp = CXL_USP(cswmb->target);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
     cxl_cstate->dvsec_offset = 0x100;
     cxl_cstate->pdev = pci_dev;
-    cswmb->cci = &usp->swcci;
+    if (object_dynamic_cast(cswmb->target, TYPE_CXL_VCS_SWITCH)) {
+	vcs = CXL_VCS_SWITCH(cswmb->target);
+	cswmb->cci = &vcs->swcci;
+    } else if (object_dynamic_cast(cswmb->target, TYPE_CXL_USP)) {
+	usp = CXL_USP(cswmb->target);
+	cswmb->cci = &usp->swcci;
+    } else {
+	error_setg(errp, "Target must be a VCS switch or USP");
+	return;
+    }
     cxl_device_register_block_init(OBJECT(pci_dev), cxl_dstate, cswmb->cci);
     pci_register_bar(pci_dev, 0,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -57,9 +67,18 @@ static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
                                REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
 
-    cxl_initialize_mailbox_swcci(cswmb->cci, DEVICE(pci_dev),
-                                 DEVICE(cswmb->target),
-                                 CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+    if(vcs) {
+	if(vcs->usp_ppbs[0]) {
+	    cxl_initialize_vcs_mctpcci(cswmb->cci,
+		vcs, DEVICE(vcs->usp_ppbs[0]->usp), DEVICE(pci_dev), CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+	} else {
+	    error_setg(errp, "The VCS requires a master USP...");
+	}
+    } else {
+	cxl_initialize_mailbox_swcci(cswmb->cci, DEVICE(pci_dev),
+				     DEVICE(CXL_USP(cswmb->target)),
+				     CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+    }
 }
 
 static void cswmbcci_exit(PCIDevice *pci_dev)
@@ -69,7 +88,7 @@ static void cswmbcci_exit(PCIDevice *pci_dev)
 
 static const Property cxl_switch_cci_props[] = {
     DEFINE_PROP_LINK("target", CSWMBCCIDev,
-                     target, TYPE_CXL_USP, PCIDevice *),
+                     target, TYPE_OBJECT, Object *),
 };
 
 static void cswmbcci_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/usb/dev-mctp.c b/hw/usb/dev-mctp.c
index aafb9e7e96..792a375245 100644
--- a/hw/usb/dev-mctp.c
+++ b/hw/usb/dev-mctp.c
@@ -25,6 +25,7 @@
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "net/mctp.h"
+#include "include/hw/cxl/cxl_vcs_switch.h"
 
 /* TODO: Move to header */
 
@@ -77,7 +78,7 @@ enum cxl_dev_type {
 
 typedef struct USBCXLMCTPState {
     USBDevice dev;
-    PCIDevice *target;
+    Object *target;
     CXLCCI *cci;
     enum cxl_dev_type type;
     USBPacket *cached_tohost;
@@ -600,12 +601,28 @@ static void usb_cxl_mctp_realize(USBDevice *dev, Error **errp)
         return;
     }
 
+    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_VCS_SWITCH)) {
+        CXLVCSSwitch *sw = CXL_VCS_SWITCH(s->target);
+
+        s->type = cxl_switch;
+        s->cci = &sw->mctpcci;
+	s->cci->vcs = sw;
+
+	if(sw->usp_ppbs[0]) {
+	    cxl_initialize_vcs_mctpcci(s->cci, CXL_VCS_SWITCH(s->target),
+		DEVICE(sw->usp_ppbs[0]->usp), DEVICE(dev), MCTP_CXL_MAILBOX_BYTES);
+	} else {
+	    error_setg(errp, "No master USP associated with the VCS");
+	}
+        return;
+    }
+
     error_setg(errp, "Unhandled target type for CXL MCTP EP");
 }
 
 static const Property usb_cxl_mctp_properties[] = {
-    DEFINE_PROP_LINK("target", USBCXLMCTPState, target, TYPE_PCI_DEVICE,
-                     PCIDevice *),
+    DEFINE_PROP_LINK("target", USBCXLMCTPState, target, TYPE_OBJECT,
+                     Object *),
 };
 
 static void usb_cxl_mctp_class_initfn(ObjectClass *klass, const void *data)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 6158560e6c..5d9f537a03 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -143,6 +143,7 @@ typedef enum {
 } CXLDSMASFlags;
 
 typedef struct CXLCCI CXLCCI;
+typedef struct CXLVCSSwitch CXLVCSSwitch;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
 typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
@@ -212,6 +213,8 @@ typedef struct CXLCCI {
     DeviceState *d;
     /* Pointer to the device hosting the protocol conversion */
     DeviceState *intf;
+    /* Pointer to the vcs hosting the CCI (if used) */
+    CXLVCSSwitch *vcs;
     bool initialized;
 } CXLCCI;
 
@@ -349,6 +352,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                 size_t payload_max);
 
+void cxl_initialize_vcs_mctpcci(CXLCCI *cci, CXLVCSSwitch *vcs,
+	DeviceState *d, DeviceState *intf, size_t payload_max);
+
+
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
         uint32_t *cap_hdrs = dstate->caps_reg_state32;                     \
@@ -820,9 +827,10 @@ struct CXLType3Class {
                           uint8_t *data);
 };
 
+
 struct CSWMBCCIDev {
     PCIDevice parent_obj;
-    PCIDevice *target;
+    Object *target;
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
     CXLCCI *cci;
-- 
2.47.3


