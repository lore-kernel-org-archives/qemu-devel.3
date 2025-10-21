Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE53FCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7hv-0001R6-GH; Tue, 21 Oct 2025 04:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vB7ht-0001Ql-44
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:27:01 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vB7hq-00076e-4f
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761035218; x=1792571218;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jUIZmd7JIICPUzVy47QppSw3s/xKoMIh18kG258C9lM=;
 b=XkFD1Oa2Sq+NYX3xJe6IrCtQi7s17lmksPNdKLgeg974lI8HK6s1Q9p4
 Lrk4tJW9SsY3UMaZ5p5KcYRSC69PnNlvSF3Nf3mmYT3iOis/V3UHNKEAF
 mu7O9A1NiiVDhwSLxGJtXsq8sS8N0204bLtrmr0Ug0lc+GlK+wur3GK1O
 eQOixMCahYNtAX3ZgPhmt3Yp4MJH/jJO4Pgi4msYGtZ5QeMWweLviroYi
 sfAHQDfppItNYO0IFP6JmcpBOyV3uM5ML6948823QNd6BTHWupiLlcwHY
 AlgUsX8qjFshyTGl4xvQQT/CGyVSiYFRtfoRxQV106+6tQJeTHUEqOpG1 w==;
X-CSE-ConnectionGUID: RhM71/RGSUWHC4Li4XyU0w==
X-CSE-MsgGUID: zRvo2qiPT/CHE6kzx4zKlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63197006"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; d="scan'208";a="63197006"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 01:26:54 -0700
X-CSE-ConnectionGUID: RKEtcbOHQuivHNPdqAbbyQ==
X-CSE-MsgGUID: W4dK7p5eT0epcDK+M08tPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; d="scan'208";a="220705030"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 01:26:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 01:26:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 01:26:53 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 01:26:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU+wssEQ30x+8GUj02J/4alLUHE9X4rvhk713d/WWmcwQb7tF7yOee9tBDiptCI0SxnY9r89GAkFxG2+D18zbj24Z1ZDLSQXohtf9+omDINSbON0fcBBsnqqfrAY8gwrlUbXOTjfjxQ5yfr5r/wdakJEOz37yhzjS/4KEAD/bz6a9Xb4BsaAtjDaaaUIwhc0nlTaCd01Y+M0uFhYWGf14A2wiWVIZVg4fBzD0WMeyfGi43M7VFTHAASsBTzFoWJSckXQ7lmgC55G1NwluLAWhhYn0u0FrdZdnE78Rhi4eJxFvIRS1hLak2y1qoAZlaEErD4HkTvEd4SE/eAvTxSghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUIZmd7JIICPUzVy47QppSw3s/xKoMIh18kG258C9lM=;
 b=kl/6hgW9Uumt5erO58bjqL+CrvmG2NNidD1B7HhgwRcbVMqRb6gY4atfiBhRg57isG8JIULBI70Yhm4CErH1mnvB6C4DhPddDqgeBxMMYC6/rIn4tBgKFJb2tpH2UK+VGjO7nIhIlPgXOT1hPMrj65Q+oBD7/mnprcciBjD3pgibbqJc26Xj7nCzAglbYDJRwMk42V+0erUSWT9xEXuE+L2GWMUSgPoOQIG6fMvKf2yGfflV/zMFTIoxXkfb+kntxxrSvE1Drhgf/SjwgfvOyNSC5jrxk4OzTL7G4msO5sPFjDbqIgdQHit7XOsBfFHTvSbRu60DdgVZJYI2F0gwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPF2F49754B6.namprd11.prod.outlook.com (2603:10b6:f:fc02::1a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 08:26:51 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 08:26:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v6 15/22] intel_iommu: Bind/unbind guest page table to host
Thread-Topic: [PATCH v6 15/22] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHcKHqV+eql//4WfkqjZkntzH311LTLP8EAgADf0RA=
Date: Tue, 21 Oct 2025 08:26:51 +0000
Message-ID: <IA3PR11MB9136117156C708D20F95162692F2A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-16-zhenzhong.duan@intel.com>
 <d158193a-c834-4fb9-b36d-487f3be4ab6f@intel.com>
In-Reply-To: <d158193a-c834-4fb9-b36d-487f3be4ab6f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPF2F49754B6:EE_
x-ms-office365-filtering-correlation-id: 85bfef7a-0a7b-44ee-c846-08de107b960d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Um3VmumlrFrGqc2DcWe2GZCLE2JBmM3VhAVuL5g2F++sJN6U0oig1Y5KMAEZ?=
 =?us-ascii?Q?q7XIH4QZM7kDYFydr8+PZX+kceyj8swyhMWoeBSNWDwFoCu+UC8ygl9aZo0M?=
 =?us-ascii?Q?VlKK+ui71ksWqQQFRN+CxjdJMcGrrMbXnKbrnjhmHopeyrEFZZQgt6Ug74ay?=
 =?us-ascii?Q?98vboRGSlgocqGYn0aP+b9UFpC6ix7EIkZK7RCpUpWArcL3MnAUqF5E3KTKs?=
 =?us-ascii?Q?HYwo5XElu1hPBcO/PRdrxEGjDoTg3vC9lc8oOv5yOW4oGY/W04xe1RKD89Jx?=
 =?us-ascii?Q?7ivWGN9O5QNM5ckvL7Cu5jXyzJq6CNauh/eGzoxQsc0QVxgf9Z+Awt8wFK5x?=
 =?us-ascii?Q?7sQE5VPwtwY90+IqkGOowwCqecoP+Aw5F+sQfw4r/X2QRolZrzyjHG0Kcl1A?=
 =?us-ascii?Q?hSuSHhpsxrosn0Q/5M/NI9513HG7sLY0U4vZ0Qp0o6l9kr5dfzn0M1oljvpb?=
 =?us-ascii?Q?nD+a1/0PMcG1rZ6DrvTzS4GITtb5zaIRQlNti2wgDVef8CbSTK1htE07vlfS?=
 =?us-ascii?Q?QOsChn54Ed7AZp4u0VtNyiUlTB9dxFfgU1l1hjZYUabyn72yeGjVYzeqer0q?=
 =?us-ascii?Q?7OWeLcMALdwPT9k9ApgYe5QUxv+wm/KYHw/xLr0oskAOluw2CcSyKf82dPks?=
 =?us-ascii?Q?rHjAOu+OJosFcNDUY4w+YqETLOYKdy1AHUYadGas/NAUzY1Ue17VphLgWb+j?=
 =?us-ascii?Q?utoTGtljzDhCf+QNYaIUdJs0uAfiArxZu7v5aqKFooxPffUgoDQnOu3hDU3S?=
 =?us-ascii?Q?lsRRSItXpA2aDGlf62rwd9qHURZKDNEUENYjkTuMS3bWb10H4SfimnO/+Sn4?=
 =?us-ascii?Q?82K0H/GlUAcBUhLAR874KnwL0M6rLYTB3ssBVIAE30k5qZImnjpXUi/Pcetl?=
 =?us-ascii?Q?3y+kaLrX0qBD2kzZNv+AWigqO5OMkRD32UBky/FqsE5m/CCZMxOyaZKSYUQ4?=
 =?us-ascii?Q?qWjuXZAyVwoGymxbe+JobWgW6lUVmF2szc/2VllJDMJH/rrqe7TRHQwmIPk6?=
 =?us-ascii?Q?KcdoYV+i+CP/qIXKCrr2bzNISshXUMKNtJbTP6bbORbtUWXzqf0hV+lfMBp2?=
 =?us-ascii?Q?GeG80d3YtGCiGYTPP1Qdg/0DWT7eDaxFDWHNlPN12GXeUEErUDr3uEeFGyNz?=
 =?us-ascii?Q?5iE0a/csAMAAN+QgziRt191wubpAZ6OG3kDaQRedIA+l1ULq/LH62r8jS5S1?=
 =?us-ascii?Q?HfbE75fUZEH6VSnL/1VodiTUIPciU4vwAk9kf7rWuSpKSxKwFW94C1G6XtBR?=
 =?us-ascii?Q?bkn9RcY/vJPBw/aaTYB+1ycfl4h4gHnwTApQ+aR5lkn02IYjc25JhGIxKzLG?=
 =?us-ascii?Q?5ag7i4e0ghHf6tlta8UuaPEl2+dKwUOoTqVpV7LdNtdTzBMJ6wdlik4sR2eK?=
 =?us-ascii?Q?EyMrsou4yHvJibnIHhTia6Trzqc1GJJ4NTzsTY7mfaDJ9QCMZnluGMBRj+Dm?=
 =?us-ascii?Q?KkKl26x5clX8gic8rp7gvJxhVEB0by1N/GCfHb7gZ/MDW2xOJvKhSu3Evx6k?=
 =?us-ascii?Q?6lOh5fDLebYUjBjdUa/ofSeJodHvbXDHLJmF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fLh43P8SDntmaz/NIGVteDfON9jvLreOVJI7preSa47orggjJGTY9B56weAT?=
 =?us-ascii?Q?pV8epGNObdwIr9FQGhmA2FMLlozgz42aprrYLSiJmi3ZUTY09hqUWFlFtVXe?=
 =?us-ascii?Q?k01PqJazyOR18JdehiAuY67WaN/uwYbIxRk47Kp39/heFR8igwUHV+H0dahn?=
 =?us-ascii?Q?edcHyG7MHA5PbBcSYxcUt0NlpSu07T0DBJnh37JFzEPyNwC8orx9apjuTrsz?=
 =?us-ascii?Q?xw/pgt9+P8Xn80yh1g2p1v1HRYFevLUiuaEJ+s5EqSR5c+6CsbftNBsNEzxT?=
 =?us-ascii?Q?rvG03lxEyL28StkpVFktX2L/HeVHRHj8V37RL1EWBfXvDVsUnOpGTXdJ1o9f?=
 =?us-ascii?Q?Apye08ruwdUHo2K++ktQpuPOR3jjcdzNbz6/cYhxGP/s+ymYf0+2Zhq/q1P3?=
 =?us-ascii?Q?8y7v0LcogAqOYI4zYUBMrKXRqtvZPvkfK9bJj98XOGMDYFKjBbxpWKD8WwDU?=
 =?us-ascii?Q?llyskZ/UT8hFGzwiJw9HUzBmRM1cBXVcwUkxvvAD+WKVge2lOX4IPLkS73BD?=
 =?us-ascii?Q?RHv0pe0BjmMA+JOpYl4m3lW2JUuI7YTtny4u1/V/haSNCTNBx5aQIccjnIyo?=
 =?us-ascii?Q?Dvli3InEBM7gy6YcsMYNuvbyMDq1RiuUMlDeoIBhm/ArzQdFMPRaXZ//kOfz?=
 =?us-ascii?Q?99FANGdc8Cm2FZCKVgss/9vqSOEk1dQbYLS5n/d/UOh7hB1PELMXbleKQxk3?=
 =?us-ascii?Q?aik81GHk4JjjV379l0RvzVTjx2V1U5tQ49gwsrhVN+dEsI4VJSAJDyQ2vT4N?=
 =?us-ascii?Q?H7ISSaCYNqP9bT3QYXhfI/nM6ULPsKXrSAWYOmSKB3091juKpmQbcvbaKmLq?=
 =?us-ascii?Q?KCcwkBWuYuFPsXPOMmIfSMCv06SGIiALTccZY7/qdrUs2U2vNWh0dOE3w1oj?=
 =?us-ascii?Q?CAoCqBhsysQITCNq37rH8yqOWmBUNwp97zKQsLX14ixQ+W8ScvBpIMFqB3S7?=
 =?us-ascii?Q?n6dI28/IEQDX4G/rEglkLEiYx5NCCj2+xgazDWTXEbWA4RtScNSGmj+rdtH0?=
 =?us-ascii?Q?66rxBXqVrnl5FJ1WzUEdSL9LuEsg9Bx4e/UQSeWoYQy+1QiFByXU21lCRwVs?=
 =?us-ascii?Q?BrUUdFIdA9Ici2UoDbhfhVVa0hz8WAamYafyPuF/xiYNFxIetpuivVC3mG7v?=
 =?us-ascii?Q?nNg5DSgHrdCnTMGf0wRlIsH896wLR3xPUZ9qUpa7IIiOBEIwsZ+y1gwHYlEE?=
 =?us-ascii?Q?nltjWgl81il+I4kEyzcS7zDi5yEWg1DlWOF0293DbjZ9Uh0jvfEqrdgSkcYP?=
 =?us-ascii?Q?yekUMlEikftRK7h7C4g3n9E8AjL0VE676DBdu3vjXcvlP/R8TW2NWgu85Amw?=
 =?us-ascii?Q?OuGYp4PWnMQnz/XulC0s+UqcRJ+ATPRj9Nytuc1x6i6bw0wfXumPyEbCiEOx?=
 =?us-ascii?Q?dd4kP7n+kzB642RGU+NEhnz3o1vpIwUfhdV1D0+X1dTTaiI/S2VZpiRrO+CG?=
 =?us-ascii?Q?GjtUkgwSh94oZZwDVlwcjwAT0bQxdau1KSkwoXKorLRYCAYrd5hX0go1/ihS?=
 =?us-ascii?Q?nXQhkQ9DO4BoZHg8aH/PgJVfKwLlInMQLo8dq+p9+iQhcVXQgN8vMipRUgsR?=
 =?us-ascii?Q?GzXmu9TKEPan2p/8wepGXaon5Yy21DavyNFSL16F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bfef7a-0a7b-44ee-c846-08de107b960d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 08:26:51.7412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lapeOQ4fPZM+iLK0wMb1geJ6PljqLySEqxyK5va1BG2VgfU+Pp0HBLHJP6G15ZkGYe8O0LjyKmUKKrRvGEF5LtHNY2mNjE3hBvnKwqLMBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2F49754B6
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Yi,

Got it, will do.

Thanks
Zhenzhong

>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: Re: [PATCH v6 15/22] intel_iommu: Bind/unbind guest page table to
>host
>
>Hi Zhenzhong,
>
>I guess you need to rebase this series on top of the below series. So
>let's resume review after rebase is done. thanks.
>
>https://lore.kernel.org/qemu-devel/20251016074544.377637-1-zhenzhong.d
>uan@intel.com/
>
>Regards,
>Yi Liu

