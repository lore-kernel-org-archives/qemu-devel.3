Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A647C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMJB-0002sx-Q2; Thu, 20 Jun 2024 14:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKMJ9-0002sG-VD
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:14:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKMJ8-0000Bv-Aa
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:14:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f6559668e1so9333025ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718907288; x=1719512088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuptFvL2/Hy787+4SKwmAONPx69cXgZ8qPSFH2rsqCc=;
 b=YwVmrqKOHE++C5g9DhO8xYqLdelZvBpC92StU7CnBQIokI72E/KTz7NR814czggL8g
 QsclP9s81r3CM0ZqCzfekkcX/biHy0daE9MiIORwtEzaR75RdLZGot19tQGHLLGV32ei
 uOVrWJ8AufrtTPyoB4FP5CHWrkK/FPrstpnet8zHK+/gBOg3znBtI+iW7kV5t90Z8o/j
 bkr08ZozdZ8NPXZ5FgV3S7/ScFEsGcgVf8vRb1QjdAcADvPJf5tsWfWk+MUJ8DiUX+I7
 WNVaZRe9y/vKtiLiFgGs5Mrezscn8NqO4vLyowjAKhUeIRh82fb/s4vj4KdborYN4Q3u
 vGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907288; x=1719512088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MuptFvL2/Hy787+4SKwmAONPx69cXgZ8qPSFH2rsqCc=;
 b=udLeZl3aQzqznKnC3pqYRidZ5MMV7hXqCrfhLAfTAqnmGaGfpoggBKr0ysLqrTYd8G
 76YID/OefGyIJIfP6AMqZGV3WSPMY1xmxzzZv83JI1jIrOX7qUuAg5eFYGl3fmgk3MCS
 FuhSvd+35wxF7gNpooTLx9/Q6zvFstIhm5v3QQegocIB4Kz/NqBgntzKWpD7AQrHKCX7
 t0jHk0xp5h/kSAYJYEVfIp6iuQLdaSl+OAiJRH4SeuPQzuSqUdv6qZ7l1ZCztbPlHOZp
 sh8cS4d5YVrIOK4HKhOstaI9ACKyEQvTYBtKNg8VxEmtxgbXkKA5skUJFar8KDa+qoFZ
 Pvyw==
X-Gm-Message-State: AOJu0YxhOEeuVHsyxthPLIgCN8FkC44fUwvmeR60d+zyjBFQZ3E4Ddao
 Sd+y7uRhbZFU0uN7DixRSZitC3O2xd/R40tzFXg/r3kD1wcJhOrl6KBsEbITDAhhMD58Zw56yUt
 7
X-Google-Smtp-Source: AGHT+IFKI/jODsjblTkC72Fv2qKZbwT8R0CYCUpbIaArJmVBQdlF3G82LmfCa5udVQildFRK+44hdw==
X-Received: by 2002:a17:902:d50a:b0:1f8:6971:c35d with SMTP id
 d9443c01a7336-1f9aa47e82cmr66637075ad.68.1718907288059; 
 Thu, 20 Jun 2024 11:14:48 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9d6b7f403sm13628255ad.200.2024.06.20.11.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 11:14:47 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 2/2] target/arm: Enable FEAT_Debugv8p8 for -cpu max
Date: Thu, 20 Jun 2024 18:13:52 +0000
Message-Id: <20240620181352.3590086-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620181352.3590086-1-gustavo.romero@linaro.org>
References: <20240620181352.3590086-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x636.google.com
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

Enable FEAT_Debugv8p8 for 32-bit and 64-bit max CPUs. This feature is
out of scope for QEMU since it concerns the external debug interface for
JTAG, but is mandatory in Armv8.8 implementations, hence it is reported
as supported in the ID registers.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/tcg/cpu32.c | 6 +++---
 target/arm/tcg/cpu64.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index b155a0136f..a1273a73a3 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -82,8 +82,8 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_pfr2 = t;
 
     t = cpu->isar.id_dfr0;
-    t = FIELD_DP32(t, ID_DFR0, COPDBG, 9);        /* FEAT_Debugv8p4 */
-    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 9);       /* FEAT_Debugv8p4 */
+    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
     cpu->isar.id_dfr0 = t;
 
@@ -93,7 +93,7 @@ void aa32_max_features(ARMCPU *cpu)
     t = 0x00008000;
     t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
     t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
+    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
     t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
     t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7d4b88d787..d011755753 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1253,7 +1253,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64zfr0 = t;
 
     t = cpu->isar.id_aa64dfr0;
-    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 9);  /* FEAT_Debugv8p4 */
+    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
     t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
     t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
     cpu->isar.id_aa64dfr0 = t;
-- 
2.34.1


