Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FFCEE0211
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soHHA-0000at-KM; Wed, 11 Sep 2024 02:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1soHGz-0008LP-3D
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:56:18 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1soHGw-0005SY-IB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1726037775; x=1757573775;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XvW4xrpwzve6ctzfxz6oGVt8ex2lVU536wHg/oH66pE=;
 b=aCKlI/pTQf9soF5Nn+mzidagcEDZBbb10Zdnk6C1P9cEagEazwsKmtPV
 3Q5MvMreMfPWVBauutZT7dZ8jh0b0Zi3ABQOZAgQmpdXZEJAukib3Ki2i
 mDWDbbOMpbt/pYFoCL7cMpWy78m2PxRKrPE+QrE///zGlsyU9WEatzhfP
 qb4Wc2au2zW3/2gkGz3Kv0e/6u96WW7zX1EEEoyFRLV9j7p2hPbRwPufa
 K1ISxw6CqFcMwszfmlqJMMK8feXLS+c69q1QmtWk7kYrzPeZ9ZHvLD6dk
 L7kScENSKLKpLCmDVovZE2AB41Q8BdLv2FEWM4aUuSPDm23nJn0B/+/sq A==;
X-IronPort-AV: E=Sophos;i="6.10,219,1719871200"; d="scan'208";a="20053104"
X-MGA-submission: =?us-ascii?q?MDGMX2M6QgvDjTvbGRNEPpXNqniBcWFE3SxIOn?=
 =?us-ascii?q?It0vFuoO0ZfMjGPtSwdYw5aV7Fr2OmCf0K+YBZz04LcIY8ECTd+OcxRQ?=
 =?us-ascii?q?Ty0NnBUn8VAy5TpLziiFvQzkiUhEHz+v0lXLf2TRtOCX4XBSKOy7cyaS?=
 =?us-ascii?q?EpyIGO0lZspmzk9HfUg50Wzg=3D=3D?=
Received: from mail-vi1eur05lp2168.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.168])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2024 08:56:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmgNAM3gr3cdPftc2yR2fpaNsgiymd+1vkhfTJXPfnoOv9UsOFOfe6Bjl4D1CCYeh9n6k49kR52Ng+WirIAL1DiO+N0TcYjdP8zCO3poM55RyMVKWRUsvpidRVMD5KqrJ8GZHCCcMhKn26rrlEzySgOoHR+Ew/cANd7XYEhtcugQUf6vx3PdEYqwvSobhEBeVCi8KuGp9Q7r2v0keQNYqDjM4XT2mHAWtfTtksbPe8CTddN1CoEexG7ry/JdQBlR7qXtZnoWBmeZ0iYTR7fBtrHAPEHuFxhf5wX7TKv+cFJ4nhGeK4Ge2ier7UVyr7bcxumWh4w2y0uXLmi5CAD/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvW4xrpwzve6ctzfxz6oGVt8ex2lVU536wHg/oH66pE=;
 b=kwfqMyePrZRZqXenmf13SVtIsDooC7Txvh/zPKz7xYF4ByThnUwc6vEP0EH+QVVCD8PlMvWdfENgsIXFzKNeyz7WIn6VRsp6ypH+E+JK2CeYtwkA5v8Q1whTCpR/oHypZZyq08eB98QEOm1rymQIYjhU9qhEVTrHRWK9GxQX6mnxV0giazq13x5xioMEdCNhoOq6wIPdZq8Vhx6aFzUNGUax8UB+TjqHoI+dKCoYdqeftvukLt7lNgM4kDcHyWEdXn+qphhgH2qWhLlBszz+nLbl3PUXMmlIg2FiJJrXsL1V/Mpd2a26Qmljb3IUeoIe7R4w/TzeCO8yAyJoen9OOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvW4xrpwzve6ctzfxz6oGVt8ex2lVU536wHg/oH66pE=;
 b=dq565b8ClvNDsj5aliIqIOg4V9Lg6oIwku3I5i8II8sm+e2DXsj/TJXttCNErxi7G1uQbJ4V5TexC2hPG+B0xfHFi1BhKz/EOnjMhbBqKrzz5jMHUWB78KNt0u7hCo1thkna7xjEXXKiUnDQj9eW5azc45UyUgzX/35jzeTwHGGgnsAoP2Etu/UuOcQGJM33B6Jaex4M1E+dXwBV4tJ+BLImJRtNweUIPz0lDON5shybI50zFQtIVVVmuke6CHUMdebdMyfFwHX9ptiBaikr6hBqRiC2MB+Q/ZTxwIThfzN9pE/349HZf2M80IJZ8pzGuzcRrWA2A36rMjE+6pM3FQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8373.eurprd07.prod.outlook.com (2603:10a6:20b:444::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 06:56:07 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:56:07 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH v3 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHbBAsVCsLQ6hnwuU+0YYI8UliRrrJSJygA
Date: Wed, 11 Sep 2024 06:56:06 +0000
Message-ID: <c84acb53-bd3b-4f3a-8c0b-7d4cae1fa8a8@eviden.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8373:EE_
x-ms-office365-filtering-correlation-id: 501b09ac-d362-4d61-7068-08dcd22ecf6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZGhHcitGemNhUmtMSlVTam5TWm1CT29SM3NnM2oxVFk2MlRNbDFqOC9SYjY3?=
 =?utf-8?B?T2tROEtpL0JHbHI5Wk9qNDRqamtGNkhxU2xidzI3MFVQKyttUjdBL0N5YWFt?=
 =?utf-8?B?aUJCbkVIQUdzWHR0ZG5kTHlNaG9TZXhLaFNZR2Z0aGJEeGZjV0NCZ0ZNUWpy?=
 =?utf-8?B?WmdyeGplT29WeklGb1ZITzJabkd2R3VMVXk3YVBwc0YvT1NDS1h6VTVNUnVW?=
 =?utf-8?B?VG9hSTVNMDZDT3JubVZrM1hXeUlCb2dKdXpwQmFtMnVlWE9rUjdQT3pEbG02?=
 =?utf-8?B?bHRJM296U0lPeTlGMFg4NVZ6VzdVUDlaSGhremVGTFE3bXRzeWJtaE9LRnkv?=
 =?utf-8?B?UHFjZlBmckNZcmtqbGoxT0p3VHRza2ZrMjJyYXJLTnI4V0ZaT0lCc1J0ck1D?=
 =?utf-8?B?b0FmaElMcGVPcVlWTXpKcy8vL2UzT25XeEg5ZUcrRUhwamVFdnBETVVSVTh1?=
 =?utf-8?B?V0FGbWZpV2ZPZU5ycW4zNDYwTmRPR3NwcXhreWlSOTBicHFnOVhyRTJxbHo3?=
 =?utf-8?B?OHFZNGVXUzBCSXNGVnRlRS9KbC9LcnhHRExGaHpaNCthdXpHTmg4NnNVenVY?=
 =?utf-8?B?dXNaZFo1QkxJa0RWa3lVVk1uRzJYei9HU2gzRTBvMFhIVy94RnZQNjRaZFlS?=
 =?utf-8?B?OFdqb0lIVHJ6cGNUMVJFYitNaTliUUhSc3lZUWQ5RC9OYmIzZHZjNTlaSjdR?=
 =?utf-8?B?cHFFRzZEMlV5cnk3dk9jU295UFhuY2NBdmx4TEQ2TURrRU9YVzBDbUNkUDJS?=
 =?utf-8?B?K2FIL3dTWXVpMmhmTlpqUHo0eVBiT29aZm5kRXJ6Tm5CQ0ZiZlNzcEYwc2p5?=
 =?utf-8?B?SlhUUHlRS0lqSndLVSt4SmlkaVFTM3d4YjJ5Ris5VXUvbXcvY1FPK0MxYXFP?=
 =?utf-8?B?NXNjR0VHMVhGZzkrMUVhNzA2RVVvZnRUT1NYeHFBendsNUptYmEzcXEzb3lX?=
 =?utf-8?B?OW43dWx1YWUwNTJSNW9oTC9qR0JwQVViOUkyVmNxMnVOakxDVE1XQlBIOGZi?=
 =?utf-8?B?YS95ckVjcHo1T0R0ZDZJMkpHNGEwN0k0MFRTMDRpNHdEMFhUbmFwc1BVVlcr?=
 =?utf-8?B?eEJwZEtpOFJQYTk4dmpMcEptY1VhdkRMeDJYcHR5K21EdTVpSXRjN2pSWElI?=
 =?utf-8?B?dlJLSnlrNUtSZy80RTNPUlc0RmRzN0dIYXF3cEdVR2M5Q3dQckx1TFo0cEMr?=
 =?utf-8?B?OXZOVE1KaGNBc2hBOFNWYWlhdHVaRHZYRkU5eHhiS05qRDlqNkpxS2twVkJ3?=
 =?utf-8?B?OGk2ZVFxNWVpREYrM3FTWFNJUkRyWHZUa052RU5rcGlHVmNjZ1NHMWNHdjIz?=
 =?utf-8?B?a25PdWUyNU1MejgrbTdkYlFwZmhBMTZabDBuVTFRcnhSUzV4cTY3OUZqcmJN?=
 =?utf-8?B?SzA0V2VGRWpXRWR4VVdCaThidCs2MU9JYnUvcUN4emZDNkVtQm0rNHV3T3Bm?=
 =?utf-8?B?WWZTT0ZSV2NZMGNlNHBNWTJuK2ttUUNKbnVRdDA3anJIVmJrL1lzS3cxZEZq?=
 =?utf-8?B?K25DSENTVk9xbXhQSjR6UDV3Y0pUN1gzSnpPNmlCTnY3QkQ1aW1TVzJmdUNM?=
 =?utf-8?B?dDZmTnFpakJ2TEtzM2hndVBpdWdjcmpRR01nbmUybVZ6S0srN3NRcGprb0dW?=
 =?utf-8?B?cFVpVXVYTDJseTNIWElqT010YkZqdkJQQUMybmhBMzUwa29wVVZjdEVxaGFO?=
 =?utf-8?B?V0FCa1Npd1Q3NVB5WnhnMEtBOGE0REhDSGpoQTFmYi95THBFbmRkdGsrelJU?=
 =?utf-8?B?UUxDbE12WEc2WUNOZU9pZ0JBaGRNMlNZTS9STWdCSzk4RlRNYzhQWDFDeGpq?=
 =?utf-8?B?bVJ2Y2Z4dXcvYktqbU9RalFPOG9rRVNNZkltTWd3YWxVRS9SdTJlanpMWG0r?=
 =?utf-8?B?OXVCT2dHYWZTMWR4ZkZuRGVpdnNidlBxMDYvL0QwUVNLWFFaWDRQRHY2dmxx?=
 =?utf-8?Q?bZg6o/XOSoc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWZZL0ZFcExObklkdEQwTzAzdlp1eG03RDJ1bmZLM0pGVVcydUtLN1NSZWVI?=
 =?utf-8?B?b0t6RUtMY0dPak5UTUw4VnpSNXBzUXpOZ1BXOWFnR2x4a0k0eTZESXBMdkdK?=
 =?utf-8?B?WGRsUFJ1UitBcVFJYUJ3Z2pwMVRqNXNKWXNXTkJSVCsyOGdYZ1c5bW9LWWhi?=
 =?utf-8?B?eEJmZUpRbUMxTGthdkJvVEh5ZHlHNTdSekxYM09ONmREa1dncGs5VFZoU2JD?=
 =?utf-8?B?c1FBbnBWemtSQ2U4Y1FMWDFTMDRsb2FicVdzUDFYUWVIUW1SaXl0UlhseWFu?=
 =?utf-8?B?aGZkbVY5WGgzbWcyWWlsclFkcUtTZHFoTWtvYlVxNm5oTlR3TzZ2RURkWVdn?=
 =?utf-8?B?cWw2T2pJUjd3azFXWVMzMzQ4eVhkNVZRU1VoaHc5MEdjUWk4RW4wOFdHVWl4?=
 =?utf-8?B?UmpiV3BFNWRSaWpza01CMmZ0RTZCY2Z4dG5JTGM4UEI2bklMQnYwNW91aVV5?=
 =?utf-8?B?aCthK2tIWDZ0WWRua0dOaHhjeStiRGhPRUlOV2VGR3YwdkloeXRvc0FlV3Fu?=
 =?utf-8?B?TllCMlpWWmEyeUJOeEdjODJJYlk2MnE2N3M2dGZZMW5mTVVIay9aTnFJSlZR?=
 =?utf-8?B?SVpLYnU4MCtlT0hqcDd3QVQ5NThVcCtoTnNwOW9URGR5NmxMNGxlN1lRMW9Y?=
 =?utf-8?B?Wm0yckV1Qm56aytTYzNNSzZkaWYzNU9wYm5VVmJOMmZwd0YwcEFGQ3hvNVp2?=
 =?utf-8?B?M3JmZ09DTUNzZHl5MEF6MDdOWFdLM1RCb2gyeHVHSEoyS1d3SHA1N0dsck9w?=
 =?utf-8?B?UGhZazlMR3o4VDQwYmxDQWxZdDV2V2c2ZjdxekRhZkJiWVN6V1BxdjdDRGtl?=
 =?utf-8?B?NFVlYktjTGk2Q2h6YVFETXhvQlVqTzJ1b1Y0L1ZOTjcwS2Nmd2pDN2xoaTky?=
 =?utf-8?B?NXZGRHpiQWVHMEdVSVp6N292QVlzTW5udGd6UDVJcERrWE1DODBZaHhWMnJQ?=
 =?utf-8?B?MExCZC9iRkpBZEZqbER5cnZUTmNyZ0d0ZzZoTTlCN2l4Uml4TGlhRUJhL2J4?=
 =?utf-8?B?cFFVNE1uSjNPRTV6YlhxSzRneHlPSU5KT1p0cWd3Z3JkeVZpSUhBMCs3eU82?=
 =?utf-8?B?VFFRbDlwSjREUFZwbHdCK3NmQVk0L1ZtU2w2S3FMNHZyem1tSkNIanh0WGJq?=
 =?utf-8?B?ZzRaWVhmTmNmQ1JuQ21hZEYyaGkzWmM0MjlNblN1cFVBM3hJbDFHQVErK0c0?=
 =?utf-8?B?a1JJMnZQMlJsYjB6MEUxcmluUUV4bVIwL1RteEgza1FRUEFyR3ZDNWJqdWl4?=
 =?utf-8?B?elRjRitBeWhvYVg1ajVSMlJhSVcyVW9CK05iT1JaRUpvbE9uZzZVWTBTa2hH?=
 =?utf-8?B?SjRoN0ZQaVVSMFlBUlpSbDNGMDRsYUZyS0xRMUlsN01xQkwzN3B1Z3dZZTNW?=
 =?utf-8?B?SmU2a3RocTd1TERqNU1wSDduaWxsdG5XKzJSQVdrR3RCQXpMV0UxVVRyMkRS?=
 =?utf-8?B?cWNNRVNkWkU1VmtLU1pia0wyLzY5bjIxKzBIYXQvR1JSdXJmNGEwQS9TOWRq?=
 =?utf-8?B?NjJ0QS8vd2g0RTBDVXl1Qi9Ya3hHV0hBOEd5NG9ubXh2bGkwNUNNcnI1dWth?=
 =?utf-8?B?TDBtYmJIZ1hrZjFuZ2xjcHBMSTJLUUVWbEdaNlpaTE9ObXdXZTlHVTBVditH?=
 =?utf-8?B?S0l3S1ZLa3hXMjFRL2FHQktpUXBWUXh1ejBUZGFQOVdpbWJwcTY2cko1NFVq?=
 =?utf-8?B?Q1dCUUFZRVlUdzYvVGtUeXJZeDFsTEdWeWpDTWVtSXI2dUlwSmdPVzJEV0Nl?=
 =?utf-8?B?cmdvdmhXYXQzSVVHVm5FaEdjeWNzUHRRMnNkQXB3QmtBVzNRV0ZRczBBMFNm?=
 =?utf-8?B?dmhDU1JZQlg0NkFQZFBBVTRzSTFVSFNGV3kxVHpuVDl1VjBhbDZrbk9QNEo0?=
 =?utf-8?B?dlVYWkV2UXpRNDcrM2JnYmoxY2psUWh4bHYzR0NVMkExNU85NHV6dGFxaEwx?=
 =?utf-8?B?cG9VRWxIOEFlR29XeStGUEdaZmJXamg2MExJTFdVclJtVUNTZkRSYVltQW9o?=
 =?utf-8?B?UHptRUtaLzJqek4yK0hKTHd0YlFPdlR1ZUlNTm5keUxHbEV4VzMwRWV5eWs3?=
 =?utf-8?B?UlhLNVBzOEdhSUNrSHRDdndBa3RrNmFtRVI5WWwyeXNad21nYjVkNUdZTlJX?=
 =?utf-8?B?MmNnR0xyNkw2ZlpNUVdxOS92Y1diZ2g4YlYvMW9rTmdvQWl1Uy9ZS09pbFB1?=
 =?utf-8?Q?WRTBvqkyejwOAq5QhciRB4A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72A529FDF622D141BCB7FA969EE45590@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501b09ac-d362-4d61-7068-08dcd22ecf6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:56:06.9930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GlHmBCW4hw5EasXOBcnE2z4Bfuc4TqpnX8TXVZFSXZcsGIVqF7U2RF/WEtwx43njxRyY565T426yw8HdVSgfkn6dH8tHW50vc6eOru8bGRRB8MLvNM3AxckwwItfsrR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8373
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgWmhlbnpob25nLA0KDQpUaGFua3MgZm9yIHBvc3RpbmcgYSBuZXcgdmVyc2lvbi4NCkkgdGhp
bmsgaXQgc3RhcnRpbmcgdG8gbG9vayBnb29kLg0KSnVzdCBhIGZldyBjb21tZW50cy4NCg0KID5j
bWQNCg0KT24gMTEvMDkvMjAyNCAwNzoyMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+IENhdXRp
b246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5r
cywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gSGksDQo+DQo+IFBlciBKYXNvbiBXYW5n
J3Mgc3VnZ2VzdGlvbiwgaW9tbXVmZCBuZXN0aW5nIHNlcmllc1sxXSBpcyBzcGxpdCBpbnRvDQo+
ICJFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgZW11bGF0ZWQgZGV2aWNlIiBzZXJpZXMg
YW5kDQo+ICJFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgcGFzc3Rocm91Z2ggZGV2aWNl
IiBzZXJpZXMuDQo+DQo+IFRoaXMgc2VyaWVzIGVuYWJsZXMgc3RhZ2UtMSB0cmFuc2xhdGlvbiBz
dXBwb3J0IGZvciBlbXVsYXRlZCBkZXZpY2UNCj4gaW4gaW50ZWwgaW9tbXUgd2hpY2ggd2UgY2Fs
bGVkICJtb2Rlcm4iIG1vZGUuDQo+DQo+IFBBVENIMS01OiAgU29tZSBwcmVwYXJpbmcgd29yayBi
ZWZvcmUgc3VwcG9ydCBzdGFnZS0xIHRyYW5zbGF0aW9uDQo+IFBBVENINi04OiAgSW1wbGVtZW50
IHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIGVtdWxhdGVkIGRldmljZQ0KPiBQQVRDSDktMTM6IEVt
dWxhdGUgaW90bGIgaW52YWxpZGF0aW9uIG9mIHN0YWdlLTEgbWFwcGluZw0KPiBQQVRDSDE0OiAg
IFNldCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUgbW9kcmVuIG1vZGUNCj4gUEFU
Q0gxNS0xNjpFeHBvc2Ugc2NhbGFibGUgIm1vZGVybiIgbW9kZSBhbmQgIngtY2FwLWZzMWdwIiB0
byBjbWRsaW5lDQo+IFBBVENIMTc6ICAgQWRkIHF0ZXN0DQo+DQo+IE5vdGUgaW4gc3BlYyByZXZp
c2lvbiAzLjQsIGl0IHJlbmFtZXMgIkZpcnN0LWxldmVsIiB0byAiRmlyc3Qtc3RhZ2UiLA0KPiAi
U2Vjb25kLWxldmVsIiB0byAiU2Vjb25kLXN0YWdlIi4gQnV0IHRoZSBzY2FsYWJsZSBtb2RlIHdh
cyBhZGRlZA0KPiBiZWZvcmUgdGhhdCBjaGFuZ2UuIFNvIHdlIGtlZXAgb2xkIGZhdm9yIHVzaW5n
IEZpcnN0LWxldmVsL2ZsL1NlY29uZC1sZXZlbC9zbA0KPiBpbiBjb2RlIGJ1dCBjaGFuZ2UgdG8g
dXNlIHN0YWdlLTEvc3RhZ2UtMiBpbiBjb21taXQgbG9nLg0KPiBCdXQga2VlcCBpbiBtaW5kIEZp
cnN0LWxldmVsL2ZsL3N0YWdlLTEgYWxsIGhhdmUgc2FtZSBtZWFuaW5nLA0KPiBzYW1lIGZvciBT
ZWNvbmQtbGV2ZWwvc2wvc3RhZ2UtMi4NCj4NCj4gUWVtdSBjb2RlIGNhbiBiZSBmb3VuZCBhdCBb
Ml0NCj4gVGhlIHdob2xlIG5lc3Rpbmcgc2VyaWVzIGNhbiBiZSBmb3VuZCBhdCBbM10NCj4NCj4g
WzFdIGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI0LTAx
L21zZzAyNzQwLmh0bWwNCj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS90
cmVlL3poZW56aG9uZy9pb21tdWZkX3N0YWdlMV9lbXVfdjMNCj4gWzNdIGh0dHBzOi8vZ2l0aHVi
LmNvbS95aWxpdTE3NjUvcWVtdS90cmVlL3poZW56aG9uZy9pb21tdWZkX25lc3RpbmdfcmZjdjIN
Cj4NCj4gVGhhbmtzDQo+IFpoZW56aG9uZw0KPg0KPiBDaGFuZ2Vsb2c6DQo+IHYzOg0KPiAtIGRy
b3AgdW5uZWNlc3NhcnkgIShzLT5lY2FwICYgVlREX0VDQVBfU01UUykgKENsZW1lbnQpDQo+IC0g
c2ltcGxpZnkgY2FsY3VsYXRpb24gb2YgcmV0dXJuIHZhbHVlIGZvciB2dGRfaW92YV9mbF9jaGVj
a19jYW5vbmljYWwoKSAoTGl1eWkpDQo+IC0gbWFrZSBBL0QgYml0IHNldHRpbmcgYXRvbWljIChM
aXV5aSkNCj4gLSByZWZpbmUgZXJyb3IgbXNnIChDbGVtZW50LCBMaXV5aSkNCj4NCj4gdjI6DQo+
IC0gY2hlY2sgZWNhcC9jYXAgYml0cyBpbnN0ZWFkIG9mIHMtPnNjYWxhYmxlX21vZGVybiBpbiB2
dGRfcGVfdHlwZV9jaGVjaygpIChDbGVtZW50KQ0KPiAtIGRlY2xhcmUgVlREX0VDQVBfRkxUUy9G
UzFHUCBhZnRlciB0aGUgZmVhdHVyZSBpcyBpbXBsZW1lbnRlZCAoQ2xlbWVudCkNCj4gLSBkZWZp
bmUgVlREX0lOVl9ERVNDX1BJT1RMQl9HIChDbGVtZW50KQ0KPiAtIG1ha2UgZXJyb3IgbXNnIGNv
bnNpc3RlbnQgaW4gdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MoKSAoQ2xlbWVudCkNCj4gLSByZWZp
bmUgY29tbWl0IGxvZyBpbiBwYXRjaDE2IChDbGVtZW50KQ0KPiAtIGFkZCBWVERfRUNBUF9JUiB0
byBFQ0FQX01PREVSTl9GSVhFRDEgKENsZW1lbnQpDQo+IC0gYWRkIGEga25vYiB4LWNhcC1mczFn
cCB0byBjb250cm9sIHN0YWdlLTEgMUcgcGFnaW5nIGNhcGFiaWxpdHkNCj4gLSBjb2xsZWN0IENs
ZW1lbnQncyBSLUINCj4NCj4gdjE6DQo+IC0gZGVmaW5lIFZURF9IT1NUX0FXX0FVVE8gKENsZW1l
bnQpDQo+IC0gcGFzc2luZyBwZ3R0IGFzIGEgcGFyYW1ldGVyIHRvIHZ0ZF91cGRhdGVfaW90bGIg
KENsZW1lbnQpDQo+IC0gcHJlZml4IHNsXy9mbF8gdG8gc2Vjb25kL2ZpcnN0IGxldmVsIHNwZWNp
ZmljIGZ1bmN0aW9ucyAoQ2xlbWVudCkNCj4gLSBwaWNrIHJlc2VydmVkIGJpdCBjaGVjayBmcm9t
IENsZW1lbnQsIGFkZCBoaXMgQ28tZGV2ZWxvcGVkLWJ5DQo+IC0gVXBkYXRlIHRlc3Qgd2l0aG91
dCB1c2luZyBsaWJxdGVzdC1zaW5nbGUuaCAoVGhvbWFzKQ0KPg0KPiByZmN2MjoNCj4gLSBzcGxp
dCBmcm9tIG5lc3Rpbmcgc2VyaWVzIChKYXNvbikNCj4gLSBtZXJnZWQgc29tZSBjb21taXRzIGZy
b20gQ2xlbWVudA0KPiAtIGFkZCBxdGVzdCAoamFzb24pDQo+DQo+DQo+IENsw6ltZW50IE1hdGhp
ZXUtLURyaWYgKDQpOg0KPiAgICBpbnRlbF9pb21tdTogQ2hlY2sgaWYgdGhlIGlucHV0IGFkZHJl
c3MgaXMgY2Fub25pY2FsDQo+ICAgIGludGVsX2lvbW11OiBTZXQgYWNjZXNzZWQgYW5kIGRpcnR5
IGJpdHMgZHVyaW5nIGZpcnN0IHN0YWdlDQo+ICAgICAgdHJhbnNsYXRpb24NCj4gICAgaW50ZWxf
aW9tbXU6IEFkZCBhbiBpbnRlcm5hbCBBUEkgdG8gZmluZCBhbiBhZGRyZXNzIHNwYWNlIHdpdGgg
UEFTSUQNCj4gICAgaW50ZWxfaW9tbXU6IEFkZCBzdXBwb3J0IGZvciBQQVNJRC1iYXNlZCBkZXZp
Y2UgSU9UTEIgaW52YWxpZGF0aW9uDQo+DQo+IFlpIExpdSAoMyk6DQo+ICAgIGludGVsX2lvbW11
OiBSZW5hbWUgc2xwdGUgdG8gcHRlDQo+ICAgIGludGVsX2lvbW11OiBJbXBsZW1lbnQgc3RhZ2Ut
MSB0cmFuc2xhdGlvbg0KPiAgICBpbnRlbF9pb21tdTogTW9kaWZ5IHgtc2NhbGFibGUtbW9kZSB0
byBiZSBzdHJpbmcgb3B0aW9uIHRvIGV4cG9zZQ0KPiAgICAgIHNjYWxhYmxlIG1vZGVybiBtb2Rl
DQo+DQo+IFl1IFpoYW5nICgxKToNCj4gICAgaW50ZWxfaW9tbXU6IFVzZSB0aGUgbGF0ZXN0IGZh
dWx0IHJlYXNvbnMgZGVmaW5lZCBieSBzcGVjDQo+DQo+IFpoZW56aG9uZyBEdWFuICg5KToNCj4g
ICAgaW50ZWxfaW9tbXU6IE1ha2UgcGFzaWQgZW50cnkgdHlwZSBjaGVjayBhY2N1cmF0ZQ0KPiAg
ICBpbnRlbF9pb21tdTogQWRkIGEgcGxhY2Vob2xkZXIgdmFyaWFibGUgZm9yIHNjYWxhYmxlIG1v
ZGVybiBtb2RlDQo+ICAgIGludGVsX2lvbW11OiBGbHVzaCBzdGFnZS0yIGNhY2hlIGluIFBBU0lE
LXNlbGVjdGl2ZSBQQVNJRC1iYXNlZCBpb3RsYg0KPiAgICAgIGludmFsaWRhdGlvbg0KPiAgICBp
bnRlbF9pb21tdTogRmx1c2ggc3RhZ2UtMSBjYWNoZSBpbiBpb3RsYiBpbnZhbGlkYXRpb24NCj4g
ICAgaW50ZWxfaW9tbXU6IFByb2Nlc3MgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uDQo+
ICAgIGludGVsX2lvbW11OiBwaW90bGIgaW52YWxpZGF0aW9uIHNob3VsZCBub3RpZnkgdW5tYXAN
Cj4gICAgaW50ZWxfaW9tbXU6IFNldCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUg
bW9kZXJuIG1vZGUNCj4gICAgaW50ZWxfaW9tbXU6IEludHJvZHVjZSBhIHByb3BlcnR5IHRvIGNv
bnRyb2wgRlMxR1AgY2FwIGJpdCBzZXR0aW5nDQo+ICAgIHRlc3RzL3F0ZXN0OiBBZGQgaW50ZWwt
aW9tbXUgdGVzdA0KPg0KPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDkxICsrKystDQo+ICAgaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwgICA5ICstDQo+ICAgaHcvaTM4Ni9pbnRlbF9p
b21tdS5jICAgICAgICAgIHwgNjk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0K
PiAgIHRlc3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYyB8ICA3MCArKysrDQo+ICAgdGVzdHMv
cXRlc3QvbWVzb24uYnVpbGQgICAgICAgIHwgICAxICsNCj4gICA2IGZpbGVzIGNoYW5nZWQsIDcz
NSBpbnNlcnRpb25zKCspLCAxMzEgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYw0KPg0KPiAtLQ0KPiAyLjM0LjENCj4NCg==

