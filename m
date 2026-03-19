Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53164107526F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w382g-000163-Gg; Thu, 19 Mar 2026 03:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w382e-00015d-NG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:43:40 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w382b-0003pw-PF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773906217; x=1805442217;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IGOR4TjF4O+UGJj3o6c7SiguGX84cpCHH+wx4j2oVG8=;
 b=Lmx3iTFMdTvRlMx1qdT3ruJDNAu5nDLE/KeL75+LtEGPuekM+w0RJQYY
 SljKJD7v91Cbyk+ufwpArwbx4BRI4ziSP9pcF5iOTOam3XQQS262UHNpj
 Vl7DXW6cTCH6bmF080IIRYd4Xbyyeicjno4etoClPod3xy2OLCdcxqsst
 kPWTkBDnw21b7JGNjUtRRyQG4PuiikifKX5Cgn4l5QGX3qlfZEfKJhirW
 /jHpU+Qb5PdNtbKAQH2uB5EChH5H65aLYS0Wx6X3DJYo4JPuhwmg/bwkv
 FwDvEdQaHki3JfgNgBNnuO435sRNTgtNuOS0AJVxmukvEl8sbq8kcDRJe w==;
X-CSE-ConnectionGUID: k/Ho7/0WSKKW6lWwUqigiw==
X-CSE-MsgGUID: QJRzCX9nRhuevlYkBPX0QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85289866"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85289866"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 00:43:32 -0700
X-CSE-ConnectionGUID: 8lsYmewsQLWez6t+ZtxPCg==
X-CSE-MsgGUID: 70ByT8KqTauKqFTW5XbhNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="247224430"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 00:43:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:43:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 00:43:32 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhMbxBioZrbooE+08PkUxa02v0Ar4UqhOlT45UIe1M3vK1XqyFmnihQ+MoA/Wiv5Y1i5am8/255Gp7U2Syu5tJM32/+icTzPcgKEmTCLw38ylKxZ4l8KGWfz6KqtLKj2EeFrK+0GQfdM8L6EUnh1YSrBFrime7r55pPS8Jb+M6MYQ/JybShzNn85yKx0TPMyBtld8FjA6BAt0uQ7kh4wuPKFEdSQLYFx+7HnRM8CPnv/Jrca2dnu1sjZU3v/FMCFcoRZZ8VktPPzKWVd7OMpJOOWtSe1ajJ0b7q+aMTAgoI1ei5QUnMMOXpXhSgUMiV8/gVYJjhBr8NM5ZuYn6VCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGOR4TjF4O+UGJj3o6c7SiguGX84cpCHH+wx4j2oVG8=;
 b=kpyRcMIaZgnrEXdLrIFMLmyH12Yd9JmyT4xyGkI0cm4dUrl0Nsxu1cdaQ7Po/298mPnX51c1zxYtmyoU8zBFRGYaN8kj42SvCTa4kWfE5/6TvdIoqQLjC7l0cWtWyaXH/DKZ3uBGfD11yUBGSPJfYLiWrZUXb2Ibu3FvbwcSTN1w5F9KQoVP9tr6I/WE6s+t8nXOXY9nV6ZyBbfskVTnDT4FmOS8b6zYQ0N3gC28V9FwT3WnVaxbMYbHPseAdV+GwdMO0NMU2qZBCTmyKZ+0GRPmV2RPG4XpAr1Q1cU+5h15bJ49/mwzFLoNN4ikc+MtsRynSgQ9JUzY5QGR3aU0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:43:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 07:43:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v1 01/13] vfio/iommufd: Extend attach/detach_hwpt callback
 implementations with pasid
Thread-Topic: [PATCH v1 01/13] vfio/iommufd: Extend attach/detach_hwpt
 callback implementations with pasid
Thread-Index: AQHcrRuLdKgJXvF6XEaG3uQl3Pj3mLW0Qh6AgAFLf6A=
Date: Thu, 19 Mar 2026 07:43:19 +0000
Message-ID: <IA3PR11MB9136ED298AD8D3284A935788924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-2-zhenzhong.duan@intel.com>
 <4eca81a6-c32f-432f-bdcc-fdb6fa6425b4@intel.com>
In-Reply-To: <4eca81a6-c32f-432f-bdcc-fdb6fa6425b4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB8040:EE_
x-ms-office365-filtering-correlation-id: 128e7743-62dd-4922-449b-08de858b30c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 2vsIFUukGNqxJpOOZevZz5TPGLZX6kKBBE55/g60WBljXJyD/tiwkFHTI2M8RbnS7dS7LOmuPYr3xMgaGJPoACwhVah1csSH22el9LMBEg9YCh0dRIY0hw0bqyQYYIguakCdKAKCmnSIWWToe5laKkbHpXoCqPgszw+1NQK3oKGrnEXzjHY5dRgaNCSMWh4DAKWsQaKbTddVeToqt00beQiDTjiGKVDIHjrwKpSPbO8GMUeBv8o7clgMeOFqwJyu3DX/xyLPGiqPA8SbvzpVkrvpsQczaHhfowgfuzLtxpftmvfEHgFlSEW5OAhPZSHCKeWiwPn5lLVaO9K6EWmPBNzv7BlGn9bviHcuh5BCbdU+/gMpDdBClzz9kUrejGlZQs+SPgMlw0tQqsZ2d2XdLqV5RiFsQlmgQHHfj/6vQVfcfbbEa4bGiHAoW7B8mrISQh6BAJ+b/aBr3KPFahGrYXTEnao0Fs/8p1/EuBqhGyESy4Q7rGJuhmHbasbvhhz+aIfobg4QryGGYSIuxd5W0C1zIM1R+ufzSOgs332RpzxCx5PPmcNXxOfuCC79HRNDNVqdJSHUnslui3dby1boX6qIK1XlSa5Qe7rm6ZaTtmnAE645GqoGtwp63mXGIrNwbNUSO9PV3cbQ0OKslS6XEZCAEDql2CYJsy3ZPGyd3TXhIW9GysxSNxskGz/KmrkVMRN/N5yNBH1Y+rglRR3QytcOrol1BmiB0hin8PR3dbVux8D8KqY0gCstCiyKhtb161pYbuI78F5yu/AMHy7EGWwxFrUn8umMzTBsHQIxV+8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTZxRjROdTNCWWVydklWOUJnemhjTWpCWDlsOURFcVJnMUNFSXZLaExlU08z?=
 =?utf-8?B?Y2JGWGhSRnV0clB0Sit0WFRRVFFKU1RpbEZBMDZDSjd0dHZLOXBaZ1hEckhi?=
 =?utf-8?B?VVBweTVsM1pTeFhHVUowU3o1alhXcXZOSnVSMENaaFRrendhSDcrdk0zc3Vm?=
 =?utf-8?B?d1UrQ1Ixb05lMjJiYkdseHEzMHMwK0NWSSt6WE00aW9kbElKeUtVOGdOdkdz?=
 =?utf-8?B?V1oxU3BibXN3YnpQbnBsVGUvNnMxWmM5cSsybURaZU01SytSMC9rQ0M2YWlz?=
 =?utf-8?B?UnpJVE5jdGplRXlOemtFNHRDanFTbEU1RFozcHNtaVdjUXgxOTUrTytsNnlp?=
 =?utf-8?B?NE9qZHl2VzNkNEtWNCs5dlVIOEE3eUNmK28vNDhFTHRrVnpSb3lUUE9vMG96?=
 =?utf-8?B?Um11MHhGR0kxRW9tVGc5dm9FOHJNZXBMaFlzTkZwb3IwdGR5OFc5djcwNU5S?=
 =?utf-8?B?anpRYTBRYkNoN2dzdjBXTUtONXNkRnBGcENNSjZkNVBnMm1HSGlzalkycjU5?=
 =?utf-8?B?cEt2M0cySDUxdktOdjdWY1FXTjFBczZFdW0vOGZmUGVsQURCSUxHWitadS9E?=
 =?utf-8?B?bWxlb0c5WXhTcVkwcVA0ZFFLL0VmQ2ZIUDJEcG1CeE92NEJMaEpSVDJ2UTlq?=
 =?utf-8?B?eXl2T245NkhKS1JqVEtoY0M2WENlSDlLdWZjcnpvand1bWhBcTdrZTNDMWxR?=
 =?utf-8?B?VVV0eU1hNXlnUVRQaUswcUJQZ2thQXF3QUQ0bitzS0pwcXd1YWxTRzlMZENM?=
 =?utf-8?B?aHhYSWdLaklOeU85dnVXdDdkS0tZbk9CdkpsalJCOHV6SjlyaTZ5VjBkUnNC?=
 =?utf-8?B?WUt0SG50aGZVL0srU1h2VTBFbDdBVkF6WlIwTDIyVktIV2M4dGhJTllhVExi?=
 =?utf-8?B?bHhIZmNjaDdDNW5DKzl5SDlnZUpIL055YzFOZmZZblV2VU5xbHBkVmMvZjZ3?=
 =?utf-8?B?bUVURWFCcVJuZzNJMzIvL2ROdUpqRlZOMHBtbWpJcVRnZVZ3cHZOdGcxcjcx?=
 =?utf-8?B?OExDVjd2WC9Jb2pjbUpaS1g1VzBiclBNZDFRT1c1bnRVbHZOTzd4Wi9EeGIz?=
 =?utf-8?B?S21wM0pKUlp1QlF4Wnc3WWswblVVcVV4d1FNalhsN1lpb1pXUUtxVjQreTJC?=
 =?utf-8?B?Q2czRUtmUWNaQ01OSnRlTDJ0SGdkUGVXb1BuL1E1QjQzSXFlcWJ5OWpLemJk?=
 =?utf-8?B?M2pMY2NnWDZZM1B6RytmVkFYOEdCTkViS1RqNjVLK21lS3FTc09NMkM0YUcw?=
 =?utf-8?B?bXNLRDBJbm43d200OTZhNVFjVXI2eEZzNWlmVUl6R2g4T2FtaUxPNmV3ZjJi?=
 =?utf-8?B?VnJDUXpyNlRCMytmYWUyUnIxNjVJdE5lZDF4bXk2cS9QRStzVEdOWngzSU42?=
 =?utf-8?B?UitObHUwdDJBWHNaRCt4V2RJYzJobS9ORklmdDlacjhBNk9tSHpRSnhhK0Iw?=
 =?utf-8?B?S0ZVR2N1SmZvMVJHSmZKOG5aR0lZL2dFWnJ5czJjMmVCMitNQ1ZPU2pHRVB2?=
 =?utf-8?B?VG4ybUdSZFdTR1pEclBja2pETStwU2Y3Z3NUVXQ3ZDdxNzNrQ1B3VTRpMGY1?=
 =?utf-8?B?SFRHVkVlTzZwL3pHT3Y5aGZ0TWhlU3RtSGhId2J1TWJ1Yy9MQkhRUXNmYW8w?=
 =?utf-8?B?cFY1V2d1Nm9aaE5UTGZQYUtxbjFzN2lLSW55ZVREbXV4dDhNSURxcjlsMDhv?=
 =?utf-8?B?NFYrRE1HL2RyWFV5VU9NMTlRYS9rNHpWZ0VVN0JXNXZoSlpzS0RUaWZtdVBE?=
 =?utf-8?B?Z3pYcVRwUCtZNGtyTHFGTjdhRENmSG9HamNpSWpKUzFNQkRCRHBJcG1NRzRX?=
 =?utf-8?B?dGY1ak5CcDY1T3RmWFZ1dUc4b2w5MVdITS9QNzdIWnhKbEdib1RPcTY5aXh6?=
 =?utf-8?B?Q04vUkdhMllHTDZaMC9EQWdEWGdlVmsvWm11Y0w2ZVNha3dUN1B5cEZtWUVp?=
 =?utf-8?B?cy94K3RZUVlndHpDSE95d214T1k5dU1lQ1ZzSzA5Um1ROUtudmRHUzVNSTRk?=
 =?utf-8?B?RnZiaXJkNWIwWEl1TVcvY2Flb2NCUEZmeVluVUxTRzlHTEVxbzNWT05qSDg3?=
 =?utf-8?B?OEdkMmpDRjAvaUJ6Q0t4RkxMbllXcVFHQkhvWWNBQUJzZm5heU82S2VBTlJn?=
 =?utf-8?B?RU5QMjEyNG1NZFhHUmplMVpZa0xzZW9lUmdUTVZZd0lqd1lrNkQ3cThSWFBO?=
 =?utf-8?B?ZUVoRTdFSGtLT2lIV0VCditFVG1mL1RKd1ZPMURWRVN5SmFWMmdtb3FXbDJH?=
 =?utf-8?B?TzltRXNZeDU4NzlDWGQzVk01VGtZamhodTllMDBvU0dnMU1UbjlJS2hpd1BN?=
 =?utf-8?B?eUE1UFZZTVRyY29PbWZsNXZXOWNuV3JxTDNwRlc4S2ZrTWRGa1ZUQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CECS8TTmEG+plQz0aVvK0pgomzcAjoHEe6CIWDn9v40AvzbNZyUzKKlAk2hqxEbT0qPsmKRxXNHBQKpPaia5XeJ8x4YWBrF8BkIHjMJ5tHCu+b38pZA3pR3h/Qv/ywONTqFIW8MRmokzYJtcfC4Atb82LVR84C3oYdJwOopYeWqQc+Xuz7ntoAv12cTmo6OE4bHTGyBU8xl2MxMG7nodSrEMfnMsiVPpEADC6olW6VZIRKNx0KX8Ftu+ZFXZUFZ2Qjr1m7GJrLAoXCWXMxCfNEqA3hVvV2vUHxlLBJB412FNYc2hh2sjZiMm/WTIqE2f2NAL6NwsdCVQRU3Jcb52aA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128e7743-62dd-4922-449b-08de858b30c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 07:43:19.8278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNYhMoAASGW8dGFLHJvRICQciTVcFdTjiUca+Bazof0RDkzYIlVbFn+aZudRB8Ns/c0SMI4iZk6eFEpDy+ilf2yOIfOaz58BnYc9XzxZN5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8040
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDEvMTNdIHZmaW8vaW9tbXVm
ZDogRXh0ZW5kIGF0dGFjaC9kZXRhY2hfaHdwdCBjYWxsYmFjaw0KPmltcGxlbWVudGF0aW9ucyB3
aXRoIHBhc2lkDQo+DQo+T24gMy82LzI2IDExOjQzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+
IEZvciBhdHRhY2htZW50IHdpdGggcGFzaWQsIHBhc2lkIHRvZ2V0aGVyIHdpdGggZmxhZw0KPlZG
SU9fREVWSUNFX0FUVEFDSF9QQVNJRA0KPj4gc2hvdWxkIGJlIHBhc3NlZCBpbi4NCj4+DQo+PiBE
ZWZpbmUgSU9NTVVfTk9fUEFTSUQgdG8gcmVwcmVzZW50IGRldmljZSBhdHRhY2htZW50IHdpdGhv
dXQgcGFzaWQgc2FtZQ0KPmFzDQo+PiBpbiBrZXJuZWwuDQo+Pg0KPj4gVGhlIGltcGxlbWVudGF0
aW9uIGlzIHNpbWlsYXIgZm9yIGRldGFjaG1lbnQuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBTaGFt
ZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4+IFN1Z2dlc3Rl
ZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPj4gU2lnbmVkLW9mZi1i
eTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4g
ICBpbmNsdWRlL2h3L2NvcmUvaW9tbXUuaCB8ICAyICsrDQo+PiAgIGh3L3ZmaW8vaW9tbXVmZC5j
ICAgICAgIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4+
ICAgaHcvdmZpby90cmFjZS1ldmVudHMgICAgfCAgNCArKy0tDQo+PiAgIDMgZmlsZXMgY2hhbmdl
ZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvaHcvY29yZS9pb21tdS5oIGIvaW5jbHVkZS9ody9jb3JlL2lvbW11LmgNCj4+IGlu
ZGV4IDg2YWYzMTVjMTUuLmJmY2Q1MTEwMTMgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2Nv
cmUvaW9tbXUuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9jb3JlL2lvbW11LmgNCj4+IEBAIC0yOCw0
ICsyOCw2IEBAIGVudW0gaG9zdF9pb21tdV9xdWlya3Mgew0KPj4gICAgICAgSE9TVF9JT01NVV9R
VUlSS19ORVNUSU5HX1BBUkVOVF9CWVBBU1NfUk8gPSBCSVRfVUxMKDApLA0KPj4gICB9Ow0KPj4N
Cj4+ICsjZGVmaW5lIElPTU1VX05PX1BBU0lEIDANCj4+ICsNCj4+ICAgI2VuZGlmIC8qIEhXX0lP
TU1VX0ggKi8NCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9t
bXVmZC5jDQo+PiBpbmRleCAxMzE2MTJlYjgzLi5iNGM1ZTgxYjFkIDEwMDY0NA0KPj4gLS0tIGEv
aHcvdmZpby9pb21tdWZkLmMNCj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBAQCAtMjEs
NiArMjEsNyBAQA0KPj4gICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPj4gICAjaW5jbHVkZSAi
c3lzdGVtL2lvbW11ZmQuaCINCj4+ICAgI2luY2x1ZGUgImh3L2NvcmUvcWRldi5oIg0KPj4gKyNp
bmNsdWRlICJody9jb3JlL2lvbW11LmgiDQo+DQo+bml0OiBtb3ZlIHRoaXMgbGluZSBiZWZvcmUg
cWRldi5oLiBPdGhlciBwYXJ0cyBMR1RNLg0KDQpXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0KDQo+DQo+UmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPg0KPj4g
ICAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWNwci5oIg0KPj4gICAjaW5jbHVkZSAic3lzdGVtL3Jl
c2V0LmgiDQo+PiAgICNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPj4gQEAgLTMwMiw0MyArMzAz
LDQ4IEBAIG91dDoNCj4+ICAgICAgIHJldHVybiByZXQ7DQo+PiAgIH0NCj4+DQo+PiAtc3RhdGlj
IGludCBpb21tdWZkX2NkZXZfYXR0YWNoX2lvYXNfaHdwdChWRklPRGV2aWNlICp2YmFzZWRldiwg
dWludDMyX3QgaWQsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBFcnJvciAqKmVycnApDQo+PiArc3RhdGljIGludCBpb21tdWZkX2NkZXZfcGFzaWRfYXR0YWNo
X2lvYXNfaHdwdChWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkLCB1aW50MzJfdCBpZCwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCkNCj4+ICAgew0KPj4gICAgICAgaW50IGlvbW11ZmQgPSB2YmFzZWRldi0+aW9tbXVm
ZC0+ZmQ7DQo+PiAgICAgICBzdHJ1Y3QgdmZpb19kZXZpY2VfYXR0YWNoX2lvbW11ZmRfcHQgYXR0
YWNoX2RhdGEgPSB7DQo+PiAgICAgICAgICAgLmFyZ3N6ID0gc2l6ZW9mKGF0dGFjaF9kYXRhKSwN
Cj4+IC0gICAgICAgIC5mbGFncyA9IDAsDQo+PiArICAgICAgICAuZmxhZ3MgPSBwYXNpZCA9PSBJ
T01NVV9OT19QQVNJRCA/IDAgOiBWRklPX0RFVklDRV9BVFRBQ0hfUEFTSUQsDQo+PiArICAgICAg
ICAucGFzaWQgPSBwYXNpZCwNCj4+ICAgICAgICAgICAucHRfaWQgPSBpZCwNCj4+ICAgICAgIH07
DQo+Pg0KPj4gICAgICAgLyogQXR0YWNoIGRldmljZSB0byBhbiBJT0FTIG9yIGh3cHQgd2l0aGlu
IGlvbW11ZmQgKi8NCj4+ICAgICAgIGlmIChpb2N0bCh2YmFzZWRldi0+ZmQsIFZGSU9fREVWSUNF
X0FUVEFDSF9JT01NVUZEX1BULCAmYXR0YWNoX2RhdGEpKQ0KPnsNCj4+ICAgICAgICAgICBlcnJv
cl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAi
W2lvbW11ZmQ9JWRdIGVycm9yIGF0dGFjaCAlcyAoJWQpIHRvIGlkPSVkIiwNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgaW9tbXVmZCwgdmJhc2VkZXYtPm5hbWUsIHZiYXNlZGV2LT5mZCwg
aWQpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAiW2lvbW11ZmQ9JWRdIGVycm9yIGF0
dGFjaCAlcyAoJWQpIHBhc2lkICVkIHRvIGlkPSVkIiwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgaW9tbXVmZCwgdmJhc2VkZXYtPm5hbWUsIHZiYXNlZGV2LT5mZCwgcGFzaWQsIGlkKTsN
Cj4+ICAgICAgICAgICByZXR1cm4gLWVycm5vOw0KPj4gICAgICAgfQ0KPj4NCj4+IC0gICAgdHJh
Y2VfaW9tbXVmZF9jZGV2X2F0dGFjaF9pb2FzX2h3cHQoaW9tbXVmZCwgdmJhc2VkZXYtPm5hbWUs
DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZiYXNlZGV2LT5m
ZCwgaWQpOw0KPj4gKyAgICB0cmFjZV9pb21tdWZkX2NkZXZfcGFzaWRfYXR0YWNoX2lvYXNfaHdw
dChpb21tdWZkLCB2YmFzZWRldi0+bmFtZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdmJhc2VkZXYtPmZkLCBwYXNpZCwgaWQpOw0KPj4gICAgICAg
cmV0dXJuIDA7DQo+PiAgIH0NCj4+DQo+PiAtc3RhdGljIGJvb2wgaW9tbXVmZF9jZGV2X2RldGFj
aF9pb2FzX2h3cHQoVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yDQo+KiplcnJwKQ0KPj4gK3N0
YXRpYyBib29sIGlvbW11ZmRfY2Rldl9wYXNpZF9kZXRhY2hfaW9hc19od3B0KFZGSU9EZXZpY2Ug
KnZiYXNlZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IHBhc2lkLCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICAgICAgIGlu
dCBpb21tdWZkID0gdmJhc2VkZXYtPmlvbW11ZmQtPmZkOw0KPj4gICAgICAgc3RydWN0IHZmaW9f
ZGV2aWNlX2RldGFjaF9pb21tdWZkX3B0IGRldGFjaF9kYXRhID0gew0KPj4gICAgICAgICAgIC5h
cmdzeiA9IHNpemVvZihkZXRhY2hfZGF0YSksDQo+PiAtICAgICAgICAuZmxhZ3MgPSAwLA0KPj4g
KyAgICAgICAgLmZsYWdzID0gcGFzaWQgPT0gSU9NTVVfTk9fUEFTSUQgPyAwIDogVkZJT19ERVZJ
Q0VfREVUQUNIX1BBU0lELA0KPj4gKyAgICAgICAgLnBhc2lkID0gcGFzaWQsDQo+PiAgICAgICB9
Ow0KPj4NCj4+ICAgICAgIGlmIChpb2N0bCh2YmFzZWRldi0+ZmQsIFZGSU9fREVWSUNFX0RFVEFD
SF9JT01NVUZEX1BULCAmZGV0YWNoX2RhdGEpKQ0KPnsNCj4+IC0gICAgICAgIGVycm9yX3NldGdf
ZXJybm8oZXJycCwgZXJybm8sICJkZXRhY2ggJXMgZmFpbGVkIiwgdmJhc2VkZXYtPm5hbWUpOw0K
Pj4gKyAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgImRldGFjaCAlcyBwYXNp
ZCAlZCBmYWlsZWQiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICB2YmFzZWRldi0+bmFt
ZSwgcGFzaWQpOw0KPj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICAgICAgIH0NCj4+DQo+
PiAtICAgIHRyYWNlX2lvbW11ZmRfY2Rldl9kZXRhY2hfaW9hc19od3B0KGlvbW11ZmQsIHZiYXNl
ZGV2LT5uYW1lKTsNCj4+ICsgICAgdHJhY2VfaW9tbXVmZF9jZGV2X3Bhc2lkX2RldGFjaF9pb2Fz
X2h3cHQoaW9tbXVmZCwgdmJhc2VkZXYtPm5hbWUsDQo+cGFzaWQpOw0KPj4gICAgICAgcmV0dXJu
IHRydWU7DQo+PiAgIH0NCj4+DQo+PiBAQCAtMzU5LDcgKzM2NSw4IEBAIHN0YXRpYyBib29sDQo+
aW9tbXVmZF9jZGV2X2F1dG9kb21haW5zX2dldChWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICAg
ICAgIC8qIFRyeSB0byBmaW5kIGEgZG9tYWluICovDQo+PiAgICAgICBRTElTVF9GT1JFQUNIKGh3
cHQsICZjb250YWluZXItPmh3cHRfbGlzdCwgbmV4dCkgew0KPj4gICAgICAgICAgIGlmICghY3By
X2lzX2luY29taW5nKCkpIHsNCj4+IC0gICAgICAgICAgICByZXQgPSBpb21tdWZkX2NkZXZfYXR0
YWNoX2lvYXNfaHdwdCh2YmFzZWRldiwgaHdwdC0+aHdwdF9pZCwgZXJycCk7DQo+PiArICAgICAg
ICAgICAgcmV0ID0gaW9tbXVmZF9jZGV2X3Bhc2lkX2F0dGFjaF9pb2FzX2h3cHQodmJhc2VkZXYs
DQo+SU9NTVVfTk9fUEFTSUQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaHdwdC0+aHdwdF9pZCwgZXJycCk7DQo+PiAgICAgICAgICAg
fSBlbHNlIGlmICh2YmFzZWRldi0+Y3ByLmh3cHRfaWQgPT0gaHdwdC0+aHdwdF9pZCkgew0KPj4g
ICAgICAgICAgICAgICByZXQgPSAwOw0KPj4gICAgICAgICAgIH0gZWxzZSB7DQo+PiBAQCAtNDMy
LDcgKzQzOSw4IEBAIHN0YXRpYyBib29sDQo+aW9tbXVmZF9jZGV2X2F1dG9kb21haW5zX2dldChW
RklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAgICAg
ICB9DQo+Pg0KPj4gLSAgICByZXQgPSBpb21tdWZkX2NkZXZfYXR0YWNoX2lvYXNfaHdwdCh2YmFz
ZWRldiwgaHdwdF9pZCwgZXJycCk7DQo+PiArICAgIHJldCA9IGlvbW11ZmRfY2Rldl9wYXNpZF9h
dHRhY2hfaW9hc19od3B0KHZiYXNlZGV2LCBJT01NVV9OT19QQVNJRCwNCj5od3B0X2lkLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJwKTsNCj4+
ICAgICAgIGlmIChyZXQpIHsNCj4+ICAgICAgICAgICBpb21tdWZkX2JhY2tlbmRfZnJlZV9pZChj
b250YWluZXItPmJlLCBod3B0X2lkKTsNCj4+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiBA
QCAtNDg1LDcgKzQ5Myw4IEBAIHN0YXRpYyBib29sIGlvbW11ZmRfY2Rldl9hdHRhY2hfY29udGFp
bmVyKFZGSU9EZXZpY2UNCj4qdmJhc2VkZXYsDQo+Pg0KPj4gICAgICAgLyogSWYgQ1BSLCB3ZSBh
cmUgYWxyZWFkeSBhdHRhY2hlZCB0byBpb2FzX2lkLiAqLw0KPj4gICAgICAgcmV0dXJuIGNwcl9p
c19pbmNvbWluZygpIHx8DQo+PiAtICAgICAgICAgICAhaW9tbXVmZF9jZGV2X2F0dGFjaF9pb2Fz
X2h3cHQodmJhc2VkZXYsIGNvbnRhaW5lci0+aW9hc19pZCwgZXJycCk7DQo+PiArICAgICAgICAg
ICAhaW9tbXVmZF9jZGV2X3Bhc2lkX2F0dGFjaF9pb2FzX2h3cHQodmJhc2VkZXYsIElPTU1VX05P
X1BBU0lELA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRhaW5lci0+aW9hc19pZCwgZXJycCk7DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyB2
b2lkIGlvbW11ZmRfY2Rldl9kZXRhY2hfY29udGFpbmVyKFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0K
Pj4gQEAgLTQ5Myw3ICs1MDIsNyBAQCBzdGF0aWMgdm9pZA0KPmlvbW11ZmRfY2Rldl9kZXRhY2hf
Y29udGFpbmVyKFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gICB7DQo+PiAgICAgICBFcnJvciAq
ZXJyID0gTlVMTDsNCj4+DQo+PiAtICAgIGlmICghaW9tbXVmZF9jZGV2X2RldGFjaF9pb2FzX2h3
cHQodmJhc2VkZXYsICZlcnIpKSB7DQo+PiArICAgIGlmICghaW9tbXVmZF9jZGV2X3Bhc2lkX2Rl
dGFjaF9pb2FzX2h3cHQodmJhc2VkZXYsIElPTU1VX05PX1BBU0lELA0KPiZlcnIpKSB7DQo+PiAg
ICAgICAgICAgZXJyb3JfcmVwb3J0X2VycihlcnIpOw0KPj4gICAgICAgfQ0KPj4NCj4+IEBAIC05
MTksNyArOTI4LDggQEANCj5ob3N0X2lvbW11X2RldmljZV9pb21tdWZkX3ZmaW9fYXR0YWNoX2h3
cHQoSG9zdElPTU1VRGV2aWNlSU9NTVVGRA0KPippZGV2LA0KPj4gICB7DQo+PiAgICAgICBWRklP
RGV2aWNlICp2YmFzZWRldiA9IEhPU1RfSU9NTVVfREVWSUNFKGlkZXYpLT5hZ2VudDsNCj4+DQo+
PiAtICAgIHJldHVybiAhaW9tbXVmZF9jZGV2X2F0dGFjaF9pb2FzX2h3cHQodmJhc2VkZXYsIGh3
cHRfaWQsIGVycnApOw0KPj4gKyAgICByZXR1cm4gIWlvbW11ZmRfY2Rldl9wYXNpZF9hdHRhY2hf
aW9hc19od3B0KHZiYXNlZGV2LA0KPklPTU1VX05PX1BBU0lELA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3cHRfaWQsIGVycnApOw0KPj4gICB9
DQo+Pg0KPj4gICBzdGF0aWMgYm9vbA0KPj4gQEAgLTkyOCw3ICs5MzgsNyBAQA0KPmhvc3RfaW9t
bXVfZGV2aWNlX2lvbW11ZmRfdmZpb19kZXRhY2hfaHdwdChIb3N0SU9NTVVEZXZpY2VJT01NVUZE
DQo+KmlkZXYsDQo+PiAgIHsNCj4+ICAgICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gSE9TVF9J
T01NVV9ERVZJQ0UoaWRldiktPmFnZW50Ow0KPj4NCj4+IC0gICAgcmV0dXJuIGlvbW11ZmRfY2Rl
dl9kZXRhY2hfaW9hc19od3B0KHZiYXNlZGV2LCBlcnJwKTsNCj4+ICsgICAgcmV0dXJuIGlvbW11
ZmRfY2Rldl9wYXNpZF9kZXRhY2hfaW9hc19od3B0KHZiYXNlZGV2LA0KPklPTU1VX05PX1BBU0lE
LCBlcnJwKTsNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIGJvb2wgaGlvZF9pb21tdWZkX3ZmaW9f
cmVhbGl6ZShIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQgKm9wYXF1ZSwNCj4+IGRpZmYgLS1n
aXQgYS9ody92ZmlvL3RyYWNlLWV2ZW50cyBiL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQo+PiBpbmRl
eCA4NDZlMzYyNWM1Li43NjRhM2U0ODU1IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby90cmFjZS1l
dmVudHMNCj4+ICsrKyBiL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQo+PiBAQCAtMTgyLDggKzE4Miw4
IEBAIHZmaW9fdm1zdGF0ZV9jaGFuZ2VfcHJlcGFyZShjb25zdCBjaGFyICpuYW1lLCBpbnQNCj5y
dW5uaW5nLCBjb25zdCBjaGFyICpyZWFzb24sIGMNCj4+DQo+PiAgIGlvbW11ZmRfY2Rldl9jb25u
ZWN0X2FuZF9iaW5kKGludCBpb21tdWZkLCBjb25zdCBjaGFyICpuYW1lLCBpbnQgZGV2ZmQsIGlu
dA0KPmRldmlkKSAiIFtpb21tdWZkPSVkXSBTdWNjZXNzZnVsbHkgYm91bmQgZGV2aWNlICVzIChm
ZD0lZCk6IG91dHB1dCBkZXZpZD0lZCINCj4+ICAgaW9tbXVmZF9jZGV2X2dldGZkKGNvbnN0IGNo
YXIgKmRldiwgaW50IGRldmZkKSAiICVzIChmZD0lZCkiDQo+PiAtaW9tbXVmZF9jZGV2X2F0dGFj
aF9pb2FzX2h3cHQoaW50IGlvbW11ZmQsIGNvbnN0IGNoYXIgKm5hbWUsIGludCBkZXZmZCwgaW50
DQo+aWQpICIgW2lvbW11ZmQ9JWRdIFN1Y2Nlc3NmdWxseSBhdHRhY2hlZCBkZXZpY2UgJXMgKCVk
KSB0byBpZD0lZCINCj4+IC1pb21tdWZkX2NkZXZfZGV0YWNoX2lvYXNfaHdwdChpbnQgaW9tbXVm
ZCwgY29uc3QgY2hhciAqbmFtZSkgIg0KPltpb21tdWZkPSVkXSBTdWNjZXNzZnVsbHkgZGV0YWNo
ZWQgJXMiDQo+PiAraW9tbXVmZF9jZGV2X3Bhc2lkX2F0dGFjaF9pb2FzX2h3cHQoaW50IGlvbW11
ZmQsIGNvbnN0IGNoYXIgKm5hbWUsIGludA0KPmRldmZkLCB1aW50MzJfdCBwYXNpZCwgaW50IGlk
KSAiIFtpb21tdWZkPSVkXSBTdWNjZXNzZnVsbHkgYXR0YWNoZWQgZGV2aWNlICVzICglZCkNCj5w
YXNpZCAlZCB0byBpZD0lZCINCj4+ICtpb21tdWZkX2NkZXZfcGFzaWRfZGV0YWNoX2lvYXNfaHdw
dChpbnQgaW9tbXVmZCwgY29uc3QgY2hhciAqbmFtZSwNCj51aW50MzJfdCBwYXNpZCkgIiBbaW9t
bXVmZD0lZF0gU3VjY2Vzc2Z1bGx5IGRldGFjaGVkICVzIHBhc2lkICVkIg0KPj4gICBpb21tdWZk
X2NkZXZfZmFpbF9hdHRhY2hfZXhpc3RpbmdfY29udGFpbmVyKGNvbnN0IGNoYXIgKm1zZykgIiAl
cyINCj4+ICAgaW9tbXVmZF9jZGV2X2FsbG9jX2lvYXMoaW50IGlvbW11ZmQsIGludCBpb2FzX2lk
KSAiIFtpb21tdWZkPSVkXSBuZXcNCj5JT01NVUZEIGNvbnRhaW5lciB3aXRoIGlvYXNpZD0lZCIN
Cj4+ICAgaW9tbXVmZF9jZGV2X2RldmljZV9pbmZvKGNoYXIgKm5hbWUsIGludCBkZXZmZCwgaW50
IG51bV9pcnFzLCBpbnQNCj5udW1fcmVnaW9ucywgaW50IGZsYWdzKSAiICVzICglZCkgbnVtX2ly
cXM9JWQgbnVtX3JlZ2lvbnM9JWQgZmxhZ3M9JWQiDQoNCg==

