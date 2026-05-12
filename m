Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CC2CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuPe-0006b8-1p; Tue, 12 May 2026 17:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuPE-0004nR-CW
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:46 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuPC-0004tC-SH
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2717C623A5;
 Tue, 12 May 2026 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dK9uBroXGIz4etI8qyTgwDI0YhmV4Tjq0hi3RQ/SAuk=;
 b=esCbElSh9ArR3w0Rb111AaduNbB0Mfhm7+E+3Kr6i/1d9NiTKfxoHyo6TioUU/pZJITqhl
 vPXi+Y7RiFoWnfaX3Q0KChL1jmgS1/R9QOPIIPlu/dvUKgYqLsfLwO78ZazhjOES1AnFs9
 m9ShYO5tIsrp3Ob6ueFi2nK/uaDLgkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dK9uBroXGIz4etI8qyTgwDI0YhmV4Tjq0hi3RQ/SAuk=;
 b=ca6vFLi4zBQVh7qPoV/h6u3zk5mETuUJzUGjHsttqAIjajvqaFRQeej+aCj5JFoaER1M6O
 e9UYRqhi+In84jCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=esCbElSh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ca6vFLi4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dK9uBroXGIz4etI8qyTgwDI0YhmV4Tjq0hi3RQ/SAuk=;
 b=esCbElSh9ArR3w0Rb111AaduNbB0Mfhm7+E+3Kr6i/1d9NiTKfxoHyo6TioUU/pZJITqhl
 vPXi+Y7RiFoWnfaX3Q0KChL1jmgS1/R9QOPIIPlu/dvUKgYqLsfLwO78ZazhjOES1AnFs9
 m9ShYO5tIsrp3Ob6ueFi2nK/uaDLgkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dK9uBroXGIz4etI8qyTgwDI0YhmV4Tjq0hi3RQ/SAuk=;
 b=ca6vFLi4zBQVh7qPoV/h6u3zk5mETuUJzUGjHsttqAIjajvqaFRQeej+aCj5JFoaER1M6O
 e9UYRqhi+In84jCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61CE2593A9;
 Tue, 12 May 2026 21:12:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QMCsDLyXA2r+IAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 May 2026 21:12:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/4] tests/qtest/libqtest: Replace QTEST_TRACE with
 QTEST_QEMU_ARGS
Date: Tue, 12 May 2026 18:12:18 -0300
Message-ID: <20260512211221.3173-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512211221.3173-1-farosas@suse.de>
References: <20260512211221.3173-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linaro.org:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, suse.de:mid,
 linaro.org:email]
X-Rspamd-Queue-Id: 2717C623A5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The QTEST_TRACE environment variable allows for any QEMU command line
option to be passed if used like so:

export QTEST_TRACE="-trace tracepoint -more -opts -here"

Formalize that usage by accepting a new QTEST_QEMU_ARGS
variable. Since the QTEST_TRACE now becomes redundant, remove its
usage.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260429003130.15164-2-farosas@suse.de
[end all fmt strings with space]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 116a8a3258..dc4a665cfa 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -454,28 +454,27 @@ gchar *qtest_qemu_args(const char *extra_args)
 {
     g_autofree gchar *socket_path = qtest_socket_path("sock");
     g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
-    const char *trace = g_getenv("QTEST_TRACE");
-    g_autofree char *tracearg = trace ? g_strdup_printf("-trace %s ", trace) :
-                                        g_strdup("");
+    const char *args_from_env = g_getenv("QTEST_QEMU_ARGS");
+
     gchar *args = g_strdup_printf(
-                      "%s"
                       "-qtest unix:%s "
                       "-qtest-log %s "
                       "-chardev socket,path=%s,id=char0 "
                       "-mon chardev=char0,mode=control "
                       "-display none "
                       "-audio none "
-                      "%s"
-                      "%s"
-                      " -accel qtest",
+                      "%s "
+                      "%s "
+                      "%s "
+                      "-accel qtest",
 
-                      tracearg,
                       socket_path,
                       getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
                       qmp_socket_path,
                       can_exit_with_parent() ?
-                      "-run-with exit-with-parent=on " : "",
-                      extra_args ?: "");
+                      "-run-with exit-with-parent=on" : "",
+                      extra_args ?: "",
+                      args_from_env ?: "");
 
     return args;
 }
-- 
2.51.0


