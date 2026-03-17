Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2161FB5EA8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 03:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2LCE-000899-8S; Mon, 16 Mar 2026 23:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w2LC7-00088r-T2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:34:12 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w2LC6-00009j-08
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773718405; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bNapGL/YhDuS995plhoU9uVwyRjFcwkCQft1FJBycwL+JfFi0GviQ1qWihFQFskPW2d2YHcY6VQv7VUupFNmDChzZC4Zei+mpJemembYbsgkCxmfk2aZmVY90Qgq7Abk1uEmY9I5HTJ1DxIiWTVpGDFNqRMs3lJcczirWPlwlCo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773718405;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=o/k9W/3pb0zb4BQ0MZjpr4wFcJrIko/dda2WW35D1BM=; 
 b=nWNobgfLR5obXcpRk6XdBrt+dZ+YWtkgtNKrBmKA8NBRMchkjREYrj/zoW6TYkXI1pUNDFsskLSSJWduzEzyvw+EtOvJ/pudUByz4scAy8gOihonzkLFx7lHF/j6qG90E2dFR0SAGxPd0s/B41dBPuOwuibKVywvy2j7oS4M9Oo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773718405; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=o/k9W/3pb0zb4BQ0MZjpr4wFcJrIko/dda2WW35D1BM=;
 b=B0HHyLS5yJA7J5vBY5BZx7TUOGyoZO9L2lW4mITZKPLYFdaB114qqKB9rI1RXAwR
 bMEwzPX7J8zbO76m6Vy8qho3sMxWA4ibfG1TN7ZhNoei3/A9RN1mOMp2BieROpnPxxR
 fz/HKDfz+wBF5QAVa0WLRqnAlMuHsznfkRLNcB3A=
Received: by mx.zohomail.com with SMTPS id 1773718402910821.7813823448923;
 Mon, 16 Mar 2026 20:33:22 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: qemu-devel@nongnu.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH 3/3] cxl: update fixed window mappings on decoder programming
Date: Tue, 17 Mar 2026 11:33:03 +0800
Message-ID: <20260317033304.3185291-4-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317033304.3185291-1-me@linux.beauty>
References: <20260317033304.3185291-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Invoke cxl_fmws_update_mappings() when HDM decoder registers are updated
on host components and Type-3 devices, so fixed memory windows can
switch between the MMIO dispatcher and the RAM alias overlay as the guest
commits/uncommits decoder state.

Signed-off-by: Li Chen <me@linux.beauty>
---
 hw/cxl/cxl-component-utils.c | 2 ++
 hw/mem/cxl_type3.c           | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 07aabe331c..8a36a62db0 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 
 /* CXL r3.1 Section 8.2.4.20.1 CXL HDM Decoder Capability Register */
 int cxl_decoder_count_enc(int count)
@@ -209,6 +210,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
         if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
             offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
             dumb_hdm_handler(cxl_cstate, offset, value);
+            cxl_fmws_update_mappings();
         } else if (offset == A_CXL_BI_RT_CTRL ||
                    offset == A_CXL_BI_DECODER_CTRL) {
             bi_handler(cxl_cstate, offset, value);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index bf79db6082..8ad36e6f53 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -29,6 +29,7 @@
 #include "system/hostmem.h"
 #include "system/numa.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/pci/msix.h"
 
 /* type3 device private */
@@ -628,6 +629,11 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     } else if (should_uncommit) {
         hdm_decoder_uncommit(ct3d, which_hdm);
     }
+
+    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
+        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
+        cxl_fmws_update_mappings();
+    }
 }
 
 /*
@@ -1377,6 +1383,7 @@ static void ct3d_reset(DeviceState *dev)
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
+    cxl_fmws_update_mappings();
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
-- 
2.52.0


