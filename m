Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E8CC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVyww-00020Q-Fd; Fri, 02 Feb 2024 14:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVywu-0001zi-Fm
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:11:40 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVywr-0001vj-Vb
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:11:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DAE51FD32;
 Fri,  2 Feb 2024 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4kRO8p6DEl/drZgDKdPAZmCp+mm2aFo3U2Xjp+yQZ8=;
 b=EkTl6e5T+uMLZBp8D3LZVDyAxBEuH0q4L+gQnw98r/bWQUZYK0ASxzUo0EF1nWTZJLmfkr
 RM0gEi6dXK5kjpeMT27zQgZRJ+BAltBXaiv1KsEWsSZha0XWYQe9WZlaeiQW80F+j+7c9w
 j/m9u3zDPyXbdlHW0mOOukVRV3VWx78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4kRO8p6DEl/drZgDKdPAZmCp+mm2aFo3U2Xjp+yQZ8=;
 b=ZpObsHaXHmQcBoxcBEXi8X5qlzA5W80eXLXIUOSroQH4i474TuJKDu40i/5WW3ec7nPMrK
 wnIP2P0ROYeRuMDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4kRO8p6DEl/drZgDKdPAZmCp+mm2aFo3U2Xjp+yQZ8=;
 b=SWLoGxuiAdmSu8UhVQqb74xVyP9jNaFrXRHGwZJTKcy0IBliY+DwO/UanCi4roSMwOAHEX
 HiALMsM9xMQ+CMuxFCqOF6vc/mGTLqEMOAyTw5gEWFilSh7d5YyWNftStb/AC6fbObxxEV
 Z+GLxECyN1NXVrsgPeV16Vp7Y4jhzpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4kRO8p6DEl/drZgDKdPAZmCp+mm2aFo3U2Xjp+yQZ8=;
 b=HLZB66Mwr7Jrj4ZCT6Ea7tMyJFwtWRW+FtpVUhFCb2MzvCzB1oOgsatUF2yX3DbdHDwK+9
 3CL+/5M9sbXMOFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26CD713A5F;
 Fri,  2 Feb 2024 19:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +IxwN2Q+vWWlZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 19:11:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 1/5] migration/multifd: Join the TLS thread
Date: Fri,  2 Feb 2024 16:11:24 -0300
Message-Id: <20240202191128.1901-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240202191128.1901-1-farosas@suse.de>
References: <20240202191128.1901-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[10.42%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

We're currently leaking the resources of the TLS thread by not joining
it and also overwriting the p->thread pointer altogether.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 8 +++++++-
 migration/multifd.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 25cbc6dc6b..b557d046a9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -524,6 +524,10 @@ void multifd_save_cleanup(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
+        if (p->tls_thread_created) {
+            qemu_thread_join(&p->tls_thread);
+        }
+
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
@@ -827,7 +831,9 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
     p->c = QIO_CHANNEL(tioc);
-    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
+
+    p->tls_thread_created = true;
+    qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
                        multifd_tls_handshake_thread, p,
                        QEMU_THREAD_JOINABLE);
     return true;
diff --git a/migration/multifd.h b/migration/multifd.h
index 35d11f103c..5a69ef40e2 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -73,6 +73,8 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    QemuThread tls_thread;
+    bool tls_thread_created;
     /* communication channel */
     QIOChannel *c;
     /* is the yank function registered */
-- 
2.35.3


