Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=XSsXlGtF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWozz-0000EB-9Q; Fri, 27 Nov 2026 00:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWozv-0008Hi-9V; Fri, 27 Nov 2026 00:59:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWozt-0005dr-1t; Fri, 27 Nov 2026 00:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758878; bh=osJpa6BzWTL7KrBFwZgIZFAYch7tPPD27LoP4a1/tB4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XSsXlGtFdSZCNYa9PLkOqa4MowL28mygtl9ZE6sJYQMYtivBhCM95cC9IN66n22pn
 rktY7LY3T4rlfNow+KV8iJdh1tFrg4wvpw/bQsa5RVbTcyamA2x7bry4YQ6/66gdxT
 2BQBgfXr6oc9vz53biLjGNWy6tvKZ3LNhLEDujnvTr+AeK6WIA0mHY80z51OOf6l/7
 as7vIbfl4Ura41Wl65FuF/8q5cfvJIR+Y+qUh0VhPO2DNUkcPoSBHsbYTdq4hon1tW
 B1s6NS+wmu5w1B1QuDAAN1iIh0iDCEbpWu+QXUQqAGpgzk1Du15W7NXrGEEtqcKE9u
 BogAsJZ/SNCPw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D5131EA2FE;
 Fri, 27 Nov 2026 08:54:38 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0AF32469939;
 Fri, 27 Nov 2026 08:54:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CA587CF27E; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 116/140] hw/nvme: advance zone write pointer only
 once the write is committed
Date: Fri, 27 Nov 2026 08:53:42 +0300
Message-ID: <20261127055421.39015-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_do_write stages the updated zone write pointer before data is
mapped. If that fails, the write pointer update is already staged and
subsequent writes will be rejected if attempted at the original
position.

Move the staging down.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 975b64665048 ("hw/block/nvme: refactor zone resource management")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 7e203726411b7a28b2d020339d6267c7c7d4134e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 178b971d03a..f347db506f4 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3759,7 +3759,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t mapped_size = data_size;
     uint64_t data_offset;
-    NvmeZone *zone;
+    NvmeZone *zone = NULL;
     NvmeZonedResult *res = (NvmeZonedResult *)&req->cqe;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
@@ -3852,10 +3852,6 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
         if (status) {
             goto invalid;
         }
-
-        if (!(zone->d.za & NVME_ZA_ZRWA_VALID)) {
-            zone->w_ptr += nlb;
-        }
     } else if (ns->endgrp && ns->endgrp->fdp.enabled) {
         nvme_do_write_fdp(n, req, slba, nlb);
     }
@@ -3863,7 +3859,13 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     data_offset = nvme_l2b(ns, slba);
 
     if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
-        return nvme_dif_rw(n, req);
+        status = nvme_dif_rw(n, req);
+
+        if (status != NVME_NO_COMPLETE) {
+            return status;
+        }
+
+        goto out;
     }
 
     if (!wrz) {
@@ -3881,6 +3883,11 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
                                            req);
     }
 
+out:
+    if (ns->params.zoned && !(zone->d.za & NVME_ZA_ZRWA_VALID)) {
+        zone->w_ptr += nlb;
+    }
+
     return NVME_NO_COMPLETE;
 
 invalid:
-- 
2.47.3


