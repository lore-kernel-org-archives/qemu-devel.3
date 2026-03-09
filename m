Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC30F3C24A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaLM-0006rC-Bq; Mon, 09 Mar 2026 09:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaLG-0006iR-Ne
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:14 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaLF-0008AU-52
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EFEB5BD87;
 Mon,  9 Mar 2026 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA2Xm82tWaXcX6p6TYQd8qQYAPkx9Kmf0sjJ54P2o30=;
 b=Hp5HycBJemkDtjYrsn5R0I2e4SFnvL9cMTxAibKERs0uGPCVBThTX5h1RDNRm7MiokBgWw
 Uqa4qNJPCGTxJ+eaLMg12JWlVSdErmphTZgxxg3RGPFyqxUkkiVI6feaAnEu3ShBOhI25I
 I5fIn7J7HFLYC6Bg9zmyn4QFsbChzkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA2Xm82tWaXcX6p6TYQd8qQYAPkx9Kmf0sjJ54P2o30=;
 b=etTv0/GMnntebW4r7a14NoPSmUwPfyQ6pG8go+Oi+NzrnN70M36/tFmHdBtn1X0BUvucKO
 UeNeGjQ4UI+iJFDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hp5HycBJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="etTv0/GM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA2Xm82tWaXcX6p6TYQd8qQYAPkx9Kmf0sjJ54P2o30=;
 b=Hp5HycBJemkDtjYrsn5R0I2e4SFnvL9cMTxAibKERs0uGPCVBThTX5h1RDNRm7MiokBgWw
 Uqa4qNJPCGTxJ+eaLMg12JWlVSdErmphTZgxxg3RGPFyqxUkkiVI6feaAnEu3ShBOhI25I
 I5fIn7J7HFLYC6Bg9zmyn4QFsbChzkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA2Xm82tWaXcX6p6TYQd8qQYAPkx9Kmf0sjJ54P2o30=;
 b=etTv0/GMnntebW4r7a14NoPSmUwPfyQ6pG8go+Oi+NzrnN70M36/tFmHdBtn1X0BUvucKO
 UeNeGjQ4UI+iJFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D57573EEF2;
 Mon,  9 Mar 2026 13:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AEY0JifGrmlJcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 13:07:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 11/22] colo: Fix crash during device vmstate load
Date: Mon,  9 Mar 2026 10:07:16 -0300
Message-ID: <20260309130730.20526-12-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309130730.20526-1-farosas@suse.de>
References: <20260309130730.20526-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[web.de]
X-Rspamd-Queue-Id: 0EFEB5BD87
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

From: Lukas Straub <lukasstraub2@web.de>

With colo we load device vmstate during each checkpoint, on top of
a vm that was already running. Some devices expect a reset before
loading vmstate on such a previously running vm.

This fixes a crash when using COLO with Q35 machine.

The reset adds 10-20ms overhead to the checkpointing proces in my
testing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260302-colo_unit_test_multifd-v11-10-d653fb3b1d80@web.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/colo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 96102c9d0f..dc7cfa81ef 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,6 +729,12 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     vmstate_loading = true;
+    /*
+     * With colo we load device vmstate during each checkpoint, on top of
+     * a vm that was already running. Some devices expect a reset before
+     * loading vmstate on such a previously running vm.
+     */
+    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();
     ret = qemu_load_device_state(fb, errp);
     if (ret < 0) {
-- 
2.51.0


