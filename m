Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8373EC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvq5-00025B-QA; Fri, 28 Feb 2025 03:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvpz-00023M-U2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:35:16 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvpy-00038K-4Q
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740731714; x=1772267714;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Srhfkt4M+QIjrqfGov02OSgHMp7iZMGIPr0MWgLDW/w=;
 b=TQ0bdd+eGVsEwNIQlfOogpN3XjGSQ+AxdGxbXUx7wg1/0G139I7hVy8N
 1Ovaz/d3J4WkfwJ3myCJkJtL9gL+fb5vOuGtEdGFOBESoE+IXa67nPjE5
 il8PkSpLCodRkrhOnXcSsnHbqofYDtV8N8oC6vYSSlh1/H9d1zvJVCO0S
 kIcb306Yk08W2W2EPpcfsD1sBqwBoG7YyLKgvMz8SyPY5NvBY+VNB7xte
 QXf4uBwbCTF4TbjKkuOrGPXqpm9DtnJb31BaGBKuJO+vmEjz3WjRLecGw
 9BBF/GCg+8m8cQqFfrWdjzUq6ogHVYAex7iALyLkharTGeVOjBbejfalC A==;
X-CSE-ConnectionGUID: AK8lZzCSRkSCN9fQRfsbXQ==
X-CSE-MsgGUID: cBDnQiEsQ4y7lzpI/+l7Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52297050"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="52297050"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:35:12 -0800
X-CSE-ConnectionGUID: 0aQ8FYjsQ+q0D3xsLUzGng==
X-CSE-MsgGUID: O8daSztOTbOfC+gUXPVQvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="117780190"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:35:12 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 00:35:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:35:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:35:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8MkXiC/e20lueQhSiJVS7G4f3YxAS/+/FRuAtw1MiBdKdkWB1fp8iTh61YUXIOgVU+kJWwiP/BEysGv7SxaR3pfOnRqsmNaYB0ILCyzj8MibctO9OoEO2BLO62BsE+WoNbzPzRFgZ4kyl4SJyQuRdGGtxbiETkTPp5cRFFxYk50sXm/eqk7B+mpkqswTVbZlNhZM7yArGHPNqwurALuuSF38kb2/S7AGa7HlXRN1BKly8qgwLPLuGKhMp6KQS2raKYPoRFgwaeEDpXl8t+bJXfL6HwqEth8nBrdPU+PnoailtEcPNaxX8LX649r+SeI1JWdw6SfQnQ+GZWoXJ/TOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srhfkt4M+QIjrqfGov02OSgHMp7iZMGIPr0MWgLDW/w=;
 b=rrrfr9aEQCn+GvjzRHaJA9f8hk3rCeznBdYd5HAF5fakibqOfQ652nu3MwROoccBWwxrKIx6CD9QBgrHL3Rd2NbuWnyNlUZEphBHHA3+zaLGe+cEcoKQWv/xKqQb53JzfjPntuu3fzyV4BcVVG6T2bijfqnreOWmRPR7mEM211ZtLu3g25K6qL727eqh/NFWEIzec+RDRxTI1MRbewSchoBAZLTvTcZFuPU8fzp3I77kZgCwVQ17bDU8Nd9I2b9YCm+a03JOZyL6oDcGXMzeaCMYctEi2KWKTJrLHjQ7qCSFQd8D1uq+3wC2smX0ZPX7YTSSGPVrGCUdmHQlHrgrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:34:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:34:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv2 10/20] intel_iommu: Optimize context entry cache
 utilization
Thread-Topic: [PATCH rfcv2 10/20] intel_iommu: Optimize context entry cache
 utilization
Thread-Index: AQHbgqgRrCVskaHBqUSses+ZflJWprNRiXKAgAlxMQA=
Date: Fri, 28 Feb 2025 08:34:54 +0000
Message-ID: <SJ0PR11MB67445127F26929645DFD145A92CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-11-zhenzhong.duan@intel.com>
 <35c93407-b8ab-4286-a254-c62d39222272@redhat.com>
In-Reply-To: <35c93407-b8ab-4286-a254-c62d39222272@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5062:EE_
x-ms-office365-filtering-correlation-id: 4bed8935-cda9-479c-fe6f-08dd57d2c690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fUkrK33FGdCc8GQ/ty8i4UCMzIS1kmGA497b7ueibL7ryvT0pdbydGcKwX/n?=
 =?us-ascii?Q?/MwEHoGxXFhGBoIiZS27uB+TFY9JDQDDBQk7PzCXrSVfIvHBKsb+7KnEZAU3?=
 =?us-ascii?Q?zOpAkzFrBWXCyGAhZUxubcJ57zC4Xs+UnoVzluBH8Vr/EJp4JZcD/w7EG5HS?=
 =?us-ascii?Q?YS+9qTWyN0PVs3Eq2jYbTzUoYL91Exni06ImUQTp85fhDkkh63TZW4ZHQerW?=
 =?us-ascii?Q?nkVx6gezlRSagBVPtyFltNWE3/qHJmnbrU6ZB+G22FSMnkBKKj6PGf6IPWF3?=
 =?us-ascii?Q?L8pU0QNPgerNhoQ+HOOTkjTP9EAks/JHSLK74r/eNIWo3sxE6a+5QGr/irhA?=
 =?us-ascii?Q?EcKkaPodrbs8bLHKx0Eqyz0KQA/VBPNjVNZoKZOnHgy/a8keOyr6/HklN79L?=
 =?us-ascii?Q?nMZWZPa6Ss/B2l3kxu7kzUorB2wvkAHothB1ZstF8qBSUIAv6GPnRSTEvQxh?=
 =?us-ascii?Q?IwWbqzI+Yyc82pKjMCXVUeZoucNr4YypJbNS/iqAABx7mGh1H0+Jk1gw7WY+?=
 =?us-ascii?Q?Zxx83sdax6VX2JNa9sjZ8XY25aqtSpozTJZOzkQtmKt4tay42mC3GGaGXc2r?=
 =?us-ascii?Q?ZfcR8h6ZqjpSndGIceyZ3Za4fUsedppmv1l/y8VppszCCTXzTyW6F/98hAfw?=
 =?us-ascii?Q?jVYcAL/ZNQPf066SNhkH7a1Wxf7E0kIsjeXir2He/R/rfj8a6VMRHcDsuvYt?=
 =?us-ascii?Q?qgp+yzHwCe/zuq7q9At2EOlOOg3ieh+EmqvT43EQ9uEuvIU4C4UPRc7aDQL6?=
 =?us-ascii?Q?RNaHcBljFph0gPDtbqv+pMPe3oEgsrWXz34a2kxYQ9G1fThGYzSXjrWDzhwz?=
 =?us-ascii?Q?jYFQcuc7TrrAviNl/8XWEuII5nE3At6ZtGEiDVWJvwLHFpV9Y4R60fprLWOD?=
 =?us-ascii?Q?y57rYrJkpgN619Su93N+86EFWX9dcZ3T+16Z1PBt31zewu2TO4/ZqQBqZ0Ua?=
 =?us-ascii?Q?0OScL0SnNLv1oTaI9lVjoEarnieuPLnLECloeQu7xDZHnR3LA2zUTXysHixx?=
 =?us-ascii?Q?Cz8Pi2L+Uu5TgODih5EXLZnzuauxJh5eu/b35hVkzlnm8RivOZiK/S4pbUwq?=
 =?us-ascii?Q?hsVyivnl25TQRxJqBKm5IMwJ5FPOZFzd6OUiDop/3TttwAIb9Q8VJ3vjiQFX?=
 =?us-ascii?Q?8k24A4KwDCC0OfogSERmtvA7szTmcdU7mX29njpHwXaeGw2+qAnLI5ClF3cp?=
 =?us-ascii?Q?HNbOFmATq5DWMTq5WHaQWAwBzR2flR91nreuhRAjbNzRtUFlXPSSgZYZrsyg?=
 =?us-ascii?Q?DYMhNPN0GM6HWTGwW8KKHWm+Aesx/CFL2fnGxatXs5dvt4K99gcWc3/BxrfI?=
 =?us-ascii?Q?vh6+Po6Dslt/AUvg2ROKWEXJPkpr+NV8HCzJdfTjv0ZX2SD4S/W3Gqm0fOa5?=
 =?us-ascii?Q?3zOhCL0z73w2pZUVc8p/Oy9aWT/T6u+85ThAyyNCYvXCY3il5/V5qv9Qt98H?=
 =?us-ascii?Q?C8LhAAkWi5EKb57ksTzRg2au/4LXw3eg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZfOxNCNR2N5uf1TAbR/tQn+GSwX6OBNkAEZ7oxtDrPIwq2R6lMn3Vz0rIhcz?=
 =?us-ascii?Q?Ao3HEluTiIJNPp3g30Q0+klqzPsyDT0xBm8JXYaAeu6nWAsWHm8nhxWUZFrc?=
 =?us-ascii?Q?XnnPHsWd1+PSpUb9oYNW547+mQcfRC6kHwGnYaZlDO17qizDK4s09L2MvuZG?=
 =?us-ascii?Q?NJsSJrIXx8ThK5em2ymQOw7MsZS1ix/5rH/OOrhr5HmBWeyQNNS/WAOTfyXT?=
 =?us-ascii?Q?CFXh/Jlt7skMgVAjSzfSTQw3udWhe7SKxIHuGot+NmcvKJku2jZC4RPCJU1s?=
 =?us-ascii?Q?FLuRdEfppW40WJTKS8k+RKNmwLRo/iqrju9M8Q8xllbHcc14DLkL4a7J1DgK?=
 =?us-ascii?Q?y0Q0slNqFd8WS5uq4I4gQK1mbgb1poRPyW4f5OcPqcCZdQjYbY/OScIpo4vJ?=
 =?us-ascii?Q?Ue1xzOqGjuULvDe7FCwz/Y+qEZRLXnE6Qz1f3jtrystzwEuXq7WTsSYmLOjB?=
 =?us-ascii?Q?D6ZHHBWF4AIjDpd7C5+ZR5mhTuMji7LQPZgwOIjUjBt5DGWkm5yK7TejMv1i?=
 =?us-ascii?Q?lINDvV4V5NQir8HL5xtq+tA3w51wPp2PgQld9cKkwXNveWmVOmkbeGGn9Apf?=
 =?us-ascii?Q?pKqfJ1kwHBI0yqv0Wg53pMaUEiXa+5HX6NXy6zD7hpGDZ2Y+bbOGRfgw1F5F?=
 =?us-ascii?Q?HHveSN5Jht4IcU6VV2nQ1giYz3dPSfK7gn7Rzl5cnhuDe5O6t3yvxYBdYuQJ?=
 =?us-ascii?Q?x1dHBJHJOIGlnIv4knTx7sjpv6OLixStQSTZxoal662SLca8BOR2HstLVjrY?=
 =?us-ascii?Q?TlKMBQ5zRZOp/dN2Mv7Q+vSKev3zDMxcnWFqCt0frK37Njiq76w2mm0IjeP0?=
 =?us-ascii?Q?PY+ya4/1jeF4HH5jcLVkJpD0J62KkKCSY0GhbzAFXi+kcbrbhxJlxJs/SZvh?=
 =?us-ascii?Q?cxMxbqyV3uwAvFM5MNawD6cJuAWqB9cthHngjzpi1XXbE6d8omxeChrYPSUE?=
 =?us-ascii?Q?7ZDAhuJAfe2mBx91Wg9Wftr5/DZDv2gHIatzWEzSDOlRIaN4S3lTHWoqEL5Z?=
 =?us-ascii?Q?IbhQRoURiWCfR+KXelqM9L0ThcTA9nFMy2/BDqZ1GeUdmEEeNI6rtxZq+LtH?=
 =?us-ascii?Q?ozrT/AoALHhhOrl5rRZmmeTg2K6yYwugB8QpOAfxDLS/lmkb9FJgdaU3x1xF?=
 =?us-ascii?Q?3rh2mGWKpxCiqGzuUMQQw++DIWpkMnvob9/wFIf5viEMcODX+Hu5kKm/t3Pl?=
 =?us-ascii?Q?Tti/yR5a8dZx1+JIAfBtl502L7E3jb8CiMTCuwZOFcaKgUkmgG0wMbeoeooM?=
 =?us-ascii?Q?xKl2lO10zFXgNirN2C9SUxFrY6pGseohxRZ+vG1/JYpkXJqi5b1zoqvBLIhe?=
 =?us-ascii?Q?YLH04wUZxNA+oe4hNrrF2SpzKeTQ4eJc72ha28CTbJ7DOVdOsGpEOTWz+QJ2?=
 =?us-ascii?Q?a3V0H7zirNGRTyxbRFGY9fkhbRW4RIQ4vVQdURsjvCn33QcAa+5GdqYadYCf?=
 =?us-ascii?Q?98nkQiYWsUgpS7ZUmXdnPgojf0yoAZFimY0uXu7640Yq7ITQNE4aHOL/RCsA?=
 =?us-ascii?Q?2Cwth5/xwhSVSuxfhd0G/YOZ3BTKHwufmAImdF2VVTWD6pU/EYu3lYV/lU5k?=
 =?us-ascii?Q?BjnRbUrx6I8DU7vTgT30kxH2h8WEqobPY2fki3SD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bed8935-cda9-479c-fe6f-08dd57d2c690
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:34:54.2566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/bP6WFGsqmmbpeRJg7GUuNg389pKQK5cGfszfJtie24RVX8yYBu4c6C0jAWxqY1rru6s+aaLIoqlQsQd368rWjstlwZf7n7/bdhmBUjx8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH rfcv2 10/20] intel_iommu: Optimize context entry cache
>utilization
>
>Hi Zhenzhong,
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> There are many call sites referencing context entry by calling
>> vtd_as_to_context_entry() which will traverse the DMAR table.
>didn't you mean vtd_dev_to_context_entry? Instead

Good catch, will fix.

>>
>> In most cases we can use cached context entry in vtd_as->context_cache_e=
ntry
>> except it's stale. Currently only global and domain context invalidation
>> stales it.
>s/states/stale

Will fix.

Thanks
Zhenzhong


