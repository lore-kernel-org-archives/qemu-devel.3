Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE3AEEC285
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 21:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vudc4-0000aJ-9h; Mon, 23 Feb 2026 16:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vudc1-0000ZX-Qx
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:37:05 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vudbz-0006wv-OB
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:37:05 -0500
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 61NLaR6u1650950; Mon, 23 Feb 2026 21:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=HQ2SR/Ce020DlhgArTVPBxltKTuZ9+Rq+KimFZm4N5g=; b=
 Mw+YY+GTwMPQ3arF0ubYAVoYCIhAgM+0dka2HMmYdZqn9LxpVPTcoDcaLT9mlzOd
 SFSVhwAN8+JeOGFtOlYs1y7VHV8jqtWId/0xs/hA/im/0B9IRA6JyodjRBtxfqH1
 vHJBPg+HPdR26qNK2D57zqLlyaz6fTNMP14XM3zet/oRb2Ymp2gR6w5o6pTaolmM
 Jlb76lLoA+zK05E4NXGD3oo0CXtgAYvGRg4S2g9qoHzVUWm2sfI5/IgwfLwJ9mrz
 TKyv+smqjluzGfqfskpTc/Iyq0GGzDvWFfS1RAFAEgVQL0P7vhzn4jT/JFra1KPf
 LuLE+kF2l3KZ3ekPqT7uYQ==
Received: from prod-mail-ppoint4
 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be
 forged))
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4cfrg9ummv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Feb 2026 21:36:28 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
 by prod-mail-ppoint4.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 61NLXx06016199; Mon, 23 Feb 2026 16:36:28 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 4cfmk9624h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Feb 2026 16:36:27 -0500 (EST)
Received: from ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 23 Feb 2026 13:36:27 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb1.msg.corp.akamai.com (172.27.50.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 23 Feb 2026 15:36:27 -0600
Received: from DM2PR04CU003.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 23 Feb 2026 15:36:27 -0600
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by MW4PR17MB4289.namprd17.prod.outlook.com (2603:10b6:303:74::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 21:36:25 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 21:36:25 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
CC: "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "leiyang@redhat.com" <leiyang@redhat.com>, "raphael.s.norwitz@gmail.com"
 <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v11 6/8] net/tap: support local migration with virtio-net
Thread-Topic: [PATCH v11 6/8] net/tap: support local migration with virtio-net
Thread-Index: AQHcoZbNBlzz1I9g30Kt97ivNEdbObWQgesA
Date: Mon, 23 Feb 2026 21:36:25 +0000
Message-ID: <721F62BC-6E5F-4963-BC3A-666F0C0290CA@akamai.com>
References: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
 <20260219115530.2019498-7-vsementsov@yandex-team.ru>
In-Reply-To: <20260219115530.2019498-7-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.106.26021521
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|MW4PR17MB4289:EE_
x-ms-office365-filtering-correlation-id: fa49e468-8fb4-43e5-24de-08de7323989a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WWIrcXNGaS9hdGt3WUh2Ym9ZWUR5VFpQZVZGZGVnU0EzWHF1dE5waFpTdkNM?=
 =?utf-8?B?bGFiWlhXR05qclJkZllaRGpJQ2lrdVBKZTZxMnhlMVgrcVB4bmtoalo0aVJ3?=
 =?utf-8?B?cVRGbUs0VmE5K0dLNU1LVGpTNUlsZUVPZGJLdzVwVkNwanoyTmRzdzNpWVZx?=
 =?utf-8?B?WWluS3dYSmFLRWs4bXFTRklkYlFKYjBNRlVqRm9WWDNzOHdIa01TTWsydWVN?=
 =?utf-8?B?M2NQKzAxckxIdmRLblpRQk8zNm81cTRIOXBScCtUdXdpaFNzODdoTmxZVWpk?=
 =?utf-8?B?amFDME41ZkhDMmxSQ09Ud1p3bGZJMW1Id1BpaE9vTjhPK2pyOFAyV09vUnVx?=
 =?utf-8?B?M2lEdEVlSVpQaHE1b1lUUWM3SWtmcXN4cDYvem54dTY2dHR5SFlmTUxZWW9l?=
 =?utf-8?B?b3dSRVg1dlRFVE9CdkNnWTd2Zk05Q1krRjgxOVdLZWg1bkNGaEdBYWt2U0JK?=
 =?utf-8?B?dVdlMzFyRXNiaDVBUkZsLzJGeGxkd0YwbTN0RVcvTHVSdjcrdDhlLzh0Q205?=
 =?utf-8?B?SWJtNlphemVXSlpkeDJKWnBVRGx3QVdCeXJNcXVRcG1aK29nZnd5bWNJMVly?=
 =?utf-8?B?cDk1YnV2ekFlY0JWd0xsOUZYVC8xcXlqQzY5aHk3MzlObS9IbmsxZ0FzdVh5?=
 =?utf-8?B?Y01CSGZqbmx4UTFXeDhOemVYOFpEZmV4aHY3M0RVY1BhaWsxek9aKzJFSGNI?=
 =?utf-8?B?MGI1M1NUTjc2QlBmdVNMeXJYM0lNK0NuOWJTUS9HOXhjOVRlWFg3TGt6bU9X?=
 =?utf-8?B?WUlZWkRjcWQxMmk1RWwvb3V1Ym1IVEo5ZUg5S2lUeUo3TVIwRE12cHFyRDVq?=
 =?utf-8?B?LzF1R1ZaVnlWdHlFZC9oYkFuWkNoUjM4SFlXSjlHd3B4alRUYXRlZWMwL2xX?=
 =?utf-8?B?SVZqZlB2Qk1MVkJqVVZnZEhsTUxSTUdBWkh0c2VHMkkrNEc1cWZ2UW5EOHdJ?=
 =?utf-8?B?VnJQOE9RcFFvUjhpbU1LQjFYejBybXArSzdPdU5aUWNtWWUyY2VOcERzVnk3?=
 =?utf-8?B?MDhLNEJNY1NCTmV6dHZkTWlocmJDYjdrejNyRkVQRGM1MlFzZWZvV1lRQ3NR?=
 =?utf-8?B?bWgxaXVwbDQwTnVIeUFhT1BBdUxJN0NwaWNiRDArMyt4THJueThNOUdKaXdv?=
 =?utf-8?B?blZZb2ZZVkFLOWJjTitWODNnbEUwU0EwcGJ3NlVIQ1IwZ0RFMXEzcC9SdVVR?=
 =?utf-8?B?QUh0TWxiTFVaaTBKb2ZBeFJXWGVXMXNENE9sK1VFR2p1bFlvUlVPbTU3dXBW?=
 =?utf-8?B?bCtEY3E3c3FCWldxbUJ4dTRiTGdlNzUyeEd0d2l6U09QYXk0VUxzemFOZzBP?=
 =?utf-8?B?TitpbTlJNW1iNC96RVY2bjg2Y2M3WHJ4WElBTE80cWFDVnBmOTdxdnVORnpN?=
 =?utf-8?B?OUdHaGJUSUxrOWxMc1ZTQkxUMWxBZ2hZbmJKdmQxZkYvZ1FkNmxSQ3ZnQUdO?=
 =?utf-8?B?NEVIaWM5enhOVmFieHpLVU1XL2hrd2ZKWi9Jc05LSkc2VGozaGVsQ3hPNk5x?=
 =?utf-8?B?YzdZcUhNQjhZblpGOCtvVXJFTTFueFd5Z0lGM2tWZjZRUHpjdkV5NDN4aWhh?=
 =?utf-8?B?Ti9ZWStlZkFsTUhocERvWWJ0QmdpNmZlQWk2c2UvbDRUMWtaM2dlTWdwRWpZ?=
 =?utf-8?B?dURmMWZuOEoyWlBkRUQyUjhaM0lud1pwNTdwK1RYRUNkRE1QeGRmcjR3a3F5?=
 =?utf-8?B?dGhtUE9hQTdvdTRsZDNIV3BIR0MzcVNxbGNxdkdKRy8vN09iK1JZbTd5dFVr?=
 =?utf-8?B?eGN3Mit3ZDkzT1VJVW1tQ3oycUU3MDV2ZU9EYkkrWG5jYmdJUDZHS1padlM0?=
 =?utf-8?B?SHRzbVByb25tQnRldCtKSWRuV3dLVk9ONnEzQUJNY1ExOVlqMWhVMVhxUlFh?=
 =?utf-8?B?SUtjMkV0ZG5MUHQ1MXNrdXI3V2hLeGl0Y2NkcDl4SEdMQ08ybVJkd1E1Vm5S?=
 =?utf-8?B?VXJKeDM5bWlHZTEyNW5VdVFmcGJRV0l5MTNVUXhkZ0VpK3dTeFBHVHVaS0lv?=
 =?utf-8?B?ZUU2MFFLcDM2aUlwYlFJaHlYalR6dEhxQVo4WWVTbVdKV2dINmRjMGgrVGVo?=
 =?utf-8?B?bXppSVdkaFBXUGZJZm5WYVoyV05iSWJJNG9xejIrQlJ6RlB5OU9nWTZJZjE0?=
 =?utf-8?B?QTlKVGJXTFdxTVlubmh5Qk5HdFFTeHoxWTlGSFlPek0xUW9vamlKbXBLSkJh?=
 =?utf-8?Q?1d6EVRn19HDXna1+cStHBW0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RE9FeTNkcnJpNjVrSjdLTHgrQlhxbXAyWitmZGJ4ZVdmYjdUZHczYzFvc1l2?=
 =?utf-8?B?Y00yaHVMNUJTRzVQL21NT1ZiUzk2Z3hEa0hsUlhkcDBKNk55MWdudzNrSnVK?=
 =?utf-8?B?SURRUnRhT0wzLzVwV01oUDlLZ3RlajA1OVBQN25SOHlxNUhObXVkTE55VjM2?=
 =?utf-8?B?VXdVbnJ2b0dPRTNOSGswNGlhcjlDWDB4RkZXZlh3aCtjemJjUHZuWnZkS0xH?=
 =?utf-8?B?SlpNRlBmVWdpU1RxQmZ5T1VlMDhmM05Fa0xpZkZWTWhCWVZaenZmeHZOeUFu?=
 =?utf-8?B?azVRREJpWEtSWlFNSFhWZkRMdU14RHMwdHhiTzlheE83a3RBR3VjdTRyMk9I?=
 =?utf-8?B?RVNWQ2pTemxZaHY5UlFwdGRNWENsUUtrejRsWXppOVhJMFl3MUtCd0xFQ2Zv?=
 =?utf-8?B?WE02NW92Z1FzNU16Rlo1NXVtbVF6NWExaHc0V0xXZEdxTndPUFlBL1MzM0VK?=
 =?utf-8?B?a0hvSG1tWGQzWlNlSXlFVTNTSnZUa210ZzFBcDdXNFBId0VycXNaWGE4bzFt?=
 =?utf-8?B?dnprL3Z3NkJmOWxIZzZkekpHTTlSS0VFQUpVSUxtVjZNd3lST00rR3p1bXpu?=
 =?utf-8?B?WWVMdWUrelR6N1duSjE2d3FOZ2REaXdWVWVzUG16VW9rdHBoM21jYTY1SEtt?=
 =?utf-8?B?NlZIMUo5dzIxbmxEVWFlbFIzMzdOZkFWUSttWmt5b1h0VmhTVGVJUmxGSHly?=
 =?utf-8?B?SmJoTUlIcTR6TVVES0gzZGRVckV2WVlxanJ2MGFaVTJ1cDI4N2syRVg1VFVM?=
 =?utf-8?B?b3dUUmFSTFduVmRSWTQ3R2F5K2M2NWlvWFBpY1JTaWRkUVZsRTdGdWFWWWtj?=
 =?utf-8?B?NDBUcFMrN2syVFhaN2hDcWNENWJVQmIvR2ZEeXhRSlNPVWQ0ZEludmxVZjk0?=
 =?utf-8?B?ZVhhYjdDak1lYnk1SE1aT2hrNHRrWFJqOVBQZjEvUlpsOTczYWErMnVLUERx?=
 =?utf-8?B?VUxwY2l3bW9WTDdDOWQyZW5PcFAyY0NieGtNYll5Nm8xVFhrTk11MmZIbVpW?=
 =?utf-8?B?Y1JRTTM5S0NlTUUvY1M4cFJQcWJ6eEExSHQ4TDlHZEVQejJkWFBFVm9rSWFN?=
 =?utf-8?B?WkFKKzcwSlhZNEpWN2RPeFY2cDNEZ052Q085ZFFsQjFkeFcyMFBBMmJ5ZEti?=
 =?utf-8?B?UDJLamlKMW1lUTd3RSsySzhGbDV3YjdodU9rYzNUN1crRzRLODl6QTFIQkNx?=
 =?utf-8?B?Snd3UUZaOHZLdHljNEJIQ2krdzVGVGg4L2kvaEdhV0FRcStlbndRNFJxWHZK?=
 =?utf-8?B?d3VTa2QrUXZoemthT054ZU1rYUhyZVF1Y1JmS0pzN1JIUmlXWjhiMXFYSkJm?=
 =?utf-8?B?WE1zZkszVjhPY3pVVjRlVmZxZTN4MjM0NHZUZDFRdFoxNGx0R1ROL0tWY2xM?=
 =?utf-8?B?UjB0Z09BZWtzYVFNN0phWGV1OXRBU2ZPRHpEVkFJcGNqaHNvS21MT0VTTW1L?=
 =?utf-8?B?Ym1mOEk3c3VCYjhQYi9MOVUzZzJQSDMvZTJOSjJmYnNKRVc3QVJCOWtIWmtK?=
 =?utf-8?B?NlRzZmpSVEhURWp3QTZzWXNmYWVFRnN2QlArQlB3bDhDdEFUdk5SYUN0dm4y?=
 =?utf-8?B?V2E3akoyc1hEendFSnd2ODRrRjFPY1BIbGJkQlljU3RoaGIrL2g5QThQak1r?=
 =?utf-8?B?dWxoZWpzcWprZ2RuYUR1aGhyWVRsZDRmK1BtOURCd3FtQ3RUUGhFa2I4d1R5?=
 =?utf-8?B?am1icTZrdzU2T2ljcVkxQmFzNmNCUVRnY09TekRKMExRRWZmd0V0RlgrUjEv?=
 =?utf-8?B?ZmlYY0RFSFphaU9PbDcvTmhLUDFMNEZLbVUyS1Noc0pOcm5wTTN0VXNrNGhD?=
 =?utf-8?B?U2JSMExYR1RLVUV4eXZJUnhOVjBDaERLZWx1Q2YrL1ExQ2s0UGxGUHlIWExq?=
 =?utf-8?B?U0xxUTJUWnhnQUxGQWY1U2tWbGhTZkRxKzc0Z0VCK0NWekNGOTRBNzFOUG4r?=
 =?utf-8?B?ZFZFN3dqdi95Qm1pc0hXUjErYW9uU2VGWFpmc3N5aGZuWUw5QnNRQ082UUxF?=
 =?utf-8?B?MWRhUUM2TFRZa1FPb25kQTNzNUdBNHR4VzFDbmRCS1hQdkJMQWUwT3Voek1M?=
 =?utf-8?B?c25tK1J2NTdwYnNQN2UvMDA4TjRiNnp2UFVFSmc3RFNxMGxYRzRpNmVoRUF4?=
 =?utf-8?B?MTNuK0ptaUwxU1pEdVE4eFJhekEwU000dUt3OTltbm1XYVZLVG9xUmpIMk0z?=
 =?utf-8?B?MVdHUStEVGhPWWVjTFhxRmRDdGJRamZrMHNqbngrcmNiOUc3SE93OXdrUlpD?=
 =?utf-8?B?MnJkNElwbmxwYTNIeVlPWTFsQURSYVVTRmhOd2pOU2EyZW04ditPMXgzcDU4?=
 =?utf-8?B?NytCVGdNSkJVUDgwV2pDS0tmOEtqUENQRDNJSWYzWkFVSU0vOFBYVStOZk1E?=
 =?utf-8?Q?+w22juVT6Mx6Aad+slIthRXhnSbnrq9rwDN45V+wpZHtv?=
x-ms-exchange-antispam-messagedata-1: pvC8erMdHhxDCg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMgmE0Jcx1rf3SGKQ/pI1Ak7vwHjj/Ut33L6q4Fkm5abWuWKuIwH35LHvHhr9fLNLiJMpeU7lmDSdrcXlpubSMBogSbpVHcNPs8K2PwsLlFtmlJfLxXmDxmHnKNQwWqVQRnDyKpSq29mb72ElwatuCdgC8FovbXu4KkztrcRXjPzd04lYYsdR4y2qBvgzQYVwue68MaZzHJe35d1KMZWDl97c/DApTHmFVjTa66VY+iyr34hTPy44oOiYW9DwlQxYHMv9gC5uGzn4E9f/bj11gcaYRcfCLKWpKptXGmKtH5W+rv3gV8aGTos2zldhhjDW3b79kP6N0EMcuvCMzgDAw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8tkwgNRTSbvzVuUjBOTnS+ZlSFHG4FfDb6tEHPbxIc=;
 b=uZRWZ1V8Y9jvJwfu9j3miELiRC/9yy8v0Dz5GgfDTlAfYbDsxuDz+M70XO5CexsCKPTaKI11M5MVjG23gUhu3BkNXprmbIzbZdbzQWkK7nDLyYdc3bUvnHPCRK3t/EuhFB0qEJin4ErYcGct8fdkOf77lL8VUqU/EJPgS/ojIBbQTwIXEP10COKmXEsRIIqs2biLY+wClP3lvau7rjY1XWXqP2fG8y0wqn6zCN0W1QzkDYAsmL+MOZugsTXb2vzvYA0V+zK8spFQmJDj+z6vCHvLOtUkeTskaLA5D6eLApqUNpAEFmNT/BMwJBrM4cTLbkilaI1bpHqyWTyRTZruZg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: fa49e468-8fb4-43e5-24de-08de7323989a
x-ms-exchange-crosstenant-originalarrivaltime: 23 Feb 2026 21:36:25.4003 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: XJZrlmbyqhbo2T+EgDUF8s5EMhuoI72gHmAXfv26SAdP5SHg3HR9tLxRK3OFJxVWrg9Wygovu8vpaDnYdmRmWg==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR17MB4289
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0FC38010E19724986CECCD2BD914CAA@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=590 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2602130000 definitions=main-2602230188
X-Proofpoint-ORIG-GUID: 9DscKDa31_5UGnTJGEah3ik1l-XBwcfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE4NyBTYWx0ZWRfX4LR7z0Rxso8p
 OGsaBuJiHUZhijMnAYKTdugnVy9rdypB88UfkSQNFciNR0/hWLJInqHsNJbXPUd5yYnblv2Adbn
 12L6bTlZR7kbQEPB1OGvaP7G/vW7W8MjZsbcQG7KjrIWb2IYDHyT4D2dBLLyxNHcU+v62uCjP6R
 b1tClTna/yJETrHpJaI3v+2sx/NfKG6/nwPJ6WH47z+7eTRqjMxFzHbkCX4FxoTMrGB7uXGar1b
 ageIy3U4IOYlShvJ+RAxgsykj/aigVg/x7dv/yolrmJBJkgiqvVXxOlOGqbofZuySug1eXVkPeV
 rgZVD//XifQZo55QKTSrTmdoVIgreV9luLzNEimmW3I8c4j/NkmRDhlSXgz4vr7z2sJxyWblVpE
 bNDGt8n6chHA0yQGtMVtVdFbVenkO0LPzTmZE9GulFjTBeT3oEa/Z+LikDMez2TzTFXx21GNfpT
 7nQI2zMLc5m765/WH+Q==
X-Proofpoint-GUID: 9DscKDa31_5UGnTJGEah3ik1l-XBwcfI
X-Authority-Analysis: v=2.4 cv=ZNXaWH7b c=1 sm=1 tr=0 ts=699cc85c cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=KDzEjHMMTas96-nIEKpj:22 a=6R7veym_AAAA:8 a=1_RjD-fSRxl2YCDaEOYA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230187
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQrvu79PbiAyLzE5LzI2LCA2OjU2IEFNLCAiVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSIg
PHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50c292QHlhbmRleC10ZWFt
LnJ1Pj4gd3JvdGU6DQoNCj4gKyBpZiAodGFwLT5pbmNvbWluZ19mZHMgJiYgKHNjcmlwdCB8fCBk
b3duc2NyaXB0KSkgew0KPiArIGVycm9yX3NldGcoZXJycCwNCj4gKyAiaW5jb21pbmctZmRzIHJl
cXVpcmVzIHNjcmlwdD1ubyBhbmQgZG93bnNjcmlwdD1ubyIpOw0KPiArIHJldHVybiAtMTsNCj4g
KyB9DQo+ICsNCg0KVGhpcyBjb25kaXRpb25hbCB3aWxsIG5ldmVyIHRyaWdnZXIgYmVjYXVzZSB3
ZSBhcmUgaW4gYW4gZWxzZXt9IGJsb2NrDQp0aGF0IGltcGxpZXMgIXRhcC0+aW5jb21pbmdfZmRz
LiBJIHRoaW5rIHdlIG5lZWQgdG8gaGFuZGxlIHRoaXMgY2FzZQ0KaGlnaGVyIHVwLg0KDQpPdGhl
ciB0aGFuIHRoYXQsIHRoaXMgcGF0Y2ggc2V0IExHVE0uIEkgd2FzIGFibGUgdG8gdGVzdCBpdCwg
YW5kIHRoZQ0KcGVyZm9ybWFuY2Ugd2FzIGltcHJlc3NpdmUuDQoNClRoYW5rcywNCiAgICAgICAg
QmVuDQoNCg==

