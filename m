Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90ACCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPT6-0004bg-DL; Wed, 27 Aug 2025 19:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSo-0004CW-DK
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:00 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSf-0004HV-II
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:58 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7718408baf7so402085b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336903; x=1756941703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DswSe38yYoTArY++0If/RvNUZ/t2C2uJUE3zFUBMwiU=;
 b=WNfdFpWwK7tpnWoHkypdmv9yMm0SrNQTsd+F9/vuBpTERAVh0TvyVApe67pQ2CKs1i
 e8IBw8YovRlS2VFJAIWna8K+fqjvDHBkizTUSZ+rl4BnLejsaS/xqfugCSx5Zf+LbpKH
 1s9WkhLjKxjGXzrzEYw8WE7V23xn6IbL2Jh5Jiol3wrdp2s5D4/EPXyrX7IgCgaIxzvu
 iwCZZfCirqkOhQ5gFmuVgprV2E1cy83DU7M+OsZBPRVxdwo+6kATQ20P8e046DRyo68x
 BpLKfj67DL52ADIY+1YsooG6EZIwmRC9ojmNMi4WcUuz0IPJrks937MCrHPNBzGCWWC3
 7TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336903; x=1756941703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DswSe38yYoTArY++0If/RvNUZ/t2C2uJUE3zFUBMwiU=;
 b=E4c/iWB9iZfzPer32UjR2og5rxqIY3tyqtx8/Y83F0Mp6m8gOJ3pTFng6MX/Iqbwuz
 cixeGPf452amjPrnClGIBnRZ8S+bS+P71hzHFibgq1UCPTX9KloHuNj9BCVNvCbPGl47
 HMn+mwchAASqI1FLKYoU0yV4xHpN8P/gNjfyRDFNFN/RNXR2tPeuwZcTq9bK6lnPfCEg
 XvMLqQrNkHa6WuS8zTp83E+/rr4bksTwxkaYHQe/rs2YlGhu/Nwr9DWelRKg6A3t5ffQ
 /QxseFUHNCCoBNSzhyv2Cq5NNhtEHo6gLS1VzQ7G9Pw/JrEjt39WE67fKzb73ywUdb9m
 buQw==
X-Gm-Message-State: AOJu0YyJLN9RzH8jgrCm9iLJH52HjlMQ8s5sql8dmaSG2k7Qa16kC/vn
 V6HytwXqZU/to2N+LAP7eGiQkpSEgb13UJrCp7HKwx1ely6v0ewV0+GxaMpic1Ou9kLNpO7spq7
 GuAz1ZL4=
X-Gm-Gg: ASbGncvRbrHrw27D6urESywjex4ahqAY1OCiUabAEuidn+sXr+3mIcWMVI7Pvv5EMrP
 4tgKN3d1R9l+rk79GSYri637fB/oWr7SuzfQ65B7gjVG7nGP2Khbrs33YBm/XmxM7X0DFSA2Xae
 XtfEvS0wBkVDXmwx35Nm/WeIFe7+nD8axWpwmFCKXL5/NkPb/eAl4niEK0rxkJeYtDJbQjrcNBl
 jhoup/0rj8fEoA4TkWrt9YfdmklPB56hOHz3COv7C5O72JmGOTjqzRYkLnn/O8qf/R1XvvSNX51
 kqC3HHlFj//2+bxcY8IwPW+SsDK1ucBk1VwoPKPTaMb8g1bPzq9dqtxVwauTJZPNTlSwriLTTEW
 YNwgg5za6ElVTIX5wlN4H44ZlYw==
X-Google-Smtp-Source: AGHT+IGZIx8uD6jjmNeAsJSBExrOnOneqh0GScEuMXY7EnKjcYTmmT86g0v1OQ0qADmCwq+SKnouyA==
X-Received: by 2002:a05:6a00:3d06:b0:770:73ed:e6e8 with SMTP id
 d2e1a72fcca58-77073edece2mr18034419b3a.22.1756336903433; 
 Wed, 27 Aug 2025 16:21:43 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 25/46] linux-user: Create do_init_main_thread
Date: Thu, 28 Aug 2025 09:20:02 +1000
Message-ID: <20250827232023.50398-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Provide a unified function to initialize the main thread.
Keep target_pt_regs isolated to this function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h    |  5 ++---
 linux-user/elfload.c   |  7 +++++--
 linux-user/linuxload.c |  6 ++----
 linux-user/main.c      | 10 +++-------
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 42cba90dea..e0291cc3b0 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -82,12 +82,11 @@ struct linux_binprm {
     int (*core_dump)(int, const CPUArchState *); /* coredump routine */
 };
 
-void do_init_thread(struct target_pt_regs *regs, struct image_info *infop);
+void do_init_main_thread(CPUState *cs, struct image_info *infop);
 abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
                               abi_ulong stringp, int push_ptr);
 int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
-             struct target_pt_regs *regs, struct image_info *infop,
-             struct linux_binprm *);
+                struct image_info *infop, struct linux_binprm *);
 
 uint32_t get_elf_eflags(int fd);
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4facaa7e27..6fce74f45a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3619,7 +3619,10 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 }
 #endif /* USE_ELF_CORE_DUMP */
 
-void do_init_thread(struct target_pt_regs *regs, struct image_info *infop)
+void do_init_main_thread(CPUState *cs, struct image_info *infop)
 {
-    init_thread(regs, infop);
+    target_pt_regs regs = { };
+
+    init_thread(&regs, infop);
+    target_cpu_copy_regs(cpu_env(cs), &regs);
 }
diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 37f132be4a..85d700953e 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -139,8 +139,7 @@ abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
 }
 
 int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
-                struct target_pt_regs *regs, struct image_info *infop,
-                struct linux_binprm *bprm)
+                struct image_info *infop, struct linux_binprm *bprm)
 {
     int retval;
 
@@ -175,8 +174,7 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
         return retval;
     }
 
-    /* Success.  Initialize important registers. */
-    do_init_thread(regs, infop);
+    /* Success. */
     return 0;
 }
 
diff --git a/linux-user/main.c b/linux-user/main.c
index ad1a29d198..e21842bde9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -696,7 +696,6 @@ static int parse_args(int argc, char **argv)
 
 int main(int argc, char **argv, char **envp)
 {
-    struct target_pt_regs regs1, *regs = &regs1;
     struct image_info info1, *info = &info1;
     struct linux_binprm bprm;
     TaskState *ts;
@@ -762,9 +761,6 @@ int main(int argc, char **argv, char **envp)
     trace_init_file();
     qemu_plugin_load_list(&plugins, &error_fatal);
 
-    /* Zero out regs */
-    memset(regs, 0, sizeof(struct target_pt_regs));
-
     /* Zero out image_info */
     memset(info, 0, sizeof(struct image_info));
 
@@ -988,8 +984,8 @@ int main(int argc, char **argv, char **envp)
 
     fd_trans_init();
 
-    ret = loader_exec(execfd, exec_path, target_argv, target_environ, regs,
-        info, &bprm);
+    ret = loader_exec(execfd, exec_path, target_argv, target_environ,
+                      info, &bprm);
     if (ret != 0) {
         printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
         _exit(EXIT_FAILURE);
@@ -1041,7 +1037,7 @@ int main(int argc, char **argv, char **envp)
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init();
 
-    target_cpu_copy_regs(env, regs);
+    do_init_main_thread(cpu, info);
 
     if (gdbstub) {
         gdbserver_start(gdbstub, &error_fatal);
-- 
2.43.0


