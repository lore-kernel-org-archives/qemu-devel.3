Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3B0D10F34
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEqK-0002nj-8P; Wed, 26 Nov 2025 07:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpq-0001q2-44
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:29 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpo-0003O2-7l
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:25 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso4031306f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764160881; x=1764765681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjInhO+n4r0xBag/pZShgiqyLRb94VnP2a+V9taCdyU=;
 b=hnAoDzO5fpsAcHa3seiiXYk8JV6fXOAKHMcIwY1lCS2052JrzrofoU/vyMG8wcNo/Z
 5/5zhl0R7lf5DxLuaHEbIhV9meyv1qv3oQK9J9Rd/bX//korCDkvcJHXYm+65hOh6TwP
 JeOI1gKabAjpuPL8w0B2gLKL+rbn+Fp9JaboixiYGd2HIRfecsIZ7uICkvzFq6/Nx62C
 18LuK58i1rskw0ItbmeUW23tFKBkoiTmtMyJwNogVYbk37tP9lqssyFaBF1+Du+Tl2eh
 8sqtPYAx1SdULO0DZNQEHyBCzsSWvjwEG/aC0fHYLJmvtiaoMJ0+sPKskUhyAjt8urBM
 ipAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764160881; x=1764765681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UjInhO+n4r0xBag/pZShgiqyLRb94VnP2a+V9taCdyU=;
 b=IpEJQfmc4kAiim3yUwHAI7ARvA37mNAEfYi0vXJQXRraHuZz1YY+rBNh5zfRzsmlUu
 0WTfSvnFJoXaPDcPSQH33MwV+nxG5Ps/5HeWgwgYVkM8tTMgefBRNsmRoygZA7+EMLZ1
 VEQVyYxig9t61I2U2Bz90J1+ZuA6mWKKgrlPaIJNXmXT1ZkV57KizRKrcLeQUPreDsBc
 4/0+UaSDlQG9dp0SCkBSn4P4Rvl2R9mqm8LvIoyScKBHTwgu8eS4P33BX8t0P0fMm60T
 T4kedoS8k6Cut6vrsFHkPokSRFA7U3QitN8zE9JHhRnX9tenVYaU8A2AZW5XPIhi7/UZ
 QIag==
X-Gm-Message-State: AOJu0YylWNHJOe1tUS/Xwx1K7yW1HckbsfpImAOWLEJ048bhyPfmdsir
 qPJMU5ThJ08DylJjJ/OrPMb12w2AYE4XnM0H2O/9fnI9aIjF5FZazUAWIEMW6DlBno1C4goprcR
 n8DOI
X-Gm-Gg: ASbGncs0PMv4pPX4ZX3u1hyAfIoyGtTzOqb9GwUYmz/gwqrzt8yqMkGXTULZ9X5H09w
 Lv6mKpimGGpSH4juJR/s4lGmp2CWXhKvVmD0Ndln52CcsN2zApgokRZfHmrvxhgywCdGhgGEEFN
 xwxUoB3V7WRsXWR4HFCGvYzaBE/97rgNK4lHMFWp8bPL7FAy95HZNnxmyN+o/zDboC6gbzb6mUH
 l6/+Zro/gDwKPl0l6ITviqnegoChZ+O4Y0RHULnkkNdBGmbXaI+bObEP+rd7qROcWTZlpOBlmzs
 tAcyaEtJ8o74kKpfkg5jXRScUIktGIw7Gaz1eDdNnGYPD3gPihZ/cVu+xVn7j1nLBpLeiCygRyQ
 T+2lgJtohWTXDjTJjPbM6EwNB044nCJk24tAhjTUdIoZ9JlYbMHShj70tHyQBb3wwRKWWtYRsoc
 X/q5vkguAZJkY=
X-Google-Smtp-Source: AGHT+IHf24wnRfqHfz9/dVwBGAnhs13hNCVqIQMNv5wbfuS8bHybj2fkHrFxzAqVb+aLrd7HVuRmXQ==
X-Received: by 2002:a05:6000:430e:b0:42b:2e94:5a94 with SMTP id
 ffacd0b85a97d-42cc1cf4540mr19664071f8f.29.1764160881207; 
 Wed, 26 Nov 2025 04:41:21 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:a692:d4e2:eaed:fc4e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e556sm40044246f8f.5.2025.11.26.04.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 04:41:20 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V3 2/4] target/arm: Allow writes to FNG1, FNG0, A2
Date: Wed, 26 Nov 2025 12:36:48 +0000
Message-ID: <20251126124116.351685-3-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126124116.351685-1-jim.macarthur@linaro.org>
References: <20251126124116.351685-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42e.google.com
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

This just allows read/write of three feature bits. ASID is still
ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
the ASID, will still cause a complete flush of the TLB.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h | 7 +++++++
 target/arm/helper.c       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 579fa8f8f4..d56bda9ce0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,6 +346,8 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
@@ -1369,6 +1371,11 @@ static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
 }
 
+static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c20334fa65..7812a82bab 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6102,6 +6102,9 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_aie, cpu)) {
         valid_mask |= TCR2_AIE;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6121,6 +6124,9 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
-- 
2.43.0


