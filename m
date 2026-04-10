Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE95CF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHSM-0006LT-HQ; Fri, 10 Apr 2026 15:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSL-0006LL-AL
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSI-0002AP-Pk
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fQZAClfmrscJEkRBjDcdDVW8Jr0wH1S70Q/Jtmz4tw=;
 b=RIOsRSvpJwPz7THZzYrqOve+3pMsKph/ZW/lS3NSpdRxB9UYYVr4nossbLnMJ3RoV/WWaS
 vCCfSq9pWm7Wm/edpWbIxAP27MqrXOMlpv6GBeaLSevCKEoJWz8wW0bnWjCA7Fn6hYwb2+
 lgCkIdwD/zWOPEzqKlSC1nNH55DLfXc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-2KgFMogFNvW9_lZiRMfKeQ-1; Fri,
 10 Apr 2026 15:23:48 -0400
X-MC-Unique: 2KgFMogFNvW9_lZiRMfKeQ-1
X-Mimecast-MFC-AGG-ID: 2KgFMogFNvW9_lZiRMfKeQ_1775849028
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E45901801230
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:47 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E69713000C16; Fri, 10 Apr 2026 19:23:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:11 +0400
Subject: [PATCH v2 49/67] ui/vnc: add vnc_cleanup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-49-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FdKqULM+Bhumrtdj2UvMtLgqGMnOx74TlvwWAfVSGL8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0WnGe6FG+pkXPCLSVxZ77fU+YyjV2pJ7Y5U
 58UwlczH2+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5SNkEACe1n+h6ft/OiRA71V+plZaISbkqDS/lj8/mrF7VDbTQ3feEUt1izDFZumJFRnVRXSvpgN
 F0mq8raSSE3qe+W2Cclk2eOXTe7cUba7Oa5ylNBldg3Yd3L2GBSorWk4El0+oaTS/z18W6BrPBf
 a3MgGo0vuUL4jKK/K7wLdFHHqq9UmUoXAi7t0kqdkcYlTgj5GwGaxqjTnwVUaKOWQjYHjrcx3SV
 8iA4sLtoTzvWwOFYmxMMPxGX37FTjDnoZJGSHikJe6c1THDxiI3F9foZyzJhgyNwfkEk4k06n6A
 QRO8mRThICcuxt5/wbMWDpbUNIV9fy199DNxhApB5TUWcBUJyYT8W7e19zP/zhBlryIK4CmHXWU
 v0jw12o0Wtj3exHNoxEbkp+jNris8n8NUL/sit/hy1QwnszcFBuT4RplrIWjRAObL0g642pQjRF
 Z/5kmZ3poaUinmaqlQ09uN3kykL6xl8rVveo85rZG706TlaXG2aJ13rT4mabAdD0EuQQnjrKyph
 xTsVbt3gtUQMj9OueVI99kRCQzP38vSSXzzd7CLIBcIFiJ1vH9z9YtOg/caIpOjYbTPY4muSkhd
 1s6xH8ka8PkEd3yGAcl7oogHJZuY1VmSQZPGJxKz2GzCWYgYakVBReLmqJFWzyqf3xvAfY2ebVn
 y2phPre0z6xUTCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add a function to tear down VNC displays, call it when leaving QEMU.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  1 +
 system/runstate.c    |  5 +++++
 ui/vnc.c             | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 1794f1a2cf0..b3aaf3ff12b 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -455,6 +455,7 @@ void vnc_parse(const char *str);
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
 bool vnc_display_reload_certs(const char *id,  Error **errp);
 bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp);
+void vnc_cleanup(void);
 
 /* input.c */
 int index_from_key(const char *key, size_t key_length);
diff --git a/system/runstate.c b/system/runstate.c
index 770253b467b..0e1cb3b4e67 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -61,6 +61,8 @@
 #include "system/confidential-guest-support.h"
 #include "system/system.h"
 #include "system/tpm.h"
+#include "ui/console.h"
+
 #include "trace.h"
 
 static NotifierList exit_notifiers =
@@ -1044,5 +1046,8 @@ void qemu_cleanup(int status)
     monitor_cleanup();
     qemu_chr_cleanup();
     user_creatable_cleanup();
+#ifdef CONFIG_VNC
+    vnc_cleanup();
+#endif
     /* TODO: unref root container, check all devices are ok */
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 4d5b36a6fa8..c26b581f3ef 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4354,6 +4354,30 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return vnc_display_new(id, errp) != NULL ? 0 : -1;
 }
 
+void vnc_cleanup(void)
+{
+    VncDisplay *vd, *vd_next;
+    VncState *vs;
+
+    QTAILQ_FOREACH(vd, &vnc_displays, next) {
+        if (vd->listener) {
+            qio_net_listener_disconnect(vd->listener);
+        }
+        if (vd->wslistener) {
+            qio_net_listener_disconnect(vd->wslistener);
+        }
+        QTAILQ_FOREACH(vs, &vd->clients, next) {
+            vnc_disconnect_start(vs);
+        }
+    }
+    QTAILQ_FOREACH_SAFE(vd, &vnc_displays, next, vd_next) {
+        while (!QTAILQ_EMPTY(&vd->clients)) {
+            main_loop_wait(false);
+        }
+        vnc_display_free(vd);
+    }
+}
+
 static void vnc_register_config(void)
 {
     qemu_add_opts(&qemu_vnc_opts);

-- 
2.53.0


