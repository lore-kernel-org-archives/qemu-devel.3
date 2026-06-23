Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED37CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc7ja-0000sN-Jf; Tue, 23 Jun 2026 16:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc7jZ-0000sF-4y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:28:37 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc7jX-0003IT-8P
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:28:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjZRlTkA8IO37Pqd5U+akFN9m7LZKOj4tk21H1WBc9qHm1rPDpVwAw5fhYkRsVTp968EFq2FBP6K2yzqz2PV3zzh0xJ4x7qAth+jLF/1PuvSa0kpY4arYZ4LUo99CmvDEKd0FdIUpY8+rzbJiyR/3eLNNzQdqbNjeBnoAhKbH+7xboiH0ogxmwkaMDNtQ2uEyfujHLtQMT5r0+OHardRK7e5ZTcp9OSEeKd9UAQ6sq0MoRHD/J2miz4VyvCJYj9ZKgXFWPUg4ziYVXJHf1GzTpRvY+T25t+fYqB5b0QYeEMCYL2h+SJ0yAKBybNznedniOG5/Jc6QJTJHT2maOZHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWth4PhzQkOEnmmrj2T9w8aGIPCN70xiYXbesduQjQo=;
 b=pUvssehkajXJeJ9NUTYyoUCTPqMeGUHBLehQUljfGaGCY7RuaOI035FbJ9xtVQQskRR2lWS+xMcy0WOsKLcGVBg6XcBLXi6LQJ88SmDwlGgDadUAfF2DybpnlIBEluTX/G0jJgjXeu3L65SK3QUjBBpl5bztWjJKDLU/b4LrlCcYHWHhnLkWIgHKbu3f0f8rcRs9UFZ68TY6LSj0QHwtbNM15BBr74aZLkdM1V76kP6jp/+jeghV8xogpYZKZlYinUUL9riencNcYy6lc4GPMV2DWKR28lx8sVxEt8VyjZRDJDoCECj6BDOfdmpT+BBOXNRLdKJBO20dfdVKA34UWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWth4PhzQkOEnmmrj2T9w8aGIPCN70xiYXbesduQjQo=;
 b=eWmczvCm9tZgT+w5u6JHMv+3HElfEzidAwpXZ/iUv6PLgwNu0s5bOWtw5ugDBtC0Ax4FUr6uv8vHMGRWX0MrX+0WUZnCMj2pC0SzksQzc1Gi3TihRLJRF05/ZeDVzexIem4uYMPf4gGRLNiVAyZWdKAYBOpNxRWryOfLvIlf0dE7wArrGPFRxJ7tiR6whSCpW07IFmeLwteOi0kvBM5kvgS/lk5c+Mnj6F/e2KIxnsMJoCAGTnAC5DOU0C75c/58q0nLXFZ4kI2Dji9rwujao0UkuCHvQ20/0P3PH9vOUndgZaUpKpxNONwNi9pBJY/PsdO/9pMu7LuEDX+u43eOeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 20:28:28 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 20:28:26 +0000
Message-ID: <ddf66baf-6208-49f1-a6b7-e9d74be2878d@nvidia.com>
Date: Tue, 23 Jun 2026 13:28:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vfio/pci: Add ats property
From: Nathan Chen <nathanc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260623023540.836825-1-nathanc@nvidia.com>
 <20260623023540.836825-3-nathanc@nvidia.com>
 <SJ0PR12MB8614F88365BE0F4362ECBF84ABEE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <e352eb01-caad-4725-8b14-710c8960fa82@nvidia.com>
Content-Language: en-US
In-Reply-To: <e352eb01-caad-4725-8b14-710c8960fa82@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 4052f32f-48f0-4677-6012-08ded165fb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0MyEJrt7JZoUC5fziqUgdr25g+1OkGB4taBpKwDEPF0ODrIE+RqzyDmft3qNib59YrEpofAfP97pnczsAeplguC974zGaGSNkuwDaOyFCGOSzF0+R2ImQ9LZ4TAeIEsw+OI9ZJA2Gk8CKImzGYDy/fVN46C35t1Dk7ldZ8AuEhFcCtOUMpzSo4gLYf8+RksNNgEc+b2UCtsRw8oEEEGPeM8tsvGDW5HIOeSjnR40o3UIWDpzODWgNBc7fSRWGTVrhl4enE8tFKLHXvyDmXeLPMP70UMsjjtW0waxV0IbGROhMUmBnYvD/pV4ex/3MWW+LFpS0EoDTSieBmBbYkxwSzV4FDb9acmScKZ96NikQ13us4/oCW8L+BvFbX0mBpFauxqCQ9FBexsO9yILpQBmjtFztFtdjK7CQzhtAO7NrcTYkBkADKvPBW4ZQBAXcj0p1KEthNeTh7bI0GEX0vHtZhU9UPuo0IEWA7la6vB9dJDHzFMd7VvHKr7uZQIC0t9ePuTjns/H0Rt1jrWOc2D/IBlC5dSqOMDf9Fd77bzRlU90+RijMJwa4Ya/42RBgZxw/FsPRQuqEQ4AwwkkS9B541/4CcfghBl6g1yaaeXCDURiW1o/rtuxYh/GHACiNjrIn0MBBwzfVAnlauzOh44hJzGJ3O/6BuPMTxGuvn7V2eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXYvL0tPRGhwK1lOUTErREJIcGpMTXhiME8wcjY2c2VyR0Jkd2FubVFlOUI1?=
 =?utf-8?B?WCt4Z2g1cmdPeW9WMlQ2bFV4VGtjL0tFeHV5ajFKMnVOZFRodHY3cnFWd0Nq?=
 =?utf-8?B?OC9zTlNMWmdFWUMzeFU1YVVMbW1Od3VUaTZXMXQzVElRcUNXSE5DcFl6eUhD?=
 =?utf-8?B?QTVuK2R6RjU1bnhXdGpTcnFVSTNjaFJEUHB2eFZsVlBvVjA5TFZRN04rQlgy?=
 =?utf-8?B?WklaUEF5cVA4bnl1V1phdzJjbVd4QVZ1NmhmRGVFSHpWTEwxVEpYQytLVnJm?=
 =?utf-8?B?aWh6WERENmZicEN3R3A3OTdpdCtzam1jaTdrQkhkUDJhMzlVT0tuQjZpSmlY?=
 =?utf-8?B?YWl2MWNQRGpaMGV0a1FuSjVGbkRWc2ZjbkQ3R2tTaXNGaS9SajQ1Z2h2N2xN?=
 =?utf-8?B?ajVvTTlEOHlYYW5rWTlxQzFJQngrZVIvTzVHT29sRkYzTlBLckh1UHhkY2h3?=
 =?utf-8?B?TFlNdzFDb1MwSEU1dURuZDA2a3dtVXk4emNyR1RYRTVvWTFrd1VFRmlzSjE0?=
 =?utf-8?B?a3NPMjM4RHAzd3JrOERtb2M3ck9EVTR1UnVmOWdXNEZkQ2doMXZEbU1YMFVF?=
 =?utf-8?B?T0p6RE8vRlBMZEJYMFdmWEc4TmRaN1g0d1dpTnlteTlrWVJWNW54ZklzZjFO?=
 =?utf-8?B?OFZsUks4SXR6dnpjdWRFazdTdzVpNmhIaTk3WXI2WW41OXhHbThwOUVuQ3JL?=
 =?utf-8?B?OEZOZGV4OFVpUlZHV2Q0ZFpXcHFJNitwNFBKZXZtR0lCZ05uUU1yRitNQVVK?=
 =?utf-8?B?MnFrQ3NhMTR2RCtzNWJ0NkRna2dxVEhJeGZuQXRFSkYxRVNCUi9wZE1seDhW?=
 =?utf-8?B?cEFnZ3QzeG1qeEp5YlVPdkhOYU5DWjlhNFVlWlFJbS9Va1Z6SjBYZVlBYTdj?=
 =?utf-8?B?ODZ6L2tOTmlHQktjcFM1VjE2eGVHeC8rd0pldjhPODNUaUNGR1ZwdEd6eW5a?=
 =?utf-8?B?cXI3Vncyczg3TjlBZzAyQ3Z3VjliN3c2U25LV3RUYjk1ejdCSU5oaTAyZm5V?=
 =?utf-8?B?K2M4KzJiZ3FlOTdqZjJZRXBwa2lCT2k2VWZYcTk3RThTdEszRS9XUk0rbWpH?=
 =?utf-8?B?V2NqeXVVeEIwQmhSTDc2dUZSZkFhVnBPajBJaURSTjh0c3gwQkR6WFJDdmZW?=
 =?utf-8?B?bU9rNjZ4RE13RUVNanNQVzZnLzNBenkzOWo3SVp2bWZ0bTQxZDMxLy8zSkhu?=
 =?utf-8?B?MlI2SGNENlczWU8xUFp5TGwyeUFyMmFONEpVMmp4c2pweTFVcTZiMzluTFNa?=
 =?utf-8?B?RjdxUUw3RUJDWExuRW9mQ1pDR25ab3JLQnpKcU9hbU81ZW1GRHEyb3JYSE5J?=
 =?utf-8?B?amJYQjVrdGxlcm44NmtNTnFjdENOZENManJjaU1RSjFPcmtVTzlaU0tBZjV2?=
 =?utf-8?B?RXpiN1BBZVFDaGtMN0Y5alh0MnZsaFNmeEZabnpFc0ltSkZjMXl1RUxvRWtB?=
 =?utf-8?B?bFV2bktuR0Q3bENXOUtKUTVBMUJrdUI1MWQwakNXMUJHTHZzL0ZGQkU5c2lp?=
 =?utf-8?B?SFFtRHFzV2JFRkFDR2hmekFiSDRmckVFR09qRmhZRWJncldwczh6Qm00R2pQ?=
 =?utf-8?B?ME5kVW8rYWJnTmptaW5SSzhGVkxvVXJaZlBiYmplNkY3UGRIdDQyL3RpY2p4?=
 =?utf-8?B?bEdkMHI2L1Z4RVZmSmxDVDNXNlhlL01SZmVONEpJTkRCNjQvaHJxOXZhclFu?=
 =?utf-8?B?K2h4anpmSy9sa2FWS3FsTkQ4Y1FwcTdtYXZLcVBtSDc4UTl1Tkdtb0MrU1Iv?=
 =?utf-8?B?MDAycHdycHl0emlIamdON3hOdnRIOGM2eDdvUjhQczZZVHRJdzYyS3hPdHZa?=
 =?utf-8?B?dVlKL3I5SEFGK3c4ZldrNGtUTUdBSFowREJzT1BneVBRQ2F1YjkwNmlweDJL?=
 =?utf-8?B?YWJtRXZaVk1yM291NXQ0UDcrMkJtQUJZT3lsUE5EVFoyTWtLaTZhc1RvSEd0?=
 =?utf-8?B?T2hrc1ZVRzNpZThVMytVZzUwMDJweEh6MEloNVBTamJrbHY0NTRZL0ladTdX?=
 =?utf-8?B?VnJaREFDQ29tVUZIRks4eG1FcmozL0xXUDdZOXFELzZhUlVMQ2JkV0UxclY4?=
 =?utf-8?B?UmMvaXQxcnovaFlvWm81QzRHYTRBQXEwRGpQS0RPVllnclB5djUwZ01hbHp3?=
 =?utf-8?B?Z2FSK2V5di9oV0NlQlJVSGdYY0dBMzU4V1A4cmg4MDhjMHBnUzJETStydTZL?=
 =?utf-8?B?QTh3N1VFaGpvL1MxTnc1UFcxSzh2Q1Y0UU55U1RtbS8wMTBLby83cE5uZmpC?=
 =?utf-8?B?dnI4a2pTcWsvSDZLNjYvUlpBdXVoQm0wSWF2U29tU0pHbC9iRnhKYkZjNnpS?=
 =?utf-8?B?TXBZOVdSVWROU3dPemMwZnVhVm5lQit1U05Nd2lTeE9kQWNpdGkvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4052f32f-48f0-4677-6012-08ded165fb11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 20:28:26.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cw//sRro2ZUhwdx4bgIh/3wOMEZ27tZJqpfnQjqxZdmUWSRc53uudzxsb1PZg5U35fH7DruoTenQ4Z6CidDTIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nathanc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 6/23/2026 12:29 PM, Nathan Chen wrote:
> 
> 
> On 6/23/2026 10:01 AM, Shameer Kolothum Thodi wrote:
>>
>>> -----Original Message-----
>>> From: Nathan Chen<nathanc@nvidia.com>
>>> Sent: 23 June 2026 03:36
>>> To:qemu-devel@nongnu.org
>>> Cc: Yi Liu<yi.l.liu@intel.com>; Eric Auger<eric.auger@redhat.com>;
>>> Zhenzhong Duan<zhenzhong.duan@intel.com>; Alex Williamson
>>> <alex@shazbot.org>; Cédric Le Goater<clg@redhat.com>; Matt Ochs
>>> <mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Shameer
>>> Kolothum Thodi<skolothumtho@nvidia.com>; Nathan Chen
>>> <nathanc@nvidia.com>
>>> Subject: [PATCH v3 2/2] vfio/pci: Add ats property
>>>
>>> From: Nathan Chen<nathanc@nvidia.com>
>>>
>>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>>> extended capability in config space but we should not expose it 
>>> (ats=off,
>>> or ats=auto and kernel reports
>>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
>>> the capability so the guest does not see it.
>>>
>>> If ATS is explicitly requested but not supported by the kernel, fail
>>> device realize.
>>>
>>> This aligns with the kernel's per-device effective ATS reporting and 
>>> allows
>>> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
>>>
>>> Emit a warning when ats=on is requested but the physical device does not
>>> advertise ATS, since ATS cannot be exposed to the guest in this case.
>>>
>>> Suggested-by: Shameer Kolothum<skolothumtho@nvidia.com>
>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>>> ---
>>>   hw/vfio/pci.h |  1 +
>>>   hw/vfio/pci.c | 88
>>> ++++++++++++++++++++++++++++++++++++++++++++++++---
>>>   2 files changed, 85 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index c3a1f53d35..f2934f2d84 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -188,6 +188,7 @@ struct VFIOPCIDevice {
>>>       bool clear_parent_atomics_on_exit;
>>>       bool skip_vsc_check;
>>>       uint16_t vpasid_cap_offset;
>>> +    OnOffAuto ats;
>>>       VFIODisplay *dpy;
>>>       Notifier irqchip_change_notifier;
>>>       VFIOPCICPR cpr;
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 9c06b25e63..c0436b4c04 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2546,10 +2546,58 @@ static bool
>>> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>>>       return true;
>>>   }
>>>
>>> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>> +/*
>>> + * Determine whether ATS capability should be advertised for @vdev, 
>>> based
>>> on
>>> + * whether it was enabled on the command line and whether it is 
>>> supported
>>> + * according to the kernel.
>>> + *
>>> + * Store whether ATS capability should be advertised in @ats_needed.
>>> + *
>>> + * Returns false only when ats=on is explicitly requested but the 
>>> kernel
>>> + * reports it is not supported. Returns true in all other cases.
>>> + */
>>> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
>>> +                                                 bool *ats_needed, 
>>> Error **errp)
>>> +{
>>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>>> +    HostIOMMUDeviceClass *hiodc;
>>> +    bool ats_supported;
>>> +    *ats_needed = false;
>>> +
>>> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
>>> +        return true;
>>> +    }
>>> +
>>> +    *ats_needed = true;
>>> +    if (!hiod) {
>>> +        return true;
>>> +    }
>>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>> +    if (!hiodc || !hiodc->support_ats) {
>>> +        return true;
>>> +    }
>>> +
>>> +    ats_supported = hiodc->support_ats(hiod);
>>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
>>> +        error_setg(errp, "vfio-pci: ATS requested but not supported 
>>> by kernel");
>>> +        *ats_needed = false;
>>> +        return false;
>>> +    }
>>> +
>>> +    if (vdev->ats == ON_OFF_AUTO_AUTO && !ats_supported) {
>>> +        warn_report("vfio-pci: host kernel reports ATS unsupported; "
>>> +                    "ATS capability will be masked");
>>> +    }
>> This will be slightly misleading if dev doesn't have the ATS CAP at all.
>> Isn't it?  I think, the best place to do this warning is below where 
>> we know
>> ats_cap_present is set or not.
>>
>> Thanks,
>> Shameer
>>
> Yes, I agree it would be better to put this in an else statement after 
> it is verified that ats cap is present.

On second thought, placing this after verifying ats cap presence would 
be better:

if (vdev->ats == ON_OFF_AUTO_AUTO && ats_cap_present && !ats_needed) {
     warn_report("vfio-pci: host kernel reports ATS unsupported; "
                 "ATS capability will be masked");
}

When ats=auto, ats_needed would only be false when kernel reports ATS is 
unsupported. And if ATS is not present, there will be no warning about 
masking it.

Thanks,
Nathan

