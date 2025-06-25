Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027BFC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 11:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUOV0-00057g-Dn; Wed, 25 Jun 2025 07:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUr-00054f-UH
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:58 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUp-0000Tb-Fs
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750851655; x=1782387655;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BYZ/hc8bHw5vAqazTiLfh8dGa3zzxKLUHjRlkP2zRNQ=;
 b=So7UD75Kk6j1brnXoW7W+6SfjvnRmFBtK662RYy2c/+PgTG2gVqS97Mz
 D6SjbYOm6xPn2yO8kiHn2dVwH9It4NpLuNhQ37gkmcS308bKtYyQKdUPj
 x4AYYpphbqdelFmNEQTZyTael5ucyEKmdg0FqtnsBgNVBvILKsYRFDc+w
 lDfuXHa/o5hSGRV/ByFAo2arzsg+g84vZacSW92MtkYy3TnVNaxu1e7Wn
 MQb3D1HjOu4rpaKAHSRx8gKzmgiJguQsRKjtCRTFDrpPBuq3HIlcjDDCl
 cXSnlTpQHP8XIaYetSdFcJIPoAtrRv+FZdkdqCEJFltDbGXnapFY/YzlC Q==;
X-CSE-ConnectionGUID: oIPVZUwgSG+ye/teHtNzZQ==
X-CSE-MsgGUID: SiO0SDcuTLe1LcuYVjFHIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64473637"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="64473637"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:30 -0700
X-CSE-ConnectionGUID: EyVfQL7FQiejsirl0K3Wqw==
X-CSE-MsgGUID: 1CmpPgNsSt2tE0cK/3vjBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="183228894"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 04:40:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0xoL2giRv4SMq4rl7yMK/qko7WptW2NhsGEFFvOR+RGd7vSSGQ5hfpi0sBnBCKtY8jPqcv+se6huC7kS8Dt/kY66gptPZCittuRw9OmN70/oJa/2TMaT9liQuwcZ1y0FudAK2I9eyTfTdBpEr1SmJQwf510p31xZQKvqWaBWO3RBerRpdbFHAGBo21K5E2hyw69gBu+Yf937+k+FFxsVSxts9xVLm3RE/MsbFQ05465coKayfZnHur6PQ5F+lEVHwxUtUCi5ZoxsDIrnNgwrmWc2Wtt8TFx9WZNm3wW+DO3TOUmdQTGxuYEEWSadw5CKeYnfZUNGo3wSlvEx0sQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFyoXvf8hLk8Abb7kcOkzZoRoyEk2ACuu9C0vq5owfs=;
 b=nvCO0CFJ2DQl+brlDeWLqy42hNUMFcIeu8fy5/NlUNbsWEkguSQ5ckfk+oezB4khPJokMGkBSHmi2BOf49mXUVUSMe0/zWJ3DBD3mDOVDsOG6nheQRwSeYcr3qiRz7edg+VsxNXUc5Ku40w+bHTJ7QADhYJ9hYpM/SfWOBQo1To7P5uRoA8+C1+rPo2jNxRH3AnGLYmhOhrfHPsuqLTLLFWnXJ28mgDO1K68EJb/kwf+9oNe9JU/RYnf2MjA/ONRgnpQRZvc9E1h0b5LPQa1GTzCBZC4GFwZ0jzhPCO6zoYtzzBVPHKeor0++B3w+1FXkK3ukZICvPFEXviHyeA/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 11:40:25 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 25 Jun 2025
 11:40:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 36/38] iommufd: preserve DMA mappings
Thread-Topic: [PATCH V5 36/38] iommufd: preserve DMA mappings
Thread-Index: AQHb2h4eX4nyUuIc7ECf0x0InCaUmbQT1LOw
Date: Wed, 25 Jun 2025 11:40:25 +0000
Message-ID: <IA3PR11MB9136CB8AE8A61803718CBC9A927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-37-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-37-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7135:EE_
x-ms-office365-filtering-correlation-id: b2b83d28-83c2-48c3-565a-08ddb3dd13a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MmmgUSyCPtKahbwFIH7ULHCURtn82JrX2w9QJdACRUQyuhRUSCWDzNPMIu5l?=
 =?us-ascii?Q?u11ShCZtGlibjt2f85PA1A3RCCMiIehrF/mkqs/1ytcsCGYcQOtAAokN7iID?=
 =?us-ascii?Q?1sCwnfUYQnGVZ54XTevz13VmJrJ7pLlW5ZUNIwgix4cFs+Peyaosm0ui0u1E?=
 =?us-ascii?Q?vbq6wQpwK62jJzs3eBaSCfV1JImHUHjh909oleXE/zl/6PRpEN9gb11VzeZ1?=
 =?us-ascii?Q?pFd3nSDeyQ9pvwZSIbvkSlwpFcTL3n+nhb0o5LKLclSij83sBn9eANLsJO1e?=
 =?us-ascii?Q?QjgrbikpFYQRSZguCLC76XN1GkO91TxrOWLaealfc7GyzndsjykweBpH5kR/?=
 =?us-ascii?Q?xa+9Jju+ucTfSnVHQw2mnrMx0fYIZ6H5ptOhmImBZlzQ/IknVoz/C4Z5W0fG?=
 =?us-ascii?Q?6DVSaxPoahsT+SQL8IsFpQ2cxUJx4GlPacowecCkXqUVbFOVNc5sXkIws3gl?=
 =?us-ascii?Q?l6FM9+zOcHcbmHC95DoZ6Sru2YZDTDbNT8eqFVkabaYmmHLIrrmYmRoJOT/h?=
 =?us-ascii?Q?yNGWF5/h+buF6Bf9HmnT89yhKwPmXbkkZNufe4LFh4a157qsgz6jxgwnS7a6?=
 =?us-ascii?Q?09bkE4kIoj49Rdvnw9rHrgLUyfCDAlzUqOw+29Sb1U/wqdOpmrbaU3RC+/5q?=
 =?us-ascii?Q?YBzNIklzB9vAAirx4R+dNj30ZZxFbZZbsSs0f2gEhMDm02B4Vf+SLYB4Pj3h?=
 =?us-ascii?Q?GldFKgRO8+r2Pi5lAQpM36Oia3h6D7Hqugtqxi7oiwsmY4ZmkeJjU2ziOBQV?=
 =?us-ascii?Q?rCpUg7DzFxbATqWhRXod+KqUGFFUZ/3NmzLHAD4ydgcrEuL8q8oS4bPc4t5c?=
 =?us-ascii?Q?QMIqsgpzSNuFGTjbZfZogVlS6PdTBK9br0UXF3G9xrkfBt2cg9yodY7FDXPx?=
 =?us-ascii?Q?fQMKzWtCr08gIXNVI8cJIqrR+mON6OlQ6H4hz3DHNmatUTVOr5EiYDj2YlW0?=
 =?us-ascii?Q?EAG6MMPV9Agu2h8/Lkn8rh5WEuZJLi2edae1e1KC63VWqe2bwv+0VwXg+/VN?=
 =?us-ascii?Q?EVQ0HF09ws4dIplhukFYW11S/EW1mg2c+hhfWQmYzMUUMaKatN3omYQ1Fh63?=
 =?us-ascii?Q?DRbDYVhGzs0qQOAiKKHsAeTVLy7+sjANth9ak17viAUqQDIXGy53iq4hVb9x?=
 =?us-ascii?Q?9q9cgSq17WAO6zdNVOQjsT6zGXFu50FN9lfzSaq+ZT4QNRrb/wiXZvxwljK8?=
 =?us-ascii?Q?pl/J3F14Dpz2EqtUOdVXnQ0dXJHS5JLTkNFR8vISqflpY9lPby4IamcVlG0+?=
 =?us-ascii?Q?s9+Z25SDGkoF03F3lkSyTkqoDQ5w4lq0ubSLIsqwvN61t8496TlW6JfJgfUd?=
 =?us-ascii?Q?OJGMWvSiIiOWEWc1UxvlNnvS2DFWhRSHoRuAlQ0YYaHxz3zNJgSycPqjbg72?=
 =?us-ascii?Q?LSwq1dGr8yN2ObL6spKIjpb2YhnfLUv4AM42vPqiKKZCLOU05JGegFreBtAj?=
 =?us-ascii?Q?zKcwL+nWVyND3OwDFbNVKGogF9+haky6EpVjHyHNk9JulUuIrpHgAg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?whHgdHLcJvvSS3WE++YYwpJa1GdEfhh344GAjyINIo3ypKn45kMalR3PbemG?=
 =?us-ascii?Q?YwHh/PAGWrk1CJ1ZOyD6JHOTThwU6ERyD44Z9DUKhiS/d5I6ombQiJPqPiCe?=
 =?us-ascii?Q?lM6/lmVpVP5bU+V32MgeKckfKXgeir0+RiIrGMvxyYRkncFbX8RuyanQoVYJ?=
 =?us-ascii?Q?b6oZB7TgWB3L0LwGE1/qOQJmVABNNzwne5p5TsvKHy4iC2Ggc++zaFbATVH9?=
 =?us-ascii?Q?eCpvaWcLoWGMxavOcMFfeANC/0apvSdKJXUTGXCApUwtnMOvLhFhZ88Fl711?=
 =?us-ascii?Q?8NIsYOC8Es35TZc3gcaE+dbQMO+xMMi8dYCmq8XbOdGmJEEbQerwIKY90aId?=
 =?us-ascii?Q?bB2CWrnzyXb+o4ZJYpvaRL7fcYGtyQjAeJZUbms2Tdgp/UNl9VwPNM9/BasA?=
 =?us-ascii?Q?nZ1TuX0jMcBezJVS3NS4L/WcdpcwA2h9QSPdfKagFjAb30k8bv97N/UmUzCd?=
 =?us-ascii?Q?mlvZt93psbU85LExDHB3xeE+uOyyJ0xnTnBZVJ2KyoI78VgJm7Wa40WPDk/y?=
 =?us-ascii?Q?AJs5hLkAIe3CApCrDsFqO4xdFlL2LUdA3ha9jFV7JzC0/0vq4GJ9Yr1Ycg5j?=
 =?us-ascii?Q?Y6w2B5ln+FYzzDVgBwWIc2KqFr8xPhYbGmikUF/JkoJIWLW4Z4fMliK1BENb?=
 =?us-ascii?Q?eTqedJ7eXl12Bqnf1eNbT094i9udC7fqEmjTFMk2RJyAPqRkJ8q655eyk6GB?=
 =?us-ascii?Q?dUj2IgATSZ25IPCHo+q0JcjckXBpMvi4sU7SiJOhruILixa8NhTrEFB4VlaR?=
 =?us-ascii?Q?6mZ345pPebKjouOs4J513XtjqfoHBhnMq/ctmOmawjS3e0pWKlhu8tTQOPFK?=
 =?us-ascii?Q?X7ww2lpBpN6WY7K6zhVdNxI03Qjxwhi28b1hFdE3m3bD82gRfT1itLrGlxDu?=
 =?us-ascii?Q?4c7vI/Zte6LUm99FovxNCrCXyFzuThQMI1EAvBq+FVjgyk3EuseTogbk8eQH?=
 =?us-ascii?Q?5OALgjt5Ph/y2tDIF0RPyxymwTHKe0blc+2nHUitN1J6Xjz1yjoW1Bz44miT?=
 =?us-ascii?Q?LT27VKom7hrouMwBTOB+Pnngn0a/x+LhCvm4o04BNqYrFYujOxzvCT63DpGJ?=
 =?us-ascii?Q?snIZvwuNWgH8MIgnb+z/G7mjqhSAnVNAF5RDd1KzE0xS/dPxmfyjbeiBe0Ni?=
 =?us-ascii?Q?5juj0XMDX9IllxRrmL3DZMGoZeIb7Y1tWU9jfz8Q7JB2c+u6lOwJ4GwD6Qq+?=
 =?us-ascii?Q?2L7WuA79+9ldievzJkUPpQjGMnx9zz4bK/D9VkwZvRREGCd0CT0qRASMfj+f?=
 =?us-ascii?Q?Ov6WmIEtzD5QIMr7DOnAHvDTMGxICTtqWDCP43YESiHQs8t71gpyqLDpHAjQ?=
 =?us-ascii?Q?tLrCczgsmfSoB9FsbwkDaRylIqMR4yxP+U4j/WdWFGEOhhRrcfBsJHaVG3lj?=
 =?us-ascii?Q?DnGdRvx82Qdlvr4wrTRhdwiu3Qri8zPCixJq5GOpYRL0/5bdRDmxt0MFqeUe?=
 =?us-ascii?Q?ATOAsG/ces/csAw3xzt9FHGULFtiKygqXYZxaYO3uUf7J4SSYho3p5kwbLX0?=
 =?us-ascii?Q?0RyDpSm5DkHG8hoA1m8k0SvOnYxpz2kWwQU55hBRaTp7qxgB1wkN011i2ZsD?=
 =?us-ascii?Q?8+F/9kfpMq1X8mqaZWhotPkXqfp/f4kx4erri2rv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b83d28-83c2-48c3-565a-08ddb3dd13a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:40:25.5103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NflOvBAO9Z1wCc7FBHCFmPIQU13qJN4AJRkccytsM010slyDlfz7+cwpVVZ7swauMyPEJTfEeCbeYVxc/LNNblYZbvSaoQZSPcxBb+sBU8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



>-----Original Message-----
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V5 36/38] iommufd: preserve DMA mappings
>
>During cpr-transfer load in new QEMU, the vfio_memory_listener causes
>spurious calls to map and unmap DMA regions, as devices are created and
>the address space is built.  This memory was already already mapped by the
>device in old QEMU, so suppress the map and unmap callbacks during incomin=
g
>CPR.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

