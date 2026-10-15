Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4652FCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHym-0006a8-9f; Thu, 15 Oct 2026 05:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1xHHyj-0006ZU-CH; Thu, 15 Oct 2026 05:42:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1xHHyh-0006zP-FV; Thu, 15 Oct 2026 05:42:25 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F8jc5W3732637; Thu, 15 Oct 2026 02:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CCwxMd+XwlnG4vKBQM5pbTLtTPugWnPQFcCGO5rq0
 UY=; b=ZkGFToxdzhdJFevJCVffESsiQtJBL9nnPgjjdrbBMS06x/BWTLvtc3nL2
 RpwLQBzqGcDcv2AOFWTxMzE3DSkYlAWte9HDJLRzYrrFmUv8KrRR+nFGcIRoZkMt
 KH0DOJhWrKb/591bLQ8Xkuj+zf4EdkNQte8G2vHC0nBR5Hu9ImfMN6reKSIyDmGU
 zYgxEcpB5bo4L6Gc01Y4xFVVz401DeErOXvaZWPV78Ujb/Mhf1f2beN70oo48AYg
 OEjPkjDbL/gi/iTwbc2uuklV3kbWIjdQZnKlRF2BIOq3ren0pFBX72Vfbyz4LJCh
 RBsLqI7WfrMq4n4fyrNSug1+6EuGA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022135.outbound.protection.outlook.com
 [40.93.195.135])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4haukug4cf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 02:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBuVw7Wq+akMXU72cCORsmN6yKBmiXcojV3X2Sx6EIdOS9+dkGaPgOlr5b3fAXzpVVI3TzTMYtCJWKTo1v590DybuaPXp0ShsETzO/HezVVm5PFVZgQivctilNHDVoOiuq3btU8mfoZBetGI7EF1ThhdsPixFBIeKLXqILHfoiHyBAKzlpk4YleIHbXBMqP1NXOhsT8u+ccGQeFJyl94V40m890bscJgDftF8oCHzMi7YAMfqFIqH2ch2bmjxBehL5dTcSvz3KIsnlJd9VU1nqFNNRshuWDJIfVCF8e+LFCKUu5pl1xWSyA34/+HsuDDcAZl8KLmOBAgLmskcYhnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCwxMd+XwlnG4vKBQM5pbTLtTPugWnPQFcCGO5rq0UY=;
 b=F5pt2d1nmOdTEkS4oWPXHKK3zaLpQTUBhQji3YrGFPlRJgvTAItnlrAxyEMlYKbdUDNGUrE1GXt8i1ioIFkxbblRrK2ZmhRbZ/mdv4N3v5l75EPfQnN006ZssEaqkKtxuwl7FKi1/dwiRdl7kMoqoEpG2DIDSmZPrca5vppLpZQF49uVgDwRPqqImq95b711AJ04DIigCoGsZeuMBiRNEHSFtnKehs8n9uMN2z7vQ6LhcNqIsl2xV4pYmnlqU4kng9kBbYKXBYAJD535gW3yj7MmJSW2fvRLc0QWAA72kks1TleCWJrivU1SVS3/yiwTRuWcvb50YthmDxOIwNVu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCwxMd+XwlnG4vKBQM5pbTLtTPugWnPQFcCGO5rq0UY=;
 b=ro9v58i/z/1Mjzz5fhk3kmsPxLZcQCMyDjSZzhn6FTHVTmB8T9dtTt0ch3YuSTucbru2OrQ1SepUbGj7ikaLWL7CgbeFTAHisbasFf4xlJJZhGa8DtUZpehzcfhYeLuD5rkxdPn6jk0/agxWU3MN6UFlujHUwRpXqTs3Yz0Ez1ke7O85eQXwWgz0whQhP42OUxFaehzvSEI6n9V6pXQ/HfOxZs2y7efAep5PXqXNpmQWL6KhNGFJA1kQ+nNENd6bQRlxhG4CMo/5DGDkuuihociJ1k71ZzpMVa8L5y8js81GB5ifpk9eUSJ7Tipqqm+elaDC/+3h1te2ARUVPzqcrA==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by DS0PR02MB9101.namprd02.prod.outlook.com (2603:10b6:8:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 09:42:18 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:42:18 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] target/arm: Deprecate using named CPU models with KVM
Thread-Topic: [PATCH] target/arm: Deprecate using named CPU models with KVM
Thread-Index: AQHdXIlx5wCXw61+3U6/rArm0aGtXg==
Date: Thu, 15 Oct 2026 09:42:18 +0000
Message-ID: <F8A86B45-9641-490E-A7CB-6FC8CB29A1E3@nutanix.com>
References: <20261013105147.1070641-1-peter.maydell@linaro.org>
In-Reply-To: <20261013105147.1070641-1-peter.maydell@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|DS0PR02MB9101:EE_
x-ms-office365-filtering-correlation-id: eb804043-4d6d-4712-2c81-08df2aa09a36
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info: 4jXEWxtLwLBQcsdupeKdfd/OhrYp6m36vTOwBrHKWPcJo5ZULeMpZFaPEfRDZFPDeNinkG5IDsc3X6lWkU4ybx0+lL/N4IcToyZ9fIE90ssBGBhaN8Cb72q4+JKBnMkPBZJuBdq4x/iHtLd4ssOE8euytVecacpaF0rQT7RQ2zd6dcL/uzMt1b2p2/pQIc7FeuYgxD9gHZmU+ebwemBKZMPIsddlNDUoyS6xogLAUtNYZP7zGoYHud3RgtjDjHGcNiwP8E/ueWP5O3L6WTHBAbK206y2/sENSB6GQGWu+S7xt1HOt/waBZ3iYBz8V0VsyoEB/VogvarqStsAQR5Y4QkB8kwfoyPdk3o7QhyCY2ns8okZmEzMrareqEX2wYGTCDqQ2Meo3OSIXuxNjcBOm9kScEoU2640667RPZoBWOUsJx5U3f1RTUlpRl5OPnbAMXapEim0DenkQQReoPbxTy4RgVKncpl3ao5nMRgyUNEk2U3Oi0Tt+y4OEivdPUq4Txv1XbuMGhBM1bAgNi+ro/+uNEeNSGxN2TQwfRW5mpC8mxHDVLZpkFrsw/U3YSPVvAjminiz3939eL183ZUpQSOlkBWH2UoLcSS2Ic0Z37poMwDmWmplHZgmXSCROkHfHrM1tw1OxRGncvsZvBH4tudwdvKDrfImS+wwMMKnq0I9fzUjBsFd8oq5z9VdrO2a+FTShXKWo+jRga50TkCSdOfQ9GaD9oWEphiSLNnXbpo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1d6dmpENXRwVXVkcjdsVUlPcUFlbUZwNU5zWmdKdFBCMkd3aWRFNEhnWDBF?=
 =?utf-8?B?QzNqMzRMbnhxYTlGcmh4a3ZxSW5qSGZEdFNkK0hLZVU2SFdhd0xsUnhYb2lU?=
 =?utf-8?B?SGEzTXpuczlJTEVocHEvYW5vZ0NKcUhJVmVjWVA0RWVIVTlyRmdMZlBFTVVB?=
 =?utf-8?B?SE1xaVJ0VzBnU2x2ZVc4UlNYNm9rcVlIVE5TeHVqWk5jQ005aGN4YmNzWkQ3?=
 =?utf-8?B?QnpTWUJoZUVzeGJoaWdmczdOLzFZUkI2ZmhhSlZmR2tleXF6cEExbTFEQTJX?=
 =?utf-8?B?WXZRdXpLeXhNaE1LQkkvU3YramNYcXBWWXlKK2lBa09zeTg5c3JOeGhyeDJu?=
 =?utf-8?B?WjZTS0dKcXVjQ0Y1RTJmYS9zUUhtb3VRbkk0ZjRYSGpkME8rUFVoUzZWSXl2?=
 =?utf-8?B?YkF5d0NnWnhQZVN6bm1JL1Rnd2dpb2Z3TEN2TTJ1bUtVTDAzbWNhbVpkM0Zz?=
 =?utf-8?B?K1VoQXVrYnJmVDI1cDVENjlkaHZ2V3I3a2xselZmSFMwNkVOcGdmZ2hyYXEv?=
 =?utf-8?B?bkl4THRTZTV5cXUrK1hneDhYQ0JSbitpOUpBdHZtVzJsOHIzTVJwamYrV3JJ?=
 =?utf-8?B?K0R4RUszNFdWY2U3MWpSeDcwRjg0MHlxN0JxWFZOWFk4TVluOHVlODM1WDdE?=
 =?utf-8?B?azNMeEFmQUorRy9wMWd0RW9pTHpMV2hxOWV6UWVGQzhWck1QRnBaYzZMUHRJ?=
 =?utf-8?B?K29adll6cmxsRFloc3lFVWJYMGlaUElFWFIwNm1oQTUrcGZwS2lRK2d4V2Rk?=
 =?utf-8?B?RHpDVG90RXkyVTZuSkx1UURPU2cwaUkramhOMEpySkJvNG1zVVVuOE04SFZG?=
 =?utf-8?B?T2tXdG5FYnV2M2c4RERJclV2RC85VkxMSk1xRElLVlNSM3h5UTdteWVteGt3?=
 =?utf-8?B?TG9odmhZamJuOTlCZnQ2TlJTMmNROUJ3YWFHZmdaeVhXekRXT0hNVlladk9v?=
 =?utf-8?B?Y29oWkxiQm8waTh6NXhuUWQzZVNyV1k3STF4bDkyNys5Nm1DMFE2WDVWN2R0?=
 =?utf-8?B?L2tSV2lmcTk0d2JWa05sZGtiRVIvR2tCbEF5NmpqZkE5N3pBVkh1c2pSVEo1?=
 =?utf-8?B?QjJERldsOFk1d0wyR3NjazArYmJRdHRLek10dW1aVHh0MStHcE90aWxleks0?=
 =?utf-8?B?b2NSbXh5SjdDTERCajZWZW54SXdrV2NWSGMwdUFSQmt3ZW85UDdIRTJ2Qkcx?=
 =?utf-8?B?ckhva1VjWUZuMEp6MGJneFljRlNSNnUvUWNJeEt6QjFZNExVRU1NcU9ZL1NQ?=
 =?utf-8?B?WEJLbXRJbUtXQ1l6T2RDV2MwSnZwMEk2U0dJdFhTVDllS2Y5NkpCL1hpY1B4?=
 =?utf-8?B?S2QxdTBVdUQxaW4rVHdVcXNjN09HbkkvcUthOGtLZXNneFB3NDJtL2lRQmh1?=
 =?utf-8?B?NFZBUnZtTmhjL3pPRWJwMnFsUUkycEVOSUpBZ3B1NUpCSldXZ3Vkb1diTWNJ?=
 =?utf-8?B?R3p6emNKM0NicnliSk9DdFVaTmZ6akdOb1k1V2hmTDc5OVdYdFBmaWc4WFA4?=
 =?utf-8?B?YkUzK0tFQXJMRS9FN3NGV1lLT2h4MURVUkZxT2FIZ0pXOFBZWXBnUW9sSFhE?=
 =?utf-8?B?QlBBcGtkcHFCZm9QWnJMSzZEZ244T2RIc29teThYZHdGdG13Zlo0UU5wUnBL?=
 =?utf-8?B?YUxhTG5vbWpGR2UxUjNUdG0zbk5IZGw0cmlhd1pYU2R3aHc0QjdDSXAra3U3?=
 =?utf-8?B?a0JiMDFubGVOeHNLNG5LR1JuQUovV2pTeTM1MHdiTllzZXVzRTZBRHhuRlp1?=
 =?utf-8?B?RW5YdXpKRVYzdmlHelg4d0FWc1Z5dVNaZDYvVTRPZHNTdGh3U2MrM1psOEs4?=
 =?utf-8?B?V01UeHcrVTV4WE1EMzkyVDcwMFBBU2E0R0NCSGJGZFFQVlpVZlU0K3ZQNTkz?=
 =?utf-8?B?WkVFUXY5OEV0VWlDZlFiSWZHZ1dOaGcxSjhFTFBjWEh3Z2lkcEVxTWdaVjQ5?=
 =?utf-8?B?T1EvbmEreVFYSHc1TFM5SXZrMjc4TjhJVEoxU1MyT0pZSXJpbEJRa0V0WTll?=
 =?utf-8?B?c3F3VGR0NWw4a1dMMVFmT3lwcVpwTUg4K1cvNFR5aHdic1pTODJ3STlHTllG?=
 =?utf-8?B?SlhJZS9VbFgzYm1kSXl2VHlkQnMweU1pelpqZ21qRGVqYy9uZVJIbEJFcWJw?=
 =?utf-8?B?dzFVMkJ5US9lenVhVWpZNkt3c0pqcWl6S29FQjFDU0JKNzFMMC9WUlhrZTM2?=
 =?utf-8?B?anNkT0dXUGdhZUkwaHFNUFZLRWdPMkszQXl2bG4wTG9wYlpoYmk4NmJBQVdE?=
 =?utf-8?B?ZkNvL0piQ3NVRTI4Y0NyczZMbjYydW9zenZZZ3RnSWc2dDVHSmhNMnhHeWRa?=
 =?utf-8?B?TzFTY2pWV0ZRSzRJTjUrMGczMGJGN09mcVdEenV0UEI0dzRSKzM5U1FxT1JE?=
 =?utf-8?Q?i7+/xC6PlA6BY8PI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7236185DBE6F04C9FDA690C326FC693@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 04+iMgD/hy3/GLxvUd73haFjRMYKBSCY8ruigJl348R/vDxJNVSokxN4GLbKgzRbvx9xd53xh+Tpc9G8326/AzkwpLK6aRhJGoZabWsEMse+07pSFIbwfbKLJtRF2uOEO4Y3c9qQuj6dpUeYvR15aOGbI7ZdyTIl/1YfDzr8igGNBtMxJz4vcWBT/sjcyjodSYcuURvp4n116ijCNm+T58KV1xf6wwAufp1jfHWlh9N0QUzIrgdB/4wB6lwzMJSoDGSYvEBj/aES0VyLWvaHKBAzK2SiC+MUhy7UN4NvGqMLmMQVjOWyjOE55m+rdWTpRO73FOBacEjKqObhCKwFOw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb804043-4d6d-4712-2c81-08df2aa09a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:42:18.0156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0qgcUm3XWK67ZT5KV/1rTCZ7Y6oFjK8cYqNrxVgg3GYjxIB2Cvjtfmt7+n45qFQH3b7Xn7MsOK5OxT6sPFLax10AUIsJ6JR85Jp89Y/HQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9101
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOCBTYWx0ZWRfXxm/FAkhwasma
 95KZhw2q1um3xL2GujLd0ZrfrzjyUmINdOWaLhmqMIRgka9ZaUFAJnyYPRxMpMkyZdML3sSx0eM
 vGI0O24lAJ5Oi6VN5Dx8NwJTcsGURMc=
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ad09ffb cx=c_pps
 a=j8jEPmhjjLnYR6B6k97zMQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=KKAkSRfTAAAA:8
 a=64Cc0HZtAAAA:8 a=QaT11G7x9sRChgbZxssA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BysKmweGyv1K6ap3DKOdNygpauuj8sIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOCBTYWx0ZWRfX/my/4EfNkJyu
 dIwKe0WDVQ1OH/pitf8s5lWMD3OqLIGorA6DBPdRyertbxV3//sOCk5eN7OISM2SCD+yJsWlRR0
 P7gJ3xjdGs+MHOLSmpw7PWJKCSbytpWYT4LCWNdmpgujMzJ3xXGtSG08AaSqG6Fa00VWIche1qH
 RQho5FJZLBxf8SXyf2QBxqedjSOPOsLtusAd+qGM8yRVHc7dScw34ckMVraLlUEuA9mZh9DSnvm
 zPL7tBS+syZnjqIzCYSESmssZ/KiSiBWbBJ3snviv5bfz55c6mzhrPQPcQx3HNEg7n2aJ9/WnMR
 RuDTqEbRD5yZhduKCelHDr2ArBI9EZOdZ44f+9H5Y/FDhNWzum/dulneiT0afG2iWBWAT9MBUWz
 uYJgrQUyPQ/pPSVKGFd0xsXwds0nYbEuyH0GTwPpFp3ExMZysocvXM7v/p5ikadPAX2NVo0UUAR
 qaKftWmrpg54fY6uW1g==
X-Proofpoint-ORIG-GUID: BysKmweGyv1K6ap3DKOdNygpauuj8sIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=khushit.shah@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gMTMgT2N0IDIwMjYsIGF0IDQ6MjHigK9QTSwgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+IEN1cnJlbnRseSB3aGVuIHVzaW5nIEtW
TSBvbiBBcm0sIHRoZSBub3JtYWwgdGhpbmcgaXMgdG8gdXNlIGVpdGhlcg0KPiB0aGUgJ2hvc3Qn
IG9yICdtYXgnIENQVSB0eXBlcywgYm90aCBvZiB3aGljaCBnaXZlIHRoZSBndWVzdCB0aGUgc2Ft
ZQ0KPiBDUFUgYXMgdGhlIGhvc3QuICBXZSBhbHNvIGZvciBsZWdhY3kgcmVhc29ucyBhbGxvdyAn
Y29ydGV4LWE1MycgYW5kDQo+ICdjb3J0ZXgtYTU3JyBDUFUgdHlwZXMsIHdoaWNoIHdpbGwgb25s
eSB3b3JrIHdoZW4gdGhlIGhvc3QgQ1BVIGlzDQo+IGV4YWN0bHkgdGhhdCBtYXRjaGluZyBDUFUu
ICBUaGlzIGlzIGJlY2F1c2UgdGhlIG9yaWdpbmFsIGlkZWEgb2YgdGhlDQo+IEtWTSBBQkkgd2Fz
IHRoYXQgdXNlcnNwYWNlIHdvdWxkIHJlcXVlc3QgYSBwYXJ0aWN1bGFyIENQVSB0eXBlIGJ5DQo+
IHNldHRpbmcgdGhlIHRhcmdldCBmaWVsZCBpbiB0aGUgS1ZNX0FSTV9WQ1BVX0lOSVQgaW9jdGwg
dG8gYW4NCj4gYXBwcm9wcmlhdGUgS1ZNX0FSTV9UQVJHRVRfKiBjb25zdGFudC4gIEhvd2V2ZXIs
IGl0IHF1aWNrbHkgYmVjYW1lDQo+IGNsZWFyIHRoYXQgdGhpcyB3YXMgYSBiYWQgaWRlYSwgYW5k
IG5vdyBldmVyeXRoaW5nIHVzZXMNCj4gS1ZNX0FSTV9UQVJHRVRfR0VORVJJQ19WODsgdGhlIHRp
bnkgbnVtYmVyIG9mIGV4aXN0aW5nIENQVS1zcGVjaWZpYw0KPiB0YXJnZXQgdmFsdWVzIGJlaGF2
ZSBpZGVudGljYWxseSB0byBHRU5FUklDX1Y4IGV4Y2VwdCB0aGF0IHRoZXkgd2lsbA0KPiBvbmx5
IHdvcmsgaWYgdGhlIGhvc3QgQ1BVIG1hdGNoZXMgdGhlbS4NCj4gDQo+IEZ1dHVyZSBzdXBwb3J0
IGZvciAic2hvdyB0aGUgS1ZNIGd1ZXN0IGEgQ1BVIHR5cGUgdGhhdCdzIG5vdA0KPiBpZGVudGlj
YWwgdG8gdGhlIGhvc3QiIGlzIGdvaW5nIHRvIHdvcmsgYnkgdGVsbGluZyBpdCBkaWZmZXJlbnQg
SUQNCj4gcmVnaXN0ZXIgdmFsdWVzLiAgUmVhbCBDb3J0ZXgtQTUzIGFuZCBBNTcgQ1BVcyBhcmUg
bm93IGFsbCBvdmVyIGENCj4gZGVjYWRlIG9sZCBhbmQgbm90IGluIHdpZGVzcHJlYWQgdXNlLiAg
RGVwcmVjYXRlIHRoZSBhYmlsaXR5IHRvIHVzZQ0KPiAnLWNwdSBjb3J0ZXgtYTUzJyBhbmQgJy1j
cHUgY29ydGV4LWE1Nycgd2l0aCBLVk0sIHRvIGdldCByaWQgb2YgdGhpcw0KPiBvZGQgbGVnYWN5
IGNvcm5lciBhbmQgb3BlbiB1cCB0aGUgb3Bwb3J0dW5pdHkgaW4gZnV0dXJlIHRvIHN1cHBvcnQN
Cj4gbmFtZWQgQ1BVIHR5cGVzIHZpYSBJRCByZWdpc3RlciBzZXR0aW5ncyBpZiB3ZSB3YW50IHRo
YXQuDQo+IA0KPiBGb3IgYW55IHNpdHVhdGlvbiB3aGVyZSB0aGUgY29ydGV4LWE1MyBhbmQgY29y
dGV4LWE1NyBDUFUgdHlwZXMNCj4gY3VycmVudGx5IHdvcmsgd2l0aCBLVk0sICctY3B1IGhvc3Qn
IG9yICctY3B1IG1heCcgd2lsbCBoYXZlDQo+IGlkZW50aWNhbCBiZWhhdmlvdXIuICAoVGhvdWdo
IG5vdGUgdGhhdCBpZiB5b3UgYXJlIHVzaW5nICJLVk0sIGJ1dA0KPiBmYWxsIGJhY2sgdG8gVENH
IiB0aGVuIHRoZSBmYWxsYmFjayB1bmRlciBUQ0cgd2lsbCBiZSBkaWZmZXJlbnQuKQ0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0K
UmV2aWV3ZWQtYnk6IEtodXNoaXQgU2hhaCA8a2h1c2hpdC5zaGFoQG51dGFuaXguY29tPg0KDQpU
aGFua3MsDQpLaHVzaGl0DQo+IC0tLQ0KPiBQZXJzb25hbGx5IEkgZG91YnQgYW55Ym9keSBpcyBh
Y3R1YWxseSB1c2luZyB0aGVzZSBuYW1lZA0KPiBDUFUgdHlwZXMuLi4NCj4gLS0tDQo+IGRvY3Mv
YWJvdXQvZGVwcmVjYXRlZC5yc3QgfCAxMyArKysrKysrKysrKysrDQo+IHRhcmdldC9hcm0va3Zt
LmMgICAgICAgICAgfCAgNyArKysrKysrDQo+IDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RvY3MvYWJvdXQvZGVwcmVjYXRlZC5yc3QgYi9kb2Nz
L2Fib3V0L2RlcHJlY2F0ZWQucnN0DQo+IGluZGV4IGNjYmM0MjE5NDk3Li4xNTNmZTExODE1MSAx
MDA2NDQNCj4gLS0tIGEvZG9jcy9hYm91dC9kZXByZWNhdGVkLnJzdA0KPiArKysgYi9kb2NzL2Fi
b3V0L2RlcHJlY2F0ZWQucnN0DQo+IEBAIC0yMzQsNiArMjM0LDE5IEBAIGluIHRoZSBRRU1VIG9i
amVjdCBtb2RlbCBhbnltb3JlLiBgYFN1bi1VbHRyYVNwYXJjLUlJSWkrYGAgYW5kDQo+IGJ1dCBm
b3IgY29uc2lzdGVuY3kgdGhlc2Ugd2lsbCBnZXQgcmVtb3ZlZCBpbiBhIGZ1dHVyZSByZWxlYXNl
LCB0b28uDQo+IFVzZSBgYFN1bi1VbHRyYVNwYXJjLUlJSWktcGx1c2BgIGFuZCBgYFN1bi1VbHRy
YVNwYXJjLUlWLXBsdXNgYCBpbnN0ZWFkLg0KPiANCj4gK2BgY29ydGV4LWE1M2BgIGFuZCBgYGNv
cnRleC1hNTdgYCBDUFUgbmFtZXMgd2l0aCBLVk0gb24gQXJtIChzaW5jZSAxMS4yKQ0KPiArJycn
JycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycn
JycnJycnJycnJycnDQo+ICsNCj4gK1FFTVUgY3VycmVudGx5IGFsbG93cyB0aGUgQ1BVIG5hbWUg
dG8gYmUgc2V0IHRvIGBgY29ydGV4LWE1M2BgIG9yDQo+ICtgYGNvcnRleC1hNTdgYCB3aGVuIHVz
aW5nIEtWTTsgdGhpcyBpcyBpZGVudGljYWwgdG8gdXNpbmcgYGBob3N0YGAgb3INCj4gK2BgbWF4
YGAsIGJ1dCBpdCB3aWxsIG9ubHkgd29yayB3aGVuIHRoZSBob3N0IENQVSBpcyBhIENvcnRleC1B
NTMgb3INCj4gK0NvcnRleC1BNTcuICBUaGVzZSBDUFVzIGFyZSBub3cgb3ZlciAxMCB5ZWFycyBv
bGQsIGFuZCB0aGUgYWJpbGl0eSB0bw0KPiArdXNlIHRoZSBuYW1lZCBDUFUgdHlwZSBsaWtlIHRo
aXMgaXMgcGFydCBvZiBhIGxlZ2FjeSBjb3JuZXIgb2YgdGhlIEtWTQ0KPiArQVBJLCB3aGljaCBk
b2Vzbid0IHdvcmsgd2l0aCBhbnkgb3RoZXIgaG9zdCBDUFUgdHlwZXMuIFVzaW5nIHRoZXNlIENQ
VQ0KPiArbmFtZXMgd2l0aCBLVk0gZW5hYmxlZCBpcyBkZXByZWNhdGVkOyB1c2UgYGBob3N0YGAg
b3IgYGBtYXhgYCBpbnN0ZWFkLA0KPiArd2hpY2ggd2lsbCBoYXZlIGlkZW50aWNhbCBiZWhhdmlv
dXIgb24gdGhlIGhvc3RzIHdoZXJlIHVzaW5nDQo+ICtgYGNvcnRleC1hNTNgYCBvciBgYGNvcnRl
eC1hNTdgYCB3b3Jrcy4NCj4gKw0KPiBTeXN0ZW0gZW11bGF0b3IgbWFjaGluZXMNCj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9rdm0uYyBi
L3RhcmdldC9hcm0va3ZtLmMNCj4gaW5kZXggM2Q5MDVmODU2NWQuLmRlMDlkNjNkMmUzIDEwMDY0
NA0KPiAtLS0gYS90YXJnZXQvYXJtL2t2bS5jDQo+ICsrKyBiL3RhcmdldC9hcm0va3ZtLmMNCj4g
QEAgLTIwMTUsNiArMjAxNSwxMyBAQCBpbnQga3ZtX2FyY2hfaW5pdF92Y3B1KENQVVN0YXRlICpj
cykNCj4gICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gICAgIH0NCj4gDQo+ICsgICAgaWYgKGNw
dS0+a3ZtX3RhcmdldCA9PSBRRU1VX0tWTV9BUk1fVEFSR0VUX0NPUlRFWF9BNTMgfHwNCj4gKyAg
ICAgICAgY3B1LT5rdm1fdGFyZ2V0ID09IFFFTVVfS1ZNX0FSTV9UQVJHRVRfQ09SVEVYX0E1Nykg
ew0KPiArICAgICAgICB3YXJuX3JlcG9ydF9vbmNlKCJVc2luZyB0aGUgY29ydGV4LWE1MyBhbmQg
Y29ydGV4LWE1NyBDUFUgdHlwZXMgIg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICJ3aXRo
IEtWTSBpcyBkZXByZWNhdGVkLiBVc2UgdGhlIG1heCBvciBob3N0IENQVSAiDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgInR5cGVzIGluc3RlYWQuIik7DQo+ICsgICAgfQ0KPiArDQo+ICAg
ICBxZW11X2FkZF92bV9jaGFuZ2Vfc3RhdGVfaGFuZGxlcihrdm1fYXJtX3ZtX3N0YXRlX2NoYW5n
ZSwgY3B1KTsNCj4gDQo+ICAgICAvKiBEZXRlcm1pbmUgaW5pdCBmZWF0dXJlcyBmb3IgdGhpcyBD
UFUgKi8NCj4gLS0gDQo+IDIuNDMuMA0KPiANCj4gDQo+IA0KDQo=

