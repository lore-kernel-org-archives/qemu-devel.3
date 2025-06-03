Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0B2C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQHE-0000G0-Nv; Tue, 03 Jun 2025 07:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMQHC-0000FP-3q
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:57:54 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMQH9-0000wy-Ap
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748951871; x=1780487871;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a5J2zymCRWrAyfFvT2/8xWUYOKpwUBOiua1DwLxowBM=;
 b=kYs8QzJLF+JRFMg5+oVq12aVza9DvPCbOYRFaEGVMXffKKXkjWrkgo0A
 yuxKwx+zdXt++PikCYns0+Pf4bo6rGMdAvj3PvOGWcBRIJ8OAPBOXhLo9
 DhZ1wGWy277FOzXPiRXB+AE8dRG5RwziOmthJ+y+vDz0kr/fcmCtuPP11
 +ziTstCUPy/IoDYQvKF/BtYY9FqczJz+ImqyxJSKf2ljbhsTVAuuIGteO
 6F28f7YDKCjQppP309R3VF7BY9oRxl/NnLT0ys14HRUr2oARDC1JOsfT5
 rU+IOTFeZaC/xlW6RssPPIGCGtV8l5b2/o3qbGCGIcy7jDi5DijH5n9CD Q==;
X-CSE-ConnectionGUID: FNN/eRudTrKOcndFqBCVAg==
X-CSE-MsgGUID: Tgjhuwt2TKuRo4RHyJlOKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68541574"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68541574"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 04:57:47 -0700
X-CSE-ConnectionGUID: oW1W6+0ySAClSrj+GslRXw==
X-CSE-MsgGUID: tu7/YcUeRPadI/rIg4RzAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="150127002"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 04:57:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 04:57:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 04:57:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.48)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 04:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBcr3254f+IOjB37lCOQ4z/YLhoQh9QEc7UBV8j7yCzOurdrLdcPCwTA/Le0s3yJMrq1rvoBhcqWhjYDpZ+c5hmmXHE2+tb0LaVtboBnbNySywO8OOxka/n+g0QuebHs5neJbAQpq4eX2jqcPDfB3nSbWQWnvdOx8l/Hf+c3Tc7euZ2IFjSlaIywrmfAgX7EQNJwR7A1dnjRl0cECTKThNa91obNYLJnnCielKiRjYxWw7WMS0TQo9Lc8t2X8D8IsiyTvS0tVG6ZACa3rOA/+Ir3SdlcAQk3zSQ3YNcW9501qYnpSszLRG/89fyczTNBS0M9KLdM9kh9aFP/x4sHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtBwWyDlMoplKGttREGMku0k9jJQMCrFLe+62QZBh70=;
 b=vqwPntPJl9+o9AQ8DzEN8DZE9oKVbJgD3pjq6sOAjgHPHvyjqONeVMu/uFLwT3YaF2I2jW4YSL4u/UFIj64pyGswuvtB7WJAcSaZDE/5Ln0uV9pAlJyePviy1wGFkptm2dmWCfD+kugO5YvMUAKBFfrzz+VKvP4qurl6J4YaIvazr7RJlMgx37JHs4j+aiXITH+2iS2EWGE4VoWfrLsd3FiZ2y0bK0AfpyYOPPb1OxgNZLBF2/slEM6lFN3fk4g3CO2qOePKhCGdbqOyH4g4OTPoJ2NqUcPpOAZjnlNIsUqAMvMzwW5WOWoQP761A44qFSMA8BrHr81qMUtm4Fg4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Tue, 3 Jun
 2025 11:57:17 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:57:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 09/43] vfio/container: register container for cpr
Thread-Topic: [PATCH V4 09/43] vfio/container: register container for cpr
Thread-Index: AQHb0M9dqpMcxFTPZEWAEOgVVzFwUbPxTXgQ
Date: Tue, 3 Jun 2025 11:57:17 +0000
Message-ID: <IA3PR11MB9136AF510081213140C10899926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-10-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1748546679-154091-10-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW5PR11MB5809:EE_
x-ms-office365-filtering-correlation-id: 88b65442-77d5-48fc-0c1e-08dda295c992
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ByDf+0Ik/CXnG8w2gUURuUGzIHPoikw2KqN0/OrRljtqrQkHnv2Ez+/fTnDO?=
 =?us-ascii?Q?jAqlVZ8v6z8FY+9jnOsv+9BPnXPNwV9q1GfR7UzAVUxkFz2LG9IodIHbZUgP?=
 =?us-ascii?Q?iIAEwkv9TJaPjUaq0jyw1s9+7e4SaVwJMMeUgtn0ZfzHu8tl9NncsxzkvO3p?=
 =?us-ascii?Q?l+TkLjv666EEwmp87b7euWtfbduFxaO4ZoLYntRWJjRO5GeG27KBy2xn/vaD?=
 =?us-ascii?Q?s5C8zi81ltlHgjOlcOQ9l+mAR+GTK31u7y0KHxJM9h12eMu/Pj1kOXbAZFdO?=
 =?us-ascii?Q?y7XM13+6NGamHOEUdC8vn4+G8tYY+Gf2j8LM3tHvBXKGvt1DR4jdOLMihWx1?=
 =?us-ascii?Q?UstZmkdNHtaKwrX2m1o2UdQqd+IY0QQdB0pBHzbKCHsRUMMUVflSQvdwceUT?=
 =?us-ascii?Q?ezmJIEVzkCp8lwFyIhpw/I0kMwJVI5n7HqCTu1UKg0XUfZwpRQTTEHL41R2i?=
 =?us-ascii?Q?nYeCBN2wotPotrwTpiWY7PlSJzFWvCSoVJxxT2R7qSKogclBp8aEI0ZfqrYS?=
 =?us-ascii?Q?Byz4YLS9HE7Tf/4Q+jDk74Nl7qntS47LH7CQqe8k+WOQRCLLOJqDRZqoazev?=
 =?us-ascii?Q?9ZAr1dMm3J/cye3ZAKkPvQQbyxg8jEvGA6p5KDOsrAqF7Hcl7Osa53vZpZRT?=
 =?us-ascii?Q?YRT7J9SHGrnr7XnxPMotRLTotGzSJA+tW+Sfk3G7Uj05On3jX/naLzmMaMbH?=
 =?us-ascii?Q?ECJBHrZNUjjanPUK5OZyb0LyqvCwxEzOxErJFW30XRrdiNZAJznK2D8bi/px?=
 =?us-ascii?Q?sNJ4mHTenD67Z/ubwsFEuRBdPnBJ548/2cxPOIY6PTvkrOH6lNGfAmknU9Fj?=
 =?us-ascii?Q?+w411+moO6wcZRmiG91h6wf2fD/fwe2bJlghxEXuMZ++9i+nkS/3sWopEroH?=
 =?us-ascii?Q?zmgcF4NXqCyrKDqIufsIi3v17N+VRZAno/Fx7+iWISGmoGsXGRTT/V5TBpUs?=
 =?us-ascii?Q?hxA3b6+zPDhHbvsUMW6k8v7PuRDy6NPgkc6QjPZaPeKQ+TGz0IsYe3LWoqDq?=
 =?us-ascii?Q?UfeqVrxhBZNONHSHQXnR9SFcqBUqdcKl0vvyIvlE/oACzof1lRo3yL1V64Qe?=
 =?us-ascii?Q?BT7mZIDlnUPiY2IbpAcUX/XJmUW1yK2Z1m/hF3a6wtllrfU8ZkpcRDOoOKDD?=
 =?us-ascii?Q?JUqOIAh5d2TurKi+COg0hy+7B6sXOy4eFG8GDxAppY2efPV+W5SfyI0pmjvy?=
 =?us-ascii?Q?j0GjhkiKN/zKifxGhoTlHaZvdU6hK/Nk2h84C22s19CkAcxG4nk/IAxwfj7t?=
 =?us-ascii?Q?k8PG9q5S96qJBd6rMoB3GwWDzroR5wamWETrkB8zAzniI03FpTOC1GpsOHfF?=
 =?us-ascii?Q?GgCY1eDu4EdKDjZ3GXsxpxWhvUYJ0CfWDEp1MVMcx5Z88MSbVTKKq2BbMkON?=
 =?us-ascii?Q?J3qa8IUFxe4FCQXk23WbuMZqvDAdtxANWlXqL375xUKOUEey72SU2OeODECA?=
 =?us-ascii?Q?v10MxqlYKlXRPSXlmI8YpIYwCKh/iPffa7nqVFBZWWHnpDDymz8Bow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bS+QPjrhaOBR8qlPhNRCVw5uAU6cnmFcBAUC0X7/JDCZpcgidPTykxiCeslv?=
 =?us-ascii?Q?Cd9+ePmuxF8/7+ny2ChI3FIG+zMXZ/B0N2W83fGQY33SFlApQNR+GbM5tPno?=
 =?us-ascii?Q?U7Ds+ZESy5XpJJz/H/HPVKYPDLXZPwxVITKDUF9AUBYaWCLqJwauxxPJxjBh?=
 =?us-ascii?Q?AFKEKOKbDr6A/z5/yW4ALVxyFRc9gs3gRodfR5ksQw5zeYM2cY1kTZKxxS7j?=
 =?us-ascii?Q?W8fcMwkRPlJ+ZXJSYF1C3kUSTLPhFpThnJ2DYzRPEHf/h71D9214pXq37pXx?=
 =?us-ascii?Q?QtMbgAVBmDZzGiNgPSSgbWz/Hv6KQSV+NfwXb+Bo18BdZIBNthR+xTdaPO4q?=
 =?us-ascii?Q?dIh5J1D852IBXmI7zRe6shijxtmQBaGoUn8IFxRC2FwWJvUFXix625YdIJoB?=
 =?us-ascii?Q?HWq/TUTJh8qK4tw+PDB15YWYOI3bQNG8g5L7nJQKtavwOUExZ3+vtjy1l5bL?=
 =?us-ascii?Q?oSJDltBbTuEZSwrfW1xT6dVu4Tlmxaqaa7iT5/b+zKSJrhMHAFc9kfOqQ6wQ?=
 =?us-ascii?Q?LPGTY9eoHbAoapi/xqbi6XeOjoiFYDQldz7M+88mHbpEoJW5lysdQoZ918PK?=
 =?us-ascii?Q?flFSEvXA4xMN8iEhV9SHIwlIIOrw41nTHy2/cYIIQpGjhfzS+VTswvUGHXKD?=
 =?us-ascii?Q?K43m1gbUZMCiRPWhoeH4U1eRD5yrfRj5GscRQUUymKN7d3TuazQYr6kHkm1r?=
 =?us-ascii?Q?fTxc8sxbZCC9i0GVLwKY074zOKcCj7Nff+xS7kbwqBjxCP6We/BqMX7JlS1b?=
 =?us-ascii?Q?ehtb5HRDE1MDgE3z88Ic/EQqTON/IbUD6krlPz0aYnCA2/pNG1f1B6wCIGiB?=
 =?us-ascii?Q?nVxERf4lH1R7GtcgVC4D/xMAScvUHfOZk0Vjx2J8p8qfD+kAheiyCksrGcQx?=
 =?us-ascii?Q?kjBg/Zalc/mJ3IAN7APdvNw/K2TJntLu5vAlQGaXxhYnyBcwR+ZMILmvTgkg?=
 =?us-ascii?Q?Oo8AuPY8udltyt6X4GoeS5c2bB9njr9TOVmSRkKeEHiiuQiDiXIAsggYfP0e?=
 =?us-ascii?Q?LVlDgue1180/Fci+0rGjn+PyYdvriz1vl5yrMC/u3NBeN95dkes8AEhWrDoR?=
 =?us-ascii?Q?73wqL36swNuvoMUzPXrQ7/1soCGsntKDFz8q9Gq6et5RdKlKWvxUvaUKjh+s?=
 =?us-ascii?Q?LWzKrWbFdXLqMkeKO/DWbiEPGinUd4d6doyd1bR8QGgSiCKbgSIg51OZLOPI?=
 =?us-ascii?Q?Kr6/GVqDsqEYbjFkD9isIrnRBf3qjlgCpQKAjdecv8LKbJllLLvw4z4ObcD9?=
 =?us-ascii?Q?69LTn+IM65mFwb4j2VpgfyJ9j4lfgnr/Zrj0k6Z4rLcplu/4kpETKGwE1NJA?=
 =?us-ascii?Q?YATMq2qR6uanwbQd0LC6sd2J68csf5ZalL+3JOMPkSLOhthUW1GFlws3G37d?=
 =?us-ascii?Q?fSsqa0/c87g6l1dBx9QGSoMECn6O6nH72oQCNraJXHn4LX6gSj4ugrnilHZH?=
 =?us-ascii?Q?d0ldSof7g8nhaFOby+HNVbO6CDyvFuEIZj09c9lLb8XSToLa/qQCCB2sVAKs?=
 =?us-ascii?Q?4B/Dhf3FuyZQ4Df8QanrHUDKR2Y7Vs1mrQ+gL0RU9HCsFMT92zyfvy2gQFiP?=
 =?us-ascii?Q?XadNRi8dh/HqIfaYLtiFzYcz7bTtkQmZvN+d5DM4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b65442-77d5-48fc-0c1e-08dda295c992
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 11:57:17.1573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYz1rWN4ykUdiTY/Yn65CLY9nu9hQuE2ikXiKwZg2Q4SVL7D+WF4GMh/9t6ml/NMQunCf1WH7FNPY7bQP9BdzYTA6Q5f61w9ngcVhK9f1Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
>Subject: [PATCH V4 09/43] vfio/container: register container for cpr
>
>Register a legacy container for cpr-transfer, replacing the generic CPR
>register call with a more specific legacy container register call.  Add a
>blocker if the kernel does not support VFIO_UPDATE_VADDR or
>VFIO_UNMAP_ALL.
>
>This is mostly boiler plate.  The fields to to saved and restored are adde=
d
>in subsequent patches.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> include/hw/vfio/vfio-container.h |  2 ++
> include/hw/vfio/vfio-cpr.h       | 15 +++++++++
> hw/vfio/container.c              |  6 ++--
> hw/vfio/cpr-legacy.c             | 69
>++++++++++++++++++++++++++++++++++++++++
> hw/vfio/cpr.c                    |  5 ++-
> hw/vfio/meson.build              |  1 +
> 6 files changed, 92 insertions(+), 6 deletions(-)
> create mode 100644 hw/vfio/cpr-legacy.c
>
>diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-conta=
iner.h
>index afc498d..21e5807 100644
>--- a/include/hw/vfio/vfio-container.h
>+++ b/include/hw/vfio/vfio-container.h
>@@ -10,6 +10,7 @@
> #define HW_VFIO_CONTAINER_H
>
> #include "hw/vfio/vfio-container-base.h"
>+#include "hw/vfio/vfio-cpr.h"

Now that we have this change, may we remove #include of vfio-cpr.h in hw/vf=
io/container.c?
Maybe this belong to patch8?

>
> typedef struct VFIOContainer VFIOContainer;
> typedef struct VFIODevice VFIODevice;
>@@ -29,6 +30,7 @@ typedef struct VFIOContainer {
>     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>     unsigned iommu_type;
>     QLIST_HEAD(, VFIOGroup) group_list;
>+    VFIOContainerCPR cpr;
> } VFIOContainer;
>
> OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index 750ea5b..d4e0bd5 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -9,8 +9,23 @@
> #ifndef HW_VFIO_VFIO_CPR_H
> #define HW_VFIO_VFIO_CPR_H
>
>+#include "migration/misc.h"
>+
>+struct VFIOContainer;
> struct VFIOContainerBase;
>
>+typedef struct VFIOContainerCPR {
>+    Error *blocker;
>+} VFIOContainerCPR;
>+
>+
>+bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>+                                        Error **errp);
>+void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container=
);
>+
>+int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent=
 *e,
>+                             Error **errp);
>+
> bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>                                  Error **errp);
> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>index 0f948d0..7d2035c 100644
>--- a/hw/vfio/container.c
>+++ b/hw/vfio/container.c
>@@ -643,7 +643,7 @@ static bool vfio_container_connect(VFIOGroup *group,
>AddressSpace *as,
>     new_container =3D true;
>     bcontainer =3D &container->bcontainer;
>
>-    if (!vfio_cpr_register_container(bcontainer, errp)) {
>+    if (!vfio_legacy_cpr_register_container(container, errp)) {
>         goto fail;
>     }
>
>@@ -679,7 +679,7 @@ fail:
>         vioc->release(bcontainer);
>     }
>     if (new_container) {
>-        vfio_cpr_unregister_container(bcontainer);
>+        vfio_legacy_cpr_unregister_container(container);
>         object_unref(container);
>     }
>     if (fd >=3D 0) {
>@@ -720,7 +720,7 @@ static void vfio_container_disconnect(VFIOGroup *group=
)
>         VFIOAddressSpace *space =3D bcontainer->space;
>
>         trace_vfio_container_disconnect(container->fd);
>-        vfio_cpr_unregister_container(bcontainer);
>+        vfio_legacy_cpr_unregister_container(container);
>         close(container->fd);
>         object_unref(container);
>
>diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>new file mode 100644
>index 0000000..419b9fb
>--- /dev/null
>+++ b/hw/vfio/cpr-legacy.c
>@@ -0,0 +1,69 @@
>+/*
>+ * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include <sys/ioctl.h>
>+#include <linux/vfio.h>
>+#include "qemu/osdep.h"
>+#include "hw/vfio/vfio-container.h"
>+#include "hw/vfio/vfio-cpr.h"

Ditto.

>+#include "migration/blocker.h"
>+#include "migration/cpr.h"
>+#include "migration/migration.h"
>+#include "migration/vmstate.h"
>+#include "qapi/error.h"
>+
>+static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>+{
>+    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
>+        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VAD=
DR");
>+        return false;
>+
>+    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL=
)) {
>+        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL"=
);
>+        return false;
>+
>+    } else {
>+        return true;
>+    }
>+}
>+
>+static const VMStateDescription vfio_container_vmstate =3D {
>+    .name =3D "vfio-container",
>+    .version_id =3D 0,
>+    .minimum_version_id =3D 0,
>+    .needed =3D cpr_incoming_needed,
>+    .fields =3D (VMStateField[]) {
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error
>**errp)
>+{
>+    VFIOContainerBase *bcontainer =3D &container->bcontainer;
>+    Error **cpr_blocker =3D &container->cpr.blocker;
>+
>+    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>+                                vfio_cpr_reboot_notifier,
>+                                MIG_MODE_CPR_REBOOT);
>+
>+    if (!vfio_cpr_supported(container, cpr_blocker)) {
>+        return migrate_add_blocker_modes(cpr_blocker, errp,
>+                                         MIG_MODE_CPR_TRANSFER, -1) =3D=
=3D 0;
>+    }
>+
>+    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>+
>+    return true;
>+}
>+
>+void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>+{
>+    VFIOContainerBase *bcontainer =3D &container->bcontainer;
>+
>+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>+    migrate_del_blocker(&container->cpr.blocker);
>+    vmstate_unregister(NULL, &vfio_container_vmstate, container);
>+}
>diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>index 0210e76..0e59612 100644
>--- a/hw/vfio/cpr.c
>+++ b/hw/vfio/cpr.c
>@@ -7,13 +7,12 @@
>
> #include "qemu/osdep.h"
> #include "hw/vfio/vfio-device.h"
>-#include "migration/misc.h"
> #include "hw/vfio/vfio-cpr.h"
> #include "qapi/error.h"
> #include "system/runstate.h"
>
>-static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>-                                    MigrationEvent *e, Error **errp)
>+int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>+                             MigrationEvent *e, Error **errp)
> {
>     if (e->type =3D=3D MIG_EVENT_PRECOPY_SETUP &&
>         !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
>diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>index bccb050..73d29f9 100644
>--- a/hw/vfio/meson.build
>+++ b/hw/vfio/meson.build
>@@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true:
>files('calxeda-xgmac.c'))
> system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
> system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>   'cpr.c',
>+  'cpr-legacy.c',
>   'device.c',
>   'migration.c',
>   'migration-multifd.c',
>--
>1.8.3.1


