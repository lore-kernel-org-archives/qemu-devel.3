Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590E5CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2ke-0003PZ-VX; Mon, 17 Nov 2025 12:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>) id 1vL2kV-00039w-9Z
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:10:44 -0500
Received: from mlugg.co.uk ([104.238.170.239] helo=mail.mlugg.co.uk)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>) id 1vL2kR-0006GE-WD
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:10:42 -0500
Received: from localhost.localdomain
 (3.c.0.2.2.e.e.a.9.8.5.7.2.1.b.b.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id 44B0635A22;
 Mon, 17 Nov 2025 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1763399432; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48dY3shIdyYgNL0gV9X/uYwMWrpcBOBCQO5LqUIeW8k=;
 b=duhMlVPFT6nKfRLiVrhLpNs/NJVkCav97jXL/0Lqm2UENwwLQMbeukzd8v1/C1jyZxX2fK
 Tlp/5PbGHmVKHd0EJfiG3zmr2YzgjH54Gh7yi1dtpoKYwEe5PZq+Wfs1TXNaade0vHNOS8
 upZAkB/gk43MQHjp6GDlLuCPBDVv8lo=
From: Matthew Lugg <mlugg@mlugg.co.uk>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org,
 Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PATCH v2 4/4] tests: add tcg coverage for fixed mremap bugs
Date: Mon, 17 Nov 2025 17:09:54 +0000
Message-ID: <20251117170954.31451-5-mlugg@mlugg.co.uk>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117170954.31451-1-mlugg@mlugg.co.uk>
References: <20251117170954.31451-1-mlugg@mlugg.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.238.170.239; envelope-from=mlugg@mlugg.co.uk;
 helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These tests cover the first two fixes in this patch series. The final
patch is not covered because the bug it fixes is not easily observable
by the guest.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
---
 tests/tcg/multiarch/test-mmap.c | 42 +++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

Changes from last revision: reverted changes to stdout format to keep the patch
focused. Note that the last line of the diff appears wrongly idented, but that
is actually because this file has a lot of incorrect hard tab identation, while
the diff correctly uses spaces.

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
2.51.2


