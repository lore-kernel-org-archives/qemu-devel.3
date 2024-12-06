Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4CCE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJa13-000850-Ut; Fri, 06 Dec 2024 10:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJa12-00084n-0m
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJa0x-0003bB-Ma
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733497985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Onh1i4bHEJAhwnBbDaaGwcniNZRbrVmFD5XcMEUPuF4=;
 b=Oq8CruIOnyqayQ//36ezbsEQD0lgcFHreBMXdiObN30xlHUPbs4DkxfrP8Pd3zFORydvdi
 la6BCbNarulbV071I+RnOUe9fH61aLxvf0zeMCwSw3z7bs1Cf6keBkbnYn08FUhvFHIuWg
 Ld+/maA98AitMmZ6JqdAK76qxokgyNM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-L4il0AASNQ-UrCaE89tEUw-1; Fri, 06 Dec 2024 10:13:04 -0500
X-MC-Unique: L4il0AASNQ-UrCaE89tEUw-1
X-Mimecast-MFC-AGG-ID: L4il0AASNQ-UrCaE89tEUw
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b677762665so292673285a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497984; x=1734102784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Onh1i4bHEJAhwnBbDaaGwcniNZRbrVmFD5XcMEUPuF4=;
 b=TXE7sazo2MlxDvM+K6Chbaf9/CQaF7Iyqmb0kNT4zbKNXAlcXQxkVxGxBs9cPybnf6
 2DF7CT3nxl2aEaDcg3rH3D1m40+QXPZ1qADFoQLCO7WOZLInPNTNyeZx53i6BoV3MAwO
 2uz14Jf9hgJ/c3OzD7wozOsTRfse7055WIeHvVc8vPFzeOcDsXOnxw3dEVO96FQlsHne
 9geR+CssCxaukKIbber5Gzpj7PY4kVwnXRBfwd50ZmsSMnBFIFk3AdZCBdgw+N70aWoF
 wCRNyGEvhH+HxkoOol8p/8HRktNW33+fMbaO8Uqra9w4jD+kwhbRHps2fsULUjo4hvLn
 xOiQ==
X-Gm-Message-State: AOJu0YzgRmQgZE2ciXFoqpvHvuNeS3+MoIuy7gbX9LZ9uhxvecLFckRW
 z5pZt0BG6bPK22mf7Jy5U06xpGCzr3e91RqbBp6X4G8/EoWgAVupuHet+XKJjUwYgFtr+y+u9k4
 yKA+CYyUIG4tKxs59ppMeO3Up7MQ4zxw2RBHQRfqQoddv+nyTSMFw
X-Gm-Gg: ASbGncvC+d2HNmBAHtIcL+vtKWEfh3S/LVav6L5S7XsXhapLUJm8/gWIx6jSVKw+1QL
 z7Xu+LsxkHB96tU2Lr3sbxP6Bme/7o6IOpii4GYQU/vktepXQCPntSqDe9bkZLz5P1YbVnWTPMj
 UNkJUF06FBf8UzoeXPChLFolVFTOrjul+l/hIhKp0xZ5GEmz5RiWJsJwXu2fPSMi43y8jlwbgEL
 eQx7XTykOxmeCz8z+Le5mIbVjKbcHakd3VoENLR2RS0nZdpv1mPFdXO4jNhK0V+MJYOpUUlCtCj
 JC7YNj35lyk=
X-Received: by 2002:a05:620a:bcd:b0:7b6:6e7c:8efc with SMTP id
 af79cd13be357-7b6bcb46a7emr602092285a.44.1733497983926; 
 Fri, 06 Dec 2024 07:13:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEirn6Y24lKwC7rhX393XlM5mpwylRi++LYFSO7rFDOWcPXB2ExpLEbFgy9wLB1peaMCshWyw==
X-Received: by 2002:a05:620a:bcd:b0:7b6:6e7c:8efc with SMTP id
 af79cd13be357-7b6bcb46a7emr602087385a.44.1733497983535; 
 Fri, 06 Dec 2024 07:13:03 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9ffacsm179852785a.114.2024.12.06.07.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 07:13:03 -0800 (PST)
Date: Fri, 6 Dec 2024 10:13:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 6/7] migration/multifd: Cleanup src flushes on
 condition check
Message-ID: <Z1MUfWrq0_BfVRSj@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-7-peterx@redhat.com>
 <87wmgcc2ss.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmgcc2ss.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 06, 2024 at 11:18:59AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > The src flush condition check is over complicated, and it's getting more
> > out of control if postcopy will be involved.
> >
> > In general, we have two modes to do the sync: legacy or modern ways.
> > Legacy uses per-section flush, modern uses per-round flush.
> >
> > Mapped-ram always uses the modern, which is per-round.
> >
> > Introduce two helpers, which can greatly simplify the code, and hopefully
> > make it readable again.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.h        |  2 ++
> >  migration/multifd-nocomp.c | 42 ++++++++++++++++++++++++++++++++++++++
> >  migration/ram.c            | 10 +++------
> >  3 files changed, 47 insertions(+), 7 deletions(-)
> >
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index c9ae57ea02..582040922f 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -351,6 +351,8 @@ static inline uint32_t multifd_ram_page_count(void)
> >  void multifd_ram_save_setup(void);
> >  void multifd_ram_save_cleanup(void);
> >  int multifd_ram_flush_and_sync(QEMUFile *f);
> > +bool multifd_ram_sync_per_round(void);
> > +bool multifd_ram_sync_per_section(void);
> >  size_t multifd_ram_payload_size(void);
> >  void multifd_ram_fill_packet(MultiFDSendParams *p);
> >  int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
> > diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> > index 58372db0f4..c1f686c0ce 100644
> > --- a/migration/multifd-nocomp.c
> > +++ b/migration/multifd-nocomp.c
> > @@ -344,6 +344,48 @@ retry:
> >      return true;
> >  }
> >  
> > +/*
> > + * We have two modes for multifd flushes:
> > + *
> > + * - Per-section mode: this is the legacy way to flush, it requires one
> > + *   MULTIFD_FLAG_SYNC message for each RAM_SAVE_FLAG_EOS.
> > + *
> > + * - Per-round mode: this is the modern way to flush, it requires one
> > + *   MULTIFD_FLAG_SYNC message only for each round of RAM scan.  Normally
> > + *   it's paired with a new RAM_SAVE_FLAG_MULTIFD_FLUSH message in network
> > + *   based migrations.
> > + *
> > + * One thing to mention is mapped-ram always use the modern way to sync.
> > + */
> > +
> > +/* Do we need a per-section multifd flush (legacy way)? */
> > +bool multifd_ram_sync_per_section(void)
> > +{
> > +    if (!migrate_multifd()) {
> > +        return false;
> > +    }
> > +
> > +    if (migrate_mapped_ram()) {
> > +        return false;
> > +    }
> > +
> > +    return migrate_multifd_flush_after_each_section();
> > +}
> > +
> > +/* Do we need a per-round multifd flush (modern way)? */
> > +bool multifd_ram_sync_per_round(void)
> > +{
> > +    if (!migrate_multifd()) {
> > +        return false;
> > +    }
> > +
> > +    if (migrate_mapped_ram()) {
> > +        return true;
> > +    }
> > +
> > +    return !migrate_multifd_flush_after_each_section();
> > +}
> > +
> >  int multifd_ram_flush_and_sync(QEMUFile *f)
> >  {
> >      MultiFDSyncReq req;
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 154ff5abd4..5d4bdefe69 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1302,9 +1302,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
> >          pss->page = 0;
> >          pss->block = QLIST_NEXT_RCU(pss->block, next);
> >          if (!pss->block) {
> > -            if (migrate_multifd() &&
> > -                (!migrate_multifd_flush_after_each_section() ||
> > -                 migrate_mapped_ram())) {
> > +            if (multifd_ram_sync_per_round()) {
> 
> If we're already implicitly declaring which parts of the code mean
> "round" or "section", we could fold the flush into the function and call
> it unconditionally.

That will add mistery when reading the callers, not be able to identify
whether the flush was sent or not.

If you have a strong preference on it, you can reply with a formal patch
and I can include it when I repost.  However one comment below:

> 
> We don't need ram.c code to be deciding about multifd. This could be all
> hidden away in the multifd-nocomp code:

Side note: maybe I should have a pre-requisite patch moving flush things
out of multifd-nocomp.c but into multifd.c, because compressors will also
need it.  Then I could add multifd_ram_sync_per_* into multifd.c too.

> 
> -- >8 --
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index c1f686c0ce..6a7eee4c25 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -358,32 +358,26 @@ retry:
>   * One thing to mention is mapped-ram always use the modern way to sync.
>   */
>  
> -/* Do we need a per-section multifd flush (legacy way)? */
> -bool multifd_ram_sync_per_section(void)
> +int multifd_ram_sync_per_section(QEMUFile *f)
>  {
> -    if (!migrate_multifd()) {
> -        return false;
> +    if (!migrate_multifd() || !migrate_multifd_flush_after_each_section()) {
> +        return 0;

If you're going to reply with the patch, please consider not queuing up the
if condition check again.  That's one of the reason why I introduced the
helper anyway, so that it'll be clear to see each check, and we can easily
add comment to each check whenever it's necessary (though I unified the
comment part all over to above, because the two modes share it).

>      }
>  
>      if (migrate_mapped_ram()) {
> -        return false;
> +        return 0;
>      }
>  
> -    return migrate_multifd_flush_after_each_section();
> +    return multifd_ram_flush_and_sync(f);
>  }
>  
> -/* Do we need a per-round multifd flush (modern way)? */
> -bool multifd_ram_sync_per_round(void)
> +int multifd_ram_sync_per_round(QEMUFile *f)
>  {
> -    if (!migrate_multifd()) {
> -        return false;
> +    if (!migrate_multifd() || migrate_multifd_flush_after_each_section()) {

Same here.

> +        return 0;
>      }
>  
> -    if (migrate_mapped_ram()) {
> -        return true;
> -    }
> -
> -    return !migrate_multifd_flush_after_each_section();
> +    return multifd_ram_flush_and_sync(f);
>  }
>  
>  int multifd_ram_flush_and_sync(QEMUFile *f)
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 582040922f..3b42128167 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -351,8 +351,8 @@ static inline uint32_t multifd_ram_page_count(void)
>  void multifd_ram_save_setup(void);
>  void multifd_ram_save_cleanup(void);
>  int multifd_ram_flush_and_sync(QEMUFile *f);
> -bool multifd_ram_sync_per_round(void);
> -bool multifd_ram_sync_per_section(void);
> +int multifd_ram_sync_per_round(QEMUFile *f);
> +int multifd_ram_sync_per_section(QEMUFile *f);
>  size_t multifd_ram_payload_size(void);
>  void multifd_ram_fill_packet(MultiFDSendParams *p);
>  int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
> diff --git a/migration/ram.c b/migration/ram.c
> index ddee703585..fe33c8e0e8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1302,12 +1302,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (multifd_ram_sync_per_round()) {
> -                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
> -                int ret = multifd_ram_flush_and_sync(f);
> -                if (ret < 0) {
> -                    return ret;
> -                }
> +            QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
> +            int ret = multifd_ram_sync_per_round(f);
> +            if (ret < 0) {
> +                return ret;
>              }
>  
>              /* Hit the end of the list */
> @@ -3203,11 +3201,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  
>  out:
>      if (ret >= 0 && migration_is_running()) {
> -        if (multifd_ram_sync_per_section()) {
> -            ret = multifd_ram_flush_and_sync(f);
> -            if (ret < 0) {
> -                return ret;
> -            }
> +        ret = multifd_ram_sync_per_section(f);
> +        if (ret < 0) {
> +            return ret;
>          }
>  
>          qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> @@ -3276,15 +3272,13 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          }
>      }
>  
> -    if (multifd_ram_sync_per_section()) {
> -        /*
> -         * Only the old dest QEMU will need this sync, because each EOS
> -         * will require one SYNC message on each channel.
> -         */
> -        ret = multifd_ram_flush_and_sync(f);
> -        if (ret < 0) {
> -            return ret;
> -        }
> +    /*
> +     * Only the old dest QEMU will need this sync, because each EOS
> +     * will require one SYNC message on each channel.
> +     */
> +    ret = multifd_ram_sync_per_section(f);
> +    if (ret < 0) {
> +        return ret;
>      }
>  
>      if (migrate_mapped_ram()) {
> -- 
> 2.35.3
> 

-- 
Peter Xu


