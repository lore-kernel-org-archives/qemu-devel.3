Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AA9FD2D9B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxZE-0004St-R1; Tue, 10 Mar 2026 09:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxZC-0004SZ-V3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:56:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxZB-0007X1-Im
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:56:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D184C5BD03;
 Tue, 10 Mar 2026 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+klaHRezzor2BJOwktV5mxehOv++t5XOPvAMZAYwXc=;
 b=WWmU5mI+N8SRcz0BUVjMGUmIbWCjMLhZSEOJWLYOKChYvI+mOga0GQKfchPQ6kBKTBwX8/
 LJYIS3Po0YquZroNb9DokPOMUHhV/93meRtEFJxKKYiY9I6kuWK8wO1la/bs6NEqDJ9wXn
 CbK1tFNXiAL5s0Ez+8sF361XfIGvtLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+klaHRezzor2BJOwktV5mxehOv++t5XOPvAMZAYwXc=;
 b=H487/fAOZO0SEiixywr3FFcjYjvL5zm0iIaFxU7n5NU4ckhmQfibjRcElxd03NHaxdsO92
 sZ56LgzSrk4iUABQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WWmU5mI+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="H487/fAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+klaHRezzor2BJOwktV5mxehOv++t5XOPvAMZAYwXc=;
 b=WWmU5mI+N8SRcz0BUVjMGUmIbWCjMLhZSEOJWLYOKChYvI+mOga0GQKfchPQ6kBKTBwX8/
 LJYIS3Po0YquZroNb9DokPOMUHhV/93meRtEFJxKKYiY9I6kuWK8wO1la/bs6NEqDJ9wXn
 CbK1tFNXiAL5s0Ez+8sF361XfIGvtLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+klaHRezzor2BJOwktV5mxehOv++t5XOPvAMZAYwXc=;
 b=H487/fAOZO0SEiixywr3FFcjYjvL5zm0iIaFxU7n5NU4ckhmQfibjRcElxd03NHaxdsO92
 sZ56LgzSrk4iUABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFA563F4B3;
 Tue, 10 Mar 2026 13:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aL80IewisGnFcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 13:55:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 7/8] tests/qtest/migration: Fix leak in CPR exec test
Date: Tue, 10 Mar 2026 10:55:39 -0300
Message-ID: <20260310135540.8679-7-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310135540.8679-1-farosas@suse.de>
References: <20260310135540.8679-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D184C5BD03
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The string was being dup'ed only to get around the const of the
qdict_get_str() return value.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 1b3d42e51c..fabdec4ff3 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -161,15 +161,16 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
 static void wait_for_migration_event(QTestState *who, const char *waitfor)
 {
     QDict *rsp, *data;
-    char *status;
     bool done = false;
 
     while (!done) {
+        const char *status;
+
         rsp = qtest_qmp_eventwait_ref(who, "MIGRATION");
         g_assert(qdict_haskey(rsp, "data"));
         data = qdict_get_qdict(rsp, "data");
         g_assert(qdict_haskey(data, "status"));
-        status = g_strdup(qdict_get_str(data, "status"));
+        status = qdict_get_str(data, "status");
         g_assert(strcmp(status, "failed"));
         done = !strcmp(status, waitfor);
         qobject_unref(rsp);
-- 
2.51.0


