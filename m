Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1B9C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aJ-0002To-BL; Tue, 07 Jul 2026 07:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a7-0002NY-3l
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a4-00085e-Ii
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0YCZRGo9KJrmjLhzgj+LRXCW2CRpl5U4QQcUJBzviw=;
 b=i8up1wzS9IDrSul+PNPoQKmfChnt4lbTfIvwHoQFEZAgV14vgYEg2t+hDfPnWQuAj7TOZF
 uH+siVI+Geg0aTR+tlYmCAeivFn927klbuHHRv+uugqhRuSS3Kr19S9eSlvWxykHBm/x0J
 lHjenx/0qAJhqLxsTocp0A26EIMa7O4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-byJRQO_rNDeLOMmoEyPmFQ-1; Tue,
 07 Jul 2026 07:03:10 -0400
X-MC-Unique: byJRQO_rNDeLOMmoEyPmFQ-1
X-Mimecast-MFC-AGG-ID: byJRQO_rNDeLOMmoEyPmFQ_1783422189
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9646D19540C5
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54C3318005B9
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E22F021E64C1; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 19/35] monitor: use dynamic cast in QMP commands
Date: Tue,  7 Jul 2026 13:02:44 +0200
Message-ID: <20260707110300.1918153-20-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Rather than asserting monitor_is_qmp(), use a QOM cast via
MONITOR_QMP which performs an assert already.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-20-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/qmp-cmds-control.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index af6a2a118b..8fe0876a3d 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -72,11 +72,7 @@ static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
-    Monitor *cur_mon = monitor_cur();
-    MonitorQMP *mon;
-
-    assert(monitor_is_qmp(cur_mon));
-    mon = container_of(cur_mon, MonitorQMP, parent_obj);
+    MonitorQMP *mon = MONITOR_QMP(monitor_cur());
 
     if (mon->commands == &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
@@ -122,11 +118,7 @@ static void query_commands_cb(const QmpCommand *cmd, void *opaque)
 CommandInfoList *qmp_query_commands(Error **errp)
 {
     CommandInfoList *list = NULL;
-    Monitor *cur_mon = monitor_cur();
-    MonitorQMP *mon;
-
-    assert(monitor_is_qmp(cur_mon));
-    mon = container_of(cur_mon, MonitorQMP, parent_obj);
+    MonitorQMP *mon = MONITOR_QMP(monitor_cur());
 
     qmp_for_each_command(mon->commands, query_commands_cb, &list);
 
-- 
2.54.0


