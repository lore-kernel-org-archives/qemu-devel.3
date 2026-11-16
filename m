Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8661606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ZAgoDjEL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3OL-0004aq-Ja; Mon, 16 Nov 2026 15:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3LQ-0000EF-Jr; Mon, 16 Nov 2026 15:30:35 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3LF-0001kl-4p; Mon, 16 Nov 2026 15:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=g7an4iUQbuxIfVZnlzrMeJkeAcJbO1cwfTsFfvvFn0k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZAgoDjELXKcvkqHkfJV2vLFUHzX6NisermK2YsAHRonVmpdcHZFr5Pckn4N5F30Yb
 c5+fT0nfaFHn35A6ZU03I9/3mIqS4OOE+HUf+0SbvvoifC7X0YT3/ztswmx+2Ut+BB
 580wbNlEAjtakITVe4PGrKm1ZElaCj9/VYKIr5/fvoz1UzET1pN2zfEzMck6nOBXz6
 6EByh5KM86WQSLzhVSGCUoXZR9RoEXqgErEP+L4+PSwRpkzoWrZOvhswOT10BCb3js
 MP4p0avNluTG+tNZlxLkH33S810pDtVMRVLxLE1XnslAeoE7RpYZDIeB29k2ls+14G
 h6GABHHJmKyIQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 87E7C1E71C1;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 855D345FBED;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 47EDDB8E9E; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 44/63] hw/intc/arm_gic: move num-priority-bits check
Date: Mon, 16 Nov 2026 23:25:23 +0300
Message-ID: <20261116202554.535325-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
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
index 4d4b79e6f34..b60f1f630b0 100644
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
index 304d89cf562..a7c0763ab6a 100644
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


