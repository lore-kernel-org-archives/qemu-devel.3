Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4783C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 20:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKl7Q-000179-Tj; Fri, 21 Jun 2024 16:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.luck@intel.com>)
 id 1sKl7O-00014k-Ax
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 16:44:22 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.luck@intel.com>)
 id 1sKl7L-00081D-RS
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 16:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719002659; x=1750538659;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kBqgVYbTfOa5IDnW0fpp9nr1163V/5qzJHPwi7gpY/s=;
 b=QTBAWrCSxq+cBrwo48YwmaIIdGWrDa5ljtSBQ+1GSYvRPU9SjkF46J5H
 eNvVCpRkzMNJ55fg0LDJK5Ka9KMcW6WMpOEhAZoI9i8c/UEAN7xf9d4LO
 I5A7YxbQGWqM4wolX4dmGCnlmpuDnQohNEBT/Oo/aUt88mFmUjIa364R3
 tVoGe4NN/w0PmQ/FFststYBe5QrqDVGMUCTxKnKpQJy4O/I+ZBIXKpfQJ
 6gSfCBzRqVy6AdGNL4s79BZnO8ahX3upn2gVUPF5A0fTlQ3DIZ7ncrrJK
 jAJcuVSP5yt3ttWMRZHML8REBkfz+BQ8yLoxdxWnbFU7GBsfiXNmuKC8e w==;
X-CSE-ConnectionGUID: FEtm2fcVSpSCksxIj+vh7A==
X-CSE-MsgGUID: brb7DXj3S5aB+Bc1iBukGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="26680590"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; d="scan'208";a="26680590"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2024 13:44:15 -0700
X-CSE-ConnectionGUID: iK5n/4TZReqsQVPp40nY0A==
X-CSE-MsgGUID: cNHGQ7CmQSuxl2SgvMrwRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; d="scan'208";a="80218897"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jun 2024 13:44:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 13:44:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 13:44:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 13:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7mP7ZPB9+zp9M5Wp++TORdLLeVCtvyyJQqRp3CCPigMZAy95E5anF7l/IQuCbRJHR4rf0JTVcglksHLRgJmejL5+MR+ZcFHb/EV6x2CNuvXsKj+DITcbH1bts1bZDHcBP53tWJHOg539H4fyX7s4WAQPDdD3cy5srlA+9fKcjUo4tNAgLiRCeMwZ3cEQztcg+08qqvW+YAlTA7lGsekNpXthnSfpqQVOUR3tPhBgYJNsd1aH2rxnBy86rgFAnrD0sUGgzLyFZw8OiiAzuHU1aKHw+IuPrTfGv0eWGIOLNvtIzbnTXUh+d54XDSwRRE7GIBxqulEYnj8jSRrsIbUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4YfTNC6Eny5SXQNDLnDp9IMKhD5CtFCWqygrfpkVX4=;
 b=hOyJ+yPMq1OniMmuBe2gpEkEL4S4iuHW2tE+ZrfArSMv4sysb/s4UvArRSv5VMxPnKCybNCokfPdhPNEnX+Rss/lr7k0Cex1Nal81YNxSMKmz1hdkbao+6+PCSnty2xZ5gilBVAmBu+xz7ldfqrxYrLbGEGK99hvZf/Bgz+D3Uo1TvR8T2n8nJt9OpbCOG5zVvE5y/XUSYUg6/x4rhlIrcSpLnt5REzY6JO93VgGtrLplLcDY+7m291tlkNYatz10R22izZ8zdx13X9QS9rKnyC1wQwfs7eMn55Chepzr5YB+MYYXjL9QgwBGqb1ZS9VoRKBpgG829cRGEafAZ80Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB8276.namprd11.prod.outlook.com (2603:10b6:510:1af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 21 Jun
 2024 20:44:12 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 20:44:12 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "Williams, Dan J"
 <dan.j.williams@intel.com>
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>, "Weiny, 
 Ira" <ira.weiny@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>, 
 "Jiang, Dave" <dave.jiang@intel.com>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>, Borislav Petkov <bp@alien8.de>, James Morse
 <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
Subject: RE: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Thread-Topic: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Thread-Index: AQHawzOz2XZytMimJk6HWFfyu84XE7HSgzIAgAAMqwCAAAwS4A==
Date: Fri, 21 Jun 2024 20:44:12 +0000
Message-ID: <SJ1PR11MB6083837A8588894E49FEBC7BFCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <20240620180239.00004d41@Huawei.com>
 <6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20240621194506.000024aa@Huawei.com>
In-Reply-To: <20240621194506.000024aa@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB8276:EE_
x-ms-office365-filtering-correlation-id: 66f5a474-2a0c-4fc9-6884-08dc9232e858
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230037|366013|1800799021|376011|7416011|38070700015; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jQwneYXvE+u5hilbX2lRt4zSgnmIRXALHoYTcIQ4Bepny773h6S/tEYx8YPi?=
 =?us-ascii?Q?E+GO034EWP4z/iSdgQk8p2Sgnq1MAwrAcV8yBFGgZBH6SNu+P6yCZ3UlSv++?=
 =?us-ascii?Q?3i3Ksn0noe251cZLxd+MMiv4RRN0nV/gqOZWd0ZIjIVmkyFNngH0Xqi41Uv/?=
 =?us-ascii?Q?2YVxYLt64aNiCeAVYPv4ukCD1+NTWfJ5MXMBna7/PxovdANaA7G0a7pMqpj0?=
 =?us-ascii?Q?gjoULphQPiB9fIBhM5PPRUEOZE4weooaRxuCng3o8xKyQOiAhOgEUZOfK6JN?=
 =?us-ascii?Q?r9VFaCiZT+23keJYRSo/YeIYveAuYdNsCakm68oib4epV2NA2c3W5To2E1kj?=
 =?us-ascii?Q?TuLxlSgNYfI14IALskR47i7WN9+G2iTBXbm/okkRsAXHpcf0LzJ+iQEQh9jQ?=
 =?us-ascii?Q?ZtJy9Mx+kBIMTLc5xcVp9bVtMViHvUs4uwE9/Vij0pBhoa6pS8oRlugFao+m?=
 =?us-ascii?Q?F4D/Po22jhw8WB1DDLWQde7ppLuCw4yVzyZAL0MRppyB/Qb7SSrrHsrVd4b9?=
 =?us-ascii?Q?sB2kzb0RldN63oMvHNBe9NepKmJ461naqt58h1UInoYiV/zIuCWQikrOp7Zz?=
 =?us-ascii?Q?mXcIYswHKAwouRbzkhOQvtkFfdr2IFCeKvl2qHxLsQ6JvxR+7iRYYSpzCxnH?=
 =?us-ascii?Q?EvX6YOOIez35ObIF79fnv2iB8lQ+OQhRl9zhBRh1SWbnQNDEWNgZ5L7e3EI1?=
 =?us-ascii?Q?Irgch50l1BSNsG6SPQHojg9/Fw8dVnRbbdA/b5jk0qBYloDcoo2HSB7HfKNh?=
 =?us-ascii?Q?O6kqH0Y+M6UqoCwKEyUuW8Om+nQOg4hIWwYIWPttb4Y85lO+kgpOJ3XZJ3SI?=
 =?us-ascii?Q?vm0hqq1b5VIOEmgDM9eF5PnVc1SzSt5Gym5azG5dQoxxUT8jSBY9B2j8uTt1?=
 =?us-ascii?Q?jrIu2yS9M9VsAasP/YtRwNi/dERlTkYZ+Bl1XRDMXb43k+IXqtPfALialVnI?=
 =?us-ascii?Q?A7bCWqh9uT017jQ2Wtl8B1YyPSDbLmmjg8k9sxZkpF+wq+LpEXFNS22gm5zN?=
 =?us-ascii?Q?JDzFSLAVPuK9Am+BM4lQlaF0ZV9Jjb5a9zROvyHbn1sILivTVmmf0DBchj5Z?=
 =?us-ascii?Q?V7MlePCmI/NqQaOzU9mWoYc5aLeelUIZm0kiUjEWv0VdiTCZKNYUfCOg2hs0?=
 =?us-ascii?Q?hcjlvgwpxF6aVFS1bbqEKeWlhFGRWVUgOG97m+hrJosVQlMKvTfQtuFaLHKQ?=
 =?us-ascii?Q?Z9GVs26GZ8JlVwmxzJqAb0QjaKC8Zh7IyxdJuvhUnj62uoDDQySoZKPLbsEl?=
 =?us-ascii?Q?7KSV01xSKQoWi31sFDx1hHc9BBKlOShJXKH2sIRbPc5MLiKE+jGf5q0XiYxu?=
 =?us-ascii?Q?zvGzB4pWS973VAS+U12GHqejCNbdk2hRtjFFPUzFnDLKD8Kox0q3JDaikkws?=
 =?us-ascii?Q?w/jfcFE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6083.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011)(7416011)(38070700015); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cTg8GMmJbgpdL8CkQVkFVKnR+pkyYxfyQIKudkc2Vr7caZVHH1ynAmdW7r15?=
 =?us-ascii?Q?oPQwvmSfXKiJwSZ+yUui1j+sDO1dRE5U7xTg6xY6aLvNX3jknNGfQ9m64IG9?=
 =?us-ascii?Q?pxHzmC5vTyqoHfBcaCH1POFWqjnA8kGYTHmklHZqsvxGf4kUQoFfuL9g00kv?=
 =?us-ascii?Q?tcwOOILt5HXZkg1Y8wJ5vi7DE5e0p5aqLWzSWtsMY7Jmo9Os0GJvOHHuTzGM?=
 =?us-ascii?Q?nA8bUcyiJebqdq2Bx9qdyNsCQIbYFGE/7TCDa9NU3oC9oulIDe01KSVOoYII?=
 =?us-ascii?Q?ECmFi0noUtP2NRiV2rsdgh3iah3RrOjpJW2YMiNgyYR5zhvMs5eoMJtH5ybt?=
 =?us-ascii?Q?RvJu7NDSiplXP+XEuEGvpFPIm6QmxMjqpz22lZvS9O6SliWiuTIKIV4l8EMs?=
 =?us-ascii?Q?7k1Rdf4tDzGAl2e3tm2jNBd4OwziyFHk5pK6OjJCjs/Qd5tIBQXmFTGn2IZ2?=
 =?us-ascii?Q?KVvS90/bFlvewiqcQJmOBIZEUwgiPDZQWrANMxNR3naGqsUUXWdATuIyvZZ6?=
 =?us-ascii?Q?jfuxbkkjAwbAlfhwNaqLBLH6p5C1zEeJ0x3lrmw3dagFrTvqrLoouO0R+1j/?=
 =?us-ascii?Q?jYlAvt840kQenuio1kRZAbGii2l/H7yhYXO8viuMZO6yRTKwN9M4mgOosbOB?=
 =?us-ascii?Q?cPXHMKHPoXhp/irjHtrJCXivL87uQzu9jLEnFNVtFy8bGXjamM+D6+D0G9pm?=
 =?us-ascii?Q?OUMj29lIE6ZXFzd7cApukwfKN6gZ+ZMryQREuN0IazzsugPLdEP09PO4LctR?=
 =?us-ascii?Q?01+2NCBIv2WYf9gPGdf5Y9ZrBNnYeD5ulO1qjNE/m+rkmrikCrlfLwXWoLY0?=
 =?us-ascii?Q?DSeR2xKCIp+4WNvGFI/FU3Ru1H2sOwSY/pf5qQstOytRKdC2vBdV7dNaN5oR?=
 =?us-ascii?Q?vSC+f3YSmpA+RPuA+Nl7d8CNwUmTCVRifck3eCXPR/ZAb4qJPEGh3PzkmnCf?=
 =?us-ascii?Q?8nCs73Q+f2MOosqlF52XdfHct21x7ujA2cCmi+zZA57Q/PFTAx7ne4ra+kV/?=
 =?us-ascii?Q?zKfVx+dEsGhjEAsDWwU5I5cNZbi31Mxln+HWS+s6WXcKU+Oofalf2ftYcuJL?=
 =?us-ascii?Q?ayVKkvn12v18jN7TugNA07U9QDR8C/GHsaV0ZiipiC5u8cfxwUKcQZJ6c33R?=
 =?us-ascii?Q?8gtpEhREXmdHflKz9lu4jomFnWNQZGIQlUJk/Ak68pYhbXyOZf5XVnx9FgHY?=
 =?us-ascii?Q?G2KGqFx4LgKPloCAg3dHkTBpnze3gwHPMrwwS5xznrTp8Bt5vHkTOOUfUry/?=
 =?us-ascii?Q?h0EOHy3Ppd0jy+XrNdydXa4j+522iYu5N4xRKHxQ5khAlTFFDCNthWR9F29t?=
 =?us-ascii?Q?WEA5MnML8NWqCxLnnExYlJGOzoxmTFYTGAsDIPVbxTfenBrWyQGfwZyPt9bT?=
 =?us-ascii?Q?CklRyxulrPj/3iMdfy7RZThyLU5FmI4r/31LL3zosVi5IrD+EYyZ4+rdRGhY?=
 =?us-ascii?Q?YCEbYk2VIYRXIrntzb5iCNptiyY2or1/Osb9R3IrA5JqxU7UP9Sn58+xCu9m?=
 =?us-ascii?Q?iyLecPyalJ+RPHw+q1n7i0/VoLV3KEGd30e52BwVD637c/ZimpOvz5478PKx?=
 =?us-ascii?Q?f5qP38AqPYJoD1zHRwYmmSmzCGDpAA6ZO0BYVSuB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f5a474-2a0c-4fc9-6884-08dc9232e858
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 20:44:12.3684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWCjMKQspYERD2KS8Gk8FlGAfwv4lFvrM1PVRsydNsVJ1XPCBk2pDVEFlde0hdbhmHigy3cYvnC6paWugwR2Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8276
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=tony.luck@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> So who actually cares about recovering poisoned volatile memory?
> I'd like to understand more on how significant a use case this is.
> Whilst I can conjecture that its an extreme case of wanting to avoid
> loosing the ability to create 1GiB or larger pages due to poison
> is that a real problem for anyone today?  Note this is just the case
> where you've reached an actual uncorrectable error and probably
> / possibly killed something, not the more common soft offlining
> of memory due to correctable errors being detected.

I guess you really need a reply from someone with a data center
with thousands of machines, since that's where this question
may be important.

My humble opinion is that, outside of the huge page issue, nobody
should try to recover a poisoned page. Systems that can report
and recover from poison have tens, hundreds, or more GBytes
of memory. Dropping 4K pages will not have any measurable
impact on a system (even if there are hundreds of pages dropped).

There's no reliable way to determine whether the poisoned page
was due to some transient issue, or a permanent defect. Recovering
a poisoned page runs the risk that the poison will re-occur. Perhaps
next use of the page will be in some unrecoverable (kernel) context.

So recovery has some risk, but very little upside benefit.

-Tony

