Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBDFC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMUn-0003jH-3g; Tue, 20 May 2025 08:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUL-0002PE-Mw; Tue, 20 May 2025 08:54:38 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUH-000109-Td; Tue, 20 May 2025 08:54:33 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso4693622a91.3; 
 Tue, 20 May 2025 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745666; x=1748350466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvwVU9F6cQaGXnx8rRhBrrA5oqA9zp4XDJF1ywgSwYE=;
 b=MG/WRv+ucLbCFUp3eM3Z7kWJAQiXtR0g75vxSu0i0YuLzhnPNdLPk7WF/P+lZhiYTG
 4Gq/ax0aNybz3lU21WXg4zcqzQrBUdO+WZsPKve2RQe+KD6lAKguT2oDlfibaWy+Qvk+
 3zY+pL6+Zu44cqJktzsqr25OtT5hueRVpbkDFMSG52nV2ZxSLuqWo3EdNXC/7+9tuvzq
 Q6XGk548J2Nphi8WhS2SAAWSNUhAMYiso0Dl6pusbjIgXis3qWD8EW/68vIdhViMdr8d
 V0pbY8kaiMrfEXjXsd3qkdSAq2OgjL3N+kTOXfv5Nw0ehHLYz7VHpJy0jQ5ROgEnqQoa
 cilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745666; x=1748350466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvwVU9F6cQaGXnx8rRhBrrA5oqA9zp4XDJF1ywgSwYE=;
 b=DxQpsYQYvqqE6fcdgJjT4R/kEekfxnytQjquKAEjEtr8rGHRxqvH7zYgKrj/lcJv8a
 c9D2RWeXtL5tcJ8pVJWpM1PMCEQ1nX1LqwaWdL+MboT54wXliE2jbYInzLIyCqWxj9Cb
 JoVppFkeIatxeChNsm6hrWrOEmNsMfXyZdWHx11wpMoTZv0K5IVQ5YxyOgjeNK9pmUwR
 c2irMgNqu7h6ls+AoTNau3yF1UQwpgJ31/T3BtwqKR10L1J0vR59k2BdX87Kl2wntBGF
 2/Cwpg2XJKpfpKTJRiMlSAuPe4AggRgkRmpTVgv/fDNGDxCT5vTjUtuCkM3LX3JazbDt
 qKKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3e3z1djNt9T6kksi4e0GuQhomiOBMX6Za25GYeRGxbMoH+OoqvfVRFQv+zzAesmOKSoP+QmiCYVSleA==@nongnu.org,
 AJvYcCX4adKZYjyrCrZKVMpxbs06aK2i73ab0ay0NWSslnA0HOm9hd8tZ5ntLbFsNq69bJ7CfEce25EzhQ==@nongnu.org
X-Gm-Message-State: AOJu0YzfU6L7DEZb85cwYgKfKvtXrWDDxDO8/DIQk8N39TzE0ug4saMY
 +1BotJBUy0ofEf6WVS998wTPDD02hm99ucyJ4pZkl8gcOn/zScrqwTwN3sEUbMtq
X-Gm-Gg: ASbGncsRma2nghd6z2SLhBGTul46FnUlbg3Kzrpzu8Ic6Fd3VAnd4elzToHh4QO8xT8
 u19VgFSBIoT0NtqkCuU49Z/G53+Jz7NH6VRcHvEr+GXqFezo2BdCtdHoHGuZFVPtBYUP1b4rMJD
 gj6kWSt+suUGmeehQXkwRTLI7cAIAyhqyKMexBgH5mSTJwiIPdHQMhFrr08VBHfHSSBGv2lh7Hr
 fSe+qMaKP+S67pqf5DdfVKJZBJ2/nIBiIWpcPJ5tTScm+ryMIl5yetQKCgDGFgttptp1pOduEkL
 GG/mi/qHi86ZIos3x46d+GIRUK3UsVy32X2r8d2TT5B5DxSV3w8=
X-Google-Smtp-Source: AGHT+IHUv1Ky3GKBjVeftojRctD7ekQgFkcQPAUZGG0rypCRZbOSLLaaaceS/2YOW575tisr9dvdyA==
X-Received: by 2002:a17:90b:3c90:b0:30e:37be:6963 with SMTP id
 98e67ed59e1d1-30e83228d1cmr24997945a91.29.1747745665822; 
 Tue, 20 May 2025 05:54:25 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:25 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 23/33] include/exec: Allow using 64bit guest addresses on
 emscripten
Date: Tue, 20 May 2025 21:51:25 +0900
Message-ID: <d3e7e584cf61c76952f4c9d913ba80d905c80e76.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1036.google.com
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

To enable 64-bit guest support in Wasm 32bit memory model today, it was
necessary to partially revert recent changes that removed support for
different pointer widths between the host and guest (e.g. commits
a70af12addd9060fdf8f3dbd42b42e3072c3914f and
bf455ec50b6fea15b4d2493059365bf94c706273) when compiling with
Emscripten. While this serves as a temporary workaround, a long-term
solution could involve adopting Wasm's 64-bit memory model once it gains
broader support, as it is currently not widely adopted (e.g. unsupported by
Safari and libffi).

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 accel/tcg/cputlb.c             |  8 ++++----
 include/exec/helper-head.h.inc |  6 ++++++
 include/exec/tlb-common.h      | 14 ++++++++++----
 include/exec/vaddr.h           | 11 +++++++++++
 include/qemu/atomic.h          |  4 ++++
 include/tcg/tcg.h              |  4 ++++
 meson.build                    |  8 +++++---
 7 files changed, 44 insertions(+), 11 deletions(-)

V1:
- Although I tried to use "#if HOST_LONG_BITS >= TARGET_LONG_BITS" based on
  Paolo's suggestion from the previous patch series, TARGET_LONG_BITS is
  marked as poisoned in include/exec/poison.h and cannot be used directly.

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5f6d7c601c..b15e9e80ee 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -109,13 +109,13 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
 {
     /* Do not rearrange the CPUTLBEntry structure members. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
-                      MMU_DATA_LOAD * sizeof(uintptr_t));
+                      MMU_DATA_LOAD * sizeof(tlb_addr));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
-                      MMU_DATA_STORE * sizeof(uintptr_t));
+                      MMU_DATA_STORE * sizeof(tlb_addr));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * sizeof(uintptr_t));
+                      MMU_INST_FETCH * sizeof(tlb_addr));
 
-    const uintptr_t *ptr = &entry->addr_idx[access_type];
+    const tlb_addr *ptr = &entry->addr_idx[access_type];
     /* ofs might correspond to .addr_write, so use qatomic_read */
     return qatomic_read(ptr);
 }
diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 5b248fd713..7dfb4cfa46 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -58,6 +58,7 @@
 # define dh_ctype_tl target_ulong
 #endif /* COMPILING_PER_TARGET */
 
+#ifndef EMSCRIPTEN
 #if __SIZEOF_POINTER__ == 4
 # define dh_alias_vaddr i32
 # define dh_typecode_vaddr dh_typecode_i32
@@ -68,6 +69,11 @@
 # error "sizeof pointer is different from {4,8}"
 #endif /* __SIZEOF_POINTER__ */
 # define dh_ctype_vaddr uintptr_t
+#else
+# define dh_alias_vaddr i64
+# define dh_typecode_vaddr dh_typecode_i64
+# define dh_ctype_vaddr uint64_t
+#endif
 
 /* We can't use glue() here because it falls foul of C preprocessor
    recursive expansion rules.  */
diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index 03b5a8ffc7..679054bb44 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -19,14 +19,20 @@
 #ifndef EXEC_TLB_COMMON_H
 #define EXEC_TLB_COMMON_H 1
 
+#ifndef EMSCRIPTEN
 #define CPU_TLB_ENTRY_BITS (HOST_LONG_BITS == 32 ? 4 : 5)
+typedef uintptr_t tlb_addr;
+#else
+#define CPU_TLB_ENTRY_BITS 5
+typedef uint64_t tlb_addr;
+#endif
 
 /* Minimalized TLB entry for use by TCG fast path. */
 typedef union CPUTLBEntry {
     struct {
-        uintptr_t addr_read;
-        uintptr_t addr_write;
-        uintptr_t addr_code;
+        tlb_addr addr_read;
+        tlb_addr addr_write;
+        tlb_addr addr_code;
         /*
          * Addend to virtual address to get host address.  IO accesses
          * use the corresponding iotlb value.
@@ -37,7 +43,7 @@ typedef union CPUTLBEntry {
      * Padding to get a power of two size, as well as index
      * access to addr_{read,write,code}.
      */
-    uintptr_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uintptr_t)];
+    tlb_addr addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(tlb_addr)];
 } CPUTLBEntry;
 
 QEMU_BUILD_BUG_ON(sizeof(CPUTLBEntry) != (1 << CPU_TLB_ENTRY_BITS));
diff --git a/include/exec/vaddr.h b/include/exec/vaddr.h
index 28bec632fb..ff57f944dd 100644
--- a/include/exec/vaddr.h
+++ b/include/exec/vaddr.h
@@ -9,6 +9,7 @@
  * We do not support 64-bit guest on 32-host and detect at configure time.
  * Therefore, a host pointer width will always fit a guest pointer.
  */
+#ifndef EMSCRIPTEN
 typedef uintptr_t vaddr;
 #define VADDR_PRId PRIdPTR
 #define VADDR_PRIu PRIuPTR
@@ -16,5 +17,15 @@ typedef uintptr_t vaddr;
 #define VADDR_PRIx PRIxPTR
 #define VADDR_PRIX PRIXPTR
 #define VADDR_MAX UINTPTR_MAX
+#else
+/* Explicitly define this as 64bit on emscripten */
+typedef uint64_t vaddr;
+#define VADDR_PRId PRId64
+#define VADDR_PRIu PRIu64
+#define VADDR_PRIo PRIo64
+#define VADDR_PRIx PRIx64
+#define VADDR_PRIX PRIX64
+#define VADDR_MAX UINT64_MAX
+#endif
 
 #endif
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f80cba24cf..76a8fbcd8c 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -56,6 +56,7 @@
  */
 #define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
 
+#ifndef EMSCRIPTEN
 /*
  * Sanity check that the size of an atomic operation isn't "overly large".
  * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
@@ -63,6 +64,9 @@
  * bit of sanity checking that other 32-bit hosts might build.
  */
 #define ATOMIC_REG_SIZE  sizeof(void *)
+#else
+#define ATOMIC_REG_SIZE  8 /* wasm supports 64bit atomics */
+#endif
 
 /* Weak atomic operations prevent the compiler moving other
  * loads/stores past the atomic operation load/store. However there is
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 041d8035bc..62bc2c4ea8 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -218,6 +218,7 @@ typedef struct TCGv_ptr_d *TCGv_ptr;
 typedef struct TCGv_vec_d *TCGv_vec;
 typedef TCGv_ptr TCGv_env;
 
+#ifndef EMSCRIPTEN
 #if __SIZEOF_POINTER__ == 4
 typedef TCGv_i32 TCGv_vaddr;
 #elif __SIZEOF_POINTER__ == 8
@@ -225,6 +226,9 @@ typedef TCGv_i64 TCGv_vaddr;
 #else
 # error "sizeof pointer is different from {4,8}"
 #endif /* __SIZEOF_POINTER__ */
+#else
+typedef TCGv_i64 TCGv_vaddr;
+#endif
 
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
diff --git a/meson.build b/meson.build
index c533243157..f6ed867819 100644
--- a/meson.build
+++ b/meson.build
@@ -3322,9 +3322,11 @@ foreach target : target_dirs
 
   target_kconfig = []
   foreach sym: accelerators
-    # Disallow 64-bit on 32-bit emulation and virtualization
-    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
-      continue
+    if host_arch != 'wasm32'
+      # Disallow 64-bit on 32-bit emulation and virtualization
+      if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
+        continue
+      endif
     endif
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
-- 
2.43.0


