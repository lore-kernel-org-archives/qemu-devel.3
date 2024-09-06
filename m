Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CCBCD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smX03-0001HA-Qh; Fri, 06 Sep 2024 07:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smX02-000143-8k; Fri, 06 Sep 2024 07:19:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smX00-0008Mg-68; Fri, 06 Sep 2024 07:19:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CA3EE8C4B3;
 Fri,  6 Sep 2024 14:12:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D71F813371C;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353762 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 66/69] linux-user: Handle short reads in mmap_h_gt_g
Date: Fri,  6 Sep 2024 14:13:15 +0300
Message-Id: <20240906111324.353230-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In particular, if an image has a large bss, we can hit
EOF before reading all host_len bytes of the mapping.

Create a helper, mmap_pread to handle the job for both
the larger block in mmap_h_gt_g itself, as well as the
smaller block in mmap_frag.

Cc: qemu-stable@nongnu.org
Fixes: eb5027ac618 ("linux-user: Split out mmap_h_gt_g")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2504
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240820050848.165253-2-richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit a4ad4a9d98f7fbde806f07da21e69f39e134cdf1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 2a11d921ab..9e94f36ba2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -282,6 +282,40 @@ static int do_munmap(void *addr, size_t len)
     return munmap(addr, len);
 }
 
+/*
+ * Perform a pread on behalf of target_mmap.  We can reach EOF, we can be
+ * interrupted by signals, and in general there's no good error return path.
+ * If @zero, zero the rest of the block at EOF.
+ * Return true on success.
+ */
+static bool mmap_pread(int fd, void *p, size_t len, off_t offset, bool zero)
+{
+    while (1) {
+        ssize_t r = pread(fd, p, len, offset);
+
+        if (likely(r == len)) {
+            /* Complete */
+            return true;
+        }
+        if (r == 0) {
+            /* EOF */
+            if (zero) {
+                memset(p, 0, len);
+            }
+            return true;
+        }
+        if (r > 0) {
+            /* Short read */
+            p += r;
+            len -= r;
+            offset += r;
+        } else if (errno != EINTR) {
+            /* Error */
+            return false;
+        }
+    }
+}
+
 /*
  * Map an incomplete host page.
  *
@@ -356,10 +390,9 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
     /* Read or zero the new guest pages. */
     if (flags & MAP_ANONYMOUS) {
         memset(g2h_untagged(start), 0, last - start + 1);
-    } else {
-        if (pread(fd, g2h_untagged(start), last - start + 1, offset) == -1) {
-            return false;
-        }
+    } else if (!mmap_pread(fd, g2h_untagged(start), last - start + 1,
+                           offset, true)) {
+        return false;
     }
 
     /* Put final protection */
@@ -852,8 +885,7 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
     }
 
     if (misaligned_offset) {
-        /* TODO: The read could be short. */
-        if (pread(fd, p, host_len, offset + real_start - start) != host_len) {
+        if (!mmap_pread(fd, p, host_len, offset + real_start - start, false)) {
             do_munmap(p, host_len);
             return -1;
         }
-- 
2.39.2


