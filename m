Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EFBC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0V-0002VH-Ln; Tue, 25 Mar 2025 18:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0G-0001Tt-F4
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:12 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0C-00072d-MP
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso127172505ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942647; x=1743547447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP1/YoZtmNlvDfK/7GvLWQk4iAQ+/s3R4pyDEvaptyk=;
 b=z3MuKUL8R610AmnUVQnnfoUul6I09LrP6+xPBJCffXlM7XzynQmvINOV9Iqat2uIV+
 PYsvu1EBDihLN+1vR3jnTheT9oHgyh4wTp3rKeKaholFcbJrkQ/lhBqP43yk2tfYHR3e
 pyEMonI9sTB8yMbbcgH6Y2ZyCazmUVv1k0YQGURkrwbP0RTTJbcOFB1924uxbdwaBKj8
 DS15E0CeG1B3NjLSdluYrwSme/9jjeLkKb+iVasYWUZayxMczFq5v67RtIiHVC7NfESW
 EgO5FvmgRksoq1dEeokPavO6xnzaHf3nLN77t0PPRdJfl45bG7F4jhYLG69jP/+yQ6mu
 FNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942647; x=1743547447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP1/YoZtmNlvDfK/7GvLWQk4iAQ+/s3R4pyDEvaptyk=;
 b=UZhasAFYQkzlsLFwD1jstijtbBJIrozdyFEAShx2Cej1JlAqWdBrxrv6AJ4QOzCHy9
 tQtNuLiHrWSMwmT4+4xzALUSUbAOeAalJTxf0C9+NktiBW2kq7+AvoNmrcov0TFMhK6S
 U0u0RFDKnjcP1T24ni5l86v3inR3/9m0bFSZEfgZfpfeuLhJAKa2qDCI8dthu6IJpoxU
 cGlQL4XM8JQpQ7x9mvKkXR7Q2V7M4oXMLsqPgVxDWWhqpeOguJ43rhSYVBYdgSsTqq4E
 Dg3tLmcSCNIzOUrePFSG1J/AdzzC0Pqv+UdLIHjMGmscO/HZ9s9jqu7oNR52M5Ci9W9F
 Nj6Q==
X-Gm-Message-State: AOJu0Yx+9c3vC7EqYzXgcFQkqnvfS+BVjXBqNbmiEm6Q22h3oBTlu4Wj
 PV1m5UNf2s5DhtYTXAXQpFzMl7+VWjnYT0ztuB/2q0F03gi46SLsCl5IlmTr05FPThI0Z/D9z1r
 0
X-Gm-Gg: ASbGnctmB0hB58lHPH3O8ddlHzRRVf6FDnH81iErgvLwWTlnMkPlyjA2XSa7OgfWGE/
 IkHMtS3qIOCG6KTIkQnNb7jl2dLOyh/VOuh3Ql5IJcv2oxvvMfmEVAxKX0LEZnlC4jADplZ3ImP
 RnvuAQ90dK4a9Uy7CRJv6uL/pJvMQBDwLLvO/MfFZJLYWeD1sBI62TR2PwBfJS8dROTVzPU+ZJW
 luvs94VRMsw3xJB08RxvZEt0O6LdiylIDjOKeBo4ttwPdwrJQpn05jtEZZKth6iRdAw2ty2rW/m
 bUCic+88pYm6hvaGtRXTpeA7plv/fNzQrRkbfI753icZIdFheIKq5aPcYHRrmhdUU/aUCLBDIzz
 LRkLdT3u9S9A=
X-Google-Smtp-Source: AGHT+IEXfQ8MaK3uGSzdmc4hzEM4xER01btUhd+yn5FrwCtOOjvoRd/HgC0pKaFssgBZQ8J2qv2eDA==
X-Received: by 2002:a05:6a00:4fd6:b0:736:fff2:9ac with SMTP id
 d2e1a72fcca58-73905a2780bmr29178545b3a.23.1742942646941; 
 Tue, 25 Mar 2025 15:44:06 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 03/11] hw/core/cpu: Use size_t for memory_rw_debug len
 argument
Date: Tue, 25 Mar 2025 15:43:55 -0700
Message-ID: <20250325224403.4011975-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Match the prototype of cpu_memory_rw_debug().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h     | 2 +-
 target/sparc/cpu.h        | 2 +-
 target/sparc/mmu_helper.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556..abd8764e83 100644
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
index 462bcb6c0e..68f8c21e7c 100644
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
index 7548d01777..3821cd91ec 100644
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
2.43.0


