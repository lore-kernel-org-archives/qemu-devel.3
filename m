Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0895BFB5EA5
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 03:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2LBn-00086v-Dn; Mon, 16 Mar 2026 23:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w2LBm-00086k-Ec
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:33:50 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1w2LBk-00007i-U0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 23:33:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773718401; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zm585goNiM3q2NRxgDvcf7lC1ffckJ+WFx5EUQEWoLuSZCfcz23IIblfhKoVpKP0K5B7rZ330mji4ImeWsyyA4j8/RIavgPs944kO2vUXoERbFlGQNQeFSwNisKeJ4veh9MOkaYsqIFCvzy/0tkS9IVqAGbDuF3GwYiT3QPLHNc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773718401;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SwiEQxy/4R6oEC1oP3Ow8K/BuKXA53v/od/0nO7d7T0=; 
 b=mym98EtGdNpKBNXxLjvyu7R+rn601qHcbv1S8bW79Kyde6O0undkjN8hrfJV4JCRN0r7QkXPYzSs1YyOSUiJGjRJHio/N2CtBNXb9oQWb2TKh8zY6iG8o8nsprg96RVSKADJWZmaTzQqQEIG4F0ptuI59wwGGCotk9P1tmIa7tk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773718401; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=SwiEQxy/4R6oEC1oP3Ow8K/BuKXA53v/od/0nO7d7T0=;
 b=GTHmobBfVKuFXq6X9fQ+EHUg9848q5UQWx6b9/2m7yFKZL8zsv74HRNBE4S7uchD
 oJ+KczESNBaS5dk+F90katY/Q1z6RbqVCuw6TVLah/l7GFZMGWYOoD9QeZxCyRaROCd
 U14uj7F1GJTYzK0QG82e7mROe2OqVpBxdi/SGSCE=
Received: by mx.zohomail.com with SMTPS id 177371839921717.129091074356552;
 Mon, 16 Mar 2026 20:33:19 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: qemu-devel@nongnu.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH 1/3] cxl/type3: expose vmem mapping for fixed windows
Date: Tue, 17 Mar 2026 11:33:01 +0800
Message-ID: <20260317033304.3185291-2-me@linux.beauty>
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

CXL fixed memory windows may map linearly to a Type-3 volatile memdev.
Add a helper that checks whether a host physical range is backed by the
volatile memory backend and returns the backing MemoryRegion and offset.

This is used by KVM to alias fixed windows to RAM when possible.

Signed-off-by: Li Chen <me@linux.beauty>
---
 hw/mem/cxl_type3.c          | 52 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  3 +++
 2 files changed, 55 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..bf79db6082 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1314,6 +1314,58 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+bool cxl_type3_get_window_vmem_mapping(CXLType3Dev *ct3d, hwaddr host_base,
+                                       hwaddr size, MemoryRegion **mr,
+                                       hwaddr *offset, Error **errp)
+{
+    MemoryRegion *vmr;
+    uint64_t dpa_start, dpa_end;
+    uint64_t vmr_size;
+    hwaddr host_end;
+
+    if (!size) {
+        error_setg(errp, "window size must be non-zero");
+        return false;
+    }
+
+    host_end = host_base + size - 1;
+    if (host_end < host_base) {
+        error_setg(errp, "window range overflows");
+        return false;
+    }
+
+    if (!ct3d->hostvmem) {
+        error_setg(errp, "no volatile-memdev configured");
+        return false;
+    }
+    vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    if (!vmr) {
+        error_setg(errp, "volatile-memdev has no backing memory region");
+        return false;
+    }
+
+    if (!cxl_type3_dpa(ct3d, host_base, &dpa_start) ||
+        !cxl_type3_dpa(ct3d, host_end, &dpa_end)) {
+        error_setg(errp, "failed to translate HPA to DPA");
+        return false;
+    }
+
+    if (dpa_end != dpa_start + size - 1) {
+        error_setg(errp, "window is not linearly mapped to DPA");
+        return false;
+    }
+
+    vmr_size = memory_region_size(vmr);
+    if (dpa_start >= vmr_size || size > vmr_size - dpa_start) {
+        error_setg(errp, "window maps outside volatile-memdev");
+        return false;
+    }
+
+    *mr = vmr;
+    *offset = dpa_start;
+    return true;
+}
+
 static void ct3d_reset(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 393f312217..5e3da17c10 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -827,6 +827,9 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs);
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
+bool cxl_type3_get_window_vmem_mapping(CXLType3Dev *ct3d, hwaddr host_base,
+                                       hwaddr size, MemoryRegion **mr,
+                                       hwaddr *offset, Error **errp);
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
-- 
2.52.0


