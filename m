Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48FEC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 22:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Hii-0006SG-BE; Tue, 08 Apr 2025 18:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2Hig-0006R7-Rx; Tue, 08 Apr 2025 18:47:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2Hif-0004y5-Az; Tue, 08 Apr 2025 18:47:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9r77004065;
 Tue, 8 Apr 2025 22:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=3zst8
 +GEy5gnvVUBHLwCLCMvDyTpb5nVCArMMoNYXXI=; b=R1btvoZzGIzOEPWrv9TUl
 KSC5KgBTTf7h2tOrRhmczTZc6DDjV+UGvbaS+/FBmvfyllv4j5k+DWGot7euc+Hf
 zTpYjS/5WYpYKfdKCEnAKkYrYivTx9WaKrPSvh6LmLiVd4gttHFt8jd2aw0i8ouL
 FVWIWSvK7Go7V63AFEUwJIHlPeYnSR8IPHTn+J4s/mR7JYDnxgwzzS7J2I9P8N6S
 TcLRKwuX+dC1TG1svFPL2rWBASy/HIC4bO53Vy3iqrMGEPcOnYRZAhJq5NmUJ5L8
 2AU08rvDIBSX8MgQ6DGbJQWrXpX7FplKDwWmfiungfpW4gXWk70ZtE/5VagkB+EP
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tnyvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Apr 2025 22:46:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 538MDiXX001297; Tue, 8 Apr 2025 22:46:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttya068u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Apr 2025 22:46:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 538MkquC038560;
 Tue, 8 Apr 2025 22:46:53 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 45ttya068c-2; Tue, 08 Apr 2025 22:46:53 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH 1/1] hw/nvme: create parameter to enable/disable cmic on
 subsystem
Date: Tue,  8 Apr 2025 15:56:44 -0700
Message-ID: <20250408225644.814616-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250408225644.814616-1-alan.adamson@oracle.com>
References: <20250408225644.814616-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_09,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080156
X-Proofpoint-ORIG-GUID: lm6o3QA-e_-vkgq_chKnRkH_Yv4QKqxU
X-Proofpoint-GUID: lm6o3QA-e_-vkgq_chKnRkH_Yv4QKqxU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Allow the value of CMIC to to be set via a new subsystem specific parameter.
This removes the requirement that all subsystems must have the CMIC bit enabled.

New NVMe Subsystem QEMU Parameter (See NVMe Specification for details):
        <subsystem>,cmic=BOOLEAN (default: off)

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 hw/nvme/ctrl.c   | 5 ++++-
 hw/nvme/nvme.h   | 1 +
 hw/nvme/subsys.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 518d02dc6670..ddd3ec15d131 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8876,7 +8876,10 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
 
-    id->cmic |= NVME_CMIC_MULTI_CTRL;
+    if (n->subsys->params.cmic) {
+        id->cmic |= NVME_CMIC_MULTI_CTRL;
+    }
+
     ctratt |= NVME_CTRATT_ENDGRPS;
 
     id->endgidmax = cpu_to_le16(0x1);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 6f782ba18826..437b3e64fcfb 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -116,6 +116,7 @@ typedef struct NvmeSubsystem {
             uint16_t nruh;
             uint32_t nrg;
         } fdp;
+        bool         cmic;
     } params;
 } NvmeSubsystem;
 
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 2ae56f12a596..ea6687c7ee6c 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -223,6 +223,7 @@ static const Property nvme_subsystem_props[] = {
                      NVME_DEFAULT_RU_SIZE),
     DEFINE_PROP_UINT32("fdp.nrg", NvmeSubsystem, params.fdp.nrg, 1),
     DEFINE_PROP_UINT16("fdp.nruh", NvmeSubsystem, params.fdp.nruh, 0),
+    DEFINE_PROP_BOOL("cmic", NvmeSubsystem, params.cmic, false),
 };
 
 static void nvme_subsys_class_init(ObjectClass *oc, void *data)
-- 
2.43.5


