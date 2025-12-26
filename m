Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7277CE8FDAC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 20:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZETk-0007bX-R0; Fri, 26 Dec 2025 15:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vZETk-0007bO-33
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 15:32:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vZETi-0002T4-AD
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 15:32:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so59299815e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766781121; x=1767385921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/CzAGB9yL8G5U4vFJFxQvsqsvNZ+dnI5o8uF0Ip/aT0=;
 b=HQ4SCrDWiziE0qpQPL8clqvnawqM6ziL9BJmJDsokU5rWRfQIcuv2CbXdhqRan3RFH
 u0hKSWcQXrqp7xSwdbujbI14kKGp00tKS36BYdZWYPbJp6ne3+oC97VeIehT7x1FYitu
 8ad9I9Wjn43EVI8r26RHPaWKQlViAcKqXy02tORH6xkTALkRW4J/Ha9stz02bV/oQEuU
 AXW5kMJI4/QaQCNBwqoiuS1XILKy2gUChf+ec2aYDnJMS1+yulpNBFymV5Se4VMr0gdH
 Ikm0+RvAAaoEK0Rt0e50szXumGNAr1yGDSKKL5iGZqQY40yDHbakh1Z3jqEvOuaqKyKZ
 r76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766781121; x=1767385921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CzAGB9yL8G5U4vFJFxQvsqsvNZ+dnI5o8uF0Ip/aT0=;
 b=j83AomrZTFCalUNxXyRjR6U9LmQVucmdypg6Kq6CyijhKt1JhgUSvjcd8FAfUQux37
 mN1PyKsuA8igNFMYs2Bq/ZzC5gXpjiOzB9GSP7k9d8oweLSfkagdEHcGzV7+u3LQwVa/
 uva33pUIhQeTJSxNGPNoEGX+/NhNSnWXxoODrEqXfGbW9C5neMKYM9MavV2QewWmaxFk
 zGU1M1w/9jD7yODmM4nNdddm43Xrkjh0NtI4zxY1d6JwcP7LjrM8XQK2cYPrtzmrMbQa
 bU6PvGKkJA3hHg5dh3WYAZs5K1kWsHuM4CqW1xcq3l9DPEMsUgpoOaAzROBu0V1LNNQI
 SoMg==
X-Gm-Message-State: AOJu0YzlNEHNVsmkHviwzjaw2bobf7joExVxwfpPaFGKQGzPUtuWcZE3
 5wcKCJfc0AJrM/E2tbI+M0rEz+SzpzJAAjkWoJCFD33vYVinqdKhjx9I4GIB/5m/+Zo=
X-Gm-Gg: AY/fxX4rvK+b0jeOb9NrhjbKhcnisRak2XddnQ7LNxCkyY2NzSe9OfzEQoNcONQvAck
 74+4YluwmYN6P4byxWotNsy80AiYMaHWLWoX3Us7seFXYNHydelTMPAv5po6DJ6C56QP5QCqpFk
 7xcpFC34tizS6JxZ9LHjEgwXyxI+zZuS7lUUazbtWUXmBn8bKqFegDke/F3sUl25yOL22KroBDk
 brd+YJEsn8hTO/05RoAaxeWTo2lgB9KEJfRAG7HkjZcgWColJ3J842YPmliUKrG+h66I27nmmSa
 Jo6zPCZpwhhbeLTdifxrskWDaSxeteQqSUg2y7QtpjLSbm3AvdsMa/XklasZ5fE8534t/cbEqBp
 tXSgVkhKJmMJ75zWFNCpXQ6CYYoj/sgYcnTHpRDLlRic1xfuKrf0CF5Eot10qzA6s6Q/q3UuaNi
 MxuMKPAqDhC9tObZVUnPCUEaBIyZiTKjA=
X-Google-Smtp-Source: AGHT+IEIUNTaWB2hi8XKe22lMWb9QuDt+aUnwvuVNq863ndN6spf1OjhuYJIkA3Y/CWOehFytFbhfQ==
X-Received: by 2002:a05:600c:3b88:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-47d19556cf7mr331207655e9.12.1766781120661; 
 Fri, 26 Dec 2025 12:32:00 -0800 (PST)
Received: from tuf-gaming ([2a02:2f01:760c:a301:1665:9199:948a:6af7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm47640451f8f.35.2025.12.26.12.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 12:31:59 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Subject: [PATCH] linux-user: add support for MAP_32BIT
Date: Fri, 26 Dec 2025 22:31:47 +0200
Message-ID: <20251226203147.1964597-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x32f.google.com
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

x86_64 defines MAP_32BIT which forces `mmap()` to return a 32-bit
address. This commit adds support for this flag if supported by the
host.

Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
---
 include/user/abitypes.h         |  2 ++
 include/user/thunk.h            |  3 ++
 linux-user/strace.c             | 26 ++++++++++++++++-
 linux-user/strace.list          |  4 +--
 linux-user/syscall.c            | 50 ++++++++++++++++-----------------
 linux-user/x86_64/target_mman.h |  3 ++
 6 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/include/user/abitypes.h b/include/user/abitypes.h
index be7a876523..0228e1b77c 100644
--- a/include/user/abitypes.h
+++ b/include/user/abitypes.h
@@ -47,6 +47,8 @@ typedef uint32_t abi_uint __attribute__((aligned(ABI_INT_ALIGNMENT)));
 typedef int64_t abi_llong __attribute__((aligned(ABI_LLONG_ALIGNMENT)));
 typedef uint64_t abi_ullong __attribute__((aligned(ABI_LLONG_ALIGNMENT)));
 
+#define TARGET_ABI_FMT_x  "%08x"
+
 #ifdef TARGET_ABI32
 typedef uint32_t abi_ulong __attribute__((aligned(ABI_LONG_ALIGNMENT)));
 typedef int32_t abi_long __attribute__((aligned(ABI_LONG_ALIGNMENT)));
diff --git a/include/user/thunk.h b/include/user/thunk.h
index 2a2104b568..e4cfb5fe46 100644
--- a/include/user/thunk.h
+++ b/include/user/thunk.h
@@ -73,6 +73,9 @@ typedef struct bitmask_transtbl {
     unsigned int host_bits;
 } bitmask_transtbl;
 
+#define BITMASK_BIT(target, host) \
+    { target, target, host, host }
+
 void thunk_register_struct(int id, const char *name, const argtype *types);
 void thunk_register_struct_direct(int id, const char *name,
                                   const StructEntry *se1);
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 758c5d32b6..616c801e6b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -802,6 +802,27 @@ print_syscall_ret_addr(CPUArchState *cpu_env, const struct syscallname *name,
     qemu_log("\n");
 }
 
+static void
+print_mmap_ret(CPUArchState *cpu_env, const struct syscallname *name,
+               abi_long ret, abi_long arg0, abi_long arg1,
+               abi_long arg2, abi_long arg3, abi_long arg4,
+               abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        const abi_ulong mmap_flags = (abi_ulong)arg3;
+        /*
+         * If MAP_32BIT is set, print the address as a 32-bit value. This is
+         * consistent with strace output
+         */
+        if (mmap_flags & MAP_32BIT) {
+            qemu_log("0x" TARGET_ABI_FMT_x, (abi_uint)ret);
+        } else {
+            qemu_log("0x" TARGET_ABI_FMT_lx, ret);
+        }
+    }
+    qemu_log("\n");
+}
+
 #if 0 /* currently unused */
 static void
 print_syscall_ret_raw(struct syscallname *name, abi_long ret)
@@ -1196,8 +1217,11 @@ UNUSED static const struct flags mmap_flags[] = {
     FLAG_TARGET(MAP_POPULATE),
     FLAG_TARGET(MAP_STACK),
     FLAG_TARGET(MAP_SYNC),
-#if TARGET_MAP_UNINITIALIZED != 0
+#ifdef TARGET_MAP_UNINITIALIZED
     FLAG_TARGET(MAP_UNINITIALIZED),
+#endif
+#ifdef TARGET_MAP_32BIT
+    FLAG_TARGET(MAP_32BIT),
 #endif
     FLAG_END,
 };
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 51b5ead969..7a8d18ba96 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -602,10 +602,10 @@
 { TARGET_NR_mlockall, "mlockall" , NULL, print_mlockall, NULL },
 #endif
 #ifdef TARGET_NR_mmap
-{ TARGET_NR_mmap, "mmap" , NULL, print_mmap, print_syscall_ret_addr },
+{ TARGET_NR_mmap, "mmap" , NULL, print_mmap, print_mmap_ret },
 #endif
 #ifdef TARGET_NR_mmap2
-{ TARGET_NR_mmap2, "mmap2" , NULL, print_mmap2, print_syscall_ret_addr },
+{ TARGET_NR_mmap2, "mmap2" , NULL, print_mmap2, print_mmap_ret },
 #endif
 #ifdef TARGET_NR_modify_ldt
 { TARGET_NR_modify_ldt, "modify_ldt" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..0bb56e7a8e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5896,32 +5896,6 @@ static const StructEntry struct_termios_def = {
 #define MAP_UNINITIALIZED 0
 #endif
 
-static const bitmask_transtbl mmap_flags_tbl[] = {
-    { TARGET_MAP_FIXED, TARGET_MAP_FIXED, MAP_FIXED, MAP_FIXED },
-    { TARGET_MAP_ANONYMOUS, TARGET_MAP_ANONYMOUS,
-      MAP_ANONYMOUS, MAP_ANONYMOUS },
-    { TARGET_MAP_GROWSDOWN, TARGET_MAP_GROWSDOWN,
-      MAP_GROWSDOWN, MAP_GROWSDOWN },
-    { TARGET_MAP_DENYWRITE, TARGET_MAP_DENYWRITE,
-      MAP_DENYWRITE, MAP_DENYWRITE },
-    { TARGET_MAP_EXECUTABLE, TARGET_MAP_EXECUTABLE,
-      MAP_EXECUTABLE, MAP_EXECUTABLE },
-    { TARGET_MAP_LOCKED, TARGET_MAP_LOCKED, MAP_LOCKED, MAP_LOCKED },
-    { TARGET_MAP_NORESERVE, TARGET_MAP_NORESERVE,
-      MAP_NORESERVE, MAP_NORESERVE },
-    { TARGET_MAP_HUGETLB, TARGET_MAP_HUGETLB, MAP_HUGETLB, MAP_HUGETLB },
-    /* MAP_STACK had been ignored by the kernel for quite some time.
-       Recognize it for the target insofar as we do not want to pass
-       it through to the host.  */
-    { TARGET_MAP_STACK, TARGET_MAP_STACK, 0, 0 },
-    { TARGET_MAP_NONBLOCK, TARGET_MAP_NONBLOCK, MAP_NONBLOCK, MAP_NONBLOCK },
-    { TARGET_MAP_POPULATE, TARGET_MAP_POPULATE, MAP_POPULATE, MAP_POPULATE },
-    { TARGET_MAP_FIXED_NOREPLACE, TARGET_MAP_FIXED_NOREPLACE,
-      MAP_FIXED_NOREPLACE, MAP_FIXED_NOREPLACE },
-    { TARGET_MAP_UNINITIALIZED, TARGET_MAP_UNINITIALIZED,
-      MAP_UNINITIALIZED, MAP_UNINITIALIZED },
-};
-
 /*
  * Arrange for legacy / undefined architecture specific flags to be
  * ignored by mmap handling code.
@@ -5936,6 +5910,30 @@ static const bitmask_transtbl mmap_flags_tbl[] = {
 #define TARGET_MAP_HUGE_1GB 0
 #endif
 
+static const bitmask_transtbl mmap_flags_tbl[] = {
+    BITMASK_BIT(TARGET_MAP_FIXED, MAP_FIXED),
+    BITMASK_BIT(TARGET_MAP_ANONYMOUS, MAP_ANONYMOUS),
+    BITMASK_BIT(TARGET_MAP_GROWSDOWN, MAP_GROWSDOWN),
+    BITMASK_BIT(TARGET_MAP_DENYWRITE, MAP_DENYWRITE),
+    BITMASK_BIT(TARGET_MAP_EXECUTABLE, MAP_EXECUTABLE),
+    BITMASK_BIT(TARGET_MAP_LOCKED, MAP_LOCKED),
+    BITMASK_BIT(TARGET_MAP_NORESERVE, MAP_NORESERVE),
+    BITMASK_BIT(TARGET_MAP_HUGETLB, MAP_HUGETLB),
+    /*
+     * MAP_STACK had been ignored by the kernel for quite some time.
+     * Recognize it for the target insofar as we do not want to pass
+     * it through to the host.
+     */
+    BITMASK_BIT(TARGET_MAP_STACK, 0),
+    BITMASK_BIT(TARGET_MAP_NONBLOCK, MAP_NONBLOCK),
+    BITMASK_BIT(TARGET_MAP_POPULATE, MAP_POPULATE),
+    BITMASK_BIT(TARGET_MAP_FIXED_NOREPLACE, MAP_FIXED_NOREPLACE),
+    BITMASK_BIT(TARGET_MAP_UNINITIALIZED, MAP_UNINITIALIZED),
+#if TARGET_MAP_32BIT != 0
+    BITMASK_BIT(TARGET_MAP_32BIT, MAP_32BIT),
+#endif
+};
+
 static abi_long do_mmap(abi_ulong addr, abi_ulong len, int prot,
                         int target_flags, int fd, off_t offset)
 {
diff --git a/linux-user/x86_64/target_mman.h b/linux-user/x86_64/target_mman.h
index 48fbf20b42..14c29203f9 100644
--- a/linux-user/x86_64/target_mman.h
+++ b/linux-user/x86_64/target_mman.h
@@ -13,4 +13,7 @@
 /* arch/x86/include/asm/elf.h */
 #define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
 
+/* arch/x86/include/uapi/asm/mman.h */
+#define TARGET_MAP_32BIT 0x40
+
 #include "../generic/target_mman.h"
-- 
2.51.0


