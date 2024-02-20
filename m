Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A594C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoL-0002ze-PL; Tue, 20 Feb 2024 17:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoH-0002ta-CJ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:41:58 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoF-0006Hs-Tt
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:41:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9419C22260;
 Tue, 20 Feb 2024 22:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljNgan+cQwv4ebUy2rr4IU4JTiPzo1fDfB243/D86oE=;
 b=aEiOm1l5+mZh3xkcUOYLWGJen/+RNtNKu14CuenE33lYRyRUC6gMF2BL9RrGGnbub5A8yb
 8IMpXtIQ7YNQZTOloFymsLRqkz+MzTuQFLXXCWBzK1buJcAwX1j9d/5XXgUyc3gNcUiYmp
 qFTM7lSw0VKl0mcUDEdxSCbjEI+zpyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljNgan+cQwv4ebUy2rr4IU4JTiPzo1fDfB243/D86oE=;
 b=CTUAPOuXkZ06d/8AQpIgHQPwSjGPuVzjaHlana/2KCdExBHJ79Y8Bpv0w24+YBTpGoOjVj
 m+6TQA5isxLgv1Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljNgan+cQwv4ebUy2rr4IU4JTiPzo1fDfB243/D86oE=;
 b=aEiOm1l5+mZh3xkcUOYLWGJen/+RNtNKu14CuenE33lYRyRUC6gMF2BL9RrGGnbub5A8yb
 8IMpXtIQ7YNQZTOloFymsLRqkz+MzTuQFLXXCWBzK1buJcAwX1j9d/5XXgUyc3gNcUiYmp
 qFTM7lSw0VKl0mcUDEdxSCbjEI+zpyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljNgan+cQwv4ebUy2rr4IU4JTiPzo1fDfB243/D86oE=;
 b=CTUAPOuXkZ06d/8AQpIgHQPwSjGPuVzjaHlana/2KCdExBHJ79Y8Bpv0w24+YBTpGoOjVj
 m+6TQA5isxLgv1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E635A139D0;
 Tue, 20 Feb 2024 22:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mGDIKrAq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:41:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 05/34] migration/multifd: Release recv sem_sync earlier
Date: Tue, 20 Feb 2024 19:41:09 -0300
Message-Id: <20240220224138.24759-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aEiOm1l5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CTUAPOuX
X-Spamd-Result: default: False [1.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.89)[99.54%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9419C22260
X-Spamd-Bar: +
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that multifd_recv_terminate_threads() is called only once, release
the recv side sem_sync earlier like we do for the send side.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index fba00b9e8f..43f0820996 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1104,6 +1104,12 @@ static void multifd_recv_terminate_threads(Error *err)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
+        /*
+         * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
+         * however try to wakeup it without harm in cleanup phase.
+         */
+        qemu_sem_post(&p->sem_sync);
+
         /*
          * We could arrive here for two reasons:
          *  - normal quit, i.e. everything went fine, just finished
@@ -1162,12 +1168,6 @@ void multifd_recv_cleanup(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        /*
-         * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
-         * however try to wakeup it without harm in cleanup phase.
-         */
-        qemu_sem_post(&p->sem_sync);
-
         if (p->thread_created) {
             qemu_thread_join(&p->thread);
         }
-- 
2.35.3


