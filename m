Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA4AC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPLI-0001cZ-HX; Fri, 07 Feb 2025 09:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPLG-0001X5-Ts
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:26 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPLD-0000EG-VT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:25 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A79DA2115F;
 Fri,  7 Feb 2025 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0KvXfDIFXkrX+ZgnkIYb6O2Q8w4gOAFmAaZ+kq6Y8k=;
 b=W7ZK+POSIx39mwyzn9io9HvOG96IK9meraYg3s4FWuF30VdUDfUetumGYoA83zHxPhgonT
 ZCvlzyFY7n9jQLsuh0l92xBzwfvgdXwq7ODMOado7jNHu8PqeuIILk73OgubMsIc+Uvvh2
 ijUqgD/n1LItGX/JgKHcZKBr/Hr0Qf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0KvXfDIFXkrX+ZgnkIYb6O2Q8w4gOAFmAaZ+kq6Y8k=;
 b=eZSzZ101t7b/6hYlvQJZo6polupmC0MU50sATbVX93b0fduRo1VVUJuOG5+X/VhYcHNve8
 cnbSWc3zvcQ0JzAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0KvXfDIFXkrX+ZgnkIYb6O2Q8w4gOAFmAaZ+kq6Y8k=;
 b=W7ZK+POSIx39mwyzn9io9HvOG96IK9meraYg3s4FWuF30VdUDfUetumGYoA83zHxPhgonT
 ZCvlzyFY7n9jQLsuh0l92xBzwfvgdXwq7ODMOado7jNHu8PqeuIILk73OgubMsIc+Uvvh2
 ijUqgD/n1LItGX/JgKHcZKBr/Hr0Qf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0KvXfDIFXkrX+ZgnkIYb6O2Q8w4gOAFmAaZ+kq6Y8k=;
 b=eZSzZ101t7b/6hYlvQJZo6polupmC0MU50sATbVX93b0fduRo1VVUJuOG5+X/VhYcHNve8
 cnbSWc3zvcQ0JzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09401139CB;
 Fri,  7 Feb 2025 14:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uD8HLoMYpmcoOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 14:28:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH v2 8/8] migration/multifd: Add a compat property for TLS
 termination
Date: Fri,  7 Feb 2025 11:27:58 -0300
Message-Id: <20250207142758.6936-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250207142758.6936-1-farosas@suse.de>
References: <20250207142758.6936-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

We're currently changing the way the source multifd migration handles
the shutdown of the multifd channels when TLS is in use to perform a
clean termination by calling gnutls_bye().

Older src QEMUs will always close the channel without terminating the
TLS session. New dst QEMUs treat an unclean termination as an
error. Due to synchronization conditions, src QEMUs 9.1 and 9.2 are an
exception and can put the destination in a condition where it ignores
the unclean termination. For src QEMUs older than 9.1, we'll need a
compat property on the destination to inform that the src does not
terminate the TLS session.

Add multifd_clean_tls_termination (default true) that can be switched
on the destination whenever a src QEMU <9.1 is in use.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.h | 33 +++++++++++++++++++++++++++++++++
 migration/multifd.c   |  8 +++++++-
 migration/multifd.h   |  2 ++
 migration/options.c   |  2 ++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 4c1fafc2b5..77def0b437 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -443,6 +443,39 @@ struct MigrationState {
      * Default value is false. (since 8.1)
      */
     bool multifd_flush_after_each_section;
+
+    /*
+     * This variable only makes sense when set on the machine that is
+     * the destination of a multifd migration with TLS enabled. It
+     * affects the behavior of the last send->recv iteration with
+     * regards to termination of the TLS session.
+     *
+     * When set:
+     *
+     * - the destination QEMU instance can expect to never get a
+     *   GNUTLS_E_PREMATURE_TERMINATION error. Manifested as the error
+     *   message: "The TLS connection was non-properly terminated".
+     *
+     * When clear:
+     *
+     * - the destination QEMU instance can expect to see a
+     *   GNUTLS_E_PREMATURE_TERMINATION error in any multifd channel
+     *   whenever the last recv() call of that channel happens after
+     *   the source QEMU instance has already issued shutdown() on the
+     *   channel.
+     *
+     *   Commit 637280aeb2 (since 9.1) introduced a side effect that
+     *   causes the destination instance to not be affected by the
+     *   premature termination, while commit 1d457daf86 (since 10.0)
+     *   causes the premature termination condition to be once again
+     *   reachable.
+     *
+     * NOTE: Regardless of the state of this option, a premature
+     * termination of the TLS connection might happen due to error at
+     * any moment prior to the last send->recv iteration.
+     */
+    bool multifd_clean_tls_termination;
+
     /*
      * This decides the size of guest memory chunk that will be used
      * to track dirty bitmap clearing.  The size of memory chunk will
diff --git a/migration/multifd.c b/migration/multifd.c
index b4f82b0893..4342399818 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1147,6 +1147,7 @@ void multifd_recv_sync_main(void)
 
 static void *multifd_recv_thread(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
     MultiFDRecvParams *p = opaque;
     Error *local_err = NULL;
     bool use_packets = multifd_use_packets();
@@ -1155,6 +1156,10 @@ static void *multifd_recv_thread(void *opaque)
     trace_multifd_recv_thread_start(p->id);
     rcu_register_thread();
 
+    if (!s->multifd_clean_tls_termination) {
+        p->read_flags = QIO_CHANNEL_READ_FLAG_RELAXED_EOF;
+    }
+
     while (true) {
         uint32_t flags = 0;
         bool has_data = false;
@@ -1166,7 +1171,8 @@ static void *multifd_recv_thread(void *opaque)
             }
 
             ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
-                                           p->packet_len, 0, &local_err);
+                                           p->packet_len, p->read_flags,
+                                           &local_err);
             if (!ret) {
                 /* EOF */
                 assert(!local_err);
diff --git a/migration/multifd.h b/migration/multifd.h
index bd785b9873..cf408ff721 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -244,6 +244,8 @@ typedef struct {
     uint32_t zero_num;
     /* used for de-compression methods */
     void *compress_data;
+    /* Flags for the QIOChannel */
+    int read_flags;
 } MultiFDRecvParams;
 
 typedef struct {
diff --git a/migration/options.c b/migration/options.c
index 1ad950e397..feda354935 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -99,6 +99,8 @@ const Property migration_properties[] = {
                       clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
     DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
                      preempt_pre_7_2, false),
+    DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
+                     multifd_clean_tls_termination, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
-- 
2.35.3


