Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F79ECA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2zY-0007X7-JE; Mon, 01 Sep 2025 07:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2z9-0006s9-TE; Mon, 01 Sep 2025 07:46:11 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2z4-0001Kd-07; Mon, 01 Sep 2025 07:46:07 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4d4881897cso1800309a12.0; 
 Mon, 01 Sep 2025 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727151; x=1757331951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJlrySIO4BSZhcIFP/jHtysQnEYOUCLY5ts4W8Z02P0=;
 b=B8KVSunI4bO116tMB4q4xnJt4heNpxogCgi3R9Q/RW7PBQnuTPhHVlLtPTbBQG4Ye6
 PHUMdUzEu8yuDo4D6IHYggYK47V9VnLEy3/4viEF6BsnV8LaMmfqx22GbA3Mu60SJA8t
 HvoDtP2+f3/YXpcyoK9IjpOG2eLIqEdinkaBLMLeYUamoUGPEn9WTrpIzzdEN8ggbQ7S
 8FLFku2ZGucUpUb1fH3VTmtjJZnoJnKPyy52nN7nVeWOB6r8kYFVRjkzOl7BR04Dj1EB
 SFaDzoc03SLntiSlaxgURNOD5TMWdehsYyQzuldkOdT5YIWqzvYKM2ARYJsSVEH/F3Sr
 WTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727151; x=1757331951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJlrySIO4BSZhcIFP/jHtysQnEYOUCLY5ts4W8Z02P0=;
 b=ampYP6/pL9ggbhrQRx7W6di41cVwQBaMMaI8QFnx+cdwLbWItsc5/F8gtg9ceyvgmm
 kfDb4Jc85pDcA99qFkZtiCGiAvi2DlfWNDdJq2/Mi+PLl/VwbauhqYBt6mQi65/+l+/Q
 4KfjsGNHgwo9JupzzfruWHIFju0xBxDuX12ZGNI65ESlYVYdvVui1KpYVBNspuexwQ+Q
 nCg31Z4isPX/nv3efA5/m47Hzfjz/I5A2qRXpC4aPPqVoX1b0RG2W/DBrYZfIPMaIxXW
 JPhsKRIXqGtt+IZ/so+PEMh7EQx4eRJ1gTryWzsmYwW3OYqr+OVc47BPn4wpfYS11TAk
 Gq5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7FWTE9LWrQtbngual93upmNgCE8cEUKQwT13KpFK5kM9t09yYQ7WKz6AIp6rsRz+S8i8yuCZHqA==@nongnu.org,
 AJvYcCWAHerfjDQhtj+c+zIuYWnbFfrllVjsZDpbCmI7hKTz44U3ULq8Ljx/L4v+usUJHa+yfhOm6sP7cj+eEw==@nongnu.org
X-Gm-Message-State: AOJu0YxlBn0XBdiBoB7LQm8Exd2Bx9qCNsVffli0/Chm1OG6cODxbmJ8
 U6vjGg1fOMcrSsO+2xpCn7c+MaRR05XQdkOzwfI/gCCLyQ/QvpH5uhZhlyrXQA==
X-Gm-Gg: ASbGnct2SEpprdwBPSNDhwpBZJailPfNbBXRPK9oXRlj+dgGXZiXFqYwCrFcTEqwYIQ
 Ne7b/vS36Afmfg9UMltjBJO65LcReO5dal6eqebLGzrOTzttYWuuet7ttTETiwlk1VnfpWD4Jea
 NRbViA/xQTOTSInz/WFk63SPCPScn8MWersjJ8nIxN9AKCT2Lf2PxUudoaiuCuIHfh9mPmrx1DP
 odJk9usqCZD7k7b/Gcf2Vi+7mSF95pLiix8Sht6qptzOUddL7WOPcKUE9MsUvm6qN3fxKeOxaXW
 81giNl1qvqwcfl+lgMum3/PemxRBIDmLHSS1s7abYOD8Q2OVw01QU7u5FI+LbCSTpvZLuT247+5
 mV6W9jMmujpfNVGwarncAKr3Ek+Pz5wvS
X-Google-Smtp-Source: AGHT+IFW5pXptoNkvEWfX0rC+eB76VvDqUzzsHSUf2+rrT0WbJDA7OQuA4qZ+JSj5xn7OBcwyTx28g==
X-Received: by 2002:a17:903:2288:b0:246:ae6e:e5e4 with SMTP id
 d9443c01a7336-249448ded1amr94443535ad.6.1756727150962; 
 Mon, 01 Sep 2025 04:45:50 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:45:50 -0700 (PDT)
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
Subject: [PATCH v3 05/35] tcg/wasm: Add tcg-target.h and tcg-target-reg-bits.h
Date: Mon,  1 Sep 2025 20:44:07 +0900
Message-ID: <a3135800931780f64d95cae0c461954c46ccecc1.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52d.google.com
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

V3:
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


