Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B702CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 06:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqQLg-0000ZK-8H; Mon, 25 Aug 2025 02:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uqQLc-0000Z5-NE
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 02:06:28 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uqQLZ-0001jT-GP
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 02:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756101985; x=1787637985;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Sc0hOLnumv1SEl4j1aDQ/HMLAEDvatbf7bOIE5emBXc=;
 b=IGFv+I/K5ulrUqOLxJWkjdWeKeO4AqcboZaHYG3EsV6M3JkvZBFnSCYJ
 15UprF4u75rnW7nUSKtnDwjheQuFQBu3eer0CXjPF2DHfFaw1+uHInwGs
 jtfNyO/99V6qh1hij/SHZbHMkVWGs+WVJRGOdJNOy96Pdao2yumJyTTpV
 wBaGS4vOdRTUbXibILXjPfyXBoeCoK22KiVIoQaTPLw4Hz2jNkftsbTz6
 3K9lFz9EwIexzt52QtdVIUVt9F5NlDjJ43ec8tcEar/UJhBs2jEdcfpa7
 3BLsZyBlFHeq3Ss65NSjgPsDevK1atJYzN2Z6DUrFrKSDlQmR9xAv2ccq Q==;
X-CSE-ConnectionGUID: K6bcEo2UQ/usSFSSa26zww==
X-CSE-MsgGUID: iujw8ZMTSKqKe5CNRZ64Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="75901777"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="75901777"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2025 23:06:23 -0700
X-CSE-ConnectionGUID: qm+D2BEMQIq/LS0eM3TF0w==
X-CSE-MsgGUID: bV61omeKRme+VmGNJC5IFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="192869446"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2025 23:06:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 23:06:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 24 Aug 2025 23:06:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 23:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFjn2xX0bJ6t7452XYsRMd4O4AxS1n6TtIVNF2wzGu6j6EM/cqF19FJnLaZJnRuVdm57w1A6Nja4ubHdUCi1nWjWrcivSfHk4jGjpwYZ4YD5WGFb1cBWNL8ZUoaxNS15jpW/rS177Mo/TnMAgrKrwCU19YbshDoCMgsse3tlLQFiSi209dMMt+HK75r9Vptp3TYwhTVtmbOk0wY/SywPL3AXJWGz0yqdmD5q9e0NBDsz8zPfcp9m/3Gnbg86nwf+i6HiPBC/hKecMBZNNBiSO0swLUuc6iFvygq8yC4FOVtFsqkSOxqSh6f9YTUvkVgupFUACTtAUnhNKkWOY95ybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4Z/GnuzDjxNFB2QA+ayLS8zymJUuQYNv/IHBaK7t/k=;
 b=Rl3YJTJlx85wS04ZYHOnP1sTnTiBw2kk4l73uhhzApiVN4iaPf8p+I4patTnI+rjI/5swDfxEjBKvChk+hk0Z2dlCsS9BFW1iX3g8kLOj3Sqxumq5hnuXecoKMYXXmjXitno9gdZ4Ti0xSWdYt0haQFsH55RdFW7CqHdQZw2FjV1nWBy+fM4GO+uop0gcF2dR1Te2C5mh9Ya9G1T7+gbWvUOB1wwKkz5N7UR/MWfuPpbldJFuSmeohx//ygOjVxfQXS9iRxzCb5SlP5lN1Wb9oNVD5jIx4403CG/jL1kjVt8yh0cQiPVh4aPjBY0foALudyQGufV37EYyl1tmhTVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB7390.namprd11.prod.outlook.com (2603:10b6:610:14e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 06:06:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 06:06:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 04/21] vfio: Introduce helper
 vfio_pci_from_vfio_device()
Thread-Topic: [PATCH v5 04/21] vfio: Introduce helper
 vfio_pci_from_vfio_device()
Thread-Index: AQHcEy/YB7cQcg3gL0aN3yJDmSz5FLRvRSIAgAOgXZA=
Date: Mon, 25 Aug 2025 06:06:18 +0000
Message-ID: <IA3PR11MB91365001B893E3883B3369E9923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-5-zhenzhong.duan@intel.com>
 <aKjx2mckGYSD6bK0@Asurada-Nvidia>
In-Reply-To: <aKjx2mckGYSD6bK0@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB7390:EE_
x-ms-office365-filtering-correlation-id: fbc37f60-16dc-4c16-e223-08dde39d81c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9W5AIjHyq0Zm//FqW5kEGHtTzO2616IunDH7alLFdkNVbQ/IEJAmZj9wGD?=
 =?iso-8859-1?Q?lc9JK/+NtRgOfXQrtoaO/c7oMmDfuxB/8aUuKPap/ReDwM/ZtbMvEPn1D2?=
 =?iso-8859-1?Q?zfi0Mih2FfL/MUFvmiqbUycQmSv0dLqAWE1YbHd+1bHDcrDkXpmuU8Ddgl?=
 =?iso-8859-1?Q?D0lSXHtaSGUyAwX5JxXNLqL5Rx240b4fhniCQh5AunO1qhKeY9ss+c7aCy?=
 =?iso-8859-1?Q?I/DQDUegRvPWauX+fQq1HasOjMPVIFaBXbcOZeY0sDZLKNe1cYPfJs/WK1?=
 =?iso-8859-1?Q?nqVMIx7bVlHDDo/4+IOrovqFi+AzpwEJJZ1haG+Bef9jBaFi1QOhPd+WRZ?=
 =?iso-8859-1?Q?tf2zz5DjCYSWQ3Bh7R5HRCQFtjwFfZ/Q21ZqqfbXEXee9bxvV2i3v6HX3W?=
 =?iso-8859-1?Q?Bor7kNF2DN/bO7ob11DV3Lw4EXVKoOfoUT0YPpGLiGIf6I1DH9wjktJUvX?=
 =?iso-8859-1?Q?4cnhjiQx5GCozBgx8yJ4oIV1NdTYh7rto6ckv1QBfZHG6y+P/0OtMni9Wo?=
 =?iso-8859-1?Q?tm6bN42YIQjFzTj3Pzzu9rrWLMt1ozlXgM9qrgmZXHX9AzGFMJ0qvHfVJ0?=
 =?iso-8859-1?Q?iEp9bdd6xEiyF7ZIHTYrxAaLsxNuSiKbvxRCGSlAJ6HoLC8jj5LnYykdkP?=
 =?iso-8859-1?Q?W8iI9HtnlCVdkhkPih/S1sCUQYifyZg0Z0gqMrGxTmIgDsoO//Q3VfmIrk?=
 =?iso-8859-1?Q?cShCfd9kvy6+gXTLG4hcsUZlXM6XIiuHZhc6PQ9zxzt67eZD+h2CtMY0I6?=
 =?iso-8859-1?Q?f0jWH7vrbRaupbNK/PZmGGhZiJdcHXU3B0UYpsIunxEc/ulH9JXFl9o3YD?=
 =?iso-8859-1?Q?ADhXV3zn6h4PPYR8A3vc9IqQuYWElGYbDOpSsiWSy5oSIK4VHm6EzpIByV?=
 =?iso-8859-1?Q?YHPQc7EAuOwBR0f9oRFMeN7DR1VPlWw890NodGq7SbLAH8l/l8xMMB2WmV?=
 =?iso-8859-1?Q?t8hMJR8+uW98wUW9r6HSaYCzTTG57hyud1jg3qcmTzTHFUbiWDm6fevt80?=
 =?iso-8859-1?Q?Ae+20LpykTUOk0UQiffXGCSUFkk/P5Y7tVUdZenyzDm0+p54cG3/2nGoDA?=
 =?iso-8859-1?Q?U20TC41RI0m9OmLiIvae/SRr0BqZPZ2CbwJPglP8hVbIV57ShPBo2K49mq?=
 =?iso-8859-1?Q?yvW5+INNmwkCy1B3DFxijbamW0m7jiB9LXcmQXZz39H8kpBTSUGCJcMqDJ?=
 =?iso-8859-1?Q?I0mTup/E+VYnCPmhGMCKfPF6WO3Ji3tCnu4BjHJ4GdYYXUrW8VfAsQOSS/?=
 =?iso-8859-1?Q?wv1uuws+2a3Fy8zPuaTABUXLtnkCApzJr+vZaZYDYSwUubbh04KR047RGg?=
 =?iso-8859-1?Q?oytrbxIXNo9JcqF5ypS5aj+BL3z22PWu8Vq0loWzdt/tt42yuxktyM9qlW?=
 =?iso-8859-1?Q?4yIbz0cyY2AkxOj9UspvAabwIQsT4LgmF7E7L9ttT/f3Nz91b28Zp8KryY?=
 =?iso-8859-1?Q?Pz/8WUT7ELNMvKALII67VHuANXa7Ov7P6/+61QuuEGSYXyD0rtFGZEkWK9?=
 =?iso-8859-1?Q?OScjSTPhVdqzmKae7/dj9e4OPNCaV5OFBupPgEdO32LVgCTTLk2I6Ua47D?=
 =?iso-8859-1?Q?GWgDa4Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QWsXG/pNWsdARnLDeiIKqFdIOoKc1ucLFLgLEu5RB2IyL+T7EoqUhiPfJz?=
 =?iso-8859-1?Q?4E9rn2tMp1s+QNsCFEu1UkOfxN8VwIfNv4XnI6LuXc/7/QmVeRBkuSCUpF?=
 =?iso-8859-1?Q?KsYog1HD+epznFdjrzkz2WzBiqqyqXyb64bSovYnOzfx8scM1uD1j2eQkR?=
 =?iso-8859-1?Q?ruGJxgo1yUQ9tO5gySOAGZWAFfCV8A1WikFlEUrX8EKMVBjqL7Qz6BQONp?=
 =?iso-8859-1?Q?nbuGR0n1aa+gndtwx3SF4m1IJjS52ozDlye8CuNxSR1UVv4qhabEC3jXUX?=
 =?iso-8859-1?Q?szYap2RsLQkEGyDkXEpfWker2IPOUtqHEET+hJrJhhGkXZCgxR91MidxM4?=
 =?iso-8859-1?Q?fincQP6OriYSp0v9yc6hoEa2UAv/XVH0R22c4DGEURAS+zgdAdGmQNxWCg?=
 =?iso-8859-1?Q?RURwMCj8TmJTGUBRLSG9aMJF/e5YC/+yhzyX1NDQ5WT7qvnCmTYO2cvrOd?=
 =?iso-8859-1?Q?0eB9OR0TSEjQeUv/LXPi3549OhTkWgqFQPag1zCQYPA9OhAOr2vcE2oh/i?=
 =?iso-8859-1?Q?rSf0JbNmAGMipBrYCrnkSE7zAJLark/I/Hn3g24jFhJeWuij6QiHjUXr0q?=
 =?iso-8859-1?Q?RbzbWsAyWT7M7ZPFI86wc+ekg12R9wfCPOTZGRZD1f2CPFTFRqeDgu6as6?=
 =?iso-8859-1?Q?fI6xVP6PG91Mnqt7O24Z64EIbB9v04xBiLW0ZYHo810yIbhzw8PmUrlJ8d?=
 =?iso-8859-1?Q?csb5xCkA8J7mIJvIxlf/jeZXZyW/yHoXTkeMQSVma2cRXxu61ff5FNMEEF?=
 =?iso-8859-1?Q?8HLFSQ+Jb7svysXvVtcuyCrpV91RxnQH1OKk0TXof7qc5hgZgWhJX0zDX5?=
 =?iso-8859-1?Q?9B926+SbTQX+PTrWjWxUyYLA4Zf9hi1V3jxsWhvV1oTqWCZzQAU+l/MSzp?=
 =?iso-8859-1?Q?hIA9E7BI/p0HqLv8Qcc+Ast5VLDU2O3A1SBMSuF3LIhEfgUv+ajzm6/bRT?=
 =?iso-8859-1?Q?IJmxMfBxMlRWWJ4/N7Hcaue0apGDfmEsr+NtxkltMUxN736TpAvuhWkOLI?=
 =?iso-8859-1?Q?XqeGw+yRY2Zwz4XIiNZJRIIa5MxRr/jZOSH9FseHj3UonWhGDjfOm09cin?=
 =?iso-8859-1?Q?cbC5eJ9yEp07nuk/h3ToyPD0fiE3GpehgPq4qsjQdIAdinFNf2z0R9JB1l?=
 =?iso-8859-1?Q?IqmlVD+iTKqPysh9avRBqggykWjUPfwWJX1d/7ayzozO6wusLho7BNsZPE?=
 =?iso-8859-1?Q?TKvWCJIyl41zMMIOxS4UFrxr1JxWgHqki2kcd+eazmu4rT4AmwW3w3gC95?=
 =?iso-8859-1?Q?oGXfhsTOM9RFmYeON+wvw3a4tjFGoOdWvu/l/5OEgr1qNfeDSYsjmETyFq?=
 =?iso-8859-1?Q?QOnGHHkMK+Xr3tm8yEjdIKrUca7wBXXWx6eMUZ6jSDD3CpxkuKgKCi8SqH?=
 =?iso-8859-1?Q?ceAt933mqlP6+AZR2bAHgVbDCI/GjBZj4UVdOFtYMt5qaZL5VigA6sLDvh?=
 =?iso-8859-1?Q?voc/5cbV0bfbI4B+1jAZcaqSkhBpe/5FK4vShDJb53JWNdb7OOCE+GHGzv?=
 =?iso-8859-1?Q?yJKrBHPemNuCRnCIZr4Hxrkb4Lra8392W4d/r2mVTilwPwGrPhLN81ew4o?=
 =?iso-8859-1?Q?v4AFRtTowf4CtAmKRAplFDzRJNFsG0ZsDciQx5V/RROK8I33FhDIVhrxdo?=
 =?iso-8859-1?Q?cJiA9TyJ4tIUZ+Fc0ldNJYE+SZd2Fb/gSw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc37f60-16dc-4c16-e223-08dde39d81c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 06:06:18.2343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yb6EgCN65ZfCg31wu5gpsgn0PONzn/VYecFKyGGSw3a89hPzzoJpKfCs+OCm5WgE4g4Mq5lpGufNUQv2jU6bLDtgmTgUSkUl1Lx1B0liCrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7390
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v5 04/21] vfio: Introduce helper
>vfio_pci_from_vfio_device()
>
>On Fri, Aug 22, 2025 at 02:40:42AM -0400, Zhenzhong Duan wrote:
>> Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevic=
e
>> to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type
>check.
>>
>> Suggested-by: C=E9dric Le Goater <clg@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: C=E9dric Le Goater <clg@redhat.com>
>> Link:
>https://lore.kernel.org/qemu-devel/20250801023533.1458644-1-zhenzhong.
>duan@intel.com
>> [ clg: Added documentation ]
>> Signed-off-by: C=E9dric Le Goater <clg@redhat.com>
>
>I think we should drop the link? The link points to the v3 that
>is not the officially accepted one now, as this PATCH-04 would
>be? IOW, the commit should probably have a link to this patch
>instead.

OK, will remove them.

>
>Also, in general, your "Signed-off-by" should be the last line,
>when you submit a patch.

Will do.

>
>With that,
>
>Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 810a842f4a..beb8fb9ee7 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -221,6 +221,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
>>  uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
>>  void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned
>size);
>>
>> +/**
>> + * vfio_pci_from_vfio_device: Transform from VFIODevice to
>> + * VFIOPCIDevice
>
>Nit: this could fit into one line.

Sure, will do.

Thanks
Zhenzhong

