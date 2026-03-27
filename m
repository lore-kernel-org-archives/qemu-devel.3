Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B1F10BA420
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yNi-0004Xa-Aq; Fri, 27 Mar 2026 00:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xudong.hao@intel.com>)
 id 1w5yNT-0004Vl-VL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:00:56 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xudong.hao@intel.com>)
 id 1w5yNS-0000KZ-0n
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774584054; x=1806120054;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9gHXTInN4zcvBm7cd/ClDcmVNaSdMREFwzfuoi6BorA=;
 b=Yfjc2x3CQJpCw92tLxc3KpL9X2JbijoVDqRWh4pR3ckDTXs3bCAqvbn0
 niDXJFWNrMwZeeEMgxnH7iZIfMTpohI2IAaviu2+JvFP1wnnASdznTNOe
 YZv3H201tBeDr0CbZ0SmIFLzdU9njZENMnG8Fa/2O53wF/ZCshYbE4BI1
 l4e72JfgIrdbkYl/Ct4VC5Q06d//jeJNyaCWLg/0udw/Bx3uwsSB11qhP
 rD+F+ILpybKoPCd++8KU6aSC+TXzlufBtiVwWXw0xcxXqWctGg8a+2zRK
 owcTy/dYelqyYjxTGCUi08AjSmWvKrQr2ffKCEpM7xMJJkgTPehMrXvEB g==;
X-CSE-ConnectionGUID: ZktauzhpRhWELpXKPHsL6g==
X-CSE-MsgGUID: EaaXeS5BRQm0ZTMaBGAPmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86349345"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="86349345"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:00:51 -0700
X-CSE-ConnectionGUID: 22PH8GPaQ8aIcNG7PhgZhg==
X-CSE-MsgGUID: utwqUGpJQmWZrmtzS7JKKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="229980134"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:00:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:00:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:00:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:00:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/1OaKap08Lm/Mfdj6fS7jy5e3KgTv1UxCsP/H49voGzPCzjNET0n8StYZmpaRTfAc4ZVUz9xzlfYTJ2r6DL0zY03vgdsevQfni7A9MbA6BYn9VjhNhpsUWQQc6UmH2g/tTamYWI6EG82FXCNLAsQpFQOiy39pBKmiyK4pmvh2sXqKjV7LgvLPe1QdhSXaGapsPaxhdQHCgoNZRgvJvdzl53gEsbE/wKpEBptpiC3LfgJs6ETHbwdp2OC/i+7V5G0PIxsgVJQE17X5HKkAJ6isB01jGDKb0fYrIKNXIJtcP7d1Muy0iHU+xDz5VoSJYM3NodemZuY/sBTmYUhLr3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUssj3jACYAqIQdUpe2FG7BCigUsyIaRtT4Hcqu2bag=;
 b=ITYhZn/dHTTajAN6aYMQzL7NeNU3qjr+FUwVHj3WqjXq85kaERa7vCJZJwzw0UpzRuUdwk6oGVAWeJv66KTQFNWr9UPIQATYpNSsDb2y2PC9ILFbkxWk3BBc88FwtD69SQEia0I2i/kxd9QKhH9aoSPvU+sKCF5lzjWr5v92sNiRXmx/wGWJmOVlQNjdWGHDuFUGBwTWQTl2bQ94M62W6uNW/43hEDPMakX4r33t4040SsuSl92cLN1qU8M2vpRQSQsdHwMoMbMw8kFd8FxV+MtQhyIhWBvs44i/TyU4OVEVTm4segULGd2zlDgcBXDhcG9t0/zlnouZ4jDnoU3c3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19)
 by CH3PR11MB8520.namprd11.prod.outlook.com (2603:10b6:610:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 04:00:47 +0000
Received: from DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::1ee8:ba94:dde9:5267]) by DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::1ee8:ba94:dde9:5267%3]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 04:00:45 +0000
From: "Hao, Xudong" <xudong.hao@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 0/5] intel_iommu: Enable PRQ support for passthrough device
Thread-Topic: [PATCH 0/5] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHcvZTJ+WxRXZjLMk2//xMrh8lu0bXBwMKw
Date: Fri, 27 Mar 2026 04:00:45 +0000
Message-ID: <DM4PR11MB52784756F6707B7246B1B68F8857A@DM4PR11MB5278.namprd11.prod.outlook.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260327025228.474257-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5278:EE_|CH3PR11MB8520:EE_
x-ms-office365-filtering-correlation-id: ff2795eb-c24f-4625-d82a-08de8bb56c6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: +TeFOZd2n/XB938Adkv9nS+VG+2Ts8WwgWiDGIocCJNAWqCuDwCezAUM4tlM0PGYc2PmjPhVnmuwMBArYNrwjdeErpef1ba/NRixEa/Z7a9yQoJpWkwjCRtJljl7BEFtUuVNqiXmtSlidcDxqOSL3TgmW10JqwUSuHYKQlpphztlyztdt1MPDaErCHfRgsWxryip5Vo+BWmbspunMEolTOYUhO09oH2K2siOJ/VEgmkqzB0lvMMrsoriotQXE/V0OpnmP56vpXVWWDBMkspzdlL8V76nsZVFrY+h3APpu3uqNOtTZ5pnVbq4CRVtaxNIjciT6Kc7+AI2+MAyB9Nc/eDGmQoSv7x+aQ6572KgXGf87qr7mTZybZ/DajDxLlR0Ltjc+QxZf5lJ/9lE9wtEDxxpfiU7asdpu/JR6PTXFQ1x2HPKcVVTRVVTCaItgsuq7V6B4+fIV985EJg4vZfolfw1KfnZsNFuL0IfQ+KlgAfwIKbsINqSKzfpkNoUx80Vj6WgTgVyFXNZbnQXAbqd0Pmt4M/h1KDL8ZgdFOilSTbBd/i39VjxLl9AcxFNj2Ek+ilcBvgL9/efFgu+EP2KtEmzCK6a20shhJn9Mvza4yroc3dJArh8WEEWO/IHQUeaETFIZ04ftm4xbL8GYFReT7KjMssFKzAs//WVivlMKYgNYSZu6YnDB0Xut/Lc+sX0XF1kZMNZZrFrhR00KcxpJA0z1KFsGqP44/i/qTIENulliPf9udCCtWJNMVwEiWFFlGBx4O/8SYSWFl2gsR31lA9ftqT3QBOeqIF3SQCePljfNC2rz+4pI05SljOIY5jD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QhEN/YVf0Tp6E4Om6p5Agw1hlsXWCc2txUd4+/HFaTdsMZ1rfhfXMkVVcwzg?=
 =?us-ascii?Q?A6fNXlgGTKQCb+tnPCO33Oqy66gAA2bKlVyK/bUC425HASN9+R2tohUqlC38?=
 =?us-ascii?Q?aDtZYTkdhluyafIZqMppAMBC+iPmuEM+hVF1CTIxWbZsnECGRZUnYks7szFm?=
 =?us-ascii?Q?UGs2Ctqn91rIAKEGRxmAFu1tU6SigPcsaJIHx07kh70Ol1TrRaWV9Mbqt6P6?=
 =?us-ascii?Q?3MZhnZD2JdY4PD3qGsmG9zEJs9yNFByeeExRUzP7eB1XXhk7r+OOW1c0W0GF?=
 =?us-ascii?Q?MEXyLNfOpFEueXi+sEKBUtcy5ShhFDMxFIGHEhai/EZzJ8SxBs0GPMzLjU2e?=
 =?us-ascii?Q?We+hp7McwHpg1O8jM7aGj/pxx3IbIQbNCaNgc8+V9l1B8kkLsZhcBprZIlgK?=
 =?us-ascii?Q?VIrdv5Ks9YHiSIYpSFiPaJdq/JmdxD4yLOHxfRL3+m8f0WfJ/5LrDDSpOwn+?=
 =?us-ascii?Q?gdpRLHC1A50V7hki6iQGxc+REl0wZsA0cRJU2MjC126WJF5Bokt5GzaEKCYm?=
 =?us-ascii?Q?pahXuu3UgwlTvzv/DY4eqHS7Y+vvDccL3xMSLhzj1iB0BiLlXNsExIC4A2+3?=
 =?us-ascii?Q?MQpaquv/TiMAPaR185aD39TAzvrMMwzSQC0ENahM1BFGAoUiWllZ1YEGS5n4?=
 =?us-ascii?Q?oo0dgjlEVlTXiaXSTgHTD4biRYLOXFC6vY7EvC47GitNtz4fx8MKhUfOr+wJ?=
 =?us-ascii?Q?F7MFyBubKiAflqcHblTEjTldur6JysZbvyHEpV5SQCddXRJaJqI390QW1Pey?=
 =?us-ascii?Q?LWVKSo7Y628pRzb/ZqTBY3Xd9ltfIuG7nhxpg1Ftsx1EntpkFSDsmDATkuwc?=
 =?us-ascii?Q?4V+FMObxPpCeLPUrPJHoF0oK8rkMI532TFReifm1rLryS5H2mu71utPP1iN+?=
 =?us-ascii?Q?V/XPUIPvsvsKnNR8MOCrJfXugGbJTAhskGVRY/iAG83LIOLal5HJcyuzqkFX?=
 =?us-ascii?Q?H0JRVEM0N/RB33wSje0DYTrWCr26zX9ZaVpsZo/qN9OjeFcoOSfIeyb3YYVk?=
 =?us-ascii?Q?y4PNLJg11F9zAlTCh3OPjtmokC2XWvgcPM1+MXjWLmTIGD0b0AP+NkkrhPrY?=
 =?us-ascii?Q?qyeX/yddBqWs+b+5VnnWIHh5HbZiXiGqNGGmhPxz1FrYNZOHauoXziOd61iA?=
 =?us-ascii?Q?vmyV2nz7OLiOBDuq0nJytNB2MrtSgQzxXKGdPefyvfBg52na66tkPtqF10dN?=
 =?us-ascii?Q?otjNV7CdfhKDcJEQifMBXTVduyIhXpur8v6bVaOrphukBM+MjPo6I2jSTFwj?=
 =?us-ascii?Q?ysd60TKpW9CFaZL1k5Lo7gNzkpc7PVmW31eYRa1TtLj5PbRsp+t7eu1n2VvG?=
 =?us-ascii?Q?sCRwTJ/tDZYFbyr5//oDqesb3BZdQ7K0yfr6MvvLzmfRGfu0+pYetjSbQWsl?=
 =?us-ascii?Q?CG8j8m9l8fQmtBX0bblBPsOkYC1Y8qx4FsTiGLbli2bId6I+xq4BArwRCZYX?=
 =?us-ascii?Q?WaK1I4dAHyCLYWyNhNUxb/aaWSSsS7lnlpdlFdqqiln7yqqgnN8eME68oF8D?=
 =?us-ascii?Q?N4VWTcjt5qNmcJQf7e+QSMv5E7Ug2c8a4J3n4tPP3aVPaL65iDkacSZ1nr4y?=
 =?us-ascii?Q?aSNeH89axEUaAU3ZpovLvtrj+BdpX05k+WomGIOKPrsv/b6He1HkHGk99bHY?=
 =?us-ascii?Q?1x5UpYJFQjsVF8BTkWo+meXtsa1H2YPu17QWlCTMibk9n5NJfFTZIznXBxxk?=
 =?us-ascii?Q?retGUHsxVN3mi2JqpHsGt1lZB0FVQP5DepyGMQ4dtVNRU5Dq+MO5Pm03nYKx?=
 =?us-ascii?Q?LdJkeAywFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: igWx5tlk6FK7CbaP66iqt2+syktbNNI+YEcEc/6tkGea7P7dP+Ac+pyw8rbjwqrQ73KFD1TT1Y8et2ULr0dbArBbLfFjyCM6H568+4w/0372Pb8KTE7Gq2GrklhKBRJ9fdweiuyBAV/NWf9gKvO976vhGWa5OxJMAPi22CvW1LnVAwT+a+T1Xg1pbz06yFt68gAJDhiKpzhv4VoYyrwx+Wa0l+a4ZohUv6vDU7WTxdVP4/KnBmAeAQwX+3GTeU0B3pQ0r380/MHdiHa6Kk79u1efdB6hRYyUnQ2ZKL+fFjglJHVYxppe65/Flr7BNCT3aY5wUU807jYgQHD+X3IsCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2795eb-c24f-4625-d82a-08de8bb56c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 04:00:45.7209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CklW4Il3tt4tIQ+pf77GqYNDp89eBEAHCSqvWkGUB3mgXbKvdPoUq3xFCKqZnKk2/wxjxT8d3e6Ia1gdt7HQZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8520
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xudong.hao@intel.com;
 helo=mgamail.intel.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Friday, March 27, 2026 10:52 AM
> To: qemu-devel@nongnu.org
> Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com;
> mst@redhat.com; jasowang@redhat.com; jgg@nvidia.com;
> nicolinc@nvidia.com; skolothumtho@nvidia.com;
> joao.m.martins@oracle.com; clement.mathieu--drif@bull.com; Tian, Kevin
> <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Hao, Xudong
> <xudong.hao@intel.com>; Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Subject: [PATCH 0/5] intel_iommu: Enable PRQ support for passthrough
> device
>=20
> Hi,
>=20
> When svm=3Don,pasid=3DN,x-flst=3Don is configured for virtual vtd, we ena=
ble
> guest's support for vSVM. In this case, the host VTD may generate
> recoverable first stage page fault event, QEMU read the event and inject =
it to
> guest.
>=20
> After guest handles the event, it sends a page group response, QEMU gets
> the response and pass it to host VTD.
>=20
> This series adds QEMU support for receiving such host events through the
> FAULTQ interface and propagating them to the guest, then catching guest's
> responses and propagating them to host.
>=20
> This patchset depends on pasid support:
> https://lore.kernel.org/qemu-devel/20260326091130.321483-1-
> zhenzhong.duan@intel.com/#t
>=20
> GIT branch:
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_prq
>=20
> Tests:
> Tested with DSA wq attached to an user APP which triggers IO page fault o=
n
> process page table durging DMA.
>=20
> Thanks
> Zhenzhong
>=20
>=20
> Zhenzhong Duan (5):
>   backends/iommufd: Introduce iommufd_backend_alloc_faultq
>   backends/iommufd: Extend iommufd_backend_alloc_hwpt() with fault_id
>   intel_iommu_accel: Add PRQ injection for passthrough device
>   intel_iommu_accel: Accept PRQ response for passthrough device
>   intel_iommu_accel: teardown FAULTQ resources in bottom half
>=20
>  hw/i386/intel_iommu_accel.h   |  16 +++
>  include/hw/i386/intel_iommu.h |   6 +
>  include/system/iommufd.h      |   7 +-
>  backends/iommufd.c            |  34 ++++-
>  hw/arm/smmuv3-accel.c         |   6 +-
>  hw/i386/intel_iommu.c         |   4 +
>  hw/i386/intel_iommu_accel.c   | 243
> +++++++++++++++++++++++++++++++++-
>  hw/vfio/iommufd.c             |   2 +-
>  backends/trace-events         |   3 +-
>  hw/i386/trace-events          |   2 +
>  10 files changed, 308 insertions(+), 15 deletions(-)
>=20
> --
> 2.47.3

Tested-by: Xudong Hao <xudong.hao@intel.com>

DSA PF assignment to VM with vIOMMU scalable mode, userspace test tool dsa_=
test passed in VM. https://github.com/intel/idxd-config

