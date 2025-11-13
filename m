Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F25CD5BA7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 09:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJTMx-0007YO-V2; Thu, 13 Nov 2025 04:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJTLu-0006ni-7l
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 04:11:06 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJTLU-0008JD-HY
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 04:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763025024; x=1794561024;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=k7YdRRErkzP8x25uHjbjjQGp9ng97dAkEngG4n6nA6Y=;
 b=mRqXE7ZE0jQVEWFvByZEAkAGZlJ3uEvTl8qqTyvm3V340ajgLTI6jDbi
 NDlUVYBQx6tkc6UyM4GcFeDvgrfSRvnMPxoeiQMFre9Xi9yCH+3DQCdK/
 K65TRVKkqweAkP6GrIMzTAHmEPQQ/+kiHSOeKMMaHH4aRCpqhqr7uE3I/
 8i+bKzh5FOLHWSIS/unWljpmYWpI3XhDiAqtRmmcsRrd1IT3kUq9lXOCp
 xtgnY0j2JQtXBPnsvC3MzUdfqxMzminlOx0Pgka/wA666U612SAv/ZciF
 BIaAY+zxIHQvExSuX4T7s1jPquCNcmigFMLx2j3YOddAx61MyaATlEj7R Q==;
X-CSE-ConnectionGUID: JwC7UMuIQA6ZzoLvZsedaA==
X-CSE-MsgGUID: 2s3wVsuYS0ujt0r0l/Z6hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76560505"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="76560505"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 01:10:22 -0800
X-CSE-ConnectionGUID: 2Wh9P/GUQvuLuh8x33rBOw==
X-CSE-MsgGUID: lOdpa7pbTvWS/kZGZ49K1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="189468991"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 01:10:23 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 01:10:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 01:10:22 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 01:10:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMMAn2+DB0w7nAlFogHP231KK3gJ+3CfbTBbY7L0ThP1T1hU48ZX83IzETavB3OGQlU1gtOda6YszGssXiDw72g8/qqI1QPjmFoDvi8JoEuz+wKrG6NUjmLFKcsslTRu+8eQftc6SIk8zQUG8Bu6eZTCfuQy1g4arRoid8rFE1eKl5tmpFABy2/vEP7EZMAJnreoaWgQymTJ0KPWRHAbIxP8YqyKegolpOQKeADOJ8mawrFSuLExFvMrLUPoY3b4n1H7wU4wPVAPzwdna0Zb6FZZB5dKzfZLdfEFEXKAb86mtVf5KnbG95Tj1XM8JXmaaRzaD7PRQcXhOVV6nLJdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1T51Pl1NRFsmglagQQK23gv/JLqbL4iWlOlpzGje6g=;
 b=O/D9YMrTMjB0oAkSOug5C4OAWZAQZbDN0/gLZvExj62FFYII5t8ctpzhUaSUJLpK4QBnhr5AduK778iaaq9NirMg27u6J7mNDOHLoFIjwocJMl6UDKB4Hp/6vK6m5+Zu5YKvKNHRvfvAvfH2TdWNOLAF5Mp7QPScZv4pWmLdwEIhzYvKjtgc7E/vsteXOlJoTpy8WFIeMDxGVI+QwVC5nt2TOwLA5q2zsv6WNmpJODEqfWVUxSQfq9SJL6b6vTOTFC+bPglPPJJSHxmyAcdR8HWkUm3IUtOCgAPWswOQY5p83V21CGVjrmYtojJDg55g8uzaHFRCgwXYprrRMyWtbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 09:10:20 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:10:19 +0000
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
Subject: RE: [PATCH v7 20/23] vfio: Bypass readonly region for dirty tracking
Thread-Topic: [PATCH v7 20/23] vfio: Bypass readonly region for dirty tracking
Thread-Index: AQHcRMKimVkPfv3WFUCRrYMqW2yT17Tg/DMAgA9A5FA=
Date: Thu, 13 Nov 2025 09:10:19 +0000
Message-ID: <IA3PR11MB9136694AE9995DCB7301887B92CDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-21-zhenzhong.duan@intel.com>
 <8b344a67-3017-4bce-9482-09b957eafd2b@redhat.com>
In-Reply-To: <8b344a67-3017-4bce-9482-09b957eafd2b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7574:EE_
x-ms-office365-filtering-correlation-id: b0d63be8-eb88-47cb-73a0-08de229477b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LTe1u5V2tIyPs3d6qUKTpnzU8TJDrpFWAIr9dl4ofC7suITO3DR8804OiJHs?=
 =?us-ascii?Q?B/9bcnwOTeaux/9TnBmdXeD4zjjBD13eSWWlqGmXZ2i1GRtNP9RKEtXSV2Ly?=
 =?us-ascii?Q?4cO5UvFDJAPL0iObDsg9P7U+0sJMHxv1MTpZOgaSwLlLiiWf0LrT1eInjai/?=
 =?us-ascii?Q?pFkAvY8sdcEPc8cDDJzx0ulW8aLYQZRuMKmLXYnWa2NzbWwXKqbh88d9uLar?=
 =?us-ascii?Q?MA/AnKfMGbJLRB+X4JmfqajGNum6b/Kf/42keNsEo67S2Kqre6D65l7On8dl?=
 =?us-ascii?Q?3NeP57X5PUaIvFs3lAWDpng9fxfd4pGUk+TPnKa7CoXYJCFbdvrBKjM12nNa?=
 =?us-ascii?Q?JvMWzK2TrHcUPkWQ7kgJUg6VeCflUyYrgN9Cq1wI5C+ZmEyvOOzdypt9A2JD?=
 =?us-ascii?Q?UizzLlYuNY0KKZ6u6vJ8jqKU70VJma5t9W6KtlKKPlPDxfAmA0UWKk4Q/dhf?=
 =?us-ascii?Q?JCIUN5EUk2Hyy0wpuQAx124Cwo3roXGKlLTLXqRPTsz2Qr2w20bfZsZW7FsZ?=
 =?us-ascii?Q?MxgQFnWcqPv3D9uFlBnZ1IBDS+vDIbipPmN5LyTZVt8zaQkH1RwfYmXl/s9D?=
 =?us-ascii?Q?QXbwXrfu+ESalsHf4yMSD+5BvzeF8dH3f7dRseTmAnUxim1pJub1Aj2oeXe3?=
 =?us-ascii?Q?mHUrFPHDjbvIgBqUiKYN1tzgWU4P0uO+g79uBewQpidTu6H8eWjEfCqvZH4T?=
 =?us-ascii?Q?iGQzI0JdWm5cp+VSReRzbD7bfxEySCy4loM8zCJ9+O9ah7zZPxGxkBVNouKM?=
 =?us-ascii?Q?RiGc3oSWRrheYrmYeib7XVo7CS1REWBdpWZfIz8EFmhDILHAcjrH8YpkBNvP?=
 =?us-ascii?Q?/uuj6mag6PW1soZV6ZJiygNb5PZiRSxY43qkb7NwbENvNEFgaPo43uAunR9U?=
 =?us-ascii?Q?mYqqm1lSWmZHaDFA+1k6B6ojXTKtDe98Q3C/DlO2z5sZsA/Vp8OgP9fdJXJb?=
 =?us-ascii?Q?v3Va1pJ3Y4Xx53+UMCNSpDRIlGz592Ym4ItM+mYilUSlY+lPoSuYWytGohtZ?=
 =?us-ascii?Q?1170zvDm3wNDAodjYAxTSeBaEiF5Ps2UoFCS6xosyJ+kc3g7IDq3g3ryEv3g?=
 =?us-ascii?Q?6zEv+RG8a8/QUBoBKWoPwYAljS8Mpx7vkG2HNGao0wezfXSENS8JpaP3u9Eq?=
 =?us-ascii?Q?N24HuFFo2+js9k/jo2o9YByvhkGKws6xclHX1V1CMZa/OPTZI5Qf+TAwHKde?=
 =?us-ascii?Q?KcSpM4Ecx3iG5UUrkRC5r5Kxj02+JGEoQCTk6A1sVb2m9nNgh+N+/E7hHDlF?=
 =?us-ascii?Q?Gl9K/XfvKIo9aiUcg+Zk7Z0mWw+3yUs9iEZAkUC0BfyVEQTZun/Js9+4zMXT?=
 =?us-ascii?Q?KKZ9dhBiwKB6UX00YUG9fL2XdndwqrA9q+ZINR72MSziy4lDyV7I8+RWhi4t?=
 =?us-ascii?Q?Lj56QDJ8KBleIsh7MUOqBeIpzBdnkpgnUNKFU6c0+nvkd7LwBapyN+/lcs5i?=
 =?us-ascii?Q?qvZcaoC0hwTKf8/JYCQmNiC7Xt/5BtHTecG+ZQWMBgSh+Ob94b7So8CKVU/F?=
 =?us-ascii?Q?8IXs+yNY0cVpacQkNzXT2+9HFT5MSheRo7W/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b2kC3DTlhbn6llgjlS1IGGNIzGwr19JJ+Cg7EL616AmlFgye+l5ZeZWdpCyc?=
 =?us-ascii?Q?GOE2BFBLDxM4ezcVgOmKLGcEVx4iG0yxNd4gG1e0fvndr44XvSvsU11Yq/UP?=
 =?us-ascii?Q?jgs44F9TXY51XutjWLRLcYHa+T1j1O4MA9I/3kHFQvgTE0UBMQegFF0MFoBG?=
 =?us-ascii?Q?IQKWSneKq+KdKavkf+1r2JfUYz50PfCJjoUtTKGaU2Q4ov7vd+iCKFYkQcIK?=
 =?us-ascii?Q?h9IwRn7wdg+N9C2sqf1rwGXG5L8NEaXCHUQlVEif0spetgxzYhBlLX+RMvKn?=
 =?us-ascii?Q?GyA1FfWLYFwIvgWknO14sW1edIT7IhPWnvHoufcTKCnxJe5L9Nty6oE9GMZP?=
 =?us-ascii?Q?nOh+0IKuRghBM1TWYp4cfcw0keb1oBflhYFNgFsZmBAEzdhoax0SuD7YyTHY?=
 =?us-ascii?Q?yhYreUflRhdnH+/6o8r+LPeg6youpJl5qO1gJ4U6Erl36VAyTAm5zvey5dVD?=
 =?us-ascii?Q?fG9rmLPcYwG9SRIlw4f7If5nSWg5eUV/33Z9Jsvsd6APqoqwi2gz56M4fLC6?=
 =?us-ascii?Q?AjCP/rwpJh0pXY2n0Om8kWP581myODN1uJvV4Vrna0BzQYWZ2oq2kc2k+dJn?=
 =?us-ascii?Q?3OYeC6OtkrsmguWzlTZD0LSZARWkYfYW4Hs6cDnwa4hE/CQe09TheOfdcX8Q?=
 =?us-ascii?Q?dD/P7XzzCe+ECO6zoM/7Nby0rn1Zfaw1fA7giRvWdy44by+ZgEyZaBeA5NWu?=
 =?us-ascii?Q?+pBLKZNfa6tPgCr7avtema+FK9nuBYHD1d6KbLUZTBird0IdZs+t4AVpysM3?=
 =?us-ascii?Q?Wo2Aq9fj4lwxwZtDjDZArYZJj2Hw3Ug98NZuO99Ad2IpVOUbrITz0L1MsbKT?=
 =?us-ascii?Q?el07fW0PLkoMGjrzljTaXSk/RI0vMUWv9gllJ8NDYeneS86KItgjjAagLRvf?=
 =?us-ascii?Q?9hi5eUnvqweOcd0o0qcZIMBDuMjxwmxJQo4T802LwLZz4GGJHFBYaVBrNkQr?=
 =?us-ascii?Q?dIpddr/jTDJtgOIJCAKStZbzUVilcb/L/1rICTb6SPeOULPQhXKE1fDvINrU?=
 =?us-ascii?Q?x/XL+plLH2AWzLH+TcKtvEyS+eAlfEdhzncGE1xHrLs0YZ0n2xeHGoB3O7dN?=
 =?us-ascii?Q?gRusKYaO1HhCuA4zJ/7UftSyI8Vz68AmBOTNMdDVUXR7Eyyt9JaN1fKoQQqB?=
 =?us-ascii?Q?+XnedDeP3Rg/DjlPxb/4XwhszYW7B+9INr/5M6XpkyO+guzqcgPRA+qMdhxZ?=
 =?us-ascii?Q?EASNN1jTEZwyFTVfKEoC00OEnwlMi9Rp1OjrXYehZbj/Tyy1cUq2u3KvTkNi?=
 =?us-ascii?Q?zWK2UB0tG0b/6l2bxzEh8VhRWZgZO1R1dMdGjb2moOKB1q2vVWCCGMcJ8eDP?=
 =?us-ascii?Q?+as8CTWrg7m4vGWLS9LV6n9uWS7GRlvt99NdFYBBIIqwQO4iqyKHJcx/pD9t?=
 =?us-ascii?Q?793rKBFYPTG9Oh/hYKbc9/zWUkkyrVrEmNZdIuSOWUSz2iWuOgmuyliDQTrw?=
 =?us-ascii?Q?10+1iqn12DiIOeVc9y3nTUjAVesuk63Jmo/D67yjdB5ylbw/6+X76ZtLIB1L?=
 =?us-ascii?Q?P6AlO5+XUej/lUH5aZ7PPWZlO8yBx28TGuQgo155pOsW6DOz9LAl45llOTVB?=
 =?us-ascii?Q?dxvZmQjtLvl6tqtxkl1/ABnuInem79/o49o2QoIN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d63be8-eb88-47cb-73a0-08de229477b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 09:10:19.2190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vHReRmnrDWE16WKCTPX8dvd1/qK2tFkJhreFZr2x9BRFO/8UwwUsK/x02vJfJBSU4itP5FERV2B4QSNqqx8igYkh95PcfJ7EhnYGHL9vfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH v7 20/23] vfio: Bypass readonly region for dirty track=
ing
>
>
>
>On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
>> When doing ditry tracking or calculating dirty tracking range, readonly
>dirty tracking or when ...
>> regions can be bypassed, because corresponding DMA mappings are
>readonly
>> and never become dirty.
>>
>> This can optimize dirty tracking a bit for passthrough device.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/vfio/listener.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index 0862b2b834..cbd86c79af 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -828,7 +828,8 @@ static void
>vfio_dirty_tracking_update(MemoryListener *listener,
>>          container_of(listener, VFIODirtyRangesListener, listener);
>>      hwaddr iova, end;
>>
>> -    if (!vfio_listener_valid_section(section, false, "tracking_update")=
 ||
>> +    /* Bypass readonly section as it never become dirty */
>> +    if (!vfio_listener_valid_section(section, true, "tracking_update") =
||
>>          !vfio_get_section_iova_range(dirty->bcontainer, section,
>>                                       &iova, &end, NULL)) {
>>          return;
>> @@ -1087,6 +1088,12 @@ static void
>vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>      if (!mr) {
>>          goto out_unlock;
>>      }
>> +
>> +    if (!(iotlb->perm & IOMMU_WO) || mr->readonly) {
>> +        rcu_read_unlock();
>> +        return;
>This change is less obvsious compared to the others. Might be worth
>explaining why you add it.

OK

>> +    }
>> +
>>      translated_addr =3D memory_region_get_ram_addr(mr) + xlat;
>>
>>      ret =3D vfio_container_query_dirty_bitmap(bcontainer, iova,
>iotlb->addr_mask + 1,
>> @@ -1222,7 +1229,7 @@ static void
>vfio_listener_log_sync(MemoryListener *listener,
>>      int ret;
>>      Error *local_err =3D NULL;
>>
>> -    if (vfio_listener_skipped_section(section, false)) {
>> +    if (vfio_listener_skipped_section(section, true)) {
>the false -> true change might be squashed into the 18/23 patch while
>explainig why you set this value.

OK, will refactor this patch and patch18

Thanks
Zhenzhong

