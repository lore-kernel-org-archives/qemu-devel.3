Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4538AC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVb7D-0005wP-6V; Thu, 01 Feb 2024 12:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rVb77-0005vr-05
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:44:37 -0500
Received: from mail-sn1nam02on2046.outbound.protection.outlook.com
 ([40.107.96.46] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rVb6l-0004kI-0Z
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:44:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmi8okjit9odWQf3ot7PmqIYZlrTW1jEhE9bwMhlrcH1pRHehfY5NBJeqdWak2rfsap71qtEUKQVZgrrschxSoTeEcaXTde2+kxYR49hKWSbVfS44amY+13dgiBsZcMw+oJoECOxZTpIh/UmXjQV6pFx0KdgkJ0Z2kZHEQYmvIl3a1TM3JVymopnouAsN7u/3sIUIDysyneuSWzvnn/U21vsPldEV3+H4t1i+x5GUxNZXgUaG1yMfXXJZJjZ43VgwrLSPPYu4VhXDsbkrC79pWpCwEJlEPKEW76qsA+5SkiXJORn79ZjSnFmHXrmeg/AprzPVZzCuNfOciHDggD/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13+JFrQYFdMc5ftL4mJHE5NKNAY54HJpu/25AAIfJ2g=;
 b=aHiFpKBh8NdAuZCi5OC5kdDGrTVfW3CqQV9AYeMODt4xn0bc8uMHCqxFn9lBsueP1D+rxKhIjmBWcROUs0mYOk5uSE/NzH3LbNhDkM9KSrM0DcU3fSr7vwC0slQR4EIPHFtgwi2DTW5Y/50SKn6u0qg/k3advbIbShSjCRhIaW/lsv3UMmDRLeT8rUdAtomOuLUU0tyXHQcMZE/G+saNcgY/q2j1TzoKnGSz3gl/LMahJUwVGL41X4yZ/0W9ueIuV39orIi+Cu1EhSuTGBcbj6EFHkWQXu4lO7Aw+6MWoBW3fpnx71fQCMnNbZ+tDTiy5eWGmNS0v1uWNAkjiodykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13+JFrQYFdMc5ftL4mJHE5NKNAY54HJpu/25AAIfJ2g=;
 b=qyXo/0NXcDmTwKUhu/2Zfo9fTuDNBsI+Vkg1sHMxhDJVj6MmoZdZU57Ile6gW2GiHpcDLbM7/Tw5Hb/BL4duaTxEBblAZCdZr6uanXZ5+CHJlYo+l1amFlMMS20lwPBOyod3em4PH1ObIS4ct+S3n84urtZqhS5jk+DS1bYNTAnDRQnvup2TJxxSh8uIYCmtKuGA1Yf0bfU0UXcCNcDsNsEySPFgbWqv1XKw77BTQGvkfmIE+QiBPRGKSMXeC7zrfr+V15hiMFXnuXIxoTeZyigrzR7JdBoOGkn4nI0VjjpN/Q80nDJeCvYNgch5/wvDHqk/8CuM71MrZ1+hNYRjIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Thu, 1 Feb
 2024 17:39:08 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::882:18fc:98cd:f5e6]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::882:18fc:98cd:f5e6%6]) with mapi id 15.20.7270.009; Thu, 1 Feb 2024
 17:39:07 +0000
Message-ID: <b83a9452-cbcc-4f4d-b0f7-b4957029e755@nvidia.com>
Date: Thu, 1 Feb 2024 23:08:58 +0530
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
 <f6586fc8-d64c-4ff0-80ac-1eb18b5f486b@nvidia.com>
 <20240131103817.50389f39.alex.williamson@redhat.com>
X-Nvconfidentiality: public
From: Vinayak Kale <vkale@nvidia.com>
In-Reply-To: <20240131103817.50389f39.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::10) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 458f2931-1e7d-4a3f-3489-08dc234cb0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8AmY/gLl3rgTaReBtO5UViyitg4yhPT/ADRFKwWCedWv6N+lDFTJo7zhDNGYIAc8ep0RtecH56oGoLz7TbbL0EV9Qz/4h4rFV5Ax4xD8iv6BrltDu5FR8tPxZSlz0X8jOZ7tZ+BDur7FCBGmPanG2ua4nID7zZ7000dQ3b4h4njeSGqPcwYJWxdeTt8vmOxO2cOPItxNjQZLLqXZRNQ+lTgG/klVSsLkaxM4u9fyLIWn/P3UCgG+rPEP6Bh6sd2WPqoY2FCEugtG25XnuK9BiL/owejLFhIbN+v0OAwEgW4NoAcDzFyHQ1Ymy0a69eXRE1C6hPU5HI0ZfUzLWfF/9houMYGcSmxsz814TYNyk852eu7Sb2vHSg15rN7kzMDrTCMWNbxWdc0jRI5u37ABZo4SkvGi9VTkTC6rZXGfpPsNIdxcJfrT64oGc73r4UHW1ga4CxodGyMtbnf8salv614EuLFkdrj54IPgWdTskCCCb44LIvxIVEXeiWgfd9DwIQ7n4ovNwTbyr5XV/tLsRWv6qpBKtlkM7bc71lH/hMU4211b3l9YPlx4cRuWwZ5WAhik5UvOrRX+rShsFxm/bi9Es1b85FuhaWrpO4KZJzWXD4V60EOsaYVjqjy0FXR7Nlh7/Ukw6VT90TBFVVmnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66899024)(5660300002)(478600001)(66556008)(66476007)(2906002)(26005)(6486002)(6916009)(83380400001)(53546011)(6666004)(6506007)(8676002)(4326008)(316002)(8936002)(66946007)(107886003)(6512007)(2616005)(38100700002)(86362001)(31696002)(41300700001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUo1WWxLRUdtYUYyWDN5WUVIdDNTckk4blZ4QlB0RFVZenk1RGRsdS82VEdn?=
 =?utf-8?B?QmxRMWxWNG1hUkxnYlIxaE5ZZDlWZTdabXhoNldycHM0TEJnWXMyZWtQRGdh?=
 =?utf-8?B?U09wOHRpbnRhMFh1YndCbnY0TS92aVI2RHhaU0hGRnR6WDFFWS8va0hSSnhz?=
 =?utf-8?B?RndYUkRtSFo1amd6YUZ0UjlKbUdqYjY4NGJ0ZG1lblFBSjZXZWt5WG8zNmVP?=
 =?utf-8?B?OVJvVERnU3hWb3NaTVQyVzJTZFNZeFcrelVtOEFkZ3Vya2xySjJXRTJrNThh?=
 =?utf-8?B?eEpkVmVialFDbFVBWXltdzFVSDNTM0p0blNkWG9jOFRhSEltejZCQ05MTits?=
 =?utf-8?B?cTRNMmhxRHF1QWo0bnFYNVpBVTkrZ24rcmtuTTRqS0JzVHJreDFNNVY1Qnps?=
 =?utf-8?B?T3poR0lWMHliVndkWThWUjR6OGdoV2N4S2gvNlQ4NC9lK25PRGJjajFFZFJH?=
 =?utf-8?B?eXVyTmk1YUo1NVBxeFRLeStlZjJNWW02U21SOVhmellaK1N1bGUxbm95OTc1?=
 =?utf-8?B?elc3dTQvcFc1V29FMWZYSTc2MGc2TzUvVVFGbjNJSXVqalpia3o3Z1Qra1gy?=
 =?utf-8?B?b3VYcnBRSjZZenJkeXBDZ09qLzIzaXVleGZ6Y25xVmFka3hKTTY0ZStXdEly?=
 =?utf-8?B?M1M4dFNCRG9tTDYybWNuczl2Q1lVYjQ1alNhdkxJSG53ck9uNmdmYVpJQTAv?=
 =?utf-8?B?aXpkRUVoUGZsOXZ6TmZ0M2d3Y1ZnbkRETjN4d3UxSHJxQmxqSm5QSHRyeER6?=
 =?utf-8?B?SzVxNjcyWjl5RTBxRjVzTFhNK1h5azROOEM0RGxnTXoxOUo2alNpOFhXZnhY?=
 =?utf-8?B?SENxbG54MmlROVJRSVJWQ0swaitIdTFybElsWDFxelNKWk5RcGxHMk9xMUdL?=
 =?utf-8?B?U0M1THA4VUJhL2RlQnRaY1k1Qm9LbERkNmxtKzJGTldxcG1wVWxxbUVVOW03?=
 =?utf-8?B?aStoUkpIWGNQeFN6MTJXTFdKNUcrckpBM0FPUVdpbXNva2ZpUlVIaUd5SEk5?=
 =?utf-8?B?M215U09CZ2ZXWXlLK3hnVVRKd0U3QWZVTlkzeFZhVG5qa1RXajNyTVFJSVV6?=
 =?utf-8?B?TkxPT09pOUZDcVlROTYyVkJ6RFp5V0Nxcld3Z1RCRGVTVkRUNGMvOHh0dEI0?=
 =?utf-8?B?cWxsQ1ZvSlU4N2ZTeGRtTCtaMmtCcTJZTEpXK2FUVHNzeDllcUdrTm5aSHZx?=
 =?utf-8?B?TWVaemlxb3V0OW9OTGRBT3poZ1Y1aklHbTlvemF0UjFzQ0lWTmhjd3VmLzFC?=
 =?utf-8?B?QUxobXNaQVM4OWVITnZmWFQ2bGZaRkh4bVRXSkFwcTJxTlBnK1RDcEFCaFNF?=
 =?utf-8?B?ek5WeGVYZ3dNNnZRSlN3cFFzR0d3bGszdllkRWJYSG4rWnFTNmlKTFI4ZmdD?=
 =?utf-8?B?SHFrUXhub1FrZHhxU2plczlOTWxTVkN2aDlmWkxXc0RTazRrRkM3dkRKNFFM?=
 =?utf-8?B?VWNvSHBaQ2dQM2JFazBYRjhYRmtJVmRPdWNDdWZPUWozcTlqTDVYdVFhdUhB?=
 =?utf-8?B?V2NybVpvUW5wUWxqRjh3ZG1kQW5maWZjVE5uaTBxbGxCSGoyYmV2TldwUlRI?=
 =?utf-8?B?SlBQT0lZMUFobnRZbGZpRUhXMGFaUDJLWnNIUFp6MU96eFFUZTh5RjdVbHZK?=
 =?utf-8?B?bXRwdVZTV2lYQ1ZnL0Jvd1FzRWMyV2wrQUdwVkYxRlVBNEFrTkJiRHFGdHd1?=
 =?utf-8?B?T05FbmFjNG5URnI4UWNxZStuVzlYRTZad1kyYTV0dDBFeFh5T1dRb0dmeGp4?=
 =?utf-8?B?M2NjbFdMT08xVVQ1cDJQTkk0Y3E4UUFYcTRHeDVTeVIrYmlqQWIrK3ZSVDRG?=
 =?utf-8?B?Ujhjb3g4cmhYV21hdG1iQzNXcnk3eWxkMzZLYkpUcDkvbkEwRHhaY3lrMEJw?=
 =?utf-8?B?UG4xa2VITWZ0Wkk4RDJMZEZKUGh1WUtIMHJuZ1VjY1BUMFNwSDdWWHNJVjdD?=
 =?utf-8?B?ZjF0SXpta3J2UmRXcTBJbWNHWUJYVCtHQ3ZQbTEwWWR3bFJ1KzlENUZKT1NE?=
 =?utf-8?B?VEx4WVJ6T2RpZlZKZXZsUkxzRUpsbUk3S1dNWGZCUmlNeHJFMG1FRVZ5dUpC?=
 =?utf-8?B?Yk5Ybk9LWlFiQzBObWw0Z2FGWjJzZGdOTTR5SnJBZkphWmw0eXFkZUFuRTZE?=
 =?utf-8?Q?JqWmY27/P1mWd+Z29JBIQLVtH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458f2931-1e7d-4a3f-3489-08dc234cb0e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 17:39:07.5573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nY8P7+03B1NIDUkfsQiAZHhdO34Hk2BrmkoMCTSbz354xpoLdJm4/mTZlDFgOpx5LFR7A6lbOUH+mAkJhtACg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
Received-SPF: softfail client-ip=40.107.96.46; envelope-from=vkale@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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


On 31/01/24 11:08 pm, Alex Williamson wrote:
> 
> On Wed, 31 Jan 2024 15:22:59 +0530
> Vinayak Kale <vkale@nvidia.com> wrote:
> 
>> On 31/01/24 12:28 am, Alex Williamson wrote:
>>>
>>> On Tue, 30 Jan 2024 23:32:26 +0530
>>> Vinayak Kale <vkale@nvidia.com> wrote:
>>>
>>>> Missed adding Michael, Marcel, Alex and Avihai earlier, apologies.
>>>>
>>>> Regards,
>>>> Vinayak
>>>>
>>>> On 30/01/24 3:26 pm, Vinayak Kale wrote:
>>>>> In case of migration, during restore operation, qemu checks the config space of the pci device with the config space
>>>>> in the migration stream captured during save operation. In case of config space data mismatch, restore operation is failed.
>>>>>
>>>>> config space check is done in function get_pci_config_device(). By default VSC (vendor-specific-capability) in config space is checked.
>>>>>
>>>>> Ideally qemu should not check VSC during restore/load. This patch skips the check by not setting pdev->cmask[] for VSC offsets in pci_add_capability().
>>>>> If cmask[] is not set for an offset, then qemu skips config space check for that offset.
>>>>>
>>>>> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
>>>>> ---
>>>>>     hw/pci/pci.c | 7 +++++--
>>>>>     1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index 76080af580..32429109df 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>>>>>         memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size, 4));
>>>>>         /* Make capability read-only by default */
>>>>>         memset(pdev->wmask + offset, 0, size);
>>>>> -    /* Check capability by default */
>>>>> -    memset(pdev->cmask + offset, 0xFF, size);
>>>>> +
>>>>> +    if (cap_id != PCI_CAP_ID_VNDR) {
>>>>> +        /* Check non-vendor specific capability by default */
>>>>> +        memset(pdev->cmask + offset, 0xFF, size);
>>>>> +    }
>>>>>         return offset;
>>>>>     }
>>>>>
>>>>
>>>
>>> If there is a possibility that the data within the vendor specific cap
>>> can be consumed by the driver or diagnostic tools, then it's part of
>>> the device ABI and should be consistent across migration.  A mismatch
>>> can certainly cause a migration failure, but why shouldn't it?
>>
>> Sure, the device ABI should be consistent across migration. In case of
>> VSC, it should represent same format on source and destination. But
>> shouldn't VSC content check or its interpretation be left to vendor
>> driver instead of qemu?
> 
> By "vendor driver" here, are you suggesting that QEMU device models (ex.
> hw/net/{e1000*,igb*,rtl8139*}) should perform that validation?  If so,
> where's the patch that introduces any sort of validation hooks for
> vendors to provide?  Where is this validation going to happen in the
> case of a migratable vfio-pci variant devices?  Nothing about this
> patch suggests that it's deferring responsibility to some other code
> entity, it only indicates "checking this breaks, let's not do it".
> 
> It's possible that the device you care about only reports volatile
> diagnostic information through the vendor specific capability, but
> another device might use it to report information relative to the
> internal hardware configuration.  Without knowing what the vendor
> specific capability contains, QEMU needs to take the most conservative
> approach by default.  Thanks,

PCI/PCIe spec doesn’t define ABI for VSC/VSEC contents. Any other code 
entity except vendor driver should ignore VSC contents. QEMU’s 
expectation of VSC contents to be equal on source and destination seems 
incorrect given that QEMU has no control over ABI for VSC contents.

> 
> Alex
> 

