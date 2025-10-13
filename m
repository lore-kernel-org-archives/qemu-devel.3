Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AE2CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8CRm-0008Hn-Fc; Mon, 13 Oct 2025 02:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8CRj-0008Go-NU
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:54:15 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8CRh-0001VF-Aj
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760338453; x=1791874453;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qkVTSqp216+2NK5PEMu5v8cbmEKncD8PPbx3G0NbcFo=;
 b=l7YbWBI83H48g08xuaEFRMtC6xciZYC7DP2wJObUTp/OauO90AWShtNv
 EgmhaQWZhj8eKtRIgHSb/0izNGA+pZ7SKlJg2Q6NX3QQHVnkdcslZNvUu
 ZgmgaNYXqx8Gw789+1k4BZkeU58K1mkOKvVuDkCUzKhSzWn5pSXM/TZ9S
 5v1kFf7lRjwIxCV6DzTvA34krgdPlW88iwYwG+opPxH1Db5xr/GexcM2k
 qmCtSJBH8Qtivcdhb6Kudaoh32bNmQAEC+29OHBbDikvLSkzu8YY7dveD
 ijs/UAY6erpq/yrV3knU2cb+wb1aXtQ/9fZ/Y3Curf+D/naWBnca/jW/k Q==;
X-CSE-ConnectionGUID: YFSre0cOTYC57ak7nfGMaA==
X-CSE-MsgGUID: UfTZ7vw3QkmWiTDqJq85eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="85096675"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="85096675"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:54:08 -0700
X-CSE-ConnectionGUID: tlmsqBo3T5S2Tr3EOBau/Q==
X-CSE-MsgGUID: FUlZKJkNQLKJxfo25QIjaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="180646444"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:54:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:54:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 23:54:07 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+S2p34YquIrY3bMDw/hnxddZHPVzqjBuErwIH5c2/vCCv+9M7hztRPMz1w87Z8kvFCAkUbnAMTA3HUtDlthPfWKHhAi0ahdPBpvn4Zkq2xaD7zyGBkDOaKl5miDXfhNKvMaSQJIzmZk10i4tgFvR69rdnPbofP+w1KEgBqVxiJ4pYpy9bEGTiKvliC01/68UnXQs0nZQOCJ4WJEYwcuc7ZYc9RehE1iBm20DlsXIm7T6daWc1+xsZu8EuNUmD2nK5ZUst3+kTsGEaxhGVJcQEiQPAm/pQHs0+xlC4gX56PjdvH8JPRaJleOfv/m7HzHsV+bOO2RR76NOfeMdUgi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkVTSqp216+2NK5PEMu5v8cbmEKncD8PPbx3G0NbcFo=;
 b=km6m8cfGb1AtPecIz5fk4NqKKy7/0m43idL63B99VjlR0G0AfZideNYP41OQGEoyS8z13fi4i6IZJR5vocAvdT/G0QEuxOGQZPm8BeP0b8bhlb2CgRtdmk8M+m4NcVu1SWAdaoIBPagWZfl8KTq4nlnaNfG1f5WvrD66mW11+9OIaM4eSK3XgbX6LQjnnZMv8Uy6xu6JHxO0t3HVsdaI6sgiLNhFoRJJEpJfbPyVRciADmg2ynR7cJf38cR/R0UbWKqINM9I7Y+WOJ0EWaOD1XVVfQHlRRNmXnbVpVf7ss0AGa/H8uG7pmZ1QnAizkuhOF+JftfdYSITgvIKldlKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 06:54:05 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:54:05 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Topic: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Index: AQHcNL+RUYjirTlu+0+SWGS5LfcOTbS60JoAgAQ3pzA=
Date: Mon, 13 Oct 2025 06:54:04 +0000
Message-ID: <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-3-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: 338c1da8-0ce3-4594-88f3-08de0a254cb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dM5h399u1kJIwvRNSYRpJl/n89ri8xn6qdZCuLoK0X8lduy7YoThKDxtgw?=
 =?iso-8859-1?Q?bHl9+ZSntv4XD2SOB+eZeUqd3a7/3P2x2TZ8xxU1WDj+wq0mBgBJRHmQWB?=
 =?iso-8859-1?Q?M4gMfMGzmcl+ifqwfIsezoZHqJfxxEEEEj0cZMq8BmCp/4WLDmE67Lwhcz?=
 =?iso-8859-1?Q?W+hwRuX91W/QbOCIBu2BqApW2pwCAjbeOhKJKgeX3kw5H2LDZhfl2OURUE?=
 =?iso-8859-1?Q?2MpDfX78iFO5Y8Y0VgEaOxlD8ZxgCnmlF4JAjBo5Nm0F5EVN4RffKRF0ME?=
 =?iso-8859-1?Q?LTd/G3ohSCQ6Oxgh7nw0DrmcTrMNZjfLvcQn02U+z2AeYQuHzA7gMGZWPd?=
 =?iso-8859-1?Q?btiG3KMGY/J2dYsfuxsJniAahQSwnl9AWW2tRu5LAFSG31MUjUFg1B6JRv?=
 =?iso-8859-1?Q?x030B4bt63S5R28ZDsFwqZo8Bzz5wwspS4L3QyrGEpocZMRQVZLuxzZbBp?=
 =?iso-8859-1?Q?oAfxFNKVcPsqNSBzkWp+/peacc6zjUZhOebXk7vd1Xn9ybUB3BfnE+vpqs?=
 =?iso-8859-1?Q?N6CPw+lidigl6GrH+GcdXUHrW60ymlvnxuiScoTRyyb8PTMn0ZW9wuWXxo?=
 =?iso-8859-1?Q?L2moruYvXSU/9qQkove/gU0y79H6BDNn4OCuAleNRjJYp/QHJIsSS4GpjH?=
 =?iso-8859-1?Q?gM9yr5cqdFZSflPCzKwK80mEvg3KsEJQSbsdGaoaKOV9Sk+Cq5/4sd17NR?=
 =?iso-8859-1?Q?RrkxwI0tG3PYZQF47m+NH6n5T7xfXDpY+JHLOhucT8K75yxlIw797QroKq?=
 =?iso-8859-1?Q?uJGd25o/Xni9BsrA/O6RXioc2Pq6lzGu4cKVLe6stMZEWxshC3xKMno4Vw?=
 =?iso-8859-1?Q?O3h+qz9i+Pu5tyQWiOlw3CIhcCWScWC35kIAR6szqO8TroUSi2S2i6IWSv?=
 =?iso-8859-1?Q?IS47PI+OcO6ruokFFObk2f/RamBRIUSsQR3S4idGTxmQahMdygCB4rnxF3?=
 =?iso-8859-1?Q?qvO1AdFY8/oKhC33aKjFsb7kRnZmsC/v74ykOLpKHCk7s5OF2EonxvWCMS?=
 =?iso-8859-1?Q?GCZD3eoKtcu7v3lCDBcJ3BT/4ANe/xDy64nA54kobHoX16zvKlaYu3QuHl?=
 =?iso-8859-1?Q?uYIHvJoW9w6+/2aLqRlvkD6gI8GfTFZ85MYEABwL3t5XS32r/2FM/gV5+U?=
 =?iso-8859-1?Q?MFdyq2mn5NHXfBFNqrhr5Hd1eOaJZnKa5/tPyEcLdiTgNCVpODes0eH56m?=
 =?iso-8859-1?Q?Dpxml5Io2wITOog/MgWo+ZDD3IL3LLe386DQzQBnG6H/9KQmyhm4ukZ9Uv?=
 =?iso-8859-1?Q?xuwJSInjbsCDoASwAFuDLjunMyX5j/r/nwzPtqxMMbcwj9ETOzjA7LzExw?=
 =?iso-8859-1?Q?WBBbWqjsZR441lyX/tuoB0tlNmSCEXOxsxncqLzHd9hJT+0QfUcSGs7QEO?=
 =?iso-8859-1?Q?wdkh2zA8tdC0VEGf//hcHwTzOjpjSmhDXlY9TgsXPiTwcp6Ct+bsB3jt4/?=
 =?iso-8859-1?Q?DEi3CiNE3Nr2EQ53XMPZ3Jb4P4eayqAR4DXYgH+QT7GThp84rRLDA2ZQ9x?=
 =?iso-8859-1?Q?eU01FLz0750g0anTtjUIi7AgnaHxVWrVlJCIPiW0UW4Qsh4/7cC44GrOnB?=
 =?iso-8859-1?Q?0Af6kSdQxB8gODrT6eMqIQXq+JT7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r5IH+h1b0DfCUpJ8PI74gFDntgRRX3TGfksdlIXf68ryy9VtPoNT/qReZ1?=
 =?iso-8859-1?Q?AiTWMmKkAKs3mIKsIMj0cm1PE3a7EzEUse/YRZrQeupVjuD6Bz+dvrFtzo?=
 =?iso-8859-1?Q?mHpAcE6AqLssudfRU5J7JUxZzG/bkIE/erMaXoSEX0i4ETf4oZh2EcuizB?=
 =?iso-8859-1?Q?00JZW1K/tmEvk1xcRk3mEbNCN3LbqEHz6loD3BbkuQtvZlVUgsxNTeLYCl?=
 =?iso-8859-1?Q?s2SjFcugUhDjzYP8vvLu5tmPFB1xmQgo2gQubiEEUXuYJhc9EV/QYTPGye?=
 =?iso-8859-1?Q?XnXqFBtlxMeUJoubdwq51lGLPFslQmuBjVP5Y9JhMmLXNu0TS6QYcH14ch?=
 =?iso-8859-1?Q?k+o7+UyLeY4vVx2CRXh0AdDzEigSH3ZtC5x9aw1KEdeJPtf6T93RhlBUP/?=
 =?iso-8859-1?Q?GyPD+02hnwI9CmRL82ob/FVNwdszOwm/RM4Kqp/BWCggcPL7/JBdL2iHjl?=
 =?iso-8859-1?Q?mfkoYAy7nd/m8WbvOzvaDWFrIVxZVwM+BZg+37b3CCS03v/2yUY6zgFtWE?=
 =?iso-8859-1?Q?JjmsOV28Yn9NiQCJ0/OEcCwlE3486a02CRBbE3CEaKefVg6Zx4eez4NGba?=
 =?iso-8859-1?Q?mp9h4jXRQrPOVd4dVAUMxhtgKhrzdeytGveqaIKjU0hyTaU7m7CHb6v9w0?=
 =?iso-8859-1?Q?HsszByaXNmWhjuLgRmIO4TIyaAr3FWUo7i/haXcTJANM7cOPkBscHQm3vC?=
 =?iso-8859-1?Q?hZ2fiSdA4oOcv2MaIfcdqeTdQ4pPbiZQqhidRQzD46j11vu/H0Hp7ZyzH1?=
 =?iso-8859-1?Q?eoXNGmTAvqPHLBw0Jinb3oO/BXWUMjVRD3oIc/UCA4ScSTfiV55K6jen2k?=
 =?iso-8859-1?Q?TG92w809eKnDoWg2MLL4tAmsDlTk1sRhdxyzTNOz3Su3dVbmvPb7YorFHr?=
 =?iso-8859-1?Q?ooLcq4tnpvyXYXjkoq9UWn7DysntQr34qLkVoBl8NMdk3e2ditmg9JA24u?=
 =?iso-8859-1?Q?1skOaaNMrmvT0ikJhfSV+V/tuY+/niF7+o2+C0iYzfpk/ncYuY6jwguCo9?=
 =?iso-8859-1?Q?vi+sCszmW5nkJt+jaRMOM6y0bC6RxC6+JAWpXSTtTYU0pTdwzABur7VUzf?=
 =?iso-8859-1?Q?+fbH5kBI07QZy5GeTCH9KoemlB9aAaCnAeakCY/yZYh+n2UTXgBIGhjgG8?=
 =?iso-8859-1?Q?9i9DjD+xQhNrnozV/uFS7ratY8/CygP4HQfWmAhGOTTMhCC5sMaeLx1xZ7?=
 =?iso-8859-1?Q?YyxUrVyCOfgK3J0eEX/6KsDfSB2nkl2S+0c+WjEfKGX1D8mjlGWSIkbGaG?=
 =?iso-8859-1?Q?3HYo7nRW7VcAX40cq7nBjglVwKkjPxX/f3WgtJ6tsigYvj8U5FK6/DaXtp?=
 =?iso-8859-1?Q?Qmkp0QUoPB3PgRSvyG7jnyIdEP32LBg5A8fLg9GVh/enkFendjZkXLdwDu?=
 =?iso-8859-1?Q?5qOdlZQCv0sdTyw4XouADsrgXUFnJl/gtQiArhmG9GHKwrkUA9TpZEThZI?=
 =?iso-8859-1?Q?XG11WDSzamwAqhuTF98Oa5voMxUQpeH/oWMBOqU2FmCauAMijr7LZGo2rx?=
 =?iso-8859-1?Q?MXbVuXUjjDsweksTc4yMFjECsLX9DE7jiXtJR/Lz2Qlq46VksHuSK6jKM5?=
 =?iso-8859-1?Q?IF7bnfpUAFLp51ra4qkUD3X1aOtIDa1s3hu2lPrM5dnp+95Zrt/Iaqa+xB?=
 =?iso-8859-1?Q?agmB+gaHhcIfY6VKLeRhZrQeb2Ud+qmkhK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338c1da8-0ce3-4594-88f3-08de0a254cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 06:54:04.9503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eeYt5X7HAQL68e6kl7R3OO8uynyag+5W+5DgypudzXk54NknDGSALpc0ZGdXfiml+gNzNv3hTbcXb3kJk3TnymVhzsStF3ZpF7QXDnuA4bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Akihiko,

> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identi=
fy blob
> resources
>=20
> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> > The res->blob pointer may not be valid (non-NULL) for some blobs
> > where the backing storage is not memfd based. Therefore, we cannot
> > use it to determine if a resource is a blob or not. Instead, we
> > could use res->blob_size to make this determination as it is
> > non-zero for blob resources regardless of where their backing
> > storage is located.
>=20
> I think this patch is no longer necessary since now you add code to
> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-udmabuf: Create
> dmabuf for blobs associated with VFIO devices".
Right, but given that mmap() can still fail for various reasons and this
use-case can work as long as dmabuf creation succeeds, I think it makes
sense to not rely on res->blob to determine if a resource is blob or not.

Thanks,
Vivek


