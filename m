Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C471BC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL80-00028s-9a; Mon, 31 Mar 2025 15:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7r-00028N-MT
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7q-0003LN-3L
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:51 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so4283946f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450528; x=1744055328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjfZMqY7kEtNVcowX1vqYv9wJwb4LYxFTdGWnR4E878=;
 b=zY/r19jOqiekSPTxVN998fKv9+qk2Im7py0eYIpkwioNd175VGcPKsirv+6uc7ciNp
 Kjtv4j22e/BAT8q5W+2RLI5wXyXRChBA2xB+3O2h1NVpziduvNc4VkIO93fpyAeWAdGz
 VFeNew4HeC1jdSEhGqbMAPJJIoGXml1P69sZOzcmLR/jWKU/SAyzDWdsDlSkKuZi36Yi
 YRzd5DiV7vxFCuf9DZTD6FMC96kKaqaPkn2u8zWexfioj5dJpK63TD+yVFPs0CGKN7II
 mIcgBBmQ4q0uf7YLgHbAp8SaXNLT+GeuVjrxp2FxIoJe4ZWbsUEZ5EOy9cKmmHLaMV9l
 p2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450528; x=1744055328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjfZMqY7kEtNVcowX1vqYv9wJwb4LYxFTdGWnR4E878=;
 b=Ymsg2kUTi024Csw78WAupgivgV4YeM2Ir4Q8LYFHEJAMnbCoq3cEzd/5QWeOyr3QkR
 qns39TlWNDf5HMnlYfxjQ5ah3pdyfnwP6UdbvAxav1w269Rnu00Q+nOkE6rOfUNth4+W
 9I/ABYkqd7Ax+7LrAJIxFNm5ycGXxkvwNYYPVi8m9PsxlDcYLeuNdfTlTY+j5FFleQd8
 +1PHbvIf4PTTo2kXeQaafwvmFNpX0ZF/3tClN44trT/19lkoNIqnZCeE3mfREJFV/jGY
 VhEEGRxhLrLKRa7yrAbCKbqCyDGmX1vpm0ke2pAuPiXl3nDb7nNUz4dOQgHSU4yOSr3j
 5Gwg==
X-Gm-Message-State: AOJu0YxLxCaKpjjuSO9A9PQdG1P9PyH/ZHLhiQWIX62VChaTBlWiTMY+
 G4of8FGtuKTbhbc/B+Uinpk43hMElNS0P5M9pi2f2y1GJM5IUEX8MuIbbV6UfmHtaWWG0TwEUtO
 t
X-Gm-Gg: ASbGncvDYfBlcePfg/ECNNysflEjMiZqsfmdO87pIkMPQaqsW/+B/GcZ/Uon01Q180m
 ZbaKQ7VYoVHnpGwu4xnJSQxSJpLuw6ZhzpG4Ldsd3+rjvljnS+1PLCxac2JlshxOkQqmCihZQQX
 z2axBDlsFwV0dPBBGKJPw/UUwAZgF7770JR5SETj24kFUZTf3AL0gYG2bFxhEcvlvZkAIxE2Oom
 6+9wrktTFRE8m7MZIaMEgWq2miamt3rgh6Sl31mMfLYYR12YyQ7YT9CZXnvq2SyC/1Oancb95CU
 5mqCg8dpr8+tUL6P7/9D68sh8mSbLewRXb1G6FeXm//hWZZmxi3QhZUNwlUVmEQgnjNm6PFYLTq
 OcRwAMgNUwpqi1D/mwbk=
X-Google-Smtp-Source: AGHT+IFVuRh6Z/n/bKcSOD4C6xxd7+fLXpm/gtS8wqzn2/xKTUCDamnCqfbuUE5kjN4LxV5jlTMavA==
X-Received: by 2002:a5d:64ee:0:b0:391:2fe4:de0a with SMTP id
 ffacd0b85a97d-39c120ccabfmr9021886f8f.2.1743450528197; 
 Mon, 31 Mar 2025 12:48:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e393sm12252633f8f.72.2025.03.31.12.48.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:48:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/23] hw/core/cpu: Use size_t for memory_rw_debug len argument
Date: Mon, 31 Mar 2025 21:48:03 +0200
Message-ID: <20250331194822.77309-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Match the prototype of cpu_memory_rw_debug().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250325224403.4011975-4-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h     | 2 +-
 target/sparc/cpu.h        | 2 +-
 target/sparc/mmu_helper.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556a..abd8764e834 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -154,7 +154,7 @@ struct CPUClass {
 
     int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
-                           uint8_t *buf, int len, bool is_write);
+                           uint8_t *buf, size_t len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 462bcb6c0e6..68f8c21e7cb 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -604,7 +604,7 @@ void dump_mmu(CPUSPARCState *env);
 
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
 int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
-                              uint8_t *buf, int len, bool is_write);
+                              uint8_t *buf, size_t len, bool is_write);
 #endif
 
 /* translate.c */
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 7548d01777c..3821cd91ec7 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -389,7 +389,7 @@ void dump_mmu(CPUSPARCState *env)
  * that the sparc ABI is followed.
  */
 int sparc_cpu_memory_rw_debug(CPUState *cs, vaddr address,
-                              uint8_t *buf, int len, bool is_write)
+                              uint8_t *buf, size_t len, bool is_write)
 {
     CPUSPARCState *env = cpu_env(cs);
     target_ulong addr = address;
-- 
2.47.1


