Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B958FF60C8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 05:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7RDg-0006ox-2j; Tue, 31 Mar 2026 01:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7RDc-0006my-Hu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 01:00:48 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7RDT-0001Si-8E
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 01:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774933239; x=1806469239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o3eOHfObMz+GggWV0J/JzhreAl3bbulM+4dREiiIm00=;
 b=aW1R/ZlzToXfvPJqNPHtDGkAbly9PLL+NgfkGMZNcAFu53rcet8/1SJa
 qGK6MShVuzQnlaPZsJ9MC/vpxjuO4EUodMdW2Q24DiBMcmqUxUn1ZPRqK
 ZrLmGH4e60USjgs515AM84rxTzvBBMhWZPQUC6Se1M2zFWhtqimHKUUow
 gG5wi2iz0wkTxdJP3cArR7Y9XISVdwIhETBGnlOFqamMrdq7A3T0ov+gm
 9yL6s8ioNkwoPTjrvXd9fW53qjSeQCFH3QGT/Ct2wVi25PIqU+IC/Oxs/
 JEKSxwimPD+iDUyzOq9oqrE0FQuFqlWZP9gVo/fdAZLeknYZLKuLgyuBH Q==;
X-CSE-ConnectionGUID: OZeLNbGySVmoem8jql3vRQ==
X-CSE-MsgGUID: U829Gg0JSZ+clwkAfo5h8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79833804"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="79833804"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 22:00:35 -0700
X-CSE-ConnectionGUID: ZIsuOY+JQb6Ulz4y8t36KA==
X-CSE-MsgGUID: e5lhAWefS7CBOSVLLqWwWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="231061808"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 22:00:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 22:00:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 22:00:35 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 22:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI8RwTqOxbJK4Ii/deHwfiP9Sjc6TDPLja1eqJb2L5Rj9WDdeAKwSQkUSq7NYaJpNOau3AWEmVl1Ys2w2VUobzPdKtEkYSTfPb7Hch4dbdyUsX99Ku4Bf5DWEl2BpBHYTmk3qLgey+ZEFN0q1Ig1nWGcFXksjdFp0LLQveJ5wf58yEJREimld8bOstNj0SYNKn+prgb12/QwVJLnSBFV1tCkhCAjDIpaEqiFXXC63eKjDZW94tEkGm5bbeUFQzjqAK6WqWbpMEvhlFRx91wfUq5yLLmHEq8BwbKkPeKbLjmSggUYS7dbNWtCQmgYuZQ8qMbv4njzLyXvtX3vya5Zew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3eOHfObMz+GggWV0J/JzhreAl3bbulM+4dREiiIm00=;
 b=f/6UhNXu718Qfdg3pHlHVKzVqlCgV0pf6Sowa9NKS7N07rmzBlOAbzXMO8e46+WgV0rns8tvzGdmm4LYR/igE5oCXkiP2qR+UquECHwlNdKk87Zkh3FjLakxgPPtAfnKXvOcfUq3BfyuIMVzEeNbdDfKIUm9OhvL4ZLBpk1oldSIMk1J5BGmK2oyHvwNZhIdRRZ7Qvp3dSvMQOAK4jjtt/J5FTZngOqqyjaE6SEyp/TKEo0cPhFOLBGKvJvhHyuFW32k9iisXrjHPZFo80CRmtbymJdsqlrwQx5iVFfpg1fEcbbn8Iu/MxF9NzvJPG3lqvgLh0mTxlp/3QRUlVJYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Tue, 31 Mar
 2026 05:00:32 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Tue, 31 Mar 2026
 05:00:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH 4/5] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Topic: [PATCH 4/5] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Index: AQHcvZTT22HcSP9u/UKSocoBc+M+EbXGrK0AgAFtAYA=
Date: Tue, 31 Mar 2026 05:00:32 +0000
Message-ID: <IA3PR11MB9136BD47ABDB98735C9BD0DF9253A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-5-zhenzhong.duan@intel.com>
 <a874598ba13c8e47751f01dca4649342365bd983.camel@eviden.com>
In-Reply-To: <a874598ba13c8e47751f01dca4649342365bd983.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB7040:EE_
x-ms-office365-filtering-correlation-id: 20dae127-b102-4399-7af5-08de8ee26fda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: JvvbQbX5eAOAK8KUCXGIjMm+fW6XJtP818/wlmtDmL9feMZOhS83ZAPKaAAZtrd2RIZ8cjMpFCaU3ixa/GSDzd079OM176UBey586uWAAr6kWn6uco96W+rZTVbDiyZUN40XgZQzEGK5rFxnqpguRUpq4teyZnSdFFzMSachxvp1eS2/0jRRPHLxC8hKZBVOBkD9JiEtJ0G4xDBvRP8pfmieSQNL9H4BeDIejctVf1AiH95/co36i2tEup7Ey8MLG49KP0k+lkBWM9j1ihuf75rdzHQEuqLwWv0TpLep42zWjhyq1hnqPhTGJWL6h+uPVWczg9Dqhk7y1S1c03G0TO6KdXwXM4U9sSSVC8+Bw4fN+9Mrnxc5EIX3d29L6CI5CU5Ddlkk6ZwWUA7EhKigwdkhK9ml2/Wlrwy2NPF0RFKGtkG+9Tif8hcB738tjhW14FH1njaIVzkoftnYsZu7moz738gt7d3Y5ls+wf1NaID3x6DGsKZozMOK5NpqVzWAGF8DXnXOjRG20nU1Xci+BeqkN2O/uEXrnIogz5eBTuXMHFS2i1t+TtcOVCXwt96z3LMYSwpIGKBRfi2YpgDqjzNsnZcOa5K6NE7J+lL7Ws+ob6SqXdm64uLn9pq2iI1BnLJMzYp/F1jC3ZtPAhZxmbesGFoZmZol2QVACbv9Au0NIgepCkqkEA/fQG88S+BOS7hWAPYo+v3ecdfQ1tAtVy2yeIh189oE7OlMmbE5ZGVoTh8x8pz9KNQtgO2AYpLtgxWUd+pFOF4LkaaT1Nzx/mLCh+vXo9h57ZBLjk/osqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXh3YWZSWGhxN3VETG54R0JrSTJsSXFxbDFPeXlJdmlTS1lML003T0lBaDJt?=
 =?utf-8?B?SE9zMUZTU2lQZmVvdXpOeFlzREMrWGRDTXEwTnd6a1hCNUhaUi9Ccjk5TklW?=
 =?utf-8?B?dk9Ya1p3Vnh1cFdMTmtDT2Q4WFA1UE10aWNWVk1oOHJiMWZjMmpBMFA0WFR0?=
 =?utf-8?B?TmdPVnpvS3kxL1JIRHBWZDc5d3l6ZW1LQS9tN0dtTC9UNEtpVStNV0RCZVlZ?=
 =?utf-8?B?TjVremJxQXk5OVJUc3ZwOVpXMmh4elIyV0lKM3R6RnhRYXN2SjdHN0FGOGRJ?=
 =?utf-8?B?dkpSL01WYnNQWEdPQVNSaHNiOTM4MFVvS2VEWTVoMG5DRzFSMkJLUTNxeUZM?=
 =?utf-8?B?SmpaZUl0dVJEVGtWQklxSjlsK3l6SkhLVlptZnM3bnl5cGFFZDYxU2ROMEwy?=
 =?utf-8?B?UjMvb0R1MWhvVkhNMEYxRmhvSnB0TEhsNEhtRmlQc2NDVmVBQkRJVnpFYlpp?=
 =?utf-8?B?cXZYbWliKy9sUUh3cFRzZVRldkwxZklWYUlxSW5SR2VWZzZGdFp3KzNvY2xq?=
 =?utf-8?B?ZlNWTTlyREdUU1RiaFVwbWFXY3RHazlCUENFQzRTWEJ6WjhLWTV6OTRXd0Jx?=
 =?utf-8?B?K0ZlbVV4blBZTkpjbFhWNUY2cGJ1UU1TRVAzVjc1cG5tSlUyZk9iTXdwRVQv?=
 =?utf-8?B?b0MxcmpvSnFUVzB0YUhFS2tzUHphQjlSUkNtU3hPbnN6WUJSdGF1eHZoZzNN?=
 =?utf-8?B?ckk2WC9Ka0FSODljODBWZlMraUhVcEh0aGNUeWZ4czN6YU1pZVdZRUgwSGpO?=
 =?utf-8?B?RTg4ZWxKUG5WcWFYZGN6RDEya0hFN3hXczZTM2VnbEQ0WVNNM245ZFowL3Jm?=
 =?utf-8?B?U3poV0lJU09VMEtGelNPSVdJc1FvbmNjakNUNjl1aUhjbGtVVDFHNlIxbExW?=
 =?utf-8?B?Q1pyWnUvNFF3Si84enlCWTVvSjFIZk5CR1ZJTDlpc2E5WlZTUkdrUW1ZRCsw?=
 =?utf-8?B?MTBUVHZ2eFVLNUhLc3JrUlpTSzlYMWNob2sraklNM2ZWMkVDWGNuTVFOVTlS?=
 =?utf-8?B?N21wL0ZnaTgrc1dZT0tMMWh3dVY2bWxQSFZUL213Sm9LNHViTE1jSnR5MkEr?=
 =?utf-8?B?MFNGWThIbHFoNXJZZ3E0SGhvSjF5RUc0ZFI3cStvQlVXZ2RINm9ZUEt0cGVS?=
 =?utf-8?B?c1cyckZRcXZNZHFhdlZad1Y5dzVTbWZUbmhGL2RobDRzMUFtU1pUVEFXaXpS?=
 =?utf-8?B?VmpleTZ3OGhpZ2dxY3hCWXZGN3FGSnhPYUdxU2hTaW9XblJOOW9tYnRZcUVn?=
 =?utf-8?B?b1h1c1dRc2Z5eVZtVEN3Q2krT1RNS0FxVjgxV2FUcEo5MU5aSE1Wc09FamtV?=
 =?utf-8?B?K2F6ODNLQm8vbDU4dDZ2UE1Vb2JDTzZRQ1dSOHM2YmNaeVV1Mytsd0Q2bUdx?=
 =?utf-8?B?eXZKYUw3NDlUbFZqcDRDSjYxK0dCN0lBc2ZMRGd5LzRJek9hOHlvTlVpUnhl?=
 =?utf-8?B?WEJSMGFMRmI5VWkyTitBTG0vS09MUVpxcUxRSjhZeVJURFU2NnVlQ1pFWmF1?=
 =?utf-8?B?TVU3NGJ2MUZ1NnVWeFFMUS9uWVNaS0Q1bjdpMDZ6VTFROW0zenhSdU84ZTVq?=
 =?utf-8?B?dHBkeU5JcnNwcFlSdWhvZ3FndjFvYUF2ZERJK2FreVk5bldWTGF4ZVBKZXlK?=
 =?utf-8?B?dG4zZHlZa3lRZ1FOdVNUby8wSnAzQVVpdGRQdTJnM0EwdVhXZDFFM3lTaFFk?=
 =?utf-8?B?Vk9vWllpN3NmMFNtQzdnK2R0cVhxcllBUGFNSVN2TnVPQjM1Y2RDcnh5Si9L?=
 =?utf-8?B?Y1ZEb3pxQ1dwQ2JpbUhSemhLakVBYTNidE1rMHZnSk8wQXVlcWlocFNPbloy?=
 =?utf-8?B?MmRwN0VFaXg1WTc3MkphVWRoN3FTUzhPSHk0Wjc3dEQxVWkzUm1MbGQyUlNP?=
 =?utf-8?B?TjNHMmdOdlRhMXdhdmwxVDh6QnNqQXNQTEdYTjZtajZrUDdLem9QY2pNQ1Jk?=
 =?utf-8?B?MnFsM3RIdGg5ak5YcFNSY2hoTmpCQVBHaUZlVjFsUTMyRWNzMExxYnVkeFdq?=
 =?utf-8?B?azRVeGRLcWE2S1MzVTBucVhDaGJwNVRDOTlCMFBjMitlQklkQUJhdXFaY1RX?=
 =?utf-8?B?OVhuclRPV1VJT2NxZTdDM01mS1Znd0dpR2xMVEcxZzNiMFJBeDJTeVY3czhm?=
 =?utf-8?B?VkFjbWJWMGJ3MTYvU1JwS2tUeERTb2pVbXl1S2VFdHgxRFhrcHdibHcyZjBK?=
 =?utf-8?B?WXdVb2lTK3FRY3FpT0JycE5KM2QxL0JJT3JCMzNreTV5WGdDR2M4WEJhV0JR?=
 =?utf-8?B?ZlZWaUdIRzFLUjJDdzRKbUdQd3UxcGl2VXFzMUhjUkUzSm84WXNVWHBUZWN3?=
 =?utf-8?B?aTZUNE1SVFM4ZVVtWlZSU3ZEbllZSndvTjRkTUo2eVpFRTBpbGFZdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YYbALUzH3QHlbQ3L4S6Dtf4IxjGJNZGA5lmFvX2TmDnFkPoVGYYO9l5XBEuVXUM49gtuUTq1sLZ0/RsEqiaQZTqssIMRiiL65FJ9CwNqKdQd18hqVqiUor7EWK8sONsbIFPh++JKBrTzf2Gf2xl6lqgugPV3wXr3DfSZvrxSc/k5By/mzRzx0wcAqotcBi3CgzH0+Q1Lp9wrNd1QTCnYFtzWouM52o1fYvaLp2C5okW0rB//c/ZHnrYvjaVFBF3pHfoOpo4yYzxrsFi2mW3RwsdENKLbVylkSWSdXeEzzAZ5ov/zGuqVEkatd/HmNMo0/Hlm4+4IAHkcQl8SiPUhgw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dae127-b102-4399-7af5-08de8ee26fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 05:00:32.3068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfKHykUh424XI0k4b9iL2brFc4tDeb59oZENl3s5MDLiXALmBE5Xj0JYpJ6khg1mILrzE/YpTbNtZlSR/swbaXdTQQJimA2hTOUYp4WYOoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQo+U3ViamVj
dDogUmU6IFtQQVRDSCA0LzVdIGludGVsX2lvbW11X2FjY2VsOiBBY2NlcHQgUFJRIHJlc3BvbnNl
IGZvcg0KPnBhc3N0aHJvdWdoIGRldmljZQ0KPg0KPg0KPg0KPk9uIFRodSwgMjAyNi0wMy0yNiBh
dCAyMjo1MiAtMDQwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBQcm9wYWdhdGUgZ3Vlc3Qn
cyBQUlEgcmVzcG9uc2UgdG8gaG9zdCBieSB3cml0aW5nIHRvIGZhdWx0X2ZkLg0KPj4gQ3JlYXRl
IGEgbmV3IFZURFBSUUVudHJ5IHRvIGNhY2hlIGNvb2tpZSBmb3IgZWFjaCBmYXVsdCBncm91cCwN
Cj4+IHRoaXMgY29va2llIGlzIHVzZWQgdG8gbWFyayB0aGUgZmF1bHQgZ3JvdXAgb24gaG9zdCBz
aWRlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuDQo+PFt6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb21dKG1haWx0bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pPg0KPj4gLS0t
DQo+PiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaMKgwqAgfCAxNCArKysrKysrKw0KPj4g
wqBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8wqAgNiArKysrDQo+PiDCoGh3L2kzODYv
aW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKysrDQo+PiDCoGh3L2kzODYvaW50
ZWxfaW9tbXVfYWNjZWwuY8KgwqAgfCA2NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPj4gwqBody9pMzg2L3RyYWNlLWV2ZW50c8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSAr
DQo+PiDCoDUgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2Fj
Y2VsLmgNCj4+IGluZGV4IDEwZTZlZTU3MjIuLmI0NmM3MTI2ZjcgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuaA0KPj4gQEAgLTE5LDYgKzE5LDkgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREQWNjZWxQQVNJ
RENhY2hlRW50cnkgew0KPj4gwqDCoMKgwqAgdWludDMyX3QgZnNfaHdwdF9pZDsNCj4+IMKgwqDC
oMKgIHVpbnQzMl90IGZhdWx0X2lkOw0KPj4gwqDCoMKgwqAgaW50IGZhdWx0X2ZkOw0KPj4gK8Kg
wqDCoCBRTElTVF9IRUFEKCwgVlREUFJRRW50cnkpIHZ0ZF9wcnFfbGlzdDsNCj4+ICvCoMKgwqAg
SU9NTVVQUklOb3RpZmllciBwcmlfbm90aWZpZXJfZW50cnk7DQo+PiArwqDCoMKgIElPTU1VUFJJ
Tm90aWZpZXIgKnByaV9ub3RpZmllcjsNCj4+IMKgwqDCoMKgIFFMSVNUX0VOVFJZKFZUREFjY2Vs
UEFTSURDYWNoZUVudHJ5KSBuZXh0Ow0KPj4gwqB9IFZUREFjY2VsUEFTSURDYWNoZUVudHJ5Ow0K
Pj4NCj4+IEBAIC0zMSw2ICszNCw5IEBAIHZvaWQgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9h
Y2NlbChJbnRlbElPTU1VU3RhdGUgKnMsDQo+dWludDE2X3QgZG9tYWluX2lkLA0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdWludDY0X3QgbnBhZ2VzLCBib29sIGloKTsNCj4+IMKgdm9pZCB2dGRfcGFz
aWRfY2FjaGVfc3luY19hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMsIFZURFBBU0lEQ2FjaGVJbmZv
DQo+KnBjX2luZm8pOw0KPj4gwqB2b2lkIHZ0ZF9wYXNpZF9jYWNoZV9yZXNldF9hY2NlbChJbnRl
bElPTU1VU3RhdGUgKnMpOw0KPj4gK2Jvb2wgdnRkX3Byb3BhZ2F0ZV9wYWdlX2dyb3VwX3Jlc3Bv
bnNlX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVpbnQxNl90IHJpZCwgdWludDMyX3QgcGFzaWQsDQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBJT01NVVBSSVJlc3BvbnNlICpyZXNwb25zZSk7DQo+PiDCoHZv
aWQgdnRkX2lvbW11X29wc191cGRhdGVfYWNjZWwoUENJSU9NTVVPcHMgKm9wcyk7DQo+PiDCoCNl
bHNlDQo+PiDCoHN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2NlbChJbnRlbElP
TU1VU3RhdGUgKnMsDQo+PiBAQCAtNjksNiArNzUsMTQgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+
dnRkX3Bhc2lkX2NhY2hlX3Jlc2V0X2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcykNCj4+IMKgew0K
Pj4gwqB9DQo+Pg0KPj4gK3N0YXRpYyBpbmxpbmUNCj4+ICtib29sIHZ0ZF9wcm9wYWdhdGVfcGFn
ZV9ncm91cF9yZXNwb25zZV9hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCByaWQsIHVpbnQzMl90IHBhc2lkLA0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSU9NTVVQUklSZXNwb25zZSAqcmVzcG9u
c2UpDQo+PiArew0KPj4gK8KgwqDCoCByZXR1cm4gZmFsc2U7DQo+PiArfQ0KPj4gKw0KPj4gwqBz
dGF0aWMgaW5saW5lIHZvaWQgdnRkX2lvbW11X29wc191cGRhdGVfYWNjZWwoUENJSU9NTVVPcHMg
Km9wcykNCj4+IMKgew0KPj4gwqB9DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2lu
dGVsX2lvbW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gaW5kZXggMTg0
MmJhNTg0MC4uNWQ0NGVhYzBlZCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gQEAg
LTEwMCw2ICsxMDAsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUEFTSURDYWNoZUVudHJ5IHsNCj4+
IMKgwqDCoMKgIGJvb2wgdmFsaWQ7DQo+PiDCoH0gVlREUEFTSURDYWNoZUVudHJ5Ow0KPj4NCj4+
ICt0eXBlZGVmIHN0cnVjdCBWVERQUlFFbnRyeSB7DQo+PiArwqDCoMKgIHVpbnQzMl90IGdycGlk
Ow0KPg0KPkhpIFpoZW56aG9uLA0KPg0KPk1heWJlIHNpbGx5IHF1ZXN0aW9uLCBidXQgd2h5IGRv
bid0IHdlIGtlZXAgbmFtaW5nIGl0IHByZ2k/DQoNCkdvb2QgcXVlc3Rpb24sIHRoZSBuYW1pbmcg
aXMgcGlja2VkIGZyb20gdUFQSSwgc2VlIGJlbG93Og0KDQpzdHJ1Y3QgaW9tbXVfaHdwdF9wZ2Zh
dWx0IHsNCiAgICAgICAgX191MzIgZmxhZ3M7DQogICAgICAgIF9fdTMyIGRldl9pZDsNCiAgICAg
ICAgX191MzIgcGFzaWQ7DQogICAgICAgIF9fdTMyIGdycGlkOw0KICAgICAgICBfX3UzMiBwZXJt
Ow0KICAgICAgICBfX3UzMiBfX3Jlc2VydmVkOw0KICAgICAgICBfX2FsaWduZWRfdTY0IGFkZHI7
DQogICAgICAgIF9fdTMyIGxlbmd0aDsNCiAgICAgICAgX191MzIgY29va2llOw0KfTsNCg0KQmVj
YXVzZSBWVERQUlFFbnRyeSBjYWNoZXMgcGFnZSBncm91cCBpZCBhbmQgY29va2llIGZyb20ga2Vy
bmVsIHVBUEksDQpzbyBhbGlnbiB0aGUgbmFtZSB3aXRoIGtlcm5lbC4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

