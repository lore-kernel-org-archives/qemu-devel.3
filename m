Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDF0E784A6
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 07:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYfiU-0000O2-Ne; Thu, 25 Dec 2025 02:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vYfiS-0000NW-5M
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 02:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vYfiP-0003yf-L3
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 02:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766647491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=04CJMsU0nP3//zUkaQiJBzIGC5bslhH0TS+YRGRP3Y8=;
 b=LKweMDUI8++WdK8sWaGK8jFLCCxE3xP3ZeSx8ffpyCERn3ZpR0DDiChOR7/YOZR3uYJHOe
 TwOcacwii6DPCIc/q9n/XtC8PfCT37VlxP8Hm5wDOIAYiIvhl73GWSdwGacEeOIM4U+gWx
 0/YgrE0YTM/0RJP8NKhuFQ1gdXwre40=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-M6hqfweCMtifQbvpWn31eA-1; Thu,
 25 Dec 2025 02:24:49 -0500
X-MC-Unique: M6hqfweCMtifQbvpWn31eA-1
X-Mimecast-MFC-AGG-ID: M6hqfweCMtifQbvpWn31eA_1766647488
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F7E61956050; Thu, 25 Dec 2025 07:24:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.107])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 846EF180049F; Thu, 25 Dec 2025 07:24:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	zhangckid@gmail.com,
	lizhijian@fujitsu.com
Cc: qemu-devel@nongnu.org,
	lulu@redhat.com
Subject: [PATCH 1/2] net/filter-buffer: make interval change take effect
 immediately
Date: Thu, 25 Dec 2025 15:24:41 +0800
Message-ID: <20251225072442.36012-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Previously, when the 'interval' property was modified at runtime via
QMP, the new value would only take effect after the current timer
period elapsed. This could lead to unexpected behavior when users
expect immediate changes.

Fix this by checking if the timer is already running when setting
the interval property. If so, reschedule the timer with the new
interval value immediately.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/filter-buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index a36be31dc8..427da24097 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -159,6 +159,7 @@ static void filter_buffer_set_interval(Object *obj, Visitor *v,
                                        Error **errp)
 {
     FilterBufferState *s = FILTER_BUFFER(obj);
+    NetFilterState *nf = NETFILTER(obj);
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, errp)) {
@@ -170,6 +171,11 @@ static void filter_buffer_set_interval(Object *obj, Visitor *v,
         return;
     }
     s->interval = value;
+
+    if (nf->netdev && nf->on) {
+        timer_mod(&s->release_timer,
+                  qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + s->interval);
+    }
 }
 
 static void filter_buffer_class_init(ObjectClass *oc, const void *data)
-- 
2.34.1


