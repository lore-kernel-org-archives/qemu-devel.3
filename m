Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03E7C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JOS-0003v9-P3; Tue, 22 Apr 2025 15:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLp-00010i-8r
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:13 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLm-0006fZ-3f
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227914acd20so1911595ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350328; x=1745955128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eY3tVR1Ho6nb9UcI2ivFSVueJvDpQEAHEetuLect7PU=;
 b=CaOs1zQrLP3GO7sYjr9yaBEghwWrb/Bj14b9xeMF/2vWBcpP85AZtbMF5AZybMkhj4
 edSgyARnkLMaG7hyJe3W2vYk4H0tc2PYSvewPc4o0IjSWnRxJZIdMWEc4mctJFlrP93g
 /NZFC5b2OCSzdviRojvcHLA2i3Z3negpNO8JTx3nESX8ve8iFi+zTmQMr2ATZZYUgiuZ
 3oi0GoZkEhE6pyUYTU+sNicGopWByIoXfr0CJIxqiOYoBCjFg20uive67Nh93K77pZaA
 k0nyh+q27Ss7hxyYIDYkF+AudEkBfUJYz7ZL/BGiwi9IP5moqHsrGPaqSUSo49EAClj7
 P3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350328; x=1745955128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eY3tVR1Ho6nb9UcI2ivFSVueJvDpQEAHEetuLect7PU=;
 b=w5b3vriDcfJ2OM1p/dOc2O5Mv8eK1t7jTS9nDlYfR22c+9wGqFO282aE47TJmQSdCK
 vFW4vL88EeAOuwmQ03moC7wYZjHVEGC1pmO1qPYSvVt/z388ci36WnbVGFhuxgvorbVL
 v4B+ukLiHHgmRpCcTTpsu4lYkJcb+MGt/t2/KlIIz0r5WdZGHQAhyXujWpFdWRN8NZq9
 BottDw+UCARrm4nIEALZpUWHDE/+P5LgihOfR9OSC4GJ6U1O2T5vDMyLCu4opmsA8xtG
 gXUtIoXYKK1WITG81jA0pOHTNChFIg7Jug9uqVZ10dMDgzY6TrVRUuk99Z3qmkV/19ju
 Elgg==
X-Gm-Message-State: AOJu0YwN9fmPG3i4EB49ELbRp/b0+CYVcZ679K+wR0AZJGavN4V2YH3l
 WxMF0BRpWI2mP1wfE0aehXJQfmfBwcJ66nOdRWRmtFigb0XaaB/V0E2rJRIUXkqLJjirPVLhzes
 t
X-Gm-Gg: ASbGnctxY13//Eym23aCZyjL0V6Vrbh8hjMYTlqVrAmHlP5LZDisFXSEy+Z/lVVJ9yS
 H4HnRxmdkl1LJqY/tvIjLGmt3F4uJeUrncEhMSrA4GD92zVuR87Cad87+UuqygDeNfewkD+FGT+
 J73ZETH4l4iiFlR09yeAj69i/lYumstY+jyDdWVoQcVFuMf8PXh6R0w9LMSDZc9HYSHr/kIgpgt
 dy9mNlyoACJ2mSzdmpfNK9JL4MBFdzOqn4GkBF2H3QG2B2mOvEW06hD1ODisPM9S+w0DNIasEJm
 MGta0i8al0HqiMtnYOuHYm4CD2bkPOUBl42PwzDHFuhoMO+YqtCOYGXlS0+QhqXAkgkBmBckvsY
 =
X-Google-Smtp-Source: AGHT+IH1XuUKH/7K74RZSmdZPTIXr5pf8eKtb+uwN4z92vtHO05QFOG7gvQy0q/tgjGsfrqyJB1HZg==
X-Received: by 2002:a17:902:fc4b:b0:21f:7078:4074 with SMTP id
 d9443c01a7336-22da31974c3mr2742595ad.7.1745350328569; 
 Tue, 22 Apr 2025 12:32:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 073/147] accel/tcg: Introduce TCGCPUOps::mmu_index() callback
Date: Tue, 22 Apr 2025 12:27:02 -0700
Message-ID: <20250422192819.302784-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We'll move CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-3-philmd@linaro.org>
---
 include/accel/tcg/cpu-mmu-index.h | 5 ++++-
 include/accel/tcg/cpu-ops.h       | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
index 8d1cb53bfa..f1ca385d3c 100644
--- a/include/accel/tcg/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -10,6 +10,7 @@
 #define ACCEL_TCG_CPU_MMU_INDEX_H
 
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/debug-assert.h"
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_USER_ONLY
@@ -33,7 +34,9 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 # endif
 #endif
 
-    int ret = cs->cc->mmu_index(cs, ifetch);
+    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
+    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
+                                 : cs->cc->mmu_index(cs, ifetch);
     tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
     return ret;
 }
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f60e5303f2..106a0688da 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -67,6 +67,9 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
+    /** @mmu_index: Callback for choosing softmmu mmu index */
+    int (*mmu_index)(CPUState *cpu, bool ifetch);
+
 #ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
-- 
2.43.0


