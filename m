Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6335BCD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 10:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRSb4-0004i5-Nc; Mon, 25 May 2026 06:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wRSb2-0004hk-5m
 for qemu-devel@nongnu.org; Mon, 25 May 2026 06:31:44 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wRSb0-0000Ai-5J
 for qemu-devel@nongnu.org; Mon, 25 May 2026 06:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779705102; x=1811241102;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3wiXU21BUtLci0l0oIJ3vxjOZnanuF7OEk41QVyslHI=;
 b=aGsgB0fQKMIOy4Djq0Kp5KUhdEswiSVfIY92JLdaBgB1yV0CL2NAgUfh
 YYo1bL8O6g8j85o2KyBpJCAEc275B0PXwbq89SahiVialRQ8oiaG/3mT0
 dj+iSlOH+4fVlErZYb5sdBWEDXRKlV1nJUfVJMvwysvtAfz9kuNW6+3vs
 jXg2RR0iW2w1KskzwOYfyQHYl6GBH1hVhmVlfmOb93lsFyuzRX1HcZy+D
 RzOc3VmBT9OwuiozDz3Kalirz+JFDJdRRvviFMvBhKq6K17MDYqLT2p2n
 lknk1MpXSLIq01/e9qMvmv4Wtp64mWIaOa7mFInQ5xpZdv3i67HAOL6Ef Q==;
X-CSE-ConnectionGUID: eMx0LpXQRNmIBKo9b1cFtw==
X-CSE-MsgGUID: 46r1bx+SSXuSAByD/mTsRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="91633745"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="91633745"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 03:31:38 -0700
X-CSE-ConnectionGUID: 7FfVK/+rSDWXOSR1qY4X7w==
X-CSE-MsgGUID: fXvwz8chS5GcyXQ87+fJjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="243406018"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 03:31:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 03:31:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 03:31:37 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 03:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4PTUyC2608pzl54Z2wAipIn2lvSUWDjUgUjlXvqFUINZWEXuzN0j/5mEx+/cYkIqwUXGD5qJrE3WusArf49NO5igoYIpFjpLlAlHBTnwBOYtEzIatkG0yvkzXy/oB4AB8Av1YDtZJvFOFa7vajdtzRjWkEI0deyv9QhOsssmDZYwYVauOHwwyRTtkaMkpC9GEa5Jdstrlis3fZ3T2tvsgUqkpYdkOxC+m7h/Egba9VA4jRMtw4daWAEElDTJWzXwkA0wFhheR4Mr3Rs3DI4c1FV3CBjI8TbSBh6O7uvFF36FbCZTrYNOUSj3RU0T+F79PRr0n+n/+JFz4aeW7EqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/hNzCwAeYylwn7co7QoOfqFUb+AalcD6iFAxLglXQY=;
 b=nhHtU+zCFfeLZuCZInQcIu0NgV/eCNomcxOZsRY0xHU3uevOPxaCl/3V33YMddqinxcUBtLiGISr/l902dzS00yk3g4YJWpsXleUvRlldfM5WLnTbfnDAeNrR7v9v2Inx4eSbpHBDv5FGTis1rVVHV668IrhbCBcnU2aUplg7Vv3GVUZIKE1LjeldvbfBj2S9EON1/3TZYQp806zg4vTffMDdLY7yRk0e7LiWOz1s3E7sMDY9iWZJzyx5BNxEr4Mewv/PfnDDYovAK0dnDd2VA8dkILAnQtzqW0WEvFkW7VSfj0Q/n6pXx2CcXBdI3NiM4jzBWxbT3cBuUTm6MnB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB7051.namprd11.prod.outlook.com (2603:10b6:510:20e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 10:31:34 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 10:31:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Qiang, Chenyi" <chenyi.qiang@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, Steve Sistare <steven.sistare@oracle.com>, "Chen, Farrah"
 <farrah.chen@intel.com>
Subject: RE: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
Thread-Topic: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
Thread-Index: AQHc51R9QaxMMIgCgUK6cdv+zRft/rYekyZQ
Date: Mon, 25 May 2026 10:31:33 +0000
Message-ID: <IA3PR11MB9136AD783C648B7ABF5E65E4920A2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260519055756.70575-1-chenyi.qiang@intel.com>
In-Reply-To: <20260519055756.70575-1-chenyi.qiang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB7051:EE_
x-ms-office365-filtering-correlation-id: d8f7c687-f58f-4e58-aa77-08deba48caaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|11063799006|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: bqcPNCEGZZ3NQS8BbpUUUfYEh13q7DtnFx/fdwJY47oGegE963jc5/MbdkDjdzDBoQlWDXJuO/Er5rZ+eJOJaQdsq2I9RhXt4fGE0VRI7i/Y+aDlM/uoiyMjKt26VUnUuqIbyXQVVGalD9UqYeqr2a35nVEGcYxjh+xAaEbSqdtpDzMS6S7HRtJH/bO2T3VF35d560LUCe/zxPmcctJ7ZnEvIYpn4Ltw2sc/2fJlAxTBuRkWBUfQRjrdfHM7nj4LRJczHVpf3vNW+PPoB3xPdkK4Iu99wcK1CSPj16eFni2zJ4Dd457ncBeP8FWpYI4DvvFXmZhyAkC/whdktnNodtc00mZBe7PvY1FF8d0o7JwJRjV2IFEV0Qte+8QpUssYcAi8yoxtMT12xQHtjRZ2PGjcwOh6MoV6qJYMbG+i+3VgSmGX7iI6yd6WX781dmStN5WORGkPZgIrbUuxOINRBuYAdvhJPBcW3sFrz86hFcRluItVAGsQ/d7M+730wMYoe23HLzHaNEPr+awEynnjNb2qj5cXrZMtd4eo+gE5xV2JjxKwJK9SRP6hvgkxGNQxvTqVG7iWafvJbaLhfKLhcU0htAdksO9TJtEqgyB3Za4jEr8+5osVLi9dUSFHwAofBA3ChoRq0Wt2BqzVmVuvjzDJMovBE4d8LXGsZIWuduSRpXjKr5irXC7J/gsLlXw04yS/3BQLdOIowac0sA8cYgPin/8+IzI2M4isSk3/fFDh+EO1ST9kySMhxSyuWKNI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?psmth9DhVpSbnWZnuBSVAQ5ZgUOk2bUEZAjmwzKIx1380M7QpvUBRg1w9i?=
 =?iso-8859-1?Q?ZNEVFZ/i2peVnLxlr4pRMQMXZROq7ZOit3MpZIDs3bw8ut84AWaidPUAZN?=
 =?iso-8859-1?Q?6hjz3tQwdLvHc6Rbpbmun0+leBJvOZU4wzKG81O94rmkYLaGuKJzfEGS+b?=
 =?iso-8859-1?Q?GE3xsUPAOSGX0irxy+efABtYdPyKBgfpjJItHkfNEGQKCjsFuVAhkp1Jk2?=
 =?iso-8859-1?Q?/AT0FKfDMwdfTt/L9fLZimdHBPmJf9gom9TvNj03bg8cVezHBHXbAzyhSS?=
 =?iso-8859-1?Q?rlS5GhNPWmdtCmsX/rRjtz4wAbpPVhhTFZl6OYx/zwrAlUzGxwmVCNWJP3?=
 =?iso-8859-1?Q?UPDc117cglWc/3ym1Htwr7/nofjE1ZYi+h+A1RAxT2vMrCmI7UbP2OO1tS?=
 =?iso-8859-1?Q?R95ljZSbJijQkb128PaVMu8eNujzTnJCAwUgIni+exv0yMc8wueY6LmoQH?=
 =?iso-8859-1?Q?UJXVD0crGja8Sob7dJMfwAWR5RTbiBpOMDMIszAlyNbcKkI5Hh0kEvqUkh?=
 =?iso-8859-1?Q?EWW5EtmtBrRBJPFl0sD1+ZBOGuNVkVNk11XFQcziDC6T2/eRL594UJSzRG?=
 =?iso-8859-1?Q?nGBDS4YgAXOEYkiPEt0MTEmF0xsfA/k2dqWXGCAPXLxz9LjAoCXJc/HiIk?=
 =?iso-8859-1?Q?X7PLePE3mUR29omsyAN/4TXqZdN9+8lNC/lt14u2vPu7lZXrLQzxt79R/L?=
 =?iso-8859-1?Q?7KvIBgE+kps7JgrJuiIZ3uVZRPgYrztz2Xy3hpiAw6PlXk5VecdTg1khlg?=
 =?iso-8859-1?Q?l4KqTlTfpJ0NBSmrP9q6RODiK/uvJ5k5cPoYP8fe+BaXUC1Nsj2XgX9wR4?=
 =?iso-8859-1?Q?s6wBKfi+IO8TRrKAc8FoHK4MnyFAaZaSIU6ZDkBbSSBfIj2UYYR7ixpNfJ?=
 =?iso-8859-1?Q?cnQJkAMpM5UJWiK0QlMd9PQlbMCjtYB89GS4Vp3nBbhjyJePLzpyqIk55B?=
 =?iso-8859-1?Q?+0AsEqyBJtHJNv8C1ciZQGIj61oodD1FvAhNwlHCCyKcwRVYI9hxz7QRKE?=
 =?iso-8859-1?Q?Vwam+xnHEiVKGJYXQ/ji0v/ZyL86UaF+DxmE2JO6xTZ8bD+yLxKQe5ZPRf?=
 =?iso-8859-1?Q?2meD8S8XowAhQnrko1IpjeqbV/LB5/3B2l3tewfubjMFi4rGu3DKxVABdX?=
 =?iso-8859-1?Q?SgCNbBtfSj1uKDR1Lpshn5zuWtlecaqyL8ggyabOF7j7EitEl5bszbpOq9?=
 =?iso-8859-1?Q?49mx6IADVPdDbCWRKJYZB0IJG3TxBuqhg9rTo52Hvw9VZBXrmVOregNPjB?=
 =?iso-8859-1?Q?BtMAw4C6dQJ/08ro20jUOjSsQDGIt6kggfg3KQdjtmZInK9BYyPOGSBHlz?=
 =?iso-8859-1?Q?J0DCWRdTcO5a5jBV/9uMtU5EfpPl1MUiHs1PQ0VjGICPPPrb0bMpvWqaU/?=
 =?iso-8859-1?Q?X+DeYhUsJoS9GdcdLI3qDItwfBlI6lHYSo54VeF6ipMhjkkdor/fsajCdW?=
 =?iso-8859-1?Q?/RGN+yPs9jUsfcyRDE1xBYg8CFt4S0gqkglrY/FQF9inSrawgUfPYzkX1a?=
 =?iso-8859-1?Q?3UoeftVlQlchc/WFHtSsyYIxoz2ITfTXoof/QSt98QaxcxgpyV2hLSaikj?=
 =?iso-8859-1?Q?D8XRgk0xAqTjLj6z6r2t6WssnIORdyJ/qcbeOm/1LPxbs6MSYEoGcB2K6t?=
 =?iso-8859-1?Q?7khYRLaWzRnf4//tLJM+0vfomsfs3pXMQMM3qEjzbRIbbJvET766mkK5g+?=
 =?iso-8859-1?Q?EQlMTh743qbmAadeXaXSf85LIUw2z1bffxhlUeySL49NPHoWV2Pd9NGZwk?=
 =?iso-8859-1?Q?R4Bda6k2K8CfIDjjYKxrq3Lo7fYpuzAITu5e9sn9sZfghza9NPKCjhpXkH?=
 =?iso-8859-1?Q?WmYrt5jfmw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K5GuMqy7s4Jy1BatO4KxyflxLrt1Xijvouht7cOv0VOlmOOahTrogcbe5pK4vEMkiqyzcZrTH52NrdxD07Pxi9juw/6nJYQRyAjdoDUOl8ZIlI0Zs+kcNgd+iDee5LqBXIsP3nxsAUBuG/HZPf2ZYJAIbQ9Hnsl/dyM4s4mUVHCV24YPSfaNbbU0dqqQw3rRlZdbLDl3TjrFwVqDUmBtHReC2Qz7Hy3p0yJEcp++TgabidNX0Fh9kBvXTta0UdjYadtCznKNks3Qu4CdneA6IBLbuPovZgzeI+2x5A7PwkoOfyEf6KyQmhiJ7nUm3gzpoDABVcRPMxYY/0gsbLT2kw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f7c687-f58f-4e58-aa77-08deba48caaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 10:31:33.3642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bbareZqJ5Kdg8JNQ3BdtDlpvLMCKBRD1lkHp4MKWi1X/vjBTcuyB5C9MkRj3+VsFvOvvPeg0uBZo98HLKiovc547zgBkrf0kzbR9d7AmuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi,

>-----Original Message-----
>From: Qiang, Chenyi <chenyi.qiang@intel.com>
>Subject: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
>
>vfio_container_dma_map() uses dma_map_file() whenever a RAMBlock has an
>fd and the VFIO IOMMU backend supports file-based DMA mapping. That is
>not correct for private file-backed RAM.
>
>dma_map_file() resolves PFNs from the backing file, but private
>mappings can run on different PFNs than the file itself. As a result,
>using dma_map_file() on a private RAMBlock can program DMA against pages
>that do not back QEMU's actual guest memory.
>
>This was observed with hugetlbfs-backed guest memory and iommufd/VFIO:
>share=3Don works, while share=3Doff can fault because the file-backed PFNs
>can diverge from the PFNs backing QEMU's private mapping.

Good finding, did you see same issue with common file(not hugetlbfs file) b=
acked private mapping?

Thanks
Zhenzhong

>
>Fix this by using dma_map_file() only for shared RAMBlocks.
>
>Fixes: fb32965b6dd8 ("vfio/iommufd: use IOMMU_IOAS_MAP_FILE")
>Reported-by: Farrah Chen <farrah.chen@intel.com>
>Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220776
>Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>---
> hw/vfio/container.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>index 4c2816b574..c5a3c60a27 100644
>--- a/hw/vfio/container.c
>+++ b/hw/vfio/container.c
>@@ -82,7 +82,7 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
>     RAMBlock *rb =3D mr->ram_block;
>     int mfd =3D rb ? qemu_ram_get_fd(rb) : -1;
>
>-    if (mfd >=3D 0 && vioc->dma_map_file) {
>+    if (mfd >=3D 0 && vioc->dma_map_file && qemu_ram_is_shared(rb)) {
>         unsigned long start =3D vaddr - qemu_ram_get_host_addr(rb);
>         unsigned long offset =3D qemu_ram_get_fd_offset(rb);
>
>--
>2.43.5


