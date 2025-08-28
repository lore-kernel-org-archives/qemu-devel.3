Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E7DC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 09:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urYlV-00074y-4X; Thu, 28 Aug 2025 05:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urYlT-00073F-26
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:17:51 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urYlQ-0005CN-6S
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756372669; x=1787908669;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n7WjTBD6qOteuOyTK6kAi+c0hgltuIUYxszGH0rgroU=;
 b=RPYmiBOwvJWDkwlyIJmOcBJC2w8xEmwkCMA1DRCHY0A/zLrQ35gZfCTI
 Ww9CtGWFGOYIegDWyz+cRLUZAXhr0T3yKawa637duyCHtqGFx+8x/wVWL
 KA+UW2AQVEr15YABfnL0Nxo8Og815xwpanaBsrradPpF9WKh5/EB2xSZj
 +xRslAnyp/ulPnzb/j/ZZpNlZYCkv3g/vQlF83pzEBmSTmfxGXHQ9dErm
 EBLEAb+YYPRy2wNG1g3B38rhmhKPYXApndRHPHbd8b25LZnvH72t9C7TK
 gU0ThIseGKUo4zlokT2W0T5WKY7nSG3cAFtffETqqA2Mgh99tWNNQVTGQ w==;
X-CSE-ConnectionGUID: pmfqaoMpTfWvj5qaE7VUjA==
X-CSE-MsgGUID: n2IoLhdvR4OqqTB38tfUsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69730785"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="69730785"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:17:44 -0700
X-CSE-ConnectionGUID: HyheaUF1RDyJslOphM29lw==
X-CSE-MsgGUID: kd70fTIvRY+BqnnIc6X3dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="193721250"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:17:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:17:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 02:17:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnb/PdFoABw0zOj6o2JU5uuVlgtjRqsv+IDrAYu3dZqI7rICAIXIVVKB3QRuBByfKd1cJgF94KIPZsOOkYfnqVfgLHRg6rSC3rmxxmG/LH52pRVOcHc/51zy26fgNy8SA+AxBhDb3cM4eYkuMEGSHNJ1bOQ0fhq08arHXpA+zIxkf5A9ELKxEPjaeuD/iOQoWCXCsbfiEu1K8ywvKCRGNAIUyUonbp3WRZ+iY5a31ynKFDfFi+a9PcsrTZ2f8wOw7KPdsgSNG8wlciOwkWGS3Eq1V0L4u63WR2O6Q22jQg+dBZipmm6aZ1xVsH54LOax3xuPogHwsQyKidN4BSNgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7WjTBD6qOteuOyTK6kAi+c0hgltuIUYxszGH0rgroU=;
 b=TK//L/54SUEYC3NPzlMHBPBaHQQwjcr9MM8bXTtxPzI+YmHO911MHOnoqc46D+sqVnQ3VJZKRWgdGqtizGb2Pmwy2Gasbp57FLezGcJmN8/5pE+bieu2Yq38C8NyNlPf4VqDdclcPebbw+3CAnF5mj3SSUIrLVpDffvfhxr4bC6hdNVtMSwbu1NL5L2TbvNP7lCQHRsXpgDJyWE5AMrW8wF/hUNUYwQ2JCEX2Z34anqge1MGUBHwt9E87rIZEuZYdANdCCKdY+FclsZ0dWO0F5b1cFsB/wEhOZEVUJJtr9hXxQxCGPU2iAEUIDP7qV9M7DqbROD6jqnWY05LjIXfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 09:17:34 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 09:17:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Topic: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Index: AQHcEy/do9teDlFYnEKseS/ebbtbpLR2YRKAgAFxQiA=
Date: Thu, 28 Aug 2025 09:17:33 +0000
Message-ID: <IA3PR11MB91364B6A01BCCEFF73F7B589923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
 <05dac745-f612-4556-bd99-9de32ae63ccd@intel.com>
In-Reply-To: <05dac745-f612-4556-bd99-9de32ae63ccd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 4b5d9e9f-b61c-4588-7c2d-08dde613b8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Sm4vWE5YWVBaT3JlcmRpZUdVeGpaUm9VeVZkRjF5NzAvelFVSmxEOUozVitw?=
 =?utf-8?B?TFVMUVZPMUowUlJ5dlVEM0FTa1o4UVpEZVFxa2cvMWxJMFZzOVNudXlhSGRG?=
 =?utf-8?B?M3JLMldHajEvTWIzMnFSUUdJUjNnRzV4alV6MUtOaTNmV09rM2w4KzZoOWVE?=
 =?utf-8?B?blhxeUJES0NwN0RpNExpM0hvK2Njak5jMlNMMkFGSFRSaS9wZEpocFJBbDJt?=
 =?utf-8?B?eWdLdXVYK1lVMnVldGU3U0kzRU1JWE5nQkRremJMR2hFRUVvLy95bUpyVUNz?=
 =?utf-8?B?Ty9VT2FpM2NQK3RGNUVlR1hUcE8xSmZEVlhUTW1jajlhNG1KRkRCd25mdXpW?=
 =?utf-8?B?OGVpWnhzYm10am9wa2IyL1NFK3VjRFhPTzRJRjNrT2p0d0J6SFZPdlNPSkNB?=
 =?utf-8?B?OU11V2g4aitXaGZqbnRiWW9tcjkyQ0l1d0dWU092eUp3TlJJaHcyS2h5eTB3?=
 =?utf-8?B?eGUwK0NKU2JGY1NDby91YnVQZ2dMaENvMDFjY1lXSk0vTm5wRHgyZXpaUWox?=
 =?utf-8?B?bkNQUTZrUDZTaThVanZZejFYKzFuMk9pUFdCbUkvOE04ampmWkFGUlZnUkFk?=
 =?utf-8?B?bkR2R1JZaForaWNMUko0a1lBNm5qVmF2OEpCYWF6UEc1YUN0aUN4ZTRsZWJE?=
 =?utf-8?B?NW1PN0hURlorRHFHYjNmZW5lVWlSU3pzYjdDMXZZYXkvYjRydTU4UUtZVVQ2?=
 =?utf-8?B?alN3Rk0rZ0FjOWJiVFRiREN5Tm13dXlaK1prYXJyMy82eTVJZlNNNWo1QXow?=
 =?utf-8?B?T3JyT05qcXZvd3hxQjYyanUwMCtqWXdrVjNNR09vR2dmSzJQNWE0dmtvd0JP?=
 =?utf-8?B?SjZhSFhGZE42WDFsbGZmZWx3T1VhMUJnZ0o5MEZYcHhxdm51QVZiNkIraHpS?=
 =?utf-8?B?Mys4bnU3TW9pVUs1ZitPNWRpNnV5dUVxYVVUdVJOdnd3L01raXYydVJpL2Zj?=
 =?utf-8?B?TFdNY3N5TjVrdU1EUDF0eDMyV2hmaUVwNUFWSXhrM2RWQkZqcmZtdDE4U0Vi?=
 =?utf-8?B?bjRXT1ZCT21naS85OHJMSWduR0dKYm1jU053SnJUQU1pOW9INGtPZTdFcGxT?=
 =?utf-8?B?enVGMXJmRHpWRXphUXovRDlxNWRpT05zWUlaZW9mMDhWSDVWWUxISlFiWmNm?=
 =?utf-8?B?SFpFeEc1MllSb3hNeVV5aUFhVkF1d0djNWxONEpMYWx4Um1wNnZ6K2tyVzBS?=
 =?utf-8?B?QUV0TEFrNzAzNUtsMmo5eW5pUkZRa3RpdStwaTFzbHA3WUJjSkJGcVdxbk5i?=
 =?utf-8?B?bHovNkpPelNHRnJsWE9SRGxTV01VbCtMTEhxaFExWWc3RjFEVy9DTzN3UlJj?=
 =?utf-8?B?M2xTMGlhN2ViWFZ5SHNQQkhKMWpMR1JlTFlqVFQvTTRaVk1IM2NnU09wOU5J?=
 =?utf-8?B?aTFKWE9uRUVwd1N6VGYydFNGMTJid2ptN0NKMEdZOHE2YmVQS0lnVzVreFh4?=
 =?utf-8?B?eDV4RmtVVW4xTm9Xa3FhZDM4SGhuUkRIWmFxN29rL2duTjFvUm0vQVg1VXFv?=
 =?utf-8?B?NTFBTnl5UjRDOUYvYVdBR2NQa2dMdkZZUGhWVTJFSm1NM2doRGtoUWF1c0JR?=
 =?utf-8?B?Mi8yZkZtSHFJbUh3NkdSVFlYQVdaR3Rwem4rVlNaL2F6Zkc1S1VzaDJLOGVz?=
 =?utf-8?B?bFRCUFcxcll1bmV4NHViZ3A1ZElVb29PK1dybnJ6V2s5SzgzZDhwWFRGLzlV?=
 =?utf-8?B?Mjk3WC91c1M4ZmdWM2ZwdXpNUlNSWGhUbXVwajhuSmhaSFo2d210QWY4L1Bk?=
 =?utf-8?B?VnBNZW41TEFJNW1Jc2hMbm1YUkJ4RkR0eWNYalVCNUVPcTlaM0NRQ0tDaXh3?=
 =?utf-8?B?Y3hoaEVlTS8xVlhLTlM4QWswSTlYWEpxMVBONlB3bWphMk5TbFFTQnBhRHYw?=
 =?utf-8?B?SkEwSG01MzhmNkVReHovVThQdkFVYkpWbkdnUTJlT2ZOVUMyTkFSOGVRdXZR?=
 =?utf-8?B?YmRnZWszTmR3TVVuVUxBNHFHT05ISjNSK2I3N3ZvZVJMWnVGN3VqaFJKSVRa?=
 =?utf-8?Q?/5yrbWAFpHbRVhRVr631gcK6u4Balg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUdWeEk3cWFPdm8xZUJ3WWJHQWdkbXBKWHpVaFJCNUxHM2NDMm1iakJtVnVZ?=
 =?utf-8?B?KzlMT1ppb09LT2gza2dxejQ1b1dhWk1scDRKUExhU1pvYWtwR0tESmE0aWlU?=
 =?utf-8?B?YzU3Qlp3TXpwRmFwaEQ5R05WaC8yZkdZRFBDcTNvZDlEZklsamIzQkt4b1dR?=
 =?utf-8?B?TlVzZ3h4dXE4eDhEaDNuaGxIQUdkVktDZ3ZEb0crbWZYekJrbk9EWW1LNjJM?=
 =?utf-8?B?bEp5a056RDR4eldPNEFrMEJwc0piZ1FLbGh4NHJhLzFaT2d3d1A2L0JjdUpK?=
 =?utf-8?B?cnpMS1hDQ0s3bEFlaXdKSUtBZmd3eW1tVWpiWUxDVHpiV0IvNEUxUUs1MnZt?=
 =?utf-8?B?OGxiL2R0UjhZT3R4NzJpbTBsT3NNUmhTS25SdUNkTUU2L0xaSVNsMkdYYlVr?=
 =?utf-8?B?cFJHUHhCM09ZejF5OTlYTnBKZ2dYNUowczFLRW8vRkIxQVVjQmJoMjhyNktU?=
 =?utf-8?B?WlI0bldzajdiRDR4cnYvdUVyTlVydlJTdS91eUppcHFId1JpTVg3c3dncmpW?=
 =?utf-8?B?ckQxQk4vS3lVQTMyeitnWmxwNFJSR2JFM1ltOWZndFdvUWp1YjRWTDV3RU5R?=
 =?utf-8?B?MFB1QktndFU4b3c2aG5uRnRVQ05CamloUGorYXBTVDU1UGVPdVpLWjJyL3pt?=
 =?utf-8?B?RFM1UmNIZ01qVGxjT25wbVVjRVRhd1FLTHV6Q0VPcWx0dHFuYnh0d3YvUDRB?=
 =?utf-8?B?Qk9id2pYMTRrT0RIZ2VIQ3NOOHZkOUJrZUVxb0VnSkd6YUMydU84ZUNscUhh?=
 =?utf-8?B?MTlVV0c0dDlOV2tCek9VM3NOQk5heS9XOGRETDczTldaR2dVREdmckhvcWdy?=
 =?utf-8?B?RXJPejl2VjVQWks5cXl6OFVSZ2lyaE5ERUVhejJsVjRFbW90NnJ4bXJWMjEz?=
 =?utf-8?B?eDZPSkc0Nmh5bGQvOEpzeXYrTjlPUyt6MWNJYjNaQ01UOWhLQjBDdFErelBp?=
 =?utf-8?B?c2h2TWQ1cnNFZmxGYUN3M3Fhd2tBcXIrZzJKSGYxc0dvL1BTL2RPMDVNMDhU?=
 =?utf-8?B?UGkvd0xidDNtZ0hOOWpPZlllK3MxcStrd2hIK0lUeWI0VEYxaHU3ZE93NThM?=
 =?utf-8?B?cmlONXNzKzJVVU9ycWR4MXJkU2hrdzdQTXo4NFlBRlM2NlUxWC9mMkRQcXJ0?=
 =?utf-8?B?QlBNTTcyUmdVMHE3ODhwTndMWW1MOWkrSDkzSEhqWWVwSFZXNXA4eTFTNnN1?=
 =?utf-8?B?RFJoL2FUMHZlQVI1eEZyanIxZEhaMit6UzhsM09zcWJLVjlCTm41Q2JzWnhM?=
 =?utf-8?B?all0NG5zd0h1c0JFQkZ1QVJyYWYxMTdYejViSGx3YnNPM3Q4dmRINk5HbWo4?=
 =?utf-8?B?ZE9ZcVRqQkZhUnc1TlUycmZXNnBQQ01ycVdRK2FtYjdVM0FKSzU3K2dNNFVU?=
 =?utf-8?B?TldPcTJUemlBSVh6bVRzWWV4bU5pZ2VWQ2t0aXcyZUZxdCtFSnR4VGVPSGtj?=
 =?utf-8?B?REtEK0t6Uk5MZ3FMTmxid0h1Y0dPZDFFdWFaa2ZCemFtQVVrdjZhVzlzb2RX?=
 =?utf-8?B?aDAwZ0lBcjhqY2hyemFLOWFEa3BsZmt6VU0wMjdCZTd5S0Q2SE1QaFo3c05q?=
 =?utf-8?B?eTZUeVZrNlZCbXhtMEJBOHd2N0RMaUxham9GcUU0eFp0ckxCZGwrNkhkRUtv?=
 =?utf-8?B?WlRyNW5Kc1lubGM4NWlOdWQvRmRxSVpySXgzZ0hSaXRRTk5Zb0Vrb3d0VnZn?=
 =?utf-8?B?dzlRcGJBTVB3SmZFQ1RGTnR0T0VZT0QxdUdyYzhvRmQzY3FvT0Z4WjNPTTVS?=
 =?utf-8?B?NnBYSTZwL2ZXek5zV1U1U09hWUlhSENjT0RYSXVsRHRPTG91SERtSWFuTWNl?=
 =?utf-8?B?WFdxeFhEbWdiZmF0Zmh6enh2bmhXWkVjN1I5THFjQzBiaThTZHkyY1laSnZ2?=
 =?utf-8?B?UlNlTnR4OXc2OWpMYUdOZFN1V2xFMWlQcGZCcUhraWt3NGMvY0lFc2I1YnlK?=
 =?utf-8?B?RXZDU3h6bXBkWHNzUGYxUmdlVXgzQndybm5XNW9UVEFNMVE1cUhYUEpmaFZI?=
 =?utf-8?B?KzFoaXRiSlFiN2wvUGV1U3dpY0dZa1hDUDRRcTdIWTBaejVMTHNJaEhnQXA5?=
 =?utf-8?B?WlR5SVJUMk5VV2FTNGxJZzdzSU1YMDJGQmkxL3FOVzNGODZBMUhrdlhqNDRx?=
 =?utf-8?Q?8MfBOsPVTd+HcSqxFg02KU/LS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5d9e9f-b61c-4588-7c2d-08dde613b8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 09:17:33.7158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBQKZNao2Dab8UmNfrKNhrfp7QEOyj0xpy2DxWZAxQfV3eHTRpFbESHmxUGFdSIjcIhi4JGCzc5uwC9drT4/lWcXVVwCTS4/G+fvpnOoKxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDcvMjFdIGludGVsX2lvbW11
OiBJbnRyb2R1Y2UgYSBuZXcgc3RydWN0dXJlDQo+VlRESG9zdElPTU1VRGV2aWNlDQo+DQo+T24g
MjAyNS84LzIyIDE0OjQwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEludHJvZHVjZSBhIG5l
dyBzdHJ1Y3R1cmUgVlRESG9zdElPTU1VRGV2aWNlIHdoaWNoIHJlcGxhY2VzDQo+PiBIb3N0SU9N
TVVEZXZpY2UgdG8gYmUgc3RvcmVkIGluIGhhc2ggdGFibGUuDQo+Pg0KPj4gSXQgaW5jbHVkZXMg
YSByZWZlcmVuY2UgdG8gSG9zdElPTU1VRGV2aWNlIGFuZCBJbnRlbElPTU1VU3RhdGUsDQo+PiBh
bHNvIGluY2x1ZGVzIEJERiBpbmZvcm1hdGlvbiB3aGljaCB3aWxsIGJlIHVzZWQgaW4gZnV0dXJl
DQo+PiBwYXRjaGVzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaCB8ICA3ICsrKysrKysNCj4+ICAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwg
IDIgKy0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMTUgKysrKysrKysr
KysrKy0tDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5o
DQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IDM2MGU5Mzc5ODku
LmM3MDQ2ZWI0ZTIgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTI4LDYg
KzI4LDcgQEANCj4+ICAgI2lmbmRlZiBIV19JMzg2X0lOVEVMX0lPTU1VX0lOVEVSTkFMX0gNCj4+
ICAgI2RlZmluZSBIV19JMzg2X0lOVEVMX0lPTU1VX0lOVEVSTkFMX0gNCj4+ICAgI2luY2x1ZGUg
Imh3L2kzODYvaW50ZWxfaW9tbXUuaCINCj4+ICsjaW5jbHVkZSAic3lzdGVtL2hvc3RfaW9tbXVf
ZGV2aWNlLmgiDQo+Pg0KPj4gICAvKg0KPj4gICAgKiBJbnRlbCBJT01NVSByZWdpc3RlciBzcGVj
aWZpY2F0aW9uDQo+PiBAQCAtNjA4LDQgKzYwOSwxMCBAQCB0eXBlZGVmIHN0cnVjdCBWVERSb290
RW50cnkgVlREUm9vdEVudHJ5Ow0KPj4gICAvKiBCaXRzIHRvIGRlY2lkZSB0aGUgb2Zmc2V0IGZv
ciBlYWNoIGxldmVsICovDQo+PiAgICNkZWZpbmUgVlREX0xFVkVMX0JJVFMgICAgICAgICAgIDkN
Cj4+DQo+PiArdHlwZWRlZiBzdHJ1Y3QgVlRESG9zdElPTU1VRGV2aWNlIHsNCj4+ICsgICAgSW50
ZWxJT01NVVN0YXRlICppb21tdV9zdGF0ZTsNCj4+ICsgICAgUENJQnVzICpidXM7DQo+PiArICAg
IHVpbnQ4X3QgZGV2Zm47DQo+PiArICAgIEhvc3RJT01NVURldmljZSAqaGlvZDsNCj4+ICt9IFZU
REhvc3RJT01NVURldmljZTsNCj4+ICAgI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+
PiBpbmRleCBlOTU0NzdlODU1Li41MGY5YjI3YTQ1IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQo+PiBAQCAtMjk1LDcgKzI5NSw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4g
ICAgICAgLyogbGlzdCBvZiByZWdpc3RlcmVkIG5vdGlmaWVycyAqLw0KPj4gICAgICAgUUxJU1Rf
SEVBRCgsIFZUREFkZHJlc3NTcGFjZSkgdnRkX2FzX3dpdGhfbm90aWZpZXJzOw0KPj4NCj4+IC0g
ICAgR0hhc2hUYWJsZSAqdnRkX2hvc3RfaW9tbXVfZGV2OyAgICAgICAgICAgICAvKg0KPkhvc3RJ
T01NVURldmljZSAqLw0KPj4gKyAgICBHSGFzaFRhYmxlICp2dGRfaG9zdF9pb21tdV9kZXY7ICAg
ICAgICAgICAgIC8qDQo+VlRESG9zdElPTU1VRGV2aWNlICovDQo+Pg0KPj4gICAgICAgLyogaW50
ZXJydXB0IHJlbWFwcGluZyAqLw0KPj4gICAgICAgYm9vbCBpbnRyX2VuYWJsZWQ7ICAgICAgICAg
ICAgICAvKiBXaGV0aGVyIGd1ZXN0IGVuYWJsZWQgSVIgKi8NCj4+IGRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IGUzYjg3
MWRlNzAuLjUxMmNhNGZkYzUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTI4MSw3ICsyODEsMTAgQEAg
c3RhdGljIGdib29sZWFuIHZ0ZF9oaW9kX2VxdWFsKGdjb25zdHBvaW50ZXIgdjEsDQo+Z2NvbnN0
cG9pbnRlciB2MikNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF9oaW9kX2Rlc3Ryb3koZ3BvaW50
ZXIgdikNCj4+ICAgew0KPj4gLSAgICBvYmplY3RfdW5yZWYodik7DQo+PiArICAgIFZUREhvc3RJ
T01NVURldmljZSAqdnRkX2hpb2QgPSB2Ow0KPj4gKw0KPj4gKyAgICBvYmplY3RfdW5yZWYodnRk
X2hpb2QtPmhpb2QpOw0KPj4gKyAgICBnX2ZyZWUodnRkX2hpb2QpOw0KPj4gICB9DQo+Pg0KPj4g
ICBzdGF0aWMgZ2Jvb2xlYW4gdnRkX2hhc2hfcmVtb3ZlX2J5X2RvbWFpbihncG9pbnRlciBrZXks
IGdwb2ludGVyDQo+dmFsdWUsDQo+PiBAQCAtNDM3MSw2ICs0Mzc0LDcgQEAgc3RhdGljIGJvb2wg
dnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cw0KPipidXMsIHZvaWQgKm9wYXF1ZSwgaW50
IGRldmZuLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElP
TU1VRGV2aWNlICpoaW9kLA0KPkVycm9yICoqZXJycCkNCj4+ICAgew0KPj4gICAgICAgSW50ZWxJ
T01NVVN0YXRlICpzID0gb3BhcXVlOw0KPj4gKyAgICBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9o
aW9kOw0KPj4gICAgICAgc3RydWN0IHZ0ZF9hc19rZXkga2V5ID0gew0KPj4gICAgICAgICAgIC5i
dXMgPSBidXMsDQo+PiAgICAgICAgICAgLmRldmZuID0gZGV2Zm4sDQo+PiBAQCAtNDM4Nyw3ICs0
MzkxLDE0IEBAIHN0YXRpYyBib29sIHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZShQQ0lCdXMNCj4q
YnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCj4+ICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+PiAgICAgICB9DQo+Pg0KPj4gKyAgICB2dGRfaGlvZCA9IGdfbWFsbG9jMChzaXplb2YoVlRE
SG9zdElPTU1VRGV2aWNlKSk7DQo+PiArICAgIHZ0ZF9oaW9kLT5idXMgPSBidXM7DQo+PiArICAg
IHZ0ZF9oaW9kLT5kZXZmbiA9ICh1aW50OF90KWRldmZuOw0KPj4gKyAgICB2dGRfaGlvZC0+aW9t
bXVfc3RhdGUgPSBzOw0KPj4gKyAgICB2dGRfaGlvZC0+aGlvZCA9IGhpb2Q7DQo+DQo+aG93IGFi
b3V0IG1vdmluZyBpdCBhZnRlciB0aGUgYmVsb3cgaWYgYnJhbmNoPyA6KQ0KDQpUaGV5IHdpbGwg
YmUgdXNlZCBpbiB2dGRfY2hlY2tfaGlvZCgpLCBzbyBuZWVkIHRvIGluaXRpYWxpemUgdGhlbSBl
YXJseS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPj4gICAgICAgaWYgKCF2dGRfY2hlY2tf
aGlvZChzLCBoaW9kLCBlcnJwKSkgew0KPj4gKyAgICAgICAgZ19mcmVlKHZ0ZF9oaW9kKTsNCj4+
ICAgICAgICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4gICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4+ICAgICAgIH0NCj4+IEBAIC00Mzk3LDcgKzQ0MDgsNyBAQCBzdGF0aWMgYm9vbCB2dGRf
ZGV2X3NldF9pb21tdV9kZXZpY2UoUENJQnVzDQo+KmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2
Zm4sDQo+PiAgICAgICBuZXdfa2V5LT5kZXZmbiA9IGRldmZuOw0KPj4NCj4+ICAgICAgIG9iamVj
dF9yZWYoaGlvZCk7DQo+PiAtICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+dnRkX2hvc3RfaW9t
bXVfZGV2LCBuZXdfa2V5LCBoaW9kKTsNCj4+ICsgICAgZ19oYXNoX3RhYmxlX2luc2VydChzLT52
dGRfaG9zdF9pb21tdV9kZXYsIG5ld19rZXksIHZ0ZF9oaW9kKTsNCj4+DQo+PiAgICAgICB2dGRf
aW9tbXVfdW5sb2NrKHMpOw0KPj4NCj4NCj5MR1RNLg0KPg0KPlJldmlld2VkLWJ5OiBZaSBMaXUg
PHlpLmwubGl1QGludGVsLmNvbT4NCg==

