Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D869C54754
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 03:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGr8B-0007DX-FJ; Sun, 18 May 2025 23:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uGr89-0007D5-Ey
 for qemu-devel@nongnu.org; Sun, 18 May 2025 23:25:33 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uGr87-0007XE-5z
 for qemu-devel@nongnu.org; Sun, 18 May 2025 23:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747625132; x=1779161132;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c/l8X1bnqp1oM1TWF2VKs91e70GCSY5uFdVk+P9cmGo=;
 b=OxJk765Hea1imb8KM1IvaEkxzfpUkYyzRWQkfJtp768JzAoq4w0S9cWw
 sWL7O1Md5RHZReula5MiHg9v5NTGgRJ//z88n2QRfx+P2AaJYGPlacx5k
 XIMUl497pwJs43ZYtroboQSnGGIt8Nn4QXULwi+cmne2vJYGOxCM0l4U1
 T1X6GraeDbLtsCZ2NkeKDV7F26VSeQnKM8IVqn69zOAPoTiv5HisSHtCk
 SIsSRRysz5e/jNDvYHfFB5hgElBFk7+lF0jKB7FW4qtpysFGi/ZdhAMvI
 PjuPfYqAcxpJ9HhiwsABxR2+3OLakdu/Ph2QznY/KxSQ8ECCq8lQY2AZT w==;
X-CSE-ConnectionGUID: rXqzJcyHQ/aVUGACmnMCvg==
X-CSE-MsgGUID: sz/RdNQxRBOCMeQOQD7afA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49412035"
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; d="scan'208";a="49412035"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2025 20:25:26 -0700
X-CSE-ConnectionGUID: 5KR/Bwv3TeiCJkCRUW7HlA==
X-CSE-MsgGUID: bOLfesllSxarenbFXrBPLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; d="scan'208";a="144218968"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2025 20:25:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 May 2025 20:25:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 18 May 2025 20:25:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 18 May 2025 20:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQfaIEWMxtNi64SndKg8q22VXAH3VD2imGUoeX4qrbk7Wshmyq62rfCpj5XZWlcgPBpQNLMQVbH4EEjbjGVhfYXMoxoo0F+Tls3QUpQ7ki8j5zablncxLa+5mhhpJ601zEM2Vbzx0gh4jjIV1gcwJuplc68r/bW4qybLKWvKQhGrytwMiIISywZYe47n9OHWW3sn8GpJAQtNv8uDs/LQ8oRp1l25t4oPOyEL1BK55RgB2eQbfWWSE9aVLkRMCl60nKmTF0H5mYd46qCoCejNQyUWT/ZW+g2J/BwCZbHaCaGRpmx+2ih+PPOp6t7Tky0Bwq8i7KyRmgTpLWtYf6X4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJSu071VgCp6hcaOdk+kLnCPvaretQNDDviikXLYD+M=;
 b=BGiKByT1cctgj0uADgPM8Rmj+dfqNhFAvzRtSER+I9MUXrSPeWytRG4Kv7FoUsP5vsXcvSpTelGtbavntveciroXdpM2+ATyQlwfb9+YiBBN8Xv7bQPK8qdTvoaFBpY/827ogpwexrxoiEyWqAkmTjwAE6Lktc+dIKkZBys3MveOJ0/hKJgmE+9GLjuLlcb1ZEmj96qv9HI4PD3qBoi2qUifz32gTqLvu2AQVHTXY8C1+lubKgDfp/Z6nc82J2tkMfNmaeGbPjyXJEWV5Ru0BB2EfdCKZbFw/GtSLNhII0nb87CxurnjMFFdEKWxompqqIKCVkyclFj3cmSUjrxU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 03:25:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 03:25:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
Thread-Topic: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
Thread-Index: AQHbw1Ng1KGgC3Lc40iButBHzdW5oLPZU1HQ
Date: Mon, 19 May 2025 03:25:08 +0000
Message-ID: <SJ0PR11MB6744EFD14811E4BAC0C05BE6929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-40-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-40-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB4809:EE_
x-ms-office365-filtering-correlation-id: 0bbe0b28-c7c8-4c32-c968-08dd9684c1f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3UPTbrpaQ3YNuhxtsBZjKm2e5UH6jVLrdXkPZoickyAAnpCi2Lwa7eao3h4G?=
 =?us-ascii?Q?+WEfd78i21RE8gDW0DCSlEJhddfOdNV5CKdljxbOj3c533D1PWu8bcgrwfFo?=
 =?us-ascii?Q?cL3VpiC2bB5xfffRumxPMGR5sbD+Ni3oq9k2M2resAVMHUPXc23s9rLlZCh0?=
 =?us-ascii?Q?qIoxNnEZk8Ynw5CX6HKwsZkZ2RHoKTcvemdkedoWeCQ9p3XmO2Ov5jHVQlj2?=
 =?us-ascii?Q?ynzJZnkwzaARdmDMKs4e2Quwl8wB7edl5+qnxkUriNgB6HAHguwDKJzchxVL?=
 =?us-ascii?Q?2L+vtZJ1pj8lt9SNWXjyBfq5JClGPAIp0trjY/T9u6A6qpXFST6H62OjpShD?=
 =?us-ascii?Q?DzwwX/FDxEJpgOD66vGHQXm3T7XxObJm7II+8oFdgiXw7StZnieNzgHPNviG?=
 =?us-ascii?Q?WGs7Em5LSFumN9B/BJSp7BLcA8QR5AIb3Ll6ozpb0xwMKlZ4MXlrXDfobh1A?=
 =?us-ascii?Q?AGDhEI8O2q7SGyzf9nDtM4MWvHaeICqhvBfExabp2sY3EWvVsA8y4dqME8n7?=
 =?us-ascii?Q?0Mky6miSuhoPKT/FiMxdtdRknuijPkH3vJqp46h0U42x7JwBkjaTb7W/8xYU?=
 =?us-ascii?Q?hI41Jk1ONTwPiTcyz3tAb8MvmAssU6nxWrWrBpXK519p4gYxD81iaLF8CrST?=
 =?us-ascii?Q?GbPYtXEulgHpfAbj6s5SIGq65jkReJxNFRW8ZmT64aBa3/O6C9xhg6+LECI5?=
 =?us-ascii?Q?ouxEqiddoJRJ+qyzdtzSkGQULMSYtiMpiDrB8ncxlG3DUcXYtk8413uhWbzw?=
 =?us-ascii?Q?/kX16xdRq3BDmovowtjjpVkFEOr8JijIKIHQ3sjE29M1qOa5XwNFlFq32jqy?=
 =?us-ascii?Q?LuCdz/T2qnkH64O6yVuS5ChteaK6jyVd/XQ6CQmwqt9IP1r0/CRvwRHchey8?=
 =?us-ascii?Q?InpIH1aBesuRFWB3ZtcrcsP7LRe0WfqYCI65RSFJF4q2s0mh2jjJ1gpvGr7X?=
 =?us-ascii?Q?1l4sqaclypRkFzrwZbeGQ9m60dDx414kgYD9zLekH67nwuaGsJZJKrfQGNCP?=
 =?us-ascii?Q?yaDGE/gadim0eS+nJLv5gkwQB+/HaN9VjGSGBtJojPvtpE79Cdime2AHEjZC?=
 =?us-ascii?Q?3q20C4FV4QCnv/QCh7MXobRd7QPOoLbXhX8TdQUYnCLzgLBh7bfGAmqmMDmb?=
 =?us-ascii?Q?EC+kjRnYIwi6kiJg22oiQWbw7Y0J7xV0MI+Rre5/OdNNg55/HRctVWgM0uN6?=
 =?us-ascii?Q?KJ2Yx2X18OboWNOL95NS6eVXBb6DjB5thJy/K0wwKOsgoYfLtw7k8+T5FMvf?=
 =?us-ascii?Q?Inv0iN9PAuKr2amC2OX+StlLCazjaltcyZVFQRMk70PmbSMnmtzSJsSEIcT9?=
 =?us-ascii?Q?lPm1cLmvtGposggOSPdM9PsQZCd2W5YTTwdyLYrF0O1bAnpjBJpQsNtoRuaP?=
 =?us-ascii?Q?yN2YmWAthwvpLx4mLlvPKYwalzVSDSORgOlB3qYca2ivz1It7TEDzkX/sFAg?=
 =?us-ascii?Q?aAuNOj4G7RW1YqT1imfvbt1dg99+8CHJF9+mqjKGY1mNGa8b0fWMRDUd6rtE?=
 =?us-ascii?Q?cM2GLIYdjNd1ntw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sVM/XwigL4S81pHTUIh34rjlInsMgOWINZs1nUsJk+svr2VAVw3p3+GNE39g?=
 =?us-ascii?Q?Z3dDmfAH56RzjqFc3HM+29FjrIN9KvzR2Jk5v0TnYF1NhtZj2e7pHM3QQe7o?=
 =?us-ascii?Q?XvQxmTr5OMjltEEFbRoMmwSlvZ9mXF7+e+X8vIYS9L4rMRu84fisSoyKESvr?=
 =?us-ascii?Q?kJqynbmY2Ac4ftLBvi0i+6on01AR3dX9o4F4LInetzpPO+OgZFIv8Kow6j/u?=
 =?us-ascii?Q?U8xG/kUg8ptg029d0MOBFOI7+LdRZl8UaB98mC3Qnovn80UEHlFRkHS4ZX46?=
 =?us-ascii?Q?Uh7clcOXOfDHw6sawtkg3sVGvpQd8/o7xCJ1zMUHJb/7Mq+hJdl+Q0tQm5jX?=
 =?us-ascii?Q?MzH/fVvSG6jUcZJ5lXzT/FwyNSD6hkGiIDdJ07sABmQST1lRNSmyiAbUmTvF?=
 =?us-ascii?Q?z6CX+4ByW3iTdNFq7voLTkU0y9CVh99n/HEGp2xOZ+axwDBH5y6TLcQXJMs4?=
 =?us-ascii?Q?s3/3RfaOib9QjLEdHu7rEjCm4rVxIJ4ZVcA+7jXVeUvPzII4t34k+n8pDqIV?=
 =?us-ascii?Q?VaxhIDpaCpheq7D6qOj40BDfSWDDo39XgwzgLgOsKjqWjS+oxm0gxO7Fxlqv?=
 =?us-ascii?Q?ryXWsp9mNgiZl2SUXHCdcbxgu+XZhlsUdv8r5pIGOujh4SFk4P3AMAzgFPFr?=
 =?us-ascii?Q?goHrTt/E6d/2SEtPE+v2nNiHagZl/HR4Z9wKuzIOHAbI/SHRuzCJ1ER2JfzI?=
 =?us-ascii?Q?/+SpR+u4sIUCtn+RNVbCCFjbjwUZdv3Qf6ADvtB6e5bfyc9YdGGn/JVzbSCg?=
 =?us-ascii?Q?WoxXvqkmRwZyISX1+TVQtelLYUWiLb/TF/iEyny4NDP4VB54iMLL1F+yBAD0?=
 =?us-ascii?Q?JAVQiHsh3UGvQhzck98xaAjg1RGDlryQkUOHrFj9jQyF5754nKxy0y2cWCEK?=
 =?us-ascii?Q?TIgStVG+lxl5PGlcJmdm8RWG6aOWKJ1bGPLui3d82Ilt8DDSWRzmDGOCD+Ev?=
 =?us-ascii?Q?5PQCPIZBxpLeGkrMlHW1nMdaNbNSgFdBl6uXbnn4+2YisEgQrJL2EyAcT0nJ?=
 =?us-ascii?Q?WjhRVE9rfOWX1pstVjiEcsgTDpbSKQGIq7qafh1Ap9XMooA7IHnjElg5O+th?=
 =?us-ascii?Q?XztlPssf7Vi5Uu4I+jf31u9bebIiBy0/nm72joWF8xAkSAfCaEEkLbqT+79W?=
 =?us-ascii?Q?vX4ZTov/OVtjIEpiwxRD7dUON3ICByI+kSNecEvlLJDFq9bg7rA/M4eeI+62?=
 =?us-ascii?Q?OMV2MXH19ym/wHyKQta62wZiKjBXjsuq4YqhbkHwwHj5rTYq8PnpL3LE0OnF?=
 =?us-ascii?Q?strDTHA0qznX4bsxAtOjmE9ysygvnH6lrgPRLpPqbgixES/9b+XS4egPGRig?=
 =?us-ascii?Q?PdEnACisaAQrbD7SHkLMjlEUfumes7iiPrE79UcrV2J3poVOBKjC40nLncZ+?=
 =?us-ascii?Q?VvDDOP0voUjndzysZE1JwxjVsAmB9I56GMfmJ/GHcDYQEnEvyDAJKvhmy1bx?=
 =?us-ascii?Q?N69WhNCcwCDyc/Klw0cCQZ2HhIC60FFR1TpuUDxG5bkQz8ai6OBup7G2RypN?=
 =?us-ascii?Q?pQwPIAxHAcQbablA2VBb7j+jmQCtJrACC+SgjC3JXMGFhZBhrIKFYfAe6m1Q?=
 =?us-ascii?Q?mGhXDTNqsuHVn6I67vstlm7S9ucflbipBto7JFA3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbe0b28-c7c8-4c32-c968-08dd9684c1f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 03:25:09.0048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlNuJAcePAqznYU3EGnp9GRYDnzr0sjSB6KpSwuEmz01nsHRLgQMWEoqn5SjW6F3nI0Na/8ynYtqNsghKnzOGZFQGeJ67Qg1Voj3q8w8pg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
>
>Save the hwpt_id in vmstate.  In realize, skip its allocation from
>iommufd_cdev_attach -> iommufd_cdev_attach_container ->
>iommufd_cdev_autodomains_get.
>
>Rebuild userland structures to hold hwpt_id by calling
>iommufd_cdev_rebuild_hwpt at post load time.  This depends on hw_caps, whi=
ch
>was restored by the post_load call to vfio_device_hiod_create_and_realize.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/cpr-iommufd.c      |  7 +++++++
> hw/vfio/iommufd.c          | 24 ++++++++++++++++++++++--
> hw/vfio/trace-events       |  1 +
> hw/vfio/vfio-iommufd.h     |  3 +++
> include/hw/vfio/vfio-cpr.h |  1 +
> 5 files changed, 34 insertions(+), 2 deletions(-)
>
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>index 24cdf10..6d3f4e0 100644
>--- a/hw/vfio/cpr-iommufd.c
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -110,6 +110,12 @@ static int vfio_device_post_load(void *opaque, int
>version_id)
>         error_report_err(err);
>         return false;
>     }
>+    if (!vbasedev->mdev) {
>+        VFIOIOMMUFDContainer *container =3D container_of(vbasedev->bconta=
iner,
>+                                                       VFIOIOMMUFDContain=
er,
>+                                                       bcontainer);
>+        iommufd_cdev_rebuild_hwpt(vbasedev, container);
>+    }
>     return true;
> }
>
>@@ -121,6 +127,7 @@ static const VMStateDescription vfio_device_vmstate =
=3D {
>     .needed =3D cpr_needed_for_reuse,
>     .fields =3D (VMStateField[]) {
>         VMSTATE_INT32(devid, VFIODevice),
>+        VMSTATE_UINT32(cpr.hwpt_id, VFIODevice),
>         VMSTATE_END_OF_LIST()
>     }
> };
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index d980684..ec79c83 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -318,6 +318,7 @@ static bool
>iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
> static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt
>*hwpt)
> {
>     vbasedev->hwpt =3D hwpt;
>+    vbasedev->cpr.hwpt_id =3D hwpt->hwpt_id;
>     vbasedev->iommu_dirty_tracking =3D iommufd_hwpt_dirty_tracking(hwpt);
>     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> }
>@@ -373,6 +374,23 @@ static bool iommufd_cdev_make_hwpt(VFIODevice
>*vbasedev,
>     return true;
> }
>
>+void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
>+                               VFIOIOMMUFDContainer *container)
>+{
>+    VFIOIOASHwpt *hwpt;
>+    int hwpt_id =3D vbasedev->cpr.hwpt_id;
>+
>+    trace_iommufd_cdev_rebuild_hwpt(container->be->fd, hwpt_id);
>+
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        if (hwpt->hwpt_id =3D=3D hwpt_id) {
>+            iommufd_cdev_use_hwpt(vbasedev, hwpt);
>+            return;
>+        }
>+    }
>+    iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id, false, NULL);
>+}
>+
> static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>                                          VFIOIOMMUFDContainer *container,
>                                          Error **errp)
>@@ -567,7 +585,8 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>             vbasedev->iommufd !=3D container->be) {
>             continue;
>         }
>-        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
>+        if (!vbasedev->cpr.reused &&
>+            !iommufd_cdev_attach_container(vbasedev, container, &err)) {
>             const char *msg =3D error_get_pretty(err);
>
>             trace_iommufd_cdev_fail_attach_existing_container(msg);
>@@ -605,7 +624,8 @@ skip_ioas_alloc:
>     bcontainer =3D &container->bcontainer;
>     vfio_address_space_insert(space, bcontainer);
>
>-    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>+    if (!vbasedev->cpr.reused &&
>+        !iommufd_cdev_attach_container(vbasedev, container, errp)) {

All container attaching is bypassed in new qemu. I have a concern that new =
qemu doesn't generate same containers as old qemu if there are more than on=
e container in old qemu.
Then there can be devices attached to wrong container or attaching fail in =
post load.

>         goto err_attach_container;
>     }
>
>diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>index e90ec9b..4955264 100644
>--- a/hw/vfio/trace-events
>+++ b/hw/vfio/trace-events
>@@ -190,6 +190,7 @@ iommufd_cdev_connect_and_bind(int iommufd, const
>char *name, int devfd, int devi
> iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=3D%d)"
> iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, i=
nt
>id) " [iommufd=3D%d] Successfully attached device %s (%d) to id=3D%d"
> iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) "
>[iommufd=3D%d] Successfully detached %s"
>+iommufd_cdev_rebuild_hwpt(int iommufd, int hwpt_id) " [iommufd=3D%d]
>hwpt %d"
> iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
> iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=3D%d] new
>IOMMUFD container with ioasid=3D%d"
> iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int
>num_regions, int flags) " %s (%d) num_irqs=3D%d num_regions=3D%d flags=3D%=
d"
>diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>index 148ce89..78af0d8 100644
>--- a/hw/vfio/vfio-iommufd.h
>+++ b/hw/vfio/vfio-iommufd.h
>@@ -38,4 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>VFIO_IOMMU_IOMMUFD);
> bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>                                       uint32_t ioas_id, Error **errp);
>
>+void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
>+                               VFIOIOMMUFDContainer *container);
>+
> #endif /* HW_VFIO_VFIO_IOMMUFD_H */
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index 1379b20..b98c247 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -24,6 +24,7 @@ typedef struct VFIODeviceCPR {
>     bool reused;
>     Error *mdev_blocker;
>     Error *id_blocker;
>+    uint32_t hwpt_id;
> } VFIODeviceCPR;
>
> struct VFIOContainer;
>--
>1.8.3.1


