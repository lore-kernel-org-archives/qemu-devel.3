Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DC41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPghg-0006Jx-E8; Fri, 05 Jul 2024 07:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghe-0006I1-Vx
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:11 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghc-0001TS-RL
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720177328; x=1751713328;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OSaq06YEpf0TE4yDv2Vg7mB2AzPZeqdCRli7T3bqPdw=;
 b=kF8qC8Mcl6zHFh5zGFIF8a+DMgnWj5WcVa70fHCPxVQKrxJUcW/4WF1H
 K98znyXKETOVm9qMueccOsb2Vv631Sj3QsC6hXU1lmb0yFc8qWtWqHE6S
 /O9jUR7pLoACt9AuWsjVVYUYvhAAblfaf2ZiCK6/KYZ9+POGwEhSDUgBe
 kynJn5X7AkZJhhTAI1qomNpdu7Sm4u3ziORtn2iHzDMOLCpI4DrZKYTJ7
 o+k6v/pn8vbor/gGtIFt5vNvdI1RqXJnsQxTf2sMWGHmFjOmzAct2zbmr
 sfm/qquXNVEFJfDr9ANiJWCcBV1z4q9A36FZHDWBBIZA3SI/qapksnDYl Q==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="15949129"
X-MGA-submission: =?us-ascii?q?MDELdEO0ckOqF/CCJ2pgPrUNKVnLZSHeHuV81h?=
 =?us-ascii?q?5wCHEhM2BF3GJao2wap3IYGJYC8d9J3JkxDB9j743Slinf+FdouwRkdu?=
 =?us-ascii?q?w1Y9xwHDNTm7gGWN8GTy6fkfOQqQrX8t7tijS0e5Pjc9WvlYABlE0D61?=
 =?us-ascii?q?H0g1M7zNGGDQDeWD8Crw17ag=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 13:01:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8zARc2q0+tnaC5rOoak4mfa929Gql0NUkM1L/mRmSUMDqFiZRugYHcRx3/nHKEj9FmnI1NrY/AE7KrZSH49xVdgagLav2km6vkO8H9s3B9MQaPVKHLaSa5lO3KPGXSdR/FI+DRlcWgBaO2GaF+DBmhfR9yhpM6Bll70YBcd0ConNgMzEpGmZNjFMtizoQif+w74UHSW302tNgttvuhu/D9KFEyl5nehxNmNKnV6CNcKDFaILjbQiCfINzYDobd7bkq2B1VNGSeiwJvNgguocm4FzML8dK4lbXuxHygbvZWxNle7LFRfFIv9wS8t+peKJnVzFT9t3eni0GLVrYsioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSaq06YEpf0TE4yDv2Vg7mB2AzPZeqdCRli7T3bqPdw=;
 b=hV42v3WhqiDnq1fd5KIY9imlPLcDFwMlhwOLudUwVbRYvABHfG1RsgXfcCBjosv6fZeG9h1mcygA8/bNqR4IvirQCAXVwl/UuKAieBBUhmqcjios4gYnmE2vlvbdGpk8tGVI61BimIbSdXA6uio0B9KERhYn875Jz8NbREkOYw6MF8k7QLVXFIEUUvDpml2LmBevhC3q+TAEcEgNDsi1NlTRa2JQsnr6Cdz0h6PmZYPNlZVawuP47tY115IEIqitj/4IsQI3ZyJR5ZepKXYd+T+XATZXMZrYWORSouzjF6CNgU5dYMOJ4VijholRL2eS1SFBf7QMNXk819i/oBX4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSaq06YEpf0TE4yDv2Vg7mB2AzPZeqdCRli7T3bqPdw=;
 b=VLKmbFUa5/A7lfoVX6QNRiFnS8U6SpLBZYP3FztIHiV6zvOQuTLtm1uae0R+CDK5ZbLKjZYS103+4TmYasQQWVDQPC0C2abjzhA69AYxJqk0aqqu/Aq10WEs57lEd1xRMl2mRAiIQc8gNaZm7q/fAcTcEmyxW9K4i0Lh3CVTo0kDQ0KDyQI1ywfmjGE+SkmwxwZZoUue7Ia38QJLFBl2EQagzrCz3dKrTdtdW817kACHSw+qoBQr5b2m1+YvgiWRMhXT71cqqfAp5x8GRnHT6i+cgVSViU2bUz+Jb3HNC+n2ElqC13p5U9u/axPAGBYnQNXA/+ZVX2QT+x/lwLseZw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7303.eurprd07.prod.outlook.com (2603:10a6:20b:259::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 11:01:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 11:01:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v4 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH  v4 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHazsrBYascOMgzcUiBvUTQcBllOw==
Date: Fri, 5 Jul 2024 11:01:58 +0000
Message-ID: <20240705105937.1630829-4-clement.mathieu--drif@eviden.com>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7303:EE_
x-ms-office365-filtering-correlation-id: 7a0ef729-7e27-4a8e-2990-08dc9ce1e415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dG1XbFFlK1h4TmtUQTVrZ3ZKbmI5NlVWYXhhckJrRFk2aHJrUDJpUjdqU3dB?=
 =?utf-8?B?VExkb2RDMUhSaDVzM0thYlNBcjEzWWtCZkFKam1hTEFIb3YrN1JpeWwrWjRW?=
 =?utf-8?B?b1ZyRk1IWHF6RWRVK1NuNUZLd3lXYVRYTERGUlVTeWlPV2FOa1ptWXg3SXkw?=
 =?utf-8?B?Zm0zQ05MZzNTK05aZlQ0dTNhQU5tOUxuamZXZTd2cGZkRFUxcWZCbWRVUnZl?=
 =?utf-8?B?THdzb3VrYkJ3YUtKWWM5WGZvSytTN2o1WVNHeUQrVmgvV2dac0FqTk45U0tH?=
 =?utf-8?B?Qlh1OUZETGtoUjBFV3VVd3BwcURCdS9JaWQvYlM1NXdpVnZOUzc2V2pjNGdX?=
 =?utf-8?B?Z2plU0NtaWo1UnBscW9HL0xsQ1BTaW1OUmJZQkFseXdGTDZiOGR5RUN5aGVT?=
 =?utf-8?B?NHQvOW45Q0psS09SMVhLdHZNTFp1TGRHYjB1cHpvS0NuWUF0Z3NoREtHVU5H?=
 =?utf-8?B?VzJiVzV2MEVGakZFM2xTMW9xQmpSNkRmZTUvalpFUTlhaWZ2ZGxGNzQvdnhr?=
 =?utf-8?B?RlJIZ1VVSS8zQmF3bnhSQTZWaUhYcWZWdXVjRW0xczZXQ3JrTWNkbkxKemVu?=
 =?utf-8?B?KzRhODlBR2ZIaWJlNHdLV2c0QUFSbWZrdEloRThyVWV3R0ZvOEhKODN0ZVd6?=
 =?utf-8?B?SDlBZG5qRmVHbTlGK3hwcDhudWUwQzJNQWYrR2dNdnV5bFZ6UGQzN01YTXNB?=
 =?utf-8?B?eHdXaXNud2xRSFNIdzY0MndKWlg2S1d3MUJmSXVIWGduUVBIVmRBNkJZUHdB?=
 =?utf-8?B?SmNMY3V5eWhSdlZaeUpDVUxlWnh0eG0yM0sxM01UaVg3cHhBRWVVOFhXdDVH?=
 =?utf-8?B?aEZCcGtnRmI3UmdBTmV1R2hIeVdtWkozb3F1ZVNDVWVFdkpBdUw0c3o2UFVF?=
 =?utf-8?B?cGpXL3pMYWFVVFROKzhDdi96UjJEL0N6clFmVy9Ga1pBNnJyeUVudExoOHdM?=
 =?utf-8?B?RjkzZHQraHJMOWgyUXQwK0FVSUt2dTVkMjFUM3orM2NxejdTdUZCOXRFR0Jt?=
 =?utf-8?B?Sm5zRm5KdWNxKzRwMUxOMTdEcHhFT045VkNDdU1LSGpJb2VROFlwcFkxQkIz?=
 =?utf-8?B?VkM2ZlErcHl4RFp0Z3ZOc1I0T0V4L3c5RzhSbEtpZHRwUUkrWGlWZXZHSHNZ?=
 =?utf-8?B?VmVhdVYzZW5qNXlZTnNDMlR1SUd1SmVJY0lqMDQxeG96OXJrWGlZcmRDV2pW?=
 =?utf-8?B?QWw4eDY2U3pnL1VLTmt0em5tS1pvbHZZMlJCR0phcXU1RDJkUUhORm5GNHhF?=
 =?utf-8?B?cHYzM3NSenZzTHdxQUY1Wm1lV3VuMjlxbFlob2xpK2xjd2FueVYvdjVsb2tV?=
 =?utf-8?B?aXpoTUU0L2hacG9QUGNHd25jL09HelVxYWJvaGR1T0JNcEpRWEZENkt0eEZZ?=
 =?utf-8?B?YjM5eFhlM2lhcFMzdGV3eG56bkhCd09zdmVTbFFGNDJTRUdOMEkrWEVVWTh5?=
 =?utf-8?B?YW9Za0N0UnNRbXloY2pEMmFRSmdFUS95dEx6aEZrOU90VmtxVDBHQW5mQVc0?=
 =?utf-8?B?aDM0L2tNMEtwc0dMK3ZESVZSMEd0MzI2MU0zcVpqdnJiNFl0WGg3Wm9Xb2NS?=
 =?utf-8?B?enNkU1U4NmZ3NU1OK0JPc3lBeDFsNXcvNHVrNXBVbDNJaWUzNkJKSUlXSFRz?=
 =?utf-8?B?T3pGZCtOdVgvYnRKa3IyT1N0cW5JNWY0Qjk3TnIwY0c0UVBDSVd5OW5GRVl3?=
 =?utf-8?B?ZG1XNElWU0h4MHNWUkl0Q09nbllVZlJTa2MvM2tWYTVCVmNvOHdESXVxdUl4?=
 =?utf-8?B?a1RWdVU1dlRIR1FMZHh0L2lEZ3hjS2Q2U0lzR3B6V2xhZXdaTU1vYXhwamlF?=
 =?utf-8?B?c3ZiQVlGU1VLOTByMXA5N29oUldMV2tFR0hERG5GaDNEZFNodVdKcXBxM1Bw?=
 =?utf-8?B?MnZaWHVBdVV2R29EQWhKbDA5M0FnSDlSSUpKV3VvYmhVTFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjVxRHFQUDVwV0xXTEhjeGp4VXVNNDlCTEVDN29uQjNwZ0hJamh4M0RtUUJp?=
 =?utf-8?B?K1Z1VmpweFBJR2tvRzZ3QkJ3TDkvT2EvNDVFa1N1ODZZNlRuOHhuVnN2WHUw?=
 =?utf-8?B?Uk5vOXZOVzBsNDhMZFV4bmYvN2prVjdiT1NWSDJyM0hIS2d2N0l0R3FmbUZJ?=
 =?utf-8?B?bjNlNm05N2packxyYWlhMmpBc2lDVEJIcjBYL1FHSGFmbVlELytrOHRxM0xl?=
 =?utf-8?B?Vjk0Wi9kWnlSTFVoc0RGRTN1OUVBL3Q0TUdBeWR1VzZYNU5zenZ2NFR6V0NN?=
 =?utf-8?B?eDN4NDNYRVNrNmwyTzVQd3NRcTJqRHRGTjh2ZGpCeHYvT29RSVg0MFkzUHZs?=
 =?utf-8?B?dlp4N2FGeFZwbjFlRTdZSWtncyttb2h3VjAyRndWZDhIa3dqbkRZYTE4TGl3?=
 =?utf-8?B?V2lKVk9xdUFlNDRmek5VUzRtaEpmWmsvQklseDY2YmlLRWM2LzhYYUUvRGgy?=
 =?utf-8?B?TDZMdjZiTk51UW1wMmJORnFBdE12UmFvS2txQXZNZ1B6SnVqZlQzeU1ReS9D?=
 =?utf-8?B?c20yTUhVeUJuSTdaODZ4Z0czV0tCRkpjMzJvUHJuQVBvMml1dnkweGdjZnls?=
 =?utf-8?B?anhJWjRYTUtoaHVGdXRWMFZtRHVodm9wdnVJaHh2akdZWEYxcE1WWDUyL0RY?=
 =?utf-8?B?c2VQRGtXSHV3MlkzSUoxbVNBajF5YUhadkxUMi9BNGVNcng1TVFhVEdDeXhu?=
 =?utf-8?B?VmZqUkJMWFpiNTR0SVFwWXRoeDFRUUk2K0VWQlh4eDRXOTM5RUdOUVQ4OVBT?=
 =?utf-8?B?TU54NmlYVmFrVzgzYnR5YXF6QXlzdWFDZmU5QkYvbnA4Zm5IeTVOZ1hETFJ3?=
 =?utf-8?B?QllqYUQrSEsrY1g3bWZNZ1VwU2k2MVFDanFKMHhiRi9DOTdBbVNKYU1yOGtE?=
 =?utf-8?B?YjhFdU9tZVJXY0wzS3RaOTg3N3lCR216UlQ3OTdUbjVPNnVBT0FsR3A3dmJQ?=
 =?utf-8?B?UE5GWjZRandCMm9DelorK2UrOXFQOTVycDZyaVpnUzlPTjZ5N080eWF2R2VQ?=
 =?utf-8?B?amJtRnRiSFlsWEIyelZOZ1NPTEw0WUNFdGN5cnlCY2w3OU8xRkRJbHFmWmtX?=
 =?utf-8?B?MGhhSTVYditzaVovbkp4S2R4YmxhNVVMVXpTOWF0cUR6TVJlZVNXbklRUkxX?=
 =?utf-8?B?U0JUUko4SFoyaW1CS0t1V1pybnQ2UDNCaHphaysxc0hiZUg3NGZPKzlUWGhD?=
 =?utf-8?B?ZityNzBKOU9iL1Faa3VOQTEyTEZvM241VjhMM0NSOHJ2LzA1TXhpZWdBbjdp?=
 =?utf-8?B?ZEg0S0lrbm5RQ3VrREdpYytKdkQ2c3QxMURRQ3MxNVN0TFdwMHl4L1d5MExB?=
 =?utf-8?B?alppVThaSW5rYW9XSGs2Q1BjZ0J4cjhQSERvZXVVTm03elRGT3MydWhEa3Bk?=
 =?utf-8?B?Ykg1UFZYU3U3OUU1b3VpeWN1djBwY2dDaVZJTmcvSE52NDFZNWxKUmI4aUhF?=
 =?utf-8?B?dTlOakZhQTdmcUdaN2V0VU5hODROanhHbUx1S29Rb0h2M20rbUNzenJ1dUxq?=
 =?utf-8?B?MFFrSEJ3dFVmMUxkK0VIMlh6MmtBRGxaVjMzSTdVZHF0a0ZNemloa2I4ckRX?=
 =?utf-8?B?UnNJQ2RKRUxkSzFZRkJUUXZDbmplMHMwTk9XalpDVGxEN3EvR3locitUSlJX?=
 =?utf-8?B?cVBRWDA2SGI0MlRqdmEzb0JGano2YUFmMC82QWV5ZjZrOFFEOWJ3V2pvYXg4?=
 =?utf-8?B?Vk95ZUxsczNjZ2g1R1IrUkp6ZGlsT09yTW9JREkvRCs0WVBmZk5NSGFVN0Rm?=
 =?utf-8?B?cFJvSk9pYkVjd1NUSXNETHlrd2ZQQnlBUlVzakRtL3pheHJqallrSVBCUUho?=
 =?utf-8?B?U01lYnVqQjNkRTZLcWYvc3cyaVRRbDRVaUZPRXh2NG5UWEw5U3hsSG1KS0Zz?=
 =?utf-8?B?bzdwME1QbUVJMk9RNThGVU5iZ2lySW0rYVI0RjNkOWNUSXNXVk95bXJxQ1Bm?=
 =?utf-8?B?UllXWlZaVGZGeko3bFBNeFY0emJWUmdJNWZ0c1MyZUtFaGZDUHpmNEMwYUJK?=
 =?utf-8?B?UXlVVTZiajFrNkNaem84bTdGRFgvbjJVaUdGc3hQNW1GOGJ0VkFpSWQxeTlY?=
 =?utf-8?B?bVI3S1V3SjQxVGRzMHlKbDB6OUp5LzdRVEQ5MmRuOHFaZFAxa0pMaXBkSjA5?=
 =?utf-8?B?aHVjVThhR2xBOXBWTzhVL3NqOHlIN0w0djd3VUFNZkJ5eXVHTGRzMFNjcUtE?=
 =?utf-8?Q?HDHhJCJfbAokGLvZrSxe6So=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EEA1010084F264FA4F043D3AF8B381B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0ef729-7e27-4a8e-2990-08dc9ce1e415
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 11:01:58.7402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHKx/EbFjDpd4Y6ju1/wHpqV3oHUlvVrBn0K0/OJIYCAJqilVyypnMh4iUAntz41uLjbhaPpT8RtnQBoALCem3d2rWeZZheuqs2giEtpB/dGUc+SncD7sAWoAhonFPne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7303
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBtYXNrIHdlIGFyZSB0cnlpbmcgdG8gc3RvcmUgaW50byBWVERJT1RMQlBh
Z2VJbnZJbmZvLm1hc2sgbWlnaHQgbm90DQpmaXQgaW4gYW4gdWludDhfdC4gVXNlIHVpbnQ2NF90
IHRvIGF2b2lkIG92ZXJmbG93cw0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1E
cmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggZmFlYTIzZThk
Ni4uNWYzMmMzNjk0MyAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtNDM2LDcgKzQzNiw3
IEBAIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCiAgICAgdWludDE2X3QgZG9tYWluX2lk
Ow0KICAgICB1aW50MzJfdCBwYXNpZDsNCiAgICAgdWludDY0X3QgYWRkcjsNCi0gICAgdWludDhf
dCBtYXNrOw0KKyAgICB1aW50NjRfdCBtYXNrOw0KIH07DQogdHlwZWRlZiBzdHJ1Y3QgVlRESU9U
TEJQYWdlSW52SW5mbyBWVERJT1RMQlBhZ2VJbnZJbmZvOw0KIA0KLS0gDQoyLjQ1LjINCg==

