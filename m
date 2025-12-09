Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7843D3B98E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 18:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT2aF-0007YL-PL; Tue, 09 Dec 2025 13:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vT2aB-0007Y4-QN
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:37:09 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vT2a9-0007Uw-KL
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:37:07 -0500
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B9HlD4g2696633; Tue, 9 Dec 2025 18:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=6H/0HJxWcrDiFPMywjUwYMrPLOKks1PgezH06X8+k+c=; b=
 TbYoxTI+TjNVJM6N5YaeRPclEeQZPDRLVdpX11uzeCeCEY/vabPkRw/hQsxHBUhk
 yx02vzDCkbllYA3RWzUuOKLZGj/cfi2lZh4QpEfJgcCRubv/u2vQMdPUWWQ/f/aQ
 7NyllQYAqxsv9v/W22tdsifPzcwhphkDNoF63p7sDO/JteQrBEltZvfER5UL2wiw
 nIdlUh4UU951DT1Y+8S3Mqof50o4dH73qzJbc+HcMYpJRmcoZ2jaztHME7mcugLv
 6dSu7djWwVPvRDjiPiXbFPJHHTolxRWQLivTPMI7DoCRh7TKZRL0Oqk5l+PlxMHC
 z/OqTNJjY4lmLP23U1ar8A==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4axkh9v7t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Dec 2025 18:37:02 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B9FgZ6V009828; Tue, 9 Dec 2025 13:37:02 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4avgq1hxsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Dec 2025 13:37:02 -0500
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 10:37:01 -0800
Received: from PH0PR07CU006.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 9 Dec 2025 10:37:01 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by MW4PR17MB5532.namprd17.prod.outlook.com (2603:10b6:303:127::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 18:36:59 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%5]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 18:36:59 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Michael S.
 Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Weil
 <sw@weilnetz.de>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan
 <hamza.khan@nutanix.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 0/8] Live update: tap and vhost
Thread-Topic: [PATCH v3 0/8] Live update: tap and vhost
Thread-Index: AQHcZIXV5dbTT97LcEKDcr0t/f76ELUXjBUAgAHMqIA=
Date: Tue, 9 Dec 2025 18:36:59 +0000
Message-ID: <0F1BA1E2-E356-47A2-BC11-BED6DFFBA44A@akamai.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <1728acb2-e098-490d-b37d-7455679ee3ba@redhat.com>
In-Reply-To: <1728acb2-e098-490d-b37d-7455679ee3ba@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|MW4PR17MB5532:EE_
x-ms-office365-filtering-correlation-id: dc2b22c8-111e-4fe1-d3ca-08de3751f052
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UXFiekZNUVBCOVNZVC9ISUJROE9GR0JablVNS3dBc1NxRVlodENVM1NCL2Vk?=
 =?utf-8?B?NUlydktRYm0wc2wvZFByLy9JbTBseGVwaGY3ekdTNkdzQ1dPanAxUTNvRmk5?=
 =?utf-8?B?VTRJbGR1WjRJdSttTjFWMTBHYWZOdUMrS09wV1JtSC9uMVg0UWI2b2lNWkNl?=
 =?utf-8?B?RU8veFdmZVo2bk5rTC9MZENmNE5NdWxxQlMveC9WazJzSTAxRFlEN0pUZEp3?=
 =?utf-8?B?d0txR2E2RE1wYitZUTdwd25icUlmTm1mMS9wNHEzQzhVdGR6L0JiNkU4T0ps?=
 =?utf-8?B?RGZLSURWV3lnUVdOS1Q1RXJNRjlvMlBkSnBDanFLRFUvL29selIycStQeTZF?=
 =?utf-8?B?YjZLbE84MU9lKyt1SEQ1L1NBakhFVnFWWE5oYW9jQnRsMVNBU3JTbW9MdXVQ?=
 =?utf-8?B?RjAzYkFoLzNQWlk5bnNzUlhSQ3o3RS9HVWNGaTZROVBwN0dJbm5YUEpqdWRO?=
 =?utf-8?B?RXBFMzdoRVhZQlh0T2U5WU1YNkNHcnJEWnNYNFQ0NGN0QzVackdNN25rNGF4?=
 =?utf-8?B?Qkk1Q3liTFpnSDcrZnFTTUhuTC85SE5uZVpxQldSYVBOMVBCR0k5STZmVzVa?=
 =?utf-8?B?dmozZHZ3WkwvbTVZTEd1ZklKL0Rrem1KNXRjMG54TE1lNThSNy92WFVkUC9R?=
 =?utf-8?B?OGZ2OGFkVGJlcC9zT2VFd1JtR0htdDFGb3U3aGV3bjdWM0FxQW5QMDliVi9u?=
 =?utf-8?B?akNwZ0EzUC9lRFlWMkNodTNxSlZlRE9wOURGSFhBZXppREJsSktERVdreVMr?=
 =?utf-8?B?ZWVMNnJrTjF5SW0rb0tsakwzOERSQnVYQlNNaHVsUUZmVmh1TWpEVmoxOHZl?=
 =?utf-8?B?aXZzenkydzNOcmZVaU9nTkRiTnIzOU1pY1Riam9Ua3hMeS8rME9ia3I3QkE5?=
 =?utf-8?B?ZlFVRHdHTnVkcWtGcFpLR0VGUnczOUxaNkk4ZVIyeW5uaXFWVzVTN05YMWNN?=
 =?utf-8?B?L2U5N1llQTBXaUxYVVRHT29NQUVhbC9kVnV5WnlZTGFDUDNTdERKK0V2blR5?=
 =?utf-8?B?NHk0K2p2ZEhIM0Mza0p4L2dvdlBML2tpQm9jV2lZOHkzaHNkeXllTmRSZGkz?=
 =?utf-8?B?WFlhNFdreVRsVUY0UkczSDFEVHU2WXFzUmplYzFhQWJWaDNoVVB3azh6REpi?=
 =?utf-8?B?Zk5ONFNJbS9hOGFBcjhqZC9YL3hycW9WN09HeVBPN2xDeU9OeUhPeGpRNmt2?=
 =?utf-8?B?dGExcndQV3h3L1NtaStMcndleCtwQlpBMDJ5REN1Z2ZEZ2FhUHFLbHJjeCtW?=
 =?utf-8?B?MmhsMi83NGZRM29OakJxV2ZEY256L1hMYmtyUktOOGRLUnBZRXZxVjZJVnNr?=
 =?utf-8?B?K1FaZmlJYlFLYkJkM0RWd29LRFMvQ25oUERWb0FzUVhVRktSM09LcU5DVWVu?=
 =?utf-8?B?c1E0NmNOOGw4TFNJQWRNbk9ibHNSSW1RcWM0N2lUQm5BNkJSRTc4dW5kL251?=
 =?utf-8?B?Q2dMYWY0WXlzRU1qQndFeEtsMXY5ODFJTmR0RXBpdVg0SFRXRTFocUxRTTVk?=
 =?utf-8?B?b1J1SGVNRG5sM3BZMGMyTGFQSWFHcldLVE5TVXRnbmhDZy9SL3c0akJBWHN5?=
 =?utf-8?B?QlhkcVVTVlpCNjVGV2VaKy9hcUl4enFMVUdVVjBjSlg0dU55dEhxVjJKU0FW?=
 =?utf-8?B?dDJlcXBFT2I5aWJ3WEw3R29TaXo5N0JhZ0E3cFFFSVIzSkRJL2toUGxCeW1L?=
 =?utf-8?B?MTc4YjJ0TGVCQk5vRmhNbktuNEFndTV6R1FZRE5SYlhiMVp5Z2RlalBkY2cz?=
 =?utf-8?B?QSsyNHl2VGtEbmIrWGpMenQxbWQ1THVLZG9oRFlBTEsydDhlZGpLTnErcGZL?=
 =?utf-8?B?VXV5aENVSk50NzZ4eVM2b3pkMUNiZTZuS2ZYWEE1aDNBTEpKNjROZ3Jvci9n?=
 =?utf-8?B?ZVd6UjhNd3k4QUoyRnNuQUcrMTBxUDY3LzdXM1psNTA4SXRHSGVad0FTQmp5?=
 =?utf-8?B?WTdOVDF0dlZ6UkdwTWk3MzdRR2xnUEowNmZFZERmcWNUbmxCczJrV2tURy9E?=
 =?utf-8?B?WjFDajFSRVlUeUxMaVgyWVNHTm9FSHFiVHJNUjNBRGI4WEFUY2lzalFYNHM0?=
 =?utf-8?Q?hDHLJJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0xsWnJ4eW5ncVVUbkczU3o4cGF5K1ZqM2dFczdtMXJuOEZvRncvanhMcEp2?=
 =?utf-8?B?UUtwTG8xV1hnK013ckJab3cwTlhMMDFDT1hJMGhxaWVKd3hXSFkvcVF5eFdM?=
 =?utf-8?B?aGhDMFdXQ0ZJV3lwQXhocERtMVZhTCtqYUoxYjdSUjVWd1NBSm8vT3Vvbzdh?=
 =?utf-8?B?MmpUa0s0ajZoaWN1UFFjMFVpZlQ1bHM3TzNVMk4xY2pCK29PeHQ4TTJsOGxo?=
 =?utf-8?B?TmlpM3Z3VkplbXZBY3BzWUMyVnR4Zm9DdERhbXM1VEZPc3ZMSlc2blFXck0x?=
 =?utf-8?B?N3NQZm5PUTloRkgvL2JKem5SMUo1eWtJc21DT3ZqcklxLzBWR1dDaFg5c0pi?=
 =?utf-8?B?WDIxamZGL2FYb2thOW93OHdtVXpFazNnUTIyb054RnhLOXlsT0tPZ1BrOWdi?=
 =?utf-8?B?RHIvaGxhN1VKejRPNVZGcUdVS2RhczNKbi9vRmFLRDd2NjRZZ0g2WlU5VGoy?=
 =?utf-8?B?SzhPVW55dFJZb3BWVzFvT2YwYnJ1VHh0VnlxWnhYSkZjNjFJSEkvYk9sb3JB?=
 =?utf-8?B?eTZRdmpSS1E0dkZvVkdMNDFXQVVLaGpacGpNTmRuUmg4c0c4aVY4d3FxTVps?=
 =?utf-8?B?Tmc3ME1PMmFadXMwZXJBL3JGR2g2elZoVEtzVmZYclJUT0dWcmpVU0x1ajZ0?=
 =?utf-8?B?UTBTZGpSZlFGakdjak81VTEzVDJnNzVkSU9iTEd0aW54SXVIdGgwMDhaT0k3?=
 =?utf-8?B?a0hndWNHeHNaaUxxWWVBNmpRUkRpcUpZMWtxU1JOd2xnVmhnZ1pvcWFWNW41?=
 =?utf-8?B?RzBBYkk4ZUxOQUJTcVhRMjg5RlVGTGhqNHgrNm1uRTJPZFBSMXAzNVBNZUNk?=
 =?utf-8?B?Y0s5Y0JDQXZkNi9oMlJGRnlsekdmdmpTZ29WMHB1S1NwUjE1NE1hU3hFTHdB?=
 =?utf-8?B?Y3BKSUg4VEJJVU16WTNCRUw2SmRwWHpKMURacXplWFdZN3dRQm94UmZvV1E3?=
 =?utf-8?B?aXh2U09WVXVzOHROKzJrOUFGbFRqdUdFdHJvcndsYlUwMU9zNGxXYWdSSFpo?=
 =?utf-8?B?M1RjR1k1ejFBK2tTWGhSR3hwZkVnMnlwZmptekU1eUNZaE84bWVhR2g4d1dJ?=
 =?utf-8?B?MnI0NzRnUWhPQXJ2WTNpV0pZdzhNNUNTZFVKWFBnaldHRzZPQThxYmdZaXJU?=
 =?utf-8?B?QXp5UTM0N2dObWV0WmNRWlhIWStWQ0hBOUhXV3VTQTc3R1NUSWlkYTlxTEtx?=
 =?utf-8?B?KzVWMDdwQmQ2MnJ4Wi9LQlVqbGl3WWIzeFA3KzBVYzUweUpWOGtpTzd0RENN?=
 =?utf-8?B?b2RMYVlueHF1Q3lrTFdiL25TMlQvZ1h6UnB2MjFmU040U3YzRDBtU3VVYmkw?=
 =?utf-8?B?N29KaFdrNk15bEFEcWgrZHRKeVZUWVBjNm5Zbm55SW1yb2h1UisvMlkzSnpZ?=
 =?utf-8?B?QXExb1NsRGF3SlJmdWpCM1BFVEFLRkFOM0ZKdWJuVEs3RjBxc0JoU095cjU4?=
 =?utf-8?B?Vm1aRm0vZklIVFdySm1OdTZPQUt3RC9CdFQ0ZkRpVElzNDRYdHdjbldSTzl2?=
 =?utf-8?B?aDdhTE1mMGlDQ1docWU2RjlwdURjMHNFWlZFa1JqeHlWY3BFWkhhY0pnVGNF?=
 =?utf-8?B?TTZOZmxiQmVtdFV5ak4wQ2NhYk9zL3l4VHVteXFGWU9iVUJ5QUJDOU5DK1Ry?=
 =?utf-8?B?THpOcnRLdUVhUTZVQW9BSnVicU9NNGY1TVR5M3ZsRHQ1cVpLZFhWWjZqZlZM?=
 =?utf-8?B?UGc0TDRnWHhIUDkvQnovRW1XRE84SVZtZlJIdE1iQi9wdS9rZGhhd1k3Nklz?=
 =?utf-8?B?c0t6QzVtWlV6M3o4ekF6QXN6WXVxK2RPVmdoZk5NT200WkJFd2g5cE43b2c0?=
 =?utf-8?B?K2h4NWc0NjhtcVYvcGJVa1Z0RWp6T2hCTVJSelZTS0FnM3JOQTFXY0E2VEZw?=
 =?utf-8?B?MGdJQnFLUGtLZnVWL3B4MkhiMjQyRVpvcUpuK0o5N3ZqRnpONFFvR2pES3Fj?=
 =?utf-8?B?ejk2dEh4VDBsanU4dXdiMG9QQjhaVlpMNGNja2xuMUxPNm9lK3plYVFselVn?=
 =?utf-8?B?eGI0MnZxcjREdnlBRzFkMkxFTU9FUkJLdk1QWVg0S0hrVkNudzlzTHdtdnA5?=
 =?utf-8?B?WURyaVQxQXlBWTcxUXVleXBubHdydXhkZ092RTVYOFVBUDlDWGxpeHgxOHhF?=
 =?utf-8?B?eUpUNloxT3A0WGhwR0pEc2x6SjEzTC9vZkUwMlViVzdlbDU5SXRrNHZHbU54?=
 =?utf-8?B?NGdtZnpJeEQrTmdORllsZFZLNldmdC85WGZpNWJuVlZEc0t6dEh1V21DanZ2?=
 =?utf-8?B?L25FbG5aZ1ZuTExyUjA0cDN1d3VRPT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNI6OoLHsadkU3nhOhTTElAjtA1FdJTsgLz0Ezd5/oh3csQfDX0s1fSXER0TKOvv0vL6EeuChsrUEz5eztoANb698SoYXCgf/rsr8C8HnbnNXIwts3I5OVyiUu9i0qW15y4KgHeOE81YArr5e7ygwrTSqm1mGE22Ba4yqhZ+Ii0GM8jm/2ODgfrnSzVnRrml5LqjrojX+7oIHDDchHZM7Lm03oEfClrI3Blr0Xfdbir1lxPEduXDcIw5bn0YIwc2b5bGBeXScv/tcC1ylxQtxpEsMgGuBuUuTMhawY8lE1x8Qmst8zPTVrgMkYslIdLNgxj5BBOqvpUXtijeEdvKLg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zUm1xNS9wDh1Mv/F8/w5ItpiJUJP2GUw7jmXbID4/U=;
 b=ARlU1VkaWXYtPhI/WZG1F8VpxA5NPRUVlHYGgORaEZH/Bk+NG5fT+aJBfM9xYyIopexDo9o9GP+NKoXMOqLOuLbkXhnvCcZGjfUot5GdO1q54OJ15k8D/el4mxqJ2JMDD53R7CMhpt1SQVLSmxO2RYgsc2vfns5d29e6LO8CuGedx4s7gXHQoaz9odh8LBFU95M3V4/1d6dS1d3ZXjHyZXECbB4lxEW0BzwrqSE1haHacgCLls9MgF9uX70jOHOQs8B1AtmcrQeH34WpzYAIyeYU8vs4mmN45ytjAiYBaf7sNS/YUlX/9psqFo5OBtf3srgZpQKRk3p2rHM94seNFA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zUm1xNS9wDh1Mv/F8/w5ItpiJUJP2GUw7jmXbID4/U=;
 b=akci6JemCG4dztpF3PBvTm2NgknzDIkLcW1ZSLXlICahERcJZKO+xcsa2yvzSv+Nh5HgcJMpJHJ17tsSSFNzJm6t6QoyMwE4/E3KAFeEQdhsCRBO2C3fOtgUYKq0/gF7u66XZC3iTS9Z6/uNske95iKVeWw0N3b1T/ECcdVILQE=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: dc2b22c8-111e-4fe1-d3ca-08de3751f052
x-ms-exchange-crosstenant-originalarrivaltime: 09 Dec 2025 18:36:59.6579 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: J4g/q1Hb8Vub/Svy0CMJ4HRXNKSG85SLmxbqfMFaZQndo1eKUutWlF1lflWwiBRJukrunYZjUYs+C2+c9YlymA==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR17MB5532
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <293347529E4693469053C062BB9A7B18@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=907
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512090140
X-Proofpoint-GUID: gdaWzHaaPFRuZX9E4y3sKaMfFpaa8PkB
X-Proofpoint-ORIG-GUID: gdaWzHaaPFRuZX9E4y3sKaMfFpaa8PkB
X-Authority-Analysis: v=2.4 cv=He0ZjyE8 c=1 sm=1 tr=0 ts=69386c4e cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jHVmVgdK5ojzxEy_FbcA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDEzOSBTYWx0ZWRfX3AAUJhKKnOA3
 TEwEQVzVOs+C6+cnBylVrhlqkWrGNXlfEjBeqxOGXMk53DQsr5p8Ckjf079UBXK/YB9dRa9zrcS
 NteGv4bdjgTcCdNBT5reBiEITazuhpGSVQiiDIL7JQZl/n0VlF4EDt1jOtpKWUVvgHOQem8jogj
 NTNlbaFu5WC24TPNpxUUPW1vGXKfJRDFzZKVbu9C5mYGwKgHi0eyXVxXzR/DBcI3mIk2PCaOeMw
 2BXocbl4gt7YkreTsIygSkF14utd0zPheSCHj7luiKyu6+IL+7y8g1WGmsiOClGztTh/6eTbeKI
 aJPAbbDv3Q3O3wP6dAJbAXd4I20EfYEMwcTbKXSIz/OgCibw1ZchIl5Yjdl9Zv70xXx/5orZWne
 3uI4W2a7+T+MzlfVuIO4wNMZpX1HLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090139
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQo+IFNpbmNlIFN0ZXZlIHJldGlyZWQsIHdlIGhhdmUgZ2VuZXJpYyBuYW1lcyB1bmRlciB0aGUg
IkNoZWNrUG9pbnQgYW5kDQo+IFJlc3RhcnQgKENQUikiIGVudHJ5IGluIE1BSU5UQUlORVJTLiBX
b3VsZCB5b3UgYmUgd2lsbGluZyB0byBzdGVwIGZvcndhcmQNCj4gYXMgUmV2aWV3ZXJzL01haW50
YWluZXJzID8NCg0KDQo+IEFsc28sIGRvIHlvdSBoYXZlIGEgZ2l0bGFiIGFjY291bnQgc28gd2Ug
Y2FuIGNvcHkgeW91IG9uIGFueSByZXBvcnRlZA0KPiBpc3N1ZXMgWzFdID8NCg0KSSBzZW5kIGEg
cGF0Y2ggYWRkaW5nIG1lIGFuZCBNYXJrIGFzIHJldmlld2VycyBmb3IgQ1BSLg0KDQpNeSBnaXRs
YWIgdXNlcm5hbWUgaXMgYmVuY2hhbmV5DQoNClRoYW5rcywNCiAgICAgICAgQmVuDQoNCg0K

