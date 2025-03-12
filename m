Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EFFC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMec-0003oR-PB; Wed, 12 Mar 2025 10:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsMe9-0003jY-MN
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:01:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsMe7-0008Hy-EW
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:01:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CARHNC015808;
 Wed, 12 Mar 2025 14:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wMv/KtlporKLTf9QCWCXak1z4205n5AyYf73ncAruUk=; b=P+vmEcM3AqDa555A
 +3FlhxSw5pjb4sP5SxJ02SCq9v/QogVBIJnN1TPTGuTRny8L4OeyatOoHrSJ9azp
 XUYZmzcSSsfjlnkJ69bMPF0Xxs4A8z7OHLarA/0d1wvTlwYYoGOEpiiWbuToC8Zf
 emBq3khcztrHfyQwMV1HbLolWn0WxmfS9V1dd38+mCkXiIi0z6DaY9huxpgtIKr6
 nwZg+rSWr38utZp6QXJbZniKfoQPNEiSRZfu9NdmxGDqw5sV5TGcW1uM8EagFxBn
 WfIaYvah/57ysEiEFqdyMgp/xvE4uy2aPQbtrEY1FcFygrBrIlABMJQyyWnemS9k
 ylI+wA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2ntm6u-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 14:01:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiQWDJ5Uura9nNr0oiZVLfFdc50qH7jtd1+/4v2DoN/a2FvRRR5/bORS58nasp3wEu3LzdV3VfrSzZZ8WOrXPfJHWJGyC2esQiDJ1jnEKJ8AyPgyZ7nmTVnB2P5bBFqtSbHm5gBa2MkX0IGip6v6UAtWBSPY+sufzGBHl47IyYH4vtOs0AGaYimxh5nkWj9iGgAFxB/kzUU9HjlzA9v8cryftjpfcJgdts3vnfMV0WVBfrze8ozZm0l1GDhP9ZkqB0T0bBzk5tb2glFXAw3lepS5HS7O/DKRh/SY4DAnEkat7Sne2UvYeG6ismjw/fmM7eZMAa1hK7IHMsVzYCDm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMv/KtlporKLTf9QCWCXak1z4205n5AyYf73ncAruUk=;
 b=P6ePVEUacKltMTgWwVFJbA6OBXZs5ASwmBPGRYG52djaUowFFnqY8kFusDPXd5byf6oqyJLaSg24CHViOf1SdprasO68df4Dy1IdaBFteX5npCEOcBo2r9lpUVgMPSnoOwytcwt+CIZHWzMZPBl/tZAu2ssNcusRhDx6vmprvnAthL+dBvVXVnuIsbRJ8tMiUE91z5z/wwuAFKLSn1/0xrvtDZByWFqKepThR8RXbRfTzgT20iRE0jVDAh0eNec9NPFxGGk4nO+95owRtx85hI+6b0/nTHLScyc1Ay4qUq5CutMRyqWV59Z2nk79HTCPZrExVPBFWtFmbUXtEOkNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by BN0PR02MB8288.namprd02.prod.outlook.com (2603:10b6:408:15b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:01:05 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:01:05 +0000
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
Subject: RE: [PATCH 30/38] target/hexagon: Add a TLB count property
Thread-Topic: [PATCH 30/38] target/hexagon: Add a TLB count property
Thread-Index: AQHbimqqiyGmWj+Uck2tGY8k0SpYQ7NuqUwAgADq/dA=
Date: Wed, 12 Mar 2025 14:01:05 +0000
Message-ID: <IA0PR02MB9486634CEDBD475ED242B69EBED02@IA0PR02MB9486.namprd02.prod.outlook.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-31-brian.cain@oss.qualcomm.com>
 <00ac01db92df$12a754c0$37f5fe40$@gmail.com>
In-Reply-To: <00ac01db92df$12a754c0$37f5fe40$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|BN0PR02MB8288:EE_
x-ms-office365-filtering-correlation-id: eb021c4c-0964-4dee-9099-08dd616e54fa
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bE9sKzU0THJwS2RTTWs2emlkYjRJRXZ5ckx6TU9kcG5CRzFBc1R0cUEzZ1JM?=
 =?utf-8?B?NTVuUDIrRXZ6MHpYWUN4V0FwakIyZzJZRmswMTlHZThhYUU0c2tGZmlESS9T?=
 =?utf-8?B?bzRiekhHVkZTS2NUdjhTYXZJalQ1b0F1WEhTc2phV0U3K2hFd3pEazZ5Q1Fi?=
 =?utf-8?B?ZTZQUnRKTktONDJtRnhIRXZrQXZOa3FvRlNsS2RxQUdVK1g4ZmhXb1ZCTkwz?=
 =?utf-8?B?SFhON2FnNUxvYmE3dTBRa1BONURYVjh5UE5EU25DSHliZENCTjJQK3lFUW1j?=
 =?utf-8?B?eFNYVWI1N0RWaWhpSjBGWEM1VUFscC8rZ3NVNExLOTVGSEg2Rzh2bGhnWEtY?=
 =?utf-8?B?dmRsUEtPd2dCSks1aXV3ZW4xUWJxejVTWDdjMFJqZ1FtZlM1UThrQmlDREFT?=
 =?utf-8?B?b0tUOG1IVnozZWp6aEE2QWlDUGlmelJqQVBGSVg0akVSbVZ0WndlbCtxQW5Y?=
 =?utf-8?B?ek9YS25TMjNXSTlmQlhyT2Vzc1dMN3JRajh1eTZPSkRJZGZTS1hOYjVqRkNN?=
 =?utf-8?B?ckNHNnlGa3Z5cmExdXluV0tubjYrVjlYTWdzSHZHclZxeXQ3U1BvNlZGcWIv?=
 =?utf-8?B?MzUrNG1CNDN6MFVGY21HTWJ5MkFRaGJ5VGQ4Yk1Wc0FraU5FL1RqOElZb1JK?=
 =?utf-8?B?MFhmMGk1ZU53MUx1a216MURFYWc5anNvbTZYV2I3TDV0Sk1LVlFwMHFiTDhN?=
 =?utf-8?B?eFdCRWxMU1AvclZBcEZLandDbDhUTHd1UjFCeno4QS80V25yM0dNSUdXYnU3?=
 =?utf-8?B?SWVJc3NHM3NBMmc4ZllkUFpQT0FjcVUwU1ZSR09idExjU252Q3ZDM1BWYlJL?=
 =?utf-8?B?aFlBL2FpU2dPK21CbnZqTDhkVFZNdXl1aExTODlueVBxVkx0QjhVRzhhMlE5?=
 =?utf-8?B?SkVGeXRRR2NabVFuc2Q3VGN1YmZHVENmM3JpdVhIRlkwNHkvdENYdTBnaEVa?=
 =?utf-8?B?MG9yNXZJek1uZVQ5OVdPZFpUVGpEK1doZjl5Wkg1NVZTektwY0xuOXJjNE9J?=
 =?utf-8?B?UTdPQlZ2U1VjNU9kdmFUcWVYc0tZSk1ZaTRjaXg1dnBYMUxNMTJoUU54eTdk?=
 =?utf-8?B?U1ZudEdqeTQzNVlLVHdtaWYyTDZmSjh1RG9NZXc2cWxBNnJLRVJUV0dBNVY5?=
 =?utf-8?B?bVArUkI5bUlTWTNHdk4vc3ZsTXFCTlBtRjBuMVlTSjd3NTc4Y2J5M01sY1Vi?=
 =?utf-8?B?QTZ6d0pPVnlqVUtDVHNBQTRTL2kySXdVSzU5Z1NMcjNDRGxLV0RwNVova09Q?=
 =?utf-8?B?SUdWdEZWQk1VRlJuWFp6WUZhbTN6UXdNUWNBY0JpZkNsRXlXWGF1bDNVQ2gx?=
 =?utf-8?B?QzdOMWtlRWEyajVUNzNmNjVOc3NMRmVXblE5ZXV3SitYV1FwZTRpOC80TFI4?=
 =?utf-8?B?Z3VXYlJRa2tIZFRiZHpnN1VyZnpITi9Ldm4yNFZIM1I0bEljVXFsWmZvMjZS?=
 =?utf-8?B?SUpSemRSekp2am1ySkxGSHQvR1ZEeE1pYmVOWVdmcEFqbmpFcVBrdzhsU25u?=
 =?utf-8?B?ekVxZjNkRHk1cXFRbFJrVzA2TTBOYVRJSlNNL1VEQzRnSFZJOE95ckFFbVd1?=
 =?utf-8?B?OUtHYjI2NDVwSjVJV2tXTHRIeGNMVTFTK0tVUnd4SjNidjhPdGErU2E3SmhH?=
 =?utf-8?B?YVpManl6bXBTTUtRRms5amZEQVZZaENUMmhpNFYvYUNla0JOeEN3WUJVdC9v?=
 =?utf-8?B?b2NSNWhWOFdwd1FpOFN4YlZSejd4NGVGWUhzRVNCL1F0Ky93OTd4dzdyemFs?=
 =?utf-8?B?ZHRzZjZSajZuVHRMUmpkYlpsMVdVV2E5a1preGJMQ3JBRmczZ21FVkthV3NI?=
 =?utf-8?B?bStHQ1BIUTFFYm45K01WdWZ6SDluUDlIOHBQQ3kxYUZaaHVIM09INE95TFNi?=
 =?utf-8?B?TndvMkZzTjFhclFnVER0TWtRKzFFZ0VkcnB0R25hNDg2R1lYQXVheVVjeWZV?=
 =?utf-8?Q?g7zyOpqtEqQqHB/YPssNEJ36IjFGhOKE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFRZVk8wTjBVOS9lbWpmVWkwVmxaZG1tcytBZDg1d1BMMUFUY0lQN1dLUDQ2?=
 =?utf-8?B?THhjMXM1ekVkK2pyeDRnaVdGRWxyUHA5WjM4ZlM4R2hUZ0d6Y1lpRVhrOVE1?=
 =?utf-8?B?MkVCdXBBTS9KcGFEVjNwc24rMzU3NUFrWVExZDJZSWFwNUhsYzcwenRZRGl0?=
 =?utf-8?B?aWdweVJac1BXbGJXNzl5Myt1TXlJdjZUY2tmVm5tdmduOGpGV2N1Rkl5clVa?=
 =?utf-8?B?OWo1QXNNZGRBaFdtQUV6NDJXN1JUNGJxbXFjbnpVb2k0UDQyZ3NjSmdhYVdJ?=
 =?utf-8?B?STYzT010YTlmUUF4K1lkN0F0YS9nbkNDYUlRdE0yVWlTRys4aHcwUkdTTGdN?=
 =?utf-8?B?bzI3Q3U5bk16bHhkQ2gvWU1KV3lESHVuVGphQktTWDhHdWovS2ZOS3F4ODFn?=
 =?utf-8?B?ZXBERnE0Ymd0Qkl2bFpGeFQrd0JuK2FCUHh5NDI0LzM5bUM5aUFrN01HYmVq?=
 =?utf-8?B?QTVhanlFUFkxYUxDMjNFYTVKTEFUbHd5SllFaG1EMzdveVg1eG9lT1JDdEQy?=
 =?utf-8?B?UWkxOGxWcWpOYThyMzIva2pwK3Z4aThQRHd1TzBjS29VeTNqZ0xpKzlSYXRs?=
 =?utf-8?B?cUhXeHpTQkMvdHNmV0lQSERwVS9sS2hzMTJkdHJ2b054OENIZFpkbEJ5SnZ4?=
 =?utf-8?B?NFl3azJGN25GaHJOK1ZCZTh3K0wxNEQ5RERUSEE3VTcza0ZPWldzZC8xWGF4?=
 =?utf-8?B?WFhYZElkUnNORzlrMkpUd2w3QTY0ZmwwSW0wMXJ4V2hvejFjZGRKZEtHMUlz?=
 =?utf-8?B?MFJjUERqZUY0NWM0bnQ1UnpmdlVBRzBHSWJFMG1PY2NhVVZqaU9BZXB1MHFo?=
 =?utf-8?B?RXhMNll3Q3lSd1hzNHhack1kOTgweVpzWit0K0tOZENWcTErdmt4M3VsbHgz?=
 =?utf-8?B?K0NvRWMwSG1lREh0TEdhZ0xjLzAxV3RlTE5ISTRCMHhQT1BSRVF4UElyZTJl?=
 =?utf-8?B?dTNmRk9KaWhiK2NJSkhLNVF0YVp6d0ovY3czTGxvaWtsaENMUWV4bVBPaXEv?=
 =?utf-8?B?TVhkOVl2aVRVVjlLK00zZzUzMFkvOFdyMi80ZVJIeUpYQTkxMTd2MG43YTh5?=
 =?utf-8?B?LzZRMWdvbVFyMnFQbTQ5cURBTkZ2aVJ3S2lCTll1dEZEUitRaDY5ckpFcXlr?=
 =?utf-8?B?U1IwTis3Y1pBZXVqcHcydlZaWURwM2RxRnE4eU5Jbzl1TWIrWXJxbm5YTHI5?=
 =?utf-8?B?NytCRE0vaHNKTTlseUFQbnZNZ005c2Z4SDlBWGZsVXNnT0taNzdIWi96dFZh?=
 =?utf-8?B?SldKM2xFMGEvRnZVMUwxbGJ5ZEdWQXZ0b1Y1aE82SHowcEVsdUxhbzcyTGs2?=
 =?utf-8?B?MWF3ai8rcy8rSnk5NFVjRkI4STl3czE5ZFZweFJVc1Q3RGE3NE5MeVYxa0Y5?=
 =?utf-8?B?VytJQXdTTlNTUjd3S3g3cHliODZNbk04UXh4K3EwQ1Qvc2JSQkloUnJwTVlN?=
 =?utf-8?B?VWZqNThZZ3hucHVaZldyTTkzT0RGNkQzdVJaMW5saDlTT2hTUEcvY3dzbkkr?=
 =?utf-8?B?TDU5ZDZ3ckpQMlRQZ1NtMTVLN1ZNVlVoUTUrWi9RQnJFVzJxSkdsclg5Y2h1?=
 =?utf-8?B?R3UwN1pVYmxrS3FUQW1VMUtyQVg4RjJXNDArVnRRVjVYWUJDWmJjUURaQmdh?=
 =?utf-8?B?ZmJ4SEdCd1Y4cTJ2ME1NbmV6SXNwMktieU5tSGNjUDkrdFJabEdjam1DVVly?=
 =?utf-8?B?RmpQblVrWU5rZ1FqOUgwZWVXVE1WaFVkaHMrVmE0UVBIQWpnbGNzOUI1cElm?=
 =?utf-8?B?OU9KV2dvTFJVaWtoWi9SdDBzWEdjRkFNUmJnQUhOekJnNXJjdjV1WThuT1g0?=
 =?utf-8?B?SldYU0J0OEpKS3Yva1RNM3p2TS92VXlRcXpOaFMzZnY0L0dLaVpnT2ZlRWxz?=
 =?utf-8?B?RlJxRjJWL0ZYMFFDdTlOMzROZ1U3cy8vaGUzRS9NaFM4QjB6RVcySWhPVnUz?=
 =?utf-8?B?K2FQc2pGKzh5N3VydlBnWUZoSFl0UWtsTVNjSXlUeW5wRFllTG5PMmhaL0tV?=
 =?utf-8?B?czkxSk43K0pOMHA0U01pOFlNelc0a0lhN21SQ1hyVnVvRGVkTkMrNWxyeG1R?=
 =?utf-8?B?aWU3MUx1RWo5dVdBbnF5SDJPT01EY1BTSEc1d2IwcDdTQmxqZDVVV3hXNW1i?=
 =?utf-8?Q?bqeoake43v6TcM1nEYAzllazI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yqKpf0RpnKhiZoNjT41+WIcftA/yrK3yKF532bpHPhbEiV+WjkpIokPyfJ1zaCXBnSDqYJ67sNvxJtHrbXuR/lnQwqRr1K50bs3jSGMd5R/nhUJRHYtjFrDwz4KdPjEb3IY0YZJQx5/PsCd1Xa4jRD2xLMSC4FUWDSw06kzSChs7VGzUdvVk8FRWQ2q/leIwzTgajRc17siyL0qHZ62C2jgzj+VNpaR+UIa5JpOgdTFp2Y1l0mt2sF2zibPbGmEnEAAYxl7fwSAOMC2BTlMyeBy/FU04iypJHlOlIPWfHJq1A7qEF7tJHerdytNey7CYH6mkgVHmQfPVhLlSa7kuUYFOOkvRqIouUjO0vwQUEVww+iFZPoIjKPYg6I+GvGDvwC2mckdtQLe0dmx7nCQChfpoROea/2l0oVAFcOK/PHisfGt/SyWzd2+JCh9Y65ANqXplB5F+LqnDN4VPcrIK5r0jDOrYFKyzzJTJNxfm0hjRbq+D7m3Af1yekvecbS0EQaBSLj/vBYFm5pVz7J0qzhI1/ngffVRetPq56SX7D/kkQYmOPRMYf2yR4XqTGlFpwY4kRye61JYVFOYWL21x15QX/KNZQ0ztr+X6zYLInjZT1mJUqKOalKa26/w65LfO
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb021c4c-0964-4dee-9099-08dd616e54fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 14:01:05.5952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygWnT1AhvRSyZjaXhdQQGSMzIxriHBwJVhTXqi0A/ZuksDlNbgi2FG+d4fcjEVjYXqD6dtvg4MirYGS0cS0ydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8288
X-Proofpoint-GUID: ApgVQBs-UHiMPZlJDB0fcsdVuILuwBMu
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d193a9 cx=c_pps
 a=eoA+jwG2N97X2eoE7Om4vA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=0CFiyTV_Qat-DleIpf8A:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ApgVQBs-UHiMPZlJDB0fcsdVuILuwBMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=656 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120097
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
cmNoIDExLCAyMDI1IDY6NDEgUE0NCj4gVG86ICdCcmlhbiBDYWluJyA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiByaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgTWF0aGV1cyBCZXJuYXJkaW5vDQo+
IChRVUlDKSA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT47IGFsZUByZXYubmc7IGFuam9AcmV2
Lm5nOyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyBh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBNYXJrDQo+IEJ1cnRvbiAoUVVJQykgPHF1aWNfbWJ1cnRv
bkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nDQo+IDxzaWRuZXltQHF1aWNpbmMuY29tPjsgQnJp
YW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMzAvMzhd
IHRhcmdldC9oZXhhZ29uOiBBZGQgYSBUTEIgY291bnQgcHJvcGVydHkNCj4gDQo+IFdBUk5JTkc6
IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBi
ZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUg
bWFjcm9zLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4NCj4gPiBTZW50OiBGcmlkYXks
IEZlYnJ1YXJ5IDI4LCAyMDI1IDExOjI2IFBNDQo+ID4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zw0KPiA+IENjOiBicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb207IHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc7DQo+ID4gcGhpbG1kQGxpbmFyby5vcmc7IHF1aWNfbWF0aGJlcm5AcXVpY2lu
Yy5jb207IGFsZUByZXYubmc7DQo+IGFuam9AcmV2Lm5nOw0KPiA+IHF1aWNfbWxpZWJlbEBxdWlj
aW5jLmNvbTsgbHRheWxvcnNpbXBzb25AZ21haWwuY29tOw0KPiA+IGFsZXguYmVubmVlQGxpbmFy
by5vcmc7IHF1aWNfbWJ1cnRvbkBxdWljaW5jLmNvbTsNCj4gc2lkbmV5bUBxdWljaW5jLmNvbTsN
Cj4gPiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0gg
MzAvMzhdIHRhcmdldC9oZXhhZ29uOiBBZGQgYSBUTEIgY291bnQgcHJvcGVydHkNCj4gPg0KPiA+
IEZyb206IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPg0KPiA+IC0tLQ0K
PiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21heC5oIGIvdGFyZ2V0L2hl
eGFnb24vbWF4LmggbmV3IGZpbGUgbW9kZQ0KPiA+IDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwLi4w
ZjU5NWJjYjczDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3RhcmdldC9oZXhhZ29uL21h
eC5oDQo+IA0KPiBOYW1lIHRoaXMgZmlsZSBoZXhfbWF4Lmggb3IgaGV4YWdvbl9tYXguaCB0byBh
dm9pZCBjb25mbGljdC9jb25mdXNpb24gd2l0aA0KPiBzdWNoIGEgY29tbW9uIG5hbWUuDQpbU2lk
IE1hbm5pbmddIA0KVGhpcyBmaWxlIGNvdWxkIGJlIHJlbW92ZWQgZm9yIG5vdy4gIEluIHJlc3Bv
bnNlIHRvIHNvbWUgZWFybGllciBjb21tZW50cyB3ZSByZW1vdmVkIG1hbnkgb2YgdGhlIHVudXNl
ZCAjZGVmaW5lcyBsZWF2aW5nIGp1c3QgTUFYX1RMQl9FTlRSSUVTIHdoaWNoIEkgdGhpbmsgY291
bGQgbW92ZSB0byBjcHUuaA0KDQo+IA0KPiBPdGhlcndpc2UNCj4gUmV2aWV3ZWQtYnk6IFRheWxv
ciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IA0KDQo=

