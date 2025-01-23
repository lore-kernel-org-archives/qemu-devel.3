Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786F7C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6sD-00069s-CF; Thu, 23 Jan 2025 18:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sB-00068n-QQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:31 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6s8-0003rn-SZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:31 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1183219f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675867; x=1738280667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nuXtmGFXC6ord9LKCUcMBdqEKN9u5T/6Xkbf7Pq9+s=;
 b=aFg1A+iXtHTzplQv2uBeKltCA6R4Lmfe8Eq1rybCKZigLroQLV2B553ijdCSuNhca0
 yitDaVxo5c14Z08YbzOzMHKGdanzlK5lAHIwrXRu56zxD+z3NV4Kri4bTiXf7IRe901u
 ewSh3ODLvS64lVeHaos+QAM2itNnueKwihf/VUbaYhFlz8DUflheKeLMm2CRcBlia0xr
 iA2SOxjzwU3emP659AOOaAbbTQ+iz7899QXBPoQbCAgJ4ilRv0QzKWazafKCia0ryG7m
 g1BJkT5HBi1ykw37JKs5+NntdFySavGUcVpLt0csONEukD40eiA+PEx/JUTLQie5aqC2
 rQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675867; x=1738280667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nuXtmGFXC6ord9LKCUcMBdqEKN9u5T/6Xkbf7Pq9+s=;
 b=J3HWu6r3Fr2w8A0WR9XgUNGVa8IyPg2qLX0IUmk6FueSq5bmcxdVCIlpuLKd8PiwX6
 py2YcWuUEXwuERsBZXG/zVyljMnCzu4G4B20O7CzORDYmUegdVSoXu4INqxFkCfcEEMt
 BB9q0wws90M8V/57+AE6XkZoVWbrS6u8aKXFdDsbRJsWZ9IQeAb62NrESpBtDqm92Pv9
 MkUYbQAKMGDbAvcLPbgd5dNzpm9tv/8T40K43NoWklewWIi79Qi6+PlaVJcxI8272pt1
 +d2lslTh2ERHoUcAwGislFuicsHbjVIB05ZI52K+aM7O+4fahUIYDOfyMKkJAVj4aj1g
 fJdg==
X-Gm-Message-State: AOJu0YwnEXj45bKJ2jlJt5boqTbgXE96iS7fwshzNUiyei5ZHbPjCZm8
 qkh+n036mrzNdzv27FF1Xps1gaPEMrpwSrWyMyhYuUtBh3R7Xwxli24z6UoabFfx6IgrgYf01C3
 0Wr0=
X-Gm-Gg: ASbGncvnDRdY3E2i5s1cRh1CtUrVQGr9ZrUgW6t5D7vp2914ON2LJATgV7Ai/SrOIib
 rEWZUrJl4dMt9j/nfvAG/fNCKAqXBaXxQziFswWUzel6lq1iqVmZjrssh54shnf/sKhP3hPCcnp
 1oRVH8YHjONarl+42khHU2p4m0mlEoVuZGHajrbX4v8VObdKvE8ehrwmtyO0DORTGAVHS25lLfM
 iXjuATjLh//bAJ5/Uk2G9eRn9j2FSd3SC7J1AUU2gTqSmykN8V/9y9FZjTi3UNWTi/O2dlDvEUA
 rDbSqEr376Jkd0xP2v4dhYqiQnyUbUkj7pCcVsBsKjGVb/gx8hB0DIU=
X-Google-Smtp-Source: AGHT+IHv5zns5zWE/8mYKYb9FdwvG4F/GC7lN2DJcXXFDd0WLjCHyuvzadU0RlDxZ5dNLmoZuF9u5A==
X-Received: by 2002:a05:6000:1887:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38bf56639d5mr27205303f8f.21.1737675867076; 
 Thu, 23 Jan 2025 15:44:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6e2sm989811f8f.23.2025.01.23.15.44.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:44:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/20] user: Extract common MMAP API to 'user/mmap.h'
Date: Fri, 24 Jan 2025 00:43:56 +0100
Message-ID: <20250123234415.59850-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 include/user/mmap.h    | 32 ++++++++++++++++++++++++++++++++
 linux-user/user-mmap.h | 19 ++-----------------
 3 files changed, 35 insertions(+), 28 deletions(-)
 create mode 100644 include/user/mmap.h

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 4e97c796318..c1c508281a8 100644
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
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
 void mmap_reserve(abi_ulong start, abi_ulong size);
-void TSA_NO_TSA mmap_fork_start(void);
-void TSA_NO_TSA mmap_fork_end(int child);
 
 /* main.c */
 extern char qemu_proc_pathname[];
diff --git a/include/user/mmap.h b/include/user/mmap.h
new file mode 100644
index 00000000000..4d004e6b822
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


