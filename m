Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ADDC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb1un-0005py-FH; Fri, 16 Feb 2024 12:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rb1um-0005pT-2D
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:22:20 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rb1uk-0004X6-7Q
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:22:19 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41GEvBOY012956; Fri, 16 Feb 2024 17:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=B15KgD+aUruVFL6KoJxjvHRYMlqBBulzHvVwvN2o27c=; b=MJ
 4U/ZPy04ssJ7ATJkxRTknlz5C62qVRS4m5IjTPUy4qhdJ/8LjMd9XM6d7eVnTzI/
 NYetypgeJuz+mQTkMfDTC0fL0qgloaFVrMgsH85n+qeUL+PiBLsIZjtJhpBt90H9
 QFZcOeyoUjckPeYuMW0DLnvSiww0GspyXprKPWuN5z90xFTuLat2Z3jioEETJLJL
 P8uKjJ8l/nsRLYsZzKA8EvH0zVwyYRbsxab3h9onIxxJ6StnMCagG/dZNn/gkxak
 nexhBUXpf6xRWnTWgQmktizPwnnT04j4/tdNz4kXaVH3lsKtJn6+anGdR6Vk3ROj
 q14QFURzx0q4Kq9r5Zbg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wa3bh14fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 17:22:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSWyNKxrP0eoUsKwL3Ebv3CcQZK8R5FIYOOxSyoilmMSqsGQItR10UPrjHdK35DrVLRn3DMbfmxd31CH6LeBfw8mDcx1n9iHVJyathk5c1HOzU3li+Z6Pb1c3YtxkV7wU4Nd+x+TiD6iZ3M74f1NaaD7lFBKFELz8tKkCDPrw750GnUwU3PuCYLNpKLG4OHl6mq45b8agFCEB8AvarCFeEE/mC3RFB15xyO3VIXWigE2AIO3cgyTIlrjDnaHsxOQh61ktGeNnNRj3unaeGjvlKz273hzdaGWbflemFhMUB7LLDU0IvxUuu4jI5PJQFNo4wmNVCFthsLlgr8zhv6DXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B15KgD+aUruVFL6KoJxjvHRYMlqBBulzHvVwvN2o27c=;
 b=kSL2+yXZFY0xmw6+vGUPkYyi6XjeqV4JBv5DZS0MPLb9xPs2Ly1+5O3Ti8814IZk6PIxuMclp9IRZ5I2HtbQne+RjC9LWQEijyI005iXv13bey3MZrx3T13SWj8WBdDvEiopZ3afPrI0EJCTQYmrejWC2pRi6YaQjbV+yVF4QJA4dm+JdMzJl5jfxek+gj3/ftuyvDIXQlmOM+0rj+/zlcWzfyU4QRs9q0J7NqUCe7rxl4uIqFLLpCQw/3E8dCWleg/to/8VcJVA1v7XHsKjzBhxX7ycuYTEE+oJifyGt9ksQg4VerYw2BoNo9U920oY1C4AhN42RtAAUtCyNhLK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by SJ0PR02MB8468.namprd02.prod.outlook.com
 (2603:10b6:a03:3f8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 17:22:12 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 17:22:12 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v3 2/3] Hexagon (target/hexagon) Pass SP explicitly to
 helpers that need it
Thread-Topic: [PATCH v3 2/3] Hexagon (target/hexagon) Pass SP explicitly to
 helpers that need it
Thread-Index: AQHaXv4k3jynT3IfxUS/ROY3oSpB1rENO1Sg
Date: Fri, 16 Feb 2024 17:22:12 +0000
Message-ID: <CH3PR02MB10247FE43B1B2A18721936133B84C2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
 <20240214042726.19290-3-ltaylorsimpson@gmail.com>
In-Reply-To: <20240214042726.19290-3-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|SJ0PR02MB8468:EE_
x-ms-office365-filtering-correlation-id: 4125b11a-8628-43fe-162c-08dc2f13d044
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GvP9raZA2V5mCIvY/NdCKg0/SUFQWOS/JoIL39ADaXHV1fdsUjZ6Ivas/og8x9qM519+tkEgaRIOAf16q9yVk1oPp+NGAywtnU/xTWsM1ZqwnR37lKWITVO7A6iiwzKo68lmRGTZa2Hv2i5ik23k6zCXZgzX0cSgtpA8KTqLpBFKduA6GAJoiqoqoUz4yEKRobVK0aXhS9Mtpm6qVipwV5el32RQ6hT5NpPoH/8TgyUfbO+XdZLNVp5tXNFUeUZlXHhJycvC7u2ncI9mlHcZb6PYj5gYPCif+B8EfXBGThTyvSyMUMpr7oDGTygMiJ7GWe0ZEIPzjpG/mNy0UGLObCuoVGl81bQQb41RTBBTnudA0B1zmEgzvMCT/DBze/BDO1MJ58DyAk/CxLpMkOCxo2+YaYPglHW8ti+ifACJqxc8IZ2AfYZ3eNEOh2UyBALmsBWBXynEtPOXH3MZvvIJb4Ke+co3MaLSw1Bqv1WfXPWmPxVQsOzvHyVercSHnI4QjIGBdz/YiGJyC3h6qKITXcRWE4hF4+wwzmcz1rMecBKdI9XrG4HouhrFl1EYqSrBcI0HVwVV8T8ZqREp67Wj+o39llFfqzsuX9nYvZiDxlVKfaysErpIvKl/Z2sYRWVg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(66899024)(478600001)(38070700009)(316002)(41300700001)(71200400001)(26005)(66476007)(7696005)(54906003)(9686003)(110136005)(53546011)(2906002)(5660300002)(6506007)(76116006)(66446008)(66556008)(52536014)(64756008)(8676002)(8936002)(4326008)(122000001)(33656002)(55016003)(66946007)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlFuL05IRk8rMkFNd3B4ZjdmU3BSd2laUWZ0YWJYQnphZjVxMmpXMUtXQnZv?=
 =?utf-8?B?aE9CRmJ5bzZkaThpaGVmdTZOTmRheUlkU25sWWF5aFREdjZzNUx4ekNxc2tZ?=
 =?utf-8?B?RTdTRFRaaUJrOTRNSVlFT3IvUnRhWENtNTJLRGtnVlhqYm1jWVByRnhhUWVh?=
 =?utf-8?B?NmxCMlBNMitoNVRzU2srOG9EQTJpVThadHVranB1SkNYMFFVMk9udmtUOXZY?=
 =?utf-8?B?UXBFUzNlVzhINGhaZWEwdURnWWtVa0lDSlh4VG9QV2FYL0NoTDBhRlk4TGEr?=
 =?utf-8?B?UWVyd295cTd4Mk9yUVVEL2xhMzFWc1ZVcVBJb1lKZksram5FQkIwd1ZHa3VI?=
 =?utf-8?B?MGI2VDR3NTdnSGNhMmNoRG93bjBOL3N1RnhFTkw2M0lUT3NlektJc0lKWnFE?=
 =?utf-8?B?bi9zaEFYUEVXdHBJTTFMUGkyODVndEczM2tCMStSR0t1ZmVJVXUvNG1FUFFa?=
 =?utf-8?B?eTlEVlZTR0JXbjl0TE5HK3dLa3Y0TkJvMDFGOUVNRTQ4NHdETXluZEFDdWpK?=
 =?utf-8?B?NFJmZy9IMkJDVWE1Vi9uNGcwUW9xcFpyS1M5dTIxRCszZm13SjZpa1g5SlF0?=
 =?utf-8?B?OHRJTjJkVjh4VjVyeVFvTUtjbEQ4TytsMDAvbE1acStKaTVmQkIzYXIxMnhF?=
 =?utf-8?B?NVd3TWtWNTVPdGEyajdGek9rSXRvTE42ajdrYTVPekpITGZidVJzM1ptVTIz?=
 =?utf-8?B?OVM3U2NvT3hZSkpqN1dqbHpKd212NXhlaXQwdU5QZ3c5S0QrMTIxYVUxaThD?=
 =?utf-8?B?Z0pmYW1zMkE5S0krWmlWelRxSkw3MnNYOTdONWZZalJ0WFU2bVdvdE9GVzR1?=
 =?utf-8?B?N2haNEpBTFhxd1c2N3hCNkt3ajJXT2l5SVBRMENtWHBCcDh1RENLMGwzeGdv?=
 =?utf-8?B?SnFFTHpDZ1lEUWIxNHpwTUw3d1R3amdsNmpmZjEvUldKai9XbXE3RXYzR0lj?=
 =?utf-8?B?WTJpNkZYdDhqUXNGc3kzU3RnSE5JRHVvWVd1cVZ2bHN5OU8zc3JkOHF4bW5m?=
 =?utf-8?B?bXpPczR0N2Y3S2Q5bGVWWStHVnptYnBFcmFUeUl4SmRBWnBNb0JBTnJsL1lT?=
 =?utf-8?B?dVZMeXZzRm9jRnMvbWg2SFh0ZUkyeFlsQkhUU3JFOFVPS2pqNGUvdXJWNmF1?=
 =?utf-8?B?cktOcHJ5bjc1dFZ2a2xwbHBtNzg3OTZaaWQ0YVVpTkJKL2xaQ0tZRnVOQmR2?=
 =?utf-8?B?NDFVOCtndXhIdy8yKzdRcDFTd2l0cFJ5bFpYL3NTL0IyYTZkUER0S3RrNjl0?=
 =?utf-8?B?S1pyNVhRU1pLRmZTT1Exb05VZ1p5eW1VSlF4dEQxTldDN3hyYU5HOHFzTnhV?=
 =?utf-8?B?NzNnRWEzS1JmcHYrQ0tGTHBQQXJuNjZwNExIN0xweFlxcDNpa1F4YkVuYTlu?=
 =?utf-8?B?MlZCbUljYlJGb0dYZ2lwcmtodEZtMHd6dU5hbE1DbkozTWJBOHo5ZHozUDFs?=
 =?utf-8?B?NGJYcFllT1hMaXloNTNBSmxFQzJuUWF2S3lBQTBMakxiRkdodHVqdDNnQk93?=
 =?utf-8?B?WVViT0FQelRQQXFVYXpJWkdHSWlRUm5LdnB4enFFSkpGTktlMnJHWkpHbFJB?=
 =?utf-8?B?b3g2NGJaUU80U1VnQUwxTTdPQ0h4ejQyN2NtMW9JS1lyVjljK0RGUWRYc1ly?=
 =?utf-8?B?dDlvWEVzUG9xZVZkeVpFbWxRWDY5K29HeERQcTllSWRQNGlkVHh6ZzBOWnd2?=
 =?utf-8?B?T04xVXFSNS9PdUUvcXZCSDhWanNmTXlHdXAxRzdHR3lLL1VPQitsNVJVWEJk?=
 =?utf-8?B?UVpaK2FNYjNoWmVFanRJQzlRVS91SHRNV2p2c2lpOWVNMlVNWWY4eG1USEZa?=
 =?utf-8?B?S3RxbmFVRno1UlpTVmRIVVZCMkUxWStzRXMvU3duM2V2MUdVbysrT1QxMVNi?=
 =?utf-8?B?Szh0eHFpd1dmUWo4WVRETWROWHR1QW9Ra1lYY2lBN2d1bzdjVDVrREdnVkQv?=
 =?utf-8?B?REFzRmx0aEJqQ0dpY1F4SlpPNTR1U0o0QUY5emg3aFQwN2R4dTFqcmJVbTBh?=
 =?utf-8?B?UVBISnU2SjV3YWdWVjFnRklESnlTRTEwQS9raUdkRHZSZzdJR2g3dmFEYXdJ?=
 =?utf-8?B?Q0FFc2dvT2JQRHc5NE9ZWGRFbGVicVJuSEtOT2M3OXIrd2Q3bWh6K0pEOHlq?=
 =?utf-8?Q?rCdM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eOKyGbiOW9oi12mWxwu3YVpZnYS70Lgdjrs2TB7Y/jYjPAXa5K9jUA/nvHRnET/dpJpA8Jf+PSnsa7hbth7PXmdo/aaL8mKe05VIKMS1PTyuj6ZKa4wuKnRApzXNY4s5zUumj56Dwsh2kPGyU+lN/U6TH8nI47hqM5WMfsrgFTPEAk5KX2KcKKqbkEYuWoMzNyyj1Fh7f/Me9wAQb1jtCuah+yi4djubVU8kJgiil7kQkbU/CRE9nuFdAnCMOI7LxXFQbBiOmRW/i7QPU70cUoP77ZKx2hyHULRYT9k53Z1bdO/AZCGgY8J62BZsy8UdBpf1BvtJuEiAhI+2FjJbY9N4A2vR/cQXS4W0CpqACT9vm5YkAkN+Fj/O2jYE52tCSN5uDEp0eYp8ve0NCiAkD3dLc8k8Xdfxtm5H+G8GHMnXez181bySO5Fm42F0D42yVZGpMjkBCzYhqgY9GIsUxYDJMKwx9MEcTXyqF0Jkpxg87Fw9jlJAZWRLr/RF3A0B6n0/OlEGUEahz4OWTArNozKHyTJ7GTLIjlX2oIFMUFvzjOjuY5GQlkpFT7fJd0Mw7fyBVz7eFWAFs+3mUMXAdSySFE0LjzzoeSiicgO8aJLJrr+7zkyvcfn+De9V7Ikd
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4125b11a-8628-43fe-162c-08dc2f13d044
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 17:22:12.4416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BRWbCCmB+q4JL5uYskEDaDsppd7mBftZVAbEJvFZxLbwhRMjCDPW4UgV6lO1naCAZG+bdpvuiGX95Zw3o9AUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8468
X-Proofpoint-GUID: qvarc-lMbCHKTGbZeQOGksunX_TU8J_q
X-Proofpoint-ORIG-GUID: qvarc-lMbCHKTGbZeQOGksunX_TU8J_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=546 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160137
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGF5bG9yIFNpbXBzb24g
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTMs
IDIwMjQgMTA6MjcgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4g
Q2FpbiA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxx
dWljX21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5j
b20+OyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyBy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJl
di5uZzsgYW5qb0ByZXYubmc7IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjMgMi8zXSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUGFzcyBTUCBleHBsaWNpdGx5
IHRvIGhlbHBlcnMNCj4gdGhhdCBuZWVkIGl0DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9y
aWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBh
bnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+
IFJhdGhlciB0aGFuIHJlYWRpbmcgU1AgZnJvbSB0aGUgZW52LCBwYXNzIGl0IGV4cGxpY2l0bHkN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFp
bC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbnRvbiBKb2hhbnNzb24gPGFuam9AcmV2Lm5nPg0KPiBU
ZXN0ZWQtYnk6IEFudG9uIEpvaGFuc3NvbiA8YW5qb0ByZXYubmc+DQo+IC0tLQ0KDQoNClJldmll
d2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCg0KPiAgdGFyZ2V0L2hleGFn
b24vbWFjcm9zLmggICAgICAgICAgfCAgMiArLQ0KPiAgdGFyZ2V0L2hleGFnb24vYXR0cmlic19k
ZWYuaC5pbmMgfCAgMyArKy0NCj4gIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgICAgIHwg
MTEgKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBi
L3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oDQo+IGluZGV4IGFlZGM4NjNmYWIuLmZlYjc5OGM2YzAg
MTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oDQo+ICsrKyBiL3RhcmdldC9o
ZXhhZ29uL21hY3Jvcy5oDQo+IEBAIC0zNDMsNyArMzQzLDcgQEAgc3RhdGljIGlubGluZSBUQ0d2
IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQsIFRDR3YgdmFsLA0KPiBpbnQgc2hpZnQpDQo+IA0K
PiAgI2RlZmluZSBmUkVBRF9MUigpIChlbnYtPmdwcltIRVhfUkVHX0xSXSkNCj4gDQo+IC0jZGVm
aW5lIGZSRUFEX1NQKCkgKGVudi0+Z3ByW0hFWF9SRUdfU1BdKQ0KPiArI2RlZmluZSBmUkVBRF9T
UCgpIChTUCkNCj4gICNkZWZpbmUgZlJFQURfTEMwIChlbnYtPmdwcltIRVhfUkVHX0xDMF0pDQo+
ICAjZGVmaW5lIGZSRUFEX0xDMSAoZW52LT5ncHJbSEVYX1JFR19MQzFdKQ0KPiAgI2RlZmluZSBm
UkVBRF9TQTAgKGVudi0+Z3ByW0hFWF9SRUdfU0EwXSkNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5p
bmMNCj4gaW5kZXggODc5NDJkNDZmNC4uOWUzYTA1Zjg4MiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0
L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24vYXR0cmli
c19kZWYuaC5pbmMNCj4gQEAgLTEsNSArMSw1IEBADQo+ICAvKg0KPiAtICogIENvcHlyaWdodChj
KSAyMDE5LTIwMjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cw0K
PiBSZXNlcnZlZC4NCj4gKyAqICBDb3B5cmlnaHQoYykgMjAxOS0yMDI0IFF1YWxjb21tIElubm92
YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMNCj4gUmVzZXJ2ZWQuDQo+ICAgKg0KPiAgICog
IFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQvb3IgbW9kaWZ5DQo+ICAgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkNCj4gQEAgLTExNyw2ICsxMTcsNyBAQCBE
RUZfQVRUUklCKElNUExJQ0lUX1JFQURTX1AxLCAiUmVhZHMgdGhlIFAxDQo+IHJlZ2lzdGVyIiwg
IiIsICIiKQ0KPiAgREVGX0FUVFJJQihJTVBMSUNJVF9SRUFEU19QMiwgIlJlYWRzIHRoZSBQMiBy
ZWdpc3RlciIsICIiLCAiIikNCj4gIERFRl9BVFRSSUIoSU1QTElDSVRfUkVBRFNfUDMsICJSZWFk
cyB0aGUgUDMgcmVnaXN0ZXIiLCAiIiwgIiIpDQo+ICBERUZfQVRUUklCKElNUExJQ0lUX1dSSVRF
U19VU1IsICJNYXkgd3JpdGUgVVNSIiwgIiIsICIiKQ0KPiArREVGX0FUVFJJQihJTVBMSUNJVF9S
RUFEU19TUCwgIlJlYWRzIHRoZSBTUCByZWdpc3RlciIsICIiLCAiIikNCj4gIERFRl9BVFRSSUIo
Q09NTVVURVMsICJUaGUgb3BlcmF0aW9uIGlzIGNvbW11bml0aXZlIiwgIiIsICIiKQ0KPiAgREVG
X0FUVFJJQihERUFMTE9DUkVULCAiZGVhbGxvY19yZXR1cm4iLCAiIiwgIiIpDQo+ICBERUZfQVRU
UklCKERFQUxMT0NGUkFNRSwgImRlYWxsb2NmcmFtZSIsICIiLCAiIikNCj4gZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9u
LnB5DQo+IGluZGV4IDE0ZGNmMjYxYjQuLmI5NmY2Nzk3MmQgMTAwNzU1DQo+IC0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2hleF9jb21tb24ucHkNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1v
bi5weQ0KPiBAQCAtMTAxLDYgKzEwMSw3IEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOg0KPiAg
ICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYignZkxTQk5FVzEnLCAnQV9JTVBMSUNJVF9SRUFEU19Q
MScpDQo+ICAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCdmTFNCTkVXMU5PVCcsICdBX0lNUExJ
Q0lUX1JFQURTX1AxJykNCj4gICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFEX1AzJywg
J0FfSU1QTElDSVRfUkVBRFNfUDMnKQ0KPiArICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYignZlJF
QURfU1AnLCAnQV9JTVBMSUNJVF9SRUFEU19TUCcpDQo+IA0KPiAgICAgICMgUmVjdXJzZSBkb3du
IG1hY3JvcywgZmluZCBhdHRyaWJ1dGVzIGZyb20gc3ViLW1hY3Jvcw0KPiAgICAgIG1hY3JvVmFs
dWVzID0gbGlzdChtYWNyb3MudmFsdWVzKCkpDQo+IEBAIC0yMDEsNiArMjAyLDEwIEBAIGRlZiBu
ZWVkX3AwKHRhZyk6DQo+ICAgICAgcmV0dXJuICJBX0lNUExJQ0lUX1JFQURTX1AwIiBpbiBhdHRy
aWJkaWN0W3RhZ10NCj4gDQo+IA0KPiArZGVmIG5lZWRfc3AodGFnKToNCj4gKyAgICByZXR1cm4g
IkFfSU1QTElDSVRfUkVBRFNfU1AiIGluIGF0dHJpYmRpY3RbdGFnXQ0KPiArDQo+ICsNCj4gIGRl
ZiBuZWVkX3Nsb3QodGFnKToNCj4gICAgICBpZiAoDQo+ICAgICAgICAgICJBX0NWSV9TQ0FUVEVS
IiBub3QgaW4gYXR0cmliZGljdFt0YWddDQo+IEBAIC0xMTI4LDYgKzExMzMsMTIgQEAgZGVmIGhl
bHBlcl9hcmdzKHRhZywgcmVncywgaW1tcyk6DQo+ICAgICAgICAgICAgICAiaGV4X3ByZWRbMF0i
LA0KPiAgICAgICAgICAgICAgInVpbnQzMl90IFAwIg0KPiAgICAgICAgICApKQ0KPiArICAgIGlm
IG5lZWRfc3AodGFnKToNCj4gKyAgICAgICAgYXJncy5hcHBlbmQoSGVscGVyQXJnKA0KPiArICAg
ICAgICAgICAgImkzMiIsDQo+ICsgICAgICAgICAgICAiaGV4X2dwcltIRVhfUkVHX1NQXSIsDQo+
ICsgICAgICAgICAgICAidWludDMyX3QgU1AiDQo+ICsgICAgICAgICkpDQo+ICAgICAgaWYgbmVl
ZF9zbG90KHRhZyk6DQo+ICAgICAgICAgIGFyZ3MuYXBwZW5kKEhlbHBlckFyZygNCj4gICAgICAg
ICAgICAgICJpMzIiLA0KPiAtLQ0KPiAyLjM0LjENCg0K

