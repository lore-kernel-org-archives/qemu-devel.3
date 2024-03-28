Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1D7CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 07:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpk6Z-0007zQ-Ve; Thu, 28 Mar 2024 03:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rpk6W-0007z0-ET
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:23:16 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rpk6S-0007TJ-EP
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711610592; x=1743146592;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3iTtiPgu/44t42WUYSLEtbBPqSd/UduHt6Svw3Tryik=;
 b=j9bapIYIpUGiQThiPsytHXgq7sdDpoYWEoAtqkfgxepbfcZYyAc0LHIp
 tuC4h1XC3g6bCU7jotOhci7knyLRWx1Ac357JupIcHdAYDiisdsfYOgpN
 D3D7/6KeNqnZ09/KuLxWejTZw+qyGHhymcpClIXcRAZIyQb1WIDWgRrFg
 QKTSe8r1Rayf6I/zjfy7TZ9nuUSczHJ07sToRbcK4B5ch+0wcNv0yM/mE
 qyrh+49UZHH9Qi6NgH0EIhoEt+NtmD7eDLl/8ZQg/6gt3HCM1fMMbZiw/
 UzTUdFSnmEojpfGqEAi0ig27sbW96jKt739x+Ii5gcs7x6Vs5egJJGvbi g==;
X-CSE-ConnectionGUID: XS2uD0erT4+jpCd3Xv2l9w==
X-CSE-MsgGUID: 2RHssYDmS2yG0fMablIt4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17475935"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="17475935"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 00:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="47758030"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2024 00:23:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:23:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:23:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtLZ+JHdxBJPQ/e9OkII2o/V6P8Kape5FirQFFb6m4JpY87o50VV2ZFSnaOKJojsVegOGYgVWBhYZUVmaTvcDi6mqVraIjrbcutS5T4zKgG3ZqsJwQarildR278yA4y6NJFJhQEdYb+DkvReosEJ5X8Xez5DtWZVWmhHSb34VQ48NvdqfuAfHovSE/k6sA98mXvGxvSrVwaDC29dGOeFBe6ETIEjGmFijett9vvV6y5qoFmxaV/yxBsioBvOyHcPl9PGoXz7FlWl139spgBWadNGHTMr36tiCH2oVNMXIfLO0Ie8rt/gZqdyY56AiIbITe1YXO/HW6KfF4ufyLVF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ1OV5danCv5aYW4ZM2pMPTU5Iqm6rNVtK5vGXY3rnA=;
 b=SsfQMVaUjcIMz3tRtRkXg5neIzYpKxIMj/Bz4oD+Kiut4j4yl30l0xDr3weDNKef7vr6xc5ZLerKeKubgI4gmsGI1CBE3v2/AfaGKfoBdpRg5K7xs9r9PuemLvw+/+cxxAQqj8xCnSLU30G1AtadCsfG1wPriuvPrZw6ATVA9brjmrtzqS/eyd57/7ZqmD4vUJiuG2aPm4w6kGvqgMBQrUvR/AqBwGVFsr5CM48UjHWh/h3/rtT9VTyAI/dMADmFLT9VCgmcM54SvDULjo534AfBliQkQQU1+pHy/QIVLy8gO1nDEJD740b+uHMZpIx2+n5AA6Uc1WIiBXI8FEPqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 07:23:04 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Thu, 28 Mar 2024
 07:23:04 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Bryan Zhang <bryan.zhang@bytedance.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "berrange@redhat.com" <berrange@redhat.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>, "hao.xiang@linux.dev" <hao.xiang@linux.dev>
Subject: RE: [PATCH v2 2/5] migration: Add migration parameters for QATzip
Thread-Topic: [PATCH v2 2/5] migration: Add migration parameters for QATzip
Thread-Index: AQHaf88Ww2Nz2JXRGU6IsqqTJks8PbFMvSXw
Date: Thu, 28 Mar 2024 07:23:04 +0000
Message-ID: <PH7PR11MB5941DB7AE63F9114667CFEE1A33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
 <20240326224221.3623014-3-bryan.zhang@bytedance.com>
In-Reply-To: <20240326224221.3623014-3-bryan.zhang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|MW4PR11MB7128:EE_
x-ms-office365-filtering-correlation-id: 2479859b-af04-48e3-0f0e-08dc4ef7e8a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIFWeOc1bSWz8FoLlUQLHaJa0ZIpLZI3fsz1EfcdKqol0lxhQaEoZFKHl+9pUyPxJx2GLc8jQlauvl2orRSkZ+2UqMyMS0QH0IXlZmBxt/f+21+pnVEOY2qRRSxynK0ZkiKfOMohBntADVn8WNiwuwr5llZo2d8g6gFaJHjCfc3VzycPE5VFWTB84quf2bb6heT1WoKBNJT5uXHsTje15cz7Lb4bCSDh5Q6wxO7vmf7uRAfLVotbxxgZRtEym1pEsMoX6N1TRLOAMgNl2eW/g1m5ARiCo73wLoFB2zFTbh2BoG+N9BFZEPcz2kkoijkRhYZeg+XdqrysDAO2qKUiY+TxdLAzhvscxz4HqsPAjEFRP54+QGoqGiupEQoMBWm/ZovtzdMAJjcNY3ubZg5Bw/Gl4sEQxOIN8yblX4/nKL80uOAc/dde2hlNBtwSKs/S4V9x7rjch8rqY2VSUeQgQpokF5ZscoNmScPTHEmb60fBIrNKuSc9QHiNI0Me+0X0/QNZG3TRP3/IPCpl0HNw3LZ8iC0HnwhAxZBfFY1Dfg6xMWoXy31J5tHMOgUtV76fG2d1PPpfPLXLotYD4p0mtrXc5rUF2MIC60ewGbQud1ZQwE2VlKAQwCkoXT9UmY/G2BPnqsxIGPeaTIkUIa/pHsYfaS6oxf4Pnsq3fHmS7wotjCMjM32/CioewR7zie6kNtudZzcw5cyRIhRQsla8+9rVoYT7sjW1f8M69zj/d3s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YyVuTmKDkKNOD76owJTOEgjj9qY0YoUW2GVGM6s1xVJ06ZOo7ejJRxdPi/vn?=
 =?us-ascii?Q?/mMYyxIQY5curIMq+yOzNEsPPG5PAOXbRw/AXoWCAmMA91KBQ9T61x6xBNYI?=
 =?us-ascii?Q?Nos41IfZJNA7iMcMu3N8UBFLEHUmZN40tFS15KZ8so9+kOwLmmWnpppMDskl?=
 =?us-ascii?Q?jxznhY3RRcj3Bap7kkvoPB4MZrVXhqkcpJjzEZpxgNkAalZ5Cc/5j45fCp0J?=
 =?us-ascii?Q?fVo7cBcRVDYlW3fjuZBdRH+DDB2IdhJ5aci0pEWrZLlfOaICKMoXX3Ax9vDb?=
 =?us-ascii?Q?cLbq34j6VhztSGW8u76Eli6qbwfXvSeAR1DNz8y5fwD7i2t1okhutlO4/Sv9?=
 =?us-ascii?Q?ukPiNUNlxwwqWWx3r2QrrdmJWcQ+90kw6hWQyEFsotC5OfGZjlj8EHkVAZSM?=
 =?us-ascii?Q?sUK5w3OjX9+rTSM2jEkQXccCmainzO25uzLGLTQ6pHPsmb/aCPx9Fj+LEgWI?=
 =?us-ascii?Q?obYy/gOyNy1rsToeeBM+cSQFVDg0YFTb6bcgpCo3p95ez4k8ZKDFc8ekxdRO?=
 =?us-ascii?Q?Of1ic5QBoJPjR3lftkT8Gy81m9iklpAEIbrtS/XS5VtIgZPNXsRYXDmwIZs4?=
 =?us-ascii?Q?PddfGyZ89WtibEVIMgGCEg+lhwihUnCp2v3mnQ87m2sIoqdnrlqRtBnPqnsJ?=
 =?us-ascii?Q?YSUG8XRoUoWsxwWsfZLaQtwW8/yYFotH7RtOUBYcVXAHfPSDRlni1t1Ru7Up?=
 =?us-ascii?Q?QPm77MnaAPQjSZjVkFTKR9ALPF3gmuoFY8ZMfF4A0vhQ5Zp9grLLdNZLhrWo?=
 =?us-ascii?Q?zPAq31OtE0XquH/gbPLvd0YrdF/A3kupXFMNcqG16c0GZeV7D5Gt4Q+a/4gO?=
 =?us-ascii?Q?T7kckC7fpM0X1PQQLZCFmZJDTolGu76GoTsF6bHU0NaZ2RETe/2g7j8EOHbW?=
 =?us-ascii?Q?1vGfqLpJvV/+UOYRp1cG0yzZIiYlDe0ggNZqyT6d/aw4LRL8c2p69jcAJpXQ?=
 =?us-ascii?Q?p1AUgPBDOgyutFtbQAocjD7o2I4bA6xh5Cx6MFpxbnxbg20vb0Ylgk2bR70p?=
 =?us-ascii?Q?+P4s7X+mkUKwUQB71ZbWLWq01g5NP14ml+Z8t7zO9pfesmaJI+xlxZI8RC+8?=
 =?us-ascii?Q?IOwCKetfCBTWrjgd+xRPBoAHA6HEucUTbaVMB1SppxW2WXMoUHulv+ZL0my+?=
 =?us-ascii?Q?QBH2wd5gwQri/S47jh+EzbGFQqhOCCKtELyYXg8l+kNZDfKXdvuzZsKx/G0Z?=
 =?us-ascii?Q?Vj5Niz4Xw0JBHjADzB0ZXilegPwTF8aFBmemQ0DjlOANCNs3H5shouQn57ga?=
 =?us-ascii?Q?5YXKG7VD8yOc12aWlSZWOCwCwe+TqA6Z/KwuWtW5B34EK3jE/yQik2EqqpKC?=
 =?us-ascii?Q?OqzGJqpYT2wMDuiV00SyYB5C0c5gc9can+NZ89d4hEixpYuw/YqtDNChjrfo?=
 =?us-ascii?Q?fxUN3Z96UQhdJPS+lBrbQeWH+LMT+jmPJOeoA0iiAhuphfzDb6Ma4tzez2F4?=
 =?us-ascii?Q?b28ubX7bChl3FyjUqIFjbqPXULcxaCOX6je7KoOBLrVJkQ9V+/jR0eQIjFo0?=
 =?us-ascii?Q?a3cxBsMODEnEeguw4LiZ3if98ScYQ/obcaRzKCkw4wJHzn6espDrS+19C+Z9?=
 =?us-ascii?Q?8HJjNxHHZtbkxPV+LU5lCdrNLJuC5+e/bgYh9XQY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2479859b-af04-48e3-0f0e-08dc4ef7e8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:23:04.6265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ot4G/2NDrJP2IV9/LvZSBVFQ3qEEvuQtW1oeji1QqWx0MUrnIyjZuHSaP0qEgMyHBhNArZVMWcZNv/E3Oo0N/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> -----Original Message-----
> From: Bryan Zhang <bryan.zhang@bytedance.com>
> Sent: Wednesday, March 27, 2024 6:42 AM
> To: qemu-devel@nongnu.org
> Cc: peterx@redhat.com; farosas@suse.de; Liu, Yuan1 <yuan1.liu@intel.com>;
> berrange@redhat.com; Zou, Nanhai <nanhai.zou@intel.com>;
> hao.xiang@linux.dev; Bryan Zhang <bryan.zhang@bytedance.com>
> Subject: [PATCH v2 2/5] migration: Add migration parameters for QATzip
>=20
> Adds support for migration parameters to control QATzip compression
> level and to enable/disable software fallback when QAT hardware is
> unavailable. This is a preparatory commit for a subsequent commit that
> will actually use QATzip compression.
>=20
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
> Revision: This commit now includes a parameter for controlling software
> fallback. Fallback is generally intended to be disabled, but having this
> option available enables using software fallback for testing.
>=20
> This commit also now has some glue code to properly set parameters.
>=20
>  migration/migration-hmp-cmds.c |  8 +++++
>  migration/options.c            | 57 ++++++++++++++++++++++++++++++++++
>  migration/options.h            |  2 ++
>  qapi/migration.json            | 35 +++++++++++++++++++++
>  4 files changed, 102 insertions(+)
>=20
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-
> cmds.c
> index 99b49df5dd..4bd23ba14d 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -630,6 +630,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const
> QDict *qdict)
>          p->has_multifd_zlib_level =3D true;
>          visit_type_uint8(v, param, &p->multifd_zlib_level, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_QATZIP_LEVEL:
> +        p->has_multifd_qatzip_level =3D true;
> +        visit_type_uint8(v, param, &p->multifd_qatzip_level, &err);
> +        break;
> +    case MIGRATION_PARAMETER_MULTIFD_QATZIP_SW_FALLBACK:
> +        p->has_multifd_qatzip_sw_fallback =3D true;
> +        visit_type_bool(v, param, &p->multifd_qatzip_sw_fallback, &err);
> +        break;
>      case MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL:
>          p->has_multifd_zstd_level =3D true;
>          visit_type_uint8(v, param, &p->multifd_zstd_level, &err);
> diff --git a/migration/options.c b/migration/options.c
> index 3e3e0b93b4..1316ea605a 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -62,6 +62,15 @@
>  #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
>  /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
>  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
> +/*
> + * 1: best speed, ... 9: best compress ratio
> + * There is some nuance here. Refer to QATzip documentation to understan=
d
> + * the mapping of QATzip levels to standard deflate levels.
> + */
> +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
> +/* QATzip's SW fallback implementation is extremely slow, so avoid
> fallback */
> +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_SW_FALLBACK false
> +
>  /* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
>  #define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1

Hi Bryan

The default compression level may be set higher, such as 6. I checked QAT t=
hroughput
If the data size is less than or equal to 64K, level 1 has much better thro=
ughput=20
performance than level 6 and level 9. But if the data size is greater than =
128K, little=20
change in throughput, and the default MULTIFD_PACKET_SIZE is 512K, you can =
have a try=20
to use a high compression level, to get better compression performance with=
out affecting=20
throughput.

In addition, if you change MULTIFD_PACKET_SIZE to 64K, you may have better =
throughput=20
with more multifd threads

> @@ -143,6 +152,12 @@ Property migration_properties[] =3D {
>      DEFINE_PROP_UINT8("multifd-zlib-level", MigrationState,
>                        parameters.multifd_zlib_level,
>                        DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL),
> +    DEFINE_PROP_UINT8("multifd-qatzip-level", MigrationState,
> +                      parameters.multifd_qatzip_level,
> +                      DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL),
> +    DEFINE_PROP_BOOL("multifd-qatzip-sw-fallback", MigrationState,
> +                      parameters.multifd_qatzip_sw_fallback,
> +                      DEFAULT_MIGRATE_MULTIFD_QATZIP_SW_FALLBACK),
>      DEFINE_PROP_UINT8("multifd-zstd-level", MigrationState,
>                        parameters.multifd_zstd_level,
>                        DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL),
> @@ -861,6 +876,20 @@ int migrate_multifd_zlib_level(void)
>      return s->parameters.multifd_zlib_level;
>  }
>=20
> +int migrate_multifd_qatzip_level(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->parameters.multifd_qatzip_level;
> +}
> +
> +bool migrate_multifd_qatzip_sw_fallback(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->parameters.multifd_qatzip_sw_fallback;
> +}
> +
>  int migrate_multifd_zstd_level(void)
>  {
>      MigrationState *s =3D migrate_get_current();
> @@ -983,6 +1012,11 @@ MigrationParameters
> *qmp_query_migrate_parameters(Error **errp)
>      params->multifd_compression =3D s->parameters.multifd_compression;
>      params->has_multifd_zlib_level =3D true;
>      params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
> +    params->has_multifd_qatzip_level =3D true;
> +    params->multifd_qatzip_level =3D s->parameters.multifd_qatzip_level;
> +    params->has_multifd_qatzip_sw_fallback =3D true;
> +    params->multifd_qatzip_sw_fallback =3D
> +        s->parameters.multifd_qatzip_sw_fallback;
>      params->has_multifd_zstd_level =3D true;
>      params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;
>      params->has_xbzrle_cache_size =3D true;
> @@ -1038,6 +1072,8 @@ void migrate_params_init(MigrationParameters
> *params)
>      params->has_multifd_channels =3D true;
>      params->has_multifd_compression =3D true;
>      params->has_multifd_zlib_level =3D true;
> +    params->has_multifd_qatzip_level =3D true;
> +    params->has_multifd_qatzip_sw_fallback =3D true;
>      params->has_multifd_zstd_level =3D true;
>      params->has_xbzrle_cache_size =3D true;
>      params->has_max_postcopy_bandwidth =3D true;
> @@ -1147,6 +1183,14 @@ bool migrate_params_check(MigrationParameters
> *params, Error **errp)
>          return false;
>      }
>=20
> +    if (params->has_multifd_qatzip_level &&
> +        ((params->multifd_qatzip_level > 9) ||
> +        (params->multifd_qatzip_level < 1))) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> "multifd_qatzip_level",
> +                   "a value between 1 and 9");
> +        return false;
> +    }
> +
>      if (params->has_multifd_zstd_level &&
>          (params->multifd_zstd_level > 20)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> "multifd_zstd_level",
> @@ -1312,6 +1356,12 @@ static void
> migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_multifd_compression) {
>          dest->multifd_compression =3D params->multifd_compression;
>      }
> +    if (params->has_multifd_qatzip_level) {
> +        dest->multifd_qatzip_level =3D params->multifd_qatzip_level;
> +    }
> +    if (params->has_multifd_qatzip_sw_fallback) {
> +        dest->multifd_qatzip_sw_fallback =3D params-
> >multifd_qatzip_sw_fallback;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
>      }
> @@ -1447,6 +1497,13 @@ static void
> migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_multifd_compression) {
>          s->parameters.multifd_compression =3D params->multifd_compressio=
n;
>      }
> +    if (params->has_multifd_qatzip_level) {
> +        s->parameters.multifd_qatzip_level =3D params-
> >multifd_qatzip_level;
> +    }
> +    if (params->has_multifd_qatzip_sw_fallback) {
> +        s->parameters.multifd_qatzip_sw_fallback =3D
> +            params->multifd_qatzip_sw_fallback;
> +    }
>      if (params->has_xbzrle_cache_size) {
>          s->parameters.xbzrle_cache_size =3D params->xbzrle_cache_size;
>          xbzrle_cache_resize(params->xbzrle_cache_size, errp);
> diff --git a/migration/options.h b/migration/options.h
> index 246c160aee..94aee24d97 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -87,6 +87,8 @@ MigMode migrate_mode(void);
>  int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);
>  int migrate_multifd_zlib_level(void);
> +int migrate_multifd_qatzip_level(void);
> +bool migrate_multifd_qatzip_sw_fallback(void);
>  int migrate_multifd_zstd_level(void);
>  uint8_t migrate_throttle_trigger_threshold(void);
>  const char *migrate_tls_authz(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 0b33a71ab4..66ea6d32fc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -853,6 +853,16 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU. Defaults to 1. (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1.
> +#
> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
> +#     is unavailable. Defaults to false. Software fallback performance
> +#     is very poor compared to regular zlib, so be cautious about
> +#     enabling this option.
> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -915,6 +925,7 @@
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-compression',
>             'multifd-zlib-level', 'multifd-zstd-level',
> +           'multifd-qatzip-level', 'multifd-qatzip-sw-fallback',
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features':
> ['unstable'] },
>             'vcpu-dirty-limit',
> @@ -1045,6 +1056,16 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU. Defaults to 1. (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1.
> +#
> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
> +#     is unavailable. Defaults to false. Software fallback performance
> +#     is very poor compared to regular zlib, so be cautious about
> +#     enabling this option.
> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -1125,6 +1146,8 @@
>              '*max-cpu-throttle': 'uint8',
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
> +            '*multifd-qatzip-level': 'uint8',
> +            '*multifd-qatzip-sw-fallback': 'bool',
>              '*multifd-zstd-level': 'uint8',
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> @@ -1273,6 +1296,16 @@
>  #     speed, and 9 means best compression ratio which will consume
>  #     more CPU. Defaults to 1. (Since 5.0)
>  #
> +# @multifd-qatzip-level: Set the compression level to be used in live
> +#     migration. The level is an integer between 1 and 9, where 1 means
> +#     the best compression speed, and 9 means the best compression
> +#     ratio which will consume more CPU. Defaults to 1.
> +#
> +# @multifd-qatzip-sw-fallback: Enable software fallback if QAT hardware
> +#     is unavailable. Defaults to false. Software fallback performance
> +#     is very poor compared to regular zlib, so be cautious about
> +#     enabling this option.
> +#
>  # @multifd-zstd-level: Set the compression level to be used in live
>  #     migration, the compression level is an integer between 0 and 20,
>  #     where 0 means no compression, 1 means the best compression
> @@ -1350,6 +1383,8 @@
>              '*max-cpu-throttle': 'uint8',
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
> +            '*multifd-qatzip-level': 'uint8',
> +            '*multifd-qatzip-sw-fallback': 'bool',
>              '*multifd-zstd-level': 'uint8',
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> --
> 2.30.2


