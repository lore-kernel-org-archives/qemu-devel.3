Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688F3E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 03:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvwN-0008BQ-Hz; Thu, 12 Dec 2024 22:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1tLvwK-0008B3-Iz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 22:02:04 -0500
Received: from mail-dm3nam02on2080.outbound.protection.outlook.com
 ([40.107.95.80] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1tLvwF-0008EJ-0o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 22:02:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBdT/h7kcYcZeE+Z4oU2sWXMjEBbGtOmLypa0/3jNe46gw3SwF/9jwJOIwzLXdpGarKersPbXttzw/TXpNP27uIX3t585kZrZwnI3wULNd5SJKbmBlAHWjqf9fqqAQRXDnIrLNdjVzVLL+AWexPG6Su5pZhVpUsI5LYmIHVXvbkkDsHRtTbbZHU+O0d7V48w/9HmUJ9ZPBND/s3MSmcPKOuKQN7FSghU7LLfB32FqMR6xyYIkXX18y3GfABtL25ozi8pzMAr+SPc2qu6gkxFY2S89ply171tAw6ae/42cJ8vR0t2HTMooKBoXkQ6gy6Oh9KPuPPQHNxLD83NQZdzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKOUlPpI6dtus3JgEj5ocRUYgdhISRnrB6EbG4Md3r8=;
 b=VxIAUsjMNWFdhKm3khnnG2DZHZOXhhNh/09/yrhoQ4KAS23vjrTArq8fB7GSjX6hL9FtYRG0IEQwkti39rRubre9ebo6eeyBKurzM3x8tXHV3+zV+GsubLfTmrj2vlXBuYoYjuaGz4mX7suAv9T3NxyZjOK/Vf59xY0my8SXnl63mEUBQ40bpQXyJ6+GQSQp0fOlsZlVFVzZq2ngVHTduMw6sfrBeDLxWzRXlrYL82kgrtstWh8WWVJ+S06Hrkg5CgtgRv7rEn36pQwcGUn94OLhmGwiux9WZxCKAjZGbGEGzQ27wN7mocfTqAtcv0hDaKUEUz6PmndeuPSPZt2HRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKOUlPpI6dtus3JgEj5ocRUYgdhISRnrB6EbG4Md3r8=;
 b=3gcPtbfae7vXVPP+CnNvjE7CuEYWqIR611BXdtamUUJEAYvLyqdyef1Eh5vyEv/Kr7vZKh/4LLL3p5HlP0AHCxJ5ivqbPqdEVFzzCM2IMhLWL+3OAaPqoEJ7iLXmm1+s7j5fmVPIZfAwf0HyW7gzLRmcdsnnSXlHGMu+1nE8Y9o=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 02:56:49 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%3]) with mapi id 15.20.8230.010; Fri, 13 Dec 2024
 02:56:49 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Anthony PERARD <anthony@xenproject.org>
CC: "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen,
 Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [QEMU PATCH v10] xen/passthrough: use gsi to map pirq when dom0
 is PVH
Thread-Topic: [QEMU PATCH v10] xen/passthrough: use gsi to map pirq when dom0
 is PVH
Thread-Index: AQHbMBN9zgKXu6QHp0mudGAMtCr+w7K9RysAgCKFMICAAyspgIABQ32A
Date: Fri, 13 Dec 2024 02:56:49 +0000
Message-ID: <BL1PR12MB5849EB10F66351905164933CE7382@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20241106061418.3655304-1-Jiqian.Chen@amd.com>
 <Zztlvl0m-Oi2XGXq@l14>
 <BL1PR12MB58491C9D1CCC1880C442AF73E73D2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <Z1sDXYATWad0Rbyf@l14>
In-Reply-To: <Z1sDXYATWad0Rbyf@l14>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.8230.010)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MW4PR12MB5625:EE_
x-ms-office365-filtering-correlation-id: d170640f-e606-4135-805d-08dd1b21c9f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dFpRYThrUmZyajJYOUdLQmhqMW9wcUZqZEpmZE5mVjRkMGpyOTNtZjkvQUVY?=
 =?utf-8?B?aHR0Y1BvQmpUeVZnUmRzUngwbjN1TVc5cG9DWWJFSGJjVDliZURGV0hHc1JT?=
 =?utf-8?B?RWVRdzB5Syt0dmFtRTFpelRWQjRvbHBVWnB1bjIycEhOZU01cm9UaUl1Rk12?=
 =?utf-8?B?M1d1c1dkWlMwZGoyRUpSckkxMFU2aW13NHpOR0Q2WU9mQzBkYTRBNTRiSDV1?=
 =?utf-8?B?aHFOWVM0aTVVSGNyemZtVUJUaGVjcEU0YTJ0cjlZTVVYOFBNT0FmY0pMOGZZ?=
 =?utf-8?B?UWFZWklMeW1RbmJDU0YwVEJSMDhBUWdzZ0xUN21pRnpCWUZnaDAwM1RYTDA1?=
 =?utf-8?B?Q1ptdmhoWmE3T01zejFFb014TGxlT3BzTEw2Tm9qMTMzbVpVb3BnMXBJYlFE?=
 =?utf-8?B?T2JrbElqLzhUL0ZyeXlrVit1ZFk1SmRUODJQTW5kK1R3MmNHKzd5aE9xaXE3?=
 =?utf-8?B?YmwrdStwN3JiN1dQSHgwY0ZzVlUyWmlOVnoxQWpnS2hDVjhENE9oTXFiaWVH?=
 =?utf-8?B?QkUwNUE1L05TMnpleTl5MlVjWldjVEhudG14Zk5PaGtuTDN6MzY1NmozSEly?=
 =?utf-8?B?REM4clR3RlJmNlBNaFB5cDQyMWw5bWF5blczb05rUzlYWTVHS0p6TnpJUFUr?=
 =?utf-8?B?ei9xdHZVcDBSdHdwQ2lsVFJoMUxJdjlGZXFSeUYwdk5FbExGNTdUMDZUeVUv?=
 =?utf-8?B?OHhsZmtBNk1BbGlIVC9WcDZwRkZFTzdrbklGOFVSRXM5YjVSZzRINUFHbzZG?=
 =?utf-8?B?eUVaaVI2R3VKdVVFbHRaaWtrejcwbUYveXFuN2lWMDdHSnhoWTJqK3dGWi9p?=
 =?utf-8?B?ajYvMm8rbytTODN4MVF6RjZmZWE0cUdFL3NOcmozNVlBUGNCYjVTTmV0QU1m?=
 =?utf-8?B?SzEzWnBVMDVxOWQwNE92eW5aM3U4MkdyR04zbmI1MG9HOHlSNTFWUFIvSzNl?=
 =?utf-8?B?U2dOSTZIOXREOG5kem1hblpSYXpEU0pnazFoLzV3MlY5NlBLaUNOd3BzSk1m?=
 =?utf-8?B?L2dkYmErRzBWaU9QQkZuV0RpdXQxWTA1UGtLcURMK3NQdXlobzVQQ1Uxd0cx?=
 =?utf-8?B?QTh1OHVXOFhWd0NhMndMbTduVTlZWkJ2L0VLdGlzYnhKRzF2cUEwbGRQSmNn?=
 =?utf-8?B?ZldJSVgxTllpRDJib3F0Skx4VndqZFFkend2MzBjRUxZa1FEYnhYQ0hiOFA0?=
 =?utf-8?B?ZW96OUpPRWZVWW5HUnlmRnJ0OW5rVko5U3Z4eXhiWWh2ZGRFSFFyTGlmZDM0?=
 =?utf-8?B?TmNoM3B3eVBGVy9EdjVkclR1WmhHbTBQVjZjRStiYkxoOTBXWWJFWHI5RkN2?=
 =?utf-8?B?cGMrQ0NiSmgzbW5GbnZzVzNLeHVqK1VpY0hENTJoaVNMMGlQc2NCNXExYnhh?=
 =?utf-8?B?ZGU3VjRSem5QWjltcmpNTDI4c2FuUmFJK0hFbFdXNTdFZ0RwOENqZHVPVkt2?=
 =?utf-8?B?MjAwc2lnQjhSOGZrQmZCNDFIaU1Odkw2YkZPMk9qMXdPMnRlOUgyQloyV2NU?=
 =?utf-8?B?dlNJbkdsKzNFOGxWRk44cG01dVNNRTdSa2x3dkdKZzFCdWFYNTlBTklQVWhV?=
 =?utf-8?B?SmhFWG1uU0NNTm1GektPYnFVT0lEQXovVktQMEZ4WmdHeFpJTnhHYjNWKzJh?=
 =?utf-8?B?WDNGVE94RllWUUQwZVlGQ3huZFl4K3grMFVaVnlUY0FwRFFNNERHcTZ0bkht?=
 =?utf-8?B?WlVvWU5zUEY3cWZDSnlRQU9MalVBYnptcVlpMFFtUG5KS04rT09IV0ZQRGtQ?=
 =?utf-8?B?Vk9ja3JEbVJGRWJCTVlWSkVUb0ZFYUxzakN3NHBZUHltbFJYMm5OKzVNRVhR?=
 =?utf-8?B?TC9Lc25uQTdzSCtMQzVIQVFvNHhYVCtNUk8xRmhrUCtUTzcrdzh4enVqRTc1?=
 =?utf-8?B?MjhCMkN0SEJMK3J2OE1PNGM2eUxqaTJiYkVRaVVMNFYyaFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUJYOGdIQmRNRFBhTGJTYUd2cHZKMVl1QVRmcm9BRG5tLzEvTXQvSVNIcXUv?=
 =?utf-8?B?bkhJdStheElaWk9uWWYycUpsTGhzTFVyTld0dU5CZm45aFV4MlVtQW03djF1?=
 =?utf-8?B?azJIa2ltNGtZbkVKZW5rcTNEYmlLSDA4N0hwWVgyZ0QrZWNtVFpMU2s2RVRm?=
 =?utf-8?B?Y3pGZjM1d1pYR2JLb2lEZ3ErK082MTVlNFJwUzYzMjY4aFlLWlVFUzJIOEZm?=
 =?utf-8?B?Zmg2OEtzdnJOL0FkZTRSVnF4RGJTcFRGTEdZVlpvZmRtVVZFc1J1b2pMTHhP?=
 =?utf-8?B?ZW1OY2NsQ0c5dEpjMnpPNDQ3UURoYzNsYWpyY2Erd1R2eGQ2SW8zcVZNUXg5?=
 =?utf-8?B?ZmNZWjl0bXgySkFXa1dSMWlRaU13Q3RiMkJsNXJ1YnFmTEZpb1N1RjZoZWRo?=
 =?utf-8?B?QTZNUVU2NUF6VkoyZkpYZENqZmk3a0gzM25teVJFKzRDbFdjNmtMTU9qS0dx?=
 =?utf-8?B?eUpmK2s4Mlc5TVpWSktpanZZdkxjZW5vcGc3aXl1cHIzV3BEbnNrRU5pd1I3?=
 =?utf-8?B?YWNROFdUM3UvcHo5OHN0NlU5L2ZzakswZWJnTTZIZ3A2NWJxTDhLR3hocUF3?=
 =?utf-8?B?YytNV084MjNhY3djaUNISzVmbWNKMGV0YkYyRkpaUm9oMlZuY00xQTMyZVFL?=
 =?utf-8?B?MEdHMnlkTzBmRG1wOHNVRUw4MVp5R0d3WnIvakxNNzVTNjNjVHNPVFlpV3Nv?=
 =?utf-8?B?UDVPMm00bXNYS0M5bTcwa1lIc3RpRU1LaVlBeUp1Z20rSnJmcExnNTlwbmtG?=
 =?utf-8?B?NWh6SzRtbStPS3o5NWs1TzZzOW9WOFRUNnBqTG9XTng4MW5oY0t5RWlERkxB?=
 =?utf-8?B?N0MyWGN1bkdJdkYzdkpmMFlYUmNYNTJtOUovdkRvK3dvK2lUamxnZE5KUGti?=
 =?utf-8?B?bU92OFpJKythNWUzb2NDQ1NqQXJyREcrRjF6THVDV2NQM3BJczBnN2FMTXpi?=
 =?utf-8?B?VzZhakxiVEYyaEorcGFObEJOL0k4eXhsRUcvOVFsNGNWWDhIN0NGOFNRZXNN?=
 =?utf-8?B?UFV4STZ4RzArU1FSeWEzaTIyU2x5QmlLUzZ4cmRCclpudGhhNTR6V084aVQ3?=
 =?utf-8?B?MEFtNlVkbHhWK3VXN09FZWE0VjY0UmFKekdSMEpGQXErZ21oYXFYbDZNZ2lt?=
 =?utf-8?B?eTkva0ZWaDc3LzZsd3FIcUVsdldtazVRQi8wSVhCdWpLMWhXSnNuRHlzcFFO?=
 =?utf-8?B?cHhuYm1ad3h4NHgwdTFRb1dqaUJDSWZ3TUZUSVBYcXhXSm5XaFhmUmlJZlhh?=
 =?utf-8?B?NjFEYkdGdFFURG91UEtyRVlBRWhCbVg3Wjc4dUk4OVBScGNUV3FhWkdDeVlB?=
 =?utf-8?B?d1pKcDMzTlVEY0xmaWR5cXZGbGFFVDR6cVBhMkpXcW91Z2VLaVdwMUk3ZGl6?=
 =?utf-8?B?VlVPK3Z3K3JzMDNVU2ZBUHBWYldYY2syWStjU0JGYUllQ1lWRkhVbjE5WFI2?=
 =?utf-8?B?OC9ZMDYrRXVhN2RncmF6MmdyMVlUUEk1dTVFVUdFenV4SFpvL3lTWFJtc0Y3?=
 =?utf-8?B?bVB6ODRZTDJPUzhXUzZkenJYeGY2Qk0wOTVhdW8yWEIvWWZjb0M4aHpuUkdY?=
 =?utf-8?B?Wm80VE5xUnRqT0sxSFBQK3N1djVHM3Q5WGxrMVJ1enZNUEVDRm5VLyszV3lU?=
 =?utf-8?B?cHkwcHc0SnJncEhKQ1pZMHR6bGxEUmlFSU1tclpYY0UzeVNSL2RtVzVxTlBY?=
 =?utf-8?B?S2huZEFJd1RVT25TNzdPSHVYSFQwSE9rN1ZZWSt0WU9mY0ZmLzN0SUcvcGhv?=
 =?utf-8?B?NHFZMlJFS1FxOGtxU3E5czdFazB6b291UThBSC96WnlVM2xYamcrek1KczJ1?=
 =?utf-8?B?TzZLeEdlWkVpUkF2T3dDVzlrRTBpeS8vQ1dZNVFsdzJnblJmVXBVMk5RcmZ6?=
 =?utf-8?B?YXc0Z3JsVXdlUklBdFpYcm9pOTRJeUhzNjlJU0ZkNHFpYm5jbms3YmUwSXRU?=
 =?utf-8?B?SnpvQm5rNXJIamF2YjZYM3pKZGxtQ2JzMUZCejREdExHTGk0MktmV3hyOHF0?=
 =?utf-8?B?QUZISTZuTU83eENUVUtIKys1bU93V0pFRCsvSVhpYTNTdVdTZVh1UDYrMDJ6?=
 =?utf-8?B?WG9PRTdVdmw0aDMreFVoeWJSS1h2ZnF4b3lkM0tJTnpHNGdPWjI5VGpud1p1?=
 =?utf-8?Q?kcOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80F959B7836FD84FB49A3574C1FED9B6@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d170640f-e606-4135-805d-08dd1b21c9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 02:56:49.2126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cu93TefQWovaLMoVT5TC3UN1aN1GIV4Nv+yCWpb8xin/ji25psBoZE1FaxZUozOrCJXT9nAgCyU/TqmdIzw/Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
Received-SPF: permerror client-ip=40.107.95.80;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

T24gMjAyNC8xMi8xMiAyMzozOCwgQW50aG9ueSBQRVJBUkQgd3JvdGU6DQo+IE9uIFR1ZSwgRGVj
IDEwLCAyMDI0IGF0IDA3OjE3OjMwQU0gKzAwMDAsIENoZW4sIEppcWlhbiB3cm90ZToNCj4+IE9u
IDIwMjQvMTEvMTkgMDA6MDUsIEFudGhvbnkgUEVSQVJEIHdyb3RlOg0KPj4+IE9uIFdlZCwgTm92
IDA2LCAyMDI0IGF0IDAyOjE0OjE4UE0gKzA4MDAsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4+PiBJ
biBQVkggZG9tMCwgd2hlbiBwYXNzdGhyb3VnaCBhIGRldmljZSB0byBkb21VLCBRRU1VIGNvZGUN
Cj4+Pj4geGVuX3B0X3JlYWxpemUtPnhjX3BoeXNkZXZfbWFwX3BpcnEgd2FudHMgdG8gdXNlIGdz
aSwgYnV0IGluIGN1cnJlbnQgY29kZXMNCj4+Pj4gdGhlIGdzaSBudW1iZXIgaXMgZ290IGZyb20g
ZmlsZSAvc3lzL2J1cy9wY2kvZGV2aWNlcy88c2JkZj4vaXJxLCB0aGF0IGlzDQo+Pj4+IHdyb25n
LCBiZWNhdXNlIGlycSBpcyBub3QgZXF1YWwgd2l0aCBnc2ksIHRoZXkgYXJlIGluIGRpZmZlcmVu
dCBzcGFjZXMsIHNvDQo+Pj4+IHBpcnEgbWFwcGluZyBmYWlscy4NCj4+Pj4NCj4+Pj4gVG8gc29s
dmUgYWJvdmUgcHJvYmxlbSwgdXNlIG5ldyBpbnRlcmZhY2Ugb2YgWGVuLCB4Y19wY2lkZXZfZ2V0
X2dzaSB0byBnZXQNCj4+Pj4gZ3NpIGFuZCB1c2UgeGNfcGh5c2Rldl9tYXBfcGlycV9nc2kgdG8g
bWFwIHBpcnEgd2hlbiBkb20wIGlzIFBWSC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogSmlx
aWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEh1YW5n
IFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVu
IDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4+DQo+Pj4gQWNrZWQtYnk6IEFudGhvbnkgUEVSQVJE
IDxhbnRob255QHhlbnByb2plY3Qub3JnPg0KPj4+DQo+Pj4gQnV0LCB0aGlzIGZvbGxvd2luZyBj
aGFuZ2UgcHJvYmFibHkgbmVlZHMgYW4gYWNrIGZyb20gUENJIG1haW50YW5lcnMsDQo+Pj4gQ0Nl
ZC4NCj4+IEFzIFBDSSBtYWludGFpbmVycyBkaWRuJ3QgcmVzcG9uc2UgZm9yIHdlZWtzLA0KPj4g
Y2FuIEkganVzdCBtb3ZlIHRoZSBkZWZpbml0aW9uIG9mIHRoZSBtYWNybyBiYWNrIHRvIHhlbl9w
dC5jIGZpbGUgPw0KPiANCj4gTm8sIHRoYXQncyBmaW5lLiBJIHNob3VsZCBiZSBhYmxlIHRvIHNl
bmQgYSBwdWxsLXJlcXVlc3Qgd2l0aCB0aGlzDQo+IGNoYW5nZSB3aXRob3V0IHRvbyBtdWNoIHRy
b3VibGUuDQo+IA0KVGhhbmsgeW91IHZlcnkgbXVjaCENCg0KPiBDaGVlcnMsDQo+IA0KDQotLSAN
CkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

