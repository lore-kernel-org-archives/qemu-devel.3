Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AF0C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzU1-0000BZ-8F; Wed, 20 Mar 2024 13:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rmzTz-0000B3-10
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:12:07 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com
 ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rmzTw-0005hJ-Jl
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko0SJmB6ItcwGnIqKtxbzhU9W4rUopqpLiDOlENaEll2xKN6x9rx8NLV83Rgeyzc+VRCH5/dCz5BAgTve39axpKL710sbfqwDXpSbarDvGWoA2BTmjKNU4SB7+ReOCXO1F8gE+Zz6H2txVH/2dTw4RuGP09/HPE1x5vIbZi221yycqBe4A/UUFjffn40H4gzMPkeD/nApJVAlKrMZZtrktnPKyio7yk/Fll4poJWatTXJ51ysjrvdZ8vaJ1o4dsBEndcTa/27+2ngPOHf5+MWj6GL3TzZzJgMWi9BQCzxHkYuieknJmAK3auqqD0cSsEDS236YtEVEuQnuliR5NKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpGdzk3mqoIKBR888KeSWchB+9HYWMUSHMcnC1ZIBV0=;
 b=H5j+3FHEUpv+r0pVJ8N/aDcZLzh5RVCOCt5xTYOvgpwwqLkxuLnC12o+MYr9clrf0/e5kqOMuhfMCX8JhdL0T19fsW7QdbXcfYLzQ3ACNrKSJdU8hsVnagpjb/mahXyLm3Hwrr+/Bjv3DyExZgGcwwnA+tbyA8q6oj5th3dudcSgLD0184V2zzX4X5rgLwh8m0/oePpSEgxVwM7u85THd7c5zxjOPxweqTuw5hXiU8TWa5M51KT1a/IAGaqdW1cLjcq7Xs6HE2jPLJbH9CceOD5fkJvmhX8jyKHnb4DuyPagrv3BuPHVXUWtuep36kQRsCRwBZRUgPp0U4HQ7dyoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpGdzk3mqoIKBR888KeSWchB+9HYWMUSHMcnC1ZIBV0=;
 b=EltbW2/AQfC9/oo72AIU7TNb5KS2a705WMez8x0AtnkFkgJE68Zg7IPdVjS2ADDi3N2pyYZR4t281qLomB5bOA8FhWqdJBV3EuUsA9CQZ0eWLHmrXUpWt0myZ6BgOaSNQfiLF6AjVwW8m+0ioevAHhQdrHJWUtufJLvlzqCgRFN73KswDeaV+HKpJEWxd6Q0tl3sR6HUFNgdeHi/KaGgzXQ6JTmdvwBDAxvJXUhoFtPJ5G9o5BsHk7oCjEo1lkC8lDNCEepoueuVCWqcxptgG7njcjwrQ5EX+9R95u/flGL3GIeJZYk/4RDAgQIyM1PHJGrrX87Y3SrQ95pS+9VgjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 17:06:57 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::74b2:8571:4594:c34a]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::74b2:8571:4594:c34a%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 17:06:54 +0000
Message-ID: <a16b2bcd-4ba2-49e9-8fe1-48d8fba07c56@nvidia.com>
Date: Wed, 20 Mar 2024 22:36:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/pci: migration: Skip config space check for
 vendor specific capability during restore/load
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 avihaih@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, zhiw@nvidia.com,
 targupta@nvidia.com, kvm@vger.kernel.org
References: <20240311121519.1481732-1-vkale@nvidia.com>
 <20240311090242.229b80ec.alex.williamson@redhat.com>
 <7cab7d27-0ad2-4cb5-9757-a837a6fd13a9@nvidia.com>
 <20240318085848.32b34594.alex.williamson@redhat.com>
X-Nvconfidentiality: public
From: Vinayak Kale <vkale@nvidia.com>
In-Reply-To: <20240318085848.32b34594.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 2befe2b1-41aa-489f-fffe-08dc49002484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDoZUTVTthtVcb4Ia2vkstQ46E3ObMhbNnufs/vRYVEeQ7fokCQA8P7hjbsj7b5OQq/nSkfhv+N1nCPKy2+A954KB1J7TXTGJWFqSxthlWBpL0rk/9iO9cg6R3mda3aVqfep2W1xTotLoWBy6TvQbkemTI7WnOoZAxUgXiVJCCP9lGv+isjaLcAy9CrEk8Slh7UJQc1KNa7uYP0jzMwcTxQH+r4zY2RFL6etw27pZp/Vij6cGVLUv/8+iHIBgwgph1Vbse1TvaWihrSlIk/kRrlhl40sAfR45g53afF1bC0Zp+xTb4fahgGqZvuUCjbUCmRMFsRJrbRTI+0Az3fGrqeZJiXZGlaom64PlKxYhhwdvmdD6L2mCHLlzV/WEKEoa2vuf6VYCDlk7SZ4zH6ukdqWRXLj4aKNT3nZWDcZ7/vkdjQ8vVflRiHlCcPBG9pxqVpHFkF3BeyEJ2q6e53toDoGpp6eSrIybWwCLOOHJ+i+b7HMBt4tvYZbEu3aIPJguJ1dunJSBmwFpIQ2Ed6aAb5DzegCwPUpWfF4At0zgI+sB4yB9aKx7o6kcAkj5tvZh1Z4QJHQeMcd14Iq9UJsIVQDkhrx6oDIIy1+NK5T6vNtnLiCe/bE7K4uJBFMX10N8s+B7vVofwkhDEDN5cHRYYnaGZmGCenpMRm9/3vw0CA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzlNcXFsYnMyUm1xc25ZdTdlOEJXM2Z6Ti9tREZpR3ZvUjJTRUNjSGdJMVZh?=
 =?utf-8?B?QWJtRXRIWkI4NG40UXJWaEhLMWFPbXg4ZlBjN3hoREJsaHJkRmdIQmt2b1lv?=
 =?utf-8?B?Mnl4Yk5wYlhIRGM4RW8wOGx3eXJNSFQ2K05nRXJ3NEYwSmdtOExYSkpaWE83?=
 =?utf-8?B?NEJ4SFFxRW05OTVUdkFxaGhlRjdNNm1hbzdUdTBjZnlLY3RQOHdXVDlXc0JN?=
 =?utf-8?B?M3pOeENOVGZxVUVVQ1B0c1hONUI1bjNHcldzalMwcTVkUWxxUEpjU05RZlZt?=
 =?utf-8?B?elkrY0M5OGxaNktiY0FKMm53RWVWTGVNQW00LzdYLzVVQmpwN1ByUnJNbitJ?=
 =?utf-8?B?SStCYUt2Zklpb0FjN2hKTVlGQ21lWHphUHlVYWtUM0VVZUh1dGcyTGVxWG9O?=
 =?utf-8?B?Y3dTNFh2VXI2Z0w4UjZyNEdhZ0wzcENJb0pRaGMzT1dhSjZsUVhxZzdWejN4?=
 =?utf-8?B?bUFFOE1OV3BOcTFWTkU3L0pnY2V4WGdOZkZiZWZOVnFLME51NVB4NURzV1JV?=
 =?utf-8?B?eTh0WnJjeGtTdlZ6cUJyQUg1am5oK0hYV0NSS0FIbVBOMHM5akoyUnhtZGo0?=
 =?utf-8?B?S3lUeW5DdWdyWmY5UWIwWS9KT2xIT0g2ZHNTQ1JNZjZtQmM1R3FQendsQ0ly?=
 =?utf-8?B?VHB5RkJBZXd2c0JEbksrV0dPOTQyVUxzQlFYeDZMaVYraVRVOS8yUWNyR3E3?=
 =?utf-8?B?WUM5bFZHZUVFdEVjVXZmbVlNaVRoQWUyTXdOT1p2NE5maXhhLzh0aTZ0bmlo?=
 =?utf-8?B?RjFTS3RrNW1VN2NGclIrRlR4V1ZibC9sZ2JLOGlNQ0YrV1MyNzY4cUVlZU9o?=
 =?utf-8?B?TlYvMno0S0I2ZEdxSWNwQ0RSbmluSVg0TTRZVzNmdTdGUmtKdE9jcWV2MGpR?=
 =?utf-8?B?aU83clZiOHh6dHZaYS9OVTVTMFBzOE92YVZqUk1sdlFONVJQWjc3b1JJbXJp?=
 =?utf-8?B?VUJwR1JLUGdWTktsRUo3MXdBejE4QW1qVktpaURCUUR2dHo1R2pYWFhvRnpU?=
 =?utf-8?B?Rm5XTTBHU09adkxhWFVtZGhBOS9tdlF0STF3RjNjSTc1SGpQUmZjeEdkUXMx?=
 =?utf-8?B?dXlKZ1h3NFBqRkhWTjgzeFNCNFRqUnpEUVhVd3Exckl1bDdxM0JvMUkwbDZz?=
 =?utf-8?B?VFcyRUZIenFkYVZTRDFWM09NcVFuUEh3NnFoUDI3ZyttemQ1OWhKVTUwbVFF?=
 =?utf-8?B?eDNyVkx2b0NhVExVYUlzWldDS2phTXlYUktqOUV1NVZXR1hLUjNHUklNcTdx?=
 =?utf-8?B?TW1JdG5RQ0tDQlRhZDBOYmloWlpGL0g2Nnl2ZndmMEgxYTlhdjhpeVZPZzlG?=
 =?utf-8?B?KzQzdi9JNm9mZkVCeGJueS9GWVk3dWhuR1NtYUJxQ2FXK2taK3RyTTlRL2xC?=
 =?utf-8?B?VVlhS25odWVTU2Zsc0YreUlQNmNxdnN6cm00STZ6NTkzOEN6L1hmWXdscTNU?=
 =?utf-8?B?N2tEeG9IaUxZQXFVcTMvRUllSWw1UE9wNGVTaVRweFp0alFPditBc3pCZE5R?=
 =?utf-8?B?ZHh5ZDNiM3Z0ZE9DOTgweFh2VXlhZmdSZ0xEc2w3M0plQjJMQW51aUtjQ29q?=
 =?utf-8?B?Q3Jaa1N0SFJwNEV5elRLL3dGc1pDTUZ6RUZtUTc0QnpZVjArVWhzbHkxNGVQ?=
 =?utf-8?B?bTlzV0xKeHpmVS9mYjRYT0h3SFlxa3hzbG0wbkZRQ2N1UUJLSTFHSE14Zm5I?=
 =?utf-8?B?Y2JNVGxpdDRBMDEzMFFFTm5ab2ozb0dyMUhzalNsQjZJSEZQenhpNHdQcnVi?=
 =?utf-8?B?bmpBYXF5TXlxYnFHOEQzd3dwR0V2d0VRdW9xTkcxeUVEcUpFdStEMHo2ZzI0?=
 =?utf-8?B?eHRJMlA5YXZqR2poTXZNZkhiR2ZIZS9sRmlLNERETmI0RG5TZzRYUkxWN01Z?=
 =?utf-8?B?T1hzeUtRSFhidzBvNElWc2gvVjc2UFFJTUdreVg1MkFsU01WakV1cE9lUi9o?=
 =?utf-8?B?NW1VUVU5QVFtZlF5Q1IyTm8zSk1SU1dteUIvWDhYdzB1OWtaQVZ2RzZ0N2R1?=
 =?utf-8?B?cVZlcGlZYVEzd1BPTUt6VFQ3S3diVFBIVFZnZmdUeEQ0OHE1NFZ5cHV3cVM1?=
 =?utf-8?B?a3o4Sy84aktvU2dpUWlZNGNhSWcxNjV3dzU4VWNrRWZIcDEvR0NHUERBREpJ?=
 =?utf-8?B?cEZGNC9pRGZqZXkvTklQWmJGemdCOExmSGpJOGN6N1ZkLzAwb05SdS9WUmVE?=
 =?utf-8?Q?Vk/SqL+ltPn5UoJeNMQIkChl5BSYIDGzltuUl7+A3Rge?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2befe2b1-41aa-489f-fffe-08dc49002484
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 17:06:54.5510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrQZu1VzgSr/ErCDthULV0I0/GIN2Q076QMxEVcNL/nZ4Xo9dYbL77dmCrliCMJgR6bc/b8oEGuaKHEWL9EezQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
Received-SPF: softfail client-ip=40.107.236.40; envelope-from=vkale@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 18/03/24 8:28 pm, Alex Williamson wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, 15 Mar 2024 23:22:22 +0530
> Vinayak Kale <vkale@nvidia.com> wrote:
> 
>> On 11/03/24 8:32 pm, Alex Williamson wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, 11 Mar 2024 17:45:19 +0530
>>> Vinayak Kale <vkale@nvidia.com> wrote:
>>>
>>>> In case of migration, during restore operation, qemu checks config space of the
>>>> pci device with the config space in the migration stream captured during save
>>>> operation. In case of config space data mismatch, restore operation is failed.
>>>>
>>>> config space check is done in function get_pci_config_device(). By default VSC
>>>> (vendor-specific-capability) in config space is checked.
>>>>
>>>> Ideally qemu should not check VSC for VFIO-PCI device during restore/load as
>>>> qemu is not aware of VSC ABI.
>>>
>>> It's disappointing that we can't seem to have a discussion about why
>>> it's not the responsibility of the underlying migration support in the
>>> vfio-pci variant driver to make the vendor specific capability
>>> consistent across migration.
>>
>> I think it is device vendor driver's responsibility to ensure that VSC
>> is consistent across migration. Here consistency could mean that VSC
>> format should be same on source and destination, however actual VSC
>> contents may not be byte-to-byte identical.
>>
>> If a vfio-pci device is migration capable and if vfio-pci vendor driver
>> is OK with volatile VSC contents as long as consistency is maintained
>> for VSC format then QEMU should exempt config space check for VSC contents.
> 
> I tend to agree that ultimately the variant driver is responsible for
> making the device consistent during migration and QEMU's policy that
> even vendor defined ABI needs to be byte for byte identical is somewhat
> arbitrary.
> 
>>> Also, for future maintenance, specifically what device is currently
>>> broken by this and under what conditions?
>>
>> Under certain conditions VSC contents vary for NVIDIA vGPU devices in
>> case of live migration. Due to QEMU's current config space check for
>> VSC, live migration is broken across NVIDIA vGPU devices.
> 
> This is incredibly vague.  We've been testing NVIDIA vGPU migration and
> have not experienced a migration failure due to VSC mismatch.  Does this
> require a specific device?  A specific workload?  What specific
> conditions trigger this problem?

In case of live migration, in a situation where source and destination 
host driver is different, Vendor Specific Information in VSC varies on 
the destination to ensure vGPU feature capabilities exposed to guest 
driver are compatible with destination host. This is applicable to all 
NVIDIA vGPU devices.

> 
> While as above, I agree in theory that the responsibility lies on the
> migration support in the variant driver, there are risks involved,
> particularly if new dependencies on the VSC contents are developed in
> the guest.  For future maintenance and development in this space, the
> commit log should describe exactly the scenario that requires this
> policy change.  Thanks,

I'll add aforementioned scenario (situation when live migration is 
broken for NVIDIA vGPU devices) in the commit description. Thanks.

> 
> Alex
> 
>>>> This patch skips the check for VFIO-PCI device by clearing pdev->cmask[] for VSC
>>>> offsets. If cmask[] is not set for an offset, then qemu skips config space check
>>>> for that offset.
>>>>
>>>> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
>>>> ---
>>>> Version History
>>>> v1->v2:
>>>>       - Limited scope of change to vfio-pci devices instead of all pci devices.
>>>>
>>>>    hw/vfio/pci.c | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index d7fe06715c..9edaff4b37 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -2132,6 +2132,22 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
>>>>        }
>>>>    }
>>>>
>>>> +static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
>>>> +                                        uint8_t size, Error **errp)
>>>> +{
>>>> +    PCIDevice *pdev = &vdev->pdev;
>>>> +
>>>> +    pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
>>>> +    if (pos < 0) {
>>>> +        return pos;
>>>> +    }
>>>> +
>>>> +    /* Exempt config space check for VSC during restore/load  */
>>>> +    memset(pdev->cmask + pos, 0, size);
>>>
>>> This excludes the entire capability from comparison, including the
>>> capability ID, next pointer, and capability length.  Even if the
>>> contents of the capability are considered volatile vendor information,
>>> the header is spec defined ABI which must be consistent.  Thanks,
>>
>> This makes sense, I'll address this in V3. Thanks.
>>
>>>
>>> Alex
>>>
>>>> +
>>>> +    return pos;
>>>> +}
>>>> +
>>>>    static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>>>>    {
>>>>        PCIDevice *pdev = &vdev->pdev;
>>>> @@ -2199,6 +2215,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>>>>            vfio_check_af_flr(vdev, pos);
>>>>            ret = pci_add_capability(pdev, cap_id, pos, size, errp);
>>>>            break;
>>>> +    case PCI_CAP_ID_VNDR:
>>>> +        ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
>>>> +        break;
>>>>        default:
>>>>            ret = pci_add_capability(pdev, cap_id, pos, size, errp);
>>>>            break;
>>>
>>
> 

