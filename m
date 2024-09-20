Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98652CF58D1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 05:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srWZE-0003G2-P5; Fri, 20 Sep 2024 01:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1srWZC-0003F2-1G
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 01:52:30 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1srWZ4-00019W-GV
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 01:52:29 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240920055208epoutp03068afd0db8c887f769712739e4b3c4bf~23e_PgpJF2245122451epoutp03G
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 05:52:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240920055208epoutp03068afd0db8c887f769712739e4b3c4bf~23e_PgpJF2245122451epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1726811528;
 bh=zxDmW650ragi6F5bfWNJG22gPqEr8vW+e7YaghobuCY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=CAJjRJ3dUD0SojJxQY0X6JbejOpeIl6BL4ZHtF0fDPg0WUJ+LPMoSrtp0BmmEjZ3Q
 whNbiz8/mSOookuRS0cQPu53uCuhFF/nrGq4Nm1BkpublxWwSaujp1bO38uG1gnUMM
 GG6kv+fERdpQ4kV/xxdpjlifx2U6OVVcNFq2t+mU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20240920055207epcas5p18ba40b296b8083afff4fbdf22623005f~23e977VcD2727527275epcas5p1c;
 Fri, 20 Sep 2024 05:52:07 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4X91jy18Fgz4x9QD; Fri, 20 Sep
 2024 05:52:06 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D8.A9.19863.68D0DE66; Fri, 20 Sep 2024 14:52:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20240920055116epcas5p248fe98a4d8d9de8eddfaa4cfe85b4424~23eNyU8aW1054210542epcas5p2g;
 Fri, 20 Sep 2024 05:51:16 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240920055116epsmtrp2ce9e07c79bfe01b39cbeb9871671c2c5~23eNxtLf82097620976epsmtrp2p;
 Fri, 20 Sep 2024 05:51:16 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-71-66ed0d86f1ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A2.F4.19367.35D0DE66; Fri, 20 Sep 2024 14:51:15 +0900 (KST)
Received: from open-sourcing.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240920055114epsmtip142d5933aad1926cb2460823414c5451b~23eMQa87M2038620386epsmtip1E;
 Fri, 20 Sep 2024 05:51:14 +0000 (GMT)
From: Arun Kumar <arun.kka@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Arun Kumar
 <arun.kka@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH] hw/nvme: i/o cmd set independent namespace data structure
Date: Fri, 20 Sep 2024 05:51:16 +0530
Message-ID: <20240920002116.3494712-1-arun.kka@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmhm4b79s0g1272Szm3LewODElzGL/
 wW+sFicb97BaTDp0jdHieO8OFgc2jynTrrF7nNtxnt1j06pONo8n1zYzefRtWcUYwBqVbZOR
 mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
 KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj9dKb
 TAVn1Cre7N3E2sD4WLaLkZNDQsBE4tT/o0xdjFwcQgJ7GCVO7ZvAAuF8YpRoW7uSHcE52c8K
 07Jy8TWoqp2MEgc+PYKq6mKSaHi5kQ2kik1AXWLtzB1MILaIgKTE767TzCA2s0ALo8SRlYEg
 trCAl8TvzYfA6lkEVCXWvzgHtoFXwFriT/sGZoht8hKLdyxnhogLSpyc+YQFYo68RPPW2cwg
 iyUEDrFL7L5wnQ2iwUXiwN0zTBC2sMSr41vYIWwpic/v9kLV1EucmbkHqqaDUeLpd6gae4mL
 e/4CxTmAFmhKrN+lDxGWlZh6ah0TxF4+id7fT6BaeSV2zIOxlSTubf0JNUZCYs6V74wQtofE
 9z9nweJCArESy5feZ5nAKD8LyTuzkLwzC2HzAkbmVYxSqQXFuempyaYFhrp5qeXwqE3Oz93E
 CE6JWgE7GFdv+Kt3iJGJg/EQowQHs5IIr/iHl2lCvCmJlVWpRfnxRaU5qcWHGE2BgTyRWUo0
 OR+YlPNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamByTki4sNxW
 p21ubJPQqTIPpfa6PZVueatafqxXmGGz+cppzYO9XLaaSy3OFv7f8uGKTLyE4DeHrpsV2uH/
 zmfLSDcYemhMiJnlXibav39+nIuPuVr1a4a90Q8bvyeUsKzfY6RaEBNj/+3X8eCtan+6+OQd
 bWuXGL5K4IiqstHg3ZuS2fU02/b0oxtVZbu2LDzWqTNtqVfVnMsO0pZ+a296cB9UPezGc2+t
 Bv/7qkMi23elbNwy573lm+qnRR83Xz0430OWWUT8k+qtxPIUQ2v2/Xw/fD77Ce2InRoteqL5
 nPGEL2eeRS/+EX0oszpz6tFVrCVLzkib3drxYdk13+r1Ku5zD7wVmRj26HaSa4wSS3FGoqEW
 c1FxIgCPs+EAEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnG4w79s0g2uLLS3m3LewODElzGL/
 wW+sFicb97BaTDp0jdHieO8OFgc2jynTrrF7nNtxnt1j06pONo8n1zYzefRtWcUYwBrFZZOS
 mpNZllqkb5fAlfF66U2mgjNqFW/2bmJtYHws28XIySEhYCKxcvE1li5GLg4hge2MEo/vtLNB
 JCQkfnz5xghhC0us/PecHaKog0miZeslFpAEm4C6xNqZO5hAbBEBSYnfXaeZQYqYBboYJbbd
 ucEKkhAW8JL4vfkQ2FQWAVWJ9S/OgcV5Bawl/rRvYIbYIC+xeMdyZoi4oMTJmU/AFjADxZu3
 zmaewMg3C0lqFpLUAkamVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjBQakVtINx2fq/eocY
 mTgYDzFKcDArifCKf3iZJsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1
 CCbLxMEp1cAUv+mwfvI2JxeBa7qzjlntLj5e0bCDX/uD/dsXB94c8P4g1Zm000uX6XxESMrm
 3YYdij/Wt82/cqYim29mufmiuNL9q5TTN+gfmpjTHcnedEeEw/ON5K7I7vSsBE35SRO2lcbM
 DhIXaYnJlpvOceborjey9adUfn7bU1Cz02jHY/OEk9V+kqXJWvNq13/lWFtcsXrujrCl0deq
 dOY1v1ao3P7g4SUpC1uv73f8ik1DnKv0TJ8L3FE/5Pvwuv23ZZ/8l+4q7QzSzjuy0fjjsn2h
 pqbc+avubzp2vq7qyD/rvkanZfFyzzer75c42XXgx/Vbep2Btmaf+m0O5bYJrgqviyo0+bvt
 hcsmU86u8AIlluKMREMt5qLiRABxN3/MuQIAAA==
X-CMS-MailID: 20240920055116epcas5p248fe98a4d8d9de8eddfaa4cfe85b4424
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240920055116epcas5p248fe98a4d8d9de8eddfaa4cfe85b4424
References: <CGME20240920055116epcas5p248fe98a4d8d9de8eddfaa4cfe85b4424@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.33; envelope-from=arun.kka@samsung.com;
 helo=mailout3.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

add support for i/o command set independent namespace data
structure(cns=8h and cns=1fh)

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Arun Kumar <arun.kka@samsung.com>
---
 hw/nvme/ctrl.c       | 37 +++++++++++++++++++++++++++++++++++++
 hw/nvme/trace-events |  1 +
 include/block/nvme.h | 17 +++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..73af48591d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5498,6 +5498,39 @@ static uint16_t nvme_identify_sec_ctrl_list(NvmeCtrl *n, NvmeRequest *req)
     return nvme_c2h(n, (uint8_t *)&list, sizeof(list), req);
 }
 
+static uint16_t nvme_identify_ns_ind(NvmeCtrl *n, NvmeRequest *req, bool alloc)
+{
+    NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint32_t nsid = le32_to_cpu(c->nsid);
+    NvmeIdNsIndependent id;
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
+    id = (NvmeIdNsIndependent) {
+        .nmic = ns->params.shared ? NVME_NMIC_NS_SHARED : 0x0,
+        .nstat = 0x1,
+    };
+
+    return nvme_c2h(n, &id, sizeof(id), req);
+}
+
 static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
                                      bool active)
 {
@@ -5732,6 +5765,10 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
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
index bb231d0b9a..2ca9c964aa 100644
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
 
+typedef struct QEMU_PACKED NvmeIdNsIndependent {
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
+} NvmeIdNsIndependent;
+
 typedef struct QEMU_PACKED NvmeIdNsDescr {
     uint8_t nidt;
     uint8_t nidl;
@@ -1854,6 +1870,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsIndependent) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
-- 
2.43.0


