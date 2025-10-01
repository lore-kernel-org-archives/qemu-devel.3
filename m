Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F81DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44oh-0002mt-Qq; Wed, 01 Oct 2025 17:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44od-0002dN-Mx
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:56:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44oT-0006Vx-GG
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:56:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1CA13377B;
 Wed,  1 Oct 2025 21:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tmdqlCJSDckHVYlAL/dBQu1k245mIF7Awdy1N/SW6I=;
 b=lPIG0zoEC9jp+nobYgqDKsp1Xe35GJgvjRAO7moANP4sUxVi6JHjM40F/vOWdZgVayiwJL
 Rm8PvEREQLNd6lMWSeMxk63P7f6eIcV43P23OriZg9Lu3Zfvzr3TvQf6CpPCl4/CiQevmP
 Ab4s76gEUbXZoPweHeIcqfTZq54LQqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tmdqlCJSDckHVYlAL/dBQu1k245mIF7Awdy1N/SW6I=;
 b=EzAt2qjNqtU2Tmz2+Zd50Jyv6ceH7IVMjCRNQIo4PWo7nHYoKpgAUwZfuf6wT0XHBeyrH5
 uN6FhSjXZY5YFTDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oN29q7N3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="tinYJg/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tmdqlCJSDckHVYlAL/dBQu1k245mIF7Awdy1N/SW6I=;
 b=oN29q7N3PBGr++QPx0Kwd4tiBPH2PG9vt+LUkS6FLhn4ULp4QAbwgDd711aE2o2sb93QT9
 tyy0CNkN8QmZ68gvsl8MHnAyyz4l//0oORELqO+L913qcslXvbeFOcgUKyY17QSOWjdGjt
 CBcoNOZMWV61nC3hYLhOjLvGC2b6ZhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tmdqlCJSDckHVYlAL/dBQu1k245mIF7Awdy1N/SW6I=;
 b=tinYJg/5fZawL6m6Bf8U6+deREwz/RUeavFhEdZgEtVS0zpM1cIu3S1BkhTfigPkv4Iz5h
 +q+kF0zpYuxHycDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97ADF13A3F;
 Wed,  1 Oct 2025 21:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CN47FcOi3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 06/13] tests/qtest: qtest_create_test_state
Date: Wed,  1 Oct 2025 18:52:47 -0300
Message-Id: <20251001215254.2863-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: F1CA13377B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor qtest_spawn_qemu and create a subroutine to create a QTestState
object, to be used in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1759332851-370353-12-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 551bc8c1b8..3fa93172c1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -409,22 +409,29 @@ static pid_t qtest_create_process(char *cmd)
 }
 #endif /* _WIN32 */
 
-static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
+static QTestState *qtest_create_test_state(int pid)
 {
     QTestState *s = g_new0(QTestState, 1);
+
+    s->qemu_pid = pid;
+    qtest_add_abrt_handler(kill_qemu_hook_func, s);
+    return s;
+}
+
+static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
+{
+    int pid;
     g_autoptr(GString) command = g_string_new("");
 
     g_string_printf(command, CMD_EXEC "%s %s", qemu_bin, args);
 
-    qtest_add_abrt_handler(kill_qemu_hook_func, s);
-
     if (!silence_spawn_log) {
         g_test_message("starting QEMU: %s", command->str);
     }
 
 #ifndef _WIN32
-    s->qemu_pid = fork();
-    if (s->qemu_pid == 0) {
+    pid = fork();
+    if (pid == 0) {
 #ifdef __linux__
         /*
          * Although we register a ABRT handler to kill off QEMU
@@ -447,10 +454,10 @@ static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
         exit(1);
     }
 #else
-    s->qemu_pid = qtest_create_process(command->str);
+    pid = qtest_create_process(command->str);
 #endif /* _WIN32 */
 
-    return s;
+    return qtest_create_test_state(pid);
 }
 
 static char *qtest_socket_path(const char *suffix)
-- 
2.35.3


