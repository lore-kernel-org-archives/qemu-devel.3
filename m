Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE39606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=esb9FSl2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJbP-0002Sn-TE; Mon, 26 Oct 2026 08:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPB-0002lz-T2
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:15 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPA-00080m-3m
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793008458; x=1824544458;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zq89hgzs7m9+iM8Br2P62CYeN5DC4Ml4L5UACTlprZ4=;
 b=esb9FSl2FiVBv9bi9BtJdSdmifZlGy3LOeScy4G7U4p+6ykME18nhyHI
 wyyBbzr+FGUU1zT0CRMz23Mei/DDqXqQWCPA36Uk6HmmxOTJ+Cn0hpXhp
 XQU7Jd1lv7O98hDcIIWBMbjzFzPy1mB+J8maSJlK17MgbMoV235/UgFTO
 9+4Iix0+kZ6j4WGZHxwWpwwqxmibjVHtHDTXGiBa/NkHIHul3CtHR8RAs
 JhaUMOS8oOns4184X4/cJi+ZY/TtUdfAaPmjFhBXw3U1lXPViHPXRyDx9
 221SCyCynZNQ6mevepMrZ3JA7gBVdsRpfoss/72D4uYsLrqX0sqOy8Rhf A==;
X-CSE-ConnectionGUID: 9S1GTztWQOCIcYFBFYZ8pQ==
X-CSE-MsgGUID: QS+0TY4dQiWlZLwG43rcoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="259472557"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; d="scan'208";a="259472557"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 18:54:16 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id B14111C1C700
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:09 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
 by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTP id 2744814003A9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:09 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
 by m3003.s.css.fujitsu.com (Postfix) with ESMTP id E8F7A202EBDE;
 Mon, 26 Oct 2026 18:54:07 +0900 (JST)
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>, Anisa Su <anisa.su@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
 linux-cxl@vger.kernel.org, "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
 lizhijian@fujitsu.com, y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: [PATCH RFC 2/7] QEMU/hw/cxl:add HPA offset tracking for CXL Type 3
 devices
Date: Mon, 26 Oct 2026 19:03:23 +0900
Message-ID: <6172d168ed84f0b968661e7bf41dad01526d9d0a.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.48; envelope-from=fj2110jc@fujitsu.com;
 helo=esa2.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:14:57 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yukiya Takaki <fj2110jc@fujitsu.com>
From:  Yukiya Takaki via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

E820, SRAT and HDM decoder programming in this series all need per‑device
host physical address (HPA) information for CXL Type 3 memory. Today,
CXLType3Dev does not expose this in a convenient way.

This patch adds minimal state to CXLHost and CXLType3Dev, plus a helper
to walk from a Type 3 device back to its host, so that each CXL Type 3
device can be assigned a stable HPA offset within the CFMW window and an
index that later code can rely on when building firmware tables and
regions.

Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/mem/cxl_type3.c          | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl.h        |  2 ++
 include/hw/cxl/cxl_device.h |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b65ddd264d..d08a4255c9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -732,9 +732,39 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
     }
 }
 
+
+static CXLHost *ct3d_to_cxl_pxb(DeviceState *dev)
+{
+    BusState *bus = dev->parent_bus;
+
+    DeviceState *cxl_rp_dev = NULL;
+    if (bus && bus->parent) {
+        cxl_rp_dev = bus->parent;
+    }
+    assert(cxl_rp_dev);
+
+    DeviceState *cxl_host_dev = NULL;
+    if (cxl_rp_dev) {
+        BusState *rp_bus = cxl_rp_dev->parent_bus;
+        if (rp_bus && rp_bus->parent) {
+            cxl_host_dev = rp_bus->parent;
+        }
+    }
+    assert(cxl_host_dev);
+
+    if (cxl_host_dev &&
+        object_dynamic_cast(OBJECT(cxl_host_dev), TYPE_PXB_CXL_HOST)) {
+        CXLHost *host = PXB_CXL_HOST(cxl_host_dev);
+        return host;
+    }
+
+    return NULL;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
+    CXLHost *host = ct3d_to_cxl_pxb(ds);
 
     if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
         && !ct3d->dc.num_regions) {
@@ -816,6 +846,13 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (ct3d->program_hdm_decoder) {
+        ct3d->hpa_offset = host->unused_hpa_offset;
+        ct3d->idx = host->unused_dev_num;
+        host->unused_hpa_offset += ct3d->cxl_dstate.static_mem_size;
+        host->unused_dev_num++;
+    }
+
     ct3d->dc.total_capacity = 0;
     if (ct3d->dc.num_regions > 0) {
         MemoryRegion *dc_mr;
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 7cf3dc622c..b8b3071f81 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -67,6 +67,8 @@ struct CXLHost {
 
     CXLComponentState cxl_cstate;
     bool passthrough;
+    hwaddr unused_hpa_offset;
+    int unused_dev_num;
 };
 
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a2c830d181..c3a729f8c5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -778,6 +778,8 @@ struct CXLType3Dev {
     bool hdmdb;
 
     bool program_hdm_decoder;
+    hwaddr hpa_offset;
+    int idx;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
-- 
2.52.0


