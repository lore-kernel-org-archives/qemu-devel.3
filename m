Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC6CCF6D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0gz-0003l0-OD; Wed, 02 Oct 2024 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw0gr-0003kr-Uv
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:50:57 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1sw0gq-0001bZ-6X
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:50:57 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e04801bb65so3718460b6e.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727880654; x=1728485454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09KvACH4arAXjV+oT9t8w/5nQn5cnKAOwRFPFd/Tva0=;
 b=F+x0cKEi6JJkp5H4ErT0ac5Io1yQewWbt8f04A29LOa+0by5sinvOS5aa2Tfj6gmtl
 QIfESr0/j5LK/rWao/vJavNWxRP8U5FNVM8pM3HlVnLxljIXN31avQijS6SU4aqU3XZG
 RNcmPoQVzG/IB/SPeQ+Qi2EXckw1fI++JSOViBpzsOkxRAUpdQZm8fArmG4pYyAvICet
 DCU9KbOr9uVkdegq7Wsi6nhuqplJr4CxXwWl7+PD0nYXYtIzt5oEqiRnyZ0BcXhetCGi
 rg2oSJ7IbWQxEOO1losNix1TSeURNTaveJOl5kRmSi8E7Q3wnrP619ujLRJv/2jT8Vgv
 UBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880654; x=1728485454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09KvACH4arAXjV+oT9t8w/5nQn5cnKAOwRFPFd/Tva0=;
 b=CvYnQh9KXkU3lODZ+E0SNR0+55xCXXSpOs/gCXe2lJSSQAhQarMQ72HuxGYqMD6vws
 ATEX0T5f0mZCmb9k+hcSRkzD7DNqoakEIMbtQdV/n8GqF9fv6lS4y1Hdm3B5z3FJFSo5
 LsjRFnYpMrrEwgZCoD2G168czqihNcYEX53u6tp+kfC6CR79U0TVG/QZ0q9Z1j0q/1G6
 b81hpZ8jLDQ8jI94emqA1JKEvim+EABd60TNvov9f42C/JmgvLAFV/qmX8XLlByw3/FJ
 ATvncmLa91CF3ItNiDeFq3AGUcMjopT/NMbwuID/54++bnhm0WV8osQi8ToYbAUyEgmN
 +8VA==
X-Gm-Message-State: AOJu0YxDd+T1HnJEGMKNnXh58cPvcPzAl0k1nF9kmBG9fY1kh7ujbsFZ
 UnJJjPOmU+jx1WpXz1uIriCqL3YlgNCnT6ADyxhMfRh8MQYQJIG9Vz/H4lYz
X-Google-Smtp-Source: AGHT+IH93Ombi39Q51Lm3dHDUZW2b6QuVOB8cAxWoUZ9y2YUhOhh49rkiJm2N7r8yrKOTGyVpJ++EQ==
X-Received: by 2002:a05:6808:f04:b0:3e0:4674:79c7 with SMTP id
 5614622812f47-3e3b4176a47mr2705556b6e.39.1727880654493; 
 Wed, 02 Oct 2024 07:50:54 -0700 (PDT)
Received: from localhost.localdomain.lan
 ([2603:8080:1600:131:df30:868d:97ce:27b])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e393597da1sm3704368b6e.25.2024.10.02.07.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:50:54 -0700 (PDT)
From: Noah Goldstein <goldstein.w.n@gmail.com>
To: qemu-devel@nongnu.org
Cc: goldstein.w.n@gmail.com,
	iii@linux.ibm.com,
	laurent@vivier.eu
Subject: [PATCH v2] linux-user: Add option to run `execve`d programs through
 QEMU
Date: Wed,  2 Oct 2024 09:50:42 -0500
Message-ID: <20241002145042.1142194-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oi1-x234.google.com
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

The new option '-qemu-children' makes it so that on `execve` the child
process will be launch by the same `qemu` executable that is currently
running along with its current commandline arguments.

The motivation for the change is to make it so that plugins running
through `qemu` can continue to run on children.  Why not just
`binfmt`?: Plugins can be desirable regardless of system/architecture
emulation, and can sometimes be useful for elf files that can run
natively. Enabling `binfmt` for all natively runnable elf files may
not be desirable.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
 linux-user/main.c           | 21 +++++++++++++++++++++
 linux-user/syscall.c        | 21 ++++++++++++++++-----
 linux-user/user-internals.h |  4 ++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8143a0d4b0..5e3d41dc2b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
 uintptr_t guest_base;
 bool have_guest_base;
 
+bool qemu_dup_for_children;
+int qemu_argc;
+char **qemu_argv;
+
 /*
  * Used to implement backwards-compatibility for the `-strace`, and
  * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten by
@@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
     perf_enable_jitdump();
 }
 
+static void handle_arg_qemu_children(const char *arg)
+{
+    qemu_dup_for_children = true;
+}
+
 static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
 
 #ifdef CONFIG_PLUGIN
@@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Generate a /tmp/perf-${pid}.map file for perf"},
     {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
      "",           "Generate a jit-${pid}.dump file for perf"},
+    {"qemu-children",
+                   "QEMU_CHILDREN",    false, handle_arg_qemu_children,
+     "",           "Run child processes (created with execve) with qemu "
+                   "(as instantiated for the parent)"},
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
@@ -729,6 +742,14 @@ int main(int argc, char **argv, char **envp)
 
     optind = parse_args(argc, argv);
 
+    if (qemu_dup_for_children) {
+        qemu_argc = optind;
+        qemu_argv = g_new0(char *, qemu_argc);
+        for (i = 0; i < optind; ++i) {
+            qemu_argv[i] = strdup(argv[i]);
+        }
+    }
+
     qemu_set_log_filename_flags(last_log_filename,
                                 last_log_mask | (enable_strace * LOG_STRACE),
                                 &error_fatal);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a666986189..79019c0db0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8457,13 +8457,14 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
                     abi_long pathname, abi_long guest_argp,
                     abi_long guest_envp, int flags, bool is_execveat)
 {
-    int ret;
+    int ret, argp_offset;
     char **argp, **envp;
     int argc, envc;
     abi_ulong gp;
     abi_ulong addr;
     char **q;
     void *p;
+    bool through_qemu = dirfd == AT_FDCWD && qemu_dup_for_children;
 
     argc = 0;
 
@@ -8487,10 +8488,12 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
         envc++;
     }
 
-    argp = g_new0(char *, argc + 1);
+    argp_offset = through_qemu ? qemu_argc : 0;
+    argp = g_new0(char *, argc + argp_offset + 1);
     envp = g_new0(char *, envc + 1);
 
-    for (gp = guest_argp, q = argp; gp; gp += sizeof(abi_ulong), q++) {
+    for (gp = guest_argp, q = argp + argp_offset;
+         gp; gp += sizeof(abi_ulong), q++) {
         if (get_user_ual(addr, gp)) {
             goto execve_efault;
         }
@@ -8535,9 +8538,16 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
     }
 
     const char *exe = p;
-    if (is_proc_myself(p, "exe")) {
+    if (through_qemu) {
+        int i;
+        for (i = 0; i < argp_offset; ++i) {
+            argp[i] = qemu_argv[i];
+        }
+        exe = qemu_argv[0];
+    } else if (is_proc_myself(p, "exe")) {
         exe = exec_path;
     }
+
     ret = is_execveat
         ? safe_execveat(dirfd, exe, argp, envp, flags)
         : safe_execve(exe, argp, envp);
@@ -8551,7 +8561,8 @@ execve_efault:
     ret = -TARGET_EFAULT;
 
 execve_end:
-    for (gp = guest_argp, q = argp; *q; gp += sizeof(abi_ulong), q++) {
+    for (gp = guest_argp, q = argp + argp_offset;
+         *q; gp += sizeof(abi_ulong), q++) {
         if (get_user_ual(addr, gp) || !addr) {
             break;
         }
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 5c7f173ceb..a4615eee54 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -30,6 +30,10 @@ void stop_all_tasks(void);
 extern const char *qemu_uname_release;
 extern unsigned long mmap_min_addr;
 
+extern bool qemu_dup_for_children;
+extern int qemu_argc;
+extern char **qemu_argv;
+
 typedef struct IOCTLEntry IOCTLEntry;
 
 typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
-- 
2.43.0


