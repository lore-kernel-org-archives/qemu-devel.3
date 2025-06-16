Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DE1C71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 21:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRGw1-0006Qp-6P; Mon, 16 Jun 2025 17:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uRGvv-0006PQ-GU; Mon, 16 Jun 2025 16:59:59 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uRGvt-0002S8-KN; Mon, 16 Jun 2025 16:59:58 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GBlqPT030649;
 Mon, 16 Jun 2025 21:59:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=WeuIsdfGEJV3EI8k2qD/XxNs3oN0g9956fG57Lmi2kI=; b=
 JKmn9SILHKQ/ryXASwqTTgBd/bWqoXtVq1lmntWKgVsi/dDJvftkWImagWZn+2Cd
 WYa20eh3cxagvfCb5FKJzf0jC+WvKIR1LNmUYzvXgdUodS2O7TXfY+IM+anLU+uW
 Xcy8KzghUSa1PwF+oMIYwt0DcEB7TDTLhQxp+d1agF9X1w3VwzmzFNZtpJWr5Aha
 6hsETMk2tKFPEaOxjrmXPTa4basXhdpgvP4D9bKQ34Gbbm4M8etAKiYuDBsf9Yvc
 iD55HGa4ueWEu7VWLDZOaTDnDpZTQfx1AEWsaRXV5B37KdUL5liYkINLGAd7HK/I
 dcUhp+qlryBKbxYu6HBVnA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4791m4eagx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 21:59:51 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 55GHrjc5005804; Mon, 16 Jun 2025 16:59:50 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.205])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4794e7htmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 16:59:50 -0400
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb6.msg.corp.akamai.com (172.27.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Jun 2025 13:59:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10 via Frontend Transport; Mon, 16 Jun 2025 13:59:49 -0700
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by BY5PR17MB3841.namprd17.prod.outlook.com (2603:10b6:a03:21e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 20:59:47 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 20:59:46 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>
CC: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "beata.michalska@linaro.org"
 <beata.michalska@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "junyan.he@intel.com" <junyan.he@intel.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Glasgall, Anna" <aglasgal@akamai.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: Re: [Patch] Don't sync volatile memory
Thread-Topic: [Patch] Don't sync volatile memory
Thread-Index: AQHb3vbfaBRDRG/7dE6gY1mmDUji3rQGPmoA///DyAA=
Date: Mon, 16 Jun 2025 20:59:46 +0000
Message-ID: <2E210136-20C2-4F13-916F-92FC8072396D@akamai.com>
References: <7987BFFC-D46A-4BAB-8973-F30E6689E05F@akamai.com>
 <aFCABp9-h_iBxoKe@x1.local>
In-Reply-To: <aFCABp9-h_iBxoKe@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|BY5PR17MB3841:EE_
x-ms-office365-filtering-correlation-id: b692ff4e-690f-4b82-fa0d-08ddad18ba0b
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Mkx3NkU3bUl4VHZtSHZybjRRdGhyVis1SE44c21QZkxPQThqdVpUb1R4dG5o?=
 =?utf-8?B?bDVyYkJZVFkrUEJxdkhXd3M1NmRwVkh4bThZTTE5STU0MnpRVHdhR090WE8y?=
 =?utf-8?B?eStIOTQ5Nkpka3VPanR1TlZLTUFzVTR3dUtzVVUrenhheXo3Z2VxOTY0STYz?=
 =?utf-8?B?Q09jNmRheDg5VWU3VEFCd21ZeXd2YUFRODdwZmRORU1VR0NuaDBjVmRyeUYy?=
 =?utf-8?B?ZHl6ZTRTM2lmaFVFOE05bEg2OFQvaW9IbmJSSWtaYUlWWjFrUmJYekZzeHl5?=
 =?utf-8?B?RkllTVp2WktiMDJiNmM2c0c1RjZZVndZMm8veFRFbFVkREhPcE1SR01DQzF2?=
 =?utf-8?B?SFJSU1pycVRsSERZZGJEUi9vc0N4Nk1xVTYvb3FKOVc4NzFGdFIxWEV5dTc2?=
 =?utf-8?B?TVZ5RFFMSjVLN0xBY0lPRU0wM2l0TW0yTmtCM3dkamhpaWZNOS92Ulcxa3hz?=
 =?utf-8?B?anZEREFmMnN6eldTRU5EZko0OERQV28yVTZ1U09WMjhpTDZDNVk1WHBiY2dC?=
 =?utf-8?B?a1BZcW1qclc1eUFTT1FPMmxCc1lUalNNVmZ2UFpjdERLWS9nbVFPVWN3QlVQ?=
 =?utf-8?B?ZjJKVnMxMmdoZlhyaUN5R1l0Q3dBR1YrRHNraUhNQXhoSzhBMDY5RThFazdS?=
 =?utf-8?B?QTNmSDNPQ0tacExnMVFYZ28vcTFNK1JNSXJBVElRemlrM1M3b3RjOW5YeU5J?=
 =?utf-8?B?TG85OHoxNExGWmJWRkdKeVdBNXpoK1BvV1dkTUg0TmxKeU1OSzVaRDhFODdK?=
 =?utf-8?B?NkxIZFg5QTV4cHJZOVpMUitZVXpQaWN4ZFJkcUkzMDdPSUV2bjYyMDAxN0oz?=
 =?utf-8?B?dWU5alRxckhuTjRIdnF1dXBvWEowR3g3R3I5elllSEtrRHdIVkNocDdXSUdM?=
 =?utf-8?B?Wjc1ZFpGL29PU01lRkJLUWM2YWFTeTJ4SmF0YlpSMEk0akhZenllRnBsRVYx?=
 =?utf-8?B?T1BWQ3RzWDFNa002NjZhcWFaZlVFMDlHNjYzYmtKbDJ1QUlaLy9KbTZ3NDJV?=
 =?utf-8?B?Ky9pdUJyRm9LZ3MxdjUvOXNpeSt2MGl3UVhJVWlQVlVzZFhyQTg1RDlVa1F1?=
 =?utf-8?B?N2NIZzQxNzNtaDE4V3hzdE9Wa3R4cHRYMEJqVVdHRGtBbDhZdTdTVXBIM2Zl?=
 =?utf-8?B?TUthNFFNaE1HeVBlTDVqaHVudW5tVzJjclFndTJidG9ub3Vtc3BRZXJVb2tC?=
 =?utf-8?B?akZocGhhdVlTVDJIcWVuMUFBeWxGMTVOTDM1QWY5TlU2ZWtLSHY4THlseFhY?=
 =?utf-8?B?TVExUGMveGdjNWRmY0ZJbEtVbDhUWGEvYWlEWVByanRZY053K1FaWUQzd01p?=
 =?utf-8?B?Y0VCaEY3VlVQT2RiTDRHZlVWQklLOStLOUNLM0hXNkFlTnlEeEt6NkVxK3k4?=
 =?utf-8?B?clNRSTRrNzBXRVR5UmpIcW94aE53ay80S1VwRXZWcU9ENkJIRFRXRGxMa1pJ?=
 =?utf-8?B?bmxZN1VNSXFtc0IzbnJ0NTlkc2c2VlRuWW5vS25KZ3dUQWRndVBuKzBUVmNW?=
 =?utf-8?B?TStRMlZ5U1NGbHA0TU5sY1J1QkE3RzUxdTg4aWpocTg1c3N0ckFTUnZUVUla?=
 =?utf-8?B?RHl5L2owTjN4VW5oK2MrYkJtYTk4VmFLWFMzMENJYnFybmhCaHE0VDVuZHJP?=
 =?utf-8?B?dTIwZDM1K2ZBQm9IZlZlMUdIUzRCUDFqTTRBZjdlaVpOSkRSYWNPR0dnNXBO?=
 =?utf-8?B?Sk1sYWxFVE04SG9vWWNCNzFQSm55cVNXWjdlbWdaaEdjOWFOOE40MzJQTjlP?=
 =?utf-8?B?cDZMeGFaWDh5ckt1R3FkQXpwL01uSm9aaituaDkyaFJNM01xeE1jQ1h5LzlC?=
 =?utf-8?B?VXd1NnFXYmlRTHBPMU9TVVhDdWFuOFNQbzA2bkM5SnkxY3RQamc1ZjdrZGY4?=
 =?utf-8?B?YnpjWHRla0ZsSFNVZ0h5OXVJTisyVTZWZmd1RzRoN1RhcVNZNWI5bFlkdlJF?=
 =?utf-8?B?Y0RNT3gramIzb2o2UEw2REpXSWUzZ3JMSHMyTmh4bXhXR2pqNkdzZnN1WldZ?=
 =?utf-8?B?TUhxV1RQRGhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmtUZzJLMnFzYlRSZ1JuNTdIL0RrMXBuODdJRnFPeUNtM1p4alJyNjBlck13?=
 =?utf-8?B?MXBMYlJEY0pLRlFpQWszbHZNY0ZZcmxaQXdhM1grNXZZT01GbHJ0S3MydjRQ?=
 =?utf-8?B?bEhwRE5TeW5iZkNha3RnOUhuS0dhdi9oaXd4VUtDZEFOZExJMkNGd2RpR2pR?=
 =?utf-8?B?Tnl6QVdOWUdtbEhqZ1UyU3JHcVFHY21wRG1kbzdSY1pjRHRhbDZGL0tDcm16?=
 =?utf-8?B?d3dJYk00MTZ4SmNWYWk1YUlqaVFZUzJGWWh4ZUViZ095OHkyNnF1aWNGNzVS?=
 =?utf-8?B?czRNNVN3eWp4SEp3M3hmWlcwbEJGQnJOeERqdnRSd1ZVR3RYL0VMc0lReFh5?=
 =?utf-8?B?MlkzS3VMZ3dhMmJlVFdUZUsyR3ZzUEZaNVAwVmRvZWhDdzBVcEd6QkIvaXgx?=
 =?utf-8?B?TDB4YkZDN1RzY1owa2NQMVNsOTdPNjhOaGtTcEhFdHhJMHZVRWlZRzdMZWRK?=
 =?utf-8?B?UDh1OUZqS3Vrd2V6bGNNUVo2VEpZWm9XT0V3dld4UW1ZTXRZVVJPeHhFU3Iy?=
 =?utf-8?B?WlEzQzFPL01FMWdVTzB5LytmRWlUWGFYYWk1Z3hreFNIYXg4K05CVHkrMlYw?=
 =?utf-8?B?bXNGNXJqWm93Sm02RXFwY0xSYkswYVRHSWVMOHlBWE11SlEyc3o5WHhhUURR?=
 =?utf-8?B?WXh5Ui9YSFE4Vjk1L0EvNVQwNEZSMC8weTRUM2NOclRkZGkyUVF4b3BqM0FW?=
 =?utf-8?B?NUU1ZjZ1SHhoL241NGRDeU5jZ1NLcmFINmdybFZObjIrL0hhRWQ3K3NveFNs?=
 =?utf-8?B?QlBwa1JtVFZWT0tvc2JoOFdNdUl0RmxrVGhXV3B3SDQ2ZjFNVmNCeHl2RWcw?=
 =?utf-8?B?bC9MeU9XMS8ySVN2N29YbVVLZ0wzbmU5a1cxbWd0TS9MQzcyYnMwOFBxbHhW?=
 =?utf-8?B?dklkcGZzK2crOVE1TVFmZzdOSHRLS2NYaHFBenpkOXdxd2l2M3g0OWQ1Mktx?=
 =?utf-8?B?byswK3QyNmptMXByNG83RUhEb3BmcUprSEYxSlFGVncxV0xqd1E0QlJUYWcr?=
 =?utf-8?B?ZVpLSWJQVHp1K1RUaHpnaTY4VFMwK3NDNTd5SkJaY0JPeGFXMVVRQXJsdHdH?=
 =?utf-8?B?dStHNXQ0NXBXYjlxNjFjZkY0bU9vdG5BdS83emV3TGZUQnpkRU9icjVIc0xw?=
 =?utf-8?B?Zk1FczdNQUVnZWZ4MUVhTC9KWkt6MVBwYVFVa2c5U05PZ0x0YlRGQkNkaDgr?=
 =?utf-8?B?aGZFVEFpOUVDbTJZMkl4V3JNOGRmd0lGckd4a1NPVVhPK09QK3gra3c5QUlS?=
 =?utf-8?B?WWpGWjBCZWdxTm1RajV0Yy9hQW9QaklOSDlicWJKZWlha0NjWUxIbVREY1Aw?=
 =?utf-8?B?Z3phU3FuZ2x3Y2NYNk5XK0pJaWZSODZ6WThpVTFmaE94UlVKdmpUVHZVRjla?=
 =?utf-8?B?cUJQWEtGVXhLaVFNb0h2SWZlcVVEQ01uNU1UNXVXT0szbEI1SXNRQnBTdzR6?=
 =?utf-8?B?L2c5UWNRT2RiaklBaUxMVUlGVGR1ZFE2RS90Q2I3ajJGdDE4V3FmZzJYakQv?=
 =?utf-8?B?ek9DUElJa3NTeFU5MHBLNXpoV1NYSHRXWmZaOFExVzkwM2NPUVhlbjBxanln?=
 =?utf-8?B?dU4vQUhaY2h1dkk4aHlKS0xTVktZRWdCbHBydUVqTEFYNWV5aCtnN2YrZTFE?=
 =?utf-8?B?Wkt4ZnJPZldnRGsrNVk1c01mQnI3OVM1cFJ1ZWtUaFJuMmE3NklGNzFRZjU4?=
 =?utf-8?B?NUo2NVBqUTdBK2piajYyTExUVlJLRSsvWXphRmxBVkhBZGovU1g4RlN3SFdW?=
 =?utf-8?B?ODBMY1NYd0tuWHZpekFwRGxnMmp1T05kRG9kOVduVGdnb0VJc0JKendnWDAv?=
 =?utf-8?B?N1lHMXRIODg3OUM1OWFGeFJNdDVwanVHSWFyTnJSRmtWaCtsOHZhZTJqdi9K?=
 =?utf-8?B?Y2RKVzRHUG42N1ZhdFFFVzRGTXZRcC93aHBLVkR6aGdBdit2MFNNVitBQ0s5?=
 =?utf-8?B?RGdUNlVQZ2pzdURtNUhhbWNuN1VMaDc0dVlPV3NoNVEzRHo4cUo2WkE3b29C?=
 =?utf-8?B?bnU1MDJvVnBjcm9mcDV0NXU3UzVnanFRQlBUQkp6cWw2UE9yWkNIVGwzc0FG?=
 =?utf-8?B?SEh0SjFldDhKSnU1MFlxUDRWVy85T0IvdUtJQ2dqNWZkTFhOOXJUZGdHWUMr?=
 =?utf-8?Q?wdCrAaca90evMRiEYKRV98QFO?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJYS9+VecZwsPtnWCt2zALo8XzaoBVjH06B36/yL86SDxeUj36q5VrTJ3q5NUzFjOBf51jHBgg+h6g57k/VhtNPu3zcWObhjhzY38igxVoF9nyfB1AGJlbARiKBQvUVDGQnobaU17ONCwAR0kxwDoPw5nSBPBsQZmOti4nguwb9IL4Ix2l6UG8hwp6JEzKAuTpXensNRot/t+91584i1pOL5aWyFNwobsCncu1pzz7JF2q4HrhWHdUvT9ypkZ/uI7pbqhw3Iq/ThSPYXoK7ffKf03AZzXQ6SsRZojLj7Fg6SWR4T5HyQlbC7xgo037LBHWVsQx1SgzAZZpOSxrWf2A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsRT/fRR7dGTZJAI+p4l4RckhUNgjOVY/qw7kEMPgIw=;
 b=ZBiLQs7j2XUTm5YmBIGhdqlzzsADVU5ifH6ti9lJKRh/yZaW2Ty8ys6Z0p21CtpQ1vdxZWDAi4hhv2KMu/RyjqhhAvq0jC7wAcZXjP0ZLvGCp16S4rIMIpFG8aTmgx1pSpZHdGpikU/DpxwuJe2QuMCYKsXX7cQudjjyx6OEfqfSCDPFdngvAIkn6zzmtT7GQ/rsoP9pEtXlgtlEp9JiUR4o4hdnTAMyqttzoomCXynFBzvdLq2xeonuU+f/lS3BSzlaPWUGpBKvx8qjW/+NWxBftZpTPPcaFtbcUiMz0wyGKJeAWTFh+LD+GGbzbMQpWrvFpPyH/hZsnyvfB5F23g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsRT/fRR7dGTZJAI+p4l4RckhUNgjOVY/qw7kEMPgIw=;
 b=ccb0EI5nY1tkFsvfW8FUYvRy4PuYPRmExiOFkBChYYcp6GpJdvZt/wGDnaMDbCq4Tl84gXXVebW5Z5hluyMKgfdMKA62ga1LcVxCzfn/29il18TV9jW2wZhyNyiynuTG/tTgWXgD1wanCPmHPrDoGAbjIcAlO4TckFeqE83V0lE=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: b692ff4e-690f-4b82-fa0d-08ddad18ba0b
x-ms-exchange-crosstenant-originalarrivaltime: 16 Jun 2025 20:59:46.8515 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: p5Sv5Q2TDCNVU+VXWUftTjBtWKNELnnWMi60zvMmsnQDcAuaRO8dwJhbsnaSN+cbjxP5h9JHzlnE2jm5T/GNtA==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR17MB3841
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9B1F1A472529245A121AFCC89A9A360@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=805
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160145
X-Authority-Analysis: v=2.4 cv=cZ3SrmDM c=1 sm=1 tr=0 ts=685085c7 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=g1y_e2JewP0A:10 a=20KFwNOVAAAA:8 a=VrrJEdDcrkW6d8FnnW4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE0NiBTYWx0ZWRfX1TPc4bubk6DZ
 sV5od5puNsWDdaNYbQDGx81sqao9/bbkVrs1P5HfmYpJ3yGOJYtPb5t811xuInHxtf2xj39fKvc
 UD1k25HiiMSZTjNioeUSRD76VBYYtv7O6+Yb5piOXdSyTXqAkQDMEuyR/1uEzclcjbr+qlUIh7V
 ulHz1ZP8GtsE67kgrAwv0dx+QlxzNY5hWGVIu7l/SxPJQ1G2JUxP2SUpWkEEBJcT2Owle08FitT
 QyGz2DTi9ofp5xmYP99+5yynM7kERthXWzt5EpbeEYMUi9dayE+Rx0NIwkZKztbTjlKj3H9eZfa
 gs/JPaRA8ZEYsAfo+HOlw0RSNjLNzPmhZ+Hy5tJT2ND8zTeCwcdDxBJiJdKk5wevp9j9oOk6zZc
 FGOgCKXCkT0EAA2lzklxdrKckouDh+oPzqAJVSSeguXBKUN4c8oJaOx1gdBQQbxadAOzehSF
X-Proofpoint-GUID: vYFN4_fCIwVv8whOJCER3n85Y_fyckt0
X-Proofpoint-ORIG-GUID: vYFN4_fCIwVv8whOJCER3n85Y_fyckt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=619
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160146
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCu+7v09uIDYvMTYvMjUsIDQ6MzUgUE0sICJQZXRlciBYdSIgPHBldGVyeEByZWRoYXQuY29t
IDxtYWlsdG86cGV0ZXJ4QHJlZGhhdC5jb20+PiB3cm90ZToNCg0KPiBPbiBNb24sIEp1biAxNiwg
MjAyNSBhdCAwNzo0MzowMlBNICswMDAwLCBDaGFuZXksIEJlbiB3cm90ZToNCj4+IE5vdCBhbGwg
cG1lbSByZWdpb25zIGFyZSBiYWNrZWQgYnkgbm9uLXZvbGF0aWxlIG1lbW9yeS4gU3luY2luZyB2
b2xhdGlsZQ0KPj4gbWVtb3J5IHByb3ZpZGVzIG5vIGJlbmVmaXQsIGJ1dCBjYW4gY2F1c2UgcGVy
Zm9ybWFuY2UgaXNzdWVzIGlzIHNvbWUNCj4+IGNhc2VzLiBPbmx5IHN5bmMgbWVtb3J5IHRoYXQg
aXMgbWFya2VkIGFzIG5vbi12b2xhdGlsZS4NCj4+DQo+PiBGaXhlczogYmQxMDhhNDRiYzI5ICht
aWdyYXRpb246IHJhbTogU3dpdGNoIHRvIHJhbSBibG9jayB3cml0ZWJhY2spDQo+DQo+IERvIHlv
dSBwbGFuIHRvIHdvcmsgb24gcWVtdSBpbiB0aGUgZnV0dXJlPyBJZiBzbywgSSBzdWdnZXN0IHlv
dSBnbw0KPiB0aHJvdWdoIHRoaXMgYW5kIHJlcG9zdDoNCg0KSGkgUGV0ZXIsDQogICAgICAgIEkg
cmVzZW50IHRoZSBwYXRjaCB3aXRoIGEgU2lnbmVkLW9mZi1CeTogbGluZSBhbmQgcmViYXNlZCBh
Z2FpbnN0IG1hc3Rlci4NCg0KICAgICAgICBQbGVhc2UgbGV0IG1lIGtub3cgaWYgYW55dGhpbmcg
ZWxzZSBpcyBuZWVkZWQuDQpUaGFua3MsDQogICAgICAgIEJlbg0KDQo=

