Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A2606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ruozKQWg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3EC-0005VO-8D; Mon, 16 Nov 2026 15:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3E2-0005ME-Lf; Mon, 16 Nov 2026 15:22:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3E0-0003dI-Ip; Mon, 16 Nov 2026 15:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860372; bh=KyKefkyH5yGBiRXasIF51mex+5Lp7nqmdf51dGEBqTc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ruozKQWg146//CJJyu36wfbUvKaNDvO1mnFoX+5krDiFV2zXHoyJykIK5lVqaHKe4
 Xs25M2fXddR8gRiMj06Uy8n2uJ7sDfFd27MzLzw9WdtHgq/QPndx2APP8R5x3QdQbO
 RTT1cyJetExtMp3nSxsYFI5nFhNvcE8y5mLm5VetGNKae2XSephqma1paLk3cM4lAW
 UwJgQ9lyX9HCizFC+XbNh3TdU6MfFoSjwdToGw84QBdSM0KhifSbEHLhsiwnmtbj5G
 qht0DuEMd1W05NjJVcXakYphhvciIgMOavQssaTmBr57LJ7rE3tMf6fiYLa/mRf1pS
 eagKVasCxpU+Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B72A51E715C;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B47CF45FB95;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6983AB8E1A; Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 38/59] hw/intc/arm_gic: move num-priority-bits check
Date: Mon, 16 Nov 2026 23:18:42 +0300
Message-ID: <20261116201922.534306-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

We check the num-priority-bits property for sane values in
arm_gic_realize(), but the property is defined on the "common"
superclass, so it is present also for TYPE_KVM_ARM_GIC.  Currently
this misplaced check is harmless, beacuse the KVM subclass never
looks at the property value.  However, we are about to make a change
that will want to use the property value in code called from the
common class's reset method.

Move num-priority-bits property value check to the common class
realize method, where it belongs.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20261106-gic_read_bpr_from_property-v2-2-9f096cce4814@linaro.org
[PMM: rewrote commit message, moved patch before the change that
 it is a prerequisite for]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2527d738072b9d9d8a2c8262127003c6aa9f9983)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 3581ff8e8a2..ca1079147ec 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -2117,16 +2117,6 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (s->n_prio_bits > GIC_MAX_PRIORITY_BITS ||
-       (s->virt_extn ? s->n_prio_bits < GIC_VIRT_MAX_GROUP_PRIO_BITS :
-        s->n_prio_bits < GIC_MIN_PRIORITY_BITS)) {
-        error_setg(errp, "num-priority-bits cannot be greater than %d"
-                   " or less than %d", GIC_MAX_PRIORITY_BITS,
-                   s->virt_extn ? GIC_VIRT_MAX_GROUP_PRIO_BITS :
-                   GIC_MIN_PRIORITY_BITS);
-        return;
-    }
-
     /* This creates distributor, main CPU interface (s->cpuiomem[0]) and if
      * enabled, virtualization extensions related interfaces (main virtual
      * interface (s->vifaceiomem[0]) and virtual CPU interface).
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 5ac56e33898..ee3c39c1309 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -233,6 +233,16 @@ static void arm_gic_common_realize(DeviceState *dev, Error **errp)
          */
         s->num_lrs = 4;
     }
+
+    if (s->n_prio_bits > GIC_MAX_PRIORITY_BITS ||
+       (s->virt_extn ? s->n_prio_bits < GIC_VIRT_MAX_GROUP_PRIO_BITS :
+        s->n_prio_bits < GIC_MIN_PRIORITY_BITS)) {
+        error_setg(errp, "num-priority-bits cannot be greater than %d"
+                   " or less than %d", GIC_MAX_PRIORITY_BITS,
+                   s->virt_extn ? GIC_VIRT_MAX_GROUP_PRIO_BITS :
+                   GIC_MIN_PRIORITY_BITS);
+        return;
+    }
 }
 
 static inline void arm_gic_common_reset_irq_state(GICState *s, int cidx,
-- 
2.47.3


