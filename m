Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2A6C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JR6-0001Le-Qk; Tue, 22 Apr 2025 15:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOp-00053s-NL
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOm-000719-IH
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:18 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223fb0f619dso64457265ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350514; x=1745955314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+vJSXjRAVXeTwmKub0ZXgQhIZDI7tyX9VxiyklcrIY=;
 b=wH31camNpQxcu4fzFuoL0jjPptDKjvyGV0cO1oRY1w7i9r/R5pFmrlhgexXgYljXo1
 hPKl2wTzEsbMC8IPGw2nTNbFn9UXGfj4KBt/9nt9kZT1APSre6QtcaqJZDBuFVcvoQ89
 WybwDhhjVnitwB30NCdZBaHrSoxBl4dbM0wZeSEXWSwOpqUpFRx0aVj4qfGlJ8QI8zM4
 A90BU79bFquCeVtEE/QGFbC6TgWjRZSGkgefKMxrjvToNY6BG+TdVb2hwcmKYNaZi0cs
 tm0mJkh/8mItxWCRyRWW6JEV6/7gpGcR8wNMxNyPrtzrdaWVLLiKbtj5Piog6vRoxrmk
 104A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350514; x=1745955314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+vJSXjRAVXeTwmKub0ZXgQhIZDI7tyX9VxiyklcrIY=;
 b=UodyfRevFJ1Whoq/+DSQ9rSLVXrkRgNZqfsG9X/8bJHgEIMYGe8fDxzLd0CG6judaG
 wR+VvPF/aa/Hvl4HNay1xusrIlWDtHJD5KiHfOrid0fmDJwoO/Sb5cqRyoX0gXYAhTbg
 n4nO46n3kDZMn5LbKaVC8KRerpOkAxBMm9aL3sbqkI2nNS6AchhZ4k+R6qCertWqWRME
 LfGyeIjI7fj7gisPdwFpjNQ6FcChdo0xLOEOVhAwrWxE23EMxElbSpFqM4DMcv6rKZbR
 WTGa9vpPEXC0Um2Zhrh8jOX1pwEg8HF2wf9MTn7FZKw9SX0E/PANyjCwab+ITPppjJvP
 hC3w==
X-Gm-Message-State: AOJu0YxtKezbER9c0JgIoxEMgUm5aePuH567cel9yAi3jAB3dM1HISTh
 5NfHxHnPXPbL5S4xHM1X7aMEQW9Y6Vcm02T9NTtj52Cm7GUVcAH/0hj3i+oltPAE+CGR6o1NvAv
 6
X-Gm-Gg: ASbGncts/SoDQlU5Cui8/t5VDKRCASzIigAAi6INRoUm4xJEqhF5AJgwD1ZoeDko+F5
 lD2GSgYWr/iAt8UPQOefYXmKXCE4sdxgFiFqxN7CzfQS7muN6h/2y1/9l9feYWJqbwIMSIUB5Dx
 IWBcBvrpUL8wxPTSAntYU3efApWkYn/gZ5a5miPgMQLA1SkqwSxdTWh3k6gkBXvdy8tMrnboSs6
 ApxW/G9a11h6p8MI0vcpXCDO6YNS4QbL6Juummw/abfINRkkOE9VE83DfF+i1i83Uu3MqyUW8q6
 IfNUN3cogaYDsJ/jdtHtTFW/9KP6cL9THqooSEyUCpqImWKJLGOWkylNPCilPgykb8+eu5kOWmk
 =
X-Google-Smtp-Source: AGHT+IFS/ByEtNVQRb9zSUknmn4aFgJ/UT/pXCaUkT2WSldojiOb5ou8jMJqmaVhRRBDJOf9CHQTvQ==
X-Received: by 2002:a17:902:d4c2:b0:224:de2:7fd0 with SMTP id
 d9443c01a7336-22c535b2b3bmr236328885ad.25.1745350514029; 
 Tue, 22 Apr 2025 12:35:14 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 081/147] target/loongarch: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:10 -0700
Message-ID: <20250422192819.302784-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-11-philmd@linaro.org>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ea1665e270..cb96b17911 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -868,6 +868,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .translate_code = loongarch_translate_code,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
+    .mmu_index = loongarch_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
@@ -919,7 +920,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
-    cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
-- 
2.43.0


