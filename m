Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3EFC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 05:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6l3s-0005pG-4g; Tue, 14 May 2024 01:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6l3q-0005oc-5J
 for qemu-devel@nongnu.org; Tue, 14 May 2024 01:50:50 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6l3m-0005m9-HQ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 01:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715665847; x=1747201847;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=btvex8+pgzPFlS6PGZS8RuT1t3hUrk6hZ9cjEtIpPYY=;
 b=l+vsNyEDDcXoh6/jEDHaQztov0yb05bAZC40FLJYz+eb3bjiGVK36UGQ
 tY9casekkb+3vSvwAC5y474yAAIxlGyBlLj008yFKsPHklwV2K4jyLplM
 jFeXDb1y0dk6riAsRamx4gr1cj/R2iVLnPzbAAM74ecOa6/ZaQgLO/ac1
 oO3r5MWEwCDpKbLDv+f580nopc6x4X7SAHSOPO9Glmq8RyhkYDVzmHGTV
 +J8Uzzn6ZQHInDQ0kxiP+cZWXeamb4gHTHsaG6O8Eu8EWrfy5l9d57fG8
 DVSmYsJDzwWmB6tjL1ZQlmZCh4sqM52AZI9m8x64a5E6QbpQBiAiIdvKP g==;
X-CSE-ConnectionGUID: vk/EZReIRUaZL0SzTK6cMA==
X-CSE-MsgGUID: pfRem02KSqadvASDiU/0wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11792357"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11792357"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 22:50:44 -0700
X-CSE-ConnectionGUID: nhlxtHHTSjyDWDnYAs24Iw==
X-CSE-MsgGUID: fsbX+oxnT5WUAyjdONa4Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="35327369"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 May 2024 22:50:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 22:50:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 22:50:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 22:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkecoe5j/sbwBTDqN6dshRfo40hSWWNVCvKBdlZZeGJJzvXppgdQaJccsDD19YyDxCzs+Jaq6FcIzJhVL+GmmeRsKFRFcuzyTCb+Za+6MBiutBValZ9cZCjggI11ZmKvsOU0XWKnyRJeJl480zg6lgY429DS0nGpPWIwCr4BUDmC3rP2kD0QIK/SUsxod9nZfTttJSo2ssc6GzgtrsDicVHl8J1pPhigb8zVrQLYL8tWStEd+T7WQaBSDnuV3ED65unuhXfs6PD3Aiq5J8nlYa3Vb93fNZZdE6o7/N8ltEf+/+2bAuDWGpy2MqbRLRUDilb7ifquUb6CJXtzvqqCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btvex8+pgzPFlS6PGZS8RuT1t3hUrk6hZ9cjEtIpPYY=;
 b=dyzb3mFIA/pCzz95D5MR5Sxv9oGKvfdrDoaS5TnY2TKhRQ1cjwzHmwzCGl91TYovFj5/uf8ZzDuFvQk/Vd7AI5yj6Es1tQqwgR3tFAxY9pVVH5u37fScMPHxBuWbriOtzss5p4SUF7npr1o/bSeqHm4OA0Mm7ZZpDErdJlhlH3hNIy5/1g4j61VkA2MDLUgfys9GD3zF/0LKdFHT/lcMUXvMAjX8Xs71sASB16bIBewbYHvgYWzJntAJS00LNQW3YROwMP625+Nmk0PNcROOruS1sscEI4ppHSE2d0hh+A5Szvj/D51O6Az4ht/kYShIllZZBSGBb9cFAV6HWGakVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 05:50:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 05:50:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joao Martins
 <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Topic: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Index: AQHamwiDe5j67ytP7Eizl35edXhELbGBjs6QgAHXVwCABg6X4IAMzQ6AgAANEqA=
Date: Tue, 14 May 2024 05:50:41 +0000
Message-ID: <SJ0PR11MB67442E0DD7D336E2BC26A90F92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <9e15abd9-f824-4f11-9532-b0dcb7b521dd@redhat.com>
 <SJ0PR11MB6744D9C5BCFBA146FE09270492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f00d7bfa-91d0-4c58-8b7e-bd3dad477e9f@eviden.com>
 <SJ0PR11MB67443F458DB55397FA4BF58C921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d150cb99-4575-40f2-a3bd-f4143afaa14b@eviden.com>
In-Reply-To: <d150cb99-4575-40f2-a3bd-f4143afaa14b@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6277:EE_
x-ms-office365-filtering-correlation-id: 643cafd8-8523-4492-7d21-08dc73d9c9cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RFR0ekcrNlUrWjBwdnEzTWl4eTQwQWJ2K0hTVVFlSHRJQ2hYRElmS09jUUEz?=
 =?utf-8?B?bWpwQ05WV3lpNXExZnhJRDJQemZLd0k5elN1QjF5NHh2T1huS2xDTFNRZlZG?=
 =?utf-8?B?ZkdPM0puUU16bWFzUDBhc0NnQzlwTHllOFBSQi94Tnl1MkFSazZwaUhyTVdl?=
 =?utf-8?B?ZTlvYTVsdEJWV2hWSG9JVVBIN0NHSngzQksrL250eWJTRTNVcGJVQ1N3OHFq?=
 =?utf-8?B?a2MrWnphSXhUU2hyUkdaZkVpYjJCWm5JUkE2WkpSbWNuc0M5YmZaMm1RUE1I?=
 =?utf-8?B?MG5kQmdxUGZUb3Y1QUlwSzl2QWVtS3BGY295dWNkbDdUWHpaa3FGMCtOUzFy?=
 =?utf-8?B?aEpyd2ZKSU1XWmVhQ1pXQUl1MTNQVzAzeFY5TEpvU21Yb3FKU002MHljVGpB?=
 =?utf-8?B?eXo3cGx0STNzMjlncE9nS2FmMGtUZEd3SkNObXB4UExxTjZQMDF5Z0xVUHVZ?=
 =?utf-8?B?SFRWSDRLMG5lMkZSQVN1RE00d2FuWU13ZWc1V1VqS25UTUlNWXBMMWV4NWo5?=
 =?utf-8?B?Y1ZyU0k3K285VGlqZWRTZTJPcXdZQ0NjbnFxR0ZqbEhGSVZ4eEFLM0tWMEo5?=
 =?utf-8?B?eFBnSGxMaHU1NHhHQjEwcWVuNFdyeXNpNkc2SG1xZlQvbEpvOENnYklFVDA3?=
 =?utf-8?B?TmpnWEhyMTNvdXEvQ09nVHk1K0dRaWcvSWVFOW5XV2RVVW5mM1dRTDNuVWdP?=
 =?utf-8?B?MWYza1htV0g5V2ZZT2JHbm5ic3FpVFcrTk9ySHVadXZUMjVSSk1FcTBzUGlI?=
 =?utf-8?B?ekRjYlNGTU1zQmtjYlNtRDgxVGk5OWcxbTgvc2VLZWh5UUh3V1JOcGRrbVN5?=
 =?utf-8?B?d3BTTThVNzJxekJOazhpdnc5UzZLY0pUZWNmVmhvWThiYXg4R1FqNkFlazhY?=
 =?utf-8?B?a3FaU0U2ZFE3ZjRVdDZzbWJaR1ZXOXBNbHdYVmxBaU5UaTI5S0tDYmkzcy9v?=
 =?utf-8?B?T2RXMmdkTWxTUnFkelBXV2xWR2pWbEhseC9nN21JOEZZcHZsRnBXTWs0TUhU?=
 =?utf-8?B?WUc2bHAxOHNuL1lRbkNFb1k2VytjQm9hVlJveXg2aGIyOGZXNkhoOC9JaUFR?=
 =?utf-8?B?VGNzaXRNZEdDM2NhVllBYkU1cXdZRXdCR2tUUVg0MW15aXJRcmxESnJ1WVVZ?=
 =?utf-8?B?NFdnRDZ4dkxLYTc2b05QWEQveE9Dbyt2OUpoSjNDWWw2VVg3Z3pxTnZBYi8z?=
 =?utf-8?B?MTFFRlBXOWJDMTA2RmthN2xoNXdZb0N6cmV3RWtHTnQ5bnUvbTZqbm9Zejlp?=
 =?utf-8?B?bTlrUVFWTG56UlJkRUxmaFNwSlFiZHpqQmtCbVhONEJFR2drcnBidndnWTVx?=
 =?utf-8?B?NTU4TDZ1Q09NSFpyUjVCMm9iNkRTd205dndVREdkNFBKUDZaRldrTkhkS3Fp?=
 =?utf-8?B?VUo0ZjZRWUlCVzY4c2QzdUtSMFlyZmtjOXptODJUUHlVUTNVc0hsSk1GQkRI?=
 =?utf-8?B?TytINHBYem5nZS9ad2dycVpoTkw0MVdxMWNGbUZBb214SURQc0doeGUvUlVz?=
 =?utf-8?B?djhLandXL0NqeFU1TW50N2cvcllxQWtBNHZMMFVIQldpL2FFRnBEY1JwNDNB?=
 =?utf-8?B?U2VnSDZEUjlFbXJueEJia2YyblFXbE5ESExLZitLMlp1RFRjUm1wQ0paS2tw?=
 =?utf-8?B?UWpBd3Y2K2FJNTVobVp1bkl1OEFTbGY1UUhnTkJiaTliN3BXc2hOS2gzYzRK?=
 =?utf-8?B?U1hCS0sxbVA1UUFGWkNvUXBwMXdtTzNzbGhlRmpsdUNwTTJ3dDVmZllMRGtn?=
 =?utf-8?Q?Skey3oyGObqDcpTsCE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW9mMnV3ck9RcFA5ZFJPQ2RpRFNoTG1HbTVsb3B3TFNuVXUxZSt1V0I3clFN?=
 =?utf-8?B?NkgxcnhGbVJZZlFtb0xZZmk4YTY4ZzB3a3FUa2dpQWdvTEdGL2VQQThKSkx4?=
 =?utf-8?B?OURjcWZOUDVvejN2WHJiNE16Rzg2Wi93NnpKMWV6NWtGY3RBRUVBd2kxeXRN?=
 =?utf-8?B?WVJqMDRWNnZScHlxeWtrdUNIRW0wNlhPL011Uk91MUhMSDFseTNXQXZucWYz?=
 =?utf-8?B?ZkNseUpxZmgwRU1OR3o4YUd3YmFqRUkwVHFLTzNZVVZONDR4M1FDYkJMbVRE?=
 =?utf-8?B?bGdiTVV1QTRTQW80Mmh4VVJnNndqeU03SDRzS3hEL0FkTGhITktFd0FpQlho?=
 =?utf-8?B?TXFEMWFRbUJrQjc3QWxoZUM2Y0N6SFgxZlJPaytPdGN2SHB2TnU3aU5iU2da?=
 =?utf-8?B?cXJzK1FyMGxzYTlYS1BLWlY5UEVGTENORXRWLzhUZkRzeS8rN3ZZRWk4d0NT?=
 =?utf-8?B?RDdLNjZmb2tQdCtsOTZNb3llUnJsT3VkN0tLRlVxcFBBMi84QzZEcXBMN3VE?=
 =?utf-8?B?a0R6Y3pGYTN5VW9QeUphMTJMR0hIdjZDMXdJdzgyYjRjaTlOdENqRUFYV21p?=
 =?utf-8?B?cE5GMU9DNU5YN0YzeWFsQmVDTXZJZ0J2ckZBTjFRVXhPM1RHSjJ3VktmbUFs?=
 =?utf-8?B?My8xZ09YNDAxbDRLZ2VQSXVoRldSRUprSkFUVkZZakFkYjhPODJiWkJiTnZh?=
 =?utf-8?B?cVJBa2FGTXRRRWdZblNwSzliU3Z1bXR1YllJSlhKUGlJSjBwcFp4UFprU01Y?=
 =?utf-8?B?QkdDYmlsQUJSZ0NHaUJhL0U3ZjF6bURUWnhQZk9XUmE5dml0aDhCNHl0OUU2?=
 =?utf-8?B?SmsvQW1xbVpETzl1ZXo5L2dhNGpqdFlkWTZrMkV3QVU4dWtCWFVOcjZNMU9W?=
 =?utf-8?B?clZqTGxBcEFJRkpZVldCN0VJTEpOMWhTWllPL0gxVnVQMXB5MmRKVzlxUFNV?=
 =?utf-8?B?ckZXNUZpeko3MXNCUW83azJoaGw3NUhYU0pTUXg1bXBsV2IwWlZWcjBjZm1I?=
 =?utf-8?B?bGdJUGpHMitjT1JCbFZZcTRJbEdxd0RxeTZWR0RJVi9CMS9DNmtuSkJyZGtx?=
 =?utf-8?B?a1UzU1JyVk9XMW1TZXp3L01QTXZ2TUNCUUJEOXloTmhMSS9Da3NCZEpoWVlE?=
 =?utf-8?B?MHpadSs0bW9VNGpZZUUzWDd3REZuYUdPRWoxYXFaNXN5ejBnTytoSkNnK1o5?=
 =?utf-8?B?aDFsVHlzNGcyTXRLNE1BTXJUY1R6YWc2TlhYTFJXcFFUbFRTUGt2MGF5bFoz?=
 =?utf-8?B?QS9mWFZtNGtGdXdJSUNteG1wQUczTjdIR01PZ2EzekNyR21PVHdtd0c1RHFL?=
 =?utf-8?B?SGxBUy95RnlHK3RoZmdHeC9DeFo4cmNBQVd0aXI5R3FkZFNaZUNxL0FVczh1?=
 =?utf-8?B?bVNsd1Z0MWRUSS9RVWtEMEN0eEJQRTQ3ZmxXUC8venhYMVBiajN3WitEOFVQ?=
 =?utf-8?B?dmFDVU96WndqMjdFdCtFN2U1L1RCenNzUXRCUHU1c3Rhd1ZkMmltMlJZQ1Ri?=
 =?utf-8?B?NVZhRW00U1o1bGNmR3U0WjVoelFIeXFwbGhwSmlsZjhGb1ZuYlNQeVE2YldW?=
 =?utf-8?B?NVpxS0IzU29QOCtmT0ZCUzArS2ZBL3poZlhyVHdGZW1JQmRucWZ2OXN6RFRv?=
 =?utf-8?B?cklhSUVtQ2p2a2VVZTErbzgrY1RlN1hSOFBZdmZBWVZ0VG5aTkM2cWNmWWlT?=
 =?utf-8?B?Y3M2UDJOTUthZmhtZTVEVHI2NWxBUU8yMUNGTUx4YlppbDh2U0dDRldJamZq?=
 =?utf-8?B?YWJuK2cxUUZwV3JmdGRZUXhLdmdjOXFPaUxEaytXeHkwRHd1Wmp1TGZVc1dn?=
 =?utf-8?B?SXJ4dENOUXlKYTVLVmN5VEZQTTdVNHUzbndpeFh1RW95NGVLcHdJSjZwZlNP?=
 =?utf-8?B?YjVHWmI0eDl5ZGpBbk5CTHFSWXBGZ3VlVTdBbkU4bGlZQnVCQlNpeU1sZWth?=
 =?utf-8?B?VTZRS2pJU29XMlpWMXA1dkZzY3FUclA3c0F5U3U0cEVlVnNHZnJCT3hUa0pV?=
 =?utf-8?B?TDRtcnFESDF5U2ZPY0I5cllVb1hsSGVvK1I5d0crUGYyOGhWZGxuQWNnc1pG?=
 =?utf-8?B?ODlySVRPbEJWcEF1dFZWTmUyNnVrZyt6Z1VndFYzRDlTbzlQU2xFaitGMWow?=
 =?utf-8?Q?yKASRcXzwK22S+Ay+hMvSVu8T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643cafd8-8523-4492-7d21-08dc73d9c9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 05:50:41.0171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W48eKuo9fiybMUcRsrnc9zTo3uwB3GRCWcIykdYzMSm/6L3gRy4Wwrost0KfaVuq9ES74Mmf6o8zt2SJ5YxQegDOI4Brg6IpQqCmnq8zR9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

SGkgQ2xlbWVudCwNCg0KSSdsbCBsZWFybiBhbmQgdHJ5IHRvIGdpdmUgY29tbWVudHMgdGhpcyB3
ZWVrLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj5Gcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggaW50ZWxfaW9tbXUgMC83XSBGTFRTIGZvciBW
VC1kDQo+DQo+SGkgWmhlbnpob25nDQo+DQo+SGF2ZSB5b3UgaGFkIHRpbWUgdG8gcmV2aWV3IHRo
ZSBBVFMgc2VyaWVzIHJlYmFzZWQgb24geW91IEZMVFMgcGF0Y2hlcz8NCj4NCj5UaGFua3MNCj4g
PmNtZA0KPg0KPg0KPk9uIDA2LzA1LzIwMjQgMDM6MzgsIER1YW4sIFpoZW56aG9uZyB3cm90ZToN
Cj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBj
bGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj5lbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4NCj4+DQo+PiBIaSBDbGVtZW50
LA0KPj4NCj4+IFNvcnJ5IGZvciBsYXRlIHJlc3BvbnNlLCBqdXN0IGJhY2sgZnJvbSB2YWNhdGlv
bi4NCj4+IEkgc2F3IHlvdXIgcmViYXNlZCB2ZXJzaW9uIGFuZCB0aGFua3MgZm9yIHlvdXIgd29y
ay4NCj4+IEknbGwgc2NoZWR1bGUgYSB0aW1lc2xvdCB0byByZXZpZXcgdGhlbS4NCj4+DQo+PiBU
aGFua3MNCj4+IFpoZW56aG9uZw0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
Pj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2
aWRlbi5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCBpbnRlbF9pb21tdSAwLzddIEZMVFMg
Zm9yIFZULWQNCj4+Pg0KPj4+IEhpIFpoZW56aG9uZywNCj4+Pg0KPj4+IEkgd2lsbCByZWJhc2Us
DQo+Pj4NCj4+PiB0aGFua3MNCj4+Pg0KPj4+IE9uIDAxLzA1LzIwMjQgMTQ6NDAsIER1YW4sIFpo
ZW56aG9uZyB3cm90ZToNCj4+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVu
IGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MNCj50aGlzDQo+Pj4gZW1haWwgY29t
ZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4+Pj4NCj4+Pj4gQWgsIHRoaXMgaXMgYSBkdXBsaWNhdGUgZWZmb3J0IG9uIHN0YWdlLTEgdHJh
bnNsYXRpb24uDQo+Pj4+DQo+Pj4+IEhpIENsZW1lbnQsDQo+Pj4+DQo+Pj4+IFdlIGhhZCBldmVy
IHNlbnQgYSByZmN2MSBzZXJpZXMgImludGVsX2lvbW11OiBFbmFibGUgc3RhZ2UtMQ0KPnRyYW5z
bGF0aW9uIg0KPj4+PiBmb3IgYm90aCBlbXVsYXRlZCBhbmQgcGFzc3Rocm91Z2ggZGV2aWNlLCBs
aW5rOg0KPj4+PiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwv
MjAyNC0NCj4wMS9tc2cwMjc0MC5odG1sDQo+Pj4+IHdoaWNoIG5vdyBldm9sdmVzIHRvIHJmY3Yy
LCBsaW5rOg0KPj4+Pg0KPj4+DQo+aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2Nv
bW1pdHMvemhlbnpob25nL2lvbW11ZmRfbmVzdGluZw0KPj4+IF9yZmN2Mi8NCj4+Pj4gSXQgaGFk
IGFkZHJlc3NlZCByZWNlbnQgY29tbXVuaXR5IGNvbW1lbnRzLCBhbHNvIHRoZSBjb21tZW50cyBp
bg0KPm9sZA0KPj4+IGhpc3Rvcnkgc2VyaWVzOg0KPj4+DQo+aHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2t2bS9jb3Zlci8yMDIxMDMwMjIwMzgyNy40Mzc2NDUNCj4+PiAtMS15
aS5sLmxpdUBpbnRlbC5jb20vDQo+Pj4+IFdvdWxkIHlvdSBtaW5kIHJlYmFzaW5nIHlvdXIgcmVt
YWluaW5nIHBhcnQsIGkuZS4sIEFUUywgUFJJIGVtdWxhdGlvbiwNCj5ldGMNCj4+PiBvbiB0byBv
dXIgcmZjdjI/DQo+Pj4+IFRoYW5rcw0KPj4+PiBaaGVuemhvbmcNCj4+Pj4NCj4+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xn
QHJlZGhhdC5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIGludGVsX2lvbW11IDAvN10g
RkxUUyBmb3IgVlQtZA0KPj4+Pj4NCj4+Pj4+IEhlbGxvLA0KPj4+Pj4NCj4+Pj4+IEFkZGluZyBh
IGZldyBwZW9wbGUgaW4gQ2M6IHdobyBhcmUgZmFtaWxpYXIgd2l0aCB0aGUgSW50ZWwgSU9NTVUu
DQo+Pj4+Pg0KPj4+Pj4gVGhhbmtzLA0KPj4+Pj4NCj4+Pj4+IEMuDQo+Pj4+Pg0KPj4+Pj4NCj4+
Pj4+DQo+Pj4+Pg0KPj4+Pj4gT24gNC8yMi8yNCAxNzo1MiwgQ0xFTUVOVCBNQVRISUVVLS1EUklG
IHdyb3RlOg0KPj4+Pj4+IFRoaXMgc2VyaWVzIGlzIHRoZSBmaXJzdCBvZiBhIGxpc3QgdGhhdCBh
ZGQgc3VwcG9ydCBmb3IgU1ZNIGluIHRoZSBJbnRlbA0KPj4+IElPTU1VLg0KPj4+Pj4+IEhlcmUs
IHdlIGltcGxlbWVudCBzdXBwb3J0IGZvciBmaXJzdC1zdGFnZSB0cmFuc2xhdGlvbiBpbiBWVC1k
Lg0KPj4+Pj4+IFRoZSBQQVNJRC1iYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24gaXMgYWxzbyBhZGRl
ZCBpbiB0aGlzIHNlcmllcyBhcyBpdCBpcw0KPmENCj4+Pj4+PiByZXF1aXJlbWVudCBvZiBGTFRT
Lg0KPj4+Pj4+DQo+Pj4+Pj4gVGhlIGxhc3QgcGF0Y2ggaW50cm9kdWNlcyB0aGUgJ2ZsdHMnIG9w
dGlvbiB0byBlbmFibGUgdGhlIGZlYXR1cmUgZnJvbQ0KPj4+Pj4+IHRoZSBjb21tYW5kIGxpbmUu
DQo+Pj4+Pj4gT25jZSBlbmFibGVkLCBzZXZlcmFsIGRyaXZlcnMgb2YgdGhlIExpbnV4IGtlcm5l
bCB1c2UgdGhpcyBmZWF0dXJlLg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyB3b3JrIGlzIGJhc2VkIG9u
IHRoZSBWVC1kIHNwZWNpZmljYXRpb24gdmVyc2lvbiA0LjEgKE1hcmNoIDIwMjMpDQo+Pj4+Pj4N
Cj4+Pj4+PiBIZXJlIGlzIGEgbGluayB0byBhIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlvdSBj
YW4gZmluZCB0aGUgZm9sbG93aW5nDQo+Pj4+PiBlbGVtZW50cyA6DQo+Pj4+Pj4gICAgICAgIC0g
UWVtdSB3aXRoIGFsbCB0aGUgcGF0Y2hlcyBmb3IgU1ZNDQo+Pj4+Pj4gICAgICAgICAgICAtIEFU
Uw0KPj4+Pj4+ICAgICAgICAgICAgLSBQUkkNCj4+Pj4+PiAgICAgICAgICAgIC0gUEFTSUQgYmFz
ZWQgSU9UTEIgaW52YWxpZGF0aW9uDQo+Pj4+Pj4gICAgICAgICAgICAtIERldmljZSBJT1RMQiBp
bnZhbGlkYXRpb25zDQo+Pj4+Pj4gICAgICAgICAgICAtIEZpcnN0LXN0YWdlIHRyYW5zbGF0aW9u
cw0KPj4+Pj4+ICAgICAgICAgICAgLSBSZXF1ZXN0cyB3aXRoIGFscmVhZHkgdHJhbnNsYXRlZCBh
ZGRyZXNzZXMNCj4+Pj4+PiAgICAgICAgLSBBIGRlbW8gZGV2aWNlDQo+Pj4+Pj4gICAgICAgIC0g
QSBzaW1wbGUgZHJpdmVyIGZvciB0aGUgZGVtbyBkZXZpY2UNCj4+Pj4+PiAgICAgICAgLSBBIHVz
ZXJzcGFjZSBwcm9ncmFtIChmb3IgdGVzdGluZyBhbmQgZGVtb25zdHJhdGlvbiBwdXJwb3NlcykN
Cj4+Pj4+Pg0KPj4+Pj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9CdWxsU2VxdWFuYS9RZW11LWluLWd1
ZXN0LVNWTS1kZW1vDQo+Pj4+Pj4NCj4+Pj4+PiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmICg3KToN
Cj4+Pj4+PiAgICAgIGludGVsX2lvbW11OiBmaXggRlJDRCBjb25zdHJ1Y3Rpb24gbWFjcm8uDQo+
Pj4+Pj4gICAgICBpbnRlbF9pb21tdTogcmVuYW1lIHNscHRlIHRvIHB0ZSBiZWZvcmUgYWRkaW5n
IEZMVFMNCj4+Pj4+PiAgICAgIGludGVsX2lvbW11OiBtYWtlIHR5cGVzIG1hdGNoDQo+Pj4+Pj4g
ICAgICBpbnRlbF9pb21tdTogYWRkIHN1cHBvcnQgZm9yIGZpcnN0LXN0YWdlIHRyYW5zbGF0aW9u
DQo+Pj4+Pj4gICAgICBpbnRlbF9pb21tdTogZXh0cmFjdCBkZXZpY2UgSU9UTEIgaW52YWxpZGF0
aW9uIGxvZ2ljDQo+Pj4+Pj4gICAgICBpbnRlbF9pb21tdTogYWRkIFBBU0lELWJhc2VkIElPVExC
IGludmFsaWRhdGlvbg0KPj4+Pj4+ICAgICAgaW50ZWxfaW9tbXU6IGFkZCBhIENMSSBvcHRpb24g
dG8gZW5hYmxlIEZMVFMNCj4+Pj4+Pg0KPj4+Pj4+ICAgICBody9pMzg2L2ludGVsX2lvbW11LmMg
ICAgICAgICAgfCA2NTUNCj4rKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+PiAtLS0tLQ0K
Pj4+Pj4gLQ0KPj4+Pj4+ICAgICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAxMTQg
KysrKy0tDQo+Pj4+Pj4gICAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8ICAgMyAr
LQ0KPj4+Pj4+ICAgICAzIGZpbGVzIGNoYW5nZWQsIDYwOSBpbnNlcnRpb25zKCspLCAxNjMgZGVs
ZXRpb25zKC0pDQo+Pj4+Pj4NCg==

