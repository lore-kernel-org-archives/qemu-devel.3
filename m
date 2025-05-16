Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E65C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqOy-0007kK-RC; Fri, 16 May 2025 04:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqOw-0007kB-2o
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:26:42 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqOs-0004fK-M4
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747383999; x=1778919999;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v9PssjukqM0juE9YqwQqd9PMO66B5LSmvMwWWfcdKl0=;
 b=HHhujSz0vaQe3WnBVYm6Iaq0Ex7yGilFPb0T80o59ksgL8oWGA99/ELT
 PBXTmPDO9QgYOw+HpouBkepkTlYDbtlDJXzQ536bRKukECynzbxWhCMYw
 sDcPdHxRjCVs4K2o07vpHwaLLf6VH+6cdxiBwKLyyZG3Os4XJGthvo2K2
 BrJZ46osB5gFrM54qWVKNX/6nbQxY6FuAadZQDpRcQgO9yW2J0GG+oFFL
 UIttiKK/9QacPkD496B5aFD+GwNuAsy1PFGcsXrGhspex+JQgVMEY/0jF
 5Bhu3MKLkjbHXCflElCDOtPNUmh4r4RWvRRmpdYcx1Jd5lUpy3dloo+De A==;
X-CSE-ConnectionGUID: YuwHWCOIQkCMcdwM3zD2eQ==
X-CSE-MsgGUID: 2maklyQuTmSR4/ON4c1zXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49042861"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="49042861"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:26:35 -0700
X-CSE-ConnectionGUID: fYJYj2tpS4+Uyuq7ajz36w==
X-CSE-MsgGUID: 7CigVC06SoKsU0E9pdOAXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="143514623"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:26:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 01:26:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 01:26:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 01:26:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWNBR0XOWjBjKMQSb1a/VzkU7SgscwzVDyV8+2otlmjCJUkS+WIEieK1HLZsMpGUOa2ve3JTpIAA5+8C+4/Usi+Gz9gf+HXM3wTAk/DtXrOF5ePxn+LkmOt+zKZHyU99xw4b2yltpKQLyTUodVET0lUiD/3+kWq2KqgkUF2luLLGxd4xffwe92wOGPaYmiiDYiaUxE3r6LeQNhMF+A2C9FhNGHJ2f7GUhxja9VvoSIP/mo/44Lp8d6MWBY559+D4+ctFC7ZuUOkqzR0FTD+b0wwkRlsm0JwFRXi8mzSMXJwbWcbuBd8lUg5CbhR19XQZOxgBTzndcso1CR5bXS5jSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfa+OPpudKowKYbAYNpyHODntOdtj+zItl8R0iSKJkI=;
 b=Px97vj6D6v6vyzy/fOlygHUldV68K04n5M3DIPUw65Nzj6cZYqaasombTTmNHhRCbpTpHPP4jLZQfP0M2sze5mpny5a12GGzqNhIYsM+AiaGjfAN/OIEQwQXm0SThZ7qpv+to9QCibcgHILCqw66VyXk3titESb5yRDIz9b0L3Cmtc5Pp8hW2H+bZB/qP9AMjsPpdqH4g5Rny8ynNCY9Rs6S0GIT1hTZnhgpT1b21l0kZimeufI5IIVOM4nZijQ+zKLUqj4HaWBwj0GUkNla7XwHQK4C3FeQnh4kp0s3NevjbkbPHm83DXt8C6nqdzYoDry0E+3yhz7YQBZcC/eqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 08:26:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 08:26:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 28/42] backends/iommufd: iommufd_backend_map_file_dma
Thread-Topic: [PATCH V3 28/42] backends/iommufd: iommufd_backend_map_file_dma
Thread-Index: AQHbw17TGeUM/AlJvEajt07i15f4jbPU8WQA
Date: Fri, 16 May 2025 08:26:30 +0000
Message-ID: <SJ0PR11MB6744903C16544B81D8317DDF9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-29-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-29-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7720:EE_
x-ms-office365-filtering-correlation-id: 3662ccae-6fc3-4f1d-3e41-08dd94535c55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AA71eYrrajqAZ5j1fPALPmHggEtKVfvwW8DuVRRbh09A9RKL0oZ0MwN/Wm85?=
 =?us-ascii?Q?dlA6yKqCjvYErB23mNcMTjOKuEqu5SIaLBa6T2JnQHVhjmqq8ueNfmOrcXLQ?=
 =?us-ascii?Q?nQBcbGikRUiNSkuPEEttT2e0VmH4eCkgaBXwJP6OJ3blZEhqS7XwetoBU2gZ?=
 =?us-ascii?Q?ZaysfqxBQZLvgP/knQZArWwJZoBm8D8G1rkB6Kg3WDifnXDroJKbWLSBq1su?=
 =?us-ascii?Q?QY+IfHwbMNN1Jc0WhQ4A4kPcHT97rrD0lOyfOYn6UOcuAf7JGgu8H72dVa6C?=
 =?us-ascii?Q?Dl2uk8c0J42Th8+O98MY/bisnsMU8gTwaBB7XVvxAcfleUWkIVjiTQOPhrNI?=
 =?us-ascii?Q?OROMedTw4bhoa5/zQ6DdiTulEsgepKra+o5S6xprlGxIEYzSZL+TDvtgbCC7?=
 =?us-ascii?Q?wZ4fY6B6KBiiLm+dPcU05CRq/GOdqpMe6SJwa6cGRemZysMUfCKz/2q3kIY0?=
 =?us-ascii?Q?llnRB3NUXUrGwDdfrl0qUzfkJg9BjKbkYRNBD4ux08VT8E2fssa23ioEqk1X?=
 =?us-ascii?Q?APnxVyWYyqh+VSIA8rcfDg3MzenJqGer75l2uA6KulCCXybEHbJZjmLZqYHc?=
 =?us-ascii?Q?ImlOBiq3V6Y7//t8u681FVm/rqiAfUcUx5S0hTGRMKlMlCNtSvKOxD0G0XFQ?=
 =?us-ascii?Q?r0Nuu2nC855aUobcg6GvtMHHIi13GPeYJddS9yZVBAJuBTAjE/tlAG911KCV?=
 =?us-ascii?Q?4UZWsGLL3wXYGotZ7ePdgT0BgTrIWBSc4+Ss9HlrU0ERry3DH0oHWXAz8H5O?=
 =?us-ascii?Q?nqk+VM6a4Jix09JnZ26UvKjetyypak8/8YLeFMoDZh1Ku7rzRhv+zIdjPmj1?=
 =?us-ascii?Q?nA+nkm/WtDvHiuuvvtsxPgzB0OnQCHk6sJxCSz22EkyhoBIsPsIZ1YAUND2T?=
 =?us-ascii?Q?2lVioS9n5GjMBA+d5stVqrT/beRGbMtt2SgemZ3ToRLeSYcOGTe+glD0gS12?=
 =?us-ascii?Q?wJnkIFwOm70FwrpHkRI5MAfbIGD2MRjiZyCXTuzwmXsuEIS8akrHkY6WEiJ5?=
 =?us-ascii?Q?hdScoN7TagiSCvsRyg//qGqAR7jifzbBFOTMjcSs2LTSCTbPbXR7SGqZ/rKL?=
 =?us-ascii?Q?/5jsKHpk0GD04ZYRWpy7f1puuQffesG7imaVmCs0NwHjh3kjj/oLH8z6Q/K7?=
 =?us-ascii?Q?mkkueWQfaLfHcsKVcw7KgZDbTpLaiPYC4VjvLivwjlekujTkv6Au5QtGHKEc?=
 =?us-ascii?Q?9uD/xRaGhePxLPFU7zFr06TxtZrgdMpoPZTZbi9f+fmzd3wyRJqpp5G6zyiJ?=
 =?us-ascii?Q?+rVGBAs+7gaA0Kaspew/K+U8g+hIx1CUt1kjBJBB3H0CbcuKGupPiziTigqe?=
 =?us-ascii?Q?j2IcIvP1VTbrAm3vIfT2ueUVPiZeBuxsEotoMVH2zzburoL8fhoMQ7MGHwVI?=
 =?us-ascii?Q?eEXeNaYeWprZqW6lL4ReFIKpZIGM6SmpAM4d/YWjHSZRankEkayNoSjTrWzx?=
 =?us-ascii?Q?WR1XpYa4Fm4ebFkSl2/B5kzm1qWW2vHSAjmMkSFd90D1nRgNLoaOCzT3ATGu?=
 =?us-ascii?Q?QOPqIFZoIkD2Tpk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tJC7zFafcDCC1Q3WHqdBY/OpSOeS4S0PHBhXRHl4sk4owU1WKlnfsZNbapDT?=
 =?us-ascii?Q?dlbS37SW82o0jBENv3VVuZV0xRpdXM1IOTagDAWs2y2triGgR8el26jJjL6f?=
 =?us-ascii?Q?raVMS7wEDpa6IIP44O1k6qT8VMSrAjkzABQRs+i9r4YgkXC/rMGTD+Rln7er?=
 =?us-ascii?Q?zKesMYpQpzWWCAT96lWE2IzRCdFKm+hRRabUx7Qtp9gNq/NIJKsKS7b0Utvm?=
 =?us-ascii?Q?2+JhR6yx294pRxW/B7SGRbHOyKoP8XUtNUHAHemGntrLJ9DrL+qltYMn6X00?=
 =?us-ascii?Q?wi/y7adyGgHfz8DwuB1ltzOKVub8EKX4/GEf12HGDK0lOsMBpbpOEChNQXLi?=
 =?us-ascii?Q?OPl/u0quEsmFJlMmKcZYqTDIA7xn1qBmf5l4XArVYmC6VRULg+wRm2YgEvzB?=
 =?us-ascii?Q?LbpEMu1QHHQB4J3ZELlUfmO3htS+k6kCWJAJzd6CC1r/rTZORmP3ngwFjYvd?=
 =?us-ascii?Q?ep85SX49q+JqxxLnDZuBFmuG0dk3WxFhZRXqrbh7f/4+XWPx7pJLRz9j0EBn?=
 =?us-ascii?Q?WbkVIbgVR7p1x6YhnjCvORQdLDtAzviv7uubv4Guii/8SilXdNax9ZoEI7d1?=
 =?us-ascii?Q?t+eh6ulxJ5IPsQSyH1Bo9yZMHpElg17GH9n51i/Yeor6rURYxR8XkUtHbEZ3?=
 =?us-ascii?Q?yW2VwegvEeu9R66jA8KjpMsBk8ybWW5XovmVImCkp25T/JN5iN7c+0JEbBfl?=
 =?us-ascii?Q?ApW2SYJJBPwd3Lk3Vnxnjl5appfUBQTFozwNepIGB/QCg7koiqj/fiDDa8Bv?=
 =?us-ascii?Q?uLADxtnVzMzgDaY8fmfr9PZc16mDpwQiTf6CU0RXkm5n9TF/zm8emAW0d/a3?=
 =?us-ascii?Q?4jgrvuIhNZ82btyuXyD4DnDs0Jyu98Q+0xgcpW5LJAmI29IraICQ4DVqLPEs?=
 =?us-ascii?Q?Oc8vI9RRb5FMlpzyxeaxsSNiCw9V2381Fzbmd8GfPIU3X6lgcDSV6t8/TqEw?=
 =?us-ascii?Q?q91tTq7kMALyvUCfbWuy722tka2I0LoXgOs8EkStZdtcdsKW3DStOwAsvcn9?=
 =?us-ascii?Q?0ozTOFtgenKfoqsbYhOZG2NnjNf312F6XZljvSwG3EoNKEawWyQb31z+K2ma?=
 =?us-ascii?Q?jWAYFtPzooLIxmipe/WS5StCz/VlMew4HKH1TzF6GaKljz4+z/2Vp4v/0DyH?=
 =?us-ascii?Q?NcsDfNs06yhxVANIGMT9uwFm2N1pdtebjMY/crHu8JzV030l+K4W0DKZzJJL?=
 =?us-ascii?Q?vye8DZmsMhjqw5xmTPQTLRZtiNV9miscXrPtaG9DFavcrpvWb86V0RKn69OZ?=
 =?us-ascii?Q?7ss9baaxvH7re5+ka85VaR+fUslQpgvdOjn+qLTXd6geUofPhwY/U1M2EXtW?=
 =?us-ascii?Q?cqT/4GMuUNiJLbF6Xb1fCHNkb25UCNxQxEvmC6+atbpj6S3KYEictQi/CWcP?=
 =?us-ascii?Q?dUKsSPVbQc48pFsgceOj9Yx6/6kRviIFMZ0QLR7gIw2kksrfLpYveQqNGRZH?=
 =?us-ascii?Q?uBWBQBoMSAvF0dIlp2+U4wfi5SqfzJoOfegb2/Cx6AdpvXvIraRzutqSo3ux?=
 =?us-ascii?Q?WsFSyuCmpIwwalYmhXjERScDloNYvRoBwLV8YaPx4gjNwsM3DyiibiNouxip?=
 =?us-ascii?Q?sn3UCzchWzH3Q/thm3GQ2Px51mWWQNbNz87/CCLn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3662ccae-6fc3-4f1d-3e41-08dd94535c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 08:26:30.8338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHdg7dQMXDUKU+Sw9KCv4YkpxXTiNiYnIImfm6gt3cSE90vB5p3F23qgfHBYSczDFN74wkDaDsPRYr/gXSNN9p4fBG+UKQDvDsdQMK3Wx/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
>Subject: [PATCH V3 28/42] backends/iommufd:
>iommufd_backend_map_file_dma
>
>Define iommufd_backend_map_file_dma to implement IOMMU_IOAS_MAP_FILE.
>This will be called as a substitute for iommufd_backend_map_dma, so
>the error conditions for BARs are copied as-is from that function.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
> backends/trace-events    |  1 +
> include/system/iommufd.h |  3 +++
> 3 files changed, 40 insertions(+)
>
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index b73f75c..5c1958f 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -172,6 +172,42 @@ int iommufd_backend_map_dma(IOMMUFDBackend
>*be, uint32_t ioas_id, hwaddr iova,
>     return ret;
> }
>
>+int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>+                                 hwaddr iova, ram_addr_t size,
>+                                 int mfd, unsigned long start, bool reado=
nly)
>+{
>+    int ret, fd =3D be->fd;
>+    struct iommu_ioas_map_file map =3D {
>+        .size =3D sizeof(map),
>+        .flags =3D IOMMU_IOAS_MAP_READABLE |
>+                 IOMMU_IOAS_MAP_FIXED_IOVA,
>+        .ioas_id =3D ioas_id,
>+        .fd =3D mfd,
>+        .start =3D start,
>+        .iova =3D iova,
>+        .length =3D size,
>+    };
>+
>+    if (!readonly) {
>+        map.flags |=3D IOMMU_IOAS_MAP_WRITEABLE;
>+    }
>+
>+    ret =3D ioctl(fd, IOMMU_IOAS_MAP_FILE, &map);
>+    trace_iommufd_backend_map_file_dma(fd, ioas_id, iova, size, mfd, star=
t,
>+                                       readonly, ret);
>+    if (ret) {
>+        ret =3D -errno;
>+
>+        /* TODO: Not support mapping hardware PCI BAR region for now. */
>+        if (errno =3D=3D EFAULT) {
>+            warn_report("IOMMU_IOAS_MAP_FILE failed: %m, PCI BAR?");
>+        } else {
>+            error_report("IOMMU_IOAS_MAP_FILE failed: %m");

No need to print error here as caller does the same thing.

>+        }
>+    }
>+    return ret;
>+}
>+
> int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                               hwaddr iova, ram_addr_t size)
> {
>diff --git a/backends/trace-events b/backends/trace-events
>index 40811a3..f478e18 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -11,6 +11,7 @@ iommufd_backend_connect(int fd, bool owned, uint32_t
>users) "fd=3D%d owned=3D%d user
> iommufd_backend_disconnect(int fd, uint32_t users) "fd=3D%d users=3D%d"
> iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=3D%d"
> iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64=
_t
>size, void *vaddr, bool readonly, int ret) " iommufd=3D%d ioas=3D%d
>iova=3D0x%"PRIx64" size=3D0x%"PRIx64" addr=3D%p readonly=3D%d (%d)"
>+iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova,
>uint64_t size, int fd, unsigned long start, bool readonly, int ret) " iomm=
ufd=3D%d
>ioas=3D%d iova=3D0x%"PRIx64" size=3D0x%"PRIx64" fd=3D%d start=3D%ld readon=
ly=3D%d
>(%d)"
> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t
>iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=3D%d io=
as=3D%d
>iova=3D0x%"PRIx64" size=3D0x%"PRIx64" (%d)"
> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>uint64_t size, int ret) " iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64"
>size=3D0x%"PRIx64" (%d)"
> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=3D%d
>ioas=3D%d"
>diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>index cbab75b..ac700b8 100644
>--- a/include/system/iommufd.h
>+++ b/include/system/iommufd.h
>@@ -43,6 +43,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend
>*be);
> bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>                                 Error **errp);
> void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
>+int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>+                                 hwaddr iova, ram_addr_t size, int fd,
>+                                 unsigned long start, bool readonly);
> int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>hwaddr iova,
>                             ram_addr_t size, void *vaddr, bool readonly);
> int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>--
>1.8.3.1


