Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916F0CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3U-00078n-8E; Tue, 13 Oct 2026 04:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY35-0006qy-Ey
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY33-0007aj-LJ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48b0d19cf7eso3172940f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880788; x=1792485588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e279h5aviwj2Oil4aweVMx7m2/REtZvKy9eOEgndrbI=;
 b=wWfs3F1kJ27omE8c/NesPbup95SAdr76iQFQjmA+crCJt/C2lHNs5/eboYZWVT9wzt
 Ml1JsfvneNBSkmC8BX8uOJCEg2yz5l0PgHj1NrEjEuAcdvc++/AZZlwfDwO8WVOU4OoQ
 uQNQxaV563qutbFer+GQhWTHFC7/LSHe3eQSC6WUsMPw4SkHgpUCkKTgXFCw07LmVVu5
 RAFb1KS4MG/5Fhv1DhTCH5h9VawdA8WO+HahUUbbX6uMCqlsSrusB7cbF4eo0kzDlFwm
 Y0A/Wz3t24g1hf1wMnebGGDzkOYIa2OntWIhFuJGCO7QadZeh2IdzC07BgNAiocERxAE
 PNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880788; x=1792485588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e279h5aviwj2Oil4aweVMx7m2/REtZvKy9eOEgndrbI=;
 b=U3Qf10eN6b+xxwELl7t+1fcXIuO9s7IBBrU8c7ay5dDdyy2N7gCdPHwGgVmePUSuzq
 ZGc0zrfsE3evPDaxVoPuBTNwpUL3ulV2n2K0X+3+v2KC+RHrVnSWmtmYs5nF8oA84OP+
 DPYTx8RFJ3hmNncP+OB+a/0HyTDgt5xhcaZNbua+XxJTaZWB+JYHUDQBW7AHtcvPeCVz
 hEnHA99Hs7ASTZpLgEiwE1Wf8nx1B441PX+CnJNxeKzDLAQTXljykFa+W3D/imo6Mx3r
 9ROAebxyhtL9RDLN/gdWhKwoohbqPLbKlEiOa7Yp06HnKkMVCuo7gzsO3W1lW2TDGmPC
 e/KQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB5U1D2/oItoVSFYoJGw225O+uFbBzUgi+ZzO2LKGBwElEN58WEAQ080B30t1MvcfYRSC/yvhmr7np@nongnu.org
X-Gm-Message-State: AFq9FYLCjvkE7om2v0jbANhRn+1McSbUjDTn8HNo22tje0690s6pBoKn
 n/e4amroIEhjFbaI5KJJhJrfdZolqZgsqGKJVbl0XC8+5AfecOxg6oOzNRVss3sQnyw=
X-Gm-Gg: AYBFou1htAOhDoguUYICqRItQSu+gRnRYHbkxyMvftEZ9kWio0E9SfJbjuKkQMcyEo4
 fDqGFyFsWWDfzPo3WdtEcZB8WcxcCm9d8gHjW0YqPC0u0cfpxSWBUAumKRt/MBSFI9jepBtdJ7S
 l9Xn8VF1lNf3+Qehen7ToCQ9TlFx549QDSbkRWx9IFAv5pcAXnhzJ8vYiIpFu7IJf4Rr5O93n2z
 lGzVUobwMcEQVLJ79OiI0uaI66cNPQ4OT1i1pNBPfJ5YiWYKNN1QmCRzLT/ico4NNoRntJf7NoS
 8pPdecemiBAhzHE/lBwbC7lAFYPqD/IJdPpQHZvijXkp1z4EmzDpBkJ+qmYAmxmPxE2WuxUZbPw
 +VdV/P+QZZd1yH0iW6z4JVPI2zV+WUOnug7bnfCo8TlEqsBQoxpF1al9MlcNpqDxfqtJvT1edLI
 cL052u/9h7ujXMEpGA4mrvnDh0rrTk3HWoljVB3XYFdU4RWUL6+1zngODddBfaWFy94/KTJYHs4
 zMuHdRdYWWtwWWu9lqjHvtO1FIYkEIZZMA3FxVm0J8WCFc6dKLAHuBLfaY+W2pYUhp2wONvwfUx
 cWg=
X-Received: by 2002:a05:600c:5254:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4a18e4aa11dmr239412455e9.16.1791880788130; 
 Tue, 13 Oct 2026 01:39:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/86] target/arm: Only allow GICv5 on CPUs without AArch32 at
 EL1..3
Date: Tue, 13 Oct 2026 09:38:15 +0100
Message-ID: <20261013083933.1024405-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

We previously allowed the GICv5 on any 64-bit CPU, with a hack where
enabling the GICv5 silently disabled AArch32 for EL1..3.

Now that we have a separate 'max-v8' and 'max-v9' where max-v9
correctly doesn't implement AArch32 at EL1..3, we can fix the "when
do we expose the has_gcie property" condition so that we only allow
the GICv5 when AArch32 doesn't exist above EL0, and remove the hack
disabling AArch32.

We could instead have defined a new ARM_FEATURE_V9, but "allow the
feature to be present on CPUs where it doesn't actively break
anything" fits the way we've generally handled things in QEMU, and it
avoids having a new V9 feature bit that we only use for this one
thing and where it's not clear when we should be setting it for KVM,
hvf, etc accelerators.

In practice the only CPUs which will allow GICv5 now are max, max-v9
and a64fx.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  8 ++++++++
 target/arm/cpu.c          | 37 +++++++------------------------------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a9eebb45564..3322d65fc19 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1130,6 +1130,14 @@ static inline bool isar_feature_aa64_aa32_el3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL3) >= 2;
 }
 
+static inline bool isar_feature_aa64_aa32_above_el0(const ARMISARegisters *id)
+{
+    /* True if any EL above EL0 has AArch32 support */
+    return isar_feature_aa64_aa32_el1(id) ||
+        isar_feature_aa64_aa32_el2(id) ||
+        isar_feature_aa64_aa32_el3(id);
+}
+
 static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RAS) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 014ec6a945e..d9e6d1ad771 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1594,8 +1594,13 @@ static void arm_cpu_post_init(Object *obj)
                                        &cpu->rvbar_prop,
                                        OBJ_PROP_FLAG_READWRITE);
 
-        /* We only allow GICv5 on a 64-bit v8 CPU */
-        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        /*
+         * We only allow GICv5 on a CPU with no AArch32 support above EL0
+         * (which is typically a v9 CPU), because GICv5 defines no AArch32
+         * system registers to control it.
+         */
+        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
+            !cpu_isar_feature(aa64_aa32_above_el0, cpu)) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_gcie_property);
         }
     }
@@ -2249,34 +2254,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     /* Report FEAT_GCIE in our ID registers if property was set */
     FIELD_DP64_IDREG(isar, ID_AA64PFR2, GCIE, cpu->has_gcie);
-    if (cpu_isar_feature(aa64_gcie, cpu)) {
-        if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
-            /*
-             * We only create the have_gcie property for AArch64 CPUs,
-             * but the user might have tried aarch64=off with has_gcie=on.
-             */
-            error_setg(errp, "Cannot both enable has_gcie and disable aarch64");
-            return;
-        }
-
-        /*
-         * FEAT_GCIE implies Armv9, which implies no AArch32 above EL0.
-         * Usually we don't strictly insist on this kind of feature
-         * dependency, but in this case we enforce it, because the
-         * GICv5 CPU interface has no AArch32 versions of its system
-         * registers, so interrupts wouldn't work if we allowed AArch32
-         * in EL1 or above. Downgrade "AArch32 and AArch64" to "AArch64".
-         */
-        if (cpu_isar_feature(aa64_aa32_el3, cpu)) {
-            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL3, 1);
-        }
-        if (cpu_isar_feature(aa64_aa32_el2, cpu)) {
-            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL2, 1);
-        }
-        if (cpu_isar_feature(aa64_aa32_el1, cpu)) {
-            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL1, 1);
-        }
-    }
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
         /*
-- 
2.43.0


