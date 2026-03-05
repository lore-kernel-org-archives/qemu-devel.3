Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103E1F47CD7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFpH-0007je-Fs; Thu, 05 Mar 2026 16:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vyFow-0007ak-Ec
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:01:22 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vyFou-0007TT-MF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:01:22 -0500
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 625J0Oap3045062; Thu, 5 Mar 2026 21:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=AQYK64xXqrQTHvsSYVZWXIdMSgrQJiX4tP9vn3s5ntc=; b=
 dMFz+NqWnl3cN0HiZYeJfblKamp4VTC9ZwBzvy2ncRWQDvfouydimoK6fDuBCts5
 6gmFAV52sp8EJMp4aAn9JPdPk6QEKgsUOq8jJNXdcyRIz8i3zNx/alLXnDHN529C
 uTmXSbyh9vNF0vmBcHNSLVqhMcKjT2Ub4kKEiKZ8G0RorhDSEaZh1DvtI7ASIK98
 xPNpjimeuh1HV/H88BN2/XTkGn1q1H4lCKPR2DCBP9H9Rr7jlYyS0BTdSxsCE2F+
 r9VhiCKcho+4K4LeQqBjt3RN9prXSyV6RZEki2HHecG5KMcbleGhL0S9T/6oW2CO
 RpqwIv4kaym/047xMKoiTA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4cmc59y84y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 21:01:15 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 625KuT6V004067; Thu, 5 Mar 2026 16:01:14 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.40])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4cq7tda6qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 16:01:14 -0500 (EST)
Received: from usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 13:01:14 -0800
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 16:01:13 -0500
Received: from BN1PR07CU003.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft
 SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 5 Mar 2026 16:01:13 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by DS1PR17MB7277.namprd17.prod.outlook.com (2603:10b6:8:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 21:01:12 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 21:01:12 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH 13/12 v3] net/tap: check that user tries to define zero
 queues
Thread-Topic: [PATCH 13/12 v3] net/tap: check that user tries to define zero
 queues
Thread-Index: AQHcrNhmvFko/ldCKkK2KLM+wjfZXbWgGOIA
Date: Thu, 5 Mar 2026 21:01:12 +0000
Message-ID: <858385BC-C323-4770-BB84-0C43BEB03CF0@akamai.com>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
 <20260305194329.1470084-1-vsementsov@yandex-team.ru>
In-Reply-To: <20260305194329.1470084-1-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.106.26021521
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|DS1PR17MB7277:EE_
x-ms-office365-filtering-correlation-id: e9453f37-0384-46f6-d8c5-08de7afa554b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: rcfQtQcJqWU/FY/H0JhGQ3zAyqxCqpg3EMGNdXDUwOWKb+N9n5+h2++AH/se/TFrhENaFFAiIAxOYIF9tNIX3aTE2ebZU4krZwiOOvFJeLwKNpS+YgAJMbzsQxb/KMik85dh8Lmp6b3dO/7GhLZVUOr5V3kpOnBvzVNNAJVmQYwWg+OASnpZnZZbxvoQpvTd7/UyStzTCK02PaGyns0uBDZcmKz/xuaPhbCj6Pqnuf8+RZVpU97QGb1tXuqn9LSdNp/ZPNeUT7nRpw6P/uuWOfY3CK27TH+iU0BBZOXuCbu2P14is8LmLviFt3k0pfOtlGeyXEajkei2n3Rh/uDd46VMSy0zC1rOaaNQl9rLY72ecPLpI4PFBUGNLtkHVACLPwFGIe3bS3HdUkWcJNP9EiHIg9uiOxt3lK29AUvoY5AsVM0BXrFfXag7RsuVzZVOpV14nlrLnDh7a2JSd3/IdsZmhjPmUwM4IDldBwSiOblerBRh//a2ATAHRTz57oByWYebK76Vcu3uip3q5IFHgqeJxqgWJOBrmoe6yVuJGdpXKbc8ED0k/bSCfw1VdD6MSVZBw8vvEMNZUMS5ycB7CWxXlLlbk8x+b4/V3qvw+XuXeEe+RWem97/OYrSW9xSQoHCouzFMNEybeGkiTM+V3cHpzb5d73akMop6nuCCLqMOR+UZQFuMLXIvcR9eQ6bDwmF1kL7AhoXoYWpua/mg1q/bE1ku1dqpoCM55aaoRsdvu3FbOPAzdmqK7r4AAjjVYYp5rM+8Ldl9a3BScvE+9WStz9Qn3GVelxIfhpz+6oo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RRTmcwQXNkcDloQnNsV0cxK2VQSzdyWi9qMnMzSXNuOW1QV0tPYnhIYmMy?=
 =?utf-8?B?Nk1GYUR2ZGdxbGhydWJNSTF1OWdsYnBkcnA2bUxEZE5WNnI3cG16VWoweEhR?=
 =?utf-8?B?WEp5bVdJbENnVTFKR2xSekhTUTBQSDVhRkdNWmVOL0ZDWjZaUXo4TTJCR0V0?=
 =?utf-8?B?OXZMQVYzamlQak8zVU1DYVAxTy8zYTlZQVg2VGowUldMSVpWRFJ6L25pWFhO?=
 =?utf-8?B?SEtOcDhUU2tybXU3WmpKbWg4ZExPTGlhNlZ4blJKQnA3azJmRWJPWDZxeUhj?=
 =?utf-8?B?U3h3RGpFV3Vmc2RhWlFJNkhPV1J3MFRpcmR5c1A1c0hGb0V1aC96ejBDYkwz?=
 =?utf-8?B?a29hdnRPZDBwM1ZBYnpwZlU3VDJUa3hlUlhpb3I3a1RrT0xuZGdIVkNZTlpW?=
 =?utf-8?B?V0J6VVdoRVlmSHZIMWJJTzVMYnNVc1p4ODlQU0p3d0c0THBscldCdG1Kc051?=
 =?utf-8?B?S3gxWFgxTFE0MHJRcm9tSDBZcE0rbkU1SzZjNzl1eUFsSWpBWFZKZkkvajdB?=
 =?utf-8?B?aERrSi9JUzJlc2ZLU2ZkR056bVduWXhYQXVFQm1jVitXUVZ0THM3TXdzN0Er?=
 =?utf-8?B?YktzQlQ1RUxIWFgzNlIrUVhEQ21GUEU1VjVKTDdoRDFNeVVlOHhkcVRmMWdO?=
 =?utf-8?B?K1B0MFVRcTRCUll2Umt1SGczMzZtZjB2ejY0dnNOdlFmUHBhMXFUTWxRVGpI?=
 =?utf-8?B?REV2TUJvQ3JnNjI5NlB5aEFFL1ZSLzdibExOcDlkNGJOVE5iVThCU2w5eG4r?=
 =?utf-8?B?dEtGOWFnK2JjM2xkUXRWWjRGWEVKMWlPUnMzeWZKVms5UGswSnd0NGFPZzdl?=
 =?utf-8?B?TnhqdWxQOGdUdVRjQ09xUGdOQm4yUkIyeEtma2dBbDczaFhtcEJNaDE1K05k?=
 =?utf-8?B?ZGJJV3pqa0R2SjEyOS9wWjdSemtxTUx3MkxPWFFkQ3VnS0dEaTdFN3E1WW9j?=
 =?utf-8?B?aG13TzBvNzBmTi94dFdZMVdSU3ZoWlZLeS9SNUM5ZE02blhsRTlydTJpdnZP?=
 =?utf-8?B?MlJtZkdKbWlmNmgzVjJINlFXZFVUZUVnZCtkL0RjSUt2cVZvTkJZU241Ukxw?=
 =?utf-8?B?d1ZsR3hEOXc5UFM2MmdvZXI4TDlubGg2bE5vV1BMNk45QUlacGhBRzFOQ3VB?=
 =?utf-8?B?NkRaNU4vZUdSejBLRUFtTldvMWJ5VWtqYmprVkpabXo1d1Q2VndOVE9LcjRl?=
 =?utf-8?B?KzZRZTNLUmEwNnFHNGtUb0x3aEY5VTFkQnErclZuSVo0cW9XSVJmcjcyaFE5?=
 =?utf-8?B?cFJQdS8xS0YwcFhiU2lKWngyNExjWDAvL1lINk1GOXdqQTU3TkZOcmNPbEhu?=
 =?utf-8?B?Z29EQjBTSGZKNEluaDZ4QTRMZEdNNGs0eHprVlBFTlZ1TUlXclUwalBhRW9C?=
 =?utf-8?B?UC9IYUJ0UTdnTzZuNXBYRGVjUVEzVUp0aEtSVTBuY0JZeDBTeHBrTThiODdT?=
 =?utf-8?B?NnRrSi9XekZXNVBNKzB4RW9obnNEMEZTdDcwZStUTGdTL1RxVklNTDFZRWhN?=
 =?utf-8?B?QnlHSHhhQnV3VnMwdzVrWVlYenVTMDNWT0lRTUQyRCsrdEJ1SnJMSE83dnZI?=
 =?utf-8?B?WFF4ZEJYdXVuczlzWUJSRFlZRmJJQlh6eG83SXIyR3loUkk2ZlpPL05POWpQ?=
 =?utf-8?B?MWFBMjlIYU93aERZeFNEekhkYWMwd1laMGhlKzZqT2J6NjA3MmcrTVM0WDlK?=
 =?utf-8?B?a2tEcDRtMlBKRm0vVVVPWmY0WktkdUdVZlh5eDNISW1DY29Ja2tFdkZvRDJL?=
 =?utf-8?B?SWtOTk8rSlArdWdxTllLNnpNUFA1a3FoNEEwSVkyREIyRllXV2FhNVhsU3NR?=
 =?utf-8?B?eXdnWU9CNjg0Q3AvUEZLZ0w2dUxERjhCSjJ4YnZZMUJpRmtyMW1TcVdPTkUz?=
 =?utf-8?B?UW5yY1pPTlBibzlJdFJ4R09rbUVFRzcrM0s1enJWTVV1OCtxbi9vS0haR3N0?=
 =?utf-8?B?Y2Znc01CQUFRQkNhVFQvWmNja2tpWEUxQUdOaVI1cE00RFRUa0NRcS9UMFM2?=
 =?utf-8?B?N1ZyMVBHQStlTUlIbXNIVTZVaWlrMVlrdnhLcXAvc2FTYXoxYWFEWDVxS01M?=
 =?utf-8?B?cm56WXluQmVvMWtOUGhJSFFRcHFDOXpVclE3TzJ4YVh5eFZFY1JrSHRGekNN?=
 =?utf-8?B?Q2E3U1dlVUZqaDZIY0tMZy9aemRSbGtFQ2w4MFJZTXUzSE1ta3BoR3M0VElZ?=
 =?utf-8?B?TloxS1lkZ1JxQzQzbExuR2xxZXhBNllXVDZzOTZvNDkwc2V4Y3ZpSFlXdlY2?=
 =?utf-8?B?UmVFakY0eFkyZVZ2WG02aEZJamZjK05haXdZbDkvT0RJWXNSUFovYm5OMC9T?=
 =?utf-8?B?Nm9lZ1daV2RtVjJRRWl4VVNaaFB0UmxmVzZBZmNZR3hhUnlTck4rS2JmUytL?=
 =?utf-8?Q?jY/koTQog4oO+9XgrPQFxpPg+TAATsuAVZP4qYSlRelAn?=
x-ms-exchange-antispam-messagedata-1: JavSMO389Ybf5Q==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4oeCFqZHDm2FcTUJF4OJ86fFFGKQ5J0oUL3sFXpmB4UYSMr2hu8QeqiuD8E3/iQ9vXX+12T/V90nFZV4OgZGayTE9gY26PNkwxD47QYt9xyyAV6HSQk5KCbQKIiTGPvLPI3GG65C8G8WXHnbx3T/ny4w/xvaDQ6wUXd27zk6N78Wjzi3CjN9gNe5n+ksAi9N+QkltkQt7lfU2a+Y6WjbP6elXsoo6FxbRlliMZjJu0gqbXK1X4gSpnRrMrH45ez0EO8KZivDuIoN6MVtS1RYt93IRC22IFwzMDOR1dkdNVfvuOZNvKe9fKECCdFyOBn9G8iJqn/y21ivfKj8wJtig==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1SzXC8sBCxRbLLZ+JIjMsox9H6g5xQNeHlDDc14CZM=;
 b=HVBoLPTmLGz5QTHsX6p/+SUqKxJDmaqADnduqShccSIKsqOh541rY+MmNUlTFiPYFjW9+L0gLPIk7L562N0lonK5002Hw9UoDS5KdY73aoj0Z/tEX1x27s3XZlLaWMabsjkTqLj0IBPI2PHoP5lvzNra+XWWHitdPUpuLSnsx3DmsqQwqLVg4HJWhCnfRb7aXv3DMaCL6ec6vY8S/+i5Ksf0LTyhqxMR9io2XHolvgxGFlPGomEvKfvNlJ9HdC3I92w8jZuf69Zbc6bUBt0jHlWJavOGPvZNQ6kAKJ6sB8M5BKCY47egXWhvzVi4uOZijzpp2kXnl6OSguBZh7veTg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: e9453f37-0384-46f6-d8c5-08de7afa554b
x-ms-exchange-crosstenant-originalarrivaltime: 05 Mar 2026 21:01:12.4097 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 0u/XaEVEkvIuMuNYuSqIitgJ37Sb54aKOGG2O4smLq+jVqiXOmwZ7hwS31yARd0o8pnylSkIwdX4wXsVWRZ6BQ==
x-ms-exchange-transport-crosstenantheadersstamped: DS1PR17MB7277
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FFD72FFB28549478A58402D850FE36C@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=645 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2602130000 definitions=main-2603050177
X-Authority-Analysis: v=2.4 cv=dd2NHHXe c=1 sm=1 tr=0 ts=69a9ef1b cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=KDzEjHMMTas96-nIEKpj:22 a=6R7veym_AAAA:8 a=aacuPn0-MhIRLMkQyToA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE3OCBTYWx0ZWRfX5uAK0WcrkvX4
 B4n2Xc71OB6DlvTtb/GHchoT+CsIDZr79qaz4JaqADIdmg3TDG/ABs7QizXDehQDuLl0Of0VKSH
 gStp5XEX3VpFLSqQ0qoD4B6KEPgrt00OCrazTX82x1PhP3HDxl8hk5nvqFG8gDvq/C3hw0bENlx
 8AGB63HEYHVPRWxMBCiZ7Roi1gxsjorHT3rdt44l0/28Q/qclixeZjVEmZhtcr5zHpocotQRaXH
 amNlTgJ47VRAzgD0ugDTgWxWgio81bGwV/FV/nKAiJIpMvzRtxhY3fmHBsTG39dBXApWgDQblqV
 4X1SBMO1wwbsdO3m1f6MLPN5UhLYxSlYulgBjmQyFdxio1OCCSn2Yna0xMoT4LhpKb3zFEwWeai
 nJppKkZz1gEAcZJ1e3+uViYY6xIaNcjUtRakRjesivN2fWfLKnKYnzc2dM7mE5S7uXlu4sNj8i9
 8Achtk7CGBQdIjgkG1A==
X-Proofpoint-GUID: rMHW4y3MvvdwUxarcfUbqDoyutgtVWHQ
X-Proofpoint-ORIG-GUID: rMHW4y3MvvdwUxarcfUbqDoyutgtVWHQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050178
Received-SPF: softfail client-ip=67.231.157.127;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

DQrvu79PbiAzLzUvMjYsIDI6NDMgUE0sICJWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IiA8
dnNlbWVudHNvdkB5YW5kZXgtdGVhbS5ydSA8bWFpbHRvOnZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0u
cnU+PiB3cm90ZToNCg0KDQo+IEFkZCBjaGVjayBmb3IgcXVldWVzIHBhcmFtZXRlciB0byBiZSBu
b24temVybywgYW5kIGZvciBmZC9mZHMNCj4gcGFyYW1ldGVycyB0byBiZSBub24tZW1wdHkuDQoN
Cg0KTEdUTSwgVGhhbmtzIQ0KDQpCZW4NCg0K

