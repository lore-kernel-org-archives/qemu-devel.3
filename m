Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C24112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBd-0000WJ-9U; Wed, 11 Mar 2026 11:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8J-0002br-LY; Wed, 11 Mar 2026 11:06:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8H-0004lt-RD; Wed, 11 Mar 2026 11:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241306; bh=+W3eicgXEE2AmYSo7J29g83NNYv1Bgs92Oh+32965CA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hVdUtmkBfcuQ+wjdrm+xpgZLikrBeKB3iPd0WschJw4ZbEEOED4AV6yqla+6zTIO5
 x+h4w4LgkRm+f5hNJ5y20Fo+kNoljUVzkFuY71mKdpatVgnd8ddLSJ+CHmg8DY/dk3
 fHJnZEqT/M2lz/3TxLiCqoTPZ0pT3R5YE4BBzaB5u8/n8e0DANFEYTWOMg4l6rnO9C
 J5GdrtMmOGzffc6+ZFcJe/dkkXuWJl+Djq/vTQG/ktH4OYhc6GxZT6TheP2cgl2URq
 QeuP9V0Hg4LGkYK5HogbRsqqfuW2cvxgTxCchBteEElnYB+E5vSNNvytbseSpSztYv
 P/eQ5hWFjpe6A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 36122191E66;
 Wed, 11 Mar 2026 18:01:46 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 23AA837C2B8;
 Wed, 11 Mar 2026 18:02:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bingwu Zhang <xtex@astrafall.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 40/44] tests/tcg/multiarch/test-mmap: Check mmaps
 beyond reserved_va
Date: Wed, 11 Mar 2026 18:02:12 +0300
Message-ID: <20260311150221.1084186-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Bingwu Zhang <xtex@astrafall.org>

Unfixed mmap calls where start > reserved_va or the max guest addr
should have a valid result.

Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit c865b6bce5d0c882b86fb7c3512174cdaf235017)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index e297f4b1e9..fd9055a90e 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -491,6 +491,20 @@ void check_shrink_mmaps(void)
     munmap(c, 2 * pagesize);
 }
 
+void check_mmaps_beyond_addr_space(void)
+{
+    unsigned char *addr;
+    addr = mmap((void *)(-(unsigned long)pagesize * 10), pagesize * 2,
+                PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    fprintf(stdout, "%s addr=%p errno=%d", __func__, (void *)addr, errno);
+    fail_unless(addr != MAP_FAILED);
+
+    memcpy(dummybuf, addr, 2 * pagesize);
+    munmap(addr, 2 * pagesize);
+
+    fprintf(stdout, " passed\n");
+}
+
 int main(int argc, char **argv)
 {
 	char tempname[] = "/tmp/.cmmapXXXXXX";
@@ -534,6 +548,7 @@ int main(int argc, char **argv)
 	check_file_unfixed_eof_mmaps();
 	check_invalid_mmaps();
     check_shrink_mmaps();
+    check_mmaps_beyond_addr_space();
 
 	/* Fails at the moment.  */
 	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
-- 
2.47.3


