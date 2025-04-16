Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37407C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 05:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4veK-0000se-2J; Wed, 16 Apr 2025 01:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4veF-0000sB-N4
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 01:49:24 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4veA-0008Qu-68
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 01:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744782559; x=1776318559;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TMqOxdOpSsMsUz5hMTkQuqsLG1T199Coe+Jh65UL8zg=;
 b=RDvcg1UBwRZc60VWq3+nDVIAlATVY56XvYTA6IDrCDWCGEVsDoINE6jX
 K7RXJqOkUW6a2q+623RyQ5/4Sp50qgLPI/L+bDr+6fcXUW5CmN5muQ9zI
 ZFh3fzY1UInNl0HX6bIZFkyZGwSZjMfzUtRsvaEirOTA0PvI9md9Miiyc
 t5DOCNK8UXci7hNZdCArrp0DbODf4U8rc32LAk/CSzxC5sj+g2S3d1i8t
 deoxIE18lTUA9atQNU2GUa+eVoUDn3+umKxK0/5Z4luf1ZvtV+9CexFg7
 4jvruybgRCFDf8n7waO1ukD7GOPhC4aCoLYXTkFdvTyC/nXZeLQoHSRFc Q==;
X-CSE-ConnectionGUID: 9wg4w7NRRk6bUWMMUbJbSA==
X-CSE-MsgGUID: AsrYanhESUuLOY586NrMvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63719201"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="63719201"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 22:49:15 -0700
X-CSE-ConnectionGUID: aT7xIaKMQzSvGw6kOqZQsQ==
X-CSE-MsgGUID: 7vwjToP0RiGDwFbUCX1koQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="167500569"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 22:49:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 22:49:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 22:49:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 22:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmAIiC6PvfzvT2uPrdxp+vnYPWKGVpXFrsMEsYdDdk3sKVMCD1+Mv+4ZNVbh8B+4Zr5i66gfFe0CivTWIbZdAh5yDLDCijl/R4IWR7GlE/f2Qtl6qRe8Kkk4GSEvpek3SYjWLmEjTMH3+SxeUaAjqPbl2IQ/wnNpRssp8yZiT+9rYMhtmq1sxokbckH2OYpx+4x5XXMGY19+carGqtrL7cmqZGygw16cUV6/letkIgj0vJYA4jbUP8uZxs9ZWUW355vai3OJ+DMLwL9kgWGhi5YrKruGciQcuQVnFJFLM1oHBbxH4nKIhYCs4WH8V/PrSDSqm1OI3BrdysM/8itazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyHymPfvXx118qUJEXi+LIFQMoNxETrQ7os7vwDmfyQ=;
 b=Y4bRbS77mUYlUtKESP0mRNKnzetkb2QE9aXWm0pFQYujEdlDDfkQFM+2cali9TZ3dD4uy9U5L+xLhzBGxhMvIARzsVQlNemcvFwTRd0RmNmNDPdXu60gBp7CYPjWPuYkdpeueZgqXg3Uf1C4HAfMf3s1S7IUORQQ5sOFK2tlwWJLcPUkuCFAnRDN+fMsKpjjji3ikXN91MViwxg4W9hB23KwuyzaLxb1g4u/NeHQY4O1F7J5PwDLHhdMBHNWxkpbCVsdEFVa0uSeC/paarP6M1cR+h1WQMSSdtNfLEdB5LV8fNH1lUUv2AlvXbypyUCeWplk1X8EOzINhT9+mDIoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7963.namprd11.prod.outlook.com (2603:10b6:510:246::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 05:49:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 05:49:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Topic: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Index: AQHbqstnyFbNUaToNUifB0k78FO5YLOeVAOAgASGe0CAApXsgIAAXhaA
Date: Wed, 16 Apr 2025 05:49:09 +0000
Message-ID: <SJ0PR11MB6744E4528936A632F83F3E7492BD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
 <08b72d7a-2202-48bc-8b1b-78c93b3e7cfd@redhat.com>
 <SJ0PR11MB67442F23FF7EB269ACFE26A192B32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <Z/7z2RZyqhy43S/O@Asurada-Nvidia>
In-Reply-To: <Z/7z2RZyqhy43S/O@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7963:EE_
x-ms-office365-filtering-correlation-id: 047075ae-cc57-42d7-568c-08dd7caa68bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HwutMO4OXl7LEfqqj3HnY99gZfCCegqZH7ypkCw4Oh3VNXDi5jq67ry2za?=
 =?iso-8859-1?Q?wKv1dv70ullHuGLlkI/Srzzi1FA1fRb/Tpl5l1Uq8EtHB0xVUuLxx0TmGJ?=
 =?iso-8859-1?Q?xssSTPG3rOIo8exxpNrgtzfC6AR7PGmCxsXftkRNFMnHxH8J0vVlEqBVdf?=
 =?iso-8859-1?Q?D0LLLUfyRNGMIsAf/nsekBcOiPX66Ip+7dezYLHTof5hjyktPUrkZ3bWii?=
 =?iso-8859-1?Q?c8Z5kMHDFNyyqLbwllTkMY4hfHE3gMg284cp3HNBKXSZ4OALtEhYwEk+43?=
 =?iso-8859-1?Q?k6kC0APpqx/xnDMVLKnI81Kk/Gya75I/1nEouyFAc/rBXDNWj64RxUpHgV?=
 =?iso-8859-1?Q?TrQt+TYfXoO5WQBTGgHxMDtiK0TJwF2kInsgq4hJon17dI79C0f0mCK6G0?=
 =?iso-8859-1?Q?vodpAhHJjyU1raGi2a8sWAbPFg8FktSyFINXOdm2XVHDzXCe8c6WP2NZCq?=
 =?iso-8859-1?Q?Wja4UExq3WVOhZbLebAlNJdxEtOrBg8i8ggSBrzPWZp7rFncXNveBI2jwQ?=
 =?iso-8859-1?Q?LwILzdXQ7wkOhorPnOQzymsLg4lgaeCqqbwo6Je00PvUWHlfqZWBy8cxtj?=
 =?iso-8859-1?Q?6Ho2eFGSl5x6AqXddbZdqCNRNNJjGkVPZlo/xAnluW99V2bNeu9EYuD9Y1?=
 =?iso-8859-1?Q?R31NlTnL5z/6gwQqB9cvZtFVC+gEsXtrK5MfdNT5Py8ukpx93F18cvUSNf?=
 =?iso-8859-1?Q?xuehBtgn3thcaGb6eoSVuIaXU8xPe2dreuaSJLf9/ABN43PqrbtmwvnD/K?=
 =?iso-8859-1?Q?9cRhPdBe6fXqKuAka2HpvjViOnQ9t9T76nNz+MOzDft7GNxsSyL4Unvpfy?=
 =?iso-8859-1?Q?30XFCM/mUmvW8m8yRNTHXT2BnG56scCCDYvUsoTUWdx0IakAeG5w8eRpBV?=
 =?iso-8859-1?Q?v9Jno55GiLVOlqzWqQ7AS7mv1pES8D0rRxc7WucUL/jVI/BXlk4D+DUibx?=
 =?iso-8859-1?Q?6FFejIraaMEfx3x1DGnN3+ArsXYZdIY1zIDBJl64SMIx7Hoc5pPdqWaK0b?=
 =?iso-8859-1?Q?KIYpPO7Bo5FjER9JPEO/5BfeXhvU6wvKAm/YQartgUfXzwkvBnAuo4vXXn?=
 =?iso-8859-1?Q?9q1T3oyQqq4ojbyGvwm6CQwbsCwPpHCIGMEGXlbRMcTWvKO6sPT6v9WBWU?=
 =?iso-8859-1?Q?JcW5F9XE5XoCu4U8xzGngTBFhHLACMt8Rwcew1q00Xrlrdknk6aNsOphFn?=
 =?iso-8859-1?Q?QY0aylreJigxRxBp9qpahWBEJHwY2jb6q1Z9R7OEeUQd6I0L592SSMDWcR?=
 =?iso-8859-1?Q?gpjv6i2lCf2VkOdC1IotrtsnD3i72wrpqMTbkOA8IfHbYVPn9+vUU05Mf6?=
 =?iso-8859-1?Q?i/l5iAErxBX91uztAAlKCuwYrC4e4byxDLcB5bX6JPTb1SjYxuYm4MEF4V?=
 =?iso-8859-1?Q?ZisLw+WOstFtBLVbvzSqdaIneYxi87u0ZKl9VnCBmdRT/EaKLJYL9n5cEg?=
 =?iso-8859-1?Q?1RRuUQ8XXClOR2oA+CqCS7jnvA7cQlex6QFoGVd8HBgKWZXd4W3bkafAwh?=
 =?iso-8859-1?Q?yVUdPqSGM/8W/RxsjehYUPXf6SuHPMKqyWDQL/VtcOfQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4laU+OWXglVDZ4b5c5FsZiWASHRGb/3+XVPr9lJLjs0zBGet2LqPlIxWmT?=
 =?iso-8859-1?Q?K29atLuTfIqX240eXBRhG+IeIPhb1WvAruEdAuPnwMpbRxXBLsslHaQwGp?=
 =?iso-8859-1?Q?nricOBOODKh18WWAZAUEXQlTLfQMzwUlcBLeh//vvCdWlb9Zdk3GZvkyFi?=
 =?iso-8859-1?Q?aKvr6Ab+IU2rHmYUGf3aZg7axZg4RdU10w/Sbsfl2SUhYDR5V/k0JkxHGK?=
 =?iso-8859-1?Q?GJSEFJitJHYhWnD40rUw6IGqfl1VFNx5rR8I/VIC4zGCvaAFvevsNmDyKt?=
 =?iso-8859-1?Q?MmO0HuVyHanMjgYbgoevx4Bzxi+cRSJ+yk0kdf14/pMYne9FQAEyDlEfA2?=
 =?iso-8859-1?Q?8sFcjOlDN0e9l0l5ZPYxxrxgbGVYjeWGJ1G1Tkcfhdv+NE05foFR6+texh?=
 =?iso-8859-1?Q?A/UA/FEUSxnepSc9LjCPUFJ6NtMWrY+5KgNKXh49XQ735Tc5RmuzKXp9Sa?=
 =?iso-8859-1?Q?aigCZrvssCK0LMWTFn/0ViM0/bNKYzhgQY2AmAZH8f+a/IixtqIFRp7YgY?=
 =?iso-8859-1?Q?SbI0fAbI/ABmB0kHoHG2/N4+OQn9o5b41XDrXA0RIQY2NLsekMPg+BIJgy?=
 =?iso-8859-1?Q?T0ipgpis2MYawmDICa2as+/xxX0kNiO8y4LzYCh0OwjrrVRI2+60B5eRia?=
 =?iso-8859-1?Q?JTsNUgvWOXUQ0RleoUiIWkKuRdSik+MRNpmi6mNxxZqGmzdE8vogLZaB55?=
 =?iso-8859-1?Q?bsqVmmfJKc1UP+CcjfZq5xyPXi1ynknYdmMTAtiLjPicVVKIxYsYD+MgB7?=
 =?iso-8859-1?Q?+8j1ZLw95C3fRkrvCguPwZ8d90P6EwkFeBZ/vx7z8OoCamX8G4oPcMI0ib?=
 =?iso-8859-1?Q?+juClTGNAYM7AlHONGd0veJl2r3VTI6px2RLwa4btAd8eYewfQFuZtbmMP?=
 =?iso-8859-1?Q?BvEjKxolo3pPSmCpgzJVYL3uJJtBG/Zqo0BIX5jKe9tYvO6G0rw/q8PipU?=
 =?iso-8859-1?Q?rr/cAMs8fVRp06fJLnm4nOLi/ScqL1kqZZkk15dD+MdkHi8ykfnQBH/qvB?=
 =?iso-8859-1?Q?CIADMFBR7N1EWhGyefMdsKGN8Cl1eYd612IYJKK/rh9DtkNUnGxsOSdF/b?=
 =?iso-8859-1?Q?ZAust37KR9DQvyg/s648amHRGBnughg4SJnwVhLof3WdxmV4wfFhrIXQki?=
 =?iso-8859-1?Q?SAepPR4mDK7UtM/U2dJW1V3+FY/l65R1SPi9jErkTk5lev+Kv+fwCww6RS?=
 =?iso-8859-1?Q?I3WypL+jrdnj+Jn2mhIsBA44DuE6xiPSuswgU+Z4ypXLMRDp/CW8P44VE9?=
 =?iso-8859-1?Q?EkFck+tMbKxHzZFEHVbPEaI15UpcAkCmeDia3VUFjufy8i/UZrMmlOPd54?=
 =?iso-8859-1?Q?yeiIboUs7uq1Ihjkf01qQimgqw/uxyfPSgJ8cVmNMMD6F3xqodhlXeo7r1?=
 =?iso-8859-1?Q?vgOCMlXIDiw0Z31bI1OFLcbUX41otSLet5dS+cIcd2T+hWycvE94M+ziYB?=
 =?iso-8859-1?Q?BvLyc7DLDMDlQdvmqU/OzKoaB1ALQsxxC0gfmhIX/IrPtTPytX/CR5xB3/?=
 =?iso-8859-1?Q?MJ/SS06buQibj1C7bKH0+vDgPr8M9018e3g480fVe/nLuAhT7XrfB41I+1?=
 =?iso-8859-1?Q?aDHLXi3Mj9yxCzFWsyWD11O9TeZnWeJAmzEQ45kPrBjAe/5Vgw/WTy3bQU?=
 =?iso-8859-1?Q?CGdXjulc2W0xqHkVtHWaDeIbOTN1wcelxG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047075ae-cc57-42d7-568c-08dd7caa68bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 05:49:09.9493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hti7gq/GaBBQMKoEFVmLjwOi5OYSBJpnNDzuNfxOPgbxFmqe86ZtjEG3btCkEByujLL8DhyunEKQZQX1E5Dzl3cWfu5nQhEAAOL7P6ChSoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7963
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
>VFIODevice.caps
>
>On Mon, Apr 14, 2025 at 09:30:41AM +0000, Duan, Zhenzhong wrote:
>> >-----Original Message-----
>> >From: C=E9dric Le Goater <clg@redhat.com>
>> >> @@ -77,6 +77,7 @@ typedef struct VFIODevice {
>> >>       bool dirty_tracking; /* Protected by BQL */
>> >>       bool iommu_dirty_tracking;
>> >>       HostIOMMUDevice *hiod;
>> >> +    HostIOMMUDeviceIOMMUFDCaps caps;
>> >
>> >IMO, these capabilities belong to HostIOMMUDevice and not VFIODevice.
>
>It's a bit complicated now, as a cap like PASID more belongs to
>the VFIO device than the IOMMU device, and should be read by
>the PCI VFIO code to set the PASID cap field. With this being
>said...

Yes, and ATS and PRQ capabilities.

>
>> This was trying to address suggestions in [1], caps is generated by IOMM=
UFD
>backend
>> and is only used by hiod_iommufd_get_cap(), hiod_legacy_vfio_get_cap() n=
ever
>> check it. By putting it in VFIODevice, I can save vendor caps in a union=
 and raw
>> data format, hiod_iommufd_get_cap() recognizes the raw data format and c=
an
>> check it for a cap support.
>
>It could still get hiod->caps?

No, in this series, I want to move hiod->caps to VFIODevice->caps,
only interface to get a cap is .get_cap() interface.

>
>I think the legacy pathway could have a NULL hiod or NULL caps,
>so both get_cap() functions could work.

If NULL hiod for legacy pathway, then vIOMMU could not call
hiod_legacy_vfio_get_cap() in any way for VFIO device with legacy backend.

> And I was expecting the
>vIOMMU could provide some callback for the core to use so it'll
>return a valid caps pointer.

Any reason for that?
iommufd_backend_get_device_info() need iommufd fd and devid which are
all provided by VFIO, why not let VFIO call it directly and let vIOMMU quer=
y
cap through .get_cap().

Thanks
Zhenzhong

