Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B092C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLp3-0007t6-QL; Fri, 08 Aug 2025 08:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnL-000385-MM
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnJ-00077E-PW
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754654517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpmwOQHX1SgGpJskyx5fWBOPbTgrLh6qjQ11c8Kgzo8=;
 b=BXsr4bEpTMz0ZA2ORifgi2PcTXhb0pU7+FfNPqLX5HvahHDzPXiMiCiscW8gzb4jxzJgKk
 0MgoDQJrMwJHLHPrmOYSL/NGPcP92uEIVhDm5Tnw519ff37ckmpgP2dyZ7rWmkDkbydpiA
 CkxayZmhqr1XyzUubuMUtW2jbVFG+wc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-GU4XYO6sML2Dxc5UUfB9Pg-1; Fri,
 08 Aug 2025 08:01:55 -0400
X-MC-Unique: GU4XYO6sML2Dxc5UUfB9Pg-1
X-Mimecast-MFC-AGG-ID: GU4XYO6sML2Dxc5UUfB9Pg_1754654513
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 663BC180036E; Fri,  8 Aug 2025 12:01:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6770719560AD; Fri,  8 Aug 2025 12:01:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
Subject: [PATCH v3 04/10] hpet: move out main counter read into a separate
 block
Date: Fri,  8 Aug 2025 14:01:31 +0200
Message-ID: <20250808120137.2208800-5-imammedo@redhat.com>
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


