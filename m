Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6151C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEL5B-0004sk-Ug; Mon, 03 Jun 2024 23:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEL59-0004sT-Mn
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:43:31 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEL57-0002HX-Fy
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717472609; x=1749008609;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h16Fk8qfLV6HpZb5dNgiQF+AY10E3ehFJCPxlAb6ttM=;
 b=g4+esBaOl95r/B1lgJYlERHwrEPpA9gObvBTBlHz3v5EE/ohCsuOhknQ
 hcXOqCusyH6g3W61fXSPSMKIpKGOqruqZqYZVuFmvFBxeUQnJcmQFhomF
 ksc/+Vcq3X/97JI2y+Xhq46d4rFGDplg5WySI/8G9OYJfq0jz4StO9Y0F
 jdWclrYcJQH8LhDo3aVZLFJDjZms0oHIfTUbZ05bOxJKqijWKKFRySLsz
 rA3mYXtCwHwXlHa1JPC6ZKOc0prbuwS5mhhp6iOU2BxzCH8/IFP3o7Hfi
 iiAbvf2F78zNTJPNTRmMKtFTSN4BbH3FUG8Cd5sgMMqWUxSIYR8smAZM1 Q==;
X-CSE-ConnectionGUID: sw6XTeWjRLGBJ2+61MYixA==
X-CSE-MsgGUID: QzvMorCvTvCR0n1+/t7mHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13799523"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="13799523"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:43:10 -0700
X-CSE-ConnectionGUID: SodCvmS6Q1OuVvB6gHCfVw==
X-CSE-MsgGUID: +gsV7slaTGyYsCME7VFqpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="41549410"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 20:43:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:43:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 20:43:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4HoqlRhcBSX2r4YCSTEVR/xVox6Gv/DPOZOVKbWvbTeATKcdj2i5d5yyBcKISaKeBoH9uC+v6PcsR7QKPEeF3rC1zey+hDyzxzOGeYFeNGVXEX9DsSQsZ4BJBLk2+GpTQJtVD8gj0SFiUOOGUuCjgRHZG9WvS0AFfWWrLVrH3f55uiRPxHRGfwaTulK9HjdNG7Oo9UOcZh5zXzMj/5hbw53t5us8MXc/bdfyn+mVCBKwKIE208oik4fpSuXU6NI94cUsRk+olyH6x5qEfxOpXf/AIFwupG386/R3xGD2CAuQbVlkCnEwYvNMq3O/WlRUf+rzg+hiENAHjJgR91qKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h16Fk8qfLV6HpZb5dNgiQF+AY10E3ehFJCPxlAb6ttM=;
 b=kzUvgYf8Zd3EGzNIR6mQh4wnjsx5ZhH3YF+vaZojkN8CSEtiuhZk8aj18ujC/tRYH67Hg2Y9ZqaLypuZriETLwgnZngIbhU+Xk83ayY3x1F3zOl4NIuf5qHWtvj49U3Q3WZODS14sCz9QDw2F0qVPrDHn4DrsXswbMZBj09L6nsUg0fZAtfnAY3fK/bNTdg6yILCdUwPwBMw3svPCot/Pn2E4/aaGct3MhPDmJSSP5hn03nOxWRvjJ0359PmIu3n5ZIFNCMuCpJ1HXZPaL5Pcyx4IatMmzi3jF8ys+jtrGadvoLwPcnjQq+Wk+jd0Gmwh3N+r23wVBoWPZjps4Gxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 03:43:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:43:07 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 03/19] backends/iommufd: Introduce abstract
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD device
Thread-Topic: [PATCH v6 03/19] backends/iommufd: Introduce abstract
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD device
Thread-Index: AQHatX0o/b9nCm4BokCfh2zvRPtKLrG1/iEAgAD5X2A=
Date: Tue, 4 Jun 2024 03:43:07 +0000
Message-ID: <SJ0PR11MB6744589051BE70E5CD7FABD692F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-4-zhenzhong.duan@intel.com>
 <f64ffbd9-fb34-474d-be4a-66c4c9ee223b@redhat.com>
In-Reply-To: <f64ffbd9-fb34-474d-be4a-66c4c9ee223b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6445:EE_
x-ms-office365-filtering-correlation-id: 2a5f9d56-36c6-47eb-ab7a-08dc8448726b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?NVQrMWt1VGVBY1NpSXllVHZQMjdGSUwyWWsyTGJFOVUvZXB2MC84Q3pZUTNN?=
 =?utf-8?B?RlF4MVc1d3l1UWhwa2p5TkdvR3AyblVpUlNoR1pEbW90TmFzRzVDSFpYbTZI?=
 =?utf-8?B?RW1ERGlKNjhzNXpXbkVPWTliZ0t1L1FFVWVON1FjVXhGMktIQ2FDQ3VMWjYr?=
 =?utf-8?B?NjlzSXpEMHBYQS9jbGt1eHRVa080YXMvUTcybzVkWXhQOU5BWG5WdDFYL2hv?=
 =?utf-8?B?Qk1zVGsxSlMvM0NwUTB4eGVJbENWSjB6Sm1maXBQdmdYUjhyWnpKSFc5WkVB?=
 =?utf-8?B?YXZ5VGF0WlJrUlQyREU0VUJlYU1xNE51T2NPVmlkZWx4dkZZLzBteDkyTmNM?=
 =?utf-8?B?dUV5a2lTRjBhNFFObzVFeU85MDNSMzVvZ0hyYkFCanV0YTdoMzRaYUQzWW8x?=
 =?utf-8?B?S3RMTWJBY2laTXB3V0gwQkFhV0VPaG9PcDNOUHZLWW5lZG51ZklNQ0dlVytN?=
 =?utf-8?B?aDlLVmp5YjMvU1YzWnhoeDBqbkZrRnBMTWFHVnRiUmtmTHFlNjhzL29iOUFK?=
 =?utf-8?B?NXFKUmI5OS9NQWdDMEtVOXZkRkpOVWE0QnVCZDJkOHpSeDlacWZtcVVrV21O?=
 =?utf-8?B?SXZlblAwQVB0L2N5OG5oQ21pVDlOYm81eXJiQXU5WGpnci96OTBaR2JGcXkr?=
 =?utf-8?B?WWhLQTI2ejhWK01qd1dZbkZkWEtHUmN3T1V3U3JMUEFYU1ovU1hvS29zQkp4?=
 =?utf-8?B?TFQ4a0VqNk1LZHBjVUEveVRYWHVsMDRmYnR5L0F0SW9WRDZwNXB5UnJQYmQ5?=
 =?utf-8?B?cUdEcDhVbkVWZGRid0k3ME10SXFhenc5Q0FyV2tQMHlPMVpTYXdMalpKSEZu?=
 =?utf-8?B?Wks1N2ptTG5IbUEwVkgyKytCbXFlWGNzaEhzN3E2NlAydlFNQ1Rib3Fac3FT?=
 =?utf-8?B?bHBUbmdmY2FYVFdCVzVPTEs1SGJ3MFc2OGxvUnlSemRFeGo5a2t1eWdHM3Nq?=
 =?utf-8?B?b1NZSDE0eHlHVjd2QmpZT3IxOWJCZmR6UU1LQTE4MFpOV3ZySllTMlZ3aHVE?=
 =?utf-8?B?OWVQcVp4Q0FYK3cvMjBERktWWmtvMkwwUzlDdTdKMHZNUFlsRnhtc2gydHBM?=
 =?utf-8?B?dWRwZ3RaVVJsUUw3ZnI2K1dxQlRRS0JmclZPc1ZtQ1E0NkRsbVhOQ1NacXZM?=
 =?utf-8?B?QnoxcVQwQkZCMGhMWXpMcU9qVEdqQURyeDU4eVZoWEVFcGd4SWpRS3NPZGgv?=
 =?utf-8?B?WmtzR09xbnUrbDU5S1FnUjlBWGE5NnJ1Z1VkZTlDT0M4NEpuR0hxOGdORHRQ?=
 =?utf-8?B?ZlVRdEl5SUpxMUtkNGt5em42a015T0hCVWEzalJrZmt3MktYaisybmpWR3FZ?=
 =?utf-8?B?aUJVLzh1a0dSOVpVa29YM0tybnA0cGpkMGhTK3UwUy96M1B3MlhWaXhXZEx3?=
 =?utf-8?B?MUVqYWI2TjVjN0IvMzh2Y3BnY0ZBOGF1Q3ZZL2tnTXJLT0l2SHZPVUN5ME5m?=
 =?utf-8?B?dUNtak1kdUl4dnY1TkFTQ3lSZDlqcmR5WnBIc0lvQzVscHgyNmVmUDFSSWZO?=
 =?utf-8?B?allBcHB2UDk0WUVzdnU5NE55eVdFRnpTTUc5SmhaU04wbldnWHFTQTZNdXU3?=
 =?utf-8?B?VENHMk9PYUJoditxc3dWMmVNSFlySUFiWUpGc1g1SXh5ck5pTkxwM21jTlZo?=
 =?utf-8?B?dzRTYkprNkluU0xHMzNwOEFDaDN2YlRFWE5scXZCaEkzM1VTMFlYZE1yVzdK?=
 =?utf-8?B?M0ZuTEh3L1V2Mis4aGRGdFZnYU0weDdJMFc0VGhkcTZoVEFlRlJ3eVB4clBP?=
 =?utf-8?B?YmNsTW5QVDdCcVZRMzdvWW80VFhJZE84QWxxODN5ZThlcVBBazY5cGdvdGta?=
 =?utf-8?Q?uVqbcL+B3vR/TIF86IDEGrqdoLcDRnLLP91Ws=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHpRbmF1Mk1GdXBtTDUyQ1hkVmwvMEJXbE9RM0RSd0dkUEg0MFRTaUpsNmFu?=
 =?utf-8?B?NlMxMDBBbWxpS2dYaExBeGVvQlRNRTI2VnFyQUJGWmV0NTU4K3NkYThyandN?=
 =?utf-8?B?Z3VFdWg3WVdKVjFOSmhVRzVhMi82eWpXRjZMR1R3WGhCeEdrcTl0ZTJBUVNk?=
 =?utf-8?B?WXFpbEcwZnJVMDlDVk1HYkpXQlVlKzNVSzhtL0ZTWW90enMzelp3SXlrK2Rk?=
 =?utf-8?B?OGZ0cUtJWW0reitVazZtRjVpbHUwVm9GU29QakdkTVVqL3ZPTE9aaFdLU2oz?=
 =?utf-8?B?ZW56ZWFSRWpIaW1pUlY5dU1RdW1UV1VTQ1JzY1NDd2J0VUl5b3doOTl2WCtv?=
 =?utf-8?B?OFpQTjladWlrR04wYWJ1dlNWblR2UTYzUGxmM3djeXVOVURLQyt1MGttZEtn?=
 =?utf-8?B?amtsdjBtdmtGOWVNN1AzSmtvRjlDMjBRTjVETDNsdEJNV2hkYlpuVTZmeVkx?=
 =?utf-8?B?ZkxoQ29iK0tGS0dWcHlDd1VoUCswN21WeUxtU3QraHdRZlJJY1VuY3dYcUNG?=
 =?utf-8?B?eWF5dHdtK0xHT2ZkWE16NU5mbnhkK21aR1pvWVR1b0R1OHRvc28rN2RoVkI4?=
 =?utf-8?B?aDcyVGJGem4vT3lJNzdvRmIvcXA0bWNoaTU3clE4WmpLcnF4T1JDVnNxR213?=
 =?utf-8?B?STExN3dBNzRSbTRyV21pRERjREJmaU8xNHZGR3BOdkpzSC9tQVpSZ1ZnQk1r?=
 =?utf-8?B?dHBnUWtxWUJuOEpzcHEwSTBmSm9EdjZhMTMyRWNxUmVjYmdsNGJCT3dTcXl0?=
 =?utf-8?B?TitSKzV0ckRMdENkcWdQRVV4UDBiZi9aYTlIYVIzbUt5T2MwQ2N1MkttMHJG?=
 =?utf-8?B?UXZhM01NZFBLVnZ4UXpYS05sMGhZRktnZEVRUFNtNXVURWNya1M1QmxodEdY?=
 =?utf-8?B?TjRDRzVKcVBnY2dBL05MRjJTMlJnblRjZDRRVnpBWXlLSW01RG1mWHdRZlZO?=
 =?utf-8?B?ZzFzWjNGdXFyeE5pbHBPbm92Sng4V1NNV2wwRStJNmhYN2tuSkJqbWlTRnhW?=
 =?utf-8?B?TTlvdFhyYjhJcjZjZ3k1QzUrbHNFRGc3UjR6ekZxZFFEMEhxUUZyYVM0ajV6?=
 =?utf-8?B?SlYzMTBtNjNnZklyTUQ5ektZK2VJUlZ4QnNoejNJYmk1RkRMWEV0U0Nzc2wv?=
 =?utf-8?B?Uk5YckhNaUlNZUpZWDJVNCtsTEJLWGlUdzhlK0JIUnl1WUFIakhsOXZUQ2Zy?=
 =?utf-8?B?ODI3OGVDM3MyZ3BhdFZIZjl4dGJWTnFGcXhNR2FzMDRoY0EwNVQwOUR4OEhU?=
 =?utf-8?B?S1JsYnZ6b3pQNERyNjFqNkU3Y3pTSkZiUnpvZFppVHpkaFEzU3o1QUYzeUVC?=
 =?utf-8?B?b0cwSEdQM2RCaDBOdjVOUFRoalpnemkyc0NBQVpQei9vTjBHYlowd1BZZ2kx?=
 =?utf-8?B?Qi9xYlB6dVNsRHExekxCVnlxQ29vd3YyKzJJSENMalhKR2ZkTzJsQzM1b1FI?=
 =?utf-8?B?RHNMU3hqNTVmbDZha3BiZGxpR0R0bkhkRGJzRGF5bjJCNVRPd2VRNlA2V0hD?=
 =?utf-8?B?T05VVWlPd3lGZkpqOVM1ekpkd3RrRXRweERqOTBHKzFUcG5zOFdtNC9DVm9y?=
 =?utf-8?B?SWVzYVRkNEZwTFFsK2F0OUNHclFzNUNaR3VHNEwxRitYdnlXQmhOQWl5dUhJ?=
 =?utf-8?B?SFJnUXBpeHZmQlFvWU54NkFRRkRHYjRpM1hpUGRoeXBFcFovNTJJTVAydlpH?=
 =?utf-8?B?a2F2b2ZDQUZqWjlsdlFXdUlzRUswbVdQUHREL0I2dk85SSszUUowUnMreFBQ?=
 =?utf-8?B?a0FLbUVRY28zakp0UFlXeXZnMXBjZStUdVFybEdneU9VTTR4djB2SGJ3WmZn?=
 =?utf-8?B?a2UyT0RCK2EyUFVreW1kVkZhSVhQc01wQ0hDOTh5ckhwdWJTR2YyZzdOR3Q5?=
 =?utf-8?B?NUpBcDZKSFdFdlhJWnlDanZmdWgwNWJZd0Q0WWdjMGJRQ0lGOWdIREVHN1p0?=
 =?utf-8?B?RUJ1QjRnRGNmSHFQdjUwY0Ryd0NJWEZFb3o3VkhPZmJmT0h5dzF6dFhRd2tq?=
 =?utf-8?B?L1lYVXBsYzZibTJET0xyNU5YdWpGSi9waFNXZWJxUjdWQlN1WStjZFZhWlBN?=
 =?utf-8?B?RFQva3BMKzBWamdzSTZtSThmVUNDRmxWM2tzYjU3ZUU0Q3RZQzY0ZDRJbnVh?=
 =?utf-8?Q?OUiPSeg3QW9SLrGGWtV16zUJB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5f9d56-36c6-47eb-ab7a-08dc8448726b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:43:07.1896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MKOvYp21D/QyZvfLnx1D9u5DJSgJehhSLNRBpeFfplifxPJdgFSzSkoq3m9cVfViGucjmue6bOYohkDn81oPxviu5e6EbuhSkfMVu6WWBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDAzLzE5XSBiYWNrZW5k
cy9pb21tdWZkOiBJbnRyb2R1Y2UgYWJzdHJhY3QNCj5UWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lP
TU1VRkQgZGV2aWNlDQo+DQo+DQo+SGkgWmhlbnpob25nLA0KPk9uIDYvMy8yNCAwODoxMCwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+PiBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQgcmVw
cmVzZW50cyBhIGhvc3QgSU9NTVUgZGV2aWNlDQo+dW5kZXINCj4+IGlvbW11ZmQgYmFja2VuZC4N
Cj4+DQo+PiBJdCB3aWxsIGhhdmUgaXRzIG93biAuZ2V0X2NhcCgpIGltcGxlbWVudGF0aW9uLg0K
Pj4NCj4+IE9wcG9ydHVuaXN0aWNhbGx5LCBhZGQgbWlzc2VkIGhlYWRlciB0byBpbmNsdWRlL3N5
c2VtdS9pb21tdWZkLmguDQo+DQo+SSB3b3VsZCBleHBsYWluIHdoeSBpdCBpcyBhYnN0cmFjdCwg
aWUuIGJlY2F1c2UgaXQgaXMgZ29pbmcgdG8gYmUNCj5kZXJpdmVkIGludG8gVkZJTyBvciBWRFBB
IHR5cGUnZCBkZXZpY2UuDQoNClN1cmUuDQoNCj4NCj5CZXNpZGVzIEkgdGhpbmsgSSB3b3VsZCBz
aW1wbHkgc3F1YXNoIHBhdGNoZXMgMyBhbmQgNA0KDQpXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+DQo+VGhhbmtzDQo+DQo+RXJpYw0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9zeXNlbXUvaW9tbXVm
ZC5oIHwgMTYgKysrKysrKysrKysrKysrKw0KPj4gIGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICB8
IDM1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgMiBmaWxlcyBjaGFu
Z2VkLCAzNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oIGIvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oDQo+
PiBpbmRleCAyOTNiZmJlOTY3Li5mNmU2ZDZlMWY5IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9z
eXNlbXUvaW9tbXVmZC5oDQo+PiArKysgYi9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+IEBA
IC0xLDkgKzEsMjMgQEANCj4+ICsvKg0KPj4gKyAqIGlvbW11ZmQgY29udGFpbmVyIGJhY2tlbmQg
ZGVjbGFyYXRpb24NCj4+ICsgKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBJbnRlbCBDb3Jw
b3JhdGlvbi4NCj4+ICsgKiBDb3B5cmlnaHQgUmVkIEhhdCwgSW5jLiAyMDI0DQo+PiArICoNCj4+
ICsgKiBBdXRob3JzOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+ICsgKiAgICAgICAg
ICBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiArICogICAgICAgICAgWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ICsgKg0KPj4gKyAqIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+PiArICovDQo+PiArDQo+
PiAgI2lmbmRlZiBTWVNFTVVfSU9NTVVGRF9IDQo+PiAgI2RlZmluZSBTWVNFTVVfSU9NTVVGRF9I
DQo+Pg0KPj4gICNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+PiAgI2luY2x1ZGUgImV4ZWMvaHdh
ZGRyLmgiDQo+PiAgI2luY2x1ZGUgImV4ZWMvY3B1LWNvbW1vbi5oIg0KPj4gKyNpbmNsdWRlICJz
eXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCINCj4+DQo+PiAgI2RlZmluZSBUWVBFX0lPTU1VRkRf
QkFDS0VORCAiaW9tbXVmZCINCj4+ICBPQkpFQ1RfREVDTEFSRV9UWVBFKElPTU1VRkRCYWNrZW5k
LCBJT01NVUZEQmFja2VuZENsYXNzLA0KPklPTU1VRkRfQkFDS0VORCkNCj4+IEBAIC0zMyw0ICs0
Nyw2IEBAIGludCBpb21tdWZkX2JhY2tlbmRfbWFwX2RtYShJT01NVUZEQmFja2VuZA0KPipiZSwg
dWludDMyX3QgaW9hc19pZCwgaHdhZGRyIGlvdmEsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJhbV9hZGRyX3Qgc2l6ZSwgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHkpOw0KPj4g
IGludCBpb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1hKElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMy
X3QNCj5pb2FzX2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBp
b3ZhLCByYW1fYWRkcl90IHNpemUpOw0KPj4gKw0KPj4gKyNkZWZpbmUgVFlQRV9IT1NUX0lPTU1V
X0RFVklDRV9JT01NVUZEDQo+VFlQRV9IT1NUX0lPTU1VX0RFVklDRSAiLWlvbW11ZmQiDQo+PiAg
I2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZC5jIGIvYmFja2VuZHMvaW9t
bXVmZC5jDQo+PiBpbmRleCBjNTA2YWZiZGFjLi4wMTJmMThkOGQ4IDEwMDY0NA0KPj4gLS0tIGEv
YmFja2VuZHMvaW9tbXVmZC5jDQo+PiArKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IEBAIC0y
MDgsMjMgKzIwOCwyNCBAQCBpbnQNCj5pb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1hKElPTU1VRkRC
YWNrZW5kICpiZSwgdWludDMyX3QgaW9hc19pZCwNCj4+ICAgICAgcmV0dXJuIHJldDsNCj4+ICB9
DQo+Pg0KPj4gLXN0YXRpYyBjb25zdCBUeXBlSW5mbyBpb21tdWZkX2JhY2tlbmRfaW5mbyA9IHsN
Cj4+IC0gICAgLm5hbWUgPSBUWVBFX0lPTU1VRkRfQkFDS0VORCwNCj4+IC0gICAgLnBhcmVudCA9
IFRZUEVfT0JKRUNULA0KPj4gLSAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihJT01NVUZEQmFj
a2VuZCksDQo+PiAtICAgIC5pbnN0YW5jZV9pbml0ID0gaW9tbXVmZF9iYWNrZW5kX2luaXQsDQo+
PiAtICAgIC5pbnN0YW5jZV9maW5hbGl6ZSA9IGlvbW11ZmRfYmFja2VuZF9maW5hbGl6ZSwNCj4+
IC0gICAgLmNsYXNzX3NpemUgPSBzaXplb2YoSU9NTVVGREJhY2tlbmRDbGFzcyksDQo+PiAtICAg
IC5jbGFzc19pbml0ID0gaW9tbXVmZF9iYWNrZW5kX2NsYXNzX2luaXQsDQo+PiAtICAgIC5pbnRl
cmZhY2VzID0gKEludGVyZmFjZUluZm9bXSkgew0KPj4gLSAgICAgICAgeyBUWVBFX1VTRVJfQ1JF
QVRBQkxFIH0sDQo+PiAtICAgICAgICB7IH0NCj4+ICtzdGF0aWMgY29uc3QgVHlwZUluZm8gdHlw
ZXNbXSA9IHsNCj4+ICsgICAgew0KPj4gKyAgICAgICAgLm5hbWUgPSBUWVBFX0lPTU1VRkRfQkFD
S0VORCwNCj4+ICsgICAgICAgIC5wYXJlbnQgPSBUWVBFX09CSkVDVCwNCj4+ICsgICAgICAgIC5p
bnN0YW5jZV9zaXplID0gc2l6ZW9mKElPTU1VRkRCYWNrZW5kKSwNCj4+ICsgICAgICAgIC5pbnN0
YW5jZV9pbml0ID0gaW9tbXVmZF9iYWNrZW5kX2luaXQsDQo+PiArICAgICAgICAuaW5zdGFuY2Vf
ZmluYWxpemUgPSBpb21tdWZkX2JhY2tlbmRfZmluYWxpemUsDQo+PiArICAgICAgICAuY2xhc3Nf
c2l6ZSA9IHNpemVvZihJT01NVUZEQmFja2VuZENsYXNzKSwNCj4+ICsgICAgICAgIC5jbGFzc19p
bml0ID0gaW9tbXVmZF9iYWNrZW5kX2NsYXNzX2luaXQsDQo+PiArICAgICAgICAuaW50ZXJmYWNl
cyA9IChJbnRlcmZhY2VJbmZvW10pIHsNCj4+ICsgICAgICAgICAgICB7IFRZUEVfVVNFUl9DUkVB
VEFCTEUgfSwNCj4+ICsgICAgICAgICAgICB7IH0NCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfSwg
ew0KPj4gKyAgICAgICAgLm5hbWUgPSBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQsDQo+
PiArICAgICAgICAucGFyZW50ID0gVFlQRV9IT1NUX0lPTU1VX0RFVklDRSwNCj4+ICsgICAgICAg
IC5hYnN0cmFjdCA9IHRydWUsDQo+PiAgICAgIH0NCj4+ICB9Ow0KPj4NCj4+IC1zdGF0aWMgdm9p
ZCByZWdpc3Rlcl90eXBlcyh2b2lkKQ0KPj4gLXsNCj4+IC0gICAgdHlwZV9yZWdpc3Rlcl9zdGF0
aWMoJmlvbW11ZmRfYmFja2VuZF9pbmZvKTsNCj4+IC19DQo+PiAtDQo+PiAtdHlwZV9pbml0KHJl
Z2lzdGVyX3R5cGVzKTsNCj4+ICtERUZJTkVfVFlQRVModHlwZXMpDQoNCg==

