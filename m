Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BB2D111A3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 03:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7nda-00057e-70; Sun, 03 Nov 2024 22:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7ndY-00057A-JP
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:20:16 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7ndX-0004Lr-19
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730690415; x=1762226415;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QzniUOKiphh33CFn39vA8hQD26Hz+g/XwwdwUF7FOcQ=;
 b=bpJNpNCKnqIhxGSiTUsJGxbowVqYf2NQD4VxUUqac9mwhhhmJ1hDHnFL
 /HYRDTQIieZz1LbDh+6jY/5NcDQI0fjjT/hEu/GPyYI7/ap94sUyA9Y67
 Eo5EjLKnTztXjHo58rOWYGmnFYn4DzwEMBSnay1dUA0u9xOntTzz+VNvx
 AwdnX13oZLnJ2SQuLKCNxXdFBVIlcKX4MU5XxLXInKX5JXtZbykrr3N9e
 dreRPpSHZSZRsVusxW439QuZnGSS47PwD8PXOSurdHk2xSQu6pHxo4pSF
 JHdpy7el2DrdNeLtPt8nboUKUn0aT4nsg0JG/b9CzXHWnT5KF3tX+arVk Q==;
X-CSE-ConnectionGUID: PlOVy8b4QDCzaLRhOrqYhw==
X-CSE-MsgGUID: jBs5cnk4RdiPHS89fW4HBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40921874"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="40921874"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 19:20:12 -0800
X-CSE-ConnectionGUID: MtKhEyTFR3+qCw5PlVNurg==
X-CSE-MsgGUID: 9Tb2WOIsQZC2UtbeGTmvJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83451676"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 19:20:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 19:20:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 19:20:11 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 19:20:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL7MBmJ5XfrnR665TTrMo4IILuALNvlwRuZojJf02Blye0rS2y4wrt1KUygLHtBwcGryjDef+tvZYm9h0zRLYzSsbwwTnowe+yv3K2ET0o+Pd0YcD2aRQxPc00PyuOQlLz5O5H9KhAzFhZpFNVeBUS9W460XBiLuVtYXAPo1mhhhcO4BzEhIX1v1QmUpgS8w/PR25UlkoB9QPUKxiL9UetvnezA09ER3TxJUc00kyjAaHcyI/hBNKtF9GCwSEiYLRAm6b4gNiFAW7JwBHOBVobEF7BLCFYUzHbXPBYAvyfEXcz6UCCSAjp5VM/CTweEdWsPARH9WTF2yPGBbdDueGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq8q8zB34jZzRtS+geqKrf/d6Cg0EPgzerwt0duRGOI=;
 b=apLXvJGwUXC/HKc0aebC3duwg1oheEOnJxgFw6K/EIKoCVY+inz1vhnPmx9h0NUU5qNxT/3dTi7K6V/5wKnEKLI2BaNLuv88agn+Vdmr9WezLH4lG9fwqTJy3JwGG4Nc6Ti42cv+mAVqLsKPxlt6ObuWKkSykT60lyKt1LpdGFRRphywnNxPI0WMrI8SG1kziN5E15hyzXmWYmCQhlcbsXteLffO/RAEywdYVGKDnVump0mRJQgW5rdAiR6YtYPhOQ5sbkewDy83e116+gBX7k6R+jYgVHOcBaogJ9tgC24WFNpLNxbN7dOLLZkjgNr5XFYc3+RFUC8G8MFsC8P3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Mon, 4 Nov
 2024 03:20:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 03:20:03 +0000
Message-ID: <bbcf1216-19b9-4d05-ba57-e451f3566f4f@intel.com>
Date: Mon, 4 Nov 2024 11:24:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Jason Wang
 <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-16-zhenzhong.duan@intel.com>
 <CACGkMEutsgWhp0mrCG6A3QA1NXnMj8RFDHMKPq3eBv3WxaQ=Vg@mail.gmail.com>
 <SJ0PR11MB6744EE9C94E4BD7FC7275455926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEvM1XHr-9Fyts5SZdwkhVh4rf=J-MjD5ZBPUcKqJ1s0dA@mail.gmail.com>
 <SJ0PR11MB6744F7B57D686541929B02C492752@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744F7B57D686541929B02C492752@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eb31f3-fb40-4b88-1490-08dcfc7f9264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjVNQU9vUitocnNDL0ZEd0tKS29TTVI4dERqT0RsLzlOc0lPYUl5Ykl6cW9k?=
 =?utf-8?B?ampqQ1NxSVgzK0xqNUFhczRZRXdRaEYvcW9KUytLRDhKc3ltdzEyWVFhU3dF?=
 =?utf-8?B?dmYzY3U4Um1wQldoRnhHL0p5bXJ5MllrbHVLUVAvRzlrVmVWVk9kRTU1RllS?=
 =?utf-8?B?WFlrc2tBZk41b3A2aURNY3plTHJYei9aWFU2cXRzY3R6TU5Ma1NVOHFQZVZP?=
 =?utf-8?B?blNjQks2RGNGYm9NRDYxWE1oYkZmalRtUlV4YTViODVwQkpacHVDaG1VZXY3?=
 =?utf-8?B?cEw1aktKZC9Ydk1BbDhvWDdib3RtWTRXL29vcEs4RHdnNHl6bE5HZjVYSmdu?=
 =?utf-8?B?Wk44bEhVblBOVzRxT3pNcEg2c2QvbE1ZTlZMSU50dThKUTM2SUNJRUlaVFFY?=
 =?utf-8?B?OEpHYzZSR21qYThHK2lUU25NRm1WWVFWOHJJOXduUG5EYm1saytxRCttcnN0?=
 =?utf-8?B?RXgyQmNLdCtSaXJDdmdZMFNDeFREY05uTlFSOG43cEpIdVJCNEsvUGs3cXdM?=
 =?utf-8?B?WXBYa1FYVkhsaWNkUithcEZ0SjlFRDFNQnNjdUYxSXl6OVhPdjJoWjRiTVNm?=
 =?utf-8?B?TXlaYVBMVEZOOFRybWVucVpPaVNxNlZnY21TSDN6V1dOVloxVnZwNlVndXRM?=
 =?utf-8?B?cjN3eEsyMDNHbVU0YURtcGxsN0xYUmFxcHBwM2tuUG9sMzRIeXJjd1RQT3hq?=
 =?utf-8?B?Q250WisvWFV3QkcydEIzN25ScXVDanZhRkI5cHV2SldpREhFL05Cc0gwQkk4?=
 =?utf-8?B?aWowV0NsYUNMUmhUY1FCVmJaNUlsVVpSYmxmbHJJbTBueUdEUys1SzRDd1ZB?=
 =?utf-8?B?bFBwSWJFY1VaL0ZKSCtCOHEzK0RWT3FwMk5oY0NtM01oZ0JHOXEyYUN2aWtX?=
 =?utf-8?B?ZTYwckhtaXR1a05hVERYeUZKQjZXVktrdHRtdjVnZjU2NGM4dVJTUFhxRVgz?=
 =?utf-8?B?TVNKcVJaNUFXR0tmcExLNGVFVU9MR3RZMHZnbWExWkZweHBQSGsxbXdmSHlz?=
 =?utf-8?B?Rkl3cGFNNVk4UW12K0t0enROSnJHeVR5emNlRTVQSlVuZXRkNmlGcUJReStT?=
 =?utf-8?B?Q0Z5UXJMMjZTTnhicVJHL3FsbXN3dUxQSGYwcTE4UlZXSml2azFYNG5LM1gr?=
 =?utf-8?B?OUdYRWtLM1BNZjhTYXZmWFVxS2Y2cmc3bTdReU9nelI0b05aQ2VGUkxoY3Jt?=
 =?utf-8?B?eVJaRVN3N3ZjdzZOT1VyQm9ERXorOGEzU3VKam1XRSswU1hqQWlxWVVCaEc2?=
 =?utf-8?B?TkM4RzNJbEZzZ2NsZnZ0T0lWREs1U3JzSVBIVzJCUDNXSUJLaWMxNU5vTzBz?=
 =?utf-8?B?ejViWUxKWkt4cTQ4S3NKTDk3aXlQYVJkQyt1bGRITCtJbUNSazJscFF2SlBM?=
 =?utf-8?B?bE40WWZUUlp1SHVDKytYODdtNFZRUXpRaXRrdlBDMCttcERUTmsrcTRYVllG?=
 =?utf-8?B?dTRoUllwbngrQkllNUxTRG1nR25SMmdncG5HTnB3MGdlc2dhb05hMzdoQWMr?=
 =?utf-8?B?QVcxdFRhb1RwUVZNWGhYcTVvNWNFNDlNVGVxbDdpY3JYL1J1OG11VklIZEtQ?=
 =?utf-8?B?UFczL3pXcDRabCtDZFNjcEhaampjSlJMZG1qRmtMNUQrRUl1ZU9pejdZdEQy?=
 =?utf-8?B?Zmo2TDErZ2h0UEYyb1IzQTk4Z08yN3FkYkw3ck94MGNVNHY4Vk1rR3pnZHkx?=
 =?utf-8?Q?aOzrAAu5/SqtP8JCO2mS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znl3T2hqL24zZDZBdldxaExZMVlsQ0c0SDRhQzhGUUhDZ2FzS3ZvOCtXWE5h?=
 =?utf-8?B?VktwaGwrSHlQb2NTVWFQZmN0RkV4clhvVFNjTVFIdmhaMEd1c3FmL0dlTit1?=
 =?utf-8?B?Vll1S09OKzEvekpDWis4SUV1eTdQdHdGdkh5SnN4WCtLT0loSFJNUmEwT0I2?=
 =?utf-8?B?dWhueFJOa0NpcW5PSnNkMTVUTHZSMHpTM3k2RkdjOE1yMjFGQzVia2tQQ1Ar?=
 =?utf-8?B?dzJYV1dSU2FyUHdaN25aRkZhb1ZkSnlYbzBIdTlwK0MxRUVRbHlrS0E4TDFB?=
 =?utf-8?B?UmdZeU5ydVF1d3haUFB6VnNtSnRGc0lKajJNdjJwL3JjSG85RUNFL3Z6eE1u?=
 =?utf-8?B?MEgwWHczYU4zRm9EazBVaUk1elpxYnloNk1DRFMwNG16bWV0Z3BPTndhVTMy?=
 =?utf-8?B?RG9hYkZJWFZqSmFhVmVFUWg3cTNmS0hhaHl4aXRjSXFZeE9EZjdyZHNaM2ZP?=
 =?utf-8?B?aUw0Mlo0WnVVeWFkOUJIMGwzL2hmS3NpZnRvcDZQYWdxbTZrUktLSzNoeWkx?=
 =?utf-8?B?c2xFVG4wRURDTWd4cVdBVVVtRFVCOEVJMGduYTd1RXVka1BYeXp4Z0pBaFZ6?=
 =?utf-8?B?NHBtOWo0a2Q5Ym1GOTlHQXRBeFhrbHA0TUdSamRLUGgrVy9IUkNQZnVhaFUx?=
 =?utf-8?B?bWJJRStzdXhGck1iazhtd1hHYlB3Mk95UFQ5Tk1jalA3cmpET1U5KytpRGRl?=
 =?utf-8?B?TXViUEZKWDVIUXhZOWtXb3BFNzNUNjY5blJueEd4b3ZBS0tROWQ5UllaaFd5?=
 =?utf-8?B?YWpKeFh3c3dVeVFmTjg1elZpWVNmWVRkT1dWQ3doc092VHVjUnlNV09TRmpm?=
 =?utf-8?B?anh3eTdRNytyK2N0YVBheE9ZeXJ3bnZVMFlYQzh6NjNGZmllUGJSclpmWkYw?=
 =?utf-8?B?N3dmWHhVOERzVFZoZnJKUWdXU0ZQVDNHalJJU1NaeXp2OGZZbGNDaGxaS3Fs?=
 =?utf-8?B?MExvSVNCMndtVXZJYjh5RW50Mmx6NGhPOUxKenBsU21DTnFRRzdBQTdZaWNZ?=
 =?utf-8?B?cmpGcFJzZnJ4RTN0OENnNWt5MnpxNWhjWXF2bXc0NGZsc05QWjhMMDNPa0tI?=
 =?utf-8?B?RmsvOHAyd0VmTHRkNGFkeW52d1dlQThGdWpGK3lEZjIyNGhBSW84N05JYlN3?=
 =?utf-8?B?RmlqTU9VMCtTY2QycHB1NEI2LzlOYVA1bmVpS2pHUFU0REQwNHl5UmdSNXgx?=
 =?utf-8?B?eWM5SVI1dHhWNEV5Uk40WWtHbTVIRHd2Yi9YWUVRSXBHdXdoSGREckUzZ3A2?=
 =?utf-8?B?MlFEdXZZYkhGWTYrRkV3QUc4OUIzOWpMRFc0VlFLU3dmdERYQ2hucTlGQ25L?=
 =?utf-8?B?c0Y2WENsQ3FDeTk3QTd2bzBRdjBkQW9abG0wR3hZL25qK3pnNiswRlp0OHda?=
 =?utf-8?B?cVI5eE9XdGd6UzRZL0dydDZSVGVqRHVNTDRhVTRGWk9GZFVJWFJMMFVHaUJa?=
 =?utf-8?B?U043c2pRWW5aT3krOGVzUmwwdEVBU0RqTXNMS3RyeGE4Sk1IUVJLazJxdnlN?=
 =?utf-8?B?M1JyM2xGRnZCQzdXRFcwaU94bUFHSG84dTdqelV2azdDRzNXZldrNGx1eDFM?=
 =?utf-8?B?Y29udnVwVlZKdmFBTnIvN3NkNHFaTEUzanpEb3J2aVV0S2ZrZ1RnWXpQN0R2?=
 =?utf-8?B?dXdoSEhyMysrcVl2eWdzV1ljeWU0R0dzRTRXSGF1NHpSdmd3ZnpiWnVPdDRX?=
 =?utf-8?B?NGdzUGZpbkhpdVp3bEFWRHc4K1V6SCtmejRrclVkWE9meXhvVEJSUlBBTGlF?=
 =?utf-8?B?MnNxVXI3T2VWTlVDclZkeXdEcFBiQy9tTGNnVVc3Z05ZUFh5aWRSUllrNm5m?=
 =?utf-8?B?QWNYalJjNVN6NFZlQkhpWW9DMkVwVXprNHl1NGp3d1JWbWNkcHRmMGhkSUVr?=
 =?utf-8?B?VUcySnlBdHo5TjJ2cU9oWlp4a2FTUlk3M0w3cnN0My8wWXRvZDg2dXpSQ1Rs?=
 =?utf-8?B?RWVNSlJIajBENTZjMFVacTFaSXo1YllDbW45WmozWFllcG5WcStFTk9ITnc1?=
 =?utf-8?B?TXQ5ek5ibUQxajRocWNKaC9CMXZRazJpTlZqdm1aemxMWEczV2JBNm5FeUU3?=
 =?utf-8?B?bDJ3RnBkTzgyQmhGYm45S2ZTZ0cvSjRTVEUxZkhMZG1iZE8rbk0xcnRMencw?=
 =?utf-8?Q?cALGgbKiLy8HYBZTr1Sk/J9Dv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eb31f3-fb40-4b88-1490-08dcfc7f9264
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 03:20:02.9883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRViVY+xQ/Wj7LUbZHVkBcy1sKU80axnrNgV59SOEKjpDd1xxm7aJv42dSJdknMuvOzR+OEr3fGwq++h4JlkrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2024/9/29 10:44, Duan, Zhenzhong wrote
>>
>> A question here:
>>
>> Are there any other major features that are still lacking for scalable
>> mode? If not, maybe we can get rid of the "x" prefix?
> 
> We don't support stage-1 and stage-2 coexist emulation and nested translation emulation through stage-1 and stage-2 yet.
> 
> Currently we only support either stage-1 or stage-2 in scalable mode, one reason is supporting stage1 is enough for current usage,
> the other reason is to simplify the nesting series https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2 for review.

PRI is also a missing part. :)


-- 
Regards,
Yi Liu

