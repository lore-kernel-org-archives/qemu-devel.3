Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1C0C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeFq-0007qD-J5; Mon, 11 Mar 2024 07:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rjeFh-0007nD-BL; Mon, 11 Mar 2024 07:55:33 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rjeFc-0003FV-31; Mon, 11 Mar 2024 07:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710158128; x=1741694128;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vhUCePKn0r5Mqz6FO9/bHsGV+X7S0SlMtaMYCJlZ1fo=;
 b=QUax7QlrM6DPMsotc7gQ/tbhOJeaL1qpU0SeI59NSS8u/JAfSuA2kwnT
 M2lewzqpvcP0VBitGWEMyhggFEtxBhSyRVKnSz5yMf73NLEY1sjSgfGab
 +qXrFgjP8z9g4RSfQGVZWrb3ajs/uxWEHTnAHqeSdu7y1/B9Gj0aguSK1
 4NDpjtb2WL9tIHo79kkPe/44j+WraihAY53TvOOh+JVH/xjaFXsq5SB6P
 ocnk0/tBG+PsJhQM+qkn/vQTqz5x6hNjBl1ge+/LvXvBIJMHrtlsBjf4D
 G/MUOahW3IlPEnoApsYpoCEGMTBYZoTIzG+oNslt+X/ihdfOawsFe+pKI Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22268507"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="22268507"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 04:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="11056075"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Mar 2024 04:55:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 04:55:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 04:55:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 04:55:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 04:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+A9ejLyk5hJEbh1BNIiCEJb7TREgWrowLaNFpyVr5D8IgYH77E259tEeklhU+20evFDPJQQj+g5dVo+HVbXPAO5X65qykpPyGv3JWe56q8WzzhrwPUGk2LCSB9kouZZzT6XZJbtu5qmmNcD+tFLDe218kIzZyMXynnbIgJcEr/iq/C8fKkbJwIcDrokjfq6OBIZhmzWDgHnBLU2iibnkK9kSP2+hwTOF10gu5qlPdkvP1TZ8s2T0LqQRZOfwRSa33h5QxSW8ueO7ot2Ru0mXf+aXRwQKDWY4ARPRiW5AOJk06kHfO8CzEgLW2qgR0H2lLBhghGiDCghooxcg+GNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgjoVrXM3skTAPv19aosmtHdKZGd5D2L5nIC3TM50G0=;
 b=PFfzinnSYyB+5gA/1GFqKE0V/gUG4ZW9sWbq1x7yFLpu/b98qHOuMA8E9yYXWqqXs5Gq9pf6bWccpFQf50pXznogP7Ugtk6+IyIg0+aS1MJ0wsO21GozLyKfRjxZHGpSjSCNtqxdH5dG8mAQLOKWuLF7CRHQe+fVee6Pd0Nq97MWEIl2LsfeTHz33+3sRqUqXCF+UnCLduqzokw46/Iltr025JfC8yEPi8hM1N29dAJhu53n8nXIcr3KQXL5XwYPlusJ1crtk7aInDM46ZKZ6a4RoEwEwpxe22oaVvpndGHZSyBup3HQMWTItS3FG0cWorJ1VCG/dQo3/BBKSqG6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by SN7PR11MB7467.namprd11.prod.outlook.com (2603:10b6:806:34f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Mon, 11 Mar
 2024 11:55:18 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7386.015; Mon, 11 Mar 2024
 11:55:17 +0000
Message-ID: <fee8e89a-7d87-43b8-bc87-af76a67c4317@intel.com>
Date: Mon, 11 Mar 2024 19:55:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-platform] [RFC 1/2] hw/riscv: Add server
 platform reference machine
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
CC: Alistair Francis <alistair23@gmail.com>, Atish Kumar Patra
 <atishp@rivosinc.com>, <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <andrei.warkentin@intel.com>, <shaolin.xie@alibaba-inc.com>,
 <ved@rivosinc.com>, <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>,
 <evan.chai@intel.com>, <yin.wang@intel.com>,
 <tech-server-platform@lists.riscv.org>, <tech-server-soc@lists.riscv.org>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
 <CAKmqyKMQyDjLkeo+aU58rE6_Vb84QeeZP3FUafw5GuWpk1JmZQ@mail.gmail.com>
 <8f5d6664-c075-4d31-bf33-ce24ceeb9b13@intel.com>
 <CAHBxVyHP1hgGWg6EByX6XzqmTm_Tr0uw7tk65KWcytNYsKdw8w@mail.gmail.com>
 <CAKmqyKM08RwR7RybMGaN6CpmbHJrLwx0DSjz_A1w6h0AkW12rQ@mail.gmail.com>
 <18efc373-b98b-4a9f-96c5-c6821793138f@intel.com>
 <20240308-48ff9db3408048d387d6cfa4@orel>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20240308-48ff9db3408048d387d6cfa4@orel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|SN7PR11MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 882f5b7d-398d-4b39-519e-08dc41c21e73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzuWqjrTQnNLQwwGl2Y3c/CNrTaDcQ/yNPgjAorxifmfzwocaLn3h76G0TKsTH8FHmzXpgUe+tBR2F3/13/5b0dOlOdanATLEMGcjiPuYWvDA0BvLN4hOtPv7nVewQiMt0vdDcmpNLpWOIATHUepbTFtYVv56B+Zmu0kqaTl+BP76Dpzcu9C2PS/zymSaH9W++06lp2WpyJr7VjXWxVJVqHkY1de13aRiriqjryaiCi34A4OM6p/fFxv9E/ZpJPlTr1ZEiWoH9bdM2snPmPwocnotsPt2gwjz27AzjpuRqrHewVN9xJyFj3Zyljg7tyUw8oTqEL+LD9Tf8GSUiaj1B7QqsV31R7SOmTQH8rszZuPvIIxrVBzdc/Jy5cTm/LkPdTm7aATMnEFEnPuooq3ee32pvZbeAAMtHxgW8LZMUsbypn8jWh/s5UDka+reT2Kl4yG01qXOGWerKlvf8Y6D4tgny9R9/dJNmHGZI3vdx00R/1OfOXckx8gN/vbIZoEV5xaJUaI8yT6FcFzDrCGKgVHGWXtRMA05qwfsfadYWl4hiRn4C31q31WHUnWnH0PuMTrnI9aBXqw3rom7Vg6Z5IsZScMj8TI4aBAxn8/YKqXvp9inbqE28j0e5535YBC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9QS0oyaXNtbGcxb1FSbjE5dU5hQlMwSklLTlI2VzJCUVplTzA5SmxEbWNW?=
 =?utf-8?B?WDNTakQ4Nm5Jcmp6VnZobU1KWlIwY0dGMmo1SURuekNXR1RCaTI1di9aeVZw?=
 =?utf-8?B?NitGdXZGVmliMkVYQXBWUWNBbm5MZDZQcDcyckgrM3hWUG5pdUNmOGVTaHkv?=
 =?utf-8?B?bkw0VWZqN3g0UllUMUFCRm5DdE1SbnZrciszQlJ6N2lYODMvOVZiemxsNmlz?=
 =?utf-8?B?NXdHNE93ZUpxaFY0QStCYThvb25HVFNCcDV3Z05oMklCVHRCNmNjYnF0c0FO?=
 =?utf-8?B?RXNQRmtld1UrenJWalVQNnA3Z3cyL3d5U3J3Lzh2ZEwzYld1T1phbGZXMUpM?=
 =?utf-8?B?UE9yNDFtYysyV1BpTDRvOUFmMXZnY3pyTmNLb2RHOWJrK1JPVTltQ0x3Rld1?=
 =?utf-8?B?YWMzSnNBQXdQSitscXd0aUdGcGRPN3d1eVNmRDVCTHhIVUpOczdzU2lrbHNC?=
 =?utf-8?B?OWdobTNjZFpxTTU4ZWIxUEREaXNIMVZUTUVCS0dWckEvenJ3M0dMMDJ6OHZC?=
 =?utf-8?B?dkdJSjI4NWRhaTF3MUFRcVNRUzhnSldIM09Dbng1L01xaHplU0Z1dENlTkRr?=
 =?utf-8?B?dVRQanAxWUdRSldmVjBZQ1FTUjk0Z2w1UER6U2FSUGRRU0NNVGxUaTM0R1oz?=
 =?utf-8?B?OTgyU2pEeWhUUDZvSDhjN0VvR3dUNkFjWk9maWRRMSt5RUdyV25xMzE2R042?=
 =?utf-8?B?eGorWlR5cEJ4L0tlYWRYbFlDR3QveTJoQ2VBYnBtRHMrajN2a2Jra0YyNW5P?=
 =?utf-8?B?WXdOaCtreVhXVllvVlRPUXRReGNLL0puT3oxSHl2ZXhDYkY1TktqVlo4Ujcy?=
 =?utf-8?B?bzZjZW9BREFVVll3Q3hrcGNaS1prTWxwdEN2M2lPT1locFU4TXRMdlYvaEVF?=
 =?utf-8?B?RWdlTTIwUGxCV2pmbmlsdVpUYWsyOGRvYXJjSHZqaEVvb091Y2ZRUFlMV01i?=
 =?utf-8?B?akNPR3F5eTVITmhFSDdtbmhZTldjcXUrLzdWY3MydEY1M0JxaVFieEpjK0Z2?=
 =?utf-8?B?MDE0OTZabk9KN3ZaRktJL0Q2ZWRObTMvS3NDSzVmd2x0d0J4VkZtdXRFUFpm?=
 =?utf-8?B?anBuSXRzU1VVYWVWYlp2SDdzb0FDNTZFRUdmc1A0V3FWcVlHVitTZU5rM1Aw?=
 =?utf-8?B?dHRUOTBxQ0V0b3JXNGxuemtzNURidDZzY05zWXFCMTNTVm1kOXlaSVJHekRw?=
 =?utf-8?B?M01wdWJNTTRwT2lnRkplS2hCMkRtUFNCeWVNNnJNZ1p3UGRwRDdBWnRrR2M5?=
 =?utf-8?B?UGZRek0xeHIwQWR4bDdJTmd5MGpoSWdXaTdZcHBjM1R4Nm15a3RGWUlOOE1U?=
 =?utf-8?B?bHVQa3RvanBpZFVydEh5MXFUUmp4SzFmcVduN2daQ3poeTUwTFdEcHlpQ0ll?=
 =?utf-8?B?ZkhnR0xiYXU0c1VsdWM5Yk5DKzNSNHhEdHlJNWJDTUFHM3lMMDZ2Q3VjU1Fx?=
 =?utf-8?B?RG53UmloYVpsR0VLdmZaUWJzcmdld3F5aVhRVGNvYUxjVjdZbnVOc3piUEJD?=
 =?utf-8?B?TlhGRmNpMGxIVDBBOVpJOFoyZkVUQ2s1L08wL0tLRnRkRVdtOUUwVll1QTVv?=
 =?utf-8?B?cEdEM2x5S3M3cTFaVkZVRGovREZQWlFVVkVPamFhOEZzd1hYT014eEtxWVM3?=
 =?utf-8?B?VDBrV0xCM0hYODJuczFyN0YvRVprdjZ0WFpUZ1V1MDZzZ0VmYlNPb1RsbWl6?=
 =?utf-8?B?MjFGUDNHaCs0MUVnaHgvcTBac3psVmJnQm9vS2xhaXFqc3JYWWthMWdBUWN2?=
 =?utf-8?B?TGVGU0lKSWY5eGJjRDZNN2UxS3NpcHZwWitHTnI0ODF0emxNRk95dVFsd2Jm?=
 =?utf-8?B?THhlQ1dTWHF2UE4xTXJqWWlNMkFvVjdMWEFkQXUvZm9WNlR2czREZ2MwQ004?=
 =?utf-8?B?SjJLYmg2R1VJK0lxemNVWFhPNmM1QWh5T1ZuNlB3VllhUEg0K0NwdGFzNTBh?=
 =?utf-8?B?TStpck5US2RrNlpQV0hVak9ZOVJsUktzM1E0b2hPVUxMeUNMdHBiS3p2YSt1?=
 =?utf-8?B?aTR2ZUMrVndqTVQ5Y1JMSlc1K1pKdDROR3IybUpTQmJCVTh2NkE3V3B2QlBW?=
 =?utf-8?B?N1FmTkZuVFUyUzlRdlFRQ0dEakZXcnZ3UVkyaGp2Q0xlbjl2NDJzN1JyZEhQ?=
 =?utf-8?Q?CWOWmRt2QuutBpRjk0iX+JsM1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 882f5b7d-398d-4b39-519e-08dc41c21e73
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:55:17.3653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GxC9Vq38Gs5SgiqNG2LjxS5+5vl5jvt+8/QGtQAc34lFohxqzkVwUsZlfUWJiZIGyYlkWxuOOZKGqYssMZS/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7467
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/8/2024 5:20 PM, Andrew Jones wrote:
> On Thu, Mar 07, 2024 at 02:26:18PM +0800, Wu, Fei wrote:
>> On 3/7/2024 8:48 AM, Alistair Francis wrote:
>>> On Thu, Mar 7, 2024 at 5:13 AM Atish Kumar Patra <atishp@rivosinc.com> wrote:
>>>>
>>>> On Wed, Mar 6, 2024 at 4:56 AM Wu, Fei <fei2.wu@intel.com> wrote:
>>>>>
>>>>> On 3/6/2024 8:19 AM, Alistair Francis wrote:
>>>>>> On Mon, Mar 4, 2024 at 8:28 PM Fei Wu <fei2.wu@intel.com> wrote:
> ...
>>>>>>> +config SERVER_PLATFORM_REF
>>>>>>> +    bool
>>>>>>> +    select RISCV_NUMA
>>>>>>> +    select GOLDFISH_RTC
>>>>>>> +    select PCI
>>>>>>> +    select PCI_EXPRESS_GENERIC_BRIDGE
>>>>>>> +    select PFLASH_CFI01
>>>>>>> +    select SERIAL
>>>>>>> +    select RISCV_ACLINT
>>>>>>> +    select RISCV_APLIC
>>>>>>> +    select RISCV_IMSIC
>>>>>>> +    select SIFIVE_TEST
>>>>>>
>>>>>> Do we really need SiFive Test in the server platform?
>>>>>>
>>>>> It's used to reset the system, is there any better choice?
>>>
>>> If we add this now we are stuck with it forever (or at least a long
>>> time). So it'd be nice to think about these and decide if these really
>>> are the best way to do things. We don't have to just copy the existing
>>> virt machine.
>>>
>> We need a solution to poweroff/reboot, and sifive test is one of the
>> hardware implementations, so in general I think it's okay. But I agree
>> Sifive test looks a device for testing only.
>>
>>> There must be a more standard way to do this then MMIO mapped SiFive hardware?
>>>
>> The mapped MMIO mechanism leveraged by Sifive test by itself is kinda
>> generic, the sbsa_ec for sbsa-ref is also an MMIO mapped device. These
>> two devices look very similar except different encodings of the
>> shutdown/reboot command.
>>
>> Probably we can have a generic shutdown/reboot device in QEMU for both
>> sifive test and sbsa_ec, and likely more (not in this patch series). In
>> this way, sifive test device will be replaced by this more generic
>> device. Any suggestions?
> 
> Operating systems shouldn't need to implement odd-ball device drivers to
> function on a reference of a standard platform. So the reference platform
> should only be comprised of devices which have specifications and already,
> or will, have DT bindings. Generic devices would be best, but I don't
> think it should be a problem to use devices from multiple vendors. The
> devices just need to allow GPL drivers to be written. With all that in
> mind, what about adding a generic GPIO controller or using SiFive's GPIO
> controller. Then, we could add gpio-restart and gpio-poweroff.
> 
I agree with most of what you said. Regarding generic devices, syscon
looks a better choice than gpio in the current situation.

Linux kernel has these configurations enabled for virt, and I'm not
going to add a new soc for this new board currently, we can use the same
syscon interface for power, and it has already well supported.

config SOC_VIRT
	bool "QEMU Virt Machine"
	select CLINT_TIMER if RISCV_M_MODE
	select POWER_RESET
	select POWER_RESET_SYSCON
	select POWER_RESET_SYSCON_POWEROFF
	select GOLDFISH

For the qemu part, we can remove device 'sifive_test' and manage that
memory region directly with MemoryRegionOps, similar to what
hw/mips/boston.c does.

Thanks,
Fei.

> Thanks,
> drew
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#50): https://lists.riscv.org/g/tech-server-platform/message/50
> Mute This Topic: https://lists.riscv.org/mt/104719372/7152971
> Group Owner: tech-server-platform+owner@lists.riscv.org
> Unsubscribe: https://lists.riscv.org/g/tech-server-platform/unsub [fei2.wu@intel.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 


