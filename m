Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E1A10A62CF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5kvj-0006EH-Fb; Thu, 26 Mar 2026 09:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clayton@craftyguy.net>)
 id 1w5dlQ-0003gg-Aq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:00:16 -0400
Received: from out-173.mta1.migadu.com ([95.215.58.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clayton@craftyguy.net>)
 id 1w5dlM-0008W4-4N
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:00:16 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1774504806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A14hZowf3NuwCrwr5yL7wfdM9vMTn4vKiUnFd9wTGhY=;
 b=T5ZscBA0lYVvCefmzgewS4vsklOW7FmfHGy7FNvJ8Zgu98LJSwDLirz9jGZaBppUcbX326
 I1Nvw/C95RVeYez/ze7/wrZaVbJ4thY7m0ERrvs2iBYQDzAVyf4aJsexbcj5crHtIjQQ2m
 fInnNFt5PTzUOjwJAn2VwnRr2BC61nTcGHZuda/Uv9csYUr2IgSoUjJ+BD5PlVy2NGERYR
 I5JMbU7864A/biPGMEYCmpp9r/cAOUo0N2Kbhmmjco6XxQ5eyUOHPgjIOIImbCWM8VzdGE
 aPOpQ9AUlE35O83tvbI7CwjsguaDda8dKsXcR2SFvLdeWQB+kbqfTEojjBQ4TA==
From: Clayton Craft <craftyguy@postmarketos.org>
Date: Wed, 25 Mar 2026 22:59:36 -0700
Subject: [PATCH] linux-user: fix name_to_handle_at when
 AT_HANDLE_MNT_ID_UNIQUE flag is set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-fix-name-to-handle-at-v1-1-49fb922e6fd3@craftyguy.net>
X-B4-Tracking: v=1; b=H4sIAEfLxGkC/x2MSQqAMAwAvyI5G6hxofoV8VA0akCrtEUE8e8Gj
 wMz80DkIByhyx4IfEmUwysUeQbj6vzCKJMykKHGlFTjLDd6tzOmA1WYNkaX0BAZO1NbsbWg7Rl
 Yxf/bD+/7Aey6dDlnAAAA
X-Change-ID: 20260325-fix-name-to-handle-at-02208f294e88
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Clayton Craft <craftyguy@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3315; i=clayton@craftyguy.net; 
 h=from:subject:message-id;
 bh=Ho8XpytcBpKaG3Fogbq2tol3XZ8ae7+JsKHuqwuhAsw=; 
 b=owGbwMvMwCW20X/1yekyblWMp9WSGDKPnI6JVAiyNOv0yat+8Tb26e4b+hfX6Dla2VhOlhHIC
 C+8IxXdUcrCIMbFICumyOKZsM5KdKWZonbgOwaYOaxMIEMYuDgFYCLmExkZttvuDXCbsE972S6L
 iOCzOTv/7hP5GMKVFnJl39f9jIxhSgz/Ha9sTDiZylbNFL/acf6DcxO1VjNF8M9eFbH8xt6uUz4
 HGQA=
X-Developer-Key: i=clayton@craftyguy.net; a=openpgp;
 fpr=3E5FFFD4A3CBAADFDA59395F1BD9F71B57D592B9
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.173; envelope-from=clayton@craftyguy.net;
 helo=out-173.mta1.migadu.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Mar 2026 09:39:19 -0400
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

Linux 6.12 added AT_HANDLE_MNT_ID_UNIQUE, which indicates that mount_id
is 64-bits. If name_to_handle_at is called with this flag set then qemu
passes a 4 byte int to the kernel, which then tries to store 8 bytes in
a 4 byte variable, causing a SIGSEGV[1][2].

This stores mount_id in a 64-bit var if the flag is set.

1. https://gitlab.postmarketos.org/postmarketOS/pmaports/-/work_items/4431
2. https://github.com/systemd/systemd/issues/41279

Signed-off-by: Clayton Craft <craftyguy@postmarketos.org>
---
This fixes a crash experienced recently while running qemu user mode
with e.g. systemd which set AT_HANDLE_MNT_ID_UNIQUE when calling
name_to_handle_at. AT_HANDLE_MNT_ID_UNIQUE was added in Linux 6.12.

I'm a bit unsure of defining AT_HANDLE_MNT_ID_UNIQUE like this,
it's part of linux/fcntl.h but this header isn't included in
qemu/linux-headers.

1. https://gitlab.postmarketos.org/postmarketOS/pmaports/-/work_items/4431
2. https://github.com/systemd/systemd/issues/41279
---
 linux-user/syscall.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7832a1aba5..3cb00c643e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8166,6 +8166,9 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
 #endif
 
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
+#ifndef AT_HANDLE_MNT_ID_UNIQUE
+#define AT_HANDLE_MNT_ID_UNIQUE 0x001
+#endif
 static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
                                      abi_long handle, abi_long mount_id,
                                      abi_long flags)
@@ -8173,6 +8176,7 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     struct file_handle *target_fh;
     struct file_handle *fh;
     int mid = 0;
+    uint64_t mid64 = 0;
     abi_long ret;
     char *name;
     unsigned int size, total_size;
@@ -8196,7 +8200,12 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
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
@@ -8210,8 +8219,14 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
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

---
base-commit: 007b29752ed06e467d3c830bc2c17a8851f8bcd3
change-id: 20260325-fix-name-to-handle-at-02208f294e88

Best regards,
-- 
Clayton Craft <clayton@craftyguy.net>


