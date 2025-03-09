Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B216C28B30
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpE-0005Ay-R6; Sun, 09 Mar 2025 13:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpE-0005Ap-3a
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpC-0004pC-7T
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so136770f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542748; x=1742147548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OnXnqroPfwg0H1e+w7z6nHC73+VyJlWMGmTrbr9qjl8=;
 b=heGzQLyN4S5WbnPUuBAff4Z7NXTko2O0UFXMVhvMacuNdLKuEzOCAAJ+YUCVzkZTij
 NTDQ+uUb8Ue/gF0kUW/n0X4HDllpUPpeqds/fFsWujmknIvnb64jIRoSL6VAnKAshie2
 Jh20ARiKI2QeZM2DJsziv9Xekkv7ZHpxHpAlEiq53eO6DBCuqs5c9h8i8Xly5W5KMNrJ
 aEC0O2TxHJUMH0aIKDQ/fXogh2eq7oZFIBvbq3hi4DmTZO33mQMxwAUEzvr741fNmVZa
 IaTdMrf+FjYfNKsX6dR49tXgANGreBIOwKVc17nljRAg8TJ33j6STBUK5oGvLM+oiPlN
 ad5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542748; x=1742147548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnXnqroPfwg0H1e+w7z6nHC73+VyJlWMGmTrbr9qjl8=;
 b=EmyNvpuKr+y1rWkB7Ki22nD5956WEa72Gs7SrKxx9M5A6gx1gwsLSvFXBSR4EyNe2h
 nLDu/BcpLt4P/lxAUJOS/mguoUCGmhpF+pb+ULtAES+NxRP0MJ7l7IVjwUdl1RAkfiBF
 umJpEsDVoH3yugRiZ7vcc5N+Qx0JuhbxYoFbb3kNg23oM5T3GAiWzT6heCj11NqAyHnv
 bz+rMfWTN9H8JJ0wD6jdFtm/VxTowLlv6P0JiM9iZe2sr3x5rboOjSxyR++7nw99OYix
 aFw/8He0a3JyuWwjfQhiVqN3MOg/Bk0bkuLSriRBo3ffoHznFEzfbwLjZvNhncqoa6g0
 gvHw==
X-Gm-Message-State: AOJu0YxAtThUED8fLgGwyUxUdaHDdqTvADd0afPdsOkQY9KbM2LT4LGy
 y7qp37W9USvVgmkFWEZRLamn7S236MUP3a+7iZ2i7ap4aiL+agduloWipG8UMq+755CT+P+rlBw
 DJMY=
X-Gm-Gg: ASbGncsdeu/V/hBMhQ47OBsQ2vzvzFnpoNywiCn6zVxwj4vhchdal5c8FVfMao59jDF
 gHRf8qN5tYHeqPtF6Rb7/KCa4kkdsMWrr7xyvUzZ5SNc5wve1KVT9VluKUH12T/7a6KqgDK6BG8
 FBUM9K9ILqA6MNTE1s/VUQE+E8PDdzC6tmFLnQlGmGondvC9pto1SGHPQK6MwfrSH4gFqWKe1LX
 HMMdt83qE0w73pb2EDiiNFToYU/ip6j1mLICqFMmQ+q6UQxpoVAFU4vPMsIxFvww72V10g/6+L3
 cq09jSYXeUMHcTi/TUxODMd/AYrk2P+7tAQAG0hwJnftSP8LBRkjXUDiADKBOrwrwNoXiKm7XqM
 gXr9fr6921dYnE5EakjA=
X-Google-Smtp-Source: AGHT+IFYKq7P5F+VmIl5UAVb+Evs6wIpgbUZeILZ6hqccKKpg1NDscolukscDvgWBerOk4rlOXbUqQ==
X-Received: by 2002:a5d:648f:0:b0:391:2e0f:efce with SMTP id
 ffacd0b85a97d-39132d06d53mr5694042f8f.1.1741542748339; 
 Sun, 09 Mar 2025 10:52:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1027d3sm12270567f8f.83.2025.03.09.10.52.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/38] user: Extract common MMAP API to 'user/mmap.h'
Date: Sun,  9 Mar 2025 18:51:33 +0100
Message-ID: <20250309175207.43828-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Message-Id: <20250308122842.76377-4-philmd@linaro.org>
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


