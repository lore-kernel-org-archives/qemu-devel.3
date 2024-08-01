Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4509C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV26-0000IP-6w; Thu, 01 Aug 2024 08:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1v-0008UC-8Q
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1t-0000pw-IE
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EB9D21B5F;
 Thu,  1 Aug 2024 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+XOv7Gu4c73ChHrW4LqNQPVbdOmzFxtgzX+S81fCis=;
 b=MwQVdH/TXp+cCX0XwWjosNW7Xe/OjydFjKf64z9MnNfHJjFa1YlTnIA51aI09lHUiWolL4
 7x2o0kFyxznSo+lRp8mZLbtC0CtToAuCfWQK+soY+xVzqDAI7QKwtUJa+HNte29vgZyYhf
 VheSA/eugwdWNFgKMP9JuS3knXNbL2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+XOv7Gu4c73ChHrW4LqNQPVbdOmzFxtgzX+S81fCis=;
 b=VRcf1W/k5x2ezQO8UHrizNOsmdKsR/4TLG68CsfPXI+qfbvJCmjP54+U3MKcL5ih5338Jw
 Go1jhQNQkMkgAnCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="MwQVdH/T";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VRcf1W/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+XOv7Gu4c73ChHrW4LqNQPVbdOmzFxtgzX+S81fCis=;
 b=MwQVdH/TXp+cCX0XwWjosNW7Xe/OjydFjKf64z9MnNfHJjFa1YlTnIA51aI09lHUiWolL4
 7x2o0kFyxznSo+lRp8mZLbtC0CtToAuCfWQK+soY+xVzqDAI7QKwtUJa+HNte29vgZyYhf
 VheSA/eugwdWNFgKMP9JuS3knXNbL2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+XOv7Gu4c73ChHrW4LqNQPVbdOmzFxtgzX+S81fCis=;
 b=VRcf1W/k5x2ezQO8UHrizNOsmdKsR/4TLG68CsfPXI+qfbvJCmjP54+U3MKcL5ih5338Jw
 Go1jhQNQkMkgAnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2546B13946;
 Thu,  1 Aug 2024 12:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gDxXNxaBq2YEYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 12:35:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 10/14] migration/multifd: Don't send ram data during SYNC
Date: Thu,  1 Aug 2024 09:35:12 -0300
Message-Id: <20240801123516.4498-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801123516.4498-1-farosas@suse.de>
References: <20240801123516.4498-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4EB9D21B5F
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Skip saving and loading any ram data in the packet in the case of a
SYNC. This fixes a shortcoming of the current code which requires a
reset of the MultiFDPages_t fields right after the previous
pending_job finishes, otherwise the very next job might be a SYNC and
multifd_send_fill_packet() will put the stale values in the packet.

By not calling multifd_ram_fill_packet(), we can stop resetting
MultiFDPages_t in the multifd core and leave that to the client code.

Actually moving the reset function is not yet done because
pages->num==0 is used by the client code to determine whether the
MultiFDPages_t needs to be flushed. The subsequent patches will
replace that with a generic flag that is not dependent on
MultiFDPages_t.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 7d946e6661..ec6dcb9999 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -456,6 +456,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
     uint64_t packet_num;
+    bool sync_packet = p->flags & MULTIFD_FLAG_SYNC;
 
     memset(packet, 0, p->packet_len);
 
@@ -470,7 +471,9 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
     p->packets_sent++;
 
-    multifd_ram_fill_packet(p);
+    if (!sync_packet) {
+        multifd_ram_fill_packet(p);
+    }
 
     trace_multifd_send_fill(p->id, packet_num,
                             p->flags, p->next_packet_size);
@@ -581,7 +584,9 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->packet_num = be64_to_cpu(packet->packet_num);
     p->packets_recved++;
 
-    ret = multifd_ram_unfill_packet(p, errp);
+    if (!(p->flags & MULTIFD_FLAG_SYNC)) {
+        ret = multifd_ram_unfill_packet(p, errp);
+    }
 
     trace_multifd_recv_unfill(p->id, p->packet_num, p->flags,
                               p->next_packet_size);
@@ -1536,7 +1541,9 @@ static void *multifd_recv_thread(void *opaque)
             flags = p->flags;
             /* recv methods don't know how to handle the SYNC flag */
             p->flags &= ~MULTIFD_FLAG_SYNC;
-            has_data = p->normal_num || p->zero_num;
+            if (!(flags & MULTIFD_FLAG_SYNC)) {
+                has_data = p->normal_num || p->zero_num;
+            }
             qemu_mutex_unlock(&p->mutex);
         } else {
             /*
-- 
2.35.3


