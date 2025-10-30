Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D56CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESN7-0001KB-75; Thu, 30 Oct 2025 09:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vESN5-0001K2-MO
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:07:19 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vESMv-0002qk-CO
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761829629; x=1793365629;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4KloIONLy2832J2E6LXi+eRae1krtkJifecfPoGM0fU=;
 b=g8mgD05WaL/ZXbM2j6j9m5voUlIhz2NCDPPlfynEh+akczLYuZCozGx6
 wMzRNhvb0STmwAtuqO6vDrdSEqlJxYosiQofLfU22Y6RO1ZhslBVKSnXl
 m4CizK+yMWX2k0YsrP2C8Nn+xYw51QZ499i2CN+7HXBsLcT6Hs+KjfJmz
 PgRXf5RRyN4DQBRQKiOjCQJR+j+7Gg0ihHh/gVBfB1L9m80F00Jo0AoJD
 008XCudGKxYGZpgfNTMyrEnUm5drWVtYQVjcIdihAPSi0lPAIl/K02jNk
 UN7nQYxjmQ9cLqlo6BcZenuejEiQrlNZj9o4TxeOLH6RYk7fd8uOqUqBf w==;
X-CSE-ConnectionGUID: loYZHahwTie/Eu90XKjdfw==
X-CSE-MsgGUID: hV6A/w2wRqOI4ZjK6BI9QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74568859"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="74568859"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 06:06:59 -0700
X-CSE-ConnectionGUID: WZkVD3abRce7EKvPyRPApw==
X-CSE-MsgGUID: GSQV5jAWThaBYAYKE2RHmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="209529310"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 06:07:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 06:06:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 06:06:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 06:06:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEdeb1I61arCltG247DAcZ3IiJv5iH1IMVPMv4qNGNT6nvK2nlAPqecdIzxEFs6uHg6UKHa1oTlcB0unINVVMl0hs7OKvdY/N+bESyeqVWn1BEUQnrVf2ooo9/9C8QZqQFsFovphkfajSjSGU2bZ2/5XLsQiIxl80xNXNR1gJXoOIykQvDpRbvGyTf+yjhgJCDwaDdmgPnwZmTrUjUTzxB+ixdPorcm8FHpNyoD8t4HIn3gDlrQeRbI04jJnJPeQjD44G40f8dkjMHZ0yqN5ZhWOU107S5iRDH6l2nHmv3GxubYuNkGrCYXmjhnDFRTMNizzz+I0Kw0RgraLsINm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KloIONLy2832J2E6LXi+eRae1krtkJifecfPoGM0fU=;
 b=QirpBLvbAHtDcWPXC3OE1BdncC5v5wRU2XJ6/LMuIVSFwWC+191ajTS/l/7DtKUi7BMEWvaYZ845AOb/EPybJUa2Q3L7Je3nAq87xgsSPh7K8/uknovA6MiODGMa3R43ZQ9iV1IMH6r0PiWlgbnH4EiExun9KUj7vqtIurtJm34o/46VoYEeRxkXyX5bDTXSmWRuUQRQ6iTvZtqhb5A1FzjX9dB6JdNZR9GZUHVaA3rgsJZtowK2n4Ddli46Ewivh7fXoeaACJkbgr7xbEAz8ipUvGGEzNqZgeGW5EuDSEnFYTupQcIgT9/LoP9sw2Qtr7UIEhoFQCYygQ1ay2X3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 13:06:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 13:06:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van
 De Ven, Arjan" <arjan.van.de.ven@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
Thread-Topic: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
Thread-Index: AQHcSLoYic5r0GqRiU2SGu5DZpxfKbTaWxAAgAADbcCAABzFAIAAKx3g
Date: Thu, 30 Oct 2025 13:06:56 +0000
Message-ID: <IA3PR11MB9136D46E2ADB556BBFA68A1792FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
 <20251029095354.56305-9-zhenzhong.duan@intel.com>
 <eb2e5419-7a63-47be-adaf-e34709d8310f@nvidia.com>
 <IA3PR11MB913625D418E023D14D4ED0CF92FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <fbfe567f-c8d0-4342-a593-efe48d7050ad@oracle.com>
In-Reply-To: <fbfe567f-c8d0-4342-a593-efe48d7050ad@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB4939:EE_
x-ms-office365-filtering-correlation-id: 857ce87d-c4a9-48e0-8d84-08de17b53438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?4p72Hcgwt9F1Pa5P5b4GptY5QTKZdkEXtcT+9QM4nso8ahik26meswsluaX1?=
 =?us-ascii?Q?+lYBP0Zg+bbQstx/3ccuqedJ3fhhbt66XK/8ic6pQIpmddHxw//rGX8LGq+I?=
 =?us-ascii?Q?xBMFzqHR0P0c8UxfHUt6ZTh3UpfYYi/8Cy1Uvn/yVGz+lDQ8ZqqGeS/pWA3A?=
 =?us-ascii?Q?pvyW76Haq3x8l3o48/vzVnEAMutu6fPoG3tMtH3hoL27xTy/k3U//zXb3/o2?=
 =?us-ascii?Q?QiuRxzvqLbmPTjvRWON5P9UQLhq2LNlE6VfN4M2HPwSUPO6kzSE/6NW0DZ5g?=
 =?us-ascii?Q?XRGpPVlpXaLAm+PWZLoJGO2A/Bm55eNoAygchVxzQIX5qpouLa1BT1nzZaLv?=
 =?us-ascii?Q?QRwFXPPymvdPrKyVApW2zVoAv8tuhnUC3EZNXgLteEUi+XwSOSiiKd+/f2Io?=
 =?us-ascii?Q?hv/vLHYUmxCPdgH3ANn0UZZrNxkH6qW0oQhsyFlHRog7VKeNqPUNLXFGH0OR?=
 =?us-ascii?Q?b4WoLuQ4Kpd1TRmkno6cCYVQaeA17Y7y1eW5NQ7NZFver6PHW8F5V1Vmk/ai?=
 =?us-ascii?Q?C3QdLUgTdfA0g5zILDwerwu9PNR07adB6lMqKIoZ6tUedzGXUmV1uVx9YFFo?=
 =?us-ascii?Q?TqNHWPB5uE9eOKDscyavI2YYXF+sQPPhjXN+LfeeEHQGHGIYgL/kUfp4G2Tl?=
 =?us-ascii?Q?lvV48Wb92h4iinjZQjzGFn1+hIsm9Lq2YaMXDgRD8thT4ndehuvibPBCPn6E?=
 =?us-ascii?Q?7Jg7PpxvoV8c42/d+l4/qEg/RLh8jy0x3klLtTwlBsnmqKLZweOk3kwPc1Vs?=
 =?us-ascii?Q?nZamFoIlgrzj2yg1iLJGQRjXuuCce+VqdYW9xbInSXihQUdEQK/WrSbGTcZJ?=
 =?us-ascii?Q?/Qwcx/Jw1AkIii6l/BjqiOnOHZOinWCNXAzqn8z6OQIw3rl+zGVeIgqCtqAg?=
 =?us-ascii?Q?vJ5rzMmVb0jEQAuhTpCgf/9xA9LUGVj5BkcHl2++vuy/z0tXXmbdvt7L1SEm?=
 =?us-ascii?Q?He3Hc3/uikAzT9XgLDf8/CCqDNw9EmR93jzpLqgGNrV5yE9yq6+oRky2JWI8?=
 =?us-ascii?Q?+PWI/py4wEugSKSxZBqD8zfV9XAYJdo6kP0zHnRddawHXQSDY6PZ1Hcy7qNX?=
 =?us-ascii?Q?nhGjYi/2U0AaevhJI2dKUCCKRI+swiPCxMXiyQ8WjazV2G4OQAWifRYzrr5d?=
 =?us-ascii?Q?5Ma9VdGSrkSGY9swB+0JFFF3CfE5j59Gspl1nNc2586BGQ9i1UWpZudJ3wPA?=
 =?us-ascii?Q?HZfbrPjP8Th/tVBp2JwIKRnjVW3fEUAmsPsgSEFpL4rWxeQh6T4gPorCFq6H?=
 =?us-ascii?Q?4sP8N/5YJSAuVJxE0PMpCQhfhED3xZFTMJa09LLuhRVkQAE8Exv2SmL6G2EN?=
 =?us-ascii?Q?NNS43TfDpBCJl/IbYj+DKeidMsqGrwTNdSE2PDbx7x8LQt1r7eBgAQkkKMYM?=
 =?us-ascii?Q?Wj8kMpshESOj0QuLrl84UytuVvTx1n/3ag6sfvEntAC1y0gkNO4SUw7VwDMJ?=
 =?us-ascii?Q?uGknYczkEV4kd0NbTkqsNC3du1Bx/Kndyp+wrngB3jePulCCC40wzgD8NJky?=
 =?us-ascii?Q?RfrQFw2hzHe2N7uMXyQ42RrouVPGf/9iZz4I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9VhgHRT9QVM+4iXSDrEvhGd2VTxpZ+DpZBTJRf6MzAVxoJkounjZd+V1PvqC?=
 =?us-ascii?Q?FxlscjVT8OPm467QFcEHx4myeSDNxyzJXcHgkEXYfLsIAzmaYdUQwHfplqdQ?=
 =?us-ascii?Q?aHOUdoR8jCwXYy+4Vv+O+ErVwPMwXOzZofAqJV5NIHK8URLcp50U0tjAkKhq?=
 =?us-ascii?Q?05vElbGcbYoZsRlvbTU0UAyggIDRoYy2WXSMjYael9XMIjHTyRDW4znmI9jU?=
 =?us-ascii?Q?sQguuNuwT05DyfCqKUETymRPGkSprdpMmIbsiQy7WUPfQphttR5rBYUif8dc?=
 =?us-ascii?Q?/vjqB7ZA/+bKlDUb4EBB0gEEpfveCnZNBaDco4F/ynh3rP1MaauoqBcpFsom?=
 =?us-ascii?Q?P6GtgOdUcoyR1UnOdTlWHm/66Q9QnRxLBsoiTqNVypkvsFUpt5F5m/MTwSSp?=
 =?us-ascii?Q?oFhvbejxKwFr/821aiW91FfM03hkKl93jziYNcE0QEw/WHlaQB1lVFY2fewA?=
 =?us-ascii?Q?uyJWEaHN9jjYB7A4vtyWamvoxc7NyKjf9ZWDX6mNWTBup6KNSFMjLdmtTVBw?=
 =?us-ascii?Q?sc6AwInbgzWyZxpSq/By6wktzqDPUw9I+Ilv/DyL4V4nRf05MZdUMjVa+Gfj?=
 =?us-ascii?Q?hEHWlT4ASFDdWm4HYIglGp8uD47g47+Fj6Wf4ANw1f7GqKwF4GnBrEmXzzYv?=
 =?us-ascii?Q?T2dExEPdE2uQjo21r52umwtnSi5Esi6J91RClgC5iVYblT6li1BWinlYqJk9?=
 =?us-ascii?Q?fpvS9ak++WkNZD9u8DCSh5lPFZSIqe6jUkpBTpmBYcCa9PLcjPTjhX+5f5v6?=
 =?us-ascii?Q?WxHdK6x8hCdpB24DPCNIEFu/sxEu1RMYztqfKtwl4mv6Ftsl5drSyVG3HcJQ?=
 =?us-ascii?Q?aUR/A2NEGqbZijJARtCDBGrvtgRA2ERCcUu0SOFGj/hYRSo5q6JZcK3DjJox?=
 =?us-ascii?Q?ydlyDyBM1qelAXc16kTFaCfG1HOyZwQJMZXi0aUpr9wp8s8bBKqOQZ/43QSF?=
 =?us-ascii?Q?OG1397qQH2uo522U6fBRg0mEXN97wPpQU+0R4cpN49JMoNbXbCCctVO8LNOf?=
 =?us-ascii?Q?DIzLIIG0BOsimuhYUMacDPYxSzMgX+VfzMLK7uf5oRx8XDJx/Wgweped+FFd?=
 =?us-ascii?Q?Nec5OlgE9k+L6qcws2F+n9akHoFdCI/xVsV6fIf4Xj7//4GGes1ZbmJyYTTn?=
 =?us-ascii?Q?6sAwzoSikZOrgFo8XPnuOmAhX5D1QhD2Xv4mioCdMoj/ci7LOdTxutXlExKm?=
 =?us-ascii?Q?uWMsuzKMsUB4RK6a0zRmQNg/m7qg+Zv3AIWYX2Io1DO2igSIy6cfSmPLGY65?=
 =?us-ascii?Q?CS6jUV/s5yrJKXuJvvWvv8NgnMq+SU1EFQeIhnRro3I9BUow6OHJPoPee2QT?=
 =?us-ascii?Q?w5o0Y+c0ggcqsau7FWaDKLIKbUnmZsZVK1/7AEVL6sjAgR1AxTDNZFR3C5Kn?=
 =?us-ascii?Q?e2vvVMshZd9Gov9++B9o/Z1XqvzQSCTZen3FSB2kPNHQ4ob9uhLg7NUTpall?=
 =?us-ascii?Q?eunlphW2nxJrw+j1kBePMA++axAOlci8FvUM04T2nnylgMWmoh4sOycobhZW?=
 =?us-ascii?Q?72hH6BUEIomLzClEVMUwxnr55xbjoelxYRHiAfomflZ7jFZYcPYuczG4qlHL?=
 =?us-ascii?Q?qGpzcCAaqtIw/rzJeXZpe9zwnGqsY0BuGKsgugb9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857ce87d-c4a9-48e0-8d84-08de17b53438
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 13:06:56.5679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71ovI34n/Um5+w8y9Yp28vxd2hMRpc72NGy0jdDJIyJUFi3p7IrXRKGN/ZUC5KfCVnc/4SeANX6dmD5h3c8j34PtNoB/gYHbK3AdK/D4jjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>Subject: Re: [PATCH v4 08/10] vfio/migration: Fix a check on
>vbasedev->iommu_dirty_tracking
>
>On 30/10/2025 09:10, Duan, Zhenzhong wrote:
>>> From: Avihai Horon <avihaih@nvidia.com>
>>> On 29/10/2025 11:53, Zhenzhong Duan wrote:
>>>
>>> BTW, do you have a real production use case for migration with VFIO
>>> IOMMU type1 dirty tracking? I mean, is the scenario you described in
>>> patch #7 a real use case or you just fixed it for completeness?
>>> If there is no use case, maybe patch #9 is not really needed?
>>
>> patch7 is a real use case, in guest, we switch device from IOMMU domain
>to block domain and see the issue.
>> We need to send accurate unmap notification with actual mapping during
>migration, for both backend.
>>
>
>I think the real question is why you are using type1 backend overall for
>purposes of dirty tracking.

Just because we had set bcontainer->dirty_pages_supported =3D true, the dir=
ty tracking
by query through kernel VFIO type1 interface is used during migration, even=
 though it's 'perpectual'.

>
>type1 dirty tracking just returns everything in the bitmap as 1s. There's =
no
>actual dirty tracking and we usually call 'perpectual' dirty tracking beca=
use
>everything DMA mapped as write is always returned as dirty no matter what
>you
>do. It doesn't look at pagetable neither for the unmap get dirty.
>
>It's only (known) use has been for testing (in the lack of IOMMU HW +
>IOMMUFD)

You mean testing live migration or the legacy VFIO type1 dirty tracking int=
erface?
If you mean the first, we can force enable it with 'enable-migration=3Don' =
and set
bcontainer->dirty_pages_supported =3D false.

>
>But reading your statement in a different way: you are saying that you use
>*two*
>backends at the same time? Why would you do that?

I mean patch7 is needed no matter legacy backend or IOMMUFD backend.

btw: we do support a qemu cmdline with mixed backend, e.g., two devices,
one backed by legacy backend and the other backed by IOMMUFD. But I'm not m=
ean that.

Thanks
Zhenzhong

