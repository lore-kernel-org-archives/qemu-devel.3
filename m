Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F06EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpv4-00057S-O8; Fri, 17 Jan 2025 12:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpul-000562-QL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:13:49 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpuf-0004oB-OO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:13:47 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43618283d48so16334425e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737134019; x=1737738819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oHKXd7OUSCtoUCYNv3jwaclYqccO793T07CYVSvSvls=;
 b=QsbHHQP9yNzE2APkRLOag13ZhjQdTLa7JziHBpkbAwAmAFWvqZmSagIuYNjRCN60aB
 vl57tP+sfx0zvJ+r06fv8gTku0GbBLkIalrmDU9swl04NWikkmj7CicCoTpgyGeNz06l
 UzAsvKwXtmsvs2aV6ZzaCtgyBjuEmKTmawGvA4gwbEJy8ygUIBA0L2TQS1cmN3QKIWQc
 NvTr+1mL79wSfssEV2dhGJZ7ySBzMXtGySpwWRCIU1R4FPLovPfF4VwS6/NKt6qppRJP
 YKUBYbaVH/LaX+fnEX2vIIlysSnuLFwVOfBSliW7J44nz5iw7Wjd93OuWQrlSUdCyCu7
 O13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134019; x=1737738819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oHKXd7OUSCtoUCYNv3jwaclYqccO793T07CYVSvSvls=;
 b=lJ86hYGpFaiZ9SoCCX7uUhScRvInsLFbdP6ndCKwIXM23ZJDz7bKo5uJIXFjuu7+/z
 l1/2QTQgHVSQs+M4gINArckOnpvgmWMqIBhAPUQq7bDHUnSVoOeR4MjKs2DTSjk+lTKW
 oXtJIGco+ydGqlwPDEczFY1H6U4ZEuQTGhJo7z9HXDWf7UBrsCt21eexTJfGZtM7b/Pl
 kD021G0Ql1yjrQLUiwsPkClHdBP91rFMGG9Z/6qp5kMz2hWu6lTtLmW6JBJEW5CyYcJb
 nydAoyE49iS1yxxqtV5TUuLJHALy0ZSYKfyCQ47q8H9V0V++pHL9qvCsqn4uVnf/mmP0
 n7pA==
X-Gm-Message-State: AOJu0YyMQmQC1Uf2Fx1rBgSkEwHAmzff/x09mRTa0aoeMT2gHvsvNpKR
 xJlP2fuFdeKNIUzZOZZgxoosA55EdLOkMwPziNn6k44S5iAe5TrFCp5i93ivmunz52XSoIhbKk1
 X8cc=
X-Gm-Gg: ASbGncuaFok8RPVhfQVDUcPGOG6jFtkqMpCa42CFuRg7pgpIVvARL2iPPi5LQKf3VQd
 rKcxZQVrEr9jZnon6onY5ljvypI5iUoAs0ovOgKhUs4KR+eiWonTKMD3riXZ4rRBOFD3kndpZ74
 zjnPADvhrtUvMRNhfFB0rbY9xxvoe48BDeYp0fYKNvGJdqLoQWdHZg6w/alVwDHFdg7u4JmUiWG
 2RYM5K7Iex7r3OknF/v2HVUyCBr9XJnxGDbWDNsdOicsoCiS6nniD9NT2AmqSyCyuFvsL6G//NN
 a866sUvBN/PkDQJfih/5ymM0lyFBBT4=
X-Google-Smtp-Source: AGHT+IHpjUx54P0CSbF6nb7eo72CAeEyommvJqjtkQqdiTzAO4HIgfAJgrT37dnmJlmGCAlXDoTvuw==
X-Received: by 2002:a05:600c:c0e:b0:431:5044:e388 with SMTP id
 5b1f17b1804b1-4389142968emr36768825e9.22.1737134019168; 
 Fri, 17 Jan 2025 09:13:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275995sm2994002f8f.74.2025.01.17.09.13.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Jan 2025 09:13:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Riku Voipio <riku.voipio@iki.fi>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] user: Extract common MMAP API to 'user/mmap.h'
Date: Fri, 17 Jan 2025 18:13:37 +0100
Message-ID: <20250117171337.91730-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Keep common MMAP-related declarations in a single place.

Note, this disable ThreadSafetyAnalysis on Linux for:
- mmap_fork_start()
- mmap_fork_end().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/qemu.h        | 12 +-----------
 include/user/mmap.h    | 33 +++++++++++++++++++++++++++++++++
 linux-user/user-mmap.h | 19 ++-----------------
 3 files changed, 36 insertions(+), 28 deletions(-)
 create mode 100644 include/user/mmap.h

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 3eaa14f3f56..a451d80a4db 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -32,6 +32,7 @@
 extern char **environ;
 
 #include "user/thunk.h"
+#include "user/mmap.h"
 #include "target_arch.h"
 #include "syscall_defs.h"
 #include "target_syscall.h"
@@ -234,19 +235,8 @@ void print_taken_signal(int target_signum, const target_siginfo_t *tinfo);
 extern int do_strace;
 
 /* mmap.c */
-int target_mprotect(abi_ulong start, abi_ulong len, int prot);
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
-                     int flags, int fd, off_t offset);
-int target_munmap(abi_ulong start, abi_ulong len);
-abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-                       abi_ulong new_size, unsigned long flags,
-                       abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
-extern abi_ulong mmap_next_start;
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
 void mmap_reserve(abi_ulong start, abi_ulong size);
-void TSA_NO_TSA mmap_fork_start(void);
-void TSA_NO_TSA mmap_fork_end(int child);
 
 /* main.c */
 extern char qemu_proc_pathname[];
diff --git a/include/user/mmap.h b/include/user/mmap.h
new file mode 100644
index 00000000000..93476a159d0
--- /dev/null
+++ b/include/user/mmap.h
@@ -0,0 +1,33 @@
+/*
+ * MMAP declarations for QEMU user emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef USER_MMAP_H
+#define USER_MMAP_H
+
+#include "qemu/clang-tsa.h"
+#include "exec/user/abitypes.h"
+
+/*
+ * mmap_next_start: The base address for the next mmap without hint,
+ * increased after each successful map, starting at task_unmapped_base.
+ * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOUT.
+ */
+extern abi_ulong mmap_next_start;
+
+int target_mprotect(abi_ulong start, abi_ulong len, int prot);
+
+abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
+                     int flags, int fd, off_t offset);
+int target_munmap(abi_ulong start, abi_ulong len);
+abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
+                       abi_ulong new_size, unsigned long flags,
+                       abi_ulong new_addr);
+
+abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
+
+void TSA_NO_TSA mmap_fork_start(void);
+void TSA_NO_TSA mmap_fork_end(int child);
+
+#endif
diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index b94bcdcf83c..dfc4477a720 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -18,6 +18,8 @@
 #ifndef LINUX_USER_USER_MMAP_H
 #define LINUX_USER_USER_MMAP_H
 
+#include "user/mmap.h"
+
 /*
  * Guest parameters for the ADDR_COMPAT_LAYOUT personality
  * (at present this is the only layout supported by QEMU).
@@ -39,24 +41,7 @@
 extern abi_ulong task_unmapped_base;
 extern abi_ulong elf_et_dyn_base;
 
-/*
- * mmap_next_start: The base address for the next mmap without hint,
- * increased after each successful map, starting at task_unmapped_base.
- * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOUT.
- */
-extern abi_ulong mmap_next_start;
-
-int target_mprotect(abi_ulong start, abi_ulong len, int prot);
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
-                     int flags, int fd, off_t offset);
-int target_munmap(abi_ulong start, abi_ulong len);
-abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-                       abi_ulong new_size, unsigned long flags,
-                       abi_ulong new_addr);
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice);
-abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
-void mmap_fork_start(void);
-void mmap_fork_end(int child);
 
 abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
                        abi_ulong shmaddr, int shmflg);
-- 
2.47.1


