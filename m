Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04862C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhGc-0003VZ-Qt; Fri, 04 Jul 2025 10:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGS-0003SL-SG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGQ-0003Jq-C0
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751638781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKHucgUogq4SzJyztCtSCHdMmqzzIbVhnQGRziR2c4Q=;
 b=RRr6ZR3DmjXJcrjp1eiG3RHsBFI6+FgvW4+wSsDpqD1gPuBQZFy5UTTRN+51pA8ObbLSGp
 nET5ZyzEbyCINVSwwqLvhNrQY/T+EaR84J3Loa8G6ofwivBciRFfZsPOq7ja7s9ChBzyUC
 rE8Noc1bdIERGNv6K6VXSfnix69J45o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-8akD3FtZNZKRn5q1-DaN1g-1; Fri,
 04 Jul 2025 10:19:37 -0400
X-MC-Unique: 8akD3FtZNZKRn5q1-DaN1g-1
X-Mimecast-MFC-AGG-ID: 8akD3FtZNZKRn5q1-DaN1g_1751638777
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AB3618DA5CA; Fri,  4 Jul 2025 14:19:36 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.34.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60C1C195608F; Fri,  4 Jul 2025 14:19:34 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/5] arm/cpu: store id_afr0 into the idregs array
Date: Fri,  4 Jul 2025 16:19:23 +0200
Message-ID: <20250704141927.38963-2-cohuck@redhat.com>
In-Reply-To: <20250704141927.38963-1-cohuck@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-sysregs.h.inc |  1 +
 target/arm/cpu.h             |  1 -
 target/arm/cpu64.c           |  4 ++--
 target/arm/helper.c          |  2 +-
 target/arm/tcg/cpu-v7m.c     | 12 ++++++------
 target/arm/tcg/cpu32.c       | 22 +++++++++++-----------
 target/arm/tcg/cpu64.c       | 16 ++++++++--------
 8 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 6d85720f1b46..d93e593fcba8 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1279,7 +1279,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
         }
-        return cpu->id_afr0;
+        return GET_IDREG(isar, ID_AFR0);
     case 0xd50: /* MMFR0.  */
         if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
             goto bad_offset;
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index cb99286f7048..b96a35880430 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
+DEF(ID_AFR0_EL1, 3, 0, 0, 1, 3)
 DEF(ID_MMFR0_EL1, 3, 0, 0, 1, 4)
 DEF(ID_MMFR1_EL1, 3, 0, 0, 1, 5)
 DEF(ID_MMFR2_EL1, 3, 0, 0, 1, 6)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 033815392385..ca8ad1cc27a8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1066,7 +1066,6 @@ struct ArchCPU {
     uint32_t reset_sctlr;
     uint64_t pmceid0;
     uint64_t pmceid1;
-    uint32_t id_afr0;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
     uint64_t clidr;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1f3406708bd7..28b8f7db949d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -655,7 +655,7 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10101105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
@@ -717,7 +717,7 @@ static void aarch64_a53_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10101105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c311d2df2170..2f57ab4d87da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7805,7 +7805,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_afr0 },
+              .resetvalue = GET_IDREG(isar, ID_AFR0)},
             { .name = "ID_MMFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index eddd7117d5bb..a65b83fe9905 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -62,7 +62,7 @@ static void cortex_m0_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00000030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x00000000);
@@ -88,7 +88,7 @@ static void cortex_m3_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00000030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x00000000);
@@ -119,7 +119,7 @@ static void cortex_m4_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00000030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x00000000);
@@ -150,7 +150,7 @@ static void cortex_m7_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000200);
     SET_IDREG(isar, ID_DFR0, 0x00100000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00100030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x01000000);
@@ -183,7 +183,7 @@ static void cortex_m33_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000030);
     SET_IDREG(isar, ID_PFR1, 0x00000210);
     SET_IDREG(isar, ID_DFR0, 0x00200000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00101F40);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x01000000);
@@ -221,7 +221,7 @@ static void cortex_m55_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x20000030);
     SET_IDREG(isar, ID_PFR1, 0x00000230);
     SET_IDREG(isar, ID_DFR0, 0x10200000);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00111040);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x01000000);
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 942b636aa5bd..03cbe42f22f8 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -225,7 +225,7 @@ static void arm1136_r2_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0x2);
-    cpu->id_afr0 = 0x3;
+    SET_IDREG(isar, ID_AFR0, 0x3);
     SET_IDREG(isar, ID_MMFR0, 0x01130003);
     SET_IDREG(isar, ID_MMFR1, 0x10030302);
     SET_IDREG(isar, ID_MMFR2, 0x01222110);
@@ -257,7 +257,7 @@ static void arm1136_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0x2);
-    cpu->id_afr0 = 0x3;
+    SET_IDREG(isar, ID_AFR0, 0x3);
     SET_IDREG(isar, ID_MMFR0, 0x01130003);
     SET_IDREG(isar, ID_MMFR1, 0x10030302);
     SET_IDREG(isar, ID_MMFR2, 0x01222110);
@@ -290,7 +290,7 @@ static void arm1176_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x33);
-    cpu->id_afr0 = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x01130003);
     SET_IDREG(isar, ID_MMFR1, 0x10030302);
     SET_IDREG(isar, ID_MMFR2, 0x01222100);
@@ -320,7 +320,7 @@ static void arm11mpcore_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0);
-    cpu->id_afr0 = 0x2;
+    SET_IDREG(isar, ID_AFR0, 0x2);
     SET_IDREG(isar, ID_MMFR0, 0x01100103);
     SET_IDREG(isar, ID_MMFR1, 0x10020302);
     SET_IDREG(isar, ID_MMFR2, 0x01222000);
@@ -360,7 +360,7 @@ static void cortex_a8_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x1031);
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x400);
-    cpu->id_afr0 = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x31100003);
     SET_IDREG(isar, ID_MMFR1, 0x20000000);
     SET_IDREG(isar, ID_MMFR2, 0x01202000);
@@ -436,7 +436,7 @@ static void cortex_a9_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x1031);
     SET_IDREG(isar, ID_PFR1, 0x11);
     SET_IDREG(isar, ID_DFR0, 0x000);
-    cpu->id_afr0 = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x00100103);
     SET_IDREG(isar, ID_MMFR1, 0x20000000);
     SET_IDREG(isar, ID_MMFR2, 0x01230000);
@@ -502,7 +502,7 @@ static void cortex_a7_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00001131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x02010555);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10101105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01240000);
@@ -554,7 +554,7 @@ static void cortex_a15_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00001131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x02010555);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x20000000);
     SET_IDREG(isar, ID_MMFR2, 0x01240000);
@@ -598,7 +598,7 @@ static void cortex_r5_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x0131);
     SET_IDREG(isar, ID_PFR1, 0x001);
     SET_IDREG(isar, ID_DFR0, 0x010400);
-    cpu->id_afr0 = 0x0;
+    SET_IDREG(isar, ID_AFR0, 0x0);
     SET_IDREG(isar, ID_MMFR0, 0x0210030);
     SET_IDREG(isar, ID_MMFR1, 0x00000000);
     SET_IDREG(isar, ID_MMFR2, 0x01200000);
@@ -745,7 +745,7 @@ static void cortex_r52_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x10111001);
     SET_IDREG(isar, ID_DFR0, 0x03010006);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x00211040);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01200000);
@@ -977,7 +977,7 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10101105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 937f29e253d7..3f4fb003f440 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -52,7 +52,7 @@ static void aarch64_a35_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
@@ -227,7 +227,7 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000010112222ull);
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
-    cpu->id_afr0       = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
@@ -298,7 +298,7 @@ static void aarch64_a72_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_DFR0, 0x03010066);
-    cpu->id_afr0 = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
@@ -360,7 +360,7 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
-    cpu->id_afr0       = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
@@ -608,7 +608,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, 0x0000000000001011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
-    cpu->id_afr0       = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_DFR0, 0x04010088);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
@@ -687,7 +687,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull),
     SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
-    cpu->id_afr0       = 0x00000000;
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
     SET_IDREG(isar, ID_DFR0, 0x15011099);
     SET_IDREG(isar, ID_ISAR0, 0x02101110);
     SET_IDREG(isar, ID_ISAR1, 0x13112111);
@@ -905,7 +905,7 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
-    cpu->id_afr0       = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
@@ -1007,7 +1007,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
-    cpu->id_afr0       = 0;
+    SET_IDREG(isar, ID_AFR0, 0);
     SET_IDREG(isar, ID_MMFR0, 0x10201105);
     SET_IDREG(isar, ID_MMFR1, 0x40000000);
     SET_IDREG(isar, ID_MMFR2, 0x01260000);
-- 
2.50.0


