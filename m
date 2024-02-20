Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15105C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPan-0008PC-Vl; Tue, 20 Feb 2024 07:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rcPaj-0008Ou-GA
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:51:22 -0500
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com
 ([40.107.93.45] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rcPad-00028F-Pm
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:51:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHiRNPeaHLkZKrUjcgX4lYw25usMtDEbhZ48g+icfplVBXFEYmL3V/v0yb9nGiKifvBBNR269xli0Qo/xF5rMhFqzmonM4zgjcGXXSDvD3wkAa47eqDRjXckOgZNNxGD8CjdnyJFrgyghEGg91P+WcyxAhHNnAI5QHfdF9d04kj80Zr4UghxahAKzMMjfisOxNS3uWBTeTTT6jD//m/wIcQFF1P+lBlPDEQQE30KmP/WbwenA+YvCRZzcOrD137hlj5/avSWy032dykQMKqD6J82IULBN/LaDpfLc0bmGsS1IpBNzvspEBhtD6QODX3mu22BqOrYlRYgkgqI7Rf+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcEjjYNRUa75wjgeU5uL/jTJjDV9QQHgm/b6dvZE3IE=;
 b=HIDDkjk62GujmavNIfaxoIsRxVqvGN9dEuTSkTPuiiPvucixZ/CNc3js/DlWMYhT4KsxZ0IrukdNbWXwtjggjEsGAz/T04EEwGJvLWHaRJY3ZReRp49sz7ggSx36g0MugdC8FbLOM0XQv4MkJwV8lpbHkL34jJlQqquQNdpHwTLX2/jwP4Ihiemz8af5v1VKzunlSHYHEjaG0xbOBoZS72fjlAo9Qj35oeKydTT1dNrDy9MtE8fd3GWw/56Rk8zkdz7bMYE2uxr2XIUBOtc6duKiLrM0Nmsjru2Su//QQDoh9C17RAExIOfikkWH7fKlG9FYYlBcex7h7jRjklKiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcEjjYNRUa75wjgeU5uL/jTJjDV9QQHgm/b6dvZE3IE=;
 b=eTSp+s3SYGaZT2SVU0C3MlgTU0i1iVqa1OIA/sDe3Uh2ZxMNgJJcb5Tnq5jXmwa8w8DpvhXqoyt9T6oL7VKQK4NzYa7xq5v8eA76liNk+KfJUQlmz3/naJoXJKjgJ58zfNgM0Ebq8Y7PzCHZ3g12/2TEAaxH4eWxRS/OWVRoXY+bzZsIhmWHWyVtnEVKAHRHSkDgiyVsQTABMPGieNtZzEfk5tK8HEgfvlLyiIwEcwvgH2BtibcN4SamL/1v9oldslb47g53uPkyafGoS/n+dGu5/P/o8GSUGAihk9JMGXgME4vlSOPbQ8V8vMbCs/rnKzibhrUuBriACbzvHpVKhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 12:46:09 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::2bc1:5563:c496:8076]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::2bc1:5563:c496:8076%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 12:46:09 +0000
Message-ID: <e9a7bc7b-bc19-4a3a-92f2-7db9ee697baf@nvidia.com>
Date: Tue, 20 Feb 2024 14:46:00 +0200
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
 <341dc4a0-cf9c-4b4f-a520-b47f24ea8e12@nvidia.com>
 <95fe7e5c-cbe8-4c8a-b503-8b32df321941@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <95fe7e5c-cbe8-4c8a-b503-8b32df321941@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|BN9PR12MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 17dab550-38cc-4cf1-cef9-08dc3211e9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+3VD35wBxBLG0TRbtKJeBXMtxZ8GawpQP2dgijDwitzlj26C/vzUcFicqeAA5nITKGy1n2x5qq0L8FH6/fT9XGbJmE1FW57ZMua60Cl3KfudaI6nHb07K0Ybq3KvwBleCJpn8oT7Reh7SS//u4GZfYX8JTh5FM6of95OZXAd9twt3iqttnl9MN3b4CXickZg0vdKNmNYHpXhMtsJK+IZtyr2WOr2pDGHVccq5wHkJ0+qt76ol4WAnMTuOb/mXYpBOmjr9r51ISwSrDmf/pp7BdJWtaXJrt3gt6/ZKhuukPXmim+YWe1dpYEzk0j/xZNizny4BX3evVtlGUs8bQCkQaIg7SSyCr5CFDdEGwtQLEudzWOmkNO6gDOgiG5cPwrPhHYqMQIhL+dqSBoa+SJ3Z2Q3kApuIk4Ne9vGaWVaHn3fN/Swdn44ydIGFvwEXFM0s9YG1Wym0dcmCuV3uiDnCry7R1hQdKKSH+QK7smXTX+HHEY66rmdNbdUlDdtdRRC3++T2BS2QJaAh0/BMFn1Hg7GkVeaxBGSD/oN7eAG78PWDxFNbyKboeZtbQf7miW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WllXOGkzNmQyWmpmYk45dFBmdkh1ZnQybEJOSmYwdkRSdThGb2JPYzVwdHBX?=
 =?utf-8?B?eTNkV3JXeVFQeTNRbDNNMG52Qk5mWi9KUEZpek5PR0RueU0vSnR5YnN5N0V3?=
 =?utf-8?B?VVh3bUhzVDVuYkhxOWliYlB5by9FMHFic1orZVEyRS9RMXJDeWxZeXZiTzJM?=
 =?utf-8?B?UFVIOEdnQ1ZSeGJkSGlJWklmWnJmNTVseE9aSXA3clRBSzYrWWhMOWlsQWZo?=
 =?utf-8?B?RWg4Q3cwbzJKSGJzZlBadWdiWnhycXdaUzZHTEJJN0dOK0MvMnhSSzViaktV?=
 =?utf-8?B?VW83SlBUellJVmlGRlViY3Boeis0dUplMzk0OHVrY2hjNUpIeEtVV2J6WTg3?=
 =?utf-8?B?dFBvUG82OHp1SDRJdE0wdTYzTUdsR0xva0FDNlpDWmo3TkFKc1BLQ1I1N1A5?=
 =?utf-8?B?SkZwRHdOMlc1TlF2MTQybUQrdXJuZlhTQldBOGJkdlFJVDIxUVppdHVvZ3ht?=
 =?utf-8?B?Z2lYcHppUW5ZaEd2eHZBUUt5WjJmaUhzcUxobzd5Sm5uRCs3d1h3clA4VkRr?=
 =?utf-8?B?ZlV3TjlsL3o5SG5JTEVLOFkra0ZmV0ZMZXFJbHNySzFMcUYybTBVaW9obGxR?=
 =?utf-8?B?SXRRSHVXQXM1RUxqc2xjaWpSaUNaRTRCL2wwL0VkMGRyVmdQaTVCdEhXWjhH?=
 =?utf-8?B?YXZ4eHhyeW9NMG9LazVzUWFGTEt3alBhbTZKZWE5ampYdnF3MUxmTGJFQTFH?=
 =?utf-8?B?SVVBREJxdEQzNlZNTmJSZmlXQkJ3cWJJNmQ1ZFQxaE5JSHNlcHZFSjBhTUcz?=
 =?utf-8?B?KzdINzdYNVZnTnk3akZ5ckxaekFTdloxVmhpZXE5OExTNDZPZGFpTGZPT20v?=
 =?utf-8?B?QTArYmM1NXVQOEdiYVFTUHh0dEJ5a1c4T2cyOXRYOCtGUEtla1I2Y1o4RHVk?=
 =?utf-8?B?ZkNHaUVUSGw5LzhLODNZSklzUFBFTThRM1ZtZGY1VTdHdkoxK2dxM2c3NWFN?=
 =?utf-8?B?VHU5YXppaTZydWJTcVk3VGdQczhPK0hTRXlTSG82VkpnTmJKQlJwbG5iNHFV?=
 =?utf-8?B?U3pGaG44Ym5HeHJlQlYyeWZlMUd5SWZ2Q2FFWDZuVFpLVk0rcjdMUmVNcGIz?=
 =?utf-8?B?WWtRalpac0JtVVlSak5jaXVFbFRMNnNDVnI0TnJlTW5hQTFNZ3lJTkNqRDcz?=
 =?utf-8?B?cFUrNGd2NkQ3Tlp4UlhySFUvUkgvb3dSci9HWDF5OFFpYlhwbDA2YkxwYjB6?=
 =?utf-8?B?VXBaMEtBNS9DNnd5Tkd6OTQ0S080cEZLRGc4dS9jK3dHUnp1T2U5SzBtaG84?=
 =?utf-8?B?L01pLzNwT1ZOdzdsZzhiT1NvNkkvaHZVYXBKemtvb2laVnBkUlhqQ2lDdGxF?=
 =?utf-8?B?OEZvbTRwalp1d21lSlk1dWJpNnJ1ang5QTVGZThOWXhwQ0ZNRlZYY2dyd2Nl?=
 =?utf-8?B?Wlk0dndHTk9yYnJWRzFkRk1Cc2VOb1RJVFNuQUNTWDh1d01sTXRiTDhNN1lF?=
 =?utf-8?B?eERTZGVkSE83RkxRNnUwN24xSVg0L0xjUE5rU1diU3RJZExhQVpxS2d0bERE?=
 =?utf-8?B?TDJNYWtrdnFRWkh0UjRqNHpuUkJHeXBtTDJzNk5uSFZzR1QvaFJ2enNNSTV3?=
 =?utf-8?B?L3lrdDRGTC9UZ25LaU0xWGxmbk50K3dDRUE2ZUpBblB6MWF4Y0hvY1RhSEs1?=
 =?utf-8?B?c0ZCMWU1dGJ3NGpTMTlvRWpQS0FURStHbkwva2M1MlQvUXV6WlhJdytnd3FS?=
 =?utf-8?B?eUd2TzVFNjFUdjNRc1ZFRHdBNmhXSjBLWHg0TEtYWlk4NG1iem90RDdqUzlL?=
 =?utf-8?B?VWQ2Q2d0YUlWcStkeFhEaW1PRzM0SkxNTW9rZHB5b3BaL2N1MDFyTWRscWR2?=
 =?utf-8?B?WjB1eWkxWDlxZ1F2OGJkSk5vdmNHNFNIamMvbHQwelJWZ1dJMmVpT1BKTnRh?=
 =?utf-8?B?c0luWDZURk80RWFyM2dCa2VSb0tBQ01KZ2swdmwvQnRvUkF1THBVSko2bDBB?=
 =?utf-8?B?bHVEbi9MZDVHaXpDRXdEeC90dWc4Q3V3ekI5QUREQmw1R2Fkd2szR211bXRX?=
 =?utf-8?B?cWlDNCtVb3d3SDM3bkJ6ZWFEM0tKbHBsMUdBL1JkanV6WXJCZ242ZmRsREVL?=
 =?utf-8?B?bGpSbzdFVFRsZm9RQ2dDZEZRQ2xFa2szM0JPa0JZWEZHSWZCQUd1T0FrL3lj?=
 =?utf-8?Q?8ZQBA758OFf4jtzVZvLfY9EL/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dab550-38cc-4cf1-cef9-08dc3211e9b5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 12:46:09.7594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go9alVI56G1A/swMBW0/jAuLLKQ32IhghGL3T0DaG+oMiYYo9pPb5q9FGGb09fXmkOWFyKLHaCfhJs/AnDxJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
Received-SPF: softfail client-ip=40.107.93.45; envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


On 20/02/2024 12:51, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 19/02/2024 09:03, Avihai Horon wrote:
>> Hi Joao,
>>
>> On 12/02/2024 15:56, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Probe hardware dirty tracking support by querying device hw capabilities
>>> via IOMMUFD_GET_HW_INFO.
>>>
>>> In preparation to using the dirty tracking UAPI, request dirty tracking in
>>> the HWPT flags when the device doesn't support dirty page tracking or has
>>> it disabled; or when support when the VF backing IOMMU supports dirty
>>> tracking. The latter is in the possibility of a device being attached
>>> that doesn't have a dirty tracker.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>    hw/vfio/common.c              | 18 ++++++++++++++++++
>>>    hw/vfio/iommufd.c             | 25 ++++++++++++++++++++++++-
>>>    include/hw/vfio/vfio-common.h |  2 ++
>>>    3 files changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index f7f85160be88..d8fc7077f839 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -216,6 +216,24 @@ bool vfio_devices_all_device_dirty_tracking(const
>>> VFIOContainerBase *bcontainer)
>>>        return true;
>>>    }
>>>
>>> +bool vfio_device_migration_supported(VFIODevice *vbasedev)
>>> +{
>>> +    if (!vbasedev->migration) {
>>> +        return false;
>>> +    }
>>> +
>>> +    return vbasedev->migration->mig_flags & VFIO_MIGRATION_STOP_COPY;
>> I think this is redundant, as (vbasedev->migration != NULL) implies
>> (vbasedev->migration->mig_flags & VFIO_MIGRATION_STOP_COPY) == true.
>>
> The check was there to prevent a null-deref in case the device didn't support
> migration.

I meant that "vbasedev->migration->mig_flags & VFIO_MIGRATION_STOP_COPY" 
check is redundant because if vbasedev->migration != NULL then 
VFIO_MIGRATION_STOP_COPY is supported (it's already checked in 
vfio_migration_init()).

But never mind, given what you wrote below.

>
>>> +}
>>> +
>>> +bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev)
>>> +{
>>> +    if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF) {
>>> +        return false;
>>> +    }
>>> +
>>> +    return !vbasedev->dirty_pages_supported;
>>> +}
>>> +
>>>    /*
>>>     * Check if all VFIO devices are running and migration is active, which is
>>>     * essentially equivalent to the migration being in pre-copy phase.
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index ca7ec45e725c..edacb6d72748 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -219,11 +219,26 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice
>>> *vbasedev, Error **errp)
>>>        return ret;
>>>    }
>>>
>>> +static bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev,
>>> +                                          Error **errp)
>>> +{
>>> +    uint64_t caps;
>>> +    int r;
>>> +
>>> +    r = iommufd_device_get_hw_capabilities(iommufd_dev, &caps, errp);
>>> +    if (r) {
>>> +        return false;
>>> +    }
>>> +
>>> +    return caps & IOMMU_HW_CAP_DIRTY_TRACKING;
>> The false return value of this function is overloaded, it can indicate both
>> error and lack of DPT support.
>> Should we fail iommufd_cdev_autodomains_get() if iommufd_dirty_pages_supported()
>> fails?
> Definitely not.
>
>> Otherwise, errp argument of iommufd_dirty_pages_supported() is redundant and we
>> can handle iommufd_device_get_hw_capabilities() error locally.
>>
> I'll handle locally.
>
>>> +}
>>> +
>>>    static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>                                            VFIOIOMMUFDContainer *container,
>>>                                            Error **errp)
>>>    {
>>>        int iommufd = vbasedev->iommufd_dev.iommufd->fd;
>>> +    uint32_t flags = 0;
>>>        VFIOIOASHwpt *hwpt;
>>>        Error *err = NULL;
>>>        int ret = -EINVAL;
>>> @@ -245,9 +260,15 @@ static int iommufd_cdev_autodomains_get(VFIODevice
>>> *vbasedev,
>>>            }
>>>        }
>>>
>>> +    if ((vfio_device_migration_supported(vbasedev) &&
>>> +         !vfio_device_dirty_pages_supported(vbasedev)) ||
>>> +        iommufd_dirty_pages_supported(&vbasedev->iommufd_dev, &err)) {
>> I think it's too early to check vfio_device_migration_supported() and
>> vfio_device_dirty_pages_supported() here, as vfio_migration_init() hasn't been
>> called yet so vbasedev->migration and vbasedev->dirty_pages_supported are not
>> initialized.
> I should replace with its own vfio device probing but the next point invalidates
> this
>
>> Why do we need to check this? Can't we simply request IOMMUFD DPT if it's
>> supported?
>>
> There's no point in force requesting dpt in the domain if the device doesn't do
> migration that was my thinking here; but otoh as past hotplug bug fixes have
> shown it needs to proof against a new device getting add up that supports
> migration while and the unsupported one be removed. So I guess we might not have
> another option but to always ask for it if supported.
>
>> Thanks.
>>
>>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +    }
>>> +
>>>        ret = iommufd_backend_alloc_hwpt(iommufd,
>>>                                         vbasedev->iommufd_dev.devid,
>>> -                                     container->ioas_id, 0, 0, 0,
>>> +                                     container->ioas_id, flags, 0, 0,
>>>                                         NULL, &hwpt_id);
>>>        if (ret) {
>>>            error_append_hint(&err,
>>> @@ -271,6 +292,8 @@ static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>        vbasedev->hwpt = hwpt;
>>>        QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>        QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>> +    container->bcontainer.dirty_pages_supported =
>>> +                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>>>        return 0;
>>>    }
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 7f7d823221e2..a3e691c126c6 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -271,6 +271,8 @@ bool
>>>    vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
>>>    bool
>>>    vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>>> +bool vfio_device_migration_supported(VFIODevice *vbasedev);
>>> +bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev);
>>>    int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>                                        VFIOBitmap *vbmap, hwaddr iova,
>>>                                        hwaddr size);
>>> --
>>> 2.39.3
>>>

