Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E195DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9bQ-0003Az-AK; Mon, 17 Jun 2024 06:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sJ9bN-00039E-Mp; Mon, 17 Jun 2024 06:28:41 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sJ9bK-0000oY-VE; Mon, 17 Jun 2024 06:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718620119; x=1750156119;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kVkosQl2KWwKxuoJ4KRTDU4j9lTJTmrfLkyVvCVspKA=;
 b=TGm+FEqxiZMrcaQyPuVX9zih+Fdjl8mfevqnL4w2vB4QbB6HBKHAvCNC
 Q84SniXWbacBkh5PjdzUmSjo6Io6WNTUl1k/3WhUUT4nKw90+rj5CizVm
 /cetMb4CPziQHbZ5e2HK/Kbvyq5wnSSnixOQkgujVl1JhPemGZxn0HToQ
 iw2JilI56Bzcw71qoNsSACsfiwYEocsnHO8eCawm/D0NYO2sOvvQ/K89d
 H+IEDqhXtTomuIDON4FNO7cUHjTLnlXnHLcTPTk8eiLUyg8mDRTEURS3L
 f90kOQbt7Lw4SyPhHjc/n7fFsLBQtLQ3aPQgI0tk3pENemhx2nQSesvyT Q==;
X-CSE-ConnectionGUID: eGLT6/vwTryh6Q4m3cGCNA==
X-CSE-MsgGUID: lix2DgtFT6yjUe+vnsn5qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15272872"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; d="scan'208";a="15272872"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2024 03:28:36 -0700
X-CSE-ConnectionGUID: 7Jx31EpETDC9RR1DWCZ/6A==
X-CSE-MsgGUID: pq6qCHY5S02xi9hXyO66+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; d="scan'208";a="64351835"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jun 2024 03:28:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 03:28:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 03:28:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 03:28:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 03:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCzOacI7njySrEluAosgZRQ3UydIQzJPLrTkOIcEfxkob9bsr4qyxpFqzT4y1esYQebXh8qq4L/VdSLjGf5Sv9QPnQVw0MGwGYHiSFCG5FUbefKPrYa9K5vdeFJhrjQzTPQvyd9qaSoqmv+wl3IKjxqAYq/CD0gvYI/RcQk+L+wR+ntBVaV36ieuPxhXbaBoyei8B4ltc9cZnhjR9LzVwRbJ+YswrSrslPWAzlmfI+d6pF/+lm26ndtW6KcE0duz1O7J8bP2C0FLar4EQcdzDGYOzMGP2SpyhmpestaAH2WTZgJm8qSZ5iieWb6LNxBHXVbF1ADwO1OTfxztoOiVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4N7webuOAAtZksO/Lp33Zlts6Y0LN9yjVBrr4Zbrrk=;
 b=LKREMkhRKxZajVQLFaOFHZYGz3OPEXmRVC/DMdH25HenjQuOvi3ZQfw/Ig4aP2f1QdfN48gTFmRK5cwff4mZcPt3jEYOaxMMKeF38jtOXcIaETK/VO4bMNVNXTjPDTEvati0kl6SVdrbRIOmCTuwchPRUACp0R8z0SiJyQ2uffrI80x8seAeuoDIOZavzzN6l8fiOW7KtGJs7v7elbHGwkK90EOdZ2MM4FBC6Pe/kfwRPB/8KeL9LfppmYO2Epc51yS/PL/2nfPugDqBHO+IvYzdTfTwrWKN9+KG93n7SqJx+AvUmX4fm7vWX40ArS7S9Sic1IqHPviPXw0BWAAgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:28:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 10:28:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [PATCH v4 0/8] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
 handling for hotplugged devices
Thread-Topic: [PATCH v4 0/8] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
 handling for hotplugged devices
Thread-Index: AQHavkDYAkybxf1S1ku7FxqCOWkmqbHLxMRg
Date: Mon, 17 Jun 2024 10:28:32 +0000
Message-ID: <SJ0PR11MB6744B76C1108A2BBAF734A1992CD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240614095402.904691-1-eric.auger@redhat.com>
In-Reply-To: <20240614095402.904691-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV3PR11MB8767:EE_
x-ms-office365-filtering-correlation-id: cff85f9d-13e4-4e36-d211-08dc8eb83cd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230037|7416011|376011|1800799021|366013|38070700015; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tUFyMdD82kwKpKKgjbIJegEOlut/8V/ZcXdaW6EYlGi/uWD2MkPkP0XcLAVP?=
 =?us-ascii?Q?tFBS0uLh4M33t4AYVe2FfX0i30IYNugQ+RFkl5hDPQUniD6ggRHb1cldx4Hc?=
 =?us-ascii?Q?+IDA10Nj/OODxSEYnEtAKqyUF7NCza5XTBw1RTepYpRB8YIIoBNbfdKAmCkR?=
 =?us-ascii?Q?ZKpSrhFwh6HH17QmT3Rt5PRJbUIgR85QPusKRHqd7EwkUXCITRzDJqEwlQ3O?=
 =?us-ascii?Q?a5mJx/47rNVuLYhJ9i4WPny1BcoOrGTqqc34Vn5hu7gDICIoupPw+/pET2qM?=
 =?us-ascii?Q?6oXkhARF1BIjUPpMS+O/8+rW92ux2LyrUVIBSnk+uEbzJiLt1cUIwSyCQPz2?=
 =?us-ascii?Q?YAoDhL9gCogSk+SR3Yb3vUjZL2Z2E+Un37kdcUrrwdoPhNVZXHovSaLjaAae?=
 =?us-ascii?Q?IpAkEqeslrFTd0R/5xsOr2lvJaud806FGEytcTdO7/ib0tyY2R1zkLkIqopM?=
 =?us-ascii?Q?TFIKA2CY1MTEnXbILx+YVl7ivjUnNYtIZZqoyaCrDuGip3CqiCGSrFErRdjW?=
 =?us-ascii?Q?RVM5Kcz1GpxqiqiPHi1bGie9IZ6XEBJElnoYW5zZ+Nw6spaAwF3SEBlOpZz5?=
 =?us-ascii?Q?V/7OCKyHMJTZwqJp2mIvf99CaafPdva9kgDPGI3yrIDjjGhmldV++LEjUC/x?=
 =?us-ascii?Q?YPJrmx1eJwCVKSdMP0hL/opgSYe/2ZnPn17RhooGlnajfPKSOgHYkfVYh/Ko?=
 =?us-ascii?Q?+KlWmb42Rn3YnT4KS8YzzjB0CVQE2lF26VN7t9BMu4hr/v/ALMKU1XMmxMBm?=
 =?us-ascii?Q?ApRSzoGDkAgOQwvOKBGqOG72wj8ypRPRijsCaT9OStZT3AEyDm/fCm1R65Ov?=
 =?us-ascii?Q?ZwrKpxcW+IcIHSAuz5sh7LNckWicxFk05F9nsvqRYSI5mOvc6ps8vFczFHTI?=
 =?us-ascii?Q?3VdOr34brpRX3165AYbb8uLjzQmzyfVZcbdloXZMgHg5cU2l34L7HARteOxh?=
 =?us-ascii?Q?gaVxNGTxuZ8X70+XUYMqlKaThC+tdxG3cpkVZWpTMNAvRDfv3jlZiKGXlJpe?=
 =?us-ascii?Q?e/KjeZ3C9SwQyPYBur64jZCeMUf9/oPXYpqhFatxa7d9nyjsIY083hRNvDsE?=
 =?us-ascii?Q?a+l2c4q+Y9z76BkOlFZuetZtaWsexQuzF+zMpqM8o6R/rAjOJSK4ZpGRj4/Q?=
 =?us-ascii?Q?IW4SSLEl7r2Q1ofT6UOXJUioEtb2UBqqLuePUMIsrOsVFqGhIybgqkWNo+pQ?=
 =?us-ascii?Q?VTBkRBVIfdl9EF80IrAKgDY7I3oRUQLASPdnovjE9gSZ29vWuaHb2bBi52QB?=
 =?us-ascii?Q?DF1yktcww/Sy0UGtD+ai9hZf4oAxoQz9ZNCeo4hE7KG599Qej9RvbyFEZ2ea?=
 =?us-ascii?Q?J5cspXKBW8aaAvxTamJSabeT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hfXFXqky8MtqsfLEYF+x9hwF6T1Fj8X7wLAJBmXpVMMKapMJmsVjhKdk1I4Q?=
 =?us-ascii?Q?KQJxuze0rmsQ0OdTaCubJmj3SfFxfV27xy9s4MG5PtydG6qvEyIsu9Hl4b6E?=
 =?us-ascii?Q?hTK7NsvPq3BS+66jnKASNGzhMW9M3p/ZBJ67shs6UWYcDW7XnR/+V4uQL5c5?=
 =?us-ascii?Q?lBlKhcatwkAnjqUbpi2ZupPCYAzIg3qD2O+T0qGw4PYbgIiQxeRXCjvZxaKL?=
 =?us-ascii?Q?yPFWHdHRbWDqcBEmDViAi/8uYJa+sv5rcO4bLfNBg6s0ej7f6Muk34NkS2Rc?=
 =?us-ascii?Q?WipVjsx6Sqz1le/5zsG602QECDCvzlXE3nnCQJ1opMKiz5y+vM13kIEBfC3T?=
 =?us-ascii?Q?Y9eXkP5851N2N2ZS1PU8myTOipU6952ICh874DxEehiGfhX8+V5340BZ5z3b?=
 =?us-ascii?Q?47zMixIDMT5EkXYX/qkJ+8oc11aujRfSxNEGdMiTCatSMKZOU6xM8+cMnZC+?=
 =?us-ascii?Q?JkytlYuClgjAecu9wvBnMpMsz7FF95cIdJiCH34ZWNiAp4logsOfCmedzEcq?=
 =?us-ascii?Q?52XM7AmnMpq7XTpbJbH+o53WR7RwwVNXppbUQmaRZl+k17GrytOZfrOm7MNB?=
 =?us-ascii?Q?lBpjd9sV7ScDZ5Zs59rtJSw/G/nkRhsj8zDBIc8es6kKjbW5cy1aNLcBrs5X?=
 =?us-ascii?Q?1VVuq6yc8nzS+pWHlqDr7CztidoxZp6Tx/L7pjFagKSUpd/hpC1pogCPz9DD?=
 =?us-ascii?Q?9h2WC2ZttQ6c9PwUBt7Y6/MsAv6cjUAnixegd9dTdUVp9P9K3nkqbvHusjA2?=
 =?us-ascii?Q?MzC6nsRou+uA1yR5CrkkPzXDewkROy86FWXMripVYJ+Y1HT7pIivEu2v/Sxf?=
 =?us-ascii?Q?Mv5vDIRnGdOI7PiRYuLzD4wFn7FgMJN80jg+GSCcNpNMuPHcfVhhjUG27GDX?=
 =?us-ascii?Q?JIrXGCsRyTc+4VRf1HFPZdJp8wZTlSt2ql130NRKIyDRZUGG2C8dorZt9lbi?=
 =?us-ascii?Q?rGs/hUZ8u3Dw+DvQLtSoJcXNVU8AI5x+TOjHGRdXQsVX12t8fRD0W39ghW7U?=
 =?us-ascii?Q?wykvckrUIUMp5BoMpj8AG3g6Xjx2gGaTRSxHs2EU9KC+KGg2q6MX/hLIqn+G?=
 =?us-ascii?Q?7iVxbu2Uz/MC4w31Jg8VA1tnMMSjeCT9jv9WJBOi8bKTnKuxyIGE4CV/P1GI?=
 =?us-ascii?Q?LUPK22tD/QotqxjAQdfJmsTRYc++HJUexh0yHD6td4EiwcfvMWdJFYDoerNB?=
 =?us-ascii?Q?NeZyr9WOggVoIgwDwNZQk/qcpo43XIdQlhHtPjm6Wg49iSpTCS/u6z659YMg?=
 =?us-ascii?Q?VXW0CNKHX3gicQ4++dH/srpgilaZJgRqkeIEMSWH2Czz6wmizY0ugdrR5vIw?=
 =?us-ascii?Q?0WtM5i5U6GUomVNsXtB52tfuXw6mrCSSsJnAaZUWwIET+HaTRxV6CdVbFJmM?=
 =?us-ascii?Q?pw0JxtM7ZMwckOhkKqI6eJICHRnIb0AVuvktD4JiESW2izC6t0HAQZoR3U49?=
 =?us-ascii?Q?ai6AaMeVKAW00McqcWDJ62IH7z/Z4OCD+nnCLaJSCTKUfNTWC4dizR+9xo2w?=
 =?us-ascii?Q?mc77AfJYNl/ncRUNm48Khp8i67pRR2DaseQcdAvjfKFe+ClRVFRa7pT9rSMI?=
 =?us-ascii?Q?nsdCMGMl/WtWrbJNszjI0Jw4BXL5etoMrKsddJCS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff85f9d-13e4-4e36-d211-08dc8eb83cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 10:28:32.4826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djJ4YqFLbU9JmOT51VPnRK3f1+MCHAA9yBmiJTz00E+zRD6AK8Ln2jB+EvHf+jkKVFBiYYoq9YP8lwfNa1tFPFcfBPcQIqd1ihxnLk6mNRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [PATCH v4 0/8] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
>handling for hotplugged devices
>
>This series is based on Zhenzhong HostIOMMUDevice:
>
>[PATCH v7 00/17] Add a host IOMMU device abstraction to check with
>vIOMMU
>https://lore.kernel.org/all/20240605083043.317831-1-
>zhenzhong.duan@intel.com/
>
>It allows to convey host IOVA reserved regions to the virtio-iommu and
>uses the HostIOMMUDevice infrastructure. This replaces the usage of
>IOMMU MR ops which fail to satisfy this need for hotplugged devices.
>
>See below for additional background.
>
>In [1] we attempted to fix a case where a VFIO-PCI device protected
>with a virtio-iommu was assigned to an x86 guest. On x86 the physical
>IOMMU may have an address width (gaw) of 39 or 48 bits whereas the
>virtio-iommu used to expose a 64b address space by default.
>Hence the guest was trying to use the full 64b space and we hit
>DMA MAP failures. To work around this issue we managed to pass
>usable IOVA regions (excluding the out of range space) from VFIO
>to the virtio-iommu device. This was made feasible by introducing
>a new IOMMU Memory Region callback dubbed iommu_set_iova_regions().
>This latter gets called when the IOMMU MR is enabled which
>causes the vfio_listener_region_add() to be called.
>
>For coldplugged devices the technique works because we make sure all
>the IOMMU MR are enabled once on the machine init done: 94df5b2180
>("virtio-iommu: Fix 64kB host page size VFIO device assignment")
>for granule freeze. But I would be keen to get rid of this trick.
>
>However with VFIO-PCI hotplug, this technique fails due to the
>race between the call to the callback in the add memory listener
>and the virtio-iommu probe request. Indeed the probe request gets
>called before the attach to the domain. So in that case the usable
>regions are communicated after the probe request and fail to be
>conveyed to the guest.
>
>Using an IOMMU MR Ops is unpractical because this relies on the IOMMU
>MR to have been enabled and the corresponding vfio_listener_region_add()
>to be executed. Instead this series proposes to replace the usage of this
>API by the recently introduced PCIIOMMUOps: ba7d12eb8c  ("hw/pci:
>modify
>pci_setup_iommu() to set PCIIOMMUOps"). That way, the callback can be
>called earlier, once the usable IOVA regions have been collected by
>VFIO, without the need for the IOMMU MR to be enabled.
>
>This series also removes the spurious message:
>qemu-system-aarch64: warning: virtio-iommu-memory-region-7-0: Notified
>about new host reserved regions after probe
>
>In the short term this may also be used for passing the page size
>mask, which would allow to get rid of the hacky transient IOMMU
>MR enablement mentionned above.
>
>[1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
>    https://lore.kernel.org/all/20231019134651.842175-1-
>eric.auger@redhat.com/
>
>Extra Notes:
>With that series, the reserved memory regions are communicated on time
>so that the virtio-iommu probe request grabs them. However this is not
>sufficient. In some cases (my case), I still see some DMA MAP failures
>and the guest keeps on using IOVA ranges outside the geometry of the
>physical IOMMU. This is due to the fact the VFIO-PCI device is in the
>same iommu group as the pcie root port. Normally the kernel
>iova_reserve_iommu_regions (dma-iommu.c) is supposed to call
>reserve_iova()
>for each reserved IOVA, which carves them out of the allocator. When
>iommu_dma_init_domain() gets called for the hotplugged vfio-pci device
>the iova domain is already allocated and set and we don't call
>iova_reserve_iommu_regions() again for the vfio-pci device. So its
>corresponding reserved regions are not properly taken into account.
>
>This is not trivial to fix because theoretically the 1st attached
>devices could already have allocated IOVAs within the reserved regions
>of the second device. Also we are somehow hijacking the reserved
>memory regions to model the geometry of the physical IOMMU so not sure
>any attempt to fix that upstream will be accepted. At the moment one
>solution is to make sure assigned devices end up in singleton group.
>Another solution is to work on a different approach where the gaw
>can be passed as an option to the virtio-iommu device, similarly at
>what is done with intel iommu.
>
>This series can be found at:
>https://github.com/eauger/qemu/tree/iommufd_nesting_preq_v7_resv_re
>gions_v4

For the whole series,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>
>History:
>v3 -> v4:
>- add one patch to add aliased pci bus and devfn in the HostIOMMUDevice
>- Use those for resv regions computation
>- Remove VirtioHostIOMMUDevice and simply use the base object
>
>v2 -> v3:
>- moved the series from RFC to patch
>- collected Zhenzhong's R-bs and took into account most of his comments
>  (see replies on v2)
>
>
>Eric Auger (8):
>  HostIOMMUDevice: Store the VFIO/VDPA agent
>  virtio-iommu: Implement set|unset]_iommu_device() callbacks
>  HostIOMMUDevice: Introduce get_iova_ranges callback
>  HostIOMMUDevice: Store the aliased bus and devfn
>  virtio-iommu: Compute host reserved regions
>  virtio-iommu: Remove the implementation of iommu_set_iova_range
>  hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
>  memory: Remove IOMMU MR iommu_set_iova_range API
>
> include/exec/memory.h              |  32 ----
> include/hw/virtio/virtio-iommu.h   |   2 +
> include/sysemu/host_iommu_device.h |  11 ++
> hw/pci/pci.c                       |   8 +-
> hw/vfio/common.c                   |  10 -
> hw/vfio/container.c                |  17 ++
> hw/vfio/iommufd.c                  |  18 ++
> hw/virtio/virtio-iommu.c           | 296 +++++++++++++++++++----------
> system/memory.c                    |  13 --
> 9 files changed, 249 insertions(+), 158 deletions(-)
>
>--
>2.41.0


