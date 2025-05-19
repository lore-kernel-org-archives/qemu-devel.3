Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEF9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrnJ-00056j-1K; Mon, 19 May 2025 00:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrn3-0004oh-N3
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrn1-0004AQ-O8
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:49 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22e16234307so36906415ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627665; x=1748232465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5vu2hrQseFU8LOh7DPzcKh1zIWTsbn7UZDtVOI2mnY=;
 b=I1JTzu3LePCYDnOlY8wTAousGCRSYLneyGU8klvk0Fe8pA87F1WbK9km+0cUZtmLG0
 ptXtDIhMccSgasSIjW2bytDj57V+7vga+qeukWf+QE2SfZ9P4MxbXs9ke+A8fXDPNQLX
 8TuLJUK5+t89WgKZAZ/em77GnvvfR0X+LW8sAjmxANGG8wQclaPTAselWEbZuWs1Kfng
 ySYplcDM7yEpKCBkbMZJSQZeBB/16qDS3RY2JgMVZ91dW8wdfCHh9A3ZlnlMMxeuvNab
 knkPmlDiH5Vli1g9yiCZjtGGlei4eZMcCMBHa5mTz3woVAkaLWlEi8i2/WKkUErM9Mgw
 dEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627665; x=1748232465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5vu2hrQseFU8LOh7DPzcKh1zIWTsbn7UZDtVOI2mnY=;
 b=FjmnYR66oAOIER0UAX+TDlUrGQG7czYNnTi7sJ7VkW0Arlk/qgtogHnxYwo1p6BB78
 eZQW95gXRA/Z/Z+h0B8gQdl0p3FHVeM407bKt/c41ynEcK8YpX6HoyyFN6hX+OkSJEOf
 bEkWHhnS3ZT83MVYBDSgrBjgrNKYXcUHTp1w53GAVciUEBzv1lCUrp49XeMJCUbmbfH0
 g/aVMF/ERLCVzSUlDMy2kD09lExCFTAd2BSwJVXEUBVWHEjZLDb0yTZVwwxGF/V0vjI3
 3+oLpyxAY6Gcf6wvavIC3vlQRa6aP0IXbBDYhAwNeFKZx3SnjI1vbdNZWfLUUPbcsFkZ
 h5mQ==
X-Gm-Message-State: AOJu0YxYKRRQytb4Ly2nX23Vs/wJQZLtn1Za0tJ5jc1SRYrLXQO7cI2T
 iD+ErMCT5NrE7fUG5b1afLiBOmr5oaWPoRHIO5wwZp07hH2VGqVtHOD2tyYPWg==
X-Gm-Gg: ASbGncs+TZXo+nyqMnfNL9C8sAjYKDAvb3pAB8XYF9UEzVowXpp7QMEf8TPhrc+s9a7
 TEnz2f7ZG2lVxPw2C7EeDRQ+S84OwMPVagxYttn8goielQysdgDCA4R5VVGdwsOBbrxVmtL3glV
 bVsSpa4413vhRWaO7+Tk6p+lM6udR1n/fRiG5ZAKal6v3bQv2hHn0SFy2iVaZS4GlWmwVVTt1EI
 pZCZwS1iVmqRh2+eiuVcl0ld1rl78Br3AlD5hhn0nPU4Fll6CSMhfId/FIpEl1mW71p7JQ31KJf
 8aBppTAJ+/JWAsO4SgIIcR9uQnR0HiyYJ4clCyDE/cYm9ugsrfhdIf0JWj+uUSQfK6zL1STu82q
 dpZWMgbE4HclDM48rNrnJ0qMnnmVwHx8BwBmnDptllFbDjqVBjUAOUH3Kkg3nIfWKA7I=
X-Google-Smtp-Source: AGHT+IEStCeD9Fqq35qs334GkR5u7E1dIHdlDYmWkUYSzlfcmoe7d/XznBlKhOEq26k7IoPog92Dig==
X-Received: by 2002:a17:902:d48d:b0:232:557c:2501 with SMTP id
 d9443c01a7336-232557c2657mr15801685ad.10.1747627665200; 
 Sun, 18 May 2025 21:07:45 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sebastian Huber <sebastian.huber@embedded-brains.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/56] hw/riscv: Configurable MPFS CLINT timebase freq
Date: Mon, 19 May 2025 14:05:10 +1000
Message-ID: <20250519040555.3797167-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

This property enables the setting of the CLINT timebase frequency
through the command line, for example:

  -machine microchip-icicle-kit,clint-timebase-frequency=10000000

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250319061342.26435-6-sebastian.huber@embedded-brains.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  1 +
 hw/riscv/microchip_pfsoc.c         | 49 +++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index daef086da6..7ca9b976c1 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -67,6 +67,7 @@ typedef struct MicrochipIcicleKitState {
     MachineState parent_obj;
 
     /*< public >*/
+    uint32_t clint_timebase_freq;
     MicrochipPFSoCState soc;
 } MicrochipIcicleKitState;
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 6e5b17c05f..2e74783fce 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -39,6 +39,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
@@ -61,9 +62,6 @@
 #define BIOS_FILENAME   "hss.bin"
 #define RESET_VECTOR    0x20220000
 
-/* CLINT timebase frequency */
-#define CLINT_TIMEBASE_FREQ 1000000
-
 /* GEM version */
 #define GEM_REVISION    0x0107010c
 
@@ -193,6 +191,7 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
 static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
+    MicrochipIcicleKitState *iks = MICROCHIP_ICICLE_KIT_MACHINE(ms);
     MicrochipPFSoCState *s = MICROCHIP_PFSOC(dev);
     const MemMapEntry *memmap = microchip_pfsoc_memmap;
     MemoryRegion *system_memory = get_system_memory();
@@ -253,7 +252,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
-        CLINT_TIMEBASE_FREQ, false);
+        iks->clint_timebase_freq, false);
 
     /* L2 cache controller */
     create_unimplemented_device("microchip.pfsoc.l2cc",
@@ -671,6 +670,40 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     }
 }
 
+static void microchip_icicle_kit_set_clint_timebase_freq(Object *obj,
+                                                         Visitor *v,
+                                                         const char *name,
+                                                         void *opaque,
+                                                         Error **errp)
+{
+    MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    s->clint_timebase_freq = value;
+}
+
+static void microchip_icicle_kit_get_clint_timebase_freq(Object *obj,
+                                                         Visitor *v,
+                                                         const char *name,
+                                                         void *opaque,
+                                                         Error **errp)
+{
+    MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(obj);
+    uint32_t value = s->clint_timebase_freq;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void microchip_icicle_kit_machine_instance_init(Object *obj)
+{
+    MicrochipIcicleKitState *m = MICROCHIP_ICICLE_KIT_MACHINE(obj);
+    m->clint_timebase_freq = 1000000;
+}
+
 static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
                                                     const void *data)
 {
@@ -693,12 +726,20 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
      * See memory_tests() in mss_ddr.c in the HSS source code.
      */
     mc->default_ram_size = 1537 * MiB;
+
+    object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
+                              microchip_icicle_kit_get_clint_timebase_freq,
+                              microchip_icicle_kit_set_clint_timebase_freq,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "clint-timebase-frequency",
+                                  "Set CLINT timebase frequency in Hz.");
 }
 
 static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("microchip-icicle-kit"),
     .parent     = TYPE_MACHINE,
     .class_init = microchip_icicle_kit_machine_class_init,
+    .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
 };
 
-- 
2.49.0


