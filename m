Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A85EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7iC-00015R-GN; Tue, 23 Jul 2024 01:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7i7-0000rH-Vj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:05:15 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7i4-0007aT-5D
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721711112; x=1753247112;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4vSnJLIQQNc1lOc/kQgH/465K00BW2KZ7D0mSnb+6O4=;
 b=BnNPMlNuEvNaE1JyeC9YcZCADcOFBykauAu1hMjMxDBOpGHJ3MDIHuu5
 wfeAt+Cf4uT/3950iotrOPNnYh+SHXlWu1AytVh8BH3zNt+Uzx61rOSWr
 Ghfxl//SOR9jtlNBIfvKbSvaKmccdOQMn5QANgiO5NbwpZQ/KugXxK4zt
 Co60MdYj3forida4rdKiTqHP2gychr0Hc9YguFyEtdqamtqUkBiUiByxU
 2bVM3dumIRpO+LSwtQAsZiXmdKE1V6qXzz7Cx3MQS0b9kOYKsVowyPDQ+
 NUY8OVCNn1+BGXm6/AHR9SO0DMyhxgnFkDwWGi1rmDK6tjFUOsA9Mkdc1 A==;
X-CSE-ConnectionGUID: 2i437wAqQ+Osq1dV706jfg==
X-CSE-MsgGUID: /x1959NjRTWtRf7xWm9C+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19188232"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="19188232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 22:05:09 -0700
X-CSE-ConnectionGUID: yEyXkxLUSa+m4xIIun50qA==
X-CSE-MsgGUID: K3saRB4FS1OE/P78/vRECw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="89570365"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jul 2024 22:05:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 22:05:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 22:05:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 22:05:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 22:05:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMcpWSYIzUUP2b4CeIJsjatv/5eFiCfAj2Osabi2a5ITt2IpzSC0n9Kvc4APnlGbnR7T7Nhg84KOvDbiCLLuH+s6t8fv8K3GmB8ltkGGZHSdCo7RBdIe/UedZyMcfaba6dvx8QXV3+pP8+mi04zEbD9yLIg1C2U2SC2acq3Ky1TWURaWsihihh1WeMovcKFZBIN/BUU0WMfcurDo/TH9rat2mNmou3pDShmITN+UEiYiH3lzrZDxC+Mw0s7gBlR1WjD1//zQpQuoDb1dFEIlfcpmURyho/s4lY3GAbXdgBtZ7epBTJZGC8vqJ1EVkbRdYeHfnXwW4UrmShwSuSDDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efjUUqlWzvryY9R1kZlcyUkk8Hq9U0qRnInAyeS8RlU=;
 b=xHzCyRQs+rSZ/6ABBGsLuOL6qgnTot2FnZBkJ7vrmvPBUBbfO5bUW7tjukN4OnUJOTTNgybhqslf9tegzJ/kZcwaB5cuxlh/aoLYkYiHwh/OV36mfz57fPAfOtgHcuGbrBZ+crZ0qbCJKJpaDoUdyJ/OKO6JJShKiHmHTITfXIZV6HSMlzq0O92iluJ+PLearSU0wBCa3Aahak1Fq2D40eI0bXxN1m7WbgUxfGkOp5Y9ZJOJ3SUX1xxkjL/64yavQKve27SZBnTi+PCblvJOEKRRgREdL9lKcVQ2P2gaDFts9a91p8b6YsgSYjbBNUrUoXQNYj8Sih17PXoRwMctwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 05:05:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 05:05:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v6 9/9] vfio/common: Allow disabling device dirty page
 tracking
Thread-Topic: [PATCH v6 9/9] vfio/common: Allow disabling device dirty page
 tracking
Thread-Index: AQHa3HwpXCOW4NT1nUGw6sWeASpqv7IDwrUQ
Date: Tue, 23 Jul 2024 05:05:05 +0000
Message-ID: <SJ0PR11MB6744B506DEB60DFB170D9CFA92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-10-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-10-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6931:EE_
x-ms-office365-filtering-correlation-id: 5a25786b-e85d-4bd5-833a-08dcaad5045b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KQc8QaTBTdX5N3eaFOxNAiZDqPASZc11G0XliHgrpDvQ5iLVTtwxkpJpzEk/?=
 =?us-ascii?Q?KpMQMDeNAbAH5Ot5tZrS97yawO0SvTie0gnK8ugrzx44ho95jS7mdXiEqXl+?=
 =?us-ascii?Q?XJ+oJzqqyyyvuQIxF0FwEvqzFoDiRAF0coDpMcM47ISj6KaXOkJx5MLEMkv2?=
 =?us-ascii?Q?2g10pe4LFs7a5GeScqxUuWC50awOdIBrp8o4L5YfWFStBt3Ti34XTjj+ycIY?=
 =?us-ascii?Q?HxABOu4vZqUnwTIPKfuDWi+qXWkrJ2f12F9Eu7Mqxomr196gEAHHfqkZdjtj?=
 =?us-ascii?Q?ASpjXFNln03wj7deSovWWYpTdNHDZMAQnRdFql1RoaMjQdZlp4Bnz4/8RZy8?=
 =?us-ascii?Q?WyuJYO61M4LAHOZe1YE1L//T7HWzA6Y6i4hsk40KcfXNV9KUAbjA1a6ToNb+?=
 =?us-ascii?Q?a2t2TScH/fcW9ikN0PkIAqGIARB9phvNH2rlo3211mBXKMK5wt0QExXbCcCK?=
 =?us-ascii?Q?FeWhR53JD+lEqsQzGeQRcpD1I1NCNTWsTflqCas/ZgOg++AsAjPra+Xez9sF?=
 =?us-ascii?Q?mhavFZ7Wc/iE+nvcnTEk0Q+4AywAVYUOZglDwVjnZcETGkDs9ET9DUlr1Z4T?=
 =?us-ascii?Q?4SZ+jLIIwgzJkK0Wa7flTz+Apz8RMBfKa3Rcc67ceLlollZzE5Q/sF7fVmOZ?=
 =?us-ascii?Q?ynXeE7Sv2ggCRr/6gS9xvz/j2D527osA1KuJPV9dTCzq4ifaceuIPZK/aH9N?=
 =?us-ascii?Q?tkmMcJnF6ouKC0Fa8BzicPNCZmAGBMqFD0OLm7k7+uzXkbvZY0k9OuXlE/rv?=
 =?us-ascii?Q?7WkmG8OFC6SSG/jBXKYvTp1zKo9ylwVR0VxaAsndaOpqMixa9pm5mLp0nw8u?=
 =?us-ascii?Q?RIC+uyVOWDSxco6iaVYWq4UnDMlt5zWwPcdH6U+rDZjZbJaVCJaeTw34BffB?=
 =?us-ascii?Q?9I69AxHY3T8OxxiyL7xI00IkoJP1CqhIHHGHIbRHYVd+rhqRCT2e17sfLHKV?=
 =?us-ascii?Q?108e47IZuq7fSkOnzZad1I2XP9MZdJQ9NleZkyYfKfh/9TQiG0MLxUl+3629?=
 =?us-ascii?Q?b6jGuMA3aKQi1UJE92OSy040fAGZZBSfFMQrTvGwikJ8SOrOZoREpdFXo5kV?=
 =?us-ascii?Q?I6KnfWeq7m4Y8y6ZqfHPAg69UGKkx5WSrdeqf+wL9Vp9Dq7TLgQy8JWkQMRT?=
 =?us-ascii?Q?NVBRgCAQupjQi5fMiLmNYhv6QKb/nK4YiCb5W5wE1+ZJfKJUwRKAdszg6M6M?=
 =?us-ascii?Q?iZ9R8mm18jt5MMYRUDbwYR76SIMNp92b1zPSqQlHXXJbGgUj5bGptNbQ8kqy?=
 =?us-ascii?Q?JlQ30Qo/NH5exGsOuRD+e0DmvIOuRLs1uYzds35NIn1XjfNi+MdaoHXaunAQ?=
 =?us-ascii?Q?XVNmqocNMvjS/Oz/DTBwScksTwrSz73ikKh5fA5tUXA4l/J25FLM0bMCrEKN?=
 =?us-ascii?Q?6mW7C9ZeMbRnIId8ev1K9G+eh4rWsVIvzZQ50DlntRMop3zRuQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nGaM5cnkO6lC0OuBfyVCCuvMbwXJfR02MV0+4zQDOYn1Tow765yICd0OOjzi?=
 =?us-ascii?Q?ZLfFq/wO37ABiBCBQiSVggwyX4xAE3bgmPDXUKAuqb28o9PqNIEUDb8hncGc?=
 =?us-ascii?Q?HJInWtJ+uoQ85MQpa+Kc3VA0ch+XJFvGDYuU7ZfgObgLbLL1CCQhb4ofb5G7?=
 =?us-ascii?Q?LjqZM92NJvYodJUoYKpMSxk7iPn4ajVq2CwtyaEDfRMCnm/OONF+DiOBEcuJ?=
 =?us-ascii?Q?jWyjxcnEie4BePuGffzd5+g6MP+FnCloio6GgCNHT9XkZA+qGk/QyOjwyqb4?=
 =?us-ascii?Q?SN+CWGePDOM45yD6jhftRA/414Z8L1pp96w1nxNRxyE8f4IjHmnqQHJkhcPi?=
 =?us-ascii?Q?N/b6n0DSoKUewMzlVgelFScCvpcOhKigjAxSBUVwFKawdCKcHpjYqtXmnGRh?=
 =?us-ascii?Q?/jaO92jgAoh8mCjC9ShHxt41MYasdbUqt1RAqt6THu6+7LKkhE5rK7Z1R2h0?=
 =?us-ascii?Q?rdogg4OBThJ91mH4LYCawoKWl8Kf751D4PWdeDWLIjQG7J4xAzgmvuJCnqy8?=
 =?us-ascii?Q?M1sFxuuGZci2eOB3ZPNiELUH2dvy5bKZdubeGHhJobbaLuFZ2BOJSSVUHcEG?=
 =?us-ascii?Q?GKQsXr+vkz6uhBOdUZJ6GYqzGw+smzBgczxt19KysPE4ysJeHGYV1pQxcW02?=
 =?us-ascii?Q?4oFW6t1xnI/Sb4DmR7eavgqF5Wq0P5R6hvBkflNhyRn146JoY9S90RYK8Ug9?=
 =?us-ascii?Q?X6t1PiEeI3iQg2nH1x7HpbS6nBkfqXj6/Lh22cRLtXu9X8ETQ37LX1dp+vZF?=
 =?us-ascii?Q?9tKtp0SwWrg/BYmHcFw9zy/LYITeGr6mVIYi3GBg2H4HTHRKfVItPt+gx5YW?=
 =?us-ascii?Q?tuq8ZQbTUVvGl3/NWmKIZobzPEDLqFk+Vo1eC3WCR1B/K5Uy/kWkQeadPSKH?=
 =?us-ascii?Q?HmRkqZBlTW/e+8YYG+ToS7kQihsU0G4I8+eT0VciHX2AIaYhq2TUcs9D8mGo?=
 =?us-ascii?Q?OAd4yJGpP3j2c7CliLkWcE59Lgp/y5yqMZtZbhN+NDZw6JeqWlX/T3Vnw6gV?=
 =?us-ascii?Q?YdiDUgXZRkH7bdhgbDKo1z4CRsq9NvohZt6LbBORYz0gX1M+YEzmiDGX/tOO?=
 =?us-ascii?Q?fO6pMuUviWlDe9cUporFIfI7MfUKmtj9q/cVNdqbdh9A19e+Hdsud+gcHufn?=
 =?us-ascii?Q?+mks7gavv5P3xDD4+iPMVzLcDrZYv4df7HooGvcv4GDa9kxWJKnskzfZcYK/?=
 =?us-ascii?Q?6J45MTJscf5z5CwGZnr4zHO2E8kyFVtgcNXaYkgDPubuIjxPb8bEZLxpKri8?=
 =?us-ascii?Q?nW8u18RcEhtr1azy+geQFB9oFT3nfjYEF9Gmmi2cCio9+ibDKJWbN+myAc7H?=
 =?us-ascii?Q?LkxWFvwvhM5hXIjnMbtMvwn39eQ0Ykf80Fh5ePS7fhYMvjAiPwiegMCwodZf?=
 =?us-ascii?Q?HsJbAdOGZUZUkJ2isOd4PG5BObM27Kjv0q7AgarBg8f4qZqMd1we4y+pDNiM?=
 =?us-ascii?Q?JRZcIf7Q1YQIp6hJ547Ncy4TRRKI/kcZ71CFQxst1ni5bUONyBpmmxTEs10L?=
 =?us-ascii?Q?c+Zyaao4CfeNEk971NaGxXeAR4GaowYH4yYTK0hvTSiLqPGbOPMtw74zPoI4?=
 =?us-ascii?Q?pSPRV0cfwGD/WzecQ0SV9xHJg+r6Teo9edHlklGL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a25786b-e85d-4bd5-833a-08dcaad5045b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 05:05:05.7141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaDpiQgJPbNfBsnof3bk11tc/3VaQMrRQqqBZWkTw6utfOOhKCsdnR2S20w3wpgji5rdDDc/RISVME+tQTars3X3/dNXwPNYtaTkBZjC9lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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



>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v6 9/9] vfio/common: Allow disabling device dirty page
>tracking
>
>The property 'x-pre-copy-dirty-page-tracking' allows disabling the whole
>tracking of VF pre-copy phase of dirty page tracking, though it means
>that it will only be used at the start of the switchover phase.
>
>Add an option that disables the VF dirty page tracking, and fall
>back into container-based dirty page tracking. This also allows to
>use IOMMU dirty tracking even on VFs with their own dirty
>tracker scheme.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong
=09
>---
> include/hw/vfio/vfio-common.h | 1 +
> hw/vfio/common.c              | 3 +++
> hw/vfio/migration.c           | 4 +++-
> hw/vfio/pci.c                 | 3 +++
> 4 files changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index 1e02c98b09ba..fed499b199f0 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -138,6 +138,7 @@ typedef struct VFIODevice {
>     VFIOMigration *migration;
>     Error *migration_blocker;
>     OnOffAuto pre_copy_dirty_page_tracking;
>+    OnOffAuto device_dirty_page_tracking;
>     bool dirty_pages_supported;
>     bool dirty_tracking;
>     bool iommu_dirty_tracking;
>diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>index da12cbd56408..36d0cf6585b2 100644
>--- a/hw/vfio/common.c
>+++ b/hw/vfio/common.c
>@@ -199,6 +199,9 @@ bool vfio_devices_all_device_dirty_tracking(const
>VFIOContainerBase *bcontainer)
>     VFIODevice *vbasedev;
>
>     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>+        if (vbasedev->device_dirty_page_tracking =3D=3D ON_OFF_AUTO_OFF) =
{
>+            return false;
>+        }
>         if (!vbasedev->dirty_pages_supported) {
>             return false;
>         }
>diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>index cbfaef7afffe..262d42a46e58 100644
>--- a/hw/vfio/migration.c
>+++ b/hw/vfio/migration.c
>@@ -1036,7 +1036,9 @@ bool vfio_migration_realize(VFIODevice
>*vbasedev, Error **errp)
>         return !vfio_block_migration(vbasedev, err, errp);
>     }
>
>-    if (!vbasedev->dirty_pages_supported && !vbasedev-
>>iommu_dirty_tracking) {
>+    if ((!vbasedev->dirty_pages_supported ||
>+         vbasedev->device_dirty_page_tracking =3D=3D ON_OFF_AUTO_OFF) &&
>+        !vbasedev->iommu_dirty_tracking) {
>         if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO_AUTO) {
>             error_setg(&err,
>                        "%s: VFIO device doesn't support device and "
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>index 8c0f212a163e..a0767de54b8d 100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -3364,6 +3364,9 @@ static Property vfio_pci_dev_properties[] =3D {
>     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking",
>VFIOPCIDevice,
>                             vbasedev.pre_copy_dirty_page_tracking,
>                             ON_OFF_AUTO_ON),
>+    DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking",
>VFIOPCIDevice,
>+                            vbasedev.device_dirty_page_tracking,
>+                            ON_OFF_AUTO_ON),
>     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>                             display, ON_OFF_AUTO_OFF),
>     DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>--
>2.17.2


