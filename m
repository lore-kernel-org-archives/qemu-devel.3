Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507D606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=kU5n6unr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpAd-0006qJ-Mo; Fri, 27 Nov 2026 01:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8m-0000Ef-QI; Fri, 27 Nov 2026 01:09:01 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8k-0001qN-Qt; Fri, 27 Nov 2026 01:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=lhfoyL07LkUGq17Mi9BauBfu3nho4RPC3fTRC4+NMhQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kU5n6unrPWdJ+AK1HLe6Nn7nHEEUmn/I8l3x4WztR+VuuN1/jsnUPp9AloO0GP21D
 nWpL6r4cQHIwLg2CXcfKGsjnNyyOxGRNrMeXGQ0KT25XQ9jjAVY5l0wt9CqsMg9qCo
 htG0GB2mbSeOsTgaGZiD3ecTe5LEOrIRn1D1G4IEtRZqIZR3CPO2/L39A4tHuuTHYX
 sz5Q6E3yd/gXXjGe9N+YYsv0GXm933LT/XLZthJYh6o6AUlZCoujH7eT9qAIEAqSpi
 W+/TaAr/28op4s4oLTpcR50Plxw6V10q6XCmAj8Rj+vL9/ayqKlvgkMzcVikwMqdyw
 p66vrFsJeiEhw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 52B041EA372;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50A0E46999D;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 25B84CF332; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 128/152] hw/nvme: advance zone write pointer only
 once the write is committed
Date: Fri, 27 Nov 2026 08:54:26 +0300
Message-ID: <20261127055709.39630-65-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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
index 36053f5eb86..886d15920c4 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3779,7 +3779,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t mapped_size = data_size;
     uint64_t data_offset;
-    NvmeZone *zone;
+    NvmeZone *zone = NULL;
     NvmeZonedResult *res = (NvmeZonedResult *)&req->cqe;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
@@ -3872,10 +3872,6 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
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
@@ -3883,7 +3879,13 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
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
@@ -3901,6 +3903,11 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
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


