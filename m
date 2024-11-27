Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C7FD6ACDA
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGImD-0004v5-Jx; Wed, 27 Nov 2024 09:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGImB-0004ut-Ih
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 09:12:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGIm9-0003zO-94
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 09:12:19 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BBFC21109;
 Wed, 27 Nov 2024 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732716734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0odT8N1HR3T7umyBQJUmBIMq9UAmD7pzTYEviuHRAi4=;
 b=BdlSH3lkMWbT9whNe1sgqmrWRo26J6lPAjTebW1uLfQGROseVmA7C255f4I4XkscJ7RCLy
 nwM3LnrAGUazIwaPycjs3tNkNT9fQwKbUyWysaE0/l8U3w4MI+ZXaxonAeRNFo6DdI/qnl
 FzDkE44o9FW8Uk+DMosRd7wVOjE9dI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732716734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0odT8N1HR3T7umyBQJUmBIMq9UAmD7pzTYEviuHRAi4=;
 b=LKRAr0IpYqIAKu65iZtJIn2r3uKMWjStpL2PZTSZlflX6F5f2IPrGjnWF777Fgy+YsfDOe
 cYcWQQ9pOWItDsBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732716734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0odT8N1HR3T7umyBQJUmBIMq9UAmD7pzTYEviuHRAi4=;
 b=BdlSH3lkMWbT9whNe1sgqmrWRo26J6lPAjTebW1uLfQGROseVmA7C255f4I4XkscJ7RCLy
 nwM3LnrAGUazIwaPycjs3tNkNT9fQwKbUyWysaE0/l8U3w4MI+ZXaxonAeRNFo6DdI/qnl
 FzDkE44o9FW8Uk+DMosRd7wVOjE9dI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732716734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0odT8N1HR3T7umyBQJUmBIMq9UAmD7pzTYEviuHRAi4=;
 b=LKRAr0IpYqIAKu65iZtJIn2r3uKMWjStpL2PZTSZlflX6F5f2IPrGjnWF777Fgy+YsfDOe
 cYcWQQ9pOWItDsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E9D0139AA;
 Wed, 27 Nov 2024 14:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P0ijFL0oR2c6FQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 14:12:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
In-Reply-To: <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com> <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
Date: Wed, 27 Nov 2024 11:12:09 -0300
Message-ID: <875xo8n4ue.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Wed, 27 Nov 2024 at 02:49, Fabiano Rosas <farosas@suse.de> wrote:
>> This patch should be just the actual refactoring on top of master, with
>> no mention to postcopy at all.
>
> * Okay. We'll have to ensure that it is merged before multifd+postcopy change.
>
>> > +            if (migrate_multifd() && !migration_in_postcopy()
>> > +                && (!migrate_multifd_flush_after_each_section()
>> > +                    || migrate_mapped_ram())) {
>>
>> This is getting out of hand. We can't keep growing this condition every
>> time something new comes up. Any ideas?
>
> * In 'v0' this series, !migration_in_postcopy() was added to
> migrate_multifd(), which worked, but was not okay.
>
> * Another could be to define a new helper/macro to include above 3-4
> checks. Because migrate_multifd(),
> migrate_multifd_flush_after_each_section() and migrate_mapped_ram()
> appear together at multiple points. But strangely the equation is not
> the same. Sometimes migrate_mapped_ram() is 'true' and sometimes it is
> 'false', so a combined helper may not work.  It is all to accommodate
> different workings of multifd IIUC, if it and precopy used the same
> protocol/stream, maybe such conditionals would go away automatically.

Maybe this would improve the situation. Peter, what do you think?

-->8--
From e9110360eb0efddf6945f37c518e3cc38d12b600 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Wed, 27 Nov 2024 11:03:04 -0300
Subject: [PATCH] migration: Rationalize multifd flushes from ram code

We currently have a mess of conditionals to achieve the correct
combination of multifd local flushes, where we sync the local
(send/recv) multifd threads between themselves, and multifd remote
flushes, where we put a flag on the stream to inform the recv side to
perform a local flush.

On top of that we also have the multifd_flush_after_each_section
property, which is there to provide backward compatibility from when
we used to flush after every vmstate section.

And lastly, there's the mapped-ram feature which always wants the
non-backward compatible behavior and also does not support extraneous
flags on the stream (such as the MULTIFD_FLUSH flag).

Move the conditionals into a separate function that encapsulates and
explains the whole situation.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 198 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 157 insertions(+), 41 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb328..caaaae6fdc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1277,6 +1277,149 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
     return pages;
 }
 
+enum RamMultifdFlushSpots {
+    FLUSH_SAVE_SETUP,
+    FLUSH_SAVE_ITER,
+    FLUSH_DIRTY_BLOCK,
+    FLUSH_SAVE_COMPLETE,
+
+    FLUSH_LOAD_POSTCOPY_EOS,
+    FLUSH_LOAD_POSTCOPY_FLUSH,
+    FLUSH_LOAD_PRECOPY_EOS,
+    FLUSH_LOAD_PRECOPY_FLUSH,
+};
+
+static int ram_multifd_flush(QEMUFile *f, enum RamMultifdFlushSpots spot)
+{
+    int ret;
+    bool always_flush, do_local_flush, do_remote_flush;
+    bool mapped_ram = migrate_mapped_ram();
+
+    if (!migrate_multifd()) {
+        return 0;
+    }
+
+    /*
+     * For backward compatibility, whether to flush multifd after each
+     * section is sent. This is mutually exclusive with a
+     * RAM_SAVE_FLAG_MULTIFD_FLUSH on the stream
+     */
+    always_flush = migrate_multifd_flush_after_each_section();
+
+    /*
+     * Save side flushes
+     */
+
+    do_local_flush = false;
+
+    switch (spot) {
+    case FLUSH_SAVE_SETUP:
+        assert(!bql_locked());
+        do_local_flush = true;
+        break;
+
+    case FLUSH_SAVE_ITER:
+        /*
+         * This flush is not necessary, only do for backward
+         * compatibility. Mapped-ram assumes the new scheme.
+         */
+        do_local_flush = always_flush && !mapped_ram;
+        break;
+
+    case FLUSH_DIRTY_BLOCK:
+        /*
+         * This is the flush that's actually required, always do it
+         * unless we're emulating the old behavior.
+         */
+        do_local_flush = !always_flush || mapped_ram;
+        break;
+
+    case FLUSH_SAVE_COMPLETE:
+        do_local_flush = true;
+        break;
+
+    default:
+        break;
+    }
+
+    if (do_local_flush) {
+        ret = multifd_ram_flush_and_sync();
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    /*
+     * There's never a remote flush with mapped-ram because any flags
+     * put on the stream (aside from RAM_SAVE_FLAG_MEM_SIZE and
+     * RAM_SAVE_FLAG_EOS) break mapped-ram's assumption that ram pages
+     * can be read contiguously from the stream.
+     *
+     * On the recv side, there's no local flush, even at EOS because
+     * mapped-ram does its own flush after loading the ramblock.
+     */
+    if (mapped_ram) {
+        return 0;
+    }
+
+    do_remote_flush = false;
+
+    /* Save side remote flush */
+    switch (spot) {
+    case FLUSH_SAVE_SETUP:
+        do_remote_flush = !always_flush;
+        break;
+
+    case FLUSH_SAVE_ITER:
+        do_remote_flush = false;
+        break;
+
+    case FLUSH_DIRTY_BLOCK:
+        do_remote_flush = do_local_flush;
+        break;
+
+    case FLUSH_SAVE_COMPLETE:
+        do_remote_flush = false;
+        break;
+
+    default:
+        break;
+    }
+
+    /* Put a flag on the stream to trigger a remote flush */
+    if (do_remote_flush) {
+        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+        qemu_fflush(f);
+    }
+
+    /*
+     * Load side flushes.
+     */
+
+    do_local_flush = false;
+
+    switch (spot) {
+    case FLUSH_LOAD_PRECOPY_EOS:
+    case FLUSH_LOAD_POSTCOPY_EOS:
+        do_local_flush = always_flush;
+        break;
+
+    case FLUSH_LOAD_PRECOPY_FLUSH:
+    case FLUSH_LOAD_POSTCOPY_FLUSH:
+        do_local_flush = true;
+        break;
+
+    default:
+        break;
+    }
+
+    if (do_local_flush) {
+        multifd_recv_sync_main();
+    }
+
+    return 0;
+}
+
 static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
 {
     if (!multifd_queue_page(block, offset)) {
@@ -1323,19 +1466,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (migrate_multifd() &&
-                (!migrate_multifd_flush_after_each_section() ||
-                 migrate_mapped_ram())) {
-                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_ram_flush_and_sync();
-                if (ret < 0) {
-                    return ret;
-                }
-
-                if (!migrate_mapped_ram()) {
-                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-                    qemu_fflush(f);
-                }
+            int ret = ram_multifd_flush(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel,
+                                        FLUSH_DIRTY_BLOCK);
+            if (ret < 0) {
+                return ret;
             }
 
             /* Hit the end of the list */
@@ -3065,18 +3199,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     bql_unlock();
-    ret = multifd_ram_flush_and_sync();
+    ret = ram_multifd_flush(f, FLUSH_SAVE_SETUP);
     bql_lock();
     if (ret < 0) {
         error_setg(errp, "%s: multifd synchronization failed", __func__);
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
-        && !migrate_mapped_ram()) {
-        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-    }
-
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ret = qemu_fflush(f);
     if (ret < 0) {
@@ -3209,12 +3338,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
 out:
     if (ret >= 0 && migration_is_running()) {
-        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
-            !migrate_mapped_ram()) {
-            ret = multifd_ram_flush_and_sync();
-            if (ret < 0) {
-                return ret;
-            }
+
+        ret = ram_multifd_flush(f, FLUSH_SAVE_ITER);
+        if (ret < 0) {
+            return ret;
         }
 
         qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
@@ -3283,7 +3410,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_ram_flush_and_sync();
+    ret = ram_multifd_flush(f, FLUSH_SAVE_COMPLETE);
     if (ret < 0) {
         return ret;
     }
@@ -3797,14 +3924,11 @@ int ram_load_postcopy(QEMUFile *f, int channel)
             }
             break;
         case RAM_SAVE_FLAG_MULTIFD_FLUSH:
-            multifd_recv_sync_main();
+            ram_multifd_flush(f, FLUSH_LOAD_POSTCOPY_FLUSH);
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
-            if (migrate_multifd() &&
-                migrate_multifd_flush_after_each_section()) {
-                multifd_recv_sync_main();
-            }
+            ram_multifd_flush(f, FLUSH_LOAD_POSTCOPY_EOS);
             break;
         default:
             error_report("Unknown combination of migration flags: 0x%x"
@@ -4237,19 +4361,11 @@ static int ram_load_precopy(QEMUFile *f)
             }
             break;
         case RAM_SAVE_FLAG_MULTIFD_FLUSH:
-            multifd_recv_sync_main();
+            ram_multifd_flush(f, FLUSH_LOAD_PRECOPY_FLUSH);
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
-            if (migrate_multifd() &&
-                migrate_multifd_flush_after_each_section() &&
-                /*
-                 * Mapped-ram migration flushes once and for all after
-                 * parsing ramblocks. Always ignore EOS for it.
-                 */
-                !migrate_mapped_ram()) {
-                multifd_recv_sync_main();
-            }
+            ram_multifd_flush(f, FLUSH_LOAD_PRECOPY_EOS);
             break;
         case RAM_SAVE_FLAG_HOOK:
             ret = rdma_registration_handle(f);
-- 
2.35.3


