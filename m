Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289D3E7FDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn27Q-0006aO-G6; Mon, 02 Feb 2026 17:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn26O-00050f-0j; Mon, 02 Feb 2026 17:09:04 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn26M-0002fU-CB; Mon, 02 Feb 2026 17:08:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E3F6F1852BC;
 Tue, 03 Feb 2026 01:07:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C26E635B3CF;
 Tue, 03 Feb 2026 01:08:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Lugg <mlugg@mlugg.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 15/56] tests: add tcg coverage for fixed mremap bugs
Date: Tue,  3 Feb 2026 01:07:20 +0300
Message-ID: <20260202220805.945271-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matthew Lugg <mlugg@mlugg.co.uk>

These tests cover the first two fixes in this patch series. The final
patch is not covered because the bug it fixes is not easily observable
by the guest.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251117170954.31451-5-mlugg@mlugg.co.uk>
(cherry picked from commit 9290c10ae9d0c3ff433efbb7ecb0e781966c5404)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index 96257f8ebe..e297f4b1e9 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -22,6 +22,7 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -41,7 +42,7 @@ do                                                             \
   }                                                            \
 } while (0)
 
-unsigned char *dummybuf;
+unsigned char *dummybuf; /* length is 2*pagesize */
 static unsigned int pagesize;
 static unsigned int pagemask;
 int test_fd;
@@ -451,9 +452,45 @@ void check_invalid_mmaps(void)
     fail_unless(addr == MAP_FAILED);
     fail_unless(errno == ENOMEM);
 
+    /* Attempt to remap a region which exceeds the bounds of memory. */
+    addr = mremap((void *)((uintptr_t)pagesize * 10), SIZE_MAX & ~(size_t)pagemask, pagesize, 0);
+    fprintf(stdout, "%s mremap addr=%p", __func__, (void *)addr);
+    fail_unless(addr == MAP_FAILED);
+    fail_unless(errno == EFAULT);
+
     fprintf(stdout, " passed\n");
 }
 
+void check_shrink_mmaps(void)
+{
+    unsigned char *a, *b, *c;
+    a = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    b = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    c = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+    fail_unless(a != MAP_FAILED);
+    fail_unless(b != MAP_FAILED);
+    fail_unless(c != MAP_FAILED);
+
+    /* Ensure we can read the full mappings */
+    memcpy(dummybuf, a, 2 * pagesize);
+    memcpy(dummybuf, b, 2 * pagesize);
+    memcpy(dummybuf, c, 2 * pagesize);
+
+    /* Shrink the middle mapping in-place; the others should be unaffected */
+    b = mremap(b, pagesize * 2, pagesize, 0);
+    fail_unless(b != MAP_FAILED);
+
+    /* Ensure we can still access all valid mappings */
+    memcpy(dummybuf, a, 2 * pagesize);
+    memcpy(dummybuf, b, pagesize);
+    memcpy(dummybuf, c, 2 * pagesize);
+
+    munmap(a, 2 * pagesize);
+    munmap(b, pagesize);
+    munmap(c, 2 * pagesize);
+}
+
 int main(int argc, char **argv)
 {
 	char tempname[] = "/tmp/.cmmapXXXXXX";
@@ -468,7 +505,7 @@ int main(int argc, char **argv)
 
 	/* Assume pagesize is a power of two.  */
 	pagemask = pagesize - 1;
-	dummybuf = malloc (pagesize);
+	dummybuf = malloc (pagesize * 2);
 	printf ("pagesize=%u pagemask=%x\n", pagesize, pagemask);
 
 	test_fd = mkstemp(tempname);
@@ -496,6 +533,7 @@ int main(int argc, char **argv)
 	check_file_fixed_eof_mmaps();
 	check_file_unfixed_eof_mmaps();
 	check_invalid_mmaps();
+    check_shrink_mmaps();
 
 	/* Fails at the moment.  */
 	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
-- 
2.47.3


