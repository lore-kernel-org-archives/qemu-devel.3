Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD8EC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2zpa-00075G-At; Thu, 10 Apr 2025 17:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2zpR-00073K-IJ; Thu, 10 Apr 2025 17:52:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2zpO-0002jT-D3; Thu, 10 Apr 2025 17:52:55 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ALM6NX011076;
 Thu, 10 Apr 2025 21:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=wOZIS
 ExYEAUELuFEJ2nWGEM2z4gchVoGQEjqlsFaSwg=; b=HE3j2fQt5RyAA9tiu+kH9
 6AVudu+Jfbe1zGDT2iNuZH+emTIFRbRNLuneIo/a7Cm/rFFuqyo5k2jaUVHhu10b
 ldIsuv0OKaq3CAAdaLj8Ui5FkcDPaNxfly5z06kGb8yambmozAehnWV+6Pft6m3A
 KsX/YvgQeP1WR200/TTQcULaooh71uf28hBCo+jJtZx1Q/hauiIfWRR3jIrj6DUf
 su1e5d1pfvOs2TxCv7x0DWw6v9Sg/xPJaavt1rdbazVgKBydCY1eowqA95dVL8+J
 IHGin4ACTfuRHu+LVg9jy29jDQzQ6gzj8FB5/HtrKEG0B++ebSAiy8NSermFblt5
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xnu9r5vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 21:52:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53AKfIpx013788; Thu, 10 Apr 2025 21:52:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyk6twu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 21:52:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53ALqjZs008077;
 Thu, 10 Apr 2025 21:52:46 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 45ttyk6tw6-2; Thu, 10 Apr 2025 21:52:46 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH v2] hw/nvme: CMIC.MCTRS should be set automatically for
 multi-controller subsystems or by parameter
Date: Thu, 10 Apr 2025 15:02:37 -0700
Message-ID: <20250410220237.587858-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250410220237.587858-1-alan.adamson@oracle.com>
References: <20250410220237.587858-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100159
X-Proofpoint-GUID: EP8ezOaWrXIG8e4bUlQ8c0hMetz9DsPF
X-Proofpoint-ORIG-GUID: EP8ezOaWrXIG8e4bUlQ8c0hMetz9DsPF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If there are multiple controllers in a subsystem, CMIC.MCTRS should be set to on
for all controllers. For single controller subsystems, CMIC.MCTRS will be off by
default. A new subsystem specific parameter will allow setting CMIC.MCTRS for
single controller subsystems.

New NVMe Subsystem QEMU Parameter (See NVMe Specification for details):
    <subsystem>,cmic-mctrs=BOOLEAN (default: off)

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 hw/nvme/ctrl.c   | 15 ++++++++++++++-
 hw/nvme/nvme.h   |  2 ++
 hw/nvme/subsys.c |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d6b77d4fbc9d..ce0d98b39991 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8880,7 +8880,20 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
 
-    id->cmic |= NVME_CMIC_MULTI_CTRL;
+    n->subsys->total_ctrls++;
+
+    /* Check if there are more than 2 controllers or cmic.mctrs is enabled */
+    if (n->subsys->params.cmic_mctrs || (n->subsys->total_ctrls > 2)) {
+        id->cmic |= NVME_CMIC_MULTI_CTRL;
+    } else if (n->subsys->total_ctrls == 2) {
+        /*
+         * When the 2nd controller on this subsys is inited, CMIC.MCTRS
+         * needs to be set. Also need to go back and set CMIC.MCTRS
+         * on the first controller.
+         */
+        id->cmic |= NVME_CMIC_MULTI_CTRL;
+        n->subsys->ctrls[0]->id_ctrl.cmic |= NVME_CMIC_MULTI_CTRL;
+    }
     ctratt |= NVME_CTRATT_ENDGRPS;
 
     id->endgidmax = cpu_to_le16(0x1);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index b5c9378ea4e5..061e7046550b 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -116,7 +116,9 @@ typedef struct NvmeSubsystem {
             uint16_t nruh;
             uint32_t nrg;
         } fdp;
+        bool         cmic_mctrs;
     } params;
+    uint8_t          total_ctrls;
 } NvmeSubsystem;
 
 int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp);
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index b617ac3892a3..9c90f12b6351 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -216,6 +216,7 @@ static const Property nvme_subsystem_props[] = {
                      NVME_DEFAULT_RU_SIZE),
     DEFINE_PROP_UINT32("fdp.nrg", NvmeSubsystem, params.fdp.nrg, 1),
     DEFINE_PROP_UINT16("fdp.nruh", NvmeSubsystem, params.fdp.nruh, 0),
+    DEFINE_PROP_BOOL("cmic.mctrs", NvmeSubsystem, params.cmic_mctrs, false),
 };
 
 static void nvme_subsys_class_init(ObjectClass *oc, void *data)
-- 
2.43.5


