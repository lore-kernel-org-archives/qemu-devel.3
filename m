Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35218CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWla-0006r6-Vw; Wed, 07 Oct 2026 14:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEWlZ-0006qs-Ej
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEWlW-0003DN-Tq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791399201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZKl9d+pTSU7suVSd5m+FF4hXN8Ml7fhgVQFTZcBAn/M=;
 b=c4In9cXpY9M+c8+ZgnWc4H3nlKCeVeNgnxmqYxHek1qxjOCIrtP1di7w3HFFLrJn2VNS75
 grIMEQptqBTyjs0Lru9hF/OpvXQVLS7OZ50HtFcZz4QKeEqqsH/A0DjLB952vKnFt4WPEb
 lmXnAF7vIJLY2+rIUGjd9/1zkeIegCY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-pqweVvDfOU2Wdwb4csJ0Cw-1; Wed, 07 Oct 2026 14:53:20 -0400
X-MC-Unique: pqweVvDfOU2Wdwb4csJ0Cw-1
X-Mimecast-MFC-AGG-ID: pqweVvDfOU2Wdwb4csJ0Cw_1791399200
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5347732a495so6689341cf.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791399199; x=1792003999; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZKl9d+pTSU7suVSd5m+FF4hXN8Ml7fhgVQFTZcBAn/M=;
 b=a3ZyPUBivoCcviGkR68YgmFMW7wEFysilq5MmVfAPEqPgkj3kMDzAvhhhfkJqPaw88
 zY3aD0W+buIN3wUyTd7wkGt+J0hA5m0bu0NhgGwJRvPMDlAu/+y3/IGC8VETBI0hjDma
 e9XyD3DZBeHdQd75KAJ192WPBlUYIjc5GgfLvF4Ty+9cJrKi5+rqpz1BXfA34Erodlaa
 zOpijfrrbabJWMqSWL+ogKJCEqsG55OrPbtZ0zWG2ApdDdya27+0AfWvlcJxvxp1g8lS
 WtArnSyKWUGIcFFdtfsvKUAuvEg8sUPS9rfYi2e0praDfwsux5+gQwtouujwrG/i6uiG
 /5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791399199; x=1792003999;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZKl9d+pTSU7suVSd5m+FF4hXN8Ml7fhgVQFTZcBAn/M=;
 b=QKt31ZJFrHbz/qnnNlwsUESP0pRRmza+f8mALOMFpRnrgX8xuYiho9WHRaxARVb24z
 QUm3I0OrVRsqRSLJ+tSi4pDzF32GR0+xiOh+Y+R59CPctt+CjBLau5uRaxVEnJYsUD5z
 tHcLQEq0cDwmzrCT2YmGSYe293Y33rZBiYzpbW8D7MNb/mko0zBqh5Gf6DWZQECu4AtL
 GnV+xzXbMEGcvZ+vWigiW9h3BNVP3hK9Mv/OPETxlOHXNXviZiudJrDwCpmt1qKvB4cG
 iO9Dl2fC4VwtwIm8gcB3uBZWtsYndZWbEgUKxpkA0pRVs/tTOeUKxogcW+6XDVMHeLzC
 MFRw==
X-Gm-Message-State: AFuF++lN5CP/BaJRltQwJKOOtr1o33uyXj034fN74VK40ROJuOd7ZMQU
 4VfYbSksZEb+LHSfFLkefRonWH/VTNL877Rs6Cq81GX8dejD4x7zsQMIBDpLn99L11UtjCeAsQZ
 VVudNx4lFhBGyR9ZooyeGWqfgZEPdJPKUgMs2tSoSAdj578WTBp+dRcLc
X-Gm-Gg: AYBFou0IIwNt4C5O3lyyty80z81RwzVZnmKznkgySmY1DAiki6XrxkwmMAaLgz9kxVa
 y26JPaydMGkduXqw2GZrN0IUeMrZ0YuUcgtiYyDWa7v0Q+hZB60bbUdE32xbOLPgTUbLDO5cjUK
 yLbp0A6H/OYIVCja4jmOzuwy5PvO9eY8E8cNOFWhPAag1nfXQ1TSX4+sLfMth90VBAyXzi3Pb4C
 16YBApsxIo76YR375Moj3IEjuqzLXanlAZrBtzPPXeBGZM/UUVl0JuA6yLJR/wFKS48p9QC5N/V
 WjG7Syc2dhsCqkWcMpVFOEzwqkAyyndea6UsZXDrJJFJe+Iju3v0XwuqpwLeYcU/IIws23I=
X-Received: by 2002:a05:622a:8ce:b0:533:39eb:8d42 with SMTP id
 d75a77b69052e-5358a8dbdbcmr732581cf.21.1791399199409; 
 Wed, 07 Oct 2026 11:53:19 -0700 (PDT)
X-Received: by 2002:a05:622a:8ce:b0:533:39eb:8d42 with SMTP id
 d75a77b69052e-5358a8dbdbcmr732241cf.21.1791399198852; 
 Wed, 07 Oct 2026 11:53:18 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53571f162e7sm26789321cf.1.2026.10.07.11.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:53:18 -0700 (PDT)
Date: Wed, 7 Oct 2026 14:53:17 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 1/4] migration/postcopy: report COMPLETED only after the
 run BH has run
Message-ID: <asaVHeTm2MljE2z0@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261002110258.1835979-1-den@openvz.org>
 <20261002110258.1835979-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002110258.1835979-2-den@openvz.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 02, 2026 at 01:02:55PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> The postcopy listen thread waits for main_thread_load_event before it
> reports COMPLETED. That event is set as soon as qemu_loadvm_state_main()
> returns in the main thread, while the run state is changed later, in
> loadvm_postcopy_handle_run_bh(). The listen thread can therefore report
> COMPLETED while the VM is still in RUN_STATE_INMIGRATE, easily so in a
> bitmap-only postcopy where it has little to load.
> 
> Management reacting to COMPLETED then finds the VM still incoming: a
> blockdev-add creates an inactive node, since bds_tree_init() forces
> BDRV_O_INACTIVE in RUN_STATE_INMIGRATE, and attaching a device to it
> fails with "Block node is read-only". Precopy gets this right:
> process_incoming_migration_bh() changes the run state before it reports
> COMPLETED.
> 
> Set an event at the end of the run BH and wait for it in the listen
> thread, unless loading failed before CMD_POSTCOPY_RUN and the BH was
> never scheduled.

This in general looks reasonable, only some question to impl details,

> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c    | 2 ++
>  migration/migration.h    | 2 ++
>  migration/postcopy-ram.c | 4 ++++
>  migration/savevm.c       | 1 +
>  4 files changed, 9 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index fab7949fe1..8944acf3cd 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -324,6 +324,7 @@ void migration_object_init(void)
>      qemu_mutex_init(&current_incoming->rp_mutex);
>      qemu_mutex_init(&current_incoming->postcopy_prio_thread_mutex);
>      qemu_event_init(&current_incoming->main_thread_load_event, false);
> +    qemu_event_init(&current_incoming->postcopy_run_event, false);
>      qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
>      qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
>      qemu_sem_init(&current_incoming->postcopy_pause_sem_fast_load, 0);
> @@ -493,6 +494,7 @@ void migration_incoming_state_destroy(void)
>  
>      migration_incoming_transport_cleanup(mis);
>      qemu_event_reset(&mis->main_thread_load_event);
> +    qemu_event_reset(&mis->postcopy_run_event);
>  
>      if (mis->page_requested) {
>          g_tree_destroy(mis->page_requested);
> diff --git a/migration/migration.h b/migration/migration.h
> index 683bc7bdd5..c65212ff63 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -108,6 +108,8 @@ struct MigrationIncomingState {
>       * loading state.
>       */
>      QemuEvent main_thread_load_event;
> +    /* Set once the postcopy run BH has changed the run state */
> +    QemuEvent postcopy_run_event;

Can we just move main_thread_load_event post to be run_bh?  AFAIU that's
the last thing postcopy does anyway, then the bh does whatever offloaded
later.

IOW, my read is the new run event should always be posted after the
main_thread_load, then we don't need two.

>  
>      /* For network announces */
>      AnnounceTimer  announce_timer;
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 5509cbdcb8..fd2c139cfe 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -2443,6 +2443,10 @@ static void *postcopy_listen_thread(void *opaque)
>       * state yet; wait for the end of the main thread.
>       */
>      qemu_event_wait(&mis->main_thread_load_event);
> +    /* The VM run state is changed later, in loadvm_postcopy_handle_run_bh() */
> +    if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING) {

Why the condition, rather than always waiting for it?  If it happened
already, the wait() will consume the posted.

Thanks,

> +        qemu_event_wait(&mis->postcopy_run_event);
> +    }
>  
>      /*
>       * Device load in the main thread has finished, we should be in
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4b590ea672..5ec09d4889 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2263,6 +2263,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
>      }
>  
>      trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
> +    qemu_event_set(&mis->postcopy_run_event);
>  }
>  
>  /* After all discards we can start running and asking for pages */
> 
> base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
> -- 
> 2.53.0
> 

-- 
Peter Xu


