Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8096DCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEVem-00040R-EP; Wed, 07 Oct 2026 13:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xEVek-0003zX-KH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 13:42:18 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xEVei-0004qd-PB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 13:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkk+mnZXl7ows5XPxyPeXFUGvUam4fXWJztGNCWDdewDT0e6+M4eP+UaqU7TwjbW8ODfTpydK2D1E8feBXKuZvZK+rlDvpXY7rysao5D3wbTEcoyu+eqSv3lTUPJCMLhWi6Ofy4B6plils4P2BJy8BECNlEScg7ncmyrhEnZUHQoB8Y6xX2AiAXoXqmol55EfsNF//j6OS5F6ytHAFEEZrcXRK3oTbVgxAhIH9ZAjVqejI25acr+LS9+0kvrlmYcuEpsQrJfedn1QAXW+pq5dBF2BV9dF+xlToK6LiGpNFLvp7F1LyPnnFStxz5y0tAERHbEVEJazJsKHAN1Dmi4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpsijXhyKZIZ1l0xuSx/wKOTVwXawVxA8rTUXa4IL+s=;
 b=wODLlZoM17ayM/HXK6AKRq05r0PSoDgee8DK5A4KD5Z6xIBzR3nagjKWonl+r42Uh2IaxHmnwWpL/sbld0A1UiJF0Mhg3vtwY48UItyAopFgynU+1R3X4X06KunrKVgZ2cfEojHx2kpN5S7B81shTG0vcrnugQG/09GVp9BpsglztlOTmYIJfVv4IbPrOGjKRrNY/3tOqFRh7bC8EXdsWgPyf85H294yqkZasMw4zggnf6Re4vCIWQK/6wxy/FyiUHX1NFsyXrINdw6gH4WYEtWnddkYFaJbK0VtcGTfE0Jvt6W94WcsLvmpd2VYKIgLozZMw8dZv+VVt4ra+jWqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpsijXhyKZIZ1l0xuSx/wKOTVwXawVxA8rTUXa4IL+s=;
 b=CXKoDvMYI9+dZoE9TJqMOs3i7SRDX9NH50YTP1hChCSbyk3d4DxJbmmnkIou90zyVOmB+N1zBdFo1XBLQqGtz1Xn8x1JW4Zb0MOW7rYf6R09cSf5/2UmdXqZbgRC8ijTT269KG0cgd4sNWYPCGzuc2SFTIsk9pcJ5v1icPvQ17xDysoBGGrtK3JDjuVW5XId0bJiSxt5JIftzh0JekQ0MA7Zg2bXojrPZXEF97YfJsCjUKWMc68fTr/PvNRD1TvMb3YIL0YSGKhAojVwfUcARtq9r8yduQAI9kSl0t47o8XA1RDlPWccssSeIscxPHuLAdhRZhl92Oyh47TBlZDDoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH9PR12MB731475.namprd12.prod.outlook.com
 (2603:10b6:510:414::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:42:10 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 17:42:10 +0000
Message-ID: <a763c5ed-ea48-4922-bbce-8ca0f0d0b7ce@nvidia.com>
Date: Wed, 7 Oct 2026 12:42:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] xio3130_downstream: Add ACS support for downstream
 PCIe ports
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
References: <20261006013133.3457555-1-tdave@nvidia.com>
 <20261006013133.3457555-2-tdave@nvidia.com>
 <20261006004605-mutt-send-email-mst@kernel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <20261006004605-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH9PR12MB731475:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bdc30a-8fc8-4d0e-c220-08df249a502c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 4AWPEVmL0r0+HcfNfTCWT1Crlza1BjRPlCfHfIHMXvmbdXpb1QZNV4k4ra/qoisLw1xhfL3OPPO6CxajfrLRl8HvEHOJWyyjGpGQdrBAvVGRv9kdre+a23uH+aV2PlgnIUGH0O0ap5DxuvaDn4ymCdFuQv8edNE5QgJT3JaBz6GKbY2TyGyCYpEvQSDzVtC/9cjQP0ws+zNAfrc+FWNdxU4KmigWTjxKfFXnezK8QJribROg/wNrQDC4DxhF52NDXs6ujRP6bR5hKM+6y1eWoAgZRpowf0eXupIfzr7KSoe/fZL9uwWvE0Ig4t0ctkWk5CR92UOqo9FSSBidvtmm1eYsgVy1KLufElRdA2jAtEOW9gzYs1nwK+zJ+5lA3CKqR2/dOwUt7iHOtH7OgDUiKIUURIcWUckB4NJqNGY/q/PV4J6o+qnELBg6xpltObF8u6KgwL8nrNYMQV/BRBnQmP3sqlAFF4/i14mrID2g3qaN2HFevrc3MZPm0ghqSmvpsuCvIuaSNc35FgoCAWnyu11UqjUH3cCKT04SKBjYpP9DoogrMrxIUbvVskX41NTjLYK9kc/bZxOIsdZWR7dYhBcwSrjerOnScUuTh6it4RaU1apcplwDKPRPqN30XYJN1SRcHFl00yGBOT86cIrdqPak7Z4RtdRAPNEogZlxVwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEY0YjBGenZtU1pqVEcvaUk4Sk1DVUtWQnJ0ZVFwTGd6ckxDZ2NlcitoaWMx?=
 =?utf-8?B?dG8vc1FPeFdGTk9RY0xuSFFablRlNjFPT3c4TDVBeDIxU3pCYmwyMW03RTNw?=
 =?utf-8?B?Szc4eks0bVBpN3BOeEkrS0V3RUVham92Smk3Z0VrUkd6em1TVXp4RnVIc3lC?=
 =?utf-8?B?K1o0Zkh4Um5YRXRHMmFWSTZIN2NPcmJ2QkF2cTI0czRCdXJqbElRVHhuSHVV?=
 =?utf-8?B?TENYQVNiV29KZGhIOTNSTGpyZ0JtZW1PQVFxWTRBSHBsN1NnV2tnMVJ3Szc0?=
 =?utf-8?B?b28reFhscXpIdWdBbmF2Q2JHM3N6V1I0UWNJSmZzN0xFS25USTBqQWNpRC9O?=
 =?utf-8?B?aUpBdVJ5Rmd2empRamIwekdhTVRsaXFDR0JnMmFITWNQTEw5Nlg0SzlIazVQ?=
 =?utf-8?B?OG9SV1VobHRJU3BhR01COG5EWXd1VFpWYXI0WEY0Z2lZYzZrS3U3WnhISGRJ?=
 =?utf-8?B?bWIyMWpVZGVmR1U2azhBM3pqUW9sQjJFMW5kcDdXUkRTRUdlUmk2SEJzdVow?=
 =?utf-8?B?dDJBSlk0Umx3N3ZQWGJIbHVlbmQ3VjA4U2UwM1RlSW1HVS9NMlpYSzltamhT?=
 =?utf-8?B?SHpOWmRRNVFmaU14TDdaWXJSdy9NVVhpMWlGRUQ5UGdPeldxMi9aMk1GRVU0?=
 =?utf-8?B?cUVrMFUwZTBhZC9YWGY2T2h4M1FXUHQ3WVM5L0FOMXJKdmN3QTI1a0hHWkxm?=
 =?utf-8?B?akxSbGpNZGNMbXdRellpKzJ1bFpzWFhRRFErVzNTNytOdWEyOEk3VjluS2pp?=
 =?utf-8?B?aDdvTXlqL29ML0trTzMxOHJXZzExSkFxN1E0VTRKWHpadFJDRWRjVHZETGw0?=
 =?utf-8?B?SFpRT0hUQTJaNkMzYXhTNGVmV2ViUUJLNjJDWGVrSGV6TnZZVkhhMWVGY1ND?=
 =?utf-8?B?TEppcWFFa1cxR1psb0FZVGFBWGhxN25SU1VtS2wyR1FQNzBNOFFtZ0Y5dkdZ?=
 =?utf-8?B?RERQV2dmQzhiTlB5R1F0eWl3SWZtOWt4ZFdyUEd3SHJmZUtwSFh4TnhjVkFY?=
 =?utf-8?B?aFF3RmhiUjNFWHFtTm9aVHhwdG9IaEtPL0x5OEU0WDU1ZnNCTzZVZHhlNjUz?=
 =?utf-8?B?dzFyaWkyMFNIUW40NXNBWEdva3AxS25VZGp2YU9VeXpvYm0zUi9uSVMzdkxH?=
 =?utf-8?B?QWtBK0xOeTgyZWQ2UG9JUWF5UmFBbHVpUEZvdXV0OFdBMlNSTlp2RkI1QXdT?=
 =?utf-8?B?bkg1bGdmMDJSdk4zRzl3bFF3SzlqdFBpNFdVWHlKMXN4cE9ISXN2QmR6QVhE?=
 =?utf-8?B?Wlp0WExjWENLMVg2dmlHS1duNnl0ajZuNktTY09wMEZSbUM4eE5kelpBMG5W?=
 =?utf-8?B?SVdoUUo0M3dWekQzcWo5QWVnV0tmeCt4U3JWaHhPL1RlZ0lwRHRFQis1SGFv?=
 =?utf-8?B?amQzaUQwZzZZZXp5M2JvWUhQYk8vQ1FEeWJ4R3ZkT1RieC9ta3M0NTg0eXdl?=
 =?utf-8?B?S0RQSlFTMGdtdi9PNGZNdWxyRGpIdkU0Y1ZvRzhkWm8xT1VscXo1Sm1pd2xY?=
 =?utf-8?B?d3lCUHZnYXpEMFVYaUg4Vmo4cXhXbmY1ZXlITHp0S3dqRndWbHZ2U0N1SmtK?=
 =?utf-8?B?c2NVMmlKcW0ydWNkbmYvV3k4c3U3WnQrNDN5bTc4bFVyQkJrMEpxallVZWhG?=
 =?utf-8?B?Z2ZVV1Ztd1Y3OVBPbjlnTTBQS3huVGJ0RUZVSCt0OWg1Y1pUdEcvc1JaQURu?=
 =?utf-8?B?Q0xDazlFeG92dWNsNGhZMnRFYWJ5NFBsei9SL2Q5RmpMSVZ3djFpM1duWGZF?=
 =?utf-8?B?eVIvYTJyU3VyZGk3QVlhL01LQkFQMjFtblR5NHMrQ1JEMUVBTlVkRWMwcnpl?=
 =?utf-8?B?eHBkeER3SmdwWDJZT09tWWo3Mk0xV1QyWVBRbjcrdjMyRW1ScEhZRUp5RHpx?=
 =?utf-8?B?V2V1NXZ2dXNRVHpxSnJtZitNa3JKT3NzSVhHL3p0S0x6THJLSXloOW15MVha?=
 =?utf-8?B?ZzFMSjhaWGo1K2NZZkxzQkEzWU0rOVRwS091VElKbXNtZkNhQUM2d3QwWTFI?=
 =?utf-8?B?NDM1cndVaHhJeHh5SVlGOUF5MjI2alRuWVFDQlJUWFhERXBUSUNraG02azlw?=
 =?utf-8?B?K29BQjJySG1RTWl5WmxiZFo3MzJvUDNKT1NNSHNvY1ZtTzNFWnlBVDVsWHYv?=
 =?utf-8?B?NXNRRnByV09QQklxQnFHVmprSHlzSWo1VG5JcEltNEhiYVdBR2s0TWFOeUdq?=
 =?utf-8?B?bzZRZHROTU1Zc2NzM0VLZ2ZVSTM1SEZld3JmNjRocDhUTjhiQmsxVmFLOCtx?=
 =?utf-8?B?dW5hVGx6N1NTazZBWTZ1ZXlRVFYyMURUaEx6a1VNVDZwU2xqWmNPL3JON1Fm?=
 =?utf-8?Q?074s1TxY6zgYWxmRzc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bdc30a-8fc8-4d0e-c220-08df249a502c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:42:09.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpA+8z5zdVaLvGPB8lRyJCOeuwE33FtTVxz78ApwRMI9fye79pbPRq4X8WU6KxaelYuyOpWADBZOPOOIL71yHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB731475
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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



On 10/5/2026 11:49 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 05, 2026 at 08:31:31PM -0500, Tushar Dave wrote:
>> When a PASID-capable device is added behind the PCIe downstream port,
>> for example, an Nvidia GPU, the PCIe downstream ports must expose ACS
>> capability otherwise PASID won't get enabled.
>>
>> In addition, the other use case is GPUDirect RDMA using Data Direct
>> that must require special ACS controls at the PCIe downstream ports
>> for P2P communication.
>>
>> Gate it behind a new x-pcie-acs property (default on), following the
>> x-pcie-* compat-bit convention (x-pcie-ext-tag/x-pcie-err-unc-mask/
>> x-pcie-ari-nextfn-1), so older machine types can disable it via
>> hw_compat to preserve migration compatibility.
>>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> 
> Does TI X3130 have ACS? If not will the purpose be
> served better by the new generic port recently proposed?


As per my search, the physical TI XIO3130 does not implement ACS.

I am not aware if the capabilities of the emulated XIO3130 are expected
to exactly match those of the physical XIO3130. My assumption was that
the emulated device can provide the PCIe capabilities needed to
construct and configure the virtual topology, even if those capabilities
are not present in the physical XIO3130.

I added ACS to the XIO3130 devices because they are currently used to
build PCIe topologies. I have not looked into the generic PCIe port
support in detail yet, so I can't comment on whether it would be a
better fit for these existing PCIe topology use cases.

Thanks.
-Tushar


> 
>> ---
>>  hw/core/machine.c                  | 1 +
>>  hw/pci-bridge/xio3130_downstream.c | 9 +++++++++
>>  include/hw/pci/pci.h               | 3 +++
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index d9ac4b419a..b1b3911430 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -43,6 +43,7 @@
>>  GlobalProperty hw_compat_11_1[] = {
>>      { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
>>      { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
>> +    { "xio3130-downstream", "x-pcie-acs", "off" },
>>  };
>>  const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
>>  
>> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
>> index 0c3fed3053..6a9df5c174 100644
>> --- a/hw/pci-bridge/xio3130_downstream.c
>> +++ b/hw/pci-bridge/xio3130_downstream.c
>> @@ -40,6 +40,8 @@
>>  #define XIO3130_SSVID_SSID              0
>>  #define XIO3130_EXP_OFFSET              0x90
>>  #define XIO3130_AER_OFFSET              0x100
>> +#define XIO3130_ACS_OFFSET \
>> +    (XIO3130_AER_OFFSET + PCI_ERR_SIZEOF)
>>  
>>  static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>>                                           uint32_t val, int len)
>> @@ -60,6 +62,7 @@ static void xio3130_downstream_reset(DeviceState *qdev)
>>      pcie_cap_deverr_reset(d);
>>      pcie_cap_slot_reset(d);
>>      pcie_cap_arifwd_reset(d);
>> +    pcie_acs_reset(d);
>>      pci_bridge_reset(qdev);
>>  }
>>  
>> @@ -111,6 +114,10 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>>          goto err;
>>      }
>>  
>> +    if (d->cap_present & QEMU_PCIE_CAP_ACS) {
>> +        pcie_acs_init(d, XIO3130_ACS_OFFSET);
>> +    }
>> +
>>      return;
>>  
>>  err:
>> @@ -137,6 +144,8 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
>>  static const Property xio3130_downstream_props[] = {
>>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>> +    DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
>> +                    QEMU_PCIE_ACS_BITNR, true),
>>  };
>>  
>>  static const VMStateDescription vmstate_xio3130_downstream = {
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index f2448e941a..dd52b9639e 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -231,6 +231,9 @@ enum {
>>      QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
>>  #define QEMU_PCI_SKIP_RESET_ON_CPR_BITNR 15
>>      QEMU_PCI_SKIP_RESET_ON_CPR = (1 << QEMU_PCI_SKIP_RESET_ON_CPR_BITNR),
>> +    /* PCIe ACS (Access Control Services) extended capability present */
>> +#define QEMU_PCIE_ACS_BITNR 16
>> +    QEMU_PCIE_CAP_ACS = (1 << QEMU_PCIE_ACS_BITNR),
>>  };
>>  
>>  typedef struct PCIINTxRoute {
>> -- 
>> 2.34.1
> 


