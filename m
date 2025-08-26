Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E2FCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwH0-0003r4-UC; Tue, 26 Aug 2025 12:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGy-0003pm-JI; Tue, 26 Aug 2025 12:11:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGv-0007oR-Og; Tue, 26 Aug 2025 12:11:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-246aef91e57so35856285ad.1; 
 Tue, 26 Aug 2025 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224700; x=1756829500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZwHQZgUPb/6HP3UXiUPBZLzI+J57XBgNUzAgDai8qM=;
 b=DC+lFKJ7yGa4viucZ/mhOsDiND1P5vRiAfajbWl+wmso7F/oiqXbcJAdCMfzfdJI3a
 PLqCgtOk13kFd98Jat48qbSnE58pnujceWz0eDDeu45L8yoHm1jIZXZVMWhFxWZOyI5h
 YUkOqzmylpAl6pDCmXJqLElfplx4q5rPpUIdiWU8S15mhs/qKTb19InuhywSWRrU3wKC
 m/CvMXamnL8a3Qe5hq54d67TA+QZUbNAHo7KM5H3dgPp5jdzK/Swe22+FyAKRcr4efPI
 rR2HRH5dVyiS6LMqWxjPxMpERIw0tR1jJxQS4ww4MvFzwgtuRa4JVXPbyByn8UyGKJhx
 3iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224700; x=1756829500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ZwHQZgUPb/6HP3UXiUPBZLzI+J57XBgNUzAgDai8qM=;
 b=cRn9NSoOFh6V4nx1y5H0IMpPuJTl/OAM296c3s679y32tCfuLNoFExxvL2n93AUHMo
 k8ilTcrSWAdB3MLDNlL+retEgxcs6svmspobulAS+EmTD5oi8VdHBwf3Puw4ZUJUACgu
 BFDy8qkARj232/LXeEZutfbXnU0C3wSDeIpNlxfHVRNmEQ7g+5W3mKorTBpCiPvknSia
 FUEJm7/j0kuIKcgFhvk8QfnhtKYuRVTw2AI+QysWoDxreJFO5nvorGfzuQuTyGoOR2Ya
 Ugqw0SDixb0F/lAWmC4CN93Vi44dDrDZ06DaQ6EleXtLnUo9zwSPA/3eTkE7+RW4VIAy
 qtwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrYrkQ4+AJJMIXQbKJZOk1RZG8Ol2OvyfVKCsxFSb4euCEeIFkRzDHnRTw7qG9OjL1A7WMaS72zg==@nongnu.org,
 AJvYcCVQVaZ8rUJasNiqIkh9o9TyHocGAuRZ68gMXvQrZLntHOajcGuNtF27DEMJxj+0xyDtg+yR1BIIS0OwgA==@nongnu.org
X-Gm-Message-State: AOJu0Ywgoh2yB1VtDluWpEio3IB4UI66Ot64kFcV7EWa8lMRtdHGT6+g
 gafAD6pmvYYzMao3UIsOCoC5aC0r/3Y8xYpyuDAFalUobkgcf6pnzqbFL9GJPQ==
X-Gm-Gg: ASbGncsDSBLgxGmxkLTObalZd5lcxacQ6lfDbB/OgXe90naP6iTY2tqNF0TQVv43Cbs
 Vs99AVSXILXbW3JgTNE1K5rSXM/K97JCxpGRhNhR0m9/NPy2xoEF0obxg3IC5F8rRdSheSOu3ky
 nfKm8HqHv89NkxuOFtPpEmIj0sthAvrmqqUwvJJk4gwKLIyGEf75cg0ADZ5sHUGM/Np/OJpgwB9
 ATKtu8sJ/DyLX5Ax64hSoYxluz004mG58dJnI5u1or3cc1aE1L4yv1TPNZEdf+9y/6o4X54PAmK
 Pielp0F/97DTuS1lGqR7QxPlNIXKiuvID65cgXwT2xsYvGLKtCiuW/kBKFsS9wOGiSov6UZ7pLz
 MpSphnr42Z0AoCyuK0rQWuQ==
X-Google-Smtp-Source: AGHT+IGEfFwjlxyNMnUmpyVEE0W7XGhab6TpxDHkqhl+S/15cqI6xCwsnSfK82WB6RRsJM34rKt99g==
X-Received: by 2002:a17:903:1a08:b0:246:cfc5:1b61 with SMTP id
 d9443c01a7336-246cfc51d45mr87157475ad.55.1756224699647; 
 Tue, 26 Aug 2025 09:11:39 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:38 -0700 (PDT)
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
Subject: [PATCH v2 05/35] tcg/wasm: Add tcg-target.h and tcg-target-reg-bits.h
Date: Wed, 27 Aug 2025 01:10:10 +0900
Message-ID: <a3135800931780f64d95cae0c461954c46ccecc1.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x635.google.com
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

The Wasm backend targets wasm64 as the host so TCG_TARGET_REG_BITS is set to
64. Since WebAssembly instructions vary in size and can include single-byte
instructions, TCG_TARGET_INSN_UNIT_SIZE is set to 1.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS                    |  5 +++
 tcg/wasm/tcg-target-reg-bits.h | 11 ++++++
 tcg/wasm/tcg-target.h          | 61 ++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 tcg/wasm/tcg-target-reg-bits.h
 create mode 100644 tcg/wasm/tcg-target.h

V2:
- Although checkpatch.pl reports the following error in tcg/wasm/tcg-target.h,
  this file is based on the TCI code so it is preserved as-is.
  > New file 'tcg/wasm/tcg-target.h' must not have license boilerplate
  > header text, only the SPDX-License-Identifier, unless this file was
  > copied from existing code already having such text.

diff --git a/MAINTAINERS b/MAINTAINERS
index 433a44118d..89e4b51e22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3999,6 +3999,11 @@ F: tcg/tci/
 F: tcg/tci.c
 F: disas/tci.c
 
+WebAssembly TCG target
+M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
+S: Maintained
+F: tcg/wasm/
+
 Block drivers
 -------------
 VMDK
diff --git a/tcg/wasm/tcg-target-reg-bits.h b/tcg/wasm/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..3dd821691f
--- /dev/null
+++ b/tcg/wasm/tcg-target-reg-bits.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#if UINTPTR_MAX != UINT64_MAX
+# error Unsupported pointer size for TCG target
+#endif
+#define TCG_TARGET_REG_BITS 64
+
+#endif
diff --git a/tcg/wasm/tcg-target.h b/tcg/wasm/tcg-target.h
new file mode 100644
index 0000000000..f00761d19f
--- /dev/null
+++ b/tcg/wasm/tcg-target.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Based on tci/tcg-target.h
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TCG_TARGET_H
+#define TCG_TARGET_H
+
+#define TCG_TARGET_INSN_UNIT_SIZE 1
+#define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
+
+/* Number of registers available. */
+#define TCG_TARGET_NB_REGS 16
+
+/* List of registers which are used by TCG. */
+typedef enum {
+    TCG_REG_R0 = 0,
+    TCG_REG_R1,
+    TCG_REG_R2,
+    TCG_REG_R3,
+    TCG_REG_R4,
+    TCG_REG_R5,
+    TCG_REG_R6,
+    TCG_REG_R7,
+    TCG_REG_R8,
+    TCG_REG_R9,
+    TCG_REG_R10,
+    TCG_REG_R11,
+    TCG_REG_R12,
+    TCG_REG_R13,
+    TCG_REG_R14,
+    TCG_REG_R15,
+
+    TCG_REG_TMP = TCG_REG_R13,
+    TCG_AREG0 = TCG_REG_R14,
+    TCG_REG_CALL_STACK = TCG_REG_R15,
+} TCGReg;
+
+#endif /* TCG_TARGET_H */
-- 
2.43.0


