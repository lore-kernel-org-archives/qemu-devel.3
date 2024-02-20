Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0FEC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoI-0002tc-7w; Tue, 20 Feb 2024 17:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoG-0002t8-3x
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:41:56 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoD-0006Fa-Vk
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:41:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8004A1FD3E;
 Tue, 20 Feb 2024 22:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+c/ZVDOoCpTXIYlubE8aW4G10xvnHLJuXzfhzZwYOU=;
 b=0ZCsQ1gX/CBWpWl7arN84jPboBE3AM0vdDj9IvEBOzypMJxKjCPFNTJT2G5/YYU4H5DG4O
 xV/J347nERJb4Rz6d99tiEFGcL4kw5AFOcPTiOVTv/AjrGr+ofb3uSamNHFk4+UFUuDStG
 3R/jIP26f0fPiQOgL4GhKiEdOkufbtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+c/ZVDOoCpTXIYlubE8aW4G10xvnHLJuXzfhzZwYOU=;
 b=Dgxy5Is1ynZ2E71SgpCyzNOcWYTPrSylElfXPTumT+7IFldEkxBtB1duF51aoJ+dzac+q9
 gtJ6yEYlARdbkwDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+c/ZVDOoCpTXIYlubE8aW4G10xvnHLJuXzfhzZwYOU=;
 b=0ZCsQ1gX/CBWpWl7arN84jPboBE3AM0vdDj9IvEBOzypMJxKjCPFNTJT2G5/YYU4H5DG4O
 xV/J347nERJb4Rz6d99tiEFGcL4kw5AFOcPTiOVTv/AjrGr+ofb3uSamNHFk4+UFUuDStG
 3R/jIP26f0fPiQOgL4GhKiEdOkufbtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+c/ZVDOoCpTXIYlubE8aW4G10xvnHLJuXzfhzZwYOU=;
 b=Dgxy5Is1ynZ2E71SgpCyzNOcWYTPrSylElfXPTumT+7IFldEkxBtB1duF51aoJ+dzac+q9
 gtJ6yEYlARdbkwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4DAF139D0;
 Tue, 20 Feb 2024 22:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iHKYJq4q1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:41:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 04/34] migration/multifd: Remove p->quit from recv side
Date: Tue, 20 Feb 2024 19:41:08 -0300
Message-Id: <20240220224138.24759-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0ZCsQ1gX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Dgxy5Is1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 8004A1FD3E
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

Like we did on the sending side, replace the p->quit per-channel flag
with a global atomic 'exiting' flag.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index adfe8c9a0a..fba00b9e8f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -79,6 +79,19 @@ struct {
     MultiFDMethods *ops;
 } *multifd_send_state;
 
+struct {
+    MultiFDRecvParams *params;
+    /* number of created threads */
+    int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
+    int exiting;
+    /* multifd ops */
+    MultiFDMethods *ops;
+} *multifd_recv_state;
+
 /* Multifd without compression */
 
 /**
@@ -440,6 +453,11 @@ static bool multifd_send_should_exit(void)
     return qatomic_read(&multifd_send_state->exiting);
 }
 
+static bool multifd_recv_should_exit(void)
+{
+    return qatomic_read(&multifd_recv_state->exiting);
+}
+
 /*
  * The migration thread can wait on either of the two semaphores.  This
  * function can be used to kick the main thread out of waiting on either of
@@ -1063,24 +1081,16 @@ bool multifd_send_setup(void)
     return true;
 }
 
-struct {
-    MultiFDRecvParams *params;
-    /* number of created threads */
-    int count;
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
-    /* multifd ops */
-    MultiFDMethods *ops;
-} *multifd_recv_state;
-
 static void multifd_recv_terminate_threads(Error *err)
 {
     int i;
 
     trace_multifd_recv_terminate_threads(err != NULL);
 
+    if (qatomic_xchg(&multifd_recv_state->exiting, 1)) {
+        return;
+    }
+
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
@@ -1094,8 +1104,6 @@ static void multifd_recv_terminate_threads(Error *err)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        qemu_mutex_lock(&p->mutex);
-        p->quit = true;
         /*
          * We could arrive here for two reasons:
          *  - normal quit, i.e. everything went fine, just finished
@@ -1105,7 +1113,6 @@ static void multifd_recv_terminate_threads(Error *err)
         if (p->c) {
             qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
-        qemu_mutex_unlock(&p->mutex);
     }
 }
 
@@ -1210,7 +1217,7 @@ static void *multifd_recv_thread(void *opaque)
     while (true) {
         uint32_t flags;
 
-        if (p->quit) {
+        if (multifd_recv_should_exit()) {
             break;
         }
 
@@ -1274,6 +1281,7 @@ int multifd_recv_setup(Error **errp)
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     qatomic_set(&multifd_recv_state->count, 0);
+    qatomic_set(&multifd_recv_state->exiting, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
     multifd_recv_state->ops = multifd_ops[migrate_multifd_compression()];
 
@@ -1282,7 +1290,6 @@ int multifd_recv_setup(Error **errp)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
-        p->quit = false;
         p->id = i;
         p->packet_len = sizeof(MultiFDPacket_t)
                       + sizeof(uint64_t) * page_count;
-- 
2.35.3


