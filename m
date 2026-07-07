Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032AEC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aS-0002hO-28; Tue, 07 Jul 2026 07:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a3-0002KH-Pg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a1-00084K-JJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7l0qxJl+3l4hatbmMLHuongOLfRhgIBNo71CXMyuJaE=;
 b=IXtmPBlbHwpJcRnKCK48/4qSOXUfCg4yUKJF2eqt2E5SeDEFiX59a0mJn63MKI5kgXvYEk
 gf7NDGoKbvyCd2Ya8d+b9LrXaYnnaUH6ASjY2xb6+MnL+feRHnZ31fBjFGuV7h0fAByf9J
 KF52i4AqKeW56NtV/30WfcJNcoEc9m4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-kj61ogxOM7qL19EZuYQQSg-1; Tue,
 07 Jul 2026 07:03:07 -0400
X-MC-Unique: kj61ogxOM7qL19EZuYQQSg-1
X-Mimecast-MFC-AGG-ID: kj61ogxOM7qL19EZuYQQSg_1783422186
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C154D180AC51
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 822361956040
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA8B221E66E3; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 09/35] monitor: add 'pretty' property to QMP Monitor class
Date: Tue,  7 Jul 2026 13:02:34 +0200
Message-ID: <20260707110300.1918153-10-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

This determines whether the QMP JSON responses are pretty printed
with newlines and indentation, or compact with no extra whitespace.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-10-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/qmp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index df35b530ed..d7adb9ba8b 100644
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
@@ -538,6 +555,7 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
                                         id ? id : autoid,
                                         errp,
                                         "chardev", chardev_id,
+                                        "pretty", pretty ? "yes" : "no",
                                         NULL);
 
     if (!obj) {
@@ -558,8 +576,6 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
                       qemu_chr_has_feature(mon->parent_obj.chr.chr,
                                            QEMU_CHAR_FEATURE_GCONTEXT));
 
-    mon->pretty = pretty;
-
     qemu_mutex_init(&mon->qmp_queue_lock);
     mon->qmp_requests = g_queue_new();
 
-- 
2.54.0


