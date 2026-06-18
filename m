Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CC2CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAT8-0006Tp-Rp; Thu, 18 Jun 2026 06:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waASv-0006Ra-E9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waASr-00024b-M1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781780357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PNRLvKKq9Fd6wQBFJY1X5kKHeTnmWLKDPWDcl5Zmms=;
 b=ic7EZGevERzXIBfvs0khx+06+AdLhy5usNIyf7CVO0FAi5LtljH+VnjNh5Sk8pSQyr665J
 Qo4V8jbGXQ7TkhdJTvP4W+t/0u4er2oTGTBuPW3/1grbxwBkJYqhfSL3GiDej0gVYnZJpK
 aTZFbNn0HDw/XFBpKbRe+A19UpMzW0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-bXT9ZqKIPdKtXAlraic_MA-1; Thu,
 18 Jun 2026 06:59:13 -0400
X-MC-Unique: bXT9ZqKIPdKtXAlraic_MA-1
X-Mimecast-MFC-AGG-ID: bXT9ZqKIPdKtXAlraic_MA_1781780352
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7EBB19560AD; Thu, 18 Jun 2026 10:59:12 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A10751956087; Thu, 18 Jun 2026 10:59:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 08/35] monitor: add 'pretty' property to QMP Monitor class
Date: Thu, 18 Jun 2026 11:58:09 +0100
Message-ID: <20260618105836.991609-9-berrange@redhat.com>
In-Reply-To: <20260618105836.991609-1-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This determines whether the QMP JSON responses are pretty printed
with newlines and indentation, or compact with no extra whitespace.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/qmp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 0abf2677f9..2a8532ef96 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -77,8 +77,25 @@ static void monitor_qmp_finalize(Object *obj)
 {
 }
 
+static bool monitor_qmp_get_pretty(Object *obj, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    return mon->pretty;
+}
+
+static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    mon->pretty = val;
+}
+
 static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 {
+    object_class_property_add_bool(cls, "pretty",
+                                   monitor_qmp_get_pretty,
+                                   monitor_qmp_set_pretty);
 }
 
 static void monitor_qmp_init(Object *obj)
@@ -538,6 +555,7 @@ void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
                                         id,
                                         errp,
                                         "chardev", chardev_id,
+                                        "pretty", pretty ? "yes" : "no",
                                         NULL);
 
     if (!obj) {
@@ -558,8 +576,6 @@ void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
                       qemu_chr_has_feature(mon->parent_obj.chr.chr,
                                            QEMU_CHAR_FEATURE_GCONTEXT));
 
-    mon->pretty = pretty;
-
     qemu_mutex_init(&mon->qmp_queue_lock);
     mon->qmp_requests = g_queue_new();
 
-- 
2.54.0


