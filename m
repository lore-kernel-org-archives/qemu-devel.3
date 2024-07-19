Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DD8C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 03:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUe9D-0007Fy-3B; Thu, 18 Jul 2024 23:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sUe9B-0007FL-Ig
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 23:19:05 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sUe98-00050P-Bc
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 23:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721359142; x=1752895142;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Bb+Q3K3ZWa5KQ0GweV8fh2efpnz3T6vnRRdrKcMknhY=;
 b=fRZpAJdKyA0sXAoo+V0D1ZpVgnMhIeDRulYT8lO5MfZoRNOMHV8Gu941
 DmkrhoaRVM488rbYlgHZpftaK9ZLQKnQdbs6jseQm/4oP+yFTdzQBbsPA
 OeHr2ieZx7aQc7srH1MDVgvqYP61Rg99AOMo9PyFZNiVC06I1gFaFFy90
 BjRKUe27K+Q4TiEiw9c991MiP2lvQvAqe04jHwZlnz4t2wiJuwjk6sK9d
 MfaVJH6W6/tFU15XX79HkUyGZZohfMKtoqnDezY4EOigiGDhXVAO6gRvy
 Hyv8kiKJc8h5bc51NNr7TTkehljK2PRHGwCmkgwUPoEdzGkBHDkyzl22V A==;
X-CSE-ConnectionGUID: CSQpR5nxTIyzkpPqHsLUWg==
X-CSE-MsgGUID: lyv/pmIFRYyE+9TljS4QlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="44380637"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="44380637"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 20:18:57 -0700
X-CSE-ConnectionGUID: xkglREsAQTa+I6L2dIIHZg==
X-CSE-MsgGUID: T5+EWAvvRlKMi8eJQQvk9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="51014731"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 20:18:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 20:18:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 20:18:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 20:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w40efb/819VYnU4hGUAmzKstN9D1KXRmZllpzKCQ8o5WnwPqOu0aDV1+7t4FBB1a+kFHjJryl9kQ5/O89B0IvTqkxIEcLPH3V2MSEMFOHKrRKmUBooxnIM5VT/JSKdVaxl7mcS0mUFJpamhHCF2SBcj0XdIpSvHwP14GxGaaRRg2y5/MHd+SGhMhEs93kZvhS9Xcupq03XdEGJv4So2seHFyP7yTQnO3JcU+rE6JUF3+4sW1NDuUtbLeMJ0tIP+xUw7Hrhc3tBvrpMixO8Eh4FHqCLyq2KIb0mLhHDEJXuTw7q+WzAo8YSiZB3q1S46VUnsUBYgM5/aB0z8owFPbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYXrBiCUm4yE3Yu20EGyTawzl5wYbcPHBftVpioybq4=;
 b=DCS2Wpr+pFiei4m87JAsh3fxh+lAOxI7e7cDGWXueqSoNRs94Ni3FAysOPjEWpEwDZCBVjoAGRpt4VhjzWVUhj1gy8mry4gQD8tr3vpgFGquDWR2vLxFH4xg1Vc+ZZBE4CRC8ZkKw0EpzIwepZnkkjk5k7I3zZN0E0PkCQEDd+LCfbyFx0jpbj88FEWlOeWoaaarnxQfAIqepjnN6s3zUPOMJCOlCywIyd5Mp4OGwGzX07kdSwKKHwQLNhHZlZKJJjcaDD7eM52PoWPsFAcrpIMjdd/cHGQEGkLEiH05aWSk8+7B0RhsP60tbvAdxm121W/dUyhm2LY0halsTFCKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 03:18:51 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 03:18:51 +0000
Message-ID: <9c9dba22-df29-4121-8126-4707084b891b@intel.com>
Date: Fri, 19 Jul 2024 11:22:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
 <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
 <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b927ae-8519-4a08-e7ba-08dca7a18370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFJTVEpKa2Yvam9VTFpwT0lHLzJhZFRHb0tvcGhHaWhDeFlxS0c2dXloK0ln?=
 =?utf-8?B?Yit5aDhiR2grVzVmbHI4cE50L2pidExvOHZjWGJqZzJLNnVORE5yR2poSlNL?=
 =?utf-8?B?QjVucFgvMmFMcFZXYlhrektrNWJCSnhFVEUwamkvN0dMcjZ0VWNGMTZUNmFB?=
 =?utf-8?B?R0RZYldaSVllaWc1N0tyZzhFSlR3OFlyRXJ3OWFCTlM5aHVJTnR1N0cwbWQ4?=
 =?utf-8?B?ZmJ5QUVpSzlvdm5obGJPSVVrWlpqem5ZOURCYVZpWTZqUzhGKzlpTFd5UkFh?=
 =?utf-8?B?dExvYktMeHpMTTVQa3pXb3o5MjB5TVlDSjlMYkpEc2d3aEdaTmhGYjlDK3Zh?=
 =?utf-8?B?dUxHNTRvWGhRUDhXbCtYbUFFQ0xnZk1odWFtQU1KRVdsQ21oRUZYcDF4c1JI?=
 =?utf-8?B?dTVObmpoWGFpL2IxWWtkV0tTMWNIOHhEWFd5Vy9HS1dLa3VsQklaV1FtMFdZ?=
 =?utf-8?B?ZlpLYWM5d2QzRXZLUUsvd2pQa3J2MDFKaXBwcjF0cU5TdXFJR1BnYXJ3eWYw?=
 =?utf-8?B?NmhJUHBhaG5zb1ZSQ0dFdDZoY0V0OERvYVBPL3NYcnBEUU9BSmtLcFVXTXdX?=
 =?utf-8?B?d25xaEtIY1dlUjVxRlRWYVNZcnc4U1E2NGU2ejYwQnZuUnNaWTZDMkRmeHRL?=
 =?utf-8?B?YlJubGI5V3JSU3hnUVBheTNtTTJ3ajMzNHQ3Wm1ZR3VLVEhodnpFY0dTYjZt?=
 =?utf-8?B?UDdKOU1WaUljSFhWWEE5citEUUwxME4yVEs4MGpiSjZVNDM5SktTZ3k3Vjhr?=
 =?utf-8?B?YUxlelpleTZteVVpSUsvbmdISDNseWd3d2t2NHAvZ3B1cm50QklzVllWT0FO?=
 =?utf-8?B?bW9QWDRBUjhTTGphckJXM1Z1SHVXYm1SOUxIY2V6MUR3ZG1JdTNUTTExaFhk?=
 =?utf-8?B?SmRwcUJLV2JDYTlEcHRSdCtDbzFMS1pHREh6SmtXSE9zbFQxQ1d2UEp5TEYy?=
 =?utf-8?B?djJkZ043a2JTQ3Nucmk1ck1SSFlDMDJ5S29PRG5oQ1FnN0lKMS83dWhtNkNX?=
 =?utf-8?B?Y0FoYjVwYkg1U2ZVWHAwQlJ1NVRBWUdmTTBFeHRjMWpRcEJmeHNoK2JDc244?=
 =?utf-8?B?VS8zUXk1S2ZTZ1FHMkxpRXFrRS9Zc3c2UDJUTTBtUTZaK1FJM0h6VHJCb0xQ?=
 =?utf-8?B?WVpUZlRuR3NhN2VoMUtwMFpHcVQ2V2FJK054N2JOdzJqMjZCcmlCVnRQc1dK?=
 =?utf-8?B?ZHp2VVpwb2FKZFZUV3llZHlSaEtPaXA5MCtzZDJHQk5McDRHSjRPOXlBaWli?=
 =?utf-8?B?NzBnalRuV00vUGlFaWhlK0hER3llOEN3eEFCR1kzajJYTVY4d2dWSk5hQjJv?=
 =?utf-8?B?RzBtb0cxNEMzWEp2eGNQRDA0RVNwZUx1VFUvd0pEMmJkTTRBdmN0d2RnS2d5?=
 =?utf-8?B?ZkdaNzFNdjcvYnFrdEl1VVErK2VmNFd0MjJLVVZWMXRaaGsrUEd5TkhBNi8x?=
 =?utf-8?B?Q3hEbDQ5Z3lCNDhFWTBLYzU0Um1LOUVIWTB6Mk50cW5tbnFYM3pTazlNcG0y?=
 =?utf-8?B?aE9yY25KUndxQVNNYTlHL0ZnR3pMcnIzYUkzNWxMNFdZYS9VbWd1cWxOSXBP?=
 =?utf-8?B?UGpKQ0Y5WVFnQTdwMlpzRTdXRnNUampvdUFDdnRLaERudCsrSVYvU3lzNzZR?=
 =?utf-8?B?UUhPY3BHajlsM2FtQ2VkT3dwQkxaL3V4TzZraFlnc0ZzQXdGQmNGSmdqdDV0?=
 =?utf-8?B?Tjh2dzJ1TVpzZ1NTRnJDU0QzN3NYaDJqUm1sbHRubVg0ZVpQUmZKWlg2ZjhV?=
 =?utf-8?B?d1kzeTJNSUh1M0NCRFdmN3hsRWZuMUdUVXBxbUZXVTVNZHVIZkFUczVzY1Q1?=
 =?utf-8?B?d1YwLzBtOGFoQXI5T01aQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7540.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHRMLzBEazRJVVVadXhXVFBMU21aSWREanA3Yk05VmJJRGFYdWROZEFMK21U?=
 =?utf-8?B?a3BKTjZ1RUNZelZ5Z1hQTExId01QQ1ROMFVEZ3NGRklzRlBwNWYycStRTHo5?=
 =?utf-8?B?S09iM3BZUncyeVhiQ2ZaeDlKZGROcXc5WlJoTGhqQ3NoMzNLWjdFcUlqVWlT?=
 =?utf-8?B?dExCd2RKWC9abU91elk0Y055SG9aR2VoTWtkbGQxV1ZNbEozcGpVcVpjK05v?=
 =?utf-8?B?cHFZWDlHbEc5M0xSYktPMXZHdU1QTGpBVW9ZR0F0WmIvUHo5OExJeFZhZlMx?=
 =?utf-8?B?Tms5TWRVazJNV2xHYWxFUlBsbWxlUk9FM0sxSlN6YWFhTkNuU1FTWmJ6WWEr?=
 =?utf-8?B?UUoya28rNnRwVUlLeUhPZlRsNFZzRmJpK2hnNFBXalBGK0lsbXF6S01pOWpO?=
 =?utf-8?B?Z2FwMWd5MFZsakQ4TWZyYjllVlRjYlJVNGhaL0RBNS9nZXNWQ2xyQjI2aER6?=
 =?utf-8?B?Rlh0SFZZb3BlRDZMdHIrNy93SUNBRHlXYVNRVE0yUmt3eXQwdEVwMVdDOFpm?=
 =?utf-8?B?dTEwUzVQVEVlaFhleXlHcTJiUzBabC82bitvTnZrOVRtbjZDU1RJUk9kY3px?=
 =?utf-8?B?ZmNKTWo4YldwZWxPanNrUGxBdmwycVUwRGZUdFRPeXBjYWxPbjVwNzhsZmVU?=
 =?utf-8?B?czRKRm9EckhNWmtrZ3ZlT25FeTYvaFMraithVUFMYStrVmdvVE5wczM5Q2lO?=
 =?utf-8?B?Q0RMeSs3VXNmVkUycWxWRHBNL3N3ZVFiRkRrMUtVRlh4MnJDeVBuTGlYT0Zm?=
 =?utf-8?B?Rm5kS2xpOHk3Z0x3ZVZrYlEvVHZIa3pGOFlSOGF1N2lkUTBxcFA0VEoyK3pp?=
 =?utf-8?B?QnU0WE5ncVdENW1aSlBWMDdyVHQrQ2pYMG80ejNZc2I1KzhQZHBkdDNpM1h1?=
 =?utf-8?B?cGczN1kzSG54d2M1aUd2THNaclVRck90YzhBb0NUQWZnc29iR0hzZWFpNDNH?=
 =?utf-8?B?WnN4QVBtaS8yL0UyckVnZFI4VzZHb0FQcUxUVFh0dTlBUWsxbWVmUWZOdm91?=
 =?utf-8?B?RE9IUnZwVDNzZzE0Zk1XUmpVdlQ3Y0s3TnAwK29qdklHanZmZ2htZGdQaWRH?=
 =?utf-8?B?RUJsYWdOeFdZYmZoTXR2dElLL08rUnN3VHhWZ1BNc2doODl3K1U1SHlsQldy?=
 =?utf-8?B?L1RuaTdFc1hqaVdaQWMrVHp0ak9mR0dHSG9xWnBaYlQ1dm0wK0E2V0p4NjZl?=
 =?utf-8?B?R3JuV3RMU3pFWUpOUEgyeU03VWVRZG05WFE5cU83VkduRWhQVGcwRmxlM1M5?=
 =?utf-8?B?OXF1WW9NeTJ2bFlBeDR5a0Y2M3FWNksvRW4yYVI4MlNMeUJnbUxyWlNjZWYx?=
 =?utf-8?B?T3ZLZy9ySDZ5aFlJOGFuMFVnTUcwUjJQSGVLUW1pVEpKN29Sem9uSG1xc3ZY?=
 =?utf-8?B?RkFmdTBEVTB5eGY0QlU1Ri9xRmVqRW0vMC9jU2N5a2hKNXhJYU1XU0xnMDFP?=
 =?utf-8?B?SW9qeksyS2d2OWVQZ29GSk9uQ3FPMGZFZFZOLzMvQTFYNXFGOUFxYlZYeTMv?=
 =?utf-8?B?Y3NPaERHTHZ1V2NqaVRuRm1Jd0gyTUNZMHFWV2FVRld3d2dSYkE5WTJOS0po?=
 =?utf-8?B?Z1dodWZZOEtyMnVhR0U5TkxyaDNOaGhxL2RLc0pnNGRYNTlDZUdsVHRDOXo1?=
 =?utf-8?B?U2lTQkZQbFdSVGxwc0JrQkNnTW5KY3ZWSjNzQW4xTVo4THIzRjRMT1pNYm5H?=
 =?utf-8?B?WldXVFowQ1V0UEpEaG8yajdwUHBrTVNSbldMYmtYZkFLWFF1OTV3dVdoaHhB?=
 =?utf-8?B?V3lOSUpiangwaEhVb0pETHpwQldmRHdyNmhCQ1FGbnUybjlMWDI1dmI1WURo?=
 =?utf-8?B?OWRWZFZKcnM0QmVvM1U0bUJYQU5iWlhaeFV6THU0ZW4wQkc0L3puNVJ3ekIz?=
 =?utf-8?B?blJydUFuTWwyZUNXeE45bW10b0hJZUx1d1FaMFcvWXg4THdHdEVPb3N6d2Vo?=
 =?utf-8?B?aUU2V0FMYjl3SGRMRmRJcWkydnY2SVVGTzJSUkZKZUxZRjFKSVB2L1VUdFR6?=
 =?utf-8?B?cG8rNStmU011YnhMckRneFBpcUNtVDFLVFNDRnVOdXhRREtTaGxISG5IR2sw?=
 =?utf-8?B?ODYxS0wxR1dQYUh2OFI1MTJiVWJ1ZzVpNkp2dVdIcnhUcXNjQVpJKzhhTm0r?=
 =?utf-8?Q?BuPPZZbFe/GJVQU1zRC2NggQA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b927ae-8519-4a08-e7ba-08dca7a18370
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 03:18:51.7493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPgIM/nu9xE06GZe/5pyHqAKTqdtsMCHhQUYrpVvTUQhabk8MDNpspMpfyL8ySD4DdEysTk7pzedTl2Ar9JBaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/19 10:47, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
>> Subject: Re: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
>> scalable modern mode
>>
>>
>>
>> On 18/07/2024 10:16, Zhenzhong Duan wrote:
>>> Caution: External email. Do not open attachments or click links, unless this
>> email comes from a known sender and you know the content is safe.
>>>
>>>
>>> Add an new element scalable_mode in IntelIOMMUState to mark scalable
>>> modern mode, this element will be exposed as an intel_iommu property
>>> finally.
>>>
>>> For now, it's only a placehholder and used for cap/ecap initialization,
>>> compatibility check and block host device passthrough until nesting
>>> is supported.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  2 ++
>>>    include/hw/i386/intel_iommu.h  |  1 +
>>>    hw/i386/intel_iommu.c          | 34 +++++++++++++++++++++++-----------
>>>    3 files changed, 26 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index c0ca7b372f..4e0331caba 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -195,6 +195,7 @@
>>>    #define VTD_ECAP_PASID              (1ULL << 40)
>>>    #define VTD_ECAP_SMTS               (1ULL << 43)
>>>    #define VTD_ECAP_SLTS               (1ULL << 46)
>>> +#define VTD_ECAP_FLTS               (1ULL << 47)
>>>
>>>    /* CAP_REG */
>>>    /* (offset >> 4) << 24 */
>>> @@ -211,6 +212,7 @@
>>>    #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
>>>    #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
>>>    #define VTD_CAP_DRAIN_READ          (1ULL << 55)
>>> +#define VTD_CAP_FS1GP               (1ULL << 56)
>>>    #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ |
>> VTD_CAP_DRAIN_WRITE)
>>>    #define VTD_CAP_CM                  (1ULL << 7)
>>>    #define VTD_PASID_ID_SHIFT          20
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index 1eb05c29fc..788ed42477 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -262,6 +262,7 @@ struct IntelIOMMUState {
>>>
>>>        bool caching_mode;              /* RO - is cap CM enabled? */
>>>        bool scalable_mode;             /* RO - is Scalable Mode supported? */
>>> +    bool scalable_modern;           /* RO - is modern SM supported? */
>>>        bool snoop_control;             /* RO - is SNP filed supported? */
>>>
>>>        dma_addr_t root;                /* Current root table pointer */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 1cff8b00ae..40cbd4a0f4 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -755,16 +755,20 @@ static inline bool
>> vtd_is_level_supported(IntelIOMMUState *s, uint32_t level)
>>>    }
>>>
>>>    /* Return true if check passed, otherwise false */
>>> -static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
>>> -                                     VTDPASIDEntry *pe)
>>> +static inline bool vtd_pe_type_check(IntelIOMMUState *s,
>> VTDPASIDEntry *pe)
>>>    {
>> What about using the cap/ecap registers to know if the translation types
>> are supported or not.
>> Otherwise, we could add a comment to explain why we expect
>> s->scalable_modern to give us enough information.
> 
> What about below:
> 
> /*
>   *VTD_ECAP_FLTS in ecap is set if s->scalable_modern is true, or else VTD_ECAP_SLTS can be set or not depending on s->scalable_mode.
>   *So it's simpler to check s->scalable_modern directly for a PASID entry type instead ecap bits.
>   */

Since this helper is for pasid entry check, so you can just return false
if the pe's PGTT is SS-only.

It might make more sense to check the ecap/cap here as anyhow the
capability is listed in ecap/cap. This may also bring us some convenience.

Say in the future, if we want to add a new mode (e.g. scalable mode 2.0)
that supports both FS and SS for guest, we may need to update this helper
as well if we check the scalable_modern. But if we check the ecap/cap, then
the future change just needs to control the ecap/cap setting at the
beginning of the vIOMMU init. To keep the code aligned, you may need to
check ecap.PT bit for VTD_SM_PASID_ENTRY_PT. :)

> 
>>> +    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>> +
>>>        switch (VTD_PE_GET_TYPE(pe)) {
>>> +    case VTD_SM_PASID_ENTRY_FLT:
>>> +        return s->scalable_modern;
>>>        case VTD_SM_PASID_ENTRY_SLT:
>>> -        return true;
>>> +        return !s->scalable_modern;
>>> +    case VTD_SM_PASID_ENTRY_NESTED:
>>> +        /* Not support NESTED page table type yet */
>>> +        return false;
>>>        case VTD_SM_PASID_ENTRY_PT:
>>>            return x86_iommu->pt_supported;
>>> -    case VTD_SM_PASID_ENTRY_FLT:
>>> -    case VTD_SM_PASID_ENTRY_NESTED:
>>>        default:
>>>            /* Unknown type */
>>>            return false;
>>> @@ -813,7 +817,6 @@ static int
>> vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>>>        uint8_t pgtt;
>>>        uint32_t index;
>>>        dma_addr_t entry_size;
>>> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>>
>>>        index = VTD_PASID_TABLE_INDEX(pasid);
>>>        entry_size = VTD_PASID_ENTRY_SIZE;
>>> @@ -827,7 +830,7 @@ static int
>> vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>>>        }
>>>
>>>        /* Do translation type check */
>>> -    if (!vtd_pe_type_check(x86_iommu, pe)) {
>>> +    if (!vtd_pe_type_check(s, pe)) {
>>>            return -VTD_FR_PASID_TABLE_ENTRY_INV;
>>>        }
>>>
>>> @@ -3861,7 +3864,13 @@ static bool vtd_check_hiod(IntelIOMMUState
>> *s, HostIOMMUDevice *hiod,
>>>            return false;
>>>        }
>>>
>>> -    return true;
>>> +    if (!s->scalable_modern) {
>>> +        /* All checks requested by VTD non-modern mode pass */
>>> +        return true;
>>> +    }
>>> +
>>> +    error_setg(errp, "host device is unsupported in scalable modern mode
>> yet");
>>> +    return false;
>>>    }
>>>
>>>    static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int
>> devfn,
>>> @@ -4084,7 +4093,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
>>>        }
>>>
>>>        /* TODO: read cap/ecap from host to decide which cap to be exposed.
>> */
>>> -    if (s->scalable_mode) {
>>> +    if (s->scalable_modern) {
>>> +        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
>>> +        s->cap |= VTD_CAP_FS1GP;
>>> +    } else if (s->scalable_mode) {
>>>            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
>>>        }
>>>
>>> @@ -4251,9 +4263,9 @@ static bool vtd_decide_config(IntelIOMMUState
>> *s, Error **errp)
>>>            }
>>>        }
>>>
>>> -    /* Currently only address widths supported are 39 and 48 bits */
>>>        if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
>>> -        (s->aw_bits != VTD_HOST_AW_48BIT)) {
>>> +        (s->aw_bits != VTD_HOST_AW_48BIT) &&
>>> +        !s->scalable_modern) {
>>>            error_setg(errp, "Supported values for aw-bits are: %d, %d",
>>>                       VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
>>>            return false;
>>> --
>>> 2.34.1
>>>

-- 
Regards,
Yi Liu

