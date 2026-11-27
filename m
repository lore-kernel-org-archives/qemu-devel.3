Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5883606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=vDuGbsxe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp62-00026K-AM; Fri, 27 Nov 2026 01:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp4o-0007LT-Lt; Fri, 27 Nov 2026 01:04:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp4j-0003i5-RL; Fri, 27 Nov 2026 01:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759043; bh=wgvZ29lhjDk+TawirSfqeUrg18BewJz6gwk8Z8brUuQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vDuGbsxepS4TmU7bah4ef6GuemfqfplVUoi3wQKefhYnXXl6Doe5lng7ATIS63o9G
 QDJi83k+Xpi2n8OoVTf7aoBFzFm7cx6oNt0egYq8uE2qDp9kdw/BZUkvSZpJZ4JdxS
 DnUnhewaOgY+y6OR/6/9wkp5VWIH6uUJp5+wTNyrVETiTst2g5xhHqHg39T5B41n6k
 2qHAVD0FRHBt68lAobRFFRJpEvBctpPvI+XgZyH1iwz2JP4tDxxUS6sJNiqIh0rBqc
 mKQVUnnzjeS3YzIWY9svugzHMqA8gkCYCGyylN4zeDxpi10f7pPZmT52oaxd06GFYP
 Eh8FLnWDromiw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B96421EA34A;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B74C5469975;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A2AADCF2E2; Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 088/152] hw/nvme: reject fdp.runs smaller than the
 lba data size
Date: Fri, 27 Nov 2026 08:53:46 +0300
Message-ID: <20261127055709.39630-25-mjt@tls.msk.ru>
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

The reclaim unit accounting in nvme_do_write_fdp spins forever if RUNS
is configured to be smaller than LBADS.

Reject such an invalid configuration upfront.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit e095e8baaa18673e1976f34cce08e4adde061e29)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 7f0f9ac7662..16524f2d915 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -420,6 +420,12 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
     char *r, *p;
     uint16_t *ph;
 
+    if (endgrp->fdp.runs < nvme_l2b(ns, 1)) {
+        error_setg(errp, "fdp.runs must be greater than or equal to the "
+                   "lba data size of the namespace");
+        return false;
+    }
+
     if (!ns->params.fdp.ruhs) {
         ns->fdp.nphs = 1;
         ph = ns->fdp.phs = g_new(uint16_t, 1);
-- 
2.47.3


