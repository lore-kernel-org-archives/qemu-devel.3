Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D300C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 05:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEMv8-0004Ti-Sn; Tue, 04 Jun 2024 01:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEMuy-0004T0-MM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:41:09 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEMut-00084q-GA
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717479663; x=1749015663;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pJ8K2Y3lsqnwXR9Ki/r1y/PpmlaG4/fNAdGH225FMnw=;
 b=nLTDeK2qigcfSNOWJePXWacehB3pco/OOWic5AplBWx/TrHbKi8Bivpe
 b9NfpjuSm54kv/faYCYCLBM00vGnoGVWtun4Wp+FSquIYAeX/wBlYtyUq
 OSe/jRJlltKIdSC6Km7/TYRtd9Zai/bQWSNh6oz9l9SDVI5UiiLxxNZgB
 O6vOMQ4hiQgFO6CUDk8rVS56s8iQx68wImMP3mRDn6Yqu/IGGgMKfWvnM
 MjEYvD3vOW51CJy2vKU8WgbJibjYEijxYOonGrA0I+2GpMvop8GWyiKCY
 wHpjdFK81lZVQRabIX2046LCMePGs0DEUfL/EfH/vxydVOr3mmCllIz9x g==;
X-CSE-ConnectionGUID: 3BcMbNQvSHqjCVZ893dT/A==
X-CSE-MsgGUID: 9xc8Tn5KQ6Ocp5ekSBOoFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25399693"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="25399693"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 22:40:58 -0700
X-CSE-ConnectionGUID: KC8ASC3KQcOTUGI/syBXUA==
X-CSE-MsgGUID: ktUTWDKjT/KgPrfsAbtTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="42199458"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 22:40:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:40:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:40:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 22:40:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 22:40:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjREZhTAEHA6NoohWtdRlOYix+vUV1ZsUgyyOjWABkIynETHJdkzL72cOGYZAFwAYbDOxIEa9likkDsHJWms+GTgfFHl670XjvyqxpSRrVAp7wqdeE7kliUJdTCPRj8UK5uwu3gKC7OWreC0rFqfFl3Ch55uaPhpsDFTcEQfKykkJuzAQMXOXuiUAvjV6AEODues7qHk7LLgz8IDiAtfceGvsnt10GZf+LXLz23OKzDtRb97KZpLf7ds3gfPuEEJrjiWRrJoF0NP7LhnYZqZZwxerwn8E/hvdcNsQwa4f5x8/EFwuBdywWgNDs766VLzonPqnDBoiv+xbkXe1bjHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ8K2Y3lsqnwXR9Ki/r1y/PpmlaG4/fNAdGH225FMnw=;
 b=VAQgaTGuuKHHsD6KvMhSW/P9wsjdn/C6jj8GncHJKR0uUGI4Sgo1idthafWnswlXU6N8NnFejlB2Tn/xm6PqbcZmSt9yLy4ambE+0nGjoiiafsGFwXVHPopyVsVAa0fjb4IJnkw1Sx3oTTxQ+ysEyOA64r7yl3GWR02fwMIwTNgQRkDB7t/a7eQB+q/fyJdG1gAAAQPVpRZKPG3OWtBKpMcQKNz6gj5BBnOBYWjcHKJiLTOhPPLixVv07dHpVgBSUhgg0Adr3GcuIEeBZB6CTIrThv99Os+YnjfoosBnKg3JUA7D25iSgI9q+f5hWSHMGWTqTGe/F6DYCos5NQNhaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 05:40:50 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 05:40:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Topic: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Index: AQHatX1NjS0WvnbGzEqvnm/9l/Wze7G2FVCAgADkm+A=
Date: Tue, 4 Jun 2024 05:40:50 +0000
Message-ID: <SJ0PR11MB67442CF9C141B5C1120CA59092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <7d5fb5db-8505-469a-a41f-6e18ef8bc77c@redhat.com>
In-Reply-To: <7d5fb5db-8505-469a-a41f-6e18ef8bc77c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5257:EE_
x-ms-office365-filtering-correlation-id: 3cfd1721-8cfc-47b9-c1e7-08dc8458e445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?RFhlUzB1YkluTWZWK2hVdVBVRE0wYnB5VDBuTzlsRTZQdjBwNG1PTExweHk4?=
 =?utf-8?B?eVNBbVEwZEhxZEdOMDNvQUxDKzhhS0FhVmhyT0VmS0plZjJHVkJKbEFMSTRx?=
 =?utf-8?B?Y3Fqa09jNEhOOWUyak03K1dpMjg2WXNSUHNEa1pKb29wbUNXUWxxYUdTQjNV?=
 =?utf-8?B?Myt2V2VXWHlFU3pZOGJuTHUzazJEWkZFaS81VWZrd1VRdnJkRGRObzc3V1VR?=
 =?utf-8?B?c1MyMVlyazFpQjhRYkI2NkRWMFovN1JYczFya29WY0RVanNOM0NnODBwYXFi?=
 =?utf-8?B?YWpyVVUzZ3Awb3VvU0JHbWFDVWd2K0Q0cXJMOXM4VFdNdkpHTkdOK1hSNGZ0?=
 =?utf-8?B?bCtva0I4cGFGYkRBUEF2QkdzbGMrTG9Jd3loTUNDL1R0bVhDTlE1UU9aZnBs?=
 =?utf-8?B?aVlEOFE3VGQ5SmlEV09PbWNLV2N6cC9oUGJta2ptSHVZcU9lOThtb3RCemlw?=
 =?utf-8?B?TFp0N2RBbWJiQTdYYUo4OURCeEM4MjRZeVZBQmJDdldHMmJiZE9ac3JJbzc5?=
 =?utf-8?B?d0xvY3Jyd1hLc2thUWs0eVpmTFIzUWFNaTg5OHZBV0hxdUpocjNueExZMnYz?=
 =?utf-8?B?MVd3ZXpNWDA1Snk0M1FMcGlTYmEwNVBQeHhTNTA1c244bmE0S1oyYitkS29p?=
 =?utf-8?B?SnJrVVRvMW1Bdk5rK2FTaVlBVVFBNzZoMXFIelY5QXAwY1VvV1hsVW1CbUVU?=
 =?utf-8?B?Yi9ZU3NMV1U5THRLaE40SEJablUxcUtrbFBoejdUdXI2WE9Ea0hsWEZ6bmdK?=
 =?utf-8?B?b0lvS3o2Rk1qUEZKMlp3WTk2TDZVTkhJSit4NjdZclUyWUw5cms2ZXA2OVQz?=
 =?utf-8?B?dzJibWdLYlNqdGVWODhKZmdvS1N6Rjd6UWJXcHNXQkoyajBLbTdZYnVaM0Qz?=
 =?utf-8?B?VmR1Y01lY2xaTGMxV080RVJzWXlSZ2IwNDBsc0VSbHBMcWNiME92VTRsSnpX?=
 =?utf-8?B?NnVJaHBaVEFlbDZoaWpEU29QTndSU2cybUdsUW9aK2pOUmtyS3R3ekNuMWU4?=
 =?utf-8?B?VTh3MnVWQ0FaMlZodzFrdEYxanJQUWlIN3ZoOTNEYWlqNmh2K1A5QXM3M2xp?=
 =?utf-8?B?YmJVVUJrWXAzVE84Y1J2SktqZGhNNFNuT1V2L3ZFZnQ1STlKWWxTOHRDemoz?=
 =?utf-8?B?V1Evb3pISUplUVJFT1l0YkJpeDBISnFIcWthT1lnQ3FxSGdRL0dibDQzNEw3?=
 =?utf-8?B?WmNaVnkzaW1CZTZVbkZQODdKM1duUmpEb1E5eTFVbUFmUFE4dlRadlY1NGpL?=
 =?utf-8?B?OUVoYTAxK1p0S2JCcmx3Y2xGMGlTZEg5UG1RSlBTMTRNemYwODdXVW5JZnY5?=
 =?utf-8?B?ZFpLT3lETDFsWUF0VTltelFyVGp3ZzIyUE5TcmZyZFNIbWoydUhDSWVMV3Y3?=
 =?utf-8?B?QmNpMlRJeHhtbnkzUlV3MEZpSW9nTEluWjVXSlc5RjBXc2g1VmJacnNxSTBw?=
 =?utf-8?B?dFFIdGZibVN5cHF3Ny9RWEVZcG81RTMrZ242VUdTbVU2TGg5OGp3cXg0VFhv?=
 =?utf-8?B?dDB3WjM1eXBYVVpLWWc1SW94RDhLc25iTnBRZkNlN2pYUTBsY2NteGlGamZ6?=
 =?utf-8?B?RlNIclpNVmNwd01jYlFUMWRiNWt6MzhWZ3YxZTNyWW5SZ1ZNN2NjcldRRkJC?=
 =?utf-8?B?Q1lKaEhzVjN6Sk9UazE4ZzhZaGFpT01VZnlCU0RVNmZiQnlyaE9Xcm5DWWtk?=
 =?utf-8?B?eDhJa280YTBDODFkc2tlSWUzNW5QNEc4Rm1VSC9uMEFrU0M5NnJXVFdDeEdQ?=
 =?utf-8?B?RVgxNmxOSW0wNFVKckF3aXdKK09SL2Z1Z1FQMmJBUnhyQXZ2bjhlSzZXMFhB?=
 =?utf-8?B?MHRWak1CdG05R01KdDgvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akoxbTB0dTRxc1V1MHdvaU1BckJpR05scHZrVFdlenR1dUpORjJGK0JHWFZm?=
 =?utf-8?B?WThReEVWWDk4R1ZaQ0U1M2lzVnM1aUg5R3dQamZldTVDSnFHMUk4UytlN29I?=
 =?utf-8?B?cVEvbVk1dzhvbTRHTzd5STdpSW5vZllzYkRXVUtmeWc0YUlWZ2RpQkRNN3BF?=
 =?utf-8?B?TXlEVENaRFRESnpQa3lwS0Q5SWR0ZGY3WE1JUVRkSitHOVA0SzRjL3hLd0RM?=
 =?utf-8?B?UDBCY1BXN3ljM09SeHc3Qkt5OTFhY3NObWpFcmVReThTdzBIWHlIcHordW1W?=
 =?utf-8?B?NHRveUVQcHJLaGU3ZG4xK0hSZGZtakZNdWNmZXg0c2RFdEhsZG9DU1hiaWNj?=
 =?utf-8?B?OEJKQmtTZDA1Rmo5SnAxdEdZOXl2QVpjVHBnYUFIUERtcmxaZlZXbUFjY1hD?=
 =?utf-8?B?MXlQR0lUMlZhQ2FmTGJDTEt2UkNjZkNUb3NMSkkvQWFWT3JTcmdxQjZSQTU3?=
 =?utf-8?B?bWl0em1FQWlLYXdNY0JPRTNRTFRieWdWM2w1M0ZhNDdqRW1RU2QwUzhCeFRj?=
 =?utf-8?B?bFRnN25wTVRUOHQ0d2N6RHZwbmJlTlhldExLdWVNVFd6NWxkUU93a0UyUkVG?=
 =?utf-8?B?TDdrU3RxZ0x1V1RZU2U3VGs3blZZei9KL21rNDI3VzRISWxsbDB3K1RQNHln?=
 =?utf-8?B?dnp0MHg2VDVmbXEwQW14SkJrTEd4SmZUK0VGKzFnZml4cnV6S2VGa3lLWUNx?=
 =?utf-8?B?L2RYQ2Z5a3EyOGI1Umd0Vm00bzJiaXR2QmVhTVFmby9oZHJlajBteWJHdlNG?=
 =?utf-8?B?TkpGSlRHZmNIRmNEMWlWRXB1b3FISXFMa3Vxd1BGYjV1aWVsM3pJbHZWL2xO?=
 =?utf-8?B?QTEwVjJ4OUFSVVd1NEsxOFNEV3ZjQTUvczRDK05zbU42VjJmS0JPNS95NTJ5?=
 =?utf-8?B?Rm5YN25ZSzZEdEFlRDdyK2tsd3dVZW5vUCt2d0xOTkswNkdpVWYvUWQwUGk1?=
 =?utf-8?B?UzB0RStkQ1dhanBVOFF1NHl4SWhOSkM3TFRaeithbWdCZVlvRlA0Q29TZGYv?=
 =?utf-8?B?UFBlRksvWllXY3ZPTWRhbFplMWlwK0NJU3RmZ0dpSlZjUlJ3OVBCdU8zanhk?=
 =?utf-8?B?ZjAwK0MxY1YxNHFXdlRkZVRvMTdNcVVJNlN0UHczODEwMDlwM1RuVjR3cDVr?=
 =?utf-8?B?VDRHTFUvRDJ6cU12bEplaEJyY0ErSmRISUhJT3daU0Q0QWFnTTV5LzhwcVNm?=
 =?utf-8?B?ZXMzTmN3eXVIdVc5Sk9Jd2NLUE9VYkxpWHhLV1lqZFhWOTY5NTBEbmh3bW1x?=
 =?utf-8?B?cUJ3MjNCQnJmQmRJVG1xUXdLaUcxREdmY0NZcFpVbjVVZFcwWHVCS1MzNURE?=
 =?utf-8?B?NDB0SVlWZFhRaFBPanNvcm9VWlRBWU9uY2gwdG81QU5VYys1alFDb0didDFH?=
 =?utf-8?B?bEt1T3JvZWxGSHhIeHVaOHlIZFZYdUcrdlZCRk54SzFPQlVkVHVGemR0OWg2?=
 =?utf-8?B?L3lzZDU2NjNCWVJ1MWp1RmFJRFVhVkdXd3paUnFySGI5UmFIVThHLzY3dGVP?=
 =?utf-8?B?OGxIWWlzaTJqbHM2T2lVUG41R1dQNzdoZXlKZy9VK0ZnRDIrRnQ0clBtZFhB?=
 =?utf-8?B?S0dPS2c2ZHo3dnAzRXpFQS9RZWFhTWQxVFpWVUFNYUlHQTZaWVFvbjBaVSt4?=
 =?utf-8?B?YWJFK3lzT1JUUzJvbUhEaXJ1YjIyc0MzbitFZlg4cFRkWDRJNk9iTHU5QXFW?=
 =?utf-8?B?Zlp5RXJibldhQU9rNU5YZmFZWjBIUzFTTXVBZFJldWl5OXBmd2pGL0hwc2VB?=
 =?utf-8?B?M0dBVktpdWI0Wm42Rnc0SzJPYmFVRWlQbjh6NVZzZHJJSVZpeFNmSnIrZVp1?=
 =?utf-8?B?ckVrdU5kUVU3bHBmZlVwZFArc0dnUkpiUlFtaWVaMmQrMTdBRjZDd2JmN2R1?=
 =?utf-8?B?RjYxTEZpNlhxNjE1dTByTExnOU4zbGtWbzJwbmJOc0k5dHB2WDhxTzl4eE4y?=
 =?utf-8?B?bWl4RTl0SGJhV2V5d3BXNU9JYzdsbGlmcy9zbFo0bDR3K2dTR3hEb09RQlhu?=
 =?utf-8?B?MlU4TXFFbm9HZDVaUkVhU2xqNk9kOWZDSkRkYWNRcDVnazVJQWZLYWxWVndY?=
 =?utf-8?B?eVR4Sml1MUhwbEhqVXVBWmk2S1NXbitIWk0vVC94dktsUU5RV2tjY2tRTEJa?=
 =?utf-8?Q?80zFvv2CJEMyW+SFZWvzZPLx4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfd1721-8cfc-47b9-c1e7-08dc8458e445
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 05:40:50.0895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTpmCF0ChtzHk8mt9QjWQWpdYN1Y1Py92W+VWNKh68J24+DlprdJq7pkYDBsRulxyABOW3XHRDiG4dFsK0qYpjBqg31BbfJxpjhbujBLdp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDE4LzE5XSBpbnRlbF9p
b21tdTogSW1wbGVtZW50DQo+W3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkgY2FsbGJhY2tzDQo+
DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDYvMy8yNCAwODoxMCwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiBJbXBsZW1l
bnQgW3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkgY2FsbGJhY2tzIGluIEludGVsIHZJT01NVS4N
Cj4+IEluIHNldCBjYWxsLCBhIG5ldyBzdHJ1Y3R1cmUgVlRESG9zdElPTU1VRGV2aWNlIHdoaWNo
IGhvbGRzDQo+PiBhIHJlZmVyZW5jZSB0byBIb3N0SU9NTVVEZXZpY2UgaXMgc3RvcmVkIGluIGhh
c2ggdGFibGUNCj4+IGluZGV4ZWQgYnkgUENJIEJERi4NCj5tYXliZSBwcmVjaXNlIHRoYXQgdGhp
cyBpcyBub3QgdGhlIGFsaWFzZWQgb25lPw0KDQpTdXJlLg0KDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4g
PHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBE
dWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmggfCAgOSArKysrDQo+PiAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmggIHwgIDIgKw0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDc2DQo+
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwg
ODcgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj5iL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXgg
ZjhjZjk5YmRkZi4uYjgwMGQ2MmNhMCAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
PiBAQCAtMjgsNiArMjgsNyBAQA0KPj4gICNpZm5kZWYgSFdfSTM4Nl9JTlRFTF9JT01NVV9JTlRF
Uk5BTF9IDQo+PiAgI2RlZmluZSBIV19JMzg2X0lOVEVMX0lPTU1VX0lOVEVSTkFMX0gNCj4+ICAj
aW5jbHVkZSAiaHcvaTM4Ni9pbnRlbF9pb21tdS5oIg0KPj4gKyNpbmNsdWRlICJzeXNlbXUvaG9z
dF9pb21tdV9kZXZpY2UuaCINCj4+DQo+PiAgLyoNCj4+ICAgKiBJbnRlbCBJT01NVSByZWdpc3Rl
ciBzcGVjaWZpY2F0aW9uDQo+PiBAQCAtNTM3LDQgKzUzOCwxMiBAQCB0eXBlZGVmIHN0cnVjdCBW
VERSb290RW50cnkgVlREUm9vdEVudHJ5Ow0KPj4gICNkZWZpbmUgVlREX1NMX0lHTl9DT00gICAg
ICAgICAgICAgIDB4YmZmMDAwMDAwMDAwMDAwMFVMTA0KPj4gICNkZWZpbmUgVlREX1NMX1RNICAg
ICAgICAgICAgICAgICAgICgxVUxMIDw8IDYyKQ0KPj4NCj4+ICsNCj4+ICt0eXBlZGVmIHN0cnVj
dCBWVERIb3N0SU9NTVVEZXZpY2Ugew0KPj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKmlvbW11X3N0
YXRlOw0KPldoeSBkbyB5b3UgbmVlZCB0aGUgaW9tbXVfc3RhdGU/DQoNCkl0IGlzIHVzZWQgaW4g
bmVzdGluZyBzZXJpZXMuDQoNCj4+ICsgICAgUENJQnVzICpidXM7DQo+PiArICAgIHVpbnQ4X3Qg
ZGV2Zm47DQo+PiArICAgIEhvc3RJT01NVURldmljZSAqZGV2Ow0KPj4gKyAgICBRTElTVF9FTlRS
WShWVERIb3N0SU9NTVVEZXZpY2UpIG5leHQ7DQo+PiArfSBWVERIb3N0SU9NTVVEZXZpY2U7DQo+
SG93IFZURCBzcGVjaWZpYyBpcyBpdD8NCg0KSW4gbmVzdGluZyBzZXJpZXMsIGl0IGhhcyBlbGVt
ZW50IGlvbW11X3N0YXRlIGFuZCBlcnJhdGENCndoaWNoIGFyZSBWVEQgc3BlY2lmaWMuDQoNCj4+
ICAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0K
PmIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IGluZGV4IDdkNjk0YjA4MTMuLjJi
YmRlNDFlNDUgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0K
Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IEBAIC0yOTMsNiArMjkz
LDggQEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7DQo+PiAgICAgIC8qIGxpc3Qgb2YgcmVnaXN0
ZXJlZCBub3RpZmllcnMgKi8NCj4+ICAgICAgUUxJU1RfSEVBRCgsIFZUREFkZHJlc3NTcGFjZSkg
dnRkX2FzX3dpdGhfbm90aWZpZXJzOw0KPj4NCj4+ICsgICAgR0hhc2hUYWJsZSAqdnRkX2hvc3Rf
aW9tbXVfZGV2OyAgICAgICAgICAgICAvKiBWVERIb3N0SU9NTVVEZXZpY2UNCj4qLw0KPj4gKw0K
Pj4gICAgICAvKiBpbnRlcnJ1cHQgcmVtYXBwaW5nICovDQo+PiAgICAgIGJvb2wgaW50cl9lbmFi
bGVkOyAgICAgICAgICAgICAgLyogV2hldGhlciBndWVzdCBlbmFibGVkIElSICovDQo+PiAgICAg
IGRtYV9hZGRyX3QgaW50cl9yb290OyAgICAgICAgICAgLyogSW50ZXJydXB0IHJlbWFwcGluZyB0
YWJsZSBwb2ludGVyICovDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA1MTkwNjNjOGY4Li43NDdjOTg4YmM0IDEw
MDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+IEBAIC0yMzcsNiArMjM3LDEzIEBAIHN0YXRpYyBnYm9vbGVhbiB2dGRf
YXNfZXF1YWwoZ2NvbnN0cG9pbnRlciB2MSwNCj5nY29uc3Rwb2ludGVyIHYyKQ0KPj4gICAgICAg
ICAgICAgKGtleTEtPnBhc2lkID09IGtleTItPnBhc2lkKTsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRp
YyBnYm9vbGVhbiB2dGRfYXNfaWRldl9lcXVhbChnY29uc3Rwb2ludGVyIHYxLCBnY29uc3Rwb2lu
dGVyIHYyKQ0KPj4gK3sNCj4+ICsgICAgY29uc3Qgc3RydWN0IHZ0ZF9hc19rZXkgKmtleTEgPSB2
MTsNCj4+ICsgICAgY29uc3Qgc3RydWN0IHZ0ZF9hc19rZXkgKmtleTIgPSB2MjsNCj4+ICsNCj4+
ICsgICAgcmV0dXJuIChrZXkxLT5idXMgPT0ga2V5Mi0+YnVzKSAmJiAoa2V5MS0+ZGV2Zm4gPT0g
a2V5Mi0+ZGV2Zm4pOw0KPj4gK30NCj5jYW4ndCB5b3UgcmV1c2UgdGhlIGtleSB3aXRoIHBhc2lk
Pw0KDQpzLT52dGRfaG9zdF9pb21tdV9kZXYgaXNuJ3QgaW5kZXhlZCBieSBwYXNpZCBidXQgb25s
eSBCREYuDQpNYXliZSBJJ2QgYmV0dGVyIHRvIGRlZmluZSBpdHMgb3duIGtleSBzdHJ1Y3QsIGhh
c2goKSBhbmQgZXF1YWwoKSBmdW5jdGlvbnMuDQoNCj4+ICAvKg0KPj4gICAqIE5vdGUgdGhhdCB3
ZSB1c2UgcG9pbnRlciB0byBQQ0lCdXMgYXMgdGhlIGtleSwgc28gaGFzaGluZy9zaGlmdGluZw0K
Pj4gICAqIGJhc2VkIG9uIHRoZSBwb2ludGVyIHZhbHVlIGlzIGludGVuZGVkLiBOb3RlIHRoYXQg
d2UgZGVhbCB3aXRoDQo+PiBAQCAtMzgxMiw2ICszODE5LDcwIEBAIFZUREFkZHJlc3NTcGFjZQ0K
Pip2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4+ICAg
ICAgcmV0dXJuIHZ0ZF9kZXZfYXM7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0aWMgYm9vbCB2dGRfZGV2
X3NldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50DQo+ZGV2Zm4s
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmlj
ZSAqaGlvZCwgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICpz
ID0gb3BhcXVlOw0KPj4gKyAgICBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oZGV2Ow0KPj4gKyAg
ICBzdHJ1Y3QgdnRkX2FzX2tleSBrZXkgPSB7DQo+PiArICAgICAgICAuYnVzID0gYnVzLA0KPj4g
KyAgICAgICAgLmRldmZuID0gZGV2Zm4sDQo+PiArICAgIH07DQo+PiArICAgIHN0cnVjdCB2dGRf
YXNfa2V5ICpuZXdfa2V5Ow0KPj4gKw0KPj4gKyAgICBhc3NlcnQoaGlvZCk7DQo+PiArDQo+PiAr
ICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKw0KPj4gKyAgICB2dGRfaGRldiA9IGdfaGFzaF90
YWJsZV9sb29rdXAocy0+dnRkX2hvc3RfaW9tbXVfZGV2LCAma2V5KTsNCj4+ICsNCj4+ICsgICAg
aWYgKHZ0ZF9oZGV2KSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJJT01NVUZEIGRl
dmljZSBhbHJlYWR5IGV4aXN0Iik7DQo+cy9JT01NVUZEL0hvc3QgSU9NTVUgZGV2aWNlPw0KDQpH
b29kIGNhdGNoLCB3aWxsIGZpeC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPj4gKyAgICAgICAg
dnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAg
fQ0KPj4gKw0KPj4gKyAgICB2dGRfaGRldiA9IGdfbWFsbG9jMChzaXplb2YoVlRESG9zdElPTU1V
RGV2aWNlKSk7DQo+PiArICAgIHZ0ZF9oZGV2LT5idXMgPSBidXM7DQo+PiArICAgIHZ0ZF9oZGV2
LT5kZXZmbiA9ICh1aW50OF90KWRldmZuOw0KPj4gKyAgICB2dGRfaGRldi0+aW9tbXVfc3RhdGUg
PSBzOw0KPj4gKyAgICB2dGRfaGRldi0+ZGV2ID0gaGlvZDsNCj4+ICsNCj4+ICsgICAgbmV3X2tl
eSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tleSkpOw0KPj4gKyAgICBuZXdfa2V5LT5idXMgPSBi
dXM7DQo+PiArICAgIG5ld19rZXktPmRldmZuID0gZGV2Zm47DQo+PiArDQo+PiArICAgIG9iamVj
dF9yZWYoaGlvZCk7DQo+PiArICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+dnRkX2hvc3RfaW9t
bXVfZGV2LCBuZXdfa2V5LCB2dGRfaGRldik7DQo+PiArDQo+PiArICAgIHZ0ZF9pb21tdV91bmxv
Y2socyk7DQo+PiArDQo+PiArICAgIHJldHVybiB0cnVlOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0
aWMgdm9pZCB2dGRfZGV2X3Vuc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3Bh
cXVlLCBpbnQNCj5kZXZmbikNCj4+ICt7DQo+PiArICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IG9w
YXF1ZTsNCj4+ICsgICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGRldjsNCj4+ICsgICAgc3Ry
dWN0IHZ0ZF9hc19rZXkga2V5ID0gew0KPj4gKyAgICAgICAgLmJ1cyA9IGJ1cywNCj4+ICsgICAg
ICAgIC5kZXZmbiA9IGRldmZuLA0KPj4gKyAgICB9Ow0KPj4gKw0KPj4gKyAgICB2dGRfaW9tbXVf
bG9jayhzKTsNCj4+ICsNCj4+ICsgICAgdnRkX2hkZXYgPSBnX2hhc2hfdGFibGVfbG9va3VwKHMt
PnZ0ZF9ob3N0X2lvbW11X2RldiwgJmtleSk7DQo+PiArICAgIGlmICghdnRkX2hkZXYpIHsNCj4+
ICsgICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiArICAgICAgICByZXR1cm47DQo+PiAr
ICAgIH0NCj4+ICsNCj4+ICsgICAgZ19oYXNoX3RhYmxlX3JlbW92ZShzLT52dGRfaG9zdF9pb21t
dV9kZXYsICZrZXkpOw0KPj4gKyAgICBvYmplY3RfdW5yZWYodnRkX2hkZXYtPmRldik7DQo+PiAr
DQo+PiArICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiArfQ0KPj4gKw0KPj4gIC8qIFVubWFw
IHRoZSB3aG9sZSByYW5nZSBpbiB0aGUgbm90aWZpZXIncyBzY29wZS4gKi8NCj4+ICBzdGF0aWMg
dm9pZCB2dGRfYWRkcmVzc19zcGFjZV91bm1hcChWVERBZGRyZXNzU3BhY2UgKmFzLA0KPklPTU1V
Tm90aWZpZXIgKm4pDQo+PiAgew0KPj4gQEAgLTQxMTYsNiArNDE4Nyw4IEBAIHN0YXRpYyBBZGRy
ZXNzU3BhY2UNCj4qdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUs
IGludCBkZXZmbikNCj4+DQo+PiAgc3RhdGljIFBDSUlPTU1VT3BzIHZ0ZF9pb21tdV9vcHMgPSB7
DQo+PiAgICAgIC5nZXRfYWRkcmVzc19zcGFjZSA9IHZ0ZF9ob3N0X2RtYV9pb21tdSwNCj4+ICsg
ICAgLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UsDQo+PiArICAg
IC51bnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3Vuc2V0X2lvbW11X2RldmljZSwNCj4+ICB9
Ow0KPj4NCj4+ICBzdGF0aWMgYm9vbCB2dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUg
KnMsIEVycm9yICoqZXJycCkNCj4+IEBAIC00MjM1LDYgKzQzMDgsOSBAQCBzdGF0aWMgdm9pZCB2
dGRfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvcg0KPioqZXJycCkNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19mcmVlLCBnX2ZyZWUpOw0KPj4gICAgICBz
LT52dGRfYWRkcmVzc19zcGFjZXMgPSBnX2hhc2hfdGFibGVfbmV3X2Z1bGwodnRkX2FzX2hhc2gs
DQo+dnRkX2FzX2VxdWFsLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZ19mcmVlLCBnX2ZyZWUpOw0KPj4gKyAgICBzLT52dGRfaG9zdF9pb21tdV9kZXYgPSBnX2hh
c2hfdGFibGVfbmV3X2Z1bGwodnRkX2FzX2hhc2gsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfYXNfaWRldl9lcXVhbCwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdfZnJlZSwgZ19m
cmVlKTsNCj4+ICAgICAgdnRkX2luaXQocyk7DQo+PiAgICAgIHBjaV9zZXR1cF9pb21tdShidXMs
ICZ2dGRfaW9tbXVfb3BzLCBkZXYpOw0KPj4gICAgICAvKiBQc2V1ZG8gYWRkcmVzcyBzcGFjZSB1
bmRlciByb290IFBDSSBidXMuICovDQo+VGhhbmtzDQo+DQo+RXJpYw0KDQo=

