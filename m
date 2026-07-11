Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939BFC44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifqM-0002Ft-Ab; Sat, 11 Jul 2026 18:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifqL-00028r-2Z; Sat, 11 Jul 2026 18:06:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifqI-0000mh-Uj; Sat, 11 Jul 2026 18:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=3Q6ZXG+BDAb7zFboOJ/J/8u/UJ71/GcqvySrUBpfbA8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cwxFX+AoL6vtcQVeqjHUomm+ZkYPakS5uJximYe3nfVn9kbc5VkcSJ+YsCMktSBh3
 R/fLT2IRhINyPv4dKySyL3/6p2+cZ9l90mQGUXqc76DU9kYGVjdHuCCIygHuZAkLkX
 69WUr0ag9EVSg49DUb40wf7oe4hW7ojmSDl8OKO4fUkBFfg28Ujl2lG79p22VBkMz8
 Yz4uX6irWQtNdVJyIzxfyvO/+RpZHbP831a1wIPZxtWRid+bfRC7UwjXZu15Eze0nK
 W5dPXh7UFc6wwIgZFUXFcXhXZxehZJA/5JMhpER3dimxN7n9R3rH4PLoFQ/j3l2xZH
 MgqPdJHHVfIOg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C339D1C0AD3;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A7363EAF5E;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E63DE13373; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 72/81] hw/riscv/riscv-iommu-sys.c: record fault on
 IOMMU-generated MSI write
Date: Sun, 12 Jul 2026 00:58:50 +0300
Message-ID: <20260711215904.3757-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The riscv-iommu spec requires that the IOMMU records its own generated
MSI write faults.

Fixes: 01c1caa9d1 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3572
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260629165954.1018123-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 58e801f74e6a4ebd3a0cf3ab1a96e1676b263efd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index bf87b0b4ea3..3314adeed23 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -26,6 +26,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "target/riscv/cpu_bits.h"
 #include "trace.h"
 
 #include "riscv-iommu.h"
@@ -143,7 +144,20 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
 
     address_space_stl_le(&address_space_memory, msi_addr,
                          msi_data, MEMTXATTRS_UNSPECIFIED, &result);
-    trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
+
+    if (result == MEMTX_OK) {
+        trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
+    } else {
+        /* Record an access fault error in the fault queue */
+        struct riscv_iommu_fq_record ev = { 0 };
+        RISCVIOMMUState *iommu = &s->iommu;
+
+        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE,
+                           RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT);
+        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE,
+                           RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
+        riscv_iommu_fault(iommu, &ev);
+    }
 }
 
 static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 4330b2257d4..3f0392c2528 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -108,8 +108,7 @@ void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
     }
 }
 
-static void riscv_iommu_fault(RISCVIOMMUState *s,
-                              struct riscv_iommu_fq_record *ev)
+void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev)
 {
     uint32_t ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
     uint32_t head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s->fq_mask;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2a9f6fccd52..7a1523e9fd8 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -99,6 +99,7 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
 void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
 void riscv_iommu_reset(RISCVIOMMUState *s);
 void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
+void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev);
 
 typedef struct RISCVIOMMUContext RISCVIOMMUContext;
 /* Device translation context state. */
-- 
2.47.3


