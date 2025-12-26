Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923D8E8FDB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFEC-0001Nn-EU; Fri, 26 Dec 2025 16:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEA-0001K0-LA
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:02 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFE9-0003mp-5n
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:02 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 516C05BCE1;
 Fri, 26 Dec 2025 21:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8Q2rQICH1az6OWLPGfQWXBH6q1We2SfqSJbry/6fGM=;
 b=pFd6Bya/oGxA/tl6RMzOnVsCv88Xcw2AVKb888rVNJPyZhHDBDXZiqX3r4Ix7oS9qx1V9R
 q7s7G5J5T4xRKDWBGPp1ZJeBuRxrhO7BHAcXAlKPjBwW/cbXkkat4K9/+cL+k6KaQTpiHz
 bwtiabn7hWwVfuvEd59JI2/4Yvs3hNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8Q2rQICH1az6OWLPGfQWXBH6q1We2SfqSJbry/6fGM=;
 b=VPW6IC56CzJucB1B3pTZUiKKHdhLPpLniFQg0SU8xYleTSmhDMqTZQposxZsuFLJ1Xb5e7
 ZA2gicJj8dmiV4DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8Q2rQICH1az6OWLPGfQWXBH6q1We2SfqSJbry/6fGM=;
 b=pFd6Bya/oGxA/tl6RMzOnVsCv88Xcw2AVKb888rVNJPyZhHDBDXZiqX3r4Ix7oS9qx1V9R
 q7s7G5J5T4xRKDWBGPp1ZJeBuRxrhO7BHAcXAlKPjBwW/cbXkkat4K9/+cL+k6KaQTpiHz
 bwtiabn7hWwVfuvEd59JI2/4Yvs3hNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8Q2rQICH1az6OWLPGfQWXBH6q1We2SfqSJbry/6fGM=;
 b=VPW6IC56CzJucB1B3pTZUiKKHdhLPpLniFQg0SU8xYleTSmhDMqTZQposxZsuFLJ1Xb5e7
 ZA2gicJj8dmiV4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46E253EA63;
 Fri, 26 Dec 2025 21:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KCcdAvD7TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:19:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 07/25] migration: Use migrate_mode() to query for
 cpr-transfer
Date: Fri, 26 Dec 2025 18:19:09 -0300
Message-ID: <20251226211930.27565-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.981];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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

cpr_set_incoming_mode() is only called on the target side, so
migrate_mode() on the source side is the same as s->parameters.mode.

Use the function to reduce explicit access to s->parameters, we have
options.c for that.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f2933f7789..4b1afcab24 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2252,7 +2252,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
+    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
         error_setg(errp, "missing 'cpr' migration channel");
         return;
     }
@@ -2277,7 +2277,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      * in which case the target will not listen for the incoming migration
      * connection, so qmp_migrate_finish will fail to connect, and then recover.
      */
-    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
+    if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
         migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
                         QAPI_CLONE(MigrationAddress, addr));
 
-- 
2.51.0


