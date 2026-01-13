Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72444D29DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 03:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfUjC-0007LI-28; Mon, 12 Jan 2026 22:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vfUj9-0007Ix-Bi
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:05:51 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vfUj6-00069U-Nd
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768273549; x=1799809549;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GDBSjhceQMatg20aUCQ2z/Nm5vHIAEX4dDkcuvuLdUE=;
 b=WcVpVQ9r1Lo3YofaTs5MG4EQMHeAgN9Jip5eJm88eRu4Iv/8JWgqi7gl
 K41ad5HPSl6LpApI7564yzw45srrxaRrlo0mcBtTIiJCwK1E6ZLd5GCUY
 2oCqBIldctqjQNanrddLVz4A5lX/LxYyNjQWE9aqtpMvd9X/JcRpQMGbQ
 z0MOgso3DpquuvFixcDJXhmmoxpp33zFNXxc/60rCBnms+oFeTtJPz4JN
 kZcdI25QW8dsny2Fhfj5YoeowNCFdk4nQWt2qLEHoKll2UbHY9lSZPm3v
 msG8rVU+d+NycGSwVvs0zV8n52Vow3jHJmqoCYOYrJ955k8jgT+HaWDXp w==;
X-CSE-ConnectionGUID: Xd9dZTcpR+WTkY7VTrkBgw==
X-CSE-MsgGUID: OmQkXH6MR/msGVpDJYyn0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="87137397"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="87137397"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 19:05:47 -0800
X-CSE-ConnectionGUID: oEbFqp5gTiaaCrfMD1VpuQ==
X-CSE-MsgGUID: NDc6j62SQ9yZW7D6quRP7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="227489793"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 19:05:47 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 19:05:46 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 19:05:46 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 19:05:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkmOC3sB8/m1Ths7dvVIds7TKwX+AeO17xFnL6LYnzZyI1sLDvhTMK3VfF3oj06+1aJqsozD0qBXsD/I8Y26wnWjXKRALfD5LAlEMetxNjqoTJ+qQPlSQ08UEHQO19nUzuwKVL5DO4LQmAqCYWoDcq2eF1lNJG9zAfEkN0ZJOuykrRDyARh5Btxf1bGhR2flh0aap5HxrMHIyKnQEi8JCU/1MgghLndfN2AE0rvrLIRWLpPFoLCJ38K0ScSRbZKSW6Vw7VtNEXpA7eI6RUlZz2RePE1XWjoUXomT07mV5vcIaK6QIabhT9PhM8O2Sa9etT5zQPwOkvnWQPJav6ACLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfrn+5XngmANjhwSFZjCjmIhQ1Ka4grbVVOA8gkx18s=;
 b=CBjZ2YKYpZ7C6KUPx0VWTEi9ZmvYldYL41ybDDwpMkOruwgMCH2lnos1ajptK2NBNsg1ekrA202Y+3TSrvFgP8DsQFZpX/kFxtzLW+IMwKwVGSPDS3V/RJX3k7jP82KASI7rqUxKGpkInEs5K9TyhRYtDqzm/ijJQQZoJih0e3YqQCoqqvT0UQ905PbtgQslXwYseDCyLYcy0D6eEMoms9leegoIOY5usxx7eVxd/hrUg7OQYYsdWTh4OMLNIX2KBnB37bpKtaKt7RDZn6loYCmf2uLmQYCUS880MPg5I2602VXafuooZwUtllCo/Nrxk0UT+FcrvnDOSEedwKIG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 03:05:44 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::2e98:2a3a:ea82:c1bb]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::2e98:2a3a:ea82:c1bb%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 03:05:44 +0000
Message-ID: <4c098753-8db6-4052-a5e5-21d076001776@intel.com>
Date: Tue, 13 Jan 2026 11:12:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/19] intel_iommu: Enable first stage translation for
 passthrough device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <eric.auger@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <peterx@redhat.com>, <ddutile@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
 <a080e728-6754-4897-9531-61b875720b33@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <a080e728-6754-4897-9531-61b875720b33@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: d92473e9-d1ad-4178-1d79-08de5250a496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|7416014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEREUG5SVTRVNHJZZDVkd1JjdUZnQjJlSUJ3cEdyeHNMdkVOUlYrUEp0MGRO?=
 =?utf-8?B?Z0FqRzFhQzh2dFNocy9vR1hnNWU2NHNMcGsxcGduNEREWjY2bDMycHR4NU5Q?=
 =?utf-8?B?WVhPQ1B3ZWNoNjBReHF2aitaNzlJTW95ZGp1dTRwV1JRZG1FQlR4bnlzMkYy?=
 =?utf-8?B?RUlsakxxSGdjL2hQdWpsVHNsSExQWU9JVTBRc0lCRmluSFN6d1VyWjRJZDBl?=
 =?utf-8?B?S2RnUmNCK3N2VnBaY1E2OVJQMWpYV2U5dHRnc2dWa0xIZFBlWUo5TEVuZUlE?=
 =?utf-8?B?U1VjRkdRTGZHZG9qejE5ZGtFRXBhUlNBWWYyRjJVYm9XQThZNGxtcW5sZ2d5?=
 =?utf-8?B?STBtZ0dzUnpjYVg3UWZnZEpiRVYvRWxGcUZmcGNvTUhHMHprYWx1K0xCbnRn?=
 =?utf-8?B?d3NqbldZaHVhUUlwOW1Xd3QwdHBuZll1a1VqeDFTTFZENm9MTmxmQXpHdmlk?=
 =?utf-8?B?SDdscDFYajl1TDZLd1E2bFdlc2pkaWpmK2dYcjZQUW9xYU5BM3RPNzdDd0d2?=
 =?utf-8?B?MXRCeE1MRXRuOFlPdkRONHRZaFI3M2FkdTVCOFJBa0d2OVQxSFVtZ2tWRmdY?=
 =?utf-8?B?R0ZJamdCalQvR2FTTjB1M3hWN0RxMkNMOHg1YjF6M2N3Sm5yMktnVEpRbUUw?=
 =?utf-8?B?WFZRaFJpb29DbGs5NU5FdmIwdS9SaEM5TUs5Z05hck9SUnQ1UWxxN0p6V3lq?=
 =?utf-8?B?Ti91WElmOHBIbGRKWDU2aWc5dWNXV3U1UmM4WE5DcjMxeVN0MWcyRGlkTFFi?=
 =?utf-8?B?MlJEN1VOSS9rdnp2VXpDN3VhR2hzbFpDUTBJN0VNWU9tUzVxOWZNS0Z4ekw5?=
 =?utf-8?B?Yktxc3FJdENRSC85c0tYdVRJODJOTjJlZ2wzMHlSbVkwRFVURWRORjZEZEZX?=
 =?utf-8?B?ZFF3ckdseUJHRyt0OU51Lzlvdm9SU1lLbUZ3SHgxUkpHb0orcWRJay96bHl2?=
 =?utf-8?B?c2pzVnpkc0ZZVk9QNS9wVUdkOHRlTFl1TC9xSU50RFVLVGxyQmNhVGlSUERi?=
 =?utf-8?B?OWdPdVZJRGFrQkxEQjIvSjZEMC9LclRKRmdFNlVzZlZmMzRjRVVCV3pTemZZ?=
 =?utf-8?B?dVZ6MElVZUJqYzZob3JBbW43bHp1NEowcXh5bzUrTnQ4UXRuZWQwQ251WWUy?=
 =?utf-8?B?UitBN1BFbnJMUnBHZExVQXVYYXo2eGYzVTN3RTQ2Z251UFpha3NjWWs5cTd5?=
 =?utf-8?B?YTdXOFpBVVl2QXJhRHFaR082cVNnWGdRb29ha3liY0F2dXpCWit1YzlobDB6?=
 =?utf-8?B?cWU4eDQxQlM1aEdOSjNxRUwwQk5QbjlIVHBpb05KRWR1anFzdUN5bnRjQ0xv?=
 =?utf-8?B?ZUZkMjN6d1A2WmpJUzIrYmxnaXprVzk1OFB4M0VBT3hXaWNoby9sY1RiN2lp?=
 =?utf-8?B?WlNpaGwySzVOU2NJTkJ1a1lLS3EzbWJtL0FndXNKL0FXRzFOQkx0SnI3cndJ?=
 =?utf-8?B?RTNnbVM4LytjdURsK3R1NTJrYWorQWtrUFZLM2lIL2NjTUFFeEZBWkZtY3U0?=
 =?utf-8?B?REJGb29ybXF3NFlnTlRMbTVmQ1FZTGZ0NUNKQytzT1VGZllMNTRoa2R3MDRh?=
 =?utf-8?B?VFJoTkltZGhYVCs5em9rLzRjbHpUL3hzZENhWlJ5WWsrNGgvMTVnaUY1TXh3?=
 =?utf-8?B?QVpJMDlxMUc1ei9GdTN6S0wzNDR1K1JMNXJpYjMxSzcyUW5wNEdJRWt6czVX?=
 =?utf-8?B?cjNyWUorcXJhYTBMWk1LK205cE9GSmkzSk13ZE5hUkJlYmFxTWxxVFFwVEk1?=
 =?utf-8?B?cUsySUpnaEZwa2ZKb1pzV0JCWFllUXcrMWFJVGwwRkJteis1Sklqdi9QSFEv?=
 =?utf-8?B?VG53YTdCemlsL2hrT29XQW5lQUdoeUZlUytpa0RNS2p3ZDZLY3pWa1dGLzFi?=
 =?utf-8?B?UjVQaDRDVmRCNmExeWhwck5ZRDFYK1gwUVkraEJDL0lQbVFUZ3NyRVlGT2pU?=
 =?utf-8?B?Q0lzRFljNnB0Z21YT29PUjF0N2V5NHFKWVg1MnpNZGh4clRrdnVUSXdtOUY3?=
 =?utf-8?B?Z0g5UVhMbEFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBhN0g5dXF1N3BaaE9UK0VDQXlKZW9DeFRrL3g5Q1ZEQ3dXWEZlVDc2VDVs?=
 =?utf-8?B?eG5rODAwajg3ZG4xbzZFeUJSOWlzQjJVSGdHK3NQcHppVDBjbWMzVTBUR3py?=
 =?utf-8?B?WVZOTlRXY1AvYzdKNUh5OTE3MjRWc0dDdDdDeGRJOGE4aWM2eDN3ZmN5eXZF?=
 =?utf-8?B?a2cwSkRBZEdCY01ZV2NxUlNITE84ckord3NSbzBTWFAySjE4akJTbUFWdXl4?=
 =?utf-8?B?QTU2TnRpdkRQUmQxT0JQNmdLQldwM2JXWFdUeWl6SEc1TVFqSDQwa2VJakZv?=
 =?utf-8?B?M3JSUjEzdEpLS1RUeXduUDVWNHNRTlF6TDBjZU8wcXZzQ0xTZS8yTXJtOXVY?=
 =?utf-8?B?VGRncmI2dDhWcEtPd0lsNFVhaTNHR3VmdXVrVWZ6c0VQeU1iZHZUNVRsdE1t?=
 =?utf-8?B?Wjg5R1RqVHVjN3dhZTNmdEZ1N3YwL3RiZThkR3l0aWU5bTJFVXgzdU5xRjFK?=
 =?utf-8?B?OXpUZDk1SlFWd0o2dWtZVHNmV3duaU1pTjcwZ0EvYXVFRlkyYmJvS2I3WFJn?=
 =?utf-8?B?c3kxMUVRRjdybDNXdHNOSnJtZEdNd0ZVSkNDbHlRMEQ4YjcwT3JvY0pwaDU3?=
 =?utf-8?B?aUFHRGNwR0tJL0h5N1ZhVFVQWExuOU54KzNLUENhTEs5ZytZYnR4bzRQeEo1?=
 =?utf-8?B?RXJEUEZ6MzJqaTArVjFlZWJuRjI5U2tNLzRNWTBrQ2dGS2RCVUdEbk5NYVg3?=
 =?utf-8?B?aFB1RlVtdmxXWFJ4MzB5dUdPcjIycE1SSnNoSGFCS1ByYVVsMDZOVEsrY1ds?=
 =?utf-8?B?ZEk3Z1o2SlZnck5KWVcxdktZR3ZJL09UUUVVWThiL3p1QnJRdDk0YklkUVJI?=
 =?utf-8?B?R2s5WHNYQ3U0dld6Z2tFclNmL3JOQ20zL0tZY0VKaWtGMU9XRlJYajFRSFd6?=
 =?utf-8?B?NFlHcWJTQWpLZnptK2hMSG0zZy95UGlCSkU1ZGJxcXlwZUx6bG9vWkVtVDdl?=
 =?utf-8?B?aEtvVHNyL2ZGYVRIRFlkeXFmeU5Ealo3YWI2MmZlRHNsVWIvdW9PSXZkUGNx?=
 =?utf-8?B?OGs2K1Z4dG1nRHV3T0tGQmN4L3hBSDlTZkd6bkNkWWY5d3ROd243Y0RGR284?=
 =?utf-8?B?ajdGS01JeHk3bWZGVWk5TXNRa1ZvL0RpL0ZJclRndGdsc2xLTml5Y3RlQ3lR?=
 =?utf-8?B?b0dhMCtZOEVqOGpQUXVzWm5wTEdCNEtwVzR1ck1xNW1vdXVGM3pQUExWdU96?=
 =?utf-8?B?V2VmTHFHakhjc0trNFdqNWpIQmhhd3VGU1pPM2huZmVHM2RGaW5SbUN1enNl?=
 =?utf-8?B?bWdPVUVZZVNJUDVWVFF4ODRGWXZvc1p0SDV1clE0ZFZxNHZoZVZCRkpzY0lm?=
 =?utf-8?B?YXNsL3RwVFF4R09Ub3hhZ215Rzd3YllBUFIzOUc5ZTIzRmFPdEdveSt2alRD?=
 =?utf-8?B?UzErNzR6NlhNN2pTVnFoMGkvc2RuazByaDUvWlBJNldhUXlEbEtoSEJTNE5P?=
 =?utf-8?B?ZlpZeDFCZXlzcXJ0NzJCQ1JDRHptZEhEYkJoeE1RMzkrU2JzbkxwUUFXRFZ1?=
 =?utf-8?B?ZTBuWHhQTW5xbmJqVHdOcWJMZC9CNGtHODJGSDZ4UWx3bTkrT2tGRU1MSzRz?=
 =?utf-8?B?M1M4elRHKzdCbFNMa1dzZklOc284SExpSnMwVTEyNW5BN0VEMjNXMEdOaE1O?=
 =?utf-8?B?Nnp4L1ltYk9PVkQvN0RkTDd4NWliZis1SDFXYnlCMVYrNWc5Z0FZbGl0YUNP?=
 =?utf-8?B?L3lkaEUrYjduLzJCUVFwY3FVbVUxRVZkUHdwYkVmOTZOYnkwOFNqQWI3UGx3?=
 =?utf-8?B?VUVCYVlobGdFOXFUbjJ3NldiNUtKU0VrTUJnWS9EbjFyNTF0ZzA1c05tT3Yx?=
 =?utf-8?B?S2dYZDEvWFJFaFdBaTJUWi8rbFBxYWtWaEo5YVhReTFCdzBnWVNUd1lqQXZI?=
 =?utf-8?B?WTgvRmZWVnlMeGxqTTZHR01uekszOVhHNmdsV21SNVkrTkxmMC81MFlEOE1y?=
 =?utf-8?B?dXk2V2plMzN5aGRBVklBNm9kZnRYaWorMWhDdWRJM095UnNkOXB0azZnZElX?=
 =?utf-8?B?Q3dkUUZVRGVoT1F3NDNOMGJpa3JscmZoaDFxRlRxc1VtWnZwajg4U1Z4b3pP?=
 =?utf-8?B?TFBOS0xic3FMdUJ5T0c1MndtVlZac2FwRk5DT2UxR0lUM2lCRHdSdDJlQStq?=
 =?utf-8?B?WCtHSDFRUkN2Y0lGRFdXR3VuaWMzMm5Wb1RzWFRJNzhEajhsbFNtbk1IcjBl?=
 =?utf-8?B?dERjRXQxTDR1MGZHdytXbVNSREdOUm5pcVY3MjhpRkRiMlJsenBDSGl6TTR3?=
 =?utf-8?B?cUIyVGdYcHRlM05wYVRIOURIVWI3L3lCTUR0czlzS2xJMlRoTEtRSFloUm05?=
 =?utf-8?B?QkljUGhPbXdzNi91NnNScitFMGhPbkNubVVabTNGeFNyUlFsb1ZyZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d92473e9-d1ad-4178-1d79-08de5250a496
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:05:44.6719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+DF6nZjzOBa4vWWHKSbxOfO954xfODKm5zufSolc1/mFExY6ECsiIs6jNesNWl67K7K1/xs5owHXusC2hqAcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/1/9 22:34, Cédric Le Goater wrote:
> Michael,
> 
> Since there are a couple of VFIO series depending on this one, do you mind
> if it goes through the VFIO queue ?
> 
> Thanks,
> 
> C.
> 

Hi Cédric,

I have two nits on the series.
1) a commit message typo to patch 09, already sent email
2) I noticed there are several new files added, while the copyright 
starts from 2025. will be nice to be 2026. :)

Otherwise, looks good to me, so feel free to add:

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> 
> 
> On 1/6/26 07:12, Zhenzhong Duan wrote:
>> Hi,
>>
>> Based on Cédric's suggestions[1], The nesting series v8 is split to
>> "base nesting series" + "ERRATA_772415_SPR17 quirk series", this is the
>> base nesting series.
>>
>> For passthrough device with intel_iommu.x-flts=on, we don't do 
>> shadowing of
>> guest page table but pass first stage page table to host side to 
>> construct a
>> nested HWPT. There was some effort to enable this feature in old days, 
>> see
>> [2] for details.
>>
>> The key design is to utilize the dual-stage IOMMU translation (also 
>> known as
>> IOMMU nested translation) capability in host IOMMU. As the below 
>> diagram shows,
>> guest I/O page table pointer in GPA (guest physical address) is passed 
>> to host
>> and be used to perform the first stage address translation. Along with 
>> it,
>> modifications to present mappings in the guest I/O page table should 
>> be followed
>> with an IOTLB invalidation.
>>
>>          .-------------.  .---------------------------.
>>          |   vIOMMU    |  | Guest I/O page table      |
>>          |             |  '---------------------------'
>>          .----------------/
>>          | PASID Entry |--- PASID cache flush --+
>>          '-------------'                        |
>>          |             |                        V
>>          |             |           I/O page table pointer in GPA
>>          '-------------'
>>      Guest
>>      ------| Shadow |---------------------------|--------
>>            v        v                           v
>>      Host
>>          .-------------.  .-----------------------------.
>>          |   pIOMMU    |  | First stage for GIOVA->GPA  |
>>          |             |  '-----------------------------'
>>          .----------------/  |
>>          | PASID Entry |     V (Nested xlate)
>>          '----------------\.--------------------------------------------.
>>          |             |   | Second stage for GPA->HPA, unmanaged domain|
>>          |             |   '--------------------------------------------'
>>          '-------------'
>> <Intel VT-d Nested translation>
>>
>> This series reuse VFIO device's default HWPT as nesting parent instead of
>> creating new one. This way avoids duplicate code of a new memory 
>> listener,
>> all existing feature from VFIO listener can be shared, e.g., ram discard,
>> dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
>> under a PCI bridge with emulated device, because emulated device wants
>> IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
>> reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off" on platform
>> with ERRATA_772415_SPR17, because VFIO device's default HWPT is created
>> with NEST_PARENT flag, kernel inhibit RO mappings when switch to shadow
>> mode.
>>
>> This series is also a prerequisite work for vSVA, i.e. Sharing guest
>> application address space with passthrough devices.
>>
>> There are some interactions between VFIO and vIOMMU
>> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>>    subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>>    instance to vIOMMU at vfio device realize stage.
>> * vIOMMU registers PCIIOMMUOps get_viommu_flags to PCI subsystem.
>>    VFIO calls it to get vIOMMU exposed flags.
>> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>>    to bind/unbind device to IOMMUFD backed domains, either nested
>>    domain or not.
>>
>> See below diagram:
>>
>>          VFIO Device                                 Intel IOMMU
>>      .-----------------.                         .-------------------.
>>      |                 |                         |                   |
>>      |       .---------|PCIIOMMUOps              |.-------------.    |
>>      |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU  |    |
>>      |       | Device  |------------------------>|| Device list |    |
>>      |       .---------|(get_viommu_flags)       |.-------------.    |
>>      |                 |                         |       |           |
>>      |                 |                         |       V           |
>>      |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>>      |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
>>      |       | link    |<------------------------|  |   Device    |  |
>>      |       .---------|            (detach_hwpt)|  .-------------.  |
>>      |                 |                         |       |           |
>>      |                 |                         |       ...         |
>>      .-----------------.                         .-------------------.
>>
>> Below is an example to enable first stage translation for passthrough 
>> device:
>>
>>      -M q35,...
>>      -device intel-iommu,x-scalable-mode=on,x-flts=on...
>>      -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...
>>
>> Test done:
>> - VFIO devices hotplug/unplug
>> - different VFIO devices linked to different iommufds
>> - vhost net device ping test
>> - migration with QAT passthrough
>>
>> PATCH01-08: Some preparing work
>> PATCH09-10: Compatibility check between vIOMMU and Host IOMMU
>> PATCH11-16: Implement first stage translation for passthrough device
>> PATCH17:    Add migration support and optimization
>> PATCH18:    Enable first stage translation for passthrough device
>> PATCH19:    Add doc
>>
>> Qemu code can be found at [3], it's based on master 159107e.
>>
>> Fault event injection to guest isn't supported in this series, we 
>> presume guest
>> kernel always construct correct first stage page table for passthrough 
>> device.
>> For emulated devices, the emulation code already provided first stage 
>> fault
>> injection.
>>
>> TODO:
>> - Fault event injection to guest when HW first stage page table faults
>>
>> [1] 
>> https://lore.kernel.org/qemu-devel/bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com/
>> [2] 
>> https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
>> [3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v10
>>
>> Thanks
>> Zhenzhong
>>
>> Changelog:
>> v10:
>> - All headers under include/hw/ have been moved to include/hw/core/, do
>>    the same for iommu.h (Cédric)
>>
>> v9:
>> - split v8 to base nesting series + ERRATA_772415_SPR17 series (Cédric)
>> - s/fs_hwpt/fs_hwpt_id, 
>> s/vtd_bind_guest_pasid/vtd_propagate_guest_pasid (Eric)
>> - polish error msg when CONFIG_VTD_ACCEL isn't defined (Eric)
>> - refactor hwpt_id assignment in vtd_device_attach_iommufd() (Eric)
>>
>> v8:
>> - add hw/i386/intel_iommu_accel.[hc] to hold accel code (Eric)
>> - return bool for all vtd accel related functions (Cédric, Eric)
>> - introduce a new PCIIOMMUOps::get_host_iommu_quirks() (Eric, Nicolin)
>> - minor polishment to comment and code (Cédric, Eric)
>> - drop some R-b as they have changes needing review again
>>
>> v7:
>> - s/host_iommu_extract_vendor_caps/host_iommu_extract_quirks (Nicolin)
>> - s/RID_PASID/PASID_0 (Eric)
>> - drop rid2pasid check in vtd_do_iommu_translate (Eric)
>> - refine DID check in vtd_pasid_cache_sync_locked (Liuyi)
>> - refine commit log (Nicolin, Eric, Liuyi)
>> - Fix doc build (Cédric)
>> - add migration support
>>
>> v6:
>> - delete RPS capability related supporting code (Eric, Yi)
>> - use terminology 'first/second stage' to replace 'first/second level" 
>> (Eric, Yi)
>> - use get_viommu_flags() instead of get_viommu_caps() (Nicolin)
>> - drop non-RID_PASID related code and simplify pasid invalidation 
>> handling (Eric, Yi)
>> - drop the patch that handle pasid replay when context invalidation 
>> (Eric)
>> - move vendor specific cap check from VFIO core to backend/iommufd.c 
>> (Nicolin)
>>
>> v5:
>> - refine commit log of patch2 (Cédric, Nicolin)
>> - introduce helper vfio_pci_from_vfio_device() (Cédric)
>> - introduce helper vfio_device_viommu_get_nested() (Cédric)
>> - pass 'bool bypass_ro' argument to vfio_listener_valid_section() 
>> instead of 'VFIOContainerBase *' (Cédric)
>> - fix a potential build error reported by Jim Shu
>>
>> v4:
>> - s/VIOMMU_CAP_STAGE1/VIOMMU_CAP_HW_NESTED (Eric, Nicolin, Donald, 
>> Shameer)
>> - clarify get_viommu_cap() return pure emulated caps and explain 
>> reason in commit log (Eric)
>> - retrieve the ce only if vtd_as->pasid in 
>> vtd_as_to_iommu_pasid_locked (Eric)
>> - refine doc comment and commit log in patch10-11 (Eric)
>>
>> v3:
>> - define enum type for VIOMMU_CAP_* (Eric)
>> - drop inline flag in the patch which uses the helper (Eric)
>> - use extract64 in new introduced MACRO (Eric)
>> - polish comments and fix typo error (Eric)
>> - split workaround patch for ERRATA_772415_SPR17 to two patches (Eric)
>> - optimize bind/unbind error path processing
>>
>> v2:
>> - introduce get_viommu_cap() to get STAGE1 flag to create nesting 
>> parent HWPT (Liuyi)
>> - reuse VFIO's default HWPT as parent HWPT of nested translation 
>> (Nicolin, Liuyi)
>> - abandon support of VFIO device under pcie-to-pci bridge to simplify 
>> design (Liuyi)
>> - bypass RO mapping in VFIO's default HWPT if ERRATA_772415_SPR17 (Liuyi)
>> - drop vtd_dev_to_context_entry optimization (Liuyi)
>>
>> v1:
>> - simplify vendor specific checking in vtd_check_hiod (Cédric, Nicolin)
>> - rebase to master
>>
>>
>> Yi Liu (3):
>>    intel_iommu_accel: Propagate PASID-based iotlb invalidation to host
>>    intel_iommu: Replay all pasid bindings when either SRTP or TE bit is
>>      changed
>>    intel_iommu: Replay pasid bindings after context cache invalidation
>>
>> Zhenzhong Duan (16):
>>    intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>>      vtd_ce_get_pasid_entry
>>    intel_iommu: Delete RPS capability related supporting code
>>    intel_iommu: Update terminology to match VTD spec
>>    hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
>>    hw/pci: Introduce pci_device_get_viommu_flags()
>>    intel_iommu: Implement get_viommu_flags() callback
>>    intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>>    vfio/iommufd: Force creating nesting parent HWPT
>>    intel_iommu_accel: Check for compatibility with IOMMUFD backed device
>>      when x-flts=on
>>    intel_iommu_accel: Fail passthrough device under PCI bridge if
>>      x-flts=on
>>    intel_iommu_accel: Stick to system MR for IOMMUFD backed host device
>>      when x-flts=on
>>    intel_iommu: Add some macros and inline functions
>>    intel_iommu_accel: Bind/unbind guest page table to host
>>    intel_iommu: Add migration support with x-flts=on
>>    intel_iommu: Enable host device when x-flts=on in scalable mode
>>    docs/devel: Add IOMMUFD nesting documentation
>>
>>   MAINTAINERS                    |   2 +
>>   docs/devel/vfio-iommufd.rst    |  17 ++
>>   hw/i386/intel_iommu_accel.h    |  51 ++++
>>   hw/i386/intel_iommu_internal.h | 155 +++++++---
>>   include/hw/core/iommu.h        |  25 ++
>>   include/hw/i386/intel_iommu.h  |   6 +-
>>   include/hw/pci/pci.h           |  24 ++
>>   include/hw/vfio/vfio-device.h  |   2 +
>>   hw/i386/intel_iommu.c          | 528 +++++++++++++++++++--------------
>>   hw/i386/intel_iommu_accel.c    | 251 ++++++++++++++++
>>   hw/pci/pci.c                   |  23 +-
>>   hw/vfio/device.c               |  12 +
>>   hw/vfio/iommufd.c              |   9 +
>>   tests/qtest/intel-iommu-test.c |   4 +-
>>   hw/i386/Kconfig                |   5 +
>>   hw/i386/meson.build            |   1 +
>>   hw/i386/trace-events           |   4 +
>>   17 files changed, 833 insertions(+), 286 deletions(-)
>>   create mode 100644 hw/i386/intel_iommu_accel.h
>>   create mode 100644 include/hw/core/iommu.h
>>   create mode 100644 hw/i386/intel_iommu_accel.c
>>
> 

