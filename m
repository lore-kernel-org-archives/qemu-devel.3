Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53BEFF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABQt-0002f3-Q1; Tue, 07 Apr 2026 14:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wABQr-0002am-RM
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAAPz-0005WG-HP
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 13:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775583649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3c620ThYvqk2MMVvCa7pZKSOudeZKs5vvRFPxcF+wc=;
 b=VIwMu/SV73blZP7IhADuSbEJQMLGxh9CVNZYKkKuM/tc/zOxEmazTnArV7ZERVb9GHdg8h
 a3nAx4B8caxFDYZq9sozIJoDMWgX1SrEDU0FOCovABMLk8sLRZjuCfbkLD1lKzQiVvzI4P
 uHH0V5GHDCrP+5Q7hTOlTQdEiDPscZ8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Mo09d39gOXeli3uNWtv-Cw-1; Tue, 07 Apr 2026 13:40:48 -0400
X-MC-Unique: Mo09d39gOXeli3uNWtv-Cw-1
X-Mimecast-MFC-AGG-ID: Mo09d39gOXeli3uNWtv-Cw_1775583648
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8d5b5d607d1so758467585a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775583648; x=1776188448; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l3c620ThYvqk2MMVvCa7pZKSOudeZKs5vvRFPxcF+wc=;
 b=RB+lwnCx8xXa3CsPooghcSk9rBH0ZQfl4AbtWuP2A762RRCUiJoMT5G+ugKzwjsrts
 rNHxUn2nLlhq50EJN5L3BQsvz9ToDY1AbxNR9aGS3fT8C2ruDApzalaIh4yGTECq/ITF
 TqhEoq6KrV36izBskCvTQwFVc+LUPTjMY3GAMvgROkP51iOQhgmnDVAKv6b0e660lioI
 7//cXk4mN/B+fkkZ/cb7fPay0Yo3J2valCMqxeXKg3AkSeXT9wBoL0TzPrsjbW+hKErO
 ZSa+dDFqTRSpc+c68zcuPAfIlTfanH/nRJueb72wfAgmsC39VRPrOKKxwtAPaghUAEzR
 XKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775583648; x=1776188448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3c620ThYvqk2MMVvCa7pZKSOudeZKs5vvRFPxcF+wc=;
 b=oaKvqKor6cTo4BOJNw935V9IzNQ/lGVLnWTondueLxfcB5PnrpQ3mhrRUQS3+Uc8sU
 NL49SoOzXotDrnal9f7Yv4tsZkVhDrxtGs5egFEq1e2DsHOawVtMPTiM9NlSH054Jz8E
 zEMasKNsqjefGhUdetIaJBWcfcIb2WqO3M8lkc6o3IZTbD8hxbYhXa31u6SIfBgLkJVa
 6qG3MAFFOlJiA/aUEaGdFeRYx5KLXvRkU42wQPsdeY3aRrse7/f8U7g4wj/6h3dszGM+
 jyeWkjekj8mKV4iR0Gmrn/EtzgIdHbTnYmfWPTSFf5HlIQcD2DL5OBBcYbXGOKpUpNK1
 onTw==
X-Gm-Message-State: AOJu0Yy/7oPwtQkR4SJUuxFZySmoO1OLwVUEQ5tG1dAXMuCOTzeeq2JR
 g1NgzIncQBhX7+3+j3fOayK8O1S7dLNCHfTlxw8feXij/mm13ZYl0t4vJWVMUTVTfDZJ+8vjiZu
 +bKlLZL4Ia/s2tqrSUphOfa/qRRmp9kRKidBXyhtAUCAxeem0rRLQfUpB
X-Gm-Gg: AeBDiet1o906Zcx7z7RX/EW4wVbt2OUo5w+WxdOmntx9Qi6wGgf5CagSTU4RwORhqeA
 Bw0QT5PL/dBTfKyktH7cPgOGK83YkBbkqblC0jYYVIVu+MZjRC3ibRbDdUrR2z0RXAgZjS+CAOi
 Cgc5n5sQixGj427aeM4yBJBRfgtMetFTjcPO66S52EJaF6Q4N4buEnsx2F+xB9jos+bWHMMs0Tg
 d+DOcHYOsHnVIZBwsuQ4cT0t05a+f3tBpcFc/tgf/dHEGmgdEhPy6Squp/hvodl+J+AGVuqlYKB
 iITpqSxgU9L40Nrs2AYH3YRP4LpK1U0AhE6ChK6TBvvKnZUPDU/272WcHOqkhYkT5MA5iBKXQRx
 PaxBlP8LBKKQu/FTTrm4LQ318lO4dYV8mTw0LMG4BYxBcJ8E=
X-Received: by 2002:a05:620a:29cd:b0:8cd:8751:2b26 with SMTP id
 af79cd13be357-8d41b8d6a77mr2467158585a.58.1775583647600; 
 Tue, 07 Apr 2026 10:40:47 -0700 (PDT)
X-Received: by 2002:a05:620a:29cd:b0:8cd:8751:2b26 with SMTP id
 af79cd13be357-8d41b8d6a77mr2467150485a.58.1775583646728; 
 Tue, 07 Apr 2026 10:40:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5488a28sm1354566585a.2.2026.04.07.10.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 10:40:46 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:40:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 12/12] migration: Fix calculation of
 expected_downtime to take VFIO info
Message-ID: <adVBnO8enyTA5DO5@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-13-peterx@redhat.com>
 <CAE8KmOxeDSWnK9k0fSEs236qkgdARjPP__GjUzZHg6xozyJL+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOxeDSWnK9k0fSEs236qkgdARjPP__GjUzZHg6xozyJL+A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 23, 2026 at 05:35:32PM +0530, Prasad Pandit wrote:
> On Fri, 20 Mar 2026 at 04:46, Peter Xu <peterx@redhat.com> wrote:
> > QEMU will provide an expected downtime for the whole system during
> > migration, by remembering the total dirty RAM that we synced the last time,
> > divides the estimated switchover bandwidth.
> 
> * ie. Total dirty RAM synced / estimated bandwidth? If so, divides -> divided by
> 
> > That was flawed when VFIO is taking into account: consider there is a VFIO
> > GPU device that contains GBs of data to migrate during stop phase.  Those
> > will not be accounted in this math.
> >
> > Fix it by updating dirty_bytes_last_sync properly only when we go to the
> > next iteration, rather than hide this update in the RAM code.  Meanwhile,
> > fetch the total (rather than RAM-only) portion of dirty bytes, so as to
> > include GPU device states too.
> >
> > Update the comment of the field to reflect its new meaning.
> >
> > Now after this change, the expected-downtime to be read from query-migrate
> > should be very accurate even with VFIO devices involved.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration-stats.h | 10 +++++-----
> >  migration/migration.c       | 11 ++++++++---
> >  migration/ram.c             |  1 -
> >  3 files changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> > index 326ddb0088..14b2773beb 100644
> > --- a/migration/migration-stats.h
> > +++ b/migration/migration-stats.h
> > @@ -31,11 +31,11 @@
> >   */
> >  typedef struct {
> >      /*
> > -     * Number of bytes that were dirty last time that we synced with
> > -     * the guest memory.  We use that to calculate the downtime.  As
> > -     * the remaining dirty amounts to what we know that is still dirty
> > -     * since last iteration, not counting what the guest has dirtied
> > -     * since we synchronized bitmaps.
> > +     * Number of bytes that are still dirty after the last whole-system
> > +     * sync on dirty information.  We use that to calculate the expected
> > +     * downtime.  As the remaining dirty amounts to what we know that is
> > +     * still dirty since last iteration, not counting what the guest has
> > +     * dirtied since then on either RAM or device states.
> >       */
> 
> * Multiple uses of dirty is making it rather unclear. (any funny)
> 
> * May be:
>      Number of bytes pending since the last full-system accounting
>      of the dirty bytes' information. We use this number to calculate
>      the expected downtime. The pending bytes do not account for
>      the new bytes the guest may have written since the last update
>      of the dirty bytes' information.

I didn't change the rest except the scope of sync.  I'll simplify this
section to below:

    /*
     * Number of bytes that were reported dirty after the lastest
     * system-wise synchronization on dirty information.  It is used to
     * do best-effort estimation on expected downtime.
     */

> 
> >      uint64_t dirty_bytes_last_sync;
> >      /*
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 23c78b3a2c..1c00572d14 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3240,18 +3240,23 @@ static void migration_iteration_go_next(MigPendingData *pending)
> >       */
> >      qemu_savevm_query_pending(pending, false);
> >
> > +    /*
> > +     * Update the dirty information for the whole system for this
> 
> * dirty bytes' information

I prefer dirty information, because it may not always be about bytes,
e.g. bitmaps are in number of pages.

> 
> > +     * iteration.  This value is used to calculate expected downtime.
> > +     */
> > +    qatomic_set(&mig_stats.dirty_bytes_last_sync, pending->total_bytes);
> > +
> >      /*
> >       * Boost dirty sync count to reflect we finished one iteration.
> >       *
> >       * NOTE: we need to make sure when this happens (together with the
> >       * event sent below) all modules have slow-synced the pending data
> > -     * above.  That means a write mem barrier, but qatomic_add() should be
> > -     * enough.
> > +     * above and updated corresponding fields (e.g. dirty_bytes_last_sync).
> >       *
> >       * It's because a mgmt could wait on the iteration event to query again
> >       * on pending data for policy changes (e.g. downtime adjustments).  The
> >       * ordering will make sure the query will fetch the latest results from
> > -     * all the modules.
> > +     * all the modules on everything.
> >       */
> >      qatomic_add(&mig_stats.dirty_sync_count, 1);
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 29e9608715..1bdf121d16 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1148,7 +1148,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
> >              RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >                  ramblock_sync_dirty_bitmap(rs, block);
> >              }
> > -            qatomic_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
> 
> * Shouldn't the ram_bytes_remaining() go into pending->total_bytes
> here? ie pending->total_bytes += ram_bytes_remaining()

It's included via qemu_savevm_query_pending().

Thanks,

-- 
Peter Xu


