Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF484C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0lh-0005sE-Ji; Mon, 04 Aug 2025 15:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06O-00014j-K7
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06J-0000tR-Ve
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:02 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76bd6e84eddso4565862b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332798; x=1754937598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uf+KywRMYJZdnc5WkH+t5Y1kT4Zel1cp7zy1z3bbj/0=;
 b=p9hbM564YSpB+SmesexRjXMWN6kdknN2zPtQ4vhbzTh+3aDtFRkg9y8K54e6J2GYDX
 0gmdHkI2nbD45sBBLy3VoijEmCE1TvP3xOFYFZlZURSZZbR4PFGBMUjrZa0EMC7je5vO
 T+rv+7T3zG63MW20MGqXuHYu+6FwWEuzIFyFJmhI/OearlGfliaTupsB+8UXa0U8/cTW
 JjRAinWAMEZYIH+NCkWSNRhTC0dieYyOP6QMHE77ZL39sBVsE8jiRy6+2Q4Aqm5OFqa+
 vaIe2fZ53aA+Cb9bsid0Q5ZYW+K2giOQASrzgbwsuFbSq54XT2ivcvAuXmhLnKen4AxD
 8/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332798; x=1754937598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uf+KywRMYJZdnc5WkH+t5Y1kT4Zel1cp7zy1z3bbj/0=;
 b=ATEFP+cxp76dAYohVjVVB7u95Db7/xXWHzEeLGZzHjZn5lnFhGPpxXEdNBzpVCIwbk
 G/Bawo3+6nOS1HbDvSQXV4b2SmPrl3DhVKq60y703yqUWioWB7Uvo54sYDNofpRnvA6N
 1txexoni5X9IaY+CzabX8XVomc5ihQTOQj8/q+mcyEQTSMmU3qdtyzS4X+gM8lKqHcmq
 qoYGm+1U9e+bZDEauqCP3TDZD68S67pxzTtFafon600xIGrUAoYwzGQNTBYOMo1hDgPl
 BejjHSdyF780DYvSXoiQiMOfuc6YyvO96jnNzSmJgn32ucLUGHkrGLeXJ8TkEHeyDVr6
 iNvw==
X-Gm-Message-State: AOJu0YyAarcGaEEhuMaWSDG0T+vXxE+3N2ylz8fsPvAP7/oIlyJmIKc+
 bz0clgH65QetD0FggjSnzU/l0SwG/txQDQ6HJ+XqNVnHwo9jywf04X5YMlwMpOoOLke7OYwxdRf
 YEUMa
X-Gm-Gg: ASbGncshfJ0jwhcRQ81GAAwwdqqWKc/0BUWS5MaB+z4y0IEdbIv/gmk2ju4iQjrPIeu
 aC8AzX9YDc/OlxJCHbMacpnuScpCndshhZoQUsxDqpdW+qGjjetnxRCyhj57J+lq7lGHizfkUCd
 toiln1lFvXFEeyR6DFO9I2YbZKko8c7KETmiB2oioDqksUztWkVzQ0Gp/a/lHpRtqe6Mr1exAIj
 qeKuKXIn1FhSB5utQoUqru5yCLaEdDbNpRrDHEIpQRCUfm/VzoLJTM6hcF+Y0P9Kv2Kpki5g7f1
 Cid1/FZu/n5dhOuW1Kr+9ISC3+JnFnmBXdBz4lxhCa6Cla+vpQjFYuu7szvFQjrca6qwKhTOhh8
 aZ9uiPCh/dM9y754viI/TIg==
X-Google-Smtp-Source: AGHT+IGNfj3RTshjkSOzA9Y591duixFQuiVaiijySFBMLA+6o9mCXyPC4glluBYWiH4JYDEA3GUgdQ==
X-Received: by 2002:a05:6a20:b598:b0:23f:fd87:427c with SMTP id
 adf61e73a8af0-23ffd875051mr9430428637.18.1754332798459; 
 Mon, 04 Aug 2025 11:39:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:39:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 02/12] semihosting/syscalls: replace uint64_t with vaddr
 where appropriate
Date: Mon,  4 Aug 2025 11:39:40 -0700
Message-ID: <20250804183950.3147154-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.2


