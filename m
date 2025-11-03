Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B168CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlUW-0005Q0-EJ; Sun, 02 Nov 2025 22:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vFlUU-0005Pp-Hd
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:44:22 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vFlUQ-00010v-R9
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762141460; x=1793677460;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o3KHAA1hPO1FhyfEvXYczWArg+vPAz/OTWXdKEJs2UA=;
 b=CUvaRl/Uxl6nyQ+dKIGmA4cZX2i1p2mbCjbSsGzyXpiUh9HfO5n797qq
 iREdJZb4/t1XoHkvBboy6VTRCMPJz5xDQjhXCYCkYTtVE6uwQAIBDiBNx
 922pDOmaIVG6iKz2kZRNrblFJ3cUiDX43ULETOs5xE/uJ0Uw9BDA+yfaT
 s6gCmIjdk4uFWxfSGkNcDG1XH1V07LWnqYhY3QEXrIXU8szXDQYuvoqmn
 PEvVLq0ffna5JIDEA9Nu+HW0ejFvg93+sezkT181Ms26l72U1QChBhunX
 4C3+hydphDWg4Kd0HRJp80bQxZa3M2byCRJorc/NUnHWzAJ0ztlldC8YW Q==;
X-CSE-ConnectionGUID: dewaRHFeT0SvFIvknqVdpw==
X-CSE-MsgGUID: YRWP5Hz3QhObHnj9RQ81hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="81623196"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="81623196"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2025 19:44:15 -0800
X-CSE-ConnectionGUID: BcfYZHd3R827id5zy+6WsQ==
X-CSE-MsgGUID: EC1oFD8RRqK3AxwmUFxoow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="191916748"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2025 19:44:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 2 Nov 2025 19:44:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 2 Nov 2025 19:44:12 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 2 Nov 2025 19:44:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlQG89trko4Bnm9jFKfjBqtu6T6zOZIwF49Ty+/YF8Jh9WfIgR/WtD5KMteeUhShoq2+M4gJkX3jbWqFWzRoAfJRBv6vO2EdVnZC0rFE1KUF8xAZDeRIthOq8shRmtxaLL1vfudBCGUjjvCLMDbLeRl11O25ioWkr4C3F0Ic/hhivymdfKiXZBsWI0e763xVQ6d0+E8kp3YfSqYLsKLIPZOlaGl9SjLNLE7dWBkwRFLyJXZklzk7w7fgBtagi7P91PyxvFfp0/IxoF89Kicl6qgN3QeH2RR9j9onmx9ob9Dez1T7DkeWldBtXzos9gA3pSz+kW6J05yXxTYnDMwD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyWcKpKu92E2GvOxp2X00l98rqoeDIs8gTNSg7Eqzdc=;
 b=mGK701KYeD7R8tuw2NGLDotkBo9uwZm2G5rFHAuYy25JWfrKMeK7mstLm2B9rF1mFCJ6sgDfr6q98JUTZTbj3RU+ATrpcWnwD3wnq8kZjlMiRGZ5iA4w2H4wGKIx1kYb4sJtjlIwOniwfOvktbAqN4UhH3Aq4pImHDNyBrPTKyc18arobnQOfwV+rDn6cBrzQ9sFzQ5mZdovrst5dsQKDXDF9fJuHe1NevJTuQxA/vtzdQ+lZs7q1Jtc9OL2PQL8hWVhaWEQxpHBYgpfUsdpBe2nbDFans/ZZdU8UkvfHtRTTgpFGxAGDppGEawyAHlNxysIGYZ/k8zT50mic8RxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL4PR11MB8845.namprd11.prod.outlook.com (2603:10b6:208:5aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 03:44:10 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 03:44:10 +0000
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
Subject: RE: [PATCH v7 12/23] intel_iommu: Add some macros and inline functions
Thread-Topic: [PATCH v7 12/23] intel_iommu: Add some macros and inline
 functions
Thread-Index: AQHcRMKRdjBWkWbHEUmpCsPDnypQ+bTfSn+AgAEHaLA=
Date: Mon, 3 Nov 2025 03:44:10 +0000
Message-ID: <IA3PR11MB913633AC1F9034AA7EDD987292C7A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-13-zhenzhong.duan@intel.com>
 <1c750d64-efd9-4942-af00-a36267715837@redhat.com>
In-Reply-To: <1c750d64-efd9-4942-af00-a36267715837@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL4PR11MB8845:EE_
x-ms-office365-filtering-correlation-id: d797a9e4-5ded-4ff8-f06e-08de1a8b3fba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BpqzIWcEtVBOIDu7Iw1BrSfF6iep723Dj9wY1uNOO8auUdpHc2Gd6NrYE+KX?=
 =?us-ascii?Q?qnXTqLycUcovdr10SJcbv+q7n4lne6dRHCyadKb7vg4uO8WyataMdpRiOETv?=
 =?us-ascii?Q?oxLIcWTthg/GLk4NyYjfb2VXZ1alUrWYu51YbnW4yl9dXjRY5tIENFxODL77?=
 =?us-ascii?Q?E8/yhAJi6Q/nyC9XNYp4/bJfvKXxrfDmMtvBrP9iJrjsnKoBhnxTqctP+Q1M?=
 =?us-ascii?Q?yUekJUPshIjIQAgT5C2JLd3MBaYGmNsIYC7ogyYh0PpmDua2oAxanzL3cNjW?=
 =?us-ascii?Q?KObnUBBntSNUASuYGKvIyEsm5Pl1aX/qH9xatgJVSrvG4gCawwQPSDnouXLS?=
 =?us-ascii?Q?xDWNCaaTH747/87kzyhztfISRs9ZHUkmgiKmr40yMmr86rMtPxxdz/HCBe1I?=
 =?us-ascii?Q?dVgK6+8rR27p+7QQSgIEvAfJzdTaGR0ZhrX7zIdn/EZpM2RJ7EabG6B+f8Py?=
 =?us-ascii?Q?8R0rjPFjr7J75Mmf1Jlqq8lcOVndzwZ1lNXkmcABkpsef/+X/EUcymMc4cd3?=
 =?us-ascii?Q?6pI5UtSLI2qFYvKWAh2LW/JRQ1AIxbzEdW9E9/UEVtQr+BZniFBWM9YJzRHB?=
 =?us-ascii?Q?xCco6ZJXa0/x179Sslaym+VVMpaeE341tf/ny0nyIR8nrhuGc8wzfQthAtc5?=
 =?us-ascii?Q?bBzz9RroEolz/cEh+oFgSeXsFZQXkrjWqnhvK/gXh2wg3ZuS8N3dr1YzK4E/?=
 =?us-ascii?Q?4M7IyWiFoddMXSYJf5gZgMT2BIwnExJgeXFtr2VwTydSolGZTF/wHxWF4Z/G?=
 =?us-ascii?Q?mTtQ3cYx+BqGK4ddmwatXIzyXzD6JhD0eEkKTz7kU47Letc50ELzkQ/KzGou?=
 =?us-ascii?Q?1WhmiVAU0YoZTLUN3OGt6q9yY/nC+ODKOWe6JHQ6bx9ez+0ZMPGszaIDhlin?=
 =?us-ascii?Q?T2mNQp5cMboSXi4ogd41PpgUjLkJqGnTd+63NNiN/v8qSruFT1YrXcjWitZQ?=
 =?us-ascii?Q?lcyobLnZ78E+vNs2zDsa0G3yVVeT3XXuIqsYBPWw7cUbHZbG2ZZpZiOo9e6N?=
 =?us-ascii?Q?d/Ig5bPLYQI2zH5BDDR9I9e+PjAMuzZ2DKshVriaPcMlQuecaBBVizpHbqY9?=
 =?us-ascii?Q?ndlAYUEHzec/0N5zEPIHcTYoubE//vgEpu7qZd3tDgkIBYGjZAtp2tUfwQ1A?=
 =?us-ascii?Q?KIAAQOGdddExDOcTUtPHZZmJgItHoqC54og2KgTVnrhJeHA/GPv6ITycTjwr?=
 =?us-ascii?Q?OBmYPtnS2zUt+3jH+iTwh2hYPQvsZxx+K4nHcTSx6k7K9fZlANA7PXURGdUi?=
 =?us-ascii?Q?/nrqx/mFF7HixN1zvCrV08fGjO2Gj1h4eBobWdbRT14jCK7M8iRXQOVMerpJ?=
 =?us-ascii?Q?D03SOlycXoRwIsAk0v09FBMvAaf+mlH6ZPp7t+M4Gkk3QSpzq5XpfsO/7jRl?=
 =?us-ascii?Q?+Tq/SN6UySJQt1W21kLPcjbkvgFCgdXr7aH8MBciQTbaHegV8fZbMLh1zfwL?=
 =?us-ascii?Q?8Aoi4LXTOIS8vIQJoMA/vwkJKUOImiueRpJ60RSZCuas+MbQuiyPxg2rJfSX?=
 =?us-ascii?Q?Xh12h3kZHdQZlPubG5rzZn/f7G3vZkfuDkWH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iNCSXUZqhGIeaQPurLe/F972A6S1X0y8t6QO5kfaeFOrRpKhMqRJUBJXSGIr?=
 =?us-ascii?Q?Z0uR7mWMC6nLfIT3fMWEA1pVMxiYZDIIN9tyWcOJM6QedewpYq050RAO3PtG?=
 =?us-ascii?Q?J1vmwDM3hwFK4bGOpA0DE4hLci2FKQue7Z4pCuS5Kom6WjDBQMvBQ/pseUdb?=
 =?us-ascii?Q?ID7Uxv1Vb5AkQtw86QUTh8QK3SodhhYAzwm7njDGRLktJ48pLAB1/n7YerBt?=
 =?us-ascii?Q?u5QH3MNuImWB4PQZ3M8IRg32zTSsRMuw4ydL0fFbErQ93VbewJVeYJ+X/s0f?=
 =?us-ascii?Q?2r0bii5kjhwsIlurrfIUa9QaMo10dlLAmGY4x8Dwq4pQS1c2oyQdXWYMKsgE?=
 =?us-ascii?Q?hnfAZ+XwR8YU+jmLb54iye0I0enDQRM3YfGZM+drO5IsmW/6iId7iBBKeswb?=
 =?us-ascii?Q?20Itje0ART36KQUgOsX5OiKxjGZZWoxf28qA47nBhL2dmLbdhGsulkbOZyrU?=
 =?us-ascii?Q?ckwg/TjDX8NXV21yhJ9I9Hh2r7aS4Z6d1wy6gR1lp5SBWeYb+h1R/Kfv2rEF?=
 =?us-ascii?Q?lX+/cvnJTN0uhJnaeg0fi/wgYsOA9GuaDYU+w6DoIo4133FcKbRzFJcVE7NM?=
 =?us-ascii?Q?qkHrg6DoBUlKBhOiYoYL+91ChOmPaTD429dizQLxDaB1v6aOta0K96Rjyypa?=
 =?us-ascii?Q?9zB6vhuGBs7S6t1PcZeoSDomxMK68ZRO/8vOslUXpS9aT8xiOngX6CURXanU?=
 =?us-ascii?Q?9cor3FCiFDScy1VRqmtRPAEL/3LMu1koAWiPlMoASElD9ZQW0qEOVE1BZZfv?=
 =?us-ascii?Q?6CFTVSIE7Tgh5Jnopde+Auv+ilMXJ6+EGTNL4J9En04HDR8fv8UfEz3wU+/H?=
 =?us-ascii?Q?tQ8QpuXBGgjodTB3EorT8ikUp1VJzyBFLTSUR7wPPiPgINSF0ExLnYmRa4zA?=
 =?us-ascii?Q?XefFCMs26yAcD3iCMkLKwG4F/IOTdEzTnJk0v5opPU4/bc1wKRdeEeatKIBt?=
 =?us-ascii?Q?c2PWzTnJPZRt38xRxiQfpA+lrYm8bezMQP3scYsu/ncrz+34ZU7yAWOgDQSd?=
 =?us-ascii?Q?0felk4+l5y3HEaUjaA4BSAIwLP/AXbZSqv4s2FVJmZZnUXXAgMj7+kwTJFIS?=
 =?us-ascii?Q?skLw6vgDvElqGUgh5HP4zHqESIpk9vXvHjdhe6eBj1KwiptQKLG5DEOo7S9c?=
 =?us-ascii?Q?shh4x1t2dxrc3jRASbSGGWHfNoJ2oFOOAUsp0S445pMDlCOWudiWvIHnckG6?=
 =?us-ascii?Q?c3e2qNzVEwJ03TkHu5BJlo0aeFx/QpqnkxZFo37gqWJvIp9GM/IxtX5TB8M6?=
 =?us-ascii?Q?PO2y2LSYrexTlgbpYmmgnttNC2leSfmQxaysaRmeGGv3XBYccs5VlpmWttMp?=
 =?us-ascii?Q?wUt7j/AsJn55nVdIbw+klTEnEMZ5YH5SFNqeYm33wT3Tfl0QnMjDmvlSofU3?=
 =?us-ascii?Q?Z2qXtIjqTzBTxtuNOLgjKLwxiwnwj0NslujrBTYGJY/IFsov9VflhXO10zQW?=
 =?us-ascii?Q?3V/ljk7fWhrbHaRvsM74wFiaUKGpFgntN5HLGoyXFA2nygy08sLj9kP5aUDN?=
 =?us-ascii?Q?xmQeWwHDfUD98af69P8+y+FRF+O8eJDf6sQrh4rqU5/QWvVnpRtffRBjjwF3?=
 =?us-ascii?Q?HIR8Ud/6V/xW1UjaUKqnNyKH9vZ1wfhm+W2N62QD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d797a9e4-5ded-4ff8-f06e-08de1a8b3fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 03:44:10.5138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8UvHAg430b6vFtJsCpth2G2NomOFnCdEKu1V9VqDVTzElNffaAUZDZMzW6Qza7Q36q12Lg95IYjgiJvL9K1sho+ntPnx+d6pXNOuc7Mw20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8845
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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

Hi Eric,

I showed the planed change inline, let me know if I misunderstood.

Thanks
Zhenzhong

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH v7 12/23] intel_iommu: Add some macros and inline
>functions
>
>Hi Zhenzhong,
>
>On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
>> Add some macros and inline functions that will be used by following
>> patch.
>>
>> This patch also make a cleanup to change macro
>VTD_SM_PASID_ENTRY_DID
>> and VTD_SM_PASID_ENTRY_FSPM to use extract64() just like what smmu
>does,
>> because they are either used in following patches or used indirectly by
>> new introduced inline functions. But we doesn't aim to change the huge
>> amount of bit mask style macro definitions in this patch, that should be
>> in a separate patch.
>>
>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>  hw/i386/intel_iommu_internal.h |  8 +++++--
>>  hw/i386/intel_iommu.c          | 38
>+++++++++++++++++++++++++++-------
>>  2 files changed, 37 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h
>b/hw/i386/intel_iommu_internal.h
>> index 09edba81e2..df80af839d 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -642,10 +642,14 @@ typedef struct VTDPASIDCacheInfo {
>>  #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>>
>>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted
>guest-address-width */
>> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) &
>VTD_DOMAIN_ID_MASK)
>> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>>
>> -#define VTD_SM_PASID_ENTRY_FSPM          3ULL
>>  #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
>> +#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
>> +/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
>the above comment is not that useful along with bitmask definition. I
>would rather move it along with VTD_PE_GET_FS_LEVEL(pe)

OK, will move it like below:

--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -56,6 +56,7 @@

 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
+/* 4: 4-level paging, 5: 5-level paging */
 #define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
 #define VTD_PE_GET_SS_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))


>> +#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2,
>2)
>> +#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4,
>1)
>> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
>I would get rid of _BIT suffix to make it consistent with other fields.

OK

>>
>>  /* First Stage Paging Structure */
>>  /* Masks for First Stage Paging Entry */
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 56abbb991d..871e6aad19 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -52,8 +52,7 @@
>>
>>  /* pe operations */
>>  #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] &
>VTD_SM_PASID_ENTRY_PGTT)
>> -#define VTD_PE_GET_FS_LEVEL(pe) \
>> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
>> +#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) +
>4)
>>  #define VTD_PE_GET_SS_LEVEL(pe) \
>>      (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>>
>> @@ -837,6 +836,31 @@ static inline bool
>vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>>      }
>>  }
>>
>> +static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
>> +{
>> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
>
>also introduce a define for FSPPTR using extract64((x)->val[2]

Will change like below:

--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -650,7 +650,7 @@ typedef struct VTDPIOTLBInvInfo {
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-widt=
h */
 #define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)

-#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_FSPTPFN       extract64((x)->val[2], 12, 52)
 #define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
 /* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
 #define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a3a4a8a72b..f801458649 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -850,7 +851,7 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s=
, VTDPASIDEntry *pe)

 static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
 {
-    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
+    return VTD_SM_PASID_ENTRY_FSPTPFN << 12;
 }


>
>> +}
>> +
>> +/*
>> + * First stage IOVA address width: 48 bits for 4-level paging(FSPM=3D00=
)
>> + *                                 57 bits for 5-level
>paging(FSPM=3D01)
>> + */
>> +static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
>> +{
>> +    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
>can you add a comment refering to the spec here?

OK

>> +}
>> +
>> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
>> +{
>> +    return (VTD_PE_GET_TYPE(pe) =3D=3D VTD_SM_PASID_ENTRY_PT);
>> +}
>> +
>> +/* check if pgtt is first stage translation */
>> +static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
>> +{
>> +    return (VTD_PE_GET_TYPE(pe) =3D=3D VTD_SM_PASID_ENTRY_FST);
>> +}
>> +
>>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>>  {
>>      return pdire->val & 1;
>> @@ -1625,7 +1649,7 @@ static uint16_t
>vtd_get_domain_id(IntelIOMMUState *s,
>>
>>      if (s->root_scalable) {
>>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>>      }
>>
>>      return VTD_CONTEXT_ENTRY_DID(ce->hi);
>> @@ -1707,7 +1731,7 @@ static bool
>vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>>               */
>>              return false;
>>          }
>> -        return (VTD_PE_GET_TYPE(&pe) =3D=3D VTD_SM_PASID_ENTRY_PT);
>> +        return vtd_pe_pgtt_is_pt(&pe);
>>      }
>>
>>      return (vtd_ce_get_type(ce) =3D=3D VTD_CONTEXT_TT_PASS_THROUGH);
>> @@ -3146,9 +3170,9 @@ static void
>vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>>          /* Fall through */
>>      case VTD_INV_DESC_PASIDC_G_DSI:
>>          if (pc_entry->valid) {
>> -            did =3D
>VTD_SM_PASID_ENTRY_DID(pc_entry->pasid_entry.val[1]);
>> +            did =3D VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>>          } else {
>> -            did =3D VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>> +            did =3D VTD_SM_PASID_ENTRY_DID(&pe);
>>          }
>>          if (pc_info->did !=3D did) {
>>              return;
>> @@ -5267,7 +5291,7 @@ static int
>vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>>          return -EINVAL;
>>      }
>>      pgtt =3D VTD_PE_GET_TYPE(&pe);
>> -    domain_id =3D VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>> +    domain_id =3D VTD_SM_PASID_ENTRY_DID(&pe);
>>      ret =3D 0;
>>      switch (pgtt) {
>>      case VTD_SM_PASID_ENTRY_FST:
>Otherwise looks good to me
>
>Thanks
>
>Eric


