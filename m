Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96635CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbRC-000290-Mw; Thu, 28 Aug 2025 08:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbR6-000281-Lc
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbR4-00079g-HX
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7720f231174so773388b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382937; x=1756987737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jt6xNOoMoilOu9VAC1hwFlkp8outxIc7YKLXOAVEdWY=;
 b=aUizyAgE7yGfVeBQxWQ87fpN//BuGGvGG33S5EkIkvYYtCq0hid2dA8V+8kXUR6ghj
 96NxiJhlQt60dLH76s0+wM8ghFeklnLtJFnfR/JSXHGAMKiTZ/89hhkN4ThHRxKzaHKw
 pDRtSNxs9QGFZVq9MfR72Vr6NyPbpazzym1YITZtuCwyrlS3BBEHxNWRygwBBVbzZmH3
 FYYGQ7n8EiGuaN0zW7MOpgcNXh9nZmysJD3gImf2GIOpTo39WbZLKK3c6ppuFM4MNefL
 8WswSulbWrnIHi5YUa7GiUk5VigEjww4ULqq2iS0K/TR8OXf5KXxFc3HUbLrlIZY0ILB
 mlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382937; x=1756987737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jt6xNOoMoilOu9VAC1hwFlkp8outxIc7YKLXOAVEdWY=;
 b=X5ysBhdbYR+Jj0JGEo12B3A3gdRQp9dW/sTrWeUd0Ty0xWS79FG4keg7gG836ZL6b+
 2Qep8QLxicxa2jaznJ+pOGhaXOszR4ogavlpN9eFPir3kAreBC9fC0CJbnLmIIMvb9wS
 lCGNhcsGqtrb7ZEJAHxhzZdxHXJEuLR4dAkIquv4ZkelhOJgQKogwSxcZ37jpwwVsx9b
 VpiCMLscgAEVI3kUHT9tD7fr0cITDGWDTZmQgM+NOA192ocHzUO+MTySaWJ1V/+SjeRy
 DAcoN03Dl3L5pq8GwohBmIDApmPKLrFPB6REAYtMLC7syXJsIDE/2rFycBp9bl/57iZu
 k5cA==
X-Gm-Message-State: AOJu0Yy0haQ735kL5Y2zHeYKkd+YdtbBcxquOwNEhr25sIw/jTJVdoy7
 OqrAQUhTVIS/gYkbmkGQieXWbNAUItK8JNaadEpv8+EmGgu9z59OmbIuiZHk0L4FC75/KD5QNBQ
 5WSPBasg=
X-Gm-Gg: ASbGncv7YHi9lUoW2sL9cEMUeFQQQu+Ve7+pkKPw7HP3yt8J376ZP6h7zXXPL2U/VF1
 I6UnBqSOxxBnCZsvzQ9rTq4TZUOsAAPttIc7sbMLDgyb0EjYSF1gNQMWQAIFXzw9bRaShNAsaKS
 0lvNmeG6RW7iic740g8xun8UiK+YgFjdrDt8pcSzO4r79sop4uq/R9fNJXkoB44W2TU0RRW63wX
 R6m0sWNNrNmtaRWi9CHx+LLwuJvBDaBFRQRL32oEchXWxiLNrWYGNYNWgCfLKBJWdzy2GLMj35l
 RWYPy+A6HSu2S7BRk46dJeZyfxzhc7ozLMhDw3GPA6IbSxTFjtpyZI0ODUHh+V0lyPV+8dGtPB2
 vwe7SebTLKfXek2ZTGKFlpeGxAw==
X-Google-Smtp-Source: AGHT+IGu90kA88csSRSdHO+Xb1tNz+XDqPWhtDquf7G/1R/W4ldgpf4DRyy5UtWkBKNnYUJbMlVe8w==
X-Received: by 2002:a05:6a20:3ca8:b0:240:750:58f with SMTP id
 adf61e73a8af0-24340d91edcmr30379546637.30.1756382936912; 
 Thu, 28 Aug 2025 05:08:56 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:08:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 06/87] linux-user/loongarch64: Convert target_elf_gregset_t
 to a struct
Date: Thu, 28 Aug 2025 22:07:15 +1000
Message-ID: <20250828120836.195358-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0dd76937f9..1e59399afa 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -518,7 +518,9 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
 
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 enum {
     TARGET_EF_R0 = 0,
@@ -526,19 +528,17 @@ enum {
     TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
+static void elf_core_copy_regs(target_elf_gregset_t *r,
                                const CPULoongArchState *env)
 {
-    int i;
+    r->regs[TARGET_EF_R0] = 0;
 
-    (*regs)[TARGET_EF_R0] = 0;
-
-    for (i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
+    for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
+        r->regs[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
     }
 
-    (*regs)[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
-    (*regs)[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
+    r->regs[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
+    r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


