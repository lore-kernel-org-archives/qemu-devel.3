Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CC606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=eA2k/dtL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWowZ-0006kl-8M; Fri, 27 Nov 2026 00:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWowV-0006Vg-M0; Fri, 27 Nov 2026 00:56:19 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWowT-0000jE-Ov; Fri, 27 Nov 2026 00:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758873; bh=rqHrpyrdzUIbGttG36ZM8a06X6wiBnfA+NQHJVQ2wZI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eA2k/dtLIMVfGRZoGsEIVLUle2J/iWrqDtAtTdGvE128DFLXqk5upykY8xwJp6t3B
 INSP76sKu7Y8twMXocc5kygSDimVfj2xPW8EN5sf3CzgXIn5vVfNxjDRGYTHmS47Mr
 vk5w7avUC+2YhP5v0Zw76SJc6hWMEWHWCBiG6biKEtJYSgnhrhzoPm23nhKusqbuMh
 Zc94+lXSLOM09AoxrSR+ltn+cJh5nvCgZmzT83zfAb3CQK0xg1kSWiI2A11hd4ZfwO
 0s7JwYWIckYWXdTwy1c8ZHK8SZR4j/98566jOB/3V8tei+N1vxlVsRedRWSifoCboP
 mOg5tyInHpIrg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E41511EA2DA;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E2017469917;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D1B8ECF23A; Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 082/140] hw/nvme: reject fdp.runs smaller than the
 lba data size
Date: Fri, 27 Nov 2026 08:53:08 +0300
Message-ID: <20261127055421.39015-23-mjt@tls.msk.ru>
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
index dc7a960df18..00db5062359 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -412,6 +412,12 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
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


