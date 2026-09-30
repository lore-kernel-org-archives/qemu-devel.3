Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED8CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqtA-0006AD-LU; Wed, 30 Sep 2026 05:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xBqt9-00069l-6g; Wed, 30 Sep 2026 05:46:11 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xBqt7-0000R5-AQ; Wed, 30 Sep 2026 05:46:10 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hvqtN46gPzBqZ9;
 Wed, 30 Sep 2026 11:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1790761564;
 bh=J0JC4Z4YoBOLybTqcPKjx2Vwsqnqk9HFBSo0Nm+WJTY=;
 h=From:To:Cc:Subject:Date:From;
 b=zH96aNk+cECczR9YcjmWJ7GmBUYyDSLNwSl4UsMYUxCNR7NEoj5hJaTWO0VGt9+YZ
 HmE279Phgcu82sTBqkf2SsVj8XrzpeRuVzb79PdW0T33V4wPmuMTno/Ul4Iz19qvVE
 xOnmgUZKRWkcs8/V2zD/xLscF5Qh5sz1bow86P0AKLnedArqfAyjedsB9yr3jUGaci
 OLw7LOx336uk5ghU9JfCbL60oWcUThVjtV4FoFz1qZ5HR5PfSlVhP9dWcP0TRmjK/R
 inJorkCGZf0Ywtog7SOk447xs9lKPkpbkSzo8ep1KY8p4LS0Yu2NA2IUTaZK2BGq5C
 wEhVh7jP22Ksg==
Received: from localhost.localdomain (unknown [134.206.233.118])
 (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4hvqtN33pbz6snq;
 Wed, 30 Sep 2026 11:46:04 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH] target/arm: add Cortex-M0+ CPU type
Date: Wed, 30 Sep 2026 11:46:03 +0200
Message-ID: <20260930094603.35969-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
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

Add the cortex-m0plus CPU type, reusing the existing Cortex-M0
initialization logic. Enable ARM_FEATURE_M_UNPRIV, introduced by commit
285e929908 ("target/arm: model Cortex-M0+ privilege extension"), and set
the Cortex-M0+ MIDR used by the RP2040.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
The Cortex-M0+ CPU type was previously included in:

  [RFC PATCH v1 2/6] target/arm: model Cortex-M0+ privilege extension
  https://lore.kernel.org/qemu-devel/20260914192323.29250-3-gilles.grimaud@univ-lille.fr/

It is now submitted separately following review feedback.

 target/arm/tcg/cpu-v7m.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 48b31d5eac..ac99c93ec3 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -76,6 +76,15 @@ static void cortex_m0_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR6, 0x00000000);
 }
 
+static void cortex_m0plus_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cortex_m0_initfn(obj);
+    set_feature(&cpu->env, ARM_FEATURE_M_UNPRIV);
+    cpu->midr = 0x410cc601;
+}
+
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -325,6 +334,8 @@ static void arm_v7m_class_init(ObjectClass *oc, const void *data)
 static const ARMCPUInfo arm_v7m_cpus[] = {
     { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m0plus", .initfn = cortex_m0plus_initfn,
+                                .class_init = arm_v7m_class_init },
     { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
-- 
2.55.0

