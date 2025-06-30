Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C695C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKgX-0005mX-9C; Mon, 30 Jun 2025 16:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKgF-00059p-Br
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKgD-0007mk-IM
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 810D021161;
 Mon, 30 Jun 2025 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMnsDqpS7mN5ekbzq6rLUj1Jtd21FawuezqRU1AIOxE=;
 b=SOyg5eilBG96Xgweic7QpojL5RNpbLiDFTv2YpjnoxsXcYhXWbsXCx7hy9Bc3UbcnWyFgQ
 9H0lBS6SxaQMlKXuZAbRJzKjUCYEIzIuZFwIr3ii2ENN+sv1fu2KKz/7xmN1CQ/R5pTcej
 nHfItiG8i8OCuYztIR4T5J64RZlORVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMnsDqpS7mN5ekbzq6rLUj1Jtd21FawuezqRU1AIOxE=;
 b=u4T9Up066SayiMCh1tGi/xzVTuJpAhXlkANSFlRrZkkJIEGUtMas/56r7hC0wJUYrSG04+
 Rv2XZ2Wy7KlkJJCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMnsDqpS7mN5ekbzq6rLUj1Jtd21FawuezqRU1AIOxE=;
 b=SOyg5eilBG96Xgweic7QpojL5RNpbLiDFTv2YpjnoxsXcYhXWbsXCx7hy9Bc3UbcnWyFgQ
 9H0lBS6SxaQMlKXuZAbRJzKjUCYEIzIuZFwIr3ii2ENN+sv1fu2KKz/7xmN1CQ/R5pTcej
 nHfItiG8i8OCuYztIR4T5J64RZlORVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMnsDqpS7mN5ekbzq6rLUj1Jtd21FawuezqRU1AIOxE=;
 b=u4T9Up066SayiMCh1tGi/xzVTuJpAhXlkANSFlRrZkkJIEGUtMas/56r7hC0wJUYrSG04+
 Rv2XZ2Wy7KlkJJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71F791399F;
 Mon, 30 Jun 2025 20:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KG35DMLsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 20:00:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 21/24] tests/qtest/migration: Take reference when passing
 %p to qtest_qmp
Date: Mon, 30 Jun 2025 16:59:10 -0300
Message-Id: <20250630195913.28033-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

The documentation of qobject_from_jsonv() states that it takes
ownership of any %p arguments passed in.

Next patches will add config-passing to the tests, so take an extra
reference in the migrate_qmp* functions to ensure the config is not
freed from under us.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-qmp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index fb59741b2c..d82ac8c750 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -97,7 +97,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
     }
 
     err = qtest_qmp_assert_failure_ref(
-        who, "{ 'execute': 'migrate', 'arguments': %p}", args);
+        who, "{ 'execute': 'migrate', 'arguments': %p}",
+        qdict_clone_shallow(args));
 
     g_assert(qdict_haskey(err, "desc"));
 
@@ -136,7 +137,8 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     }
 
     qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate', 'arguments': %p}", args);
+                             "{ 'execute': 'migrate', 'arguments': %p}",
+                             qdict_clone_shallow(args));
 }
 
 void migrate_set_capability(QTestState *who, const char *capability,
@@ -174,7 +176,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
     migrate_set_capability(to, "events", true);
 
     rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
-                    args);
+                    qdict_clone_shallow(args));
 
     if (!qdict_haskey(rsp, "return")) {
         g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
-- 
2.35.3


