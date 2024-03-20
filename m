Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421D8C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmv7W-0004jb-GT; Wed, 20 Mar 2024 08:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1rmv78-0004eD-B7; Wed, 20 Mar 2024 08:32:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1rmv6p-00058Q-Ub; Wed, 20 Mar 2024 08:32:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42K9u5T1017219; Wed, 20 Mar 2024 12:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=qcppdkim1; bh=bOvgz++S7AfGPpfiDpC5Tid4OVMYIESnFI0N3dfThoM=; b=
 SlLwuzJYijVhGTzWGreUB3V/ev42AKpLr3yda6TxXOqGUv8FHV1tk7jlQ+ATzNNA
 8iIOnrh/aVsgRYyfWWbk0H8pQVKKjsFSv3pFzhr73SLQpYGVtv7F/4qT+imRv+ps
 MXVN3INdKFafspKibAivNwdxdHmcH0kFvFn3xz0+QWWpqmIPuqkBCdfCCJ9WscXC
 P1v3iIamXv5FTYeoRYNbx+I/DPrS2wmi8SGzfinV8VpatnbH5z+70polaRL836Bm
 zcbUtrpmud0oNwygw/UQJt1R8QoI8kFFXbaHa92RHbpwtDXI8iZGzar8/F+BNCAz
 XDfAMM7r53LcRVMQYB/t/Q==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyw8x8bdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 12:31:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTLYXlLI7bDCswDFXZwlN0X3cBkXyuENdGOm5PB3ItI3GxskbQys0GxfB6jK8GBjZhW51Xe9jvj/1vNpxMWEhg5STz3LckpvsSEbnudc1vpeCqMe3JhdbiHoec3X8PNDpFV/Px3qRhHeHgXBpIzb9w6DSZ/GauADPClVumjITYfgovqDTdl47cxWWuv/gJNQAEvYmYNw02cEze5t0my4ZAXESr0EPgLaKa6B5N3F31S50ybrYTy8TrEmJKGncuAH1QhL9pNDjB/xiwLS3V4w5rgShlPQj24eLFJm2GgqWCXjDakeW3bSbMPHqukuXeQ5NAUSQj8JQhoEiZy+67HxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOvgz++S7AfGPpfiDpC5Tid4OVMYIESnFI0N3dfThoM=;
 b=IXB3wNbZ03XByHRCTHb1XQ+lUrqvCyFKoKB7Y1+NRtR0728MvnNjL+/5d308JhCSDOr7ZWbmyjUvHtPMTFybIaIjozvo8X7IR5nAcEn+nLq3MNgqLRi5OBqY41XYoFs3UuiQQuPg2oHGzghGa72V1xIcmzJSUn4cXr1q3kATqVD6C3ooeG2wu60ZXTFoICDf4z4j3C67LYm6aKep3Ce9i4WfpBf+30YdIMeHYbYqWtTXUarXRGKhtM6a0nlLNi+5lX1iGEWGoZkm2VSMtUtXyxbJplV0HSn4n0iWQMkTyAkYZsO+sRQpULxR75OB7dOjpzRlnEKzZvdSybeiw0SEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com (2603:10b6:a03:53a::21)
 by SJ0PR02MB8660.namprd02.prod.outlook.com (2603:10b6:a03:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 12:31:42 +0000
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::f655:6bb8:2692:cb0f]) by SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::f655:6bb8:2692:cb0f%3]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 12:31:42 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Thomas
 Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "qemu-s390x@nongnu.org"
 <qemu-s390x@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Thread-Topic: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Thread-Index: AQHaerh97y9neLDZOEe71DBZx3RqVrFAhvkAgAAIqYA=
Date: Wed, 20 Mar 2024 12:31:42 +0000
Message-ID: <59C20F1A-FCFE-4E26-B511-A6C0E1EF6F61@qti.qualcomm.com>
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
 <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
In-Reply-To: <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9884:EE_|SJ0PR02MB8660:EE_
x-ms-office365-filtering-correlation-id: 05fdcf36-7c41-43ad-9251-08dc48d9b28c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8YybwWrscCvu6/R1SU4ctAY57+lCHeJLyQYCD6KYdZuX15vxiWCPuxLwo/tHL9KVFl11LZoRZqOVgixDJiM5gqseAaMSgme6ZMa0UQfJnEjavTSvT7F8598oTLt8lX7FmaSVCHf+fSgTbjtCK97kBbBoLNpyReO7FgYuWnVEFbiWa85jDUHjt1Iq+5HAvSsYGEWPn58niDUJplExh7UluJQy2uWyVnmRnmZFEWjOTK4+lxNuvZFIr44j7rNgRL9rQsGfIvF7+7i7NkeSX0dvQhyXXmlwczThHxa+TbLT3pgKKbUEnvT9JqRDnE5WODOVvwbFGjrjBv4Uaq/KuO3rF4099orN6P0ljfiX21mYkmnQ4b6733U/4SZh9P0+S2cEJ5cZwCCMdhmm5IUUoJcBMoKsNhFQ9t/EiAxI3BZmBQIsh0O2eH1Zsl/WJLkLAX4sFCSrORj5hgHTwpLZ/CxC3pdAv7LDR7nHAcgIsgJLA0CAM80iZt73pL+5Wl46Fpj0QrlqC8Xgo+SxRx0vrZ0BYROuKnEXm5BBEGn4fQedcdOjumsda8vUo8lB1Bb2O8qW0Hy3FLb9oIfrRVToI+fPgwgz4mnWOEdnRQgveisce+P2Imi3q5ngYRSkglkzsSbKjs3MISKR2xfMLxzYbCkeOAPlIkliNZ/KbjKYH4/S/k674WJ3+ZGY7thsjUGiIHmIgqqB6pn7nsVwVRCYObFq1e/AWvQPxaTZCuAonA0TsE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9884.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVQ2cHo2QkN5UEFzR3ZCOG5XQXdRRE8xd21XMzU5REVRVjFWRm1VOUxWaTBB?=
 =?utf-8?B?WjlhU2JSTEs3SkpsYmZLSTJJQzQzOHJFK1J5ditWeG82cHdTM0NDTlQvMlda?=
 =?utf-8?B?em11ZERzM2JaM280elZpQ2h6SVdCeFl4cWNvL292MEx5RTViU2IyYm83c2Zs?=
 =?utf-8?B?eWVVUE1XL2ZWTVB4SVg0YkpIK1hmdXVCU0RZTzNoaVI0ck52U3hkYzZmeE1i?=
 =?utf-8?B?MDlvazJ1OHVkazBJU1ZaZGxqTVdMRnltc0xmWVcwZWxWWDNWYWhHekM3K0FH?=
 =?utf-8?B?cjNUVkt6TkNIVSsyVnNTQWFhdDJtNm1UUEJwV1dUVnI1QTBrTlZBVEJFR2pW?=
 =?utf-8?B?S2RETGxCdS9JcUNVWS9HbUswQmNPRmtvdmN6cjRyRkg4VFphZ1JEUHFtU2lE?=
 =?utf-8?B?VTJ4QUpaNFZmcExIZGRjKzg0WTV1WWJ4MjBULzR4Z1c1ZTA1T3dkajRMSUhs?=
 =?utf-8?B?Z2d2MzVrSVgxL3ZWVkpoVWVSSjBVSldYYTl3czZKeEZIdkE5dFBFbDZURWZR?=
 =?utf-8?B?YytkMzlOUDBEVXNmN0hBbml1aU02Wm9MTVQwNFVKUktHZFY3TUlyZGlxVzda?=
 =?utf-8?B?ck42L2JXRG81YkRrRU96akhoVysxOWQ0YkgxUEJqWXEzQy8xY00ySXY4ZlZD?=
 =?utf-8?B?ODRxNmg4N212VmVOejVoOGYxOHZYV1NLWXRtYktFMWc4cDVCckJZQ05SYU91?=
 =?utf-8?B?L3FaV1hZNzdRcHZZOUx1U2Jtckw2UkRmM3o0U0VtYWpESWZieDg0SE44RmZi?=
 =?utf-8?B?bGJ0WlpZR0dseVJudHprRDBSdzJWVkxLc2pOaVlmMXlWVWxGaFF2K3lQSWNT?=
 =?utf-8?B?eVV1RGZ4cHFualZla2JQdmo2bnJqaVNmRG1qYU9oazlIek56VFU5UHNQVmU3?=
 =?utf-8?B?NHJsZXBYb2F4Z2NPeVVCTWt0WFZmNVVVRS83cjJ6MkZQdXBYY3R6emRnUTJx?=
 =?utf-8?B?ck84dFhTOElBUGZJM2JVcVY4a1lwOEE3QkZMbmxHS05VWnBGVU9zM2N0T0Nm?=
 =?utf-8?B?eUg1dytjdzMxdklIMFVwQWpaY3JEQmFTSzFPUXZsVDFGMFQ0emlNMjJnck5Y?=
 =?utf-8?B?S1R3TUVER1dWUUJSVkRiOHFMWUljWUdlWk4yQVdQa1dIY3pEcEhScjUwOGNk?=
 =?utf-8?B?VVZJS2lVQmtmRHQxMVJBV0lwK1RSZmJoaWszOVk1UU9ITFFqa2hOc29wVVhI?=
 =?utf-8?B?R1dEWllRRGdBOWdrTmRIam9YMWQyV2FXSWhjamdyN0hydGM0S1k1bmREU0RT?=
 =?utf-8?B?VFRqNDdvK3hseDZ3a3NweXgwMDJRV0JXdGFVREtTWmZNQTQxVnR2Zkorb01l?=
 =?utf-8?B?WEFPSDQzd1ZSaE5tWEZZU2dwc052MVJxa01FSS9scTdsYzNERnVhZFlxVTFG?=
 =?utf-8?B?RlRxQTdvUUV4Q3MzMENrZHdXQkszZGZsWW4vYWx0L3lPeXdrVWk4YVdtNHFW?=
 =?utf-8?B?a2ExQmpXVzlxL3RuVEpwY3lybTVrcnN4bGFNa00zNk1jdjU3YXJjT3J5MnRS?=
 =?utf-8?B?NU9Ha2JIYkhXK1JDNzBNMHlkcDU4S1M1YkgrNVV2Q2JHK0VodHNZVnFoekE1?=
 =?utf-8?B?Rk9nMkw0MWNsb1RyRmpQbjBhanFxc3RDRDdkczliZEo3Sk84Y0VrVXJWdlVo?=
 =?utf-8?B?OUdreEZxcnI3MGtFNEdCcURSUEV3UXlyZWgxSXpJNGgwbDluTnRheW1WZ2Nz?=
 =?utf-8?B?RVVLc0srQk5NbjB1bUpPN293K0laRE5ZUS9qckVRWW1QYUJxRi9IWXV4cW54?=
 =?utf-8?B?Rk1wSEp4RW9kNGcwNHZKTHVzRUNiQnd3eG1aTmhITkFsNS9lN1JQOGQraE90?=
 =?utf-8?B?dUV2QTdGOC8yOUdwRlJFdyt3aHl3SlRRTi9DMUxSWDMxMXpFR3RVc1dtbnlj?=
 =?utf-8?B?YlJGQ0hBQXFheGFvZWszd3V5T2tKM1pnVlJMdk05TUJHb29sUDhiQVZLa0Va?=
 =?utf-8?B?WjdlblZNQTZCTEZjWGpBVlhYWjgwYkFFQi90Z1dCM3g3Tnp4YldyOWJtckFV?=
 =?utf-8?B?K1grYUtTWDlRVnA1MUpmQURGTThiUE5BOFNJSytZckVTZXJ2ZHh2YmwvZFhP?=
 =?utf-8?B?djRHbElxQjd0V0k0VlkrN1hSTWE1V1lTZFBONDdKdTNtRDhIdzBtZmlWWWJJ?=
 =?utf-8?B?MFFKY3B1MTduaEpSQmZxa0svOUlVZUducGdlVi9sNFBZNVRZSXhPZHBGRnV1?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <944B9B54F1AF6649BBE52987F11F7D72@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 67IAl4Jps4W/A3SRNWyxG7M18XJJT2wXoOvjud3vs2h60f5is2PWCr3UjBG73kz3UKJa0ub38jfd1AD01YZdSc0nV796pG2s2m6isrXemXRcMt3OJh09FZZFpdoLep1qH/9rXVzI8ojXuhSpjwuZE47LT9SfIBG9V+HRI1dLy7xmCcErHergcnihgXPNf0/lTxFnsIOLheozUoBIJIMmJZzMBvVPlqvazKt6ybywCk2eOkYsPbglXn6qosyW2Sy+JCg6aKdYYGZ6KZISPia2FJHcsso8k8sdrJxydwSIBTpxlgewbGwAP8UsL0XDTabDnxWaQn56PWDirmugKioUhlWnIhDSuUsPMgwfbHXl3xElPTn94wr6zIDDgTfpyfqbtkfyPdeVO/inwc6QVozGgA5mdiBOOlXgGb2Z+pIQoypvceFvrijikKHaia5atulvrRURFU3y5dwOlXuOEePpUqYGh+k2nGUvkL740BpxsHx2uUofpXY9DYdI/hhN41kTRmBKP2L7t8kYBmJ15yozBs8PFPTAqwtXfA/uwCc26pH0YyBHTgfXBrb/0X0WxRZT+quoAAQDbd/hAPdwjrmqig2Btz06HmW/R3K0h9uqW7XI/Lkd0PJXnbks9tu6WQpr
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9884.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fdcf36-7c41-43ad-9251-08dc48d9b28c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 12:31:42.0246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoKbtGk+eDVOMFPbzFuq/6VVDhHPSw3kC+kB+6pEOruwkbDfSCPkz/vru/vJiWfHDvdor0PA95maqZpt7S/lbOfwsc/iA2ejqL6wb8GmiGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8660
X-Proofpoint-GUID: S9FgIoxJw3zOZrscwrXApcncCDvAhUXn
X-Proofpoint-ORIG-GUID: S9FgIoxJw3zOZrscwrXApcncCDvAhUXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200099
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4gT24gMjAgTWFyIDIwMjQsIGF0IDEzOjAwLCBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxpbmtz
IG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBPbiBXZWQs
IDIwIE1hciAyMDI0IGF0IDExOjIwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+IHdyb3RlOg0KPj4gDQo+PiBPbiAyMC8yLzI0IDE2OjE5LCBUaG9tYXMgSHV0aCB3
cm90ZToNCj4+PiBPbiAyMC8wMi8yMDI0IDE2LjA4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3
cm90ZToNCj4+Pj4gSGF2ZSBzMzkweCBhbHdheXMgZGVsaXZlciBOTUkgdG8gdGhlIGZpcnN0IENQ
VSwNCj4+Pj4gcmVtb3ZlIHRoZSBAY3B1X2luZGV4IGFyZ3VtZW50IGZyb20gaGFuZGxlciwNCj4+
Pj4gcmVuYW1lIEFQSSBhcyBubWlfdHJpZ2dlcigpIChub3QgbW9uaXRvciBzcGVjaWZpYykuDQo+
Pj4gDQo+Pj4gQ291bGQgeW91IHBsZWFzZSBhZGQgc29tZSByYXRpb25hbGUgaGVyZSB3aHkgdGhp
cyBpcyBuZWVkZWQgLyBkZXNpcmVkPw0KPj4gDQo+PiBJJ20gbm90IHN1cmUgaXQgaXMgZGVzaXJl
ZC4uLiBJJ20gdHJ5aW5nIHRvIGdldCB0aGUgTk1JIGRlbGl2ZXJ5DQo+PiB3b3JraW5nIGluIGhl
dGVyb2dlbmVvdXMgbWFjaGluZSwgYnV0IG5vdyBJJ20gd29uZGVyaW5nIHdoZXRoZXINCj4+IGh3
L2NvcmUvbm1pLmMgd2FzIGRlc2lnbmVkIHdpdGggdGhhdCBpbiBtaW5kIG9yIGxpa2VseSBub3Qu
DQo+PiANCj4+IEkgc3VwcG9zZSBpbiBhIGNvbXBsZXggbWFjaGluZSB5b3UgZXhwbGljaXRseSB3
aXJlIElSUSBsaW5lcyBzdWNoDQo+PiBOTUksIHNvIHRoZXkgYXJlIGRlbGl2ZXJlZCB0byBhIHBh
cnRpY3VsYXIgSU5UQyBvciBDUFUgY29yZSwgYW5kDQo+PiB0aGVyZSBpcyBubyAiYnJvYWRjYXN0
IHRoaXMgc2lnbmFsIHRvIGFsbCBsaXN0ZW5lcnMgcmVnaXN0ZXJlZA0KPj4gZm9yIE5NSSBldmVu
dHMiLg0KPiANCj4gSSB0aGluayBpbiBhIGNvbXBsZXggaGV0ZXJvZ2Vub3VzIG1hY2hpbmUgeW91
IGRvIHdhbnQgdGhlDQo+IG1vbml0b3IgTk1JIGNvbW1hbmQgdG8gZG8gc29tZXRoaW5nIHNlbnNp
YmxlLCBidXQgdGhlDQo+IGRlZmluaXRpb24gb2YgInNlbnNpYmxlIiBpcyBnb2luZyB0byBiZSBt
YWNoaW5lLXNwZWNpZmljOg0KPiBwcm9iYWJseSBpdCB3aWxsIGJlICJyYWlzZSBOTUkgaW4gc29t
ZSB3YXkgb24gc29tZSBjb3JlIGluDQo+IHRoZSBtYWluIGFwcGxpY2F0aW9uIHByb2Nlc3NvciBj
bHVzdGVyIiwgYW5kIGl0J3MgdGhlIG1hY2hpbmUNCj4gbW9kZWwgdGhhdCdzIGdvaW5nIHRvIGtu
b3cgd2hhdCAic2Vuc2libGUiIGlzIGZvciB0aGF0IG1hY2hpbmUuDQo+IA0KPiBUaGUgY3VycmVu
dCBody9jb3JlL25taS5jIGNvZGUgaXMgYSBiaXQgb2RkIGJlY2F1c2UgaXQncyBwYXJ0bHkNCj4g
d29ya2luZyB3aXRoIGEgY3B1X2luZGV4IGFuZCBwYXJ0bHkgbm90OiB0aGUgY29kZSBwYXNzZXMg
Y3B1X2luZGV4DQo+IGFyb3VuZCwgYnV0IGluIHByYWN0aWNlIGZvciB0aGUgUU1QIGNvbW1hbmQg
dGhlIHVzZXIgY2FuJ3Qgc2V0DQo+IHdoaWNoIENQVSB0byBvcGVyYXRlIG9uLCBhbmQgZm9yIGV2
ZXJ5dGhpbmcgZXhjZXB0IHMzOTAgdGhlDQo+IGltcGxlbWVudGF0aW9uIGRvZXNuJ3QgY2FyZSBh
bnl3YXkuIE15IGltcHJlc3Npb24gZnJvbSB0aGUgSVJDDQo+IGRpc2N1c3Npb24gaXMgdGhhdCBp
dCdzIG5vdCByZWFsbHkgbmVjZXNzYXJ5IGZvciB0aGUgUzM5MCB0aGF0DQo+IHRoZSBtb25pdG9y
IHVzZXIgYmUgYWJsZSB0byBzcGVjaWZ5IHdoaWNoIENQVSB0byBOTUkgKGFuZCBpbiBhbnkNCj4g
Y2FzZSB5b3UgY2FuIG9ubHkgZG8gdGhhdCBmcm9tIHRoZSBITVAgY29tbWFuZCwgbm90IHRoZSBR
TVANCj4gY29tbWFuZCwgQUlVSSksIHNvIGdldHRpbmcgcmlkIG9mIHRoYXQgd2VpcmQgaW5jb25z
aXN0ZW5jeSBtYWtlcw0KPiBzZW5zZSB0byBtZTogYW5kIHRoYXQncyB3aGF0IHRoaXMgcGF0Y2hz
ZXQgaXMgZG9pbmcuDQo+IA0KPiBXaGF0IE5NSSBwcm9iYWJseSBvdWdodCB0byBiZSBpcyBib2Fy
ZC1zcGVjaWZpYzogc28gaXQncyBsaWtlDQo+IGhhdmluZyBzb21lIG5vdGlvbmFsIGZyb250IHBh
bmVsIHN3aXRjaCBsYWJlbGVkICJOTUkiLCBhbmQgdGhlDQoNCkRvIHRoZSB5b3VuZ3N0ZXJzIG9m
IHRvZGF5IGtub3cgd2hhdCBvbmUgb2YgdGhvc2UgaXMgPw0KCTotKQ0KDQoNCklzIHRoZXJlIGEg
cmVhc29uIGZvciBub3QgdXNpbmcgYSBHUElPIGludGVyZmFjZSBmb3Ig4oCZTk1J4oCZIC0gd2ly
aW5nIGl0IHVwIGxpa2UgYW55IG90aGVyIHdpcmU/DQoNCkNoZWVycw0KTWFyay4NCg0KPiBib2Fy
ZCBnZXRzIHRvIGRlY2lkZSB3aGF0IHRoYXQgbWVhbnMgKHdoaWNoIGlzIHVzdWFsbHkgZ29pbmcg
dG8gYmUNCj4gInNlbmQgc29tZSBOTUkgbGlrZSBpbnRlcnJ1cHQgdG8gdGhlIGZpcnN0IENQVSBp
biB0aGUgbWFpbiBjbHVzdGVyIiwNCj4gYnV0IGNvdWxkIGJlIHNvbWV0aGluZyBlbHNlKS4gSXQg
ZG9lc24ndCBuZWVkIHRvIGJlIGxpa2UgYQ0KPiBmcm9udCBwYW5lbCBzd2l0Y2ggd2l0aCBhIHJv
dGFyeS1zZWxlY3RvciBmb3IgJ3BpY2sgYSBDUFUnDQo+IHBsdXMgYSBidXR0b24gZm9yICJzZW5k
IE5NSSB0byB0aGF0IENQVSIuIEluIGZhY3Qgd2UncmUgcXVpdGUNCj4gY2xvc2UgdG8gIml0J3Mg
YSBib2FyZCB0aGluZyIgYWxyZWFkeSwgYmVjYXVzZSBhbG1vc3QgZXZlcnkNCj4gaW1wbGVtZW50
YXRpb24gb2YgdGhlIFRZUEVfTk1JIGludGVyZmFjZSBpcyBhY3R1YWxseSBhIG1hY2hpbmUNCj4g
bW9kZWwuIChUaGUgZXhjZXB0aW9ucyBhcmUgaHcvaW50Yy9tNjhrX2lycWMuYywNCj4gaHcvbTY4
ay9xODAwLWdsdWUuYyBhbmQgaHcvbWlzYy9tYWNpby9ncGlvLmMuKQ0KPiANCj4gU28gSSB0aGlu
ayB0aGF0Og0KPiAqIHdlIHNob3VsZCBpbmRlZWQgZHJvcCB0aGUgY3B1X2luZGV4IHN0dWZmLCBw
ZXIgdGhpcyBwYXRjaDoNCj4gICBpdCdzIHVubmVjZXNzYXJ5IGNydWZ0IHdlIGRvbid0IHJlYWxs
eSB1c2UNCj4gKiB3ZSBzaG91bGQgbG9vayBhdCB3aGV0aGVyIHRoZSB0aHJlZSBjbGFzc2VzIGxp
c3RlZCBhYm92ZQ0KPiAgIHdoaWNoIGltcGxlbWVudCBUWVBFX05NSSBvbiBhIG5vbi1tYWNoaW5l
LW1vZGVsIGFyZSByZWFsbHkNCj4gICB0aGUgcmlnaHQgd2F5IHRvIGRvIHRoYXQsIGkuZS4gd2hl
dGhlciBpdCB3b3VsZCBiZSBhIGxvdCBvZg0KPiAgIGVmZm9ydCB0byBlZmZlY3RpdmVseSBzd2l0
Y2ggdG8gaGF2aW5nIG5taV9tb25pdG9yX2hhbmRsZXINCj4gICBiZSBhIHNpbXBsZSBtZXRob2Qg
b24gTWFjaGluZUNsYXNzLiBOb3Qgd2Fsa2luZyB0aGUgUU9NDQo+ICAgdHJlZSB3b3VsZCBtYWtl
IHRoZSBOTUkgaW5mcmFzdHJ1Y3R1cmUgcmF0aGVyIHNpbXBsZXIuDQo+ICAgKEJ1dCBJIGp1c3Qg
bG9va2VkIGF0IHRoZSBtYWNpbyBjYXNlLCBhbmQgaXQncyBpbnNpZGUgYQ0KPiAgIFBDSSBkZXZp
Y2UsIHNvIGF0IGJlc3QgdGhhdCdzIGEgYnVuY2ggb2YgY2x1bmt5IHBsdW1iaW5nLikNCj4gKiBm
YWlsaW5nIHRoYXQsIHdlIHNob3VsZCBsb29rIGF0IHdoZXRoZXIgd2Ugc2hvdWxkIHJlYWxseQ0K
PiAgIGNvbnRpbnVlIHRvIHdhbGsgdGhlIHdob2xlIFFPTSB0cmVlIGNhbGxpbmcgbWV0aG9kcyBv
biBldmVyeQ0KPiAgIFRZUEVfTk1JIG9iamVjdCwgb3Igd2hldGhlciB3ZSBjYW4gc2F5ICJvbmNl
IHdlJ3ZlIGZvdW5kIG9uZQ0KPiAgIGltcGxlbWVudGF0aW9uIHdlJ3JlIGRvbmUiLiBUaGlzIGFs
c28gZGVwZW5kcyBvbiB0aG9zZSB0aHJlZQ0KPiAgIG5vbi1NYWNoaW5lQ2xhc3MgaW1wbGVtZW50
YXRpb25zLCBiZWNhdXNlIG9idmlvdXNseSB0aGVyZSdzDQo+ICAgb25seSBldmVyIG9uZSBNYWNo
aW5lQ2xhc3Mgb2JqZWN0IGluIHRoZSBzeXN0ZW0uIFRoaXMgaXMNCj4gICBraW5kIG9mIHVzZWZ1
bCBmb3IgaGV0ZXJvZ2Vub3VzIGJvYXJkcyB3aGljaCB1c2UgdGhlIG02OGsNCj4gICBvciBwcGMg
ZGV2aWNlcyBsaXN0ZWQgYWJvdmUgKHNlZW1zIGhpZ2hseSB1bmxpa2VseSksIGJ1dCBpdA0KPiAg
IHdvdWxkIG1lYW4geW91IGNhbiBvdmVycmlkZSB0aGUgZGVmYXVsdCAidGhvc2Ugb2JqZWN0cyBo
YW5kbGUNCj4gICBOTUkiIGJ5IGhhdmluZyB5b3VyIGhldGVyb2dlbm91cyBib2FyZCBpbXBsZW1l
bnQgVFlQRV9OTUksDQo+ICAgYW5kIHRoZW4gc2luY2UgaXQncyBlYXJsaWVyIGluIHRoZSBRT00g
dHJlZSB0aGF0IHdpbGwgYmUNCj4gICB0aGUgbWV0aG9kIGNhbGxlZCwgbm90IHRoZSBvbmVzIG9u
IHNwZWNpZmljIGRldmljZXMuDQo+ICAgKFRoaXMgb25lIEkgdGhpbmsgd2UgY2FuIGVhc2lseSBk
byAtLSBteSBxdWljayBjaGVjayBzdWdnZXN0cw0KPiAgIHRoYXQgVFlQRV9NNjhLX0lSUSBpcyBv
bmx5IHVzZWQgaW4gdGhlIG02OGsgdmlydCBib2FyZCwNCj4gICBUWVBFX0dMVUUgaXMgb25seSB1
c2VkIGluIHRoZSBtNjhrIHE4MDAgYm9hcmQsIGFuZA0KPiAgIFRZUEVfTUFDSU9fR1BJTyBpcyBv
bmx5IHVzZWQgaW4gdGhlIHBwYyBtYWM5OSBib2FyZC4gU28gaW4NCj4gICBmYWN0IGluIGFsbCBj
YXNlcyB0aGVyZSdzIG9ubHkgZXZlciBvbmUgVFlQRV9OTUkgaW50ZXJmYWNlDQo+ICAgcHJlc2Vu
dCBpbiB0aGUgc3lzdGVtLikNCj4gDQo+IFRoZSBsYXN0IHR3byBhcmVuJ3QgYmxvY2tlcnMgZm9y
IGhldGVyb2dlbm91cy1zeXN0ZW0gd29yaywNCj4gdGhvdWdoOiB0aGV5IGp1c3Qgc2VlbSB0byBt
ZSBsaWtlIG5pY2UgY2xlYW51cCBvZiB0aGlzIGludGVyZmFjZS4NCj4gDQo+IHRoYW5rcw0KPiAt
LSBQTU0NCg0K

