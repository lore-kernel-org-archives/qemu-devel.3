Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8DCCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJN5-0008CB-Qy; Mon, 12 Oct 2026 12:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMN-0007ym-4D; Mon, 12 Oct 2026 12:58:49 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMK-0006BP-W2; Mon, 12 Oct 2026 12:58:46 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw135JdzBqdB;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824321;
 bh=8YhXGObb9R7y4NQD16UzBKhs9n3aO4Y8czE9nfrcr5Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VChLSd4MyD6XgFpzIigfXVefaM8Vm1gzazXlMMiwY2Hi6CXtEq0M1eAFIPJ7y11Z6
 JSq6piOUiU0tul8hIPbVPp7a1KGHtbrg4TOYEJw0kQqjlxlxYHmE5nC/SdtVytyZWr
 X1VKldqcDF434hLqX3edWDvzX3Qm3UQWokd66yAjlCZ0PHrXhY33ap51UT/e3Z/aTZ
 N/xt22c8DNTChYRqG2C8Oi9hpqBT1BayeE6xmcI15Ztbn+sd0psO2T0eHJm4Ia+W66
 mDMY2kAAF7mmCBU1zj54slkKNJuUzRpEucLgyDuRGIaRukPOakRslawJal+cobWwc+
 OgK7KNMrs3q2Q==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw11wCTz83nb;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH 1/9] target/arm: add Cortex-M0+ CPU type
Date: Mon, 12 Oct 2026 18:58:31 +0200
Message-ID: <20261012165840.99050-2-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
References: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The Armv6-M Unprivileged/Privileged Extension is optional. While the
Cortex-M0 does not implement it, the Cortex-M0+ may - and the RP2040
Cortex-M0+ configuration in particular provides this extension.

Add the cortex-m0plus CPU type, with explicit initialization of all
architectural state. Enable ARM_FEATURE_M_UNPRIV (introduced by commit
285e929908) and set the MIDR used by the RP2040. All ID registers are
initialized explicitly, and their values inherited from Cortex-M0 have
been verified to be appropriate for Cortex-M0+.

Note: The MPU is optional on Cortex-M0+, so we do not configure the
default 8 regions in the CPU type. The RP2040 machine correctly sets
mpu-ns-regions = 8.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 target/arm/tcg/cpu-v7m.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 48b31d5eac..975c712b61 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -76,6 +76,37 @@ static void cortex_m0_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR6, 0x00000000);
 }
 
+static void cortex_m0plus_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+
+    /* Architectural state: M-profile, v6-M, with unprivileged extension */
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_UNPRIV);
+
+    /* MIDR for Cortex-M0+, RP2040 variant */
+    cpu->midr = 0x410cc601;
+
+    /* ID registers: same as Cortex-M0, verified to be appropriate */
+    SET_IDREG(isar, ID_PFR0, 0x00000030);
+    SET_IDREG(isar, ID_PFR1, 0x00000200);
+    SET_IDREG(isar, ID_DFR0, 0x00100000);
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
+    SET_IDREG(isar, ID_MMFR0, 0x00000030);
+    SET_IDREG(isar, ID_MMFR1, 0x00000000);
+    SET_IDREG(isar, ID_MMFR2, 0x00000000);
+    SET_IDREG(isar, ID_MMFR3, 0x00000000);
+    SET_IDREG(isar, ID_ISAR0, 0x01141110);
+    SET_IDREG(isar, ID_ISAR1, 0x02111000);
+    SET_IDREG(isar, ID_ISAR2, 0x21112231);
+    SET_IDREG(isar, ID_ISAR3, 0x01111110);
+    SET_IDREG(isar, ID_ISAR4, 0x01310102);
+    SET_IDREG(isar, ID_ISAR5, 0x00000000);
+    SET_IDREG(isar, ID_ISAR6, 0x00000000);
+}
+
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -325,6 +356,8 @@ static void arm_v7m_class_init(ObjectClass *oc, const void *data)
 static const ARMCPUInfo arm_v7m_cpus[] = {
     { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m0plus", .initfn = cortex_m0plus_initfn,
+                             .class_init = arm_v7m_class_init },
     { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
-- 
2.55.0


