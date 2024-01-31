Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6A2C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 09:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7Hg-00033C-DB; Wed, 31 Jan 2024 04:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rV7Hd-00032q-5w
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 04:53:29 -0500
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rV7HQ-0006K1-Et
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 04:53:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8aUAV6JjZkVJxaOUTk+x3iopMRdhH9arrF+Qvo/mTCJxVQ59wLqjDNwVaB3Hl5vx6vRHeMdLnHkEKI0FBlfeaYAX5vEf6tuyX2zlVCq5jiNBo9sSU7x7ZsEC2t+jHqgwXyDhHZydI7sxo8BZSWWdJHEAk/cd08IPbCsP09WUtE3mKOIpknnDeJZj5OS8D8L7DNdgU2U7uY9kAfRbGSi976V7Zhtxs40sO1oD2No1xZwNZQ1qorQ4cwzyBksJL5QfG50LOWIIJcEp5J9TTsWxZ7C/laOsoD1p/4znhAV0AhavYEYMB7y0AVOHh1A/QGcCugMejHWahwWNym+iv2OSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2KYHT2PPH51HkBiH1ic4pjfD+kykckFmeFJWoQAIyA=;
 b=J2W2o4et9fTYXaSldFXva3W9jVqymHV8Vk5feXBekLYOB+rAJUgFnLbqBUAR+hTgEj9RSGHyhSNMbtlQQQ3CbjT43bmowQKaFJrN2PWSyG7YleAYXGiquUdZ7vGm6V4XnNRIoGcZBitCoyIAVE0GPtsFTgRnvbQhV9nm++dnY9rpRxKc5ch3U4T7sibPdv3II8rpv6t77yhdvYreah3AwFI32k+zjNbS2GEsIc10xsc/ReFLAizMs+g4ObMMUE4aw6b42JeAJ19c5qChPftIWbyz42YvMe8pn5hK1Z+pfflIg3Fo4n+LwgLIXbUllS0bOx4JlZl43GKsUkDOTLNUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2KYHT2PPH51HkBiH1ic4pjfD+kykckFmeFJWoQAIyA=;
 b=O092MYaczU7en48A46W8S0OZ6uIEl2hOE9KPL8YOOpoawGxK5oY9osX7nb79cZb9LK544+BTj29lqPlv7bqdye5LZHKz3lTRTDUpkn++I7raErCPd1HBDc9oKOgEb0rV3rSfwellj3mRzkXD1hDb8kzr5twSUEM2bxuVgAUTiWsTXRphu3ooCxktd9armPL9G1tvIWaY3jP2lffhdxyTtkhPBXFvnWHMOJHi3hOOyqFU5jZ39I650Ap/+HUUpoHTLncgPlboUfUIxDGo62pn5V7plsM3zcY6s1i9hJkZwrKiJUBKYu/dscR1N37CTm272l4mVgDGml500I8VSBy7ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 09:53:09 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::882:18fc:98cd:f5e6]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::882:18fc:98cd:f5e6%6]) with mapi id 15.20.7228.035; Wed, 31 Jan 2024
 09:53:09 +0000
Message-ID: <f6586fc8-d64c-4ff0-80ac-1eb18b5f486b@nvidia.com>
Date: Wed, 31 Jan 2024 15:22:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, targupta@nvidia.com, cjia@nvidia.com,
 acurrid@nvidia.com, zhiw@nvidia.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com
References: <20240130095617.31661-1-vkale@nvidia.com>
 <4d6a45ed-ca8d-4e41-b536-c2502ff1ce8b@nvidia.com>
 <20240130115832.462e76b7.alex.williamson@redhat.com>
X-Nvconfidentiality: public
From: Vinayak Kale <vkale@nvidia.com>
In-Reply-To: <20240130115832.462e76b7.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::23) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 70afa6fe-0c9d-4b4d-dc43-08dc22426de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyZc6zN1NTUquBmVsz4Vb4317I7Vw2hwf6BYmLYU88gwyR+HunZvQtQJhEsZlBZPfWEbopfzJxTaW1TptpjJsFhjvvlHqk0OGrboOy+O6HlSU+6onD4KfI3+tDZ0aB1DyVXVAWE9xAh/bXd7KPHOJnSx81RVNLMk4lTWziWqWV960KImnq/ILS2l2Ted9wqNQlCN7rmaLD0hWrWMJgZFQW+QyYXv6431Xl3nqUR0+DKwJXhr/jjH0Cz0IdKRrziWWzA6Zn+L/YVWAcluXE50dTCIYOeMMezzAPq8ytWTlLNgq3GB4lCkj/DwqJjj0tfQlvQ4tsZjUVXbxZHdADtTdUjvUPmJITgib1AeL4GbuTs7qLtopxVsjJV/C5hQscJZvHn1AOUFOz0fhnsv0Z+VU9rLds5rl/c6Zd8ffIRtBE4aXeWPxKTLHuL7nnpnEyV1L0xIeozDeitoC98v0pYqI42lJRcxfcbI2vXcjjN8xPA+XqJ+AvHQ9yK+dATwCZ8tuVOzHeo1JNcSilFTJWOS1qvsjC99ewjBejlCQ3UBmIfryJPtA+urf523D9B5/vqY6pOffmEWC2xPQn9j//GBTj/G8TEi64Ryi/7oT6lJDvqVhklbg5MoXpzG8EvZeHHt0m3rmZS80z8jjF8uSERUJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(66899024)(4326008)(8676002)(2906002)(5660300002)(31696002)(8936002)(86362001)(66946007)(6916009)(316002)(36756003)(66476007)(38100700002)(66556008)(6506007)(53546011)(6512007)(478600001)(6486002)(6666004)(83380400001)(26005)(107886003)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZZdUhJRU1adm5KamtDRlA2SkkwbVdNQndOUHNLRzhFVHpCMVYvY1dmdVpw?=
 =?utf-8?B?Q2RHM2F2VUJRWm9sWXRta1ZYR290cWkzWWZPUEFSZXVqaWpNVTJXbWZZeEUy?=
 =?utf-8?B?b2VRZ1gyODE5N2txZEpRWjlwYlA4SVVDOFNsc001RHRaWFNnMDladmpHdUpr?=
 =?utf-8?B?L1lVN0k0SWhnWDdPTEtuZGpjbXlCQnJ4b0tSYko2V0NEbXZUeDBTcjA4dnBs?=
 =?utf-8?B?MUJvMlFsT0g1Z0p0STIvZFdQV0Zjc1RYM1JYMlNaRjBMWEJQWXBEd0Y4a2Nj?=
 =?utf-8?B?MWJtbU1aUXZhcFlLVitsNWViWjVWNDNUQ2NMSDZVaGRvOG5mcEN6d3pVU1BC?=
 =?utf-8?B?YXN6QU1aY25WYmQyMHVUellscUEva3NXdC9qRTBUNlFScVQ3bHJBV2x1akFK?=
 =?utf-8?B?UENFMXlQYWR6K256MEczb2hwSURTWmRYeTZZSHllODB1czI0d3YzNXk3ejNV?=
 =?utf-8?B?U2RsOHdlNGNVUUE5N21mcVpmazgrK0dEVzA2aE5SWFA2dnorRmgzM1lHeHdz?=
 =?utf-8?B?dURUdXRUM0lwdTVPaTZHNnRIQS9vZXVJRGo5K0paekI2STJYVE96NmN3VndT?=
 =?utf-8?B?bEJTQmhQY2psUWJvd09jRHBFcUxDWWdXb1J2R2pCNHkxelhlYlg4WVVQUlhp?=
 =?utf-8?B?blZuVXQ4NEt2dU9qWWo5bWRjT0NqczNxODAxbkpuWnFYdTQzbjhhVzJIdzd6?=
 =?utf-8?B?UlowRnMrMDNZMi8xQ05DSE1jaVVyR2lqMDEwQ1dZRXluWmozdVI3Sm5xUlpm?=
 =?utf-8?B?UFFjYnJjMzRQWFJ4dVNJNDloSGNGQi82Y0srREFLbWFkSytPNlN6bnZHcFhv?=
 =?utf-8?B?YURtOTlCamkzUTkyaVZ3MGRtTTdNSGtDZzRUMmR6QkZBeTU2TkR5QUVzSXpH?=
 =?utf-8?B?TUl5K2ZLNDMzNXV4S0RzQUplR1dSakZUZ1BrRnFsbWxjdUhHb1ZyVkI2S3NE?=
 =?utf-8?B?UDJ0WEUrVHh4YW5jdGlhTlp4NmsxNDJBYVlHL2ZXOXNBRTFpZ1J6bldkQW94?=
 =?utf-8?B?QVc2aUpsbW9pcUJodVBrUmovYXc1dDVhK0Mwb1M3VkVURkhYT2dRZTJkYXVG?=
 =?utf-8?B?S3BpVW55UHVzRldRSnIwTXYxdHhvWFJCS2UvNXpYUFloRG9ibkZGRWVhdFhT?=
 =?utf-8?B?V2lCRjRqK0N2RVVURlQzNU1lR0MxbnBRa1NJR2lZcG5uTElKVDU1RDhyR1Bi?=
 =?utf-8?B?TTBzRnpDMno5TWlKd281a2Rsb0ZLM1NVMlE3SzE4Qnk4dDZJOGdCL0J4UWMx?=
 =?utf-8?B?dHBHeG9PaVVkVGVwU1o5dHQ1aW40NXRFVVVwVG82aFQ2VDN1dWhlRWNSaVhZ?=
 =?utf-8?B?THdHbEZORjl3NW9CVEV4R3o3d1pFUm1jc1VLRzJrNGQ1UkRuSVc1MGpjK3Ja?=
 =?utf-8?B?UUFxQUFxaXlwc21ES296SWszQURYTm1ZK29aaFdaMjBXLzdmQ3ZPVWJDU3h0?=
 =?utf-8?B?QXVqR3VaWHJLdXNjdUV4dVA3RW00Y2dpbFBxdk9pL2pqenVEVGtkVEZ6RDYy?=
 =?utf-8?B?eXFmcGJxeUYzMHFYeVVTOWhTcC9GSkgzcW50cERwNXNsSW1wMllad045MGVp?=
 =?utf-8?B?MVRsVERsaXpFc0J2Q2F2UFlIY3c3ZzNZTnRaWHNFendEL0xnN3R3U3J6OE1D?=
 =?utf-8?B?bGF2NW83aUZWaEljU216ZVpkZyt3bTRMZS90aERTTnRHNHNRclRFbG9xMHlZ?=
 =?utf-8?B?dnZvQ25WcFBtQVlVR3I0RnNSNUF4RGhrQ0tpNHZGM2taZVYvS2xpS3JGNlFn?=
 =?utf-8?B?QWVveUdudU5xRGMvZmlJOFp4Uk9XbzZ3NXZ0aEJxRjZpSzgraFpDcGNIbEY1?=
 =?utf-8?B?b0NrNWFWV1l6SWl0Nzc1L3p0RVJ6L2s4dTNMK2orZko4LzJnelFHM3BuMXR6?=
 =?utf-8?B?VGE1Ri9QaW51TDAremQ1ejM0YmF1VzNMUjhzOVBrdElESDV1c01lMjAwb1hq?=
 =?utf-8?B?V1BtbGVvT3c5cnE5SVh5RWQ1T211czlUY3I0WUZ3OEIwWmZIbXA0NkhaQkk3?=
 =?utf-8?B?Ulg4VXpVYmo5UVRZZTBna2czaytKMWVpaXY0a0NjaFA4WHlZVmtyVnNXNldS?=
 =?utf-8?B?dmgzZnRHbjJZcS9OWThuTk9ka2JLVzJXSEFSVU51Z0VVelZwck5BZTNJTjBh?=
 =?utf-8?Q?2D8IH598OCXqel/vXOBI9RSLf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70afa6fe-0c9d-4b4d-dc43-08dc22426de2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:53:08.9966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+yQQA3ElrhIdUriFmor1/vMaTSp5u/O53nLBTfayeavJPcEV0Vg2PVaTsNWUIGM4KSgbdcgdgR6NLEsFeHJzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=vkale@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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



On 31/01/24 12:28 am, Alex Williamson wrote:
> 
> On Tue, 30 Jan 2024 23:32:26 +0530
> Vinayak Kale <vkale@nvidia.com> wrote:
> 
>> Missed adding Michael, Marcel, Alex and Avihai earlier, apologies.
>>
>> Regards,
>> Vinayak
>>
>> On 30/01/24 3:26 pm, Vinayak Kale wrote:
>>> In case of migration, during restore operation, qemu checks the config space of the pci device with the config space
>>> in the migration stream captured during save operation. In case of config space data mismatch, restore operation is failed.
>>>
>>> config space check is done in function get_pci_config_device(). By default VSC (vendor-specific-capability) in config space is checked.
>>>
>>> Ideally qemu should not check VSC during restore/load. This patch skips the check by not setting pdev->cmask[] for VSC offsets in pci_add_capability().
>>> If cmask[] is not set for an offset, then qemu skips config space check for that offset.
>>>
>>> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
>>> ---
>>>    hw/pci/pci.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 76080af580..32429109df 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>>>        memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size, 4));
>>>        /* Make capability read-only by default */
>>>        memset(pdev->wmask + offset, 0, size);
>>> -    /* Check capability by default */
>>> -    memset(pdev->cmask + offset, 0xFF, size);
>>> +
>>> +    if (cap_id != PCI_CAP_ID_VNDR) {
>>> +        /* Check non-vendor specific capability by default */
>>> +        memset(pdev->cmask + offset, 0xFF, size);
>>> +    }
>>>        return offset;
>>>    }
>>>
>>
> 
> If there is a possibility that the data within the vendor specific cap
> can be consumed by the driver or diagnostic tools, then it's part of
> the device ABI and should be consistent across migration.  A mismatch
> can certainly cause a migration failure, but why shouldn't it?

Sure, the device ABI should be consistent across migration. In case of 
VSC, it should represent same format on source and destination. But 
shouldn't VSC content check or its interpretation be left to vendor 
driver instead of qemu?

> 
> This might be arguably ok (with more details) for a specific device,
> but I don't think it can be the default given the arbitrary data
> vendors can expose here.  Also, if this one, why not also the vendor
> specific extended capability?  Thanks,

I'll cover VSEC in next version of the patch.

> 
> Alex
> 

