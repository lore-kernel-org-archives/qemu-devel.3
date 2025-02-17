Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51CCC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 03:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjrPp-0002rZ-D1; Sun, 16 Feb 2025 22:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tjrPe-0002qe-Ud; Sun, 16 Feb 2025 22:03:14 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tjrPc-0001eC-0v; Sun, 16 Feb 2025 22:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739761392; x=1771297392;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=6AyL2VG2gLeIInbuHjSeB3wdpT8PbHXVaJAEWEPNk/w=;
 b=TriBpw45nmLkWz+sKr/alapfclGQodeWsU8lMMeNT+apKx+m4KQAIXBQ
 Ug2NKud2iv9WaBo7foy04SlMAtd/7Dcv9boZeL1Vko3hjVuGcjufpMqRA
 S0v5wCeDKQtlP9oBy0YnPa6XEwXNNWE/bNy5o+UrQrfUXvaWNwKgQyXtU
 c0q77wpNVS+STYdBsohTCPMUS/Mnb0t/7hfottpaAK77kBCFvQfpJaR42
 VoNJH/6cy605LhS2UvY+1FZONab5jNmVLuahBIi3Id9R6nfA+swywIKks
 p3/9SbjTNtsQxOgmHT5z1j3hjoiRl7saspRpjnIw/FLPCdrbPzVBz6ruv Q==;
X-CSE-ConnectionGUID: KJm1yXQQT56Ij+8lxoK1bQ==
X-CSE-MsgGUID: a0KkVotCR1KYy50KvEb3ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40139814"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; d="scan'208";a="40139814"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2025 19:03:05 -0800
X-CSE-ConnectionGUID: YisO66ChRDahGbcoHEvVsA==
X-CSE-MsgGUID: oipkO5/wRYeY+JFCdx3Ikg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="144917687"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Feb 2025 19:02:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 19:02:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 19:02:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 19:02:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLCkod0lfyEsU5FMMhyifdpReoSLW1BI0NYiorZgwRkbWPmMf2nYO1q+1wuPuHLY18IYq9AVF5vxmEHSaW9DQOXd7igQ9VkwQCl6kw/Px5zVuhGBQstLAUh0YG70LRB3LWID18ltdAzXxzvs8OxkqgUrqdv74m3eHv0AaltjxvdPsC+FjgYAAMPGtE8BasV3BQjB+NdiVb2qJ9qr2b5fCbDMFgVGaqVYBFyFN17zZnqlWErFKqlVbt0utSrfek3IiM0Y9IrPwKEdo35g4rGXM1XTIgY/iNXB107YhKYuUAJreKNBwI7dm9OQZNtPdevtH2KfxrwsIMkYv0QD9jlkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icg2IRjoye0fc7b9FxcHUYrHruWinQscl16vUcH8uqs=;
 b=L8NBy5Enm25pLaZpjVRp7A0q5FqC26vpYr7V7ocKMAm2FbMwc5xzoajEZQ499HKSpZXXyt8kJ4I9g0Am6SzXcqhPXc6GhwjOp+it0M3EZ37OaDfQfZtPS+xJ6OZ38oLztgFf0Bj6OU2WlF9cvjg+GRXln3NSz3u29uMKfuh6c5lQTZjCNld+WEifx6LImTMI9Sw4RopJlN6kz0O1TRP79LAFBKYNn59ojwMwFKomflx8Nug3a3gbxHr5FhTj3y+p8bngt61/xUTZIGCX0qik+ALMgq9k+3TLKCKtGKoPySShN8Z/bvr4DZvyhbTYj1Jc+rSYjqMYtyk6zcKo1hyZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 03:02:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 03:02:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>
Subject: RE: [PATCH 3/5] hw/i386/intel_iommu: Tear down address spaces before
 IOMMU reset
Thread-Topic: [PATCH 3/5] hw/i386/intel_iommu: Tear down address spaces before
 IOMMU reset
Thread-Index: AQHbeKLMyYd+oAvkI0aAtbyMJaiADLNK3oTA
Date: Mon, 17 Feb 2025 03:02:52 +0000
Message-ID: <SJ0PR11MB67444138EAFE0660733B315D92FB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-4-eric.auger@redhat.com>
In-Reply-To: <20250206142307.921070-4-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7557:EE_
x-ms-office365-filtering-correlation-id: 2b63b085-469e-4fd3-de7b-08dd4eff9201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PWXD2wX++BpW5zfys6CObbzs6xI3bP8bBl/WHozp7hWB/ginWD0MfzZ9dN+b?=
 =?us-ascii?Q?gXHQupVhJLMNzEdryMOPG3JnhlrrMW+jG755w5ur9z03AOMuZ+tEfApexGq1?=
 =?us-ascii?Q?eG4XYP2ZWx7+QSfFRR23Gl+4E81Wq3oGNgQNqj4mJ9LqeYeAJqbIpHjLM6JK?=
 =?us-ascii?Q?8FWQxK7qzUEWOye4zLU0pdBPeasSdMOBXukPqGr5HTjquXeIMr0ObkjeFbHQ?=
 =?us-ascii?Q?Me3qeqqjDM/Gx8lI5toWGVamzr1r4j2Qva+u0tk5B2bmVMIR8evNj/9y3Dkc?=
 =?us-ascii?Q?/rtxRKJW0zgdvtBJ19GpaIWIUF9QTI36luRqJhWq0eVT5ev5I7WAi1c14JwX?=
 =?us-ascii?Q?Q5jNofjb2uvOAPbKHnRF+lorKVOhN7ILQa8IWFcSfHWR55wMpPo48vSQE7VU?=
 =?us-ascii?Q?cmz+uee3zjfVXdRMwGmWj5vd7AVC46A6R42Fbkc+Qk9k3tzeXgzwyi5Hbend?=
 =?us-ascii?Q?ofU8EEyKcyegOzRPyP3uI+2w2n56mo1I/opFjGrIiUVskjybtXsrhMi+VP8k?=
 =?us-ascii?Q?xFhVw26mOKkcj+pLyALJBVABqYVmKMpG4sawcciPzycMpZeAQPlgAlz0pKA7?=
 =?us-ascii?Q?VvV8R1luj5pmjaNuPDTvmgwppTH17oeQYpyv8p1MCR5u+jrDAA8DGBeEJuvJ?=
 =?us-ascii?Q?wUCNbl0Bu4TzymkOey7cUguzHHMMeXK9kkvFrOGUXXYokf+IdhZtP10AHyaD?=
 =?us-ascii?Q?URs0kUu1rgP9/Zr5JUdDS+dmJAEwuk3dd7wmCOcmsNnNzxOGH3GYY/SilqHz?=
 =?us-ascii?Q?F97On0kC384nSFlST+cBtXy9Rtu2WbfL/coUkzxY4lgkOONgjKTEZo2FT40i?=
 =?us-ascii?Q?gjFwLEr2LYZ/YzLEJgA3J09S7oKm1G4iGp7DxgeLfrGuEFyhFYdvLhCH0Drs?=
 =?us-ascii?Q?6sJ/vY2uljWkbjDwV9fGuNDoVDiEBH2cZncpe97KPQGTLRC5y4wQDQP1QpIc?=
 =?us-ascii?Q?QyVA+dG6Qa+IT6E4SNX9SylDKdKP4G1690Mx0jYTew13hFhdz3iy/WHd33id?=
 =?us-ascii?Q?OOS+ptQKq38HVQ+sCCK+iUvnuQxR1tY8pjzJlQiuaC5lUwZs7AdYF+Qz4nbw?=
 =?us-ascii?Q?zZgZrsseLOVI+hZLL0ezLvcker4QfBVt5L+qI4vAowYIrfO8D4S5SoEfwkWF?=
 =?us-ascii?Q?KparuDa3bmYf5xGfN2dNER6wIZW9Y7HOoZXozh+EkBvMHsrODUh/OFWJEmHB?=
 =?us-ascii?Q?vYcr19PaXqzZh0aZf80mSZ38KRpA7HEr3fBopz4ofEsHIumIVSk9vMaUci+f?=
 =?us-ascii?Q?agLAtqbNHdab+qyGlcd65GQDl8T2hFszbuvDCPobX9VJBLdw938TvutfXTyg?=
 =?us-ascii?Q?ls1e5YROtuIxw0c629xhkM5d1I+9+nxS9ObBvJDSG2VrS6VsitkyqturfJGy?=
 =?us-ascii?Q?DqQeXItsSFxc/jXj0UFL/8CNHHGPrQnEPwq4lpaxzQgev4RMrGlVt7jWTZg6?=
 =?us-ascii?Q?oe4XLv83x8VQ3/y+MGixN7Ia0Oa/bHWtAPREnfEWVvS+gaHFy5S1dQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6wcqf1A4nHwKyC+3AosSwGpxW9QruXwoU8/vvH+fc3pYbP4fK8+p+5fd3VMx?=
 =?us-ascii?Q?phnha1cS4v5G3tpdpNS+CZlHRkq8bMrMcsKC6rKdhfG3fpigozuyAZ/bDbzq?=
 =?us-ascii?Q?fNNchm9XQv6xWRaiVYbQASc/KFNXY18UtghXZy/Ts1Bminbf7wxoErj7shD6?=
 =?us-ascii?Q?z9XLCTPe1B4LkJTMe08TsY9zeVCPRY9sg2lnahweW1OwyRbJV61+5sB4BQ/Z?=
 =?us-ascii?Q?eTjnWAq0zu6//UYHsEWNiAHc1lxL/M4ynBKd/DfSUMQq1T5oETMw+ePwtWXy?=
 =?us-ascii?Q?qPd6xQnSRA9v7FymWpzZ2+F1WDvwa1hiQEcMlNO2MeTp2WFEpwErVSYJSELd?=
 =?us-ascii?Q?hPw3U3pEemGhuUG7wfNVDApd6ViQ1sUHt5qqdUmwRHf1wVk+OgWYJG4RBzu6?=
 =?us-ascii?Q?qWZq524JPUVzlX23o/RFx4ozjx3DhW4D6fFNgcOQpP1IBvsYIN/nCuqlwv/E?=
 =?us-ascii?Q?shImG+R0DjWoHMkHnOxfG5PJuvhrEm6BN99P738IQtnuPD6QpufZUq0Q1f9Y?=
 =?us-ascii?Q?c7L8zzLOqdcUIJRUd24eX7Os3FtPSqLL7cfj3TbD28m0hFW1sgKG1NNh/q1X?=
 =?us-ascii?Q?e35FqP7InMst8VxwgagPd4k5lJvTfUU1X4hq5kE3iDfOLp8nNk13Im/iXRuQ?=
 =?us-ascii?Q?TqV+YB4eZZdZoi7cXsoLKON81+gyCYKFPbfQ5DFcu8st5Ff2EtCHD7MKpyyn?=
 =?us-ascii?Q?r/s82JGI9mXm9GIZr81RWTHbG2utQYMoUteGnDhZd7vBoaVF8wo1nPKCOvje?=
 =?us-ascii?Q?Qbf4Zv2JufnBuPeib80c31Cc7YLB6HLja1VZR+ClDi05j684Ih7x13C2i3yW?=
 =?us-ascii?Q?ZNg2T4gzn+2yFGgsAEB8o1/oY8A54NoxsFCcDuroHAH+uEmikeJrFjFEhPMe?=
 =?us-ascii?Q?fAQLVCxScSVXsVkBZ7QPE3xHegzExuunBtA9qorihQkvC/uhw3j4QQx8msco?=
 =?us-ascii?Q?iIt/6+Ql9DSsUIgeLz0sp5FmSRHA+YUbRuTGmRxCmQIZtqHzB1fGT87wZdjF?=
 =?us-ascii?Q?G/U2b9miXj+4W3gtJo/lUirSsv4DEQWvT3De5AIRyBgb/uyIfU96s6b+tFbk?=
 =?us-ascii?Q?vxRasJbjAWZL5H4UjW7c94277vBD2Q/3D0brnqpQZArJ7SLW+q1pxkO85Cp1?=
 =?us-ascii?Q?H+rsWwXe9+JPJ3n/pp4ojdQcgeHnTZ8pe1mPbWIhgWA5YUJuP4qF3qDi8paV?=
 =?us-ascii?Q?VQh0J7SUtPrWj2V7Fo6TvdFu2afqw0+gHWYyh8RbeKnHgyKA8Xc3fmsXbgtS?=
 =?us-ascii?Q?0BH0QW+IxUzBmcWCZyySo0Do/9y7n5OsDjEyfB2kQ3BsrhCG6YAkgb+cT/5J?=
 =?us-ascii?Q?0diFmOVrAJl0CieR12loozoecgxoy/bM8ekPMDN50cRKDgTHzLqnPiXAXRCu?=
 =?us-ascii?Q?yt5WsBENwzw6qXDP36X6PzvfRPt3Y8WU6bEHqO54NmuXZpjxA8wK2o3zlQ0k?=
 =?us-ascii?Q?P4tAPsMWBHRgqqaEH3pgwBOzADfQApvUk1HU18eNmL0yPJglGD8Aw+wWhaVp?=
 =?us-ascii?Q?Dc8dhdCkqEPXtgQiVu23ZmH1ceCvsqsCmTqNByx0SsNp77Ok62GVUaAEtwZ5?=
 =?us-ascii?Q?PIIjtA5Nr1hTZmeF5iQjz9Szul8N3frf9/4LOZQ4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b63b085-469e-4fd3-de7b-08dd4eff9201
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 03:02:52.9479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRdASUVXnlW78Aq7Aufb+eG14yW+/dB/e7LjH3Kcvk3WdGJSOW8smksE1yW+1/8hb6VpPnTgcE5nJLZ+47sQYRl1wg5XukleguKYgPRce3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [PATCH 3/5] hw/i386/intel_iommu: Tear down address spaces before
>IOMMU reset
>
>From: Peter Xu <peterx@redhat.com>
>
>No bug report for this, but logically tearing down of existing address
>space should happen before reset of IOMMU state / registers, because the
>current address spaces may still rely on those information.
>
>Signed-off-by: Peter Xu <peterx@redhat.com>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> hw/i386/intel_iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index 21a8bf45f8..1bd9ae403b 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -4702,8 +4702,8 @@ static void vtd_reset_exit(Object *obj, ResetType ty=
pe)
>     IntelIOMMUState *s =3D INTEL_IOMMU_DEVICE(obj);
>
>     trace_vtd_reset_exit();
>-    vtd_init(s);
>     vtd_address_space_refresh_all(s);
>+    vtd_init(s);

I'm not sure if we should have this change. vtd_switch_address_space() chec=
ks s->dmar_enabled and vtd_init() updates s->dmar_enabled. With this change=
, will we leave stale mapping there after reset?

Thanks
Zhenzhong

> }
>
> static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int
>devfn)
>--
>2.47.1


