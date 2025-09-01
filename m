Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFAACA1006
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut333-0005SU-Cz; Mon, 01 Sep 2025 07:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31R-0003Xj-NG; Mon, 01 Sep 2025 07:48:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut318-0001nq-9M; Mon, 01 Sep 2025 07:48:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-248c7f955a2so37342945ad.2; 
 Mon, 01 Sep 2025 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727283; x=1757332083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkF/SrWBRt7mpVRvpwQdPdICO84Pyhp/wixwRcKtvEU=;
 b=k8yGjVed8FRLRj4fqLIK9xLS9An/GsNSP3SXXofpSmk5qPF/9gI5XMn/9us2q+3iSh
 hEehByRmXmXXftwmb3S0+dTiZGhfq+r5yjybGMyOqKy7NxK+RSEBozuyrKI4JQf3EUs6
 1PxWY+VeXnFGPRhIEe9v4XnBuzDChFl2anexxD/gL9rBTsY0OiluDhEUCKhvoBBQ3NQ+
 sXYFXhs5NPMlYDMzYSmC/FA3nOEAWQG8Auoqe1t0sKb+R4A/a/RM0OXG2Rk1WLA5hCZf
 NUqFvPFtvNiq5m0+9Z+J1Ka5An3VhyX5WdvsojWFNcFkoP2wGC9PkgJJ7WRef0iWKlxL
 QxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727283; x=1757332083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkF/SrWBRt7mpVRvpwQdPdICO84Pyhp/wixwRcKtvEU=;
 b=H9G/t3rnM4jtAmUkwyqdUs8SPQdaEKsgpjtb4foU9fHuEdW8FPSZFXF7MxFzgn0jEs
 KTYIFHOeF7BURfg5C35pN3m2qsyyySY29IKDVRcHnH5q+yoJR4PfmaeVu4OsomnMj0Ki
 1MwABDwMJJd7R6bDL1quV165YOtA7AFwoUo7hcrAGvh2bsMxMQVOUF9DgCX0QSMIcDwk
 EVSxQ49VCsvkvMmQEZtJ2/JuQd1AFSH4/VBfk2kntQ7Uhl415TyJdnPygEeSC8RzvswN
 wfZUXPdCaJzVIObGRfTotOj0I5M7TkPWXLKs+3EeK4aX4gX8AvlD5v5hO6CjigHm412f
 RXgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVttcoZ0YKculnCcx/ZphYTBOSnyusa813kCcWHdlZtujLI9RPBYGS/nq/50IjbaKdHbCFplWnwfA==@nongnu.org,
 AJvYcCXCQXiYx9EzQL1WdMmBDTjea+iW+kfJAS+Kpm+Tt0emzuPGDsJ6DViSuso1vdlOe1oN/hwN0sw/M26JwA==@nongnu.org
X-Gm-Message-State: AOJu0YzE5CMq9Cq8JXI1s9pIq8wrZ8+sy6aQ3y/bI6lKIWQtloxDIBAo
 pNePuSkpkaqPLKAyzNdvr71Nz1X7LZmIA6BkLCeVWwA1HStL9C9oVqiCgD9YAQ==
X-Gm-Gg: ASbGnctTyXsl2GY7T2zpm8TXqLf5N1pFR3WdvhfxfVDqau4xDoSWL/fh6a89naQNDPh
 TCNBgf22zW725uedFXUPeKpnso/YkJBxNSwkXjF4W2lIPriLuyQVSViMAIRwlFLxa3qB7FKXPhK
 NYN0F6jT9Ecs883aTZx9ZlArw36XT/eb18hgHHwU3EGjWaHkVZl62mFkwECBTrlM5+kfheP3c3Y
 tYvNtREb3o0HChDgh6UikrXS3pYP6wfbQNDeVfiQ1cegz1r2QmHwQyrUInDkIRwyU+opq1Y+VH3
 roGJu1tiKOBolSnzW15HR6a7cpQKfIYqRGUYK3XmnBI+lKMJ0wgr767l1Z2iXAf5AePAc4/GaLn
 idInppHOewoIXsam4kzFJzQ==
X-Google-Smtp-Source: AGHT+IGUn25ZeeJI9WLAckX6lUgqQ7vUWG/PMX7jQQzeUj//EkzeoPWDh8SsJSFxSR46d+uLY0ukJA==
X-Received: by 2002:a17:902:f641:b0:24a:9475:3db2 with SMTP id
 d9443c01a7336-24a94754493mr90911585ad.35.1756727283063; 
 Mon, 01 Sep 2025 04:48:03 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:48:02 -0700 (PDT)
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
Subject: [PATCH v3 28/35] tcg/wasm: Implement instantiation of Wasm binary
Date: Mon,  1 Sep 2025 20:44:30 +0900
Message-ID: <c0d05186cd431515eb3f97a7c860ec5b6deac0a5.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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

instantiate_wasm is a function that instantiates a TB's Wasm binary,
importing the functions as specified by its arguments. Following the header
definition in wasm/tcg-target.c.inc, QEMU's memory is imported into the
module as "env.memory", and helper functions are imported as "helper.<idx>".

The instantiated Wasm module is imported to QEMU using Emscripten's
"addFunction" feature[1] which returns a function pointer. This allows QEMU
to call this module directly from C code via that pointer.

Since the subarray() method doesn't accept a BigInt value which is used for
the 64bit pointer value, it is converted to a Number (i53) using
bigintToI53Checked method of Emscripten. Although this conversion (64bit to
53bit) drops higher bits, the maximum memory size of the engine
implementations is currently limited to 16GiB[2] so we can assume that the
pointers are within the Number's range.

Note that since FireFox 138, WebAssembly.Module no longer accepts a
SharedArrayBuffer as input [3] as reported by Nicolas Vandeginste in my
fork[4]. This commit ensures that WebAssembly.Module() is passed a
Uint8Array created from the binary data on a SharedArrayBuffer.

[1] https://emscripten.org/docs/porting/connecting_cpp_and_javascript/Interacting-with-code.html#calling-javascript-functions-as-function-pointers-from-c
[2] https://webassembly.github.io/memory64/js-api/#limits
[3] https://bugzilla.mozilla.org/show_bug.cgi?id=1965217
[4] https://github.com/ktock/qemu-wasm/pull/25

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 1cc2e45e77..15db1f9a8a 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -23,6 +23,43 @@
 #include "tcg/tcg-ldst.h"
 #include "tcg/helper-info.h"
 #include <ffi.h>
+#include <emscripten.h>
+
+#define EM_JS_PRE(ret, name, args, body...) EM_JS(ret, name, args, body)
+
+#define DEC_PTR(p) bigintToI53Checked(p)
+#define ENC_PTR(p) BigInt(p)
+#if defined(WASM64_MEMORY64_2)
+#define ENC_WASM_TABLE_IDX(i) Number(i)
+#else
+#define ENC_WASM_TABLE_IDX(i) i
+#endif
+
+EM_JS_PRE(void*, instantiate_wasm, (void *wasm_begin,
+                                    int wasm_size,
+                                    void *import_vec_begin,
+                                    int import_vec_size),
+{
+    const memory_v = new DataView(HEAP8.buffer);
+    const wasm = HEAP8.subarray(DEC_PTR(wasm_begin),
+                                DEC_PTR(wasm_begin) + wasm_size);
+    var helper = {};
+    const entsize = TCG_TARGET_REG_BITS / 8;
+    for (var i = 0; i < import_vec_size / entsize; i++) {
+        const idx = memory_v.getBigInt64(
+            DEC_PTR(import_vec_begin) + i * entsize, true);
+        helper[i] = wasmTable.get(ENC_WASM_TABLE_IDX(idx));
+    }
+    const mod = new WebAssembly.Module(new Uint8Array(wasm));
+    const inst = new WebAssembly.Instance(mod, {
+            "env" : {
+                "memory" : wasmMemory,
+            },
+            "helper" : helper,
+    });
+
+    return ENC_PTR(addFunction(inst.exports.start, 'ii'));
+});
 
 __thread uintptr_t tci_tb_ptr;
 
-- 
2.43.0


