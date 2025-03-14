Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00051C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6LM-0003yi-I1; Fri, 14 Mar 2025 10:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tt6LK-0003yC-IY
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:48:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tt6LI-0001nl-Ic
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:48:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A7FD1F453;
 Fri, 14 Mar 2025 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741963717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y17d/mTD60kA1nAKDtMTFIqWkNzLBmZZTvec22zZvys=;
 b=IcBwVrVQxMk2LV+mjXlpc18aq+5+Zp6Ba6jkaa8xHvy7dGfgHLw+VWc7TvlBre1zZcwp6F
 xMxoSWXyg06obO/OaJoZ2BomITEipgG/5Jv4hA4ty666tPXX6BnRSQwU3pArK8V7mi5M7H
 TmekhuK0zNQqAKdT1C3L9tb6FKQJkac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741963717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y17d/mTD60kA1nAKDtMTFIqWkNzLBmZZTvec22zZvys=;
 b=gHmplMjgTZZXe/i2PnJ000z7C+P7KLS097K9yK+YMPU7Gp2m8/NLIBrviO+MqMCsgd4FGl
 nCJ+uB6/3dIzWPDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IcBwVrVQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gHmplMjg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741963717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y17d/mTD60kA1nAKDtMTFIqWkNzLBmZZTvec22zZvys=;
 b=IcBwVrVQxMk2LV+mjXlpc18aq+5+Zp6Ba6jkaa8xHvy7dGfgHLw+VWc7TvlBre1zZcwp6F
 xMxoSWXyg06obO/OaJoZ2BomITEipgG/5Jv4hA4ty666tPXX6BnRSQwU3pArK8V7mi5M7H
 TmekhuK0zNQqAKdT1C3L9tb6FKQJkac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741963717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y17d/mTD60kA1nAKDtMTFIqWkNzLBmZZTvec22zZvys=;
 b=gHmplMjgTZZXe/i2PnJ000z7C+P7KLS097K9yK+YMPU7Gp2m8/NLIBrviO+MqMCsgd4FGl
 nCJ+uB6/3dIzWPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7144132DD;
 Fri, 14 Mar 2025 14:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WMN3JsNB1GeVPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Mar 2025 14:48:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 andrey.drobyshev@virtuozzo.com
Subject: [PULL 4/4] hw/qxl: fix cpr
Date: Fri, 14 Mar 2025 11:48:24 -0300
Message-Id: <20250314144824.1707-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250314144824.1707-1-farosas@suse.de>
References: <20250314144824.1707-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A7FD1F453
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

During normal migration, new QEMU creates and initializes memory regions,
then loads the preserved contents of the region from vmstate.

During CPR, memory regions are preserved in place, then the realize
method initializes the regions contents, losing the old contents.  To
fix, skip writes to the qxl memory regions during CPR load.

Reported-by: andrey.drobyshev@virtuozzo.com
Tested-by: andrey.drobyshev@virtuozzo.com
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <1741380954-341079-5-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/display/qxl.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 2efdc77e61..da14da5209 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -30,6 +30,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "system/runstate.h"
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
@@ -333,6 +334,10 @@ static void init_qxl_rom(PCIQXLDevice *d)
     uint32_t fb;
     int i, n;
 
+    if (cpr_is_incoming()) {
+        goto skip_init;
+    }
+
     memset(rom, 0, d->rom_size);
 
     rom->magic         = cpu_to_le32(QXL_ROM_MAGIC);
@@ -390,6 +395,7 @@ static void init_qxl_rom(PCIQXLDevice *d)
             sizeof(rom->client_monitors_config));
     }
 
+skip_init:
     d->shadow_rom = *rom;
     d->rom        = rom;
     d->modes      = modes;
@@ -403,6 +409,9 @@ static void init_qxl_ram(PCIQXLDevice *d)
 
     buf = d->vga.vram_ptr;
     d->ram = (QXLRam *)(buf + le32_to_cpu(d->shadow_rom.ram_header_offset));
+    if (cpr_is_incoming()) {
+        return;
+    }
     d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
     d->ram->int_pending = cpu_to_le32(0);
     d->ram->int_mask    = cpu_to_le32(0);
@@ -539,6 +548,10 @@ static void interface_set_compression_level(QXLInstance *sin, int level)
 
     trace_qxl_interface_set_compression_level(qxl->id, level);
     qxl->shadow_rom.compression_level = cpu_to_le32(level);
+    if (cpr_is_incoming()) {
+        assert(qxl->rom->compression_level == cpu_to_le32(level));
+        return;
+    }
     qxl->rom->compression_level = cpu_to_le32(level);
     qxl_rom_set_dirty(qxl);
 }
@@ -997,7 +1010,8 @@ static void interface_set_client_capabilities(QXLInstance *sin,
     }
 
     if (runstate_check(RUN_STATE_INMIGRATE) ||
-        runstate_check(RUN_STATE_POSTMIGRATE)) {
+        runstate_check(RUN_STATE_POSTMIGRATE) ||
+        cpr_is_incoming()) {
         return;
     }
 
@@ -1200,6 +1214,10 @@ static void qxl_reset_state(PCIQXLDevice *d)
 {
     QXLRom *rom = d->rom;
 
+    if (cpr_is_incoming()) {
+        return;
+    }
+
     qxl_check_state(d);
     d->shadow_rom.update_id = cpu_to_le32(0);
     *rom = d->shadow_rom;
@@ -1370,8 +1388,11 @@ static int qxl_add_memslot(PCIQXLDevice *d, uint32_t slot_id, uint64_t delta,
     memslot.virt_start = virt_start + (guest_start - pci_start);
     memslot.virt_end   = virt_start + (guest_end   - pci_start);
     memslot.addr_delta = memslot.virt_start - delta;
-    memslot.generation = d->rom->slot_generation = 0;
-    qxl_rom_set_dirty(d);
+    if (!cpr_is_incoming()) {
+        d->rom->slot_generation = 0;
+        qxl_rom_set_dirty(d);
+    }
+    memslot.generation = d->rom->slot_generation;
 
     qemu_spice_add_memslot(&d->ssd, &memslot, async);
     d->guest_slots[slot_id].mr = mr;
-- 
2.35.3


