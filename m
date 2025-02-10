Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BDFC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXK8-0008VF-Uj; Mon, 10 Feb 2025 12:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thXK7-0008Uj-2y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thXK4-000552-Ou
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739207512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjeeiTKnOYXCR+wso53W613ZoQx2mUlrU8wAdC5O38U=;
 b=iIZ3f4kKl4p/c/rnKh2gjXkCMyB6ZBtwZ/OXEcPZwFlN3JTxZ3T5BuplVaPso9/3aojUSz
 xH8Rzur3NFHLWI+WtQhk2/0qvczR55WUDkvdaYz3R4Rb2w0448iGiX96kVO1IOXtimubCZ
 foC6LnR6jrW2E/ABufnh102khUs4OG8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-TupSHofKMCKwNwdN0VdMkg-1; Mon, 10 Feb 2025 12:11:50 -0500
X-MC-Unique: TupSHofKMCKwNwdN0VdMkg-1
X-Mimecast-MFC-AGG-ID: TupSHofKMCKwNwdN0VdMkg
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7268475e62cso4028800a34.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739207509; x=1739812309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjeeiTKnOYXCR+wso53W613ZoQx2mUlrU8wAdC5O38U=;
 b=XpIMwFyjpyla2fMwZJG8kfqmRFCogtg+U4ium81dF5RENCov8cs/ldXy4qZJ2WrQlw
 hl9+YV3mLjFCi+4Fe6gFM0zP9R3PvGwTmhw+JbtI4Z3JWro5kk1TLtbcCdf3xYNwKjs8
 WRzAliJjGWqzByhYxgMIrLdkf0KXvaV6o7QG1RwNTNlGSigaeZ2crKXzv79X+k9F80Bc
 z+Qg02s5PKgpnvY37IYiIak65viBtVzFdgE4fpE9ZYT6KWXBh6wBhQOgZdSU0VvbJOx+
 jTd2Amrj9czMn64qlplI3xUeYb/5M7oz2jfrNHyQSVCsgeIi2e3WkxsYJxohvgDJJYjb
 +iLw==
X-Gm-Message-State: AOJu0YzoaNSsQ3zeS4W0pdH1sGeORxVeH5jdgPBvvFVH5AE2yETILqr5
 QQzaI4GP2KPTjG+F2s4XDGp+wSn1/rGEW+2Gx3vlSud2vSj+UTE9FdHzpU7r1uoOBnn1KQlTiXL
 x3yeGIRwmTReUqNX6dcTEPPtQGcoorXxiKFBwj1bUwTJiltp6O00H
X-Gm-Gg: ASbGncvb0UPBoHlS1YkhWhfVMdrPaI/53r1RpYGOfDSaBJ12YzKN6neh0dnEI3fac38
 mEv0+C7b8po9HYCQ5y+rXndNRrc7qPYaTFlcp/zAJMnfgg9u22bMS5hwy8Q4RCdPfhLzUnnJ3OY
 PSYEG7qWkxhqoxum2JYuSu4koAWBkLU899rytZXBMtcqGW0MM9gukO9C7rkUcSUBbiMsaCGgCBs
 SGFM7Q5c17KQSJksxFeuhfGyyDEWiYmyp4uSRsvzaNms7kME7TEI6tcCx8=
X-Received: by 2002:a05:6830:4990:b0:71d:eaa8:9971 with SMTP id
 46e09a7af769-726e79e21a3mr270561a34.8.1739207509616; 
 Mon, 10 Feb 2025 09:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+gsuh+O/tg4Q3yH23jw3CA6Q+TvqOLpAIwG++heSYT73uzWa5aVZL56M5+2zG6H0T+B7Dlw==
X-Received: by 2002:a05:6830:4990:b0:71d:eaa8:9971 with SMTP id
 46e09a7af769-726e79e21a3mr270437a34.8.1739207507808; 
 Mon, 10 Feb 2025 09:11:47 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726af9356e7sm2469381a34.19.2025.02.10.09.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 09:11:46 -0800 (PST)
Date: Mon, 10 Feb 2025 12:11:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC PATCH v3 7/8] migration/multifd: Add a compat property for
 TLS termination
Message-ID: <Z6ozTtvsIU66tzQ7@x1.local>
References: <20250207195359.17443-1-farosas@suse.de>
 <20250207195359.17443-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207195359.17443-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 07, 2025 at 04:53:58PM -0300, Fabiano Rosas wrote:
> We're currently changing the way the source multifd migration handles
> the shutdown of the multifd channels when TLS is in use to perform a
> clean termination by calling gnutls_bye().
> 
> Older src QEMUs will always close the channel without terminating the
> TLS session. New dst QEMUs treat an unclean termination as an error.
> 
> Add multifd_clean_tls_termination (default true) that can be switched
> on the destination whenever a src QEMU <= 9.2 is in use.
> 
> (Note that the compat property is only strictly necessary for src
> QEMUs older than 9.1. Due to synchronization coincidences, src QEMUs
> 9.1 and 9.2 can put the destination in a condition where it doesn't
> see the unclean termination. Still, make the property more inclusive
> to facilitate potential backports.)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick..

> ---
>  hw/core/machine.c     |  1 +
>  migration/migration.h | 33 +++++++++++++++++++++++++++++++++
>  migration/multifd.c   | 15 +++++++++++++--
>  migration/multifd.h   |  2 ++
>  migration/options.c   |  2 ++
>  5 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 254cc20c4c..02cff735b3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -42,6 +42,7 @@ GlobalProperty hw_compat_9_2[] = {
>      { "virtio-balloon-pci-transitional", "vectors", "0" },
>      { "virtio-balloon-pci-non-transitional", "vectors", "0" },
>      { "virtio-mem-pci", "vectors", "0" },
> +    { "migration", "multifd-clean-tls-termination", "false" },
>  };
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index 4c1fafc2b5..77def0b437 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -443,6 +443,39 @@ struct MigrationState {
>       * Default value is false. (since 8.1)
>       */
>      bool multifd_flush_after_each_section;
> +
> +    /*
> +     * This variable only makes sense when set on the machine that is
> +     * the destination of a multifd migration with TLS enabled. It
> +     * affects the behavior of the last send->recv iteration with
> +     * regards to termination of the TLS session.
> +     *
> +     * When set:
> +     *
> +     * - the destination QEMU instance can expect to never get a
> +     *   GNUTLS_E_PREMATURE_TERMINATION error. Manifested as the error
> +     *   message: "The TLS connection was non-properly terminated".
> +     *
> +     * When clear:
> +     *
> +     * - the destination QEMU instance can expect to see a
> +     *   GNUTLS_E_PREMATURE_TERMINATION error in any multifd channel
> +     *   whenever the last recv() call of that channel happens after
> +     *   the source QEMU instance has already issued shutdown() on the
> +     *   channel.
> +     *
> +     *   Commit 637280aeb2 (since 9.1) introduced a side effect that
> +     *   causes the destination instance to not be affected by the
> +     *   premature termination, while commit 1d457daf86 (since 10.0)
> +     *   causes the premature termination condition to be once again
> +     *   reachable.
> +     *
> +     * NOTE: Regardless of the state of this option, a premature
> +     * termination of the TLS connection might happen due to error at
> +     * any moment prior to the last send->recv iteration.
> +     */
> +    bool multifd_clean_tls_termination;
> +
>      /*
>       * This decides the size of guest memory chunk that will be used
>       * to track dirty bitmap clearing.  The size of memory chunk will
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0296758c08..8045197be8 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1151,6 +1151,7 @@ void multifd_recv_sync_main(void)
>  
>  static void *multifd_recv_thread(void *opaque)
>  {
> +    MigrationState *s = migrate_get_current();
>      MultiFDRecvParams *p = opaque;
>      Error *local_err = NULL;
>      bool use_packets = multifd_use_packets();
> @@ -1159,18 +1160,28 @@ static void *multifd_recv_thread(void *opaque)
>      trace_multifd_recv_thread_start(p->id);
>      rcu_register_thread();
>  
> +    if (!s->multifd_clean_tls_termination) {
> +        p->read_flags = QIO_CHANNEL_READ_FLAG_RELAXED_EOF;
> +    }
> +
>      while (true) {
>          uint32_t flags = 0;
>          bool has_data = false;
>          p->normal_num = 0;
>  
> +

Extra newline (can be fixed when merge)

>          if (use_packets) {
> +            struct iovec iov = {
> +                .iov_base = (void *)p->packet,
> +                .iov_len = p->packet_len
> +            };
> +
>              if (multifd_recv_should_exit()) {
>                  break;
>              }
>  
> -            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> -                                           p->packet_len, &local_err);
> +            ret = qio_channel_readv_full_all_eof(p->c, &iov, 1, NULL, NULL,
> +                                                 p->read_flags, &local_err);
>              if (!ret) {
>                  /* EOF */
>                  assert(!local_err);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index bd785b9873..cf408ff721 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -244,6 +244,8 @@ typedef struct {
>      uint32_t zero_num;
>      /* used for de-compression methods */
>      void *compress_data;
> +    /* Flags for the QIOChannel */
> +    int read_flags;
>  } MultiFDRecvParams;
>  
>  typedef struct {
> diff --git a/migration/options.c b/migration/options.c
> index 1ad950e397..feda354935 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -99,6 +99,8 @@ const Property migration_properties[] = {
>                        clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
>      DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
>                       preempt_pre_7_2, false),
> +    DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
> +                     multifd_clean_tls_termination, true),
>  
>      /* Migration parameters */
>      DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
> -- 
> 2.35.3
> 

-- 
Peter Xu


