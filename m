Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D47C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACWR-0003yo-KJ; Wed, 30 Apr 2025 14:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWP-0003tv-J5
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWN-0008LJ-V1
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGMmWQoDu0O44Khh2IplYBQXTQMrVHQxvhNgACgHD6s=;
 b=YoQcF3r1PME9Kqdmu0gejmIiwE3NW1WuWZARk16IvY9iKDVEHOEe8yf+Faj0FSGb2ZBlzJ
 HdQ9OkqLyvHii5zydDe3BHQLcIeyooKBWUmKvVfsOfLYfXiHIZAH4UpLMhEckAU2Pnt4tR
 oepbc0bxkt7VQsuj7EXfinj2WLHQhq8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-79j4yoelPomgWdzlEF3-LA-1; Wed,
 30 Apr 2025 14:50:59 -0400
X-MC-Unique: 79j4yoelPomgWdzlEF3-LA-1
X-Mimecast-MFC-AGG-ID: 79j4yoelPomgWdzlEF3-LA_1746039058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B9E21956086; Wed, 30 Apr 2025 18:50:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C91AA19560A3; Wed, 30 Apr 2025 18:50:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 8/9] hw/rtc/mc146818rtc: Drop pre-v3 migration stream support
Date: Wed, 30 Apr 2025 20:50:34 +0200
Message-ID: <20250430185035.724919-9-thuth@redhat.com>
In-Reply-To: <20250430185035.724919-1-thuth@redhat.com>
References: <20250430185035.724919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

mc146818rtc's migration stream is at version 3 since commit
56038ef6234 ("RTC: Update the RTC clock only when reading it")
from 12 years ago, released in QEMU v1.3.0!
No versioned machines are that old, we can safely remove
support for older streams and the qdev_set_legacy_instance_id()
call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250115210048.25396-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/rtc/mc146818rtc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 6f787be7af8..f9f5cf396f0 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -819,7 +819,7 @@ static const VMStateDescription vmstate_rtc_irq_reinject_on_ack_count = {
 static const VMStateDescription vmstate_rtc = {
     .name = "mc146818rtc",
     .version_id = 3,
-    .minimum_version_id = 1,
+    .minimum_version_id = 3,
     .pre_save = rtc_pre_save,
     .post_load = rtc_post_load,
     .fields = (const VMStateField[]) {
@@ -829,13 +829,13 @@ static const VMStateDescription vmstate_rtc = {
         VMSTATE_TIMER_PTR(periodic_timer, MC146818RtcState),
         VMSTATE_INT64(next_periodic_time, MC146818RtcState),
         VMSTATE_UNUSED(3*8),
-        VMSTATE_UINT32_V(irq_coalesced, MC146818RtcState, 2),
-        VMSTATE_UINT32_V(period, MC146818RtcState, 2),
-        VMSTATE_UINT64_V(base_rtc, MC146818RtcState, 3),
-        VMSTATE_UINT64_V(last_update, MC146818RtcState, 3),
-        VMSTATE_INT64_V(offset, MC146818RtcState, 3),
-        VMSTATE_TIMER_PTR_V(update_timer, MC146818RtcState, 3),
-        VMSTATE_UINT64_V(next_alarm_time, MC146818RtcState, 3),
+        VMSTATE_UINT32(irq_coalesced, MC146818RtcState),
+        VMSTATE_UINT32(period, MC146818RtcState),
+        VMSTATE_UINT64(base_rtc, MC146818RtcState),
+        VMSTATE_UINT64(last_update, MC146818RtcState),
+        VMSTATE_INT64(offset, MC146818RtcState),
+        VMSTATE_TIMER_PTR(update_timer, MC146818RtcState),
+        VMSTATE_UINT64(next_alarm_time, MC146818RtcState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -929,8 +929,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
     memory_region_add_coalescing(&s->coalesced_io, 0, 1);
 
-    qdev_set_legacy_instance_id(dev, s->io_base, 3);
-
     object_property_add_tm(OBJECT(s), "date", rtc_get_date);
 
     qdev_init_gpio_out(dev, &s->irq, 1);
-- 
2.49.0


