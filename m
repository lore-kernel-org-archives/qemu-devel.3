Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21419C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visvH-0004do-5U; Thu, 22 Jan 2026 06:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1visuy-0004b1-RG
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1visus-0007Xj-Di
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769081517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ii4cQD0ST+MxMEinFEnmcuZUQXF8DcPut1AVOJNRDAI=;
 b=FPxJXb0UcR1ft1D1lIhYc3ED5+q+9uECTT3p/wfMvs/u4Yri1YqRpgKmFLFZQW/yG1BEQw
 K8kOrXVo2335yKBrzOz5jFNz0eX3AzZkSjGDzVRkUCJx0aI2xvVv10Xh0yjXXYMhGhfXEW
 mLxB3AFdcNncm6zXfeATBRDSgAf0BDg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-3n9ltSLmOlaL32dcCHjHHw-1; Thu,
 22 Jan 2026 06:31:56 -0500
X-MC-Unique: 3n9ltSLmOlaL32dcCHjHHw-1
X-Mimecast-MFC-AGG-ID: 3n9ltSLmOlaL32dcCHjHHw_1769081515
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 325E6180034F; Thu, 22 Jan 2026 11:31:55 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C14031958DC0; Thu, 22 Jan 2026 11:31:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org
Subject: [PATCH 1/4] tests: fix leaks in dbus-display-test
Date: Thu, 22 Jan 2026 15:31:40 +0400
Message-ID: <20260122113144.2046899-2-marcandre.lureau@redhat.com>
In-Reply-To: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Close the connections and complete the method invocations.

Thanks ASAN for the report.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-display-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 1d5951b7117..5773776cad5 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -76,6 +76,7 @@ test_dbus_display_vm(void)
         qemu_dbus_display1_vm_get_name(QEMU_DBUS_DISPLAY1_VM(vm)),
         ==,
         "dbus-test");
+    g_clear_object(&conn);
     qtest_quit(qts);
 }
 
@@ -97,6 +98,8 @@ static gboolean listener_handle_scanout(
     GVariant *arg_data,
     TestDBusConsoleRegister *test)
 {
+    qemu_dbus_display1_listener_complete_scanout(object, invocation);
+
     if (!test->with_map) {
         g_main_loop_quit(test->loop);
     }
@@ -131,6 +134,9 @@ static gboolean listener_handle_scanout_map(
     g_assert_no_errno(addr == MAP_FAILED ? -1 : 0);
     g_assert_no_errno(munmap(addr, len));
 
+    qemu_dbus_display1_listener_unix_map_complete_scanout_map(object, invocation,
+                                                              NULL);
+
     g_main_loop_quit(test->loop);
 
     close(fd);
@@ -287,6 +293,7 @@ test_dbus_display_console(const void* data)
 
     g_clear_object(&test.server);
     g_clear_object(&test.listener_conn);
+    g_clear_object(&conn);
     qtest_quit(qts);
 }
 
@@ -322,6 +329,7 @@ test_dbus_display_keyboard(void)
         &err);
     if (g_error_matches(err, G_DBUS_ERROR, G_DBUS_ERROR_UNKNOWN_METHOD)) {
         g_test_skip("The VM doesn't have a console!");
+        g_clear_object(&conn);
         qtest_quit(qts);
         return;
     }
@@ -348,6 +356,7 @@ test_dbus_display_keyboard(void)
     g_assert_cmpint(qemu_dbus_display1_keyboard_get_modifiers(
                         QEMU_DBUS_DISPLAY1_KEYBOARD(keyboard)), ==, 0);
 
+    g_clear_object(&conn);
     qtest_quit(qts);
 }
 
-- 
2.52.0


