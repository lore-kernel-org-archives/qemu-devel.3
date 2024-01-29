Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6B0C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6O-0005xG-FV; Mon, 29 Jan 2024 18:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6L-0005wR-L6
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:42 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6K-00058W-00
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:41 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29026523507so2726957a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571098; x=1707175898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0VyFnxuloTGEbgz18a76FD3rClrdXq5QXu0ykcKSCs=;
 b=dDu5Fzmg1m1j4TMzpFO5oBgSfAeYER55EUWsAP6AISz4GNTuOXsNLEQOpxBOjxfVeh
 OFKxHY1Dg9jM8v15c6yBNB4TqCnWHfZOAbkqsu3vQanHP7dydAWjulusS7ejuuEXj+fE
 tNMwJdjjIEzFzc1lzGc8M9N1tOlOuMLKvj2DNy2U53ahCPvDMiKJ9V0c70/bV3JXH8Hw
 lQ5hiurd1PYyXBZ0g7sx3HUeW3HlSU34NvcI6OIFnyeadNpNeeWBt3kvFBxBvWP3lkWr
 cr1kFYBK8mNfHm7+DkL5lR9iP3/rAuOeLaOhyCR04qt2IL1YePOFxEyhWnQXLqWu8Kpl
 faQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571098; x=1707175898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0VyFnxuloTGEbgz18a76FD3rClrdXq5QXu0ykcKSCs=;
 b=cg5nFdDobEIhj72E4H9kAOnOyrYHog9rQxh8NjowidbtGZKDtQpUfpjGG1Aiamk4fK
 DoK6lTFFSR9nq11sNGNNvfqWJgYcnsZGFYYGKaIvTSXIW8n9hU/i+vcNCXJpnhZxc9hb
 l5QyDCcl9k3p2XAEsdLyOabt+BF6Stmp+/Sw+ye3gFX6muvM3Ao1Piizyf5Q1twkAuQ5
 Wthmb1R4eVqSvNrLuhqK961JKaPE2Bf4/Yw1s8poBIA5KkfOfebszP8ifEBoXOWY+NXp
 Q4Ezi1T9Lq/E80lFLDnkucqrbMv23uqvxoiP7gGdGKr3f6lmDNaa7ctl72c4no6sojYg
 dmMw==
X-Gm-Message-State: AOJu0YzhbFPMEF0QYYWVhD6nI8Gw2jutirZQqxoZymkeAjmwHSwhCc/a
 2wb2rCuKsblDL4PA44HnclfWkEFwRopt5D1iDlDBX5xy5m0TQMrV7pXfDErgwEa74Vdb9Jg73cP
 2+A8=
X-Google-Smtp-Source: AGHT+IGw/8CG5ZBjwIZcWvlYi4Oa4Q3VTp3fsYs80/zzCxy2X/R2NxoC0sTGvcNQ4Ui7N9tQnWA/bw==
X-Received: by 2002:a17:90a:a512:b0:290:6c4:ad45 with SMTP id
 a18-20020a17090aa51200b0029006c4ad45mr4216647pjq.39.1706571098448; 
 Mon, 29 Jan 2024 15:31:38 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 22/33] target/riscv: Rename riscv_cpu_mmu_index to
 riscv_env_mmu_index
Date: Tue, 30 Jan 2024 09:30:32 +1000
Message-Id: <20240129233043.34558-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Free up the riscv_cpu_mmu_index name for other usage;
emphasize that the argument is 'env'.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        | 4 ++--
 target/riscv/cpu_helper.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5f3955c38d..9c825c7b51 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -498,7 +498,7 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
-int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
+int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
@@ -507,7 +507,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 
-#define cpu_mmu_index riscv_cpu_mmu_index
+#define cpu_mmu_index riscv_env_mmu_index
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c7cc7eb423..15f87ecdb0 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,7 +33,7 @@
 #include "debug.h"
 #include "tcg/oversized-guest.h"
 
-int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
+int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return 0;
-- 
2.34.1


