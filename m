Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAB4F3C25E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaxd-00043N-EW; Mon, 09 Mar 2026 09:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxU-0003yU-3q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:47 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxP-00067q-LU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EDCEF40657
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AACC4CEF7
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773064042;
 bh=fGNhZhGwYx5O0WsKa+ya31k08B1YR0SmQJGqiNNdM0g=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Mb4+Ih0in3QH04vck+nRjMXiGw51U/O5qGbmQg9d/HTPvtzhgW33C3FtwqBGZvyrj
 ytWGlQ1NRzmA9o3lOWZxfU8t0W9ggmxwEJA+URyso+wE0mQVneAS9BBS5QArVEAYbK
 46CxZqBjCsouAiNYjvgykowEAV35HqPSe3Xj0nJ5UVUd9R9rVpebFJoRAP9UMOjkMJ
 89l+3Py1NJqHua6k4+qBDsKvRmzyRxCVMr4tDaYwy52Cuimhx/5M27FcCZsc6FECrf
 x5yAcjNWGwpelWR9TH2VKKLTFYPQ82s3p1izpzOGbYFpOSw3qhVoSanXuSoHgDN7Bu
 +jO6dW0OaC5iA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] tests/tcg/multiarch/test-mmap: Check mmaps beyond
 reserved_va
Date: Mon,  9 Mar 2026 14:47:10 +0100
Message-ID: <20260309134711.5312-10-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309134711.5312-1-deller@kernel.org>
References: <20260309134711.5312-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


