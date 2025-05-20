Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5406C54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMVj-0006R0-Qx; Tue, 20 May 2025 08:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUq-0003yW-EB; Tue, 20 May 2025 08:55:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUj-00015x-Me; Tue, 20 May 2025 08:55:03 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30e87549254so5713647a91.2; 
 Tue, 20 May 2025 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745694; x=1748350494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7pn51WkI2VfDBAIgVkjLNvwgbH/QMeYb332RfFRnmc=;
 b=JPjLrzDtlYr/Fwyd131Qf+KRdRdrKxoGy2EJn4qZi71S2S7CMWVZ9wxSPjhh1EXtNf
 si75N9ZfJQgGbOg6xpSaBQjW7HISrTpZq81mbqfvbGqvCeG8YxBBdXt5huR7mjuaccxj
 HURWFpir9qrS2aINbAke1PKux7T6vVZmh0M60Id+9gHefmix3jTypto+3ip1ly6tzACT
 KEYj2OOhK0/a/tYZs1ThNsIPh4XEboXLYfz2kvDwjZCbtWMlTO4o3SsvXhcQQvj+8R8B
 qDKmwL0ATKIYt/3cPsOtCgNL7i/ZGU1faavA9Zt3wcQfjGhaPyLR2T9DNOCUsEW50mAC
 LlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745694; x=1748350494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7pn51WkI2VfDBAIgVkjLNvwgbH/QMeYb332RfFRnmc=;
 b=P/WlCJfkw3DM9SXWgcZvoh6e+H5ub0+vEoFb6GRbvsIVcDU7u4NXsB/i1RYRVBl1Yt
 kWu210PAJ7Pd/o13wUD5qSwd6snupOF1UF367rJPe8DL9WoOfFqzMBkE9Yo9fDOEcIse
 ZKrmnqDxe5IkvWGLvgaVWXIQ7Roa+T7fW8NniXLFPjU3w9LNIsSv+VzJYkoR8RenECAN
 t9BC9NgGBhGrdRw4MyFfTUbeIIYBAYVWXm+aJLQ5jpXpBbMHPqciY1rd8aV/1Uw5y/yG
 bmBQoIuabFy1obskdbTimSsM69tuB/hyeEKzb9/Q3TZ3dOiqtngM7J05pa5jeGyIY5Cu
 r3cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR0Kq2fHf1qLL6ew6rdWPvUkdsCKGVXLicvUdoHS7gm2hCdpFh7U1KEw/7uaCvIbfr+hfuVnJ8vQ==@nongnu.org,
 AJvYcCXTkGnhcIfQIYQ8olbYjH4l6vNVG0xq1E4Klc2rlf/JuDfYXlNWxOakypklwaUmXqP67vWfC3Mvm3Zxyg==@nongnu.org
X-Gm-Message-State: AOJu0Yyzp3b2VjSyHbo4zkTdyFMaoS/HkFn2XComtNllnel5bRUDr6KL
 m0BKU4mqRvLlyjrmxTy0b1xO+c95m7OO5XdL1vsSCsoRa5UcwbO4Mvf5fZm5T2F8
X-Gm-Gg: ASbGncs1lpkHWjxJ9XDJvtL8m4ztux8vnsa06lhIJSd9J4CYExvk3Pq+oG77bUVFyJ+
 hGOS8wd9DFi2ZJo88AblK9RmA26ElP90/d0Qi2Gz+HyzyIb2YSx4rsSa7T1MAT1sHtH/nXQAcIC
 Jr/odpKg8vCRNnDMHQ8cz/yVZJxcJGBiDddS7VX6ZL3ISSZwDmDYiXSKfHVIL7osArVrVop4rvX
 ajfGzAYVMQZrTc552frESkexQDvia5EOdSNk6O4EvQIPU5BbqlUMmrGOyNBB2LKgi81ZeCvL7pX
 /X8bwp94UwqNQpgHlbFUBxsxcmixL0Du86mkF+f3P2jiSMp7SELohpSstq+gaw==
X-Google-Smtp-Source: AGHT+IGajpd6KWApJBhXUBZOQ39gUNizGUA6mw1/uq8/j3XxCq6FiAhKcVdhKBCbeeWVn1V+o+KQDA==
X-Received: by 2002:a17:90b:3f4c:b0:2ee:5958:828 with SMTP id
 98e67ed59e1d1-30e7d522155mr29183315a91.9.1747745693818; 
 Tue, 20 May 2025 05:54:53 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:53 -0700 (PDT)
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
Subject: [PATCH 28/33] tcg/wasm32: Implement instantiation of Wasm binary
Date: Tue, 20 May 2025 21:51:30 +0900
Message-ID: <2433bd9fe6eed2f93f511195cedbfde0fc4a89a4.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1032.google.com
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

instantiate_wasm is a function that instantiates a TB's Wasm binary,
importing the functions as specified by its arguments. Following the header
definition in wasm32/tcg-target.c.inc, QEMU's memory is imported into the
module as "env.buffer", and helper functions are imported as
"helper.<id>". The instantiated Wasm module is imported to QEMU using
Emscripten's "addFunction" feature[1] which returns a function pointer. This
allows QEMU to call this module directly from C code via that pointer.

Note Since FireFox 138, WebAssembly.Module no longer accepts a
SharedArrayBuffer as input [2] as reported by Nicolas Vandeginste in my
downstream fork[3]. This commit ensures that WebAssembly.Module() is passed
a Uint8Array created from the binary data on a SharedArrayBuffer.

[1] https://emscripten.org/docs/porting/connecting_cpp_and_javascript/Interacting-with-code.html#calling-javascript-functions-as-function-pointers-from-c
[2] https://bugzilla.mozilla.org/show_bug.cgi?id=1965217
[3] https://github.com/ktock/qemu-wasm/pull/25

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tcg/wasm32.c b/tcg/wasm32.c
index b238ccf6d6..f2269c0a22 100644
--- a/tcg/wasm32.c
+++ b/tcg/wasm32.c
@@ -25,6 +25,7 @@
 #include "disas/dis-asm.h"
 #include "tcg-has.h"
 #include <ffi.h>
+#include <emscripten.h>
 
 
 #define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
@@ -44,6 +45,29 @@
 
 __thread uintptr_t tci_tb_ptr;
 
+EM_JS(int, instantiate_wasm, (int wasm_begin,
+                              int wasm_size,
+                              int import_vec_begin,
+                              int import_vec_size),
+{
+    const memory_v = new DataView(HEAP8.buffer);
+    const wasm = HEAP8.subarray(wasm_begin, wasm_begin + wasm_size);
+    var helper = {};
+    for (var i = 0; i < import_vec_size / 4; i++) {
+        helper[i] = wasmTable.get(
+            memory_v.getInt32(import_vec_begin + i * 4, true));
+    }
+    const mod = new WebAssembly.Module(new Uint8Array(wasm));
+    const inst = new WebAssembly.Instance(mod, {
+            "env" : {
+                "buffer" : wasmMemory,
+            },
+            "helper" : helper,
+    });
+
+    return addFunction(inst.exports.start, 'ii');
+});
+
 static void tci_write_reg64(tcg_target_ulong *regs, uint32_t high_index,
                             uint32_t low_index, uint64_t value)
 {
-- 
2.43.0


