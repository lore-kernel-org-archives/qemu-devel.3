Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B7AC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nTr-0001sL-0Q; Thu, 10 Sep 2026 18:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lMk-0003KK-VS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:27:44 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lMb-00018C-HU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:27:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B0E41FEE6;
 Thu, 10 Sep 2026 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i81n+GnYIxgR2D7wkfxfD6rDpyiLWPJwk+0xmQ4/zbo=;
 b=W4X0EdgxMDHW+cuq3ZLN4J10UQ9RJZr0K/5xkuttOtRkFGy8oWnLkXOgunBLf630dsTD4Z
 +PxJAatnhPX44GEMzlXxTTmCpaq4HB6xjVIFeXYLkmzjf+VUKEd4eD8v+Eje0qHgjPcqn7
 VUcrak2o2WDaLeMp8QlngJOjuwqzusY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i81n+GnYIxgR2D7wkfxfD6rDpyiLWPJwk+0xmQ4/zbo=;
 b=885n9/h+w7jcyrdJ41eSiOal6Z9G+kZddG3y21NawzLqIdCGTs9VwuKf/+ZmroL/IAABFY
 9Ij5Ho3zyXIxI2DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i81n+GnYIxgR2D7wkfxfD6rDpyiLWPJwk+0xmQ4/zbo=;
 b=DeWyp0SUwE5yT5tgfc7u80vaKVK6wYiZiDes6jOeXAm2JPhnngyYagHgcSrZRgb9g05ciZ
 OaL+3Wj3i1hcpy6I5o4CZkwKp4VQTYrSQTrIvaYc0Mj66UfFX3+i7JSJ0kUg9KXHwSt71f
 bRffh1PO1VVlvnemMmp4DeWq+nOvYsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i81n+GnYIxgR2D7wkfxfD6rDpyiLWPJwk+0xmQ4/zbo=;
 b=ttgprqApxsP2WhkEI/YFZAG74ANI/Ftr9omKNaB5R8ddq+MrVVsMSufnNJxY/YtG0wo4ds
 U0CACmrLG6QPThDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DACA813A5D;
 Thu, 10 Sep 2026 20:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eESWKmMSo2pJPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 20:26:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 5/7] migration: Drop iochannel reference during snapshot setup
Date: Thu, 10 Sep 2026 17:25:57 -0300
Message-ID: <20260910202559.916866-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910202559.916866-1-farosas@suse.de>
References: <20260910202559.916866-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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


