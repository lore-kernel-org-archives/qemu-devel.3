Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C148EF48D1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 06:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqmV3-0007MP-NL; Fri, 13 Feb 2026 01:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqmV0-0007Lu-Lw
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 01:17:54 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqmUx-0004Nh-8G
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 01:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770963472; x=1802499472;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UBoFReY23Pk0Kg0wdyVY0806IGHztuGI9qb3hAGgtik=;
 b=C7uq9CyTqLBp5KJGzxbTbuyceFo4qi2rU3KYeI/YhMh33nBjeeRhYjXg
 jH8yx2mBWF8JimqieG4LcY2oNLpnAZ/Kos+Czk09EJ+9DN6EQGx+uSh6l
 REq4UYyRpwpOAVTo8nWiVnHXTis5i7eOYbEVZyPYAPnTGuYqn3qhuaISl
 ySIZPqyRPF4PoHXtQ3WB3GJ1EDRsHNCGRdWtluUlyH5h/S75hWw3yHJyp
 fTsv5hx2297el1o2/b/tGYj0UCX8zooi00fmU+BVXKc3rhas4xN4L3e2j
 +NbK5KQXlW6H1afqrmraqA/qJjHRsDv3M8tNcufoGKPAvQIwHPlTd09Iw g==;
X-CSE-ConnectionGUID: OWSm+kRUSOaDrK5qCfE7tg==
X-CSE-MsgGUID: ps0yFC0eT66O+p/zaOob3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72191360"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="72191360"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 22:17:48 -0800
X-CSE-ConnectionGUID: VgcDLE20SguG3ExQPxgk6g==
X-CSE-MsgGUID: 70Q51qPLQVW69E/2Eit0hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="242293190"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 22:17:48 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 22:17:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 22:17:47 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 22:17:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xapNH192eqnG6LuImUW3lhiF7gHpUjgi91avxFIskqngp5EWp9L71solyut2fnCoGTLuLJdZLY0Q/sr/wOKpQS41AqW9Rnqh7VhRRce/JQCLppxyI+CsuNLSUyUr9b3hG1NFvsbk+gf/9JptYyX2YM6/p9SQ/IgGJ0G4hjwxS+ofXKhRgD1y2tN71/xrQUbjnI4oHw57dMc0qgYR+nze5J7vM1p28pMhYnL6x/EFXPUlQ59VXLjknY1V0QtDwHlUYXWihIAqRleGIKxo1dZGlJvaKIqRYj8tVFyWpCnMjmEW8euj1EASkmRG8OKtaZXauiv1p254mYmY4asJEcEE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBoFReY23Pk0Kg0wdyVY0806IGHztuGI9qb3hAGgtik=;
 b=jKeNf/JIr8Vwffwgs77qsIgoe3fggh5XWWXoXHZFAZkXqcgDPQMeGdvQszERTN2DRNv1Cih/lMQ9Oh49wE5sdCu4+Xm65tzWWQicMZuNUgOE4R9xkEr90cRuPfCT143tG8cZ7M0Ezh/md3rfyR/JU8N/ZxCbvVPelO6xEnt08SPrLyRyg+g2+SSbf52fMj6eSCZ2rCK1i4MHMM9VvkYDoxq0nIzngETxRTO8oyffFJLLdH2Q1SL9LBFizkp3oEZl4FMDJkxTrbKhaGcLlXd+RM0YCR4Z6rtdFfSfLwzbYXxVVzhMcAyk1sZvpDmKubx11RxORR4WQ7nGrenG0tA1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by CY8PR11MB6964.namprd11.prod.outlook.com
 (2603:10b6:930:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 06:17:44 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::6133:51a3:d513:fc61]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::6133:51a3:d513:fc61%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 06:17:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 06/14] intel_iommu: Export some functions
Thread-Topic: [RFC PATCH 06/14] intel_iommu: Export some functions
Thread-Index: AQHclk1RKm/2KgcLIECa2GtFEa2HqrV+vrGAgAF1K5A=
Date: Fri, 13 Feb 2026 06:17:44 +0000
Message-ID: <DS4PPF93A1BBECD17B215CE8E6F9999CA059261A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-7-zhenzhong.duan@intel.com>
 <1d7e53d3f80772a06878a87f0be637421070e2d9.camel@eviden.com>
In-Reply-To: <1d7e53d3f80772a06878a87f0be637421070e2d9.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|CY8PR11MB6964:EE_
x-ms-office365-filtering-correlation-id: 7d34ae23-cb5c-402d-acbc-08de6ac799f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dlRiZFFrc3drcFgxT0ZmY0pFeTgyNmQ5MWdrWjZXWjFWb1I3MGZ0aWVVc2FJ?=
 =?utf-8?B?Z1RSd1Y4M0pzcmNKdTJHUXVIbW11bTNJUTNqc243OTA4RGFkbDhjR2RBT1BX?=
 =?utf-8?B?bklFZGYwbytQeE9sVWhwN0ExczY2QnJlSVRLanRCMncySGU4S2s0eTJCSXl6?=
 =?utf-8?B?SzgyZlNJajFuUlNkNGJkc2xYYkJPemRXVnhwbHNQRjlUR2pRUjcvVVNaMVBX?=
 =?utf-8?B?Y2QyRksrME01M2Q5b25Ddm9nczU0aE9xaXNmano0K2JzaDdGajFMbUh1ZHcy?=
 =?utf-8?B?UjM1RDB6Z0t4bWFOalR4YWJPUVNLZ0h5aUNOWE9uWXRha09RcllTNlF4cHFP?=
 =?utf-8?B?THJpODBzRGE0dElBUk04ZnJoeTlVSEJXVWxTL3JiejFVWnk1N2tIYThHQWdJ?=
 =?utf-8?B?eHlJajhUSy8yMUNGcFVBWElzLzVOenlsc3N1YUY3U3R1V1hqTDRuK2xaSzJH?=
 =?utf-8?B?Rjhtd1Vnd0srcCtidGt1NWlQQzVwdWtjY2hidEdUWi8xaU9oajU2YStOYitV?=
 =?utf-8?B?SDNyZ3E4Z3MyQ2d5clBhTFdiOEFJTHFuZXJFY09UTjE2d2g2WEhlcnQwSnh0?=
 =?utf-8?B?eTdNcGFVY3BNemUxNFNxVlV6Ulp2cUQ0aHpNWC9RK1FPaWVtOUQ1dnAvdE02?=
 =?utf-8?B?dU5keGRxaGE0amJ3MjBQOXJsYkFtU0hJWmJ6V1JBY1NaWjQ3cFdnaWIzTnE1?=
 =?utf-8?B?VHl3Q0wwK29VWk9La1l0NmNUQ1BHYWQ0YnhMSis3V0dXQmUrZTF4K1NMaHNN?=
 =?utf-8?B?QVVENUVkb1BxeHlUV1RqdGdabC8vMjBYS3ZIRUIrZExtcWRRUlRFRHY1YkQ4?=
 =?utf-8?B?TjFmam5oeHZWUUV5WXZXWmo3R01XaFc3b0oya3NqNnJ2VzJsWDVCWUgyL2Fx?=
 =?utf-8?B?cEsxQ2dkdTJ2WDgwa2ZqWnF5eU9ZNWVpWHRLUFpWVnJ0cEI1emkycHpja2hL?=
 =?utf-8?B?Mzh2MnNxWVBXMkpSMmF2bnI2WGNkUENYRytQTDVGWjFEK0h3U3pDbW43RnN2?=
 =?utf-8?B?TGdUa1pNakxqOU9sdTJxcnJEL0RWdGVQYWtEc3FhWXg3TjFIMU9jdlFBTmhS?=
 =?utf-8?B?OTFvY01lWURtYmpFMDJ4b0l6c0luUjd6MGZXMUdWYzNHd3FtWk5VenJuMDJT?=
 =?utf-8?B?UDF0S2hkMlpSejdUS1hIM3FQa0ZKZUVxMGNJRzBncm9wSk90WWFjSzVOMWJ1?=
 =?utf-8?B?ZG5kRGpjbWtrMkRPL0luREc2T2pPRzhBMWYwOUY3RWhLRE5BVG9rMG1NZEdJ?=
 =?utf-8?B?eldBM08wbGhmaE85RmJyS3R6c3RjNE9NMnFTdnYvR2k4YklxeG9WUWQ3K0Fj?=
 =?utf-8?B?SHpGbzY5QzF4MVF1OEpkR0N5Q3B6cnhtMW1UaTVJZEFoeWdOa25RempESEJO?=
 =?utf-8?B?ZzJENGZwUFQ4d2prbzhma0RQSTNzeVNqc1RnS1pQZ0kyNzFKdzdyeFIrVkxQ?=
 =?utf-8?B?K0RxT3FSeGpvaFRnc1VrTkQ1SGt2YVY2S2pUQmNyV3NaeWpyc2JUUllSaEti?=
 =?utf-8?B?ZjRkRlpqRlBYdisrd3ZRcTE3citGcmJtNitmaXlDTFA3ZjVvOSt5VDF3Wi9r?=
 =?utf-8?B?a3cvT3lKamxzUDBxeHdRUmplalVCZUlwYnZWRE1Ec3JNd1JjR2tpMWlaOUpp?=
 =?utf-8?B?SlhmOHJmK1NqZVgrUXpDM0wveUtPWFQxY2ZWOFc0ck5vQkdFM09NVk93QTky?=
 =?utf-8?B?NExhVlVyNjJpRFBGTHFsK3dwVUZvNkR1a2t3ZlpWQkw5YjBvem1yb0pTblpW?=
 =?utf-8?B?OUlITlg2TzZaQVNJRUM5L1NrME5nWVV2VVo3YysyempZb2NMS2pQZmtxS3dB?=
 =?utf-8?B?SStEZm1VYm8wVkU2eU5sTWp0Z1M1Wm9iYTdWMU1Yd0JVZGUrbGt2WG1DQ1Zv?=
 =?utf-8?B?TldsbFJqNmM1b0FmbGJzWFJBUE1tbTlIUXdWTUVTMW9HL3BRR1Vhdllmd1Bv?=
 =?utf-8?B?cThuUWxrRGdTcVRWa0VhcHBvTXdPejV6bVhJZjVVMVJDVkZoWjhBaUVMZlAx?=
 =?utf-8?B?NmxKanhwelJjeVYrLzN6ekRFS09wMkpjVDFnWWkyZDQ4ODNWTlA2dWtsSWhQ?=
 =?utf-8?B?eWUyZVVyVG1VMVYvVVRsdUxzSWVJV3kvdkErdk9iTllSQ3RxQ0xTeHhjdG5S?=
 =?utf-8?B?L2htb0dNMnpad0EyN25pT05JNS9KMndUSVo5ajY1c2hSaUsxYThzNUlGSnRm?=
 =?utf-8?Q?xXyASaR8IPYDKoyYVSPo+2Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXgxVXJiMGk0TGtMWjFHOXhXK0p6aWZ5eHV5ZzE0VmxNTGU2UktEc2FCYm9B?=
 =?utf-8?B?Q3hxQnN3ckJzT3crUlJNUXYza1Z3WXllK0VEMUNabUVGQ1c2R0RsTis1MUFm?=
 =?utf-8?B?MlJpajZKZFVFU3NvblhpQlpZemJrd2ZjZFBxVGNpQUhIakRadkppRGc1eGVM?=
 =?utf-8?B?ODcrc0pZUjJCSmM5WnRXQzlWMzV2ZlRYYmYzdlQxN2JmTElsdHVpN3EwZGxX?=
 =?utf-8?B?YUhOemMwdExWK0t0NkxCNjJpSmRFYkZvbEIrMEFYdFFINzR3eWxZZUFOWlpL?=
 =?utf-8?B?cFZBNHdQOTgyM2xyV2FjVWZCVGJqOC8raXdWTXorcURlNTcvWEZib2JHRDZN?=
 =?utf-8?B?Zmc5MmpINGJDck12MzhQUXdUdG1waEloSlhkWEpSTXNURTRzZS8vWnowQnoz?=
 =?utf-8?B?OHgzWFMrYSt5L2tPRkNmbk93RmVPRHlyaHpBNnY4cC9aMXZYV0ZwVzA0akc5?=
 =?utf-8?B?VkhHNGVUQlU5N3JvNVJoRFE3eVo5c0FoN2hVWk9RczlrQVJ3TlY3TVBpZE5n?=
 =?utf-8?B?RlRRWGR3M1AxUlBWQ3pXOGNHWXlyRytmQ3YxL3ZocFJNeGsyeDhaUUo0dGk1?=
 =?utf-8?B?bVd2eDZQWk1weGdmMERsenFNT2FlNnFMZnZFNXpsM0N1SS9pZUFNZ3dVQU80?=
 =?utf-8?B?bW1wUmRnQitHazJEODhKeUNaaEVBVWNvVEowYlIzYUl6SGhLWkhra3Y1Q3RD?=
 =?utf-8?B?YlptQTZPZzY1UGIzY1YxTGFoeFJmenIzbWlLZlZkRFlXMVNWZ1NwY1kvVFJS?=
 =?utf-8?B?Z3FoTnh0VDNlVzZyRjdJb1VNb0pWTzF0N1JRWEMySjVMS2FRUmtQeHJoT0V3?=
 =?utf-8?B?VmZ1ZkZ4Rkt2ZWpKTGQwRElSVEQ5TWh5UjIvekFUUmVwSk9tZDFMTkVhR2xH?=
 =?utf-8?B?a0RIK28wODlhb2hUM0ZQOFNmK1VaSElIMUMzS2Naa1JNLzlOcmMvbndpUWh1?=
 =?utf-8?B?dlk1WEFGWmpwVjNWR29uUnd3OTBKTEhtUmxOdEl0d1o1c3ZZNUtOUmNGYkll?=
 =?utf-8?B?YkUxMjZtdXlaNTNXcytBZEU0cytySWxka0psS1RoVXZTOHU4V0d1dGxvc3ZC?=
 =?utf-8?B?Q2VwazE2NklWZ3VRMy9yUCtJdm5HRHF4MjRIQWo0RDI2VnB6aHE2K24yRE5M?=
 =?utf-8?B?ZnlybEVPNWo5YktoRDc3dEN6UFUrMDRhZS9qVC8yL2UxRVA4ZmM4NllhaGxF?=
 =?utf-8?B?THhvbFhUR0EvWEdJYXlaeUdrQk9DZnNObUlkMWFINjlUbkNybjNpaVFyM2lY?=
 =?utf-8?B?aWNmSXNFY1U2V001SDh0WmNZOFpSRlNqOHZFeE1sekR2TUtWSjVqZEZZMlJu?=
 =?utf-8?B?OGtiQkZ6aGZMZFl2U0tzTGpKY0Q2QVF1VGlvWW1EV0RYWEpYb3dub2tJT2g5?=
 =?utf-8?B?Z0dxOFVHZWJnWkN1M1lFTUIyQTRkZHpMQ0hmZVRqOHZSZ2RTTjdwV0Q5Ymxq?=
 =?utf-8?B?anBmQUVhSUFjanFlcEJ5MFJqTnlXdGRTODkyU3RicHhmcHc0UUI0Y2NDdFlT?=
 =?utf-8?B?U1RzNXNhcG1jdk1JSVZXTTF4NVlZai9HRXVmVW51SHorWUlGSU9JMWVOQVhs?=
 =?utf-8?B?bXpWMFl4TWxQZVpKWjl6RmdObnNHOXIxZ3UyeS9UOExWZzIzYitBd1FFM0hi?=
 =?utf-8?B?emZFZXNObXErQnNZVnpGbmZJNmJsZ1gxeDF5ZWdIRXpHSTg3WkE3UU9FN0hV?=
 =?utf-8?B?RlQ5c2dCc3M2RVZqemZ4bEtMbnErQVRCOHNBb3VnNWoxejBxcm1rMU95MHYr?=
 =?utf-8?B?WjlTcGtyUGFrSVRua0Z4amdoZXRoSVJqWjVzM1pkSkZQRmllcm8zdmIveXBF?=
 =?utf-8?B?a3UwU1RqODFUZCtkM2Z2d2QrWXByR2xwRkRQbHZZR3JWU3BwQnJvRGtkVmwz?=
 =?utf-8?B?Ym9Pb2xZc3RaVVg4RDZGcFFXQTRWSGhPYnExZlkzOVVzKytXYlVFWGo3Qjdi?=
 =?utf-8?B?MkU2ZkFJLzMrZHkzN0czSzI5eStiV1B0UlFkOHhoZzFBaEVhenJVRm4yUDVY?=
 =?utf-8?B?NWpIblR4SFJKSytkNnpJZWpUUC9WNkRyaW9vZ05RQWlBRTlDNnVlTlRPVmp5?=
 =?utf-8?B?Ym1PRXhVS004d0FVTWoyT0xpd09iQVpHaHJKRFVFK2tncTRyVks5WlMzaDJl?=
 =?utf-8?B?YllHUmJvRHJkcmx6ZHF5NmErQmZ6SkovMzM5VVBYd0ozZGZ2czZ5L2VSUWhK?=
 =?utf-8?B?YTFCQ2xXaXNhOTFOcXQ5eEppaGgvcDIxYU5uUXJnWDhjZnkyWHZkcWFCZlJ0?=
 =?utf-8?B?NUJxT0NQV2gxSkY1Y3dZR1FoMnRxYUZhYk9rUkQxclM2a0dRamVsZkpaa0ZH?=
 =?utf-8?B?cm1NMVVuZE5wZjVGWVV4VUZmTTFsTEV0ZTcwWC9hNFAxb1h6QmFldz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d34ae23-cb5c-402d-acbc-08de6ac799f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 06:17:44.7056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51ebfjQvhKUw/TdPtCoWpNrrT+MjkWHZuWWvYV+VJ0yxk/wmNzWvtTdojWv6XG/mHRBWUwv+X88HymPGvy3MopcqpK5b1Bcq2gBD7rOpDTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6964
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgQ2xlbWVudCwNCg0KQ291bGQgSSB0YWtlIGl0IGFzIGEgZm9ybWFsICJSZXZpZXdlZC1ieTog
Q2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4i
IG9yIG5vdD8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+RnJvbTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbT4NCj5TdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwNi8xNF0gaW50ZWxfaW9tbXU6
IEV4cG9ydCBzb21lIGZ1bmN0aW9ucw0KPg0KPmxndG0NCj4NCj5PbiBXZWQsIDIwMjYtMDItMDQg
YXQgMjI6MTEgLTA1MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gRXhwb3J0IHNvbWUgZnVu
Y3Rpb25zIGZvciBhY2NlbCBjb2RlIHVzYWdlcy4gSW5saW5lIGZ1bmN0aW9ucyBhbmQgTUFDUk9z
DQo+PiBhcmUgbW92ZWQgdG8gaW50ZXJuYWwgaGVhZGVyIGZpbGVzLiBUaGVuIGFjY2VsIGNvZGUg
aW4gZm9sbG93aW5nIHBhdGNoZXMNCj4+IGNvdWxkIGFjY2VzcyB0aGVtLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuDQo+PFt6aGVuemhvbmcuZHVhbkBpbnRlbC5jb21dKG1h
aWx0bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pPg0KPj4gLS0tDQo+PiDCoGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4+IMKg
aHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgNDIgKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlv
bnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGlu
ZGV4IDcxY2IzYjY2MmUuLjY3NTNhMjBjYTQgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KPj4gQEAgLTYxNSw2ICs2MTUsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUm9vdEVudHJ5IFZU
RFJvb3RFbnRyeTsNCj4+IMKgI2RlZmluZSBWVERfU01fQ09OVEVYVF9FTlRSWV9SU1ZEX1ZBTDHC
oMKgwqDCoMKgIDB4ZmZmZmZmZmZmZmUwMDAwMFVMTA0KPj4gwqAjZGVmaW5lIFZURF9TTV9DT05U
RVhUX0VOVFJZX1BSRcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgxMFVMTA0KPj4NCj4+ICsvKiBj
b250ZXh0IGVudHJ5IG9wZXJhdGlvbnMgKi8NCj4+ICsjZGVmaW5lIFZURF9DRV9HRVRfUEFTSURf
RElSX1RBQkxFKGNlKSBcDQo+PiArwqDCoMKgICgoY2UpLT52YWxbMF0gJiBWVERfUEFTSURfRElS
X0JBU0VfQUREUl9NQVNLKQ0KPj4gKyNkZWZpbmUgVlREX0NFX0dFVF9QUkUoY2UpIFwNCj4+ICvC
oMKgwqAgKChjZSktPnZhbFswXSAmIFZURF9TTV9DT05URVhUX0VOVFJZX1BSRSkNCj4+ICsNCj4+
IMKgdHlwZWRlZiBzdHJ1Y3QgVlREUEFTSURDYWNoZUluZm8gew0KPj4gwqDCoMKgwqAgdWludDhf
dCB0eXBlOw0KPj4gwqDCoMKgwqAgdWludDE2X3QgZGlkOw0KPj4gQEAgLTczMyw0ICs3MzksMjkg
QEAgc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV9wZ3R0X2lzX2ZzdChWVERQQVNJREVudHJ5DQo+
KnBlKQ0KPj4gwqB7DQo+PiDCoMKgwqDCoCByZXR1cm4gKFZURF9TTV9QQVNJRF9FTlRSWV9QR1RU
KHBlKSA9PSBWVERfU01fUEFTSURfRU5UUllfRlNUKTsNCj4+IMKgfQ0KPj4gKw0KPj4gK3N0YXRp
YyBpbmxpbmUgYm9vbCB2dGRfcGRpcmVfcHJlc2VudChWVERQQVNJRERpckVudHJ5ICpwZGlyZSkN
Cj4+ICt7DQo+PiArwqDCoMKgIHJldHVybiBwZGlyZS0+dmFsICYgMTsNCj4+ICt9DQo+PiArDQo+
PiArc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV9wcmVzZW50KFZURFBBU0lERW50cnkgKnBlKQ0K
Pj4gK3sNCj4+ICvCoMKgwqAgcmV0dXJuIHBlLT52YWxbMF0gJiBWVERfUEFTSURfRU5UUllfUDsN
Cj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGlubGluZSBpbnQgdnRkX3Bhc2lkX2VudHJ5X2NvbXBh
cmUoVlREUEFTSURFbnRyeSAqcDEsIFZURFBBU0lERW50cnkNCj4qcDIpDQo+PiArew0KPj4gK8Kg
wqDCoCByZXR1cm4gbWVtY21wKHAxLCBwMiwgc2l6ZW9mKCpwMSkpOw0KPj4gK30NCj4+ICsNCj4+
ICtpbnQgdnRkX2dldF9wZGlyZV9mcm9tX3BkaXJfdGFibGUoZG1hX2FkZHJfdCBwYXNpZF9kaXJf
YmFzZSwgdWludDMyX3QgcGFzaWQsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURFBBU0lERGlyRW50cnkgKnBk
aXJlKTsNCj4+ICtpbnQgdnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVT
dGF0ZSAqcywgdWludDMyX3QgcGFzaWQsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX2FkZHJfdCBhZGRy
LCBWVERQQVNJREVudHJ5ICpwZSk7DQo+PiAraW50IHZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShJ
bnRlbElPTU1VU3RhdGUgKnMsIHVpbnQ4X3QgYnVzX251bSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50OF90IGRldmZuLCBW
VERDb250ZXh0RW50cnkgKmNlKTsNCj4+ICtpbnQgdnRkX2NlX2dldF9wYXNpZF9lbnRyeShJbnRl
bElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2UsDQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWVERQQVNJREVudHJ5ICpwZSwg
dWludDMyX3QgcGFzaWQpOw0KPj4gK1ZUREFkZHJlc3NTcGFjZSAqdnRkX2dldF9hc19ieV9zaWQo
SW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBzaWQpOw0KPj4gwqAjZW5kaWYNCj4+IGRpZmYg
LS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
IGluZGV4IDkxNmViMGFmNWEuLmFiNTJhNjg4YzUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTQyLDEy
ICs0Miw2IEBADQo+PiDCoCNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPj4gwqAjaW5j
bHVkZSAidHJhY2UuaCINCj4+DQo+PiAtLyogY29udGV4dCBlbnRyeSBvcGVyYXRpb25zICovDQo+
PiAtI2RlZmluZSBWVERfQ0VfR0VUX1BBU0lEX0RJUl9UQUJMRShjZSkgXA0KPj4gLcKgwqDCoCAo
KGNlKS0+dmFsWzBdICYgVlREX1BBU0lEX0RJUl9CQVNFX0FERFJfTUFTSykNCj4+IC0jZGVmaW5l
IFZURF9DRV9HRVRfUFJFKGNlKSBcDQo+PiAtwqDCoMKgICgoY2UpLT52YWxbMF0gJiBWVERfU01f
Q09OVEVYVF9FTlRSWV9QUkUpDQo+PiAtDQo+PiDCoC8qDQo+PiDCoCAqIFBhZ2luZyBtb2RlIGZv
ciBmaXJzdC1zdGFnZSB0cmFuc2xhdGlvbiAoVlREIHNwZWMgRmlndXJlIDktNikNCj4+IMKgICog
MDA6IDQtbGV2ZWwgcGFnaW5nLCAwMTogNS1sZXZlbCBwYWdpbmcNCj4+IEBAIC04MzEsMTggKzgy
NSwxMiBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj52dGRfcGVfdHlwZV9jaGVjayhJbnRlbElPTU1V
U3RhdGUgKnMsIFZURFBBU0lERW50cnkgKnBlKQ0KPj4gwqDCoMKgwqAgfQ0KPj4gwqB9DQo+Pg0K
Pj4gLXN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGRpcmVfcHJlc2VudChWVERQQVNJRERpckVudHJ5
ICpwZGlyZSkNCj4+IC17DQo+PiAtwqDCoMKgIHJldHVybiBwZGlyZS0+dmFsICYgMTsNCj4+IC19
DQo+PiAtDQo+PiDCoC8qKg0KPj4gwqAgKiBDYWxsZXIgb2YgdGhpcyBmdW5jdGlvbiBzaG91bGQg
Y2hlY2sgcHJlc2VudCBiaXQgaWYgd2FudHMNCj4+IMKgICogdG8gdXNlIHBkaXIgZW50cnkgZm9y
IGZ1cnRoZXIgdXNhZ2UgZXhjZXB0IGZvciBmcGQgYml0IGNoZWNrLg0KPj4gwqAgKi8NCj4+IC1z
dGF0aWMgaW50IHZ0ZF9nZXRfcGRpcmVfZnJvbV9wZGlyX3RhYmxlKGRtYV9hZGRyX3QgcGFzaWRf
ZGlyX2Jhc2UsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgcGFzaWQsDQo+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlREUEFTSUREaXJFbnRyeSAqcGRpcmUpDQo+PiAr
aW50IHZ0ZF9nZXRfcGRpcmVfZnJvbV9wZGlyX3RhYmxlKGRtYV9hZGRyX3QgcGFzaWRfZGlyX2Jh
c2UsIHVpbnQzMl90IHBhc2lkLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWVERQQVNJRERpckVudHJ5ICpwZGly
ZSkNCj4+IMKgew0KPj4gwqDCoMKgwqAgdWludDMyX3QgaW5kZXg7DQo+PiDCoMKgwqDCoCBkbWFf
YWRkcl90IGFkZHIsIGVudHJ5X3NpemU7DQo+PiBAQCAtODYwLDE1ICs4NDgsOCBAQCBzdGF0aWMg
aW50IHZ0ZF9nZXRfcGRpcmVfZnJvbV9wZGlyX3RhYmxlKGRtYV9hZGRyX3QNCj5wYXNpZF9kaXJf
YmFzZSwNCj4+IMKgwqDCoMKgIHJldHVybiAwOw0KPj4gwqB9DQo+Pg0KPj4gLXN0YXRpYyBpbmxp
bmUgYm9vbCB2dGRfcGVfcHJlc2VudChWVERQQVNJREVudHJ5ICpwZSkNCj4+IC17DQo+PiAtwqDC
oMKgIHJldHVybiBwZS0+dmFsWzBdICYgVlREX1BBU0lEX0VOVFJZX1A7DQo+PiAtfQ0KPj4gLQ0K
Pj4gLXN0YXRpYyBpbnQgdnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVT
dGF0ZSAqcywNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHBhc2lkLA0K
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX2FkZHJfdCBhZGRyLA0KPj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgVlREUEFTSURFbnRyeSAqcGUpDQo+PiAraW50IHZ0ZF9nZXRf
cGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQzMl90IHBhc2lk
LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9hZGRyX3QgYWRkciwgVlREUEFTSURFbnRyeSAqcGUpDQo+
PiDCoHsNCj4+IMKgwqDCoMKgIHVpbnQ4X3QgcGd0dDsNCj4+IMKgwqDCoMKgIHVpbnQzMl90IGlu
ZGV4Ow0KPj4gQEAgLTk1NCw4ICs5MzUsOCBAQCBzdGF0aWMgaW50DQo+dnRkX2dldF9wZV9mcm9t
X3Bhc2lkX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+IMKgwqDCoMKgIHJldHVybiAwOw0K
Pj4gwqB9DQo+Pg0KPj4gLXN0YXRpYyBpbnQgdnRkX2NlX2dldF9wYXNpZF9lbnRyeShJbnRlbElP
TU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2UsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURFBBU0lE
RW50cnkgKnBlLCB1aW50MzJfdCBwYXNpZCkNCj4+ICtpbnQgdnRkX2NlX2dldF9wYXNpZF9lbnRy
eShJbnRlbElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2UsDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWVERQQVNJREVudHJ5
ICpwZSwgdWludDMyX3QgcGFzaWQpDQo+PiDCoHsNCj4+IMKgwqDCoMKgIGRtYV9hZGRyX3QgcGFz
aWRfZGlyX2Jhc2U7DQo+Pg0KPj4gQEAgLTE1MzEsOCArMTUxMiw4IEBAIHN0YXRpYyBpbnQgdnRk
X2NlX3Bhc2lkXzBfY2hlY2soSW50ZWxJT01NVVN0YXRlICpzLA0KPlZURENvbnRleHRFbnRyeSAq
Y2UpDQo+PiDCoH0NCj4+DQo+PiDCoC8qIE1hcCBhIGRldmljZSB0byBpdHMgY29ycmVzcG9uZGlu
ZyBkb21haW4gKGNvbnRleHQtZW50cnkpICovDQo+PiAtc3RhdGljIGludCB2dGRfZGV2X3RvX2Nv
bnRleHRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50OF90IGJ1c19udW0sDQo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB1aW50OF90IGRldmZuLCBWVERDb250ZXh0RW50cnkgKmNlKQ0KPj4gK2ludCB2
dGRfZGV2X3RvX2NvbnRleHRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50OF90IGJ1c19u
dW0sDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdWludDhfdCBkZXZmbiwgVlREQ29udGV4dEVudHJ5ICpjZSkNCj4+IMKgew0KPj4g
wqDCoMKgwqAgVlREUm9vdEVudHJ5IHJlOw0KPj4gwqDCoMKgwqAgaW50IHJldF9mcjsNCj4+IEBA
IC0xODk0LDcgKzE4NzUsNyBAQCBzdGF0aWMgVlREQWRkcmVzc1NwYWNlDQo+KnZ0ZF9nZXRfYXNf
Ynlfc2lkX2FuZF9wYXNpZChJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9maW5kX2FzX2J5
X3NpZF9hbmRfcGFzaWQsICZrZXkpOw0KPj4gwqB9DQo+Pg0KPj4gLXN0YXRpYyBWVERBZGRyZXNz
U3BhY2UgKnZ0ZF9nZXRfYXNfYnlfc2lkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3Qgc2lk
KQ0KPj4gK1ZUREFkZHJlc3NTcGFjZSAqdnRkX2dldF9hc19ieV9zaWQoSW50ZWxJT01NVVN0YXRl
ICpzLCB1aW50MTZfdCBzaWQpDQo+PiDCoHsNCj4+IMKgwqDCoMKgIHJldHVybiB2dGRfZ2V0X2Fz
X2J5X3NpZF9hbmRfcGFzaWQocywgc2lkLCBQQ0lfTk9fUEFTSUQpOw0KPj4gwqB9DQo+PiBAQCAt
MzExMiwxMSArMzA5Myw2IEBAIHN0YXRpYyBpbmxpbmUgaW50DQo+dnRkX2Rldl9nZXRfcGVfZnJv
bV9wYXNpZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCj4+IMKgwqDCoMKgIHJldHVybiB2dGRf
Y2VfZ2V0X3Bhc2lkX2VudHJ5KHMsICZjZSwgcGUsIHZ0ZF9hcy0+cGFzaWQpOw0KPj4gwqB9DQo+
Pg0KPj4gLXN0YXRpYyBpbnQgdnRkX3Bhc2lkX2VudHJ5X2NvbXBhcmUoVlREUEFTSURFbnRyeSAq
cDEsIFZURFBBU0lERW50cnkgKnAyKQ0KPj4gLXsNCj4+IC3CoMKgwqAgcmV0dXJuIG1lbWNtcChw
MSwgcDIsIHNpemVvZigqcDEpKTsNCj4+IC19DQo+PiAtDQo+PiDCoC8qIFVwZGF0ZSBvciBpbnZh
bGlkYXRlIHBhc2lkIGNhY2hlIGJhc2VkIG9uIHRoZSBwYXNpZCBlbnRyeSBpbiBndWVzdCBtZW1v
cnkuDQo+Ki8NCj4+IMKgc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3N5bmNfbG9ja2VkKGdw
b2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
cG9pbnRlciB1c2VyX2RhdGEpDQo=

