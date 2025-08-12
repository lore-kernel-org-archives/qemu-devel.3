Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D609C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsr6-0007kh-3s; Tue, 12 Aug 2025 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsr4-0007jv-7P
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:32:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsr0-0003yD-Uh
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:32:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a11f20e03so7840445e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019922; x=1755624722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmepWnmKnV1nGb/YBpt/j4zVDXYuzaCa55nrvQSLBc8=;
 b=U1UL63km8cFsbH7KnT9DAF8L8xzJW31UrAb9E9rswzPZ6Ilaeju7CX4sji1kby/rrq
 +I+sWCV/qTz5YtwkWNSwC83YQo9tUBdovlP0alqAzniWz9O9Eswgd4sSpawW13uk3d1Q
 f5imRQOtAfXG20vv0GsepqP5TFfcm1+ofhSpOk/CDoK4X8RqRCXHyrFnStgME5sx7k5D
 eWVf8lw2f/tZDn2SOGLkK/83Z6o6eRxuxFsJ0iibjM2W46irv29Ogjn1rpqc4Y7hYWfu
 0ezC9V4nrUOKwoIgDsCTV2TF6vjl8B7pPsB7Nvw91q9qCzcLWQbJHwyz1QaFPjPEjUaV
 G/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019922; x=1755624722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmepWnmKnV1nGb/YBpt/j4zVDXYuzaCa55nrvQSLBc8=;
 b=Vc64NSGMbeDtLYiGroEQaoif9FR/XSMQBpMl5L/pYh39OJ+Dtk91i+KCPEtNTdQnTz
 +Vyl0m1C01R8hUMQkXPdeYwAoVB3RRXWoGNkX1YUDGzVny0V8c8fIWBFhwtJZz4+TsG5
 mEI0SzjABFhujWLYBs57fGP6tkTl3XqXkLJy3yt27uAekFED0dkg65YZyfTtnMdfBUpC
 Uaxtw1tNhUhHKy9qHZZVj0IuBtUAQBQtumX91TEPU3mWi3hR24RWML7HOlqsS51U1ia5
 qkllZH4NxZypjpjBrbp+V6IxVkoFM87Bp3CkHq+2cbQqFNxSgS6zv472ahx5vDLOX6cR
 Wihg==
X-Gm-Message-State: AOJu0YyGe59DnafpIQrAiN0zSo9xBi/d5c7YphNEuznGP89yoSFEiW94
 yWMrwfnJMM54YO+2Z7wklyy+9iIsC86jdfmEe89iapFQsqlIWxEl4dNVRPsYL7t334gq3IfW0U4
 SV0Qk
X-Gm-Gg: ASbGncsAUrtjYCIMEOzvSTy9S0sdLsfFty75s4EpNWzi1nfHiUcko2DMBaxU/Qz/7CP
 qhc2CY1/hrmOWwHFZ/9YmgVs5KBIOuUBUNUGSPcvfG0dwxSV6CIBpJ8K9HE8PQhuoGD6YrGnoOi
 fRZYIxYJR6qoRxJOomq5231bTOFaN7vpfJYOe3aKXPFoA8q0OzOpkSwz5lRwOR1N7JdDv18tw/I
 OZy7HGjiEXEHFQTnQi3/n16EW/UeDF9XFBokJGRKie9jIGSl2uLWkwCZcQ4/Ye56OfNnjn7Rhp/
 2DtzUpgEJG5roFiQ6hzdcYkKSE41AUZ14USYsLv/qH7UDv96A8nN5u7FlqNE8iEAopbgjAmLSL9
 tdg2ZRm5xNVa3iZzXPCe+g/3XYnvlv3LSoMxkaTSNREBza5sm4phSGnzwp70UGzJ85h0CqHxW
X-Google-Smtp-Source: AGHT+IGI8BvT4Ih0dwkY4C0lDW1jBIoMHbZydwVXYDfSgRnZBpFMTYI40usU0pOBTjv5H/TBQabGLg==
X-Received: by 2002:a05:600c:4587:b0:459:d709:e5d4 with SMTP id
 5b1f17b1804b1-45a16593b94mr352075e9.0.1755019921810; 
 Tue, 12 Aug 2025 10:32:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5843021sm331161685e9.3.2025.08.12.10.32.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 10:32:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [RFC PATCH v2 08/10] target/arm/hvf: Sync registers used at EL2
Date: Tue, 12 Aug 2025 19:31:56 +0200
Message-ID: <20250812173157.86934-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812172823.86329-1-philmd@linaro.org>
References: <20250812172823.86329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When starting up the VM at EL2, more sysregs are available. Sync the state of those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
[PMD: Adapted to host_cpu_feature_supported() API]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Extracted from bigger series as proof-of-concept
---
 target/arm/hvf/hvf.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 05fbd8f7fc9..9d702b82521 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -400,6 +400,7 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
 struct hvf_sreg_match {
     int reg;
     uint32_t key;
+    bool el2;
     uint32_t cp_idx;
 };
 
@@ -545,6 +546,27 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
     { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
     { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
     { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
+    /* EL2 */
+    { HV_SYS_REG_CPTR_EL2, HVF_SYSREG(1, 1, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_ELR_EL2, HVF_SYSREG(4, 0, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_ESR_EL2, HVF_SYSREG(5, 2, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_FAR_EL2, HVF_SYSREG(6, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_HCR_EL2, HVF_SYSREG(1, 1, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_HPFAR_EL2, HVF_SYSREG(6, 0, 3, 4, 4), .el2 = true },
+    { HV_SYS_REG_MAIR_EL2, HVF_SYSREG(10, 2, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_MDCR_EL2, HVF_SYSREG(1, 1, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_SCTLR_EL2, HVF_SYSREG(1, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_SPSR_EL2, HVF_SYSREG(4, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_SP_EL2, HVF_SYSREG(4, 1, 3, 6, 0), .el2 = true},
+    { HV_SYS_REG_TCR_EL2, HVF_SYSREG(2, 0, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_TPIDR_EL2, HVF_SYSREG(13, 0, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_TTBR0_EL2, HVF_SYSREG(2, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_TTBR1_EL2, HVF_SYSREG(2, 0, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_VBAR_EL2, HVF_SYSREG(12, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_VMPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 5), .el2 = true },
+    { HV_SYS_REG_VPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_VTCR_EL2, HVF_SYSREG(2, 1, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_VTTBR_EL2, HVF_SYSREG(2, 1, 3, 4, 0), .el2 = true },
 };
 
 bool host_cpu_feature_supported(enum arm_features feature)
@@ -608,6 +630,11 @@ int hvf_get_registers(CPUState *cpu)
             continue;
         }
 
+        if (hvf_sreg_match[i].el2
+            && !host_cpu_feature_supported(ARM_FEATURE_EL2)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_sreg_match[i].reg) {
@@ -745,6 +772,11 @@ int hvf_put_registers(CPUState *cpu)
             continue;
         }
 
+        if (hvf_sreg_match[i].el2
+            && !host_cpu_feature_supported(ARM_FEATURE_EL2)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_sreg_match[i].reg) {
-- 
2.49.0


