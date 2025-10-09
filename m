Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E9CCCD188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ncC-0005gx-6U; Thu, 09 Oct 2025 06:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6nc3-0005cu-Jl
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:08 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6nbw-00078Z-QB
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760004661; x=1791540661;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1otTvxkZyk/OEbeu8/wp2BaACcG9dHW8ZBFUii7RI2M=;
 b=b+oTsIDdkdlFfursqFmoq0reM1iAeO1E9mmENBdYGMtHHvNQl29CDjJd
 pkxYnVXRYrdUtYo1w3VLsODyc3aR/ar9eDfMkmwE81Q4iNfjhdSvfdUmR
 m+/247DzDtZ5GeUTl/xy7DLFUkVaGvO9CMw3DlMu3kkjUNQu8/MLZFABW
 EE34faXAgXCLWYWS5YUuC4GLyuIEus2RoMFgPgcQjVCattwVqdLKmy9Rz
 ngmxdD+lz1frbmdO1gCYAClJilIy33J++xg2YOM1CzGw/1zQKtPHtPR3G
 FDZbzHrBGppCR0vR5zNR1+kufklIhslJDGyqyvb+V1pzVU9605GDd+TLo g==;
X-CSE-ConnectionGUID: izBt5ebmTe28XBNbbv+Wpw==
X-CSE-MsgGUID: tOXs+cFcRgmHjMNeSU6Ecw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73638071"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="73638071"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:11:00 -0700
X-CSE-ConnectionGUID: zh3m9yuCQLOVDolzdeQYhg==
X-CSE-MsgGUID: 9sarjrPNSdeom69EJ9TefA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="184944036"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:10:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 03:10:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 03:10:59 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 03:10:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYj1UIPMnoS3QrRwdopSX8DB33ldqeK5vXSaiXmoRgmh3+ul1g8zWVHx5mol0TdgQUsVdEx6dlcc5P6pZUyjhEkiEmfDgUYqOqoPL68FLoZoSdmDYbXUzhb90w/OFWVRcY+usN7ipQD6oIheGD9cEJtJV+EwVXz8YlSPaBuQV+mhbGLgtAhYBOU6ThKM8gmD4oq9f7RYdkMftKHIPwMLNTUv620OUr7AfZMRGcKKrCUO6Is2P+vruC+1A9eHnQ7POAJJMZmKOEujxejuumDO+0jGpduXvDmHMbkSKuDCaTS7dn7gSs70CSApQWy7nNL62uY0qqIiqfF+ckZag7mxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNmFeNEl559kU8M0FjJg5yWG8JkgoAH3569b+d3w7HM=;
 b=SCtdgsS88YBm72hyDC4ukxk+aheF7xNZlVOxLeRaZunWmgy6O0UnC+/pnDnD2kddcUK6RK7xJsf2UMVwnKVO7F07k4OcdNqKXdOJUdMa/9B5mUo6hGoilXfOxOKNw8LWClRGR5adUtQ0Tft8OcxuHm770RRduDkqSGioZlIikw/MxOPS78PCOa8pD5wzsCsP4yaIt+mF3iALYCvNqy9jpuxoE7ls0otzXVXeN/7l7ikGpwcgDHZYX94GJF05PG8WtjZdurEjA7TNhxpc7Szftd6r04rdVmTLJD1/9B9Akd+gt/RDNC1+B3Jb8oj5RJbbIWpzgCwkjEofyLRXUzp9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:10:54 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Thu, 9 Oct 2025
 10:10:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 09/22] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
Thread-Topic: [PATCH v6 09/22] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
Thread-Index: AQHcKHqDmgomY56oOka/QgeuZZ/FSbSr5i0AgAJkbdA=
Date: Thu, 9 Oct 2025 10:10:53 +0000
Message-ID: <IA3PR11MB9136347B4DB9E05F0E7F1CE792EEA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-10-zhenzhong.duan@intel.com>
 <0cfac891-cc6c-478a-9e6d-fc5dc44f0239@redhat.com>
In-Reply-To: <0cfac891-cc6c-478a-9e6d-fc5dc44f0239@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB8071:EE_
x-ms-office365-filtering-correlation-id: 023661d5-d6d5-4efc-701a-08de071c21b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7aphi583WVJKQNk/rgbqpVVI4Eg5HmxilWD5JPhPGY5nGa1fklcb7QsBpDz9?=
 =?us-ascii?Q?/3W6gG8Nj8ULlAfD2Bpm0KnBzwLn14+WJP6parIx2LPT48gpnw3Co0+/X+m1?=
 =?us-ascii?Q?YNqK0ll+uYmDJree/m9M3QJX5w5lABcIgST6DqPwBU5HaSMmfT51eQCBMdr0?=
 =?us-ascii?Q?sKZnO3aT7hWKSHH7JpgZvU/LwM+jxw6ozY3NxzC7wu7Mu8j+EQkilrfptA2b?=
 =?us-ascii?Q?voF+Cya37XX6bhVelF5i6f+yCq8GonmGZnVJvQhioivO9g36fiktDGAfxiCN?=
 =?us-ascii?Q?XRYwRWkjW5SYmdyoOpy9F4Lu7EZQqu/S68x/M/zoW312UV2UheAX1SsGwxCD?=
 =?us-ascii?Q?YElsbrPLvqNZP9Z3AfNYP9nw/IxozloYUbXu2236wXcPr6Kq4KYXLF/4nzaM?=
 =?us-ascii?Q?m4MLXTYTriKEt+IEGfjqHgTK/FjlYHgBc+iES8YfmAkP2LSXu+g1BFzaxxSs?=
 =?us-ascii?Q?g/YebvlNfA0cLVMh2GhnmYzsQq0/tSwakTLLnxmyx9bcG/IX2vArQ5rFFKak?=
 =?us-ascii?Q?PKFKKyMMJFJvL19rc4TGf4SdwVPZN1eXLBfXVaIqWwMUF6W5kQHsCy6LPuyh?=
 =?us-ascii?Q?JsXJQt/OpbbmvpztZqrqDhcxVkBco7cwxUgo9zu6/YSkZxIToMYNUXSQuica?=
 =?us-ascii?Q?OGa9kHDHvGxhmn8GroKtDGVxWPHUjQpx5GF37K9acJBal3+WG1ev1sTQkZXl?=
 =?us-ascii?Q?bHG7i4RRC/alAmVRZgIomeBEkFmKV8ddcgl3JfM0hoX70teXy46GIfN3vN12?=
 =?us-ascii?Q?iW0R+Ue5EbHuPxEUhlp8gEqpb8JQoPD+Xot5Geu6ArQ3pdMbzNXz6g+pK/k1?=
 =?us-ascii?Q?jOIlBh4S7FF3dV6S9+6GAvlGc/K9UtGjpxO9kBopGeyYbzrl5mhKpLQTum0x?=
 =?us-ascii?Q?DVH+JE+4ucEzLZiCQ6B7qOtPlA/gmfWgDVaRgx4KtmddqUQ/GDr7z7uB3sog?=
 =?us-ascii?Q?qW+tOPAXdJLJB3YYte4L80TCtL+hLQKnnHgNY1FtLG1lc0TA+yvXDr7KDZTn?=
 =?us-ascii?Q?j9qaizMczCsVzSP0jLVijpULgEmOerhFjUzpA2BZuelJQDMXu+hQ6UWzHa7k?=
 =?us-ascii?Q?Jw53ze9DoVnBkaT3vSCU3TmN595phaD4vCD9kmJy60bM3qfF8YNxWD4lp2X5?=
 =?us-ascii?Q?w26jQ/jpZ4gNHSfrMbS616/gJ+bJTfc+5Slb72HU4gmy+k2Nx73VZxMsO78L?=
 =?us-ascii?Q?UgqgmmOfuqPOBqbXZP8oV35x7biqo74sgju8nbnR945ka2jwDeTaaZ5y/OQ9?=
 =?us-ascii?Q?gIPPQHSaajVDzmv4jCvFDtZOwJCoXv+vmNe3jlTxu0oA8EmiRywq3zet9cB1?=
 =?us-ascii?Q?wKQ5UxUY1ZOQmpOuj5hHAEcw1g80F5jzjtx1ZTobmwIrTgJi3pFykwY8N6XK?=
 =?us-ascii?Q?Me7ctylt71jKzXUgJ8RixGmQKPz2eh4ETqg6VuB4+dL+X2Pa6iDQuVp4ULMU?=
 =?us-ascii?Q?soK/4esnwi15HjsKBz8sg7Eq5rPwN8NZAqAzSAzvDQ2lSLIgKFH//mr6dJPo?=
 =?us-ascii?Q?Vva5o0hVKshfcAmniqTKzM3sCyecsrvN9QL+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QpTMcjjWnCybyNYkWOKhaYfS5T1nbFjNWLfi1Q+OHB9MpTdqpncvr74Jklgw?=
 =?us-ascii?Q?VdNe+sKjOmYSdHHhaLolPPWekTHaBNerq8CN5X8AFuH/VP6hAHK0WHbXaAHI?=
 =?us-ascii?Q?p4r7EZzUM5FVN39l2i0setEtTlapJLHayO+68ZcBIb8Wb0UHbgp66nckjSp+?=
 =?us-ascii?Q?DNZNdyp+UjXE2cDigAm2hfZKLaoUsbZ8uGY5zluUhPBNZe++cMac5rALJLZI?=
 =?us-ascii?Q?9dnAC/2mrPYxtzwgKJ8dO0vZT5aFzwFdULGgc4fS68+E5UGIsxfL46x/edwC?=
 =?us-ascii?Q?iFdT028fn5dOYNU4xeLI0g6gTbJ7N1xCotVy6gFqx4tyIjG4qmSDWsTeNCV7?=
 =?us-ascii?Q?YsP5ajUtvJ8n8ZJrqmDpXu4negNIfcUPvAkaM+XV/kypX1/U/52zWznC2pVg?=
 =?us-ascii?Q?mGrHVo7t40L4IUdbRDQm6zzyAdgRaz3xu8SGLDjmRLAUjvhxj5GPxmsOFjww?=
 =?us-ascii?Q?ykBaUvYDjf6dcclAki18MaSE5l6BU3abxjZZn0Is61WgX7sVL+O5QwRT3m5Y?=
 =?us-ascii?Q?tkN6glAJIjjf8qm+rJQbEtiREd+HgWJRuME+PKKiPkc2F/ePczTIlam/06Du?=
 =?us-ascii?Q?fpqX9y3UxelnyGi39PJkfmfeQ2EREt/HWqJqcKbBuEEQtVjNj1YfacoMUZP6?=
 =?us-ascii?Q?VvpYJp0qrQqHc8qWjtjMQKU61PT4t1r2eV8Cvl5ZMmpMSabBTlIiogmrT+1o?=
 =?us-ascii?Q?wfZxGEHGggibhvNx68bBY83EXLCSr530atJvZsBrmiu5b+oY1y5VUd0zoqsy?=
 =?us-ascii?Q?ntYE9BZzyEeQXoae+vhQkWix7+PO2RGDjxSnHCIg3PxzTC39GA0/K++xaDGJ?=
 =?us-ascii?Q?agH+tAixlGv/R6wIinl1J5ONogVnE7wAtlt/bKBNtHSMxKov1PFeIrvOXQsd?=
 =?us-ascii?Q?5aZNH118ZaCfFdirsXZ3EvMK7PBUlskCYcUZ3W69JY4uYAR/cIOaxVNGa7v0?=
 =?us-ascii?Q?cQ6M8YmGESe9gIOfwqnOZruOTIDh7AaacMyeJIpsDGZdyi5IxHuZ53PX831K?=
 =?us-ascii?Q?l25Kj4d3oLX5P+DXJDtHFGiKNhwMrSMFzqHwAUqdJfKxs/fiD1FXUCNB+tHu?=
 =?us-ascii?Q?NsDTi+uZoZTeI5ZuFbc2PPwOsXqCqP4WHOHIiaBwpsFWl3pSm/ZWz5/BbU2s?=
 =?us-ascii?Q?L7XTCcuxVgdDCCfqZxy71XItXT2rDo0C71adcG5s+47yfp3DRvkHSavTOIzk?=
 =?us-ascii?Q?+Ecr8Y/dWv0VyBpxbOUDVh7j64cEZIqDo0lEt3CwWORAVTsVhS9PfcaGvv9a?=
 =?us-ascii?Q?3Or8+tUXQABV6CYQCCxLYjTp8t8gb330iD1kOZwma8VwOxej0V+8j9oBtkLQ?=
 =?us-ascii?Q?mlsO2i3b33UIseR7kRFhNDS8zCv3CRlK3+xEd94+drFjxjTOcD3Fiu55a91Z?=
 =?us-ascii?Q?OPI+F4B8BEqFUCbZauWsuthS9NnltTG8Zwy+6rfR3V8speYNyHrR5BFjFCRA?=
 =?us-ascii?Q?ba+uPOAkzuRxtb5sqagoNS0ScJg/3IeCFAQXuCnIMy0dWtm21lUgbMGMIKeS?=
 =?us-ascii?Q?y3opMzicAmYYRRYk0NK1ekyXLGIj2p/ZHBmRdEg6jLvrVpTEAdHH+5aRiXtK?=
 =?us-ascii?Q?Dv5wVU5HhphiMKAlAEt0MfpP7v5uOgUKaYMlOpzx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023661d5-d6d5-4efc-701a-08de071c21b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:10:53.9112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: th7Cj2odCa3KdOPmo66UF31c8BduNSEt+8ZQ8Kh6N0Z++sHhde/PrsNwH9x40ICLSZ/JS5sbbpL9h/x+rUV6deab+tez7lglfPGhIWOAfGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH v6 09/22] intel_iommu: Stick to system MR for
>IOMMUFD backed host device when x-fls=3Don
>
>Hi Zhenzhong,
>
>On 9/18/25 10:57 AM, Zhenzhong Duan wrote:
>> When guest enables scalable mode and setup first stage page table, we
>don't
>> want to use IOMMU MR but rather continue using the system MR for
>IOMMUFD
>> backed host device.
>>
>> Then default HWPT in VFIO contains GPA->HPA mappings which could be
>reused
>> as nesting parent HWPT to construct nested HWPT in vIOMMU.
>>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/i386/intel_iommu.c | 37 +++++++++++++++++++++++++++++++++++--
>>  1 file changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index ba40649c85..bd80de1670 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -40,6 +40,7 @@
>>  #include "kvm/kvm_i386.h"
>>  #include "migration/vmstate.h"
>>  #include "trace.h"
>> +#include "system/iommufd.h"
>>
>>  /* context entry operations */
>>  #define RID_PASID    0
>> @@ -1702,6 +1703,24 @@ static bool
>vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>>
>>  }
>>
>> +static VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace
>*as)
>> +{
>> +    IntelIOMMUState *s =3D as->iommu_state;
>> +    struct vtd_as_key key =3D {
>> +        .bus =3D as->bus,
>> +        .devfn =3D as->devfn,
>> +    };
>> +    VTDHostIOMMUDevice *vtd_hiod =3D
>g_hash_table_lookup(s->vtd_host_iommu_dev,
>> +                                                       &key);
>> +
>> +    if (vtd_hiod && vtd_hiod->hiod &&
>> +        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
>> +
>TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>> +        return vtd_hiod;
>> +    }
>> +    return NULL;
>> +}
>> +
>>  static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>>  {
>>      IntelIOMMUState *s;
>> @@ -1710,6 +1729,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace
>*as)
>>      assert(as);
>>
>>      s =3D as->iommu_state;
>> +
>not needed

Will do.

>>      if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
>>                                   &ce)) {
>>          /*
>> @@ -1727,12 +1747,25 @@ static bool
>vtd_as_pt_enabled(VTDAddressSpace *as)
>>  /* Return whether the device is using IOMMU translation. */
>>  static bool vtd_switch_address_space(VTDAddressSpace *as)
>>  {
>> +    IntelIOMMUState *s;
>>      bool use_iommu, pt;
>>
>>      assert(as);
>>
>> -    use_iommu =3D as->iommu_state->dmar_enabled
>&& !vtd_as_pt_enabled(as);
>> -    pt =3D as->iommu_state->dmar_enabled && vtd_as_pt_enabled(as);
>> +    s =3D as->iommu_state;
>nit: init could be done at declaration

Not exactly, it must be after "assert(as);"

>> +    use_iommu =3D s->dmar_enabled && !vtd_as_pt_enabled(as);
>> +    pt =3D s->dmar_enabled && vtd_as_pt_enabled(as);
>> +
>> +    /*
>> +     * When guest enables scalable mode and setup first stage page
>table,
>sets up?

Sure

>> +     * we stick to system MR for IOMMUFD backed host device. Then its
>> +     * default hwpt contains GPA->HPA mappings which is used directly
>> +     * if PGTT=3DPT and used as nesting parent if PGTT=3DFST. Otherwise
>> +     * fallback to original processing.
>fall back?

Sure

Thanks
Zhenzhong

>> +     */
>> +    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
>> +        use_iommu =3D false;
>> +    }
>>
>>      trace_vtd_switch_address_space(pci_bus_num(as->bus),
>>                                     VTD_PCI_SLOT(as->devfn),
>Besides
>Reviewed-by: Eric Auger <eric.auger@redhat.com>
>Eric
>


