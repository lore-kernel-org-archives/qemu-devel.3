Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993B0C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 09:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbzZP-0006lo-Bu; Mon, 19 Feb 2024 04:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rbzZL-0006jo-Js
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:04:11 -0500
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rbzZJ-0008BY-C7
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:04:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGdfowZsFPjx5sQ6gmdMt8+oZxdWjdn/+msErJS8oVUx7F0b6x+cTQPqBEwrUV2UfnttXcy6whmZ69KH4n5kkynEFgmo4MUC0mtlG98XlB9hYNRxW54yLFwT0l07y8JdBx19U2rYhlqVuovQ+6LXgrZSeOySkfZqvSIc3HCl7TKAyemqx30NOIa77i+DYnSbFmbw8GKOl0EkxHG3Rn1D60PWVP2bR4dwvSK9P8EY9U31B+kyIcjzkEwIvRkJHQnHaQgLu2PeEjGzK2WdVIBE3KBssIat2HrrIV2fsLLYU+t9guD54Aa+IHmvatS7808f7n9g3QcWOv0cvrcCAeRJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY3A+gu6XKAMJMePXvUILr8hYEiN53/e8bzUk7pHrks=;
 b=NYHfLHHOl8uu2LqMNyhUP2bt9M48WXgnFsHy8S67VqzS5OczeUnrYG+b9QM55y/owwKhejZG6Jf9jJhMHVXC2EZUCevSlOLR8QH52/ndhyYJ7feV7ijJo+eMw/JO4ys/5YiHsIARhyU4igs4wPX0cSlnsuO9XvdejbOpTqECQ8C/bxAJ4/IC4Fkv2K5FqmH4L4MKLpE2C56Bu4Qfk1fhM92lrJw11wDclWmVYhf+D8oTxHi/TgEP9JXlmMhrjFtscYxtxnKuWVOirEJtb9cCwMFaZeSnc9N1wbQcJQl/x7GcX2oQT+l/pTE/0D/0mOZjKCO1jBeGmgpM4IoCrJSkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY3A+gu6XKAMJMePXvUILr8hYEiN53/e8bzUk7pHrks=;
 b=bMX6CaIG5ne9EoRWiwLP3c8UyOI9mvnEjzC8ZY2aCvpJYVEB8YF3FYeSZLsGQj+Q3yq7G4XenKHYPhLbAZFLnCLFrRrkXfWJr+lbAzsvAxyl9tF/HYg8t02aijEFlv421MlJ96lAFgM5jd57+N+5POL/+ixkEH57KiJBO3g2llktjB45CRuARP78TbYUi/91myyy6HHL4HBCGI1RwmQ5jW0e2nYKm36YPPFdmboDmFM8Fia/OcO0o01VtYvHZUHopdTKMz8gdKpyc8RpJr9hS8s9Vs2DRoUhjRWh+hqV9aW2aBCf8ewtb+iSyTmPtLKiFSb3X3jBwrdT1p4r07ob/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 09:04:04 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 09:04:04 +0000
Message-ID: <341dc4a0-cf9c-4b4f-a520-b47f24ea8e12@nvidia.com>
Date: Mon, 19 Feb 2024 11:03:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 3/8] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
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
 <20240212135643.5858-4-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240212135643.5858-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: ceea9a12-6961-4489-9692-08dc3129b878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/bCgnW0zLvfYvmWYIUGfz0Uqh+cBXAFtlyn4kP30mSRGfpEvIyVYsKTVCtMilBynyd2wzkvlR2pyOu9700ODFvbH8GsOknRZpFTb9jCTR+E9XkGedCEncxTQDd2NpryMST/7aSANu6QuriwArOdzjzxZzoSF3Zw4IK+8dflVsq/fmFxG2ty9KTcdQiF7eQWVnH68ONph4XKlsDZ2kn3BUPKELeEEuQgxe3ovVz2IcE1tXzyFEZaq0W7qN8FSsQHVZyibr0WuubK2A07DeGjsgAvQITMqZwWZtrFCe7p9YWHwBu0hQGBT9Ttu3d2NuW4DewxkzdCeyO3oRw2FD2XfnLELHEP79prGM/LteG8MzwiF64cgYN0CmLLvkMcPFXOsj4EMUcmUg4gvGpv/cREN1Ltgk9MMckyeZr9hm/Qai3p6nFCDVq6CcyU5swoEC3XuJLgw8VelQZaq82vNrZhGW+3UP1KqYwxp1FLNMQae+Un6S//eIpWtqhgeTHQCr8W9BFmgL4s8XhhtNKJs6JqSwpFD6NK7M8wEDyd0VF8cGCFjNOZiyuttAf11cvcKl5E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(316002)(54906003)(41300700001)(6666004)(2906002)(7416002)(66476007)(66556008)(66946007)(5660300002)(4326008)(8676002)(8936002)(83380400001)(86362001)(31696002)(6486002)(478600001)(6512007)(53546011)(6506007)(36756003)(26005)(38100700002)(107886003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW5PUHlDRkxWSWZ0ZktmTmU0Q016Yk9IbExWUVFYanpkNlRrcVl5YzEzV1lL?=
 =?utf-8?B?cmw4RVdWWTkzQmFXaEVHT2hodVY1WkhJeUFUdDh1TFdqOExtSW84Q2ZmaHNu?=
 =?utf-8?B?SWs4K2pLYzhRVFNYNVlvNk1zWTNKS1I1T0ZTYm9HeG9rMlRGanlPUG83UWYx?=
 =?utf-8?B?bzJVRDRhd3NuT0Q3eHdqSzVwMFFKYWkydUhEN1dNMVdUajYrZlRaUFJhM3BY?=
 =?utf-8?B?SlhJRlB4OGJBbUJadnZmcS91Z081L3RpZFk5aytBR1UycGNIOFk4RGVUbCtU?=
 =?utf-8?B?bzhvUFBuanBIaU1kT09wdVR1b0FrUk1mUGFYN1dzYk5XNEZxTkRpNDVkdGlq?=
 =?utf-8?B?WWRmSWM1K0pCYTFJTGE2ZFhFcU95b3o5cUFuSmpsOUxEV2Y1TFNCdlU5VTlo?=
 =?utf-8?B?cXUrNWxmQlV5UGgycGdKTEN3aWEwUDZtb3ExQ2ZuSndaaUk5T0x2V05ncmow?=
 =?utf-8?B?YW9aMGxEb0pCeUp2OEhxRWFrRDNCbGx3RHp4VVhFNjMzcnRwL2NOVlVCdUFY?=
 =?utf-8?B?L3NhcWd5SWZzSU42cDB4RW1GZWthWDdCaXMwNFJVNU9JOXNTMFJOcmZnUWFa?=
 =?utf-8?B?N1RyaVdxOTJQVkl2UlArUEZTeVhvRDR4eVJyejhSd3Z3UXZvcE9qUjVoOXdQ?=
 =?utf-8?B?TUc3SlZwSVhXNUpqaTlhbStzakVmeW0zMWFCMlZVd1BxanNQWVB4ZXVMTVRx?=
 =?utf-8?B?cFhYUHEzdFNnS3RlOWcxRmQvQk5iN0NmQzdBQW1ETVkzY1Jla2NRbmlaUjFU?=
 =?utf-8?B?YnpqYnY3cHdWY3FlZjl1cEp5aWhqSUtUZjYxRG1LOCsvcCt6MFNGNE9XR2ww?=
 =?utf-8?B?WTdaa283bksrVDZpTUY4Y0dNbXdVUUkwNmdzWGIzNFhKTkNEbHJsNnJGTTRY?=
 =?utf-8?B?S1MzUlcrMExXNEZuVW9RTmZOUEZDU3lhbmQ1ZWFQQzl6WkVDY3BJS0lLcEFy?=
 =?utf-8?B?YUdFbEdNQlc0bmtxdVlIVGxiSXlxcDlkWExxb25aYkJ3RjhWZGhsclpiT3I5?=
 =?utf-8?B?M3FjbjFTMENCMll5R3Q3bmxNL0YyZ21leENLT0pSWXRVZDdGZFVTcUE0UWUr?=
 =?utf-8?B?QVE0QXc2bm9aQzhpY1JxREdISldDcWxacE16OEZZZ3I5SHRJSm5kNGVUZWxT?=
 =?utf-8?B?Y2tFZFQ1UWFEWlNKTHA0MkNqdmUxOTE3eEdoWmQ0ci9jSjFTeVVZUkIwbkxU?=
 =?utf-8?B?bWZBNU1rMFJxQ2dlZy9HenY3WEVNN2NsRFdrQU9lNlliQ2kzYlU2N05tMjVY?=
 =?utf-8?B?WXlTTytZNjNnektEbmFoaVE5NEZGZFlwWEVnWVJ3aGw5WEdodmgxVU03ZlVN?=
 =?utf-8?B?QzdrVmJmOUxGV08vRERZTnZuRzFpZjZOMlYvTUhudnRld0hGSG1objBmaUUy?=
 =?utf-8?B?NHFURDMzWUwvMENqclBIRnR2c1k1K240RWtZRFpFVjRETDV2c0JZOUxUMlVM?=
 =?utf-8?B?ZGoyeHhWc2ZlbEo3aXMvTzJ5WlVNVXh6WnllclpMd0N3bGRvaHdEUHc1Qjcv?=
 =?utf-8?B?bjl6eW5MTmoyWG9iY0p4NHl0dGpUdXVHcHB3dVppTENsazIxMUh5ZDBPTndD?=
 =?utf-8?B?RU9jNjI4UzFuOUNXQ21iN0puMWJxaVFrdHNBRllId1UyTjA1OUNSWWNWSDVj?=
 =?utf-8?B?KzJ3dXV6Nms2SlczeFZTOGFBRDJ4a2hZdnd2WmNwUUk4cUJCVjJRL0NkeXNG?=
 =?utf-8?B?c2lHazUvZnZnT00rVHBlWm11aHVRVnpROGxHamlIK0h6YkZTSjEwSWZENWpq?=
 =?utf-8?B?UDdvZDBWM0dlaWhzeWtGN2VIVFFoYXh5RHdETGV6UmZLUUZaaVU5Mzh5T3Ft?=
 =?utf-8?B?dzNaNkhCcVFkWEhYbW45eHNNYzlJSlowS1lVS0U5NnpOOHE4VS9XMFNmSWFX?=
 =?utf-8?B?Tk1uWlovUlY2Mmw3dHcvNzJsbjhZdWM0SXFzNkxLQ3RmTE5rb0RCTStNSE9h?=
 =?utf-8?B?TWZQM0krL05Tci95TnZpbFdISHlsb0wzTXBiYktxODE1b0lkaEp3dGxhZmNV?=
 =?utf-8?B?UDlwSGQwRUZtdm1aL0NMMFZ5UGZMSE5FTUF3TndieFduZ1RscnAwZnNSaUVY?=
 =?utf-8?B?dkJrcEpBU012Qmg4UWo0bDBLTlpEUFNEekJkeWhVOG04Wkoyc1FjekhmTGZj?=
 =?utf-8?Q?n09bC1ht2gmbDYKqmu/UTMu5M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceea9a12-6961-4489-9692-08dc3129b878
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 09:04:04.0152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 371soYUGT9yEuRassL0mqp5ykQ7fE61VvaSZvdWbeoGivtscUTra9axs00yFILyoE4Ns7t5VuifZYs6a4lrE+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
Received-SPF: softfail client-ip=2a01:111:f403:2415::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
> Probe hardware dirty tracking support by querying device hw capabilities
> via IOMMUFD_GET_HW_INFO.
>
> In preparation to using the dirty tracking UAPI, request dirty tracking in
> the HWPT flags when the device doesn't support dirty page tracking or has
> it disabled; or when support when the VF backing IOMMU supports dirty
> tracking. The latter is in the possibility of a device being attached
> that doesn't have a dirty tracker.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/common.c              | 18 ++++++++++++++++++
>   hw/vfio/iommufd.c             | 25 ++++++++++++++++++++++++-
>   include/hw/vfio/vfio-common.h |  2 ++
>   3 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f7f85160be88..d8fc7077f839 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -216,6 +216,24 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>       return true;
>   }
>
> +bool vfio_device_migration_supported(VFIODevice *vbasedev)
> +{
> +    if (!vbasedev->migration) {
> +        return false;
> +    }
> +
> +    return vbasedev->migration->mig_flags & VFIO_MIGRATION_STOP_COPY;

I think this is redundant, as (vbasedev->migration != NULL) implies 
(vbasedev->migration->mig_flags & VFIO_MIGRATION_STOP_COPY) == true.

> +}
> +
> +bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev)
> +{
> +    if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF) {
> +        return false;
> +    }
> +
> +    return !vbasedev->dirty_pages_supported;
> +}
> +
>   /*
>    * Check if all VFIO devices are running and migration is active, which is
>    * essentially equivalent to the migration being in pre-copy phase.
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index ca7ec45e725c..edacb6d72748 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -219,11 +219,26 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>       return ret;
>   }
>
> +static bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev,
> +                                          Error **errp)
> +{
> +    uint64_t caps;
> +    int r;
> +
> +    r = iommufd_device_get_hw_capabilities(iommufd_dev, &caps, errp);
> +    if (r) {
> +        return false;
> +    }
> +
> +    return caps & IOMMU_HW_CAP_DIRTY_TRACKING;

The false return value of this function is overloaded, it can indicate 
both error and lack of DPT support.
Should we fail iommufd_cdev_autodomains_get() if 
iommufd_dirty_pages_supported() fails?
Otherwise, errp argument of iommufd_dirty_pages_supported() is redundant 
and we can handle iommufd_device_get_hw_capabilities() error locally.

> +}
> +
>   static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>                                           VFIOIOMMUFDContainer *container,
>                                           Error **errp)
>   {
>       int iommufd = vbasedev->iommufd_dev.iommufd->fd;
> +    uint32_t flags = 0;
>       VFIOIOASHwpt *hwpt;
>       Error *err = NULL;
>       int ret = -EINVAL;
> @@ -245,9 +260,15 @@ static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           }
>       }
>
> +    if ((vfio_device_migration_supported(vbasedev) &&
> +         !vfio_device_dirty_pages_supported(vbasedev)) ||
> +        iommufd_dirty_pages_supported(&vbasedev->iommufd_dev, &err)) {

I think it's too early to check vfio_device_migration_supported() and 
vfio_device_dirty_pages_supported() here, as vfio_migration_init() 
hasn't been called yet so vbasedev->migration and 
vbasedev->dirty_pages_supported are not initialized.
Why do we need to check this? Can't we simply request IOMMUFD DPT if 
it's supported?

Thanks.

> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +    }
> +
>       ret = iommufd_backend_alloc_hwpt(iommufd,
>                                        vbasedev->iommufd_dev.devid,
> -                                     container->ioas_id, 0, 0, 0,
> +                                     container->ioas_id, flags, 0, 0,
>                                        NULL, &hwpt_id);
>       if (ret) {
>           error_append_hint(&err,
> @@ -271,6 +292,8 @@ static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       vbasedev->hwpt = hwpt;
>       QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>       QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    container->bcontainer.dirty_pages_supported =
> +                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>       return 0;
>   }
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 7f7d823221e2..a3e691c126c6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -271,6 +271,8 @@ bool
>   vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
>   bool
>   vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> +bool vfio_device_migration_supported(VFIODevice *vbasedev);
> +bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev);
>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                       VFIOBitmap *vbmap, hwaddr iova,
>                                       hwaddr size);
> --
> 2.39.3
>

