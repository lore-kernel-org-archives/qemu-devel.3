Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEFFC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uME3s-00009s-Pu; Mon, 02 Jun 2025 18:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uME3p-00007S-Qg; Mon, 02 Jun 2025 18:55:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uME3n-000709-IP; Mon, 02 Jun 2025 18:55:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552LN18B031552;
 Mon, 2 Jun 2025 22:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=1DyXb
 G1GnK+drcNgklmwFuyKTP4bSeDrNTJd9IUnwLo=; b=LAVQP448nZ8F81g5A5Ik9
 V6LiWPzIvdnMQBrgRGAcxiFNz96ccvY/pqNA8WrnW5RpIm4HmL04r/OhmZrFZ/Xo
 LwnqqqI9NAeMyQ/MeeaF0DJM5qhw6MicA+zRVxgLxd+ZyKcixJQRo+lkchgzjWTm
 iaaHZQ4/k9Fs1h5B0G4w/PchT7eR7esRuaYs6FZj0HHtDu5bsgf5WmRlJBzFRxfe
 8EIOiNPxXtu6BLacZWIUu9/AaSeKm4xrfWAPno3bzj5fKZdP/RgxGcMrYQ3ZltCx
 UJNLTGp1UkexjkVPK3p7Hi0+D37jfh1PbgNNzCShde3Cg6L/Ny3h6OmiQ3zgYzf+
 Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwh8h4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 22:55:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 552L7kF9030803; Mon, 2 Jun 2025 22:55:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr78jxw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 22:55:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552Mt3dQ019747;
 Mon, 2 Jun 2025 22:55:05 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46yr78jxs2-3; Mon, 02 Jun 2025 22:55:05 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH 2/2] hw/nvme: add atomic boundary support
Date: Mon,  2 Jun 2025 16:04:58 -0700
Message-ID: <20250602230458.1073148-3-alan.adamson@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=683e2bcb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=T6DPaIb5cbDtP-xAtskA:9 cc=ntf
 awl=host:14714
X-Proofpoint-GUID: rzMMOLKCBqN1MeX65MbWCvyAV-Cg0Lcs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE4OSBTYWx0ZWRfX+WKYQkbhH5vg
 PthFFlBBHmUePXEfS301Avnu+phF0pM6ZWWgPypiqnxf0jyQOd3VH0WN2R9IrjWFoKLy+je3vPy
 QpYvx1f6jNaR3M5Ek34O92T/60VbCPn1t3qZCot9l/WtnDPksCqdE2EzAjlFBACFH8lAgYEUXPi
 CYWPNT5EVdnYZ3DrPeNLGrpFRwNf0UtWdEFyn4OU1V6/BBt/Onz8+9Yn86Q4Tbz6LDNsAjxwfkw
 4I1Ax85CC9hzminH62pU25TF08An2985T3Dv8wuMp4hmpR0VTcTAuP6j5EYkImtxRgUJESyIJg7
 t7bpgnXNOnlvPRVs6py+23qcI6YBeL4Bm0FY0SgjHGHfIKm5LQYiIDCNQXj6thMXZ85kN82hdwJ
 Nl+l7SgBm7hwOHxLDe05pVCH0A5oUTvXy7DpaEhPGMuFCpPXI7hiZwcBwECd4dkY/MCw2uA4
X-Proofpoint-ORIG-GUID: rzMMOLKCBqN1MeX65MbWCvyAV-Cg0Lcs
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

Add support for the namespace atomic boundary paramters: NABO, NABSN, and NABSPF.

Writes that cross an atomic boundary whose size is less than or equal to values
reported by AWUN/AWUPF are guaranteed to be atomic. If AWUN/AWUPF is set to zero,
writes that cross an atomic boundary are not guaranteed to be atomic.

The value reported by NABO field indicates the LBA on this namespace where the
first atomic boundary starts.

New NVMe QEMU Paramters (See NVMe Specification for details):
        atomic.nabo=UINT16 (default: 0)
        atomic.nabsn=UINT16 (default: 0)
        atomic.nabspf=UINT16 (default: 0)

See the NVMe Specification for more information.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 hw/nvme/ctrl.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c   | 36 ++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h |  8 ++++++++
 3 files changed, 97 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a2dd50f3af43..a5a9540a21a5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6709,9 +6709,21 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                 if (n->dn) {
                     ns->atomic.atomic_max_write_size =
                         le16_to_cpu(ns->id_ns.nawupf) + 1;
+                    if (ns->id_ns.nabspf) {
+                        ns->atomic.atomic_boundary =
+                            le16_to_cpu(ns->id_ns.nabspf) + 1;
+                    } else {
+                        ns->atomic.atomic_boundary = 0;
+                    }
                 } else {
                     ns->atomic.atomic_max_write_size =
                         le16_to_cpu(ns->id_ns.nawun) + 1;
+                    if (ns->id_ns.nabsn) {
+                        ns->atomic.atomic_boundary =
+                            le16_to_cpu(ns->id_ns.nabsn) + 1;
+                    } else {
+                        ns->atomic.atomic_boundary = 0;
+                    }
                 }
                 if (ns->atomic.atomic_max_write_size == 1) {
                     ns->atomic.atomic_writes = 0;
@@ -7425,6 +7437,36 @@ static void nvme_update_sq_tail(NvmeSQueue *sq)
     trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
 }
 
+static int nvme_atomic_boundary_check(NvmeCtrl *n, NvmeCmd *cmd,
+    NvmeAtomic *atomic)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+
+    if (atomic->atomic_boundary) {
+        uint64_t slba = le64_to_cpu(rw->slba);
+        uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb);
+        uint64_t elba = slba + nlb;
+        uint64_t imask;
+
+        if ((slba < atomic->atomic_nabo) || (elba < atomic->atomic_nabo)) {
+            return 0;
+        }
+
+        /* Update slba/elba based on boundary offset */
+        slba = slba - atomic->atomic_nabo;
+        elba = slba + nlb;
+
+        imask = ~(atomic->atomic_boundary - 1);
+        if ((slba & imask) != (elba & imask)) {
+            if (n->atomic.atomic_max_write_size &&
+                ((nlb + 1) <= n->atomic.atomic_max_write_size)) {
+                return 1;
+            }
+            return 0;
+        }
+    }
+    return 1;
+}
 #define NVME_ATOMIC_NO_START        0
 #define NVME_ATOMIC_START_ATOMIC    1
 #define NVME_ATOMIC_START_NONATOMIC 2
@@ -7444,6 +7486,15 @@ static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
         cmd_atomic_wr = false;
     }
 
+    /*
+     * Check if a write crosses an atomic boundary.
+     */
+    if (cmd->opcode == NVME_CMD_WRITE) {
+        if (!nvme_atomic_boundary_check(n, cmd, atomic)) {
+            cmd_atomic_wr = false;
+        }
+    }
+
     /*
      * Walk the queues to see if there are any atomic conflicts.
      */
@@ -8523,6 +8574,8 @@ static void nvme_init_state(NvmeCtrl *n)
         } else {
             atomic->atomic_writes = 1;
         }
+        atomic->atomic_boundary = 0;
+        atomic->atomic_nabo = 0;
     }
 }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 28aacb8db59a..86f5ab0a7572 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -747,6 +747,28 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
             error_report("Invalid: NAWUN=%x NAWUPF=%x",
                 id_ns->nawun, id_ns->nawupf);
         }
+        id_ns->nabsn = cpu_to_le16(ns->params.atomic_nabsn);
+        id_ns->nabspf = cpu_to_le16(ns->params.atomic_nabspf);
+        id_ns->nabo = cpu_to_le16(ns->params.atomic_nabo);
+        if (!id->awun || (id_ns->nabsn && ((id_ns->nabsn < id_ns->nawun) ||
+            (id_ns->nabsn < id->awun)))) {
+            error_report("Invalid NABSN: %x NAWUN=%x AWUN=%x",
+                id_ns->nabsn, id_ns->nawun, id->awun);
+        }
+        if (!id->awupf || (id_ns->nabspf && ((id_ns->nabspf < id_ns->nawupf) ||
+            (id_ns->nawupf < id->awupf)))) {
+            error_report("Invalid NABSPF: %x NAWUPF=%x AWUPF=%x",
+                id_ns->nabspf, id_ns->nawupf, id->awupf);
+        }
+        if (id_ns->nabo && ((id_ns->nabo > id_ns->nabsn) ||
+            (id_ns->nabo > id_ns->nabspf))) {
+            error_report("Invalid NABO: %x NABSN=%x NABSPF=%x",
+                id_ns->nabo, id_ns->nabsn, id_ns->nabspf);
+        }
+        if (id_ns->nawupf > id_ns->nawun) {
+            error_report("Invalid: NAWUN=%x NAWUPF=%x", id_ns->nawun,
+                id_ns->nawupf);
+        }
     }
 
     if (id_ns->nawun || id_ns->nawupf) {
@@ -754,14 +776,25 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
         if (n->dn) {
             atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawupf) + 1;
+            if (id_ns->nabspf) {
+                atomic->atomic_boundary = cpu_to_le16(id_ns->nabspf) + 1;
+            } else {
+                atomic->atomic_boundary = 0;
+            }
         } else {
             atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawun) + 1;
+            if (id_ns->nabsn) {
+                atomic->atomic_boundary = cpu_to_le16(id_ns->nabsn) + 1;
+            } else {
+                atomic->atomic_boundary = 0;
+            }
         }
         if (atomic->atomic_max_write_size == 1) {
             atomic->atomic_writes = 0;
         } else {
             atomic->atomic_writes = 1;
         }
+        atomic->atomic_nabo = cpu_to_le16(id_ns->nabo);
     }
 
     /* reparent to subsystem bus */
@@ -841,6 +874,9 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_STRING("fdp.ruhs", NvmeNamespace, params.fdp.ruhs),
     DEFINE_PROP_UINT16("atomic.nawun", NvmeNamespace, params.atomic_nawun, 0),
     DEFINE_PROP_UINT16("atomic.nawupf", NvmeNamespace, params.atomic_nawupf, 0),
+    DEFINE_PROP_UINT16("atomic.nabspf", NvmeNamespace, params.atomic_nabspf, 0),
+    DEFINE_PROP_UINT16("atomic.nabsn", NvmeNamespace, params.atomic_nabsn, 0),
+    DEFINE_PROP_UINT16("atomic.nabo", NvmeNamespace, params.atomic_nabo, 0),
     DEFINE_PROP_BOOL("atomic.nsfeat", NvmeNamespace, params.atomic_nsfeat, 0),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 4ac9bd7e6a25..1045cbf2206e 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -220,11 +220,16 @@ typedef struct NvmeNamespaceParams {
     } fdp;
     uint16_t atomic_nawun;
     uint16_t atomic_nawupf;
+    uint16_t atomic_nabsn;
+    uint16_t atomic_nabspf;
+    uint16_t atomic_nabo;
     bool     atomic_nsfeat;
 } NvmeNamespaceParams;
 
 typedef struct NvmeAtomic {
     uint32_t    atomic_max_write_size;
+    uint64_t    atomic_boundary;
+    uint64_t    atomic_nabo;
     bool        atomic_writes;
 } NvmeAtomic;
 
@@ -285,6 +290,9 @@ typedef struct NvmeNamespace {
     } fdp;
     uint16_t  atomic_nawun;
     uint16_t  atomic_nawupf;
+    uint16_t  atomic_nabsn;
+    uint16_t  atomic_nabspf;
+    uint16_t  atomic_nabo;
     NvmeAtomic  atomic;
 } NvmeNamespace;
 
-- 
2.43.5


