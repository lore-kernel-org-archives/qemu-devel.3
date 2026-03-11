Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E44103E2E8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RCe-0005Ok-GK; Wed, 11 Mar 2026 17:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCd-0005Oa-3w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCb-000370-Iq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A97095BD30;
 Wed, 11 Mar 2026 21:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pz9KB5gDhWYyKBCIaxcjvFsy3Xq478977CIMj+YESYY=;
 b=NXhEf4dRr8DEwr2g4VJrfr1/AkX/uq1QmuwoG6LPCJ7VpA6OCXv7oYWT5xNKqwxVawEZuV
 41dGm8Te8CyJ2NT/aovIRXFwORsC1ktdvdUHe5FNNdOosLVHm7zy21K1XPdn6BWDcO6sd+
 Qzr+UYjvmOCrEMKRcIgsHcMVUG2rje4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pz9KB5gDhWYyKBCIaxcjvFsy3Xq478977CIMj+YESYY=;
 b=kqFMqsRksNqvWcj8jSWfHB+3Z3M8egkljWptLtJFJJULa0OfqaiQ1uxbpea3GbM17xD/11
 giLtNzCUgCg66HBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pz9KB5gDhWYyKBCIaxcjvFsy3Xq478977CIMj+YESYY=;
 b=NXhEf4dRr8DEwr2g4VJrfr1/AkX/uq1QmuwoG6LPCJ7VpA6OCXv7oYWT5xNKqwxVawEZuV
 41dGm8Te8CyJ2NT/aovIRXFwORsC1ktdvdUHe5FNNdOosLVHm7zy21K1XPdn6BWDcO6sd+
 Qzr+UYjvmOCrEMKRcIgsHcMVUG2rje4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pz9KB5gDhWYyKBCIaxcjvFsy3Xq478977CIMj+YESYY=;
 b=kqFMqsRksNqvWcj8jSWfHB+3Z3M8egkljWptLtJFJJULa0OfqaiQ1uxbpea3GbM17xD/11
 giLtNzCUgCg66HBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1557F3FC1B;
 Wed, 11 Mar 2026 21:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8B37MuPfsWngUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 21:34:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 3/5] tests/qtest/migration: Fix leak in CPR exec test
Date: Wed, 11 Mar 2026 18:34:16 -0300
Message-ID: <20260311213418.16951-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311213418.16951-1-farosas@suse.de>
References: <20260311213418.16951-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fedoraproject.org:email,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[9];
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

The string was being dup'ed only to get around the const of the
qdict_get_str() return value.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0d97b5b89f..63ca5f3996 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -154,15 +154,16 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
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


