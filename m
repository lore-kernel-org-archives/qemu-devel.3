Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E95CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTP0-0002Km-7s; Mon, 25 Aug 2025 05:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uqTOu-0002Ik-93
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:22:04 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uqTOr-0006wM-NX
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756113722; x=1787649722;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tmfdcIeQH3mRzptjz61kP0k9l66WXK8uQrQLgxqrVqM=;
 b=LQuthopdni4CMsi4F9mb/KXUFHhYs6wh3dZT5FyVgkHySKCpDpNU+ZhL
 kDkxE11nnRomNk48k6sRkO7+5BCb+970E3YyhaPSwXi05k7Mh+oCHRLwI
 QFRgc0mRaC8SiA54sGW/SdpxgIZT4pIDrYZU+0tf5LlYmuD1Cq/UWsh5Z
 c2IDp60HR4SL8HMSs3Bkk0gICj3uFXAo3Kevezcg1JYKVioUsgbinJrG2
 JdQRBaIwDeqRi8GML/Q4vFmWGOySgRrYZxvynjRa9oRIztfYtBUrLHR3j
 b58FyvVjtYib4ImEDk+/n9nv9Pq/SVc3as/QpLSJfUVx/v4EsMLP38aGn w==;
X-CSE-ConnectionGUID: XPLq1A1uTZuFExYY0E8eWw==
X-CSE-MsgGUID: PSofO5oGRj+p5nJBO8kWdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="75773137"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="75773137"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 02:21:58 -0700
X-CSE-ConnectionGUID: nFAW+f00SJOOwECw25IzEw==
X-CSE-MsgGUID: tUI3JUlERSeT1s/OX8Umbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="169639331"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 02:21:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 02:21:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 02:21:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 02:21:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVrvijiAU92XJQjkGvBLnZm9RsIOalCoVDn4UJE8GLnMt7M5Tm30CKocmV0vlE+RVWzY2Y1zL/7gRHXrOg7/q6KF9+FBDACKl3V0LfAVeT8YjsS137wSX9+zFrURUOyw0QkylUZi5eGdGKWAnzgcASnwus+Gb4A8Y3NTZVp1TcFqCxy7D2Tvd0kvUSBXCruFmjAux9UJv/4QxFt+AfiAg9WhJtW6vf9DzPRHgyc0lB7CEN7x5cpoAq5n+z40Q8TTc/ciMg8+K9aa8be/HlxfDMOnnrByx3lt4ltFm2Psg7oCVxbFm3fHoZfIGRCkTo5liTYUOncXPgL/padLbAcOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyP32GUttox7lFx/fIUqUrJp5eBwE2jIJtaSj17jfP4=;
 b=KxbCKFUq3wKUST7Mg5Wf/WBzxKUTZ2nQM1BGVgefkcH4xqL+jL2jGxtj78YegN/nOamRQVPgLuUbZEptj6VuP9blqgT+atwBCWtPcULATji2TrNsOsMMNXhuQpUqURCNA0KrAk/z27LNS8+o0AWWVxAYRvw45MGE8VJnAM385HORMjJvBYxioRvBeW2jp/kKRfxYpv0IEoH/oN1kaQk1wyv48ZunmN0CtUdnZDXO27AuC0+CpgeuLO0GwVh+W8yHWkp0qDB4EGZR1VoH38l2Thfev5Epnx2gISg5DTC3AVBIir1989NjralbnNAHjKVsTOAvsQZzmvPDNa37t4fPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Mon, 25 Aug
 2025 09:21:48 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 09:21:48 +0000
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
Subject: RE: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
Thread-Topic: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
Thread-Index: AQHcEy/8GohI0K7pz0eZTie1Q5YTorRvWgMAgAPANdA=
Date: Mon, 25 Aug 2025 09:21:48 +0000
Message-ID: <IA3PR11MB913633DE25AD6CF07BF26F8E923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
 <aKkDXiSwWGgio0dM@Asurada-Nvidia>
In-Reply-To: <aKkDXiSwWGgio0dM@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7504:EE_
x-ms-office365-filtering-correlation-id: bb6bca65-0722-4dca-3a6f-08dde3b8d159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2nozjySY9dD2vD9SFCRTJO4FWdDCbrVZnDI72PMxyNE+1CDuBC0qG1wfh5GE?=
 =?us-ascii?Q?dgjA3EmyqhqX+4Sj9ihzNRgt4Ic01Rb7bF7NeYJmNn/kH6NMRfPM8I0kn4nq?=
 =?us-ascii?Q?hDIN4IAWvqx7AineCnCJGcVPaFN1itu/lxrOjxICGbmE+h1gT+1pdDFM5voT?=
 =?us-ascii?Q?schzD9CILoPG/QTNO85PlMWWsh9N3Xfp/JZyr41eY1CQILnCcIL52KbVXtUR?=
 =?us-ascii?Q?QnOMgn0ayU6n/XMbPZAwp2f5ssduw6FJ207NAh+iewqaHQOQe8+Xi4TUh9ke?=
 =?us-ascii?Q?oCIJ4yUzsRxc4EFDfoOfM8M61kSPnyMB6e1kBcFu0XK0B57xRqDb2CnAM2vQ?=
 =?us-ascii?Q?Op7LlohYiXZQbKXZ7LbwqmkXe+dZEyBpn/I4lWFC7M++YknH0pydD5dUy+F+?=
 =?us-ascii?Q?FP+OtNcqnlacf74/ryxVmFQGauxoV8LfdYskv8TFgQsDUinp4ladc12lLQT0?=
 =?us-ascii?Q?twE1A20TZ8nxsWSawDhssa39SCkyMV6tasYGbSY70hdMtMFh7k5qOF+VRFJV?=
 =?us-ascii?Q?oR3u9SPIwaG9Jtt/PMuf+1rpIaJQ0gsN2PQYjCluN4uTPP99KLdMdAjxjLqd?=
 =?us-ascii?Q?llxjzz+HnflTMq4TsK/LQuYLioarhVx3qE7M+LfL3sw8w54A5FGRms4uu1y7?=
 =?us-ascii?Q?i89bBUFSx629bqKk1SAyS825GIlM/SflNMbsXXCN3Qo/1MCJkFSxdrweLQEX?=
 =?us-ascii?Q?QC/USpTD0irFDt15MXduK7rLBjNMIMr4H5Yy6pof2GPo97y6eDZLj17RLsKm?=
 =?us-ascii?Q?738qY643KFbZcDlEumR6Qgg8swaPXWUccInDhTYNVJQ0khlKqNE4WNRObj5Y?=
 =?us-ascii?Q?idy0jEo7+xc7BrDjFoqa0U0TyrHU8eibe6dJBPXmOGFH8GRiZLsPymmFga9i?=
 =?us-ascii?Q?vKD0Iny4KsvNBrIyLjIteWGHlr+E0jrcFSFMWh+Qcv/XmNqU9cRGDkyQ6A/F?=
 =?us-ascii?Q?X14f8steQh/jzxxH8Ao6AgNFknTmMM67qFxNyQ2/5arsbpLd2MNMbairHhuH?=
 =?us-ascii?Q?/Afs/FOh1aSAV4xbclAWWkRqpxtXUunvNs0CdJbJ96vcT2mTlPJxNR19zNoB?=
 =?us-ascii?Q?VBDpMjNFlnJ6kNOsZr1mKyRxdUP6BgRSfynb2ZHu6l2WQVcLD9/slNRWnq09?=
 =?us-ascii?Q?BBzOEDSQ/kSfGjoffESGO30732+lCuZSSD08TdeHXLRvyYB+Nd7jZ2ZEDc0I?=
 =?us-ascii?Q?wa4ztDIdrk4hAEKySIp2gKurj0TjEqaDmg5yjG1zZsJ2eKtAO4xasOqSZnZ9?=
 =?us-ascii?Q?WUjv7TtcveQXQ14g+LcEI1HKXIF9qyWrH1fgElADbbDUjwDav1otwOATUjsH?=
 =?us-ascii?Q?/+VpNP2MjKy9NZvGYJiKuA6TswoRR+fTnaGQYvBxTdN0UcdLvXnmJsofa2la?=
 =?us-ascii?Q?aXD1SE9z/lF6JGvscc1oXZnYTD1Ptr5qcdGBSJ5c6ex+Wks8MBno/9NmSnag?=
 =?us-ascii?Q?T8zUbB+FXNIPVROUtuvS1EjxJHow1pNQaZ7fsKCO63OSyu/ia4gg7w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wZaY8LFGjFfmDXRoBzaaJd5DxDpbmydtckikthgTUUq6Vpfc1oO9uv2CYKbl?=
 =?us-ascii?Q?UZ9VgY6qVlagCdIahCuD9Bss5G+4uxkUFDY/gPGKFE5iSdEjo0I/WqxB+cK1?=
 =?us-ascii?Q?N8G2j/PdZtwXyUPY7/pSW5NHP5ZR5Y5wc2Z7C1NfkbIGAevCjxXlGx+QIjac?=
 =?us-ascii?Q?7VR90CdjfAOY94b4i9Ly3HSRglOlK8jOQ0AC2T1Yvfnh9IWV9T+u3meW2K/B?=
 =?us-ascii?Q?VIL3zoj2NMaEesXBIjYIxX6ipuODarETfw1d6R+aO1ti+FYs8Scyf4bgArVj?=
 =?us-ascii?Q?NIonDzNsk99kpy5++MVo1i/8761tjY198K58gPDdMLHKMzpaCjlFvNUVinHp?=
 =?us-ascii?Q?aTq34a6KBMcxXf+aYkWVNhLmmcZ6FKW/Oq2s/YTClHtc/FP3LEcjP8NH1mrc?=
 =?us-ascii?Q?7STeHAQJ/uJ28PrWsWtV44tB3taWU7oHfG0VdXsjwFHarzopbPTxO/R+life?=
 =?us-ascii?Q?3fk+frakjcZdFft2J1iwXiSu0JRpDTXLQlyCfhN7PwiF8uV1o0y0KUmusG+5?=
 =?us-ascii?Q?/TCNNp0pWygrkjeeO7EWJNuzTwyG+vUXV3IVCUp4v2B3BJEmzbyavGxb0dgm?=
 =?us-ascii?Q?+jdEavqW5WkLkubiGfTdGlU0RXAGyETtBu335mkKm64Ig5ywnVKYPSJa+eHt?=
 =?us-ascii?Q?UAFOQa/Ke+znu1zxKhcbEF2W/ZaACiBvwYRvuIPgID+phEZvg2Zz4s/2Apzz?=
 =?us-ascii?Q?f41h4v2mLyYL3IzIbLPwRWSZHUgjwDplvyRUZ5kk6ssZ5XpLVdt7qfl1asIO?=
 =?us-ascii?Q?gzbTjKcZqmLFeUDWLv9ijVngd8F79AFlVcIl1I3aabIamWU6rzCMiVps5U9O?=
 =?us-ascii?Q?U+QKG433/g1ED7K1RaqC4CRBpncuTJLXpTjFKqXhbbCzb3jPmTuRN4gj+KQI?=
 =?us-ascii?Q?j25g4vkoCxIPxdkZDnhUtr5dGsT2kZR5XKZch5TxkL7L1rrF0FFjVwWV35mS?=
 =?us-ascii?Q?JDDPRTxvXcbtHm4wE8dyrNV/CmDAFLQJ2ZoYWvwCkXO1SB8Isac0T7cylFZI?=
 =?us-ascii?Q?ItCIiGNUEAQ0V1luN2jNH2R2WoZoTXluU6ufHmqFeC0+mE9tVWZRPThS9FR+?=
 =?us-ascii?Q?PQVHiP2JH0ikmwBYPWD8DjtkJTlLmUfd8A3OlYWiBZOR9RFXQJEqoH58BLPJ?=
 =?us-ascii?Q?m7oay0rOrISJQhb4AqWy9LWq59BK5jOTqUcDefp697vL1pcwdTtAeJseYXjx?=
 =?us-ascii?Q?+y4gGBT4ymsHthD4KMf/rvml2c2mfMU16tm2CEZ22iGrDt/SU3/fDScpFuD5?=
 =?us-ascii?Q?OKGaDnH6Hrz/gA3XumBihjtRlMYgyhOPMFRu+Hrhao6K7j/Aj6LjaWbCfk1C?=
 =?us-ascii?Q?883F59Sfv7F3xogEq252VuxisjiEsZTVmID2KMK/HS70xVTKUIAhD3p1QCMh?=
 =?us-ascii?Q?JFagYswPgNm0pZp69Sg7+NiuCuQ+gOVeV5tT1DW/Hs5dqas9yc/hld+2hhcY?=
 =?us-ascii?Q?95Ktj1vpN2qyN4FRGTW8ZICbf4qG9nxTYkaDs/lr6feaxQ21NWFtzLINkE65?=
 =?us-ascii?Q?fPWkx28/Kr/3jVjHRmQt9uBPddYlqORw/qZ2Oqz8kzwb2E+fynvaxVGwLZUf?=
 =?us-ascii?Q?0DBeXUBl79qJwacYiqzHqJUZhQxdWGODMDAfqNDC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6bca65-0722-4dca-3a6f-08dde3b8d159
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 09:21:48.2093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /W521xeD7IiXK5kj3sDeUKhTmmx98EF/RzgwJ+NMLb+l+wwKVkEGsdoHa8wJN/FE11hv4/rAPuVGUxDrJtXUoWneeFyybqqeoY8VSiPGPps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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
>Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
>
>On Fri, Aug 22, 2025 at 02:40:58AM -0400, Zhenzhong Duan wrote:
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index e503c232e1..59735e878c 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -324,6 +324,7 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>  {
>>      ERRP_GUARD();
>>      IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>> +    struct iommu_hw_info_vtd vtd;
>
>VendorCaps vendor_caps;
>
>>      uint32_t type, flags =3D 0;
>>      uint64_t hw_caps;
>>      VFIOIOASHwpt *hwpt;
>> @@ -371,10 +372,15 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>       * instead.
>>       */
>>      if (!iommufd_backend_get_device_info(vbasedev->iommufd,
>vbasedev->devid,
>> -                                         &type, NULL, 0,
>&hw_caps, errp)) {
>> +                                         &type, &vtd, sizeof(vtd),
>&hw_caps,
>
>s/vtd/vendor_caps/g
>
>> +                                         errp)) {
>>          return false;
>>      }
>>
>> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>> +        container->bcontainer.bypass_ro =3D true;
>
>This circled back to checking a vendor specific flag in the core..

I'm not sure if VendorCaps struct wrapper is overprogramming as this ERRARA=
 is only VTD specific. We still need to check VendorCaps.vtd.flags bit.

>
>Perhaps we could upgrade the get_viommu_cap op and its API:
>
>enum viommu_flags {
>    VIOMMU_FLAG_HW_NESTED =3D BIT_ULL(0),
>    VIOMMU_FLAG_BYPASS_RO =3D BIT_ULL(1),
>};
>
>bool vfio_device_get_viommu_flags(VFIODevice *vbasedev, VendorCaps
>*vendor_caps,
>                                  uint64_t *viommu_flags);
>
>Then:
>    if (viommu_flags & VIOMMU_FLAG_BYPASS_RO) {
>        container->bcontainer.bypass_ro =3D true;
>    }
>...
>    if (viommu_flags & VIOMMU_FLAG_HW_NESTED) {
>        flags |=3D IOMMU_HWPT_ALLOC_NEST_PARENT;
>    }

IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 is a VTD specific flag bit from host =
IOMMU, we have defined get_viommu_cap() to return pure vIOMMU capability bi=
ts, so no host IOMMU flag bit can be returned here. See patch2 commit log f=
or the reason.

Thanks
Zhenzhong

