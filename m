Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF48010ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68Iu-0003lf-Uc; Fri, 27 Mar 2026 10:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w68It-0003kl-JN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w68Ir-0002Xt-Ke
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774622208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1KaJRkHY4Kpb4ZZERFSbOT2VSGz74fMkW4MVssCRzc=;
 b=BSWTfYwN2PeJXBkiVu/DwWtcdEPSOak8QhB2ev9A5xbMDamfr7LJgTitPa3TqXObhkWg4z
 GXxlJdIqeVvzcMobLLgRz8DOnp2QaIl0MjdbP2yIBVmuCyJB7AAkifHHOnEDvQ3QHAgQJk
 CDST3hZ5UtNnLVzqzC8N3cDRbuRSOMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-2g8tWJc_MXOu8BR_bcU0sA-1; Fri, 27 Mar 2026 10:35:42 -0400
X-MC-Unique: 2g8tWJc_MXOu8BR_bcU0sA-1
X-Mimecast-MFC-AGG-ID: 2g8tWJc_MXOu8BR_bcU0sA_1774622141
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439c54e0f6aso1538891f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774622140; x=1775226940; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n1KaJRkHY4Kpb4ZZERFSbOT2VSGz74fMkW4MVssCRzc=;
 b=jI3HB/KgD+vto9UAyIN9I3kK6tQwDXSsqF//2i2IcFQpBKvA2Rts9hl6jHa0jdVHCQ
 FxcrXKSRPLIVJZnEAlk4T9rYiNxntEbmAwqYayH78sAk8QFXNvJcHnjUW5tgc/N2Zjlz
 y/y9WEZ0OjOz+q717ky/FOyXRb11kyqazHtbX0Qa4Xnf8dD3S9IIyjDF+vmQwUmN6ii9
 K/Z+dZrrHElGaPtJgEDNhtYKiLGSqvhbXwujBmLXWwe8FprpQ7KqdjA23CnsHEsIO49Y
 pDqENzqEJNRZ5EgzYXEkdJLjcL/NJ9Yn7KvlnxWyPlGecigr3UOMKTjqreJ3y9zYN2Ya
 7xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774622140; x=1775226940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1KaJRkHY4Kpb4ZZERFSbOT2VSGz74fMkW4MVssCRzc=;
 b=LsjPlUUF9g9fcQdHpV2IOEN9uViAHXtChKqYdXgGaPynDSCQPEfi62BtemDP8UwZhn
 NdByKV4zBjbuIKxoUPrKml3a/PhHXSTufwtSPUDObF8euS0AoiPQr79k0H+J+MNa7HbP
 nP3sECfaM2ALYqrLSzUolZJN5J7AdBDVz/V19UFqwYYt44dH8/JNsk6OceeAOgIjMEEe
 FCYO9KAz88Joibcc9DF9535v0pmJn+pLp6hNmioy5m5VTOVpF8eDwLnvi+E2Oyuv4cyc
 aBGsnueDiqYKhG7Nn1IBC0mCzOX/JQHnIYhubPUdFVPcwF7BplAmd8HC1exHZrp9cPWB
 HVag==
X-Gm-Message-State: AOJu0YwGQ9Ra8uF1LPjSXRogUeSiLgLkpdxzg7dw+KZ/cHvK9mPYJhLV
 lQhTvveaMq4YLX2eEUXfXhp1Mgh6+5gcc4w/mztkhUQEN1tQIw61S+rEdR3ZWUjXNgp/YxleukS
 ICEYjk6Z28WnG6PWxMUwV3FirP2YAy4TFBcrLCLjkqNW/2RGfxJVPe6tU
X-Gm-Gg: ATEYQzywOiaeIuNChnVe8LFGKsXkyjlEenH6n07aUOSz2pi0/DdAabRquF70oCX+Gi3
 BJc+z6rp/qGXF96ipAJrkGwIGQ4X/CZU7tp1f65NUSQuXm/qUDYpfeXN7CqKZuAgiNrey7MMh1W
 zN+Y275LIZeSlz7cuY8Dl5hZxdMnv4/iB6PumveZYtflSXmBFntX6QZSu1Sa7w58qRRhcEBWMY9
 QSQyVx/pa5y2go7fxL6H1oCAi7/+j3ZdSsb3AS31vVpzTaOTiCsSlL68qjgunb+P9ueIhfsWFKB
 tZ2UeBBG5Qt0blwUR4rRLsXutagolSCJCHTd5rZfuefF5tvCU+hH57Cm8tvMEazRZZwLiNSPovx
 kAQ==
X-Received: by 2002:a05:6000:26c6:b0:43b:97d8:9a3d with SMTP id
 ffacd0b85a97d-43b9eaad57emr4212538f8f.9.1774622139766; 
 Fri, 27 Mar 2026 07:35:39 -0700 (PDT)
X-Received: by 2002:a05:6000:26c6:b0:43b:97d8:9a3d with SMTP id
 ffacd0b85a97d-43b9eaad57emr4212464f8f.9.1774622139114; 
 Fri, 27 Mar 2026 07:35:39 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9194311asm16744729f8f.10.2026.03.27.07.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 07:35:38 -0700 (PDT)
Date: Fri, 27 Mar 2026 15:35:35 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>, 
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH RFC 01/12] migration: Fix low possibility downtime
 violation
Message-ID: <acaNfFWvNAEpFsFD@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-2-peterx@redhat.com>
 <CAE8KmOyTq4wib3niowjXNfqh4TjwhcEDqUt99=mvuLs5vsSx9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOyTq4wib3niowjXNfqh4TjwhcEDqUt99=mvuLs5vsSx9A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Prasad,

On 2026-03-20 17:56, Prasad Pandit wrote:
> On Fri, 20 Mar 2026 at 04:46, Peter Xu <peterx@redhat.com> wrote:
> > When QEMU queried the estimated version of pending data and thinks it's
> > ready to converge, it'll send another accurate query to make sure of it.
> > It is needed to make sure we collect the latest reports and that equation
> > still holds true.
> >
> > However we missed one tiny little difference here on "<" v.s. "<=" when
> > comparing pending_size (A) to threshold_size (B)..
> >
> > QEMU src only re-query if A<B, but will kickoff switchover if A<=B.
> >
> > I think it means it is possible to happen if A (as an estimate only so far)
> > accidentally equals to B, then re-query won't happen and switchover will
> > proceed without considering new dirtied data.
> >
> > It turns out it was an accident in my commit 7aaa1fc072 when refactoring
> > the code around.  Fix this by using the same equation in both places.
> >
> > Fixes: 7aaa1fc072 ("migration: Rewrite the migration complete detect logic")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 5c9aaa6e58..dfc60372cf 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3242,7 +3242,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
> >           * postcopy started, so ESTIMATE should always match with EXACT
> >           * during postcopy phase.
> >           */
> > -        if (pending_size < s->threshold_size) {
> > +        if (pending_size <= s->threshold_size) {
> >              qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
> >              pending_size = must_precopy + can_postcopy;
> >              trace_migrate_pending_exact(pending_size, must_precopy,
> 
> * What is the 'size' difference between < s->threshold_size  Vs  <=
> s->threshold_size?  Going through the source IIUC
> 1) 'pending_size' is measured in Bytes.
>      static void ram_state_pending_exact/_estimate()
>          remaining_size = rs->migration_dirty_pages *
> TARGET_PAGE_SIZE(=4096 bytes);
>          100 dirty pages * 4096bytes  => 409600 dirty bytes => 409600
> * 8 => 3,276,800 dirty bits
> 
> 2) 's->threshold_size' is derived from bandwidth (100M bits/s) and
> downtime(=300 ms)
>         100,000,000 bits/s => 100,000 bits/ms
>         100,000 bits/ms * 300ms => 30,000,000 bits in 300 ms
>         30,000,000 bits / 8  =>  3,750,000 Bytes / 300 ms
>         s->threshold_size = 30,000,000 bits (= 3.75MBytes) can be
> transferred in 300ms downtime.
> 
> * Are we comparing pending_size(=409600 bytes)  <=
> s->threshold_size(=30,000,000 bits)?

While threshold_size is indeed derived from bandwidth, bandwidth is in
bytes:

    current_bytes = migration_transferred_bytes();
    transferred = current_bytes - s->iteration_initial_bytes;
    time_spent = current_time - s->iteration_start_time;
    bandwidth = (double)transferred / time_spent;

Conversion to bits only happens for the mbps statistic:

    s->mbps = (((double) transferred * 8.0) /
               ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;

> 
> *  static void migration_update_counters()
>         transferred = current_bytes - s->iteration_initial_bytes;
>         bandwidth = (double)transferred / time_spent
>         if (switchover_bw) {
>             expected_bw_per_ms = (double)switchover_bw / 1000;
>         } else {
>             expected_bw_per_ms = bandwidth;
>         }
> => ^^^^^^^  Should we divide 'bandwidth' by 1000 here (for bw_per_ms) ?

switchover_bw is expected to be in bytes/sec, however, time_spent is
already in msec, thus bandwidth is also bytes/msec, the existing code is
correct.

@Peter, not sure if it is necessary, but it could be usefull to mention
in MigrationParameters docs, that avail-switchover-bandwidth is in
bytes, not bits?

> 
>       s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();
> 
> migration_iteration_run():
>    /* Should we switch to postcopy now? */
>    if (must_precopy <= s->threshold_size &&
>       can_switchover && qatomic_read(&s->start_postcopy)) {
>       if (postcopy_start(s, &local_err)) {
>           migrate_error_propagate(s, error_copy(local_err));
>           error_report_err(local_err);
>       }
>       return MIG_ITERATE_SKIP;
>    }
> * Here we should check pending_size <= s->threshold_size,  because
> must_precopy is zero(0) when postcopy is enabled. And we switch to
> postcopy mode even when pending_size > s->threshold_size.
>   I wonder if we really need both 'must_precopy' and 'can_postcopy'
> variables, they seem to complicate things.

With devices that implement pending method, don't support postcopy, and
are not yet migrated, must_precopy would not be zero.

Both, must_precopy and can_postcopy are required, that is what allows
postcopy to switchover early. pending_size is the overall total that
includes also postcopiable data, hence why it is only used to trigger
precopy completion.

However, the majority of devices don't implement pending methods (yet)
and thus are not counted towards the estimate even if they don't support
postcopy and affect the downtime.

Wondering if VMSD devices could implement some pending estimates based
on their defined fields, this would also improve not violating the
downtime requirements.

> ===
> # virsh migrate --verbose --live --auto-converge --postcopy
> --postcopy-after-precopy f42vm
> qemu+ssh://destination-machine.com/system
> # less /var/log/libvirt/qemu/f42vm.log
> ...
> migration_iteration_run: estimated pending_size: 50577408 bytes,
> s->threshold_size: 36282361
> migration_iteration_run: estimated pending_size: 43757568 bytes,
> s->threshold_size: 36282361
> migration_iteration_run: estimated pending_size: 36413440 bytes,
> s->threshold_size: 34334680
> migration_iteration_run: estimated pending_size: 29069312 bytes,
> s->threshold_size: 34334680
> 
> migration_iteration_run: exact pending_size: 4339167232 bytes, 0,
> 4339167232              <== exact size is calculated once.
> migration_iteration_run: estimated pending_size: 4332871680 bytes,
> s->threshold_size: 35651363
> migration_iteration_run: switching to postcopy: 4332871680, 0,
> 4332871680                    <== switch to postcopy with
> must_precopy(=0) <= s->threshold_size
> 
> migration_iteration_run: estimated pending_size: 4332892160 bytes,
> s->threshold_size: 35651363
> migration_iteration_run: estimated pending_size: 4323188736 bytes,
> s->threshold_size: 27243109
> migration_iteration_run: estimated pending_size: 4315320320 bytes,
> s->threshold_size: 27243109
> migration_iteration_run: estimated pending_size: 4308221952 bytes,
> s->threshold_size: 37695433
> ===
> * Here, the exact pending_size is calculated only once, because we
> switch to Postcopy mode even when pending_size is > s->threshold_size.
> 
> Thank you.
> ---
>   - Prasad
> 


