Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0474D7237F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGAx-0005a7-8r; Fri, 23 Jan 2026 07:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGAa-00058Y-Md
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGAZ-00055Z-AA
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769170902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeMx6AsK3anORPzR6IouDopmDhX/6ygcD5xk4N1Z3hI=;
 b=FlCHlsRKFtr/syBmmxgNYJi9QKZ+zYAy2qBLFN3oknDAYTB8nEEKISmO17wifUDCq7lMZV
 FCPSdDnuUaLk2hevPJD0tn55RcW2A4ekivvV3yARgblxzcmVwG7SisX0GEeFejRA9dXUA9
 06uP60MzDnfezY6poWjOVKOzx3o0DnQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-Do6yTjWVMG6DS6-Yb8gThQ-1; Fri,
 23 Jan 2026 07:21:41 -0500
X-MC-Unique: Do6yTjWVMG6DS6-Yb8gThQ-1
X-Mimecast-MFC-AGG-ID: Do6yTjWVMG6DS6-Yb8gThQ_1769170900
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36FED1956096; Fri, 23 Jan 2026 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEB9030002D1; Fri, 23 Jan 2026 12:21:37 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	Zhang Chen <zhangckid@gmail.com>
Subject: [PULL 09/13] net/filter-buffer: make interval change take effect
 immediately
Date: Fri, 23 Jan 2026 20:20:58 +0800
Message-ID: <20260123122102.51422-10-jasowang@redhat.com>
In-Reply-To: <20260123122102.51422-1-jasowang@redhat.com>
References: <20260123122102.51422-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Previously, when the 'interval' property was modified at runtime via
QMP, the new value would only take effect after the current timer
period elapsed. This could lead to unexpected behavior when users
expect immediate changes.

Fix this by checking if the timer is already running when setting
the interval property. If so, reschedule the timer with the new
interval value immediately.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>
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
2.42.0


