Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48343D1119D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 02:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7n5s-0002fH-LX; Sun, 03 Nov 2024 21:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n5l-0002cN-JR
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:45:23 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n5g-0000Is-39
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730688316; x=1762224316;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vOJwKJ0zq4hz40II/6Orf8iEOvzn6EGFrJJD6/khfgc=;
 b=kWxysl2bo16iZw/VBzU1QfB22GpaUk+iSK14DNQUP2QE0yJIx2kWxZdG
 phQDKxClaUoyn5MKnMZv9c04MtmSWOscrj+ojnQ9o7oM0Z9uZ71c4xycB
 cNzS0eC5bfS72nENPydolq/B16C/88rDusqA+oFpgYkB3kx5avRrfvOR+
 rGm3jut8IitoIlQ0QZWSyVF7x+6s/s5XD7iL+w7FbgKf8G025fQl30AyL
 kc6EXh2G8Shjm5UScMRrbFZvEK7wDI9vtYFRFi6C9JKmvVvXevVrJX45O
 xeP1IKFzQwO19p4XoTeDxrtcsvkuE3XyvP3Sj/jQRs2p37jnMUsS3VQzn w==;
X-CSE-ConnectionGUID: i1OPQw+jQbSeGazIVExejQ==
X-CSE-MsgGUID: ceq1ohzLSeiCK5HJUX07HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29800236"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="29800236"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 18:45:10 -0800
X-CSE-ConnectionGUID: b7RMeh0uRuGz2fyXPclr6w==
X-CSE-MsgGUID: cXq3aF9xQmyuT4yaxUdnRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="84327666"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 18:45:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 18:45:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 18:45:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 18:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qThK/guNwcn5U4nFMPfADbNL5n2OHaJ1cQ4go23vytkkHSjhawljUKL0C3DcDYc082OIGKu6LnildRN4R3ircRZi6tg60sBvIM4f7CzqChsS4S5OjHOXN6HXi7FLrxtZRVQiWhKw51PGApVCs4PQMbRx8lo8Zb8taN25VWNQ8DrfKzh2/rs3aq/mxRFaKuNfJb62qIlIttbVAeKi8oRiHS40xcJN+pM4eVI2w7QMfWiysPMRjgGdXVqvRz6ojgW0hzE2HUndCtByRHaBgaK4h2gGWKjA9+X3LONzp1U93k/7smDTaLjNWMmOglcFSMtfzw/TKtlhaKB9RL2Px9sGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rieYxCujH+XhYjssfCZMLwP5/HJUq2weWqIni4HMQ/w=;
 b=uqlWOG4uJjwrFy9ubLObgRSjHzWhupqC6eI2s+st0HL4rN52fJCbUBZMz740dY/1sXlPga86jB8X0G8WwX5FcPzGiNUlb+eWKjARFYhB6lnQrIsGkbUm26LfuWmQ9QX0WtOUA1jN3smESmq9VwDdmDNnlQ6uOacj9E6JCIEXCVPX067Lq5X+/Hbn486EH73NcuWfyv4n93kWuuP8rqXqpRkfU/4rzvtkaVwxYAaB64vpfYatyGIHkdVR/9A1Xa5UsIRjOW5En5HwUpIX962A3ECeztVZ5HXA0ub4RWR9KQA50DpY05xtA+3nlm1BxfkQlrYOdoua7bVamlrhrUg1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 02:45:05 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:44:58 +0000
Message-ID: <3bb9da3b-f1de-4a3a-bdd8-37937ed15d50@intel.com>
Date: Mon, 4 Nov 2024 10:49:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8a5df5-53ad-4a2d-9b1f-08dcfc7aabdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFB1WGUrb2NvTE5zQ05iMVdpNmt4Q2VzalF2OTU3V0NBcXNEVW5JbUo1ZGps?=
 =?utf-8?B?UElVWDNBQkRiczRBSzlHeXU2dkI4TStyUnFRbVc5VGZvb3RRYll4ZmpuLy9R?=
 =?utf-8?B?RUgxQVgxVUdGbnZ5OWpjN2JjRktPRWtpa2RhYVI3aTJUbGdsK0hiOE9kbkE4?=
 =?utf-8?B?cjZKT0tleFo0UlBaYWVUeDl5bXJENUw4TkE3Um05ZjVKMlVPTXdDVDUwNDU2?=
 =?utf-8?B?MlE4QUhac25ya3VReU9wc25VVHRsdFRQaWRnbHRubHpFOEpnd3FCejJtMTJO?=
 =?utf-8?B?b0s4MUlKZVNreWJxQU1wcEJrMVZHRjNDNk9XaHQzNDFQam9Pcml3cTB2dXdW?=
 =?utf-8?B?Um1vQ3JIUUxmaDkrb2FOUTNQQ0gxcml0VzYya21aekttaWVVOVIrR3JySm4v?=
 =?utf-8?B?eWZsSXBPeDZLRUt3NmliWUltSlk3NVBWOWxMTUFtNDVXMGZES2cxRDZYSm5I?=
 =?utf-8?B?ZTd0YzB5akxPMm5zdytHRkFabm5Yenl0ZnI0VkpYWHRyRFdBWFlETUtrdVNv?=
 =?utf-8?B?MWlxbzhSeGlyVC9Idm0rNVVhYWFDUGxNK0ZhNEI0dmNncUVyV0hzNHRVbUpa?=
 =?utf-8?B?U09kNmtWODZPVlRpbFpKZGZuL0MwY01hSExKUkhsU3NKaTFqSVl2eFdrSW80?=
 =?utf-8?B?SHlJaGZyWDU0UW0yNDc5YmxCRmI4T0gyakdZZUF1TzZENVpuYjFlM0dHTlI2?=
 =?utf-8?B?UXNBVEhYMnlsTUp1aUlGb0ZSWEtvQVpWVWl0b0pRZDRqMm9yalVtalNaNzFP?=
 =?utf-8?B?WFhxOUI4eGdtWnJsRXl5WlNLL1c0aTlySkRvbGtkUFhhRktSL0E1U0pJZk1K?=
 =?utf-8?B?QWFET3hJc0xRaWxTTVFPSFV4SnV3NHdoZkRUd0tkakJSTGprQ0ZOdC8rNW53?=
 =?utf-8?B?V1dXSjlNalUxSTlQWjdjUUxldmk1c1A4SEU3dVBSb1NaYUJlU1JzMk42aGhB?=
 =?utf-8?B?VDBvVGE0SDdCSlRQdEtCZXZUN3FFUEt0cThDaFJRaUFRWTZob1dpaWpKOTlm?=
 =?utf-8?B?cDN1NmdsMTRYTnlnb043RzNJVVhCWm4yRkwvSEJuNG9NRUtIVCszQUNkZ2E0?=
 =?utf-8?B?ZVlwbkF3M1d3aWtzekdmcHZCVHV2MDBOZ0ZBNVdZR041ciszaFRUWUhPMkt1?=
 =?utf-8?B?Q2pGRG94TW0rK0RVb2MyZkxxUUJxbnpsVTR3RXVEdWphUm5SK2Q1eXdhcEdz?=
 =?utf-8?B?VkswSWJPa3B5cmFhazdrMjNjOHgveVRJMzJ6NVc2NTNWdERzWFJVK0x1anVK?=
 =?utf-8?B?YndvL0ZRNmRkQTZ3Zlpyd2l1VnFDWnpRM3FUeXNxL01pSGdhbTkxekVQSTdi?=
 =?utf-8?B?a0Q3bTNyRytLd1hXR05YMXk3N1dXSHFMYmRZV1NGL1E3UGMzTnRBZ3NLRTVj?=
 =?utf-8?B?aWt6QnJROWtkaXBpVTA5MFh4dXZWc0lnWUJKQWlQSmxYYUFHSldvaVpDSFdF?=
 =?utf-8?B?Rk5pQ016Y042bGxIVXg5bnBFN0JEUkQ0cVYrcmh4SG9UaE5TbThoVlVRUVll?=
 =?utf-8?B?Z0grcjdJYmNCVXBka0pKSUNzbVpScjNIWStyUHhXWExXbjN3a0YzMkVzQnlr?=
 =?utf-8?B?Lzl2YVFhL3pkY0pLMXlVWGxqck1rbEhOSnA1SWRiam10aUMzNGFlM1hHcVN6?=
 =?utf-8?B?enBNeUd4OU1tdjZFQWVKcHU3YUxKalRxa05QWUZiY0s1bFhkc0xDUHRweENC?=
 =?utf-8?B?SDAyRzByYVBadVQ5d2NKYll6Z0o1SkEzSXFRZjNKSytZNllmcldSWk9pK29k?=
 =?utf-8?Q?CQU8GCKzpcNm5fR8zNh9x5Me4NT3x2WX+j8C/VB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slg5N2MxdHVIT0xna1FoUEplL05VSXdUTXVEY3BXbHZnNHdmRXJwbURaa3hp?=
 =?utf-8?B?MHdFMzA3UTJTcVU2N3dMbjZxMTVhWlJIekFBcWF0WVBYWG5FVmxma2wxODQ4?=
 =?utf-8?B?ekZ2MVhDNDhtU1oveEJLVklXc1BVOWpxOTBvSlhuVGZ2alM2cURsOGlLZThv?=
 =?utf-8?B?b0RHYkZrYk84WkhOeGNodGY0WmVQaUt2WE5qdlB3SWRuTXIwbko4aDZ0VTcr?=
 =?utf-8?B?c0EzbzhpbGV3eVhwbUwyTGQ3QktHZ2drQzkrbHo3OTdQNmZYUlJCRmZTalNG?=
 =?utf-8?B?azBHK2RVUktpK3hldHFNZzVmOEV3dlhPQWRxNVRtbHlOVUdtOEZOY3kvU003?=
 =?utf-8?B?dzlzVElSangvNHBYRWdlYlpybllGeU95cFBzckJYU2ZyWEorZk5WOVMrYnhD?=
 =?utf-8?B?TVBKWDJ0V0VKQmh2Q3NldVNSdW5nN3g2M09BN3NmTHhhb1ZPVVV1M3VzT3hY?=
 =?utf-8?B?UXAwSnJ3Z3BtbFQ4a21mdUM5NmhyUTVDOVdhWXBnMExkc3lsVnlSeDNEVm5X?=
 =?utf-8?B?VnJSdHBXVjNyZ1V1MFVQNkZQNHhOcVdKZlAzZDZhcWJ0bWVZOGpXd0Y3WmlY?=
 =?utf-8?B?a1dsL1lZdy95R1Fmd3laYzJnWk5qMUlaMFh1WGJ3L09tRGRzMkJBcEtQenNE?=
 =?utf-8?B?MXhCZzdjcHR5LzNHQ0NGMW4zZkI2MHQxSzU0ZVhnTENFNk02c244ZXphdzRN?=
 =?utf-8?B?cmZhSTM1aTY1THl3akRGK1JTMzVMaU5YZHBsdklaaGt3cEI4UG9WZlBxcWZk?=
 =?utf-8?B?WHAzQTNHZzg0U1NYcHowVEE3djRSRGF0dTc2QU96WEpuR0YwMHgxQi9CZi8y?=
 =?utf-8?B?QjJwMEFUVGJ1K1BPL0xPNzJ1NTVqbGJKRFo5YzEwNWwyVS9SdkNmeXQwQmdE?=
 =?utf-8?B?dmZkZzcrWHA0eVdxQkRCZ2FPZEJLZFpVSWE3blA2Q2lsWU9TRkRrdm11VmVK?=
 =?utf-8?B?YUhSaWY5ZktobWprVy95QXZhQzdMR0xXNzg1T0QwaC9wcldnR2JDakZraUc0?=
 =?utf-8?B?dDY5cnF4VzdzU1ZMZVBjV3ZVTVd6eTlTUXRJUmpJdFJITUdmWXIxYVZDVWt4?=
 =?utf-8?B?L2gwdG1vNlpMVmQzMXRTeVlXa2JlWmlNY2N1dDZZWCt4c0ZuZXcrbXFSODFl?=
 =?utf-8?B?Sng2SWp2b3dCclYzK3BvWjQxemh6VTJQbGRKKzJTYXA1eEMwU0JWVUdWQUps?=
 =?utf-8?B?NVE1KzgwNTdJMXVrRkhJbklNblQ4NHpTb2JsTXBaam5KOEl0dHJUQmxiOHd5?=
 =?utf-8?B?bWtEYzh3aU9BNE1hcDJ2SEZyTFZ3YlF0OUxJWU1tVWxtclJ2NlQ5NjU5cDlm?=
 =?utf-8?B?NW1jcXJxNmZTb0xLd3JCWmJ5cDZQSlVrcHQzSnNRVzFORTRhQUVtQ2s2SjlM?=
 =?utf-8?B?V1ZvSUNDdk5LK012TEhjRSt3c05Ua0Jaa21WTndzRitCQlNtU2s4WW13bmtt?=
 =?utf-8?B?Z2t5UW0yNFBBSUNneUl6NWR5NjBwUmZucVpBM0Z2MWdBanVsNmI2VlNodmNi?=
 =?utf-8?B?aHJtby8yQ2w2c0UvdlZ0SEI2b29QYzVsRjFINHA5UDI1SFh6Y0pwUjJwWHFI?=
 =?utf-8?B?S2tsQ2N4cE81WWlMZFF4aVlKdGlkejBBbnhVMXg3TjNTTUN3VkFjY1R0TmNq?=
 =?utf-8?B?ZXo0UzFTVXVBN3lCcVFtYUM4aG5vYUUyNmpSVGgvcTR5NVN3UTBsL2QvY2cw?=
 =?utf-8?B?WlJIeFJVRW5TdTFaV0lnTVozUDA3YS90SHJXMW04U2Y2SGZNa3JoZUtZUTFt?=
 =?utf-8?B?YnlNRTkzOVdKQm9tNzJWWTdxOXFkSlFxVmtjLy9kVyswRTZhbmpDQ08vR2hL?=
 =?utf-8?B?ZVJaVXUraU45djJVZDY1MHNJSVNFY1doQWEzcUhUVDBPWDJlSnVrVnd0SElO?=
 =?utf-8?B?Z3Z5a2ZoVzlBQ1l4NXJmMVY5UGF4eG0waGNVaGhjOVU1Q05QTkhIMHA3cjBr?=
 =?utf-8?B?U0VpaEVXZmFCOVEvQy9iK0NCNHhXQk96ZVVBdjJUc0VtNVRCTG13eXhsZ0M5?=
 =?utf-8?B?QTdSYmVhVkdpSjVIVC8ySGFFT1NpWlkrbzlCeFFlZWlIUjJZNGpaanAvSTZV?=
 =?utf-8?B?cEdTWkNOaWtMT1liNlFreXRlbGIrclB5c1djMjBwZzRTWWphUnJtbmN6d1pI?=
 =?utf-8?Q?xhYkVV0YNr4usugSPi8HmqXm8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8a5df5-53ad-4a2d-9b1f-08dcfc7aabdb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 02:44:58.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG6KCPofhhHyReaEo0yjoSuVcYidHxLyvEcyTvafTXv3p9vwImdibTPOKoRI6kD1gdln8jzbs0uGZcyWowgHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yi.l.liu@intel.com;
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

On 2024/9/30 17:26, Zhenzhong Duan wrote:
> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
> flush stage-2 iotlb entries with matching domain id and pasid.

Also, call out it's per table Table 21. PASID-based-IOTLB Invalidation of
VT-d spec 4.1.

> With scalable modern mode introduced, guest could send PASID-selective
> PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.
> 
> By this chance, remove old IOTLB related definitions which were unused.


> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/i386/intel_iommu_internal.h | 14 ++++--
>   hw/i386/intel_iommu.c          | 88 +++++++++++++++++++++++++++++++++-
>   2 files changed, 96 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index d0f9d4589d..eec8090190 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -403,11 +403,6 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
>   #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000f100ULL
>   #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
> -#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
> -#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
> -#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) & VTD_PASID_ID_MASK)
> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
>   
>   /* Mask for Device IOTLB Invalidate Descriptor */
>   #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000ULL)
> @@ -433,6 +428,15 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
>           (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>   
> +/* Masks for PIOTLB Invalidate Descriptor */
> +#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
> +#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
> +
>   /* Information about page-selective IOTLB invalidate */
>   struct VTDIOTLBPageInvInfo {
>       uint16_t domain_id;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 9e6ef0cb99..72c9c91d4f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2656,6 +2656,86 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>       return true;
>   }
>   
> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
> +                                         gpointer user_data)
> +{
> +    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
> +    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
> +
> +    return ((entry->domain_id == info->domain_id) &&
> +            (entry->pasid == info->pasid));
> +}
> +
> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
> +                                        uint16_t domain_id, uint32_t pasid)
> +{
> +    VTDIOTLBPageInvInfo info;
> +    VTDAddressSpace *vtd_as;
> +    VTDContextEntry ce;
> +
> +    info.domain_id = domain_id;
> +    info.pasid = pasid;
> +
> +    vtd_iommu_lock(s);
> +    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
> +                                &info);
> +    vtd_iommu_unlock(s);
> +
> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> +                                      vtd_as->devfn, &ce) &&
> +            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> +
> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> +                vtd_as->pasid != pasid) {
> +                continue;
> +            }
> +
> +            if (!s->scalable_modern) {
> +                vtd_address_space_sync(vtd_as);
> +            }
> +        }
> +    }
> +}
> +
> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> +                                    VTDInvDesc *inv_desc)
> +{
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +
> +    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
> +        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1) ||
> +        inv_desc->val[2] || inv_desc->val[3]) {
> +        error_report_once("%s: invalid piotlb inv desc val[3]=0x%"PRIx64
> +                          " val[2]=0x%"PRIx64" val[1]=0x%"PRIx64
> +                          " val[0]=0x%"PRIx64" (reserved bits unzero)",
> +                          __func__, inv_desc->val[3], inv_desc->val[2],
> +                          inv_desc->val[1], inv_desc->val[0]);
> +        return false;
> +    }

Need to consider the below behaviour as well.

"
This
descriptor is a 256-bit descriptor and will result in an invalid descriptor 
error if submitted in an IQ that
is setup to provide hardware with 128-bit descriptors (IQA_REG.DW=0)
"

Also there are descriptions about the old inv desc types (e.g.
iotlb_inv_desc) that can be either 128bits or 256bits.

"If a 128-bit
version of this descriptor is submitted into an IQ that is setup to provide 
hardware with 256-bit
descriptors or vice-versa it will result in an invalid descriptor error.
"

If DW==1, vIOMMU fetches 32 bytes per desc. In such case, if the guest
submits 128bits desc, then the high 128bits would be non-zero if there is
more than one desc. But if there is only one desc in the queue, then the
high 128bits would be zero as well. While, it may be captured by the
tail register update. Bit4 is reserved when DW==1, and guest would use
bit4 when it only submits one desc.

If DW==0, vIOMMU fetchs 16bytes per desc. If guest submits 256bits desc,
it would appear to be two descs from vIOMMU p.o.v. The first 128bits
can be identified as valid except for the types that does not requires
256bits. The higher 128bits would be subjected to the desc sanity check
as well.

Based on the above, I think you may need to add two more checks. If DW==0,
vIOMMU should fail the inv types that requires 256bits; If DW==1, you
should check the inv_desc->val[2] and inv_desc->val[3]. You've already
done it in this patch.

Thoughts are welcomed here.

> +
> +    domain_id = VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
> +    pasid = VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
> +    switch (inv_desc->val[0] & VTD_INV_DESC_PIOTLB_G) {
> +    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
> +        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
> +        break;
> +
> +    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
> +        break;
> +
> +    default:
> +        error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
> +                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)",
> +                          __func__, inv_desc->val[1], inv_desc->val[0],
> +                          inv_desc->val[0] & VTD_INV_DESC_IOTLB_G);
> +        return false;
> +    }
> +    return true;
> +}
> +
>   static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                        VTDInvDesc *inv_desc)
>   {
> @@ -2766,6 +2846,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           }
>           break;
>   
> +    case VTD_INV_DESC_PIOTLB:
> +        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
> +        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
> +            return false;
> +        }
> +        break;
> +
>       case VTD_INV_DESC_WAIT:
>           trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
>           if (!vtd_process_wait_desc(s, &inv_desc)) {
> @@ -2793,7 +2880,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>        * iommu driver) work, just return true is enough so far.
>        */
>       case VTD_INV_DESC_PC:
> -    case VTD_INV_DESC_PIOTLB:
>           if (s->scalable_mode) {
>               break;
>           }

-- 
Regards,
Yi Liu

