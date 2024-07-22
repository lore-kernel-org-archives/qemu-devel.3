Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D43CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVw5l-00022w-Fa; Mon, 22 Jul 2024 12:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5j-0001tb-6Z; Mon, 22 Jul 2024 12:40:51 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5e-0005xE-PG; Mon, 22 Jul 2024 12:40:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 43FA61140163;
 Mon, 22 Jul 2024 12:40:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 22 Jul 2024 12:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1721666444; x=
 1721752844; bh=WyKJRhjeeug+HYE4DuRDplA49rGAICyGPO4Gj8mghwE=; b=h
 iem9nEf5B1KW5PR5WTt6vBH/AVwuNrmQfv0bXvWi0XCxbST0ijGT9XGx8+XTSrp4
 5NXKOfacRlnzoP2cmH/RD+01psz+ADFWQuuFWob2+A4fDM/pa/OOEvgeNwmSZ3Bv
 loaBpPMzjotWyNPdSThnwrCWKsHx+rcYVcmWFGiYk9U6jCMhUPNnzYHKu24g4jJ5
 MQ/ABhzwtQRyEZf4IKMENB1tF4dEr4fbk6CD5d9ErL/l57F+ToYA7JMXy8UDhonM
 1V6lrdgyr2T7xJtrh82dGEfdEBzucgaaCbe5iB/bNiU9g7qlB0wv1wZ7If9NVDOG
 a2HWYmElShIxrLHhuCWpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721666444; x=
 1721752844; bh=WyKJRhjeeug+HYE4DuRDplA49rGAICyGPO4Gj8mghwE=; b=j
 LpVCqOEL5vyf+Ny+bf23GKyObD0sbMKrMbm/gY6zDHmuSndnMReFN2PGBv2hAyhy
 5/hItlP4mxgo3SKdqYTp/rpaMaG3L1Ett7Srzpvte8/xfhrQUEjNTGAAyMjQW4MX
 jsKOk2lDTb35MHgS8WdWLt+ofd90XcaDtQmEd3PYxNIFqNHTck57flK+LpaOGjU4
 iYZxaQ/RtYr/tGVhiRVLElC2TK14IRE0h0SVlHF782TflkvMejUYs4QgBjHm6D8X
 /b6imd94/Yt3/3yb5KECE7Y2qfhBsYCXC+c+mtdrrp/4bFRlRrRcUCHh/MAtT7LB
 2N+UtwvZsIN/nKNbS6Fbw==
X-ME-Sender: <xms:i4ueZoMKdaQg0KTULo1hlCBtRANxp4Kon2BT3zuMXihTnxsiTIU2uA>
 <xme:i4ueZu9HAcAQv55NN4UvBMYZt6Ju5Tsgzm7w5n1s8quODrQtliGIfL906iKL8pa14
 6MIiahESOYiSN-JAYU>
X-ME-Received: <xmr:i4ueZvSy4HD7KrZ5yAqV6W7HNYlqUmhLyXglNa30f1nKP-NAK2SPkYwjTVWojFIQMovczwaRbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:i4ueZgvWRsZiBEd3IGkzeO1qM6PaY-7iIsRw7x4wPrZRDDgrdcsTnA>
 <xmx:i4ueZgfJ3ign36iMH67bXb50DtDiM11la7_csTKIhnXfYENm2wz7tw>
 <xmx:i4ueZk1-0nSvfebeImrdNHrgQsk8oKfrz5QYYbttCdxriZNO2inwlg>
 <xmx:i4ueZk-GsoLe8Iau0zjRL0SXVuFUTXoyXirdSEkEY4ti1qaMhtuURQ>
 <xmx:jIueZv_v1YTwyiani31pvmlpHBNQMF9L9tChzDhph8aIEOje612vlc0G>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 12:40:41 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Ayush Mishra <ayush.m55@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 3/4] hw/nvme: actually implement abort
Date: Mon, 22 Jul 2024 18:40:30 +0200
Message-ID: <20240722164026.61128-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722164026.61128-6-its@irrelevant.dk>
References: <20240722164026.61128-6-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152; i=k.jensen@samsung.com;
 h=from:subject; bh=uglZ62ZPer5vBDYnn35Dk3Wt8vMep/HYhK4caD0wnJk=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaei3uawf+QHwE9an/l+E/1HGrp6BeMqdVq3
 SgXJ969wRlcY4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmnot7AAoJEE3hrzFt
 Tw3pdU4H/Ridki1+9k3YDCcl0dlBoUgA4znHYdrYNjStvE8Qi0iiyuIawJrzMcK38krNfvw7l56
 7blBNZr6wrM95Jh+T807p/VW+GsONVpSSHudkILNdXCiwT0UaP9mVOlwaQkHqIJueEWrCBY80ts
 kHdP0lUAZFf3+kkVhY57OvkpYS7XaCXDbTyAXZAJWip2CJBkrwFIx5vjG27MnMVFs3Lo92vH8Rh
 BjzY0IjFux2hnUnpQUyWTKUJPqpYGL9QYC1AKaST9D74Ha73VQ6yey5wihxoBbvg7M3X7Ph4Alg
 lfYgl7i0ZuRAlTEhuNT+lGSePInZxsoFzVDKRlCjdZsinVFnXiw3uqpp
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ayush Mishra <ayush.m55@samsung.com>

Abort was not implemented previously, but we can implement it for AERs
and asynchrnously for I/O.

Signed-off-by: Ayush Mishra <ayush.m55@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 385438a9ae09..39782ddb2e76 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1758,6 +1758,10 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
         break;
     }
 
+    if (ret == -ECANCELED) {
+        status = NVME_CMD_ABORT_REQ;
+    }
+
     trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);
 
     error_setg_errno(&local_err, -ret, "aio failed");
@@ -5950,12 +5954,40 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
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
2.45.2


