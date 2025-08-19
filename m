Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4A5CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzZ-00056Q-4e; Tue, 19 Aug 2025 14:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzV-000536-5i; Tue, 19 Aug 2025 14:23:26 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzS-0003p2-Tu; Tue, 19 Aug 2025 14:23:24 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b47175d02dcso4698660a12.3; 
 Tue, 19 Aug 2025 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627800; x=1756232600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEe0HN7Xf3vBBHUAfg1FxQ2bKTW63w/E0lVNLcPFW3I=;
 b=aQ7yijkDQhxfsHVYXh58q9h5GF0nOEY6M42zA/xaSdHJT5/jn0QceImK22bHeLmggD
 gi0yUCD4yfUCRtzMF+oc1zDpe85MQWIWfC2ogD4+HPCqXBKeI3ospfjZqCdAqdY7+Xir
 IqkKNQRWRvIcT+SKBQ047hvmPo7BIFMwufu8o2UbwQin67xcBv1yTWDcV9NB3/7d9/lF
 6gYyn3T4iJs/xGDMQda57vpBQc6pwcWTyTU9iJuOpJNj0VCSO9LINQlSna5uiKHATVkM
 BPD7QokpjYFbHddIUYqAmXzcKQ+zgxw+pWBN2VLMETTqrbtOTnfru4zXaQMBAxrKDtWC
 PEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627800; x=1756232600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEe0HN7Xf3vBBHUAfg1FxQ2bKTW63w/E0lVNLcPFW3I=;
 b=n2mLwlASlcFvhAsyrMVuJSiVA3cK6JEpVCtcI6d3fpKtp2flir5tDCtFZoWZIEhd0Q
 82CU5g7lXswQ0TM5jhzShhlhYT50hZXyk02tm/Z9Onuf007q2zI7kNf1PrfBHcylwBab
 YXntHMCTKpSJUteHbQygY6dLlobqbaXR36sL5uh25e5Nu8Wj0zh2bi8az+ekOeoUi1fU
 HfuBedin0zteFHBuKAUDRMxQhd9/tZP7VHGEM2xQulZ/ehemqXQPTa/ZkmV/IPzKTN6a
 vggbFtfqy2J7sdUKuJG17wjIN+5YWSt/Wd9GgMtThQ9MIq5Cykq6lvqad/ED6AZx0DXI
 WeIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUT8FleC6PbltIgr36M3loyz7FJYMCq1jIAZxK/JQeAWBazhG/Yn8t0G0WvVtuh71n+FQkoJHHnQ==@nongnu.org,
 AJvYcCWO7Fqv4Am3umO5CL6Z9zSfTJoIPHFwsgwMa9HKZtoGLQa0rLstmABHgBud9+12d9LwfusjDzFYm4skRA==@nongnu.org
X-Gm-Message-State: AOJu0YwWP3avh7dH6jxIEkdDbiKthZI+LyIy/2uXYy5RS5yRxdLzAplT
 0o9Ao3qW38PDdmzyeXzs3N+jPUxIL2B8njbqmgq9kxTFKRWZ0sSY0xwiIkgQn+Yu
X-Gm-Gg: ASbGncu+aDWJugYwYX2C1xEtWEsK5bcO0n139LlHKG3D7M7dLpXQx4AulbLSKsk9OJJ
 +aHb8OTpYS7A1wwBf/hEuyMo9yHWK0KxAfF4Xz+k/wV9t4xFmXKAVZu1o+Eifv13iO0OxcoYyBv
 +aSh0gGMS93axM1TFtIlui6kHQG5yu0onjeM2Cn2+0h8XsemGDJ4qNkGDTt1kYYi0Je8iOFVWUh
 3DrkUdBP5aztOqjKSw6Qsby3q9FfUXJBuXd/OlD8n0BRiICxOEGxdM9V3dcPk/nObL64bXK+cur
 CkWPiCMs03dsWhhZljat6M/Pth7nxWNuuTfL5+j51+Vmo44Zz5XXE4TGPK5jHoKjkM6ZTO5YfWo
 5QzWXg2JgDjBWbfW3WTYbgbie6RA+rj4C
X-Google-Smtp-Source: AGHT+IHtNnKipR3Fypo/eDFtdgSl7BprlRg5emqbe3ysrJHUAV2vD8MkoDbuZM3v7oL0TVitf5GA4A==
X-Received: by 2002:a17:903:4b2b:b0:244:5311:8ed4 with SMTP id
 d9443c01a7336-245e0504d55mr41833065ad.55.1755627799997; 
 Tue, 19 Aug 2025 11:23:19 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:19 -0700 (PDT)
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
Subject: [PATCH 08/35] meson: Enable to build wasm backend
Date: Wed, 20 Aug 2025 03:21:37 +0900
Message-ID: <3bfbeb81abed474af3b984911b3185e072339efb.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
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
 meson.build               |  4 +++-
 tcg/meson.build           |  5 +++++
 tcg/region.c              | 10 +++++-----
 tcg/tcg.c                 | 16 ++++++++--------
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
index 291fe3f0d0..263a72df61 100644
--- a/meson.build
+++ b/meson.build
@@ -916,7 +916,7 @@ if have_tcg
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
-  elif host_arch == 'wasm32' or host_arch == 'wasm64'
+  elif host_arch == 'wasm32'
     if not get_option('tcg_interpreter')
       error('WebAssembly host requires --enable-tcg-interpreter')
     endif
@@ -934,6 +934,8 @@ if have_tcg
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
index afac55a203..e6f8f9db5c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -254,7 +254,7 @@ TCGv_env tcg_env;
 const void *tcg_code_gen_epilogue;
 uintptr_t tcg_splitwx_diff;
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
 tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
@@ -1118,7 +1118,7 @@ typedef struct TCGOutOpSubtract {
 
 #include "tcg-target.c.inc"
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
 /* Validate CPUTLBDescFast placement. */
 QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                         sizeof(CPUNegativeOffsetState))
@@ -1440,7 +1440,7 @@ static TCGHelperInfo info_helper_st128_mmu = {
               | dh_typemask(ptr, 5)  /* uintptr_t ra */
 };
 
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(EMSCRIPTEN)
 static ffi_type *typecode_to_ffi(int argmask)
 {
     /*
@@ -1517,7 +1517,7 @@ static ffi_cif *init_ffi_layout(TCGHelperInfo *info)
 #else
 #define HELPER_INFO_INIT(I)      (&(I)->init)
 #define HELPER_INFO_INIT_VAL(I)  1
-#endif /* CONFIG_TCG_INTERPRETER */
+#endif /* CONFIG_TCG_INTERPRETER || EMSCRIPTEN */
 
 static inline bool arg_slot_reg_p(unsigned arg_slot)
 {
@@ -1894,7 +1894,7 @@ void tcg_prologue_init(void)
     s->code_buf = s->code_gen_ptr;
     s->data_gen_ptr = NULL;
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
 #endif
 
@@ -1913,7 +1913,7 @@ void tcg_prologue_init(void)
     prologue_size = tcg_current_code_size(s);
     perf_report_prologue(s->code_gen_ptr, prologue_size);
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     flush_idcache_range((uintptr_t)tcg_splitwx_to_rx(s->code_buf),
                         (uintptr_t)s->code_buf, prologue_size);
 #endif
@@ -1950,7 +1950,7 @@ void tcg_prologue_init(void)
         }
     }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     /*
      * Assert that goto_ptr is implemented completely, setting an epilogue.
      * For tci, we use NULL as the signal to return from the interpreter,
@@ -7048,7 +7048,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         return -2;
     }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(EMSCRIPTEN)
     /* flush instruction cache */
     flush_idcache_range((uintptr_t)tcg_splitwx_to_rx(s->code_buf),
                         (uintptr_t)s->code_buf,
-- 
2.43.0


