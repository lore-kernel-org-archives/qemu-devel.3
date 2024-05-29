Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E50C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIuz-0004M4-DV; Wed, 29 May 2024 09:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIus-0004Df-TR
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:00:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIuo-0001hh-Kc
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:00:30 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240529125358epoutp01b422dbd3722fe3a81e509b966b3eaec7~T9sv48NzW1385513855epoutp01T
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:53:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240529125358epoutp01b422dbd3722fe3a81e509b966b3eaec7~T9sv48NzW1385513855epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716987238;
 bh=URd0ET0qY4qruNePzvnDDejkpybUORKzBqsq3dIXZCM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R6Tn6UG+n3ZxfHLafoyjtajh04BsqkCCm9Pr2fGh/8/UHyNK82FiAygHYMezJ7SEm
 zZdIAJjzmDTR4Etuc7zB0ipfjfc9YFABIWEKBV9dQZn1TAUDk6E0ablXs+enFUYY3w
 4ySamIUMkYoPU/1ehQKJFz3AfOtBiElWHzQmNLoo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240529125358epcas2p43936e4f19b8814465abf88ba9db1af59~T9svUIQKQ0605506055epcas2p4x;
 Wed, 29 May 2024 12:53:58 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Vq8TK4g7Sz4x9Pq; Wed, 29 May
 2024 12:53:57 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.D3.09485.56527566; Wed, 29 May 2024 21:53:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epcas2p12f9e62a58081d18c6ff30753f6ba22cf~T9suGMrHq0515505155epcas2p12;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240529125356epsmtrp23f41c0cd231c302199ab37005905b9dd~T9suD1Yy31667216672epsmtrp2C;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
X-AuditID: b6c32a46-19bfa7000000250d-16-66572565bb6d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 F8.3A.18846.46527566; Wed, 29 May 2024 21:53:56 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epsmtip267f1d58f930413614f77bcc258bb8c40~T9st2fbY11461914619epsmtip2O;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, minwoo.im@samsung.com,
 gost.dev@samsung.com
Subject: [PATCH v4 2/4] hw/nvme: separate identify data for sec. ctrl list
Date: Wed, 29 May 2024 21:42:32 +0900
Message-Id: <20240529124234.1430707-3-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529124234.1430707-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTTDdVNTzN4NprJYsTU8Isbh7YyWSx
 /+A3VotJh64xWjw7fYDZYta7djaL4707WBzYPaZMu8bucW7HeXaPTas62TyeXNvM5NG3ZRVj
 AGtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0BlK
 CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DC
 hOyMC4vWsBb8Nq44cuUIawPjP7UuRg4OCQETiXMb7LsYuTiEBHYwSuyaM5MZwvnEKPFp6kwW
 OOdm/xz2LkZOsI7vH04yQiR2MkrMOrqZDcL5zShxd9kuFpAqNgF1iYapr8BsEYEcif6V35lA
 bGaBeInnK36ATRIW8JLYvGMDG4jNIqAq8XHZemYQm1fARmL/5mZGiG3yEvsPngWLcwrYSnTN
 ecMOUSMocXLmExaImfISzVtnM0PU32OX2LiuDsJ2kVjZ9hpqjrDEq+NboD6Qkvj8bi8bhF0u
 8fPNJKiaComDs26zQcLFXuLa8xQQk1lAU2L9Ln2IqLLEkVtQS/kkOg7/ZYcI80p0tAlBzFCW
 +HjoENQtkhLLL72G2uMhsennA2jYTmCU2PLjIdMERoVZSH6ZheSXWQiLFzAyr2IUSy0ozk1P
 LTYqMIJHb3J+7iZGcJrUctvBOOXtB71DjEwcjIcYJTiYlUR4z0wKTRPiTUmsrEotyo8vKs1J
 LT7EaAoM6YnMUqLJ+cBEnVcSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8T
 B6dUA9PWthZBy76SRQfncl6zfC9VduhQdrtjAoe0YpnSpAmx07zMOg01Pb2+a736MO3gf9en
 D1dNs7jMdfhxPvuJX1fO73Kp/cdbvt/1wZZ5wce7F2c2JzfbsKez8cRzbajaznL47PZk9RSf
 BSbX13fdsW3QfOT2dImtkb7T5iPqoSJSpl5iTuvnpLXKX1mg/kSqI+Pk6fTm/x84OtKWVcRt
 WeM817zJ9kStrf6aySxa0deN93PorvgnqJQ+uU712pvYYJP3P1epvl7I+mHxtDXXr/dvtPIq
 +iN7zDFmlfa71DgT6/gYBaPrjEsLUs5fzZn5/tcaXz3/VydPqus/dVn41iQ+iKuoNlqvarbZ
 V55JzUosxRmJhlrMRcWJACjGo4IcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvG6KaniawftufYsTU8Isbh7YyWSx
 /+A3VotJh64xWjw7fYDZYta7djaL4707WBzYPaZMu8bucW7HeXaPTas62TyeXNvM5NG3ZRVj
 AGsUl01Kak5mWWqRvl0CV8aFRWtYC34bVxy5coS1gfGfWhcjJ4eEgInE9w8nGbsYuTiEBLYz
 Sty+2s8OkZCU2Hf6JiuELSxxv+UIK0TRT0aJDxMPsYAk2ATUJRqmvgKzRQTyJK69XMIMYjML
 JEscXzYDLC4s4CWxeccGNhCbRUBV4uOy9WA1vAI2Evs3NzNCLJCX2H/wLFicU8BWomvOG7Aj
 hIBqFj3+zQ5RLyhxcuYTFoj58hLNW2czT2AUmIUkNQtJagEj0ypG0dSC4tz03OQCQ73ixNzi
 0rx0veT83E2M4HDWCtrBuGz9X71DjEwcjIcYJTiYlUR4z0wKTRPiTUmsrEotyo8vKs1JLT7E
 KM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgWs286fIOEavmRzdEp/9xTNWLMJ9ncmbH
 7KdCbJ5XQ3b+9nHyvjVF8fhvXvVDzhoXl7wsP94d/2L9Cut/kycuj+9KaiwPmZ9Wem36tf8f
 bHnUQvZ5T6/VOFQrtWHTzp49KXduurl4hK+d3rtjfmkrj95K99SljvEzogKXtr843HW+Vq/v
 mvviBecP/BQ2fL57Bdfky3aLFjDdk3/kUWDL2Vo2VTxmStUMViFv7hMy3b9mqHg2S/57kJqr
 qr2SYc7Wp/++x0n7NxxRU1jUxSedpjm5VMUlyziDgZ/3o9DHjp/xjArGLiUlrVz7J5s6xO8z
 P//ZMPb11489ziXTW4K9kpP82Rc+66oOWK97if2LEktxRqKhFnNRcSIA7BQAAdYCAAA=
X-CMS-MailID: 20240529125356epcas2p12f9e62a58081d18c6ff30753f6ba22cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240529125356epcas2p12f9e62a58081d18c6ff30753f6ba22cf
References: <20240529124234.1430707-1-minwoo.im@samsung.com>
 <CGME20240529125356epcas2p12f9e62a58081d18c6ff30753f6ba22cf@epcas2p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=minwoo.im@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Secondary controller list for virtualization has been managed by
Identify Secondary Controller List data structure with NvmeSecCtrlList
where up to 127 secondary controller entries can be managed.  The
problem hasn't arisen so far because NVME_MAX_VFS has been 127.

This patch separated identify data itself from the actual secondary
controller list managed by controller to support more than 127 secondary
controllers with the following patch.  This patch reused
NvmeSecCtrlEntry structure to manage all the possible secondary
controllers, and copy entries to identify data structure when the
command comes in.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c   | 21 ++++++++++-----------
 hw/nvme/nvme.h   | 14 ++++++++------
 hw/nvme/subsys.c |  8 ++++----
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 18672f6619..7cf1e8e384 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -219,7 +219,6 @@
 #define NVME_TEMPERATURE_CRITICAL 0x175
 #define NVME_NUM_FW_SLOTS 1
 #define NVME_DEFAULT_MAX_ZA_SIZE (128 * KiB)
-#define NVME_MAX_VFS 127
 #define NVME_VF_RES_GRANULARITY 1
 #define NVME_VF_OFFSET 0x1
 #define NVME_VF_STRIDE 1
@@ -5480,14 +5479,14 @@ static uint16_t nvme_identify_sec_ctrl_list(NvmeCtrl *n, NvmeRequest *req)
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint16_t pri_ctrl_id = le16_to_cpu(n->pri_ctrl_cap.cntlid);
     uint16_t min_id = le16_to_cpu(c->ctrlid);
-    uint8_t num_sec_ctrl = n->sec_ctrl_list.numcntl;
+    uint8_t num_sec_ctrl = n->nr_sec_ctrls;
     NvmeSecCtrlList list = {0};
     uint8_t i;
 
     for (i = 0; i < num_sec_ctrl; i++) {
-        if (n->sec_ctrl_list.sec[i].scid >= min_id) {
-            list.numcntl = num_sec_ctrl - i;
-            memcpy(&list.sec, n->sec_ctrl_list.sec + i,
+        if (n->sec_ctrl_list[i].scid >= min_id) {
+            list.numcntl = MIN(num_sec_ctrl - i, 127);
+            memcpy(&list.sec, n->sec_ctrl_list + i,
                    list.numcntl * sizeof(NvmeSecCtrlEntry));
             break;
         }
@@ -7144,8 +7143,8 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
 
     if (n->params.sriov_max_vfs) {
         if (!pci_is_vf(pci_dev)) {
-            for (i = 0; i < n->sec_ctrl_list.numcntl; i++) {
-                sctrl = &n->sec_ctrl_list.sec[i];
+            for (i = 0; i < n->nr_sec_ctrls; i++) {
+                sctrl = &n->sec_ctrl_list[i];
                 nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
             }
         }
@@ -7934,7 +7933,7 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
 static void nvme_init_state(NvmeCtrl *n)
 {
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
     uint8_t max_vfs;
@@ -7959,9 +7958,9 @@ static void nvme_init_state(NvmeCtrl *n)
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
     QTAILQ_INIT(&n->aer_queue);
 
-    list->numcntl = max_vfs;
+    n->nr_sec_ctrls = max_vfs;
     for (i = 0; i < max_vfs; i++) {
-        sctrl = &list->sec[i];
+        sctrl = &list[i];
         sctrl->pcid = cpu_to_le16(n->cntlid);
         sctrl->vfn = cpu_to_le16(i + 1);
     }
@@ -8534,7 +8533,7 @@ static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_num_vfs)
     int i;
 
     for (i = pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
-        sctrl = &n->sec_ctrl_list.sec[i];
+        sctrl = &n->sec_ctrl_list[i];
         nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
     }
 }
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..485b42c104 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,6 +26,7 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
+#define NVME_MAX_VFS 127
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -612,7 +613,8 @@ typedef struct NvmeCtrl {
     } features;
 
     NvmePriCtrlCap  pri_ctrl_cap;
-    NvmeSecCtrlList sec_ctrl_list;
+    uint32_t nr_sec_ctrls;
+    NvmeSecCtrlEntry sec_ctrl_list[NVME_MAX_VFS];
     struct {
         uint16_t    vqrfap;
         uint16_t    virfap;
@@ -662,7 +664,7 @@ static inline NvmeSecCtrlEntry *nvme_sctrl(NvmeCtrl *n)
     NvmeCtrl *pf = NVME(pcie_sriov_get_pf(pci_dev));
 
     if (pci_is_vf(pci_dev)) {
-        return &pf->sec_ctrl_list.sec[pcie_sriov_vf_number(pci_dev)];
+        return &pf->sec_ctrl_list[pcie_sriov_vf_number(pci_dev)];
     }
 
     return NULL;
@@ -671,12 +673,12 @@ static inline NvmeSecCtrlEntry *nvme_sctrl(NvmeCtrl *n)
 static inline NvmeSecCtrlEntry *nvme_sctrl_for_cntlid(NvmeCtrl *n,
                                                       uint16_t cntlid)
 {
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     uint8_t i;
 
-    for (i = 0; i < list->numcntl; i++) {
-        if (le16_to_cpu(list->sec[i].scid) == cntlid) {
-            return &list->sec[i];
+    for (i = 0; i < n->nr_sec_ctrls; i++) {
+        if (le16_to_cpu(list[i].scid) == cntlid) {
+            return &list[i];
         }
     }
 
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index d30bb8bfd5..561ed04a53 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -17,13 +17,13 @@
 static int nvme_subsys_reserve_cntlids(NvmeCtrl *n, int start, int num)
 {
     NvmeSubsystem *subsys = n->subsys;
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     int i, cnt = 0;
 
     for (i = start; i < ARRAY_SIZE(subsys->ctrls) && cnt < num; i++) {
         if (!subsys->ctrls[i]) {
-            sctrl = &list->sec[cnt];
+            sctrl = &list[cnt];
             sctrl->scid = cpu_to_le16(i);
             subsys->ctrls[i] = SUBSYS_SLOT_RSVD;
             cnt++;
@@ -36,12 +36,12 @@ static int nvme_subsys_reserve_cntlids(NvmeCtrl *n, int start, int num)
 static void nvme_subsys_unreserve_cntlids(NvmeCtrl *n)
 {
     NvmeSubsystem *subsys = n->subsys;
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     int i, cntlid;
 
     for (i = 0; i < n->params.sriov_max_vfs; i++) {
-        sctrl = &list->sec[i];
+        sctrl = &list[i];
         cntlid = le16_to_cpu(sctrl->scid);
 
         if (cntlid) {
-- 
2.34.1


