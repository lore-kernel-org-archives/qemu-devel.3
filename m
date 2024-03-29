Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91683CD1284
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 01:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq0f4-0001tm-4L; Thu, 28 Mar 2024 21:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0f3-0001tY-2V
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:04:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0ev-0003RL-DD
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:04:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42T0H39T016207; Fri, 29 Mar 2024 01:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=9E3N/IWCLYpvXgeYdVYT6j0/31hIv1Ko7+UTRe7lHyw=; b=U+
 2RglGDKHBh7KfJ4SB5Y+yyWpDcVjyWYthdaQCRrTdacxDvpkKmLJo4PL3te53OZg
 znbfI+BeUqvL2kGg6VHmMGRQGmZ690vmGiRWFJxcG4wcBjT/f2bvNiG/p7sZrR1M
 5Mmyy9nv54Z2QyzOJnBOs/kg2S4RxU8i8wdaojk3nkzyUqXlNmgBlVus5ZsYqVNE
 NgklhuHY11hhm4FcZBfVbwRq3Z8ABV0PrYGNb1KgjI8oWQ22xQnWMGL2KOzz4n4z
 eIDlrxbkRHsVhKHc/iIsDfFF24o7l1DqeElrV/GJMRwXO/wyUApP4r2uY7FyKbSp
 q8n9BLnt8igd5CmyIzVA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5aeg9cpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 01:03:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqWr1dOQvl+SZV8D3AM94C1EFyxIdFO9lsThtzN8u8dudE2e/+TuQrTzaoH9mk+J7KATOMBVccLTfpJNG4oQcnDr3RpL+rLgD+6v6i86+s7gabkY7KzCAl4qXVBMR7TdIeg9yChW0bSbVkqpnKfzj9NBdAisc5OLzmkRDni/GLGPsBUnwHT6x5CEkKCeWOdSSMcFVHtXIH6S+xbk9Domj6hb6Sg1p0hI1ihF1o6kUSaMDTC8ZdSq4z6Ny4HYhafHPcqqHdaul+WHCJGMFrbfPLH124NnUL6sl0iEsZJs7HKi3DEF2Swpi0veE8luDUNO07RrjEBYwqfKsfekkBgEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9E3N/IWCLYpvXgeYdVYT6j0/31hIv1Ko7+UTRe7lHyw=;
 b=B/VxJdWy+KtmEAGAccMMgwOUk0BM6mQgx58xtpnP4TJmFObQ68H6FAPc5xdnY9cxAsuAOebS7ChJglH3UmwVCLBo1NAMlSClGFFkUpoNBcX95W4Y/XAg/sqlfIS/a0ih2OPhqQAWOsWPpZA3YEQInhCxrdi/EC17+tYANQF3wZNTyhz1rXRqpJHix3TbFRzFU9OYmiJyV1Te7VklH+LsJpmGrmZCml7MAzFmYoC5h9aVnUNYcK2l3/jf7cKiVmlR4LIxO5Tm/KNQ+YJwWvF3KV+M4O5GkQverJAZws2zC8jzMk8/ctxeqReME/EPEKnUJM9bfWbbASColdKfcKRSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CO1PR02MB8490.namprd02.prod.outlook.com
 (2603:10b6:303:159::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:03:46 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:03:46 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 8/9] Hexagon (target/hexagon) Remove gen_shortcode.py
Thread-Topic: [PATCH v2 8/9] Hexagon (target/hexagon) Remove gen_shortcode.py
Thread-Index: AQHacD7djCguhpBwV0i9YEfzy4aew7FOCWGA
Date: Fri, 29 Mar 2024 01:03:46 +0000
Message-ID: <CH3PR02MB102476E0FC0812218BE9A65DAB83A2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
 <20240307032327.4799-9-ltaylorsimpson@gmail.com>
In-Reply-To: <20240307032327.4799-9-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CO1PR02MB8490:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFtVrHLv8y9zPSXDh2Hkq3c162X0IwqPYNZVQSDPn1mMx0twyu4ryJhjV1Vyqf+EJkBcIBfZBaAemEdOpSwvfbdze+wCeGHyT1ctTJiVoEKdGrt8B98xIIamdfnO6JDYhp/jqYzyh0sXPHF45YL0SY443okoqRSE/o9NxsnANECzyqlmjqRNdP9opjmmR0my2jnAS9bi1iXuVdK+2mo2h4Bg2m/jsq0rV1PW5Kj4BD192+XHWCTwJacoFiAx9LPigQa0dDt7mCv42xyIQBMHkC87AWsPSzpXC3dqq6fr6VT4Pj/TXjOaHDcLcjJMB6zssf5VY47dT1iNEyhso0dC5J6Qst/nDN8M6xOIzcQSR+zI3dWCc9E6qSqJG0rRPYC3y5vkcAo1Ex87blf7NUJjaNa8fUsnyTYgvb7paUUC2ZW+GkF6vR6g6MWyYn0KZGutWtbEEHZz5QfmE+Zo5bCYiux/sou89DzXLDq0d1dYHGmqTSqOOhyptkGMIgOtBjI9DNjaDxF9MVkEKBuN+pj/UKDTWRLt7SjXoELM+u+sYpyCAkKwEVhqbzFAygOJKiv9WfEiNpwD/VAxVE5kz4415q4WVWastzDte76m9Hsis6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REtOVTlua1AzaG9NenRaUG4ydnByL2xRMUU3KzZYNWNEVHpjdWtQZDB4bTNU?=
 =?utf-8?B?YkEyWk9CTS9oTVdkV1RLd2hUV0lIb3JmSFRRSkgzQW16VVdRN1VjcHRZbW1S?=
 =?utf-8?B?bklEbk91c0dmaEwvcjBidDZpZG1VUG5RNk9JTnc3STJrUkxqS0pUYzNzclZN?=
 =?utf-8?B?bnd2aloxbUsxVng2cS81eGlWS0RKd2lkaUdWenFFV0Q2aUFHSVpQd0hDUzBl?=
 =?utf-8?B?Wkg3amVBa0p6ZHVtaUp3a3NrRms0aHlxTDZ1R3lqbWJoeUg5UXVtN1FMN3dp?=
 =?utf-8?B?TGdsNC9adXlEei9yRTU3cnFkS0xRYzJRR0dXR29Id0xUd0Z5TVQySUZtQkc4?=
 =?utf-8?B?VmdrMlVSQWRLZUlKUVhqbEJia1g4WDJodDVIUFVoQW53djF5cVBCOVdveGNY?=
 =?utf-8?B?MUtKM3RIUzFrczI3WE1LQTVweHpVZHFvUVhNSnFpZmdOcVFRTG1aVXFSMjFM?=
 =?utf-8?B?b1YzV3U2eW9OdEQrSlJYNnFReElKVWV2cmM0VnpmYVZuUyt5SGFuOFo1K1Bi?=
 =?utf-8?B?aUh4VmFudTZjazVPK3pPaVB1cXZhaEdQeG1iV1kzVjJPY1AyOGd5OXoyVXdt?=
 =?utf-8?B?RXh2TXQzRDR5ZlZoZTFHMTF2N0R0STlOSmlZL0tLRjc0R1oxVDNNdTJFZC92?=
 =?utf-8?B?a3lodzloS3Y2VmV3UURXQ1RKREl4RXcxVmlacmYxV1JxMFcxVmVIREVYbkhm?=
 =?utf-8?B?ZUhlL1h4N0pCY0lqdHV0Q2tTWW1yRjF5VnRrY2hDd0NCQjMzQWV3NnBoRzNl?=
 =?utf-8?B?d0RtdW9rRFdFL2Y1eDVjUXJsclU2Nm9WSUY0V3BwRVZqcGEwZ2UvZGEvM3gw?=
 =?utf-8?B?TFFndUM0QWtoYUExY2c1Z21GQnpONnc1U3FxclJXZHJCNjdMNTJZTzZadDBL?=
 =?utf-8?B?MEt6M3ZJYSszWnk4OFlPVUoyRzI3QkhNRnFWcXhidHZvendOU3p3cC9mUGl0?=
 =?utf-8?B?c3JES2ViYXdWNG9vdHpuTTl0TUtrYU1jbWVSOGJjWjFTNWZHQlJFZi9jcUIz?=
 =?utf-8?B?MVg4S2hsNEdXUXFqZFRabXBjbXBFeGFjd3Y1UzVQcGZNeExOUGJNUkNNM2RM?=
 =?utf-8?B?K3NRZlZHZmlHbkxoK0JmeUJJQXdkcDNxcG1yMjFlVnFIc3QrT3VqMGg0L0J6?=
 =?utf-8?B?YmQyQTlVdkhZRjdDUE1CeGpNVnpCOUFzbWRhOFlZOFk2WTF2bTBWVTkrQVhP?=
 =?utf-8?B?S3BPSE1RMXdITFhEVUJwTHBMa05WeDZkR2tlMTZFbThKb1h5NWdjbUc3Sk80?=
 =?utf-8?B?cnZuVWJkNHI4Nm5HVGZqbGxieUh5VUNjY3l4bElHLzA2Zm04VFlWQUswNVMx?=
 =?utf-8?B?UnZBWHlBemJKYkcrR05NUnNDMmtKMWgxNzl4UEtZMXZ4eGluaERucng2RzQy?=
 =?utf-8?B?TDAzTGNtZDVtMU5IdjRkSFNXRFI1REtJQklVaS9CVmxhc21VZGpDQS9xa0I4?=
 =?utf-8?B?RVQ0T1N5Zlk2b05XSnFrTm1hb0hLVEJuZnRoOEVrdjFBVngyYmtxUjlFZ0Zm?=
 =?utf-8?B?VEswNC80eW5HNldCUlRRSER1RGo3RFNRL3hMbit0Y0R0V0daL2xyajFxYnhT?=
 =?utf-8?B?WldIdVlrc09saGFrSkY0U0d5VWFHSUtrcm1tcElPQnB5WkIyRVBSY0ZUVTdo?=
 =?utf-8?B?Zmx4eDc4ZFQrdEJaM0Z4bHNEK2I2ZHR3TzZ2TklYdHJZbTZlb2hJb29GeUJs?=
 =?utf-8?B?cHhsZCtLMEFPZzhnbEVoOEExSS9xYkkvZHpoY1VrbUs3M0VoTHJ2czJpUUph?=
 =?utf-8?B?bnROdUpsenFiK1ZtY1ZhVHA0SC9rUmpLa0h1emROZExtK2ZWT1RxYnloTnQ1?=
 =?utf-8?B?d0ZIVHE3WDNtOVkzaWVNU3c1OXhLWFloZWpYc3ZnZ2pjVTArUHArSXZScTk4?=
 =?utf-8?B?UVFhNjNLK3IydndIa1lkYVJvcFpkdU1DZXZnd2g5d2pqT1N5Zk9yUW5GSE13?=
 =?utf-8?B?TVhPdENQc1dhSDdEVmVla0JIZFNZWC9QZVVJdHo4T29nM0JvUE9MOVpGUHpW?=
 =?utf-8?B?bHhnYlR2Q2d2VVNIL1ltUEdOSEo2akVVc3llRHNxeFdENkt6MTZ5Qy9tcnA3?=
 =?utf-8?B?TnhUL3BNRUdlRlRZV3V6OHkxZ3I1OTdWbWEvOFVpd2JUVmdxalVITUo1TENB?=
 =?utf-8?B?ZkFYZjF5LyttamFvWU5JaEFxY05JTVVhVkFTWnlJVk9CZmV4dkl3d0dxOWNx?=
 =?utf-8?Q?YCewu3CeUBqAX7gnfNin31ECL1GOij6SBVE2sCZIKCF1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x2Zqpm6MF4qTk8iI9N6azw6Jhtsfb7GmbMOyeU4x7ED10MZoH6LwOh9OARwiy1Xas/vfQLKltaVk0V96hz6VyftR5JBtzJN0eoyZMOznH2Ike3qWWNmxa5HDO6HZ+R1Nq/y+oN75FT4uiFAABkKeFasgkxJBpejelRMDpoW4HwJZvqgUEYfsbj3tmudCwmTuvCoK2Fb1TfRhflNdqG+Sd+8BH/43IsfnDkrkyUs6yc8dI1EqtspnUcc1kdaBaEkxoKPKX+fCMHdBt9GtiRFohR6mNoBdAh1DFA/mGwaIdDUC8mV9X4Iibab2gUOCavFYzVENyWaJzFF4IPobVBKfyiQZak4eoL6fPk1U2M4gt7irH/Ur7HoQQSFJSB27AWh8Qgazh+1ofvifgdYo1F01goB0AWFv/5GCMvvlBH7B7gy9Luy86aX/zL8AJvs4OlpolXy3zAeczulvkI3/B50EQHoPccA8XXZt0mzW+gmVSXviBEEUYLueAm5UZYKFCq8egz3twRQXsS0vK4JkpU4MWaYpkEWx1PJsMrj6Xt454kk4A13GGsiIbbQia/into6A+/spWVr3zTjbUIZcsdexZ0gZ+tg8DT9PXiJlyaexfHTS7wh/bEnenjCYVp64D+lR
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a28a24b-342f-4efd-405f-08dc4f8c1642
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 01:03:46.7012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZMkT1yMPav5xnH3knwDi+eHa18uS8dqitqWL49HMgc7IdKrznvsSWeDrrNF9Hf0YNloFlXpfxCkv3XXrrmR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8490
X-Proofpoint-ORIG-GUID: 0mpjNH38vNcPpXvWNryv_2d1qalwOrzb
X-Proofpoint-GUID: 0mpjNH38vNcPpXvWNryv_2d1qalwOrzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290006
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGF5bG9yIFNpbXBzb24g
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA2LCAy
MDI0IDk6MjMgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxxdWlj
X21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+
Ow0KPiBNYXJjbyBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+Ow0KPiBy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJldi5u
ZzsgYW5qb0ByZXYubmc7DQo+IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjIgOC85XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUmVtb3ZlIGdlbl9zaG9ydGNv
ZGUucHkNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50
cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gVGhpcyBkYXRhIHN0cnVjdHVyZSBp
cyBub3QgdXNlZA0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3Jz
aW1wc29uQGdtYWlsLmNvbT4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2Fp
bkBxdWljaW5jLmNvbT4NCg0KPiAgdGFyZ2V0L2hleGFnb24vb3Bjb2Rlcy5jICAgICAgICB8ICA3
IC0tLS0NCj4gIHRhcmdldC9oZXhhZ29uL1JFQURNRSAgICAgICAgICAgfCAgMSAtDQo+ICB0YXJn
ZXQvaGV4YWdvbi9nZW5fc2hvcnRjb2RlLnB5IHwgNjMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ICB0YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgIHwgMTAgLS0tLS0t
DQo+ICA0IGZpbGVzIGNoYW5nZWQsIDgxIGRlbGV0aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAw
NzU1IHRhcmdldC9oZXhhZ29uL2dlbl9zaG9ydGNvZGUucHkNCj4gDQo+IGRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9vcGNvZGVzLmMgYi90YXJnZXQvaGV4YWdvbi9vcGNvZGVzLmMNCj4gaW5k
ZXggMDJhZTljZjc4Ny4uYzhiZGUyZjllOSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2hleGFnb24v
b3Bjb2Rlcy5jDQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL29wY29kZXMuYw0KPiBAQCAtMzcsMTMg
KzM3LDYgQEAgY29uc3QgY2hhciAqIGNvbnN0IG9wY29kZV9uYW1lc1tdID0gew0KPiAgfTsNCj4g
DQo+IA0KPiAtY29uc3QgY2hhciAqIGNvbnN0IG9wY29kZV9zaG9ydF9zZW1hbnRpY3NbXSA9IHsN
Cj4gLSNkZWZpbmUgREVGX1NIT1JUQ09ERShUQUcsIFNIT1JUQ09ERSkgICAgICAgICAgICAgIFtU
QUddID0gI1NIT1JUQ09ERSwNCj4gLSNpbmNsdWRlICJzaG9ydGNvZGVfZ2VuZXJhdGVkLmguaW5j
Ig0KPiAtI3VuZGVmIERFRl9TSE9SVENPREUNCj4gLSAgICBOVUxMDQo+IC19Ow0KPiAtDQo+ICBE
RUNMQVJFX0JJVE1BUChvcGNvZGVfYXR0cmlic1tYWF9MQVNUX09QQ09ERV0sIEFfWlpfTEFTVEFU
VFJJQik7DQo+IA0KPiAgc3RhdGljIHZvaWQgaW5pdF9hdHRyaWJzKGludCB0YWcsIC4uLikNCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL1JFQURNRSBiL3RhcmdldC9oZXhhZ29uL1JFQURN
RQ0KPiBpbmRleCAwNjVjMDUxNTRkLi42NWI0ZmNjMGZhIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQv
aGV4YWdvbi9SRUFETUUNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24vUkVBRE1FDQo+IEBAIC00Niw3
ICs0Niw2IEBAIGhlYWRlciBmaWxlcyBpbiA8QlVJTERfRElSPi90YXJnZXQvaGV4YWdvbg0KPiAg
ICAgICAgICBnZW5fcHJpbnRpbnNuLnB5ICAgICAgICAgICAgICAgIC0+IHByaW50aW5zbl9nZW5l
cmF0ZWQuaC5pbmMNCj4gICAgICAgICAgZ2VuX29wX2F0dHJpYnMucHkgICAgICAgICAgICAgICAt
PiBvcF9hdHRyaWJzX2dlbmVyYXRlZC5oLmluYw0KPiAgICAgICAgICBnZW5faGVscGVyX3Byb3Rv
cy5weSAgICAgICAgICAgIC0+IGhlbHBlcl9wcm90b3NfZ2VuZXJhdGVkLmguaW5jDQo+IC0gICAg
ICAgIGdlbl9zaG9ydGNvZGUucHkgICAgICAgICAgICAgICAgLT4gc2hvcnRjb2RlX2dlbmVyYXRl
ZC5oLmluYw0KPiAgICAgICAgICBnZW5fdGNnX2Z1bmNzLnB5ICAgICAgICAgICAgICAgIC0+IHRj
Z19mdW5jc19nZW5lcmF0ZWQuYy5pbmMNCj4gICAgICAgICAgZ2VuX3RjZ19mdW5jX3RhYmxlLnB5
ICAgICAgICAgICAtPiB0Y2dfZnVuY190YWJsZV9nZW5lcmF0ZWQuYy5pbmMNCj4gICAgICAgICAg
Z2VuX2hlbHBlcl9mdW5jcy5weSAgICAgICAgICAgICAtPiBoZWxwZXJfZnVuY3NfZ2VuZXJhdGVk
LmMuaW5jDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fc2hvcnRjb2RlLnB5DQo+
IGIvdGFyZ2V0L2hleGFnb24vZ2VuX3Nob3J0Y29kZS5weQ0KPiBkZWxldGVkIGZpbGUgbW9kZSAx
MDA3NTUNCj4gaW5kZXggZGViOTQ0NDZjNC4uMDAwMDAwMDAwMA0KPiAtLS0gYS90YXJnZXQvaGV4
YWdvbi9nZW5fc2hvcnRjb2RlLnB5DQo+ICsrKyAvZGV2L251bGwNCj4gQEAgLTEsNjMgKzAsMCBA
QA0KPiAtIyEvdXNyL2Jpbi9lbnYgcHl0aG9uMw0KPiAtDQo+IC0jIw0KPiAtIyMgIENvcHlyaWdo
dChjKSAyMDE5LTIwMjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0
cw0KPiBSZXNlcnZlZC4NCj4gLSMjDQo+IC0jIyAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdh
cmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCj4gLSMjICBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQ0KPiAtIyMgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9u
IDIgb2YgdGhlIExpY2Vuc2UsIG9yDQo+IC0jIyAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIg
dmVyc2lvbi4NCj4gLSMjDQo+IC0jIyAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRo
ZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+IC0jIyAgYnV0IFdJVEhPVVQgQU5ZIFdB
UlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4gLSMjICBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
DQo+IC0jIyAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4g
LSMjDQo+IC0jIyAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UNCj4gLSMjICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KPiAtIyMNCj4gLQ0KPiAt
aW1wb3J0IHN5cw0KPiAtaW1wb3J0IHJlDQo+IC1pbXBvcnQgc3RyaW5nDQo+IC1pbXBvcnQgaGV4
X2NvbW1vbg0KPiAtDQo+IC0NCj4gLWRlZiBnZW5fc2hvcnRjb2RlKGYsIHRhZyk6DQo+IC0gICAg
Zi53cml0ZShmIkRFRl9TSE9SVENPREUoe3RhZ30sIHtoZXhfY29tbW9uLnNlbWRpY3RbdGFnXX0p
XG4iKQ0KPiAtDQo+IC0NCj4gLWRlZiBtYWluKCk6DQo+IC0gICAgaGV4X2NvbW1vbi5yZWFkX3Nl
bWFudGljc19maWxlKHN5cy5hcmd2WzFdKQ0KPiAtICAgIGhleF9jb21tb24ucmVhZF9hdHRyaWJz
X2ZpbGUoc3lzLmFyZ3ZbMl0pDQo+IC0gICAgaGV4X2NvbW1vbi5jYWxjdWxhdGVfYXR0cmlicygp
DQo+IC0gICAgdGFncmVncyA9IGhleF9jb21tb24uZ2V0X3RhZ3JlZ3MoKQ0KPiAtICAgIHRhZ2lt
bXMgPSBoZXhfY29tbW9uLmdldF90YWdpbW1zKCkNCj4gLQ0KPiAtICAgIHdpdGggb3BlbihzeXMu
YXJndlszXSwgInciKSBhcyBmOg0KPiAtICAgICAgICBmLndyaXRlKCIjaWZuZGVmIERFRl9TSE9S
VENPREVcbiIpDQo+IC0gICAgICAgIGYud3JpdGUoIiNkZWZpbmUgREVGX1NIT1JUQ09ERShUQUcs
U0hPUlRDT0RFKSAgICAvKiBOb3RoaW5nICovXG4iKQ0KPiAtICAgICAgICBmLndyaXRlKCIjZW5k
aWZcbiIpDQo+IC0NCj4gLSAgICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLnRhZ3M6DQo+IC0g
ICAgICAgICAgICAjIyBTa2lwIHRoZSBwcml2IGluc3RydWN0aW9ucw0KPiAtICAgICAgICAgICAg
aWYgIkFfUFJJViIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ106DQo+IC0gICAgICAgICAg
ICAgICAgY29udGludWUNCj4gLSAgICAgICAgICAgICMjIFNraXAgdGhlIGd1ZXN0IGluc3RydWN0
aW9ucw0KPiAtICAgICAgICAgICAgaWYgIkFfR1VFU1QiIGluIGhleF9jb21tb24uYXR0cmliZGlj
dFt0YWddOg0KPiAtICAgICAgICAgICAgICAgIGNvbnRpbnVlDQo+IC0gICAgICAgICAgICAjIyBT
a2lwIHRoZSBkaWFnIGluc3RydWN0aW9ucw0KPiAtICAgICAgICAgICAgaWYgdGFnID09ICJZNl9k
aWFnIjoNCj4gLSAgICAgICAgICAgICAgICBjb250aW51ZQ0KPiAtICAgICAgICAgICAgaWYgdGFn
ID09ICJZNl9kaWFnMCI6DQo+IC0gICAgICAgICAgICAgICAgY29udGludWUNCj4gLSAgICAgICAg
ICAgIGlmIHRhZyA9PSAiWTZfZGlhZzEiOg0KPiAtICAgICAgICAgICAgICAgIGNvbnRpbnVlDQo+
IC0NCj4gLSAgICAgICAgICAgIGdlbl9zaG9ydGNvZGUoZiwgdGFnKQ0KPiAtDQo+IC0gICAgICAg
IGYud3JpdGUoIiN1bmRlZiBERUZfU0hPUlRDT0RFXG4iKQ0KPiAtDQo+IC0NCj4gLWlmIF9fbmFt
ZV9fID09ICJfX21haW5fXyI6DQo+IC0gICAgbWFpbigpDQo+IGRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9tZXNvbi5idWlsZCBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkDQo+IGluZGV4
IGIzYTA5NDRkM2IuLjk4OGU3NDg5YmEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9oZXhhZ29uL21l
c29uLmJ1aWxkDQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkDQo+IEBAIC00Miwy
MSArNDIsMTEgQEAgaGV4YWdvbl9zcy5hZGQoc2VtYW50aWNzX2dlbmVyYXRlZCkNCj4gICMNCj4g
ICMgU3RlcCAyDQo+ICAjIFdlIHVzZSBQeXRob24gc2NyaXB0cyB0byBnZW5lcmF0ZSB0aGUgZm9s
bG93aW5nIGZpbGVzDQo+IC0jICAgICBzaG9ydGNvZGVfZ2VuZXJhdGVkLmguaW5jDQo+ICAjICAg
ICB0Y2dfZnVuY190YWJsZV9nZW5lcmF0ZWQuYy5pbmMNCj4gICMgICAgIHByaW50aW5zbl9nZW5l
cmF0ZWQuaC5pbmMNCj4gICMgICAgIG9wX2F0dHJpYnNfZ2VuZXJhdGVkLmguaW5jDQo+ICAjICAg
ICBvcGNvZGVzX2RlZl9nZW5lcmF0ZWQuaC5pbmMNCj4gICMNCj4gLXNob3J0Y29kZV9nZW5lcmF0
ZWQgPSBjdXN0b21fdGFyZ2V0KA0KPiAtICAgICdzaG9ydGNvZGVfZ2VuZXJhdGVkLmguaW5jJywN
Cj4gLSAgICBvdXRwdXQ6ICdzaG9ydGNvZGVfZ2VuZXJhdGVkLmguaW5jJywNCj4gLSAgICBkZXBl
bmRzOiBbc2VtYW50aWNzX2dlbmVyYXRlZF0sDQo+IC0gICAgZGVwZW5kX2ZpbGVzOiBbaGV4X2Nv
bW1vbl9weSwgYXR0cmlic19kZWZdLA0KPiAtICAgIGNvbW1hbmQ6IFtweXRob24sIGZpbGVzKCdn
ZW5fc2hvcnRjb2RlLnB5JyksIHNlbWFudGljc19nZW5lcmF0ZWQsDQo+IGF0dHJpYnNfZGVmLCAn
QE9VVFBVVEAnXSwNCj4gLSkNCj4gLWhleGFnb25fc3MuYWRkKHNob3J0Y29kZV9nZW5lcmF0ZWQp
DQo+IC0NCj4gIHRjZ19mdW5jX3RhYmxlX2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoDQo+ICAg
ICAgJ3RjZ19mdW5jX3RhYmxlX2dlbmVyYXRlZC5jLmluYycsDQo+ICAgICAgb3V0cHV0OiAndGNn
X2Z1bmNfdGFibGVfZ2VuZXJhdGVkLmMuaW5jJywNCj4gLS0NCj4gMi4zNC4xDQoNCg==

