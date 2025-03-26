Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A53C3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVrD-0007VN-KO; Wed, 26 Mar 2025 14:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txVr2-0007SC-1i
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:52:01 -0400
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com
 ([40.107.94.68] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txVqx-0006Hm-Td
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxdfOu85Ig1asYRZWUAdhFUtVvdkwQ0HeMSh7aq4rPqMnkpPjHKyO6i0UjW/2pzLuWP8G9BKMuzU65bymlWavLKTMSnuj7jKBo0tz7Q/OlsVj2z2KlIgd2gkXbQTvnoU0qjurBoaT4sST8Y0pJpAsKnnEtNVTsaACRr6I68CAx9p5jpYAeLOZwJOKGxR2/vjumFqw2lMvI+vFLH1APGsLN7JdTbBaEgkebcPRmP4DEWEG/2plD4FAXwGopaFfr83qwVNOfAw0c880YfopPjpwD7r60DCTBBQjbrcOXCV/yTfCmv9nm7Irdk2Zmz8GrF4eGaPah75xNDNbtrd3XhaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwjIhedna6RVTHXxhSn+8lgTpcNl3RRj+gHyRYCxdXE=;
 b=HWjXtxl/O/26Tcq28DXZ2PEBxhgonbFwUWGfS2m8Wh43tDkZ20lNZVXWgzUaUb8gJPnzfCwCGrrCfLy5fZdffrUYc3fj/CxuXqwaeXrIFJVC1k+kPlj5A+g6nrbCR/ye7LHkwZx3BpPIvtzvsWiPN46NtAa0NxYXtre/FnlJULdXRzcKFbedQeCfsYgTcPCELmS5DRojSOUe5QHegBCDPM6EZ4Sca0J3YceGGVAcXfI0khV4i+BdZZ2zuFzkMkCQqUMilsm7PieEIjpErae4I16R9DVM79EkQ4cRSo9Nu1xcRxN+xkkGNDVEPRiVF5IR+jJBBrE2yCdNPMaLIziRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwjIhedna6RVTHXxhSn+8lgTpcNl3RRj+gHyRYCxdXE=;
 b=C+rED8gMe1/EiYseAwKyvmaGOPu/v4Xf9HI0V3Hb8Un2s5vaIPzEJYZMW3gKda+Ab5XqgjLILJfuIbyxwTN8Pr5PryTeVvoCNAY8O78I6tBeaJWo6wcmCHUb3mbuCnSlb41VNfbwG4cZ4KLUsRVxh2khCwge+rvnUgMM6oqs6zI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 18:46:43 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 18:46:43 +0000
Message-ID: <829e27d6-eb6b-8a26-e982-0ba936888c6a@amd.com>
Date: Wed, 26 Mar 2025 13:46:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 2/8] migration: ram block cpr blockers
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 David Hildenbrand <david@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-3-farosas@suse.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250307181551.19887-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:130::11) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bef9caa-6867-4ccd-4753-08dd6c968d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGtzYVUwM0FXVDF1c0pPQ2M3NmdvTTBlWXM5ZFRLZTlZQWw2ZWliZFFkWi9Y?=
 =?utf-8?B?OE8xSjkzK1J5SkhEazg5SElLL0NGU0lrbnpNelVqNkYrdks2MzJ1TDVjQVIr?=
 =?utf-8?B?clNjUkl0aUVjZEs2WUd6SmxwS2w4Y3VXNW5SSnE0WEZtMUVQM0hEd3N5bUdn?=
 =?utf-8?B?K0hLcWU4MFRHYzdEc0xhQ0JxTTJBTkUzQWJuTWNRZjNmZmtqMGtXRkZEZUhC?=
 =?utf-8?B?R1JlcG1vcnhLeVFuTm0yTUR4VDJhQWlJNSswMkRQUndVMHIzYkgvemZoQmdI?=
 =?utf-8?B?SmFRRzMrZUpvV1BzL3hRY1Z0TVBrZXNrNXNSM1ZQRjdKaFZqWHR0UW82dGts?=
 =?utf-8?B?YUhDRlJTV2l0TFNNbGxrNnA3ZFdEYXNXMFM1VzRCdWhJeEJ4aE41aVJRbW90?=
 =?utf-8?B?aVVCVDVSR3hCa1FTaDl4R0JuczBYTCtFa1NxcFRTdmdTU3RpQVN4bGJ2NEhF?=
 =?utf-8?B?cU1qeFV5cGZyN0xMRGwyUlA3VnVNSzFhTzk3eGpHdWR0ZTRyQnF4cy96cWhZ?=
 =?utf-8?B?c1pJeDBhRUlIMDZ2bEtwZDBlMTkzY25DRU9NVEJ1VHdoSkFXQkxMT1hzYkhT?=
 =?utf-8?B?TlREZVBsNUtjUUhsU0pPVWluQ3hqMnJhR002QnZ4SlJyK1ZERnBMbmN3aEY0?=
 =?utf-8?B?UGlvczhxbFVUQ0hSTWtFOGpacGJMUzIyeTIreUZ6WktpZkJ5U3p1NUxxUDhR?=
 =?utf-8?B?NVQ1L1A3UWtOOE5HdTJ0WVlYQVhUS0REaUl1M2xqYWZJQjlPNWhkUUhCR3JL?=
 =?utf-8?B?NVYyTGpPRkpibkJVTThXTG9leURKT1lwV2FQQlBtVW5vUGk2ajgwc20zMk43?=
 =?utf-8?B?bUQwaG1PYWJDWGlWVzFPZ0JPV1oweEs5VjNDQ2ZzUEdER3NsOWdkQXhxaVhC?=
 =?utf-8?B?YklCK0dNcG1YYlBWYXA4YlZzR0RGN2VUU2xITnlVb3cwblJ6S2Fwc0hydzJq?=
 =?utf-8?B?WGljdFFMNm5jZmdEdHI3d0V2Z1VUMUVXK005c2tqSStmU3VyanNnUTBZV1I2?=
 =?utf-8?B?SzJiL0o3bHg0NmdhNFFTZm4yL0s5N3o1ZGNSSEhmc0Y5ek5Uc1RtT2huWXB3?=
 =?utf-8?B?SmRjZTJtTjFKSHFSemJmRE5LSEdsZkZ5T21rVTY5Y0RBcWhQUCtjWFRKNTNX?=
 =?utf-8?B?N0Fldzdla1VXVmJER0I0ekhFS1BYVms1U0JnWHgyTlQ2R3ZWMHUvVDA0SXBB?=
 =?utf-8?B?T0ovTWFUVkU4WHdHa1laMDI3Kzc2YWZoNVowZzk1K0JxR3A3L3RNMk5ZbWdG?=
 =?utf-8?B?aGxtQm04dm9kelcyeGFna3dRanZxUG5KNVR4TTRWSTBlck5xV3ZVTVJNc1Q0?=
 =?utf-8?B?aVFzRURYL05GU0ZwNFhnWWZENC9kK045Q0lDV052cGV1T01rSlhpT2c1T2tR?=
 =?utf-8?B?MmpxRW1pL3BHRXlPYkVkdUVWcGoxSlpMaVg2aGdCTS9neXNtbWZEcTFyQm5h?=
 =?utf-8?B?WnEzVGs2Y0F1UjFENm8xelVSMXNXTzNXWTJhaW45dlVxTi9pR0tXenB2NEU4?=
 =?utf-8?B?YmxxK0JhVnJpcjg2Zzhwd2owb3RHRXVPYWErNFFyQXEzVEpTYmdZUXg1WGEv?=
 =?utf-8?B?QjFEZXI4cmo0NzdtWDJJaEZ2MU5XWWhvMElZcElsUVU5SUZ4cTM3Zy9VcnFw?=
 =?utf-8?B?N3JmV0xVRXdMcXVhZ0xQdUZ3YWFXQ1ZWelVIY1g2WmtwbGxKeFA4eE0vU2tS?=
 =?utf-8?B?a3d0alZyemxxUW9RRWYycFlKK2FZd2hUTGxvUUFzVkRaQ1VKUmZ5cEhUUEQw?=
 =?utf-8?B?a2xWNE01SW5xWVgwNFNnWUJERVdVZmRiaFhvNGdMMG05dExZMzd0NEtsSG5n?=
 =?utf-8?B?N3NLa0YwWHV5eFV2bndLcUY3WndLNWtKNGdUWkNNSEV3RVBNMDRkNFlaalg1?=
 =?utf-8?Q?IDNIY46F9oqJN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWxWZEpaSEVMNERPS21yYXpTQUtRS1cxT21PaDhabVFMU2JXMGNMSnY3WVFm?=
 =?utf-8?B?bDRHTEZoWTd4YytRR2p5OHBDQjdlM2ZNWWVMK3pDK0NMVFRuL3dTNXlkdUZ1?=
 =?utf-8?B?bXM3cCtwaStpMElxMDZzSktST0lSbGNQUmFoUjVudVNSWURIYjRBQlJMWDhh?=
 =?utf-8?B?RzFBOHM2L0tVL2JuNFRJTkFkRUNZaDBGZVh4QkpVd0JNQ0JIM2xHcHBremV5?=
 =?utf-8?B?RHhybWF4V1N2U2IvaDhFb1pwWkcvSzF0TUdYc1FZWjZDRnNPMWxrRHl1Rlhk?=
 =?utf-8?B?UWFNaHkxazNRK3RJc05wcGJSa3NNOUxJam9xZ0YxWWJSTWtZMjhlTnRyd2Q2?=
 =?utf-8?B?Ymt6NVNxRlhZYlZiY2hSOXZkeExldXhjTnFuMTBJS3Zxd3lwbnJ3dExTWWxu?=
 =?utf-8?B?UDRkaWQ5K0VuZGtEaEpXUmJmc085clR5RUNnd0tzaW1IKzkrK3pIRGZOeWkz?=
 =?utf-8?B?WkZtYTJ6bjh6OWV4RGMyNkZJMVZMZWUwdTZnMG5SN3JCZ3Z5bVh1ZnJqMmZO?=
 =?utf-8?B?bldWdGN3MldjOHBnVzNIbUkwR2kwN2VJU1RqZWlrR3FsUHM1UHkwSi9lUmJs?=
 =?utf-8?B?eDV2ZU43UHpyditrdlM1ODdoZ24vODdZcVlUcmpydFJXSlVxRUx6ZFVvbG9j?=
 =?utf-8?B?RDBvK3FFUUdvN2MvTGhqVytJRjRPemFmTllQejJIU0o2b1VrZ25TVDg3Ym9w?=
 =?utf-8?B?aDN2bXI0UE16VEFZaTFGL1QrcFJoNzBVQ3Y2MUdsYXRzeHJhS0xVZXFncm9M?=
 =?utf-8?B?Yk1XYXVScElQd1JnUFMzOTJxQzE4czA1TmdQR3YwZzN0VFZHRExQOThwc0Rr?=
 =?utf-8?B?NE5pR1lYand1REtDZTJtdUhTS0FndFdmWjZITU90cXNwMUU2d3l2UTdDSEJK?=
 =?utf-8?B?WWg0NnUxZjFpRVlyL3ZxQW5JQit0UzlCUGVWcmc0NHZSaXpkdnRmcUFYOHpV?=
 =?utf-8?B?RldxRDBjeGswSDk4NGcySVdGUUE2a25QbVVMRGl0MDc1WEJuUThEOUNoK3hy?=
 =?utf-8?B?cDczWXNzWVIwTnEyaUc5UW90ZkdndWJyTkRPY3hSNHJIN2owZktLUHl5cFRn?=
 =?utf-8?B?UXNmamJJa0lua3J6Vis2TXJHc3VXR3hwckVHSG5KL040bXJUN1g5anBSRmhi?=
 =?utf-8?B?UjZJVU1hRktrQ3N6cEFKd1FjL290cGgwRTNpV3VlS3BORHRMVEE0YS9hcnFi?=
 =?utf-8?B?UU56REt1Rjl6NzhhOU8xR2U4REJ1YW1LTlNXejNuMkM1d1dHa3BVRWhOSHRF?=
 =?utf-8?B?b1pLNlhXcm8reVNjU2wwd1grQTM2VVB5Ris0V1lpbDE1VTRZVW12Q3JnYXNH?=
 =?utf-8?B?ajQrV3BabnlNN0VYcGk2d2ZvMG1QcGFNVTMzZWNhYm4wU1ZJTWRBWm14NjVr?=
 =?utf-8?B?THdMOWNtQzlDNERSTDRDMVNoUW84Ny9lRjEwWk14N0ZmVTdlZ1hPNFdncUVa?=
 =?utf-8?B?UU9uSTg5cnNFb0ZhMU1hVThMTVJlNGM2Tzl3RGZIZG9zaFRnbXJzeUMzdHJk?=
 =?utf-8?B?Z0p3VHZ3d3crWmJxODZwYzhWZS9CNk9aZmZjZ3Z4UWlLOXJTdFVUSGNtVzJz?=
 =?utf-8?B?ZnJoNW45WmFGVXZuNGI3S2NUM0hUQzJsTG1kMGlyY0dmeWd0M29FQWhhZGk5?=
 =?utf-8?B?M1RqUElIRS9nZE9LcWQwUGZTdUk2QkNhZlYxRWQrZFRQZVlOUG1CSUN2bG1r?=
 =?utf-8?B?bmkyK1JROEU0dkpkdWtSbjdQUDVyVXJGektqUWp3b2VkUEVBcVVrV1F5bll0?=
 =?utf-8?B?dFlLUjZPNW0zdU1Xc2lGZmh3L0h1b3dWeUhXbW5KNC84bldWZUNKbnVqdkJx?=
 =?utf-8?B?cExOaGFQQ3R5R0dsOXIxdm03VHBuYWx4SGk1OC9DSnh2emRPTkExZEV4dXl3?=
 =?utf-8?B?aE4xYVhHQjNXSnlMeThhNllsM3d6RzNMMm1KbEcwdC9FSjhsd2Z5aENLVlFG?=
 =?utf-8?B?TFhDOWtkTFNBQnV5Mmh2c2JyU3poVWRON1pzOS8xb0Q1aW1BRUhqZGRscTNU?=
 =?utf-8?B?aEZPL1VRZnlTN0NmdkJRdmdIaThYQktqZXVPMGV4QytkbkJUYjZ2UlZKbzJF?=
 =?utf-8?B?ZU5iRFVCbmgrakdxeHpjWU5Vd3l0ZlExSW5zdnRTVDNjVUM0VW1US2U5WkRk?=
 =?utf-8?Q?QRw29mom+c9zckza3BliX9wuH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bef9caa-6867-4ccd-4753-08dd6c968d77
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 18:46:43.3199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHfHbi1I07kQuU5znFZRdOgfBfri+9krDHX3yJp+kCq7GJztwGi7Av/ArMwhMQKgWu7blk6gcD0fqz5PfTzi2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
Received-SPF: permerror client-ip=40.107.94.68;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.624, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/7/25 12:15, Fabiano Rosas wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
> in the migration stream file and recreate them later, because the physical
> memory for the blocks is pinned and registered for vfio.  Add a blocker
> for volatile ram blocks.
> 
> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
> sufficient for CPR, but it has not been tested yet.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Message-ID: <1740667681-257312-1-git-send-email-steven.sistare@oracle.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/exec/memory.h   |  3 ++
>  include/exec/ramblock.h |  1 +
>  migration/savevm.c      |  2 ++
>  system/physmem.c        | 66 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)

This patch breaks booting an SNP guest as it triggers the following
assert:

qemu-system-x86_64: ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.

I tracked it to the err_setg() call in ram_block_add_cpr_blocker().
It looks like the error message is unable to be printed because
rb->cpr_blocker is NULL.

Adding aux-ram-share=on to the -machine object gets me past the error and
therefore the assertion, but isn't that an incompatible change to how an
SNP guest has to be started?

Thanks,
Tom

> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 78c4e0aec8..d09af58c97 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -3203,6 +3203,9 @@ bool ram_block_discard_is_disabled(void);
>   */
>  bool ram_block_discard_is_required(void);
>  
> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
> +void ram_block_del_cpr_blocker(RAMBlock *rb);
> +
>  #endif
>  
>  #endif
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 0babd105c0..64484cd821 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -39,6 +39,7 @@ struct RAMBlock {
>      /* RCU-enabled, writes protected by the ramlist lock */
>      QLIST_ENTRY(RAMBlock) next;
>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> +    Error *cpr_blocker;
>      int fd;
>      uint64_t fd_offset;
>      int guest_memfd;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 5c4fdfd95e..ce158c3512 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3514,12 +3514,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
>      qemu_ram_set_idstr(mr->ram_block,
>                         memory_region_name(mr), dev);
>      qemu_ram_set_migratable(mr->ram_block);
> +    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
>  }
>  
>  void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
>  {
>      qemu_ram_unset_idstr(mr->ram_block);
>      qemu_ram_unset_migratable(mr->ram_block);
> +    ram_block_del_cpr_blocker(mr->ram_block);
>  }
>  
>  void vmstate_register_ram_global(MemoryRegion *mr)
> diff --git a/system/physmem.c b/system/physmem.c
> index 8c1736f84e..445981a1b4 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -70,7 +70,10 @@
>  
>  #include "qemu/pmem.h"
>  
> +#include "qapi/qapi-types-migration.h"
> +#include "migration/blocker.h"
>  #include "migration/cpr.h"
> +#include "migration/options.h"
>  #include "migration/vmstate.h"
>  
>  #include "qemu/range.h"
> @@ -1903,6 +1906,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              qemu_mutex_unlock_ramlist();
>              goto out_free;
>          }
> +
> +        error_setg(&new_block->cpr_blocker,
> +                   "Memory region %s uses guest_memfd, "
> +                   "which is not supported with CPR.",
> +                   memory_region_name(new_block->mr));
> +        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> +                                  MIG_MODE_CPR_TRANSFER,
> +                                  -1);
>      }
>  
>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
> @@ -4094,3 +4105,58 @@ bool ram_block_discard_is_required(void)
>      return qatomic_read(&ram_block_discard_required_cnt) ||
>             qatomic_read(&ram_block_coordinated_discard_required_cnt);
>  }
> +
> +/*
> + * Return true if ram is compatible with CPR.  Do not exclude rom,
> + * because the rom file could change in new QEMU.
> + */
> +static bool ram_is_cpr_compatible(RAMBlock *rb)
> +{
> +    MemoryRegion *mr = rb->mr;
> +
> +    if (!mr || !memory_region_is_ram(mr)) {
> +        return true;
> +    }
> +
> +    /* Ram device is remapped in new QEMU */
> +    if (memory_region_is_ram_device(mr)) {
> +        return true;
> +    }
> +
> +    /*
> +     * A file descriptor is passed to new QEMU and remapped, or its backing
> +     * file is reopened and mapped.  It must be shared to avoid COW.
> +     */
> +    if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +/*
> + * Add a blocker for each volatile ram block.  This function should only be
> + * called after we know that the block is migratable.  Non-migratable blocks
> + * are either re-created in new QEMU, or are handled specially, or are covered
> + * by a device-level CPR blocker.
> + */
> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
> +{
> +    assert(qemu_ram_is_migratable(rb));
> +
> +    if (ram_is_cpr_compatible(rb)) {
> +        return;
> +    }
> +
> +    error_setg(&rb->cpr_blocker,
> +               "Memory region %s is not compatible with CPR. share=on is "
> +               "required for memory-backend objects, and aux-ram-share=on is "
> +               "required.", memory_region_name(rb->mr));
> +    migrate_add_blocker_modes(&rb->cpr_blocker, errp, MIG_MODE_CPR_TRANSFER,
> +                              -1);
> +}
> +
> +void ram_block_del_cpr_blocker(RAMBlock *rb)
> +{
> +    migrate_del_blocker(&rb->cpr_blocker);
> +}

