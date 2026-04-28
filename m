Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4CBFF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHn53-0006NG-VT; Tue, 28 Apr 2026 14:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wHn4l-0006Jw-7v
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:22:34 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wHn4j-0003xb-81
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:22:26 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
 by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 63SBjCCE1739802; Tue, 28 Apr 2026 19:22:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=q+UN/koF6hUV+IfXStLyp6nK1JFyz48PWHUUtyLfuqE=; b=
 BC6hJuYStZjkMsE0LYp2CdOFt1ByTKDb9rlOk/cA5RJ75E7UViSFubzK2FCyxyOM
 mpFnPTItLpZBvc+wuDkirtJqp8Oit919ahuTB+/8MXRUR/ZvTpKZqABvawfsV3U3
 jE7vch/0Pl98nqGeTe05JscVx6tqD+6rlknhXYl1l8iFUbfD1wp8GeI7EnD8KjvM
 CnYV8TDh+YyaGaAhUvzxSq5wNGyuMbPA0ju3+zGifWSa53Z/M/KwNV1xCyO3QzZs
 j7uUtf8dYcy8myuIt/CBkJvC5wvjw3XBg1kqyHhwnXVZdfJMo7slg1Qwj+IcOCqq
 +pj71k9rEH+MxW7v+sLORw==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4drnrcq3qh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 19:22:19 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 63SIBsFj007577; Tue, 28 Apr 2026 11:22:18 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.40])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4drukb4tuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 11:22:18 -0700 (PDT)
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 11:22:18 -0700
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 14:22:17 -0400
Received: from BL0PR07CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft
 SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 14:22:17 -0400
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by CO6PR17MB4930.namprd17.prod.outlook.com (2603:10b6:5:35a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 18:22:16 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9846.026; Tue, 28 Apr 2026
 18:22:15 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
CC: "armbru@redhat.com" <armbru@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "raphael.s.norwitz@gmail.com" <raphael.s.norwitz@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com"
 <berrange@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: Re: [PATCH v15 0/8] virtio-net: live-TAP local migration
Thread-Topic: [PATCH v15 0/8] virtio-net: live-TAP local migration
Thread-Index: AQHc0P1htD26Nw42LU6XSUHSX971crX0kteA
Date: Tue, 28 Apr 2026 18:22:15 +0000
Message-ID: <18B4D18F-CE3D-4282-AEEE-98D7EB98EA83@akamai.com>
References: <20260420193846.675844-1-vsementsov@yandex-team.ru>
In-Reply-To: <20260420193846.675844-1-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.108.26041219
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|CO6PR17MB4930:EE_
x-ms-office365-filtering-correlation-id: 39646552-b92b-4d0e-26c0-08dea5531366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: gr5xJf0Ht9wXRTJa4Dtg1mlviIgubpRj82zl2ugUkiNWAylDtqX0I9UEM0gM9w9CmOabkavaZhCAE943M3fAsmD6BOcDLSthrm9q0Ly+ZQtzCQS3kdERwANJaVczkxXHmurD9Ul1pBN/8uFC6QrAAvF1dHvWLN9RqN0z3bEC6847KGserKeV9NWyMRqn92ZRI54k83SkNfxC+LyJD6xSBwu8G0rpdckNqkmqUblFkDd4o4/aCpHsJ9t/IrBUS7Yp3PWDfGtQ5F1gQc1uOc41K99eA7Atqz8mWr+UZ7VweuiOl4q9EM/eQA+KXpERW1XkaIdk+/IKMbVkz5rOPR7VQQf1dHX04S9K2qRS9j8NTPEvIrg5xaQScZCB8yoGcd4639McverKzX5+d7bCbPan/DkQx67QYaCvk/r0eaNXlbpSjJyeVNX3mYzPqdSeoFABQ0Y9BJbn/pemFD17ns/GK+ojJCAeRMlyaa9QrSj760vriCfeVmSuXSPSCh/cPPXnRYwhUbEbGSety1ZJ0l66xwQukHsxr7PI70bPOEW1t1e0zZBdapMzVkOObV70p3f205mZmA+Co6FOdeV5/AM2P69bdLfH5RXmwkPWbP275F9rAKPqHWWnUKVAmKcF0VDypeqC5YFY9RBExmIXhNCmhAn/isrLRG9f1CUL0H6lED8PzoRcVghdioXaH01WDc3MT0BMnaNmQ0BjtxFSg7unTB8vn52CJ3lY0eaqzydoWZE379ENRx1ALHrN8aRIJwGD50mC4mmwfLA3SwS7gPIt36cCs6PB9OLG+UkPduu8h08=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RnM3kxYTZ5cWdUQlp1Nm9GUFlTNWxNQUpvTHM1NndYL2tVTjlHcWRlekdy?=
 =?utf-8?B?N0VqbVhEVWE1WjNEdzRXYjJhOXk0UHdZSHpVVUpYbHkwT2N4WXpoKzNQMkVV?=
 =?utf-8?B?MWFJZWd2Y0RoOXVwbGVrRmJVUVlwdklDR1pPOWkvMnRyZ2VVVmxwTUZFVlhs?=
 =?utf-8?B?ekp5QXlUQkIzTmNVU2JHRjhWTVVpY1RFOXY2d0ZVY3FWeS9kcmR5Y0RkdlBB?=
 =?utf-8?B?RkV1cXFXVURlUTE3aGZvay95M3JDM2NZdGpaeGczOUg2cWYyYjhzSUIrV0ZI?=
 =?utf-8?B?eSs1K0ZYck81UjRCaXlGTldvRVJObUFHNDZSSzNoSDM5a0VvR0tVeXdTL2t4?=
 =?utf-8?B?MFkvdTJSOTNNbnNSZHdHaFl1ODFoWmtxN012WkI5cUhlL1haazhtMkJzU2J6?=
 =?utf-8?B?QkFXcGpObk9LNVpZWUtBT2h3WXh5S1RiMjJ3K3VmV3dRQzAyb0VwRkpoUEhp?=
 =?utf-8?B?VFE0MnJSUW1BNklDR1BJSzdVMW1rRWt1cWZhTjExRW5GQ0k0QU9oSUhXWG44?=
 =?utf-8?B?RTFZbkFJLzZVb2p5Q2p4SjVXVkJ4RlhidTI5SlB5NXZocUhuT3FsdmNPWHc5?=
 =?utf-8?B?a1A3ZU5XNlNGd1IxNEN6eFFVWEZvMHdBaDBFZ1lMYVFIWjVkZnF6ZVdtV1Fx?=
 =?utf-8?B?UUJJMlAvajlDakI2bGowbCtieVlqTEtqOHFjczRjckVKZnkwbkRCU2dmd0M0?=
 =?utf-8?B?RFYvOWloTGhPRkhaMEpRY3I4ZjJDaXhpWFhlUnhoanBIYy8wY3dMdnFPU0lF?=
 =?utf-8?B?azFQcHMrOEw1OUhCU1FWWGtPQ21PQU1Cb3FEVGhEUzk3QmJJYWpKZ0xIaWkz?=
 =?utf-8?B?bVErdzZsNXZHdDRNL2tFQTJyZWJIZzRmTE1BYk56OUs5b0Z4UFA5MjJCUE52?=
 =?utf-8?B?VTdFMDI4TnpXR2FqcUxPOVZrUUFyQTlqQ1pLWnp2aXVUaVpFWkZrZWZ0R3dT?=
 =?utf-8?B?NFlpRWVDS1k4WTNDZmpadFJJcVhZeGNYTU5oLzBvUlhsckxUVi9MdFhLN1M4?=
 =?utf-8?B?RGVTTWpoRXg0RHY4dWFKR3VGMVB6SkZlMXVZeXR5c1hDWCt2S1BPZ2wzVFA2?=
 =?utf-8?B?MDZXL2V0aUw2YUtvSWZoaEN0dmY1ZTJlTk9lK2VtL2ZOdDdrS2RoWkNhMy83?=
 =?utf-8?B?MllPSjRDYnBsdm4rS0g4eFJraVBHNXpZbDNjTDh1ZWRjbnJRQWZob3YrYklB?=
 =?utf-8?B?S1ZYdTY3cnc5QWxsSkloTzBZYTJ3RUtBV3NPcEpwU1JpVzBLamg0WW1MKzZr?=
 =?utf-8?B?bWdaVkJGNGlKNE5YdklRS3RmbjU5NVNCWG1TY1pIY0VYdTBMUUFPOGxMNXhv?=
 =?utf-8?B?TTAzMHlZVnlIREVHVjBLbjlrRHNnb3J2dmFKUHA2Vy9wUjJ2bjY2eXR4K21x?=
 =?utf-8?B?WElPd3lXOElLZWxkdVR3UUs2NThxUUF6YzFXa3U5TUZCK1NYbVBuNzFodXQz?=
 =?utf-8?B?WXc5VzMvN0RDeTcxOHplK0wxaUljSGIzU2QyOUJjeWc4cnNJVGVmeGZKS3JQ?=
 =?utf-8?B?VjVGZXcrQ1dDUUNKaWxrMENMempYcGJ3elpkK3pmMWo5V3pLWm5VUXVpQmpV?=
 =?utf-8?B?M251dFY0eldsN3dYL1FZeG1zVmU2Y0ludnNoQ2tURWxkaW9SbmlETldtYXpq?=
 =?utf-8?B?YXVIdEJMTVhwbHdXc0VWZTBYR0hCcXhTb203RFhlN0hQVUoyUVEySjhHUEsy?=
 =?utf-8?B?TE96QjNGTVlGOXdJcDVHYVhLRHJwLytzdmdHUzVZaCs0ZGhDWjBxd3VpaXVa?=
 =?utf-8?B?VkErR0N1UWhqUGZWTVNQSXJHc2h2Rlk1TENib0Qwd0huQS83KzkxaUt0OTYr?=
 =?utf-8?B?K2VYRWN0U2l0bE1iOGNtcGxBLysrMC95djc4RzdGcUE5dUFBTkQrcHhSM1E0?=
 =?utf-8?B?QURPNXN2QmRSKzUzQml1dldCYVNBeDBOanZZeTBoK05vcmVYZDlTWkpGTzVI?=
 =?utf-8?B?YVpteXV2NTBycElLSHdYcVpWVmNkaFNEZlJVM3BwNlVraEQyR01FblJ2TlU1?=
 =?utf-8?B?VW5iV3pzL1VIR2huUEtwUVJMQlFzejE2RFRIU1YvVk9ib3oxVERpRzVrYjJa?=
 =?utf-8?B?YVNvNWhoMXF3c0RzOGJsMGFLclpDT2xNQU5SUkVSUmVLTXZsZ244aFFma0dM?=
 =?utf-8?B?NlJkcU9rUHNzWmF6QnFoVW5Cb0dHa3RFcDBMNStWZU5nL3VXbXliNEpVRi94?=
 =?utf-8?B?RnNxVXVJTzc2TEVJRVEyRnVQMHBYN3puNlpHdTM0TlJ3THNEQ2ptdEdDZnk0?=
 =?utf-8?B?MlVocUR1VkE5ZS9aTDlMNUtGNm9DUDArUmQ2WVdKUStqV3ZjRVh2QXU4UzhU?=
 =?utf-8?B?OEtiUi90d3BIaTlycVZ2TDR6TlBXOVorUFM3eEE3d0QyUXBteDEyQT09?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNkrNUwJu4gYeIcPB41pMszIZOMzvW0L05xPO2Uw02OSUXu+K4y/pCg3qlmGF57olgL7SwEsBi3335mCEbjzqKtPc9Y2wd09sHG7N8gMPKxLhjbKJXgsO6TR4BBQWpWzUzJYxI1VDCnd8OXfYjOwNyU11xb2TAXEhGTNNQTUSaqYpGwC8EAyg+igSe1OFBQPq7fqtct493jFjN6oMtRuppEnBb22qg7a2U7owaQOdTt/HHArJtI/I+xAeVvkUQzqotAGDrJfYQ68ykyZpb81FuTh2Dcp4nG2k9i3wavuVj3nwKaaUh7Jtk4kHCftgkZ8YXaOM9maCHR29UspvA7QFA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ylpb96onTz0VRWvxTuOLo0WAg7/4fsdmkdUcyd7URDw=;
 b=km3+xlEhVEtlxOzdDb5h89x7SXJrM11DM23KjWNXmW6TPnfha8uoUJw/u8AcK/ZwgVESRKkJdY9bSAsH4mKPgxeNmKTeyhP+cLQ3x6obIY2VCAQpewgeM6fVBHbARZd9q5yZQ48GJYANjNUNoAo+5f9pHqDfapTQIUUl2SaB2rMnApjrXgyphDCbLxDIRGA0g7NVGwmjo3TiBgGCT+6OqbHm9VujdwmHfxNP9dz8JRjGVyBKsk4VsN+kqynnosOTbR+SqII3rpYqBvu7Cp7+376W0RqNBRca4FQ0f9ISuj/Bks3UpuiCyHWWMJnqd30zIGvg542ancDxQFeHIhZ94w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: NNYsizMGCLebu9bu3SOqD+ywtJBkrzufK/Gh62xJ6/f2FsPj4sLg8wJZClGAk6cvPBxRnLejQMGglx2UNogOuj7goMS5Y0t5wGxs95XXH7xXVpGhDchc2PVUd//Cbr4T0tUUtbssBotR4Vh0yTtSf/ik0poAKj6mrVHVSvjYZoYQ9D4czMxv4x71yQg3R2V7rLu0BKBXPv4A+QTFSAnCE7dvAYYqW/qrr294r12zsj1+KOUSiXt1+IYS6jvFHUkfkdS89wZ+KD27yafcc5pmHxhqGiRN6IjgIa1eLyktt4CZknwPKPbmfclGub1mPUV6bf6kaliYnhZoGh6YhuMbCw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 39646552-b92b-4d0e-26c0-08dea5531366
x-ms-exchange-crosstenant-originalarrivaltime: 28 Apr 2026 18:22:15.9070 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: ZEljevFUyOWtqxp4ieJmtDCrPYddQR7P2dJwNqMypb0rEcZ2vuz19VVLRpCoK1pDnPt5yKO2JDgN88C+CPAZfw==
x-ms-exchange-transport-crosstenantheadersstamped: CO6PR17MB4930
Content-Type: text/plain; charset="utf-8"
Content-ID: <909B4BE24C6186448AFB29F07D3A3969@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=676
 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604280176
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3OCBTYWx0ZWRfXyw1VMV8XS56x
 X64PPBgLf1ayMmwlczmDu8Oku32vv5qzZUv8Ahkxec7pfIbZiDxVynUTu8m6MdP/UovekqjuauP
 YfksJtj52rD3VDZWZUIUg1Gu+Ct5soGI8zqoSqbuMsXprRZPWYsWqXQt/WppRwZR8kmgq54RMPO
 0sC5la8QIpxE6nDiwlRyjEpwSwBlSDbh4NmhKxNwPdtQrFlHYjSojHd27qhgNVXlrIFrzeyZjSI
 ZaknYqQxB1osudUiEUiIAdZBQMtdUKONv9C48ZZ0KbfFYxsm4Z8pnS308ALrwvNF7JMkKzvY1+K
 QVFFLDwX20g0XNDWgFWRm6c5q568eWq/kgYkN6vzwabao0Hv0zL2I8MK55aC+e7t5JP8Ugp3C/k
 0QlUEpQ1TU3m1fpqAOtO8+GUaX4roWpSgIal3n62ApaCWFIJ4ozmTg5HHlleyEsbkUkjhuqQyiS
 Y3ILUxDp91+LFImo52Q==
X-Proofpoint-GUID: djEaD-aiFqX66FNAw3P3nik9--lLl3hs
X-Proofpoint-ORIG-GUID: djEaD-aiFqX66FNAw3P3nik9--lLl3hs
X-Authority-Analysis: v=2.4 cv=fdCdDUQF c=1 sm=1 tr=0 ts=69f0fadb cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=d4nn1RXdvEacMIURMw2s:22 a=6R7veym_AAAA:8 a=X7Ea-ya5AAAA:8
 a=JAu020AAf4nROT3hdigA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280178
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
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

DQoNCu+7v09uIDQvMjAvMjYsIDM6MzkgUE0sICJWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IiA8dnNlbWVudHNvdkB5YW5kZXgtdGVhbS5ydSA8bWFpbHRvOnZzZW1lbnRzb3ZAeWFuZGV4LXRl
YW0ucnU+PiB3cm90ZToNCg0KPiBIZXJlIGlzIGEgbmV3IG1pZ3JhdGlvbiBwYXJhbWV0ZXIgImxv
Y2FsIiwgd2hpY2ggYWxsb3dzIHRvDQo+IGVuYWJsZSBsb2NhbCBtaWdyYXRpb24gb2YgVEFQIHZp
cnRpby1uZXQgYmFja2VuZCAoYW5kIG1heWJlIG90aGVyDQo+IGRldmljZXMgYW5kIGJhY2tlbmRz
IGluIGZ1dHVyZSksIGluY2x1ZGluZyBpdHMgcHJvcGVydGllcyBhbmQgb3Blbg0KPiBmZHMuDQoN
ClJldmlld2VkLWJ5OiBCZW4gQ2hhbmV5IDxiY2hhbmV5QGFrYW1haS5jb20+DQoNCg==

