Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219F6C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEe2-0004li-H7; Fri, 11 Jul 2025 10:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEUP-0003Rb-Um
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEUK-0006tp-Rl
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 22F281F745;
 Fri, 11 Jul 2025 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aG95BgYcOsHXzWzUs4dX5Sb1S1cl1g5JAcSQb06bXEs=;
 b=xGhuNNFU/9kvNMzKDHGLwPLrmPjdnj6sLqAVAhbA3E96tqbbRgO7APre5o0GXO+1FqwNhf
 ZUkZvDkNIKR3CdmcNFSzPNzxQ+5y+rEcirxaJ6btBEFwWgkVN8EnuAgqhu3H0YPbzWG2oY
 sq2unFRzdMAInKEWFYCgCTl8SKUsU48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aG95BgYcOsHXzWzUs4dX5Sb1S1cl1g5JAcSQb06bXEs=;
 b=LEL+EsTYwonbTgV5dVyJFMTZFZqT3p9OjFXg1VvOB3jyix5k24qZNCbFt5MakSeagvpG6a
 vNEaHTNJnb9/IuDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xGhuNNFU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LEL+EsTY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aG95BgYcOsHXzWzUs4dX5Sb1S1cl1g5JAcSQb06bXEs=;
 b=xGhuNNFU/9kvNMzKDHGLwPLrmPjdnj6sLqAVAhbA3E96tqbbRgO7APre5o0GXO+1FqwNhf
 ZUkZvDkNIKR3CdmcNFSzPNzxQ+5y+rEcirxaJ6btBEFwWgkVN8EnuAgqhu3H0YPbzWG2oY
 sq2unFRzdMAInKEWFYCgCTl8SKUsU48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aG95BgYcOsHXzWzUs4dX5Sb1S1cl1g5JAcSQb06bXEs=;
 b=LEL+EsTYwonbTgV5dVyJFMTZFZqT3p9OjFXg1VvOB3jyix5k24qZNCbFt5MakSeagvpG6a
 vNEaHTNJnb9/IuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42DE61388B;
 Fri, 11 Jul 2025 14:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2PihAIsbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/26] migration: Rename save_live_complete_precopy_thread to
 save_complete_precopy_thread
Date: Fri, 11 Jul 2025 11:10:31 -0300
Message-Id: <20250711141031.423-27-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 22F281F745
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

From: Juraj Marcin <jmarcin@redhat.com>

Recent patch [1] renames the save_live_complete_precopy handler to
save_complete, as the machine is not live in most cases when this
handler is executed. The same is true also for
save_live_complete_precopy_thread, therefore this patch removes the
"live" keyword from the handler itself and related types to keep the
naming unified.

In contrast to save_complete, this handler is only executed at the end
of precopy, therefore the "precopy" keyword is retained.

[1]: https://lore.kernel.org/all/20250613140801.474264-7-peterx@redhat.com/

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250626085235.294690-1-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/vfio.rst    |  4 ++--
 hw/vfio/migration-multifd.c      |  4 ++--
 hw/vfio/migration-multifd.h      |  2 +-
 hw/vfio/migration.c              |  2 +-
 include/migration/misc.h         |  8 ++++----
 include/migration/register.h     |  6 +++---
 include/qemu/typedefs.h          |  6 +++---
 migration/multifd-device-state.c | 10 +++++-----
 migration/savevm.c               |  6 +++---
 9 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 8ff5ab0c74..2d8e5ca9dd 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -80,7 +80,7 @@ VFIO implements the device hooks for the iterative approach as follows:
   vendor driver indicates that no data remains.  In the multifd mode it
   just emits a dummy EOS marker.
 
-* A ``save_live_complete_precopy_thread`` function that in the multifd mode
+* A ``save_complete_precopy_thread`` function that in the multifd mode
   provides thread handler performing multifd device state transfer.
   It sets the VFIO device to _STOP_COPY state, iteratively reads the data
   from the VFIO device and queues it for multifd transmission until the vendor
@@ -200,7 +200,7 @@ Live migration save path
                              .save_complete() until
                                pending data is 0
 	          In the multifd mode this iteration is done in
-	          .save_live_complete_precopy_thread() instead.
+	          .save_complete_precopy_thread() instead.
                                       |
                      (POSTMIGRATE, _COMPLETED, _STOP_COPY)
             Migraton thread schedules cleanup bottom half and exits
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 850a319488..55635486c8 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -583,7 +583,7 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
 
 /*
  * This thread is spawned by the migration core directly via
- * .save_live_complete_precopy_thread SaveVMHandler.
+ * .save_complete_precopy_thread SaveVMHandler.
  *
  * It exits after either:
  * * completing saving the remaining device state and device config, OR:
@@ -592,7 +592,7 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
  *   multifd_device_state_save_thread_should_exit() returning true.
  */
 bool
-vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
+vfio_multifd_save_complete_precopy_thread(SaveCompletePrecopyThreadData *d,
                                           Error **errp)
 {
     VFIODevice *vbasedev = d->handler_opaque;
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 0bab63211d..ebf22a7997 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -26,7 +26,7 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
 void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
 
 bool
-vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
+vfio_multifd_save_complete_precopy_thread(SaveCompletePrecopyThreadData *d,
                                           Error **errp);
 
 int vfio_multifd_switchover_start(VFIODevice *vbasedev);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 33a71f8999..c329578eec 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -835,7 +835,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
      */
     .load_state_buffer = vfio_multifd_load_state_buffer,
     .switchover_start = vfio_switchover_start,
-    .save_live_complete_precopy_thread = vfio_multifd_save_complete_precopy_thread,
+    .save_complete_precopy_thread = vfio_multifd_save_complete_precopy_thread,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 8fd36eba1d..a261f99d89 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -119,19 +119,19 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                        Error **errp);
 
 /* migration/multifd-device-state.c */
-typedef struct SaveLiveCompletePrecopyThreadData {
-    SaveLiveCompletePrecopyThreadHandler hdlr;
+typedef struct SaveCompletePrecopyThreadData {
+    SaveCompletePrecopyThreadHandler hdlr;
     char *idstr;
     uint32_t instance_id;
     void *handler_opaque;
-} SaveLiveCompletePrecopyThreadData;
+} SaveCompletePrecopyThreadData;
 
 bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                 char *data, size_t len);
 bool multifd_device_state_supported(void);
 
 void
-multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
+multifd_spawn_device_state_save_thread(SaveCompletePrecopyThreadHandler hdlr,
                                        char *idstr, uint32_t instance_id,
                                        void *opaque);
 
diff --git a/include/migration/register.h b/include/migration/register.h
index 2a26e76a68..ae79794cdd 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -98,7 +98,7 @@ typedef struct SaveVMHandlers {
     int (*save_complete)(QEMUFile *f, void *opaque);
 
     /**
-     * @save_live_complete_precopy_thread (invoked in a separate thread)
+     * @save_complete_precopy_thread (invoked in a separate thread)
      *
      * Called at the end of a precopy phase from a separate worker thread
      * in configurations where multifd device state transfer is supported
@@ -107,14 +107,14 @@ typedef struct SaveVMHandlers {
      * When postcopy is enabled, devices that support postcopy will skip this
      * step.
      *
-     * @d: a #SaveLiveCompletePrecopyThreadData containing parameters that the
+     * @d: a #SaveCompletePrecopyThreadData containing parameters that the
      * handler may need, including this device section idstr and instance_id,
      * and opaque data pointer passed to register_savevm_live().
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns true to indicate success and false for errors.
      */
-    SaveLiveCompletePrecopyThreadHandler save_live_complete_precopy_thread;
+    SaveCompletePrecopyThreadHandler save_complete_precopy_thread;
 
     /* This runs both outside and inside the BQL.  */
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 507f0814d5..4a94af9665 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -109,7 +109,7 @@ typedef struct QString QString;
 typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct ReservedRegion ReservedRegion;
-typedef struct SaveLiveCompletePrecopyThreadData SaveLiveCompletePrecopyThreadData;
+typedef struct SaveCompletePrecopyThreadData SaveCompletePrecopyThreadData;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct TCGCPUOps TCGCPUOps;
@@ -135,7 +135,7 @@ typedef struct IRQState *qemu_irq;
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
 typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
                                     Error **errp);
-typedef bool (*SaveLiveCompletePrecopyThreadHandler)(SaveLiveCompletePrecopyThreadData *d,
-                                                     Error **errp);
+typedef bool (*SaveCompletePrecopyThreadHandler)(SaveCompletePrecopyThreadData *d,
+                                                 Error **errp);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 94222d0eb0..fce64f00b0 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -131,7 +131,7 @@ bool multifd_device_state_supported(void)
 
 static void multifd_device_state_save_thread_data_free(void *opaque)
 {
-    SaveLiveCompletePrecopyThreadData *data = opaque;
+    SaveCompletePrecopyThreadData *data = opaque;
 
     g_clear_pointer(&data->idstr, g_free);
     g_free(data);
@@ -139,7 +139,7 @@ static void multifd_device_state_save_thread_data_free(void *opaque)
 
 static int multifd_device_state_save_thread(void *opaque)
 {
-    SaveLiveCompletePrecopyThreadData *data = opaque;
+    SaveCompletePrecopyThreadData *data = opaque;
     g_autoptr(Error) local_err = NULL;
 
     if (!data->hdlr(data, &local_err)) {
@@ -170,18 +170,18 @@ bool multifd_device_state_save_thread_should_exit(void)
 }
 
 void
-multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
+multifd_spawn_device_state_save_thread(SaveCompletePrecopyThreadHandler hdlr,
                                        char *idstr, uint32_t instance_id,
                                        void *opaque)
 {
-    SaveLiveCompletePrecopyThreadData *data;
+    SaveCompletePrecopyThreadData *data;
 
     assert(multifd_device_state_supported());
     assert(multifd_send_device_state);
 
     assert(!qatomic_read(&multifd_send_device_state->threads_abort));
 
-    data = g_new(SaveLiveCompletePrecopyThreadData, 1);
+    data = g_new(SaveCompletePrecopyThreadData, 1);
     data->hdlr = hdlr;
     data->idstr = g_strdup(idstr);
     data->instance_id = instance_id;
diff --git a/migration/savevm.c b/migration/savevm.c
index c4fd5f5a5b..fabbeb296a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1581,15 +1581,15 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 
     if (multifd_device_state) {
         QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-            SaveLiveCompletePrecopyThreadHandler hdlr;
+            SaveCompletePrecopyThreadHandler hdlr;
 
             if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
                              se->ops->has_postcopy(se->opaque)) ||
-                !se->ops->save_live_complete_precopy_thread) {
+                !se->ops->save_complete_precopy_thread) {
                 continue;
             }
 
-            hdlr = se->ops->save_live_complete_precopy_thread;
+            hdlr = se->ops->save_complete_precopy_thread;
             multifd_spawn_device_state_save_thread(hdlr,
                                                    se->idstr, se->instance_id,
                                                    se->opaque);
-- 
2.35.3


