Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3F7C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pg-0002UH-1x; Mon, 17 Feb 2025 14:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6oy-0001vY-0u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:28 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ov-0008Mo-1V
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:23 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220ca204d04so61620385ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820619; x=1740425419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oS5Y9/paa9jMbBQhn+BAkk9Qf6Zlh0Z5idEcCp0uG9E=;
 b=NSIlwrO6Gb7iq9o0U9UAonbiOpLYoffOoy3VuxwarABg6WcIPeRa+20wNIt6ZxPrpG
 ppBm3vOSU+cUUyJbfNFydqlVtI0YODhbHxy+9ABj318/dd4UoEfWr4dgEeofF51MlK7B
 fUcbuzc0jix11zscP0/XjFWyrArKY1RbgxSf1W7jgTUnEs0hjiIZSMqbK+/hbgrzT36K
 d8R7NvDhGEJzvA2YmUm5j2rBJE5idz/r3WnVA/R6UyblxltSTvzWHHmsGc+M/q6fBDIz
 rUwVSUOAmG+PEQ4zrs1xtX+fwGQ7alsbwdsVsA7LJQFeX9QchUxq4vyfsIVKajr63ZJs
 A+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820619; x=1740425419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oS5Y9/paa9jMbBQhn+BAkk9Qf6Zlh0Z5idEcCp0uG9E=;
 b=KIlluHIbZwpfeEJRXQL04p0U23o5+V3L4+Vg3NHP8YaKJsHP4KjLdnsfOVCImkaqSc
 J6aFKr19kWWPoifJl1g+xHRD8fKJDpGEYL23Z8AxWOkakjP3UTOr1Zb5K4SYyKGL484e
 Bg+pCSsJin0xOIlqyvw+SQqZxG+nbiqFqN2dtO+nd9jwO450OQX7+uQ8Fe3krGSasmai
 lJQSx6qDcLH+gMjpi9LkAiNw5yAjKuY77jMT4W1f0TYG/s3vYUvXbkqfF27HU+es5ABB
 oZP9kRa0uC0n7vdyRcG+xmPqmSba+ryV02XKYnlyAMNkopLhDRRVz8Dxc8jhhPZZR63O
 zNhg==
X-Gm-Message-State: AOJu0YzV4Nu8X8YJ+hRx7yf6eBhC/snJpK4/O3DB/cSaTwBTzvvKf8dt
 qo8I+0gbRTkH6gzjmY4j2xIQtEB/7q3+OOk1MtuE+LoTUh5O34KN+SSyajqKaXLCOK26wR2cyvb
 7
X-Gm-Gg: ASbGncsZcGeGU708lH0synUj6hcKziJJoh2AEuyxPewR5X3NZ9IJMrQJJnaL6zi1XVR
 UP/TA/LXjGLBpAzj5m2DkWu8F6khYp5lHd28DRm/fs0rdROrHJvhOFoUyECEDAQqwBYJKnJ43Zy
 GlLYyBzHv9vxi/gmC9rrCOvcrNy3aFBL+FMfF7oebm0AiwayNzQGze6OVyap9ZvIvsUHgUvWGs2
 MqtrYdpIY6lhg7KHH/kvhFfQRR5oBmGXeT8MTTVqjeinTnlP2KE8pvdqXxwIei4xMrL0wKjB59/
 oQjDFZTF0yP5IvrUQNTHnHmKX7b7PN9Vw+LILpHAcO4OvMI=
X-Google-Smtp-Source: AGHT+IEEjVJ/kWBfynp0EQUl53uERQFDTLOp1xHgMCvZRu+Lnf0SqzG/1efzi3fCqeVJxWQzDaoVrw==
X-Received: by 2002:a05:6a00:3d0f:b0:732:4c47:f807 with SMTP id
 d2e1a72fcca58-732618fa196mr14649336b3a.21.1739820619502; 
 Mon, 17 Feb 2025 11:30:19 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/27] target/loongarch: Use VADDR_PRIx for logging pc_next
Date: Mon, 17 Feb 2025 11:29:53 -0800
Message-ID: <20250217193009.2873875-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DisasContextBase.pc_next has type vaddr; use the correct log format.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/translate.c                   | 2 +-
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 3480f54c71..e59e4ed25b 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -289,7 +289,7 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     if (!decode(ctx, ctx->opcode)) {
         qemu_log_mask(LOG_UNIMP, "Error: unknown opcode. "
-                      TARGET_FMT_lx ": 0x%x\n",
+                      "0x%" VADDR_PRIx ": 0x%x\n",
                       ctx->base.pc_next, ctx->opcode);
         generate_exception(ctx, EXCCODE_INE);
     }
diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 974bc2a70f..3d70d75941 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -56,7 +56,7 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
     if (a->rd != 0 && (a->rj == a->rd || a->rk == a->rd)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Warning: source register overlaps destination register"
-                      "in atomic insn at pc=0x" TARGET_FMT_lx "\n",
+                      "in atomic insn at pc=0x%" VADDR_PRIx "\n",
                       ctx->base.pc_next - 4);
         return false;
     }
-- 
2.43.0


