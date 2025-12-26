Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239D1E8FDB0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 17:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZBj9-0006QU-B7; Fri, 26 Dec 2025 12:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vZBj7-0006QD-TA
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 12:35:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vZBj6-0008Mj-4C
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 12:35:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so43765145e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766770542; x=1767375342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c9zIHzNk/zX6b4v+zzS+hNXbQFRs1l0qf8scYPkEdUQ=;
 b=gXWlwPXReyHuSZj/Vq9t6eMNS+tvXhcdu2+wMZSTGJskbwSiR9Pm779U3Rlg35Xl1h
 bXQOzkXfY9OZhyM+NrQm56ndgusMe0izYhpSmjsCqrBpAI6KXnXN7B6iLryPvJS8W2ED
 FCTSoOS24Um0LTe2waCd0hZSRa2vUBOMF+drjrBFbhK0V3m6wP4jQrsvaFSXI8WScHW8
 eW8AGOu1sXecXXi5bp9lvxNJ5mDjKZ0qD5IkfUG24mP1KmAg8owUNaj/lckU2+4azjxn
 7qqvYkEMoQ7vtcJP9jdGxpdLpx7/GDCONlHKUAqIrs/SzbXluZY91O4XM0KGP8AkXU3l
 gThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766770542; x=1767375342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9zIHzNk/zX6b4v+zzS+hNXbQFRs1l0qf8scYPkEdUQ=;
 b=ROGj9KGD8Yk/UTLvHJDFBWNAUqDbZjpzxhudn5q/W/qUd8h5Ighw6NcuviedS3a65b
 mn0lO4IPKdS8AFw3tlSqBm+AdINIoyDftt4BfAtVGpI5JsC4PO0/eMnItp9c/V4TcLqj
 +odJIB5CV6N/+B26KQ+3zh6ihsSERT2g7eguFwI+j/c2TorRIWdrQKLqONVmA76hN8CV
 5PSh3M+LG7xTimXTUmrpmhXsbghWFOtDINhy+lNISuTUvRDzKXiTGWkIhCClEBjzFgoj
 lve+SoqgWiYiGz9evtaIO0sp4XHFdVsDP8YJR8D7XDc5dmNly9pm8QhR200jNAuYHtTn
 S8Pw==
X-Gm-Message-State: AOJu0Yze1DsG1xaXhovTEE7qdGgFQe9YCjHv8D+VGAFXPwfHK74+0vfm
 5rBCAmkZW1ndEIjIzCrU453qdMbhQzsuUrRY2Ai2uPOqjsP0NckHYk3xJorpIHoDxDs=
X-Gm-Gg: AY/fxX6VlerPqiqEw3yZHC5LbvHkMQfQlY2NKEhbPcHZvQ+MZfgXbOxCGoVurslbR5b
 PUpo+nZb5J1Gk8b7Vg2Bzj9j/d7Buzsx8/vz34ZR1u5gxqlDbSIqbnCrSKy4T7TqvS7eyS+uCjY
 sYj5fgMiPpkriJyfs6bg4gIjNGlNsPchxUKUiK5n0rsEpkGKbvIu4d7okp+76CjAFT7etmGxlvZ
 R3wN/koGZICFc89MmONORLLK2M440BujswrQDU3Pv1rBBVuXFSl7/telKj/YQClNnSGGbk0yZ+m
 z4vn6n0tLxXWHqG9Q7q8D/nrqkQFTGmx6SmUtCnDRC1su5by8wqP5zUM8Gl/TOex8wIvdqFqzQ+
 YI0VhhVr8ACXAHiQGDZGbRp8Lv9wbXh6pfvuWzP732HKguwW9P5zyn1QwdDJQ+wIp+h9bdicLK8
 uRcEG4ntyUtLeN9G8a6YGTpVrQdjfjGi8=
X-Google-Smtp-Source: AGHT+IHzu6vM3dx4OUDCGtC8oehiKkdWMM6o31+tUMIB5VDQMVE5kHRlFo0QOMajFS44gY5YBY5LgQ==
X-Received: by 2002:a05:600c:6299:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-47d1959ae49mr291812215e9.35.1766770541880; 
 Fri, 26 Dec 2025 09:35:41 -0800 (PST)
Received: from tuf-gaming ([2a02:2f01:760c:a301:1665:9199:948a:6af7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a4651bsm178032295e9.7.2025.12.26.09.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 09:35:41 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Subject: [PATCH v2] linux-user/strace: fix printing of file offsets
Date: Fri, 26 Dec 2025 19:35:21 +0200
Message-ID: <20251226173521.1957025-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Previously, 64-bit file offsets (loff_t) were printed using `print_raw_param()`
function, which led to silent truncation of the upper part. This commit fixes
this issue by adding two helper functions:

1. print_file_offset32(): prints 32-bit file offsets (off_t)
2. print_file_offset64(): prints 64-bit file offsets (loff_t)

Changelog v2:

1. Make `print_file_offset32()` static.
2. Use `last` parameter in `print_file_offset32()`.
3. Rename `low` and `high` parameters of `print_file_offset64()` to `word0`,
`word1` respectively
4. Convert `last` to bool for `print_file_offset[32,64]()`
5. Use `PRId64` instead of `PRIu64` for `print_file_offset64()`
6. Fix `print__llseek()`

Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
---
 linux-user/strace.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 758c5d32b6..285fc987f5 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -85,6 +85,10 @@ UNUSED static void print_enums(const struct enums *, abi_long, int);
 UNUSED static void print_at_dirfd(abi_long, int);
 UNUSED static void print_file_mode(abi_long, int);
 UNUSED static void print_open_flags(abi_long, int);
+UNUSED static void print_file_offset32(abi_long offset, bool last);
+UNUSED static void print_file_offset64(abi_long word0,
+                                       abi_long word1,
+                                       bool last);
 UNUSED static void print_syscall_prologue(const struct syscallname *);
 UNUSED static void print_syscall_epilogue(const struct syscallname *);
 UNUSED static void print_string(abi_long, int);
@@ -1664,6 +1668,20 @@ print_open_flags(abi_long flags, int last)
     print_flags(open_flags, flags, last);
 }
 
+/* Prints 32-bit file offset (off_t) */
+static void
+print_file_offset32(abi_long offset, bool last)
+{
+    print_raw_param(TARGET_ABI_FMT_ld, offset, last);
+}
+
+/* Prints 64-bit file offset (loff_t) */
+static void
+print_file_offset64(abi_long word0, abi_long word1, bool last)
+{
+    print_raw_param64("%" PRId64, target_offset64(word0, word1), last);
+}
+
 static void
 print_syscall_prologue(const struct syscallname *sc)
 {
@@ -2187,11 +2205,13 @@ print_fallocate(CPUArchState *cpu_env, const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     print_flags(falloc_flags, arg1, 0);
 #if TARGET_ABI_BITS == 32
-    print_raw_param("%" PRIu64, target_offset64(arg2, arg3), 0);
-    print_raw_param("%" PRIu64, target_offset64(arg4, arg5), 1);
+    /* On 32-bit targets, two registers are used for `loff_t` */
+    print_file_offset64(arg2, arg3, false);
+    print_file_offset64(arg4, arg5, true);
 #else
-    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg3, 1);
+    /* On 64-bit targets, one register is used for `loff_t` */
+    print_file_offset64(arg2, 0, false);
+    print_file_offset64(arg3, 0, true);
 #endif
     print_syscall_epilogue(name);
 }
@@ -2597,8 +2617,7 @@ print__llseek(CPUArchState *cpu_env, const struct syscallname *name,
     const char *whence = "UNKNOWN";
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
-    print_raw_param("%ld", arg1, 0);
-    print_raw_param("%ld", arg2, 0);
+    print_file_offset64(arg1, arg2, false);
     print_pointer(arg3, 0);
     switch(arg4) {
     case SEEK_SET: whence = "SEEK_SET"; break;
@@ -2619,7 +2638,7 @@ print_lseek(CPUArchState *cpu_env, const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
+    print_file_offset32(arg1, false);
     switch (arg2) {
     case SEEK_SET:
         qemu_log("SEEK_SET"); break;
@@ -2650,7 +2669,7 @@ print_truncate(CPUArchState *cpu_env, const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_file_offset32(arg1, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -2667,7 +2686,7 @@ print_truncate64(CPUArchState *cpu_env, const struct syscallname *name,
         arg1 = arg2;
         arg2 = arg3;
     }
-    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_file_offset64(arg1, arg2, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -2684,7 +2703,7 @@ print_ftruncate64(CPUArchState *cpu_env, const struct syscallname *name,
         arg1 = arg2;
         arg2 = arg3;
     }
-    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_file_offset64(arg1, arg2, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -3239,7 +3258,7 @@ print_stat(CPUArchState *cpu_env, const struct syscallname *name,
     print_syscall_epilogue(name);
 }
 #define print_lstat     print_stat
-#define print_stat64	print_stat
+#define print_stat64    print_stat
 #define print_lstat64   print_stat
 #endif
 
@@ -4228,7 +4247,7 @@ print_pread64(CPUArchState *cpu_env, const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     print_pointer(arg1, 0);
     print_raw_param("%d", arg2, 0);
-    print_raw_param("%" PRIu64, target_offset64(arg3, arg4), 1);
+    print_file_offset64(arg3, arg4, true);
     print_syscall_epilogue(name);
 }
 #endif
-- 
2.51.0


