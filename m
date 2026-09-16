Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6386C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uL0-0005VY-Ik; Wed, 16 Sep 2026 14:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6uJy-0005Rr-TE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:25:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6uJw-0007jR-W7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:25:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 12B541FEEE;
 Wed, 16 Sep 2026 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789583115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oE0hIo5jZf8VCGn9Wb6Vg7pw7T401l6C8ASv97kwSKo=;
 b=ok3ammhry7ch3JuhWsZx3z1kp7Ag+6c8U6JDZlL7GJMjl+D0TlblGM7Lg+2rUan1Ybt0nU
 KSfusnHtAzYK0+QPjvHA2yky7kbjvAsrAmk7iqt4rHsTEqx2GvmHyXFgBVnn/qsMVyiAsY
 x1UhZfjgxSaOQaPKXnmoMDXW8Ei96AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789583115;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oE0hIo5jZf8VCGn9Wb6Vg7pw7T401l6C8ASv97kwSKo=;
 b=MOy5SD7HAfTLRzvyPjAJGg3KnmihqghEZeFMOS/rZnn0egOcle/x2kyS8oFsWINDOg9wJo
 FOAsZWRIZLsHI1Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789583111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oE0hIo5jZf8VCGn9Wb6Vg7pw7T401l6C8ASv97kwSKo=;
 b=tQNdKNGwLrHnJCtSVoZJFuvRlFLZCxu5zgi/TfbNHBdPBBvte9MAV7nMSDKOtLMai/vmLn
 yVnNfBM8peKVUgM+mJ6IyEcAjSzRYl81gm31wgCqzywToobm+JFW3Uiya/yV/K3i8LwxkV
 TSNkaFdwrDlqK3OlIVWFZiShkS4YjIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789583111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oE0hIo5jZf8VCGn9Wb6Vg7pw7T401l6C8ASv97kwSKo=;
 b=v9jMA1/HaFbPDAeDN/0mbKhzci9Sqs3hp8hFRW3606epIFTHewMjIZ/bzkb/fdqDJ8/yS0
 ka9coCgMVe0qRJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 891C0136A5;
 Wed, 16 Sep 2026 18:25:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qq7VCwbfqmrFWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Sep 2026 18:25:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Mark Kanda <mark.kanda@oracle.com>, Ben
 Chaney <bchaney@akamai.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
In-Reply-To: <20260916132428.1628553-1-den@openvz.org>
References: <20260916132428.1628553-1-den@openvz.org>
Date: Wed, 16 Sep 2026 15:25:04 -0300
Message-ID: <87y0d1rr3z.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email, akamai.com:email, suse.de:mid,
 suse.de:email, openvz.org:email, imap1.dmz-prg2.suse.org:helo]
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

"Denis V. Lunev" <den@openvz.org> writes:

> From: Denis V. Lunev <den@openvz.org>
>
> The cpr state is a process wide registry of the resources that have to
> survive an exec. Entries are added and dropped from realize and teardown
> paths all over the tree, and a caller has no way to tell which thread the
> next caller will run in.
>
> The state carries no serialization of its own. It is safe today only
> because its callers happen to hold the BQL, and that is a property of
> where those callers live rather than anything the interface promises or
> checks. A caller that is correct within its own subsystem can therefore
> break this one from a distance: two that overlap corrupt the registry,
> and the next lookup walks an entry that has already been freed.
>
> Give the state a lock of its own instead of relying on that. Entries
> move when a device is realized, when a resource is handed over, and when
> a migration starts, so none of this is on a hot path and an uncontended
> mutex costs nothing.
>
> Take the lock in every accessor and across the save and load walks.
> Holding it over the walk callbacks is safe because none of them comes
> back through this interface. State that is not reached through these
> accessors, such as the VFIO device list that hw/vfio manipulates
> directly, stays outside it.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Cc: Ben Chaney <bchaney@akamai.com>
> Cc: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/cpr.c | 59 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 10 deletions(-)
>
> diff --git a/migration/cpr.c b/migration/cpr.c
> index bca43e9bf3..503057e262 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -9,6 +9,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "qemu/lockable.h"
>  #include "hw/vfio/vfio-cpr.h"
>  #include "migration/cpr.h"
>  #include "migration/misc.h"
> @@ -26,6 +27,14 @@
>  CprState cpr_state;
>  static GHashTable *cpr_fds_hash;
>  
> +/* Callers are spread across the tree and need not share a thread. */
> +static QemuMutex cpr_fds_lock;
> +
> +static void __attribute__((constructor)) cpr_fds_lock_init(void)
> +{
> +    qemu_mutex_init(&cpr_fds_lock);
> +}
> +
>  /****************************************************************************/
>  
>  typedef struct CprFd {
> @@ -94,6 +103,8 @@ static int cpr_fd_pre_save(void *opaque)
>      GHashTableIter iter;
>      CprFd *elem;
>  
> +    QEMU_LOCK_GUARD(&cpr_fds_lock);
> +
>      QLIST_INIT(&state->fds);
>  
>      g_hash_table_iter_init(&iter, get_cpr_fds_hash());
> @@ -109,6 +120,8 @@ static int cpr_fd_post_load(void *opaque, int version_id)
>      CprState *state = (CprState *)opaque;
>      CprFd *elem;
>  
> +    QEMU_LOCK_GUARD(&cpr_fds_lock);
> +
>      while ((elem = QLIST_FIRST(&state->fds))) {
>          QLIST_REMOVE(elem, next);
>  
> @@ -127,7 +140,7 @@ static int cpr_fd_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> -void cpr_save_fd(const char *name, int id, int fd)
> +static void do_cpr_save_fd(const char *name, int id, int fd)
>  {
>      CprFd *elem = g_new0(CprFd, 1);
>  
> @@ -139,6 +152,13 @@ void cpr_save_fd(const char *name, int id, int fd)
>      cpr_fd_hash_insert(elem);
>  }
>  
> +void cpr_save_fd(const char *name, int id, int fd)
> +{
> +    QEMU_LOCK_GUARD(&cpr_fds_lock);
> +
> +    do_cpr_save_fd(name, id, fd);
> +}
> +
>  static CprFd *find_fd(const char *name, int id)
>  {
>      CprFd key = {
> @@ -149,6 +169,15 @@ static CprFd *find_fd(const char *name, int id)
>      return g_hash_table_lookup(get_cpr_fds_hash(), &key);
>  }
>  
> +static int do_cpr_find_fd(const char *name, int id)
> +{
> +    CprFd *elem = find_fd(name, id);
> +    int fd = elem ? elem->fd : -1;
> +
> +    trace_cpr_find_fd(name, id, fd);
> +    return fd;
> +}
> +
>  void cpr_delete_fd(const char *name, int id)
>  {
>      CprFd key = {
> @@ -156,6 +185,8 @@ void cpr_delete_fd(const char *name, int id)
>          .id = id,
>      };
>  
> +    QEMU_LOCK_GUARD(&cpr_fds_lock);
> +
>      g_hash_table_remove(get_cpr_fds_hash(), &key);
>  
>      trace_cpr_delete_fd(name, id);
> @@ -163,20 +194,23 @@ void cpr_delete_fd(const char *name, int id)
>  
>  int cpr_find_fd(const char *name, int id)
>  {
> -    CprFd *elem = find_fd(name, id);
> -    int fd = elem ? elem->fd : -1;
> +    QEMU_LOCK_GUARD(&cpr_fds_lock);
>  
> -    trace_cpr_find_fd(name, id, fd);
> -    return fd;
> +    return do_cpr_find_fd(name, id);
>  }
>  
>  void cpr_resave_fd(const char *name, int id, int fd)
>  {
> -    CprFd *elem = find_fd(name, id);
> -    int old_fd = elem ? elem->fd : -1;
> +    CprFd *elem;
> +    int old_fd;
> +
> +    QEMU_LOCK_GUARD(&cpr_fds_lock);
> +
> +    elem = find_fd(name, id);
> +    old_fd = elem ? elem->fd : -1;
>  
>      if (old_fd < 0) {
> -        cpr_save_fd(name, id, fd);
> +        do_cpr_save_fd(name, id, fd);
>      } else if (old_fd != fd) {
>          error_report("internal error: cpr fd '%s' id %d value %d "
>                       "already saved with a different value %d",
> @@ -188,12 +222,15 @@ void cpr_resave_fd(const char *name, int id, int fd)
>  int cpr_open_fd(const char *path, int flags, const char *name, int id,
>                  Error **errp)
>  {
> -    int fd = cpr_find_fd(name, id);
> +    int fd;
>  
> +    QEMU_LOCK_GUARD(&cpr_fds_lock);
> +
> +    fd = do_cpr_find_fd(name, id);
>      if (fd < 0) {
>          fd = qemu_open(path, flags, errp);
>          if (fd >= 0) {
> -            cpr_save_fd(name, id, fd);
> +            do_cpr_save_fd(name, id, fd);
>          }
>      }
>      return fd;
> @@ -204,6 +241,8 @@ bool cpr_walk_fd(cpr_walk_fd_cb cb)
>      GHashTableIter iter;
>      CprFd *elem;
>  
> +    QEMU_LOCK_GUARD(&cpr_fds_lock);
> +
>      g_hash_table_iter_init(&iter, get_cpr_fds_hash());
>      while (g_hash_table_iter_next(&iter, (gpointer *)&elem, NULL)) {
>          g_assert(elem->fd >= 0);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

