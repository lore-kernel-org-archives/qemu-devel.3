Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD59CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwJJ-0006nk-It; Tue, 26 Aug 2025 12:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIi-0005L5-Ge; Tue, 26 Aug 2025 12:13:36 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIf-00088H-0w; Tue, 26 Aug 2025 12:13:36 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b49db86cac4so1841491a12.3; 
 Tue, 26 Aug 2025 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224810; x=1756829610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdm5qlPjiiBmfUrpVbsMm6TdPYck5xoQGraSVKOpe8I=;
 b=OPGPPY9ZAiV/ByuEVPQOoX9Qz1JrSCD57L08m2a+4pLeMUzIiuUQrt7yiVQlDn5fOi
 8T6tkQ2whtbuj+hHqdXUhBQrtQUdV37xCbr7MHjq+IUVCz5luCMyz5/la6pFVc2bBKrf
 TllMavomIG0ls5y0LDNaIu5dxPsgiz8KpA1hmR5fr5oRltBKhYUVVPodMKyr90S+RGbY
 xjIJepQUh2kS/e22gPAqT+83YrpIU+rp7p0QfpMD2c2CZFcxFdElZWlojcBT3U7m75Y3
 bOhnZg4Dkj6aaruomrFKW2i0Djz1zGex4jr4B/KrbwaP/bN/HH66X45k26CsqSVJWKnK
 hILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224810; x=1756829610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdm5qlPjiiBmfUrpVbsMm6TdPYck5xoQGraSVKOpe8I=;
 b=P9Z7HvYv7A48rZl+5X77HMZ4FxQuOzXHeLoP0oG6tmsaSk5v8fTFabXMrmFibx1J1L
 3ydlm86Lxo6kQ1vuZhquYCkXUnh0TYdxJiupdaRlbvT1dF/CF0AAn4/VMVWrzG6/Zaux
 oXGGfffSecE2WKzOe3yATLGwy3PEcwK1ssyHxCACPQnbEA3j8Y+puKFHPquknHO1qHck
 ulCTwsGXa+fr3DmempvRRCLZ9AbQevD1QVpG6EASwJUMBJWl+2dCxdexp9jMZv2h3mEL
 KRnFcnBv2cCDhpk6i/42BIBgIsvd7b5cYtI+H/k+XVS1AxCKnKXnjXoNQ/RngjELaNje
 CGiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHw3zVD15Bn/TrsxmLvAdbl3MJznZwx62Ln+B84XLtO65s6riULofIdCpQga6zsxSyyVdeJT5khQ==@nongnu.org,
 AJvYcCX4319KgR1pITBpg9bc2vH7y8OaeNloUF/BvIMhssLx85IGYv+kmF7Bbi4EolHSN29IcDU+tHK6nIr1Fw==@nongnu.org
X-Gm-Message-State: AOJu0Yz8ftffL2LU1caotP/mAL3SMCv9z/9flH2mBaAWCEJDP2stI3qI
 Cmnp/G/OBrlyhefelIqjuWXkvczv06ZupMWt/JDV9mLWGRh6gw+s6K1Bg+sY1Q==
X-Gm-Gg: ASbGncvj8K4ZVZwBKaA13DvZOfWp4Lr84TBu1+ws2Bt4IEQY0pDuaizde35+o54WTZ+
 Xm0Spe2CL4KVBkl30RJVvZboW6AiNEjGWnugKT1A5RryFqnjA5NvYJH/UXk+F4KV61OYG86DiMo
 lYBmEbqEDKhKjnqiSM6qsTvrTsk3A0CTdIGZFLfbAgJ48KAfpPZQllxeoJ0Y1w7dUhVuUmswwk9
 xRPthXuaoOQal76gecAPdtFpKrlrBdNxdCD8rwqMha/lnqZMjOzbqoSiouduzxMz0JQ2S3gmXDg
 5wNbPofEyYR8xuPeeVXE8f9kP9au2nRagZY3Xch4S5yZGrb9Oa7SKEBrmUWdpsHWpFfCPq9mrcS
 hWJ2i8Tvq3aArrXNlllGizg==
X-Google-Smtp-Source: AGHT+IHM08p3gwEauAwGot3XMz9a+Eisy9iW8w94o7N8zZy3qFDxVmnsbhhE93IhyI2Bii++6C9NFQ==
X-Received: by 2002:a17:902:ec81:b0:246:92f5:1c07 with SMTP id
 d9443c01a7336-24692f51fb7mr134640575ad.51.1756224809607; 
 Tue, 26 Aug 2025 09:13:29 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:13:28 -0700 (PDT)
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
Subject: [PATCH v2 24/35] tcg/wasm: Add mb instruction
Date: Wed, 27 Aug 2025 01:10:29 +0900
Message-ID: <3db8ec74078663cbaabcc680e53f1d588f5f5970.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x533.google.com
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

This commit generates the mb operation. In Wasm, it uses the atomic.fence
instruction as the fence operator [1]. TCI instruction is also generated in
the same way as the original TCI backend using smp_mb().

[1] https://webassembly.github.io/threads/core/syntax/instructions.html#atomic-memory-instructions

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  4 ++++
 tcg/wasm/tcg-target.c.inc | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

V2:
- Added Wasm implementation of the mb operation using the atomic.fence
  instruction.

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


