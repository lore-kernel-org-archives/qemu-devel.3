Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B514FC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJO-000333-UF; Sat, 02 Aug 2025 19:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJM-0002p0-B3
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:44 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJK-0001Aw-Fj
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:44 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-619a0f2a8c9so158229eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176001; x=1754780801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DswSe38yYoTArY++0If/RvNUZ/t2C2uJUE3zFUBMwiU=;
 b=LdLB/KbNYHHMQEkakr2HtZfusmEF7mfgT+gQGIbdH887Ns7ZgERUqKicthhABJaX84
 gB0s3nE4ML+oJ4yBs/Y52jt0toaIRFcRf42J/cozLHGTW/ZHPAeej+wbuqFewKeHdoU2
 6fHKrcPTyyKxiSYqzvctI5QOWF60gO8pjRlJSnFf/VLy7Lzn065rlYba4O3Awk1szThZ
 z7RPScl7s9D38R4CeiYvehmvfhmmFf3iFRNVwK+ghwQ5IxhAecT4DqQKQCZUHRnKoQb3
 uxifjJKt9yOgKlg/Fs4ZWCEL1pf6dhBKByvLJbo5dzkdf5ZCVbsnM0lLNd25n7bkksSN
 ryJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176001; x=1754780801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DswSe38yYoTArY++0If/RvNUZ/t2C2uJUE3zFUBMwiU=;
 b=odUtp/oKybXbvXzykhYVJrncstckPuiHOK8MtS3XL/th7nKZW1ikdPCwnBvZi4qZDh
 /Mb/+yRXPrYrPN7OhbIviExUpu4GQoemRyYtrMicEDfSmpFYueMiUz60OB6YFsq6XOdY
 sDqCykJDx3Dg3LkYGYgWjtlg/7U1xG7aK0ffRjYyX9iqApX0lM+TuNCyKpLAAJUPlQTK
 ea9pGbwpyBr5JLb/i34Li/Z8NOg9E3k+aL7wXMZvMgU5dCpvxGHfxd6O22Fpsh5yu7DQ
 JuHV06J/OdegDJNOdY7t3qObWqMOV3DXFo4wa9o2ttc61yIlqSWWmDOkDc8CVgB0ERDY
 k27A==
X-Gm-Message-State: AOJu0YwVSrhaTqKqQ75mJd4mUjjBHTi3hMiLZZc5dItZ8MbZgTKixdw7
 mm1MA5nz258k0g4o50t7kKqZwtGbYzAMMVKWqH5eeffE2sUT4z4E23T6eccZzXQjt2fGjL+0N/c
 TRAlIfGI=
X-Gm-Gg: ASbGnct0di/C5RYrJU2BrgEdLjb3x2ZTjpVeFKHCD8oxcq5rdRtw9DU6sbVB8k3Hhir
 n+tvm7+bL2WuyhOENSBOWsu/SiS12iNL+hfkG840aNEs0GDpHDKRcMbNeESkqgzlez41QlQoXHx
 B8fvXii0U+UB1+eolR4OEZ+aV8ji3Wx3dvHX9k2p/vcXQsxh++411ntaEtMRZC7DrCEuA9bigVD
 A0f7VnalHBQYSoF7/uliyxRF93MVra/EFaDQyIko7WInc6/CjgtCfXfyUCGuUaZTSVtk7/Jc275
 NLzAv+a2Ugt5+btmvh4JQaaOzatifWm5W5BD+hUSMk/qTZqEyyQFVZZatJ1EOwokIT2PaUTpvTv
 GC4TlJScoeMoxZ7gOUhKDsEnbUvy6qO5E08nca2NBouFCXkO48Zi4
X-Google-Smtp-Source: AGHT+IHyFk4hJ8YTLPT1EgFmg24j4lMU/r8x1A+VNGIzlEP0rnp0My2zA8usA++A9IzR/vWmwKIxLA==
X-Received: by 2002:a05:6820:290a:b0:615:e61d:2de3 with SMTP id
 006d021491bc7-6198f2358c1mr3029290eaf.3.1754176001066; 
 Sat, 02 Aug 2025 16:06:41 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 25/95] linux-user: Create do_init_main_thread
Date: Sun,  3 Aug 2025 09:03:49 +1000
Message-ID: <20250802230459.412251-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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


