Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212B5C48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb1ux-0005qu-Bz; Fri, 16 Feb 2024 12:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rb1uv-0005qJ-FR
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:22:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rb1us-0004bw-8L
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:22:28 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41GDJAqG022054; Fri, 16 Feb 2024 17:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=evrNTbSAVzETreO/+qsvPoqFAmBNFR33DoIsurqVsS4=; b=OA
 reLZEQugaTSV4/aYQ6hzVDyO+OXICWOGgzt+x42CjH5eM0bZ+WxoizzTv2WJIZ4g
 2x6jVeDMaEFk4M9v6K+uWGinzccivMpM97Cs6MICHnLsKxNUMsiXdAX2FwRHZnYa
 vi/3mzVLYm9nk1CVgAd3GdGF2SLSrE09SjSJR5Clg3Joth7Z3dHXvjQUvoCWIQKK
 FG9ySN5OngJj8u6+XwgzIIutLl/qDt3J7SwjboNJQOED+57nRyKSUAgg6SGA+eLJ
 Ih5IWvwjmkWo5HlqzAzF3WY1Xt2ypbM4Hjs8lAkjpzOJ8W9EeYgN3Ufj9eJW77wQ
 k5rDVh4wNwUhCKlqN40w==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wa6nk8qv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 17:22:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt1fs53KEP2qID+xiZhfwE9jX93q3QU+95YALizwVPhHDg3rwIoj5IDbqeMKmXvJ3trQUZjQ63E1ugZIEOlo9u+fu3/9Demz0ROrb7aIFOyIqmLffgfo/kOzBF/SplmXAwAVefrwdnY6dt9I4bj0eiGPiCdx17K4AKS3VuvarWpSgp76KBNg8ApPOuyxHYWAemJxLXrEhZaFNQJIEkQvno1UsgHY5kfn+7Eijprq2YGg07r8LFjeHnZedamY+vgUkc8zaflz80Ghr7mq4HYBvZ9KNusXRodC4bJULGuvBG/QP0JNQl1BAfIe4gFBZwDVrAknc90W9KhkF69XJ3z1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evrNTbSAVzETreO/+qsvPoqFAmBNFR33DoIsurqVsS4=;
 b=BjJkM2NOWZfk7XUHMMsHMuojufj68h4UlcMq6aezBRZ/kfoBM5NieFIHgE50XDoWsxs3ysC6Unbzu7MwFqp1JVXzM4WVe5SGr4reYsqNxT1pYIiMsZhjSE8+BeAYTCvBtd2GOYtfEP6G49RDlEp2uB776FFtMG2vDx52cwdGLZkfIP4Cl6LY54eBpNJINrUeWKlDLESsz+uw1baocWwKtYARG01E+JEOIfYRXI+WZCRICcU/+jUkQOc+20x1hHLqzNzx+izGYMGHCy3YTY5ZVrlDufGOeyTUpuI4SxYILtAb37XBwXWJdGG2dQb68DaAYF7zFHwwXHUb0rLs4AXs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by DM8PR02MB7864.namprd02.prod.outlook.com
 (2603:10b6:8:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 17:22:21 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 17:22:21 +0000
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
Thread-Index: AQHaXv4k3jynT3IfxUS/ROY3oSpB1rENO19g
Date: Fri, 16 Feb 2024 17:22:21 +0000
Message-ID: <CH3PR02MB10247A6A02A51FC3FC2E3129CB84C2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
 <20240214042726.19290-3-ltaylorsimpson@gmail.com>
In-Reply-To: <20240214042726.19290-3-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|DM8PR02MB7864:EE_
x-ms-office365-filtering-correlation-id: 5c187b27-73e3-4b72-5b28-08dc2f13d57b
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHQhMBmdQTn7MWyFSYIgVksCkIdKjpMoz01ZfW2aUuCxVd97x0ZzTqZAqjEJ+aF1Eq46FJplFkWWMDJLMs3ktiWFmeeJKI8GhPvAHQdqnzws37dfjDOhSoa8b5bXRJ7NaqWOiqHxU7seBR4ij2IF8PGTmZeGwH+nNOmfUwlTqBaSqBeh5kjB4NYnm51ePs9cUJc2/I3lGWYeQHNPD7NzpfB5BFxoGYLWdYQsqcfzcLRPu4EyD0FgJEeztRbqOvRfgx7XMO7JleWnQrqpZxLOZGT40JSvnUtD1PfqcV3XqTgpj1r4yFNGpRxOarkgFKW4kIEDx2yDTL4NmbYp10/y7/ChNne/ACY5TQWivdLnOoQMhq7RjTvUWdGCuhSqK0sdbeXW/maOKjDJa8Wntukkoo03y2ZkAmujpnxBmaaWaeoWiBsWUQm01eNpQrU4mjb5/1iDlE9OnhOeywgYxfJnFXalnMU54N0oK36yS+Di+JL0xXvzoDSymXui0H1DeBY2hecXz1U+hA5FVilpWPt3GfHaBlKSb/Gl2B5Ggd4XzG7QzX0K4PEqY4BrEwVwi9gYQ08mEwBF3ZnmVjTqp1CKB/036uTXVou46zVHnhF0KI0BZKlr/iQhyE7ngWt68rxX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(33656002)(86362001)(55016003)(8676002)(76116006)(66946007)(8936002)(5660300002)(66556008)(52536014)(64756008)(66476007)(4326008)(2906002)(122000001)(83380400001)(66446008)(38100700002)(66899024)(38070700009)(110136005)(478600001)(7696005)(9686003)(6506007)(53546011)(54906003)(316002)(71200400001)(26005)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDVrQ3BlUEQ3NmxWQ1EzTS9YRzhpNUxxL0ZIWnNPV1Q4TDNtYkNkWEg0WUZR?=
 =?utf-8?B?alF3cCtPbTgrVGdYelZEZ1hFSlRxZHRBSmNOdngvdFlVTXFYbzVzZ2JDZEtW?=
 =?utf-8?B?RlJ3aVBXclovMDZSUkNKMVJYM1BWbGZDUkRKaXU5WjdVQi9uaUZzUGhrMmxO?=
 =?utf-8?B?KzVqczlzSUxlbW9aMEZOS0lkVmRrZTlpV29iSmc0Uk85NFlyY1UycGpoOGJl?=
 =?utf-8?B?U0kwdkhydk9FRCtGbEpkMW1qczdJYkIybWJVUU51MU5SYmNXRnpiSktRWGp3?=
 =?utf-8?B?TVB3SkVVQnV0ZkE0SjV0dGxGV1BCdG1BSkVXaTBKQXVERWgwczlrWmpxV1dn?=
 =?utf-8?B?Qm54djBZMHNsV2c3Y1lYYVB4SWJKdGRHTWVoQ1UzYWhBWWhqYXZvTUY1cjJ6?=
 =?utf-8?B?cU1CUWhIa21vV0x6Rkd4UjFKaU9hK2RpSGQ1QzZrYUxOdm9TR1ZLd2ZnK3ZJ?=
 =?utf-8?B?cE81cWVydE5iY3hJUUdOZ1lKMkFXQmZwQzZpeVFUaE04LytVSVR4RmV4Z1Zp?=
 =?utf-8?B?Q3ZBdHpyV3JJV3NNaHlhbC9lZTF2UGJ3OFVPVkIwR3VPVWJwOVhiaGdBOURS?=
 =?utf-8?B?c0ZJT3pnRnBCSDNiZ0hobHRSb01MZ2xZWFNrOGxkNGMxKzRqNEpjQUY0T1pG?=
 =?utf-8?B?YU43d29CcnFuSURWOVl5bDZHMURjcjliWlA2VjFPUUwvVTRTTDloTmZJbG9C?=
 =?utf-8?B?Rng2ai91OVZXaDNodUNzN2FDcDV3OURta2MzK1hZSmJuYkt0VTdzMkR3SnN1?=
 =?utf-8?B?b1JiY1hHanNLeml4Vjl0eUdVNnV4Ni9KQ0wwclMzU2NMZnlrSnhTRjNkZ1FV?=
 =?utf-8?B?d1p3UEoxa0Q5SE03R25ZeWJZb0pIOFdMSFJjd0NvbU9HY1VnSlgxd01iNlJ4?=
 =?utf-8?B?cnVnQk1xVkNuZnJnbWhsSWpaUWVpQThsMGNoeWFOdkNINTRFMjlGRDhlZ2dt?=
 =?utf-8?B?THlqZ2ltWnVBNHhjenRnN09vNEFrNWI1Yy9mU0VtNkxUR2NSL0ZlRzNDYytz?=
 =?utf-8?B?RjZvRFhQU2VRN0ZEOHdvelBFQjFqS1FCRUZnMzlCKzZsMWp2SUZkWVZ2Sm1J?=
 =?utf-8?B?U1ZIbk1Nd0JUd0pBQktZSGU5NkF2NmxTRHVtbzBQdnl3dnhOUFdCNG5DVEVT?=
 =?utf-8?B?dnpZdnFyQjcvVEJFV0JhVEF2WDhsZ1I0S3lJWXJoaGQzQ1JZRzZrdXlzNlBC?=
 =?utf-8?B?Z2NrS3NGdTE3bkRkL1hTTDBZUnRiUEJxSXE1a0w5NmE1R3ErcnV3R2FTUldR?=
 =?utf-8?B?QmsxWDc4YmdoMHNLajFRVndEMzA5bEgwTXRnWTRWNDY0azJvenQ2TEVmcUVs?=
 =?utf-8?B?RlZheks3WklMcnZmNWtRUnc2dFBSRDNHVmY5RnJGa041Wm1rMW5FeUd6cXhP?=
 =?utf-8?B?TmhwbTc0MzN3ZzFvdDQzL1dxT2lCdHN2Zi9kaWFkK0JHdkJtYndaRThxcDEv?=
 =?utf-8?B?cUJSanI1SEhNQkpqME5nVDN3MDhmR3VCbWhxa2dydlhNNXdqNDBSdnVmdjV1?=
 =?utf-8?B?cHNQNVViUGRacXZFdGt2NkJSb3J5WEhZTWhtQ0tDb1ZSVDNlOWRnaUh1K1R1?=
 =?utf-8?B?enAxelo5b0h4UGxWVzUxVnRPWjdjWTZPeG8xTnV6NXJiZUNjK1VHQS9XWTE0?=
 =?utf-8?B?L3BtZVFFaE1XNVdaSXJSNjExWVgwSnZwVkNqMzUwQXQ5Z3BNWFJwUHBKdzRK?=
 =?utf-8?B?U2RzRHpTNWZSVVBqanFNR2FhK045bExVMmpLT3crbFZTcEU1bVp2WkVYQllE?=
 =?utf-8?B?WkQ5a2UzOEJXQ2VhSG45dmNHMG9QS1hNRUZTcEREcW1iTUd5Mk9Ra0c1VUFa?=
 =?utf-8?B?TFZkcnczSnJtU2x5MmdCREZielhlN0NxeEUvK1NOcWthTThUV0VUMTFleEd0?=
 =?utf-8?B?Skd3S1h1RCtZc3FzV2NqLy83QnlvcE5uUENBUVBlVHpRNGxpb3BJOGhzVDBH?=
 =?utf-8?B?WHNrZW5HNk93Z2YxdW5sZXkrSWdwa25NSlB3Vlo0U2hXTlJMZE10YVV5L0Vm?=
 =?utf-8?B?TWNXbnRESTdjRWN2SGZRMTNGMjIxV3JtajBIMlZUcEtUME95MGkrOFB4UmlU?=
 =?utf-8?B?WjdOalk1dHdWdXdBdG5LRjVyTDdSRVBqQ2J2OTdha2ZUUjdEME5qWHdqTHAz?=
 =?utf-8?Q?ObT0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IBWxtAOQJCmkvKLAEdCmRrbZR9y0P2kGXghBfQfku6EDRouq8eGRFIO6ORjuCYnnzfQclwZym14EXXO6xoTyCoKey3skKB/OFhsN+jdqF5qr0K8vrhQqq6N4ljU/1imK8gDOycFDupKFLwayYY/FTllzOM4BXGunUkl1BfvsqxbIxf/pWNWYAe8OeMpgq7yljYL4fa8+q+suVTcJbYfE6EXFef6NFhUNmC/KnWdTZTDRGGR7oQJ1a9swJ2o5HFR8BT9PRmI5Ws0jy7U288M7fMWB7hIK/oi/3kEmDZmYopt17qxCI6BIBfwm8vINm5WWADPLCbWVQ9tL9dgeJZysj7pyYFIC6RUGKLrf3DkrURSs+s7HQYiI8u4SDi5zE6Yp8YYeyA4wWjaKWRykNsjFc+h1mb/HysgLCi5z+OBWPsa/4GEgq+0p/dPy9V3j2d6bCvEgQXVraDr71G4X3DD/aGDUM9I3jMO+aRYnJM1rqBXnFGxqGXOuouOXexXOqK7UMATD1khk3fW5Q/+JgcjSVrMGPRU1HbZsUodnNY+CfD2ueUuLGMSQxIzb7yL6R15ecDahb5iuhrDMCeeIQXyLTaYH/Y3Q33oWh2UeQrbSCnEja29yCWBSqW8n+UKMV7af
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c187b27-73e3-4b72-5b28-08dc2f13d57b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 17:22:21.1864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NnjslozuRWyHq/XcRw/ZMdRdFZEaFa+jy6RFj5lFkJF4/KTBMC2axMd/a92o9eHkizotDAAdITNYkFBkrDE1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7864
X-Proofpoint-GUID: 3baGfttIy4PeXe3zGbmYYFUvDjwf_7Wi
X-Proofpoint-ORIG-GUID: 3baGfttIy4PeXe3zGbmYYFUvDjwf_7Wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=546 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402160137
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
ZXN0ZWQtYnk6IEFudG9uIEpvaGFuc3NvbiA8YW5qb0ByZXYubmc+DQo+IC0tLQ0KDQpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQoNCj4gIHRhcmdldC9oZXhhZ29u
L21hY3Jvcy5oICAgICAgICAgIHwgIDIgKy0NCj4gIHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVm
LmguaW5jIHwgIDMgKystDQo+ICB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICB8IDEx
ICsrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmggYi90
YXJnZXQvaGV4YWdvbi9tYWNyb3MuaA0KPiBpbmRleCBhZWRjODYzZmFiLi5mZWI3OThjNmMwIDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaA0KPiArKysgYi90YXJnZXQvaGV4
YWdvbi9tYWNyb3MuaA0KPiBAQCAtMzQzLDcgKzM0Myw3IEBAIHN0YXRpYyBpbmxpbmUgVENHdiBn
ZW5fcmVhZF9pcmVnKFRDR3YgcmVzdWx0LCBUQ0d2IHZhbCwNCj4gaW50IHNoaWZ0KQ0KPiANCj4g
ICNkZWZpbmUgZlJFQURfTFIoKSAoZW52LT5ncHJbSEVYX1JFR19MUl0pDQo+IA0KPiAtI2RlZmlu
ZSBmUkVBRF9TUCgpIChlbnYtPmdwcltIRVhfUkVHX1NQXSkNCj4gKyNkZWZpbmUgZlJFQURfU1Ao
KSAoU1ApDQo+ICAjZGVmaW5lIGZSRUFEX0xDMCAoZW52LT5ncHJbSEVYX1JFR19MQzBdKQ0KPiAg
I2RlZmluZSBmUkVBRF9MQzEgKGVudi0+Z3ByW0hFWF9SRUdfTEMxXSkNCj4gICNkZWZpbmUgZlJF
QURfU0EwIChlbnYtPmdwcltIRVhfUkVHX1NBMF0pDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9hdHRyaWJzX2RlZi5oLmluYyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5j
DQo+IGluZGV4IDg3OTQyZDQ2ZjQuLjllM2EwNWY4ODIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9o
ZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jDQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNf
ZGVmLmguaW5jDQo+IEBAIC0xLDUgKzEsNSBAQA0KPiAgLyoNCj4gLSAqICBDb3B5cmlnaHQoYykg
MjAxOS0yMDIzIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMNCj4g
UmVzZXJ2ZWQuDQo+ICsgKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyNCBRdWFsY29tbSBJbm5vdmF0
aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzDQo+IFJlc2VydmVkLg0KPiAgICoNCj4gICAqICBU
aGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5k
L29yIG1vZGlmeQ0KPiAgICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5DQo+IEBAIC0xMTcsNiArMTE3LDcgQEAgREVG
X0FUVFJJQihJTVBMSUNJVF9SRUFEU19QMSwgIlJlYWRzIHRoZSBQMQ0KPiByZWdpc3RlciIsICIi
LCAiIikNCj4gIERFRl9BVFRSSUIoSU1QTElDSVRfUkVBRFNfUDIsICJSZWFkcyB0aGUgUDIgcmVn
aXN0ZXIiLCAiIiwgIiIpDQo+ICBERUZfQVRUUklCKElNUExJQ0lUX1JFQURTX1AzLCAiUmVhZHMg
dGhlIFAzIHJlZ2lzdGVyIiwgIiIsICIiKQ0KPiAgREVGX0FUVFJJQihJTVBMSUNJVF9XUklURVNf
VVNSLCAiTWF5IHdyaXRlIFVTUiIsICIiLCAiIikNCj4gK0RFRl9BVFRSSUIoSU1QTElDSVRfUkVB
RFNfU1AsICJSZWFkcyB0aGUgU1AgcmVnaXN0ZXIiLCAiIiwgIiIpDQo+ICBERUZfQVRUUklCKENP
TU1VVEVTLCAiVGhlIG9wZXJhdGlvbiBpcyBjb21tdW5pdGl2ZSIsICIiLCAiIikNCj4gIERFRl9B
VFRSSUIoREVBTExPQ1JFVCwgImRlYWxsb2NfcmV0dXJuIiwgIiIsICIiKQ0KPiAgREVGX0FUVFJJ
QihERUFMTE9DRlJBTUUsICJkZWFsbG9jZnJhbWUiLCAiIiwgIiIpDQo+IGRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eQ0KPiBpbmRleCAxNGRjZjI2MWI0Li5iOTZmNjc5NzJkIDEwMDc1NQ0KPiAtLS0gYS90YXJnZXQv
aGV4YWdvbi9oZXhfY29tbW9uLnB5DQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24u
cHkNCj4gQEAgLTEwMSw2ICsxMDEsNyBAQCBkZWYgY2FsY3VsYXRlX2F0dHJpYnMoKToNCj4gICAg
ICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZMU0JORVcxJywgJ0FfSU1QTElDSVRfUkVBRFNfUDEn
KQ0KPiAgICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYignZkxTQk5FVzFOT1QnLCAnQV9JTVBMSUNJ
VF9SRUFEU19QMScpDQo+ICAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCdmUkVBRF9QMycsICdB
X0lNUExJQ0lUX1JFQURTX1AzJykNCj4gKyAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFE
X1NQJywgJ0FfSU1QTElDSVRfUkVBRFNfU1AnKQ0KPiANCj4gICAgICAjIFJlY3Vyc2UgZG93biBt
YWNyb3MsIGZpbmQgYXR0cmlidXRlcyBmcm9tIHN1Yi1tYWNyb3MNCj4gICAgICBtYWNyb1ZhbHVl
cyA9IGxpc3QobWFjcm9zLnZhbHVlcygpKQ0KPiBAQCAtMjAxLDYgKzIwMiwxMCBAQCBkZWYgbmVl
ZF9wMCh0YWcpOg0KPiAgICAgIHJldHVybiAiQV9JTVBMSUNJVF9SRUFEU19QMCIgaW4gYXR0cmli
ZGljdFt0YWddDQo+IA0KPiANCj4gK2RlZiBuZWVkX3NwKHRhZyk6DQo+ICsgICAgcmV0dXJuICJB
X0lNUExJQ0lUX1JFQURTX1NQIiBpbiBhdHRyaWJkaWN0W3RhZ10NCj4gKw0KPiArDQo+ICBkZWYg
bmVlZF9zbG90KHRhZyk6DQo+ICAgICAgaWYgKA0KPiAgICAgICAgICAiQV9DVklfU0NBVFRFUiIg
bm90IGluIGF0dHJpYmRpY3RbdGFnXQ0KPiBAQCAtMTEyOCw2ICsxMTMzLDEyIEBAIGRlZiBoZWxw
ZXJfYXJncyh0YWcsIHJlZ3MsIGltbXMpOg0KPiAgICAgICAgICAgICAgImhleF9wcmVkWzBdIiwN
Cj4gICAgICAgICAgICAgICJ1aW50MzJfdCBQMCINCj4gICAgICAgICAgKSkNCj4gKyAgICBpZiBu
ZWVkX3NwKHRhZyk6DQo+ICsgICAgICAgIGFyZ3MuYXBwZW5kKEhlbHBlckFyZygNCj4gKyAgICAg
ICAgICAgICJpMzIiLA0KPiArICAgICAgICAgICAgImhleF9ncHJbSEVYX1JFR19TUF0iLA0KPiAr
ICAgICAgICAgICAgInVpbnQzMl90IFNQIg0KPiArICAgICAgICApKQ0KPiAgICAgIGlmIG5lZWRf
c2xvdCh0YWcpOg0KPiAgICAgICAgICBhcmdzLmFwcGVuZChIZWxwZXJBcmcoDQo+ICAgICAgICAg
ICAgICAiaTMyIiwNCj4gLS0NCj4gMi4zNC4xDQoNCg==

