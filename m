Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26E3C28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 12:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqtIs-0006X9-5u; Sat, 08 Mar 2025 07:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqtIi-0006UB-MN
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 07:29:14 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqtIc-0002Bd-Qm
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 07:29:05 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39140bd6317so68502f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 04:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741436941; x=1742041741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNWRd/3bpDqDY9go9fwbBzHVlSOjDlQlmHNSNyWLCFQ=;
 b=eh+zA946OZtKL44+9K4/NzexQYPy5C3xUiG998OVU2tr84hIWSxFDsEAoSHDanW7gC
 B2HTmUfhisTa8oVxxlGH12sDwdXnS4yfzF8H92IQqxMI4ai0zix8nvwNiwwnw0WvR/0I
 PSiqnwEl38+mTpJlshxvQvT75yFkrxhrOHeLuJgIf0OU1GqAXFiAsfBT8xfn5iH46xnO
 dgZo+oJrVsMHd4MotCUwME7G1m46h2DlrBqf0XwCXBMIlImrnmXu0fyjXEFW97Lx6J9u
 kHKFlDI+MkvVE4BOPoHlm/PbQ7xWjhlA8SvLpMRyAjP2WnTpbkfGLFvWYhOC3UVTiW5n
 C9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741436941; x=1742041741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNWRd/3bpDqDY9go9fwbBzHVlSOjDlQlmHNSNyWLCFQ=;
 b=e3161xwGE50dGthjdCT98Lw2qTYTKKil8vJFprChUJcdqdMVhG3b68z0ocjFtf56PJ
 z5SIpOzIKKLBFb99ZCMIqmIA+WYW/0u5dHn1UgS4nnUDSAiZwWHuAR/1t3jzm3BaqVQA
 HwEb0yODgFrVF+9BIxri1yrLHKr6HICpf8uJzOfqbo1y1G0JxK0DL7KZsTVSTWFCzQ1g
 GAz6Y/0jCi+a8WS2BqbndujawrZoGEoTcw/b8UhureT8zO8I+FXFHTSFdj7hke09dadJ
 W+kPrAF/2npxqRpv1Z8OC5NNl7Mc4kMFmZYNhd8d/pag6psjiGMRSWKP2CzmuFENmGgb
 0HPQ==
X-Gm-Message-State: AOJu0YxmyVVlntw6EJXTW5Dec8BhuQPj+o2BajCc8+EdNZOaKcylS0xA
 qcsEHe3WS0yvy0RJcJyaZb1A3/RmvU/DeOMlfXhHN1sSbV5EnK356osmo3kecLAnbnU5gDHFQIt
 Ee2Q=
X-Gm-Gg: ASbGncvM8wZ3l403xJ1BP6/wTECeo0o2dMeIjtYLff31GlfjvMgMcj+Xo6txg+EJONX
 u3Ywik21dRaLs1TMJ7pdibpeD4lolXBszck9xgns6tCM0Kz561EQ9pu0FfUgX45cLVrqyxybvA1
 J9e7Za2nKRqnsFUKGBRnuTaPDB2vbXZGSVij8yc3HUtKHJUYmQfDmJv/oJxTiRof5MJF5ko7OUr
 I4FSovqTUX34wIGZovOSx4MRGfHE9VpQq8OpNfhOYn/gx+YyGG/R8OAXjgjuU1V0aCuccHH8wzp
 zrEVdSyva+tx6tHcmXvGG8sr29Iyz8yeIxGRfC35Fth6ORZ0HjKaUE29K/tpYOR5Pt0qGkXFmzZ
 f/nxMBVgSfZdk/I+t0bw=
X-Google-Smtp-Source: AGHT+IGMluLQ6WjIStepyGF8R0zu2xurdD0n4VO2r4YxLPlaKmqC91urDhWP+6d2NapoTshUuT3Uzw==
X-Received: by 2002:adf:a39c:0:b0:391:34ef:ae6f with SMTP id
 ffacd0b85a97d-39134efaf51mr2877368f8f.29.1741436940882; 
 Sat, 08 Mar 2025 04:29:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm8434950f8f.89.2025.03.08.04.28.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 04:28:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 3/3] user: Extract common MMAP API to 'user/mmap.h'
Date: Sat,  8 Mar 2025 13:28:42 +0100
Message-ID: <20250308122842.76377-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308122842.76377-1-philmd@linaro.org>
References: <20250308122842.76377-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h        | 12 +-----------
 include/user/mmap.h    | 32 ++++++++++++++++++++++++++++++++
 linux-user/user-mmap.h | 19 ++-----------------
 3 files changed, 35 insertions(+), 28 deletions(-)
 create mode 100644 include/user/mmap.h

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 0b3bd65b180..c1c508281a8 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -32,6 +32,7 @@
 extern char **environ;
 
 #include "user/thunk.h"
+#include "user/mmap.h"
 #include "target_arch.h"
 #include "syscall_defs.h"
 #include "target_syscall.h"
@@ -233,19 +234,8 @@ void print_taken_signal(int target_signum, const target_siginfo_t *tinfo);
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
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment);
 void mmap_reserve(abi_ulong start, abi_ulong size);
-void TSA_NO_TSA mmap_fork_start(void);
-void TSA_NO_TSA mmap_fork_end(int child);
 
 /* main.c */
 extern char qemu_proc_pathname[];
diff --git a/include/user/mmap.h b/include/user/mmap.h
new file mode 100644
index 00000000000..4d5e9aac70a
--- /dev/null
+++ b/include/user/mmap.h
@@ -0,0 +1,32 @@
+/*
+ * MMAP declarations for QEMU user emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef USER_MMAP_H
+#define USER_MMAP_H
+
+#include "user/abitypes.h"
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
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment);
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


