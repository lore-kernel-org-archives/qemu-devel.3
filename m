Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC79DCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimV-0006uA-7x; Fri, 19 Sep 2025 17:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimM-0006mG-In
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimE-0002Yb-4L
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:29 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtoGs023213;
 Fri, 19 Sep 2025 21:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=bUPav
 Y3lJxfhxP2xgahZHolvMbEwYtLblQG5B8W4OxU=; b=bzMEKdFf0KpXQPk+pwQ41
 8HrZlzVW9v44ns0AekdBSF4KaR9zLqjX/1CwUUJktlsBkC2gHJN2NnPfv5FfaMxM
 Y48wghEYH90tGWNJ5eG/gQO9NVbO8Aoi/4bVIMgge+yXiBp+ONID0O2Cd1qG/F0Z
 z8c+egYX+Kna0nToc2JKrDMf7Riv8qw9bpFI3XXpDJ1mdLYKGQs0H6bxv9ZCd9xa
 M/boa4xeLVEf7FqWDs2BsHjbjQn7syDhyQhcBZcnygVFMHygdKb3RXhHg7xa672u
 03xgYFzlucI4HU2ccAFYi7ZtbB2r4qlp4gperA2Ne8FeAq6axxI/Pk0gLBgZkIU2
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6pdwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JIx8c4033731; Fri, 19 Sep 2025 21:36:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwru7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:36:02 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0Z004301;
 Fri, 19 Sep 2025 21:36:01 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-19; Fri, 19 Sep 2025 21:36:01 +0000
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
Subject: [PATCH v3 18/22] amd_iommu: Toggle address translation mode on devtab
 entry invalidation
Date: Fri, 19 Sep 2025 21:35:11 +0000
Message-ID: <20250919213515.917111-19-alejandro.j.jimenez@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cdccc3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=YvzyzkPmWOJL5gKF_FwA:9
X-Proofpoint-GUID: LPevFVPNJSRRBPVAVBUB-ipStWPk1u0J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX00csENR9FHGm
 rhUo59djyJdiJZFMEMYj+2i8Ne+Ef26kJrH7fmHeAQ7kCmuw4yVRji+JZ/ly8ABZHP/Cuv49pXc
 bjA1xdJV+KtBuFqIA0VsWmULMhYW0a5pCjRj/l8VImFmFNW09n0RL3xYuXp5VTGeUEsdbf4DApS
 vHcq6iOYFKcM9qqsksUmP5Q3XX3BUshP554729LpDcijRhzeyoJS0kkYMQq/XmRXsgf0zTNQ47L
 qnXWPb5k//toSQl5Xs66qW1TtYgtCgp61V7sLWdnlCrk69Lfxl1glVfEjg3D7cvH6NRq3zC7E3L
 ZxconKChwhUnLN7bEHGw3y+BWp2ru/UFzAJblftq5679msBEPfR9VB4fjjWMWpzKybTNztL3cIZ
 CCvfh88d
X-Proofpoint-ORIG-GUID: LPevFVPNJSRRBPVAVBUB-ipStWPk1u0J
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

A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
Device Table entry (DTE) e.g. after attaching a device and setting up its
DTE. When intercepting this event, determine if the DTE has been configured
for paging or not, and toggle the appropriate memory regions to allow DMA
address translation for the address space if needed. Requires dma-remap=on.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 122 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index ce5d4c36624fd..e916dcb2be381 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1032,18 +1032,136 @@ static void amdvi_reset_address_translation_all(AMDVIState *s)
     }
 }
 
+static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
+{
+    /*
+     * When enabling DMA mode for the purpose of isolating guest devices on
+     * a failure to retrieve or invalid DTE, all existing mappings must be
+     * dropped.
+     */
+    if (inval_current) {
+        IOMMUNotifier *n;
+        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+            amdvi_address_space_unmap(as, n);
+        }
+    }
+
+    if (as->addr_translation) {
+        return;
+    }
+
+    /* Installing DTE enabling translation, activate region */
+    as->addr_translation = true;
+    amdvi_switch_address_space(as);
+    /* Sync shadow page tables */
+    amdvi_address_space_sync(as);
+}
+
+/*
+ * If paging was previously in use in the address space
+ * - invalidate all existing mappings
+ * - switch to no_dma memory region
+ */
+static void enable_nodma_mode(AMDVIAddressSpace *as)
+{
+    IOMMUNotifier *n;
+
+    if (!as->addr_translation) {
+        /* passthrough is already active, nothing to do */
+        return;
+    }
+
+    as->addr_translation = false;
+    IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+        /* Drop all mappings for the address space */
+        amdvi_address_space_unmap(as, n);
+    }
+    amdvi_switch_address_space(as);
+}
+
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
+    switch (ret) {
+    case 0:
+        /* DTE was successfully retrieved */
+        if (!dte_mode) {
+            enable_nodma_mode(as); /* DTE[V]=1 && DTE[Mode]=0 => passthrough */
+        } else {
+            enable_dma_mode(as, false); /* Enable DMA translation */
+        }
+        break;
+    case -AMDVI_FR_DTE_V:
+        /* DTE[V]=0, address is passed untranslated */
+        enable_nodma_mode(as);
+        break;
+    case -AMDVI_FR_DTE_RTR_ERR:
+    case -AMDVI_FR_DTE_TV:
+        /*
+         * Enforce isolation by using DMA in rare scenarios where the DTE cannot
+         * be retrieved or DTE[TV]=0. Existing mappings are dropped.
+         */
+        enable_dma_mode(as, true);
+        break;
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


