Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7FBCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX3PJ-0008OE-Su; Tue, 09 Jun 2026 16:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PE-0008Mu-Tc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PC-0000MF-2j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659KBmvT2134549; Tue, 9 Jun 2026 20:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=aAMbd
 9NhPfm3vLYooXyD7mg+ApQv48UepFY6bs9O55Q=; b=IqnJZ7fqi3dPgFOFffGa5
 vDDW9/k3Kav8BDVMjJdvAoA5oAEkan6Rhe//B30xYoHu3KLWzYtsoZkwSEk0PlF0
 X7NMP8byQ6kdlhhwjASXMOgMbs+HigOBhBRVREBGkCIEHS1y9mJhS7yaFYygI5xi
 3h42rBqI/n/OITM6GMYYcL8yT1y+KqgG0ad8qpymgUZO8nqkDA2jvPbrIhiL9amU
 yOiv0Yn2tH3SqzohPsfl5ydZ//qz+gbGOcO5566SwMS4fE9UEsbzVhHx+B9RN+qZ
 J4V1VNPvnGM3Gmyd8KfzDz88DCo9laO+j0jvxl1u0M2chVuBv1c8Cs5mieI4eXpK
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ema4y5ar1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 659KmWQn023153; Tue, 9 Jun 2026 20:50:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ema0qn7mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:31 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 659KoTpL030607;
 Tue, 9 Jun 2026 20:50:31 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ema0qn7ju-3; Tue, 09 Jun 2026 20:50:31 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com
Subject: [PATCH 2/4] amd_iommu: Use full BDF when reporting page faults
Date: Tue,  9 Jun 2026 13:43:33 -0700
Message-ID: <20260609204403.323149-3-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=ZMvnX37b c=1 sm=1 tr=0 ts=6a287c99 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=ll-nBFWiReWw3pmKOSoA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-ORIG-GUID: u3BbCQ9p-7h7xGnBUXISwII2hRjKjNTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE5NSBTYWx0ZWRfX5NwfVy9jEuKC
 QxV2RJQItJUxdu1XY3FmeQk0y3kT8JXCgljv1PrL0/mPaR3K8je3pOfCcBzn8ohwifeog+dFXod
 kUbW6jNS4pOzwuu3cEprCHO79C8CRMlajsw0NoG5XVj9F7a78BxJL0wjD0+ALZ0N70CRPAR+Z78
 Uhz7KpunAtB/ER7Du7UWAyho6NKrCUs7MyXtMEPGTDc2/CM0fZSYWGCWZ1oK6loC7ftJCeetMwn
 6TWdPStMKy5Aywm/gPaL9EhEedhx1rGbaDnUIR1+Ozni4iRAF5I/XYYw6AlHaen2xlIkEP/po0W
 rZocoYVQDGfYEIzKuA+LtHcVGmdZ8v9DwpOfRFcJy5eluHamRjlKrzEvuZDqLLNiY3P0w1b84jN
 irFj3ehyOl1rxZaJUorWnhlnW2UrMzSCIAJvlH4DxpJLLFfg3ZU7+slli1qOaoepWFpbpsdPn6G
 zomAUXGKB5niheeHs9Oa0Y263ZsjW0DgQS41VxU0=
X-Proofpoint-GUID: u3BbCQ9p-7h7xGnBUXISwII2hRjKjNTh
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

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/i386/amd_iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 997d02eab5..ca9d79bb51 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -87,6 +87,11 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;
 
+static uint16_t amdvi_as_devid(AMDVIAddressSpace *as)
+{
+    return PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+}
+
 /*
  * These 'fault' reasons have an overloaded meaning since they are not only
  * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
@@ -613,7 +618,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
 {
-    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+    uint16_t devid = amdvi_as_devid(as);
     AMDVIState *s = as->iommu_state;
 
     if (!amdvi_get_dte(s, devid, dte)) {
@@ -664,6 +669,7 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
 {
     IOMMUAccessFlags perms = amdvi_get_perms(dte);
 
+    uint16_t devid = amdvi_as_devid(as);
     uint8_t level, mode;
     uint64_t pte_addr;
 
@@ -719,7 +725,7 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
          * and walk down to the lower level.
          */
         pte_addr = NEXT_PTE_ADDR(*pte, level, address);
-        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, devid);
 
         if (*pte == (uint64_t)-1) {
             /*
@@ -1763,6 +1769,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     uint8_t mode;
     uint64_t pte;
     int fetch_ret;
+    uint16_t devid = amdvi_as_devid(as);
 
     /* make sure the DTE has TV = 1 */
     if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
@@ -1796,7 +1803,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     if (fetch_ret < 0 || !IOMMU_PTE_PRESENT(pte) ||
         perms != (perms & amdvi_get_perms(pte))) {
 
-        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+        amdvi_page_fault(as->iommu_state, devid, addr, perms);
         trace_amdvi_page_fault(addr);
         return;
     }
@@ -1823,7 +1830,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
                                bool is_write, IOMMUTLBEntry *ret)
 {
     AMDVIState *s = as->iommu_state;
-    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+    uint16_t devid = amdvi_as_devid(as);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
-- 
2.43.5


