Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16C8C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguTQ-0005I4-3A; Tue, 29 Jul 2025 20:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFQ-0001uy-Q1
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFO-00044a-KP
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso7912008b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833641; x=1754438441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y5qoqoexhfze1ueAgVQL5v2FRUGJ7lRXoO8zg4ql7UI=;
 b=y8FVTv0ZtdZoT6JKZpSTfXLSNcOVWq40kSyedeTwfLwG1MbNvd3I+x09ox3YXqp0EG
 9VqusG+4mnMqp3SMtvTS3KIp9Acn9AkbeWp5gTFCa7BO2QDpTpbSAb9BJ7a1M2Sc505b
 ApnBKhqWtSyr8CvSu4ELOvfBufQ9x0VNLi8PChwPKp46ztZzohMvr76JuOyd9WBy0X8v
 ePiByemt8H0vXLzX094b4UBFjeAYebGGfRm5HmbUqqo26AJe/XMPv+Yxxaor5aE0Grag
 LR5PBDIwGi8K9VW9vMy3WjIJsoFkSbUUqz1EQVUpB6fk2w0ewHdtW8VIHcrjRX9aEaza
 qDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833641; x=1754438441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5qoqoexhfze1ueAgVQL5v2FRUGJ7lRXoO8zg4ql7UI=;
 b=KAD0XbfJsjq3uC3Misdo+ALctGRE+OUHSd4tYhTiZWzA6NPbu3bgHEkfTa7nbUAhxb
 cmanwpaapqxzq/5XOMIZBJIz97kvA2PWoeJQhPWwbMnapYLtd9b5SzhUIwIkMgpOPDmW
 0HGrChut0H1KSDQfyFct3XXYPLNWhZ+16qjp0E5OkM+YTgsU96iXFeyKH3VFByJC2B4D
 BGpkIIA+KqdfRjut197tVfaHKmuz0pEtnQedWeAcg8ADGQHrRXgc7dsQuHG/AbVobQj6
 sAj07MMqGmqo+2Uo3uAU49Oa8Rca0zI7WSEH+L4HEiw3z0pf/r7WK8QZLQYo2RvuQINS
 UNmg==
X-Gm-Message-State: AOJu0Yw0eHXDywB3HdxTlAohpW+vU9KY5jcn2ZChxtlxm6QJNjF+HIcf
 6dr1+5uwFs0d3QfvpiFYt5WwPRVF/a5AHUHK+u8IgCOhQ6t5nwK0Fxy2fGgzikV51QLd+KKC8HZ
 xKocu
X-Gm-Gg: ASbGncsO32PweCfrNBSWHlDtTNLG7eQYrkzRYLxhP1gV5MqPe2Ana1GI0h9MJd2eBdt
 9ECrxYaOVXOZRRfJZDCLk00lqDgsJ2Br1gBSl44aAZyo0jlypneWRnM0HYI597QGDt+KuxfSgkk
 +du3C0eb7dWuw/0v+buqGk4WUxL32S8LyrGPpWLQwSG/K8qEWWRGw2vpNpf/zXXZlPRpOqzY08A
 X4J6G5Tx06rUn5sH5mcUZ/EremleHhxwSoNTNbwuIRO/2NM18bBrx4nuwil+Bf0Wp+AFW3qsIoZ
 0BSU4rz1darMzvTyYkJtcsOOa4cnG+kY1xf7osvV3vpQKtls6ZKLImcJxfdYGBHrFr1y1Bx5SId
 SiNdftpqHkmfRCPw5+OeMIwXiVdt6bXDPACcjWA9/PdE4ZEXtZdCK/EVDB7WZhdScyqN3BZTPJs
 QMRtgmM2oxPw==
X-Google-Smtp-Source: AGHT+IEthxz9+sxWvcp0NzkIkzB4s20YcRyb4hdkbc7TnfdRBEN3fxM9RBTTJBvcCXCvASMdcmOU7Q==
X-Received: by 2002:a05:6a00:14d1:b0:76a:7b13:e6e3 with SMTP id
 d2e1a72fcca58-76ab33001c6mr1811542b3a.23.1753833640827; 
 Tue, 29 Jul 2025 17:00:40 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/89] linux-user: Create do_init_main_thread
Date: Tue, 29 Jul 2025 13:58:55 -1000
Message-ID: <20250730000003.599084-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h    |  5 ++---
 linux-user/elfload.c   |  7 +++++--
 linux-user/linuxload.c |  6 ++----
 linux-user/main.c      | 10 +++-------
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index a5eef18eff..b7dceb4abe 100644
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
index b26daf925d..1d8cc7f6b5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3635,7 +3635,10 @@ static int elf_core_dump(int signr, const CPUArchState *env)
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
index 4def4be1c1..121dc4a0e6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -697,7 +697,6 @@ static int parse_args(int argc, char **argv)
 
 int main(int argc, char **argv, char **envp)
 {
-    struct target_pt_regs regs1, *regs = &regs1;
     struct image_info info1, *info = &info1;
     struct linux_binprm bprm;
     TaskState *ts;
@@ -763,9 +762,6 @@ int main(int argc, char **argv, char **envp)
     trace_init_file();
     qemu_plugin_load_list(&plugins, &error_fatal);
 
-    /* Zero out regs */
-    memset(regs, 0, sizeof(struct target_pt_regs));
-
     /* Zero out image_info */
     memset(info, 0, sizeof(struct image_info));
 
@@ -989,8 +985,8 @@ int main(int argc, char **argv, char **envp)
 
     fd_trans_init();
 
-    ret = loader_exec(execfd, exec_path, target_argv, target_environ, regs,
-        info, &bprm);
+    ret = loader_exec(execfd, exec_path, target_argv, target_environ,
+                      info, &bprm);
     if (ret != 0) {
         printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
         _exit(EXIT_FAILURE);
@@ -1042,7 +1038,7 @@ int main(int argc, char **argv, char **envp)
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init();
 
-    target_cpu_copy_regs(env, regs);
+    do_init_main_thread(cpu, info);
 
     if (gdbstub) {
         gdbserver_start(gdbstub, &error_fatal);
-- 
2.43.0


