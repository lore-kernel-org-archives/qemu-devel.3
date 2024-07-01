Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFE9C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZM-000144-UG; Mon, 01 Jul 2024 12:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZC-0000mw-QO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:47 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ8-0005TZ-RF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:45 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52cdebf9f53so3263646e87.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850061; x=1720454861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NAjd9MzEHdZLfkEQtg/fWScyodUzBC9VZqmLgzQaiAI=;
 b=dRIS0ElNDmrrODv+BRQuIjvz8jm4fkuQcov4MSYcFRCwBP+FLLX7nH4Gt7TFxO/HDu
 qb2hhrl2d6leTQr/mJCaSKLxLj7/AkfsgbdfsIOsaD3TespGVmsTt968DY/zng/U3K8M
 E0sgm6tXR1+F+Au9f33SlSeZGMtADUCqpuZeemlZZRxeuuD2vcRsEvPMzLpIq8q3Y3Jc
 9QoEL2KYeY9NMA/hFCyb/yQb6B4nuSoD8CGl+DeiZNJjo2WoeWA+Z8mV4jvol1YY4VM6
 17eWUjfKHwUjN41jg5VSOhZa4ryw6TOQoieIEnRycTEACYs4Iqv9wTubVxNaT5VKeG7f
 3bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850061; x=1720454861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAjd9MzEHdZLfkEQtg/fWScyodUzBC9VZqmLgzQaiAI=;
 b=N5UqDNdL1Uy4+OoxloKwBsQQLX+r5JiMO0TEPB3IxjrjOVWiwhwVan0Ne3pzXNB5+0
 2Hq0sQeGbyvwzoU0Yxex6zNlEFt9DSJAgfnTinkqRmFba9gSFnbLk/69LXPkU3kfLHfw
 dMr0p9TpAUk/NvrjKWJUdBuJQv5kZnXF/jQXp/O3rMFKF609bwdStIwFLSlucSdk3q3C
 885o55sv680Fm8I/EnwZq0ACPshbuHOSaZKoM2sf4gpP8z2QB9pkYLDxQE8EpmlYsDUQ
 0ehXIsxocS0auHiIcNhSm34bIfKTO1UvVjuwzxO9NKf29aJcmfD8OCtaWjQB4syNobJi
 RhwA==
X-Gm-Message-State: AOJu0YznSLE1ubzcTiEP0DA7ot5f3aQj3WUGWbvAEsymG73bM9h5UpzK
 dPy6h/nbXhS7wifpfBmUO4QNAacBdlB9Zx/Dsc1rhpCm266Foe97qqD/jN/BrxiJD2sEbC7G6D4
 n96c=
X-Google-Smtp-Source: AGHT+IHyvbrQUXntP2HIUlkFgeD34YrnbzP8bxv4HeKr0dRzUbr6zmhZM/blf/xlmAz9lN0Nch+TEA==
X-Received: by 2002:a05:6512:3b29:b0:52c:d9f8:b033 with SMTP id
 2adb3069b0e04-52e8264bcb5mr3781219e87.3.1719850061255; 
 Mon, 01 Jul 2024 09:07:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/29] target/arm: Move initialization of debug ID registers
Date: Mon,  1 Jul 2024 17:07:21 +0100
Message-Id: <20240701160729.1910763-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Move the initialization of the debug ID registers to aa32_max_features,
which is used to set the 32-bit ID registers. This ensures that the
debug ID registers are consistently set for the max CPU in a single
place.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240624180915.4528-3-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  2 ++
 target/arm/tcg/cpu32.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3841359d0f1..d8eb986a047 100644
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
index bdd82d912a2..28a5c033bb9 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -87,6 +87,34 @@ void aa32_max_features(ARMCPU *cpu)
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
+    t = 0;
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
@@ -955,9 +983,6 @@ static void arm_max_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
-    cpu->isar.dbgdidr = 0x3516d000;
-    cpu->isar.dbgdevid = 0x00110f13;
-    cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
-- 
2.34.1


