Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79263CA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwJz-0000Og-5q; Tue, 26 Aug 2025 12:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJF-0006ie-PS; Tue, 26 Aug 2025 12:14:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJ7-0008Bn-Qq; Tue, 26 Aug 2025 12:14:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-24458272c00so67996305ad.3; 
 Tue, 26 Aug 2025 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224833; x=1756829633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkF/SrWBRt7mpVRvpwQdPdICO84Pyhp/wixwRcKtvEU=;
 b=koVE/+Xe6nKc+jv6vnl9iZspQUDPrl+iRxEPqHXXEnqtZcRbYmOCqU1f1BW6wY8ppd
 VdzQYRNf7GgVcp5miVlqL+N3jBJprk4xbTtrUus6fg0BGViKN3FHI5S2fQ875fNoNYU5
 fFP1lXQQ8v2XMuh+lrd26jka9DeRMQC2t0iM9nq0wSXH/K+wT5eNQMYvvxjbTdScbzhW
 7cJe8/b3GeEr+ClUNDpYXmTPFhyjyh1u9sBi5g6n2mO81UR9tqZgMb5/lRbD9pYwErig
 XQFz79bqNlAbXD/x9SRP69PaZU70CzCDqknPXu1m58si8Av+8N6VTwF7/1XJ2/jCMuYN
 rM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224833; x=1756829633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkF/SrWBRt7mpVRvpwQdPdICO84Pyhp/wixwRcKtvEU=;
 b=fSHj3K2njpuTSr1YvwAEST75DLPo7NnMXOGNXSSS2fAqaNDWcGqcm1h5S67Vqmc6Xj
 tUzuAblVNstWXqUnCmGqA0qwdBTS73qCdkDES1cDw6auE1f9BrTEcvA/8Qx50Ndyw7sL
 1w/Zo365XrAOqVzWawIRiNQl4rlbQAZrLBWffobLVIKx53sT1L4C3mhEJ7lBU641251z
 KiWnJ7HlPtkXCL4hV3N9jc7KSH64NM44m7C+/UHua00vDLXFgVMWKorXK9HVN7svijj5
 9SFOp6ZtrqOBygovhVPyqUAb+z7Yql+JaIHtIEfgWsF3FEXTH71NihzuZcRLB/ALz39D
 d7BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI4yRhqWyhjVobi4Oy3eAhjaIApkLQ2fGdZlTl3gfR2c4Q8uwfIZYie4IKDEdVDNXDfo4H+PzDfQ==@nongnu.org,
 AJvYcCV2pwY1Mp/wCf6dHEfKP8KAfBVuj4Dkej68aNmalUZsYJNcNrbc+92WsZczcnAeVLSrCPmXSMNpKt+WMw==@nongnu.org
X-Gm-Message-State: AOJu0Yw/4hUNEc5Pe1sLDAZYI+edxegypeEvouFmkRL3tObbyBtuUpeo
 paBHOvk/GH+gkgvw9O8XOItVJ9AEsAdYnq9ImhylxQalza+qvbOhQk5Ok7T18w==
X-Gm-Gg: ASbGnctOvFegxKg6s9IcvtHW0V2J0Pd1f1TadRt2fY1u28/rILYbqFiYido6Nw4U8wF
 F4m6TYM+/rsVXcWZ/kUC4hxjCAIzV6+5DXPYU0W0E2jSKduirEE8lKD2iTUWulqtkqHDdc1RtZc
 96xpW+aqL+hAvpBn3cBHvs5KODyeXFfai2bp1RtrmE/yy0kLlfDwbj4NoPrSqTOuzt4wId7SZ7h
 cNTXPeUbSYP1n1bEj5EmKWa8yy4Jn6KmbmIV0FdHa3KWGOn1srWv7r1daGTc3bJiL9LB9lRW8SO
 3GxpbCe/otVmx3vc9FgTgC249hFW1wjG2EWYApG/kMpnVRKE0JcK8cRqwt2cDo+YW492ODuL13/
 1iDmQC3jqbk9YxcyMzeAmtw==
X-Google-Smtp-Source: AGHT+IEFvgv334bH701ne0mKaBmxUq/pjTqrgeDMEvrImaiNqmHHp0Z+joyZhm835L4NeY5p5xazNA==
X-Received: by 2002:a17:902:db0c:b0:240:6406:c471 with SMTP id
 d9443c01a7336-2462ee0b897mr216696975ad.10.1756224833007; 
 Tue, 26 Aug 2025 09:13:53 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:13:52 -0700 (PDT)
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
Subject: [PATCH v2 28/35] tcg/wasm: Implement instantiation of Wasm binary
Date: Wed, 27 Aug 2025 01:10:33 +0900
Message-ID: <c0d05186cd431515eb3f97a7c860ec5b6deac0a5.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
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


