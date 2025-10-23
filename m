Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0371FCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw54-0005tn-Ol; Thu, 23 Oct 2025 10:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4z-0005rz-2Z
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4w-0007On-1V
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so8881595e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761228846; x=1761833646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPRRwLj76IcDwxiEgjfHUMq405RINil88LOEgkCDg4g=;
 b=KR/fBf+T8dykxTclQ88yXi28gAIRTfhlWhnuujmfkhobKW2o6sDUKUkxyeuJioFaHE
 J5AMDHBRqXmvcWpI+U//Q8sJI5+DQoTlijGLySH3WFukjHN2oOvaCnIlHpNOo/gfc/xW
 TZDamOhWMTockWsG4Si1HnIQYHVwxBEyXPVX3G1JqaUdCQckT5RXiz4XqREj95tO7pIR
 lGCr7M4JyEKHpSJZv+D00AUbfgE9vEtxurExQXNZeFIgbEVqAWQGK7eDZN1bivg9h4a8
 quLgEQxws7HsyaxlqV67KnybP0aOHFNO9y6CiqAuVaqMi8idn9yjsGeVQ63UUgVngjrR
 ADBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761228846; x=1761833646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPRRwLj76IcDwxiEgjfHUMq405RINil88LOEgkCDg4g=;
 b=fc+R7+qZyMJlHGgmIRsvBKfiAQEi5oPb6KFAxy17JEIDkgvjKcIN00K8AWZXSHBqI7
 DgiCYjaTbpHUJduZU+/T+ryEFe88W4jkoeNaOYKpnWRTSpiP/l1ZWMlfBlf7eRMLlrKt
 vlwjcTSDxulyP3UXz6xFG4bPOBiT4FAXPWZRG2wuQoa7z2nNB16UCEA0W4zXp/unUt2a
 DNctWrCYVgi1zu1MOmuarqIgDqD1rFoVt4imQ+PmRvwOdRMSbybktI8vG04grwjbZUL8
 JVo2+lp4vnXrQuo/qIj0hxbOcy0gji5zeNAeXp4/qFcIkOxIVidVun3yp5gGlWp5hD49
 pLkg==
X-Gm-Message-State: AOJu0YzCgo0G4X1SzpouSAYCGGZQt9FqY6c7c15aCnDgLoF6/2HqpyqT
 /uwKysOAzKsDthEWw/U7X+S+J/VcbaDJqL6FIAueWOo1KeWTpnGWeH6DzHQYIbh3+qbLqRVwOgV
 sF6esXhI=
X-Gm-Gg: ASbGncuyt/ZD+beyaiHRJ2yIws+zRKbqhXHK7HQgsrZBGlpibLZkEruNBBX/q6TQ36L
 n0w90But3uK7ClFZj2aJG6QkHCP8J6dK4g1KFFCYkClhm5GzFtfa0YJu5P0p7h54+PueC7K08CB
 bUyhj+MidmMge9/FAU/z/duuTK8s7uvu5aS8eyIkysdd2ocPtn0JNL3EVclYB0LTh7OiOsbbUd5
 onzgX1R+ClHSp32hkrg5V9LeIHU4n0uHrrCskyqrFsQKwNRzjAeNC+v2koTmpEXsXQ3l9863ljn
 p8HY/DIEzYZ53qkB2a1eNeesQ+vRap52IHkzTJtZuEZj0fqAj2NQ3LyjWlZi4l2WESPop1y+tcg
 HSUkwyrKlnROTsb9thqTdqOlTzCNz3mK4oVC7bFwYOsWy8g81M394jyu8UrU4LrB5GUAPAkhtSC
 utqx6NkgF/p0UkCOLzjZuB63ghEmBL+NJ3mHKrlGrS4n5rxQDUQaCKD38THbG1
X-Google-Smtp-Source: AGHT+IFMdQ58xrMRUX6dzUgY79SmJ1MkX80IjdKXk4TetdhTTz3dppUk37vr8z/z4eOnZE4KqCL3+w==
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-47117925171mr251202815e9.34.1761228846452; 
 Thu, 23 Oct 2025 07:14:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342946sm99794275e9.10.2025.10.23.07.14.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:14:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 15/58] target/arm/hvf: Simplify
 hvf_arm_get_host_cpu_features()
Date: Thu, 23 Oct 2025 16:13:34 +0200
Message-ID: <20251023141339.10143-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Use index in the structure, dereference &host_isar.idregs[] once.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 890e9266f93..dea1cb37d1f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -743,21 +743,21 @@ static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
 static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     ARMISARegisters host_isar = {};
-    const struct isar_regs {
+    static const struct isar_regs {
         int reg;
-        uint64_t *val;
+        ARMIDRegisterIdx index;
     } regs[] = {
-        { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
+        { HV_SYS_REG_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_IDX },
+        { HV_SYS_REG_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_IDX },
         /* Add ID_AA64PFR2_EL1 here when HVF supports it */
-        { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
+        { HV_SYS_REG_ID_AA64DFR0_EL1, ID_AA64DFR0_EL1_IDX },
+        { HV_SYS_REG_ID_AA64DFR1_EL1, ID_AA64DFR1_EL1_IDX },
+        { HV_SYS_REG_ID_AA64ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
+        { HV_SYS_REG_ID_AA64ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
         /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
-        { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.idregs[ID_AA64MMFR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.idregs[ID_AA64MMFR1_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] },
+        { HV_SYS_REG_ID_AA64MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
+        { HV_SYS_REG_ID_AA64MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
+        { HV_SYS_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
         /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
     };
     hv_vcpu_t fd;
@@ -780,7 +780,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     }
 
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
-        r |= hv_vcpu_get_sys_reg(fd, regs[i].reg, regs[i].val);
+        r |= hv_vcpu_get_sys_reg(fd, regs[i].reg,
+                                 &host_isar.idregs[regs[i].index]);
     }
     r |= hv_vcpu_destroy(fd);
 
-- 
2.51.0


