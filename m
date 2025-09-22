Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C678CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d0p-0004e2-S7; Mon, 22 Sep 2025 05:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czc-0002Qf-NQ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:38:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cz9-0000fo-Ki
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45dd5e24d16so40131425e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533844; x=1759138644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcPukW9mtIUHAUBp8jxaYoUAYF89W1SMYnteBY4oBnY=;
 b=m22+zmulqqKV1+4/jESIxTzHuJboLqMz0/h40d5HSPS2KtoTxG4pm08q44Q5NClz+k
 ovGZC38R4qwAjOnOMWHjcBaVLFYn71+Rhkf10T8rtVHGDushlCITNP9XYzBx+61eGinS
 sQc82UCIEKCeYaMuQHJdlUuQilRugMDlfz/xun2e+NaqYx7Pham4cnANA8J5Mkn8gaKJ
 GZuRPRFM9yJC34uXBv7uIXEUiEStZcD2iNiluSeIix5swGnSkk6o0VHwDhYwJ/XCB+OY
 cLhGZZUEZbSbBXbTF/jwPEiSOafl1nMb67Rz3sfyR7a7EHERUDreHFgmeF8UDWZiJPyg
 MqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533844; x=1759138644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcPukW9mtIUHAUBp8jxaYoUAYF89W1SMYnteBY4oBnY=;
 b=n9Ai6A8brr87ZGBibsj7maOThJfFtb9/QcS3ud76nEpWDAxaKi61muyKWj9UWthPyg
 Q+a7NYuJfp/z9n31ck58O0FDMXVvWiUre+mI69wgEKlQO4a2FxzQ1OTc0YmdDR52+4eZ
 gim7Tgm7vQ6/IBKdKOqObmOtSiZbsbXXO9zD7BIqy+vtYiCJ8NAwNve2rCtoL6Blz5mz
 BJvSby6dPNh/U7pKMnoonsVqpYqiKxPvnLoH5xx6cqJFVvW5NyyiHwKKA679XU1rh75V
 EWVGXOnghsw0YV8qn34R3BmXv9R8wJWJxG0bcrRLCTty5XhKoDo7apwKMWOLgpQciDQ0
 sAEA==
X-Gm-Message-State: AOJu0YyVcRw6V6/jn3yqVNMljR0Tp8LrX1zjhwMexfW+vkQDOW20BT2R
 Sk7j98TIL2vXl+QHqXfqbaAnxc+m0jsr53zj6cQ2KiKA6nlRNfoUMbqFiCsDdAF3wEo=
X-Gm-Gg: ASbGnctFSkaJ1SZaQqq3DGqPdkpbXvhxK8Iu5PgTux4zadPzmEGEb9og7u/lEIqfLU9
 o62HbN5RQ+iczgS1SwSBAnVZxzudCvY2EWxseTIGrfJscSFb3QjZPAf399x7zHK3VmUzydzNhh4
 mUDO4v+JLZ3F5JamRm0/4dzk7nANGrVHOMNWkprSTZQ0sRCFJk+KFj4ZF17kMevc7C7b4LZjnrc
 Otmvv0knPXlc/3SLJjnCsiQY8ZDImA+4Vnnibx//1WbhkRlVIwxL8v5ZwUW/2QsBaLrFCnA2YKQ
 Fxla1ly3fA/HGArBL+g1bwiaKAgZcFbieS9o+eS7wP9Cxc75SelYTpON1jEA3gsMoolke7PW07c
 2dS1yYaS9fSKIGWn5+68VcTA=
X-Google-Smtp-Source: AGHT+IGsUBp1NqafwcbALwg7UwDN4rTjCYc92dl7M1piUEbdRsb5ea8yuyhueyCJpDcb+0E7dS+OzQ==
X-Received: by 2002:a05:600c:3593:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-467e6b64adbmr110656125e9.1.1758533843575; 
 Mon, 22 Sep 2025 02:37:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee1227cc37sm17817268f8f.7.2025.09.22.02.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0112A5F9EB;
 Mon, 22 Sep 2025 10:37:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 05/25] semihosting/syscalls: replace uint64_t with vaddr where
 appropriate
Date: Mon, 22 Sep 2025 10:36:50 +0100
Message-ID: <20250922093711.2768983-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/syscalls.c | 78 +++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index f072d919193..20f155f869a 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -22,7 +22,7 @@
 /*
  * Validate or compute the length of the string (including terminator).
  */
-static int validate_strlen(CPUState *cs, uint64_t str, uint64_t tlen)
+static int validate_strlen(CPUState *cs, vaddr str, uint64_t tlen)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char c;
@@ -51,7 +51,7 @@ static int validate_strlen(CPUState *cs, uint64_t str, uint64_t tlen)
 }
 
 static int validate_lock_user_string(char **pstr, CPUState *cs,
-                                     uint64_t tstr, uint64_t tlen)
+                                     vaddr tstr, uint64_t tlen)
 {
     int ret = validate_strlen(cs, tstr, tlen);
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
@@ -71,7 +71,7 @@ static int validate_lock_user_string(char **pstr, CPUState *cs,
  * big-endian.  Until we do something with gdb, also produce the
  * same big-endian result from the host.
  */
-static int copy_stat_to_user(CPUState *cs, uint64_t addr,
+static int copy_stat_to_user(CPUState *cs, vaddr addr,
                              const struct stat *s)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
@@ -128,7 +128,7 @@ static void gdb_open_cb(CPUState *cs, uint64_t ret, int err)
 }
 
 static void gdb_open(CPUState *cs, gdb_syscall_complete_cb complete,
-                     uint64_t fname, uint64_t fname_len,
+                     vaddr fname, uint64_t fname_len,
                      int gdb_flags, int mode)
 {
     int len = validate_strlen(cs, fname, fname_len);
@@ -139,7 +139,7 @@ static void gdb_open(CPUState *cs, gdb_syscall_complete_cb complete,
 
     gdb_open_complete = complete;
     gdb_do_syscall(gdb_open_cb, "open,%s,%x,%x",
-                   (uint64_t)fname, (uint32_t)len,
+                   (vaddr)fname, (uint32_t)len,
                    (uint32_t)gdb_flags, (uint32_t)mode);
 }
 
@@ -150,17 +150,17 @@ static void gdb_close(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void gdb_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                     GuestFD *gf, uint64_t buf, uint64_t len)
+                     GuestFD *gf, vaddr buf, uint64_t len)
 {
     gdb_do_syscall(complete, "read,%x,%lx,%lx",
-                   (uint32_t)gf->hostfd, (uint64_t)buf, (uint64_t)len);
+                   (uint32_t)gf->hostfd, (vaddr)buf, (uint64_t)len);
 }
 
 static void gdb_write(CPUState *cs, gdb_syscall_complete_cb complete,
-                      GuestFD *gf, uint64_t buf, uint64_t len)
+                      GuestFD *gf, vaddr buf, uint64_t len)
 {
     gdb_do_syscall(complete, "write,%x,%lx,%lx",
-                   (uint32_t)gf->hostfd, (uint64_t)buf, (uint64_t)len);
+                   (uint32_t)gf->hostfd, (vaddr)buf, (uint64_t)len);
 }
 
 static void gdb_lseek(CPUState *cs, gdb_syscall_complete_cb complete,
@@ -177,15 +177,15 @@ static void gdb_isatty(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void gdb_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
-                      GuestFD *gf, uint64_t addr)
+                      GuestFD *gf, vaddr addr)
 {
     gdb_do_syscall(complete, "fstat,%x,%lx",
-                   (uint32_t)gf->hostfd, (uint64_t)addr);
+                   (uint32_t)gf->hostfd, (vaddr)addr);
 }
 
 static void gdb_stat(CPUState *cs, gdb_syscall_complete_cb complete,
-                     uint64_t fname, uint64_t fname_len,
-                     uint64_t addr)
+                     vaddr fname, uint64_t fname_len,
+                     vaddr addr)
 {
     int len = validate_strlen(cs, fname, fname_len);
     if (len < 0) {
@@ -194,11 +194,11 @@ static void gdb_stat(CPUState *cs, gdb_syscall_complete_cb complete,
     }
 
     gdb_do_syscall(complete, "stat,%s,%lx",
-                   (uint64_t)fname, (uint32_t)len, (uint64_t)addr);
+                   (vaddr)fname, (uint32_t)len, (vaddr)addr);
 }
 
 static void gdb_remove(CPUState *cs, gdb_syscall_complete_cb complete,
-                       uint64_t fname, uint64_t fname_len)
+                       vaddr fname, uint64_t fname_len)
 {
     int len = validate_strlen(cs, fname, fname_len);
     if (len < 0) {
@@ -206,12 +206,12 @@ static void gdb_remove(CPUState *cs, gdb_syscall_complete_cb complete,
         return;
     }
 
-    gdb_do_syscall(complete, "unlink,%s", (uint64_t)fname, (uint32_t)len);
+    gdb_do_syscall(complete, "unlink,%s", (vaddr)fname, (uint32_t)len);
 }
 
 static void gdb_rename(CPUState *cs, gdb_syscall_complete_cb complete,
-                       uint64_t oname, uint64_t oname_len,
-                       uint64_t nname, uint64_t nname_len)
+                       vaddr oname, uint64_t oname_len,
+                       vaddr nname, uint64_t nname_len)
 {
     int olen, nlen;
 
@@ -227,12 +227,12 @@ static void gdb_rename(CPUState *cs, gdb_syscall_complete_cb complete,
     }
 
     gdb_do_syscall(complete, "rename,%s,%s",
-                   (uint64_t)oname, (uint32_t)olen,
-                   (uint64_t)nname, (uint32_t)nlen);
+                   (vaddr)oname, (uint32_t)olen,
+                   (vaddr)nname, (uint32_t)nlen);
 }
 
 static void gdb_system(CPUState *cs, gdb_syscall_complete_cb complete,
-                       uint64_t cmd, uint64_t cmd_len)
+                       vaddr cmd, uint64_t cmd_len)
 {
     int len = validate_strlen(cs, cmd, cmd_len);
     if (len < 0) {
@@ -240,14 +240,14 @@ static void gdb_system(CPUState *cs, gdb_syscall_complete_cb complete,
         return;
     }
 
-    gdb_do_syscall(complete, "system,%s", (uint64_t)cmd, (uint32_t)len);
+    gdb_do_syscall(complete, "system,%s", (vaddr)cmd, (uint32_t)len);
 }
 
 static void gdb_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
-                             uint64_t tv_addr, uint64_t tz_addr)
+                             vaddr tv_addr, vaddr tz_addr)
 {
     gdb_do_syscall(complete, "gettimeofday,%lx,%lx",
-                   (uint64_t)tv_addr, (uint64_t)tz_addr);
+                   (vaddr)tv_addr, (vaddr)tz_addr);
 }
 
 /*
@@ -255,7 +255,7 @@ static void gdb_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
  */
 
 static void host_open(CPUState *cs, gdb_syscall_complete_cb complete,
-                      uint64_t fname, uint64_t fname_len,
+                      vaddr fname, uint64_t fname_len,
                       int gdb_flags, int mode)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
@@ -315,7 +315,7 @@ static void host_close(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                      GuestFD *gf, uint64_t buf, uint64_t len)
+                      GuestFD *gf, vaddr buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     void *ptr = lock_user(VERIFY_WRITE, buf, len, 0);
@@ -336,7 +336,7 @@ static void host_read(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_write(CPUState *cs, gdb_syscall_complete_cb complete,
-                       GuestFD *gf, uint64_t buf, uint64_t len)
+                       GuestFD *gf, vaddr buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     void *ptr = lock_user(VERIFY_READ, buf, len, 1);
@@ -394,7 +394,7 @@ static void host_flen(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
-                       GuestFD *gf, uint64_t addr)
+                       GuestFD *gf, vaddr addr)
 {
     struct stat buf;
     int ret;
@@ -409,8 +409,8 @@ static void host_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_stat(CPUState *cs, gdb_syscall_complete_cb complete,
-                      uint64_t fname, uint64_t fname_len,
-                      uint64_t addr)
+                      vaddr fname, uint64_t fname_len,
+                      vaddr addr)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     struct stat buf;
@@ -439,7 +439,7 @@ static void host_stat(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_remove(CPUState *cs, gdb_syscall_complete_cb complete,
-                        uint64_t fname, uint64_t fname_len)
+                        vaddr fname, uint64_t fname_len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *p;
@@ -457,8 +457,8 @@ static void host_remove(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_rename(CPUState *cs, gdb_syscall_complete_cb complete,
-                        uint64_t oname, uint64_t oname_len,
-                        uint64_t nname, uint64_t nname_len)
+                        vaddr oname, uint64_t oname_len,
+                        vaddr nname, uint64_t nname_len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ostr, *nstr;
@@ -483,7 +483,7 @@ static void host_rename(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_system(CPUState *cs, gdb_syscall_complete_cb complete,
-                        uint64_t cmd, uint64_t cmd_len)
+                        vaddr cmd, uint64_t cmd_len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *p;
@@ -501,7 +501,7 @@ static void host_system(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void host_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
-                              uint64_t tv_addr, uint64_t tz_addr)
+                              vaddr tv_addr, vaddr tz_addr)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     struct gdb_timeval *p;
@@ -546,7 +546,7 @@ static void host_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
  */
 
 static void staticfile_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                            GuestFD *gf, uint64_t buf, uint64_t len)
+                            GuestFD *gf, vaddr buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     uint64_t rest = gf->staticfile.len - gf->staticfile.off;
@@ -604,7 +604,7 @@ static void staticfile_flen(CPUState *cs, gdb_syscall_complete_cb complete,
  */
 
 static void console_read(CPUState *cs, gdb_syscall_complete_cb complete,
-                         GuestFD *gf, uint64_t buf, uint64_t len)
+                         GuestFD *gf, vaddr buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ptr;
@@ -621,7 +621,7 @@ static void console_read(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void console_write(CPUState *cs, gdb_syscall_complete_cb complete,
-                          GuestFD *gf, uint64_t buf, uint64_t len)
+                          GuestFD *gf, vaddr buf, uint64_t len)
 {
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ptr = lock_user(VERIFY_READ, buf, len, 1);
@@ -637,7 +637,7 @@ static void console_write(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 
 static void console_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
-                          GuestFD *gf, uint64_t addr)
+                          GuestFD *gf, vaddr addr)
 {
     static const struct stat tty_buf = {
         .st_mode = 020666,  /* S_IFCHR, ugo+rw */
-- 
2.47.3


