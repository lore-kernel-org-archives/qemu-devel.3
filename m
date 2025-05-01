Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF71EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYkn-00057v-CR; Thu, 01 May 2025 14:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uAYkj-00055l-V8; Thu, 01 May 2025 14:35:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uAYki-0007k3-7d; Thu, 01 May 2025 14:35:21 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Hu7rB015674;
 Thu, 1 May 2025 18:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=fgxet
 DfKvpli5uI5Njpy0OHZGnxS42jFj8kIOIbVxQI=; b=XSCwPNPGhtJ4+f3r9zokf
 EAl7XKiFfypvOTLvToNc2vb2gDOD4MmP+It3d6sSkSBGyNNhZ8C/Wx/ZK73jHi8c
 JLo3700WWbWYtDhg7RkvbKkUC7I1tBOJMWdkAF6mrvZIuqRKTMeAqKMppMZqUsdU
 FKVvkpxWcs3hoQnxcZPf9a0ut/Yh9gdOzQRNtFtySU9WidAmkIdU7sY6e3Ac46kM
 w21I1BG6MBXVYdj7Jqhm0eoOcV8zdraLkFh6SJqNvrojhSUc+wka1yPSZadlrnuy
 hF7i6SpHmMPKM3QNQ2xXKMkY2bLM19BW7kWxEETJ3vGpFn5Scx+4TkoixdrlBGPC
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukuqrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 May 2025 18:35:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541Hg6Ul023840; Thu, 1 May 2025 18:35:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxk3vn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 May 2025 18:35:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 541IZ9jY011241;
 Thu, 1 May 2025 18:35:10 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 468nxk3vm2-2; Thu, 01 May 2025 18:35:10 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH v3 1/1] hw/nvme: CMIC.MCTRS should be set automatically for
 multi-controller subsystems or by parameter
Date: Thu,  1 May 2025 11:45:05 -0700
Message-ID: <20250501184505.3630283-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250501184505.3630283-1-alan.adamson@oracle.com>
References: <20250501184505.3630283-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDE0MSBTYWx0ZWRfXx7X+EcUbtGcU
 JP9lV2I8CSbNLij1VSLmeMZsQ0komk5eycU/T0pOV4zv8VLe6o1CxXPDgyGyG6ftf8gfioUWK6V
 6TJ3lkAeJqi41fV47S4YiK93yhv1P+GZq3PAKqmbz1GtTT289syum/A9ekso+emuVulaDOrPjAG
 OIkq/hftf1xSvLCZgvMuVt4IJiBKFb3ei5kmuRU4gItlDmAHWQBKhbnYJF+76A+oAoVX9cxfXr8
 sFD0n2L30Qs4RayQszkrU1B85lRc8MV/vxN8rKIQ6tg3d4vMwikxF3axibzXYy6AswYVqKlZjNG
 Ca7TpmS8xLXLiDCXmCA3NSMMPve91Ed4gq1do4jN2hHjfxAnC/IKNNIGjJkUbfaX1mhXmrdoqei
 WsrvBuz1ENjH4dpRPwp0sNhRBl9GBSq3euYWNmLHyBoiG4XDLkWoskm09tK3gFzHYAUTfa00
X-Proofpoint-GUID: 7bqB08Pd89fajsAPmg_jgOyjUHum3ZIS
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=6813bedf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=YjdARypce4YUJNy7lvIA:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: 7bqB08Pd89fajsAPmg_jgOyjUHum3ZIS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0b-00069f02.pphosted.com
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
index fd935507bc02..72e45f3a7f78 100644
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
index 38271d78c8bd..c644fdf0be5e 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -216,6 +216,7 @@ static const Property nvme_subsystem_props[] = {
                      NVME_DEFAULT_RU_SIZE),
     DEFINE_PROP_UINT32("fdp.nrg", NvmeSubsystem, params.fdp.nrg, 1),
     DEFINE_PROP_UINT16("fdp.nruh", NvmeSubsystem, params.fdp.nruh, 0),
+    DEFINE_PROP_BOOL("cmic.mctrs", NvmeSubsystem, params.cmic_mctrs, false),
 };
 
 static void nvme_subsys_class_init(ObjectClass *oc, const void *data)
-- 
2.43.5


