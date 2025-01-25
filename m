Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5895DC0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 12:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLE-0008Gj-Bf; Sat, 25 Jan 2025 07:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfKy-0008BM-DW; Sat, 25 Jan 2025 07:32:33 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfKv-0005TB-0m; Sat, 25 Jan 2025 07:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808349; x=1769344349;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aBNXUK51XTb5h+RZylc8ESD+bwtNxYy97oEksRtg0Sk=;
 b=PSkz1y/0l4t268RjkRQWi+puHKnG1HhDbGfseda3iQEt7Kfz1L3y1cIl
 ZmwSOct5s99X3t+K6xqC0sXYSfQvYjxQzPVPJ51Kw1Ejc3om0LJqJmCro
 +OPkQ/biTgudxpEGN5U2EbAfGbJYcESCgeC53+gNhhTLctOyWe+LS39Bi
 Hz47K3iyqGwpWTkmSNNwNXf/P/FA+umfdHl1reYftpfEIELC+ny+LKfWp
 ECY7NmDHN6RHI86PE2hhUu03uk9QZRb9aUS6AkDDydNIS3V3WNCc3Xiat
 fkuGWKuioU0txMMObLBvZdj+p8ycd43REHN9DpiHoYDuZ1ou6ct/d3WH6 A==;
X-CSE-ConnectionGUID: dOzJujxPQo+LvQsDTTByaQ==
X-CSE-MsgGUID: LH3ZoiiURKqokSwOfTDksA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434697"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434697"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:27 -0800
X-CSE-ConnectionGUID: it/u1kMrQG2UInClstZ4Fg==
X-CSE-MsgGUID: kzOQkwweR2SSqVl4klD0XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897640"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:24 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/10] i386/fw_cfg: move hpet_cfg definition to hpet.c
Date: Sat, 25 Jan 2025 20:51:28 +0800
Message-Id: <20250125125137.1223277-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125125137.1223277-1-zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

HPET device needs to access and update hpet_cfg variable, but now it is
defined in hw/i386/fw_cfg.c and Rust code can't access it.

Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
allows Rust HPET device implements its own global hpet_fw_cfg variable,
and will further reduce the use of unsafe C code access and calls in the
Rust HPET implementation.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/fw_cfg.c        |  4 +---
 hw/timer/hpet.c         | 14 ++++++++------
 include/hw/timer/hpet.h |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d2cb08715a21..546de63123e6 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -26,8 +26,6 @@
 #include CONFIG_DEVICES
 #include "target/i386/cpu.h"
 
-struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
-
 const char *fw_cfg_arch_key_name(uint16_t key)
 {
     static const struct {
@@ -153,7 +151,7 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
     PCMachineState *pcms =
         (PCMachineState *)object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE);
     if (pcms && pcms->hpet_enabled) {
-        fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_cfg));
     }
 #endif
 
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 92b6d509edda..f2e2d83a3f67 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -40,6 +40,8 @@
 #include "qom/object.h"
 #include "trace.h"
 
+struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
+
 #define HPET_MSI_SUPPORT        0
 
 OBJECT_DECLARE_SIMPLE_TYPE(HPETState, HPET)
@@ -655,8 +657,8 @@ static void hpet_reset(DeviceState *d)
     s->hpet_counter = 0ULL;
     s->hpet_offset = 0ULL;
     s->config = 0ULL;
-    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-    hpet_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
+    hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
+    hpet_fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
 
     /* to document that the RTC lowers its output on reset as well */
     s->rtc_irq_level = 0;
@@ -698,17 +700,17 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     if (!s->intcap) {
         warn_report("Hpet's intcap not initialized");
     }
-    if (hpet_cfg.count == UINT8_MAX) {
+    if (hpet_fw_cfg.count == UINT8_MAX) {
         /* first instance */
-        hpet_cfg.count = 0;
+        hpet_fw_cfg.count = 0;
     }
 
-    if (hpet_cfg.count == 8) {
+    if (hpet_fw_cfg.count == 8) {
         error_setg(errp, "Only 8 instances of HPET is allowed");
         return;
     }
 
-    s->hpet_id = hpet_cfg.count++;
+    s->hpet_id = hpet_fw_cfg.count++;
 
     for (i = 0; i < HPET_NUM_IRQ_ROUTES; i++) {
         sysbus_init_irq(sbd, &s->irqs[i]);
diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index 71e8c62453d1..c2656f7f0bef 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -73,7 +73,7 @@ struct hpet_fw_config
     struct hpet_fw_entry hpet[8];
 } QEMU_PACKED;
 
-extern struct hpet_fw_config hpet_cfg;
+extern struct hpet_fw_config hpet_fw_cfg;
 
 #define TYPE_HPET "hpet"
 
-- 
2.34.1


