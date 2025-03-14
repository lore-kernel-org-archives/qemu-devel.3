Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59373C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6LH-0003xd-8c; Fri, 14 Mar 2025 10:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tt6LE-0003wX-D0
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:48:52 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tt6LC-0001mf-IG
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:48:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6865A1F84B;
 Fri, 14 Mar 2025 14:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741963715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2FX6fCHSAtfJRNiMdzoFd+Ca6UJI492RJTWWUu75ZY=;
 b=XFWiTLyhx7oOmNe2XT+ouFQ2ihilj4cl4Sga1M3l+oYNCVRS2hLz+L08OHzC506edwSmee
 N1dD0/Lu4bcmb/Ypxnw5NuShIThNj6W1s18QeQB19Pz0/DFnh5BzwJd33uI25v2N+Kjtge
 zqGdRdJJbASH06wcRgS5KgrcSrlk3wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741963715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2FX6fCHSAtfJRNiMdzoFd+Ca6UJI492RJTWWUu75ZY=;
 b=cC9KkK1hLDzY/Cji5LVfZJXYIpZ2NdMHEMZ9VOTu/TgfjQka4WYvPL52GfPEgIlBHMEDFr
 oKhpTFt00sWHkhAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XFWiTLyh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cC9KkK1h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741963715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2FX6fCHSAtfJRNiMdzoFd+Ca6UJI492RJTWWUu75ZY=;
 b=XFWiTLyhx7oOmNe2XT+ouFQ2ihilj4cl4Sga1M3l+oYNCVRS2hLz+L08OHzC506edwSmee
 N1dD0/Lu4bcmb/Ypxnw5NuShIThNj6W1s18QeQB19Pz0/DFnh5BzwJd33uI25v2N+Kjtge
 zqGdRdJJbASH06wcRgS5KgrcSrlk3wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741963715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2FX6fCHSAtfJRNiMdzoFd+Ca6UJI492RJTWWUu75ZY=;
 b=cC9KkK1hLDzY/Cji5LVfZJXYIpZ2NdMHEMZ9VOTu/TgfjQka4WYvPL52GfPEgIlBHMEDFr
 oKhpTFt00sWHkhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E306132DD;
 Fri, 14 Mar 2025 14:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GFnTOMFB1GeVPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Mar 2025 14:48:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 3/4] hw/loader: fix roms during cpr
Date: Fri, 14 Mar 2025 11:48:23 -0300
Message-Id: <20250314144824.1707-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250314144824.1707-1-farosas@suse.de>
References: <20250314144824.1707-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6865A1F84B
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
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
fix, skip the re-init during CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <1741380954-341079-4-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/core/loader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 332b879a0b..ce6ff1b52e 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -51,6 +51,7 @@
 #include "trace.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "system/reset.h"
@@ -1029,7 +1030,9 @@ static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
     vmstate_register_ram_global(rom->mr);
 
     data = memory_region_get_ram_ptr(rom->mr);
-    memcpy(data, rom->data, rom->datasize);
+    if (!cpr_is_incoming()) {
+        memcpy(data, rom->data, rom->datasize);
+    }
 
     return data;
 }
-- 
2.35.3


