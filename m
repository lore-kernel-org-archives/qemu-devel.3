Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684E2C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 10:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJza-0007Ix-R3; Fri, 08 Aug 2025 06:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ukJzY-0007Gq-UT
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:06:28 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ukJzV-0006aj-P8
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754647586; x=1786183586;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XJ3JMdiz/dgU16tlx6R15OvMye6DI5ljBjw2wfVuTLw=;
 b=cWjGUdV/KTe3Qam0aIlbYQjSo2vPSXht87IojDy1oE6j8v5zx86l+KxV
 vwTeVONCMJ8ft0lyQL1Z55uGGPhOm6jpqNRHRzQ/lxAcqnvh13U0KHCeu
 jq5oInLUDusAnK3Jmvmxd7JdlCtCtMLAiiZen9Tp3UUfXW2L3UNLnrmYn
 cRIokcdLXiB/s1uqRLU8S8F9EBw9Ta30yv9F7d7NWnbBYp1soXLmHo5M/
 cgJZyR9FTOcogJrR4oyE4Zlfkd11ElxK7fQyP/EkhBGRaDwcUC+DOK2hA
 HMKckMkc1byXWdQuz1gIHWewWeSiwJv4bMq9/DIqdE7Q+zmPUOeeTO43X Q==;
X-CSE-ConnectionGUID: 8H8IGQrdSLqNmNuMfE3X7w==
X-CSE-MsgGUID: Slno8CVHTZSbYG+3xTsOEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57125311"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="57125311"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 03:06:23 -0700
X-CSE-ConnectionGUID: Mc1W2JzqSP+ZwcZc2CLvxQ==
X-CSE-MsgGUID: m4a0X5iGTmGBINtsAYKIaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="165677275"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 03:06:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 03:06:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 03:06:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 03:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY0PiMLkpMwxFcfSGuTH4syNy0slTm8m+P7P19HnSwI/VhE2Pv7aLlRLWrgw6v/z1o4UMDfvCIrTUcRa7BHFaF+6+pWL55t/ouwrbbjG5xIfVy+/3QtbWeilOzceYz4T9HDqXs9oKSioTqseA9TRVS0XsrnFf7Mn+DJ20NGtNyMms2tXScgmsBPGYdj0JhaaAZmT1YsYR06dak4+vIGwzUfS0iMB1IJfKeuo4cCBLJWuaQ73VSgaZMyxIi6py57dqKVLTEEk+PwEmL/MJtvL/nMr/Ux+ubNjiEq5Ye5s9V7y+gfGKlFLWO02mDEAVziT2tGsqQDToJHFep6v0n/7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ3JMdiz/dgU16tlx6R15OvMye6DI5ljBjw2wfVuTLw=;
 b=J6WZWc4y3NqTNnzNVhNtNaoJjGxErwgX4z3I+2PzlfB9PVl0aP6jb2q/PnbTsJQp/F5S44O8fsdcLB6UCVwmzCOA71KAhrSGraqCygqA0MlXeMQMlwEr9qgMP9Ek7GF8Vo1NmwBqDddHjdhG8mf523NW3dYCFSTD/By/Gnrkv6ONzAFSv9Znt1XCqkEOVGAUZoXSMwxvdePLehFAiaZFpAIQCMTNk/0Y/IGlBSm/Uz2Zkb+7zuCrjfmyHLJmgDQsOS92cGWw4p96RR2u6xzE9RCmhSxsXUtamrYWWXY4af/CyjC7CPSwK/Dhj8jhnW+yxFZR+vWABWAtIsZUdhlHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 10:06:19 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:06:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] vfio: Allow live migration with VFIO devices which use
 iommu dirty tracking
Thread-Topic: [PATCH] vfio: Allow live migration with VFIO devices which use
 iommu dirty tracking
Thread-Index: AQHcCBpD5Vb30jVjO0KE3V3fbSwvRLRYcT4AgAATxNA=
Date: Fri, 8 Aug 2025 10:06:18 +0000
Message-ID: <IA3PR11MB9136FA0497C10AD0234EEACB922FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250808040914.19837-1-zhenzhong.duan@intel.com>
 <9202e1ea-7b83-4caa-85ab-7621413a50f2@oracle.com>
In-Reply-To: <9202e1ea-7b83-4caa-85ab-7621413a50f2@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB7417:EE_
x-ms-office365-filtering-correlation-id: 00dee143-a7ea-4a6f-a2f5-08ddd66337ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WFB1eEhkZFJobTgrVVZ6Yzh0TDFIT2hLcjRFbFA0bGpheXJHRUNhamNrUUkx?=
 =?utf-8?B?OGNwU2M3dFlBYnYxWmkva01FS1hrUHEyV1lTc3JTUTFVQ3RGMGM4NlVKRVlK?=
 =?utf-8?B?L2RQck5VOUFyeG1SM1RwYTl4RWNPQkxzc1JwWUNra0RCZUZJVVlxSGJRaktQ?=
 =?utf-8?B?MXBGNWtobTQ3SEo1MlVCSlh2WE5xa1dSQjVzdVFBb1hPMXVQdkowcElndnFT?=
 =?utf-8?B?MkhIMVovQm0xSlJ2aDcvYW5rSU9ldlhoM3M1dEZReFpzbzMwcldxY0hWLzNv?=
 =?utf-8?B?N0JuekIwTzJkcjIvMWRjajZ6eVFONXkxamhwNGpjejBneWNKUkF0dGFDbzRv?=
 =?utf-8?B?Y3RZT0lKZmJqZEpldTduVjQ0cXJqRis3bnIrNnlpWGN5SVMzUjY4M3NBbTBN?=
 =?utf-8?B?VWRiUThYbXNPWjROd2FBTXYyMk9HemFWOUVqMmdZOGNWckRINDVwQnU0aEQ0?=
 =?utf-8?B?Nk95WUROOUhIRTQwMHVybEhVRUgyekp2WUlMZTVBaElkT2xFeDlqczEzYmxy?=
 =?utf-8?B?bXgzTVMzZkpFczJJUTYvZFU0VGdKVGl2anBmQW1PaHRhSUpjRnIxOEV2bUgy?=
 =?utf-8?B?NFBtQ09kUjRjWVpJckRYWGZhRHFhT1dpRGtqM1I4RVphK2JuUVJhOWF1Uy91?=
 =?utf-8?B?bUlMQm5COXloN3VNQjJFZ1JEbUFQV1AxSHZMbVNPR2k0YmVTTWJBSjlsdldD?=
 =?utf-8?B?eHByTjJFdG5iZTUybjYvdFc2V2pyZlBGeUNMenpTTVV4YWN0NXdDR3lwK1Uz?=
 =?utf-8?B?d2NpQm9GbVRMNkEvWDZZVHJqQjRVZ0kza0xVcVdhZ0oreXVFaE1GUnNYV3Y4?=
 =?utf-8?B?M1RteEFuSmFIdEVxQkdtTE95K3VRUUlsS0M1V2oxMm9rQ2pSMTN5a0hDUHVy?=
 =?utf-8?B?QnZzVE41bERVQytlNTkrdGtWYmoxUnFCQzZnY0xhWllNSHYvLzVIS003Ym1z?=
 =?utf-8?B?T0Y1QStGcHJ0NmhxWll2dTdaSi93MERwOGs0d2VUZnpacThWYnZ2VmF0SnZY?=
 =?utf-8?B?SEo2VkxXQXFoOHlxaWw2d1EzV1FDZjlrUVlvOXlKeld6U2lEQWZwS1VpNXdG?=
 =?utf-8?B?WlVia05PUnVaWE1WVFRnRk4vSlBDQzErUGxWQmsyOW82ZDBKWXhrTHk5aGg3?=
 =?utf-8?B?WmRGd0dnVjhnaWphcitCQ0ppbXhRd2NoY24yd25qTzB0MXdUM0I1T1N0Mm5p?=
 =?utf-8?B?NTdhQW92bG1NODNaN0Q5MGNOTzFvZzAvYnhSUldJcGdmVlBvS0tWK2FZUlBn?=
 =?utf-8?B?U0RUSUNnTHhFamRaenVXRzIrRVcwUXFEMCtYTWRmVStLK1U0SHFZU1ZpdkVR?=
 =?utf-8?B?K0Q4RUxSN3JjbExOdS90WlRBSkpVVyt3VDdDeHpVWHhsMFp1dW9LYVM2NTha?=
 =?utf-8?B?VkU2TlhKWFNJcS9FQVJxY3JkM1pQUmE1NENkZnNjcUJncFRTemdLcVI4SHov?=
 =?utf-8?B?Qi93cE9DeStYYXpncnF1ajIxY0FFanIyU3hJcTV0ZzNRbTV1K2NtSHp3Ukt0?=
 =?utf-8?B?REVjRUNteFUxTHBOMDV0OVZkQVRpYUhFbC9DTlhGWVZqQkRENk8rakxjazlZ?=
 =?utf-8?B?YTNNVGRPL0hPeHhuRlFOeEY1N2tWejk3MWlQcU9zT09XcWE3dzMyd3VuYUkx?=
 =?utf-8?B?Sm03V1JGTUE4b3dNT1JpYUdtcDlGMjk2V2RXM2pTem9TWUNzK2RSMm9KTVVC?=
 =?utf-8?B?ZGZHOXJHWFRKWUc4OTM1VUoxekl2NkYvVm14VDlsKy9nNUtaYWhBdGs5cUN5?=
 =?utf-8?B?TkdsSzhRTkQ0OFJaN3VoNUJldlFzeW1wc1FoWm1DRFN3T2ExQWVlUkUvWVJ2?=
 =?utf-8?B?eDFuYlVSREdpK1pHODRhZ3p6UVY5QjQ2bXZqTjJiaFdqZW1nOWNvS1JJQ1hG?=
 =?utf-8?B?QmtNN1hvM2lyY0tuTDIwRmozeFdZbTZuSGZVdzFEVElNaEtFeXc1MmU5TzJp?=
 =?utf-8?B?WW81cklXZzVSNlRYTmREWnJGQkRmMTFlZ1BWWXFxUnNUbFpLdkxQcEdJdm1K?=
 =?utf-8?Q?cxWzdpWNxw/FoqbQkeTlKngj4seW/Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWV3Tk1yN0hJeWNpOUFDWTdxYklia2RRRHVNVytFWHR3TFdYbnRHWlA2SldY?=
 =?utf-8?B?OEFIV3dCalQvekJ4QW9FQzZrdlQ2bkp5YXV1TytSL3JuRm1reUVZZkdXM0dV?=
 =?utf-8?B?QWtvK3lwdU1JWTRTR1ljY1BOSURja0VyWHdOaHAwSmRRRUpJOXprMkRXV0FM?=
 =?utf-8?B?ZUs5ZWV5eFc3QnZNOG1tTlJyL2xaeUFsekVWSG9mdmtmdGVZcHJVM003b0Ir?=
 =?utf-8?B?bXN4M1V0OUliR292cUtldUlYNDkxS25JSlNZUEZaZTdiNnlUTUs4c3FXNFFk?=
 =?utf-8?B?dTVwR2EyT3VyY1VLSnpZbjNOR3p5K1l1WFZNaC9PUm9nYTZHTFU5cWlZME10?=
 =?utf-8?B?YS94enJZNkgxRVBSQUV2Q2lQVlpVblAvMnY4SDFlYk45cHhJRDFPZnphVGVR?=
 =?utf-8?B?c1R3Y1hLRVVPWnZRLzVZRHRTOTEzOWdpbmo2WWljNGdjTisvUGpBWjczNlFF?=
 =?utf-8?B?MW5ocnkvR250VVVZMndYUlRIOWVJV1FzOXg3a2NGMjVKUENsMjFnSUdHVjhj?=
 =?utf-8?B?NzJNQjhTM2hXcjlPL2JUdDBkR0crdFdMOVdDam5aaXl1SHJxTWUxcmFvd1d6?=
 =?utf-8?B?Y0tiS0RlQzhZSkFyNStWOUR4N0xyVndSQkc5MHhuelB1aHNnWFJGU25neldp?=
 =?utf-8?B?eEhNN2dpZWI5SWVwOFRRNXM1cDhqTzAvV0VkN2dJNUtBdGhiZjF1R0RBUlNw?=
 =?utf-8?B?bEN1bndqdTZiWkxVbXRXQ09pK1RwSVVzVFB1eU1jckltaHRhSUF1RlVSZTBt?=
 =?utf-8?B?UDlTckhpN0hOY0VSNFYrRHczaFY5S1RGeFJWOHZLYnVKOHJudDhZQlNUTjFV?=
 =?utf-8?B?cG41UGZlT2lrRlBwMzZHT1AzVXlCQkJDc3lpcTRLQ2Y4aERYcEtQdnJWb0Ro?=
 =?utf-8?B?ZHlZNzVaY0wrNXpOM0Z3OHJUTUJ4QTEwS3lrRTRzcURlV3lpYVhiOVJZMWpP?=
 =?utf-8?B?TXR3bzdTVGhsOERVMS9TZzFqWTdzcXUxd01FRXFrZHpURVB4S1A2VkdCaTdm?=
 =?utf-8?B?WEVaNWF1VG1jMUg1T1VkSkdlamQ5eGhHeHczTXJJQTFQVWFXeUpzaUVxME1J?=
 =?utf-8?B?WUpHblo2SFpQVXlRaUljN0VBeTZjelg1V3pxUDFrUUlRL3dndWlrbGhZV1Rj?=
 =?utf-8?B?bCtadHNnYUU5a0lWRE9QaEwrSlNWbmdwZzZJR1VETWxyTUNSdjAzU1JCZCtV?=
 =?utf-8?B?eTJmUng5ekxhbVdBUXFLdGF4QUkvWGNseHc2VFVGeEViazNwNVROcEpYU21m?=
 =?utf-8?B?TFlrSHZUeENqQXh6SkNkNnFFT3V4M1pmVysvSTMwVmNPQXVsSmpQaFFIeDFm?=
 =?utf-8?B?Mm82OWZSN2JWQ05OOTk2MGxPYm1LNldhc2QyK2ZvejI2L251dzByc3JKMzE2?=
 =?utf-8?B?YU53QndYaVA0cXhPa0wrT2Y2dDhBenlFOTBhK1N0ZVRWekNTeWxPYXZQKzl1?=
 =?utf-8?B?ajNJV3Q4MU9HaWhGTloyT2xKbEdkYmRJejcrQ05CWFNZU0p0TnZPMlhrM1dh?=
 =?utf-8?B?UzkrcWhNek9oZW1yY3NxQ25WOFBLV2FCMmxCRlUvL0xDRGdjdWc0dERxYkZj?=
 =?utf-8?B?YTdoZmlpdDNDeUFhVVV6R0JscktyNG1Ubi9VNlkrdjdRREFWalQ5NzBvSU5L?=
 =?utf-8?B?RW05Yk9nQm1CZTNpV015WkZLTEZzeExkTEtmTGJnUjloRGViSDJXbzhWanNT?=
 =?utf-8?B?VVEydXRycDBuVEVxYy9KWFZKa3E4MEV3S1c1Sk15MHNwVnk3RCtPUGtBL29S?=
 =?utf-8?B?WkxQNmk3SU1iaG0vOU4xdkFYeGFXS3pzdkNJeEZJSFFobERJSjJNNlpnRnlV?=
 =?utf-8?B?aTA3bWJka2dSRHJrZmRZNmN6dE5URlBwN1RjTXBELzEzeVdPS1RJYjVSd2Mw?=
 =?utf-8?B?SXhiM1FoMmhETENsdXk4ZDArVHU2OW5NNlpKQWNyN3ZuU3JWRW52d2lrTTI4?=
 =?utf-8?B?dThobzJLTmdWa2ViT0t1QmpkY0Y0a0E2cmkrRGFOQjNlbWszOUxhWU5jRmRJ?=
 =?utf-8?B?RkFLdVBrZitpNWZvckliK0R2WXIvK3oyS3JZWjE5dmN6Uk40QUxyUVlOZnVt?=
 =?utf-8?B?WEFaL3Bob2p3TjZjMlFOK0RlRHJPYVZCYTBnSnpNNHIvQ2F3T1hnK0Y3ZHYz?=
 =?utf-8?Q?hkcWZaNE/GlG48cKoq8Dw9Rjg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dee143-a7ea-4a6f-a2f5-08ddd66337ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 10:06:18.2433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fNDNan2UHnOrJ0lcPYOMAYEqfBe7Us5oY+39NoyQTCpiFYVJPfhrz6uW5YbPkJ1eiTm6ecERLBU7Xw9Y6gcU46ZQuIqU/KGBh98Bb9GOaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgSm9hbywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0
aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZm
aW86IEFsbG93IGxpdmUgbWlncmF0aW9uIHdpdGggVkZJTyBkZXZpY2VzIHdoaWNoIHVzZQ0KPmlv
bW11IGRpcnR5IHRyYWNraW5nDQo+DQo+T24gMDgvMDgvMjAyNSAwNTowOSwgWmhlbnpob25nIER1
YW4gd3JvdGU6DQo+PiBDb21taXQgZTQ2ODgzMjA0YzM4ICgidmZpby9taWdyYXRpb246IEJsb2Nr
IG1pZ3JhdGlvbiB3aXRoIHZJT01NVSIpDQo+PiBpbnRyb2R1Y2VzIGEgbWlncmF0aW9uIGJsb2Nr
ZXIgd2hlbiB2SU9NTVUgaXMgZW5hYmxlZCwgYmVjYXVzZSB3ZSBuZWVkDQo+PiB0byBjYWxjdWxh
dGUgdGhlIElPVkEgcmFuZ2VzIGZvciBkZXZpY2UgZGlydHkgdHJhY2tpbmcuIEJ1dCB0aGlzIGlz
DQo+PiB1bm5lY2Vzc2FyeSBmb3IgaW9tbXUgZGlydHkgdHJhY2tpbmcuDQo+Pg0KPj4gTGltaXQg
dGhlIHZmaW9fdmlvbW11X3ByZXNldCgpIGNoZWNrIHRvIHRob3NlIGRldmljZXMgd2hpY2ggdXNl
IGRldmljZQ0KPj4gZGlydHkgdHJhY2tpbmcuIFRoaXMgYWxsb3dzIGxpdmUgbWlncmF0aW9uIHdp
dGggVkZJTyBkZXZpY2VzIHdoaWNoIHVzZQ0KPj4gaW9tbXUgZGlydHkgdHJhY2tpbmcuDQo+Pg0K
Pg0KPlRoZSBzdWJqZWN0IG9mIHRoZSBwYXRjaCBpcyBhIGxpdHRsZSBtaXNsZWFkaW5nIGJlY2F1
c2UgTE0gaXMgYWxyZWFkeSBhbGxvd2VkDQo+d2l0aCBWRklPIGRldmljZXMgYW5kIElPTU1VIGRp
cnR5IHRyYWNraW5nLiBZZXQgdGhlIHBhdGNoIGlzIGFib3V0IFZNcyB3aXRoDQo+dklPTU1VIHRo
YXQgZ2V0IHRoaXMgYmxvY2tlZCBkdWUgdG8gVkYgZGV2aWNlIGRpcnR5IHRyYWNraW5nLiBJIHN1
Z2dlc3QNCj5pbnN0ZWFkOg0KPg0KPnZmaW8vbWlncmF0aW9uOiBBbGxvdyBsaXZlIG1pZ3JhdGlv
biB3aXRoIHZJT01NVSB3aXRob3V0IFZGcyB1c2luZyBkZXZpY2UNCj5kaXJ0eQ0KPnRyYWNraW5n
DQo+DQo+Li4uIEl0J3MgbG9uZ2VyIGJ1dCBJIHRoaW5rIGl0IHJpbmdzIGEgYml0IG1vcmUgaG9u
ZXN0IG9uIHdoYXQgd2UgYXJlIGRvaW5nIDopDQoNClN1cmUsIHdpbGwgdXBkYXRlIHN1YmplY3Qu
DQoNCj4NCj4+IEludHJvZHVjZSBhIGhlbHBlciB2ZmlvX2RldmljZV9kaXJ0eV9wYWdlc19kaXNh
YmxlZCgpIHRvIGZhY2lsaWNhdGUgaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25n
IER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4NCj5UaGlzIGlzIHVuZm9ydHVuYXRl
bHkgbm90IGVub3VnaCB0byB1bmJsb2NrIHZJT01NVSBtaWdyYXRpb24gd2l0aA0KPklPTU1Vcy4N
Cj5IYXZlIGEgbG9vayBhdCB0aGUgZmlyc3QgZm91ciBwYXRjaGVzIG9mIHRoaXMgc2VyaWVzOg0K
Pg0KPglodHRwczovL2dpdGh1Yi5jb20vanBlbWFydGlucy9xZW11L2NvbW1pdHMvdmZpby1taWdy
YXRpb24tdmlvbW11Lw0KPg0KPlRoZXNlIDQgYXJlIG1lYW50IGRvIHRoaXMgKDQxZDc3OGRkYTAw
Xi4uZDI3ZTVhNWRiNWY0KS4gRmVlbCBmcmVlIHRvIHBpY2sNCj50aGVtDQo+dXAuIEkgaG9wZSB0
byB0YWtlIGNhcmUgb2YgdGhlIHJlc3Qgb2YgdGhlIHNlcmllczsgdGhvdWdoIEkgaGF2ZSBiZWVu
IGhlYXZpbHkNCj5wcmVlbXB0ZWQgaW50ZXJuYWxseSB0aGF0IEkgaGFkbid0IGhhZCB0aGUgdGlt
ZSB0byBjbGVhciB0aGlzIHNlcmllcyBidXQgSSB0aGluaw0KPml0J3MgZmluYWxseSBjb21pbmcg
dG8gYW4gZW5kDQoNClRoYW5rcywgdGhhdCBoZWxwIG11Y2gsIHdlIGhhdmUgaW50ZXJuYWwgdGVh
bSBpbiBpbnRlbCBuZWVkaW5nIHRoaXMgcmVsYXggd2l0aA0KdklPTU1VIGVuYWJsZWQuDQpJJ2xs
IHBpY2sgeW91ciBmaXJzdCA0IHBhdGNoZXMgd2l0aCBtaW5lIGFuZCBzZW5kIGFuIHVwZGF0ZS4N
Cg0KPg0KPlRoZSBnaXN0IG9mIHRoZXNlIGZpcnN0IGZvdXIgcGF0Y2hlcyBpcyBlc3NlbnRpYWxs
eSB0aGF0IHdlIG5lZWQgdG8gcXVlcnkgdGhlDQo+ZGlydHkgYml0bWFwIGJlZm9yZSB1bm1hcCwg
YW5kIHdlIGhhdmUgYW4gZXh0cmEgb3B0aW1pemF0aW9uIHRoYXQgbGV0IHVzDQo+c2ltcGx5DQo+
cmVhZCB0aGUgRGlydHkgYml0ICh3aXRob3V0IGNsZWFyaW5nIGl0KSBhbmQgc28gdGhlIHF1ZXJ5
IGlzIG11Y2ggZmFzdGVyIGFzIHlvdQ0KPmRvbid0IGhhdmUgYSBUTEIgZmx1c2guDQoNCkkgc2Vl
IHRoZSBsZWdhY3kgYmFja2VuZCB1c2UgZG1hX3VubWFwX2JpdG1hcCB0byBkbyB0aGUgc2FtZSB0
aGluZyBpbiBvbmUgaW9jdGwoKSwNCndpbGwgeW91IGFkZCB0aGF0IHN1cHBvcnQgaW4ga2VybmVs
Pw0KSUlVQywgYmV0d2VlbiBxdWVyeSBhbmQgdW5tYXAsIHRoZXJlIGlzIGEgd2luZG93IGluIHdo
aWNoIHdlIHdpbGwgbWlzcyBkaXJ0eSBwYWdlcw0KaWYgYSBidWdneSBndWVzdCBzdGlsbCByYWlz
ZXMgRE1BLg0KDQo+DQo+SSB0aGluayB5b3UgY2FuIHJlcGxhY2UgdGhlIGZvdXJ0aCBwYXRjaCB3
aXRoIHlvdXJzIGFzIHlvdXJzIGl0J3MgbXVjaA0KPmNsZWFuZXIvc2ltcGxlci4NCg0KT0ssIHdp
bGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5NaW5lIHdhcyBzcGVjaWZpYyB0byBJ
T01NVUZEIGdpdmVuIHRoYXQgcGVycGVjdHVhbCBkaXJ0eSB0cmFja2luZyAodHlwZTEpDQo+cmVx
dWlyZWQgZm9yY2VmdWxseSBlbmFibGluZyBtaWdyYXRpb24gdG8gbGV0IGl0IGdvIHRocm91Z2gu
IEJ1dCBJIHRoaW5rIGl0J3Mgb2sNCj5mb3IgYm90aCB0byB3b3JrDQo+DQo+CUpvYW8NCg==

