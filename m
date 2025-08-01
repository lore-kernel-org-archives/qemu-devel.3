Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E0BC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 23:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhzBA-0001nE-4E; Fri, 01 Aug 2025 19:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8q-0007L4-6H
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:24 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8l-0005to-5H
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:22 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-31ec651c2a1so1229791a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754090777; x=1754695577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeeV1u3q4RgqqCDQMBsh82fVC3RKdkiF+Bmr/9Ydojg=;
 b=eHVIS+j0QNkJQovTzh31miyDo/gdEaCiAW0mDdzNW6+Xu2ClksbZ2qBDSG3PWmx3jg
 MW0JNbyuWcJW+GjuH8sDghpG7/HID5xej7028XPxZYIhr7/5jluiSrumxiF/aBAVdHdA
 rEF9iUYDJiZ428f+j5M424fWAhbJoSxCanfot4955RgPnV85CXjYUsghr9J6L1Jss9Jr
 XBp7FRRrlhB1PjAxMtYiVC+KQWkU1AMQUlj/7t7Ao8Mg5gsZj1bl841k4FrYKYBtghFX
 5mPgNoi3InDkZxPMQKfEUfWU2czqzSTWhZg1OWi363SE2y46VdRdNezrL8KoyQry7ZNI
 YZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754090777; x=1754695577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeeV1u3q4RgqqCDQMBsh82fVC3RKdkiF+Bmr/9Ydojg=;
 b=tXk5RYMfR/JyZ1DnyLGi8UK1J2bA8BekZPzLkPTD044OR/MIGaKyJ1ntOt5v9pPXFh
 sDA8GwqbnnoTvblGkqmUFXB8vMK/lwvkPaXTiA/RTzi4xkn2kYTqZrfN60+izMkP5SMQ
 2cGjmP8zi2CErxB9mfE1y46KZk4X0v/EBPbRnijR0yfNMeIQHpxYXlSoF/AePOhjmZ7I
 FPUjfERXBW3hOvrrk1vXNx+1HVmIFlMG49ivX2Q7jEXFcUrnb15kD3X0MTBYipd0tr41
 kXE3uFIadFQyXC/FS5Du/XHJ2lAFM0q5AsEEZovgfKN83iEhEKtpx0clZ+Y0FLb6wRkY
 khcQ==
X-Gm-Message-State: AOJu0YzuQjcr4DGre3QBpDraCCcCBiooVdWuYpDYT9I3V1nEGAjceHPl
 1/mG4dQEG+H5wk+eORWpYbNsrkntSJDyROKq+xJzOx4czjqe3lDh5qU7ceSWfrenONFgMzFUQA1
 nyk1SrUU=
X-Gm-Gg: ASbGnctVNy8eJQXS40gvc9dgKwREwbhukxeTqT5Xttg1tauFRHVs+f48bpO8aorq9Zy
 YWoBGjMMak9i317WR7oLQU/BwcxdRXD2zXGu0F3TQk39owWXAz5YoxtjdA6heQGDcxXWPkoHMFn
 of3flfT4BCLzeGnYbxJ5C05BynSbOhYi+l4Ulm9c2S0uWx/dABZ/pr3RqJmid8hmMHmUkbVGv8Z
 mCGjU4XnnxBvY3BBNfSCZEzxS+8B6p76tOo6gUUPRRS2S43r0Ekpfj2CoTt6YvEc3wWc9Z18rEu
 1Z0mtMTpz5mkK34mDZFsdwVdllOzGIwQlWQgmWQeyom6qVOMAsYq/sQQs0usiU/Y88tUdOO8d+y
 xcizyZBF6jTSfOseyFj9tMW7pPY7IdWwj
X-Google-Smtp-Source: AGHT+IGM2c9xz266BbZEOokQcgwYVnYNMAKS0fJBGnLI9S8eKNPXJMSWDvQWa3PlSQrBqgzmmg4lRA==
X-Received: by 2002:a17:90b:4c47:b0:313:f6fa:5bb5 with SMTP id
 98e67ed59e1d1-321162bcfd6mr2438520a91.18.1754090777221; 
 Fri, 01 Aug 2025 16:26:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eca6d3asm5628217a91.23.2025.08.01.16.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 16:26:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 01/11] semihosting/syscalls: compile once in system and per
 target for user mode
Date: Fri,  1 Aug 2025 16:25:59 -0700
Message-ID: <20250801232609.2744557-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We replace target_ulong mechanically by uint64_t.
We can't compile (easily) this code once for user, as it relies on
various target/function types, so leave it in specific_ss for user mode.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/semihosting/syscalls.h | 30 ++++++------
 semihosting/arm-compat-semi.c  |  1 +
 semihosting/syscalls.c         | 89 +++++++++++++++++-----------------
 semihosting/meson.build        |  4 +-
 4 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index 6627c45fb28..03aa45b7bb9 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -9,7 +9,7 @@
 #ifndef SEMIHOSTING_SYSCALLS_H
 #define SEMIHOSTING_SYSCALLS_H
 
-#include "exec/cpu-defs.h"
+#include "exec/vaddr.h"
 #include "gdbstub/syscalls.h"
 
 /*
@@ -24,23 +24,23 @@
 typedef struct GuestFD GuestFD;
 
 void semihost_sys_open(CPUState *cs, gdb_syscall_complete_cb complete,
-                       target_ulong fname, target_ulong fname_len,
+                       vaddr fname, uint64_t fname_len,
                        int gdb_flags, int mode);
 
 void semihost_sys_close(CPUState *cs, gdb_syscall_complete_cb complete,
                         int fd);
 
 void semihost_sys_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                       int fd, target_ulong buf, target_ulong len);
+                       int fd, vaddr buf, uint64_t len);
 
 void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complete,
-                          GuestFD *gf, target_ulong buf, target_ulong len);
+                          GuestFD *gf, vaddr buf, uint64_t len);
 
 void semihost_sys_write(CPUState *cs, gdb_syscall_complete_cb complete,
-                        int fd, target_ulong buf, target_ulong len);
+                        int fd, vaddr buf, uint64_t len);
 
 void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb complete,
-                           GuestFD *gf, target_ulong buf, target_ulong len);
+                           GuestFD *gf, vaddr buf, uint64_t len);
 
 void semihost_sys_lseek(CPUState *cs, gdb_syscall_complete_cb complete,
                         int fd, int64_t off, int gdb_whence);
@@ -50,27 +50,27 @@ void semihost_sys_isatty(CPUState *cs, gdb_syscall_complete_cb complete,
 
 void semihost_sys_flen(CPUState *cs, gdb_syscall_complete_cb fstat_cb,
                        gdb_syscall_complete_cb flen_cb,
-                       int fd, target_ulong fstat_addr);
+                       int fd, vaddr fstat_addr);
 
 void semihost_sys_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
-                        int fd, target_ulong addr);
+                        int fd, vaddr addr);
 
 void semihost_sys_stat(CPUState *cs, gdb_syscall_complete_cb complete,
-                       target_ulong fname, target_ulong fname_len,
-                       target_ulong addr);
+                       vaddr fname, uint64_t fname_len,
+                       vaddr addr);
 
 void semihost_sys_remove(CPUState *cs, gdb_syscall_complete_cb complete,
-                         target_ulong fname, target_ulong fname_len);
+                         vaddr fname, uint64_t fname_len);
 
 void semihost_sys_rename(CPUState *cs, gdb_syscall_complete_cb complete,
-                         target_ulong oname, target_ulong oname_len,
-                         target_ulong nname, target_ulong nname_len);
+                         vaddr oname, uint64_t oname_len,
+                         vaddr nname, uint64_t nname_len);
 
 void semihost_sys_system(CPUState *cs, gdb_syscall_complete_cb complete,
-                         target_ulong cmd, target_ulong cmd_len);
+                         vaddr cmd, uint64_t cmd_len);
 
 void semihost_sys_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
-                               target_ulong tv_addr, target_ulong tz_addr);
+                               vaddr tv_addr, vaddr tz_addr);
 
 void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
                            int fd, GIOCondition cond, int timeout);
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 86e5260e504..40dc778529d 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -34,6 +34,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "exec/gdbstub.h"
+#include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index f6451d9bb0e..f072d919193 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/guestfd.h"
 #include "semihosting/syscalls.h"
@@ -23,7 +22,7 @@
 /*
  * Validate or compute the length of the string (including terminator).
  */
-static int validate_strlen(CPUState *cs, target_ulong str, target_ulong tlen)
+static int validate_strlen(CPUState *cs, uint64_t str, uint64_t tlen)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char c;
@@ -52,7 +51,7 @@ static int validate_strlen(CPUState *cs, target_ulong str, target_ulong tlen)
 }
 
 static int validate_lock_user_string(char **pstr, CPUState *cs,
-                                     target_ulong tstr, target_ulong tlen)
+                                     uint64_t tstr, uint64_t tlen)
 {
     int ret = validate_strlen(cs, tstr, tlen);
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
@@ -72,7 +71,7 @@ static int validate_lock_user_string(char **pstr, CPUState *cs,
  * big-endian.  Until we do something with gdb, also produce the
  * same big-endian result from the host.
  */
-static int copy_stat_to_user(CPUState *cs, target_ulong addr,
+static int copy_stat_to_user(CPUState *cs, uint64_t addr,
                              const struct stat *s)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
@@ -129,7 +128,7 @@ static void gdb_open_cb(CPUState *cs, uint64_t ret, int err)
 }
 
 static void gdb_open(CPUState *cs, gdb_syscall_complete_cb complete,
-                     target_ulong fname, target_ulong fname_len,
+                     uint64_t fname, uint64_t fname_len,
                      int gdb_flags, int mode)
 {
     int len = validate_strlen(cs, fname, fname_len);
@@ -151,14 +150,14 @@ static void gdb_close(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void gdb_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                     GuestFD *gf, target_ulong buf, target_ulong len)
+                     GuestFD *gf, uint64_t buf, uint64_t len)
 {
     gdb_do_syscall(complete, "read,%x,%lx,%lx",
                    (uint32_t)gf->hostfd, (uint64_t)buf, (uint64_t)len);
 }
 
 static void gdb_write(CPUState *cs, gdb_syscall_complete_cb complete,
-                      GuestFD *gf, target_ulong buf, target_ulong len)
+                      GuestFD *gf, uint64_t buf, uint64_t len)
 {
     gdb_do_syscall(complete, "write,%x,%lx,%lx",
                    (uint32_t)gf->hostfd, (uint64_t)buf, (uint64_t)len);
@@ -178,15 +177,15 @@ static void gdb_isatty(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void gdb_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
-                      GuestFD *gf, target_ulong addr)
+                      GuestFD *gf, uint64_t addr)
 {
     gdb_do_syscall(complete, "fstat,%x,%lx",
                    (uint32_t)gf->hostfd, (uint64_t)addr);
 }
 
 static void gdb_stat(CPUState *cs, gdb_syscall_complete_cb complete,
-                     target_ulong fname, target_ulong fname_len,
-                     target_ulong addr)
+                     uint64_t fname, uint64_t fname_len,
+                     uint64_t addr)
 {
     int len = validate_strlen(cs, fname, fname_len);
     if (len < 0) {
@@ -199,7 +198,7 @@ static void gdb_stat(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void gdb_remove(CPUState *cs, gdb_syscall_complete_cb complete,
-                       target_ulong fname, target_ulong fname_len)
+                       uint64_t fname, uint64_t fname_len)
 {
     int len = validate_strlen(cs, fname, fname_len);
     if (len < 0) {
@@ -211,8 +210,8 @@ static void gdb_remove(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void gdb_rename(CPUState *cs, gdb_syscall_complete_cb complete,
-                       target_ulong oname, target_ulong oname_len,
-                       target_ulong nname, target_ulong nname_len)
+                       uint64_t oname, uint64_t oname_len,
+                       uint64_t nname, uint64_t nname_len)
 {
     int olen, nlen;
 
@@ -233,7 +232,7 @@ static void gdb_rename(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void gdb_system(CPUState *cs, gdb_syscall_complete_cb complete,
-                       target_ulong cmd, target_ulong cmd_len)
+                       uint64_t cmd, uint64_t cmd_len)
 {
     int len = validate_strlen(cs, cmd, cmd_len);
     if (len < 0) {
@@ -245,7 +244,7 @@ static void gdb_system(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void gdb_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
-                             target_ulong tv_addr, target_ulong tz_addr)
+                             uint64_t tv_addr, uint64_t tz_addr)
 {
     gdb_do_syscall(complete, "gettimeofday,%lx,%lx",
                    (uint64_t)tv_addr, (uint64_t)tz_addr);
@@ -256,7 +255,7 @@ static void gdb_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
  */
 
 static void host_open(CPUState *cs, gdb_syscall_complete_cb complete,
-                      target_ulong fname, target_ulong fname_len,
+                      uint64_t fname, uint64_t fname_len,
                       int gdb_flags, int mode)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
@@ -316,7 +315,7 @@ static void host_close(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                      GuestFD *gf, target_ulong buf, target_ulong len)
+                      GuestFD *gf, uint64_t buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     void *ptr = lock_user(VERIFY_WRITE, buf, len, 0);
@@ -337,7 +336,7 @@ static void host_read(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_write(CPUState *cs, gdb_syscall_complete_cb complete,
-                       GuestFD *gf, target_ulong buf, target_ulong len)
+                       GuestFD *gf, uint64_t buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     void *ptr = lock_user(VERIFY_READ, buf, len, 1);
@@ -395,7 +394,7 @@ static void host_flen(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
-                       GuestFD *gf, target_ulong addr)
+                       GuestFD *gf, uint64_t addr)
 {
     struct stat buf;
     int ret;
@@ -410,8 +409,8 @@ static void host_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_stat(CPUState *cs, gdb_syscall_complete_cb complete,
-                      target_ulong fname, target_ulong fname_len,
-                      target_ulong addr)
+                      uint64_t fname, uint64_t fname_len,
+                      uint64_t addr)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     struct stat buf;
@@ -440,7 +439,7 @@ static void host_stat(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_remove(CPUState *cs, gdb_syscall_complete_cb complete,
-                        target_ulong fname, target_ulong fname_len)
+                        uint64_t fname, uint64_t fname_len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *p;
@@ -458,8 +457,8 @@ static void host_remove(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_rename(CPUState *cs, gdb_syscall_complete_cb complete,
-                        target_ulong oname, target_ulong oname_len,
-                        target_ulong nname, target_ulong nname_len)
+                        uint64_t oname, uint64_t oname_len,
+                        uint64_t nname, uint64_t nname_len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ostr, *nstr;
@@ -484,7 +483,7 @@ static void host_rename(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_system(CPUState *cs, gdb_syscall_complete_cb complete,
-                        target_ulong cmd, target_ulong cmd_len)
+                        uint64_t cmd, uint64_t cmd_len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *p;
@@ -502,7 +501,7 @@ static void host_system(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
-                              target_ulong tv_addr, target_ulong tz_addr)
+                              uint64_t tv_addr, uint64_t tz_addr)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     struct gdb_timeval *p;
@@ -547,10 +546,10 @@ static void host_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
  */
 
 static void staticfile_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                            GuestFD *gf, target_ulong buf, target_ulong len)
+                            GuestFD *gf, uint64_t buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
-    target_ulong rest = gf->staticfile.len - gf->staticfile.off;
+    uint64_t rest = gf->staticfile.len - gf->staticfile.off;
     void *ptr;
 
     if (len > rest) {
@@ -605,7 +604,7 @@ static void staticfile_flen(CPUState *cs, gdb_syscall_complete_cb complete,
  */
 
 static void console_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                         GuestFD *gf, target_ulong buf, target_ulong len)
+                         GuestFD *gf, uint64_t buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ptr;
@@ -622,7 +621,7 @@ static void console_read(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void console_write(CPUState *cs, gdb_syscall_complete_cb complete,
-                          GuestFD *gf, target_ulong buf, target_ulong len)
+                          GuestFD *gf, uint64_t buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ptr = lock_user(VERIFY_READ, buf, len, 1);
@@ -638,7 +637,7 @@ static void console_write(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void console_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
-                          GuestFD *gf, target_ulong addr)
+                          GuestFD *gf, uint64_t addr)
 {
     static const struct stat tty_buf = {
         .st_mode = 020666,  /* S_IFCHR, ugo+rw */
@@ -683,7 +682,7 @@ static void console_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
  */
 
 void semihost_sys_open(CPUState *cs, gdb_syscall_complete_cb complete,
-                       target_ulong fname, target_ulong fname_len,
+                       vaddr fname, uint64_t fname_len,
                        int gdb_flags, int mode)
 {
     if (use_gdb_syscalls()) {
@@ -719,7 +718,7 @@ void semihost_sys_close(CPUState *cs, gdb_syscall_complete_cb complete, int fd)
 }
 
 void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complete,
-                          GuestFD *gf, target_ulong buf, target_ulong len)
+                          GuestFD *gf, vaddr buf, uint64_t len)
 {
     /*
      * Bound length for 64-bit guests on 32-bit hosts, not overflowing ssize_t.
@@ -748,7 +747,7 @@ void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 void semihost_sys_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                       int fd, target_ulong buf, target_ulong len)
+                       int fd, vaddr buf, uint64_t len)
 {
     GuestFD *gf = get_guestfd(fd);
 
@@ -760,7 +759,7 @@ void semihost_sys_read(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb complete,
-                           GuestFD *gf, target_ulong buf, target_ulong len)
+                           GuestFD *gf, vaddr buf, uint64_t len)
 {
     /*
      * Bound length for 64-bit guests on 32-bit hosts, not overflowing ssize_t.
@@ -790,7 +789,7 @@ void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 void semihost_sys_write(CPUState *cs, gdb_syscall_complete_cb complete,
-                        int fd, target_ulong buf, target_ulong len)
+                        int fd, vaddr buf, uint64_t len)
 {
     GuestFD *gf = get_guestfd(fd);
 
@@ -856,7 +855,7 @@ void semihost_sys_isatty(CPUState *cs, gdb_syscall_complete_cb complete, int fd)
 
 void semihost_sys_flen(CPUState *cs, gdb_syscall_complete_cb fstat_cb,
                        gdb_syscall_complete_cb flen_cb, int fd,
-                       target_ulong fstat_addr)
+                       vaddr fstat_addr)
 {
     GuestFD *gf = get_guestfd(fd);
 
@@ -881,7 +880,7 @@ void semihost_sys_flen(CPUState *cs, gdb_syscall_complete_cb fstat_cb,
 }
 
 void semihost_sys_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
-                        int fd, target_ulong addr)
+                        int fd, vaddr addr)
 {
     GuestFD *gf = get_guestfd(fd);
 
@@ -906,8 +905,8 @@ void semihost_sys_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 void semihost_sys_stat(CPUState *cs, gdb_syscall_complete_cb complete,
-                       target_ulong fname, target_ulong fname_len,
-                       target_ulong addr)
+                       vaddr fname, uint64_t fname_len,
+                       vaddr addr)
 {
     if (use_gdb_syscalls()) {
         gdb_stat(cs, complete, fname, fname_len, addr);
@@ -917,7 +916,7 @@ void semihost_sys_stat(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 void semihost_sys_remove(CPUState *cs, gdb_syscall_complete_cb complete,
-                         target_ulong fname, target_ulong fname_len)
+                         vaddr fname, uint64_t fname_len)
 {
     if (use_gdb_syscalls()) {
         gdb_remove(cs, complete, fname, fname_len);
@@ -927,8 +926,8 @@ void semihost_sys_remove(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 void semihost_sys_rename(CPUState *cs, gdb_syscall_complete_cb complete,
-                         target_ulong oname, target_ulong oname_len,
-                         target_ulong nname, target_ulong nname_len)
+                         vaddr oname, uint64_t oname_len,
+                         vaddr nname, uint64_t nname_len)
 {
     if (use_gdb_syscalls()) {
         gdb_rename(cs, complete, oname, oname_len, nname, nname_len);
@@ -938,7 +937,7 @@ void semihost_sys_rename(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 void semihost_sys_system(CPUState *cs, gdb_syscall_complete_cb complete,
-                         target_ulong cmd, target_ulong cmd_len)
+                         vaddr cmd, uint64_t cmd_len)
 {
     if (use_gdb_syscalls()) {
         gdb_system(cs, complete, cmd, cmd_len);
@@ -948,7 +947,7 @@ void semihost_sys_system(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 void semihost_sys_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
-                               target_ulong tv_addr, target_ulong tz_addr)
+                               vaddr tv_addr, vaddr tz_addr)
 {
     if (use_gdb_syscalls()) {
         gdb_gettimeofday(cs, complete, tv_addr, tz_addr);
diff --git a/semihosting/meson.build b/semihosting/meson.build
index b1ab2506c6e..77200a7f27b 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'guestfd.c',
-  'syscalls.c',
 ))
 
 common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
@@ -9,9 +8,12 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
   'uaccess.c',
+  'syscalls.c',
 ), if_false: files(
   'stubs-system.c',
 ))
 
+specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
+                if_true: files('syscalls.c'))
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.47.2


