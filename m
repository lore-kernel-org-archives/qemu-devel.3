Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4E4CD6E4A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 06:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTDBk-00074v-1N; Sat, 30 May 2026 02:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wTDBi-00074n-2Z
 for qemu-devel@nongnu.org; Sat, 30 May 2026 02:28:50 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wTDBc-0005qc-6b
 for qemu-devel@nongnu.org; Sat, 30 May 2026 02:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780122499; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=z4y8uU2x8AV1KIYxLjQG+6/0XGc9ZwUDlfvJk+6eJYo=;
 b=gCe/7mnGV/slPUAx7Rv4nCiT5PYmeMFg7aV+acPVU1SMUaiJyx6toao8tIHvpl760YCBC++LQUe8Ii7ku7HEv/lg5x0TDkwx0vfrkweYVCBPRvsHF4GcNoxL53tfP4t6gu4mqjFbdvj8V2bn7cTsTq567SMJVGGz5CepKL+IeeQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X3r4Fqm_1780122497; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X3r4Fqm_1780122497 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 30 May 2026 14:28:18 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2] util/cutils: drop qemu_strnlen() in favor of strnlen()
Date: Sat, 30 May 2026 14:28:16 +0800
Message-ID: <20260530062816.59206-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

There are only three call sites, and strnlen() is available on all
supported platforms (POSIX.1-2008, Windows via UCRT, MinGW).  Remove
the hand-rolled wrapper and use the standard function directly.

While here, align bsd-user/uaccess.c to use size_t for max_len/len,
matching linux-user/uaccess.c and eliminating a signed/unsigned mismatch.

Also remove the stale qemu_strnlen() entry from docs/devel/style.rst.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 bsd-user/uaccess.c    |  4 ++--
 docs/devel/style.rst  |  1 -
 include/qemu/cutils.h | 17 +----------------
 linux-user/uaccess.c  |  2 +-
 util/cutils.c         | 15 +--------------
 5 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/bsd-user/uaccess.c b/bsd-user/uaccess.c
index 89163257f4..7ad4b580f4 100644
--- a/bsd-user/uaccess.c
+++ b/bsd-user/uaccess.c
@@ -43,7 +43,7 @@ abi_long target_strlen(abi_ulong guest_addr1)
 {
     uint8_t *ptr;
     abi_ulong guest_addr;
-    int max_len, len;
+    size_t max_len, len;
 
     guest_addr = guest_addr1;
     for (;;) {
@@ -51,7 +51,7 @@ abi_long target_strlen(abi_ulong guest_addr1)
         ptr = lock_user(VERIFY_READ, guest_addr, max_len, 1);
         if (!ptr)
             return -TARGET_EFAULT;
-        len = qemu_strnlen((const char *)ptr, max_len);
+        len = strnlen((const char *)ptr, max_len);
         unlock_user(ptr, guest_addr, 0);
         guest_addr += len;
         /* we don't allow wrapping or integer overflow */
diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index d025933808..0b854ae042 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -519,7 +519,6 @@ QEMU provides other useful string functions:
 
     int strstart(const char *str, const char *val, const char **ptr)
     int stristart(const char *str, const char *val, const char **ptr)
-    int qemu_strnlen(const char *s, int max_len)
 
 There are also replacement character processing macros for isxyz and toxyz,
 so instead of e.g. isalnum you should use qemu_isalnum.
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 36c68ce86c..d249f22676 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -101,22 +101,7 @@ int strstart(const char *str, const char *val, const char **ptr);
  *          false otherwise.
  */
 int stristart(const char *str, const char *val, const char **ptr);
-/**
- * qemu_strnlen:
- * @s: string
- * @max_len: maximum number of bytes in @s to scan
- *
- * Return the length of the string @s, like strlen(), but do not
- * examine more than @max_len bytes of the memory pointed to by @s.
- * If no NUL terminator is found within @max_len bytes, then return
- * @max_len instead.
- *
- * This function has the same behaviour as the POSIX strnlen()
- * function.
- *
- * Returns: length of @s in bytes, or @max_len, whichever is smaller.
- */
-int qemu_strnlen(const char *s, int max_len);
+
 /**
  * qemu_strsep:
  * @input: pointer to string to parse
diff --git a/linux-user/uaccess.c b/linux-user/uaccess.c
index 27e841e651..f9bd713edd 100644
--- a/linux-user/uaccess.c
+++ b/linux-user/uaccess.c
@@ -99,7 +99,7 @@ ssize_t target_strlen(abi_ulong guest_addr1)
         ptr = lock_user(VERIFY_READ, guest_addr, max_len, 1);
         if (!ptr)
             return -TARGET_EFAULT;
-        len = qemu_strnlen((const char *)ptr, max_len);
+        len = strnlen((const char *)ptr, max_len);
         unlock_user(ptr, guest_addr, 0);
         guest_addr += len;
         /* we don't allow wrapping or integer overflow */
diff --git a/util/cutils.c b/util/cutils.c
index 9803f11a59..f39a97e509 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -54,7 +54,7 @@
 
 void strpadcpy(char *buf, int buf_size, const char *str, char pad)
 {
-    int len = qemu_strnlen(str, buf_size);
+    size_t len = strnlen(str, buf_size);
     memcpy(buf, str, len);
     memset(buf + len, pad, buf_size - len);
 }
@@ -118,19 +118,6 @@ int stristart(const char *str, const char *val, const char **ptr)
     return 1;
 }
 
-/* XXX: use host strnlen if available ? */
-int qemu_strnlen(const char *s, int max_len)
-{
-    int i;
-
-    for(i = 0; i < max_len; i++) {
-        if (s[i] == '\0') {
-            break;
-        }
-    }
-    return i;
-}
-
 char *qemu_strsep(char **input, const char *delim)
 {
     char *result = *input;
-- 
2.50.1 (Apple Git-155)


