Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708E7C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhDL-0004iz-3v; Thu, 13 Jun 2024 05:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHhDJ-0004iH-P8; Thu, 13 Jun 2024 05:57:49 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHhDH-0003Tu-MT; Thu, 13 Jun 2024 05:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718272668; x=1749808668;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Jog/2yvQLKLAeRKvBoD5FNtCCT4Yql/7WYyTvqGk24s=;
 b=SFYpn5HicQBxOdsYaOe4p+KouFBlRCOPZtuNnneEqv+j3g1OvwxfJOhW
 brzARMthjqH33w4310Ur+XH6FoPXGqTNo5+99/Y6Idw/b0gx8nIuljQG1
 JNpGXavVOpYvHktezvXq/b7LBTfA/wyRpt2mu5aaSsQIqwnqJxt3QKsEQ
 7LjQMIK26b+mPaLrxKB8DTPpiDI2PvcdnMPfd46bA6h5JF5QN/xTzw+ba
 aB8iGoa3iaKiT+jmVuua3NsJ1Kb9D1FJ1Qlv1bZPlFNY0qmOPgJ+j7lRz
 YGazmPMrrrbZY033r+dNqWXSzYNJyxeJaiGlv5pjtjBAJmfx/00NwJXBg A==;
X-CSE-ConnectionGUID: yAqU/8/PTlStO6CANNUImw==
X-CSE-MsgGUID: d0LC7uPPR6WdX3wAK3NxJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14805319"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="14805319"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 02:57:24 -0700
X-CSE-ConnectionGUID: QsLB7WBHRkmwuk/cuRYPmg==
X-CSE-MsgGUID: gLi0/019RzyX2T0orSb0gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="40207190"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 02:57:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:57:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 02:57:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 02:57:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atubae9tQ+zuaXLGhyiSx/lHlkWle8wuTV+wP3vEAOF1Ys0yzqb94r31CEA0qBcTXxP1eehpMxn8jAd+AtRsahXrblG5g29LQCh9xc45ZrBjlO6MkVP2XjglxbW6eUKnXVerepnN8vM7xUNnbWpIrJc9nmtMTzH/HX6h2SzwNGOdOWUEUT9HZsJoPX2tvaNcj4tTm1Qs6OEPeAVhWmZOt+D4IvUF8xMdJVHcvTPVEt7TKkrDKMrx6qVPkxqg+JslA5GKLeqTFGgdKZu3qxmE5rBTqY9apAZb2MdtDf3OVPFh8YyrpHshgoAVcCgMPLtO7Feu1Dp1sa1O4ihvdsozzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29uEW6P2gmmzU2PkGugz3vLdvifDEqTVb2eDdlimAME=;
 b=h4C7EHXnzIRc5vSozXoFE4EvLzCz7iTa6hPB/+51084SonHiOzdgcMEca6HwwH5gluLtXBuG95m+zCxy8OTE+PSONjXLAqMISGXUs4XOgGmRBPYQ5jmGVX5s6nq+CxkSNLHqSIR3XY4BavuITCd4kZOQQm/UIibUBRAvc5p0d4a3CpaLPDqmLPRvsK8w3QIMht53T+WupIJgpgtlfz4gUPGDCmzUamGyjgBlTBFBlbHxt95w8+ZSj7RGu9JlZIE7qaIII0MICe5UQNzgehFXu/tszvIQAsWP+L823VIHIMwpiLZLIJ7LveOskRWitwWB0SAsfVKtsK3pPuEHCw89BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 09:57:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 09:57:14 +0000
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
Subject: RE: [PATCH v3 2/7] virtio-iommu: Implement set|unset]_iommu_device()
 callbacks
Thread-Topic: [PATCH v3 2/7] virtio-iommu: Implement set|unset]_iommu_device()
 callbacks
Thread-Index: AQHavXOM0wxYI9B1aEuZYZmteIcYF7HFdL3g
Date: Thu, 13 Jun 2024 09:57:13 +0000
Message-ID: <SJ0PR11MB674452B1D7B17383EFA73E6C92C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-3-eric.auger@redhat.com>
In-Reply-To: <20240613092359.847145-3-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5190:EE_
x-ms-office365-filtering-correlation-id: 077d4515-4a94-451e-bfc0-08dc8b8f337d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230034|376008|1800799018|366010|7416008|38070700012; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BPEt6JvSvVsqu3KC8QjoaWOVTlqzRL1qWN4ehDU5M5q2NiW+T5KExOikLpPx?=
 =?us-ascii?Q?sTzAYcUXhAmvpN1bjaFfb3boN9k9gHjw6Mm11p8cbfS6TIrl0wNJBNaFanX4?=
 =?us-ascii?Q?N1c1heHpk2FbZ8lVmiiwWt2W9V9WXzYgWFCKkUHDWeOjMzFlQ1c/a8llNr10?=
 =?us-ascii?Q?r7WFyzTz3gJYMbuor8eqxkB26SS7TeWXJWjbk8Q4FXF1ldkpbwH6djkyJEDg?=
 =?us-ascii?Q?579ZqYJLFAMHTZd30Ty2gQUZiWT+NRBYwfe/sA+t1XqwtJ3q8VBzAezHpWM5?=
 =?us-ascii?Q?5h80lDZ9PXbvm4i9oyi9OWqvFYjUBHlcgZCsuTDU9vOd68mAo1AEpiisAcd2?=
 =?us-ascii?Q?cZOMqyHEYFzAjm2qhi4ihFgFnPQKQPUFjpz6B1cH6Mwwx7jaDazfdorHj5iI?=
 =?us-ascii?Q?YJeMks+EGpGW39X0si9DV9mVIErtmQajzigwT358UcAVZGedDYmDhDbwNhqY?=
 =?us-ascii?Q?bRJvCUh8902G+4q+ar/Gslza7zOW0Ws303XrEJISwGW9Q652loDdy20YMJMS?=
 =?us-ascii?Q?eWx3bMO+uXQ4blNK7h/k4WOj/KzVTqyqDN5LIdfbwEgSbdK+13XLoxgy4gHL?=
 =?us-ascii?Q?kyo4LU8GfSlqnYyoge6OPiqgBVe0h5rDTMTClTFNq2aVxdzvPQ+lKk0Yozhe?=
 =?us-ascii?Q?h0G4+L3nhe7fNGz/auoQzIgFQYQrG8dX587M8CxqbMBdLkyaUFNpMJiPndCv?=
 =?us-ascii?Q?SD+t+2lq4NDmEiKQEQMrqRJY+Z9pZqZRfo7oJEQu83xfca3NZwL1eW+YW8Sz?=
 =?us-ascii?Q?9IzhperaP+ZS1t3jf3g19J1gFrsUvoUp8ho4VjsppeWarljcpJsQx3qW2LW6?=
 =?us-ascii?Q?xC+qVyx1DYNgGlAmKpqT/5mbQaAcqAUQjyBxd7tvualX0Flb4WkXmv0/tVx7?=
 =?us-ascii?Q?cEU42iRWWdHLmlddZ6rHsjhfSlU3GChh5TW9yLq1FhnG9GaRJx51Mun9acK5?=
 =?us-ascii?Q?8A+EzaLwZGUybOkWoG+fx/nvbizp3pnjjES51nf0QLXNSPJ1KnfXeuG+KCak?=
 =?us-ascii?Q?pe9tC9Ax6+jbADNMtrSjankFSWQ767X5XFrqMuhY0kYRlhmRP6maVOCe6yjq?=
 =?us-ascii?Q?7EbMOdU/xGCLJax7qaRmaOn4eEJ6E0LrHmXpQI/K2dquELeHD09eJm7ULb7e?=
 =?us-ascii?Q?PimdRRBazSLrKa2kIOCFYaCek0aj3hByFRj2NPg3Wtq7rHJhiDxvS6CFvv/v?=
 =?us-ascii?Q?DE3M3IwCDBJfthLw9m9fvo0ueT0lkMt28478/d/YmitvivL6l1LOdIvuYJkD?=
 =?us-ascii?Q?tkZfTJsAfeBC32qbT+ZijtnpKQ2qBlQmx7MDayoF78SY71mWFxOtxtadAH3F?=
 =?us-ascii?Q?gRhMiPrb7kZ00AQcjFfPHASiQsdzv8QDS5NrzS8uUKiUoS7yVLHy8ZyxNEcO?=
 =?us-ascii?Q?+GCsZ2U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tw7QtaXEuTWUWGh7/LTP8fXbC6BNVKPHwZdf9GmTTTaNldf4NcuG3+GTsXw/?=
 =?us-ascii?Q?ICrYKUkYCYIis6vwk8RZEfXRNVQz++ZJpTfcSH5cViwTB/9bH+Ux9VXzwmr5?=
 =?us-ascii?Q?j4NLdMz9GzvDVFLzOghlW6YRH2yQpinKG+ujsO/wYUUVEKh17cNPbXROKaPe?=
 =?us-ascii?Q?DXndFu+hFX5KZW9Sv5Mkj3HwyS0HhKW+dcEBuF4VKIgKx42Wzaa7cGTog3lj?=
 =?us-ascii?Q?kZbORX6nmbmWt1oe5Po77a9tKhG4PKNosAsfrcV85jIzo9FNvm9tPPNWkbaR?=
 =?us-ascii?Q?OL5UhexBrNM8NHVvGJmml3SssQ3ArQl7uf4NhZDuuHOhIh42ZNW5XF6dg3wE?=
 =?us-ascii?Q?9Ohqr8waAbPYFTm7/hgvvKZD9bJFgU41nv6+auwR8+OuZPJpS3/6yd2N7HRC?=
 =?us-ascii?Q?rL/2dqcMDEGUoCk9VErdf7Tt5YqgSAw8z5mZcwz/yyoJh/cymXBGHR3DITBx?=
 =?us-ascii?Q?rNc34xtHvbPZtJHJBpkosAYJRr2TeygGA+DwWOkLOb/IkotyRyiZQJux6f3B?=
 =?us-ascii?Q?GrmRad99CwTepoE8HZeVXtePiOiFgbULlGKXEjoAKbQzE7DlkQIl6u01tfIo?=
 =?us-ascii?Q?u4zUtMZBG6L399+aGGMH0x1GOvsp8GRg8rQ+Dle3xdhOFCmc0myy9Z/spQh+?=
 =?us-ascii?Q?1gMtQEK8UOmW0R2oz4rBzX9fvZ/lL+EC7Yr7oF32N/tFNH4Wb2/jTGLONQ9l?=
 =?us-ascii?Q?Y9bbiz1uDsTAzGX2Ac5gNkbjz/3POqKyvp7tFpZH/8N1Uy86VBleE8/8WBbE?=
 =?us-ascii?Q?fvuCVWbLuN8r6b3nHd3LNIaiADePG2GgV9PB9eqBaKc94BRn0RlajFu1K2Yb?=
 =?us-ascii?Q?4dYb+N1inkM8fJca5Bz9xRpv3WspXnUghUn/R4B+zPTaibjqt7vl0wHrMT3c?=
 =?us-ascii?Q?1qFTv5P/kztPxIo5DYzq861BhoKwzUNTcgJztP3TgKZG4PrcBcNcjFCMCSU7?=
 =?us-ascii?Q?KkMAbPI0WAiiv7Y3BQNlId4LnoywZ3Wppv3O+N+CZLtx0e3MCcAsUueRkRKM?=
 =?us-ascii?Q?0RRhgTjsaok2bB2i0ghgKa+TWnKhpGpTBqoMimGRr3crp8kjUUFsZ+vCSLxm?=
 =?us-ascii?Q?Wv97u2Fv0sL3D2B6kZULcwa71WRVLVtOCBPHpFP6PfR5BJUrE9FJV8bZHkIA?=
 =?us-ascii?Q?WFezG22qRn/Vs35qGounC1LKDIbAVEV+E5h/c4jfAlx4LD/NG2Rx1vXjrBdf?=
 =?us-ascii?Q?gWfYLYSOmPWeeN1+nVAVm3z9GmaPxGspTrYOOK/NrL+T+0H99vYw+K7JIQQA?=
 =?us-ascii?Q?o/zruFLI6nPnXRMWTFGk97atrJaAKm/meJvpr2YMRfd++o+VSv0aD9g+vdSe?=
 =?us-ascii?Q?Tq45rcD2pjPHJkdRy9oK/CaQW4tu/QvyWGRiJA8tT6SW/2HreaS/fa0ichrx?=
 =?us-ascii?Q?UfCHvFggPs5mMNFlKVgYGXVXnKwkvYO/RyWz5+OQPugmNiozuwEEmJjDmuei?=
 =?us-ascii?Q?+xqX6fSL4ovP3nZDrQjruQzgrIU4INAuRe1juGHVNGUg7PBZek/uflF76eDV?=
 =?us-ascii?Q?BkDJBbRbwaGfqsLxC43TtcMJdFGHX7BaPrw71nMvo7XqWScnq3hw3uCeDyMu?=
 =?us-ascii?Q?J9js4Iu3GZ1P1N5L8FLB8gzJTQINMKmLbRUYffp9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077d4515-4a94-451e-bfc0-08dc8b8f337d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 09:57:13.9977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIgzwR35+v1UsfE5MKpVFApmrYCyUwWY/WDUHGtOW1dqFTacPxp6VArCqUD55524zkYIi7NDnwMjpmB18Toj/jQe4Qyul39Lk4x/L0whMu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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
>Subject: [PATCH v3 2/7] virtio-iommu: Implement
>set|unset]_iommu_device() callbacks
>
>Implement PCIIOMMUOPs [set|unset]_iommu_device() callbacks.
>In set(), a VirtioHostIOMMUDevice is allocated which holds
>a reference to the HostIOMMUDevice. This object is stored in a hash
>table indexed by PCI BDF. The handle to the Host IOMMU device
>will allow to retrieve information related to the physical IOMMU.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
>---
>
>v2 -> v3:
>- include host_iommu_device.h in virtio-iommu.h header
>- introduce hiod_destroy() and fix UAF in
>  virtio_iommu_unset_iommu_device()=09
>---
> include/hw/virtio/virtio-iommu.h | 10 ++++
> hw/virtio/virtio-iommu.c         | 90
>++++++++++++++++++++++++++++++++
> 2 files changed, 100 insertions(+)
>
>diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
>iommu.h
>index 83a52cc446..a5926de947 100644
>--- a/include/hw/virtio/virtio-iommu.h
>+++ b/include/hw/virtio/virtio-iommu.h
>@@ -25,6 +25,7 @@
> #include "hw/pci/pci.h"
> #include "qom/object.h"
> #include "qapi/qapi-types-virtio.h"
>+#include "sysemu/host_iommu_device.h"
>
> #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
> #define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
>@@ -45,6 +46,14 @@ typedef struct IOMMUDevice {
>     bool probe_done;
> } IOMMUDevice;
>
>+typedef struct VirtioHostIOMMUDevice {
>+    void *viommu;
>+    PCIBus *bus;
>+    uint8_t devfn;
>+    HostIOMMUDevice *dev;
>+    QLIST_ENTRY(VirtioHostIOMMUDevice) next;
>+} VirtioHostIOMMUDevice;

Do you have plan to use the elements in VirtioHostIOMMUDevice?

>+
> typedef struct IOMMUPciBus {
>     PCIBus       *bus;
>     IOMMUDevice  *pbdev[]; /* Parent array is sparse, so dynamically allo=
c
>*/
>@@ -57,6 +66,7 @@ struct VirtIOIOMMU {
>     struct virtio_iommu_config config;
>     uint64_t features;
>     GHashTable *as_by_busptr;
>+    GHashTable *host_iommu_devices;
>     IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>     PCIBus *primary_bus;
>     ReservedRegion *prop_resv_regions;
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 1326c6ec41..db842555c8 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -69,6 +69,11 @@ typedef struct VirtIOIOMMUMapping {
>     uint32_t flags;
> } VirtIOIOMMUMapping;
>
>+struct hiod_key {
>+    PCIBus *bus;
>+    uint8_t devfn;
>+};
>+
> static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
> {
>     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
>@@ -462,8 +467,90 @@ static AddressSpace
>*virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>     return &sdev->as;
> }
>
>+static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
>+{
>+    const struct hiod_key *key1 =3D v1;
>+    const struct hiod_key *key2 =3D v2;
>+
>+    return (key1->bus =3D=3D key2->bus) && (key1->devfn =3D=3D key2->devf=
n);
>+}
>+
>+static guint hiod_hash(gconstpointer v)
>+{
>+    const struct hiod_key *key =3D v;
>+    guint value =3D (guint)(uintptr_t)key->bus;
>+
>+    return (guint)(value << 8 | key->devfn);
>+}
>+
>+static void hiod_destroy(gpointer v)
>+{
>+    object_unref(v);

This is a bit different from intel_iommu, here v represents VirtioHostIOMMU=
Device *.

Thanks
Zhenzhong

>+}
>+
>+static VirtioHostIOMMUDevice *
>+get_host_iommu_device(VirtIOIOMMU *viommu, PCIBus *bus, int devfn) {
>+    struct hiod_key key =3D {
>+        .bus =3D bus,
>+        .devfn =3D devfn,
>+    };
>+
>+    return g_hash_table_lookup(viommu->host_iommu_devices, &key);
>+}
>+
>+static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>int devfn,
>+                                          HostIOMMUDevice *hiod, Error **=
errp)
>+{
>+    VirtIOIOMMU *viommu =3D opaque;
>+    VirtioHostIOMMUDevice *vhiod;
>+    struct hiod_key *new_key;
>+
>+    assert(hiod);
>+
>+    vhiod =3D get_host_iommu_device(viommu, bus, devfn);
>+    if (vhiod) {
>+        error_setg(errp, "VirtioHostIOMMUDevice already exists");
>+        return false;
>+    }
>+
>+    vhiod =3D g_malloc0(sizeof(VirtioHostIOMMUDevice));
>+    vhiod->bus =3D bus;
>+    vhiod->devfn =3D (uint8_t)devfn;
>+    vhiod->viommu =3D viommu;
>+    vhiod->dev =3D hiod;
>+
>+    new_key =3D g_malloc(sizeof(*new_key));
>+    new_key->bus =3D bus;
>+    new_key->devfn =3D devfn;
>+
>+    object_ref(hiod);
>+    g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
>+
>+    return true;
>+}
>+
>+static void
>+virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>+{
>+    VirtIOIOMMU *viommu =3D opaque;
>+    VirtioHostIOMMUDevice *vhiod;
>+    struct hiod_key key =3D {
>+        .bus =3D bus,
>+        .devfn =3D devfn,
>+    };
>+
>+    vhiod =3D g_hash_table_lookup(viommu->host_iommu_devices, &key);
>+    if (!vhiod) {
>+        return;
>+    }
>+
>+    g_hash_table_remove(viommu->host_iommu_devices, &key);
>+}
>+
> static const PCIIOMMUOps virtio_iommu_ops =3D {
>     .get_address_space =3D virtio_iommu_find_add_as,
>+    .set_iommu_device =3D virtio_iommu_set_iommu_device,
>+    .unset_iommu_device =3D virtio_iommu_unset_iommu_device,
> };
>
> static int virtio_iommu_attach(VirtIOIOMMU *s,
>@@ -1357,6 +1444,9 @@ static void
>virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>
>     s->as_by_busptr =3D g_hash_table_new_full(NULL, NULL, NULL, g_free);
>
>+    s->host_iommu_devices =3D g_hash_table_new_full(hiod_hash,
>hiod_equal,
>+                                                  g_free, hiod_destroy);
>+
>     if (s->primary_bus) {
>         pci_setup_iommu(s->primary_bus, &virtio_iommu_ops, s);
>     } else {
>--
>2.41.0


