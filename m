Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5603C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWU-0004Qp-Hl; Wed, 29 Jan 2025 11:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW6-0003ie-Cu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:14 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW4-0005O8-Cr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:14 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3CB4221108;
 Wed, 29 Jan 2025 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2tpXGnfhOzltkYPPLz0LOgBKOHJEbh2+/RZC8KdFRc=;
 b=S3OF1BVf/0PxwA5X/xMvb8XWfYSrNn6aBHRxX5/cpyTYKqp6JlK0DYmXTUNXGWVUoQn63q
 s9cw4Yr91Bfr5q6oB/6ljdeVaVh1KM8euCytmMOB5ddwoh4EPIHNP2luwtbbAAJPpiqREG
 hfKABqact4dkvgwMKYym6j1P8aHcbd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2tpXGnfhOzltkYPPLz0LOgBKOHJEbh2+/RZC8KdFRc=;
 b=Zj5uj646a3u3paF+roNxjLNz+GjzBxque3vPlCUXHuRDAQtIY+XIt8mSa5Rc/3cvZh36Nw
 aSAclf0HW2s5XJDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2tpXGnfhOzltkYPPLz0LOgBKOHJEbh2+/RZC8KdFRc=;
 b=S3OF1BVf/0PxwA5X/xMvb8XWfYSrNn6aBHRxX5/cpyTYKqp6JlK0DYmXTUNXGWVUoQn63q
 s9cw4Yr91Bfr5q6oB/6ljdeVaVh1KM8euCytmMOB5ddwoh4EPIHNP2luwtbbAAJPpiqREG
 hfKABqact4dkvgwMKYym6j1P8aHcbd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2tpXGnfhOzltkYPPLz0LOgBKOHJEbh2+/RZC8KdFRc=;
 b=Zj5uj646a3u3paF+roNxjLNz+GjzBxque3vPlCUXHuRDAQtIY+XIt8mSa5Rc/3cvZh36Nw
 aSAclf0HW2s5XJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB942137DB;
 Wed, 29 Jan 2025 16:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EJJhGgFRmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 33/42] migration: Adjust locking in migration_maybe_pause()
Date: Wed, 29 Jan 2025 13:00:50 -0300
Message-Id: <20250129160059.6987-34-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Peter Xu <peterx@redhat.com>

In migration_maybe_pause() QEMU may yield BQL before waiting for a
semaphore.  However it yields the BQL too early, which logically gives it
chance for the main thread to quickly take the BQL and modify the state to
CANCELLING.

To avoid such race condition from happening at all, always update the
migration states within the BQL.  It'll make sure no concurrent
cancellation can ever happen.

With that, IIUC there's chance we can remove the extra parameter in
migration_maybe_pause() to update active state, but that'll be done
separately later.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-9-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 03e3631d5b..4e4bf8ffed 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2828,14 +2828,14 @@ static int migration_maybe_pause(MigrationState *s,
      * wait for the 'pause_sem' semaphore.
      */
     if (s->state != MIGRATION_STATUS_CANCELLING) {
-        bql_unlock();
         migrate_set_state(&s->state, *current_active_state,
                           MIGRATION_STATUS_PRE_SWITCHOVER);
+        bql_unlock();
         qemu_sem_wait(&s->pause_sem);
+        bql_lock();
         migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
                           new_state);
         *current_active_state = new_state;
-        bql_lock();
     }
 
     return s->state == new_state ? 0 : -EINVAL;
-- 
2.35.3


