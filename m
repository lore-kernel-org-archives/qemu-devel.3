Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3666C88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62uQ-0003KS-Gy; Mon, 14 Sep 2026 05:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x62uP-0003K4-0G
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:23:29 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x62uN-00079L-9j
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789377807; x=1820913807;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=svHSlE6xU8fQ4qWtQhPMZCloRmv/37L1gIJjXHIMk2I=;
 b=Cnxkq/4z20cjGagP3SZ68H7nt/Vceolzg52hvyStfoph73gNGffzpxrl
 0ps5isWRN5cfKPuJcT54wnT76QIydS3odnxPtmO2Im3rgFs3LMuBsc0WD
 FABkasjX+hUkKIKHJqx/zmWSo5tMrgjHI42AlsvMNvlQ6XNBrkYbWra7p
 VQPG0tmvocDdlMQOP0F+eqvybDWRA4O5lH06a+ElZQFnGiy5+Fq7q/NoL
 7M9ry7f4Njwt9VIbOwlg8RGkHHtIKd0YPCFPe40kBHfmDh95kivNOfdut
 rdP38Tn8Qe2uDiY2OJwT/enP2sFKIC1sky8E9w8TjGSZoC1gwtqtMP74b w==;
X-CSE-ConnectionGUID: 6JVbvgzhQSOKycb07Mh7cA==
X-CSE-MsgGUID: a5PPGNt4R52Kk2n8q24T/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93595751"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="93595751"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:23:25 -0700
X-CSE-ConnectionGUID: pkq5XaXnQmS2Px1A/JqlBA==
X-CSE-MsgGUID: aWHGQWFeRheOBGe8qi6ZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="271181098"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:23:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:23:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 02:23:24 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jO72EiY5Jacy1yTJGI4PinPCYQogNceuSc+VFi6r3U819fnIIr6WIkcvzhNmLRrEctPAhf37cIxddGJliyDiAwoM4EHpVRHPEm6FNox23yo/U2VL+3ZrUQvVNGSF7IBRsANfLmeSlh2aqsKZ8Iqa1ZaRKTpYFhugcdju2ydt29z/iS19HhKUj8jlIFrhXO3ADeQ50UINLnUT01HdqLNCXoCoqZ27I0GCmRcxW2Rld3RFSF35HPX7NdI74IzSqLXlBdy3hPRoR4kQjKEYT6kfKD7ugbhvU/14Sbfa8DzVA77m0SHIIeDan9YWBZzqTDEHrvmnuROWIfn0ro2MmCIrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svHSlE6xU8fQ4qWtQhPMZCloRmv/37L1gIJjXHIMk2I=;
 b=gKPqGfSDvXc7o8qMHuPSImIfM5f9quxUWIqFeR9GrIjsplVRN5416jGhJAlOe+D8/YFJWLin5tDRanFBRJUYQGXsTUtR1NxgTwK2y+6nfSz1uL6OTjbEDTROmhQ2A6bFSe6zUhusNkAZBG9kQ80g9ztfwpBhJ30rgWmGTOuBppR/ur2iNJ7ZK3l5a8Es66Y8KbpZiLVeewaXdHbK4WwNdVfBwP5XkfklPzBFEUqy+LGA+QseaSy6BnhPXI1aIrvYe9YOU55P0zwkzV1IvziXO9IUIpwjrmgHGgf5i8I/wPo0B0zk+LJjpuNwPDLRebFWSovUUN2bLlgG0mcbkDlEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by SJ0PR11MB5056.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:23:22 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119%5]) with mapi id 15.21.0382.014; Mon, 14 Sep 2026
 09:23:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v6 5/6] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Topic: [PATCH v6 5/6] intel_iommu_accel: Accept PRQ response for
 passthrough device
Thread-Index: AQHdQCzvYgz2Z9z/R0eqsz3JQZHujbbNuyWAgAAZJUA=
Date: Mon, 14 Sep 2026 09:23:22 +0000
Message-ID: <DS4PPF93A1BBECD66484BE380BE7392148D92BB2@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20260909072837.3183154-1-zhenzhong.duan@intel.com>
 <20260909072837.3183154-6-zhenzhong.duan@intel.com>
 <1c2a4ebe6ece6a8f6b3f9e74db8428d1c2c87290.camel@bull.com>
In-Reply-To: <1c2a4ebe6ece6a8f6b3f9e74db8428d1c2c87290.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|SJ0PR11MB5056:EE_
x-ms-office365-filtering-correlation-id: 18ae5c22-808a-4990-194d-08df1241d273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: h20BT1cKyqOmBagufTUGwbfVb1d3j9N5EGorxfTvzFIbFp56lI4a4eNWWGvxE2ePRASgL3b12oFRNmsGd4Zhf0WVM3vW9tSFcRhtKBADNVyqGGhZU4hwIQ14HAmbnwLchcmOTAU1pno2I5Y4EfkAIQ6KQqVNXS+xmvpKmDPM7vkBHV/d1BqW3ey18mqKvAez4lvborkDUg4REJc7KPgxZys+AmLL7xHuyv1NECJMpXBIdmsQNpcRlC7990XdZ2eLqDi6WlkvxfFXA7QrDOFuKT7T3BJ68d1c4YDuSlSodpRuYN4NmqtTVhpk8AOCmfAmX1VeB9kB1Bex+zb7AuQFm/3HTGs1IOe3X2vHLED91ZQI/kZyD/H1y1XC1a4/DZN3xRO7CPxczgkB0zxSEWagGx5d6r307cDqn6M6Gpo6V2Qbulqz2Oq0o9iUrGDLG+0SD7+MXbP2IpW/fJ5El9d6tIxhHExz3EOCp/8Inp2w/2L8Bg/rh4VurfnqSOXIncqz74ja7n6E5NIsAcgnO/GZrrVYDWRfRAsiaAO5GGfOf7IQr107JPjLvPrO161HA/ORlUNVaGxHTvouyy1jHUuUVnDrSANe2zoJtB3NtZKgO6GvqpEMpgVIVUcShboKR5FB1xFTqPGfqZzcC9eRzRAj13dywWG+Ww+NUKiq2rx80Zx3mjL7Z5q9i2Tdoa3RT1pcJSHV87zKBidH+t3NvQ0DoB0IptmdJLp7BJb+yrPdeyg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGZSK1VrTXdhMUt6eGdENGFPV3A5enREVW1xaW9ob3BmSHdVMTdJcGtrZzdQ?=
 =?utf-8?B?VndKeUoveDhVdnVkUHZJWVRKakovVGJXSUdDcVNLMnNaL1F4WGFGNWpVSEl6?=
 =?utf-8?B?MENjUmR1Vzg3MWJEZFRnTzc3N2l3bGVSbE5rZjVlazB2U1FMNEEzK2tyUlNC?=
 =?utf-8?B?NVB6TGRGMXljK2YzM1FmN2JUQzhJcFg1S1FSS3FOQ0JiazZkc0VDeUR5andR?=
 =?utf-8?B?b1I4NTZVMTZiSVhGeFdHakdJZllNNHM3MXJ6M2N0Zm82enRoYWdUWHNDN01S?=
 =?utf-8?B?OE5BRlpUc1UvMzQyQzhsbktoWEVQcWQ1Mjhwa0JVYmt1d2ozY25UQmFzbWlM?=
 =?utf-8?B?NHVuS0ZoTEVXUG14T0VwZlRiN0dId25XdXFUOVdZV0VNNzdONW9sU3dSbm5G?=
 =?utf-8?B?TkRNYWsyQ2FWUlJlbk1NWmtWcVRhbllmRk1zaVNRMmk5QXFIQXZTbmtZcndH?=
 =?utf-8?B?a0d2UHBSbmJaYnRSeGR3RW9lQnNGT1NSaEJqc1RBUXZoTnFPQ0dySGlwWjJQ?=
 =?utf-8?B?RmtQa2p2VjAzTE8vejBSOFBBYTZ2dm5HZ214QVY3MGZxL1JDeG1qZWxUR0ZP?=
 =?utf-8?B?dnZURkFxck9FQWp6ekhiRklOcThkZVJidTZBcnMrSEg5SnlyQW5STDB5ZVRl?=
 =?utf-8?B?eHBCaGM2Nmwvc0dWTGdzNmQxUDAyV09GY3ByVEo5S3ZCOWtBaWpDUHd1K1Fp?=
 =?utf-8?B?MU9CT2I0ZldiS24wY3c1bGUxWTlIQ00vaEd2aHNBYzRUajJibFF3aVZWU2ly?=
 =?utf-8?B?R1NiLzdsdGVpQy9kZUdiMnFmVjhya01Xc2NqYlEzcWhRY1VTWURELzc2THZp?=
 =?utf-8?B?N3g0eWYwbjNRSTQ0S3daZnNERG5KNUZ2ZW9jRm9lZE5KMm1SOVN0Zmg3dGgx?=
 =?utf-8?B?QStBY1J2ZmxZVU5pRGdNS3dLbnlEbnpsdWFobHpjNzM0TGN0bzRva2UwV0Rv?=
 =?utf-8?B?ZGJwNHJCTHRHWllXT3BqMzVEY1V4cDI0UHl5dTZQODZjZGhOK1F6bWdqRFFt?=
 =?utf-8?B?VVNPenNmdmZPQTRBNXdWVllTNXlZK2lScURZQUpTYkp3R3U2RHpRajhpejNR?=
 =?utf-8?B?ZDdwcUlnRzBNd1VlMnNlV2NJL2VPTG9iOXdFaXJEZXhlcjQxOXhtQlg4SWp0?=
 =?utf-8?B?UW95SzNISitDOWJlNmlINnI3bjRuUjZCbGNjT2RrR1cyMnduc2FBUTBBMGhn?=
 =?utf-8?B?WHcybTVOSUhMZDVWTkFUYUtKWTNxMHNrYTJrMzZKTlVaY0VTYjVZTDlSTk5p?=
 =?utf-8?B?R1RnTDIxclp0WHNaaHR6cHJRNUlERUxIOTE4U0JXb3RDL21EWDVoclFXV0tx?=
 =?utf-8?B?UGxaNUtCRWR4VTI0YVI2aUZ2cERCVzBXZk1qMTh4d3VyalRtanBkLzZuR3g5?=
 =?utf-8?B?OWROajNuak0ySlBJbmM5SkxHVXRpdGJUaVczZUJSYTlrakpYUFJpditkYXNY?=
 =?utf-8?B?RHVTRHpYOXgwcmJCWmlrM2dVQlVLQkZzUUtpbmhhSzdvZkY2aVFQUlVjdnlw?=
 =?utf-8?B?aWt1dURud0pFZnl2RUQ4Wk5BVjMrTzFhbjRza0ttZUtZN2Q0Tk8rY1ZLZ0Ry?=
 =?utf-8?B?UWswcWRONDF4YzRPYU91MXR1TEVkZm8xSmcrLzFrMFd4cXdIYnJTMDBpYzAv?=
 =?utf-8?B?by91VmJscDZTeFZuS2RNSjZ0Y0w4RDJ5ZllPSHpRNGlJZXpvV29HSjV1Vk1w?=
 =?utf-8?B?Z1BtdVlGbUdkdUxxT3VZOHN1VFdkSGxMYlF3YlhCazJnNXpuWmhodlhRSTFx?=
 =?utf-8?B?L0hnNHhaeDFHNDEwNEgxV3NHS21UdldBc1UvdmI0N3c0eUd0N2lXVytGK0Jh?=
 =?utf-8?B?cTFyZ0dmekFvTXNEcmFSbDJnemZxZTA1TUcwZzR1UE1QZlUrYXJKdUJmTE9L?=
 =?utf-8?B?TkJMVEM4WExQYkh1K2VadWNLMkR2ZWdzcjNtNXRzMkttQWNXUnUvZllCVUxp?=
 =?utf-8?B?TGVxWjNhakZ1ZG0veWFaSnF3cHZMK1JiQ3A5RzZZNUJxZllEaVcxNkVFV1c2?=
 =?utf-8?B?TUlnYVRmQktjK3RvZUowaGZsc09KVUpTUWxmRWZJclZ6QW00NmdlWStvSmNm?=
 =?utf-8?B?UTdiS0ZiOUVuMUFGZHplY3VJeEFKdTdWdDVBOXFIcjB0b2Y5amtHbTNzZ2dr?=
 =?utf-8?B?Z2JOby9Penp5Yi96aUh5YkwyVzRiZ0F3aXZINi9ycllsNlpub2JaaXlFUHhN?=
 =?utf-8?B?V0hjUlcxNUFlVVdjNHZhZnU2WVRsQzQ2TXhhM0ZnWXRKcCtsQjlvWmxMR3Nn?=
 =?utf-8?B?eWVDS0V2eXFSYzZHKzVaOEJkTlp2d0F5M3ZSQXVEczhHWmM3WEhlWXc4dzZk?=
 =?utf-8?B?bXZlb1lOVG1DYTkzOWdMbzFuQ043dlREQTVld2JKVUVSM1RUa0JnQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JCUcNDAxCS30tDG5wP6mtGcYpRMOTkSlXJuqeLldmhAoO3us45hgc/E2TXBzQ2eseCy0usm3On2Kh+ommbMsgeV8n2Einz+X9xhOIjmxdBLuyixV+MJ3u3zn1oejH4WCh3I5haJQzfBtSEL0D48BozKvFnE5K5vYii8h2wLLaTWcxl9oXVhlK07B6hiVrEYjFkIUQ3bsLiq0+ggrWXeJNUYHLTD7z6F/BeGSQZsbdMrW3G+hyhe2tVCJqPrp+FZY17LsO36k3bOImIEdeQzrk7LJH/D9vgyPUxoB/9XviCvFZyxAUlMx2dNE+CX+SAKSIQX9k41xa5uNIPvjKMeWgw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae5c22-808a-4990-194d-08df1241d273
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 09:23:22.2780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IT37z7JwmG51v5Ua067wI3sMMt0XhCdQxdRWPwBk9vxQmOqQFdX64ibvqkDtz206v1sLJOkkNCygnn2OJypEnxV6Qavo7Q0r50IxlfiFP+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsw6ltZW50IE1BVEhJRVUt
LURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHY2IDUvNl0gaW50ZWxfaW9tbXVfYWNjZWw6IEFjY2VwdCBQUlEgcmVzcG9uc2UgZm9yDQo+
cGFzc3Rocm91Z2ggZGV2aWNlDQo+DQo+DQo+QSBmZXcgbWlub3IgY29tbWVudHMsDQo+SW4gYW55
IGNhc2U6DQo+DQo+UmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5t
YXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPg0KPk9uIFdlZCwgMjAyNi0wOS0wOSBhdCAxNToyOCAr
MDgwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQouLi4NCg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4g
aW5kZXggYzBiZDI0OWM0YS4uOTAzYzc0YmFkMSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXVfYWNjZWwuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+
PiBAQCAtNzgsNiArNzgsNjIgQEAgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9maW5kX2hpb2Rf
aW9tbXVmZChWVERBZGRyZXNzU3BhY2UgKmFzKQ0KPj4gwqDCoMKgwqAgcmV0dXJuIE5VTEw7DQo+
PiDCoH0NCj4+DQo+PiArc3RhdGljIHZvaWQgdnRkX3dyaXRlX2ZzX2ZhdWx0cShWVERBY2NlbFBB
U0lEQ2FjaGVFbnRyeSAqdnRkX3BjZSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBjb29raWUsIHVpbnQz
Ml90IGNvZGUpDQo+PiArew0KPj4gK8KgwqDCoCBzdHJ1Y3QgaW9tbXVfaHdwdF9wYWdlX3Jlc3Bv
bnNlIHJlc3AgPSB7Y29va2llLCBjb2RlfTsNCj4NCj5JIGtub3cgdGhpcyB3aWxsIG5ldmVyIGNh
dXNlIGEgcHJvYmxlbSwgYnV0IHdlIGNvdWxkIGJlIGEgYml0IG1vcmUgY2F1dGlvdXMNCj4NCj4g
PSB7IC5jb29raWUgPSBjb29raWUsIC5jb2RlID0gY29kZSB9DQoNCldpbGwgZG8uDQoNCj4+IGRp
ZmYgLS1naXQgYS9ody9pMzg2L3RyYWNlLWV2ZW50cyBiL2h3L2kzODYvdHJhY2UtZXZlbnRzDQo+
PiBpbmRleCBmY2QzZjMzZjBhLi4yYjJiYWViNDA4IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni90
cmFjZS1ldmVudHMNCj4+ICsrKyBiL2h3L2kzODYvdHJhY2UtZXZlbnRzDQo+PiBAQCAtNzgsNiAr
NzgsNyBAQCB2dGRfZGV2aWNlX2F0dGFjaF9od3B0KHVpbnQzMl90IGRldl9pZCwgdWludDMyX3Qg
cGFzaWQsDQo+dWludDMyX3QgaHdwdF9pZCwgaW50IHJlDQo+PiDCoHZ0ZF9kZXZpY2VfZGV0YWNo
X2h3cHQodWludDMyX3QgZGV2X2lkLCB1aW50MzJfdCBwYXNpZCwgaW50IHJldCkgImRldl9pZCAl
ZA0KPnBhc2lkICVkIHJldDogJWQiDQo+PiDCoHZ0ZF9kZXZpY2VfcmVhdHRhY2hfZGVmX2h3cHQo
dWludDMyX3QgZGV2X2lkLCB1aW50MzJfdCBwYXNpZCwgdWludDMyX3QNCj5od3B0X2lkLCBpbnQg
cmV0KSAiZGV2X2lkICVkIHBhc2lkICVkIGh3cHRfaWQgJWQsIHJldDogJWQiDQo+PiDCoHZ0ZF9y
ZWFkX2ZzX2ZhdWx0cSh1aW50MzJfdCBmYXVsdF9pZCwgdWludDMyX3QgZmF1bHRfZmQsIHNzaXpl
X3QgYnl0ZXMpDQo+ImZhdWx0X2lkICVkIGZhdWx0X2ZkICVkIHJldDogJXpkIg0KPj4gK3Z0ZF93
cml0ZV9mc19mYXVsdHEodWludDMyX3QgZmF1bHRfaWQsIHVpbnQzMl90IGZhdWx0X2ZkLCB1aW50
MzJfdCBjb29raWUsDQo+dWludDMyX3QgY29kZSwgc3NpemVfdCBieXRlcykgImZhdWx0X2lkICVk
IGZhdWx0X2ZkICVkIGNvb2tpZSAlZCBjb2RlICVkIHJldDogJXpkIg0KPg0KPlllcywgc29ycnkg
Zm9yIHRoZSBsYXRlIGFuc3dlciwgSSBub3QgYWdhaW5zdCByZW5hbWluZyBzc2l6ZV90IGJ5dGVz
IHRvIHNzaXplX3QgcmV0DQoNCkdvdCBpdCwgd2lsbCBjaGFuZ2UgYm90aCB2dGRfd3JpdGVfZnNf
ZmF1bHRxIGFuZCB2dGRfcmVhZF9mc19mYXVsdHEuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

