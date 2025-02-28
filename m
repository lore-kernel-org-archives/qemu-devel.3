Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B49C282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvny-0000wT-4l; Fri, 28 Feb 2025 03:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvnx-0000wG-A8
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:33:09 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvnv-0002r5-Cy
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740731587; x=1772267587;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FhRI41eC+VwKXEQAHm6AU4aNsdNlD+3SA0b+HJnzf9w=;
 b=AFughktcDvHnScnSJQqfNOvUK4h1dnhF03nUHeZhzP3zPB6N3tivqNXE
 lanmC16UgMVxTYhx4kEDClbPC8TmfIcFyFAN8iGARHJ77a53SwWnW5sOc
 oXKeSYgF7lNVDsDwMG68bnIT5IjYterzWM6pvTQZBO5pjyoyxTD5zqnVo
 s4Bkgm/o34ChG+IILWI3sLxuEvFK23YMSlUITLG8Yd/+zdMtRs0YrNdm0
 R3IDZcCN/ijXdyomUx0yH+7k/kX9ydxMLLnp0oDgfAMiv6NzU+Dvd0ZTo
 H3lMlmXUWqX2yzmrVSfCWd2DHCv9XM6T7sDRgmPfchiMoLAsJzN//RQ/6 w==;
X-CSE-ConnectionGUID: 3z3R7x+nRo6kDGEwJe1+YA==
X-CSE-MsgGUID: BDPEg3FtSLSWX5jGh4cH4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41904948"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="41904948"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:33:04 -0800
X-CSE-ConnectionGUID: QZHE5m+SSN2xsrXWSg+0Dw==
X-CSE-MsgGUID: amTfufvyRwGeN/AH8sAQ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="122221971"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:33:04 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 00:33:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:33:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:33:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQUjtWGLD5LrH4DFb3vDNYhApoEIDq+DwzpJ1lzDRLv0plD6daOLtLS6DR4sJxfIaxxWsiVVtsyCt2wiqkF+o/BwlEBHb4iU5L0JTxWbCKOytJkIEXiQQ2YyBA8j0xepaielyM1dnZB7qTWHkN+bsIyiafMDdUgeiJSgWRn8TYadebm0LlrxgZsSh6s4pwvIHBnC2EQALStn5A+qa46CsdFRs5flvVSqlPZiAcGBSXKMacuT8iesU6FhXF1bY91H3ocJcIbsxuXUkeLdVnDm+yy5nDbK9oRBBs8of5sqCwGcaE65Bti8hieSFw+6kICjPSSfCDN/4GwtdM4YTjs6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCTLimF1Na+pA/AmSusz2Lgbpewi1qkwAJ895HitIio=;
 b=GFYAk1jvq3I8WL2wKgr2V5Q2psdkpgEABsDlteVFvII9kty5jvpHq7x+W0SUbtJOwo9bWfxpguT4EYcsPQpftR1xsHEdWlSWjMIwTTutSGB+Xie7c3SFPC92uFMAeLyNz2rLIfJwQUPTDne7Wa86moiYfrDg4XUgthe4Dw3kMgVTHTaW6cXcK6FTGZ+X98UQQjeOYj18v4syXwQfoeHCEkpFkp9eqiE/OyM/7tyCqLYqiVsMhJCYTAQwo7R8UjtWLKKBM8sj5dHrwSiCwkeT7UCJVKgRxLD/FdJxtRAsaxLWdw4T+PWhOCC95AJSKGSHf3sHOKIkPnD7cDk6HorMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:32:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:32:45 +0000
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
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv2 07/20] iommufd: Implement query of
 HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Thread-Topic: [PATCH rfcv2 07/20] iommufd: Implement query of
 HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Thread-Index: AQHbgqgFNTczvVKt3E2FrB9fI7E8XrNQjjUAgAprgTA=
Date: Fri, 28 Feb 2025 08:32:45 +0000
Message-ID: <SJ0PR11MB674431265A37DF6828728EE992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-8-zhenzhong.duan@intel.com>
 <c37e7e15-89a8-4996-9aad-10417a032f14@redhat.com>
In-Reply-To: <c37e7e15-89a8-4996-9aad-10417a032f14@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5062:EE_
x-ms-office365-filtering-correlation-id: 5f38b6a0-6479-4486-4fd2-08dd57d27a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uyxqwq9ZkMw40mHXgrkZbvGkce5h/+UtfEoCiDl74DRTGUYp4OlH7loJyddn?=
 =?us-ascii?Q?99BJubc+mOhCxf47r5BaLUQW3Mxag1iL7NMZb88ppVzl0O6C35P3V5Gc515s?=
 =?us-ascii?Q?OA9wcH0LR6astec5f7B2Tr7ikOc0GqfjR/LBF6oLRyx4ZgRoO1ZauPq+tu4g?=
 =?us-ascii?Q?WYvPI8Og0LE7Ar8pYlABmAija3HtxraQVJ+zf96fvq2xha3e5mlh0QBBoUBM?=
 =?us-ascii?Q?BRusbmt6czYBMGiljSWzdOcVy492XjR28UhqBpqnQg2ClqN0DH+YZiu88Lyc?=
 =?us-ascii?Q?kqQnkDBacN7u0nchn+dztyPkKudGZKLr/RAOjvKe1omX5Pj11N/KYl6EeaUK?=
 =?us-ascii?Q?lazzz8nCP8GFQNVt5tGlDfM619036ZfQDnAJOZRWPUIubWq62Fwijw3CP4fD?=
 =?us-ascii?Q?wzTSF6fhFzh+bAwtH9k5PD24yJklkgUE7S7kPgn+HhYXh5ynmQtfg47tW3nF?=
 =?us-ascii?Q?oT/2mDpvK1ajvN08uMmVtedtvH1TjCPARDqmDypiD866LwhhtwakcKifjK66?=
 =?us-ascii?Q?SLXF8RrvzWHVbltQ3mwg50UoAhDhHRhJ18Dr3m6qsiAZely4EaB7a8EGb4KH?=
 =?us-ascii?Q?JXviIrHuo4mROyuHN5s2KgvsM7qxPYf0v1ohhaYM6swly9dJ+EwIezWIU2UA?=
 =?us-ascii?Q?oycGzSW7qvxMGLwVk6LvTBIuyh/5HkC6rq9NG3OiqyTLTOa8CN84V8lj88kV?=
 =?us-ascii?Q?6YizCwOSBWsB06c9kgg0dqd97+K/HUG9xkUWdEbnpEQXlSCFuyIJc+UQLv51?=
 =?us-ascii?Q?dYw3fDDAFiM1IxWddZAtxqpD3iR8AiFpt5oP4AlFfUz/gy4oWzLbO5XD5XGx?=
 =?us-ascii?Q?wcnkr9c1S9CfGcpBaU0BAcekW6Sq1h1JNZTeKvanp5zIW37o+OFkSXDHs2zx?=
 =?us-ascii?Q?emBAHBrrf7zUzWmfoaDHp9Zn4ugEdG9LY1ovzW+OHEB1+3FVoKiOsqUGnwrp?=
 =?us-ascii?Q?AKhZUQWI4+1g2/xJRoIc/HAfvVbg2Kp1rliGB23gi2CWR7QbLB3trKkRnJe1?=
 =?us-ascii?Q?fIQkYkkQz7HJWsOHkOziEL0lRgEB9d1FjKVYxoSWc9Fs+C3DfXdAGRsCRYJT?=
 =?us-ascii?Q?FMFB/g5lkxCRLefVQoNOQJucfpKakyflgYh6+ZCRHi/cnbhtnnzmdErz/xtl?=
 =?us-ascii?Q?vqv1rqFm3+6DT08iu6R7oO09w8lvQFk5sncf0hHK74WRSNfKr97MXBFjhxNe?=
 =?us-ascii?Q?ZZ5qdG0FLfUXJTqlsilsjOjgKkbd6tyVSC2JJH7hT7HXHOHwNnI6BIDZoPss?=
 =?us-ascii?Q?D0dmoX0UJZQdypaIkiCYU8h04cv4B0K4rpD0vHspr4TA2X8xYcLSwpeymM5g?=
 =?us-ascii?Q?xByzp2P4VnkdIR/cFl0Z6Ybus8WxijpVzHeeNLjWptTsdTaf1v/TbMC9iVPg?=
 =?us-ascii?Q?CKiwJsXxA4nn0xZ9ZuO/87O9abJYlfE8hj2OhB96Luyic6jfGwKnAL9zN+pY?=
 =?us-ascii?Q?boPcv0tKesP6+T6XsdA8m70m/UFAqCIt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/SJFLzjHQFS4C/TBWpQ9cT/A0KIHIhNkSnExZW1yEL9FeEIsRzJsyYFE9gCz?=
 =?us-ascii?Q?O3JEKQO4ZDxx5W758VTAnqaFjz3fOPTjE0uN/651OfWpiWWmE2Mi2crjFAYi?=
 =?us-ascii?Q?Y6ZBbKjiRQEc/u5SIyt0lNaE/NIlY1K9iPH+gQFeCGInfGMevoqDwKX0dY88?=
 =?us-ascii?Q?T8WFsm1BrR4vyzTFP2Ro7gax5T+5/NbVETK+06d8VmJkpqzp7EuJK+OjaHso?=
 =?us-ascii?Q?V5iaUkCiCouXUeLFC6+KknmlrjOIepbMkskefGFPhIhcO8xlYp3A6UBWTy5i?=
 =?us-ascii?Q?c9ptHmC+pmdtXeZx6tmjbXYZxGoWXUrMN/c0E3sbingJZD7gdYTkpNxw04RZ?=
 =?us-ascii?Q?vHP56sgZ2PxwpO8e7LZYPjMIlI8WARJVj/jDYaFNyIACMEo5iUbFA8uZIjIS?=
 =?us-ascii?Q?EPktqrh39QOq/lD/aUkWUaG7J8ujxBoS5OiXhw+WVzdHdQle4JxB0DjdHnK9?=
 =?us-ascii?Q?9gkzseUVo2AvIVeXi1QyLukByF4NlYSHaUctUCYVsI1Z3tRTIO4aLh3JLpuS?=
 =?us-ascii?Q?BFHzgooo0eO3/zaU20+VcxcwJ/XDtK5xV/MlXVozBlEw9CPFe+qMGn0lDsic?=
 =?us-ascii?Q?hud2KO+tuXNyAnavSf+qkppAnmpP4aNc8PUHCosAAhDcIVJaBSLjQ6pDWyV+?=
 =?us-ascii?Q?BxckBEMgimLgpYyW72TNRye8RPZevBgaG4If2KPEUHwaXwp5IV7UID8MHc0r?=
 =?us-ascii?Q?AOcvU24oUbfxpt3J7JfBtyg6xplTEiyZNYghcGmVjqGDWchdt8vwykMvBhKG?=
 =?us-ascii?Q?8ikmqc+V63Q4AXXhF0na3U6SQGP0xPw92T4tf6fzh3yiFIGBPBLVIEu7tZd0?=
 =?us-ascii?Q?y2xPnBK4Fhmqe4knU+xmKy42E82IHOXFxk2/vEWw/ovNtgOp0BUIwrgYzGRT?=
 =?us-ascii?Q?TLMc8HeNo/gy4/ZMPdT8k1FuXyiJlNboCfR3dEmkHFDs+ZSLpcKtoARc94Do?=
 =?us-ascii?Q?nAX2KU77MDWQ0KyA/4aWZvWdJNO0OA1SvNbxQO/o9Jnogdn9/ELQJZtD4oFM?=
 =?us-ascii?Q?k7FLM38DlCWb6BCkx9ZX3UvP1ltDssgHg/5z4usVx/MNIZkNbSt9XhEc31Y9?=
 =?us-ascii?Q?NrpP27L7vQ+dfR4zW09FFksUKGzP9J07dvQpNqAy+kv6HTQWg4aMRC10pAxr?=
 =?us-ascii?Q?WLkNGDvsSsP+rN1zqNhX0BfDH+YVzdRMovWI8ebAztLIgCOdZkST/evXH5Fp?=
 =?us-ascii?Q?auEpZ1savxqcskomlsN0Oqn94s3igfQss2QYcl4MJwlev4dn9bE1oxaCJ5oI?=
 =?us-ascii?Q?kwYhc5+IFUEpqRFGGiwO3xfL6xZ9On13L3Y53R/Hn/j3DeChXStFT+4bs74g?=
 =?us-ascii?Q?SYMT+ZoJjrH0u1ugrbX0qG84bRLmbH6xrZQsP3E/6PWs4CPoDExXWQ9mCiWn?=
 =?us-ascii?Q?7DsXt98MadIAjW4OM38Tye2prBvnWp81lUPjygiCpNN5WvC3CdAipKq2bb/3?=
 =?us-ascii?Q?H0APfHi4j21875u+dCvlBOTFU2NctsLnUcBTYDr3/c8FdnVDyThjwCY+eHvb?=
 =?us-ascii?Q?kPXdr4g1HDrXXYX7w8FVmb177PaY93ZBx5mtLLLflOVTPXCBfl5vDu5JmFNn?=
 =?us-ascii?Q?dX1bmEZaLt3ccjhXXZ9k6sVzlOigM6m9M4SfSuAs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f38b6a0-6479-4486-4fd2-08dd57d27a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:32:45.7565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHZw3NJsuHXhT/gOfRUnxsfsxTNVNxpyHZDIcKmrzuWQhUbYmpviS3e28jp9NDT5CHOfCwgOTr0Nvf7AIC/u0sIbIh9P8ipB2An94YjT5pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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
>Subject: Re: [PATCH rfcv2 07/20] iommufd: Implement query of
>HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>
>
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP] for
>IOMMUFD
>> backed host IOMMU device.
>>
>> Query on these two capabilities is not supported for legacy backend
>> because there is no plan to support nesting with leacy backend backed
>> host device.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/i386/intel_iommu_internal.h |  1 +
>>  backends/iommufd.c             |  4 ++++
>>  hw/vfio/iommufd.c              | 11 +++++++++++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index e8b211e8b0..2cda744786 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -191,6 +191,7 @@
>>  #define VTD_ECAP_PT                 (1ULL << 6)
>>  #define VTD_ECAP_SC                 (1ULL << 7)
>>  #define VTD_ECAP_MHMV               (15ULL << 20)
>> +#define VTD_ECAP_NEST               (1ULL << 26)
>>  #define VTD_ECAP_SRS                (1ULL << 31)
>>  #define VTD_ECAP_PASID              (1ULL << 40)
>>  #define VTD_ECAP_SMTS               (1ULL << 43)
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 574f330c27..0a1a40cbba 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -370,6 +370,10 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice
>*hiod, int cap, Error **errp)
>>          return caps->type;
>>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>>          return vfio_device_get_aw_bits(hiod->agent);
>> +    case HOST_IOMMU_DEVICE_CAP_NESTING:
>> +        return caps->nesting;
>> +    case HOST_IOMMU_DEVICE_CAP_FS1GP:
>> +        return caps->fs1gp;
>this is vtd specific so those caps shouldn't be return for other iommus, n=
o?

vIOMMU should not query a CAP it doesn't recognize, even if that happen,
zero is returned hinting that CAP isn't supported for this vIOMMU.

Thanks
Zhenzhong

>
>Eric
>>      default:
>>          error_setg(errp, "%s: unsupported capability %x", hiod->name, c=
ap);
>>          return -EINVAL;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 175c4fe1f4..df6a12d200 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -26,6 +26,7 @@
>>  #include "qemu/chardev_open.h"
>>  #include "pci.h"
>>  #include "exec/ram_addr.h"
>> +#include "hw/i386/intel_iommu_internal.h"
>>
>>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr
>iova,
>>                              ram_addr_t size, void *vaddr, bool readonly=
)
>> @@ -843,6 +844,16 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>      caps->type =3D type;
>>      caps->hw_caps =3D hw_caps;
>>
>> +    switch (type) {
>> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>> +        caps->nesting =3D !!(data.vtd.ecap_reg & VTD_ECAP_NEST);
>> +        caps->fs1gp =3D !!(data.vtd.cap_reg & VTD_CAP_FS1GP);
>> +        break;
>> +    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
>> +    case IOMMU_HW_INFO_TYPE_NONE:
>> +        break;
>> +    }
>> +
>>      return true;
>>  }
>>


