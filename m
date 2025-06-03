Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5BEC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 03:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMIgW-0002cv-Mm; Mon, 02 Jun 2025 23:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMIgU-0002cT-84
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:51:30 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMIgP-00043v-JW
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748922685; x=1780458685;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3/v23i3dq8p/2i5GDFdhiddSCr/cQrnIkZkLcB7e23A=;
 b=QMjrgg4rh6vC2xIERJb1SCJZOkHZfDzKUD84/CcWktoue9vZrOWzEMlq
 I6YHf+qNZg4+GYwK1PGaPaD9Mk4FL/c/5FaKugE+KPFyElwyEjanFBLSn
 c2qY3VaPaT0DOnGBX6bwdZ5nhzJUg7j8f3aVu+5VyvBjVxYYi7Yg3/hMc
 DX9hpGxT+1D2b6U1YUu/C2t1QN6HErKN1Lj4LmuJ+saMKGJjBYWnJwju1
 WFanRhTQgi1xdePfxNzjUivS/7nILFSoObP7fCMQOWER3x+KyWFffKdJW
 5ciR1luhfAt82srIGiill9dhfRdyyiA7jLpas0pNgx3gtnCLFiY2HvO7x g==;
X-CSE-ConnectionGUID: af10NG2mSa+11hWe/dYypA==
X-CSE-MsgGUID: 2nL1/6TLR8SOVAtA1Ld16A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51013024"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="51013024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 20:51:22 -0700
X-CSE-ConnectionGUID: sPdjF4CIS9eyhv+L4MsFbA==
X-CSE-MsgGUID: +I+GVyfqQaayk3hKKjmMJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="148586456"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 20:51:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 20:51:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 20:51:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.72) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 20:51:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLoBA2oQAct4Ysp7bq1beeOeuP8nWr6yn1+2wlNVvwvEhc2QrGiQfhHzaYEbKNrhN3Lx2a0T3QesOM5/nFdzoUIBRuvMtiw2cysafOE3+wHfWaDRDOyKpx0EEBA4sNkep+3YVDo/eHc3fJAEj11nPbK93V9e7UHFYBEhO1OLOU3BmEd4MVly3WV4X2+pE9zlKEag/G8LsONqYXXXiRJHKQQuknD8jRg8AAY9sJASUYJp6yBNYk16ipZToHD7s8NbMlAjpTXJihVweBzKbFZVw2X3GhOjc7fJiUpYQxLBZd+TBnYhskNX4ZPaif5WPWXScj9iAJwi8SCz1r5VfZwNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZoYSD87m5bcWnZtGriu9jj+NQVcffnH9WT2PgvlMno=;
 b=wofBcI1ctZ3uIjOdsy8GnAvl2WhUEvB2ENDKtgg0w+btWhw0APZHyOeS5oJ6/utSq0sC4/lgdnMuqS6YE8vQqOi+R0Hhkey5TNYL7V3lUqgws4VrrLrXd1zsOF62yRM8WRGyajlVjUdtcmGkpk6MbhI/3zX9bP86swUoJ9EjbkZ7qW8L8bJth+dXqcqAOkzHaNcf/BzU5iYS2RUEpwmN0IdtmymJTfH9Y8bJk70+FfWB+JIMhgcYDogeN8ejISDyvr7ifkxjHj8pcmxuIRLy0dRJMMlMeOsu1ZxJG8bWCSC4YWRBUBI8luNCs9ojFgAeTJILZ+iSb1PB9gub9sxCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 3 Jun
 2025 03:50:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 03:50:44 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 4/4] vfio/iommufd: Save vendor specific device info
Thread-Topic: [PATCH v2 4/4] vfio/iommufd: Save vendor specific device info
Thread-Index: AQHb0Ua612Cm81Yp40OXGB9SHe7n8rPrqnaAgAUnIXA=
Date: Tue, 3 Jun 2025 03:50:44 +0000
Message-ID: <IA3PR11MB91360EBB98E8BB98BBE23309926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-5-zhenzhong.duan@intel.com>
 <aDodfcVaeaYj6iGy@Asurada-Nvidia>
In-Reply-To: <aDodfcVaeaYj6iGy@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB6563:EE_
x-ms-office365-filtering-correlation-id: cfffcdfe-a1dc-423e-d23b-08dda251d166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?A6pCU+Hs6DYhOuLzDzyTfedzlW34tGtOTUZe0NxKXTMJ0dcEl5BR8FdtonpX?=
 =?us-ascii?Q?wtwuhstHezmPwA2daRSQoKPaHiOIe0pu6AV+4iYLFBJQGmBFQkfYMSTl2k0D?=
 =?us-ascii?Q?RnTBcHiI0eD4y7Db/450xzwB/W2wyxS7R6oNIKWus9ldPLOuUnudEnnGHuD/?=
 =?us-ascii?Q?l+evW/KNvGJGgMrJfCQE4JRJz9DkHnf9ukshAOp1NfdMBktCHtQlFyuhNdsR?=
 =?us-ascii?Q?sgh/NnH634uGed9dvohDvwnws+s24O6r2d/FNBMabqB+upbKFflxUFr6YbXh?=
 =?us-ascii?Q?skj6GiLEU50VNgPn25Gutl3KLgPFs//1Lwb3jcvKbAFiQ3A+yg/kBlSdHVUG?=
 =?us-ascii?Q?wwxQLA/O/uhgj13rOCRfMbSpE5l0XZE1FAtUSnPhFVAHAnc/kseWFx/lWt1X?=
 =?us-ascii?Q?Kj0k3ix4qWkfvU4QKPzs+M/JfZT5nS/oWwXUGvtGUSXPeNMNYjmS05/3tefC?=
 =?us-ascii?Q?85CuXbqIR8UGgQFFQEooOxE3e0pPDprvKBi+bLsa9sLCFyT8293z+tMlFFnx?=
 =?us-ascii?Q?uL5T7D6VQleFVX1gAE1M4K9637QZxorVDusbgxlXW1dqsayXnRfKsYEPi7WT?=
 =?us-ascii?Q?SsZCRAFN4ogtDhFudC4MRxLNLxq2q5wxS2zFeveBGTYkTuODNlpSGk3lIRnL?=
 =?us-ascii?Q?NFAB2UG2k7+uSpy/V1PVP61fSaZK3fDeF7zKKAXTZfxJ4bT6QzaJxzMEdXLh?=
 =?us-ascii?Q?lzhcF9ufAtNSETuexUjbFMbGIscRo0BNJdolVwGn0uEF358g13SyMrdJIJwb?=
 =?us-ascii?Q?ouA0bMKwxDme7/uytsVuUHUJW6fJwayAHlKrUaaxUGbDXNhF+o88WOtxrz7M?=
 =?us-ascii?Q?sOHVzuH6talv0hrcbvfCs6tvbnLf/G2aOqIUKyvTHjSruL/C3yWzR9GYZUXE?=
 =?us-ascii?Q?Wa0nEC4hr/jZKTOB7xcF3VwZyDJvDbzFHGQYiU61NspiIBs8m6ReZLR1CnU8?=
 =?us-ascii?Q?4+QWUfDYl+0AHKmMdhSzZ6V779nfdDFyc0jnUArDjWUGN+u5xj9IN3AKaefc?=
 =?us-ascii?Q?VVlgd0zhledb4KKGNyj+8ZL6fzqqBzi+C8I7ygAc/Ep+f4gduiPZ5585vvxs?=
 =?us-ascii?Q?tcDvoXFmYMROX5kXnD50CMrSZgDg5YewTc5uZMlntInAGXRVwUFz2oaDWJ1T?=
 =?us-ascii?Q?GMN/i+XkIxV8sAnqo+jgE0CaqKIdxxQBHnNH7bESXRRcTKlMiUUU2+TboEoi?=
 =?us-ascii?Q?gi6fPZSDKOfpwxnkjsUgAkQSG3wl+4cqE2qggs0Wcs9Z/AjNPrXIqda4/AZF?=
 =?us-ascii?Q?BEvuq/z07o2ORSd1ze7PML0h265/xAlHGvCm/PXvIliyVv5ZoaxWRMeApvQV?=
 =?us-ascii?Q?hsHymSypyr7DSxced4eItnZf2JPt20vmvSd+Uae7RRtYI/DSjS8Py8j2lJLE?=
 =?us-ascii?Q?RtVGLTuFT2Zdvxqk3+QxoP7ixqNhwzri155nfEks6PCYOr2K6vGm2HSo77OZ?=
 =?us-ascii?Q?cRbEOMU6SXd/FhJKsf86GIbrsumeQQPCT2tNPIZ8AmkpGNFer7eLqYim0EDY?=
 =?us-ascii?Q?38cY+kTNGkYEgpw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mXmnqj6B1Z5xZNkXNkF9B+jrLhIgj3RDt1h5/L6/1kaiPEs7kGajJgG8+jkJ?=
 =?us-ascii?Q?TJq+6BF0pZhj9n04vUNoekl18QQaE8lmwAVBJ8HAYAmMh+9Wp/a6JooJFMXG?=
 =?us-ascii?Q?Fb64R+ZxsaUSmRo/aLaLEzD7bsreIccLNXBn0FpNUghMjB3CR7Hih4bMjbZO?=
 =?us-ascii?Q?fZcViTreoCgtLio67RfLrDlVeUpgycPEHQmxrXaERENSVbLWU+0PlFoB+GKM?=
 =?us-ascii?Q?kcGZaNYlmFUue6+MRwzecreBfHzCBCV5UXuh7y0DC8u0crab79IoatqpTuj3?=
 =?us-ascii?Q?p4a/c9OHhzI34UiriNYmuhgClZ5Fr6XWy3LdLh3uoamSEXyx/IJ/ZdYmHcx9?=
 =?us-ascii?Q?3vd6MZTOG/b+RTxiq6OYLmODXdE3Kcc4NlsXEI0TQriYouNE8OJus8n2fd8X?=
 =?us-ascii?Q?TUo1iGJJBzapHhJQYKajmHXNtVUPJE61a3AjP0Wmn080nwDrkYkQKkqVqwzy?=
 =?us-ascii?Q?Zcov4opx6FcveJfyV2ro5WcgtDNi3A063EOsanqAYmNwGhQ8RVVXE9aY35tV?=
 =?us-ascii?Q?An7oxEaGapFqMoIGNLaHTXB5NhkbJms79Eyju5YMqUjVrD2HDqIm/36i55xT?=
 =?us-ascii?Q?hF20RjDMjzAr2ROoRb2CVo1kCcXWNiZzV7pC6Gg8r9a/pguQ8dMxPwomTMAY?=
 =?us-ascii?Q?26K/s6lges3gGotoTrZJfhgoqPMuoq3bYpkhkrEChVb64MFqthoqs+fmHurg?=
 =?us-ascii?Q?RDXvJEBjzHGKBnQL0VJy1muxW/MsrEs53KnF3IfgxRu5x70i6UpWsOKR6EZm?=
 =?us-ascii?Q?KpwB0szSkXhTiWxIh/Okfab61QW2cw45C8+Vvb2rtX8wTQSH3vKYTdp7jUsv?=
 =?us-ascii?Q?baEKgMRkT0329O68lW645CN/v+yJmaHHQ/jRCWJO60DBWzCySasfeNSxwsa2?=
 =?us-ascii?Q?zMHXpOpULT7+5hJhjDL1bR0u7xP8Fu0Yl3gU3FdHnXeh2Q4Lp5A4t77ET4V2?=
 =?us-ascii?Q?HLVCUFTBaW9NfEXBGhnLF7XADZdez7MPFaBLMDFhES4Vgem6UbhNUMHFRy0I?=
 =?us-ascii?Q?PjyaVfk4oMoXGFIaq75X5//kzYOmC2X6/N3pAgzNbB1sujPBNxrk3j7yMou8?=
 =?us-ascii?Q?i5pP0zGHm+KbBd8dS3HTSJWp30lOx+1mpeeXGH91WUy3BPrOJ5ZdGosHrnML?=
 =?us-ascii?Q?NkDquhMNi3fg/Kj6kUexKVsDwvzcPIDU8sCEG9Hynf+aXKoA1Z0DQvqQrfjn?=
 =?us-ascii?Q?YpxyRc3yN93AKONqZZBfYYsRHCnZCHs/Ek5vtzsR12Uk4CW5/9wL7qZ7+htY?=
 =?us-ascii?Q?4I8+55HYf53PxWdeFWqn+0u25C3CR48q+c4/WCrykVabAIXMl8q0VlDsFxUv?=
 =?us-ascii?Q?GnoW5kti2Bo6o+n3p73aSM4OCxjQl/TTXredPPrvPV7w6TJeSVYo7PwtiKoc?=
 =?us-ascii?Q?2aUxBBp63RelpUAw5me7scrrq0L9jbM3nlvfn6b6S2Q0/7HiUh6NShWKajPH?=
 =?us-ascii?Q?QiW661A+HCr5LBl8LP00evII58mrTH/zVBP1VbpRhsnjdgGms0bXZtaTbdV4?=
 =?us-ascii?Q?gPeqGSshjSPL6DwUv0992zNQmL2vyHCFAg9xjHQlSRaVdO60Dte/Lo+b0zsj?=
 =?us-ascii?Q?u35tnBrCyC+qZtFhT9nJSY9pLmfy1Mk0lA8RR4og?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfffcdfe-a1dc-423e-d23b-08dda251d166
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 03:50:44.5488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBkNcPitqfRkTSENqe/qcIoSxeJm7qbzkMEqQZZFZYwBrwc5q1QyK3Ne6iZqqfn3FEGLinGWrc++gzHi8yPRmd3aiElN6DbjcDA6cTPPLbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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
>Subject: Re: [PATCH v2 4/4] vfio/iommufd: Save vendor specific device info
>
>On Fri, May 30, 2025 at 05:35:12PM +0800, Zhenzhong Duan wrote:
>> Some device information returned by ioctl(IOMMU_GET_HW_INFO) are vendor
>> specific. Save them as raw data in a union supporting different vendors,
>> then vendor IOMMU can query the raw data with its fixed format for
>> capability directly.
>>
>> Because IOMMU_GET_HW_INFO is only supported in linux, so declare those
>> capability related structures with CONFIG_LINUX.
>>
>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
>I like this that we eventually moved all vendor stuff back to the
>vendor vIOMMU code.
>
>> +typedef union VendorCaps {
>> +    struct iommu_hw_info_vtd vtd;
>> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
>> +} VendorCaps;
>
>Nit: can it be just:
>
>typedef union {
>	...
>} VendorCaps;
>
>?

Any special reason?
I didn't see anonymous union is preferred over named union in docs/devel/st=
yle.rst

Thanks
Zhenzhong

>
>>  typedef struct HostIOMMUDeviceCaps {
>>      uint32_t type;
>>      uint64_t hw_caps;
>> +    VendorCaps vendor_caps;
>>  } HostIOMMUDeviceCaps;
>
>Ditto.

