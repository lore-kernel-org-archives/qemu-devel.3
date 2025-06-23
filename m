Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111F7C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 02:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTXAf-0000z3-OY; Sun, 22 Jun 2025 22:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTXAe-0000yg-3w
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:44:32 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTXAc-0004Rq-1i
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750646670; x=1782182670;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RjV68SAzYhI8ZZDSJs5YtTjh2IVfBFCztJw6egMMPCc=;
 b=IffNTH2k7vfAyOX852yrOEMvVxrAZSBabFCsc4d/FnSlRzyDVWWhDiXx
 duZf/h92wXJBR/8ETAqSA4DaY0pZxE4oJdsCNBHA2zHCciEfjzVg3kXgr
 UQxTFsXOh7WkueQio0lkgA/D+mYR1FN3zlMLrma34Qt0L/zPlJpycAKhj
 6NyrlgUtCwgdfTZmlhm2CVmBnllEDKHAT3amlCOT9NKGTmK4gX06ZuZHR
 rt8SkhSLN2gFjcKr1IecG9uuk5/WkNdcJLW/gfr2emONbBJpP/h26tpJB
 FWhSTvR7Sp7fimcwW6WFr7iSeXdc27o7Mhv4tunrwqzSBA395DZadce7K g==;
X-CSE-ConnectionGUID: +cQiy7Y7RiWNb/xXKiTlGw==
X-CSE-MsgGUID: 4IAAe2FKRPqan93tV+pYtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63892185"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="63892185"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:44:26 -0700
X-CSE-ConnectionGUID: H1p3mLqFQaKPLVubLck/4w==
X-CSE-MsgGUID: nbXkclimQuC0ISOcVE/2rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="152141610"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:44:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:44:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 19:44:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:44:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saBh1jsOSDn6dmLHC10hrdpLIfL01wrzQzj/+L6f72I3Iv3RcRsE0spvxaTRa41naa9VKo21rpvZdt9rdYnyaw8duM383f6ehyUe4FEanRn+UXN9rgVrxA9t6izbnaGU1vcZmvF6ZK4+pE8XrMmpGnXtiWXe5RgM1fwDMxX3L1c2Xi2ptvlm0vGZhnImaq10yI/EAWEeB9fPaawrPTQHJt4heAeTrdoKUHhRcEAWnBVH1I8vbiS6XOqUbqj0EK1GMOv48UBhR3yeF9UAYpjw14cxoBSeP7e+4tQyJStj0v7fTifLsHRM0VlE/BeTzdMjoMkEHthuIZEoHsTBwZDHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjV68SAzYhI8ZZDSJs5YtTjh2IVfBFCztJw6egMMPCc=;
 b=ZfwdKbTGwjsFLVMyIAhVwQYgMWlNeVqMGIxadXZtA6lddXcg+CddeQmdQtQSYsZ2CvYxBXBXMofB0a9OqiuVSBr6mFoHTPiI2J3umciihz4THmw70/gILKv6RXNPujBoY+1Px1YKv7umUWEKJenFFa59NAjmslg1qlZPPfZ9PajX97fLBBCD4mF4r6GXyHO+RBdxbRyW6Z/9CkCb53/W5mEuLrw2gFMHHmUxcqzg6DqkTaYMeivKGt/wtrqeTPS7C8OMxzG7PxgtyMsAQZQLvEVIffe9Hm5IiGiMrgoU0vYDyclD3eGla3IqjIHQMolJMdZqs6VX2K5AwfJAKxp9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB7386.namprd11.prod.outlook.com (2603:10b6:208:422::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 02:44:04 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 02:44:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 07/19] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v2 07/19] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHb4bQhvdo20suAmEqSjT9neJJeJrQL8+sAgAQYQ/A=
Date: Mon, 23 Jun 2025 02:44:04 +0000
Message-ID: <IA3PR11MB91362BD4B94B4B1D8106AB309279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-8-zhenzhong.duan@intel.com>
 <b860ed2b-fa73-45a6-9958-a4da0e5f3811@redhat.com>
In-Reply-To: <b860ed2b-fa73-45a6-9958-a4da0e5f3811@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB7386:EE_
x-ms-office365-filtering-correlation-id: 80bf71ef-686a-499c-384e-08ddb1ffd154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SlRqazg1OFdKQ0oxc0tubHYwQzhkYWRkR3ZkWCtINDliRGI1dnE5Q0xNdjkw?=
 =?utf-8?B?S3BEMDFveUZjbXg5Y3pHeTV5Yi9BRUJncnJ2cUFvbUN5bG91Y3BVaytIRFF1?=
 =?utf-8?B?T250N0hPMEpWcVF6NGZ2N1lydHAxVGhYck4yZ0MyWUYvU2RGVU9RNm96VEM3?=
 =?utf-8?B?azdnU0RqRkMzYjlPb0hWQUxjTUcrdTZIcklOWldoNGlBNURCNENXWndhTSty?=
 =?utf-8?B?aDFvNkFHMXBTc2QrdVUwQkhyTWRIYUxJNVBmLzRGTXJNNWZuVkZLTFhINFhz?=
 =?utf-8?B?dmE3THdqMzZmb3VpSllDYkZ6L2ZmWStabi9MT0pmck9ZTkJYMi80NURHSXc1?=
 =?utf-8?B?UXZHSmpGaHRxZ05YZW9NVXRRYWd0bHhVTEk4SG5uREFtWDkzWDQvK3JWNTJj?=
 =?utf-8?B?M1RCc0lPSkdoMWcwUkVBRDUxVUhaMmRBMzhTbGFmR0s5aFRiVyt5OEQxb0Ix?=
 =?utf-8?B?bk5jYWpSTUNYQnJDOHdpMy9yNHA5MSszRERzSFdSd0xOd1dYd0pXV3hMRWRF?=
 =?utf-8?B?MmxEZ29RY1ZQdU9WR0V1aWtNeFJaWS9oWEh3Vy9keFNoejBWRDNmaWgybjdu?=
 =?utf-8?B?dzhrNnEvK2ZiQVdqY3c1MUVpMSthaEYzVml5OEloeC9RWWk5TFIzdXp3azBr?=
 =?utf-8?B?Q3dkNVBCaEYvMlhjc2NkSXN0cG82dnN6dVRRRXpyQmZUZWhlZTRRRzNWTFZ6?=
 =?utf-8?B?SVpRdWNhbVA0ZjlpdFJiZGk4VEpYdUUvOGlhNnZRU1krQmd0YUh2Y0w2SzhN?=
 =?utf-8?B?bTVoQ2Q3N2J3WXVocGhNQ3BGU2xNNmJCYzJCQjBBRVZjWXhaZzBGbXkrR3lm?=
 =?utf-8?B?WklqYU9Vd2xyak9tQUx4dDBQRXhCVXJGV0hVS3RqOEtIeG9wZ3lMMDFTVVFM?=
 =?utf-8?B?Q2xRWXhacENrcjRGZ084RWJZYUh5NW82bWRValM0amRJYkx2dUthdHdqRzhQ?=
 =?utf-8?B?Z1ZZcWxnSFFtaFRGSU9FdjVqVFpPZWlkZFBham9LODJoc1ZoV0dkUnNUWUVT?=
 =?utf-8?B?K1FzZ0dSZngxRHlnQ0w0NE1neXFybnBPdzRIMWNhdncwdWFCM2dqRkJuWUVh?=
 =?utf-8?B?ZittQllpSURrOHdDVndOUDM2djNwcm9ib3JQN3RGTVlXQ2xjTVYvdVFNWlE2?=
 =?utf-8?B?b2NzQ3VlOEVLNGpRRDg4Nm5oVmhxRnA2YjBEd1crME5ySkM4UHdrQklRZ01m?=
 =?utf-8?B?N1BPbkZiZEh2U1A5QVVDMjJQOEU3TTh2RWpRNEtWOHRBUC9hT2ZJR3BaLzVZ?=
 =?utf-8?B?aFA5REVJNTdCSXJxQlhaOTJDRUFFUUxweTFicHJkVVZJUUwzTW9pMUd1dFAr?=
 =?utf-8?B?dXg2Z3U5czA2T2h1WXRKM0lIMGtiVkd4bHRZaWN3NW56cnRFRnZiQS9EK3ZU?=
 =?utf-8?B?VnE3cFB4bEZvUkdGL3IyRGk3d0ZUY0ZhTEdpQ08rTTQrSUJpRklmSkFhMWlE?=
 =?utf-8?B?TTRhYk9rek1CNDBCZGx2RkN1NlAzQVFDSlg5cmNzOUJFL090ejNtZWJES2sv?=
 =?utf-8?B?a2VuSHN6ZTNWVGk2N2pyMFZReFRqNkJEVUdKTkwxcTVoa2tIQ3ZQbElSb3ZS?=
 =?utf-8?B?MGFSTkFUY1dCVG5kK1RGQlErZXVHdEZweFU5ZUsxRmJldlU1ck1RM0l6Vlpv?=
 =?utf-8?B?eUFCMVIzOWJSclVHd2RXT0M2MjEwVFZSbFZ1S1J2MkJtbE1XYUJpRjZHVUlx?=
 =?utf-8?B?aTJFZkFBeFdjTnd1b1pBcENQQ1d0YUM3U1V6ZlZhbFhuTlVKNWhhdWJXQzE1?=
 =?utf-8?B?aWRxSGlwcUcyU2xQeVpRMTJrTmxNUy9qRm1GQW1TKzFOdWsxYVBFTnd4eDdS?=
 =?utf-8?B?KzlFR0VrNDZnOVlqN1FNQW9sVUt4V1cxTnA4dHJOZC8rSVlpWWxtN1ZJd3ZV?=
 =?utf-8?B?Y1ptSkNLcDdaSUxPLy9PSDlxU1FuVTh1K2xtdmRTaGp6ZDBiRG5aZkN2UHJh?=
 =?utf-8?B?d1RTcGJMTVZuOTQ4eTNuWnhFVnRhMlRsNmNCcnVxdUlvVUE5WWxEUWlNSzVR?=
 =?utf-8?B?empZNkVqZDZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wnd1VHkxdFhzSHZaMGNTN20wUGdDS1Exa25IS3g0cVgxZ2Z0cENrbDhiajBt?=
 =?utf-8?B?VUZoSnVkYjBBQXFSVEdzdnArd0NRK3pIN1oxZE5BMUxQWHNhTEt5aUk0SFZm?=
 =?utf-8?B?aUtpRUtWQWZLM2xzY3FoZllCMGVvOTVvelUwekl2VDhQSG81WVFrcm9vd0pv?=
 =?utf-8?B?ZkFoNXVCVFhGYUdSMGRZN0o3SVBWaFZMdWx6dFk0SUVob0piemxVWm1VaWh2?=
 =?utf-8?B?N1FxOUJxejkvY3B2NU1jMTVnbnhlU0x6dDVwOWtYT09NMmNBNWo1K3JDL1l5?=
 =?utf-8?B?eTF0N1MveGN0d0xJcWZ0MDVZYURXL1B5dEJ4UFdrRmFveHJJajIybnduK2Vr?=
 =?utf-8?B?MzZjaS9xeVFXYlRaS2lRdVNIaHMvSzl5QndMNjIyUlBDVHBYczYwK2RxZjc5?=
 =?utf-8?B?Um1hbytBbkFMc2ZKUkl2M1MxTEdQOEVJRnNtaGJCcm5jb3NRbk9ad0VITmVv?=
 =?utf-8?B?S0ZIdFVxNWozT3R4THdjSlpxUWtHak1lNVQyc3ZiQkRnQStjREdRMFk3MURV?=
 =?utf-8?B?NWd4U3JkSWZOQWEzT2REdDlRdE9nTkdYTTlyeDhLYTNUNjdvQ1U4aWVqcmU5?=
 =?utf-8?B?N0dJUmpZV1EwL1RtZDZUUjFyYnpMUGRBTXhsR00vak1tVVkxNG0waXE5cjVS?=
 =?utf-8?B?M2txM0N5emt6aG50N2dvRDlyZ0JTYXQ5RlF4SG0zSHBkeVExSEFGTDh5NlFk?=
 =?utf-8?B?S1I5NVp4QjI2ZmxMWEdZYklMV1hrS290eEFqVjJybHc0V0lLRVBqb1hTMGQx?=
 =?utf-8?B?dnZYVmRHajBTaXF2NFBxNU8rWUtRRDZSc1pHOUhnYzJQNzJ3eEZoRGdMYUVE?=
 =?utf-8?B?bGdYcW1tdVI0NlB5bmdEbmpyVHE3Sk1NNGZBZ3R4WkdrazFIM2hEQlVJckVs?=
 =?utf-8?B?Yzd5MW9GaHdOZ3J1dEl2N1N4TUpHdU5seWF1RUVpYlowY0I0S1RtMktlTW16?=
 =?utf-8?B?MTVJZEtiaTAzU3NsdWh3eVBpbklmYnVHTmdyNDROdUhsMjVacG0xQnRuMExn?=
 =?utf-8?B?STJHNWEvc016UXJ3YTNkRHRLdzlaNmpQZnh4N25kaUJIcVRGYmVtT3VZcHJS?=
 =?utf-8?B?MHdBSUJUeHA1WUFqN0VvUVlBd2lIVTlMNXhDVVhDalJYWG12clQ0SGc1a1dE?=
 =?utf-8?B?d0lkalBESzY3eldFZjRWcXpWZ29JTmdjVk1mVS9KSEZzSHpPRm1DQTQ5SFpL?=
 =?utf-8?B?dDZjRFBiMlZpUU0yQzBWck9BWnhITzRSanFvM0NMdy9ZUEQ0dTVWc1JvQ012?=
 =?utf-8?B?YkdzK2dNUnhWbWxFUDk2UGVIZDE4TjkrbUhZSm8xalVlNEY3Y0tsSDdtaVdS?=
 =?utf-8?B?dHZPLzdPQ2FIdlkzRnJDQ0RiRVlnczVrWGdBeW9ibTgrT2UyQ3NUejE4U1NF?=
 =?utf-8?B?MVBqVEhGNXdJNU5XN01KRDNubmVUTjdFQ3Y3dmhvQ3RLbUhlR3RXNDVZWG5D?=
 =?utf-8?B?OHcrNVFwam51Tm1QRzFLMkFxTmFVcGlqb3AyRDRhUjFYNzF1VFVFOHB2L2Zx?=
 =?utf-8?B?OUk0T3FDaG4yZEZDdm5kVmNZSkp4anBDWml0bGllMnIxUE1nRjhueXMzdlM1?=
 =?utf-8?B?b0ZpZ3Flaldybkw4WU5mS2Z0QVJ1elU0T0lEbFlKN0dTak5pSzcyZGNuRVlr?=
 =?utf-8?B?eDF4aUdBaytpeDNqWHhzRHhyYkM5ZFVnZjhEdGhORjZ4aVBuVFIvYUNVV0xn?=
 =?utf-8?B?ODNmcHJMWU1LKzZsdERYY3QxbEh5WFFaZjQ0NTk3elBUVkNUTFF4VlRZUytx?=
 =?utf-8?B?RnBYUmluWlc3SEx0anR2dlpYY1oyWVBBWWdzOGFDd0svNDlmY0hFak5tUSt4?=
 =?utf-8?B?VzE0N3pSUkxqYmN3UzhmcHNzdWV6cnMwS0dJc0wveFRDUzY2OXVVZUtQakFi?=
 =?utf-8?B?RXBhaFk4ajA1SHNGTk9SZmVXbExkczRTejcwOGx6UmlxQzRLcjQrRC9KbVNr?=
 =?utf-8?B?SjJyV3hHN0tBeEFMWS9OV2NBcWV0c3duWnlrMFV5K3NJUTcrRFR5d24rK2VH?=
 =?utf-8?B?S3A1aHhLcWFhZzZwRk03S0JyMURVZThVbUtUYTM4TVJnOVFIdkV5dnU1Wkxs?=
 =?utf-8?B?L1VEdDdhNFpETXVBNXJvYXUrU2ZsbGFWalhVRnpIRmZaL2RCMXAzRUpGeEdo?=
 =?utf-8?Q?iT4aJWxlf7oaRy9rRIajyXZDf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bf71ef-686a-499c-384e-08ddb1ffd154
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 02:44:04.3163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVvTCwpoqt51PtBkBDdOuSGdg2u+I2QFDsxmiKIpiQ4xevkyVuywMS8/YbJ1IxUAMX6lPhtyeaK7xWItaGBe7O6yqmrPAnjZpBRw23P0zH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7386
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA3LzE5XSBpbnRlbF9p
b21tdTogQ2hlY2sgZm9yIGNvbXBhdGliaWxpdHkgd2l0aA0KPklPTU1VRkQgYmFja2VkIGRldmlj
ZSB3aGVuIHgtZmx0cz1vbg0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA2LzIwLzI1IDk6MTgg
QU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiB2SU9NTVUgaXMgY29uZmlndXJlZCB4
LWZsdHM9b24gaW4gc2NhbGFibGUgbW9kZSwgc3RhZ2UtMSBwYWdlIHRhYmxlDQo+PiBpcyBwYXNz
ZWQgdG8gaG9zdCB0byBjb25zdHJ1Y3QgbmVzdGVkIHBhZ2UgdGFibGUuIFdlIG5lZWQgdG8gY2hl
Y2sNCj4+IGNvbXBhdGliaWxpdHkgb2Ygc29tZSBjcml0aWNhbCBJT01NVSBjYXBhYmlsaXRpZXMg
YmV0d2VlbiB2SU9NTVUgYW5kDQo+PiBob3N0IElPTU1VIHRvIGVuc3VyZSBndWVzdCBzdGFnZS0x
IHBhZ2UgdGFibGUgY291bGQgYmUgdXNlZCBieSBob3N0Lg0KPj4NCj4+IEZvciBpbnN0YW5jZSwg
dklPTU1VIHN1cHBvcnRzIHN0YWdlLTEgMUdCIGh1Z2UgcGFnZSBtYXBwaW5nLCBidXQgaG9zdA0K
Pj4gZG9lcyBub3QsIHRoZW4gdGhpcyBJT01NVUZEIGJhY2tlZCBkZXZpY2Ugc2hvdWxkIGJlIGZh
aWxlZC4NCj5zL3Nob3VsZCBiZS9zaG91bGQNCj4NCj5Zb3UgbWF5IGFkZCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UgdGhhbiBldmVuIG9mIHRoZSBjaGVja3MgcGFzcywgZm9yIG5vdw0KPndlIHdpbGxp
bmdseSByZWplY3QgdGhlIGFzc29jaWF0aW9uIGJlY2F1c2UgYWxsIHRoZSBiaXRzIGFyZSBub3Qg
dGhlcmUgeWV0Lg0KDQpXaWxsIGRvLg0KDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oIHwgIDEgKw0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDI4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDI5IGlu
c2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCA3YWJhMjU5
ZWY4Li4xOGJjMjJmYzcyIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC0x
OTIsNiArMTkyLDcgQEANCj4+ICAjZGVmaW5lIFZURF9FQ0FQX1BUICAgICAgICAgICAgICAgICAo
MVVMTCA8PCA2KQ0KPj4gICNkZWZpbmUgVlREX0VDQVBfU0MgICAgICAgICAgICAgICAgICgxVUxM
IDw8IDcpDQo+PiAgI2RlZmluZSBWVERfRUNBUF9NSE1WICAgICAgICAgICAgICAgKDE1VUxMIDw8
IDIwKQ0KPj4gKyNkZWZpbmUgVlREX0VDQVBfTkVTVCAgICAgICAgICAgICAgICgxVUxMIDw8IDI2
KQ0KPj4gICNkZWZpbmUgVlREX0VDQVBfU1JTICAgICAgICAgICAgICAgICgxVUxMIDw8IDMxKQ0K
Pj4gICNkZWZpbmUgVlREX0VDQVBfUEFTSUQgICAgICAgICAgICAgICgxVUxMIDw8IDQwKQ0KPj4g
ICNkZWZpbmUgVlREX0VDQVBfU01UUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQzKQ0KPj4gZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4gaW5kZXggZTkwZmQyZjI4Zi4uMWM3OWVmYzFjYiAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtNDAs
NiArNDAsNyBAQA0KPj4gICNpbmNsdWRlICJrdm0va3ZtX2kzODYuaCINCj4+ICAjaW5jbHVkZSAi
bWlncmF0aW9uL3Ztc3RhdGUuaCINCj4+ICAjaW5jbHVkZSAidHJhY2UuaCINCj4+ICsjaW5jbHVk
ZSAic3lzdGVtL2lvbW11ZmQuaCINCj4+DQo+PiAgLyogY29udGV4dCBlbnRyeSBvcGVyYXRpb25z
ICovDQo+PiAgI2RlZmluZSBWVERfQ0VfR0VUX1JJRDJQQVNJRChjZSkgXA0KPj4gQEAgLTQzNTUs
NiArNDM1NiwzMyBAQCBzdGF0aWMgYm9vbCB2dGRfY2hlY2tfaGlvZChJbnRlbElPTU1VU3RhdGUg
KnMsDQo+SG9zdElPTU1VRGV2aWNlICpoaW9kLA0KPj4gICAgICAgICAgcmV0dXJuIHRydWU7DQo+
PiAgICAgIH0NCj4+DQo+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+PiArICAgIHN0cnVjdCBI
b3N0SU9NTVVEZXZpY2VDYXBzICpjYXBzID0gJmhpb2QtPmNhcHM7DQo+PiArICAgIHN0cnVjdCBp
b21tdV9od19pbmZvX3Z0ZCAqdnRkID0gJmNhcHMtPnZlbmRvcl9jYXBzLnZ0ZDsNCj4+ICsNCj4+
ICsgICAgLyogUmVtYWluaW5nIGNoZWNrcyBhcmUgYWxsIHN0YWdlLTEgdHJhbnNsYXRpb24gc3Bl
Y2lmaWMgKi8NCj4+ICsgICAgaWYgKCFvYmplY3RfZHluYW1pY19jYXN0KE9CSkVDVChoaW9kKSwN
Cj5UWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQpKSB7DQo+PiArICAgICAgICBlcnJvcl9z
ZXRnKGVycnAsICJOZWVkIElPTU1VRkQgYmFja2VuZCB3aGVuIHgtZmx0cz1vbiIpOw0KPj4gKyAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmIChjYXBzLT50
eXBlICE9IElPTU1VX0hXX0lORk9fVFlQRV9JTlRFTF9WVEQpIHsNCj4+ICsgICAgICAgIGVycm9y
X3NldGcoZXJycCwgIkluY29tcGF0aWJsZSBob3N0IHBsYXRmb3JtIElPTU1VIHR5cGUgJWQiLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICBjYXBzLT50eXBlKTsNCj4+ICsgICAgICAgIHJldHVybiBm
YWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAoISh2dGQtPmVjYXBfcmVnICYgVlRE
X0VDQVBfTkVTVCkpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkhvc3QgSU9NTVUg
ZG9lc24ndCBzdXBwb3J0IG5lc3RlZCB0cmFuc2xhdGlvbiIpOw0KPj4gKyAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmIChzLT5mczFncCAmJiAhKHZ0ZC0+
Y2FwX3JlZyAmIFZURF9DQVBfRlMxR1ApKSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJTdGFnZS0xIDFHQiBodWdlIHBhZ2UgaXMgdW5zdXBwb3J0ZWQgYnkgaG9zdCBJT01NVSIpOw0K
Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArI2VuZGlmDQo+PiArDQo+
PiAgICAgIGVycm9yX3NldGcoZXJycCwgImhvc3QgZGV2aWNlIGlzIHVuY29tcGF0aWJsZSB3aXRo
IHN0YWdlLTEgdHJhbnNsYXRpb24iKTsNCj5zL3VuY29tcGF0aWJsZS9pbmNvbXBhdGlibGUNCj5z
L2RldmljZS9JT01NVQ0KDQpXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

