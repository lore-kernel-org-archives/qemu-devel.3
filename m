Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39220C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2FZ9-00074B-5D; Thu, 03 Sep 2026 18:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2FZ0-00072H-46
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 18:05:42 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2FYx-0003Xz-2e
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 18:05:40 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A26681FBA8;
 Thu,  3 Sep 2026 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788473133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EYRbSgft2VgPr98eYwep2GCDB37oUZvrs46N1Dm/hk=;
 b=MGrQV7dH3I4AP3neEDRZVLLElDEqUY6GZJN514FPdCHD4xCFpCLq+TEK6beuUcexP78q/Z
 +lmWFWjUnHow8PIeBvLdL64VfqHqjqISXq7+xMMTCkHibnZQofKeKeqBrYSPYmhjNBaN+r
 heW4El5ie9mn23uM9bmAH588LCBRmI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788473133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EYRbSgft2VgPr98eYwep2GCDB37oUZvrs46N1Dm/hk=;
 b=+oc1MOmN+DHxvYh/8MyTTm5QukkXyJ2cx7cStUB1uSPO5zAtjZdxdeFaBnMjC1wpg2WGGH
 Y88AT3FEEZVweLBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bim6vuUJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+zfy6MDi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788473129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EYRbSgft2VgPr98eYwep2GCDB37oUZvrs46N1Dm/hk=;
 b=bim6vuUJWQI7K2OpvJj6alIJDFfB4vsdHSVDd1eVUlC6CQ++I3B9n7A72A1mu/aFE+u7fq
 /YeS7UbLRX/82N1rQiXeCVdFm2eqUFEiNjNuNIdlR57cuFbbNrAgZmDvZJk7D7i5pZLdQy
 8khOsqkEzVO0Sd87/ja7JoPHjkLaxmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788473129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EYRbSgft2VgPr98eYwep2GCDB37oUZvrs46N1Dm/hk=;
 b=+zfy6MDiJPdb70saIlxXXOWz1xoI3k5ReSU2tizvofjuzgkft546NlBh34Ft4QkLBNrI8+
 4EeSQpG5eZOaZIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1AE913738;
 Thu,  3 Sep 2026 22:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MNlrHCjvmWppUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 22:05:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/3] migration: Drop iochannel reference during snapshot setup
Date: Thu,  3 Sep 2026 19:05:22 -0300
Message-ID: <20260903220523.2849019-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903220523.2849019-1-farosas@suse.de>
References: <20260903220523.2849019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A26681FBA8
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

During migration there are usually two references to the iochannel,
one from the channel creation itself and another from the ownership
transfer into QEMUFile.

- The reference from the QEMUFile is decremented at qemu_fclose.

- The original reference is decremented at migration_connect_outgoing()
for regular migration and not at all for snapshots.

The ide-test has recently added migration support and ASAN has
flagged:

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x55ca12aac0b9 in realloc
    #1 0x7fd97d7e5a05 in g_realloc
    #3 0x7fd97d7c98c6 in g_hash_table_new_full
    #4 0x55ca14e186f1 in object_initialize_with_type ../qom/object.c:506:23
    #5 0x55ca14e1a590 in object_new_with_type ../qom/object.c:706:5
    #6 0x55ca14e1a7e8 in object_new ../qom/object.c:722:12
    #7 0x55ca12de896f in qio_channel_block_new ../migration/channel-block.c:32:29
    #8 0x55ca12ec8f2d in qemu_fopen_bdrv ../migration/savevm.c:172:49
    #9 0x55ca12ec8b42 in save_snapshot ../migration/savevm.c:3375:9
    #10 0x55ca12ee18e3 in hmp_savevm ../migration/migration-hmp-cmds.c:497:5

Change qemu_fopen_bdrv() to drop the original reference once the
QEMUFile has taken over the object. The xen code already does the
same.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 5b0e89ca7c..8d4bdc28ab 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -168,11 +168,16 @@ static bool qemu_loadvm_thread_pool_wait(MigrationState *s,
 
 static QEMUFile *qemu_fopen_bdrv(BlockDriverState *bs, int is_writable)
 {
+    QIOChannel *ioc = QIO_CHANNEL(qio_channel_block_new(bs));
+    QEMUFile *f;
+
     if (is_writable) {
-        return qemu_file_new_output(QIO_CHANNEL(qio_channel_block_new(bs)));
+        f = qemu_file_new_output(ioc);
     } else {
-        return qemu_file_new_input(QIO_CHANNEL(qio_channel_block_new(bs)));
+        f = qemu_file_new_input(ioc);
     }
+    object_unref(ioc);
+    return f;
 }
 
 
-- 
2.53.0


