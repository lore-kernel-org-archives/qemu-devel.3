Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1466CD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQICe-0000zV-4H; Fri, 22 May 2026 01:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQICb-0000zC-Rr
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:13:42 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQICa-0006tw-7W
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779426820; x=1810962820;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x/Ia/KnPrFZxismRPPnXx25KU2uyYPRl6APofyyj1Fs=;
 b=Lr2i+be60RC49UjWJ1tQfexjw6v0q0AK+I4ryTveJhmvAEjYw0sjNr85
 4w9jnPHUu09BAGY1j+tbo78r3rMtX+IyANxCfFHAtaciB8zaX+Y9DuySA
 Jr2AZZUbxVXo5dxRY3VBmpSBfl/GOtzHmI3tAif3bxKM2Uq+Dovm7V4gv
 oTPIS6KHLFH3SzhGsq8jQD8036T7MjtD7Bmxw/kVnk6z5SxfPR9c0F4Kb
 d38w2iC9G0JqIxvdaVNqljpXZSpg8VcTwHLGlx/Cqj9CR4Qwl3D/VzBZX
 5gJUtXEZRAg3yZfJmJ/X2ga4flvih5e5OWOpr3T3IneXrqoHF6eMur9ja g==;
X-CSE-ConnectionGUID: uGv3r2+oS0G8fN0ycgHO0w==
X-CSE-MsgGUID: 2dXynlWoRZuZJ3sCMxMP7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="90927961"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="90927961"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 22:13:38 -0700
X-CSE-ConnectionGUID: yOh8TsWjQJ68H1c5/4UnBQ==
X-CSE-MsgGUID: 6aq+ArRxQvimTxRF9mZARg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="238179283"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 22:13:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:13:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 22:13:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+yAzM9IzkdCPD95z77YIHhrJ6PomQ444l+w+G8ukgtuajFwvKiQbJS7acZrVCsXlH8hTYXzPrS7hwJLALO3Ya34gCeL/kNA50fyg4IlU9AGCzxgTdzA37bJ8pXwu4S26fv3yPHx/H1ePwP5dyF53INodM2EjmL8fF/s/WDdNyZojitVPgZoUvJLCJIr1ZpTih2O7GL4MDwd3KJVRgVp2y7EEQJfyq6N6M4dbYkfO4peDZGG6kD7UsfegbxhBPpVQolMZlU7yQuA3Tcq6aRxz7Mv6evRWZr9GKSwT5PFZhXBta76biSA/rXVT4RyaO+lfS3kVtm1cV6c7P8t5bhwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+toY2hxhHeGEAKDZu11ji3WhvVgQBrMducufl+wk5sY=;
 b=kZu7xJ6ZmX0Mk3TMlo+TH10Hs4329xJ43PTd1ORwRxkCbv8bA1twJ1RPom3z8keqRELHS6tov6LLfu2AL00vI5d2IzqflQTXG/vP3zNs9pb7ke99XylwcBLwyCeRDuQ1PH1ODGd4GZFXk2fu2H4Qnplxjwoa4lNHgouBV2SR0sO6v2vPJtEiASLOvUuTuoIN6Ij83y/JO7XVKBwmNdzvMe6DS0qQyDWbebOSsxdcobVoBbIWfTLoL13qLBg6fkHrsnrk4FXvA+81LfAdLN76a+bKfRvuDb+OfUQJHGlOzbAVvcfqsLN6OVJ2fURVUlY/avQUvDv5swGKj1XNA5m98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH8PR11MB9534.namprd11.prod.outlook.com (2603:10b6:510:39f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 05:13:29 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 05:13:28 +0000
Message-ID: <6eb23f97-3fc4-42c1-a0db-1383d72bce6a@intel.com>
Date: Fri, 22 May 2026 13:21:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] intel_iommu_accel: Add pasid bits size check
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-15-zhenzhong.duan@intel.com>
 <33d2536a-6401-4724-a632-5cf5003f2143@intel.com>
 <IA3PR11MB9136F28FF99D26A8BDA1E2B692012@IA3PR11MB9136.namprd11.prod.outlook.com>
 <16d2698f-7fb1-4718-8e90-7979a3e8d0b2@intel.com>
 <IA3PR11MB9136D8E8BFC422BD83713FD1920E2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136D8E8BFC422BD83713FD1920E2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH8PR11MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b9f12e-dc64-4989-2142-08deb7c0dbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|42112799006|376014|11063799006|4143699003|56012099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ygectzAUmb3qsFQRn4CP4w9HEU6j13769EekE+2IMtDpXZEB9b2yzOZVudLN6dzxvxlxMnccE8hBIu9vtr879SVHWC9ayFcTlK7yToT+ldxK/XeSFfAgg1+30Zcij+/3RKawnxcEQkdktKqy4GlTrwAvlEcKrCtswJwKgLzJihHZcg/fLsgViVj8Zsvt4QvTbumZenTZGV+O+ZhFWwNZOr+A9BHTilXoOWhn/JsVwi4Fo6iTa5N8pH9Bfg3m9AzJMUK9JyPQrhVyyquP6TTcy9J2WETYSDUNbtaGKTIbb68IpqNVw8uFXVfqAt2rfoNP04Hlky28dTuFPBd2vGxRAlMbsNhyQL6Mnw66d1umFQsdECqvPafKcw0l/uX8yuzkYnsBeUW1oKgFmWvfVSYByFYAruVX6j0D/K5nhHZLFYx3D5HGtg/ntAYVQipxHMbsfi3/pGnK7KGeLQrHDF6NlIkHCakYPgttlt/beRQJub8l67Asn+ywfH+dAgFdhILCZAXTuXce0zVyD7F2wnNjFU97y8vJzuLt6/KETV4Jho61cNWcNdBta6IFo/wA0eY/Vqu2LxL1NFieRanzk/uMC8mONJvRDHCsZUT9xq1kWQLApf7EDejdKPCcIEqtUY3mTywvgdLZKJkbYGba95gdfeHXekFfZ0gBtU7+1woCnulE6dWFVen79c8QujPwIv09
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(42112799006)(376014)(11063799006)(4143699003)(56012099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdzZTVsYlBPZERDemhub3pDZWNhbGR5RFp5bTBXUlpjcjFvQWIrb1hSN3hy?=
 =?utf-8?B?Z0FiWDJKWVJCR0RsbFdzZ3kyUmV1bEVFM1ppbFdWOC9BcVk4NHYwTUZwMVUx?=
 =?utf-8?B?ZWNueFQ5Vm16cm0yU3hWS0c3d0tUV0FGb3EvTFlmaGY0SHBkNXlFM09vVTRj?=
 =?utf-8?B?bExFOHJwWXdGUHVrRUd4V0xPRlA2QkxTOWJIL2dnKzVFNW5Ha1AzbW9WK3VG?=
 =?utf-8?B?ckRSdWdJN0lpMjVkc3ZKU3VOWHdRdTBMYVRnTnRTUk1oVFNhaDJUUGhMNGZW?=
 =?utf-8?B?UkdhT0VxOVBsNmVmeU9ja042TWQ3d1M5Y0FuYmpHSVJsUGsyRzBtcGRXSlFk?=
 =?utf-8?B?VFBHaitHTjJrdVQ4VWJvTGlJbXIwbURuQWlwdnY1UG40YlFLWEViekFlSHc2?=
 =?utf-8?B?OWh2Mi9uZTFnMUFpN0pyREFoNHVpMFRlc0dScWw0dXNCZFQ3dFdjcVExWGpj?=
 =?utf-8?B?eEtJTFdZMTBabG5LTFJucDVWUGZZZDFXVS94VzcyNUkxYVJtR2xQYzZMWlVC?=
 =?utf-8?B?eitoVUhPblIzTjNlaHNrd2JjeXJoRHpsUW0zQ0sxc2JBVnUzZ0JEUmZGSzBq?=
 =?utf-8?B?TkVoQlNRZFlDUzh2QjBjRFB6cStwYkZJcHNheDRxOVdZOWhqdjM2SlVBUDF3?=
 =?utf-8?B?OWlERjVlL3NTL0orUVA5TFZ3bXpNVk5ROGJNWVpDWk9JL3RlU0lhb0VSVEZr?=
 =?utf-8?B?R1FwTFliU3hCUHlYQnJXUzErQTNxNDZ5Z25CYXdDZno0TkVGRmJXTlh5b0l5?=
 =?utf-8?B?ZExYa0tFSWpYOWlmQ01VM1J3dkpuaGRrbm1oVTFDZklib2NBUTcwRGFicVp2?=
 =?utf-8?B?bys3RHhnbGtsek1odDRxVVZ0SWxIaUZwTlpGYmxYZHB1K3VJUi9lNDRtNjhW?=
 =?utf-8?B?S0x3clhOZXd0V3JDS1JDNnRRUEZqdEd3RTM3ZklneXBLNTdTcTJ3ak1XOUl3?=
 =?utf-8?B?c1B6RStkQU4wMGxuTUh1b2xoZ3dSbjlpbHp2REFZVVl3azBSMDcyTTkvVENS?=
 =?utf-8?B?SEZUTWxhN0hqWWFzcld0bnVnckJTdTVUU1hBaW1vSm5QVHFDbFBmZzVjclQ5?=
 =?utf-8?B?bEFGWFJqNytVYzRKbnNqU0syMDZ5WXhrU1BhMUVKcUJ0VXFhMDhMRVY0WnZm?=
 =?utf-8?B?Q1B1bjJOU0FKWkMwdE1SSGs4SmY4V3JJK1dac0NEemw3TXQxQk03ZGlwVk10?=
 =?utf-8?B?TjQ1SStSOXlwdnAwRlcxeXRkZUVLNjBEcW9DZXBHZU85UTdKeEoyODQ3R1ow?=
 =?utf-8?B?UjQ5NWc0SjBvc0wwa1V3UVYydDNmb0Z4THJPTWpCUTFKR0FXNnkrcnA5dTZN?=
 =?utf-8?B?MFczb2xFRkhGZGRZNTBXcnZqeG5CVndPVE5FQ2I0QWZhbjFLUk1UaStLSnpw?=
 =?utf-8?B?Wi80eFFmWE41Q2hQNXpPMWx2c1JGODlET1hZY3lPbndoMUdmUHI1cUdxdVpH?=
 =?utf-8?B?NkNDTFd4eGRlSGNvZ0FZc2NFb0R2VURiV25GNVZLS3V0Q0htUGh6aStuTER6?=
 =?utf-8?B?aWpPeUVIN0lYb2FjZ29ldXg2b21ycEtsK1Vydzd5V2xLalRES083NkQ3Ukp2?=
 =?utf-8?B?TmtXdWVCMzV0QVFyMjRKSlJuYnQvek5pM1VkT3JmVk5ZejVtUDdBY2VkMSs4?=
 =?utf-8?B?TkFyTDBJWmZnNW5tMTdJeGg5ZURCaE9nZ3RLaVFjQ1paQjBZaGl5bFdRRDJV?=
 =?utf-8?B?NUdoSU1xQlhaR0k3YTZkT3c1VjFoZlZCemYwUVd6OVhkU0VESWFKQmVtRm5F?=
 =?utf-8?B?Q1NXVGR4ek1RRlBzN21XdjB5S3Y3b0tpeHRqZWxRdkF2bjFMMkg4dHhqYjhW?=
 =?utf-8?B?YzdCZXM5aWtOK0JsUzdvZlVhWEpDeUdMQW04bWkzTHNzRkdUajE3Kzh0d2tW?=
 =?utf-8?B?c0tJcGtnYjE0a0E5QzFBVXFsMjVlY1RlTFJjYkFaVi9zUVNoQnFjNS80MG04?=
 =?utf-8?B?d3h4Q3VyVnBIZ2J6Nys4aGlscFZ5S2EzVFExR05CZUhIYXAyNEdYZCtYVE9J?=
 =?utf-8?B?ZHovMmVGeVlEc2pSUy9vQ0w4UzJ3Z29rMFo0YW9PSlpxbjBNNGZlZjBxWUJS?=
 =?utf-8?B?YXhFL1grQUgxdU5rV2NWbm8rOEVIUENHMDQ3K0UySHVlK1paTUJMRzFnY1ZL?=
 =?utf-8?B?TS9KeWF4WXo4MWNnZS8xdVExTzdOVGdya0NFTWkvV0w2WkRNWVVmWGdTZ3JK?=
 =?utf-8?B?QlEyVHV2dlV4TXVuZisxZFpHeU16cHZMU3B2Q3NiYTMwR1NSeGNVMjZWRElV?=
 =?utf-8?B?NW5ZTzVub1M3dEFWVHo3U3JKZGI3MjByMlFjVmRIQzRoNzN4dmhkZ1MwREJV?=
 =?utf-8?B?bHBsenhQR0pla2orT2F3VS8vRFlJMnpTYzdxZ3BNRUw1WXJVT1Q5dz09?=
X-Exchange-RoutingPolicyChecked: Fy1W4iXbOvcl4QSa3eVdMjjRttrkh4cUTKGAaB/krVv3xn286AMcNZ3c0OOVsxp2tE9byj0TBAQ0CIq1LSETA2g2kpbGIBkmH8qI+KFnTS0f6NsiMZugkW5vk2r4MIff6ZWGELN3tbNj3RWIO7C64op6FOnUmJoN3Uw13D6qe0bZ+SC9Xmrg6SAENW05XbG1yv275fgRAB9B3VU52xWtsemBrh7qJBo1M/TCgh9Nmalt5CNAtJ6M0j+HRmrjIjuJO7ZwYVEaCPL8uBXkPdDX7oE2nrUMnLaI5m9/4POrcB4+T588Qx9DmvQA076bX2AGp+MV6cgdaSP8w7yvZRFIeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b9f12e-dc64-4989-2142-08deb7c0dbac
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:13:28.3223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoQP7qF5yZWC4UuvIKnRs8ixTJT6DrfeEJQ0mB6t8G1xnujiEnKFj4IjmoWg0Ii5CWLpABXoiVZM+5luQVExvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9534
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5/21/26 19:46, Duan, Zhenzhong wrote:
>>>>> @@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s,
>>>> VTDHostIOMMUDevice *vtd_hiod,
>>>>>             return false;
>>>>>         }
>>>>>
>>>>> +    /* Only do the check when host device support PASIDs */
>>>>> +    if (caps->max_pasid_log2 && s->pasid > hpasid) {
>>>>
>>>> the second comparison looks strange. hpasid is derived from ecap_reg,
>>>> while ecap_reg is from s->pasid... is there any place that changes
>>>> the pss filed of ecap_reg afterward? I think this check should be
>>>> against caps->max_pasid_log2 as this is the value from hardware. right?
>>>
>>> ecap_reg is from ioctl(IOMMU_GET_HW_INFO), it's not ecap register in
>> vIOMMU.
>>
>> I see. I misunderstood that the hpasid is got from the vIOMMU ecap
>> register.
>>
>>> My understanding is that guest kernel will pick the min(caps->max_pasid_log2, s-
>>> pasid), so checking the two doesn't make sense?
>>
>> I think the caps->max_pasid_log2 should be the same with hpasid since
>> both are from host. Also, I didn't see the logic to pick the
>> min(caps->max_pasid_log2, s->pasid). This is not expected just like the
>> aw bits.
>> We fail if aw-bits > host aw-bits.
> 
> It's a bit different, see below:
> 
> static u32 dev_iommu_get_max_pasids(struct device *dev)
> {
>          u32 max_pasids = 0, bits = 0;
>          int ret;
> 
>          if (dev_is_pci(dev)) {
>                  ret = pci_max_pasids(to_pci_dev(dev));
>                  if (ret > 0)
>                          max_pasids = ret;
>          } else {
>                  ret = device_property_read_u32(dev, "pasid-num-bits", &bits);
>                  if (!ret)
>                          max_pasids = 1UL << bits;
>          }
> 
>          return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
> }
> 
> dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
> 
> caps->max_pasid_log2 = ilog2(idev->dev->iommu->max_pasids);
> 
> caps->max_pasid_log2 is then exposed to guest as pasid bit value in virtual PCI capability.
> Then guest kernel does the same min() calculation.

got it. yes, vtd should check the bits reported via the ecap_reg.


