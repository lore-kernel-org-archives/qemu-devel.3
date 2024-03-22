Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D05CC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnh4Y-00055u-Q2; Fri, 22 Mar 2024 11:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>)
 id 1rnh4V-00054Q-DV; Fri, 22 Mar 2024 11:44:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>)
 id 1rnh4Q-0002Bu-Dx; Fri, 22 Mar 2024 11:44:43 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42M4ncBm025004; Fri, 22 Mar 2024 15:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=LdDj+UkE1aKZro669099GiO5TV1cJjqqngsPgH1DEzI=; b=pF
 ehPJVsI3uNK4SOcTFkOSM3H1LYq/xSvABedmbX59RyeWVTmI34tVmVOtlCNpFN+o
 eJDIZqqa6UFaDmCvZ/BAR62lkEmnbyxoSBai6eY9defHpfmGv0PNehJyFO5ZmNXX
 3Qp7gwkQCqlTWMMCUpOKA5MR97TDX/S1BQ8mFcZVjTDk8+yUdF8VBon/mtdWYiAS
 wORefqt7tcGuIxtYhnTeu03VZCCzTSSQBKNt5rBhwHafUZ0O98PK3WPj/1g8sxTM
 5n3oEgiQdl4oI72sRPeipTZ2XZl0wBUEDdXFRJ3YYdA69Di24TS2zkip2cullrRH
 gdDyt26HE/pvIwok9udg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0wy8tk0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Mar 2024 15:44:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVHSKkoVzGBKvO/uh6QrA1CFi9HxAvutT7uPDhp9rf0XlPnuVOri1Hjw0z/mc6k5dfawrFJjNKD2JiRveiuOZ6hII3NszGXZ0qTydkUEZ70ZOqLpjHhi1CzQVx77uw5yfbgIKEV6/wfvmNKXZa0cBTKje/h5fobxIDUq4EJsdrQJJPmowBYHrozVHiyXuzNMm09+guSZ5daIEoCHO3uqNu2Bdo5XJ4dTizWuVvGZ1NLOk5NE/UJoSpYTReYb+w9UIkXZ+9vhKkbx7uq+nh7cY2zP9lLxCnUY5LBBJHUoQB7Un2Ube/YGt5gkNrqEhTwSfZw5veXj3eQufjvXFcUWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdDj+UkE1aKZro669099GiO5TV1cJjqqngsPgH1DEzI=;
 b=az3CGJQ+LiHZN5lOWACYSTg6kolW3bFTe4BxIXou1JEtWmWk0CNmaWP/C74Le68Pp7j5+AjJYiLo7QeiFbDT/uIaBo3WE3fA40p6pg1IQV329/QdY6JtV6Fswx4qD3X9CF91fx3dJjGbR06ED+Ih9XmerU4YfoPigic2nBG83uDaoc7jXaYnRmn9QYrg7bLgDqnmidNzsoHrU9vLB83cm3zjpxKfGw/+30LesmTqABhy/gGNNHMYgWg4l4E4sbtLABX45GmIcMVQjjPy8zI65bPRGuv0uEAaL/NSVIaxi1ZZaNUrRnQEmQPURMVzg/x2Skqiw2riWS59R/0mxt6fJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by BY5PR02MB6980.namprd02.prod.outlook.com
 (2603:10b6:a03:235::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 15:44:03 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 15:44:03 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, Anton Johansson <anjo@rev.ng>
Subject: RE: [PATCH-for-9.1 08/27] target/hexagon: Convert to
 TCGCPUOps::get_cpu_state()
Thread-Topic: [PATCH-for-9.1 08/27] target/hexagon: Convert to
 TCGCPUOps::get_cpu_state()
Thread-Index: AQHaehRAH1YjJtgDrk69xGiT8CBoeLFD604A
Date: Fri, 22 Mar 2024 15:44:03 +0000
Message-ID: <CH3PR02MB10247BD8329D17B82404C3E25B8312@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240319154258.71206-1-philmd@linaro.org>
 <20240319154258.71206-9-philmd@linaro.org>
In-Reply-To: <20240319154258.71206-9-philmd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|BY5PR02MB6980:EE_
x-ms-office365-filtering-correlation-id: e0dde0bf-296d-4ac4-910c-08dc4a86e688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSqM0KtFC9uiF5pA1YFJJnSJn9nD0OWmUWnhBWYiRudf9y3g5jmWL3DjWS8iSKaHEf4bLY282Y94IkUZNS4+H1hfUkfnEvU9hd6C+j5DME+cSBsDIrk+PV1518T+MhfRCXBswaA3dLQnOfmucrjZuEpJybswXOdgR6vwtw0mQWvZeyB4+f81xzaEBBOdp884BB4mV7x0eKo/zOkOU/IZMQ91c3Zt3qob8Oqh4ak69yYmvrKAwWJSwBcm0Xef+NGzyzllIJF08Ks4ar9hjZXBZGGTJK/ByTOTAoI0ZWP73zk8MGpyQrzeh7JYYkWfVI8DXwZqLbYt9TDAkQ9mKzXs+5WL+XF4zVwFzU/fjATrlUi+hUAu2MxHLjbE8l1WlgrqyotZxYgRaw5GlydIpljXl3EorAKBZHF0cAzcZampXMSrLQrFANmWyxAgSskCEvIaTiUkrFPFqJA+a75MLUGjx/me57AJgeU2HQqwJYpMIMWcmnD46sQlh9ysjS2qomRs1/47azbaV0SRj0547Neoo08Xp+5GCct8T9MO7ZPthBEJL5iexLHrbfn/gPVTHV4alQII84i5p5oR9OciqNDYXJ7NPbzs86FMTuUYx/znvr32fDTYfHrMTygB84S3o4QXR08q5Z6kDQDKYzF+bsvFRlbe5Na5Hv5HWpyQS2uYXVv/9xnSp7UPkz7jdX7zZPhio/q/C9Q0gBi/llnI8vTCkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR02MB10247.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGxkdmNuV0VBZ2JQa3BWUmMvMmZVbU9NVzlEQnFKcjNmN0J3YU5nMXZZdy9F?=
 =?utf-8?B?S2RMK3oxeG9WeG9lQk9nT0gvV2ZUZ1dKVTlSdC9LdkptdGJENDE4cnVPQmVE?=
 =?utf-8?B?aFJGNnFoR2Y3WVJyc2RVRDB1MzN2blp0RWlxYkFEd2JqalBzZ0dRcW5zL2lZ?=
 =?utf-8?B?MWljbkY3REIwQ2JMWldUVyt0aFNaYUR6bStBUGh2UDlTT0NSaGlnV3grS0FF?=
 =?utf-8?B?VndPTWsveVFhVjBHSDdzQTZId3piQVMzUDUySmtQSW1zWWliQmFiL3RTbmtv?=
 =?utf-8?B?Um52dVNnOXlXN0I0aTdaMzBnMFhqTTcxN0lySXlSVmJ2K2NMc3FZbWdxbWU0?=
 =?utf-8?B?TWdmYWhBb0taNjkrcjIvdGh3ZERRNGh6QUJYb014c3l5YXZkd1NSZWMzdGhW?=
 =?utf-8?B?S1F3cjhhbUxFV21jSW1tenNVZ0hMSldMMll0cHE0VWU2M2tZRXUycU5ia3BC?=
 =?utf-8?B?VGprVmJENDRFaEdQcCsvM3ZJWDVlMjNQdi9NajR0Wk93SktrcVEzenZZN0VH?=
 =?utf-8?B?WTd4ZUdqMkdqWGJGK3cyTTllZHpKQmJlMW9ldFdZbURoUjd3SUNpU1BxMmUv?=
 =?utf-8?B?QTZkU05LR1VTZVRESTJaZzQ5RTM3cTJGRXBCd1hXakpmR2t4eGI0NngydzJ2?=
 =?utf-8?B?ZzBZeXhoTkg0bUY4YUVpV3Bhb0VjR01nSWhXcldVRnVBNFYvVVZxVEVHdnI0?=
 =?utf-8?B?VUhZZndKanFRdW5lN0hJd0xhSVFPRk1sTVQyTXJoaWtwMFg5VDFEMUhwdTZl?=
 =?utf-8?B?ZVdDWENydkY4TVJUUVM0YWc0b05qZkl6WUpWM0ZPZXBCU3FGejVWTmhVY2JK?=
 =?utf-8?B?em92enFpamRiT2VEeGF4S1V5aVU1RW5QdTlCMk9BS3A5RU4zL0ZTRFFJZUs0?=
 =?utf-8?B?elp1VncrcFNsRXRoSlc1a0hWZW5hekJoazBNUFNGZkxMQ2RmV3YrcUVDRHA1?=
 =?utf-8?B?TXhCcjR1eFlTdXpZazh5cTdWRjFrekVjQnlyN1RZNmszck5xK3grMVc3L2tU?=
 =?utf-8?B?TWovVVdmbk11cE01WU81Z3ZqOG1yYzcvSWM5ZyttRnY4UnNPcVlnTStWc3NY?=
 =?utf-8?B?aHF0bDFRSVc2Ky9VYzRkQVV4OUdVdWtaVFpXY2JEYVBUL2F2bTRoWHBocldN?=
 =?utf-8?B?ZXBoQWFYVStkSlU1R0JWMTVJOXVTQ2RZNFJwTzhFSm9lZXByV215S1VjNWRD?=
 =?utf-8?B?WXlwcGhnbTgxRldxNFVXZFdoRk1ETUhWVlVndFRXVzZkckNwazFMdDRiU1k3?=
 =?utf-8?B?YlhGNUZkNm80LzRTREN0ZkhXZ0YzN1NpKzloN05nRkpnYTVZdmQ0RE04Ny9w?=
 =?utf-8?B?Y0xLbVFYOWt2bFRYTG9vTlhHUUI5NjF4UlpPWnQwUzNkU2l3cmdSWTNCUVJJ?=
 =?utf-8?B?MGdIbHY0WjBPc2R6cSt1a29TNzFENk9mVUhLeUpGdmM5bzRReXZUK1M0NzNq?=
 =?utf-8?B?YmRsMnBsZDZ1UGVFajczTkhKV0F1MWdycFd0cWtsUDBINnNqcVBkZklTOEVj?=
 =?utf-8?B?UlRMdUdSNlNGeGNEbnlDdi9JNWUrY0MrV3lLbGh0RjRSUkZxWEJNcXRUQmJm?=
 =?utf-8?B?MnA4VFZMdmYzYXpMOHFiVklpSzBHeHVDeEdhc1psdWJOUVpsR0d1WldQWVFi?=
 =?utf-8?B?VUhTTGk1NGROcEE3V2k3S0tzSVhFMkQ3UnhDNVlhenkreVkrcnJyQ01GV3JH?=
 =?utf-8?B?dDMxLzRkQnFFVVBOYUFZS3liUHB3RVR6Yy90ZGRPYWRGVXYzREpYR05VT1FR?=
 =?utf-8?B?bnYvdVM5Ni9PcElxZTBSVlI2bm5ZcUgrZTd5NWN3Y2UyR1Nva01vVDJFZ2lU?=
 =?utf-8?B?WWNBWkdvc3hsUVhkdDVlR255azNZT0lXQmtsU2xZZ1NYRzE4VW9RT2JySGxr?=
 =?utf-8?B?TnBtT0s0Zlg4NVFzTGpzM29YdHoxUHdOdS9samlyUHhJRDRCekZUUFZqTW44?=
 =?utf-8?B?ay8wOWJGb2ZabzBXZEVLSHFGQUlUVlFqcCs4Y2xGMHIzYUFvbk4xK3hwTWxy?=
 =?utf-8?B?YzJFQmtsUlA4Tlg2Mzc3b2dpZGRIeEtkcmJtd2I3ck1HZFJncjQxZVJMSHcy?=
 =?utf-8?B?YjZyRlJmSDQ4WUxyVlVKTlltWjBZTTZuL3FNTllxWEkxZVFiVllRUXhNMStr?=
 =?utf-8?Q?v7/5CVLxagp1q/hyN6fNA/K6i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gJGmiG+cqJVrDF1E2urMmGSp+8OixfLETpuV27lIev7I73cq2C3oPmol3LOAXmCxtZuczfAO0TOe1baT9J/HkW4M9TXLNfbiNA3Ay4G4HwMOh/m6GAaH/eQHjQzRtTszWAc64SR/Gbyn84CziVL6YWGB7MJ2UBrnTSTCbEyKjDfHDp9nODgHjTDpCVX/Q+4mv8o3pQ+FAHFyl2lQGdNXUuXh5MmEDgSAInPf8KkJUjW7KGf1pF6qimqb41aldi1+aPwwi2a8oNpknFvj3p4CsWKSDsLdci85/9FpbuYQ5k5M8pzTo5ByJ4fuIRDJz7zqO2ZzVui0rVxNRvnBq2foGWAGPVblYv78YFXPwjhcwkvHNqyDW2JdW/Dp8EW5P52koOmq932u2E6pNPe8xmqL4VtY7Ri5F22btHm/BNmy15FUqWcmEAK6D+IkFlA9T8lIbaMGzWfEFctsLQUCvX/O++BxtyKDBQhTpbjEzGMsmOTcri+o66DFgkuEuAZJk9ct7EKeiCv47eOLE0l9bPFdLk6frJYpyLsruLSVZUZTA9yAWcRY418Sagr8QKiSA4uAn/IiiEsL+4/s773L8e1/XY5oCO3LBiryjI9x+P1K4O+47lTQ9gFJoQ9g9QDsFHeK
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dde0bf-296d-4ac4-910c-08dc4a86e688
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 15:44:03.3171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ek5bDvqHVCCDnEs4ZJoA6PXnCtjwO6vr0o/UWQd1rWu0Im1GzyB8cWG7yxFNQ3SgEA8K6gXu4XEFamOFZ/jZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6980
X-Proofpoint-ORIG-GUID: V2zd-uIK7eJdhnJ4BBMazO4oYyc8oCZb
X-Proofpoint-GUID: V2zd-uIK7eJdhnJ4BBMazO4oYyc8oCZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=846 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403220113
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxOSwg
MjAyNCAxMDo0MyBBTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBxZW11LXMz
OTB4QG5vbmdudS5vcmc7IFJpY2hhcmQgSGVuZGVyc29uDQo+IDxyaWNoYXJkLmhlbmRlcnNvbkBs
aW5hcm8ub3JnPjsgcWVtdS1wcGNAbm9uZ251Lm9yZzsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7
IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZzsgQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz47DQo+
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz47IEJyaWFuIENhaW4N
Cj4gPGJjYWluQHF1aWNpbmMuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gtZm9yLTkuMSAwOC8yN10g
dGFyZ2V0L2hleGFnb246IENvbnZlcnQgdG8NCj4gVENHQ1BVT3BzOjpnZXRfY3B1X3N0YXRlKCkN
Cj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVh
bGNvbW0uIFBsZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5k
IGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gQ29udmVydCBjcHVfZ2V0X3RiX2NwdV9zdGF0
ZSgpIHRvIFRDR0NQVU9wczo6Z2V0X2NwdV9zdGF0ZSgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1i
eTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQoNCj4gLS0tDQo+ICB0YXJnZXQvaGV4
YWdvbi9jcHUuaCB8IDE0IC0tLS0tLS0tLS0tLS0tDQo+ICB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8
IDEzICsrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1Lmgg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaA0KPiBpbmRleCA5MzVhOWMzMjc2Li4xZDQyYzMzODI3IDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaA0KPiArKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuaA0KPiBAQCAtMTM0LDIwICsxMzQsNiBAQCBzdHJ1Y3QgQXJjaENQVSB7DQo+IA0KPiAg
RklFTEQoVEJfRkxBR1MsIElTX1RJR0hUX0xPT1AsIDAsIDEpDQo+IA0KPiAtI2RlZmluZSBUQVJH
RVRfSEFTX0NQVV9HRVRfVEJfQ1BVX1NUQVRFDQo+IC0NCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBj
cHVfZ2V0X3RiX2NwdV9zdGF0ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdmFkZHIgKnBjLA0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90ICpjc19iYXNl
LCB1aW50MzJfdCAqZmxhZ3MpDQo+IC17DQo+IC0gICAgdWludDMyX3QgaGV4X2ZsYWdzID0gMDsN
Cj4gLSAgICAqcGMgPSBlbnYtPmdwcltIRVhfUkVHX1BDXTsNCj4gLSAgICAqY3NfYmFzZSA9IDA7
DQo+IC0gICAgaWYgKCpwYyA9PSBlbnYtPmdwcltIRVhfUkVHX1NBMF0pIHsNCj4gLSAgICAgICAg
aGV4X2ZsYWdzID0gRklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBJU19USUdIVF9MT09Q
LCAxKTsNCj4gLSAgICB9DQo+IC0gICAgKmZsYWdzID0gaGV4X2ZsYWdzOw0KPiAtfQ0KPiAtDQo+
ICB0eXBlZGVmIEhleGFnb25DUFUgQXJjaENQVTsNCj4gDQo+ICB2b2lkIGhleGFnb25fdHJhbnNs
YXRlX2luaXQodm9pZCk7DQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jDQo+IGluZGV4IDNhNzE2YjliZTMuLjVlMGE5NDQxZjIgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jDQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2Nw
dS5jDQo+IEBAIC0yNzMsNiArMjczLDE4IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fcmVzdG9yZV9z
dGF0ZV90b19vcGMoQ1BVU3RhdGUNCj4gKmNzLA0KPiAgICAgIGNwdV9lbnYoY3MpLT5ncHJbSEVY
X1JFR19QQ10gPSBkYXRhWzBdOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIGhleGFnb25fZ2V0
X2NwdV9zdGF0ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdmFkZHIgKnBjLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90ICpjc19iYXNlLCB1aW50MzJfdCAqZmxh
Z3MpDQo+ICt7DQo+ICsgICAgdWludDMyX3QgaGV4X2ZsYWdzID0gMDsNCj4gKyAgICAqcGMgPSBl
bnYtPmdwcltIRVhfUkVHX1BDXTsNCj4gKyAgICAqY3NfYmFzZSA9IDA7DQo+ICsgICAgaWYgKCpw
YyA9PSBlbnYtPmdwcltIRVhfUkVHX1NBMF0pIHsNCj4gKyAgICAgICAgaGV4X2ZsYWdzID0gRklF
TERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBJU19USUdIVF9MT09QLCAxKTsNCj4gKyAgICB9
DQo+ICsgICAgKmZsYWdzID0gaGV4X2ZsYWdzOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBo
ZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqKQ0KPiAgew0KPiAgICAgIENQVVN0YXRl
ICpjcyA9IENQVShvYmopOw0KPiBAQCAtMzI3LDYgKzMzOSw3IEBAIHN0YXRpYyBjb25zdCBUQ0dD
UFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gew0KPiAgICAgIC5pbml0aWFsaXplID0gaGV4YWdvbl90
cmFuc2xhdGVfaW5pdCwNCj4gICAgICAuc3luY2hyb25pemVfZnJvbV90YiA9IGhleGFnb25fY3B1
X3N5bmNocm9uaXplX2Zyb21fdGIsDQo+ICAgICAgLnJlc3RvcmVfc3RhdGVfdG9fb3BjID0gaGV4
YWdvbl9yZXN0b3JlX3N0YXRlX3RvX29wYywNCj4gKyAgICAuZ2V0X2NwdV9zdGF0ZSA9IGhleGFn
b25fZ2V0X2NwdV9zdGF0ZSwNCj4gIH07DQo+IA0KPiAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgdm9pZCAqZGF0YSkNCj4gLS0NCj4gMi40MS4wDQoN
Cg==

