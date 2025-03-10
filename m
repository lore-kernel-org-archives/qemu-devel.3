Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268A2C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 22:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trliU-0004Bd-Vv; Mon, 10 Mar 2025 18:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1trliF-0003vN-En
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:35:07 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1trliD-0001jI-Kl
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:35:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14F551F388;
 Mon, 10 Mar 2025 22:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741646090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0wrgi6pxrkmOfIx5ZgU7+DOtdeSiALIzxKjJwUR95Y=;
 b=Zwgu5gfx9SjWVnsJxwugC90T4P5BraR3/US/osn9MKmbmkEEzZEtKDtbHjRfOA6hNBpAnI
 80s7u33aQaJ1WKZOl+7z1JEFui7jOM3bulPtu7FUbZzWg6Bg5DaqrauaCmFWtBUcL+HZoj
 o5TZVja4UZaSDsNbdQCBkfUH3vuBuIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741646090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0wrgi6pxrkmOfIx5ZgU7+DOtdeSiALIzxKjJwUR95Y=;
 b=jw+nQg1iXVLc6dvX+twKa97S+9G8hbZ4V3KDqRnE4D+bwLYLXFDryijZF/w533JlHFGcn1
 hQNYpk9/D5mYI0Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zwgu5gfx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jw+nQg1i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741646090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0wrgi6pxrkmOfIx5ZgU7+DOtdeSiALIzxKjJwUR95Y=;
 b=Zwgu5gfx9SjWVnsJxwugC90T4P5BraR3/US/osn9MKmbmkEEzZEtKDtbHjRfOA6hNBpAnI
 80s7u33aQaJ1WKZOl+7z1JEFui7jOM3bulPtu7FUbZzWg6Bg5DaqrauaCmFWtBUcL+HZoj
 o5TZVja4UZaSDsNbdQCBkfUH3vuBuIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741646090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0wrgi6pxrkmOfIx5ZgU7+DOtdeSiALIzxKjJwUR95Y=;
 b=jw+nQg1iXVLc6dvX+twKa97S+9G8hbZ4V3KDqRnE4D+bwLYLXFDryijZF/w533JlHFGcn1
 hQNYpk9/D5mYI0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B60B21399F;
 Mon, 10 Mar 2025 22:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OrLHAhpz2dzRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Mar 2025 22:34:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL v2 3/3] migration: Prioritize RDMA in ram_save_target_page()
Date: Mon, 10 Mar 2025 19:34:40 -0300
Message-Id: <20250310223440.31328-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250310223440.31328-1-farosas@suse.de>
References: <20250310223440.31328-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 14F551F388
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

From: Li Zhijian <lizhijian@fujitsu.com>

Address an error in RDMA-based migration by ensuring RDMA is prioritized
when saving pages in `ram_save_target_page()`.

Previously, the RDMA protocol's page-saving step was placed after other
protocols due to a refactoring in commit bc38dc2f5f3. This led to migration
failures characterized by unknown control messages and state loading errors
destination:
(qemu) qemu-system-x86_64: Unknown control message QEMU FILE
qemu-system-x86_64: error while loading state section id 1(ram)
qemu-system-x86_64: load of migration failed: Operation not permitted
source:
(qemu) qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
qemu-system-x86_64: failed to save SaveStateEntry with id(name): 1(ram): -1
qemu-system-x86_64: rdma migration: recv polling control error!
qemu-system-x86_64: warning: Early error. Sending error.
qemu-system-x86_64: warning: rdma migration: send polling control error

RDMA migration implemented its own protocol/method to send pages to
destination side, hand over to RDMA first to prevent pages being saved by
other protocol.

Fixes: bc38dc2f5f3 ("migration: refactor ram_save_target_page functions")
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-2-lizhijian@fujitsu.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 589b6505eb..424df6d9f1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1964,6 +1964,11 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
+    /* Hand over to RDMA first */
+    if (control_save_page(pss, offset, &res)) {
+        return res;
+    }
+
     if (!migrate_multifd()
         || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
         if (save_zero_page(rs, pss, offset)) {
@@ -1976,10 +1981,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
         return ram_save_multifd_page(block, offset);
     }
 
-    if (control_save_page(pss, offset, &res)) {
-        return res;
-    }
-
     return ram_save_page(rs, pss);
 }
 
-- 
2.35.3


