Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38616C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvjQ-0008B9-Km; Tue, 25 Feb 2025 09:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.szyprowski@samsung.com>)
 id 1tmuIj-0005Mm-VR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:44:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.szyprowski@samsung.com>)
 id 1tmuIe-0003cE-IM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:44:40 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20250225124424euoutp01253acd9e3cd7a2e854a23d88a73b69cd~ndCCx8uTc1123511235euoutp015
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:44:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20250225124424euoutp01253acd9e3cd7a2e854a23d88a73b69cd~ndCCx8uTc1123511235euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1740487464;
 bh=nb4/FGwpc0ZvlcW6T82BW/IoYGw7X61bnHpjvQN7tVw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=gGz6y0jHc5GwAGeke0E/qIgQ78sCnuM9VU2bqdU2vsueZWt5bRU9Bp+UM83atwkVg
 N6Ij7jR4pc9x1Ytuj+lQP7PP5Oqc1tHd6G6hQN3QUiKgNMr8rf5bEQ3CaHdt3z7syt
 UiY9fqr7RnxI1N1f5w8Qk3vW8ZjohKmcyAUuKBjk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20250225124424eucas1p1f80ce5e90273b294d6966f0902ccc95b~ndCCcsO6T2105121051eucas1p1I;
 Tue, 25 Feb 2025 12:44:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 7D.43.20409.82BBDB76; Tue, 25
 Feb 2025 12:44:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20250225124423eucas1p150140ffe95a53e4d802b3594a89707b8~ndCCCVTkX0644106441eucas1p1l;
 Tue, 25 Feb 2025 12:44:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250225124423eusmtrp12c956444221f348d502f678f8c4ee842~ndCCByZ_91244912449eusmtrp1A;
 Tue, 25 Feb 2025 12:44:23 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-1a-67bdbb28311b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.0E.19920.72BBDB76; Tue, 25
 Feb 2025 12:44:23 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250225124423eusmtip2719f90ba7eb9b3cc0af903887d2e0543~ndCBl3uWj1322813228eusmtip2E;
 Tue, 25 Feb 2025 12:44:23 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Laurent Vivier
 <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] linux-user: add support for the AARCH64 ILP32 ABI
Date: Tue, 25 Feb 2025 13:44:18 +0100
Message-Id: <20250225124418.3530474-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOV2N3XvTDf69FbFo3rSc1WLtkbvs
 FnPOPGCxWNC9kM3ieO8OFgdWjzvX9rB5PLm2mcmjb8sqRo87h6ewBrBEcdmkpOZklqUW6dsl
 cGXcWfeJuWBaesXqlkeMDYxzg7sYOTkkBEwkFl/8yNjFyMUhJLCCUeLJ6aUsEM4XRonHTa+g
 nM+MEgffXGbqYuQAa+k+CBVfzijx4+pZNriOGa/nMoLMZRMwlOh628UGYosI6EnMWHcHLM4s
 UC9xqb2RFWSQsICTxImrRSBhFgFViZv/voGV8ArYS/Qtf8oMcZ68xP6DZ5kh4oISJ2c+YYEY
 Iy/RvHU2M8heCYFeDol3HYfYIBpcJHbuPgZlC0u8Or6FHcKWkTg9uYcFoqGdUWLB7/tMEM4E
 RomG57cYIaqsJe6c+8UGch2zgKbE+l36EGFHibubt7FCfM8nceOtIMQRfBKTtk1nhgjzSnS0
 CUFUq0nMOr4Obu3BC5egfvGQ2Dl5ISuILSQQK3FuQy/jBEaFWUhem4XktVkINyxgZF7FKJ5a
 WpybnlpslJdarlecmFtcmpeul5yfu4kRmE5O/zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuHlzNyT
 LsSbklhZlVqUH19UmpNafIhRmoNFSZx30f7WdCGB9MSS1OzU1ILUIpgsEwenVAOThn147rWd
 GqHKh16sfrCPpTgvpPVij8HiX9uUv73t3npi8YUMUxnboL+SSvvb//PuevrqkYHlifnfpHP5
 rPkX3p2Zc+bU4veGzfu4HGX/hqZK7f3+7GHJFIvjIadM+dYeyOnxPR988tMWG0O2VoPZjxsD
 c+8stTz6z6cx5OzmzT7MLpuvGf2wW29hx8p4ZeWG9/6bc1MqjKb7qy1yUmqfc+ys5s6N7T+N
 rJ6tdbWo3CF282HqrisXt7u/KOJQVV/m9uRnFE+N0vLwqR4TyrJYzob91t97PPH9+ZY11q+i
 P64Susrxx47bUc7caU6myOr01Qe+uZ+8mKF1aLVbfHRPgPL0Yr/sr6xruFIUPrgZKrEUZyQa
 ajEXFScCAGN9hQ6WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsVy+t/xe7rqu/emG7z8ZGTRvGk5q8XaI3fZ
 LeacecBisaB7IZvF8d4dLA6sHneu7WHzeHJtM5NH35ZVjB53Dk9hDWCJ0rMpyi8tSVXIyC8u
 sVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4s+4Tc8G09IrVLY8YGxjn
 BncxcnBICJhIdB9k6WLk5BASWMoosWOjIIgtISAjcXJaAyuELSzx51oXWxcjF1DNJ0aJzx/X
 soEk2AQMJbredoHZIgIGEtt3fmMFKWIWaGSUODNxNjvIAmEBJ4kTV4tAalgEVCVu/vvGCGLz
 CthL9C1/ygyxQF5i/8GzzBBxQYmTM5+AHcQMFG/eOpt5AiPfLCSpWUhSCxiZVjGKpJYW56bn
 FhvqFSfmFpfmpesl5+duYgQG8bZjPzfvYJz36qPeIUYmDsZDjBIczEoivJyZe9KFeFMSK6tS
 i/Lji0pzUosPMZoC3TeRWUo0OR8YR3kl8YZmBqaGJmaWBqaWZsZK4rxul8+nCQmkJ5akZqem
 FqQWwfQxcXBKNTDN/8gYfmKJaOOaIM0Zdnvsf1ytebAq3VFXhDN9sYTd9h8bJ+ote/HE+un+
 Nn7foDglVyXLe6tqS2SvlQd5eXb5zj79ti65TmTaDmmN3135xzYd3Z9VmmVsKP3fybEh/tyN
 98VJvgdztOs2GHqWybw+ULldt33vp8MayXNcXgR95ux00bARW6nxb1PXGrEqvm+L5zt2/t/6
 //za938WRPfHvetafC/jo8azlh0HxIW4fcNKmt/wPki2mRjPrbVF+W2cRV6F6WnjC4WfLCMt
 p3jOuVVj1aTHw8y5OKPl8uZr8l/iz/3N/aF5LiBWZUO0uflqS92zVvLZ+wK7xfkq3Bb8kdP+
 +HFW0W7zxMmOHUosxRmJhlrMRcWJAPAosIfrAgAA
X-CMS-MailID: 20250225124423eucas1p150140ffe95a53e4d802b3594a89707b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250225124423eucas1p150140ffe95a53e4d802b3594a89707b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250225124423eucas1p150140ffe95a53e4d802b3594a89707b8
References: <CGME20250225124423eucas1p150140ffe95a53e4d802b3594a89707b8@eucas1p1.samsung.com>
Received-SPF: pass client-ip=210.118.77.11;
 envelope-from=m.szyprowski@samsung.com; helo=mailout1.w1.samsung.com
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Feb 2025 09:16:08 -0500
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

This patch adds support for the AARCH64 ILP32 ABI [1] to the QEMU
linux-user AARCH64 port.

The ILP32 ABI was initially developed quite some time ago [2] to
facilitate porting legacy code to the new AARCH64 architecture. However,
it appears that most legacy code is still used as ARMv7 (ARM 32-bit)
binaries, running on ARM 64-bit CPUs through the 32-bit EL0 compatibility
feature of those CPUs. As a result, the ILP32 ABI has not been widely
adopted.

The 32-bit EL0 compatibility feature is optional, and it seems that
upcoming ARM 64-bit CPUs will not include it [3]. Therefore, the AARCH64
ILP32 ABI can be revived to support running older legacy code. The ILP32
ABI can also be beneficial on systems with tight memory constraints, as
32-bit code typically consumes less memory, both in terms of operation
and code size, compared to the same code using a 64-bit ABI.

This indicates that there are still important use cases for the AARCH64
ILP32 ABI. Adding support for such binaries in the QEMU linux-user
enables common development scenarios, such as simulating a build-system
with AARCH64 ILP32 ABI instead of relying on explicit cross-compilation.

The qemu-aarch64_ilp32 target as been tested with tests from the Linux
Test Project [4] copiled with the toolchain released once by the Linaro
[5]. The results are very similar to qemu-arm and other 32bit linux-user
targets. Manual inspection of the failures didn't reveal any failures
specific to AARCH64 ILP32 ABI version.

[1] https://github.com/ARM-software/abi-aa/blob/main/aaelf64/aaelf64.rst
[2] https://lore.kernel.org/all/20180516081910.10067-1-ynorov@caviumnetworks.com/
[3] https://developer.arm.com/documentation/109697/2024_12/Feature-descriptions/The-Armv9-0-architecture-extension?lang=en
[4] https://github.com/linux-test-project/ltp
[5] https://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 configs/targets/aarch64_ilp32-linux-user.mak | 10 +++
 linux-user/aarch64/syscall_64.tbl            |  2 +-
 linux-user/aarch64/target_mman.h             |  6 ++
 linux-user/elfload.c                         |  6 ++
 linux-user/qemu.h                            |  4 +-
 linux-user/syscall.c                         |  6 +-
 linux-user/syscall_defs.h                    | 65 +++++++++++++++++++-
 linux-user/user-internals.h                  |  4 +-
 scripts/qemu-binfmt-conf.sh                  |  6 +-
 target/arm/cpu-param.h                       |  6 +-
 10 files changed, 103 insertions(+), 12 deletions(-)
 create mode 100644 configs/targets/aarch64_ilp32-linux-user.mak

diff --git a/configs/targets/aarch64_ilp32-linux-user.mak b/configs/targets/aarch64_ilp32-linux-user.mak
new file mode 100644
index 0000000000..e70fd98eef
--- /dev/null
+++ b/configs/targets/aarch64_ilp32-linux-user.mak
@@ -0,0 +1,10 @@
+TARGET_ARCH=aarch64
+TARGET_BASE_ARCH=arm
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
+TARGET_HAS_BFLT=y
+CONFIG_SEMIHOSTING=y
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+TARGET_SYSTBL_ABI=common,32,time32,stat64,renameat,rlimit,memfd_secret
+TARGET_SYSTBL=syscall_64.tbl
+TARGET_LONG_BITS=64
+TARGET_ABI32=y
diff --git a/linux-user/aarch64/syscall_64.tbl b/linux-user/aarch64/syscall_64.tbl
index 845e24eb37..33507d823b 100644
--- a/linux-user/aarch64/syscall_64.tbl
+++ b/linux-user/aarch64/syscall_64.tbl
@@ -265,7 +265,7 @@
 221	common	execve				sys_execve			compat_sys_execve
 222	32	mmap2				sys_mmap2
 222	64	mmap				sys_mmap
-223	32	fadvise64_64			sys_fadvise64_64		compat_sys_fadvise64_64
+223	32	arm_fadvise64_64		sys_arm_fadvise64_64
 223	64	fadvise64			sys_fadvise64_64
 224	common	swapon				sys_swapon
 225	common	swapoff				sys_swapoff
diff --git a/linux-user/aarch64/target_mman.h b/linux-user/aarch64/target_mman.h
index 69ec5d5739..7356235a40 100644
--- a/linux-user/aarch64/target_mman.h
+++ b/linux-user/aarch64/target_mman.h
@@ -4,6 +4,7 @@
 #define TARGET_PROT_BTI         0x10
 #define TARGET_PROT_MTE         0x20
 
+#ifndef TARGET_ABI32
 /*
  * arch/arm64/include/asm/processor.h:
  *
@@ -16,6 +17,11 @@
 
 /* arch/arm64/include/asm/elf.h */
 #define ELF_ET_DYN_BASE         TARGET_PAGE_ALIGN((1ull << 48) / 3 * 2)
+#else
+/* aarch64_ilp32 */
+#define TASK_UNMAPPED_BASE      (1ull << (30))
+#define ELF_ET_DYN_BASE         TARGET_PAGE_ALIGN((1ull << 30) / 3 * 2)
+#endif
 
 #include "../generic/target_mman.h"
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a2c152e5ad..70d2913915 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -682,7 +682,11 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 /* 64 bit ARM definitions */
 
 #define ELF_ARCH        EM_AARCH64
+#ifndef TARGET_ABI32
 #define ELF_CLASS       ELFCLASS64
+#else
+#define ELF_CLASS       ELFCLASS32
+#endif
 #if TARGET_BIG_ENDIAN
 # define ELF_PLATFORM    "aarch64_be"
 #else
@@ -977,11 +981,13 @@ const char *elf_hwcap2_str(uint32_t bit)
 
 #undef GET_FEATURE_ID
 
+#ifndef TARGET_ABI32
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER  "vdso-be.c.inc"
 #else
 # define VDSO_HEADER  "vdso-le.c.inc"
 #endif
+#endif
 
 #endif /* not TARGET_AARCH64 */
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5f00750151..1acf50b2b7 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -86,7 +86,7 @@ struct vm86_saved_state {
 };
 #endif
 
-#if defined(TARGET_ARM) && defined(TARGET_ABI32)
+#if defined(TARGET_ARM) && defined(TARGET_ABI32) && !defined(TARGET_AARCH64)
 /* FPU emulator */
 #include "nwfpe/fpa11.h"
 #endif
@@ -98,7 +98,7 @@ struct emulated_sigtable {
 
 struct TaskState {
     pid_t ts_tid;     /* tid (or pid) of this task */
-#ifdef TARGET_ARM
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
 # ifdef TARGET_ABI32
     /* FPA state */
     FPA11 fpa;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 02ea4221c9..1012686227 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6936,7 +6936,7 @@ static inline abi_long copy_to_user_flock(abi_ulong target_flock_addr,
 typedef abi_long from_flock64_fn(struct flock *fl, abi_ulong target_addr);
 typedef abi_long to_flock64_fn(abi_ulong target_addr, const struct flock *fl);
 
-#if defined(TARGET_ARM) && TARGET_ABI_BITS == 32
+#if defined(TARGET_ARM) && TARGET_ABI_BITS == 32 && !defined(TARGET_AARCH64)
 struct target_oabi_flock64 {
     abi_short l_type;
     abi_short l_whence;
@@ -7642,7 +7642,7 @@ static inline abi_long host_to_target_stat64(CPUArchState *cpu_env,
                                              abi_ulong target_addr,
                                              struct stat *host_st)
 {
-#if defined(TARGET_ARM) && defined(TARGET_ABI32)
+#if defined(TARGET_ARM) && defined(TARGET_ABI32) && !defined(TARGET_AARCH64)
     if (cpu_env->eabi) {
         struct target_eabi_stat64 *target_st;
 
@@ -12533,7 +12533,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         from_flock64_fn *copyfrom = copy_from_user_flock64;
         to_flock64_fn *copyto = copy_to_user_flock64;
 
-#ifdef TARGET_ARM
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
         if (!cpu_env->eabi) {
             copyfrom = copy_from_user_oabi_flock64;
             copyto = copy_to_user_oabi_flock64;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 86d773add7..292939575c 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -60,7 +60,7 @@
 #define TARGET_IOC_TYPEBITS     8
 
 #if (defined(TARGET_I386) && defined(TARGET_ABI32))                     \
-    || (defined(TARGET_ARM) && defined(TARGET_ABI32))                   \
+    || (defined(TARGET_ARM) && defined(TARGET_ABI32) && !defined(TARGET_AARCH64))                   \
     || (defined(TARGET_SPARC) && defined(TARGET_ABI32))                 \
     || defined(TARGET_M68K) || defined(TARGET_SH4)
 /* 16 bit uid wrappers emulation */
@@ -1234,7 +1234,7 @@ struct target_winsize {
 #include "target_mman.h"
 
 #if (defined(TARGET_I386) && defined(TARGET_ABI32))     \
-    || (defined(TARGET_ARM) && defined(TARGET_ABI32))
+    || (defined(TARGET_ARM) && defined(TARGET_ABI32) && !defined(TARGET_AARCH64))
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
     abi_ushort st_dev;
@@ -1905,7 +1905,7 @@ struct target_stat {
     abi_long       st_blocks;
     abi_ulong  __unused[3];
 };
-#elif defined(TARGET_AARCH64)
+#elif defined(TARGET_AARCH64) && !defined(TARGET_ABI32)
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
     abi_ulong  st_dev;
@@ -1928,6 +1928,65 @@ struct target_stat {
     abi_ulong  target_st_ctime_nsec;
     abi_uint __unused[2];
 };
+#elif defined(TARGET_AARCH64) && defined(TARGET_ABI32)
+#define TARGET_STAT_HAVE_NSEC
+struct target_stat {
+    abi_ulong  st_dev;
+    abi_ulong  __ilp32_pad1;
+    abi_ulong  st_ino;
+    abi_ulong  __ilp32_pad2;
+    abi_uint   st_mode;
+    abi_uint   st_nlink;
+    abi_uint   st_uid;
+    abi_uint   st_gid;
+    abi_ulong  st_rdev;
+    abi_ulong  __ilp32_pad3;
+    abi_ulong  _pad1;
+    abi_ulong  __ilp32_pad4;
+    abi_long  st_size;
+    abi_ulong  __ilp32_pad5;
+    abi_int    st_blksize;
+    abi_int    __pad2;
+    abi_long   st_blocks;
+    abi_ulong __ilp32_pad6;
+    abi_long  target_st_atime;
+    abi_ulong  target_st_atime_nsec;
+    abi_long  target_st_mtime;
+    abi_ulong  target_st_mtime_nsec;
+    abi_long  target_st_ctime;
+    abi_ulong  target_st_ctime_nsec;
+    abi_uint __unused[2];
+};
+
+#define TARGET_HAS_STRUCT_STAT64
+struct target_stat64 {
+    abi_ulong  st_dev;
+    abi_ulong  __ilp32_pad1;
+#define TARGET_STAT64_HAS_BROKEN_ST_INO 1
+    abi_ulong  __st_ino;
+    abi_ulong  __ilp32_pad2;
+    abi_uint   st_mode;
+    abi_uint   st_nlink;
+    abi_uint   st_uid;
+    abi_uint   st_gid;
+    abi_ulong  st_rdev;
+    abi_ulong  __ilp32_pad3;
+    abi_ulong  __pad1;
+    abi_ulong  __ilp32_pad4;
+    abi_llong  st_size;
+    abi_int    st_blksize;
+    abi_int    _pad2;
+    abi_long   st_blocks;
+    abi_ulong  __ilp32_pad5;
+    abi_long   target_st_atime;
+    abi_ulong  target_st_atime_nsec;
+    abi_long   target_st_mtime;
+    abi_ulong  target_st_mtime_nsec;
+    abi_long   target_st_ctime;
+    abi_ulong  target_st_ctime_nsec;
+    abi_ullong st_ino;
+} QEMU_PACKED;
+
 #elif defined(TARGET_XTENSA)
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index b9b05c1d11..b13ca36577 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -130,8 +130,10 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 
 void print_termios(void *arg);
 
+#if (TARGET_ABI_BITS == 32) && defined(TARGET_AARCH64)
+static inline int regpairs_aligned(CPUArchState *cpu_env, int num) { return 1; }
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
-#ifdef TARGET_ARM
+#elif TARGET_ARM
 static inline int regpairs_aligned(CPUArchState *cpu_env, int num)
 {
     return cpu_env->eabi;
diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 6ef9f118d9..695d15e6ea 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -104,6 +104,10 @@ aarch64_be_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0
 aarch64_be_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 aarch64_be_family=armeb
 
+aarch64_ilp32_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7\x00'
+aarch64_ilp32_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
+aarch64_ilp32_family=arm
+
 hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x0f'
 hppa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 hppa_family=hppa
@@ -159,7 +163,7 @@ qemu_get_family() {
     ppc64el|ppc64le)
         echo "ppcle"
         ;;
-    arm|armel|armhf|arm64|armv[4-9]*l|aarch64)
+    arm|armel|armhf|arm64|armv[4-9]*l|aarch64|aarch64_ilp32)
         echo "arm"
         ;;
     armeb|armv[4-9]*b|aarch64_be)
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 896b35bd6d..151d512e91 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -8,9 +8,13 @@
 #ifndef ARM_CPU_PARAM_H
 #define ARM_CPU_PARAM_H
 
-#ifdef TARGET_AARCH64
+#if defined(TARGET_AARCH64) && !defined(TARGET_ABI32)
 # define TARGET_PHYS_ADDR_SPACE_BITS  52
 # define TARGET_VIRT_ADDR_SPACE_BITS  52
+#elif defined(TARGET_AARCH64) && defined(TARGET_ABI32)
+# define TARGET_LONG_BITS             64
+# define TARGET_PHYS_ADDR_SPACE_BITS  40
+# define TARGET_VIRT_ADDR_SPACE_BITS  32
 #else
 # define TARGET_PHYS_ADDR_SPACE_BITS  40
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
-- 
2.34.1


