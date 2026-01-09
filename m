Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3ABD1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBnT-0003Jp-BY; Fri, 09 Jan 2026 07:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnQ-0003Iz-UX
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:40:53 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnP-0007EA-AS
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:40:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A38205BD06;
 Fri,  9 Jan 2026 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsJGFF8VOKFlAUQA5zQYG147+Oe5oJOK9GND8kTEtS0=;
 b=UwwyqNwdvyjyqaqsh55uW4J75Tz5zW4A6ggioz7dh/FV1DgnkfREl0JLSHuV8x11YoHbPJ
 g+ow+IJX0A2GfjWFrsIbCYcuLJNM+OFpyZ07EnTo/OXIP+kr5wfVy7U5c6liqDR4ahRi4J
 WmTOuDtuMieg9/kpn14lWcd8nMtkUzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsJGFF8VOKFlAUQA5zQYG147+Oe5oJOK9GND8kTEtS0=;
 b=dQS8UKWrcZXA2dc6329ztZ/sUZIcbNq1CN2rlV5KeI3J7eonsPj/0luQN3O8VKxAFlqGmF
 fo4VdsTupkAk5KAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UwwyqNwd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dQS8UKWr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsJGFF8VOKFlAUQA5zQYG147+Oe5oJOK9GND8kTEtS0=;
 b=UwwyqNwdvyjyqaqsh55uW4J75Tz5zW4A6ggioz7dh/FV1DgnkfREl0JLSHuV8x11YoHbPJ
 g+ow+IJX0A2GfjWFrsIbCYcuLJNM+OFpyZ07EnTo/OXIP+kr5wfVy7U5c6liqDR4ahRi4J
 WmTOuDtuMieg9/kpn14lWcd8nMtkUzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsJGFF8VOKFlAUQA5zQYG147+Oe5oJOK9GND8kTEtS0=;
 b=dQS8UKWrcZXA2dc6329ztZ/sUZIcbNq1CN2rlV5KeI3J7eonsPj/0luQN3O8VKxAFlqGmF
 fo4VdsTupkAk5KAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5460C3EA63;
 Fri,  9 Jan 2026 12:40:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJQNBVD3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:40:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 01/25] migration: Remove redundant state change
Date: Fri,  9 Jan 2026 09:40:17 -0300
Message-ID: <20260109124043.25019-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A38205BD06
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

If local_err is set, migration_connect_error_propagate() will be
called and that function already has a state transtion from SETUP to
FAILED.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9d1bf5d276..c45393f40e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2326,8 +2326,6 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
         file_start_outgoing_migration(s, &addr->u.file, &local_err);
     } else {
         error_setg(&local_err, "uri is not a valid migration protocol");
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
     }
 
     if (local_err) {
-- 
2.51.0


