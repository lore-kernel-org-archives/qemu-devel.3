Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F61CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwH3-0003tZ-Of; Tue, 26 Aug 2025 12:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwH2-0003se-Dr; Tue, 26 Aug 2025 12:11:52 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGz-0007po-Qd; Tue, 26 Aug 2025 12:11:52 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-325393d0ddaso2849008a91.3; 
 Tue, 26 Aug 2025 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224705; x=1756829505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/fzUvhJeb27HtSyKuJMiX4ymH+63mED0fuMX31N3yI=;
 b=LAtPYz1iBywP950XD0aSBqahHhZggcqGkEDX3EMYp6dsH1xJd32LaNb3AYqwe7GuuK
 vQV8JwsV3cnw/8yfdstmXkMrzNc/qhSs20EZJ5etzyDZIl9D3ot5RGkhb2Eaxl8difZQ
 aDDQ0ylam1W8uulW4ccbEntly23KJERLSFb9LexjkfJmiQffL/wHddHmXhvLRu45SRDL
 tRk1YbGbcthflU3pr3c77L61vIsTuhoVdIE5LRstvsMf1ScdUcrWq5/3r03XO9bDE7ku
 c5EASeFPGdgc+Glwop/qM2/CFQtBgIq3s56uDkamhjujIc69xKp3HWXeujJVRbZCzDV0
 EXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224705; x=1756829505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/fzUvhJeb27HtSyKuJMiX4ymH+63mED0fuMX31N3yI=;
 b=nC7iu1pT/XLqd2FYbGh0XRVLr1fo9EDlr5Z9AqR4NZXbxEeu9rz6lPEsU0AIxlPIc6
 zET9xWkDLIBw6v1DmNd/5ixBdHMXpxHTxzJUkwmho4JtUPM4bqHMQ5SmT/lMF3xx7O3V
 2TziB4qB/ymxCH6B91j/2y2ywTG5uu5UMBCJMLAdig0pLErQw5ZPZsu4m+d9QHGnzY8K
 X1XhFBIKavbaKGux4yAdZoFIePDrHc07gtX2do0R4zEuKB9iNA7UExDS1eI/N8h6NB+D
 fDwoM4mszgUuAPM2jFr4+2sBCAOuycPoyfoc06Jo8tUMZ81Ub7CuXemO0WkHNrFcwxYV
 5Rbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWngcEAhbAAXypVWszrWG9OikTKgpFTbfgn4Nak1Dhd6XG40W2moPG9JZ9/VyblLf+fFdvD5nzSh3USBQ==@nongnu.org,
 AJvYcCXDjJuxOQOjvVtdTt1Xu/Z22hGWzEKAnytXJNB3HASAgDbH8NV3dk3MsuIe8iR07IDkjXp2t4Lptw==@nongnu.org
X-Gm-Message-State: AOJu0YxvJq4H409NLTvm+kUIKdmYrPOZQwpUjQtXXajIeu66ATnLykV+
 wBqW+QSWrWxn2iyqA07iqE4K2hbEK04Y/m3BPcvW204k5nlMPmzb5U2kZPIVEA==
X-Gm-Gg: ASbGncsdeDyAsrf5sRtg7EzkZKaFD88f9u9fK7yT022PNDZGk78wvS9ogpeR2BV9qxt
 av6WZpHM5LWSkzPv3QoJhAQehwshl4F8FKLLNLkYVAnRLlT0IBnGrTF89ilBO26F9ilmuo70wVT
 dkhTzEy6Bn7BgUVI8SBZK6xUN6oAL5m0PHfrDwOv2bPvbEv5Dozxmy7085f0Z8v1Mz4rc5vq2W5
 IbW7fbIDT68G+kfs586IJ1zQhKCkG9cqphzxBxTFtLt4J6QI9dOCaCOvrG75lCVq2NHM3nByi46
 z8Cusr5pQTOVMyxITD2g9B7Pygz3RU1WHtG7weYqmCaUQvGqFy2Z2cAZb//JI+dSXtw2Gmwsnza
 3CWWJWwgPXN0QURVw2m9/rw==
X-Google-Smtp-Source: AGHT+IGZxEaqTQRXGPWF9FaWy38eYlIdt17yPJKSFFyS/6cuD/InjA9HI50yt14P82OhG7aAL/TnjQ==
X-Received: by 2002:a17:90b:1fcc:b0:327:6823:bfe with SMTP id
 98e67ed59e1d1-32768230e60mr483310a91.8.1756224705261; 
 Tue, 26 Aug 2025 09:11:45 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:44 -0700 (PDT)
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
Subject: [PATCH v2 06/35] tcg/wasm: Add register-related definitions
Date: Wed, 27 Aug 2025 01:10:11 +0900
Message-ID: <1582a3fb83f9a0f12a988bc159319362f69676e6.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102d.google.com
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

This commit adds the register allocation definitions and register names to
the Wasm backend. As in TCI, call arguments are stored on the stack buffer
and the return value is placed in the registers R0 and R1 when needed.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 tcg/wasm/tcg-target.c.inc

V2:
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


