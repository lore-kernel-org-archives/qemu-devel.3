Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8851BC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXd43-0004ln-9M; Fri, 04 Jul 2025 05:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uXd3x-0004jv-Dw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:50:33 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uXd3v-00071C-8k
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751622631; x=1783158631;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tP6Cpyol1N6XiTrboS9ydpxBqnNv8XMhrr3vjgWPclQ=;
 b=FpmDfMWY6gD686enJ/F6FDbGNXaP9m9q1xUHF7q6Bcte1WSV5Y0aINVR
 ZjHHQ493nmEhm0gEO5lHyygbyOKAV5HukLyvWs3VjKyz+nhGbof7903JK
 TxALWUDPsqvygf7mP+g5naRMBvDjjCFsw/ds+JD+QIls/+Infkv/L370a
 h7DJx1so1yEXsfXGbdt6u29eCqbuuoh/NzmiFhjAv6hzRBNjoEjZayINy
 palOkINUYNtkBGSyDc9JdPymaJ16QtmJbko7WODrhJ07HRMEo4LGWFBds
 5UQpjdNM07cO+WoytTb9y9vXkA0JhzYeOjkZu0yQcSjhw1FpdgvXDkGk/ A==;
X-CSE-ConnectionGUID: pLeU+QRpQnyx+Wi8hpghEw==
X-CSE-MsgGUID: RKfFq9+WTqyp75xYWxF26g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65011358"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="65011358"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:50:25 -0700
X-CSE-ConnectionGUID: vhRx/RehT5e0CeUXn63WBQ==
X-CSE-MsgGUID: h+0MvPpuTcGTecpXJlBCQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="160277430"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:50:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 02:50:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 4 Jul 2025 02:50:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.84)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 02:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml+pKJpAqDlWwP5kMuuuNEOf6gVE5IpHMJblbTs0/oqRfWknMop1GEcDkTCsudi0QVwUIcuCxsXQzG92p+h3cmXnnBEcFFH14RwThmKfutEJqMDuGHNXyepum2R79qJIV7gkib5jRhah/7zFh5x6KHVxxH2b0Xla/g3/HniOHz/5djbNXdu/5sTMX+xp9c9eQXwCy5UoUeRzGN4wDUv1XYp/g8ozA5c3b1ji91EiMnJ0Ggt7cANN6KsVHIHL/Gg/1St53XM4vy8Ua/IeP+upWt6ykw/3cFen1pzZym0NkpEo7S2plIjI5Ub3qV9Qk1i5T5NunXHqBkK2CWsxiG7ZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwCftZSYkZ1i5Q4IKpEP6jGgQM9pK9FdK0fojoZAHRQ=;
 b=R637Ytt3RwMKah+JZv52ilDWMVbrWrhSzLORUdp5ihrjfzZXJpUXNjMPf8ESTnjnMjkPaWf2TGh1MYFNTDZmIKu++nGcmSP8541ERwhY8/AGfIY0Ruq/FUXCDRXl+wG8IjFIPEaGJW38x+/EbAFT8iLOaNkHkKMl7/hqZFTHvzAHkKwCDjyj2acb6Ee9E7+WV+RSbYEEfP9OrOlZEaPmPWm6+S3A8zGpzbtUJe09+CU6O6cM9LVFzSLLsHNLyq5gepxuMxxYMAtkD/PXNBcr90fdjNAKw2iSTyFl1rDiUdx4/D+CiJO/VXJpsL1OgTCBvdia7bGZhoFApiy0H+yFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA0PR11MB7332.namprd11.prod.outlook.com (2603:10b6:208:434::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Fri, 4 Jul
 2025 09:50:23 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Fri, 4 Jul 2025
 09:50:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V6 03/21] migration: close kvm after cpr
Thread-Topic: [PATCH V6 03/21] migration: close kvm after cpr
Thread-Index: AQHb65yMsITnHNUgkkakwRoIjbSdCbQfY4wAgAJU1pA=
Date: Fri, 4 Jul 2025 09:50:22 +0000
Message-ID: <IA3PR11MB9136B12D6587CB5C96D763A59242A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-4-git-send-email-steven.sistare@oracle.com>
 <e51734be-8949-4856-9107-16acdb6a80da@oracle.com>
In-Reply-To: <e51734be-8949-4856-9107-16acdb6a80da@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA0PR11MB7332:EE_
x-ms-office365-filtering-correlation-id: 399cdaa9-8193-48cd-ab5f-08ddbae031f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8aSqpPoQW6PbTral9/XX+gTGfB8eKd3IxkrAvCwkiw+jF9/nLyDpeniZqCWd?=
 =?us-ascii?Q?hU3HGys4SYnm1oxArIt9/tuDY0Mqu5tPejcmQG3mK+6teDtPiw95efE/XclD?=
 =?us-ascii?Q?oEbGdO1Uy22DuvEDK6hfdtP2D1/vbEDUU1MousE7MYKNkjKzgNdItxWL4UM6?=
 =?us-ascii?Q?DvFs2sQssMZd7LbcbR7m9hGxNe6t3GljpzlNq33gKxsp3Q4Cl3gylqYaOGOJ?=
 =?us-ascii?Q?6bxZClzLpSLnzIUguxZomjo7a6j/iR27Nys8WqecdYHIM1MUT/6+kcRZUZFg?=
 =?us-ascii?Q?f2guN59AjQy/nxfne1QMtCX+TZ2hTvL/UwoWOINUwyTgO/UMkEzdRFnNTd05?=
 =?us-ascii?Q?XxbxFNPx6YKLJ1SU5jGa63cL+wKyI2jppSWtfqhza0JqDjlWtyXhpicMRIXs?=
 =?us-ascii?Q?CkQ5817dELjHa6BOrfWTQFBlIs+mnq0lLLRuEqBpkC7L2HlgJD79UItQ8GXu?=
 =?us-ascii?Q?f1MCZyhYHzDkRBKw3tc6jrwFqhsC66YAC6LM0pkz+jO7DEqmAyvy4EcO6qlb?=
 =?us-ascii?Q?QBkgDSW7R0ZT473gZtqnpr7lhFUHaF6k5PxIk2tcR58KsnI3TStqJK/OMi9a?=
 =?us-ascii?Q?+igtB+YLlfK+c9FmJmSQxYuZvm37e5fAVcfTIVGQLo4CtBImpiNNwllNvny7?=
 =?us-ascii?Q?zlTk2pYQNpSI7NujN1RXod+5ystF+Dz0CqJqiX5fQimI4qwPSE1wzJQIKM4X?=
 =?us-ascii?Q?FJTN0LtpYXt9osZspSfryyfAVKAX0wuoFm+wdNHZAvoVTqJry8egvMOBpzTm?=
 =?us-ascii?Q?6lpQs0iFCsNmavPUiUDm8mdZ7A9p8ovJk1sxlnSUVf7PT2EyvTn334yEC99V?=
 =?us-ascii?Q?x/kJUGGKM6yVNAkiIagt9+VlgOAYF36NOL3cwwT5UOb5gHcld9cVGYOP3Vb9?=
 =?us-ascii?Q?P+8vGXoqUx/Tt7mIJ5W0SemKghOOslTRjo60ysxV31Z26BQR/UDpPFCSdmU8?=
 =?us-ascii?Q?reRfYc1jUzc05XaIhB3M8LvG/5RhJiAYuCY2Y3z6ytg7FU5KWqo6rdlOI4oN?=
 =?us-ascii?Q?/6GBxSAHMcIJjZkUWIXuBp9r8nGqdbE/9IzDpHuaSlu1sBkiUym5TSJg1iJq?=
 =?us-ascii?Q?1h3L3xCCVgx5zAFTeSYLue9oRL3mfllUsfv3KU8GDb538TlDMipVkZ6Sye4H?=
 =?us-ascii?Q?EjvYzfbpW3dThT9MmT5M15hBJ616tnCLQMaaDqQDBEUBE7zhOt+sNugZz4Km?=
 =?us-ascii?Q?wQjSYHeqvjnFb630rgagv7YxZXM5P6LHYUKJIFh2oZyAH4rFKM4kKeCNH0md?=
 =?us-ascii?Q?s+Xy6ONp8tt/HMUeSc/nyQzbBSgtbK0zUIhw+MgdPkEd9b2pOyr+76567N48?=
 =?us-ascii?Q?9qtRVaclhBCP/HYMnowK8LO93u+7B8MoaoQxVbUGBRye4TX5EA2alY/3BzvI?=
 =?us-ascii?Q?8M3b0L/etL+Kv2jz+ekfVNF3f70bRN8aZvMOnHpIP7/LCt1hCa3E947xVLc3?=
 =?us-ascii?Q?eBhMTlTfAfGaEn+xIoFN4gjzgGncczSFbwUUmOcNyO3Ki260MXpM4ZdMlxkP?=
 =?us-ascii?Q?CBmLQAHx2GbLVvI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RzxsyC8sfX0FW6JjyEgi71C1otyKgz9dtTdHNlY5vOf7R4L6R/fOo1hzmFY4?=
 =?us-ascii?Q?qciQZqPdrylUjugYsRBvThbgPSNj1GvGWL5UHECF513+QEVrGuttROJ3rTwj?=
 =?us-ascii?Q?pGq5ZANjQIhtp5l0G2q6xIWeLkUXoNBE7DbeilMzjdCfXXeLn4w6vYXG0Z/G?=
 =?us-ascii?Q?XEnml9ywGWa+HFH8RcbJOC4e36DveTrZucSafCMfqaja0iKvqNPRS0gjFI2u?=
 =?us-ascii?Q?gSjyHi8J+R3IavAQUYUvF7EnMFhkxK/WZKX5+O30tA60SZDr5v0cugwddmf9?=
 =?us-ascii?Q?6NwmuEnGVFHLoupVOxPaH3AveK1uMu4jVEdB7dQnJMDZTIsGNF0mJWM/wj3q?=
 =?us-ascii?Q?v2A2zPnD3EuYpX9CbqN4epKVqa6SwiQLFhyFFSIOMEmNvNoqKE1Dvg80JdIl?=
 =?us-ascii?Q?TYfHooOoP7vgomQ5Z8pEKPk8V0BaZfJQ6CF74q07RoECzQgfUCA/Ye5Qhmox?=
 =?us-ascii?Q?6M280nXBYYRH3PcmW2W7kXpTDf2Dj6mSKJmGFPRbRkOrdQSpCikS2TSt4aMq?=
 =?us-ascii?Q?SpCa+PuTHY7Gj7/8piaRjnxZGvrAoOWSMqRb4FypPfR+HbOKZmKo0CuNrwaJ?=
 =?us-ascii?Q?D+ec8TFHpmSP75ZAR9hXs1CWOnD62cUUF73Oc/Dm6oPaLvUH6qJdKGQDd8hH?=
 =?us-ascii?Q?YZeVIYuKxApBbC9wlBc33z7Y3RKNqDXIxiiJ79iBVMdC8xoBl1yo9dELFbhw?=
 =?us-ascii?Q?/r0E6PhhnP5lr5aS2D69EfS854NadJI3+swyzlz5WOtOOvPgE8klqy0fqrq/?=
 =?us-ascii?Q?nJVtpQDaofw0MRR8l/zugBDusv3AwPodsK0Qdb42Zdf9nxioOpMS3YaFrqxw?=
 =?us-ascii?Q?cRx6uyI93W0HQNFT5MrpKeNXgNOB2uLmSP6lTt8Y9NkX0kcMN1qBJ1wD6ruP?=
 =?us-ascii?Q?ZWt371l3Mqg1rAVAKZqBzAZaPaTzQztK82TMZomPn6kEUn+adarVdeUZZC5q?=
 =?us-ascii?Q?cRlzzQamWbu5k+ZKjSstz89TNiuPNSAy+wQkhmIpLAWvu59cOgYEgw8qQrcx?=
 =?us-ascii?Q?p6KpcBcCZBegDnZJfYrzwiAoISWyCe5+/Me8A73xiX2IqEgtMGXy6u3TPiPS?=
 =?us-ascii?Q?sORC4radhV+OZF8Qci2Uvx1JaQy2+FwDUFjSwThTdJmLV9PBfebPzzHjnuFO?=
 =?us-ascii?Q?2rrvy/TvJPziLjGyDiHdRmxiFW0tZMgh0xJ5FYMAQlrkxX1JmYowm1VA7GKU?=
 =?us-ascii?Q?Ru3IO6itaTJCqg7PUwr3MuMt/08iYVGYPNK1CqqMPkiivR8sJSqWSpcq5oDa?=
 =?us-ascii?Q?1tWSxATJ/QtIWZb1tvyyT9SiyH4t8vZKsnu0y+O9jo7NXtEQdHuKJOnFiTQA?=
 =?us-ascii?Q?fY8006GQd78OMOVbBckX3a4YvgVmbnTa/CTd0o6Tmr5QllcNDWGyYsRx7r5X?=
 =?us-ascii?Q?UZh+sFIPMRGjFInxPWxOSU4LMhca+EVw24AdrRmMra6PnkdHD2j1zaI8k0T7?=
 =?us-ascii?Q?t1cOnYnD12jF8YHmm/FWJ7swyrB7ts4SSUbivYHxCOUu+ZEWs8/VEBBelM6i?=
 =?us-ascii?Q?rojHDUko7SSLRUwuVlahyXC0Vw+1bRsUTGWCGK/oKyWix4pzgj9angWlba4K?=
 =?us-ascii?Q?OPV//27LOCxqXQ3LbhuxLYAQ0m8T0MbJPQ60uNrM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399cdaa9-8193-48cd-ab5f-08ddbae031f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 09:50:22.9324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAB8R0sW2fi10FvLhcK7XvAbnMaYD1M3phPsLLGRraOhY0vlXPIYf6SZzJyAW34JpU5C+3TIIwpT+OY90O/JsyHvbdcZjl2xAe+E0jGIokE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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
>Subject: Re: [PATCH V6 03/21] migration: close kvm after cpr
>
>cc Paolo.
>
>After incorporating Peter's feedback, IMO this version reads well:
>   * kvm exports kvm_close
>   * vfio exports vfio_kvm_device_close
>   * vfio-cpr registers a notifier that calls vfio_kvm_device_close
>
>- Steve
>
>On 7/2/2025 5:58 PM, Steve Sistare wrote:
>> cpr-transfer breaks vfio network connectivity to and from the guest, and
>> the host system log shows:
>>    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
>> which is EBUSY.  This occurs because KVM descriptors are still open in
>> the old QEMU process.  Close them.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   include/hw/vfio/vfio-cpr.h    |  2 ++
>>   include/hw/vfio/vfio-device.h |  2 ++
>>   include/system/kvm.h          |  1 +
>>   accel/kvm/kvm-all.c           | 32
>++++++++++++++++++++++++++++++++
>>   hw/vfio/cpr-legacy.c          |  2 ++
>>   hw/vfio/cpr.c                 | 21 +++++++++++++++++++++
>>   hw/vfio/helpers.c             | 11 +++++++++++
>>   7 files changed, 71 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 25e74ee..099d54f 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -62,4 +62,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice
>*vdev, const char *name,
>>
>>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>>
>> +void vfio_cpr_add_kvm_notifier(void);
>> +
>>   #endif /* HW_VFIO_VFIO_CPR_H */
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device=
.h
>> index c616652..f503837 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -283,4 +283,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev,
>const char *str, Error **errp);
>>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps
>*ops,
>>                         DeviceState *dev, bool ram_discard);
>>   int vfio_device_get_aw_bits(VFIODevice *vdev);
>> +
>> +void vfio_kvm_device_close(void);
>>   #endif /* HW_VFIO_VFIO_COMMON_H */
>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>> index 7cc60d2..4896a3c 100644
>> --- a/include/system/kvm.h
>> +++ b/include/system/kvm.h
>> @@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
>>   int kvm_has_vcpu_events(void);
>>   int kvm_max_nested_state_length(void);
>>   int kvm_has_gsi_routing(void);
>> +void kvm_close(void);
>>
>>   /**
>>    * kvm_arm_supports_user_irq
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index d095d1b..8141854 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>           goto err;
>>       }
>>
>> +    /* If I am the CPU that created coalesced_mmio_ring, then discard i=
t
>*/
>> +    if (s->coalesced_mmio_ring =3D=3D (void *)cpu->kvm_run + PAGE_SIZE)=
 {
>> +        s->coalesced_mmio_ring =3D NULL;
>> +    }
>> +
>>       ret =3D munmap(cpu->kvm_run, mmap_size);
>>       if (ret < 0) {
>>           goto err;
>>       }
>> +    cpu->kvm_run =3D NULL;
>>
>>       if (cpu->kvm_dirty_gfns) {
>>           ret =3D munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>>           if (ret < 0) {
>>               goto err;
>>           }
>> +        cpu->kvm_dirty_gfns =3D NULL;
>>       }
>>
>>       kvm_park_vcpu(cpu);
>> @@ -608,6 +615,31 @@ err:
>>       return ret;
>>   }
>>
>> +void kvm_close(void)
>> +{
>> +    CPUState *cpu;
>> +
>> +    if (!kvm_state || kvm_state->fd =3D=3D -1) {
>> +        return;
>> +    }
>> +
>> +    CPU_FOREACH(cpu) {
>> +        cpu_remove_sync(cpu);
>> +        close(cpu->kvm_fd);
>> +        cpu->kvm_fd =3D -1;
>> +        close(cpu->kvm_vcpu_stats_fd);
>> +        cpu->kvm_vcpu_stats_fd =3D -1;
>> +    }
>> +
>> +    if (kvm_state && kvm_state->fd !=3D -1) {
>> +        close(kvm_state->vmfd);
>> +        kvm_state->vmfd =3D -1;
>> +        close(kvm_state->fd);
>> +        kvm_state->fd =3D -1;
>> +    }
>> +    kvm_state =3D NULL;
>> +}
>> +
>>   /*
>>    * dirty pages logging control
>>    */
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index a84c324..daa3523 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -177,6 +177,8 @@ bool
>vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>
>MIG_MODE_CPR_TRANSFER, -1) =3D=3D 0;
>>       }
>>
>> +    vfio_cpr_add_kvm_notifier();

Hi Steven, I just noticed this, do we need to do same for iommufd?
Do we need to delete notifier when all VFIO devices hot unplugged?

I see Cedric has just sent a PR, if I'm right, maybe a following up patch t=
o address it?

Thanks
Zhenzhong

