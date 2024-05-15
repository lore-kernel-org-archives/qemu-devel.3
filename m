Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E41C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79S0-0004eg-4K; Wed, 15 May 2024 03:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rv-0004Ty-HM
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rq-0001de-4Q
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04e2so39976405e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759588; x=1716364388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OfPp6+r7Zf3NKTXpMRuMvIJCtMgZRIBNwDS9FcnyZQ=;
 b=WMqI9hQGNOVFL0sLwB/CM+TcgedPegvmOgyjvW/8qhuYztSmSuLSSC79zMPbxf1Qmn
 7TOOrl7uUOFEMVOQpOpJEq0YHqd3cTppBi+CGu0IjDtrk9R26hkYO1PDAyc9Dp6lVlMf
 VvN3gT4bQ5TzMr8M4QH1gNnBltFNkacVELe6gQVUuEBb4SL1s3mKLMVKVA1lj7cKEtbX
 F6pSM2dP1YA10eMaPUE3IN7brdjwBTDomMwsXV7ZKfROnDohbRSI0QlSlkbgzR2mIU5S
 R0FK1m0Ae4u30e44CfnKAsGKBtJbewHuar5FBheCNqtcvr/xXN39WtnEitFfp7sxLk7+
 XxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759588; x=1716364388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OfPp6+r7Zf3NKTXpMRuMvIJCtMgZRIBNwDS9FcnyZQ=;
 b=f/Rz2o+e7z2eoAAbVFFb55D7b0cSY89YRGI3va45JXYoHF5l8EZ6jSnn9mUF0zyEMj
 K2LG9az3yZ1SoKdFBTtoKXLMe7Byeug0QJ+sUyBDwBnvkAm0hgD3iJOM/yUptIgXNUDZ
 nDIY60HvnjCWOp0U/UvEUej8pBXHcDQspum2JEO2m2R/nWjblB72N2JXGxefB9IVWWJf
 /dS3Yj7Xd2q/vMRx8kRB8mW5nA9l2zsJiq0R+7C2hBkqhG1LWLo0JDrhE2kVB6fvBJuu
 qQ9rWVXE5dy+JwUKTU2kVaotNee1qgdnZa494/9e52rqb5Y9/NKizdg1c9BajqY/e6KI
 FilQ==
X-Gm-Message-State: AOJu0Ywq8SV8/3RHOvhbsCHYP1pEOjP6hw8fuAcCLau4Idua7Y/KH1WN
 cb9dyfAgUV/osSxcnNbVLsnQ7P6LAxMKzy3OvQr+PIvgT2KuSoJ9WHFE91M5/GEotlJ2MHp/G/M
 luzc=
X-Google-Smtp-Source: AGHT+IEQlDkr5WuAu1lurJV8ROi5DlydtsypbGiyYlSDnqLyo52JUi9WmuPvuwcqZPD0Q2Z3sdWiHA==
X-Received: by 2002:a05:600c:5718:b0:41b:3c4c:211b with SMTP id
 5b1f17b1804b1-41feab42a67mr102889535e9.22.1715759587870; 
 Wed, 15 May 2024 00:53:07 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/34] target/riscv: Use translator_ld* for everything
Date: Wed, 15 May 2024 09:52:42 +0200
Message-Id: <20240515075247.68024-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c999e942e1..2c27fd4ce1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -20,7 +20,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -1082,7 +1081,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
 
-    return cpu_ldl_code(env, pc);
+    return translator_ldl(env, &ctx->base, pc);
 }
 
 /* Include insn module translation function */
@@ -1243,7 +1242,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
 
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
-                uint16_t next_insn = cpu_lduw_code(env, ctx->base.pc_next);
+                uint16_t next_insn =
+                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
                 int len = insn_len(next_insn);
 
                 if (!is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
-- 
2.34.1


