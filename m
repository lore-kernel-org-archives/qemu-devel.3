Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A39CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 05:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stgyW-0005ou-LN; Thu, 26 Sep 2024 01:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1stgyU-0005mc-Pu
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 01:23:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1stgyR-0005wl-NF
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 01:23:34 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240926052326epoutp018e471256da825a4acd63f46ed0198216~4s9okdl1R3171831718epoutp01j
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 05:23:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240926052326epoutp018e471256da825a4acd63f46ed0198216~4s9okdl1R3171831718epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1727328206;
 bh=BV7E1RcZ6RTTMImVJgR4fSD+gghd5R8oeDqVS1kiug8=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Lu02VTEsDPt9D2KLZ+hSFvJ71P+0hxqlo3U6yaJL+R+vwgsygQ/Q2yxFyw/V8yBRc
 JoAMZ3Hb66zVN+zrRbyAdQOpxjmSGBn455SkKL/4TAzR2SdlO8dxv8Qxqg8zgAVvoQ
 PbLo166EMWhlqFQcaCI7A53SVVUK6ZhS9Lib4h94=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20240926052326epcas5p3cea8a0969cd96faaa226068a1c26898c~4s9oLfmbE3153931539epcas5p3x;
 Thu, 26 Sep 2024 05:23:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4XDhp3664rz4x9QG; Thu, 26 Sep
 2024 05:23:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BF.15.09743.BCFE4F66; Thu, 26 Sep 2024 14:23:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20240925061501epcas5p26c161f5c7cae08faa15a8db8391ab417~4aBYU-h8M2274922749epcas5p2o;
 Wed, 25 Sep 2024 06:15:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240925061501epsmtrp2bd74fda0a0a7a72164fa80b07de692ea~4aBYUQQWx2674826748epsmtrp25;
 Wed, 25 Sep 2024 06:15:01 +0000 (GMT)
X-AuditID: b6c32a4a-9e9a3a800000260f-08-66f4efcb423d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BF.81.08456.56AA3F66; Wed, 25 Sep 2024 15:15:01 +0900 (KST)
Received: from open-sourcing.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240925061500epsmtip2752b70d5fa2aebae7b9f10fcf1fa20d4~4aBXS2kdl0508305083epsmtip2T;
 Wed, 25 Sep 2024 06:14:59 +0000 (GMT)
From: Arun Kumar <arun.kka@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Arun Kumar
 <arun.kka@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v2] hw/nvme: i/o cmd set independent namespace data structure
Date: Wed, 25 Sep 2024 06:14:07 +0530
Message-ID: <20240925004407.3521406-1-arun.kka@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmlu7p91/SDLqu61vMuW9hcWJKmMX+
 g99YLU427mG1mHToGqPF8d4dLA5sHlOmXWP3OLfjPLvHplWdbB5Prm1m8ujbsooxgDUq2yYj
 NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
 UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGhx2X
 2QuaTCru3FrD1sB4Rb2LkZNDQsBE4tT5BcxdjFwcQgK7GSXOrXgD5XxilGi+dYwJwvnGKLHp
 wDcmmJbXczeyQyT2Mkr0vWqDaulikuhdO5UVpIpNQF1i7cwdYB0iApISv7tOM4PYzAItjBJH
 VgaC2MIC/hIH1+wGq2cRUJV4vXM2O4jNK2At8Xf2KTaIbfISi3csZ4aIC0qcnPmEBWKOvETz
 1tlgiyUEjrFLnP51iBGiwUVid+skKFtY4tXxLewQtpTE53d7oYbWS5yZuQfqnQ5GiaffoWrs
 JS7u+QsU5wBaoCmxfpc+RFhWYuqpdUwQe/kken8/gWrlldgxD8ZWkri39SfUGAmJOVe+Q53g
 IdGytx/sZiGBWIn+DRfZJjDKz0Lyziwk78xC2LyAkXkVo2RqQXFuemqxaYFRXmo5PGaT83M3
 MYITopbXDsaHDz7oHWJk4mA8xCjBwawkwjvp5sc0Id6UxMqq1KL8+KLSnNTiQ4ymwDCeyCwl
 mpwPTMl5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwsZlxiJ9c
 8k1baLO+CNtlAW6NetnfJuqcgo3Sx5KvrOHNl3/5oSPzSMr77S5dF2puBxRE8W2xdKzbpMh4
 suCieEa3rch6EauK16Lr3W6bzI/7t8wvSnvPln1n55i9uWpuzXDw3fm0C9YP5Kc8/el1LGf1
 5vZZ38WmLQnsr/dcmmKRpp7+Zt/+pmvrN+hcl9Uu+8ypc8lSyembxf93QRUPvxuc030TanxW
 bXcEa7Ry6K7KrUcuX2h12258PcYoPvJ2YPz3WB0h8V83DcJf1PouMvmx7mvn3tNOOw85bd8y
 M9b1Ym5Rk8eiiU+FbR+4qyfqhZb1uCov6JjEMmWRHX9MueTOp4/2dPjYXL7Mv/iNEktxRqKh
 FnNRcSIA+bmARxEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvG7qqs9pBpOPs1rMuW9hcWJKmMX+
 g99YLU427mG1mHToGqPF8d4dLA5sHlOmXWP3OLfjPLvHplWdbB5Prm1m8ujbsooxgDWKyyYl
 NSezLLVI3y6BK+PDjsvsBU0mFXdurWFrYLyi3sXIySEhYCLxeu5G9i5GLg4hgd2MEk3r7jNC
 JCQkfnz5BmULS6z89xyqqINJ4vGWaewgCTYBdYm1M3cwgdgiApISv7tOM4MUMQt0MUpsu3OD
 FSQhLOArcf7YYWYQm0VAVeL1ztlgzbwC1hJ/Z59ig9ggL7F4x3JmiLigxMmZT1hAbGagePPW
 2cwTGPlmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjODi1tHYw7ln1
 Qe8QIxMH4yFGCQ5mJRHeSTc/pgnxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7
 NbUgtQgmy8TBKdXA5DlDRCG2v2h/wo/1DKbPjyg8sph/QOrq1+NGkWudLogsmVK8VufSVT9+
 c5nH2ouOL3miX5Oqb9mZX/3Y8ZLW8envjn3/afFyygWjjQfFoivDtkuci1R6X2EWbLRUw+XU
 8qLo2Z/CPxzpvLRk83b3ye8+ijgxvElWaGmR1vpXeueo/InTKTIeEwWl56069PbalDtvU54w
 9d+NerqhLUPrYsUeq5Jzenw7F6/we6SycHbVLf9wp6Pcoir6Sfnn3vutY5xmutTO96xg5YEb
 8TyuGc3tB+yCQhq/K1hrPGpPWZ798fpVwVfcnsV/xH56GtwoTPw0ue/8069Ze41eN05LeJK7
 z2CFfOuiduXEE/ZtXEosxRmJhlrMRcWJAD2Wd829AgAA
X-CMS-MailID: 20240925061501epcas5p26c161f5c7cae08faa15a8db8391ab417
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240925061501epcas5p26c161f5c7cae08faa15a8db8391ab417
References: <CGME20240925061501epcas5p26c161f5c7cae08faa15a8db8391ab417@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.24; envelope-from=arun.kka@samsung.com;
 helo=mailout1.samsung.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.108, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

add support for i/o command set independent namespace data
structure(cns=8h and cns=1fh)

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Arun Kumar <arun.kka@samsung.com>
---
 hw/nvme/ctrl.c       | 31 +++++++++++++++++++++++++++++++
 hw/nvme/ns.c         |  6 +++++-
 hw/nvme/nvme.h       |  1 +
 hw/nvme/trace-events |  1 +
 include/block/nvme.h | 22 ++++++++++++++++++++--
 5 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..cef2c3fa19 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5498,6 +5498,33 @@ static uint16_t nvme_identify_sec_ctrl_list(NvmeCtrl *n, NvmeRequest *req)
     return nvme_c2h(n, (uint8_t *)&list, sizeof(list), req);
 }
 
+static uint16_t nvme_identify_ns_ind(NvmeCtrl *n, NvmeRequest *req, bool alloc)
+{
+    NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint32_t nsid = le32_to_cpu(c->nsid);
+
+    trace_pci_nvme_identify_ns_ind(nsid);
+
+    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
+        if (alloc) {
+            ns = nvme_subsys_ns(n->subsys, nsid);
+            if (!ns) {
+                return nvme_rpt_empty_id_struct(n, req);
+            }
+        } else {
+            return nvme_rpt_empty_id_struct(n, req);
+        }
+    }
+
+    return nvme_c2h(n, (uint8_t *)&ns->id_ns_ind, sizeof(NvmeIdNsInd), req);
+}
+
 static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
                                      bool active)
 {
@@ -5732,6 +5759,10 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
         return nvme_identify_sec_ctrl_list(n, req);
     case NVME_ID_CNS_CS_NS:
         return nvme_identify_ns_csi(n, req, true);
+    case NVME_ID_CNS_CS_IND_NS:
+        return nvme_identify_ns_ind(n, req, false);
+    case NVME_ID_CNS_CS_IND_NS_ALLOCATED:
+        return nvme_identify_ns_ind(n, req, true);
     case NVME_ID_CNS_CS_NS_PRESENT:
         return nvme_identify_ns_csi(n, req, false);
     case NVME_ID_CNS_CTRL:
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..6dbdcb49bf 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -62,6 +62,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     static uint64_t ns_count;
     NvmeIdNs *id_ns = &ns->id_ns;
     NvmeIdNsNvm *id_ns_nvm = &ns->id_ns_nvm;
+    NvmeIdNsInd *id_ns_ind = &ns->id_ns_ind;
     uint8_t ds;
     uint16_t ms;
     int i;
@@ -75,7 +76,9 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     id_ns->nsfeat |= (0x4 | 0x10);
 
     if (ns->params.shared) {
-        id_ns->nmic |= NVME_NMIC_NS_SHARED;
+        id_ns->nmic |= NVME_ID_NS_IND_NMIC_SHRNS;
+        id_ns_ind->nmic = NVME_ID_NS_IND_NMIC_SHRNS;
+        id_ns_ind->nstat = NVME_ID_NS_IND_NSTAT_NRDY;
     }
 
     /* Substitute a missing EUI-64 by an autogenerated one */
@@ -770,6 +773,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
         subsys->namespaces[nsid] = ns;
 
         ns->id_ns.endgid = cpu_to_le16(0x1);
+        ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
 
         if (ns->params.detached) {
             return;
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..b0268efe84 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -228,6 +228,7 @@ typedef struct NvmeNamespace {
     int64_t      moff;
     NvmeIdNs     id_ns;
     NvmeIdNsNvm  id_ns_nvm;
+    NvmeIdNsInd  id_ns_ind;
     NvmeLBAF     lbaf;
     unsigned int nlbaf;
     size_t       lbasz;
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 3a67680c6a..6be0bfa1c1 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -56,6 +56,7 @@ pci_nvme_identify(uint16_t cid, uint8_t cns, uint16_t ctrlid, uint8_t csi) "cid
 pci_nvme_identify_ctrl(void) "identify controller"
 pci_nvme_identify_ctrl_csi(uint8_t csi) "identify controller, csi=0x%"PRIx8""
 pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_ns_ind(uint32_t nsid) "nsid %"PRIu32""
 pci_nvme_identify_ctrl_list(uint8_t cns, uint16_t cntid) "cns 0x%"PRIx8" cntid %"PRIu16""
 pci_nvme_identify_pri_ctrl_cap(uint16_t cntlid) "identify primary controller capabilities cntlid=%"PRIu16""
 pci_nvme_identify_sec_ctrl_list(uint16_t cntlid, uint8_t numcntl) "identify secondary controller list cntlid=%"PRIu16" numcntl=%"PRIu8""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..47af651354 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1068,6 +1068,7 @@ enum NvmeIdCns {
     NVME_ID_CNS_CS_NS                 = 0x05,
     NVME_ID_CNS_CS_CTRL               = 0x06,
     NVME_ID_CNS_CS_NS_ACTIVE_LIST     = 0x07,
+    NVME_ID_CNS_CS_IND_NS             = 0x08,
     NVME_ID_CNS_NS_PRESENT_LIST       = 0x10,
     NVME_ID_CNS_NS_PRESENT            = 0x11,
     NVME_ID_CNS_NS_ATTACHED_CTRL_LIST = 0x12,
@@ -1077,6 +1078,7 @@ enum NvmeIdCns {
     NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
     NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
     NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
+    NVME_ID_CNS_CS_IND_NS_ALLOCATED   = 0x1f,
 };
 
 typedef struct QEMU_PACKED NvmeIdCtrl {
@@ -1400,6 +1402,20 @@ typedef struct QEMU_PACKED NvmeIdNsNvm {
     uint8_t     rsvd268[3828];
 } NvmeIdNsNvm;
 
+typedef struct QEMU_PACKED NvmeIdNsInd {
+    uint8_t     nsfeat;
+    uint8_t     nmic;
+    uint8_t     rescap;
+    uint8_t     fpi;
+    uint32_t    anagrpid;
+    uint8_t     nsattr;
+    uint8_t     rsvd9;
+    uint16_t    nvmsetid;
+    uint16_t    endgrpid;
+    uint8_t     nstat;
+    uint8_t     rsvd15[4081];
+} NvmeIdNsInd;
+
 typedef struct QEMU_PACKED NvmeIdNsDescr {
     uint8_t nidt;
     uint8_t nidl;
@@ -1420,8 +1436,9 @@ enum NvmeNsIdentifierType {
     NVME_NIDT_CSI               = 0x04,
 };
 
-enum NvmeIdNsNmic {
-    NVME_NMIC_NS_SHARED         = 1 << 0,
+enum NvmeIdNsIndependent {
+    NVME_ID_NS_IND_NMIC_SHRNS   = 0x01,
+    NVME_ID_NS_IND_NSTAT_NRDY   = 0x01,
 };
 
 enum NvmeCsi {
@@ -1854,6 +1871,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsInd) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
-- 
2.43.0


