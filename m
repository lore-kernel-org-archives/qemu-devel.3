Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF11C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMJ9-0002s1-3u; Thu, 20 Jun 2024 14:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKMJ6-0002rR-Th
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:14:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKMJ5-0000B4-2E
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:14:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f70c457823so9460405ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718907285; x=1719512085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+l7hHWjon/08cVoPA+U9reWFWKg72VY3+sgSySxKiqM=;
 b=rPFEP0UWWckPF21zrsEzs3jN8CRTmpTLZV3MjgQwoVZSULrYnJurVr9btXoLUJ/4dJ
 3B0IHNnUF5hceQ7r9gkiLS1Q/20r/SvvQrrhLUMQ/70wekkTBFXUpPN5xB62xW3yI60a
 KvmitDkR9NwdvTkFAej+IN8MGEQ8IYzwwXLc6RsPu0+NellUBAaxZTj27xhXHTN2M26O
 6v8811egbTp0ryXrazqR7DR5QeihSFfLdIHCWs6Ss8HGd96rPkiFYxDSerVulhW43nz2
 1wPaTibkRu314GHZ8SaFwviI93MrnbagfqCnesw1Dxb0E6+xqq5RTucMcIZnWt5rK8ZB
 xYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907285; x=1719512085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+l7hHWjon/08cVoPA+U9reWFWKg72VY3+sgSySxKiqM=;
 b=oh8Dm4Rr75eS3+jE6FGGZOivcAJICL1NLNbp73aTi9SzcmQGL+6Du7sYgF2yS+Gl/t
 BO1Qkh5lVjejxZ1LZyc0Zg+ro9gOges6xMmF/dSS+IQG6EsaAo7x030zNBvQcqiLJzKI
 tbxEz3J8tKPcYKQV4HkSzcp0R2lubT6ji6UUN+02lWSCF2jFSlcSmaLk/S3M0harlG1C
 EChKAoF4IaqIiA8/Pc0JKKronu5NMeYXahRXmSuwXI7yOWuHOFEWKvi+1UJKYuPfeUen
 zHIktx2DrjKwJHkOFwDUpNUPzJ2QoED4e96C4xHYmyivuu88zuLQQ9lNoDogEg7IWh68
 pf2Q==
X-Gm-Message-State: AOJu0Yx0i4iedSST0/JcRmJvaEHgWcPVLdrjIjbsvfJhB6vgqLYfGD0k
 71jWVNsEpf0yBpSpuGY6zOTRGuBhRZWhowyGZbppqUJRw1snIcnyDABM+qDkFEQRSQsks5I6ZVN
 i
X-Google-Smtp-Source: AGHT+IEBk8ZXoPERnBXdp9j/kZjeo5hgUhal6WEsZ5gXyKe/hmjesEY/0JVS/NDKtky2vjUaG6HsuQ==
X-Received: by 2002:a17:902:e5c8:b0:1f6:5bba:f134 with SMTP id
 d9443c01a7336-1f9aa480f34mr62838355ad.46.1718907285262; 
 Thu, 20 Jun 2024 11:14:45 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9d6b7f403sm13628255ad.200.2024.06.20.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 11:14:44 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 1/2] target/arm: Move initialization of debug ID registers
Date: Thu, 20 Jun 2024 18:13:51 +0000
Message-Id: <20240620181352.3590086-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620181352.3590086-1-gustavo.romero@linaro.org>
References: <20240620181352.3590086-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x629.google.com
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

Move the initialization of the debug ID registers to aa32_max_features,
which is used to set the 32-bit ID registers for both 32-bit and 64-bit
max CPUs. This ensures that the debug ID registers are consistently set
for both max CPUs in a single place.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.h       |  2 ++
 target/arm/tcg/cpu32.c | 30 +++++++++++++++++++++++++++---
 target/arm/tcg/cpu64.c |  7 +++++--
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3841359d0f..d8eb986a04 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2299,6 +2299,8 @@ FIELD(DBGDEVID, DOUBLELOCK, 20, 4)
 FIELD(DBGDEVID, AUXREGS, 24, 4)
 FIELD(DBGDEVID, CIDMASK, 28, 4)
 
+FIELD(DBGDEVID1, PCSROFFSET, 0, 4)
+
 FIELD(MVFR0, SIMDREG, 0, 4)
 FIELD(MVFR0, FPSP, 4, 4)
 FIELD(MVFR0, FPDP, 8, 4)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index bdd82d912a..b155a0136f 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -87,6 +87,33 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
     cpu->isar.id_dfr0 = t;
 
+    /* Debug ID registers. */
+
+    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
+    t = 0x00008000;
+    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
+    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
+    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
+    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
+    cpu->isar.dbgdidr = t;
+
+    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
+    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
+    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
+    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
+    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
+    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
+    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
+    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
+    cpu->isar.dbgdevid = t;
+
+    /* Bits[31:4] are RES0. */
+    t = 0;
+    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
+    cpu->isar.dbgdevid1 = t;
+
     t = cpu->isar.id_dfr1;
     t = FIELD_DP32(t, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
     cpu->isar.id_dfr1 = t;
@@ -955,9 +982,6 @@ static void arm_max_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
-    cpu->isar.dbgdidr = 0x3516d000;
-    cpu->isar.dbgdevid = 0x00110f13;
-    cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0899251eef..7d4b88d787 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,7 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar2;
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
-    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     cpu->isar.id_aa64isar2 = t;
 
@@ -1268,7 +1268,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     cpu->isar.id_aa64smfr0 = t;
 
-    /* Replicate the same data to the 32-bit id registers.  */
+    /*
+     * Replicate the same values from the 32-bit max CPU to the 32-bit ID
+     * registers.
+     */
     aa32_max_features(cpu);
 
 #ifdef CONFIG_USER_ONLY
-- 
2.34.1


