Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA4AC98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8kz-0002Tf-7d; Fri, 25 Sep 2026 12:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8kw-0002SZ-NK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:38 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8kv-0001D2-11
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:38 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so693958a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790353595; x=1790958395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xqGf9nyqInK3fvaYjWzi97i5cTSt62jgFhFWNbx7iCw=;
 b=RXh8+amxSMkrGdAcqPVEu7JBRAvPypRGVqiWYivqp0mDtcUMYx8Sp/On7se69aW4SO
 0bCZ30F1Klq1eMVD6KjYquRlbi6lQeNw1BKLg4f/az6u1wZGX3MIaVhLsFiYVRLl5L/C
 38Y3w4GPNeAoayMOwv1WNCnFKxAk0MOLfIl4R/6Mk7nWBMZ2T60W8hNknqRj5R4T/P+L
 KSv5vIdK8YAQHXhbb2ENJ/KEDICX9CVimRWyd8FfY0gDX6RXjKn4zd00+gZtBIpKYzxL
 v0ibHhPodugoysAmcBlac+sm/S/2Ip80mGFj9veUql863SBFNY+rf6QdTIG9dycbdulM
 9ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790353595; x=1790958395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xqGf9nyqInK3fvaYjWzi97i5cTSt62jgFhFWNbx7iCw=;
 b=EedguYqrBqr6YP+RM8S0gpCMATytULjFs/8i6rug0gzkKUZZTNgmhmnRBdiR5iE58e
 n2YnSoYbTJdV97sTYjN4tldcHhURV72wq2uuXitR6aPyXoPNqizyZqxwXD+Gy0xgpLsi
 vt8HRvs3eiGb5m3sABqh/2rkD34JURSDxnf413/Ge5vJ20t7XfAkeG92SB5sc+QBbH9G
 DOPacopIV97cFdir5yk6tt5rL/JOsO4ni/TE581M7dwOCIt499AOtB/MCZ4LI5b6qVTG
 0g5XEcegLwQQV9l7kSH51dwFmCMamXPrxH38H9TAtQiaM75GrWsyWQPOMyXUqL1mgeSJ
 +k8w==
X-Gm-Message-State: AFuF++myUab1aNmdbcxaaeJAy1BDUe737NOuuI7CDO8xwlDcYLtM5G2O
 3lUbj95aTAc6h/Sh+xRPoIuNR5M5Z14PoTR2lfQJ0Gqk4G5F+X4WEc8NitCAwmk9XV/k+3bfF/I
 iDv1L
X-Gm-Gg: AYBFou3d9YdBlGTijP9DZNpiFo7JmHboeJwerfbt7j+YdzRV1SGQyg1faf6JX+WaaYX
 ogJYBIeaBPvzKa/MZrx8H2lUTGbOwfBsXizSvIUKaEsN4DJ6TRePGiGknuu3RJfgrOd93C3OBHG
 qAvXFcdsCA2HXf02dosTDFeQ3C3WuBnHdV0PXWlh9RN9ePs7dUS3tpQGWttpNCP7ue4wJXkOIDL
 tH63wkxOt30U1LGt7TtolYDIsTx9xGmmZu0HIe/RPWYRY/JYXpedz59R3Z0hJCLCEmJnEw0O7+h
 Mb3IlnVqHxr7NVnD75WK33rWAsviPwEDIw6RyLJBT3qZJ+/JoPhkeMADlxlhIf9fqrMCmvcJfj2
 zZ2uobqCIwIV+dRplNjVenfsvER0QPu2vkjvvpxKDXs0B6Ckbh7ydqm1CVMAgU87Xdq7NgvlYPZ
 xJGycvMMUO6lv2z9PNXVllGDVfrX07dU2HYWgDdotYCcfcCZnrh0wdcqxYYJUFCAtisr3qz54kA
 6jcPfoVTrcSCKIM9QlYENbIyN+NF5H1wrgaHYRY
X-Received: by 2002:a17:90b:28c5:b0:39e:6a81:c923 with SMTP id
 98e67ed59e1d1-3a098729524mr4727158a91.22.1790353595376; 
 Fri, 25 Sep 2026 09:26:35 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976cacbesm11464809a91.13.2026.09.25.09.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:26:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 2/5] target/arm: Enable writes to SCR_EL3.TID{3,5}
Date: Fri, 25 Sep 2026 09:26:29 -0700
Message-ID: <20260925162632.404001-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925162632.404001-1-richard.henderson@linaro.org>
References: <20260925162632.404001-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index b488cc48b73..be8680966fc 100644
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
index e3f931dba26..52739243d12 100644
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
index c3f607e6d6b..26a9fb6c849 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -839,6 +839,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
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
2.53.0


