Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07CCC5472E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 19:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sifmh-0007UH-A7; Mon, 26 Aug 2024 15:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmf-0007Ov-Uk
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:53:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifme-0002EX-B4
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:53:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F0151F8AE;
 Mon, 26 Aug 2024 19:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZzH6tbwU1tnRJepeYyskBXA12nUW4vAOqU+UVM33TM=;
 b=NnbWdDE+cHVnfrXRe1xQqqVRAEPssb4682c7+N4ChE0OjOLJI/rHH7zhRJcn7vQ9CJk8HW
 cE3zSATTTM+6zvluqWMGIFz+5PDr5ja9vW9ZbTdDncIkTENT2OwGlG+8TdY5d7udw75iai
 cE9EHK/w70TN+Bc81VTEItrfCWsXcos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZzH6tbwU1tnRJepeYyskBXA12nUW4vAOqU+UVM33TM=;
 b=8CkWJnqL0DuwO5ZCdMHNA/8MKmIoGQ41LL2Y3VwAcm30XCvhrl/EJuBw9L+hfHOKdI3dn6
 kryyELpNH61VCGAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NnbWdDE+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8CkWJnqL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZzH6tbwU1tnRJepeYyskBXA12nUW4vAOqU+UVM33TM=;
 b=NnbWdDE+cHVnfrXRe1xQqqVRAEPssb4682c7+N4ChE0OjOLJI/rHH7zhRJcn7vQ9CJk8HW
 cE3zSATTTM+6zvluqWMGIFz+5PDr5ja9vW9ZbTdDncIkTENT2OwGlG+8TdY5d7udw75iai
 cE9EHK/w70TN+Bc81VTEItrfCWsXcos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZzH6tbwU1tnRJepeYyskBXA12nUW4vAOqU+UVM33TM=;
 b=8CkWJnqL0DuwO5ZCdMHNA/8MKmIoGQ41LL2Y3VwAcm30XCvhrl/EJuBw9L+hfHOKdI3dn6
 kryyELpNH61VCGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EFC31398D;
 Mon, 26 Aug 2024 19:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KMtIGUndzGY5PQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Aug 2024 19:53:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 11/18] migration/multifd: Don't send ram data during SYNC
Date: Mon, 26 Aug 2024 16:53:15 -0300
Message-Id: <20240826195322.16532-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240826195322.16532-1-farosas@suse.de>
References: <20240826195322.16532-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F0151F8AE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d64fcdf4ac..3a164c124d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -452,6 +452,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
     uint64_t packet_num;
+    bool sync_packet = p->flags & MULTIFD_FLAG_SYNC;
 
     memset(packet, 0, p->packet_len);
 
@@ -466,7 +467,9 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
     p->packets_sent++;
 
-    multifd_ram_fill_packet(p);
+    if (!sync_packet) {
+        multifd_ram_fill_packet(p);
+    }
 
     trace_multifd_send_fill(p->id, packet_num,
                             p->flags, p->next_packet_size);
@@ -574,7 +577,9 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
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


