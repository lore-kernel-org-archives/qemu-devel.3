Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE7BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN8S-0001w9-8x; Sat, 30 Aug 2025 11:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uruBp-00045c-9z
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:10:29 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uruBm-0002MK-8v
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756455026; x=1787991026;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aXnA0gMZ7uTSNl5a+bwcmXXocFQXDMJwYFoTWpjXTVQ=;
 b=AHZZMnr2lZcqTXZLIekPeszzg/6OuQ1z4Xgh+cwUg/JpLRkAd/qUi/RH
 Mrghh38BeGYFBdpfZK4Ty+ZY5UHsiWtsDzifY/4K3VasEtGe84m9h2Tjf
 oJKhvhrA0pSckLaVR3Mwa8ZhpmPgkzD9Qa2bbS11fpzERIPUln6Rkghyu
 7KsGY1Ne186iKPumXbbNQseMmlYimXjSxqGomfzrdpogAulq1ifn4Cv1g
 djOioLLP9h2al9/MA8+LK8NFoWeReX0Rvt05YCbQaxkviR1RDbsED0ArV
 lWTWB6s5LBa/WqUDFpaAZm+56Rjud/WcI8Wx1EemBrXUP2IZMC05osGje w==;
X-CSE-ConnectionGUID: vsvyIzxRRSqdcfQlan743Q==
X-CSE-MsgGUID: oi6WJ7ZWQ26qZhjq9ppoig==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62555007"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="62555007"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 01:10:20 -0700
X-CSE-ConnectionGUID: dWsgGnDeQ7mjfjdUoT4PTw==
X-CSE-MsgGUID: NxhuZLv7R/qGL4Vq9Jyr/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="169581742"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 01:10:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 01:10:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 01:10:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.62)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 01:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJCNArat600WN5rjh1lXBBYRhTzpHC5I7n7XGhOTQ7StCQ7+Wwl+1KFQ7tGYxdDWu5JvIozyqNlKE1LJ/e71ClCYBvVxKnVBFPwwdMtgHTyau84I2xU2t10hbCjzCsgyYj4NDtrCg3cDnbh+7ReXjOW6gCXvBSw/buL0ErjHnwnYIuPTPyfPSO94/DZm9uFWPUB9ZWvaVXEPLdXm4+/m6bbN6YQrqAXid+bLOSckaS6bMfKBFL5w6cQ+tSb2qqmY0bueE8ldU2Buxu1DerID/yRyorOoNQWAnOo33DnWbdtR952Tg0RGS8kuNvpTkzgUy5scQ+1BdlGfCutISbOScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDL3PZ9xwUv0RMJ55J6mG7eJC9zSd54McnnDDjHyzq8=;
 b=F0fFCsiVSnZbPATaL40b9YTr/9ki5XlWjDq0JCi/91NDyx0uAt1RnnPAIoFNhvPziKFzRGcgXMUFhy4877nfKJG6lq9Zu7sn35RvbW7qUlqoDsAphGWFfKuwBPpZ+BAAlfRMGQANZlxG2gzVx1TzjNVHcua02NP25YE+x9s+B/1H+scOxqsK/2WjjRWHm+vkbY0Wcx7E6IR+m5Q0A/KCvW36pCGhfSr3kF0UgYMHEyb8pSPyUpw86bn7wkcrjbfdxZe0gThVKMkALFm6Ui3EOCUQTkvpbdgKnSGNbvwAEne5+OpkZmjvqyweQmlW/eap2PPMu78A51+ush3C02RBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 08:10:09 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 08:10:09 +0000
Message-ID: <6dc3e334-7f22-4f8f-a801-b9ce07b0bc4f@intel.com>
Date: Fri, 29 Aug 2025 16:16:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
 <aKkDXiSwWGgio0dM@Asurada-Nvidia>
 <fba0b1ce-13de-4c80-9f44-4adc07cc6934@intel.com>
 <aK8fsD+c0LAXzB3y@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aK8fsD+c0LAXzB3y@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|CYYPR11MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: a320e88d-87bb-4461-794f-08dde6d378be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|42112799006|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXo4cHlUZkYzL1htVEdldnh6UlF1OVU1UjdHc1E1a3pIRld4WGxqNWRMcllT?=
 =?utf-8?B?NE1mUjhMVzRHaVA2R2hLcnJaYmdRT2sxbW9LY1FOQzN3MW1tYTJ2NXdacG5o?=
 =?utf-8?B?Q0owVFFFQTFBQkpacmxTQmo0dzNEdzN0MXRDWjJyZVluVlhSQnhzSVU3SnRu?=
 =?utf-8?B?U3pkOVRXbjRxTGx1Uitac3kzY0RIdXRwaktDaTgyY3RiZ1BmZ3YvdG5URVBm?=
 =?utf-8?B?RnZIRUlLZWZ0UmRIaXEzVmFtS0dWazhwR1FaZnFaM3FORkI1V24vMUcrNU80?=
 =?utf-8?B?OE1lWVJOSGFES1NCWTg0eDNET1g1bmZZQ3RVSlVRK0VmQ21qOTk2NWtsVUpL?=
 =?utf-8?B?Wk15K3daTmJFclhwTHRiZWk4T1NmQ1Bic0xUeFlqaUxiNDhNSmlvMFVvQ2Y3?=
 =?utf-8?B?QTZCMkpqd1B4QTEzbXhxM1pSZllDd08rdjJKZHVOa0IwT284WEFlYWhLZ0FZ?=
 =?utf-8?B?Mk9GY2lFdUVOM1l3RjhiTGFMSU1XeFhoTEZjQlB5eGdFOVFqUjNiVVVvUWlU?=
 =?utf-8?B?RlV0aFhDNVVBNEprdmNHRGhnRG5qZ2hMa3NqK3cwb1VqYkFyeEYwV2VLYWln?=
 =?utf-8?B?dFFaM094Kys5dGRzYllORmkxcEVvRlhkVUo1T0Z5RUVDcXk4enNZN05HVytF?=
 =?utf-8?B?NCt3VHIvL3pDV2t5V2pLUDJ2bGcwV2RSenFDWm9oNDRobU1Jcis2a2FKbjJk?=
 =?utf-8?B?eWdQM1hLcjVTUWdIczIvaHlESG1kUzNjRlVHYVhmS3Nidk1FYmhMOGJQNk9m?=
 =?utf-8?B?OG9tbnZKZ2Q3RTJTQzhYL290NTJKa01uOW15ZkppYUJTblI3OFBNTUpoNlVT?=
 =?utf-8?B?NnRNM3gwREw3dkxpcUx3UHJCYlNyL2RveDV0ZGZaTmVtU2l3NE1nVldHOUdR?=
 =?utf-8?B?MFIzblJMcDBNUmpoaURYVEh6ZTR2SkMwZWp0aHVqN0RPV0U5YVJUeW0rYnNS?=
 =?utf-8?B?VFZ5RFk5VjRPUjUwM1pDZ216c2RnOHRMVVVwSFBHOUVaNkF6RkJTYTFicld6?=
 =?utf-8?B?N2dEVkRQWXZsMHUwSHhLd3hFaTBML09NVmxPTW4rRHF6enZNQVAybDEzTDBD?=
 =?utf-8?B?RDU3VzlqVVY3RTdMaUxyc3R2N2EzWktGOUNrUmpXWkZWaGVKYVhmUVRPVUxV?=
 =?utf-8?B?YUZ1R29lK0I1UERvNG8wTG1lUlZySGU5Y1Q3UVdMSjl6SjJ5b0dZTTZTY3hV?=
 =?utf-8?B?TUtCRk1xQTFrSUVXODdrSE1VRFpsc0UzN2E3Z3NCWmZ4VFFsQnJid3E4NXV3?=
 =?utf-8?B?MmU3QzBWemRMTUUwQTlieGpQNTl4QkFnR20xeE5jZ1BuNitUb3JRdGNCdEJa?=
 =?utf-8?B?RmlnZFk0NldWcGt1eks3SkVya1hFVlo2bkdGazFYSzV6ckRrVlkyMXBySjZW?=
 =?utf-8?B?S01nWkJGOFB4MEY4OEYwU0U2SHR4LzJyRzM0UFFLUFJsakF2ZnpqeEYyWi9Q?=
 =?utf-8?B?ajhBemhYRWlBU2htNTd6MExtZldIQ3dMeUFMRkVOSTc2MTY1MEV1cEcydldP?=
 =?utf-8?B?b0cxNXhDOGdZcGhXSkwraTJhbXpPUzJTazhLSCsxemxObDdGV1VPMXZ2UTNa?=
 =?utf-8?B?RXdabnVwQmY5MW04dEVXa014UWIrNGlObU9VTi8zTlR1NUtqWERjS21qUGxH?=
 =?utf-8?B?bFc5Z0YwMFBmdjBRWXo3aEdKTFBsR24yVldCLzVwM0N6eWVMQWdWTDRid1NS?=
 =?utf-8?B?VlVkSTErNDg3UU9oWVBlODg2L0VtNVAvVzhXQWh0YmRrVFBsTUNveU8rS1F6?=
 =?utf-8?B?aW9FN1JyZVRiNXFCbGIxem56elpKWFA3aXQxNGdnbmdrQjlGbE1KVGU4TXQ5?=
 =?utf-8?B?bGlkUTB3TkhTUWdyTkZtYUFEa29HWmthNVpFK2lGSVJtWVRGU0R1OU0vbVBG?=
 =?utf-8?B?QmxXVmNUd1V0Sy9QTHVTNnZBa1BLODhzUlZEYm1tNmhXeTBmWGFwNTh0TTVs?=
 =?utf-8?Q?48yzPJ/VJsE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(42112799006)(1800799024)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NksvVlB5UWVHRlJyWkVySm1zOWxWalRpOTh1SjhHdURkdjNXRGJKSVQ2Wkd1?=
 =?utf-8?B?RnY5OVFqeTI5NnluNkJOcmQrMzU3czI5NDdpVnZoRlE3bEIwMHdIZ3E5OWpk?=
 =?utf-8?B?YW1CRlR6R1FXQ2krenExb3lxV0dpSkErK1JmdVlERVVzSmxPOHl4QWF6WjhZ?=
 =?utf-8?B?S1Z3VWEvdU96UWdqclNiOEU1Vithb3kyam8vK0oyS0lWWDI4Z2JkYmFEY1VB?=
 =?utf-8?B?ajFLeVo5bjR0SVdXRnppcXE3TnMvTjJCWW1RSkt4dGlwd1VwaDRTK0cvMDhv?=
 =?utf-8?B?b1ZzRjJCU2c4NmtmQUVvYjNpakJVbE1na1QyT3lzaUdtK29NcVA4U0JEZnA2?=
 =?utf-8?B?Qk5nbGhRSVArYTR2NnhNNGg4blVFNjhzUkJxalprR3JvT0t0WEhpbVRnWDZU?=
 =?utf-8?B?eGVuTWc4bVF0WDRkN3loOGhUVm1CdXhBcEJ6VGdVQXNUZmR4ZXRYa0tzMXFQ?=
 =?utf-8?B?NGQwNmxyU1BidUVyTU10WVI1cmhidjA5VjZYa2ZYSVN6Mzk3Kzdqb3Jzemk4?=
 =?utf-8?B?ZTJWSW45SnBTQmV0dHFOM05yMzNFeUt0Nm5aRGpYMzhzSGlkYTIwQnAyeklu?=
 =?utf-8?B?R0xMZkU4ZEkzMHV6NnhRdVJiVUtWU1NaNU9mZmhVb2ZjYm9hVFQ5TytodzF3?=
 =?utf-8?B?NEhZNlZLY0dxR2VmdVNsTjVySlpoVXN2K293Rm9QSDV3WFFqcVpmbDRaZ00r?=
 =?utf-8?B?eDhyQ1YrdUttcnVnazZkeSt5aW81czViVG1KQ1llaHl0VTA1SDQwNEZ5d2Qx?=
 =?utf-8?B?dXM3RUdRc0FSeDFWSzBGeERDTHZqcFRpSDVFMWZyb2FzNFVua05hd1RvdkJO?=
 =?utf-8?B?MDFjQVltTkpBYU91L3lDZmxTZkVhN21sbzcyZ3N6NUlBYWhEeGF3cGZKUUU3?=
 =?utf-8?B?RE5OTXdsVSttanZEdklDSTNSWDNiZUtwdVNYNzJvSDg2azlOWFY2ZUg5N0t2?=
 =?utf-8?B?NXRrUVZxeVIvTjdQY3FMWkhMck1kODFZMUtMU21pN1R4eW1TOU5MaStFSEg0?=
 =?utf-8?B?dVZsUjE4ZmdnOTZ3anpTZU9pQTZBOWVvYXh3c0JzbGNpQVIyd2ZvMW0xS1Jv?=
 =?utf-8?B?cE9USnRmTkxwb21wSDV5V3F0TmJpelIyTU44RjJnYW14VjlxZWNJYmpzdUNy?=
 =?utf-8?B?MkE3V3M0OC9oTTNvNTQxZjZubjdoMkw5L0RXamtPY0NOd0xDV1hLejRxVEg2?=
 =?utf-8?B?MklBYy80Q1ZGQlkyRlhnM0NRbFM0MjZDdm1BRy9RUDZlYXcwcHJTajl2OVd6?=
 =?utf-8?B?bjJrVUhJNzlMZ3l5MWVEbCtycno2cTZmaUNnSGVLZG41TlBkS3MxVURCNVhO?=
 =?utf-8?B?anc5eWNmR3lIVUhTbjhoTlUyNmJvSFJjVTVUbS9UcS9SNW9YZVVtMkp5bUw1?=
 =?utf-8?B?Sm8rQlE0NDA5VjhBUUZVUUlLR1dZMXordnRuTFc5b1A1N3QxTkI0cVl4enRO?=
 =?utf-8?B?aUYwek9UQXdXY1JyVWIxZjhYTUZBSVFhbFczL0ZZTjQ1RkJ3R3oyd2wvUXMv?=
 =?utf-8?B?MXE5dHVieUVUL3QxOHZjVTAybHJLN3Jnd1hRRGE3TFUvdnYydEpxK0VIdWVJ?=
 =?utf-8?B?RGl6MGwwU203T3hRWVJzZkp3QTBxTVNQSG1COGtCL0gwajdRYkZlY0RBVXVh?=
 =?utf-8?B?OHBJdmVzdHdLekRReXZ2THpFOEVBakh1QmFlMGJJME83eC9nZXFsUUwwZ1Nu?=
 =?utf-8?B?bmdXK3NjQ1dhMXZNbHBqRDA3b0tKS1Y4SGlSYWZ4MTJoa3ZNZ21XTVQ1WEsy?=
 =?utf-8?B?UVQwbGtqcW1hWXZDbkljVi9XNzREMVZnTEswTUNTd25nbmxYUUthdk9XNk9z?=
 =?utf-8?B?amZ2M3FJbFZSTGRsazBaVXp4Y1F2NVNPbnVsN3lNNlpwK2dNa29reElLc3lv?=
 =?utf-8?B?Vis0RENWWkFHQzBOb1ZrYThXcGhFSmd3N3NrTHNnaGZRVkhBdUVrVFQvdDZw?=
 =?utf-8?B?bW90aTZYS3k2UGQ4Z01pZW1PY2lrRi9LQUYwRnNRbjgremxoS240S09XbUhy?=
 =?utf-8?B?aktHcHFLaVprRnRPbGc2ZFkzanVudjEzKzBIbzhxZzBCV3pYVWpBRU1nY1ha?=
 =?utf-8?B?U1BEYksxbkNvRjIwVm5FMFl6TjBXWTFyK1Nhb0hDUWxyN1FDZjVrZEF2SFBm?=
 =?utf-8?Q?SlDlGFDrOgSvXpAhfZenx8M3Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a320e88d-87bb-4461-794f-08dde6d378be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:10:09.7344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zsYydigmpbbv6D1hqK/e7sm/BVSclZEpHgN4Fdy39l16z+sJ0S8jCeSQXpMqYn0GGgssPxk/ZVEGKqc8DcGlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
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

On 2025/8/27 23:09, Nicolin Chen wrote:
> On Wed, Aug 27, 2025 at 07:56:38PM +0800, Yi Liu wrote:
>> On 2025/8/23 07:55, Nicolin Chen wrote:
>>>> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>>>> +        container->bcontainer.bypass_ro = true;
>>>
>>> This circled back to checking a vendor specific flag in the core..
>>>
>>> Perhaps we could upgrade the get_viommu_cap op and its API:
>>>
>>> enum viommu_flags {
>>>       VIOMMU_FLAG_HW_NESTED = BIT_ULL(0),
>>>       VIOMMU_FLAG_BYPASS_RO = BIT_ULL(1),
>>
>> hmmm. I'm not quite on this idea as the two flags have different sources.
>> One determined by vIOMMU config, one by the hardware limit. Reporting
>> them in one API is strange.
> 
> It's fair enough that we want to make such a clear boundary between
> a vIOMMU flag and a HW IOMMU flag of the same vendor..
> 
>> I think the bypass RO can be determined in
>> VFIO just like the patch has done. But it should check if vIOMMU has
>> requested nested hwpt and also the reported hw_info::type is
>> IOMMU_HW_INFO_TYPE_INTEL_VTD.
>>
>> 	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
>>              type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
>>              vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>>              container->bcontainer.bypass_ro = true;
>>           }
> 
> Then, it feels odd to me that we don't have a clear boundary between
> a generic flag and a vendor flag :-/
> 
> It's fine if we want to keep all the host-level vendor flags outside
> the vIOMMU code, but at least could we please have a generic looking
> function outside this iommufd_cdev_autodomains_get() to translate a
> vendor flag to a generic looking flag?
> 
> We could start with a function that loads the HostIOMMUDeviceCaps (or
> just VendorCaps) dealing with vendor types and outputs generic ones:
> 
>          host_iommu_flags = host_iommu_decode_vendor_caps(&vendor_caps);
> 
>          if (hwpt_flags & IOMMU_HWPT_ALLOC_NEST_PARENT &&
>              host_iommu_flags & HOST_IOMMU_FLAG_BYPASS_RO) {
>               container->bcontainer.bypass_ro = true;
>          }
> 
> Over time, it can even grow into a separate file, if there are more
> vendor specific requirement.

you also have valid point. I've also considered to let vIOMMU to invoke
the vfio_listener_register(). This might need to change the VFIO logic a
lot. Conceptually, it does not stand very well... And it is too heavy
for WA an errata...So may we just start with a function as you proposed?

Regards,
Yi Liu

