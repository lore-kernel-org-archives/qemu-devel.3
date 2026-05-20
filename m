Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CE4CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfO5-0000bV-0k; Wed, 20 May 2026 07:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wPfNL-0000ZB-Jz
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:46:13 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wPfNH-0008Ao-0l
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779277567; x=1810813567;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RZd8QuqdEPQDKqgfo92QXJYnqp/YjbMSVfHxcVEZxBI=;
 b=H20bcYadT9qePQoYYs5kU/nLsOVl0OZIwLAJmOXzL8rHdS/dqFoH8C7l
 MEhlMVJ/BjLgP1hg/JMhEMwNy5W+T7JhFWYSl/8BUZ3A+39lOdoLxv+r0
 3aeSeeyoc4U7WCRSrxzHRtQ182AVlJ+7OEe2QlBmN79Vid+L6w2+X+N62
 f206A31jATZivfuivVBUEVZzuodvPr+cDh1m/lpgyoXROlhGE0aoow+vq
 gzNPHnTWnuh/EIHooTpSIw62dtsnuNZQiNZ1ZiRGbBBTRn/d4tnRHEXjx
 SysGbK0Dp2Bir8IcxTQogDWtwCiIXybZy4czyeTe0r59Ptkh606DID4b3 w==;
X-CSE-ConnectionGUID: Qn+5hgCbQ/CXY+iipa6XAw==
X-CSE-MsgGUID: pqsGY2+kRVqY7VXBUyfw1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80345043"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="80345043"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:38:55 -0700
X-CSE-ConnectionGUID: m/ZI5VqrSB2Flrc1A+k9uA==
X-CSE-MsgGUID: SKepBK55QPusZ23BzeKnqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="239137111"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:38:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:38:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 03:38:54 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:38:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FD6VKYKb+11JL5CMyxGUh5yLs/XAcrJeK7NVy0X+mwRPffS0Ze1oS/oQ5Bcle5dslMzDY6v4IkYxCROwyRrKw7A9yEtbPrZNvcOLl6WeVtyv/O/CeCZSR7ja5qp4XhorrRMpcmwH6dXw+6Rnowl+xBmIvI6WbI7AdnBLpY8QgLZonenPcudbPTi3zK6/aXq8ZnD9XP3lXfMlc1MXD5fNUW1QInwpXiZCnhIQdHgAYEkpK2qSm6DLwey7oYQvXcIaBC234EuouX7uoQ79RqZxyUcz3/tknc9N07bhBEkspL0PK7uyGFsZpg4VR5lckUKOUatoeTyQM2W7yKKXPtQrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZd8QuqdEPQDKqgfo92QXJYnqp/YjbMSVfHxcVEZxBI=;
 b=O9zwm3Czg0QZ0fMJgHadM3/JO4LX16pbgXma38UU9AUo/8unNwBq0Ofy8I6kqItFFP2SxFxn2GVsNjEZbc5JOnRE25cNNF9bXe9iLHn01ZW9gNJdgwv/I3pAMI12hOkuSjFVche5t5QwvDCj1uQvczdlyvXoXXEgub6uD46KtfRJj7ccfSOFXJrF6w6p7BK8QgSUyq818hFA5h65TkbU5AQyFE/Fww1++aa/Jfm4SH+Gz3UXouN+lQqYkepQ7pXDWvxksAORTIKgVCHU8A1JMJUaONygJvZVtn3O3R9qmYccHDAAOkwhrW8uIxjjKhL3FiyI+2qWqqaY4JXV12JZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:38:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 10:38:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v5 14/15] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [PATCH v5 14/15] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHc32mq+heH+3Y7mkyp8HUicHH917YNafsAgAlf6oA=
Date: Wed, 20 May 2026 10:38:49 +0000
Message-ID: <IA3PR11MB9136F28FF99D26A8BDA1E2B692012@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-15-zhenzhong.duan@intel.com>
 <33d2536a-6401-4724-a632-5cf5003f2143@intel.com>
In-Reply-To: <33d2536a-6401-4724-a632-5cf5003f2143@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6055:EE_
x-ms-office365-filtering-correlation-id: c24ae9ac-57c6-41ba-84bb-08deb65bfad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|4143699003|56012099003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info: 7fxWeht6N21M3bAy0kAIR8cnrUs3/0hsEVQKZjLzAKdc+F8H0u4L3U87en2g8jyd8odIfn4lEyD7wnMjVGEAaXwCJ0Ym1zc8UnZuodCAX/u3j2vIszyxLRkWabVVI5O7ULWDmOZVC10bSbhJuCzSNVdAkh3pM9rA/4tnjoWBMxeC0DwkpaY91lLesznGNx6jnkXVrWvj0pool72UvHAbZxQlLWMlHxZtvSM4UQ4nNroKOht+ZhRZG01AnvXw2rBqrdLBI6GH29DDkV3BO9dASgidWjGL8AOzuiVG9n4r3UGZq0U6KJqiF6lPE8vv6t1SoRSKUC6UWl7/lbbhaJhJpp3WDBu+KE26O7RRql42LEeYEmv+Lb09iisZTDBmWSBn2T6S2KwKvRheyhMvPRYjkANsPLgy8p7a+lCMJ7QXN68pC3nkojrYEg+GJhW2TvEprX7Ntb3Kyv/tGWzgSEEAp1/SA2qdk1h4JiqweD0lmMDKcqERPCWxx4QWjfikP3NuIAftWdevezEhUZTp5MEttwypaZkviZ5nJFxBo5xWh2X4wC5YEV5sE6yFaN0kVj7T/A+ux5MLZf8bC+nd8GQGJePvCKNK761Z8INASwa8ZQ50m0UUfANORsjhhkUaISPsAc6CMslEMujJk51oiqTXAFfqDkDaeaTGEAY4bzhTSiqE4oMx6a4GiA9NVJUMGWrxcKMXTCldS8ivqa9Z+NA0CVNayY0xFaAzahOn6TyGt617Su6LmqIzYen7EJxLXyA+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTZ5TCtSbkk3WnFORDdiUHM1WmFleUdoUFpjT3R3aGxJTjlNU1pDemtNaXAw?=
 =?utf-8?B?dGF2M3g2MlQvaEVXc2ZpVzJXTFZWa1lGMHlueUJFelBKZThFUHJ0ZTVNb0Q5?=
 =?utf-8?B?MDFzb2QxWGVvdmp0Z05oVHpDQjNuQzg5dzJ6TUM5YkJwZ1JLZHdLeEVUc3A5?=
 =?utf-8?B?MHVHQk1UK3hKdklySnBvMEl3MzlDeHJZTlFVSDFuU21qdS9tc1RPdjNPaEI5?=
 =?utf-8?B?TUZOUTNFYktBMkx3QU9zYzQxRWpSbkNSTmNhRGoxVG9IaEFSOExFMUVkQTEw?=
 =?utf-8?B?ZGExWVdHT1pJRkpjTm1LZ3NpTGFMZGIyaXd3VkdyMWtTWFJkOVNtbG9TOE42?=
 =?utf-8?B?UU9Qb096ZHZrM3FxR3MwZkR6SGFGSzAyYktFRGlPb0Y1a25mQnpvNVFRL0Za?=
 =?utf-8?B?S1NrZ0gyOVBMc3V3NEpFMTN6dnA0cHdiNTExUnU1RlkzMXNBSEZBS20wN1hY?=
 =?utf-8?B?ZFhZai9mTFVMSWZFcGhBVjVoOGlwVWljbHpvQ1A5cG9mR0JBR0JTSkZ3SGRV?=
 =?utf-8?B?Ky85ZDd2NnFJOXpaT0VURTFFTkhIcXdVall0MUdZU3FlVHVyTG9aNy9FZ002?=
 =?utf-8?B?ME1iNzYrU3BNSUw2U1lkOGQ3UUZyTkNiNWxuVkZJeS9VUDFuWGlrcVlPb1JX?=
 =?utf-8?B?eHV6eXo5eTlvVy91V1VsczlZKzBvenVMUk5yZ1ltM1k1RXRWZWFqb2tCbFVw?=
 =?utf-8?B?WitxRWtrcGRPdVg4MSsvbHUrOGxVRVZ3WGk0Yzg3MW90ZVZQU2JRVFIwQmwv?=
 =?utf-8?B?MXk5RDZ2WFdZd2FPZVFRNk1GaitsTDU1YzYxcHpya1gzUU4xUXVYaTFseEJ2?=
 =?utf-8?B?bmNOZE93aTlmdEUwYUJSUVFiUFNDUVgrL2RiWVFld0wzckk2M3lLWHY2ZlNM?=
 =?utf-8?B?SWdkc3d6aGg5UUduNWhBeHZiVC83RTUwUDhNeG0xOTQrbUF3dmdESFgxT1lD?=
 =?utf-8?B?djFSVG9zQkc2SmxadFI2RWIvK2V0Z3B2a0ZEZlcvbWxZWjc4VUpTTWFhS0dz?=
 =?utf-8?B?VlpsSEZDT2Z2clAzRHc5YkhaYURYQ2tBZU0zQVVlb3QzanpZNXZVNmNNWE81?=
 =?utf-8?B?Wk1kWHBCTjhOb0ZkZ2lQWXpWdnBiQkU1eXAwaThiMU5GOEZnS1AvakYzNGlY?=
 =?utf-8?B?VE9YRFBHc0N4bW43b3pZMGNKNzM5bFhHZm8yY1Z6Vyt0c1JtMC9xYSs5dzVs?=
 =?utf-8?B?TGU2OEEyNDAvdzhQOGxKbWdFakZHU3MrNFhNbm94eVc1QzNEcGdNRVpqamQ4?=
 =?utf-8?B?dWZHMi9Kbkx2L0JmUDYzaFFWd1d3S05HSGM0cWgyY1hMMFJrNFZmY3NnRjVi?=
 =?utf-8?B?a1lvUzY5ZHpwUWRXbHM2TUU4UXBnSHZSUFdJZ3dWWGRCWVd5elppVlhRblZw?=
 =?utf-8?B?QXZEb1hhOFIyRFFhWDNpTTlrRDVkZndmMHBVWUVLcWdCcEVEb0lLSitvUzBx?=
 =?utf-8?B?THF1b3NRMldoWWtqQjZjRU1kRmFjeTkyN1dkRWx0a3k0cTFDazZJZ1VjdGs4?=
 =?utf-8?B?MTRLRk9NcGFZWEp6ejlSck8wdWZONDVYNDdMdjZSTldXYTVBWUZNQWh4dG5J?=
 =?utf-8?B?NDdjYWJ0Z3VwZ0dGMVVzcHFNUkJIYWRmOXlHYXBPbSt3Z1pTbkJGMU5sNmEw?=
 =?utf-8?B?eW51S1c0RkxJQ0lvc3V0akVDdkF0NENHMjhnTjFWdXNUWEJBOVpyLzU1N09u?=
 =?utf-8?B?OVg0SU9tSmNibitrdjZEY0g0bTVYOUgzeC9yOUlrSThteTdWd1R0azljNWd4?=
 =?utf-8?B?bVR2aGNvWUhOcUlHVVVzMGZ0bDlhTWxvUzdCY2NQM0JNbzh6bXhKenBtV3gy?=
 =?utf-8?B?QTVPeU82MUZJVlBUMWhRWHVSVDF3V1FFSHViN1Z2dmdYeVQ4SFJZa2NkNDNT?=
 =?utf-8?B?bkt6OE92ZVduU0s1cDVvdnRkU1gyQUpxRzFoaFBsY3JjSGJsVVZBb3pPakdD?=
 =?utf-8?B?VVg5ODhyQnhIdWtRKzFROU5ta1F2QVg4TjFzRENmQkVLSXdRQWJmMkE2bW9W?=
 =?utf-8?B?dVkrZkN4QWEvNGRCaStVTGtyQ05nL0Y5ckF2SC9QQUNuVUkzNnVOYmpPRUlq?=
 =?utf-8?B?aG55MTZWSkFlNHlpSEFzdkxTUG5VYitxeTlveFRwZnl3NHM2Zm1wVDRlUStK?=
 =?utf-8?B?UkVMQjVFclBQSkZNcW9GaVFidnQ1aU9wUWNLc09KMWxmVUt4MEFhK1NBUDFp?=
 =?utf-8?B?QWZHaEx3NmkrMjR3ZzczN3ZyUEp5ZlVLNkZRTTFPZGlxNGFoelhIS2g3Vk5h?=
 =?utf-8?B?R1RGZGpBdml5R0lNcmoxYlVrRVNZU1JSUjFkREFlQWhKWGhwRmYxYnJIMzZn?=
 =?utf-8?B?REt5UithV0pwU1VTVGZjeGVPeXJxSHgxVzVlQjRRckFGZlhYRmZOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lXpsBsOD2nRjtq/iweLaGOxbVOqLRbFNOcamJV20grSPP0cFveZEisY0pZh5n9f1DOiiZB8wPsOd/QyAvj+Qns1GnNci7bJiK1q+1kR7UPnqOJ2Gm+oupNE1N1KeK6GdE0t863q8T9mlQx2uqydb/NVimalLRg9B0IwAJTaPj9JKbQzZpp0Try42qYPB8eTXG80BGW5Xt5jIRJlq2df7seI1p7lUCJ2LS2JGLnvfpW82JV1niBQIKamdCZa7F029VLglhYAz5zD5mefa/LpN7quuBztusY1fxfbujcfwP03ThSaoHzrALjLfPpAnzieOtBSpsod8TizyKRPXzV/h2w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ae9ac-57c6-41ba-84bb-08deb65bfad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 10:38:49.9167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8g4jhzP1WLwwjf/9NsOAgJJFOQln24+FGylyhRNtKAPScbGRv6ofknjBQIbVcqg/wmmnARp6wx/VuxsfwXu0Ou++UkNSzvRkexNam2Yb8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

SGkNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGl1LCBZaSBMIDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNC8xNV0gaW50ZWxfaW9t
bXVfYWNjZWw6IEFkZCBwYXNpZCBiaXRzIHNpemUgY2hlY2sNCj4NCj5PbiA1LzkvMjYgMTI6MDgs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSWYgcGFzaWQgYml0cyBzaXplIGlzIGJpZ2dlciB0
aGFuIGhvc3Qgc2lkZSwgaG9zdCBjb3VsZCBmYWlsIHRvIGVtdWxhdGUNCj4+IGFsbCBiaW5kaW5n
cyBpbiBndWVzdC4gQWRkIGEgY2hlY2sgdG8gZmFpbCBkZXZpY2UgcGx1ZyBlYXJseS4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4gVGVzdGVkLWJ5OiBYdWRvbmcgSGFvIDx4dWRvbmcuaGFvQGludGVsLmNvbT4NCj4+IFJl
dmlld2VkLWJ5OiBDbGVtZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBi
dWxsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAx
ICsNCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jICAgIHwgOCArKysrKysrKw0KPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgNCj4+IGluZGV4IDJjNzE2YzUyOTcuLjUxOWFmM2ZhOTAgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPj4gQEAgLTE5Niw2ICsxOTYsNyBAQA0KPj4gICAjZGVmaW5lIFZURF9F
Q0FQX1NSUyAgICAgICAgICAgICAgICAoMVVMTCA8PCAzMSkNCj4+ICAgI2RlZmluZSBWVERfRUNB
UF9OV0ZTICAgICAgICAgICAgICAgKDFVTEwgPDwgMzMpDQo+PiAgICNkZWZpbmUgVlREX0VDQVBf
U0VUX1BTUyh4LCB2KSAgICAgICgoeCktPmVjYXAgPSBkZXBvc2l0NjQoKHgpLT5lY2FwLCAzNSwg
NSwgdikpDQo+PiArI2RlZmluZSBWVERfRUNBUF9HRVRfUFNTKGVjYXApICAgICAgZXh0cmFjdDY0
KGVjYXAsIDM1LCA1KQ0KPj4gICAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAo
MVVMTCA8PCA0MCkNCj4+ICAgI2RlZmluZSBWVERfRUNBUF9QRFMgICAgICAgICAgICAgICAgKDFV
TEwgPDwgNDIpDQo+PiAgICNkZWZpbmUgVlREX0VDQVBfU01UUyAgICAgICAgICAgICAgICgxVUxM
IDw8IDQzKQ0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gaW5kZXggNGRkZjY2MjYyYy4uYTBkZDZiMGVl
MCAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBAQCAtNDQsNiArNDQsNyBAQCBib29sIHZ0
ZF9jaGVja19oaW9kX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj5WVERIb3N0SU9NTVVEZXZp
Y2UgKnZ0ZF9oaW9kLA0KPj4gICAgICAgSG9zdElPTU1VRGV2aWNlICpoaW9kID0gdnRkX2hpb2Qt
Pmhpb2Q7DQo+PiAgICAgICBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlQ2FwcyAqY2FwcyA9ICZoaW9k
LT5jYXBzOw0KPj4gICAgICAgc3RydWN0IGlvbW11X2h3X2luZm9fdnRkICp2dGQgPSAmY2Fwcy0+
dmVuZG9yX2NhcHMudnRkOw0KPj4gKyAgICB1aW50OF90IGhwYXNpZCA9IFZURF9FQ0FQX0dFVF9Q
U1ModnRkLT5lY2FwX3JlZykgKyAxOw0KPj4gICAgICAgUENJQnVzICpidXMgPSB2dGRfaGlvZC0+
YnVzOw0KPj4gICAgICAgUENJRGV2aWNlICpwZGV2ID0gYnVzLT5kZXZpY2VzW3Z0ZF9oaW9kLT5k
ZXZmbl07DQo+Pg0KPj4gQEAgLTY0LDYgKzY1LDEzIEBAIGJvb2wgdnRkX2NoZWNrX2hpb2RfYWNj
ZWwoSW50ZWxJT01NVVN0YXRlICpzLA0KPlZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsDQo+
PiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAgICAgfQ0KPj4NCj4+ICsgICAgLyogT25s
eSBkbyB0aGUgY2hlY2sgd2hlbiBob3N0IGRldmljZSBzdXBwb3J0IFBBU0lEcyAqLw0KPj4gKyAg
ICBpZiAoY2Fwcy0+bWF4X3Bhc2lkX2xvZzIgJiYgcy0+cGFzaWQgPiBocGFzaWQpIHsNCj4NCj50
aGUgc2Vjb25kIGNvbXBhcmlzb24gbG9va3Mgc3RyYW5nZS4gaHBhc2lkIGlzIGRlcml2ZWQgZnJv
bSBlY2FwX3JlZywNCj53aGlsZSBlY2FwX3JlZyBpcyBmcm9tIHMtPnBhc2lkLi4uIGlzIHRoZXJl
IGFueSBwbGFjZSB0aGF0IGNoYW5nZXMNCj50aGUgcHNzIGZpbGVkIG9mIGVjYXBfcmVnIGFmdGVy
d2FyZD8gSSB0aGluayB0aGlzIGNoZWNrIHNob3VsZCBiZQ0KPmFnYWluc3QgY2Fwcy0+bWF4X3Bh
c2lkX2xvZzIgYXMgdGhpcyBpcyB0aGUgdmFsdWUgZnJvbSBoYXJkd2FyZS4gcmlnaHQ/DQoNCmVj
YXBfcmVnIGlzIGZyb20gaW9jdGwoSU9NTVVfR0VUX0hXX0lORk8pLCBpdCdzIG5vdCBlY2FwIHJl
Z2lzdGVyIGluIHZJT01NVS4NCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBndWVzdCBrZXJuZWwg
d2lsbCBwaWNrIHRoZSBtaW4oY2Fwcy0+bWF4X3Bhc2lkX2xvZzIsIHMtPnBhc2lkKSwgc28gY2hl
Y2tpbmcgdGhlIHR3byBkb2Vzbid0IG1ha2Ugc2Vuc2U/DQoNClRoYW5rcw0KWmhlbnpob25nDQoN
Cj4NCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlBBU0lEIGJpdHMgc2l6ZSAlZCA+IGhv
c3QgSU9NTVUgUEFTSUQgYml0cyBzaXplICVkIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgcy0+
cGFzaWQsIGhwYXNpZCk7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+
ICsNCj4+ICAgICAgIGlmIChwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4ocGRldiwgJmJ1
cywgTlVMTCwgTlVMTCkpIHsNCj4+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJIb3N0IGRl
dmljZSBkb3duc3RyZWFtIHRvIGEgUENJIGJyaWRnZSBpcyAiDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAidW5zdXBwb3J0ZWQgd2hlbiB4LWZsdHM9b24iKTsNCg0K

