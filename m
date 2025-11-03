Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D93FCCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1E3-0008E3-RB; Mon, 03 Nov 2025 15:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG1Dy-0007y3-29
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:32:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG1Dt-00008A-HD
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:32:21 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KOlJW032582;
 Mon, 3 Nov 2025 20:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=OuZFz
 So1rfARp/6cHAyceO176Yv3SSda1AJgBWh35zY=; b=Fvi7POBTFTCXdj+9f2AzL
 1ss2bwmFeNFhJLFlKnuX+KVlS1C+UUu0+TqF0jUNRc2/hxu8x3iPz+lT7AHh/coX
 Vs8ennUQFPlqEEwZRaGB7cWxuMKVrqzaX+6i/ZZpG/PeW9riSBNppyinlTt6Niar
 P5vedwKUQglAq0fRONA3F7dPqJ9dpa9kvPlZdnTuoe5zGZdi0FE+OtJoW0cWYFZE
 6nGWD4UDD5RIMNHhCEZNm6vlivS6ZaK5cvrRHXijR5D8sScOfylDlZUaj5QA82Ns
 vdn40Xsh3g5nFiRjJ+D6b0lIQpHXCWaZDU+YFEkDe1pogmnMczx2ngrz1T3Abuud
 g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a73dag0gj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 20:32:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5A3Isrjj010209; Mon, 3 Nov 2025 20:32:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4a58nc6eb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 20:32:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A3KSvS3040083;
 Mon, 3 Nov 2025 20:32:10 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4a58nc6e9h-3; Mon, 03 Nov 2025 20:32:10 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org, sarunkod@amd.com
Cc: alejandro.j.jimenez@oracle.com
Subject: [PATCH 2/3] amd_iommu: Fix handling of devices on buses != 0
Date: Mon,  3 Nov 2025 20:32:08 +0000
Message-ID: <20251103203209.645434-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251103203209.645434-1-alejandro.j.jimenez@oracle.com>
References: <20251103203209.645434-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030183
X-Authority-Analysis: v=2.4 cv=e7oLiKp/ c=1 sm=1 tr=0 ts=6909114b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8
 a=CeIGwK1nGGNdpEed_GQA:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: maY64zlPfyWBmranWTVSrhIk7JopKc4m
X-Proofpoint-GUID: maY64zlPfyWBmranWTVSrhIk7JopKc4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4MSBTYWx0ZWRfX01IXyO3bIHfI
 Ll+08AByqEjiIUD7lyMkP2bzHmcNh1FdjEmq9K7wuYodLT5NHO/YFf7rJq6e+jUdbwD1Z0OV6mF
 CTqOfJPVtuM3kJA1oYKDuF4Wf1asvhCkGOmjG6IPOMUXknL60EeKdixrf+4FXvFT6Djyrbtbpgk
 pEYtDI/Qbs59FFiGAossRegVnqqU+EtdsyqbKPc58orT6x7LfkEs6wDEZrTJPUH+xTt45bS9FAj
 VxmNnwYEHlgbLIFWtRJ3nbVtBRgoiBBKdB5nQ2DirrirB5itwLd1tZdch16izR2FpfuG8n6ucqg
 ITSofKzxBabi/JuGdGNJQyvAvtJjTPFaegE7cyJzzVGR7wN4A0292uM+Qk89Ii8fl7bfppJGgYK
 cj60G38qTu9DNRVIcp8+QePsh894xlZ05LRJOB+Je+aW9sGvsvQ=
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

From: Sairaj Kodilkar <sarunkod@amd.com>

The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn for
indexing into the DTE. The problem is that before the guest starts, all PCI
bus numbers are 0 as no PCI discovery has happened yet (BIOS and/or kernel
will do that later), so relying on the bus number is wrong.
The immediate effect is that emulated devices cannot do DMA when placed on a
bus other than 0.

Replace the static address_space array with a hash table keyed by devfn and
PCIBus*, since these values do not change after the guest boots.

Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
 hw/i386/amd_iommu.h |   2 +-
 2 files changed, 79 insertions(+), 57 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 378e0cb55e..78407ead80 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
 };
 
 struct AMDVIAddressSpace {
-    uint8_t bus_num;            /* bus number                           */
+    PCIBus *bus;                /* PCIBus (for bus number)              */
     uint8_t devfn;              /* device function                      */
     AMDVIState *iommu_state;    /* AMDVI - one per machine              */
     MemoryRegion root;          /* AMDVI Root memory map region         */
@@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
     AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
 } AMDVIFaultReason;
 
+typedef struct AMDVIAsKey {
+    PCIBus *bus;
+    uint8_t devfn;
+} AMDVIAsKey;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
     return (guint)*(const uint64_t *)v;
 }
 
+static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
+{
+    const AMDVIAsKey *key1 = v1;
+    const AMDVIAsKey *key2 = v2;
+
+    return key1->bus == key2->bus && key1->devfn == key2->devfn;
+}
+
+static guint amdvi_as_hash(gconstpointer v)
+{
+    const AMDVIAsKey *key = v;
+    guint bus = (guint)(uintptr_t)key->bus;
+
+    return (guint)(bus << 8 | (uint)key->devfn);
+}
+
+static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
+                                          uint8_t devfn)
+{
+    const AMDVIAsKey key = { .bus = bus, .devfn = devfn };
+    return g_hash_table_lookup(s->address_spaces, &key);
+}
+
+static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
+                                       gpointer user_data)
+{
+    const AMDVIAsKey *as = key;
+    const uint16_t *devidp = user_data;
+
+    return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+}
+
+static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
+{
+    return g_hash_table_find(s->address_spaces,
+                             amdvi_find_as_by_devid, &devid);
+}
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
@@ -551,7 +594,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
 {
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIState *s = as->iommu_state;
 
     if (!amdvi_get_dte(s, devid, dte)) {
@@ -1011,25 +1054,15 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
  */
 static void amdvi_reset_address_translation_all(AMDVIState *s)
 {
-    AMDVIAddressSpace **iommu_as;
-
-    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
+    AMDVIAddressSpace *iommu_as;
+    GHashTableIter as_it;
 
-        /* Nothing to do if there are no devices on the current bus */
-        if (!s->address_spaces[bus_num]) {
-            continue;
-        }
-        iommu_as = s->address_spaces[bus_num];
+    g_hash_table_iter_init(&as_it, s->address_spaces);
 
-        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
-
-            if (!iommu_as[devfn]) {
-                continue;
-            }
-            /* Use passthrough as default mode after reset */
-            iommu_as[devfn]->addr_translation = false;
-            amdvi_switch_address_space(iommu_as[devfn]);
-        }
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
+        /* Use passthrough as default mode after reset */
+        iommu_as->addr_translation = false;
+        amdvi_switch_address_space(iommu_as);
     }
 }
 
@@ -1089,27 +1122,15 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
  */
 static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
 {
-    uint8_t bus_num, devfn, dte_mode;
+    uint8_t dte_mode;
     AMDVIAddressSpace *as;
     uint64_t dte[4] = { 0 };
     int ret;
 
-    /*
-     * Convert the devid encoded in the command to a bus and devfn in
-     * order to retrieve the corresponding address space.
-     */
-    bus_num = PCI_BUS_NUM(devid);
-    devfn = devid & 0xff;
-
-    /*
-     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
-     * been allocated within AMDVIState, but must be careful to not access
-     * unallocated devfn.
-     */
-    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
+    as = amdvi_get_as_by_devid(s, devid);
+    if (!as) {
         return;
     }
-    as = s->address_spaces[bus_num][devfn];
 
     ret = amdvi_as_to_dte(as, dte);
 
@@ -1783,7 +1804,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
                                bool is_write, IOMMUTLBEntry *ret)
 {
     AMDVIState *s = as->iommu_state;
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
@@ -1858,7 +1879,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     }
 
     amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
-    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
+    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
             PCI_FUNC(as->devfn), addr, ret.translated_addr);
     return ret;
 }
@@ -2222,30 +2243,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     char name[128];
     AMDVIState *s = opaque;
-    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
-    int bus_num = pci_bus_num(bus);
+    AMDVIAddressSpace *amdvi_dev_as;
+    AMDVIAsKey *key;
 
-    iommu_as = s->address_spaces[bus_num];
+    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
 
     /* allocate memory during the first run */
-    if (!iommu_as) {
-        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
-        s->address_spaces[bus_num] = iommu_as;
-    }
-
-    /* set up AMD-Vi region */
-    if (!iommu_as[devfn]) {
+    if (!amdvi_dev_as) {
         snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
 
-        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
-        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
-        iommu_as[devfn]->devfn = (uint8_t)devfn;
-        iommu_as[devfn]->iommu_state = s;
-        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
-        iommu_as[devfn]->iova_tree = iova_tree_new();
-        iommu_as[devfn]->addr_translation = false;
+        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
+        key = g_new0(AMDVIAsKey, 1);
 
-        amdvi_dev_as = iommu_as[devfn];
+        amdvi_dev_as->bus = bus;
+        amdvi_dev_as->devfn = (uint8_t)devfn;
+        amdvi_dev_as->iommu_state = s;
+        amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
+        amdvi_dev_as->iova_tree = iova_tree_new();
+        amdvi_dev_as->addr_translation = false;
+        key->bus = bus;
+        key->devfn = devfn;
+
+        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
 
         /*
          * Memory region relationships looks like (Address range shows
@@ -2288,7 +2307,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
         amdvi_switch_address_space(amdvi_dev_as);
     }
-    return &iommu_as[devfn]->as;
+    return &amdvi_dev_as->as;
 }
 
 static const PCIIOMMUOps amdvi_iommu_ops = {
@@ -2329,7 +2348,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
         error_setg_errno(errp, ENOTSUP,
             "device %02x.%02x.%x requires dma-remap=1",
-            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
         return -ENOTSUP;
     }
 
@@ -2510,6 +2529,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
+    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
+                                     amdvi_as_equal, g_free, g_free);
+
     /* set up MMIO */
     memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index daf82fc85f..38471b95d1 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -408,7 +408,7 @@ struct AMDVIState {
     bool mmio_enabled;
 
     /* for each served device */
-    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
+    GHashTable *address_spaces;
 
     /* list of address spaces with registered notifiers */
     QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
-- 
2.43.5


