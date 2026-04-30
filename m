Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAF4FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGP-000425-Cv; Thu, 30 Apr 2026 10:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wIRRs-0003mR-M7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:29:00 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wIRRq-00019U-6i
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777555738; x=1809091738;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dnRsJIo+YU6PRtTsUJUvDvwzQzANtwVeHqp6WyJldHo=;
 b=npBWj0ajtYot/Mc47J1zLO7KOP6OR+COd031uZJ/cfOnCw4SdwxOKwLR
 780/jSfeGG6721FSoW1vUTHfNDafppahGmDbx2Qjl4dmIjsGJU/qnHyz9
 CpGR8/i3gkwoYQ+pd813qZvf+8mdvGzKcfTRGs50lJgu58LZd8Y8ZSBAY
 u2Yng92Ld9++/2AJrSHsC2QMoV7FzuHYYfPbY65OEt1E9EpxP1S01Rz1g
 KjyvjMMMypUPcdrc7hM9ZpdttvkTvUsuFTQGpxzVT+rJRH8nQoKSVsU4z
 11ibqJMiX7KMo/sNbxVHZBdsZ8OQi466wSuJy9pJUuyl6gq7g1uhsepUc Q==;
X-CSE-ConnectionGUID: 6FLkDeAlQiauLfVaxeIRfw==
X-CSE-MsgGUID: A2MrjYSwQBebFYlT0B/wFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78694866"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78694866"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 06:28:54 -0700
X-CSE-ConnectionGUID: jJ1TSySZRI+9kn0K24R42g==
X-CSE-MsgGUID: O4tNqkcZQT6rR/HLB7YHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="229976039"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 06:28:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 06:28:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 06:28:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 06:28:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUfo/ltvyNdv2RLpmY+GwI4x0XyVV+jWRQTili6pNNEUq38kasfIHfE6+dlhlT1Ifk+gaVbyK5WiPx05UGv5+Xq/+Q7SsL4tycNHUAyFefrkQNMgk4jWfwTnUlbutuUTMW29zGHV2amlAPd7RQ+I0kYItlz9KSrZIT2+LBeW/FHlaq0yMFTc1uDgbouG8nkBElCywYxkfyalppK3SEJlNMNy5cj7MnGtISovvNt3Xu3zhTWdr13FuPZ5+30whdIfvqibLHKfYEBYJPgBgoJZp4RqcqmNbjvJyq6PvO08fk3QNcxqwPS944nlCvS4WMqX9Bj4Q6j12w2BuJpv+/n+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnRsJIo+YU6PRtTsUJUvDvwzQzANtwVeHqp6WyJldHo=;
 b=ars09tZLarU8rXEa7gRXnkofdmQr9OCdimkQ6szXKa+jR3YqFcYcIN9J4xlhFSwmcPAoq95QUj2BZxLpyLAMTjiIB955ihM+s4UVefumt9EIHEQoywyk7tPxCqRW2Jn/r61dHHVol71ytg42Hpr0IQtsFvALzAJo3Gcq6Ly4GwKHw7XpJrDz/bU7CURXUyRf+8rSxwbNZp2UaVCnmbTZVpB5Ru+NfmneSEUAdG+Vnnq/00tsgRxqDBzbLCRWWP6/6LpzBuhiuulNOTAODmRg08wKsV4Omaweax9aclw2nL4kESpPu/Yyi+QUMOMZIwytmjTy4uKqEkObUNWglYEuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LV3PR11MB8743.namprd11.prod.outlook.com (2603:10b6:408:20e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Thu, 30 Apr
 2026 13:28:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:28:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v4 01/15] vfio/iommufd: Extend attach/detach_hwpt callback
 implementations with pasid
Thread-Topic: [PATCH v4 01/15] vfio/iommufd: Extend attach/detach_hwpt
 callback implementations with pasid
Thread-Index: AQHc2HDq66Tr6YcQeU6/xK+m5NkLXrX3iZEAgAAPoaA=
Date: Thu, 30 Apr 2026 13:28:43 +0000
Message-ID: <IA3PR11MB9136AFFC4A138756ACDA5E7692352@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-2-zhenzhong.duan@intel.com>
 <CH3PR12MB75481F8138FE8727DEAF0213AB352@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75481F8138FE8727DEAF0213AB352@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LV3PR11MB8743:EE_
x-ms-office365-filtering-correlation-id: 7c72e40d-f25f-4bc1-16ec-08dea6bc66b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: /9KrH0KIUKSjEzNZokjHGdnAXDq/HhWiX1HZSqslLLCOcRtfecqbxXG3Jt4K8G6vlIgLXG8q5d4ijDHkFhK5C1YVszzPYnNqXfZ2syeAgSn6w7zXD/XoKrnHGGbigbe9icA13rt5XMMLyII3x35KGtF8z6BGuf/HJ2ggyEY5/nQtpTsIqL824upR4HGrWKQQT/R/jsn+E9AGXtzyH4GnKcRdqI/uq68VNnvxitnIMOEjI/kvBqELDlat9eq+9P7ghTrKe1twcxxvcmDofxjFw1BxGH+HBM7Oexlx/MZ4s5kfh1FU/pj5NRLeCUzO9OlbxVOHK84NjV7TzTzPhyZ57qONuAvkP9NP8Jll8abYz7Tri9WH71fhOFAn+LpgGsTXt8o2awHYDRojbKb5Y2Vnx8gokHfw40CepurRf2cO6UwWN4jKb7sppuiqN0tUwbn+SkVvB772fkI70LhLrJ/bKnERaai8oHZ2eO6FZEoG8k6pcFjgiExbsG9fe38TKkUhnyL7Fi1Ha1iBe441sW1V+dt6Eo0lcvTHI4tCDbD7Xf96Jg/EuxYIotl8Spb+2a4uQ8diJDuLUB+rtmWVY5gjCh+OdXnimmkWdCsN5r7wl/cGX6XGR7Q4E7oze8TBFPGSGYoGrZ/hCGnFbA+NzZcEha8q73qfuWehf7pCzqtFzzG2KzMfSo77rciRagTKpxNP8elAY6+8KPhrFV42IaqnLs6mz7cXBQhZykl9L/CPtgySGoovFM1t/yqyKqzK8lu5HmXB6bsshvHruLoKFffUTkt32Gxs768qd65LL6cw5a0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWZWcmhZYndibzVwOWNiSEZZcW83eWg2UjZoOGU0bWFtNm5xdHhNSlhEdm9s?=
 =?utf-8?B?M1Q2ckR1b1pPNUU2dVY4c1RIMXhYay91dGV3VjZENE0wZUxQbVJvamR0QWVx?=
 =?utf-8?B?Zi9NWEJublMvRDlOeG9JSW9hZHNQdXdwRDFHMXRJc3VFS1c5QnlHbUhoWVBs?=
 =?utf-8?B?SlF3eCtnWStEbHNWNmRSRmVlUThieUdxZXFwTEtnc2swYUdxb0xMblBTdVFS?=
 =?utf-8?B?YVBURzJ5MW55QVkrZlJuUmxJRW1LSkRtRUFZNzEzMDFFcmFRV09xSTlFM3p0?=
 =?utf-8?B?UXVFSTRBcVNxQWR2dHh5SDJwdlFlelZ4ckxHcUMvekFIK1U4WTlFSVd0Q2Ju?=
 =?utf-8?B?ZXNSWjYwbU1GWmxMZ04wOStkMno0bStpV21MSlE5T1lnY0hORnlqM0MxM2xI?=
 =?utf-8?B?enpzRFFJZ0VwVEM1MjlRbEhDQ3hrWGdKMTVmVS9heDNSc3NpZVplL3FnaUNk?=
 =?utf-8?B?YUVQaWtvb2xEbFhZamxCTU42SG9oOFFVTlNuR2VuclZiZHg5RjNkdVNTSU9D?=
 =?utf-8?B?ZUthMitSZ0tNWG55SElCbnAyNWp5RW5idWZvb3MvSUh6elUrRUZXdlo5OFhI?=
 =?utf-8?B?eElGSnFJTy9nTUMrdkRyMXlNTms4bFhEMjNPcWVzSzU5UWdvTkF5TEtMaTBr?=
 =?utf-8?B?WVVMckxFU21xNWlaYnRlSEd3QzJrUWRWWW5vTjRoK0pHaXlaZVVsZVROc2tr?=
 =?utf-8?B?bXR1WjdOYWtxV0V6R1VONzhTWE1Ba1VvenR0WFVpa0pRT0dHL3BrdjgvQXF6?=
 =?utf-8?B?eTdDNytCOWFSL2p1SERpZnk1RGJnK3BYVGhlM1U4ZzdveGM1N1lUMGhCdmZv?=
 =?utf-8?B?cFJieTY4OUNjU0EvcWhzZmFoaC93U1M3Q1RkelRqMFo4WE9MOXhkNFhiYkJ6?=
 =?utf-8?B?aTYwQ21oYUxHblVKb2QralZIU0ZMaU9HMjZOai8zSm9HOHA1cmZ2MDA2eHRU?=
 =?utf-8?B?Q2twSnBQMWdKL2JZcWVhQTI1c2tibElKNlNEczI4L1E1Q0dDcG5QY0hRbjBu?=
 =?utf-8?B?aCtCMEs5RmN3MU9qTUp0ekxyRURGZVd5QitybkZOQUZoOEVyY3FYT29pUTE5?=
 =?utf-8?B?Q2pjN0lPY3AxeTVtMGdJczFpakRhbk1aT1dScmJXbEVaR2NWdFpud1RlVmU5?=
 =?utf-8?B?UGZRSURKNWdQc0g4OEY5VGJML2pOc2VXZUVKdEpERHA1S09nUDR1MG1SaVhH?=
 =?utf-8?B?eHlXWTlMZjZYL20xeGNYV0hBYXlOaThWRE5qdWxFayt1UUdsSzRGclhaS01q?=
 =?utf-8?B?QVpjMGxpRHk1ZXZ5aTlUMUt5SUFNTDcwbzEyaEFtU2N5cmptMHpqUllSTVpU?=
 =?utf-8?B?THUzMm16MVJlKzZlSTZETmJYb0s4eHJFSmVFV2FDYk5EWEJWNlRVTjNteWxi?=
 =?utf-8?B?YXFnUUVrbi91QVB0S3RlbXhuTXkyNnVYVXpJZmxBUklyTjNDOEVTcGdRYm94?=
 =?utf-8?B?VlJXMnV6bnJkWFE4aGsyblJvNG56RzZrUzBBL080NGtEbkhvYlR2QkdTR2pG?=
 =?utf-8?B?MUNMcmNZK2tRdnFZT1lFck1QLzhQSW84RDRTWTg1d0VURVByYW1UL252MGZX?=
 =?utf-8?B?MEMyaG5wUVAyS3Y2d3BNbmsybWEyeGRVOUJra3I0UGRkSjIrQzQyek5XVm8v?=
 =?utf-8?B?NUNqZ25ld04xSzFOa0JDcWdJNXhpQWZna0lpOHBVTDRaUnI4NVdDUVNtWTBs?=
 =?utf-8?B?UTdWdTM2RmpUaUg5dzZTZ2NReHVxdGxPMG9IenVXSktlNE02KzZrc1F3T2Zl?=
 =?utf-8?B?M2xMSGZzRmdYbXVjVGh5SkZZS05BcE5oZFhVV2liZWdVK1VCN0RjMWRoa01G?=
 =?utf-8?B?aGtwNnRrdGVuajExQlhaQlZXWnZBK2dtd0MyK1FjTDByTFZoL2k5akk5Ni9y?=
 =?utf-8?B?RXpzWFdSNWRPbVUyRnMxdGNzeTFoTW0rTnp2WHM2YlVkNk53U2F4YjAzN2Zt?=
 =?utf-8?B?ay9QUDBKWXpkRUpsR0p4Zjg1enJZYTVwRWVaamhGM2tDNFhTMjNBaFRTTzdX?=
 =?utf-8?B?eTI3NVdlTHNYQUhQQjB5TWdvRlNiTkphT1ZXeGtVVHByekFORG95Q1BDbTNm?=
 =?utf-8?B?YzFFWkZURkFDR0tSK3VsTVVVOEZnTjNTeE1malZ1dGE0SUgwUm1CZGlhbDV1?=
 =?utf-8?B?NkhXbjd3VU1DR1g0UTZGR04vL3ZwSHRqRHFIUVF5QWIyZ1Z1SUJHQytRTVJY?=
 =?utf-8?B?bW5tR3BSdVZoai9xZTIrOUJ4WmNydW5Scmlic3RsRVNraWRNYXZmMGZBRVRI?=
 =?utf-8?B?QU94NDV1MVlaK0J1Q1ErTzNNRlpYRHM4WHVsdWViOEFYdjVIYzNyTWpOQ09G?=
 =?utf-8?B?dEZ4MTFCeGN5Rjg4VExWaVdMZHFWN2pCc2FMOWZBVHEzaldrWkVjQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZHj9vJqSCPIzFvlRP8Qjd2oOgJa5bdnKAk28xWs/szispVEWPFyqkqLi1yPn05t9ds1zI2TJkVy0h5fD6w6JoREl+fQRPH+bJYC2uJwC076fMYg2065OmdpaOVggz6h10hsaBQy7y+stmPmicbgXuOUHrb4SMMuHZpL33Be61ulLoLz9JtCwfMTizndVqafGEepXJqCltMHD6LMP0pdGBz7wlZWSv6CH3fxNeXMH98peEDWvz1u+w1CsLtcapuAAlHyj5H1whPSSbGBrOMta5jx4JiwKgRZrNmpJul1mK0YjN6WcdvII3e0e4JKyvlO2XHWVeTloFl3i+iECzkhyGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c72e40d-f25f-4bc1-16ec-08dea6bc66b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 13:28:43.9972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzcBqN9CQQu2nCIg3crBoxTGTvG8sNdcIF7MM1GOqvMqEYMkByNXcKUkgEEWSVHV5Lyx5iy1spQHXmOrDv2HG8sPG251EM0EtGoZKXcABM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8743
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
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

Pj4gIGlvbW11ZmRfY2Rldl9nZXRmZChjb25zdCBjaGFyICpkZXYsIGludCBkZXZmZCkgIiAlcyAo
ZmQ9JWQpIg0KPj4gLWlvbW11ZmRfY2Rldl9hdHRhY2hfaW9hc19od3B0KGludCBpb21tdWZkLCBj
b25zdCBjaGFyICpuYW1lLCBpbnQgZGV2ZmQsDQo+PiBpbnQgaWQpICIgW2lvbW11ZmQ9JWRdIFN1
Y2Nlc3NmdWxseSBhdHRhY2hlZCBkZXZpY2UgJXMgKCVkKSB0byBpZD0lZCINCj4+IC1pb21tdWZk
X2NkZXZfZGV0YWNoX2lvYXNfaHdwdChpbnQgaW9tbXVmZCwgY29uc3QgY2hhciAqbmFtZSkgIg0K
Pj4gW2lvbW11ZmQ9JWRdIFN1Y2Nlc3NmdWxseSBkZXRhY2hlZCAlcyINCj4+ICtpb21tdWZkX2Nk
ZXZfcGFzaWRfYXR0YWNoX2lvYXNfaHdwdChpbnQgaW9tbXVmZCwgY29uc3QgY2hhciAqbmFtZSwg
aW50DQo+PiBkZXZmZCwgdWludDMyX3QgcGFzaWQsIGludCBpZCkgIiBbaW9tbXVmZD0lZF0gU3Vj
Y2Vzc2Z1bGx5IGF0dGFjaGVkIGRldmljZSAlcw0KPj4gKCVkKSBwYXNpZCAlZCB0byBpZD0lZCIN
Cj4+ICtpb21tdWZkX2NkZXZfcGFzaWRfZGV0YWNoX2lvYXNfaHdwdChpbnQgaW9tbXVmZCwgY29u
c3QgY2hhciAqbmFtZSwNCj4+IHVpbnQzMl90IHBhc2lkKSAiIFtpb21tdWZkPSVkXSBTdWNjZXNz
ZnVsbHkgZGV0YWNoZWQgJXMgcGFzaWQgJWQiDQo+DQo+Tml0OiBwYXNpZCBpcyB1aW50MzJfdCwg
JXUgaXMgYmV0dGVyLg0KDQpXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+UmV2
aWV3ZWQtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPg0K
PlRoYW5rcywNCj5TaGFtZWVyDQo=

