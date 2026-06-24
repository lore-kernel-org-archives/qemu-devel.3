Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D71CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1S-0004l2-C3; Wed, 24 Jun 2026 07:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM17-0003g1-JA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM15-0008A6-U8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BoQVjC+WTHa0GDH7WkxeEaC9ZnFqa3LfuA3gPWnOsK4=;
 b=CAF9rSdbrBIvWg+9zAV7TsHMADuG+AbazMLXA3XrFx2JVOxeht7ATKppV8VTZ6bgd+JLB/
 6bM85O/X7zgxrDFPwahNubsFnHjIN5Kn44WbZU7LeEbK4agxliOeKzXVlUNdAPFz50m+5v
 I+M+BKGzxmntB2lFpOjy/MSVMhgcc4Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-b8Mt3R67OWKzdK6zk6wiYQ-1; Wed,
 24 Jun 2026 07:43:37 -0400
X-MC-Unique: b8Mt3R67OWKzdK6zk6wiYQ-1
X-Mimecast-MFC-AGG-ID: b8Mt3R67OWKzdK6zk6wiYQ_1782301417
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D30E1955F23
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FFAB36926; Wed, 24 Jun 2026 11:43:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:45 +0400
Subject: [GIT PULL 23/35] ui/console: add console event notifier infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-23-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Sdok16WnTykV6Ni+P4/d9cRAkIbyiKVJ1ig5XtWrP00=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JoZy9engENe7rNbikCDWGwG87Qkf2q978Vi
 Qzp6ThCGciJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5dOED/40O6dgyZaNXEAG8q4BFyr7kj/bCHN9I92xD+tPoTVUkLoIPn4yKMipifWVnFcQ9MCi8l4
 +hlUJ1Yj4IGRMNcpV5IO4vxCXd9GIDcztOivb2XhBUmHv2zclDdYxzBI8AtAVeSMG3AZZAN+SW7
 SrnUbdRWRNuKXehmzDvb1Fgxv4rZGwcPdNA4iOzuU5LFkB8KoTGas4TSBh0TrJ8s4cCCYisdGo3
 Aq8yolNQKyIfZiwaMLfAmoPh7nOU0nKOcxDtWHxfiJaFAFdIfpuALOsj8fCPazAHP8aTBHocwQy
 vIIW1RFF4HpDV/TK1MV5mrpnLDCIKFoooMNY85nn+GeMGcCV7rft8Bio6Uj/et6xBENGdL/ujt0
 PDZKZhkvmNaLUxdXQKkT06bw5VxmHanCWqvJXh/Jz0WQUADpHZozi76qzfcQopZtSAMldTZ8Esn
 sbUq0zSDBeFhizVzscaD9Zi6d4dVJlK0yO9R8VlJ3LJ0MSS/SZaOOwsU5TrLB9QL3onBHXPHNmb
 2PAZEIp+Iv6ZFVODl2PtJBDULF5LQkCjRxiAaCTHooXpLDu8hPNfG6E4hzhfIigd7qyIddpfXMO
 5PdxYo56aBK2Yxhasz24HsLKELtHfCz3sgm8eskrELSwwM0ouP4jirWXCtcxnu7e8gmX76R2AfT
 LzwZDgqCCYY9POg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Add a NotifierList to DisplayState so display backends can be notified
when consoles are added or removed at runtime.

No events are fired yet, that follows in the next commits.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-23-4656aec3398d@redhat.com>
---
 include/ui/console.h | 18 ++++++++++++++++++
 ui/console.c         | 23 +++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 5322c56009d..29bf7228883 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -415,6 +415,24 @@ const char *qemu_display_get_vc(DisplayOptions *opts);
 void qemu_display_cleanup(void);
 void qemu_display_help(void);
 
+/*
+ * Console notifications:
+ * Handlers must be idempotent, it may notify multiple times.
+ */
+typedef enum {
+    QEMU_CONSOLE_ADDED,
+    QEMU_CONSOLE_REMOVED,
+} QemuConsoleEventType;
+
+typedef struct QemuConsoleEvent {
+    QemuConsoleEventType type;
+    QemuConsole *con;
+} QemuConsoleEvent;
+
+void qemu_console_add_notifier(Notifier *notifier);
+void qemu_console_remove_notifier(Notifier *notifier);
+void qemu_console_notify(QemuConsoleEventType type, QemuConsole *con);
+
 /* vnc.c */
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password, Error **errp);
diff --git a/ui/console.c b/ui/console.c
index 1fe3e3a3a6c..76851bc129d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -70,6 +70,7 @@ struct DisplayState {
     bool refreshing;
 
     QLIST_HEAD(, DisplayChangeListener) listeners;
+    NotifierList console_notifiers;
 };
 
 static DisplayState *display_state;
@@ -84,6 +85,16 @@ static bool console_compatible_with(QemuConsole *con,
 static QemuConsole *qemu_graphic_console_lookup_unused(void);
 static void dpy_set_ui_info_timer(void *opaque);
 
+void qemu_console_notify(QemuConsoleEventType type, QemuConsole *con)
+{
+    DisplayState *ds = get_alloc_displaystate();
+    QemuConsoleEvent event = {
+        .type = type,
+        .con = con,
+    };
+    notifier_list_notify(&ds->console_notifiers, &event);
+}
+
 static void gui_update(void *opaque)
 {
     uint64_t interval = GUI_REFRESH_INTERVAL_IDLE;
@@ -1056,10 +1067,22 @@ static DisplayState *get_alloc_displaystate(void)
 {
     if (!display_state) {
         display_state = g_new0(DisplayState, 1);
+        notifier_list_init(&display_state->console_notifiers);
     }
     return display_state;
 }
 
+void qemu_console_add_notifier(Notifier *notifier)
+{
+    DisplayState *ds = get_alloc_displaystate();
+    notifier_list_add(&ds->console_notifiers, notifier);
+}
+
+void qemu_console_remove_notifier(Notifier *notifier)
+{
+    notifier_remove(notifier);
+}
+
 /*
  * Called by main(), after creating QemuConsoles
  * and before initializing ui (sdl/vnc/...).

-- 
2.54.0


