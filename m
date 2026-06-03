Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9978CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUmK5-0007bi-5G; Wed, 03 Jun 2026 10:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUmJw-0007ZM-UM
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:11:48 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUmJv-0003rk-67
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:11:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8662F6763E;
 Wed,  3 Jun 2026 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780495904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/2k/sg3jnaTZ3XEHiBDENqOY1G5vJxTu+cUtaqBs5O4=;
 b=1a78WbXlMi7y67aKwwSn6nCGB/9l0MdqJIaP3r51OztEBMzUPuxWZSar14UvZEeHRR9fQv
 H16j6HzH5Ox/3qnvaaefqL4ERbQmGz5yXDbzg3uSK8br0mTSClBP2BTQIndl4W8zZt6aiz
 m3nhfhbGe4trULSTgFnvWpgXAcuh7SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780495904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/2k/sg3jnaTZ3XEHiBDENqOY1G5vJxTu+cUtaqBs5O4=;
 b=kZgISGW1/KvRO1FvB4FZRIoXOC5zkabhuf2l/6FNhhFI0xNj8I8PRq2GXaVZtH1ihIvqn9
 17c4sn6uwgd5ZDBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780495904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/2k/sg3jnaTZ3XEHiBDENqOY1G5vJxTu+cUtaqBs5O4=;
 b=1a78WbXlMi7y67aKwwSn6nCGB/9l0MdqJIaP3r51OztEBMzUPuxWZSar14UvZEeHRR9fQv
 H16j6HzH5Ox/3qnvaaefqL4ERbQmGz5yXDbzg3uSK8br0mTSClBP2BTQIndl4W8zZt6aiz
 m3nhfhbGe4trULSTgFnvWpgXAcuh7SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780495904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/2k/sg3jnaTZ3XEHiBDENqOY1G5vJxTu+cUtaqBs5O4=;
 b=kZgISGW1/KvRO1FvB4FZRIoXOC5zkabhuf2l/6FNhhFI0xNj8I8PRq2GXaVZtH1ihIvqn9
 17c4sn6uwgd5ZDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B8CE779A7;
 Wed,  3 Jun 2026 14:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ey9oDx82IGoDbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 03 Jun 2026 14:11:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] chardev: Don't unregister yank upon async path connection
 failure
Date: Wed,  3 Jun 2026 11:11:37 -0300
Message-ID: <20260603141137.1108963-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
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

Commit 5c102ac9 ("chardev: Consolidate yank registration") has moved
yank registration in the tcp_chr_connect_client_async() path to after
the connection is successful. If qio_channel_socket_connect_sync()
fails early, there will be no yank registered to be unregistered in
the error path, leading to assert.

Remove the now-extraneous unregister.

Cc: qemu-stable@nongnu.org
Fixes: 5c102ac9 ("chardev: Consolidate yank registration")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3528
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 chardev/char-socket.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e064b105c5..99e01a4875 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1128,11 +1128,6 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 
     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
-        if (s->registered_yank) {
-            yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
-                                     char_socket_yank_iochannel,
-                                     QIO_CHANNEL(sioc));
-        }
         check_report_connect_error(chr, err);
         goto cleanup;
     }
-- 
2.53.0


