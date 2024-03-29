Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A15CD1284
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 01:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq0gi-0004S5-Dj; Thu, 28 Mar 2024 21:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0gL-0004Lq-9A
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:05:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rq0gI-0003oV-VG
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:05:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42T0N681006811; Fri, 29 Mar 2024 01:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=75pD3tS7NCSJHhJK45gI8kPVU7ZcD1e22y53JWJExmw=; b=OJ
 Iv7dYhiYSpckV1qIKWjvdRpg6mBexVIehFNsoBaAPxyXLpCRbY2q3WJ4yGGYJ3Bf
 okosi+S0kdtH8B9ojB9Ef878hr3oxlpvuD8fe88GZc+chHYJdEc1RtLUhESn02TE
 fyXILc38iCxYWzYmsbJUPibEFKt96Jj2BTac7wVScKitzEgfuZpDX3HKfhZrME+m
 zvqMQB3IQ0QbXQKBgWkVZgVjerC3LgOzOFOW8wrOPlJFfOjiR7xY/djjHnlyb8fp
 upw/TluKPXIsEhbdk48c30tfT1K9v0LzbNbY6WpYBmysTSdC5g6JBhlwgTSX+ET3
 sQzVpg/LH0LJvmWbPzdQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5aquha5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 01:05:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e53kKyIo89LWO8knUD/E4ANiu9/HBioGqd516+iPShIsELVycVw7gXVAZHN+mBvFhONKbrXetXCTnhpuHYu7ZvC+enqqMgMdQ3Dz5ijCmm8Jd9RzQBxvSvCT5Gnllc0KRADveJ0JE4UXXfBTYPNEJ0WPIIxnSaF6xThUA7iLWim2b52vPp5kT/ZgFmLMsMGoWrsD/xOvAQtdma3XMxIUkh3WwIFbqMRQZ8bPh60JGx0VYdISayKKtAVjk+j09JXr2IoVUj51rkFoLzyIOkXrfzZSRqsE+f9pkHVb2d/g8V/v69SI+YLMyk7AXNR+rooC/A8qUZSfzksMuOSw6YVYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75pD3tS7NCSJHhJK45gI8kPVU7ZcD1e22y53JWJExmw=;
 b=mD3DnfN5y45g+f3VPrdqBlouyTWsKPHVgMEG1sn6Lcy/qJQjCW8poe7vSgNGBeJTpyBnV/QNxenkTsqPU//txDg+VEYWgs29WB9b0TDaWSQ38IcKXqPN+nDStNUp8m8c1bbtzLKwv3Xrd9BLUps49C3HtpUerHAXW+U+TpiwLIHkAxpf9AA6GsQH21fcRR/2pgjGav4T6kZPbtajnALqYpUdkIAbPNt6ETtfYqpo8ChqFKDJssoGx8XJV8MKZayLzoRypJyyh3VVZzyIkp7lju0xLnOiQ8jI2JG8mpGOfAyAUSaR2Pif2yudcVLVTShyqdrxu5D76DfQ2vbgnCTXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CO1PR02MB8490.namprd02.prod.outlook.com
 (2603:10b6:303:159::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:05:13 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:05:13 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 5/9] Hexagon (tests/tcg/hexagon) Test HVX .new read
 from high half of pair
Thread-Topic: [PATCH v2 5/9] Hexagon (tests/tcg/hexagon) Test HVX .new read
 from high half of pair
Thread-Index: AQHacD7aMPJLT4/pDkqfaouzXcvmy7FOCcdA
Date: Fri, 29 Mar 2024 01:05:13 +0000
Message-ID: <CH3PR02MB102472C4FA8A110890B705844B83A2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
 <20240307032327.4799-6-ltaylorsimpson@gmail.com>
In-Reply-To: <20240307032327.4799-6-ltaylorsimpson@gmail.com>
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
x-microsoft-antispam-message-info: qg8RMVaoQWoxJUurn029eCxh5KjESnKplBzFFse8GYxMK5phI2GQ6XQSehh5803IrUfIXYiPO83cg2M/WaoWWtmoLp5gmIJuyRWHLaEEHIowyBE+HW3gQXTpzqA6sx+Zgl4GydW96ab6GXcBL1AedVXNamzt3P39p5IYMAVgwTMYjTb16QVntlG7jY5hup02KBEfvWmgxqXiDIIXrsqZcOj0VOSADP3T+wwQRGN3LJrm6gGtu/ssfMIymEJxtWYl1M9Niw3eAThFFTRLTp4qCTNsyQ2h1AGwIqUWWZqzANV0Z/fqmwaQx9/95/FWZfHBUz94DlFr9ELRl4VfrlGWJwkTM+mK6d0auTAjI1AlQWPo6ZSVpawGepcxE1YHsVKg7+X/Lk1a/URI4OH9aZBwBd9p67Bho3AcevQfHWl3SezaLbcCZcd5XeyMGFYDPgAV0o3tc86rqNqxHMuJsdZDJtq/rhaqg4uJxzpnAfkIaLJ0U0XwwHkrVP+lbUvgRQwouN1YgVvS0lMm63KsSo4lnXL+go3YL/vR/LTvduWF/e1PtwcRchS4fd/xTcZEU30EUWii2S3Dgj0sJho/qwu3xfhtsQddwLJZlRIaW9bOz6Khq2F4Y9uHwJQe9ha1auy1MKrAyeKqfBk/bujW7TPa2sJbTV0LkSZzwBHU2O7Safg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUNMN1c2YlFPZlhIaVZMS2w3TG94cXEvK3hZOE5rMFRjRDdxMGI4VlI0aWFJ?=
 =?utf-8?B?S2xTMTVUTXdVUlNyUkQzWHVDb1Zlc2taSVRHd0xqTzJnRlFuaHRoRFQ0TFI2?=
 =?utf-8?B?VGpFTjNiNjVoSFZKNHNNWGhMSlBGbzRDUXlBSXpIOFBtVDVGMDJ2OXZpSWJ0?=
 =?utf-8?B?TDJFbTErVUNlZUxDb1N4NUxIbTdXOTJidXlQdVpTbHZUdkQrUEtzazFFRkZ5?=
 =?utf-8?B?dk83N2NIQmhnOE53aWpnNmxXZlVJa2o5S1pxS21BZC9HekpRbHltVUxzZlFV?=
 =?utf-8?B?NGxiT0NFOGpHS2hqVjVSRVpsN1FtU2piMW0wdExwQmN3OTNXZzlFNWpnT1B2?=
 =?utf-8?B?VFlUblozOU42VURKMURXVWxDc1l6bjd3YkVPenJrdGY2ek1mVjNUZUl4TkFu?=
 =?utf-8?B?RFRUV1hhYWFHRko5Sk1vN2xjbTI1bUZidk5Na2lKTEtxY0J1NXBFbzV0dENV?=
 =?utf-8?B?b3ErQjJSMUNIczhaN2VUQ3hKYkk2bGgrK0dYZHR3cS9UaEFteFRrVzVyUzUy?=
 =?utf-8?B?SElObFdlOEZzOFNDTWNqYytBU2ZiWTBEVndkSWVKVkc5cE1HK051UEhnWlVR?=
 =?utf-8?B?T3JMRkpGWWlLS1RDL2tzeVZZQVlRODFBRjdqaEpiKzcxSHhOOXRNWGp1TUFw?=
 =?utf-8?B?aVcxUERXc1RVRUxJSjNGL0NpTFJFNjdmc2U5b1dDVnpVRUNBMVNnMnJudFRL?=
 =?utf-8?B?cVFXQU1WRk5jUTc4bS9GdWp6UVlycXNkVXBHMWkwZnovV1AwVnYwT3UrYmh0?=
 =?utf-8?B?cFlObXNvSjhxZXRncTZoTm0rS3VsUVFWNDFUZzJMWkRMR1FhQXlWRUhTaHhM?=
 =?utf-8?B?OHUwZEpSR2FnLytuMGZad2RNdU50QzRzdGdBQ1NvR2liZEt3T25iT2lva01U?=
 =?utf-8?B?WElZQldHRHJCREsvZzQ3c0NiNkk5RU1tTWE2MlcxQWFMMFJ3amlxbm1vTkhW?=
 =?utf-8?B?dnRUTTdxNWJGVEZqOXUva3RJNUorRmxmUENGa3dhTkIxb25Wd3d5dTVYOU9O?=
 =?utf-8?B?ODV0VmFsR2JEeXlzMDQvbW9sc0tuMFZ1Nm9YQXRVb3RuTko3aGtMbDR1YVgy?=
 =?utf-8?B?Y2dlMVBHS0kzSWFpZDEyZ1B4RXRtaDdkM1J6dzF2NmdhQWV1ME1aVUlUbDJG?=
 =?utf-8?B?MFVyWGw5NVpXbk5oeGg0c0lHOEhqNHVoUFFuOXZ5NktVeGJWNVlveUNOcWpE?=
 =?utf-8?B?S1NXQWhkY1JoM1ZOOFFWRlA4Qlg3dzRKbzVNRlFiZm1kWVE0U0Z1QllPZFYz?=
 =?utf-8?B?RG9wby9mRlpQeGs0N0tzSFB6ZGtzS0tOODdpK29oeHlPaVJwK20rTHE0TzhP?=
 =?utf-8?B?WjJtMkt0dHhZWkducks0TUs2QSt4cVQzejFqOXFMUXRjK0dtQWNqU0plbGZE?=
 =?utf-8?B?ZTlwWEJZSDJkRng5QU1PMHB0M0I0d0VLOHFzZmdSclV0RExBL3FxRDBrQmFL?=
 =?utf-8?B?Tm9jTysvR1hTS1RSY1pzemxLbVVDYkM0ZE1MR1NUYk5aYlFzNG5haXNqK3NY?=
 =?utf-8?B?TWtzZmQyeUFpMkxoNEhoVStHT2lMV2VYQ2pKOVh2cE00Q3VURm1xalFINmts?=
 =?utf-8?B?aU1LWXRLbXN3bFA0dmlpRjVZVGNiMnBDcTM5Q1F5V3pTcnFTTEpXOXdjQmsy?=
 =?utf-8?B?bnhIaFdJQk92aTJnbEhlNjZlUkVGSTBrbWhWeHZlNUxEWFoyOXlUcEowaFFo?=
 =?utf-8?B?MEEvR0QrOXMvM1l0Y1FKMVV4Smd4bGk2dUVKZEQvU2JrdzV2TngrZktWbWpO?=
 =?utf-8?B?Q2NhMUI0U29aekd6N0s3ZHl3SUZMbjcvVWZ2ZG5DY0d4L0NqOHFSeG5mTjFI?=
 =?utf-8?B?VldlRkZ5dUFpNmhnOGYrMU4zUi8zdVpPaWRnMWJtWmJBcDB4YldVcWJld2J1?=
 =?utf-8?B?WFltUHdSWmlCT1R0cXJBekxjbUlLOFhHc0FrVmMybW1Ka0JScDc0YlBJcXlP?=
 =?utf-8?B?SHQ1MjBvaUUrUDhSQ0gvYlhtYTFWM21sb2VuNVY5TzFMTk0yU3JlUm1tUTFH?=
 =?utf-8?B?ajRlUjhDNkdUMW9ZYVFPR00vMmZBYVpGZVU3aEhQM0lNUDNzekVPaFR4Q0Ey?=
 =?utf-8?B?VnFzeTRPT1ArSnRhbmRNTXIzOUdhS0tWaDFSWjJ5Yi9xYmEvaTZLNFVxNkdq?=
 =?utf-8?B?YzlNbjcxZmtWVnYvOHUxSjBxc0dCNldWd1lpakVKd2lNVURZMEdVMnhNT3Bn?=
 =?utf-8?Q?F8/L/g1i8/VguWYclKMJ3vSj+mfPuUWWHuKfZvDUs+qc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1YXIoidDY3Y9CMSvtHv4NRKkOV6b6Wme+qjlOnx3oFEPrM42V0YY2EtDeqS+dzQAi/h/tBoqA0krfsA76FzrwCqtUiVCAmmLupqQa/Lc/TMFMVPUE9s8pQns7dn6vWXihqkGrA7Gu3ROTZKuazvSMeHKkCJM+oDIaOign+wyXY4QzGzEqemM3oIRXAiTioL7VXfkP+CII97qajjkvCK/yWqPIPXLDU8NA0QdiFoHTlDRByr/UHzlXg1/YyOMUORwjBZb3GqnzkKc4rGDooQq4rZ2U/fkop1giB7crfVegBeT1IBtDIji71Hbg5udVNR1IPtV1thFwEVL5vQMxUMEA/jVAa23iPx4vPo49HcujUKGqmZXXF4uDeNe8929NZ5o00DgetkByC3QgH4Ct3Ii9CgGZRWXbd2ZXfZQVuNrN1ywHLR8OT27jQjmcVpnc73OBQO6dNGOFclbw1WydxqfoWVxuLwx+h5lfUDRbn0h5xGI4tsM5wtU1Z4B19XgDDDd8Nu8ENcB9e0vkANNmofzsT7DsPjcrlb5NirjvaGD6EK1g9iA9MXlRpy5IXVfrBzJphEZ5mY6MePU4MlMa22PdYOXxajHxDgEhObPLq+Bq0iki82W9JjJ5cKF8VY8RoqB
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a70f33-46d8-4197-0b60-08dc4f8c49ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 01:05:13.4929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDaRlZyplk1ohjB6NeujWC6ahQglXtlK89gsmxFJcyUokrGYSi0MppR81I4MZ76KuB76Zw/jr+/zdffAGxteAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8490
X-Proofpoint-ORIG-GUID: RWN4PtuhmGdChAOPpAUBJI5-Xa_sSCot
X-Proofpoint-GUID: RWN4PtuhmGdChAOPpAUBJI5-Xa_sSCot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=792
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290008
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
UEFUQ0ggdjIgNS85XSBIZXhhZ29uICh0ZXN0cy90Y2cvaGV4YWdvbikgVGVzdCBIVlggLm5ldyBy
ZWFkDQo+IGZyb20gaGlnaCBoYWxmIG9mIHBhaXINCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwg
b3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5DQo+IG9m
IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiAN
Cj4gTWFrZSBzdXJlIHRoZSBkZWNvZGluZyBvZiBIVlggLm5ldyBpcyBjb3JyZWN0bHkgaGFuZGxp
bmcgdGhpcyBjYXNlDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxv
cnNpbXBzb25AZ21haWwuY29tPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJj
YWluQHF1aWNpbmMuY29tPg0KDQo+ICB0ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIHwgMTYg
KysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlz
Yy5jIGIvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYw0KPiBpbmRleCBiNDUxNzBhY2QxLi4x
ZmUxNGI1MTU4IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jDQo+
ICsrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMNCj4gQEAgLTEsNSArMSw1IEBADQo+
ICAvKg0KPiAtICogIENvcHlyaWdodChjKSAyMDIxLTIwMjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBD
ZW50ZXIsIEluYy4gQWxsIFJpZ2h0cw0KPiBSZXNlcnZlZC4NCj4gKyAqICBDb3B5cmlnaHQoYykg
MjAyMS0yMDI0IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMNCj4g
UmVzZXJ2ZWQuDQo+ICAgKg0KPiAgICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5
b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+ICAgKiAgaXQgdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkN
Cj4gQEAgLTIzMSw2ICsyMzEsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X21hc2tlZF9zdG9yZShib29s
IGludmVydCkNCj4gIHN0YXRpYyB2b2lkIHRlc3RfbmV3X3ZhbHVlX3N0b3JlKHZvaWQpDQo+ICB7
DQo+ICAgICAgdm9pZCAqcDAgPSBidWZmZXIwOw0KPiArICAgIHZvaWQgKnAxID0gYnVmZmVyMTsN
Cj4gICAgICB2b2lkICpwb3V0ID0gb3V0cHV0Ow0KPiANCj4gICAgICBhc20oIntcblx0Ig0KPiBA
QCAtMjQyLDYgKzI0MywxOSBAQCBzdGF0aWMgdm9pZCB0ZXN0X25ld192YWx1ZV9zdG9yZSh2b2lk
KQ0KPiAgICAgIGV4cGVjdFswXSA9IGJ1ZmZlcjBbMF07DQo+IA0KPiAgICAgIGNoZWNrX291dHB1
dF93KF9fTElORV9fLCAxKTsNCj4gKw0KPiArICAgIC8qIFRlc3QgdGhlIC5uZXcgcmVhZCBmcm9t
IHRoZSBoaWdoIGhhbGYgb2YgYSBwYWlyICovDQo+ICsgICAgYXNtKCJ2NyA9IHZtZW0oJTAgKyAj
MClcblx0Ig0KPiArICAgICAgICAidjEyID0gdm1lbSglMSArICMwKVxuXHQiDQo+ICsgICAgICAg
ICJ7XG5cdCINCj4gKyAgICAgICAgIiAgICB2NTo0ID0gdmNvbWJpbmUodjEyLCB2Nylcblx0Ig0K
PiArICAgICAgICAiICAgIHZtZW0oJTIgKyAjMCkgPSB2NS5uZXdcblx0Ig0KPiArICAgICAgICAi
fVxuXHQiDQo+ICsgICAgICAgIDogOiAiciIocDApLCAiciIocDEpLCAiciIocG91dCkgOiAidjQi
LCAidjUiLCAidjciLCAidjEyIiwgIm1lbW9yeSIpOw0KPiArDQo+ICsgICAgZXhwZWN0WzBdID0g
YnVmZmVyMVswXTsNCj4gKw0KPiArICAgIGNoZWNrX291dHB1dF93KF9fTElORV9fLCAxKTsNCj4g
IH0NCj4gDQo+ICBzdGF0aWMgdm9pZCB0ZXN0X21heF90ZW1wcygpDQo+IC0tDQo+IDIuMzQuMQ0K
DQo=

