Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF9BC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCxh-0005nS-LR; Fri, 24 Jul 2026 06:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wnCxT-0005mm-Ji; Fri, 24 Jul 2026 06:16:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wnCxR-0000Zb-5K; Fri, 24 Jul 2026 06:16:47 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OAGEwN4075569; Fri, 24 Jul 2026 03:16:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LLtdJOPLptWcogFddwC6sZEctGYAMbIs07A1PfOeh
 iU=; b=nr5ZyA1goNsAbeaubhq75mdU8dZKqLQc+9VI1OOusg3XULuvBypfCVRd0
 MN96JIBxuiWpe275u+KuPove52/bvilmQ1LLsdI40dr7YbFRLR4jkbVw5Rexbnbt
 Ss6YOjac6iZg8ZOiRkbf8ONm6ptI796w8q1die5TqO1whoE7RX5AWxoKmpTFyLfc
 jW++UwekiO5MRsu0oDqM9fh9V7/aROQ/ne7EyNG4XVfHOgzknRAx/9EmrXet/DDX
 MbplUI5JLoKY0LSzT35is/K+yGqr2N1cLrZrDNXxI92+iLLZr6XLKiTT6UJqThZC
 LrPBfOXH1MCyXI3IhIp/O7hmbT1vg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021077.outbound.protection.outlook.com
 [40.93.194.77])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fm5dgr2wm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNQVHxHI9S12pfMWiSvImGPr2XGbW2jFl8ehwEL7osp0qmUCxTNslcewu/vnwzzpQfPI0SDs0DqrAz+Qfwv8JJf3XDUeOz45OsxfbHnduZI/sjIiXXgC2mszPnq1usRI1WGAHWVmVhrAwJV6XaB5pSUPWTT5IGcRXDY+Yhyy+XR6tDyn3D0z+JhcANsR/A2YDayRamEVzdg6ZKrFlcwHctikNSBZBmI1pyqTQ93TOJw+15EZmfbKF7gTnfP17x9UjIYxTRVtmS76iYxOfGXWkDBlnr93CyHOD97Sgws50bmYGvNoo6VWidUIrHbkZ3toGQo3+krBnJD9COGVi9ijdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLtdJOPLptWcogFddwC6sZEctGYAMbIs07A1PfOehiU=;
 b=Kp4rE6JodQiJLtcXJ+QKNhXRulcn7kRCGn/VdUyBhCkJuSRMWqHe6I55AmL7GQD4x/zPuz31dhidXDncdXBe5PG+6/O+2M0GKXxYVWa2mj6le0w3fA9Koet3qD4ccNRXHnLFui9EQXesbzJ4oJLiES0+pgCIDP18GpCfIcMZLoqfG+ggpMD5smauEvs07FjGDNfc+HCVcLrO6oyAWYzf3JlPDSQXNlZf/16sb02cgz7Dh6t+HDARLllcCRe4F1hrKfTE7j4GEe7uQKs1ifXUZxEULbYWMKAdFUqlEeye5rO5Cxh2WDbrxVCveDxNmhAUA5gRIBKi1pFyQ+5tWxSFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLtdJOPLptWcogFddwC6sZEctGYAMbIs07A1PfOehiU=;
 b=OfG6mIgsQDxznM2lqbMy9MshHFTF3UFCUlB7w9ZAXuRRnOQ/C54GhnuU5G95oeksGrZp/uTwmwdYP4kQtlie9WYnAHFvkBKpVGmDmeyMb9Ib45+zWrebMfeE3JlyKT9quiCdhh2nhJN4yxpGjuYWKImCyxrTwt6GQ5FB6fdh24n9KZFquT6ZXSeqjEwIYRORtXP38Ti703JSEVG99PS88IKopXey+NBlvWVQ99M1G3ZgLP+lMIOl1TFPy6BzciSd7DuMuFPiUOvqORUb3ZzZhRpr2txUOMg2IFl15fn8PjMTwUoRGNNxRUH0KLDJ6oYR7wK6vFhdhImI6Go8Ms+O0A==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by SN4PR0201MB8839.namprd02.prod.outlook.com (2603:10b6:806:206::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 10:16:37 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 10:16:37 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 QEMU Stable <qemu-stable@nongnu.org>
Subject: RE: [PATCH v2 0/6] vfio-user: validate server responses
Thread-Topic: [PATCH v2 0/6] vfio-user: validate server responses
Thread-Index: AQHdGE/cu9eFH+JTE0yfU+CZbQ8hRbZ8Yn4AgAAX1iA=
Date: Fri, 24 Jul 2026 10:16:37 +0000
Message-ID: <IA0PR02MB946261BEEA581D44C5E4FB7F8BCF2@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <5828b987-9b58-4f44-b942-322399b99c6a@tls.msk.ru>
In-Reply-To: <5828b987-9b58-4f44-b942-322399b99c6a@tls.msk.ru>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|SN4PR0201MB8839:EE_
x-ms-office365-filtering-correlation-id: 49c0019d-7d1c-4f6b-a821-08dee96ca5a0
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: WZDNu+XWilHf9+JDThVBc4IPlDyk93s/ur+GrYpHMfzX6WUR+dViGT4iZJPeECkpvzb9UdSERKHYeivFyrpOCKHZVRnXMtieyjaZBUbTn5fnfCIVmLL9oadC28L3i20SJ2jIeo9znacJKy/basDvWgiWb9jCtVsT3/mmzdmjsHtErT0+TBRs9XS69/P/padGZ4gmiscWvuWYbuInlFAj1X7SrGhQ9fEeyO5G3YMzUGEttQRWNBhwqVQ9in/l5qQTHoI3BqN7DBQcpYFZLDr9+bpvMDpsxvaUgWM4q45hRLxSNcbfE/hyBgR8Ru5s/OwBMkedtGdvPDLdJ93CMth5kn7qNnt8VTca9N7yikHldsiFFPUpXi6ImTP193YInNpUG7mZ3181Ie+DnBr7raos/w7Waz6IW9g8oKAgPZ8yUWhkgRbCnkooXazQgQCQwqPoPdgVHX2uPE3f9C+4ymQ52YnQJ/Ms4GBBpsFQD0DxpNUDYnA27nRl/1CvR/9/9zMVN4DTzTX7EsGAKUoRvEHuJpvvnReGaW4B2+InxAd8gBriWxiUp3NV8S2430rw8J3BYLBk9W7qVT3jEzXMyaQBc6+aB5u1IMyFp1t2IfPLbxFTS3expfnwScHk90EyV5ZTEdJxN4Gw0k9Zaed5ND8Sq4asAB9S+vRGB0mC/awMN5ruDQcZfuEPTiQdPbJhvGUClNAXwqmaegdFz/IHL2ghCGSYJtpS0a9TbFtWWtJrZ24=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmJOV0dOMjNiaGxHQVBlbEF2OEp2Yjk3M0xuampxUnhkSkQ5anYrSmhjN0ZC?=
 =?utf-8?B?MmlZdVhTSmxORjcyVVFRaUZjOGRmZmJVdUgrQUJBUU85V1RuaTQ2UlFZNWRJ?=
 =?utf-8?B?Mk1UWEtDZGhIa1IrYkJReFo3eWV6TjZSdjJhTGxUQTZ4OTFCdnNoU3hRWU9r?=
 =?utf-8?B?MHpvN0tTWllLSk1xdkhzVllMRGd4TzRIYWhtY0NSZE5uOVJtVnFIbnlMeDUr?=
 =?utf-8?B?UEhTaXBkR0lCekJ4dXljQ0dubG9mc1dtMU44NnYvTUNQRmJiYVova0hYeXpj?=
 =?utf-8?B?NEZpYmhOZGpLOUllY29RWE80UzR4dmJ6QTFubjlSb1g5aWlZWEpWOERQRURl?=
 =?utf-8?B?WWpudnBSazJDT3o4dmR3MjVZQ09TblE2b3J4dHpGVlZTL04yM0JFLzJSZXpB?=
 =?utf-8?B?QmhYbHRlelpMMWphSC8reDZwSjlQODdRdVYrdlF5bnFGOVk1NDdTWGQrUGVF?=
 =?utf-8?B?bzNJTXAveEE1WGxDOVh2Z3F4bEZPUGV4R2lZR243ckVBREZYbGlBWkhpcEdJ?=
 =?utf-8?B?U0Y2Q1FPYjYvOVhFVVVoQStrL3ZOZHo5b1kvRmV2Z1NVTTE3TkJ0S0U1anpv?=
 =?utf-8?B?b3RTL3l2YWdwZWdybHFLQTN0cmU2dFBhSmxMOHQzNk9oK01kNGxJTm9BZExS?=
 =?utf-8?B?RlVWN21SRm9abVd2eHJUOEpqWWQzRlBkSGV6a0h4RE45a01FQVY5US9wZmFu?=
 =?utf-8?B?VmJnQ29WVzk4b3cxekN0c1Ywd2JhMnk1RDRkQU0yVm1xTDdiQm5CZ1JOU3F4?=
 =?utf-8?B?WjRldjhTSTh3RytJUGl3Q0g4VG1WeDNkY3o3MTNqVUtBOU9TVHU0WGNHN2Ux?=
 =?utf-8?B?bmQ2Q1ROSkxzV0RFdVlKTlEvR2tDS1lHdm5uckxaTElnYkRLOFM2amF6MlZi?=
 =?utf-8?B?eVZOVkNvdE5HejFwRUpxaWhxQUtQZllpMHFDQzkvRmNUU0E2bEVXV0xVaU5z?=
 =?utf-8?B?VnFJWldhRUlidkU5Qks2citkdTlvd3crUzhBaFhhNUhuS3ByNWNjdHRId0dn?=
 =?utf-8?B?UEFsRnVwQjVWSEQyenFrekphUjV2QjZjYy9HVXoyT1N0bmhGUHozT1U3dmFW?=
 =?utf-8?B?STlNcXJkV0JMK1hzVGNOK21peWYvM3NLSEljczNqWWJsdkhZOHdTN1hidXZ1?=
 =?utf-8?B?bVB2R01DZlpPRzZ3WXkyVSt3NDFwZTVDODh0b2RucmNiY2tMVms0Wk9jMCtC?=
 =?utf-8?B?S0s2bUNUa01vNHFNUmtvVmhic3ZPV05COXVWdFJVN2RIUWF3d0FiRnV2SUQ1?=
 =?utf-8?B?NnBkMU9oazg4Sjc2ME1GeFJOVUNtbGlaU3ExYVl6KzlJUC9ZUkZweE5RaVI5?=
 =?utf-8?B?Y3c0cFNIWUdSaHdkZnM0UmlrS2ZLUW1VT0dWcnRra25Sajg0UzJHUnRyREdJ?=
 =?utf-8?B?ZjlLNUtlVTZKNy9VVXhCZ2lVTGp4MnlVWE5QdXU5LzhFQ25HMHJvbVRUYStk?=
 =?utf-8?B?UVB4RTRZa0ZBRldkdDc0aFZQcGNrMFRlT2N2cHRsaUc5dEp0UkhvK2g0V3kz?=
 =?utf-8?B?T0kvbmFqZ0E1blhtYU1OWUJmeVRYVm45OGVCaFp1eFdDZEdJWTk1YW1RSUVn?=
 =?utf-8?B?eUpHSm5kdUFyeEUyaU9vdzgyZFNXSkUzQUVybll5TlFSM29LYnVROFdtbUlL?=
 =?utf-8?B?NHZEV09CMzN5UEttQS9DamVqeG1QdGNOdVlleGpMR2RQTUphcDJBVHNabndX?=
 =?utf-8?B?enVFcjltYllOK3NCYlpzSjBiYm9rQVl0RVdud0NUUFQzVm1xNzJodHhoOXdk?=
 =?utf-8?B?Q1pteklWS3BGU1lmMVhmU3NvdUpQU3lHaHVlVVp4R1NXMit4bHBMSUpBYlBJ?=
 =?utf-8?B?SXVrbmhtd3pia0R1LzZKdlJSaWMyOEMwZVA2K08wM2xpdStlRUQ1VHRUdHl5?=
 =?utf-8?B?L1JBd2xGeDNVa01wZWs4WmdQc0FCby9jNFpJNVkvUTJWNmhDOG10UTdvMnJI?=
 =?utf-8?B?VXdqd2pvSm5WR200djNValVCK3J5b2tpRXAvZU9PdFlpcU9vVm8vdkV0SzZi?=
 =?utf-8?B?a0R0a2tQZHVZT1ZjcTVJOG4rMUdwZFJBb1VEc3hFcWgwTWFSU1NNdzdMQWtC?=
 =?utf-8?B?QWFyMjhtSHZ1MXdtS3Bza1I5VHdNUkpBMDh1ZmJUWVlQUTRDM2lUMGo5T1VP?=
 =?utf-8?B?cG5PUGpyLytMQ2FuaDFvbmhuSUdOU1dFNmVkek1JeXprMytyMm1PdS9PaHpZ?=
 =?utf-8?B?VUhNaC81a2g1bXhNUW9PWkxrMlhqR202L3FNTXJpRGZtb284Qm94aldGcG1t?=
 =?utf-8?B?TGx3OXlSSkd2N0xHSlZMN1VsNnFsSUVyVW1ieDVBNnZaWkIxWlcrN2NpMytx?=
 =?utf-8?B?SzBwdGFoS0xSczJVcXg5VHB6TFV0TjIyYVFZTHhWekI3eVhrVit1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SuDmDAY7NisXIDwu0Y87T1v+0SZcX52KGpdxth9zgRwNMgqgK0PiIAzMHVn76Jcxq2whA70+W0M+TMopVh4FvHCDBYl9sh9Aimq4HIgV4kb0JtWUYGG5GCU6wOFEJYa4VC3T62reIMeF2AQrDbs3h7HUu6Agi9QBcFbHIIkuQA+XeWSaPU4fsHaUGrcKKrURVaMrARCT3lDTs4XRA2H5XO/yJScTdRB9Agj7p5x+b11AIkEsJrYCa9T/0NnrKRkKlC6Xd3ddQfX9G39xZ2IeTSH8iHPQrJhKnmJzgmNQsXlJAqN5BpCWhjlieGh1ic0VVR86totDnrFEKwLZ4gRa2w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c0019d-7d1c-4f6b-a821-08dee96ca5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 10:16:37.7282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIQx8RfjBw2dWje0G8lqfvkg8LZVZtV5P4ayjj9MW3WgONv1QfQMdniP8QYhxx2liEJzt51PVhj+u+E0v6GMQsSR3WebZTf/ViaoGaAmt30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8839
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfXw8OUf3dnLebp
 8IKB0Z5tw8ibt05AtZpUqZghi9T/EZmJDitHFxyHAul5AG3QmlH8uA+XEAjkYZkJzHe/1Fk7/w1
 pMceKsmTUB6odugAoqduGUttcgdWnI4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfXxijpF2qOYn/0
 vaneVspEXmxrw3eycptcuKpn+AskPnsbJN+LqJfCO1bJlDeVgHPe4NvDImQM1w7IsW5D3GHI+SQ
 OPQykp995X5VWmrIM6th5s+asQ4BddBv5ln8eIV7yikl/SYjdNPwF5HiwO3O4oo4Na8I/X5suHI
 RsRXMbTESQP5HHoEPD0zhPK+rAKyPZYJ5r5CzRdq7cbJtXSgyN+BmoZnQxXrUCfTpHNnoEsNrRI
 k0UMXTLLYKbCV2gqJoqy1A0hP/ojC8xsH/153efv0i4Ed+kzbnko/xqhEiBfrL+UoNtzLLlIdWZ
 A5HObJtRP59TVOrnfaRTuZIpjoqdhpoQpZuRzWxHxaWyQrBaefVHB3Bs/Oywm+uwro1IoEAFVrV
 q2bE7T2R77ituNsmK046fHjM2ZpveCcaaLhJ8OzRXe3S0MFVGN3OtJxauCmRg/TzOl8RvEGpqHF
 PUE1r+JJeDammxEnJcg==
X-Authority-Analysis: v=2.4 cv=YbWNIQRf c=1 sm=1 tr=0 ts=6a633b88 cx=c_pps
 a=bQgB5pj4NMiodnwxFn3P2A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=9qUTvQc-AAAA:8
 a=64Cc0HZtAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=gAL3cSrCvUDLzRm5ZpYA:9
 a=QEXdDO2ut3YA:10 a=axOgMmt4Ejcwn1cqzmsR:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: RahL61vOjR5a2tdiLABhtuZGcCzrFRj3
X-Proofpoint-ORIG-GUID: RahL61vOjR5a2tdiLABhtuZGcCzrFRj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFRva2FyZXYgPG1q
dEB0bHMubXNrLnJ1Pg0KPiBTZW50OiAyNCBKdWx5IDIwMjYgMDk6NTENCj4gVG86IFRoYW5vcyBN
YWthdG9zIDx0aGFub3MubWFrYXRvc0BudXRhbml4LmNvbT47IHFlbXUtDQo+IGRldmVsQG5vbmdu
dS5vcmcNCj4gQ2M6IEpvaG4gTGV2b24gPGpvaG4ubGV2b25AbnV0YW5peC5jb20+OyBjbGdAcmVk
aGF0LmNvbTsgUUVNVSBTdGFibGUNCj4gPHFlbXUtc3RhYmxlQG5vbmdudS5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgMC82XSB2ZmlvLXVzZXI6IHZhbGlkYXRlIHNlcnZlciByZXNwb25z
ZXMNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0K
PiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIDcvMjAvMjYgMTY6NTgsIFRoYW5vcyBNYWthdG9zIHdy
b3RlOg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIHNvbWUgYnVncyB3aGVyZSB0aGUgdmZp
by11c2VyIGNsaWVudCBkb2Vzbid0DQo+ID4gcHJvcGVybHkgdmFsaWRhdGUgaW5mb3JtYXRpb24g
cmV0dXJuZWQgYnkgdGhlIHZmaW8tdXNlciBzZXJ2ZXIuDQo+ID4NCj4gPiBUaGFub3MgTWFrYXRv
cyAoNik6DQo+ID4gICAgdmZpby11c2VyOiB2ZmlvX3VzZXJfZ2V0X3JlZ2lvbl9pbmZvOiBwcmV2
ZW50IGJ1ZmZlciBvdmVyZmxvdw0KPiA+ICAgIHZmaW8tdXNlcjogdmZpb191c2VyX2dldF9yZWdp
b25faW5mbzogcmVzcGVjdCBtYXhfeGZlcl9zaXplDQo+ID4gICAgdmZpby11c2VyOiB2ZmlvX3Vz
ZXJfZ2V0X3JlZ2lvbl9pbmZvOiByZWplY3QgdW5yZWFzb25hYmx5IHNob3J0IHN0cnVjdA0KPiA+
ICAgIHZmaW8tdXNlcjogdmZpb191c2VyX2dldF9yZWdpb25faW5mbzogcHJldmVudCBleGNlc3Np
dmUgbWFsbG9jDQo+ID4gICAgdmZpby11c2VyOiB2ZmlvX3VzZXJfZGV2aWNlX2lvX2dldF9yZWdp
b25faW5mbzogZml4IGNhcGFiaWxpdHkgY2hlY2sNCj4gPiAgICB2ZmlvLXVzZXI6IHZmaW9fdXNl
cl9kZXZpY2VfaW9fZGV2aWNlX2ZlYXR1cmU6IHByZXZlbnQgYnVmZmVyIG92ZXJmbG93DQo+ID4N
Cj4gPiAgIGh3L3ZmaW8tdXNlci9kZXZpY2UuYyB8IDQwDQo+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gSSdtIHBpY2tpbmcgdGhpcyBwYXRjaCBzZXQgZm9y
IHRoZSBzdGFibGUtMTEuMCBicmFuY2gsIGV4Y2VwdCBvZiB0aGUNCj4gbGFzdCBjaGFuZ2Ugd2hp
Y2ggZml4ZXMgYSBwcm9ibGVtIGludHJvZHVjZWQgYWZ0ZXIgdjExLjAuMC4NCj4gUGxlYXNlIGxl
dCBtZSBrbm93IGlmIEkgc2hvdWxkbid0Lg0KDQpTb3VuZHMgZ29vZCB0byBtZS4NCg0KPiANCj4g
VGhhbmtzLA0KPiANCj4gL21qdA0K

