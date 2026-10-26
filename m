Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3639606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=TWwughNa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJbP-0002Ri-N5; Mon, 26 Oct 2026 08:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPI-0002nC-NZ; Mon, 26 Oct 2026 05:54:22 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPG-00081b-9A; Mon, 26 Oct 2026 05:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793008458; x=1824544458;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6z8lEk1AeWECdTspXda6U7FgVtrO8TNGfV5ZPDt7sUE=;
 b=TWwughNa3fiPeP0I6RdeF01SUvzfY7TPkThFpmvWHBgZe1JKku8h2JLT
 9M4Z8NkESVr+TpjFgtDv08J2Xl3ikAUJEx41jvfVq/lwMQffhaXUM3WOW
 CtVD1AJw6BXzO3FjtwDO6bjoj7SppgnjnTO78ulMRl6nHCwpUjkM7vPlR
 tfH30ZnX6JUH44ENp8yh6I35Y0yVYoiu/Sx0sSbfDQZAcib6ztu74jO11
 r4WIa4+xIMUpF+pA0BvTBtdktBvhHBtQoY07fs7xZKQhbxedtisA8VqAL
 jPRabqCTXkpaSCS1L1eXrddrykncTWOJhkr87lEzC68aweMdxRE8mql7g A==;
X-CSE-ConnectionGUID: FVXmPABPR8mvVJCrm3pRWA==
X-CSE-MsgGUID: aT+7mxdtSIuv2Bzyh8W67g==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="237204752"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; d="scan'208";a="237204752"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 18:54:16 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 42C77C020DB;
 Mon, 26 Oct 2026 09:54:16 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
 by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTP id AF66E18002D1;
 Mon, 26 Oct 2026 09:54:15 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
 by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 61058202EBDE;
 Mon, 26 Oct 2026 18:54:14 +0900 (JST)
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anisa Su <anisa.su@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>, lizhijian@fujitsu.com,
 y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: [PATCH RFC 5/7] QEMU/hw/cxl: expose CXL Type 3 ranges as
 E820_SOFT_RESERVED on x86
Date: Mon, 26 Oct 2026 19:03:26 +0900
Message-ID: <06c1447e554c2b353c029d0e0c0ef6dd38c46e41.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.37.100; envelope-from=fj2110jc@fujitsu.com;
 helo=esa12.hc1455-7.c3s2.iphmx.com
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On real systems, CXL Type 3 memory is exposed to the OS via the E820
table as E820_SOFT_RESERVED, so the kernel can treat it as a dedicated
reserved range rather than normal RAM.

This patch adds a small helper and a recursive walker so that, on x86,
the HPA ranges assigned to CXL Type 3 devices are added to the E820 table
as E820_SOFT_RESERVED when `program_hdm_decoder` is enabled. An ARM stub
is also added as a placeholder for future support.

Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/arm/cxl.c              | 10 ++++++++++
 hw/arm/meson.build        |  2 ++
 hw/cxl/cxl-host.c         | 25 +++++++++++++++++++++++++
 hw/i386/cxl.c             | 11 +++++++++++
 hw/i386/meson.build       |  1 +
 hw/i386/pc.c              |  1 +
 include/hw/cxl/cxl_host.h |  2 ++
 7 files changed, 52 insertions(+)
 create mode 100644 hw/arm/cxl.c
 create mode 100644 hw/i386/cxl.c

diff --git a/hw/arm/cxl.c b/hw/arm/cxl.c
new file mode 100644
index 0000000000..1cbcf2d8e5
--- /dev/null
+++ b/hw/arm/cxl.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "hw/cxl/cxl_host.h"
+
+void cxl_c3_add_memory_map(hwaddr base, hwaddr size)
+{
+    /* TODO: Implement memory map addition for CXL Type 3 on ARM */
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068de04..2a4f09fbef 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -116,6 +116,8 @@ arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
   'ax3000-boards.c',
   'ax3000-evk.c'))
 
+arm_common_ss.add(when: 'CONFIG_CXL', if_true: files('cxl.c'))
+
 arm_common_ss.add(files('boot.c'))
 
 hw_common_arch += {'arm': arm_common_ss}
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e279ce5fe3..1967c9a9c3 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -689,12 +689,37 @@ static int cxl_fmws_mmio_map(Object *obj, void *opaque)
     return 0;
 }
 
+static int cxl_c3_mmio_map(Object *obj, void *opaque)
+{
+    uint64_t base, size;
+    CXLType3Dev *c3d;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+    c3d = CXL_TYPE3(obj);
+
+    if (!c3d->program_hdm_decoder) {
+        return 0;
+    }
+
+    ct3_type3_get_hpm_range(c3d, &base, &size);
+    cxl_c3_add_memory_map(base, size);
+
+    return 0;
+}
+
 void cxl_fmws_update_mmio(void)
 {
     /* Ordering is not required for this */
     object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
 }
 
+void cxl_c3_update_mmio(void)
+{
+    object_child_foreach_recursive(object_get_root(), cxl_c3_mmio_map, NULL);
+}
+
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 {
     GSList *cfmws_list, *iter;
diff --git a/hw/i386/cxl.c b/hw/i386/cxl.c
new file mode 100644
index 0000000000..02dbe4d3f0
--- /dev/null
+++ b/hw/i386/cxl.c
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "hw/cxl/cxl_host.h"
+#include "hw/i386/e820_memory_layout.h"
+
+void cxl_c3_add_memory_map(hwaddr base, hwaddr size)
+{
+    e820_add_entry(base, size, E820_SOFT_RESERVED);
+}
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index e16930c431..b212b3f6fa 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+i386_ss.add(when: 'CONFIG_CXL', if_true: files('cxl.c'))
 if have_hmp
   stub_ss.add(files('sgx-hmp-stub.c'))
 endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2d8c87b0e3..f843629543 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -534,6 +534,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     if (pcms->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
+        cxl_c3_update_mmio();
     }
 
     /* set the number of CPUs */
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 21619bb748..6c142a5b89 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -18,6 +18,8 @@ void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
 void cxl_fmws_update_mmio(void);
+void cxl_c3_update_mmio(void);
+void cxl_c3_add_memory_map(hwaddr base, hwaddr size);
 GSList *cxl_fmws_get_all_sorted(void);
 
 extern const MemoryRegionOps cfmws_ops;
-- 
2.52.0


