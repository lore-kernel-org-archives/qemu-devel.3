Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759DFCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtww-0004s1-EO; Fri, 31 Oct 2025 14:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwv-0004ql-Go
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:09 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwR-0006Et-Nu
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429c19b5de4so855002f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935615; x=1762540415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h94wgQCnwPK/CyYz1RjeCmxtDplpfFb/9H5sqCClSa4=;
 b=xRSZV/H+bjE/f6wKQSYeAkgyuEqc1GGuHj4Mo7YAK1/Y4GIjdMgIH4VGvrLoTzr+3u
 z/6bukxbVJN3RlUxpNAYmN6B/sN67kaUooHZVi8QPPSbJpczSL4RZlW2rqH6POS1yQ91
 DUbB+h8aDGJn4vkv/YPJik2rxk1jQgo/jOpoIc4NiFleqh4GwIauZOxzU5yBJpUkeQrZ
 VDf3lZ0gyj96sYNmkH2HazU4AHH/nk+AxNdgOnk42pgge6tcyyejr/mE46qG4IPpg97g
 y5jOgBDNTV1m87hi4A9sQBPPBH8wXKtrm1SGWK327OR+UsuCaM1jqt5o52soZL8//mxI
 9F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935615; x=1762540415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h94wgQCnwPK/CyYz1RjeCmxtDplpfFb/9H5sqCClSa4=;
 b=Bim7Gg63rSUTe6uY6z8AiuhFgiX91hwisJfqL77cHrKe3hvscm5ONkeN0pvYHBA9eU
 uqOXFk9GQzMUNrzqR02yvXjzd0jLBndUZ69Q9KgecBXbQ+DySHw8G3Fq/+4I7D7QJwvM
 GmzWHjtSbOBFk7tXGEV5ajzMpCxl/6n0NzAhRTOqLjq1NhBkCM3m4wiYMxHVmy+KL1m9
 QCCqRt9hMVBwsehqJ3tC6inm5UnNb3UZwGshdkkLC4e42yqYObpUAR9KmtYDe/Vbwo7e
 j8PAfad3CrAOY0d50RimLhkTE2J4TnArHlJiiyRqRVIhe1ZkB3Cigr/lEB6LEZeMcuRL
 0h3w==
X-Gm-Message-State: AOJu0YwspFAlqn2f4kbUdoyiZxm28dLJAJJ1PtbmOXpyeo0thct1TUac
 uHfW6h4PLICF+XSfnI7wkajRmbjzqb6f5oKPnwYBAN048PPZ0ACYoY1zzJSlzF5WvCO1Ejtlct6
 52Lg2
X-Gm-Gg: ASbGncvCpiEtTMA4/KChVwg9mAFigh6Whjl36v9vhbTtSHOF3fngCfcCMvQWlsjTQvK
 J+q3S3EfoeRR/w9qQsQD9HjNRFELsz1+sSkDS+/ie03VoO8M46OilbE2XynWlzPAKoh4iWsVNjo
 giSXFLNg5TV2cu8scXVNzcTrnHowXNk77W9gz35YhrjHIFxmnkhgTU6FGB3FaFbi9pQ/jY37xZa
 A+ZN342d41wXtIg2Dcs0hrQ4IsBX7o+EoAFC9ej8eLrPpyhUZ3a6qVdr/MxF1qwLhIRtXvV2IPH
 x+kqcrRfRG31CGmFdyshlliN1UmxB4teZE3+2hnaO+YIOtFr5ojo8tVwn4lyCtm2TLnMOVtmVJH
 Z1P7kUFTRR5o3GFA+P8x4kmf/Ed+xUeOOiZCY7RLbMrPlD0EBhFx/VDb7as65oV9oLjZDvjO5pN
 pSQ9j28o1diL1MpWW3
X-Google-Smtp-Source: AGHT+IEF0CKnTGiMhO1s/Ax/7g3Bss99/29uOU7sJxzkwNSq4ybRnovCLWBr8DJ81T6hpPF48WVKrg==
X-Received: by 2002:a5d:5f43:0:b0:428:3c4f:2c40 with SMTP id
 ffacd0b85a97d-429bd6c11b0mr4330913f8f.56.1761935615098; 
 Fri, 31 Oct 2025 11:33:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/38] target/arm/hvf: Simplify hvf_arm_get_host_cpu_features()
Date: Fri, 31 Oct 2025 18:32:55 +0000
Message-ID: <20251031183310.3778349-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use index in the structure, dereference &host_isar.idregs[] once.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


