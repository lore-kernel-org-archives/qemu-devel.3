Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7413DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwKE-00014b-2p; Tue, 26 Aug 2025 12:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJk-0007aH-Vm; Tue, 26 Aug 2025 12:14:41 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJb-0008HB-J3; Tue, 26 Aug 2025 12:14:40 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3258cdb71a4so1949077a91.2; 
 Tue, 26 Aug 2025 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224862; x=1756829662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeqqTWC+7HoIg9vTIlz7vtwEiWiWvUi6bVMstauLERc=;
 b=l0w9p7keCj30ez5E0ZN5u15pV7O+SiqnXInNYebTDjcHkOcKfU+bpoJ+MnokbdULP4
 yqePwaFT3m3UqlBx+6uq3IBOaqKJAib9WTjajBKidQizqQVpUuiqBiFPugEOZe6w930x
 RNOWPFms04lMBiecDPtcaMOAvjVs14hI40tNybIx0a8J+4fEYVPYJ0jG9n+smMXPMQYs
 sXuY1fZ3KTwDAtbZ2PPYHt/xohl0RHmfNwlcQ2e+mjHNXEmaRpy6gL8ZsDrPjOgqUw1C
 k4q7TSkKK30u6pAtepHMrtxjRSP7/IHRLSaaKPUvv8Gh/5qkaVFmAEbtnnKSKLScniIK
 1AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224862; x=1756829662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeqqTWC+7HoIg9vTIlz7vtwEiWiWvUi6bVMstauLERc=;
 b=UaCq9Q1LID9gdpS0Q1khL7qHB6cBU5QTA/kJO+nhAw6yvw877C/BM5PkxgeaKZSza8
 Lhql2nMHCJYX53XmlK2pkeD+VaEK09yZ9+fSn1rmyEzAlKohKVd1qV5BstgaEELyzSU6
 W5zKThqOOgqRauK+P+ILeG6H8qm3sICswUUGR2eM0m+Ka5YzBrPHqCcmXIBSmjekdq4c
 juW3EsVkpGac+LaaQ4Wc6VwunzgGG78OAcqiSe7/g+vnpYD5Ukcpm0uEuYqRgeSijdrf
 ILJegZA0nC7U42CikNpoK8i+U941+z5MXyHi1bjLptNggk+8yh+mJeoIwbS19feggf/u
 BNIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRwUftrVuGpqmvf08Avog5voCtAjMwKHDlpixY9kaomPl+kJw40JFH+ZsEn82wiU1yJ//waFMwpQ==@nongnu.org,
 AJvYcCXZPt+UyGQnbLwJe1jQB5ov9eWxgLHlTfhr3LUuf7REEZKqL/rCGZ9d/eU4Zez9K05SBJJ7qtsxT7gdAw==@nongnu.org
X-Gm-Message-State: AOJu0YzJ/AjwjVJtCjFzV6KlcBmQWynLy8HotgffvzoKJb8eNx1s6kmk
 DdSdNKEYKDYkkwYSYoNHxRxlltRfOYQCszKOhP34QV1V87MZL+/EXqpxW4BjCQ==
X-Gm-Gg: ASbGnctv/5C5pi7jZtSc13EAChz9uik/5nAUcGB2J/mhpExdhFFyq0atv5EJEc6oisG
 i50GRU18YQZRr0nAXC6/uf1IFFSmHIm6TP51pBXj+uR2yiEVkg2DwrWY5tqpp6SHs98frIfR7K9
 FxHUCsS0AX18GP1W7D825Hsev/9RlOoKwQkiw4cCdwT16jfQfJsWon00Hh2ajCKEj1uZDl6f5/U
 ptDarpAMFDB1hMKFU4C07Cega6wCAv24QakDcrzVw+LZLeTBBNh0uPxUrSQqByIIh2yu3wpDUr9
 dCFE2unEc/Hg242TMcZclt1v9GcFrs8jCxNokmH8RbolmEMcUl2yNqNojaIXXbA4jHw0C0VFjP1
 Dkzv+q4PXeKFT50315vSPX0r6MRycFNFf
X-Google-Smtp-Source: AGHT+IE6/B2iwBLzlIlMCwk5+dyYLZnHcLbSr3asQMWO55eMn1Wq2KkKn7xgXDK+z5gHm2rYfpgcHw==
X-Received: by 2002:a17:90b:1b4c:b0:324:ece9:6afa with SMTP id
 98e67ed59e1d1-32515e2bd02mr19862361a91.4.1756224861825; 
 Tue, 26 Aug 2025 09:14:21 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:14:21 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 33/35] meson.build: enable to build Wasm backend
Date: Wed, 27 Aug 2025 01:10:38 +0900
Message-ID: <d12537fb63f977a45682f7a52841a0d7feb3e902.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Enable to use tcg/wasm as the TCG backend for the WebAssembly (wasm64)
build.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 include/accel/tcg/getpc.h |  2 +-
 include/tcg/helper-info.h |  4 ++--
 include/tcg/tcg.h         |  2 +-
 meson.build               |  6 ++++--
 tcg/meson.build           |  5 +++++
 tcg/region.c              | 10 +++++-----
 tcg/tcg.c                 | 14 +++++++-------
 7 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
index 0fc08addcf..3901655715 100644
--- a/include/accel/tcg/getpc.h
+++ b/include/accel/tcg/getpc.h
@@ -9,7 +9,7 @@
 #define ACCEL_TCG_GETPC_H
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 extern __thread uintptr_t tci_tb_ptr;
 # define GETPC() tci_tb_ptr
 #else
diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 909fe73afa..9b4e8832a8 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -9,7 +9,7 @@
 #ifndef TCG_HELPER_INFO_H
 #define TCG_HELPER_INFO_H
 
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 #include <ffi.h>
 #endif
 #include "tcg-target-reg-bits.h"
@@ -48,7 +48,7 @@ struct TCGHelperInfo {
     const char *name;
 
     /* Used with g_once_init_enter. */
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
     ffi_cif *cif;
 #else
     uintptr_t init;
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a6d9aa50d4..b91818d982 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -963,7 +963,7 @@ static inline size_t tcg_current_code_size(TCGContext *s)
 #define TB_EXIT_IDXMAX    1
 #define TB_EXIT_REQUESTED 3
 
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *tb_ptr);
 #else
 typedef uintptr_t tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
diff --git a/meson.build b/meson.build
index 5b048ea70f..42b9004a20 100644
--- a/meson.build
+++ b/meson.build
@@ -920,9 +920,9 @@ if have_tcg
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
-  elif host_arch == 'wasm32' or host_arch == 'wasm64'
+  elif host_arch == 'wasm32'
     if not get_option('tcg_interpreter')
-      error('WebAssembly host requires --enable-tcg-interpreter')
+      error('wasm32 host requires --enable-tcg-interpreter')
     endif
   elif get_option('tcg_interpreter')
     warning('Use of the TCG interpreter is not recommended on this host')
@@ -938,6 +938,8 @@ if have_tcg
     tcg_arch = 'i386'
   elif host_arch == 'ppc64'
     tcg_arch = 'ppc'
+  elif host_arch == 'wasm64'
+    tcg_arch = 'wasm'
   endif
   add_project_arguments('-iquote', meson.current_source_dir() / 'tcg' / tcg_arch,
                         language: all_languages)
diff --git a/tcg/meson.build b/tcg/meson.build
index 706a6eb260..1563f4fd30 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -20,6 +20,11 @@ if get_option('tcg_interpreter')
                       method: 'pkg-config')
   tcg_ss.add(libffi)
   tcg_ss.add(files('tci.c'))
+elif host_os == 'emscripten'
+  libffi = dependency('libffi', version: '>=3.0', required: true,
+                      method: 'pkg-config')
+  specific_ss.add(libffi)
+  specific_ss.add(files('wasm.c'))
 endif
 
 tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
diff --git a/tcg/region.c b/tcg/region.c
index 7ea0b37a84..68cb6f18b7 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -94,7 +94,7 @@ bool in_code_gen_buffer(const void *p)
     return (size_t)(p - region.start_aligned) <= region.total_size;
 }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
 static int host_prot_read_exec(void)
 {
 #if defined(CONFIG_LINUX) && defined(HOST_AARCH64) && defined(PROT_BTI)
@@ -569,7 +569,7 @@ static int alloc_code_gen_buffer_anon(size_t size, int prot,
     return prot;
 }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
 #ifdef CONFIG_POSIX
 #include "qemu/memfd.h"
 
@@ -667,11 +667,11 @@ static int alloc_code_gen_buffer_splitwx_vmremap(size_t size, Error **errp)
     return PROT_READ | PROT_WRITE;
 }
 #endif /* CONFIG_DARWIN */
-#endif /* CONFIG_TCG_INTERPRETER */
+#endif /* !CONFIG_TCG_INTERPRETER && !EMSCRIPTEN */
 
 static int alloc_code_gen_buffer_splitwx(size_t size, Error **errp)
 {
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
 # ifdef CONFIG_DARWIN
     return alloc_code_gen_buffer_splitwx_vmremap(size, errp);
 # endif
@@ -813,7 +813,7 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
      * Work with the page protections set up with the initial mapping.
      */
     need_prot = PROT_READ | PROT_WRITE;
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     if (tcg_splitwx_diff == 0) {
         need_prot |= host_prot_read_exec();
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7d3e7f8cb1..bd8f8e565f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -256,7 +256,7 @@ TCGv_env tcg_env;
 const void *tcg_code_gen_epilogue;
 uintptr_t tcg_splitwx_diff;
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
 tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
@@ -1443,7 +1443,7 @@ static TCGHelperInfo info_helper_st128_mmu = {
               | dh_typemask(ptr, 5)  /* uintptr_t ra */
 };
 
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 static ffi_type *typecode_to_ffi(int argmask)
 {
     /*
@@ -1520,7 +1520,7 @@ static ffi_cif *init_ffi_layout(TCGHelperInfo *info)
 #else
 #define HELPER_INFO_INIT(I)      (&(I)->init)
 #define HELPER_INFO_INIT_VAL(I)  1
-#endif /* CONFIG_TCG_INTERPRETER */
+#endif /* CONFIG_TCG_INTERPRETER || EMSCRIPTEN */
 
 static inline bool arg_slot_reg_p(unsigned arg_slot)
 {
@@ -1897,7 +1897,7 @@ void tcg_prologue_init(void)
     s->code_buf = s->code_gen_ptr;
     s->data_gen_ptr = NULL;
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
 #endif
 
@@ -1916,7 +1916,7 @@ void tcg_prologue_init(void)
     prologue_size = tcg_current_code_size(s);
     perf_report_prologue(s->code_gen_ptr, prologue_size);
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     flush_idcache_range((uintptr_t)tcg_splitwx_to_rx(s->code_buf),
                         (uintptr_t)s->code_buf, prologue_size);
 #endif
@@ -1953,7 +1953,7 @@ void tcg_prologue_init(void)
         }
     }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     /*
      * Assert that goto_ptr is implemented completely, setting an epilogue.
      * For tci, we use NULL as the signal to return from the interpreter,
@@ -7055,7 +7055,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         return i;
     }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     /* flush instruction cache */
     flush_idcache_range((uintptr_t)tcg_splitwx_to_rx(s->code_buf),
                         (uintptr_t)s->code_buf,
-- 
2.43.0


