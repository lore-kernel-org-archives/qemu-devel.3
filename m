Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F8DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDo1J-0003jC-Bu; Tue, 28 Oct 2025 14:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vDo1E-0003iF-Dy
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:02:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vDo10-0000NM-E4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:02:03 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SFVX083264077; Tue, 28 Oct 2025 11:01:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DEkcMBHmZGU93qZZMuWGEJGnuMvqZ/ZvjXjt+ellG
 9o=; b=qnF7x9MXnd+FfEFWEdWIeqAntFQrZdM+heIvPxNUIRqJn+YhWr+GtljFA
 hhBiRnUD/IUoqqshj9eWzQgBBEb6SsILjU4xjlgYcOCc6rcvvXPoMBTN3ZfnOfHE
 wNX3+x2HN318k1/+vuKNMoUozQ9qb+5wiwGWqtqWq4hpHr7gIqm2kYb+1fC2VDtX
 s+19ZJ9xQXzZL+NpsSMkHrTEM0noEhakwQ0Hd1xXY9t2fKFNfMx/GeGbGnBHaBrx
 D7g73WJROZhY3bBPkPuf1vAJl6D1P3PKVCrE/VtoS/iP/QCRvWyKtl9rkVzvQapz
 Fu+gNCwAAAjgBNreAXxBAgAWhGo8w==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021109.outbound.protection.outlook.com [52.101.52.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4a30j4gcqt-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 11:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+zHlVYE4tKwpLu/kH/1WjQqq8/2DTQNj5/flYc5EWpz5V0YaTNIQW1H0lUFQc06cRyMQJTkKHwQW7ic72EUtkV1Y5DaBKlzbFDnumzZHEyn/p05t2YP5ssoCkdk3HL06BjQbfJP9FYQiVyRorXDk0dA+AfAc69wpw/fA2AN/z3mo99rq0bIIMSdH5wx7Dzu/qicoQU4MnZPxB3Pp/RDfWR+VrJYBZtVoZvKCSmZWBmANMK3DnZx9fGcrCNxwzCVluSU8SGPL2FdPi/qikMFL1MZqUkEyskJ7wSvHwGsBIqIHZF0jvKsmCTk45IthWBba+stjwTApS9bsaLMMjpkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEkcMBHmZGU93qZZMuWGEJGnuMvqZ/ZvjXjt+ellG9o=;
 b=sGpkmu0Kr2aKu/Q/GKihiwQaJN4kmyVQMgoEpeuMxTtALeHpOtwNoq3Xq/rxF6vz1iDL2z2ADIPawW2FHzeJejSOzZSWh+b5MCYPV7FCyCJi5rgIPkbFiCXaeSMcDRGg6/ZwiihE6y0fPCiMq92+fhfAwkUzawT6AJsejAZGLxnLeDICk3iDPPdnoxv6cEDaC27jHwwEN3kjsh4H5JGvGOygCpUR4CaLOMpjSbYGKb0++Ye/wxoa45XNnB5MEDd9DYac8IIgGK+i1CGgD6f6DMli5/1y17egFWPXL5KSmXQToLgjKxV1oGJztb2iIT+jQWjmBKvYz9pt3s9iLERIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEkcMBHmZGU93qZZMuWGEJGnuMvqZ/ZvjXjt+ellG9o=;
 b=lVY+VBkKdJvfPOk8f7EEAyddD7pdYVnKtpqlNv8r9IwXre3yBaK+uhzY7Tsj7BE31ISj2x0sQwUjLH9/k9O7CUD8CkuFq/LNLmq5vpHpS4oVHFn/IjkyJea//Y8XjRS6dPNURwj/uVFq37OFjXFKrCV26u61cUvNNApIWfN6k2x/Qpu7Tt4f/3dfdgzCeC8R4GA+xyMWVN706ZIVvpWcaJAz2nTosR7qNSioMthRG+na23IMs6LmcUbbSqqiOpEtaLHzg95aiYdGb8r+MUiNJt45ghajQZJiR/B8M8bH4YuELcXLtx/MA38dmuv+cQwnXK+YKuHpnxhjCTCndLaUxA==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by MWHPR02MB10548.namprd02.prod.outlook.com (2603:10b6:303:281::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:01:21 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 18:01:21 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "minyard@acm.org" <minyard@acm.org>
CC: "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, "corey@minyard.net" <corey@minyard.net>,
 Jonathan Davies <jond@nutanix.com>, "cornelia.huck@de.ibm.com"
 <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/2] hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel
 config
Thread-Topic: [PATCH 2/2] hw/ipmi/ipmi_bmc_sim: Support setting fake LAN
 channel config
Thread-Index: AQHcSDTd7FALtb84VUatIr6Y31K5DA==
Date: Tue, 28 Oct 2025 18:01:20 +0000
Message-ID: <20251028180115.1098433-3-yunpeng.yang@nutanix.com>
References: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
In-Reply-To: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|MWHPR02MB10548:EE_
x-ms-office365-filtering-correlation-id: 6a02a75d-4484-4eac-eda0-08de164c004e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+GQfvz2V6Mz1C8lmoqqauccLb0gSVS2O9Ox9w63hQADZF98XrqFFshHsnG?=
 =?iso-8859-1?Q?btYUxFtfg2mJsM1c2JfDjwXhJIkjds1A57QSVicCiCSCgmvxDx2pbgZilU?=
 =?iso-8859-1?Q?70FyZ4v2ou8XkQS3MCS2uczXeo/cAWmCjyn/t12kNFJ6jiGpoX2ejFkH4o?=
 =?iso-8859-1?Q?mszuls6JNfC6zMmSsOmPX9SzGg5miZ2+dsJ6HuUX60nO/T/O+ifBpLuWUH?=
 =?iso-8859-1?Q?lkCCZTI3/6TPf/sTMoTlK40RaPNKPJwtlvrJfANHypIh4AB6A0Y8TIi+Zd?=
 =?iso-8859-1?Q?8rPFkDT8YLVjxfg4x6aKbS7jcnVFFJKpVVCcVUM30kkOnxd74PPBNsLLfH?=
 =?iso-8859-1?Q?iwrbRY1jL9L/KILjM0miwiIb3lwkG5srHPHZqV74hGcvLi4JAtYQkOdFIg?=
 =?iso-8859-1?Q?AfCck0PinS4VsMfujzLaM4Ck2LpeCg+Ki7sD17XH9+xgwyixIf+qMw4z3j?=
 =?iso-8859-1?Q?Cp84JIz7vvT3BapcIr+9SouoZMzzmeIF0ggWPOa3BMMo4IKbA/rSz1/hQo?=
 =?iso-8859-1?Q?vzQlSPKu7zltw+lZeOPBEzezKv9ZRtzuadTP1k3ib6A2B+3d27VdhPVFCf?=
 =?iso-8859-1?Q?zgALckYnWgB9O93nibYKU5BnbufbS/pYHF+cTxOZTzUnoHa3+lg1G4qtQP?=
 =?iso-8859-1?Q?9i+EEqjpH/hFKMrmFaEnkmWOWCat/TNqHgfvvmq2ns/m2DQ44OGLvMdnV4?=
 =?iso-8859-1?Q?Q6efYnwvu88705VfdAN5yMHIWfK2ftB+Mr/Hs4VuHdtvU8fZ+2ehWKvPSU?=
 =?iso-8859-1?Q?ur7uzjbC0saz8gMAxhKxg15nbNaBk9uYXTaAo0BfmDUGEFn6VSYeSCBVsg?=
 =?iso-8859-1?Q?oT68002BxmbzOHr9f0pukWddUJvdJUvEoNjoNlEWP1Vuc3WIZY//mhjLU/?=
 =?iso-8859-1?Q?pMb/puNjU0eUuFC4OcbK8JE5QdILv8fO9BnDxA/cSDtSA4/PNy+dVkosVz?=
 =?iso-8859-1?Q?h+pBT17B0EgRMdr7xgCl6YB1SdSU53aXIPuETTneQBiZq/Hp5OY2E+VKcP?=
 =?iso-8859-1?Q?0PHMEK8igW7SWDVypMdEx3f0QpidgWnYBuTQ3p9YNh/TWFLORZObKJShGH?=
 =?iso-8859-1?Q?Z6jbArl87dAgJR9p2GLpq4y/Dhv9faZ95gy/tjCCHnDUyaWQBwv5Jg80QA?=
 =?iso-8859-1?Q?yRt4s4U1zQ1uuE4DNdoKI7wcn6mhNNZlST0tyAcMvMRJ87l5X8ng2ehKEx?=
 =?iso-8859-1?Q?27K4kEd8hN2AMceGfuSZDy9mdyC7h4AR3GX+EUzmxebJAs9h9dbq/io2pK?=
 =?iso-8859-1?Q?VEwYQPP29PDaLueDI59j6HAq1jbONydZ3qN3zmv3mkCmqWfeEEKjukWSBs?=
 =?iso-8859-1?Q?AsUF6xZ+U2XdiHc0OnRIjj1ZYf3HbOn/Lm8374dnSzBGv8V0evwVcZ2UJi?=
 =?iso-8859-1?Q?OJnRgrMgc0DCi9gPPZiyOtHunQEX0hpwKOCVLBP9lvyPFEYL80PnFxFAek?=
 =?iso-8859-1?Q?LGTNIqUPUarUCEiP/DGuPec8DZ8aW/iuGym00J0eIcHC7mk5OvDdfiGTY7?=
 =?iso-8859-1?Q?L6U0rP19ezXsl2TPrPH/TPgeRWrF9RcnFc9tsVFKjWQaL48zz5gwRLGWNv?=
 =?iso-8859-1?Q?L0Fk66MXFN6Ka+OFQpTwXTGLyr7C?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ulvr3Y+982lv03yFjfpxJiYpLcuFyn/J8rc/XeKO8fRMs75YQlZZNc2+Df?=
 =?iso-8859-1?Q?/cAb1DocBQ9OFMxnA7SuipI23CKOuJlXiFLaSk8NRg+cNvnGbVVinel55X?=
 =?iso-8859-1?Q?ekj0bm2UGNsBY3DcG9wSOT6yQu9UEMlllZ3UrAHg9UBObKQk3sr/sPyIug?=
 =?iso-8859-1?Q?MH1Mmr3ZvDkD1PBVNnwKJtX73Es/6Qi8zphqWyKl56Dno/SS4WYmSIS22I?=
 =?iso-8859-1?Q?3VsHcGWDAGPJPvCIWuGbNMce75KIWdJgRSCZJKKe1JFmAcuMCGytDgI/o2?=
 =?iso-8859-1?Q?YvLZ5gkkDL5PNACUrNLqw0fVJBCSKEManf/ZPXfB7r/Au9eyOz57Aq1G0W?=
 =?iso-8859-1?Q?k3yuHfzYI0AWNUdhxLfLQk3A7/i8vNoBC7Gqek6tuTFodCG85Agh1j9G5r?=
 =?iso-8859-1?Q?Dnr0i+KfqBqx9S1oPTuaKwq1+9MyX4X1xjpYYS7iLMCqXMRUT9ugu/Lj0S?=
 =?iso-8859-1?Q?vv8raiXLWbFaaBzh+/pAF9TWV4srrtWUgUutq09omgz1XSvIsi7YBiQyA5?=
 =?iso-8859-1?Q?izmfgbwVyuVBvKPyz0fLQBcJ7Grc1h8PjDtdmSEZrkE2jVkY2j0u9KvBHX?=
 =?iso-8859-1?Q?47pdmzQ/2t3fIU2xwitSVhNM0A7gwDKh5q6PSRvm50/mOGu/6bndlkLxOY?=
 =?iso-8859-1?Q?Dc7Jsh3/S8rsDtchw51zoFwB0rT0stW51QfsCMqgVqYTSdVHdbdPO3myGH?=
 =?iso-8859-1?Q?IIQQfSGJ6H8gmkHw/CpRXqoc9ijjPY2JejVwAnCCIUbTrBw1XA7bIue0Pp?=
 =?iso-8859-1?Q?Zg56O9Hh79xlaM8jmrV8IMRostturu5DPBjQ+nwQXTMtYeZ8Jdy4FO9J3a?=
 =?iso-8859-1?Q?tFt8IUaDw0Pi3lgJ02j4QVNE2UyG2PfNS+Bjb/klqlLVblepAaWKScJhDW?=
 =?iso-8859-1?Q?955PPSUUVCWRL10hIc0V7rtbOpeOtj0orvYgNtG7cYrpsFvX5hbN5FCIJq?=
 =?iso-8859-1?Q?/cNs4Pbwd3h5/JzQXwHv4BiJYmNhHgMx+hzFTcuH4n+TEBIcYGx1okuOBK?=
 =?iso-8859-1?Q?O2dipRX/c0Mgd+06k4Q8hvJmHj/cSJjE7EpDUVG8ra1K0m8Q+5yQ996ODR?=
 =?iso-8859-1?Q?oxSv9JVjqsB8nwegvLG6KpsPzVyFFtbRoHqYjLqkHexhJbkztEaSrI0LPP?=
 =?iso-8859-1?Q?RCLEwyEchykKgT/+UpTqpG+VyNQ0rv7VdxEjOHDwB3gH57+WpxdRMrma+b?=
 =?iso-8859-1?Q?mYKRYHMmAEm6qfcMGGmYm6n5h4XtfSdy9tY8ml5VwXQfeARTXLEAeVe0Hd?=
 =?iso-8859-1?Q?97ykUPIITyVeAymPKLNoJCyP58CljymZfIK4ghICo3fLuS4NdM3CpXo4gB?=
 =?iso-8859-1?Q?pLFi7OuEW3helq7bMuzKREywKSmY5/kUIfmVSNsem6ugdR9irjexTRA692?=
 =?iso-8859-1?Q?j0eKYiIocHvUkP8B8U0kTGU3+gBdvFmAqigeIeUrtSgFMzCfzsgi6/CBda?=
 =?iso-8859-1?Q?55Vja8EYImiTDVaHUzV1Mc6d2Y/13XQSuNW1KTN3SqRSv0DeBL6sSIwQ3s?=
 =?iso-8859-1?Q?d6KBkNDwEbeklG6LB1Qx7JY82mvtun4E8yXbpqwuPKykAeFNAb7NGs9MP8?=
 =?iso-8859-1?Q?9C0tdYxXxCjUIehqeVG1LyGcUT4kpat23A/mbKNdwaTaqjnpzBcbuYJk7h?=
 =?iso-8859-1?Q?OlXdSLP9YMz2K7KvsILnBFI9pwAhHkxB5wnGIQyiXffVqmd8QRyYlxUA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a02a75d-4484-4eac-eda0-08de164c004e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 18:01:20.9508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b01B+C9W5oqcdNKLyHaxdIhfVDK0qSw9Hj0jv0hifqZHYyoVn/5ducP6th//RMp0XglL2gs5K9F2UPgM7gVwEVqfBTeh5cg83V2dUwsS4Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10548
X-Proofpoint-GUID: iJXEv75E61YPFHTrc4bqqY0CwKJUAb5g
X-Authority-Analysis: v=2.4 cv=FJYWBuos c=1 sm=1 tr=0 ts=690104f4 cx=c_pps
 a=eErdSk/Sa828lcK029XJ5Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=64Cc0HZtAAAA:8 a=XT8gEEquJfDF-nft9kEA:9 a=wPNLvfGTeEIA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1MiBTYWx0ZWRfXwy9F7YXrPXKl
 vPMyd7CCeyz1tljJiC6p1viuhmux3PO3pNy440B8GQIvbOjLUE9/Yt6pe1GY1VJ1EtZlN9UFT8K
 l/DJFJQbBDLKOvaCKFAKz6lKEzfrOwLCyg96gfpmlu3rwM7bteFhwY0x73fVCLhlyEH8KepK4lP
 wxEOsJrIQwzpSoG/FZtWw8NsDasqhA2u7U/7mtTX7SUdYG7hoTy6TPWLrDZLOIkPh8l+eD9hGee
 YE1GNiHvErXHYcDOytL/euc6IPpqB+KQPizV7rq/z9gp7oQaWHcbFrK7fvIMGD/4LtZV5fG4HYx
 +UV0mZGcZ+PNq1t3mwZ2Nn31zT8v9UVovion33952RHPB5tOgxMEg4KZEdpFyzHGYG0ARohP5S+
 q4rL46gEOUIkasz+iTeXUJJfyzSFBQ==
X-Proofpoint-ORIG-GUID: iJXEv75E61YPFHTrc4bqqY0CwKJUAb5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The "Set LAN Configuration Parameters" IPMI command is added to the=0A=
`ipmi_bmc_sim` device to support dynamically setting fake LAN channel=0A=
configurations. With the fake LAN channel enabled, inside the guest OS,=0A=
tools such as `ipmitool` can be used to modify the configurations.=0A=
=0A=
Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>=0A=
---=0A=
 hw/ipmi/ipmi_bmc_sim.c      | 110 ++++++++++++++++++++++++++++++++++++=0A=
 tests/qtest/ipmi-kcs-test.c |  83 +++++++++++++++++++++++++++=0A=
 2 files changed, 193 insertions(+)=0A=
=0A=
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c=0A=
index 2ead46ee55..f4cea91fde 100644=0A=
--- a/hw/ipmi/ipmi_bmc_sim.c=0A=
+++ b/hw/ipmi/ipmi_bmc_sim.c=0A=
@@ -106,6 +106,7 @@=0A=
 =0A=
 #define IPMI_NETFN_TRANSPORT          0x0c=0A=
 =0A=
+#define IPMI_CMD_SET_LAN_CONFIG           0x01=0A=
 #define IPMI_CMD_GET_LAN_CONFIG           0x02=0A=
 =0A=
 =0A=
@@ -300,6 +301,7 @@ struct IPMIBmcSim {=0A=
     ((ibs)->lan.channel !=3D 0 && (ibs)->lan.channel =3D=3D (c))=0A=
 =0A=
 #define IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED    0x80=0A=
+#define IPMI_BMC_LAN_CFG_CC_PARAM_READONLY         0x82=0A=
 =0A=
 #define IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS        0x00=0A=
 #define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT      0x01=0A=
@@ -2131,6 +2133,113 @@ static inline bool is_valid_netmask(const uint8_t *=
netmask)=0A=
     return mask !=3D 0 && (inverted & (inverted + 1)) =3D=3D 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Request data (from cmd[2] on):=0A=
+ * bytes   meaning=0A=
+ *    1    [bits 3:0] channel number=0A=
+ *    2    parameter selector=0A=
+ * [3:N]   configuration parameter data (from cmd[4] on)=0A=
+ */=0A=
+static void set_lan_config(IPMIBmcSim *ibs,=0A=
+                           uint8_t *cmd, unsigned int cmd_len,=0A=
+                           RspBuffer *rsp)=0A=
+{=0A=
+    uint8_t channel;=0A=
+    uint8_t *param;  /* pointer to configuration parameter data */=0A=
+    unsigned int param_len;=0A=
+=0A=
+    if (ibs->lan.channel =3D=3D 0) {=0A=
+        /* LAN channel disabled. Fail as if this command were not defined.=
 */=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);=0A=
+        return;=0A=
+    }=0A=
+    if (cmd_len < 5) {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);=0A=
+        return;=0A=
+    }=0A=
+    channel =3D cmd[2] & 0xf;=0A=
+    param =3D cmd + 4;=0A=
+    param_len =3D cmd_len - 4;=0A=
+=0A=
+    if (!IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (cmd[3]) {=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR:=0A=
+        if (param_len < NBYTES_IP) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.ipaddr, param, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE:=0A=
+        if (param_len < 1) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        if (!IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(*param)) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+            return;=0A=
+        }=0A=
+        ibs->lan.ipsrc =3D *param;=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR:=0A=
+        if (param_len < NBYTES_MAC) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.macaddr.a, param, NBYTES_MAC);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK:=0A=
+        if (param_len < NBYTES_IP) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        if (!is_valid_netmask(param)) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.netmask, param, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR:=0A=
+        if (param_len < NBYTES_IP) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.defgw_ipaddr, param, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR:=0A=
+        if (param_len < NBYTES_MAC) {=0A=
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(ibs->lan.defgw_macaddr.a, param, NBYTES_MAC);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING:=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS:=0A=
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_READONLY);=0A=
+        return;=0A=
+=0A=
+    default:=0A=
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED)=
;=0A=
+        return;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Request data (from cmd[2] to cmd[5] inclusive):=0A=
  * bytes   meaning=0A=
@@ -2329,6 +2438,7 @@ static const IPMINetfn storage_netfn =3D {=0A=
 };=0A=
 =0A=
 static const IPMICmdHandler transport_cmds[] =3D {=0A=
+    [IPMI_CMD_SET_LAN_CONFIG] =3D { set_lan_config },=0A=
     [IPMI_CMD_GET_LAN_CONFIG] =3D { get_lan_config },=0A=
 };=0A=
 static const IPMINetfn transport_netfn =3D {=0A=
diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c=0A=
index d0a207477e..9bab0d84ad 100644=0A=
--- a/tests/qtest/ipmi-kcs-test.c=0A=
+++ b/tests/qtest/ipmi-kcs-test.c=0A=
@@ -318,6 +318,88 @@ static void test_kcs_lan_get(void)=0A=
 }=0A=
 =0A=
 =0A=
+/* set/get ip address: 192.0.2.2 */=0A=
+static uint8_t lan_set_ipaddr_cmd[] =3D { 0x30, 0x01, 0x01, 0x03,=0A=
+                                        0xc0, 0x00, 0x02, 0x02 };=0A=
+static uint8_t lan_set_ipaddr_rsp[] =3D { 0x34, 0x01, 0x00 };=0A=
+static uint8_t lan_get_ipaddr_cmd[] =3D { 0x30, 0x02, 0x01, 0x03, 0x00, 0x=
00 };=0A=
+static uint8_t lan_get_ipaddr_rsp[] =3D { 0x34, 0x02, 0x00, 0x11,=0A=
+                                        0xc0, 0x00, 0x02, 0x02 };=0A=
+/* set ip address source: static */=0A=
+static uint8_t lan_set_ipsrc_cmd[] =3D { 0x30, 0x01, 0x01, 0x04, 0x01 };=
=0A=
+static uint8_t lan_set_ipsrc_rsp[] =3D { 0x34, 0x01, 0x00 };=0A=
+=0A=
+/* set/get subnet mask: 255.255.255.0 */=0A=
+static uint8_t lan_set_netmask_cmd[] =3D { 0x30, 0x01, 0x01, 0x06,=0A=
+                                         0xff, 0xff, 0xff, 0x00 };=0A=
+static uint8_t lan_set_netmask_rsp[] =3D { 0x34, 0x01, 0x00 };=0A=
+static uint8_t lan_get_netmask_cmd[] =3D { 0x30, 0x02, 0x01, 0x06, 0x00, 0=
x00 };=0A=
+static uint8_t lan_get_netmask_rsp[] =3D { 0x34, 0x02, 0x00, 0x11,=0A=
+                                         0xff, 0xff, 0xff, 0x00 };=0A=
+=0A=
+/* set/get default gateway ip address: 192.0.2.1 */=0A=
+static uint8_t lan_set_defgw_ipaddr_cmd[] =3D { 0x30, 0x01, 0x01, 0x0c,=0A=
+                                              0xc0, 0x00, 0x02, 0x01 };=0A=
+static uint8_t lan_set_defgw_ipaddr_rsp[] =3D { 0x34, 0x01, 0x00 };=0A=
+static uint8_t lan_get_defgw_ipaddr_cmd[] =3D { 0x30, 0x02, 0x01, 0x0c,=0A=
+                                              0x00, 0x00 };=0A=
+static uint8_t lan_get_defgw_ipaddr_rsp[] =3D { 0x34, 0x02, 0x00, 0x11,=0A=
+                                              0xc0, 0x00, 0x02, 0x01 };=0A=
+=0A=
+/*=0A=
+ * Set and then get LAN configurations=0A=
+ */=0A=
+static void test_kcs_lan_set_get(void)=0A=
+{=0A=
+    uint8_t rsp[20];=0A=
+    unsigned int rsplen =3D 0;=0A=
+=0A=
+    /* set ip address */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_set_ipaddr_cmd, sizeof(lan_set_ipaddr_cmd), rsp, &rsplen);=
=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_set_ipaddr_rsp));=0A=
+    g_assert(memcmp(lan_set_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* get ip address */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_get_ipaddr_cmd, sizeof(lan_get_ipaddr_cmd), rsp, &rsplen);=
=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_get_ipaddr_rsp));=0A=
+    g_assert(memcmp(lan_get_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* set ip address source */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_set_ipsrc_cmd, sizeof(lan_set_ipsrc_cmd), rsp, &rsplen);=
=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_set_ipsrc_rsp));=0A=
+    g_assert(memcmp(lan_set_ipsrc_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* set subnet mask */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_set_netmask_cmd, sizeof(lan_set_netmask_cmd), rsp, &rsplen=
);=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_set_netmask_rsp));=0A=
+    g_assert(memcmp(lan_set_netmask_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* get subnet mask */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_get_netmask_cmd, sizeof(lan_get_netmask_cmd), rsp, &rsplen=
);=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_get_netmask_rsp));=0A=
+    g_assert(memcmp(lan_get_netmask_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* set default gateway ip address */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_set_defgw_ipaddr_cmd, sizeof(lan_set_defgw_ipaddr_cmd),=0A=
+            rsp, &rsplen);=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_set_defgw_ipaddr_rsp));=0A=
+    g_assert(memcmp(lan_set_defgw_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+=0A=
+    /* get default gateway ip address */=0A=
+    rsplen =3D sizeof(rsp);=0A=
+    kcs_cmd(lan_get_defgw_ipaddr_cmd, sizeof(lan_get_defgw_ipaddr_cmd),=0A=
+            rsp, &rsplen);=0A=
+    g_assert(rsplen =3D=3D sizeof(lan_get_defgw_ipaddr_rsp));=0A=
+    g_assert(memcmp(lan_get_defgw_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+}=0A=
+=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
     char *cmdline;=0A=
@@ -340,6 +422,7 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("/ipmi/local/kcs_channel_access", test_kcs_channel_acce=
ss);=0A=
     qtest_add_func("/ipmi/local/kcs_channel_info", test_kcs_channel_info);=
=0A=
     qtest_add_func("/ipmi/local/kcs_lan_get", test_kcs_lan_get);=0A=
+    qtest_add_func("/ipmi/local/kcs_lan_set_get", test_kcs_lan_set_get);=
=0A=
     ret =3D g_test_run();=0A=
     qtest_quit(global_qtest);=0A=
 =0A=
-- =0A=
2.43.7=0A=
=0A=

