Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E95AC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 03:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRjZd-0002Ie-Kq; Tue, 17 Jun 2025 23:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRjZa-0002IR-T2
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 23:34:50 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRjZX-0004nh-9S
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 23:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750217688; x=1781753688;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WxlvpoOfPsrsFhToU+DwSB7QWJIkypDuZVHhM5lje2U=;
 b=bdMC35Flb1JLkUQi2JeMIpa3WZjH3/pXRFm6jpWf589UxSP0fp3jgpk/
 J3HknRmO6O+i/v04wCC466HYdNtAX+XY16NujbTYVnqHDzS/oFVOpV5DG
 ROW2Wh7Kngb2Yrl2zYDBt8Z2aaggbY3y6wkQ2g8aq1+UQoKKehF1rmrwF
 sXaZGqDnlDirbpGeyt8ymlZZA6RF3AYDen1U9lQppB3sJC7YmK+pUJPVi
 2Y7UdsTRenjOFSyXOcXXcO8+ZErLc3O0HPN9xJA1/djfhUJYn+7K5EziS
 A2fCSAY3c9BC26qPcU2e+0eGVPs1lAbRysAsnqb46Gh+c+5/WyOdMeK98 w==;
X-CSE-ConnectionGUID: iDrQbJzBQk2L/d7JtoFqeA==
X-CSE-MsgGUID: SByFasqNSQeKphVuPdXP0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56092881"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="56092881"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 20:34:41 -0700
X-CSE-ConnectionGUID: JLPKbsoWTiaK3svpiklQ8w==
X-CSE-MsgGUID: teqaV5VSTNWaoZEKSZa5OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="154010921"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 20:34:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 20:34:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 20:34:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 20:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMtMdJxCpcN7sSwA3/85fczzb1/qn9X78jFYbWAt5gkfJUD/cjxDGa8UwdHmNHyM33rr8/sn/Y+Al3Mre6tLeB/4rMhvM4L1PfSi6EOE/v8Xn+JOwNby0Vj9Eg6n0c5ReFDCMwcCX8NIlteer3DsBq4J2m8a3/vnSP1sxCZbNKzDx0MIIsyFAJ06q6KVdaMSFIoxw/FMYuGiHc4xjVnsTt88J6sTtrxJAWo6lE8Jr68czSNnw5vju/Ov/0zCxrxynPB01hSl/TA5TnwGGaixhKcDJ85/xg908/CuQ11bOf8sKmlDyiUd1NWXe74bgZAzpLPJZNloG3UvVL7sWlC2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ezZtT00juAVjzsN+fH/7FOaxTql8CdjB6RJvBNRv4M=;
 b=fKQ+6up0DpEDeo0Eh1DYB8Uv+31uHvn3jBMNTnnytHcClDqHfGVIWorFVR6SFJtwEPL3FChej3OQCrCAoUZ1vH5bHEyG+dFaaW8flRpVcjNqg50nVf8LppQzHiNojHEx2xEP7vbQ27DsaE+VR2SZsIseaKRdB539tb81XKiMu79PfPNj0Muc22MqHyjtilI4TTB0tMmi1lXSA5VCjHnos3rudWIhTCK0rxynf1Zs28FDcSkKHsGmgcrq6Ousj1ciDqO2BvRsYafJde5561OlYuINNlNx9yGITvXMvqqzbS6gGV4sXONDG5u/DPkq9o3bmS+frUT2dCWH7aot6/iVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 03:34:33 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 03:34:33 +0000
Message-ID: <6a9f95b4-3e56-4ed3-b2a2-c41a6f728eb2@intel.com>
Date: Wed, 18 Jun 2025 11:40:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aE+wCIG8KHb3u1lV@nvidia.com>
 <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aFDdkxPODYnyG0Vo@nvidia.com> <20250617123707.GW1174925@nvidia.com>
 <de5baefb-515a-47e3-9e4b-16bca4dbec5e@intel.com>
 <20250617131113.GX1174925@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250617131113.GX1174925@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU3P306CA0008.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: 587d9db9-8ec9-44c5-b7bd-08ddae190a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzhlc0oyeGhFMWpHSTlIbld1eEpvZ3VIODlLaS9SMVBFTUwrNk96VWQxR1Ex?=
 =?utf-8?B?bFVTYzBxT3NHWkJRVU9qazdQWVphK0VkamFWaFR6WUlITTNTR05Kc0xHQTVV?=
 =?utf-8?B?aDBSQi9uWWF1YlRwTWowcG1QaFUxcldERTRRek91LzFqNVBid3F2eXNoSXgx?=
 =?utf-8?B?Q3NMcENCT25FWHp4WllMallCS05WNmprb0VGYXpoYTBPNmY3YTV3U2hPamdO?=
 =?utf-8?B?SVpsOXpaUUZwK1UrNzFZdkJWNW1iR09UTkxpMFZCRGNSbE5FRHg2bzNNMXBo?=
 =?utf-8?B?SGRqbUN2QnpYS2dPWndiMGRXVEI2MDk0cnpTWVBWYlBwaXZlczVNak14Wnk4?=
 =?utf-8?B?bXRGZncwaE50MWxnMmRvMS9EWGUzaE4xVTIxc3dLR0JrenRKdnYxS0NFc2JF?=
 =?utf-8?B?Y0NhNVVWYU00SUl0WVFrdHgrNEJ3SUpPNHNqSWRnQ1lQaVoyTFF4WmFEQXFy?=
 =?utf-8?B?TW9ZUUx2QkhGMGh4TVEvRHc2bWdybDViRWhHNEdmMllIM3hQeEM3dk1NTUhy?=
 =?utf-8?B?ZXdBZXlvdzlFM3FZVmxwVUVqZmJCL0tvZ050VXFqK00yUnFxRUJ6Qkp1RDVm?=
 =?utf-8?B?U2pZbkZXY0hwVk93emVMS3VzcTBjb0ZqaXhVS2krVkoyYnhZMDA0VmlkUjRm?=
 =?utf-8?B?UlptRHJ4djR0UFo2RVA0L2djUVIyMjdQbVdIMkZHMGFHcWU1YllZWDh5bTZj?=
 =?utf-8?B?dTRBV29DaVpiM2l4RkllRjJySi91VmFOTS9PeEZWZGNMSkhqT1NXaXI5NWdZ?=
 =?utf-8?B?ZndhQVVmTDYyWlg2LzVjaEliZmovb0M2bjY3Ym8wR0dJWmlPbzU1Z3Y3RzRK?=
 =?utf-8?B?Nk4wVVZ6KzAwLzFoZnVmRWM2dzhwSDQ0WnUwUXFmT0F2MVZlU21kMkVOa0gx?=
 =?utf-8?B?V0NFVXhpekVrRmQyS2U0R2RXWHFCRS91bGhaaDhLdGNHdFJlSjdIOFdtQ0px?=
 =?utf-8?B?VkZseFUranZ2b2c5bTh1MytRck1KSVk5Z2YxZ3VEUUZodzZTbGFPVUlLTk1v?=
 =?utf-8?B?Y3RNWCs1eFF4V0QxZnlVS0FOWDkvWVA2bDlZQUxFcXdPYUg5WFFLQW5CMmVo?=
 =?utf-8?B?OS8wVnRYcWhVS1kwSFVvNDFNTkhCK0VsN0hxN2ozNENENE0zUmxiQzFnOUk4?=
 =?utf-8?B?Q1NQaUlVUk5SSVppR2ludTNzd1ZqQnM5Z1RIWGRWOHdGeG9lcGE3TlhjNVIw?=
 =?utf-8?B?UUd1SVlPRkEvS0RoMk5nNU02QjY5aXNSb0dhWWV0ZkVwNEJIam9USGhNT3Ft?=
 =?utf-8?B?S1FoT2xnd1VoV2xmTUpCdy9QRWVEMFhmL2FCYkhLWmQzdW13WWxidjYvOWFp?=
 =?utf-8?B?TW5SMzVQbUptZTczaUtJWE5hQlBvY0NxK3N2ck5kbjZZbDNaTGdFdzI5aHJy?=
 =?utf-8?B?NzVMdlRtVzRueXVXWHdSeWZCeTJDL0VsM0Jvbk0wMVdMdXFvUExhUUZ1cktR?=
 =?utf-8?B?K1o2ckF2WVRPalVYYk9CekttWmF2TE9heHVTTkxLUE85WW5tWE5OZVd1Y2Za?=
 =?utf-8?B?YW85Z1M5S0JzRVg4U3VSL3VJSk5TZ2taZUlCKzZib2dJNnM2REJoMkFIdGdX?=
 =?utf-8?B?ZHlXbFM2K1dnUGlBTmg0MUR0bWVEc2FIVCtIRWFOY2I3MkFRaUVsbS83UkVR?=
 =?utf-8?B?b2JYeEZhZEdJV2Q3c0Y4NHlYWFpUNjFOSUxaSWxrU0tpNVozZDVhSU1NTVNT?=
 =?utf-8?B?RjdnK1g3bE1GdkNVc1UrVFJnOEVZVHpsWW93Q2FqNU1MYklYQnA3OThuTmNM?=
 =?utf-8?B?bGx6dGRxSUp3VEFjbjBsc09EeXRPcFYzVmFld2hzTDAvU2VPbGhJc0RURHpZ?=
 =?utf-8?B?ZHpwOWdZckM3aHNtM1JiYUdqSXpNM0R1OEE2c1lNY1hlTHovelJiR3ovL2tQ?=
 =?utf-8?Q?UGrgmu9oaVUBV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnpBdVEvV0J1NkIwNnZFS09aeGZqcFBRYndrZjJ3OXlKeDZuMmh3WFl3Uy9t?=
 =?utf-8?B?Tkl0aksvRFgvWnRBcEZ2RktMZWdyaThMeG1naEZMY0lMN2NzQkczMWM3eVJi?=
 =?utf-8?B?VW9xTHo5RkxqRVBRRUxUM2RCSnorNTlIamhxRFo4ck96dGRBM1dLQlBOZ05D?=
 =?utf-8?B?R0d5QzlYaWV4TVd0WDI3R3BIYVNkN0doa0d0UlRXODhFUWJySlpHUDhkMzNi?=
 =?utf-8?B?VXZqNmRzWFYvbm0vSEVDdHpxZjFkVTRmOFZ0UE02aW1oeGN6elFZYjliVjlp?=
 =?utf-8?B?Y09XTXlNZmU2ekl4ZUdCTURXUzQ3ZlJnc2N1eG9qNE5OYkx0SUtya0NWcFJI?=
 =?utf-8?B?YzRkWUx2Qm1JRjVZN3ArMG91b21TQVBKMDZSU1UzSHV6TkF0dkoxdjVHTmxF?=
 =?utf-8?B?Tk1lSlZFeHYybkJ6TldpTkRuMkV4clJEYkVVamR0NEoySkZlTlRaVEk1UU5L?=
 =?utf-8?B?WVdaUlpGT3YvNzZtNzJyd01US0VoMm1Nb0c4S3VjNGdGR01seTA4d1k4TDJu?=
 =?utf-8?B?Y3J0djRFa2N5cWRuVENNc0wrR3FQS2dLMDFEOXdUaWJXS1NaeDFQeVlwbWtH?=
 =?utf-8?B?T0N0QXdRZWtEdXpxS1FucmhPV1V2bHlLd0VVQlNkL1dFVmhOczJyZFBYZUxp?=
 =?utf-8?B?MXI4YnFaVFk5WTF2L1ptdnVKSzhPVlVPNUxxMlRYT1BSTTBEUE5FMlJMRlE0?=
 =?utf-8?B?TjhqczBNeGlaYkRWUG9zRExCRnRENlJvNUs4ei93NHArUUtYQkI2UkoyZmVC?=
 =?utf-8?B?UVFKd0UwRm1ucXFlYUN3WUJOMHNPRUhleWtYUDFaWE9SMVBrWHZ0ajdqaXhE?=
 =?utf-8?B?Q1RtTVNSWS9rc0tKNTVvMDJ0cnNBSm9YbG5QNUhMMGxEckt3dy9IdzRaRlo2?=
 =?utf-8?B?VmlBNnNTakRHRjZsVmtCR2JXL3NyV1UzYWZNU1pKU2ZORjJhenNUTnZlZ1V3?=
 =?utf-8?B?bVkrV1JnMUw0R3A2VGJ3VVVrSDljVWd6dm44UDFmcXRhZ0haSTFBR1drNWNL?=
 =?utf-8?B?dVB3RUlCeFFObkZaTm5oV0ZvU1prWlB1QUk3bVlkVlFWN2pOeGl2Z09ka3U0?=
 =?utf-8?B?KzVjV3RJT3NiVGh4QnJ5bzQvZmtRZU9uYzhYeDVxTktuUUZpZC9FUVBxdXYy?=
 =?utf-8?B?bnN4UW1td0E3MVppL0tFT2t0OEhHVzR0Z25laFlySkNWL0h2OGYzbU1mL1Qr?=
 =?utf-8?B?VDZWaU1OU1FuNFNmeVpMZDROVWdEVklvN296bEtLSmZScjB3N2JTYlJoMVlX?=
 =?utf-8?B?UUxjelZCSUlIVW9HMVdMaDMyZlJRUDlya1cyYWVmQ21uaG9hUlJmSlFnZkVC?=
 =?utf-8?B?Y2ZXMWhWZVlpR0hPN0JYK1E3Y0UySk94d2lNQkdCRkJ4cUJyUHBrWEF5M3JM?=
 =?utf-8?B?RGFRalQ5ZllBRnp3em91Zno5blg5RHVIa2FoQWpsYXZuQ0tRclVZUnMzQWpa?=
 =?utf-8?B?b2JneFQzUllTUWJENnJBOHlrSzRYeVBUM1BvMXE2SHE0T1lnNFoxeWk5aEZm?=
 =?utf-8?B?S1RVRU5EajQxM0RyMVMrS0lDSmhqaUNJZXZCUlBEc3hFck5mWWVsKytRZWhS?=
 =?utf-8?B?UWx5NloxKzJCRE1yK2ZvNjdaRm5pZ1huZ0lBdnFUQ3lqRVhoVkVMdFRWNDZi?=
 =?utf-8?B?VTNYbU8yQUdLMUFUSmxlOW1jcE1TWXFVemxwbEw0VXhQeWF4S3hWVFpYcm5T?=
 =?utf-8?B?YXczODdqOFNmUWcwUEwzTVlMUjhKYjNyb1Zra2M1V2JCWndGdkxlL0dZczlt?=
 =?utf-8?B?OUJNbTdYZFlPR1ZKaEozY2RTNHAyUndwcHN0ektFUCtFeTB2b0hrR2RwR1dX?=
 =?utf-8?B?YW5tY1paRjhwZkpta1VseUM2WGtoZ0M0bUVQa0NLT2JTVnhiSHVUWnZPS3pF?=
 =?utf-8?B?QUhLSnB2NjlySEE0YjU2WHlUT093NTFaM0lCZzRvNnBFM3MzNHIvZ1FOOEV6?=
 =?utf-8?B?S0pGMEZEclVnd2svSnBDbHNUaEpFZXhtTmZSV2pIdi9xYWZXOElPRlJUb0dI?=
 =?utf-8?B?OHZaVXhiYXNRVHBWUmE0RkV2TmZqZXdkUVhSQ3E5NnJkcURyd1dBbk1CNFR4?=
 =?utf-8?B?Q1FZK2RPVjVLMlVnM2llbTA4Y1c0cW1ZUnZCdDlkQnFEVWR0ZGQ2cWxoOTUw?=
 =?utf-8?Q?iprXMzdbwikANn0PdwtTL7RlQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 587d9db9-8ec9-44c5-b7bd-08ddae190a8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 03:34:33.5591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd5H8lz4wcZSp8Yde8fmHEti8KAnfrvKJiSDafMTBPPgCGKSVIKCxkuJiPx/UchOWWgMTgSB7uTZ8JQSd7rMhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

On 2025/6/17 21:11, Jason Gunthorpe wrote:
> On Tue, Jun 17, 2025 at 09:03:32PM +0800, Yi Liu wrote:
>>> I suggest fixing the Linux driver to refuse to run in sm_on mode if
>>> the HW supports scalable mode and ecap_slts = false. That may not be
>>> 100% spec compliant but it seems like a reasonable approach.
>>
>> running sm_on with only ecap_flts==true is what we want here. We want
>> the guest use stage-1 page table hence it can be used by hw under the
>> nested translation mode. While this page table is only available in sm_on
>> mode.
>>
>> If we want to drop the legacy mode usage in virtualization environment, we
>> might let linux iommu driver refuse running legacy mode while ecap_slts is
>> false. I suppose HW is going to advertise both ecap_slts and ecap_flts. So
>> this will just let guest get rid of using legacy mode.
>>
>> But this is not necessary so far. As the discussion going here, we intend
>> to reuse the GPA HWPT allocated by VFIO container as well.[1] This is now
>> aligned with Nic and Shameer.
> 
> I think it is an issue, nobody really wants to accidently start
> supporting and using shadow mode just because the VM is misconfigured.

hmmm. intel iommu driver makes sm_on by default since v5.15. So if guest
configs sm_off, that means it wants it. For the kernel <5.15, yes it will
use legacy mode if it has not configured sm_on explicitly. So this seems
not an issue.

Actually, as I explained in the first hunk of [1], there is no issue with
the legacy mode support. :)

[1] 
https://lore.kernel.org/qemu-devel/20250521111452.3316354-1-zhenzhong.duan@intel.com/T/#m4c8fa70742001d4c22b3c297e240a2151d2c617f

> What is desirable is to make this automatic and ensure we stay in the
> nesting configuration only.

yes, once QEMU supports nested translation based vIOMMU, it's better to use
sm_on instead of legacy. I think for the kernels >= 5.15, this automation
has already been achieved since sm is default on.

>>> ARM is cleaner because it doesn't have these drivers issues. qemu can
>>> reliably say not to use the S2 and all the existing guest kernels will
>>> obey that.
>>
>> out of curious, does SMMU have legacy mode or a given version of SMMU
>> only supports either legacy mode or newer mode?
> 
> The SMMUv3 spec started out with definitions for S1 and S2 as well as
> capability bits for them at day 0. So it never had this backward
> compatible problem where we want to remove something that was
> a mandatory part of the specification.

got it. yes, it's all about backward compatible support.

Regards,
Yi Liu

