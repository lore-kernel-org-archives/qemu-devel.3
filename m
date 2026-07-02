Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E12C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJto-00064U-2P; Thu, 02 Jul 2026 12:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJtm-00064D-J7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJtl-0006Xx-1Q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783008259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imosoSyjc8oivapN2gcbi9LxUJhfQbOr+fmY5+aZ9BE=;
 b=MQEr8nSwXdp9g8oOjZXmQdWkYsQSVJSeH7rGFjRGma7ntG5YoeDA3BjjPz9MXxFhDZU4kg
 2PJxFMFblaTrWgRLOqKzyHdvgHHnLNE0uDo1vA+vWCm3D+5IydrZHpXJ3++IAmZ9Hd3Pkf
 0goPO3WHnvqm2qUJbsX602EZ8+JQC4U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-UZrEjtY9NV2bjLDZDGkQjg-1; Thu,
 02 Jul 2026 12:04:16 -0400
X-MC-Unique: UZrEjtY9NV2bjLDZDGkQjg-1
X-Mimecast-MFC-AGG-ID: UZrEjtY9NV2bjLDZDGkQjg_1783008255
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 429D11944A85; Thu,  2 Jul 2026 16:04:15 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20190194510E; Thu,  2 Jul 2026 16:04:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH v6 07/34] monitor: add 'readline' property to HMP Monitor class
Date: Thu,  2 Jul 2026 17:03:10 +0100
Message-ID: <20260702160337.1910921-8-berrange@redhat.com>
In-Reply-To: <20260702160337.1910921-1-berrange@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
index be59b6ca65..260e4b40fe 100644
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


