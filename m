Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD09FC3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTuFH-0004pJ-9B; Tue, 16 Jul 2024 22:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTuFE-0004fz-OM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:18:16 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTuFB-0005Ee-AJ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721182693; x=1752718693;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cWJ5JsQsiVQftXKCu5yEBIPLA+YDzNXDzTwLt9i8bY0=;
 b=DeSsAejKPc2kmn1YjQCpW3Q6yfFW1y00BMe77mntIBQ5T52/EYwXO3J9
 XncwJgu2z7ZrzDfYpCkFeVVo9erqefyLgD+obuCtaxxodna/xW8g6HFJZ
 pwLofNvyeXK4p4O6Zlfr2yMBtpIMUx9WEgcDoGMSRUCQgQS3ebnH7yVIH
 Ltx4ybB1xcXwgJ/VGQPrN4TEJehS/slnZ9jmZWsWpCtFDyX0+HB9dKDdZ
 /Pbnt4eqpzNBCZhrcmkbvHzqmEx/g6ljWFDGnMjxBn162ONkVAbL+LYms
 vwqG5GdxO1nLQkKsYj5GMnLV+j/excEPh3famyUECfxPUbWqP9TVkncT/ w==;
X-CSE-ConnectionGUID: 3hVdANv7Tuimslu31bqndg==
X-CSE-MsgGUID: 98IWnH5GQEiLcq74cphdYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18526319"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="18526319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 19:18:09 -0700
X-CSE-ConnectionGUID: DL0itEI/Q7CAzakPvj3chg==
X-CSE-MsgGUID: IxCcoyCCR72zIIcCMSzTVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="50156090"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 19:18:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 19:18:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 19:18:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 19:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuUrfKqo+63CYz2TcIBWiRAQOYBQFSyL7qXQA0EMQICSVcfWiBqNuiY+FbeYN3ekODkHHthOClMIqK4UG+CKwUVAmaiJTznupl0mKb3VaW+yjZ/HLABKQJHjLjyGReNL/Pl+ggxmiZ2oEHA/K3LQe1ZSO1yz8aYy2UIkodaJbq+5DR/i9oreO0Ut2vDNNUdDts03CFv156fMq1xtib0kMyt1Afv2w8bUn02+volNk64yhjYpGfI4KKp0Ahhjw0QLOlmQQC58JoLfrF2gM+HWWQ5Dyt/HIIjYr8jRJ22Gl93hymvpcPP8eFr6UTXBS8LelkRlqOzTSETVgFSoJpD7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kAUqpyAzLhHPBKW/f5qPaDnNK40Dvu0KAqKm53Hphs=;
 b=O3WhdE5/aQu/z4i7NkyCYR+5IYobW62OaNp6GZi0VOqAIJmIwbtCbkdLGt7/arBGf3N5uhBHNvjJC46W5PjXX1hC+BQ22nuMJM3LgPaL4FL66hDU6n892bo3sf5Gsy67ZIjPgd0Z+4YNHGuBUMkD2Piz+siE1n1/rjoFoRYj8uzGgMFo1sXLgVP2GpjJXjLtYrLH8sOM82sR3GzLqMvzMktUc8QRoP2DykrH6kKbSiCMLKoRaSpJqeLJ7tiKy1kN1VY1gfdPxsyHE6IdIZSvfj7kJA/i3AwEjnH/t1mK1W+XHd6K5jGL6dv7rCDU/i83AkHBZecAYWJW/xG88bkVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN2PR11MB4614.namprd11.prod.outlook.com (2603:10b6:208:268::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 02:18:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 02:18:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
Thread-Topic: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
Thread-Index: AQHa1FFShwF3jB8O50qStFQJTkISYLH6NXow
Date: Wed, 17 Jul 2024 02:18:06 +0000
Message-ID: <SJ0PR11MB67443AD929EFB426B4E4FBBF92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-6-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN2PR11MB4614:EE_
x-ms-office365-filtering-correlation-id: cbbbf16d-58cd-4521-7aad-08dca606b1f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?80QWx/XlX8iyn0cQrgxhvJJo7t1owff5JaDgrvfIsqsfSd0qXz7Oleeq8Swf?=
 =?us-ascii?Q?tVd88kJbMQLlZ5tdfS7qbobJRxHRP0wOIFuOCf737UfYQqvDOo8fv0YvcaJS?=
 =?us-ascii?Q?VbzWtTM7KQEpwfUtfaTYJDvHtwzHaVNA5l4TIlWy8A2MgCYq3q4OZMOV6E2W?=
 =?us-ascii?Q?uJ/rkNixUi1qdT6HiIX3JSNpTx81JnpVvA0IDYJ7Mbso7jKYkzgThcSQ08lH?=
 =?us-ascii?Q?4SHGuzrc1wYKOkGLNeksmQci3m5ytOkOaN08kevq+Z0G3HY2yLp9jBz7yIo6?=
 =?us-ascii?Q?KssYr8b47WJ3Ja6bmAOKfg4Zq4kDr7phQudkFakpYzzN+GX7p9UHbsAJAUYI?=
 =?us-ascii?Q?ya+gO0B4USvxg5xoDxPy1cRRuwgWEUTl8AIoxdZBugweo6VDaIY8taQiXk9K?=
 =?us-ascii?Q?jefcw0n3gstvQcsXHIJ9hjwf1V0RoOLECCYZa5a+ycyrbcCbNvQDjAVpxsOU?=
 =?us-ascii?Q?KoUKXl2t96dvhqNeQB8LJRZFu+/GuGo8qEjOpuG2oYH8iqJXMymmhMXbFtfJ?=
 =?us-ascii?Q?nIqGQ52Bex1PtGDCDMylQ3KGvOw5GUGFcN5AvrYlz4c3vnhBkqLpDbWwyitU?=
 =?us-ascii?Q?kWer/63hr6ZVBaTgBa3M/G2h0oOzMlXSP3uD30WB2xTx8p9JI+yL8IEm/YCE?=
 =?us-ascii?Q?OF8A2kku38XiZ261ZREtx1OjUs7JhhUuUZBsU4TEeGE6zwXI9pVOyP2XqFqU?=
 =?us-ascii?Q?mUynotHl6DlzeDKKfkjR19KoACzvNuj1tTrwBQpoia5ZC2alRtQ6xrgx0l12?=
 =?us-ascii?Q?15K5qfzgaQ+LXn4LTwtIg6Ye3hKtchhx0V2AXuCyM7CCO+cPITc2arHcdVdq?=
 =?us-ascii?Q?pnZ4TrUSSN32VWocyEa8+GmPdX5FKrb4Lp1A4uJxNnb+YTWjY5dzkXiaCaQL?=
 =?us-ascii?Q?JZeRSlCwptwT4ocxeksnzM6Dl31Dm6OfrIhsraAGlPYxpRgLUTYhaVxlfLxB?=
 =?us-ascii?Q?Xb8QJ5AuDfL3X9ujrNDvKE881nWYlYWDuR8355JNeyFC667nIWo/+CZB5QjD?=
 =?us-ascii?Q?Z8s7opg28iXJNw4HEEYNxiIkQcksRvl+4K6oJBY+FHCaTQcZoxIWTmT/C4Jp?=
 =?us-ascii?Q?VZyf0iprv3SrOV+FX/rntZA3zy0fH/TxL+APgzx1gkLJqwFxIDJzCAHYQhX6?=
 =?us-ascii?Q?BP3sS46SrILgSKflTvsHbqLztL14unfChVh7uLCRd18VFd4CrlTNhPyYhEqd?=
 =?us-ascii?Q?b/XIaVWOQyrJDxofrqFo0e+ibvgmx/LkVSH71gueMKnWV9nFDb7plL5Htscf?=
 =?us-ascii?Q?qLd/ebJH1mo9yE/5GfPfaZ+s24EWSJKaPiHnNkPl9+25EapyW5CYjtFK8cDV?=
 =?us-ascii?Q?iUW227wvnAeNzxplb/DNmXf3pyhaETeJ2Linf3bxJASr9JBM+PsR8eDw+STy?=
 =?us-ascii?Q?Qk/R/nDQAs3aULsN8YBchkdlVbPLlxy1C71Qvu71GWg/5x42QQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N8n3ufJ3bb4BQ/2NKIoqNQUTkxsn/eQ//xHuZepbEJyqLUjcI8INURDy47Xg?=
 =?us-ascii?Q?0BCU86PXbTVfdEQjjY0iY+8PMZ8RUZb1rHK8SPgwJhWm4e+fiaimWxdHRKjU?=
 =?us-ascii?Q?FON9cmxrAVCdF7SlhecbbCtuNJ5grT7B8ZQyPsePcDvY9PmmKzbIKp4pvThb?=
 =?us-ascii?Q?JLppHHIGD5GQV3tXcDO33lqJx43KMZJSxkuZbJgYnwuRWvTVFBRe3r4laOmt?=
 =?us-ascii?Q?Kt8eJlaURkrujm19m8pq0PBYF9riBb8UEg8npcuDL1z4JrrrQIovGlef+hJD?=
 =?us-ascii?Q?6SJDkU8DSMl6N5nkmZHfTfAjSvi5lO35/OkyYu7HcVFxLUwLQkQbtGuhBTT3?=
 =?us-ascii?Q?tNB+wHp8P2UHmv2wecwbFaoczon1rUrR41+SCB6D9UfIrXoWAZ9uerpCe9nR?=
 =?us-ascii?Q?7TkNmuxCjPzfgwMieiCehuQNOTGAuaaJc8hFW6H7erNxZhskMbce+xtmA/GZ?=
 =?us-ascii?Q?mQiVKuVqnzdF7mq6m4iFCXcWJ6LfNPU2eLXN7e1xpP/jDSc4BANdZQBzhM/J?=
 =?us-ascii?Q?B4399FBc2vrkl64hhiXVxYW0ysGYstRJYEZ5XN0BcqfUgmK0p1KDHYhX4VUv?=
 =?us-ascii?Q?5Rz66QBq6JO6sco7Nli1R8/T7NoYkCFhjKpdkjkgtjhW+gkGOxQBvcbihgGK?=
 =?us-ascii?Q?ujsf+CCDF7PStaE3CzokDgZehxb3qWVARv3Qj10CfdiW1IWQ8sisEIxtrv9V?=
 =?us-ascii?Q?pzJFfdRHNslCohqOF8xx+lUnh80IDRtA4D7xT66+Z96fAD1wiBbw+rqw0P4N?=
 =?us-ascii?Q?PLDDjXguQCuwAvaaGZ+ofH+6lOKZPnFHLthE6pKxqoDbqHbOhTxZu3Z/WlZ4?=
 =?us-ascii?Q?SBb9VdTm4wvp/T3Z4eELEDJX1VVlG6mHnEJsqC8IHACXcxFOO0JrTk/Q1Zud?=
 =?us-ascii?Q?9Giu5uBshJPCW5h+ikBGk589Hs/GFibBy4AL7Nrxxt7nq0Q6MFPDsyF942p5?=
 =?us-ascii?Q?NAyQFNMvO/k03BfOsvK7dZOokH39kx/fZcK1+1ww6asqo+LYBeo/TvSwjv6x?=
 =?us-ascii?Q?jDWMQRvGxRnhDm/OB/7u6exMUWbCyD38likWm9enmO66DQbpytzkUtP/Eyd1?=
 =?us-ascii?Q?y+Pfg/a+LX8i1FgA+STgr8jtdPbzB+28TUiExuU3I1SDHXNNxmo1IUlnG4qU?=
 =?us-ascii?Q?8M9Wr2aI6aSCeuf04ZrE6fx7Whc/7GQVtJ0ztng7bBYdSkWGVJ+RyqhLQozQ?=
 =?us-ascii?Q?XG4w7aYnk45W2Mt5hb3++fE7g9LjI3jfoJJw9UHoN6EcZm+a8oWJPfcfYcaN?=
 =?us-ascii?Q?Cmp6FHjEe3sKD3LznoDpksbP5wdyV07oNakRzZLo5MVkiW6JgK8UB5OSa1QD?=
 =?us-ascii?Q?vHZQeAlHOeI+tzb9ADa/YfhY5c8p+yFDsUhcHsuZuFE5MfTmNyVp+N6c+PY2?=
 =?us-ascii?Q?fimFKE0GrkY3vQ5n0MpmYZWnXLhwqEmPBeujqg9KZyOr8LvheNJQfgRnAAra?=
 =?us-ascii?Q?avUIFOCWtJ42xVAklIcgoCPGcpMutIL+ofwGOuLTq4ubxtg/mf+I5c35hD/6?=
 =?us-ascii?Q?+9hFgxf1Rr6vRtqNo1KsN6vagK/3g+0KbnDdVqetxJv6SHlEKzohNBPRHmTw?=
 =?us-ascii?Q?ca9/wDGzMNU1qrXcmD4gfTEj4s1xgjjdLoIler4v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbbf16d-58cd-4521-7aad-08dca606b1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 02:18:06.5095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKzFPI1BK9A932iy2AFnyHwV97GSiwPqe4UW7+TMttvQtkDFgZcTJUO8+s9MxtShzzoYY7OPFG5XkX/oVEPE5rZJBU+twnvYWbc+T8tydUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
>
>There's generally two modes of operation for IOMMUFD:
>
>* The simple user API which intends to perform relatively simple things
>with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>and mainly performs IOAS_MAP and UNMAP.
>
>* The native IOMMUFD API where you have fine grained control of the
>IOMMU domain and model it accordingly. This is where most new feature
>are being steered to.
>
>For dirty tracking 2) is required, as it needs to ensure that
>the stage-2/parent IOMMU domain will only attach devices
>that support dirty tracking (so far it is all homogeneous in x86, likely
>not the case for smmuv3). Such invariant on dirty tracking provides a
>useful guarantee to VMMs that will refuse incompatible device
>attachments for IOMMU domains.
>
>Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>responsible for creating an IOMMU domain. This is contrast to the
>'simple API' where the IOMMU domain is created by IOMMUFD
>automatically
>when it attaches to VFIO (usually referred as autodomains) but it has
>the needed handling for mdevs.
>
>To support dirty tracking with the advanced IOMMUFD API, it needs
>similar logic, where IOMMU domains are created and devices attached to
>compatible domains. Essentially mimmicing kernel
>iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU
>domain
>it falls back to IOAS attach.
>
>The auto domain logic allows different IOMMU domains to be created when
>DMA dirty tracking is not desired (and VF can provide it), and others wher=
e
>it is. Here is not used in this way here given how VFIODevice migration
>state is initialized after the device attachment. But such mixed mode of
>IOMMU dirty tracking + device dirty tracking is an improvement that can
>be added on. Keep the 'all of nothing' of type1 approach that we have
>been using so far between container vs device dirty tracking.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/hw/vfio/vfio-common.h |  9 ++++
> include/sysemu/iommufd.h      |  5 +++
> backends/iommufd.c            | 30 +++++++++++++
> hw/vfio/iommufd.c             | 82
>+++++++++++++++++++++++++++++++++++
> backends/trace-events         |  1 +
> 5 files changed, 127 insertions(+)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index 7419466bca92..2dd468ce3c02 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>
> typedef struct IOMMUFDBackend IOMMUFDBackend;
>
>+typedef struct VFIOIOASHwpt {
>+    uint32_t hwpt_id;
>+    QLIST_HEAD(, VFIODevice) device_list;
>+    QLIST_ENTRY(VFIOIOASHwpt) next;
>+} VFIOIOASHwpt;
>+
> typedef struct VFIOIOMMUFDContainer {
>     VFIOContainerBase bcontainer;
>     IOMMUFDBackend *be;
>     uint32_t ioas_id;
>+    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> } VFIOIOMMUFDContainer;
>
> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>VFIO_IOMMU_IOMMUFD);
>@@ -135,6 +142,8 @@ typedef struct VFIODevice {
>     HostIOMMUDevice *hiod;
>     int devid;
>     IOMMUFDBackend *iommufd;
>+    VFIOIOASHwpt *hwpt;
>+    QLIST_ENTRY(VFIODevice) hwpt_next;
> } VFIODevice;
>
> struct VFIODeviceOps {
>diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>index 57d502a1c79a..e917e7591d05 100644
>--- a/include/sysemu/iommufd.h
>+++ b/include/sysemu/iommufd.h
>@@ -50,6 +50,11 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp);
>+bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>dev_id,
>+                                uint32_t pt_id, uint32_t flags,
>+                                uint32_t data_type, uint32_t data_len,
>+                                void *data_ptr, uint32_t *out_hwpt,
>+                                Error **errp);
>
> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
> #endif
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 2b3d51af26d2..5d3dfa917415 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -208,6 +208,36 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>     return ret;
> }
>
>+bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>dev_id,
>+                                uint32_t pt_id, uint32_t flags,
>+                                uint32_t data_type, uint32_t data_len,
>+                                void *data_ptr, uint32_t *out_hwpt,
>+                                Error **errp)
>+{
>+    int ret, fd =3D be->fd;
>+    struct iommu_hwpt_alloc alloc_hwpt =3D {
>+        .size =3D sizeof(struct iommu_hwpt_alloc),
>+        .flags =3D flags,
>+        .dev_id =3D dev_id,
>+        .pt_id =3D pt_id,
>+        .data_type =3D data_type,
>+        .data_len =3D data_len,
>+        .data_uptr =3D (uint64_t)data_ptr,
>+    };
>+
>+    ret =3D ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>+    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>+                                     data_len, (uint64_t)data_ptr,
>+                                     alloc_hwpt.out_hwpt_id, ret);
>+    if (ret) {
>+        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>+        return false;
>+    }
>+
>+    *out_hwpt =3D alloc_hwpt.out_hwpt_id;
>+    return true;
>+}
>+
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp)
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 077dea8f1b64..325c7598d5a1 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -212,10 +212,86 @@ static bool
>iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>     return true;
> }
>
>+static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>+                                         VFIOIOMMUFDContainer *container,
>+                                         Error **errp)
>+{
>+    IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>+    uint32_t flags =3D 0;
>+    VFIOIOASHwpt *hwpt;
>+    uint32_t hwpt_id;
>+    int ret;
>+
>+    /* Try to find a domain */
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>errp);

If there is already an hwpt that supports dirty tracking.
Another device that doesn't support dirty tracking attaches to this hwpt, w=
ill it succeed?

If existing hwpt doesn't support dirty tracking.
Another device supporting dirty tracking attaches to that hwpt, what will h=
appen?

Thanks
Zhenzhong

>+        if (ret) {
>+            /* -EINVAL means the domain is incompatible with the device. =
*/
>+            if (ret =3D=3D -EINVAL) {
>+                /*
>+                 * It is an expected failure and it just means we will tr=
y
>+                 * another domain, or create one if no existing compatibl=
e
>+                 * domain is found. Hence why the error is discarded belo=
w.
>+                 */
>+                error_free(*errp);
>+                *errp =3D NULL;
>+                continue;
>+            }
>+
>+            return false;
>+        } else {
>+            vbasedev->hwpt =3D hwpt;
>+            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+            return true;
>+        }
>+    }
>+
>+    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>+                                    container->ioas_id, flags,
>+                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>+                                    &hwpt_id, errp)) {
>+        return false;
>+    }
>+
>+    hwpt =3D g_malloc0(sizeof(*hwpt));
>+    hwpt->hwpt_id =3D hwpt_id;
>+    QLIST_INIT(&hwpt->device_list);
>+
>+    ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>+    if (ret) {
>+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>+        g_free(hwpt);
>+        return false;
>+    }
>+
>+    vbasedev->hwpt =3D hwpt;
>+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>+    return true;
>+}
>+
>+static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>+                                         VFIOIOMMUFDContainer *container)
>+{
>+    VFIOIOASHwpt *hwpt =3D vbasedev->hwpt;
>+
>+    QLIST_REMOVE(vbasedev, hwpt_next);
>+    if (QLIST_EMPTY(&hwpt->device_list)) {
>+        QLIST_REMOVE(hwpt, next);
>+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>+        g_free(hwpt);
>+    }
>+}
>+
> static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                           VFIOIOMMUFDContainer *container=
,
>                                           Error **errp)
> {
>+    /* mdevs aren't physical devices and will fail with auto domains */
>+    if (!vbasedev->mdev) {
>+        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>+    }
>+
>     return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>errp);
> }
>
>@@ -224,6 +300,11 @@ static void
>iommufd_cdev_detach_container(VFIODevice *vbasedev,
> {
>     Error *err =3D NULL;
>
>+    if (vbasedev->hwpt) {
>+        iommufd_cdev_autodomains_put(vbasedev, container);
>+        return;
>+    }
>+
>     if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>         error_report_err(err);
>     }
>@@ -354,6 +435,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>     container =3D
>VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>     container->be =3D vbasedev->iommufd;
>     container->ioas_id =3D ioas_id;
>+    QLIST_INIT(&container->hwpt_list);
>
>     bcontainer =3D &container->bcontainer;
>     vfio_address_space_insert(space, bcontainer);
>diff --git a/backends/trace-events b/backends/trace-events
>index 211e6f374adc..4d8ac02fe7d6 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t
>ioas, uint64_t iova, uint64_t size
> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas,
>uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping:
>iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64" size=3D0x%"PRIx64" (%d)"
> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>uint64_t size, int ret) " iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64"
>size=3D0x%"PRIx64" (%d)"
> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=3D%d
>ioas=3D%d"
>+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr=
,
>uint32_t out_hwpt_id, int ret) " iommufd=3D%d dev_id=3D%u pt_id=3D%u
>flags=3D0x%x hwpt_type=3D%u len=3D%u data_ptr=3D0x%"PRIx64" out_hwpt=3D%u
>(%d)"
> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=3D%d
>id=3D%d (%d)"
>--
>2.17.2


