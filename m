Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9311EFCD9F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzecX-0001OD-Tx; Mon, 09 Mar 2026 13:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vzecW-0001NN-DF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:42:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vzecR-0001w3-4Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:42:18 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629CNBhl059583; Mon, 9 Mar 2026 10:42:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eyNvX9A8LmLCyNyy7tbwKtMmN3NYKk8xJy5ak0HwS
 2E=; b=B+fkyVu7TlyrH8MZ9YaXi7Wpn3kN2CNfxHT2WRynexZo3rVjItcwwwK+1
 ELz6rwFynj8/m90NTrgO7NqU7U5by/5JZ4k23/Jbol+mwjY+NYwHPrQkoGvkyuFa
 FMyYVOygSvFwkc1LV+QR9E4zNCwkDKBXWP6/MPfaurptsQcVg3BM7QCMeot1w78I
 yH/iI8QmamY2ldeFHnc2gtSMVzO/bgkhXkH7lc8YZOjFLdyQJVkRrSpRcethK+6T
 ZnKWgbOFIpTxc2/0//1ZQB6YUzR0Mh8dz0jVY9k9aqM8AO+MDOfKnUxMunqje5NI
 H8DzR24RWl/GFXh5F2VRSMbJIj1Fw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022073.outbound.protection.outlook.com
 [40.107.200.73])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4crkyk5k8g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 10:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHgY7TWZKKdCO/z64lCgZjv+nAE9nIk38AMPib77wyFyTAqD8IXnKzVADlb7L4IwwndgDIm5X6YTAArlHhv57gDAyqz8wLBtKIH2aU8EOwN7Qa7GwMHcNten2X8jocayVDqeAA16y3faQkWW/PL551FMWxwy8EI3oxfeYxQiKc6hPVPc9rfwP+SBiiXMWazgGH+YUysMmPuGeJu/hu1XUurQRzRMJUZA5xHLyTuOKRV61qySDwvrbbcX49Z4em8m5FamhSwqjVPVVW7eF4LhOiIjLVsPxn9CvZWNsTbbza811Rbc+R7DQPX8F8QHfrcW3d5mhYZ61TPptQIeuGDYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyNvX9A8LmLCyNyy7tbwKtMmN3NYKk8xJy5ak0HwS2E=;
 b=gW2z7b6fqYdKgCp6dEPAG2p7E1dPa+lWl4US4AaJ4dCJvZSB/s0oMJ1tLojJAqTRQajQlerpqlB7JlGWEOpfjyXpmgtKogmyZfTabGosQiwrNJLUcUPMdyuIpKg3M8K/vCe/gu/375R2ciJFgKluPqw75ajmRNXSf4+kRonHiFCXVbdMjfkzZhgUnWEUDquL88TXV1Gd309kxaCPKACXMXoTBSvppCaNiSokZeze12q29FUjOCBtHMexgnJuzpjE1HKfRYCDuaKgIbHJ5ss4lt+a4pPOrCmEn0NVk4qVeyYGhu6zBNYKQkJz0N7ibBn67zPm9xp6WV8zYIzoAw0xzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyNvX9A8LmLCyNyy7tbwKtMmN3NYKk8xJy5ak0HwS2E=;
 b=aHtJgwGllD2QiQrk1whRUf9OJNiqz/2Dr2RlbJsYtArHsfASlxJCeQ9XU0lM8cYWdF2TOjnv/+ZoqobPheYMI2gZfxxElZ57QFQZSdaaDyss6LW5vR7RJMbgdoymzQBGmEPgxFoh50ktGE/EPITRqyDspkr9d1MrvSV2eJheLs1fnXAyU5qPUXukqvNu7rKrg2ndVKcPlcPEcgJ9Xh+6MamulF4RBgMSZnO44+kDACNZTtmap9ROmWGth/ha0IL2oOhtIoxVUxIl6DI11julV4Xj0hw/l9LZ0Yovf+u3FlDz6qSBzCGqw2gMYx6lePxo2SkTu1U9A2Ry1ZDYZqziaA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by IA0PR02MB9631.namprd02.prod.outlook.com (2603:10b6:208:40f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 17:42:08 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%5]) with mapi id 15.20.9678.020; Mon, 9 Mar 2026
 17:42:08 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Thread-Topic: [PATCH v2 1/1] io: make zerocopy fallback accounting more
 accurate
Thread-Index: AQHcr6Rq6iJC2Z+CoUCUQa6EPCmGKbWmad2AgAADGwCAAAT0AIAABtkA
Date: Mon, 9 Mar 2026 17:42:08 +0000
Message-ID: <0DF1A5F6-E20D-4A3F-9285-9205E87DE641@nutanix.com>
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
 <aa755Yc6t_bBzM_u@redhat.com> <aa78gMsQrt1BeXt3@x1.local>
 <aa8AqKqOa8YhEiF9@redhat.com>
In-Reply-To: <aa8AqKqOa8YhEiF9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|IA0PR02MB9631:EE_
x-ms-office365-filtering-correlation-id: 9d1bb4b5-24ef-4451-15b5-08de7e032fe6
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 8YrwBTnfLfcB9zP4YGK2Jwf5yq+0d8PbflyMWbaMK/IKc8wsoq23EhTKVaSPAj17S6IGn5eRcO3XFsiHr18/xrlP7lYNJBKYIWhRtOO30rSgZ0ojov9STvwTgJd83omzovCRTA3j9hi9Fwg2k0XdPm1XDVsK3nPIFPuPBzOcWVSaQhSJIC0F94DlpYNDUuocbVDZCeb0B4P4ivAFQRmCoCJon9lTpcZyhj3wI32KvrKUR2A1fAjpu2lK+aaFVBzV4BG1Pel9L46QxAxMbR50xUdH2EsQMq5cHuSX370QdxbL3L8spHPL+vzGyszXC5UpkGsliXQ+5x/Bm4F0iF1PBqQIfGecZ84L9LEd/WXqCOamgz8kdkh9588ywJEYlC96bR4jqdvJ1aPl9kr+mwRM1RMoVe6WRSanZC31ZrnA8VUgc3A+0B1Qazs+wvmzoYVWJridIm5udX53FKxkSodXGv1ENgIgHsxKnAIkq0T0YqJgHvbvqGG+4oD40i3sxLSCMVqt2TKb0O2KzzCfGvjh2D0OJG5VfUagC06n35bP4bPXgIsMMCluvGyOt2FUsVhmDyrOBHkn90Hf84rKn4XYx1NocEX12iFfBBWu0aEK+eEiQyemHgmNL1ZraZhyje3cM2OcckSiqzHY2EUV7ijm6+ucIz99yXY7OpfoItTnMLJktzTusZML5iR5oUL0MA9HQrmA5+hpj6i2vjH0h3UoDhO5q+65obvnOXAD8wOOxJq1d00O/3oMzV1U9GzgMsnK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2RGVDc2VlBxb1BZKzZoSVczVnhHOEtWUVNiVjUwSHBaSFo1VDdVODhEQ0xs?=
 =?utf-8?B?SlYrUTM1Znk2N1YyODRNWDJPaUJZRUhoRnNiR2xuS2pwTW80ZjcxR0ZPK2ZS?=
 =?utf-8?B?TVNWTWhrOUhoVVlnTFdrNnh2Wmp4K0k4YlZUbS9NWmR2akF3MDJwOVNkVWFY?=
 =?utf-8?B?KzRiM21KemZmdGM2dUd6UEVMVFVvUmFYWSs0VU1vR2NXZ0UwaWRCM2ZkQy9L?=
 =?utf-8?B?L245YnVRcG5kREt5UC90eHdCcENqZ0FpdXVvLzJSc215QzU3U0YvZGovM25L?=
 =?utf-8?B?MGx1blV3MlNaajRhSXZvTHpydWFsZlVVZDRqVTNCZE1LQm9aOVBieSsrV0sw?=
 =?utf-8?B?dVpydHBqSUdVNU5tUUllMTdqZTB6NnJCSzE3dWtmUUhRdFI0M3hZbTZ0UmQ1?=
 =?utf-8?B?TGVrTlVpYUhxd21leGowZWNwaGw4Tjk3Z0h1dWlYdERUcXNkVWxhMGJHWVY1?=
 =?utf-8?B?RW1sOTNUcDN6eDNTTzhEV1YwUWJGSWo3VkxiRWRiYktBN1V4ek1nWUQ2ZGRF?=
 =?utf-8?B?QlhxWFNlbjV6K3Z5UTlMTGxUVzNucmNPNFhDK2h5b0RVNEE4SFhDRWdXOFRw?=
 =?utf-8?B?Z0tHSDlRUDN1U2owSDNEREk4b2dOOUtBeEROM3haV2UxOWtleTA4dkEwOGNh?=
 =?utf-8?B?NzBOdGRqMVU1L2l2ZkNSM1lVZUNDRngzcXBqdVEwY3ptQU0vc0s1U3R6VGFp?=
 =?utf-8?B?QUFZMHR5R3M0azQyOEtweVBZclJpSkVUSVl2QzFEMmxvR1VUaWliTXBqc2RM?=
 =?utf-8?B?czR1eTU2YmZkRFQrQzE2aVMvcTE3SVE5bWRYUkZsMktKaG4yaHFQWWUwNk4v?=
 =?utf-8?B?ZFVBWU5ackdQanhRMTFYcWdLQTFDcXB3UnVvWStRa1FVcDQ0dWpmTFNWSDd1?=
 =?utf-8?B?THFxQmx1VnhZeGdiYUpCc1pETVRrMWRPZ2U2WHBUMVhNdlVyS1NVdzlYdTNB?=
 =?utf-8?B?RG1DVzAraUZGTFllRjIxeXJhMFdnUENtVktMSGRMSkl1Rjczd0VDVzVBUjVM?=
 =?utf-8?B?eTBuSjlYRXZwZjRJZmF0OFdmQmVVQ1JWcFM1Yk5yQjZwTE9tVWxxNW5BdFpD?=
 =?utf-8?B?a3lKZ0ZEYjdSRzlRUlN3S3EzVXkxYW5qWGlLdXgzU05kamhEaUdDaVBsdGNM?=
 =?utf-8?B?NmpCRno4U1hLUENmQkRhOG5rczF6THJTM0lmOWd6OG5NWitWMW5Iem9SeU5l?=
 =?utf-8?B?OWZRbDJ1dVdHN0tBUlVlM3FJZGMyT1huWHB6ZjRHZDNyT1NRTTUxYnM1V2p1?=
 =?utf-8?B?cEpyNEp4WTRYc1dFNWRlZTBJMHlyTE5JcENobmlXNldkRnVQaEMweE41RlhN?=
 =?utf-8?B?Wm5IQTh6aUJ2amFpQ2JkSlJrYnh3Z3JyM2s0SW9oUVN4OWJvMGkrWDhpTUZW?=
 =?utf-8?B?QVRiUzFPVDBXbldSQWNBci80YUV3cFo0aEJ4dEdlSHV1OGFnQVBVTkRMMlIr?=
 =?utf-8?B?VllnQk9EVm5STnhpTGRrRk9GQTc2OG9GaDMrd3pOVjZwUlExd2hQdDhSYlhD?=
 =?utf-8?B?dnJZV2Q0UXN5a0ROTnZzWG8ra2w2bGpPdEU2TTVZOFcvV2xXVWpocWZ4U3BF?=
 =?utf-8?B?RzQrMzZHRlJtVHVlRVE5bFhRM2dLM1Y4S0wyUi9rMFY2VytYSTM2TzhDWjYx?=
 =?utf-8?B?cGhaRmRMc05IciswbURSR3d4VTFlSTdXbFBCSm9QUnVveHJ0YWUzWmdybkxQ?=
 =?utf-8?B?dTJHMWN4UHRlSnZnbk9rY0NQN3dSWWFOSDdwOVZPNCtTT0U1L0hqZkpiVjJr?=
 =?utf-8?B?MFMrQVZQNVNzaWxzZDNwWWk2Z2daalM4cHJMalBxRXNSa1VKTkNjM0NrWStp?=
 =?utf-8?B?bisraFVHaDlZdEF0YVI3aDRQOFh6cGRrbURNM3Fmd2NvNjIzbEVqK2lNd0p0?=
 =?utf-8?B?aXF1enZMdjlmdXVCYnNVbHE4NUFPNGdXRkh1QmhTVUcxY21sOTRINDZqS2Nt?=
 =?utf-8?B?Zk4wSFpmay80aXlKMS9McEh1dG8yN0QxcmlVSnBOOXFlTWdBWUFWVThqdVdJ?=
 =?utf-8?B?TjJSVlZsVEtndmFuWHpUNDlTNHVnS2JVYXU3VURrQUJQZE1lRkFBYVVWNVZX?=
 =?utf-8?B?MGpzN2ZxZjkxdFlzYmdDciszVTZ5UFZxR3JaNnI3ZnNTYTJEaHBxaDA0K1Yv?=
 =?utf-8?B?S2pDdEtKdkNVelg4MnV2cGdFc2k4LzYza0crNnE3NmRzVW9qeTU3MWhEaU8v?=
 =?utf-8?B?Vm9WSHltdEdpbkN0WHNKcjhlUDk2SENHL21MNlQwOEdlN2VET1g5d0cwUjF1?=
 =?utf-8?B?MHI1Y1pVaE5hK2U2eGRFZU5QS2RRbHhrenBvdnRKbVJMcGc0R0wvWGpRSTRH?=
 =?utf-8?B?MjhTM1pLOE8zTmxvc3lQTmtYb1ZKQzQzUWE5RFl1QmRKYkFiNm9wZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6E0B46F46F56B418B273C05B544E2D6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NW/n1D2o+Re1z25utSEXwrbqFlp0NGaV5TZpmbUWm9rTIBoEA2v7UCWa/FYTF6RwYD2WMbTHxyErd47RH4vLEf+Uyv+YhpkiAsl9jq1d4bLjcnRv7pY4taVPr+ExpB/n/eyQ4kCrfakvjKJqW0/ekHlr3Myrp+6NLAZK0NrVOW2kdY6Knd9zyCzlSPSEjmhrHXynv1KKPlyS5voquT1jsKJed0t8vYuWkx7XjugyFhTb/i80A89f854olMeTIEUD7bFsmmjFO2KQ7DIJCzoV0jsdkNXMBxn2tiqpdavxX3OEZDuNLxen9SAEIGx3mqoPWXkQ8jVYvHnTht/5M7bPaw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1bb4b5-24ef-4451-15b5-08de7e032fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 17:42:08.6548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQyY4SkMLF84hvvmX8kkUo60CXU46qdWCc4FhLBHYsMP64VrYCifNv0AYNj/GjfK2ttlWcdEMQXt7SL8eSvt5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9631
X-Proofpoint-ORIG-GUID: UnsdsbBz622KYhwjgXRJYES0MmGaEHWE
X-Authority-Analysis: v=2.4 cv=Y831cxeN c=1 sm=1 tr=0 ts=69af0672 cx=c_pps
 a=mhBramkM2YKFwkQI7AGxcA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=DG3v9zVweXGxY0ZWAqYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1OSBTYWx0ZWRfXzsIMWxMSos/1
 660OUWXPSquh1R3XudTb2heWKo2Bor0OdEYC9OhXJXtkS1DclFgifpine/WpsKG021a8ajgXR/o
 gI0IGIqpAYdjHadKdGit72e0ccvQHffI80ur30ONuIYFOvIaWgUIqHj9XZ4Td0iWwcItP1o45lE
 /QREMe39QV9eaFuJo9jWKZtz2YUALuwqlaHMAYETkKF6U3Z1b9DsnSP5TZFRjLkhdpxX8eYALBw
 vh6aKtw0VNYGyl4BVgTrAF3/WV1M77goItt/y4ea53D+Rw8X+AGTb234QxJ60Il0UsJwn2rilcC
 vT03yBihYHPNfSSmopmaH+otECYWWN0z2S37+xR1lv9HqF3tjq4rS/RQKnatLqMc1TqBxs9WzkJ
 5t2MULABTEOR4WjhYNjzazZx1+dbws9eQbhHv0I5VmYP1DmqvOAM2So6tEevUPLCbjiFJqPd1X7
 xqMH6yaStyPu9666UYQ==
X-Proofpoint-GUID: UnsdsbBz622KYhwjgXRJYES0MmGaEHWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCj4gT24gOSBNYXIgMjAyNiwgYXQgMTA6NDfigK9QTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJ
T046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIE1vbiwgTWFy
IDA5LCAyMDI2IGF0IDEyOjU5OjQ0UE0gLTA0MDAsIFBldGVyIFh1IHdyb3RlOg0KPj4gT24gTW9u
LCBNYXIgMDksIDIwMjYgYXQgMDQ6NDg6MzdQTSArMDAwMCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3
cm90ZToNCj4+Pj4gQEAgLTg4MSw4ICs4ODEsOCBAQCBzdGF0aWMgaW50IHFpb19jaGFubmVsX3Nv
Y2tldF9mbHVzaF9pbnRlcm5hbChRSU9DaGFubmVsICppb2MsDQo+Pj4+ICAgICAgICAgc2lvYy0+
emVyb19jb3B5X3NlbnQgKz0gc2Vyci0+ZWVfZGF0YSAtIHNlcnItPmVlX2luZm8gKyAxOw0KPj4+
PiANCj4+Pj4gICAgICAgICAvKiBJZiBhbnkgc2VuZG1zZygpIHN1Y2NlZWRlZCB1c2luZyB6ZXJv
IGNvcHksIG1hcmsgemVyb2NvcHkgc3VjY2VzcyAqLw0KPj4+PiAtICAgICAgICBpZiAoc2Vyci0+
ZWVfY29kZSAhPSBTT19FRV9DT0RFX1pFUk9DT1BZX0NPUElFRCkgew0KPj4+PiAtICAgICAgICAg
ICAgc2lvYy0+bmV3X3plcm9fY29weV9zZW50X3N1Y2Nlc3MgPSB0cnVlOw0KPj4+PiArICAgICAg
ICBpZiAoc2Vyci0+ZWVfY29kZSA9PSBTT19FRV9DT0RFX1pFUk9DT1BZX0NPUElFRCkgew0KPj4+
PiArICAgICAgICAgICAgc2lvYy0+emVyb19jb3B5X2ZhbGxiYWNrKys7DQo+Pj4gDQo+Pj4gLi4u
dGhpcyBpcyBjb3VudGluZyB0aGUgbnVtYmVyIG9mIE1TR19FUlJRVUVVRSBpdGVtcywgd2hpY2gg
aXMgbm90DQo+Pj4gdGhlIHNhbWUgYXMgdGhlIG51bWJlciBvZiBJTyByZXF1ZXN0cy4gVGhhdCdz
IHdoeSB3ZSBvbmx5IHVzZWQgaXQNCj4+PiBhcyBhIGJvb2xlYW4gbWFya2VyIG9yaWdpbmFsbHks
IHJhdGhlciB0aGFuIG1ha2luZyBpdCBhIGNvdW50ZXIuDQo+PiANCj4+IFdvdWxkIHRoZSBsb2dp
YyBzdGlsbCB3b3JrIGFuZCBiZXR0ZXIgdGhhbiBiZWZvcmU/ICBTYXksIGl0J3MgYSBjb3VudGVy
IG9mDQo+PiAibWVzc2FnZXMiIHJhdGhlciB0aGFuICJJT3MiIHRoZW4uDQo+IA0KPiBJSVVDIGl0
IGlzIGEgY291bnRlciBvZiBwcm9jZXNzaW5nIG5vdGlmaWNhdGlvbnMgd2hpY2ggaXMgbm90IGRp
cmVjdGx5DQo+IGNvcnJlbGF0ZWQgdG8gYW55IGFjdGlvbiBieSBRRU1VIC0gbmVpdGhlciBieXRl
cyBub3Igc3lzY2FsbHMuDQoNClBsZWFzZSBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZyBhYm91dCB0
aGlzLCBpc27igJl0IGVhY2ggbm90aWZpY2F0aW9uIGFuIGluZm9ybWF0aW9uIA0KYWJvdXQgd2hh
dCBoYXBwZW5lZCB0byBhbiBpbmRpdmlkdWFsIElPPw0KPiANCj4+IFRoZSBwcm9ibGVtIHdpdGgg
dGhlIG9sZCBjb2RlIHdhcyB3ZSBtYXkgcmVwb3J0IGZhbGxiYWNrPTAgZXZlbiBpZiB0aGVyZQ0K
Pj4gY2FuIGhhdmUgZmFsbGJhY2sgaGFwcGVuZWQsIGFzIHdlIG1hc2sgdGhhdCBmYWN0IGFzIGxv
bmcgYXMgb25lIHplcm9jb3B5DQo+PiBoYXBwZW5lZCBpbiB0aGUgd2hvbGUgYmF0Y2ggYmV0d2Vl
biB0d28gZmx1c2hlcy4gIFNvIGl0IHNlZW1zIHRoaXMgKGV2ZW4gaWYNCj4+IHRoZSBjb3VudGVy
IGlzIG5vdCBwZXItSU8pIGlzIHN0aWxsIGJldHRlci4NCj4gDQo+IEJldHRlciBmb3Igd2hhdCBw
dXJwb3NlIHRob3VnaCA/DQo+IA0KPiBJZiB3ZSBlbmFibGVkIHplcm8tY29weSwgaXQgaXMgdXNl
ZnVsIHRvIGtub3cgaWYgL3NvbWV0aGluZy8gbWFuYWdlZA0KPiB0byBiZW5lZml0IGZyb20gemVy
by1jb3B5LiBpZSBpZiAvYWx3YXlzLyBmYWlscyB0byB6ZXJvLWNvcHkgdGhlbg0KPiB3ZSBjYW4g
ZGlhZ25vc2UgdGhhdCB0aGUgTklDIGRyaXZlciBpc24ndCBjYXBhYmxlIG9mIGl0LCBvciB0aGVy
ZQ0KPiBpcyBzb21lIG90aGVyIGxpbWl0YXRpb24uICBJZiBzb21ldGhpbmcgbWFuYWdlcyB0byB6
ZXJvLWNvcHksIHRoZW4NCj4gd2Uga25vdyB0aGUgZmVhdHVyZSBpcyBmdW5jdGlvbmFsbHkgd29y
a2luZy4NCj4gDQo+IFdoYXQgd2lsbCB3ZSBkbyB3aXRoIGEgY291bnQgb2Ygbm90aWZpY2FpdG9u
cyA/DQoNCkkgd2FzIHdvbmRlcmluZyBpZiBpdCBjYW4gYmUgdXNlZnVsIGZvciBkZWJ1Z2dpbmcg
bGl2ZSBtaWdyYXRpb24gaXNzdWVzIHdoZXJlIHplcm9jb3B5IGlzIA0KZW5hYmxlZC4gRm9yIGlu
c3RhbmNlLCBsZXTigJlzIHNheSBhIHplcm9jb3B5IHdyaXRlIGZhaWxlZCBkdWUgdG8gdGhlIHNv
Y2tldCBlcnJvciBxdWV1ZSBiZWluZw0KZnVsbC4gTm93IGl0IGNvdWxkIGJlIGVpdGhlciBkdWUg
dG8gdGhlIG91dCBvZiBvcmRlciBwcm9jZXNzaW5nIHdlIGhhZCBzZWVuIGJlZm9yZSANCihodHRw
czovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2NvbW1pdC84NDAwNWY0YTJiODc0NWU1OTM0Zjk1NWMw
NDVhMGI0MzExY2QwOTkyKSBvciANCmR1ZSB0byBpdCBnZXR0aW5nIGZpbGxlZCB1cCBiZWNhdXNl
IHNvbWUgY29waWVzIGdldHRpbmcgZGVmZXJyZWQuIEZvciB0aGUgbGF0dGVyLCB0aGlzIHN0YXQg
Y2FuIGJlDQp3b3J0aHdpbGUgYXMgYSBkZWJ1Z2dpbmcgc3RhdC4gDQoNClJlZ2FyZHMsIA0KVGVq
dXMNCg0KDQo=

