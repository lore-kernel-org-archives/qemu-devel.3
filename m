Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BFECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44oo-0002u7-1U; Wed, 01 Oct 2025 17:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44og-0002hH-4J
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:56:54 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44oP-0006UY-7H
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:56:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C86201F811;
 Wed,  1 Oct 2025 21:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKOpn+U+BRPN1zCBS7rO+5G7ydgYvhHxYWWtrXfDMU0=;
 b=WnwpgWFrbT4GM+xf/yJaiYr8ERiNlp8jG7L9QUEiJG0L6+WlrG4GtEEfVfMokECS7NNN9T
 ytURE93LqPMnPLhAeOBUkMlP7/JlTeL90p3G8joDoDLaNXiYwUgFt18u+PHjWG0a3xT6Ln
 fDXpntfdk+YhyuPqx+5Sanrz87o2Tjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKOpn+U+BRPN1zCBS7rO+5G7ydgYvhHxYWWtrXfDMU0=;
 b=90iDAQQlyO3LX7Uj76uTrAhmFyHsbGxcI9spOnSLbYb/bcWmrwtbMoFnSj8H2hdkhiLmZL
 lrR7/Fq1Pzk68fAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKOpn+U+BRPN1zCBS7rO+5G7ydgYvhHxYWWtrXfDMU0=;
 b=WnwpgWFrbT4GM+xf/yJaiYr8ERiNlp8jG7L9QUEiJG0L6+WlrG4GtEEfVfMokECS7NNN9T
 ytURE93LqPMnPLhAeOBUkMlP7/JlTeL90p3G8joDoDLaNXiYwUgFt18u+PHjWG0a3xT6Ln
 fDXpntfdk+YhyuPqx+5Sanrz87o2Tjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKOpn+U+BRPN1zCBS7rO+5G7ydgYvhHxYWWtrXfDMU0=;
 b=90iDAQQlyO3LX7Uj76uTrAhmFyHsbGxcI9spOnSLbYb/bcWmrwtbMoFnSj8H2hdkhiLmZL
 lrR7/Fq1Pzk68fAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7569D13ADB;
 Wed,  1 Oct 2025 21:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sJacDcWi3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 07/13] tests/qtest: qtest_qemu_spawn_func
Date: Wed,  1 Oct 2025 18:52:48 -0300
Message-Id: <20251001215254.2863-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Steve Sistare <steven.sistare@oracle.com>

Allow the qtest_qemu_spawn caller to pass the function to be called
to perform the spawn.  The opaque argument is needed by a new spawn
function in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1759332851-370353-13-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 3fa93172c1..d97144e1d5 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -418,7 +418,8 @@ static QTestState *qtest_create_test_state(int pid)
     return s;
 }
 
-static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
+static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args,
+                                    void *opaque)
 {
     int pid;
     g_autoptr(GString) command = g_string_new("");
@@ -492,9 +493,15 @@ gchar *qtest_qemu_args(const char *extra_args)
     return args;
 }
 
+typedef QTestState *(*qtest_qemu_spawn_func)(const char *qemu_bin,
+                                             const char *extra_args,
+                                             void *opaque);
+
 static QTestState *qtest_init_internal(const char *qemu_bin,
                                        const char *extra_args,
-                                       bool do_connect)
+                                       bool do_connect,
+                                       qtest_qemu_spawn_func spawn,
+                                       void *opaque)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -515,7 +522,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     sock = init_socket(socket_path);
     qmpsock = init_socket(qmp_socket_path);
 
-    s = qtest_spawn_qemu(qemu_bin, args);
+    s = spawn(qemu_bin, args, opaque);
 
     qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
@@ -570,7 +577,8 @@ void qtest_connect(QTestState *s)
 
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
-    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true);
+    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true,
+                               qtest_spawn_qemu, NULL);
 }
 
 void qtest_qmp_handshake(QTestState *s, QList *capabilities)
@@ -593,7 +601,7 @@ QTestState *qtest_init_ext(const char *var, const char *extra_args,
                            QList *capabilities, bool do_connect)
 {
     QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
-                                        do_connect);
+                                        do_connect, qtest_spawn_qemu, NULL);
 
     if (do_connect) {
         qtest_qmp_handshake(s, capabilities);
-- 
2.35.3


