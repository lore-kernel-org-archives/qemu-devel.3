Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0978BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44nj-0001wq-Lf; Wed, 01 Oct 2025 17:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44nR-0001p0-Rh
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:55:42 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44mz-0006C0-GG
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:55:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B76833773;
 Wed,  1 Oct 2025 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdTuOYpkm1F8Joh6I2XE/u3MBbP+kNvzRGqOQSgAM3Y=;
 b=KyRfaelWmOAfcfVx9XjP161WnKRUOrq2SMS0zxDDv+k9vwvj7M3xMbzmlSDhDaLWCJY8xv
 45dBpXNpKtxgE2Olrt4klGqRAzyPNL3gcSDGzqzM9y5Eu4IJyjl1GivU76Jpz1Th1ab5Gi
 W8MMi9pcm5Y+M3YbcCxGmfF5qW4GPDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdTuOYpkm1F8Joh6I2XE/u3MBbP+kNvzRGqOQSgAM3Y=;
 b=YaC3DcsfNn24tcQWrpR+5p8+dG6L/We2re81koJhHn++IxoLb+y1RDTRUkBvBWXdb4PVYw
 JIOSfbc4T+vHw4Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KyRfaelW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YaC3Dcsf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdTuOYpkm1F8Joh6I2XE/u3MBbP+kNvzRGqOQSgAM3Y=;
 b=KyRfaelWmOAfcfVx9XjP161WnKRUOrq2SMS0zxDDv+k9vwvj7M3xMbzmlSDhDaLWCJY8xv
 45dBpXNpKtxgE2Olrt4klGqRAzyPNL3gcSDGzqzM9y5Eu4IJyjl1GivU76Jpz1Th1ab5Gi
 W8MMi9pcm5Y+M3YbcCxGmfF5qW4GPDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdTuOYpkm1F8Joh6I2XE/u3MBbP+kNvzRGqOQSgAM3Y=;
 b=YaC3DcsfNn24tcQWrpR+5p8+dG6L/We2re81koJhHn++IxoLb+y1RDTRUkBvBWXdb4PVYw
 JIOSfbc4T+vHw4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36A4F13A3F;
 Wed,  1 Oct 2025 21:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kMdkOb2i3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 03/13] tests/qtest: optimize qtest_get_machines
Date: Wed,  1 Oct 2025 18:52:44 -0300
Message-Id: <20251001215254.2863-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B76833773
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

qtest_get_machines returns the machines supported by the QEMU binary
described by an environment variable and caches the result.  If the
next call to qtest_get_machines passes the same variable name, the cached
result is returned, but if the name changes, the caching is defeated.
To make caching more effective, remember the path of the QEMU binary
instead.  Different env vars, eg QTEST_QEMU_BINARY_SRC and
QTEST_QEMU_BINARY_DST, usually resolve to the same path.

Before the optimization, the test /x86_64/migration/precopy/unix/plain
exec's QEMU and calls query-machines 3 times.  After optimization, that
only happens once.  This does not significantly speed up the tests, but
it reduces QTEST_LOG output, and launches fewer QEMU instances, making
it easier to debug problems.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <87h5ymdzrf.fsf@pond.sub.org>
Link: https://lore.kernel.org/qemu-devel/1758290310-349623-1-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 94526b7f9c..f3d4e0829a 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1630,7 +1630,8 @@ static void qtest_free_machine_list(struct MachInfo *machines)
 static struct MachInfo *qtest_get_machines(const char *var)
 {
     static struct MachInfo *machines;
-    static char *qemu_var;
+    static char *qemu_bin;
+    const char *new_qemu_bin;
     QDict *response, *minfo;
     QList *list;
     const QListEntry *p;
@@ -1639,9 +1640,10 @@ static struct MachInfo *qtest_get_machines(const char *var)
     QTestState *qts;
     int idx;
 
-    if (g_strcmp0(qemu_var, var)) {
-        g_free(qemu_var);
-        qemu_var = g_strdup(var);
+    new_qemu_bin = qtest_qemu_binary(var);
+    if (g_strcmp0(qemu_bin, new_qemu_bin)) {
+        g_free(qemu_bin);
+        qemu_bin = g_strdup(new_qemu_bin);
 
         /* new qemu, clear the cache */
         qtest_free_machine_list(machines);
@@ -1654,7 +1656,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_ext(qemu_var, "-machine none", NULL, true);
+    qts = qtest_init_ext(var, "-machine none", NULL, true);
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
-- 
2.35.3


