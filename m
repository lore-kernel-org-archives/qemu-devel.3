Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C6FC5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1wL-0004nM-5W; Thu, 06 Aug 2026 13:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wJ-0004lU-0c
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:31 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wH-0001fy-Ba
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:30 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so2641826a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037488; x=1786642288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1L0+rBxezIyKN6/2AHClvxFcunVGgHr8jfzeunPqo3I=;
 b=HVvrYuK1S1ZkS8V+gBOCGT3ye7toOhLZF440dM31C1ShjLEAoC5bOX3BFgeoCiP1nX
 /eo4gRRc4F/wbSlEGujpwFSskEBrRQGBlmSslukx7HoQ6hSy6ZWG5xygTW85X0E4Ip1E
 3C8+cG8L+KeopxfAfs6Wj9cclKmplUYEX8mMTI6Skx8W/sXFE2xwXlobUuFLsSft8q8x
 ZoVRrFPOUu/azuUUYxNnX6AmE13Sa9KeWNo/xaytrKP7PAknaTFbBn/sMTJwuw2i+4gM
 OqWG+iFzUQTZlxPjQq8uk+TMqY5MwxPulNvr60ryEPBgoy49RLCjq3ZbGlmG/1lGR+z7
 RBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037488; x=1786642288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1L0+rBxezIyKN6/2AHClvxFcunVGgHr8jfzeunPqo3I=;
 b=dAqIh4qIzF0P7Ra88Cp23KWC72KSE6DkgVuIWtdaHrmf3i2ki7481xJ/8qw6FXlv1E
 376zw5gaXTEK6M2CE6Kkr6UnFjRaPqodsgPiatVaI5LGzfzgj6XvhxO4wv+/Z+DNhnAu
 75XoejDFOFKUtHXSZOUXsCTzRhGMHvT5Jw5PdYwy11q4aHZrn/R5hUlSrbNAQpvRBotC
 huaFrnAQ7U94Ei8MXia5iBiN2TofI/TOSmYZ93vB4l39GBjgJ0h3hUO6Me0Zz1v1gSHN
 1NuTLJ9NpxwXhVrobrAVfGCFvjfVHZ6UL83zLv7p1WjlAlAT3WUCvZaVCRwFc4msSvJG
 Gzpg==
X-Gm-Message-State: AOJu0Yxiv3vGSHalXvkXQG+F1Zd8tvaJpHcNNq1YCO72Oex6ZzoIuvmh
 ZHGaKUhID2kJNjX41gl4xxYU286VDQq4N7imi1NqQTwqrqQA3vKVz+lpInHJq9c2eECpoUVpHzR
 TYZC7
X-Gm-Gg: AR+sD12z1OFjo3ZdDf+g1kYGxqKcrMcBolH50hkBUP58GNkqT8rhOxIEhx57WpxP0Rw
 WjW38Bpx7+035Xor2jrkHxRerfmvWV+/zX0BwIVRyp1O2J9trl58ZydXsQMbcCdwcNgRMkuAThL
 evNAyL5kv0rzTLmS8VIDX2cJA7xWNgsoUhupl/NfvGW4zoLZ76+I7UWuTtE066SCYDQzoAnxVy/
 Ip5bQe53VA3AZcJrgmgljJrNj8XjoCbV7lcx5hf98KH54KgKbebaEHcCt3ond1QW5x3Ax2xFiNd
 98bwcIfenAOu3W4O2rVfChreGCIywwcL8kv0qNj2LeeyPvoKsspBeB20sCIqXYeFIbUqKqXqT8j
 U8/nUabGKbacU/6BiPnMMRQqwtUsCumVl59AvWw2hnJo4E5CnVmPAntDJDj4dhf79ekASJGf0SJ
 bgZ199TBLnOFsqBaK13AnrM0jpIGBJ9Y5U9/2bD1M/6P1Ru8sfZ+RYds1BqzcK+2O+sosFoOSCE
 xwb+lhuMnShr74d2Akd
X-Received: by 2002:a17:90b:4b84:b0:38e:8021:2ea9 with SMTP id
 98e67ed59e1d1-3903c5f6482mr15178690a91.19.1786037486581; 
 Thu, 06 Aug 2026 10:31:26 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085e4a2a5sm1983711a91.14.2026.08.06.10.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:31:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/6] target/arm: Enable writes to SCR_EL3.TID{3,5}
Date: Thu,  6 Aug 2026 10:31:19 -0700
Message-ID: <20260806173123.333423-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806173123.333423-1-richard.henderson@linaro.org>
References: <20260806173123.333423-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/cpu.h          | 2 ++
 target/arm/helper.c       | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index d6f8b4d065..f0b354445f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1402,6 +1402,11 @@ static inline bool isar_feature_aa64_idst(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) != 0;
 }
 
+static inline bool isar_feature_aa64_idte3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) >= 2;
+}
+
 static inline bool isar_feature_aa64_half_evt(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, EVT) >= 1;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a471b87aa5..41bfda65d4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1786,6 +1786,8 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_EASE              (1ULL << 19)
 #define SCR_NMEA              (1ULL << 20)
 #define SCR_FIEN              (1ULL << 21)
+#define SCR_TID3              (1ULL << 22)
+#define SCR_TID5              (1ULL << 23)
 #define SCR_ENSCXT            (1ULL << 25)
 #define SCR_ATA               (1ULL << 26)
 #define SCR_FGTEN             (1ULL << 27)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c88af981e2..8ab0075628 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -796,6 +796,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_rng_trap, cpu)) {
             valid_mask |= SCR_TRNDR;
         }
+        if (cpu_isar_feature(aa64_idte3, cpu)) {
+            valid_mask |= SCR_TID5 | SCR_TID3;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
-- 
2.43.0


