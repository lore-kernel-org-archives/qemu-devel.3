Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DAFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVvW-0003zX-O9; Thu, 18 Apr 2024 13:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVvF-0003Ab-H4; Thu, 18 Apr 2024 13:51:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVvD-0007hR-IF; Thu, 18 Apr 2024 13:51:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 72C5B5FD78;
 Thu, 18 Apr 2024 20:50:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C3E54B9352;
 Thu, 18 Apr 2024 20:50:02 +0300 (MSK)
Received: (nullmailer pid 947875 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 111/116] linux-user/x86_64: Handle the vsyscall page in
 open_self_maps_{2, 4}
Date: Thu, 18 Apr 2024 20:49:41 +0300
Message-Id: <20240418174955.947730-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

This is the only case in which we expect to have no host memory backing
for a guest memory page, because in general linux user processes cannot
map any pages in the top half of the 64-bit address space.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2170
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 4ef1f559f270c66b3ffc23f6c845ff3d008c6356)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 834a254895..11c75e3b4e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7994,6 +7994,10 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
         path = "[heap]";
     } else if (start == info->vdso) {
         path = "[vdso]";
+#ifdef TARGET_X86_64
+    } else if (start == TARGET_VSYSCALL_PAGE) {
+        path = "[vsyscall]";
+#endif
     }
 
     /* Except null device (MAP_ANON), adjust offset for this fragment. */
@@ -8082,6 +8086,18 @@ static int open_self_maps_2(void *opaque, target_ulong guest_start,
     uintptr_t host_start = (uintptr_t)g2h_untagged(guest_start);
     uintptr_t host_last = (uintptr_t)g2h_untagged(guest_end - 1);
 
+#ifdef TARGET_X86_64
+    /*
+     * Because of the extremely high position of the page within the guest
+     * virtual address space, this is not backed by host memory at all.
+     * Therefore the loop below would fail.  This is the only instance
+     * of not having host backing memory.
+     */
+    if (guest_start == TARGET_VSYSCALL_PAGE) {
+        return open_self_maps_3(opaque, guest_start, guest_end, flags);
+    }
+#endif
+
     while (1) {
         IntervalTreeNode *n =
             interval_tree_iter_first(d->host_maps, host_start, host_start);
-- 
2.39.2


