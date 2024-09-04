Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73193CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slomD-0006TG-2i; Wed, 04 Sep 2024 08:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1slomA-0006QM-AY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1slom8-0007sx-LM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725451575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dBW9QyBTPJ2vPf7oNy3xBpLtcKazFBxSJAYyxXMm5To=;
 b=H97ouyJG+7yXV6Pto5IniOVDuymOmDkAs1rEpmVbLaNv/Luhf4mzc0aWXBiqWrnrhZHlKD
 Uzh/o3eL2ZQDYqRRitL70K4V1Vi3mnFRNoKNVzm23ES63FClyFRkjSyEWzRhC3FNgwyW9A
 7R9P2d0P0k2rm7boU6Am6gbpHkYDSbE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ySx9gp-6PVSsDXmE5p3iog-1; Wed, 04 Sep 2024 07:59:22 -0400
X-MC-Unique: ySx9gp-6PVSsDXmE5p3iog-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6b43e6b9c82so169658737b3.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 04:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725451162; x=1726055962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dBW9QyBTPJ2vPf7oNy3xBpLtcKazFBxSJAYyxXMm5To=;
 b=nlLeW6b374DQVub5MeT7zWYGThwFu706tzxpbQql4BYZO1OsByTpQY+aGW/mi05anA
 DLxJAsftcwYdWRU2CypUhBBVNhIO7PLOPBQdIy1tgt1XTZSjjBbieo8nJdXxRF6aoJqm
 Ahn8OfcqXpUaM3IfrcdfemysnJWYmx1s9/3Dm0EdJv5hWReUTwNIB2dgK2Gn5HavKaju
 8xmp/djJ0aHkVrvrqFFeoVDJ+Gidmbls0neQCT86IWE6UjyI0BkVuFOXAMQaWdyIKzoR
 SdJ74YW9I8uScJ4GtCIzi0vZjuFbEujovp7d20Knyp1hkXrnAHIxllIOCdllBfjN4ma2
 7xrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdSjcjWdy1jZb8qAiCtJMba0jpMgVZMQx7OtdHR9IhftE1MoiXBhatQjCEdkFNEfHmOi5ULzlZqbvx@nongnu.org
X-Gm-Message-State: AOJu0YyS+SPE334vRH3C/AX/qTLmCQsq+WuPC7GzyVCyAtzrCr1eINIu
 H61YD1YDwjj5UHMn5MkBHmShIZ40f8y2MbMl03eV9alUNbGtRMv/jMsFe1wlvBDU+eNNOnMU0ln
 sXEAEqqs6muqVM0hCED1jOpgbqo1y8n6hqY7AS68CvAeJTlFjAxDc
X-Received: by 2002:a05:690c:6785:b0:630:f7c9:80d6 with SMTP id
 00721157ae682-6d40fe0f6f3mr192366177b3.27.1725451161914; 
 Wed, 04 Sep 2024 04:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq5HvwRqtezxFnSO42dBg91ombB3BJoTOvLU4UJi+3DHaAlCu/R/sHK6aAwUDyIFtI7vIAAA==
X-Received: by 2002:a05:690c:6785:b0:630:f7c9:80d6 with SMTP id
 00721157ae682-6d40fe0f6f3mr192365827b3.27.1725451161569; 
 Wed, 04 Sep 2024 04:59:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d5b0easm611441485a.100.2024.09.04.04.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 04:59:21 -0700 (PDT)
Message-ID: <1a4270a7-212e-4651-a720-913b3dd11296@redhat.com>
Date: Wed, 4 Sep 2024 13:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/19] qapi/vfio: Rename VfioMigrationState to Qapi*,
 and drop prefix
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au,
 andrew@daynix.com, arei.gonglei@huawei.com, berrange@redhat.com,
 berto@igalia.com, borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com, kwolf@redhat.com,
 leetroy@gmail.com, marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 avihaih@nvidia.com
References: <20240904111836.3273842-1-armbru@redhat.com>
 <20240904111836.3273842-20-armbru@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240904111836.3273842-20-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/4/24 13:18, Markus Armbruster wrote:
> QAPI's 'prefix' feature can make the connection between enumeration
> type and its constants less than obvious.  It's best used with
> restraint.
> 
> VfioMigrationState has a 'prefix' that overrides the generated
> enumeration constants' prefix to QAPI_VFIO_MIGRATION_STATE.
> 
> We could simply drop 'prefix', but then the enumeration constants
> would look as if they came from kernel header linux/vfio.h.
> 
> Rename the type to QapiVfioMigrationState instead, so that 'prefix' is
> not needed.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   qapi/vfio.json      | 9 ++++-----
>   hw/vfio/migration.c | 2 +-
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index eccca82068..b53b7caecd 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -7,7 +7,7 @@
>   ##
>   
>   ##
> -# @VfioMigrationState:
> +# @QapiVfioMigrationState:
>   #
>   # An enumeration of the VFIO device migration states.
>   #
> @@ -32,10 +32,9 @@
>   #
>   # Since: 9.1
>   ##
> -{ 'enum': 'VfioMigrationState',
> +{ 'enum': 'QapiVfioMigrationState',
>     'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
> -            'pre-copy', 'pre-copy-p2p' ],
> -  'prefix': 'QAPI_VFIO_MIGRATION_STATE' }
> +            'pre-copy', 'pre-copy-p2p' ] }
>   
>   ##
>   # @VFIO_MIGRATION:
> @@ -63,5 +62,5 @@
>     'data': {
>         'device-id': 'str',
>         'qom-path': 'str',
> -      'device-state': 'VfioMigrationState'
> +      'device-state': 'QapiVfioMigrationState'
>     } }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 262d42a46e..17199b73ae 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -81,7 +81,7 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>       }
>   }
>   
> -static VfioMigrationState
> +static QapiVfioMigrationState
>   mig_state_to_qapi_state(enum vfio_device_mig_state state)
>   {
>       switch (state) {


