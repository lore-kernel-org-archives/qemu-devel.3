Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922ACC00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 23:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwVzG-0002a6-EO; Mon, 15 Apr 2024 19:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1rwVzB-0002YD-Dq; Mon, 15 Apr 2024 19:43:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1rwVz8-0000YU-IX; Mon, 15 Apr 2024 19:43:41 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43FNEg54018222; Mon, 15 Apr 2024 23:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=9bEqkH4QZib/PZMAJV83iwXlAGQ4QsIIMsLYZSbJyqQ=;
 b=D8OiG0MXFuM8JWK5FKo337uNE+l5VASEYOPo6QdDKmvBBKq6lfFQVwXG2Y7kxOmkjhA8
 nXJFDA2hzvqfF+fVo8oLUs7CsppiL1uf1tG+UdLhl8gR5NMndmw0e4mPfk/Bedzeuknt
 HBIudKeWA3wS7yR9Amjq1s43XRqmlp/BnTFhSQpkBdkWTBl8C07lOD8TGo0MRnaOse56
 pKfmsT5i4EDEMYMQcquSKieG0bjriSplEtuxSkJqsTMUfxtKz1OqJxHyLg74pKxWg+3R
 fNQHjQTDmcwbiXbUsuSD2AAZ6sL0h2B9AhgM1nVjfq7NiWd3WCwFG9FuJ2zDxsyEKSlE iQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv3xpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 23:43:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43FMa6Bx005046; Mon, 15 Apr 2024 23:43:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xfggcquja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 23:43:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FNhQpe021896;
 Mon, 15 Apr 2024 23:43:29 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3xfggcqucj-2; Mon, 15 Apr 2024 23:43:28 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, its@irrelevant.dk,
 qemu-block@nongnu.org
Subject: [RFC 1/1] hw/nvme: add atomic write support
Date: Mon, 15 Apr 2024 16:46:39 -0700
Message-Id: <20240415234639.3021291-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240415234639.3021291-1-alan.adamson@oracle.com>
References: <20240415234639.3021291-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_19,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150159
X-Proofpoint-ORIG-GUID: aSvOcMVvGXGz79gFcXugqMqqSohLGmhQ
X-Proofpoint-GUID: aSvOcMVvGXGz79gFcXugqMqqSohLGmhQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Forces writes to be atomic based on new atomic write parameters.

New NVMe QEMU Parameters (See NVMe Specification for details):
        atomic.dn (default off) - Set the value of Disable Normal.
        atomic.awun=UINT16 (default: 0)
        atomic.awupf=UINT16 (default: 0)
        atomic.acwu=UINT16 (default: 0)

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 hw/nvme/ctrl.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  17 ++++++
 2 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d238346..5d19965122d0 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -40,6 +40,9 @@
  *              sriov_vi_flexible=<N[optional]> \
  *              sriov_max_vi_per_vf=<N[optional]> \
  *              sriov_max_vq_per_vf=<N[optional]> \
+ *              atomic.awun<N[optional]>, \
+ *              atomic.awupf<N[optional]>, \
+ *              atomic.acwu<N[optional]>, \
  *              subsys=<subsys_id>
  *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
  *              zoned=<true|false[optional]>, \
@@ -254,6 +257,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
     [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
+    [NVME_WRITE_ATOMICITY]          = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
     [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
     [NVME_HOST_BEHAVIOR_SUPPORT]    = NVME_FEAT_CAP_CHANGE,
@@ -6071,6 +6075,9 @@ defaults:
         }
         goto out;
 
+        break;
+    case NVME_WRITE_ATOMICITY:
+        result = n->dn;
         break;
     default:
         result = nvme_feature_default[fid];
@@ -6154,6 +6161,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t save = NVME_SETFEAT_SAVE(dw10);
     uint16_t status;
     int i;
+    NvmeIdCtrl *id = &n->id_ctrl;
+    NvmeAtomic *atomic = &n->atomic;
 
     trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
 
@@ -6306,6 +6315,21 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         return NVME_CMD_SEQ_ERROR | NVME_DNR;
     case NVME_FDP_EVENTS:
         return nvme_set_feature_fdp_events(n, ns, req);
+    case NVME_WRITE_ATOMICITY:
+
+        /*
+         * Since NAWUN and NAWUPF are not currently supported, this
+         * has no affect.
+         */
+        n->dn = 0x1 & dw11;
+
+        if (n->dn) {
+            atomic->atomic_max_write_size = id->awupf + 1;
+        } else {
+            atomic->atomic_max_write_size = id->awun + 1;
+        }
+
+        break;
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -7003,16 +7027,76 @@ static void nvme_update_sq_tail(NvmeSQueue *sq)
     trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
 }
 
+#define NVME_ATOMIC_NO_START        0
+#define NVME_ATOMIC_START_ATOMIC    1
+#define NVME_ATOMIC_START_NONATOMIC 2
+
+static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd, NvmeAtomic *atomic)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    uint64_t slba = le64_to_cpu(rw->slba);
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb);
+    uint64_t elba = slba + nlb;
+    bool cmd_atomic_wr = 1;
+    int i;
+
+    if ((cmd->opcode == NVME_CMD_READ) || ((cmd->opcode == NVME_CMD_WRITE) &&
+        ((rw->nlb + 1) > atomic->atomic_max_write_size))) {
+        cmd_atomic_wr = 0;
+    }
+
+    for (i = 1; i < n->params.max_ioqpairs + 1; i++) {
+        NvmeSQueue *sq;
+        NvmeRequest *r;
+        NvmeRwCmd *req_rw;
+        uint64_t req_slba;
+        uint32_t req_nlb;
+        uint64_t req_elba;
+
+        sq = n->sq[i];
+        if (!sq) {
+            break;
+        }
+
+        QTAILQ_FOREACH(r, &sq->out_req_list, entry) {
+            req_rw = (NvmeRwCmd *)&r->cmd;
+
+            if (cmd->nsid == r->ns->params.nsid) {
+                req_slba = le64_to_cpu(req_rw->slba);
+                req_nlb = (uint32_t)le16_to_cpu(req_rw->nlb);
+                req_elba = req_slba + req_nlb;
+
+                if (cmd_atomic_wr) {
+                    if ((elba >= req_slba) && (slba <= req_elba)) {
+                        return NVME_ATOMIC_NO_START;
+                    }
+                } else {
+                    if (r->atomic_write && ((elba >= req_slba) &&
+                        (slba <= req_elba))) {
+                        return NVME_ATOMIC_NO_START;
+                    }
+                }
+            }
+        }
+    }
+    if (cmd_atomic_wr) {
+        return NVME_ATOMIC_START_ATOMIC;
+    }
+    return NVME_ATOMIC_START_NONATOMIC;
+}
+
 static void nvme_process_sq(void *opaque)
 {
     NvmeSQueue *sq = opaque;
     NvmeCtrl *n = sq->ctrl;
     NvmeCQueue *cq = n->cq[sq->cqid];
-
+    NvmeAtomic *atomic = &n->atomic;
     uint16_t status;
     hwaddr addr;
     NvmeCmd cmd;
     NvmeRequest *req;
+    int ret;
+    bool set_atomic = 0;
 
     if (n->dbbuf_enabled) {
         nvme_update_sq_tail(sq);
@@ -7026,6 +7110,23 @@ static void nvme_process_sq(void *opaque)
             stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
             break;
         }
+
+        if (sq->sqid && atomic->atomic_writes) {
+            qemu_mutex_lock(&atomic->atomic_lock);
+            ret = nvme_atomic_write_check(n, &cmd, atomic);
+            switch (ret) {
+            case NVME_ATOMIC_NO_START:
+                qemu_bh_schedule(sq->bh);
+                qemu_mutex_unlock(&atomic->atomic_lock);
+                return;
+            case NVME_ATOMIC_START_ATOMIC:
+                set_atomic = 1;
+                break;
+            case NVME_ATOMIC_START_NONATOMIC:
+            default:
+                break;
+            }
+        }
         nvme_inc_sq_head(sq);
 
         req = QTAILQ_FIRST(&sq->req_list);
@@ -7035,6 +7136,11 @@ static void nvme_process_sq(void *opaque)
         req->cqe.cid = cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
+        if (atomic->atomic_writes) {
+            req->atomic_write = set_atomic;
+            qemu_mutex_unlock(&atomic->atomic_lock);
+        }
+
         status = sq->sqid ? nvme_io_cmd(n, req) :
             nvme_admin_cmd(n, req);
         if (status != NVME_NO_COMPLETE) {
@@ -7138,6 +7244,8 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
     n->outstanding_aers = 0;
     n->qs_created = false;
 
+    n->dn = n->params.atomic_dn; /* Set Disable Normal */
+
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
     if (pci_is_vf(pci_dev)) {
@@ -8191,6 +8299,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint8_t *pci_conf = pci_dev->config;
     uint64_t cap = ldq_le_p(&n->bar.cap);
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
+    NvmeAtomic *atomic = &n->atomic;
     uint32_t ctratt;
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
@@ -8298,6 +8407,38 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     if (pci_is_vf(pci_dev) && !sctrl->scs) {
         stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
     }
+
+    /* Atomic Write */
+    id->awun = n->params.atomic_awun;
+    id->awupf = n->params.atomic_awupf;
+    if (n->params.atomic_acwu) { /* ACWU is currently not supported */
+        printf("Atomic Paramters: ACWU is not supported\n");
+        id->acwu = 0;
+    }
+    n->dn = n->params.atomic_dn;
+
+    if (id->awun || id->awupf) {
+        if (id->awupf > id->awun) {
+            printf("    AWUPF must be <= to AWUN: Setting AWUPF to %d\n",
+                id->awun);
+            id->awupf = id->awun;
+        }
+
+        if (n->dn) {
+            atomic->atomic_max_write_size = id->awupf + 1;
+        } else {
+            atomic->atomic_max_write_size = id->awun + 1;
+        }
+
+        if (atomic->atomic_max_write_size == 1)
+            atomic->atomic_writes = 0;
+        else {
+            qemu_mutex_init(&atomic->atomic_lock);
+            atomic->atomic_writes = 1;
+        }
+    }
+    printf("Atomic Paramters: AWUN=%d  AWUPF=%d ACWU=%d DN=%d\n",
+        id->awun, id->awupf, id->acwu, n->dn);
 }
 
 static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
@@ -8451,6 +8592,10 @@ static Property nvme_props[] = {
                       params.sriov_max_vq_per_vf, 0),
     DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
                      false),
+    DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
+    DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
+    DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
+    DEFINE_PROP_UINT16("atomic.acwu", NvmeCtrl, params.atomic_acwu, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5fd..66d89bc4bbfb 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -220,6 +220,12 @@ typedef struct NvmeNamespaceParams {
     } fdp;
 } NvmeNamespaceParams;
 
+typedef struct NvmeAtomic {
+    uint32_t    atomic_max_write_size;
+    QemuMutex   atomic_lock;
+    bool        atomic_writes;
+} NvmeAtomic;
+
 typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
@@ -272,6 +278,10 @@ typedef struct NvmeNamespace {
         /* reclaim unit handle identifiers indexed by placement handle */
         uint16_t *phs;
     } fdp;
+    bool     atomic_dn;
+    uint16_t  atomic_awun;
+    uint16_t  atomic_awupf;
+    uint16_t  atomic_acwu;
 } NvmeNamespace;
 
 static inline uint32_t nvme_nsid(NvmeNamespace *ns)
@@ -421,6 +431,7 @@ typedef struct NvmeRequest {
     NvmeCmd                 cmd;
     BlockAcctCookie         acct;
     NvmeSg                  sg;
+    bool                    atomic_write;
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
@@ -537,6 +548,10 @@ typedef struct NvmeParams {
     uint8_t  sriov_max_vq_per_vf;
     uint8_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
+    uint16_t atomic_awun;
+    uint16_t atomic_awupf;
+    uint16_t atomic_acwu;
+    bool     atomic_dn;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
@@ -617,6 +632,8 @@ typedef struct NvmeCtrl {
         uint16_t    vqrfap;
         uint16_t    virfap;
     } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset */
+    uint32_t    dn; /* Disable Normal */
+    NvmeAtomic  atomic;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
-- 
2.39.3


