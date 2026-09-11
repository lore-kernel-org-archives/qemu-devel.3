Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6B4C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wkO-0004YC-8S; Fri, 11 Sep 2026 04:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x4wkM-0004Y4-FW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:36:34 -0400
Received: from mgamail.intel.com ([192.198.163.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x4wkJ-0003wY-LO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789115792; x=1820651792;
 h=message-id:date:from:subject:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=or9OhuFC2qBIHaVXmVoqkRVVzyglVHYfWMyrU4ygc9Q=;
 b=ismARoB9W6Zm4ahE+7JU+xeTC988pHinlZ1+mDy6g9Tz7MplN2cHGeW1
 fvor4gS5vDrIrbJmiCNPvxAy1r/raZJGCHhz1j5vIihEsIUcgLfTl50TK
 l60VNxfqO41GEFNF+iILFp7pSUvhpB8zpMAw4Cvq9a5/kEWuBO+oXtItI
 zw8P/EBeF2bm6AB+JeYEyVApzPXvjcuC8GLC5wjNDmEAlUk1yACgOzPkw
 Wvam6/jVnUnYg7X65L67RVDrhY/26UIVYkhJ4hEiHCz26D5FK4GNjYfuN
 CvG3uTK7DWm1tT7t0tfoxEd6mzqXjXxh9UGzvyyFLMWnbY+homr4hR6MZ g==;
X-CSE-ConnectionGUID: 0+T+m+7KQKmuBtChwXuRkA==
X-CSE-MsgGUID: DEZAodcbS4mrSt3TE5Yn/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="86995"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="86995"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 01:36:28 -0700
X-CSE-ConnectionGUID: ItwJ0RyARXOueCtG0JGjXA==
X-CSE-MsgGUID: 0X9GZPXoS3u6PmHhGEJULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="275633429"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 01:36:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 01:36:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 01:36:26 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 01:36:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmJ3IO0YWNulkd/UuexpNfuC+Xd5PEB8piyrw5GhgAxgwPPfcfQs6BOJyAipWhCXYI8TsvV2kv8PPaGVbHIz65vL6OTbA18Qe+RiBxJBTAW2yhet2OCUKOU1Anzo6m7o5hTGWbgUhSia04smkngAsdOoTKyhS4PwPkUuPIKRgGZVxEeKDNIoteZ0kovzmeAEdmb6qDdQ3hg0jIdlK9siZKa0PCOgirTMYlXXX4CRYwgECoNdivp2+06EMY3wCkdnGJydldc9UKSvWozoStkF04ohbHCbJ4E6Ku7s+Jq1pUMx1fcV3GuuzG9zXByo7Tr8n6UfoeiIncrFrz5Yyae+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nObV+naEJdMGddcYXorJ3vUuj1phgcB6d4qea9zbgU=;
 b=UumRz+HUIuKzY62toBkMX0QGQg/NvvQleBZD9dfK807xa9gMQTjInd78pJGgPOiW05tnzWOdmLf1V2MIozmXgbfRI0s7gTP00yfarzJLN6o2Bn9yROVZ7Kdu57AaiUKeH4KFhtqi4KyT6eyMgj0ztyrRvrXnutwGiRJBIuOUnxKZ+Iqsake9crq75XF3RmlbPqV/p997va2a9pf8OMnzmxW0/Uh6h1vKjgu65xmFwXwTEuNt4n64P1MCWAsww8O8MME+Ciaa28tPnfqT4slVc1pEUFy8kaNkIYYO2uvXVcSMTkhUw/l63XU3aA5gtvTmGea7iVZlWqg7KZmBi+7mKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPFCECA32305.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::51) by PH0PR11MB5925.namprd11.prod.outlook.com
 (2603:10b6:510:143::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:36:16 +0000
Received: from DS4PPFCECA32305.namprd11.prod.outlook.com
 ([fe80::2b17:a125:480c:d700]) by DS4PPFCECA32305.namprd11.prod.outlook.com
 ([fe80::2b17:a125:480c:d700%5]) with mapi id 15.21.0382.012; Fri, 11 Sep 2026
 08:36:16 +0000
Message-ID: <22327826-756f-445f-be34-f97b5f983976@intel.com>
Date: Fri, 11 Sep 2026 16:36:07 +0800
User-Agent: Mozilla Thunderbird
From: "Wang, Yuan1" <yuan1.wang@intel.com>
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
To: Tomita Moeko <tomitamoeko@gmail.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <bosheng.xue@intel.com>,
 <junjie.cao@intel.com>
References: <20260825090435.1492485-1-yuan1.wang@intel.com>
 <c425dffd-ccc6-42b0-b083-51f06562237d@gmail.com>
 <2dde7fa2-de05-4a8b-91d0-22e0fb1df107@gmail.com>
Content-Language: en-US
In-Reply-To: <2dde7fa2-de05-4a8b-91d0-22e0fb1df107@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0046.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::12) To DS4PPFCECA32305.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::51)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFCECA32305:EE_|PH0PR11MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c33b72-0e16-4163-b189-08df0fdfbe61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X3oBIdRngD4idHHNHtcR5aXTpCrkDTGva5j0K2im8aF5S80rwvwEIY7+hqm/LUphbGx2AnzPQXzgOuj6fA7L5fDADBJAXx8Z3/1JvwPCiI5cAkd2ZpcOWSrxEKjVs9CBLl3wKSzjnJ7XFtNmpgoV5Ng6NznjdZxGpDcDmDzLFcZ+4CYBq3CqY3fOn2gtKOJ6scXPbSY5XBCvSyTWangfJfVnH72dJ4BjWAJOIo4JyZNMnFSgXa8jeAeQDFeKeacim6qKBTxJHnrVoJLgFxYgPWhC3EvUXMGG5bkwO9lZvhoaLqRCdDa9VRRkB3pWaSorD4RLmEa27wZpVZRW4x08UrR8un+ePSt+ozDlehZGtVnWsS5pi3nKdIjFh1WeaiveTGbh0iLG+S6QjvCxTROzDCqvFOFX5qXDKLGFjK0n0FsBgvxIUt1r4ZlTki4U/6vS/WSJanIT1H2zHC15dNuZUghxr++SgmBsLfNY6+Iec2QR7LsBTYIKbVs0UDIn+8GFKs7KT8HFObObI2tXcmauYj2Duy4dv2b3Bg3NKF6AoW5e//rcE1keYt9tTPM87HV6qjfhKHnqGvatVgwcbgTLm45dUjYonTMKGq7+ad5quns9YfpSjjgFqVYOwd4fNPCV1olBwEh0UpWcpf1zV2Kl+Tn+AiFPKNv4gwB0QBloG4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFCECA32305.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnFvUWhOUVRGRFJVWGhHeUNuRlJFd2FUUEsrZFBWVVVta0V3YlZDVGdnd0F2?=
 =?utf-8?B?VjFqRzFFcXJHRlRndk9ncXlpL21Ea2s4SmlNV0FzM2FtdGEwc0pZakFEdEVX?=
 =?utf-8?B?SjlVYzBvTXF3bkZJMkszSTlueTZ0L2QrT24reEJBb04zOWJBUk9GRzh0aUY4?=
 =?utf-8?B?a1dWSUhsa0FndkRUalFBSUlwV0o1ZFJwZkdFeklBMkFRSnVXczBpdGRBWUQ0?=
 =?utf-8?B?Sy85dTJNTUpsaHV0YVphdkRnSExKdHBLaXFJczVJRFZVNGdGVGl1ZExDaFl4?=
 =?utf-8?B?OG1hUlRpYXgxSDFRZ1c2Q0xDckQxVENSYnE2VW5XOE9hTE56N1hwRVozKzFn?=
 =?utf-8?B?NGdPcUZTU1FKYXhhdlJabDRYNGI0M0ZCRjRPa3FHNEIvNWFuNnBvTWxZdGw1?=
 =?utf-8?B?ZHVmYkpHZ0IzQVo0Rys2SDN2OU02Tm9WbkpVeVg4dnIzS2pIeDVBdmp3R3Vy?=
 =?utf-8?B?algwNjNYSXlnTDNXK2w5N1BWNjA0ZUpKMTU0dWN6eUFkOG1VaWs4eGFpd2Zw?=
 =?utf-8?B?S2VCbUErRmZjdVV2K0p1c29XQllOTWlocFpyc3FndVNpazlISFB6R1VzM04w?=
 =?utf-8?B?b1Q0YnRwbGpOOTV0M2lZNUFwOFEvU0V4dmw2elIvY3B1eTB1ZVhXYk9lSjl5?=
 =?utf-8?B?WXRoOFRJU2FnMUM0d3RGRmRzR2N5OUxqZXhneEJ5eUI4VVduMHNJY3FublVL?=
 =?utf-8?B?dGMvUGlNc3BNUUV4N0RoSXlkTWRsNXZBSXNyUXRFRzVmUlRwVjBidVl3bVIy?=
 =?utf-8?B?b0FVTTJmTlRuTlhacXVrRjdDMFI5K3EydVhDZDhBTm9PWVFtWkI2N0RPSSsv?=
 =?utf-8?B?bkNaNFAveVlOeWR2UWVCTENOcktXc1FFNjNlZWdDRWFiNGdEVVRWM1FEbGU4?=
 =?utf-8?B?cE5GN1JzZjN4NlNKaUZwRW94YTdIeUh0NjZiRU5IdUVqaW5rSmhhYndGTmFX?=
 =?utf-8?B?VytPWHlxZVF3VkxKY2ZHUW8vYkMrcWkrcVpQYnpUREJ1SENaV0FuRVNsWGFn?=
 =?utf-8?B?TW1qUEMxU1hwY1RMSUFPNXVJVm9GaEpidDM2bE9vclBvK0djUGxhU21JTlVN?=
 =?utf-8?B?Uk1SSlhKK3FlTC9xNWNLaXJVNUlBUHBTSWVadE5Qb29KU05CbDh5S0drd0VT?=
 =?utf-8?B?ZjJlREs0WGhKZ3RDNHg1UHpZaGNJMmVrVkZROXZSblFGcmVzaXRUVjk4UUx3?=
 =?utf-8?B?dDBIV1ducmZveGJVZVNpeERxaVNXVGFTVWM3WE1jQUlodUc3MHkzWVBUdXRq?=
 =?utf-8?B?WUx1dVo0dlBFc1NvcElPQWhmSm9JRmZneWQ4aFlhQTJaMkVmRW1rNHJaQ0o4?=
 =?utf-8?B?MWZjcVBFcysyTkVnS1ZZS3R4cWlmdlhQMUltbUhNWFFqSUFZb2ZkdFFLaCtj?=
 =?utf-8?B?bGVIdUZQZUhzQkVibURtd1pKQk1hL25WUGxIdjU4bGQxaHNtdWd4M1J6dmhj?=
 =?utf-8?B?bWtEeXB1R0c4LzFKa2NGVkE0bElqNVJkU2UrTmdUQkVJZUI1dUVwUU95SWJP?=
 =?utf-8?B?NXVTNXYva3dCcldIUG9qdTZnMVNwaFpvTHNQQnVnWStVV2JHV2FBSGlmc0U3?=
 =?utf-8?B?Q0NlQWFncjFiZXpGR0FLVDR6QmhORWFLNEVnN0JjbnJxcStyRmhqeG8za1VC?=
 =?utf-8?B?MWNMZEhYZDhJbTVDT1lsbGx4TkE3MnRESDd4VHVMT0trSzV4NDZ2VlNNYmdK?=
 =?utf-8?B?eFVKYkh5Tjl0OE1MRlQ5bGpiOXZsazdtZXRlU1FMaEdrTGhMeGRRU0FCZ3Y1?=
 =?utf-8?B?eWk5MU1WWHByQWRTa3A5QjZ4dGJpTlBleFJNbVRjRjgzMUlXYzNMMCt0WkJz?=
 =?utf-8?B?MktaeG5XdnFxallzWUFFVEhwdk9oNGVEU1RSVEdycnE4bk5ZN3dwMEhzQ0ZM?=
 =?utf-8?B?T2pqb1ZuRmp0VnFzYXh0SzJHNEx1ak03ZEJ1WGtqZjd1ZXd0SkpMb0xSeUZ4?=
 =?utf-8?B?S293T1NMUHJKbUdzRFRoU0s2eGVsbXp6TDROQlNtb1Yxd2R4ZXJKTVpRZEs5?=
 =?utf-8?B?OW5SMmJnZFhnTXByTE5vMDlCUlVQdmxaOHBsZVJXaUk3U0U2UFp1UkhSTG42?=
 =?utf-8?B?bDFmNm90MzF0LzFpSmNMMGZQUUpNYkF3OEVZbU8yam1FWHRHM1BOTDBmenFx?=
 =?utf-8?B?MTlqQUVlVFpEVUdOa2ROcG96eEZ4aG1IcnBObHNtZ1hxUmlwSjFHa041NEUv?=
 =?utf-8?B?dnRDRnN1UG5aODFjeTlNUTF3MUVaYjk2a0N6azdPWDYyVXAzUnJTR3EvbEps?=
 =?utf-8?B?VnN1RFpTZFdRanYwQjkzbktNcHNCNmNhNy9qMEdLcUowWVI5NFhtWTJ6c1lw?=
 =?utf-8?B?dVpOU0dRNFgvMHhQejJvRjYxWEFtdXQ5c0RvY1ZteGs1bGgrVFVGdz09?=
X-Exchange-RoutingPolicyChecked: MHG6bhs2I/HCRfGEDHNJiCO+aEG2FzipXJ546QpoutCbtm1zQ8uoEl9sWtcFmn0tcW3LQH3scTAjbJJe8GF1v7ena9QhhixblUxJtxuskYezIazu41lcBaww8iUf67C9Z71m7qXQV8EfWif1vUvt4/YclOGYW94RfTY7hrc7eYQj4SUYpGKcPwBuFu7DpwHRwPWLS4c5+270aWTQD5ZQPyxONONfsVtOWYj9G5hwgCgbWOij4WGfAtOlU/3x2cnAWFwbk4ELQxqZev8yGxzCOwR8XnZu1Mjr0Doz4xtPWxbRmDiKFXEjf5JofqYS4+91RzpuIgnt9Zfn2LQoKVOZIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c33b72-0e16-4163-b189-08df0fdfbe61
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFCECA32305.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:36:15.9981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYe25JsOHto9UDdmL5kNEYuXJw0tpsK7lJOdUL4XANq2kKXQH1vbWubA0IikJvdQG5lXuKTQD3wf8GxDT7QU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.5; envelope-from=yuan1.wang@intel.com;
 helo=mgamail.intel.com
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

Hi Moeko

Thanks for the kind review.

On 9/8/2026 5:09 PM, Tomita Moeko wrote:
> I took a deeper look about the change, this change actually changes
> vfio_probe_igd_bar0_quirk() to go with the 64-bit emulated BDSM register
> path, right? But the problem is, does the BDSM register really exists on
> Meteor/Arrow Lake and later iGPUs?
>
> In drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c:xe_ttm_stolen_mgr_init()
>
> 	if (IS_SRIOV_VF(xe))
> 		stolen_size = 0;
> 	else if (IS_DGFX(xe))
> 		stolen_size = detect_bar2_dgfx(xe, mgr);
> 	else if (GRAPHICS_VERx100(xe) >= 1270)  // MTL+
> 		stolen_size = detect_bar2_integrated(xe, mgr);
> 	else
> 		stolen_size = detect_stolen(xe, mgr);
>
> For Meteor Lake and later, detect_bar2_integrated() is called. The DSM
> region used is at (BAR2 + 8M).
>
> 	/*
> 	 * Graphics >= 1270 uses the offset to the GSMBASE as address in the
> 	 * PTEs, together with the DM flag being set. Previously there was no
> 	 * such flag so the address was the io_base.
> 	 *
> 	 * DSMBASE = GSMBASE + 8MB
> 	 */
> 	mgr->stolen_base = SZ_8M;
> 	mgr->io_base = pci_resource_start(pdev, 2) + mgr->stolen_base;
>
> drivers/gpu/drm/i915/gem/i915_gem_stolen.c:i915_gem_stolen_lmem_setup()
> also suggests it is (BAR2 + 8M) on MTL (i915 only supports up to MTL)
>
> 	if (HAS_LMEMBAR_SMEM_STOLEN(i915)) {  // Only True for MTL
> 		/*
> 		 * MTL dsm size is in GGC register.
> 		 * Also MTL uses offset to GSMBASE in ptes, so i915
> 		 * uses dsm_base = 8MBs to setup stolen region, since
> 		 * DSMBASE = GSMBASE + 8MB.
> 		 */
> 		ret = mtl_get_gms_size(uncore);
> 		if (ret < 0) {
> 			drm_err(&i915->drm, "invalid MTL GGC register setting\n");
> 			return ERR_PTR(ret);
> 		}
>
> 		dsm_base = SZ_8M;
> 		dsm_size = (resource_size_t)(ret * SZ_1M);
>
> 		GEM_BUG_ON(pci_resource_len(pdev, GEN12_LMEM_BAR) != SZ_256M);
> 		GEM_BUG_ON((dsm_base + dsm_size) > lmem_size);
> 	} else {
> 		...
> 	}
>
> 	if (i915_direct_stolen_access(i915)) {
> 		...
> 	} else if (pci_resource_len(pdev, GEN12_LMEM_BAR) < lmem_size) {
> 		...
> 	} else {  // MTL
> 		io_start = pci_resource_start(pdev, GEN12_LMEM_BAR) + dsm_base;
> 		io_size = dsm_size;
> 	}
>
> In addition, nothing about the BDSM register can be found in MTL datasheet vol2,
> neither 32-bit 0x5C nor 64-bit 0xC0. I believed it is removed since Meteor Lake.
> https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/
Correct. The BDSM register at PCIe config space offsets 0x5C/0xC0 has
been removed on Meteor Lake and Arrow Lake.
> Since you are probably an intel employee (from your mail address), you may check
> the GOP driver code to see if the BDSM register (0x5C/0xC0 in config space and
> 0x1080C0 in BAR0) is really used or not. Please kindly correct me if I am wrong.

For Meteor Lake and Arrow Lake, BDSM is still present and located in the
MMIO space at offset 0x1080C0 of BAR0. 

The GOP driver continues to read this register to obtain the stolen
memory base address.

And for MTL, there is a WA which there in Linux Gfx driver which cause
it to read 0x1080c0.
Please check the following function i915_direct_stolen_access().

drivers/gpu/drm/i915/i915_utils.c: i915_direct_stolen_access()
bool i915_direct_stolen_access(struct drm_i915_private *i915)
{
    /*
     * Wa_22018444074
     *
     * Access via BAR can hang MTL, go directly to GSM/DSM,
     * except for VM guests which won't have access to it.
     *
     * Normally this would not work but on MTL the system firmware
     * should have relaxed the access permissions sufficiently.
     * 0x138914==0x1 indicates that the firmware has done its job.
     */
    return IS_METEORLAKE(i915) && !i915_run_as_guest() &&
!IS_SRIOV_VF(i915) &&
        intel_uncore_read(&i915->uncore, MTL_PCODE_STOLEN_ACCESS) ==
STOLEN_ACCESS_ALLOWED;
}

Consequently, MTL still needs to read BDSM to obtain the DSM base
address in i915_gem_stolen_lmem_setup() function.
As seen in i915_direct_stolen_access(), this bypass logic only applies
to the bare-metal environment (it falls back for VMs).
However, the GOP driver does not differentiate between bare-metal and
virtualized environments, so we still have to provide a valid BDSM value
to it in GOP driver.

> For the "IgdAssignmentDxe fails validation on the zero BDSM size and aborts
> without programming the ASLS register", having a fix skipping BDSM size check
> on Meteor Lake and later ones could make it work? OpRegion is automatically
> detected and exposed to guest on IGD as I remember.
The MTL GOP driver always attempts to read from the BDSM register, so a
valid BDSM base address and size must be provided.

Thanks

Yuan


