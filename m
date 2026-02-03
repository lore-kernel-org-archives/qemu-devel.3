Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE80E87845
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJFx-0001MO-FK; Tue, 03 Feb 2026 11:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnJFv-0001LX-UL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:28:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnJFt-0003Fy-Ur
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770136077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U2bOva1H3SkdmmRfsXLDoXqAJuO+xOxjm1PpnHaChhU=;
 b=d1yaLyxZefnjGpLhul+Mm7+k7BmBpQU900nphsChfI8fy9PJ0dNP4x8L3t+LCFsAD1iiyZ
 GUuehr/05I2/KKkiIK9rqVNLM06zmR5+RBXtxCUmtw+a8hqP5Z0wuNnDljLjdJy7M54ZfQ
 618Ers90PPzJnwxNIOoIk4o1UnJx+cU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-wqYjc3cgPNK7GWELSUZnoA-1; Tue, 03 Feb 2026 11:27:55 -0500
X-MC-Unique: wqYjc3cgPNK7GWELSUZnoA-1
X-Mimecast-MFC-AGG-ID: wqYjc3cgPNK7GWELSUZnoA_1770136074
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-431026b6252so5839646f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770136074; x=1770740874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=U2bOva1H3SkdmmRfsXLDoXqAJuO+xOxjm1PpnHaChhU=;
 b=FYMqhGGKWcXmkV9hsOuCec/8ACtbXH5sTF2du4ylmq2Z6IRMMkAVdbxxSMXcB8JDhM
 zZnEp16qcMClC6xv5fb2IiReU/vWKQpRmC0smWEFbqRtRr2xxQ2x0BRMiQ4vS4pLBL/t
 HnDe8qeD2hC61fJltMoDfn4DnO59AuqnYdGSqQYVe66XQz8hZwpiIbB8oHsJ1acTPU6o
 O4ZrUDh4UfNgZsvUGjGGnYX/V3HzmsH1Nes+JgtBy87Tu8cRR/ks954yxkYGHT23NtSH
 2A90+i0I1BPjQiMR6CQUKnkuNUl380IVnbEPzO5ogDSIqxdVKZEy7johieHysXMPsaiO
 UUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770136074; x=1770740874;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2bOva1H3SkdmmRfsXLDoXqAJuO+xOxjm1PpnHaChhU=;
 b=KpDeqOE17qcYX1EzuKDLmAshOSEgyWt3HnuKaYqeBrZpleus5dXE4I23bjchI457y3
 XkGK0yeXZbF8XVSPqrFGkpJuGhsW0/VOxlCQqCvtjPTTaxKon2DxrZSf9zdzrg2Hbmha
 KmJkEYDV/gTyyv/Hc4ZAh5EWlP/B7PnLACZscr0cVpB3m9ptfUMsGrWQHSU6E7KAQ0//
 jkvURUqKK3jBKz0uMhLAPJnDrztYTp/c6G4cinAnEqAf+bqDxQff+gTjO0hwXxmclay2
 0DQNN6GETS7J+WDKNwgzOK5+sOXdu+W12qfLF9Uj86dswe4teIpnGcu97R36qlCL42CJ
 d+7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU9rxSiUHi6ydS1qvOXHwYFbPiXol8uk5g8DglXqWsVN8iqBBKh8sEt+yHNJc0U0w4IT1bthal/782@nongnu.org
X-Gm-Message-State: AOJu0YzxSxPZwh9+9un3vJcjaXqyZWk6VJrLesDom8u1Rw3+osenpcmq
 87QzLhXGtU83NcH7aksR3nCd9ulIziapYKcO3a42eFYb2XsqBYsoacNF2PlIJGdtIlyhlA+EZI5
 EHWY0m8R5iPIVJrKWuVvUsYjca4Qrb8HhIuB5va6feFmIfEVFtXIEB/yK
X-Gm-Gg: AZuq6aKgxqcI+cv8B1z7fGhCktrUUMXzwtZCzEbFJeHnmkb6VXV2SchiK0Tl6bysl05
 s40OXgnRpoPtxoAHnLZZ7HwaYjYBrLwKVzuxovWbG5zjhrBmlBq9MnxEpFrppLnATDlFjbkXw0/
 OB9yEW+a9Ro6am8FUNrWmzEShZcNd1R3/YygZJ8WE7vCzTsf7e38Z0gy5nV9QisrP6h0qc0ACde
 ks4EAwbUCNVRoyUjW4J7xca/5YZJEfBii+Iv6T83kJUYcbQf6PoJh9asRZmeyHT0JYTwrY8oHGN
 4TjsKb9d2VIGVgvtYur0NLBVw2VMp62+1i9WRDnYjdvHh2lUFiV63SvrcgAQOk538pi5Icg2lK4
 XmaGzI9U3GIOxj4zUkgaEUUPkDqhBKN6LJGbxVxspOHCU3ATM
X-Received: by 2002:adf:ffce:0:b0:435:e440:f518 with SMTP id
 ffacd0b85a97d-435f3abb472mr20197964f8f.54.1770136074074; 
 Tue, 03 Feb 2026 08:27:54 -0800 (PST)
X-Received: by 2002:adf:ffce:0:b0:435:e440:f518 with SMTP id
 ffacd0b85a97d-435f3abb472mr20197927f8f.54.1770136073524; 
 Tue, 03 Feb 2026 08:27:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfd4sm50663463f8f.25.2026.02.03.08.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 08:27:52 -0800 (PST)
Message-ID: <baab949a-b413-4197-9659-d1e6b8232966@redhat.com>
Date: Tue, 3 Feb 2026 17:27:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260202173406.13979-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 2/2/26 18:34, Avihai Horon wrote:
> The VFIO_MIGRATION event notifies users when a VFIO device transitions
> to a new state.
> 
> One use case for this event is to prevent timeouts for RDMA connections
> to the migrated device. In this case, an external management application
> (not libvirt) consumes the events and disables the RDMA timeout
> mechanism when receiving the event for PRE_COPY_P2P state, which
> indicates that the device is non-responsive.
> 
> This is essential because RDMA connections typically have very low
> timeouts (tens of milliseconds), which can be far below migration
> downtime.
> 
> However, under heavy resource utilization, the device transition to
> PRE_COPY_P2P can take hundreds of milliseconds to complete. Since the
> VFIO_MIGRATION event is currently sent only after the transition
> completes, it arrives too late, after RDMA connections have already
> timed out.
> 
> To address this, send an additional "prepare" event immediately before
> initiating the PRE_COPY_P2P transition. This guarantees timely event
> delivery regardless of how long the actual state transition takes.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
> Changes from v2 (https://lore.kernel.org/qemu-devel/20260201122348.28478-1-avihaih@nvidia.com/):
> * Renamed prepare-pre-copy-p2p to pre-copy-p2p-prepare
> * Renamed prep parameter to prepare in mig_state_to_qapi_state() and
>    vfio_migration_send_event()
> * Added short explanatory comment before sending the prepare event in
>    vfio_migration_set_state()
> * Explicitly used VFIO_DEVICE_STATE_PRE_COPY_P2P as parameter for
>    vfio_migration_send_event()
> 
> Changes from v1 (https://lore.kernel.org/qemu-devel/20260128105159.10282-1-avihaih@nvidia.com/):
> * Removed VFIO_MIGRATION_PREPARE event and instead added a new
>    PREPARE_PRE_COPY_P2P state which is sent before PRE_COPY_P2P
>    transition
> * Added details to commit message
> ---
>   qapi/vfio.json      | 13 +++++++++++--
>   hw/vfio/migration.c | 26 +++++++++++++++++++-------
>   2 files changed, 30 insertions(+), 9 deletions(-)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index a1a9c5b673..17b6046871 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -11,7 +11,13 @@
>   ##
>   # @QapiVfioMigrationState:
>   #
> -# An enumeration of the VFIO device migration states.
> +# An enumeration of the VFIO device migration states.  In addition to
> +# the regular states, there are prepare states (with 'prepare' suffix)
> +# which indicate that the device is just about to transition to the
> +# corresponding state.  Note that seeing a prepare state for state X
> +# doesn't guarantee that the next state will be X, as the state
> +# transition can fail and the device may transition to a different
> +# state instead.
>   #
>   # @stop: The device is stopped.
>   #
> @@ -32,11 +38,14 @@
>   #     tracking its internal state and its internal state is available
>   #     for reading.
>   #
> +# @pre-copy-p2p-prepare: The device is just about to move to
> +#     pre-copy-p2p state.  (since 11.0)
> +#
>   # Since: 9.1
>   ##
>   { 'enum': 'QapiVfioMigrationState',
>     'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
> -            'pre-copy', 'pre-copy-p2p' ] }
> +            'pre-copy', 'pre-copy-p2p', 'pre-copy-p2p-prepare' ] }
>   
>   ##
>   # @VFIO_MIGRATION:
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b4695030c7..4bd8e24699 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -68,7 +68,7 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>   }
>   
>   static QapiVfioMigrationState
> -mig_state_to_qapi_state(enum vfio_device_mig_state state)
> +mig_state_to_qapi_state(enum vfio_device_mig_state state, bool prepare)
>   {
>       switch (state) {
>       case VFIO_DEVICE_STATE_STOP:
> @@ -84,15 +84,17 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
>       case VFIO_DEVICE_STATE_PRE_COPY:
>           return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
>       case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> -        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
> +        return prepare ? QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P_PREPARE :
> +                         QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
>       default:
>           g_assert_not_reached();
>       }
>   }
>   
> -static void vfio_migration_send_event(VFIODevice *vbasedev)
> +static void vfio_migration_send_event(VFIODevice *vbasedev,
> +                                      enum vfio_device_mig_state state,
> +                                      bool prepare)
>   {
> -    VFIOMigration *migration = vbasedev->migration;
>       DeviceState *dev = vbasedev->dev;
>       g_autofree char *qom_path = NULL;
>       Object *obj;
> @@ -106,8 +108,8 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
>       g_assert(obj);
>       qom_path = object_get_canonical_path(obj);
>   
> -    qapi_event_send_vfio_migration(
> -        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
> +    qapi_event_send_vfio_migration(dev->id, qom_path,
> +                                   mig_state_to_qapi_state(state, prepare));
>   }
>   
>   static void vfio_migration_set_device_state(VFIODevice *vbasedev,
> @@ -119,7 +121,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>                                             mig_state_to_str(state));
>   
>       migration->device_state = state;
> -    vfio_migration_send_event(vbasedev);
> +    vfio_migration_send_event(vbasedev, state, false);
>   }
>   
>   int vfio_migration_set_state(VFIODevice *vbasedev,
> @@ -146,6 +148,16 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>           return 0;
>       }
>   
> +    /*
> +     * Send a prepare event before initiating the PRE_COPY_P2P transition to
> +     * ensure timely event delivery regardless of how long the state transition
> +     * takes.
> +     */
> +    if (new_state == VFIO_DEVICE_STATE_PRE_COPY_P2P) {
> +        vfio_migration_send_event(vbasedev, VFIO_DEVICE_STATE_PRE_COPY_P2P,
> +                                  true);
> +    }
> +
>       feature->argsz = sizeof(buf);
>       feature->flags =
>           VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;


