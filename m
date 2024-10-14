Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D75CF259D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 06:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0EDm-0006Ie-JS; Mon, 14 Oct 2024 02:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1t0EDZ-0006Hb-GB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 02:06:09 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1t0EDU-0006hC-MC
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 02:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728885965; x=1760421965;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=k+LQnnpFhLkjP0nKNHLF/lPe5q5ReyZWqhwhzkadSnE=;
 b=OYbEOzjhrDLe4bB45KniWpO92cgO4CokruQa4TdkCSiX0vlmN0KzNKqN
 D52mhTr1j6IYwI6CQH/y1Am8TmfyGPtc30cJQVpA5Qu7AhILjVwC3yQZ7
 ydmPz0L9R0RWFF0w06bDwJysA/rNIoiwRUIt2PxoHNex7ZYZMZVKR5HVi
 TFpLK7n7G4qYhjNbS2yP4aYbLVB1iFIC0W4pD7hkaJ97uHGJH1cBACq/k
 rp7QH8VLrU4FACAvzzLQdVJq37K5eb+lQJtN9SeTVxenlelhzC3JCMM2B
 0/Xwt3cUD/eTCuj8xwwbk1BJso7cdVec0wEaFvb7mZwY+CmAnCfgvo1nq Q==;
X-CSE-ConnectionGUID: Jiup1hmmR3+CFNqFd8bB1Q==
X-CSE-MsgGUID: MaWCnKboTlGWdcnxCezYxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28404969"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; d="scan'208";a="28404969"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2024 23:06:00 -0700
X-CSE-ConnectionGUID: Eo+w4fxhST27WpM9C3KB3A==
X-CSE-MsgGUID: k3E3EXdrRqq8RtDogUwlVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="82265367"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Oct 2024 23:06:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 23:05:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 23:05:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 23:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dcss+2aHs6ZVcqiBIklNSc2bDbHhZ2QGM6o2rqwDB2HY2xMD8ctdis9ejooQrA6q7PF3GNWAqAzUuV3Z3Rxch/2p+z2cwZbtkCyzhTBunlz2WVo3OIWvik4JvUQGnJuRgzFxSmQstKiav9pknIwRI+7BHcX+UOlKiN+B52RjHBacPtBCMH7JSd1bT7gSK4bWillKx0Y9bkB/mV99rdFfB1dTWUJHwJQC2OK5KVX6eHfSvQ+V5Vyy+2rQ3rwaMe/GN8TDDZw1UR0mza84kmlOzLCcmT5bmDY8iv70KqKQ39fiIANykGdKsB3gTf5vp4s965VCmcOwP8H2kK2YWJtwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZYTDfwa9i7U62l3MB5mzdNmK19hw4kygZG1nqTFZNs=;
 b=fxNRlMCeL/sbsom5l0ROSm1Btk6/H38sWnIkQqFiUiuD8jjxVAI07cN+B/yvs6tMi+Xu8z9rMsuv0hcXGPHNFh0sSkWs58olD3VVEb5JfY1Mev5P6sIby/6Kb1NLjf+ViSibexU4/IKbeJCJMl/Ff0X3tWE6ZYGU+f0QNaDWqjLpM5cCPFmmACKwDWFhYUXnBMSNz3z6aN240Ph+lCKZk/QZJ7DXIZWg8EixbH+ZDja7LHY5OSLFxX4l6UqdKsQdEyCu4u1y/a7WmkFEnH+d7VlQudX142X7rsA631PqE0L1W0GYHb0DRooUY+tirLdJ1vgE4yteIbS9UTBMOY8shA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 06:05:56 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::5c9c:bb71:47cb:f4f9]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::5c9c:bb71:47cb:f4f9%5]) with mapi id 15.20.8048.017; Mon, 14 Oct 2024
 06:05:55 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Yong Huang <yong.huang@smartx.com>,
 "Zhang, Hailiang" <zhanghailiang@xfusion.com>
Subject: RE: [PATCH] migration: Put thread names together with macros
Thread-Topic: [PATCH] migration: Put thread names together with macros
Thread-Index: AQHbHAzPYe/to1su4k2pOP3RbDRMgrKFxeCQ
Date: Mon, 14 Oct 2024 06:05:55 +0000
Message-ID: <CYYPR11MB843298AB238610364FE102419B442@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20241011153652.517440-1-peterx@redhat.com>
In-Reply-To: <20241011153652.517440-1-peterx@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|IA1PR11MB6418:EE_
x-ms-office365-filtering-correlation-id: 38605d88-5e67-4b00-09e4-08dcec164445
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cws64gkUfDra9Huuche2qGY3lnlsjPgrV+u09feOrLClsYKlMKgEC9XrEKh8?=
 =?us-ascii?Q?s2+KnxTGvz0hw26bn3irJ9VXiC/9UPTpadw1Gb8g0M9/Hay7B6gORNM6Pxiv?=
 =?us-ascii?Q?Yehvn4qugJmPtbZix8pj/twg+K31D7pL8ABrgc5pQAYpvgkfOp2WIzPEIne4?=
 =?us-ascii?Q?lGGRdZpiuEq7a7q7Mpm9UG9m5Zn6EENoxDw74+3CIko2cWi1Yh58VBXfbb9H?=
 =?us-ascii?Q?nYPactVceLH/U2kx50TRCvpZ5VUnlKdfHnz86RihqcO5BfLW1nyMmYqBlwIi?=
 =?us-ascii?Q?WwnKEU5+Rs/l5ahCn0H9VtKvhkucqpOkGvhp8SW1jRhI8HyC8LEn7z1eQTAo?=
 =?us-ascii?Q?+xUyYosW5K106jkErHjhnQo5KpvNa/0MxqaFsNCBmUKvpdC/+smdLZKmvT1B?=
 =?us-ascii?Q?A+9/k4BLTJSp0pLBLkqZrghFbK3JqXNFqWybT2rLRlXvV8S9q7+3KuavdcIT?=
 =?us-ascii?Q?Hk3F5883qWjss2H1loMGi0u/EBYGFND8pMV7jv0x6T9BaVWKjszk3m8jHRYb?=
 =?us-ascii?Q?M6FTkHKrVl8UcI7yfgOQRbOuNXYFhEJlSOneA/xurDD7hN4ho01kHah/GysC?=
 =?us-ascii?Q?qk0kub4uCWknk+gfXkmLbILeYcxtRutp59H7o8Kz6x1yFOpoIV8vEj1gIjc4?=
 =?us-ascii?Q?dVf6hSaLvJldskmpBnueoo4b3eQzECgYxBqKfhI54nLU493rmH1tcCiSJQv2?=
 =?us-ascii?Q?0JGvZwem4SDaAXChr80ae6U1r5nJY1S1wjXI1yGJdEWgsYMCVVjgC0+laNWB?=
 =?us-ascii?Q?JiLyVe6wHqph/d4dUGDC9is+38XUd3tLyD/5J4TZMARLYPMF06RD3RonaXn/?=
 =?us-ascii?Q?vinAUFQJH7bxOymGtGw1ERLHtOpoVKblkcUEK6qa7UFK9PqaXnxLScgAiu4s?=
 =?us-ascii?Q?RP2Z8ff1W6WpFx5X49oCSIdCCrurUoWbhHXoq2BjivlxcZS5nRqEFIa/bTfF?=
 =?us-ascii?Q?WqNZ1mG8bL+ofo7exoPRADO0hxZ71Uvp+obrEjz/K4siTIVRZJ3IjV//lsJQ?=
 =?us-ascii?Q?KdL5fY1IASfiNy1qQ54SGEDg6YhU1dC0RpmAzVEhAWSUCh8MrkMNnfVFyOQE?=
 =?us-ascii?Q?UeZ/3ISUbljU/uW842z5ur8Xhb/wH9ULLZYJpM+sUv3jw5aFjKzKHHksZ8CE?=
 =?us-ascii?Q?L4qMNjHXi308Djv+E3WV8lR1CAxJFyWpdlQnGBndgLxLNl987/V377DwIiLz?=
 =?us-ascii?Q?3ud8Ot75A8A7FXXNO805LhzibfG1pnHUEunAe5cXJOpLdIZqbc1CVtU21h/+?=
 =?us-ascii?Q?jDVWXi0Demozwlx32iQ8z/A8OmCHCT2gDxXgS4PuR8vjBWp6HfGW9h9fUTfX?=
 =?us-ascii?Q?hw2Ye+ZHlaIqE8nG+vQFUBDr6Oqg5aUZ8kt5cHgxToNIwQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cOakxaDTPNSaAV8gOaAYrL0NKi4omiYSMDKulSBeV0Z9DvTF0B2XK+FSyO6r?=
 =?us-ascii?Q?drKIJ1M4s4XaxX+d5l3z5CJJLWZ3H/YsC/yQB8+4mUBZnbh3xKT/86u7lRkk?=
 =?us-ascii?Q?xyKIUG7kuqjOqv47pJ+X7l6t3qLHx6VXFOOmhjiTyjUwaTUHOFdEbD9Zwblc?=
 =?us-ascii?Q?PjA+oW6hP8n0nGnkdtQUVgLtyLvdk97CHvUNgX9tp6S9Gd8bCessl9MRycNg?=
 =?us-ascii?Q?0qDKUh8dT8cueLNVU2ao9R0sZZ7MRt+wgGV2D1+eDdjuH1ey3PHaXovNDYWY?=
 =?us-ascii?Q?PKUnt+wN2O2G351TwTtx22vEhmoAZnlEVEl1v0DyW0rJWwfxJ+FB3LHkpBrY?=
 =?us-ascii?Q?iDKUik1+FgTor60YZyWMLS5Pe+SjkZc/LZQQGie6Z/nt7HCy/k/+jG5JuMxl?=
 =?us-ascii?Q?m3dU5crAZLWoMXZjp/rxWGD5fCAoYtctufXdhSLB1skZNFjUrBLfNClM1p+P?=
 =?us-ascii?Q?1c+/zEzNn9rlKx4Ku9U6hICb4bg7zOcGtF99fsfEN/Ho/UtIXv6QCVCENTrc?=
 =?us-ascii?Q?s6I6Y2IzAZNpKsYW49VPBsjCnLNpM4tzD8pih0Wduu/xTkzRe775PxLNxJpl?=
 =?us-ascii?Q?bD8LFoUhkANIg2JHCmI7L4umIiq+CsOabe4+QtZ3Nt6wPWuELWGcTA1aeVW1?=
 =?us-ascii?Q?aOHkRTIV1fDizDRGYQY/eHMXzNYKtO8w2vY7pcVjlhRnmCmhOpSks7/XqxoH?=
 =?us-ascii?Q?NyVTRF34Gi/vL7iY9jh1bccZhlIgWlir394BxI7dNlzTcaTckRLJDIsV90yq?=
 =?us-ascii?Q?4XcoPKLVX12nrmx9/Cfa9sn/W3xR37o4eMdNgxNmPWv/92EIRwET9w9twewM?=
 =?us-ascii?Q?r4RrRyzfqexY8bQybKTx317ZAODoz46LXw22VyLEGvF+EpVdCHq4ZDUgQg7u?=
 =?us-ascii?Q?25qzSxm/JVF9avbkGXte+iVaEwDGFKXDiydD7Zzor7sWVNv1c2bX3bpCOTOn?=
 =?us-ascii?Q?Y2DV3LolVGoKUWiIflm3XBhuYMWp2wyO2zv1ndfkaEr/CCR4MBd5yULtyGRl?=
 =?us-ascii?Q?m0k7ZfWH0sK4a7lj6/R/MVDOb6AsKFiEAqMXfEFJ1ZVB8mJQMD7CopHeZhum?=
 =?us-ascii?Q?KHgfjSjLTy1/D5dTs2P6TH4kBxwfp5HVbFTUUV65ujHoEWtToY1AIV4vZllW?=
 =?us-ascii?Q?+vm+bBvLUJx49IlZotyZCIRUdnsIfz8q3/+SQtqOySoW5/erylZveq0q0QJv?=
 =?us-ascii?Q?oIFauBMxnvynJRcO6LJ1w3JRgTaAiMffu/L1T2II6q5VezCZdrQ3UCwjaknH?=
 =?us-ascii?Q?f1wPL3S5KkUYY/Ol4YRcf4kWuJagcZ04/ZxTIVHASJrR/mzp2JRSmSAm6A/Z?=
 =?us-ascii?Q?5E5tb1yZEoym2gWGSVSpvDC/XV2Lx5jmSiYJWVm0y7Niwu+Jfe6i7pm+Qs1q?=
 =?us-ascii?Q?muIGy2gjrQ/Q6J6xjacozjkBk9AiGzO0+QRVTnmCKkOyZIQzbSOe7pSLbcon?=
 =?us-ascii?Q?KfqViK1MgjFGTyQtt/mLotLtONhnI7eAMISq7jWrBnmgi+HF42AzknRARN/p?=
 =?us-ascii?Q?3ZZuuLkFEbY+hBJh24zamh8taeobmshOqt3MvLe0sE3mULlFuhbcEk/1jYXo?=
 =?us-ascii?Q?i4RpJZp3HgdXGRqpC9TtQcQ0+iEsIuB5wdJSNcOm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38605d88-5e67-4b00-09e4-08dcec164445
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:05:55.7979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayGPJ+S0+K3zQBMnaGE5qQSb+QOftSU9eYPm7+Cmbm9UGo4SzyyLBLUM3nUPNSiNCusOl9/QNO0N6yVNuUC7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6418
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
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



> -----Original Message-----
> From: qemu-devel-bounces+chen.zhang=3Dintel.com@nongnu.org <qemu-
> devel-bounces+chen.zhang=3Dintel.com@nongnu.org> On Behalf Of Peter Xu
> Sent: Friday, October 11, 2024 11:37 PM
> To: qemu-devel@nongnu.org
> Cc: Fabiano Rosas <farosas@suse.de>; peterx@redhat.com; Yong Huang
> <yong.huang@smartx.com>; Zhang, Hailiang <zhanghailiang@xfusion.com>
> Subject: [PATCH] migration: Put thread names together with macros
>=20
> Keep migration thread names together, so it's easier to see a list of all=
 possible
> migration threads.
>=20
> Still two functional changes below besides the macro defintions:
>=20
>   - There's one dirty rate thread that we overlooked before, now we add
>   that too and name it as "mig/dirtyrate" following the old rules.
>=20
>   - The old name "mig/src/rp-thr" has "-thr" but it may not be useful if
>   it's a thread name anyway, while "rp" can be slightly hard to read.
>   Taking this chance to rename it to "mig/src/return", hopefully a better
>   name.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Chen

> ---
>  migration/migration.h    | 14 ++++++++++++++
>  migration/colo.c         |  3 ++-
>  migration/dirtyrate.c    |  6 ++++--
>  migration/migration.c    |  9 +++++----
>  migration/multifd.c      |  6 +++---
>  migration/postcopy-ram.c |  6 ++++--
>  migration/savevm.c       |  3 ++-
>  7 files changed, 34 insertions(+), 13 deletions(-)
>=20
> diff --git a/migration/migration.h b/migration/migration.h index
> 38aa1402d5..b9ce5aa4ff 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -28,6 +28,20 @@
>  #include "sysemu/runstate.h"
>  #include "migration/misc.h"
>=20
> +#define  MIGRATION_THREAD_SNAPSHOT          "mig/snapshot"
> +#define  MIGRATION_THREAD_DIRTY_RATE        "mig/dirtyrate"
> +
> +#define  MIGRATION_THREAD_SRC_MAIN          "mig/src/main"
> +#define  MIGRATION_THREAD_SRC_MULTIFD       "mig/src/send_%d"
> +#define  MIGRATION_THREAD_SRC_RETURN        "mig/src/return"
> +#define  MIGRATION_THREAD_SRC_TLS           "mig/src/tls"
> +
> +#define  MIGRATION_THREAD_DST_COLO          "mig/dst/colo"
> +#define  MIGRATION_THREAD_DST_MULTIFD       "mig/src/recv_%d"
> +#define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
> +#define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
> +#define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
> +
>  struct PostcopyBlocktimeContext;
>=20
>  #define  MIGRATION_RESUME_ACK_VALUE  (1) diff --git a/migration/colo.c
> b/migration/colo.c index 6449490221..9590f281d0 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -935,7 +935,8 @@ void coroutine_fn colo_incoming_co(void)
>      assert(bql_locked());
>      assert(migration_incoming_colo_enabled());
>=20
> -    qemu_thread_create(&th, "mig/dst/colo", colo_process_incoming_thread=
,
> +    qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
> +                       colo_process_incoming_thread,
>                         mis, QEMU_THREAD_JOINABLE);
>=20
>      mis->colo_incoming_co =3D qemu_coroutine_self(); diff --git
> a/migration/dirtyrate.c b/migration/dirtyrate.c index
> 233acb0855..a74a6aeb56 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -29,6 +29,7 @@
>  #include "sysemu/runstate.h"
>  #include "exec/memory.h"
>  #include "qemu/xxhash.h"
> +#include "migration.h"
>=20
>  /*
>   * total_dirty_pages is procted by BQL and is used @@ -839,8 +840,9 @@
> void qmp_calc_dirty_rate(int64_t calc_time,
>=20
>      init_dirtyrate_stat(config);
>=20
> -    qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
> -                       (void *)&config, QEMU_THREAD_DETACHED);
> +    qemu_thread_create(&thread, MIGRATION_THREAD_DIRTY_RATE,
> +                       get_dirtyrate_thread, (void *)&config,
> +                       QEMU_THREAD_DETACHED);
>  }
>=20
>=20
> diff --git a/migration/migration.c b/migration/migration.c index
> f5f428e764..7609e0feed 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2484,7 +2484,7 @@ static int
> open_return_path_on_source(MigrationState *ms)
>=20
>      trace_open_return_path_on_source();
>=20
> -    qemu_thread_create(&ms->rp_state.rp_thread, "mig/src/rp-thr",
> +    qemu_thread_create(&ms->rp_state.rp_thread,
> + MIGRATION_THREAD_SRC_RETURN,
>                         source_return_path_thread, ms, QEMU_THREAD_JOINAB=
LE);
>      ms->rp_state.rp_thread_created =3D true;
>=20
> @@ -3473,7 +3473,8 @@ static void *migration_thread(void *opaque)
>      Error *local_err =3D NULL;
>      int ret;
>=20
> -    thread =3D migration_threads_add("live_migration", qemu_get_thread_i=
d());
> +    thread =3D migration_threads_add(MIGRATION_THREAD_SRC_MAIN,
> +                                   qemu_get_thread_id());
>=20
>      rcu_register_thread();
>=20
> @@ -3823,10 +3824,10 @@ void migrate_fd_connect(MigrationState *s,
> Error *error_in)
>      }
>=20
>      if (migrate_background_snapshot()) {
> -        qemu_thread_create(&s->thread, "mig/snapshot",
> +        qemu_thread_create(&s->thread, MIGRATION_THREAD_SNAPSHOT,
>                  bg_migration_thread, s, QEMU_THREAD_JOINABLE);
>      } else {
> -        qemu_thread_create(&s->thread, "mig/src/main",
> +        qemu_thread_create(&s->thread, MIGRATION_THREAD_SRC_MAIN,
>                  migration_thread, s, QEMU_THREAD_JOINABLE);
>      }
>      s->migration_thread_running =3D true; diff --git a/migration/multifd=
.c
> b/migration/multifd.c index 9b200f4ad9..697fe86fdf 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -723,7 +723,7 @@ static bool
> multifd_tls_channel_connect(MultiFDSendParams *p,
>      args->p =3D p;
>=20
>      p->tls_thread_created =3D true;
> -    qemu_thread_create(&p->tls_thread, "mig/src/tls",
> +    qemu_thread_create(&p->tls_thread, MIGRATION_THREAD_SRC_TLS,
>                         multifd_tls_handshake_thread, args,
>                         QEMU_THREAD_JOINABLE);
>      return true;
> @@ -841,7 +841,7 @@ bool multifd_send_setup(void)
>                            + sizeof(uint64_t) * page_count;
>              p->packet =3D g_malloc0(p->packet_len);
>          }
> -        p->name =3D g_strdup_printf("mig/src/send_%d", i);
> +        p->name =3D g_strdup_printf(MIGRATION_THREAD_SRC_MULTIFD, i);
>          p->write_flags =3D 0;
>=20
>          if (!multifd_new_send_channel_create(p, &local_err)) { @@ -1259,=
7
> +1259,7 @@ int multifd_recv_setup(Error **errp)
>                  + sizeof(uint64_t) * page_count;
>              p->packet =3D g_malloc0(p->packet_len);
>          }
> -        p->name =3D g_strdup_printf("mig/dst/recv_%d", i);
> +        p->name =3D g_strdup_printf(MIGRATION_THREAD_DST_MULTIFD, i);
>          p->normal =3D g_new0(ram_addr_t, page_count);
>          p->zero =3D g_new0(ram_addr_t, page_count);
>      }
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c index
> 83f6160a36..a535fd2e30 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1230,7 +1230,8 @@ int
> postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>          return -1;
>      }
>=20
> -    postcopy_thread_create(mis, &mis->fault_thread, "mig/dst/fault",
> +    postcopy_thread_create(mis, &mis->fault_thread,
> +                           MIGRATION_THREAD_DST_FAULT,
>                             postcopy_ram_fault_thread, QEMU_THREAD_JOINAB=
LE);
>      mis->have_fault_thread =3D true;
>=20
> @@ -1250,7 +1251,8 @@ int
> postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>           * This thread needs to be created after the temp pages because
>           * it'll fetch RAM_CHANNEL_POSTCOPY PostcopyTmpPage immediately.
>           */
> -        postcopy_thread_create(mis, &mis->postcopy_prio_thread,
> "mig/dst/preempt",
> +        postcopy_thread_create(mis, &mis->postcopy_prio_thread,
> +                               MIGRATION_THREAD_DST_PREEMPT,
>                                 postcopy_preempt_thread, QEMU_THREAD_JOIN=
ABLE);
>          mis->preempt_thread_status =3D PREEMPT_THREAD_CREATED;
>      }
> diff --git a/migration/savevm.c b/migration/savevm.c index
> 7e1e27182a..e796436979 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2131,7 +2131,8 @@ static int
> loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>      }
>=20
>      mis->have_listen_thread =3D true;
> -    postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
> +    postcopy_thread_create(mis, &mis->listen_thread,
> +                           MIGRATION_THREAD_DST_LISTEN,
>                             postcopy_ram_listen_thread, QEMU_THREAD_DETAC=
HED);
>      trace_loadvm_postcopy_handle_listen("return");
>=20
> --
> 2.45.0
>=20


