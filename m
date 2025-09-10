Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25BBCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 14:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwLlB-000383-47; Wed, 10 Sep 2025 10:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uwLl8-00037l-QO
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 10:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uwLl6-00070H-Kt
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 10:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757514313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2K82FTjD2ngCIzEX9ElyP4drQK2Em+tFHR+l3Wud0Y=;
 b=bbR393ttOKYNrW//tyTqY+2h89lvheqKIpv/m/ow4ODEQFB5wbf7ik4Egm5N1i1zIeJDiX
 AxCfBnXtThq92Lv3AjL9XcjipcKe8tSU0IKCjY8yGufgM9QPcoTZaIItON7pxvKb42miUI
 1eo33gYxtdmNzDEs3BBGmWuBQEvcYwM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-49rqXEkuNWy54vDf599kNw-1; Wed,
 10 Sep 2025 10:25:11 -0400
X-MC-Unique: 49rqXEkuNWy54vDf599kNw-1
X-Mimecast-MFC-AGG-ID: 49rqXEkuNWy54vDf599kNw_1757514310
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB4FB19541B0
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 14:25:10 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 352B8300018D; Wed, 10 Sep 2025 14:25:08 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hpet: guard IRQ handling with BQL
Date: Wed, 10 Sep 2025 16:25:06 +0200
Message-ID: <20250910142506.86274-1-imammedo@redhat.com>
In-Reply-To: <aL7oe3sis3bKJhLW@redhat.com>
References: <aL7oe3sis3bKJhLW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit [1] made qemu fail with abort:
  xen_evtchn_set_gsi: Assertion `bql_locked()' failed.
when running ./tests/functional/x86_64/test_kvm_xen.py tests.

To fix it make sure that BQL is held when manipulating IRQs.

1)
Fixes: 7defb58baf (hpet: switch to fine-grained device locking)
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/timer/hpet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 789a31d0a0..1acba4fa9d 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -40,6 +40,7 @@
 #include "qom/object.h"
 #include "qemu/lockable.h"
 #include "qemu/seqlock.h"
+#include "qemu/main-loop.h"
 #include "trace.h"
 
 struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
@@ -222,12 +223,15 @@ static void update_irq(struct HPETTimer *timer, int set)
                                  timer->fsb & 0xffffffff, MEMTXATTRS_UNSPECIFIED,
                                  NULL);
         } else if (timer->config & HPET_TN_TYPE_LEVEL) {
+            BQL_LOCK_GUARD();
             qemu_irq_raise(s->irqs[route]);
         } else {
+            BQL_LOCK_GUARD();
             qemu_irq_pulse(s->irqs[route]);
         }
     } else {
         if (!timer_fsb_route(timer)) {
+            BQL_LOCK_GUARD();
             qemu_irq_lower(s->irqs[route]);
         }
     }
@@ -534,10 +538,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             /* i8254 and RTC output pins are disabled
              * when HPET is in legacy mode */
             if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
+                BQL_LOCK_GUARD();
                 qemu_set_irq(s->pit_enabled, 0);
                 qemu_irq_lower(s->irqs[0]);
                 qemu_irq_lower(s->irqs[RTC_ISA_IRQ]);
             } else if (deactivating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
+                BQL_LOCK_GUARD();
                 qemu_irq_lower(s->irqs[0]);
                 qemu_set_irq(s->pit_enabled, 1);
                 qemu_set_irq(s->irqs[RTC_ISA_IRQ], s->rtc_irq_level);
@@ -683,11 +689,13 @@ static void hpet_handle_legacy_irq(void *opaque, int n, int level)
 
     if (n == HPET_LEGACY_PIT_INT) {
         if (!hpet_in_legacy_mode(s)) {
+            BQL_LOCK_GUARD();
             qemu_set_irq(s->irqs[0], level);
         }
     } else {
         s->rtc_irq_level = level;
         if (!hpet_in_legacy_mode(s)) {
+            BQL_LOCK_GUARD();
             qemu_set_irq(s->irqs[RTC_ISA_IRQ], level);
         }
     }
-- 
2.47.3


