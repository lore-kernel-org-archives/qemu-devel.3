Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37134C88E58
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtQ-0005Tk-PE; Mon, 26 Jan 2026 02:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGg6-0003AC-Pp
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:34 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfy-0004g0-9T
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:23 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81f47610542so2101072b3a.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411173; x=1770015973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgECP+hmksJ+zy6bkW5CzjXt2QiZncCK0ttplyASTGU=;
 b=JR37yOojmnwtNMbvKCHkSJFmcczAkpHsJe2xMKiGy6bqYUZx5xQhBCa9BbAZxmN1RR
 u3xlGtjGGhQ5ahBnSuPqf6IsS0DmMu2jR4ErNx3hIjJaxMtqugVLLR56TFRWl+/Py0gm
 M2Vrne+38CW3VlOjDBwcl/lUqmowpryFPxR5LM/dlNm35seWWDWkt/3wlr7I9Petbixs
 NzoKAa7uZa2wqfVxEQBDbrvj+zW5oi4dI6/zei/pNcEtCztPhHacWfjAygBc3Tq9pQBQ
 MvRq3z9oc/OJpI3Gkp5Hm9EKflYQSm1ZtXM9b7WEhzT/G0dwMXGKfcjwDo6Ag6gNgG9W
 nBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411173; x=1770015973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hgECP+hmksJ+zy6bkW5CzjXt2QiZncCK0ttplyASTGU=;
 b=YV1IH3qjYzjN6SrDuRpaA8eF2DGtTQkHST4UpgZBR3rhg89x8v9vafnq3i4x1lqq3M
 ByRNTB2WE6UIGhlq/flIVumy8265TGI+5rVCMR5cN5sqeJXVZZs/fBYRWpiCZNUBy0p6
 djz/L0/3RHVGPMz0YnHwYbn7Q/oQG4UBV7t9TDN3PeD09YVQDEy24FKP0sqkfGY+n7Fy
 H9k+OqsA9uMpA8xvusq0udkbLYI+iq5jSkSruR9F72MH+99DbNBO3mb9s6KbgBkKboRp
 NiOYRbSnOhbdQd0+KbBq2KsviUYiX1F4h20aqIy+bJCpEJeUdldw7CQuJO0hDEBSvnuG
 +vbA==
X-Gm-Message-State: AOJu0YxyHvJY4pg7L3AMOkBpchaUds6rIkYJLUnm32WmflbelbhA5OTS
 UQVI+6ejMbGDJtgYesjjZXrX0HVXBi+6weqIcyFWd8juIwswGRAn8QjoCWSilPSz
X-Gm-Gg: AZuq6aImFzDAhfWXiQeEc/uqPJf1n8NG3zmSARodpuq/VoORnfTGtn30OGMBhz+ppRZ
 DBGUMOX8cwIqMHxy605Ndzdz1tT3NawVbR0lZpd4DZBp14CV3btcjr8NQLP1/IIDhfJBRSqsPv7
 WxvBQO76ADr1w5xTtrnPw3Wr3K9bZMLCQRLn+CkSxq+Zb+8H8h5dtVMjxivulgiYAdzwzY/ApiA
 I+1cEs6ccJyOlxwRgR0CH+doryqrC1kVexmE0trnpcvxWni5eUNxsohK1/oAZSve5M5oEke4Nax
 RWkvjsfWaII5cp3f4wt13jVXN40IiMvtvNI6qDwCL+GFMgqcDmyp6DiqZ0hU6jbvfOh2EFpjfSn
 1WM2K0CFuo0r+zUP6Sy6O0HNg3L1faB6P3FNHGFMV59xPAFB//uaSe3nOo9XbkEJblafyXlfA8S
 MnX4O+pV0AIJjiIDS39N+gqtPQgiPcjLpHcEy5yDt1ZX8zvBG7/DLS
X-Received: by 2002:a05:6a00:1494:b0:821:7ee2:b692 with SMTP id
 d2e1a72fcca58-8234120a841mr3321932b3a.2.1769411173276; 
 Sun, 25 Jan 2026 23:06:13 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:06:12 -0800 (PST)
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
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 28/33] tcg/wasm64: Add tcg_target_init function
Date: Mon, 26 Jan 2026 07:03:41 +0000
Message-ID: <d266a6bfb493cfa469ff2759284ba0ae6f91609b.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit adds tcg_target_init, aligning it with the Wasm backend's
register and stack usage.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64/tcg-target.c.inc | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 7c414a8a36..797ebf3f88 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -2822,3 +2822,32 @@ static int tcg_out_tb_end(TCGContext *s)
 
     return 0;
 }
+
+static void tcg_target_init(TCGContext *s)
+{
+    /* The current code uses uint8_t for tcg operations. */
+    tcg_debug_assert(tcg_op_defs_max <= UINT8_MAX);
+
+    /* Registers available for 32 bit operations. */
+    tcg_target_available_regs[TCG_TYPE_I32] = BIT(TCG_TARGET_NB_REGS) - 1;
+    /* Registers available for 64 bit operations. */
+    tcg_target_available_regs[TCG_TYPE_I64] = BIT(TCG_TARGET_NB_REGS) - 1;
+    /*
+     * The TCI "registers" are in the local stack frame and
+     * cannot be clobbered by the called helper functions. Additionally, Wasm
+     * modules for a TB and QEMU itself (i.e. helpers) are separated so also
+     * those variables aren't clobbered by the called helper functions.
+     * However, the TB assumes a 128-bit return value and assigns to
+     * the return value registers.
+     */
+    tcg_target_call_clobber_regs =
+        MAKE_64BIT_MASK(TCG_REG_R0, 128 / TCG_TARGET_REG_BITS);
+
+    s->reserved_regs = 0;
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
+
+    /* The call arguments come first, followed by the temp storage. */
+    tcg_set_frame(s, TCG_REG_CALL_STACK, TCG_STATIC_CALL_ARGS_SIZE,
+                  TCG_STATIC_FRAME_SIZE);
+}
-- 
2.43.0


