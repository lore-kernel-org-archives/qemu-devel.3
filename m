Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B381CE7B04
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWze-0005MA-Oy; Fri, 06 Sep 2024 07:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzW-0004gh-VA; Fri, 06 Sep 2024 07:19:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWzU-0008Jr-R3; Fri, 06 Sep 2024 07:19:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65C3A8C4AD;
 Fri,  6 Sep 2024 14:12:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 73E80133716;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353742 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 60/69] linux-user: Preserve NULL hit in target_mmap
 subroutines
Date: Fri,  6 Sep 2024 14:13:09 +0300
Message-Id: <20240906111324.353230-60-mjt@tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not pass guest_base to the host mmap instead of zero hint.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2353
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 3aefee3ec01e607529a9918e2978f365c5c3b5e9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index be3b9a68eb..2a11d921ab 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -559,9 +559,13 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
                             int host_prot, int flags, int page_flags,
                             int fd, off_t offset)
 {
-    void *p, *want_p = g2h_untagged(start);
+    void *p, *want_p = NULL;
     abi_ulong last;
 
+    if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+        want_p = g2h_untagged(start);
+    }
+
     p = mmap(want_p, len, host_prot, flags, fd, offset);
     if (p == MAP_FAILED) {
         return -1;
@@ -609,11 +613,15 @@ static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
                             int mmap_flags, int page_flags, int fd,
                             off_t offset, int host_page_size)
 {
-    void *p, *want_p = g2h_untagged(start);
+    void *p, *want_p = NULL;
     off_t fileend_adj = 0;
     int flags = mmap_flags;
     abi_ulong last, pass_last;
 
+    if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+        want_p = g2h_untagged(start);
+    }
+
     if (!(flags & MAP_ANONYMOUS)) {
         struct stat sb;
 
@@ -739,12 +747,16 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
                             int flags, int page_flags, int fd,
                             off_t offset, int host_page_size)
 {
-    void *p, *want_p = g2h_untagged(start);
+    void *p, *want_p = NULL;
     off_t host_offset = offset & -host_page_size;
     abi_ulong last, real_start, real_last;
     bool misaligned_offset = false;
     size_t host_len;
 
+    if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+        want_p = g2h_untagged(start);
+    }
+
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         /*
          * Adjust the offset to something representable on the host.
-- 
2.39.2


