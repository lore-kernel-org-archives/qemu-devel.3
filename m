Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC02C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 08:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9KI6-0006iy-Kf; Mon, 28 Apr 2025 04:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u9KI3-0006iW-EA
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:56:39 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u9KHx-0006ii-89
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745830593; x=1777366593;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OVDbwYg9Tdgo2ZKHAhJyAr8owrP5XZNhZ0SCGvI8C+c=;
 b=gX44oOnMlkn0E1D9zkyREnZXmCzwEyP0iQZTdU9+8UCPvHyvyQONTm9R
 qN/eYYbLQPxYxHlE7Zy66Rw7oA21MxExiswfKXbb/G8+oQ14kU/7kSviB
 6THm5cyNxaDZ6+03UVNMLnCLChl8ihw/txjXxFI9Y2AmrLauDoYbuvGNA
 ZzU3b7EFKAXsTpBpD5si/jK+LNyexUPi6auIw/fLZNheboBOD6xM6Yvro
 vQayYKCgrHje403U6jf1h9121Rx815nnVTWmLCPAXcic1X3808jnd9c4W
 jo1EG+NKGUxzoavSh4zAQEL5/TQKNTRDN1iB5pPXZL+VEDRWLpGMug/+x w==;
X-CSE-ConnectionGUID: jrwsuitYTSCxcA01g+7Rrw==
X-CSE-MsgGUID: VigVEIp+SIujT5wQ7nRdMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="57608579"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="57608579"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 01:56:26 -0700
X-CSE-ConnectionGUID: t/cXXFqLSpqjuMdHhVWIFw==
X-CSE-MsgGUID: UPtis2/SQaKbQZwWhsR6QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="133978141"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 01:56:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 01:56:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 01:56:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 01:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNRjHrPwuK+XblEexdsG2iDTLMcYTgETfF61TPEUN0NYivGSAEEbi809uhZh4eBkmzNl1+slmFgldWqCy7CVPhdrRAn7VMRwkXjO31BrRpcnmCvvqZKsGwORCtw9AWZqZihhcAhAT+nd568mQ9s74bKgQvIeCdUhUhWw2RDVHw3t9J5BT0tk8H7ek0RHgNyzs1a1uXk2khKnbyZsjCkFBaeqjRHP+xUjZOxdse5ObQibHTq1tIkvxtZtLF/cv6FVBda2phC7QuZp79Hnw6h7aKka6OaxwVMMqfuif6yiX1EyjsRRH9U2akqLRNZb4ghJvcn4YrYhfoXd1joWHgP/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxUXhKut3c9Bft1wVuG639u9U8lw4TxtJR+1B24yBPo=;
 b=LsvmWihUZaPxt2P26sNP8EmJgq9ZKAZVo55ueAO/c98WXQSfojiErSC8Hk1V+7vHRBi/eXQo5fFdXsfvUK+apDoTnGmMdkzWd4WiR88Ui0UAzf4YytY6urZNSbVL24jbm4w8N/uIDe7yZN45utv4WyOqUPqbzF3ulfE/yxQkR3CcnZheUXa8XGuN+UrH3hDS0IzUIsxRy4aUXqM7eO/Kt5i0M2TIDLzKcs8jFHoQATsXH0yz0aMlfru6rU+VAYL6UtiMER6kvQFVDeNI/5Ghrj6hkAImFKR+EzSJkudMPc2SjH6xC7fDGrwzdxwjtX/ISDUuZcuyX0YJDXC4PEfxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW3PR11MB4667.namprd11.prod.outlook.com (2603:10b6:303:53::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 08:55:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 08:55:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Topic: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Index: AQHbt/xFnz+12v1rTEmQHzTfc+jobLO4xhPA
Date: Mon, 28 Apr 2025 08:55:53 +0000
Message-ID: <SJ0PR11MB67441EF218A7D9B3D9860A1892812@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
 <20250428051235.10767-4-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250428051235.10767-4-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW3PR11MB4667:EE_
x-ms-office365-filtering-correlation-id: 69c5b5cb-6d64-4aa6-050e-08dd86327b3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?b6rPdBo4pIRCVkHhwqrVwqEA89RTfMyPA0JMtGZuXPVklPAWSPexQzYmmyun?=
 =?us-ascii?Q?H/uIKc9zsNWueH8I120VSTLvVNUC13iCqx2f2OeCPK8Z9gggCBflB6tVRuyF?=
 =?us-ascii?Q?BkC/UZCGTs45zL18ihJPAKuiE7xE23RH6uKP09Z9jaJcr0UDgCDuKQdgpsKQ?=
 =?us-ascii?Q?2ltPjVgWXXGi7V1/xu/BUWuBmDdIs3c2EEARCaRzPAKWzWJhyzsUvVWIwm60?=
 =?us-ascii?Q?rmGOYYEZUzT3jJsgh5axE8g1bh9vVwQOGL5Rr6xAnsfwvhLb18W9kEX0Rtm2?=
 =?us-ascii?Q?8h6DtFmz46ZwopxWmKZcaaIdMhzVk/4Dftz/SKSlLAvjLyn2NTgD9XppTWGi?=
 =?us-ascii?Q?jdq1lSoTOxGYP+ockEa3VcLb0c+2+qVf0h56OaLjMvmsw1EN4lOcsmXIWImH?=
 =?us-ascii?Q?gMyAzy+54N6bqUErCWHcmNJIe3T+yPmOBfuqouZm4YFoWtaXNZbGYnw/vNav?=
 =?us-ascii?Q?8Qe9v6ZSkhhAbtfx0+VLJrhDcz6LQ4NjLt08IDD+DrZiG4AV8nrSPZ6Kub2g?=
 =?us-ascii?Q?q1vDeKHCa7h0xvNhgSfLIe1rodOz/ILFqa4q8qyoO9/lSUt+Wjk/jEPylXT0?=
 =?us-ascii?Q?5Va6zGnR76nbTsl3Vz7me/bwdRpE9dnuk83LrBeHubtR1tN0ym5LbxT70Hmk?=
 =?us-ascii?Q?OwWmzq+hLWd1lS7V0VMYnT9WdqxmF4mUPLdMaEO/359LhMSnN8ojWMYpw9qN?=
 =?us-ascii?Q?r6qkk4XHxPfNAGGqK4XcRveY5kpy8+0Eeiq15NkHmsgGemoRmxsc/VkumKun?=
 =?us-ascii?Q?Pbn3UqsLGVRkGluxF2Szz2yZJowwT1VgMrzzzdUsVraBriGEYjyHzkEriK+3?=
 =?us-ascii?Q?BsxI02ezylIPqSxfWzpR+BEYa01fgDPKiIaSQ42d1KSmdCbHvbb5iL/sRVe0?=
 =?us-ascii?Q?d3sUEKHYkXKcWP3AtCA8s5zCWiIioVzjzpnjOWWd2vorl7b92EuQFH53BuL4?=
 =?us-ascii?Q?5IpsUuh+iy6mc+DNB+oCqcVkJ6iH7SaRKz6LOHZ7+/6ejPHnkYlZ0cwicB1H?=
 =?us-ascii?Q?KUshK0743sw0YPuKDfDYiXymNdSGfBeah4DmTFs1BB243345vXEPx5fgwtQI?=
 =?us-ascii?Q?qMeidqjdUHZMWxLSsATHAQMaBRfSmcPPPVRxq0GQ9duHJ1BEFFfewApksSM2?=
 =?us-ascii?Q?+Z5KOzsumj0RIrZdTN++oPh8/l2QEXGBZiHcLZpgKu3iBQch0HS0vxqp2M7O?=
 =?us-ascii?Q?1CWzcPg/x3q4WIg1IEit3Rykwl0yd2lMJVDM4EMZUkE1O5jCGegvA/sLTTj7?=
 =?us-ascii?Q?rRL9JqsGakpTOSiwg86pvSAjuiDMOH0kv6hTbj1tiUbN11r5jS0GLTJ8p/Ag?=
 =?us-ascii?Q?a/H/90qQgQvfUuNUFeeEGB21CP9q4PWnYRKuVHMh6BHHmkx0m8tTwqTcyyRf?=
 =?us-ascii?Q?KqFiNkmBv5WrFyqA4ooRLVTYoZFD6/6cDACPQQmQt/49RDtFJfgfNoI4Ffql?=
 =?us-ascii?Q?cRQaDvihOtHGCzAcYXXGhLQpN4eAe2Abd1MkLmRZeP3tMxIS/jUtswPWseSO?=
 =?us-ascii?Q?ngWKLDJgUHClpa8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZSGz30Gc3Jdf69H793zD2WoTXVnkRNN62+Copw3q6vYQUmRcLW6GLOnL3XRk?=
 =?us-ascii?Q?jCwH9K6NLCtWyyKQHX6y8hKhb7kkYsLqXHefIvEvafwtTY5mScqEMDwoWsK/?=
 =?us-ascii?Q?30dpvwf1Uag9Dg59xooe0seGq2cvVxAMY8u3EYRlyLPuvARQiM1LxYxJ/kOh?=
 =?us-ascii?Q?Mci4McsyIjNsk3UBLUoXc38ftADEtRWglR5VhQU7cbgCcX2CfwXq0lB9mg+U?=
 =?us-ascii?Q?mogavXqRvjI5YU0UCeAqTfw3rq//8a8t31ITv2/9fqswFJYoq61AIKwvxqOa?=
 =?us-ascii?Q?BZnksyfT35I3SPUzhTmybTiDFXkks4qwUobupis97Naui+0mSRw+roDU9S4X?=
 =?us-ascii?Q?m1P3zTtJgcDr4OHwLhFCjk5zp7H5S+dNhRNTUJgSOlNkKaW/3Y6A7SmqL6yT?=
 =?us-ascii?Q?jyjpiu5IKEaMRiMkbsYcWSRg4jURI8YAVohz2/gNC3XIT0PwRnFCye5fDyFN?=
 =?us-ascii?Q?ORwg0R6TB4cIcMq9zzy5R+vYbieYP5pCW93LB5bB57xNoYSTca56Osmzidab?=
 =?us-ascii?Q?5TC7JyMugJ1raLZmwpPPcu83kpCoimOy4mV+IkGqnnxvMnGlrVjI1QueOWe2?=
 =?us-ascii?Q?8+PXJjrH6EjBtVJSDpi+Z91H0Z6LHQ7d8fmZoreLHH30XmaWZId9X9OE339j?=
 =?us-ascii?Q?ozjbSHZFMDqXrKcXQJqRonWyxubs3OUZ9uU8hyjJjRas1lI/9VBbwknPI5XT?=
 =?us-ascii?Q?eHVUjvzIduA0ZxZtVoRYHZB8+lbLXA2JzO7dsfWtPa4K50pRko57k7fugQHq?=
 =?us-ascii?Q?t7Np7LRP4I9Z4A57lKmGK7MRyGcQ/MAfrvWziDjVJNyK6Qz9I8fCrMIOR0Qw?=
 =?us-ascii?Q?B5diZRJHup7P96dQPg9qyRb6x/q2COXhhK3ygAr1h/erMEGup2/z8S+mN2VB?=
 =?us-ascii?Q?99HX50/Td50MvoIEaIuqOwPDUP+awMr6YU7VgMfEMTbnWI9aG20GR8vVSUsq?=
 =?us-ascii?Q?zvUslUoLIicYnbsJ8mct48EB2tTeMM/aJrmQctNwNqg1djf2yweV6wTuGxCt?=
 =?us-ascii?Q?Oyx/EarBvNJqUtPxc0/cCG0mvUj21xbZQg9U4o5TrhjcPPtdfCmTa8s102qv?=
 =?us-ascii?Q?OvC09jrYruG6GDNakrwEy47rJuf2z+c3nMTOc9P57nNTYkhykuato5U5Z1AP?=
 =?us-ascii?Q?4ES/07MPIiyvLw6lWVtw7gY6uvkm8F+L24JjHOfi+4XpyjsDEhSRYdiIc0qJ?=
 =?us-ascii?Q?YIRKbSK/ygkAkTpmBoH/YOLIfruX5GxB6W2LNLb5nFtZKzePxVADWaCBoQkZ?=
 =?us-ascii?Q?On3pzlpJZQtKPTjerjOCMKuziOTpz9vboubsttBR02j3WoNeFXDky3eP6orn?=
 =?us-ascii?Q?886icsyILcxlb1BQfeowyOL/TmVHPwSBKBgvHZ/SeyNP+ZFmuUcKFgE2TYzT?=
 =?us-ascii?Q?nWmaeNFPTW9FR9ixIOhMG9anbkHErly5GTd5rhSgN0umVznwxwLvjmsTt+ya?=
 =?us-ascii?Q?b+iXFNd5VNmSdu7q/6ie3FDOmJHryTiL+cyFkL5YM0cNJitPeA4YGgHPrZ77?=
 =?us-ascii?Q?BFp1z/E/S7z0blQGdRA/3IjecMe5KB5HUXQk37eHcQXvONQSmLgnysmsmHuZ?=
 =?us-ascii?Q?8D9Lb/diUelm9g4zhoJH1NdEhN7KPhhosc488JTP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c5b5cb-6d64-4aa6-050e-08dd86327b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 08:55:53.0514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KSpy4JLD2ZwhPJjcr9Vwy6/ENOlqJhjkDUxo6DXAsT+r/RUP54/bxmzF6okjv+OZlOzdl4OcOFBpaNmofrPElPLGHTNM5OfFLLVgTGjzIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4667
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
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

Hi Clement,

>-----Original Message-----
>From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
>Subject: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for an=
d
>creating address spaces
>
>vtd_find_add_as can be called by multiple threads which leads to a race
>condition on address space creation. The IOMMU lock must be taken to
>avoid such a race.
>
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>---
> hw/i386/intel_iommu.c | 28 ++++++++++++++++++++++++++--
> 1 file changed, 26 insertions(+), 2 deletions(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index b7855f4b87..931ac01ef0 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -4203,11 +4203,15 @@ VTDAddressSpace
>*vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>         .pasid =3D pasid,
>     };
>     VTDAddressSpace *vtd_dev_as;
>+    struct vtd_as_key *new_key =3D NULL;
>     char name[128];
>
>+    vtd_iommu_lock(s);
>     vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key);
>+    vtd_iommu_unlock(s);
>+
>     if (!vtd_dev_as) {
>-        struct vtd_as_key *new_key =3D g_malloc(sizeof(*new_key));
>+        new_key =3D g_malloc(sizeof(*new_key));
>
>         new_key->bus =3D bus;
>         new_key->devfn =3D devfn;
>@@ -4302,9 +4306,29 @@ VTDAddressSpace
>*vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>                                             &vtd_dev_as->nodmar, 0);
>
>         vtd_switch_address_space(vtd_dev_as);
>+    }
>
>-        g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
>+    if (new_key !=3D NULL) {
>+        VTDAddressSpace *second_vtd_dev_as;
>+
>+        /*
>+         * Take the lock again and recheck as the AS might have
>+         * been created in the meantime.
>+         */
>+        vtd_iommu_lock(s);
>+
>+        second_vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, =
&key);
>+        if (!second_vtd_dev_as) {
>+            g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_a=
s);
>+        } else {
>+            vtd_dev_as =3D second_vtd_dev_as;
>+            g_free(vtd_dev_as);
>+            g_free(new_key);

We need to release memory regions under this vtd_dev_as to avoid leak.

Thanks
Zhenzhong

