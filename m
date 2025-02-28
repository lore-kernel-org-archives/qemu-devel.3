Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCEAC19F32
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 02:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnq61-0004Y9-0v; Thu, 27 Feb 2025 21:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnq5z-0004Xw-19
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 21:27:23 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnq5w-00029h-FN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 21:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740709640; x=1772245640;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BLygFqSRG7iyYRpuDuM0a13H+x83hmVZKNaCKMscpTE=;
 b=F5aSzYY2xW837kaaszhlr+JAPGUT+NKqWPt3PWUrR+8fk9SkUVwZ0R09
 MupA74zC1x/4Xcfe3NHwTzgqKF7Q1S8A83FVVc4V6B5WBbNsbZF1j8zPg
 bNLMg1RXDXHGvLxNBLF+1p4NzOTCm7slpCiA1e73bONuw08I1d4lUGF1E
 PoyYCWsHtBboCo3GR/fXMwYPTBmrM5CPnGfh6CTUZGN12MPZMPiffwJ+2
 Whi5ZgT7WnyW9I2CDJDEmvEkV2fvkKaL2KQh1BOH1/NKQDfpHHWXm2ZXG
 HbRkD878Qi317dhAa+63fvxQAHvq5nab3wycsOJ05Oj3IGInBADv4g9H9 w==;
X-CSE-ConnectionGUID: AT+FrDDjRw6MeSLtvPCkng==
X-CSE-MsgGUID: L/nVSReQRuShfVx1u1mUlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41656883"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="41656883"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 18:27:15 -0800
X-CSE-ConnectionGUID: RSelmn44SQiRxeRWgQuV/Q==
X-CSE-MsgGUID: ylobKoXfTOCYYlIjS3uquA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="121806242"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 18:27:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 18:27:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 18:27:14 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 18:27:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWht5SOGOLk5QI4vrGmyx8wt39cjZ7z3nM+WgNG/CcmkfhY/UaOs2DH7hD/m++QLDMB/t4UzmyQJT6vJVb4y+29h0TzzJdhSi47vrer+B+TTEl7ZGfzwSYwFJ5lIzdmrr0GIGnxgnsTutggHiniFOyF/Efbc6rejJhe6Bd4EQ5e2Jq9qFgeIqNWTZtQV4hxwVr4tfaD/hzRNLaYNXmWWadSuwLcCbgKAl9KFUu0d19/qLoyb3RJhrjQVfA43VXOldtrfRQAVuOuU5lY6GSxj+qDQm7xAjHd7bDHy7IR88wrzYZjjAFwz+LicYngpBsORnwIXLbmmGrjYYSwe8DN6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STcC10hF+CU8anI8VOGSTyK7v3pauD8ZfA1uorQrXmw=;
 b=sj9yK8+GlWOnk80oUDKoudQfmEFeXzIYotP5Ie6fVdOrbvibRPGv1/jdUY+YRjDlR6p64MOTwsHg4bXixJTpUcc3uV6aBb9qNzToQ0/TIgzFbXnNxtzN678qSCpzJSoBJ12qH/9tGOBfh+9NPjPkXy5NLwcfxVdMBwD/1Rb45zvNPEiN6r/Adw0HDiXKpGmzM+4scJ4dO9eOC8Jfun38qwVPIl/J4N5NXuuN2bKPhAFOm2+SRF1dHxoQvfRotQ+y17gQlxF2kbLD41cgUVKlvLOZZzVECK6lSX3ucB3KobgEBpqaNOnSFDp1WRTqIrfHSjY3cmb3mpbrV5+9tgtG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 02:26:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 02:26:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
 invalidating user-managed HWPT
Thread-Topic: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
 invalidating user-managed HWPT
Thread-Index: AQHbgqf2du4TDl7Tuku7EhsMkpByw7NQaNMAgAqAHTA=
Date: Fri, 28 Feb 2025 02:26:42 +0000
Message-ID: <SJ0PR11MB67447179E30A69F5CED4183492CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-2-zhenzhong.duan@intel.com>
 <61f66ea9-7636-42d7-9098-bd911b2829ab@redhat.com>
In-Reply-To: <61f66ea9-7636-42d7-9098-bd911b2829ab@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6495:EE_
x-ms-office365-filtering-correlation-id: e20c70da-aecc-4fa5-652c-08dd579f572b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Dmovb7V0I5shW37QF1uR5bCblhcLrmVHXQDMNEeCT+J0VA2D6UyK4rXKT2zi?=
 =?us-ascii?Q?24aj633H1untG0ODmQ4KEqCGvctTEi/aPmzCLIT3TYCi2EssXifM+HQ/0xST?=
 =?us-ascii?Q?JcQs6y4/284+DGvEG1mwG35URCb4Hk5now2jZuwiZw4PdJEW9grzHCWnRxvL?=
 =?us-ascii?Q?QGmzmHH7D3WnMLBTN3cUvzv1LHlXiKBS1WNbOpkZ9mwKsJb1UPUJ7dCWa4qF?=
 =?us-ascii?Q?T0wMAGEuELHQyzal40gKiYBpQwkb3S/urvqyVlBxOUHvGipwkhhd3ACnN6m/?=
 =?us-ascii?Q?LtUukXCH/LvXSkqH7uUB22D9POlOHjK0/FDl9vKntxyvyUcBo8IgQl8u9vz2?=
 =?us-ascii?Q?gwcAlpct1IMCr9m5QPYKUanfZO5RdQArZQdseOIaLl7OW9Sq8XIrvMDec6vi?=
 =?us-ascii?Q?SmjQo/qQf8hM6yM6UJAHyeAdtbOmyVOlceiqaW/h8OZZ1knApP1AAwatxmCq?=
 =?us-ascii?Q?8nxMIf5cnqzd1n4wWpjVK9vdRXF4S5hP3mgJexOryD4oBUuz6Y5Rtf/Fhl3j?=
 =?us-ascii?Q?tcuUsxT7mxL61o7EK9uxkZhkzN41rtykzFU0BCwP0VYe3oZ0UQczhB5bR5lL?=
 =?us-ascii?Q?oYobHSMnmjchmhvfg0aoYOKBnGsOe8C2SZVSWIndv/33nC2UAPqkJb7W2St6?=
 =?us-ascii?Q?tGyG2zVHkjg40G+ZODEsj+q8t2msFmCyV2x+F1sOL18MwiHyQe//dv5FvyVn?=
 =?us-ascii?Q?LgkDK4DRX/A1wKZalJ88GwQSwriBAa6H8b74cy3txoaI1SsKxiPb0g5wZacn?=
 =?us-ascii?Q?PbAl0GRtdWo/PW+7FLYNRoPiRN8nw/qS5wvCc/kNP0zIZ0m5tgmv6DCGkUgY?=
 =?us-ascii?Q?D8SgTkCHdjNt5KynfzEJJSr+2Jxrmvt27oPZmKOJ0hYmJwjOEiSlR7gquu/g?=
 =?us-ascii?Q?IMcqBOP4FtIjN9/NfxJE3Xp+JVdwS5ValwuWLRc3eE0JObheHGxT+yXASTBH?=
 =?us-ascii?Q?zpC2ZOErKJaj8eyKNtSkGKWHaJJDjZyMLSjRY9pUxUPUpyG9F6vamBx4JIlX?=
 =?us-ascii?Q?/SwPKvfe0vAG631qAVOHJHGketqKyeJhoemvIkdunANbs3tA0mXGsPChLj8G?=
 =?us-ascii?Q?kDQ+stcz+OjE2+p1Hvsa77DOiMHe1CbS/XBN+fu84dqep3HtiT5W2RLyqQIW?=
 =?us-ascii?Q?Ht3xrJtDhr6qpjta9A4JQ4AKRJyw6UFGtg+aNGdwRTkYEy/NIGymaO8zO+Ws?=
 =?us-ascii?Q?eC8MQqaa9r4Vh1WRKeAgleUvCJ3E7DTJ21YdhFfbbC4lCWKILLSgpeWeVFcW?=
 =?us-ascii?Q?iDJ7uUGyz8ygsUDEegmewydHe4iCQ3yG0r125Uxb4KjRUKsHqoq/gyXv//mC?=
 =?us-ascii?Q?C+xmqqzgXE90a4XABGgMqjJVYQJIavSBeg+Fn95gailRSAdq5DwsLSgmcyta?=
 =?us-ascii?Q?Jhvss6GslE/bIwK1Ugi0Pn2taSmJo+NZPChBeUzsPAo7lpTP8pgr0amsYZ9m?=
 =?us-ascii?Q?QXPfq6t8L5rf09MAAspTfu6ddinQvEZQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ardJvAbv+fnmzJIMqndcNrMFGDDsGWu0+ZupVRTSbJWzEqefuTfLf7GsQL1P?=
 =?us-ascii?Q?vGSOT75gW183tMO6R5QEnXyac8UtIX9ucpBl8eNW/vUPO4Hc6FH8S2FFymMy?=
 =?us-ascii?Q?esSIr3Prmau/FFVm6SDZy5DgNG0J0u3REE78DoVcfy4HCJ6IhG2ecOB59eb4?=
 =?us-ascii?Q?NLcBpGNutt4QeKGAZwb3g0LcXVMCydbKEhwFWNwJrZZaSvpisoqAVYlOHpU0?=
 =?us-ascii?Q?dPlQZV74bcGSda08iw4wVLA1XfsMJ81EB7YFeOhYKm2Ox/LzYMo9T2dbGaTb?=
 =?us-ascii?Q?bryAYTLavt7WFF9PJ2KuyWOTcZoqq9lZxBXBZxEspA9iNdc3zqTNGyKzssa9?=
 =?us-ascii?Q?Mm5KUvGarzBvjgJ0KcPp1L1sbY4AddaWQxR76RAqI/dBzxD9qykpd37ddjyo?=
 =?us-ascii?Q?tULTqiwlnr59O3AhbY8e09hAkup3ymEmo4jslfvE2UvjU/Qgcm0KH1xnghpZ?=
 =?us-ascii?Q?rr29xrEg4yTbdilmEDsYb9KA8HmMouTyEZYmCgzDGkLP9C/gOXmEV2TpmczX?=
 =?us-ascii?Q?c6jxmMCSh+U46XnOvfyPsa/fLwghf4t1PTbD5GU9oju1O14d7CfaqP19LPE7?=
 =?us-ascii?Q?AdFdNd4Q1LgbZ6K+JxzACt0dmeJG5LGhR5lDzo4hE0lCColxoAbLPLiBvukX?=
 =?us-ascii?Q?uJmaZhK93FwA+VHqKOWmre4z/iIiOTBBN3jvLXYUMOE4V+IvNjy25vMWAJVK?=
 =?us-ascii?Q?gXH6+1+PHtehbA2DxJqfjGVaonYNENzCMx5DhiX7U7vFqd/12Fxr6/k9EFvX?=
 =?us-ascii?Q?aD96QzAzalgt0+kWlO969jPsmaogzwMGwljXxuLUzUD/UzoWEJEnNjms+ihJ?=
 =?us-ascii?Q?Vt8nRq/f11SWUeDs8AQLtRyEYh9c3CX+jEaz+PXX9h0RDpVC6VwrgF/c7skY?=
 =?us-ascii?Q?NOcPSYAUMEKjGFb1WIR07mGKHd8TjLcpLlsZQkUCcfAd+DGRNtF7QMWx8tQb?=
 =?us-ascii?Q?pxExyS7jie0H8I3Jo9BPS2ZuPh8OAMc1a5ykhi+q9IDAdgNG2/j2kWSJq8me?=
 =?us-ascii?Q?I6NRkWzl2O0Jf36UODo3mlRpOHlrXTosoHwTK58KnTzM+HjTyAdHXB6WKfU1?=
 =?us-ascii?Q?+golDUGNzhcso8Web5CwBLGAXhRyOLCJyx2WupEiwuv6uwBifIjUWkAzquzv?=
 =?us-ascii?Q?bxevQRT7dPhtuyim07Nm4XJzwJXOuMvQ+zdM1OvES4/KfqSGZb73zZsSLdii?=
 =?us-ascii?Q?lB3UQRMiWZ75bWEFnP/SB9vevs5b0JfjVjCzDRzCkEGYiRSAgszXBXGDYD1T?=
 =?us-ascii?Q?T5UBZMSpGZ3Zzi3YgM8421F/Hjvn0l1ji9SA6PlFkG7KSfYyx1z/vfTkuUI2?=
 =?us-ascii?Q?Yh31sfmHW/+BnEfGbNcj1tujfLwK9U0fT+3ONBufLA6T+W54ofePHdog6oyE?=
 =?us-ascii?Q?BOrVFxGHzpIe5ixiw1/0/HtgqR6dFEeDpK9HJWezonE5yMuN3W/25R/ixZn9?=
 =?us-ascii?Q?9q1uhhTwVhm1khulVEy+/jHXReYclNvN1fj4btqdZGwPYK9305fYZztFzAoB?=
 =?us-ascii?Q?TJhV+gW7VnqdGrgQi0yxCXBJ3ZzrxvmfMC6B5sZkzgF/gj2pmxLNcGC9xwKW?=
 =?us-ascii?Q?ruiIeT8hz7UKdLyD3E/fNcFqqh6bEpNAbVqinNBn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20c70da-aecc-4fa5-652c-08dd579f572b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 02:26:42.9982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vC+Fk5y40oVNuVkzqXm8U2ZPrQOwlmYydviYuhXKqM3AGyzWOE5GLUrUHZTIN/9cWdrp/3Hy8WuvuCXKVB9eDrIlZQcRuzoE/SjgDJzup8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for invalid=
ating
>user-managed HWPT
>
>Hi Zhenzhong,
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>in the title, there is only a single helper here. a small commit msg may
>help the reader

Sure, will do.

>> ---
>>  include/system/iommufd.h |  3 +++
>>  backends/iommufd.c       | 30 ++++++++++++++++++++++++++++++
>>  backends/trace-events    |  1 +
>>  3 files changed, 34 insertions(+)
>>
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index cbab75bfbf..5d02e9d148 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -61,6 +61,9 @@ bool
>iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>                                        uint64_t iova, ram_addr_t size,
>>                                        uint64_t page_size, uint64_t *dat=
a,
>>                                        Error **errp);
>> +int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t
>hwpt_id,
>> +                                     uint32_t data_type, uint32_t entry=
_len,
>> +                                     uint32_t *entry_num, void *data_pt=
r);
>>
>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>  #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index d57da44755..fc32aad5cb 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -311,6 +311,36 @@ bool
>iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>      return true;
>>  }
>>
>> +int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t
>hwpt_id,
>> +                                     uint32_t data_type, uint32_t entry=
_len,
>> +                                     uint32_t *entry_num, void *data_pt=
r)
>> +{
>> +    int ret, fd =3D be->fd;
>> +    struct iommu_hwpt_invalidate cache =3D {
>> +        .size =3D sizeof(cache),
>> +        .hwpt_id =3D hwpt_id,
>> +        .data_type =3D data_type,
>> +        .entry_len =3D entry_len,
>> +        .entry_num =3D *entry_num,
>> +        .data_uptr =3D (uintptr_t)data_ptr,
>> +    };
>> +
>> +    ret =3D ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
>> +
>> +    trace_iommufd_backend_invalidate_cache(fd, hwpt_id, data_type,
>entry_len,
>> +                                           *entry_num, cache.entry_num,
>> +                                           (uintptr_t)data_ptr, ret);
>> +    if (ret) {
>> +        *entry_num =3D cache.entry_num;
>> +        error_report("IOMMU_HWPT_INVALIDATE failed: %s", strerror(errno=
));
>nit: you may report *entry_num also.
>Wouldn't it be useful to have an Error *errp passed to the function

Will do.

Thanks
Zhenzhong

>> +        ret =3D -errno;
>> +    } else {
>> +        g_assert(*entry_num =3D=3D cache.entry_num);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>  static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error
>**errp)
>>  {
>>      HostIOMMUDeviceCaps *caps =3D &hiod->caps;
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 40811a3162..5a23db6c8a 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -18,3 +18,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t
>dev_id, uint32_t pt_id, uint32_
>>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=3D=
%d
>id=3D%d (%d)"
>>  iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, in=
t ret)
>" iommufd=3D%d hwpt=3D%u enable=3D%d (%d)"
>>  iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_=
t
>iova, uint64_t size, uint64_t page_size, int ret) " iommufd=3D%d hwpt=3D%u
>iova=3D0x%"PRIx64" size=3D0x%"PRIx64" page_size=3D0x%"PRIx64" (%d)"
>> +iommufd_backend_invalidate_cache(int iommufd, uint32_t hwpt_id, uint32_=
t
>data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint=
64_t
>data_ptr, int ret) " iommufd=3D%d hwpt_id=3D%u data_type=3D%u entry_len=3D=
%u
>entry_num=3D%u done_num=3D%u data_ptr=3D0x%"PRIx64" (%d)"
>Eric


