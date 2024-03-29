Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600B9CD1284
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 01:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq0hC-00066m-CF; Thu, 28 Mar 2024 21:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0h8-0005uB-PB
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:06:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0h5-0003yC-Cv
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:06:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42T0Vbbo019249; Fri, 29 Mar 2024 01:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=JZhYRkYbFr/3eTOLzgTyY6WWtte9g+S0QXZTSptyzNY=; b=ID
 qHKbLiZLoIaR7EgvhvmL71Q8xWmJPNA92yUhCQo5jJk8i+YfXXVBRMXRPt2T5nuK
 UsTxsFHuDeZu4Dn/l/zZIGWpY+1zrSNayweCYjzCEpZQa6zWWsWUmfpTKvMptM3s
 eEt/ckgFt5cOqzM7r0C8rHDpXbUaBrro95HlodZG7I6VeQLRiXz1rv25U5L5qlZu
 /JYNgIQlwR7WsO9fr2GQZBZiv5ddc6nKnlq5jgdvCFMc74i3VsoPiyoIZarlfpki
 zdv4NjlfVZhd1C1E+VEh/XimgWpbKuk9tlwWMdrjDziV7JRbt81pmUvv3pWinj0h
 s4iDxcaUdxOXz60+AfhA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5hskg6pu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 01:06:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTyQEQjmpChzsnoWssUe3dA3ef71fTiMdJm+jGGNValW3uTHWugheGLtCjdP697S10P+UDM1jzE67rVYObb14q/Red/KvAhv5VjCXN9Gi1JhrQXvS5ZTqnZ1vdB20rxJ12Sq/nv6F7I8VWW7fupC57XhkWI5q1JGUM4zM5tZhJO7fKzWQ5BMbPo5rQcRiyTqbYOWP0AJQWOTRzkyC+Om212qzsFaaPIuk0aEEZwe/fWphbIY9gZYVCjoF9waaUk6nW+7O8biglIvNzGc159G+RZT6ZOZaWI5/IJdkKbJjAm/5dp5XBg3p1WSOI4UMHYGox5Pv9PMae7hs7wOIXw04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZhYRkYbFr/3eTOLzgTyY6WWtte9g+S0QXZTSptyzNY=;
 b=WWUwWp3Jpyg1igVtBa7a8rC/TPS5KE17RBio/ESm2OicrmCMT2EGNnc/5tVkgt27+oejp9JDUu7OoVP+YMDM9yAG0YUToPp0W4EQYeKloOnmzhfHDsKCvhNKH4q6z/WDS+VcH+oD+jbs3YmgWDNgarW5ZIK+qRY9/0uKQWzgehGCPD3oGoBwES3Zeo7nwJN7bvKE2bU9b88e2XDFvJ8Kbr9jEhUOBWS5la23eDEpixl4qSUlUqtOdV+9AtjQA9oWD0MoVgwjh84s7XHCq842a5ocjacn1T33dwTvZd/413xa/TpbXmDUoglRzlx8Km4gnlqW+RJC52lmJcTMcC69ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by SJ0PR02MB8420.namprd02.prod.outlook.com
 (2603:10b6:a03:3f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:05:59 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:05:59 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 1/9] Hexagon (target/hexagon) Add is_old/is_new to
 Register class
Thread-Topic: [PATCH v2 1/9] Hexagon (target/hexagon) Add is_old/is_new to
 Register class
Thread-Index: AQHacD7XTsAHm8r6Mk2yx6sVxCPkL7FOCgDg
Date: Fri, 29 Mar 2024 01:05:59 +0000
Message-ID: <CH3PR02MB10247BCED12F7AE72B87D155EB83A2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
 <20240307032327.4799-2-ltaylorsimpson@gmail.com>
In-Reply-To: <20240307032327.4799-2-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|SJ0PR02MB8420:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OaQK+8zLfEE42BS4eqwx5EF5hv4tBAF6vjHX2f+hRRHeQdQCc+kBXlqM5EmhPsi2X1tx1rh5dpU096NG7Ta6QSXrSaBG9vaoO2iYExyv2gG99lsPzYHp5HRU7nQJ9vJ1/Q5siwdxW2/XwgsZONSeXuEOEFmewZAmFs0sm4eSWIuX9QFSXmZEk4pwA70YRzjaoGaisN4qJxfIg3kxrJldXw52HEAyOCBGg8Oem4licnwb7AzgfwtCFPtltyou+JkxD94lcCIyVF7wB3rIIWTo+ZBfMTLQ87cJ5prP2oQu/S+KAAfTbeoqzO9a1rwIXM12keL9/6kHtssFlS0HHl7b+hhJiZpd908YU5VCsCERf9259SLsWQd+fKXiIRKcWvkfOO2TNDhJvdQPp5xOVEerLHsD0L9CpfWNvrn6eONVnBchsXDjKM14SlyPgauTPmJufm+glrBZv4C4Anc2hhbilM79uXVCbweDzJfsNa6qiwYZTIlanJFzIMG5WxG8ZpgdVOiv3n4mD5fZW+4A1N85P3i6hIXLfAFwgZDzXK4rctMglmDqkGU44bKOw2Ve+n0xh4Er68iiYdLmb1Xv1GNtoDW2HQ6Jvbvt8zZhaJE9Jm8q+pAXvshuSJlW85LbVxKCrlRLJoafo+Sr1JywtURL/W3fsDbUsrNN8GiXBq0Egms=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2theE5HZjdyVXpMbEIwSFpiQ0UzWXQwTGN2WlNSRlBrZVYzMDQzdytTemtk?=
 =?utf-8?B?NU8yMk82WGhraWFFV0pvN3dYaGV6WVEzSVhJVytWMG1oWXNIeW4xajhtNHB4?=
 =?utf-8?B?N3BUTkFPaG4wMlJCQit1UmNDZ2k4VW1JZFlMTmF6RWhmSTBXTUoyMFk1SWoy?=
 =?utf-8?B?T2JhTUw0KzViaFZDSkI2VTZzekRDcU1lYUtrbFU4b1R1aWFmUmYrc0RjcG01?=
 =?utf-8?B?aTdSTUJkQWlQaHhhVFpSdmdFQmh3b2MyaXhHTHFTZ0RVWUxkZ0dWS1V3a2li?=
 =?utf-8?B?VmlIZGphcWJ4SXp6MmxnL2MySmZ4Kzcyd2VPMjV0Q1dFZm8rS2NkL3lJYWJv?=
 =?utf-8?B?cUYxc2libUV5Nm9iRkpmQTQ5NTBKK0FOcTYzZjJWM3FOdGgrOTN5SU1EYWUx?=
 =?utf-8?B?M2M1QWp0TmxMM1N4K2pxZ0tPdlhlV1JtdnhmTzdjaGRrY2RNY2duQVUvS3VW?=
 =?utf-8?B?ZGxpUWRzQnV1MHQza05KRGZEVW9IZVEraVhWTU85YkZ0UmxTVjUwY1JNaW1k?=
 =?utf-8?B?THFZMkRtcEJPWFRqMDNMZzlla1NlSzE1b3Z6c3pxWCtZNjA5MDgzR1RkZ2Zi?=
 =?utf-8?B?cUN4QUNDMlFPZG1QZzZCelQvYjNmekNUand2aUNxdTlCSFl4TnlhTjBRR0RL?=
 =?utf-8?B?RUhtUDdqM28vd2hkcllwMmFmbWx2ME1FNGM3ZFk4aDFmR0VZUGNVMTRtVHRr?=
 =?utf-8?B?ZXV3UEEzMGdoVXUzTFNGNklPektWaUtEV1hnV1FMbE4yRTlqbXpqVXdMZkV0?=
 =?utf-8?B?QVlNN0hUeXBTdHc0YXk5UGN1QUU0SUVySkVrV2w5UG9sUE00YWovOXdrdWda?=
 =?utf-8?B?Mktnci80WmpPYlFxOUNmSFpoaEtHVzZzTjkxK0I5Q05yWEtPcDJqM1NzeWJV?=
 =?utf-8?B?eDJsTlZ1N09UQVRXSU1SU0swZk91N1hZUDQ4b3NCNm04T1NCdnpMR0tSQ1Nt?=
 =?utf-8?B?dFB0a2c1QUdtcktLQ09YWUtPRDA3MnplU2pGL2VzSkJ2QmwxNHBQVmdkWFl5?=
 =?utf-8?B?TG5ZT0R0aU1iMTVkMmVNRWpxVzdKY3JleE9pVVVVd3JncCtMZ0ZncHFvWDNs?=
 =?utf-8?B?bDdqWEptclMrcTJtSkZLYjNYYlR5S3pxWXVUTHp6enV6c0tKRktqY3IyeFd5?=
 =?utf-8?B?TFZmY1E2YU9EUGc4MlY4TFNlbVNJazRXMEtUZkxydjZmYnVnTEtzc1BkbzY3?=
 =?utf-8?B?VGh4eHl2cVRCSWFRN1VtdUpzbmFsVTd5d3l2YkpqcTZGUEpvMFlwOW1kdXJK?=
 =?utf-8?B?TkxTNzJJR1dWOWVjR2t5MUJVWkl0ampwTFJyaDcvOXhqbFN3cGxwL0VyNk96?=
 =?utf-8?B?VUdJRy9qR1l5ZzhXazB4V1lMTGVWUHpSZVpkWWp6NytZREpsYVdrdURYZ2Rv?=
 =?utf-8?B?UGk0SUZmelJ3UHQyMEZCbDFpakpacnlNelNPak9rR094TkFHbm1EYzZyWVps?=
 =?utf-8?B?dFhVZWNzdW9tZFVQcHNnTHpzZTdRa01GSDF3MWNyY0xRTXdzcHIrRVBRSFpv?=
 =?utf-8?B?SUF3emFnTmYvb1FPcUEyMHg0MjY2WXVSMVRuZ1pQS2ZkN3o2ZmRRck1ueTJJ?=
 =?utf-8?B?KytHc1pMN01SYThrejlPWW1kN0tJUVJmZmIybjZJaEcxV3NDT2lrUUczcVl2?=
 =?utf-8?B?NkFPWFpFU1ZyZUFhWFZvTDZXYTFnRENGdVFQby8xRVF3dkFwQzVBTjU2aUNn?=
 =?utf-8?B?bk8xblJRK1Nqdnp6L2xWMWh1Ui9VQUM5QllmWEJnanZENWg3T2VWYjhNS20r?=
 =?utf-8?B?QUFCejdONzlBRDBCMjNYeDJjQU5rLzMzZ0pFZ3pFWUE3RitGMmt2MnZBYTQ4?=
 =?utf-8?B?cThyVVE1UXdheC8xTnhEMzZhOXZudGVEN3pWbE5mdENiK0tCd2tabFNvd0w0?=
 =?utf-8?B?TUs4ZFh4dzRwWjBFNFdLUm4raDhhNm14QVgyYkZMMm04b2NuZUhtQ296eHJI?=
 =?utf-8?B?dklCWGpZQmM4Vy9ZcmxSb3I4Vi9vSTREN04wbGcwOWk4cE9JQVNSL2VGVFJn?=
 =?utf-8?B?UHo1ZUROS3MzajN1Mk5ubmVhN0hTVkhqaFBpTW0zNzhZNlUvY3NUbXdFZEt2?=
 =?utf-8?B?S3VFd2RMZlE2NkxIcC9BRDd6emtJZEZuTHdSRml1ejBQTURFNGxPUCtWdjdo?=
 =?utf-8?B?bWdCM1cwWnBuQWxhZER2cmlqMDRqc1M2anJ1azc3bXVMdnVXaGhwaERTOUky?=
 =?utf-8?Q?kahk3N0zmspprAX4EybPIkX7kKxPJKFqB8c3mTzLmtok?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w1bzcRFj3fl3xPmEPpLu8jtunx91repQLmtnZvVULNpCn+2VAvuxboES6EMEiwNpUchApjYfgCNu0WeEm+zG/c6Vj8oUTMMvQhZy04GTz5RRbGcvaAzXhGNhn5FsMHOc0MIx4Q2QUyrO7MkO18jktqxLdWrrk5RWMHKlGYXBxLgvYxf8XrcWgqOC6PHQXHv74mrtfhtJNsZAMRMBNmMRkVHRT69uh8l6M/9KoD39zHMxmaDJ3AAP27Dcc+SjGhGziT3JNYH2d51mboiQTZlQZjWEA5AKQx06RevdZZASym7WOXANS5T6M7Pc6g4GaTrvuo4OIsm0QyloNHwpEOWx/2rf3XisyPQjDRCv/9Gg/mQMKz1lo9p9tuVtbkVVIDvw+86+e2t3FHCb691y1Kai6pBHzDAHJOoBdE6w4Qs21DT/DLLmclJfIYSEsLQ2Jk+2pEeJhQmobs5HHzuQzm+HYfBzyLV0Ypp5UcqEpBzifrOTLG3A0Fz+U8wbT9xa1aK946RG4vThB5e/m9AdotcB6/xBRoS68+8hr+kGcCoepthA08VKnvuKdtLczLMhUGiYkMhkZZfu9Nt1YT+94CyR+MLWFIfQix/TKecHwcdAcfG3gu5hFvYAhlLFN2FmCvhF
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7aae82-ba66-4d4d-8496-08dc4f8c6533
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 01:05:59.1579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T81T6NuKyr0Bk1JElDZN8yFqFZZcDWPMk6D/9t9wRTUVr+ZP/F6PCi2Y96417mBre2ndgl8kGMijiuZqhc8mEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8420
X-Proofpoint-GUID: hmCdbJYOyKlagPCtIgYPaEqnLddJE37Y
X-Proofpoint-ORIG-GUID: hmCdbJYOyKlagPCtIgYPaEqnLddJE37Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=717 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290008
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
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
UEFUQ0ggdjIgMS85XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgQWRkIGlzX29sZC9pc19uZXcg
dG8NCj4gUmVnaXN0ZXIgY2xhc3MNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRl
ZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5r
cyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4g
LS0tDQoNClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCg0KPiAg
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSB8IDE0ICsrKysrKysrKysrKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkNCj4gYi90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5DQo+IGluZGV4IDE5NTYyMGM3ZWMuLjRiYWNlZjIyM2YgMTAwNzU1DQo+IC0t
LSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weQ0KPiBAQCAtMSw3ICsxLDcgQEANCj4gICMhL3Vzci9iaW4vZW52IHB5dGhv
bjMNCj4gDQo+ICAjIw0KPiAtIyMgIENvcHlyaWdodChjKSAyMDE5LTIwMjMgUXVhbGNvbW0gSW5u
b3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cw0KPiBSZXNlcnZlZC4NCj4gKyMjICBDb3B5
cmlnaHQoYykgMjAxOS0yMDI0IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBS
aWdodHMNCj4gUmVzZXJ2ZWQuDQo+ICAjIw0KPiAgIyMgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+ICAjIyAgaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJs
aXNoZWQgYnkNCj4gQEAgLTM5NywxMCArMzk3LDE4IEBAIGRlZiBpc19yZWFkd3JpdGUoc2VsZik6
DQo+ICBjbGFzcyBPbGRTb3VyY2UoU291cmNlKToNCj4gICAgICBkZWYgcmVnX3RjZyhzZWxmKToN
Cj4gICAgICAgICAgcmV0dXJuIGYie3NlbGYucmVndHlwZX17c2VsZi5yZWdpZH1WIg0KPiArICAg
IGRlZiBpc19vbGQoc2VsZik6DQo+ICsgICAgICAgIHJldHVybiBUcnVlDQo+ICsgICAgZGVmIGlz
X25ldyhzZWxmKToNCj4gKyAgICAgICAgcmV0dXJuIEZhbHNlDQo+IA0KPiAgY2xhc3MgTmV3U291
cmNlKFNvdXJjZSk6DQo+ICAgICAgZGVmIHJlZ190Y2coc2VsZik6DQo+ICAgICAgICAgIHJldHVy
biBmIntzZWxmLnJlZ3R5cGV9e3NlbGYucmVnaWR9TiINCj4gKyAgICBkZWYgaXNfb2xkKHNlbGYp
Og0KPiArICAgICAgICByZXR1cm4gRmFsc2UNCj4gKyAgICBkZWYgaXNfbmV3KHNlbGYpOg0KPiAr
ICAgICAgICByZXR1cm4gVHJ1ZQ0KPiANCj4gIGNsYXNzIFJlYWRXcml0ZToNCj4gICAgICBkZWYg
cmVnX3RjZyhzZWxmKToNCj4gQEAgLTQxMyw2ICs0MjEsMTAgQEAgZGVmIGlzX3JlYWQoc2VsZik6
DQo+ICAgICAgICAgIHJldHVybiBUcnVlDQo+ICAgICAgZGVmIGlzX3JlYWR3cml0ZShzZWxmKToN
Cj4gICAgICAgICAgcmV0dXJuIFRydWUNCj4gKyAgICBkZWYgaXNfb2xkKHNlbGYpOg0KPiArICAg
ICAgICByZXR1cm4gVHJ1ZQ0KPiArICAgIGRlZiBpc19uZXcoc2VsZik6DQo+ICsgICAgICAgIHJl
dHVybiBGYWxzZQ0KPiANCj4gIGNsYXNzIEdwckRlc3QoUmVnaXN0ZXIsIFNpbmdsZSwgRGVzdCk6
DQo+ICAgICAgZGVmIGRlY2xfdGNnKHNlbGYsIGYsIHRhZywgcmVnbm8pOg0KPiAtLQ0KPiAyLjM0
LjENCg0K

