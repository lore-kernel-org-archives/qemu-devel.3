Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC47C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 03:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJOcM-0000WV-VW; Sun, 25 May 2025 23:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJOcL-0000VJ-4D
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:35:13 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJOcH-0005QN-JU
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748230509; x=1779766509;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ltWRkHiza5zkCSrRKMH2439LztvUHfSv78CRMfpLZ20=;
 b=VYWBx2dD49YMnmQolMG2208LscPfsBwO53Ue59JdcWQpm1JbQd/HWeGJ
 tk1u1Pb5BXU6fNa6la8XtVq1N4TIvYhnc6mSBeoIunD4QYJcXbrqud230
 NwMcf9vIon3gJAC0GRuLDXlAqRSwVI+nKQS9qQ6f1JUmFazbRXUccUsUA
 +TzVu4hmG9SnAjl0Xw091L7cftYXHGJula/OHqn2xoTVfExFf0D5PfmF/
 ZRD4CkZ3Bl9KksniwtXEVvEBihgewhix5jcZEr3xPnfXPh1q3w0uycENm
 bMzJxnwZ+7/RWnLhmLi+E4vQM/VUU8e6GHVfpHxvauJ2WeRMgbR+e50SW Q==;
X-CSE-ConnectionGUID: 2ZY+Inl/Qg6k5ULsFd//dw==
X-CSE-MsgGUID: smbkH4YhTe6Sep2Z7aHI4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="61551160"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="61551160"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 20:35:04 -0700
X-CSE-ConnectionGUID: zbo3ANYGQWyg2oDAIIyBrQ==
X-CSE-MsgGUID: 8Rrmyj7eTNqR5xKYgoypEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="147393582"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 20:35:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 May 2025 20:35:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 25 May 2025 20:35:03 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.62)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sun, 25 May 2025 20:35:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbtXRbTpMCaslnN+zF7bOdDaLuTzNWh4fHi/ZUky91do1xpqJ6v4yR7tryoGd3Pkv1wYeofOa+Yu5B+UfQpH5ctEWuZ3osoXVKBvNy81ERX56p6gTvo5yMlLGn5RJ///VzroGTAQLhfTeQ6R5VSsRJaSzqPDSPK/RZZ9NOEPtUap9IFQMt7XpMIe3A0/ggmSmsP/IAAAoYA5HEeVBFJPT0DcrdPi1I3+32Q1V9470T68i2Kab1JqBcQrf8rCO2phr6pzKdfinAkIz/7geyktTwKIQMLHvofTOaHJDdQVFOQQE64ClRQt23KrLVl01q9OuFUP/6GpsvmnnKxqu2Xrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T/aFsLx1oB7BXW4ufM4aOl5ZUACMJ1EvGrb15//4C4=;
 b=E5cC3GkkvQQDFclFlBGACA4IrrHn77Xkt/jAa9y7dcLj2tyOaofdNO3rAYP+Ftr3X96+nBhVPPvPkkp/0AeEP09Xl4hXtcdAyxVhH++uKL1uQRzGa/V05nRa2j8DrVn6ZRCURphZhTBS3EWjpev3t/zymaPC1FAHi+Tf2FQnQyAMS0Tc00KnU7NGHIP0nPPT6xwb+WqgoKEq/E0z97EldsnjvrmSbFsT3fhtX9cvfR039ZtRLztYYAL9O3hlqONpxxmgq1SB8D4MhXebnhI014eNmv/pPTgMBe/14lbkdcYyCkcuS+RkbxaJx5EygcB8dm2VRjG+rwBiB67OJ3XlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV2PR11MB6047.namprd11.prod.outlook.com (2603:10b6:408:179::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Mon, 26 May
 2025 03:34:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Mon, 26 May 2025
 03:34:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAB6U9CAAOAeAIAFOtoQ
Date: Mon, 26 May 2025 03:34:32 +0000
Message-ID: <SJ0PR11MB6744E48B17DD7980076BB4BF9265A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <SJ0PR11MB67446AF2F48F35D64E98B3D69299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aC97Kn+M5/9/naY0@Asurada-Nvidia>
In-Reply-To: <aC97Kn+M5/9/naY0@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV2PR11MB6047:EE_
x-ms-office365-filtering-correlation-id: 7e8abd77-dcd9-4270-0e6b-08dd9c063aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4OJUhS6lq4NUS3QP3sYOUubKvCx432JzdZX6Y0tfG4hO3D1E3E/AnvIToNYU?=
 =?us-ascii?Q?vmxzLbLaz9SYKrf3lXJsiOcS5V+M/G1UMv+KDjOjH0wVRK/Wh2d23FzEl665?=
 =?us-ascii?Q?RjBQlpUqCGhYYFoNYwoVmyD1oYxMtYq5RB2ZYCMeOAd8RhzezkR7AJo8U4VK?=
 =?us-ascii?Q?0NnxPhiNZWGBUiuy3r7kHThdGQoESCbVlLCTK98QULsmjtJGuKg3aP2WhPii?=
 =?us-ascii?Q?I5XrOMzyZziophCY5T3H4SFjQ6qOp6NqtTjlNvD8UYlPUX/HSuwgoTW4td2T?=
 =?us-ascii?Q?Um0+T4n7qnyZEd2olybZndLbCcZyLqX6Zyaq1AgXEv60zUuGThy3Q1zZeg01?=
 =?us-ascii?Q?1H+e/BoorAOwpjP23seEN/TAc2B2qoCByvTQpxwwphFz7EjY2thtXdekjeod?=
 =?us-ascii?Q?JY4vCLBiK3+fHafifXwV4xykHcexdNPrCotDMxdtAYrcVgfgDuqEol87EtGD?=
 =?us-ascii?Q?QAJY8XAToSMamx0aHLqHBzmZc9gHtcur+pfWzHRtlYTM7ADHZEWCHV2qM5ED?=
 =?us-ascii?Q?+Ws8tvoY0cE0O1pOH4rqpCsuL1e7Rl85aeBwwHMLESQ/Ld2WlcBNt6EqvmoR?=
 =?us-ascii?Q?rFuj/FX2WsnQWXcMWkuVXiY4piTrmIuT8atji20iiqm4yddV/alDrrq6Qt2u?=
 =?us-ascii?Q?kHT3y0c4vnjNO9H34wUylLKGT2rdZsrDJcONUl3LUykVgG0MREZNYGbmSfvd?=
 =?us-ascii?Q?OcBw0yIXK+4rzTKW/nLnzplMuBoL+NiL/kK88LwcodzUBUPlziEkqGSvUfDx?=
 =?us-ascii?Q?NN+S08IGMPbc43S2O+mfWvaVFIDujXd2JV+HGlKkTEeU/u0LjR7gG5JUt1hF?=
 =?us-ascii?Q?dKhJk8d5PVYz4OS4Fx6O8xhfg4XKzjM7JiTYZHekHI1lu95sc52o4c+f0nE1?=
 =?us-ascii?Q?IabzjQ0McQYtBROAa4Vxzf6xywM7yZrS/VOIpPZxCYGiEZ9IF1EQOU7WooAh?=
 =?us-ascii?Q?vVdYQNxcfuvp8TKg6ihTnO5Az4d9tkKHWSuCmLld38gI6Y5oTwr8FscaDagC?=
 =?us-ascii?Q?jWx/5GXt1qqEZUF/Z18IRMv7ZhopqA6YCKLskrgAD4D50EqyM1BvhT76ZAOM?=
 =?us-ascii?Q?+nsh/M/DcmVzYNZoCHL5BB7lvdVkPtnrRzbd0I1CZhoYnACqJ/BWb5xscSJ6?=
 =?us-ascii?Q?JGDwHL9+UHuqwX4bYE82DWbUqOKfZKecECn9JiTIE1IkUYU38nKnG6xzonTN?=
 =?us-ascii?Q?Sso13+tAUqzvL57qgzOtNoPCL8ZMJR+9Wm2xLNitY2Zq/L8QqAVQOWM9TSwy?=
 =?us-ascii?Q?hEWvOGpUXntf7zxjDlyH7FqY+3jBacZ4Hls2OQ0foI2yUdP0U4r9eIA/Pbrf?=
 =?us-ascii?Q?GcQq+saLGWEdSfcLI5KE2ptePrG9IL/VI6Rug6z8STU8WeaUTQQ8GJ0G4tHk?=
 =?us-ascii?Q?UgMJ2yBL1OriMrBhcv827vV3DNOUVsDioM5Z9oeGg953IeP9FPQ1yBiKB7cD?=
 =?us-ascii?Q?0BxXwstqYKgNzpL0ETJ3iOkKDJQpFnts8S/YFXfBMH320SfZ7fKPQQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bmVttihrjHOE+uv+/M1ReSivhJj8rkvwTAg2rbYZCxKd/jZTk1aoH+gsBUob?=
 =?us-ascii?Q?RUQUAynhHm08bqSQVWN0jtfKz9T7aRI2R2y5qluoa9Riyk3HeySTUOWdZ+p4?=
 =?us-ascii?Q?b+BKR/XoZejHFkUxaungOI6aiKwz3GPd8O7KvjKpziTAeygm3l8MzdymXsFJ?=
 =?us-ascii?Q?anL3tWxCnWQog+lA1QWGiMbsQ7YxF6JbNB6iAUSrPt7SWC1TqUjw82C2CqtU?=
 =?us-ascii?Q?saR+0VZNL+zALJEGFpoDL9EC5JMVnhY7fwVwDCxKwQ7ClwkExClIrEVXzmfG?=
 =?us-ascii?Q?EXfBu9a3c+OeiVOvLVOaOgwzTXTTiKivdZKaTC2tFh23MEoCU9XOXAkXYD4M?=
 =?us-ascii?Q?7E51SII0iy08ok0MCusmDZ1OVNCUcUQ1JEqQCCEnB5pZnj2egGKtj6OPylho?=
 =?us-ascii?Q?C6XJinTw4QXBS4BGanRyb3IiwtE5FQfwYEqmWP8TlgeZAQ3YPMHR6BxnTvas?=
 =?us-ascii?Q?mnw5VVlK0oPjGQbDWsoYA/GGEYwJ1+t6njyi+s9RKGu3bEl3SHGkN3QcNuYp?=
 =?us-ascii?Q?odvvAXvWpESzyRioZ/SWkjr9UhEgXLYKYBUd8crX1pQtDggfD/BEQojHGpAv?=
 =?us-ascii?Q?wVqsN+844GxV+PDEEQ8hFm5Xr5LVFPGDP08g04NlJPjJ8vebSEaTSaAdzBSC?=
 =?us-ascii?Q?B4p26azJt1iKfZI49TniMmDI2lANhyvt620B2WrSQpTVUSFOi/6f4qWjaCbi?=
 =?us-ascii?Q?WxnxGFoKAnKGDVuXO6GoqmzTUAIvIaQwLp5BFvGmtgc/6MShMuRIUsiHav05?=
 =?us-ascii?Q?Rh+pl6Iv8irWRA1tRR10GXRms5akLWpoYo6NzFh0dVJ1GbvtblhVAEIUZ7Cp?=
 =?us-ascii?Q?uJAGETb7bUl0rB0CI4+UEymVKQK5jvnXGME0OouWf6n+StSNNGNG7MMPWkwb?=
 =?us-ascii?Q?SHIlI54REYtzfvkw5xN0EO8JhKsAGW346Lwq55jjtsPBWTuXLAt3frL+/WEU?=
 =?us-ascii?Q?prIY9MLuXaIO9I3wwqTpit8W9mezdq31kiJ756/KZFXVzNboG4gqwX5zu+Iy?=
 =?us-ascii?Q?zbKn8L/gQ06fj3n+oOOpi74ZCLiYSrces+byaMeb4BO1pkoWLRjE1iJ9vcLF?=
 =?us-ascii?Q?cSjO7xv27edxsBhW7ST2IscszM8/ZbxjHtPEJ/dhD37U5fGfZmzR2hc13Znz?=
 =?us-ascii?Q?TvbJeHznSVbh7S2TvgwCpsHprBmJ5gzVfnIaPRu4Jik6beLZePxF2FFeFXe5?=
 =?us-ascii?Q?9G8Aw9om0Ziltdl9sgHn5QYbXC3cd97jIKK9CpFu+Ywi9UQXjZy0KJs37Y3Y?=
 =?us-ascii?Q?QQSqaYmKE4bdf1XdgdB078XPUxiCjR1vy9fhrruBk/xuTgnXzMRmWYNuH+Fv?=
 =?us-ascii?Q?py46vin+YL5Hd9Nopf6fdkL6i4KVy/+MIHLW0k2qo9PETsZ9334rBpW6sZmu?=
 =?us-ascii?Q?02HWiyIzvab1Xj9/aZV0UT7PONiU3EOhM6L5cdeeFJ2B2WalGlSBP3g2zpDM?=
 =?us-ascii?Q?9bqxoR+VmW/e0ERv+G7PDaASXoekas2Pw/XXJFOj3oALB4OePljOw+sSTFtq?=
 =?us-ascii?Q?8tbL5BdHhsYGH3nWUVQjU9SxlymUGCaIakrSn2UIE/QSa8WLuKA90EdkK+jE?=
 =?us-ascii?Q?Hrfq/Oe8vfJmgWDP/XvqlUH2a7ZNRXVlsEM/tVVj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8abd77-dcd9-4270-0e6b-08dd9c063aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 03:34:32.3698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iJPJyTZSmQdYaVarCVgVqlqCpo6jEHjqeXOoahVVVm087Dkt6GeOEIrVSf1m00C4YQQFo5OdkjHzywbuWJwJmkWGrwSQY+oYOEJbQUbHxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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
>From: Nicolin Chen <nicolinc@nvidia.com>
...
>> >I think you did some substantial work to isolate the get_hw_info
>> >part inside the iommufd backend code, which looks nice and clean
>> >as the vIOMMU code simply does iodc->get_cap().
>> >
>> >However, that then makes these direct raw backend function calls
>> >very awkward :-/
>> >
>> >In my view, the way to make sense is either:
>> >* We don't do any isolation, but just call raw backend functions
>> >  in vIOMMU code
>> >* We do every isolation, and never call raw backend functions in
>> >  vIOMMU code
>>
>> Iommufd backend functions are general for all modules usage including
>> vIOMMU. I think we are not blocking vIOMMU calling raw backend functions=
.
>
>Well, I am not against doing that. Calling the raw iommufd APIs is
>easier :)
>
>> We just provide a general interface for querying capabilities, not all c=
apabilities
>> are from iommufd get_hw_info result, e.g., aw_bits.
>
>Question is why we need a general interface for get_hw_info(), yet
>not for other iommufd APIs.

Because other iommufd APIs are already abstract and hides vendor difference=
,
but get_hw_info() is not, it returns raw vendor data.
This makes consumer of this raw vendor data have to recognize the vendor da=
ta format.
For example, when virtio-iommu wants to know host iommu capability, it has =
to check
raw data from get_hw_info(), we hide this difference in the backend so virt=
io-iommu
could just call .get_cap(HOST_IOMMU_DEVICE_CAP_*), no matter what underlyin=
g
platform is, Vtd, smmuv3, etc..

>
>IIRC, Cedirc's suggested a general interface for get_hw_info so the
>vIOMMU code can be unaware of the underlying source (doesn't matter
>if it's from iommufd or from vfio).
>
>I see aw_bits from QEMU command line. Mind elaborating?

You mean aw_bits for virtual intel-iommu, that defines the IOVA address wid=
th of intel-iommu.
We need to check aw_bits from host intel-iommu with virtual intel-iommu's t=
o determine
compatibility.

Thanks
Zhenzhong

