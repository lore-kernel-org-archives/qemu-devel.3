Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F061C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOei8-0004I4-Hs; Tue, 02 Jul 2024 10:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1sOdkI-00081Z-Pw
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:40:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1sOdkB-0007Mh-2e
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:40:33 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240702134017epoutp01b988ede3c87b61a7a4db2054bc99a8d8~eaQ43Jpdt1289012890epoutp01S
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2024 13:40:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240702134017epoutp01b988ede3c87b61a7a4db2054bc99a8d8~eaQ43Jpdt1289012890epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1719927617;
 bh=Tc04XVLYYScLca5YrloOjmE417jHIdRSu1c6MkC6BYM=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Hh/JChhY+nChIzrG1q33nFHsLfHGQfYhMN04EEEWatpxQ8SMBjIPGu40zVlnqcLfl
 FxUeA27sSo+S5eeu3bIc/f53c9g9PObRbzN+X/2JKNjClJVKiboLDt56GTSweNfu4G
 1J/ucv6vg6KhL+v43GWVrgBxFd5aJFGnvMdw7ujU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20240702134017epcas5p4b6d417adaf595c7e28e6cc9a1cd2bfa2~eaQ4pqyol0142801428epcas5p4G;
 Tue,  2 Jul 2024 13:40:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4WD3v40dVDz4x9Pw; Tue,  2 Jul
 2024 13:40:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 47.B8.09989.F3304866; Tue,  2 Jul 2024 22:40:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20240702133144epcas5p22b982613bfbfce0e7ad0c74fd72a7956~eaJbAG7uc1478014780epcas5p2n;
 Tue,  2 Jul 2024 13:31:44 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240702133144epsmtrp120509736bfe851d4c537af5097cf305c~eaJa-c6NK2395523955epsmtrp1c;
 Tue,  2 Jul 2024 13:31:44 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-9e-6684033fa496
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BE.79.07412.04104866; Tue,  2 Jul 2024 22:31:44 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240702133143epsmtip1658fb420c8b1043b6dbb320b07aa6277~eaJaJXUEF2392523925epsmtip1e;
 Tue,  2 Jul 2024 13:31:43 +0000 (GMT)
From: Ayush Mishra <ayush.m55@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Ayush Mishra
 <ayush.m55@samsung.com>
Subject: [PATCH] hw/nvme: actually implement abort
Date: Tue,  2 Jul 2024 13:32:32 +0530
Message-ID: <20240702080232.848849-1-ayush.m55@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmlq49c0uaQdM8IYvbk3ksTkwJs9h/
 8BurxaRD1xgtjvfuYHFg9Zgy7Rq7x7kd59k9Nq3qZPN4cm0zk0ffllWMAaxR2TYZqYkpqUUK
 qXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLuVFMoSc0qBQgGJxcVK
 +nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZf9ZfZin4z1+x
 +/MJpgbGNu4uRk4OCQETiUWf/zN2MXJxCAnsZpTYuXkuI0hCSOATo8S3eTwQiW+MEucXbWOC
 6fi9sZsFIrGXUWJP43uo9jYmibMTvzGDVLEJaEnce3mLBcQWEZCU+N11GijOwcEskCTR9Vkb
 JCwsYCSxcepjsKEsAqoS/R/vgdm8AtYSmzd8ZoNYJi+xeMdyZoi4oMTJmU/ARjIDxZu3zmaG
 qNnFLtHwXhvCdpH48v8NO4QtLPHq+BYoW0riZX8blJ0tMaf1GyOEXSKxdt41FgjbXuLinr9M
 EGdqSqzfpQ8RlpWYemodE8RaPone30+g4cArsWPeE7ByCQFliZ5DBhBhSYknr79AXe8h8X7T
 YVaQEiGBWIkH6w0nMMrPQvLLLCS/zELYu4CReRWjZGpBcW56arFpgVFeajk8UpPzczcxgpOf
 ltcOxocPPugdYmTiYDzEKMHBrCTCK/W+OU2INyWxsiq1KD++qDQntfgQoykwgCcyS4km5wPT
 b15JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUyt1zrFTSJ6n93X
 +F0s6Ve2ULLatiCAZ/XhvFiriZ7PGcs4T+pdsubaZOaztXq19J7/6yeInn9ee6QmWO/6s5+7
 flyNvTVBMOut+P4kg+Jeha01ifxXjnAZBaznFZt8KGGHrXjP2q0nU66Ws/xd8OqF0OMN4ac5
 /Pg/Sm+a9HxO8sxMiYmtygVxYZwbgll07kZ+ezr7eMmvMtXr57elKc9MVzyQrfCtecryCLOo
 7v+P12RIdrM9uZ6dHuDovEw48E/saqW6lzsktlrZGl77t2pyyqsPj+xEzdZeu3j9QNPzD9Ld
 RzRcyzL4JwUfbV2S9V9hak1T14W4ncmyFSyTzql/bF/xQl1j44R5Etw3Wf4qsRRnJBpqMRcV
 JwIA3KN9CAcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnK4DY0uawZZNgha3J/NYnJgSZrH/
 4DdWi0mHrjFaHO/dweLA6jFl2jV2j3M7zrN7bFrVyebx5NpmJo++LasYA1ijuGxSUnMyy1KL
 9O0SuDL+rL/MUvCfv2L35xNMDYxt3F2MnBwSAiYSvzd2s3QxcnEICexmlHj9bgorREJSYu62
 b1C2sMTKf8/ZIYpamCSmPJkGlmAT0JK49/IWC4gtAtTwu+s0M4jNLJAm8bXlMRuILSxgJLFx
 6mMmEJtFQFWi/+M9MJtXwFpi84bPbBAL5CUW71jODBEXlDg58wkLxBx5ieats5knMPLNQpKa
 hSS1gJFpFaNkakFxbnpusmGBYV5quV5xYm5xaV66XnJ+7iZGcEBqaexgvDf/n94hRiYOxkOM
 EhzMSiK8Uu+b04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLg
 lGpgem7RZCY5R+sDI6fIr36Of057ZjFJXky2e8o28/ixLb8Sd+klWMyx3bCiZr7Vt0oPLcVV
 sRbnr/7tvGzxxXO22YNKf82KsOgdf15U9xUXXt/ZlR3l/Pn8wUtSCeKnVq5fsrCpVquvctsj
 6/IpsRuWMPr71m1ybrlmejjiVNm+myJVZ1j2lKX7pDx0UGGLWrrjoTXL0RlXnlxe/SlZTik5
 teOCi/VcfW4N9z1a2zXXOc9/xjN1ksaLpIYl0WeFHBOXNXsZKKtderrsvOURoQX2Nh4lFxVn
 fr7N19U+z2udaq6ywstvs31517T81Vuhziy68Oop7zhb+2kmMQ8571wQ6Om+ERH58Qu/xT/J
 gl0qSizFGYmGWsxFxYkAnAAEWLcCAAA=
X-CMS-MailID: 20240702133144epcas5p22b982613bfbfce0e7ad0c74fd72a7956
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702133144epcas5p22b982613bfbfce0e7ad0c74fd72a7956
References: <CGME20240702133144epcas5p22b982613bfbfce0e7ad0c74fd72a7956@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=ayush.m55@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jul 2024 10:42:15 -0400
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

Abort was not implemented previously, but we can implement it for AERs and asynchrnously for I/O.

Signed-off-by: Ayush Mishra <ayush.m55@samsung.com>
---
 hw/nvme/ctrl.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..a38037b5f8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1759,6 +1759,10 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
         break;
     }
 
+    if (ret == -ECANCELED) {
+        status = NVME_CMD_ABORT_REQ;
+    }
+
     trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);
 
     error_setg_errno(&local_err, -ret, "aio failed");
@@ -5759,12 +5763,40 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
+    uint16_t cid  = (le32_to_cpu(req->cmd.cdw10) >> 16) & 0xffff;
+    NvmeSQueue *sq = n->sq[sqid];
+    NvmeRequest *r, *next;
+    int i;
 
     req->cqe.result = 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (sqid == 0) {
+        for (i = 0; i < n->outstanding_aers; i++) {
+            NvmeRequest *re = n->aer_reqs[i];
+            if (re->cqe.cid == cid) {
+                memmove(n->aer_reqs + i, n->aer_reqs + i + 1,
+                         (n->outstanding_aers - i - 1) * sizeof(NvmeRequest *));
+                n->outstanding_aers--;
+                re->status = NVME_CMD_ABORT_REQ;
+                req->cqe.result = 0;
+                nvme_enqueue_req_completion(&n->admin_cq, re);
+                return NVME_SUCCESS;
+            }
+        }
+    }
+
+    QTAILQ_FOREACH_SAFE(r, &sq->out_req_list, entry, next) {
+        if (r->cqe.cid == cid) {
+            if (r->aiocb) {
+                blk_aio_cancel_async(r->aiocb);
+            }
+            break;
+        }
+    }
+
     return NVME_SUCCESS;
 }
 
-- 
2.43.0


