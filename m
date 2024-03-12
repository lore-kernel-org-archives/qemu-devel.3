Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6100C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxzm-0001X1-MD; Tue, 12 Mar 2024 05:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rjxzY-0001NV-P3; Tue, 12 Mar 2024 05:00:16 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rjxzL-0007X2-Vc; Tue, 12 Mar 2024 05:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710234000; x=1741770000;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=uTMfTx8rVZqIiYLvJ/KSmG9NpVrx1mUi+YrZUWJe/2g=;
 b=IfCnrq5/NIFE9yizj4Fq49o/mpIuidl2ERzG1isT346nCeo4dP6ZMAhf
 0yRvC6N2okKTQ8RJstcJ6hZuoBfDH13hLkWNTY++wej1PotlEM0ZOkUQJ
 F6Ez4NNql5cXPwcPUvKqe+ZvopJ/cFEfIRZROrXE7+eBQJDp2DO/ZK15B
 F3MOSMDM/z3UHj7DcqhCw/S+1mkBSGyLiXkrwJjyquKhbgIvorRS45d8Z
 KuY4wf2sQZcMhZ7iyLqTrkDQx21SRNPrmBl3ahY4ZTOCAvrfdhWdbX5wg
 o58Cu0Wo9BcP2k/Zj9q7pOM6ZAXREq/B5sUwX5ztXJndJKLZ5Zmzm4zG3 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="15491521"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="15491521"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 01:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="16065333"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2024 01:59:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 01:59:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 01:59:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 01:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiIHvrWlZL/2jq9ECh+uQht3ulVfnaaZO7HSZGTkBbtU12B7sgoHlf9Wr6LPa9yrk59SGpWEUFAmKLZTO2Vq43clVoTdfBrwzGCJku8gqLx6R3P7vT4hzmCfD5j40MYN7Ghn3Ddxtub40kP7gKb0MgEJlnfOu0ruUPxQNkU2QXqhGz6vmOgDMyOks/RuL+tmb7eHYWbsqiodskhsOle+5R8y6PCuOXRQIrV3gIbOnTOg9EeI6m1i99XZ6hQk2phM9DApmyLYJcfh+T7qyZfTWbHzR+XeTbLhkeawyBSHlBfPQh/TaWu9CaPt2E9DcmirkioOT5dPQtZpDOseVHBmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwserGqS7kAEpb0Jjpc+WVmwiWa6If8UgoP1aaBAufY=;
 b=ad1HX98V0L0i2TRA9jpV04KfbJ0Tij0kKpxf9qSjz4+T8/QMR7VdUm9vLJSOC+u+uTcZfhZDhBYG7/Zo+bTY6pLpEk1Cv6gszR0AYFJD6Ytpb7CdSqhsD9EDKZZf0gNo5fLseOD/TkhcHVBYiGVuSAFGOZIlK0/AqTgZChmb8iypds5iYm8XqY6aRuyhCQG9oV2ftH8e3E2WyxI7IlMmj9JtV2MawhHkBjGSqhxvrMFzrbVmVms7/yDNbM3oe/zibb7PY5uqXqzAAu4mu1JEru+orf1U11zFqawGLb/mNjkZUj2LVqlyoUJhobbtYEPDCygfvIe8EMTMm36Ldbkyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 08:59:52 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 08:59:52 +0000
Message-ID: <13bb6ef3-be61-4b3d-91c5-887bbcbf6e13@intel.com>
Date: Tue, 12 Mar 2024 16:59:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Add RISC-V Server Platform Reference Board
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, <pbonzini@redhat.com>, 
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, <andrei.warkentin@intel.com>,
 <shaolin.xie@alibaba-inc.com>, <ved@rivosinc.com>,
 <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>, <evan.chai@intel.com>,
 <yin.wang@intel.com>, <tech-server-platform@lists.riscv.org>,
 <tech-server-soc@lists.riscv.org>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <ff1b2b2a-dc8e-4346-92de-bee9c4b4b31f@linaro.org>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <ff1b2b2a-dc8e-4346-92de-bee9c4b4b31f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 0011b850-7973-4437-4600-08dc4272c792
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4qzUseXfNP886heQd51Llz3No9KsC0n1/QwpE42eniZutUm9hs3MpOhe4crBdsHuUNtkku12xDUL+tRZLj4vKftAxOv48nvwCIutnyPRaHwhICutZdMacCFjaH7he7zlUQGYkL6xuvgWgx/yHehYdZ5q3B5UInI1vU6Mhvvxg/UZd2vVBXC7X4TqFGnVPwIrreqM66jcHrFsKkAiuqO4bGoj+T9tVbydajdJy4SINvLyGnd6lyglYo65DSxdx6WhkFoBoSK1+0TWTOlWaaH4pYNbNbkLjGiTmv21RL43dlzoJ3rZzQN6fEIdQfuO5vaCJNEqH6HBCSZv1iOeAVOqgD5UEsEINZEldo43FfsA2EymscVfnbIBeohKEzDKqCUKzRIzgYgtwnXctryUuNVENOfQZhLOxujnRoTO+g5Ay6+fJJisegHfdF3aVqharRYnJdyU8Swl+7/o1JB/W2k5C0jWBMRDGxqrFq7KKFTDR1MwXc6daQwBJmrK4S6pxtNc5ViW9u7HS+MFH9kOFwPXkqtMl6un6u/PFTk6TK2cH5HRiytWdiVrPQ39o92mZCl9pE3VDzi5x9YcMrxJHnNCqCuTUc1mIoNQ+vmuqwFpNpeu/RlBEaaOJ49MdTC2OquUlmxyn8CQBxgw9PUflAkTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(921011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1orUTJDSkZsTlZGSjU3dVp5Z1RCeGdsczVYa0hHeWZVNlNDcTRRREpFeEJy?=
 =?utf-8?B?NlFtdTJOdjB0bmRVMDVwVFZDQUtsS3dhTmhFd0dJR2NXc0lUZHJXMmkvUy9I?=
 =?utf-8?B?MWZXY2ZEYmthNWUraUh0a2xMT0FyZDBJS25PeXZaL1hudlllczZ3ZzZsajlJ?=
 =?utf-8?B?VjNaa0oxNDR4Q1psOHo5YmRmZ25wTldsbWhQckJMTkthZXpqSFRJVGxFSTdh?=
 =?utf-8?B?aUd0dmFadjRPVjd6UlJTZHF3c3lHbVZ3UEFDT0pTckdYTU52dUk1L0djS0VC?=
 =?utf-8?B?eXQ5dWhidUR4ZlZPZkh2ZWFOR01RTE1JREdPMzdISGV3WEJxYlczM3JSem0w?=
 =?utf-8?B?b1hMSFJVbFVZL2dWdG1DczhBN1hVSmVkVGluRmVOU2dnM2JTNU9CRWFuVWpW?=
 =?utf-8?B?LzRiTHR4OXpNV2dUM0Vwcm82WTZkdXpyZ1MybWdJeis3dkhic2hYYVpxM0xn?=
 =?utf-8?B?TE5GSmVTL0l4Y2xiaCsyM1VlNGhsVFlSbGQ1b0NxcCtITlQ1c2x6TzZvYnND?=
 =?utf-8?B?TkZ1TzI1UERZS1A4ekk2dzV0RWxkSGxoSUROR2t5eUUyT2k4bUZZQlFsRkND?=
 =?utf-8?B?TDJiY1JSVWg4MkNPOHR6SGtPSjN0RklWZ0RSZlYwVm8vSEpaQlhwN1ZRWTUx?=
 =?utf-8?B?SmkxblFGT0JUdHhzcFh6c0VWQlFvL3BvZHg3ZzVDNlJDcDRQNTFJR0oyMG8w?=
 =?utf-8?B?QjN1SXI5WEl1VFMwSGxZbHczNTM2NG96TW1KT3p2bXpTcE9qOVIrSVBvWUcv?=
 =?utf-8?B?cTBMMTJxQ3paa0NFS20rOC9RZEVoeVNsc3lFNkxlcTJ4NExhY25SUk5Bb1ZC?=
 =?utf-8?B?Y3dNY1RhVjM1YURoQkNwUjRGR09VRHR2aG9CYXJuVjhwUmM4azZHTWdOWFBU?=
 =?utf-8?B?eWh0dHpNL0FDdjV6Z2Y3NFZKdFhVZWRKVWxFSjJRMWhsTWt3bEQvbXdSZWtn?=
 =?utf-8?B?aHBpOW1MRXdFaWo2WHlYT1pVbkFyUDQ0VlluMnR2TlErYzJtSHBZVHZPN3ZF?=
 =?utf-8?B?Nm1oMHFHZDM1eGRzV3M0MXlOQVBCUkY5UGM5UGFUMjFyTjNrYWRxRWZKQXFz?=
 =?utf-8?B?L1ZHMjNMcXFacVM2RE0ydWpsVS9ibTExTytmb1RkSFZMM0pYS0lrVlBETDRW?=
 =?utf-8?B?QksvTlk4Mkk1bTVyTldoeURTOXhielJKNWo5NCtXV0pJZ1RMUkdsbmZDdExn?=
 =?utf-8?B?T0lDRERIU2Z3T3pTWXI1eDEvYmZjTkE2YyttQUp3NlVXR2lZVHhuMHI5d3A1?=
 =?utf-8?B?bFJleWdVclFIbmk2RUs5NE12aXJUMTlDc3ZxaUhTc3lvL2V6M0lvdGFPNmEx?=
 =?utf-8?B?ditlUGVKWTFvMlJyZ1pqV3pkNm5FM1pHb0xUTWhRQjdzdlYwS0pCQUFCajFo?=
 =?utf-8?B?L2ovV3VXdFc2b0tLY29FaVFUNjcrUXl3L2RGR2Z4WTllNVlKSHN2YXJlY3VL?=
 =?utf-8?B?SmxSbDljaUQrT0w1aTBSR1NHWlVYak9FU0QzOVBSUE10SUVKamp6bmFtakd1?=
 =?utf-8?B?bzdzQmRodWFZMytEc3ZHZlVBRkRDNnpzTHF0K1dBZFU3YmFodnlrS052RE5E?=
 =?utf-8?B?SjZxOXNjOXgxdnBGcU84aDZxVE9jL2JoUzlvakxwRUY5c2t2V3VyMER0dWU0?=
 =?utf-8?B?TkkyRjNMVGYxQmoyWW1ubC9SbjVkZjJwbUxDTTdrdFFaR3htU2w3a0N2Wi93?=
 =?utf-8?B?NWhNbmg4ZG4xclk5ZG83dWxKc2pua1NaR0dkVFE5ellxNXFGczJxSTg0NFUx?=
 =?utf-8?B?N3NiUkl6UFBnSzZLUUIxSzNVbXo1a2VrbXRwYTBBOGh5ZmNTVjE0V3ZGNjMy?=
 =?utf-8?B?enBkQTUvVlUrRjJ1Ny91TFZqRG1lV2ZsMTgwNXRMTkFqM0dMWHZZWWFMMExm?=
 =?utf-8?B?cWJ6ZHpma1hDWjBOR2Jzd0FoRmNrTTVDTHluM3BTck1qQ1BYNVN5R3N1TTFS?=
 =?utf-8?B?S29kL1B6U2krcDRiVko0RURoTzhRUTE2QWNtL3h3NVVkazAwL0h1L0EraklL?=
 =?utf-8?B?ZHVnNnZnS3NiVm5uR0twTDhKQk5tK0V1c08zTkYyL1dmZ3M3enVpdHN1QSs0?=
 =?utf-8?B?QXhPb1lLaUhFRTVZMTdzY0kza3pwejZHOTl4SkNDY1Q5SWhPNCtiaEpuRjBo?=
 =?utf-8?Q?6j6ngEH6HADQHRIvIfnz2utUf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0011b850-7973-4437-4600-08dc4272c792
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 08:59:52.5198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jInOlAk/72z3mjVWgpx7sMSUWjcQbNSQKt3xzoq587vuzmDqq6Ln4UHk1lMze32hfXSfRuZ5Y/hqc+12FbPuBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/8/2024 6:15 AM, Marcin Juszkiewicz wrote:
> W dniu 4.03.2024 o 11:25, Fei Wu pisze:
> 
>> The RISC-V Server Platform specification[1] defines a standardized
>> set of hardware and software capabilities, that portable system
>> software, such as OS and hypervisors can rely on being present in a
>> RISC-V server platform. This patchset provides a RISC-V Server
>> Platform (RVSP) reference implementation on qemu which is in
>> compliance with the spec as faithful as possible.
> 
> I am working on sbsa-ref which is AArch64 Standard Server Platform
> implementation. Will not go through details of rvsp-ref but give some
> potential hints from my work with our platform.
> 
Hi Marcin,

Thank you for sharing this.

> 
> 1. Consider versioning the platform.
> 
> We have 'platform_version'.'major/minor' exported in
> DeviceTree-formatted data. This allows for firmware to know which of
> non-discoverable hardware features exists and which not. We use it to
> disable XHCI controller on older platform version.
> 
Looks good, I will add it.

> 
> 2. If specification allows to have non-discoverable devices then add some.
> 
> This will require you to handle them in firmware in some way. Sooner or
> later some physical hardware will be in same situation so they can use
> your firmware code as reference. We have AHCI and XHCI on system bus
> (hardcoded in firmware).
> 
This RFC currently adds the devices like AHCI as PCI devices.

> 
> 3. You are going to use EDK2 with ACPI. Hide DT from code there with
> some hardware information library.
> 
> For sbsa-ref we created SbsaHardwareInfoLib in
> https://openfw.io/edk2-devel/20240306-no-dt-for-cpu-v6-0-acd8727a1b59@linaro.org/ patchset.
> 
Looks good, I will ask my colleague working on FW part to take a look.

Thanks,
Fei.

