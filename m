Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46B606A333
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=X49/n4mH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWowZ-0006m9-8M; Fri, 27 Nov 2026 00:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWowW-0006ay-Du; Fri, 27 Nov 2026 00:56:20 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWowU-0000ZD-EX; Fri, 27 Nov 2026 00:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758873; bh=p96DvxvMhAD3LgwnIWWAkNxrjm9JVMgDHskArrFFqHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X49/n4mHsM0Pa+juG5VyTCsehgK0jkLZt+GvlzkYHMPjn0OQSQBrQjlba8YRT43Sz
 St/157Dl+7VJW3grLs/YyyKxYbgEQPzZME4H4WKiZYZS0lVDJaxYIqwAPXL3Hs2Pg1
 sYaYZ5RpJgg79AhCbTs4b8x2npIc8/O5QdPP9Tsn4tAXQtv8rBWvPpD8eTvfXJU017
 abMV7kQPAIexXuvmoC9dcENPJM83mfTlOY4yGSIbVFYpsafSx2uVpdhXFaSTZ57QHt
 2tdey4zQoqSCNDDXpYhHoY/1/YdPE+pCyP5Wy6AktBSY6/OUYGZCoOhJ83aNG1yuY+
 MHNp9ghpJXXsw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E0AA51EA2D9;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DD26D469916;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CED14CF238; Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 081/140] hw/nvme: verify source and destination
 lba size for copy
Date: Fri, 27 Nov 2026 08:53:07 +0300
Message-ID: <20261127055421.39015-22-mjt@tls.msk.ru>
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

Cross-namespace copy requires the source and destination namespace to
have the same logical block size. This is not verified, causing a heap
out-of-bounds write.

Fix by correctly identifying the invalid operation.

Cc: qemu-stable@nongnu.org
Reported-by: Feng Xue and XGPT of ThreatBook
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4173
Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 0b9935a847175c29ea794bbf42a79230fbf4031b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 0a5493d2f23..b9afa41393d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3237,6 +3237,11 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         status = NVME_INVALID_FIELD | NVME_DNR;
         goto invalid;
     } else if (snsid != dnsid) {
+        if (sns->lbaf.ds != dns->lbaf.ds) {
+            status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+            goto invalid;
+        }
+
         if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
             !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
             if (!nvme_copy_matching_ns_format(sns, dns, false)) {
-- 
2.47.3


