Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0DACD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNfA-00066Z-BG; Thu, 04 Apr 2024 10:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1rsNen-0005qY-JR; Thu, 04 Apr 2024 10:01:34 -0400
Received: from mail-dm3nam02on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2405::700]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1rsNei-0007xR-R1; Thu, 04 Apr 2024 10:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM0XZywCGkebek80OlyvbAdjhR21mzRY/okDKMljp0sPFGg3inckFH32N/CfdOGLniRyDStaxokh27ASi4vt7evomkndMzu3gCHm6BgVaM5o5/0bXyuRvKBTdeauwnCSuFyzlrCnwibGm35svDQ07+2Frb/APIQh+s/OZQoub9HvriGGnplwfErqMTzzvdXlhzfaMnkg//gq/HLQODsjZLOzA/p7/ZaeJqK4HHgVZN/K38Vk5uemxPjWJDd2Z8YN2Dx4H/FPe4trMccVohjhgeXEMr8IrgxrANWHVctEbc/jWliGSq2LgCPo5SSLXnzhjLNYdB1Y2Kqo0P5JfQn+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaXvKDtaneKLD7J4eMPjNahnVopMZOi79UzWqeijaLc=;
 b=ixtV+hWKYS9Tux4XG0H2t7Tu7zonxqmN1HOj3adSF4MPUQaMN/ZmAuGMIOSUZMyt+b7xBu12EcwgNpaQ3CP/Wzn7X5Vxl60HsyNnasQk0p++Li64RD5jCe1DiQSF2ePexLqIWeidaXqyJOY2fVzuQh+3jPax/7LgSHxAiOw/7FqnSYgN4sLWrJjYePzX5FPl9BSUPJH5UqSFDidg1QbOjFixwsM1Nc4VPk7vtKsfVf4Lsiq+udLBZENe/sXgGXuIJO7ubWIwqib+7TWRyOvD5XDBPvgHYJgEQBudac5MukTbvn/opoP6LUQ28yaj66iVfl3Lx7WhnlfYCPtbjVc6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaXvKDtaneKLD7J4eMPjNahnVopMZOi79UzWqeijaLc=;
 b=9uAgEtn/97CIWH6tZK8YJdU5DeFpxeI3u1oL8RrSSH4bqsQ0+smLY5LXf5hIsbSCj1N68ebKZADLI0vAjI469aXwgp+I1TM8/gSWFmdHvX3J7Wm4P98biWHr7fpJNV3gpIACIOTOZxEAvF9fJpIy9dmcGdyBaa9hmxAloWtgvQI=
Received: from DM8PR01MB7142.prod.exchangelabs.com (2603:10b6:8:1::11) by
 SJ0PR01MB6157.prod.exchangelabs.com (2603:10b6:a03:290::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 14:01:20 +0000
Received: from DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::63bf:3703:b8b4:9d1]) by DM8PR01MB7142.prod.exchangelabs.com
 ([fe80::63bf:3703:b8b4:9d1%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 14:01:20 +0000
Content-Type: multipart/alternative;
 boundary="------------c8RvZptx13P3VidEKPRJjXJ9"
Message-ID: <98b28e91-20e1-4b71-8997-608303fbdb3f@amperemail.onmicrosoft.com>
Date: Thu, 4 Apr 2024 19:31:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 3/8] hw/acpi: Update ACPI GED framework to support vCPU
 Hotplug
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com,
 gankulkarni@os.amperecomputing.com
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-4-salil.mehta@huawei.com>
Content-Language: en-US
From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
In-Reply-To: <20240312020000.12992-4-salil.mehta@huawei.com>
X-ClientProxiedBy: CH2PR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:610:56::22) To DM8PR01MB7142.prod.exchangelabs.com
 (2603:10b6:8:1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB7142:EE_|SJ0PR01MB6157:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxcR/fs8JPJeggrlazzdf55L2tSPQWiF2MhPm4APNPPUqAlBCkxetWZb/VLExm9UU6ntj6zh676x9fY4cxDr0wEok5aSZuWdPGs1bBtWRBh54vRejjlwPWAg93k0LwD9JopBGW5YDAjFreTIFDS+OmDbzyvkyizC5usW8MhWysCuJL+DwtgV5XiZWSAzJtYt491y68i3hFK8fwoetxuQB77F3cBXwACbBhYt1b4aeZ9OWRDJ9wmyeeFjDTndESLZCJIeKB+dKsaXVgw8cCBErS3BoJPztfZP36xxhxBFgKKLrXFJnHzpIsLa/y4N9RQwXXUrUt644MdQ/jkah7H5KfwsIi6uoVWj4poVaoo3cCJ1vs5HVl/DKQY/oPHjDKjcHUBJu3ZAWx92GNTbb4BBTgXEVVhVuh2eJtFr6Zvdjlf2KwBIkFBnps98K3vvQbT7EIv/1FDfrBDF8yE26+UoYRAtal0BfMbrYs79uJl1D8MZ3WY5t3WhcYH7ulpi4zicH/P7Wcy4nOeZiqtRgF7b3i3DbwomddwidJGKMpfn1kZwmlH/gCEtfeES95ZKACNamdWpcPIwMsmGv9rF5mFSl/QLgyJCqoyIb29Z/lNQ5vB0xJhTboBpKAd9ORJYzz/t+gJ0h9f1tt2PLunZC6Yop7Ez8BGltrm2bP4CfQYsdkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB7142.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2liTk4yeEU0NGZ1ZVdlbGRKeW5VUFNqd2ZhWGlyeEpRYU1qbjk5M2drV2xK?=
 =?utf-8?B?QXovdGovd3k3UGx4SmsrWXdwbCsrODd2VVJPQkh4c0NwZk40UWZFM0hRVG1L?=
 =?utf-8?B?N1FPMWJWeVEvTnBHMjhrQWM5NWZLUFhTbjFUUWZkZjVXZUloSlJwQklkQ1do?=
 =?utf-8?B?UmY0bDRQRldaZW5MZTNhMVdsQ0Noc0FCalhMT2xqVk9TeDUzNEp6cit1NnhT?=
 =?utf-8?B?T0JwdmxhQUQ3blIyQlJxeE1TanJDTWdEOHA2Zi9abnpWMkFQR0pxdStYVmNy?=
 =?utf-8?B?MllXMEdEWDRUMmhTQ0Z2VDc0M2ZYcjVZbUgyWC81YTZYc3dOZFpVd3hXa3JV?=
 =?utf-8?B?YThzTm8yOVFUMWp5bFpYRlFnK3BDelhFRklFdE1jekZqcCt1ekZaL2tmT3lt?=
 =?utf-8?B?blJZdEI3eVhuZTl2Nk9VU2JnaDdsdDN6TjJhODkvVGdNVTkvc21BUmErNkZ2?=
 =?utf-8?B?RU5Qdjd3aHdZRlpWWFVkQVJsYzltMi9uT2ZsSFNTbjRUTFcwNHRSVmRtU3Fm?=
 =?utf-8?B?aVh0ejZ6WjNhUStmVk1UN0ZpWnZlUGlSM1ZaL0dHNkE3NHR0Wnl1bG94ejFL?=
 =?utf-8?B?a1VJdzdtQTRSNFp3bVlXM2lFanFBTlEwN0dacWlyd2xheDZIV1BVNEFSbFNX?=
 =?utf-8?B?eU5sbE11QVNzdXVCaXpxZUNDWnNCM210dS9Qd1NNWlU5Y1dMcU5lUkhsUWEz?=
 =?utf-8?B?L0pkQ3BZODBXV1RvUEk5UEVoT0ZWT1IvcVFzdU1XTVpvVXpsK0taQXVaQVBi?=
 =?utf-8?B?SFVqZGRtUU56Zk5wU2NCRUo4V3NJWVdldmU1bjRWN1YvejJ5eHVEZXNOYlRm?=
 =?utf-8?B?bUVCN2lTWGZDcFZKZmVMZGpZRUo2bEJNck5IK2UvbUdRNldQMmFGa2ZtMExo?=
 =?utf-8?B?VmVSd2tSMVA2RGFCVTBwY3NzV0JZMEl1aVRuc1lnUDNvVGR3WWlGbXZKUG1M?=
 =?utf-8?B?WmRCWXo1bmpyU3VoN2lYdGdvRllpeVVpOXJNSksxUWloRG9sUmxncmpNeDJ2?=
 =?utf-8?B?U1VpL3VTUjEwdi8zajNZbXM3a0FXc3lEL1R2QjN0SklyVmsyc1VQSW5mdWRn?=
 =?utf-8?B?elpYczdNYkZ1Y3dpL0VvSTFyUVNpdzQ1c2ZRV0Q4L241Z1dsQSsyQ0NBYm01?=
 =?utf-8?B?K1IxRHpmRWdOVUlIN2tvYTFTNzFhMUhHS0JXMmorcGdweEsvaVRaSHFRa2ZL?=
 =?utf-8?B?bHgxQnZLb1pCeU42WUZNOEtMMXNMd0hpbjluVk9JRjltblMzQm9qYStsUGI2?=
 =?utf-8?B?S0VQY1NMM3BuVlBpMzllVks2djFNRURGUHIvdDA5dXUvMDd6cTlOQVBya1Nn?=
 =?utf-8?B?WmJjWDlITUtiVUhlbFRmc2NhYXUyRjhnRC9qTXpoRHN0WFZDVG5MV240OHcv?=
 =?utf-8?B?KzRYc2VUOXF5TnlNUnJTR2ZTMFhVbHk2a0tqcEhUcnUvKzRGdVNHRHQrQXQ0?=
 =?utf-8?B?N0o3RzdPVlN0QnZrMUpaL0JLbis0OXlrc2F3ckdjdTR1UkNQT3duY2JlaUdy?=
 =?utf-8?B?eE1jTnFOdkphY3Q1L0kwZDRDaGJ5MEhrNzVDMTBralJzazdVWSttamh4L2s0?=
 =?utf-8?B?VkJjZUROZ3FxWW0rekdnTmRvQXZVOVFxNWtEOWNvU3puQkF4ZjZJVjVuTnZ3?=
 =?utf-8?B?YkJOK2pkcWVGdGcrRlFBSUF0bUFHdktBbXUwTjV3UXM2b1ZRV3ZjR0Voa2pE?=
 =?utf-8?B?dFlHd3pHQmZONkNZSk9BWjdHdmNGZFlEZjUzMjVld1kvL3BXQlByOGJrQnFB?=
 =?utf-8?B?bFd4eWMyUy9lcTlOUW11SU1wdkkrcVFMN2ZNSzJmbjNTREdZSkMremc4L2RT?=
 =?utf-8?B?Z1dxSGZvYlhjc1ZXbDExOTVnazl6ekU4WVRzV2Q5RFhqZmJ6Vm4zelo3UGM0?=
 =?utf-8?B?Q1RTaHpGOFdQR2p2bG8xVzNILzJCL3huaUNXVXpORlNxWnprWDVsODk2NnZv?=
 =?utf-8?B?K3BoVXQ2U2NPbSt0N0tvaXp1SlJ3ZXBpV3ZBWUUzUkdUazBPaTlETmRDRFVN?=
 =?utf-8?B?S0MrQ1E0VHZVcU5kQWQwVFNCbzk4aUc5cUg3b1hiWUdZd21tRHQxU25tR1Ay?=
 =?utf-8?B?SUJBYjRFNmppVlVqWkNrYS9MLy9HTisrWjdJL3BjWjBaUSs3djlTdDhSZVdP?=
 =?utf-8?B?bFhpMUlNK0pPcjFXaDM2YnhmbldBMGlPbE12Yk84bEg1WlZhR3F4Q2NHVVkz?=
 =?utf-8?Q?eg4HRxz+K5aDVZa+eK4YH2Q=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f848a7-ed19-46c2-0581-08dc54afb4ad
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB7142.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 14:01:20.8426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gnOnbxdZfJbsdl5yQvo7MoiGnbKNaK14az2x6AsAx9QVdp6Wq/WLbUyf+Tt+skqeZ9hQvMfxtBPxoEp52y2w6AgBDhZwM0XnfdTcvqaOraY2r+Bj+TwUKOb3nl1XQYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6157
Received-SPF: pass client-ip=2a01:111:f403:2405::700;
 envelope-from=vishnu@os.amperecomputing.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--------------c8RvZptx13P3VidEKPRJjXJ9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Salil,

On 12-03-2024 07:29, Salil Mehta wrote:
> ACPI GED (as described in the ACPI 6.4 spec) uses an interrupt listed in the
> _CRS object of GED to intimate OSPM about an event. Later then demultiplexes the
> notified event by evaluating ACPI _EVT method to know the type of event. Use
> ACPI GED to also notify the guest kernel about any CPU hot(un)plug events.
>
> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.
>
> Co-developed-by: Keqian Zhu<zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu<zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta<salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan<gshan@redhat.com>
> Reviewed-by: David Hildenbrand<david@redhat.com>
> Reviewed-by: Shaoqin Huang<shahuang@redhat.com>
> Tested-by: Vishnu Pajjuri<vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li<lixianglai@loongson.cn>
> Tested-by: Miguel Luis<miguel.luis@oracle.com>
> ---
>   hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++++
>   hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
>   include/hw/acpi/generic_event_device.h |  4 ++++
>   3 files changed, 27 insertions(+)
>
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 3fc4b14c26..c6c61bb9cd 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>       return;
>   }
>   
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>   {
>       return;
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 2d6e91b124..35a71505a5 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -12,6 +12,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "hw/acpi/acpi.h"
> +#include "hw/acpi/cpu.h"
>   #include "hw/acpi/generic_event_device.h"
>   #include "hw/irq.h"
>   #include "hw/mem/pc-dimm.h"
> @@ -25,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>       ACPI_GED_MEM_HOTPLUG_EVT,
>       ACPI_GED_PWR_DOWN_EVT,
>       ACPI_GED_NVDIMM_HOTPLUG_EVT,
> +    ACPI_GED_CPU_HOTPLUG_EVT,
>   };
>   
>   /*
> @@ -234,6 +236,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>           } else {
>               acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>           }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>       } else {
>           error_setg(errp, "virt: device plug request for unsupported device"
>                      " type: %s", object_get_typename(OBJECT(dev)));
> @@ -248,6 +252,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>       if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>                          !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
>           acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>       } else {
>           error_setg(errp, "acpi: device unplug request for unsupported device"
>                      " type: %s", object_get_typename(OBJECT(dev)));
> @@ -261,6 +267,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>           acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>       } else {
>           error_setg(errp, "acpi: device unplug for unsupported device"
>                      " type: %s", object_get_typename(OBJECT(dev)));
> @@ -272,6 +280,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
>       AcpiGedState *s = ACPI_GED(adev);
>   
>       acpi_memory_ospm_status(&s->memhp_state, list);
> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>   }
>   
>   static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> @@ -286,6 +295,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>           sel = ACPI_GED_PWR_DOWN_EVT;
>       } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>           sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
>       } else {
>           /* Unknown event. Return without generating interrupt. */
>           warn_report("GED: Unsupported event %d. No irq injected", ev);
> @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
>       memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                             TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>       sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
same sbd can be used here instead of SYS_BUS_DEVICE(dev).
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);
>   }
>   
>   static void acpi_ged_class_init(ObjectClass *class, void *data)
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index ba84ce0214..90fc41cbb8 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -60,6 +60,7 @@
>   #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>   
>   #include "hw/sysbus.h"
> +#include "hw/acpi/cpu_hotplug.h"
>   #include "hw/acpi/memory_hotplug.h"
>   #include "hw/acpi/ghes.h"
>   #include "qom/object.h"
> @@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>   #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>   #define ACPI_GED_PWR_DOWN_EVT      0x2
>   #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>   
>   typedef struct GEDState {
>       MemoryRegion evt;
> @@ -106,6 +108,8 @@ struct AcpiGedState {
>       SysBusDevice parent_obj;
>       MemHotplugState memhp_state;
>       MemoryRegion container_memhp;
> +    CPUHotplugState cpuhp_state;
> +    MemoryRegion container_cpuhp;
>       GEDState ged_state;
>       uint32_t ged_event_bitmap;
>       qemu_irq irq;

Otherwise, Looks good to me.  Feel free to add
Reviewed-by: "Vishnu Pajjuri" <vishnu@os.amperecomputing.com>

_Regards_,

-Vishnu

--------------c8RvZptx13P3VidEKPRJjXJ9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Salil,<br>
    </p>
    <div class="moz-cite-prefix">On 12-03-2024 07:29, Salil Mehta wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240312020000.12992-4-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">ACPI GED (as described in the ACPI 6.4 spec) uses an interrupt listed in the
_CRS object of GED to intimate OSPM about an event. Later then demultiplexes the
notified event by evaluating ACPI _EVT method to know the type of event. Use
ACPI GED to also notify the guest kernel about any CPU hot(un)plug events.

ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
stub to avoid compilation break.

Co-developed-by: Keqian Zhu <a class="moz-txt-link-rfc2396E" href="mailto:zhukeqian1@huawei.com">&lt;zhukeqian1@huawei.com&gt;</a>
Signed-off-by: Keqian Zhu <a class="moz-txt-link-rfc2396E" href="mailto:zhukeqian1@huawei.com">&lt;zhukeqian1@huawei.com&gt;</a>
Signed-off-by: Salil Mehta <a class="moz-txt-link-rfc2396E" href="mailto:salil.mehta@huawei.com">&lt;salil.mehta@huawei.com&gt;</a>
Reviewed-by: Jonathan Cameron <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Cameron@huawei.com">&lt;Jonathan.Cameron@huawei.com&gt;</a>
Reviewed-by: Gavin Shan <a class="moz-txt-link-rfc2396E" href="mailto:gshan@redhat.com">&lt;gshan@redhat.com&gt;</a>
Reviewed-by: David Hildenbrand <a class="moz-txt-link-rfc2396E" href="mailto:david@redhat.com">&lt;david@redhat.com&gt;</a>
Reviewed-by: Shaoqin Huang <a class="moz-txt-link-rfc2396E" href="mailto:shahuang@redhat.com">&lt;shahuang@redhat.com&gt;</a>
Tested-by: Vishnu Pajjuri <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a>
Tested-by: Xianglai Li <a class="moz-txt-link-rfc2396E" href="mailto:lixianglai@loongson.cn">&lt;lixianglai@loongson.cn&gt;</a>
Tested-by: Miguel Luis <a class="moz-txt-link-rfc2396E" href="mailto:miguel.luis@oracle.com">&lt;miguel.luis@oracle.com&gt;</a>
---
 hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++++
 hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
 include/hw/acpi/generic_event_device.h |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index 3fc4b14c26..c6c61bb9cd 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
     return;
 }
 
+void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
+                         CPUHotplugState *state, hwaddr base_addr)
+{
+    return;
+}
+
 void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
 {
     return;
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 2d6e91b124..35a71505a5 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -12,6 +12,7 @@
 #include &quot;qemu/osdep.h&quot;
 #include &quot;qapi/error.h&quot;
 #include &quot;hw/acpi/acpi.h&quot;
+#include &quot;hw/acpi/cpu.h&quot;
 #include &quot;hw/acpi/generic_event_device.h&quot;
 #include &quot;hw/irq.h&quot;
 #include &quot;hw/mem/pc-dimm.h&quot;
@@ -25,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_MEM_HOTPLUG_EVT,
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
+    ACPI_GED_CPU_HOTPLUG_EVT,
 };
 
 /*
@@ -234,6 +236,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
         } else {
             acpi_memory_plug_cb(hotplug_dev, &amp;s-&gt;memhp_state, dev, errp);
         }
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_plug_cb(hotplug_dev, &amp;s-&gt;cpuhp_state, dev, errp);
     } else {
         error_setg(errp, &quot;virt: device plug request for unsupported device&quot;
                    &quot; type: %s&quot;, object_get_typename(OBJECT(dev)));
@@ -248,6 +252,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
     if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &amp;&amp;
                        !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
         acpi_memory_unplug_request_cb(hotplug_dev, &amp;s-&gt;memhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_unplug_request_cb(hotplug_dev, &amp;s-&gt;cpuhp_state, dev, errp);
     } else {
         error_setg(errp, &quot;acpi: device unplug request for unsupported device&quot;
                    &quot; type: %s&quot;, object_get_typename(OBJECT(dev)));
@@ -261,6 +267,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&amp;s-&gt;memhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_unplug_cb(&amp;s-&gt;cpuhp_state, dev, errp);
     } else {
         error_setg(errp, &quot;acpi: device unplug for unsupported device&quot;
                    &quot; type: %s&quot;, object_get_typename(OBJECT(dev)));
@@ -272,6 +280,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
     AcpiGedState *s = ACPI_GED(adev);
 
     acpi_memory_ospm_status(&amp;s-&gt;memhp_state, list);
+    acpi_cpu_ospm_status(&amp;s-&gt;cpuhp_state, list);
 }
 
 static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
@@ -286,6 +295,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_PWR_DOWN_EVT;
     } else if (ev &amp; ACPI_NVDIMM_HOTPLUG_STATUS) {
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
+    } else if (ev &amp; ACPI_CPU_HOTPLUG_STATUS) {
+        sel = ACPI_GED_CPU_HOTPLUG_EVT;
     } else {
         /* Unknown event. Return without generating interrupt. */
         warn_report(&quot;GED: Unsupported event %d. No irq injected&quot;, ev);
@@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
     memory_region_init_io(&amp;ged_st-&gt;regs, obj, &amp;ged_regs_ops, ged_st,
                           TYPE_ACPI_GED &quot;-regs&quot;, ACPI_GED_REG_COUNT);
     sysbus_init_mmio(sbd, &amp;ged_st-&gt;regs);
+
+    memory_region_init(&amp;s-&gt;container_cpuhp, OBJECT(dev), &quot;cpuhp container&quot;,
+                       ACPI_CPU_HOTPLUG_REG_LEN);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &amp;s-&gt;container_cpuhp);</pre>
    </blockquote>
    same sbd can be used here instead of SYS_BUS_DEVICE(dev).<br>
    <blockquote type="cite" cite="mid:20240312020000.12992-4-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
+    cpu_hotplug_hw_init(&amp;s-&gt;container_cpuhp, OBJECT(dev),
+                        &amp;s-&gt;cpuhp_state, 0);
 }
 
 static void acpi_ged_class_init(ObjectClass *class, void *data)
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index ba84ce0214..90fc41cbb8 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -60,6 +60,7 @@
 #define HW_ACPI_GENERIC_EVENT_DEVICE_H
 
 #include &quot;hw/sysbus.h&quot;
+#include &quot;hw/acpi/cpu_hotplug.h&quot;
 #include &quot;hw/acpi/memory_hotplug.h&quot;
 #include &quot;hw/acpi/ghes.h&quot;
 #include &quot;qom/object.h&quot;
@@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
+#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -106,6 +108,8 @@ struct AcpiGedState {
     SysBusDevice parent_obj;
     MemHotplugState memhp_state;
     MemoryRegion container_memhp;
+    CPUHotplugState cpuhp_state;
+    MemoryRegion container_cpuhp;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;</pre>
    </blockquote>
    <p>Otherwise, Looks good to me.&nbsp; Feel free to add<br>
      Reviewed-by: &quot;Vishnu Pajjuri&quot;
      <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a><br>
    </p>
    <p><u>Regards</u>,</p>
    <p>-Vishnu<br>
    </p>
    <blockquote type="cite" cite="mid:20240312020000.12992-4-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------c8RvZptx13P3VidEKPRJjXJ9--

