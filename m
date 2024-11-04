Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC3BD111B3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 07:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7rMe-0003IM-Vp; Mon, 04 Nov 2024 02:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7rMc-0003CP-1m
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:19:02 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7rMZ-0004zU-2X
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730704739; x=1762240739;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OIzD5VbPK+XpwVClvHcroeqvkqrECcUEQc8AQu1IXiI=;
 b=AGojm3S8FgT434WCefwlWt0yT6hCeJJVV8+pTbVxC/5JcHhEODzwiV5M
 2PSuyJ746SIjIySzStb/H2uGbdj8+d4BS4VTqb5QrSGZ2dSCLpT9HIhRu
 WxydVM5gfuMeR0UtbR8h20djhBAUkHF/PZzEomDO0ypljOkSEgjG8Z5X1
 XgXSui96MD0hnMB68+5L5rwR8y82bneL6+POn9FUTqvHD8aMdfoI9vbWu
 8XxpsIBFT3icjH3zKfM8RLrHUKvvMbJ4hG7c8mhRWMAIGAQ57J2+KH+uA
 xA8uDYI8lMUN+ScfC41fYOC9csT4LdiTh7RVL0KnG4worEl8Dcudk5l6h w==;
X-CSE-ConnectionGUID: 2c+r6N0HRQ+SRAwBFGoAAg==
X-CSE-MsgGUID: F8jjA5JkQJOzexSAXw4jGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="55787852"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="55787852"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 23:18:47 -0800
X-CSE-ConnectionGUID: DZ9HQOGsSkqFVlf/RjDbsQ==
X-CSE-MsgGUID: UYfR+kgeT6eHSd1naZpi4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83091357"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 23:18:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 23:18:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 23:18:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 23:18:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uI5FsokD89TU3cuqbuUoQ5Pb/XdlTkOBiMFjUWPC7GX30pAPcNlKJOwK+pq2NC8yuqBNsICQte/bb20eQTxMeI+nsCsjn5TVGk/sAOaw0vXOQnxHxGPwuZwHA0H5N1NxLXY0Txjo5I1mEsp74C6HxJOoyIPgjxtJbiodgbCAKhyOoOAMTFPgROXM4TnOSZFic/QuPPNEseBL1hxfJGmfdfQw5NtPdV6P46hK6uDpm9Wt+OYUi58ATgVJaXU3TDyJUzqriUq/lr0NDkxrW0+0cGwkTJLPFlyw+t/SFdB3qTugggyZcp4Sr/ndiTB3Bhg1aRpjLalyiBVM8qRUBmyh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qvxje3lOyan9JtvcREfkA9wZBdZvVdnG+9/rSnBeHHU=;
 b=m4JkhXkun4IfmSZFDxpgf2ytsxMCFU1TOUEFlTpfOr68CgmUyQQ89rNuGll5OA4oh63LTEx44sttRngJpki0ph0iZt4dbgsH9ZcCOPWStE58VATYarDO8WOrmAhzTxg8XJ4PXN74tD+MK7Q8imChXsBCIZoijhTZiT+9s9UhWoo6oqjkv7C7cbPLk3RkEyWx30kzCt+1o1EoFi2UN5u68S5q1swZ0W5y+YS618qW1kfiVpFg9XBFmkIURzA+9LAFnaBSu5sfZtH/USocIfbjwMs0OXXR5p9xUtJVGj4n9ODHuVcNi5+qP7jpkxw7brhPZK+BQwGstUIkfLGI5xkCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYXPR11MB8691.namprd11.prod.outlook.com (2603:10b6:930:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 07:18:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:18:34 +0000
Message-ID: <df02d9d4-3a54-449f-8d99-cca10bd28cf5@intel.com>
Date: Mon, 4 Nov 2024 15:23:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-16-zhenzhong.duan@intel.com>
 <5cbe6426-e64c-45f1-b276-c7dbb70ff3ed@intel.com>
 <SJ0PR11MB6744F2BFCE29E91D6180609292512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744F2BFCE29E91D6180609292512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYXPR11MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: cb350cde-ce8d-411a-fe60-08dcfca0e48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlJxMTlGZzFrSFc5QmtycEpSakRuQW1NVmVyc0Zqd3Q4SFlpcWJva29HVEF1?=
 =?utf-8?B?aVVrWTR4UTRzNXBXOTdWaEFuMFpwVHZmOXkybDBjVURhR3dRekN5WjlRTFhj?=
 =?utf-8?B?RkJlVnFVMEZzNzczcGJIWXI4akFQMFB1YmU0S2JIaDF4cVNKM0VyZmxsRldr?=
 =?utf-8?B?NG1COVlBdFRWQldxODFwNXJIbWRRSDFXdHdnREhRdEhWN3dscHltNkRhWlh4?=
 =?utf-8?B?Qnd1UStCV3czeXY2QVFwTDk5M2E4aUpYZkNvcVpBYWdLQnQybmpvN2ZJN0I2?=
 =?utf-8?B?RENwMTlOaFJGN1ViZWd0RGNwbnM5TU1WZEp0ZStMTHRBUkhnLzBHaDBDOWVY?=
 =?utf-8?B?TWFkWmtHU1FDcUg1Nk9BT2RIWGk3cUpYQ1NOMHRTQTErUEpiekxjdzhrTFpw?=
 =?utf-8?B?OGMrM0xwdGhZSkZjZ3F6VFBaWFRCOGZGMVhiRm5wWkVaazVXV2NKMTdldS9E?=
 =?utf-8?B?SndXL0x2cmdBNXdMSVJkSlprM1AwZkloWTZHeCtLejVsQWVHUnRRTUswT2Iv?=
 =?utf-8?B?RGRZamxKcmh4WXNhK0ZQNGRNUjlId0xSRmU3MTNlcmw0UzVmdUFqUE1Yci9K?=
 =?utf-8?B?dUdsOUFSbkRvZHg5Wll3dm5yVU96a1o3NUVidThxUFZCY21DeU1kemJLWDZq?=
 =?utf-8?B?NDJrb0pFUTRnRWJoWW5vWHBIK1dSUGJISWQxMjZLUDU4QXgyN1pFU04xUE9i?=
 =?utf-8?B?OUVCcHE3dk8rZTdUbkFOUUJzUjZ4M0Z3NG5BUWhkSlRqbGlBb281cWZuZm9y?=
 =?utf-8?B?QUFReGRsYk5xaUVGcEhubEk0SnZsSmJoN0M4dHlaU1VIdDR6VlVkdFBBQi9T?=
 =?utf-8?B?NGRqK0lQRVZ2VjJENFl4MFFwaWNRTFFkdFg3cE1uRjJSUlFpRlltUmxCQUdn?=
 =?utf-8?B?MkRKWFljbFhkaG9DT3RJNlFBOU9YTmVSQkR0bGtreHdoY0hOcXIwSCtpSjJn?=
 =?utf-8?B?cmFJUjUzQjFBNC9yQVZxMm1FeVVNZ0l2VmRpbEpPZ0gwN0hZLzRqNmExUVlD?=
 =?utf-8?B?YzgwNGhuOTZhSFd2cURsM0xvREFLdHJUUzVGRmdXeWwyd2VFVWl1Uys3OURa?=
 =?utf-8?B?cHNQM0h2VmdGUjJFUlZRYkoyQWQyUWFydHh2L1lURnVOdUNyV1pLekN2eXBH?=
 =?utf-8?B?WlNnaG5pSVdVTnZyOVYvVFpKSTkxODlMZlBNZXJsY0lJVkVsREVvUmNYTFp2?=
 =?utf-8?B?VWZ6RnQ5N2h5VXRtcGFxblNsclRSRDFEdVdoVnlNRHNBY0EvbFRRUU5HUUND?=
 =?utf-8?B?czBrYlFVTU1uSmw0YncxWml2SHk5ZWY2WkVma3VkaTF3Q3IwVERDNVpldXk5?=
 =?utf-8?B?a3dZc3lOSDRtbFVDR3FZcDZ1Smh3eG5WWTNNWE1YYVJHWUJvcEdvUWZ2NXo3?=
 =?utf-8?B?SjhkckxraEJVb3pMTkFyTGxvZXk5QkVCeHBmL2RzM1dTUGZ3VnFyMDV5THUx?=
 =?utf-8?B?MnNkbTlzSjF1ZVZ0YTgvMW5XcE5hdjZ4bGQrT1VvbS9PK2JaU05wQ2NvT1lz?=
 =?utf-8?B?Rmd2Z285YjNBMlZZdEl5eHcrWE16Y3VaS3k0bDNoQnFxZEEvUExlT0FPbEVt?=
 =?utf-8?B?Q0pTZjJ4Y2tuLzd5MjQ2VGswRUovVDlMUkxpNzZqMFdqYmpZYkVkdHc5OU90?=
 =?utf-8?B?d1VVbmJQMVhQYnBmeFRIVHo2WkUxUmZlL1o1dWtha2NyUnZFWWpoTytFYXJr?=
 =?utf-8?B?OWFJL0R2MmRlSWV5NVIzeUtJWnJKdGhxZ3d0VFplVnNrZVoraFJQdGFYeVZL?=
 =?utf-8?Q?KQXkttGeqEcFceoKd+KtkkrgX9TkLMc4fkHUocG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEcrWE92NERqR1VBYjNBWk5hMDdxZ0lTZi9mN253NGJHRE1pZzJuNVZmbG9T?=
 =?utf-8?B?OFArcEM4L3ZDM1BxRWpwemZ0OXhRbUQyNm0zSndVeTEveXZVTGI0NStJNmI2?=
 =?utf-8?B?Nk1WWjk4S3FMSkFUL0N4b3ZSOXVtcjlkUUdjc05jdlVWci92YXczRWhqd1ha?=
 =?utf-8?B?dDhlWFN3NlRibm0zZjdMMHpQWXcrZGM0MHF3bkhsTXl0QmNheExyN213L0NT?=
 =?utf-8?B?OG1MZHA4djRBYUIwOVdJWFAyTkNtRWQxUEJYMUVuMUVYekROVDVJU2JLVkR0?=
 =?utf-8?B?VjE1b3dVQzVzRkN3YllaR2lpQk4rZEF6MWJiNFhYK0toTFQ2UlgrOWNuZnkz?=
 =?utf-8?B?R0FRNlN1dGd0NDBNbHNOd1FLWTg4U3VnTHpIRnRadkNXNldBeU4zRHBFWmo2?=
 =?utf-8?B?c3R3QytuU21TSmkra0w4TzVuZ2FteWV6dXpXQmI1a2I4KzNFMkNEekJIQzlx?=
 =?utf-8?B?MUVaWEpHWlVsV0pCMFEwSVBLVzFUOFM5VDI5K2NYMGhURm9ka0UyQXI3SXFE?=
 =?utf-8?B?dDlQZnozWlBSNE1iUStJTi81eVJheDF5TVJDbXg4OU9CMnZBajlmV21xQy9D?=
 =?utf-8?B?WlYveGlSTS9ucHlQSEZ2NEhEeDRDS2JILzRldndySWNnd2l6RlpjYmhka3BD?=
 =?utf-8?B?bTErcHFqUWpkQmVXdHNydkVXb1dCWkducUVNVGpobjd4V2h1NWNlWVIvTXV5?=
 =?utf-8?B?L2hhSkZSVEdtRGVuZU5DSTRBYjFrRDBSQXFaK2lveXFLVWE0UFpDVjlHeUlV?=
 =?utf-8?B?Z3FIUWgzRnVEV3RXWThhRVhKVk5EV3RlMXp3cDc0V3lDWitUNHJlYjc4ZUR2?=
 =?utf-8?B?VW10a0YwaDl4dlNPa05IOVNON0xXRnF2aTduWXJLaTgxanhIbVpBeDlZcytL?=
 =?utf-8?B?NjU4NVVmOXJMallsSVYrSzJ3MFFPOU1IOVZzNVRQWVZ6Vld6MWFSaHB2SGho?=
 =?utf-8?B?alVtTzF3ckxTbHpFSVZtSTJFY2VSSU5DeGFRbWk1Y2hPTUFleEpnSVZoalBj?=
 =?utf-8?B?TkJzSkpVZkYrNzAwRDJGSTN6S3FQZUZ6WW5YMmttSFBnd1hvNjlOR1FzWHVz?=
 =?utf-8?B?UTRIZjcweU1kTG8xRDRHVDg1Z3J6cWppMVFXeGNIcEtqZHpJRGdDbEVQZWtI?=
 =?utf-8?B?RWZIclhiTmE2QUdhQVJDUmdXc1hBdzJJaUo4bjdTNDFiclZwN1BBNm81bDRQ?=
 =?utf-8?B?S3ZkazJkUXB2Y2ZxQXVSbGNhWjJRQ1NVekxIb2YxNERpaG1xajZCblZWK0tR?=
 =?utf-8?B?Wk1kQTlDUXQzOUZXT2lXWHgvd21vZUx3L0h4QnB6QTVmSXR4aUo2UDdxeDJK?=
 =?utf-8?B?Z2ZvdTN3bXNDd1l5cmFPanJQRU9oMmdTTFk4OExpc0x6QXZYcnN3dm5veEZ0?=
 =?utf-8?B?ckJ5cndlQW1TZHZ4c1NZbzBoeWc0SEFQVjk5ZTJ6Uk9mb3g0MHlrQTJGd3BR?=
 =?utf-8?B?cmY0RG9EUmt1c3B4V1REUkNDQ1duTmFhTTRVeENFZ05WYkRlT2hXQnNBRnM1?=
 =?utf-8?B?dmdQZ2dPREowaHAyKzYwTXlmNnVJdnkrWlFNcmduWWF5bXUwWml2eVdHc1ZK?=
 =?utf-8?B?cmh4dkpQVFZSUVd5cU9VZTZwWlFaam02VlRQaWxxVjRVQ0hQNFJ5ZkovM2dl?=
 =?utf-8?B?aTRaSHorL2x5SHZUUEtPL0xQOWVKYzR6bUUzOVJzeE9RUXVJaG41dnl3TmNB?=
 =?utf-8?B?TWdJT0hhaVZwZ1Q3azdrT3JPUUdWa2JRK2s3bXd4VjlWN0Z6QkdqTjQ1dWlk?=
 =?utf-8?B?OEd5WHFrUUJVKzlXUlBkRzlCRlNKZTIwbU1RUERRMTdEMHRJUUNrVTNmcmxT?=
 =?utf-8?B?QmxqL1F3MUY1Z2NVSGxSeHBzbEVNMjU0VEFnV1dHaTEzL1dxc2tMSVFqYk9K?=
 =?utf-8?B?MHorM1hWd1d0Qm41U0lmdEkxY3hidTNVRy8zbW12SGE4Ry84RWhlZ05ITm94?=
 =?utf-8?B?YzEzMndudjR1WWQxdXQ5SUVudTI2SjZhT250bHg2RE5DY0E1QVI2b3JmS3FK?=
 =?utf-8?B?NERnWGFtZ2JNV2J0NEF1MUdaQlpkYXY1NWt0ZWZpa1VTNmthdUlXSUhlZFhj?=
 =?utf-8?B?RjRpS3NnQlFldGpURXE1b2JMSksxSDBVZU9qelhGcTNhZGczaUtRSmlPWEoy?=
 =?utf-8?Q?0eRCfKi2UZSVGfA5lPc/7T1Nh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb350cde-ce8d-411a-fe60-08dcfca0e48e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 07:18:34.2373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJsITQh58dXuy+Gae2w0CgtxW0/VEEYLE/KLcEvsHpcLd8SyoEPw/FuaK+19wqUcHbVPIruCB5pBlvIesrMJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8691
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
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

On 2024/11/4 14:25, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, November 4, 2024 12:25 PM
>> Subject: Re: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
>> scalable modern mode
>>
>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
>>> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
>>> related to scalable mode translation, thus there are multiple combinations.
>>>
>>> This vIOMMU implementation wants to simplify it with a new property "x-fls".
>>> When enabled in scalable mode, first stage translation also known as scalable
>>> modern mode is supported. When enabled in legacy mode, throw out error.
>>>
>>> With scalable modern mode exposed to user, also accurate the pasid entry
>>> check in vtd_pe_type_check().
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> Maybe a Suggested-by tag can help to understand where this idea comes. :)
> 
> Will add:
> Suggested-by: Jason Wang <jasowang@redhat.com>
> 
>>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  2 ++
>>>    hw/i386/intel_iommu.c          | 28 +++++++++++++++++++---------
>>>    2 files changed, 21 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index 2702edd27f..f13576d334 100644
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
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 068a08f522..14578655e1 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -803,16 +803,18 @@ static inline bool
>> vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
>>>    }
>>>
>>>    /* Return true if check passed, otherwise false */
>>> -static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
>>> -                                     VTDPASIDEntry *pe)
>>> +static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>>>    {
>>>        switch (VTD_PE_GET_TYPE(pe)) {
>>> -    case VTD_SM_PASID_ENTRY_SLT:
>>> -        return true;
>>> -    case VTD_SM_PASID_ENTRY_PT:
>>> -        return x86_iommu->pt_supported;
>>>        case VTD_SM_PASID_ENTRY_FLT:
>>> +        return !!(s->ecap & VTD_ECAP_FLTS);
>>> +    case VTD_SM_PASID_ENTRY_SLT:
>>> +        return !!(s->ecap & VTD_ECAP_SLTS);
>>>        case VTD_SM_PASID_ENTRY_NESTED:
>>> +        /* Not support NESTED page table type yet */
>>> +        return false;
>>> +    case VTD_SM_PASID_ENTRY_PT:
>>> +        return !!(s->ecap & VTD_ECAP_PT);
>>>        default:
>>>            /* Unknown type */
>>>            return false;
>>> @@ -861,7 +863,6 @@ static int
>> vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>>>        uint8_t pgtt;
>>>        uint32_t index;
>>>        dma_addr_t entry_size;
>>> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>>
>>>        index = VTD_PASID_TABLE_INDEX(pasid);
>>>        entry_size = VTD_PASID_ENTRY_SIZE;
>>> @@ -875,7 +876,7 @@ static int
>> vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>>>        }
>>>
>>>        /* Do translation type check */
>>> -    if (!vtd_pe_type_check(x86_iommu, pe)) {
>>> +    if (!vtd_pe_type_check(s, pe)) {
>>>            return -VTD_FR_PASID_TABLE_ENTRY_INV;
>>>        }
>>>
>>> @@ -3779,6 +3780,7 @@ static Property vtd_properties[] = {
>>>                          VTD_HOST_AW_AUTO),
>>>        DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode,
>> FALSE),
>>>        DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode,
>> FALSE),
>>> +    DEFINE_PROP_BOOL("x-fls", IntelIOMMUState, scalable_modern, FALSE),
>>>        DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control,
>> false),
>>
>> a question: is there any requirement on the layout of this array? Should
>> new fields added in the end?
> 
> Looked over the history, seems we didn't have an explicit rule in vtd_properties.
> I put "x-fls" just under "x-scalable-mode" as stage-1 is a sub-feature of scalable mode.
> Let me know if you have preference to add in the end.

I don't have a preference for now as long as it does not break any
functionality. BTW. Will x-flt or x-flts better?

> 
>>
>>>        DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>>>        DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>>> @@ -4509,7 +4511,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
>>>        }
>>>
>>>        /* TODO: read cap/ecap from host to decide which cap to be exposed. */
>>> -    if (s->scalable_mode) {
>>> +    if (s->scalable_modern) {
>>> +        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
>>> +        s->cap |= VTD_CAP_FS1GP;
>>> +    } else if (s->scalable_mode) {
>>>            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
>>>        }
>>>
>>> @@ -4683,6 +4688,11 @@ static bool vtd_decide_config(IntelIOMMUState *s,
>> Error **errp)
>>>            }
>>>        }
>>>
>>> +    if (!s->scalable_mode && s->scalable_modern) {
>>> +        error_setg(errp, "Legacy mode: not support x-fls=on");
>>> +        return false;
>>> +    }
>>> +
>>>        if (s->aw_bits == VTD_HOST_AW_AUTO) {
>>>            if (s->scalable_modern) {
>>>                s->aw_bits = VTD_HOST_AW_48BIT;
>>
>> --
>> Regards,
>> Yi Liu

-- 
Regards,
Yi Liu

