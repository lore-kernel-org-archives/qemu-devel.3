Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BF9C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sZR-0000iN-9D; Tue, 08 Sep 2026 05:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x3sZP-0000iD-FH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:56:51 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x3sZN-0003YR-5e
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788861409; x=1820397409;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rjpo8Jvoy3mIQ7PCawixC/yyszzCkhZxuv3pcErDzw0=;
 b=jcXkYAGheuZi73wkwv/pjn1hB06JBnCQgs6JL5iR9xClQzEKenEm2+kF
 bYt7jBPRWxGXJYt9VneLvTC/AajAMT5zDzQgPutHgjsuWqcdWvYRP4x1R
 gqgjvzZCILM+F5cSkgWWBfhX33/UJwjoxmKtoAZwNTDzA2e+wBN4Nnxyc
 rOeqZeE5gHMuaoLyteHDVCsFV02e+eL057liaftRseONtVTcHAcw3SND7
 6bJNlud5MdhTqezUynVF4nH0kGb1Z44Y7zU+8aYo6mcR2elAs6Hd674gt
 bR5Q+93iltsyeSDg9rDt37G4ZmlXWZmTcNBOIcXafMny4RXXk8wGFFi4x Q==;
X-CSE-ConnectionGUID: ozUfTtx4RxqGsCes6W56kw==
X-CSE-MsgGUID: Ab+/ANzoSfGE4ROxNkC1Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93078312"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="93078312"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 02:56:46 -0700
X-CSE-ConnectionGUID: RPLbjniCTp63Lhui2Gd3GQ==
X-CSE-MsgGUID: JdXiwP9DSDmjWWERbWyovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="264749195"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 02:56:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:56:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 02:56:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRSq3aiS7N+qljyamZzyqT5NIMQdmK086aHU35DdtMlvH64bl+ww9/kIbnqiU6wHls+YRurIj+NwKaASfhAp3LDov8Gwklnsd1JN4YTR7rgZf4nVheL0Ewwnh3FA3+GslTtySTydG9ZM4xHlnipWX2hbxVp1SKzR2qLnrjUp00liT2RFJXpRHpONwgay41gD2CLmL2vlqLxpCwSik5/UFSAd9HcGKmFzF8DuUST5UGcHwEhZTgNqO3GmphMlkQhqosBZI1bVp2BnrpvAHb7lqmzWnf0N1IRoqb1JcadbDOl7fEROtbRUP0V2TCNBdzfDER5qQN6HqVAhsImzBRKMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjpo8Jvoy3mIQ7PCawixC/yyszzCkhZxuv3pcErDzw0=;
 b=LD89xgC0gMlefBX53zaeKpok2qHtbP9T0DIB4Ek/8pGFs4WOr3kHznuW4TZZmGfAZsK6EL+KQ2Hx1rVj2kn3CrwA1wHY4SH4RoJOcRKyDOW5DQfYXcVIuOL/sWjtIevfG77lg3FrjplYAzZPiL1gcm/1u/B7y+1dVz/CwnZD4gfrrbwTJWby1Iz3uHcQVlMClKc4w24L30ur1t/xEitGBlfItbMmg6AmzclF7k8qotlZYgPFCaVc/Dg49uic0BmTNajRCPjXSsekg41gew42GtJu4LbyD0uwK3pDhRbY9xe9lY+I+XQ/6CvKIm/aG0duAovyA/U2v4YZnTDVVHkMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by SA1PR11MB7040.namprd11.prod.outlook.com
 (2603:10b6:806:2b7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 09:56:41 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 09:56:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1] intel_iommu: Support concurrent page fault handling
 with PRI
Thread-Topic: [PATCH v1] intel_iommu: Support concurrent page fault handling
 with PRI
Thread-Index: AQHdO7Orx/6HOHEK7kiJZZLQqCFugLbER87AgAASHICAABzGAA==
Date: Tue, 8 Sep 2026 09:56:41 +0000
Message-ID: <DS4PPF93A1BBECDDCCA0C6B34349809AAD492B12@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20260903145044.2245609-1-clement.mathieu--drif@bull.com>
 <DS4PPF93A1BBECDE07BE6A9E338055C18B892B12@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <9c94e7a7ed4f84eb9bed8b6ab2c709dcdde79988.camel@bull.com>
In-Reply-To: <9c94e7a7ed4f84eb9bed8b6ab2c709dcdde79988.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|SA1PR11MB7040:EE_
x-ms-office365-filtering-correlation-id: c77bd478-e8e3-4efc-3b7c-08df0d8f7bc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|3023799007|18002099003|22082099003|56012099006|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: Qs6YOcyxH9maGFMWoTs+y+6SoNi6O3GzxISve/YqXaSK61o8txg+jkl8HZJB+Hr1SdBSMdIjT+o8tiGx2lSisktCCXNeTcJO1x5jeEPe7eMO4ZV4wzKrjP4PnLvb/CPCSbjuQHdCBKxJULqTcKRoXl2BuqPelgCud0xK1SF5fBv6zPuwAeOZV/8G9NUFQgYMUib2JiugvI/rXwTRWP1lFBIB3/0iZyZrJkO3fwUWnttV4Wcd98lxjnpPIUU+2/eWXgtykZEz50MUb9Q56cD4pnfw2SQtMRy86I6LofqRaQee54Pi1WL8sh7lZScghnvvvxg1Omxih+ErqjHupDFo4dMk0KR9cPjeQzPvQla18bxxVDb2ZkoKBloODpxJdlCqth04fnnbdySxDBxVFyL/8Z7SGU1G8hoZUZkHUDLJbgIKOimrWrHRWUIHIiPlwkW2HnJ3feBzYvhCdvHKOm6JRcNEyt6HCXUnL6JZay2QJ1MlgzDEnN0Ifl6ATTOGWKR0jKPwmq+8RFR9fTB/HSSeOiUoHjPZVxnMZQIzGFrh2fXMmuWHPOSbZvYV0afsmKbKUyBERrOodTV+owZ0pMf7TcQkme2om1sjmPYhUBTmnGUKoge71daVIXSFyS+FHXtUwdEcFMTEIeFyAmzv96BxJ+0fJ39YiAQ7+gtl97v4wZJi5JpZIfmZqMqome2HPFFddbYK1GG6jQfzf+60tw7djPNydfO1/TjyzInHrtZvryE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXh0MTBzVUlrTlRSeFp0MURZbm9oSHJybkVic25PV285YUZjNldKd2Nzbk9h?=
 =?utf-8?B?SzIwQUxkYzhWMUNldUE3bllTaEM3b1ZRY1FvR2hYeE1uZ3BiSk1ZL1I5Y3Fp?=
 =?utf-8?B?bGt1UHlxY1RVVkRnOERlOGdQTGlHU0wrQ3plYmxpbWRadjBOYkpkR0UxbnVL?=
 =?utf-8?B?RzFWcEQ2cDJYeThWbE1HcDNtMGthUWFENXViZWljR21YMFlJQ1JEVm02QmRI?=
 =?utf-8?B?QXFpQURWd1FTRjR4dy9kYTJva3dETUFFT1ZNWFR6ZFpKT0VEM1VpRjFESTBD?=
 =?utf-8?B?Z25LMVlJRUowR0Z5djJNbXUrVkZBcnplWjh6L2FqdmQ5aGxKcis0NVpLb21l?=
 =?utf-8?B?QUNYL3dxK2ZMa0xiUWlyUllHbm9WeitQUXQ4bElzNGs2MnUvNWtrb05XMlNy?=
 =?utf-8?B?UmVPcHpWbnVRQ3VIQUtPbWJGLzVBTjJ2QVVYdklYeUhaWjZ4clBDWW9tRmlK?=
 =?utf-8?B?UUJoOUxYd3JyYWdWYldRNmVaOGcrdVo2NEU0VEh6cklEMmNhRGZoWm43SEhJ?=
 =?utf-8?B?SkVXc1U2dkdqUzJjTDdJTkVmbnVRcFZ6ZEJ2WGEreU9yR1k4eEhmNUFmSzRs?=
 =?utf-8?B?bGFQMkNBayt0QUJZYVFKNjJscmV0dzRKMEtWZ1pUVkZROHhKTklsYUdLMmhV?=
 =?utf-8?B?VDd0M0xzRktMdXY1L3RoanovVzFxdVFiU0YxTUsxdExoS1pQTU92SDhVaENr?=
 =?utf-8?B?UUVOaWxobTBybzJHamtkMEZSb2NIRjBwNndUNFRENU4wS08wWGI1ZzlCRGE5?=
 =?utf-8?B?Tyt4aC9USmpkbktRLy85RENNdm9vZUZSZHUzQk1hSERCYy8wbEZTVjRsbDFa?=
 =?utf-8?B?QkFXcmQrUUlJWDJ5U2c1V1pBcjgyRlNIQSt1cVViQW1Id2UxeGNjemxlT1Ex?=
 =?utf-8?B?dHdiclFqZHV3Qi9KcHRtaW9BeGpyQVVjMFprMVFhMDNzS3RoTFF1U1kvRXNJ?=
 =?utf-8?B?ZVR6akZSZHNkRy9FQ1N2M2ZteWNnWCtZcUdUM2huOVYrZ3FUR3czQkFFQjI5?=
 =?utf-8?B?Uk1PcVp6bHJnNDVsME84L0ppMjF6YXhNVjJ4dEE1VHpGamgrQ0h6eUdNc0RM?=
 =?utf-8?B?QlVQZEFUSjl0cEpQMnN4ZkRUV2M1K2JRV3A1TGg1TEZaOTlpMEtSakZKUzBB?=
 =?utf-8?B?RGJmc1RrbGxwSzZtZUVZYys1b2NmYXFzUVYvNHVGTlNyTWx5NGFFU094SVZ0?=
 =?utf-8?B?dVZHVllXSzE1K2E5b2pqSnNPZmc3OTdPdU8yQWQvRjdBQWRHZUtKNlNPdENj?=
 =?utf-8?B?L09mZmsza3F5MTVpK01TTVZESjArUkVkamVJNERWLzlVTktpWGNVRS85MDRN?=
 =?utf-8?B?Tlg3OEVVK1B2ZFA3dGpLU2g4WFBDVTJLZGZBaEFLbFdjYUY3T045YVE5dStH?=
 =?utf-8?B?azNqa1MzQ2NQOEkyWVoyWHNROVdycjRmTktaWDVIdWhlVHRiM1VwY2lxK0ZV?=
 =?utf-8?B?QUNnVFF1RFQ4L1FMRTR0aGE2d05RVS9FQ1ZVL0VucEpRbmE4KzhpWGJUclVG?=
 =?utf-8?B?NXhCQ2dsU01pc0RFV0pSc2s3VlMyb0Y0U1hkTEpTTHg0L0JrendtajhUcU4y?=
 =?utf-8?B?ZE9BU1BOSHpJQlNDSEx5OFNxTXdUNk1pOW1vMCtWcWhWYjVNbkg0TTJhcHhR?=
 =?utf-8?B?N1pvU09tUm95Ynh5ZG1BN0pEamQxelBRZ0NlYnBRaEtDVHl4MHNreS9FQXcr?=
 =?utf-8?B?QnJLdWpROHBsTXJTWktnaGxEYUFrMG9yWHJrOVNPM0lSQjR3dEhhdzd2SHQ2?=
 =?utf-8?B?Vzh4d0ZrWEs1TVZXVitObXcvMkZkRzJXQlZnSHNVUUh4eThjcEZYWUFhLzFZ?=
 =?utf-8?B?clpJMzNXZjl0UzRrcWgzN2RRaHpOTkVlNWxqNVFnM3pFbkVQdDMwZ2lGM0hY?=
 =?utf-8?B?UkQ2cFpNN01zS3FOcGtCNjJ0Z1JsZEpiMmcwdnJiWUh2V0pHbHpLNVNqU3BM?=
 =?utf-8?B?RDVCaTNNVU9UclJHK3NsWkc1OE01TTRkN3JPVDA4NGcvNk1naTRwcTAyeTBn?=
 =?utf-8?B?cnIvOG92WnB2bEhaRW9EbVEvQk9mVnN3OGdJMlFzdkZRK0YzbGJsMVZaUzU5?=
 =?utf-8?B?ZGZBLzhiMDBKRk9COWMrdGduL3U2bFFVcjcyUWRqRThpblhHNDFuZkhJMnp0?=
 =?utf-8?B?aXZ1T3ByY0Z0Z0NVNElYKyticXJxZGFKOXdhZVVYNFgrNTU4bXhlV1BJZHdz?=
 =?utf-8?B?MXE2UlE4YncxTENPQkN1ak9weTFic3NSWkwwaGVrV1JtRkVyRzJROTZpbXRU?=
 =?utf-8?B?aUloVXlFL2tFWlFKYlhUM1pvdEpNdGRqOC9lNWZteFNOaWwxWUpYYk5oZC9Q?=
 =?utf-8?B?SHJxeVR1aXVESVFjYlR4UC9kS0YvbGRQb3RMS0V4NitGeWlCQXN6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: stL5hkRdXolts090AFol5NiJZ46ZKemsZnL0XlzGGLfFOX15mLtRWh6sDKGaTbWIl/TER1JyWrUPDntbrGDpRJ8yyT3BDj7MCVPBWLIJ5N0Mj+s8HQ33dD7q6YeQcoU3ozArn3X18uqw5oiBC/MpmPGCKF++bIDE6b65DnewkMODOn+7G+xJjMlK2hncPPleJ527zaipxjZ1d3gV0QnQFGcJDqL1zPStL5dHlw0XlR1DqQLI5qhbTWRWxcgW0WWT4EcSUg9bDSNfCPMI7u4WjOrS6yHc6iS75cQLWTUCgidEmEK/aqNQG611EWWaWUdSND5FmAj0KTU3moBUnCk93g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77bd478-e8e3-4efc-3b7c-08df0d8f7bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 09:56:41.7999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHjH5HPUm7MQ666URPbJxtsyMNa/vjwGBnrlJKqTOJssCekUSeBKzQWje5t4KKlY0CzxjebnnteIu68yitrdl9YjKDHJEjoCAog5YhBTN5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsw6ltZW50IE1BVEhJRVUt
LURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBpbnRlbF9pb21tdTogU3VwcG9ydCBjb25jdXJyZW50IHBhZ2UgZmF1bHQgaGFuZGxp
bmcgd2l0aA0KPlBSSQ0KPg0KPg0KPk9uIFR1ZSwgMjAyNi0wOS0wOCBhdCAwNzowMSArMDAwMCwg
RHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5v
dCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbA0KPmNv
bWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+Pg0KPj4NCj4+DQo+PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+IEZyb206
IENsw6ltZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLQ0KPmRyaWZAYnVsbC5j
b21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPj4gPiBTdWJqZWN0
OiBbUEFUQ0ggdjFdIGludGVsX2lvbW11OiBTdXBwb3J0IGNvbmN1cnJlbnQgcGFnZSBmYXVsdCBo
YW5kbGluZyB3aXRoDQo+UFJJDQo+PiA+DQo+PiA+IFBSUSBzbG90IGFsbG9jYXRpb24gbXVzdCBi
ZSB0aHJlYWQgc2FmZSB0byBhdm9pZCBwb3N0aW5nIG11bHRpcGxlDQo+PiA+IGNvbW1hbmRzIGlu
IHRoZSBzYW1lIHNsb3Qgc28gd2UgdGFrZSBhIGxvY2sgaW4gdnRkX3ByaV9yZXF1ZXN0X3BhZ2Uu
DQo+PiA+DQo+PiA+IFRoaXMgYWxsb3dzIG11bHRpcGxlIGRldmljZXMgdG8gY2FsbCB0aGUgcGFn
ZSByZXF1ZXN0IGludGVyZmFjZQ0KPj4gPiBvZiB0aGUgc2FtZSBpb21tdSBpbnN0YW5jZS4NCj4+
DQo+Pg0KPj4gQXJlbid0IHRoZXNlIGRldmljZXMnIGVtdWxhdGlvbnMgc2VyaWFsaXplZCBieSBC
UUw/DQo+Pg0KPg0KPkhpLA0KPg0KPk5vdCByZWFsbHksIGVtdWxhdGVkIGRldmljZXMgY2FsbGlu
ZyB0aGUgUFJJIGludGVyZmFjZQ0KPmFyZSBkaXNjb3VyYWdlZCBmcm9tIHRha2luZyB0aGUgQlFM
IHRvIGF2b2lkIGRlYWRsb2Nrcy4NCj5BIGRldmljZSdzIERNQSBtb2R1bGUgaXMgbGlrZWx5IHRv
IGhhdmUgYW4gaW50ZXJuYWwgbG9jay4NCj5UaGUgZm9sbG93aW5nIGNvbmN1cnJlbnQgcGF0aHMg
Y2FuIGxlYWQgdG8gZGVhZGxvY2tzOg0KPg0KPi0gRE1BIGxvY2sgLT4gLi4uIGludGVybmFsIGxv
Z2ljIC0+IEJRTCBsb2NrICsgUFJJIHJlcXVlc3QNCg0KSSBzZWUgQlFMIGlzIHRha2VuIGluIHBy
ZXBhcmVfbW1pb19hY2Nlc3MoKSwgaXNuJ3QgRE1BIGxvY2sgdGFrZW4NCmFmdGVyIGNhbGxpbmcg
cHJlcGFyZV9tbWlvX2FjY2VzcygpPw0KDQo+LSBQUkkgcmVzcG9uc2UgLT4gTU1JTyB3aXRoIEJR
TCBpbiBWVC1kIC0+IFBSSSBub3RpZmllciAtPiBETUEgbG9jaw0KPg0KPkRNQSBsb2NrIGFuZCBC
UUwgdGFrZW4gaW4gcmV2ZXJzZSBvcmRlci4NCg0KDQo=

