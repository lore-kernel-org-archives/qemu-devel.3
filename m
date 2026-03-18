Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A848E10775E6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2u1u-0007PG-VT; Wed, 18 Mar 2026 12:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pfalcato@suse.de>) id 1w2tmU-0004RT-CO
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 12:30:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pfalcato@suse.de>) id 1w2tmS-000063-BC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 12:30:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16B745BECB;
 Wed, 18 Mar 2026 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773851395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MLQF0cGJStof3nDqoSS/VGYCR2qfVs2/I0b7oZR7/2w=;
 b=Fc/dYUZF/69DEuHAyWGb8Z4rtQWRV26oKGti+wxNoXQ8Owy8TGAyA6S6YosCSv3n5QjE2h
 Pp4K6e2KbXcYQr0H/rt9SVmOdDLs1pzGM6EgJ10PMn7O4BTc3Xi7udnXNhOGVnx+dIAEa6
 1sWUg2gmj1fIStIjZkTSwX3NPrKDdOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773851395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MLQF0cGJStof3nDqoSS/VGYCR2qfVs2/I0b7oZR7/2w=;
 b=fzgKsO3yxsEu93eTb7jwGilpBEzoMBvTEw/i+Nq/DfBvQeohrkS1J2hYFqZciyeIY76q+Y
 kjhcC4lyaS0QkOAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773851395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MLQF0cGJStof3nDqoSS/VGYCR2qfVs2/I0b7oZR7/2w=;
 b=Fc/dYUZF/69DEuHAyWGb8Z4rtQWRV26oKGti+wxNoXQ8Owy8TGAyA6S6YosCSv3n5QjE2h
 Pp4K6e2KbXcYQr0H/rt9SVmOdDLs1pzGM6EgJ10PMn7O4BTc3Xi7udnXNhOGVnx+dIAEa6
 1sWUg2gmj1fIStIjZkTSwX3NPrKDdOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773851395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MLQF0cGJStof3nDqoSS/VGYCR2qfVs2/I0b7oZR7/2w=;
 b=fzgKsO3yxsEu93eTb7jwGilpBEzoMBvTEw/i+Nq/DfBvQeohrkS1J2hYFqZciyeIY76q+Y
 kjhcC4lyaS0QkOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 912D24273B;
 Wed, 18 Mar 2026 16:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mOoPIALTumnJYwAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Wed, 18 Mar 2026 16:29:54 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Pedro Falcato <pfalcato@suse.de>, qemu-stable@nongnu.org,
 Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ide: Set IDENTIFY word 93 to 0 on SATA drives
Date: Wed, 18 Mar 2026 16:29:51 +0000
Message-ID: <20260318162951.1060969-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=pfalcato@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Mar 2026 12:45:56 -0400
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

According to the ATA Command Set specification (and the SATA specification
too), SATA drives are supposed to set word 93 (which for PATA holds hardware
reset results) to 0. As such, clear it when ncq_queues > 0 (which is only true
for SATA drives).

Doing so fixes a quirk in Linux where it thinks the AHCI QEMU drive is PATA
over a SATA bridge, and thus limits maximum transfer sizes for individual IOs
with a:
[    1.632121] ata1.00: applying bridge limits

While at it, bump the device's firmware revision for IDENTIFY. This makes it
so Linux can avoid enabling a quirk for fixed QEMU releases.

Link: https://lore.kernel.org/linux-ide/20260303183337.1013474-1-pfalcato@suse.de/
Cc: qemu-stable@nongnu.org
Suggsted-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
Note: I understand the version bump is vaguely controversial (particularly
 exposing the QEMU version in the string) but I don't have a much better
 idea. Logically, bumping it to 11.0 for stable releases doesn't make much
 sense.
 
 hw/ide/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index b45abf067b20..89f62f301e94 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -211,7 +211,15 @@ static void ide_identify(IDEState *s)
         put_le16(p + 87, (1 << 14) | 0);
     }
     put_le16(p + 88, 0x3f | (1 << 13)); /* udma5 set and supported */
-    put_le16(p + 93, 1 | (1 << 14) | 0x2000);
+    if (s->ncq_queues) {
+        /*
+         * This is SATA, which is required by the spec to return 0 for this
+         * field.
+         */
+        put_le16(p + 93, 0);
+    } else {
+        put_le16(p + 93, 1 | (1 << 14) | 0x2000);
+    }
     /* *(p + 100) := nb_sectors       -- see ide_identify_size */
     /* *(p + 101) := nb_sectors >> 16 -- see ide_identify_size */
     /* *(p + 102) := nb_sectors >> 32 -- see ide_identify_size */
@@ -2660,7 +2668,7 @@ int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp)
     if (dev->version) {
         pstrcpy(s->version, sizeof(s->version), dev->version);
     } else {
-        pstrcpy(s->version, sizeof(s->version), qemu_hw_version());
+        pstrcpy(s->version, sizeof(s->version), "11.0");
     }
 
     ide_reset(s);
-- 
2.53.0


