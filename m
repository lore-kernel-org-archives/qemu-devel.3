Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13219CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LB-00081w-VR; Fri, 26 Sep 2025 09:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28L9-00080f-0Z
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kq-00042K-SN
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:22 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so1816564f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892669; x=1759497469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wog2u7ZRqBCvVQUI8DPnDXMtSGN90PRtiQocp7urOxA=;
 b=l8mk9V4r8RGsVbrqIJDHGQfcI7uWc6W6EP/qwjzlqCmfM97T5lBBn+nd+jYmp43EOz
 +ScvPJy+npCx1bhNRPkmg9XGkBjsOzRU0JJF5U5yZZIoicV8v5mHJCH/VlQ9FUBhd8uO
 3rQOHT7662MKtS0yyX3P+lZgANYjTPC+1W+pMNYRHeOvx+qxNn6ZYxek2A7ve3cHxi4y
 2Af/MTgM1T9SqbwA24Vbc1tO5RBgNM3yujUMTxOSyT0Z50GgWyJa0g4d99hiSt7Of1Ze
 XbNtjxsY/YLP/OCtVx5fsHycPpCaZpH2ItTenJPn1bzBJyHQk+ukIC3KRuSgEddv4/yY
 t4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892670; x=1759497470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wog2u7ZRqBCvVQUI8DPnDXMtSGN90PRtiQocp7urOxA=;
 b=p2OwIUhOZ+o1HZPXijzZyxSoBE6dBQQLVCR3DFWLAMI9zztS0S+gDIKUuS6v2TQE5N
 9394KWif2MDB5W/LvMn4Uu/oYR4zpZa1Xp3sYEqYCiDqshM8Iu4OgXXG67DR3p6x4q2l
 7dLBCobD+U49DvzIMve/WUtcr2nsKeP4dC/wIvTqgrER/Upgds+pIkK55N6N3hX6P92J
 QgwRV4xZHYY4gAH5uJHBQva7c0PkfjI9rjttsk+oG/d2G3q+cmlTwHV5cU5V9IxZ5RjJ
 PvANbLprT6odXhWOOOuITSX/Zt2e99YyFdwdd/f9hA0+5fKB8dM4d+py2Atj7Fb6JN/i
 HA9g==
X-Gm-Message-State: AOJu0Yy6qkRrLHiscgPJBJFu/znfEDk+Q1KgqJ8TszB/jvZIHHDsRIi6
 laUaV/X9ujWxmNrGOo5VMtapOVjF95v9sx6jkzgjDAad+PQ58gPR4VhhGksA4WWYt9I=
X-Gm-Gg: ASbGncsn+tP83shfJl4Nzz/GngSm8a8f3GbfI00Qxi16Dtl3yGxIMfnKV93CffgMgwz
 jtm/VF691Ryc1Gxo/CMOyNoOdZXSxK1VVjzuHKBN8vWyLQIYdspfkTmKQ5ppJw4eXM8z5DB2Cnq
 Q0f6ktpChrqsrZqFJN/DzPeVl1JTYY44xQJeV8EtzkEMro9Xdy7pc5ilRYUJ+0oXLJWc9qnOnqX
 PDbi3ke4GPnWl0VdIdsZrRn+tp2yMKdmJotFR66LmSbc6KshHac0KC4oA4upALE9QMpZoi3PKeJ
 Cndtu/UxgFWgPtOxIzJYWcrO2aw9/wcY31cttvnuU4tSiGGHkJdlFlJQURR2WBHT6HgaashfuUE
 jZ3G6TKQwIaQEV0/avFut1xZmOUd1P0EhLQ==
X-Google-Smtp-Source: AGHT+IEPwCnkNMZ7ZM1XdFg6nGJN7t8pwLovdGHDGkfo+OxeCTdPoVqtWDhmyCK5F3erCw5Yz6oZKw==
X-Received: by 2002:a05:6000:1447:b0:3e8:e52:31c5 with SMTP id
 ffacd0b85a97d-40e468e626emr6823674f8f.2.1758892669524; 
 Fri, 26 Sep 2025 06:17:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603365sm7353419f8f.37.2025.09.26.06.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 019505F8B1;
 Fri, 26 Sep 2025 14:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/24] semihosting/syscalls: compile once in system and per
 target for user mode
Date: Fri, 26 Sep 2025 14:17:22 +0100
Message-ID: <20250926131744.432185-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We replace target_ulong mechanically by uint64_t.
We can't compile (easily) this code once for user, as it relies on
various target/function types, so leave it in specific_ss for user mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-5-alex.bennee@linaro.org>

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
index bcd13cd6dfd..64ddc749bf8 100644
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
2.47.3


