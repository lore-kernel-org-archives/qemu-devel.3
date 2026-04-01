Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E35910FCAD2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82Yw-0007Op-1x; Wed, 01 Apr 2026 16:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82Yt-0007Kl-Pl
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82Yq-00071f-7g
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775076790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5C9tcOTJlQiDMdf1Cn0FOcL1icR7tdKwKfEDAhG/m8=;
 b=KqB+ciV6tMgR8uIRUfUuE1HPNcHNzhjJDZ+Q15ezWqtiiEIii4Tdx69lbY5Fa+JtszdATH
 b+uWjnKYTMgZVZ93TLun0l0coh58dpwq9nOSaIOmZDL2dvfsBp2IX1yDHA4WWGV2o4402S
 bB8OYkLNK0P6VxGkFzkaT7KPV+/syys=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-skkF0mRWMKaGQ7gLLP8suw-1; Wed, 01 Apr 2026 16:53:07 -0400
X-MC-Unique: skkF0mRWMKaGQ7gLLP8suw-1
X-Mimecast-MFC-AGG-ID: skkF0mRWMKaGQ7gLLP8suw_1775076786
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd827a356aso68724885a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775076786; x=1775681586; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H5C9tcOTJlQiDMdf1Cn0FOcL1icR7tdKwKfEDAhG/m8=;
 b=b9+67LBkAPBxghdkBS+nOctUmGyWKOR89Ihy9SmR5+rE0gCrdDv2UWrKngonM+GPil
 DsWl3Ri3n6gCE1xoh8VRR664Xk98Emg2t6eRE/hVOUjuGBrji+2Cv8dsag5vbAi4XtfT
 uWxpcNWHIRrfh8eqBewXsMb8ojrt14EiuKRa/FzoWWdSloyb1DPl9Gr8UNHStfDnmUsw
 P1ovCIpXP5O/UM2HGWTYEUfAC/QPYDXchIdKEK7TMDQesqSC32F6nw0OzEeapf2/t3XQ
 G9j7f/ucpHIAKot78UG8xqb2oPaJDNanNIqG/oepsXu7nrM9InKkgMTxqofbifDLHcNk
 lf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775076786; x=1775681586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5C9tcOTJlQiDMdf1Cn0FOcL1icR7tdKwKfEDAhG/m8=;
 b=Pj0j8bhDnvFvJVUkHfpdwBB1CBt6XzPrjgOop8Z227ERsiyeC3BZPehQf19sBuMcAW
 FvdNI6wiSdEinWZyoRDFncgNG3nMRfUbEu4Ywb4uAgVB7twbLf8QSmMTpStANLyFXUSd
 +dTHCkC35wmfXjJu7+9/q/1f3o6BD+QH2RIk9htiqLPh8D6mlEInFSuGY2V8QKKNAqCq
 Zd+xc6JBmqqdYKeIQqAS3nLOA2mJzoZfaK3ToNwu2+69vwgFwFKMbSE4aEyb76lpGtod
 Az/J2S65KhcVF/6Srt8e4onTJ4T/I75Mlg8v/HQ0DC9+e1CGO/wnCLUmIaGsmei7tJJP
 1Gwg==
X-Gm-Message-State: AOJu0Yy5PJMUWI3lAucGI50H+BxLei3Xtyok4P/LQJdEy4ayRokz6Pz6
 twpp2ISFawFWCoN4hzQ2TO0atN+0UAIKjiePBBP0mdLQ/RP5mSx5v1cVTXW3DUqEPjV8oaI5dVA
 T0EAut414fHtQKzSWAFnjfqZxAgY4WIFuoJzPJOGupBwp75kH8ukFCt9/
X-Gm-Gg: ATEYQzxnTJCNykTyeLu5G5SRKFVVUQp21OxZI9dFCCpjsxIrrORnFWHeavh6z8s0rR6
 cLlnjHBEPQgtPF4lk7udLElxbk0le75bnkI8XQnB++qbUFjXMQfX+qIVZlhw3/TNdbIieofC2qc
 haP9uNI934sH7RtqfDN4aEEd8fbhFrD8bUReAukHBNOo4h1P+N2s2BktXiv5x/P9+b7+/VIKqdJ
 RhKaJg3jSRFX0qwYD13eJtsmjklkp/8CjfuqTOQ+ubG+rCSkr8iYJsPY9rnI1sbfeReVlD2rAqi
 qJMPq+QJ60CF1XO5GrvzxaMQNK6OgRJOFy4A/jUyJ+XVdAg+C80UZUXMTHSPka7qmbUZ6C8hf6t
 om6WzPhRPjLTU72ArWpkloilXAh9r7PLcWTsTrxO2sY/jUw==
X-Received: by 2002:a05:620a:454c:b0:8cf:c77f:f4e2 with SMTP id
 af79cd13be357-8d1b5c5aeb0mr765096285a.67.1775076786295; 
 Wed, 01 Apr 2026 13:53:06 -0700 (PDT)
X-Received: by 2002:a05:620a:454c:b0:8cf:c77f:f4e2 with SMTP id
 af79cd13be357-8d1b5c5aeb0mr765091585a.67.1775076785485; 
 Wed, 01 Apr 2026 13:53:05 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a874459asm59585185a.39.2026.04.01.13.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:53:05 -0700 (PDT)
Date: Wed, 1 Apr 2026 16:53:03 -0400
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
Message-ID: <ac2FrwjNPfwrKjnL@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-6-peterx@redhat.com>
 <CAE8KmOzjUviaivX_Z6vk=S9DKMyM7aSyx2D1-M25tRsamc1PyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzjUviaivX_Z6vk=S9DKMyM7aSyx2D1-M25tRsamc1PyA@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 04:05:00PM +0530, Prasad Pandit wrote:
> > +typedef struct MigPendingData {
> > +    /* How many bytes are pending for precopy / stopcopy? */
> > +    uint64_t precopy_bytes;
> > +    /* How many bytes are pending that can be transferred in postcopy? */
> > +    uint64_t postcopy_bytes;
> > +    /* Is this a fastpath query (which can be inaccurate)? */
> > +    bool fastpath;
> > +} MigPendingData ;
> > +
> 
> * Pending precopy bytes are: bytes still pending to be sent + dirty
> (updated) bytes; How do we measure/estimate pending postcopy bytes?
> 
> * Could we do away with separating pending bytes into Precopy and
> Postcopy bytes? Instead go with just pending_bytes on the source side?
> 
> * Let's not add another term/variable called stopcopy. It'll only add
> to the confusion.

What would you suggest to solve this problem?

> 
> 
> >  /**
> >   * struct SaveVMHandlers: handler structure to finely control
> >   * migration of complex subsystems and devices, such as RAM, block and
> > @@ -197,46 +206,17 @@ typedef struct SaveVMHandlers {
> >      bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
> >
> >      /**
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
> >       *
> > -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> > -     * pending data.
> > +     * This estimates the remaining data to transfer on the source side.
> > +     * It's highly suggested that the module should implement both fastpath
> > +     * and slowpath version of it when it can be slow (for more information
> > +     * please check pending->fastpath field).
> >       *
> >       * @opaque: data pointer passed to register_savevm_live()
> > -     * @must_precopy: amount of data that must be migrated in precopy
> > -     *                or in stopped state, i.e. that must be migrated
> > -     *                before target start.
> > -     * @can_postcopy: amount of data that can be migrated in postcopy
> > -     *                or in stopped state, i.e. after target start.
> > -     *                Some can also be migrated during precopy (RAM).
> > -     *                Some must be migrated after source stops
> > -     *                (block-dirty-bitmap)
> > +     * @pending: pointer to a MigPendingData struct
> >       */
> > -    void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
> > -                                uint64_t *can_postcopy);
> > +    void (*save_query_pending)(void *opaque, MigPendingData *pending);
> >
> >      /**
> >       * @load_state
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index b3d1e8a13c..b116933bce 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -14,6 +14,8 @@
> >  #ifndef MIGRATION_SAVEVM_H
> >  #define MIGRATION_SAVEVM_H
> >
> > +#include "migration/register.h"
> > +
> >  #define QEMU_VM_FILE_MAGIC           0x5145564d
> >  #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
> >  #define QEMU_VM_FILE_VERSION         0x00000003
> > @@ -43,6 +45,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> >  void qemu_savevm_state_cleanup(void);
> >  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> >  int qemu_savevm_state_complete_precopy(MigrationState *s);
> > +void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath);
> >  void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
> >                                       uint64_t *can_postcopy);
> >  void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> > diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> > index d808ece3b9..b1ec51c77a 100644
> > --- a/hw/s390x/s390-stattrib.c
> > +++ b/hw/s390x/s390-stattrib.c
> > @@ -187,15 +187,14 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
> >      return 0;
> >  }
> >
> > -static void cmma_state_pending(void *opaque, uint64_t *must_precopy,
> > -                               uint64_t *can_postcopy)
> > +static void cmma_state_pending(void *opaque, MigPendingData *pending)
> >  {
> >      S390StAttribState *sas = S390_STATTRIB(opaque);
> >      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> >      long long res = sac->get_dirtycount(sas);
> >
> >      if (res >= 0) {
> > -        *must_precopy += res;
> > +        pending->precopy_bytes += res;
> >      }
> >  }
> >
> > @@ -340,8 +339,7 @@ static SaveVMHandlers savevm_s390_stattrib_handlers = {
> >      .save_setup = cmma_save_setup,
> >      .save_live_iterate = cmma_save_iterate,
> >      .save_complete = cmma_save_complete,
> > -    .state_pending_exact = cmma_state_pending,
> > -    .state_pending_estimate = cmma_state_pending,
> > +    .save_query_pending = cmma_state_pending,
> >      .save_cleanup = cmma_save_cleanup,
> >      .load_state = cmma_load,
> >      .is_active = cmma_active,
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 827d3ded63..c054c749b0 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -570,42 +570,51 @@ static void vfio_save_cleanup(void *opaque)
> >      trace_vfio_save_cleanup(vbasedev->name);
> >  }
> >
> > -static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> > -                                        uint64_t *can_postcopy)
> > +static void vfio_state_pending_sync(VFIODevice *vbasedev)
> >  {
> > -    VFIODevice *vbasedev = opaque;
> >      VFIOMigration *migration = vbasedev->migration;
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
> > +    if (migration->precopy_init_size + migration->precopy_dirty_size <
> > +        migration->stopcopy_size) {
> > +        error_report_once("%s: wrong pending data (init=%" PRIx64
> > +                          ", dirty=%"PRIx64", stop=%"PRIx64")",
> > +                          __func__, migration->precopy_init_size,
> > +                          migration->precopy_dirty_size,
> > +                          migration->stopcopy_size);
> > +    }
> >  }
> >
> > -static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
> > -                                     uint64_t *can_postcopy)
> > +static void vfio_state_pending(void *opaque, MigPendingData *pending)
> >  {
> >      VFIODevice *vbasedev = opaque;
> >      VFIOMigration *migration = vbasedev->migration;
> > +    uint64_t remain;
> >
> > -    vfio_query_stop_copy_size(vbasedev);
> > -    *must_precopy += migration->stopcopy_size;
> > -
> > -    if (vfio_device_state_is_precopy(vbasedev)) {
> > -        vfio_query_precopy_size(migration);
> > +    if (pending->fastpath) {
> > +        if (!vfio_device_state_is_precopy(vbasedev)) {
> > +            return;
> > +        }
> > +        remain = migration->precopy_init_size + migration->precopy_dirty_size;
> > +    } else {
> > +        vfio_state_pending_sync(vbasedev);
> > +        remain = migration->stopcopy_size;
> >      }
> >
> > -    trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
> > -                                   migration->stopcopy_size,
> > -                                   migration->precopy_init_size,
> > -                                   migration->precopy_dirty_size);
> > +    pending->precopy_bytes += remain;
> > +
> > +    trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
> > +                             migration->precopy_init_size,
> > +                             migration->precopy_dirty_size);
> >  }
> >
> >  static bool vfio_is_active_iterate(void *opaque)
> > @@ -850,8 +859,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
> >      .save_prepare = vfio_save_prepare,
> >      .save_setup = vfio_save_setup,
> >      .save_cleanup = vfio_save_cleanup,
> > -    .state_pending_estimate = vfio_state_pending_estimate,
> > -    .state_pending_exact = vfio_state_pending_exact,
> > +    .save_query_pending = vfio_state_pending,
> >      .is_active_iterate = vfio_is_active_iterate,
> >      .save_live_iterate = vfio_save_iterate,
> >      .save_complete = vfio_save_complete_precopy,
> > diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> > index a061aad817..376a9b43ac 100644
> > --- a/migration/block-dirty-bitmap.c
> > +++ b/migration/block-dirty-bitmap.c
> > @@ -766,9 +766,7 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
> >      return 0;
> >  }
> >
> > -static void dirty_bitmap_state_pending(void *opaque,
> > -                                       uint64_t *must_precopy,
> > -                                       uint64_t *can_postcopy)
> > +static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data)
> >  {
> >      DBMSaveState *s = &((DBMState *)opaque)->save;
> >      SaveBitmapState *dbms;
> > @@ -788,7 +786,7 @@ static void dirty_bitmap_state_pending(void *opaque,
> >
> >      trace_dirty_bitmap_state_pending(pending);
> >
> > -    *can_postcopy += pending;
> > +    data->postcopy_bytes += pending;
> >  }
> >
> >  /* First occurrence of this bitmap. It should be created if doesn't exist */
> > @@ -1250,8 +1248,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
> >      .save_setup = dirty_bitmap_save_setup,
> >      .save_complete = dirty_bitmap_save_complete,
> >      .has_postcopy = dirty_bitmap_has_postcopy,
> > -    .state_pending_exact = dirty_bitmap_state_pending,
> > -    .state_pending_estimate = dirty_bitmap_state_pending,
> > +    .save_query_pending = dirty_bitmap_state_pending,
> >      .save_live_iterate = dirty_bitmap_save_iterate,
> >      .is_active_iterate = dirty_bitmap_is_active_iterate,
> >      .load_state = dirty_bitmap_load,
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 979751f61b..89f761a471 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3443,30 +3443,17 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >      return qemu_fflush(f);
> >  }
> >
> > -static void ram_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> > -                                       uint64_t *can_postcopy)
> > -{
> > -    RAMState **temp = opaque;
> > -    RAMState *rs = *temp;
> > -
> > -    uint64_t remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> > -
> > -    if (migrate_postcopy_ram()) {
> > -        /* We can do postcopy, and all the data is postcopiable */
> > -        *can_postcopy += remaining_size;
> > -    } else {
> > -        *must_precopy += remaining_size;
> > -    }
> > -}
> > -
> > -static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
> > -                                    uint64_t *can_postcopy)
> > +static void ram_state_pending(void *opaque, MigPendingData *pending)
> >  {
> >      RAMState **temp = opaque;
> >      RAMState *rs = *temp;
> >      uint64_t remaining_size;
> >
> > -    if (!migration_in_postcopy()) {
> > +    /*
> > +     * Sync is only needed either with: (1) a fast query, or (2) postcopy
> > +     * as started (in which case no new dirty will generate anymore).
> 
> * as -> has
> * (... no new dirty will generate anymore)  - ...?
> 
> > +     */
> > +    if (!pending->fastpath && !migration_in_postcopy()) {
> 
> * The comment above and 'if' conditionals don't seem to match. We are
> saying a call to 'migration_bitmap_sync_precopy()' is needed either
> with fast query ie. 'pending->fastpath = true'  OR Postcopy has
> started ie. migration_in_postcopy() = true, right? What is the
> right/intended behaviour here?

It should have been s/only/not/.. I'll update comment to:

    /*
     * Sync is not needed either with: (1) a fast query, or (2) after
     * postcopy has started (no new dirty will generate anymore).
     */

> 
> >          bql_lock();
> >          WITH_RCU_READ_LOCK_GUARD() {
> >              migration_bitmap_sync_precopy(false);
> > @@ -3478,9 +3465,9 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
> >
> >      if (migrate_postcopy_ram()) {
> >          /* We can do postcopy, and all the data is postcopiable */
> > -        *can_postcopy += remaining_size;
> > +        pending->postcopy_bytes += remaining_size;
> >      } else {
> > -        *must_precopy += remaining_size;
> > +        pending->precopy_bytes += remaining_size;
> >      }
> >  }
> >
> > @@ -4703,8 +4690,7 @@ static SaveVMHandlers savevm_ram_handlers = {
> >      .save_live_iterate = ram_save_iterate,
> >      .save_complete = ram_save_complete,
> >      .has_postcopy = ram_has_postcopy,
> > -    .state_pending_exact = ram_state_pending_exact,
> > -    .state_pending_estimate = ram_state_pending_estimate,
> > +    .save_query_pending = ram_state_pending,
> >      .load_state = ram_load,
> >      .save_cleanup = ram_save_cleanup,
> >      .load_setup = ram_load_setup,
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index dd58f2a705..6268e68382 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1762,46 +1762,45 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
> >      return qemu_fflush(f);
> >  }
> >
> > -/* Give an estimate of the amount left to be transferred,
> > - * the result is split into the amount for units that can and
> > - * for units that can't do postcopy.
> > - */
> > -void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> > -                                        uint64_t *can_postcopy)
> > +void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
> >  {
> >      SaveStateEntry *se;
> >
> > -    *must_precopy = 0;
> > -    *can_postcopy = 0;
> > +    pending->precopy_bytes = 0;
> > +    pending->postcopy_bytes = 0;
> > +    pending->fastpath = fastpath;
> >
> >      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > -        if (!se->ops || !se->ops->state_pending_estimate) {
> > +        if (!se->ops || !se->ops->save_query_pending) {
> >              continue;
> >          }
> >          if (!qemu_savevm_state_active(se)) {
> >              continue;
> >          }
> > -        se->ops->state_pending_estimate(se->opaque, must_precopy, can_postcopy);
> > +        se->ops->save_query_pending(se->opaque, pending);
> >      }
> >  }
> >
> > +void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> > +                                        uint64_t *can_postcopy)
> > +{
> > +    MigPendingData pending;
> > +
> > +    qemu_savevm_query_pending(&pending, true);
> > +
> > +    *must_precopy = pending.precopy_bytes;
> > +    *can_postcopy = pending.postcopy_bytes;
> > +}
> > +
> >  void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
> >                                       uint64_t *can_postcopy)
> >  {
> > -    SaveStateEntry *se;
> > +    MigPendingData pending;
> >
> > -    *must_precopy = 0;
> > -    *can_postcopy = 0;
> > +    qemu_savevm_query_pending(&pending, false);
> >
> > -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > -        if (!se->ops || !se->ops->state_pending_exact) {
> > -            continue;
> > -        }
> > -        if (!qemu_savevm_state_active(se)) {
> > -            continue;
> > -        }
> > -        se->ops->state_pending_exact(se->opaque, must_precopy, can_postcopy);
> > -    }
> > +    *must_precopy = pending.precopy_bytes;
> > +    *can_postcopy = pending.postcopy_bytes;
> >  }
> 
> * IIUC, we send fastpath=true from _pending_estimate() because we want
> to avoid call to migration_bitmap_sync_precopy(), as calling it won't
> be fast. And we send fastpath=false from _pending_exact() function
> because we want to trigger call to migration_bitmap_sync_precopy()
> routine.
> 
> * Instead of calling the boolean parameter 'fastpath',  let's use
> 'bool use_precision'  OR 'bool sync_data'. And then in
> qemu_savevm_query_pending()
> 
>     qemu_savevm_query_pending():
>             if (use_precision || sync_data) {
>                      migration_bitmap_sync_precopy()
>             }
> 
> * When reading code, equating fastpath with 'estimation' and slowpath
> with 'precision/accuracy' is unnatural.

I'll use "exact" as suggested by Juraj.

Thanks,

-- 
Peter Xu


