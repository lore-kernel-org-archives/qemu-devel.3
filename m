Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DCEC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwdx-00062Z-1m; Wed, 20 Mar 2024 10:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1rmwdu-0005zV-3S; Wed, 20 Mar 2024 10:10:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1rmwdr-0004S4-Of; Wed, 20 Mar 2024 10:10:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KAK2j6031981; Wed, 20 Mar 2024 14:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=qcppdkim1; bh=y2Qj1gLOXfStjmjt9Cq/tl3wWp8ISKoaHs6TCFa18Dg=; b=
 PIFWAhuxdtrxQn+IrEfXg3Qr77d604MOulDjHGShz4UXZnbog8uPuwUs33AvqPhw
 RFkJsCSeKeC8tNqGWPCwu6MbyC+kDBKluDZ90x/73ykwNUZLpE1mJLOBWCHTdsfD
 oDCJN9SzlIjEWRqRSo5VcyTZOK4jSG4kX4qmQlmX9yN/v5m1aht9vgl12ws2UJDn
 nYqw4xt2L/wzLtgm8DOUjcvGLv24tAlFY62Y/tYZ4rv7oLruo/F6Dv8rvp37gXk+
 tLd7jYhA1VcWSWAU2mH9GZEw22EploL4o8OrGQ0lwH8c1fyrTELh53hIH8Pujuf8
 gma14lp8T5JpvSPqUnc65w==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyq60sans-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 14:10:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRtH3vdYTsZgrL+FZeBHOdlyH/m6fVFlaOII0S8kM8gTTJ1axu+Rwv5qrmpOT+MI+PsyQxKLpc5RdZYMnjISTxRdpmbMNf/DaFvfx0satmygljjXbJeArFNDm9diA3mNQ76XWi7Mg6XzwugVk75MZt1RreJwWyYYozZsOcwougz2acxgfmEbDrISgqe4RFbeNODZjM5jasyHydHd6DuphBSWckFjWxCa2dRan8ZOjkR16d7DSqqQ/9VPTBHc6wrsUU+fe9A8GvdjgcLmf8fWD9AlgBlNPW/8CzUnnjU9DfgaPNaomsy2wcQMInXiDR/Ok7myvBs6L2zZiEaCkU2j9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2Qj1gLOXfStjmjt9Cq/tl3wWp8ISKoaHs6TCFa18Dg=;
 b=I2DS3vcHuS0DWGGJ3/7DgiziYmvzp6iXjJcHg99svlazCWLvyhky0Mi6avQCGgYmA7hTg3hNr8cwuVCSh+nuwqUNB6ERtTZ2/o6wu4iGSqXTygyCpMS0Dn6G9USFYx7kR4Q6ciiEu5duGKmoM94mNkbZ2vX+GpBSwRCvdCvA7xawX7wMm52mAXvXX6JlyD2C06xVdiN8iLcRK0fOf0wOQpSSYCDIl+gcHwB7ADA5a3sqage7lzJ6HYaLyZf+IO/La6HqfuZMvGUkzrN6Lcx4DDwHEAOdZpfXCmVSfu3raE+TlLjzrLyRVXOoZYzmK+7aBOw3S1hLRtz5mBkCUM9FpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com (2603:10b6:a03:53a::21)
 by DS0PR02MB9545.namprd02.prod.outlook.com (2603:10b6:8:f2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.30; Wed, 20 Mar 2024 14:09:58 +0000
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::f655:6bb8:2692:cb0f]) by SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::f655:6bb8:2692:cb0f%3]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 14:09:58 +0000
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
Thread-Index: AQHaerh97y9neLDZOEe71DBZx3RqVrFAhvkAgAAIqYCAABd6gIAAA/qA
Date: Wed, 20 Mar 2024 14:09:58 +0000
Message-ID: <23BCD870-16A1-4AF9-9308-2788178F511B@qti.qualcomm.com>
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
 <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
 <59C20F1A-FCFE-4E26-B511-A6C0E1EF6F61@qti.qualcomm.com>
 <CAFEAcA8MVbKqv-TgaO7Vv95f0p164Gao+LT-CM5+92cXjkpmTw@mail.gmail.com>
In-Reply-To: <CAFEAcA8MVbKqv-TgaO7Vv95f0p164Gao+LT-CM5+92cXjkpmTw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9884:EE_|DS0PR02MB9545:EE_
x-ms-office365-filtering-correlation-id: 927ac261-51d8-4e9e-de5c-08dc48e76d01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vJely6AEpsGff1npCI8uegMpqLE0tkBw3QTKxh8Vx5pRD1/2QE6nfKcRBSoN5IwJdccqGv96VOMZdfaKnUmiMdQ7DU+oZGUMIRjMzLxKjO6x3vvExLKySmVfkFfma24N2UiXpK+TQWG/x9jpeh1pgNJVz3YvuxNLS+YYIcY4MwWKnqhfBapU6nUrsD5Udf0B0J68zOCxmS34Yy/3UbQEnAFkm3igdkOgpXNzU7u+auSloGklCZeZP2jPVq865vIfNKUlsrwmMI+VFNJ0VExek34UYI9eW87rrLfespfDtjkHwGT+IMYEFCpzRo0qdW2vrrLc5Qgq+whcEuzJoeeF86d/mh+pRAtzhAJdPogAKoCu1LNkfSow0h5m2p8+MDCSIRPam3KCmmFtASR5Teb11wo6lQ6zREgXEY3pq6OBYaPGQjWHgHIOGjqKMH2yywSB4Zs4uEnG0cSYh0PwkDqR9LBi1r7oBdiru124+p9iF+VNSqp1bKaSVxj9Scy5Di3ouKNi1+qXZ8ksgaK5IrIMp152VksO4lqSrF/Os+wmLxwIQJwSz+jcy0APKsHXZBUOh13OY1/Ge/vwgiNUQnkNhT2cnXmZdoPbyyohrsfM45TC0ieQmuJF1Y2JJ/Y8Tfc4lk6NZjX36PEzfWaDwFFeTvnnfony1Gh3W7xHBUq1suCAp2wGWzo3cAujI1N7d4qCwd/GRDilhKDAcfw71cY3Zth/OsO7Z5mUr6VcRXL0XE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9884.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWpBTlhadm1CS1Ewbjd6QnUzeDliTXlCNjRyR1dGMGZDK0FSKytGc1FueG9I?=
 =?utf-8?B?YzRhbkxBanNjVngzQWxwcGE1YWtmQXVJeGVUeUhxUEc2TnhSdXN0V0NiZzNp?=
 =?utf-8?B?ZkFoNUFKVkpUZUdIOFJ1TVdHWEtWV2lWSDAwNnc4a1BidjZ0dmFLTnJjdEJJ?=
 =?utf-8?B?U0JLUW5COFpyNXRnRkRWNlJGenVPOTFHNG1JWkpydWNNZWRvUVk4a3ZZS2dF?=
 =?utf-8?B?VmJsZ2hwdHNmcUdPMnBLUlBndmRFWXFZYTlVaFJoVkZ3UnU3UVh2bk5FTFFY?=
 =?utf-8?B?SDdOQ25YTnpXY2IwRmJpVGpncG5hekdIQ0N2RFBrUG9mcStEMmd0ZXJqL1Nt?=
 =?utf-8?B?YlBYdjN2NkYybldzeVc3NzJONmN3dW9YS2ZhS0FDTEVHQlg5VVUzaGx5djJj?=
 =?utf-8?B?cEtPQURueGp2bmJ1c0szVGptNHVjckNNNEFYRHhXY09CT1NQOURvRlo0QXZ3?=
 =?utf-8?B?TExGcnJKc2l1UFlwMW9FSnc3YWlsTlB2MmMxVHdaYzY0RENFbzF6eWFJUzJK?=
 =?utf-8?B?dy9MZklwb01lbUxrcFdsdkFKL3g4djlaS2w3VU9wdzM4QUFsRFc1UlZCZit6?=
 =?utf-8?B?VDdId3dhUmJiblJuR3VTTGJOaTBJVFdEV1Y3cVIxS2Fmc3poeGdnV25VQXpE?=
 =?utf-8?B?SjJiSnAxVFNDVldTcTVmcElrYUsrM09XN1pMN2RlNElXS0ZVVEpLNnlFRytE?=
 =?utf-8?B?RjVQMTFHRldZYjY5dXFid3FFRm5xdkljbmpHYnhoQWFOWm9VamVNSmVFVVN1?=
 =?utf-8?B?R1ZUMTRzRmlQcUQ3aVlOTnR3SGVPa1h4Mno0bG1uVVNjM0dTRVJmY0hYT2RG?=
 =?utf-8?B?WXRmbVA0YjJkenBaK0d6NUsvQ0lYNEppdjFkbEUzUS9aUWlpWjJNczc3aytu?=
 =?utf-8?B?cmJQcFQ1L3lhUDRGN1p6NVdsVFlDOHhHbU1PNWFFTENyaTVxZVZiWjRkMm1l?=
 =?utf-8?B?RHFBM2NMVkxVTmVqOXk3TEkrckVnV3o4c1lEYWpPK3gxYm9maU9QeUpjN09T?=
 =?utf-8?B?R0l1S3A5QkNpRXpiQmxxRTdaTWo1MzhRQ2pRdjR2SmRTSDhNUlNsWUJ4U2tQ?=
 =?utf-8?B?VEF1NDc0YWxQTThmUlIwdWtReUVwN0pETHc3czJuVXdmOVQ0b050OWR6ZjBy?=
 =?utf-8?B?OUpaZ0NxaXVlZHNNblNLSjVPcnQzRllxZXA3SUZNZ0hINFRiVW9zZ1EwdmZk?=
 =?utf-8?B?Sk9ERHNIaFo1aUZvWk1iUjJqYnFTVmpVdnZZWWRvdmdBaDNBcXdya3lyVDRK?=
 =?utf-8?B?WlBGTmV4THpXVVM1ZjdHQ1UzVW5sMTBnU2JSNk1veWhmMVJYbWNXekZkSzlo?=
 =?utf-8?B?dXZqUVJYU0Jlalk1T0Z4bW00My9BNkhzS2dSTlZyaFNCS3F3cWFrSXFlanVG?=
 =?utf-8?B?U01SemhlREtMN0REQWtyL1Q0Tnh1Yjl3bithc3dQK3J0UGQxZWhSNzF0eTRE?=
 =?utf-8?B?YXFFekdCVlBhbytSWG8vKzd0eGZDUkJMMVFZcE9HTHpISW9uU0Zkb0dQaG5J?=
 =?utf-8?B?ejNtcWFCbHlSYk5DYjEwaEU0cVEyT21MSTNPTW5MOEY1WlV2OHpXeWNsc3M4?=
 =?utf-8?B?SURyTWloU05hWU5DYTV6NnpFenloR2d1MUFhd0k0RVBaQ3pUZ3lrQnp6TUNl?=
 =?utf-8?B?SXMwZ1E5WG5EUHRtazZUNzN0WnlyK01CZk1MM2RZYjdmMWRKck1YY2tDTkNv?=
 =?utf-8?B?RDZ5bmVMRkZTOUx5bWZ5TmI3SlhoUDQ3WjNYa3g0aFhwMDRmcC9OVUFpelUy?=
 =?utf-8?B?RHJ2eUZqUTVkWHF1eE1MMmdNMjBOZHpTMEd2YTZLZ2QrSTVkdysvN0hVcFhU?=
 =?utf-8?B?Q1M4ZGNHU2lhcG9Ga3c1R3NFTDFYSHlrL09CMjlQWHdiVTIwTmpmaTQ4aXBN?=
 =?utf-8?B?bjZ6R1hlODlETFFxbXozeitCS09XU2JxbjZvajdjamRmTUEwNXRhYVYrS1B6?=
 =?utf-8?B?dFNtL1JFelpGc3pSQmZ4VSsyeE1LUVBCQ0xHaTdQamtvSXR6ZDhSVnZDOFB0?=
 =?utf-8?B?VyszanlpTGRJb0JQLzlEcXE0dnVMcUMxRWt6VUN1em50NzhYNUhDNXgyVTMw?=
 =?utf-8?B?dVZJSWw0RXI0eHJDdHhOMDF6SXhjZDFPZGhYU0lYUU1iMDlqcThBbmlWUmZC?=
 =?utf-8?B?S1NNSTdGektvaHlnRVBnenBnQTBoWnlqbXlGb1UrREFrVlBBNi94YmRGQ1R2?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD2EEFAF78F294439565757710A1C739@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 719QyL3tsoNSWtlQYNAFo4hHVP1+iyREuD3RTopNq4Wbrj118z3dqDFrcSOEeLH2AwZnJJT31gZgsdqGOtbOZGNdKE1XCbMqb0sClu66tQp5Pmx/K1QEGlYL2mzsX6yDtbvHjbiSVW3MbJZbLec1H3Y62ouFk3LjcHO/fsPXZZkvtJNl41r29A+WZEfDUZGm25LzdcJbMk92GBOSuzCjGtHC9oETbmCJ7A3dJM7UjCMa0WjOyDw6lIw4kin5muqOFbO7rXzqW0R8L2HyDQ3fKspkL+2ZKi8gmpd7++5l6A4lb6zmduvIkeyRF3zyfEIUXuHb1NtvRkgJJ6rY0cKCUqsqWCIxH/P4t/cvS9MbOKEu5c2t6TsX99n69mycp5mEEhEbtryF6o2TIwwiiUvQs3LLqqzNIEiKvLVvtcuQK6elG8weCk9n2rQEvnbSef+GIMkHGjmi7/AT9MSCDo2GY/vvSQiRhqifI6uMFQixnAe4fDBxtZIVgjvqoOgJS9hLV//KBpoE/4G13EZNlHHEtnKimFG2JHFc4NTFIASMoALU/MLIyiyompu62GiEze6f/6Rn6CkoZaYqKuDCTFzMd61AzOYHRP/d95zbcdVM/q7VOKOMOpgPOhwlsTBozMDx
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9884.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927ac261-51d8-4e9e-de5c-08dc48e76d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 14:09:58.2676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8tpcclhv1T8l+s5Mq2YHr5cFrCZTA0UyAp+cIBv8aN1jEnd0Z6Ck+dVaKy/Vj52+7sA24YKy4ISq3TjdpHGG6xUmGTENAA3hQz2rhuEcto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9545
X-Proofpoint-ORIG-GUID: _ImrrNAHDGDysHALe5oZ4_AU1QJj6KuZ
X-Proofpoint-GUID: _ImrrNAHDGDysHALe5oZ4_AU1QJj6KuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200112
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

DQoNCj4gT24gMjAgTWFyIDIwMjQsIGF0IDE0OjU1LCBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxpbmtz
IG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBPbiBXZWQs
IDIwIE1hciAyMDI0IGF0IDEyOjMxLCBNYXJrIEJ1cnRvbiA8bWJ1cnRvbkBxdGkucXVhbGNvbW0u
Y29tPiB3cm90ZToNCj4+PiBPbiAyMCBNYXIgMjAyNCwgYXQgMTM6MDAsIFBldGVyIE1heWRlbGwg
PHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pj4gV2hhdCBOTUkgcHJvYmFibHkg
b3VnaHQgdG8gYmUgaXMgYm9hcmQtc3BlY2lmaWM6IHNvIGl0J3MgbGlrZQ0KPj4+IGhhdmluZyBz
b21lIG5vdGlvbmFsIGZyb250IHBhbmVsIHN3aXRjaCBsYWJlbGVkICJOTUkiLCBhbmQgdGhlDQo+
PiANCj4+IERvIHRoZSB5b3VuZ3N0ZXJzIG9mIHRvZGF5IGtub3cgd2hhdCBvbmUgb2YgdGhvc2Ug
aXMgPw0KPj4gICAgICAgIDotKQ0KPj4gDQo+PiANCj4+IElzIHRoZXJlIGEgcmVhc29uIGZvciBu
b3QgdXNpbmcgYSBHUElPIGludGVyZmFjZSBmb3Ig4oCZTk1J4oCZIC0gd2lyaW5nIGl0IHVwIGxp
a2UgYW55IG90aGVyIHdpcmU/DQo+IA0KPiBUaGUgcGxhY2VzIHdlIHdhbnQgdG8gZ2VuZXJhdGUg
J05NSScgYXJlOg0KPiAqIHdoZW4gdGhlIHVzZXIgdXNlcyB0aGUgJ25taScgY29tbWFuZCBpbiB0
aGUgbW9uaXRvcg0KPiAqIGluIHRoZSBnZW5lcmljICJhIHdhdGNoZG9nIHRpbWVyIGV4cGlyZWQi
IGhhbmRsaW5nIGNvZGUgKGluIHRoZQ0KPiAgIGNhc2Ugd2hlcmUgdGhlIHVzZXIgdXNlZCBhIG1v
bml0b3IgY29tbWFuZCB0byBzYXkgInRyaWdnZXIgYW4gTk1JDQo+ICAgaWYgdGhlIHdhdGNoZG9n
IHRpbWVzIG91dCIpDQo+ICogd2hlbiB0aGUgdXNlciByZXF1ZXN0ZWQgdG8gc2VuZCB0aGUgVk0g
YW4gTk1JIHZpYSBJUE1JDQo+IA0KPiBJbiBhbGwgdGhvc2UgY2FzZXMgd2UgZG9uJ3QgaGF2ZSBh
IHBvaW50ZXIgdG8gdGhlIGJvYXJkIG9yDQo+IGFueSBraW5kIG9mIGlkZWEgb2Ygd2hhdCBhIEdQ
SU8gd2lyZSB3b3VsZCBiZSwgYW5kIGJlY2F1c2UgYXQNCj4gdGhlIG1vbWVudCBUWVBFX01BQ0hJ
TkUgaXMgbm90IGEgc3ViY2xhc3Mgb2YgVFlQRV9ERVZJQ0UgYQ0KPiBtYWNoaW5lIG1vZGVsIGNh
bid0IGhhdmUgZXh0ZXJuYWwgR1BJTyBsaW5lcyBhbnl3YXkuIEZyb20NCj4gYSBjb252ZW5pZW5j
ZSBwb2ludCBvZiB2aWV3IGFsbCB0aG9zZSBjYWxsc2l0ZXMgc2ltcGx5IHdhbnQNCj4gdG8gYmUg
YWJsZSB0byBjYWxsIGEgZnVuY3Rpb24gdG8gc2F5ICJ0cmlnZ2VyIGFuIE5NSSBwbGVhc2UiDQo+
ICh3aGljaCBpcyB3aGF0IG5taV9tb25pdG9yX2hhbmRsZSgpIGRvZXMpLiBCZXlvbmQgdGhhdCB0
aGUNCj4gaW1wbGVtZW50YXRpb24gb2YgdGhhdCBmdW5jdGlvbiBpcyBqdXN0IHdoYXRldmVyIGlz
IGNvbnZlbmllbnQuDQo+IA0KPiBJZiBpbiB5b3VyIHBhcnRpY3VsYXIgbWFjaGluZSBtb2RlbCBp
dCBtYWtlcyBzZW5zZSB0byBoYXZlIE5NSQ0KPiBiZSBzb21ldGhpbmcgeW91IGRlYWwgd2l0aCB2
aWEgR1BJTyB3aXJpbmcsIHlvdSBjYW4gaW1wbGVtZW50IHRoZQ0KPiBUWVBFX05NSSBpbnRlcmZh
Y2Ugb24geW91ciBtYWNoaW5lIGNsYXNzIHRvIHdvcmsgYnkgcmFpc2luZyBhDQo+IEdQSU8gbGlu
ZS4NCg0KDQpJ4oCZZCBicm9hZGVuIHRoaXMgdG8gYWxsIOKAmXNpZ25hbHPigJkgKElSUSwgUmVz
ZXQgZXRjKSAtIGFuZCBJIGd1ZXNzIHNpbWlsYXIgc3RhdGVtZW50cyBhcHBseSwgd2l0aCB0aGUg
4oCcYnJpZGdl4oCdIGJldHdlZW4gdGhlIGZ1bmN0aW9uIGFuZCB0aGUgR1BJTyBtZWNoYW5pc20g
bW92ZWQgY2xvc2VyIG9yIGZ1cnRoZXIgZnJvbSB0aGUgb3JpZ2luYXRvcihzKSBvZiB0aGUgYWN0
aXZpdHkuDQoNClRoZSBpc3N1ZSBpc27igJl0IG15IOKAnG1hY2hpbmXigJ0gbW9kZWwsIHJhdGhl
ciB0aGUgY29tcG9zZS1hYmlsaXR5IG9mIChhbnkpIHN1Y2ggbWFjaGluZS4gIEEtcHJpb3JpLCBh
IG1vZGVsIHdyaXRlciBkb2VzbuKAmXQga25vdyBpZiB0aGV5IHNob3VsZCByZXNwb25kIGRpcmVj
dGx5IHRvIGFuIE5NSSBvciBub3QgLSBIZW5jZSB0aGV5IGRvbnQga25vdyBpZiB0aGV5IHNob3Vs
ZCBpbXBsZW1lbnQgdGhlIFRZUEVfTk1JIG9yIG5vdC4gVGhhdOKAmXMgYSBkZWNpc2lvbiBvbmx5
IHRoZSBtYWNoaW5lIGNvbXBvc2VyIGtub3dzLg0KTXkgc3VnZ2VzdGlvbiB3b3VsZCBiZSB0byB1
c2UgYSBHUElPIGludGVyZmFjZSB0byBtb2RlbHMsIHdoaWNoIGNhbiB0aGVuIGJlIGFwcHJvcHJp
YXRlbHkgd2lyZWQuIChBbmQsIGhlbmNlLCB0byBoYXZlIGEgc2luZ2xlIHBsYWNlIHRoYXQgaW1w
bGVtZW50cyB0aGUgVFlQRV9OTUkgaW50ZXJmYWNlIGFuZCBwcm92aWRlcyB0aGUgR1BJTyB3aXJl
IHJlYWR5IGZvciB3aXJpbmcgdG8gYXBwcm9wcmlhdGUgZGV2aWNlcykuIA0KDQpDaGVlcnMNCk1h
cmsuDQoNCg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0KDQo=

