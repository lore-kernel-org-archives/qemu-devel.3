Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503C7C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp5aD-0004LF-R6; Wed, 29 Jul 2026 10:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wp5Ze-0004GV-Tr; Wed, 29 Jul 2026 10:48:02 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wp5Zb-0000PQ-77; Wed, 29 Jul 2026 10:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785336475; x=1816872475;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+XEqTvJkhJL8Zjzo3UW1sPiWBb9hzsCcLzLQ1Vw9yso=;
 b=Sf5X/aOsR1N+djP5G63np0XML8QQoY2+mA+zJTdPvBhjwElEnp8jiyzo
 AP3mX4R0hIdQ6vzPlFnWT//1NS7JAvlgJbqk+lZqIs5OPsHSMRQDDc3kC
 dgBetPEcN/AHOu79FrM5mkxT2CB4j+MwPDT3lroBN3j+3dqHAebuvKuIQ
 jqxkLZtGPL749Sx0K08aiVrMLZwfiZGrHDyAxthBAhShcJF8alTh1hyAv
 k83Y74DbX5fQBn7Lh6S8UJNc6XveLHy2fvwOFiCAlRgUvPxdJZlAktojP
 JDpQ/HfNofN9D94GSPjt5fZoVUMfCe85zyoMbJepEZ95hCqYlIEe5TjMN w==;
X-CSE-ConnectionGUID: E3x9Us+sSCaIb+ktoHLuvg==
X-CSE-MsgGUID: BxT5VkXER7e+vTKnJfI/nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133627"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="86133627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:47:51 -0700
X-CSE-ConnectionGUID: lNn4tTa/RfuIF7wDg75jtQ==
X-CSE-MsgGUID: AEbLXD/WRHa2Js+/w/uCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="258788810"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:47:50 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, philmd@oss.qualcomm.com,
 qemu-stable@nongnu.org
Subject: [PATCH v3 4/7] hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox
 teardown counterpart
Date: Wed, 29 Jul 2026 22:46:42 +0800
Message-ID: <20260729144645.1552511-5-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
References: <20260729144645.1552511-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The primary CCI teardown is open-coded, guarded by .initialized, at
the two places that need it: the reset path (before
cxl_device_register_init_t3() brings the mailbox back up) and
ct3_exit().

Factor it into cxl_destroy_mailbox_t3(), the teardown counterpart of
cxl_initialize_mailbox_t3(), keeping the .initialized guard inside the
helper: the primary CCI is only brought up from the reset path, so the
first reset after realize and an unrealize before any reset must both
skip the teardown.

No functional change.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 7 +++++++
 hw/mem/cxl_type3.c          | 8 ++------
 include/hw/cxl/cxl_device.h | 1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 603677a97b..bc00fec9f8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4843,6 +4843,13 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cxl_init_cci(cci, payload_max);
 }
 
+void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d)
+{
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ce2cb6558c..3a5eea76f2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1076,9 +1076,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    if (ct3d->cci.initialized) {
-        cxl_destroy_cci(&ct3d->cci);
-    }
+    cxl_destroy_mailbox_t3(ct3d);
     if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
         cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
     }
@@ -1344,9 +1342,7 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
-    if (ct3d->cci.initialized) {
-        cxl_destroy_cci(&ct3d->cci);
-    }
+    cxl_destroy_mailbox_t3(ct3d);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b7e20e3fe4..608d05165a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -325,6 +325,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
-- 
2.43.0


