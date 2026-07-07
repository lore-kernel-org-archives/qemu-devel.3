Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8A7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aI-0002SI-Qr; Tue, 07 Jul 2026 07:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a3-0002KI-Pk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a2-00084J-Bl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0vsz1oL++u0YQvfkWjDECtDbWy7Q45p6EemFAOcrHo=;
 b=J42rcTgDfWUaADxxJpijiA4ychkxJ2/ZTOnBWc2029j0PCkd5rrqjFs6JZ2wKahQesEHkC
 60btqqDqeEqnNuZOWLMHmsH/HE+LK4mDOYC4Fik5hHmZMBJU8sxGFO36p8m/ijQncI3+n5
 2mJarLQkt9YagBC2mVhU0VokwNCY4zo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-Y4CdWP5wPvGUo8A0r4WyGw-1; Tue,
 07 Jul 2026 07:03:07 -0400
X-MC-Unique: Y4CdWP5wPvGUo8A0r4WyGw-1
X-Mimecast-MFC-AGG-ID: Y4CdWP5wPvGUo8A0r4WyGw_1783422186
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C70F41954B1E
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8736818005B6
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B4A7221E675A; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 08/35] monitor: add 'readline' property to HMP Monitor class
Date: Tue,  7 Jul 2026 13:02:33 +0200
Message-ID: <20260707110300.1918153-9-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This determines whether a human monitor runs with readline for
interactive use, or without readline for non-interactive use by
the GDB stub.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-9-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/hmp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 34a39b071c..54fd25f220 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -50,12 +50,37 @@ static void monitor_hmp_finalize(Object *obj)
 {
 }
 
+static bool monitor_hmp_get_readline(Object *obj, Error **errp)
+{
+    MonitorHMP *mon = MONITOR_HMP(obj);
+
+    return mon->use_readline;
+}
+
+static void monitor_hmp_set_readline(Object *obj, bool val, Error **errp)
+{
+    MonitorHMP *mon = MONITOR_HMP(obj);
+
+    mon->use_readline = val;
+}
+
 static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 {
+    object_class_property_add_bool(cls, "readline",
+                                   monitor_hmp_get_readline,
+                                   monitor_hmp_set_readline);
 }
 
 static void monitor_hmp_init(Object *obj)
 {
+    MonitorHMP *hmp = MONITOR_HMP(obj);
+
+    /*
+     * Default to common case for external HMP use,
+     * as opposed to non-interactive internal use
+     * from gdbstub
+     */
+    hmp->use_readline = true;
 }
 
 static void monitor_command_cb(void *opaque, const char *cmdline,
@@ -1550,6 +1575,7 @@ void monitor_new_hmp(const char *id, const char *chardev_id,
                                         id ? id : autoid,
                                         errp,
                                         "chardev", chardev_id,
+                                        "readline", use_readline ? "yes" : "no",
                                         NULL);
 
     if (!obj) {
@@ -1566,7 +1592,6 @@ void monitor_new_hmp(const char *id, const char *chardev_id,
 
     monitor_data_init(&mon->parent_obj, false, false, false);
 
-    mon->use_readline = use_readline;
     if (mon->use_readline) {
         mon->rs = readline_init(monitor_readline_printf,
                                 monitor_readline_flush,
-- 
2.54.0


