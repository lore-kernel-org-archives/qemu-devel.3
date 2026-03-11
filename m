Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60079103E2E8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 22:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Ro4-0000sM-Pl; Wed, 11 Mar 2026 18:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0Ro3-0000rn-9r
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:13:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0Rnz-0004yi-8V
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:13:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A0845C226;
 Wed, 11 Mar 2026 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773267205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bUxM2kWtbIydGXKb0MroLDjr7nUS9i7JFN2WLUWOOY=;
 b=YLi5aIVe1cVG3IcnY6K1iUuuahyKJgZ5CIFvgTqAjQmdXgNmmyiS1x+2yxDbdiqGfZgSHu
 XoqD7pUeyiDNYjaUzGzqj1ijdklIAAd9uIeNmTbpFhfu06Oh9Racj2QXuTHyR9JJg6lEYV
 1uHOrsGIeIWK3q8/UWL/uYeQFKeau6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773267205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bUxM2kWtbIydGXKb0MroLDjr7nUS9i7JFN2WLUWOOY=;
 b=QGzDgzh7mtlV/+rPprY9Jd1Avv8oTtD/5nOJhmVp8eB81MA+INpDM+XN7EYu911cHiXBKM
 77C96LUtVttcjdAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773267205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bUxM2kWtbIydGXKb0MroLDjr7nUS9i7JFN2WLUWOOY=;
 b=YLi5aIVe1cVG3IcnY6K1iUuuahyKJgZ5CIFvgTqAjQmdXgNmmyiS1x+2yxDbdiqGfZgSHu
 XoqD7pUeyiDNYjaUzGzqj1ijdklIAAd9uIeNmTbpFhfu06Oh9Racj2QXuTHyR9JJg6lEYV
 1uHOrsGIeIWK3q8/UWL/uYeQFKeau6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773267205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bUxM2kWtbIydGXKb0MroLDjr7nUS9i7JFN2WLUWOOY=;
 b=QGzDgzh7mtlV/+rPprY9Jd1Avv8oTtD/5nOJhmVp8eB81MA+INpDM+XN7EYu911cHiXBKM
 77C96LUtVttcjdAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BCF83FC44;
 Wed, 11 Mar 2026 22:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WGfPDATpsWnCeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 22:13:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/3] tests/qtest/vhost-user-test: Use g_timeout_add() to
 schedule connect
Date: Wed, 11 Mar 2026 19:13:18 -0300
Message-ID: <20260311221320.22112-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311221320.22112-1-farosas@suse.de>
References: <20260311221320.22112-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,linaro.org:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In vhost-user-test, we currently create a new g_thread to run the
connect_thread() function.  This function sleeps for 1 second, and
then calls test_server_create_chr() to create and configure a
chardev:

    chr = qemu_chr_new(server->chr_name, chr_path, server->context);
    g_assert(chr);

    qemu_chr_fe_init(&server->chr, chr, &error_abort);
    qemu_chr_fe_set_handlers(&server->chr, chr_can_read, chr_read,
                             chr_event, NULL, server, server->context, true);

This has a race condition, because when we set the
'reconnect-ms=1000' option on the chardev the socket chardev's
implementation handles the connect asynchronously, via a background
thread and a callback invoked in the main-loop thread.  This means
that that callback and the test_server_create_chr() call to
qemu_chr_fe_set_handlers() can both enter the char-socket code
simultaneously.  The result is random assertion failures and memory
leaks reported by the clang address-sanitizer.

Fix this by using g_timeout_source_new() to set up a GSource that
will run test_server_connect() on the main-loop thread.  This ensures
it can't execute in parallel with the callback that the socket
chardev sets up.  This is similar to how we already handle the
reconnect_cb() in test_reconnect().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/vhost-user-test.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d2bb21d5b9..c8b5f8ff71 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -930,26 +930,42 @@ reconnect_cb(gpointer user_data)
     return FALSE;
 }
 
-static gpointer
-connect_thread(gpointer data)
+static gboolean connect_cb(gpointer user_data)
 {
-    TestServer *s = data;
+    TestServer *s = user_data;
 
-    /* wait for qemu to start before first try, to avoid extra warnings */
-    g_usleep(G_USEC_PER_SEC);
     test_server_connect(s);
 
-    return NULL;
+    /* We only need to be called once */
+    return G_SOURCE_REMOVE;
+}
+
+/* Initial delay before connect, in milliseconds (1 second) */
+#define INITIAL_CONNECT_DELAY_MS (1 * 1000)
+
+static void test_schedule_connect(TestServer *s)
+{
+    /*
+     * Wait for a bit for QEMU to start before we first try to connect,
+     * to avoid extra warnings. We must run the "connect" on the
+     * main-loop thread so it doesn't race with a callback that
+     * the socket-chardev sets up on the main-loop.
+     */
+    GSource *src = g_timeout_source_new(INITIAL_CONNECT_DELAY_MS);
+    g_source_set_callback(src, connect_cb, s, NULL);
+    g_source_attach(src, s->context);
+    g_source_unref(src);
 }
 
 static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
 {
     TestServer *s = test_server_new("reconnect", arg);
 
-    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
+    test_schedule_connect(s);
+
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
     return s;
@@ -983,10 +999,11 @@ static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
 
     s->test_fail = true;
 
-    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
+    test_schedule_connect(s);
+
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
     return s;
@@ -998,10 +1015,11 @@ static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
 
-    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
+    test_schedule_connect(s);
+
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
     return s;
-- 
2.51.0


