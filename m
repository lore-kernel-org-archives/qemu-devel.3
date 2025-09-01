Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B7CCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut33q-0006vE-VA; Mon, 01 Sep 2025 07:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31p-00041f-L5; Mon, 01 Sep 2025 07:48:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31h-0001ve-AW; Mon, 01 Sep 2025 07:48:53 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b47175d02dcso3634641a12.3; 
 Mon, 01 Sep 2025 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727312; x=1757332112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeqqTWC+7HoIg9vTIlz7vtwEiWiWvUi6bVMstauLERc=;
 b=MpQZ967FKmaLJeY84tNvQANt/DA+3i+IH884q+LtnCWHKpIJf3Z5dJzCxG75HHAXjd
 wjQPG1KVp66pst8IpJe7DPd9xWwvefB0rcBfLvJ255+8ZdNHFvRvcly1hJLCbumVyZxA
 Pxb9Bzdxre4RFU9Hntcx4A21P4DV3e/v2TSfcUxPxddJhJk7lrv14ENs5xxh6gTcpZ7a
 oivUvD7x/cdXljVRwP+3XQTK5e6HFJQnaJ9H7utqAEPTGhqxlIGMPwE3G5Y3VjcE6g3o
 ACbobJpbpEbabDKrN4YerHRpwzBtHL5EMzoH1poevh2cksWsXS2oJtY9DhDZn7Lk0suM
 hD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727312; x=1757332112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeqqTWC+7HoIg9vTIlz7vtwEiWiWvUi6bVMstauLERc=;
 b=JettOwc2VuWZjrYNJFfRXY8eGozC+DDN8JjpWMGwZhRGKSbqDCzLyA/jpk/Jiz428w
 i9EWrZ3Hc8k9kFKralMnS5Vn9CQUITc12qvgsONEg5YTmVafNj+JCTbd4NenRmwHyFlh
 F6futnU9jAh/BrJuAE4KdMpQJ6gLo5SYaoAmyNjrl0k/HqCqPtS3aOcDhjGD091hTPwS
 1G75JBxIj8YPb3q15F36oL/SvZys5RiUtUAPw9Ve92owp2/nCUXRsDmM4R0cH11qB9tZ
 PQEE8H//83CNLTkPaijEuad4QJHqUUj9waaSLHvA0vwf2PWm+ZprnHVTtlIqfDZ+y1VU
 /91g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMVOXVPPGm5HgkTUqtMY9wbt+PvYZNhxOvyc4iefwqM14M9Wc627pJ38xX9TBRX33GFQvdtodRc1rpng==@nongnu.org,
 AJvYcCXOPpXHIfw34+nw+drxd6gddNQxs+TimYMlMJa6xBSkt7rwNTnpjDEhvjPS+8n5UNptKruRXWXamw==@nongnu.org
X-Gm-Message-State: AOJu0YzKwMkRRITIX8J35ymZ5gWRIaxqFEJnnsFVW2w00E+lPG5pEITI
 IX3iIoG4RR/F7TDDoDm4HCe9ILhijpC3dP/c5I7LpT4J5RyV4RT0UgP6Q9bffQ==
X-Gm-Gg: ASbGncuPh1fJMTUif4NKqdOSg1HSZE0VzxSZWKu+Vb5BBBkz17XC3NdvFxhbNiQ5jwj
 KKED9kmIJi++IpO1rH2szGZ9X1cQ02AU+CTglB/KzfWTT1b9no6For8lwKn8qGrVKOB4Hdkp9ws
 kkZpL/yjNEOQFJ0G06/ZkrHqAxj5M8s1pmkkrBrpIHNOJt4Q0njJyXXDvwvZyJKpisJUH/tn1Ee
 rZYtLtrnzMQ05DgpXvSH6lE+2yF86WT/1AvIuZfZ1HfArPmGfZE6VHga4d4yaU069UhLbEkjFjF
 MjZgrgqKR6h3DWF8YHwsc3ud7XF3knq5Tf4+I5c1Pk+kNrl6jxItPyK9/HWbmLN7R+AClKH4lr4
 NW8Y3chd/TNFVJm2DxdDenQ==
X-Google-Smtp-Source: AGHT+IE2P0y3EXRBcz5+VxcwlR2IflV3hZpTShg6qxom2+2ldzNKmBy6OUihtfnE2AV1TxSTNXnCpw==
X-Received: by 2002:a17:903:166e:b0:248:a054:e1cc with SMTP id
 d9443c01a7336-249448de11cmr114129205ad.18.1756727312243; 
 Mon, 01 Sep 2025 04:48:32 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:48:31 -0700 (PDT)
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
Subject: [PATCH v3 33/35] meson.build: enable to build Wasm backend
Date: Mon,  1 Sep 2025 20:44:35 +0900
Message-ID: <e7333cfd991ce89b4003417eba0c8bdec927fa0b.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x529.google.com
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


