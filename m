Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14F7E8305E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 19:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnMMX-0002I6-QN; Tue, 03 Feb 2026 14:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnMMO-0002HS-NL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:46:55 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnMML-0000oV-5a
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:46:52 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 6135gCWk381584; Tue, 3 Feb 2026 19:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=HPXZusNFDmFvhxhG1LVwOLqvUHu00ybQEaqTjS57v+8=; b=
 BVOA+jJUp9sfQcqNJ34f7n/HZsVLvqWGEmUjsjNZBPWWBzlVd/C3qMwk2uK1VFC4
 r6D4VcTzPVnr0uonhzzPk29OGhbaQzT0hue7hUoN1vHDCsvisA2+JSaRTye9xUzU
 CjMYiy8h6M/WfJNsR48wZMHno+9y0oDYK9FLvVwHoVZh1Rpux+0KLz2dg4qIX5mN
 ieXMnumWSApztyOHieFT1uI8rSeVKTevfuZ8EYMW/8EwpE9N+c3n4AEocyUf/oZY
 ArSU0x3vav0HeCHWq00EhMo54tcEmEQVTd8ds2XafsiDKt81iuJee+lkoJ+IGGYw
 2HjhWwjTs1eBOl0o4V1whw==
Received: from prod-mail-ppoint4
 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be
 forged))
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4c1uxrfem9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 19:46:46 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
 by prod-mail-ppoint4.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 613IX8R1013873; Tue, 3 Feb 2026 14:46:45 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
 by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 4c1dy3fkuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 14:46:45 -0500
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 11:46:45 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 3 Feb 2026 13:46:45 -0600
Received: from DM2PR0701CU001.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 3 Feb 2026 13:46:44 -0600
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by DM4PR17MB6039.namprd17.prod.outlook.com (2603:10b6:8:8b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 19:46:43 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 19:46:43 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Mark Kanda <mark.kanda@oracle.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan
 <hamza.khan@nutanix.com>, "Hunt, Joshua" <johunt@akamai.com>, "Tottenham,
 Max" <mtottenh@akamai.com>
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
Thread-Topic: [PATCH v4 0/8] Live update: tap and vhost
Thread-Index: AQHckJZEtI/bI5eMI02lYSB4PqSw1LVpLZKAgAZLnID//8bugIABhasAgACcl4D//7RIgA==
Date: Tue, 3 Feb 2026 19:46:43 +0000
Message-ID: <111AAAA6-1E4E-4341-99B8-011980080F74@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
 <aYCvexnciB7THTkr@x1.local> <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
 <38db7222-bf35-43d4-9ab9-52810c9727e9@yandex-team.ru>
 <aYJJ17xU2iQmk5sQ@x1.local>
In-Reply-To: <aYJJ17xU2iQmk5sQ@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mark.kanda@oracle.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|DM4PR17MB6039:EE_
x-ms-office365-filtering-correlation-id: 550bca30-0a1c-404b-3d78-08de635cf540
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cVBMdnE3NHQ2c3VCZlZ0SWY0MDZZTFJ3ODhCYmo2c2lsRGF3MkRoRkxYNzBx?=
 =?utf-8?B?TlQxbmZpWVlxOFA0Y3Q4VmNJblNPMjhqOG9BTmZWTFZjNkRXc0hFWFJVNjlV?=
 =?utf-8?B?ZUdGblNSYTdhdGZZSGNVbWp4UGNmWEFVN1h5ZVRtOWdZb2dWYnRpaTlnVkQx?=
 =?utf-8?B?MVdMUzFSekpkYkhDeDZKRE1SSFJBZlNqTXlRbGZGNkZUcXd4ODdVZHZyQWNE?=
 =?utf-8?B?elpmdm8vdTdGSDhSVFFFNmVNSzNPWGZqTkRvN3RLQUxKeVlrRU4rU2NxcXZ4?=
 =?utf-8?B?cmcwQ21SU3pGam1JNDJmN0tlcmFNTGFMOWpxaWtNWVVkYmJiM1BpS3l6Y1lx?=
 =?utf-8?B?K0xCdmY5RXFpV3Z1STZCNkIvelNweks3UzB6bzNid28wNGJJcWFLdjU4VUx6?=
 =?utf-8?B?UGp4YWM3QytscHJ6S3p2UE5WcU5kNC9JMnpGWjFTMWJhOS9LUytMNVZLbm5I?=
 =?utf-8?B?QmVEY2dYSWxKZVNWelVDZGZyMGh1MmFsbDZLck1HQ2MzTktIcENHOVVjaGxa?=
 =?utf-8?B?YXBhSm1hT1VNbnVQNTE1Zmd0NFV4T05qQ0xmTExxYm5XR0U1RTE1WnVHL3ZM?=
 =?utf-8?B?L0NMc1hldldzRklRN25GdW5rZXJLREJyOXd5ay9ja0RLaVJCbXNkZWJ5Tjl3?=
 =?utf-8?B?NWVwM3RjL3ZQVWM1OTR0b000RFZJOWhJMlZ5OFJSQ3R4Z0taRHlTTEE1a2pw?=
 =?utf-8?B?OVY3NzQyRFJpMWMxajBFU2dSRnRGOFRiR05xWXJ2ak9WSC9sWHhIOXc4azU3?=
 =?utf-8?B?Uzd3R1FXUnloZzNUOGxpbFNMN2wzODNKWGRWMGJjWkQ5NlF2UjJHNHlIQ3g1?=
 =?utf-8?B?WTVOR3o5cTdVY0tWMHBZN0JFbTF5K09GaFE2U3ZFUzF5d2VOWC9mN2JQL2lq?=
 =?utf-8?B?QlQ4ZzZ3Q0FmdzI5Z09jdUUxWGNpQm1JNlRXcU9BVkpNWU5pUHFPWXNQZWRp?=
 =?utf-8?B?WVM4eGNsQjNQVGtwVkY1dm02VWdsejBIUXRyUGpaNEhuT0lWMFZKY2gzbnM3?=
 =?utf-8?B?QkdudWVMN3pNblJKSCtqUmg3LzhObk9STU5qMHNjZXlwblFDRzg5Q2RRU0Yx?=
 =?utf-8?B?UmpHZFArRnp0UTErdkhKZnlTMC9KZFl4TWF2RGJNVm42SzE0N2N5SDZMNWZu?=
 =?utf-8?B?THRHanlLSU1UTzFSMkhMVGo5MjRQU2xBN1A0OHJsbnVxNjNMRnloQy95OUxO?=
 =?utf-8?B?RU5DcHd6RUxZYTZWTnlVUkZYVGQzQTlMaHl0dVpVenlLYi93NEtWUTJ0dGhH?=
 =?utf-8?B?NldFS3Q2ejdocjF4b3V2ZnJmdC9nSXppWHVwZ0RYUEx4UlU3eERRZWZiTGF0?=
 =?utf-8?B?VnVZeGo4R3JXdTVyQ2QydU11dmdWdmg0SVJNVnRKM1pwOFZHbXNQdFdnZ0tH?=
 =?utf-8?B?cWpMOG9vaUk0bi96R2xqRTErajNTYk14SkZuaWx0VG9rT2hOK1NyQnNtR2NY?=
 =?utf-8?B?d0pYeHArcjBkMWs1M3Y3UHd6ano0eWxyTDNvRld1WkVtVXMwN0xCOUxTaEVs?=
 =?utf-8?B?MWpEUUFNUHdlbWhYWDdmTW1ZOFUxbENEM2F3Wk1qYkFiaUZWL1lmV2ZOd2py?=
 =?utf-8?B?LzJhQ1VoSHNlOUZDUUZDNjRUalljdDRBczlpTUtFV25MVFZsYUVrT0lVWmtU?=
 =?utf-8?B?aWV4aVZ0Q1RVSm0rcEczTExER1JScW9nMkt2UHd5NUtrT2EzSmw4dWtlSnBO?=
 =?utf-8?B?OVdZUlgwYTc3TXh6UmFTRXhvOFNRTGdqK0hhS3JTbi9GKy95bWEzV216Yjlx?=
 =?utf-8?B?aDBLTHludEszVnNwQ3BEV0Q0V1JjUDM4dUppRnFZRTNVL0gvdkZ4VHpOOUor?=
 =?utf-8?B?R2NVclhPbndvbDNWSEs2OFc2WGVSWWdDamxJNWZTRVNQazRhNFd5eFRYdzlF?=
 =?utf-8?B?UHNuT2RvMTY1OEJycU5TNG9NenlQY2lSSVNTZWJTNW9XZUtXU3BENE5JL01W?=
 =?utf-8?B?eXF6VmJWbGMyVmVQYjA3TGtEbFBSZEFWRHB2Z0k5bUVjaE0yMWxjVkJBalRq?=
 =?utf-8?B?T0NOdDNRZ0F6SXNmcEd0MGlvZGJSV2JmZFlqNkhkUFE5eGFZODhHNkJ1UlZI?=
 =?utf-8?B?aWVFdnRCTnJUeHBuM2NKS0c4ZzU4YXF4d1hvV29tREhsQURuZFhQcmtnUmln?=
 =?utf-8?B?WUpGRG5lSzY1bkJCM1BnM3pWWUoxdm5GczlweWVHWGZ3VWMrUUlOaVRTaEVJ?=
 =?utf-8?Q?GpyW2DZ0TWrKGBPqRnYR13c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUh4cVpRWndQd2tCbExnSUtMOElMSlVhTVRvd3dQL05PeVZUby9INlpiL2hV?=
 =?utf-8?B?T3F2M3ptQUxVUUhHanJ5TWt5Mnl6NTlTOXpzcGdGRExUZjV0cG56cXl1VU1H?=
 =?utf-8?B?NllNRFlsMVR3NEJYamxteWdvT0l2RlJvdWFaT2phQStVQUE2YWRBTmZsOGlv?=
 =?utf-8?B?L29QTDNWTG5obVhBUTYyTFYvanpwdzduQWdGcEV5YlNpcHNPLzgrK3pMZzBG?=
 =?utf-8?B?Umo4SDdJQ2dMaVhIYUV3NnFGdFRpaUcvQ01NYVZLMnkyR0VzVm9CdzU5WVli?=
 =?utf-8?B?RHRBaW1taUs5QVJzQnRqK2tmWFduY0pxNVBOdHV2U2RObFlDMm9naXM2VVFk?=
 =?utf-8?B?V25JakZHV1pYblFuRGpSVWRUWWpRa1ZDT1hkaENremM1cGRPcXFCcjJKcVpL?=
 =?utf-8?B?bGZDUEVuRDNqTUJMeDY1c2JpMDZvc2hUa1UyYUxVc2VXZzhTSndGOE16RExh?=
 =?utf-8?B?amRZNGxxV3pDNkozR2o3VVo0WXVHUmVLTUZQWkpBYlhKM0UyZWE2TlR0WVNG?=
 =?utf-8?B?TmZNMHVGSDZid29GTEx3ZlhzSldmaWtmejBrOHVkWkVyZDlYTVYrTjA1V0li?=
 =?utf-8?B?azRDcjI2c2ZzQWlWSFFBcHVpd0tHeWJydkNWcjFkaEREMS9YVnRqVVAreXJq?=
 =?utf-8?B?S040bXFJRjc3a1dwODY0RWZ2c1kxWHVVQm1SRkxJN1l1WS8wazd5Wmt3NDNh?=
 =?utf-8?B?VDFrUFIvVGZyTXprVFlxamJ6YzNzR1UyT0FZTlVGSG9SSWYrVmV2M1hNOXVJ?=
 =?utf-8?B?N0xaSzVnTU5jTElNQkx1WU1BQVZaMUQrZDBaU21yNnlLT0VpZUZLajdzYXY5?=
 =?utf-8?B?MmRUT2g0czI4V1Bva09zOWdKRDl5MlpZWU9OZmJEOTJPZ3VTN1ZhRnhraTdl?=
 =?utf-8?B?QmRBSTVpQTNzWXRBYWlaWUR3cktYOXF0RUhiQXRlOGNjNUZBd3FPc2lzN1Ev?=
 =?utf-8?B?Nk5HWXNJN0FTVHNnTkJqMmxtZ1FaTG5lUFJTZDV1aDR2VmpEOU5oQWEreEgy?=
 =?utf-8?B?ZHJrb2hTNitabU5zQUkvc0w1Z3puOGRTbG1KalJkb1pxSzlhMS82NjFXYUxD?=
 =?utf-8?B?SjA2aEdGU3hGNmNwbFdZcjNSU2poQmQxcXR2QmNjZituOHdaOXNtTzNJSWY4?=
 =?utf-8?B?MUZMKzU2cnRNWkZxTUJ4YXExNEwrQ2ZWaUszd2t1bCt4Z0F4VittR29aRHcw?=
 =?utf-8?B?aVg3cHVwNUVqN3NJZk9ReFdXaUNjQ2c3MHpEcmp2WlBXL213ZWg3Z0ZPQ0c2?=
 =?utf-8?B?c0JzV3lCYlRhRm5Gd1RMNWwrWjZpbzNzeGdiSE9pWHBSSzl3MkNFNXlZNUY2?=
 =?utf-8?B?UStaa0pqd3NDUEtSU0tHbUp6Zzloa2RtSEVwQVZyRVBaSHQrS2E4bWZlK1dO?=
 =?utf-8?B?Zm9vL3RWYVUrZ0lwTEZQV1JYNTduNnMrUjZOTGpKcUZ3MkphUWdqWW5TbVdZ?=
 =?utf-8?B?b3hzUmdmRnhxdllNWUsyVEVlQ0M0V2w3cXVRMU42cFVCZlFIcjVxQ0FBbk9Y?=
 =?utf-8?B?bEt1QjU0OHlHQzR4M0FOb3gvQXlyQUNteDZ3VGIxdW9NQ3c5cDE2NDZnU3h4?=
 =?utf-8?B?RWUydFVOanRoZSszSnhSS2oyaGpDbXNJV24yYm9rdXk1RzVmT2kxekgrM2ZX?=
 =?utf-8?B?dzJTMzh2VkJxaGF0WngwMCtObGVhT1lyUXhTajR2V1hESEkraHZLSGtZM2ho?=
 =?utf-8?B?Y1hNMWpWT1pqaUNrZ0hYL0dhL1IvWnZnbWo4TlpTVEVzdzVYYWU1YmE1NGJx?=
 =?utf-8?B?WDRwc1F4bFRKUWtmb2VXMmdvTlY4MHcwK2dVbmZXS3NhdEpmUDRmelhubGky?=
 =?utf-8?B?bUwyMUdBR3FGRnRKUHNrY2V5UEw2aWlOT2hwRVNYVFJzNVhOMVVuSUZxOEFP?=
 =?utf-8?B?WVdSMTVHMnc1Q2tMZDdrbXllOUpyVVVGRkNxVDBWV2dFc1doWUtVeEZyZWVO?=
 =?utf-8?B?TC9yU2F1dnBKZ0hOT295Z1l1OGM3eFJoS1RraGFHbEVidmpEMlg0T2hETi9T?=
 =?utf-8?B?eDlPTS94ZUwxLytlZzZ5a2NlMTlFS0pmSUtzUWNTVVRlekVzdkMzd3VCZHVD?=
 =?utf-8?B?YWZlckJzaXB6WDJ4dGxSaTZlWnZmUWtLVjRiWElJOC93MFJxZVdaWG45U0lS?=
 =?utf-8?B?SzV2QUE1UzVWTUN4RVFxVTlYWHJlK09TTmtpWUZhSjB3cXROT3FtdWUyVUZZ?=
 =?utf-8?B?TWwzOTRXcGUra3d3UW9mbTVud1hHc3VHK3ZyNmZFZ2hrdW54S2JPbmZwQTdl?=
 =?utf-8?B?ajNFWmpNSGlQTVk2OEU5NnB0bVphQ1Q0elZ2T09lL3FKSkZXUlVtT1Z6b3FJ?=
 =?utf-8?B?TVVrRk9ra3cxR1BoeGVjYzNlOW42Wng4SjdVNGd1a0xzMVQ1SFJ1RXRLcVZZ?=
 =?utf-8?Q?P3oBAFpXXa1sG7aL9TwphvOhaO8nCqNcGV/arRlhEwV0o?=
x-ms-exchange-antispam-messagedata-1: TTf7pwvCqjqwBA==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLpU7rO2mTQg3cvpJG93TJBfpNOBp7ISnW0N8PZhIzPe90s8iZvjuFysIIK43jtJgexGTiYxt4d3pxqI0R+53c0c9FtPs0Fg4BXw4UEFVuhbKG2/F18bgIxO72jcdAtIOGee2HDyedZ12jtdd9Jokfi0I4lOXeKd8HkKujiYQfPhc31QYBISmtmOuQ5OPkX361B3T6Ow5Hs5p6lk++/yh2MhLwVM7dPM4xtyr7Q7DPAJJJECjTlHfRQc5AX5BUJQ8+3KGXFrn6hgps4bND3trHHGeF4NoFr++cJJb9aCifynRJLqK406vmttZtpRGtu1CnhvV6F9K6CpKxnL4W63AQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgBbfVO/Xa0/zr619Se12Ce4y7jjp97nvI/sg8WPvSc=;
 b=KBil8VVjxKCZkOuKP8tqsrfsXF7v5WqNHUvFD6l8gdWjs47iSuZNHtcuBzPAnfT0KWLyF+tYLzk7BBR4ij1EoaW9GBENce/ixKrx5/0dCYnDFb40nhGnx8qyX6wud5csvzECKgeXU/Ml01WLqvKLKm37KG1PAGgostQmF5hprRzK7fzhkCJTh+cF+HqphqF/6bnXzWNDTMiheTCuFvmOGqsjaJ7UNYvzjh2elTmw3gFiLEQM9pDNr/6jzCXE6x67r04o2murpHDDNgnfgxq1AlAoF4KPoLLQueu8cYzf95LDr2FhBZ59/iAhUW0CDKDjJW+k0LEQsl14a7SqTLSf0Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgBbfVO/Xa0/zr619Se12Ce4y7jjp97nvI/sg8WPvSc=;
 b=OmCdmGE7eTN+JHijgX2zFlxKcRhgJzsWTL2JFSYws3YA85pSeKQlC6nW7DKQ3JsocVkg4G7/5CO291HbWJyhyRa6JZB09bpp4nVnfo+4ExvpVHirDiRxWw/jdhrzsmJwCYkFWZjp4n7CQ7+R7k0zjOvh9FcPeWFVT1t0rszx2l4=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 550bca30-0a1c-404b-3d78-08de635cf540
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2026 19:46:43.5794 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: UOk3EnHSnAaqsg0xUW2a0mjiQ5C91R9MHqBlWYKJutYccg4thz3ITF9iid1tCQMOXV2cWzyfWk4YjWk7Dqk57A==
x-ms-exchange-transport-crosstenantheadersstamped: DM4PR17MB6039
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FE6CA4C0DD71C4380F9F266714592DD@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030155
X-Proofpoint-ORIG-GUID: WSaAo1_lNvpRAfpfU88BMBSkcL6ze31L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE1NyBTYWx0ZWRfX6BapG+PXZx5s
 JKcQ/mP/XvgdiNq7G/06/jOHcVmcPyMCAmHMaCNSwnpRdEUne9g1xLAjBqGvfHVyJXhEEWefU1V
 zFCbdX2EYGO26gxlu/xDmpVD1nxGuSZuX6eC5DHUPru6BPvVRQ1ZJtYX58sJLX/aNYB7ZhGzeIP
 52mWgHnWZrJVTSTVCiGHsY9Vg1rKWDk1BV1HNg0v6E6+C7guvVDVWP7Idmh6UdVWqMHy1Wdi7DQ
 D4+RbByFqB0kMkjCGhv9UtWknaVfw3VSC1eb9ofq2iyvVQeWWDJgtVAt1V0aEqe4rF/LhDv4Wez
 iRTznTd6NPTlOwrROCiMRvW2jPty/KcX7daoDwpKegXjfcC/m8TP7n7GN7GdL7ULT0FF7EbBgfh
 MKyg6D6SCv81U2gxzxIOBSceLHhdGE9dwWAuJCO48DFOE40K/Ms6MkU+pX3o4dWNaKqs0vhrXk+
 WSZhwYV7H8OlpRhqHQA==
X-Proofpoint-GUID: WSaAo1_lNvpRAfpfU88BMBSkcL6ze31L
X-Authority-Analysis: v=2.4 cv=DopbOW/+ c=1 sm=1 tr=0 ts=698250a6 cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UnJhHybzbDwo8PvvyYEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030157
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQo+IFdlbGwgZXhwbGFpbmVkLCB0aGFuayB5b3UgVmxhZGltaXIuIEkgd2lzaCBzb21lIGRheSB3
ZSBjYW4gbW92ZSBhbGwgYXQNCj4gbGVhc3QgY3ByLXRyYW5zZmVyIHVzZXJzIHRvIGxvY2FsLW1p
Z3JhdGlvbiBhbmQgZGVwcmVjYXRlIENQUiBpZiBldmVyDQo+IHBvc3NpYmxlLiBUaGUgdW5jZXJ0
YWludHkgdG8gbWUgaXMgY3ByLWV4ZWMsIGJ1dCBJIHJlYWxseSBkb24ndCBrbm93IGhvdw0KPiBt
dWNoIG1nbXQgaXMgYWRvcHRpbmcgY3ByLWV4ZWMuLiBjcHItcmVib290IGFsc28gbG9va3MgcHJl
dHR5IHNwZWNpYWwgYW5kDQo+IG1heSBub3QgYmUgcmVsZXZhbnQuDQoNCg0KPiBUaGUgY29yZSBp
ZGVhIChvcmlnaW5hdGVkIGZyb20gU3RldmUuLikgaXMgcmVhbGx5IGFib3V0IGZkIHNoYXJpbmcs
IGFuZA0KPiBpdCdzIGdyZWF0IGlmIHdlIGNhbiBkbyBpdCBpbiBhIGNsZWFuZXIgd2F5Lg0KDQpU
aGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBJZiB0aGF0IGlzIHRoZSBjYXNlIHRoZW4gcHJv
YmFibHkgVmxhZGltaXIncw0Kc29sdXRpb24gaXMgcHJlZmVyYWJsZS4gSSBzZW50IHNvbWUgY29t
bWVudHMgb24gdGhlIHByZXJlcXVpc2l0ZQ0KcmVmYWN0b3JpbmcgcGF0Y2ggc2V0LiBJJ2xsIHRy
eSB0byByZXZpZXcgdGhlIG1haW4gc2V0IHNvb24uDQoNCg0KPiBNeSB1bmRlcnN0YW5kaW5nIGlz
IHRoZXJlJ3JlIHNvbWUgc3BlY2lhbCBtZ210IChPcmFjbGUncz8pIHRoYXQgbWF5IGRlcGVuZA0K
PiBvbiBjcHItZXhlYzsgSSdtIG5vdCBzdXJlIGhvdyBmYXIgdGhhdCB3ZW50IGluIGFueSBkb3du
c3RyZWFtIGRlcGxveW1lbnQuDQoNCg0KPiBUaGF0IHNob3VsZCBiZSBhYmxlIHRvIHJldXNlIG1n
bXQgY2hhbm5lbHMgdG9vIChyZWxldmFudCB0byBjaGFyZGV2IGZkDQo+IHNoYXJpbmcsIHBlcmhh
cHM/KSBpbnN0ZWFkIG9mIHJlcXVpcmluZyBlLmcuIGFsbCBtb25pdG9yIHBvcnRzIHRvIHJlY29u
bmVjdA0KPiB0byBhIG5ldyBRRU1VIGFmdGVyIG1pZ3JhdGlvbi4gU2FpZCB0aGF0LCBJIGFsd2F5
cyBhc3N1bWVkIHJlLWNvbm5lY3QgaXMNCj4gZmluZSwgYW5kIG1vc3QgbWdtdCBzdXBwb3J0cyBs
aXZlIG1pZ3JhdGlvbiBzbyB0aGUgbWdtdCBzaG91bGQgaGF2ZSB0aGF0DQo+IGluZnJhc3RydWN0
dXJlIHRoZXJlIGFscmVhZHkuIE1heWJlIEJlbiB3b3VsZCBrbm93IGJldHRlci4NCg0KSSdtIG1p
c3NpbmcgYSBsb3Qgb2YgY29udGV4dCBoZXJlIGFzIEkgb25seSBiZWNhbWUgbW9yZSBpbnZvbHZl
ZCBpbiB0aGlzIHByb2plY3QNCnJlY2VudGx5LiBATWFyayBLYW5kYSBDYW4geW91IHByb3ZpZGUg
YW55IGNvbnRleHQgYWJvdXQgU3RldmUncyB3b3JrIGJlZm9yZQ0KaGUgcmV0aXJlZCwgb3IgT3Jh
Y2xlJ3MgdXNhZ2Ugb2YgdGhlc2UgZmVhdHVyZXM/DQoNClRoYW5rcywNCiAgICAgICAgQmVuDQoN
Cg==

