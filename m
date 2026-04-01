Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D89910FCADC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w831D-0007W2-Cn; Wed, 01 Apr 2026 17:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w831A-0007Sk-C2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8317-0002q5-2w
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775078543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xnFJ1Jn8FdB0LOIwIUI7GyLsq6P9iKYrFV1apXsU8o=;
 b=AcdqCXnkzsvegJ4N6vpcAb2WHj2NdUFzF2ZQg6mNWn4v8uXtWg+qV96sUM/iRh1Ms18+ip
 7IO/NechgYyiJEf2KJz1MqN2cXAhiSjGn/cBtB72hJ2e+QwTRv7cr51dFCCqUE2t7uZVCM
 HgT9BcECMIdSFImnSgWCZlXAo1hN/A4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-4A7k-qALN0-dPFFrLzinYA-1; Wed, 01 Apr 2026 17:22:22 -0400
X-MC-Unique: 4A7k-qALN0-dPFFrLzinYA-1
X-Mimecast-MFC-AGG-ID: 4A7k-qALN0-dPFFrLzinYA_1775078541
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a31df1907cso7980356d6.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775078541; x=1775683341; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7xnFJ1Jn8FdB0LOIwIUI7GyLsq6P9iKYrFV1apXsU8o=;
 b=Y+vd4IOGwVx5RC9JH4i8pET8lgS1fimDHrgyUEvpE0HKZdC0/eW00vzSCRxJ9IXRql
 1/JPwJjn//ubBQ+OhTXurCOlkbUD8C7J5zAbwmA53b6SN4+BeI9HGoQjNSCGbR/Tk9yf
 fpz4PW7XC7aZFDxnVjOsGY/VHOmkXJU28+L3U/GvoTfaufxwIlKM9H/Rt/Km/TdHIc3m
 Q9U6B8qHPYG56R7FwhcMCqVVr2ODCvvieQes+AA8LGdQ12x5zDj6KP73vTmMBqzKQ83A
 YEsGnjk7y+796hjrK/YSynnL6QT0QBO720ItXKEFiE5Cvi6UOIe+Jp0GihFIJkKfFAsS
 8PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775078541; x=1775683341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xnFJ1Jn8FdB0LOIwIUI7GyLsq6P9iKYrFV1apXsU8o=;
 b=ftBbbAMRGanCpeUQmRYwRc7eX0O20XpU43LFckVTLiMl//r4fZGMp7hC6gywTcGCB+
 3sGqtJimn0ClPxX6E64JpxHGgGKOcE8ahF0Lg76zBechJJjoUsmQKrQuy+MQ12ceUDkt
 5FBGAk9hXHEjDxXcgBuCAZ+wLk4e4PL8fimt/wxq7lIAHdaXHMnwHw3qhcYNlyFE1pMZ
 FtSKs6WMPMDHhtEwj74yyaGuFQOgfA5+fzPJRgie0XfvAW6hGTi9gyRkV6RmmxUO8e89
 pwonze80YTkE0R6wAGl6Gi7ZrwUDNkT6VufqRhiDWD1PgXIRKJfvjfzKmBod7VfbL9/u
 5acw==
X-Gm-Message-State: AOJu0YzbhpzDB0MtWJriTdtx72AwdBfbxvjjKs6QVbzfMu8+E8IcihnB
 0oc2FqUF4nJIRIYqa8ll04+F2ZblI/BzPwSnP8UoUeGJDTCkwZ8kd8TC6gHYakoQlNu8x6ie8Sm
 2PqNyMrk/HyxWQ3NuHwW8WeMns9W6CWfijpZYUBnU4ysbx1Ay6AM8U2Rj
X-Gm-Gg: ATEYQzw7wANSnuL+H2oumhQUpFKJ7+olPufVeVpTJxSmyPOkoiCLlcLwq+6XiPmIODJ
 vec5M9qkEAXo679X+o9dROS6AZ8eIVnoAUyVsC7aBT47bZtr1qexQwSmBuEG4chRILfr0zOUjF5
 1QhMY+o+fwtX3PUiTHR9OXcGRIA3FjdQWJ/SLb0lxegyUVKEpY6kMliDNcrt6LHnhod3OGgRb6g
 jOhi9wkZhQ9HuCEIjOY5heRUGNGJPHY8kQV4RjM5QqTwzoWN/bwQY8IUucQrOppm6z3TDFWHLn/
 BiOFOcVyeWvKVEgAmCv7+/1KN7NJakA/BvJ6bK7Aa1/ncIyvLfcCJrugIpypqcVDsm+xq9Pl2FK
 J7MIzdBu2/aI+A81qy5VHOa7u1KwB78THmcknrhkWTTC2sg==
X-Received: by 2002:ad4:5f09:0:b0:8a1:8ddd:e12e with SMTP id
 6a1803df08f44-8a43a55d16bmr74441026d6.48.1775078541269; 
 Wed, 01 Apr 2026 14:22:21 -0700 (PDT)
X-Received: by 2002:ad4:5f09:0:b0:8a1:8ddd:e12e with SMTP id
 6a1803df08f44-8a43a55d16bmr74440646d6.48.1775078540702; 
 Wed, 01 Apr 2026 14:22:20 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a5969158ddsm6623106d6.27.2026.04.01.14.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 14:22:20 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:22:18 -0400
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
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC 05/12] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
Message-ID: <ac2MitFie3jXyiRk@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-6-peterx@redhat.com>
 <b957ae39-12e0-40d2-b0b3-8f09bff10bf0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b957ae39-12e0-40d2-b0b3-8f09bff10bf0@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 25, 2026 at 05:20:41PM +0200, Avihai Horon wrote:
> 
> On 3/20/2026 1:12 AM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > These two APIs are a slight duplication.  For example, there're a few users
> > that directly pass in the same function.
> > 
> > It might also be slightly error prone to provide two hooks, so that it's
> > easier to happen that one module report different things via the two
> > hooks. In reality they should always report the same thing, only about
> > whether we should use a fast-path when the slow path might be too slow, and
> > even if we need to pay with some less accuracy.
> > 
> > Let's just merge it into one API, but instead provide a bool showing if the
> > query is a fast query or not.
> > 
> > No functional change intended.
> > 
> > Export qemu_savevm_query_pending().  We should likely directly use the new
> > API here provided when there're new users to do the query.  This will
> > happen very soon.
> > 
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Jason Herne <jjherne@linux.ibm.com>
> > Cc: Eric Farman <farman@linux.ibm.com>
> > Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Eric Blake <eblake@redhat.com>
> > Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > Cc: John Snow <jsnow@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   docs/devel/migration/main.rst  |  5 ++-
> >   docs/devel/migration/vfio.rst  |  9 ++----
> >   include/migration/register.h   | 52 ++++++++++--------------------
> >   migration/savevm.h             |  3 ++
> >   hw/s390x/s390-stattrib.c       |  8 ++---
> >   hw/vfio/migration.c            | 58 +++++++++++++++++++---------------
> >   migration/block-dirty-bitmap.c |  9 ++----
> >   migration/ram.c                | 32 ++++++-------------
> >   migration/savevm.c             | 43 ++++++++++++-------------
> >   hw/vfio/trace-events           |  3 +-
> >   10 files changed, 93 insertions(+), 129 deletions(-)
> > 
> > diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> > index 234d280249..22c5910d5c 100644
> > --- a/docs/devel/migration/main.rst
> > +++ b/docs/devel/migration/main.rst
> > @@ -519,9 +519,8 @@ An iterative device must provide:
> >       data we must save.  The core migration code will use this to
> >       determine when to pause the CPUs and complete the migration.
> 
> We should also remove the state_pending_exact section above.

Ah yes, will do.

> 
> > 
> > -  - A ``state_pending_estimate`` function that indicates how much more
> > -    data we must save.  When the estimated amount is smaller than the
> > -    threshold, we call ``state_pending_exact``.
> > +  - A ``save_query_pending`` function that indicates how much more
> > +    data we must save.
> > 
> >     - A ``save_live_iterate`` function should send a chunk of data until
> >       the point that stream bandwidth limits tell it to stop.  Each call
> > diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> > index 0790e5031d..33768c877c 100644
> > --- a/docs/devel/migration/vfio.rst
> > +++ b/docs/devel/migration/vfio.rst
> > @@ -50,13 +50,8 @@ VFIO implements the device hooks for the iterative approach as follows:
> >   * A ``load_setup`` function that sets the VFIO device on the destination in
> >     _RESUMING state.
> > 
> > -* A ``state_pending_estimate`` function that reports an estimate of the
> > -  remaining pre-copy data that the vendor driver has yet to save for the VFIO
> > -  device.
> > -
> > -* A ``state_pending_exact`` function that reads pending_bytes from the vendor
> > -  driver, which indicates the amount of data that the vendor driver has yet to
> > -  save for the VFIO device.
> > +* A ``save_query_pending`` function that reports the remaining pre-copy
> > +  data that the vendor driver has yet to save for the VFIO device.
> > 
> >   * An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
> >     active only when the VFIO device is in pre-copy states.
> > diff --git a/include/migration/register.h b/include/migration/register.h
> > index d0f37f5f43..2320c3a981 100644
> > --- a/include/migration/register.h
> > +++ b/include/migration/register.h
> > @@ -16,6 +16,15 @@
> > 
> >   #include "hw/core/vmstate-if.h"
> > 
> > +typedef struct MigPendingData {
> > +    /* How many bytes are pending for precopy / stopcopy? */
> > +    uint64_t precopy_bytes;
> > +    /* How many bytes are pending that can be transferred in postcopy? */
> > +    uint64_t postcopy_bytes;
> > +    /* Is this a fastpath query (which can be inaccurate)? */
> > +    bool fastpath;
> > +} MigPendingData ;
> 
> Extra space before semicolon.

Fixed.

> 
> > +
> >   /**
> >    * struct SaveVMHandlers: handler structure to finely control
> >    * migration of complex subsystems and devices, such as RAM, block and
> > @@ -197,46 +206,17 @@ typedef struct SaveVMHandlers {
> >       bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
> > 
> >       /**
> > -     * @state_pending_estimate
> > -     *
> > -     * This estimates the remaining data to transfer
> > -     *
> > -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> > -     * pending data.
> > -     *
> > -     * @opaque: data pointer passed to register_savevm_live()
> > -     * @must_precopy: amount of data that must be migrated in precopy
> > -     *                or in stopped state, i.e. that must be migrated
> > -     *                before target start.
> > -     * @can_postcopy: amount of data that can be migrated in postcopy
> > -     *                or in stopped state, i.e. after target start.
> > -     *                Some can also be migrated during precopy (RAM).
> > -     *                Some must be migrated after source stops
> > -     *                (block-dirty-bitmap)
> > -     */
> > -    void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
> > -                                   uint64_t *can_postcopy);
> > -
> > -    /**
> > -     * @state_pending_exact
> > -     *
> > -     * This calculates the exact remaining data to transfer
> > +     * @save_query_pending
> >        *
> > -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> > -     * pending data.
> > +     * This estimates the remaining data to transfer on the source side.
> > +     * It's highly suggested that the module should implement both fastpath
> > +     * and slowpath version of it when it can be slow (for more information
> > +     * please check pending->fastpath field).
> >        *
> >        * @opaque: data pointer passed to register_savevm_live()
> > -     * @must_precopy: amount of data that must be migrated in precopy
> > -     *                or in stopped state, i.e. that must be migrated
> > -     *                before target start.
> > -     * @can_postcopy: amount of data that can be migrated in postcopy
> > -     *                or in stopped state, i.e. after target start.
> > -     *                Some can also be migrated during precopy (RAM).
> > -     *                Some must be migrated after source stops
> > -     *                (block-dirty-bitmap)
> > +     * @pending: pointer to a MigPendingData struct
> >        */
> > -    void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
> > -                                uint64_t *can_postcopy);
> > +    void (*save_query_pending)(void *opaque, MigPendingData *pending);
> > 
> >       /**
> >        * @load_state
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index b3d1e8a13c..b116933bce 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -14,6 +14,8 @@
> >   #ifndef MIGRATION_SAVEVM_H
> >   #define MIGRATION_SAVEVM_H
> > 
> > +#include "migration/register.h"
> > +
> >   #define QEMU_VM_FILE_MAGIC           0x5145564d
> >   #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
> >   #define QEMU_VM_FILE_VERSION         0x00000003
> > @@ -43,6 +45,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> >   void qemu_savevm_state_cleanup(void);
> >   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> >   int qemu_savevm_state_complete_precopy(MigrationState *s);
> > +void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath);
> >   void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
> >                                        uint64_t *can_postcopy);
> >   void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> > diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> > index d808ece3b9..b1ec51c77a 100644
> > --- a/hw/s390x/s390-stattrib.c
> > +++ b/hw/s390x/s390-stattrib.c
> > @@ -187,15 +187,14 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
> >       return 0;
> >   }
> > 
> > -static void cmma_state_pending(void *opaque, uint64_t *must_precopy,
> > -                               uint64_t *can_postcopy)
> > +static void cmma_state_pending(void *opaque, MigPendingData *pending)
> >   {
> >       S390StAttribState *sas = S390_STATTRIB(opaque);
> >       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> >       long long res = sac->get_dirtycount(sas);
> > 
> >       if (res >= 0) {
> > -        *must_precopy += res;
> > +        pending->precopy_bytes += res;
> >       }
> >   }
> > 
> > @@ -340,8 +339,7 @@ static SaveVMHandlers savevm_s390_stattrib_handlers = {
> >       .save_setup = cmma_save_setup,
> >       .save_live_iterate = cmma_save_iterate,
> >       .save_complete = cmma_save_complete,
> > -    .state_pending_exact = cmma_state_pending,
> > -    .state_pending_estimate = cmma_state_pending,
> > +    .save_query_pending = cmma_state_pending,
> >       .save_cleanup = cmma_save_cleanup,
> >       .load_state = cmma_load,
> >       .is_active = cmma_active,
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 827d3ded63..c054c749b0 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -570,42 +570,51 @@ static void vfio_save_cleanup(void *opaque)
> >       trace_vfio_save_cleanup(vbasedev->name);
> >   }
> > 
> > -static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> > -                                        uint64_t *can_postcopy)
> > +static void vfio_state_pending_sync(VFIODevice *vbasedev)
> >   {
> > -    VFIODevice *vbasedev = opaque;
> >       VFIOMigration *migration = vbasedev->migration;
> > 
> > -    if (!vfio_device_state_is_precopy(vbasedev)) {
> > -        return;
> > -    }
> > +    vfio_query_stop_copy_size(vbasedev);
> > 
> > -    *must_precopy +=
> > -        migration->precopy_init_size + migration->precopy_dirty_size;
> > +    if (vfio_device_state_is_precopy(vbasedev)) {
> > +        vfio_query_precopy_size(migration);
> > +    }
> > 
> > -    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
> > -                                      *can_postcopy,
> > -                                      migration->precopy_init_size,
> > -                                      migration->precopy_dirty_size);
> > +    /*
> > +     * In all cases, all PRECOPY data should be no more than STOPCOPY data.
> > +     * Otherwise we have a problem.  So far, only dump some errors.
> > +     */
> 
> I'm not sure that must be true, as stopcopy and precopy queries are not
> atomic, so device state size can change between the queries.

I believe I wrote this only based on my (proven wrong) understanding of
stopcopy size, which I thought was an upper bound. It looks not..  If so,
yes, atomicity will be a problem..

Is below all the doc I can find regarding to this ioctl?  vfio.h has:

/*
 * Upon VFIO_DEVICE_FEATURE_GET read back the estimated data length that will
 * be required to complete stop copy.
 *
 * Note: Can be called on each device state.
 */

struct vfio_device_feature_mig_data_size {
	__aligned_u64 stop_copy_length;
};

#define VFIO_DEVICE_FEATURE_MIG_DATA_SIZE 9

I understand all driver authors want to be flexible, but I wonder if I'm
the only person keep getting confused by the VFIO migration API on
providing estimated results all over the places, and it'll be definitely
more confusing if it can shrink.  We can leave this part of discussion in
the other thread.

I don't think this check is a must; I can simply remove it, however please
help me to understand better on this interface.

Another note is that the goal of this series is to provide any way so the
mgmt can query pending information when VFIO is involved during migration.

This series only exposed (hopefully, much more accurate) expected_downtime.

When repost, I plan to add a system-wise remaining data field so the mgmt
can fetch for each of the iterations to predict any possible unconvergence,
for example, query remaining data and if it stops shrinking for a while it
is a simple sign of possible not converging.  It means either downtime
needs adjustments or something else (cancellation is also an option).

Avihai, if you think this goal will also be part of what you or your team
will be looking for, please let me know.  I am always open if you or
someone from your team thinks it easier to take this over as you know
better on this area.  Otherwise I'll respin after I figure out the rest
puzzles with your help.

Thanks,

-- 
Peter Xu


