Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA44AC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uME3s-00009n-CF; Mon, 02 Jun 2025 18:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uME3q-00007T-5R; Mon, 02 Jun 2025 18:55:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uME3n-000705-Ik; Mon, 02 Jun 2025 18:55:17 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552LN00S026929;
 Mon, 2 Jun 2025 22:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=gBBuB
 8NIIMrPHOFxQE2b5PdnS1sob6G9rKlUY0tfH98=; b=aEOFgtFhJPac8XaNtD5ib
 KXiMl/PuQy0tSdDVnzH9D2AgmeyqLd3xaumjg2ADqfKz6Ll2JBUdwlylvQd6nuH2
 U8VkNfPhN83FvyCU6xdU62FLyDx8on69YOHMCcWYr9UN1d0KyHSFfHYEGhHhiFLf
 0+wKuxMLFqM2hw9UhuwJhyVLUF38jtEKznjNo5R1bL0aaEox2rLA+GrjnRqsj6ly
 fMsFRFmDKLtDMp3OOUBeB0Jj9LT7vrXDkYw2k3FhLi1wYbKGYOXU0ovNhLfWHzla
 m0DRnVuZ2yuRjuffA3ZKhdtxfBKknxxNG7n0BayCOOo4ifIlUNBf10lOQcMrDwfS
 A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8k8mcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 22:55:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 552LFCpZ030714; Mon, 2 Jun 2025 22:55:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr78jxvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 22:55:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552Mt3dO019747;
 Mon, 2 Jun 2025 22:55:04 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46yr78jxs2-2; Mon, 02 Jun 2025 22:55:04 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH 1/2] hw/nvme: enable ns atomic writes
Date: Mon,  2 Jun 2025 16:04:57 -0700
Message-ID: <20250602230458.1073148-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250602230458.1073148-1-alan.adamson@oracle.com>
References: <20250602230458.1073148-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_08,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020189
X-Proofpoint-GUID: lTcxn0Es8gOmy37Ycy_V_bNYJdmj8dM9
X-Proofpoint-ORIG-GUID: lTcxn0Es8gOmy37Ycy_V_bNYJdmj8dM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE4OSBTYWx0ZWRfXyCDsW2jQGGiU
 ztRNvl6yOCwTAIgVjYrHmSw/RWH9kse7GLI9NXFkrm1wWeXhUeQ5KGmX72x4Lg0PpzZVffuwo1u
 30wYGt+jc8zHxzSVGEEqiVdzksE1ML1/WJVqW5RcS6Php1Q/O4rySKReV43xVTJzEbVUyydwrNY
 1QizjF27cmGvg4JSKz3hs7E9OoJHtYJdgns2IevMeDj4QznYwOM7RbeWTZTaeDOPD64r/R4a1Nh
 vqH/gvFvJh2njbJLSr1uu0l/taW9JAc4+d1zftmhSX5OsCnKFNjkPqbdsfqnaXNe+vWeTiu+35U
 W0ImDRHbFp+fOw/zKVJgjWVRpYETVwJHdypFTjHIQzzUUcp0ZFeUjdA4dgAVaiYIxR+EQ/4fV3t
 WWrA92GobfdHI51nlaFslDNX6Nb16la9bpiZacEAIAcfH7rY1qrqcprxiij2QctqyDD9DIRF
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=683e2bca b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=gGF3E1kH2P8b_CMGT_gA:9 cc=ntf
 awl=host:14714
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add support for the namespace atomic paramters: NAWUN and NAWUN. Namespace
Atomic Compare and Write Unit (NACWU) is not currently supported.

Writes that adhere to the NACWU and NAWUPF parameters are guaranteed to be
atomic.

New NVMe QEMU Paramters (See NVMe Specification for details):
        atomic.nawun=UINT16 (default: 0)
        atomic.nawupf=UINT16 (default: 0)
        atomic.nsfeat (default off) - Set Namespace Supported Atomic Boundary &
                Power (NSABP) bit in Namespace Features (NSFEAT) in the Identify
                Namespace Data Structure

See the NVMe Specification for more information.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 hw/nvme/ctrl.c | 23 +++++++++++++++++++++++
 hw/nvme/ns.c   | 38 ++++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h |  6 ++++++
 3 files changed, 67 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd935507bc02..a2dd50f3af43 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6703,6 +6703,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         } else {
             atomic->atomic_writes = 1;
         }
+        for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+            ns = nvme_ns(n, i);
+            if (ns && ns->atomic.atomic_writes) {
+                if (n->dn) {
+                    ns->atomic.atomic_max_write_size =
+                        le16_to_cpu(ns->id_ns.nawupf) + 1;
+                } else {
+                    ns->atomic.atomic_max_write_size =
+                        le16_to_cpu(ns->id_ns.nawun) + 1;
+                }
+                if (ns->atomic.atomic_max_write_size == 1) {
+                    ns->atomic.atomic_writes = 0;
+                } else {
+                    ns->atomic.atomic_writes = 1;
+                }
+            }
+        }
         break;
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
@@ -7477,6 +7494,12 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
 
 static NvmeAtomic *nvme_get_atomic(NvmeCtrl *n, NvmeCmd *cmd)
 {
+    NvmeNamespace *ns = nvme_ns(n, cmd->nsid);
+
+    if (ns && ns->atomic.atomic_writes) {
+        return &ns->atomic;
+    }
+
     if (n->atomic.atomic_writes) {
         return &n->atomic;
     }
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 6df2e8e7c5ac..28aacb8db59a 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -724,11 +724,46 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     BusState *s = qdev_get_parent_bus(dev);
     NvmeCtrl *n = NVME(s->parent);
     NvmeSubsystem *subsys = n->subsys;
+    NvmeIdCtrl *id = &n->id_ctrl;
+    NvmeIdNs *id_ns = &ns->id_ns;
     uint32_t nsid = ns->params.nsid;
     int i;
 
     assert(subsys);
 
+    /* Set atomic write parameters */
+    if (ns->params.atomic_nsfeat) {
+        id_ns->nsfeat |= NVME_ID_NS_NSFEAT_NSABPNS;
+        id_ns->nawun = cpu_to_le16(ns->params.atomic_nawun);
+        if (!id->awupf || (id_ns->nawun && (id_ns->nawun < id->awun))) {
+            error_report("Invalid NAWUN: %x AWUN=%x", id_ns->nawun, id->awun);
+        }
+        id_ns->nawupf = cpu_to_le16(ns->params.atomic_nawupf);
+        if (!id->awupf || (id_ns->nawupf && (id_ns->nawupf < id->awupf))) {
+            error_report("Invalid NAWUPF: %x AWUPF=%x",
+                id_ns->nawupf, id->awupf);
+        }
+        if (id_ns->nawupf > id_ns->nawun) {
+            error_report("Invalid: NAWUN=%x NAWUPF=%x",
+                id_ns->nawun, id_ns->nawupf);
+        }
+    }
+
+    if (id_ns->nawun || id_ns->nawupf) {
+        NvmeAtomic *atomic = &ns->atomic;
+
+        if (n->dn) {
+            atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawupf) + 1;
+        } else {
+            atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawun) + 1;
+        }
+        if (atomic->atomic_max_write_size == 1) {
+            atomic->atomic_writes = 0;
+        } else {
+            atomic->atomic_writes = 1;
+        }
+    }
+
     /* reparent to subsystem bus */
     if (!qdev_set_parent_bus(dev, &subsys->bus.parent_bus, errp)) {
         return;
@@ -804,6 +839,9 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_BOOL("eui64-default", NvmeNamespace, params.eui64_default,
                      false),
     DEFINE_PROP_STRING("fdp.ruhs", NvmeNamespace, params.fdp.ruhs),
+    DEFINE_PROP_UINT16("atomic.nawun", NvmeNamespace, params.atomic_nawun, 0),
+    DEFINE_PROP_UINT16("atomic.nawupf", NvmeNamespace, params.atomic_nawupf, 0),
+    DEFINE_PROP_BOOL("atomic.nsfeat", NvmeNamespace, params.atomic_nsfeat, 0),
 };
 
 static void nvme_ns_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index b5c9378ea4e5..4ac9bd7e6a25 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -218,6 +218,9 @@ typedef struct NvmeNamespaceParams {
     struct {
         char *ruhs;
     } fdp;
+    uint16_t atomic_nawun;
+    uint16_t atomic_nawupf;
+    bool     atomic_nsfeat;
 } NvmeNamespaceParams;
 
 typedef struct NvmeAtomic {
@@ -280,6 +283,9 @@ typedef struct NvmeNamespace {
         /* reclaim unit handle identifiers indexed by placement handle */
         uint16_t *phs;
     } fdp;
+    uint16_t  atomic_nawun;
+    uint16_t  atomic_nawupf;
+    NvmeAtomic  atomic;
 } NvmeNamespace;
 
 static inline uint32_t nvme_nsid(NvmeNamespace *ns)
-- 
2.43.5


