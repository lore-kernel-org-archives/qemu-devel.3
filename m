Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97548CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 19:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPQa3-0007Hz-2N; Tue, 19 May 2026 15:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPQZz-0007Hk-9l
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPQZw-0005eo-J8
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779220690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TC1AxjtIHRMe78qik8GYEk9gRcR7ZcDxsu+tc5L5ve8=;
 b=S4UMv0Sw4GJ9tN1yow3Rs1/MOkm9CcYktG8DBLHMz0qcaoDTiZYD4bLA09PUJcE1ETH0wN
 DziUk+a9P6qfNttcfD2IQm8mRo3YGJ4WT6Dax+OsYjXCOetl0DarE4f+43Zch90ecGXdYd
 APmEaTPO8FkDgFRj2Hoe/b9CSxL/xU4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-34fjqwzJM3-qz_2UEUVw4Q-1; Tue, 19 May 2026 15:58:09 -0400
X-MC-Unique: 34fjqwzJM3-qz_2UEUVw4Q-1
X-Mimecast-MFC-AGG-ID: 34fjqwzJM3-qz_2UEUVw4Q_1779220688
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514551d5f2aso166744991cf.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779220688; x=1779825488; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TC1AxjtIHRMe78qik8GYEk9gRcR7ZcDxsu+tc5L5ve8=;
 b=sazpQ27zQ/OZbNVjD8m4LdPzsCfOs1E4Cc61jRI9ioboZQjWA0XyrmBMO7ZVFpw7Jz
 vNzRbdhbQVYrdSZOyGwthhobvHp0aP9Pxu7ygtnTq/J6T9fu4BhOHIp+VXQTi1rkSHN1
 E07hD5detRGStEUeaJucQzbYvJXXZMmGfL/SMyioL90SslkRd0hcqbu9mIP5wjKJAOjc
 HC+kULeQKeMKyQuD651tqQbWfMIrQCYzaeyX0xyg9/i1auNND44bUSUX24dwH+3+Hn4t
 wewEVyfBeR3EMaEUQQip+DKwMmRVdsk7fG5cUa/KptJMqK11NaZ5gd0YdJlHUcGu7OUH
 sP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779220688; x=1779825488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TC1AxjtIHRMe78qik8GYEk9gRcR7ZcDxsu+tc5L5ve8=;
 b=U3p34dXEenkd45p1ynb+gh2enjW7SXqg+foWI0xLKJeTLiYnd67gjT57NvrPdrh5ls
 Z+Pr39TDZ+NqiUxH2+x2ZisCjE0MEWyU3BpZTqZJKUpKiV9jnCXZbazkT98w01ckoEVz
 Uo/peIGkktuQhKbdiOgMCKgPUm+nev1r308lr+QBY+gB/L8ZR64Gf/vZjoWIh6QbuUOE
 23TF0GFJ+9lglkUuLDyOxNHhKPR6EIieNP6ll/KACFRbBt02USdiFEt6yL9MMJ/4QJbg
 aFSbIZEQ7uB3Ayo+cTXKJcQ7RvadmeO42YG35O1Wge65bMmsARCJ40tED9pn3MLVLC+3
 upHA==
X-Gm-Message-State: AOJu0YxdqkwNdHjwYeQCP0eNO/W9uUzie5RTESUBZc7RbYDmpD7a5/8E
 Yr2/SeLnA4faE1oj1fYkF/uSN1uzrNFEtEmBwFZ0MA8hNBaYNYzGGlWoFTTuxuRyRMSIqyfRSmY
 jL6o3OxHKKjvf8RLeFwAwAJG5PCZ/vh5aDrixfWJC678OW9tJrfVAxOBa
X-Gm-Gg: Acq92OGTa+N1165mlHrWpWelU0AZgs6SDgf9BrSWY9Q0z5re5dGclgq7txx5aiWiNok
 +DuJgNb3u2K11WDGFInjvTWkgMLE5T8MIRaMv4qQ+staeTk/I78IkV6pYhPb4k0CbCywSYNKXib
 kTZrGbQEHKFMa3Ncp/iuQ/F+yH55dCmrHEP503bfBLlF4kPfVv71olncM3imueMc66OMfdY9tuM
 SREWrlpJXeIs11Vg5veWk/MTVAa28xwc9zyqweX2/bvVVZ8xSOSyHKHl6GLhF5FyrJxMDqk80va
 tdVxAdqfGZYVPo3itxq2g1gDyi6cNvTu7n8dJPAzY7EqWF7m7kK93vFduvEvkwKRGZAegDouBYR
 6A+qCLlxNf8pGWtAMVuGaJ8VGx2D1jc5Bfgd/nGHQV+FY3QS2dtRyTJz1Iw==
X-Received: by 2002:a05:622a:30f:b0:50d:9f33:9a5 with SMTP id
 d75a77b69052e-5165a02c2b1mr310275291cf.23.1779220687899; 
 Tue, 19 May 2026 12:58:07 -0700 (PDT)
X-Received: by 2002:a05:622a:30f:b0:50d:9f33:9a5 with SMTP id
 d75a77b69052e-5165a02c2b1mr310274541cf.23.1779220687200; 
 Tue, 19 May 2026 12:58:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51645801211sm173051741cf.20.2026.05.19.12.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 12:58:06 -0700 (PDT)
Date: Tue, 19 May 2026 15:58:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 09/14] vfio/migration: Re-query precopy size before
 sending VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
Message-ID: <agzAzawATnGGMIGO@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-10-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505081423.28326-10-avihaih@nvidia.com>
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

On Tue, May 05, 2026 at 11:14:18AM +0300, Avihai Horon wrote:
> When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> flag is sent to the destination to indicate that initial data has been
> sent, so destination can indicate back to source when it finished
> loading it.
> 
> To get a more accurate estimation of initial_bytes, re-query precopy
> size before sending the flag. Extract the flag sending logic from
> vfio_save_iterate() to a new helper for clarity.
> 
> This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> flag if, for example, the previously queried initial_bytes was lower
> than actually is. Additionally, it prevents sending the flag if
> vfio_query_precopy_size() failed.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
>  hw/vfio/trace-events |  1 +
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2911583ee1..243624b5fe 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
>                                           data_size);
>  }
>  
> +/* Returns true if the init data flag was sent, false otherwise */
> +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
> +{
> +    VFIODevice *vbasedev = migration->vbasedev;
> +    int ret;
> +
> +    if (!migrate_switchover_ack()) {
> +        return false;
> +    }
> +
> +    if (migration->precopy_init_size || migration->initial_data_sent) {
> +        return false;
> +    }
> +
> +    /*
> +     * precopy_init_size holds an estimation of the initial data size, re-query
> +     * precopy size to ensure it's really zero before sending init data flag.
> +     * Don't send the flag if query fails.
> +     */
> +    ret = vfio_query_precopy_size(migration);
> +    if (ret || migration->precopy_init_size) {
> +        return false;
> +    }

IIUC this chunk isn't necessary?  If we don't expect REINIT to happen that
much (when NIC reconfigures?), then we can still rely on the window where
the "new switchover ack" will be requested later on during the exact sync.

Relying on that seems slightly cleaner.

> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
> +    migration->initial_data_sent = true;
> +    trace_vfio_send_init_data_flag(vbasedev->name);
> +
> +    return true;
> +}
> +
>  static bool vfio_precopy_supported(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;
> @@ -664,11 +695,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>  
>      vfio_update_estimated_pending_data(migration, data_size);
>  
> -    if (migrate_switchover_ack() && !migration->precopy_init_size &&
> -        !migration->initial_data_sent) {
> -        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
> -        migration->initial_data_sent = true;
> -    } else {
> +    if (!vfio_send_init_data_flag(f, migration)) {
>          qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>      }
>  
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ab27ff5ea2..e91858354c 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -176,6 +176,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
>  vfio_save_iterate_start(const char *name) " (%s)"
>  vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
>  vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
> +vfio_send_init_data_flag(const char *name) " (%s)"
>  vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>  vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>  
> -- 
> 2.40.1
> 

-- 
Peter Xu


