Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAE8C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXxB6-0001dO-4e; Wed, 15 Jan 2025 01:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1tXxB3-0001cy-Ek
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:46:57 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1tXxAy-0000lj-5q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:46:56 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250115064641epoutp0235376ff3c2f9c2e68294fa617ad17b62~aytAVgRgd2006420064epoutp02K
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 06:46:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250115064641epoutp0235376ff3c2f9c2e68294fa617ad17b62~aytAVgRgd2006420064epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1736923601;
 bh=CxnbocLTmZ95AX1LAnfwVw73na1JRDE7lgMbiY0yk68=;
 h=From:To:Cc:Subject:Date:References:From;
 b=VwiHefHgg7d1RgJ7HKVAPK+eQQ4YjlIrYrWFqkh+CiB/ipEk7OEliq82OFBGY0tyW
 dQa4tSJm2GzjgXMdkWpqe2pW9k8oxUFF0CJFfaZ40Lmh2vpiv4j3RgY9lef+yqkmTK
 YLc29picQEVdJ8P9EJc5IyR59EyreM5fbT9ekjh4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20250115064640epcas5p36ec07e0e4ae4fedc17fe938f09c6bdc5~ays-So0rX2573125731epcas5p3M;
 Wed, 15 Jan 2025 06:46:40 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YXxNs63GMz4x9QH; Wed, 15 Jan
 2025 06:46:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 78.93.19933.DC957876; Wed, 15 Jan 2025 15:46:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250115052058epcas5p24379c769f1f53bc7fec3771fa8122389~axiKg2GZn0846208462epcas5p21;
 Wed, 15 Jan 2025 05:20:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20250115052058epsmtrp23cc55b2a5fa4d3ec4733aa7d4b2a29ef~axiKgImhZ1255712557epsmtrp2O;
 Wed, 15 Jan 2025 05:20:58 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-93-678759cdd05d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A9.40.33707.AB547876; Wed, 15 Jan 2025 14:20:58 +0900 (KST)
Received: from open-sourcing.samsungds.net (unknown [107.99.41.223]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250115052057epsmtip1f842cac0bad040e4cd116f58b767d690~axiJr5ETT2486724867epsmtip1j;
 Wed, 15 Jan 2025 05:20:57 +0000 (GMT)
From: Arun Kumar <arun.kka@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Arun Kumar
 <arun.kka@samsung.com>
Subject: [PATCH] hw/nvme: Format Index Mismatch Protection
Date: Wed, 15 Jan 2025 05:23:47 +0530
Message-ID: <20250114235347.38477-1-arun.kka@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmuu7ZyPZ0g64ObYs59y0sTkwJs9h/
 8BurxaRD1xgtjvfuYHFg9Zgy7Rq7x7kd59k9Nq3qZPN4cm0zk0ffllWMAaxR2TYZqYkpqUUK
 qXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLuVFMoSc0qBQgGJxcVK
 +nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZv5dtZyw4KFzR
 f+8yewPjXr4uRk4OCQETif7/u5m6GLk4hAR2M0osOH2DGcL5xChx6uMhNjinp+MTM0zL8Rsf
 WSESOxklHv+YCtXyk1Hi3tnjTCBVbALqEmtn7gCzRQQkJX53nQbrZhaIl/i2aCkLiC0sYCWx
 /t13RhCbRUBVovHzFlYQm1fAUuLDmh6obfISi3csZ4aIC0qcnPmEBWKOvETz1tlgiyUEdrFL
 tB6dyALR4CJxZ/IJJghbWOLV8S3sELaUxOd3e9kg7HqJMzP3QNV0MEo8/Q5VYy9xcc9foDgH
 0AJNifW79CHCshJTT61jgtjLJ9H7+wlUK6/EjnkwtpLEva0/ocZISMy5AvGXhICHxNTZuxlB
 RgoJxErMPCsxgVF+FpJvZiH5ZhbC4gWMzKsYJVMLinPTU4tNC4zyUsvhEZucn7uJEZwEtbx2
 MD588EHvECMTB+MhRgkOZiUR3iVsrelCvCmJlVWpRfnxRaU5qcWHGE2BQTyRWUo0OR+YhvNK
 4g1NLA1MzMzMTCyNzQyVxHmbd7akCwmkJ5akZqemFqQWwfQxcXBKNTDt/Vt2xzbm4S7JKbry
 bQXfV3488acjQy3mBmtVmPLUku6LXHXXWtj1hUzf++zf+8Tsedra7aGfjvUy1THZPm05s+H4
 8wiN/JlGLJ/lpt6ZMHdz3lkRO9OdJl0GReq7Xz/4ddRR5Y9+vErfstWHFaamrrhwvNFMpmBr
 yHzN7bMcztd9Nd0e33xIpzn0Cc8SyTSNiR8ifCVXSDH2HVQunBGVc2ZvFMPJxKp7XgdYk2fN
 0UmYVrB15RvhZw8EN9k6hJYEnbNOa2XN2PgsdenUL0KHbJxe6r81WciQ4u47ibFNo8Lhq0vc
 9ld2zLkvf2X8yN9jH5RrHvP31dXrCS0lC5fO60tz+hrH1/5ExvMuj7ESS3FGoqEWc1FxIgDV
 tf4RCwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnO4u1/Z0g7Wf+C3m3LewODElzGL/
 wW+sFpMOXWO0ON67g8WB1WPKtGvsHud2nGf32LSqk83jybXNTB59W1YxBrBGcdmkpOZklqUW
 6dslcGX8XradseCgcEX/vcvsDYx7+boYOTkkBEwkjt/4yNrFyMUhJLCdUeLT9oOMEAkJiR9f
 vkHZwhIr/z1nhyj6ziix8sB8dpAEm4C6xNqZO5hAbBEBSYnfXaeZuxg5OJgFkiVe//AFCQsL
 WEmsf/cdbA6LgKpE4+ctrCA2r4ClxIc1PcwQ8+UlFu9YzgwRF5Q4OfMJC4jNDBRv3jqbeQIj
 3ywkqVlIUgsYmVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBIehVtAOxmXr/+odYmTiYDzE
 KMHBrCTCu4StNV2INyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomD
 U6qBafuLVUZB13lfsX0WiFrrE1tddaFnY0zQpsAJNjmXv8TuKsySfLHE0vOBD/PekF9vfgcl
 S+/M0GyocgjxFIrb8/pVZdf9PB/xzcoSk3TPGtlll13rnsDTMUPqzZfnNudl531Q57MUnLd/
 wp2vPjcfGFxuijk4Y8q/2L0Tb1QbPGq0tbubfpTxO8c0Cc8qaY4+fdOHtm+ecH/TMdycPNOL
 17Ci7LHaSl5H9keeJ0xmHSpacHN/odYRV/8txTNcHdxb2xvfJ/ddkL+vXaZfrcg4Yxq/9WMH
 /pCcZwmKM5/3z9nTemRX5naja6z6CbardpWsD+Fdn6Cam7DIecPNz6x5fBH2ltnr0vZN0po/
 4cs3JZbijERDLeai4kQAkMW/E7ICAAA=
X-CMS-MailID: 20250115052058epcas5p24379c769f1f53bc7fec3771fa8122389
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250115052058epcas5p24379c769f1f53bc7fec3771fa8122389
References: <CGME20250115052058epcas5p24379c769f1f53bc7fec3771fa8122389@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.25; envelope-from=arun.kka@samsung.com;
 helo=mailout2.samsung.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.063, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

implement TP4140-(Format Index Mismatch Protection)

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
---
 hw/nvme/ctrl.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..46bf522754 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4452,6 +4452,16 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD;
     }
 
+    if (!n->features.hbs.lbafee) {
+        if ((NVME_ID_NS_NVM_ELBAF_PIF(ns->id_ns_nvm.elbaf[
+             NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)]) != 0)) {
+            return NVME_INVALID_FORMAT | NVME_DNR;
+        }
+        if (NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas) > ns->id_ns.nlbaf) {
+            return NVME_INVALID_FORMAT | NVME_DNR;
+        }
+    }
+
     req->ns = ns;
 
     switch (req->cmd.opcode) {
@@ -6537,8 +6547,26 @@ done:
     nvme_do_format(iocb);
 }
 
-static uint16_t nvme_format_check(NvmeNamespace *ns, uint8_t lbaf, uint8_t pi)
+static uint16_t nvme_format_check(NvmeFormatAIOCB *iocb)
 {
+    NvmeNamespace *ns = iocb->ns;
+    NvmeRequest *req = iocb->req;
+    NvmeCtrl *n = nvme_ctrl(req);
+    uint8_t lbaf = iocb->lbaf;
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t pi = (dw10 >> 5) & 0x7;
+
+    if (!n->features.hbs.lbafee) {
+        if ((NVME_ID_NS_NVM_ELBAF_PIF(ns->id_ns_nvm.elbaf[lbaf]) != 0) ||
+            (NVME_ID_NS_NVM_ELBAF_PIF(ns->id_ns_nvm.elbaf[
+             NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)]) != 0)) {
+            return NVME_INVALID_FORMAT | NVME_DNR;
+        }
+        if (NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas) > ns->id_ns.nlbaf) {
+            return NVME_INVALID_FORMAT | NVME_DNR;
+        }
+    }
+
     if (ns->params.zoned) {
         return NVME_INVALID_FORMAT | NVME_DNR;
     }
@@ -6562,9 +6590,6 @@ static void nvme_do_format(NvmeFormatAIOCB *iocb)
 {
     NvmeRequest *req = iocb->req;
     NvmeCtrl *n = nvme_ctrl(req);
-    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
-    uint8_t lbaf = dw10 & 0xf;
-    uint8_t pi = (dw10 >> 5) & 0x7;
     uint16_t status;
     int i;
 
@@ -6586,7 +6611,7 @@ static void nvme_do_format(NvmeFormatAIOCB *iocb)
         goto done;
     }
 
-    status = nvme_format_check(iocb->ns, lbaf, pi);
+    status = nvme_format_check(iocb);
     if (status) {
         req->status = status;
         goto done;
-- 
2.43.0


