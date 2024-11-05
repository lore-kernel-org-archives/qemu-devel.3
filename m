Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED21D1CA36
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Cnr-00004s-NC; Tue, 05 Nov 2024 01:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8Cnq-0008WM-AA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:12:34 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8Cnm-00086r-Bc
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730787151; x=1762323151;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FAC9ieKz6gkH1flSgxTvl6ZKN3WmLbK80gL6YDjtJQQ=;
 b=BYDveP5k7VxS3Tw99S4jCTStl3cEirqGCVZTAYdVZop88iQrHhuvO9x/
 WwFAfJhUQIE+xThLIewzgVsLCh0rO9vOlRghTiJspWLkJ2PcHMFWvvRzV
 ctTFFbs9Mi5k/WuuRgP6vmShu6V8tpEKGYyXBptjjbolUsvanjQrpu5/J
 ti4JU1CfK9LSMGDI+7lMIqwOlfSLm+As6pAm3mgpqp/FSlqR/i00xqLih
 JoIrJWmextrmxO9+yF6lsKnhPPRNGgkvzEtedUD1wdwvUFqkooWJisb9T
 XQKiff1g33171Im0T6yYslg13sUxwFs/QzGVnw+ujjG0dXHWtW7nEh8PB Q==;
X-CSE-ConnectionGUID: npVp2ccyQpW12PKQjT70qQ==
X-CSE-MsgGUID: /U1G85ZeSDelZmRd5sggcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47978154"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="47978154"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:12:28 -0800
X-CSE-ConnectionGUID: LDRymN6WRPOHoM6tR8ZJSQ==
X-CSE-MsgGUID: 6M7u/WzHQvW0TEHQS9V+Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83830582"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 22:12:27 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 22:12:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 22:12:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 22:12:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ytd0R+y2Y8GvG+Te2+KE3P6qu/zEKTlLTZIZ6w9fHf8OawRUiicrzL+lIn38JDU7Rby3MaGRv0jGhmHCqsjxfFURaTYySMD+5TIHiJ1qK57fLpW2AQ2rIVDrXzcBanYSkkiTLnjDYY0Hhdp/0xpKS6JAwjY9LAzfyueUGhehtud5UidUyiZS/E7SbUmj0oibh8hdr8we53Pj/dgU/mAuizDGnYXtkVHzv9Ew6rMId0+UQp3+GPrEltWCLAYLRjz1BFA7Ra+SpwYgR1PFSUUkDDwQpPdl0bRxvMq+3tfPopR4cbaaVuo86R6rSyqC7EFHWipM0ABsCm+VY0lwIEy0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAC9ieKz6gkH1flSgxTvl6ZKN3WmLbK80gL6YDjtJQQ=;
 b=YHBC4L41yDt7iodQR4wm+171NgYnKaQNpe/UTzBvpVBCwpHnOZI4bRPhbRy/cDmTDSqAeb5ClqXr7hHg0wJeHYVDNCti/4m+ntyIlthKPowxTkpQQWoel3TAA0R+36NpXjJsa1FkFCL5yBGKRZScGx0JZZu1z8dI0xf+XmcUXgAsGTzZDIWu87Vk31fZRRaZ5Q2WkFAlNwf2Kj6hLolTIaSeSP8LIUxirGWnG4aJBVlSkDaeo7Fp6PQLMp7ih2vv95xkPXlE1hheTowxYDvCH3HMy96G7MhVYAKmC3DrrlwB7tKO4gc5u0CAnYUfNWg4cRpoSQ9Q7Od12UYQXFHYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:12:23 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:12:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Topic: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Index: AQHbLrllsz/Poj6ktkWylIhCzxfopbKoIyaAgAAQvkA=
Date: Tue, 5 Nov 2024 06:12:22 +0000
Message-ID: <SJ0PR11MB6744D1EA9FCE89F58E83F7B692522@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-3-zhenzhong.duan@intel.com>
 <0e8716db-9a3a-4007-823b-6b0ef5ad455b@intel.com>
In-Reply-To: <0e8716db-9a3a-4007-823b-6b0ef5ad455b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7596:EE_
x-ms-office365-filtering-correlation-id: f532cac9-ca73-42b7-db60-08dcfd60d00e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UzFIMXdjbDVaNTZVbk1zREhBMXVja0t1NGFMYVA0OU9qN2ZaZUlaRDZ5RXhz?=
 =?utf-8?B?Q0szYnI4dytxSmV0dmhod2lhRVlGQmxySmgzaDRzM3VPSitJc3ZlVGpWSHda?=
 =?utf-8?B?emJIaEltTUprRW5wWWZGS3YrSWxzMEI5OU03cURqUkRSSG0xaEF5bld1Uzlv?=
 =?utf-8?B?bWh2MVpnSkVOUFhmZDA5NVJwZ2JHZ1VHS2hiOVlRR3E5R2pkV1hBRU1haUxm?=
 =?utf-8?B?YkFsbUdjZDF5R0NXaTk5YXJ3eUxSUEk1Z3c2Nk9pQUZNckNrNmFBOWN1L0dp?=
 =?utf-8?B?VldmOWFLY1ZRdFc4c0ErejBYWmxxbytzSFpCVGFKbnBsWUc1amFuTmlhNHJI?=
 =?utf-8?B?bUVyWWdmR21SWmJpL1VtRHZrVHAzVzdyclk5eGdLVnlYN1hHQUFWdkgxMUli?=
 =?utf-8?B?ZzdhcldzSU15YjZSSWdYSjVudUY5RXVrUlZzN200OGRFVHpZaHdjWmN2bTZ2?=
 =?utf-8?B?MmhVL1YvZmRmRWYrT3ZWRkVWMlRRaHZGS0xXSStuMldEclhTYlRwcEM2RExR?=
 =?utf-8?B?U3NIRjhzcFhnb0hKS0pQWnlncnBnTmRueEtDTFNFYnZBS3FqTGNseXd4WGN0?=
 =?utf-8?B?UzJsa0pxM3BLTUVoQ2lFNTN5Nkl2TTlJeHRpZWp3Y293VmpjZlJMb2JDaVBN?=
 =?utf-8?B?eDRwVHNBUysxdVYrY25YaUQyN3R1ZW5FRS96ZlRWSVdNczVQbENVeEJjdWUz?=
 =?utf-8?B?d3dka254N253aFVHZ1Z3V2E0U2lSMW9CbUsvWExtUkU1VmJ3My9XRzE1dDRx?=
 =?utf-8?B?VXh4TngrRjhRMnEwMFBGQVU2RWNobWVzeHlMV2kxeXZyS0tRMEJxeUVGTUwx?=
 =?utf-8?B?S1dCdkJYVlozb0M5QWgreHZVNEpMLzZMd09PRVVpRWZ4aDRFQm9vZUdtMC9j?=
 =?utf-8?B?ZTgvVzVvckxTTU1hcFk0cEMva0dyWGg3R3lWNWZHNXVHcTJUcEZOUllmM0h6?=
 =?utf-8?B?U0J0R0JjYjYzRDE0MmNXeXg3WURXTXZLcG9hQldZbDFRNU95czVvMzV0dUtx?=
 =?utf-8?B?VjhDaW1zQ2NvTjNXNzZYV0FvSmNveXJoQVNFN0pCMVhmcHhVNFluK3Bpb00v?=
 =?utf-8?B?SHZNUUpEeGtCK0J0U0ordENETDFValFBMDNQUWxpYlpLY01FZG84SHUzc0pS?=
 =?utf-8?B?QVJWMnRpTXBaamxUQVZnUW9maVFVcVNETWVpZkdwOXIzRnJZMDVGK0JKcUZU?=
 =?utf-8?B?emRneTRJYWhuMnNvMU5Gem1HSXg1ZG9zNWxhL2RteGR3Tm05YkR0RTFuUXdk?=
 =?utf-8?B?YWZUVk00VEVMSUgyODNMSW9JemZwYmdUcmlkVWtEL2Y2NWVUNzJvTkJpVzBa?=
 =?utf-8?B?a0pJVU9RcXBNMVlmc1lUaUxnMGc4anBFbFg1ZmM2aEIxUUhRVk1QczNheU9C?=
 =?utf-8?B?djlNQlIxZjUwQXRvS0R4WStQelh2YmYxV0E2V0lQeDZIWGd3VW0rQUZITEtP?=
 =?utf-8?B?KzdqOFB0LzhCTnJKank0RkJkUXgvdElHVWpzNmx0R0lOK09aT3hydTFYcWZD?=
 =?utf-8?B?ZWlXbjdleGJIWUY1eUJmVXJLSStaN2VOaEhnMzJwa3JySS9zZEMxTWNxK294?=
 =?utf-8?B?Q3ZpVFdxWjI4NXVaRGFCOVI2VEx0ZnFqL3B0M1czZnFYOXpqejVCdGNsNGJ6?=
 =?utf-8?B?R3VwNkkwM0x0WW1xRzVpOTIvN1JrcENsZ2FaQTA1RkM0Qkhnenc5QzlRek9t?=
 =?utf-8?B?Qlg1VTYxRnNtdExoNXNOY1hGVEtIa2dNRW00MEhCaTAyaEJIL0M4NVFnRURW?=
 =?utf-8?B?REU3cEhTN3lkYlJCQi9jTWV6U3o2VDMraWkxTVZocFh5OTVVdk1ucGFra2F2?=
 =?utf-8?Q?P2lIQ9qGNuTwD7e3aw0nR2Dmm25oXVNoX7EhI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGtOV0dkbHZiZWx5RlB5YUl6a1ZNd3UyL2ZRY0JPdVRGRDhiR0ZRcDlhbHBB?=
 =?utf-8?B?QytYL1dzeEd4aFY1NWdMQi8rajlKNGk4K1U5WlJGZnpxS0lPRlZacGxBRm5v?=
 =?utf-8?B?NklBZHl4Wlg2S0JFWVBlUDBpaDVtck1VNUl4clgrM1NoZWJONkhwR3Uwc0VB?=
 =?utf-8?B?SVlRcWRFZlBkODdhMjVKY2s3OWg5QlN3VnF4TnJHQzFRVFBLZ3ZtYTJuVEdk?=
 =?utf-8?B?U3ZWdVZqdzBHWCtibDFUTWRqcGhzOVhWbDF5YlY3NG80YW9hM2ExMlJyYjhm?=
 =?utf-8?B?dlNyOG4wU1J6Z25HYWZEOFp5NTg3amdWOFZRT0huYjJiMlN4Z25KYjhHMldR?=
 =?utf-8?B?eExlOHI5Z290dWxtVHd0TDcvL3NNWnhFSWtYS3ZGbUplWDEzRTNLc2txV3Ix?=
 =?utf-8?B?bDE5ZFNKRWxSYytvYzFHUTM4WjBjYjVvQzlsYThQRTVGMnN3NEw0ZFVjSG1P?=
 =?utf-8?B?bFFUR2M5TUhITlBXRENzUEJqT09WNHV3clVJMDlaU2p4Yk5aQyt1dmFQZkRq?=
 =?utf-8?B?Mkt6aWZ6M3V1MWRJWC9YSS80ZWNid0N2MWxad0ZyN3pRZkhqak93N3BGU3d4?=
 =?utf-8?B?aENVMGNJYmZQMHBKVXg2Z2pMZ2h5NEpiZUtiemRTV1dwT3lCcXgvVDJmWXhK?=
 =?utf-8?B?TXdqMUFXbGwxWDdhQXZjV1FQMmd4VzA1VnJGbGZxQjF5bmVySzhhV3NPZith?=
 =?utf-8?B?SUk4L3ZCRTFoemRObnF6Nk1uUXRJQWZ0ZHVFMGN5dU52QWhYb3EvVGlhRkJ5?=
 =?utf-8?B?RG96cEM4a0tydU1WajZvN1ljVDhqSktvL0thV0RUa0pPeC9WRFJZd3l6M2ds?=
 =?utf-8?B?V2dtVDdhMzVxVjRJazJ3d2l3SU50RkNRVE5pQWFDM0oyK3phbno1bXdHbnMy?=
 =?utf-8?B?aDZ2SWNzVTM0MFRXSkJCSHlocFM0ejJSZzY4RVdLS1U2ZkxzRG5MQVljVXNw?=
 =?utf-8?B?YjgzV1Q4OExoUUZoNDlrazZNdnVXS1RSUFdPYVBHVGNmZ2gzYWYrRWxTZ0JJ?=
 =?utf-8?B?SndWTU1ySlBNY0p5QVNKZUpWcVBmMlFLTE5peUxGY2hReGFIZG4rU3VyeCti?=
 =?utf-8?B?enN5QXlmUUxpMkFLREhrS0Yyd3NNY00ydHpUdnRlMHA4cVR0V1V2ekpLYlRL?=
 =?utf-8?B?T1E2VGluc0pNd2JMZUI2Z0ozeXFVdG9UWkNnakt2UzZXZjI5QzlwakRRU0l3?=
 =?utf-8?B?SXR6M05sc2c2SEs2NUZqR3JCRVpkNGF5WmFHZEZRYk9iZnBVVGFQamtIZFpY?=
 =?utf-8?B?aFZiMVlFMjlSTnAweFRrVUtjY3FuMlpXVEl6ZzBCQU1ERkhqV3ovRXpndWsw?=
 =?utf-8?B?enNteG9BWTgvNzJKWFpQNlUvZWNEbFRxSkJvM1pKcHo4SldXNlMzNEdOSmFn?=
 =?utf-8?B?S3Q0NGhjcytNVnY5Wk0vRU11TmRsN0pySDVuQVFXWDF1MG4yMC9SNnp1Z2tK?=
 =?utf-8?B?TmkrSjNrZ0E5UXdTZkltNXZSczlIWGMremNkdG05WU1Pdit0eDloUlZXMFpz?=
 =?utf-8?B?cE1Sc1IxVS9xNFlIRFVVZHlyQ0MvM3ViZURGdE5PR1hSSEE0OTdBTXhFaEVR?=
 =?utf-8?B?NDk5L0tuejdoUXFyZ01FS3U3cHZLSXZjWTRZS2lSaDR5RkdQbWpyd256bjRh?=
 =?utf-8?B?Q29aVzJLQ0RybEJ2b3pPNC9Hd1BkeERCSFB2VEVzbWdsSUNNZzYxNC9WOTZa?=
 =?utf-8?B?ZTYrb0dEVlQ0OXE3MzRyRERUMFgreXN3WUJvQ29TZGQrTzE3QmlWUExpd3dT?=
 =?utf-8?B?T3ZCOEV1T2haTmlwWTdET2N6aDU4NDNCaCtKQTdwVWp3N3dHekN3TStNL1cv?=
 =?utf-8?B?dnNraUVhU0dNSGZPTitnNERvMzZhUW5lY2JpZGdZbGlwUXVuRktjYnJ4bDgz?=
 =?utf-8?B?ZU5hOFI1N09McUs1dVRYdUpzY1JIK3ZGbldyZU9qd1NUSXFwN2VxenFEMklw?=
 =?utf-8?B?K3F3ZWdJb21PUTNRbGVDZHZEWHZSVHV3dE1WUWlKQjVOMWRxWTg2Y2dFaG56?=
 =?utf-8?B?WG1NbnVGVEhUQ0xiVWk4SDVnQmFVTllVKzhFU3NpOFZ1am1hb3k1Y2RYa2Q1?=
 =?utf-8?B?Q2pIUTh1L3h0Q3l2dk52MFlESXpYZloxTnZCdGw3WEthSW1vUHpNc1h4T1Np?=
 =?utf-8?Q?ss+oGQt4SnchEQdFIm12DOwCm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f532cac9-ca73-42b7-db60-08dcfd60d00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:12:22.8995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hy6lKR4tdMiCuB6s3r+YnN408Ea+6YROfGkrtWlHvTLRtY5TZ5TnPgJ17zTnD2fbDR/TDRTwXwFjcGOlwKy+zkydzfySObOsjAwMgRYZfsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMjQgMTowNSBQTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBpbnRlbF9pb21tdTogQWRkIG1pc3NlZCBzYW5pdHkg
Y2hlY2sgZm9yIDI1Ni1iaXQNCj5pbnZhbGlkYXRpb24gcXVldWUNCj4NCj5PbiAyMDI0LzExLzQg
MjA6NTUsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQWNjb3JkaW5nIHRvIFZURCBzcGVjLCBh
IDI1Ni1iaXQgZGVzY3JpcHRvciB3aWxsIHJlc3VsdCBpbiBhbiBpbnZhbGlkDQo+PiBkZXNjcmlw
dG9yIGVycm9yIGlmIHN1Ym1pdHRlZCBpbiBhbiBJUSB0aGF0IGlzIHNldHVwIHRvIHByb3ZpZGUg
aGFyZHdhcmUNCj4+IHdpdGggMTI4LWJpdCBkZXNjcmlwdG9ycyAoSVFBX1JFRy5EVz0wKS4gTWVh
bndoaWxlLCB0aGVyZSBhcmUgb2xkIGludiBkZXNjDQo+PiB0eXBlcyAoZS5nLiBpb3RsYl9pbnZf
ZGVzYykgdGhhdCBjYW4gYmUgZWl0aGVyIDEyOGJpdHMgb3IgMjU2Yml0cy4gSWYgYQ0KPj4gMTI4
LWJpdCB2ZXJzaW9uIG9mIHRoaXMgZGVzY3JpcHRvciBpcyBzdWJtaXR0ZWQgaW50byBhbiBJUSB0
aGF0IGlzIHNldHVwDQo+PiB0byBwcm92aWRlIGhhcmR3YXJlIHdpdGggMjU2LWJpdCBkZXNjcmlw
dG9ycyB3aWxsIGFsc28gcmVzdWx0IGluIGFuIGludmFsaWQNCj4+IGRlc2NyaXB0b3IgZXJyb3Iu
DQo+Pg0KPj4gVGhlIDJuZCB3aWxsIGJlIGNhcHR1cmVkIGJ5IHRoZSB0YWlsIHJlZ2lzdGVyIHVw
ZGF0ZS4gU28gd2Ugb25seSBuZWVkIHRvDQo+PiBmb2N1cyBvbiB0aGUgMXN0Lg0KPj4NCj4+IEJl
Y2F1c2UgdGhlIHJlc2VydmVkIGJpdCBjaGVjayBiZXR3ZWVuIGRpZmZlcmVudCB0eXBlcyBvZiBp
bnZhbGlkYXRpb24gZGVzYw0KPj4gYXJlIGNvbW1vbiwgc28gaW50cm9kdWNlIGEgY29tbW9uIGZ1
bmN0aW9uIHZ0ZF9pbnZfZGVzY19yZXNlcnZlZF9jaGVjaygpDQo+PiB0byBkbyBhbGwgdGhlIGNo
ZWNrcyBhbmQgcGFzcyB0aGUgZGlmZmVyZW5jZXMgYXMgcGFyYW1ldGVycy4NCj4+DQo+PiBXaXRo
IHRoaXMgY2hhbmdlLCBuZWVkIHRvIHJlcGxhY2UgZXJyb3JfcmVwb3J0X29uY2UoKSBjYWxsIHdp
dGggZXJyb3JfcmVwb3J0KCkNCj4+IHRvIGNhdGNoIGRpZmZlcmVudCBjYWxsIHNpdGVzLiBUaGlz
IGlzbid0IGFuIGlzc3VlIGFzIGVycm9yX3JlcG9ydF9vbmNlKCkNCj4+IGhlcmUgaXMgbWFpbmx5
IHVzZWQgdG8gaGVscCBkZWJ1ZyBndWVzdCBlcnJvciwgYnV0IGl0IG9ubHkgZHVtcHMgb25jZSBp
bg0KPj4gcWVtdSBsaWZlIGN5Y2xlIGFuZCBkb2Vzbid0IGhlbHAgbXVjaCwgd2UgbmVlZCBlcnJv
cl9yZXBvcnQoKSBpbnN0ZWFkLg0KPj4NCj4+IEZpeGVzOiBjMGMxZDM1MTg0OWIgKCJpbnRlbF9p
b21tdTogYWRkIDI1NiBiaXRzIHFpX2Rlc2Mgc3VwcG9ydCIpDQo+PiBTdWdnZXN0ZWQtYnk6IFlp
IExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmggfCAgMSArDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAg
ICAgICB8IDgwICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4+ICAgMiBmaWxl
cyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCAyZjliYzAxNDdkLi43NWNjZDUwMWIwIDEwMDY0NA0K
Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2
L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC0zNTYsNiArMzU2LDcgQEAgdW5pb24gVlRE
SW52RGVzYyB7DQo+PiAgIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPj4N
Cj4+ICAgLyogTWFza3MgZm9yIHN0cnVjdCBWVERJbnZEZXNjICovDQo+PiArI2RlZmluZSBWVERf
SU5WX0RFU0NfQUxMX09ORSAgICAgICAgICAgIC0xVUxMDQo+PiAgICNkZWZpbmUgVlREX0lOVl9E
RVNDX1RZUEUodmFsKSAgICAgICAgICAoKCgodmFsKSA+PiA1KSAmIDB4NzBVTEwpIHwgXA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodmFsKSAmIDB4ZlVM
TCkpDQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX0NDICAgICAgICAgICAgICAgICAweDEgLyog
Q29udGV4dC1jYWNoZSBJbnZhbGlkYXRlIERlc2MgKi8NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDFlY2ZlNDc5
NjMuLjJmYzM4NjY0MzMgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTI1MzIsMTUgKzI1MzIsNTEgQEAg
c3RhdGljIGJvb2wgdnRkX2dldF9pbnZfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgYm9vbCB2dGRfaW52X2Rlc2Nf
cmVzZXJ2ZWRfY2hlY2soSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVzYywNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgbWFza1s0XSwgYm9vbCBk
dywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hh
ciAqZnVuY19uYW1lLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBjaGFyICpkZXNjX3R5cGUpDQo+PiArew0KPj4gKyAgICBpZiAocy0+aXFfZHcpIHsN
Cj4+ICsgICAgICAgIGlmIChpbnZfZGVzYy0+dmFsWzBdICYgbWFza1swXSB8fCBpbnZfZGVzYy0+
dmFsWzFdICYgbWFza1sxXSB8fA0KPj4gKyAgICAgICAgICAgIGludl9kZXNjLT52YWxbMl0gJiBt
YXNrWzJdIHx8IGludl9kZXNjLT52YWxbM10gJiBtYXNrWzNdKSB7DQo+PiArICAgICAgICAgICAg
ZXJyb3JfcmVwb3J0KCIlczogaW52YWxpZCAlcyBkZXNjIHZhbFszXTogMHglIlBSSXg2NA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAiIHZhbFsyXTogMHglIlBSSXg2NCIgdmFsWzFdPTB4
JSJQUkl4NjQNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIiB2YWxbMF09MHglIlBSSXg2
NCIgKHJlc2VydmVkIG5vbnplcm8pIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgZnVu
Y19uYW1lLCBkZXNjX3R5cGUsIGludl9kZXNjLT52YWxbM10sDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgIGludl9kZXNjLT52YWxbMl0sIGludl9kZXNjLT52YWxbMV0sDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgIGludl9kZXNjLT52YWxbMF0pOw0KPj4gKyAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAg
IGlmIChkdykgew0KPj4gKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiJXM6IDI1Ni1iaXQgJXMg
ZGVzYyBpbiAxMjgtYml0IGludmFsaWRhdGlvbiBxdWV1ZSIsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgIGZ1bmNfbmFtZSwgZGVzY190eXBlKTsNCj4+ICsgICAgICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+PiArICAgICAgICB9DQo+PiArDQo+DQo+SWYgYSByZXNwaW4gaXMgbWFkZSwgSSdk
IHByZWZlciB0byBtb3ZlIHRoaXMgY2hlY2sgb3V0IG9mIHRoaXMgaGVscGVyIHNpbmNlDQo+aXQn
cyBub3QgYWJvdXQgcmVzZXJ2ZWQgYml0IGNoZWNrLiBBbm90aGVyIHJlYXNvbiBpcyB5b3UgY2Fu
bm90IGZpbmQgYSBnb29kDQo+bmFtaW5nIGZvciB0aGUgQGR3IHBhcmFtZXRlci4gSXQncyBjb25m
dXNpbmcgYXMgcy0+aXFfZHcgaXMgY2hlY2tlZCBhcw0KPndlbGwuIFNvIHB1dCB0aGlzIGNoZWNr
IG91dCBvZiB0aGlzIGhlbHBlciBtYXkgYmUgYmV0dGVyLg0KDQpJIHNlZSwgQGR3IGhpbnRzIGlu
diBkZXNjIHNpemUsIHMtPmlxX2R3IGhpbnRzIHRoZSBpbnYgcXVldWUgZWxlbWVudCBzaXplLg0K
TW92aW5nIHRoYXQgY2hlY2sgb3V0IHdpbGwgcHJvZHVjZSBkdXBsaWNhdGUgY29kZSBmb3IgVlRE
X0lOVl9ERVNDX1BDLA0KVlREX0lOVl9ERVNDX1BJT1RMQiBhbmQgVlREX0lOVl9ERVNDX0RFVl9Q
SU9UTEIgaGFuZGxlcnMuDQpNYXliZSBzLyB2dGRfaW52X2Rlc2NfcmVzZXJ2ZWRfY2hlY2svIHZ0
ZF9pbnZfZGVzY19zYW5pdHlfY2hlY2s/DQoNCk1pY2hhZWwsIGxldCBtZSBrbm93IGlmIGl0J3Mg
dmlhYmxlIHRvIHNlbmQgYSB2MiBhZnRlciBwdWxsIHJlcXVlc3QuDQoNClRoYW5rcw0KWmhlbnpo
b25nDQo=

