Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65A8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HNL-0002vP-3V; Wed, 15 May 2024 12:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7HNG-0002tC-Oy
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7HN7-0007VN-JR
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715790052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utEvZD8gjs+RSQCypVFDaq914F4vrRPtst+HSMepIh8=;
 b=BjdYk4CtuCMDyWetxsfzRZXXd82oeoyDDfg9mowSc4grycTNVuVAk9Yr5xGUDcIqXRk3JB
 Sr/E6/h3rOEg51SBFeLsyVTtcIsqtjtRBDgq+ozuaUUdP6k657HgxOpLrN44+XTS6j9JMk
 itYkAhiIMb1gixc8yPDPtEAQP2a5txM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-77d_R9G_N2msOR-RHJWrUg-1; Wed, 15 May 2024 12:20:51 -0400
X-MC-Unique: 77d_R9G_N2msOR-RHJWrUg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-792c10a363bso968889885a.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715790051; x=1716394851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=utEvZD8gjs+RSQCypVFDaq914F4vrRPtst+HSMepIh8=;
 b=Ch/gKWrnO2Wo1L2qSODBVa5SJDFiMGuuTENo404RiayMHWwQIqwvA3Jo3jHg1GmTW+
 1ElslHqwXDMLv11RKjMqgHP9rAC0qlzpVZXV2UY6VlqL/3bn6CZrD4RBhWE8XSNujp2t
 IWzZebkkeNmudzR2OdFVDWM2QGaQD02+rDPb/kVGUOpIc+byUHvVY0P1Q+x0qRrwmOhF
 MXgih5q3surM9PIEXYvOl/1Rtoqjf7Tzd7WwuTBC+GyX2UFUe/dupgK4ha3eImtAgebv
 1k/Eao0rh7aPigxrI+i0WEyLkaJFhb1fsRed8BBV0aSgayp8YOWGLQN0p/6/OEQ8o7mc
 SWGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUURujNgK2kKEtNi15fc2a2uIOaigkQNrlK0B0Ze6obk8h4DvOhWg3TMA/xGt/1tRD9f3S9ji99buS+AcuD9KRJez4W+cE=
X-Gm-Message-State: AOJu0YwlgrgNWFysTiUJS0jlisj6YKBx7WdE3FVHLqj6gT/f0X1uBMSB
 H9l5zwolIaeKQxUreksYzC9xoJOWz7pSpzHVqcdpRxtE4i1mrXl4WeyQJVDzz86lJhi53svXF+S
 z5oDqo1wekLBCtU82IXwN2YtLZ2OJ5XVBLglBchGUdIif9PaE49jt
X-Received: by 2002:ae9:ea07:0:b0:792:8a3f:1fd with SMTP id
 af79cd13be357-792c75ac0e3mr1656070485a.43.1715790050724; 
 Wed, 15 May 2024 09:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwqQxk5/c+3shJYd45S9q2y3sYEobA3eoSipjuwoNqCYGDAOkNXrjAYlJ0h5g4I0S3lPIr4A==
X-Received: by 2002:ae9:ea07:0:b0:792:8a3f:1fd with SMTP id
 af79cd13be357-792c75ac0e3mr1656067985a.43.1715790050402; 
 Wed, 15 May 2024 09:20:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43dfd760ca8sm74394631cf.14.2024.05.15.09.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 09:20:49 -0700 (PDT)
Message-ID: <f8b5017b-a2fa-470a-b97c-41612b737a5d@redhat.com>
Date: Wed, 15 May 2024 18:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] vfio/migration: Emit VFIO migration QAPI event
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240515132138.4560-1-avihaih@nvidia.com>
 <20240515132138.4560-3-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515132138.4560-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/15/24 15:21, Avihai Horon wrote:
> Emit VFIO migration QAPI event when a VFIO device changes its migration
> state. This can be used by management applications to get updates on the
> current state of the VFIO device for their own purposes.
> 
> A new per VFIO device capability, "migration-events", is added so events
> can be enabled only for the required devices. It is disabled by default.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/migration.c           | 59 +++++++++++++++++++++++++++++++++--
>   hw/vfio/pci.c                 |  2 ++
>   3 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..3ec5f2425e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>       bool no_mmap;
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
> +    bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 06ae40969b..2e1a8f6031 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -24,6 +24,7 @@
>   #include "migration/register.h"
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
> +#include "qapi/qapi-events-vfio.h"
>   #include "exec/ramlist.h"
>   #include "exec/ram_addr.h"
>   #include "pci.h"
> @@ -80,6 +81,58 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>       }
>   }
>   
> +static VfioMigrationState
> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
> +{
> +    switch (state) {
> +    case VFIO_DEVICE_STATE_STOP:
> +        return QAPI_VFIO_MIGRATION_STATE_STOP;
> +    case VFIO_DEVICE_STATE_RUNNING:
> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING;
> +    case VFIO_DEVICE_STATE_STOP_COPY:
> +        return QAPI_VFIO_MIGRATION_STATE_STOP_COPY;
> +    case VFIO_DEVICE_STATE_RESUMING:
> +        return QAPI_VFIO_MIGRATION_STATE_RESUMING;
> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING_P2P;
> +    case VFIO_DEVICE_STATE_PRE_COPY:
> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void vfio_migration_send_event(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    DeviceState *dev = vbasedev->dev;
> +    g_autofree char *qom_path = NULL;
> +    Object *obj;
> +
> +    if (!vbasedev->migration_events) {
> +        return;
> +    }
> +
> +    g_assert(vbasedev->ops->vfio_get_object);
> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
> +    g_assert(obj);
> +    qom_path = object_get_canonical_path(obj);
> +
> +    qapi_event_send_vfio_migration(
> +        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
> +}
> +
> +static void vfio_migration_set_device_state(VFIODevice *vbasedev,
> +                                            enum vfio_device_mig_state state)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    migration->device_state = state;
> +    vfio_migration_send_event(vbasedev);
> +}
> +
>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>                                       enum vfio_device_mig_state new_state,
>                                       enum vfio_device_mig_state recover_state)
> @@ -125,12 +178,12 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>               goto reset_device;
>           }
>   
> -        migration->device_state = recover_state;
> +        vfio_migration_set_device_state(vbasedev, recover_state);
>   
>           return ret;
>       }
>   
> -    migration->device_state = new_state;
> +    vfio_migration_set_device_state(vbasedev, new_state);
>       if (mig_state->data_fd != -1) {
>           if (migration->data_fd != -1) {
>               /*
> @@ -156,7 +209,7 @@ reset_device:
>                    strerror(errno));
>       }
>   
> -    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
> +    vfio_migration_set_device_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
>   
>       return ret;
>   }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b79..8840602c50 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
> +                     vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>                        vbasedev.ram_block_discard_allowed, false),


