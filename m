Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0040DCDE038
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 21:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stvvI-0005xr-1p; Thu, 26 Sep 2024 17:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1stvvE-0005qF-P1; Thu, 26 Sep 2024 17:21:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1stvvA-0000nl-Qp; Thu, 26 Sep 2024 17:21:12 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QItbHs007360;
 Thu, 26 Sep 2024 21:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=a
 Lmyj8ObeTbfo5EfzCGgLtUxQ9EPns4zv5edQn1jLtA=; b=l+ovNGbpUAGY3DADk
 EdxP9+Mf+V0EyQBWyIwVITyYOW3K8+H8dBt0mH8dQ81RPVrhSoturEJsJc4Ka3yp
 m+rQZKsqdsi3vWGVFLiIJBTcN+NV0p4pAvPOO6KAZ2+LkVnTTWN59436cOxQIn//
 Zyu4NBKjz4oWTyy5T1QRHpA0hLS0EWnbUyBp1W/WLUVT9oZH8EuSDPcxwka+pVBZ
 dKeq9W9i/Qh7EcbfXOiUMNZnrVfnuN/hSuF4HjJYabeZgzgHB3B5pb8F1fQU5iLP
 XJ7jzyP8wqaEFjIVc0yd92s6Pn5V3MwkfALdTOf9SprF2RCZ+45GKGeFisDIleAZ
 6TBRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cxf9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2024 21:21:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48QJprux009750; Thu, 26 Sep 2024 21:21:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkcej8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2024 21:21:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48QLKwv4030377;
 Thu, 26 Sep 2024 21:21:00 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 41smkcej6j-2; Thu, 26 Sep 2024 21:21:00 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, its@irrelevant.dk,
 qemu-block@nongnu.org
Subject: [PATCH v3 1/1] hw/nvme: add atomic write support
Date: Thu, 26 Sep 2024 14:24:58 -0700
Message-ID: <20240926212458.32449-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240926212458.32449-1-alan.adamson@oracle.com>
References: <20240926212458.32449-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_05,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260150
X-Proofpoint-GUID: wf7jE3XY15lEWGxgcRitLlhD-Tc7uyPT
X-Proofpoint-ORIG-GUID: wf7jE3XY15lEWGxgcRitLlhD-Tc7uyPT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Adds support for the controller atomic parameters: AWUN and AWUPF. Atomic
Compare and Write Unit (ACWU) is not currently supported.

Writes that adhere to the ACWU and AWUPF parameters are guaranteed to be atomic.

New NVMe QEMU Parameters (See NVMe Specification for details):
       atomic.dn (default off) - Set the value of Disable Normal.
       atomic.awun=UINT16 (default: 0)
       atomic.awupf=UINT16 (default: 0)

By default (Disable Normal set to zero), the maximum atomic write size is
set to the AWUN value.  If Disable Normal is set, the maximum atomic write
size is set to AWUPF.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  11 ++++
 2 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 9e94a2405407..c8346709a20d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -40,6 +40,9 @@
  *              sriov_vi_flexible=<N[optional]> \
  *              sriov_max_vi_per_vf=<N[optional]> \
  *              sriov_max_vq_per_vf=<N[optional]> \
+ *              atomic.dn=<on|off[optional]>, \
+ *              atomic.awun<N[optional]>, \
+ *              atomic.awupf<N[optional]>, \
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
@@ -6293,8 +6297,10 @@ defaults:
         if (ret) {
             return ret;
         }
-        goto out;
+        break;
 
+    case NVME_WRITE_ATOMICITY:
+        result = n->dn;
         break;
     default:
         result = nvme_feature_default[fid];
@@ -6378,6 +6384,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t save = NVME_SETFEAT_SAVE(dw10);
     uint16_t status;
     int i;
+    NvmeIdCtrl *id = &n->id_ctrl;
+    NvmeAtomic *atomic = &n->atomic;
 
     trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
 
@@ -6530,6 +6538,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         return NVME_CMD_SEQ_ERROR | NVME_DNR;
     case NVME_FDP_EVENTS:
         return nvme_set_feature_fdp_events(n, ns, req);
+    case NVME_WRITE_ATOMICITY:
+
+        n->dn = 0x1 & dw11;
+
+        if (n->dn) {
+            atomic->atomic_max_write_size = le16_to_cpu(id->awupf) + 1;
+        } else {
+            atomic->atomic_max_write_size = le16_to_cpu(id->awun) + 1;
+        }
+
+        if (atomic->atomic_max_write_size == 1) {
+            atomic->atomic_writes = 0;
+        } else {
+            atomic->atomic_writes = 1;
+        }
+        break;
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -7227,6 +7251,80 @@ static void nvme_update_sq_tail(NvmeSQueue *sq)
     trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
 }
 
+#define NVME_ATOMIC_NO_START        0
+#define NVME_ATOMIC_START_ATOMIC    1
+#define NVME_ATOMIC_START_NONATOMIC 2
+
+static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
+    NvmeAtomic *atomic)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    uint64_t slba = le64_to_cpu(rw->slba);
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb);
+    uint64_t elba = slba + nlb;
+    bool cmd_atomic_wr = true;
+    int i;
+
+    if ((cmd->opcode == NVME_CMD_READ) || ((cmd->opcode == NVME_CMD_WRITE) &&
+        ((rw->nlb + 1) > atomic->atomic_max_write_size))) {
+        cmd_atomic_wr = false;
+    }
+
+    /*
+     * Walk the queues to see if there are any atomic conflicts.
+     */
+    for (i = 1; i < n->params.max_ioqpairs + 1; i++) {
+        NvmeSQueue *sq;
+        NvmeRequest *req;
+        NvmeRwCmd *req_rw;
+        uint64_t req_slba;
+        uint32_t req_nlb;
+        uint64_t req_elba;
+
+        sq = n->sq[i];
+        if (!sq) {
+            continue;
+        }
+
+        /*
+         * Walk all the requests on a given queue.
+         */
+        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
+            req_rw = (NvmeRwCmd *)&req->cmd;
+
+            if (((req_rw->opcode == NVME_CMD_WRITE) || (req_rw->opcode == NVME_CMD_READ)) &&
+                (cmd->nsid == req->ns->params.nsid)) {
+                req_slba = le64_to_cpu(req_rw->slba);
+                req_nlb = (uint32_t)le16_to_cpu(req_rw->nlb);
+                req_elba = req_slba + req_nlb;
+
+                if (cmd_atomic_wr) {
+                    if ((elba >= req_slba) && (slba <= req_elba)) {
+                        return NVME_ATOMIC_NO_START;
+                    }
+                } else {
+                    if (req->atomic_write && ((elba >= req_slba) &&
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
+static NvmeAtomic *nvme_get_atomic(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    if (n->atomic.atomic_writes) {
+        return &n->atomic;
+    }
+    return NULL;
+}
+
 static void nvme_process_sq(void *opaque)
 {
     NvmeSQueue *sq = opaque;
@@ -7243,6 +7341,9 @@ static void nvme_process_sq(void *opaque)
     }
 
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
+        NvmeAtomic *atomic;
+        bool cmd_is_atomic;
+
         addr = sq->dma_addr + (sq->head << NVME_SQES);
         if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
             trace_pci_nvme_err_addr_read(addr);
@@ -7250,6 +7351,26 @@ static void nvme_process_sq(void *opaque)
             stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
             break;
         }
+
+        atomic = nvme_get_atomic(n, &cmd);
+
+        cmd_is_atomic = false;
+        if (sq->sqid && atomic) {
+            int ret;
+
+            ret = nvme_atomic_write_check(n, &cmd, atomic);
+            switch (ret) {
+            case NVME_ATOMIC_NO_START:
+                qemu_bh_schedule(sq->bh);
+                return;
+            case NVME_ATOMIC_START_ATOMIC:
+                cmd_is_atomic = true;
+                break;
+            case NVME_ATOMIC_START_NONATOMIC:
+            default:
+                break;
+            }
+        }
         nvme_inc_sq_head(sq);
 
         req = QTAILQ_FIRST(&sq->req_list);
@@ -7259,6 +7380,10 @@ static void nvme_process_sq(void *opaque)
         req->cqe.cid = cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
+        if (sq->sqid && atomic) {
+            req->atomic_write = cmd_is_atomic;
+        }
+
         status = sq->sqid ? nvme_io_cmd(n, req) :
             nvme_admin_cmd(n, req);
         if (status != NVME_NO_COMPLETE) {
@@ -7362,6 +7487,8 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
     n->outstanding_aers = 0;
     n->qs_created = false;
 
+    n->dn = n->params.atomic_dn; /* Set Disable Normal */
+
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
     if (pci_is_vf(pci_dev)) {
@@ -8138,6 +8265,8 @@ static void nvme_init_state(NvmeCtrl *n)
     NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
+    NvmeAtomic *atomic = &n->atomic;
+    NvmeIdCtrl *id = &n->id_ctrl;
     uint8_t max_vfs;
     int i;
 
@@ -8195,6 +8324,29 @@ static void nvme_init_state(NvmeCtrl *n)
                         cpu_to_le16(n->params.sriov_max_vi_per_vf) :
                         cap->vifrt / MAX(max_vfs, 1);
     }
+
+    /* Atomic Write */
+    id->awun = cpu_to_le16(n->params.atomic_awun);
+    id->awupf = cpu_to_le16(n->params.atomic_awupf);
+    n->dn = n->params.atomic_dn;
+
+    if (id->awun || id->awupf) {
+        if (id->awupf > id->awun) {
+            id->awupf = 0;
+        }
+
+        if (n->dn) {
+            atomic->atomic_max_write_size = id->awupf + 1;
+        } else {
+            atomic->atomic_max_write_size = id->awun + 1;
+        }
+
+        if (atomic->atomic_max_write_size == 1) {
+            atomic->atomic_writes = 0;
+        } else {
+            atomic->atomic_writes = 1;
+        }
+    }
 }
 
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -8734,6 +8886,9 @@ static Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
+    DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
+    DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 781985754d0d..8f46d4860c3c 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -220,6 +220,11 @@ typedef struct NvmeNamespaceParams {
     } fdp;
 } NvmeNamespaceParams;
 
+typedef struct NvmeAtomic {
+    uint32_t    atomic_max_write_size;
+    bool        atomic_writes;
+} NvmeAtomic;
+
 typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
@@ -421,6 +426,7 @@ typedef struct NvmeRequest {
     NvmeCmd                 cmd;
     BlockAcctCookie         acct;
     NvmeSg                  sg;
+    bool                    atomic_write;
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
@@ -538,6 +544,9 @@ typedef struct NvmeParams {
     uint32_t  sriov_max_vq_per_vf;
     uint32_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
+    uint16_t atomic_awun;
+    uint16_t atomic_awupf;
+    bool     atomic_dn;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
@@ -619,6 +628,8 @@ typedef struct NvmeCtrl {
         uint16_t    vqrfap;
         uint16_t    virfap;
     } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset */
+    uint32_t    dn; /* Disable Normal */
+    NvmeAtomic  atomic;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
-- 
2.43.5


