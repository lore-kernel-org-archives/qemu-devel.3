Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58037C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc0da-0003I3-Pz; Mon, 19 Feb 2024 05:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rc0dY-0003HW-Tz
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:12:36 -0500
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2409::601]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rc0dS-00031v-40
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:12:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDJqpDDVlKWDofI4s42PuTuQJVyMv3+cXHfkW8Q/Ds2Q6WY1Ty7CcPzEIXUFwROGYC/UrZTe863S+kdcHfwygtr4eEN235tE724sBJHru8GUrUZfU85rd1eqTTDMBcMNrSwIL3co16YTn2W/YsgmiCfqb66y9lHQ8OAWA7Ml22M9jFum8zITgvfqDHOLeGXfv95hLDvwPKNQ2OUAD/o+zTLBnY2oiUXiP+vvciYt6idBVAlshX8RWn5eSsX8jxTl71L+FvD4DxMkhJornJ2ctLHxnREZ+BvK8yCrjFEY4MaKbV8C8+bXF0SG8qciaVzEXK3ijlyNathwGxJ0EctpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqViHiazYTl5UMPMBpkL2jSDExyInKGSijeFtNLzzTw=;
 b=PHqXnnlM5YISBf29P8OOqSnLY+TwCG/K3Nfe6Oa2yzv7IK7k71BcoYGK70Pf2iYMSMvXO7OE7pl40e3eA/mrmCiea6BWazRq23NIbWQEyoeDwVXt8JAYu8C8BCPcECMPRlawG6DbhIHg5kehaPE6C+Iu/QakqBR9MLTVcicZQYDQXLducJnUDx4fXFETWP2ia9xjifdlhZdjZ8nfYgWvjXsQ8fnF5xQRI9uTrH+t7lSjHBMGYMfYv48F3Q6muHJgBy+TrZM1YZbwveDqkQffvA2YZYmUW79DjiFgRZeAB88W284+LDQgkxGQqM5L3AElZSlIqgEK+KM9YF+jafQQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqViHiazYTl5UMPMBpkL2jSDExyInKGSijeFtNLzzTw=;
 b=rk/fSGxt0dxTRa7zgo3vDc6ZiTTtcDjDvoagyqjPW8rIkAHxJQv1vTm4nnCpflZw1a4aQD+qKAJ0GNDVEyhZ5thquITf6KgEslxYeb7IexcjM2yf3wt/IcVS2aKKWiU6UNhpUERO7DBfqHtu49hf74oCgPrMCLjXKncs8A6Hvb+iS7pgI0anhnJkO3rObcRPmz7isGzxy4oPGhcJWc/MdZHucZ4FORUTWnmG2TtgrTYUM0Tqy09kCgC/bWrhp+MBmrNGJuqArRmXo+bFTQKyYQamJMzaLl5umpf75XGu5vA8KCNqwxytxwPbbvKh0oGNC06dntVDG3mAGz7uPMgUWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 10:12:23 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 10:12:22 +0000
Message-ID: <cfd8f7f8-4d9c-4373-a127-1f07a3d6e26e@nvidia.com>
Date: Mon, 19 Feb 2024 12:12:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 7/8] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-8-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240212135643.5858-8-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::22) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: d67e8308-472b-4735-7f00-08dc3133438a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXdZoJm/a64Zd1mtFiYjqTGeKr48yU9jD0vmaoq4Ch7rD7XuUtGDXdffc1dvhQO8cRU6/7i0lPLNaJdcbbnvNptZMeviuo68L9bmG4cZk0Cnn3HazUbymcUiH4NhQxOx+Fjl7sNakdhow2hiag9mg22pJbM6oZi9bg5H+BzHk01OLW3DE4rB49ltmjfp3I4Kx222KGmJlyAld5X3G7wdJprsi/jUFjVv4gtT2ZsvV6yVhMYD7GxMs8dfNzifS9V6VknqBu/RjooRutp7HaG1l8vFa2N+GfjfJ1PJmQthOZEWFzQ8JgGeBkug5f3eUZAXG/u1sB4rbR3ZPKcpWhY7oodDWifCtfye8udIztNc9qAbtTGhBl24YPJiBVW+c5Fi34IF71guPhN9EADP/UosVnQp+zrU6nThlpx2XbPxzoO/PAFSr0KZrsCVK+kMPniPZB3EsmP1c3VQXBy+HJfSLO29tF4lYqCyfOEFNOMzzF6bD+y8Bf5LbUmMJIC3dU5l2y1kkljgh00RftgZtyAQHCrsQxKV9mWKeJh9FkpdrHwR/ehc0AxyzXty7W1LSM/J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(316002)(54906003)(41300700001)(6666004)(2906002)(7416002)(66476007)(66556008)(66946007)(5660300002)(4326008)(8676002)(8936002)(83380400001)(86362001)(31696002)(6486002)(478600001)(6512007)(26005)(53546011)(36756003)(6506007)(38100700002)(107886003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkc4NzJTdG8yRjVaSzZlMWdIeUZydEdXMFNxTE1pK3FqRGxET2dYYWd2VzJV?=
 =?utf-8?B?RDhTMDFGeUI3bE9LZzh4cWV3Mko5MlhRb09ZVERKSVk3NjNrb041Y2ZudTl3?=
 =?utf-8?B?b216N053amE5bDhOZ25qVUZEcGZvbG5HSnRleHllbmRoZG45eVZteXNPUUdU?=
 =?utf-8?B?cWpna2l5Vms1K1hUdC96OVRRMUU0ekYzNklOaDVqYjZielMrYjhpVnBjN1pD?=
 =?utf-8?B?TXVrNkFQNytwV3ZPaE9wSElvNWJzZjBCeEFCa1hZVjlBRk5zdG42aXlQcWk1?=
 =?utf-8?B?dFU4NXVCcWhLcFp3SGduNVY4WnMxWkticTRsK0U1dStDaHU2MFh3NkVOd2M5?=
 =?utf-8?B?M3JOOXVNd0JOcFRSc0lOdUtINW1KMkxtZVRNSzA2Y2g0a25ycFFIVG9RZ1hj?=
 =?utf-8?B?Y2h1ODNBUDViYmp3TUxjS1R3YUdmVkhPcnlySjlKdG41ZGxYaCtQTUh1WnE2?=
 =?utf-8?B?MjFNVG9pT1l2TllpaWVSSWxqNWpPbEtWc0YvYnpNTkZSakhjU09jWTJPRUtT?=
 =?utf-8?B?VkkxTms2QTJHdEtTK0w4cjZNcjNBQTJTaUZMZWVTRGVGdW0rdjl5K0VTZE02?=
 =?utf-8?B?NG41VUlHSHljRXJ1VDRHT0UxT0gyRlRvOUxyeGZyMmNhZlRXMlhsMExmY0xT?=
 =?utf-8?B?L1hXZnZtb1pIR1pkN0xZdVA0KzNVdzVkK2VkZzZxSkZ4L3kxalVWMjNpVHdm?=
 =?utf-8?B?cWZWSUJlUjVVczhNVEZYOHdZOEVyZjMvT0ptaGJFR2o3SVlRVFZxc054U2tT?=
 =?utf-8?B?RmUydEJXTmk2emtxTXhkSkR3Rzg4WDdlcEtBS2ZGQjA2T0ZwNHdsZGpoT2o5?=
 =?utf-8?B?T0N0bXFMSGlzaUlRZkVqbzlZVmJtWS9nemswd0pNVVFITzZOOVR3N0tYTzRJ?=
 =?utf-8?B?SzczUVljb3JYQURYd1M5N0ZUNThBMHRkeXlldXFZcVdBVVpGMlFiV2RNM05u?=
 =?utf-8?B?MWxjZVpUOGUvQUJoQjdGVCtkWlF3d3kxWGVXUHlkYkFlTWxwWjlJUHdXT25O?=
 =?utf-8?B?cXlGU1ZwcW9pN2JHUG9ESlV4MnNHSTQvY21GazBQTHZ0N1NSLzh3WFRybkJq?=
 =?utf-8?B?dVhycXE3WHBVbndaYk5oKzUxbmQyamo0Yms2M2RCcnV3alRiYmEyYzkwYzE3?=
 =?utf-8?B?QWdIdmF1biszQUJhUXZ3TGVaV1Q5L3ovZUpJWjBOYWlhR1ZCckd3aFhUdGdW?=
 =?utf-8?B?L3VpTjJpWnBRRUxSVi8xcFZiV3Z0YVJBOFJTek9CczBFUXIxOC9DUG82eFha?=
 =?utf-8?B?SExJVWZFbDI1OFNxcndPTC9oSUNRc0F2dDU5V3U0eVVjeXR6bENOeWhCekNi?=
 =?utf-8?B?TmphTVFnczNhU3Q5WDREUTk4TkJhWHE5ZmhUK1ZkdFVqdEpXQ1plUVlhL1ZO?=
 =?utf-8?B?UjlYWEtpWmEwcjI1VEIvYU5kbkRHRmdJQTNtSlNtMTA0WFdrZVlpdEJ0YXMy?=
 =?utf-8?B?c0IxL1JERjZQbkFHMjlQM3RzdGpaaTcwZkRCZFZpOUlsa2t5NVRFMTlJWDlO?=
 =?utf-8?B?aWpzUnBzZFkvT1FxUVdjYVdnU3dNTXRRczFrWEFjUGlQbzQyM2ViTWFkYThJ?=
 =?utf-8?B?QkNEcG5neTVsSTJ4SnlkVmJLbG5jN0lldHVGVURGcmlSU2dHY1cxYXZvUGhN?=
 =?utf-8?B?ZnJoNHhYVWtLVDZkVEZiVWd4N3o5eE9nclhhMEpZTlBRVUVzZzlVNytTeDFS?=
 =?utf-8?B?L3Z6UnRuS01DTGIrNDZ0S05YUTlwN1JzT1lhOGlHNE5KSkZxN2Z6MjVBYmEv?=
 =?utf-8?B?UWcwMmExK1FaU2hVWG4rUGppL3pLNlVaWFV2ZGZLa29mQVJBUjdRYmFkRXJK?=
 =?utf-8?B?Q1VHdnpGMkRFOVpOTHArcUY2ZXk4dWFzRC96M1BNbkwycUoyYTFaV3FKaVdN?=
 =?utf-8?B?SzN0Zys4cWFndU1QRzY3dld4T3R1NjdaNHBqYXZPMGE1MFBZa3pCd0U1OUJz?=
 =?utf-8?B?YTErRUlWbHlXNnErRkdHM3MyVzZKYitHQzFyUWE1b3hid05hN3AvWDJWOVU4?=
 =?utf-8?B?bE1zSitlWm0rNkFtQnBBc3pydkhZcTVaT2tFd2NTb3JwTkh3c3MzSktUdVZF?=
 =?utf-8?B?S0tkWk12QkI2MWZ1TzMzRFdLcjBzZk9OWVRGOWMwUDBpY2ZtOEJnME1iT1NF?=
 =?utf-8?Q?Bl0sMHuICyttYxLgSm8QqlZ9l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67e8308-472b-4735-7f00-08dc3133438a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 10:12:22.7978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5Lq79LlxfUyrlhT2Lee6F8y0r8YLspFb/9mAEzl9RCUOPP54uDqEHuErO/zgkh1ROAHicDqv6tePXOhnnbnLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
Received-SPF: softfail client-ip=2a01:111:f403:2409::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi Joao,

On 12/02/2024 15:56, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> By default VFIO migration is set to auto, which will support live
> migration if the migration capability is set *and* also dirty page
> tracking is supported.
>
> For testing purposes one can force enable without dirty page tracking
> via enable-migration=on, but that option is generally left for testing
> purposes.
>
> So starting with IOMMU dirty tracking it can use to acomodate the lack of
> VF dirty page tracking allowing us to minimize the VF requirements for
> migration and thus enabling migration by default for those.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/iommufd.c        | 3 +--
>   hw/vfio/migration.c      | 4 +++-
>   include/sysemu/iommufd.h | 1 +
>   3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 697d40841d7f..78d8f4391b68 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -275,8 +275,7 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>       return ret;
>   }
>
> -static bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev,
> -                                          Error **errp)
> +bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev, Error **errp)
>   {
>       uint64_t caps;
>       int r;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 70e6b1a709f9..674e76b3f3df 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -938,7 +938,9 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>
> -    if (!vbasedev->dirty_pages_supported) {
> +    if (!vbasedev->dirty_pages_supported &&
> +        (vbasedev->iommufd_dev.iommufd &&

Shouldn't we check the type of base_hdev instead?

> +         !iommufd_dirty_pages_supported(&vbasedev->iommufd_dev, &err))) {

Maybe we can store IOMMUFD DPT support in iommufd_dev and use it instead 
of querying it here?

Thanks.

>           if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>               error_setg(&err,
>                          "%s: VFIO device doesn't support device dirty tracking",
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index bc6607e3d444..d6be49f2ac78 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -53,6 +53,7 @@ typedef struct IOMMUFDDevice {
>   void iommufd_device_init(IOMMUFDDevice *idev);
>   int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t *caps,
>                                          Error **errp);
> +bool iommufd_dirty_pages_supported(IOMMUFDDevice *idev, Error **errp);
>   int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>                                  uint32_t pt_id, uint32_t flags,
>                                  uint32_t data_type, uint32_t data_len,
> --
> 2.39.3
>

