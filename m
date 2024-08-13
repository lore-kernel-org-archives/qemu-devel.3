Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32FDC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 02:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdh1n-00066b-6G; Mon, 12 Aug 2024 22:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdh1l-00065H-KK
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 22:12:49 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdh1j-0004mK-1w
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 22:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723515167; x=1755051167;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rZYiWTDYFmZ2dds9RrEBHmkOfAvTbmO5Ba6jZr82j7k=;
 b=gIGXzrYgU49MAyrsGm1/fsyCksGH9BMgcfkPvK21dzoJ6XbudXnUIlgE
 sXNGGT8bdZVlsjiuvaUuH1/xVQw6z106Dlt2QtgkEuYwkiydAs87OqDee
 ZhoYsJgYbujqo2DtaHCkXD7vx5o4OhwQyrragtq03qEwooEMkyq2A9j9q
 dWEt6KSkVjdv6g8Gjn1HxK+Tuzx5Yg0Yk1+fNm7cBO2BUnA7iRFVmuNxm
 iQi7dBD2hZiBrbPFRDRgKtKW5no3yuh4V9SQaQHuDA/oD3Yau/4GjC1uA
 pHyi5nfSsjEMUH1knUch7SCdEO9yfSTW5pWjMN1s9aZtUI2g1cvcEX1k0 A==;
X-CSE-ConnectionGUID: 3zLirv2sQLaqIBO1hqu+AQ==
X-CSE-MsgGUID: /0eVyHzjSemDl+12z/FE5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32801674"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; d="scan'208";a="32801674"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 19:12:43 -0700
X-CSE-ConnectionGUID: a3NxwMwkQjOV88w8zxeOcw==
X-CSE-MsgGUID: DUihJoMzTWuEwfnJmX65FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; d="scan'208";a="63200046"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Aug 2024 19:12:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 19:12:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 19:12:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 19:12:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZRLrNxiCgLWyZDROyfUgUgYNJRaF08zw3pY348frXjyfnkwAhw/wCVYEjrLY9XyyI3Awbwmqq40KdXHPuFqidzHCQ/Ue7txPDhnRzASIxJqrazrT2wlK1VFE4vxyKJDzlwPxPIHrR/dQ8E28JbTH6AvpTIhgYYnqOeKh94hJ88TVcV+C9dZp2U7ZV9uxfk4f81wa94ziJBWxWXiyhWlpRjN1lTZzAqzBe97DjOI0ecx6fDfQpuXMuRfF+nXbvUyBwgkS5cm9AC0YQk6eT+ZcIKxg/W4AGb+6s48OejEQ4bTK+1rjv1Jya3Go8LZ0WOCt4elY5lOqCYPzDvXpwKCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZYiWTDYFmZ2dds9RrEBHmkOfAvTbmO5Ba6jZr82j7k=;
 b=F1Ychga1qt/hDxVDcJWsYu5MvV/Qxa5WV7w8XfhbvF81dM9PgnLvQGzdlD93I2mFlrMcDZNK0dUpv0Chuc2V7QxbTAHG/dUNA6asPVM/UCENGaZSXB2do1xyuu9un3QaA2ZXGvJWYXm9ZZt9Dxn5UOECFO4w8mqc7ejT2wjhaam4pFqzZs4KVTxIUYDkgGq8WeFqRTsLNX/5XXlAWydyywitjPRNUJw8H8M1JQaMTRcxRhgbXqVQPvg8CyJOZ/JHT6raJZiy5tusz+6qEXP6m/2Ijn2h0DcN/9IIQ0cnI3WBKQUOL63QA5YPwMi+nbKqkVQqaYgy5zCGecwTe669uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 02:12:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 02:12:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHa5wEJJTBdHO0BpEOuemhd//fJ3bIZx7mAgAOKmgCAACX0gIAHBdeQ
Date: Tue, 13 Aug 2024 02:12:38 +0000
Message-ID: <SJ0PR11MB6744A4015D28C6BFAD241B2792862@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
 <d245008c-ef6e-4a58-bcbc-869aa4901cf4@eviden.com>
 <ecfaec89-bdfd-0512-b9e4-d2dc237a9c56@intel.com>
 <1b46fc72-7e51-4585-865e-1d32b2ae6997@eviden.com>
In-Reply-To: <1b46fc72-7e51-4585-865e-1d32b2ae6997@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6397:EE_
x-ms-office365-filtering-correlation-id: b4b2c8c8-61aa-4c47-4ec4-08dcbb3d6791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Nkd2cGNSckNjOWg2bGZ0YzlsVkduZXFxc1hNb0cxNmNWWEhxL1djNWtpdXlD?=
 =?utf-8?B?OFZzL2VqOFE2d1FMWmVTbEM2RVlTMlhIbFp2Z21qNkVKa2JhQTE0WXhCWUVy?=
 =?utf-8?B?Rm9KbHFGV25Ub1Vzc0ZTZFBwMEdnMVpSMjdJb1BFT1hkc2FBMm1yQ3Z4VDE3?=
 =?utf-8?B?cDBYTnlhd2NDK281Y1lJVzh2NG1nU0hpRlEwcjFaRS90ZHNXcFh1V0lVd3RQ?=
 =?utf-8?B?UWJEY3A1Nk14cXpRc1FrWkVqNnJFaWN6bUU1WFRlcjFuRjRtQTVrdGZsaUcz?=
 =?utf-8?B?SWF1UEFOTUFkVit4aFMvUDdFVVdHOTM1WHZXWkNXdnVxVjV3L2ZpT0V1aGhX?=
 =?utf-8?B?T0VMa25ieDdtU3Y4YUd0cC8wQS9lL2U3ZjJ3K1p3ZzFDeG96NlVTUTErRi8x?=
 =?utf-8?B?ZTBlNURyTUExdVdSSmZJNS92Z1pKL2pWZGNscVRaeWtzSVpwN3pOZGR5MDF0?=
 =?utf-8?B?dFVodkJBdzV6NkhwcmpWY3JHeTBEVFdXQWQzMnc1SENHdnVjcXVnSlRZaTlZ?=
 =?utf-8?B?cXpMalhKMDlhYVczeGx3RDVQT2F0N0UySnc3WFhEREFxT1BLVWtmRGxNOE9o?=
 =?utf-8?B?TzU4SnNsTXorZTBmeTNXQU8zTTZtV3lLRU00K1llVXZIL3V2dlVISW5iZTNi?=
 =?utf-8?B?Tmo4ZE83VE5WOVd6MzlINGZQTGVRK094bHNxRWdybmQySGFnZHpEV3c1NTBn?=
 =?utf-8?B?eFV6VCs4U3RyWVcrTGROOEtzWDU1NG43VFB3bWF6eDNGT055QzRROTRRaDZU?=
 =?utf-8?B?cDdGdlhBcmswRDVvenhHWUgveFdDckZEZ1poNGJFMVU4SlUzdlJydVppdG1B?=
 =?utf-8?B?ZWpPTUwrQWFYalVLd1pkYUJjQTh2UjVVWXQvQXdJeDRvZzJYa0VRK3JmUHBS?=
 =?utf-8?B?aFVWQkVsQXZiZExYK1JlQndyKzRyNjhDeDJpNlZVKzF6THFscFBUcEs5cHFI?=
 =?utf-8?B?WFMvaVMxS0dxbFo4YjdHeXp4OHdoTVVHb0VDTFhUQUJDbW5CMk1CVTBjbXhB?=
 =?utf-8?B?SmJxblpkZkxZM0l1emZPeTJSTjRqQUhXVXJVNjQyUkZPOXl0ZVpSTHkwQTNy?=
 =?utf-8?B?azNFTWNhRzZtMXc1SEF2R01Ua3VoVGZyTUZCNWxBVUFYTWdJNndMOHNUR3pj?=
 =?utf-8?B?cmc2TUxOUjBMSEtoblRzaTBMdEgxRjRYM3JBUGdjallQb242K0ZkekJ5SnVM?=
 =?utf-8?B?TDdYS3oySHBLNzIvR2xVeXREbEpjTHlVcVVmRy9ZQ3g4YzcwQ2N3NzArWlBv?=
 =?utf-8?B?R1Rha25VSk5TUWUzZW9Fd0xmc2NZUUZqYUlKanp3R210ZGs5ekRuNXVkNjVW?=
 =?utf-8?B?dUE1bms4ZEV6R1laaVJINHJ2WFRMWFloKzZPMmozZkJpRWpEVXBNNmlKUHJ4?=
 =?utf-8?B?MG44cW13Sm5yZUxDMnVJQzMzdEtJV1RHK1FOQ2pGUExGMDB2MlRnZFlqZ3Zt?=
 =?utf-8?B?Z1V6eFlPYjhISWZmamJwQVhLc3RGenM1MEx4ZnZQVWl3eHY2MVN2UmxSeUhK?=
 =?utf-8?B?b1EyektlU2UvamJkYzNsZFpickIzVkRFaWJXUmxUckVsamJza3hhVWt6U2Iy?=
 =?utf-8?B?TUtCWDFmRmFNbFJOKzFDaXdHQnBTb0cxdU84Q3pEWW1NRmlmME5KM3RaelFT?=
 =?utf-8?B?Vkg3eFhma3NjN1ZvMnA2SmgwR3NJR2o4c0ozMXhMTEljaUl4Um1abFBwdWFU?=
 =?utf-8?B?bnlRTnhsd3lzamhlY1pYQWcyNm9mSHZOc0kxSEtHbS94VE1RYVozUi9EOEtv?=
 =?utf-8?B?Q1grSGZHOThORUMwbEwxdFVjYUJTTHBIOXkvOW5wOUY1NHJuVGhrVVlQVFR2?=
 =?utf-8?B?c2hoS1krdW5ySkpoeFlia2h5L0gvc0UrdlhOdHY3ZklkSWFSZGlCQlFwT1c1?=
 =?utf-8?B?WjZ0VlZ6YlF0anBFS0dJNzR1MnVPYlhmbXJzcU1XWUdiV3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXB3VHdzVlB0Mk1WOWE4clFzVkswOCtPMXhtSnQ0RDB4eVlhdjdVQi90eS9U?=
 =?utf-8?B?OWJxODZyVWFkZFc4TlV4UWo0UkEwdE53WVJJbGorcDFTTjJoNkRySlNYU0Vq?=
 =?utf-8?B?c3dodzFYbmZQYVI4L2psaWZVdVIxN3NEekZoMm9RRENCOUk0VXRiS2RLMEd0?=
 =?utf-8?B?MnNCWlhUbDJPOGNqQWZIZ2tmY3lWVW9iRVFrNWVSRi9iaE82bVIwQXFQVnZw?=
 =?utf-8?B?aHBwMHdObXk2WitFVW9TL0lEbGNuNzcybERBUjBPYU0wUU1uY1ZwNEsxc0p3?=
 =?utf-8?B?ZjdYOVFGTnkxaUNqanRLblJsbXd6S0JBekdDU0JoUm9pZ2RWMWw2TjRvc0ZD?=
 =?utf-8?B?RXM4dDYvU1h0NFdjUUxDZy9QZ3JkYk9QbWJxT0RCNXR6N3pVZDhEalBBeUEw?=
 =?utf-8?B?WWd0SmtjUjBhMDdCTFBNSDVibkhMY0MzMnVxS001TE1vV2FRSzJJanV1bjFa?=
 =?utf-8?B?eTZESnpsQXNJK01LK0N1QnhydjlFbS9EVjlmRHhIWEVKdEFycmJPTGpjeGJj?=
 =?utf-8?B?b0hDSGx6bGVNL2FWVGNleE9OZjV1aG9heWZSeDlNTlgwakNjWGxCMWNHMlc2?=
 =?utf-8?B?VGZZVHlQcEZxaXRuSVpRYTZ0MU9qNythSWpPSlQ1Zm54OCttdVJNVDViUE94?=
 =?utf-8?B?WkJEV1FmNHkwV1lwYjZpVml6UjVkcFBWZWgydzRraUI1aDFrSXdBL0kySUlG?=
 =?utf-8?B?N1p3WHhvbXZGYmhhY2g3b0U0b1orblpMMkFsTmJBcXB3cUpzS3lTQ0R6T2JP?=
 =?utf-8?B?MllzbC9xZzJxaGdHbURTamlva3Q5dVVOL2hIMUpwTVRLUUxLczRVN3lMQ2JN?=
 =?utf-8?B?S2hzazYrTEF4N0lwMURVWS9naXhpa0dmdVN1T3ZsTTRKeHlaRzVrdkM0Mkdk?=
 =?utf-8?B?L3IyUlBPMS9na1Q5Qk1zVUt6bnR6cWVZMnVPM1YvamdqR2dON3JsbEE4cUxS?=
 =?utf-8?B?emdHWHZXdHd4QWRiam1RQ2JUUk1ETXFOZUlocHIwcVlYWGFGbkkxYzYvNzdX?=
 =?utf-8?B?ekUzdDBEUXVWWDlHTFliVGpJS3Rhand1UElTOUhjNHJ2LzY5eXRTMTI4Vjhn?=
 =?utf-8?B?YXoyQnIzckx2MWVrUzErbllYVTJkYUd0N0dlcFdZNmEvQUgrM2poR3dvTEVQ?=
 =?utf-8?B?ZlJvdTFwMU00UHFkMlE1amZLeDI3cXNWbnk4U1poYlhEa0JvaHdTUk1qNVRu?=
 =?utf-8?B?WGU3Z0tHNHpHaGFmQmw4dXlvZFJqL05HVEZXRVJ6RXZ0dzZramRnL1hIMGV4?=
 =?utf-8?B?Z1R5d3h3Z3Fnd3o0aUYzTTg0ZnZsRTYxRXQ3WGg3ZHI0QmhmdHMvMi96T2M2?=
 =?utf-8?B?OUpWZWRobDRKSmFXZ2lIbWUyYWRWam82cnFYcjhpa1JZUEJMaDZkK21oZk9Z?=
 =?utf-8?B?NlZkdlBDeFp2dTNXUm5kTDBRRlBDVWJMNGdsUmplcVNFdFRCZ1VvMHlpL2Jh?=
 =?utf-8?B?THhVYjVRYW0ycHEwbklSS2FyRkZ2OEVTd05lV1pmbWN5c1djSy9iMVk5NEIr?=
 =?utf-8?B?Yzk4TFhXWktQelNKZG85Wmx1eWUvaGFlZCtQSmptYmZiSitxdmlTbk9YaEVv?=
 =?utf-8?B?Y3N4ZzdQUm4wLzZ0Q0ZFaDJNbmxtS2dqZ1h0M09ES3A5dCttYlVXZGJZVzI4?=
 =?utf-8?B?Nm5vdXRibEsweXE0a2NRR2hFbVJEK2tieTU4WG85RVY4MElwU2hkOGtHUldD?=
 =?utf-8?B?ZWpDdytwTjJjTlRZckNYSGwxT2JSVTBFemRWRVdrb0xGS2k2VDJQeGNuWUg1?=
 =?utf-8?B?eW5RZVdOL3JudnJVVStzQk5XVTlVZndEQmpiN1d5ZU5yeVIzZHRKaGRrbDBN?=
 =?utf-8?B?R3dJeUFkbDRUaGRnNFRrTmFhVFpWMCtuL0twSWFEZEpMRGhxNGFIZmJRemNR?=
 =?utf-8?B?MHhsZndKVWdSZWFxL2tGTnlNeWgvZkp1UlZoV0pEQyt3QTdpRVp1eENWK2Jy?=
 =?utf-8?B?QjNXbVBMdDFlQWFIZ2xnTndaQ1NDeW9heTRTeVVBSGgrL21mdkpmbjgxSFU4?=
 =?utf-8?B?VGZzZnZjOEJYa0NqMk1McDNpRVpJeG5sR1FtL0lqdEZHNmYzS3VlbG5QTjFP?=
 =?utf-8?B?UlpMdXBqTWI1Mzc1MDNqc2RHeHMyaXlwa3VZb0JPZHNpQVJTelFTQWlPNW9C?=
 =?utf-8?Q?UrO5V0zEInDSm+GKTC+NoomHS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b2c8c8-61aa-4c47-4ec4-08dcbb3d6791
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 02:12:38.4720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5gYgEXVmnVegfARqUacembPoZ+KE3ekqAzFjZ8Et48oZWCeUOcBAb7ekedQn4K+POvk0/PwB46EwZElPNY9Uyfghmj4DihDdKzJJvQ/Ufo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAwNC8xN10gaW50ZWxfaW9tbXU6IEZsdXNoIHN0YWdlLTIgY2FjaGUgaW4gUEFTSUQt
DQo+c2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbg0KPg0KPg0KPg0KPk9u
IDA4LzA4LzIwMjQgMTQ6NDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywNCj4+
IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50DQo+PiBpcyBzYWZlLg0KPj4NCj4+DQo+PiBPbiA4LzYvMjAyNCAyOjM1IFBN
LCBDTEVNRU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+Pj4NCj4+PiBPbiAwNS8wOC8yMDI0IDA4
OjI3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwu
IERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLA0KPj4+PiB1bmxlc3MgdGhp
cyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVu
dA0KPj4+PiBpcyBzYWZlLg0KPj4+Pg0KPj4+Pg0KPj4+PiBQZXIgc3BlYyA2LjUuMi40LCBQQURJ
RC1zZWxlY3RpdmUgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uIHdpbGwNCj4+Pj4gZmx1
c2ggc3RhZ2UtMiBpb3RsYiBlbnRyaWVzIHdpdGggbWF0Y2hpbmcgZG9tYWluIGlkIGFuZCBwYXNp
ZC4NCj4+Pj4NCj4+Pj4gV2l0aCBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBpbnRyb2R1Y2VkLCBndWVz
dCBjb3VsZCBzZW5kIFBBU0lELQ0KPnNlbGVjdGl2ZQ0KPj4+PiBQQVNJRC1iYXNlZCBpb3RsYiBp
bnZhbGlkYXRpb24gdG8gZmx1c2ggYm90aCBzdGFnZS0xIGFuZCBzdGFnZS0yDQo+Pj4+IGVudHJp
ZXMuDQo+Pj4+DQo+Pj4+IEJ5IHRoaXMgY2hhbmNlLCByZW1vdmUgb2xkIElPVExCIHJlbGF0ZWQg
ZGVmaW5pdGlvbi4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IMKgwqAgaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oIHwgMTQgKysrLS0tDQo+Pj4+IMKgwqAgaHcvaTM4Ni9pbnRlbF9p
b21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgODENCj4+Pj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4+PiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KPj4+PiBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0K
Pj4+PiBpbmRleCA4ZmEyN2M3ZjNiLi4xOWU0ZWQ1MmNhIDEwMDY0NA0KPj4+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+Pj4+IEBAIC00MDIsMTEgKzQwMiw2IEBAIHR5cGVkZWYgdW5pb24gVlRE
SW52RGVzYyBWVERJbnZEZXNjOw0KPj4+PiDCoMKgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExC
X0FNKHZhbCnCoMKgwqDCoMKgICgodmFsKSAmIDB4M2ZVTEwpDQo+Pj4+IMKgwqAgI2RlZmluZSBW
VERfSU5WX0RFU0NfSU9UTEJfUlNWRF9MTyAweGZmZmZmZmZmMDAwMGZmMDBVTEwNCj4+Pj4gwqDC
oCAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9SU1ZEX0hJwqDCoMKgwqDCoCAweGY4MFVMTA0K
Pj4+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUEFTSUTCoCAoMlVMTCA8PCA0
KQ0KPj4+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUEFHRcKgwqAgKDNVTEwg
PDwgNCkNCj4+Pj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lEKHZhbCnCoMKgICgo
KHZhbCkgPj4gMzIpICYNCj4+Pj4gVlREX1BBU0lEX0lEX01BU0spDQo+Pj4+IC0jZGVmaW5lIFZU
RF9JTlZfREVTQ19JT1RMQl9QQVNJRF9SU1ZEX0xPDQo+MHhmZmYwMDAwMDAwMDAwMWMwVUxMDQo+
Pj4+IC0jZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9QQVNJRF9SU1ZEX0hJwqDCoMKgwqDCoCAw
eGY4MFVMTA0KPj4+Pg0KPj4+PiDCoMKgIC8qIE1hc2sgZm9yIERldmljZSBJT1RMQiBJbnZhbGlk
YXRlIERlc2NyaXB0b3IgKi8NCj4+Pj4gwqDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0Vf
SU9UTEJfQUREUih2YWwpICgodmFsKSAmDQo+Pj4+IDB4ZmZmZmZmZmZmZmZmZjAwMFVMTCkNCj4+
Pj4gQEAgLTQzOCw2ICs0MzMsMTUgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRl
c2M7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICgweDNmZmZmODAwVUxMIHwgfihWVERfSEFX
X01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00gfA0KPj4+PiBWVERfU0xfVE0pKSA6IFwNCj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKDB4M2ZmZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykg
fCBWVERfU0xfSUdOX0NPTSkpDQo+Pj4+DQo+Pj4+ICsvKiBNYXNrcyBmb3IgUElPVExCIEludmFs
aWRhdGUgRGVzY3JpcHRvciAqLw0KPj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0fC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDNVTEwgPDwgNCkNCj4+Pj4gKyNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BJT1RMQl9BTExfSU5fUEFTSUTCoCAoMlVMTCA8PCA0KQ0KPj4+PiArI2RlZmluZSBW
VERfSU5WX0RFU0NfUElPVExCX1BTSV9JTl9QQVNJRMKgICgzVUxMIDw8IDQpDQo+Pj4+ICsjZGVm
aW5lIFZURF9JTlZfREVTQ19QSU9UTEJfRElEKHZhbCnCoMKgwqDCoMKgICgoKHZhbCkgPj4gMTYp
ICYNCj4+Pj4gVlREX0RPTUFJTl9JRF9NQVNLKQ0KPj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0Nf
UElPVExCX1BBU0lEKHZhbCnCoMKgwqAgKCgodmFsKSA+PiAzMikgJiAweGZmZmZmVUxMKQ0KPj4+
PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFMMCAweGZmZjAwMDAwMDAwMGYx
YzBVTEwNCj4+PiBXaHkgZGlkIHRoaXMgdmFsdWUgY2hhbmdlIHNpbmNlIGxhc3QgcG9zdD8gVGhl
ICd0eXBlJyBmaWVsZCBzaG91bGQNCj4+PiBhbHdheXMgYmUgemVybyBpbiB0aGlzIGRlc2MNCj4+
DQo+PiBZZXMsIHR5cGVbNjo0XSBhcmUgYWxsIHplcm8gZm9yIGFsbCBleGlzdGluZyBpbnZhbGlk
YXRpb24gdHlwZS4gQnV0IHRoZXkNCj4+IGFyZSBub3QgcmVhbCByZXNlcnZlZCBiaXRzLg0KPj4N
Cj4+IFNvIEkgcmVtb3ZlZCB0aGVtIGZyb20gVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDAu
DQo+T3RoZXIgbWFza3MgY29uc2lkZXIgdGhlc2UgemVyb2VzIGFzIHJlc2VydmVkLg0KPkkgdGhp
bmsgd2Ugc2hvdWxkIGRvIHRoZSBzYW1lLg0KPkZvciBpbnN0YW5jZSwgY29udGV4dCBjYWNoZSBp
bnZhbGlkYXRpb24gaXMgOiAjZGVmaW5lDQo+VlREX0lOVl9ERVNDX0NDX1JTVkQgMHhmZmZjMDAw
MDAwMDBmZmMwVUxMDQoNClllcywgSSdsbCBtYWtlIGEgc2VwYXJhdGUgcGF0Y2ggdG8gZml4IGl0
Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

