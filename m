Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44267C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSid-0006oF-VD; Mon, 12 Feb 2024 04:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZSiZ-0006nz-Tl
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:35:17 -0500
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZSiX-0007XU-QO
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:35:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg1RcVqW5o2xpUK2kDLZu3pBzZOpP3YnRh56mJKk/bRPXkxJYPBnvhlFNo6ERcT7RwPtadqrVimmEUkVxzEygv+OFV9eU4HwushtNVa7jALMiB4myGGGcbuf4yAwI5sYpfx9DAmyIgUUToQyPAyTgFcygh3OpPA2gYOciHcSo5x+tzx6rzBOp+1m2+eezs9Ll0j8rM8VDcIfukpZ2+gZPan7y9ldZc0kacmxzhqpvq0oziSkfHL/SH8wccBHMZhPfbQoTnNZz551PnqLfsxlYLJuo8Em+38dF0V/8qkqdFQt89aYenPXNK4R1jfjLvmtG8d6azSQhrnLOfa2Y2wafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKXmtoias3aYXNnb62oAt8gXzZEAi/b+iD6VGXU+pfE=;
 b=Lzgt7tgwcRuvsAAqnGePxHoebu9KmiyZMs6YC9kZvcdUk4jcSQgDKiiWuD84WoiOZeqfeegYKHj99UNKCzdvoG1qC7s6/cPTPXlhpzIutwkjkPHjn3u2Qfcm0a2I5sf84ILlDnkGbjYLbBtYsyrqa4TXrqReMBdbq3Qs8NdAw+m7kaI8x7SnS49ai7o//XTs2Z5pI/W2yxd0z2VgNLMydH8K1VmsY1tyscSYKML0YjrhWOXWRTV2p3vC6iuSp5+B4e9aTDzDCuVJ/gfRNhp24lGfhbP65H8XQ2U6gK79fDBHTgZm2IlG+zfiT1ab/cXcsuzSXYg9IAyA0tXwu/UUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKXmtoias3aYXNnb62oAt8gXzZEAi/b+iD6VGXU+pfE=;
 b=c/kJopxANVdguebl1FnnPYxWt5OcP2hDQ1mS/4FFegVDTTp9flC+JTmfSLOD6CNO4Jw8HO97aEMu49oZdrLOhYUpq/gJDcQlQnXBILpyoGjhL45H17kecNC1NwhGQGbztbwgCC32LtZONZKtzaO8KBcWfd5VecIieL5q+b/UiUP+R8dqoVsOn46bN1W6GzWtIzUnmwBnjagLPdfcNfO+OZylgv5AIgvhmzqbUF8THSavl3rQXa+GEcvEWiYzmDE9CeW/Zaj7+qJon4wusxXZOR7aKNWmP6gUvixbEGnSfcUYn8WCr2P8UyYX/zi3RMk1UiIm2V7ugmcK4H3evW70cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 09:35:08 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 09:35:08 +0000
Message-ID: <addd8e61-535e-4a7f-976a-8e0c57cfe944@nvidia.com>
Date: Mon, 12 Feb 2024 11:35:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] vfio: Extend vfio_set_migration_error() with Error*
 argument
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-12-clg@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240207133347.1115903-12-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1e9cb1-9f91-48e7-7844-08dc2bade6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+mZd0VF4DGjd1dOuVRENTSBbEwKmDDhywckFgV392/LhG2y74mSMoaGCDtiFPxUQtvyqj+MLbG9gC5dbsBAnZ4+OToC0zihgTMd/fG8O4b+hSU3U1R31Uh0z3bTQ43XIu0vr1UYjF+7WO5ih5URsJ1ZzKCPTJftu9weGB8V08TXVkzp+g7P8ZEFl4xN7TUM1fYXO1Kiig2Lbop+Xueyly+mSq37KFKAgLG7HR6x9WEDNbPrZhGkl7+TPwqELZ78mDpp5JvNRiW86u85woaBSSM+H+/XhxZ1VD7/epC1MrrPoTrRj/kTvaU+rsz6YSC9fyU7okDrPCxssR8YlOlps8fXHv+FQHrwZFYAXzPCySLQQrIa61VSjLDSFqEMzh+dEg+NLUDE3YQRAnAwzX1bI15mmcsvV2NqyYBs81FE1kHCyX7TJh2zFp/NGROzRjFFOP8q8Vjrm3rBXMpriO081TGPWm7TE7mXqN51hN/QRCTby5xecns1aK5e67ZWOq9UMpYydXusNQMFOCMvfWhvo/EtvJ+NuJ5xPNqtPhCY2hx0j+cnYrpad5IeeFYRY/XS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(41300700001)(2906002)(31686004)(5660300002)(8936002)(4326008)(86362001)(31696002)(83380400001)(36756003)(26005)(2616005)(66574015)(66946007)(66556008)(53546011)(66476007)(6666004)(38100700002)(6486002)(54906003)(6506007)(478600001)(316002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1VSitzOHNvN2FJYTlCU3F1cjVkQXZSWlV1dHl6SWtaazlCQU9YSElTTktv?=
 =?utf-8?B?eGtCS1VXd3k3dG9xdGlPTFAyYVMvd243Yjk4bGRWa0d5d3hZWVo5OUFTK1RS?=
 =?utf-8?B?eVJ0QUpJazNFWmpESXlTWGJ4bSsyRUVxTGxsN1ViNTN5aVMzbGl4RXdTbUNa?=
 =?utf-8?B?MmtUeE1rUHVkQ2JkOGpWS1ZEa2ZVLzBmVTZEQzZGZVIwTjdvTWx6TWxwN1NJ?=
 =?utf-8?B?UDFpSGdjQTE5R0hQMEVKczl3K0hHY0t4SzJ5dlBYbEMvQnpKdmcyMEVmTmtw?=
 =?utf-8?B?ajIxb3RoZEwrckNiSmpXdEliMm5SQ3R3ME54czUxaFBLaDJ1ZjVGcHhBWFh5?=
 =?utf-8?B?M2RrVEpaV245K0pTTTRRdWhXUjBndDk0S2kzRWtPTks3N3lNK1FydlFVWi9x?=
 =?utf-8?B?TUtqNzhRRjQxRFVqMTd6VmloYlpESGdjblZiY0RKMEtnK2dNa200NWZLK2or?=
 =?utf-8?B?VFpqWGxyRXI0VGlsempnc2JKUUNLYXRSSE9SenZpamlRb2lRRkdkb2gwcUtQ?=
 =?utf-8?B?ZXpONElkNVR1d2xqZFRKOHdKczQxNXArUGZxSkJTdmVOdmNSbXp3UFR0Q0xD?=
 =?utf-8?B?UmJiaWVabEh1TmZaUDRZenBWSVNnRnB3Yndab0Izc1RBNWlMZThRTGtoRkFV?=
 =?utf-8?B?TStLcTBhZ1hEU293SjQ5ZnQ1a2xGODRmSXpLT3RaRVZTUktWY29RTGI4TVdD?=
 =?utf-8?B?cUhjZC8yYjNrR05sQW1ablR3QVhXNG01V0xzRVBpRythNjVUcTRuVVM4UjlI?=
 =?utf-8?B?L1liaDN0c1FJUlh2emFad25VTlJZbVIzcnBKZm8xMGZQWXEyMU80Y0NRb011?=
 =?utf-8?B?MEk5SllqMTZ5WDVybzNTSUJ4aDZENU5KaWpTUDhCOUZZUHZZaHVQdCsvOUZT?=
 =?utf-8?B?MUh5eGNIZVBucWFocGlxQmRLUDU2Z3VldWxWSjlhaDVpRXFUU0JsNTJ3M1Jw?=
 =?utf-8?B?cEZoK3hDLzRBbHNzTUdCTkVUNUViMzJiMzJNUDhOMmFxdktERzJiRXhwYStt?=
 =?utf-8?B?YnBJT2U4Zm9tTTArM0M2eGJiUXQ2bmM3QzgvdXRSYW5mQTVmQUYwSldWRHBa?=
 =?utf-8?B?ZER2R3FnU1lKdzN3THQzTURWMWZnZG1pTU9NaTBUY3hGME9La01hdmVzMkpC?=
 =?utf-8?B?Y1NzWWdBdXJxdmxUWnVMZ05FRitGQVJ4a2JGU2lEcjc5RnU2dnpaZElmRVJ4?=
 =?utf-8?B?bmJlcVovV29IK0QreE1yd1RwdEJ0YUhUbFhLQ3lXWU1OaGF2NmpEZEtrV2s2?=
 =?utf-8?B?dGsxQXBXQ1J2clFEMmJsWE1RMmtlY2ovTDdCL3M0TDJBbXA5ZVNjSGNvVmFX?=
 =?utf-8?B?Tks2TXhHUkxZdVljQmt1TUl2VmFoRmRsOEhSTVdpYWs3N1N5QkNzRHI1Sy9v?=
 =?utf-8?B?ak1Md2d3c1NBK2FoTU9NbDRSekMvVGVmcTRUeHh2SzZJaGY4djh1RkpYalZr?=
 =?utf-8?B?eitjOEMzMDlqUlVqWnlxc3NiMG9OQ2hxN3NINWZjaDVQdjNjSEpTTWNtOHJ4?=
 =?utf-8?B?R0tzQzRmN3hZY3RLQURMVTg1RU9ZR0tsRktQUmpIaWR3Sk91Ukc1ejRab1FK?=
 =?utf-8?B?djhVOXAya2dxTnlZTC9mU2ViRURSOXZpbnduSjJWUUFxRUlJQmxrbkxmQ2Yx?=
 =?utf-8?B?Qmp4d2Vja25hMW9HbkMrcUVtamwxZW9nM1kxRGhWc2Q2NGNoUklXbG9WMVZo?=
 =?utf-8?B?OWhDQlFRZ3I3L2Rqc3c2NkRWOXAxNC9RajhpejI2S2JReTBlU21SRjR0QmM2?=
 =?utf-8?B?SGlIZjMzT1RtbWx1SWQvU3dERFE5S0xnYWUrQVlKN1crejZKbnBIa1pTa215?=
 =?utf-8?B?YWhoMncrZlpDY2kwQ09ab3lxWGpoRXR3M1YydVd6VGJ3Z0Z1ekltUnArQ0Nm?=
 =?utf-8?B?VXVNTDhWZXJTc3puVzJBQ1lSd2Y1dHJmOTA1MDlxRVBJYWh0UldWcS9uUGhP?=
 =?utf-8?B?NTZKNUpPcXpuQVR6bHZVaVVSdUdZU0dpa29pM29PR21lbll2bWdDazQ4YmZH?=
 =?utf-8?B?cmJucS9DS2Z1eDd5bTVINnFUUzl6cVl1cXpOd1ZPV3JzelBoczBZYVNrd2ZW?=
 =?utf-8?B?ODJ4bVlSelVhR3A2M2JoRnFKTG5NUXFkcjJ4VUVBcTdEUm5aUnRYOStEbEZ6?=
 =?utf-8?Q?MBd2MOQJmOZGAOy4TOJsJbBhm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1e9cb1-9f91-48e7-7844-08dc2bade6a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 09:35:08.0705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6p/PpHcg5GGnkrJmv76NJbO2B5LXKryP5vllMNZ/tbbwTtcmqyC5LXMRw8mSw93DbBpUnZ/wDmac+e6+jOyxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
Received-SPF: softfail client-ip=2a01:111:f403:2418::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Hi Cedric,

On 07/02/2024 15:33, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> vfio_set_migration_error() sets the 'return' error on the migration
> stream if a migration is in progress. To improve error reporting, add
> a new Error* argument to also set the Error object on the migration
> stream.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 50 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 82173b039c47150f5edd05d329192c5b9c8a9a0f..afe8b6bd294fd5904f394a5db48aae3fd718b14e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -148,16 +148,18 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>       return vbasedev->bcontainer->space->as != &address_space_memory;
>   }
>
> -static void vfio_set_migration_error(int err)
> +static void vfio_set_migration_error(int ret, Error *err)
>   {
>       MigrationState *ms = migrate_get_current();
>
>       if (migration_is_setup_or_active(ms->state)) {
>           WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>               if (ms->to_dst_file) {
> -                qemu_file_set_error(ms->to_dst_file, err);
> +                qemu_file_set_error_obj(ms->to_dst_file, ret, err);
>               }
>           }
> +    } else {
> +        error_report_err(err);
>       }
>   }
>
> @@ -296,15 +298,17 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       void *vaddr;
> +    Error *local_err = NULL;
>       int ret;
>
>       trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
>                                   iova, iova + iotlb->addr_mask);
>
>       if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> -        vfio_set_migration_error(-EINVAL);
> +        error_setg(&local_err,
> +                   "Wrong target AS \"%s\", only system memory is allowed",
> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        vfio_set_migration_error(-EINVAL, local_err);
>           return;
>       }
>
> @@ -336,11 +340,12 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>           ret = vfio_container_dma_unmap(bcontainer, iova,
>                                          iotlb->addr_mask + 1, iotlb);
>           if (ret) {
> -            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                         "0x%"HWADDR_PRIx") = %d (%s)",
> -                         bcontainer, iova,
> -                         iotlb->addr_mask + 1, ret, strerror(-ret));
> -            vfio_set_migration_error(ret);
> +            error_setg(&local_err,
> +                       "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                       "0x%"HWADDR_PRIx") = %d (%s)",
> +                       bcontainer, iova,
> +                       iotlb->addr_mask + 1, ret, strerror(-ret));
> +            vfio_set_migration_error(ret, local_err);
>           }
>       }
>   out:
> @@ -1224,13 +1229,15 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       ram_addr_t translated_addr;
> +    Error *local_err = NULL;
>       int ret = -EINVAL;
>
>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>
>       if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        error_setg(&local_err,
> +                   "Wrong target AS \"%s\", only system memory is allowed",
> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
>           goto out;
>       }
>
> @@ -1239,17 +1246,18 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>           ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>                                       translated_addr);

If vfio_get_xlat_addr() above (it's not shown here) returns false, we 
will pass a NULL local_err to vfio_set_migration_error() and it may 
de-reference NULL ptr in error_report_err().

Should we refactor vfio_get_xlat_addr() to get errp, or add an else 
branch below, setting -EINVAL (and removing the default -EINVAL from the 
top of the function)?

Thanks.

>           if (ret) {
> -            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> -                         "0x%"HWADDR_PRIx") = %d (%s)",
> -                         bcontainer, iova, iotlb->addr_mask + 1, ret,
> -                         strerror(-ret));
> +            error_setg(&local_err,
> +                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                       "0x%"HWADDR_PRIx") = %d (%s)",
> +                       bcontainer, iova, iotlb->addr_mask + 1, ret,
> +                       strerror(-ret));
>           }
>       }
>       rcu_read_unlock();
>
>   out:
>       if (ret) {
> -        vfio_set_migration_error(ret);
> +        vfio_set_migration_error(ret, local_err);
>       }
>   }
>
> @@ -1345,6 +1353,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>   {
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
> +    Error *local_err = NULL;
>       int ret;
>
>       if (vfio_listener_skipped_section(section)) {
> @@ -1354,9 +1363,10 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>       if (vfio_devices_all_dirty_tracking(bcontainer)) {
>           ret = vfio_sync_dirty_bitmap(bcontainer, section);
>           if (ret) {
> -            error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
> -                         strerror(-ret));
> -            vfio_set_migration_error(ret);
> +            error_setg(&local_err,
> +                       "vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
> +                       strerror(-ret));
> +            vfio_set_migration_error(ret, local_err);
>           }
>       }
>   }
> --
> 2.43.0
>
>

