Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FDE10F2840
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68we-0003Fm-A2; Fri, 27 Mar 2026 11:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w68wb-0003FX-NZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w68wY-000541-R3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774624669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YpBYhi2m6AptHkdkk76uhi0tTU6007ZARFXMcizC8I=;
 b=KzGotyKP/fZjw32KFV2GlrQZzg6/Is6kjTeeLLVDjQhV6Bl4KXFcEQk3HGcXChO8RJky5x
 acQpbJt56VrxESNqWeLCnP1YQRFjL09K7jzTnQt3n1AcBdajTlByAMniJ4sriG7avVQqgz
 JTqM20V+tnghNOImeqvoYQGYn8Mzav4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-rVtnNPWtPxKDPMfZBuqFig-1; Fri, 27 Mar 2026 11:17:47 -0400
X-MC-Unique: rVtnNPWtPxKDPMfZBuqFig-1
X-Mimecast-MFC-AGG-ID: rVtnNPWtPxKDPMfZBuqFig_1774624666
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-661827d7a81so3235009a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774624666; x=1775229466; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7YpBYhi2m6AptHkdkk76uhi0tTU6007ZARFXMcizC8I=;
 b=U3Kf7aRrZN3SiM7ZjEkobOpss+iCEFZMa6Cyclfulp1tO5Is/DsOoTJcF/nn3hbWS9
 /2umGsZSx7qAh1bqWKO1M3bvgUK4r8f/WNjjhKmwt9LC57EbMRz3qMniEh879oDtEVrK
 nbdZ8UqOfgVCvAgtzR0eiBvfO0+Xr2M3oiqNU7r1UzCftQ/+eJMiDgmfTynfFbvYIC3s
 KPGw8fq/xT3Zqj8R2IbcCM6PkT24DTcDaBEvDFCaIsNf1EhmRY0FfXCTmYrhftcARVhk
 BIq1IcT/yHMwM9fo/llQxa2nsLFCDmndrcixExgs90uUP11iVZ74VIgRP6IF2zOQWSRD
 OtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774624666; x=1775229466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7YpBYhi2m6AptHkdkk76uhi0tTU6007ZARFXMcizC8I=;
 b=RqYS3UTyS4hQLimf/fUqPHt6wxdkFB5cROYQdu1HUiLewUploMxKK2Ia+H5VzpS/sc
 eyQPBaPCV6Z9R+lw28325FTMN8ObSYElVNaMYuKwEgsO3hrFSe+pG8PEyj3QtSpxRGgH
 dQIvqNVJq0wnmIID4I/eLCTWjSPbpCpJG383OR3bU0t1nBx6eWS6hEYW5WJcfV6gUg/h
 rdAo4Nhfkuxi56zJgtnSWaCoeOZbbtQvpCHVcF5PCPjKusjo6WsCw3G2X20PekjhlgYl
 jDYzfDiF3r3cPXXXkyze4qdKvZcM/dIrpiQAmRR8vgZ91JcNNjlIGGLalRaLf+uqFAk0
 0zUg==
X-Gm-Message-State: AOJu0Yx2RewvltPc4Ogtk89aFgjjR5KVHqVpVc0ncbgS/s4PZdq4n0Xa
 kYXSoG8NobFzlV/79LisKYa+0s1DPa2ZtB8KkX7H+RCzPne/hKHrkYRh4Gr8kU9KLHMWvsX9X5a
 T+wbmwEuMKGfgrvZSkjladH6DvZNMhLDT5xeYv3gEY7EeDHazJAFD91cx
X-Gm-Gg: ATEYQzw0WgApWr25xdZpJhEQ5874Nkw50m8FXelw6UFf2rBhXRIUdhnMTMKuR5GVUdW
 qRfK7W7QZqRZ+vd063BgXrc3rY9d4Q+XEbMQo+xb5ezGTdjK6FUexVajYUX5XPA9CCH/RfAZ2Rg
 PkI7eb1vSZ4Wo4aU+eyiGw8m1BpS1tfTREimcu7+M06c0/8k5qpkzbhzfCtlMmvAl3/6b7ATJMB
 ZGmBvUJo/22EeeXTlpNY8KdcQah+2hdtzn7ya/DyRzQuCQmRyJpIy0FGNPKcxjs2yNtZj5rVKIr
 IHMZ49DDaSvgr2gYbpS7/bGRoOqqmJrbyqiXrdfQycqJ6a5nif3QSFKlq9HUqSOv6Fyc9Px7PLV
 qAg==
X-Received: by 2002:a05:6402:52cf:b0:667:90c1:844 with SMTP id
 4fb4d7f45d1cf-66b2af342a2mr1583368a12.10.1774624666302; 
 Fri, 27 Mar 2026 08:17:46 -0700 (PDT)
X-Received: by 2002:a05:6402:52cf:b0:667:90c1:844 with SMTP id
 4fb4d7f45d1cf-66b2af342a2mr1583336a12.10.1774624665683; 
 Fri, 27 Mar 2026 08:17:45 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66ad5e3afd4sm2395873a12.5.2026.03.27.08.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:17:45 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:17:42 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>, 
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC 05/12] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
Message-ID: <acac25816hL_3gyY@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319231302.123135-6-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2026-03-19 19:12, Peter Xu wrote:
> These two APIs are a slight duplication.  For example, there're a few users
> that directly pass in the same function.
> 
> It might also be slightly error prone to provide two hooks, so that it's
> easier to happen that one module report different things via the two
> hooks. In reality they should always report the same thing, only about
> whether we should use a fast-path when the slow path might be too slow, and
> even if we need to pay with some less accuracy.
> 
> Let's just merge it into one API, but instead provide a bool showing if the
> query is a fast query or not.
> 
> No functional change intended.
> 
> Export qemu_savevm_query_pending().  We should likely directly use the new
> API here provided when there're new users to do the query.  This will
> happen very soon.
> 
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Jason Herne <jjherne@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/migration/main.rst  |  5 ++-
>  docs/devel/migration/vfio.rst  |  9 ++----
>  include/migration/register.h   | 52 ++++++++++--------------------
>  migration/savevm.h             |  3 ++
>  hw/s390x/s390-stattrib.c       |  8 ++---
>  hw/vfio/migration.c            | 58 +++++++++++++++++++---------------
>  migration/block-dirty-bitmap.c |  9 ++----
>  migration/ram.c                | 32 ++++++-------------
>  migration/savevm.c             | 43 ++++++++++++-------------
>  hw/vfio/trace-events           |  3 +-
>  10 files changed, 93 insertions(+), 129 deletions(-)
> 
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 234d280249..22c5910d5c 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -519,9 +519,8 @@ An iterative device must provide:
>      data we must save.  The core migration code will use this to
>      determine when to pause the CPUs and complete the migration.
>  
> -  - A ``state_pending_estimate`` function that indicates how much more
> -    data we must save.  When the estimated amount is smaller than the
> -    threshold, we call ``state_pending_exact``.
> +  - A ``save_query_pending`` function that indicates how much more
> +    data we must save.
>  
>    - A ``save_live_iterate`` function should send a chunk of data until
>      the point that stream bandwidth limits tell it to stop.  Each call
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index 0790e5031d..33768c877c 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -50,13 +50,8 @@ VFIO implements the device hooks for the iterative approach as follows:
>  * A ``load_setup`` function that sets the VFIO device on the destination in
>    _RESUMING state.
>  
> -* A ``state_pending_estimate`` function that reports an estimate of the
> -  remaining pre-copy data that the vendor driver has yet to save for the VFIO
> -  device.
> -
> -* A ``state_pending_exact`` function that reads pending_bytes from the vendor
> -  driver, which indicates the amount of data that the vendor driver has yet to
> -  save for the VFIO device.
> +* A ``save_query_pending`` function that reports the remaining pre-copy
> +  data that the vendor driver has yet to save for the VFIO device.
>  
>  * An ``is_active_iterate`` function that indicates ``save_live_iterate`` is
>    active only when the VFIO device is in pre-copy states.
> diff --git a/include/migration/register.h b/include/migration/register.h
> index d0f37f5f43..2320c3a981 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -16,6 +16,15 @@
>  
>  #include "hw/core/vmstate-if.h"
>  
> +typedef struct MigPendingData {
> +    /* How many bytes are pending for precopy / stopcopy? */
> +    uint64_t precopy_bytes;
> +    /* How many bytes are pending that can be transferred in postcopy? */
> +    uint64_t postcopy_bytes;
> +    /* Is this a fastpath query (which can be inaccurate)? */
> +    bool fastpath;
> +} MigPendingData ;

I agree with Prasad, that name fastpath seems unnatural, I think using
estimate (or exact and invert conditions) would be better.

> +
>  /**
>   * struct SaveVMHandlers: handler structure to finely control
>   * migration of complex subsystems and devices, such as RAM, block and
> @@ -197,46 +206,17 @@ typedef struct SaveVMHandlers {
>      bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>  
>      /**
> -     * @state_pending_estimate
> -     *
> -     * This estimates the remaining data to transfer
> -     *
> -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> -     * pending data.
> -     *
> -     * @opaque: data pointer passed to register_savevm_live()
> -     * @must_precopy: amount of data that must be migrated in precopy
> -     *                or in stopped state, i.e. that must be migrated
> -     *                before target start.
> -     * @can_postcopy: amount of data that can be migrated in postcopy
> -     *                or in stopped state, i.e. after target start.
> -     *                Some can also be migrated during precopy (RAM).
> -     *                Some must be migrated after source stops
> -     *                (block-dirty-bitmap)
> -     */
> -    void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
> -                                   uint64_t *can_postcopy);
> -
> -    /**
> -     * @state_pending_exact
> -     *
> -     * This calculates the exact remaining data to transfer
> +     * @save_query_pending
>       *
> -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> -     * pending data.
> +     * This estimates the remaining data to transfer on the source side.
> +     * It's highly suggested that the module should implement both fastpath
> +     * and slowpath version of it when it can be slow (for more information
> +     * please check pending->fastpath field).
>       *
>       * @opaque: data pointer passed to register_savevm_live()
> -     * @must_precopy: amount of data that must be migrated in precopy
> -     *                or in stopped state, i.e. that must be migrated
> -     *                before target start.
> -     * @can_postcopy: amount of data that can be migrated in postcopy
> -     *                or in stopped state, i.e. after target start.
> -     *                Some can also be migrated during precopy (RAM).
> -     *                Some must be migrated after source stops
> -     *                (block-dirty-bitmap)
> +     * @pending: pointer to a MigPendingData struct
>       */
> -    void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
> -                                uint64_t *can_postcopy);
> +    void (*save_query_pending)(void *opaque, MigPendingData *pending);
>  
>      /**
>       * @load_state
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b3d1e8a13c..b116933bce 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -14,6 +14,8 @@
>  #ifndef MIGRATION_SAVEVM_H
>  #define MIGRATION_SAVEVM_H
>  
> +#include "migration/register.h"
> +
>  #define QEMU_VM_FILE_MAGIC           0x5145564d
>  #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
>  #define QEMU_VM_FILE_VERSION         0x00000003
> @@ -43,6 +45,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>  void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(MigrationState *s);
> +void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath);
>  void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>                                       uint64_t *can_postcopy);
>  void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index d808ece3b9..b1ec51c77a 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -187,15 +187,14 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>      return 0;
>  }
>  
> -static void cmma_state_pending(void *opaque, uint64_t *must_precopy,
> -                               uint64_t *can_postcopy)
> +static void cmma_state_pending(void *opaque, MigPendingData *pending)
>  {
>      S390StAttribState *sas = S390_STATTRIB(opaque);
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>      long long res = sac->get_dirtycount(sas);
>  
>      if (res >= 0) {
> -        *must_precopy += res;
> +        pending->precopy_bytes += res;
>      }
>  }
>  
> @@ -340,8 +339,7 @@ static SaveVMHandlers savevm_s390_stattrib_handlers = {
>      .save_setup = cmma_save_setup,
>      .save_live_iterate = cmma_save_iterate,
>      .save_complete = cmma_save_complete,
> -    .state_pending_exact = cmma_state_pending,
> -    .state_pending_estimate = cmma_state_pending,
> +    .save_query_pending = cmma_state_pending,
>      .save_cleanup = cmma_save_cleanup,
>      .load_state = cmma_load,
>      .is_active = cmma_active,
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 827d3ded63..c054c749b0 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -570,42 +570,51 @@ static void vfio_save_cleanup(void *opaque)
>      trace_vfio_save_cleanup(vbasedev->name);
>  }
>  
> -static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> -                                        uint64_t *can_postcopy)
> +static void vfio_state_pending_sync(VFIODevice *vbasedev)
>  {
> -    VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
>  
> -    if (!vfio_device_state_is_precopy(vbasedev)) {
> -        return;
> -    }
> +    vfio_query_stop_copy_size(vbasedev);
>  
> -    *must_precopy +=
> -        migration->precopy_init_size + migration->precopy_dirty_size;
> +    if (vfio_device_state_is_precopy(vbasedev)) {
> +        vfio_query_precopy_size(migration);
> +    }
>  
> -    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
> -                                      *can_postcopy,
> -                                      migration->precopy_init_size,
> -                                      migration->precopy_dirty_size);
> +    /*
> +     * In all cases, all PRECOPY data should be no more than STOPCOPY data.
> +     * Otherwise we have a problem.  So far, only dump some errors.
> +     */
> +    if (migration->precopy_init_size + migration->precopy_dirty_size <
> +        migration->stopcopy_size) {
> +        error_report_once("%s: wrong pending data (init=%" PRIx64
> +                          ", dirty=%"PRIx64", stop=%"PRIx64")",
> +                          __func__, migration->precopy_init_size,
> +                          migration->precopy_dirty_size,
> +                          migration->stopcopy_size);
> +    }
>  }
>  
> -static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
> -                                     uint64_t *can_postcopy)
> +static void vfio_state_pending(void *opaque, MigPendingData *pending)
>  {
>      VFIODevice *vbasedev = opaque;
>      VFIOMigration *migration = vbasedev->migration;
> +    uint64_t remain;
>  
> -    vfio_query_stop_copy_size(vbasedev);
> -    *must_precopy += migration->stopcopy_size;
> -
> -    if (vfio_device_state_is_precopy(vbasedev)) {
> -        vfio_query_precopy_size(migration);
> +    if (pending->fastpath) {
> +        if (!vfio_device_state_is_precopy(vbasedev)) {
> +            return;
> +        }
> +        remain = migration->precopy_init_size + migration->precopy_dirty_size;
> +    } else {
> +        vfio_state_pending_sync(vbasedev);
> +        remain = migration->stopcopy_size;
>      }
>  
> -    trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
> -                                   migration->stopcopy_size,
> -                                   migration->precopy_init_size,
> -                                   migration->precopy_dirty_size);
> +    pending->precopy_bytes += remain;
> +
> +    trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
> +                             migration->precopy_init_size,
> +                             migration->precopy_dirty_size);
>  }
>  
>  static bool vfio_is_active_iterate(void *opaque)
> @@ -850,8 +859,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>      .save_prepare = vfio_save_prepare,
>      .save_setup = vfio_save_setup,
>      .save_cleanup = vfio_save_cleanup,
> -    .state_pending_estimate = vfio_state_pending_estimate,
> -    .state_pending_exact = vfio_state_pending_exact,
> +    .save_query_pending = vfio_state_pending,
>      .is_active_iterate = vfio_is_active_iterate,
>      .save_live_iterate = vfio_save_iterate,
>      .save_complete = vfio_save_complete_precopy,
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index a061aad817..376a9b43ac 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -766,9 +766,7 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>      return 0;
>  }
>  
> -static void dirty_bitmap_state_pending(void *opaque,
> -                                       uint64_t *must_precopy,
> -                                       uint64_t *can_postcopy)
> +static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data)
>  {
>      DBMSaveState *s = &((DBMState *)opaque)->save;
>      SaveBitmapState *dbms;
> @@ -788,7 +786,7 @@ static void dirty_bitmap_state_pending(void *opaque,
>  
>      trace_dirty_bitmap_state_pending(pending);
>  
> -    *can_postcopy += pending;
> +    data->postcopy_bytes += pending;
>  }
>  
>  /* First occurrence of this bitmap. It should be created if doesn't exist */
> @@ -1250,8 +1248,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>      .save_setup = dirty_bitmap_save_setup,
>      .save_complete = dirty_bitmap_save_complete,
>      .has_postcopy = dirty_bitmap_has_postcopy,
> -    .state_pending_exact = dirty_bitmap_state_pending,
> -    .state_pending_estimate = dirty_bitmap_state_pending,
> +    .save_query_pending = dirty_bitmap_state_pending,
>      .save_live_iterate = dirty_bitmap_save_iterate,
>      .is_active_iterate = dirty_bitmap_is_active_iterate,
>      .load_state = dirty_bitmap_load,
> diff --git a/migration/ram.c b/migration/ram.c
> index 979751f61b..89f761a471 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3443,30 +3443,17 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      return qemu_fflush(f);
>  }
>  
> -static void ram_state_pending_estimate(void *opaque, uint64_t *must_precopy,
> -                                       uint64_t *can_postcopy)
> -{
> -    RAMState **temp = opaque;
> -    RAMState *rs = *temp;
> -
> -    uint64_t remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> -
> -    if (migrate_postcopy_ram()) {
> -        /* We can do postcopy, and all the data is postcopiable */
> -        *can_postcopy += remaining_size;
> -    } else {
> -        *must_precopy += remaining_size;
> -    }
> -}
> -
> -static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
> -                                    uint64_t *can_postcopy)
> +static void ram_state_pending(void *opaque, MigPendingData *pending)
>  {
>      RAMState **temp = opaque;
>      RAMState *rs = *temp;
>      uint64_t remaining_size;
>  
> -    if (!migration_in_postcopy()) {
> +    /*
> +     * Sync is only needed either with: (1) a fast query, or (2) postcopy
> +     * as started (in which case no new dirty will generate anymore).
> +     */
> +    if (!pending->fastpath && !migration_in_postcopy()) {
>          bql_lock();
>          WITH_RCU_READ_LOCK_GUARD() {
>              migration_bitmap_sync_precopy(false);
> @@ -3478,9 +3465,9 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
>  
>      if (migrate_postcopy_ram()) {
>          /* We can do postcopy, and all the data is postcopiable */
> -        *can_postcopy += remaining_size;
> +        pending->postcopy_bytes += remaining_size;
>      } else {
> -        *must_precopy += remaining_size;
> +        pending->precopy_bytes += remaining_size;
>      }
>  }
>  
> @@ -4703,8 +4690,7 @@ static SaveVMHandlers savevm_ram_handlers = {
>      .save_live_iterate = ram_save_iterate,
>      .save_complete = ram_save_complete,
>      .has_postcopy = ram_has_postcopy,
> -    .state_pending_exact = ram_state_pending_exact,
> -    .state_pending_estimate = ram_state_pending_estimate,
> +    .save_query_pending = ram_state_pending,
>      .load_state = ram_load,
>      .save_cleanup = ram_save_cleanup,
>      .load_setup = ram_load_setup,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index dd58f2a705..6268e68382 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1762,46 +1762,45 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
>      return qemu_fflush(f);
>  }
>  
> -/* Give an estimate of the amount left to be transferred,
> - * the result is split into the amount for units that can and
> - * for units that can't do postcopy.
> - */
> -void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> -                                        uint64_t *can_postcopy)
> +void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>  {
>      SaveStateEntry *se;
>  
> -    *must_precopy = 0;
> -    *can_postcopy = 0;
> +    pending->precopy_bytes = 0;
> +    pending->postcopy_bytes = 0;
> +    pending->fastpath = fastpath;
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->state_pending_estimate) {
> +        if (!se->ops || !se->ops->save_query_pending) {
>              continue;
>          }
>          if (!qemu_savevm_state_active(se)) {
>              continue;
>          }
> -        se->ops->state_pending_estimate(se->opaque, must_precopy, can_postcopy);
> +        se->ops->save_query_pending(se->opaque, pending);
>      }
>  }
>  
> +void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> +                                        uint64_t *can_postcopy)
> +{
> +    MigPendingData pending;
> +
> +    qemu_savevm_query_pending(&pending, true);
> +
> +    *must_precopy = pending.precopy_bytes;
> +    *can_postcopy = pending.postcopy_bytes;
> +}
> +
>  void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>                                       uint64_t *can_postcopy)
>  {
> -    SaveStateEntry *se;
> +    MigPendingData pending;
>  
> -    *must_precopy = 0;
> -    *can_postcopy = 0;
> +    qemu_savevm_query_pending(&pending, false);
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->state_pending_exact) {
> -            continue;
> -        }
> -        if (!qemu_savevm_state_active(se)) {
> -            continue;
> -        }
> -        se->ops->state_pending_exact(se->opaque, must_precopy, can_postcopy);
> -    }
> +    *must_precopy = pending.precopy_bytes;
> +    *can_postcopy = pending.postcopy_bytes;
>  }
>  
>  void qemu_savevm_state_cleanup(void)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 846e3625c5..7cf5a9eb2d 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -173,8 +173,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
>  vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>  vfio_save_iterate_start(const char *name) " (%s)"
>  vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
> -vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> -vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> +vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>  vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>  vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>  
> -- 
> 2.50.1
> 


