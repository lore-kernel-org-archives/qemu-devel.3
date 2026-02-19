Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096D1E9A057
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt8ks-0000ok-61; Thu, 19 Feb 2026 13:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vt8km-0000o9-Ol
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:27:57 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vt8ki-0007Y0-3D
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:27:54 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 61JH4PZw2336928; Thu, 19 Feb 2026 18:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=oDL5w03TwmASLf+HQvO6kKAxzHwEOfsDHFNS4PcHqGs=; b=
 cCfISkSx8Gj8xVO6TrfaNf63IrGb9X0gW1JaiO6a0U9FyW1sGEeLMqQITOdKoqz6
 XG8/AA9zJnOEjMmY6k7AS3v4MGFxBMTm6UA3rfcNxS+WktZpDvlMJSpBIX78/4sN
 CCkYxm8hArgj5wJM2fWkFdbJ2UMS/N0e0UCrMtfK7SUi+a1559FKvp7uKpIJnyP2
 3hxoowCk+atWNM2tt5gVZDL7u7y27O2bG4oZRg4VUoBJUUeIJ2j/dL08r6btCod2
 ewUuS0YXOiQ8ToXJO6IZ8ivHoAbjOVMt9qTZfGHHa37vNPPoCX9lwrEZ9gVE8qxF
 LQb+XasbIGH0zRZW01uvjg==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4cdgkd9xmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 18:27:49 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 61JIIjaQ017382; Thu, 19 Feb 2026 13:27:48 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4cdgj60m70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 13:27:48 -0500 (EST)
Received: from ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Feb 2026 10:27:47 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Feb 2026 10:27:47 -0800
Received: from DM2PR0701CU001.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 19 Feb 2026 12:27:47 -0600
Received: from SJ0PR17MB4301.namprd17.prod.outlook.com (2603:10b6:a03:29a::20)
 by DM4PR17MB6389.namprd17.prod.outlook.com (2603:10b6:8:103::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 18:27:45 +0000
Received: from SJ0PR17MB4301.namprd17.prod.outlook.com
 ([fe80::8159:aa6f:8ecf:11f]) by SJ0PR17MB4301.namprd17.prod.outlook.com
 ([fe80::8159:aa6f:8ecf:11f%2]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 18:27:45 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v3 09/12] net/tap: move fds parameters handling to
 separate functions
Thread-Topic: [PATCH v3 09/12] net/tap: move fds parameters handling to
 separate functions
Thread-Index: AQHcoRVV1VxYfO0y6UK+vTh3XKDqHrWJ7JKAgABnSQD//7EJAA==
Date: Thu, 19 Feb 2026 18:27:45 +0000
Message-ID: <B4B91407-B42B-4496-8FCD-8AA08B3FC24B@akamai.com>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
 <20260218202829.1322088-10-vsementsov@yandex-team.ru>
 <881F7D8C-E65F-4629-8AE4-68CA9BFCEFB4@akamai.com>
 <22e274b0-564c-476b-8b8e-b0f6b634fa99@yandex-team.ru>
In-Reply-To: <22e274b0-564c-476b-8b8e-b0f6b634fa99@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4301:EE_|DM4PR17MB6389:EE_
x-ms-office365-filtering-correlation-id: a379ab41-2588-4f22-6933-08de6fe493b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Rzhwdk1PNi9wckkwcFVQTGtOVkVaUDhUTkVQMldKYkVRSzB4VEx1Y25tamhO?=
 =?utf-8?B?Q0xXc3lqemxUYTRleXN2OWljOG1INU16b25yK3NMaGZUWUlMRk1hTkFLWG9p?=
 =?utf-8?B?eGFOcEQ3c2VDSHBubUtkNWZQUW1CVS81OUQyTXR5c1FjRXBsd0hzV3E4a3lE?=
 =?utf-8?B?UC9tUldDYnR4ZWZFaVhnOWRaVytQVXhraWRGcXdCWXVPQi9NZGFkSEtnTFNk?=
 =?utf-8?B?cUFldHl0UG5oNWllY1RVNXRZNHVYOWxjbFZ4eW94UUFkRFdCUExaMkxwRFh4?=
 =?utf-8?B?Wkh1RlQwdkhvR3p4OWFHVjAxMEdTaWx6ZWwyV1hCMVd4Qkozd2IxZjJXbWhm?=
 =?utf-8?B?dzhWU2JNekpmenBGV1lLOVBYanA2TU8xc2UwSkM5SFlJSVFKMXdGUnBWeTFs?=
 =?utf-8?B?Sy9wckc2NURBV3ZhWmJ3RlFvUzh0KzU3TXZ1aHVhZDlsVURJQTJaWTdCelZp?=
 =?utf-8?B?bXM2S2lVWGg0UHJ4VUg2VFg5eXZIb0l3WlU4R2NqZCtBaU5sOFMrMi9Pb29x?=
 =?utf-8?B?MjQ5UlBsNzBIdzZFOHdrQUUxZnUxdlg1WXpBc3BBZ3J0Tno0RWs0NDZsclls?=
 =?utf-8?B?SHFvdGVTLzhrczhJNDhzNUlJZzBuNnBjb2ZrRHdZV3JKRDNNWllRN2l3aEpD?=
 =?utf-8?B?eHEzUlUydkl4aHFjN0VoN2dFUWowMmZ2ZXBEZmhIN3p1QmRWNGZ3NUUxY3do?=
 =?utf-8?B?VEcyYWdTRTRkUzNIeGRWWjJkV1lCK1lONS82YmYwUnR4bldicGROQkdOOUND?=
 =?utf-8?B?STh2MkpkS2ZGdFhyaTIxWkxiZFhpM3dRK3U3MnJEWmx0TDlJT2FOaGk1UW5z?=
 =?utf-8?B?SHJHM01lL2pmYVV1bXI5NTFWeEcxTkh4OG4vT3B6TnRmV3dmU0wvakk2VmpE?=
 =?utf-8?B?ZGRaemJSZWQ4T0ZIUDlNSkxOMmVVb1RkZ05xbWVvK1dSaS92eTdOd09sT1pp?=
 =?utf-8?B?Y1ZacnB2a3BEeE1Xb0J1RHBCQkRVQ1g0VUZEbzdlcjFRb203YlVFTTJLTVN1?=
 =?utf-8?B?SlFXL2VSVWVXOEE0OGU1dzduTXZQcWwyWkVmU1owVTdlWHlTei9ObnFzOFUz?=
 =?utf-8?B?N1hRN3dXWGI0NEJWRUprb2cvYmJvRE9DKy9JMktYNUJBVTlVL3p2NkZGd2Zs?=
 =?utf-8?B?TXU5Z251a2pFTlFFRy92R0N4R1RzS1JodnBmZGFVZnlWYS9tZi8weVF0TFBT?=
 =?utf-8?B?M2NIU2ppd2ZEdFoyT0RRQ0pVWUxvMjI4THNBbDFDL2NObmdDQ3Z1aFJncGdU?=
 =?utf-8?B?dmhjY0RhRFRWdTlyZG4yWmxsRXlGeXJ5cFVZMEVrK1pxRGN4V29xSkR1Wk1U?=
 =?utf-8?B?dCt3SVBzTk41SCtaaDd0aE5IajJBTW5nbVA5aU5reWdORVpjdmo3UjRUQ0Zn?=
 =?utf-8?B?TkJ4UGpkaGx1Q3pxQzJmVDg4SkdLekJHeSt2UFduckpReUJhNWYxV2I2TVdj?=
 =?utf-8?B?R09VTjJCLy9zMHE1aUdpSEh5ZGRXa1hXYkk4UzYyZlRRVE0xWjdhUUQ4Mzg5?=
 =?utf-8?B?T25ZRlZaUXpWcEcvK0tIdnlkVS9hVzNvZktQWThwVmVnbzk5SnY2SzZOV0ti?=
 =?utf-8?B?T3lpSWdBY2hLSDE2dkE0MDV1VUZzY2luL0VGY2JoaDZNT1hUTVBhaVpyQXBv?=
 =?utf-8?B?QTJRREJPNitwSDYyKzBpdXhHMjYrdWRIMElKdUErNUE5d3l0SlBXaWNaMVU5?=
 =?utf-8?B?L1dEeCtZeFlOdWdUd242Y3Q3V1hIV2ZCeW1qcFZiM3ZnZEZGZGdWM01EMnAv?=
 =?utf-8?B?WDRnZTN1dDBCL2ZqbTczczVGUHhiOElBMEZleEljR0dxZmQ1RHBCM3YzVUFz?=
 =?utf-8?B?emhxMUlrUUxPTnUyNVpPMnNhL1JWWHl0c1hQSHQyYzREWWNFa3dFVDh2b29z?=
 =?utf-8?B?VmtYbWIzRDZiaU9sbkJKS2xTRDg1cVZBUmNaZ3F4NGNJRmZlQ2VRNnc2UlVl?=
 =?utf-8?B?WVViWjFubmdkSGI3NC9SVWFiTzcrNEpCT1RyMWI5d0t6MUhGM3U0THZCelZW?=
 =?utf-8?B?R1JFZDJCK1NOTFRWOEJ6Z3FhNUNteUdwTUs0Uys3MzhGWVJDWGJUUXVQN0lV?=
 =?utf-8?B?K3N4K1RjV3VpMTdUcUJXUGp6ZlgvaFNrclVHM2doRG5LOVNCbHNnUUFhZWFZ?=
 =?utf-8?B?TVpsaUNrOHp2WW9ZeTh5SWFqM2FlK2pPbXNKcVdEMFVTTmk1RkJobFFtSFJo?=
 =?utf-8?Q?hjCPkD7fONAX0qO0xZROw1Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB4301.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHFOWHRNYUwvVFd1N2RWekJHbXpObFoxUkQ0aVg3SXdLZ2ZGT3piUGhyN2lK?=
 =?utf-8?B?dXoyVzBodUYvZ2RZQyt3Z2xmYjZ5L2lpUVRxQVc4NldKY2E3OUVpUWg5SURJ?=
 =?utf-8?B?dEpxQnFjaEhaZHpqRWtHQXFMRmR5dWROYjZRUVNoMTZHRUtEM2RnUk5pWVBm?=
 =?utf-8?B?cjlBTmdPQmxiR1hNRFJWUGV5K2haWStlTWVod29ldEFINTZOV3FBMU5oOUpV?=
 =?utf-8?B?cWlWTTRYTXZxTWVwNi9OSjZsSnQ0VXhUdXlDLy85WFM5UDhRT3JlTTNjdlFl?=
 =?utf-8?B?Yk4vLzY3NEtmTnZHcnUrQWNxbVg0U2R2bjhrMnFZM2JhVExIeWlrMGZFY2I0?=
 =?utf-8?B?dU5vS0I1RmtrazVxbmx5dE1NOFdFNG9yb0ZUYW5ZRWpmOWtmd1hYQWxxSjRW?=
 =?utf-8?B?M3Q4VHgrRXJZcXc5b2lzSUxzY2I0eHR3ZUhhdm5wc0dPNk1xbjkyU1N2UjFB?=
 =?utf-8?B?WWMrdjY0Z2JkdmxxMWR1ZEFBelhURXBVU1R0U2J5eXFkQXlvNkNnRUVRMVFj?=
 =?utf-8?B?ZTRxUXlnZXZxRUxVcEs3U0JjVjk2YkRjZTR0bThVdW5TMmVZdWRPbVNXS2lW?=
 =?utf-8?B?OXFjdXArWWc4ekZaRHg1Tm9IZjNNSGd0ekFQQUFCSHNtek9JRjNoVEs3K3hT?=
 =?utf-8?B?ZFdSZktkaGF6TzlpSW81QWRqcU5RK0s0andQVVQvMm0zMEVRS2E1RmJPaFFn?=
 =?utf-8?B?a1hXOEZUN3phSEVPam1zSTdEZTBuaTVjVUZ4Z3NPY2RMazc1YkZVUUZxZzhh?=
 =?utf-8?B?VGduK2c0ZmNQeUduZmhTV3pYM24xcXhNV1Nma21qR3ZFRjJqQ3U0RWJpenMx?=
 =?utf-8?B?WmhLaHZoejhsQU9zM25NUTdUTktlcFk5cUNoQWVDbHRaQmxKOUkrcW5vTEpL?=
 =?utf-8?B?bXdPQmxkSmtqbDFFcXN5a1pBZkxMTVFZa05SRFZQeEk0dWN0aFFiTncyRDR4?=
 =?utf-8?B?VHN6T2g4aGpNZjhqQzBjSm5kRVVPQXBzYlRLOGZWTjRmb25WWERYdXNkaUN2?=
 =?utf-8?B?UG9leGluMzFRanNRVTUxcEVnREhLRFFnN3UvR0FqS0RCbERqNHVBbysrYkw5?=
 =?utf-8?B?cWdIRHZuYzhmWWZLT3ZRaXVKYXdjU04ybUlyaDFacmppdGt3b3NKYXNnOUJB?=
 =?utf-8?B?TlNXZ0JOWFVSVXV6SXpQd0gvOUdOWEVpL09FQ0xhUi9ib0Nvbk9MVUVPTDNj?=
 =?utf-8?B?TStnTk0zWFVXaVIxVVFtdVdaQ3lCenRMN1JJMFZNTWYzOCtrTG5HRzlLT1I0?=
 =?utf-8?B?Rjc5Zk1NRHJJT0FVaGpBQTY5dEVzc3Y3NEdFWWxvelg1NEdrd1kzckt6b2U1?=
 =?utf-8?B?T29hWVI4TkNHNC8zTUVoQ3FzdmIvdEZWamFHR2lxSTk5MG04TzNuVmV6VzRp?=
 =?utf-8?B?UlFHVlZ4ZS9LZ0NZVStrSGFHaFo2QVcvWS9WQ3hoQzFVVVlQMjB3YnIvL1Vw?=
 =?utf-8?B?ZlZrSmZQa1BvR2haazlYVkh4S1VzU2NHdTZPNDhhYTRCSmdJdlZyeTkxQ2U2?=
 =?utf-8?B?VzBGZlZRdWllRFpscU9HZ1NINnlLQURQZzhJYVRPMWVRZWQ5T2dFWWZmdkpI?=
 =?utf-8?B?VXA4R0FwL2FrZFNtQ0l1Qmt6b3VKWEllV2VsUys2Z2FlckxxLzJyNnllZVQx?=
 =?utf-8?B?Z0RveUJaaFlDTDFRRW53bUlqVU1oWjNNNUcxM2pvYzJHWVZwdGVjTWVrd2lG?=
 =?utf-8?B?bXRpNFRvSGxTaEFDZGhQWU5ib0srenI0QkZxM29zUzAzZERoTEpodWlYOWNS?=
 =?utf-8?B?VjhiWGFoRVE4ZmY3c09ScFpDUXF3cUZzM2NRbHFNSkNJaTdpSWZvREgvSWps?=
 =?utf-8?B?UVlteVBYZ0pBOTZLcUJoemVEallLSkZzNjh5K2c3dnljenRlbTBDUDNhMGVB?=
 =?utf-8?B?eHBoMVVmMk0rSFB5Q2wxb3BjVzgzaVYzT01WTi8rSmM2UEtzVXlQZmVMeUNt?=
 =?utf-8?B?a3hMeG1LNTNqOG5ETGtlSHN6NXIyait2aDY0VG5oelhTM3JPK3YzZHZ3Tzcx?=
 =?utf-8?B?R0NqVjJwVjJoMnI5cGs5cG5CdlJNcFNic1RoOGNBV0hYQ0hyZmRBU2U3V3Vv?=
 =?utf-8?B?dnJwWlB2eHNzZXZYellwRVo2aW9lQThZV2tqWU1RUWtUZG12SU5GVDAySGJ0?=
 =?utf-8?B?bXBvYWFkTytSMXFRNDlWZklXeGM0Rjk5ZHBET2ZuMTJiZ3pibTd1aGVzcC9m?=
 =?utf-8?B?VnNyMWprdEZRb2RvS2RubmxGa1huNW9lMmFTcHdTOFdjeFZuOUd3bkRwMFdy?=
 =?utf-8?B?TFVKeU5RVFlHWmt4N1lvME9oMyt5V2JzRk1PYXFRT1Z5KzBueUFHNnhoeEYx?=
 =?utf-8?B?RmE4azZ3dkgrVHE0UWRzL29Fa0tjbnhvdDNqM25VQ0lqNkp0RFd3Vm0wcVVB?=
 =?utf-8?Q?BViOsfMkBcfwR7oiPAASwIKvqGAMhN+TODAFfGng0c9Tr?=
x-ms-exchange-antispam-messagedata-1: 84b2IoOXHNQUGA==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORxBJuBAZOS9lIcrCJ5nlZ/tW74XJlsasmgnkRG/zddy/TQf/uc17pJY7mW8Xrl378/eTmRCEUbdQnM4sPifGgg2IsEgspgT1FM0p3SxgWQl6meZvQCrd5CAth8DpNZqhTSEt5pLvYJAstM0bUnL1Im7A9MEz2U/zD66Knw+7dudZoS730Spy5Hm6+cXjP6pDd7rlLCYeASk+mrGUzpuOKqP9Z76XRj2y9IXo8Vax/sIsFXAZQA6F8f2Rhf/rxRMLXLzQwXzEXRjto1qu/aMvnXTah9RbJHwCFtMpux3NVWrx0cWsUak4rO7X7aqVJfTJS8H+UGyMwc/YgDTud1yLg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a6u8vwhDcQzxjNMk182vvpgnIE7g4CGMEFhp6W36s8=;
 b=urqYlORBEZJBDtG4/Xl7CFSy6ZWx7g0FGs81jmF9KesQ09lp3+U9G6vhfPtquGbmXUU0q3qQgljnErHG/NLYj9hIIZrWhJuovZ3mveZhRQDCIv1sD5t39H7S+CWwQskLeLS+Mgo9u0r070uNhnaVLHIMYVWUvk2NH/s8kbDsOlgceUaygP2zpA7VMM8DTZbYw8zptKTz/hiQ/73dsJpM9y6/mlj1lpocQi+YiaQqlNCUI+DdGjkBHnaIw640DwOkTyxhyEhwXPbv8necQZH2LtUAXCxdFxqqYvqLOvI739Llwee3MVPA4RR9Tmeqz2Y80wHx771YbfVZ8CJ4WXEQrQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SJ0PR17MB4301.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: a379ab41-2588-4f22-6933-08de6fe493b0
x-ms-exchange-crosstenant-originalarrivaltime: 19 Feb 2026 18:27:45.3670 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: WGq/pg3jyTflIglobbAHABFR9umle4lUIKlxV9HSyWYh2Zk7xbBAFXJ39BbaMx7AFwb4aDqdlBW9PZMEZqh3ug==
x-ms-exchange-transport-crosstenantheadersstamped: DM4PR17MB6389
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D61B03B4B8FF5429C1341407132040D@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=982
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2602130000 definitions=main-2602190166
X-Authority-Analysis: v=2.4 cv=OfmVzxTY c=1 sm=1 tr=0 ts=69975625 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=6R7veym_AAAA:8 a=tYGNeyUUtiQ98AY3NAUA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: UyV6qami7JoENuAlw-lAp-ptC1fkqYst
X-Proofpoint-ORIG-GUID: UyV6qami7JoENuAlw-lAp-ptC1fkqYst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE2NyBTYWx0ZWRfXynjVRdRvwmlA
 pDMkKD/HCoxj3iH7119rfulzufxMUIyVinG+Ku86wxD1pJxqKRWFxZdkFKCyF9xgSDLj0Ru9+80
 RSYrVkM6T+7BDDL2piG7XlpKVbE/A7ZAgfT1M3ndedUWYakXpFV9zEKiog73PKOQ+pYglI4vad8
 AW2k2QSISPpJ463BKn01VSyXYMIzhFI9YLxkBZ91uTCpvoibSYZLMieQMwh+YrngXfjFq0dQwhY
 lddbKAxnMFVuRC8kzEPSYWfX+TxW+kuDY1bfJ2QMXY28Pi09a2aFM5WOEs5uK1p4OQTO2xFWOuz
 Cj4V4eAWecfR7q86kZhZYXYRQz+nS0QlypqSppAVM5cKHgORVMnyPYQ7wg8BcqaUr89C9470TMX
 6xcRceUhLBkTAhz6Fhay9PcRezjGzVgnYQ54TUwZMrR6Df6/VQZ0V/74R0W8Thok2ykZxs6VFTn
 xKyBvvZISggSsaZtbgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190167
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCu+7v09uIDIvMTkvMjYsIDE6MTAgUE0sICJWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IiA8dnNlbWVudHNvdkB5YW5kZXgtdGVhbS5ydSA8bWFpbHRvOnZzZW1lbnRzb3ZAeWFuZGV4LXRl
YW0ucnU+PiB3cm90ZToNCg0KPk9uIDE5LjAyLjI2IDIwOjAwLCBDaGFuZXksIEJlbiB3cm90ZToN
Cj4+DQo+PiBPbiAyLzE4LzI2LCAzOjI5IFBNLCAiVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSIgPHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50c292QHlhbmRleC10
ZWFtLnJ1PiA8bWFpbHRvOnZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50
c292QHlhbmRleC10ZWFtLnJ1Pj4+IHdyb3RlOg0KPj4NCj4+PiArIHF1ZXVlcyA9IHRhcF9wYXJz
ZV9mZHNfYW5kX3F1ZXVlcyh0YXAsICZmZHMsIGVycnApOw0KPj4+ICsgaWYgKHF1ZXVlcyA8IDAp
IHsNCj4+PiArIHJldHVybiAtMTsNCj4+PiArIH0NCj4+PiArDQo+Pg0KPj4gQXJlIHdlIGFwcHJv
cHJpYXRlbHkgdmFsaWRhdGluZyB0aGF0IHF1ZXVlcyAhPSAwPw0KPj4gSSBiZWxpZXZlIHdlIG5l
ZWQgdG8gdGhyb3cgYW4gZXJyb3IgaW4gdGhhdCBjYXNlLg0KPj4NCj4gQWdyZWUuIEknbGwgYWRk
IHRoZSBjaGVjayBpbnRvIHRhcF9wYXJzZV9mZHNfYW5kX3F1ZXVlcygpLg0KDQpUaGF0IHNvdW5k
cyBnb29kLiBZb3UgbWF5IG5lZWQgYSBzaW1pbGFyIGNoZWNrIGluIG5ldF9wYXJzZV9mZHMgdG8N
CnRocm93IGFuIGVycm9yIG9uIGFuIGVtcHR5IGZkIGxpc3QsIHdoaWNoIHdvdWxkIHJlc3VsdCBx
dWV1ZXMgPSAwDQp0aHJvdWdoIGEgZGlmZmVyZW50IG1lY2hhbmlzbS4NCg0KVGhhbmtzLA0KICAg
ICAgICBCZW4NCg0K

