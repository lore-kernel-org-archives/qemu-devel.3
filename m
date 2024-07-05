Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142EDC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPecD-0002bd-Ku; Fri, 05 Jul 2024 04:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sPebb-00018T-5J
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:47 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sPebZ-0004bJ-3m
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720169265; x=1751705265;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U6mykfvrXJsmWmw7zkUnbXLhengYmJoziYlm2euqrvg=;
 b=QcDPZj8I7stdYdSfJ4PUs/T8uuon6/KS1yI44ZzrGVW1LqQ16ZZ+7fxy
 u0XSMNjNxXlZKL8G0U2dmFGJ7akuij8NZC7wjQbnyM1giSiZHwmQh9WtE
 lETCXoHY/CgEqP1qFKSsdMCuA5cmeM0oEEkQhVWwe89vNUduvAvMtnfkm
 NMMGI02LQSSydUI4jLtlOUUFIJ+/InzziBofW1CKNoz+5tn+OTfvy3xCi
 q/5kD/QbEFcAGZoUTfq3N9bx6wcv1IEaUpcSSthoPSLZAabRgBlMKyN5G
 3g7SNg3uJG62H8O2xa0BzfFtwaWPWt5x6IMX99SRwO7VyC8IQhKJf1woZ g==;
X-CSE-ConnectionGUID: 5X3A3R2UR/Gf+3yTplGhzQ==
X-CSE-MsgGUID: C4Xq0gIkRVmT4afLc1zckA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28071774"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="28071774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 01:47:40 -0700
X-CSE-ConnectionGUID: ohJtnORRQpCdZP8SEvJiuA==
X-CSE-MsgGUID: Pvo5Mj0mTN69HXpFePr+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="47465352"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Jul 2024 01:47:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 01:47:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 01:47:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 01:47:39 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 01:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4Z75urjugtTlY77EVX7MA0ds+FRLIJnZikVAx2w7NSLnfOBPritKgW47hLkMCF7ME4Gsv15wEkileLuBCQ/lcJqQyfF2+tNaREgLVjmFD+BSi3b4vnrZT2DWnE68NGTEksmzMlUmym1oSgJrx27K22jfEo/H4FeyF5KPuk7Mosfsu7Gj2Hwjwuv0Y9kSt4V9g2pEQD5oYCtBqAXnXy7SZzyzhpQQr5M0Ig8UTuKRiPeUHmcaeSYanAfs2uFFnXcSKQSIaqCwAzOOhA3O/iPHyRWiI0vappdxbT7RYjNFDsFSHbXXkbpxz8Ybnx1gu1bGP8HkzdMlsg5Xh2HGAw8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6mykfvrXJsmWmw7zkUnbXLhengYmJoziYlm2euqrvg=;
 b=ksa1N4779CZu8dbO8rmk9e83I6jVxbSdZx8yEHD2mxl3H2TWdNiYSVeyraDmW9Xu47urOEZ3XxuMj3a0IzIQFGr+d387mLEPgSMYtnYZIei+ff+q2WOrV8O85G4k1l28FDzxFIAtT82cHv3+rZZxEtWLGrRh/TmBQOh6AA46DDaUtuQGXYnaYa6QeOye0MueFyw1VQQEoZmn3IEK/R8weBqW9pBBubs9B9bkQSOESLC5D2UVixmKmUvLN84guvrv6LL2WMY/zuBjDOPwpKhB4JQtMUZF17/O1CGwCWQAIBWipTXSCdi9reBDkWJAFL+tFTYze3oyxRpPAwgmYT/Ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8306.namprd11.prod.outlook.com (2603:10b6:930:c6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 08:47:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 08:47:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH  v3 1/3] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH  v3 1/3] intel_iommu: fix FRCD construction macro.
Thread-Index: AQHazpilPvi8AA6UY0+AS7/gkgP0ZbHnnxdg
Date: Fri, 5 Jul 2024 08:47:36 +0000
Message-ID: <SJ0PR11MB67442382DF94AF44782AB17692DF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
 <20240705050213.1492515-2-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705050213.1492515-2-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8306:EE_
x-ms-office365-filtering-correlation-id: ea36b8ee-6d15-4684-1e76-08dc9ccf1ece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NGY4T2YybVlkU1dHVmhDNXBIbGZZaEJ6aW5CdE1YWXNEK25ZM2ZvcUNOTU5t?=
 =?utf-8?B?ZWtoUVdpanhCRFVoODc4TzYxaDQ0OW95eTA0NjBJWjhYaXp1Nk1FN0wvY0hO?=
 =?utf-8?B?b2lPcVpnUHpEQ3YvUnVmYXpEVmp4ZVN3NXNReGw2UXJqamQzbE5RSHlzRXEv?=
 =?utf-8?B?VFZvNEs2ZWpsek5LWTkyNVdEMzFTUkdHTmtKdzEvTmw4MWxmU2pocHVQcW9j?=
 =?utf-8?B?bDEvTUpuK05JMGFPSHpyS2dYUXBaYlQ4NEE4ZlJhbzh4L1VaLzIzNmlyQjJT?=
 =?utf-8?B?V296UzFOR1MzeklLdUhucFU2eDJkRjk2Y1hTNmNCU2tsRXpWZHlPdlJNVXdq?=
 =?utf-8?B?TFdRRjhXR3FvMlVGSU1yN3VLUHl2aFB5UXJSOEJOQVJtUnZVSzZKNlFKYmlT?=
 =?utf-8?B?T3RyWHpIUUsvbXRZWnEwaTRMOTlLMC82ejM3MG5rcWdNNXB5R0VGWCt4VUtq?=
 =?utf-8?B?TjV5VkpnSzk3dmtZNWdZWFY4MjB4Q3drMnkxdjlMUWZPVHBhSXVCcnVJZVc4?=
 =?utf-8?B?enZscmNQTy8rOXIxZWk5L2tsT2ZKRTc3UlBYd2luMjZiSVhQeFZ0OHg4V0ZK?=
 =?utf-8?B?cUh2RVpNWUNmTlk4ckRZVjNaVlowQndGOWRKZlN2MEpISy9xRi9GT3AzWklv?=
 =?utf-8?B?QlM0Si82S3Qzem9NOGZpL3ErajdhT2RGcnVsYzlpakJnWHFHOHFLM3kwRjdw?=
 =?utf-8?B?aTJEZ0RzZzZibHlMbVhCampPMWprZlptcDVrWmkvMXZmRlRCVkNWamhVK0cv?=
 =?utf-8?B?L2U4K1dsazFEZWlqZTZWOGtpS3hocFBwM01SY3FVY2ZDSXBYb2RJMlk0cXpq?=
 =?utf-8?B?cTF1V05RdzFBbGlDNXNXdnpoc0VxczBVTVdkUzdrNjd2R0tZMk44UVdUMUFz?=
 =?utf-8?B?d29XR1lyWXlRUVVRL3Nlb0VmQUVWRlZtWXVrTUhQN2pGVllMS2Z4WDFvTlhp?=
 =?utf-8?B?REJaQndlWC9sbWVBUmNoSDhPcFBYMXdYb2s2UU1jMDFGNUN6U0tNYkR3RTFG?=
 =?utf-8?B?eFdxZFRmMDNkem1ZblVTSERPcEU2ZTBocjJLeU04dHlRSFdUSjZyY0tIVnVP?=
 =?utf-8?B?LzQrWWt4Mm51WjRTMVpxVWE1bk1HNXdyT0lYR0h3RFBVc1JBYzhUM0huNnJa?=
 =?utf-8?B?OHpVM1lYYlB1RmdCQjNNOFczeVNuKzVDM3JtMC9CZHJ0V3piNHFZRzdnWFdv?=
 =?utf-8?B?eHZhUXIrekJPWXhjUzc4UlplaGNxRHVpbVh2UzN4UVU2NEhpRTErUWtIRWdU?=
 =?utf-8?B?djNFblg1aGZ2WlNLa2lmYnc5UlV4RWhMVlp2dTZaUFp6cHlDcy9aZjNEcUVT?=
 =?utf-8?B?RlN0NE1vVGQ4RjBYVDRDYXphV2hVSDJWVnhQRDN2ZEVnd2FKV0M5SkxOanJp?=
 =?utf-8?B?ckZwYUFSZGw5aE9LVW1SOEU1U00zMDNvL0dYd3NGcm1Yd3BvY3V0SndhRHpi?=
 =?utf-8?B?Ykl1QkJBOE5POXVBSG1GZGdlY0ZvM2dzY1dtWGtJQVRhbkRsMGhsOEpBaFpa?=
 =?utf-8?B?ZktpQXVEeE1jL3FobUJrcndpclppcm4rTnRyc1kxVllkOEQ0czBIYjM4TFl1?=
 =?utf-8?B?UEE5Mk1XOUgvTmJvTnZLZjRxM2ZXZklFS1B6V3Q4bmVRK2x2SjBLWVlud012?=
 =?utf-8?B?WU1BRm9mekhLeTdoL2MrRWV4M1M5V0NFUTFrWjV4V3pxU053OGJwZzJwV2t1?=
 =?utf-8?B?SlNtNGNkc0R0QTZXdStjajVzRmhJRTMzTGpWNWRQUC96alJWWEgrNWovWWpp?=
 =?utf-8?B?bFZ6VUhpZnV6OEJxK1JtRk9CdFlqakN3azl1R2kyZlVGWW5iakxIUzhDZmZ6?=
 =?utf-8?B?UUZ1d2pITTdVWm5Pc2pLKzBNVE13RThTaTlGVGhPdDlVYmRSdmh3TExlaVpn?=
 =?utf-8?B?elhBS2J2K2t5Q1krTzdvYUhUVFp6N2VIR0gzNnk1eW14YVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmxUa2lESzNLdmJNcjl6Q1lBMFRFdTZQVjJRUyt4MWZBeGpPWWh4RldLRlJp?=
 =?utf-8?B?SHZLSXJ3NGRTKzA2WXFPZnVLd1hOekdrNHFyL1VwUnJOMm81SFZEZWtkdlJP?=
 =?utf-8?B?Z1hyM2ZERTRleTZlK3R0QlZMNUlxejJOQmdFWk9rMkRaRUVUcFlMa0pXMFNl?=
 =?utf-8?B?V1ZEWFdGWWlnakZRUkFRZzltaVZvUE5LcUdOK2hCaHlXUVhsYVYvdCt1N2Z6?=
 =?utf-8?B?VXNXL0YyWnk3Tm5UQWRRdjRpcGlIc2ZBQ2N4M2lIZFptdnFQZlJjam9BNkZl?=
 =?utf-8?B?MUYyOCt0OTlnU2lTU2ZqZ3BRbHJEaEF2Z0kzNFJxVmZ3Q0xmb0ExamZQQUxq?=
 =?utf-8?B?YVpLbzFjVnJ2ZzRUaGlRT2l4d0ZYdGQ3STBBZnhtYTlOcnFtU3F6UXMveDhN?=
 =?utf-8?B?Vjh3MURQT21ETkR0dDZoVWhvcko3MUdjNDE4WTd4R002SEVKKzR2MjFuV2x6?=
 =?utf-8?B?ZFI5ZXE1L2tXM05jOHFWalRNRzJmaFFCNy9RV2E1TWxzbDJXRTB1anBsNzc5?=
 =?utf-8?B?bS9RUVUwWnUyQmVQdWM0dThMY0QwOEtDMEF0c1NlSmd2dlh2Y3h1SmNJNmZu?=
 =?utf-8?B?ZDJXR0VGeEJSZFU4OG1XN0RBZVVnalFGZnV4VTRUdUVCRUNXRFEvUS9lOXlE?=
 =?utf-8?B?cGFEYmI0dWlpSnpoTzE2OGQ1d1R2R084cXRxMDdtYWg2WGtpM0JtSm5vK3dk?=
 =?utf-8?B?MEVzbU5sVHdpT2hlWWM4OC82YUVOaU5iMG9mOXZEc2kyMjV0S0h0ZGp2N1M2?=
 =?utf-8?B?R2lQZFpxRU5KY1dSSENZdWpURG1OL2FhUm82RWZhSU1HTmVZKzU3SFhXZXAz?=
 =?utf-8?B?dllFdDR4dDl4Tmc2Z2Zzd21IY1dUYUYyZ0p2ZStvZDlHSDRjZkhvaFZTZzFG?=
 =?utf-8?B?aDRYclZickcxdTVWN1hTMnAxK3kzVzBtdUJiMHFNaERMNXlyWFRZVnVEQU5F?=
 =?utf-8?B?eURqRXlBN1VsclFwYThCL25vK3pob0h3R2pLVHI4RjZNYkFHZjBZQ1hpOW5U?=
 =?utf-8?B?Q3NDVEUrWUc5Zk1DanY0SHkzbFhEZGpMUDVvYnM2QkFWOGtVclhWbzV3Ym1J?=
 =?utf-8?B?VlVEZHArd2dFZlBtSzlQT3RVR05VblJFbVcwWWFpSG8zVmdyWFFweHBvc01F?=
 =?utf-8?B?eENuLy8wWVNsd25WSThRaDFoUERtZEpOeUQzRmgyM3pTazVSYk4reWd1bFUx?=
 =?utf-8?B?Y2lXUmRUZE5LZ2RQUGY0L3VoRVZ0QUNjZ0ZsN0VPM3IxSEx4ek1vanRZNU5B?=
 =?utf-8?B?cEx3RFErNmZsTWlkZzNOOU5LUnZTZFJTT1BOT0IxVXhHWTdJUUp5Y24zbkJw?=
 =?utf-8?B?OWI0dGxIUmJ2WW1iY2FmKy9HQlhoS3FqVUV0M3YxVCsyOXFXWUVWUWE0QzY3?=
 =?utf-8?B?cWJLOXB0ZGJwb2w5TlR3UXJBSWVyQVhLMW1EWndneTRXeXlILytqaW1MQlcy?=
 =?utf-8?B?M1hOZCtyQnhycXBzcTBnV1FhVEF4OGdSYjRickFoalhIREVKZzZYbzZjSlJW?=
 =?utf-8?B?U2xhTjR0RGtHRXpKQlVQbDZIekNEQkpmRmpTajVEdzc0OGNpM0ZhblhtNUFI?=
 =?utf-8?B?U0JBcFVmRmdrc290cEtCYld2U3hnZEVlTXRGdXlZbmdWM01OcHFsakN6L2Rl?=
 =?utf-8?B?dU9iSUhwUGFDQlRCY2N3Z1ZiUzNuY1c1WjBLM3liMnlZOURJRUtlQzYvS2Y1?=
 =?utf-8?B?NWRTMHBBQTY5cytoMjlxcVR3R2dHZWh5MytWSmZ1YTBLM2NTRnd0aXkvVmdN?=
 =?utf-8?B?cTg2WXEyQXVXOExieWQ5L2JtQ3R5WEgxYWJqSW5Ib1dVWFM0bXFsRVJaU2FX?=
 =?utf-8?B?a0lPMU9TV3NhT2FOMHlWeHh2VGF6aEorVUQ4dmV6NDdWVXNrYnpvVnpOeG5h?=
 =?utf-8?B?RzBkSUYzUDhSaDNEblphVTMzbHlVS211UUFiU0dKRzJZSWZMZ082UWx6dzhm?=
 =?utf-8?B?akZDOFpzbHlLNTFmRERTeFpwc0k0dDlxaHpzblNMdUZPcGE0ZnFld29MdXpC?=
 =?utf-8?B?emduZnNyN20rMEpOaEJrcFY5dVV0dzY5K2c3VHVlUk9LbklXYmlkdlU1U1c3?=
 =?utf-8?B?Q0NITi9IOUVKRjFyWlRYbTBabmpqSTZQZWF6ZnpiUmhlK29QdEhpR2psWjUr?=
 =?utf-8?Q?WqiuCpE+S02Zo34PkkLxiJWGn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea36b8ee-6d15-4684-1e76-08dc9ccf1ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 08:47:36.8564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwkmdEVxH83MjOm0syVMoxuqPdA5RJ+U3QGJy1Q7auoGjJY/wRGzE2Z8PwvZfgS1H3bgAqSp7IpyhKl5jxyF0gT6fb9g7oRFWbT7nlJFrTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8306
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogW1BBVENI
IHYzIDEvM10gaW50ZWxfaW9tbXU6IGZpeCBGUkNEIGNvbnN0cnVjdGlvbiBtYWNyby4NCj4NCj5G
cm9tOiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVu
LmNvbT4NCj4NCj5UaGUgY29uc3RhbnQgbXVzdCBiZSB1bnNpZ25lZCwgb3RoZXJ3aXNlIHRoZSB0
d28ncyBjb21wbGVtZW50DQo+b3ZlcnJpZGVzIHRoZSBvdGhlciBmaWVsZHMgd2hlbiBhIFBBU0lE
IGlzIHByZXNlbnQuDQo+DQo+Rml4ZXM6IDFiMmIxMjM3NmM4YSAoImludGVsLWlvbW11OiBQQVNJ
RCBzdXBwb3J0IikNCj4NCj5TaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj5SZXZpZXdlZC1ieTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+LS0tDQo+IGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aCB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+aW5kZXggZjhjZjk5YmRkZi4uY2JjNDAzMDAz
MSAxMDA2NDQNCj4tLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4rKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj5AQCAtMjY3LDcgKzI2Nyw3IEBADQo+IC8q
IEZvciB0aGUgbG93IDY0LWJpdCBvZiAxMjgtYml0ICovDQo+ICNkZWZpbmUgVlREX0ZSQ0RfRkko
dmFsKSAgICAgICAgKCh2YWwpICYgfjB4ZmZmVUxMKQ0KPiAjZGVmaW5lIFZURF9GUkNEX1BWKHZh
bCkgICAgICAgICgoKHZhbCkgJiAweGZmZmZVTEwpIDw8IDQwKQ0KPi0jZGVmaW5lIFZURF9GUkNE
X1BQKHZhbCkgICAgICAgICgoKHZhbCkgJiAweDEpIDw8IDMxKQ0KPisjZGVmaW5lIFZURF9GUkNE
X1BQKHZhbCkgICAgICAgICgoKHZhbCkgJiAweDFVTEwpIDw8IDMxKQ0KDQpSZXZpZXdlZC1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVlREX0ZSQ0RfUFYg
YW5kIFZURF9GUkNEX1BQIGFyZSBNQUNST3MgZm9yIGhpZ2ggNjQtYml0Lg0KQnkgdGhpcyBjaGFu
Y2UsIG1heWJlIHdlIGNhbiBtb3ZlIHRoZW0gdW5kZXI6DQoNCi8qIEZvciB0aGUgaGlnaCA2NC1i
aXQgb2YgMTI4LWJpdCAqLw0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+ICNkZWZpbmUgVlREX0ZS
Q0RfSVJfSURYKHZhbCkgICAgKCgodmFsKSAmIDB4ZmZmZlVMTCkgPDwgNDgpDQo+DQo+IC8qIERN
QSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9ucyAqLw0KPi0tDQo+Mi40NS4yDQo=

