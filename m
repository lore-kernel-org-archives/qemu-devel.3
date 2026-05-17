Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D3BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPP7-0007PX-Pd; Sat, 16 May 2026 20:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOT-00073M-Pm
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOP-0004lz-LS
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-835c98b659eso962161b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977804; x=1779582604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjP/qEuf/tycrqFw+mSyrMAF+WG+DYMnwHYOmyGsbr4=;
 b=S1ti30OevQ3yKzdpFa14Czi9fWKejfeJC/8fniQZmKbJwuMEE46tFymK11c74V5A5E
 fTMqCumV8TmLjrLwd5pwSPnjx3FhEG523dAZHPccAs9WONCMKACz0VG1Sc+zZkZ1eQhP
 +lKNAQ5yoi2EUqgB5WkL+Es00zN1VLZTJ9hAXJlcd7fLLY5jN/+/TbQT0FhZymwxe5wy
 qll6yXqk/1qrJfu498kFx8WJVmTsbE7mwQujNSxijOCATwPW7f6vzKXTz6poVZqhdcQk
 PVnx/upBwufttX3Yr1GXVzCwgk9xcUtn6uf4ZWgZF+xT+Xblp5mxf/qhVbi+KubKbl1C
 5nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977804; x=1779582604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FjP/qEuf/tycrqFw+mSyrMAF+WG+DYMnwHYOmyGsbr4=;
 b=BtJlsT3rRMhDWcYP2xey9MLAuR53I/TD4DTCjlcktBnGo0bXkZXTYUxbJkCSzb+i4f
 p952k5jQGEfIl1msMafEXjgB4BcWjWIn5kQ1nqiiybYR2hBUBStW1cy+pEnKqkIgSOZt
 XK3uYFX6skZ3pDue58X3BXxPuPDN6Z0h42Bk69NjFUJWblsx4eodJHCxzDRtCSf0n1We
 dfgIh4zyoug1OLTKjwrGNTZ+kOX1SjmJv+coTlW9up7k2gmsWT2pCPNLH1M4InGLopAD
 Bog6WZQ1G30xefiIQWqD4kX19u8fWXABMmsdCjNDL06d9NPZwhLAHcRMDkOLTW7vSJBs
 YWYw==
X-Gm-Message-State: AOJu0Ywc06+ohwE7fqcpnzwDNjFXsDQJ6RuGJneC2omWDsN7U/a4G/gq
 EnZSu9i5lILEz+VL3Q8Wefq/mmNpcRb5AMJjguEMdo8zMiuMB05kbEk8Xj6gMINlDZW91Zwp/Fa
 e/F5Y
X-Gm-Gg: Acq92OE/rtmaCXZR551XNJYhdjZOXTjfOY3RdSfklsJaYMBdJXKo5voC4CsJ20wQ7QO
 HHYLEU92fO6JOvLeux9zhHydq4lt6EkPOBRwy5at3SfNLqkypl77ogCz8LFJNIPUxfv0iaRG/zA
 XL8mKnIeAVHAcrt0lCGWvVA3jGZyhg/fo58dEUnz/5vS3iHuv3Od+HipRnj3SIrdFCqJ/UAAfhD
 5G+8ODdYazCarBnn/1VR9IpMTTXh4ooC5PTVRSiLJme/Hy6JgPIwhdcNJ1CQ5juOcd3FRi1azFk
 Ctb9ZoKI8oq7F14ounZC03/yO/M26B2IatCG8KteNa49MQkCZsIC2x7lb8qQrpA1V6cZhjqUlp6
 0rJIoQBRSRv5OHtNS279Yf7db/rX/zM+ldj2bh3hjJWqIwsHHQKooFAAQygATyv0YTmlfQSLhAM
 P0hDYcNY0SCpATyLpCDqqWYj3oIUVv
X-Received: by 2002:a05:6a00:ac3:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-83f33a1c9fdmr10663267b3a.0.1778977803925; 
 Sat, 16 May 2026 17:30:03 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 01/63] target/arm: Implement ID_AA64ISAR3
Date: Sat, 16 May 2026 17:29:00 -0700
Message-ID: <20260517003002.321430-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/arm/cpu-features.h    | 9 +++++++++
 target/arm/helper.c          | 8 ++++++--
 target/arm/cpu-sysregs.h.inc | 1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4e44245a8b..50776347a5 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -244,6 +244,15 @@ FIELD(ID_AA64ISAR2, CSSC, 52, 4)
 FIELD(ID_AA64ISAR2, LUT, 56, 4)
 FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
 
+FIELD(ID_AA64ISAR3, CPA, 0, 4)
+FIELD(ID_AA64ISAR3, FAMINMAX, 4, 4)
+FIELD(ID_AA64ISAR3, TLBIW, 8, 4)
+FIELD(ID_AA64ISAR3, PACM, 12, 4)
+FIELD(ID_AA64ISAR3, LSFE, 16, 4)
+FIELD(ID_AA64ISAR3, OCCMO, 20, 4)
+FIELD(ID_AA64ISAR3, LSUI, 24, 4)
+FIELD(ID_AA64ISAR3, FPRCVT, 28, 4)
+
 FIELD(ID_AA64PFR0, EL0, 0, 4)
 FIELD(ID_AA64PFR0, EL1, 4, 4)
 FIELD(ID_AA64PFR0, EL2, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8240f1b384..6ad01b345f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6519,11 +6519,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR2)},
-            { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64ISAR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ISAR3) },
             { .name = "ID_AA64ISAR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6752,6 +6752,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64ISAR2_BC_MASK |
                                R_ID_AA64ISAR2_RPRFM_MASK |
                                R_ID_AA64ISAR2_CSSC_MASK },
+            { .name = "ID_AA64ISAR3_EL1",
+              .exported_bits = R_ID_AA64ISAR3_FAMINMAX_MASK |
+                               R_ID_AA64ISAR3_LSFE_MASK |
+                               R_ID_AA64ISAR3_FPRCVT_MASK },
             { .name = "ID_AA64ISAR*_EL1_RESERVED",
               .is_glob = true },
         };
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 3d1ed40f04..b99579f773 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -10,6 +10,7 @@ DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
+DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
 DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
-- 
2.43.0


