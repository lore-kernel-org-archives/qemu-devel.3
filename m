Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5105ECA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut31x-0004Jq-Nn; Mon, 01 Sep 2025 07:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30y-00023p-Hz; Mon, 01 Sep 2025 07:48:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30l-0001jF-5Q; Mon, 01 Sep 2025 07:47:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2445805aa2eso43018895ad.1; 
 Mon, 01 Sep 2025 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727260; x=1757332060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akIEERgXs7+yZRZkR9zbLlIdfnSFTSvmgC+mcTcKDAw=;
 b=WuziJcNguo2eyLJhhzdkZHu0lXdb4H6OBiryDAXTgrYvr5ahpeh0EgY9PZTGfU+6QU
 H8R8FhaKitGpbaocnmYPwVl2K+0w000rw+oXrorTDLv6/ZNhgPsDxLq/4maVdBqMYuLE
 Y/nwR9LSsfbFijRzPxBL5od+t3q5Uwmh88I+5q4RpmyepUh7Il1wauH1IjfnnJRy2SA+
 iDMf9rJ4iow5T4qvmmhI3h/FcE6AMdb3ZRoEpZuuCOo5EqvU7d9WoMQeljpqKqGoHZxw
 1EjX2Z/m9tQ6uh+X+chw2DPpQS6gWiFfV0+c9cB8yF/yGhkeKhF5cpowKB4o5V2C8M3B
 tFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727260; x=1757332060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akIEERgXs7+yZRZkR9zbLlIdfnSFTSvmgC+mcTcKDAw=;
 b=h0xC//ekLpS9WKUigfvFp4quxFswlqs67oOzvRXgI7VhVhiS1oV3Ft0r8ZbbeA2JEU
 UN6tXFI0Ag3DQZM6VTLawPq90SPLcT0lplwiso7xMu8UySNP4EiJKJ5ewdAIRudUpCDS
 Z6VE41wwbgzHqXqvyoQ7cYF/5mpMsO5m2Qv6KKhwtF9KR1iosHzp4XlkKd8i1x7q1kla
 Mqqq/vmVqv06r2AfCgB7JDJR6FeQgYu9cnkgLr6KVTQ3PLkhKXvId8oZrbXKYjZJ33NN
 3OQlsKE3sie2x16QycaFbyC6Di6hYGhLllx403QsxNLQ/aRCjNQTYt0eIx9k9A75xvX6
 8tyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4oN3OYVUQChHXbviClvG+39XrJnVnzeKAcfXofTaxEvMB3EHnLiEMeuLZeAvjEqsWjPixwrLCmg==@nongnu.org,
 AJvYcCX51YMnr2dhTbJJgWzQjf2mTiEJsehBFa7Acya+bjKV6nEFvNvsEluMVSlI2YOpBAy8YH4rt3imQudFvg==@nongnu.org
X-Gm-Message-State: AOJu0YyStQhLblZNldPKZFoEg1kdpoQKSEzXi3281H9xYCXrj72iaX18
 3bRjgQFJbPPRlAgNWeGPHXOMXAgYoxVzsHz9TTaLo6UxFCjAFunqBQHC6VpFwg==
X-Gm-Gg: ASbGnct3Q0MX6FolOn0jNEmbR0MR8ozloqqisR4Kq8OuVk9TzGTcjlwzyXDHbqzFhsG
 IjXENtjasRS+wPOl+YsA7iOwzxllQdh76s+KOhARdHWIa+VtpM0R85niAng0facV0bEskuCi1gh
 0iqgrpn3YkPAeUdcSeZDMKXvj0VyK+dck1ICpbJTGobg8fAJ3zbFkn3kGbxjL6tKZdr9awtc/Or
 lxSqFpO9ylq9Mh7kQDG28FKAXRbBTUWhV5QTUVZRMEJaTv0RcBFUgURt+2AN0iaFEPPeau2m/NX
 nveJiaGTy7eE5v688txLxBXY3EDZcQDPSduBQYwRFldYdiU7VYL0/CY9cqfsebYOAc8gJAo/UQg
 UkWUQIFCKutKtZYXm+vH/S3ekE4nkwRoQRMIY2sp0u9M=
X-Google-Smtp-Source: AGHT+IGoZH78ykrPnBnJb7ak2DPU5Ku0CRJtbTb5vWJ5yLQGCn6ko/d1/XgsT9gurpBWIb+vEU6nVA==
X-Received: by 2002:a17:902:f78f:b0:249:1156:31f9 with SMTP id
 d9443c01a7336-249448e52c0mr95198285ad.21.1756727259789; 
 Mon, 01 Sep 2025 04:47:39 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:47:39 -0700 (PDT)
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
Subject: [PATCH v3 24/35] tcg/wasm: Add mb instruction
Date: Mon,  1 Sep 2025 20:44:26 +0900
Message-ID: <3db8ec74078663cbaabcc680e53f1d588f5f5970.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This commit generates the mb operation. In Wasm, it uses the atomic.fence
instruction as the fence operator [1]. TCI instruction is also generated in
the same way as the original TCI backend using smp_mb().

[1] https://webassembly.github.io/threads/core/syntax/instructions.html#atomic-memory-instructions

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  4 ++++
 tcg/wasm/tcg-target.c.inc | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 793c1807c2..1cc2e45e77 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -566,6 +566,10 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             taddr = regs[r1];
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
             break;
+        case INDEX_op_mb:
+            /* Ensure ordering for all kinds */
+            smp_mb();
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index e1ee2f6485..1d639561db 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -1116,6 +1116,11 @@ static void tcg_out_op_r(TCGContext *s, TCGOpcode op, TCGReg r0)
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_v(TCGContext *s, TCGOpcode op)
+{
+    tcg_out32(s, (uint8_t)op);
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1931,6 +1936,20 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     g_assert_not_reached();
 }
 
+static void tcg_out_mb(TCGContext *s, unsigned a0)
+{
+    tcg_out_op_v(s, INDEX_op_mb);
+
+    /*
+     * Wasm's threading proposal provides atomic.fence instruction as the fence
+     * operator.
+     * https://webassembly.github.io/threads/core/syntax/instructions.html#atomic-memory-instructions
+     */
+    tcg_wasm_out8(s, 0xfe);
+    tcg_wasm_out8(s, 0x03);
+    tcg_wasm_out8(s, 0x00);
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


