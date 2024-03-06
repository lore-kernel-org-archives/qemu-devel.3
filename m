Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0B5C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 12:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqop-0006dG-5a; Wed, 06 Mar 2024 07:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rhqok-0006d3-LI; Wed, 06 Mar 2024 07:56:18 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rhqog-0006At-Pr; Wed, 06 Mar 2024 07:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709729775; x=1741265775;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mqq7o2tyuIcBy8STKNcHWXdfHHjBI14CkiJGpQztH0A=;
 b=Ihfmo9ZrxxlYFNfWkyyrsxu6ksI/lAr2JntofXbuVlJpdbM5QDOX81j2
 pkHZwxm3Uz/ROF98okqD36BwL0cO0VM5ZvqzH7l0Xs93NcH/UOAumLUDi
 2D9VUmuUAIPtFb7Q6eM1RApZpH2nQGPwMBYQgGDXnPya0SfEmaiJFyh04
 6WOKjd1+BSYfqq35tiu4wtrsmpltv7xS/eerm5sfKmOJElAM4YXaZSAcD
 8H5RvD0ZrnHFqx+XbhGfhzgsDshA8eMPpekGf0n6oEs+VCCiCsc2ykD3s
 iJPmtXs7uGu5TmUE0yxSu4iGWzNj4v/ynhxUop6LXPOwqGDzAA+/hX4dx g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4200565"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4200565"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 04:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; d="scan'208";a="40734024"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Mar 2024 04:56:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 04:56:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 04:56:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 04:56:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 04:56:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QC4l0ShWG8vzdFgNt7bf7LbK6X54Cm18f/I40jpV48CGGizhOsktqtt5o4h7C77pUcf4xSzONRircs8oAMD4GfZr5JSnI60SWDs0+fPcz68RTM1ye12+RY6x76t6ZRB4DmlAlUWHeAxwfGx2rs9K/aMbWXq2K4jwJVF2iQXrtIwHra06qEaNG9ycC6ktwnh9Syo90kcb0Cs8vc36wAXXHrEzTSggV3Okn2FC+0jjEj8KJbDv6zCp5rIgxRHLHytnENPCdAC75MZmdpDjnrStlmgrQXUj8ac9+Cm26Johpe0NNZCdbe5skth9mY/4haT9WnfTwvoPWlPevhp6EZ9DwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQbVSFxb1IB92/68p9I/7KVCkJO/NmFcrymRb2iJG2k=;
 b=dBQHcVeVVfADX1aAfsNiwiIuyqzk7EqsJcz/NsouccXdlZa2XcFBOuRQ3bfYS/QPWy3UJaXTxJD73bPNZLXZfwy1TQTwIDpM+HrwVscahI4zCuv/MNxaSit3sjbruXuYsNJ57/9j6Nl8O3DeBV6tsZCX82XNd8TLh+00sDTK7WYQkVSHF2Y+7cL5fd0EFh3ZfNHug0j+Agwj84kysiR9ysBEhEfjNwCdMGp2mpI/am8ZqImU+pq0kEuu4TvqT+J4bgM3elyxo/8IEasCFV/1RAwNTqiMypz2tilXC0xPau3Md3/PPqxSvvxovPclXaksSgYtQy83HzSwllC5K7Qf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 12:56:06 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 12:56:06 +0000
Message-ID: <8f5d6664-c075-4d31-bf33-ce24ceeb9b13@intel.com>
Date: Wed, 6 Mar 2024 20:55:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] hw/riscv: Add server platform reference machine
To: Alistair Francis <alistair23@gmail.com>, Atish Patra <atishp@rivosinc.com>
CC: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, <andrei.warkentin@intel.com>,
 <shaolin.xie@alibaba-inc.com>, <ved@rivosinc.com>,
 <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>, <evan.chai@intel.com>,
 <yin.wang@intel.com>, <tech-server-platform@lists.riscv.org>,
 <tech-server-soc@lists.riscv.org>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
 <CAKmqyKMQyDjLkeo+aU58rE6_Vb84QeeZP3FUafw5GuWpk1JmZQ@mail.gmail.com>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <CAKmqyKMQyDjLkeo+aU58rE6_Vb84QeeZP3FUafw5GuWpk1JmZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 862c4745-3d8a-4c41-3a9e-08dc3ddcc971
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtBx+4n2yss8Qif+fR/IJ0ceYYdB2NtRYhna0HXcV6eMz3FihH41/pVBO3lclkqmeZRuLkKN4wm6wkTTFk5qKOwDIvtghJ5QM5U03ZG2TBudPJStHOUqGu2YAJfYhA2oMt3lVFf7wXasPh3pI1LNRcel7jjI5bT3D50NYDg3KoetTp2oUYMvcoC9mgPM7wEPXgMf9XND4gW+znDUpo3H2NOYvr+uCdQwVDUeUsDUzyUqCjLONCqkoRU/0g3tQYeU1VrfiD9UaP/Pdy0+viPeasq7mbAJRIsm8wjr5B4uT8TIiJU+Ac4AyfF1pmxJj5ZF1++B1856KJq04TPqWOG4u/NeMwQJcB7hJCsM8C1HiaxmKyUbwz+k8lP6tXejL3PSC+hPZZAYuQOTg1M/QlXIWmUX5j+OvB6XK14r+gGno8v134BjsX1i3aznMD3YaJ9QcrqkvaKtXXH88Fuf3w0phayxCDteA56jsB2tn5mSOZk2sWdX4IVGYJwixndZkPdtpM86hMyRyCfH6B6tUfK82z0Hhf51wKlrUKJrOLRSFrCip0/dmwKpvTAI0s/1TKwiUa9xrBPKBN9FQnL62xSJ+1QeRRPzeJtbm4dMXqbjDrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGVGL1FXTFRUd2hucHo5ZURmQWExakwzMzVmNCtFUGJOWDlQL25IOFlKN3ZI?=
 =?utf-8?B?aUp2dFMrNnBTMm16MHpPUURNTlhSYXp6eThJeVNVR2hmVUdVUk5SVWd4VkND?=
 =?utf-8?B?MUgwRi9FUlF1aXBKc0J5eUtQV3p4Vk9UWGNxNjdKa2ZhdjltZ0lXdlEzRWgy?=
 =?utf-8?B?dis3dzNRTTZoV1NNOXVnR0MyVTdDWnhNQkNuUnFySS96d0lPcEVydm5LTTJY?=
 =?utf-8?B?MHo4Q2N0OXEvdkR3Z3I2NTlWRHJOV2E2TTlEUUUxK3YyT2dCTE9weWVVNFhW?=
 =?utf-8?B?b0RGOFBMb0pheWpHazlLMFV2TGFwaDFpUEUxQ1U5UEtGUDBZd2tML2FZSCtT?=
 =?utf-8?B?QUdyUGczMW9qQWJaUFZxbm9NYlB0VHdJa2NXb3NaVVM3Z0ZBbjJQNTB1aVJa?=
 =?utf-8?B?QUdBOElDalBtdjBtNTQwV1BGa0FSTCtwS0hHNkpIaThBUTJKLzZ6MkQ3T096?=
 =?utf-8?B?R3hUbmsvcVNWQjNYK0Z4NjJ4bnB0UUpCckpZL2JJOXhNR1F3VnBtRWx3ZFl1?=
 =?utf-8?B?ckIyanpvVzMzNVpsMUxKblFLNnBhV1pHMDN3QUJrYWNZWXZ0UUdOU0VpSGtG?=
 =?utf-8?B?bWpleklxUERUdFg0eTd6YlBiZ3gwcnBxNFV3c0FSamx3VTBLNG9JOTZPYnhW?=
 =?utf-8?B?akFGV1hMTUNiTURmdWszK25MaHBLTGVRU3pLV2xzcVAwY0RpM2pPbmZlSUgw?=
 =?utf-8?B?bjhnT1RQc1piaXo2WTR3a1JqZm1mck1NZmFoTGlRRms0SVFMMFdPaGNMR0h5?=
 =?utf-8?B?ZDd3aEQ4d0E1S09kd2YwS3ZES2hlTFQybTltK1RzSVB0RUF5OFE2cHFDOHgr?=
 =?utf-8?B?azhBdGNKOWsvczFJTkNrNWxVclEzbjJ3QWNnVlNmZmJSU1BMKzBCNG8rczY5?=
 =?utf-8?B?QTVGb1RKemkvYmdsVzJOZTRqbi9RQis1bTBIR3V0UTdZcHovWVJKMkFQUjBR?=
 =?utf-8?B?cWVVZnNmaTF0R3NIYTJ5V1VDMlFFNFFGb3ZCVkwwVVRXSktHeXRBYnVSejMy?=
 =?utf-8?B?dzdZV1h0dXYxQVR6aWpQaFlCS09wUzNyT3FDa2hHMGg1L1BwbGtZOHlGYUNH?=
 =?utf-8?B?KytZTEIrSU5wYVcrdDZ6V0kxL0w0YlZPa1BiMGRRUERTRHc1NXh2KzJHQ2N2?=
 =?utf-8?B?a09CaW93SnRETzB0eUNPZHJvelZNVFVnb1d1N0puOENsQTA3ZUJBK2YvU3ZT?=
 =?utf-8?B?OWV3aElOS2dCYURVM1VaOGNTRGczTVZROEpCZVVONjVDb0tpSHVvWi9Rampw?=
 =?utf-8?B?ZXpUWDVRazYveWdHL1FNQWQvR2FqUE5MK3B2cXBFNzl4Q3BSbThXeXBVeXgr?=
 =?utf-8?B?RldsbUYxSklZdFRMV3lUSjhEaUp2RDd0TVE1VDBDdVVzMmpOL1BqNnVPQTlm?=
 =?utf-8?B?SktJRnloendLMnRrUGpsSHlSQ2pxM08zY1FCblUreU9qcG52SFpIbXY3SUxr?=
 =?utf-8?B?M3lXWVZIMHhjWXFYbWZSdkl4dFloZFJLRTErcXlUYjBxK2xxRnVTamdwbGxM?=
 =?utf-8?B?ZjJtTFB4SHpFVXFZblVwRDQxSngvV3NnTW1OWDBsanhMMzM2WVJrWWZha3o1?=
 =?utf-8?B?TkhHM2dsVXBQMmluM05jRHp3QUVRb2VZbUp2a1FZZzVtcDdJWXNEZjhJYWFE?=
 =?utf-8?B?TzBMdENYSzJGeUR5dXJMWTJkK0hmckZ3ejZrWUNWeUM4NzlMSm55dU4wK0Jl?=
 =?utf-8?B?dTl2Si9mVHN6b0RkSndlblcyWVUvbFZoRDdpenZuYmF1RDlUYnNCcHZFY1ZX?=
 =?utf-8?B?TXdZbXB2N3RXZjBGQkhDUEQybmIrL05oRHRUN1dZdVVDZjUwdDNwQzU1aFVM?=
 =?utf-8?B?WHorcjJHU0MydWJ4em5DN3l3c1B6Qmk2SnYxMGQ4ZnY5YTFvc3VrS2prR1VB?=
 =?utf-8?B?dW1yaHZIZ2pIVTNKZ1RvaFhQMmtLYVR2Z2R4T2JnZEh2ZFJDRVhCa2RHVnZx?=
 =?utf-8?B?bXR0emM0bWJXR1VpWkI0eS85Wklqd3VBMUpHTkJ2V3BxTU4xeEVNa1FpalJq?=
 =?utf-8?B?QmJ2NUc3OWl4OGlPdHZiYWU5NTV1UUZva1UrQ00xN2FCMmVqclVhZm9OaXdD?=
 =?utf-8?B?TW5zbndscCthaTRURUptRXUxVFg5aW1pY2gzS3RiU08yQWY2TnlWdzJySVhC?=
 =?utf-8?Q?+fYvnbnFegI3XYRYZk7nHYppG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 862c4745-3d8a-4c41-3a9e-08dc3ddcc971
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:56:06.5658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wvj0GvsnBUUILRvO3a/4Cqgkorx6Y/eSU4Ft1ev19YxLeLeRAThrgfz0dCnw5DbwfTqMkR7vDqGi7LtFwif7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/6/2024 8:19 AM, Alistair Francis wrote:
> On Mon, Mar 4, 2024 at 8:28 PM Fei Wu <fei2.wu@intel.com> wrote:
>>
>> The RISC-V Server Platform specification[1] defines a standardized set
>> of hardware and software capabilities, that portable system software,
>> such as OS and hypervisors can rely on being present in a RISC-V server
>> platform.
>>
>> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
>> short) machine type is added to provide a environment for firmware/OS
>> development and testing. The main features included in rvsp-ref are:
>>
>>  - Based on riscv virt machine type
>>  - A new memory map as close as virt machine as possible
>>  - A new virt CPU type rvsp-ref-cpu for server platform compliance
>>  - AIA
>>  - PCIe AHCI
>>  - PCIe NIC
>>  - No virtio device
>>  - No fw_cfg device
>>  - No ACPI table provided
>>  - Only minimal device tree nodes
>>
>> [1] https://github.com/riscv-non-isa/riscv-server-platform
> 
> + Atish
> 
>>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> ---
>>  configs/devices/riscv64-softmmu/default.mak |    1 +
>>  hw/riscv/Kconfig                            |   13 +
>>  hw/riscv/meson.build                        |    1 +
>>  hw/riscv/server_platform_ref.c              | 1244 +++++++++++++++++++
>>  4 files changed, 1259 insertions(+)
>>  create mode 100644 hw/riscv/server_platform_ref.c
>>
>> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
>> index 3f68059448..a1d98e49ef 100644
>> --- a/configs/devices/riscv64-softmmu/default.mak
>> +++ b/configs/devices/riscv64-softmmu/default.mak
>> @@ -10,5 +10,6 @@ CONFIG_SPIKE=y
>>  CONFIG_SIFIVE_E=y
>>  CONFIG_SIFIVE_U=y
>>  CONFIG_RISCV_VIRT=y
>> +CONFIG_SERVER_PLATFORM_REF=y
>>  CONFIG_MICROCHIP_PFSOC=y
>>  CONFIG_SHAKTI_C=y
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index 5d644eb7b1..debac5a7f5 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -48,6 +48,19 @@ config RISCV_VIRT
>>      select ACPI
>>      select ACPI_PCI
>>
>> +config SERVER_PLATFORM_REF
>> +    bool
>> +    select RISCV_NUMA
>> +    select GOLDFISH_RTC
>> +    select PCI
>> +    select PCI_EXPRESS_GENERIC_BRIDGE
>> +    select PFLASH_CFI01
>> +    select SERIAL
>> +    select RISCV_ACLINT
>> +    select RISCV_APLIC
>> +    select RISCV_IMSIC
>> +    select SIFIVE_TEST
> 
> Do we really need SiFive Test in the server platform?
> 
It's used to reset the system, is there any better choice?

Probably I can remove the "sifive,test1 sifive,test0" from the
compatible list in fdt, and only keep "syscon", I see opensbi has
already removed that support in commit c2e602707.

> Same with the goldfish RTC?
> 
Although the spec doesn't make RTC mandatory, it should be a common
practice having a RTC on server, so I add a RTC here no matter it's
goldfish or not.

>> +
>>  config SHAKTI_C
>>      bool
>>      select RISCV_ACLINT
>> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
>> index 2f7ee81be3..bb3aff91ea 100644
>> --- a/hw/riscv/meson.build
>> +++ b/hw/riscv/meson.build
>> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>>  riscv_ss.add(files('riscv_hart.c'))
>>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
>>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>> new file mode 100644
>> index 0000000000..ae90c4b27a
>> --- /dev/null
>> +++ b/hw/riscv/server_platform_ref.c
>> @@ -0,0 +1,1244 @@
>> +/*
>> + * QEMU RISC-V Server Platfrom (RVSP) Reference Board
> 
> Platform
> 
OK.

>> +static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>> +                                          DeviceState *irqchip,
>> +                                          RVSPMachineState *s)
>> +{
>> +    DeviceState *dev;
>> +    PCIHostState *pci;
>> +    PCIDevice *pdev_ahci;
>> +    AHCIPCIState *ich9;
>> +    DriveInfo *hd[NUM_SATA_PORTS];
>> +    MemoryRegion *ecam_alias, *ecam_reg;
>> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
>> +    hwaddr ecam_base = rvsp_ref_memmap[RVSP_PCIE_ECAM].base;
>> +    hwaddr ecam_size = rvsp_ref_memmap[RVSP_PCIE_ECAM].size;
>> +    hwaddr mmio_base = rvsp_ref_memmap[RVSP_PCIE_MMIO].base;
>> +    hwaddr mmio_size = rvsp_ref_memmap[RVSP_PCIE_MMIO].size;
>> +    hwaddr high_mmio_base = rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].base;
>> +    hwaddr high_mmio_size = rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].size;
>> +    hwaddr pio_base = rvsp_ref_memmap[RVSP_PCIE_PIO].base;
>> +    hwaddr pio_size = rvsp_ref_memmap[RVSP_PCIE_PIO].size;
>> +    MachineClass *mc = MACHINE_GET_CLASS(s);
>> +    qemu_irq irq;
>> +    int i;
>> +
>> +    dev = qdev_new(TYPE_GPEX_HOST);
>> +
>> +    /* Set GPEX object properties for the rvsp ref machine */
>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BASE,
>> +                            ecam_base, NULL);
>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZE,
>> +                            ecam_size, NULL);
>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
>> +                             PCI_HOST_BELOW_4G_MMIO_BASE,
>> +                             mmio_base, NULL);
>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_BELOW_4G_MMIO_SIZE,
>> +                            mmio_size, NULL);
>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
>> +                             PCI_HOST_ABOVE_4G_MMIO_BASE,
>> +                             high_mmio_base, NULL);
>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ABOVE_4G_MMIO_SIZE,
>> +                            high_mmio_size, NULL);
>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BASE,
>> +                            pio_base, NULL);
>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
>> +                            pio_size, NULL);
>> +
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +
>> +    ecam_alias = g_new0(MemoryRegion, 1);
>> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
>> +                             ecam_reg, 0, ecam_size);
>> +    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias);
>> +
>> +    mmio_alias = g_new0(MemoryRegion, 1);
>> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
>> +                             mmio_reg, mmio_base, mmio_size);
>> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
>> +
>> +    /* Map high MMIO space */
>> +    high_mmio_alias = g_new0(MemoryRegion, 1);
>> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-high",
>> +                             mmio_reg, high_mmio_base, high_mmio_size);
>> +    memory_region_add_subregion(get_system_memory(), high_mmio_base,
>> +                                high_mmio_alias);
>> +
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
>> +
>> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
>> +        irq = qdev_get_gpio_in(irqchip, RVSP_PCIE_IRQ + i);
>> +
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
>> +        gpex_set_irq_num(GPEX_HOST(dev), i, RVSP_PCIE_IRQ + i);
>> +    }
>> +
>> +    pci = PCI_HOST_BRIDGE(dev);
>> +    pci_init_nic_devices(pci->bus, mc->default_nic);
>> +    /* IDE disk setup.  */
>> +    pdev_ahci = pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
>> +    ich9 = ICH9_AHCI(pdev_ahci);
>> +    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
>> +    ide_drive_get(hd, ich9->ahci.ports);
>> +    ahci_ide_create_devs(&ich9->ahci, hd);
>> +
>> +    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(GPEX_HOST(dev))->bus;
>> +    return dev;
>> +}
> 
> We should share as much of this code as possible with the virt machine.
> 
This function references multiple rvsp specific variables, some
refactorings are needed to group all the information of
ecam/mmio/high_mmio/pio/irq and pass them to virt and rvsp respectively.
I see arm virt/sbsa-ref are seperated clearly and no sharing between
them. It has the benefit there is no side effect between them. Should we
use the same policy?

Thanks,
Fei.

> Alistair
> 
>> +
>> +static DeviceState *rvsp_ref_create_aia(int aia_guests,
>> +                                        const MemMapEntry *memmap, int socket,
>> +                                        int base_hartid, int hart_count)
>> +{
>> +    int i;
>> +    hwaddr addr;
>> +    uint32_t guest_bits;
>> +    DeviceState *aplic_s = NULL;
>> +    DeviceState *aplic_m = NULL;
>> +    bool msimode = true;
>> +
>> +    /* Per-socket M-level IMSICs */
>> +    addr = memmap[RVSP_IMSIC_M].base +
>> +           socket * RVSP_IMSIC_GROUP_MAX_SIZE;
>> +    for (i = 0; i < hart_count; i++) {
>> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
>> +                           base_hartid + i, true, 1,
>> +                           RVSP_IRQCHIP_NUM_MSIS);
>> +    }
>> +
>> +    /* Per-socket S-level IMSICs */
>> +    guest_bits = imsic_num_bits(aia_guests + 1);
>> +    addr = memmap[RVSP_IMSIC_S].base + socket * RVSP_IMSIC_GROUP_MAX_SIZE;
>> +    for (i = 0; i < hart_count; i++) {
>> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
>> +                           base_hartid + i, false, 1 + aia_guests,
>> +                           RVSP_IRQCHIP_NUM_MSIS);
>> +    }
>> +
>> +    /* Per-socket M-level APLIC */
>> +    aplic_m = riscv_aplic_create(memmap[RVSP_APLIC_M].base +
>> +                                 socket * memmap[RVSP_APLIC_M].size,
>> +                                 memmap[RVSP_APLIC_M].size,
>> +                                 (msimode) ? 0 : base_hartid,
>> +                                 (msimode) ? 0 : hart_count,
>> +                                 RVSP_IRQCHIP_NUM_SOURCES,
>> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
>> +                                 msimode, true, NULL);
>> +
>> +    /* Per-socket S-level APLIC */
>> +    aplic_s = riscv_aplic_create(memmap[RVSP_APLIC_S].base +
>> +                                 socket * memmap[RVSP_APLIC_S].size,
>> +                                 memmap[RVSP_APLIC_S].size,
>> +                                 (msimode) ? 0 : base_hartid,
>> +                                 (msimode) ? 0 : hart_count,
>> +                                 RVSP_IRQCHIP_NUM_SOURCES,
>> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
>> +                                 msimode, false, aplic_m);
>> +
>> +    (void)aplic_s;
>> +    return aplic_m;
>> +}
>> +
>> +static void rvsp_ref_machine_done(Notifier *notifier, void *data)
>> +{
>> +    RVSPMachineState *s = container_of(notifier, RVSPMachineState,
>> +                                       machine_done);
>> +    const MemMapEntry *memmap = rvsp_ref_memmap;
>> +    MachineState *machine = MACHINE(s);
>> +    target_ulong start_addr = memmap[RVSP_DRAM].base;
>> +    target_ulong firmware_end_addr, kernel_start_addr;
>> +    const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
>> +    uint64_t fdt_load_addr;
>> +    uint64_t kernel_entry = 0;
>> +    BlockBackend *pflash_blk0;
>> +
>> +    /* load/create device tree */
>> +    if (machine->dtb) {
>> +        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
>> +        if (!machine->fdt) {
>> +            error_report("load_device_tree() failed");
>> +            exit(1);
>> +        }
>> +    } else {
>> +        create_fdt(s, memmap);
>> +    }
>> +
>> +    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
>> +                                                     start_addr, NULL);
>> +
>> +    pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
>> +    if (pflash_blk0) {
>> +        if (machine->firmware && !strcmp(machine->firmware, "none")) {
>> +            /*
>> +             * Pflash was supplied but bios is none and not KVM guest,
>> +             * let's overwrite the address we jump to after reset to
>> +             * the base of the flash.
>> +             */
>> +            start_addr = rvsp_ref_memmap[RVSP_FLASH].base;
>> +        } else {
>> +            /*
>> +             * Pflash was supplied but either KVM guest or bios is not none.
>> +             * In this case, base of the flash would contain S-mode payload.
>> +             */
>> +            riscv_setup_firmware_boot(machine);
>> +            kernel_entry = rvsp_ref_memmap[RVSP_FLASH].base;
>> +        }
>> +    }
>> +
>> +    if (machine->kernel_filename && !kernel_entry) {
>> +        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
>> +                                                         firmware_end_addr);
>> +
>> +        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
>> +                                         kernel_start_addr, true, NULL);
>> +    }
>> +
>> +    fdt_load_addr = riscv_compute_fdt_addr(memmap[RVSP_DRAM].base,
>> +                                           memmap[RVSP_DRAM].size,
>> +                                           machine);
>> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
>> +
>> +    /* load the reset vector */
>> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
>> +                              rvsp_ref_memmap[RVSP_MROM].base,
>> +                              rvsp_ref_memmap[RVSP_MROM].size, kernel_entry,
>> +                              fdt_load_addr);
>> +
>> +}
>> +
>> +static void rvsp_ref_machine_init(MachineState *machine)
>> +{
>> +    const MemMapEntry *memmap = rvsp_ref_memmap;
>> +    RVSPMachineState *s = RVSP_REF_MACHINE(machine);
>> +    MemoryRegion *system_memory = get_system_memory();
>> +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>> +    char *soc_name;
>> +    DeviceState *mmio_irqchip, *pcie_irqchip;
>> +    int i, base_hartid, hart_count;
>> +    int socket_count = riscv_socket_count(machine);
>> +
>> +    /* Check socket count limit */
>> +    if (RVSP_SOCKETS_MAX < socket_count) {
>> +        error_report("number of sockets/nodes should be less than %d",
>> +            RVSP_SOCKETS_MAX);
>> +        exit(1);
>> +    }
>> +
>> +    if (!tcg_enabled()) {
>> +        error_report("'aclint' is only available with TCG acceleration");
>> +        exit(1);
>> +    }
>> +
>> +    /* Initialize sockets */
>> +    mmio_irqchip = pcie_irqchip = NULL;
>> +    for (i = 0; i < socket_count; i++) {
>> +        if (!riscv_socket_check_hartids(machine, i)) {
>> +            error_report("discontinuous hartids in socket%d", i);
>> +            exit(1);
>> +        }
>> +
>> +        base_hartid = riscv_socket_first_hartid(machine, i);
>> +        if (base_hartid < 0) {
>> +            error_report("can't find hartid base for socket%d", i);
>> +            exit(1);
>> +        }
>> +
>> +        hart_count = riscv_socket_hart_count(machine, i);
>> +        if (hart_count < 0) {
>> +            error_report("can't find hart count for socket%d", i);
>> +            exit(1);
>> +        }
>> +
>> +        soc_name = g_strdup_printf("soc%d", i);
>> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
>> +                                TYPE_RISCV_HART_ARRAY);
>> +        g_free(soc_name);
>> +        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
>> +                                machine->cpu_type, &error_abort);
>> +        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
>> +                                base_hartid, &error_abort);
>> +        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
>> +                                hart_count, &error_abort);
>> +        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
>> +
>> +        /* Per-socket ACLINT MTIMER */
>> +        riscv_aclint_mtimer_create(memmap[RVSP_ACLINT].base +
>> +                i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>> +            RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>> +            base_hartid, hart_count,
>> +            RISCV_ACLINT_DEFAULT_MTIMECMP,
>> +            RISCV_ACLINT_DEFAULT_MTIME,
>> +            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
>> +
>> +        /* Per-socket interrupt controller */
>> +        s->irqchip[i] = rvsp_ref_create_aia(s->aia_guests,
>> +                                            memmap, i, base_hartid,
>> +                                            hart_count);
>> +
>> +        /* Try to use different IRQCHIP instance based device type */
>> +        if (i == 0) {
>> +            mmio_irqchip = s->irqchip[i];
>> +            pcie_irqchip = s->irqchip[i];
>> +        }
>> +        if (i == 1) {
>> +            pcie_irqchip = s->irqchip[i];
>> +        }
>> +    }
>> +
>> +    s->memmap = rvsp_ref_memmap;
>> +
>> +    /* register system main memory (actual RAM) */
>> +    memory_region_add_subregion(system_memory, memmap[RVSP_DRAM].base,
>> +        machine->ram);
>> +
>> +    /* boot rom */
>> +    memory_region_init_rom(mask_rom, NULL, "riscv_rvsp_ref_board.mrom",
>> +                           memmap[RVSP_MROM].size, &error_fatal);
>> +    memory_region_add_subregion(system_memory, memmap[RVSP_MROM].base,
>> +                                mask_rom);
>> +
>> +    /* SiFive Test MMIO device */
>> +    sifive_test_create(memmap[RVSP_TEST].base);
>> +
>> +    gpex_pcie_init(system_memory, pcie_irqchip, s);
>> +
>> +    serial_mm_init(system_memory, memmap[RVSP_UART0].base,
>> +        0, qdev_get_gpio_in(mmio_irqchip, RVSP_UART0_IRQ), 399193,
>> +        serial_hd(0), DEVICE_LITTLE_ENDIAN);
>> +
>> +    sysbus_create_simple("goldfish_rtc", memmap[RVSP_RTC].base,
>> +        qdev_get_gpio_in(mmio_irqchip, RVSP_RTC_IRQ));
>> +
>> +    for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
>> +        /* Map legacy -drive if=pflash to machine properties */
>> +        pflash_cfi01_legacy_drive(s->flash[i],
>> +                                  drive_get(IF_PFLASH, 0, i));
>> +    }
>> +    rvsp_flash_map(s, system_memory);
>> +
>> +    s->machine_done.notify = rvsp_ref_machine_done;
>> +    qemu_add_machine_init_done_notifier(&s->machine_done);
>> +}
>> +
>> +static void rvsp_ref_machine_instance_init(Object *obj)
>> +{
>> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
>> +
>> +    rvsp_flash_create(s);
>> +}
>> +
>> +static char *rvsp_ref_get_aia_guests(Object *obj, Error **errp)
>> +{
>> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
>> +    char val[32];
>> +
>> +    sprintf(val, "%d", s->aia_guests);
>> +    return g_strdup(val);
>> +}
>> +
>> +static void rvsp_ref_set_aia_guests(Object *obj, const char *val, Error **errp)
>> +{
>> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
>> +
>> +    s->aia_guests = atoi(val);
>> +    if (s->aia_guests < 0 || s->aia_guests > RVSP_IRQCHIP_MAX_GUESTS) {
>> +        error_setg(errp, "Invalid number of AIA IMSIC guests");
>> +        error_append_hint(errp, "Valid values be between 0 and %d.\n",
>> +                          RVSP_IRQCHIP_MAX_GUESTS);
>> +    }
>> +}
>> +
>> +static void rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>> +{
>> +    char str[128];
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +
>> +    mc->desc = "RISC-V Server SoC Reference board";
>> +    mc->init = rvsp_ref_machine_init;
>> +    mc->max_cpus = RVSP_CPUS_MAX;
>> +    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>> +    mc->pci_allow_0_address = true;
>> +    mc->default_nic = "e1000e";
>> +    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>> +    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
>> +    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
>> +    mc->numa_mem_supported = true;
>> +    /* platform instead of architectural choice */
>> +    mc->cpu_cluster_has_numa_boundary = true;
>> +    mc->default_ram_id = "riscv_rvsp_ref_board.ram";
>> +
>> +    object_class_property_add_str(oc, "aia-guests",
>> +                                  rvsp_ref_get_aia_guests,
>> +                                  rvsp_ref_set_aia_guests);
>> +    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
>> +                 "should be between 0 and %d.", RVSP_IRQCHIP_MAX_GUESTS);
>> +    object_class_property_set_description(oc, "aia-guests", str);
>> +}
>> +
>> +static const TypeInfo rvsp_ref_typeinfo = {
>> +    .name       = TYPE_RVSP_REF_MACHINE,
>> +    .parent     = TYPE_MACHINE,
>> +    .class_init = rvsp_ref_machine_class_init,
>> +    .instance_init = rvsp_ref_machine_instance_init,
>> +    .instance_size = sizeof(RVSPMachineState),
>> +};
>> +
>> +static void rvsp_ref_init_register_types(void)
>> +{
>> +    type_register_static(&rvsp_ref_typeinfo);
>> +}
>> +
>> +type_init(rvsp_ref_init_register_types)
>> --
>> 2.34.1
>>
>>


