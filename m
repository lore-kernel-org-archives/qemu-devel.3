Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AA8C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwCF-0002yF-D5; Fri, 28 Feb 2025 03:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnwCD-0002y5-1f
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:58:13 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnwCA-0005qy-OG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740733091; x=1772269091;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AqKCUZdd9bR66RP46uSMhtmqVOhMarxKcjoXmHZfKPA=;
 b=TfFXAIjmHULvYJveX5okTzEQ0lI5DGYxcFHzPnwrLpdHEyd8EwQXVY9S
 jA9gOh6oYOGAcKOUS4++irAhrcwpQSg6WUz8DCH5C2lygwmLjnewUwHKf
 d5Y1DRhdSyyFrpvWCicWe8HC91NqlCYGXqLxdo7cuUV4fqCrKXJoU5Y5S
 QH+w2wE+nK6T2o1QCvLL8ahIojJbfpZkw64bSmeHYRny14rxY3IksiqWl
 MSgaHnLb48TNgNJ2ePPcnI5zC+b+0n7wo6oayRLU7yDo6OWv3UySdPmUo
 BjoDu487fMU21ENo4gM9owhBPrYdJJmOjuRu7Oe7W4UXLwL7yWlTvkNpy A==;
X-CSE-ConnectionGUID: CSryhx49TPa71B4VP1fT2w==
X-CSE-MsgGUID: v//CDF98RxSs5jjchrPtKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45434785"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="45434785"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:58:07 -0800
X-CSE-ConnectionGUID: Dkg0SIw+TA+5u13Z84nA3A==
X-CSE-MsgGUID: 6cpfnT6LRNezcNjNMfNjMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="117464409"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:58:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 00:58:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:58:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:58:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+a2k3V1YOillrE03HbZt9iGZeScaVAoTR7+AMjw/1fSDDUfx0kfDSopxyY3iJvPCKbBwuyDwhlyd1xUVAV7e5qnZeooAraPtVLtV2JyHermqpsEEvg/gtxCDeaZ57ylzz+9zMvAf8Ujt6edlMrmBN79JGN54KmRAPad3sHSWDVXdaevcUJTUxmiqegowxWiQc0Va/GLXLOTm1p3hYytptONHQOGci3q63EFYsrh+Oc+rgQF8kLEPGlwIB9LXlz8yrLaiaWWD93ttT1fbWR6KCWz+72PpaiA58blNAeCkm1gyzsNaCm114jVQ/0NcALWKDakT/LjxsOMam0wE7gtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80JnE20lXlh+10Ny/kpwVHjqZxYh+33P3KqojFVIoWA=;
 b=EhwNbG+i9yBVNapoDgEUHrx9UmSeRghFfn9uK/EDEHNV5XinKz99+DUo7qFeFncmfmnbgq72/IypWufujlbVoIjunVQfKd9gDsgMDsmcgpb+JcInNd9npaimDvscdLi94k6TQRAVVrdJOUOeA2ZQZlf2S6uK/VvtisrziLZJwZNd/JzglWxkGLMnQidQAJuJ+aCExR20h9MiAPSwjXxH8IucfUGQW+p+/V9D+4KaSlZFEl/VnlluiUuu81d3muQDs+VPMEh5+PGuRVcz63IlnRj27b8JDHEUb3CR/dVHCe7qoXTcNVgr0O0Bn+fJv/JDFN5/iA5AM9uc3aj4+oY5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB8097.namprd11.prod.outlook.com (2603:10b6:208:457::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:57:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:57:35 +0000
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
Subject: RE: [PATCH rfcv2 11/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH rfcv2 11/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHbgqgPWtFwJdyqPkikFkNsC40Ef7NRuMgAgAlF1AA=
Date: Fri, 28 Feb 2025 08:57:35 +0000
Message-ID: <SJ0PR11MB67440272DF01878C9A0DCBF192CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-12-zhenzhong.duan@intel.com>
 <ba276dfd-fe0a-43ab-90bf-163e1ad76d06@redhat.com>
In-Reply-To: <ba276dfd-fe0a-43ab-90bf-163e1ad76d06@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB8097:EE_
x-ms-office365-filtering-correlation-id: 40171b1b-6315-465a-e640-08dd57d5f1ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LbOJ1VObgrlgTBs5p465+t8yUyPSpbozLX4jDOB9Zhx37LPKMsBC4mmonyCC?=
 =?us-ascii?Q?++1AjqB495XUtduZPOJfWsqNi/E3NkS0nrWpB7ZnNNFDCXe19MUDpg7Al/Jm?=
 =?us-ascii?Q?zuLOOoC9Hii+2/s816xGs+J2haZVI92LvsvxFn9zIQMaK7pK7u94wtA+/Cpu?=
 =?us-ascii?Q?1V/OT0r6olDhRFIruZb8M813oyga6yX2c9thu+sVYig3BGBaE8niSzrC5++3?=
 =?us-ascii?Q?TpVYQOYo9tReGbH2svRWUdjOs71SxP6p1hF3Rd87mK6gru9t56G4u1VZD42M?=
 =?us-ascii?Q?jFES43TtYHS7e1l/x7kKAhOH0O3ES1R6ncqCMxS0BaDo7aqu48xwKwi6Rmw7?=
 =?us-ascii?Q?wE9XddLE36NAqCKj1Epw3CXNyib+MfFpjWQyHkp4AJNSlGT/9xRCJtQFHjCV?=
 =?us-ascii?Q?8WEL+Nxx0TWlW/cImE/McEvR46uVW8Xy4/zVlspZHEsNuwqkvgd9n2fG789Q?=
 =?us-ascii?Q?ojcP1VfEg42NkdSU8wGKPih4md3KA5PSU0MYljG0GEklfBOH2lPO8Bs8I+0F?=
 =?us-ascii?Q?8nPthKSOIURwgZAb8mx0668sdgitzS2HFQaLXEy13me+UpUtT58g573CGd9b?=
 =?us-ascii?Q?lDl2f6dgqq/J2/X7SwH5rG5KLszYrEXuKhiGQbd7nIfZ5XG3gwVHcJ9rIB9G?=
 =?us-ascii?Q?kKW227Xeyqo5J7ypgTM7UDBQ6FDeK8oQ8NXxLiUDZj23UzkjA1ADkNGYbPzy?=
 =?us-ascii?Q?E7BlUOGy2B9rFYNXe2iyrPUrkaRttDCFZAHLH+oP00YMrvIGjvrJluDvLzfo?=
 =?us-ascii?Q?hVk1uey9gGMQ9ctD2qUkgw13DFBaEYXI8vHTkdbrCAn64btoTdXNCNFmYLtn?=
 =?us-ascii?Q?YicbDoNf7tN1GMFTe9p8IDQLA3nWtrpDOK2F7/H7s582cISDEIxkYVpDiS/7?=
 =?us-ascii?Q?3VPVSsDhwIbOYlCDdfejmJsJi4Ar6UW3hb058SFOkV0bR9i9pKraFkiInxZQ?=
 =?us-ascii?Q?i3S2SnKVw8Xya78WKsTISWVEGtCnmzfWaxikPzBGjAVrpndkDhxhvzr9Z3eF?=
 =?us-ascii?Q?GEm3QqYX8rIjCLzijcKscQ3HXM2Hy8pdY7q/DDhDQg0GUASWIoEbO+TOsMG7?=
 =?us-ascii?Q?EVCpna1VRyrUN2bi8g9B192fMjzXxbn7meZTs9ELvZ8h/SsOjbf032GEf0/o?=
 =?us-ascii?Q?QYn+PukuxlrHO7d6f6lCq2VW2eE3aIcNXdcKO6QOAFoPbTbZ/qcn2UtM/J+Z?=
 =?us-ascii?Q?f81KipM87CgeqJHvzIuWivvN2xN4npZ7jBawFH+7c2y/pKWlzceqGfyEjkRh?=
 =?us-ascii?Q?e2tVVLWIIjMdxCo+ayUGMkI7+zFf7dLzRqMPb3/KaB4wtbq/6zSoeZNJFxGW?=
 =?us-ascii?Q?trzIv/XyObPl/ocNqP1RcJdPdaeNBcdDlCDL+/OajVorwVrobrRuVE84tG/N?=
 =?us-ascii?Q?lUzqxiu92Hapag0R4jCWgLn9FbvJ3p7OzneLJQ5+OeJVzVOphishiuEfgOWb?=
 =?us-ascii?Q?LH1B72oo3+Mrzmx17QVcVJdaqZzh154H?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p8cWuMtfBKcLYyiK8OjOTWeAVNWJrCPhX7Izhe4Gzn9qmhW+4T4JuIifiCdv?=
 =?us-ascii?Q?PzP9X+mJdDhpqOpTvomVlGgxcbdGso1X5ztVl8eFKNTcNe1QQZSprSi9o4Tn?=
 =?us-ascii?Q?twjROtXcn+ZwN2kiSOl/ifwkdeg1pdBDYKrADrhRs4LzNfN+iPrSGseAlQUf?=
 =?us-ascii?Q?7dLUhzeUDrhlyND0T/eaW0j9h8hHLY3sjtafqJ6/LjF355jBO6edekbjWbeg?=
 =?us-ascii?Q?402CqrfHZZxHfRVGvyHIEzGquoKqaQCZIpEZq71Aepqyeh2AWqSuvZMrVV9M?=
 =?us-ascii?Q?FsrCcXRO4MD9bjbqr00EdOGeAha/bbzZDoKXN70SQDpJxmT/AN01kfTQdnSA?=
 =?us-ascii?Q?RHtBiXoLNizVpovPi8YJUYioM/F3bqpfw5aM1gNc0/IlxAxIf2WS8MzZ/ioY?=
 =?us-ascii?Q?kq8U4mg4Z0+1h5wpBsjsRrC5sj3vIPrb1G0eGa+HrSA5KM4Uzlyl85HNC+Vc?=
 =?us-ascii?Q?7f6QTxoM2cLj3WPcVlhM2nYvSoPHs5QFXvqnidiWSpYIpR9nWELre9+0zbGv?=
 =?us-ascii?Q?CWgwGmfqjBvPK2Qi6J2kqDy3kUWcE1Z3mZjCoOqhOfCeFhut/3rUzPL3ZDPT?=
 =?us-ascii?Q?ARTcH6sL/VKIu1B6rs95OeTZU+ibRKR+hu5QQ0W1Maf4L3ZWzH6Dt6p7hbo6?=
 =?us-ascii?Q?qjySTAI0gjPBh4O6V+u/8ld6uzKFshHTQ2M4F0uIgg0tl13xfUvPrBhk0PHc?=
 =?us-ascii?Q?BGsuHZspXZkR6sTpcm+hzKS+RziYuVky9IxmzQMd2VGX8Ew6N3hZszZOYPdI?=
 =?us-ascii?Q?vhjNWo/EF3VRyK3Qz6eyg1HA+y+gxyXXNBioQEWcy/g44w3A7PUv2Jf5tgXi?=
 =?us-ascii?Q?71fwCe+65LydDrhIMbJPLo1XmepCjJnHaUvuGs93ruwDq/nBCwIQwh6l00jm?=
 =?us-ascii?Q?o2v6x5Zbm9zkik6mltq1Gr8pW0FxRo6QhX4swGqieCGAY5xfjDh2vx5CjoDe?=
 =?us-ascii?Q?g0tzZ35VaOThbcUp1SId+1CaqByfvvOzw3AAPWnEvBJBZaUuPUHammsKTjgJ?=
 =?us-ascii?Q?kiIaq9HRRCK75Z1FrZz7GYYoMZs9/Bd7HBR8eBOrDrzhDTRqnWzflgbvbQsa?=
 =?us-ascii?Q?hsZyFUoFsgTwkAwoeXSToR/qB3nIexUHD3noCXURCNpdZ9MNSV8d+s0b1pHD?=
 =?us-ascii?Q?V+iDQOAgGAs5Ut7RpkZ62EAtkJw0uVJ9B+OUDDKltNGU1XY28oJj17gcrpd2?=
 =?us-ascii?Q?YFeS/QkcOHoOr/kYLl/TcksTkZPhfNvCzJHXhn8tNwCsjCq4NXZYzVDx54kY?=
 =?us-ascii?Q?zbFDSND9J6L5U0mQRHS9M7gpPHico9INn12BJEloSO9Wl0fE8aAuU6f/gZ7N?=
 =?us-ascii?Q?qtMK/V/78KfHueAmqVu1lvulQZtu64Kt664vtE4jM49xzbVtfKB6neZa/uO/?=
 =?us-ascii?Q?vHCbRC2KwxoF+a1D9jwstP+itgVKlxM1IMO5Zs2H8ZSAh80n5pqzZe0opfUD?=
 =?us-ascii?Q?SVSIjdA4R8qhcLrF61FLJgPnBxk7xljSO9uJt5VMtEyHu0cyBuz/BKXW5f5w?=
 =?us-ascii?Q?LDRsQT2qXFeK8NrhO+y/8wRWluky2CWa6M5AYChiFbY7DzN64qyiPVTm3KaV?=
 =?us-ascii?Q?XNAb3SfyNx0zIIcPOPBE26CM+345RveCRS88oWS3THfbupgrJPzwKolTty4y?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40171b1b-6315-465a-e640-08dd57d5f1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:57:35.4904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KJkp7JyOLJgyDHZOWj6IDLqGH4+7ubfzSkgbbM8/CNKHVUuaZeOXqo/+S1rzGE4/07GmxOBdTULa1KJPjZjesbbhMW2TziF65iteybLQl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH rfcv2 11/20] intel_iommu: Check for compatibility with
>IOMMUFD backed device when x-flts=3Don
>
>Hi Zhenzhong,
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> When vIOMMU is configured x-flts=3Don in scalable mode, stage-1 page tab=
le
>> is passed to host to construct nested page table. We need to check
>> compatibility of some critical IOMMU capabilities between vIOMMU and
>> host IOMMU to ensure guest stage-1 page table could be used by host.
>>
>> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
>> does not, then this IOMMUFD backed device should be failed.
>is this 1GB huge page mapping a requiring for SIOV?

No, but if guest has configured that support, but host doesn't support it, =
VFIO
device should fail the plug.

>>
>> Declare an enum type host_iommu_device_iommu_hw_info_type aliased to
>> iommu_hw_info_type which come from iommufd header file. This can avoid
>s/come/comes

Will do.

>> build failure on windows which doesn't support iommufd.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/system/host_iommu_device.h | 13 ++++++++++++
>>  hw/i386/intel_iommu.c              | 34 ++++++++++++++++++++++++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/include/system/host_iommu_device.h
>b/include/system/host_iommu_device.h
>> index 250600fc1d..aa3885d7ee 100644
>> --- a/include/system/host_iommu_device.h
>> +++ b/include/system/host_iommu_device.h
>> @@ -133,5 +133,18 @@ struct HostIOMMUDeviceClass {
>>  #define HOST_IOMMU_DEVICE_CAP_FS1GP             3
>>  #define HOST_IOMMU_DEVICE_CAP_ERRATA            4
>>
>> +/**
>> + * enum host_iommu_device_iommu_hw_info_type - IOMMU Hardware Info
>Types
>> + * @HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_NONE: Used by the
>drivers that do not
>> + *                                             report hardware info
>> + * @HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d
>iommu info type
>> + *
>> + * This is alias to enum iommu_hw_info_type but for general purpose.
>> + */
>> +enum host_iommu_device_iommu_hw_info_type {
>> +    HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_NONE,
>> +    HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD,
>> +};
>> +
>>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>>  #endif
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 7709f55be5..9de60e607d 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -39,6 +39,7 @@
>>  #include "kvm/kvm_i386.h"
>>  #include "migration/vmstate.h"
>>  #include "trace.h"
>> +#include "system/iommufd.h"
>>
>>  /* context entry operations */
>>  #define VTD_CE_GET_RID2PASID(ce) \
>> @@ -4346,6 +4347,39 @@ static bool vtd_check_hiod(IntelIOMMUState *s,
>HostIOMMUDevice *hiod,
>>          return true;
>>      }
>>
>> +    /* Remaining checks are all stage-1 translation specific */
>> +    if (!object_dynamic_cast(OBJECT(hiod),
>TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>> +        error_setg(errp, "Need IOMMUFD backend when x-flts=3Don");
>> +        return false;
>> +    }
>> +
>> +    ret =3D hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE,
>errp);
>> +    if (ret < 0) {
>> +        return false;
>Can't you simply rely on the check below?

I think not, below code will overwrite errp.

>> +    }
>> +    if (ret !=3D HOST_IOMMU_DEVICE_IOMMU_HW_INFO_TYPE_INTEL_VTD) {
>> +        error_setg(errp, "Incompatible host platform IOMMU type %d", re=
t);
>> +        return false;
>> +    }
>> +
>> +    ret =3D hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_NESTING, errp);
>> +    if (ret < 0) {
>> +        return false;
>> +    }
>same heere
>> +    if (ret !=3D 1) {
>> +        error_setg(errp, "Host IOMMU doesn't support nested translation=
");
>> +        return false;
>> +    }
>> +
>> +    ret =3D hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_FS1GP, errp);
>> +    if (ret < 0) {
>> +        return false;
>> +    }
>> +    if (s->fs1gp && ret !=3D 1) {
>looking in the vtd spec I don't find FS1GP. Is it the same as FL1GP?
Yes.

>Maybe I am not looking the correct spec though. Why do you need to check
>both ret and fs1gp

Ret < 0 means error happen, e.g., vIOMMU checks an unrecognized cap.
0 or 1 means no error and unsupported vs. supported for FS1GP.

>Even why do you need a member to store the cap? Looks FL1GP can only
>take 0 or 1 value?

You means s->fs1gp? That's user configuration for vIOMMU.
We need to check user's config of FS1GP with host's FS1GP to ensure compati=
bility.

Yes, Fs1GP takes only 0 or 1, aw_bits can have other values.

Thanks
Zhenzhong

>> +        error_setg(errp, "Stage-1 1GB huge page is unsupported by host =
IOMMU");
>> +        return false;
>> +    }
>> +
>>      error_setg(errp, "host device is uncompatible with stage-1 translat=
ion");
>>      return false;
>>  }
>Eric


