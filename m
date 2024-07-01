Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8841C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sODbj-0000HG-6r; Mon, 01 Jul 2024 05:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sODbb-0000H1-NI; Mon, 01 Jul 2024 05:45:51 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sODbY-0007LM-2I; Mon, 01 Jul 2024 05:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719827148; x=1751363148;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=lemxPrPeIpzRi7FbiUnFMGNXfE2Z+hZjBK98pHFnb/4=;
 b=jRJib4ZbpSTDFHNqgVx1GKH9oy3cLC3Eu1GeAOtkMAO8vehnw96cHmMd
 5YBUd06cJsiUzJZJ8rROWaPg/QzkqbsnP3HQkcULfPT2iqlMdxtUPPvqx
 HiLkfqxj+EyLywHThKxdh4LxaInlZhdihCGTXZXd+yigwnX2WQcLpQ5Il
 4B37YXBZ6/uhMIDAeBZW5QbFQJw3TyWLwa3Nw72jalb2Tn+95Ix/saEex
 SpWntpUAq4YbIfhTEiK5AKtoV1hSpi5UiD2AVt8jJVWVSyoS7As0yyiTr
 9CkgeBPwhQmAKXKcsf2oWmrOFDYljJWaGF9JKKoxc8UbWYnaybyH3bmzk A==;
X-CSE-ConnectionGUID: KcMXHYNHTZy+4CHrMUUo0w==
X-CSE-MsgGUID: w6J3v7maSsuU8anfg3FjSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="20757119"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="20757119"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2024 02:45:45 -0700
X-CSE-ConnectionGUID: vBjfs8g3RJioOrGmDXi7Iw==
X-CSE-MsgGUID: JT64uID5RMyF2eLm7ERqzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="49789919"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Jul 2024 02:45:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 02:45:43 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 02:45:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 02:45:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 02:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTMrShKJW+S5x6kITcZXlSq2zgo6wIyW6YYvh88lUX5lmJ2mpicjC1Liin09BQeZUZRgtrFEBGUHlFuRKhzFBhOS3c3j/fA12mkRM131lpeTDmi0wKVc/jceRiPfCdrrTSCpwkXIijAMmTUjL88PiicFvH9kC03ysSR7bqr6bnBJ2iMCwsgDOanmpoq9RYReG4IZgG+e0YN1cm/UN27qlRhWtbr7dglS3+4wpUHGb9IRHdvECUD13xoWSm0eHQcno/X1fDQQYgzVQZzGucpFuJSuYAUYiM9JG6SWh9bMMoC+2wVKKQ+coFsM6UPVD0RuMnPXKffGKH3YXpFb8yomwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfeaPaZQaUjsoBcOGpAV+8zbj6lZMOE/RueONZl1plw=;
 b=V2HV4eTO1T85oQ57dNIyVWZUmSSb75PoBMbUec89W+Brj7nN4qO+o2+6GpANeSLLHNBF//ZjtjoGbsBoNBngVdhrWI3my/8cQzuGti/etrbiNmOMfj/D2119O/VxXAv/MKV5hbwHS8FZyFAzHEqV9ZnscYueYDfhodphabAG/1BC7J3YqfYbZSz3LB4MCQJ4Nx+1WxpjlX3Mz4nL+obqGEhINjjjBf49Wq7CIaXWnaZCT/zGlrMeb9LP1FXGCXa2g5n+y+rAA8kZ9J3Lfvi0KNyDeFatrcQijHpU3wxiW6Z6nYzetpg/LvMlCN4gBwcg5caHYxpaTD+R9YiOzVA8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7789.namprd11.prod.outlook.com (2603:10b6:208:400::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 09:45:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 09:45:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 5/7] virtio-iommu : Retrieve page size mask on
 virtio_iommu_set_iommu_device()
Thread-Topic: [PATCH v2 5/7] virtio-iommu : Retrieve page size mask on
 virtio_iommu_set_iommu_device()
Thread-Index: AQHay5PDClnD+Hs7ZEOHhx+qPzrtCrHhne6g
Date: Mon, 1 Jul 2024 09:45:35 +0000
Message-ID: <SJ0PR11MB6744A5C0B3D89B04C30B636092D32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240701084957.1567641-1-eric.auger@redhat.com>
 <20240701084957.1567641-6-eric.auger@redhat.com>
In-Reply-To: <20240701084957.1567641-6-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7789:EE_
x-ms-office365-filtering-correlation-id: b2b5cffb-72e9-4a04-7e79-08dc99b28e62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vQls/+nFY/X7ksqkQzlZfegLRMZI6S8PJssgZSOMSxWLQBzxVvNvdSgUlDhg?=
 =?us-ascii?Q?552N9+K9hqVfE5QSZVnvj6H3aVcenLJk7gW8p6r5q6iGwxf4mycZg45p3Ioe?=
 =?us-ascii?Q?/WHIaS8RiYrjVp6QJD/AF1d/F2/IUrbvgWFO6KrOBiD/egLPu5GPCelk7scI?=
 =?us-ascii?Q?rRbShOpS6/4xjc8eoiJbcxB35MyQI0MIFdBHRJZ5V7t7Ow4TFkjkzz15O/6G?=
 =?us-ascii?Q?B/NGxkaO+iIqdh3dor2r9IhAWb+IEaBtZjnv8raEAYNYH6Hjy/wTQUp04R6q?=
 =?us-ascii?Q?YoKuvcAQv7UKR/Z1C73AwebJsBH/SMmSBVM0jP+4+1AaxR71QBB/svhvSByG?=
 =?us-ascii?Q?essbXss0j86k09P6ZGTaWYlrqlJ+vD6Y4EGEOZc2f0ZpMuTH2EAwW9n5wD6K?=
 =?us-ascii?Q?jl4yZwQUZ7qPc9UOWzMedB11Xu18mcvLSFXLvaAo9Psro6qQIsrk91zdNsEu?=
 =?us-ascii?Q?drWVLklHxiMLgK5/Yu9lCERVpYJxsid8gXL2k1m0h2mTOuq8PKuW22VPbEU1?=
 =?us-ascii?Q?LWcCVFwg0LfysETElXLtzFl5yycNy2q+YMjuzz0noUTB2C8cdGYARWxZep9e?=
 =?us-ascii?Q?m6rhCuVKr1L3Jol4Pis1zbvBaHs3nBhDWiTXaHJ01yTOIaHCYEEiMyQRxrqx?=
 =?us-ascii?Q?jR1bHYdGC2By3zaNChCUOJtE018Ow9OXq6jRFR6iXKtpfBR/at19VFcZQtH1?=
 =?us-ascii?Q?1pqvXO0eBuuaTAlwRZ6qNQgswinYuvCHffcR1bnSBSzouToausnPAOtz6CjA?=
 =?us-ascii?Q?xMTweCQ22r9JuXo7GkjC5Am7znx6LSseeQ8sUnXEnFdikAs3APrLklk6gvrx?=
 =?us-ascii?Q?Gvwmyt6bNsQQR0Qlp+RJU6Fr77OHGRavsQYX6mBlwlBHoF/C1JChXrwq1vDm?=
 =?us-ascii?Q?bCioRDwMxVKTxB5Uud1/SV4pt7JnlQ+gNosH9ln3tT+9GkHwogKkNQ+o2+JJ?=
 =?us-ascii?Q?wYDLAHyeuGEW2SiqxbDxZk42y+DLQbxiJmbTJT0RIvrBwHLb+bwISUhL91yb?=
 =?us-ascii?Q?0YeNuQy+rdCB9aghUzcInZdybSruPAERmnBYZxH5yww7JTFs7EYo1M0Mcyjp?=
 =?us-ascii?Q?MpCWXuVOR5vv8+VMewb+UIY59WCgfwDn+8iiu8jgQZ25YRGy/D220KGg27hb?=
 =?us-ascii?Q?y9xpAEn3KfK5MJGjxha7DQSy2aI3euggA/aSwSObNwaY/Gp3J+2elE9ipvT8?=
 =?us-ascii?Q?Ba099GnD5HhQDDjrGQjCJ63UWibCaXYp5jVEfVQEgzPWiyv3ittKzppDqa9f?=
 =?us-ascii?Q?EksD5mvPxLnXIG9xCdv2t1xcAXOhCho3gu7f/xn5IDa9XUvSUN1kaYdp7B+4?=
 =?us-ascii?Q?TegTvuHiKczcETtouvAZ/CuQh/4QOWAXI9Yx3j5GHZl4CxGYlzSsgq76zOIA?=
 =?us-ascii?Q?0YMBm5Xo3z3JBnQrNsC4K/DDId4LoTI4AyyPTuaNnInXN/NeLsdg4MpM5IqI?=
 =?us-ascii?Q?nhXJLqtjNQk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8r4/mrF+GsseUqpITHbiFyGTbf9jMNX7xxegNGRoBcRfOOq+FepfT36veqSc?=
 =?us-ascii?Q?1MNLZb7OJmcsjIgH+OkDiLDB7ny43U+jVTYKWnOnWApHgOtk1NpXeqfHNZap?=
 =?us-ascii?Q?FRthYSu3jp8VAWuzyHpf2UHEWeJosIPAIgc+OtVoZ55lVb/Od0QVG8K5TcuB?=
 =?us-ascii?Q?nFadpWFuJwnhxaBHzfswkI5904rTUKTxzR74khQbVQXE0QZ83hlgX3+bP32C?=
 =?us-ascii?Q?LGQXtl8WYlL2ncfeG1aWJ3cTKwkkZO8iCTn1lXb9x58UDMmAPPOtRTbMvJWP?=
 =?us-ascii?Q?R50OALAlnbqa03+qbd5UBPzLWIlHREj4DNQ0Gj9e86RdSj9BZc0mdEacQcNK?=
 =?us-ascii?Q?ZRvHBwZ/Xw9lSSCvj7mz1W1+MIowKgY6TjIgAdds107DcW1h1O1dpYkCxf4h?=
 =?us-ascii?Q?/F2w9KVR5SQXN45CBnWlxp6kfm5li9/8jYTO52XlBHK8YaXTgovCBU8NOKG0?=
 =?us-ascii?Q?+uygRamOtVsxXtDdTX6KB7YqwOlvgoRdQx3KqGYWTRf7aYCs86ukrN52gCXK?=
 =?us-ascii?Q?KYt1euPgNLoGLR0uT7yuzc/8MbH4TebeKRwO+BgNJ51m7DGlsxnKNpqv37GI?=
 =?us-ascii?Q?mKnytc8Aqitqp1ZkRWOA4ydSoIPORT8fqFXNoyFLpadaIsQeiHR4YlYTibn1?=
 =?us-ascii?Q?F/qoOlaJ0PqT1UfVz5qC/u13kaNAxmhfVeHgbL5jPD+VkSPh0j/Hb4kgi7a/?=
 =?us-ascii?Q?+u8pIQ7kqVWUOTjJpFulKdWY2zTXoO/xjSVQjGwsWpaUK16ReazMNkSOp2wL?=
 =?us-ascii?Q?yf/GpjLS1QyHuVjS7vncrVLZxyeXeferNSE1MNU6hjTznfsL93G0fR4BzkCI?=
 =?us-ascii?Q?L0nrpEyoANylAy9TDFzWdI1DzyQk2cpzj7a4rmYsxaJq+54uveuZvXSSL6zq?=
 =?us-ascii?Q?6ddjWW3Wk5RlnL+j4T5DgSAxYLMkbVfWiFVWmDybcDe5SQqEupKcILo2Fdpc?=
 =?us-ascii?Q?/Y6qvHWgaeOTOHGDOpazp8fz48CReY0agiCd0XLw+NkG9P8qwgIX1SYCrAK1?=
 =?us-ascii?Q?nMucEZ/i4SDJkiLAtZvGu2c9/H4Qm71e8BmlVeXRFV/5WulQ03g/P3dEmoS0?=
 =?us-ascii?Q?YSmoNBwEqGdom9ZjMc5InU9FoOyXuFw1o3wsxBLTOrgQdOjMkmMW6zvfFbCo?=
 =?us-ascii?Q?raXd75r+g4PXk2ZX1TkNncKrGBK5ODqJbN+n9fDCZ8ayekmzPwiBIO1gT+cx?=
 =?us-ascii?Q?agM3IVz1q8PhnvTcu0LTb76MABkMVbuMQcPd0xpJwyI/IIz5wik77C/QKm3N?=
 =?us-ascii?Q?bWvO+CIOoaGhu4w6MDAZZbfSX7nSt/C6qdmSUi1F6YekcfCqsnDqZeaGqJp9?=
 =?us-ascii?Q?40Hq//YS8SXpE3Wr/n4IhjePN5cFkhwNYE69/pHsapT48+Ue38GRQ4SZsID3?=
 =?us-ascii?Q?489G7TUon4GBK7ggq17WduYQJQ8cP5ZLxF4DLBUWFZ7Um8VxzbBUwY26jc7/?=
 =?us-ascii?Q?2U3vUcuHdRhrVuLVzgsasfWF7o3oSmhUQllzGEoBHnI754/AlcnlzxLVTLly?=
 =?us-ascii?Q?thmZ29bwAzQzq8mQBQIc0+R85bBNnMfSNKqsEBxZM/KwDVLMRFOT46GnOcVq?=
 =?us-ascii?Q?IPMmqcY+7fZoUBlERi2M/q8YzcT5Bh6ksffEOrkg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b5cffb-72e9-4a04-7e79-08dc99b28e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 09:45:35.1642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hklm6bdGljh4DZ5FZZEjnr9ToyEcKllth2KmDk5ynIqfTetu/XGxoXY4wkweZmi71AyOu1faN4iEnI5mgrcwPC9GWAzq7V3F5SmAZVB33kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7789
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>Subject: [PATCH v2 5/7] virtio-iommu : Retrieve page size mask on
>virtio_iommu_set_iommu_device()
>
>Retrieve the Host IOMMU Device page size mask when this latter is set.
>This allows to get the information much sooner than when relying on
>IOMMU MR set_page_size_mask() call, whcih happens when the IOMMU
s/whcih/which
Sorry, I missed it in last review.
>MR
>gets enabled. We introduce check_page_size_mask() helper whose code
>is inherited from current virtio_iommu_set_page_size_mask()
>implementation. This callback will be removed in a subsequent patch.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Otherwise,
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>
>---
>
>v1 -> v2:
>- do not update the mask if the granule is frozen (Zhenzhong)
>---
> hw/virtio/virtio-iommu.c | 57
>++++++++++++++++++++++++++++++++++++++--
> hw/virtio/trace-events   |  1 +
> 2 files changed, 56 insertions(+), 2 deletions(-)
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index b8f75d2b1a..7d5db554af 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -598,9 +598,39 @@ out:
>     return ret;
> }
>
>+static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t
>new_mask,
>+                                 Error **errp)
>+{
>+    uint64_t cur_mask =3D viommu->config.page_size_mask;
>+
>+    if ((cur_mask & new_mask) =3D=3D 0) {
>+        error_setg(errp, "virtio-iommu reports a page size mask 0x%"PRIx6=
4
>+                   " incompatible with currently supported mask 0x%"PRIx6=
4,
>+                   new_mask, cur_mask);
>+        return false;
>+    }
>+    /*
>+     * Once the granule is frozen we can't change the mask anymore. If by
>+     * chance the hotplugged device supports the same granule, we can sti=
ll
>+     * accept it.
>+     */
>+    if (viommu->granule_frozen) {
>+        int cur_granule =3D ctz64(cur_mask);
>+
>+        if (!(BIT_ULL(cur_granule) & new_mask)) {
>+            error_setg(errp,
>+                       "virtio-iommu does not support frozen granule 0x%l=
lx",
>+                       BIT_ULL(cur_granule));
>+            return false;
>+        }
>+    }
>+    return true;
>+}
>+
> static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>int devfn,
>                                           HostIOMMUDevice *hiod, Error **=
errp)
> {
>+    ERRP_GUARD();
>     VirtIOIOMMU *viommu =3D opaque;
>     HostIOMMUDeviceClass *hiodc =3D
>HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>     struct hiod_key *new_key;
>@@ -623,8 +653,28 @@ static bool
>virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                                 hiod->aliased_devfn,
>                                                 host_iova_ranges, errp);
>         if (ret) {
>-            g_list_free_full(host_iova_ranges, g_free);
>-            return false;
>+            goto error;
>+        }
>+    }
>+    if (hiodc->get_page_size_mask) {
>+        uint64_t new_mask =3D hiodc->get_page_size_mask(hiod);
>+
>+        if (check_page_size_mask(viommu, new_mask, errp)) {
>+            /*
>+             * The default mask depends on the "granule" property. For ex=
ample,
>+             * with 4k granule, it is -(4 * KiB). When an assigned device=
 has
>+             * page size restrictions due to the hardware IOMMU configura=
tion,
>+             * apply this restriction to the mask.
>+             */
>+            trace_virtio_iommu_update_page_size_mask(hiod->name,
>+                                                     viommu->config.page_=
size_mask,
>+                                                     new_mask);
>+            if (!viommu->granule_frozen) {
>+                viommu->config.page_size_mask &=3D new_mask;
>+            }
>+        } else {
>+            error_prepend(errp, "%s: ", hiod->name);
>+            goto error;
>         }
>     }
>
>@@ -637,6 +687,9 @@ static bool
>virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>     g_list_free_full(host_iova_ranges, g_free);
>
>     return true;
>+error:
>+    g_list_free_full(host_iova_ranges, g_free);
>+    return false;
> }
>
> static void
>diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>index 3cf84e04a7..599d855ff6 100644
>--- a/hw/virtio/trace-events
>+++ b/hw/virtio/trace-events
>@@ -132,6 +132,7 @@ virtio_iommu_notify_map(const char *name,
>uint64_t virt_start, uint64_t virt_end
> virtio_iommu_notify_unmap(const char *name, uint64_t virt_start,
>uint64_t virt_end) "mr=3D%s virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
> virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t
>virt_end, uint64_t phys_start) "mr=3D%s virt_start=3D0x%"PRIx64"
>virt_end=3D0x%"PRIx64" phys_start=3D0x%"PRIx64
> virtio_iommu_set_page_size_mask(const char *name, uint64_t old,
>uint64_t new) "mr=3D%s old_mask=3D0x%"PRIx64" new_mask=3D0x%"PRIx64
>+virtio_iommu_update_page_size_mask(const char *name, uint64_t old,
>uint64_t new) "host iommu device=3D%s old_mask=3D0x%"PRIx64"
>new_mask=3D0x%"PRIx64
> virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
> virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
> virtio_iommu_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn,
>bool on) "Device %02x:%02x.%x switching address space (iommu
>enabled=3D%d)"
>--
>2.41.0


