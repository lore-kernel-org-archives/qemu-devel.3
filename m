Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB48C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRM-0001jP-KZ; Tue, 22 Apr 2025 15:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOs-00054X-78
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOp-00071j-Or
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:21 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223fd89d036so69452925ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350518; x=1745955318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTmftL2su6jwrf+15dG9AUJcmzSAFqQvTSHtk/3sj+U=;
 b=B08RjbiH8y8/3G6mzimTaWpak4VNv6I0K9M9WfQ0QWBRkYEGenSsOrU+cgFKZOhUYJ
 H+JYiKiHXCF436K/46qBRh3ZQybO9Z29XClYdJ70E51vbOm6ZFlEiK15J7TBUTofn/1C
 kW24wsGjcc9e+Z/oQu07AO57hWhBpC5bx4/OUDLMAIslhd7rCugMVb2VZE37r1JbOoYe
 xUCgQNW4dZVfb9Z9InxASuApi9OFtCTHe6XSSJLbDTTkPkr1j1K1PzsRU/Ufanr4ReJJ
 +iDVZUKhJauPyw7GycJMUcgkQiptSY10pi1VtKntMbGsmFXvZK9yo/l5PJNnQ2MVSgoU
 0zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350518; x=1745955318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTmftL2su6jwrf+15dG9AUJcmzSAFqQvTSHtk/3sj+U=;
 b=xJvmpooxkYl/kK5D3Y5/fPh4ITWMC2LGCQq3RDdj5nekSRKuyHCCQRYSZN76Q9KOJl
 njrsbtKkbkeW7OpQ9ts4V1dU7e868i1zv2VLVv9WrehrYO8+cglyIuj8U5NzvRVKXWcw
 6P/4j99BwoIfetgLBsKJKjYC4xB7Tvdbg3kF7Kjmrf7wi4nBf2hxW6SH2KP6YaZY2JWg
 O9pxYWbe9SsIyoH0UpPf1RDqKs7qrI9HeZ0zc4Ovi9RFkGwJCZYw1B911zAOtQjs2RVj
 bqnpfRIbEOtYD8XsxBPt2h94Nlz+gHNqU3itJ+Mz8BmT+iW7Ie/30tPV+w/WbgA7Ux2X
 btmA==
X-Gm-Message-State: AOJu0YxPx4HhmPpgMKOVuy3n2v8Mneir1udKAzb4p2sej+/z1JrN+Gw8
 8ETh5O+N6y6kOFryzLQa3F7gzW7fMfF0nPsh5fXSrOEFiK2ujDsJveNwCJNK55ekdffA7vo0eek
 h
X-Gm-Gg: ASbGncs0pqtnY9NcnAD+GSRUvBPFwVOmjahTMEjzFjyNqXtESuPBizm2T9kze3V3iK5
 XDfcNJbIdB3IBCL/zglftkDerG0vY9n8K03UgBZ/GMsn+J7fCFgTROEbZ5m3E4ljjyAkYWMw8Pe
 0KqhE0cvccC/W4I6IE/ysvQbDckNp8aHBFSuVMw4xLmVglIVDRPsQ2/RsOJnkHhabB7gAjV42fH
 VgsWA3zC0oI08ir7e5p4bz3UUMate2uq4/4izAGxgWEkzj5qqx+Cnqg9PjbxNwvrnLE87nqC1D3
 AzFVCGiwXjwMPUDc496U4moDu1SeJJogPQ7fsgEe779yu48Y5Ooh5GIo/pEVNTYG5AciX0h3dQ0
 =
X-Google-Smtp-Source: AGHT+IHVRcBggYCd15MgK+/IdR7680RkscSm3Pdu3FoGqfCXXmEKEh76FfMbB7qbpaUL+BTV05Hx3g==
X-Received: by 2002:a17:902:ce8c:b0:21f:4b01:b978 with SMTP id
 d9443c01a7336-22c53607c5bmr255596385ad.36.1745350517832; 
 Tue, 22 Apr 2025 12:35:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 087/147] target/riscv: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:16 -0700
Message-ID: <20250422192819.302784-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move riscv_cpu_mmu_index() to the TCG-specific file,
convert CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-17-philmd@linaro.org>
---
 target/riscv/cpu.c         | 6 ------
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a..430b02d2a5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1021,11 +1021,6 @@ bool riscv_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return riscv_env_mmu_index(cpu_env(cs), ifetch);
-}
-
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
 #ifndef CONFIG_USER_ONLY
@@ -3049,7 +3044,6 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->get_pc = riscv_cpu_get_pc;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5aef9eef36..bee7dfd803 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -91,6 +91,11 @@ static const char *cpu_priv_ver_to_str(int priv_ver)
     return priv_spec_str;
 }
 
+static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return riscv_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -138,6 +143,7 @@ static const TCGCPUOps riscv_tcg_ops = {
     .translate_code = riscv_translate_code,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
+    .mmu_index = riscv_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
-- 
2.43.0


