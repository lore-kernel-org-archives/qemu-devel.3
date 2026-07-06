Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D29FC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjqu-0001sZ-8U; Mon, 06 Jul 2026 09:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjqm-0001ri-6N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjqk-0001cv-LD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783346346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkjdrI725VspPVbuz3o4rBqZpOogPffuMLbDQ9eM+wg=;
 b=PqPaLib1eh3ZZzQQeLaTkBKWi4vwv58e0ZnlAONwe/rcaDhK+i3QLVh5hTlB1v3fcH+QnF
 ZikGesUN9B7QTCXPPVsHe0BqyqrZJugXcqhZgHfsZ1QYX4bBhIup3YwEQ5LAnTdSBHmbBN
 jXef1a18Kdp2/FFNUGBET2kU41wvG28=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-Zlxv7Q1LNYm56ZXJmd5V5Q-1; Mon,
 06 Jul 2026 09:59:04 -0400
X-MC-Unique: Zlxv7Q1LNYm56ZXJmd5V5Q-1
X-Mimecast-MFC-AGG-ID: Zlxv7Q1LNYm56ZXJmd5V5Q_1783346343
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50C6F1805A0C; Mon,  6 Jul 2026 13:59:03 +0000 (UTC)
Received: from berrange.com (unknown [10.44.48.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 000B93000B4E; Mon,  6 Jul 2026 13:58:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v7 08/35] monitor: add 'readline' property to HMP Monitor class
Date: Mon,  6 Jul 2026 14:57:56 +0100
Message-ID: <20260706135824.2623960-9-berrange@redhat.com>
In-Reply-To: <20260706135824.2623960-1-berrange@redhat.com>
References: <20260706135824.2623960-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This determines whether a human monitor runs with readline for
interactive use, or without readline for non-interactive use by
the GDB stub.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.55.0


