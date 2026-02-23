Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854F3EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKn-0002Wr-Ty; Mon, 23 Feb 2026 12:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKm-0002VT-BF
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:00 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKk-0000JH-Ob
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:00 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837634de51so20466095e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866177; x=1772470977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d/expR217T5l2ZpgIxw9igXVO7ZIf/mmczK8CZEhS9Q=;
 b=o2lWedMp5lMZpGjfZiKeFAMyr1kg+DTWcmp2R9F7sw27aEUXGUnAw9mCujtyAq5weX
 URv+YNSKCRoPDUkZIrh1XZiGqinTASul7Q4XoGDdr/i4YFBYG+1iV1QIfm+2+NXIZWtI
 wn719pv+nD6Bae8Bx6zn221fpeUXxDLVnJEVpPj8xzs5He7uNGpNJ2clcM6r9Y+fhV7i
 SbETqLbqJhpWev4qm42prIC6oK9j2x4G79oXru0UBNJzWzcCpVUzMOKx9ZIbP5HnGsuL
 zvRhRc5A8hQBU64NDp+O2ohMDANTqTqSGX8aYF/I8LpKI8ZqFrZ7zbdKpR+Dt3dtvOA4
 aYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866177; x=1772470977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d/expR217T5l2ZpgIxw9igXVO7ZIf/mmczK8CZEhS9Q=;
 b=RQ4SwYOihbF/TxWbeBF3D0EK9oxKmw8Ok1yrUBmHpAxLb4qShdPL5rHTfXiHE3Y6sh
 JJ+t4XNI0m3FmxFxhA9lD86tE8F8Li6jmgFui014DZ/g4EknNcrYfMfDydlaKl//bI1V
 tEHEZkTiQ2jmAIiBHzo+loNZ+mNVraxe2KPXVtH9uOzRDUleRULDxHiMb3K1tq6MgAOw
 /254TBI2yYAnxcLOSKpAaxHzGNM0ZsnrrPLVjjXdnABYM8U/y/lqUuR/pX80BPuRQUJk
 kFfhomQe3ktT7ADgdlb4GmBhJOKfqDIJ1EOeJmGyOGtUzf2kAZ8y+l+kJV6XXDDkj0Jt
 Fcig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW+sByiVCI7n2uqPhnC9mL60IFGUCU6jVFrMX1jwsePo8CD9u10Px4gOlixha/f9OzE6MYpLobULVr@nongnu.org
X-Gm-Message-State: AOJu0YyyzM0iAZbHq00nNE0KOLKRkF1Eib+IGovuzf610VAG0/IWDdTL
 DIr/+QIO6VJv3tYjN4PezgMiOUJDrtGoNjUuS/hq+pOVopBelMnqoHLBt/sixQ4aQnM=
X-Gm-Gg: AZuq6aKYiLMjbuFd7WE494h47MQ9qfm1mgR1vWhMiDNX+n4hzllvp1xpgH/LX6PrkZD
 WaDImFa4KjWiBpo7rlx1j8+pNhxtUzeAORmjAX931zz6gUZ+DB5idOeqUskT9UVb1x4eSGuPBZn
 ifo/cTCEt2Aq0JCVHJtjYGOAVUCvnLtvJyq23M+3rIgL3juPjBeiYYstvcE2HN6jaWuA27/Cgvz
 Huu9nXvrv/9U5LpftjFoagaNj/k1+pCUMONYWcjBcWJ2EVndqjQLlghrptr89PnEnytoTCBbY4y
 BPctQ8amHKLKvz/fIujc9omhVeoQXTyHLtlyow8rar6MYuuW/JnaJq/XTWbz55RchzQQzMZhh6F
 cODLimfaSzDwRK0BPJnGQYvZ78RrmTg25Ue023WnVGSs/lm67rke6Lmzesb1OWKv53LKkLsrbFv
 HuppQNbJvvAl5KSw5UpaS3lYhTGk9hJaHtOUqZlIqwD69x0UXxdJL9bU1JdpIREswKlbNmsKPP1
 XL+GXS1d0pP6d7+S9vzmL0fedS2+V8=
X-Received: by 2002:a05:600c:6217:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-483a95eb550mr137670155e9.3.1771866177201; 
 Mon, 23 Feb 2026 09:02:57 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 38/65] target/arm: GICv5 cpuif: Implement PPI enable register
Date: Mon, 23 Feb 2026 17:01:45 +0000
Message-ID: <20260223170212.441276-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Implement the GICv5 register which holds the enable state of PPIs:
ICC_PPI_ENABLER<n>_EL1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 980abda3ca..915a225f8e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -607,6 +607,7 @@ typedef struct CPUArchState {
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
         uint64_t ppi_pend[GICV5_NUM_PPIS / 64];
+        uint64_t ppi_enable[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 4647fd40ba..c54e784dc4 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -219,6 +219,12 @@ static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, old | value);
 }
 
+static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -334,6 +340,18 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
         .resetvalue = PPI_HMR1_RESET,
     },
+    {   .name = "ICC_PPI_ENABLER0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 6,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_enable[0]),
+        .writefn = gic_ppi_enable_write,
+    },
+    {   .name = "ICC_PPI_ENABLER1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 7,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_enable[1]),
+        .writefn = gic_ppi_enable_write,
+    },
     {   .name = "ICC_PPI_CPENDR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 4,
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


