Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C190EC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJjs-000078-1E; Sun, 09 Feb 2025 21:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjo-00005F-NV; Sun, 09 Feb 2025 21:41:32 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjm-00087f-KO; Sun, 09 Feb 2025 21:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155291; x=1770691291;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aBNXUK51XTb5h+RZylc8ESD+bwtNxYy97oEksRtg0Sk=;
 b=R8i9+Y4p0nuSlUy+loa8f6AaovizCg4IRmzTtrPMo9hHLEUFAKfft4YC
 g9O029ZDHSWJgkbVw63zHdY6/NHVoDAuUjFGJJ6NTZvBiZbGRQZ1Wo2Sz
 CBTZJ3CXrRKqXMjdo98iwoKAFONWG8XgG7zJ2BIL3Jun8HV+PogbLs20r
 M/PQJayYBZEsvmOaOjVbW1ksvcFCdPUPQ12gqRypIMOlXn118z0IGvUsU
 5MPh8EnU03tvpXigpUTeuWvxRd1mPTaHW1ZVTP8Mnt+Wbkf4PlqXB9iBZ
 WHwt8hyjmvBCJn2dMdBaGeT43SIlWftNyvo/rOXwXdybepHzfxRDTG0No g==;
X-CSE-ConnectionGUID: 79f50HH7Tqe9jUFgOR6rHg==
X-CSE-MsgGUID: q2NYFwAsSNOnx1FVnxLecQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351234"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351234"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:27 -0800
X-CSE-ConnectionGUID: aAHcT5VOTl2pOXAz+VEFvQ==
X-CSE-MsgGUID: OvR4yrbuRnetMqSyXJmVYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938200"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:24 -0800
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
Subject: [PATCH v2 01/10] i386/fw_cfg: move hpet_cfg definition to hpet.c
Date: Mon, 10 Feb 2025 11:00:42 +0800
Message-Id: <20250210030051.2562726-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210030051.2562726-1-zhao1.liu@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


