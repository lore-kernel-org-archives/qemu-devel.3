Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C40CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzim2-0006Jk-Lf; Fri, 19 Sep 2025 17:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilv-0006BI-4o
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilr-0002Ws-WE
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtoGn006928;
 Fri, 19 Sep 2025 21:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=/9+0K
 CE3r5tkaFKWr1+qwyZdMZMZ2is8s5wftLUBkCk=; b=bgSvd0vkZ8BVZFTtkKHaB
 ylyx8pkazr8z+c0cDJWpbJ8C7DOmOa43XJKjbgRcvYezge6KJFnkivPuvo3vboHd
 7rHKXTRN2whlPnfr2o92++BV3AJy7uIaPhVuue0+amzUT+VYtscEpZ4gSJZ32+Tz
 yb69Bw65DLWc64rZcc0Ju8vXZ6mlEm2pGWZKUXUscZ3QuEUv/UNy57EsvQ9VT18X
 Ky0kYns4ItAoluqqY/3cTY+INuVifAAngvPDBR3DBZaKvnU1ta8Cp7a31MvQrN0t
 DqNieHFDhU5gqYBQBmWcgJAEeWJ7lHdIThvdUhC/THwQRN+mytBllYF4kM7ZDKjh
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd6bp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JKgfKG033651; Fri, 19 Sep 2025 21:35:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:48 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0L004301;
 Fri, 19 Sep 2025 21:35:47 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-13; Fri, 19 Sep 2025 21:35:47 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 12/22] amd_iommu: Unmap all address spaces under the AMD
 IOMMU on reset
Date: Fri, 19 Sep 2025 21:35:05 +0000
Message-ID: <20250919213515.917111-13-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Proofpoint-GUID: z6S4R3qRbT8cDZs2vKHfSO2MrD16wihO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3Qc59lY9vZEb
 sYnYp+IW2dVl9iYrfBYH+JXLC1c0a3mjwQQkMAAlbTe4yaTT0QsAkYMdiNBpypQF3jdfRHmXPQV
 4uNSayNKQFa8wsHtUFXBM3uRhqkKaOhm50/q4lg3xV39S0O/eyN/NpAegC92dRolxv+BNiBxQnm
 ZS8+lgymIth63UDfauIFo6VDOwMnn+8081EUVDWdZPvYmzCK7EISqIUoFUBKuiRNZU9JGmJqZkk
 5mQpuj7kUBz+OBlQ+cBxOMj0TnJRQcfKf+LvrGCZgWFgixssmIYpoG4agr9uXC4moi8eb4ZJYmd
 G33R9xIIdc3GWkAAupPa2JPOrP/5SlPiS1RL6ZeZ0mRj4VOVuvODz+S6yu/cdkKtbuLlKDtnZZO
 TjqJTTkk
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cdccb5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=0R8M-FwGblI3YPkDnqAA:9
X-Proofpoint-ORIG-GUID: z6S4R3qRbT8cDZs2vKHfSO2MrD16wihO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Support dropping all existing mappings on reset. When the guest kernel
reboots it will create new ones, but other components that run before
the kernel (e.g. OVMF) should not be able to use existing mappings from
the previous boot.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4376e977f8886..497f18c540666 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -847,6 +847,77 @@ next:
     }
 }
 
+/*
+ * Unmap entire range that the notifier registered for i.e. the full AS.
+ *
+ * This is seemingly technically equivalent to directly calling
+ * memory_region_unmap_iommu_notifier_range(), but it allows to check for
+ * notifier boundaries and issue notifications with ranges within those bounds.
+ */
+static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n)
+{
+
+    hwaddr start = n->start;
+    hwaddr end = n->end;
+    hwaddr remain;
+    DMAMap map;
+
+    assert(start <= end);
+    remain = end - start + 1;
+
+    /*
+     * Divide the notifier range into chunks that are aligned and do not exceed
+     * the notifier boundaries.
+     */
+    while (remain >= AMDVI_PAGE_SIZE) {
+
+        IOMMUTLBEvent event;
+
+        uint64_t mask = dma_aligned_pow2_mask(start, end, 64);
+
+        event.type = IOMMU_NOTIFIER_UNMAP;
+
+        IOMMUTLBEntry entry = {
+            .target_as = &address_space_memory,
+            .iova = start,
+            .translated_addr = 0,   /* irrelevant for unmap case */
+            .addr_mask = mask,
+            .perm = IOMMU_NONE,
+        };
+        event.entry = entry;
+
+        /* Call notifier registered for updates on this address space */
+        memory_region_notify_iommu_one(n, &event);
+
+        start += mask + 1;
+        remain -= mask + 1;
+    }
+
+    assert(!remain);
+
+    map.iova = n->start;
+    map.size = n->end - n->start;
+
+    iova_tree_remove(as->iova_tree, map);
+}
+
+/*
+ * For all the address spaces with notifiers registered, unmap the entire range
+ * the notifier registered for i.e. clear all the address spaces managed by the
+ * IOMMU.
+ */
+static void amdvi_address_space_unmap_all(AMDVIState *s)
+{
+    AMDVIAddressSpace *as;
+    IOMMUNotifier *n;
+
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+            amdvi_address_space_unmap(as, n);
+        }
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2099,6 +2170,9 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 
     msi_reset(&s->pci->dev);
     amdvi_init(s);
+
+    /* Discard all mappings on device reset */
+    amdvi_address_space_unmap_all(s);
 }
 
 static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
-- 
2.43.5


