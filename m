Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573B2C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUM-0007XG-KW; Fri, 08 Mar 2024 10:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUJ-0007I5-M7
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:23 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUG-0004Ob-TN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:23 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41316084f08so8746515e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913019; x=1710517819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Sm35nBBjeyJtKOD4iPFn/FW++KVU08Dtn0CIVkC0JA=;
 b=nQsbeTKMbywyU1lzrJMuO9n85LzjZUiNlrErcyMPY5wmBErK1/oNQbNbj4BBRz+5G3
 C2GKdq3fHboC2NN+r/+Eih+Lp41izZfwPYd5iQVyCgBfA1bzgxyB5jiUBZRuArjG8PxT
 FJOoXDYNFhUdq8LdKk+9H3zEID6JDF326h20Qk85Pybx9pKOgd6I5iZoNqvlazqPOi39
 pWOlt55TBM+IG3gMuap+LsUt9bBr7BCwILwycw/kqTAcIGueGraYeYS5UvRnNr7IeEII
 /AXTGg05lkEAXEzaWj/EVDoLf8I18DHCEDet8zmpbMfXPwOprfpTC9gmO5/gHXF21PB7
 62Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913019; x=1710517819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Sm35nBBjeyJtKOD4iPFn/FW++KVU08Dtn0CIVkC0JA=;
 b=MPSIrFNJFRQxCDHEYk5eDq+amkabf6r+YeK7k3UNO/n5eR6VTP48gjSBrKFkQzpqBt
 HhNMymwM0AL17OsG9iYeHKOjqfZSFEfePdBKLsJxjpNCIvvEecMAitUWdpaqo5m/sSAo
 7sXp+KCYrLNZHYJ0AJpx1qK306gAZB+vpqeD/Z36FqHmJt4XJBHYiaBPZpMJsSivEhlM
 7cM7tajqK38LX7HhlTv7OZHt7BMkhLLZUvy1UMuGzM1aPzF58miA+qdY6wjiVzzY3nKb
 eJftoTmiwJdT5CEMgrqvQyTAkqy/pDDfStIq4+xyolcvfRL7VvzSj+v9qMRkcKOPj9nM
 c6sQ==
X-Gm-Message-State: AOJu0YzkfDrHiY+t56y9qvELNUk+zHTzkr7Rbzt3IqfM96sI3YXiw6m8
 PSFiNZfUBrhU1xFGvVFyZdGUEtCtSEH544cekMi85RbIflJBadKLy5tVzZXsa9nwo753e9LGKsW
 H
X-Google-Smtp-Source: AGHT+IFm+WwSrksjnt/KOBtMvX9zZwUXWNAEKZluAqIlnIBX+KZ2D1D1mdtiPGXgRBCImrIKf9YOGQ==
X-Received: by 2002:adf:ea8d:0:b0:33e:74ce:6121 with SMTP id
 s13-20020adfea8d000000b0033e74ce6121mr2044876wrm.3.1709913019231; 
 Fri, 08 Mar 2024 07:50:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/14] target/arm: Define CNTPCTSS_EL0 and CNTVCTSS_EL0
Date: Fri,  8 Mar 2024 15:50:07 +0000
Message-Id: <20240308155015.3637663-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For FEAT_ECV, new registers CNTPCTSS_EL0 and CNTVCTSS_EL0 are
defined, which are "self-synchronized" views of the physical and
virtual counts as seen in the CNTPCT_EL0 and CNTVCT_EL0 registers
(meaning that no barriers are needed around accesses to them to
ensure that reads of them do not occur speculatively and out-of-order
with other instructions).

For QEMU, all our system registers are self-synchronized, so we can
simply copy the existing implementation of CNTPCT_EL0 and CNTVCT_EL0
to the new register encodings.

This means we now implement all the functionality required for
ID_AA64MMFR0_EL1.ECV == 0b0001.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301183219.2424889-7-peter.maydell@linaro.org
---
 target/arm/helper.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 46e0c3c4fcc..68b5d6a4cb0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3389,6 +3389,34 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
 };
 
+/*
+ * FEAT_ECV adds extra views of CNTVCT_EL0 and CNTPCT_EL0 which
+ * are "self-synchronizing". For QEMU all sysregs are self-synchronizing,
+ * so our implementations here are identical to the normal registers.
+ */
+static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
+    { .name = "CNTVCTSS", .cp = 15, .crm = 14, .opc1 = 9,
+      .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = gt_vct_access,
+      .readfn = gt_virt_cnt_read, .resetfn = arm_cp_reset_ignore,
+    },
+    { .name = "CNTVCTSS_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 6,
+      .access = PL0_R, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = gt_vct_access, .readfn = gt_virt_cnt_read,
+    },
+    { .name = "CNTPCTSS", .cp = 15, .crm = 14, .opc1 = 8,
+      .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = gt_pct_access,
+      .readfn = gt_cnt_read, .resetfn = arm_cp_reset_ignore,
+    },
+    { .name = "CNTPCTSS_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 5,
+      .access = PL0_R, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn = gt_pct_access, .readfn = gt_cnt_read,
+    },
+};
+
 #else
 
 /*
@@ -3422,6 +3450,18 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
 };
 
+/*
+ * CNTVCTSS_EL0 has the same trap conditions as CNTVCT_EL0, so it also
+ * is exposed to userspace by Linux.
+ */
+static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
+    { .name = "CNTVCTSS_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 6,
+      .access = PL0_R, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .readfn = gt_virt_cnt_read,
+    },
+};
+
 #endif
 
 static void par_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
@@ -9258,6 +9298,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
         define_arm_cp_regs(cpu, generic_timer_cp_reginfo);
     }
+    if (cpu_isar_feature(aa64_ecv_traps, cpu)) {
+        define_arm_cp_regs(cpu, gen_timer_ecv_cp_reginfo);
+    }
     if (arm_feature(env, ARM_FEATURE_VAPA)) {
         ARMCPRegInfo vapa_cp_reginfo[] = {
             { .name = "PAR", .cp = 15, .crn = 7, .crm = 4, .opc1 = 0, .opc2 = 0,
-- 
2.34.1


