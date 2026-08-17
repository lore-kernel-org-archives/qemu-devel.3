Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951C5C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtKb-00084r-RN; Mon, 17 Aug 2026 05:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtK6-00073D-U5; Mon, 17 Aug 2026 05:08:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtK5-00021Q-HL; Mon, 17 Aug 2026 05:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=sQhQob8k3fPIVVPZtxB4njf9ANw96/9GJcBbpx5lEdg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EzRgTbYjzne6jr41XVRvknWL+B5lpyjlqAs1hbbALe3Qx8k3g9P/50mvEZjEEMAzz
 N1Ta7Y+VA0/h0uk3sNtlDT788ZCSiuPjugscuiR9NzyFvdnWPBMNWcpyBu03veRqVj
 SupoalxVZKmKq8YFhXUIbMAu5Wr98OUtsvD587w3CPoa/u1YBPHVfV+RTubSGzUON9
 yOnLxxHhUYXnR1l1zgCmpXoPyGhdN6/1nmuqQUQ9mQIJWbZ5UOfIOPLUhR1NITr3mP
 hSea/wy5sZJ59q7hRdjX6EqRumrMK3a1gbbbfTM17bQ9jYepMVpMPx35dP1iXxynw6
 weyS6hYyvrJCw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 85DEB1CBA53;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6570D40D035;
 Mon, 17 Aug 2026 12:05:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 06BE030D1E; Mon, 17 Aug 2026 12:05:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 31/42] tests/qtest/ide-test: add a multi-sector ATAPI
 DMA read test
Date: Mon, 17 Aug 2026 12:04:36 +0300
Message-ID: <20260817090453.2034156-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

test_cdrom_pio_large() already exercises a multi-sector PIO read.
Add the DMA counterpart through the same cdrom_read_impl() helper so
the multi-block ATAPI DMA read path gets equivalent coverage.

Signed-off-by: Denis V. Lunev <den@openvz.org>
(cherry picked from commit fe543c2d787a611f1efa34107818a8eee90bb5dc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index c97bc17b677..6e59197566c 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1158,6 +1158,11 @@ static void test_cdrom_dma(void)
     cdrom_read_impl(1, CDROM_DMA);
 }
 
+static void test_cdrom_dma_large(void)
+{
+    cdrom_read_impl(BYTE_COUNT_LIMIT * 4 / ATAPI_BLOCK_SIZE, CDROM_DMA);
+}
+
 int main(int argc, char **argv)
 {
     const char *base;
@@ -1217,6 +1222,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/cdrom/pio", test_cdrom_pio);
     qtest_add_func("/ide/cdrom/pio_large", test_cdrom_pio_large);
     qtest_add_func("/ide/cdrom/dma", test_cdrom_dma);
+    qtest_add_func("/ide/cdrom/dma_large", test_cdrom_dma_large);
 
     ret = g_test_run();
 
-- 
2.47.3


