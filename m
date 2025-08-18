Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D3BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 04:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unrMB-00071Q-Nv; Mon, 18 Aug 2025 00:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1unrGG-0005p6-9b
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 00:14:27 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1unrGD-0002Cl-2s
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 00:14:19 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-323267bcee7so4441143a91.1
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755490455; x=1756095255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2+nV0YfiHa2rAN0jtaoq5Xn/wQINVnz22GUz0HS3IA=;
 b=gtFAanFQFN/8/92AwnqnWJlP2mHdKOIoEj94Kt8qViMGT9ysViQSmk10i5Tf9PNnW1
 KY0+oFBbzOerHCx5m8z/6Nw3CRtwbWbC0Kfhq3YO/arUld+FjY1BIgyFS5Gt6AQqCkre
 TGRIrlMEy/tRPDEtIlVD5WR50NIe5EDxIldOiEHXzjLppJJ6YOS0A2ZTpTlr/mpMheE7
 UgKeZUmx3v+t919U0f8vYILvtK/SlFzvqP1/4aEc1OSsklIwOk3CyiN/XanI4hss27dm
 OylYTT2iGO4cRWMT9ypOdFn87dYKxBNaWkOFAHXEoZCD+6svJZplcUF8w4ejr/qQ+bWk
 8OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755490455; x=1756095255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2+nV0YfiHa2rAN0jtaoq5Xn/wQINVnz22GUz0HS3IA=;
 b=w/GUUxX2O01rLzlYOLnGm7LQ+XQ5oQnmLg76t/O4TR9cjEshEGRqMdFwcLiQacoLjg
 m87+7dMvmjI3/vfNJ0bEaveern6JGf/VtsUqMARPm2TeaydNIdh8YqsIXhrfR5VwTfvs
 kdIcTDdgL4bmMfjs3b+wZS5CYpYD8j7XbZ9TXGYG9vBjxD/i2EHRY9EfnL9eZR+o83H4
 sLTwEDu+h7bimp0cTQUSuf3yoPun5LAhEDnCqVmbIwSlGB1ML/cku0l4uTC1SbdxDVty
 RF12A76s9UDc//jdOuLaEeJn1teQXVnRwNntiNArJvYpC4ICdyzdyqn1uMxszthlE4d8
 Tz8A==
X-Gm-Message-State: AOJu0YyD9kWB7Qs4D2rhnp8T/2ABvqbXOE3NGFT/+qhtJqUF0VUUZMFJ
 2BgiHEmtix+wN3BWBcVAlQz+PsKW3KPHQFciyz5XDPXZ0vd6fO6W2Nf5HixLgvaov1QXp+Qq/nK
 XIdLvNpk=
X-Gm-Gg: ASbGncsvNSYb6+EEk9muX4UQjCehDYIJCmMPB7zqlHVMLA5NBCpCeWQiG2YdfgDOspj
 1FmryAxBuDYxTyJs0Vb5qVFSo2RnvgrV2rlPmFp01yhL5EbW22GDQMvd1zqDn9uvXNpNx1ub/47
 tCKTaCGYeGGM9FXUWQLfOCfMmMF12u3drie/TF4PnUvIbcpOWdN8o0Ww7ncoV5T8a4Cnr+sU1PL
 JPf74XPmMFRzpzado6UGVhlSmxNq88lBcCnfbrBrGCzGyhIb2HR4bHwOx/++lXrfQClQhhWKI0k
 8O4nAdn10/I0O3iS+X6mpC1hjhH8Ninym6ZN6BZKcenOyIvmuP+1Oje4Qna1rQeKiTv/gvKjZfa
 4WvYXl+qlwdgtm3IqmGXOMgnqWFiRnIEFq4Z81rUiL/c/pyo=
X-Google-Smtp-Source: AGHT+IFzkbsdg0Lq6v5LrS2LBwx2rSLakrYFKHwWSxFDNoj8ZH1o2x02q10TWBONg3g6irXJfNpzCA==
X-Received: by 2002:a17:90a:f94e:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-32341ed2b23mr18088957a91.14.1755490455050; 
 Sun, 17 Aug 2025 21:14:15 -0700 (PDT)
Received: from localhost.localdomain ([206.83.122.207])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3232f8c8e4bsm5498344a91.2.2025.08.17.21.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 21:14:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org, philmd@linaro.org
Subject: [PATCH 3/7] target/arm/hvf: Split out sysreg.c.inc
Date: Mon, 18 Aug 2025 14:13:50 +1000
Message-ID: <20250818041354.2393041-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818041354.2393041-1-richard.henderson@linaro.org>
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Move the list of supported sysregs to a reuseable file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        | 147 ++----------------------------------
 target/arm/hvf/sysreg.c.inc | 146 +++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 141 deletions(-)
 create mode 100644 target/arm/hvf/sysreg.c.inc

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 47b0cd3a35..f0e4b75e6a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -403,150 +403,15 @@ struct hvf_sreg_match {
     uint32_t cp_idx;
 };
 
+#define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
+    { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
+
 static struct hvf_sreg_match hvf_sreg_match[] = {
-    { HV_SYS_REG_DBGBVR0_EL1, HVF_SYSREG(0, 0, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR0_EL1, HVF_SYSREG(0, 0, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR0_EL1, HVF_SYSREG(0, 0, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR0_EL1, HVF_SYSREG(0, 0, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR1_EL1, HVF_SYSREG(0, 1, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR1_EL1, HVF_SYSREG(0, 1, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR1_EL1, HVF_SYSREG(0, 1, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR1_EL1, HVF_SYSREG(0, 1, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR2_EL1, HVF_SYSREG(0, 2, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR2_EL1, HVF_SYSREG(0, 2, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR2_EL1, HVF_SYSREG(0, 2, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR2_EL1, HVF_SYSREG(0, 2, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR3_EL1, HVF_SYSREG(0, 3, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR3_EL1, HVF_SYSREG(0, 3, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR3_EL1, HVF_SYSREG(0, 3, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR3_EL1, HVF_SYSREG(0, 3, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR4_EL1, HVF_SYSREG(0, 4, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR4_EL1, HVF_SYSREG(0, 4, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR4_EL1, HVF_SYSREG(0, 4, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR4_EL1, HVF_SYSREG(0, 4, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR5_EL1, HVF_SYSREG(0, 5, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR5_EL1, HVF_SYSREG(0, 5, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR5_EL1, HVF_SYSREG(0, 5, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR5_EL1, HVF_SYSREG(0, 5, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR6_EL1, HVF_SYSREG(0, 6, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR6_EL1, HVF_SYSREG(0, 6, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR6_EL1, HVF_SYSREG(0, 6, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR6_EL1, HVF_SYSREG(0, 6, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR7_EL1, HVF_SYSREG(0, 7, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR7_EL1, HVF_SYSREG(0, 7, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR7_EL1, HVF_SYSREG(0, 7, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR7_EL1, HVF_SYSREG(0, 7, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR8_EL1, HVF_SYSREG(0, 8, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR8_EL1, HVF_SYSREG(0, 8, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR8_EL1, HVF_SYSREG(0, 8, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR8_EL1, HVF_SYSREG(0, 8, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR9_EL1, HVF_SYSREG(0, 9, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR9_EL1, HVF_SYSREG(0, 9, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR9_EL1, HVF_SYSREG(0, 9, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR9_EL1, HVF_SYSREG(0, 9, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR10_EL1, HVF_SYSREG(0, 10, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR10_EL1, HVF_SYSREG(0, 10, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR10_EL1, HVF_SYSREG(0, 10, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR10_EL1, HVF_SYSREG(0, 10, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR11_EL1, HVF_SYSREG(0, 11, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR11_EL1, HVF_SYSREG(0, 11, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR11_EL1, HVF_SYSREG(0, 11, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR11_EL1, HVF_SYSREG(0, 11, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR12_EL1, HVF_SYSREG(0, 12, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR12_EL1, HVF_SYSREG(0, 12, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR12_EL1, HVF_SYSREG(0, 12, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR12_EL1, HVF_SYSREG(0, 12, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR13_EL1, HVF_SYSREG(0, 13, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR13_EL1, HVF_SYSREG(0, 13, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR13_EL1, HVF_SYSREG(0, 13, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR13_EL1, HVF_SYSREG(0, 13, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR14_EL1, HVF_SYSREG(0, 14, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR14_EL1, HVF_SYSREG(0, 14, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR14_EL1, HVF_SYSREG(0, 14, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR14_EL1, HVF_SYSREG(0, 14, 2, 0, 7) },
-
-    { HV_SYS_REG_DBGBVR15_EL1, HVF_SYSREG(0, 15, 2, 0, 4) },
-    { HV_SYS_REG_DBGBCR15_EL1, HVF_SYSREG(0, 15, 2, 0, 5) },
-    { HV_SYS_REG_DBGWVR15_EL1, HVF_SYSREG(0, 15, 2, 0, 6) },
-    { HV_SYS_REG_DBGWCR15_EL1, HVF_SYSREG(0, 15, 2, 0, 7) },
-
-#ifdef SYNC_NO_RAW_REGS
-    /*
-     * The registers below are manually synced on init because they are
-     * marked as NO_RAW. We still list them to make number space sync easier.
-     */
-    { HV_SYS_REG_MDCCINT_EL1, HVF_SYSREG(0, 2, 2, 0, 0) },
-    { HV_SYS_REG_MIDR_EL1, HVF_SYSREG(0, 0, 3, 0, 0) },
-    { HV_SYS_REG_MPIDR_EL1, HVF_SYSREG(0, 0, 3, 0, 5) },
-    { HV_SYS_REG_ID_AA64PFR0_EL1, HVF_SYSREG(0, 4, 3, 0, 0) },
-#endif
-    { HV_SYS_REG_ID_AA64PFR1_EL1, HVF_SYSREG(0, 4, 3, 0, 1) },
-    { HV_SYS_REG_ID_AA64DFR0_EL1, HVF_SYSREG(0, 5, 3, 0, 0) },
-    { HV_SYS_REG_ID_AA64DFR1_EL1, HVF_SYSREG(0, 5, 3, 0, 1) },
-    { HV_SYS_REG_ID_AA64ISAR0_EL1, HVF_SYSREG(0, 6, 3, 0, 0) },
-    { HV_SYS_REG_ID_AA64ISAR1_EL1, HVF_SYSREG(0, 6, 3, 0, 1) },
-#ifdef SYNC_NO_MMFR0
-    /* We keep the hardware MMFR0 around. HW limits are there anyway */
-    { HV_SYS_REG_ID_AA64MMFR0_EL1, HVF_SYSREG(0, 7, 3, 0, 0) },
-#endif
-    { HV_SYS_REG_ID_AA64MMFR1_EL1, HVF_SYSREG(0, 7, 3, 0, 1) },
-    { HV_SYS_REG_ID_AA64MMFR2_EL1, HVF_SYSREG(0, 7, 3, 0, 2) },
-    /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
-
-    { HV_SYS_REG_MDSCR_EL1, HVF_SYSREG(0, 2, 2, 0, 2) },
-    { HV_SYS_REG_SCTLR_EL1, HVF_SYSREG(1, 0, 3, 0, 0) },
-    { HV_SYS_REG_CPACR_EL1, HVF_SYSREG(1, 0, 3, 0, 2) },
-    { HV_SYS_REG_TTBR0_EL1, HVF_SYSREG(2, 0, 3, 0, 0) },
-    { HV_SYS_REG_TTBR1_EL1, HVF_SYSREG(2, 0, 3, 0, 1) },
-    { HV_SYS_REG_TCR_EL1, HVF_SYSREG(2, 0, 3, 0, 2) },
-
-    { HV_SYS_REG_APIAKEYLO_EL1, HVF_SYSREG(2, 1, 3, 0, 0) },
-    { HV_SYS_REG_APIAKEYHI_EL1, HVF_SYSREG(2, 1, 3, 0, 1) },
-    { HV_SYS_REG_APIBKEYLO_EL1, HVF_SYSREG(2, 1, 3, 0, 2) },
-    { HV_SYS_REG_APIBKEYHI_EL1, HVF_SYSREG(2, 1, 3, 0, 3) },
-    { HV_SYS_REG_APDAKEYLO_EL1, HVF_SYSREG(2, 2, 3, 0, 0) },
-    { HV_SYS_REG_APDAKEYHI_EL1, HVF_SYSREG(2, 2, 3, 0, 1) },
-    { HV_SYS_REG_APDBKEYLO_EL1, HVF_SYSREG(2, 2, 3, 0, 2) },
-    { HV_SYS_REG_APDBKEYHI_EL1, HVF_SYSREG(2, 2, 3, 0, 3) },
-    { HV_SYS_REG_APGAKEYLO_EL1, HVF_SYSREG(2, 3, 3, 0, 0) },
-    { HV_SYS_REG_APGAKEYHI_EL1, HVF_SYSREG(2, 3, 3, 0, 1) },
-
-    { HV_SYS_REG_SPSR_EL1, HVF_SYSREG(4, 0, 3, 0, 0) },
-    { HV_SYS_REG_ELR_EL1, HVF_SYSREG(4, 0, 3, 0, 1) },
-    { HV_SYS_REG_SP_EL0, HVF_SYSREG(4, 1, 3, 0, 0) },
-    { HV_SYS_REG_AFSR0_EL1, HVF_SYSREG(5, 1, 3, 0, 0) },
-    { HV_SYS_REG_AFSR1_EL1, HVF_SYSREG(5, 1, 3, 0, 1) },
-    { HV_SYS_REG_ESR_EL1, HVF_SYSREG(5, 2, 3, 0, 0) },
-    { HV_SYS_REG_FAR_EL1, HVF_SYSREG(6, 0, 3, 0, 0) },
-    { HV_SYS_REG_PAR_EL1, HVF_SYSREG(7, 4, 3, 0, 0) },
-    { HV_SYS_REG_MAIR_EL1, HVF_SYSREG(10, 2, 3, 0, 0) },
-    { HV_SYS_REG_AMAIR_EL1, HVF_SYSREG(10, 3, 3, 0, 0) },
-    { HV_SYS_REG_VBAR_EL1, HVF_SYSREG(12, 0, 3, 0, 0) },
-    { HV_SYS_REG_CONTEXTIDR_EL1, HVF_SYSREG(13, 0, 3, 0, 1) },
-    { HV_SYS_REG_TPIDR_EL1, HVF_SYSREG(13, 0, 3, 0, 4) },
-    { HV_SYS_REG_CNTKCTL_EL1, HVF_SYSREG(14, 1, 3, 0, 0) },
-    { HV_SYS_REG_CSSELR_EL1, HVF_SYSREG(0, 0, 3, 2, 0) },
-    { HV_SYS_REG_TPIDR_EL0, HVF_SYSREG(13, 0, 3, 3, 2) },
-    { HV_SYS_REG_TPIDRRO_EL0, HVF_SYSREG(13, 0, 3, 3, 3) },
-    { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
-    { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
-    { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
+#include "sysreg.c.inc"
 };
 
+#undef DEF_SYSREG
+
 int hvf_get_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
new file mode 100644
index 0000000000..222698f1d1
--- /dev/null
+++ b/target/arm/hvf/sysreg.c.inc
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 0, 0, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 0, 0, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 0, 0, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 0, 0, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 0, 1, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 0, 1, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 0, 1, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 0, 1, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 0, 2, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 0, 2, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 0, 2, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 0, 2, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 0, 3, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 0, 3, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 0, 3, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 0, 3, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 0, 4, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 0, 4, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 0, 4, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 0, 4, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 0, 5, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 0, 5, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 0, 5, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 0, 5, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 0, 6, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 0, 6, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 0, 6, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 0, 6, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 0, 7, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 0, 7, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 0, 7, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 0, 7, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 0, 8, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 0, 8, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 0, 8, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 0, 8, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 0, 9, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 0, 9, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 0, 9, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 0, 9, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 0, 10, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 0, 10, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 0, 10, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 0, 10, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 0, 11, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 0, 11, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 0, 11, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 0, 11, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 0, 12, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 0, 12, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 0, 12, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 0, 12, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 0, 13, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 0, 13, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 0, 13, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 0, 13, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 0, 14, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 0, 14, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 0, 14, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 0, 14, 2, 0, 7)
+
+DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 0, 15, 2, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 0, 15, 2, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 0, 15, 2, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 0, 15, 2, 0, 7)
+
+#ifdef SYNC_NO_RAW_REGS
+/*
+ * The registers below are manually synced on init because they are
+ * marked as NO_RAW. We still list them to make number space sync easier.
+ */
+DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 0, 2, 2, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 0, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 0, 0, 3, 0, 5)
+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 0, 4, 3, 0, 0)
+#endif
+
+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 0, 4, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 0, 5, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 0, 5, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 0, 6, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 0, 6, 3, 0, 1)
+
+#ifdef SYNC_NO_MMFR0
+/* We keep the hardware MMFR0 around. HW limits are there anyway */
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 0, 7, 3, 0, 0)
+#endif
+
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 0, 7, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 0, 7, 3, 0, 2)
+/* Add ID_AA64MMFR3_EL1 here when HVF supports it */
+
+DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 0, 2, 2, 0, 2)
+DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 1, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 1, 0, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 2, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 2, 0, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_TCR_EL1, 2, 0, 3, 0, 2)
+
+DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 2, 1, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 2, 1, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 2, 1, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 2, 1, 3, 0, 3)
+DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 2, 2, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 2, 2, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 2, 2, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 2, 2, 3, 0, 3)
+DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 2, 3, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 2, 3, 3, 0, 1)
+
+DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 4, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ELR_EL1, 4, 0, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_SP_EL0, 4, 1, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 5, 1, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 5, 1, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ESR_EL1, 5, 2, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_FAR_EL1, 6, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_PAR_EL1, 7, 4, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 10, 2, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 10, 3, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 12, 0, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 13, 0, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 13, 0, 3, 0, 4)
+DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 14, 1, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 0, 0, 3, 2, 0)
+DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 13, 0, 3, 3, 2)
+DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 13, 0, 3, 3, 3)
+DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 14, 3, 3, 3, 1)
+DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 14, 3, 3, 3, 2)
+DEF_SYSREG(HV_SYS_REG_SP_EL1, 4, 1, 3, 4, 0)
-- 
2.43.0


