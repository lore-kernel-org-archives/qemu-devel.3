Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69358606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=cOFFwpdJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpDh-000475-Eo; Fri, 27 Nov 2026 01:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpB5-0007bV-83; Fri, 27 Nov 2026 01:11:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpB1-0002cr-LR; Fri, 27 Nov 2026 01:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=eaxmt4FquaC90OFN4VLSy+oKTShKzDzsZJyQOKnFD3I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cOFFwpdJ+1ZRF1CU6816uepyHgJxOr8mMc+u+eDhh1kvw4J/jRl6dSTLEgpBmwzDP
 aNWme183q5+z8UzSeCUEQ0VUzyOGssrZBA1qIQjcoEsS0wgH6PDVlYMI1Wnf0SB2hB
 7lWEgdOrZnlNucKuQ+S5zgNqAwLI/X+mP/1EZr+s8mcX/vtkTe/d1ZM0REjfCxSOXJ
 7A/CbpGOBElHWUAhJg0pqrIr41Icw3CwgtD2N35V1PhcHGTH9C+BS9PTJFJ/2nKmo+
 YIJpO817NFcPck7PIg0GSp+1qI1YvhFITbVkLRyHHjn88VNvZmdVE5e4ZPDmSKSMgB
 CJ1/uw0QhVDng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CBEEB1EA388;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8E574699B3;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 98AFFCF35E; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 150/152] hw/block/pflash_cfi01: Reject out-of-range
 blk_offset on load
Date: Fri, 27 Nov 2026 08:54:48 +0300
Message-ID: <20261127055709.39630-87-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

A migration stream can set blk_offset beyond the flash storage.
The write-confirm path would then write past the end of it.
Check that the pending write block fits in the storage in
pflash_post_load() and fail the load.

Cc: qemu-stable@nongnu.org
Reported-by: phudd6 & kietvha1 from Viettel Cyber Security
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4388
Fixes: 284a7ee2e290 ("hw/pflash: implement update buffer for block writes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261124185556.81132-4-philmd@oss.qualcomm.com>
(cherry picked from commit 7dcf2a795503c3f4a5221a3bfe52164ab3d2dc47)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 4616767188a..310cb954691 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1029,6 +1029,13 @@ static void postload_update_cb(void *opaque, bool running, RunState state)
 static int pflash_post_load(void *opaque, int version_id)
 {
     PFlashCFI01 *pfl = opaque;
+    uint64_t size = pfl->sector_len * pfl->nb_blocs;
+
+    if (pfl->blk_offset != -1
+        && (pfl->blk_offset >= size
+            || size - pfl->blk_offset < pfl->writeblock_size)) {
+        return -EINVAL;
+    }
 
     /*
      * ROMD mode is not in the VMState; derive it from the migrated
-- 
2.47.3


