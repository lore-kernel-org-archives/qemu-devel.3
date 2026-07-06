Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248A3C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wghgx-0002tI-Tx; Mon, 06 Jul 2026 07:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wghgw-0002tA-Mi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wghgu-0002Gv-2w
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783338046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H6cgTZkzMPjhiMOghI17jq8x3fxfTThxihGpxJ92rP4=;
 b=gmKhaS8E2bdMKg6p7tHSsW3ZN0DoaHxwGc3dpgxeoT1Qqwh3T8121Wqop4dy/9fMaHSQ9B
 409Zco2kKyuRPFT/XHR2SnXyaBUv2UkLqHq3xz1/2PhwmvI5g9XRgX68N88AblkZ54q5ka
 aUHH1GHY29a1H3PzFjE43StX40G7YFc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-bk2khP3vOYuBZxBBMpvdlA-1; Mon, 06 Jul 2026 07:40:45 -0400
X-MC-Unique: bk2khP3vOYuBZxBBMpvdlA-1
X-Mimecast-MFC-AGG-ID: bk2khP3vOYuBZxBBMpvdlA_1783338044
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-475b0b4e8d5so2328198f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783338044; x=1783942844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H6cgTZkzMPjhiMOghI17jq8x3fxfTThxihGpxJ92rP4=;
 b=Zpe5h2EuxWu8nCh7XngF/vBmRyhcP1Tk9BR6LDYVLohzP0WJgsPBi8abn1lIZQLUTH
 HQtxcHZ2Pu/mRg0aUNW4vTNLHxGrDrg3+BK2+HDnYsPMpTrJwJHPqcN/trP36BOqyG8Z
 HSVNwmWMmhSMEnofV7nq66d0nQOs4zChIFbH8HiMP29OxY6+3J1uUZSRjKUflFT5arWE
 rc4hvjow4vzTKPK0SA9ruM2sKPJa7CmTcFf7KeOPzX1iQdcqNa4TYkcckKmID0X5W4Mn
 1NLWGIS7w32rD2rgc/Y0FsO9mSsELcUKOGqNIzJH54CC/dxMHqmqt9dunz1qgXAU1f5M
 LIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783338044; x=1783942844;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H6cgTZkzMPjhiMOghI17jq8x3fxfTThxihGpxJ92rP4=;
 b=FUJ+JJAhbgfXsOjjRc2o9ipqBSrCm294lpvUbZITRyEFUU3ENshRma2mzOsVOwoyt3
 jl6BHTZD5BnMIwvgiNfbRGZmuRRKid0cVReYVNPOSs05fHJV7XQYjl33NeYlu0wj5stT
 8vwHGBkQghHiQpZJ9xPjcgZPKTbxFRVfe1n+I9Us4BFtcL4qmgr8qXwSKuO6adI7yYrV
 c9PfrKPsr3vM4AoJjYqeUyLY134IGtpr40v/3RrwfJOtomNOCEM+uxa8P+HHghhAK3Oi
 UyBqiM7GyIEsedneGpbUIpKxa2/Dx17LsaAFepeGg+Kv205Vdm148WpFEnSwbAqAdSit
 Oc5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7oQLHGGB3rgLywjW4nZH3Dq0mPl6peDpv3uU5xw4N/KhiblYZFbPz/Atu2V2LzSIrhEt6cB25IN5S@nongnu.org
X-Gm-Message-State: AOJu0YxHwzEMRKHNWnXyYiFUOUeODMnoYulFAY/WlNo9jJQlpg02m7TG
 9NoVKu80iFWo574wK1XXBprtW6sB2sXwAFETdOUquuvXTRHXQZyebrPbHzIoedfa7oN0bz/Zodm
 jjR/N603adzt+CX4RTA/gJYnVhTrFa4aulyE5PvmsLYaNApLPQ/YTIwp+
X-Gm-Gg: AfdE7cnAHIDjOo14ke7kaQZ+QXNjjvLam9N7thQyOELlCKTFtByVx40OVsfLwIAunS2
 FOQB3+szC5J688mz7t/3BiZ59NsQOVMaEV3cNdiktsooi2M3IWvxZSKUZqohlAToNX5ULq/BI5a
 9Kq03+zzCgQ+nIJNUyPhs33WrMDLL2XZJe85PLD5gSqrM2qCljwlZDpSSj2hDh7PLKJpzyXVm/m
 ednyJUJOS9y5tx0Jz8WW2IVdP+8okh+6EuBEyBzBYPV6DgLnVokDQky7QrE+2AS/TfLSc/Ps9er
 5tmq3d27DlMGtz3MYuHIwkv99Hfdk66XBKpp4tyJEB4XKXE7AyUxHMogGz6OgvB78oI91QOxOxR
 jsWCaREmQNUR62GTUMaVKYCjMrE2YZSdFC9rwmhf6G2hGBaWxug==
X-Received: by 2002:a05:6000:1813:b0:475:f100:3600 with SMTP id
 ffacd0b85a97d-47aae69dee3mr8497247f8f.61.1783338044028; 
 Mon, 06 Jul 2026 04:40:44 -0700 (PDT)
X-Received: by 2002:a05:6000:1813:b0:475:f100:3600 with SMTP id
 ffacd0b85a97d-47aae69dee3mr8497185f8f.61.1783338043429; 
 Mon, 06 Jul 2026 04:40:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f213e8sm21211461f8f.34.2026.07.06.04.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:40:42 -0700 (PDT)
Message-ID: <7ceda49f-9696-4168-bdcb-d4949ee6f5aa@redhat.com>
Date: Mon, 6 Jul 2026 13:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/16] migration: Run final save_query_pending at
 switchover
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
 <20260706085211.13905-4-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260706085211.13905-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter, Lukas,

On 7/6/26 10:51, Avihai Horon wrote:
> Before switchover, the source needs one last exact pending query so
> modules can flush dirty state. This is currently done ad hoc in modules
> handlers. For example, RAM syncs its dirty bitmap in its save_complete
> handler.
> 
> This should be a general concept relevant for any module, so extract it
> to migration core instead by running a final save_query_pending before
> switchover.
> 
> The final query requires special handling by modules (e.g., it's called
> with BQL locked, during VM stop), so extend save_query_pending
> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
> flag so migration modules can tell the last pending query during
> switchover from periodic iteration queries.
> 
> Call final pending query also in COLO checkpoint, which needs to flush
> dirty state before the checkpoint's live state is saved. Unlike a
> regular switchover, COLO reaches completion repeatedly for every
> checkpoint, so this must be done on each one.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   include/migration/register.h   | 41 ++++++++++++++++++----------------
>   migration/savevm.h             |  3 ++-
>   hw/s390x/s390-stattrib.c       |  2 +-
>   hw/vfio/migration.c            | 11 ++++++---
>   migration/block-dirty-bitmap.c | 11 ++++++---
>   migration/colo.c               | 10 +++++++++
>   migration/migration.c          | 14 ++++++++++--
>   migration/ram.c                | 40 +++++++++++++++++++--------------
>   migration/savevm.c             | 20 +++++++++++++----
>   hw/vfio/trace-events           |  2 +-
>   migration/trace-events         |  2 +-
>   11 files changed, 104 insertions(+), 52 deletions(-)

It'd be nice to have your R-b again. Patch is the same, it includes
the colo fix.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 5e5e0ee432..6f632123f1 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
>        */
>       bool (*is_active_iterate)(void *opaque);
>   
> +    /**
> +     * @save_query_pending
> +     *
> +     * This estimates the remaining data to transfer on the source side.
> +     *
> +     * When @exact is true, a module must report accurate results.  When
> +     * @exact is false, a module may report estimates.
> +     *
> +     * It's highly recommended that modules implement a faster version of
> +     * the query path (for example, by proper caching on the counters) if
> +     * an accurate query will be time-consuming.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @pending: pointer to a MigPendingData struct
> +     * @exact: set to true for an accurate (slow) query
> +     * @final: set to true for the final query during switchover. When final is
> +     * true, the query is called with BQL locked. Otherwise, it's called with
> +     * BQL unlocked.
> +     */
> +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> +                               bool exact, bool final);
> +
>       /* This runs outside the BQL in the migration case, and
>        * within the lock in the savevm case.  The callback had better only
>        * use data that is local to the migration thread or protected
> @@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
>        */
>       bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>   
> -    /**
> -     * @save_query_pending
> -     *
> -     * This estimates the remaining data to transfer on the source side.
> -     *
> -     * When @exact is true, a module must report accurate results.  When
> -     * @exact is false, a module may report estimates.
> -     *
> -     * It's highly recommended that modules implement a faster version of
> -     * the query path (for example, by proper caching on the counters) if
> -     * an accurate query will be time-consuming.
> -     *
> -     * @opaque: data pointer passed to register_savevm_live()
> -     * @pending: pointer to a MigPendingData struct
> -     * @exact: set to true for an accurate (slow) query
> -     */
> -    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> -                               bool exact);
> -
>       /**
>        * @load_state
>        *
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b6bb4fa977..81abd96dda 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>   void qemu_savevm_state_cleanup(void);
>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>   int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
> +void qemu_savevm_query_pending_final(MigPendingData *pending);
>   int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>   bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>   void qemu_savevm_state_end(QEMUFile *f);
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c334714b31..b0f04eb30c 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -190,7 +190,7 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   }
>   
>   static void cmma_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>   {
>       S390StAttribState *sas = S390_STATTRIB(opaque);
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index fb12b9717f..195498845e 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -622,13 +622,18 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
>   }
>   
>   static void vfio_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t precopy_size, stopcopy_size;
>   
> -    if (exact) {
> +    /*
> +     * The final pending query runs during switchover downtime. VFIO does not
> +     * need a fresh device pending-data query then to get the latest dirty
> +     * data, so avoid the extra work and report the cached counters below.
> +     */
> +    if (exact && !final) {
>           vfio_state_pending_sync(vbasedev);
>       }
>   
> @@ -646,7 +651,7 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
>   
>       trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
>                                migration->precopy_init_size,
> -                             migration->precopy_dirty_size, exact);
> +                             migration->precopy_dirty_size, exact, final);
>   }
>   
>   static bool vfio_is_active_iterate(void *opaque)
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 7ef3759e53..cba54e25cd 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -767,13 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>   }
>   
>   static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
> -                                       bool exact)
> +                                       bool exact, bool final)
>   {
>       DBMSaveState *s = &((DBMState *)opaque)->save;
>       SaveBitmapState *dbms;
>       uint64_t pending = 0;
>   
> -    bql_lock();
> +    /* Final pending query is called with BQL locked */
> +    if (!final) {
> +        bql_lock();
> +    }
>   
>       QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>           uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
> @@ -783,7 +786,9 @@ static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
>           pending += DIV_ROUND_UP(sectors * BDRV_SECTOR_SIZE, gran);
>       }
>   
> -    bql_unlock();
> +    if (!final) {
> +        bql_unlock();
> +    }
>   
>       trace_dirty_bitmap_state_pending(pending);
>   
> diff --git a/migration/colo.c b/migration/colo.c
> index 2d36f933cf..08632d5e4a 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -409,6 +409,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>                                             QEMUFile *fb)
>   {
>       Error *local_err = NULL;
> +    MigPendingData pending = {};
>       int ret = -1;
>   
>       colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECKPOINT_REQUEST,
> @@ -465,6 +466,15 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>       if (migrate_auto_converge()) {
>           mig_throttle_counter_reset();
>       }
> +
> +    /*
> +     * Run the final pending query so migration modules can flush their dirty
> +     * state (e.g., RAM syncs its dirty bitmap) before this checkpoint's live
> +     * state is saved. Unlike a regular switchover, COLO reaches completion
> +     * repeatedly for every checkpoint, so this must be done on each one.
> +     */
> +    qemu_savevm_query_pending_final(&pending);
> +
>       /*
>        * Only save VM's live state, which not including device state.
>        * TODO: We may need a timeout mechanism to prevent COLO process
> diff --git a/migration/migration.c b/migration/migration.c
> index 7e0a0bea7a..442f950c43 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2793,12 +2793,22 @@ static bool migration_switchover_prepare(MigrationState *s)
>   static bool migration_switchover_start(MigrationState *s, Error **errp)
>   {
>       ERRP_GUARD();
> +    MigPendingData pending = {};
>   
>       if (!migration_switchover_prepare(s)) {
>           error_setg(errp, "Switchover is interrupted");
>           return false;
>       }
>   
> +    /*
> +     * The final query to the whole system on dirty data to make sure we
> +     * collect the latest status of the VM.  For precopy, source QEMU will
> +     * dump all the dirty data during switchover.  For postcopy, this will
> +     * properly update all the dirty bitmaps to finally generate the
> +     * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
> +     */
> +    qemu_savevm_query_pending_final(&pending);
> +
>       /* Inactivate disks except in COLO */
>       if (!migrate_colo()) {
>           /*
> @@ -3291,7 +3301,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
>       /*
>        * Do a slow sync first before boosting the iteration count.
>        */
> -    qemu_savevm_query_pending(pending, true);
> +    qemu_savevm_query_pending_iter(pending, true);
>   
>       /*
>        * Update the dirty information for the whole system for this
> @@ -3342,7 +3352,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>       bool complete_ready;
>   
>       /* Fast path - get the estimated amount of pending data */
> -    qemu_savevm_query_pending(&pending, false);
> +    qemu_savevm_query_pending_iter(&pending, false);
>   
>       if (in_postcopy) {
>           /*
> diff --git a/migration/ram.c b/migration/ram.c
> index 55aa9b47dc..8918b2f03b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2686,9 +2686,6 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
>   
>       RCU_READ_LOCK_GUARD();
>   
> -    /* This should be our last sync, the src is now paused */
> -    migration_bitmap_sync_precopy(true);
> -
>       /* Easiest way to make sure we don't resume in the middle of a host-page */
>       rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
>       rs->last_seen_block = NULL;
> @@ -3376,10 +3373,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>       rs->last_stage = !migration_in_colo_state();
>   
>       WITH_RCU_READ_LOCK_GUARD() {
> -        if (!migration_in_postcopy()) {
> -            migration_bitmap_sync_precopy(true);
> -        }
> -
>           ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>           if (ret < 0) {
>               qemu_file_set_error(f, ret);
> @@ -3442,25 +3435,38 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>       return qemu_fflush(f);
>   }
>   
> -static void ram_state_pending(void *opaque, MigPendingData *pending,
> -                              bool exact)
> +static void ram_state_pending_sync(bool exact, bool final)
>   {
> -    RAMState **temp = opaque;
> -    RAMState *rs = *temp;
> -    uint64_t remaining_size;
> -
>       /*
>        * Sync is not needed either with: (1) a fast query, or (2) after
>        * postcopy has started (no new dirty will generate anymore).
>        */
> -    if (exact && !migration_in_postcopy()) {
> +    if (!exact || migration_in_postcopy()) {
> +        return;
> +    }
> +
> +    /* Final pending query is called with BQL locked */
> +    if (!final) {
>           bql_lock();
> -        WITH_RCU_READ_LOCK_GUARD() {
> -            migration_bitmap_sync_precopy(false);
> -        }
> +    }
> +
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        migration_bitmap_sync_precopy(final);
> +    }
> +
> +    if (!final) {
>           bql_unlock();
>       }
> +}
> +
> +static void ram_state_pending(void *opaque, MigPendingData *pending,
> +                              bool exact, bool final)
> +{
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;
> +    uint64_t remaining_size;
>   
> +    ram_state_pending_sync(exact, final);
>       remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
>   
>       if (migrate_postcopy_ram()) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7e2a0c2b4a..74d622583e 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1801,7 +1801,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
>       return 0;
>   }
>   
> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
> +static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
> +                                      bool final)
>   {
>       SaveStateEntry *se;
>   
> @@ -1814,7 +1815,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>           if (!qemu_savevm_state_active(se)) {
>               continue;
>           }
> -        se->ops->save_query_pending(se->opaque, pending, exact);
> +        se->ops->save_query_pending(se->opaque, pending, exact, final);
>       }
>   
>       pending->total_bytes = pending->precopy_bytes +
> @@ -1826,13 +1827,24 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>        * close to reality when this got invoked frequently while iterating.
>        */
>       mig_stats.dirty_bytes_total = pending->total_bytes;
> -
> -    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
> +    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
>                                       pending->stopcopy_bytes,
>                                       pending->postcopy_bytes,
>                                       pending->total_bytes);
>   }
>   
> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
> +{
> +    qemu_savevm_query_pending(pending, exact, false);
> +}
> +
> +void qemu_savevm_query_pending_final(MigPendingData *pending)
> +{
> +    g_assert(bql_locked());
> +
> +    qemu_savevm_query_pending(pending, true, true);
> +}
> +
>   void qemu_savevm_state_cleanup(void)
>   {
>       SaveStateEntry *se;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 4c28b3291c..fa2204f002 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -176,7 +176,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_save_iterate_start(const char *name) " (%s)"
>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
> -vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
> +vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976ab..1c9212d3e2 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>   qemu_loadvm_state_post_main(int ret) "%d"
>   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>   qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
> +qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
>   loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>   loadvm_state_setup(void) ""
>   loadvm_state_cleanup(void) ""


