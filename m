Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40776C36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 13:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txnVn-00015d-HH; Thu, 27 Mar 2025 09:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txnVf-000156-Mp
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:43:05 -0400
Received: from mail-dm6nam11on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2415::61b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txnVb-0007E9-Cs
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:43:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgGtznKnoGHJbAnHTve03YuPC3+fWsaycbm/50YoD/UpMiu8JVr/3RrONiW1xHp3DIdcaqJ5xrmqu2KuUXwCVZGxODGZuJmMNBrqGfOga8UdVxdrQENMzRBqv/WNpJ2ysKTnZ2xUYpoCTYpGMUo7eCZgSArM/geK+DZfH9bPwKcegFlWhRjCOO+qanOEcIhRu4woFEIWA1GkmUJW8VPa72di26VLVF7Iz5Wkaro5sY2MgHwIUM075Cr9Yf5iMO4EidPSX4cMzXCNPLDq6PWGCE7/iWcqMh0NVdK2GlX4A9HOrq5ajPYZ81nf3fzBuInUC2ewqwo2LFf5bCSc56wozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p06qbS2c2ofdMOM8QNjpYrv9iYVuwpyd8zXCtvwgA7Q=;
 b=GUnSYwXTjZdOCwJAHM/2YuR9t5uue3+GYeYPk5OPLzefQS+EvGl/tGCkp3XTNb7F/5Xs6rWy+PU0sAw23LhOe3kDN9bvZhQ1295k9fpI82GxxupMm9a2kyNu+Le8HV/EeXztRPjvA5Y+xgXUs0qh81cv9pMdaQi02Q0ThesyQZ1p3dTyG6TELKPjQYXFd5eSI39vaqS3gNQhvlrV2MwZF7QlLv9kZyhP0OmFhb8BonWC62KQUy2l7i8g8nCoF/yOx6kOs7HBgqwbHPMVi90N2Cp4fRUgZC7KUl7vXpCD0hitJwXuWD2t3WiCNpEM674We32p2x6UqmYlG6mbh4HkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p06qbS2c2ofdMOM8QNjpYrv9iYVuwpyd8zXCtvwgA7Q=;
 b=P7C2eLUaCK8JUrqPacjZoagmUcSLnwisq3bU0nBRPxvY+LSbIrbPjJiys7h77cEMA5Z03mRTFE3zrHoNWCc+aENnZ6ozNPC9ogWQbh+TMQiSBkJJQP3hHeEwSQWH6ZAbd6GPCKlKuk5h3DP2ZzkRDZuLGCHLST+ue36qiSZaHPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:42:52 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:42:52 +0000
Message-ID: <9ea04b32-d075-ffa0-1ed9-4229ba9f4255@amd.com>
Date: Thu, 27 Mar 2025 08:42:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 2/8] migration: ram block cpr blockers
Content-Language: en-US
To: Steven Sistare <steven.sistare@oracle.com>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-3-farosas@suse.de>
 <829e27d6-eb6b-8a26-e982-0ba936888c6a@amd.com>
 <9576dc01-e26c-1fc4-6534-ac79c71331b5@amd.com>
 <174301860426.2151434.16431559419990134889@amd.com> <87msd7a6td.fsf@suse.de>
 <20250326213443.jl3r77hqh6gy2h4w@amd.com>
 <307f12e8-7de0-42b2-97ab-997c2dc3f39c@oracle.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <307f12e8-7de0-42b2-97ab-997c2dc3f39c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:806:121::11) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 31eb5d7d-6821-442c-e5e5-08dd6d3545aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlNBWXhzM3BEK0dKS2hUeXdvbTBrL1VLSFZOdkVVc1kxdHF4TFIvTjZTY2Vr?=
 =?utf-8?B?N2dIWTBzQjZjemJrUGF6dkt0UzZKV3VEOVYvcDdPdUNnNkFxYUhqZEZrK1Z3?=
 =?utf-8?B?UXBKRWVJQ2wvbHFRcWRBM3BBMXJPWnFnL3dOaFZqMFR4R2h5TkdjZnVDVmMx?=
 =?utf-8?B?Z3JZSWs3c3pDb08yQnV1M3htNTY4N1FzUEhYOFZpa0d3bDVFN016WVNac3dY?=
 =?utf-8?B?Yk5VckZLdHVraFJaZE1sUmJ6WW90SmdLdXpvemhiMHFMbTQzM2ZvZ0prTXR4?=
 =?utf-8?B?MzBxZFc3VjRXSzI0T0tNSzVVZ28xcm9KUGxJSUZ3UlRIRUlVZjIwL2hSNU4y?=
 =?utf-8?B?OGNyNWV0Z3BveGcyektjY29WLytIa1Mzb2dCYVNudTN2dFhrVm1jOGlYTzhq?=
 =?utf-8?B?VDVpazg0dk0rL21oeGhudllVbVJLQ2M0b21RTWZ0czQvcXBDRmhQazJYZS9N?=
 =?utf-8?B?SWdzNGt5dHZnWlZIUEkveEovdWl2djJEWW8zbG85UnVCZXc4YkgxcEZLa25N?=
 =?utf-8?B?ZDVhcWtTVWJVVkc3Um1lbjVKZ3V0a2taR1RHTmcrWmlCMXlieWJTclphNk5k?=
 =?utf-8?B?b1pPdzRCVTZ6azF6NFl2a2c4STM2bE44WDFIWS90Ym05aDhnS0lZK0Z3OXJC?=
 =?utf-8?B?Yk5ZLytCdGdHc05LREdRYXBHdFZsS3dxMnVTQVhwL0lBeUFYd1N0ZHZyR1Zl?=
 =?utf-8?B?cjNnM09CQW5DN0V1UkQ4SU5Zdks3TnladHAwb0pkMFdKcnVCci8rcjFpUlpK?=
 =?utf-8?B?eWdwVm5ha2d0VVNDbGdYNU5rT3hoYlFrVmxmVWVuM2NuODdqZjVRU3JXaFlw?=
 =?utf-8?B?RURhbVEwWmpOc0cvWSt2RWtKTzMvTDNCalpuUFRmQ0dZMDdCSmRjNW10T012?=
 =?utf-8?B?TzRuUnU4UjVYZnQ4c0kveXJUNXJQYnRiQzMwTjFMVzV1ZlhQVllWOVY0THRO?=
 =?utf-8?B?ek1KRU9sZ1JzM2RoZVZLRks3MEtsQk02c1FHNEV1aDdIMXRSTDJhalJuclB0?=
 =?utf-8?B?NjAzNmFuRE9YRzIrb05yS0RaQTNXbVd1VG03ZHROK1NtSUtNOWVPbSs3b1ZK?=
 =?utf-8?B?d1hJS2pUaExlVG9BVytQQmIxVmR0Mzd5OENxandHZWxiVkRpb0Z6TG9qcFZU?=
 =?utf-8?B?RVI0UEFpMXFjaTE5TXcxdFJHQVg5eU5KaDRCcG5uSFEyVnd6ZmZGbmh0SnY1?=
 =?utf-8?B?MHpodjk5aHJ0aTBEcnl2dE5VQUFKYk9GYnVJSVdlMFBOOTZuckVHb0lLMW1V?=
 =?utf-8?B?MHRjcEVWQnQybExrSGhLaE9hcUIyUzE5RmszenJGY2twU1l1VzAyczdXTlA4?=
 =?utf-8?B?V3JPd3BudzJCL1pKSmhpMVEydStIZlY5YWEvMzR4YUVBcFlyc3FScjdzL3pp?=
 =?utf-8?B?SGVaQlh0SWFyeSs4Uko4Qmk5ZXo5S3RxMXlMNUVJeC9EclF3MTJGbHplY2h4?=
 =?utf-8?B?TDlGVTFTQVNGYU9MSTJQTDdHbUpJekNUOVd2Q2phRUo0d25FUGU0ZnRya0lr?=
 =?utf-8?B?cEJ3WHRYSjNlY1hQODhsaW8vSHIyMGVObHBnSEIwMS9id2o1ajFYcVZXUnRS?=
 =?utf-8?B?SlVQczBUZ2dLcE8vRUFvV3Z2djlyMnpaMi9ieG5YdEI1dWFLOE1GVzU2Yzk3?=
 =?utf-8?B?bDZYdVE0QlRzdWdEcURGQ0UvUDVUWVNLN3NES2N0TVJiS1RZQ3FwK0VwL29v?=
 =?utf-8?B?TE1RSzRXcXE1Q2xEdStaV3NNbkd1L2JEY3pKQ3lOTzlyQ3k4cllJbUFEN2pY?=
 =?utf-8?B?cHc1Q2NWVm1ZblJuYVRibVZESkVzaGZ6cUFOcVZ6RmwrREFPdlY4YXU5Q3dt?=
 =?utf-8?B?bGpKM3VJWGhFQnNzdnJ2dVQwTERJNHVPYkI4YytEdkMzako0S05aS1dDa2xH?=
 =?utf-8?Q?weDa2l9nC4ibB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEFZWTdMT0F2d2VTdGVHR0IvTEFVaG5Rbzgzb21lSTlXMVBUWVNSdXA4MnZS?=
 =?utf-8?B?Sk5xdGJnWXg3YW9QekFqUEtMYnJVengweVF6RVRZZmtibHBpbVJjaDlnbFlv?=
 =?utf-8?B?bXlkMFcvV09qT05nQW5zYVM0ZytMTWFjOWkzSE1HR3N3ZEtkT3BEZDZxclAx?=
 =?utf-8?B?Z3VRa29TVWthRE12SndwM3UxU210ZFYxTm1CV2RvdXN5K2hnc1FFdkxBbjI5?=
 =?utf-8?B?dE4zRkxiWFg3MlJnVzFEOXRDLzl4czNWcUxVVTVmVzIyUGxpQjVmRXh1S2Mx?=
 =?utf-8?B?djExYXpkQTN3UHBJTUhsSnQ4OWdZWjR4S2huQncrVVBsaHN6Q21qM2dmZThs?=
 =?utf-8?B?SnMydlBRUW5hTGRWMnhIOUxCVXBxQ3QzbGRuMUhVblhjOHA4Y2NzclZlKzVm?=
 =?utf-8?B?TmNmVUFoV1pndTlWemxvckxEUTk5K3NwSGlPbGZhWG1neElJcW00enNMeEJw?=
 =?utf-8?B?NEpqTjZNY09INGtYc3k1VWFRQTFHUWw0THRQQys4YWxhUVlKcjd0Tk1WZktp?=
 =?utf-8?B?M2hYc3FNSWtKZEh2cFc1UU0rODYxTS9BNGxQYkxyUnNFbmlqOHZwODRRTE8v?=
 =?utf-8?B?UkR5ZkVXNjUzV3B3bjJBRXlOeG1WdzFuNDF4VHhLVnEya1Q4MFdVUG9mbWpM?=
 =?utf-8?B?S3Z1d1NQbm03Z2p4ZXhZd0dZVmQ4cDhqeW9wU1BLRk5RQ2lEelBudVF0d3V0?=
 =?utf-8?B?b2ZCRzVGcjlpK0dCT0NnQjl2QnNWd052bEJldDZsWWRtMjNYVjRNblNaVFVq?=
 =?utf-8?B?RmhEWXdhYUFYUWhvbnAvWkdxS2VyUU5jRkg2Q1RZaytSelFzWFBtdTlMODBR?=
 =?utf-8?B?TWdIS24zbmg3bzZiZ2sxZmZWUDh0S0FnZlovT2UyMWxJWWVicFVNakhMamhw?=
 =?utf-8?B?d2R1S1o4bUtQanJoVFEyWnpNdXhySVJkQkZHUTJncGtzV2NvdVE5bTFjK25m?=
 =?utf-8?B?cFg3eEZvVCs2b3hkSUQyZlBVeW03ckdtVmY3bUtRWDZaMHRqSDhLS0dVMUNZ?=
 =?utf-8?B?azdCTGtwSW9GQm5LVWRQdW9ITm5xQW1tc3pFd0lPUUNhWDFKc2FmZ3E4MS90?=
 =?utf-8?B?RDZXMXdqSVVYNXdKYklJUytET0ZmQXlUemhmNGtTdHU3TFhCYng2ZkpoZElU?=
 =?utf-8?B?YThFbFd2TEVUK2V0djhab2lZTFloR2NidnhXbEpnL3ZaMEp1cllQSEZveEdD?=
 =?utf-8?B?SHFxelBYeXJJa0hwNmUvMGIxdk9oZkNIcEhmWUtoVGoxaGpqTWorQXg5TDd3?=
 =?utf-8?B?KzFKTUxUN2t1WkVqUGlaYkVNcHp4Vlh4c2FmNkNUUVB6bGRvVXp6SCs4c2Ju?=
 =?utf-8?B?WmdlY0hYZW9oZlREdCtXa0NZeFV6OVZEMWVvWkJPK2lZcEpJK212RTJFN1J1?=
 =?utf-8?B?MkZtTUVmbUpxNTdDeDNkSTFxbWF1MERNNEZyeE9kY3FjKzU5Q1pnamVjYnhl?=
 =?utf-8?B?dFBKck1Cc0doRFM3VENFYktpVHFwd2JxY2tBT3FSRC93YThaUkp4emdGOE5X?=
 =?utf-8?B?c25EbzJ2dDFOTDA0S2ZWYi9HaytvUEZyTHczVGoweWNuVWViK0k3a3NXeXB6?=
 =?utf-8?B?R2RoNVF0NE5aVE9zWnhaVE9SN1oxbUFNeU1BRWk3T3ROR2p2UXowbTYwSE1M?=
 =?utf-8?B?ODRjMFIxWlpjZW1VdDA0K3lhb2tXKzI4cFNsK0h1WkV6MnduVWxKY2hlcTFj?=
 =?utf-8?B?ZUlCMG1pczhralpFOUk4Z1pJWFdUWUxaN0ZvR0VvQzdEMjdoajh2MjdpUlZ2?=
 =?utf-8?B?ZmdHR0JIMzdUV0pYV0JzMEhVdzZVdGk3cm9yTWhGWVY1WW0vWmtDcFp1eUsr?=
 =?utf-8?B?ZHM3T3FHODFLaWFGNGEwajNwQ1lKcXM3c28yL3pmTU9vMTNOU3hCMHNNc21z?=
 =?utf-8?B?MTRhL0dOVUVWc3h5ZkxqWkJHbnErc2JhZU1uZDF6NHN1SHhJNXpSZ2xFbmRw?=
 =?utf-8?B?cG1manNWc2hZV1NpcUcyaWg1R2FMTTlSSVBYMDRnbG5lTHhwc2ZlWm1rd2JU?=
 =?utf-8?B?TmF0NlQ1YjBnbVA4UzhUVlpIMWZMaW15cVBVSk1KdUt1YzVTdmJxcUlQalQ3?=
 =?utf-8?B?UVU2NkVrdXJnenJYY0w4dUxMR0dGbC94eG5LcUJacDBuVWZTMkhsY3BjeUE3?=
 =?utf-8?Q?BTHIM9OH7nYEi4HGBk92BntRS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31eb5d7d-6821-442c-e5e5-08dd6d3545aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:42:52.7633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfOQ7CZ1f7FaWhTjYNT/oDxe3okkudCSVitDIvfyQs1oOSkPH2GfyCq8zodo7iItyFzL3ZWUiY4+Ti4WjWwd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
Received-SPF: permerror client-ip=2a01:111:f403:2415::61b;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.943, SPF_HELO_PASS=-0.001,
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

On 3/27/25 07:27, Steven Sistare wrote:
> On 3/26/2025 5:34 PM, Michael Roth wrote:
>> On Wed, Mar 26, 2025 at 05:13:50PM -0300, Fabiano Rosas wrote:
>>> Michael Roth <michael.roth@amd.com> writes:
>>>> Quoting Tom Lendacky (2025-03-26 14:21:31)
>>>>> On 3/26/25 13:46, Tom Lendacky wrote:
>>>>>> On 3/7/25 12:15, Fabiano Rosas wrote:
>>>>>>> From: Steve Sistare <steven.sistare@oracle.com>

> 
> Thanks everyone for debugging this.  To summarize,
> ram_block_add_cpr_blocker already blocks
> guest_memfd, because rb->fd < 0.  The fix is to delete this redundant
> code in ram_block_add:
> 
>         error_setg(&new_block->cpr_blocker,
>                    "Memory region %s uses guest_memfd, "
>                    "which is not supported with CPR.",
>                    memory_region_name(new_block->mr));
>         migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
>                                   MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
>                                   -1);
> 
> I will submit a fix (unless Tom or Michael would prefer to author it).

Steve, please do submit the fix. Thanks!

Tom

> 
> - Steve

