Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B161DCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlFx-0002ZL-4N; Sat, 09 May 2026 13:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlFv-0002Yj-8o
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlFt-0004dl-Kj
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Or9sAs8SR9br6GVeIhvDb9XD6TOVD7AUKbWB+HucyRs=;
 b=CsTxt3WcLFA4sKBoomKbEpuyMwxJjz045WEQClWeTGLSi6ExA1ciKA8yPLiHic7qPVcd7n
 HuBKEv54o6jdLsoDKvi4DHWpdgn+E9OZ5Uv1DIoDSk6zVOsik2fF64Zghy0yN+YL9SlVnf
 RdAPNGSyqZMEHrOskcWNULdWLbYThfg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-jncvvPNPMi6YBiAOK_ItNQ-1; Sat,
 09 May 2026 13:14:17 -0400
X-MC-Unique: jncvvPNPMi6YBiAOK_ItNQ-1
X-Mimecast-MFC-AGG-ID: jncvvPNPMi6YBiAOK_ItNQ_1778346856
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5420E195608B; Sat,  9 May 2026 17:14:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AAD81801A63; Sat,  9 May 2026 17:14:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 02/33] tests/qtest/dbus-vmstate: Mute Glib complaints about
 g_unsetenv thread-safety
Date: Sat,  9 May 2026 21:13:23 +0400
Message-ID: <20260509171356.1157879-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Fabiano Rosas <farosas@suse.de>

TLDR: GLib is bugged, the dbus-vmstate-test spams debug messages
unconditionally. Mute them.

GLib is trying to protect against the lack of thread-safety of
setenv/unsetsenv functions by warning when those functions were
invoked after a thread has been started.
https://gitlab.gnome.org/GNOME/glib/issues/715

Unfortunately:
1) GLib itself starts a thread pool via _g_dbus_initialize when
working around a bug in its type dependency chain. This happens in
many places, but the test triggers it via
g_dbus_address_get_for_bus_sync.
https://bugzilla.gnome.org/show_bug.cgi?id=627724

2) GLib itself calls g_unsetenv after the test calls g_test_dbus_up.

3) The debug message at g_unsetenv is issued to the G_LOG_DOMAIN
defined while compiling the library, i.e "GLib", but this domain is
never initialized, so the log functions go into a fallback chain that
results in ignoring the G_MESSAGES_DEBUG environment variable, causing
the debug messages to not be suppressed when they should.

Mute the messages by implementing a handler for G_LOG_LEVEL_DEBUG
in the "GLib" log domain and honoring G_MESSAGES_DEBUG.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260429190550.20122-3-farosas@suse.de>
---
 tests/qtest/dbus-vmstate-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 90c050b4480..51c5fdb995a 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -357,12 +357,33 @@ test_dbus_vmstate_missing_dst(char *name, MigrateCommon *args)
     g_test_trap_assert_passed();
 }
 
+static void log_func(const gchar *log_domain, GLogLevelFlags log_level,
+                     const gchar *message, gpointer user_data)
+{
+    const gchar *domains;
+
+    assert(log_level & G_LOG_LEVEL_DEBUG);
+
+    domains = getenv("G_MESSAGES_DEBUG");
+    if (!domains || (!strstr(domains, "GLib") && !strstr(domains, "all"))) {
+        return;
+    }
+    g_log_default_handler("GLib", G_LOG_LEVEL_DEBUG, message, NULL);
+}
+
 int
 main(int argc, char **argv)
 {
     GError *err = NULL;
     int ret;
 
+    /*
+     * GLib currently emits debug messages that ignore
+     * G_MESSAGES_DEBUG. Set a custom log handler to work around the
+     * issue.
+     */
+    g_log_set_handler("GLib", G_LOG_LEVEL_DEBUG, log_func, NULL);
+
     g_test_init(&argc, &argv, NULL);
 
     workdir = g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
-- 
2.54.0


