Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6681BE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM86k-00079D-Vh; Fri, 13 Dec 2024 11:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tM86f-00078O-KP; Fri, 13 Dec 2024 11:01:33 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tM86d-0005A3-U7; Fri, 13 Dec 2024 11:01:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41B8A1F78D;
 Fri, 13 Dec 2024 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734105686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwiVLOerfW9Cfdhb0cJ1TgrGYEBCJdwy+qViOmssyjE=;
 b=MODssFVxMiVGGt+NSFlwqNmATOrhFAUeQ4O1h301kbaOI3vCHN0AEFo/M7sJZYlnZ9/fy6
 HgVwPdZ5jAtZFo/pBrU7gbe9ieSLpCjzHLCtukzKGkbWBJY190A2ivJa102TrHw/PCtaW9
 nrAI+WTLNbRqUVwbS8PNos2ONzQ3AXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734105686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwiVLOerfW9Cfdhb0cJ1TgrGYEBCJdwy+qViOmssyjE=;
 b=ZfnKYQCbnW2y0iAgiNvGg4lkJ1Z4+8tj1uJ2VA0gFnwur+0Ml6zRzxk7ZZ6U+reou5S/19
 nEAbV6Sf29pqiKAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MODssFVx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZfnKYQCb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734105686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwiVLOerfW9Cfdhb0cJ1TgrGYEBCJdwy+qViOmssyjE=;
 b=MODssFVxMiVGGt+NSFlwqNmATOrhFAUeQ4O1h301kbaOI3vCHN0AEFo/M7sJZYlnZ9/fy6
 HgVwPdZ5jAtZFo/pBrU7gbe9ieSLpCjzHLCtukzKGkbWBJY190A2ivJa102TrHw/PCtaW9
 nrAI+WTLNbRqUVwbS8PNos2ONzQ3AXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734105686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwiVLOerfW9Cfdhb0cJ1TgrGYEBCJdwy+qViOmssyjE=;
 b=ZfnKYQCbnW2y0iAgiNvGg4lkJ1Z4+8tj1uJ2VA0gFnwur+0Ml6zRzxk7ZZ6U+reou5S/19
 nEAbV6Sf29pqiKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DBC6137CF;
 Fri, 13 Dec 2024 16:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mCdvMFRaXGc9QwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Dec 2024 16:01:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	qemu-stable@nongnu.org
Subject: [PATCH 1/2] migration/multifd: Fix compat with QEMU < 9.0
Date: Fri, 13 Dec 2024 13:01:19 -0300
Message-Id: <20241213160120.23880-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241213160120.23880-1-farosas@suse.de>
References: <20241213160120.23880-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41B8A1F78D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Commit f5f48a7891 ("migration/multifd: Separate SYNC request with
normal jobs") changed the multifd source side to stop sending data
along with the MULTIFD_FLAG_SYNC, effectively introducing the concept
of a SYNC-only packet. Relying on that, commit d7e58f412c
("migration/multifd: Don't send ram data during SYNC") later came
along and skipped reading data from SYNC packets.

In a versions timeline like this:

  8.2 f5f48a7 9.0 9.1 d7e58f41 9.2

The issue arises that QEMUs < 9.0 still send data along with SYNC, but
QEMUs > 9.1 don't gather that data anymore. This leads to various
kinds of migration failures due to desync/missing data.

Stop checking for a SYNC packet on the destination and unconditionally
unfill the packet.

From now on:

old -> new:
the source sends data + sync, destination reads normally

new -> new:
source sends only sync, destination reads zeros

new -> old:
source sends only sync, destination reads zeros

CC: qemu-stable@nongnu.org
Fixes: d7e58f412c ("migration/multifd: Don't send ram data during SYNC")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2720
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 498e71fd10..8d0a763a72 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -252,9 +252,8 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
 
-    if (!(p->flags & MULTIFD_FLAG_SYNC)) {
-        ret = multifd_ram_unfill_packet(p, errp);
-    }
+    /* Always unfill, old QEMUs (<9.0) send data along with SYNC */
+    ret = multifd_ram_unfill_packet(p, errp);
 
     trace_multifd_recv_unfill(p->id, p->packet_num, p->flags,
                               p->next_packet_size);
@@ -1151,9 +1150,13 @@ static void *multifd_recv_thread(void *opaque)
             flags = p->flags;
             /* recv methods don't know how to handle the SYNC flag */
             p->flags &= ~MULTIFD_FLAG_SYNC;
-            if (!(flags & MULTIFD_FLAG_SYNC)) {
-                has_data = p->normal_num || p->zero_num;
-            }
+
+            /*
+             * Even if it's a SYNC packet, this needs to be set
+             * because older QEMUs (<9.0) still send data along with
+             * the SYNC packet.
+             */
+            has_data = p->normal_num || p->zero_num;
             qemu_mutex_unlock(&p->mutex);
         } else {
             /*
-- 
2.35.3


