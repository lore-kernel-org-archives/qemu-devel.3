Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4017C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPPs-0007d4-W8; Wed, 12 Mar 2025 12:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsPPl-0007cF-2C
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:58:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tsPPh-0007nS-5A
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:58:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C9Y1aD015350;
 Wed, 12 Mar 2025 16:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8MBZMUb8ukjaJO3HZlD4j65r9dmsWMC7KoY51554mX4=; b=adnkdBXzIOY0mei0
 TekvhWIdpK9F+mBNjPofMTz7Pfsa8hm6PSYDgmAZxbwIftsQdF0lHsbiBaks1RWT
 Dpv8m0f2HdcKBZNE2oopyvOhzD5vz7yjQ44380QypZQ65uySQtYnY3+wQyhtr+vk
 ons7rRQjNNjyXfqeX3/ezG3Xej2zUjG3fKd4dpgLQ2h32WD0p7giKwwpC/HHjSkA
 QT0B1mRVNw2f+cMFJ2b75btqP8BcFzBpkIOwgqX6Om6QLCaLXJVfRII3xQT+qBcK
 fG1RUR0s3GREDtfQZRvjOD9cuHIoQxQslVH+QAagVzMTNX3U0OgpvjFa0rEMlysr
 BfLtLg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17012038.outbound.protection.outlook.com [40.93.6.38])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nu459-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 16:58:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCJUv3SNpj8Qi7pSrusBumQAblNDSg95NIkUWhlTlNx+2Abt4AHfV0nNrOcpeuvkd+msxp4qzdq3UbLyRfW8rnUbQ30oy8E7eyPSDOVujhqeQxj9pK2A/TWlfswLiBUTj+zQN5yJ0WwR0QaokW03mbp3XJhrKFqWJcC1MFcfaPGAwbR7wc6VHjGzi+nXuPmee5hP0QnuOm3vSbQhalhMZZ7czfovIyCHkvilqfVtTZCZ44gZvyJ/4DUHkDYxw6yEMRPwcN5gOYPdNa4D4BfxD6aU/MxG9hmUMwhI2PGHBR1vYa7PkxoxOn/gqihsAltStn4zvuHo11bZlGcIk7otRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MBZMUb8ukjaJO3HZlD4j65r9dmsWMC7KoY51554mX4=;
 b=naOmSIsVTsLM5usenb/uSgvN4Zi9wAYyvoEqF0jEC87UqAZRlY3ikoHo6WW+vrKr+Afm4HNlkArE70F1ScdR/5mTD8QNJRhXGSlWXAiyJhrNIMOTwC+btPETO6rqP9OEW+YlpBhPQJsV4+O0ofD+8SaDzY12HrL3GL4yIZfHoL3OU1ONEUdcVtIrxGL+ePj/RpzVEgxQIYcpVENbzrJrSfLNJRsAV+lEGonjzbbTkisRhB5yA4+tizilHQ/jijPJKO4Fqf51vDBE7nx/RJ3M3hhxF16D3yqBJyrm2F9LBMFQaT67spsBZm1UryMV9SnulP9r3JSweBb0lDSfpACJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by IA0PR02MB9605.namprd02.prod.outlook.com (2603:10b6:208:3de::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 16:58:28 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:58:28 +0000
From: Sid Manning <sidneym@quicinc.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>, "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng"
 <anjo@rev.ng>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "Mark Burton (QUIC)"
 <quic_mburton@quicinc.com>, Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 31/38] target/hexagon: Add {TLB,k0}lock, cause code,
 wait_next_pc
Thread-Topic: [PATCH 31/38] target/hexagon: Add {TLB,k0}lock, cause code,
 wait_next_pc
Thread-Index: AQHbimqncW7260tyMESV+AfIz7Q/IbNvyrkw
Date: Wed, 12 Mar 2025 16:58:28 +0000
Message-ID: <IA0PR02MB94860B33B023202934C9B93CBED02@IA0PR02MB9486.namprd02.prod.outlook.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-32-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-32-brian.cain@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|IA0PR02MB9605:EE_
x-ms-office365-filtering-correlation-id: f941b0bd-81f7-4724-7ad9-08dd61871c5d
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YVYzTFdNMVVWQjFZQUVHWll4TXRCenNaQWxWWTJML1BacUZ6VkhYR21HaXgw?=
 =?utf-8?B?djdyUlVZb3NzaXRxNUhDMENzcFVzZEpLdXFHWURTL1lUcE9aWXVCQ08zTU42?=
 =?utf-8?B?T3l6VllUbW5VSFlMR3R1Y1JmbW5NYlVDVFNOMVdabWlHMitRKzM3U2RqTkNq?=
 =?utf-8?B?eVZCbDhtRkZlQlh5SUZaTENyd1VyeUVaQWxFOVhhc2VsT0dpTHpuNVpmcmN1?=
 =?utf-8?B?WG5aOHUvckQ1am1uczlPQ2hxc05wVU9xREJtcTNySjJtYjFwWUVwdkcyTEtU?=
 =?utf-8?B?KzlFNThpWHlndGZTVjcwaHNIc0xFWmM0TXJJaWtzOGRaaEhQYVRUZVE1Nmhw?=
 =?utf-8?B?VjA1R3JwbkpGNWhRVHl4cGxPdWh5eUJjeWpOcGhMczRHck5laStDaFNleUh0?=
 =?utf-8?B?c0dPeXFZbmNUTmlBeGRrRFJ3bWVLOFJ5a2FQNmpDYUpOS3NSdWF2bEdtOVli?=
 =?utf-8?B?MnJBeXI4RzR6TFlUZFhudkhJTUZLZUR2UUxlNi9lU2NtajY1dEVPQlhyU1NM?=
 =?utf-8?B?Sm8zV1VjVG5ORVhZWS9DeE9VT09xL0ZCbjRpeWJES0Z1YWhtWGVoZVFCMW9E?=
 =?utf-8?B?WUY0VGlKZHFDSVplNzRtSVdJb2RXZkliY1M0dUIxQVp4am5VNEpGM0ZVN0pY?=
 =?utf-8?B?Q3V0Nm5jb2drSTNFN1hGd1JWOFFCQWkwRHRxTWpDNmJwNndnbFdZaCtmS3Zp?=
 =?utf-8?B?bWx4MWhXWHZxU0dLVHJxeEhMZEE3ZThIVGtVK29GNmljcEpDbGNjVnJTKzB1?=
 =?utf-8?B?TGxnOTQ0ckNmK3NuTHpEWlpDWTJ1Vk1VbXdGNExPbjczam55STFhcnpvb1Bm?=
 =?utf-8?B?ZGRJZHFoMWxqR1JwL090WkllYk5PZytRNFRiN3dqMmlpL25DNEhBNlBPTGJr?=
 =?utf-8?B?MjVoeFAvcWdFMlF6ckRKOUtyQ2VkMloxWkxCb2JsVVJuNWljV2g1TDgvNDFs?=
 =?utf-8?B?TTk3UVFTUDN3OWJVR1EzTmUzTWZwcmlaS3ZoUnhKVUJPb3QyYjdSMlBOMHdU?=
 =?utf-8?B?TWV4cDNiaTRVYVZPa2l6bVg3SVZZWkk3MnJLVHdRM3Y3UkplNnVNd3hZYm5q?=
 =?utf-8?B?NmlUQVdCbURjWCswaWNVYldmQ0w5WUlxeUtsNGR0b1JHUXZJTzIvNnp6NFIv?=
 =?utf-8?B?dUZOWmc5NlM2STJDU2xxT0hCNWxWNGVsSithUEdlVW5FcFFpeVNzbkRTeXBL?=
 =?utf-8?B?cXNLQWhYanM1UlVFMkNUK1JtV0hzaGU3OUQyTmlKbXZabC9pZ3pZQlgxb3pJ?=
 =?utf-8?B?L3NPYWNRM0JmOE9CTVBzR0NDZXMvTmNyZ0RNV05sSG54bHdtcTkrQlVtcFB3?=
 =?utf-8?B?dU1RWStVeFloZk9LazRsOU9hVG8yRFpUaVdsZW5iUU50Zjg1SGw0Z0dvaFFa?=
 =?utf-8?B?V1dxOTRvWnRVVE9iZTcwMEdBMWdhaC80SU5FK2N2NEJWbGJRUWczVkdGZzE2?=
 =?utf-8?B?ckVVTUR6QUZIaEN4MEF1OU9ydHJOdm9SNEJMMHdSK0k1MFhMRy9rVmZIQmJK?=
 =?utf-8?B?U0hwSEpKYVl4aFhZUnhNN3dKUHdCUlRDaVFNd2tIS2VOdmpRUUwrYnRyUlVQ?=
 =?utf-8?B?TDlucTBvOEU3RkNSTFpOZ1c0UDc0cjd1RDNLSG9aUzhZRU9ueTVVd05MbXFB?=
 =?utf-8?B?aVVKVkR5TFlPb3h6ZWo5U09WK2NGRkJFRjVESnJIdW5JMCtLaWpSMnFRc1Zh?=
 =?utf-8?B?cGk4cGxwZ2ozNnpUeGk2eGpRRExxalRaSjFCM2lJbkViSXVhRTlGLzFRMEFy?=
 =?utf-8?B?ZXEwTXJiWm8rL1lYQVVwUk94U2dTQ2Nid283TWVDdlM4TkJtL3ZVRnl4d1VM?=
 =?utf-8?B?TE1GZlFwM2hXRGtWLzdORXQwL3BpcVp0b21PUUliRzU3bkg0RkNTSEVKRVhE?=
 =?utf-8?B?M3grYjU1N0dvWlloVGphcnpWQTlnd2VCVDExOUJPOUVzM3FCUGFBMHNOcGZ5?=
 =?utf-8?Q?MG9Us4ecHG4SPb3N4hi7imQhFoo0uODO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2QxRFFtMU1LOTk2dHQrWGg0aG9KckE5bGxxMVVlQXBrS0xqZmVmWDhkZmNh?=
 =?utf-8?B?VUlmTWtTMXJra25XdjJ6Y0lHSVhxb2dqTE5JMzkrUk9FOHNrelBQN0I4VHNM?=
 =?utf-8?B?OXRvNWo2ZzJtaUhmaVphdXBYU005L1lXZHhZc1Vza0RtQWlJY25sS3REN3RL?=
 =?utf-8?B?OGtwOFd3dWVuUjhXV2VxaTN3QnNLMTFwZER5MUdUY3MvZGYyV1dURTUvWmZP?=
 =?utf-8?B?MzI0ZmtZU3JMb0pBM2hEY1o3Qy9TTnREUmQ4TmlwclpPV3k4dk5rQnI1MGJC?=
 =?utf-8?B?blUvNkVXNDB0SFZpVWZyUFVFcWdLMUhONjZUNEpDUzJuMndTY1hZZTYvNWti?=
 =?utf-8?B?OGJSWElRclhVZ0hDdS9sdDlsL3JYWDVQM25NdmZrZVYxbXhJaGNoaXdVdnRJ?=
 =?utf-8?B?cmQwYi83aEJ5bXhRM0RZQWd3aU9nK2xTV2ZVcHFDZGtsTHFBWkFaZDB0NkRN?=
 =?utf-8?B?ZWovdktzSE9na2JjRitjMzRFWWIxN3Q3K1NLRm44ditIYXVRLzJiRFJvRzJL?=
 =?utf-8?B?V2Y1WGhZRThMY29WdkZZSXhMaEM4RHNHcGZNS2h1cWQ2aVF3bjRlc3hmdnpW?=
 =?utf-8?B?SjhkVUZBYXg4aUQyNHJ3RVB6Ny80QXRXZzdyNUNvQkZMR3ZRR0RNRXUvbzB6?=
 =?utf-8?B?eHlZZHJlT0c1TlcwdnBFU0xYQ0pYRUFRNjFPdStIVFErMkxMMWMzLzhHZUM4?=
 =?utf-8?B?TnViakZGZGlIOXNwZ2ZOVzRDdFZVSlRvcEhmTU9rc0xvam9uM3RvWjcveXJY?=
 =?utf-8?B?bmtPWnhFUE9BeEVsODlLNzdsbzVpeGR3UzZCcS92ZnJaRnNoa3pKSXBtZjEy?=
 =?utf-8?B?Zm9uZXFvdFk5N3ZJd2dyL3V4SmpiL0k4aDh3cWc0czk2VXFxMDdjNWs2aUt2?=
 =?utf-8?B?NnU5cEpvc3BhYTc3ZVVBZnRQemJnd29RU2VicjRjTWkzeWhNN3ZFRGFFQW1G?=
 =?utf-8?B?S2xNb3JiZ2MvSVo5WTF4RnM1Y0xtUzZkaUFnMmJDL0NLeERoQ0EzQ216eW0z?=
 =?utf-8?B?b2dOS3NBaCt6SVBPaDg3WVZsQklRV21KNnV2dHVmR2ZiUEQya3dCeFMzOEVs?=
 =?utf-8?B?c3RjeDRHYStRTysxNFpnODAwUXlIL0tmNXA5b21PbzdBVEduNE5yNlJkL1R3?=
 =?utf-8?B?ODROWUxyQ25yc2wxRjFabnVKUHZUUmExQ2pSbDIrQWdaQ3hXSzhNUWNIdDVS?=
 =?utf-8?B?MjJGL0dFRlN1MXYzOVJZcFI0ZzE2d25BMnFOYldDL2dJWFA5NTFXTitKUHlP?=
 =?utf-8?B?RllHSXpvazY5RDRWMzdiKzlSVko4dGxZODh6bTc0RVpxd09qSDlReTFCRXlT?=
 =?utf-8?B?eFlmT0xaYjdXdnBodVBlRTNNQUQ3OE9ZMVVjem14RTV1ZnJSVGFmQ3hHeHJ4?=
 =?utf-8?B?YnF0MGc0eXBHRUlhRzhpR1N2cXhSRW1yRm9qRWVlOCt2R0NhVlhqYk43ZmF1?=
 =?utf-8?B?UHpnUGlsU2RxblQvZ05TdERxUENWRE1zT1BscmZUWVJaVTl0ei9OeVhPVWFn?=
 =?utf-8?B?NENuR0dMM09kNllsM1YvYzY5eEV3ZHhPRFpOQkpab2Y2TVEyaUwyaWl1L0ls?=
 =?utf-8?B?ckVVRktqY0RsbDErd1gzaFgycU9ZZE42Q3ArU3oyUWl1ZUUyeGlxYWFZSTYy?=
 =?utf-8?B?RHh4VDhWam8wMmU4MURQTHpFWlNKUjF0NHJCdERBVGdJd2paaGNRbUVMUk1L?=
 =?utf-8?B?bUZCTHR6SEFtUzBtTTEwcFhZQ2pyaXVQZHkvYXNIZzJDVW1PNXFrR3BFbUZ4?=
 =?utf-8?B?Z0lESDBxTUxERXZsTzA2M1pPOTJMWHVHbFdLRy9IdE5XVjByVmU2bENYMDdI?=
 =?utf-8?B?dXZRdHBmV1V5WHh1ZnFnclNlVVpsT2VaSWhUY3ZLSWNyRUFDNk9RSWpZcTVo?=
 =?utf-8?B?eGNxRGJkbWtlNE9Td3FudzVDRVNYKy9RcmxQWjNQZWZxYVg4ZVg2UDF3Q281?=
 =?utf-8?B?c1JQZUc0bmFrZ1hVdFUzYXlBVnYvUVFKUWtWYVRtV3V0a2ZuYzRyTVc5OWs1?=
 =?utf-8?B?SXpIdXBkdE5FQlBkNzhJZHQwTFBiZnMwaG4rbFh3TzJFUFVMUVpjZERWWnhZ?=
 =?utf-8?B?QS80U2xaWm9NeTZPYTJHUUVyQWRPenM3c2VneUVYeEpyMW5QYWNlclFTaUJ0?=
 =?utf-8?Q?Ey5arLNDF9q4fG3l721HnXmfo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wEA76/YA/EdFSk1kDG1U4nWgfSntaS+y0wMqzRZKjnZP3uvRpVkFAdycuXxFyItL655tztBP9bokYgeMnsiZ1wKA89zSrqF/bs8K/cgcxl/eFAyRP6X5RwABQZhyUM/tWD3kmjWq53hTAKEq03w1iOQL5eF453pDP+0xju3mXcm2w5Q0xovOwn9FTWr7ZtAQPdYZsSBF3l5cdL7OS8FuK0OVr5CW6lCeF0n45UABaba8SDgX3TEf1BzyNw6SuyS2uvD/m4TY6eOZHI8dxSNQsFx6aD/EwPLo+EP57dGyQoNNbN8PkLhu3sca8hdAod0QITC94KgpcySX61HNoUcnC6cLd9g4vLwwURVGhlPrSzjzuf8nbPAeYpVVz2+QnkF31NJm06n+ZlwrbFlU8jWhSzSbDoSUxaItcj77HI/hyuJpvAkNIIy4zL1FuOOv9OeEUFrI0dfKsaMnJuDoL+xr1jvAjEg6YQXSYT/1DiZMBo1nsySIXKynKgqg5A3jetbVzVeZgPA3iwmsZ23sPOOVFiYQrpL2Sw83HuVHWDmNXZgzUq/l2SvxX/zUVgh/61dNcXREQ3H51CZDqJmXkxQJDEs1oBGYId8DjLMsvU5AY7YFRuPZoQMBXnFtIREmbpDG
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f941b0bd-81f7-4724-7ad9-08dd61871c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 16:58:28.0455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19mg/CZlpMQUoC7ay7x8tQ7+4puCTX19+IIyaDQthDZp2mnJfMEwNiS3DTUf52FZAKqYsuE77Ji6sAGNxjI+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9605
X-Proofpoint-GUID: ZVhfJ0Wi5eEKsxmMI7jSi0n-LWD5RXRs
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d1bd39 cx=c_pps
 a=BX/OqAvQ3O7aab6wCuJmTQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=ahSj42thazzCSNLXnbMA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZVhfJ0Wi5eEKsxmMI7jSi0n-LWD5RXRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120117
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJpYW4gQ2FpbiA8YnJp
YW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDI4LCAy
MDI1IDExOjI2IFBNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbTsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gcGhp
bG1kQGxpbmFyby5vcmc7IE1hdGhldXMgQmVybmFyZGlubyAoUVVJQykNCj4gPHF1aWNfbWF0aGJl
cm5AcXVpY2luYy5jb20+OyBhbGVAcmV2Lm5nOyBhbmpvQHJldi5uZzsgTWFyY28gTGllYmVsDQo+
IChRVUlDKSA8cXVpY19tbGllYmVsQHF1aWNpbmMuY29tPjsgbHRheWxvcnNpbXBzb25AZ21haWwu
Y29tOw0KPiBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBNYXJrIEJ1cnRvbiAoUVVJQykNCj4gPHF1
aWNfbWJ1cnRvbkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nIDxzaWRuZXltQHF1aWNpbmMuY29t
PjsgQnJpYW4NCj4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAz
MS8zOF0gdGFyZ2V0L2hleGFnb246IEFkZCB7VExCLGswfWxvY2ssIGNhdXNlIGNvZGUsDQo+IHdh
aXRfbmV4dF9wYw0KPiANCj4gRnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+
IA0KPiB7VExCLGswfWxvY2sgY291bnRzIGFyZSB1c2VkIHRvIHJlcHJlc2VudCB0aGUgVExCLCBr
MCBsb2NrcyBhbW9uZyBoYXJkd2FyZQ0KPiB0aHJlYWRzLg0KPiANCj4gd2FpdF9uZXh0X3BjIHJl
cHJlc2VudHMgdGhlIHByb2dyYW0gY291bnRlciB0byBzZXQgd2hlbiByZXN1bWluZyBmcm9tIGEN
Cj4gd2FpdC1mb3ItaW50ZXJydXB0cyBzdGF0ZS4NCj4gDQo+IGNhdXNlX2NvZGUgY29udGFpbnMg
dGhlIHByZWNpc2UgZXhjZXB0aW9uIGNhdXNlLlRoaXMgd2lsbCBiZSB1c2VkIGJ5DQo+IHN1YnNl
cXVlbnQgY29tbWl0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+ICB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAg
fCA0ICsrKysNCj4gIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDQgKysrKw0KPiAgdGFyZ2V0
L2hleGFnb24vbWFjaGluZS5jIHwgNCArKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oIGluZGV4DQo+IDA5NTdmYWVhZDMuLmRkYzExNThkOGUgMTAwNjQ0DQo+
IC0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oDQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5o
DQo+IEBAIC0xMDMsNiArMTAzLDcgQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiAgdHlwZWRlZiBzdHJ1
Y3QgQ1BVQXJjaFN0YXRlIHsNCj4gICAgICB0YXJnZXRfdWxvbmcgZ3ByW1RPVEFMX1BFUl9USFJF
QURfUkVHU107DQo+ICAgICAgdGFyZ2V0X3Vsb25nIHByZWRbTlVNX1BSRUdTXTsNCj4gKyAgICB0
YXJnZXRfdWxvbmcgY2F1c2VfY29kZTsNCj4gDQo+ICAgICAgLyogRm9yIGNvbXBhcmluZyB3aXRo
IExMREIgb24gdGFyZ2V0IC0gc2VlIGFkanVzdF9zdGFja19wdHJzIGZ1bmN0aW9uICovDQo+ICAg
ICAgdGFyZ2V0X3Vsb25nIGxhc3RfcGNfZHVtcGVkOw0KPiBAQCAtMTE2LDExICsxMTcsMTQgQEAg
dHlwZWRlZiBzdHJ1Y3QgQ1BVQXJjaFN0YXRlIHsNCj4gICAgICB0YXJnZXRfdWxvbmcgKmdfc3Jl
ZzsNCj4gDQo+ICAgICAgdGFyZ2V0X3Vsb25nIGdyZWdbTlVNX0dSRUdTXTsNCj4gKyAgICB0YXJn
ZXRfdWxvbmcgd2FpdF9uZXh0X3BjOw0KPiANCj4gICAgICAvKiBUaGlzIGFsaWFzIG9mIENQVVN0
YXRlLmNwdV9pbmRleCBpcyB1c2VkIGJ5IGltcG9ydGVkIHNvdXJjZXM6ICovDQo+ICAgICAgdGFy
Z2V0X3Vsb25nIHRocmVhZElkOw0KPiAgICAgIGhleF9sb2NrX3N0YXRlX3QgdGxiX2xvY2tfc3Rh
dGU7DQo+ICAgICAgaGV4X2xvY2tfc3RhdGVfdCBrMF9sb2NrX3N0YXRlOw0KPiArICAgIHRhcmdl
dF91bG9uZyB0bGJfbG9ja19jb3VudDsNCj4gKyAgICB0YXJnZXRfdWxvbmcgazBfbG9ja19jb3Vu
dDsNCj4gICAgICB0YXJnZXRfdWxvbmcgbmV4dF9QQzsNCj4gICNlbmRpZg0KPiAgICAgIHRhcmdl
dF91bG9uZyBuZXdfdmFsdWVfdXNyOw0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYyBpbmRleA0KPiBjNGI5ZGYyZmMzLi43YzM0ZDAxNWEz
IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYw0KPiArKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuYw0KPiBAQCAtMzEyLDcgKzMxMiwxMSBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2Nw
dV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLA0KPiBSZXNldFR5cGUgdHlwZSkNCj4gICAgICBlbnYt
PnRocmVhZElkID0gY3MtPmNwdV9pbmRleDsNCj4gICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID0g
SEVYX0xPQ0tfVU5MT0NLRUQ7DQo+ICAgICAgZW52LT5rMF9sb2NrX3N0YXRlID0gSEVYX0xPQ0tf
VU5MT0NLRUQ7DQo+ICsgICAgZW52LT50bGJfbG9ja19jb3VudCA9IDA7DQo+ICsgICAgZW52LT5r
MF9sb2NrX2NvdW50ID0gMDsNCj4gICAgICBlbnYtPm5leHRfUEMgPSAwOw0KPiArICAgIGVudi0+
d2FpdF9uZXh0X3BjID0gMDsNCj4gKyAgICBlbnYtPmNhdXNlX2NvZGUgPSAtMTsNCltTaWQgTWFu
bmluZ10gDQpJbnN0ZWFkIG9mIHVzaW5nIC0xIHRoaXMgY291bGQgdXNlIEhFWF9DQVVTRV9OT05F
Lg0KDQo+ICAjZW5kaWYNCj4gIH0NCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9t
YWNoaW5lLmMgYi90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgaW5kZXgNCj4gZGM5MDA0MjJmNC4u
OWZkYWZiNDU3MyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jDQo+ICsr
KyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYw0KPiBAQCAtMjIsNyArMjIsMTEgQEAgY29uc3Qg
Vk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4YWdvbl9jcHUgPSB7DQo+ICAgICAgICAgIFZN
U1RBVEVfVUlOVFRMKGVudi5uZXh0X1BDLCBIZXhhZ29uQ1BVKSwNCj4gICAgICAgICAgVk1TVEFU
RV9VSU5UVEwoZW52LnRsYl9sb2NrX3N0YXRlLCBIZXhhZ29uQ1BVKSwNCj4gICAgICAgICAgVk1T
VEFURV9VSU5UVEwoZW52LmswX2xvY2tfc3RhdGUsIEhleGFnb25DUFUpLA0KPiArICAgICAgICBW
TVNUQVRFX1VJTlRUTChlbnYudGxiX2xvY2tfY291bnQsIEhleGFnb25DUFUpLA0KPiArICAgICAg
ICBWTVNUQVRFX1VJTlRUTChlbnYuazBfbG9ja19jb3VudCwgSGV4YWdvbkNQVSksDQo+ICAgICAg
ICAgIFZNU1RBVEVfVUlOVFRMKGVudi50aHJlYWRJZCwgSGV4YWdvbkNQVSksDQo+ICsgICAgICAg
IFZNU1RBVEVfVUlOVFRMKGVudi5jYXVzZV9jb2RlLCBIZXhhZ29uQ1BVKSwNCj4gKyAgICAgICAg
Vk1TVEFURV9VSU5UVEwoZW52LndhaXRfbmV4dF9wYywgSGV4YWdvbkNQVSksDQo+ICAgICAgICAg
IFZNU1RBVEVfRU5EX09GX0xJU1QoKQ0KPiAgICAgIH0sDQo+ICB9Ow0KPiAtLQ0KPiAyLjM0LjEN
Cg0K

