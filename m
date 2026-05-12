Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A6CCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuD7-0004lO-TI; Tue, 12 May 2026 17:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCG-0002dl-9k; Tue, 12 May 2026 16:59:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuC8-0004u0-KD; Tue, 12 May 2026 16:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=spMSY34vA7lTKqGmhvsZ7COBnm2jw9smcsjabY4pbwQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w90I72TY2Ydd+Noxil8q0NZBNdBnbqkhw3Git17yVZrdy/Y1vq7wTZXJ1K28Uamoe
 bwvy9aZ7QC+fa9uvtg1HTSWNbkEyoUn1t1C3ILOxUVeT3UQkT71ble0WdkYgonH8c9
 z/LkEFvqfjeGj9tgGRmh4ILMy1hcPsgvSZG32CYhYDKIDI1hlZbDHnywGxiu8+t/GS
 9T+tyb+43kq6jl+ZkT53FqlnitUOXX4AXZqnEmWtTgI4yrfdXRJMc6UTT7tSW2mjtb
 z4rLMO0a7DlcJtnV17wzNc0maitAeE/NbZEkzYX8p62ivi55/4leWiKwUzQgKFxDL7
 tMONtiqqp9lGQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 32FFD1AA2F9;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3F5C73ABC6A;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Clayton Craft <craftyguy@postmarketos.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 045/107] linux-user: fix name_to_handle_at when
 AT_HANDLE_MNT_ID_UNIQUE flag is set
Date: Tue, 12 May 2026 23:53:32 +0300
Message-ID: <20260512205437.360850-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Clayton Craft <craftyguy@postmarketos.org>

Linux 6.12 added AT_HANDLE_MNT_ID_UNIQUE, which indicates that mount_id
is 64-bits. If name_to_handle_at is called with this flag set then qemu
passes a 4 byte int to the kernel, which then tries to store 8 bytes in
a 4 byte variable, causing a SIGSEGV[1][2].

This stores mount_id in a 64-bit var if the flag is set.

1. https://gitlab.postmarketos.org/postmarketOS/pmaports/-/work_items/4431
2. https://github.com/systemd/systemd/issues/41279

Signed-off-by: Clayton Craft <craftyguy@postmarketos.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Message-id: 20260325-fix-name-to-handle-at-v1-1-49fb922e6fd3@craftyguy.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 22966937f4130278259a79d6462d1a0887e22c6e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e6dd35d2a1..3f61dd732c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8040,6 +8040,9 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
 #endif
 
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
+#ifndef AT_HANDLE_MNT_ID_UNIQUE
+#define AT_HANDLE_MNT_ID_UNIQUE 0x001
+#endif
 static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
                                      abi_long handle, abi_long mount_id,
                                      abi_long flags)
@@ -8047,6 +8050,7 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     struct file_handle *target_fh;
     struct file_handle *fh;
     int mid = 0;
+    uint64_t mid64 = 0;
     abi_long ret;
     char *name;
     unsigned int size, total_size;
@@ -8070,7 +8074,12 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     fh = g_malloc0(total_size);
     fh->handle_bytes = size;
 
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
+    if (flags & AT_HANDLE_MNT_ID_UNIQUE) {
+        ret = get_errno(name_to_handle_at(dirfd, path(name), fh,
+                                          (int *)&mid64, flags));
+    } else {
+        ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
+    }
     unlock_user(name, pathname, 0);
 
     /* man name_to_handle_at(2):
@@ -8084,8 +8093,14 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     g_free(fh);
     unlock_user(target_fh, handle, total_size);
 
-    if (put_user_s32(mid, mount_id)) {
-        return -TARGET_EFAULT;
+    if (flags & AT_HANDLE_MNT_ID_UNIQUE) {
+        if (put_user_u64(mid64, mount_id)) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        if (put_user_s32(mid, mount_id)) {
+            return -TARGET_EFAULT;
+        }
     }
 
     return ret;
-- 
2.47.3


