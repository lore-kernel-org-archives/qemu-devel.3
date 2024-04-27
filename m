Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D715C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 03:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Z5T-0000lb-51; Fri, 26 Apr 2024 23:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s0Z5R-0000lB-6N
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 23:50:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s0Z5P-0001IM-6W
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 23:50:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43R3R2D8024504;
 Sat, 27 Apr 2024 03:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=t1f5L2Rjvu9HT9NsNEYTsvbqligjBdRLfDyuzsCkeCQ=; b=mz
 udXGVeajTnrN1n39H7zB3EiVHO0VyF+cObQl+O80tF43eqLc9VOp9Ghl+I+Rwpjp
 fsOMtyEAHDhvuMj8MNIHhHzi2qhekv3ZF+9JMrlwATp5eqTPHfKjbI3jVgSVaXyd
 O1Y7CcE5HZx4Xge2oMJmb+9uc6HZzHtNZNmYGX6hCmqE4u848wAj+VBKR0EcwJNo
 A4k9VU20CFLitd6cD1BQUFtAQ5C/jItYklfUzKqZvzwbQeOBS2bzH0AVm3Ap0Bko
 mdc7V2/DJCmLIgWc8wOAeI47Y6yjweBPyHdfqA2zqDO4QMFLA+CA5Lr6ZohlHy7Z
 cMo5n4MasbyyVixilG2w==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrseyr0s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Apr 2024 03:50:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQAV/YMu1f7iXCeGi7a+/yWj25xMojUwo/g0s0ok1/JyhuXktdFi0LTvPCH9OuvCEBuvYQnOJjMh8MlP9P+SnzUwrNWqYIr+yZEtkkEXNYHgU9vNTm8rqlPT4HEmBAJ67W4OGewpGhg78tSSAL3n1DzEBvaxRHbQnx2kuNMiesACK9BlqXp/aobeiRgUTDl+26TrUyv/Ulz33SspBDSCFUvHrIRsYMDFXIN+mBlD34M549NqIvwD2hR2sdG2c6jgTaphWPpdYVMpbFmo6q57QwwWh75oEDVETVow47U8ImLtbpbb/+Of1CHEX+xZnq/4T8QKwmO0ZOpVc1R8MSMEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1f5L2Rjvu9HT9NsNEYTsvbqligjBdRLfDyuzsCkeCQ=;
 b=Xr8cpyOI+aCeqymyt+06gjkULJdqIZoe3/ysbQklEoHQxW/nggLeQVablY2XwQeft3XbgS7k60cqYdxg66BKB7WOPVIypqEAYCkAgvjuWh95HofnQcwzRWF5eL2nc1wSJEPSGARXjagXqop7VoRk2rS655mCBSHnwl9FhUvRIIgAQvu3DxoKcL0bJVnqX6czBqlvbOfR99r+jseykSBFiI04+IWOcWfQKB6uZ4RZc7yoVStcxSvpNGNjRUJ3hwZ3vnQU9gQgCA/qSc3Xg5f3pvVNf+cHyYFb35bVBAsmYx7UDdAB+U8Tm7ISiDCBkAgx+aS46rqCgcC6EpRbE551xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by PH0PR02MB7638.namprd02.prod.outlook.com
 (2603:10b6:510:4f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Sat, 27 Apr
 2024 03:50:42 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.042; Sat, 27 Apr 2024
 03:50:41 +0000
From: Brian Cain <bcain@quicinc.com>
To: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Sid Manning <sidneym@quicinc.com>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>, "ltaylorsimpson@gmail.com"
 <ltaylorsimpson@gmail.com>
Subject: RE: [PATCH] Hexagon: add PC alignment check and exception
Thread-Topic: [PATCH] Hexagon: add PC alignment check and exception
Thread-Index: AQHamAXI2DfPaB81NEaUP3xGYaYSDbF7e+iA
Date: Sat, 27 Apr 2024 03:50:41 +0000
Message-ID: <CH3PR02MB1024736477D0FF232AD689F9FB8152@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
In-Reply-To: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|PH0PR02MB7638:EE_
x-ms-office365-filtering-correlation-id: 83a181ba-6c04-4183-1368-08dc666d358d
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hN6kXGjpl1TF7d35yX3bjoRyIZEtex0uC6mcoDZs+JRilHpFoYag0OW7XGsS?=
 =?us-ascii?Q?kIcddf+lh3VHYRz9PNmCdlsvE9xnA83LqgTTa9ohOm0He/cT5gvuiTzOPRNB?=
 =?us-ascii?Q?vKGzNh0qWIxbio7wZc8Iw6GO7DCmBjvQCFbiXhvZs3qaPWQCtTVapIpyHajo?=
 =?us-ascii?Q?AxluWnXnrLtySVt+jpksFKEdf9M20Jv6WKn+GXkU+kbyIWYL2KK9mZV6Ucs/?=
 =?us-ascii?Q?SJ5Xgs+AUZvOX6JjlacwEQUFSqnu8kcGEDzMVKR13VIb5EXSVcxHL9cTnF30?=
 =?us-ascii?Q?P/KTrDEbbRweDjxMeL5uRmp+BDQEtP938Eg/rufbbcFWfkLy6S3mTLZJH7Qr?=
 =?us-ascii?Q?cKa1xIpwXF9ZLzFeu0WeoNg7GoBNpS+W/KYZHwRAThHAiiaQaU7KC+H5LhO4?=
 =?us-ascii?Q?wCEKXJdQ9KvLaUSt30FFt/cARlE5vlHoFlZ7b5cIuwTIFwmvlAT4POGCcVXc?=
 =?us-ascii?Q?NiqQeVSNj0C/udXVhOUwMaEh15c4kbO/+4URfbFynQRFR/uJNmNNPURS9UPV?=
 =?us-ascii?Q?iOBWKtlyqsxh3YvYXfEuduptK2t3q51bTtYo3l8kh+Wu8Ai+AFlDah+83o+Y?=
 =?us-ascii?Q?k4Cq0FlTekOU3TjsJ1tmecOG+woq4Z0MymsW0RS4kbzZBX6h/mnqVSipGo2+?=
 =?us-ascii?Q?0QX/52o9JwTV7cc3i7KBVivfZmOh2/+4sSjtXXLONAAED7QDpApzSDC1XyC6?=
 =?us-ascii?Q?6csgcyBoHlnT2tr7azSyfeULNnc4UnmlJVZUpcSO7T/h90xbXGR7E0ltW5Ru?=
 =?us-ascii?Q?jZzMGcJLok9zXWWXpT0WI2pjiWRZ2eedKP5T/QZi9SQLxGPHkamdkiODwPSX?=
 =?us-ascii?Q?583b9gn7vJsee2/vWzg3gzBIUXTtdj6AvqbqqKbxX+64ec4W1+8BoFTL0dfL?=
 =?us-ascii?Q?KCax0ORt4wbYINaUoJDhHc4EPaZQw6VQydB3bKs+ZgaipcpWt1RBWvcVOw0c?=
 =?us-ascii?Q?z/EvHZzR11geCUT9dhdKQWpYHBU4sCujmO+xkfI3ULR3bmWScgEomkcbq0JQ?=
 =?us-ascii?Q?ClnhwlWQRs82Yg/1IoW/MFJaYIZ0ur+/rAInIKw8a7GfI+AJSlhjnf/Y9d2a?=
 =?us-ascii?Q?c1I27TbW4Cno9vi5N/iLNIpnIo1+qt67ty1NyGE4tlCiLawsR35+whESW4vJ?=
 =?us-ascii?Q?Y+1gRejdfhRVnxmFzu+OMHU9FYBFEoDYztyW/07G1y1wwEu/7efs5I67vW+9?=
 =?us-ascii?Q?nhRKG46M9nrFabwDYLH+cQZ7szS11jnfQ2tM/xfuH2s+2nMhCLDpkBLeS4vV?=
 =?us-ascii?Q?+3nRjEcZ7pDDBpyWEVdS1XL+TZ0nl66Fua22G0jDb7oAgxdnMXwecBUXpeL9?=
 =?us-ascii?Q?GNJyEXXGMZaK/Zhhz9NpfeYjaUXyQCnfYMu+8UeuTdGoTg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JrdE76w4EMc80zEayiFaoI9EYsHamZfXceV3zZ+hoTlb62CPDlOMbjNvpqDT?=
 =?us-ascii?Q?lL0dq6pGuI+wHjgClo3uWo7hGGuU46xRDpFPVCWRQeV2n9+sKANXkAGSgBGn?=
 =?us-ascii?Q?SXMNyiGGu3+Da057TCDEh+JeRdXU7khJTok2RIJPMhd1bFEZPt3utcuWCoCa?=
 =?us-ascii?Q?ntV6102hAWUbiMlDw1z5g0O1Avv/mc5dZhJAIi/Dkr9qyo7YvP8wJ/FFhyFl?=
 =?us-ascii?Q?HujsRJ5jjwCl3yixLv+s4dYgYP69fMRWoIXpKOAg1MnDqIxWt9rTA9f4mf4+?=
 =?us-ascii?Q?p1Ot6+3o5yggrgEQBbGMrgJ+pPAFBltdZ8XNQNXe0GDUDBF92AB2r50SxPAp?=
 =?us-ascii?Q?nRmMqQePssiTm4ZNtqOwiLdJZ76mdPVocV6smcZK3CtPg70N/VYBGP+Xbt+d?=
 =?us-ascii?Q?k190oiYOZ+C5pKaiiMeYPaataYGpZu+8Fkqw2o/1hLoPSPjXEG0dIfXpULUD?=
 =?us-ascii?Q?toqRK51B65dmVKzV8INTFFYI9neHQtiRPxYY/qLo8N1vxWOAGeOqchI6mBLx?=
 =?us-ascii?Q?j4CBqd7+bha1u7In9nEiyZ4AzHlsrSHjMw7M/4cLJZK/Vtt+PSU4rEKgfpyJ?=
 =?us-ascii?Q?WWj/SV5/jalEYNDqqMFPHS0py/f/dQ3SpnNp9knDo1UTM4p6pZDuJQmZP9Zf?=
 =?us-ascii?Q?PKeau3/acFO3ycqbND9Y8yfFSh5WewQGY0/9Tmey/k9Frphn6kePlwYTqslb?=
 =?us-ascii?Q?P1S5l3gGT8D5hbBYsr3mvobprd/Lr0LFw0LnrSLD7aT0zRsMhzeJF/ZgnDKz?=
 =?us-ascii?Q?3alGEtMkM/FYjWi353L8aYiTFrI7lJzgvXmc6Nob15KUp+VWu3aqiA6wd55H?=
 =?us-ascii?Q?IlnRZKGZFCnj/J9KwY94BzXqPBlJf8jo1NTLt5BxIwhiFHm8EU9v+Gf8rMDy?=
 =?us-ascii?Q?e1QESSqBG0X65dctScgc71mHALmVn3ssRsRVcgZ8DjlIitz024HGFOmXLyZj?=
 =?us-ascii?Q?ZSvGMOFF9KOi6PFzjkdNq7xQSUd+nLvrm4MS4CUux8AuOSVF9CvInOVmR8ch?=
 =?us-ascii?Q?nBJoMPLYYxOLm62AJ03vC+Ua4x0mhvJ4G1TPAstCUiVppxf6oXoLWSDAr47c?=
 =?us-ascii?Q?7uHXnHe99MxQV2Tqh4gN+KFIk2RPRGxTeCUmAPAmpgIj24L5Trhm4I5Gj45T?=
 =?us-ascii?Q?2tH8DLOCqyHCdOxjL1OkJwuIQxLiqU9vgWwdF8lXzjA4vSS9HBhpAcZEjRLf?=
 =?us-ascii?Q?NISgom0dQn7GT3t1qSrtVqXx47ACn+kcImNDMceoXJdsz8ELE/2Rgu7AD+lG?=
 =?us-ascii?Q?pYa7QDKB0ZL6ij3lOrcqaweM7XOsF6dayvrckMpWSEhULcbzciKoVf8q0lYa?=
 =?us-ascii?Q?a2ytzQ2Zw7ROVnEm+4CEhsc/bzdFN+CTMQj8FGBtIQeee8UZmMLDqtcP4F4C?=
 =?us-ascii?Q?VZBR76vox37wqO38a8NiAxBcGG+CwTjJ1HC+IvvobLbQXAvRjXaTkpIHVFRK?=
 =?us-ascii?Q?PXD21rBK+XnIFCQ4zwH2ChyTiENXOrJ2njsopZU9SlqYCGOtuU/PHRDho+Lj?=
 =?us-ascii?Q?IBW4Dc8m3jUoG2D6SvstWpQL+0rkYhRs+YFUO6EFR/6k8iz8GV9wJ70hVSXO?=
 =?us-ascii?Q?jA1Kpkkb7MtwdfgViXA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y8tD4emc5iFUf0Aa466tv1i5Us+3mq5HyFk5pb8vMpG+C9gTM0s8Z9X9InIQSiAB5QERmlkJqfP8UomAzmkqg+dzNJP7Iw5csncCIi3Wb4j+KxzyOtiJaBqLrXQf8J/TTcvrlkjQg/ZTt/7tcT4nAM1Ng14apdH+1YXHjH9GC1p/C1jz/GhYWTCgtgQQdRZeqz22CQBqT+tAucf6+9lcWvwKUopWhof5Nejc3YYqu+XTOF3z3XRLgHDUCpputfI3cMdlVkP9iypteBnCBXe1F0tIMCUsZ4sOYL1UiQTg8PMrSAH3sSf5Fx5CoRyyvIY79wHoXJfvvb+FBvFXoKS4WQA7leWtys8e9aTWn17a5wpC3DLl3y+sKaUUApx38LqvQh9obPRb9j79DgQ0Gsj47d+Hb92YCn9aEZxH+l7D7tDoihxwuRdDQj5T59ORfRddqEsRJC8SPs0N3akj+WesmfSgRAMU03Dj5JzsbhGXIke9ISelVdDglgHUL7AZz/74PluE9PFEVpNHER6Oyo/NXmJ+CXsH7WK7DGlkxyNYujryfuHfZYhX+4JIg1iDh1c7M3E9RXRTLToNnv8Ql+/BFewYot39uRKARrRiZglp2DD2CgdPnMWGBhWyVnQQQ1xx
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a181ba-6c04-4183-1368-08dc666d358d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2024 03:50:41.5622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vuqH+t9oYa8XTd67Gld+HeSaG3ZGjyWekLMYc13qhAgMA6umPRr6wK20AJp5sIWlz0oPjmCdTv8DVQiGFsMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7638
X-Proofpoint-GUID: _w40_m46pvKOjAaoQCTVSCrxBkA3YbIy
X-Proofpoint-ORIG-GUID: _w40_m46pvKOjAaoQCTVSCrxBkA3YbIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_01,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404270026
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



> -----Original Message-----
> From: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>
> Sent: Friday, April 26, 2024 1:16 PM
> To: qemu-devel@nongnu.org
> Cc: Brian Cain <bcain@quicinc.com>; Sid Manning <sidneym@quicinc.com>;
> ale@rev.ng; anjo@rev.ng; ltaylorsimpson@gmail.com
> Subject: [PATCH] Hexagon: add PC alignment check and exception
>=20
> The Hexagon Programmer's Reference Manual says that the exception 0x1e
> should be raised upon an unaligned program counter. Let's implement that
> and also add tests for both the most common case as well as packets with
> multiple change-of-flow instructions.
>=20
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Reviewed-by: Brian Cain <bcain@quicinc.com>

> ---
>  target/hexagon/cpu_bits.h                  |  1 +
>  target/hexagon/translate.h                 |  2 ++
>  target/hexagon/genptr.c                    | 21 ++++++++++++++++-----
>  target/hexagon/translate.c                 |  2 +-
>  tests/tcg/hexagon/Makefile.target          | 13 +++++++++++++
>  tests/tcg/hexagon/unaligned_pc.S           | 10 ++++++++++
>  tests/tcg/hexagon/unaligned_pc_multi_cof.S | 13 +++++++++++++
>  7 files changed, 56 insertions(+), 6 deletions(-)
>  create mode 100644 tests/tcg/hexagon/unaligned_pc.S
>  create mode 100644 tests/tcg/hexagon/unaligned_pc_multi_cof.S
>=20
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index 96fef71729..d6900c8bda 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -23,6 +23,7 @@
>  #define HEX_EXCP_FETCH_NO_UPAGE  0x012
>  #define HEX_EXCP_INVALID_PACKET  0x015
>  #define HEX_EXCP_INVALID_OPCODE  0x015
> +#define HEX_EXCP_PC_NOT_ALIGNED  0x01e
>  #define HEX_EXCP_PRIV_NO_UREAD   0x024
>  #define HEX_EXCP_PRIV_NO_UWRITE  0x025
>=20
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 4dd59c6726..daf11eb584 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -75,6 +75,8 @@ typedef struct DisasContext {
>      TCGv dczero_addr;
>  } DisasContext;
>=20
> +void gen_exception_end_tb(DisasContext *ctx, int excp);
> +
>  static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
>  {
>      if (!test_bit(pnum, ctx->pregs_written)) {
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index dbae6c570a..c96edd9379 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -473,6 +473,7 @@ static void gen_write_new_pc_addr(DisasContext
> *ctx, TCGv addr,
>                                    TCGCond cond, TCGv pred)
>  {
>      TCGLabel *pred_false =3D NULL;
> +    TCGLabel *branch_taken =3D NULL;
>      if (cond !=3D TCG_COND_ALWAYS) {
>          pred_false =3D gen_new_label();
>          tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
> @@ -480,12 +481,22 @@ static void gen_write_new_pc_addr(DisasContext
> *ctx, TCGv addr,
>=20
>      if (ctx->pkt->pkt_has_multi_cof) {
>          /* If there are multiple branches in a packet, ignore the second=
 one */
> -        tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
> -                           ctx->branch_taken, tcg_constant_tl(0),
> -                           hex_gpr[HEX_REG_PC], addr);
> +        branch_taken =3D gen_new_label();
> +        tcg_gen_brcondi_tl(TCG_COND_NE, ctx->branch_taken, 0,
> branch_taken);
>          tcg_gen_movi_tl(ctx->branch_taken, 1);
> -    } else {
> -        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
> +    }
> +
> +    TCGLabel *pc_aligned =3D gen_new_label();
> +    TCGv pc_remainder =3D tcg_temp_new();
> +    tcg_gen_andi_tl(pc_remainder, addr, PCALIGN_MASK);
> +    tcg_gen_brcondi_tl(TCG_COND_EQ, pc_remainder, 0, pc_aligned);
> +    gen_exception_end_tb(ctx, HEX_EXCP_PC_NOT_ALIGNED);
> +    gen_set_label(pc_aligned);
> +
> +    tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
> +
> +    if (ctx->pkt->pkt_has_multi_cof) {
> +        gen_set_label(branch_taken);
>      }
>=20
>      if (cond !=3D TCG_COND_ALWAYS) {
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index f163eefe97..e6ee63a53e 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -185,7 +185,7 @@ static void gen_end_tb(DisasContext *ctx)
>      ctx->base.is_jmp =3D DISAS_NORETURN;
>  }
>=20
> -static void gen_exception_end_tb(DisasContext *ctx, int excp)
> +void gen_exception_end_tb(DisasContext *ctx, int excp)
>  {
>      gen_exec_counters(ctx);
>      tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC);
> diff --git a/tests/tcg/hexagon/Makefile.target
> b/tests/tcg/hexagon/Makefile.target
> index f839b2c0d5..02d7fff34c 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -51,6 +51,19 @@ HEX_TESTS +=3D scatter_gather
>  HEX_TESTS +=3D hvx_misc
>  HEX_TESTS +=3D hvx_histogram
>  HEX_TESTS +=3D invalid-slots
> +HEX_TESTS +=3D unaligned_pc
> +HEX_TESTS +=3D unaligned_pc_multi_cof
> +
> +run-unaligned_pc: unaligned_pc
> +run-unaligned_pc_multi_cof: unaligned_pc_multi_cof
> +run-unaligned_pc run-unaligned_pc_multi_cof:
> +	$(call run-test, $<, $(QEMU) $< 2> $<.stderr,"$< on
> $(TARGET_NAME)"); \
> +	if [ $$? -ne 1 ] ; then \
> +		return 1; \
> +	fi
> +	$(call quiet-command, \
> +		grep -q "exception 0x1e" $<.stderr, \
> +		"GREP", "exception 0x1e");
>=20
>  run-and-check-exception =3D $(call run-test,$2,$3 2>$2.stderr; \
>  	test $$? -eq 1 && grep -q "exception $(strip $1)" $2.stderr)
> diff --git a/tests/tcg/hexagon/unaligned_pc.S
> b/tests/tcg/hexagon/unaligned_pc.S
> new file mode 100644
> index 0000000000..39d6b2060b
> --- /dev/null
> +++ b/tests/tcg/hexagon/unaligned_pc.S
> @@ -0,0 +1,10 @@
> +test:
> +	allocframe(#0x8)
> +	r0 =3D #0xffffffff
> +	framekey =3D r0
> +	dealloc_return
> +
> +.global _start
> +_start:
> +	call test
> +	jump pass
> diff --git a/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> new file mode 100644
> index 0000000000..a83e248ece
> --- /dev/null
> +++ b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> @@ -0,0 +1,13 @@
> +.org 0x3
> +test:
> +	nop
> +	jumpr r31
> +
> +.global _start
> +_start:
> +	p0 =3D cmp.eq(r0, r0)
> +	{
> +		if (p0) jump test
> +		jump pass
> +	}
> +	jump pass
> --
> 2.37.2


