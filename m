Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919BFC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPQ-0006DI-OZ; Thu, 01 May 2025 17:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOo-0004ZH-I0
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:54 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOm-0002BR-9k
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:54 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b12b984e791so1268048a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134690; x=1746739490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jS8XY9JGqBdyz2cH3mTsFmqEBbkq7c0hUNDy2FU3g/U=;
 b=unwMRDQYJd9LKNq3OhvjKL2/IMrO2grOLLx1uuhL4PI7facdgfnKkyXnlPUx6ty7wK
 7nNUWYOfnMqqOlGTH1j+no26bbkOhjQjfsuzF4vShjxJsHwPbJF7+PqbmX8rXFKvMXnB
 3+YBr1FmhvYg9rldW6pX1WIsRLMAd//J7IjiDy+bZDqvPi0I8cFpxa/CUpgXifUCaHpC
 P0pVyIlqAPaTRzqhq0ZvRwtLbU14ACwVNjRAZvrFrzYQS9UWQ5s+BWQI6RUf9UeSvd3/
 03lIbhfNpzw4wZaoeWHppA9PK37scgPPVuPH3XEmIE7sKDKNY82LwREmK4xqrD1c8mwV
 WZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134690; x=1746739490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jS8XY9JGqBdyz2cH3mTsFmqEBbkq7c0hUNDy2FU3g/U=;
 b=Dkk3pP8H+imdVKz6Fv51eIqsoDi2mF3uQ9eub2mCGwfclDUQwK+vMoDWdw6VDJrCpI
 X7nJHg8+HE31WAwaVHd7zeYtFuQ7ArKR6BUoWnyXcZZsCUJeRYDap2ZzFZYkvh1zxzUv
 sZpGzL2hKJVFqcP2b3ADAj75e50uwo8KijFDM+nRRXHtm5GsUzxm+iXCt2Vzf7TxNpr0
 BhKkokgFCkOTfHzbIKHgLQngzMRVhVCUMTHECRPneQ5bBuLv98kXCK2pAtxuuGaRHYXo
 plZpkUp90SElNnssO4BnlWJLOU9/24f6GpNzkUY2HgV2TwomZd/Zk1i4h6yjdGVnh5aR
 /bGw==
X-Gm-Message-State: AOJu0YwEFesCL8/OEfc5hd9re1rh5bwGQ4WLdOAt8fciFQY+GXVDqJS7
 q5yTO/JTftwURd9zm2LG65af2ipiffinWK9c0DFKgrPVaNxZI5scXkCfpmnae/AO+Lr2UqTwqf8
 F
X-Gm-Gg: ASbGncsVe9cReTDEs/aO4UZl9JtUjdR6p6oMfgzqJznmDd+o0tqdEgcqRRwx5xA9BJ4
 ueYf70MT021Ld2rjWTd+8iU5kFFTOKANyDvFxfs2wajIMTiixgtKbeksuV+cfHrNGOBJ+C4bQw1
 vBWGvjvG+fkqwabOGrvaHVUh/fdvHHgOv06hT7lj2BfBW2gjwr9HmPrnbRNaxu7jRsWfiELlAkr
 bDrODeDPBDT4saDNeOq+87COIK5RzM5JDAuUpmRNOWSmV5EDhqT2NWSs3Ikv+vbwvHKj4B45FYA
 JxJZLdOx18cJU5muLdvX4lZ9lg3GKYrUppbGb9Ffqa+gV6RNRrPesT7IB63WB+lDHKP15HKYVRY
 =
X-Google-Smtp-Source: AGHT+IGhjtPV+x2Ly++JUDH/knenrRgqxn9fjYhTeewbuSe3voXMidSiTyg+9cN/GJZvThtRaNhuKw==
X-Received: by 2002:a05:6a20:ce45:b0:1f5:7280:1cf7 with SMTP id
 adf61e73a8af0-20cde958af1mr608448637.16.1746134690662; 
 Thu, 01 May 2025 14:24:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 45/59] accel/tcg: Use target_long_bits() in translate-all.c
Date: Thu,  1 May 2025 14:20:59 -0700
Message-ID: <20250501212113.2961531-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index acf32e6c08..6b6e10be9d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -54,6 +54,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/main-loop.h"
 #include "qemu/cacheinfo.h"
+#include "qemu/target-info.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
 #include "exec/icount.h"
@@ -343,7 +344,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     }
 
     tcg_ctx->gen_tb = tb;
-    tcg_ctx->addr_type = TARGET_LONG_BITS == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
+    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
 #ifdef CONFIG_SOFTMMU
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
-- 
2.43.0


