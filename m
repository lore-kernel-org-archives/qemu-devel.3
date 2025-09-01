Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A14ECA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2zp-0007x1-LU; Mon, 01 Sep 2025 07:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zD-0006sZ-Bs; Mon, 01 Sep 2025 07:46:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2z5-0001L9-7e; Mon, 01 Sep 2025 07:46:09 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b47175d02dcso3633218a12.3; 
 Mon, 01 Sep 2025 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727157; x=1757331957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlFgd5lXojT+BzMbp7XrzAMP3YD6Ncv6gWAYJEjREGE=;
 b=EQCDXNfJ6HjdIVBmxrTXcyYmlRqkYhQnNAy/3SrdLmtPOhSIIIFbszh7qjCZSmsIow
 jV4lfCdGp81c9qrY5zavkMIDwsfwVNOJLFTC2pIG/OdKMvME4a3u8J2pQbap9gLsgDWG
 x4OpCFAr3iGSPncfAny5BnYZnWpcR+b3zHuRd8+b3Q5cQGdqMaQa+Y05jhaLWu8D9FpZ
 1ABRVxYHQYNPxTXp7NP5snn1SOQ4ymya/M1XZRlzGXz9OuLFCVM3JpArCnLG7yD3QXD4
 4JH+HZRC+aaZ8o2HzE4WlJBsUbkuFs+6jFeCoJLluYoLFjNBu8eU0gY5EYwgbsuKC8Ps
 4KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727157; x=1757331957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlFgd5lXojT+BzMbp7XrzAMP3YD6Ncv6gWAYJEjREGE=;
 b=u2Of6GuO89vGRX48F7nQopqzfBpvbMdK88C3iSkCgbuNh2NMNlfcNThP3hPpaTku9a
 b+aO1oCaD6vm8vZe0DB2iLxC2cSLGnkokBmuzaR7mM6N82p0KJaUWbntGiTiRl537n39
 tEvTao55z7cxpmkNWDPpzAEl7aG4mnWjN+TdQ60fUWYSQToE7vxe1EUlYZNSlvgqOjcw
 SIgCLxvXvZSTbZfaDOZMpPevGeRjsmLAfXEPQ55dAE49nH1wLHQfIYLDLxdt7X/HWD8/
 rkD2xugkUnamWiBvkC32NjWbtl77xG9oP5pnSoYU0E5rArstrgCIEeGTK1l0L1y09ZLX
 8f8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9VnJJOY8X3UT8VpYFoRzy9bftIu4bBQ21ouSbTXr4BMY3NwrUEuTwGpV/OsNiIDpkD7m8OfbYhw==@nongnu.org,
 AJvYcCXzQ7SRjJkz3hFjH4fN8LXoxM/aEnQNPb3GMunhhTf45mWaSxX/BhOAFZUYhH7eQtw49c4nKC2lsvD5Kw==@nongnu.org
X-Gm-Message-State: AOJu0Yyy66TKX/Z6vLbhCofknEff6Ln7KkZZFRwF8VkxaNKGjpZRXYyL
 GvDygghpXRK6R/QdtOTvUZCwdL1HRi+RebQRp6cQbAF/C0SliJlt2jsDq13wig==
X-Gm-Gg: ASbGncuvDXOGX6SF+qewR99r4temKnNdX8GX4a09mB5PZPoTTxTGUIomuNGwQ84RXEV
 o6y78lOM+uaz8n6OtZ6VPj+6vJtKouW71PZuhpk3gqxq5woCc+i4kjoKesEAv1l1M8aMaLCuM/g
 A1hWADLNnODAVTZ5Uj2kOEo+RU0hDf+i2ZXlXj7UixeE68c9sdIMr40CB3BYcgfpRk/3cGDc0Kw
 RAUnLTRBkb/8qJbocue/dWhB5WtI4d4thiYwjZbEh0GyHEc6pXJLpclaTyPIsSZjFqs0/nMM2G8
 M8sC0f0H85aCKtC1PgYABWMFyAal2EgcgAXmzFe/oKrsZpSLQSn5ZTtoABQhB0lH10bD0H0FcTJ
 QXI8qfd3DiOYMQ5m08bAwQuZ27ZJZSzmF
X-Google-Smtp-Source: AGHT+IEkUCnP6JXuWT8gfRp2jur/WnSaq6ah7CS9FpCZKPdUEINQcJ234j5iV+DIBRSHhcjK9DgbsA==
X-Received: by 2002:a17:902:cf43:b0:249:c2f4:5af8 with SMTP id
 d9443c01a7336-249c2f47c40mr90316775ad.33.1756727156619; 
 Mon, 01 Sep 2025 04:45:56 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:45:55 -0700 (PDT)
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
Subject: [PATCH v3 06/35] tcg/wasm: Add register-related definitions
Date: Mon,  1 Sep 2025 20:44:08 +0900
Message-ID: <1582a3fb83f9a0f12a988bc159319362f69676e6.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit adds the register allocation definitions and register names to
the Wasm backend. As in TCI, call arguments are stored on the stack buffer
and the return value is placed in the registers R0 and R1 when needed.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 tcg/wasm/tcg-target.c.inc

V3:
- Although checkpatch.pl reports the following error in tcg/wasm/tcg-target.c.inc,
  this file is based on the TCI code so it is preserved as-is.
  > New file 'tcg/wasm/tcg-target.c.inc' must not have license boilerplate
  > header text, only the SPDX-License-Identifier, unless this file was
  > copied from existing code already having such text.

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
new file mode 100644
index 0000000000..3affc17232
--- /dev/null
+++ b/tcg/wasm/tcg-target.c.inc
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Based on tci/tcg-target.c.inc
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
+static const int tcg_target_reg_alloc_order[] = {
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
+    /* 2 of these are call clobbered, so use them last. */
+    TCG_REG_R1,
+    TCG_REG_R0,
+};
+
+#ifdef CONFIG_DEBUG_TCG
+static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
+    "r00",
+    "r01",
+    "r02",
+    "r03",
+    "r04",
+    "r05",
+    "r06",
+    "r07",
+    "r08",
+    "r09",
+    "r10",
+    "r11",
+    "r12",
+    "r13",
+    "r14",
+    "r15",
+};
+#endif
+
+/* No call arguments via registers.  All will be stored on the "stack". */
+static const int tcg_target_call_iarg_regs[] = { };
+
+static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
+{
+    tcg_debug_assert(kind == TCG_CALL_RET_NORMAL);
+    tcg_debug_assert(slot >= 0 && slot < 128 / TCG_TARGET_REG_BITS);
+    return TCG_REG_R0 + slot;
+}
-- 
2.43.0


