Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92BBD111A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 05:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ppt-0003Dt-Ue; Mon, 04 Nov 2024 00:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7pps-0003Dj-Jy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 00:41:08 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7ppn-0002yv-DJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 00:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730698863; x=1762234863;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XeqlZ6YmQ7/fZYnfn6mYXcdEFHtwPqkikJzHSR5Biqc=;
 b=Jr6UiGWWBBYLOS7ee6E2/Vi9s1/SgOt7is4QZ8wEBEfo8YAzmU7Zyub8
 aez4S5y7tpMsBA76fFYaBOlbSyDYgI6yIO21AzV1zxYlXHI7333qFSpa0
 JRjHiGEymqlMiQ6pxQFNfDaNnswXfJ6L7BVtaN0GMVjXNKQNbQnqop59x
 foQeMcq27TasxnwA+2LB27BPwjyMMOR9kUXgB20PGK/QVdS8pw7INT2FM
 wZL9tsXNicIJ/UvFkPRBROC1oxG8ajn9qC2NJrJasceqiJmbolI4bWGYE
 hh8NGV5M/ZEiVzWIBr++gWJjr9RitnCBIYdV5wsw0dYkADxAC8bI27Yt/ w==;
X-CSE-ConnectionGUID: R2MWAB6BQPCt8a49D1Vo3w==
X-CSE-MsgGUID: m1V8+EK4S0yl89sfVLebVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30558899"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30558899"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 21:41:01 -0800
X-CSE-ConnectionGUID: QAD+P14SRmmugD5zMoYQ6g==
X-CSE-MsgGUID: D4ncIimpRjuKWlpFDqMzsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="84358675"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 21:41:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 21:41:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 21:41:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 21:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOpAr0DYHe8WaIpJlN+PUDX8AX2cy28/B1tBlPqgcdayxaWDsshEMTk4sm6/PxL6rBVMdMXtknVU5NKezVCfKJVJwvDcTNp8VItXsqnB9IntNgP7f1dJobO29W2qHOnoYh7Wal8xuSMSKmi2Il3wZu92O1MsajHuAs/fU2hoNcUCl+/J834NvsEmo7Uxj9pRMeXprJFpuKdSIoSXFFXLvPaAQmwAg+8VAnJY/2R7OLn1UV5YoSnMDbDd+fARop1F/8bYqRLti9+/U1kdRP2VXhdxUTxWW/5P/oa79uYZu86kImLxRjdID+nxKvrnyyvFJykAJixGCdpSiyrl4ZzO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYdUSGmTwn4wZZsfdq5qYlrHXpm1e6sOMikW6v0hknE=;
 b=aR51C7M5VDcOEWoxILUEuGRIHQ/If/JCwQB2fd9CT90vcG+pe2Aqai5E4dZkQQ1iSCzURP5JIXzFq57pKf8cAS9dyHa4vTLvgi7Mcft47/PO94852g/yWeqd2eqU4dB3shcWEJn7OtE2Q4zjyul+HbwvaR/HzYT27/i7LAjNAdvfteCiuPgHYI73dX1etNsdOa6dwGgXtdT6CI0p0SwZq3abgVgOP5dG9NYaAwyTjG9+7sQdPUuUO+EsNCTBrdX8jWJfpJmJ4PKLygwbScg+Wc9vyAL+qOA9OiM07akq0VvBBDIVfLgScIlilCDBS66iLIziVI+70W7X1cFkfHfGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Mon, 4 Nov
 2024 05:40:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:40:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v4 10/17] intel_iommu: Process PASID-based iotlb
 invalidation
Thread-Topic: [PATCH v4 10/17] intel_iommu: Process PASID-based iotlb
 invalidation
Thread-Index: AQHbExt1Cvi+Y/czf0iIuiPCct0QOLKmonmAgAAPHVA=
Date: Mon, 4 Nov 2024 05:40:44 +0000
Message-ID: <SJ0PR11MB6744981BA2E527F9F6E7959192512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-11-zhenzhong.duan@intel.com>
 <ca5e5eed-ea6b-4e74-beaf-990ba8ca5f07@intel.com>
In-Reply-To: <ca5e5eed-ea6b-4e74-beaf-990ba8ca5f07@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6850:EE_
x-ms-office365-filtering-correlation-id: 62bec441-0215-4e42-69d7-08dcfc933a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QdBkkhjYqDsC2FHAeU5pifN7/A+LPNKt935HgwBtPr55jah1CwZUzO4bol?=
 =?iso-8859-1?Q?jtnzHo0U/TxiLTpkXqO1eLui+e6JBAe9OzN8XmtsjghTJY2wZMiLeiIImj?=
 =?iso-8859-1?Q?O8sRr1AtS9dSUCTVkdDZsbfcCeCNWtEdmucnoLZRAlg8LNsT/Tm6O/Yh5r?=
 =?iso-8859-1?Q?I2zvPVSJpA9kyVlzye5XlYllESnt+a2oJEXRCVwRBPZhDVYzSPJaLg8G8W?=
 =?iso-8859-1?Q?KUK1UVTZxeyPrSsEcD4AsjDP1ZhJloSqYsOr+WT5FNyXnDo3loKXbeV4pc?=
 =?iso-8859-1?Q?QcxIf1InMdS7Xs3vqOrAG3TlbNNVl9qiHufdb5/PvQoWofy0fsqkrRoZc3?=
 =?iso-8859-1?Q?lWiq/uYIflIir+QgaINt2DCb+7FfTU1eeGnwOGjSvREveyn7pItqBr9d7h?=
 =?iso-8859-1?Q?YSJ8xRs844kdeLg2iwZlfumvK8pgBsOpQlHBH3X4oHrVAvaddoju5VLbpk?=
 =?iso-8859-1?Q?Bv3vZvKBjpU+XT4mqxpHZhBctdJXq+PkSvtNFzwPcYLq9NbsI0j+6xeIoV?=
 =?iso-8859-1?Q?JTz19DpVIgBeNeHeqYGZpODbTtNTJM1EyTlUyZAmLUtQUTPiwm+icjwRu/?=
 =?iso-8859-1?Q?lpVnP+12IDp+25jfrtD9hHmdvQT2EXSk1c0GmBbfSUrQ4dQQpuqvngO4Ob?=
 =?iso-8859-1?Q?imUoBkM1qg/KK6EkBXHYH72eKxey3W977MRGc0dphuFwbnZA27KneVLs24?=
 =?iso-8859-1?Q?SmkVpbM26IjhOpJxprrzWm1QA8y1OPhu3vzr0JCJ77MUYBgSVGpK7Kdjpt?=
 =?iso-8859-1?Q?5kjIirbUJlCfglpFhFBmVIg5BiNjyNv7x9CoPvqVa022kOg1EVI8y8jnON?=
 =?iso-8859-1?Q?bPdzItEm9JkQ4E/K6QL+RvenZGLwHXSTTyWd0o5eZj61V0SmGr0As56F8z?=
 =?iso-8859-1?Q?oi7yf9FHT2Aiwgx2Vxa2/sovtWzVTZnn1Irl0MH08ThKJINvlsjypgdLtV?=
 =?iso-8859-1?Q?3JewQ9jQQZpxrvPEg0j9vWXsC3UpQzFdzgNr0qzvPeer1d7yo67Eg/0o3X?=
 =?iso-8859-1?Q?lTQHcbiIrFayk39GKX6BhqKBLcwz6Wfiuz9EWvP94elPYRWPK8MzxrdSV+?=
 =?iso-8859-1?Q?gw6+sKIA6ziedi2LRfAx0OEhcf7pnX/hoV1jJUkoHmfFeTJk3S7UAJwaph?=
 =?iso-8859-1?Q?DIb3k4hsdSU1qT7Uzkif9pEkDb/w3IdagC5JxT1rIDpBGdi9kntSpLQ9Qf?=
 =?iso-8859-1?Q?KxLoidGH5NwqDqFY3U/1oRoMRBVQxy1QzwN00pWlmkkSUyW7BUo7cgMO+W?=
 =?iso-8859-1?Q?e6Ai2gJP41a0JpbsMkU0yrbrCe9LChqtX5k95o/qATSETW9QLAdb++kLaX?=
 =?iso-8859-1?Q?K+swtbwX3vU8zAkPdTyXKwvVaROk7+bbR6lVU6zbgauXbxB+0vsiPwdHCn?=
 =?iso-8859-1?Q?JJE1FNGYm8beN6NMffvikjcV7voRcd2rqQ0e1/nQMVtbmyiNqRfDM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P+7y/0L3BXCyj22OR83dLE2YbM+kvcqObNL/gs6N6Jya0GoNulqFWMylBU?=
 =?iso-8859-1?Q?f7fNzm/djYpwzHcSidoVk5l28+bfhundjHvBc551lP9pGdv4LcvkjgYHh8?=
 =?iso-8859-1?Q?jIiKdCDbqH+dVd5pB4dFeGlXnIM4irtSt+nEyMnWg1g6pVWX1L081xzNZC?=
 =?iso-8859-1?Q?72w3HEqBPXqClrprCP9OMnGq0RlXuBLo2k1mKyXnIgxqqdfnw2UcAPRct9?=
 =?iso-8859-1?Q?sg0NJmDJv5WwjjE19wuh+tQfZ42xch7CmNStu8Kx7Io0/llvQVzCPU8UKN?=
 =?iso-8859-1?Q?v/KN42Oq238bi0d+zIX1wlYrjNWi3zCE5l6PZO5KauPRW94KjNrKSa/dAk?=
 =?iso-8859-1?Q?EHXrPgd/vicTxUdupCcxw+Oy3kGrcviZJDcKzTY63XDCdbbYeYhNQ3oGun?=
 =?iso-8859-1?Q?iT14hPSyAd7WspX5OH4jnbYne2ThANaEjQy2T2YjEriCTXBe1WWNQtatFB?=
 =?iso-8859-1?Q?D4BVcZrZR8W5OL2dhhL5gsgCwgFRH3RcLbnkIv8U7UY4w/eTu276Oo9eNs?=
 =?iso-8859-1?Q?asvoHiXI6n06cBXWwF5vphNBvX18aJetxi5s+MpFl265xAA4McP9xgczN7?=
 =?iso-8859-1?Q?zjNNnyBXbUerVEVe8PDKifU43ECOFLQBKqIgUTaGmLaTC1carbdahPHoK0?=
 =?iso-8859-1?Q?grI8X0mlcGHzcPFLN5LrL62loM/rK3eRFKdZjgxOmuqCvWShDV89DlySaU?=
 =?iso-8859-1?Q?ALzuaPqsgww9jEBeVJzrrKDr7eM6AZ3qZZzZs4FmLbsFthGaIw6L46LdDt?=
 =?iso-8859-1?Q?JdDPIF0QeAYv3NIoc7qnzPAG9+SoFCwU/jaf74A7DMh8Ukdyp+1qo7FuPT?=
 =?iso-8859-1?Q?C0uXfGX/D8FFE0CbsewDn1IkgKkZWnuFtM4pOrabyHqGc3T5XFGiRDN4xc?=
 =?iso-8859-1?Q?ED4RtRFKN+B9LY/Wxvw0pju6LCWfl+ehCTUPV/1cGYYLJq1SLroyfG6cM4?=
 =?iso-8859-1?Q?JbgTAr3QXeX3deh9qOCl01+7RKljHv/UZNoG75hRSAvWEGJjvQNoTc9rUj?=
 =?iso-8859-1?Q?RW+45altMEPO0bKjt27vGglt/4PuMSQqa70uS3QxE/MnSZnKmzQJEfAFEi?=
 =?iso-8859-1?Q?Pp0kWoe7jkqYYf6Wvl/eX6WEbG7qoXaiPOgC7SQo9phJjAv3rTkyyXSvaz?=
 =?iso-8859-1?Q?e5JVqr8SZicBuVYaXOUnNU+Dk6bN0cLincnoGfm0AfigwuEDIvy/jhLFB0?=
 =?iso-8859-1?Q?nSJEruj9pNl/ptRwlCRyFSHL32naeEwMuY+lvJnsgiyBkg7bbVQi2EekEz?=
 =?iso-8859-1?Q?1QMfmk9Y0iQQtPLP7pc2nR2o/0hP0H6h4YkkNbJHYe415Su057emcILFIp?=
 =?iso-8859-1?Q?fqs45QLUYhBV5r6aqV7zXA28MedkEd0jBqSNu0Mq7hgtQp+s+Dtn3H5Hhy?=
 =?iso-8859-1?Q?L77WXU0vGVpvrezjusBJctdQFpK3gjSGzllxktAgacu6N5YlXscpIXS/qY?=
 =?iso-8859-1?Q?MJg2ZGIRHt2ayv8OJekFjrHT5XQqETkG9UkjOx0BOtaYhe+8XwVYFQFK77?=
 =?iso-8859-1?Q?RFcvkzRQpB5S4hBF25h8sP4I8RMxcUEGzqzx3PHd0CHsNw1UcXbo3DwRCA?=
 =?iso-8859-1?Q?LSPqqjHAdc8wfhA99h95THHppi1DRT61n4VOUSsBDpU7NBvhOIsfcRYuS0?=
 =?iso-8859-1?Q?lgUyozqGLbrKvbTdwm0gGuZ3URt7DknMGC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bec441-0215-4e42-69d7-08dcfc933a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:40:44.8139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xdv+FTfmwjQ+e+yD7wPx8tLLr36Lo/p7SEtoFOK7LQPi4+D0cTJjh6vPk0vyQ8mrFATbz/6FCxRHaHPyj/e9XcKrGAxS19hclNx/vstzuNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
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



>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Sent: Monday, November 4, 2024 10:51 AM
>Subject: Re: [PATCH v4 10/17] intel_iommu: Process PASID-based iotlb
>invalidation
>
>On 2024/9/30 17:26, Zhenzhong Duan wrote:
>> PASID-based iotlb (piotlb) is used during walking Intel
>> VT-d stage-1 page table.
>>
>> This emulates the stage-1 page table iotlb invalidation requested
>> by a PASID-based IOTLB Invalidate Descriptor (P_IOTLB).
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: Cl=E9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/i386/intel_iommu_internal.h |  3 +++
>>   hw/i386/intel_iommu.c          | 45 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index 4c3e75e593..20d922d600 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -453,6 +453,9 @@ typedef union VTDInvDesc VTDInvDesc;
>>   #define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
>>   #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) &
>VTD_DOMAIN_ID_MASK)
>>   #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
>> +#define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
>> +#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
>> +#define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
>>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 46bde1ad40..289278ce30 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -322,6 +322,28 @@ static gboolean vtd_hash_remove_by_page(gpointer
>key, gpointer value,
>>       return (entry->gfn & info->mask) =3D=3D gfn || entry->gfn =3D=3D g=
fn_tlb;
>>   }
>>
>> +static gboolean vtd_hash_remove_by_page_piotlb(gpointer key, gpointer
>value,
>> +                                               gpointer user_data)
>> +{
>> +    VTDIOTLBEntry *entry =3D (VTDIOTLBEntry *)value;
>> +    VTDIOTLBPageInvInfo *info =3D (VTDIOTLBPageInvInfo *)user_data;
>> +    uint64_t gfn =3D (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
>> +    uint64_t gfn_tlb =3D (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4=
K;
>> +
>> +    /*
>> +     * According to spec, PASID-based-IOTLB Invalidation in page granul=
arity
>> +     * doesn't invalidate IOTLB entries caching second-stage (PGTT=3D01=
0b)
>> +     * or pass-through (PGTT=3D100b) mappings. Nested isn't supported y=
et,
>> +     * so only need to check first-stage (PGTT=3D001b) mappings.
>> +     */
>> +    if (entry->pgtt !=3D VTD_SM_PASID_ENTRY_FLT) {
>> +        return false;
>> +    }
>> +
>> +    return entry->domain_id =3D=3D info->domain_id && entry->pasid =3D=
=3D info->pasid
>&&
>> +           ((entry->gfn & info->mask) =3D=3D gfn || entry->gfn =3D=3D g=
fn_tlb);
>> +}
>> +
>>   /* Reset all the gen of VTDAddressSpace to zero and set the gen of
>>    * IntelIOMMUState to 1.  Must be called with IOMMU lock held.
>>    */
>> @@ -2884,11 +2906,30 @@ static void
>vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>>       }
>>   }
>>
>> +static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t
>domain_id,
>> +                                       uint32_t pasid, hwaddr addr, uin=
t8_t am,
>> +                                       bool ih)
>
>@ih is not used, perhaps you can drop it. Seems like we don't cache paging
>structure, hence ih can be ignored so far. Besides this, the patch looks
>good to me.

OK, will drop it. But nesting series needs it, see below.
I'll drop it in this series and add back in nesting series.

/**
 * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
 *                                           stage-1 cache invalidation
 * @IOMMU_VTD_INV_FLAGS_LEAF: Indicates whether the invalidation applies
 *                            to all-levels page structure cache or just
 *                            the leaf PTE cache.
 */
enum iommu_hwpt_vtd_s1_invalidate_flags {
        IOMMU_VTD_INV_FLAGS_LEAF =3D 1 << 0,
};

Thanks
Zhenzhong

>
>Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>
>> +{
>> +    VTDIOTLBPageInvInfo info;
>> +
>> +    info.domain_id =3D domain_id;
>> +    info.pasid =3D pasid;
>> +    info.addr =3D addr;
>> +    info.mask =3D ~((1 << am) - 1);
>> +
>> +    vtd_iommu_lock(s);
>> +    g_hash_table_foreach_remove(s->iotlb,
>> +                                vtd_hash_remove_by_page_piotlb, &info);
>> +    vtd_iommu_unlock(s);
>> +}
>> +
>>   static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>>                                       VTDInvDesc *inv_desc)
>>   {
>>       uint16_t domain_id;
>>       uint32_t pasid;
>> +    uint8_t am;
>> +    hwaddr addr;
>>
>>       if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
>>           (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1) ||
>> @@ -2909,6 +2950,10 @@ static bool
>vtd_process_piotlb_desc(IntelIOMMUState *s,
>>           break;
>>
>>       case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>> +        am =3D VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
>> +        addr =3D (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
>> +        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
>> +                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val=
[1]));
>>           break;
>>
>>       default:
>
>--
>Regards,
>Yi Liu

