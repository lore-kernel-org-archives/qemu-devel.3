Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4661FCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR29-000414-Cn; Tue, 19 Aug 2025 14:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1U-0001jZ-3r; Tue, 19 Aug 2025 14:25:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1S-0004Wh-4J; Tue, 19 Aug 2025 14:25:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24458272c00so56805435ad.3; 
 Tue, 19 Aug 2025 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627924; x=1756232724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLeDWSkTQRfvzmWorL2lfp3RyCcc75fwMMerpGbsxQw=;
 b=FPSJGQB5OM9hYQL6G6EAocsweHFGroRIHK8IBqF11TMKdepgsZc9MN/+Frqzm4ncdE
 pwSEvtr6kmkxM9x8txHtdWo6TQ4PRFfkOloy4gB0EJptV8un4afnZ4I88HofFQUpGfP6
 OTa4k+oyHyyIBRcplCHUQSwUNIpL1JLGlHNbSHuhsasjWvXbb0DLXXACE7Imj7OWcMkH
 wXdiiVLiA2rTZLP5+3UW84p1HcQDiDp1fGWjvHDJ+bRqDkemq/41TCJoFWkQryBr9F6f
 nyMjd67Dwy46UaheYaq1jDq4ouFGh9ra0vNx1Mz7wp4TSKLbAx1IwkZ+VTUMvX7w7zvx
 fmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627924; x=1756232724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLeDWSkTQRfvzmWorL2lfp3RyCcc75fwMMerpGbsxQw=;
 b=rjxxXHuSyZJ1zl0x0G64lA6MZeU/RjcKV8UAPQaSX+CWbw8mLEoHi9Iz8hfqjhk/2U
 dH5l0BxyR2HAra6RkQPQ5QPNiWaGyPfUKKZVvqEW2XC6ESSDLWrjZRoMMCB5/BQwHpsf
 daYy2/m9/uB4lSwWjgR0ywvPti86k+HrkLB83OfXyT2ieePtAmmOB3vHkv3aRRomph2t
 etVmCuv+6ESax5fqI+Coh9NOa8EkiDuYtue1a9WadZzelSyAMjjKAgortmpq7mgiAAmq
 le/woY1LI1+T3jtqWwatQZukPDGw0qPfGPk1fTn0xmoyXrv2YqYJqJsktgS8Ztsgszxm
 IEwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK9hQ9BiMEOO/9myyyOmoEYxOHU+pFiuZB6EPpNCKBX9OK/T257LWpkWLeDRq5b5A5drB0NMz/Xw==@nongnu.org,
 AJvYcCVzVZTHOVZ8xUxWLRWUHgkx0s61oE86mKVzQjYqaPL4LdPoAS3EKuduY3Rp4cim/+8YSvWhfrVe0kiERA==@nongnu.org
X-Gm-Message-State: AOJu0Yxbq/a3zEFbxMXGQKFbXTh72nyEk5gI+GL9esFJskPhUES7E/sW
 ZbuDU8/5+ccRvc0cirUeW2/Q8rgfN731I5imESvhPL1hUGk3DxL/ZJ5sbYsgUQ==
X-Gm-Gg: ASbGncuU57SoStnrKoUH54Hw3Mg8W0xaJpezVYcyZxUluTYOR3W6EUDAzs5Q5Ps0sLJ
 gmeGGt9WubgtkYPsVcyDhWYunrkcfRwcF4khGPcLZFof0uv0mH69XJH0stp7ylleqKzsb5+zfVS
 wRsgOXlKJoGKgUdcKmRG9GGEFW/LH3yfkAVtMkxGgpWVh7XcnfdRC3pgSdmWpc2XO8IodXsy1rY
 THM3VrkwSFb9AnOwWopnJQvbdbcpagUE0bGZBI0tOfbZ34DxFbM0nE9PSaMHacVMuWY4aIa48S3
 PHi52MDb0yaZUBJ9SbtGGWupWa37SMFOaSOGN6ohL/2+MuT5CoaskGQcfHi9GGFn7vhGGiCXOsW
 elhcbJha+CpclNLdZ54ES91NK8Y3wWCIVNPKLNdBdw0s=
X-Google-Smtp-Source: AGHT+IGoOqJOj1cPfn78hD8vlFxsKQWwq6CGFnUar6hxXovlXPO3dsvLvIk8dmpGKHJa3T43IyBUJg==
X-Received: by 2002:a17:903:fab:b0:240:1f25:d443 with SMTP id
 d9443c01a7336-245e047f53bmr49657645ad.30.1755627923708; 
 Tue, 19 Aug 2025 11:25:23 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:25:23 -0700 (PDT)
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
Subject: [PATCH 30/35] tcg/wasm: Implement instantiation of Wasm binary
Date: Wed, 20 Aug 2025 03:21:59 +0900
Message-ID: <2ed7c66cf4fc77e69262486f0c735d747b4dcba1.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x629.google.com
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
index 4bc53d76d0..835167f769 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -25,6 +25,7 @@
 #include "disas/dis-asm.h"
 #include "tcg-has.h"
 #include <ffi.h>
+#include <emscripten.h>
 
 
 #define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
@@ -44,6 +45,42 @@
 
 __thread uintptr_t tci_tb_ptr;
 
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
+
 static void tci_write_reg64(tcg_target_ulong *regs, uint32_t high_index,
                             uint32_t low_index, uint64_t value)
 {
-- 
2.43.0


