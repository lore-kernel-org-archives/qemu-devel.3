Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE70C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oCP-0004Pp-V1; Mon, 07 Apr 2025 11:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlt-00029I-R0; Mon, 07 Apr 2025 10:48:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlr-0001hI-TF; Mon, 07 Apr 2025 10:48:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso5252829b3a.2; 
 Mon, 07 Apr 2025 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037297; x=1744642097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fW8XIKfaYZtOTkzwtpemEa+AlpQFv1wOG7n/PEjrSqI=;
 b=lytEpGnG3BxuFIVFEQqRhWAWKMpW/MpmtYXlWSfpbCegJW5WRpwtHOj8jzmzBnObf+
 Yknd+iYjVDhqSDn0+RHjqZPioIBJOW+gvjabobxb1RQ8XCJDXvKYue9mwz7GVmCbWh8L
 uTP9bMrMyC22GIAK3mlMGOTuLJhv68nOp0S7hJ0Wn+zLsn6AgrLGIUl0b22Nxe9FfnsX
 bvy8gB7pI7Er4jKFdVlAJefIsn7UbLj49SeS/UgGv0HEZOD5Bg9vs4SUZa4sRGXjDiFy
 OA+4A0cFCuHQv/YjNTdRy1QSmuy7aaMexXx31EGseROiL8Al+rpWN/FOaWg1o/Sr0DU/
 SEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037297; x=1744642097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fW8XIKfaYZtOTkzwtpemEa+AlpQFv1wOG7n/PEjrSqI=;
 b=cOc6iWEJjCmvFrZwN/8dn+lUL58chK2Ni3rlKDhMy74DExOmomJCWYa5nK4wtsNnep
 cRdutHL7MlEblQNdJH0WS5pggf4f/TkYVQkYvtUnMAknUvJQQnTcDIm07fiv1smA6Ext
 g6AKspx+mhCBgC+ScbyIgLnDVI8XKTou4NY3dbecYmLAv6vTVvt3gCqCLClGXG8kf2aZ
 ztI9jMMrKoXZ+ubkqYEyXdC70RLyFf+tUUdvgEWxiY2kC6hco1YqiJ9blcETCYfPF+OM
 K7kLhXHMK5khjxlgIMPuFKuYaGxqTMdLOkrsrwyFGOoJ4tTbAQxxTglQQsgCNxcjy1Zh
 5eig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwKM9DDxBa8/PAMvd0W5V9x+/rKf15a991cAj53fGSEEIWc2vTNet7Nr1FJ/PMm3f2IFrR5UprzX8XaA==@nongnu.org,
 AJvYcCUwrWqx3EZAvJUdu2pm37mTN9nJ4OP6J2doEBatk8z9oZMISW6AocCBM8hOQ/CiZpuM7pBRK2V7/I4Hfw==@nongnu.org,
 AJvYcCWyCKjtLZMWwxRtb84H8IkIcFeuNVrW/N1+76RrT+0BoDQyrSN5Q34c/DV7izsNxthX915GsDK2DQ==@nongnu.org
X-Gm-Message-State: AOJu0YwE5DHk7JCwTBonsfCKJ0dj8rpWZkgJUv1sUAn+aWFD/AZP0ELT
 hGnRHKZo28JwcmKm4oZ6xqc6BktlZjOSILGr3J0FOp0747FTPiPbvy+kc6bO
X-Gm-Gg: ASbGnctVOAeeUdnsD1FtXiHm5VKZVcvMtz6FpA47IC0+77iR2tF8nQjJsyRrOSWonAk
 QN0fMgX/zTvDgatXpIhEYHgPVp/DcxaR71QYmxzAXj4aiO0TTYK0DJBzzf2ErjuYzQBDPRgaiKC
 44JewnJ+ZuSal1u/cF2PcCo17Oxv4LfGDP5jzqMrmdWSTeL3WCcpAgQseYxdEJVRlc4Y4SlWE/a
 vjc02t1xNbswpJufwDzp+RjqzV5+1aGPEa0o3h1gQkZhLseYHcI8GqVRLXjIPRuAUNRNFI5Glkm
 myUIKz+VhNOzWM2nahHmWQi8bGc0yZt7fNOTdbDwL+m8jRexl4s7pWf0Cri/pA==
X-Google-Smtp-Source: AGHT+IEf/31V+SpzPJuGAwERtSZYT3VmroA5Y689cGqjAR92zXSAv+cv0eNY3KphtMS3srkYGNEyog==
X-Received: by 2002:a05:6a00:3922:b0:736:fff2:99b with SMTP id
 d2e1a72fcca58-73b6b8f7d08mr11175167b3a.23.1744037296768; 
 Mon, 07 Apr 2025 07:48:16 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:48:16 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 06/10] include/exec: Allow using 64bit guest addresses on
 emscripten
Date: Mon,  7 Apr 2025 23:45:57 +0900
Message-Id: <04ab0a8c2ab61c47530f77b149ad29123a0ee382.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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
different pointer widths between the host and guest (e.g., commits
a70af12addd9060fdf8f3dbd42b42e3072c3914f and
bf455ec50b6fea15b4d2493059365bf94c706273) when compiling with
Emscripten. While this serves as a temporary workaround, a long-term
solution could involve adopting Wasm's 64-bit memory model once it gains
broader support, as it is currently not widely adopted (e.g., unsupported by
Safari and libffi).

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 accel/tcg/cputlb.c        |  8 ++++----
 include/exec/tlb-common.h | 14 ++++++++++----
 include/exec/vaddr.h      | 11 +++++++++++
 include/qemu/atomic.h     |  4 ++++
 meson.build               |  8 +++++---
 5 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876..8f8f5c19c4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -104,13 +104,13 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
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
diff --git a/meson.build b/meson.build
index bcf1e33ddf..343408636b 100644
--- a/meson.build
+++ b/meson.build
@@ -3304,9 +3304,11 @@ foreach target : target_dirs
 
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
2.25.1


