Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF16D4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVI-0000fv-C7; Thu, 15 Jan 2026 13:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV4-0000ck-IS
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:20 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV1-0005sV-0S
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:17 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so882700f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503311; x=1769108111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gVbnXqfgbvwxJ7BEsCc6CmzypR5ojwe4TPV/AFLeVSs=;
 b=xXjo9wdhuEqpAE5+XP3xTf+9lIuz9bChneJ8L2WUAgvHQM4Hz8ma9GtRItaC+6mgC5
 S7ADenZhX6YOeJVB2sRi4TayObtg6GYNmHZfw0OMO1lAfpf9RJg5n0q4hR3QytCfMnkx
 OAxqG8ePlaNS9+CNLEKBR90zAvO/sMrNiGwluRN5/JANVDRU6DjNeq0hdlppJjxmWdL/
 3Zraz+4OQmz8NLxFnijHyF/QFNyTEOZbqWTTfUHHSnlp19kPWF80L74uXLUl3/K7BLha
 3AZrGZXDuJoDD/ap4wCun0vLCrbOyp6WKdRz4A9K6N5Dcxa/7WVL2dbJszd24lQgN96Q
 1ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503311; x=1769108111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gVbnXqfgbvwxJ7BEsCc6CmzypR5ojwe4TPV/AFLeVSs=;
 b=lvavYWKyciTOvXLwNL9IfuBfDo00q2SYcqOZVxN6OvFWU3QbwIBpSLK9vdOAflY3Ll
 3nvWHUtRUFDq2T5KEzhFcCCKgQ10of89K7bxPgc9qix+xXohia8X64vS5WwafjS1RFkT
 cuiJF0IY/snoANn7SoG4PDQDKNBnWLGCqJ8VPe4sdvBe9nr4AVaXZhhVA4336fSCA4c/
 Mx6gRtm2S560VvGPv7XYJYBQgD5m3Y4vpShbAekb+LsNXrahubfgPEA9o4EdYQznRQx5
 BSCLpw8NJnd778XOI4FtJjfQ4NAXnbda26WjaVSyR/Ay8zqns7R6DY6k+JFXguuSzc/o
 Xqlg==
X-Gm-Message-State: AOJu0Yz9TEKr66x7sCo+J/YLrYbeFiAwXWFonI7o2AOKcyL4qiNtYOPK
 bJplZ6tz1PDZxZHdbfXArd528MvyX8Qaf+jQM/L5cv7Uyw2fv7nfVTY1JrdllyLUdtJ6wrEyiYY
 t3RVJ
X-Gm-Gg: AY/fxX6ee44j4axNL/mZ6ZVWpYANyBzaXNkRrMbWtlPoVamCxEdwCYYjl3xRht9IBc9
 XZGflprZUnlOJdXBWZFmvabed9DeADAP+20v6zSsvAferqIZ2PYjeKvKjZRFoS6Z1yCsP3mPH9a
 jMZEorwYfFWXO7ztQJSPp5yZ9/MT37JRMLIG94gq4D4/39+GRMBnamBJuy5TOSJiP49atertJSB
 IZrA2DEQaWU9ynE5X6apT4p5KG0cgMmic0rRXFB9dDuzuQjgQpj/QkKnumcRoQLLHaYZkhp4dS/
 a5+lizCcKx2FR8WvRzSduIdVH2LWj1eclLPALddNIIBJNqHDKUDquDzoC2bpCAx+ncl83EjY9EA
 eA7tRQSQHQQuDfgt4kUZ2Wz1da20QFDxoPQw/0ibsTTYF9xSRJZVh4SV1cQafTtaJvYejijhClp
 6+negs41f8oTKBEmeyTJFpeSEuDbUgMHlG94dMX0fOwNkwXqsac9Y+Jf8T8mgiHcX+5LRoPwxMr
 RFsxPITfJeAkJKekEa13x/Wo2XpfIqHvvIw8nRh/PkdHQ==
X-Received: by 2002:a05:6000:144c:b0:430:f68f:ee91 with SMTP id
 ffacd0b85a97d-43569bbeb36mr479488f8f.37.1768503311204; 
 Thu, 15 Jan 2026 10:55:11 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/25] target/arm: Enable ID_AA64MMFR4_EL1 register
Date: Thu, 15 Jan 2026 18:54:44 +0000
Message-ID: <20260115185508.786428-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
[PMM: add entry to v8_user_idregs[] list also]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/helper.c          | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c62..2ba49d8478 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
+DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 263ca29d92..a7239ff25b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
-            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6706,6 +6706,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .exported_bits = R_ID_AA64MMFR2_AT_MASK },
             { .name = "ID_AA64MMFR3_EL1",
               .exported_bits = 0 },
+            { .name = "ID_AA64MMFR4_EL1",
+              .exported_bits = 0 },
             { .name = "ID_AA64MMFR*_EL1_RESERVED",
               .is_glob = true },
             { .name = "ID_AA64DFR0_EL1",
-- 
2.47.3


