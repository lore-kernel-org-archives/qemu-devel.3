Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A72606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=DQlZRo2j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMadi-0004Xz-At; Thu, 29 Oct 2026 20:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadY-0004Vv-JK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadW-0003ch-5k
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLYlh12256631; Fri, 30 Oct 2026 00:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=AtYLt
 7/3L/KneBSziO5uJ6zinKJBVgez4qpoyfItFrY=; b=DQlZRo2jEk2rWWZ1pOlCB
 eKihcrfDwii1QqgggF84wNHXcC6LWVZO709PeN5gx7nmitrazKKuZAKzCEJPR5GB
 m5WCbwddrkZ3gNB5+EV5y75TlerGJUYQHB+xxaEixzuNYNQvYiyNU96dxXrv7MqH
 U68dfgt1bxeLZ4idYkAOd28j8dZk2x7BDx2zHd3FtWjDSvJtFmseJf/J4C64+3ug
 dVjaySIpFZpN0VE5KDzUvQlCKt080yl37uBXuOZ9fz/r6hmz7YCu9/jNQm9mOZDJ
 UZ19fYN2zSC28WrUN7GYK2CX2BA4LbWVbxBAFh7HEvivm2tVLcZuaa3X4OzVRw5R
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hme61r42h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 00:38:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 69TNgAJQ2004302; Fri, 30 Oct 2026 00:38:20 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4hmg231tmh-3; Fri, 30 Oct 2026 00:38:20 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, joe.jin@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 2/5] amd_iommu: Use full BDF when reporting page faults
Date: Fri, 30 Oct 2026 00:38:14 +0000
Message-ID: <20261030003817.3521476-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
References: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610190000 definitions=main-2610300001
X-Authority-Analysis: v=2.4 cv=L9qI0OT8 c=1 sm=1 tr=0 ts=6ae3e6fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=ocuUHAh6soMjp_LHbv0A:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: Nm4nQkXfE1RoEE4csZGTHWoT376C_Qlm
X-Proofpoint-ORIG-GUID: Nm4nQkXfE1RoEE4csZGTHWoT376C_Qlm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfXyz0PB4N21J3Q
 3cJ8DmqsilAFDuUmYDNGzSJ+dyNtWUmG+ow9njBn9pVGn74VfB4ERogeJ6jELnrskcDdDOQ7zne
 TtBk1D2PkHlNEAHAan+6JyQdtRVrRsg4D4HRHnGcSQ0vcqV+s5uvqPwhOevd8BE8LfBfyKnJEOi
 5AaKGuml6k5ElDM1iU5yZHN9zgdVZwtQKeP02eutCvUroEwlcKW8IZf+QhMMoHY25goc6+WLXTp
 +l8ocDxCf1TjKfs05+sn9cS1bCpJQm3RrdZcrPp8QbaZs+YPDq7PaDtwm8ErHhTkPRo5HzuggbC
 oWPdzckP/xtS7Ev/2P2w/ibo1EUmlzZuhUr7CcWmRh3fz8Q4pjcDK7K4rfYaDLqc7ERfwQC1X7u
 HW31oaPq53ikRhk86UsKHRD3dhXGS6IkktdfB+7Tbj/I4dBM1JlxFt2nzbWWIb4VFgk3tLpiuF4
 UhlKrpxaa5YUQcXNDxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX2f6sVcki4McR
 G/IsECIT0V20NIg0JzlDtXuVdRHAhkq7ZKh4BnkRp7pWDZ28o4g0u84a5ZTIEsiszcCTjYFIFQc
 PYLg+tB/Wl0Mhq9L6szyen44x1VJU9/Q0y6x4tK8DPU+mA3p4+CW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dongli Zhang <dongli.zhang@oracle.com>

AMDVIAddressSpace->devfn only contains the PCI device/function number.
AMD-Vi event log entries require the full DeviceID, including the PCI
bus number.

When reporting IO page faults for devices behind a pcie-root-port, QEMU
logs the fault against the wrong requester. For example, a fault from
01:00.0 is reported as 00:00.0 because only devfn is passed to
amdvi_page_fault().

[root@vm ~]# lspci
... ...
01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)

[   58.154050] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]
[   58.156968] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]

Use the full BDF consistently for AMD-Vi address spaces and pass it to
page fault and page-table access error reporting.

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index fa590c9223..f52a922c69 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -66,6 +66,16 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;
 
+static uint16_t amdvi_get_devid(PCIBus *bus, uint8_t devfn)
+{
+    return PCI_BUILD_BDF(pci_bus_num(bus), devfn);
+}
+
+static uint16_t amdvi_get_as_devid(AMDVIAddressSpace *as)
+{
+    return amdvi_get_devid(as->bus, as->devfn);
+}
+
 /*
  * These 'fault' reasons have an overloaded meaning since they are not only
  * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
@@ -460,7 +470,7 @@ static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
     const AMDVIAsKey *as = key;
     const uint16_t *devidp = user_data;
 
-    return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+    return *devidp == amdvi_get_devid(as->bus, as->devfn);
 }
 
 static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
@@ -665,7 +675,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
 {
-    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+    uint16_t devid = amdvi_get_as_devid(as);
     AMDVIState *s = as->iommu_state;
 
     if (!amdvi_get_dte(s, devid, dte)) {
@@ -764,6 +774,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
     uint8_t pt_level, next_pt_level;
     IOMMUAccessFlags perms;
     int ret;
+    uint16_t devid = amdvi_get_as_devid(as);
 
     *page_size = 0;
 
@@ -781,7 +792,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
      * Pointer and indexing the top level table using the IOVA from the request.
      */
     pte_addr = NEXT_PTE_ADDR(dte, pt_level, address);
-    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, devid);
 
     if (*pte == (uint64_t)-1) {
         /*
@@ -837,7 +848,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
         *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
 
         pte_addr = NEXT_PTE_ADDR(*pte, pt_level, address);
-        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, devid);
 
         if (*pte == (uint64_t)-1) {
             /* Failure to read PTE. Page walk skips a page_size chunk */
@@ -1898,6 +1909,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     uint8_t mode;
     uint64_t pte;
     int fetch_ret;
+    uint16_t devid = amdvi_get_as_devid(as);
 
     /* make sure the DTE has TV = 1 */
     if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
@@ -1931,7 +1943,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     if (fetch_ret < 0 || !IOMMU_PTE_PRESENT(pte) ||
         perms != (perms & amdvi_get_perms(pte))) {
 
-        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+        amdvi_page_fault(as->iommu_state, devid, addr, perms);
         trace_amdvi_page_fault(addr);
         return;
     }
@@ -1958,7 +1970,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
                                bool is_write, IOMMUTLBEntry *ret)
 {
     AMDVIState *s = as->iommu_state;
-    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+    uint16_t devid = amdvi_get_as_devid(as);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
-- 
2.47.3


