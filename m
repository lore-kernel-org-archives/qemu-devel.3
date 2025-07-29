Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F5C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 07:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugf8H-0000IK-FF; Tue, 29 Jul 2025 03:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1ugf8E-0000E0-27
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:52:18 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1ugf89-0000EA-L8
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753775534; x=1785311534;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gCLXSGEws6OpxTRPa5zEtYShoMMwil43XhcUJ85S7Iw=;
 b=kcXKB8guW71SVc9bcV6je/2xeb/1+VKbh7zZGqVQN7jeSbDLguMIWSt/
 DCWos/ZETfuGATvp4aSg3tGclvJt3AdGQTpgia9vWSV4KLMa0odEGTw9G
 3q1DBNn+R67pqQcYyfh/TL23V/XP3eilK4untKeTSxRAQyHGjIqDEDwi3
 ABFDFvXKd+6b4T8nk3WYSLZC+zixx32D2U4yMoO4ROtkTwk6uwnb1jx7P
 q2PlxzxKZnAJ96Gtz2uqukzoi8tVPOMkfWxk8wMhnEkLJ+k1KgviLD37F
 ZDPsL+ofQQggxkxfGfnTJZ/vHOgxDL4KKGQDfrUkjZ2xDSzzICAbp34ou A==;
X-CSE-ConnectionGUID: MYLeAXZ3R6iyiyr70rHlxQ==
X-CSE-MsgGUID: tGSdNlN+SV+j4Wh8yZiL8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55243713"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55243713"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 00:51:51 -0700
X-CSE-ConnectionGUID: 8iqLS+T9SCi6c3DBvpJYRg==
X-CSE-MsgGUID: lq0lGrxmSY2GZ2MHB95T4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="161897401"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 00:51:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 00:51:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 00:51:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 00:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srTPRSG2w4+64a3LoEd/v+lwQIxbdBD45wHTz3Seb/9AFxKQHckvk7/aXoe0c45P177rrD0NklAtmbvCTliXI8FO3ZRyMiyzEex11K7vLUQoBuT5TqRRb90YvUqHo3tEsfH+pi+TNuwboessZA7ac0z9OR9cIGbUDUx8KD+Hl5xmo/IQnrEImI0Ea4hvLQfVTT1+zEVlLzlkh/fBGU1M/kPHy7OHlxOSxnQZsb8xUoonQksRzNA/sqQ3bS4Hhdk1cwPbuJympImOADTQktL2z7qKAhrEJjolqUzIJtwJBSiPiRB918QrMXBuOmpbLoaNfSHMwm++5DKmN+dIjSlDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KB95q0xZ7Kr5V+3kSm63ilD9NVtVwIhdmGG+5jx9W0=;
 b=EEaKOpFrn5fSCg6Pp50+o82dmu7WN7e5UTiqYVMjLwU+nbdU8b2KFe8qwPMwZuieglQdrGvdyfqmJgp8cdXiwZUL62nuq65zMIL/KfZI4NeaCxFIQjPk/m+6MvGFSM3JTRCWxmJ6N3H+Reogj2cvwbihbqqesZeilrcpCwQ52g4VIY5KbOAmW0vw70zt8KbL4X9DzASkIXwal21ajNSABLqLLc9V8dH3wMTzZFHHiePOWgfLJgiTzlXVRnbm9kGrWaD38vVJ5fPmdd7viuHL5pSf5iF4LXijEk4RVmFa55xkdLfFzOgEO4c+/81HG62VbmrTSk+XRaufGPplatgo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 BL1PR11MB5223.namprd11.prod.outlook.com (2603:10b6:208:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 07:51:21 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 07:51:21 +0000
Message-ID: <37320576-8ec6-4927-a1f4-861808752d33@intel.com>
Date: Tue, 29 Jul 2025 15:51:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/kvm: Get X86MachineState in kvm_arch_init()
 without the cast check
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
References: <20250729062014.1669578-1-xiaoyao.li@intel.com>
 <20250729062014.1669578-2-xiaoyao.li@intel.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20250729062014.1669578-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|BL1PR11MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: a72b6dc8-71e0-4374-6857-08ddce74b562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elRtUWVkQWl6RWRCSUVFT2N5ZmJDekhYVEtvVUlFZGtyVG9tcFpzVXl3NjY0?=
 =?utf-8?B?SEg5UG9JOWZ4VUxFVWViRVoxQVdsd0F3VVE5dVcyQ1Q4dkcxNWVuVzJIT1JI?=
 =?utf-8?B?UzhNV3FlMGJjRFQrdjNDL1VHUmtkc0JmcGt5NXNGbkIxWFZvWkxVSHVabEFs?=
 =?utf-8?B?ZXBCMUdHczhtbHBDN1lPMU4wN1REUHVhcGxGL3J5K2xvYkw2cWpPQndod2Z1?=
 =?utf-8?B?c0VzamxxRzNxaTRiREE2L05pSWdtTWVhZmRkV1R4TVZUY0JUZys1a25PdFhT?=
 =?utf-8?B?ZGlwVVMrTWtTTlAxMnd4T0x1aUFKWXY2TzM5SlJZTjJXRjVMVytvN0d6N1BT?=
 =?utf-8?B?L3R2RU9IZWVYbUFUeHF0VjlSTnltMHJtUklnUldTZk5xcEU2eGRQS25kckNU?=
 =?utf-8?B?NnBXeFZFeDV2QUdKWUVOT0UvVzBsMGlCU3kreTZjWHB1aUFFZXYyZ3BGdGha?=
 =?utf-8?B?cjVvK3YrK09TUStsWCs1ZXhJdkNPRUx5dURtaVFuSWFRbFd6OExkdE5qcXNk?=
 =?utf-8?B?aWJDTjNzZ2NoeVkyV3lLdlEvanhQL1g0Q3d4UFVCM2x5THU2NVppbncyelcx?=
 =?utf-8?B?Y1pCMmdhK2crVytrUE10SFEvUkxkaVdJeWtINHpzYnQvbzNlOUE3NnJ1cTc0?=
 =?utf-8?B?aG40bDF5UTMxb1dBQ1NLUmZrelVmSklHRlJCVHVncTVPVGIwaU9RM1BOcjU1?=
 =?utf-8?B?MFRsbmlKUWZBWVVFcUtsSkMzVjV2ZTJBK0FvdG5IaHQweFZ3YXpUTnFWKzRi?=
 =?utf-8?B?TSt1U2JZR2lIUkNCRVZZNWZLY0ZDbVd6bWFjcW5qMi9abjRYdGNIY3NNZ2pF?=
 =?utf-8?B?VzA1VkY1MlJ3TzF2bUF0SjJ2N2VjVFpUOFl2dU1DR2RIU2c5MFFqQzNtT0NW?=
 =?utf-8?B?YVVhbVpYZ0hCSHRlNkpBbHc3TVRGengvdHEwNWx3ZW4rcVJzMFhkMVBzb0dt?=
 =?utf-8?B?NU55N0hzVUlETi9zSVo0K3A1SWw5ZFQvZXdGR00vMXdUcE9RRGZQdTQ3VXBw?=
 =?utf-8?B?MENWV29wQng5eGFad3RGeU9EdTZFb0RqamJlK2RHV0FHSzRmMlRoNnZHckUy?=
 =?utf-8?B?N0ZDbDRDZWtKdWpnNlZOTWpBYjZLMXhOTWYvczdFOUhsTDFPVmtjOTgzdWZn?=
 =?utf-8?B?Z1AwdUI4ZUNLdGovd1NDMTRGaEYrMitUaXpYdVA1L1Q3UndCUUhSdVNPOC9K?=
 =?utf-8?B?UmpnczdGbjh3dld2cENORG1nUTlkNWRub1JYYVJGQTlTL3c3Q08xRDR4aEdS?=
 =?utf-8?B?eXJpZlVaalA0MWFtVTFMTlRleDRUcStVd2tPRDVwWExjeVlVNU1hQmt4ekJa?=
 =?utf-8?B?Z1VUeXI4a0t5OEVxTStTSURHYUxySnNUYUNmbFIxRU1CSE5iRWMrRkJnaUIz?=
 =?utf-8?B?eERIcUo0clZKVUdRb0J0MlFXbUlaVzg1NzVIUmRzU2JyRWNFdlhBWVg4UXN3?=
 =?utf-8?B?QnMzMW5aeGc3UlhYaFFrbnBGWUN1eFpPaGcrSnk2K25TRkhucS9iQzZmUWlO?=
 =?utf-8?B?OUJYbEFVTVFMcHJDZHUxMlF4OWErdXdHbDRib3FOMWx4Wkd6a2FQNjlDc3BW?=
 =?utf-8?B?czVoMERickxrOVpZeFUxU3RxMTZicVRrLysyZ2p2aGwvaWpNbkdnL0kxNHY2?=
 =?utf-8?B?RkhkZTJ6eWR4YXU0b2phdUJoMnl2Tzh3VE9oOUlOVUFGYnRqbEdFQU85VEhG?=
 =?utf-8?B?aVdRQXM0L0RDUVF0V0NlUUE1L2NVOGNCd2pHTkxoZWp4VXdPVmFYQjJBeEZS?=
 =?utf-8?B?OGVmbVlUUktNTUVHYkEzQkFudVdrTXlMVmFZemZlV21RYUFhU2ZtWklDVVk0?=
 =?utf-8?B?NktpeXhVTkR4OVhockxKamVodVVYcFlLVVZuMDNVTEtKMysrYW9DWGtUTjA1?=
 =?utf-8?B?N091dFRPNDJhUGtNS2dQNmZqZXpCbWFXT1NZNlZ6MFpISmkyL1d1UTB4U1Vj?=
 =?utf-8?Q?nIz3nteG33g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpOeE1kdWtBeHFqbkF6bTlGNUlPSG0wN3ptZ1d1MnJZZHRYaTNFQk5VVTlp?=
 =?utf-8?B?ZkUvU3lUc21WZmg2d2RWUG95dkhnVXpZL2hDNFdMb1JTdVVLV01MTksvVFlM?=
 =?utf-8?B?ZXJ2L1pBeW00SWVibEh0RlFRWERXRUJQZW5xcElwOUFGMEVDL0s3dUMxMW9W?=
 =?utf-8?B?SU13M1BmVExGWDM4eTZvSEN4aHovUFVPb1JabURkdUJTQ1BIbThhc0o0WE1u?=
 =?utf-8?B?T2ZuSEVhbXh6Q25waUErcFVFb3RBRWtvalkySmF1c3hCN0VlQXA0bVBZTGJD?=
 =?utf-8?B?MW9CRTNFQXZWcjgrNERmM1hHRXdMYmp3VFFIL2l1TlJDaU94aktzeFVrSFE0?=
 =?utf-8?B?aDZobnJjLzBCRDhjaTlnSjhVUjhMUEZmL2ltQTFtdUVDd0F6SGdOUkxmT2Ro?=
 =?utf-8?B?ditZOU1mcmFNby9HWUlTQmhhZ2ZQejRtTTY4OWlzcCs1OERrYXRnSVcyYWp0?=
 =?utf-8?B?bEJpK09peVVnMUQyTzdGdDh6YzE2clYvSmsrZ3NSOEdVVW1kcENzNUhUQXM5?=
 =?utf-8?B?TitHQkZ2Umg5OFNiZzc0NXQxUHJLUHFHNkYweVZFQnZyckhPK3hRWXZldFpJ?=
 =?utf-8?B?N0tmMjluSVhtYVhSdDFDQWdGTjd0VXZYd0VFRks5bTN6a1FWOWdYeDd0ME5x?=
 =?utf-8?B?K2lhb09OcGJlV3pZNkF4VUVKM2VhYWxOVXRnSVpKVkdzUEsvN29KMW9Kbyti?=
 =?utf-8?B?Z1pBODVGQVA5dVVERFl1djJDVDBCY0pnVnlEa21vb1ozeDFiY1ZHazdrT3FV?=
 =?utf-8?B?M2RZaWlkTjRqdEROUHFuR2tlbm5pMHFmNlRwVjFNdWpXQ3VZUVMwSTZsbS9Q?=
 =?utf-8?B?NnNpZDdJMTlPdVNVbnJkZXNEQ2Z2UzVsQ3J2NnN3c0NXbGgzU3VmU2I3S3pi?=
 =?utf-8?B?czlHWU5MZTd6MzZKa3doVjAyc1p4WW5abE01OXQ4dFdkelZVcEpiLytCSFBo?=
 =?utf-8?B?eEFwVlhndUgvdnMvVGdGamQwU0FIRVhMK29IcnM3aHF1VHFvRTdlbzRhMzJW?=
 =?utf-8?B?dy9VWDZTZTJ6eGRNY0w1T2R2bXppeXgyaW1ZOElYQ3ppUlZwQStYWFFHMlNE?=
 =?utf-8?B?UkVtL1VOQjhyRTB3ZFJCaVVaWTRmU1JnWWFESGVjUUVSSlo1R3hwaFBCbFNE?=
 =?utf-8?B?OW93amhDQ1FIZDRVMFZ2WGgyZ0FTZ09TZmdTcFFZczNwNituSnY4OHJQcHNx?=
 =?utf-8?B?T3loTGE0aG52SUZrTFQ3RXlyMjBkSzlNajQ4LzNXRjJGd09Yd01CV2ZkTmN2?=
 =?utf-8?B?TmYydjhxYkVTTmlzS0hHUDVmeEJYTnRkdUJ0S2ppcjBkY3o5Rnk2eDgxbmNH?=
 =?utf-8?B?WVRFQUVzMEFMWnpyeXdCdjF2ZUZta0dDd3pSOGt2UXNiVmNLbmM0OVRBUVp3?=
 =?utf-8?B?L3dPekprTWRVRlNxSFBiOXVTaFJ2UEl1RXpJYlJYT2ROUFlITS8rRlVISFlX?=
 =?utf-8?B?LzlzbE5VV1hWOWxMelFQRHpBR2xJRWVJOEc4YVNudm5xOERqdzExRldjMzRi?=
 =?utf-8?B?TUNWSm1EaXYxRDBPSVJHWEluRmlDWForRlpiWmxva3pkSGFxbm5nVVczZUJU?=
 =?utf-8?B?dVNhdXdOVjVIK256cEgxeWxPRGh0QmcyMkMxdHFLbnFjRjNHTGV2YlhkUkdi?=
 =?utf-8?B?djlEdS9UVUtRRHdSc0txK0Y3QlpyVVBBbEZNWmNOa3NWdmpzSkNhK3F2N3A4?=
 =?utf-8?B?K2xzTDk4R240VjRVWE1EYjRCWFkvUno0ZlE1K2hMT2d4M3NvODJKNWhabkhl?=
 =?utf-8?B?M09JejhydjVvbjNseVdoL2laNS9rWkpLQU50WDJlNlQ1T3RyZVdKQXg3dnE5?=
 =?utf-8?B?NmhhcUVueWtLMWpOSzhRM21RbXFzQ2h1TzBqcHlwdlZON1BBYlVGN3V2clNC?=
 =?utf-8?B?MGhPellQZ3pNMFJobUFOdGZiR1Q1YlJyS2JyQm1nQ3VER2V2RWZQdmlDbFYw?=
 =?utf-8?B?cGZRTzVZT0dJaTZRYlVidC9wM3VjMXJHaUxwa0xxL29Od0ZjdjBobElqelZ6?=
 =?utf-8?B?TFZmR2tka1FXeXVibjh4cjNsN3FFY0lraWsxVi9RWjBEcCs5M1VsM0hGNnAr?=
 =?utf-8?B?b0MrWU83YkpDVlJhYlJUOUtTKzhrL3JiUGYybnVWK24ydUl2M1g2ejZubU5I?=
 =?utf-8?B?OWhIYXBtTTE4U3VCV05YVlR6VStBRTVuY1BBNlVrMjlRMVpIY2lJTmYwbEwr?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a72b6dc8-71e0-4374-6857-08ddce74b562
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 07:51:21.4076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXKXyPreethZoNjCO4ycBEZbh80e6Zqv7bh9SHAHddZDu19/1qT8wqBDPkSrL/x+KB47pX7GjfTwinFGcgdS6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5223
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
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



On 7/29/2025 2:20 PM, Xiaoyao Li wrote:
> Commit 8f54bbd0b4d9 ("x86: Check for machine state object class before
> typecasting it") added back the object_dynamic_cast() check before
> casting MachineState to X86MachineState. And commit 035d1ef26565 ("i386:
> Add ratelimit for bus locks acquired in guest") followed it.
> 
> The reason to check object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)
> before commit 8f54bbd0b4d9 was that smm was not supported for microvm
> machine at that time. But after commit 8f54bbd0b4d9, smm is supported
> for all x86 machines (both pc and microvm). And since it's the
> target-specifc implementation of kvm_arch_init() in target/i386/kvm/kvm.c,
> I don't see how it would be called for other machines than x86machine,
> and why the check of object_dynamic_cast() is needed.
> 
> Drop the object_dynamic_cast() check and simplify the code.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

LGTM.

Reviewed-by: Chenyi Qiang <chenyi.qiang@intel.com>

> ---
>  target/i386/kvm/kvm.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8d7..d145ad49e4e5 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3230,6 +3230,7 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
>  
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> +    X86MachineState *x86ms = X86_MACHINE(ms);
>      int ret;
>      struct utsname utsname;
>      Error *local_err = NULL;
> @@ -3311,8 +3312,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      }
>  
>      if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
> -        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
> -        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
> +        x86_machine_is_smm_enabled(x86ms)) {
>          smram_machine_done.notify = register_smram_listener;
>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>      }
> @@ -3326,18 +3326,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>  
> -    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> -        X86MachineState *x86ms = X86_MACHINE(ms);
> -
> -        if (x86ms->bus_lock_ratelimit > 0) {
> -            ret = kvm_vm_enable_bus_lock_exit(s);
> -            if (ret < 0) {
> -                return ret;
> -            }
> -            ratelimit_init(&bus_lock_ratelimit_ctrl);
> -            ratelimit_set_speed(&bus_lock_ratelimit_ctrl,
> -                                x86ms->bus_lock_ratelimit, BUS_LOCK_SLICE_TIME);
> +    if (x86ms->bus_lock_ratelimit > 0) {
> +        ret = kvm_vm_enable_bus_lock_exit(s);
> +        if (ret < 0) {
> +            return ret;
>          }
> +        ratelimit_init(&bus_lock_ratelimit_ctrl);
> +        ratelimit_set_speed(&bus_lock_ratelimit_ctrl,
> +                            x86ms->bus_lock_ratelimit, BUS_LOCK_SLICE_TIME);
>      }
>  
>      if (kvm_check_extension(s, KVM_CAP_X86_NOTIFY_VMEXIT)) {


