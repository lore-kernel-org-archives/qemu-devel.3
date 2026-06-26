Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E970CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 06:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0U0-0008Q1-TV; Fri, 26 Jun 2026 02:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wd0Tz-0008Pa-CZ; Fri, 26 Jun 2026 02:56:11 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wd0Tx-0007vz-OG; Fri, 26 Jun 2026 02:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782456970; x=1813992970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hBO3fzaslaoxTxxwV/97htR4gR1dlBLu3SsAm+it1ik=;
 b=Z6jL3ATKF6X17SZkCDg5vH6mnVTgr2KNU/P66uBzpTbvsi2zEK7gKjSs
 r9AvE5cpVStUYML145zdHaccQgJEbT2UBa0cl64vvoZ4UeMMkSCxsx68K
 5Gl669V11XjKpTsHSmLiYc02ZVrODcbXn9bJuDdE1YqFYi8YZjiUJbaJl
 6FAA1Zm0vSiFGcNhmnOtwwFSknG9U6IRvTNDVWmJKq7qx1EaARXfNL7rK
 9Yy8wQ8hu3CpoloDaLp7cdudR9tkdqUqufznWO4+AoJWq1emVt4oWf8Tp
 XSfzNKO9Rw/ttC7N3uDA22JKLoyKJnRJGH8RjXjDuv8JG4CaOLz37pz7E A==;
X-CSE-ConnectionGUID: b7lQVdCkRLGNAn4LboZXCQ==
X-CSE-MsgGUID: d05GiOcLTtCiNlvHvjDWMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802336"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="85802336"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 23:56:08 -0700
X-CSE-ConnectionGUID: Z8FIXWuASSaPzL369Bc1Ug==
X-CSE-MsgGUID: DI6gJO+qSrKvunDrRJuEHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="244865876"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 23:56:06 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com, qemu-stable@nongnu.org
Subject: [PATCH 2/6] hw/cxl: destroy primary CCI before re-initialization on
 reset
Date: Fri, 26 Jun 2026 14:21:45 +0800
Message-ID: <20260626062149.1844334-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626062149.1844334-1-junjie.cao@intel.com>
References: <20260626062149.1844334-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

ct3d_reset() re-initializes the primary CCI through the call chain
cxl_device_register_init_t3() -> cxl_initialize_mailbox_t3() ->
cxl_init_cci(), but never calls cxl_destroy_cci() first.  Each reset
cycle therefore leaks the old timer and leaves the old mutex
undestroyed while silently overwriting the CCI state.

Per CXL r4.0, the "Mailbox Interfaces Ready" bit in the Memory Device
Status register (Table 8-212) is set after a Conventional Reset or CXL
Reset once the device has re-initialized its mailbox interfaces.  The
CCI is the software abstraction of these interfaces and must be properly
torn down before re-initialization.

The secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) already follow
the correct destroy-before-reinit pattern in the same function; apply
the same discipline to the primary CCI.

Also destroy the secondary CCIs in ct3_exit() where they were
previously leaked at device removal time.  Guard the primary CCI
teardown there with the same .initialized check used for the secondary
CCIs: the primary CCI is only brought up from the reset path
(cxl_device_register_init_t3()), so a device that is unrealized before
its first reset would otherwise tear down a never-initialized CCI.

Fixes: cac36a8faffc ("hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cba05ec57d..4ac6eaa950 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1073,7 +1073,15 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    cxl_destroy_cci(&ct3d->cci);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+    if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
+        cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    }
+    if (ct3d->ld0_cci.initialized) {
+        cxl_destroy_cci(&ct3d->ld0_cci);
+    }
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1328,6 +1336,9 @@ static void ct3d_reset(DeviceState *dev)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
-- 
2.43.0


