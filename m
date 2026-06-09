Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9162CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX3PK-0008OU-8r; Tue, 09 Jun 2026 16:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PE-0008My-Vq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PC-0000Mb-GG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:40 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659KBYVJ1797633; Tue, 9 Jun 2026 20:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=TtJDt
 DM9JF5rDPn3kg/DyYE1vdrXTXAVcNyMNUUXEZo=; b=k0l9ow6ObNfZEwHOV/8O8
 hSN0nd+m9jpHBZzmt7eBieKSV1RB3Lt9czvuOacg3BQcYq0sflNf9y6tEQzDD9Vn
 gY9uANj74cA6nu2R5+v0Y9SuSJh4kYpCo+OvvMoP9kfs+HkxtSmjMeBDpbuCDytg
 U0xoLWKwLuiUdMvHZbVMZovXr9ay2JcXu20k4tef/5Qva966GmAzXGP0kuIXiZ7B
 8jQxuJxAp6gjgB+rPvUtx4yzWWWVw0xIDOcQdT6D2mfoSwXiBPYE7IpflnTszHMV
 AM7tqS6kRPdsiqe0HCA3gUv19CtFTgabj7l/hq5aCbO/RninjJU+awGDImaOIncz
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emc3rn946-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 659KmW52023145; Tue, 9 Jun 2026 20:50:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ema0qn7nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:33 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 659KoTpP030607;
 Tue, 9 Jun 2026 20:50:33 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ema0qn7ju-5; Tue, 09 Jun 2026 20:50:33 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com
Subject: [PATCH 4/4] amd_iommu: Use INTCAPXT for IOMMU event interrupts
Date: Tue,  9 Jun 2026 13:43:35 -0700
Message-ID: <20260609204403.323149-5-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260609204403.323149-1-dongli.zhang@oracle.com>
References: <20260609204403.323149-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606090195
X-Proofpoint-ORIG-GUID: nX24M4v06p1JMNt1JA-Awl8YjxFzba6u
X-Authority-Analysis: v=2.4 cv=crirVV4i c=1 sm=1 tr=0 ts=6a287c9a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=y0zx0RgqgJ0mTu1Bm_QA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-GUID: nX24M4v06p1JMNt1JA-Awl8YjxFzba6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE5NSBTYWx0ZWRfX/eYJ7khK8Udk
 15qjt70U0NWC2t+id0YmhxiHm+v73n39izKyIQwKbEWUbKePBv1YvNxLWKjcHzbpxTONuup25/O
 FHnrPROi9eeX2PdaxWJxKNQ45t3xWdhNUOAJ0Ppl3fAmwjp5uzQGWwD9PeZb6wlPPmPhZT7RKIQ
 JRd0MU68VFcD4qYqj/C17sBnAtbBZDUOtaWP49Z3uxYi5MCL1ow2SpTuKXcGbjPEA7t35mvZ6vv
 qN8ej9gd0PvOCC4BQV0ddhdWddHHrqgrMWPzx7CnlGuh54zdhi0xo9Yi4WyU0433LVcFzejJZgV
 3fgVWxdvu9MVxw6zsGimqzPe8Pn/mR5yQyCc8/l9GfGn5Y8o+jU4odpZ2rpmFN1ex6bkLE8SGY3
 EjtI8q7vDRJ5A+yFO1nM+ADE9CnKJkEO6wkDqF4XFI6vuYUYeYp60dUEOxtQIzTh/tEhj/zueEK
 ZcOG9zbqVYPyidgQ/sHmq42mA5INnCIt8XZxIwUA=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When xtsup=on is exposed, Linux switches the AMD IOMMU event interrupt
setup to x2APIC mode and programs the INTCAPXT event register instead
of relying on the PCI MSI capability.

QEMU currently neither records writes to the INTCAPXT event register nor
uses the programmed event vector when raising an AMD IOMMU event interrupt.
As a result, DMA faults can be logged into the event log without
delivering the AMD-Vi event interrupt to the guest when xtsup=on.

Add the INTCAPXT event MMIO offset and accept guest writes to it. When
IntCapXT is enabled, build the AMD-Vi event interrupt MSI message from
the programmed INTCAPXT event register; otherwise keep the existing PCI
MSI fallback.

This patch intentionally only supports the INTCAPXT event interrupt path.
It does not add PPR or GA-log interrupt support.

Keep command completion wait interrupts on the existing PCI MSI path by
using a separate event interrupt helper for INTCAPXT delivery.

Send INTCAPXT event interrupts through the APIC MSI delivery hook so
KVM can handle x2APIC destination IDs above 255.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/i386/amd_iommu.c | 50 +++++++++++++++++++++++++++++++++++++++------
 hw/i386/amd_iommu.h |  2 ++
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 996c154a3f..17485aa27f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -220,18 +220,53 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
    amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) & val);
 }
 
-static void amdvi_generate_msi_interrupt(AMDVIState *s)
+static void amdvi_send_msi_message(AMDVIState *s, MSIMessage msg)
 {
-    MSIMessage msg = {};
     MemTxAttrs attrs = {
         .requester_id = pci_requester_id(&s->pci->dev)
     };
 
+    address_space_stl_le(&address_space_memory, msg.address, msg.data,
+                         attrs, NULL);
+}
+
+static void amdvi_generate_msi_interrupt(AMDVIState *s)
+{
+    MSIMessage msg;
+
     if (msi_enabled(&s->pci->dev)) {
         msg = msi_get_message(&s->pci->dev, 0);
-        address_space_stl_le(&address_space_memory, msg.address, msg.data,
-                             attrs, NULL);
+        amdvi_send_msi_message(s, msg);
+    }
+}
+
+static void amdvi_generate_event_interrupt(AMDVIState *s)
+{
+    uint64_t intcapxt;
+    uint64_t control;
+    MSIMessage msg;
+
+    control = amdvi_readq(s, AMDVI_MMIO_CONTROL);
+    if (!s->xtsup || !(control & AMDVI_MMIO_CONTROL_INTCAPXTEN)) {
+        amdvi_generate_msi_interrupt(s);
+        return;
+    }
+
+    intcapxt = amdvi_readq(s, AMDVI_MMIO_INTCAPXT_EVT);
+    if (!intcapxt) {
+        return;
     }
+
+    X86IOMMUIrq irq = {
+        .delivery_mode = AMDVI_IOAPIC_INT_TYPE_FIXED,
+        .vector = extract64(intcapxt, 32, 8),
+        .dest = extract64(intcapxt, 8, 24) |
+                (extract64(intcapxt, 56, 8) << 24),
+        .dest_mode = extract64(intcapxt, 2, 1),
+    };
+
+    x86_iommu_irq_to_msi_message(&irq, &msg);
+    apic_get_class(NULL)->send_msi(&msg);
 }
 
 static uint32_t get_next_eventlog_entry(AMDVIState *s)
@@ -257,7 +292,7 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
         /* generate overflow interrupt */
         if (s->evtlog_intr) {
             amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_OVF);
-            amdvi_generate_msi_interrupt(s);
+            amdvi_generate_event_interrupt(s);
         }
         return;
     }
@@ -272,7 +307,7 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
 
     if (s->evtlog_intr) {
         amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVENT_INT);
-        amdvi_generate_msi_interrupt(s);
+        amdvi_generate_event_interrupt(s);
     }
 }
 
@@ -1740,6 +1775,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         amdvi_mmio_reg_write(s, size, val, addr);
         amdvi_handle_excllim_write(s);
         break;
+    case AMDVI_MMIO_INTCAPXT_EVT:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
         /* PPR log base - unused for now */
     case AMDVI_MMIO_PPR_BASE:
         amdvi_mmio_reg_write(s, size, val, addr);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 0b2e8d207b..7e829ccaa2 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -57,6 +57,7 @@
 #define AMDVI_MMIO_EXCL_BASE          0x0020
 #define AMDVI_MMIO_EXCL_LIMIT         0x0028
 #define AMDVI_MMIO_EXT_FEATURES       0x0030
+#define AMDVI_MMIO_INTCAPXT_EVT       0x0170
 #define AMDVI_MMIO_COMMAND_HEAD       0x2000
 #define AMDVI_MMIO_COMMAND_TAIL       0x2008
 #define AMDVI_MMIO_EVENT_HEAD         0x2010
@@ -106,6 +107,7 @@
 #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
+#define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
-- 
2.43.5


