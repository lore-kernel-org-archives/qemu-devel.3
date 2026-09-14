Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB0DC88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x697d-0004Cq-1e; Mon, 14 Sep 2026 12:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696i-0003F3-ED
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:37 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696f-0004eK-LV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:35 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so681857f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789401632; x=1790006432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tvOn/pAIjzvCed7vyXKyUkE525/C0NZBVLFzB/DrGUI=;
 b=Wq7W+bhichAtZQhMLjmullrqYyP3wd5SW3KFAeaR8BCL6T4SHsjEKGcLa9BaKrZkcg
 Mj1FRDd+YgCAXbX4mhLAe+mIlR7y9aoBw2p22x+mA5ZXMpNQKuw96MUXsP+eX77ZqxJ4
 CAb4p8kDR5W5knHjcZuKqQxysEE98bT24ADx+ge7oGzIF3z9oemAx9Bpau6qNIDWpsCk
 bXDr3dV5J8Cb+xQqo6DgRmen95po3sStTe+R9+KKmPLxkBsej9Rhg+VNZ8v0gnTH1FO5
 AW+vdCZniQepDCBRK1acup9QQlVIE/51UlOPYazIkm+oOXjiSkBFBSZ5wQWnKHMTwKmY
 nK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401632; x=1790006432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tvOn/pAIjzvCed7vyXKyUkE525/C0NZBVLFzB/DrGUI=;
 b=ZpZueLAiM8kl1pjYmqcE0ll0gxjJQTGvZMNBjlAFk1ckYunhTMHqFX1VqUxVhJBh7X
 NCwhBXleujqEJucsAIf4JAzGhTJSwqrXO4nZR44nREQ8DKxfKJRhtVBdBfa/QTcVDISW
 wVLq+r5oZMVesep0uLSKW65NrhdXx3cF8lyjrg6FeN3WrnPJ9QR+wAe1xraR6gZJ++bM
 VF0ZI/S8Sh/zj0wAYNGlz183XH72B/nk9gM4m3n5EQ2e7HMPOwlJJufmWXt6tSzWI6Ox
 cBTgPAh3eP6HJZM8v8VruCKSVE4t/Dcxs11mhCvR1sOviW4IpeHCitlZyLsfH7sRBDFp
 CfRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0xxNnZefchG5soIKqGyi3wxykH+DBm9k/CZ9FhBdzMN+AAOVmd7MkDT8U1A6vVa9bKSFw65URvH5T@nongnu.org
X-Gm-Message-State: AFuF++l52zas4BBKj6mgQdGY2C6Fb7GNnVKsfed4Q56hBrgC3ckBmVjM
 4wxTsPqPrZ6hZyGwQvhLCID+Qqd8EFFRTDfN61mZUDwNz6sO1f8uoZUxxrNOf64CYkNcgaZQlU0
 ZbhHSteo=
X-Gm-Gg: AYBFou0Seh2fwqC8s45k3U5Z353lmeCIg3fqGwR5e+tq9GvS1PR0llkYelHNXy30sqx
 Gh+TG9nlMtmqLjwhgzITUrtpduW80vQA6doeDqGaslMMV6XJF2NbrVSM6p63/M6YmcgKA+QuzY7
 1DtmtXinnP1nXW81uPSvm11j2ujA3xHSYWqK+lRkfqIEgDyTbFbR39d33aMK3A04QIvZIDNC+z6
 x8Akdfp+zCiOIhR02b9Q+9fpGKxqe50tQLMTw9nZe5kKKIRhRvmKruUXFyjObZfa3Z3Bde1XK2W
 Ec/HtP0mulepQq0iL4qHBJjJYc/FtMWxz+YY7lBCVzOg4W+wSFyo6crbS+nfQ8nM5r2e8YFvxal
 s0DyxuATdW8cN/WWXIJHT0THx3vjBjuvL3u+uiYSs4QOoCAQ4+q+Md2CTjqKmB3iz7+YiMg4CI6
 4tqYotC/rkqxCK11qtSv+ELL2Tw6WzEQuT+Wy6dJ3snZj/jE06t3Nb9foq4D+z0A42Se55ekzfE
 Eu+O3w+kCKvqgXM/GTG8Aj4K0EMpxNoHzCKziN64/Ve9ktY9A6LYg9RJY+ekrQAslkX2iukrVuy
 ETHL
X-Received: by 2002:a5d:664f:0:b0:47f:9158:5924 with SMTP id
 ffacd0b85a97d-48705a44dc3mr62141f8f.9.1789401632218; 
 Mon, 14 Sep 2026 09:00:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm30797695f8f.27.2026.09.14.09.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:00:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 7/9] target/arm: Only allow GICv5 on CPUs without AArch32
 at EL1..3
Date: Mon, 14 Sep 2026 17:00:18 +0100
Message-ID: <20260914160020.327787-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914160020.327787-1-peter.maydell@linaro.org>
References: <20260914160020.327787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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
index eecbc3b889e..c4029c0f73c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1129,6 +1129,14 @@ static inline bool isar_feature_aa64_aa32_el3(const ARMISARegisters *id)
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
index 2b1b87b0ed4..bbf4e0aa465 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1584,8 +1584,13 @@ static void arm_cpu_post_init(Object *obj)
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
@@ -2235,34 +2240,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
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


