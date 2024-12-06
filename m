Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6D3E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZAh-00075i-4i; Fri, 06 Dec 2024 09:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZAg-00075X-2l
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:19:06 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZAe-0007Hx-5P
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:19:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DE781F37E;
 Fri,  6 Dec 2024 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733494742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwKMMeqb6McDAwbFPaQtPW7rMasnfMpxj/nNcEowxQQ=;
 b=NnGMdFrohCfxfUxfR41nKwWrrP3iZiUrgMMlyPvjvE1DqFcHz2EgrzNi/FosiKjzAcatx9
 QsABgV/2ZVkhO5Y7uaz43+Ow4FKaEOipVBjrj+7MWDRz9BdIa49Gxlc1KYqKhLMDxnGucT
 PGVW4hh4X/OW+D3pptSaDv/TV8pitY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733494742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwKMMeqb6McDAwbFPaQtPW7rMasnfMpxj/nNcEowxQQ=;
 b=ZzuLy4KV1yeacEMoklVRQF4U1307p6eWHOoHw+qXNEepC74y7GCknClm5jwf15bLGW8LfF
 P5C1uyCsQ0xOQsCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733494742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwKMMeqb6McDAwbFPaQtPW7rMasnfMpxj/nNcEowxQQ=;
 b=NnGMdFrohCfxfUxfR41nKwWrrP3iZiUrgMMlyPvjvE1DqFcHz2EgrzNi/FosiKjzAcatx9
 QsABgV/2ZVkhO5Y7uaz43+Ow4FKaEOipVBjrj+7MWDRz9BdIa49Gxlc1KYqKhLMDxnGucT
 PGVW4hh4X/OW+D3pptSaDv/TV8pitY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733494742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwKMMeqb6McDAwbFPaQtPW7rMasnfMpxj/nNcEowxQQ=;
 b=ZzuLy4KV1yeacEMoklVRQF4U1307p6eWHOoHw+qXNEepC74y7GCknClm5jwf15bLGW8LfF
 P5C1uyCsQ0xOQsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEF2E138A7;
 Fri,  6 Dec 2024 14:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x9iHKNUHU2f8ZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 14:19:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Alex
 Williamson <alex.williamson@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 6/7] migration/multifd: Cleanup src flushes on
 condition check
In-Reply-To: <20241206005834.1050905-7-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-7-peterx@redhat.com>
Date: Fri, 06 Dec 2024 11:18:59 -0300
Message-ID: <87wmgcc2ss.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> The src flush condition check is over complicated, and it's getting more
> out of control if postcopy will be involved.
>
> In general, we have two modes to do the sync: legacy or modern ways.
> Legacy uses per-section flush, modern uses per-round flush.
>
> Mapped-ram always uses the modern, which is per-round.
>
> Introduce two helpers, which can greatly simplify the code, and hopefully
> make it readable again.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.h        |  2 ++
>  migration/multifd-nocomp.c | 42 ++++++++++++++++++++++++++++++++++++++
>  migration/ram.c            | 10 +++------
>  3 files changed, 47 insertions(+), 7 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index c9ae57ea02..582040922f 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -351,6 +351,8 @@ static inline uint32_t multifd_ram_page_count(void)
>  void multifd_ram_save_setup(void);
>  void multifd_ram_save_cleanup(void);
>  int multifd_ram_flush_and_sync(QEMUFile *f);
> +bool multifd_ram_sync_per_round(void);
> +bool multifd_ram_sync_per_section(void);
>  size_t multifd_ram_payload_size(void);
>  void multifd_ram_fill_packet(MultiFDSendParams *p);
>  int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index 58372db0f4..c1f686c0ce 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -344,6 +344,48 @@ retry:
>      return true;
>  }
>  
> +/*
> + * We have two modes for multifd flushes:
> + *
> + * - Per-section mode: this is the legacy way to flush, it requires one
> + *   MULTIFD_FLAG_SYNC message for each RAM_SAVE_FLAG_EOS.
> + *
> + * - Per-round mode: this is the modern way to flush, it requires one
> + *   MULTIFD_FLAG_SYNC message only for each round of RAM scan.  Normally
> + *   it's paired with a new RAM_SAVE_FLAG_MULTIFD_FLUSH message in network
> + *   based migrations.
> + *
> + * One thing to mention is mapped-ram always use the modern way to sync.
> + */
> +
> +/* Do we need a per-section multifd flush (legacy way)? */
> +bool multifd_ram_sync_per_section(void)
> +{
> +    if (!migrate_multifd()) {
> +        return false;
> +    }
> +
> +    if (migrate_mapped_ram()) {
> +        return false;
> +    }
> +
> +    return migrate_multifd_flush_after_each_section();
> +}
> +
> +/* Do we need a per-round multifd flush (modern way)? */
> +bool multifd_ram_sync_per_round(void)
> +{
> +    if (!migrate_multifd()) {
> +        return false;
> +    }
> +
> +    if (migrate_mapped_ram()) {
> +        return true;
> +    }
> +
> +    return !migrate_multifd_flush_after_each_section();
> +}
> +
>  int multifd_ram_flush_and_sync(QEMUFile *f)
>  {
>      MultiFDSyncReq req;
> diff --git a/migration/ram.c b/migration/ram.c
> index 154ff5abd4..5d4bdefe69 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1302,9 +1302,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (migrate_multifd() &&
> -                (!migrate_multifd_flush_after_each_section() ||
> -                 migrate_mapped_ram())) {
> +            if (multifd_ram_sync_per_round()) {

If we're already implicitly declaring which parts of the code mean
"round" or "section", we could fold the flush into the function and call
it unconditionally.

We don't need ram.c code to be deciding about multifd. This could be all
hidden away in the multifd-nocomp code:

-- >8 --
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index c1f686c0ce..6a7eee4c25 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -358,32 +358,26 @@ retry:
  * One thing to mention is mapped-ram always use the modern way to sync.
  */
 
-/* Do we need a per-section multifd flush (legacy way)? */
-bool multifd_ram_sync_per_section(void)
+int multifd_ram_sync_per_section(QEMUFile *f)
 {
-    if (!migrate_multifd()) {
-        return false;
+    if (!migrate_multifd() || !migrate_multifd_flush_after_each_section()) {
+        return 0;
     }
 
     if (migrate_mapped_ram()) {
-        return false;
+        return 0;
     }
 
-    return migrate_multifd_flush_after_each_section();
+    return multifd_ram_flush_and_sync(f);
 }
 
-/* Do we need a per-round multifd flush (modern way)? */
-bool multifd_ram_sync_per_round(void)
+int multifd_ram_sync_per_round(QEMUFile *f)
 {
-    if (!migrate_multifd()) {
-        return false;
+    if (!migrate_multifd() || migrate_multifd_flush_after_each_section()) {
+        return 0;
     }
 
-    if (migrate_mapped_ram()) {
-        return true;
-    }
-
-    return !migrate_multifd_flush_after_each_section();
+    return multifd_ram_flush_and_sync(f);
 }
 
 int multifd_ram_flush_and_sync(QEMUFile *f)
diff --git a/migration/multifd.h b/migration/multifd.h
index 582040922f..3b42128167 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -351,8 +351,8 @@ static inline uint32_t multifd_ram_page_count(void)
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(QEMUFile *f);
-bool multifd_ram_sync_per_round(void);
-bool multifd_ram_sync_per_section(void);
+int multifd_ram_sync_per_round(QEMUFile *f);
+int multifd_ram_sync_per_section(QEMUFile *f);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/ram.c b/migration/ram.c
index ddee703585..fe33c8e0e8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1302,12 +1302,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (multifd_ram_sync_per_round()) {
-                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_ram_flush_and_sync(f);
-                if (ret < 0) {
-                    return ret;
-                }
+            QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
+            int ret = multifd_ram_sync_per_round(f);
+            if (ret < 0) {
+                return ret;
             }
 
             /* Hit the end of the list */
@@ -3203,11 +3201,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
 out:
     if (ret >= 0 && migration_is_running()) {
-        if (multifd_ram_sync_per_section()) {
-            ret = multifd_ram_flush_and_sync(f);
-            if (ret < 0) {
-                return ret;
-            }
+        ret = multifd_ram_sync_per_section(f);
+        if (ret < 0) {
+            return ret;
         }
 
         qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
@@ -3276,15 +3272,13 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (multifd_ram_sync_per_section()) {
-        /*
-         * Only the old dest QEMU will need this sync, because each EOS
-         * will require one SYNC message on each channel.
-         */
-        ret = multifd_ram_flush_and_sync(f);
-        if (ret < 0) {
-            return ret;
-        }
+    /*
+     * Only the old dest QEMU will need this sync, because each EOS
+     * will require one SYNC message on each channel.
+     */
+    ret = multifd_ram_sync_per_section(f);
+    if (ret < 0) {
+        return ret;
     }
 
     if (migrate_mapped_ram()) {
-- 
2.35.3


