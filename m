Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F84AC369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Kth-0001h0-B4; Fri, 25 Apr 2025 11:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8Ktf-0001fT-Cr
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8Ktc-0002qS-6r
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso2015966b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594598; x=1746199398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gj1TznuRCvGs0CqAqeiTcoQslN5U+5zXVdqj/kfvErI=;
 b=KB1mvoOpcahpai4bRzMx2zi3n+pKeW82PlJawGwMV7yXEYgnPB5u6q2wLkTT9i/O/Z
 EVEZDfAEcQwIO51tF527kmhU8T9gO1JBnA0N0+9saNJGCICPog7R9ONsWHuejILn6DI/
 Ez5Ai1Xfz/kyUPMLFlhGMXH2okXPcYmDbeRRdOd248reC8bbwytnsS0qOJcphg0+JLt6
 x8n2tF4ZtFWUkR3H+q1XYMzEr2LflNP2MoC4sO6QdIQwZqIfxqJUmAGsiZY27qtQi6bc
 Tt4aMSKKqyQPHXvHM2A3R7HUWYx42K620n4Tzf/oDF151Q2Cz0lbLkKRLfCKyD1AMzwZ
 kt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594598; x=1746199398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gj1TznuRCvGs0CqAqeiTcoQslN5U+5zXVdqj/kfvErI=;
 b=eGrI5VBq4QfWspNYtVx4HYgdcjLHAyUi9MeWGNpABy0UNM0lzay64t53ym9GyP4XRy
 Ga+7PzTqWOxy0dLLMLK15R7UlijCzdXSTczdG9+qstuH+MzJOgmo55kJcp/8iW9LsAqW
 jz4jU2jmjQNsTNIuHSiJZo2Ds9ii/gmItH/okkjMF+8lH0fHpx7eM6OD7ae2oIaxVniy
 aXrxW4XVQDo0loaNs2wGnYShtRuaB9/+lAuz0+f0sfgTJejIUEQpi2O8LDeKH851n/oC
 WLQHwxgkBaWap60EZdzu6RBxZCwBi5rv2lww8vsTyq1L/X5JeWVu1nv3wLWP2KftR19q
 S3+A==
X-Gm-Message-State: AOJu0YwnCsXgjWscCHyNVbq7j4Dd0xn/ZSBCQTFbmpgmmR26ExKljYWM
 CieV5F6qWBzD6h4N7D+m5chiI/d1gYyTO/Cq95JZqjw+Owv+Yse2wiawPFnZP0GIyhLgHbCfCxM
 f
X-Gm-Gg: ASbGncuExrPOXriO8ToLEevUdBHzIw7ZI5UAxDx+aORvQo5ru4XGJmi/rnLt/zioglZ
 eEdeUas91zdDQBQt8sZ0A6oILyzsA15fjFEz9gE+vk/7fPQPOy1hP1x081/ZyRG+yDgRiDLPAEY
 L4aybNuf5KbI9rE7KzSyvEtP1LdKuueorelpVRdY0sAUhjXuvHTLIevLXpUb2ClgYXlEII/SQPJ
 /nJ2gOE5o7yDGj65tfotlB3GFtT6VrVt3NlGo3buN92gy95KKLa03DGYQqD8rntunY0ompvOTDh
 bsCLPFVvjrKL3BHOZjA3AXpqtGesJJLf5AkGoWziYUSQEB2LLcMbyviAp1bf2eUXvWlkrjbHS8A
 =
X-Google-Smtp-Source: AGHT+IHlpTJ5GWn6gG2zhioZwB3wxKSuwTAio2KDzURoJmoOdGD1WB6S+fGML5Si6lQzViQU+sr9yg==
X-Received: by 2002:aa7:880a:0:b0:736:b923:5323 with SMTP id
 d2e1a72fcca58-73e268ef417mr8849538b3a.10.1745594598552; 
 Fri, 25 Apr 2025 08:23:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3390466b3a.106.2025.04.25.08.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 08:23:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
Subject: [PATCH 7/7] target/riscv: Fix write_misa vs aligned next_pc
Date: Fri, 25 Apr 2025 08:23:11 -0700
Message-ID: <20250425152311.804338-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425152311.804338-1-richard.henderson@linaro.org>
References: <20250425152311.804338-1-richard.henderson@linaro.org>
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

Do not examine a random host return address, but
properly compute the next pc for the guest cpu.

Fixes: f18637cd611 ("RISC-V: Add misa runtime write support")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/csr.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a663f527a4..85f9b4c3d2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -30,6 +30,8 @@
 #include "exec/icount.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
+#include "tcg/insn-start-words.h"
+#include "internals.h"
 #include <stdbool.h>
 
 /* CSR function table public API */
@@ -2099,6 +2101,19 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
+{
+    uint64_t data[TARGET_INSN_START_WORDS];
+
+    /* Outside of a running cpu, env contains the next pc. */
+    if (ra == 0 || !cpu_unwind_state_data(env_cpu(env), ra, data)) {
+        return env->pc;
+    }
+
+    /* Within unwind data, [0] is pc and [1] is the opcode. */
+    return data[0] + insn_len(data[1]);
+}
+
 static RISCVException write_misa(CPURISCVState *env, int csrno,
                                  target_ulong val, uintptr_t ra)
 {
@@ -2114,11 +2129,8 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     /* Mask extensions that are not supported by this hart */
     val &= env->misa_ext_mask;
 
-    /*
-     * Suppress 'C' if next instruction is not aligned
-     * TODO: this should check next_pc
-     */
-    if ((val & RVC) && (GETPC() & ~3) != 0) {
+    /* Suppress 'C' if next instruction is not aligned. */
+    if ((val & RVC) && (get_next_pc(env, ra) & ~3) != 0) {
         val &= ~RVC;
     }
 
-- 
2.43.0


