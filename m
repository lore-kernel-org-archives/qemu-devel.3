Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BD1CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLH4Q-0000XB-FT; Fri, 08 May 2026 05:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLH4K-0000Wd-K0
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:00:24 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLH4H-0001C3-Mn
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778230822; x=1809766822;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7XD2eO4UyyS/lXzy48QerZXJo32kYKPzkXZVrtYiZlM=;
 b=OUnUvqpqX60dAdKBCNhu/IDBYyUTFCgu54QtlPaVOziPKcxtZBTUnaAp
 B7+zKnuUX7KrC3XIZbyvkqnybK5WKbuI6SXktHJhmNI4lgUi9rs43a47u
 RWMltVPPeL0tcVvJXMT92yuswSbsXQNmuprQ3CHjlCBJN117rfcCSB+oe
 8uGGkK6R/yPcM0RAgdgpebdX0MOfGG/hQcfKFEJCPz1JOoh4qqmMrbl5W
 8TrkVZR/din8OjpEBV9YG9jT0wMCJHysDsFXcM2WmSaN1671oxxA2B/fL
 f9b7ZgVenvGgXOrQhZ78kgjhfQSQzbBqoRM8ANvTrOyWgLD7yxlNjIx/2 g==;
X-CSE-ConnectionGUID: ZHwbgphwRD+p8eg4ggCi5g==
X-CSE-MsgGUID: dNoWIihCR7OEvBoO2T++YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79302301"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79302301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:00:17 -0700
X-CSE-ConnectionGUID: /ojGUCv2SfKDr/4V8/561g==
X-CSE-MsgGUID: VZAl05bcTzuBZXMqEdlbfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="232367503"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:00:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:00:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:00:16 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDcTwz/JUaQP+PWWgM7s3Jith64+9Q8KzN51cZYZkzi2hCDn98Ofc7anFkd1rYqB4EPsJeRLKmC+QPoO3xoQQ0HUgzotCB6N6jqzHH+ONg7LYnqTw476vadrDAClf8WKGxYWZvU7i7hC/5NQxd+hdr4XVRIbc4X+ISkFLMyWvNokOYQQ+hhO+ncivbfz/I2bllUu6kfM4tiEO0m3TV6uYLyv2wZFjNWgVh2u7Vf8ZNRLkeoNda4Pnw7iUvQZg4S5+pTqTFIL+tXyS96ielYfQT0P2uFz7xcCije3BnFucOGD3eXSxfSE/xsBsxeJbJWG+GO+Gdx13rFNylI3mcuUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYay+CeJBC6HuKBnyEOIUv2AQRkZuciRfb12KeUO2oA=;
 b=FVnLWvHxIL0uJ8XBRpkQsuKh4SY56czbGFIbfLeQ10q86CtDjix/7oL1Cnz03j8SeCNml0Li7m3g2gQgGFFB56PXCypMMNrirbci3qLKjExNz+PwuRYFWgKZWu6I3wDjhMyujzZS+xebnQY1pah7U7vzfYh/8poVOFVGaGo4QOqwu6UY2h3Dt5+jlhEncmZ0OOBn3Rrk79myFkR4XzBkI1bvaST1WGdSItUuQ3JyObGpdoKufTO4oe586TyYvfI5nqRd0EV2n45+Kx02LOf4/xLGK7JPLMQoAiRLRndL7JcO34qvX6ZUIXn2kTu9D4sr9oiiKsd8GI23PiRl0MqLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:00:13 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 09:00:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Topic: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Index: AQHc2HD8BanUNHqXVU60FS6iP2zM9rYCKcUAgAFEo1A=
Date: Fri, 8 May 2026 09:00:13 +0000
Message-ID: <IA3PR11MB91366207BA6A1182AF85637E923D2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-9-zhenzhong.duan@intel.com>
 <b92a2bf357a436a40f4bc2f955fa7589d41c6564.camel@bull.com>
In-Reply-To: <b92a2bf357a436a40f4bc2f955fa7589d41c6564.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7876:EE_
x-ms-office365-filtering-correlation-id: 4db0b111-eb18-4f31-7720-08deace03788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: h8eTYvX1pUELWV6S/2yUZmKCBsC0iDIT1e3Fyjt/r2ig3VcCVOA0HQZ5lmMIuc1+q2UVhAlZnRw4x42iG++5mtwFB4MDWPOtC8z3llPhil6CwJnyBZoa7D5SAPjoLYemyoUGTDkwfJdVcqYy47tnasjuwxZAPhwBG1xYbXangcnfkKnLtOmGwBHx/510ql3+ay5ybXM8bwu4D8X4EcT1KpS1oa9HrrGMJPldnp+aQWEDI0JbtKsfaO3aPZbiMwCIn+x1eERD8G7WMpp4z3xe1g4YN1fuiXXPyM3l6X5IlVwWbVTqsXtFs7f5beC5MFTHslTFhzmJPTQzO1dHBohZ33LaeoyDwGC4RDqIeUsmd7Lx7zMgks9ft+rG2FYT4bNM9cf//Q71MxKI65c8KV3m4K98CabwF10KS0k661m4LkYzFPPyEl5sG85tpRXlH3NBthDHRVT1FQhtaLq6cnxlpEhEUEYtbI6VXS6G7XHXK2G2mM2foaKGXsU8S8Ll+LHf9VEWEsVCDr1asYZAYNnTbNFYQqHOZkbygzhYnXOd5V8T+G+k1no5MBVRDTpRZELmR9c+yu9EXPbTrmLelguBien2cOAVLXwrIPJelM0ZfdfkIw/q/vlkvx3A3phk14TLCnTo6dx5ELmnbrH7ra/HEVWMptmMVTcm7eCp/Ecl0r/RIiPHTOhAOVv4B1Rs0GPrHL09SuAwl7SIVJqUG6fGckwVbceASdcXo9ip+8tZzwt2xSUzIt6BqiJffhLk+F6U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WbhUWn8pKOCLJBHZN45o2jNZVJ99aTpWgujOWeugYtsVKJO1Y9nOa4sC/x?=
 =?iso-8859-1?Q?B/42uJFa4bUOU43HUWwNRE+a1vkHmIZQnsMLl2oy/4bEX+E8zPi9OnEx6/?=
 =?iso-8859-1?Q?5AT7h3yF7dq2uHGpHhBt0fSdTgOrMknInprSqCPOjfQXP/vizj5NX2FMJM?=
 =?iso-8859-1?Q?e5H6D50mly+/+Fn+fmM0FwQ4Ajl/zlqM2E3A332w5TijvNWE59yROx8tBV?=
 =?iso-8859-1?Q?zTqB1uIt+3KQwqdm/FsDRCYcN9AJuTH5tK3dn4TkCpkY2yTJ6GdN09V9PB?=
 =?iso-8859-1?Q?w1KIt2f+2mwAw3s16+m9wDEhWuMiYbQjvYLj2kNF9L/6qyrSYFlKQXivFS?=
 =?iso-8859-1?Q?CfFLs+UGZ3RlbY7AEeVaMC4kNCo+d3Ek9KqULgwm2ol9TjatoQVqjyCA15?=
 =?iso-8859-1?Q?CDukMWacjJsFCViamrQdVeFecaqX/xWKJQLly/LFr6qjYQw0K0m8pwhhEl?=
 =?iso-8859-1?Q?HUDX2HUWM6tJBxJIW92yKAMXjzB/xqkgYTb1whEFI5xhI7SSrU3og37hJM?=
 =?iso-8859-1?Q?s2QNrJCKDpTxBO8kQWC+gZcEdHb/JzOMAaGZDBSlXG4pCbkvRNl2jOg+D6?=
 =?iso-8859-1?Q?hLZIkva8whFeUNagRrg+aoYufxqjzogGxEyC/Wfk6Xogcwi/CirCjLfLz1?=
 =?iso-8859-1?Q?+lMYYeWpcGbGeWSstQdvQI2gWPzjRTwl/mCNdpigEGBkjPnc1kI+cndJFb?=
 =?iso-8859-1?Q?kswtfqMsEGiNkebQ08a+vltpPQCBIpYT6oEIXZqzn/Cjrzfj7jkOVvfE4d?=
 =?iso-8859-1?Q?IBnN1Y1kFaEHPPgIKzgSyoDyiI8B0a05NZAw1zSFEXtTl9daEGo9s9DZ4e?=
 =?iso-8859-1?Q?3gkl/SEJEUtYkxHv1Lc9TPLsO64GVMcPj8oQtZcieRVMQQgDlxHXaVKrrM?=
 =?iso-8859-1?Q?umTt8PoiJt4ZbE7EoQqEcRXfB/rGYsHrCj52NfFlUvaKLkhtZj5rnAea8n?=
 =?iso-8859-1?Q?NE/mWlhGrpY35G+p6T7eWX7avbnMSe7CtWeNXedes+Lgp+qfTdCDWc/4Gm?=
 =?iso-8859-1?Q?tmfQjcaHOGxBCX9O69MBN1W1I2qKEam3iYv54+HlqJo2iLX5XQu7AvL8Cn?=
 =?iso-8859-1?Q?OY3kC8+4vxP509SLKQ6N4N8JehmvTvUe1EwwFA98urpfNSNpKCCfu5Dedj?=
 =?iso-8859-1?Q?JbeYYOus6YNIbVRvCqGv9JwGJSfCYi4ybhuvyVbESrKnJmD4VQpwqETHuN?=
 =?iso-8859-1?Q?jiv8E3l7XYF9Uo37nLS4RGnbjCYIThWxYhCfcSyTZoblKi1v8KtkSDRXaf?=
 =?iso-8859-1?Q?Yxsn7Hp3C4YHOm92NSBO95GRz0s97V18zggvrOF6vzhnojjz6KPoeevmvE?=
 =?iso-8859-1?Q?tsTUUgNXaEgJeO7X4PJVA66uLCvIgbd3g1IB23pNf6vWp8YRilbtQCJAIE?=
 =?iso-8859-1?Q?hzQRhlpCuzijpI5XNvZUlKA4vPw6zb3eGe/DVouRRzZBsGEoXFFNUiOFuX?=
 =?iso-8859-1?Q?P0p5jYsXQcfJQiAQ/AWpEWcbDSMdroCRaXYO1q6h2gaX1kvg/rTQtZG7/u?=
 =?iso-8859-1?Q?fKVPoMb8jqGddTMSuT9hVODgYSH+HH1Ewd67Tz7pGd68yRwD/d+We2aY8f?=
 =?iso-8859-1?Q?RkSmDJFSB8kp4nxICmKLgEc5p/P4JdUbPEv5Tv1bPWVA84xj/ufQOkULqq?=
 =?iso-8859-1?Q?chJppZY6zpETwDusPiFulf7cAlF4gJyKccvzKgTw85aOUYu7TNb5YG4st7?=
 =?iso-8859-1?Q?KRX82nHsmFjfqMSP3/6nBc59sf+DI7Z5g5RR9nrTrA/ULiRCqxZ640xNCs?=
 =?iso-8859-1?Q?MkuCIi3763FSVDhtJHC/QiUIjUcI+HQRWyznU0kXkgG2vzAElI9J0AC9ch?=
 =?iso-8859-1?Q?2DRs24qd6gi8E6L4sBKLheJS8kIw4I4onbfzmdNoIh4MrGZunFfYmq9d24?=
 =?iso-8859-1?Q?C8?=
x-ms-exchange-antispam-messagedata-1: Bp0vgS0lr9kwdQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dD6LhOKhSn/ukDpRB4A7cOC6uArIooYyC9ew1At+GeCBz0uFZq5I+Qu1Iy74CMrjMTHbbJyJUm6t+NCmBvXkF5xCHvUzAmIhb3Ky/PPnJbcsU/g7cZSy2nOVEaSSwa8ArlWvmwnA8y3PrQ7eY/uRKMz1hYkY+CIX/tbo8zTnplMszEHdZxDBHSa3VKVHm/FcpljVLq/N3wMVTqNRA1vWcdlZyDcVo3WE4cBHlf+Xwtn6m1CieSHpWcdN/hWG3Bd+W0MXfd+wmhUfRHv/o5gPYS3engxsi5Vf5UwY9Ze6OZreH4FBWzvTxcIV96fSRch7AhyCMz0VQIuDpCM3kmWFNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db0b111-eb18-4f31-7720-08deace03788
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 09:00:13.7342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaQluyGLO2+BVrwlDhr+2OnJN5d7auazicF6nCcOGScBgZ9s7f4WDNCL26wJcXqi+i122D9SVNvmOZUxZxENPb7Fp/sFi2EiMgSEejX9Wjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Clement,

Good finding, it's not good that PCI_NO_PASID(-1) is set as VTD_FRCD_PV whe=
n pasid =3D=3D PCI_NO_PASID.

It looks error prone and confusing as we still have both PCI pasid and iomm=
u pasid in intel_iommu code, I am trying to set vtd_as->pasid to iommu pasi=
d to avoid those check and conversion. See link https://github.com/yiliu176=
5/qemu/commit/9f71129bd215cdb5c416e3c7abb7c282fdb7c006

Thanks
Zhenzhong

>-----Original Message-----
>From: Cl=E9ment MATHIEU--DRIF <clement.mathieu--drif@bull.com>

>Subject: Re: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
>PASID_0
>
>Hi Zhenzhong,
>
>Have you checked these kind of calls?
>
>```
>    if (pasid =3D=3D PCI_NO_PASID && s->root_scalable) {
>        pasid =3D IOMMU_NO_PASID;
>    }
>
>    /* ....... */
>
>    if (ret_fr) {
>        if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
>            vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>                            addr, is_write, pasid !=3D PCI_NO_PASID, pasid=
);
>        }
>        goto error;
>    }
>```
>
>cmd
>
>On Thu, 2026-04-30 at 03:13 -0400, Zhenzhong Duan wrote:
>> In previous patch we introduced a global macro IOMMU_NO_PASID(0) for
>> Requests-without-PASID, this makes the local macro PASID_0 redundant.
>> Delete it and use IOMMU_NO_PASID instead.
>>
>> Suggested-by: Yi Liu <[yi.l.liu@intel.com](mailto:yi.l.liu@intel.com)>
>> Signed-off-by: Zhenzhong Duan
><[zhenzhong.duan@intel.com](mailto:zhenzhong.duan@intel.com)>
>> Tested-by: Xudong Hao
><[xudong.hao@intel.com](mailto:xudong.hao@intel.com)>
>> ---
>> =A0hw/i386/intel_iommu_internal.h |=A0 1 -
>> =A0hw/i386/intel_iommu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 21 +++++++++++----=
------
>> =A0hw/i386/intel_iommu_accel.c=A0=A0=A0 |=A0 2 +-
>> =A03 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index c7e107fe87..0141316f83 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -615,7 +615,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>> =A0#define VTD_CTX_ENTRY_LEGACY_SIZE=A0=A0=A0=A0 16
>> =A0#define VTD_CTX_ENTRY_SCALABLE_SIZE=A0=A0 32
>>
>> -#define PASID_0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
>> =A0#define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)=A0 (0x1e0ULL |
>~VTD_HAW_MASK(aw))
>> =A0#define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1=A0=A0=A0=A0=A0 0xffffffffffe00=
000ULL
>> =A0#define VTD_SM_CONTEXT_ENTRY_PRE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1=
0ULL
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 74642d8123..4d1b262d56 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -100,7 +100,8 @@ static void
>vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>> =A0 *
>> =A0 * Requests-without-PASID:
>> =A0 *=A0=A0 - PCI subsystem: Uses PCI_NO_PASID (-1) to indicate no PASID=
 present
>> - *=A0=A0 - VT-d IOMMU:=A0=A0=A0 Uses PASID_0 (0) to index the PASID tab=
le for translation
>> + *=A0=A0 - VT-d IOMMU:=A0=A0=A0 Uses IOMMU_NO_PASID (0) to index the PA=
SID table for
>> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 translation
>> =A0 *
>> =A0 * Requests-with-PASID:
>> =A0 *=A0=A0 - Both subsystems use identical PASID values (1-0xFFFFF)
>> @@ -114,7 +115,7 @@ static void
>vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>> =A0 */
>> =A0static uint32_t vtd_pasid_to_pci_pasid(uint32_t pasid)
>> =A0{
>> -=A0=A0=A0 if (pasid =3D=3D PASID_0) {
>> +=A0=A0=A0 if (pasid =3D=3D IOMMU_NO_PASID) {
>> =A0=A0=A0=A0=A0=A0=A0=A0 pasid =3D PCI_NO_PASID;
>> =A0=A0=A0=A0 }
>> =A0=A0=A0=A0 return pasid;
>> @@ -969,7 +970,7 @@ int vtd_ce_get_pasid_entry(IntelIOMMUState *s,
>VTDContextEntry *ce,
>> =A0=A0=A0=A0 dma_addr_t pasid_dir_base;
>>
>> =A0=A0=A0=A0 if (pasid =3D=3D PCI_NO_PASID) {
>> -=A0=A0=A0=A0=A0=A0=A0 pasid =3D PASID_0;
>> +=A0=A0=A0=A0=A0=A0=A0 pasid =3D IOMMU_NO_PASID;
>> =A0=A0=A0=A0 }
>> =A0=A0=A0=A0 pasid_dir_base =3D VTD_CE_GET_PASID_DIR_TABLE(ce);
>> =A0=A0=A0=A0 return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid=
, pe);
>> @@ -986,7 +987,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>> =A0=A0=A0=A0 VTDPASIDEntry pe;
>>
>> =A0=A0=A0=A0 if (pasid =3D=3D PCI_NO_PASID) {
>> -=A0=A0=A0=A0=A0=A0=A0 pasid =3D PASID_0;
>> +=A0=A0=A0=A0=A0=A0=A0 pasid =3D IOMMU_NO_PASID;
>> =A0=A0=A0=A0 }
>> =A0=A0=A0=A0 pasid_dir_base =3D VTD_CE_GET_PASID_DIR_TABLE(ce);
>>
>> @@ -1529,9 +1530,9 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s=
,
>VTDContextEntry *ce)
>>
>> =A0=A0=A0=A0 /*
>> =A0=A0=A0=A0=A0 * Make sure in Scalable Mode, a present context entry
>> -=A0=A0=A0=A0 * has valid pasid entry setting at PASID_0.
>> +=A0=A0=A0=A0 * has valid pasid entry setting at IOMMU_NO_PASID.
>> =A0=A0=A0=A0=A0 */
>> -=A0=A0=A0 return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
>> +=A0=A0=A0 return vtd_ce_get_pasid_entry(s, ce, &pe, IOMMU_NO_PASID);
>> =A0}
>>
>> =A0/* Map a device to its corresponding domain (context-entry) */
>> @@ -1592,7 +1593,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s,
>uint8_t bus_num,
>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0 } else {
>> =A0=A0=A0=A0=A0=A0=A0=A0 /*
>> -=A0=A0=A0=A0=A0=A0=A0=A0 * Check if the programming of pasid setting of=
 PASID_0
>> +=A0=A0=A0=A0=A0=A0=A0=A0 * Check if the programming of pasid setting of=
 IOMMU_NO_PASID
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * is valid, and thus avoids to check pasid e=
ntry fetching
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * result in future helper function calling.
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>> @@ -2150,7 +2151,7 @@ static bool
>vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>> =A0=A0=A0=A0 vtd_iommu_lock(s);
>>
>> =A0=A0=A0=A0 if (pasid =3D=3D PCI_NO_PASID && s->root_scalable) {
>> -=A0=A0=A0=A0=A0=A0=A0 pasid =3D PASID_0;
>> +=A0=A0=A0=A0=A0=A0=A0 pasid =3D IOMMU_NO_PASID;
>> =A0=A0=A0=A0 }
>>
>> =A0=A0=A0=A0 /* Try to fetch pte from IOTLB */
>> @@ -2515,7 +2516,7 @@ static void
>vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>> =A0}
>>
>> =A0/*
>> - * There is no pasid field in iotlb invalidation descriptor, so PASID_0
>> + * There is no pasid field in iotlb invalidation descriptor, so IOMMU_N=
O_PASID
>> =A0 * is passed as parameter. Piotlb invalidation supports pasid, pasid =
in its
>> =A0 * descriptor is passed. In both cases, pasid is converted to PCI pas=
id
>> =A0 * before checking with vtd_as->pasid.
>> @@ -2586,7 +2587,7 @@ static void
>vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>> =A0=A0=A0=A0 vtd_iommu_lock(s);
>> =A0=A0=A0=A0 g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pa=
ge, &info);
>> =A0=A0=A0=A0 vtd_iommu_unlock(s);
>> -=A0=A0=A0 vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PASI=
D_0);
>> +=A0=A0=A0 vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am,
>IOMMU_NO_PASID);
>> =A0}
>>
>> =A0/* Flush IOTLB
>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>> index bd1236c070..8940d240a1 100644
>> --- a/hw/i386/intel_iommu_accel.c
>> +++ b/hw/i386/intel_iommu_accel.c
>> @@ -217,7 +217,7 @@ static void vtd_flush_host_piotlb_locked(gpointer ke=
y,
>gpointer value,
>>
>> =A0=A0=A0=A0 did =3D VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>>
>> -=A0=A0=A0 if (piotlb_info->domain_id =3D=3D did && piotlb_info->pasid =
=3D=3D PASID_0) {
>> +=A0=A0=A0 if (piotlb_info->domain_id =3D=3D did && piotlb_info->pasid =
=3D=3D
>IOMMU_NO_PASID) {
>> =A0=A0=A0=A0=A0=A0=A0=A0 HostIOMMUDeviceIOMMUFD *hiodi =3D
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod-=
>hiod);
>> =A0=A0=A0=A0=A0=A0=A0=A0 uint32_t entry_num =3D 1; /* Only implement one=
 request for simplicity */

