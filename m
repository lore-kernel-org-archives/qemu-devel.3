Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E886FEDA03
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z5M-0004Z4-6r; Tue, 17 Mar 2026 14:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z5J-0004U9-JK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:24:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z5G-00037E-54
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:24:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C287F4D3BC;
 Tue, 17 Mar 2026 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zP8ZJ3QpNGvxRsk4L1xTZiyzIagnWWTaRBbLo+IETtY=;
 b=rb8lHVnWDaBMVnC6Vcd3SnvZMwBXpPAg0yUoGVvmC2pdGx0TfW31/3loogG/uQARVoBNsD
 5Qk7yjgYwocTaXCMwrmD5Wjj6KTpt45SBFPCDHyERfnzRvPC7zh8GSsQiPzvuxmgKrYSEM
 OPej+dDTBdZNHMH7JE7AyczRecC9kmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zP8ZJ3QpNGvxRsk4L1xTZiyzIagnWWTaRBbLo+IETtY=;
 b=dxd0iau8L8PvSyrc3h2PXg78isEU3opRZedeZ3G8ykqihAcsLReUCKqFZd0+LNQ4IddN7u
 mkap20/0TC82HmAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zP8ZJ3QpNGvxRsk4L1xTZiyzIagnWWTaRBbLo+IETtY=;
 b=rb8lHVnWDaBMVnC6Vcd3SnvZMwBXpPAg0yUoGVvmC2pdGx0TfW31/3loogG/uQARVoBNsD
 5Qk7yjgYwocTaXCMwrmD5Wjj6KTpt45SBFPCDHyERfnzRvPC7zh8GSsQiPzvuxmgKrYSEM
 OPej+dDTBdZNHMH7JE7AyczRecC9kmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zP8ZJ3QpNGvxRsk4L1xTZiyzIagnWWTaRBbLo+IETtY=;
 b=dxd0iau8L8PvSyrc3h2PXg78isEU3opRZedeZ3G8ykqihAcsLReUCKqFZd0+LNQ4IddN7u
 mkap20/0TC82HmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D67E4273B;
 Tue, 17 Mar 2026 18:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJgsOSOcuWnXdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Mar 2026 18:23:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 06/10] migration: assert that the same migration handler is not
 being added twice
Date: Tue, 17 Mar 2026 15:23:16 -0300
Message-ID: <20260317182320.31991-7-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317182320.31991-1-farosas@suse.de>
References: <20260317182320.31991-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Ani Sinha <anisinha@redhat.com>

Currently the code that adds a migration blocker does not check if the same
blocker already exists. Assert that the migration handler being added has
not been added already.

CC: Markus Armbruster <armbru@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260311070114.164434-1-anisinha@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index c77832f851..7feeba804f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1699,6 +1699,8 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
+            assert(g_slist_index(migration_blockers[mode],
+                                 *reasonp) == -1);
             migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
                                                        *reasonp);
         }
-- 
2.51.0


