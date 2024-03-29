Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5794CD1284
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 01:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq0fk-0002bA-Qv; Thu, 28 Mar 2024 21:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0fd-0002WF-1J
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:04:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0fa-0003X0-Bm
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:04:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42T0ZQDT019376; Fri, 29 Mar 2024 01:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=orw6TvQLLH07HGBlcIES7qFwkBRTDPuxalxO2JuxngI=; b=Mh
 gaFY5RgiV5RQ360rX1ndrh+B10I78jNf7y3tHUpA+XMwrkVMebEc+q33HetSQgRU
 dxfVeIKnrq+bTlyrS4HJXcTw6ZAS++xf0LgnR0Kl2riXrFojI1iXU7HC07EZHnzE
 Oi9b6BnEtsXiebuMBOD8te4zxnWeppwwcnUPAluz+D71ieCC3YKR+pUKP6/EkGlH
 2/qEKC0uN1FkAq55AkT+WLrtiiMOGwt+5KjmOUHOEmrHkhgwtfNFUcBXSRNtWdWC
 HKPqX7G/KYM9OghMPp/r1QtPSSnE5d1OCZSAa+KJjjaUqv6T2iYp7gUwYFCtH3Jq
 WzWpOSPabPg697uNXBUQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxjun2-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 01:04:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EovIRJkO96NPo8RZ2M16m8Y3d17XmzN9XccZFT4Vm1biykKnDKV0/JmCLjQoq5F/IHpzW+plS0NR9KkPYlOlJGP1sAoHi7m3nvqq3ycrblcVZp1JKM1/DFfgbLKGgLt4O6nEcy9t/jQO5cY20k1ije86Z7o0hwOeomUXTSJ0O3rxMplVBZmxpGZx4cIkCA/Xj8CoiqJqSM9OV0sapVy2gLmBeGvYTWkwN+SaVrEK0FhYjc4Pu965s9LZiEYWaNCrGitBLjTykXSAZ3zwjbvb784p3+CGpGDfMQqaazrIMSgNlFgTJVcQnMigUr5eZjtDYebW97VDB0S24Q9AKwYAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orw6TvQLLH07HGBlcIES7qFwkBRTDPuxalxO2JuxngI=;
 b=PC5Rw5VjaUd4z388As8EEq8+cpYVBsmsjvuZSNIy+Fd0cLRq6PQq+5TJGLqw+S8hC1vJuZYyDO9bBoCLBg1b+B6DkCh4RZ7XbaUIo8L9UaUNvJqYHXDn3eFpN8xU8ErzTADR51J69/EudubY8G3okaOhK4fbKPNWayXgcbFAEnCePw1PRbteKwTX1pl7GtI2tdcim0EcQyydgsittaDhtA3nq4BtQpVArvvawKE01asdaBFYODWXAKyRW7UV6D3L/iBEId1+j4l5OInE7tncOMOR9exfZOJiAwY2n+YGHDQFxPCfP9OuzVz3F7NXVeHr5hyct2MTzhtBtocqfSioFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CO1PR02MB8490.namprd02.prod.outlook.com
 (2603:10b6:303:159::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:04:25 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:04:25 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 4/9] Hexagon (target/hexagon) Mark has_pred_dest in
 trans functions
Thread-Topic: [PATCH v2 4/9] Hexagon (target/hexagon) Mark has_pred_dest in
 trans functions
Thread-Index: AQHacD7ainoIf8WfbEKwwDSoNiGgzLFOCZGA
Date: Fri, 29 Mar 2024 01:04:25 +0000
Message-ID: <CH3PR02MB10247248FF4B8C46B752F7E4BB83A2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
 <20240307032327.4799-5-ltaylorsimpson@gmail.com>
In-Reply-To: <20240307032327.4799-5-ltaylorsimpson@gmail.com>
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
x-microsoft-antispam-message-info: cDbUQfT9C9AbwLCTEsaLDO4GQ8qAimJVuwUJigFcGIYEhrZmkjSCVLSSRDtz9W8AA1zEdqQcBGeKq2m+NFsGK7taRdw2L1e3JQvLd5ESjmpCND1UzzZKdrSkHfmRVuB557fP4qvWQJpmzB6bMhZyvyDHu4L+ZcXxdzif3CpxZUCnZjC3Nc2qer23a1yFpEI2APF/EUYWjTigl7w1dvi3bOIP7VT2ktIE7Yxzhg1N2OWjR84X7Kvnl15/toC/HPJZmDRsV2Qr1gOrzcNjYtYZ+l7YhKfRwSSUrVAWPV/+/1C3h57jPkJ9y1L368o9rSh50cHD7+JRSbMdLro8y4j+BONReYA7Pd9ACJ/qU86+N4l4+jAtTCupOx3dN80bruvidp8HReLRd/BFa+C37WHnn3fxdDned49xthH9EPViHGgbV78+Y8/W/qfQbuUFTpIL214Ln8sJ0Y+Us4z9qjMqVgceIa/5aHGKm4GCT2afpUEBkiopyqzKCKU5HXzRGq2s+t9eT0D2sClICT1+8PzXe6X0pXUA08v/PE2KvvHItV/l7wv2GmCNJL1QRnS6QsqUNI3cgzYFpqvZ+mFiu4TNswop1qoHkVxpKzL0kr1QTb5PEFPuyyjwiK0as8ZYnIQrjU4qKw5jxfT9Ka0m3v3ecPETRVfJhN1FjmFL7fC9uBI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkRQZGxiR3pHc29URHpCZ1ZzNDh2enZUZHRRSlB0bWxKeVdxMmZ5cjZlSHc3?=
 =?utf-8?B?dUxlaDBWK2d5eHJMeHZWcHIyTWJrMDJHdlhqazhMK0dhR2cxMkRNVjNoczho?=
 =?utf-8?B?bjdwWjVQWGN1N1E2bkZEQnBkQXFGVHhpN3FXTnJES1dJOExvNjU0dnRTa3dr?=
 =?utf-8?B?TlRGeFl4cUJwaXhOdVRHbWswQ2Rrc3kvQ0xpZG9BK0x6aWhYTkhSNldwOWll?=
 =?utf-8?B?blZEOHpzeGp1aHVTc2pNYWFTNjREYmlKa0VYTUhmZFF5QnJGQnpqeFRGMTIz?=
 =?utf-8?B?b3ptelpORHVHZ1Q1VGs1YVRiNjR4SHZtWDJNWkkzSmRVaDFnOHVDeUhtbTI3?=
 =?utf-8?B?QVNmLzlMVk82VWpySEZEY1lkN01DL3g1c0lQcnhlOURTZ0h6aDA2QWZhUkRC?=
 =?utf-8?B?ZHBTV2huek02MjViSFlrVEIwQ1d6UDk5RVc2OEtxR2hVcmR5eTlaK2tmREJ4?=
 =?utf-8?B?RWpXWkN3WFZGbzJmUnh5aTFMY2VycjgzV1JMM3VNM3hJQmh6aDNxZFQrTGZr?=
 =?utf-8?B?V3VSRUM4cGxVT3JndUl1T213MXN4UXZqSENROEVvYUdodW1mUUhseG5Sdy9X?=
 =?utf-8?B?RUV6WmJycDkyUSt1dGRkY0N5Z1BGZ1dIQ0d5dVRtM2krLzRmei9zOU5STlJx?=
 =?utf-8?B?RWtuNlIyQ2dXTkI2V0FVaHI2SHBqelJNMTh2Y0NxaXRRS2p6N1FycWdDaHFa?=
 =?utf-8?B?dTJ3V2FhQ0hlZDB1dllpdDB3T2QvYTM0eTZVNWdCRW90M2RIWkFjV0NTaDZ2?=
 =?utf-8?B?c1FqWkxKaTJxazJrZ3NSVDE3VGllbkpxT3IzZEFNWmloNzJpK0pWRXZ4Smdj?=
 =?utf-8?B?N0pEYWFTbUdDcytOTHFrOFhhMTMxclRjZWdZUE52dVV5UVp1U1l1MUl2ZG1x?=
 =?utf-8?B?VWQxNlAwMUtKQUFtaXUzUFZ1dmdDZVhYTTZyTnh1dnRPUXE0TkR3V1dsTjJ1?=
 =?utf-8?B?QllBbWxmSFBBcG03UTJjcnk3Vythbi9YeUhsbkZKWWFKbWtxcjdFSDI0VGM5?=
 =?utf-8?B?WFVMZnQ5RzczNTR2bE14RXZSUzIyWVJENGVuUjQxNFA5Wm1XZzV0eldsa0p4?=
 =?utf-8?B?Y2wwN0RMeUN1N1Z3dVlXOHNZQ0ViZVdadUFxZks0TnY1cXRkWFViMVNpcVdW?=
 =?utf-8?B?RzZETWoyWExEcHQweWUzdTAxRWVsMC9Zc2pvb2QzQ2NSQkxhalRrMWJIYVA0?=
 =?utf-8?B?Z3BwQ0RuSjVyKzNLK0FoUjlqNE9jMWwzUmkxVTV6MlZpOWFvMS9PclBWd2ky?=
 =?utf-8?B?bHFBRzdoVnMwQk5EVmJRWUd6RFM3LzByWEp6eEVHWVJPeWRGZ1VlaXpwVk8w?=
 =?utf-8?B?cjZqT3dwdEMvT3g1aUpWbHJPOUMzNE1CTW5MNzY1Y1FadXNNZkFOT1VJeXha?=
 =?utf-8?B?TXArNkcybUgrYnFSUE5QNDU3eEdqU3kzTENzWkhNd2t0T3BlbDFpV2VTT2ho?=
 =?utf-8?B?K0JtRnpxRDhGMVIzNnl6cjZwKzhsU0twZVBsVkVZN0ZES2lxazNjYzYvZWh5?=
 =?utf-8?B?RE9sd00xb00vYnhENEplODlndVh4T0FPS0VKSnVnOEEwTVo5cmxOckR0K2lL?=
 =?utf-8?B?MWVTdFhIc0o2YVVZYmptaTFrcVJVQ0RXYU1GMytMQndyd20wVGhUY2xlc0dE?=
 =?utf-8?B?K25IWXVIOEhHRU1UYXU4UC9vSExDcWtWcDBRSUNkQnA0Q2FjV1BXbjdLdXNw?=
 =?utf-8?B?eVVmWHVBWEFFY1Y3ODJzWDg2L000RmhuOG5maXNlVGVLM05sRXFhRVhxd0tN?=
 =?utf-8?B?NHd5Y28yTlNnckYvR2h1alVDdjlPTkFpWlBjNXN2QmVpOVgza0R6UlhsR0dD?=
 =?utf-8?B?OWJUUVp2WjBudVNtcDBGdHB3RmZFR3hiMW9PQmtteW54bWdpODNzOTB0Snl5?=
 =?utf-8?B?TlpTa2VERHRwMS9CYmUvK1lmcTZhYXJnUTBvajlpVHlBUHdwS2I0bDJSZld2?=
 =?utf-8?B?Tk5vdUFJRU1nbzJpejAxd3hia0I0M0RBTzN4NGFvaFB6Q04zaytrWGRuMGdU?=
 =?utf-8?B?NnE0aHVyWUdNTHlSdXZSWVVHa2hxZGtUbXRxdkJYNnEzODVxSGlEbnhOMm1E?=
 =?utf-8?B?SjBnMzI2VHFCeCt2L3hkSWdGaEZEdnlSZnlSWUIya1FLN21tajZhL3AzZ2Vm?=
 =?utf-8?B?N01sM2pyTnRraTdWUVpIZzg1Wnd6QURHUG1UOE1PTkM0OFBud2xFVDJtVHFx?=
 =?utf-8?Q?DYx2rWxi+2IvJKK0AZhj6GZYNTnb+wT6vOoxKtyjhnEr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rPFqbfyBe1Nt14zLh1uOqAiq7i+rSq/QIdsfp5so2AmcaBQxiBi0QkfOOpoSqaIwXp/vrXX9XQi6lTpb0Bz08MxAHC9qg4BzjSQgvNfPJvMWtXkI5ptDfWsZ2EvQaIwkjvMrMs8bIT6t8VxAgQ7aB54E/M2b4c3XkAerXFOV7PDPKp2VetEgU/fLPTH6OM4UWPavMBg1G1VBSF16ujHjK3NJ9mqHdzb8Y3slEDzZtFJvqArI80u4mSH/Sxdg0YpMGRbTMb9GlNbeuZ760/go5bYDPQbo9Bm0vlakW7P+ZXxmJAFgfEHCLqPS+1QybCfwCauCWmvSAU7EMDY6A1nI0C0n6kmKXdre2N3+glGZuL9i9ZFcUQjNlUmCXs9cbo9S3K/ZF+Pk/Et6PctsU2tO22yh5Q3G1DzHOyv8Y962uDyKT7Zexx5rPiLy6iCQh4MFbcax34JEVPbudOyYBprTei3cskQ8VJB8gbQXKYuxiW3mQK613o9tRYzh5ilEGkBj/Zx9o/aHE7m7EweRAyiTySvaQPg6+AJas4q37oMZo8zSVnUKBqg+/FS+wB42egznFGlaZ2yTe+uE31BQ+DP752/qGxvCuPGvNwxV6EArK7LcTSA1vW5/1QuEbH2fs+pj
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1287ae16-fdce-46e4-8d89-08dc4f8c2d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 01:04:25.1190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWiruVr3QzEECQVrsC6K4uibK97fQy7zzJgKkoVZMC5WMjAmZjTB22dOk/e6xEi7P/hsjrREiog41W+3zV3+Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8490
X-Proofpoint-GUID: NIL3zarjVFwZfChYiU_1JDNWXS5khViz
X-Proofpoint-ORIG-GUID: NIL3zarjVFwZfChYiU_1JDNWXS5khViz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290008
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
UEFUQ0ggdjIgNC85XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgTWFyayBoYXNfcHJlZF9kZXN0
IGluDQo+IHRyYW5zIGZ1bmN0aW9ucw0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkNCj4gb2YgYW55IGxp
bmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBDaGVj
ayB0aGF0IHRoZSB2YWx1ZSBtYXRjaGVzIG9wY29kZV93cmVncw0KPiANCj4gU2lnbmVkLW9mZi1i
eTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gLS0tDQoNClJl
dmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCg0KPiAgdGFyZ2V0L2hl
eGFnb24vaW5zbi5oICAgICAgICAgICAgIHwgMSArDQo+ICB0YXJnZXQvaGV4YWdvbi9kZWNvZGUu
YyAgICAgICAgICAgfCAzICsrKw0KPiAgdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5
IHwgNSArKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbnNuLmggYi90YXJnZXQvaGV4YWdvbi9pbnNuLmgN
Cj4gaW5kZXggYTc3MDM3OTk1OC4uMjRkY2Y3ZmU5ZiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaW5zbi5oDQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2luc24uaA0KPiBAQCAtNDEsNiAr
NDEsNyBAQCBzdHJ1Y3QgSW5zdHJ1Y3Rpb24gew0KPiAgICAgIHVpbnQzMl90IG5ld192YWx1ZV9w
cm9kdWNlcl9zbG90OjQ7DQo+ICAgICAgaW50MzJfdCBuZXdfcmVhZF9pZHg7DQo+ICAgICAgaW50
MzJfdCBkZXN0X2lkeDsNCj4gKyAgICBib29sIGhhc19wcmVkX2Rlc3Q7DQo+IA0KPiAgICAgIGJv
b2wgcGFydDE7ICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKiBjbXAtanVtcHMgYXJlIHNwbGl0IGludG8gdHdvIGluc25zLg0KPiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYw0KPiBpbmRl
eCBhNGQ4NTAwZmVhLi44NGEzODk5NTU2IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9k
ZWNvZGUuYw0KPiArKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYw0KPiBAQCAtMzY2LDYgKzM2
Niw5IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9zaHVmZmxlX2Zvcl9leGVjdXRpb24oUGFja2V0DQo+
ICpwYWNrZXQpDQo+ICAgICAgICAgIGZvciAoZmxhZyA9IGZhbHNlLCBpID0gMDsgaSA8IGxhc3Rf
aW5zbiArIDE7IGkrKykgew0KPiAgICAgICAgICAgICAgaW50IG9wY29kZSA9IHBhY2tldC0+aW5z
bltpXS5vcGNvZGU7DQo+IA0KPiArICAgICAgICAgICAgZ19hc3NlcnQocGFja2V0LT5pbnNuW2ld
Lmhhc19wcmVkX2Rlc3QgPT0NCj4gKyAgICAgICAgICAgICAgICAgICAgIChzdHJzdHIob3Bjb2Rl
X3dyZWdzW29wY29kZV0sICJQZDQiKSB8fA0KPiArICAgICAgICAgICAgICAgICAgICAgIHN0cnN0
cihvcGNvZGVfd3JlZ3Nbb3Bjb2RlXSwgIlBlNCIpKSk7DQo+ICAgICAgICAgICAgICBpZiAoKHN0
cnN0cihvcGNvZGVfd3JlZ3Nbb3Bjb2RlXSwgIlBkNCIpIHx8DQo+ICAgICAgICAgICAgICAgICAg
IHN0cnN0cihvcGNvZGVfd3JlZ3Nbb3Bjb2RlXSwgIlBlNCIpKSAmJg0KPiAgICAgICAgICAgICAg
ICAgIEdFVF9BVFRSSUIob3Bjb2RlLCBBX1NUT1JFKSA9PSAwKSB7DQo+IGRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkNCj4gYi90YXJnZXQvaGV4YWdvbi9nZW5f
dHJhbnNfZnVuY3MucHkNCj4gaW5kZXggMTIwMTE3MmRkYS4uOWY4NmI0ZWRiZCAxMDA3NTUNCj4g
LS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5DQo+ICsrKyBiL3RhcmdldC9o
ZXhhZ29uL2dlbl90cmFuc19mdW5jcy5weQ0KPiBAQCAtNzAsNiArNzAsNyBAQCBkZWYgbWFya193
aGljaF9pbW1fZXh0ZW5kZWQoZiwgdGFnKToNCj4gICMjICAgICAgICAgaW5zbi0+cmVnbm9bMl0g
PSBhcmdzLT5SdDsNCj4gICMjICAgICAgICAgaW5zbi0+bmV3X3JlYWRfaWR4ID0gLTE7DQo+ICAj
IyAgICAgICAgIGluc24tPmRlc3RfaWR4ID0gMDsNCj4gKyMjICAgICAgICAgaW5zbi0+aGFzX3By
ZWRfZGVzdCA9IGZhbHNlOw0KPiAgIyMgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gICMjICAgICB9
DQo+ICAjIw0KPiBAQCAtODgsNiArODksNyBAQCBkZWYgZ2VuX3RyYW5zX2Z1bmNzKGYpOg0KPiAN
Cj4gICAgICAgICAgbmV3X3JlYWRfaWR4ID0gLTENCj4gICAgICAgICAgZGVzdF9pZHggPSAtMQ0K
PiArICAgICAgICBoYXNfcHJlZF9kZXN0ID0gImZhbHNlIg0KPiAgICAgICAgICBmb3IgcmVnbm8s
IChyZWdfdHlwZSwgcmVnX2lkLCAqXykgaW4gZW51bWVyYXRlKHJlZ3MpOg0KPiAgICAgICAgICAg
ICAgcmVnID0gaGV4X2NvbW1vbi5nZXRfcmVnaXN0ZXIodGFnLCByZWdfdHlwZSwgcmVnX2lkKQ0K
PiAgICAgICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXA0KPiBAQCAtOTgsNiArMTAwLDgg
QEAgZGVmIGdlbl90cmFuc19mdW5jcyhmKToNCj4gICAgICAgICAgICAgICMgZGVzdF9pZHggc2hv
dWxkIGJlIHRoZSBmaXJzdCBkZXN0aW5hdGlvbiwgc28gY2hlY2sgZm9yIC0xDQo+ICAgICAgICAg
ICAgICBpZiByZWcuaXNfd3JpdHRlbigpIGFuZCBkZXN0X2lkeCA9PSAtMToNCj4gICAgICAgICAg
ICAgICAgICBkZXN0X2lkeCA9IHJlZ25vDQo+ICsgICAgICAgICAgICBpZiByZWdfdHlwZSA9PSAi
UCIgYW5kIHJlZy5pc193cml0dGVuKCkgYW5kIG5vdCByZWcuaXNfcmVhZCgpOg0KPiArICAgICAg
ICAgICAgICAgIGhhc19wcmVkX2Rlc3QgPSAidHJ1ZSINCj4gDQo+ICAgICAgICAgIGlmIGxlbihp
bW1zKSAhPSAwOg0KPiAgICAgICAgICAgICAgbWFya193aGljaF9pbW1fZXh0ZW5kZWQoZiwgdGFn
KQ0KPiBAQCAtMTIxLDYgKzEyNSw3IEBAIGRlZiBnZW5fdHJhbnNfZnVuY3MoZik6DQo+ICAgICAg
ICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwNCj4gICAgICAgICAgICAgIGluc24tPm5ld19yZWFk
X2lkeCA9IHtuZXdfcmVhZF9pZHh9Ow0KPiAgICAgICAgICAgICAgaW5zbi0+ZGVzdF9pZHggPSB7
ZGVzdF9pZHh9Ow0KPiArICAgICAgICAgICAgaW5zbi0+aGFzX3ByZWRfZGVzdCA9IHtoYXNfcHJl
ZF9kZXN0fTsNCj4gICAgICAgICAgIiIiKSkNCj4gICAgICAgICAgZi53cml0ZSh0ZXh0d3JhcC5k
ZWRlbnQoZiIiIlwNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gLS0NCj4gMi4z
NC4xDQoNCg==

