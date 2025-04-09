Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F81C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 05:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2O6p-0001Ub-TV; Wed, 09 Apr 2025 01:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1u2O6n-0001UN-5a
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:36:21 -0400
Received: from mail-bn8nam04on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2408::604]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1u2O6h-0000R1-HQ
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:36:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpIIqiTLqnCvWF29D8RFwhztzfhR3pmTdBXskMunVJTBjQKk5UII81fa+xb8GbFRD1kNX6LGGBNnfLjGfSLb4YP2y1x8qye5KbtyvmkxU10j6AhUsrdtwQwaO+96YZB/cgGdVhHYomdoArgmDsZRchsnCBDl9xJXJj2LXW7Frun2h++NY0dn4s/WypXq9HH9IXI8vPzJVi5QBdt1B76Enwm4y8A99C92YMQYWRunmBGMp8nQ2YEgRcuqAfuY6lee3NOpc9KvOxEgjAvPx2nUWTQ1R9c8tsfZLP5pMug6irpBROIU5z3DQnN3f89aPv45XnUUKYrks3hpTJeaQN9QUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkuojxiwmH/sSyOLPn6iLtzW763KyQeHsdzxcnrHeQY=;
 b=toQRwf5huYQWGKRbfTDd2UKqm/LzNMili8LMZxSM8RK7VmwHuocX/j8yZPgT+drYr3tjFz+4/tVlyeEFWD6EOZPpcULwsHNLU6vipHBd9UYiuyecEwzOZwpaDzNEeVRIsfKcd6JtHMdeWCyI/CArkUe98EbJ/YyMbnThsHvCpb2RsWOZpsJW3cfrRUkghq6d0MAQtNhEkxtw5pfqf/NbH/h0LP4V5P603OynmIhcymdQQyB+6X2uFLTdSZrhYyG0KvyGmfeBOfL0QGX+wcgotdAnYfRRtL/lI38TqmMsRkmoWtoHa5MYQppAIcKjgo/AHjoFGYmDo5gabEbkw19hSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkuojxiwmH/sSyOLPn6iLtzW763KyQeHsdzxcnrHeQY=;
 b=5F/hd13L79wzoSlU6kvpdkzt20AXr8+3zLyZT+8mIJK+SqUhn/DdMth0JFytwDNXhsFNj4ywnULA9sXoHe5Hs2E7pdzdpOV4Y0T6kQgdfiz5XjjBJBY/O+QAZIdAlG8noW7qlYMyQFotsxGf5nvgrrL0Yt/HtKdRk4wrV+4Q+sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 05:36:07 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 05:36:06 +0000
Message-ID: <d4b44d77-3522-42bd-b02f-fe2e9be65857@amd.com>
Date: Wed, 9 Apr 2025 15:35:59 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 02/13] memory: Change
 memory_region_set_ram_discard_manager() to return the result
Content-Language: en-US
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-3-chenyi.qiang@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250407074939.18657-3-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVP282CA0031.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:206::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 744ceed8-1366-4a83-d19b-08dd77286cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym1XMHpic3hRV3hDalJIZHBXS1VSMlpnRTg4S1R1bXkwUStRcFBrQnFDeE1v?=
 =?utf-8?B?d2F6QmlZanRDa3BqZFNCRWVlckFWa3FIWTlFWDV0TlFmYlNPdk44bFRiazJ6?=
 =?utf-8?B?VGVMRGlWQ2xRKytQMzNrcmhKRHZwalJWQXovUkE3OUkvVVdmaTRGQWZJSkNm?=
 =?utf-8?B?eXFuajVMYlhvdjF3U3Fha2pOTnlpamJHV1JsSUE4TE9oc3RCWGtmdHFFQUVG?=
 =?utf-8?B?VkF3KzgrMFkzV05xYWRoYjl2K25iTGpsRlV1dXhKUG1RZ2F2N2lISlhBOGFR?=
 =?utf-8?B?OFdkNVMreXpKdW8vSC90V2tFdXpQV1Flck14ZlM5Vkh2Tkk5c29YOUg2WHc3?=
 =?utf-8?B?dGYzdHA3MGlDTVdBSXJJQ2dMeHNPUXBaeTVKaEJ4Uno3aTA3eU9WUGMvR2Qw?=
 =?utf-8?B?alNEWEVjL0hBTDRBczAzU0lHdm56SVNaeEpIdmNGelc1NFB1YUNud0kvQzNB?=
 =?utf-8?B?d2RjRCtXNzdHVEhsKy9TdzEvcmF3Qk56V0pxaGJYV0FrQTh6N2lnK0R2QmVl?=
 =?utf-8?B?djJ2OXY0N3ZmMm14ck9tWFBFNktleVZzN3c0M1JKRGhYOGpLZmNyVnc1WDMx?=
 =?utf-8?B?N2tVbGRLM2o1emhEYjNvbjJlSDJ1OHVHeVdLVkpkd2dLb3B5aUw1SmkwMkNJ?=
 =?utf-8?B?T0sxNmkvVEhEZ3p3d2U1UmZIU0tSdlZta0RiUUgzWXBuTUZ5dWlZdVl0WFRa?=
 =?utf-8?B?azNxNDdRMGJ3S20yWW0zWTFEa3hvZGNJVnU3UzZKWml0M1JhT3BxNGE5QUtz?=
 =?utf-8?B?SldyM0JSY2Vqdk5KR0NQcXRCcVh0NFlZcEY2dHlUUTNPQnVObWNkQW1YTnNi?=
 =?utf-8?B?WnF4SGhSN3JmTzRteTBWTWQzV0psb00wWGZIRHpNWVFmOGVzV1Y4a2UvbDlO?=
 =?utf-8?B?TzdTRmQ0NXJGSnpWWWg0Sksrdm1TdCs4YTJITWVVNnhETzJzdFVhWmlCM2NY?=
 =?utf-8?B?Q0xrVFhPMHBQVHIwM1A5UVBnUzFnS3lPUVpUakVhL0lnem1ZWG5mOGRYOFZD?=
 =?utf-8?B?WVJhdkV1TTBxQVFDcVFjL3lpd3lVZFdUUDA5b1VRclVHL3JvdzFOYzQ4cXQz?=
 =?utf-8?B?U0diT3ZKeDM0eEpkYjJ0dnRtVjNEK3RIdHZ0WjFaVWlGOENzejMrdXlCUWJ3?=
 =?utf-8?B?bUw5NmlNaUp4anRBN1lYaUFLb0tPd1VPQ2NHcDVPRVBZSCtUTXVpUHR1ZEFM?=
 =?utf-8?B?YlB6Skg3Skh4VnhVMkdsM2t2WlBWbUptQzhuRHFncEhuTXF4ZFMwcjB2bGd0?=
 =?utf-8?B?R252VCsveEM3Y1d0Z1hab3JWcnFyR0J3NHpBaHBQcW0rODFiVytpREo2NFk3?=
 =?utf-8?B?QytuTkQ1NWVESjcyWG1DSkw5OFlBb0dFNVMwZVZIS1pxeXZXOGlBYVhRU0Vh?=
 =?utf-8?B?OFljeHJBSUNpd1NKWHl3cXFNMWY2UXFocEk2THdoQnlSZUdqSDd2L3RXbmtm?=
 =?utf-8?B?Umx3NDJuVEdnN3YzbkVYZEtxLys0MVZ1cmZrZEkwOG0zLzIwT2dQeDdzZmhN?=
 =?utf-8?B?cjdzL00zL1Y5MlpCQmhhd3VUZ1RQQmVQcHNab0h6a2plbERqcjJNWVdUeGxm?=
 =?utf-8?B?TWpWMEJlZ25FUE9XUXloSXVQM1JzTmJkbzk4WWFYUzFobEJiMUJuUDJRZFp0?=
 =?utf-8?B?c3N1SnBWREZhbmJEZGw1TG90cDBTaXNmaUdVL20vSmIwNlozSm9HWHZPVlFO?=
 =?utf-8?B?TTN3R0xIV3JaMTFpSm5kL1NwR2prTC9NeGt2bmxhMVUwMndQOEtYMGxrd20z?=
 =?utf-8?B?RU9uZ1FkTmxMdmhqOC92Q1dIQ3ZBWUx6Rk5UYi9yWDlpVHhTMURpSVlmK243?=
 =?utf-8?B?ZS9kTHhmK1FiWFZrOE9obzhwdjBSY2IzQlVVNzJkUjFYaDcwaU8xaVMvVk5K?=
 =?utf-8?Q?0iKgy4W/Au08O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czg0d1VjWVpySVJ5S0JBSWZBNzV2MnVxR0ppNlF5ZE1kZlQvWHZ3d20wVWpF?=
 =?utf-8?B?Q0crUzRBbGxYTURzUkJmZjJxVEMvZTgwaTkxOXNjQXFNNVpZT1pyclQ1dnpW?=
 =?utf-8?B?L3VRbmNVYXY0d1J3VFlCQjcwcnBhU3p6VGZPaW9SU1B3UEY4MktNMkxFUEFU?=
 =?utf-8?B?VTViSDFOWFlvQy93OUtMR3BVWFYyTWo3Rnc1a2t6SE1jd211V094Z3NhWDV0?=
 =?utf-8?B?KzJkUnRSa05nM0x4RWZCQXV3S1l0a0wvR0NwRVJzTWx3WWVOaGNmUUJEcWJE?=
 =?utf-8?B?MDdCcy9SbVF6UDNkc1gzOHhuM01zNFJXeUpYaXc4SWlJRXNSa2E1N3NOdXVT?=
 =?utf-8?B?VkhXZHAwbUQxblU2alBYbnJkT3pLdkJwVDg3bEplcGxRbDU4NFdaemtCak0y?=
 =?utf-8?B?VklHMEE4cFdEN1hpRHBGS1JGSGJhZm1jMUtFZk5acFREWWxhYndCS1l4azNz?=
 =?utf-8?B?L1RnblYyMlNDOWZvTzV1blJuQVRxb05Od1AxdlhhWHIvNUpNVHZEbDJZaWdS?=
 =?utf-8?B?TzlocngvQkwxZVQ3SjU4MHBxYlVZTEhaWElHTGFyTTlkOG1RVjVXK0RqNmFJ?=
 =?utf-8?B?aGpMV2pScGR6SHJCREFuZ1poOWNHVGExY0xNOTM4WEc3T3EvREdoVEZ1d3Ba?=
 =?utf-8?B?RnNRYjFaVlpoOG9rRnd5U3VUbHhxVTI3ZWhjM0U4aXh2NVlCQkJQZzJXOVU5?=
 =?utf-8?B?SjgzRUlkb0VzSjNxVEhnZkxvdW56SEkwZG9DWUtPOFZWWlNzeHY5R1lxMXU3?=
 =?utf-8?B?V2tUYzFXN1JsQUVnL1Y5N0JSbzlpcmswUlBsR0F3dG5GKy81TEMwa3Z6Tmlv?=
 =?utf-8?B?eDVWR1BHcHZBQXRGZVpmWDVscEdISUhacHk5S3VMdE50TklEck1kRVZOYTFO?=
 =?utf-8?B?R3hJRCtzRFZFNzJrZE9zcy9kRDJ0VFhVSUg2ekRZcm9SdmduMWFtM1VwUGUr?=
 =?utf-8?B?amlxZ2VHenFyQnFyK1plRHFuWHF2UHY3TnVVQ3RHanhhQ1Avd0ZTN05aZVhQ?=
 =?utf-8?B?OHVoNncvWkRyMlVZN2ZOdjVaQ2xlcFBZRWU0aUVheUc0dVZYRnQwSWZhcDZ5?=
 =?utf-8?B?dkxBVzhmaks3MFA1ZzJ0Y1B6aVFWczV0WEpKTVBzeEl2MzdGL3cyVVdkaUlB?=
 =?utf-8?B?elhaUGk1RGVMdVl6L2R1eVhZZFVmVDEwOWdNZWlTR0dWOWFVNEN4ZnZraHJT?=
 =?utf-8?B?RzZSd1FBSjJGV29WaUF4cHRiR0ZqWVA2WHQyWVlzNHVRMG5hRjJYTGZNS3FQ?=
 =?utf-8?B?dndZQVNvbXVIZlhscStpZTdNWWJUc1JnVFgwU3pvMS9VY3Z0SE41Y0xjVTNV?=
 =?utf-8?B?ZEcrSmFDZ1lKcUxKNkI5eW54QWFZZDVlVzZyOWxYVHNqdGR0WDcrSnZhbm41?=
 =?utf-8?B?V0ZUcDRzUnRTZ2hiOXZ5ZDJXWTlvU2NzVlFkekY2U1pzdExOQXRiNUJlaTU1?=
 =?utf-8?B?QTFKUDIxb3huMEVwWXR4R1ZFTlQ1bGdKckp0ODVoeW1sWFRVRnQ2QnZCVnBZ?=
 =?utf-8?B?dDhHWFNxMVEyZ1JVOURpNWRKRS9rbnZWM2svWGxYZmdXekNPc1Y2c094c1NB?=
 =?utf-8?B?NzJXZktSRC9SS3FoS0JLcWJWaDZiaERWbi9Cc1NzcHpzWTY0TGhGN0ZhcTVI?=
 =?utf-8?B?aW5QNXhwMXpSQnhQTlllTlQ5ZG9qek5lWU1nZTdNYWxiencvRlp0VkJRckZN?=
 =?utf-8?B?dWR6UnljTVBMRFQzOXk0VzRNWnVyZVlUaVlxdFoxaHhwNVQya2cyY3lhNmVV?=
 =?utf-8?B?T0dNWFQ0S2dQTmFzV28vbFFHb3JDditkb2RmVUtSNEt2ZDE2L3d1WDM1TWU3?=
 =?utf-8?B?aVo5aWtxRzg1ZlNsRDJocFZEd0cyNytKM25iT09iN0Z3T2dlUEx1WHlIMTVO?=
 =?utf-8?B?QkErRjhHV3Vzbm0vRDVSQ0xsakMzQWtJZGg3Z0ZuSVIwL2lzUjJRczRXZThM?=
 =?utf-8?B?ZHR5K2JxY3dQakp1eEIydmFwbW16Q0U4SWFjM3p2Y1FYeThKSEV5bTZtQWNW?=
 =?utf-8?B?Z2ZNN1J6YmdiMGl6QVBiQ2hXMmx5bW54c3M4QVZ3SEl0NitwN1VGMk5BK1Jt?=
 =?utf-8?B?VzNHQ0s5YklZWXdGa1FGY3lvMjh3QmlEVkpUTDFwbHhaVWJWeUdWamRMc0sw?=
 =?utf-8?Q?nfSf0nGDRcavNepFmPT/KIQh2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744ceed8-1366-4a83-d19b-08dd77286cdc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:36:06.7566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yThu+mUTFCsa/s0YmsBLvZLOKuq//oG0nXKoKc7wGktEqd94vviWjaFLaCxhS+6uQv10MgrN9UOPs4HzEy/4Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
Received-SPF: permerror client-ip=2a01:111:f403:2408::604;
 envelope-from=Alexey.Kardashevskiy@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 7/4/25 17:49, Chenyi Qiang wrote:
> Modify memory_region_set_ram_discard_manager() to return false if a
> RamDiscardManager is already set in the MemoryRegion. The caller must
> handle this failure, such as having virtio-mem undo its actions and fail
> the realize() process. Opportunistically move the call earlier to avoid
> complex error handling.
> 
> This change is beneficial when introducing a new RamDiscardManager
> instance besides virtio-mem. After
> ram_block_coordinated_discard_require(true) unlocks all
> RamDiscardManager instances, only one instance is allowed to be set for
> a MemoryRegion at present.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v4:
>      - No change.
> 
> Changes in v3:
>      - Move set_ram_discard_manager() up to avoid a g_free()
>      - Clean up set_ram_discard_manager() definition
> 
> Changes in v2:
>      - newly added.
> ---
>   hw/virtio/virtio-mem.c | 29 ++++++++++++++++-------------
>   include/exec/memory.h  |  6 +++---
>   system/memory.c        | 10 +++++++---
>   3 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 21f16e4912..d0d3a0240f 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -1049,6 +1049,17 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    /*
> +     * Set ourselves as RamDiscardManager before the plug handler maps the
> +     * memory region and exposes it via an address space.
> +     */
> +    if (memory_region_set_ram_discard_manager(&vmem->memdev->mr,
> +                                              RAM_DISCARD_MANAGER(vmem))) {
> +        error_setg(errp, "Failed to set RamDiscardManager");
> +        ram_block_coordinated_discard_require(false);
> +        return;
> +    }
> +
>       /*
>        * We don't know at this point whether shared RAM is migrated using
>        * QEMU or migrated using the file content. "x-ignore-shared" will be

Right after the end of this comment block, do not you want 
memory_region_set_generic_state_manager(..., NULL)?


> @@ -1124,13 +1135,6 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>       vmem->system_reset = VIRTIO_MEM_SYSTEM_RESET(obj);
>       vmem->system_reset->vmem = vmem;
>       qemu_register_resettable(obj);
> -
> -    /*
> -     * Set ourselves as RamDiscardManager before the plug handler maps the
> -     * memory region and exposes it via an address space.
> -     */
> -    memory_region_set_ram_discard_manager(&vmem->memdev->mr,
> -                                          RAM_DISCARD_MANAGER(vmem));
>   }
>   
>   static void virtio_mem_device_unrealize(DeviceState *dev)
> @@ -1138,12 +1142,6 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>       VirtIOMEM *vmem = VIRTIO_MEM(dev);
>   
> -    /*
> -     * The unplug handler unmapped the memory region, it cannot be
> -     * found via an address space anymore. Unset ourselves.
> -     */
> -    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
> -
>       qemu_unregister_resettable(OBJECT(vmem->system_reset));
>       object_unref(OBJECT(vmem->system_reset));
>   
> @@ -1156,6 +1154,11 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
>       virtio_del_queue(vdev, 0);
>       virtio_cleanup(vdev);
>       g_free(vmem->bitmap);
> +    /*
> +     * The unplug handler unmapped the memory region, it cannot be
> +     * found via an address space anymore. Unset ourselves.
> +     */
> +    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
>       ram_block_coordinated_discard_require(false);
>   }
>   
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 3bebc43d59..390477b588 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2487,13 +2487,13 @@ static inline bool memory_region_has_ram_discard_manager(MemoryRegion *mr)
>    *
>    * This function must not be called for a mapped #MemoryRegion, a #MemoryRegion
>    * that does not cover RAM, or a #MemoryRegion that already has a
> - * #RamDiscardManager assigned.
> + * #RamDiscardManager assigned. Return 0 if the rdm is set successfully.
>    *
>    * @mr: the #MemoryRegion
>    * @rdm: #RamDiscardManager to set
>    */
> -void memory_region_set_ram_discard_manager(MemoryRegion *mr,
> -                                           RamDiscardManager *rdm);
> +int memory_region_set_ram_discard_manager(MemoryRegion *mr,
> +                                          RamDiscardManager *rdm);
>   
>   /**
>    * memory_region_find: translate an address/size relative to a
> diff --git a/system/memory.c b/system/memory.c
> index b17b5538ff..62d6b410f0 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2115,12 +2115,16 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
>       return mr->rdm;
>   }
>   
> -void memory_region_set_ram_discard_manager(MemoryRegion *mr,
> -                                           RamDiscardManager *rdm)
> +int memory_region_set_ram_discard_manager(MemoryRegion *mr,
> +                                          RamDiscardManager *rdm)
>   {
>       g_assert(memory_region_is_ram(mr));
> -    g_assert(!rdm || !mr->rdm);
> +    if (mr->rdm && rdm) {
> +        return -EBUSY;
> +    }
> +
>       mr->rdm = rdm;
> +    return 0;

This is a change which can potentially break something, or currently 
there is no way to trigger -EBUSY? Thanks,


>   }
>   
>   uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,

-- 
Alexey


