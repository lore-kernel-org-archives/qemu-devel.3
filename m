Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDE4C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpXd-0004GR-Dy; Fri, 17 Jan 2025 11:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXZ-0004D7-JL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:49 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXX-0001Es-L6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DA782126D;
 Fri, 17 Jan 2025 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6vPYsR1SOU0W45lR5X2L88SOzwXIIrQNvy0gQ9sxCM=;
 b=yPkg2rlIoONXEtIG6ZT8GlmDQP2uemjdD57G3ptZ8ff8NXPAIs5MQ3ImLTmQSw3ZRGWuNH
 oOI+/9BP5Bb3WLvGE7KNVAj3HrBYR/XMfZsD+vn5TcDXZseHnwvG0P7lcAPQzTBORYMt2f
 eYpCoVKwRR1od61w080MgKN+iLp0wqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6vPYsR1SOU0W45lR5X2L88SOzwXIIrQNvy0gQ9sxCM=;
 b=CyHhU//4nzNqPXHhjK/ZUNQncgxs5JfehLa4A8w1N/hUsYtrmxO4ViiQC9pYTC2RBS+J7Q
 pCjDPL7G7HKUbQAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yPkg2rlI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="CyHhU//4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6vPYsR1SOU0W45lR5X2L88SOzwXIIrQNvy0gQ9sxCM=;
 b=yPkg2rlIoONXEtIG6ZT8GlmDQP2uemjdD57G3ptZ8ff8NXPAIs5MQ3ImLTmQSw3ZRGWuNH
 oOI+/9BP5Bb3WLvGE7KNVAj3HrBYR/XMfZsD+vn5TcDXZseHnwvG0P7lcAPQzTBORYMt2f
 eYpCoVKwRR1od61w080MgKN+iLp0wqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6vPYsR1SOU0W45lR5X2L88SOzwXIIrQNvy0gQ9sxCM=;
 b=CyHhU//4nzNqPXHhjK/ZUNQncgxs5JfehLa4A8w1N/hUsYtrmxO4ViiQC9pYTC2RBS+J7Q
 pCjDPL7G7HKUbQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9BE813332;
 Fri, 17 Jan 2025 16:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yNZsISiKimftQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 Jan 2025 16:49:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 3/5] tests/qtest: Introduce
 qtest_init_with_env_and_capabilities()
Date: Fri, 17 Jan 2025 13:49:34 -0300
Message-Id: <20250117164936.22223-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250117164936.22223-1-farosas@suse.de>
References: <20250117164936.22223-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DA782126D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

This patch adds a new version of qtest_init_with_env() that allows
specifying QMP capabilities that should be enabled during handshake.
This is useful for example if a test needs out-of-band execution of QMP
commands, it can initialize with the oob capability.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 18 ++++++++++++++++--
 tests/qtest/libqtest.h | 17 +++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 4bc9643aad..a1e105f27f 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -543,7 +543,9 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
 }
 
-QTestState *qtest_init_with_env(const char *var, const char *extra_args)
+QTestState *qtest_init_with_env_and_capabilities(const char *var,
+                                                 const char *extra_args,
+                                                 QList *capabilities)
 {
     QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
     QDict *greeting;
@@ -551,11 +553,23 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args)
     /* Read the QMP greeting and then do the handshake */
     greeting = qtest_qmp_receive(s);
     qobject_unref(greeting);
-    qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
+    if (capabilities) {
+        qtest_qmp_assert_success(s,
+                                 "{ 'execute': 'qmp_capabilities', "
+                                 "'arguments': { 'enable': %p } }",
+                                 qobject_ref(capabilities));
+    } else {
+        qtest_qmp_assert_success(s, "{ 'execute': 'qmp_capabilities' }");
+    }
 
     return s;
 }
 
+QTestState *qtest_init_with_env(const char *var, const char *extra_args)
+{
+    return qtest_init_with_env_and_capabilities(var, extra_args, NULL);
+}
+
 QTestState *qtest_init(const char *extra_args)
 {
     return qtest_init_with_env(NULL, extra_args);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index d771f29d63..8f3bde5d16 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -19,6 +19,7 @@
 
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "libqmp.h"
 
 typedef struct QTestState QTestState;
@@ -68,6 +69,22 @@ QTestState *qtest_init(const char *extra_args);
  */
 QTestState *qtest_init_with_env(const char *var, const char *extra_args);
 
+/**
+ * qtest_init_with_env_and_capabilities:
+ * @var: Environment variable from where to take the QEMU binary
+ * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
+ * arguments are subject to word splitting and shell evaluation.
+ * @capabilities: list of QMP capabilities (strings) to enable
+ *
+ * Like qtest_init_with_env(), but enable specified capabilities during
+ * hadshake.
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_init_with_env_and_capabilities(const char *var,
+                                                 const char *extra_args,
+                                                 QList *capabilities);
+
 /**
  * qtest_init_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
-- 
2.35.3


