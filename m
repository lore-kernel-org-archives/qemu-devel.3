Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B885C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk0t7-00046Q-Fg; Wed, 15 Jul 2026 10:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wk0t0-00045z-8V
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:47:00 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wk0sx-00042d-6d
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:46:57 -0400
Received: from pps.filterd (m0409408.ppops.net [127.0.0.1])
 by m0409408.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 66FE7heq1275221; Wed, 15 Jul 2026 15:46:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 apr2026.eng; bh=k48yu0WsRj7VL+9iBGg/plf4AgAAWugl0y/reyMeogo=; b=
 BlpOe1EscRtHbBrCfjLe6LdzpMFpmowumAhpQ68vVnf95JAhqvF3KZFCVPZQlP50
 ZIUHUX0gE/sok5QtjgMyxyiMM4B6kqyPDIUfgz+odPQhujEl1P0qiwonUzz/Ulsi
 KCYHf1HqUmhxpbGEzkJRalFL2NSgIgBbQRqNltJN6OafXOzxgUKxxcEny/B2VtK1
 phGhUnJQ2sgSzo/35uHjuQTRHO0xWNTZH1gDHCCLR8kFiGBXqMv3IjCkiq4UgNmJ
 oJXxn2KfG8Wu3K3o1oNYEolEtd3/vnbekNKy7I5mkWmIz5oMy2sexWIzyfDsDSus
 NUXa2kREP9EzPz/l062mEQ==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0409408.ppops.net-00190b01. (PPS) with ESMTPS id 4fc0r71gvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:46:50 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 66FEgBK2005088; Wed, 15 Jul 2026 10:46:49 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4fbh5wep75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 10:46:48 -0400 (EDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:46:47 -0700
Received: from DM5PR08CU004.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 09:46:47 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by CH3PR17MB6339.namprd17.prod.outlook.com (2603:10b6:610:152::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 14:46:46 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%6]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 14:46:45 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
CC: "armbru@redhat.com" <armbru@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "raphael.s.norwitz@gmail.com" <raphael.s.norwitz@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com"
 <berrange@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "mark.caveayland@nutanix.com" <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Thread-Topic: [PATCH v19 00/15] virtio-net: live-TAP local migration
Thread-Index: AQHdE6d6uILADNYcukiSXZ+cDnAHLrZuZyUA
Date: Wed, 15 Jul 2026 14:46:45 +0000
Message-ID: <92090252-442B-4F9F-A56C-0E8785A8A4CE@akamai.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
In-Reply-To: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.110.26062818
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|CH3PR17MB6339:EE_
x-ms-office365-filtering-correlation-id: f258c57d-9da4-4239-3163-08dee27fe4a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|10070799003|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 7yiNRyX7s4wySmTix5GCo/CWUCTAwGK33eqQhKGCV6jQ8ek7qQaJ8HCFKdU9trqOO4koOibBjFX5rpi8e6PNyYPcM4qOBGRNfob3dm6RUb9ug1A7ZxDLEXV5hdOeofEcwpXoPDoMrD6PzalPjZXIP07i6U/Jc+iACUrH8qcLhvElBs/mhnToViyUAcroOryCKeiQmatzSCN4cVWG5Mi+FymiiUAbFtiW3A5X4GBJEmC915rt3x2lkDdigab6lmI3BaPsTegRP+xMpniz724ZsTEmgaHhjVOGIsYX3xPDrjr5LQsiQTq4+vGOjGYQwmP9jxqkI8pM6HUlXOwgE9UDDB08apnSNC15zZa03bwe68Dv3kFJuYMlo8fWBOlwkqwkVkm9zm22kk5qhBsEwBkjFj4t62MrEmS0RTD8PHWTea4adIYDUxZwyny+7mzISAiHH8o8Bowd2nbWUFKAT2q4gK/6VX5J2iW0fUyLj9wVzlTiOKrVj5pAd5Wvaya0/ETMhK/WkYhc8NOF476AzqST/+A44A/NtU5NQ1hAYcaYNH9AUfD7SEP4oMKUVhyo0KWqe6kXjVSbi2hucuEal5BiaNzzxaGC8tGOphbF/UMmZ4YABHFCra0KoJ/R8EV0a0MCmzBfB84F8dgMaVt1DYQO7l+J4YvC9oCkdegduTORemyd5GRq4MCvWEZAVliji7fsNwg35tJGgV9XQZGLs/oHpW+3C5OW0Op2U372Tbz5drc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10070799003)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THF5M3IxUWh2eVQ5Mk5VSm15dmsyL2pTVVp0R1BnZ1dibU9EZCtNQTQ5emdk?=
 =?utf-8?B?VlNDWGFOMWJ2d00wdW1DWFNHT3RmdENaeGdCYmNsM2xCaUJBdE5JYXZReC8r?=
 =?utf-8?B?RDRudXNDdU9MLzl5ckdrK0J5QUVCdjFYS3M4NG4zZGZtZ0VuTXdGeWlBNi9x?=
 =?utf-8?B?UHM1aHRDR0w4SFJPR1htYnd4bWdSV0I4L3RWUDk3TVlBS3hhckRNRDdDWkhu?=
 =?utf-8?B?SEZDVFp5YjZWOGVKMm1rbmh1cUc5T1piKzJ1L1JubXp6SmR1Umt6QUk5R3Zy?=
 =?utf-8?B?WDdsWVhWVEY0bk1VRnVVZ3NtOGFJVEJDQnJvanlidE80Nlh2ZktlV1F3amlD?=
 =?utf-8?B?am5DalpLUWFoUjJoUDk2cCtzZUxjS2dLUkdrUDFTRzJ4SW9KWEZTRHNnYmlU?=
 =?utf-8?B?b3FrV2NONEtvWWdKcGNtbURJbGFzSnFjY215cG9uV0Y5Nlord3FNUUg5cjF6?=
 =?utf-8?B?enlKSkNQOGo5SGtmR3I3K1dRL3dscC9DUUdGZ3FxekViWndRaVIwNjJjK2Vw?=
 =?utf-8?B?aW5zNEZuQnFweUNuS0ZDSGNoMmJjS2czNnhDT3I0TnN1ejJtS0ZwaUl1a0JT?=
 =?utf-8?B?MkowSFJ5RGo3YmYyQ01BMlBta1M2ampEMDNld2VMUnFnWi9kOXpDbVFJL1dx?=
 =?utf-8?B?bWNHeUZZRE52ZGdhODBUamZQTFlUYVJCdlZrcXJ4U01iYTRhSlJXTVFPK3B4?=
 =?utf-8?B?ZFZ4SlpWQ0JYd1poMmp2elllaWI1WXlHV1N1TWNZS01YZTAwSlM3TDd0RzVm?=
 =?utf-8?B?b1JvVHdmc294Y1FSeDl2Y21tOFRJZmVHdU9HYTV4ZDVNdEt1MW96Y2xiSS9t?=
 =?utf-8?B?NkZOTXQ5RUJ2N0l1S0hiQTBYS2ZDRVlTQUd3Tm5JU0FFRlN4SzlEKzVDWmlO?=
 =?utf-8?B?UDFEcEJTVDlJdXdPRThKZ3dhc2wzc2Y4czFtMHpkblNtM2NHTDlWOHpkUFZP?=
 =?utf-8?B?ZkV0UjgvaVV5S3VKdFhuVHI0U0lSZ3AvQzBQQ0JDL1RFUlVaWmVnWmpqTi8w?=
 =?utf-8?B?aUVTaTVPTkhZUzI0ejJtSm9lWFJUNTFOOHVaYkF0NVE5S2VDaVg1MnZnYjNX?=
 =?utf-8?B?bzVuc3NvdUxHN25rb3Z5UVhwMWI1STJaQzA4eHozZUxZdU5JZHFJTVhzcEI1?=
 =?utf-8?B?a2J0N2JQdVpzRnNKSHNjaE9ZNUFQNm9MQ2VmeUpUSENpamxDSlBCWjBVMGRq?=
 =?utf-8?B?cTBCSWVXak1DU25RT1hXRURzTmVGQitZRURhYmFnakZwSzk2cHFMblJtK1Jk?=
 =?utf-8?B?QjRlV0RBWGJIb1A3RVkwTTdjNHpCYk9uMVRUWW5GS1VOQ200aTBBSnFxeEFj?=
 =?utf-8?B?VWVvN0oycEhzYThiRVNpWEVxL09NZ3RRREtpVUtrRit3RmlrbjV3VzQ1Nk4r?=
 =?utf-8?B?V3NKb09sM0Y4QkFJQ3JuTXhKTXYrd3N0b0JwV3JNZGZ5bXdMcUVDcVdPajBY?=
 =?utf-8?B?NFJYTEpNd3dlK3dDWXZNdE1LMXRhbENsUnJucnB1cWdVdFlkMGJBWTkwSEpL?=
 =?utf-8?B?aWF6aHJSeW4wcUxjbkJ1WGlUdThuRWpXTmlpYjFoTmZ6UXVXSjAvU3JCNDF6?=
 =?utf-8?B?dWlrU2xHeUlFYWNRbndPd0w4NWltZGJRaHA0L2hSVDFFNlRXUFBhWDVxbisz?=
 =?utf-8?B?b1pBdlV5RE5tSGJSUi9MeVVDaXo1Kzl5bXN2TS9tOXpYRmJvUzZrMUNIVG9x?=
 =?utf-8?B?OU1PZzR0alVMdVV0VkpJbkRMY0tjZEJ0dGVVUHJmKzFTdm5EQ01lZkhtbWpq?=
 =?utf-8?B?bmpUOHdVKytNVmFXKzlDTGEwM1BoMEtxcmNYNmc3TThKbk9wTHJaY2N3NlV0?=
 =?utf-8?B?eGVnRXAyNkhNMm1tYXQyODFiWG8wS2U4MXdpcW12Z3NrTzhCczJ2TlhGVDBy?=
 =?utf-8?B?MzBWdTEwVWFCbkozUEZJQXIxR3BxRWtpalRKTXJvTk1ZRU9DcklKaUpmNGIv?=
 =?utf-8?B?N3B5MTdJeTdZSWtxVllJU1libkpDeHB6VngvV0FWYVo0NTlNejBLRDNNbCtU?=
 =?utf-8?B?L2lCbGRxYjNMMzRxODZ4dXI1TmFnbFZSMUx6N3JxR3pMT0dEdkhtSTd3ZGkz?=
 =?utf-8?B?SWNzMzdiTG0vMCtzVVBpRFVpTHBPZHFveTdwaVBmRUw3WkJEZzlnRU1tMGZJ?=
 =?utf-8?B?RzdERHJsTXVzRUhvS3p6cjRGVC9JOGFyQUhadWdSNEZtbjdqc1o4TUNVOTAz?=
 =?utf-8?B?WmZRRmFqblBNVThvclVVd0FTWlZrSzNlbE5Bd0RCaHF5azJTeldta1YvYXMw?=
 =?utf-8?B?aVcwK0M1R056eDltd2RLcld1VHNBcS9XTzhsNFhTb08yWTAzZ1lIVnc4cDBO?=
 =?utf-8?B?djJQd1AvT0l2MGtTdEJHN1A3V2IrYVR2NVliNFF4cUpaUkdjSE9SVkZldlhm?=
 =?utf-8?Q?ga2i5fiRp4ErutDvzHkYDmL4oe4aVUQMVvc4+wjjZVIzk?=
x-ms-exchange-antispam-messagedata-1: cO63X+pL1TnVAA==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdIknU2sA9KwLIPm5b9bxQDwDqauLzZ9/25yXqa81bUSmtcRPdbQbMLh5PdB9Py08+6x+CjfWcVbN/aGmT72A6c/0JrixEon4ydhgRiWtosGPZ9scGebq6q6IaTz/xUD3BZSaNtC4k/p4L6s8KCjGYka3TxnQudDbSmJSBetg4IUesuM0yDxMTsakoIwlB4PZ9w73V4A8vPeiMkaWg+Skp08VdGx9PhYw/3AqGgtZ3bJ/XaOnkV2ea4Ae1bltRkLumePkombqlnn2Yty0jzmB8NDuINXxyWxLd6mQ4y45KJVocfZ4qCE2KMw3hyaR9qKLmYqRTn8kgmDSrZ/+miC0w==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCkhvtei2J/B5/fMsdL3fqZNSvCLpyzMwBBy06+1W7I=;
 b=b4pNtxgvelZ4mu7vVgZ1qqmhZPra7eVm1d1tD522OxVlhb4vicDNoGdc8LOgzK/5B+EshXNieFyau9fSpGxnoX8KMO61UalXBI0Ct4ogihV9nXIOJRLRwHWqu8rtpmKwAnVhxofYLzBBzZhKAMow8rHQ8yexqRP23BiqL2psWESyBqc1zGRBRtSBfT0fqqYBUTRHb66Kda8+ELy3ykssKhF3BOwDaTBl+6IttojdeTP7Q8uFmCnqhShwqObY4Zu9AWYTTUwwXj9UcyyOxrwQo2y9rFrwUE3S2KtEVXhIBrjGGmnt+5kGJf3MQs6eeHddxYmGa8o04hrILzogBLXbCw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: HSyiFIHgQ+QfUslvickdG1+iOA/6Whl7jgpM0DGzBa0Wz9b2uTwsWm4RSd1Ls7VmvrW4/+0mMwioc7sJpaOxeHd/JfJUxnreueFD1tTnsMFb/5eEuRG9Wubs4ldl1daAwkfz3uEYYAdX4c/9JUFrEpPSzIUhk/fE31Mgdjt2Rqgh90UHHtntJbvZ1AQxf+QX6pxtFquszycqIaTi29e8+O1uWgBVJIdht0KvCBKE+R47EUu6PEg+8ua24/zPTZn69uOLZq1gyr3m4OXyW5GosMGgpEZ7DRMgDaI9eHt/ROVd3pJ1+0O9WtWeW8M5qHo0ccximvJvCKZ6qTF9P+Hefg==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f258c57d-9da4-4239-3163-08dee27fe4a9
x-ms-exchange-crosstenant-originalarrivaltime: 15 Jul 2026 14:46:45.7706 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: GJmOHpoJjrxiNozX72bUld5kCXdCtVMZnq2442GpcnYvBNNVKSZokbQwr38sPqq8hQObsLWpZaIt04IX4GJ9vg==
x-ms-exchange-transport-crosstenantheadersstamped: CH3PR17MB6339
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6555387E12EED4D942705E983EBC1A1@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607150146
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0NyBTYWx0ZWRfX/YV3ICcB0z1j
 bvynWKsTvYY12Gsm1PoZ9epReIs2y0fvQmuIRxeU7kGqG/xyqfU4wKYe45PjufYuYgr0FFiuPWr
 K9LTv822Y0UsNpQTUEmSrPDl7eobm28=
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a579d5a cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=BYUV7c42er6_Rx9bq0XK:22 a=6R7veym_AAAA:8 a=X7Ea-ya5AAAA:8
 a=pqW7ofXxTfurCPM2P1sA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: ObirNJ2RiOp_8BYQP7pVsIATCK2RxQwY
X-Proofpoint-ORIG-GUID: ObirNJ2RiOp_8BYQP7pVsIATCK2RxQwY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0NyBTYWx0ZWRfX4OKT6mvBK7vx
 3XgBrl2wvDb2BH3SyoKI4R2ZCAdMjtoqTt95RNtOMOCJm4/wdg/QNZzJmwYEkJFGXD2Lre/8CA8
 jXQJxl/LLtSFTbyK33qcP3N4VkntC5SswGo8nkfhZqmlP/tJQ9M8zoPr/eP5SNKYkqxS1kNv+gf
 E/ybP0pvEQoqMgEHQVcnND9PB+QZUNhHWCHV7TNNX6A0B9MQPTYbMDzqs6hk+RnbGNEyuBSsZ5+
 tSthV560GS18+0eBRZTLyLiiWJTwDD0kw8nfzho9zU1SGRFAwcf4KqJd3hLUx+GxksFWNWIaT4W
 8j/eMoZUpW3928iviFAwkjRRdcTYjgb4KMgltC4vxQStWhK6pVGtFOZT+5zocFc+lmawvf2YlHp
 OQttpF4zCmk7t15YiPJZo5qbSo/L0uBVSneKZwI5vbRJeNgywads8YJFzDgyoyZq10JRJBvNdTi
 s2T166nDpMmOKre98cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2607150147
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

DQrvu79PbiA3LzE0LzI2LCAxMTo0MyBBTSwgIlZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXki
IDx2c2VtZW50c292QHlhbmRleC10ZWFtLnJ1IDxtYWlsdG86dnNlbWVudHNvdkB5YW5kZXgtdGVh
bS5ydT4+IHdyb3RlOg0KDQoNCj4gSGkgYWxsIQ0KPg0KPg0KPiBIZXJlIGlzIGEgbWlncmF0aW9u
IGZvciBUQVAgbmV0IGJhY2tlbmQsIGluY2x1ZGluZyBpdHMgcHJvcGVydGllcyBhbmQNCj4gb3Bl
biBmZHMuDQoNClJldmlld2VkLWJ5OiBCZW4gQ2hhbmV5IDxiY2hhbmV5QGFrYW1haS5jb20+DQoN
CkkndmUgZ29uZSB0aHJvdWdoIHRoaXMgcGF0Y2ggc2V0IGFnYWluLiBJIGhhZCBhIGZldyBtaW5v
ciBxdWVzdGlvbnMgdGhhdCBJJ2xsIHNlbmQgaW5saW5lLCBidXQgb3ZlcmFsbCBMR1RNIQ0KDQpU
aGFua3MsDQogICAgICAgIEJlbg0KDQo=

