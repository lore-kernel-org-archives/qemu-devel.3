Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D352C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Yzz-0006Hg-CY; Mon, 07 Sep 2026 09:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Yze-0006AU-DV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Yzb-00051i-8r
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so42414515e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786154; x=1789390954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PECZI3QBNqqLr6ePRzJzDKHA0mATh/ie5d5BiyY28gQ=;
 b=dNUTJ4tcQTEfv+Fu0tEgF2bpVXZyJ9svixDWNIihYctLxLCzkaLB2oG4B8aD1LCXTS
 MITvyfy+t+gXK/TBKPQhm3Z78CLm464HqONW8csyH0n5ZuKeSsUyqrklkSESNaFlIVNL
 dgmTdHexS3WvhTf69WiLaRLm0hdTmRpWFYRM+9HFnAq1m916eDPxJROgZPSfKZn3lIDb
 anonCE1be4dFoM4I2k+PiXZhvq9/qMR08hRuH2PxJqkhTQYfBWZRLY257RikSW+aDI5J
 8lxAkb4Wd5By1ueq2RcpgOqFlAYoivmcjmKcNImMdr8AjkPSvF4aUQ8divLwsKjen/9U
 sVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786154; x=1789390954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PECZI3QBNqqLr6ePRzJzDKHA0mATh/ie5d5BiyY28gQ=;
 b=fygTecSTzlr4DUidLPn5R/lGr5e9L6t3Vkp0C8prAJrJxplbd6NrQXTwV8w1Cck+62
 tj9hygIb4H8RbhQl4bdc2LhopcvTwwOT1lccOiyoUvK4opKt6AjIeM5C8rih/cb1x+IK
 BE4z5b/4gCaRmMNY9mwq3Bp6xZVFsMeAIgptj4zAGepzeCNv076oGlPnQay8Ji6SYhnH
 wCmdE8MXcLKUd4n2NIeKLjipQqxPAdRyY94Jz+jVMs8yOtNzTcHMNF3/bHwSxE/irGCC
 2vZtgxZZORfPr1eooMkySk5aMbv1/yUbRQF9Xv2msObVNTJzNW1XdQ7MLzWOh0+zjTLW
 nHAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBywvbTNjUPIfT3Up9X5Jixf4sI/bBxxDKzkADFFxH9eHgQlX5kLSacS3TsTF4FOPN/bmdCyAuvBHc3g@nongnu.org
X-Gm-Message-State: AFuF++mMiTnVwcxoCMZBu3bfONsVIeD0AyTJ8lhVOnOzH7DRtUx9oSvC
 aO9NK+JdPhB8VXH9tD5+HISJwCgldaCedYevT7n7bH/9vZoYMvB0K/SBhgJutv0bgzI=
X-Gm-Gg: AYBFou21r4C+AZ7zs1KIpRKKfoK0rAjp7YeDMSaF9O6EeAcBpPQ8bq2oPiJmUpPn7ve
 lcXZOwuNzHDc1ohf4dngzbJwAOHadSbmm3KwlFkmeLqS3DXvX4V3av6MCJ8I18Wr/SLak4lh+4R
 GtlTY2/0n7VPD2+4tnu0Dn5WqIAF+BCENg+RdmugOY/4H03Y5s6QBfQ5zKBainjuQt2LXnNQORh
 JIX2OwoTExSuVzEncfpDE1V3d32G2n+CNujQd6aYTlZT/uBZSjvMBygT9wcRqktBhZDww7Fm/AB
 bVM5sqhM4Jlk+DafUQOcq/F+EUJxLBYd8msCSJIKEz3EbPjPAbIvNWPAtcSoMAtvFSmyRIwsAvW
 JfmU4Xpfts3PWTpqVUb1why7JZxSXXLMO/+hCl5FTodrVBrW7os8X1aWhR/7PcJYq6gJnmgrlD7
 L/5ZyJOZy7fz770PZUYNERTsCeGnLZaP+D+u9FNUe3q9qUKB2+8MKjJ+tVGEgoALn2JYBbb6+qB
 bhG9rjIFSu9tihXWrIkxBkKs3IeknWNrYmj8lzRcA22Ssc42paDIkiIaUhzsBCDzI3aVw==
X-Received: by 2002:a05:600c:1914:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-49cf8269fdfmr222267565e9.13.1788786153787; 
 Mon, 07 Sep 2026 06:02:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm468589935e9.9.2026.09.07.06.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
Subject: [PATCH 7/8] target/arm: Don't register 64-bit TTBR0, TTBR1 for PMSA
Date: Mon,  7 Sep 2026 14:02:22 +0100
Message-ID: <20260907130223.3148989-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907130223.3148989-1-peter.maydell@linaro.org>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

We register the 64-bit versions of TTBR0 and TTBR1 in
lpae_cp_reginfo[], marking them as ARM_CP_ALIAS because the AArch64
definitions in vmsa_cp_reginfo[] will handle their migration.

However, this means that we are also defining these registers as
present in the Cortex-R52, which is a v8R PMSA CPU.  v8R does define
AMAIR0, AMAIR1 and the PAR, but does not have TTBR0 or TTBR1.

Split the TTBR0 and TTBR1 definitions into a new lpae_vmsa_cp_reginfo
which we only register when we have both LPAE and VMSA.

This is a migration break for Cortex-R52 CPUs (which we don't use in
any versioned machine type).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Detected because we ended up with the CP_ALIAS TTBR[01] registered
but not the TTBR[01]_EL1 cpregs that handled the migration.
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4028e0eba6..b41e07e84b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3098,6 +3098,9 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .access = PL1_RW, .type = ARM_CP_64BIT, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.par_s),
                              offsetof(CPUARMState, cp15.par_ns)} },
+};
+
+static const ARMCPRegInfo lpae_vmsa_cp_reginfo[] = {
     { .name = "TTBR0", .cp = 15, .crm = 2, .opc1 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
@@ -7226,6 +7229,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         define_arm_cp_regs(cpu, lpae_cp_reginfo);
+        if (!arm_feature(env, ARM_FEATURE_PMSA)) {
+            define_arm_cp_regs(cpu, lpae_vmsa_cp_reginfo);
+        }
     }
     if (cpu_isar_feature(aa32_jazelle, cpu)) {
         define_arm_cp_regs(cpu, jazelle_regs);
-- 
2.43.0


