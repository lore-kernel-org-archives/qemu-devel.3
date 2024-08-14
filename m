Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D441C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 12:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seD1C-0006i8-Vl; Wed, 14 Aug 2024 08:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seD1B-0006h3-CN
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 08:22:21 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seD14-0000WI-D5
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 08:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723638135; x=1755174135;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dYpfgSd0Mc0TXiw/Zv2oBuOg6Pa9/c6m5C0IxE8CkCc=;
 b=YZOALuXqtUiv6PSRpGwBPDwAPDAxG95q3qEnxTXgJ8i65LWXzwtAPdAM
 N3iP/tqKl5/GM1PMBNBHDQFuBJbI2KdHXGoLlfglRRfe/3MqPZxaBPuJM
 1CaYRNolM9lf+oRH9r3KW8LhNbyIcUc6AU7ZskaaWs77uttEnFWS5mTr/
 z2oFd6lLCUkPdqroIHXTuSFVpf6xHs99egUuUvSrxI9uFU+OVmA1e7CaX
 LYhnHDuS2jJ3afrXStoFPY1MVLggtoyiNe3Q3bKZrLQ9RHrNiM8sYsOH/
 AYOl8vHWoHe/gb33ouXTy90htW0kg+DXakuBzpNz3nxG2DaaF7R1mXqJV Q==;
X-CSE-ConnectionGUID: mFJnn5atTVWYVkP4RwxLtA==
X-CSE-MsgGUID: iRci/wvwQL+Oc7wpZ9lpjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39355296"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; d="scan'208";a="39355296"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 05:22:13 -0700
X-CSE-ConnectionGUID: y4ISFGbTR1qseOi/FBy0YA==
X-CSE-MsgGUID: +iUn/YvETzWQrSt5rMp8LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; d="scan'208";a="89692639"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 05:22:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 05:22:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 05:22:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 05:22:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 05:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG6uALO69ZqdNjalAfnEVX1pkrEW4xAPIZXvqt4dSDtFjet/B8lmdF1pghj6FB7Z0zEc2Z3tCjffvkM7VuQ1hKMgjZ9DcmnxOhVN9FiXWMyi5vbnhej8jVC8XWBtc6hS41ZSllirwp/5t4dJ+ppGe2d8u4Ed9VuPVQwhu6zpzEmKoBaQh/rVVODWZJ3AvulIK+oL42F8KWTOC2PShz5W/SwAGqqagHL+QPZ5tNHGPbVspKxc8R9bKaRVUPYoqWz28o+E+kNyzBc4YhmSWBn3z9vshT0LwBr78HFxlknOzT3drTSYzISCdUWJjMdUb1vZlb4kIEzqr8M4cdRchJZmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DtduF09EcD+wlSO1JN8LJZmrVXiaU6r50S+/sSCBwg=;
 b=owaINne/oacva8BbVs0PaHj/8PI44WoaNW6ltw/al2+4eG4M/IsNeU05GIhX0WwcNFWSIDV0zzJP8s9FRscY6AWzAU3+kHdgLcNVPsKX4gjQwAhfH5eJOmtlG9WmyNsqvazhFRKsoSPCyfksh07FkPHOCfjsAZILRMWIW+MNHc4UF9nMzj4kPzd6Z0FISd20fyLiMeKMvyjylWMnLvRiMfMHDEawCH+fv0it2NzEIDBZRcsgrWlll2505G7va1E6Qs5gUf1hjHOraENp+oMPhps+Ny6ceNouifgHlrDrfXvF0UYSmP9X5Z8KZBHor1TGPCtIO2p6R8vJ4j16gZHJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV3PR11MB8460.namprd11.prod.outlook.com (2603:10b6:408:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 12:22:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 12:22:03 +0000
Message-ID: <745d9b3a-388f-4dfb-9062-4591ffd457c3@intel.com>
Date: Wed, 14 Aug 2024 20:26:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-15-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240805062727.2307552-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV3PR11MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fed82c-cd41-4c02-8a78-08dcbc5bb3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 1vyuyK+JK7i4TjKK+6wxOCdvGCNBgkMZgTKTVW9E6yRvk0bqws7+sz3gMYaY3HFiQJ04lqhlrGU/gri6s6cskk8mFj+TwjqYU4jhr85FjR6/nroUuhDMe4tv9IPkH3BFsIKRFaVQgSBDs4JcWjAAqYwW9fVjjDlPQL3ifsrcUfYxkEHV0f8XfOCPtwGXdJVdr2ls6GSduP87qpSfz5DhwbQDUMnwKq28nbF3YNQqlOhKBYxaO0kJL2LItphMre5dwuOpgqFKvehZ8gc/fgmJNIG32DfMevvqO/QI04wNQ+iHK5M4Wey8EH+wdrCOS4v/MHZ6DTLKtALKLs9u0oUxJPbPoKqkloexr/unCGlHpcPgnKmQEth2DSzr0qbdCeCUnRBv2G75D2GcDf77vUZewmDr4dSVmzB1I62BjTfn38HMjjQ/pD7p5eTp5nFwrVZL8JNOmD5W95oCRp6JnOWDUghU107helJCkp6QfeExeHw9m6zXGG75+j1tS4R1ReTI7s6jrRXY7Gqt9WiVDh/2h6oBm7ppQNLqXvhkRh62MZF9QH+4YRmhl4XDveFPUczDFBWT2K3NEDZkYFvVHTEG/xp+UMdrT6oiOy0SCBbNZ1Ol0LDqiKYns6zPuMtgMHLAx7dPxmz+QIg9VNo0M2Sv1IWg4GzgOpfxM32AuGS5mXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdaUVVEWnRWNzMvOEN1Q3lEYlpteEt3ci9LNkttSTZ1NzM0bjd6cUgyanZr?=
 =?utf-8?B?UzBXWUNpcTdMaFhLWTZRU3g4aXczNW5Jc0llcVZCVTN2dlBYUVR6cFJwZXM1?=
 =?utf-8?B?ditUT0hEak9GeVIwL1BLRWYxWURaKzJyNGxQK0tGVDRHMU00b2VwT3Nrcldk?=
 =?utf-8?B?NGMwSUFaQ3BvVUZtNXpTbTJhQ0s3NndIUmFoMFVMMDFVS1JTV3JIQ1FZRk83?=
 =?utf-8?B?OEhWT29PWTBkZXZpNnVKWlNjcFVIc3NWb2pCUEgyMzVwWkxDK2lNbUgyMHI4?=
 =?utf-8?B?ZWNWR0pkeEdrSXgzTGMxdkNXWmZxVnZUbmd5eXo0bXF6RmIzSWtuaVlmRzNL?=
 =?utf-8?B?aDdrQmFUNWtGTzVVUllLYUF2T1h4NE5CUUxqTG95ZEpkWCsxQ3VWREVUZVFY?=
 =?utf-8?B?eXYzKzhVVUE0NllmeGtOMnR6bzlHb01YV0JkYzZQS3d4RmI1NnFYOW5UZEh6?=
 =?utf-8?B?YW1KbWs5RkhQdUgzc3pDeWRHc3pzbThaR2xJT3BobG5tazB4bmlqVy93eGlt?=
 =?utf-8?B?bWZHM1J4d2ZrdHphekNtRFpOdnMrajRaNmhOc00zRmN6ZWE3VlZ0U1g3bFp6?=
 =?utf-8?B?U2E2a0NDa1h6TnF4aFE5K2NHNStiTlJwVXd0UCsxLzVSTktKUWFIR1hRcHA5?=
 =?utf-8?B?bmdPNjV0Sk9DM0Q3Q3I4QndPZzRZTmlidHdKTWRCYnJsZEgzWkpxekcreHhi?=
 =?utf-8?B?R1ZBNzZ0NFpXdFhxSW1QTHJrVEZkYUhPdHgzaFl3aHp3STIzTkVkOTdPK1hj?=
 =?utf-8?B?WGhNV3NBbVVkU0lIZUIvSWlSeks0R1BqQmlVT1BCandmTmRsQ3pyM3F1NHM4?=
 =?utf-8?B?bERzcHV4SWlaakJoRWNxM01wUXhpclFFSzdJY2NuNDQ0Z3FiSlB3UTRnMm1K?=
 =?utf-8?B?NUZPaXF5TllpL2dsVURJaVhKYmxOMTkyMHEwM2NIN09uRk1ZSFVmQ1lKRWFw?=
 =?utf-8?B?aWpUeEZvbzlQM0RaMlZaYXJjaXJCWGZaeElEeDFJODd4TjNSYXpYbW5OK0NQ?=
 =?utf-8?B?SzJ6bHJ5UzZ1d1ArV3lxVzVEWjliM0NyeU1ERVhNNkJPMWNuRVhlZGtpazNT?=
 =?utf-8?B?cmg4M2Q5OHVQVVRWamRJR0NUYjYxRlo2NjY0NUdUWWVwMVM3eFBwaVFPT1cy?=
 =?utf-8?B?dDlDUzQ3VEZuRzRqQVZrdUp3bXFtVUVsV29WakZjcDZrQ2FRcWlxWTNSUTEv?=
 =?utf-8?B?ME02TXQzOE1XQzh4MVNzSHYyeS8zTWlkaldjdkd6S0FYcFNhWEZyZ2FMd1ZY?=
 =?utf-8?B?Sk5tZHJOVVdJOTJ0UFc4RktPcHd4NzNLRkJKTGxTQVAySFlZWlIzbUdwanl1?=
 =?utf-8?B?R1hGeFJjcUVKNlQ4Y2RwL3FndFcrcjVmWjI3QzYyOVA3a0U4aHJpeWpSakVx?=
 =?utf-8?B?SHR6eWUwQ1p5LytFcEhHV09lakhDeEgySExRU2J2VU9TeC8xSCtGSXAvVHZQ?=
 =?utf-8?B?K2lVekNOeUJ6cWxCSGYwK2FTNkdHb25GMnJsVXRuRjloeGtETTYzMU4rSENR?=
 =?utf-8?B?cXZITEtvdWY0NUhVOWVrMDN4M21xK3B1SzVDdVhUaWxLbUxiM3krZTY0Q0wy?=
 =?utf-8?B?aWo3U1JCYklOSFR6K1NPT0l2eXhWVk5DL3lCQmVXeDVOSW05L1loTFc0N045?=
 =?utf-8?B?c2wxai91VklsSnVFSDlRV1pGUlg1bzZrZmUzdU5PM0J6ZU85endac1lxemNt?=
 =?utf-8?B?OG44YmxlR0ZDN3d5cXZ6dklSSFVjdkZZT3dmL2NsR25VUE5PUEJ1bmgwTVRT?=
 =?utf-8?B?Z0o5ZlJMWUFaY0x4d21penVzUmhlU2FlZUJWQ2U5MnZHTzR2emxrcSsybWsr?=
 =?utf-8?B?bkdrWloyRU9BT1BGc2dhNFlxYlRTdEhkT2lrVW8weU9Ud1BNbEFDeENKSXhV?=
 =?utf-8?B?UkdsVm5JTWFhMy9zcGp0SkxLYmJobXlEc0JtK25QZHpQUmZxazBqUWxxYWh1?=
 =?utf-8?B?cURwUC9KQ05LNXE2VVE1U0F6MG51UHl1MnRyczMrU2VZb0g4Vk9WT0xJTm1R?=
 =?utf-8?B?SWlYNlU1OWJVdVAvVzk0ZndWbU1YS1NOSlAxVWlhdkdsc25hVmlwYkt4bmdH?=
 =?utf-8?B?ZEltSi9QMGtGV01PbHVVQ24zcHU2eUFBWWhpRFZKY0d2bXRmSXFBM0FacitL?=
 =?utf-8?Q?jDyMv66R63q9oDBaV+uQ/XqVq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fed82c-cd41-4c02-8a78-08dcbc5bb3ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 12:22:02.9636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+j9GoawVBLH1kWOwIORc9j8iO6GeHIEDri/EQKFOnTxndaewXi06iF9te6xxP+hf3txJhAb+PdncmgFjy6g0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8460
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024/8/5 14:27, Zhenzhong Duan wrote:
> According to VTD spec, stage-1 page table could support 4-level and
> 5-level paging.
> 
> However, 5-level paging translation emulation is unsupported yet.
> That means the only supported value for aw_bits is 48.
> 
> So default aw_bits to 48 in scalable modern mode. In other cases,
> it is still default to 39 for compatibility.
> 
> Add a check to ensure user specified value is 48 in modern mode
> for now.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>   include/hw/i386/intel_iommu.h |  2 +-
>   hw/i386/intel_iommu.c         | 16 +++++++++++++++-
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index b843d069cc..48134bda11 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -45,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
>   #define DMAR_REG_SIZE               0x230
>   #define VTD_HOST_AW_39BIT           39
>   #define VTD_HOST_AW_48BIT           48
> -#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
> +#define VTD_HOST_AW_AUTO            0xff
>   #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>   
>   #define DMAR_REPORT_F_INTR          (1)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 317e630e08..5469ab4f9b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3770,7 +3770,7 @@ static Property vtd_properties[] = {
>                               ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
>       DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> -                      VTD_HOST_ADDRESS_WIDTH),
> +                      VTD_HOST_AW_AUTO),
>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
> @@ -4685,6 +4685,14 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           }
>       }
>   
> +    if (s->aw_bits == VTD_HOST_AW_AUTO) {
> +        if (s->scalable_modern) {
> +            s->aw_bits = VTD_HOST_AW_48BIT;
> +        } else {
> +            s->aw_bits = VTD_HOST_AW_39BIT;
> +        }
> +    }
> +
>       if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
>           (s->aw_bits != VTD_HOST_AW_48BIT) &&
>           !s->scalable_modern) {
> @@ -4693,6 +4701,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           return false;
>       }
>   
> +    if ((s->aw_bits != VTD_HOST_AW_48BIT) && s->scalable_modern) {
> +        error_setg(errp, "Supported values for aw-bits are: %d",
> +                   VTD_HOST_AW_48BIT);

call out it is for scalable modern.:)

> +        return false;
> +    }
> +
>       if (s->scalable_mode && !s->dma_drain) {
>           error_setg(errp, "Need to set dma_drain for scalable mode");
>           return false;

-- 
Regards,
Yi Liu

