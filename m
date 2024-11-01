Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DB8E67493
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 01:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6gaG-0002TU-13; Thu, 31 Oct 2024 21:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t6gaB-0002SG-HL
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 21:36:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t6ga5-0000WM-Vb
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 21:36:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so12733755ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 18:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730424964; x=1731029764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vsiebkp7yeK+UnSZT8y03VRBqJ6iZEd6SjBUXH3PT1g=;
 b=b5IDV96M6sQPIN34ijK7CBefTh+aLxKn3bTvj/KEXPrvxRVEFdNIyf9dcllDBt4grA
 JIUxVZajF1mNWWx7CefUVvFFmH/FaVs/DVm8vtRugdTOyj7/cR6h8iNAczt4Q9xvStuo
 I7DEMFiq9ft2umt/9PLzF0Vq5GtY4RRfmLsbpv8OqmzgegaoMqy+50DWvsukxvVke9Qg
 qpBBBDgkxc+/9jaVxJ7tbTtsjvk1Nxi6lAyKLAm9MUs0DPQ/JgZuSeqGUad1dN7UYDdn
 WQVetgWCXAx2HnCb8LCpGMSgL7sVyHEdLGCK2Ja2FgRW18NawzlEYovQm5UCHb4Z1Prj
 gOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730424964; x=1731029764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vsiebkp7yeK+UnSZT8y03VRBqJ6iZEd6SjBUXH3PT1g=;
 b=bn2HufMmq3kjNPF5ohYA+c2wZe5bC8HkpDgO92G/dGNxfQ8JtQLly5JOM+y3lkHoOU
 sJUdgzQQWQVZXQQqJ8E/DXo8mVYjYTTuAk/N+4rq56IB4xVNbHS047Z+JojakUGm51Zc
 P2XVeXfrbMaeLSCRRkRAemV0Uo1neD4ysPFf9UCYPaFW1K5TmL0OM7m6WYIxJGZMjayI
 gq2Ma5pwNpxLXEjFJ8BgZg6PqMHWyVZXj6teiOeqkSN3T8wAqZnU0PveMv5/UCFj+NOd
 /65RJNCsWFT0FcrmRJet34khaszVxcr+Jd+lmgUB2YczbGCzL9P6KVmKN+sZ0pxS696W
 cUuA==
X-Gm-Message-State: AOJu0YwxIEfutv1ZD0VWFQfIvwSfexgLtd9QuNrGcXdMbhO90ONL4y9+
 9DTYyQTHR84GrOBG1WrbhDuRDkDlifn6488FR6HkDSErAO3vhzPe3/GIyLly7FZpoldzDIoDs8G
 M
X-Google-Smtp-Source: AGHT+IGkYgPIyYT7mkbfVaX1Xlebk5kU81ToYw9/bNuq9AHvvYXw7vDmfIajMg8R0GooMMMxcfrx3w==
X-Received: by 2002:a17:902:d485:b0:20b:b455:eb4f with SMTP id
 d9443c01a7336-2111af678abmr24905635ad.25.1730424963766; 
 Thu, 31 Oct 2024 18:36:03 -0700 (PDT)
Received: from amd.. ([2804:7f0:b402:60a7:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057effe3sm14411495ad.301.2024.10.31.18.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 18:36:03 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH] target/arm: Enable FEAT_CMOW for -cpu max
Date: Fri,  1 Nov 2024 01:35:41 +0000
Message-Id: <20241101013541.883785-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

FEAT_CMOW introduces support for controlling cache maintenance
instructions executed in EL0/1 and is mandatory from Armv8.8.

On real hardware, the main use for this feature is to prevent processes
from invalidating or flushing cache lines for addresses they only have
read permission, which can impact the performance of other processes.

QEMU implements all cache instructions as NOPs, and, according to rule
[1], which states that generating any Permission fault when a cache
instruction is implemented as a NOP is implementation-defined, no
Permission fault is generated for any cache instruction when it lacks
read and write permissions.

QEMU does not model any cache topology, so the PoU and PoC are before
any cache, and rules [2] apply. These rules states that generating any
MMU fault for cache instructions in this topology is also
implementation-defined. Therefore, for FEAT_CMOW, we do not generate any
MMU faults either, instead, we only advertise it in the feature
register.

[1] Rule R_HGLYG of section D8.14.3, Arm ARM K.a.
[2] Rules R_MZTNR and R_DNZYL of section D8.14.3, Arm ARM K.a.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu-features.h     | 5 +++++
 target/arm/cpu.h              | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 4 files changed, 8 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 35f52a54b1..a2a388f091 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -26,6 +26,7 @@ the following architecture extensions:
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
+- FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
 - FEAT_CSV2 (Cache speculation variant 2)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 04ce281826..e806f138b8 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
 }
 
+static inline bool isar_feature_aa64_cmow(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, CMOW) != 0;
+}
+
 static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HAFDBS) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8fc8b6398f..1ea4c545e0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1367,6 +1367,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnIB    (1U << 30) /* v8.3, AArch64 only */
 #define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
+#define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0168920828..2963d7510f 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1218,6 +1218,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
     cpu->isar.id_aa64mmfr1 = t;
 
     t = cpu->isar.id_aa64mmfr2;
-- 
2.34.1


