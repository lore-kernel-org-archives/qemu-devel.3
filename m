Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E8CD6E74
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVBiK-0004Ok-2D; Thu, 04 Jun 2026 13:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVBiH-0004O1-4y
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 13:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVBiC-0002Em-V3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 13:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780593499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKWR0AT4SKE0HC0VZXmYLPSqFa5UTEaHGl/wpNr/Mh8=;
 b=UMb2GNWF3Ve93zK4rxPAOE8QtOCqymsN3whXx1gjgVvkz2Oni6IVa4eZ8RGq8oFlW5Vy78
 Fv5AkA18/40z8uw3MJeapEh1dscKCTz3vgRo4S1h/5ARjAPrAsxkcxjWypgSKHcwazjOSf
 ipiJph0M85RwdVZTQWm4EPduL+eyWGA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-4re7yuZTNMu4XbVMQPEB4w-1; Thu, 04 Jun 2026 13:18:18 -0400
X-MC-Unique: 4re7yuZTNMu4XbVMQPEB4w-1
X-Mimecast-MFC-AGG-ID: 4re7yuZTNMu4XbVMQPEB4w_1780593498
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cce230de8bso26158086d6.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780593497; x=1781198297; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AKWR0AT4SKE0HC0VZXmYLPSqFa5UTEaHGl/wpNr/Mh8=;
 b=YAzFTMJIZVEmW4VBj5BiQC13kQIY0iZK6avVrlhNZdUHsBtdF65rphsx/HKqrIselK
 Ub7D8sodMN0RLpVqppiyhKoTlweBCrynrHwIZWE51J3Ig8V8/ZUujRnZshkJOFFTC6ZN
 9FdniKcTp6vNy57xWFPHquHmra47HAiCKsUGbca7pCZM9vR6+pzysn30a7rn6cVc/ZqC
 v0+ldKHpXqpOeEphQDlqAkfI1kZ3OcF55dQUS80kxCJSZJXDA69QZRbAXb1Fo7UcxWyC
 /v9ae7bkTWr3mLB52nNlX403MO6OFrio2AJcuSAFQyKLE/eP7/o1+JF8xkd1cJ8fKABG
 CAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780593497; x=1781198297;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AKWR0AT4SKE0HC0VZXmYLPSqFa5UTEaHGl/wpNr/Mh8=;
 b=n4AW81aPZivmrhSOf/nJxDIv7dLZ4L9ZShiS7+UwVoGQpSNMvTaD7+y9c/uIbFQCE1
 m51p0wppzK4th2HsFTJhI0EsAhCGHfPHO1gr9mPduyjAur7AQIIllpz6caR6jbUiYfsa
 sFv8MW1onyC5Ttn5XaferBlcuclQr18gd9znbwfFJsrf37Nej5LJNTuXmhQWVzVp64Wo
 FwPV/Kj/gprzKGeGUmJI/Xb5Rkp1hon99rCKB2O8PGfFiUpCfjSq2fomhJS4vON0Xyf2
 epn2fM3J118Oh5axgDQTaRlelXaPM/ZXSSp+b6stz3SnzPjkeh32lNa2aZOroH0RFGPR
 sujg==
X-Gm-Message-State: AOJu0YyjIgZ6oiIGxCTJAnlWy8D1XK3HymGSjEfxxTZk9VuCOYDLpum/
 Cbj6AaYFW6thVvSB3ob607qYDWhAx/7jn3fZuFX35h579WGfQ8nhirIOcrgABYfNh2ZpOw8Q0QL
 xAWLZLdhbZfIcityGDAFN5OQ2wJMiUm1E7iRSAUVzBCpA0GGJBcDwTcvr
X-Gm-Gg: Acq92OEqQktIDZMHJFwq3PhcJI+1C42cmxqRrRni9F71ogyNNqRszz3lY/G0Xa/Ejeb
 9nmlws29QJfJBHjZzfB5yQKNDBFYSSBMtUHdbqauB7eZxhn2TipH/qob/9kNmE8EatS7uBLjDFC
 cka4rlen4cQsoPjjHTPvnLk/0ZmgLZNkSBWyQigxNNx7yWrOCygwUVjGdOkdeatjfVeq1Scnf7X
 xUK0m6S1R7qyP9/HbWhKNxjWHtV3B0YIia2nsIcXNK6D6/PYLqovNaxfWzSoI37pqi5o3W1ymbY
 R4r4ESqEo0C1Ax4dO4yrqUiuEuo/yfIpXR6llTymqJVbPD0djl6lbeARTgfGz1PNlekmVLp/BTm
 yNZ9ZrCdSv0Xp0BXSvwAz/0Hwug==
X-Received: by 2002:a05:620a:4141:b0:915:6cf9:5630 with SMTP id
 af79cd13be357-915a9d89fdamr3386785a.34.1780593497209; 
 Thu, 04 Jun 2026 10:18:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4141:b0:915:6cf9:5630 with SMTP id
 af79cd13be357-915a9d89fdamr3374985a.34.1780593496483; 
 Thu, 04 Jun 2026 10:18:16 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00a4f4sm684559785a.3.2026.06.04.10.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 10:18:15 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:18:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, Gavin Shan <gshan@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v2 02/13] migration: Run final save_query_pending at
 switchover
Message-ID: <aiGzVgatc_0Df21z@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-3-avihaih@nvidia.com>
 <aiCJHa-lT9Ycf6jq@x1.local> <aiCWynDFLoxtcctK@x1.local>
 <722fb01a-988b-4b21-9cca-aca1de2858db@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <722fb01a-988b-4b21-9cca-aca1de2858db@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 06:29:01PM +0300, Avihai Horon wrote:
> 
> On 6/4/2026 12:04 AM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jun 03, 2026 at 04:05:49PM -0400, Peter Xu wrote:
> > > On Tue, Jun 02, 2026 at 12:26:10PM +0300, Avihai Horon wrote:
> > > > Before switchover, the source needs one last exact pending query so
> > > > modules can flush dirty state. This is currently done ad hoc in modules
> > > > handlers. For example, RAM syncs its dirty bitmap in its save_complete
> > > > handler.
> > > > 
> > > > This should be a general concept relevant for any module, so extract it
> > > > to migration core instead by running a final save_query_pending before
> > > > switchover.
> > > > 
> > > > The final query requires special handling by modules (e.g., it's called
> > > > with BQL locked, during VM stop), so extend save_query_pending
> > > > SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
> > > > flag so migration modules can tell the last pending query during
> > > > switchover from periodic iteration queries.
> > > > 
> > > > Not all modules need the final query; skip it for those who don't need.
> > > > 
> > > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > > ---
> > > >   include/migration/register.h   | 41 ++++++++++++++++++----------------
> > > >   migration/savevm.h             |  3 ++-
> > > >   hw/s390x/s390-stattrib.c       |  9 ++++++--
> > > >   hw/vfio/migration.c            |  6 ++++-
> > > >   migration/block-dirty-bitmap.c |  6 ++++-
> > > >   migration/migration.c          |  7 ++++--
> > > >   migration/ram.c                | 37 ++++++++++++++++++------------
> > > >   migration/savevm.c             | 27 +++++++++++++++++-----
> > > >   migration/trace-events         |  2 +-
> > > >   9 files changed, 91 insertions(+), 47 deletions(-)
> > > > 
> > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > index 5e5e0ee432..6f632123f1 100644
> > > > --- a/include/migration/register.h
> > > > +++ b/include/migration/register.h
> > > > @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
> > > >        */
> > > >       bool (*is_active_iterate)(void *opaque);
> > > > 
> > > > +    /**
> > > > +     * @save_query_pending
> > > > +     *
> > > > +     * This estimates the remaining data to transfer on the source side.
> > > > +     *
> > > > +     * When @exact is true, a module must report accurate results.  When
> > > > +     * @exact is false, a module may report estimates.
> > > > +     *
> > > > +     * It's highly recommended that modules implement a faster version of
> > > > +     * the query path (for example, by proper caching on the counters) if
> > > > +     * an accurate query will be time-consuming.
> > > > +     *
> > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > +     * @pending: pointer to a MigPendingData struct
> > > > +     * @exact: set to true for an accurate (slow) query
> > > > +     * @final: set to true for the final query during switchover. When final is
> > > > +     * true, the query is called with BQL locked. Otherwise, it's called with
> > > > +     * BQL unlocked.
> > > > +     */
> > > > +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> > > > +                               bool exact, bool final);
> > > > +
> > > >       /* This runs outside the BQL in the migration case, and
> > > >        * within the lock in the savevm case.  The callback had better only
> > > >        * use data that is local to the migration thread or protected
> > > > @@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
> > > >        */
> > > >       bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
> > > > 
> > > > -    /**
> > > > -     * @save_query_pending
> > > > -     *
> > > > -     * This estimates the remaining data to transfer on the source side.
> > > > -     *
> > > > -     * When @exact is true, a module must report accurate results.  When
> > > > -     * @exact is false, a module may report estimates.
> > > > -     *
> > > > -     * It's highly recommended that modules implement a faster version of
> > > > -     * the query path (for example, by proper caching on the counters) if
> > > > -     * an accurate query will be time-consuming.
> > > > -     *
> > > > -     * @opaque: data pointer passed to register_savevm_live()
> > > > -     * @pending: pointer to a MigPendingData struct
> > > > -     * @exact: set to true for an accurate (slow) query
> > > > -     */
> > > > -    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> > > > -                               bool exact);
> > > > -
> > > >       /**
> > > >        * @load_state
> > > >        *
> > > > diff --git a/migration/savevm.h b/migration/savevm.h
> > > > index 96fdf96d4e..10b3d78a5f 100644
> > > > --- a/migration/savevm.h
> > > > +++ b/migration/savevm.h
> > > > @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> > > >   void qemu_savevm_state_cleanup(void);
> > > >   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> > > >   int qemu_savevm_state_complete_precopy(MigrationState *s);
> > > > -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
> > > > +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
> > > > +void qemu_savevm_query_pending_final(MigPendingData *pending);
> > > >   int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
> > > >   bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
> > > >   void qemu_savevm_state_end(QEMUFile *f);
> > > > diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> > > > index c334714b31..aed0c6844d 100644
> > > > --- a/hw/s390x/s390-stattrib.c
> > > > +++ b/hw/s390x/s390-stattrib.c
> > > > @@ -190,12 +190,17 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
> > > >   }
> > > > 
> > > >   static void cmma_state_pending(void *opaque, MigPendingData *pending,
> > > > -                               bool exact)
> > > > +                               bool exact, bool final)
> > > >   {
> > > >       S390StAttribState *sas = S390_STATTRIB(opaque);
> > > >       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> > > > -    long long res = sac->get_dirtycount(sas);
> > > > +    long long res;
> > > > 
> > > > +    if (final) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    res = sac->get_dirtycount(sas);
> > > >       if (res >= 0) {
> > > >           pending->precopy_bytes += res;
> > > >       }
> > > > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > > index fb12b9717f..95072d6664 100644
> > > > --- a/hw/vfio/migration.c
> > > > +++ b/hw/vfio/migration.c
> > > > @@ -622,12 +622,16 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
> > > >   }
> > > > 
> > > >   static void vfio_state_pending(void *opaque, MigPendingData *pending,
> > > > -                               bool exact)
> > > > +                               bool exact, bool final)
> > > >   {
> > > >       VFIODevice *vbasedev = opaque;
> > > >       VFIOMigration *migration = vbasedev->migration;
> > > >       uint64_t precopy_size, stopcopy_size;
> > > > 
> > > > +    if (final) {
> > > > +        return;
> > > > +    }
> > > > +
> > > >       if (exact) {
> > > >           vfio_state_pending_sync(vbasedev);
> > > >       }
> > > > diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> > > > index 7ef3759e53..66ed91de03 100644
> > > > --- a/migration/block-dirty-bitmap.c
> > > > +++ b/migration/block-dirty-bitmap.c
> > > > @@ -767,12 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
> > > >   }
> > > > 
> > > >   static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
> > > > -                                       bool exact)
> > > > +                                       bool exact, bool final)
> > > >   {
> > > >       DBMSaveState *s = &((DBMState *)opaque)->save;
> > > >       SaveBitmapState *dbms;
> > > >       uint64_t pending = 0;
> > > > 
> > > > +    if (final) {
> > > > +        return;
> > > > +    }
> > > > +
> > > >       bql_lock();
> > > > 
> > > >       QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index 7488a94206..df8ed3a9fd 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -2787,12 +2787,15 @@ static bool migration_switchover_prepare(MigrationState *s)
> > > >   static bool migration_switchover_start(MigrationState *s, Error **errp)
> > > >   {
> > > >       ERRP_GUARD();
> > > > +    MigPendingData pending = {};
> > > > 
> > > >       if (!migration_switchover_prepare(s)) {
> > > >           error_setg(errp, "Switchover is interrupted");
> > > >           return false;
> > > >       }
> > > > 
> > > > +    qemu_savevm_query_pending_final(&pending);
> > > Not needed for postcopy, we can move it to migration_completion_precopy().
> 
> While currently not needed (because VFIO isn't compatible with postcopy),
> AFAIU, generally it is needed because we have here a switchover similar to
> precopy case -- the switchover decision and VM stop at stopcopy_start() are
> not atomic, so theoretically a device may want to request an ACK in this
> gap.
> 
> But that's all theoretical and not necessary currently.

True, then it makes more sense to keep it here.  You can enhance the
comment below with VFIO implications for the future DMA faults when it's
ready.

> 
> > A better idea is.. we can drop migration_bitmap_sync() in
> > ram_postcopy_send_discard_bitmap() too, then we can keep this one.
> > 
> > But then, let's properly document this, both for precopy and postcopy
> > cases.  One example:
> > 
> >      /*
> >       * The final query to the whole system on dirty data to make sure we
> >       * collect the latest status of the VM.  For precopy, source QEMU will
> >       * dump all the dirty data during switchover.  For postcopy, this will
> >       * properly update all the dirty bitmaps to finally generate the
> >       * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
> >       */
> 
> The last dirty sync is done a bit differently for postcopy case:
>   postcopy_start()
>     ram_postcopy_send_discard_bitmap()
>       migration_bitmap_sync(rs, false);
> 
> 1. The last_stage parameter of migration_bitmap_sync() is false (shouldn't
> it be true here as well?).

Yes, I think it should.

The only thing uses that last_stage so far should be ARM64 where some dirty
data can be generated to bitmap not ring (only matters when dirty ring
enabled).  In that case AFAIU we need that too for a postcopy switchover.

> 2. It calls migration_bitmap_sync and not migration_bitmap_sync_precopy,
> i.e., without precopy_notify calls.

This is another thing I feel like got overlooked in the free page hint
feature.  The only notifiers registered is that balloon device, logically I
think we need these notifiers in postcopy too to make sure we properly stop
the free page hints seeing BEFORE_BITMAP_SYNC, then don't start it
(vm_running=false) in AFTER_BITMAP_SYNC:

virtio_balloon_free_page_hint_notify():

    case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
        virtio_balloon_free_page_stop(dev);
        break;
    case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
        if (vdev->vm_running) {
            virtio_balloon_free_page_start(dev);
            break;
        }
> 
> If we need to keep the above differences for postcopy then I guess we'd need
> to introduce different final query flow for it. It may be cumbersome.
> Do you think we should do this extra effort to support it, or, as you
> suggested, we can drop the final switchover ack check for postcopy for now?

IMHO you can add a small patch for replacing the postcopy sync first with
migration_bitmap_sync_precopy(last_stage=true), copy Gavin and Wei in that
patch only:

Gavin Shan <gshan@redhat.com>
Wei Wang <wei.w.wang@intel.com>

Then this patch can be on top.

I'll loop both of them in while replying, to see if we can collect early
comments.

> 
> > > I'd also appreciate a short comment explaining why the final query is
> > > needed.
> > > 
> > > > +
> > > >       /* Inactivate disks except in COLO */
> > > >       if (!migrate_colo()) {
> > > >           /*
> > > > @@ -3285,7 +3288,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
> > > >       /*
> > > >        * Do a slow sync first before boosting the iteration count.
> > > >        */
> > > > -    qemu_savevm_query_pending(pending, true);
> > > > +    qemu_savevm_query_pending_iter(pending, true);
> > > > 
> > > >       /*
> > > >        * Update the dirty information for the whole system for this
> > > > @@ -3336,7 +3339,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
> > > >       bool complete_ready;
> > > > 
> > > >       /* Fast path - get the estimated amount of pending data */
> > > > -    qemu_savevm_query_pending(&pending, false);
> > > > +    qemu_savevm_query_pending_iter(&pending, false);
> > > > 
> > > >       if (in_postcopy) {
> > > >           /*
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index fc38ffbf8a..4e3f442593 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -3376,10 +3376,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> > > >       rs->last_stage = !migration_in_colo_state();
> > > > 
> > > >       WITH_RCU_READ_LOCK_GUARD() {
> > > > -        if (!migration_in_postcopy()) {
> > > > -            migration_bitmap_sync_precopy(true);
> > > > -        }
> > > > -
> > > >           ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
> > > >           if (ret < 0) {
> > > >               qemu_file_set_error(f, ret);
> > > > @@ -3442,25 +3438,38 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> > > >       return qemu_fflush(f);
> > > >   }
> > > > 
> > > > -static void ram_state_pending(void *opaque, MigPendingData *pending,
> > > > -                              bool exact)
> > > > +static void ram_state_pending_sync(bool exact, bool final)
> > > >   {
> > > > -    RAMState **temp = opaque;
> > > > -    RAMState *rs = *temp;
> > > > -    uint64_t remaining_size;
> > > > -
> > > >       /*
> > > >        * Sync is not needed either with: (1) a fast query, or (2) after
> > > >        * postcopy has started (no new dirty will generate anymore).
> > > >        */
> > > > -    if (exact && !migration_in_postcopy()) {
> > > > +    if (!exact || migration_in_postcopy()) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    /* Final pending query is called with BQL locked */
> > > > +    if (!final) {
> > > >           bql_lock();
> > > > -        WITH_RCU_READ_LOCK_GUARD() {
> > > > -            migration_bitmap_sync_precopy(false);
> > > > -        }
> > > > +    }
> > > > +
> > > > +    WITH_RCU_READ_LOCK_GUARD() {
> > > > +        migration_bitmap_sync_precopy(final);
> > > > +    }
> > > > +
> > > > +    if (!final) {
> > > >           bql_unlock();
> > > >       }
> > > > +}
> > > > +
> > > > +static void ram_state_pending(void *opaque, MigPendingData *pending,
> > > > +                              bool exact, bool final)
> > > > +{
> > > > +    RAMState **temp = opaque;
> > > > +    RAMState *rs = *temp;
> > > > +    uint64_t remaining_size;
> > > > 
> > > > +    ram_state_pending_sync(exact, final);
> > > >       remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> > > > 
> > > >       if (migrate_postcopy_ram()) {
> > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > index 23adaf9dd9..22cb6a15c6 100644
> > > > --- a/migration/savevm.c
> > > > +++ b/migration/savevm.c
> > > > @@ -1795,7 +1795,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
> > > >       return qemu_fflush(f);
> > > >   }
> > > > 
> > > > -void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
> > > > +static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
> > > > +                                      bool final)
> > > >   {
> > > >       SaveStateEntry *se;
> > > > 
> > > > @@ -1808,7 +1809,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
> > > >           if (!qemu_savevm_state_active(se)) {
> > > >               continue;
> > > >           }
> > > > -        se->ops->save_query_pending(se->opaque, pending, exact);
> > > > +        se->ops->save_query_pending(se->opaque, pending, exact, final);
> > > >       }
> > > > 
> > > >       pending->total_bytes = pending->precopy_bytes +
> > > > @@ -1817,16 +1818,30 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
> > > >       /*
> > > >        * Update system remaining dirty bytes whenever QEMU queries.  It will
> > > >        * make the value to be not as accurate, but should still be pretty
> > > > -     * close to reality when this got invoked frequently while iterating.
> > > > +     * close to reality when this got invoked frequently while iterating.  Don't
> > > > +     * update in final query as some modules may skip it if not needed.
> > > IMHO this specialty isn't needed.  We can just make all modules report and
> > > making sure we don't deadlock on bql.  AFAIU, CMMA never takes BQL, while
> > > dirty-bitmap should conditionally take it now.
> 
> I didn't want to add unnecessary work for the critical downtime path, i.e.,
> unnecessary exact queries.

If there's any real slow sync, then likely it needs to happen.. because of
the same reason why RAM do the sync, to make sure the data is latest in
QEMU migration core (say, bitmaps).  If it's a fast sync then it doesn't
matter.

query_pending() so far should achieve both functions: (1) synchronize dirty
info with whatever remote modules like KVM, enforced when exact=true, (2)
report.

VFIO is just special because VFIO dirty info accuracy never rely on
query_pending or whatever it collects, so it's purely a way to estimate for
size of dirty, hence (2) only.

> I am not familiar with the other devices, but if you think it's negligible
> for them then we can drop this specialty (in VFIO I'd still like to skip the
> stopcopy size query; using the cached value is good enough IMHO).

Yes VFIO is fine but it'll be good to comment.  Let's try to drop them, I
want to avoid below "if (!final)" if possible.

Thanks,

> 
> Thanks.
> 
> > > 
> > > >        */
> > > > -    mig_stats.dirty_bytes_total = pending->total_bytes;
> > > > -
> > > > -    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
> > > > +    if (!final) {
> > > > +        mig_stats.dirty_bytes_total = pending->total_bytes;
> > > > +    }

[a]

> > > Then we remove this too which is counter-intuitive..
> > > 
> > > The rest looks all reasonable.
> > > 
> > > Thanks,
> > > 
> > > > +    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
> > > >                                       pending->stopcopy_bytes,
> > > >                                       pending->postcopy_bytes,
> > > >                                       pending->total_bytes);
> > > >   }
> > > > 
> > > > +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
> > > > +{
> > > > +    qemu_savevm_query_pending(pending, exact, false);
> > > > +}
> > > > +
> > > > +void qemu_savevm_query_pending_final(MigPendingData *pending)
> > > > +{
> > > > +    g_assert(bql_locked());
> > > > +
> > > > +    qemu_savevm_query_pending(pending, true, true);
> > > > +}
> > > > +
> > > >   void qemu_savevm_state_cleanup(void)
> > > >   {
> > > >       SaveStateEntry *se;
> > > > diff --git a/migration/trace-events b/migration/trace-events
> > > > index de99d976ab..1c9212d3e2 100644
> > > > --- a/migration/trace-events
> > > > +++ b/migration/trace-events
> > > > @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
> > > >   qemu_loadvm_state_post_main(int ret) "%d"
> > > >   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
> > > >   qemu_savevm_send_packaged(void) ""
> > > > -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
> > > > +qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
> > > >   loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
> > > >   loadvm_state_setup(void) ""
> > > >   loadvm_state_cleanup(void) ""
> > > > --
> > > > 2.40.1
> > > > 
> > > --
> > > Peter Xu
> > --
> > Peter Xu
> > 
> 

-- 
Peter Xu


