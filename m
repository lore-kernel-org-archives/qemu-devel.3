Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2235C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzypi-0007JB-Ro; Fri, 28 Aug 2026 11:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzypg-0007Iy-Fc; Fri, 28 Aug 2026 11:49:32 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzypd-0004kz-UV; Fri, 28 Aug 2026 11:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUK6VMReKkqAhvvBnY/MKD+6gY2qEnX/HfHjTj3fEyAQ5CxQGtZD82GtXKxsAASHKc3MW1azeZ9mgxVOkHD/EmOnU2BEvrvt2+1r6yCFsj1ImDAHoMwLJHJedD7Wjo8KEHipeSNQdtfffQK4rJvwyE+cyRFjbxDc6I0j5rYK65PWan4HDCcvlewUerDaB+3JRFYf5I4E55e4hRkqZC3AQ5iDhJVY0lsdXxE0aq2CjBoMgBjFb8JdPldI2b87SU/meuhmeAF4d9FAMrzvcJkBSNkrjju8wtxpfqu8J2zAYRA4wAaJbnoL9UJGk0kU0sRnt9Qp++qgEq5bNDg856UqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuNIO/HxTMXp2UEwlW6BThibto15fRdh9sHbUfWlJtE=;
 b=EEZeD1UZMM8hwx8Q/o/vwGxGYUNAQnMQe6ZI2Ma9ihOak5FX9c2a0UXUpIlLWah7TJdbjDx2GRPvGSwAqwYyJv/b5C9nuDKCEMKt+6b7CGBk0fMvvLQX3JelXlrLN4pxj9KaQlFgJgKernJ3+iXjPxF/LtA+kaQ2wXNQUpB6KbI5toTHDdL7pt+UV9/mPFZBvThHx/1IojjIWoQDyKIC8xVBTjswVtwVL7bY7JK4Uogk6WvTKZjMOTbdRnR1/9YTTVp7Sbz+wI6epuhE7nLTOJ6qcOV6BGIaWIQOqEXA254HGZRpuiy+wsjB1yLKjktbi0eyJE42MkDnsi9oxjY9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuNIO/HxTMXp2UEwlW6BThibto15fRdh9sHbUfWlJtE=;
 b=eydpk01kHcbNzOZnpqFmI6J+WHKvlH72kasUlxhWkJopB4nQY/H2fEqhXSsOmTx2ARzT4pCP7wQK8qx9+6lszMisOcDfFbkpxxH6+nJOajdm35RzbbpCme1QFSvnz+dUOUYG12QncafbE/0KsRPlccM+G+DI9YSUvdWgkueFzM3UGNeBEgMfC3KZlc+FMiIjYoylfk1u7voWXqgvulhixN4RDaREYSMzT9E39LA3iPb7iOrdOGNbZ3fGjGew4iDjKEF3yJofo/wxSpi224IcS88wMizhrzmJesManXoUizwy6rQob+0ZRYD1zbuoh6ShTQpSI4FW0Amw/8MbBKjwag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:49:21 +0000
Received: from CH3PR12MB9732.namprd12.prod.outlook.com
 ([fe80::9ca6:b6a5:78f0:b31b]) by CH3PR12MB9732.namprd12.prod.outlook.com
 ([fe80::9ca6:b6a5:78f0:b31b%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:49:21 +0000
Message-ID: <f2fe3c7f-4a8f-4025-ac09-777eb5cfc31c@nvidia.com>
Date: Fri, 28 Aug 2026 10:49:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [edk2-devel] [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI
 BAR placement
To: Ard Biesheuvel <ardb@kernel.org>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <46b4544a-6e97-4433-b3e2-60cf43e62c7b@app.fastmail.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <46b4544a-6e97-4433-b3e2-60cf43e62c7b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To CH3PR12MB9732.namprd12.prod.outlook.com
 (2603:10b6:610:253::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9732:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db39a21-271a-4c13-7c1a-08df051bed55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 4/+7QKQtLhslLEKRbZy/SjcnY3EKz8NV3G6WcHZDYo4xbFQbBiQFs5oKUd6qp22QO9/mcUAq4ZEfW1Fg4oiouvf/EDoCuSYX2+Loy/8qjr4w1HekHUSATVFomJe3/Vby32Tmai+vnTOg0icS5HwICi0DSzJnVD4rbtP5IYkxtz8oBeQ1EZQ6SmKonXqWO6ps4PiFco3PhYfyrW2swn7mQ7hK1d04CYiqEL/aTVp3LbrM73l9GjyuZtFZ9gG92ijKQ4INgJZ3eJr7nPDTpAct1kHxP4p1v4NrKnMMgcUZynBRb1G92Y7li+iLu34hJWDkEOeVbd8UjORlKFlsXO/NRQQ/ktvzM3+bnJscu5ztgUQOA+cL+d48WJKLPnpDrJjAunQtW8z/qYkwILhEsKxs5U8R41WTazG42qGUjPR1TESqY2sM5slQ7fjRJn6FucuWCRUmEbQHSPdCwEqxkaVM1K8dnl0fzAY7Pkba+Y2bZK08j7HlEOzWNbP38JsxohQ6qiDFz1MkGhqAfAmRiCGfrIc727xsQmOJnKh3QPUeqx3tpLJVnTTB7zMlYSTCAy28KMFpM7GhYhHCSbEJzRAQR7hh9GTMq41sMOLkQHmGaHmPi0DEVrNDaPzaR1nPQkA1ntO2GrVOVPoD+qUSBrouQ5EeU0K7bLDzTOq3ug+v/ZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlkU2dROGZGRU5HMWZvTzRDbGpMazJaZHBvWll0R09LaXFOQjF1QnYvWGlZ?=
 =?utf-8?B?ekhOSDgxVW82Tm9jVmo5cmQzVlZXWC9MUWxZcFh2NGVGbUFja0JndHJIaGlp?=
 =?utf-8?B?U2xvNEhiSWZ4L0ZzemJCZnlFcCtzZjFBeHBFaEpZTzI0ajhxc2RQYjlIUVkr?=
 =?utf-8?B?YUFhTE5xbkRxUjN4QzNDU0pabkJLVCtMTi9zMzQ0bVBrMTBDSTl5SHFhYmlo?=
 =?utf-8?B?ZWZxZW9JUmh1d2NSVC9XclNUc1dyaWJmdWRkbVF4SDhrLzFMUzhTTVVvcU1h?=
 =?utf-8?B?blUyUlRsM2U2by9iZFBtYWdldHlKWXdja3YyWmp6NlBFYTBGczlCK3ZDa1V3?=
 =?utf-8?B?UW94TU9ESUR0MEdaemQyWnhIRGFhTXhSOXIxY3lKbUxYQUtMcnlnZEg4cmEr?=
 =?utf-8?B?Rlh2V2w2dngwdzkrZE5FeXVQcEJkdTgrUzcxcklYRTlHV21UTHA1bUdIaEpm?=
 =?utf-8?B?T2JLMWp2cXNtZENGWVNBOWplL1hadUlPMTNNelFqeExrWUh3a3ZWeEYyVnBN?=
 =?utf-8?B?R09IN2taMm1UcUgxajh2OGt0MHVHdFVoZUFqY1ZCOUI0bUVyb0I0RVhqSlJH?=
 =?utf-8?B?MnZqNXg3NjRibGhudE1sV3BFenk1ODJIK2lqMEhaS21idmtKUjBSZjJhSm1s?=
 =?utf-8?B?bDFBVU5wU2Nqa3h0M0dXNk03eWV5TE9CV0d3NEFadVdrSkp4YjJUNkRoVDd0?=
 =?utf-8?B?LzRCNVFYWksvaksvU0JXU2IvUEJuUFR3cllwcFZNR1Zzc0ZieVBiUkdoRWMv?=
 =?utf-8?B?OHVOa010L0o4WnNqSGRUaHZ5UW0wT0JVNWlSK0RaSXFVZHVzRW1vbmIzNnZa?=
 =?utf-8?B?eVRCaGYzNFBEa1V1bGVFQzUvMG4xMmZoVURiMHppSEl4STRZaXljZDM3ZTU2?=
 =?utf-8?B?cVY2NFRaMU80L0Q5aFVhSnN3R2dGb0o3MThpNk94bkRxc1RqK2NMVmlyTGdx?=
 =?utf-8?B?UlduM0g3a1J1eDJNS040Szhwekk4SUIrcVF6UldWTU9rcU9TclAxbDJ6TEl1?=
 =?utf-8?B?MmRXeTdsejI0SmJwM3Y2RGwzbzd0SnpiWUFablV1N2NYUm1icDBDbzRSSXN2?=
 =?utf-8?B?Zk5oV3g2N2d0UE0yaXBONXVRYk1ZRHgvSG05bW5jV09ld2JXbWdxMlU0QlRZ?=
 =?utf-8?B?ZmYvSGh0NEhqZmtEM0dYUUhsaHBkT1I1b25FamR0ekF6SG5VWlBoYU9GZUdk?=
 =?utf-8?B?aGJVaTA5Z3oxSXR3MGpKQ2dFRGdleGNyTktBeEhESTFScEppMHluR1VoV0R1?=
 =?utf-8?B?engwSHdKZ0FJazR6eThOSTYzZmQwalp4YTBDMk8zZ3ZNV200VWNUUENkMUsr?=
 =?utf-8?B?TzhzRlJzZVBIQVF6aFhqc2VsZ1QxTnp2TFh5QXl2YjhydkVYOU40VldtLzlV?=
 =?utf-8?B?dmlsMGtlcVdoeDl2ODJwbUlyVkxKT21CS2ZTbmNuTlhUbnRlWFlzUWt0VVhx?=
 =?utf-8?B?T09HcVZkajNFUld1SnF1eHRHaDlFR3pFcXd0aGNxck9ybFptTUlZMlJpOUJq?=
 =?utf-8?B?NTJYK0NBTWMrRnIrQXRubHpCWCsyMFB3dTVUb2Mxclo2S24vWlRvSndxRUh6?=
 =?utf-8?B?VmRmaU9pTEVyM1dYUE9tRHBSeXVIUWs1MzNZb2V1MmV0Y0RoZG53SDR4c1Vo?=
 =?utf-8?B?ZlArRzBDY0tJYTBXMDQ3aDIzTHpvSVNCQ3lTTmNPa2gyNzBYcHFyQWhPZmFC?=
 =?utf-8?B?ZUJWRllCazdzOFFLNlV1b2NvQlhFNDQ5b2ZCbE5RTkpxL0RrL0JQZWd6ekM2?=
 =?utf-8?B?b3o1aXNqSEp5YVlsVWpvS2hid3ZkS0VFMEtwait3ZkdXcWQwNmE1eUwxRVNW?=
 =?utf-8?B?eEhGc2JxcUlFYlovT09YclJZeHFyR2JhUi9BMUc2M0xRV3Vrc1d6ZkU4WDlG?=
 =?utf-8?B?dEFWZnZPNFZTWkRGeG94M2plRGsrYm91d0ZMSFYwbDZhaEcwekE4TThTTFRr?=
 =?utf-8?B?bm5nNlI4Q29oaFg1WEJZVUNUcnhMaitpeHByUWlOS0o4eHVrUzFEY1EwaExa?=
 =?utf-8?B?YzNLTG5NNjBiZmNMcGwyMFFjanlmc1Nsa2VKV001QlJ3OTZEaUw3Vk1UWmFC?=
 =?utf-8?B?YnRWVVdXQldEbzhCRTErbCt5aFRpZ0pMN1cyT013UlNqSnN0Ym5BM2tLaFlm?=
 =?utf-8?B?ZVpzY3BSUXE3TXRJTE1pNjgrUzJ0ZjIzeHlXMC9Wak1kK3FJa0dCMUI0dlVa?=
 =?utf-8?B?ZnZtTzV6YkxFTkVhakZ1d3pOTHpNZEVwMVRybVkwY0ZVYlBGdjBOV0hUOXBH?=
 =?utf-8?B?bGw2cDN1emlIVU5xK2FMNm9xZHB0YWV4cE84WEduSGJGaTVsNFVlOFcxUHpU?=
 =?utf-8?Q?/GcYDWbeVRhEDpbUnS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db39a21-271a-4c13-7c1a-08df051bed55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:49:21.5384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VvyW1c0LM+Jj8uJErI5yXx0pMuwQONkbQgTrUykN/azmpPAZHJz+uRFBtEb76Rn2qmZ/GwLiFo1+vCG2rm5mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=tdave@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 8/27/2026 9:38 AM, Ard Biesheuvel wrote:
> 
> On Thu, 27 Aug 2026, at 15:47, Alex Williamson via groups.io wrote:
>> On Thu, 27 Aug 2026 09:18:50 +0200
>> Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>>>   Hi,
>>>
>>>> Following the feedback, RFC v2 keeps PCI enumeration and resource
>>>> assignment in firmware. QEMU only validates the user-provided fixed
>>>> BAR configuration and provides the required metadata to firmware
>>>> through the "etc/fixed-bars" fw_cfg file.  
>>>
>>> qemu already has vendor-specific pci capabilities.  They are used to
>>> pass hints for the bridge window sizes of pci bridges (including pcie
>>> root ports) with hotplug support.  See OvmfPkg/PciHotPlugInitDxe/ for
>>> the firmware side support.
>>>
>>> I'd strongly recommend to do the same for the fixed bars:  Add a pci
>>> capability to pass that information.  All the logic you have today to
>>> link the information in the fw_cfg file to the correct pci device is
>>> simply not needed any more then.
>>
>> Placement of a VMM defined capability into a vfio-pci device is not
>> such a trivial problem as it is for emulated devices.  Space may not be
>> readily available and the capability may mask non-architected registers.
>>
> 
> Is this the reason we cannot rely on the Enhanced Allocation (EA)
> capability here?

AFAICT, this was explored on RFC v1.
EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL was suggested as the
shorter path at the time, which is what this series uses.
> 
>> Does this suggestion relate to fixing the gap between mapping fw_cfg
>> entries by vendor/device IDs or is there something fundamentally
>> undesirable about using fw_cfg here?
>>
> 
> I much prefer this approach over the previous one, as the PCI resource
> allocation logic remains in the firmware where it belongs.
> 
> However, the OS may still re-assign/re-balance things in some cases, and
> so using a non-standard mechanism here means that the OS needs to learn
> that these devices are special.

This fixed-bar design already accounted for this using ACPI _DSM in
patch 4/5 — fixed BAR placement requires ACPI and emits the standard
_DSM function 5 (Preserve PCI Boot Configuration) for the hierarchy, so
the OS is told not to reassign these BARs.

> 
> ...
>>
>>>> On the firmware side, a new DXE driver, QemuFixedBarsDxe, installs
>>>> EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL before PciBusDxe starts.
>>>> When PciBusDxe calls CheckDevice() for a discovered PCI function, the
>>>> driver returns ACPI address descriptors with _MIF|_MAF set for fixed
>>>> BARs. Two small changes to PciBusDxe preserve these fixed addresses and
>>>> program them into the BAR registers during BAR programming.  
>>>
>>> Expecting PciBusDxe respecting AddrRangeMin looks sensible to me ...
>>>
>>>> After PciEnumerationComplete, QemuFixedBarsDxe walks each fixed
>>>> root-port hierarchy and programs the bridge memory windows to cover
>>>> the fixed BAR ranges assigned to endpoint devices.  
>>>
>>> ... but changing things after-the-fact in platform code is a complete
>>> non-starter.  PciBusDxe needs to do that, i.e. take care that the bridge
>>> window assigned actually cover the fixed pci bars.
>>>
> 
> Agreed - if the bridge windows are not programmed correctly on the first
> pass, there is something in the code that needs to be fixed. I don't think
> papering over it like this is the right approach.

That's a fair point. I did the window-sizing after PciBusDxe because I
didn't want to touch existing PciBusDxe code too much.

As per my understanding, PciBusDxe's enumeration splits into three phases:

Phase 1 (PciHostBridgeEnumerator) walks the whole tree and calls
CheckDevice() per device — by the time this phase finishes, every fixed
BAR address is already known and cached on the device
(PciBar[Bar].FixedBaseAddress).

Phase 2 (PciHostBridgeResourceAllocator) prepares an address for every
resource node in the tree — both individual BARs and bridge windows
alike — purely from size and alignment; PCI_RESOURCE_NODE has no address
field at all, so this is entirely blind to whether a fixed address was
already required.

Phase 3 (ProgramResource) then writes the actual PCI config-space
registers, and by default it just writes whatever address Phase 2
prepared, for both BARs and bridge windows. The one exception is
ProgramBar() — it specifically checks whether that particular BAR was
marked fixed back in Phase 1, and if so, overrides Phase 2's prepared
base address with the real fixed one. However, ProgramPpbApperture(),
which writes the bridge's own window registers, has no equivalent
override — it always writes whatever Phase 2 prepared, with no awareness
of a fixed BAR anywhere underneath it. And that needs fixing, and for
that I have to change the existing code.

I think the fix would be to extend Phase 2's own sizing step
(CalculateResourceAperture() in PciResourceSupport.c) to check for the
already-known fixed address on each child and, when present, size and
position the window as the exact union of those addresses instead of the
blind size-only sum. Does that match the direction you had in mind, or
is there a different integration point you'd suggest?


Thanks.
-Tushar




