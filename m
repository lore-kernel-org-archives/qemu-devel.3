Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E1C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMfq-0005Ae-NX; Wed, 12 Mar 2025 10:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsMfi-00056c-KL
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:02:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsMfX-0008Qh-PC
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:02:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C9vhZ1014953;
 Wed, 12 Mar 2025 14:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5qUcXOZaDLf5pdHEXsBDh6Z3023evBP1BsekKGn5lEc=; b=HglqR6ZisnXEyRnx
 N/fFDp9mInjwyp13Y+xGwizuJOoVo0XuaD4gysvwn6OXc4TFRWehFbxsFswHLUxC
 m64LQFl8KmvCvac3FXoOMtAhsOVvZ1T3+eTgwVckfT8psTd4iv6teyzPNVjUPxf8
 cDaWDepJ53cgqm1hBXyREdtO2drf1boAPQmWI1FNoO0Wn9oeD4lAkpg92ONbLU53
 cG5mwUwZaeXIYNxEhS2Jj1Z4owmJGbcCZbez3TwaYdxMKGSwZKld6b7NL9WoRsON
 EJubhZ0d5LpZjx6LJ79Ys0qXtCiQPPgfw4Rid7tlsJ7QYCqncThdCQncmMPfBsCf
 T9xaaQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazlp17012050.outbound.protection.outlook.com
 [40.93.20.50])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p2kut-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 14:02:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbJJf8N707tBWijog/uuVB4VrErfBJlXOK1oPCsmqIfJeiKW2DHa1m/KJphTifASdZKOLqT/TrPmfi5qbIAs2zt0xTMyZbiLQGl1m14fEvEWioyXx0TaDLw1/haeritduJMmVedEN3vi9ATxpjzxxwZb3OXB8IDNuxiOLsr3LyXnyhpZumziWoOpdY70MBtGbOOLzCAZfwj150NHLIFG71uBKINNIhyvvqdNxmpLp59FbqVBCbv+ysPKdD0hMqiT3/lU7y1+ql8TzHSuJlrlR3eeoUW5ewSkxqpMdKnMLSUIlwCRYyaRuFI3wvlqnDyyObA5EzE921W//n9UVJYXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qUcXOZaDLf5pdHEXsBDh6Z3023evBP1BsekKGn5lEc=;
 b=lxCTYvHJ7DO5mqcQTFYB02c+oYCVdM+FMnYgLsHKgdlm8Lb0csicTP2O+Iu0OhwnxQDIsXr7+mAgo92OkGpy2XhC5TxmgSlYjhhEedQOQJx2mCgUYNTR0UaFEG/Hmn1L1ypbhqSo3gUqa4sVwFe0SGgrHfe50rF7Otu2VQkUC1fKx/QbIic/fevxwvW0emc4EPk4XFtFbChO5EI1mxbMhZIjyU0sNePDf3by5mn70uBBrHqJPCw4gawBzyC7H1RJMgjCOM12lxKXv6V4eG+ThEyMvV7yHm2qcQqwX1SNAlBx5rdMe5sqj5KXyxMVArfmwG+6Tp7LnW+J2t6kMPU+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by BN0PR02MB8288.namprd02.prod.outlook.com (2603:10b6:408:15b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:02:36 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:02:36 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>, 'Brian Cain'
 <brian.cain@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>, "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng"
 <anjo@rev.ng>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "Mark Burton (QUIC)"
 <quic_mburton@quicinc.com>, Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
Thread-Topic: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
Thread-Index: AQHbimqq7JAlF+F3YUOZKwYJb0+p8bNupUYAgAD0coA=
Date: Wed, 12 Mar 2025 14:02:36 +0000
Message-ID: <IA0PR02MB94868BC8A1DCD9495B37AA2DBED02@IA0PR02MB9486.namprd02.prod.outlook.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
 <00aa01db92dd$0fa87e90$2ef97bb0$@gmail.com>
In-Reply-To: <00aa01db92dd$0fa87e90$2ef97bb0$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|BN0PR02MB8288:EE_
x-ms-office365-filtering-correlation-id: b11f9760-ddb6-4d9e-2ff9-08dd616e8b2a
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?djVmM3ZYc3l3Q3pOWDlPS1o2cEFkVjV6ZThtNkFIN3lnWjVkSHFCY1k5eTE5?=
 =?utf-8?B?RCtISWFqS040dFFQODVhYi9uWVpvTFNBUm12WXI3VXM5R1cvSzZyZjcrdHV0?=
 =?utf-8?B?TEtiMnhpenBGeEVLbzlKckNnczBpWGVDaEZIZmVjM2Rna1ZnbGxDREhwZ1BC?=
 =?utf-8?B?cnJYTUpXc3BnUzU1SjN0L2RMOFQzVUM4MTVrUkJNNmlnTWhQZ25jVDc3ck5M?=
 =?utf-8?B?dkRhUFhscFJHNTJmMXM3VmRFQnJuOVdiWmwyeWQ0WHlVYjFVeTk2NUFVYVNx?=
 =?utf-8?B?Q3czb05lY1RvcVFhYUt4SFMyREJhb1dIdlJQSnBVTEJjT1RBNnlESXNsWUgx?=
 =?utf-8?B?N0QzNllLR3dmYzdtdEpJbTl3NW5pQ3I3SHJpaUk1OVJ4angwR3Q4S1UrVzRk?=
 =?utf-8?B?VTdxcnkvb1dpVlBJV2dWTmV4QnR1eXZkSkVaQy9aZGNmUXBhOEM1NnhteGMr?=
 =?utf-8?B?d1VzeEFqbEVhWHdtam9FaS93NEdwM2lrVFEySkRFVVJManY1RjJXUFI2T2NG?=
 =?utf-8?B?alVSSVpoQmh3QkpNbktZZXYwNmxicGNsYXh5bkZ2M3hBU3NIWHZST2phcy9l?=
 =?utf-8?B?eEt5RVUrd1NNaWtUZXVSWDhxcGtvdlhoaGFTQmM4ejJQUHV6b05hTFBFY3Zo?=
 =?utf-8?B?R2tiUDk5bk5NSHBhblZTKzgzUUM3aStiVWlmNzRvcmFjNnVpejU4ZU43c0Rn?=
 =?utf-8?B?bzZwMHpjVU0xSCtMck44NnBXNjR4elZiSWxLZVVOZ2lnSDBXN2Yrc2VXa3lP?=
 =?utf-8?B?S2RRVWd3UG5zaHd0UmVYcnFaQkJLRTBFM2ZOTDBCWE85OHVOTTRCdmhFem85?=
 =?utf-8?B?Z21JVWp0cXQ0TytqVUpWUi9LRU1wdzFiaklnZzBoVWFDS1BMQXZWVHdVdDNa?=
 =?utf-8?B?Sk10SnRZV2pqYnpJMW1PMlM0V0VHdW1OTnJSWlhxRnhvdnh6SE5CZjF4bWpK?=
 =?utf-8?B?dktqY2x1eVdhYWlaakhLRkpzdEp5RS9TWm9KRTBQT0NneFFicis5R3llcHVN?=
 =?utf-8?B?cHZWajAvenM4NUFaWVNUdkxHdlFvQ0xDZHNVTVlYcklRUFo0Sm5MNkdDVXdr?=
 =?utf-8?B?NkxVUndmSUNBUGQ1VUhvNThId252NSt2QWUzMEhCZG1URmZ0UUV1N01JaTJQ?=
 =?utf-8?B?dTRZbHlwbythdGF4VVNQbG02NTRoVmw1NDF5ZmUySnlYeDVEZDBqMVNLbTBh?=
 =?utf-8?B?TEhId2ZQVjhMc3Z5WFJQamlzRkZMcDdibnp6MmtNbzN5Q04yNkhMdTM5Yk5Q?=
 =?utf-8?B?UVJMc3YzYW94UDBidEdWTXI3Ny9iMTcwUUt5dkplY2R6TDAxY24vYXhNWVdL?=
 =?utf-8?B?eFI4OHFienYyTzQrUkFZa3NPMXdKK1dITy9YaDg1YTliQlZYN2NhQjVqUllR?=
 =?utf-8?B?QTRCcktGL01JTGlzOW5ybmV4V0l3clhFOVh4eE1QRUE4NHpQV013ZlY4ZkRL?=
 =?utf-8?B?UGJFeXp5U2twd3BzY0VFL1pKSDU3YnBiN2lKdjBRSTVkQnFWR1VuU0Jkd1p3?=
 =?utf-8?B?N3ltZVpnVjN4d0ovZkx2TXowUmdTakFZZjNmK0FZUTcvbW9NaXp4OEhvcm1Q?=
 =?utf-8?B?NlBsZUZSNjNIK2h4T0pIcGxzMXpoK1RLYWx1dTNjODNiYTB3NCt3ZGowbDJm?=
 =?utf-8?B?U3N6R0tETk5ROHIydkVkNGt1L0Nlem9kUm1HaEQ1WGxOZFk5WTNsUFdyTjNJ?=
 =?utf-8?B?bnFMK3V1SzhjUXRYOG9ubldKSGFYaDhKQitHSWZocFNxZTM1N0FTakloMUt1?=
 =?utf-8?B?MEIvQ2tlQkV1Unk4b0Q5K1JLTGYrVU9JWGdibGZzS3Zucmp5bGlaTk9GaXJx?=
 =?utf-8?B?WVVvZ0E2T050V3dEOGI0UmxaZCthWEhGV29iU1YxR1ZxcGdyUmNvZmNIT2l4?=
 =?utf-8?B?UFVCQXRCS1RjN3ZLM2xqc2k3OTB0ZjdyNEFIdTY3RzA5WG9MT1p3cUtHTXlJ?=
 =?utf-8?Q?fOXdRwVcUhaqvdRX/HN9cWBWYCTMPR9N?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk82R0lZSU9tQ2NlM0g0RXBldnZFbVBJcWRjb1laL2VidlVZNXNjbHlBT2Rm?=
 =?utf-8?B?RnFYN0dsQWd0WXl2dzJDaUFVUmN6c1E5UWZKaHZQZzJ0M3lNaFNFMDh0bk10?=
 =?utf-8?B?N2R3U2FnR0QyWStmYmtUOUx3bXFOU3gxNFNNazdUMWtIdEsySms3WTdJSzVD?=
 =?utf-8?B?WG4yNTEyOVJTZUtPQ0hEMjFKci9kMk9SNUFxbnN6S1RCcHRkSzNLdGZ6c25R?=
 =?utf-8?B?SnJMNktaY0tab0FKNkVYek5xM0NIVzBiS0FnRS9sbUJSNnBHUlRLWDlOcjdq?=
 =?utf-8?B?cFZVbDRTRG8vU3FFTVV3cDhzeGZ1c09zN3o3YUV1UXZockpVUlAzQldkQlJr?=
 =?utf-8?B?ejhkUkJKU1A4ZTZ2QUpwU2xFdk56UjdpTHpRK01DajN2dXh6TVkyN3BkN0lt?=
 =?utf-8?B?MlhxL1J1UlJub092ejdpTGQ1WXZiRXBFOExUeUpEekl4ci9pbmNMUUZiaTN4?=
 =?utf-8?B?d3NxQVcyeUJKczVrbDdiUWdHS1VSbDM2aXNkckU4N2RzUXlYaFFKODNzaS9i?=
 =?utf-8?B?MDRzUmNLSjNHMzZrRGNiUWVVeEVzcERlTFRQcFZ1YittdWZNVWpYMkFKeGQr?=
 =?utf-8?B?RlZ0L2ZMZ1hyRkxKaDZickRTL1BkMjdUM2NYVzZrUWh4U3NaVnMvN1hCcm15?=
 =?utf-8?B?cEZRM0hFdm12c2c5VXlpNzZDeDlyY3dGK3d2OWZDbGp4aW5yU0c2SVlTcUpv?=
 =?utf-8?B?QStCMmh1OVRYWVY4U244Snl5RWsvalBNWkJ4V3RRQjRpMTYvNzk4V2VWODZm?=
 =?utf-8?B?ZXhmQVpZbk4vWlp2Wm9BOHF4Mm9ERzAzNVhkKzNlMkV1bHptZE5RUEI5MVp6?=
 =?utf-8?B?bzFHZ2lMenNOOERBWFFzR1lTRWloN01rYVU1MGJ2SXFkaExBS3AyMlVnazUw?=
 =?utf-8?B?T0NUdU9CUDMvcWpBZlY1UEp2NHl3STY4KzNrcTliUW9hMUVCR09lN2dENDYw?=
 =?utf-8?B?WmVkZCtMV1BvdVdBVFlER3ZSNmdlWS8xeEhxSlFpOUYzM0JzZ3ZuTEs3UzVV?=
 =?utf-8?B?RUovV2Z6QWIvVmFwUm5rL2hOQ1ZwcEN3a0EveEhmbm5ueTRyUStvZUY1UXV5?=
 =?utf-8?B?RzFwbUQ3N3l4dnBJcmpGOHhVWmRFbTNZWkprZmR0TU02bUV1VDJHS1daMEly?=
 =?utf-8?B?YlRXVHBkaEZxTnY1aWF2K0ZGQWNzalZhMWRSK3NjN2JGYkNUWUI5V1MyaUV1?=
 =?utf-8?B?V1E1UnVNQmRlbHJPSGwyaGRIK3RTSE1ZRDJFeVJuWnQ4dmhYdWVFcEppV21T?=
 =?utf-8?B?ZjVSdklubmlpcy95ZUJtT3cwVEJUdlNkRHlPVFV5bkU1TldVQlBxY2J5VEpK?=
 =?utf-8?B?cnplclZOc1h5SC9ZYVgxeVhCN1ZuVm1NelFBeGZldnY4V2poZzRmTmpmUmxG?=
 =?utf-8?B?b3pBblZZMDNhRmNlenZ4aDM3RkRiYkY0cHlFVWdWU05kZE1LeXhxQ3BkdVF1?=
 =?utf-8?B?RGRibTdtUmw1VStIR1g1N0tYeW1CeE8wU1lpNjV1V0k2R1p5a0xENlpSdGJD?=
 =?utf-8?B?YThEUjZTTnYxeDJyOU1zOWxVemZZWVY3Z1lXMGhjNmRXWXlLOW9qV2luaUVq?=
 =?utf-8?B?dFcrLzZheUdFdzhNUHVKTVBSL2lVVzFQRWpnaXVrUjM5eWl0aDhjRE1wZThW?=
 =?utf-8?B?bzd6S1R5eDkyWHFKSmxjRWcrcTdIeStscFpBM28xanpETi9IV3NWSVJRb0oz?=
 =?utf-8?B?dkFGV3AwakpKSXhNazEvVHVoNW9nMHhNalpKaTB0ei9USEVpVkNvN3N4dTcr?=
 =?utf-8?B?QmFxQUZYSFdqcnQ2Rzh6MmQyazJucDB4RG43YnhNN0FHOHhGaTlXRXMxTW9M?=
 =?utf-8?B?QlVrRklDd25QRzZWR05uMkY4RFpxRUlIOVp6WG5SclZ6YTgzRmdRY0RjcHRr?=
 =?utf-8?B?M2R4Tkd3dUh4bWJwazdFaXhqTkQralFYak02dUEyVCtZV1J5UFdKUjhZa3Bi?=
 =?utf-8?B?MzhidStCRXArMThRdUhMS1NHNlBYYnRKaHljZWNMM2J4UEJvQ3JkYi9LSjVL?=
 =?utf-8?B?cEhkU1lLbUpUY2p3WDZLV0pKL0l0Zld3aTlXT0lONzRhbEhvNGhTd0d4RCtU?=
 =?utf-8?B?L3hJWkwwcG5ialpKa0MxR2t0TEkyeVA5L3d0NHhCM05jZFFPeGVHaTBxRjA3?=
 =?utf-8?Q?vzPUtcRGZ9bwJdzLc5RN5kh2C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QCv1A5kqsPl5oQZBsWes4My8EzretFHvSItgOgtzNZkL36Vf2h0+pzEPVPWa1l8a8Y5ZsN5gKOh+rWNL+dmvcVMC6NZRQfy93Muecvp0ul1RESLm6GqJuC//MQy6EACbSneDOfF5XaJ9xe4msrAN+pnrxZarwL57PHp1GY9fxh3GOA6acGchTbGwu82oVZ+VXArgOefrnLgtjoIYYQZBWHCoV1kO5brvducCHj0vcGmjkFPeveSf0310apVm+Bq8I9QPzpL/EAUNpXkhfZ8AIvyi+IDlF1qcrnxTjmIalCs6g4S5qyZw5raJnH1fhzx6g502eGyEjvJZ+BacNn9iBqJ0/P5o/ljK5c1VF4Z0upsI2+TRTBq9ZfRw0iHpSv9fnRSczOGA8994myfqnyAxMupkyHEWYhy8yAYPXHI6EJ4tdr4S9z6RjMbo2bG6g8ZEamalvd5OAjOErFxbtPAmp6Xy7dj0KwMhMxX5Nm3tvHkrqYK4F2dITucYII3i6WQDRxA4wOTorQJlIJnXLz1WWBNvRjqIYx4Qfchiwjgm2RkYFtgNGdLi9qkynHHfGOgWWRpxsACOYDEkAuu5vqKDjcb/aPJ6uS/s4ql4yV0szio82YZuCLreEPSEsE1bNSwQ
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11f9760-ddb6-4d9e-2ff9-08dd616e8b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 14:02:36.5350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtIubxjnJnnc99bKQnD6nbylCM0OvtS7M3qNtKmS0nSYv5I8kQY0Et1L15mU4xzpZfJR5qGJfS2mgn24JWObxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8288
X-Authority-Analysis: v=2.4 cv=ePkTjGp1 c=1 sm=1 tr=0 ts=67d19403 cx=c_pps
 a=Al84TKQ7ImdPUwhB59KusQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=Je83v-lnS0Boj8GAR3wA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: gHRlBQfWgWsvyMzTdJBCvOAaFL_a9vVW
X-Proofpoint-GUID: gHRlBQfWgWsvyMzTdJBCvOAaFL_a9vVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120098
Received-SPF: pass client-ip=205.220.168.131; envelope-from=sidneym@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbHRheWxvcnNpbXBzb25A
Z21haWwuY29tIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDExLCAyMDI1IDY6MjcgUE0NCj4gVG86ICdCcmlhbiBDYWluJyA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiByaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgTWF0aGV1cyBCZXJuYXJkaW5vDQo+
IChRVUlDKSA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT47IGFsZUByZXYubmc7IGFuam9AcmV2
Lm5nOyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyBh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBNYXJrDQo+IEJ1cnRvbiAoUVVJQykgPHF1aWNfbWJ1cnRv
bkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nDQo+IDxzaWRuZXltQHF1aWNpbmMuY29tPjsgQnJp
YW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMjgvMzhd
IHRhcmdldC9oZXhhZ29uOiBJbml0aWFsaXplIGh0aWQsIG1vZGVjdGwgcmVncw0KPiANCj4gV0FS
TklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxl
YXNlIGJlIHdhcnkNCj4gb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVu
YWJsZSBtYWNyb3MuDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJv
bTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPg0KPiA+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMjgsIDIwMjUgMTE6MjYgUE0NCj4gPiBUbzogcWVtdS1kZXZlbEBub25n
bnUub3JnDQo+ID4gQ2M6IGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbTsgcmljaGFyZC5oZW5k
ZXJzb25AbGluYXJvLm9yZzsNCj4gPiBwaGlsbWRAbGluYXJvLm9yZzsgcXVpY19tYXRoYmVybkBx
dWljaW5jLmNvbTsgYWxlQHJldi5uZzsNCj4gYW5qb0ByZXYubmc7DQo+ID4gcXVpY19tbGllYmVs
QHF1aWNpbmMuY29tOyBsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb207DQo+ID4gYWxleC5iZW5uZWVA
bGluYXJvLm9yZzsgcXVpY19tYnVydG9uQHF1aWNpbmMuY29tOw0KPiBzaWRuZXltQHF1aWNpbmMu
Y29tOw0KPiA+IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPg0KPiA+IFN1YmplY3Q6IFtQ
QVRDSCAyOC8zOF0gdGFyZ2V0L2hleGFnb246IEluaXRpYWxpemUgaHRpZCwgbW9kZWN0bCByZWdz
DQo+ID4NCj4gPiBGcm9tOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgdGFyZ2V0L2hleGFnb24vY3B1LmMgfCA4ICsrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jIGluZGV4DQo+ID4gMzZhOTNj
YzIyZi4uMmI2YTcwN2ZjYSAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYw0K
PiA+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jDQo+ID4gQEAgLTI2LDYgKzI2LDcgQEANCj4g
PiAgI2luY2x1ZGUgImZwdS9zb2Z0ZmxvYXQtaGVscGVycy5oIg0KPiA+ICAjaW5jbHVkZSAidGNn
L3RjZy5oIg0KPiA+ICAjaW5jbHVkZSAiZXhlYy9nZGJzdHViLmgiDQo+ID4gKyNpbmNsdWRlICJj
cHVfaGVscGVyLmgiDQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgaGV4YWdvbl92NjZfY3B1X2luaXQo
T2JqZWN0ICpvYmopIHsgfSAgc3RhdGljIHZvaWQNCj4gPiBoZXhhZ29uX3Y2N19jcHVfaW5pdChP
YmplY3QgKm9iaikgeyB9IEBAIC0yOTAsMTEgKzI5MSwxOCBAQCBzdGF0aWMNCj4gPiB2b2lkIGhl
eGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQ0KPiA+ICAg
ICAgc2V0X2Zsb2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIxMTExMTExMSwgJmVudi0+ZnBfc3Rh
dHVzKTsNCj4gPg0KPiA+ICAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gPiArICAgIEhleGFn
b25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKGNzKTsNCj4gPiArDQo+ID4gICAgICBpZiAoY3MtPmNw
dV9pbmRleCA9PSAwKSB7DQo+ID4gICAgICAgICAgbWVtc2V0KGVudi0+Z19zcmVnLCAwLCBzaXpl
b2YodGFyZ2V0X3Vsb25nKSAqIE5VTV9TUkVHUyk7DQo+ID4gICAgICB9DQo+ID4gICAgICBtZW1z
ZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih0YXJnZXRfdWxvbmcpICogTlVNX1NSRUdTKTsNCj4g
PiAgICAgIG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih0YXJnZXRfdWxvbmcpICogTlVNX0dS
RUdTKTsNCj4gPiArDQo+ID4gKyAgICBpZiAoY3MtPmNwdV9pbmRleCA9PSAwKSB7DQo+ID4gKyAg
ICAgICAgYXJjaF9zZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX01PREVDVEwsIDB4MSk7DQo+
ID4gKyAgICB9DQo+IA0KPiBDb21iaW5lIHdpdGggcHJldmlvdXMgY2hlY2sgY3MtPmNwdV9pbmRl
eCA9PSAwPw0KW1NpZCBNYW5uaW5nXSANCg0KWWVzLCB3aWxsIG1ha2UgdGhhdCBjaGFuZ2UsIHRo
YW5rcyENCg0KPiANCj4gPiArICAgIGFyY2hfc2V0X3N5c3RlbV9yZWcoZW52LCBIRVhfU1JFR19I
VElELCBjcy0+Y3B1X2luZGV4KTsNCj4gPiAgI2VuZGlmDQo+ID4gIH0NCj4gDQo+IE90aGVyd2lz
ZQ0KPiBSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNv
bT4NCj4gDQoNCg==

