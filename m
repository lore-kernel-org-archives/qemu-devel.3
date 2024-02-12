Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67126C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSVp-00038L-F2; Mon, 12 Feb 2024 04:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZSVo-000383-AJ
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:22:04 -0500
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZSVl-0005N9-FD
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:22:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB33H8KC79rCwU72uPM9p/SSsy4i0O+CjeztTImo6YknbbttLt2G9glIy1wT6FzZHUGu/1Nis1VytjT0JdAbifGocM0+l/Q/OhmTVVl7HJb+8RIv76fV9WeVIIPv2Gj5BB7hOE35YiO2ClOxXSCtspRgh8qFi+N5Lt1ewnl4SXevZT+yAPFY6UjLwHPSTUFaPxG9B2S56B8I6hmz7Yu5QICCWzJnLOUTavDbKOFAfQRleVSNa06o1LVCKqvYrfSsCNMlLxyP4wfU1S6EY6mZL2LR2YqE3GZESrkY9SUEwwgGVQeElDHUByJXsUkYC/abRQe+kRi/gc0kLX85+G99tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKbMSmRdZIDsSoumYG5ty82XIgS6gNKFBt9eYccKrfk=;
 b=RX7ZtxIdU/lxzEHP9yHqy3BNMZ6y5KeU/mVMCY2hg+eJ3BDNq/CUgRUI2Eed1weCMvwhEKL6x6hz7DAeM+uwg5NIt7WiL6rKIVz0B50UNY9gx4PnAtNRPJ62gZ7TO5TdQpwdrVUgv8gq9VOW1N+YMArD2ciI2/n9mWCLynuiexsN0Ncg2uV0dMk3yV9VRGJVSbxH7v+I3XjQNXU7ikxjLm+EP014j4ph3tUzXdZ8Rk0WaIZo3H/E53nK4AT7oYLd/Gw+UBcyvPCc7Do2+ebL40syQKTBO542kHpoDN4qEhr/dUZopzROqXl9d/AXuuj8Cq652GvXXbZOF/31bejueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKbMSmRdZIDsSoumYG5ty82XIgS6gNKFBt9eYccKrfk=;
 b=tZB5paOQgJFXud6H0Om887C+lNFO+V2kTVO76lahSwFkhrzGm47W4L0s8WtVvQZWLM0RhRqVuVUfOgad8mpLKJ/n3tNmGsmjM/LBBJp3bynrpJBzvJ8Nyp+uTH3VqaMNuwyF3YoHEOaewEUnYzSCHUF9KyxtHT4ehG46lwmYmPC+viuY4ww4q8Z8fvAqZiNc+lPdbfPjxhnQIOW4ynwPm0fpwaF/wDfBMaQm9r5nTG1/LhFqHisBkVn1PlgIBvqfPi6Y2fDXO3N22V7uPzXgnTkiZ3udN3u+gcNPUx7gZGk48oK1WkIJkeb1To8O7OeI/tplZQd+dOpiaOC8UnHiQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 12 Feb
 2024 09:21:55 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 09:21:55 +0000
Message-ID: <1b9a06f8-00fd-42b8-9473-e5e8b46ff1b5@nvidia.com>
Date: Mon, 12 Feb 2024 11:21:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] vfio: Add Error** argument to .vfio_save_config()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-10-clg@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240207133347.1115903-10-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: fee96ec1-55a9-45bf-e7a8-08dc2bac0e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keIKazzIu69CGjnzZQifVjyB9Aidc9ut59O+gFmGWXYoNiRyNYIkGZcvj8XdlL97CEWHK5RLYGhG9ETfMbKAKiNimKFWPd174yLQLKjMCExIf0bql+HRnigEmDAP7V7VvQ3DiWLGlhizL7wV/i0TrSHyV4hSfJDfWp/pSolyGspnOzuOCyZ1KYvJ8HQrPpx0w4+Fw3haXJ8eakdwPZOKdjeEx+5wNTEu92/mz6z5AwJEtglah2wkl0hgCncb0B2CjKPTiJ2ynDUZ9fohe93scRwtwEv7/Oh9s0HuDJmxjBJTT1jHbQRSPfKLOrbKYgrWTlD8VVvENj/gIpLgmp6xb3EovRb1jUcnTVwbZOGuwwApuDRwIrsImL+2pD7RCfcQBHSrKMsjhmeYzOq5gJEUf4KoEGSfwvq+GcsA/PDVPRBvfT5alYSE/zsLVOiv0HH77pQaE0EqUBtUarYN8ISbbPkY+/b34874Z7dEVFu+Ad8R+MXzwpV27qePtZJ2FqJ1LS8Ir1PumuI3au8dyyQWI3iCsBpjgNi8W8FaAb2mwcehd+3W+ny8WCQjKOIAwJfu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(53546011)(83380400001)(6506007)(6512007)(478600001)(31696002)(6486002)(26005)(86362001)(66946007)(8676002)(316002)(54906003)(4326008)(66476007)(31686004)(6666004)(38100700002)(66556008)(8936002)(36756003)(2616005)(41300700001)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFkQS9aMXlDWkh4L3JwQU13UEFNcnZFdStBY0ZwNS9zUUpkLzhIcjZZTW9p?=
 =?utf-8?B?SFRLT2t2YkJOSnVrYldxTkg4a2F4bWpqbTVMMzJqaHVVdG1UeHprY25CeUcx?=
 =?utf-8?B?WEFlOTV2a213V3REZXFydUhUZC9DWVdxamZEQjJtRFY1bVdiZTk0RjRYQ1ly?=
 =?utf-8?B?VURhakNFeExqem1vaEN3UFRtc2pqMFM1emc2OWlmYW9lREtBangzUGJWalp5?=
 =?utf-8?B?UjA3Y3E5N0pFTmdsY2pmUXlxRXNSMG95dmRkejByWWJYOVlaUTN4eWRCMkNo?=
 =?utf-8?B?U3pYcXlPWk9MV1FuTmxHUlIzdXlDN1d2NFl3MS84T084dWV1MTlOcjE5RlZV?=
 =?utf-8?B?cjI5OXlQSllWbWVuVTlLczZPZkE0bWlvRkZGeVpoeitNRGdwcFJuQnU1Mkxk?=
 =?utf-8?B?ODZYMnZ3MXI3c0tUakV4OTRiRFBJaWtNeHJzWXE2T1RLRndQa3htWHh5UU8x?=
 =?utf-8?B?ZC8rWmZ4bklhR2lYcm52TjIwVkJ1U0ZNMmpiZEZhSnhFWVZ2ZDRsZkVKRldk?=
 =?utf-8?B?bkZFS3V5MkxHYVJadUZ2TVRrdFRCK2lmQmhZNXVVVnFCUHlHN2xYNFFnd1FV?=
 =?utf-8?B?MTFvRTRKdWsrS1c1d3JFUmFadU9PbTBFTkM1SHJBaHRObWE3cm15RXE2QTkw?=
 =?utf-8?B?TGJuV1NvdlN0a1o0eXdKMlhSTndxdzNqRk1IdEJ5cDdaejdqQzJOL1Uyckxy?=
 =?utf-8?B?anhEa1RwWkE1Z3ZGbmpHcUZiUmVPRUIwU1BYc0VXd2ZQRHZ5eXA5NnErakQx?=
 =?utf-8?B?MktGdHg0dWMvTnNDNjcvRXhXRWxHK28xR3VwdzN5MzdKOEdtMWRNSklyS1Fj?=
 =?utf-8?B?bVZwTHZqNm9FdDdpT05LU3NKcXk4eGZBVWdTbjJrOW8rVDdybUYxajJyUGZk?=
 =?utf-8?B?dW45Njg2enFDTEdmdXc3MXBXdkpuaDZHVW9rZVJaSjB2dk9janQ2Tm5kUEE2?=
 =?utf-8?B?VkVIWGN5SXl2RHVXWUNHOTdSMkxCYUdEUFVmZXkrOWlmUnRkU3VRRzlHUnRR?=
 =?utf-8?B?dkt4ZkUrL3g5Y1RtaGZiMWhXbW1OSWlGNFRObEZzU3Y1cWdVa1g5MnlGSWU1?=
 =?utf-8?B?MFN5eDJndm4rUHB3dXFsczN2Nnhwak1zV0xnRDRHbyt3QTZvL0tUQnhnWFJJ?=
 =?utf-8?B?QllWbnF0aUxXVUhzR285bnN6VmtaRkdJOU5RTWFXWFU5MTRkY2djNDNuYXd0?=
 =?utf-8?B?d1BRZnFpVU5RbU1KK0UrUjVleDdvNXhmSEZKQXpwWDZyRFF4QjV6NXpZbjhG?=
 =?utf-8?B?aFNSK0lVQ0RYelE0L1Z4WHIzWWp3Z0xubTgxSE1rMXBqZkxKbDQralB0TG4v?=
 =?utf-8?B?R0h1NXRCOENEQXZmQUhmbDdsUkt5MjVYNVZsaG9xanByMWIxazU1TEozR3U2?=
 =?utf-8?B?M0ZPbEoxUnVWUTN5SHFDRkw2cW9uZmVENTVISjVNcmdsSUhqcytwSytNOERt?=
 =?utf-8?B?aDdYQStzelZ6V3UzQmVJWWduWm5NdS9xekFIUjVCK2xITmRydnZGOUFSVGZp?=
 =?utf-8?B?aDZrTHpueDRHR1U4TlY2a3A0cFNKV3BBSnF6bFJjOUR0ZEtGeXhaRytMbTdZ?=
 =?utf-8?B?WjRpbjF3WVFmYzRzYkk3cEZzcENtTVhNK1VEbXVWdnBCMHN2eGJVdnlZbDhm?=
 =?utf-8?B?c3ZPNjFtcFBmK2xNL0JQa3d5ckUwZU1aK2lXRkljaEFmL3FuTkxZU2hVT0li?=
 =?utf-8?B?WllZYVFMNjQ2ZVQ5Q0J0UUFlRUVzNzFmV0xzRWZBRmR1MWJpQjcvMnkwT1RU?=
 =?utf-8?B?Ly9ZT3F1L2N3TXVvdTgxN05JdHp5bndxQ2dyeHBuNUpMa2M2Z0RLQjlsV0M3?=
 =?utf-8?B?aFVmenVJU0RMQy9vZHBiYnE0MUxTUHdzSEtTZDIyWGpoYlk2OTh3OHJObW4x?=
 =?utf-8?B?MEFZQWpQRnhyUzNlTUV2NDd2Z3QyVWFmSGcrZTUwK2E3emtXdDIxN2V1OU5z?=
 =?utf-8?B?UXEzQzVzdlZPbDMvaFZzZE1tRnZWTGtDd2xybG5JUmx2SkVtaExsTGV4WHRL?=
 =?utf-8?B?eXVQVHF0MXRCcXdrUDlYOWZTcFMrUXUxVHRsbzJiYjlCYkNyZ1JURDR1WmhH?=
 =?utf-8?B?QTJpQmxYaWFSQ0tuWFpmWDllZEl1NlZwTVd1Vkx2RWx1cWtLZ2R2WjJWZXVY?=
 =?utf-8?Q?c2pma2ae9gPMinO8yG8NSYVHW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee96ec1-55a9-45bf-e7a8-08dc2bac0e1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 09:21:55.2731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3trIIExgwIAIbYx6zzNemWnM0Ar/AY/t4MKzQ2H5BnI29oHzC9GgTXFv+4r5jZ5C3GUfHSOVPuoLKktzcH1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 07/02/2024 15:33, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Use vmstate_save_state_with_err() to improve error reporting in the
> callers.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h |  2 +-
>   hw/vfio/migration.c           | 18 ++++++++++++------
>   hw/vfio/pci.c                 |  5 +++--
>   3 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9b7ef7d02b5a0ad5266bcc4d06cd6874178978e4..710e0d6a880b97848af6ddc2e7968a01054fa122 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,7 +133,7 @@ struct VFIODeviceOps {
>       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>       void (*vfio_eoi)(VFIODevice *vdev);
>       Object *(*vfio_get_object)(VFIODevice *vdev);
> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);
>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>   };
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2e0a79967cc97f44d9be5575c3cfe18c9f349dab..fb264c1ef57bbbde4306901e5449e0dfbd0ce3b7 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -190,14 +190,19 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> +                                         Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> +    int ret = 0;

Nit: 0 assignment is redundant.

Thanks.

>
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>
>       if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
> -        vbasedev->ops->vfio_save_config(vbasedev, f);
> +        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
> +        if (ret) {
> +            return ret;
> +        }
>       }
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> @@ -579,13 +584,14 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   static void vfio_save_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    Error *local_err = NULL;
>       int ret;
>
> -    ret = vfio_save_device_config_state(f, opaque);
> +    ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
> -        error_report("%s: Failed to save device config space",
> -                     vbasedev->name);
> -        qemu_file_set_error(f, ret);
> +        error_prepend(&local_err, "%s: Failed to save device config space",
> +                      vbasedev->name);
> +        qemu_file_set_error_obj(f, ret, local_err);
>       }
>   }
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa387f0430d62ca2ba1b5ae5b7037f8f06b33f9..99d86e1d40ef25133fc76ad6e58294b07bd20843 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2585,11 +2585,12 @@ const VMStateDescription vmstate_vfio_pci_config = {
>       }
>   };
>
> -static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>
> -    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
> +    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
> +                                       errp);
>   }
>
>   static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> --
> 2.43.0
>
>

