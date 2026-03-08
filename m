Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C763EEA853A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHyY-0005Kt-8X; Sun, 08 Mar 2026 13:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHxG-0003na-Cz
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:15 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHxB-00041m-NF
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 93B15600AE;
 Sun,  8 Mar 2026 17:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DB7C116C6;
 Sun,  8 Mar 2026 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772991008;
 bh=fGNhZhGwYx5O0WsKa+ya31k08B1YR0SmQJGqiNNdM0g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ssD8s+UuBlY5JD6gEBxm74gnSZh6a3kbxZPzVHQ87sVmG5JbxcM7XX94L37LBGs3C
 DS1UExBdbJkOuv+qyLrEjpqA9XaJwQeCwl9H/gdEgEb/+x4sN13uUbkg+poH8KJGQO
 dSrbgZ67NjtGJPrVFYfHAT2TV2fX5wOWQjvUVQfOs0u9B/efC6qkpUoglL08tU8rld
 snuGH/uoJfR/xmnSUFqCXwb8Woc7nUb/Vn8DooZaEULp9VVdphRzxDfRfyGs6CvB/J
 N890mew6Rf0N4AvXtbkP8XJydgyEDOYVwQCPxGnpOOpDY6OR6cex+2MxnssNbHVFPO
 +Ff2B2foaOx9g==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/12] tests/tcg/multiarch/test-mmap: Check mmaps beyond
 reserved_va
Date: Sun,  8 Mar 2026 18:29:35 +0100
Message-ID: <20260308172936.2835-12-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
References: <20260308172936.2835-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 tests/tcg/multiarch/test-mmap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index 88f7a04101..2bfa529127 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -497,6 +497,20 @@ void check_shrink_mmaps(void)
     fprintf(stdout, " passed\n");
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
@@ -540,6 +554,7 @@ int main(int argc, char **argv)
 	check_file_unfixed_eof_mmaps();
 	check_invalid_mmaps();
     check_shrink_mmaps();
+    check_mmaps_beyond_addr_space();
 
 	/* Fails at the moment.  */
 	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
-- 
2.53.0


