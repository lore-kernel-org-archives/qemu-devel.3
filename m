Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456B4F0180E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRXn-0004uW-F6; Fri, 06 Mar 2026 04:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vyRX9-0004s4-K0
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:31:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vyRX7-00022r-Ol
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772789503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Aaoy2eA1BSi13H8uLpxF/EJnOkB4xxeI3t9FtpCwLow=;
 b=Q2j3GSUnOmSRV2BxS5kcr62D4j2r4SfdPl1z/UTJazQS5VyEZMUisllK268v4IvZFaXY6u
 3x/5AmKQucZm749gpVEPp/JRjCBHojf6QyPH6uLVY76Xv5zGV9J6nK5WPLu/I0Mg+hlan+
 cyh1h/JeStI62pK8trn5BwcRBahqBds=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-BNCf_mr9NBewaW4ljV_RxA-1; Fri,
 06 Mar 2026 04:31:40 -0500
X-MC-Unique: BNCf_mr9NBewaW4ljV_RxA-1
X-Mimecast-MFC-AGG-ID: BNCf_mr9NBewaW4ljV_RxA_1772789499
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B57180060D; Fri,  6 Mar 2026 09:31:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D3281958DC7; Fri,  6 Mar 2026 09:31:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	qemu-rust@nongnu.org
Subject: [PATCH v2] hw/timer/hpet: Remove HPETState::hpet_offset_saved field
Date: Fri,  6 Mar 2026 10:31:34 +0100
Message-ID: <20260306093134.27789-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The HPETState::hpet_offset_saved boolean was only set in the
hw_compat_2_11[] array, via the 'hpet-offset-saved=false'
property. We removed all machines using that array, let's remove
that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501230129.2596-6-philmd@linaro.org>
[thuth: Adapted the rust part to the current master branch]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/timer/hpet.c                  | 9 +--------
 rust/hw/timer/hpet/src/device.rs | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 0d7b8e0c7a3..767093c431a 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -75,7 +75,6 @@ struct HPETState {
     QemuMutex lock;
     MemoryRegion iomem;
     uint64_t hpet_offset;
-    bool hpet_offset_saved;
     QemuSeqLock state_version;
     qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
     uint32_t flags;
@@ -272,11 +271,6 @@ static int hpet_post_load(void *opaque, int version_id)
         t->cmp64 = hpet_calculate_cmp64(t, s->hpet_counter, t->cmp);
         t->last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - NANOSECONDS_PER_SECOND;
     }
-    /* Recalculate the offset between the main counter and guest time */
-    if (!s->hpet_offset_saved) {
-        s->hpet_offset = ticks_to_ns(s->hpet_counter)
-                        - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
 
     return 0;
 }
@@ -285,7 +279,7 @@ static bool hpet_offset_needed(void *opaque)
 {
     HPETState *s = opaque;
 
-    return hpet_enabled(s) && s->hpet_offset_saved;
+    return hpet_enabled(s);
 }
 
 static bool hpet_rtc_irq_level_needed(void *opaque)
@@ -766,7 +760,6 @@ static const Property hpet_device_properties[] = {
     DEFINE_PROP_UINT8("timers", HPETState, num_timers, HPET_MIN_TIMERS),
     DEFINE_PROP_BIT("msi", HPETState, flags, HPET_MSI_SUPPORT, false),
     DEFINE_PROP_UINT32(HPET_INTCAP, HPETState, intcap, 0),
-    DEFINE_PROP_BOOL("hpet-offset-saved", HPETState, hpet_offset_saved, true),
 };
 
 static void hpet_device_class_init(ObjectClass *klass, const void *data)
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index ebf715d3995..0a5c131819b 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -627,8 +627,6 @@ pub struct HPETState {
     flags: u32,
 
     hpet_offset_migration: BqlCell<u64>,
-    #[property(rename = "hpet-offset-saved", default = true)]
-    hpet_offset_saved: bool,
 
     irqs: [InterruptSource; HPET_NUM_IRQ_ROUTES],
     rtc_irq_level: BqlCell<u32>,
@@ -947,11 +945,6 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
             tn_regs.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
-        // Recalculate the offset between the main counter and guest time
-        if !self.hpet_offset_saved {
-            self.hpet_offset_migration
-                .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
-        }
         regs.hpet_offset = self.hpet_offset_migration.get();
 
         Ok(())
@@ -962,7 +955,7 @@ fn is_rtc_irq_level_needed(&self) -> bool {
     }
 
     fn is_offset_needed(&self) -> bool {
-        self.regs.borrow().is_hpet_enabled() && self.hpet_offset_saved
+        self.regs.borrow().is_hpet_enabled()
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-- 
2.53.0


