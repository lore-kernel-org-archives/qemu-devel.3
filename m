Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27097C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfxF-0003yR-4T; Thu, 01 May 2025 22:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx9-0003ws-Lm
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx7-0007Sw-JC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeYUX001984;
 Fri, 2 May 2025 02:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=T7KSx
 NiPgGcz6WjjcYDyFckVRmU310GEr03Swk/ObiY=; b=in9wAkxhcCX0DPGDHIAyd
 yQ6hl2Ln28zPUYqvFS4Jl7ueUdtFM2hO8yvtG+dy1/Apqm1ZbgO54FcZATZS+vzA
 plLvZck5rdncd+3QHSEyYZgolws59PLW069PtADhtBPbwQKXaydM7psXefTlPsMC
 nqOi+jCgKhkRROB9ZYAUb2UmKYKxeNtYZKt7zM5oKVbs7S1SbyTvmQxfKf7xId5o
 cD1bfb8j/BPyYuAPk4KvDOETUhaEUtGBWWkOpBXFG2YgkVAbH1jofIaWD/cFzy75
 0Kuy3MIXevNmwhaAoecnmWe05SEjpKa5eW2CYURFnhr19+OtGnko8oHquFJMNNNf
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umcccq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5420K1MH023894; Fri, 2 May 2025 02:16:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh03u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:19 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsQ011525;
 Fri, 2 May 2025 02:16:19 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-19; Fri, 02 May 2025 02:16:19 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 18/20] amd_iommu: Toggle address translation mode on devtab
 entry invalidation
Date: Fri,  2 May 2025 02:16:03 +0000
Message-ID: <20250502021605.1795985-19-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=68142afe b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=bc8DUuFyzEVX7U-nHvcA:9 cc=ntf
 awl=host:13130
X-Proofpoint-GUID: hymC5FIXU7nF6CTqBZr7I__IFgRP-pnM
X-Proofpoint-ORIG-GUID: hymC5FIXU7nF6CTqBZr7I__IFgRP-pnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX6vd/jTqKjj7u
 M2jeoVThBgkFQiuDvV2ttuCAbVKnyEmadtBXa4yHf1CpiB7GB2cB4Zgwt5SaI+a84Mkdk31Prep
 l/MzLzZfc8rHVk8wmWB4V0ESNlqT78cSRMnx1Usd2Q22jkgnVSOdU/EM7qjJwgydgVmUJxUFkvg
 O+Rua/uWoF98XWIkP6gSRqkXMTGshBiNVZ7CIBzf8Ir4h99AdHj0MF+eSG+PIwZbro9tGNJySzf
 yIjY6V0gMX/E19wssxNWvb9MQKf2o96+82kEHoVKLfxy6G7+0nTrC0xy9FM8MGPIKdB+l16npx4
 fav1KxtbdBXO8wvq4QBzB48c4DmZx69HG3AEgoekUYuS/L9avJiFe94FtGsNU/tGmDJy7Jw2h9L
 B1gZfo+utVcJT9MVStuYAuOAcV2Y5S5jxXsDGonbiXUSfu6UVaYufJaD8C/OK9LjCrTdf6cH
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
Device Table entry (DTE) e.g. after attaching a device and setting up its
DTE. When intercepting this event, determine if the DTE has been configured
for paging or not, and toggle the appropriate memory regions to allow DMA
address translation for the address space if needed. Requires dma-remap=on.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 78 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index a2df73062bf7..75a92067f35f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -991,18 +991,92 @@ static void amdvi_switch_address_space_all(AMDVIState *s)
     }
 }
 
+/*
+ * A guest driver must issue the INVALIDATE_DEVTAB_ENTRY command to the IOMMU
+ * after changing a Device Table entry. We can use this fact to detect when a
+ * Device Table entry is created for a device attached to a paging domain and
+ * enable the corresponding IOMMU memory region to allow for DMA translation if
+ * appropriate.
+ */
+static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
+{
+    uint8_t bus_num, devfn, dte_mode;
+    AMDVIAddressSpace *as;
+    uint64_t dte[4] = { 0 };
+    IOMMUNotifier *n;
+    int ret;
+
+    /*
+     * Convert the devid encoded in the command to a bus and devfn in
+     * order to retrieve the corresponding address space.
+     */
+    bus_num = PCI_BUS_NUM(devid);
+    devfn = devid & 0xff;
+
+    /*
+     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
+     * been allocated within AMDVIState, but must be careful to not access
+     * unallocated devfn.
+     */
+    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
+        return;
+    }
+    as = s->address_spaces[bus_num][devfn];
+
+    ret = amdvi_as_to_dte(as, dte);
+
+    if (!ret) {
+        dte_mode = (dte[0] >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
+    }
+
+    if ((ret < 0) || (!ret && !dte_mode)) {
+        /*
+         * The DTE could not be retrieved, it is not valid, or it is not setup
+         * for paging. In either case, ensure that if paging was previously in
+         * use then invalidate all existing mappings and then switch to use the
+         * no_dma memory region.
+         */
+        if (as->addr_translation) {
+            as->addr_translation = false;
+
+            IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+                amdvi_address_space_unmap(as, n);
+            }
+            amdvi_switch_address_space(as);
+        }
+    } else if (!as->addr_translation) {
+        /*
+         * Installing a DTE that enables translation where it wasn't previously
+         * active. Activate the DMA memory region.
+         */
+        as->addr_translation = true;
+        amdvi_switch_address_space(as);
+        amdvi_address_space_sync(as);
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
     uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
 
+    trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
+                             PCI_FUNC(devid));
+
     /* This command should invalidate internal caches of which there isn't */
     if (extract64(cmd[0], 16, 44) || cmd[1]) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
+        return;
+    }
+
+    /*
+     * When DMA remapping capability is enabled, check if updated DTE is setup
+     * for paging or not, and configure the corresponding memory regions.
+     */
+    if (s->dma_remap) {
+        amdvi_update_addr_translation_mode(s, devid);
     }
-    trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
-                             PCI_FUNC(devid));
 }
 
 static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
-- 
2.43.5


