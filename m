Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA9CE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smX00-0000Tx-2g; Fri, 06 Sep 2024 07:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzw-0008Kn-DP; Fri, 06 Sep 2024 07:19:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzu-0008Kc-Pf; Fri, 06 Sep 2024 07:19:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91F808C4B0;
 Fri,  6 Sep 2024 14:12:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9EDED133719;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353753 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Yutaro Shimizu <shimizu@cyberdefense.jp>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 63/69] hw/nvme: fix leak of uninitialized memory in
 io_mgmt_recv
Date: Fri,  6 Sep 2024 14:13:12 +0300
Message-Id: <20240906111324.353230-63-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

Yutaro Shimizu from the Cyber Defense Institute discovered a bug in the
NVMe emulation that leaks contents of an uninitialized heap buffer if
subsystem and FDP emulation are enabled.

Cc: qemu-stable@nongnu.org
Reported-by: Yutaro Shimizu <shimizu@cyberdefense.jp>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 6a22121c4f25b181e99479f65958ecde65da1c92)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 652116085e..659332db0a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4302,7 +4302,7 @@ static uint16_t nvme_io_mgmt_recv_ruhs(NvmeCtrl *n, NvmeRequest *req,
 
     nruhsd = ns->fdp.nphs * endgrp->fdp.nrg;
     trans_len = sizeof(NvmeRuhStatus) + nruhsd * sizeof(NvmeRuhStatusDescr);
-    buf = g_malloc(trans_len);
+    buf = g_malloc0(trans_len);
 
     trans_len = MIN(trans_len, len);
 
-- 
2.39.2


