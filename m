Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E03BCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 16:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umaTA-0001jm-Nw; Thu, 14 Aug 2025 12:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1umaT5-0001i4-Rp
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 12:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1umaT3-0005jo-N8
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 12:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755187576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olgPsnsXU1lnRrECkVwm901Y7CwtTfKj4zJsWxS8vjo=;
 b=JCzc4Yd3gvFBNMdZcbjE3P1/ewLuI+fxzvMBPQwAyon+vgs9Y2FovIc2dT3PD9qwxPqbPH
 ALyWOArqSEAmcnHNSK5arDXYzuW6K6QmrMcZkE8dzunvuMxc86puEJSSx35Ye9ulNZj/wa
 Sqoy/IrqDJXF+b1Au2h0ysH+ztKdmaI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-iiLvmrmHMA-Zo7ms57dkJQ-1; Thu,
 14 Aug 2025 12:06:15 -0400
X-MC-Unique: iiLvmrmHMA-Zo7ms57dkJQ-1
X-Mimecast-MFC-AGG-ID: iiLvmrmHMA-Zo7ms57dkJQ_1755187574
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 291BE1954194
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 16:06:14 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A2FF18003FC; Thu, 14 Aug 2025 16:06:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, mtosatti@redhat.com
Subject: [PATCH v4 4/8] hpet: move out main counter read into a separate block
Date: Thu, 14 Aug 2025 18:05:56 +0200
Message-ID: <20250814160600.2327672-5-imammedo@redhat.com>
In-Reply-To: <20250814160600.2327672-1-imammedo@redhat.com>
References: <20250814160600.2327672-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Follow up patche will switch main counter read to
lock-less mode. As preparation for that move relevant
branch into a separate top level block to make followup
patch cleaner/simplier by reducing contextual noise
when lock-less read is introduced.

no functional changes.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
v3:
  * drop 'addr <= 0xff' as addr == HPET_COUNTER is sufficient
     Peter Xu <peterx@redhat.com>
---
 hw/timer/hpet.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index ab5aa59ae4..c776afc0f2 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -431,6 +431,16 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     addr &= ~4;
 
     QEMU_LOCK_GUARD(&s->lock);
+    if (addr == HPET_COUNTER) {
+        if (hpet_enabled(s)) {
+            cur_tick = hpet_get_ticks(s);
+        } else {
+            cur_tick = s->hpet_counter;
+        }
+        trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
+        return cur_tick >> shift;
+    }
+
     /*address range of all global regs*/
     if (addr <= 0xff) {
         switch (addr) {
@@ -438,14 +448,6 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             return s->capability >> shift;
         case HPET_CFG:
             return s->config >> shift;
-        case HPET_COUNTER:
-            if (hpet_enabled(s)) {
-                cur_tick = hpet_get_ticks(s);
-            } else {
-                cur_tick = s->hpet_counter;
-            }
-            trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
-            return cur_tick >> shift;
         case HPET_STATUS:
             return s->isr >> shift;
         default:
-- 
2.47.1


