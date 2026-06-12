Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E36ECD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY8tM-0003Ow-0g; Fri, 12 Jun 2026 16:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wY8tK-0003OF-Uo
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 16:54:14 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wY8tJ-0004Wu-GI
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 16:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDs3vms0zAbJ6r54hMBIwaEu8QscYQytajPPdlZ6+GnHHOLUtaY3daBbSB8a8nfMH0B1LsxQFFCmTKVJXl8EO94NoWy0cofS0jwrcncdwN3GPKiKOSBomognUCpHxvaVr48JTRpfgjOVE3q1SzYt+p8o2Rfn2QAwUhaNSdOfOStFTON4ceKW/fY2eff9OQ/rsmbFSoFhgj57oi9xSrw2ndjrN/xuxUXkkUf2tlkmGf0iWgwFQkHK761RijAGle5E7T1Sx90xZEGmV5MqeaM5YX/1Ko2kMMd82XLXyG+zpVerOef04qQ+phO2zVF+Mcxtl9r4qtV2t4bifrbld5jckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZrt4fC/nEXOAKh07xGt2vE0ryk6ngEwgk61RPlLHAE=;
 b=Igk20PYEnRlmV4NN5C/IkF2q1VpjDM9KGQ6EemrXtayp7i5M54cswbB+iNFY0lGY1uP0tlHa8ErPQ0ZtZR9Q2pS5uB4e/6EjtgI+X+7shIMZC2ivKig/RDg1nwWfwxBIoFrIV6eouideRXn6wp4onvkhLmHPlTrLU8bfY9HFaKo/OcojzrMUy6nkVCkEqwgZgEH87GrFWoL7gOEtcvCW6o3WxwhbbmuKfVuN9l1HrS5HHikxCtlHSHpi2JwxJw98tg17ptFwOjNHiC4VRhlqFCoZS8gatQnJWtiNatNyFQbhFlERtStf1Nba6mA2UdcPGpUBGC5ae0RcUi7lkYC3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZrt4fC/nEXOAKh07xGt2vE0ryk6ngEwgk61RPlLHAE=;
 b=ITTkax/LZ+3w2QqNa9Z4ZvFAPylwasFbW/RzUXGuYw9m047w5HBbOcfrTR8I/vKQ7cbOZeU6zTgrZwpa20XVvl5RVncvMYVT2dvIaIb/8klsYnbLH9ql2Vg2cByiyEbcCVS1+jH9Tk015UFPZQtsk+h5laIFtco6K9cxNfk2Z2fE4Lh35eJ2t9FW3ynNyfkg4HLKL91UZbFACyv8o1VA2jed+Tds/RmLTINE3r1vIfSYEbRIPk05NtHw0n5TbsAQtJDag9rtHfCPhGFKPkFaeed7W9pEO+z3Sp/N3Wq6EmH+A1RrJKddB2xfkusoSAtdLOw8j6DCLrew+swVeJ/HsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 20:54:08 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 20:54:08 +0000
Message-ID: <932f0b51-3120-4240-847f-3637beae9c76@nvidia.com>
Date: Fri, 12 Jun 2026 13:54:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] vfio/pci: add vfio-pci ATS control property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <981b9398-6da9-4862-a5c6-370b220b2bc9@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <981b9398-6da9-4862-a5c6-370b220b2bc9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::27) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f972561-dce7-4692-156d-08dec8c4bf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: s657AaBNk4d8+3yt6fV3GAsSD8atdkT+rStIIAWe4GbYB+0vU/niTQCzfmzNgASX9mVCpobbJFTDw3j62iBCsWP6BODmpKzjVIw6PFFxnNUejDZ4weNLN0gZQHdWtIPRm3BC2QEd7GwgXTJyT6wosXZBy6WIq6UNcvfa3JrCTgu8yA+1sJCeE1Sp7HV1cTwJqeWL/1GOg6YEQL590Q18u36STOO4UyWLC8mDT6SQynrEEEWpse+QThIkcXmbdU96Ok0pkbZtzqCmpuTy23aV2mN3MGSXbTdeej/89mRsa4h1Qbty7vRfl77oHQFgLIafxdLjQjLW/aEZAyw5wIYDDVTB39lqTuWJ0ZjonJKqm9HqFlA5WgvSS4gzVqKcXDm/qW2wqN9gULj6NKQO31tuzbqcLWOVxGxUJxNZsmRT5gr0ZUYz8cDFdTqEHeF0JEw8edxU2wXYu14xHynjrqI/TG25RzL/M0qE4jPQzVyUvSe82+/U1JpA1HDotV3HjBTyGCXU3IslmBG17Xt61+740h0qFT+mDXoehOL95w8GDSeC0krb7V8q5Rrs+M0Aea/LEF8dS5uwFaKqkm7HXRqDuc9CE23JUV0ujCoOJZKqiyB7p+lz7+/LqO8d2msrHNALu/d3ZSQKzvsT+/Y4DXT5fc3nKGFdfwenQch65lGrjFNhJbTlI0Pw0Oib+Z0wxUFE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1h3LzJLcjVSZFlxaE5kWFdoSlhiWm1FSGE4UUxVY1lSdENxUjU2OWFRbUxY?=
 =?utf-8?B?NXBzL0IyU2s2M0R2aWswSkM2QkR6em4yVjRQblFGNG1iZzdmNTN4VFQ4YjFw?=
 =?utf-8?B?R1lsNGhSbjFwaFZmRWVsYVpDRngvQjZpbjhQQVRPK1lsd0JQUWVmMmVzTmNB?=
 =?utf-8?B?YW5BYmwramlRSFVqQTJmNDF5T3g3ZnJGWlQ5Qk9vRXMvYS9QT1RtRThPQjcx?=
 =?utf-8?B?V3BNNURxRExEUjIxUnVxSzFCYkxnQ0p1dVpQQUVnTzNkTktnZUVPNm9pc0g5?=
 =?utf-8?B?UFZ1REpzTkpkYURoWHFkVEswc3JmSGZCT0F0WHlVVzRTdTN4V0VibDlBbU9S?=
 =?utf-8?B?K3U4SjIzSnIwMWZ5cmdzbksvWjZXaXlTKzhROHUrSHE1aTljbmJ0WWhIMGs3?=
 =?utf-8?B?Yy80YTErakN3VklsOENvci9oeUdyQXRORFp6N3ZuY1o3M0FKU0lOUFRaQWlQ?=
 =?utf-8?B?MHp4WGRWVkMwSUh5d2RPcVBoUE5Qa1B5cU5BSVN1aTZKLzFBeFNEUkFQQ3VW?=
 =?utf-8?B?dTFQR3RpaTFaOTRvb1FDR210Sit5N0YrdmZxWGtQdHozWk41TjZPZlR1c3Fx?=
 =?utf-8?B?aUtQSFRQa2E4R1REZjhKcmhTcWJVRVhlTXAvVTdncjI5VWRWdVVHM0I5NXdM?=
 =?utf-8?B?anJSOW81Mi9VUHdhelNVTmZvUlNXZE5PNDRIMFFtcDkwRkdrdzNoWklhdmNl?=
 =?utf-8?B?UlpRNk8yQlJKSStiSlVHcXVWZWpBRXBoSVcrVFk2dmZtNWY2RCtWeElOM0lM?=
 =?utf-8?B?amxxcDhqeDh1SHF3ZDM5aEloVHlzN3U3L0EyZWJpR0pqampXS3Z2WEYvbzZm?=
 =?utf-8?B?bWtFK0lISE5pRXNXcHppVUJLSVJmQ3FXYTBJL2p3WmFtTmd6cEZBTUxhcHJV?=
 =?utf-8?B?LzA2Rm5DMmIrcXpmYW0za2ZGVlZSWjhXbFM2U2E2VVB2MjRCckZWRU9TWTBZ?=
 =?utf-8?B?WXNwN2NiUHZZMFJ6UzJBQnZlRzZ6NGRNZ1ZTMi8wYmVZVTZLNjlBUWpNaU5E?=
 =?utf-8?B?QzhyLzZVWXRtUGNVeUhCQ0o4R2ZPaEU1eFdDb3I3eklnZ1FZUmVlZ0NlSThB?=
 =?utf-8?B?QUtpMWNqak1LVHFTSVBFNzJPOE5RRnh1SDUvWXpOMnVpcVVDQmFjMnFmeXkv?=
 =?utf-8?B?T285VlB3VFRBTHJWblkrNUd5eWEzK01maDJTY1VVT1BPTUZYSHpMTGdKbTNE?=
 =?utf-8?B?ZlVWODJwdWFzdXgzdFB0endncURRYlhRVHFyNEl1UmlWNE1reEl3cnB1NXlk?=
 =?utf-8?B?M3kyT0NnUUFIWnp5QWVVRW85MlB4TVBLZGlobXBRZnBBaHRZajY5R1o3OUFF?=
 =?utf-8?B?WDluNkxLQUpCdzhOS1hMdDdXRlJxaDh4d1I2cWxLVGhRM1NxMGM5ZEpkMlEy?=
 =?utf-8?B?UHUyTjFlT0NLL0NHSjhTSWxHYUpaSk9tb2hNNXBoNXgza0V3c2kvL2pOS05q?=
 =?utf-8?B?VjFiTjE5YU9QOWkzcVN6eDZHZG1ybXZLYnZ3WTREWVovckZIRUJjR3lMUS9w?=
 =?utf-8?B?V2hxd28vanJwbzFrMDFrM0hXS1dTNitBMndlTmFxdVhpNWk1RVpTRzgyeU5Q?=
 =?utf-8?B?N3ltS2VIMVFNUnVnVmp3dks1THFYMXRXaVdMeTZuQlI0bGF6ck9icFQ2ZmI0?=
 =?utf-8?B?UitJQy9mVm5XSmdXM2VCRkpxZlg4VlFwL3J4YUlqNVg4dW1jNFVlOWpjQUo2?=
 =?utf-8?B?anRSTkptSk5oaW83amFlU2RSVVQzZkFLZ0loRXRvUUFhMzg5UFAveHhBb2ZW?=
 =?utf-8?B?aklvVFhUSjVRSklpck1rNi9aQWZkb1A5V1hvZU1pT0Z3ZzdYaXR3dVFMTXhT?=
 =?utf-8?B?TGJwRkcxeUp2L3BxQUp6N1ByTlliVFdDeThiN09tcU1lRDJlWU44RHNZelky?=
 =?utf-8?B?cGdVMUFjWUlyVXUvN055bTNxNDJvRS9UNENjWktMekZ5MmtjTmpBejNSNEVL?=
 =?utf-8?B?UkRvNnN3L0o0eS9QdFNFZ1VNR1FqUi9wZjBjZEcxTnB5Q2hHYTFjcGxxTXRl?=
 =?utf-8?B?TFVyQ0c2czFGaHpFK3ZWSmk4d2JWSmZxVkhzL29XcGFqdEY0dU1CZlpRajBD?=
 =?utf-8?B?aU8wemc3UjRBWWdHRG5FUDFxbHlaOHdNRStva1JCNUlpSUNESnF0TnRhWE1X?=
 =?utf-8?B?VXZhbEZ5TFRPdjZyUlZaOUhzMlpYSmdaeUdhQXA4b08xT0lUSW5KRUdhMGdF?=
 =?utf-8?B?bkxSeTYwd3luYjl3Qy93ZHFFV0ZlMm9WUEQ5S05FTlBJb0tEaFRhTmV3elRt?=
 =?utf-8?B?OGlLcGtiWWZOTlZ0dDJGemZ1TktINklSZmhuTDE5dytDRzBmTXcrTFpPSDkr?=
 =?utf-8?B?K2lMYWdCUkF1T0lpZ21BZjloS2Zka3JDM3hkNDBhSlJVdnJLWUJOdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f972561-dce7-4692-156d-08dec8c4bf2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 20:54:08.0942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uByS/pqXVhL7dbfxcFsD/LF6ROcIRxqqS68sWgPOPVLwnNPjxia5x4aQtD38MwxxVyUipZgQHaA6KG0ZJD5Vvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nathanc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi Cédric,

On 6/12/2026 12:56 AM, Cédric Le Goater wrote:
> Hello Nathan,
> 
> On 6/12/26 03:43, Nathan Chen wrote:
>> Hi,
>>
>> This series adds an ATS control property to vfio-pci and wires iommufd
>> support reporting so vfio-pci can decide whether to expose the ATS PCIe
>> extended capability to the guest. This series is a follow-up to the
>> previous patch included in the "hw/arm/smmuv3-accel: Resolve AUTO
>> properties" series [0].
>>
>> The new vfio-pci property is:
>>    ats=on|off|auto (default: auto)
>>
>> Behavior:
>> - off: always masks ATS from guest view
>> - on: requires ATS support; fails realize if kernel reports
>>        IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>> - auto: masks ATS only when kernel reports
>>          IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>>
>> To preserve machine compatibility for older machine types, this series 
>> adds:
>>    { "vfio-pci", "ats", "on" } to hw_compat_11_0.
>>
>> Please note that no linux-headers sync patch is included in this series
>> because IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is already present in
>> linux-headers/linux/iommufd.h in the current base.
>>
>> Testing:
>> Verified ATS capability visibility changes with vfio-pci ats=off/on/auto
>> on an NVIDIA Grace system:
>> - ats=on + ATS supported by kernel => propagate ATS extended cap to
>>    guest view
>> - ats=auto + ATS supported by kernel => propagate ATS extended cap to
>>    guest view
>> - ats=on + hiod_iommufd_support_ats modified to return false (mimic
>>    kernel-reported unsupported ATS) => realize failure
>> - ats=auto + hiod_iommufd_support_ats modified to return false (mimic
>>    kernel-reported unsupported ATS) => ATS masked
>> - ats=off => ATS masked
> 
> What about ats=on and no ATS support in the physical device ?
> 
> I agree it is a bit of a corner case. A warning would be nice,
> it can be addressed as a follow up change.

Right, I had missed that case. I will look into accounting for it in the 
next refresh.

Thanks,
Nathan


