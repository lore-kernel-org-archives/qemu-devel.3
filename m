Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD758CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWaR-0005os-MU; Tue, 16 Sep 2025 10:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWa4-0005ix-5J
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:55 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWZw-0008Hn-Uz
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-25d44908648so53122775ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032563; x=1758637363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CLvOjXal/wRoc/wLSYOsvhQgX3fvH+M30NDHTCz0Cg=;
 b=kJEgu6l1/wDnAiy/CR/hN4bYeEh7eOmRcuafuzeRa4SU440ssf0PSJdqOL9fbAK0b1
 GeAB9ES7bG2801Fkto17/xXLHuOfX+jhh+tYVWIj5Lj0Wu5HPEYle1v+qzN21qFCh9Zn
 Uuk3daBc+ajRNPbZSegfpEzsSwN3A8tlD4ONkXPh6j554UjyPVKYFgOs4vZk7FPiWjmG
 tPOp5senSOLS606cju+ASdh0GYtsUcdx+5n9dMT5PB9SBGo2mdWZGenJ4rlEoKdJbRA3
 S5ta70pAHumIq26EwcmTMlh2uZvlV2Baj9WyTwTQoBvpJxWGBZmZW5pQkzZdPrzCii5d
 VSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032563; x=1758637363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CLvOjXal/wRoc/wLSYOsvhQgX3fvH+M30NDHTCz0Cg=;
 b=NcRsYTUZirhtZNIYH7PniKtUUOZA11jHD1X4i2r4n6h9c/wjBMQjH+r7x9j3vUfAP/
 x3/mlgC5hc17YrW3Suvhr7kIXn4LkQYkR2hozBe7/Q3TOeWj3cdvTIWc3SaheRfeJ4SW
 7Jl9cTqd5/BF+6c9t0nDep1iLVWAa5tp7hxeSSL+ix9q8VzZU5Gx/E/n8VnsuBIkvIyX
 8hJk6VyfOsmVDb7BUA9vHjg9tIkur7TpDXVVWpLaNB+P8gjhrTjzAe0Oh+VlsGZ6RkWC
 /y3pUzgEhZNuQL/FR2neNpsq1z1/DQF/KibTAzmhHHF53TMYSCjeXGiazRK/wuWgcG45
 VMlg==
X-Gm-Message-State: AOJu0Yx+Sgam2q6J3vmzW4Cfpa1V8WrJRKObcHte3Qvp/j3f5sObW0sm
 U0HRZtmA2WziwWtdEdNn51Q75LU/rMPcNa9EF+xgfX59mfi5gpRTSnjRwwCJJE/buZgux7Ay93p
 FmvBn
X-Gm-Gg: ASbGncsP2I1Oay0Sd9ImCijSp2RINCMLrxbuB9sN4DiLlkR3HsvwUWg7RzOiQySLdya
 dJjPfwnfUwqgUNehBjE77sZpXFWNyimOYfkLV4xl1X9kDHbL17mhorRxPmR9foYL9b5UdJ6zzyJ
 kykURM5/gmm4MDPbMCVK0CGDsEGQzqZvxDk76cx3QjMuKFGg4KQ1W7I5hBOqgqsKugOJ8ECnPQM
 ODl5EYLwV2xNXsSGHobmptk2XlSnUSJoyApXl044JZDszTAz/MyApQBbpwiNMx04UL+1fGcTWOF
 6SZhAnkQw7H5KxUWaIdmssRwMm+T7QnFIMDSgbzBzi5XjZLcryJpfBKLFDhSkc7mBDedB5jZoq0
 64JOWxuP7Q9e+LHUVAA9T4Bsfdf3V
X-Google-Smtp-Source: AGHT+IEgFYRalaSvs5S3aALfeRi2yL5MiMSg+po6K/v7tJPJ0muDCVCpraHKy73OVqaPuM1ISoTwDg==
X-Received: by 2002:a17:903:384b:b0:24e:95bb:88b1 with SMTP id
 d9443c01a7336-25d267641f0mr178771905ad.34.1758032561755; 
 Tue, 16 Sep 2025 07:22:41 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 03/36] target/arm/hvf: Split out sysreg.c.inc
Date: Tue, 16 Sep 2025 07:22:04 -0700
Message-ID: <20250916142238.664316-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        | 147 ++----------------------------------
 target/arm/hvf/sysreg.c.inc | 146 +++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 141 deletions(-)
 create mode 100644 target/arm/hvf/sysreg.c.inc

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b77db99079..9f8e3083b4 100644
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


