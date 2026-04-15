Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73073F43847
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD27I-0004Tk-Aa; Wed, 15 Apr 2026 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnorwitz@nvidia.com>)
 id 1wD27G-0004Sy-43; Wed, 15 Apr 2026 11:25:22 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnorwitz@nvidia.com>)
 id 1wD27E-0000Nm-98; Wed, 15 Apr 2026 11:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1AogIjE/w1JGt73H6RHYvI0R28u/ShqJuIbz2TPhS2rpRDamMG9q9d+0DzpfEw7OuCV/Hc13q9xuGY2syDTYB6l0jSzrotTofM/8YwdJgC4bQ0vIPJBWW9qrKrnORbvaD1DU5X7QqU+g57M7DFiAK4MktjhSvVGBhNzAHXw+x5+Mz19n6DHUiaI8zoeu9vdSbVpgecHNRvPv68LCasamBy2sECcxeGoPTmeGNnA4QwB25Fy6/EVCT/kb/h1h74+IMVIsbQBDUFfCZzwdynaQ8G8xbcTyWt8lSmiAoAq2ggUzKbBOnuxOQUf5oco22A8HFsJDmxEvlCBljBvVEVuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE/ZWXopzoPSWh9orDpBm8ci2l9rX4b22ppHimCIxhg=;
 b=fwiBmfo2rj+0k6cSGfpQHNQH9fQ+vHiRCwnj+bDpjkBHRbPWnjZQLo8N2vfKme3JjHAu91iCLqIkCUJZFmL8MKgA7M/UqUaSsspUq6GUu2UPtrWBqJ9NvIwnZ4oIhkr2DmxcdWXG3aMMqLxAannrGhku1VMgQSZy1Vss3Yd24NJ8Q7+NQb1AiWZbqhCX7GA90j9R/TRKHQIkiqNzJzM2ZJFu7DRbVa/R1DeBzS9xR6fNtrY8+Q2EhmQ0T37cHFn/Z30ERQEguNyxyc3fRAyBn3QXmiCqOxVcjhdyzg9HsV3CjF58o6n8yHiQpQ9tpVA6TYL5EBaZ7PTiE6cjcGiF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE/ZWXopzoPSWh9orDpBm8ci2l9rX4b22ppHimCIxhg=;
 b=g3SctmJPMzx9kF7dX7bDbGXn8/Ifi6XrOF9MXMnN3DVVCT2ZafnxPG+xxBA8Fz2eOopcIsvOnagWgdOxabvryEMDXfhy7NL8tyJpBJwLWlWtTETDWwpAO8sFkKfsrL2PyanrKmt8l98WXrzDoYrWEWnNpS/Gv0qp6uocu4E8TqUH2E+SVtQdYr0yeIllma4VDKzxvhHwANuKFPX0OnhZFBhtsCE/XwNGDc36+nNCRWSl0173Vmjp597tVWNgtuj453J+YlSHrCoU/mz+KgeCbG/aozvcLOQ0g5qI7Rli/Mub64OTSlQ7WNgBX2AJsKUqmKmnotcz9be/554Zoi/H/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 15:25:13 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%5]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 15:25:12 +0000
Message-ID: <82d9d2d5-7102-4b34-ad7d-df0e8f77b509@nvidia.com>
Date: Wed, 15 Apr 2026 17:24:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user-blk: add seg-max-adjust flag
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260401230548.136541-1-heifetz@yandex-team.com>
Content-Language: en-US
From: Raphael Norwitz <rnorwitz@nvidia.com>
In-Reply-To: <20260401230548.136541-1-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::31) To SN7PR12MB7226.namprd12.prod.outlook.com
 (2603:10b6:806:2a9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7226:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: bb804ad8-84f1-4a8e-8a10-08de9b033023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: EG6ADv7nSrY92rjMydT0pWkjz8921kGiPSYPHM1DIa1izW7pmD1Yis8pg+qZyP17PzBRtgRPiHDEHqHTNgih5PfqJetJilDPXinMjzCHYaZ4o2cyoRNLE4tMngwDsuomMsbVApfKq2FqwEtWePybnZDPBwtaevRrrcY9WfhjeyHIQ0yMxlBL/2kw7mE7WXcJIOkAe6HAFlttnGAguiYpI9f7KhAQd29x3v+ertSIlGNfYCrHMxy0y6l4nZdspgutFN8gJx+B2MbRVGo7VkkwEQvsFDp+aSd/8zDQgeTpryO2TV8QChBI1btFbzEq+cGxF79FifGfbp5w3WCtR7s56kYS5fpY/vNro/d/vLUF2J3diIwgLMHe4MsU+d7S6eBNU3IWpx0D3iJyi3A39S+ErGON3Pepvz98VbMdaFjqARYRIeg7fDBupouxEA41ZJz/8EYCbGlDAexyPasXS5TcSOZsI+38zUszM03s5PgoMZO5hm/1IiqJo8xWTS93k/yi+HsLPpc6T8gNOAr1o72G/9Hz+4avdxEMOdLcVjLIR5l0ccwSrnJ67HkksAU2DOtxfjDEj4OIa9cOtlosDGwQK8oQiNU3rw7x38x+J4jUl0UWE8UR3jraIQDwGUfjMDg82Y92QtE9aiY+33WyOwbsfZ+nq5iz8YiQY28owbMs9Qrn0jUV5Gfx50b4sZtLBAHlpnLaO8V8fvgkhkeKhwpxcZgNH4si50O9x1f/lUlaQP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFozZnBuaUEzb1FRZUQ3N2xQZURIWlIxL2ZyY0dtLzFUcy9KNnFmbHBGQVk3?=
 =?utf-8?B?c0I2ZktiNjREQWxPc3FuaUZoVHk3MVJxTk1IZWorRCtmSVlKMk9DWGdnZnlm?=
 =?utf-8?B?Q2M1MUR5QkVoUHBjeUpDck0vTWcyd3lvelpiQVVoUW1iaDdFanVreWlreFhJ?=
 =?utf-8?B?N0VwVEdaMWYwZEFrRkxMVlBjOUVuTnd6YVhUQ2dST3VMRkNVb0kxeWs3MXo5?=
 =?utf-8?B?RFVZeER4SDZudllHNE5yUUY4dmdrQVZ3a054eEhuTTNvVFNCalB5eDcrS3g1?=
 =?utf-8?B?TmkyQkZiUnozS2RIWmxZMWZic2p4aDRSL24zQTkvenRaNkduYmlqUWVCR3Uv?=
 =?utf-8?B?ZHhnbHVFcENnQlZ6NmhqVzNlODR4UlRkUXBjb25rWUNUMzFrZHBkR2VEV2Rx?=
 =?utf-8?B?QUJsRWRVZGFwbC9BRWY2UjZTU2RTOXhIQTVuay9WK0RZQ0dGRExjazNmR2Uy?=
 =?utf-8?B?V1JmK1NiMmpxMndNTllwdWhDM3hRREVKN3BXZ1A0emVOK3pacVl1TE00bkcw?=
 =?utf-8?B?M1dGdkc0Wkl5dWVCQzJXZFlJUXQ3clZaU3NZV3RUYVhiYkxPUTJPbGhxcTE0?=
 =?utf-8?B?Y3RURk9OMWFBYUtyZHl1WTZmYmp1WEtKVFdudWdTK3ZTNi8wTE1WbVRLWUNv?=
 =?utf-8?B?OEZsbnVpNSt2dWhHYnNtNkJoYXlVYVBUZm5hMVlORU1QVVNHYkJuLzM1WXli?=
 =?utf-8?B?SDVITUNkN3VGNEVCTEpQRnpCWEdEZnlqQ09XUEtucjBRM2p3cmxwUmhkZDFm?=
 =?utf-8?B?NkpJMllDRUtWaEJwUnFjUnJYYmw1eGdsaVhESEdpZFNMeWJybU5XbEdxUXAz?=
 =?utf-8?B?SlZuN0NqWEQwcnhFL1hId05kcit4eFFacDF5VTdlWWtyRStVMERmTDU1eENy?=
 =?utf-8?B?OThPVVh4NE82elVpTmxoRVJucWZFOTR1YlZadGlzdWNNbDhCOFJURjYvUy9J?=
 =?utf-8?B?cWN1czRSV2dnS0Q0TDRUejAxWGRSdVJZRlh5eDlobGxvRkxLdFJZNTNjUDBy?=
 =?utf-8?B?akY1NEFkYmxDeFhQVWFnQmh0VEhoKzluN0F6ckJnZ1UwdmhmMTNLeGhJbTVS?=
 =?utf-8?B?d3c1RjlFNEo1RzRMWWdaTTRWZzhqSDQ5YkUvM1R1aEFWSzVqN0VxeUhIMU0x?=
 =?utf-8?B?ZnFEdVZTWkV5Mk11ZUxtSklkY2RUUFU5SWJ5S3VLdXZnUzJCWXE5Sy9Bdk5s?=
 =?utf-8?B?aWIvaUY1MllsZXVDdDlIM2pQVXl1Ylp4ajlBcmw2Yi9RUnl6ZTdOcktQaXVL?=
 =?utf-8?B?UkwvUWExZkdEU3FTUjBWemo5ODdEMGpyMVM3LzhGdXIxUnZZNWtSdGpIK3Rj?=
 =?utf-8?B?SjlYSm5DWG9nS2wrZS84T05hSkRpSEZSN04rK2xDR2xyaVl1azNXNlJMczJY?=
 =?utf-8?B?L2ZqSC9ZcUxrRmxpMDdHQ1EzR2ZkOWpJNG1VSmhFVlJuQit2UVJvcVgyeDJO?=
 =?utf-8?B?SGFPN0dLNHBtT1BEZXE0eElXS0hMZmpOT3IvMlNnVjI1TlMzN090SzczTHlD?=
 =?utf-8?B?ajRVN2RGOS91QUU5N0R5aGw4bTBvZXZzSW4zTFpIMTlPSmowZFVaalRsZ1hZ?=
 =?utf-8?B?Q3lpZlE5Tk1KMlByRUlrVHN4YysrZnpqQVZEUG5lMlN5OEhsOURIQkpTdlBC?=
 =?utf-8?B?clh3Q3d5a3hQdHExUkNBNm93Nzd4djNERU9PMHRRTHRUOWV4cFVyS1h0YmhX?=
 =?utf-8?B?d3BFTCtaK3R3emlWSG5LMW9hOFFnaTM1UVhzYXlYN2pXV0pHazV0WHNsdEhU?=
 =?utf-8?B?THh6VExxNHlQZ0lSYnRLdUtDYVp1ZlJjTEhXeG82ZEVFcDdRalc4Qm43cTVH?=
 =?utf-8?B?a2JSMHdZNW92bEdKR2RWaUlmaTZHNWIwdGlZZ0NVclIvZ2RsSjFBY3hZbFZo?=
 =?utf-8?B?VFRuMXE2QkoyL0ZqNVh6eVh0M1JxaHRYa1o0WXRRbG96UGJBOG50TWl3eUdk?=
 =?utf-8?B?Q1VOaUJtTTVJTkFhcm5pR3FETzArMjZGZWlTK3R5Q2lnU2NlRlN2cVlLSDZa?=
 =?utf-8?B?SGE5ZXJOWmxTRHR1ZjV2cFNlVmFiNjVLSHNIL3l5R3ZVSmdvMFlINzlFMS9E?=
 =?utf-8?B?d0NjNXpYRHBmeHIvZTZKYkNRbnhVWktyVFZ2THkzS2dkcXozc2NoSVlucXRu?=
 =?utf-8?B?b1FuZml3U08rR2p3MzBxWXVRRU5HQ01SSGxnQ0p4MHFDRmFiZVFKdEJPeFQ1?=
 =?utf-8?B?cE14UDZTMnlBd3RBSm4xUnZYU0R1d0k1cGIzZjExdFBxSlFxWDNUSU5ScWd2?=
 =?utf-8?B?cytVWUxrajY2OCs1QXRtY2IzVzlhelRJaFFMRzlxTElzSDAxeVRsV2dDL0Q3?=
 =?utf-8?B?NW10NWdma1FCUGhyZnQ1dmpCV0RNQUM1M1o0dzQ3U2dheEJRTG1lZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb804ad8-84f1-4a8e-8a10-08de9b033023
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:25:12.9058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsZCgMyRL+GHZVm3mh9uNaEp2J8Afs3sfNhVge07XmJjFwUZw1Hx9p+gQcEEHoIg48vHA+42aJtyIZjyLolQUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=rnorwitz@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Looks in keeping with how virtio-blk does things with seg_max_adjust, so 
I’m happy in principle.

Just a nit and a question.

On 4/2/26 1:05 AM, Sergei Heifetz wrote:
> [You don't often get email from heifetz@yandex-team.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The virtio specification is not completely clear about seg_max and its
> relationship with queue_size. Some drivers (for example, the modern
> Linux kernel driver) rely on seg_max to set the maximum number of
> segments used in a request. If seg_max is set larger than queue_size,
> such a driver might overwhelm a virtqueue by trying to send more
> segments than it can handle. As a result, it either hangs or faults.
> 
> One might argue that it is the vhost-user server's responsibility to set
> a valid seg_max value. However, due to the issue described in the
> previous paragraph, this value should generally depend on queue_size.
> That's why it may be necessary to control it on QEMU's side.
> 
> This patch adds the seg-max-adjust flag. A flag with the same name
> already exists for virtio-blk (and it exists to solve the same problem,
> except that here we have a vhost-user server to consult).
> 
> If seg-max-adjust is set, the final seg_max is the minimum of the value
> provided by the vhost-user server and (queue_size - 2). It is not
> enabled by default.
> 
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   hw/block/vhost-user-blk.c          | 11 +++++++++++
>   include/hw/virtio/vhost-user-blk.h |  1 +
>   2 files changed, 12 insertions(+)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index c151e836770..23f910d9fe3 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -65,6 +65,11 @@ static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>       /* Our num_queues overrides the device backend */
>       virtio_stw_p(vdev, &s->blkcfg.num_queues, s->num_queues);
> 
> +    if (s->seg_max_adjust) {

NIT: declaration at the top of the function

> +        uint32_t seg_max = MIN(s->blkcfg.seg_max, s->queue_size - 2);
> +        virtio_stl_p(vdev, &s->blkcfg.seg_max, seg_max);
> +    }
> +
>       memcpy(config, &s->blkcfg, vdev->config_len);
>   }
> 
> @@ -474,6 +479,10 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>           error_setg(errp, "queue size must be non-zero");
>           return;
>       }

Can you explain why queue size must be greater than 4 if seg_max_adjust 
is set? Sorry if I'm missing something obvious.

> +    if (s->queue_size < 4 && s->seg_max_adjust) {
> +        error_setg(errp, "queue size must be >= 4 when seg-max-adjust is set");
> +        return;
> +    }
>       if (s->queue_size > VIRTQUEUE_MAX_SIZE) {
>           error_setg(errp, "queue size must not exceed %d",
>                      VIRTQUEUE_MAX_SIZE);
> @@ -608,6 +617,8 @@ static const Property vhost_user_blk_properties[] = {
>       DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
>                          VHOST_USER_BLK_AUTO_NUM_QUEUES),
>       DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
> +    DEFINE_PROP_BOOL("seg-max-adjust", VHostUserBlk, seg_max_adjust,
> +                      false),
>       DEFINE_PROP_BIT64("config-wce", VHostUserBlk, parent_obj.host_features,
>                         VIRTIO_BLK_F_CONFIG_WCE, true),
>       DEFINE_PROP_BIT64("discard", VHostUserBlk, parent_obj.host_features,
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> index 1e41a2bcdf6..dee848cfd81 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -34,6 +34,7 @@ struct VHostUserBlk {
>       struct virtio_blk_config blkcfg;
>       uint16_t num_queues;
>       uint32_t queue_size;
> +    bool seg_max_adjust;
>       struct vhost_dev dev;
>       struct vhost_inflight *inflight;
>       VhostUserState vhost_user;
> --
> 2.53.0
> 


