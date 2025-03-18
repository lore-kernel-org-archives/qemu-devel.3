Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55909C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 14:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuYBW-0001w6-Gt; Tue, 18 Mar 2025 10:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tuYBU-0001vw-Ke
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 10:44:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tuYBS-0006kA-Fq
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 10:44:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICeON6030816;
 Tue, 18 Mar 2025 14:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RyqNhw43evtUPtoopAxvLN+pMyTExX1rG59oDEh++eA=; b=p6X8xeftggNl9Xts
 3VBI5Dv9Pz8iN4b+q0hCdxHctA2zsG2Jh9AgVACpB3WahFBulR4axwKjnCbRAle+
 yF8Q2E73iIiE4Ukrw+dEjdov0VIMB+aQu24s2FWBpFcmXUgxgZUNO7h2kTI1r60Z
 IvF9I2D77yJq6yQrmw06yRaJo4YCtB7q7uYgy+yujni/Cc0LQ0HojFG8tsZy2yOV
 v6GBNBjJ1tRmohpi1aroM5Oc1+kCIFV55fn1CCv/ahVgDLQGr6UxNPo1O/DS1Pk8
 WgD5TWvV3NjJS1YuwD9sQKakikhVDVX+tzm8Otms2POV5sfkYravQ6x5NlAcxMmx
 eFd1kQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t0bsa-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 14:44:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkRipRvpiMcxQrJ26QOrw4QaZe2zcg7Em3WFdOI+3KXRWStj2pakFqUKi/HWZwh5m/RUIsWCl8grXUhOMiG5dxDrkH+rGK29PKZGAwVxyHq0a9o86i8IoQe02mv3TlgCvILIw5PdTL4If0+ra66BaLIt2GFMRIuXyz4F1vGm2lItp21RRVVImYQQRgmFs+v8FKU+EW2joEuvNtV/SAr7x1I2tGPHg1uoX9lc78cXWQIaR377wEXyQ+M2aybpUISu2oLDoMBozrGx7kJzQqtRJhiCkUB8ojye6T0G52tASyCQypZvRNauFIrWvRycADOBsaxoghuhARqwYNqnMj+3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyqNhw43evtUPtoopAxvLN+pMyTExX1rG59oDEh++eA=;
 b=XYU5eCSH2kGL1876voUIyn7gKq7Sy8mRuoKFagTXg4+y7IJ9MSddXxt791TQuFhK1N+X/Ql3LpU7roVo3YC4rrQAgDKLfiDZkUHDrYTMQ0+1B/rbJ6RHtbvx1hV2hy4VgsWu6hkIlHsW0u7iISlkD/MCN3L8D4uT3cSw4xwfaRdkdNc4EAaS/7RavUSoUQ9tYpcT86s5WP/YW7pdOcKpL3PZ9JCd+XwcDRdY8Zln/RhWM5UQbhaIuwLpryzwHpLUGSDisKS+DCsUMU4puwGqEF/WhzAtioN57GDafBAYS16rgv76Gyl9Ju8p3lm9BGCgC7nUnasuFttS68AvkWrE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by SA1PR02MB8446.namprd02.prod.outlook.com (2603:10b6:806:1f5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 18 Mar
 2025 14:44:34 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:44:34 +0000
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
Subject: RE: [PATCH 01/39] target/hexagon: Implement ciad helper
Thread-Topic: [PATCH 01/39] target/hexagon: Implement ciad helper
Thread-Index: AQHbimrU4TBYeOZDEUm6Uqf0b/n4/bN3mMWAgABpkCA=
Date: Tue, 18 Mar 2025 14:44:34 +0000
Message-ID: <IA0PR02MB9486B49FCC51238C5C50572FBEDE2@IA0PR02MB9486.namprd02.prod.outlook.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-2-brian.cain@oss.qualcomm.com>
 <016201db9756$cee11240$6ca336c0$@gmail.com>
In-Reply-To: <016201db9756$cee11240$6ca336c0$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|SA1PR02MB8446:EE_
x-ms-office365-filtering-correlation-id: ba68bc86-5a45-4ca4-d1ca-08dd662b6649
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Y01IbWFCcmxGWUpxOFhWbFl1eTNLaGNvVFpoaWlnUW0vM1RQNXNyZzd3TkFt?=
 =?utf-8?B?VkludXc3K25aenh2OGRGWnJBZnNSaERna1R2RGFSdUxYY3VmOWhROGRFb25N?=
 =?utf-8?B?UmREMkVNbDYvWDNDeGYyL2tZSHFSWXU2NkIvNGtobjFsTFVTei9mV2E5Wkp6?=
 =?utf-8?B?NGdEaklZaFNuMlEzN2N0UzkwOEZTVEtPbC9KL2M1WGNZYUtRYWM2N2prTmFu?=
 =?utf-8?B?eXRXQUk3ME44Z3o1NmlyUkNKVUNSZGtZcjRycU1ST3dDQ1RlU3JVN09ZN1Mw?=
 =?utf-8?B?Zkp5VkZiNGhPSWRISHdpa0ZGanJZRTJhZnJJWGcrNENod0tobEJxN040ZGJa?=
 =?utf-8?B?K0dubTBqOFlNcHpROFp2bVdUQytmL1I0ZzA3WFkxNXhSRlBlQVF4a3JRa3RC?=
 =?utf-8?B?Z01PbkJ5WkVxQWs1bUFRV2FrMms0eVRSM1hiUVNsRzcremx4T0JzNXZmTVpJ?=
 =?utf-8?B?YTdIRlFQL2ZKVlc2Y0M5dmlXcEdvVmtmdVhRRDZ2Zm5UQTRIWm9sY0xOcGlG?=
 =?utf-8?B?UUJMUjdzb2dNTTJRRGpzMmNpdG10VXdJckl0NVg5TlRaTVVaSGNReURWczhO?=
 =?utf-8?B?ZGhuK3h0bVZtSGhBRytCUkpmb04vZW5SaWNGc3NvdGFodGY1dkR4U2I2d1JJ?=
 =?utf-8?B?L0lwSndJc0JGNllDTGZzN1hhVVRmY1VLNWZoWUNXa3B3dmMxOGF4ZDJWamR6?=
 =?utf-8?B?S1h0d0NDc0tUdEppdEw3MWJzcWRqUWY1bGtwSU9VRVp2cW1NMi9YNE5SNTY5?=
 =?utf-8?B?NDVpRjMrcEJUQ3JKVUcvaVJzQzAxYkpvT2FFemhpVG9ZNitRS1Z3Y2xoci96?=
 =?utf-8?B?RjRud2p5ZjhzQzFmOXp5d0VkWUNIcjQxc0NQSjk1SDNENTRKWG5FK1NhODBV?=
 =?utf-8?B?bVlxc1F4b3JuZ1JqOE1XTjN1MExya0dtR2krOTAxektkQ0lOWmZvS1F2YkVo?=
 =?utf-8?B?MXkvcGFXMGxZeDNwL1lyd2xnYkJMRk0zd2I3M0NHNzhxeFpadk9nQUFnU1RY?=
 =?utf-8?B?VnJNTVFaNWMwVlJxSG1QazVMYVplbzBqeGZmNk05ZlVjWHkybGgvNW1nd3RH?=
 =?utf-8?B?TklTTmhpdk9RQmptSTRwWjJZS0xqYmMxZ1lmMm1nR05veUx1R1BpWmtaWlFW?=
 =?utf-8?B?ODBYOGRXZkxWSXlHWS8zYTN4RmtJYkdKNEh1NVRaVUIvSEREbGFIbzkzMmFS?=
 =?utf-8?B?WXNadzI0UVA1RHVCSTRpdUsra20rc0p6N1VlL2hKMXM2bklHUHkvNkJEUHla?=
 =?utf-8?B?MWNwNmFlVDlXVjM5cEhqbXBGQysxSGU3WElCWm9aam1acTFjb1NSUE5pSkhD?=
 =?utf-8?B?VDhXdXhIclVJaHg4U3lzdEVqb0pWMG51MWZYOGRKUHBnZFhTbzdGU0ZKelZJ?=
 =?utf-8?B?VCs3ZDFJU1hKeDhPRi9UanZkVU9iZ3NqTjdsZWZBTDFUa21uekpiY1JLQlls?=
 =?utf-8?B?VE5iZzVBRVd2SENTNzB3WUUrSkEzWS9KMHI5dXZISmxVNVN1YjFndGxNTlpw?=
 =?utf-8?B?OFdYS0ZodmZnN29TNmlneHZVTTIwZXBxdUFBMkZhY0t5NkRST1laVWdUUHRm?=
 =?utf-8?B?alQ4TTlMbFFZM2lIcTdnRGJuelpHOE9SclQ3ZDFGUnJJcFJZbjJBMWxKUjBo?=
 =?utf-8?B?NU5vR1kxN001dU9HRmxxdGo3UlhMNjNtWUZQVGNORUVWM0hjVnh0MXQrWVlT?=
 =?utf-8?B?RGhBOThDRmpTZElvbzVLb2I0dUkzeE1oYVZFdkhuVXkxRDJzTVhmRlRIYW43?=
 =?utf-8?B?WS8vcm5PZi9EaldtMmRzRyt4QmhNZE9KQnVDbXJjaW5hdE1rNUdsL1FTMTN5?=
 =?utf-8?B?akJUYUhqS2xTUUVnZC9Bd1RSTG9VQ0MyVy9ncmphcElGVzU4cDJDdXpsY2J2?=
 =?utf-8?B?NjNvZkdYRlZ4M205WnY3TTZXYUEwcVc4WkltNGlUU0E2SEhZa1FhcG9CNFlM?=
 =?utf-8?Q?DSI8a87B6VwS/7Zg11+hiIa4w0l3PGKJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG04dWl0MXhWMk5vNk5Gd3U5KzlkMG94dlNtdXp6KzNSQ252RDluaTBsL1NI?=
 =?utf-8?B?RjRqZzQycDgyMDI0VDVKL0NYWGJlUjkwNnljK2NvK2JmOVk3U20vRG15K05X?=
 =?utf-8?B?K2htVCtKSjFyREJ5QjR3UnZQTEtnN3ZBY3QvOGlrQVFyRlF2UGFOZDBaUHZa?=
 =?utf-8?B?VXF1RVhHRzJWOUJpajlWVXp2QkhyLzg3aEQ2REp6V1p6ci9rMS9qM2piUGQr?=
 =?utf-8?B?eGt6RmsrYytkYWFpVXZ4YnJILzd5Um9JbytWbmp5QTFHa3pPTDcxQWlOd3hp?=
 =?utf-8?B?OGpMbDg1VXozcW1pOGlKV1Bkd2FiRERKN09PRUpiaGVaQThtK2ZqUnVDbDB1?=
 =?utf-8?B?Y3VKanM0a2IvR1ZVTXREbjNiT1YweWFXMDRCeUtobm1NYnIyQ2RsMWRxU1Vi?=
 =?utf-8?B?WEoxeDZtRyt1N1p3OHFJNHNZQmtHVXZva016ZWlYemxOU2pCSVB5SUhpWTRO?=
 =?utf-8?B?SGtBTndLRGZTVkwvc0gzT1k1TXMrb3lIeDMzcThHTHF2K21CSXJneTRQU3R4?=
 =?utf-8?B?dWdzbDBaeXNRY3RldHhBZUFYTS8xZXUwYlBBUStMM2krSlM1SnJZK3BJS2wy?=
 =?utf-8?B?QU1DZWEwcjVDTFZ6aEZmeXFhSnphc2tScCtTUW8zV2I4cWZNV3BYSjFaWHJt?=
 =?utf-8?B?bEE3VGZ1ZXZFSlVLSEJ5KzNwSzQzWXRqU2tLdTJEYnAvM0NLN3RaUUVnOFhZ?=
 =?utf-8?B?ZlFnRVE5Y1hwdWlta3RzbTVZUFVrc2xlVGl0OEVTeFNKOTNZWHVnWkRQbmND?=
 =?utf-8?B?MmFEOTJHL3ZSRFVvT2FKTTdCRi9KVXBMS1U1WmxUR3J3TXdEY3RpbkZxSHZ6?=
 =?utf-8?B?SStEMXkyWHdXTlR2U2lNN0p5UmZrTXh0czZHTlV4MHBIS2hJamxmc1haVlA1?=
 =?utf-8?B?eW9VN1dPdGZQTEUwK0tvSGJxNFFLenZJV0JKYk5Xa2NkZ3g4eTZyR1JIT3VO?=
 =?utf-8?B?dEdybnZYcVdYSWZ6b1czanE0R081VzZFWnB6K1ZNYm96OWhtQVFCN1lSQTYr?=
 =?utf-8?B?cThHNnR6MnZjV2xPUHJIb1hNcVRGdkNKWTkzTnpXbGJmQW0wck5ZN04weVA4?=
 =?utf-8?B?Wmw5aDZkWVJuM1NQY3hLN3dHVG16ckplaTNoOWRYTGZjRFA2ZzM3L29Pb1A0?=
 =?utf-8?B?NmFvS1RwQWQ3QnV0eFFUeVpDNmpkamZ2NUJyTkt1RkVpa0s3TDJicmd1QkQx?=
 =?utf-8?B?RVBERklCWVVHaEdMOVkzK0swcmxXQndIV0xXYW1vbzNVdjI3RVB3Yk4xbzNx?=
 =?utf-8?B?VmI1cUoxL09GZTc1MUhtM3p3QU0yN0lSQ3hoK1VrQkFRK1JvNkprK3hmQ1Ev?=
 =?utf-8?B?WjFGclNZU09la0xlVVlHQllNWVZzZkp3aHZadUFyb211bHNDenJPTWM4TXlI?=
 =?utf-8?B?OFFIY2Nqamgyd01lYUJWdW82N25iYmxUbXJMcG5PTUxUODg5WVZmZlhyOVRH?=
 =?utf-8?B?eHUxL0NHT2EvNWUrMHNYYU1nL25PNW1HblN0enovVVVGUVNTVXRwN2wxR1Nh?=
 =?utf-8?B?ZVcydDA3WlVxT3FCRllwd3B6RnVTMnBudS85LzkxVjJ4TlMxVWRwbVBhaWhS?=
 =?utf-8?B?U0RlMk94enNJQkpVekJMKzNUUndTcUxtUE1JejhESS9XZ1J1ejJjQnJDb3Ri?=
 =?utf-8?B?ZFMzMWpxQzIway92aDJhTnpEWTVCbjdOMHBWQTdKUHBlcHFENXRoelF5dC92?=
 =?utf-8?B?RUxYdUdiN3VkRlhWalFUelBXS1R6SEcxMnkveFYyZjhoc0lXOVhFN01yaEYx?=
 =?utf-8?B?TE5GdUFsVUtJL1lEME1tT3l2Qm9zaG1GbDkyNkdmbG9Vb3RWRlMwR1pFaHI0?=
 =?utf-8?B?ZXpkdVJ3WWh6alJwVmZJTHRxT3dQYXk4NGJiWnhSbk9wRHA2dXljVUFRNzd5?=
 =?utf-8?B?NG5PaDhFNG5iSllwekVTd2JNY3ZRckVucVZCSGZWcUUxMDU5eEJrdUgrKzd1?=
 =?utf-8?B?aUh2YmJRcjUyZlNkclpsUUMvcWFTdDN3M0I3K01jMEpBanA0cjFVYzJMeU10?=
 =?utf-8?B?OTdBeXZlYjlFY0s0NFRnbVVLN1ZSV2JYRjQrMjlwa2tkOVNFMERYYjF2dGo3?=
 =?utf-8?B?QlV6c2VyL0JDWFhBUHJ5OXIzSDdXTG9xMmFTcFRZNlorMTJZV1hWRkxjZDdz?=
 =?utf-8?Q?o/QkO3J5B4tFI46U6x8Rxg7sD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SCiU3srH7+5o6C/SK8wTj7Zs537onrMcm5h2TWk3mPZ4TY7XmxF0JsAbvgOCj31LDVVrm8SQd2qM8u1EV7FxYOTMrRHhdjYYnXM+OE1bDZBKjiA+GWvGVdh6qsXz5Xx31ahZ8kbOXauhW2yEfQ+RJvSMft8Y1Lb6iy6Q8eOCPYIxCpcYSLTACKHY7OnuAPuAad4ml4CgzJoaM5mRM85lSbRiWOSXig6wcyQQNQ1BE7QYBx97nEQ+ogLNvCM3Xt51yNqeffwgTq0XnJlcTjpNrTvXWBc0StAdc0b2e44C2gIak2r30B9ougelQyWd3bRjg3kUbNVtyI1n9dL6Ga0s6LDC8zFn/mg995yx0VXH37SaaSvfkkVCPCXq0Wffoye85gKZYOqVrpzDOlbEIjeJMokMy7yRo8ryEYImHtVcHoW+yykiwWPZf/Ad/84ZhZXBSd7p1BqivH4b8EGYbnnXAJNtasMo04nfMQc9qpPd9+yhTJNZOzXruConbjObBxlII2iyGEKEJU8Qde9e6YnuEtPuSlrmecAYHe43anGjnRwCjRpIM98UTFNIC1Rmz2JclIH9IIq+hinsTa+DyHIrh2htmCIaUOqrKSxIjBc/AxXTdvQ9KJNskTRxJtO4Dirx
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba68bc86-5a45-4ca4-d1ca-08dd662b6649
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 14:44:34.0722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgpDPijbYa2CZdpN/AqEd02EQ5EIvkRzTJqEvkd2aZVQzlLeIUcyp8lmtEfuHlJuKb0e9U6SJ1mAtpcQZnsLhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8446
X-Proofpoint-GUID: aPsU7ood4IGjIgVGHMVKs5CQVv7jpjo9
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67d986d8 cx=c_pps
 a=di3315gfm3qlniCp1Rh91A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=at0bhs02LLflEQY2P9UA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: aPsU7ood4IGjIgVGHMVKs5CQVv7jpjo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=874 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180108
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
Z21haWwuY29tIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFy
Y2ggMTcsIDIwMjUgMTE6MDggQU0NCj4gVG86ICdCcmlhbiBDYWluJyA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiByaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgTWF0aGV1cyBCZXJuYXJkaW5vDQo+
IChRVUlDKSA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT47IGFsZUByZXYubmc7IGFuam9AcmV2
Lm5nOyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyBh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBNYXJrDQo+IEJ1cnRvbiAoUVVJQykgPHF1aWNfbWJ1cnRv
bkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nDQo+IDxzaWRuZXltQHF1aWNpbmMuY29tPjsgQnJp
YW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMDEvMzld
IHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgY2lhZCBoZWxwZXINCj4gDQo+IFdBUk5JTkc6IFRo
aXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3
YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFj
cm9zLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIEZl
YnJ1YXJ5IDI4LCAyMDI1IDExOjI4IFBNDQo+ID4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0K
PiA+IENjOiBicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb207IHJpY2hhcmQuaGVuZGVyc29uQGxp
bmFyby5vcmc7DQo+ID4gcGhpbG1kQGxpbmFyby5vcmc7IHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b207IGFsZUByZXYubmc7DQo+IGFuam9AcmV2Lm5nOw0KPiA+IHF1aWNfbWxpZWJlbEBxdWljaW5j
LmNvbTsgbHRheWxvcnNpbXBzb25AZ21haWwuY29tOw0KPiA+IGFsZXguYmVubmVlQGxpbmFyby5v
cmc7IHF1aWNfbWJ1cnRvbkBxdWljaW5jLmNvbTsNCj4gc2lkbmV5bUBxdWljaW5jLmNvbTsNCj4g
PiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0ggMDEv
MzldIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgY2lhZCBoZWxwZXINCj4gPg0KPiA+IEZyb206
IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPg0KPiA+DQo+ID4gY2lhZCBpcyB0aGUgY2xl
YXIgaW50ZXJydXB0IGF1dG8gZGlzYWJsZSBpbnN0cnVjdGlvbi4NCj4gPg0KPiA+IFRoaXMgaW5z
dHJ1Y3Rpb24gaXMgZGVmaW5lZCBpbiB0aGUgUXVhbGNvbW0gSGV4YWdvbiBWNzEgUHJvZ3JhbW1l
cidzDQo+ID4gUmVmZXJlbmNlIE1hbnVhbCAtDQo+IGh0dHBzOi8vZG9jcy5xdWFsY29tbS5jb20v
YnVuZGxlL3B1YmxpY3Jlc291cmNlLzgwLQ0KPiA+IE4yMDQwLTUxX1JFVl9BQl9IZXhhZ29uX1Y3
MV9Qcm9ncmFtbWVyU19SZWZlcmVuY2VfTWFudWFsLnBkZg0KPiA+IFNlZSDCpzExLjkuMiBTWVNU
RU0gTU9OSVRPUi4NCj4gDQo+IFB1dCB0aGlzIHJlZmVyZW5jZSBpbiBzb21ld2hlcmUgZWFzaWVy
IHRvIGZpbmQuICBTZWUgcHJpb3IgZGlzY3Vzc2lvbiBvbiB0aGlzLg0KPiANCj4gSWYgaXQncyBv
bmx5IGluIHRoZSBjb21taXQgY29tbWVudCwgaXQgd2lsbCBiZSBsb3N0IHF1aWNrbHkuDQpXZSBj
YW4gbW92ZSB0aGlzIHRvIG9wX2hlbHBlci5jIGFuZCBleHBsYWluIHRoYXQgY2lhZCBjbGVhcnMg
aXBlbmQuaWFkIGFuZCBoYW5kc2hha2VzIHdpdGggdGhlIGwydmljLg0KDQo+IA0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPg0K
PiA+IC0tLQ0KPiA+ICB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDM5DQo+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+IC0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAzMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMN
Cj4gPiBpbmRleCBmZDljYWFmZWZjLi5iMjhhMThhZGY2IDEwMDY0NA0KPiA+IC0tLSBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jDQo+ID4gKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMNCj4gPiBAQCAtMzQsNiArMzQsMTEgQEANCj4gPiAgI2luY2x1ZGUgIm9wX2hlbHBlci5oIg0K
PiA+ICAjaW5jbHVkZSAiY3B1X2hlbHBlci5oIg0KPiA+ICAjaW5jbHVkZSAidHJhbnNsYXRlLmgi
DQo+ID4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiA+ICsjaW5jbHVkZSAiaGV4X21tdS5o
Ig0KPiA+ICsjaW5jbHVkZSAiaHcvaW50Yy9sMnZpYy5oIg0KPiA+ICsjaW5jbHVkZSAiaGV4X2lu
dGVycnVwdHMuaCINCj4gPiArI2VuZGlmDQo+ID4NCj4gPiAgI2RlZmluZSBTRl9CSUFTICAgICAg
ICAxMjcNCj4gPiAgI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMw0KPiA+IEBAIC0xMzM4LDkgKzEz
NDMsMzYgQEAgdm9pZCBIRUxQRVIodndoaXN0MTI4cW0pKENQVUhleGFnb25TdGF0ZQ0KPiA+ICpl
bnYsIGludDMyX3QgdWlWKSAgfQ0KPiA+DQo+ID4gICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0K
PiA+ICtzdGF0aWMgdm9pZCBoZXhhZ29uX3NldF92aWQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IG9mZnNldCwNCj4gPiAraW50DQo+ID4gK3ZhbCkgew0KPiA+ICsgICAgZ19hc3NlcnQo
KG9mZnNldCA9PSBMMlZJQ19WSURfMCkgfHwgKG9mZnNldCA9PSBMMlZJQ19WSURfMSkpOw0KPiA+
ICsgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOw0KPiA+ICsgICAgSGV4YWdvbkNQVSAq
Y3B1ID0gSEVYQUdPTl9DUFUoY3MpOw0KPiA+ICsgICAgY29uc3QgaHdhZGRyIHBlbmRfbWVtID0g
Y3B1LT5sMnZpY19iYXNlX2FkZHIgKyBvZmZzZXQ7DQo+ID4gKyAgICBjcHVfcGh5c2ljYWxfbWVt
b3J5X3dyaXRlKHBlbmRfbWVtLCAmdmFsLCBzaXplb2YodmFsKSk7IH0NCj4gDQo+IENhcmVmdWwg
aGVyZSAtIGFuIGludCBpcyBkaWZmZXJlbnQgc2l6ZXMgb24gMzItYml0IGFuZCA2NC1iaXQgaG9z
dHMuICBDaGFuZ2UgdGhlDQo+IHR5cGUgdG8gaW50MzJfdCBvciBpbnQ2NF90Lg0KW1NpZCBNYW5u
aW5nXSANClN1cmUsIHdpbGwgY2hhbmdlIHRoaXMgdG8gYmUgbW9yZSBwcmVjaXNlLg0KDQo+IA0K
PiA+ICsNCj4gPiArc3RhdGljIHZvaWQgaGV4YWdvbl9jbGVhcl9sYXN0X2lycShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QNCj4gPiArb2Zmc2V0KSB7DQo+ID4gKyAgICAvKg0KPiA+ICsg
ICAgICogY3VycmVudGx5IG9ubHkgbDJ2aWMgaXMgdGhlIG9ubHkgYXR0YWNoZWQgaXQgdXNlcyB2
aWQwLCByZW1vdmUNCj4gPiArICAgICAqIHRoZSBhc3NlcnQgYmVsb3cgaWYgYW50aGVyIGlzIGFk
ZGVkDQo+IA0KPiBXaGF0IGFzc2VydD8NCltTaWQgTWFubmluZ10gDQpMb29rcyBsaWtlIGEgc3Rh
bGUgY29tbWVudCBhbmQgY2FuIGJlIHJlbW92ZWQuDQoNCj4gDQo+ID4gKyAgICAgKi8NCj4gPiAr
ICAgIGhleGFnb25fc2V0X3ZpZChlbnYsIG9mZnNldCwgTDJWSUNfQ0lBRF9JTlNUUlVDVElPTik7
IH0NCj4gPiArDQo+ID4gIHZvaWQgSEVMUEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKSAgew0KPiA+IC0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gPiAr
ICAgIHVpbnQzMl90IGlwZW5kYWQ7DQo+ID4gKyAgICB1aW50MzJfdCBpYWQ7DQo+ID4gKw0KPiA+
ICsgICAgQlFMX0xPQ0tfR1VBUkQoKTsNCj4gPiArICAgIGlwZW5kYWQgPSBSRUFEX1NSRUcoSEVY
X1NSRUdfSVBFTkRBRCk7DQo+ID4gKyAgICBpYWQgPSBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5E
QURfSUFEKTsNCj4gPiArICAgIGZTRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQsIGlhZCAm
IH4obWFzaykpOw0KPiA+ICsgICAgYXJjaF9zZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX0lQ
RU5EQUQsIGlwZW5kYWQpOw0KPiA+ICsgICAgaGV4YWdvbl9jbGVhcl9sYXN0X2lycShlbnYsIEwy
VklDX1ZJRF8wKTsNCj4gPiArICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7DQo+ID4gIH0N
Cj4gPg0KPiA+ICB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgbWFzaykgQEAgLTE0MTYsMTENCj4gPiArMTQ0OCw2IEBAIHN0YXRpYyB2b2lkIG1vZGlmeV9z
eXNjZmcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90DQo+ID4gK3ZhbCkNCj4gPiAgICAg
IGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBo
ZXhhZ29uX3NldF92aWQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG9mZnNldCwNCj4g
PiBpbnQNCj4gPiB2YWwpIC17DQo+ID4gLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+
IC19DQo+ID4gLQ0KPiA+ICBzdGF0aWMgdWludDMyX3QgaGV4YWdvbl9maW5kX2xhc3RfaXJxKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdA0KPiA+IHZpZCkgew0KPiA+ICAgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiANCg0K

