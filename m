Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399A8CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 22:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44rQ-0006Xe-Dv; Wed, 01 Oct 2025 17:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44rL-0006Qu-Jf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:59:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44r7-0006xW-SY
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:59:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 661261F829;
 Wed,  1 Oct 2025 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHc4oM9ZtZFrk0XUJmqzObtuG0W98/P5ibR0FuVsWJc=;
 b=xPCFlUgeU1ILMPHYzRt5f80Y+afb9nPlmtEvTQB9l/r0R9+e4EXaeg7qf8zU+glanTm9V8
 4qKq9TQmq6pJKUwAsG4szNnypeKOYvXsc7Zp5WUF+2LR7w6Uw8HYsAgWudtPQ+vavSGANp
 l7UrKgdX0wsq67HKSZ8Jc0zMmvpxIA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHc4oM9ZtZFrk0XUJmqzObtuG0W98/P5ibR0FuVsWJc=;
 b=sUSDNYGLAFIpCsAri9ob1tMDaU3uT6dne2FJwQJJ42PYTJiLI8yOTO8+qC6n5deDwwdyPD
 RmijkfVUct5KD3BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHc4oM9ZtZFrk0XUJmqzObtuG0W98/P5ibR0FuVsWJc=;
 b=xPCFlUgeU1ILMPHYzRt5f80Y+afb9nPlmtEvTQB9l/r0R9+e4EXaeg7qf8zU+glanTm9V8
 4qKq9TQmq6pJKUwAsG4szNnypeKOYvXsc7Zp5WUF+2LR7w6Uw8HYsAgWudtPQ+vavSGANp
 l7UrKgdX0wsq67HKSZ8Jc0zMmvpxIA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHc4oM9ZtZFrk0XUJmqzObtuG0W98/P5ibR0FuVsWJc=;
 b=sUSDNYGLAFIpCsAri9ob1tMDaU3uT6dne2FJwQJJ42PYTJiLI8yOTO8+qC6n5deDwwdyPD
 RmijkfVUct5KD3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E02413ADB;
 Wed,  1 Oct 2025 21:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sJ4ENM+i3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 13/13] migration-test: strv parameter
Date: Wed,  1 Oct 2025 18:52:54 -0300
Message-Id: <20251001215254.2863-14-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
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
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Define migrate_set_parameter_strv.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1759332851-370353-19-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-qmp.c | 16 ++++++++++++++++
 tests/qtest/migration/migration-qmp.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 66dd369ba7..c803fcee9d 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -442,6 +442,22 @@ void migrate_set_parameter_str(QTestState *who, const char *parameter,
     migrate_check_parameter_str(who, parameter, value);
 }
 
+void migrate_set_parameter_strv(QTestState *who, const char *parameter,
+                                char **strv)
+{
+    g_autofree char *args = g_strjoinv("\",\"", strv);
+    g_autoptr(GString) value = g_string_new("");
+    g_autofree char *command = NULL;
+
+    g_string_printf(value, "\"%s\"", args);
+
+    command = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
+                              "'arguments': { %%s: [ %s ]}}",
+                              value->str);
+
+    qtest_qmp_assert_success(who, command, parameter);
+}
+
 static long long migrate_get_parameter_bool(QTestState *who,
                                             const char *parameter)
 {
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index faa8181d91..44482d250f 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -34,6 +34,8 @@ void read_blocktime(QTestState *who);
 void wait_for_migration_pass(QTestState *who, QTestMigrationState *src_state);
 void migrate_set_parameter_str(QTestState *who, const char *parameter,
                                const char *value);
+void migrate_set_parameter_strv(QTestState *who, const char *parameter,
+                                char **strv);
 void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                 int value);
 void migrate_ensure_non_converge(QTestState *who);
-- 
2.35.3


