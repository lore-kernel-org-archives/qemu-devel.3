Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38A1FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9u-0006kV-PY; Wed, 29 Apr 2026 20:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9m-0006Vw-04
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:30 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9k-0006JP-6c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:29 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82f4a53ae20so246613b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508485; x=1778113285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5SZ2AUA7BYXKc3EOO2JfsbSox2Kf5n1BI6zKR3SCrI=;
 b=glwGKjGgicHtHgrifnx5Bvg7syHA2+ixbhkFwbLq6Py8Y6Bpr6Bzra8M8aPRwZ0ZPV
 L1PGAsDKdZEZh1OglREV0BmoBH6weItGpRsyIz2/LmjiIAX1SVbS28J3etH57stTYS6I
 5TMCuWZbgg/7wFzHiuv3HyY7jVbqQxs0e5VLsMQGRZLANeTf6PBYdfGRnB5oUihg9CxY
 bRTgv2v7ZQMVOdw/z3IYYOMuIhJRZRQSneOuTUwJH7hq8LzfP6KHfD5cxs0eLvycNORF
 S8sWjCMHVQYN7HACTT8C6SDsrduYDW8jElbp/rqRN2EDRUx6CjnmJv0psmbnb5Fc8f6t
 M1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508485; x=1778113285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y5SZ2AUA7BYXKc3EOO2JfsbSox2Kf5n1BI6zKR3SCrI=;
 b=T9HWvea4yvSc9xvfWKBIE7KYfiELEuJA0lxiZpj0iCTak8OPSMNYPlo9U0/oxrzxtf
 aVsIi9QdORKWIp6ZD/DKXqXMVac8KXwnAaVaWGdz5nBZfaPUEdu4qoTuvTjFgK08Rsgz
 BAO2jLYrE2jZqpYvc9VpI0/Dh/6zw5BQxvMcXWeQkxhaz/7e8ugbn7XZ7CWd75FN258l
 qYlU+UTXFL6/1BS4GTC26eHrs2hRLfQODk8rHKORFGDBMUw3gaASozWtoyByxVWrWJ0a
 0M1hzo9LocO2Cn37PBWHhd6iWUTUioBC20Yv/pEvNEs2JSAgCNU9gqjJeatGm1kybRnu
 Iw2A==
X-Gm-Message-State: AOJu0YyhId7OB3lXQzytZhVz1xNXPt1JfWv+SD86DdVx4lXz4dnfs70R
 D+R8kcKmAWuwLYiTsh1dsIEy2HhTarQtmyEo4UwNGo+wV25U53cNmYgMbSeB6+9I/c1WWrjRbtC
 ItgwX0LQ=
X-Gm-Gg: AeBDieuRwS3PSJg9Vbt1T835zF7L4qqyB/+5lwiZF284Hx6m8hydmaJ+5rVlkVQpqPU
 8t/WsLcy/DxhlnUT1SdApbgF7DSd/heCvvZCoaZfXALV07b5rlN87SJEldaV12mF4f0blLH1RxG
 ifqVzApLk6hHYQIqLaftWhpeJlBobBRSrHGJO+lLj4xwwMxSDXRZZopkCOpcAzOskWjTTmUnxyE
 V11jU2sOx2ygsfMf107qPE6SyYIvmfcloXNv1r91yiIkac9lkO7M96CiBTKBtp2TwcPOc//pj/r
 57EiVH2mYBla6Op52mmd6wFqVGrnr3nOnUJuvPfI4HnrEvGOe7JcBaK6AxHmchGbgaHdKl7ts3g
 sRfORY5zS+dTsLte49ap2GAGrgscIKbb82P/KY6+anFmGh24gZJwDwBs+6FgDDvznMeTZHvbgZP
 Cifh6K83dY5jyqJVhA6FvGQXI9BGvOtEcTEPPvvBLf
X-Received: by 2002:a05:6a00:a15:b0:82c:21b8:4a1f with SMTP id
 d2e1a72fcca58-834fdb0ab80mr848113b3a.5.1777508485040; 
 Wed, 29 Apr 2026 17:21:25 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 15/47] target/arm: Implement ID_AA64FPFR0
Date: Thu, 30 Apr 2026 10:20:14 +1000
Message-ID: <20260430002046.59739-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h    |  9 +++++++++
 target/arm/helper.c          | 13 +++++++++++--
 target/arm/cpu-sysregs.h.inc |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 35e281699c..60a16ef398 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -401,6 +401,15 @@ FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
+FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
+FIELD(ID_AA64FPFR0, F8E4M3, 1, 1)
+FIELD(ID_AA64FPFR0, F8MM4, 26, 1)
+FIELD(ID_AA64FPFR0, F8MM8, 27, 1)
+FIELD(ID_AA64FPFR0, F8DP2, 28, 1)
+FIELD(ID_AA64FPFR0, F8DP4, 29, 1)
+FIELD(ID_AA64FPFR0, F8FMA, 30, 1)
+FIELD(ID_AA64FPFR0, F8CVT, 31, 1)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6263a3cb3b..ec027ed00c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6456,11 +6456,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = 0 },
-            { .name = "ID_AA64PFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64FPFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64FPFR0) },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6691,6 +6691,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64SMFR0_I16I64_MASK |
                                R_ID_AA64SMFR0_SMEVER_MASK |
                                R_ID_AA64SMFR0_FA64_MASK },
+            { .name = "ID_AA64FPFR0_EL1",
+              .exported_bits = R_ID_AA64FPFR0_F8E5M2_MASK |
+                               R_ID_AA64FPFR0_F8E4M3_MASK |
+                               R_ID_AA64FPFR0_F8MM4_MASK |
+                               R_ID_AA64FPFR0_F8MM8_MASK |
+                               R_ID_AA64FPFR0_F8DP2_MASK |
+                               R_ID_AA64FPFR0_F8DP4_MASK |
+                               R_ID_AA64FPFR0_F8FMA_MASK |
+                               R_ID_AA64FPFR0_F8CVT_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
               .fixed_bits = (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index b99579f773..6e8b335b8f 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -3,6 +3,7 @@ DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
 DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
 DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
 DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
 DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
 DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
-- 
2.43.0


