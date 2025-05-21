Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A97C54756
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 03:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHZs8-0003eR-Ob; Tue, 20 May 2025 23:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHZs6-0003e6-BN
 for qemu-devel@nongnu.org; Tue, 20 May 2025 23:11:58 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHZs4-00050P-6T
 for qemu-devel@nongnu.org; Tue, 20 May 2025 23:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747797116; x=1779333116;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n5NyMrAuU1T1W6pHFhrsMECoS0dGs2JP3sypeHfJBH0=;
 b=G1azRffSn5wk65IsV3QhzWMPhlJwMGQMIbdGmRDoNe0I//Q/b4W85ndb
 hTBEEn7sHHxF6VmOl1vVerYvzPqmLteRirkdZnzEwaxYb9pN/xJHz8NhO
 HAtBesmQu7QwzFOeIqsNdsZs+urr7fJUx/TOWkI5CcEVZlEpJfSmPrd3Y
 /lbhlHTudVXq5W2Vt3U+++9LS28UCsowM0c2i9EtRPjFSIAjevJMANVsN
 UPZENJIZzH97ziTny8LgEXVvLR3tvJcjh0bmQYAL1cPPa+HxMHgZMpO4V
 /+6WqC62dqO+eSEzBINy8yMZBXmSjkMwm3fEcgR5ztESu0qTmCTdRQ3LR A==;
X-CSE-ConnectionGUID: 9wbAdyk9R96Qo+yXzkuy8g==
X-CSE-MsgGUID: vft/ERtZRhmcC84pZo8+qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67173473"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="67173473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 20:11:53 -0700
X-CSE-ConnectionGUID: JWfLuhc0Rd+G/uqPenTB1g==
X-CSE-MsgGUID: X8s9skDNTuSi69kaeRfMVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="140937082"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 20:11:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 20:11:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 20:11:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 20:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNFwzZKFTLzPTRHnC4+is71kBiExTONxMDeaJ0VK8VB8WDg6+ta3uRnCRtPQXLFYunY6xZ2fbQNQIc5/67NRg1uVQBAZcPntRNOe8vhfPaqhas48YRp5/+v6h4BBRvcdjWt4tgqiuRNedCBY4/xDOS3dxqS2MEHD2ef942Gx2ymWzPiKFc7oXIJVGNzYsNfQHJtO819lTVgKPVuEd6xvIvShpEU0WE0klaPGU0R6RUAgiWMUbvMeo20VRryIWKxgo/5v5HXkB2jGKgi/cRd5TlAdIRthk8HHyKX4pfaoNuf5kVgCBWpDR/U8QuWLdtJWiHWT0L+bvLSarNEzoPNigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5NyMrAuU1T1W6pHFhrsMECoS0dGs2JP3sypeHfJBH0=;
 b=CbN+SeNMiJMlUgXCPFK/Xrx+Czl9+m5zvohxCpMYFCHiFCeIplzH662ZXRcmG0oOLUHk9kYT222mv9s50yOFTePqLjcRYKI2xhvFCpjGEwiRXnDSUKZ0VXKdc2BD7OLCcdbGKEe7F6yU/MsIIAEFMcKvKtlfqsz+3d8KW8JygJ48AEPzLxHwqCztPTNPEjWERWuzSf52cY32k5JcZD4orfC6zumBURQEKAQY33mWlsE21Ame45uUquuzBGu+Uf8TWhq6a44IRrvzyX5V0o3bd6tgYO5PRu2OnrvK5JQSFCUaBu0jBf+HtbxR0CBbjTfZj2gRLVj093VeaqSxyGAFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 03:11:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 03:11:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Topic: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Index: AQHbw1yUpeYjtdu/DU2o3xTJaAJiQbPU9flwgAUvL4CAAdBwAIAAb8tQ
Date: Wed, 21 May 2025 03:11:44 +0000
Message-ID: <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
In-Reply-To: <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6742:EE_
x-ms-office365-filtering-correlation-id: 11ca3042-c55d-4635-17ac-08dd9815374a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fbshg5nV6dDO17Ao5rCYBfOJUYeJBlrUBZPWY1GP6dds3YPMvldNCc/1HQ?=
 =?iso-8859-1?Q?UFww7+JHqOkD/Ae6vSVXg/miA02yUY4Gy3bsYSiMOkAfqZKwipYwJYwB8W?=
 =?iso-8859-1?Q?zWBI6DAz1eNwWD4OsNjJCAABXAD01NTyhEwQY9zdJGuLq0EXMmx02Dcfdp?=
 =?iso-8859-1?Q?1PMtJCWOnfByU0fJvYI70842/OnJr5ywBWL07U+D9XyKHOzcs669g+UhS6?=
 =?iso-8859-1?Q?GOrarY3vgftkSOzsdfSSiRkO4QnKxMpQ8SfM0w2+lfFLtNEow7b7yDkfAP?=
 =?iso-8859-1?Q?Av3l/1BCYucTIlpLu7NdMtTlrTgAYGt0fKt9dFjonB0IOo5w+8f2grcWMs?=
 =?iso-8859-1?Q?T+P3FkEjF7aDUCzXAACXOjIfPY9Oshva/HUyla88HnOyhGCSoXPe5Ax8xV?=
 =?iso-8859-1?Q?BIejn0rr+xf93mRjgNsTz5m9l8ZTK5tugTq4tLiWOtBlrTTV8Xx/kVRojS?=
 =?iso-8859-1?Q?SKk+8Bxg+55LdEAx+5AnUDVrT8F+5XKPLKol86G7C4W9g7rKZp0hY+qehV?=
 =?iso-8859-1?Q?ICFqAiwvGRvn8tjlqiXkMDicbgq/9fi59fxkqF/JMkuw0+HMie/pWaUKRm?=
 =?iso-8859-1?Q?Evb55aHVRQYQh15hMxWYpCi+Jah0U6bMlpFbfZ6CJuvjdhC+WT8tc6Yrad?=
 =?iso-8859-1?Q?+qixgibdVgq4VkSCMuCzZ3uozU3Xm4iFwnC+VabINhUn7qBay97/pc0umW?=
 =?iso-8859-1?Q?4J3UUDS6xdZM4LrLuqOetyrpIWu61XLBuO9VJ/6XZPEo2wpbffI1JmNVW2?=
 =?iso-8859-1?Q?OzUrZ7/3vLjO+XpOqSVb7IooCfS2UHEITUUuaHIdavEVmOgrJTm95YmFBd?=
 =?iso-8859-1?Q?uElts2qYRpn/qiZ/fCU53rnFFpEIccQ+iWAH2aRX5a7mKVRiAI+1DmGUVC?=
 =?iso-8859-1?Q?0AQoyVtCFFmUN6FifIgtHrs2UaNfP2QAHHXogd8reSIw9CD03dJrHSG8UP?=
 =?iso-8859-1?Q?d/7dRZjYFcMkj0+jRkolD64fQw7S8FF/+kh6dgzdPbe4zNarfDd/2U4v9p?=
 =?iso-8859-1?Q?KYX6DT4l6RvICKhKki+VhhFV2jjOw0tf3Q7oJsULc4vxI36yJ1EmXZ8oE2?=
 =?iso-8859-1?Q?SEGMobvrzraLSLkuU2nNmVM6nPjgkEbh5dO5cThfOc3EvZIXZ+CbY798u+?=
 =?iso-8859-1?Q?AjGgwHMgoE6fgAIl3x9x9zrREpjjewHxyCgfQfIqRUS5D7BgfAiAyzDhL7?=
 =?iso-8859-1?Q?E9QZ7awE14IqBLSjXqTURF/qDEQ/W6vwleg2S07Frm0+KTv6OkAvGealus?=
 =?iso-8859-1?Q?nvGKsnJ/B77j78lWRDhVLsTTzXsEFIkOop6iJO/B1tVn6nB5iUmWbRqbtm?=
 =?iso-8859-1?Q?/D+D6dqxHZp7BENuq16qFkr1tTB6ye35eZEvHlBNdDwTOmA7u0S7nSJ472?=
 =?iso-8859-1?Q?lIDuZ4A/D/DiAWUTwJngKji13+Lxe0SB/nOAtPhSRTCin5jkUa6nVwWcL9?=
 =?iso-8859-1?Q?JZDinAbnwaz1NZ8nqAYTbD3Ky7XixM3LvSN8vNX591GHQdYg4N+nzTWWks?=
 =?iso-8859-1?Q?Ww3AeqUw5ryz7hI6qvvlYslCjQu9lug23Q+us0JJ7VkQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K7pzWIZtwNfFlBLGiwXywZ/6z6/VsoWg64KbK4xItu9XLecT9cTbIztO4N?=
 =?iso-8859-1?Q?ajlJT61jzmmquObxvjf6p/oqH23/auObQJ6k1fvI+ubCwo9bz+z02/Pkev?=
 =?iso-8859-1?Q?cChbgipLvSvOZCwxFMmhaCtcahX2NrotqynvM1Z502L0XmFtRiqZ3Z1TUX?=
 =?iso-8859-1?Q?mYjTUB5oKJIqSoqD20EUVxEmOs4b6iyOyJ2iElID8ov5x/zjUXvNo3Z6Ig?=
 =?iso-8859-1?Q?64vFUQywXfJ0P2Cql3KVliSbkzw5zSQQQWNabMZjhjMXywlDi83Tsvx41w?=
 =?iso-8859-1?Q?NqIqkAY2U4YqJSZjrb98IBq9PLYuZ/2t5ko7DIcJIJO3bthUEwPfTm4r52?=
 =?iso-8859-1?Q?n3SJEUs2Tqb4meDy7rH2U4nj7+kTsj6nmDkXjmxCgzCSDWRFx27HDeEQi5?=
 =?iso-8859-1?Q?mAflZgJTxzLQIuDlBCEk9pH9SXxvBq54QEERnIMpNYk2W81T215KO39cou?=
 =?iso-8859-1?Q?Xk+jCtE4zLX96uFSmwGDOTKEM1bvZWJP2XsarywbALc4xs8rjBDw4IJ+I9?=
 =?iso-8859-1?Q?BUzbmK6sHSup8GSwJVDjMPaPiyd39jRQCbPovyVLHqSmaAcLz1Qhz8Xgcq?=
 =?iso-8859-1?Q?e0rcoDZXWzT3AylPCwZ8nCY5ag+pDgyMB4sqRhECahwEdoQWKcL4leLGbz?=
 =?iso-8859-1?Q?rh0j2ykOmgstePXViYpkvus6Vw2V23tzekl6TbkNkEsIpMu6Xyv6LiPYI/?=
 =?iso-8859-1?Q?Mmv19WHdvzhwnqI3zUGPZV3tpKgbJBdnzfbz4Zhtli49/2e/ItUepdiyAG?=
 =?iso-8859-1?Q?KhHdrHFKRpwKp2u/XcOLC9fqyZzk4fHA/uK2mN+VrjSTyihQoDu7g8+AAo?=
 =?iso-8859-1?Q?+hRt7codMy9axlu9MvSjFDmHVMdfYO9mdGGT0Y28dCx2dYtO0NR/WTkeq3?=
 =?iso-8859-1?Q?yZh7U33S2kbTMxXyGV7g0y4kxdwVlVYjgKXM7/xBWWKA2m3ko1tdbdIGlM?=
 =?iso-8859-1?Q?Qt71PwA+K1AyM4AQHGMC83JabtNBEBbC6vHs+SOViC2oIKDwPFA7Kja7IV?=
 =?iso-8859-1?Q?q1frJArkUtfY0GfFZ8BaGGIJZpmMFN/s/JJhJB0Dli3XphCqRxN1LqkLTm?=
 =?iso-8859-1?Q?/tJBUlcYa/7pZWBoYd+qjODAd6lktbK4R0M3DyCKvK8nIwaKpDo8b9GEcR?=
 =?iso-8859-1?Q?oUh0gV0BDyoiZMhquQkgZt38OdB6qCo7BrQGuP/gwedIRIcpzqtYWpP2g3?=
 =?iso-8859-1?Q?moZXmComsfccYNv2fgt+SAFHlwu+YF07/LyjC6jqkqTYHvOBkzsIJcpp7o?=
 =?iso-8859-1?Q?0b2pYep7P9O64VbqR0yXl7z2KWrtskiMUIZJ3LG5Yzx1fRLNEBS7GNZt/j?=
 =?iso-8859-1?Q?Gm9O+FxENqaEGyB87COVq2XLb6VZnjwKx9mmZ4bv29AVhFD9XW1m/kM+pd?=
 =?iso-8859-1?Q?goOyD0QSfAgmcvOKH7aCKHt454rt4UrLoBgLO/5gmUDBarwN1+Zv79tfk3?=
 =?iso-8859-1?Q?eKuQALwrvAKnvYtivNd/bdj1jLdxDBzTXGHQzglGDao7AcvnON/8bVqlO4?=
 =?iso-8859-1?Q?12GuRNK2MsvllGZP8Onb8ZNDdChg8jWg4csH4lROHhM0rPE0Oq0Y9QvmDl?=
 =?iso-8859-1?Q?35k4sE/OnG7qkSakRsIy5eg5VyHTf6ZeYUgW7jzyPUQ9mca8gMgADP5/fi?=
 =?iso-8859-1?Q?QOSnpKdOHUZkh3i1nJUJtXWsxCxnrjPYqu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ca3042-c55d-4635-17ac-08dd9815374a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 03:11:44.5450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMbrCVyZWWpSfE2FCBNFKCmy0D7Ya5CJ9+F4kE7nR0u9EO1BJBTkbROz9OVIOAJwuymamuYiL1hrlJrYtp1ikPHIVd7W7t03uTZEVJ0Pm8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>
>On 5/19/2025 11:51 AM, Steven Sistare wrote:
>> On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>
>>>> Define the change process ioctl
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> backends/iommufd.c=A0=A0=A0=A0=A0=A0 | 20 ++++++++++++++++++++
>>>> backends/trace-events=A0=A0=A0 |=A0 1 +
>>>> include/system/iommufd.h |=A0 2 ++
>>>> 3 files changed, 23 insertions(+)
>>>>
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index 5c1958f..6fed1c1 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -73,6 +73,26 @@ static void iommufd_backend_class_init(ObjectClass
>*oc,
>>>> const void *data)
>>>> =A0=A0=A0=A0 object_class_property_add_str(oc, "fd", NULL, iommufd_bac=
kend_set_fd);
>>>> }
>>>>
>>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>> +{
>>>> +=A0=A0=A0 struct iommu_ioas_change_process args =3D {.size =3D sizeof=
(args)};
>>>> +
>>>> +=A0=A0=A0 return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>> +}
>>>> +
>>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>>>> +{
>>>> +=A0=A0=A0 struct iommu_ioas_change_process args =3D {.size =3D sizeof=
(args)};
>>>> +=A0=A0=A0 bool ret =3D !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &arg=
s);
>>>
>>> This is same ioctl as above check, could it be called more than once fo=
r same
>process?
>>
>> Yes, and it is a no-op if the process has not changed since the last tim=
e DMA
>> was mapped.
>
>More questions?

Looks a bit redundant for me, meanwhile if iommufd_change_process_capable()=
 is called on target qemu, may it do both checking and change?

I would suggest to define only iommufd_change_process() and comment that it=
's no-op if process not changed...

Thanks
Zhenzhong

