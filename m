Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4CEC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHh8S-0007K3-IT; Thu, 13 Jun 2024 05:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHh8Q-0007Fa-F8; Thu, 13 Jun 2024 05:52:46 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHh8N-0002YO-To; Thu, 13 Jun 2024 05:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718272364; x=1749808364;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MYHfeemcKBR47XRIb5fglGGn5VV2bGI00+roc2ypC0g=;
 b=ldiEimLuKxQWMlgAwhT1z29lxbhcsFAaM/W+zWx4ww2VkmgrQJme85Ks
 QnICKLK525pKBwUs5+z74rP9J2vCrsrvvio8txcCg1M4Vw8TnmwOW/lKR
 AfOu1ZaLaPUjcXCJ4tmE4u7PyaxAl8FGN7418vHjrKDImxEwtdn3cgqSl
 zJsp+ylAvSyr0Ox6RLPJ/TuvZU4rpYE3mOiPUWpY2jCRti/dgiTLOF4av
 6cAPfTOa7NTMYd230olNX1s/K60Hoqfqnwu/Lqn6loJwfWmS7lE0YMwrv
 enK+8mTxMZZ3pSK99ptUiTn2SEqiCjLvtXQNwFwT7EMaSNf5dy+HKFYWt A==;
X-CSE-ConnectionGUID: QlFC5Pf2QICzW8fL/PXoYA==
X-CSE-MsgGUID: NxFaXp/SSNSyVSY2TqVLeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25659943"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="25659943"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 02:52:41 -0700
X-CSE-ConnectionGUID: hDThxXiqSEutUt5tH95Bug==
X-CSE-MsgGUID: patvUmuNTcCtH3UHYq8ciw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="44469945"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 02:52:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:52:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 02:52:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 02:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4UvpCwL2FCPRRj4EETZSU7Y37bb/xU3VEgQoF9dRsWcea9pZvcrHwW/K2vDWRmVW+w4jDIZUnCdhgO2CdizHm7TQKegSN9/T1Yd35MQx2M3QqrkO6wpt+Yiekk+g3DNOmjq/X/Z8uWPiBMFmDqKzEWlIFb0+N2Xl84MnSuSGVM/W8pZwLNLn1RBdzx0dtrYS2sEdhMDcwQtFI3CXiqI4bOQUURo1nBcYX6Wke+o4HLMM68LiMNMZb7R2bmZjqscXfHZXuCt82J3jZuaC0KYYGKuqBtO+OEoiEJaLlfOxyTyH0eMSrp0z2Zplk8p5xZ94Co9cCZlg8i07sdCTxFmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYHfeemcKBR47XRIb5fglGGn5VV2bGI00+roc2ypC0g=;
 b=N9DsLJ915sXrH9PROmwZp4fvP9RBJlAqGGDLjzgk/yGpaKCnmpKBNg8XIm034TXN4ZDi2We0gXc0FUrAmABxlCWCKjQNP8AKM1scev3kiv80KQ5I4EWM79klt23f0vkQ9u5HELrhORqub+RLmyeZmOKSHS1TWBSvoyafRq0U7QA6DvdIpsSJ8Yun3HIRSOeQ4euRC8mVjBGqNv1hzNZ3uDwA2HJK2oufe70v4zXQrwqMXHk9rm/U6GsEY7rr857yxyiie/VPKEy6LpQQ/GzlZz63Kv/RYyd7N851nyI0jJB0oZ4tViWCcL5MilwflzWuTXQ+KEOOJMU1TIHgzCVcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 09:52:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 09:52:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [RFC v2 4/7] virtio-iommu: Compute host reserved regions
Thread-Topic: [RFC v2 4/7] virtio-iommu: Compute host reserved regions
Thread-Index: AQHauOiYnfHCpfKY3EO+0RQTvgcaNrHB6JrggAOGJACAAAuwgA==
Date: Thu, 13 Jun 2024 09:52:36 +0000
Message-ID: <SJ0PR11MB674431216B76FB9F85D0864792C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-5-eric.auger@redhat.com>
 <SJ0PR11MB674461B49A34599D0166D74E92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ec20948e-16de-48e6-be8b-dffa9395bb8a@redhat.com>
In-Reply-To: <ec20948e-16de-48e6-be8b-dffa9395bb8a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5190:EE_
x-ms-office365-filtering-correlation-id: 0073b931-f645-44ec-186f-08dc8b8e8e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230034|376008|1800799018|366010|7416008|921014|38070700012; 
x-microsoft-antispam-message-info: =?utf-8?B?bWFjLyt1T3ByN3RoUjdVVXl5K0tpLzR0YkQvZFFJd1k4djkyYVhZTXZWYkdt?=
 =?utf-8?B?dWszMk0xbTF0bndkR2pqRDNGVVE5YmxOdUlQUmRxMVNjdmhFMnlqZE9hZEd0?=
 =?utf-8?B?VnNVenZhbU14bUhKR2t4Z0NRczRvVjZsamRtSCtQbzY3QUdLWTY5bEdJZW41?=
 =?utf-8?B?Y2tKNzJPbmFFeGRGeDJ5TDh5K0ppNWRTRGxWaS9sZjMzZktOUkgrVmhzbmht?=
 =?utf-8?B?czNFRXBoQTZDQkRoeDBiRndyM0VkZkVaK04xWWs3d2ltdk1EWmN3aDRENC8v?=
 =?utf-8?B?b0xUU2QvTVZnRmJYTEF2NzNRVG5wTHZnaCtMK1grWUVZM0UxSGpMV3ZFcnAv?=
 =?utf-8?B?RGc0b1NIZWxycnhxa0wyb1UvMUlscWFWOEJDUEVYSGFweXZRNzhpckFvU3ND?=
 =?utf-8?B?THhZTHZiWnliT0Izb3BJaFExSUJqclpvcXRJWVpzQjh1ekFjc0J5ZDBlc2M2?=
 =?utf-8?B?cXpkcFFLKysrT3E4cVM4RmVubWtDaDlvYU1UQU9CYVM4b0RqdmE4OWE0UmtG?=
 =?utf-8?B?RFVZOUY2NGtPaWVRbUFQb2p2U0grR2RVbVBwTnIyMnlwR1g5b20zWDVwZDJt?=
 =?utf-8?B?Q1pXcGdMaXhtMnJ5aGpFVXNKZTZHdmQwNmIrTEFrVHJhR1BKZzFObm1jdURw?=
 =?utf-8?B?bEM3K1h2Z1hLT3lXbFlOS2dsem4rc2Jta081dHllK1lXQ3NoZUtZZkNwZGo0?=
 =?utf-8?B?UTdKSlVkNnFhZVVMUHhMdWVVanVveTBRNXAzbit1aU1KRGc1WWt2MzlXN2hl?=
 =?utf-8?B?NDBmU1lxL2xrcUM3UlU0TEZvQ2RtVjFHTVRRb0xieHJTTEZ1cnhDaW5wekR2?=
 =?utf-8?B?RU9mMHl4NC9oTnBNMHdGQVM5SkhDMmt6WlNDbnhIZy9ubk1EYk5BT0JlTkxj?=
 =?utf-8?B?cC9vQk1hV242WURsTjY3VU83MnI3b2pQQ0FmeTVTcjliUWdUQkU5RS94b0FK?=
 =?utf-8?B?UFRDVnlYODRQOXd5RjV0VStZcDY1dVdUWHlwNnEwTmZOc2JuMzJVSkdYR2JD?=
 =?utf-8?B?Tit0RDlIT3I4ajVRbVBNRmluTE9UTGd0aTBaZUlCRUtJNUwrMU9LMjBnN051?=
 =?utf-8?B?V25ObzJ0MEpGaGxHSWZETUE5MlpOdTN3bG5rZ0VCNGtWajlLKzBSdGt3MlQy?=
 =?utf-8?B?TVdESXA2OStpL0NzYlFlMzRBcUZxVml3S0lzcDNOb1Y0NEdkbmpPNjJHekxX?=
 =?utf-8?B?K2VpY0NCQWVja0xOM0FpQUEzZVJpeVlxSWVCYys5WTcydWcxS3RLTDVleGtj?=
 =?utf-8?B?Y1pwM2xtcDVrSWN0dmE0TXZWak1KS1VjSzQ3dHZZeEROT3d3cDB0M0tWRG1J?=
 =?utf-8?B?d1JJdTYyNi9BVHlEdDE3alhhOGNod3B1NitVVE01WlN2MTBGUk90ajk1RFU4?=
 =?utf-8?B?b2tYSnZ1YUU4ZlY2eGl4WUVBK1BocFJFVXlFYzZFWlFXMGZyUWpVYTVlWTRG?=
 =?utf-8?B?cDluODFOZEdDdWhMeWtIVkhwbk4wWmdyVnhrWGxJNFBQU2hkN2NEakYzMW1y?=
 =?utf-8?B?QUtKcFVjZUN2M0dhek40NXZvdS9WR1NuSkNRNXp3MzkxV3FOYXFoUWxBbTM3?=
 =?utf-8?B?YSszZWRCbHJrQ3F2MWtPMThNazM2ZE9SVXgzYTFiQlM4OE52NmVpRzJ3cGNK?=
 =?utf-8?B?MlZYb2JFblQ2akkyeDNDTEVpbG5pWlZydTVQSWhncUtudEdMSGZxVWtUdXBU?=
 =?utf-8?B?ZWdkeVRaUWRXcjkwKzFSQWFTZEk5UDFLLzZ3MDlHdG1WaFNXLzM2UlFoRk56?=
 =?utf-8?B?aG94UXZQVjZEYWZUN3BQS0p5Nm9wTGNiaVJqQXR1cTdyU0NmRUdRWVl6ZDRx?=
 =?utf-8?B?R3BMRGsxZG5SOFdpOHI3WGU0L2U3MW56cElTbmVvUUZMcXhvNm9GV013Znht?=
 =?utf-8?Q?B2YhcyPSxvs8G?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(7416008)(921014)(38070700012);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aElqRHgwQmhaMys1RlZBL25HZWttQmNEcFF5dkxMMEM5Mms2ckJzN0liakVL?=
 =?utf-8?B?RnFrRElXRGhvZ09uRGUvbjNEMDNPcHdUbUQ1U1pJZHV0Z21XbWUzYUoyWWxa?=
 =?utf-8?B?N2MrL0NDQWJ2alNaWWhabWo4QWdNSll5OWhNZ0pTWnd5Z3FlNzZMTDE3ak9u?=
 =?utf-8?B?Z1dHUk5sUkhGbWhCWW1sdG9iWVZ6amFTQlA4THRiWlFwZGFERmJZcHlsWEtx?=
 =?utf-8?B?cDRsU1dESWhNV2RIdHJvZ0NZNHFPTEM5VXZOMEdaS0pleCt1VVQrZGcxK0Fv?=
 =?utf-8?B?NUxncUdOQzF0STBPSndzcDdXRUFQM1krZjhJSFdNeVJpdWhFUU5qSHJmTEdC?=
 =?utf-8?B?ZjlWZnllRURva1VkLzRZYnFEcUkzTDdMYnpRV3BaanhWYi9TNzNPZ28wdUlz?=
 =?utf-8?B?QWdUMDl5N0NMaEVnOHR5eThrNjVZR2FySFdvU3FhRmp1SzYxZG14aERaemw1?=
 =?utf-8?B?MUpKR1ZLMGloSUdwb2NxcUZuM0ZGaTdNV05YUUg0N09Bbis0eGRnaWR0bGc0?=
 =?utf-8?B?UmdqTmdXTlU5eUZ2bTUwK3lWZmx3ZTBJS1ZYbERXMUpkSDlHN2lOejI4QlZK?=
 =?utf-8?B?MTZXRFd1MmRmNkQzUU9sdTk2c2FoNW1BTjFyS1hOanRBSFJoUkd0cnBycDF5?=
 =?utf-8?B?eGV4SGlPWXhoV21sQklOUUJrNVIwN25YdGJWS3AwV2VVWmdBV3Z0eEdlN1JQ?=
 =?utf-8?B?N3NPS3hPRnptRlNmdEppZ1JQbVl2bGRkTit0bXlCUTZtR1RTcEMxOGNRSm0v?=
 =?utf-8?B?YW5qcmM0OGx1VlRSUWJZV0RyUnpuU1FqZ3BTMWJaVFNObVpEWUo1Sm1FS2ln?=
 =?utf-8?B?Vm5DenIwYXh4Z1JlaXNwM2tFTU44ZlpyeGs0YytaZU5WMEs1WVhtN0ZOcktR?=
 =?utf-8?B?VHdzb2JiS2ZrS1hXMk8vbzU1VUlGZ0R4b0xKYjhXMmtCZHRDbUloMVBURWRn?=
 =?utf-8?B?dERGUTg2RDhhYVdIUHdRVEVYSEExUlBaYjQvZTdISEZCZFd0ZGtocXowRytH?=
 =?utf-8?B?NmdXNmVHeWc5TGQzcEY1TGF0d0NMNWY1OTNXZ204R2VyNUxuZHFpM3Fxa2FY?=
 =?utf-8?B?cUp0THFFd3R4UUhraG1tbjFnNjd0SFJFeEh4dkhBZUpzL3RKbE5HVTNieU9G?=
 =?utf-8?B?WlRmZm5DUkI3OGM4TFF4OUErc0pWUEI5Nlg5bENtUWhNS0ZWTzNJUHFEYmlP?=
 =?utf-8?B?Wk5vTzhSaFdYRXpkcnRmbmc4cjZJOVp4OEI0aC9YN1FZYXZHR3J6UDFPNEI4?=
 =?utf-8?B?WWNKckgvM0Z6bHRNVkx1WHlKMi9wT21uZWdLdFllSlVtbjVTTldvd0c2ZHFs?=
 =?utf-8?B?NXJxSjNKNDZiUGovd0JKcitMRjB0S0dWNXZTZlBRTVRSNkFRZHU2d3JBNTlF?=
 =?utf-8?B?Nzc0ZC9UamxsaDFKLzV2TUo2aHF4MmlTNEZVUzFjbkJ5dTBwVGxRN29YQ1Nu?=
 =?utf-8?B?Nm9WbDJCMWpDL0FYZkJQSlJ4WDF4TjdGZHJMY3NyOXJEOGZNeU14Rmk1NWJh?=
 =?utf-8?B?VU5zeml2SmM3V0ZydGNOV1JlOFlUUmlwdWpOWWZzWEVxREh4VE5VT3pROGhK?=
 =?utf-8?B?ZXBLYU9RdlZsMGJObzV3Y29XbDZVTkxwUGhuZXc3YWxWUGpQa09DSVl3Nis2?=
 =?utf-8?B?a2Q3RTJ2Z0ZsOHg2UnA1V1JEZlI1ekVhckdSbWZWY3hNa00rUWxiK05PRndH?=
 =?utf-8?B?LzlZTkpWdUgwQ242UjRNQ25HLzJaTmVISE9qUnl2cFp0MnZSRTk0Nkx1ejE4?=
 =?utf-8?B?dVZOMjJRZWN4NXB2OWVEMkZUQ0paVzdjZmJ3SHgyMUtYYmhWN2lIVjQrQk1h?=
 =?utf-8?B?Mm1TZVArQ0dZYk1CV0lSa2dyd2lhWGp6SzkzeEhaV09nbEErNWdQV0ZRcjNi?=
 =?utf-8?B?NktITWtWR1liTGx5ZVRSREJOWTFaSTVSZmduU1ZqSEpqbDlGc3FXeGJCQk8x?=
 =?utf-8?B?dGpJampmWlhPbVR3blRpcVk2Nk1mL2RWdG5RUEo3S0V6QXR3RUFoMUFJU1g0?=
 =?utf-8?B?VUMrcGdIK0NxcEQ0dlYyeUNMS1RsSm02WXBkZU9nWmgvM2kwcml3ZGVrQjly?=
 =?utf-8?B?bVU5Zm11Wk9JZ1dHbXVPeUNlazYxTzJZRnRuL2o3RXZpMmFDbHNVS2dIMS9T?=
 =?utf-8?Q?gI8TrMiDNrDGt8eeQQG8/SM4I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0073b931-f645-44ec-186f-08dc8b8e8e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 09:52:36.7264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1AghDh8lY62iYpQkZQfWa/SFF9oCEtVOWEoNfUgf35vsPRp2r11VhSQ55AAs5L2aJaSPPJFU21ORb9vYFkYLbn9g2xHJYOQGV9ljAxt2fQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1JGQyB2MiA0LzddIHZpcnRpby1pb21t
dTogQ29tcHV0ZSBob3N0IHJlc2VydmVkIHJlZ2lvbnMNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+
T24gNi8xMS8yNCAwNToyNSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBbUkZDIHYyIDQvN10gdmlydGlvLWlvbW11OiBDb21wdXRl
IGhvc3QgcmVzZXJ2ZWQgcmVnaW9ucw0KPj4+DQo+Pj4gQ29tcHV0ZSB0aGUgaG9zdCByZXNlcnZl
ZCByZWdpb25zIGluIHZpcnRpb19pb21tdV9zZXRfaW9tbXVfZGV2aWNlKCkuDQo+Pj4gVGhlIHVz
YWJsZSBJT1ZBIHJlZ2lvbnMgYXJlIHJldHJpZXZlZCBmcm9tIHRoZSBIT1NUSU9NTVVEZXZpY2Uu
DQo+Pj4gVGhlIHZpcnRpb19pb21tdV9zZXRfaG9zdF9pb3ZhX3JhbmdlcygpIGhlbHBlciB0dXJu
cyB1c2FibGUgcmVnaW9ucw0KPj4+IGludG8gY29tcGxlbWVudGFyeSByZXNlcnZlZCByZWdpb25z
IHdoaWxlIHRlc3RpbmcgdGhlIGluY2x1c2lvbg0KPj4+IGludG8gZXhpc3Rpbmcgb25lcy4gdmly
dGlvX2lvbW11X3NldF9ob3N0X2lvdmFfcmFuZ2VzKCkgcmV1c2UgdGhlDQo+Pj4gaW1wbGVtZW50
YXRpb24gb2YgdmlydGlvX2lvbW11X3NldF9pb3ZhX3JhbmdlcygpIHdoaWNoIHdpbGwgYmUNCj4+
PiByZW1vdmVkIGluIHN1YnNlcXVlbnQgcGF0Y2hlcy4gcmVidWlsZF9yZXN2X3JlZ2lvbnMoKSBp
cyBqdXN0IG1vdmVkLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+IGh3L3ZpcnRpby92aXJ0aW8taW9tbXUuYyB8
IDE1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+LS0tLQ0KPj4+IC0NCj4+
PiAxIGZpbGUgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYyBiL2h3L3ZpcnRpby92
aXJ0aW8taW9tbXUuYw0KPj4+IGluZGV4IDA2ODBhMzU3ZjAuLjMzZTk2ODJiODMgMTAwNjQ0DQo+
Pj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+Pj4gKysrIGIvaHcvdmlydGlvL3Zp
cnRpby1pb21tdS5jDQo+Pj4gQEAgLTQ5NCwxMiArNDk0LDExNCBAQCBnZXRfaG9zdF9pb21tdV9k
ZXZpY2UoVmlydElPSU9NTVUNCj4+PiAqdmlvbW11LCBQQ0lCdXMgKmJ1cywgaW50IGRldmZuKSB7
DQo+Pj4gICAgIHJldHVybiBnX2hhc2hfdGFibGVfbG9va3VwKHZpb21tdS0+aG9zdF9pb21tdV9k
ZXZpY2VzLCAma2V5KTsNCj4+PiB9DQo+Pj4NCj4+PiArLyoqDQo+Pj4gKyAqIHJlYnVpbGRfcmVz
dl9yZWdpb25zOiByZWJ1aWxkIHJlc3YgcmVnaW9ucyB3aXRoIGJvdGggdGhlDQo+Pj4gKyAqIGlu
Zm8gb2YgaG9zdCByZXN2IHJhbmdlcyBhbmQgcHJvcGVydHkgc2V0IHJlc3YgcmFuZ2VzDQo+Pj4g
KyAqLw0KPj4+ICtzdGF0aWMgaW50IHJlYnVpbGRfcmVzdl9yZWdpb25zKElPTU1VRGV2aWNlICpz
ZGV2KQ0KPj4+ICt7DQo+Pj4gKyAgICBHTGlzdCAqbDsNCj4+PiArICAgIGludCBpID0gMDsNCj4+
PiArDQo+Pj4gKyAgICAvKiBmcmVlIHRoZSBleGlzdGluZyBsaXN0IGFuZCByZWJ1aWxkIGl0IGZy
b20gc2NyYXRjaCAqLw0KPj4+ICsgICAgZ19saXN0X2ZyZWVfZnVsbChzZGV2LT5yZXN2X3JlZ2lv
bnMsIGdfZnJlZSk7DQo+Pj4gKyAgICBzZGV2LT5yZXN2X3JlZ2lvbnMgPSBOVUxMOw0KPj4+ICsN
Cj4+PiArICAgIC8qIEZpcnN0IGFkZCBob3N0IHJlc2VydmVkIHJlZ2lvbnMgaWYgYW55LCBhbGwg
dGFnZ2VkIGFzIFJFU0VSVkVEICovDQo+Pj4gKyAgICBmb3IgKGwgPSBzZGV2LT5ob3N0X3Jlc3Zf
cmFuZ2VzOyBsOyBsID0gbC0+bmV4dCkgew0KPj4+ICsgICAgICAgIFJlc2VydmVkUmVnaW9uICpy
ZWcgPSBnX25ldzAoUmVzZXJ2ZWRSZWdpb24sIDEpOw0KPj4+ICsgICAgICAgIFJhbmdlICpyID0g
KFJhbmdlICopbC0+ZGF0YTsNCj4+PiArDQo+Pj4gKyAgICAgICAgcmVnLT50eXBlID0gVklSVElP
X0lPTU1VX1JFU1ZfTUVNX1RfUkVTRVJWRUQ7DQo+Pj4gKyAgICAgICAgcmFuZ2Vfc2V0X2JvdW5k
cygmcmVnLT5yYW5nZSwgcmFuZ2VfbG9iKHIpLCByYW5nZV91cGIocikpOw0KPj4+ICsgICAgICAg
IHNkZXYtPnJlc3ZfcmVnaW9ucyA9IHJlc3ZfcmVnaW9uX2xpc3RfaW5zZXJ0KHNkZXYtPnJlc3Zf
cmVnaW9ucywNCj5yZWcpOw0KPj4+ICsgICAgICAgIHRyYWNlX3ZpcnRpb19pb21tdV9ob3N0X3Jl
c3ZfcmVnaW9ucyhzZGV2LQ0KPj4+PiBpb21tdV9tci5wYXJlbnRfb2JqLm5hbWUsIGksDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlX2xvYigm
cmVnLT5yYW5nZSksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJhbmdlX3VwYigmcmVnLT5yYW5nZSkpOw0KPj4+ICsgICAgICAgIGkrKzsNCj4+PiAr
ICAgIH0NCj4+PiArICAgIC8qDQo+Pj4gKyAgICAgKiB0aGVuIGFkZCBoaWdoZXIgcHJpb3JpdHkg
cmVzZXJ2ZWQgcmVnaW9ucyBzZXQgYnkgdGhlIG1hY2hpbmUNCj4+PiArICAgICAqIHRocm91Z2gg
cHJvcGVydGllcw0KPj4+ICsgICAgICovDQo+Pj4gKyAgICBhZGRfcHJvcF9yZXN2X3JlZ2lvbnMo
c2Rldik7DQo+Pj4gKyAgICByZXR1cm4gMDsNCj4+PiArfQ0KPj4+ICsNCj4+PiArc3RhdGljIGlu
dCB2aXJ0aW9faW9tbXVfc2V0X2hvc3RfaW92YV9yYW5nZXMoVmlydElPSU9NTVUgKnMsIFBDSUJ1
cw0KPj4+ICpidXMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGludCBkZXZmbiwgR0xpc3QgKmlvdmFfcmFuZ2VzLA0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+Pj4gK3sNCj4+
PiArICAgIElPTU1VUGNpQnVzICpzYnVzID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT5hc19ieV9i
dXNwdHIsIGJ1cyk7DQo+Pj4gKyAgICBJT01NVURldmljZSAqc2RldjsNCj4+PiArICAgIEdMaXN0
ICpjdXJyZW50X3JhbmdlczsNCj4+PiArICAgIEdMaXN0ICpsLCAqdG1wLCAqbmV3X3JhbmdlcyA9
IE5VTEw7DQo+Pj4gKyAgICBpbnQgcmV0ID0gLUVJTlZBTDsNCj4+PiArDQo+Pj4gKyAgICBpZiAo
IXNidXMpIHsNCj4+PiArICAgICAgICBlcnJvcl9yZXBvcnQoIiVzIG5vIHNidXMiLCBfX2Z1bmNf
Xyk7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICsgICAgc2RldiA9IHNidXMtPnBiZGV2W2RldmZu
XTsNCj4+PiArDQo+Pj4gKyAgICBjdXJyZW50X3JhbmdlcyA9IHNkZXYtPmhvc3RfcmVzdl9yYW5n
ZXM7DQo+Pj4gKw0KPj4+ICsgICAgaWYgKHNkZXYtPnByb2JlX2RvbmUpIHsNCj4+IFdpbGwgdGhp
cyBzdGlsbCBoYXBwZW4gd2l0aCBuZXcgaW50ZXJmYWNlPw0KPm5vIHRoaXMgc2hvdWxkbid0LiBS
ZXBsYWNlZCBieSBhIGdfYXNzZXJ0KCFzZGV2LT5wcm9iZV9kb25lKSB0byBtYWtlDQo+c3VyZSB0
aGUgaS9mIGlzIHVzZWQgcHJvcGVybHkuDQo+Pg0KPj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJy
cCwNCj4+PiArICAgICAgICAgICAgICAgICAgICIlczogTm90aWZpZWQgYWJvdXQgbmV3IGhvc3Qg
cmVzZXJ2ZWQgcmVnaW9ucyBhZnRlciBwcm9iZSIsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICBf
X2Z1bmNfXyk7DQo+Pj4gKyAgICAgICAgZ290byBvdXQ7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+
ICsgICAgLyogY2hlY2sgdGhhdCBlYWNoIG5ldyByZXN2IHJlZ2lvbiBpcyBpbmNsdWRlZCBpbiBh
biBleGlzdGluZyBvbmUgKi8NCj4+PiArICAgIGlmIChzZGV2LT5ob3N0X3Jlc3ZfcmFuZ2VzKSB7
DQo+PiBTYW1lIGhlcmUuDQo+VG8gbWUgdGhpcyBvbmUgY2FuIHN0aWxsIGhhcHBlbiBpbiBjYXNl
IHNldmVyYWwgZGV2aWNlcyBiZWxvbmcgdG8gdGhlDQo+c2FtZSBncm91cC4NCg0KSWYgc2FtZSBz
bG90IGlzIHVzZWQgdG8gcGx1Zy91bnBsdWcgdmZpbyBkZXZpY2VzIHdpdGggZGlmZmVyZW50IHJl
c2VydmVkDQpyYW5nZXMsIHRoZSBzZWNvbmQgZGV2aWNlIHBsdWcgbWF5IGNoZWNrIGZhaWxlZC4N
Ckl0IGxvb2tzIHNkZXYtPmhvc3RfcmVzdl9yYW5nZXMgaXMgbm90IGZyZWVkIGFmdGVyIHVucGx1
Zy4NCg0KPj4NCj4+PiArICAgICAgICByYW5nZV9pbnZlcnNlX2FycmF5KGlvdmFfcmFuZ2VzLA0K
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm5ld19yYW5nZXMsDQo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAwLCBVSU5UNjRfTUFYKTsNCj4+PiArDQo+Pj4gKyAgICAg
ICAgZm9yICh0bXAgPSBuZXdfcmFuZ2VzOyB0bXA7IHRtcCA9IHRtcC0+bmV4dCkgew0KPj4+ICsg
ICAgICAgICAgICBSYW5nZSAqbmV3ciA9IChSYW5nZSAqKXRtcC0+ZGF0YTsNCj4+PiArICAgICAg
ICAgICAgYm9vbCBpbmNsdWRlZCA9IGZhbHNlOw0KPj4+ICsNCj4+PiArICAgICAgICAgICAgZm9y
IChsID0gY3VycmVudF9yYW5nZXM7IGw7IGwgPSBsLT5uZXh0KSB7DQo+Pj4gKyAgICAgICAgICAg
ICAgICBSYW5nZSAqIHIgPSAoUmFuZ2UgKilsLT5kYXRhOw0KPj4+ICsNCj4+PiArICAgICAgICAg
ICAgICAgIGlmIChyYW5nZV9jb250YWluc19yYW5nZShyLCBuZXdyKSkgew0KPj4+ICsgICAgICAg
ICAgICAgICAgICAgIGluY2x1ZGVkID0gdHJ1ZTsNCj4+PiArICAgICAgICAgICAgICAgICAgICBi
cmVhazsNCj4+PiArICAgICAgICAgICAgICAgIH0NCj4+PiArICAgICAgICAgICAgfQ0KPj4+ICsg
ICAgICAgICAgICBpZiAoIWluY2x1ZGVkKSB7DQo+Pj4gKyAgICAgICAgICAgICAgICBnb3RvIGVy
cm9yOw0KPj4+ICsgICAgICAgICAgICB9DQo+Pj4gKyAgICAgICAgfQ0KPj4+ICsgICAgICAgIC8q
IGFsbCBuZXcgcmVzZXJ2ZWQgcmFuZ2VzIGFyZSBpbmNsdWRlZCBpbiBleGlzdGluZyBvbmVzICov
DQo+Pj4gKyAgICAgICAgcmV0ID0gMDsNCj4+PiArICAgICAgICBnb3RvIG91dDsNCj4+PiArICAg
IH0NCj4+PiArDQo+Pj4gKyAgICByYW5nZV9pbnZlcnNlX2FycmF5KGlvdmFfcmFuZ2VzLA0KPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAmc2Rldi0+aG9zdF9yZXN2X3JhbmdlcywNCj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgMCwgVUlOVDY0X01BWCk7DQo+Pj4gKyAgICByZWJ1aWxk
X3Jlc3ZfcmVnaW9ucyhzZGV2KTsNCj4+PiArDQo+Pj4gKyAgICByZXR1cm4gMDsNCj4+PiArZXJy
b3I6DQo+Pj4gKyAgICBlcnJvcl9zZXRnKGVycnAsICIlcyBDb25mbGljdGluZyBob3N0IHJlc2Vy
dmVkIHJhbmdlcyBzZXQhIiwNCj4+PiArICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPj4+ICtv
dXQ6DQo+Pj4gKyAgICBnX2xpc3RfZnJlZV9mdWxsKG5ld19yYW5nZXMsIGdfZnJlZSk7DQo+Pj4g
KyAgICByZXR1cm4gcmV0Ow0KPj4+ICt9DQo+Pj4gKw0KPj4+IHN0YXRpYyBib29sIHZpcnRpb19p
b21tdV9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsDQo+Pj4gaW50
IGRldmZuLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhv
c3RJT01NVURldmljZSAqaGlvZCwgRXJyb3IgKiplcnJwKQ0KPj4+IHsNCj4+PiAgICAgVmlydElP
SU9NTVUgKnZpb21tdSA9IG9wYXF1ZTsNCj4+PiAgICAgVmlydGlvSG9zdElPTU1VRGV2aWNlICp2
aGlvZDsNCj4+PiArICAgIEhvc3RJT01NVURldmljZUNsYXNzICpoaW9kYyA9DQo+Pj4gSE9TVF9J
T01NVV9ERVZJQ0VfR0VUX0NMQVNTKGhpb2QpOw0KPj4+ICAgICBzdHJ1Y3QgaGlvZF9rZXkgKm5l
d19rZXk7DQo+Pj4gKyAgICBHTGlzdCAqaG9zdF9pb3ZhX3JhbmdlcyA9IE5VTEw7DQo+PiBnX2F1
dG9wdHIoR0xpc3QpPw0KPmFyZSB5b3Ugc3VyZSB0aGlzIGZyZWVzIGFsbCB0aGUgZWxlbWVudHMg
b2YgdGhlIGxpc3Q/CQ0KDQpOb3QgcXVpdGUgc3VyZSwganVzdCBzZWUgc29tZSBjb2RlIGluIHFl
bXUgdXNlIGl0IHRoYXQgd2F5Lg0KDQo+IEFzIG9mIG5vdyBJIHdvdWxkDQo+YmUgdGVtcHRlZCB0
byBsZWF2ZSB0aGUgY29kZSBhcyBpcy4NCg0KU3VyZSwgdGhhdCdzIGZpbmUuDQoNClRoYW5rcw0K
Wmhlbnpob25nDQoNCg==

