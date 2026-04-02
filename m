Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A411ED3942C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8IkL-0006BJ-RG; Thu, 02 Apr 2026 10:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8IkK-000682-0v
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8IkI-0006lM-4r
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 10:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775139004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2vBrRe5aRe6cex++EO//d2YeXQEmpoUBS3WyOxwxXFU=;
 b=BvRjcZ6glLEXRmuJlONmA70cHI2DD0EWOKPz5c/yYYmu7k4zt/4mvItJ/NDoZvKcxVsi/M
 HRUxOsQW3ZoKJnZEvdM1WsGMrzFuPdWGmnyQeoduFHGY/VqgIQHiuYMwksUgIXSJ0m62+Z
 UDxx+M4Q6DLjWIgyYjn2EOZC3KKAEDw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14--fVdJIpeNjGMLC4JzdN4eA-1; Thu, 02 Apr 2026 10:10:01 -0400
X-MC-Unique: -fVdJIpeNjGMLC4JzdN4eA-1
X-Mimecast-MFC-AGG-ID: -fVdJIpeNjGMLC4JzdN4eA_1775139001
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a5f6110cadso21841656d6.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775139001; x=1775743801; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2vBrRe5aRe6cex++EO//d2YeXQEmpoUBS3WyOxwxXFU=;
 b=sKh4Vdxet0WHfEzfZtKfKu39yjz938tsAZrYazcndLLK77m51jaht/yMRFA/7r8o60
 W0aMpHhujkTCHkZrXMggEglipbeZAae7gtyNp0KriwtqAelotlHXvww0oV9wBGc4O+fK
 3vaDM/iqRdCFCHw0ngcFqK1q0lUbAlNLhtKB8OjOnyqv4ZW/G0/UqectcJF4kjSyQ4Za
 60Q7PTzqhjYuzn4xIEF4PUcFvpdsG/Y4gQHWZQ5AzZ0VBUknJzukhGThMkKvCf7BTIfL
 1yLuCut7axHs9S9y8YwogWroJFiD4UxHu9O3rM+GuJqvSog7AL60pq6Lq9SeSCp7F4hn
 Xzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775139001; x=1775743801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vBrRe5aRe6cex++EO//d2YeXQEmpoUBS3WyOxwxXFU=;
 b=BdCMXx+viX6W/BkYYNqY4jDQ/VHXb2X5QRBDTyh22NCzs0Y50H8LByf9mToKIzRbN6
 KDMmeaz4xnJBoa1nec71DicnSEfTA6sKlJSMoHhyraDiWM23rgHRecZK4ErGYBDTNTE6
 v32DDo6knI9rGx642Tsw6EJyyFTlnSOlCK9IXuZHhy4ltcBYHFlDrOVRKyOmgjewOqh6
 ZUfMneOnos4PAgHtTZyHqO+DNxrtx6AxnM178oytWf9KpA5VclF4cdJfA3zBP1bjTTaY
 lcoGz0qZU0jOKK8YgFEF2L5wQdJ7EaeEBB6dLcN8bMAxgoBKdjCIBUe6RGpv14/clyVY
 V7nA==
X-Gm-Message-State: AOJu0YxbfqymX2ToYpfM0AIHlmYmXrq1aogUDA2Ism1NRzGW1dndWD1r
 uimq+A1EpgafoTCWeSwM+JBE66IiqxbDDHlWILxQsz30p9mEDec3tW5RU6U+80vSgiuan+yB2zO
 xfeY+U2YldcvhCYwJVSpE01j7nQngwdoiOdzvuYbclyegudXmU+og4GX4
X-Gm-Gg: AeBDieueunMFPx/UzECOIEDX64Dk/VzUjyYRQtn3xy36Ug9VQQvRNxRw2SPf8Y/9WG5
 7bLPD12AhzGRTnkuTp9wv1gnY6YAeYSDz8EX8dWJ9uscmGk0TFOfh9YqOny3B5aUddgy49kF/kQ
 qtdWyv4eszepT+KtZ+2QSmKB4B4VNTFvnS585YIY8b8Cs+AuMzMqs4RKtaM5vHNeds3FNXIuu7h
 t0B5tH/qy6+1tB9MYEBXxCDqTZ1VVp/D9IkYe+jSKjpy8mXVMlM8ngz8buRYwM79GQWvA2YSN9u
 hIDZAU2XkYJ7xppjZQMm1ri8KGcVY9+67kYPw7luaHsi7awG548dZX44TjU+Fle3ClMfHoennGK
 BADe/Q7mz6AO69eBnD84+80HGEdqAkSqYdhcG3ywFZb7xMw==
X-Received: by 2002:a05:6214:212b:b0:89c:ed49:496f with SMTP id
 6a1803df08f44-8a43810b774mr112737236d6.23.1775139000379; 
 Thu, 02 Apr 2026 07:10:00 -0700 (PDT)
X-Received: by 2002:a05:6214:212b:b0:89c:ed49:496f with SMTP id
 6a1803df08f44-8a43810b774mr112736456d6.23.1775138999706; 
 Thu, 02 Apr 2026 07:09:59 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a597acf5dbsm23310286d6.49.2026.04.02.07.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 07:09:58 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:09:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <ac54tN39eq0Rv6T4@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
 <82b40877-482e-4dbe-add1-6e0cc4292ae7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82b40877-482e-4dbe-add1-6e0cc4292ae7@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 25, 2026 at 06:54:58PM +0200, Avihai Horon wrote:
> 
> On 3/20/2026 1:12 AM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Allow modules to report data that can only be migrated after VM is stopped.
> > 
> > When this concept is introduced, we will need to account stopcopy size to
> > be part of pending_size as before.
> > 
> > One thing to mention is, when there can be stopcopy size, it means the old
> > "pending_size" may not always be able to reach low enough to kickoff an
> > slow version of query sync.  While it used to be almost guaranteed to
> > happen because if we keep iterating, normally pending_size can go to zero
> > for precopy-only because we assume everything reported can be migrated in
> > precopy phase.
> > 
> > So we need to make sure QEMU will kickoff a synchronized version of query
> > pending when all precopy data is migrated too.  This might be important to
> > VFIO to keep making progress even if the downtime cannot yet be satisfied.
> > 
> > So far, this patch should introduce no functional change, as no module yet
> > report stopcopy size.
> > 
> > This will pave way for VFIO to properly report its pending data sizes,
> > which was actually buggy today.  Will be done in follow up patches.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/migration/register.h | 12 +++++++++
> >   migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
> >   migration/savevm.c           |  7 +++--
> >   migration/trace-events       |  2 +-
> >   4 files changed, 62 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/migration/register.h b/include/migration/register.h
> > index 2320c3a981..3824958ba5 100644
> > --- a/include/migration/register.h
> > +++ b/include/migration/register.h
> > @@ -17,12 +17,24 @@
> >   #include "hw/core/vmstate-if.h"
> > 
> >   typedef struct MigPendingData {
> > +    /*
> > +     * Modules can only update these fields in a query request via its
> > +     * save_query_pending() API.
> > +     */
> 
> Move comment to patch #5?
> 
> >       /* How many bytes are pending for precopy / stopcopy? */
> >       uint64_t precopy_bytes;
> >       /* How many bytes are pending that can be transferred in postcopy? */
> >       uint64_t postcopy_bytes;
> > +    /* How many bytes that can only be transferred when VM stopped? */
> > +    uint64_t stopcopy_bytes;
> 
> Keep consistent phrasing?
> 
> /* Amount of pending bytes that can be transferred either in precopy or
> stopcopy */
> uint64_t precopy_bytes;
> /* Amount of pending bytes that can be transferred in postcopy */
> uint64_t postcopy_bytes;
> /* Amount of pending bytes that can be transferred only in stopcopy */
> uint64_t stopcopy_bytes;
> 
> > +
> > +    /*
> > +     * Modules should never update these fields.
> > +     */
> 
> Move comment to patch #5?

Sure, I'll address all above.

> 
> >       /* Is this a fastpath query (which can be inaccurate)? */
> >       bool fastpath;
> > +    /* Total pending data */
> > +    uint64_t total_bytes;
> >   } MigPendingData ;
> > 
> >   /**
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 99c4d09000..42facb16d1 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3198,6 +3198,44 @@ typedef enum {
> >       MIG_ITERATE_BREAK,          /* Break the loop */
> >   } MigIterateState;
> > 
> > +/* Are we ready to move to the next iteration phase? */
> > +static bool migration_iteration_next_ready(MigrationState *s,
> > +                                           MigPendingData *pending)
> > +{
> > +    /*
> > +     * If the estimated values already suggest us to switchover, mark this
> > +     * iteration finished, time to do a slow sync.
> > +     */
> > +    if (pending->total_bytes <= s->threshold_size) {
> > +        return true;
> > +    }
> > +
> > +    /*
> > +     * Since we may have modules reporting stop-only data, we also want to
> > +     * re-query with slow mode if all precopy data is moved over.  This
> > +     * will also mark the current iteration done.
> > +     *
> > +     * This could happen when e.g. a module (like, VFIO) reports stopcopy
> > +     * size too large so it will never yet satisfy the downtime with the
> > +     * current setup (above check).  Here, slow version of re-query helps
> > +     * because we keep trying the best to move whatever we have.
> > +     */
> > +    if (pending->precopy_bytes == 0) {
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > +static void migration_iteration_go_next(MigPendingData *pending)
> > +{
> > +    /*
> > +     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> > +     * into the core layer.
> > +     */
> > +    qemu_savevm_query_pending(pending, false);
> > +}
> 
> I think the iteration terminology here could be confusing, because these two
> functions are called from migration_iteration_run() and they don't refer to
> the same iteration concept.
> How about migration_pass_next_ready/migration_pass_go_next?
> Or migration_dirty_sync_ready/migration_dirty_sync?

I get the confusion, but IIUC the word "iteration" normally was used to
describe one full walk of system resources, introducing "pass" may causing
another way of confusion to me.

E.g. see Dan's post in 2016 and since then iteration was defined as so:

https://www.berrange.com/posts/2016/05/12/analysis-of-techniques-for-ensuring-migration-completion-with-kvm/

Here, migration_iteration_run() was named to say "run the current
iteration", but it doesn't necessarily mean it can only be run once for the
current iteration.

OTOH, I don't think it makes much sense we define "iteration" (or any new
term at all) to be one run of migration_iteration_run(): currently, we
invoke handlers' savevm iterator hook for each migration_iteration_run(),
but that's pretty random behavior..

For RAM, that's MAX_WAIT.  For VFIO, it's something else...

It was still a "grey area" and no way to define, even if we may want to
define it at some point to make each iterator to follow some rule.

Comparing to that, iteration to be defined to describe one round of walk
for all VM resources makes a lot of sense and it's a criticla concept for
precopy.

Thanks,

-- 
Peter Xu


