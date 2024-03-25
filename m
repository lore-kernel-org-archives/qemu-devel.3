Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CE6C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohEU-0001ez-88; Mon, 25 Mar 2024 06:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rohEQ-0001Ze-TZ; Mon, 25 Mar 2024 06:07:06 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rohEN-00031F-7Y; Mon, 25 Mar 2024 06:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711361223; x=1742897223;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MNt1Hz/edUyZ2BhZ5vyh0XMSArFQRImVBDep9VMccJE=;
 b=F4wO0EgeW/YjNyxFkjbbMLR40nWk2bgdaJ7PqBmJYvdwipQiYcUxmrD1
 S6AlqfHYAbYVq+3amOJ0odUyQ7654C8+uHHzUyc6yhwMXXPG2tNYj/wBk
 cOdnZz+7mwwIzAXRRB4DQvq94kiQdfP9X70jpquAvZtIyy+G94kujuZe4
 xGm+WSZO8fZkx2bCabFYTsLmKcJEeJyjnOgnWXkONRtUMGRStqpZYGVAA
 620PIv6jn60uUKmLKSdT+RjlM41DEZkLn+lcUVJTdHdkvdeEYxdOLSN/E
 4RsSRDeGVhxB0BXkUKwPvr+TqLY2BSbnMe52nXpxNHA3X/ZrimAGVwN/g A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6183328"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6183328"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 03:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; d="scan'208";a="20039147"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Mar 2024 03:06:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 03:06:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 03:06:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 03:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzrtvGqpOn1xmwK+ZUqQaSJgZUxworzIs315T8gcL7E7JLKsNrRssOSrBNoQ4DKUf/8AZnYNIH0dK5ZTHxZ/xkL7UKBWpxwxVujXgLnrWWo9A2Nckz7Est3gJg9gdShAm6Batwel0vTIrPS+4gZ9anq4I29NjVRyPyOcT6W39wPArLFYFIg/izIVHuRM2xEM1uCkjq5WJDRHArEhC9PSfmQVvPXlq09OKZ5OpBTh04Fb7c5Mh7fOWpPt8IHzmf0hqT0fPGyXHsYTt+TPlit5Y/DdZfNGoHmhfdyuV75aFCg0oXvGWPHJvJyV5pynyVbi6DAnL+zeK+8cGaSDKyR3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uITwhT7P9hctKjxb05KpP14LmKoXElq8NnwWdpA8kgo=;
 b=Mdn1m0xGWZjdWwLWLLjfkn2P3K95T7GEpgHJXivn+Bovj02+dhegr36aKY72QDTViCu98zQVgWAu7byqjL8XkBES+lkJ/fr1K+ueXCS/1kZSsqUNUpFhCCeqNaaIaxbcQeL5BGXaEu9DqTh/+JhTKg5ZKULPeB0V5PJ5Dkmv2qj195EHrVWQdh75eYFBvDnKb0gTNy0/UDT/TXBNp1ykgzKy8IxcLBmRuAZCPq+d7bRwhL8ZO06W3JgCmNdDHIx0RK0Dhd2qmp/DK/EB9zAl6eosuNpwkRK8HnI+aDTPufnsDM2D7DXdXjwHYtdUePdbUwhKubPolfD2RerxeelrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 10:06:54 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 10:06:53 +0000
Message-ID: <3de5968f-28ab-439d-a8dc-65767f69a8ec@intel.com>
Date: Mon, 25 Mar 2024 18:06:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/2] hw/riscv: Add server platform reference machine
Content-Language: en-US
To: Atish Kumar Patra <atishp@rivosinc.com>
CC: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, <andrei.warkentin@intel.com>,
 <shaolin.xie@alibaba-inc.com>, <ved@rivosinc.com>,
 <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>, <evan.chai@intel.com>,
 <yin.wang@intel.com>, <tech-server-platform@lists.riscv.org>,
 <tech-server-soc@lists.riscv.org>, <ajones@ventanamicro.com>,
 <conor@kernel.org>, <heinrich.schuchardt@canonical.com>,
 <marcin.juszkiewicz@linaro.org>
References: <20240312135222.3187945-1-fei2.wu@intel.com>
 <20240312135222.3187945-3-fei2.wu@intel.com>
 <CAHBxVyG186Zo7nAm7o8=vhBtzU+x8ry4_mWwHxuaZ8BasnDyPg@mail.gmail.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <CAHBxVyG186Zo7nAm7o8=vhBtzU+x8ry4_mWwHxuaZ8BasnDyPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|LV2PR11MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a04662a-bd8d-49c3-1265-08dc4cb34ba3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWTy+CRqrdeL5X8iHkFcbyydAeqC3woOOFsGaDaRG3imWjXzgPyxQixyc/3DlthKIyLnF7WWr+udsGD9gzbvL2G/iQVU8AT19UDX06wL1BrSTIyPqvD0kOAAtXjbVgp1CJEevqMEypoc6XZRMphuuUjsCj4uMbEnbnWdvsoXCOQYqFA+UhyBAZB5/Wgia+OS71ICzcBOseWVmfSkwaQ3u+LIiuf0YAfdn7646/CR8MqrLrzF7Lx9E15uG2Cx1ze0PNM0dbnITGIpNi6ELb6AE50tb3eIpDX4uJaokqR/Gx5Jvn8slZmdOLfkUutsve3Eao4faRNiWYIvubBGF4pCWv54/QHnXhUk5utKGU5vMk8XwDmK2B8W5WUrrR9DKuTuyPf+RkmbvgPImzY+oj3jvTCS0/C7rYnui2BlDvUY9MXQp6zAf5ZEQ1WKKS5hqXtYUCe5wcNLkaa1e9d5TpaN2AAUnI0rzUMV6GKuH4uiGA/t7t95FUJN6igL2sewq8dp3Ag+CidhQRA7dr1CGJYPsakZha7U77qbyc6OPsVVWlDwyVj6AUEVfU7kdLh2nCvuEigCLtahsENh/qwSpcjn0etTSeNz+XYTLZvmhpzTp7wiPLApTbKT+7z6klBiUj5Vg8H7VQU2Uy2lpGKONhwOnjcG1mYK7ZIf+/cDYxz92rU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3VRQmZ0NmFUQ0FqZGJyT3J1KzE5c2wyMVExT1JPb09TRHB5QmtkOHJrLy8v?=
 =?utf-8?B?c2tFZ1lwTWZCVXlTRGJBNlc0SFB6Z283aUxpM1h3eEExYmppZXZsYU93cjB6?=
 =?utf-8?B?WGsxUEphdkdvOTVRUTdyQjNDRHJUSmExRlk2UnRIWk1aUEl1bTl0dERFTHVM?=
 =?utf-8?B?STFoQ25kZkdzTTdIdlZDcjBoell6R1BKcGtMMHIrSzFFb2ZpZGppNnBrVi93?=
 =?utf-8?B?dnpHMlBieHVmb2Rwc2dNY2FCdFM5Wm1WTTVjUmMwRmwyN3pvNm1YMUtocXd1?=
 =?utf-8?B?cjhGd2Ewd09tV2xGcUVHOURQOWtSUjMwUEMxTEhjMUNZUytpNDlzbzZWRXEr?=
 =?utf-8?B?TXMrcjlHOGhIOFU3RytkdmNPeW1EeFpqMHc4SFk5UDUwbW43b3pZU1c4Z3dz?=
 =?utf-8?B?bmJQUmZZUUxjcXVkK1gwRVR4NUNOenZaMmhueU9rZFhGUkpFWk9VUFViRHkw?=
 =?utf-8?B?OVhHU0Zieml0andkb2FlYVlPZ245dWd2TTI3aDZhYkhza1AwY0JyVjd0K3NZ?=
 =?utf-8?B?a2NlMjZuNTlEcm1PMzExTEYxQWd5cW1IK3pYRWFkL0d3V2h1bG56SXV0UTkr?=
 =?utf-8?B?d0tUUVdTSlc1NmR6QnE3SWNvVDkydnh3ZmNVNDFQZWlzVHppLzdFR3czd0M2?=
 =?utf-8?B?K2ZvTmhPV1FYUm0wUTFLR0crZHpBcnZLcEd0bUQ0UjVFZWZVa05QaGtabHQv?=
 =?utf-8?B?Mk5CTXJDdk5IdzRKNGwrRlBTRTcwVlM5NkF4SkdCNnRmY2RBUndJWXBxWjQ1?=
 =?utf-8?B?dGZub2JrS2xmNXNOS1ArOXVRTWxPSFVEcGtHYnpsdENoR3hvby9KOVZHRzZT?=
 =?utf-8?B?QytGOVI3TllOWWl3NWN4WlJYeFY2bTJxcDlSZFpWTlJYYXJRam5qRFMxSVN5?=
 =?utf-8?B?dTVFK2RMTU5YMk1uSlJXdjFhbm5aTlN3VHJPTy9OS2ZWRStNaTU1dlRQbW15?=
 =?utf-8?B?OWZoKzg2TnJiNDVrNnUyZWZSdTJwWUh0aFVESy9vdFdxK09rSFplNDQ2NEps?=
 =?utf-8?B?WG1GL0EzWGt2MlpaaXRicDRXN0ttbm12TU1EU285NGRJdWRXd29kbjVRRmJv?=
 =?utf-8?B?YmZDdUNwSTRsZm5LbUdEekc3LytqVGhtR0krU0NlNGRPM1NNOHFUZW5iUWhu?=
 =?utf-8?B?UjloMVV6a1o5SEpCTHdidENoR01iZi9Da1NodU1FQ1BXMmVkTEl4Q0Qvd3pj?=
 =?utf-8?B?d1BqVGhVa3ZmbFgvS2dSdWtiR3NIWGNJOXpjUFpCNm1VWWxiSFpWMW80L3BK?=
 =?utf-8?B?NXRQdHJKc0FIMWVtc25uNTdlRFJFREFvS1VPdFRPMFl4aXFwRnJVcG9jQ0xW?=
 =?utf-8?B?WmxZbzVjd2FSOTg1UUN0a0Fqamh5NUYrRjMwdkhyd0U3UTBIRVNLVCtLT1o3?=
 =?utf-8?B?Wm5oK0lFdnpZNXBmRGMwQTFRd01VTXF6ZHo5ZWJJdnA5dzJmMEFsMVpiN015?=
 =?utf-8?B?azBXTVpWRTM3Y2paeXFuL1A2ZEtCVXU1c2daeHFJbm42VFdPU1RYUmw3NFI1?=
 =?utf-8?B?WlpzaktPUDFrQVRDVUxDSFhYSXZEYkVVOCtJWURUSnl1bjV4aVVvZXJzWFh3?=
 =?utf-8?B?L3Vpd3JSUTYwNXllREowQk5BWjFpd1NNeTZqTzIwMkNhanREY2RZRGswZExF?=
 =?utf-8?B?d0RGRVZXTjNRWXdycEJUc21IM1FrMmp6dmpEbXdiVGdva1JSdDB4SG0xN0pk?=
 =?utf-8?B?Yjhjc3kvay9GeldZK1NQZ01iU0s4eGlWZE1zZTZYUXBsUkswSmlBeklNbTFo?=
 =?utf-8?B?NnQwTlYvS2hDZXAwdUNyM3RvUG9wMEt2M3NPbXA4dHZsUWFlK1VZWmVBS3RG?=
 =?utf-8?B?bjd2dE5PT1cyNEdqQ3RwUnA5OHc4RXh6YVVXZ1hhbUUyclZlREgvbFFsRlNq?=
 =?utf-8?B?N1FWU0lQUkcrSlZzZkVyeHJMY3MvWit6YkNqRnRqUU03azlpYzhXRGZUUWFJ?=
 =?utf-8?B?a2VaQzhFTjJReVk2OGZlQWxDSnZscmVQemU3RDB4cEJnbUNOQitjSFZidFFr?=
 =?utf-8?B?Zm5ybEJFSWZvYWcydm9JVGhoNjJGdnRxL3JxSTdwVEJHRTNQZkRtZXBCemUv?=
 =?utf-8?B?czc3NC9mVDVWT0R0WWIzVXhDQmRiaDBsS25JcG02bHN1L1Jxd2dNaEVmQmJL?=
 =?utf-8?Q?cVwdKPDofKFZ/huPUFBOzyzJ/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a04662a-bd8d-49c3-1265-08dc4cb34ba3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:06:53.5057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4StCSYxmh2mzpSKj9E7Jk2PV8RGV6wRLCER/Hxf9RC7CSjS1GOlnkXI5WlQGV0Dcf00CEPxEbVef26zSxkKQcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/23/2024 3:14 AM, Atish Kumar Patra wrote:
> On Tue, Mar 12, 2024 at 6:53 AM Fei Wu <fei2.wu@intel.com> wrote:
>>
>> The RISC-V Server Platform specification[1] defines a standardized set
>> of hardware and software capabilities, that portable system software,
>> such as OS and hypervisors can rely on being present in a RISC-V server
>> platform.
>>

[...]

>> +
>> +static void finalize_fdt(RVSPMachineState *s)
>> +{
>> +    uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
>> +    uint32_t irq_pcie_phandle = 1;
>> +
>> +    create_fdt_sockets(s, rvsp_ref_memmap, &phandle, &irq_mmio_phandle,
>> +                       &irq_pcie_phandle, &msi_pcie_phandle);
>> +
>> +    create_fdt_pcie(s, rvsp_ref_memmap, irq_pcie_phandle, msi_pcie_phandle);
>> +
>> +    create_fdt_reset(s, rvsp_ref_memmap, &phandle);
>> +
>> +    create_fdt_uart(s, rvsp_ref_memmap, irq_mmio_phandle);
>> +
>> +    create_fdt_rtc(s, rvsp_ref_memmap, irq_mmio_phandle);
> 
> 
> We need a minimalistic DT for firmwares which probably don't use rtc, pcie etc.
> Does EDK2 plan to generate ACPI tables from these DT ? Otherwise, we
> can get rid of these.
> 
Yes, I agree. Eventually we can remove many of these fdt when EDK2 is
able to generate the ACPI tables directly. I add it here as EDK2 has not
been adapted yet, the system won't boot up with the upstream EDK2 if
e.g. fdt of pcie is removed.

Thanks,
Fei.

> As Heinrich said, Linux kernels should boot using ACPI only.
> 

