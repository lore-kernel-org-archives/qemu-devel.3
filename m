Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF4BC36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiJ-0007kc-Jy; Tue, 01 Apr 2025 04:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWi5-0007Iu-SX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWi3-000603-Vz
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso45559595e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495058; x=1744099858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tbBPJmAvAc99IgMdN0t2hESc9/XHhznc8n8w80Wh1ws=;
 b=y/DytJU6J49U4nNoMr+KBRVMUGD7eqPge5PNktf97obtGHxNtJdOuq81e52zBY7pqU
 jS9//xD6NAzP5fBgXJS4f/BGwuKfVA0xfBdcG7vZsVqxAaKTf6tdnyEnkAtxcuKIFX8w
 CE1ng3xawCIF4D6T9x7Q/5PcYhmvQB4Z/mKXJnBNxbuAs8jOJWYCAReUIyniSuImZc6J
 1A6wGJFNKUov0PQcIlAZHxArZxMIGiUOWvZgwFrcCyu66Y9/567XJjPU2d3ESYDolupG
 9cO3ZOyNuJ2ekZTAoFXoBku16LD2yTKS2LsJPYO4OE9njcb8YLu8yAMssVM6YmZkws1h
 rqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495058; x=1744099858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tbBPJmAvAc99IgMdN0t2hESc9/XHhznc8n8w80Wh1ws=;
 b=X9iRleuC9MRvAuZdG+lkXNPTquE8XQKT/KULkoqx25zg7dVzLt29phXZ1IeJXU7SDo
 52yJRNOQ5i/qzb0pNqpG1YAP10oJSsC/XzeGlQ0QJDhnbOWLwqWNZn6UR3zPZKmWpf6P
 E5F++L9sFtnq3uz1O7AznUY973xuddU+ClUpeJ0JDmkEf8BAM/hiqISFN1J8TpMlle0B
 5xv7RmmF/hn57CUZwhmzVT52iJWXSwOVEQhlTVA7e44AlNJldNknyjmNOyEqp4f5OFLO
 AymymXpKb0DgbsaG4LoqrLLR55rHEG/iXhHV7XsbcFqaCEEAewPAZAdKhxcQ1Q+XTsco
 Ox+g==
X-Gm-Message-State: AOJu0YzJLCo+Hsmuo5ficF/TlYz5l3MPDSG8PVfz36ctZGMWGIFcJrt/
 MzQtbEvlf0QVjKVKDICn3iB0eK/kdO89f0RVHl1tEeHqK5xJs/CLrObyuGQVvmu6YLM1ZS56Bft
 N
X-Gm-Gg: ASbGncuyiE8D6vItqAqIHPZNM4D4HrjqgEVOR3bRsSJ5VwsL6t4dltLj5GMfVyqNbcN
 WwE/zf7AlRzVB7cb2uQxSG+UwuHhpg4HEdJn0M6LXMSrgGjw94/DQvZcpkxLO9GJgOP20KaraoK
 1it2QmD//eVQqpPwcT89wD0YI83/W5tp+F7KG8hK1w1KEdlCKHLbzW2au+yqMUhMCcNoUudoIGR
 jlF1LrZjqul0fuNZyyyt5voKi8jCyxPuk6V4esDzcTQ176sqDCzozAKNVWFMeLUD2hlPVB3AxoC
 Rly+HZ88eK37BiqM39UlkcyM7Wi5Wys+4tIOJ4IPfAXltsG/bDlGYr1rtisAQbe8wG1MBOa6TOT
 wGEP0Ak8GPybDZKRCb5I=
X-Google-Smtp-Source: AGHT+IGprqswA2N264LR5hyFa8S7rBULUlrMNVZ71lf7V5W+Sh5f4yfrrcqUpW3CedQWs9EGovdqCQ==
X-Received: by 2002:a05:600c:1f10:b0:43c:f8fc:f6a6 with SMTP id
 5b1f17b1804b1-43e8e3cf6d0mr104299815e9.9.1743495058208; 
 Tue, 01 Apr 2025 01:10:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663470sm13368861f8f.27.2025.04.01.01.10.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 16/24] target/riscv: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:29 +0200
Message-ID: <20250401080938.32278-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Move riscv_cpu_mmu_index() to the TCG-specific file,
convert CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c         | 6 ------
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a2..430b02d2a58 100644
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
index e539b0266f3..710449d17e8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -92,6 +92,11 @@ static const char *cpu_priv_ver_to_str(int priv_ver)
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
@@ -139,6 +144,7 @@ static const TCGCPUOps riscv_tcg_ops = {
     .translate_code = riscv_translate_code,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
+    .mmu_index = riscv_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
-- 
2.47.1


