Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E66DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 04:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seoaw-0000Fr-PR; Fri, 16 Aug 2024 00:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1seoau-0000Db-KR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 00:29:44 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1seoas-0006fQ-KU
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 00:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723782582; x=1755318582;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s0DBLxqGbjxMXsJyPZykYimQ3pPA6pYcMdsWR8sXluY=;
 b=mbvuoWIAzFdRmvxd4O4oq42qQ0v1K7ab+JCc4aJiexzgiPrSaBGpF8Uy
 Vib8XcF4ItplOr6CXFIpw2n8N5+CErzu7NGkJqWudfemusfTvNXtmLYni
 FfT+mGpprSKZ1n9QkCBJodAhZJFu5kpShJKvkYEod98tswFD+3hvcsgda
 /Jy6mYLCu+osFNxcAx4M1wYtTbweqrhreEfWc8BaEt0G/2W1Dk+qm1vJK
 J2OVrJiatLmXPLkmyper1WjZk5FDRTewGnHR0k+v/MeQl1CjNc4Q5waaN
 xwCp+VrKDAmprJYtVTE/rmdcE5eSiOw3Yc3L1Auptm3LHGwC3k1xsR0b8 Q==;
X-IronPort-AV: E=Sophos;i="6.10,150,1719871200"; d="scan'208";a="18443721"
X-MGA-submission: =?us-ascii?q?MDElgWBxA8fPma19Vb/JYmYDjZ8RbP86A7X7HC?=
 =?us-ascii?q?g969kDpK0UZ8xyjz4JaLE27m9bUaSkam9AcZfEdG9x3yO4CXe5y45kUp?=
 =?us-ascii?q?nB0RoHXOEZ+uuCFwSD2FeO5R3QcQBagGOJC9y9NYpANIXBb351WhThtd?=
 =?us-ascii?q?m2ydI6qairOFXsOoaUhS5Y1w=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2024 06:29:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuarnTcDEjnqckSJwBLkElMwlmg98EJD+f1LvzKThBMPNzAbiBSsso66oExt1iURYp+ZJTdCrvXpd0/roWLyWXnca2/mg2K8DvCJuC4F6B0NAE63Lj4tf7kFHzt7Br4NW1BlvCV2Wp6dPGYnnTLLHavPFB5zU+Rsvf6ny+npTm8p+lY+QFmRhtjzpHn9xh1oh8lOEJf03wdnK+c/1rIYDtkE8gUabsorGa3ARCjYck24bHiQIFVgh96dRFBd6Do8EiB0OUzD/B1dMJ08thns8kRRd6S1yynrDWkH+/YW5SLDJc07rcvXPJ+z2HVLKCEHCsouoqi7MMLA1YX+3zYNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0DBLxqGbjxMXsJyPZykYimQ3pPA6pYcMdsWR8sXluY=;
 b=SIFgr0KbQKgvvOOD2LuoXslWkGH1+NT26u8lm/ZGiIdNtxNFL6GNbuRuUIsNn4cWUfnSRUUjJ+lu8yTrh8RuusGOm5gtgZNF9m1r4xtDXohG7yq9B0s68szO6fX7m/8DquW6kc5bB1QKHRJ1fPndOxIjPnK0eudhqGrsS/LkmJGj/CZToxt2lE4OcjVFLV7kbnJSP/FrxUQn14E/MZ1xx8AQZO2NJmEizD/LhL7gYHkAfVBE2VnLPW2KjfGX9Tr+mIMeWsduuL5vUv0TV3rlAPB+26OSPx+Zo+tgPu0wg6S+LXhD4K2DNzLVKrmyCwvSRfTrBfllZy/h7+Mk3Mns4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0DBLxqGbjxMXsJyPZykYimQ3pPA6pYcMdsWR8sXluY=;
 b=ph07mRPPq1B4bWeVBFnQgttjwvifoAUDR3rTKm794LQ1S+m4GizjbOFukmuAMa7VBgfeGMDsIYZ9Mtkf6B00Eo7OUxj3xKGU9RnLPo2SWWDD1BNZmnN9H31pCm4+kCxa5W0f9J7+6Ajmci9GfDFDgjagh7jT5R9NMb/lOwJLqOzyrCy8F3rxe0pYVlwNvhfC2MKNFm2Y8jqYozD3URuiJAWHjGsGvmucSOQVr2OfsArzlPV62nqGm5/Swkau1iyUCDiXmJvgQi+6wJ29jQy4c4pePNnO1H//8j3q/qyidkuQmAH4xZmEqMdwcLCetsUUCgcXiCxGHSSkNlKy2hDlaA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV2PR07MB9155.eurprd07.prod.outlook.com (2603:10a6:150:ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 04:29:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 04:29:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Thread-Topic: [PATCH v2 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Thread-Index: AQHa5wEDqHVcFd5qEEG5hVAqB55VbLImsP4AgAKLgQCAAB87AA==
Date: Fri, 16 Aug 2024 04:29:38 +0000
Message-ID: <b2eab25c-c8b7-4ff0-807b-211a65a8689e@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-9-zhenzhong.duan@intel.com>
 <516fa8d2-ac16-4f2f-b7de-e5ac6b6d8663@intel.com>
 <SJ0PR11MB6744BA14C86A1BEA1169FD1092812@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744BA14C86A1BEA1169FD1092812@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV2PR07MB9155:EE_
x-ms-office365-filtering-correlation-id: fb717b20-5133-408a-f29d-08dcbdac0a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VTZWb1dvUDNsQ0RsSHV3OTlCdXo0NHFlUjhyamJoUFhUYWJPN3JGbVUxWlR0?=
 =?utf-8?B?VFVScmZXMkJxT1RnNWxrb2kxV29zVVk4M0xSZHppSE1MNHFURkNrNTdocFBG?=
 =?utf-8?B?SVNEcklPdkNhNk4wcDlLTEhlak9yRzlteHc5a0lXRUdDT3BCSUEzdFNsemxL?=
 =?utf-8?B?ajk4T0Yzc3dOMlVrdHdQTlQ5MWFnMXhTeVhucGVFamxHVDljZjg1d0luempj?=
 =?utf-8?B?TjNpMm5zbWtjUERKZ0ZoV0liWEhCODJXK0FSK0s2NFNzUnRvUzR0UmtoZUNK?=
 =?utf-8?B?QWhFNjFLbFhpT2xDOW9zZDlpeStoZzA0KzNBZGtMZnVXRHVZV3pUTmU2ejFs?=
 =?utf-8?B?NGdvWTNEQ0s3NHpOZXpGakg3amV5bnI0T2djbTNCMmFqQUJDcll6bThOYTR0?=
 =?utf-8?B?RHhyTW50SnBUdTFCWklPYzNXd0FtakM2b0xNWDR1aE1Oakh2bkxIVzZLNG43?=
 =?utf-8?B?ckFzOUV5Zi9heVI2VW1ZQ05xUmVtUU5DZUR5QUp4TkVBWUlzTC9VM0ZkdXNz?=
 =?utf-8?B?S1NwVVMzSWNyNmtZb200R1VGRTJ3Y1FUS3YvMWNCZlEvMDhrK3NNbUp2ZWE4?=
 =?utf-8?B?c0FGZ0JEYndQRzQwc1lRM3dpbis3RHVJWjBqcm96ekpoV3Z1d3hLV2VLVDMr?=
 =?utf-8?B?UDIwN1dXNUFXMG45eW9qY042cU1MYkVLSVBBMUpNaGUzRVVIWjBWNnV1UFd3?=
 =?utf-8?B?ejNySC9Fem1ublY5N3NTUlJmR0VBdmhEampTSXhibDZMVUF5WFVLbXg0M2g0?=
 =?utf-8?B?d1EzZXlod3FVai94Nzh5bXZLOHUvUVlTcG50Q0c0TnRVQ3Jha1oxbjJhYXZH?=
 =?utf-8?B?OXVUWkY4bDFrSlM1OENtWkhlWVNOdEY0Mzd2RURuNlhLWEtSVVY1WGFDN0JQ?=
 =?utf-8?B?ZWRFcFRpbW5YZ1MwcVRVck1SKzB4eHFxMnhDT3UyNnl5eExCdituK1JER0pC?=
 =?utf-8?B?K1EwZ1BvQmZ6T0s1S0ptQkZtSTZ5MHJVL2ExYXA5VGlFMTQ4YkI1R3o2cWtX?=
 =?utf-8?B?UE1TeWYvNFJYTWE4aWZpZHN4bnhGdjkyM2JiMWNkdzZuUlVkSEJRNld2M1o1?=
 =?utf-8?B?NnVQS1BiVTlNVEdJazNCR0tzYU92UmFtWVArNkJwYk5BY3dOYVl0bkNsK015?=
 =?utf-8?B?ckMxak9LRGZxVzhXcEZFYVNiV2tBdHdCZEtsM2FqUG5WVWNseWhIVkZRc0Z4?=
 =?utf-8?B?dXVLRFpnMkN0cGhzQWF4NkdGNWNvZUxPYStkQ1V4d0hhdjd1aXhjSndqRDlE?=
 =?utf-8?B?RFpSTGNBdHVXc0xoWHhaVWhzZGNaSkFlbllYWlNMZGc3enZJaHYwZGNXMk1K?=
 =?utf-8?B?UjlpdGo5eGNlbG82RDJhK1M5ZytCNFZuVXJrVW44eUJZR3F3enRDN0kyMmhH?=
 =?utf-8?B?UkVjMWRjNDlPL3ZUazJ4U21jRTlEZkRGRVQyYURWY1NaNHNYSlNMSlc5S2RY?=
 =?utf-8?B?ZDlRZTkwR1Flei8zdHpWUFRGbVFJMXp6a3o1bk5jbnN3Y2UzTCtBNSt4cngv?=
 =?utf-8?B?emo3Ym0xb3owQnpWUkcxNCtIS1BPNWlXMXcveXd5MFFvS3V3TWRYeFFPQ2p5?=
 =?utf-8?B?eEFYV3VVSmJud2VRcldCTkx2TG10YlVtTWhIRENMeUQreThoWFI3bmhZS3hR?=
 =?utf-8?B?RGZ6K0cxUGY3TW84RzBNYjVTQk9aUnV5L0RaMVJJTmtXRFFBLzlINzBOek4r?=
 =?utf-8?B?OGsyQzNLSDVteHkxZURNeFVQRlMyS25HcWM1eTZvRVhRUTlHcE9mWmJZTi9t?=
 =?utf-8?B?bytDc2cxdldiYWFCUkJMeDM1ZENjOFc4WlNTRm9qWXhTTlJiSDc0cHFMMHgx?=
 =?utf-8?B?djkyY3NoNi9nQk1jQVE4cE5oODFPNzFBS0JmSzBVUFFISm9mdjBUcU01WHJD?=
 =?utf-8?B?emlhOGIrV05PRm9mZE9Ma3BYZDVNS2NNT3pZaHpYbURBL1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFLNS9OOEVudDNDanhIS0ZGdzdGbCtmQXUxRDdZZ3RCV1BIL2dvRFdPWjVG?=
 =?utf-8?B?aGdMZVJWTzRFaEdvRXNJWTJVTStzc3d5K05xWndVSHIrM0V4d2NDR3RKdElt?=
 =?utf-8?B?OUxid0Y4VUc4YkJZQmdxTGkzZC9CcmJpS3VmNVN5cTkrQm5XbzU3YXh6Y0xB?=
 =?utf-8?B?eXRvZ3FkY3BjTUlOK2pBSFFPWjN6R24zbmU4WlBYUWtDNjBMNjE5SmNWSEVK?=
 =?utf-8?B?clF5RXZld2s4QXpTdkdla09kNWoyNElkL0lKNTI4VWY5OG83N2dFaXFvaStu?=
 =?utf-8?B?TEx0WFM2KzBHMDBBY3ZmbDRNbi9qWVJjWTBhcWl4L05tVTE0eURoT0x1cGRw?=
 =?utf-8?B?aWlRa2s4dGNWZkhlaTIra09NRGlUaVhKRW5yNXlwT1JyK1E3NnVvU3JtNTUx?=
 =?utf-8?B?eFVrbFZHRFkwcWlTaDJKOXlMM3ZxMlVmc1NocE44dklpaGJPMXhCaG1xY2lH?=
 =?utf-8?B?QVBVTWVzN2dSNDdST2ZhNG5UcUxwK1B3Z1ViNGk5SGFia1FJRnFmZVFjRUMv?=
 =?utf-8?B?REdyT0RyLzBpVHV6OThiZ3pOOXVJM2RNNk1hZUR1ZTNrd2Y2QjhkTS95M3FO?=
 =?utf-8?B?TWpOQzBYdDdKMGIraUsvbjZTeUQ3K2prU2FrZnFibUtlNmEvOHNxbmxUUzdr?=
 =?utf-8?B?YUR0UVJhT2JJKzBFM0ZYeGh2N0o0WnJReTRvOUFiWjFoKy9JMXZjNS96SENL?=
 =?utf-8?B?ejhNZzBUNnltWDFPSkJ1ZzE1aXhHQVBVWjBEMjdKLzJNZEVCMlFOWCtDb0NJ?=
 =?utf-8?B?T0Z1THNqbUJJaVpLYkFOeVM1Qm5rRVhERTB5L3ZmTFdDOGdrL2hQNnRZMm5F?=
 =?utf-8?B?c0lGVmNPWXM0T1hOYmtmcWd3WXhIc0dNRUswbHVtaGhmTmNJMWFWMzdLdlQz?=
 =?utf-8?B?UGwwaE56VE41THZWYlNQSHNmbFNSYis1L0JmVGhvM0t0cG1IKzFyQUFhbHZU?=
 =?utf-8?B?UDhQVHpnS21RSGxjd3dDZFB4UkcvcTBhSVdRSUhhVUREQTM0WjNWUVJmdzBo?=
 =?utf-8?B?eFRiS1BNblY1YndXY0xzbHVjYUxzdmIzemI0ZkpYTDE5cmJnRE9OeUN0dWZ6?=
 =?utf-8?B?bGwrNkdUeGd2SWFydG1kYVRFYnlQYnNqQUFsakVuMlo0aDF6aGQxbUhaZFMx?=
 =?utf-8?B?OEMySUpLVHl0MkMyUStxNVd6NmFjSE1MZUVxaEE3K3lvbWlRam1NVnBidUZJ?=
 =?utf-8?B?ZDk5bUxpK0NmanFubk1aVmxLMGpOMm5Lb1hJZFlxdldJeVdTM3ZXaGR0Mnkr?=
 =?utf-8?B?dlJtNVhXWW4vN2xUbkxEc3Q0S1d2R2djMGNOblRKQk9tMTdjZTZKZDVyeTJG?=
 =?utf-8?B?RkQ2RWcxWlpCVWhzZWhReGhBSzFmTTZ1enJJQndBR0E3eHZQSUZlUlRkTG1W?=
 =?utf-8?B?RUdpSkRqdWk2K2tpallFQlJLUDlZT2NnTHR4czVwbVRBa3dTM2NQbnZKdUlB?=
 =?utf-8?B?OGgyRHF4Unc2QTdlUU1XS29sZFh3VHNjNGJ2K3gvN3pRbnl2bGVyN2RiUU1n?=
 =?utf-8?B?L2ZGbjgwTndLYWdCYU5HRjNEazY5dkhUOUxlbzAyM2RVNXBTbVdPRFNFcGJN?=
 =?utf-8?B?NmtEUWtGTUxEQUYvR3d1a3ZocGczV202eVgxV2dHdXk4M1FUZ2NZUkZMZDc2?=
 =?utf-8?B?em9QMGp6VVphdEpFMWlibGNKVldzVGpRamxGUlBpVTY5WE1tQ1hzNWRDSjJT?=
 =?utf-8?B?cEg5ZEp6VmdtNG1uczR1clJqNjZhZ293bllKbmVDMXlIbjRPa3JWTHRmMmpu?=
 =?utf-8?B?akJBajcxTmJOZXdrR3pLS2RvR3VzWW9JbnZIVDlGZWUxMjB2MDBnNDROVEQ1?=
 =?utf-8?B?d2JNZ3JFYWozdGtPeEJrS3RCRC9lSURsQkRNZUY5czUrbXNCbmxHUW5LbldM?=
 =?utf-8?B?Q1E4SnJlMUJ4QnJhUG5wTit4NlFJaUx0VkZ0ZnBvNzlMQVVEOE1KeTc4Ykpq?=
 =?utf-8?B?RlIvTnJNS1p1TTZiVENUTmw5YzYxUGhpRzBmRnNPTGdqeDBudmZXcWNjaUZa?=
 =?utf-8?B?RHhhdENGYkQ0NmJsaFl2T0d0MDFLTkhSVjV5L0tTQ1pRajJ0ejIyMXFBaGdy?=
 =?utf-8?B?eUNlZmkwZDZBSWMzVkszU1VZVm0yUEJmTGU1TVNvV2FPbkZqUWF4Y1g4c2F2?=
 =?utf-8?B?K2lvb1J4OEg1bFdNRlpuVnUrWi9lNHlHRk9TSDRsL1Uwd2E4SmxMSlQyWkQ0?=
 =?utf-8?Q?f+xhPD6JXgjJVcT4YctyZpc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <889DDDEBED2C204CBA3B5D2BCB6B3B84@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb717b20-5133-408a-f29d-08dcbdac0a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:29:38.0387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Y6+FBgriwfg0BpoN6IiKTx5c/Srupw6MIIMcKPRVeD33qyyPI4p+B17nsYTq6QIGLPs+h37I5Dwkm9HNvY8Czot9zLJlfZqz3TsjWKizbCUStc1SLe/wmBxizI9sZ33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9155
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE2LzA4LzIwMjQgMDQ6MzcsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAwOC8xN10gaW50ZWxfaW9tbXU6IFNldCBhY2Nlc3NlZCBhbmQgZGlydHkg
Yml0cw0KPj4gZHVyaW5nIGZpcnN0IHN0YWdlIHRyYW5zbGF0aW9uDQo+Pg0KPj4gT24gMjAyNC84
LzUgMTQ6MjcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+IEZyb206IENsw6ltZW50IE1hdGhp
ZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggfCAgMyArKysNCj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAg
fCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDI3
IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj4+IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gaW5k
ZXggNjY4NTgzYWVjYS4uNzc4NmVmNzYyNCAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCj4+PiBAQCAtMzI0LDYgKzMyNCw3IEBAIHR5cGVkZWYgZW51bSBWVERGYXVsdFJlYXNvbiB7
DQo+Pj4NCj4+PiAgICAgICAgLyogT3V0cHV0IGFkZHJlc3MgaW4gdGhlIGludGVycnVwdCBhZGRy
ZXNzIHJhbmdlIGZvciBzY2FsYWJsZSBtb2RlICovDQo+Pj4gICAgICAgIFZURF9GUl9TTV9JTlRF
UlJVUFRfQUREUiA9IDB4ODcsDQo+Pj4gKyAgICBWVERfRlJfRlNfQklUX1VQREFURV9GQUlMRUQg
PSAweDkxLCAvKiBTRlMuMTAgKi8NCj4+PiAgICAgICAgVlREX0ZSX01BWCwgICAgICAgICAgICAg
ICAgIC8qIEd1YXJkICovDQo+Pj4gICAgfSBWVERGYXVsdFJlYXNvbjsNCj4+Pg0KPj4+IEBAIC01
NDksNiArNTUwLDggQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUm9vdEVudHJ5IFZURFJvb3RFbnRyeTsN
Cj4+PiAgICAvKiBNYXNrcyBmb3IgRmlyc3QgTGV2ZWwgUGFnaW5nIEVudHJ5ICovDQo+Pj4gICAg
I2RlZmluZSBWVERfRkxfUCAgICAgICAgICAgICAgICAgICAgMVVMTA0KPj4+ICAgICNkZWZpbmUg
VlREX0ZMX1JXX01BU0sgICAgICAgICAgICAgICgxVUxMIDw8IDEpDQo+Pj4gKyNkZWZpbmUgVlRE
X0ZMX0EgICAgICAgICAgICAgICAgICAgIDB4MjANCj4+PiArI2RlZmluZSBWVERfRkxfRCAgICAg
ICAgICAgICAgICAgICAgMHg0MA0KPj4+DQo+Pj4gICAgLyogU2Vjb25kIExldmVsIFBhZ2UgVHJh
bnNsYXRpb24gUG9pbnRlciovDQo+Pj4gICAgI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfU0xQ
VFBUUiAgICAgKH4weGZmZlVMTCkNCj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gaW5kZXggNjEyMWNjYTRjZC4uM2MyY2Vl
ZDI4NCAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiArKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBAQCAtMTgyMiw2ICsxODIyLDcgQEAgc3RhdGljIGNv
bnN0IGJvb2wgdnRkX3F1YWxpZmllZF9mYXVsdHNbXSA9IHsNCj4+PiAgICAgICAgW1ZURF9GUl9Q
QVNJRF9UQUJMRV9FTlRSWV9JTlZdID0gdHJ1ZSwNCj4+PiAgICAgICAgW1ZURF9GUl9TTV9JTlRF
UlJVUFRfQUREUl0gPSB0cnVlLA0KPj4+ICAgICAgICBbVlREX0ZSX0ZTX05PTl9DQU5PTklDQUxd
ID0gdHJ1ZSwNCj4+PiArICAgIFtWVERfRlJfRlNfQklUX1VQREFURV9GQUlMRURdID0gdHJ1ZSwN
Cj4+PiAgICAgICAgW1ZURF9GUl9NQVhdID0gZmFsc2UsDQo+Pj4gICAgfTsNCj4+Pg0KPj4+IEBA
IC0xOTM5LDYgKzE5NDAsMjAgQEAgc3RhdGljIGJvb2wNCj4+IHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nh
bm9uaWNhbChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQ2NF90IGlvdmEsDQo+Pj4gICAgICAgICAg
ICAgICAgKTsNCj4+PiAgICB9DQo+Pj4NCj4+PiArc3RhdGljIE1lbVR4UmVzdWx0IHZ0ZF9zZXRf
ZmxhZ19pbl9wdGUoZG1hX2FkZHJfdCBiYXNlX2FkZHIsDQo+PiB1aW50MzJfdCBpbmRleCwNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgcHRlLCB1
aW50NjRfdCBmbGFnKQ0KPj4+ICt7DQo+Pj4gKyAgICBpZiAocHRlICYgZmxhZykgew0KPj4+ICsg
ICAgICAgIHJldHVybiBNRU1UWF9PSzsNCj4+PiArICAgIH0NCj4+PiArICAgIHB0ZSB8PSBmbGFn
Ow0KPj4+ICsgICAgcHRlID0gY3B1X3RvX2xlNjQocHRlKTsNCj4+PiArICAgIHJldHVybiBkbWFf
bWVtb3J5X3dyaXRlKCZhZGRyZXNzX3NwYWNlX21lbW9yeSwNCj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJhc2VfYWRkciArIGluZGV4ICogc2l6ZW9mKHB0ZSksDQo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmcHRlLCBzaXplb2YocHRlKSwNCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpOw0KPj4gQ2FuIHdlIGVu
c3VyZSB0aGlzIHdyaXRlIGlzIGF0b21pYz8gQS9EIGJpdCBzZXR0aW5nIHNob3VsZCBiZSBhdG9t
aWMgZnJvbQ0KPj4gZ3Vlc3QgcC5vLnYuDQo+IFllcywgd2hhdCBhYm91dCBiZWxvdzoNCj4NCj4g
QEAgLTIwOTYsNyArMjA5Niw3IEBAIHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9fZmxwdGUoSW50ZWxJ
T01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPiAgICAgICBkbWFfYWRkcl90IGFk
ZHIgPSB2dGRfZ2V0X2lvdmFfcGd0YmxfYmFzZShzLCBjZSwgcGFzaWQpOw0KPiAgICAgICB1aW50
MzJfdCBsZXZlbCA9IHZ0ZF9nZXRfaW92YV9sZXZlbChzLCBjZSwgcGFzaWQpOw0KPiAgICAgICB1
aW50MzJfdCBvZmZzZXQ7DQo+IC0gICAgdWludDY0X3QgZmxwdGU7DQo+ICsgICAgdWludDY0X3Qg
ZmxwdGUsIGZsYWdfYWQgPSBWVERfRkxfQTsNCj4NCj4gICAgICAgaWYgKCF2dGRfaW92YV9mbF9j
aGVja19jYW5vbmljYWwocywgaW92YSwgY2UsIHBhc2lkKSkgew0KPiAgICAgICAgICAgZXJyb3Jf
cmVwb3J0X29uY2UoIiVzOiBkZXRlY3RlZCBub24gY2Fub25pY2FsIElPVkEgKGlvdmE9MHglIiBQ
Ukl4NjQgIiwiDQo+IEBAIC0yMTM0LDE2ICsyMTM0LDE1IEBAIHN0YXRpYyBpbnQgdnRkX2lvdmFf
dG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPiAgICAg
ICAgICAgICAgIHJldHVybiAtVlREX0ZSX1BBR0lOR19FTlRSWV9SU1ZEOw0KPiAgICAgICAgICAg
fQ0KPg0KPiAtICAgICAgICBpZiAodnRkX3NldF9mbGFnX2luX3B0ZShhZGRyLCBvZmZzZXQsIGZs
cHRlLCBWVERfRkxfQSkgIT0gTUVNVFhfT0spIHsNCj4gKyAgICAgICAgaWYgKHZ0ZF9pc19sYXN0
X3B0ZShmbHB0ZSwgbGV2ZWwpICYmIGlzX3dyaXRlKSB7DQo+ICsgICAgICAgICAgICBmbGFnX2Fk
IHw9IFZURF9GTF9EOw0KPiArICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgaWYgKHZ0ZF9zZXRf
ZmxhZ19pbl9wdGUoYWRkciwgb2Zmc2V0LCBmbHB0ZSwgZmxhZ19hZCkgIT0gTUVNVFhfT0spIHsN
Cj4gICAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsNCj4g
ICAgICAgICAgIH0NCj4NCj4gICAgICAgICAgIGlmICh2dGRfaXNfbGFzdF9wdGUoZmxwdGUsIGxl
dmVsKSkgew0KPiAtICAgICAgICAgICAgaWYgKGlzX3dyaXRlICYmDQo+IC0gICAgICAgICAgICAg
ICAgKHZ0ZF9zZXRfZmxhZ19pbl9wdGUoYWRkciwgb2Zmc2V0LCBmbHB0ZSwgVlREX0ZMX0QpICE9
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE1FTVRYX09LKSkgew0KPiAtICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsNCj4gLSAgICAgICAgICAgIH0NCj4gICAg
ICAgICAgICAgICAqZmxwdGVwID0gZmxwdGU7DQo+ICAgICAgICAgICAgICAgKmZscHRlX2xldmVs
ID0gbGV2ZWw7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQpsZ3RtDQoNClRoYW5rcw0KID5j
bWQNCj4NCj4gVGhhbmtzDQo+IFpoZW56aG9uZw0KPg0K

