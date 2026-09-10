Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645BEC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nJJ-00079P-99; Thu, 10 Sep 2026 18:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lOx-0003vQ-Sf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:30:01 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lOM-00016V-Ab
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:29:12 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C78A021EC8;
 Thu, 10 Sep 2026 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQ9VeugiW+rPuTWWJ01AvhVzMaKeZUhNf2XmHpNRQyQ=;
 b=Jyxpc3qf7+2vN451rIZ1waVTqTmZkZwOvwegpj5WUp278QSAokf5e7vvEIxLSeF020tebw
 Qaqyscj+SBD1JvP0NeBMfY9BkyqPx6cFpqK+gtuIhkAvIk3XHuY/mOlTjlTpcgNVD91q87
 RwqX4FAI/16vWMEagtaHOG9GjslzYNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQ9VeugiW+rPuTWWJ01AvhVzMaKeZUhNf2XmHpNRQyQ=;
 b=gqbzGKBtXKYq8F6X+OyQdbg0C5QJ8gxa6O7wk56+kTb5GY2ez+R8/sgKjkymUtU/wh42q1
 d+tJNaWvkWSsMHAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FEmXpC2B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d5q+UNo1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQ9VeugiW+rPuTWWJ01AvhVzMaKeZUhNf2XmHpNRQyQ=;
 b=FEmXpC2BIqXYKXJ3MlrizlT9jo6IqLOI1A1YCEITUD28ATf/okPjVTpJdi0UIzLfNDs3RD
 ZJJTNwIULvzBs6WyYAhydfCONcvOhRKTriKKQPGvU5Bw/qTesrls0VlRQ0YzGj9JbWuG9G
 wERb7n7DSumAqCUFqnQ81H3aAFAz+as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQ9VeugiW+rPuTWWJ01AvhVzMaKeZUhNf2XmHpNRQyQ=;
 b=d5q+UNo1UiYan0l2x1Y5+xCTRQEMkID8XVye82eBZZeQ2ZNk/aqMLOqLRNge4mcJpUNxGs
 oEMGcRHqPzoe72BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C362E13A5C;
 Thu, 10 Sep 2026 20:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MN3hJGISo2pJPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 20:26:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>
Subject: [PULL 4/7] ahci: Fix leak of IRQState
Date: Thu, 10 Sep 2026 17:25:56 -0300
Message-ID: <20260910202559.916866-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910202559.916866-1-farosas@suse.de>
References: <20260910202559.916866-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C78A021EC8
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,openvz.org:email,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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

ASAN spotted an indirect leak in ahci-test:

Indirect leak of 576 byte(s) in 6 object(s) allocated from:
    #0 0x556112a08ca0 in malloc
    #1 0x7f21591e595d in g_malloc
    #2 0x7f21591ffe38 in g_slice_alloc
    #3 0x7f21591c988d in g_hash_table_new_full
    #4 0x556114d756f1 in object_initialize_with_type ../qom/object.c:506:23
    #5 0x556114d77590 in object_new_with_type ../qom/object.c:706:5
    #6 0x556114d777e8 in object_new ../qom/object.c:722:12
    #7 0x556114d6d2be in qemu_allocate_irq ../hw/core/irq.c:94:25
    #8 0x556114d6d1bc in qemu_extend_irqs ../hw/core/irq.c:82:16
    #9 0x556114d6d329 in qemu_allocate_irqs ../hw/core/irq.c:89:12
    #10 0x5561135da9bd in ahci_realize ../hw/ide/ahci.c:1644:12
    #11 0x55611360156a in pci_ich9_ahci_realize ../hw/ide/ich.c:132:5

Although ahci_realize() frees the return of qemu_allocate_irqs() right
away, the individual IRQStates are still left around.

Issue qemu_free_irq() at ahci_uninit().

Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/ide/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 6b04762c4a..86f6297dc9 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1688,6 +1688,7 @@ void ahci_uninit(AHCIState *s)
             }
             ide_exit(ide_state);
         }
+        qemu_free_irq(ad->port.irq);
         object_unparent(OBJECT(&ad->port));
     }
 
-- 
2.53.0


