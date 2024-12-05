Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE38E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4kC-0006Ht-CP; Thu, 05 Dec 2024 00:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4kA-0006HU-VT; Thu, 05 Dec 2024 00:49:42 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4k9-0007B4-4K; Thu, 05 Dec 2024 00:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377781; x=1764913781;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MqPtIjiKuUsW3EQ/VPF+u6Z8ovdVcse78lSqSTpfpsA=;
 b=lpdQeVwRTT9s17r2ZVgoEfzovix1mtTrlXXF5rdwpAM/bG9EJUH3U417
 GiExcQZIOTmTwgxnzH8NDXsRAZirszzAfN8RxWEbP4ilmam+kLkzMASy0
 ml5KvYmHX9NVv0gypD83DcKsTU7Oq8M5DX3k0TS48gabtUgiy/F3XGFlz
 RZ54qTQiYn8zNdvOyIAAfBXxeDJsPLVu5QC2itH41RP6oRSwCBHbzOLnG
 IYb1SbBQuIJq+FlQLcMD+ih/QGgF9XjGHlwcDUaPHv887lKV2cjXr6lr4
 EDI4y1UHiEEad7SJjKSGFVCutuxzdViWj7dmVNskXJym8bQaBe7KOgXkt Q==;
X-CSE-ConnectionGUID: 5jtPkJzwTSK71luZiyaWSg==
X-CSE-MsgGUID: MOWHeT8AR1y2h9EzC5r1HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815669"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815669"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:40 -0800
X-CSE-ConnectionGUID: a5XZ/26IR3yt+nQKjD4Zng==
X-CSE-MsgGUID: Bp3GlixeSHuiq6x1DnhnHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94455046"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:37 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
Date: Thu,  5 Dec 2024 14:07:10 +0800
Message-Id: <20241205060714.256270-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 hw/timer/hpet.c         | 16 +++++++++-------
 include/hw/timer/hpet.h |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 0e4494627c21..965e6306838a 100644
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
@@ -149,7 +147,7 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
 #endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_cfg));
     /* allocate memory for the NUMA channel: one (64bit) word for the number
      * of nodes, one word for each VCPU->node and one word for each node to
      * hold the amount of memory.
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 5399f1b2a3f7..d8bd51b7e202 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -40,6 +40,8 @@
 #include "qom/object.h"
 #include "trace.h"
 
+struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
+
 #define HPET_MSI_SUPPORT        0
 
 OBJECT_DECLARE_SIMPLE_TYPE(HPETState, HPET)
@@ -278,7 +280,7 @@ static int hpet_post_load(void *opaque, int version_id)
     /* Push number of timers into capability returned via HPET_ID */
     s->capability &= ~HPET_ID_NUM_TIM_MASK;
     s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
-    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
+    hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
 
     /* Derive HPET_MSI_SUPPORT from the capability of the first timer. */
     s->flags &= ~(1 << HPET_MSI_SUPPORT);
@@ -665,8 +667,8 @@ static void hpet_reset(DeviceState *d)
     s->hpet_counter = 0ULL;
     s->hpet_offset = 0ULL;
     s->config = 0ULL;
-    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-    hpet_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
+    hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
+    hpet_fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
 
     /* to document that the RTC lowers its output on reset as well */
     s->rtc_irq_level = 0;
@@ -708,17 +710,17 @@ static void hpet_realize(DeviceState *dev, Error **errp)
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
index d17a8d43199e..dbf709251a8f 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -74,7 +74,7 @@ struct hpet_fw_config
     struct hpet_fw_entry hpet[8];
 } QEMU_PACKED;
 
-extern struct hpet_fw_config hpet_cfg;
+extern struct hpet_fw_config hpet_fw_cfg;
 
 #define TYPE_HPET "hpet"
 
-- 
2.34.1


