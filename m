Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7399EC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 14:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh7gc-00081c-Rw; Wed, 30 Jul 2025 10:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh66D-0005ho-Ed
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh669-0006vs-Ar
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753879196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zd1FxBLQ4yxr7ES3QONl2dWq+/99FTSEpJQKAVkOJI=;
 b=e9ubpT/Blui4Bd49W2VuWPXNw9X79x5S+Ox+FWwlLAJyVyYbUh06Jhkr32T2p4/B9gijqM
 dw7YcQfpnpfBydimgzowVYGgkSXEDLdOiGEVHQr5Cegak+KsX7GSH94sboIcW7OaHxfrAt
 sEffTsT1YQ2z62/g1TmYsBPVpzf7rk0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-5mN1s-vyNlCk89WZ9v0Hmg-1; Wed,
 30 Jul 2025 08:39:53 -0400
X-MC-Unique: 5mN1s-vyNlCk89WZ9v0Hmg-1
X-Mimecast-MFC-AGG-ID: 5mN1s-vyNlCk89WZ9v0Hmg_1753879192
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C8D119560B5; Wed, 30 Jul 2025 12:39:52 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75A2B30001B1; Wed, 30 Jul 2025 12:39:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2 5/6] hpet: make main counter read lock-less
Date: Wed, 30 Jul 2025 14:39:33 +0200
Message-ID: <20250730123934.1787379-6-imammedo@redhat.com>
In-Reply-To: <20250730123934.1787379-1-imammedo@redhat.com>
References: <20250730123934.1787379-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Make access to main HPET counter lock-less when enable/disable
state isn't changing (which is the most of the time).

A read will fallback to locked access if the state change happens
in the middle of read or read happens in the middle of the state
change.

This basically uses the same approach as cpu_get_clock(),
modulo instead of busy wait it piggibacks to taking device lock
to wait until HPET reaches consistent state.

As result micro benchmark of concurrent reading of HPET counter
with large number of vCPU shows over 80% better (less) latency.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/timer/hpet.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 97687697c9..d822ca1cd0 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -74,6 +74,7 @@ struct HPETState {
     MemoryRegion iomem;
     uint64_t hpet_offset;
     bool hpet_offset_saved;
+    unsigned state_version;
     qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
     uint32_t flags;
     uint8_t rtc_irq_level;
@@ -430,17 +431,44 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     trace_hpet_ram_read(addr);
     addr &= ~4;
 
-    QEMU_LOCK_GUARD(&s->lock);
     if ((addr <= 0xff) && (addr == HPET_COUNTER)) {
-        if (hpet_enabled(s)) {
-            cur_tick = hpet_get_ticks(s);
-        } else {
+        unsigned version;
+        bool release_lock = false;
+redo:
+        version = qatomic_load_acquire(&s->state_version);
+        if (unlikely(version & 1)) {
+                /*
+                 * Updater is running, state can be inconsistent
+                 * wait till it's done before reading counter
+                 */
+                release_lock = true;
+                qemu_mutex_lock(&s->lock);
+        }
+
+        if (unlikely(!hpet_enabled(s))) {
             cur_tick = s->hpet_counter;
+        } else {
+            cur_tick = hpet_get_ticks(s);
+        }
+
+        /*
+         * ensure counter math happens before we check version again
+         */
+        smp_rmb();
+        if (unlikely(version != qatomic_load_acquire(&s->state_version))) {
+            /*
+             * counter state has changed, re-read counter again
+             */
+            goto redo;
+        }
+        if (unlikely(release_lock)) {
+            qemu_mutex_unlock(&s->lock);
         }
         trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
         return cur_tick >> shift;
     }
 
+    QEMU_LOCK_GUARD(&s->lock);
     /*address range of all global regs*/
     if (addr <= 0xff) {
         switch (addr) {
@@ -500,6 +528,11 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             old_val = s->config;
             new_val = deposit64(old_val, shift, len, value);
             new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
+            /*
+             * Odd versions mark the critical section, any readers will be
+             * forced into lock protected read if they come in the middle of it
+             */
+            qatomic_inc(&s->state_version);
             s->config = new_val;
             if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
                 /* Enable main counter and interrupt generation. */
@@ -518,6 +551,13 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                     hpet_del_timer(&s->timer[i]);
                 }
             }
+            /*
+             * even versions mark the end of critical section,
+             * any readers started before config change, but were still executed
+             * during the change, will be forced to re-read counter state
+             */
+            qatomic_inc(&s->state_version);
+
             /* i8254 and RTC output pins are disabled
              * when HPET is in legacy mode */
             if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
-- 
2.47.1


