Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6850C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 03:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiC0-0002DV-Bo; Mon, 24 Aug 2026 23:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiBy-0002Cx-IZ; Mon, 24 Aug 2026 23:51:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiBw-0003oC-MW; Mon, 24 Aug 2026 23:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787629876; x=1819165876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0imPRPw1GgstRdKATeAOxFetl0KGS73c0NJJN+hCFus=;
 b=gIgJhZM63AKyQqdv0c7b4lT+j6+TKH3DGSHU9bEYAyRPhLPCbvUeVGau
 2wcqr59+clMn0YhXhFEODaELwFBlD/ylMV/smbCQtkh+JRrm6ROG4NiyM
 4JqNANAUSdjo2W0dPPhUUdiBdPLDuZqvgBE7d+1pglzvulAa5WLROWtdB
 AlNPzHCcMs5Z54SPw/pxl2ARsULOME3g8+kalE2CVPvRUIUaqymnmH7Fy
 0SgpWIrug8Pm5AvPs/m+ZdI4/VKqNa8pkMyJkNjCXv0G2DasCQgJe9FDn
 Hkf7Ry6mDOCO0uAECNjXMBcXtgPKDr4SoXqWBTtrm3ocEZ56FeSTzAQww g==;
X-CSE-ConnectionGUID: CwiSDIZ+TCmNSuE/oFCNjA==
X-CSE-MsgGUID: j5rzCvkaQNaEO99gJpI1qg==
X-IronPort-AV: E=Sophos;i="6.25,241,1779120000"; d="scan'208";a="150003426"
Received: from mail-eastusazon11012043.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.43])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 11:51:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVkm3fs2QJ+ne1av2jOP3+1wQScmQQjBsbs+ajuXdvUqbYsNER+tYHd9/jhQ11y1lYntZerCsdL+KEDCRZbWWte/3VA3cRvcRwW1Yw/Hyfnwo6oKqEUnSEKjIMgOngyUsZPLRKcFOxQAe44CfVHWbLVVlKn/3BM49J2honHaFGXJc33qTsN2wwe2LOLPK5H+C5puW6rqX85TNpj5YXraJnq7AIIgU+m1AlHRilpnZ+XxRAVGrQzy9VK6YcS4qm7JGBJihYShd+cZqAp4achEre6FlYOIvnAcZCiSO/Bit0gTTDigZFFEBpWDJtKRg59+MhyolclpRBArKRKsPSrgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0imPRPw1GgstRdKATeAOxFetl0KGS73c0NJJN+hCFus=;
 b=Ca5dOnd91eeNxE/24Pv36MUwozXg1U2JSHu634XBhEY1RigPbSXaquL+rPGA8nGl5a4pxOcq+6EalYIrdrF6A/6YwexH8AYqyXZpLjxpzS77MZ8Zfl1nER55Je16krRt/HuHFBDDYGIWsS4qeIqQEjpUqCguH/f3dcSweCbmZHP+7PdJxI2VjU2Bd+pubGxfzAxN7JGq/8kMcPwwyQLlcT881gQY3pD7ktiDrmtAOJK7n3e5TxVDEbOdXnBX7Flqmu2CINFLUGlce9pKsaaV9CEclzqrAGUsGK3MmDxAu1yjsBz75XVO6HAl98OKFe7xVHt7G4Ai6QDRIJobs0uHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0imPRPw1GgstRdKATeAOxFetl0KGS73c0NJJN+hCFus=;
 b=yT/koj/3AqvLnBhwn1m1yle3D4TeZZoWSc9SuQGuoh1BfZo8JPWoFzKM7dFQ6sDFH+gm2XryfTr6XXMZoxNVT8CxPvrbEqBkK5drCHGGoU8wixwLVwmAJoK6jKmRmyMc31hyzP9XZPf0tsZKOjTf45vq2HOj0kxfnhvIBGXqvu4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BL1PR04MB549746.namprd04.prod.outlook.com (2603:10b6:208:243::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 03:51:12 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 03:51:12 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 3/5] target/riscv/tcg/debug: adjust 'timing' bit for Debug
 1.0
Thread-Topic: [PATCH 3/5] target/riscv/tcg/debug: adjust 'timing' bit for
 Debug 1.0
Thread-Index: AQHdJQfLEIu9nRxi0EqNDt0WlEysTrauP9+A
Date: Tue, 25 Aug 2026 03:51:11 +0000
Message-ID: <92b2752ac51b74070c952c68897733eb29d608c0.camel@wdc.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
 <20260805182506.2943757-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260805182506.2943757-4-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BL1PR04MB549746:EE_
x-ms-office365-filtering-correlation-id: 4ada5402-5f50-4952-ab39-08df025c1ada
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|19092799006|376014|38070700021|6133799003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: coNjZw/jzmsDdacS6+yfufgz7aiWQjz38NIyt5+yaBlzv5b5+tVCD2y24+Q5NuevFBSz1iOxE5M308QDTZaeYVsvnMpTWdjjrj3IG09lCdqCjqrIIpD/KcFBY4CHqYwi7TekWXlvA8zJzbXhCNIDx7epyuv0NQ/tSuAbGJpthXebStl+FpCmLADcTvfEXyY06UL8OtLTzRt4eoE8cZA7s3F+KNITMxh7WxH0qJbwacTi2vnAhogFM4sNBE/7IXso3RTgiAa9f/uKaVJ6xtI3xx/TewwyHJtXG4QGcQHOUKbURtdN7v6Xn9umdI8GRAP7BLV8kxhmipvuti6bpaJaPS9I3v9SZYvF2Vn9CTbnumMZgomQpSHD8jH+1Z0H6n9IdyoK3soIM/U/NhByUeGmSb0IjypCutt28IsLHQHrasEv1n8NEYZaUxUs5O9l30xWQ8oV0gaRgiLOVPDndAaksTeqFarPufyDQIGzqbq23TDgkCJQ1ZM+cGZ87b/VLuyMm3MGkpNwLTmA+fwTF3N5nQcXQahkIBKoY664DyUl7rHAuH9HFQtNa14DvF3PtV1on/YRfXzuRmrlS+6tECI3TJ+gXsyd6IGAtfGdNTPGQyLEethHE8C445tr57R4Dxkp0kQDqZuIfuXZuLkmhY/CnYWqUiGYyO2opks8aOvxjzcWwGfqGG5qL/myjQ4WXISBc8j+rv07Y8Em8y5CicXPbP0nIuT71I96yHzQorKDqI8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(19092799006)(376014)(38070700021)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE5nbGxqSGFXejNGcVlNd0NzTHRLWjljWVBaRjNyRGZZVlFzZmxDci9DWVpH?=
 =?utf-8?B?dVhEblB2TjBpYXViTTE0dFRWN2pjWmYwUnpTMGlpOGpvQjE3Wi9vYWhLTWZn?=
 =?utf-8?B?WFp3bEpSSTFac0FXMnUxZXRWU2dIeVVZQWFjM1cyUXp0YmdrdlUwWnRHUE9q?=
 =?utf-8?B?YXdmTERHak81UUQ5WWRGSkJ5M3hSd3ZDeGU5ZkdDNkFWZU1ncUZGeGFKN2Yw?=
 =?utf-8?B?amJqdzc5M2I0NEdnbXRGSDdYcm96cG5TRkVzdFZvQVFnUlhBUUh3S1BBYlVY?=
 =?utf-8?B?SUwwZzMzemRLTkxrSnIrVEI1aEZ1aDJRWnB1Zm55ak5RWXoyU0V3bXBUM1NN?=
 =?utf-8?B?S29DQVh1RklwNlVhdUdzdDArb2taaWEzckw4UTdJV1UrOTFCWXl6SHg5dDFM?=
 =?utf-8?B?bGRLaWd1UTBTNmc2dkxYTnVXeWduRHBPWmNIUllPK3BPUzFZV2xIbEZVT2hw?=
 =?utf-8?B?emhhRnI1cHMrcGt2NzZYcE95NllEQkhiVTNib0U4aVdFRFVDcit6YmtyRDg0?=
 =?utf-8?B?OG0vYUxscHRvMDlSQzE1WHJ2aDZPazFVTlJtL3RGcVBJYXZaVG5UZ2cyMjUx?=
 =?utf-8?B?NlViRTRyalpMMFA4OS9SWHowbng1cHJCR2xxTWlWS0hDeDNWWjRsQnlmaFdh?=
 =?utf-8?B?UkYyaGFPYUxUNmRENnBHQVNNaHliV2graUhLTUlEYW1ubjdxbjBnWjV5Y2p0?=
 =?utf-8?B?YTV1R05GTVlna2t3YVNaQmJtTm4zU25pS29YdFFhWlNUd3JHRllmV1NIMEtl?=
 =?utf-8?B?SmlwY0FVMHlBYXhjS0xyakg3eUczbFFGaTZkYXUxa202QS9VUVBrcUZ5ZC85?=
 =?utf-8?B?TytZL3gvVnV4VWdPSW1DMXBpUUpkdWl4bmpNcHRic3Z2QXpPTkd5R1F1SnlX?=
 =?utf-8?B?WjdqUDcxMlBOYVk0NUF1YUlPcHFxMTdmeXBKOEFVM00rb1U4UHNNNDMxYXpJ?=
 =?utf-8?B?b2FSN0Z5RFhIdjNqbE1KZUJ0QWJEaGJ0OHFXNStRMS9JWWlZOG9TMUVMMGlO?=
 =?utf-8?B?dGFYM3lQQS9qbGtFS2dRVy9nS1hVdDF3bW81OUUvN2pIWU0ydDYxeXppdUhs?=
 =?utf-8?B?amxuQVRMMWFERm5JWlEzZjFCdVQzTndPb3FMUDZsUWh5aUluV0l2Ylllb2Vm?=
 =?utf-8?B?aTZPa3ZvWDN6S3p3UlQybU01alFXMm9OZm8xaVB6WGptL3ZxWkN2SndxSzFM?=
 =?utf-8?B?eUZwSjhJRWVSV29xd1Z1UUoxZVBrckluSjAzNmVYQkZ2MDliVmFWQ3lENDNy?=
 =?utf-8?B?QUpqTzhjaHd4Zk8rMEhlWDNtN0hwMnZRNjFiOEZOYzh5a1NQNFl5eW9vaG5v?=
 =?utf-8?B?OC9OUlVONmpXbWw1Mjk0MDF4bUJjcko0SDh6VDYrb2h5T25qNjRoMVZCcWlG?=
 =?utf-8?B?UnlMUjByZnJtZ3Evc0s3TkwrQThkNUNxOVZ4MjRodG12c3RVMXVLMWNaZWs2?=
 =?utf-8?B?YUszcVA2L2pxeEp1RElUMkVVSGpRd3cxV0Jjbmdkdzd3WTQweDFOWGpFNTc0?=
 =?utf-8?B?M0pNYTY3aU1PVFFmazJvbmV0bUowSXVzSCtMU2tra0MvVHBMVGE2aGI4MkVG?=
 =?utf-8?B?SVlHaGRXK01lTTZUK0dWbno2ems5OTNFajRRUTNpOEVrQlhxRzBKTXJVN1hT?=
 =?utf-8?B?bUNYOGx4ZmQrNlBTRzQ0ZytXbXBYbFFKM002aXJXcmRsa201d2JWQ0locXFT?=
 =?utf-8?B?eWZCcjVJNVNuK1dDRFFuOW51enpVZDVYdGZWcmpLNEFTbFhOcXRjZWVVVnR5?=
 =?utf-8?B?VlRTcTVNRFNPMGRxQ0FNU2tZcDFaMFJRTkR1T1FkT2RDelBhNmk4T1JLM0ZJ?=
 =?utf-8?B?MEpCeVp0K3dOZjUzZHV2N2V3cms4TTZnOEluQjFlRjdkR1c4ZlV1aHhMM1NF?=
 =?utf-8?B?QmRpNGpqTFVmMnVXczZWb0RPMGFFWHQrNUpsKzIyQ0ZRT2tLVkc2WHJ1Vm43?=
 =?utf-8?B?TmhYbk5NZXZGalEyME1hV2hHdGVwZzB3RW8weXI4dkZ5VmxzSWNaSlpSWFBU?=
 =?utf-8?B?d2M5ZFY2czFQZFZRM1JQdXdRZ240WDd1cVNqWEd6dlhISyszanlHV3dRdE9I?=
 =?utf-8?B?WDhkL3B1RVQvUjgxdVRZZnVNSWpySFh0Tm8rQ2pzU3RHQ0xwOS9rRks1cmpI?=
 =?utf-8?B?clZIbi8rZG02Z3pLK0dLUTh4QkhtUkFqRVBkVlZTLytzQTJvN3RpSjhsbjNa?=
 =?utf-8?B?MEViY3VjUEdKdGMyRFhXaHljVUlSZ3VvdUlFR2YzYVVDSDJ4bll1T1AzUmdt?=
 =?utf-8?B?N1Z0TDZzZFBLMGxLMHRvUGsybWg4UXQ3Tmp4KzQyVnNNdnhtTVJCSHI5R05h?=
 =?utf-8?B?Z2wwTjIvZkszbFhERHlXYmx6aXFjQWRtUVY4bkdPS01sckpKYmJhSGVNRW5P?=
 =?utf-8?Q?Y4xbruT3s/yaQn3LudJpmujBIH+WsUAWlAmKqcce/TZUc?=
x-ms-exchange-antispam-messagedata-1: +hipSnI+9r/gsbfOjVWnX4e2x3jjRr5ZuEQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB04AAD057BCD441A8B51CB383A07CCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IRuoOHxYgPmHxbPlUlfpyUsgbRb4y7kS/Cwg4/XYQuVrVxJgYgkRKpPZvMcJ4Za0KOK2gZx7lXZw15R2nE5414J4xJZYB7fSUWlhT3PJwmm5S+6j32SiipiUuueaBMyDXdyeeE9IoNyVKsztCsqeS9M+et7qXj9IPIwHwv+82+J17VPWhIC+8Nj0nps8nMkHOe8mT3l0LDKILmWXp5EfHiwm9EGO6+ABgK+S/aLcxsRShpvhCtF9sOtGppG+1D78Jjo8uEXFN4CA4WpIJfRTmTtEfGd3jcgUbCVtihrm51oyo/I3uC/HWVcf8TBpdZnHuOIMCJZzlMOYgxQMBRY9jg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RZxnmXQK/W4QyQN+3/2cMfQY6Adl35bxTSKp5NmWoWgSlyoyDA4UWNxwCtrSKBGx8l2OIIsMGBayAJ+GZfNvSSGs1gvq11B4POIZZSc3oYiUE1HTQ6f+QJ9h4XpswDHZyrCG6gB2w/xJO7l+kaJFdtoj99+WmQ/uDuxQhUQZj4pip/+LSVtLqIl5x1TNTV5F3Xu6gm4IRu8g1xQ2SB/gUksznuMoOZZY+gniyJ+kthkrM1fTGrgWw2LP+YYt7uGm8WXF3W2A99cNz6dxaKJwroAv4Kj4X6PkQkxMq42Zv4Xyicnb6q1v5HbwWVO3GBRzFiemRWTkIXfM0JXVedh1EddWDNAG7f47CARU+0LGzKzi1G5O0MHLJ1BrTBYm7WZYARuMz0rG5mtPxPzWKYIxW/IA1J+X60MAUnITyb5nCIFi1gyl+vWmQiIesewmt+7drlwPypmn7AoAQz78v6odX8X7EHRWfsPTJlC7G8dNh2wQgJ4PFnUCkuc3vv3cuy9egu8RVKAT16UFbuDMbgM+DE4atnvjxrFXu+nM19HnFxqKI/EjJfSNUQpkdtAj0IBIN6gJRmULmNI2uR+IDE5idQYjEEKqESukLsXn9LvhaaGcRmHR1BLRtiBQfoQEE348
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ada5402-5f50-4952-ab39-08df025c1ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 03:51:12.0393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsBcdAz2a7DzlhKQgWqD8bKXnV/b12C9p4OrRPS2GCGtrbZF+0EvD2gkAhhTh4BffJeWzAetFQ8ibqu2meTLwxNNSuWBbAsaQBZHBEBsikk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR04MB549746
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDI2LTA4LTA1IGF0IDE1OjI1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gVmVyc2lvbiAxLjAgY2hhbmdlZCB0aGUgJ3RpbWluZycgYml0LsKgIEl0IGlz
IG5vdyBiaXQgMTguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFs
aXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0K
PiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmMgfCA3ICsrKysrKy0NCj4gwqB0YXJn
ZXQvcmlzY3YvdGNnL2RlYnVnLmggfCAzICsrLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di90Y2cvZGVidWcuYyBiL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuYw0KPiBpbmRleCAyMTkxOTI4
NzYxLi44YjIzYzhkMDQ1IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmMN
Cj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jDQo+IEBAIC01ODQsMTAgKzU4NCwxNSBA
QCBzdGF0aWMgdGFyZ2V0X3Vsb25nDQo+IHR5cGU2X21jb250cm9sNl92YWxpZGF0ZShDUFVSSVND
VlN0YXRlICplbnYsDQo+IMKgwqDCoMKgIHdhcm5fYWx3YXlzX3plcm9fYml0KGN0cmwsIFRZUEU2
X01BVENILCAibWF0Y2giKTsNCj4gwqDCoMKgwqAgd2Fybl9hbHdheXNfemVyb19iaXQoY3RybCwg
VFlQRTZfQ0hBSU4sICJjaGFpbiIpOw0KPiDCoMKgwqDCoCB3YXJuX2Fsd2F5c196ZXJvX2JpdChj
dHJsLCBUWVBFNl9BQ1RJT04sICJhY3Rpb24iKTsNCj4gLcKgwqDCoCB3YXJuX2Fsd2F5c196ZXJv
X2JpdChjdHJsLCBUWVBFNl9USU1JTkcsICJ0aW1pbmciKTsNCj4gwqDCoMKgwqAgd2Fybl9hbHdh
eXNfemVyb19iaXQoY3RybCwgVFlQRTZfU0VMRUNULCAic2VsZWN0Iik7DQo+IMKgwqDCoMKgIHdh
cm5fYWx3YXlzX3plcm9fYml0KGN0cmwsIFRZUEU2X0hJVCwgImhpdCIpOw0KPiDCoA0KPiArwqDC
oMKgIGlmIChkZWJ1Z190cmlnZ2VyX3ZlcnNpb25fMV8wKGVudikpIHsNCj4gK8KgwqDCoMKgwqDC
oMKgIHdhcm5fYWx3YXlzX3plcm9fYml0KGN0cmwsIFRZUEU2X1RJTUlORywgInRpbWluZyIpOw0K
PiArwqDCoMKgIH0gZWxzZSB7DQo+ICvCoMKgwqDCoMKgwqDCoCB3YXJuX2Fsd2F5c196ZXJvX2Jp
dChjdHJsLCBUWVBFNl9USU1JTkdfMF8xMywgInRpbWluZyIpOw0KPiArwqDCoMKgIH0NCj4gKw0K
PiDCoMKgwqDCoCAvKiB2YWxpZGF0ZSBzaXplIGVuY29kaW5nICovDQo+IMKgwqDCoMKgIHNpemUg
PSBleHRyYWN0MzIoY3RybCwgMTYsIDQpOw0KPiDCoMKgwqDCoCBpZiAoYWNjZXNzX3NpemVbc2l6
ZV0gPT0gLTEpIHsNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuaCBiL3Rh
cmdldC9yaXNjdi90Y2cvZGVidWcuaA0KPiBpbmRleCBhMjVkMDk5YjM3Li5lYjYzNWJjMjc3IDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmgNCj4gKysrIGIvdGFyZ2V0L3Jp
c2N2L3RjZy9kZWJ1Zy5oDQo+IEBAIC05OCw3ICs5OCw4IEBAIHR5cGVkZWYgZW51bSB7DQo+IMKg
I2RlZmluZSBUWVBFNl9DSEFJTsKgwqDCoMKgIEJJVCgxMSkNCj4gwqAjZGVmaW5lIFRZUEU2X0FD
VElPTsKgwqDCoCAoMHhmIDw8IDEyKQ0KPiDCoCNkZWZpbmUgVFlQRTZfU0laRcKgwqDCoMKgwqAg
KDB4ZiA8PCAxNikNCj4gLSNkZWZpbmUgVFlQRTZfVElNSU5HwqDCoMKgIEJJVCgyMCkNCj4gKyNk
ZWZpbmUgVFlQRTZfVElNSU5HwqDCoMKgwqDCoMKgIEJJVCgxOCkNCj4gKyNkZWZpbmUgVFlQRTZf
VElNSU5HXzBfMTPCoCBCSVQoMjApDQo+IMKgI2RlZmluZSBUWVBFNl9TRUxFQ1TCoMKgwqAgQklU
KDIxKQ0KPiDCoCNkZWZpbmUgVFlQRTZfSElUwqDCoMKgwqDCoMKgIEJJVCgyMikNCj4gwqAjZGVm
aW5lIFRZUEU2X1ZVwqDCoMKgwqDCoMKgwqAgQklUKDIzKQ0K

