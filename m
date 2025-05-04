Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3766DC3ABB0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP0-0008Qq-83; Sun, 04 May 2025 16:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOs-0008NT-00
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:27 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOp-0006we-MW
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:25 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-308702998fbso3395354a91.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392241; x=1746997041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8L43VbOTrH9ZrSVatLWH3zgdrIKpBIl0F+WaJ9mYjo=;
 b=S5cpwdoex/ukUKFK1vSq/xBZMWoJj18HfXfm3YbZoI2oJjwbbsCdu6DV/JKpDO58nl
 CTZ1BGV8LT2peZ+144ywpzBOIggrAxhsBHeV9pteY55xf7fArZK+AKs6DhRDF+Uomym0
 QduKmRPGg3zaetJDXwXcSDQvftRCWVMb0A6xPX8robaHIrP4GLt3PDnzfeYnG7z9e2HO
 ezz5+s9DfaT8XZ9IVuWPjrKVtbxFeTiv358uspCF4Niq5fhBdJw0JE6emGncnPkhypW+
 rEP7FqrprUtlsC2Gts8vZGouDCg0TnJRnmtZcyeT8R1x30alSHT5unluI3tc+EZCE/og
 Yrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392241; x=1746997041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8L43VbOTrH9ZrSVatLWH3zgdrIKpBIl0F+WaJ9mYjo=;
 b=VaQUgRmo0xhHHG+MOU2cmoDV59Q4s3BV7ii8k5RyHh/ubihc2s61JJpVHva5+PZrb8
 oHPADS3DAhU2alBpVEivNZJ3YWA5t/obLjuO5sKU+7P5EwkrfjpIlS/7cXftEkqz+b/M
 ReOwceLN30vbEzzFGWdAtfp1E5AyvJ2bzqENnYr6CtvAeoIOCLVzB6Z/6boRNKHkVf0K
 6FTvX7/+kVOEVlc4ilrXOylQm0BgjQWLij5WYQPBSrgQaKWWlL5BaAJ1SQjMWEx48oYt
 2z/zFY4AyDY/5w4jOiE4O3Rl+GGV2aGpf1pL/MsN04pF92FvVh41/4sr8ycuMZ6b9mst
 mLlA==
X-Gm-Message-State: AOJu0YyvTGuKNAhffA02mKq+oy083d6YhAA8bOGeZJVoCX8vBfYTam4i
 R04+NJ3tGkzurBCPlAhoAcTLV/vSOHkfT8n4c75L+SbkfbEDX4o462A0PpUZhx3IRll1CasyQbD
 f
X-Gm-Gg: ASbGnct7CRWyJN7tquXccoXHvDt07HgAXORIE2fMnmEHNysI6dnwhmRJFWe8UfBS1EJ
 DzBMoGc0thGpwjq/0i/z/O85ors8iLFej9JG7EnTXAVlxivGLo3pZZj5Qsx0zLnNQ4VqhGDBoWx
 I8qhO3tqBbQfoqLki+v6WjGItYiBGsraie2fdQuagV5LWr40uRP1MvV0+q31N6PtnTvMmHJFCMh
 DZMMeq+8WnvhcwdTw276nQHj2wFrqP86s2YxWEqNf+D0m2uASn8ocLaT2jqLG7s9ZA3u9FHIFAT
 wp9Ev6OeykZUiisTwLjR6BeDkFlx0rfBh4jRvRLI+J6MjWeVxNxESq0pQwEWObQJK2lhhK78XxR
 FtFDL//4bNw==
X-Google-Smtp-Source: AGHT+IF23gg7L34sDpvCSnxYen68JvPt+936XkM6Xl8ecMLE+PDYplACU5rVS/CIv8kfNTVRKA/Qqg==
X-Received: by 2002:a17:90b:3c87:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-30a6196f08cmr9084691a91.2.1746392241256; 
 Sun, 04 May 2025 13:57:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com
Subject: [PATCH 07/12] target/mips: Fill in TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:08 -0700
Message-ID: <20250504205714.3432096-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Check 32 vs 64-bit addressing state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 4cbfb9435a..1f6c41fd34 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -560,6 +560,14 @@ static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
     };
 }
 
+#ifndef CONFIG_USER_ONLY
+static vaddr mips_pointer_wrap(CPUState *cs, int mmu_idx,
+                               vaddr result, vaddr base)
+{
+    return cpu_env(cs)->hflags & MIPS_HFLAG_AWRAP ? (int32_t)result : result;
+}
+#endif
+
 static const TCGCPUOps mips_tcg_ops = {
     .mttcg_supported = TARGET_LONG_BITS == 32,
     .guest_default_memory_order = 0,
@@ -573,6 +581,7 @@ static const TCGCPUOps mips_tcg_ops = {
 
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
+    .pointer_wrap = mips_pointer_wrap,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
     .cpu_exec_halt = mips_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


