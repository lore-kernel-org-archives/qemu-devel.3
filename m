Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6EDE9A052
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7RE-0000Ug-Vh; Thu, 19 Feb 2026 12:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vt7OZ-0007hQ-QF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:00:57 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vt7OX-0005m4-0V
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:00:55 -0500
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 61JFsVYu1546620; Thu, 19 Feb 2026 17:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=3UwXqHLNYyCaM1K1XdsQ8Wt8ot5mPwIvKpqrzpAFRBs=; b=
 K1QW3Zqz2OHI6OnQSiXStqyHfE9iIxx6ZUzBVzghgoh5tmR90f1HMhWGLgvXvK6T
 LyzkZqDOkkOTlYssuEHm1NttVGpthgX4QKMC1MjFaFdLmjBZrrXmasahVMg1egYL
 VMWRfpJx49PXGfiHGwJP1qu2p0D5qCAdV5iWSnBU8rBBJ1O1GZNmY235y960q+TC
 zA27Ub0ld+WEfcmYiJmL5fpGvSsWJZZzWxB/6wC7bdxIc9wCuWbC/SRZPrKB6HtN
 EA7K5RGS6JPTjGZUYVqGhu+Hdk9oEn4oKrKAXWoSr6r2DBcVw0qwq0H202UGLD37
 EDEsIYOlOlomgQzgEJrh1g==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4ce583rnns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 17:00:51 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 61JGmpNe011656; Thu, 19 Feb 2026 12:00:51 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4cdgj601v4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 12:00:50 -0500 (EST)
Received: from ustx2ex-dag4mb6.msg.corp.akamai.com (172.27.50.205) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Feb 2026 09:00:50 -0800
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag4mb6.msg.corp.akamai.com (172.27.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Feb 2026 09:00:50 -0800
Received: from CO1PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 19 Feb 2026 09:00:50 -0800
Received: from SJ0PR17MB4301.namprd17.prod.outlook.com (2603:10b6:a03:29a::20)
 by BY5PR17MB3731.namprd17.prod.outlook.com (2603:10b6:a03:236::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 17:00:48 +0000
Received: from SJ0PR17MB4301.namprd17.prod.outlook.com
 ([fe80::8159:aa6f:8ecf:11f]) by SJ0PR17MB4301.namprd17.prod.outlook.com
 ([fe80::8159:aa6f:8ecf:11f%2]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 17:00:48 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v3 00/12] net: refactoring and fixes
Thread-Topic: [PATCH v3 00/12] net: refactoring and fixes
Thread-Index: AQHcoRUvMWQaQ4m620ycRZV9OUg3EbWJ7JmA
Date: Thu, 19 Feb 2026 17:00:48 +0000
Message-ID: <6B3E0042-4C30-467E-87AB-613551599F0B@akamai.com>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
In-Reply-To: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4301:EE_|BY5PR17MB3731:EE_
x-ms-office365-filtering-correlation-id: 87126371-5359-4bad-a1bb-08de6fd86e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?M1dIU3VNSHVLV0hmMjdhT3BOc1JhVnN0TmhoelZIY1A0NnMrOGtCZ3dVc3o2?=
 =?utf-8?B?L2liVkxVTmhZeW9hdUhPb2ZwSFMweVlFT3gzWVhFMnFUamN0UkFSVEpUd01r?=
 =?utf-8?B?RlEwTm01a1I4MFZhMGZYUmZZdG1OUXFuQ3NtWVpoeHRrUFFuQmlEVkFDelor?=
 =?utf-8?B?TGMvT3JCeStCSHA3NFQxTjBPb3VCWTN5cnRJak5ScS9iUDBpaHRSQlJHeUR5?=
 =?utf-8?B?dWl4amRLSjJDcE9ZZlpsVlg4MmFWRmkxTENzT3Q5ZjRXZGE2Q3NKbDRKQVUy?=
 =?utf-8?B?R0xuTk52MEIrSytyOGRraUxNOG00NHpiRnJCRFA1clJwdDFWVGxMYk96Mm55?=
 =?utf-8?B?NjVWS1NjTHdwS1A4eGlrRCsycGxpb2dOSDFtSWVEL05ZaWhwbVFIMDFVZCtT?=
 =?utf-8?B?cHdrT0hNbWxrUWdMRE9mTHprTmRsL2pKNHdvM21BM1c0N0JXTWZNQStLdndi?=
 =?utf-8?B?MnNRc2tncHRPeWxnLzZXdVJYVnc3WGdrQ1Q4V0FxQkt6ZWF6bTErVXQ1ejFI?=
 =?utf-8?B?ZTlOWHZUMGoxTEZ3cDlnNEtnU3BSZkhKY0R6alljbjBVQkNQb3hCQ2EySjkx?=
 =?utf-8?B?L0JyMjdTaGtvQUU1bHJpYXRVZXRoQWtteTBIWHdVSDVKVkt0VmNnVkNZR1Z0?=
 =?utf-8?B?OUFUL3A0ZHR6SWJ6bWdqM0ZzYlJPdXJKRjlRNzljZzdCODhVd2tFR0hMQTEz?=
 =?utf-8?B?bG05WjhpbFN3NlhNSkZUbyt0S1NVUmhKRnJwNHZQdm5sMTFVVjYwL21vc1BQ?=
 =?utf-8?B?dWdLWnpNUGlQeXhhS2RQV20rY29ITEF1ZmpNajZvNmlXdUk4Wmd4VjZkMmZN?=
 =?utf-8?B?MnhiY0gza1BzQU9GN0IvckpCT2xIdjF2WTFySFRrT01rdVVLSHRyNU0wZ2V4?=
 =?utf-8?B?bDkrZ2lZYURMbFA4ZkF1T2c1dnpEVkhYbTRPMm9FeTBVWmFPVmdMOE5LcGpH?=
 =?utf-8?B?R2tyU0w1eDFWM2NoN3FoSlRBRmJMNmNrMFozQVdBSDY0eUF2VnBnVXZqYmVU?=
 =?utf-8?B?ejg5MGg5TXdEQzNrTFloWCtIR2hNaGRuSms5Y1RtVWRUY3daOFpDOG5LZFNn?=
 =?utf-8?B?VFA0NWZ5VzJPb1UzNVZyNytwTGY5Zk1ZUXJ1Z2Y2U21qcHkyYm5EVjZCRDJq?=
 =?utf-8?B?Sk81MVZJVUdWTlM2S05OZG9xdDVnOHcwWGFva2VSeFZxcytnZWxOTERpanN1?=
 =?utf-8?B?K2lJcHlqUVY5d0VQY0x1VUVLMVhRZCtpenFrM0ZBcEtud29hdVloaThoYWtF?=
 =?utf-8?B?dzl0NGJkWmFkREsyQXY3eHNGQUZRaUltc0dEaDVYMzkvNFdjNnFiRkhPZmNy?=
 =?utf-8?B?azVkUDl5YjRQZG9MWmdCSU4vYU5kTkdwQkpnWkJmTlV0N3NMNUFuSCs3TXdz?=
 =?utf-8?B?QnZxQWNjTEZuTk05YW1XNWt2a0ZoU2RUMUx0WThwM1ZudmI0bHo2bEdiTVEz?=
 =?utf-8?B?Z1VvUlYxd2hQa3VEU0RSWFAydnRmSEJaaWhaSVpVZTJJUnFBWktxV2NBYU1G?=
 =?utf-8?B?eDZaWDRqWndWNTdWUVh0NGJjNTdvRldWY2orT0ZxcVRzOUthbldOaytrWXFJ?=
 =?utf-8?B?eTRTak01Zml0eGpLWkFsUEEzQTg5MW5YRmJaTHI0eVIzb0RqQllNdXpxbGdO?=
 =?utf-8?B?anU2NGpqNEJPVGxndy9DTGVaaktUYVp6U29LcS95ZnNwaWZibW1tcDJwckhX?=
 =?utf-8?B?NWJ6OUdWUktBREIvMEZwSHJXUEEyNjRtLzg1OHowOHZFMnJQY2NkYmJPL0lq?=
 =?utf-8?B?OUV3NXduQ1FFM0x2RWFwVHNtWXVjb0NIUmp1TlpNalRrL3lEL0NITnFwaHZF?=
 =?utf-8?B?ZDVwWG1oRU5QZ0VEZGs1Q0JUVWtkUVNQOTRvUkhQRXJVdFdwQmQ5cVJVY29C?=
 =?utf-8?B?c3FDRDBmUzB2d0N5bHY5c3UrNnV4WEZiNVFzVmhDUkMrL2NQTWY1U0RsU0Y3?=
 =?utf-8?B?Z0RJVnpVNURrNnBFOW81SUxtekJyQk96TldIdzY1TktFeUR0R2kwK29KU0l1?=
 =?utf-8?B?NjE1VWlKNEJTNEYvUnVnbUMxbjZ4Z2xrRlg2VlNKZnJVYWJyUExnZkRJZEJm?=
 =?utf-8?B?amd4NHJCc0kwK3JCenZhbFJTUE9vZUM1ZmJlRG0zbHBETThyaGg0QnE0ZEZV?=
 =?utf-8?B?K0RmU2NIbWpDbnFBd0ljU3pxZVFzdU9oU3dsZ0Q2M01DdnAzWnI3VnVpaG5i?=
 =?utf-8?Q?GVEfHoItoSXhq0o4UgEyBSU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB4301.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aElWd0NyallGc2pDYjUwNTZpUnNpczZZMnRnZ0pwVWc2N2hZaUR6OTFockNH?=
 =?utf-8?B?TSt2NjN3VzBYYWh3T0FtRGlPekphQXhsSk8xNk41R3ZVTWxuVFF2alFyTVds?=
 =?utf-8?B?emZXMTM1L2h4ejlvNWhsaW1FNkJSa000MVFnT0pZSDg2dDhiNFoyZ21hZGY2?=
 =?utf-8?B?TVFxcDY4TnVmcThiZ1cyQ3VhQVNPekdmVHJpVlpmMHBLNTl1blRZajB2dk9z?=
 =?utf-8?B?WG51UUNRQXBGTFJ5NW1sMFJDRG5OdG9QRHQzSU1vaGJiNGNzeEJuTWcrSytO?=
 =?utf-8?B?TkZuTWdTVjNWQkRwOXV1YjU5aHJNd21LWDhHZk5NUXA3NEMrUFBHblBXOXE1?=
 =?utf-8?B?TnRiY3B2VjVmVlBHbmg5Y05wVWVHbFlmeDk1RjJVTFB5cEtEcTFRc2VKcE5F?=
 =?utf-8?B?bGtFZmFFV0VGNUE2OEZ4MCtjYmh2c3BCcGc4dmN1bVF1QnUvc1hvYkZjNnJZ?=
 =?utf-8?B?cVpVVU1TNmEzSWZzSE5NZUJsSUsvckJOd2VwazB2bk9GL0duUnhLY2lvMnkz?=
 =?utf-8?B?Tkg0Tng2aklYMWZDRXZZWnFaR1hSaUtOM3VYZ1A0YSt5RGRpVlJlOTZoSnB4?=
 =?utf-8?B?QStlR1l6aUd0QlVZUk96bWtIM3dRSFpud2pwcU4rOUpkL2orL3M0QkxXYXF5?=
 =?utf-8?B?YVd1TTN2amRIcjZmUkxmc0ZJaUNOanQrL2pzdXQyejhCam00SE90RzNEdGpC?=
 =?utf-8?B?SVVER3ltZFp4YnAzYlVmSTlVUmMyMlkzWDdSY0d3YjhhQlA0YUpEOFJ6ZnE0?=
 =?utf-8?B?eEFYUUdVUzJOaW1peGkyM1JwWTg2TFFrRlFKaXF0L2p4d3dyOVAwVDljQ0RL?=
 =?utf-8?B?cFFrK2pUS2Ryclg0QWJWOTJKKzMrNS94dGl6M1hXSk5FeGduUkF3SlJmc0Ri?=
 =?utf-8?B?VWFGVE1wdy9HQzFJcm9xNU1xV243UVl5MjduWi9xNHVTMjROc0s5QzAvNVZm?=
 =?utf-8?B?Wnh1MzQ3VmExSjFYUU8wNjY5eHRMOVdOcHRsUXZpTXQxV1ZuRkJ6d092UVpJ?=
 =?utf-8?B?aDMybmNkWWs5Z1BKUFZoU2lSTlA5WEEyMU4rdmlyTHo1em1sYjhWZSs4d2M2?=
 =?utf-8?B?YmV1OHpVSnViWkpoVzdraEI4dlozWURPZEtnSnppMnFBaVVxcjF2UlJoQVFX?=
 =?utf-8?B?YmpNdzVielZYbEMrTGNSZ1pIajYyRHVtVGJIdm9ORzZmUHlUTG1vNDZQUFNZ?=
 =?utf-8?B?N2ptek50Q1FiWXN4aWQ0OUdFRkN5TTY0S2NFWlZwWmdvZHFRWk45a1I2Q3Nt?=
 =?utf-8?B?cnAzbnpoNG5NZHBSVWlWQ3JYNVdlZ2tOYytzQ3lzbitYbjczTUpLS3hxeW1F?=
 =?utf-8?B?bk82TzBjdWpuWWhYcllqUGRRN2lZRFdMeWovZk1HNkI1cUtBNTZyZ3k5M0RB?=
 =?utf-8?B?b1JJeWJGb3pvb0l1MGtEdldZSDRnTDF0bTlmSzhtaXdFVHRCUFJsNGFHbmZS?=
 =?utf-8?B?ZDFxakd1MjdyN1RSL29qS3lETmpPQTlFT08ySHV5R2lpYnZDc2lVZldUejNK?=
 =?utf-8?B?a2tJTmpSY3Jzc0ljdHFuMTBLaUFTOEhycDdWN0hxaDIrSE9OWEl0MnVXODdK?=
 =?utf-8?B?Yk1ucUpJTUFlcHp5OWtJREJrV3h3T0ZBdjhRS28yNE1HQ3A5TVRrZmNZV3Z4?=
 =?utf-8?B?dnU4bFFrTXBQVmVhUXhNbzk0VG1IdGg0bUZQQXVoTEdVTW41VFAzeWxyczhC?=
 =?utf-8?B?aUQ1b0lSSGdjc29SdjIwaGg5QWdPR01MRTJheVFhVFh6YkZVRU5WOEJENDBs?=
 =?utf-8?B?M2FkMmN6SUJKYjRDbEdRTHZLNDZYbEZrd0ZFNjM3cDlkWi82Sk5CelVvL3FU?=
 =?utf-8?B?Qy9YQ2d0UHI1a0ZTREdkaE40cGtSSzhYWlg5K1FRMnNBZGtOelhHaVMwUU1V?=
 =?utf-8?B?MWE4azZFVFM1U2xmRWZST1dVWG1YbDhwTW9HWHhheUdNUVFsZlQ5bExTSHhQ?=
 =?utf-8?B?Y0I4Vm9JRGNSQ3NFOERVTlhDa0VUYUFUWXFidjJjZ1FpRm1rV0ZsL2liaFEv?=
 =?utf-8?B?anpxWnNCZCtYUzBtTWZNdVpLVTFaY0FiUnpDWmxCbWhwb1V4WDY1NS9pZXVz?=
 =?utf-8?B?c1d5aitHZ3d1bEg4dzB6Y051ZFR4ZnpFRFVPUWpPS2Q0MU9VVkYwU2tKU3NF?=
 =?utf-8?B?UitaU2RPbUdoVm5QVTZGUEFNbTQwUldoM2RRNnpqOFlNSGVPWStDZE0vYUFy?=
 =?utf-8?B?TzJYTHlldmNRTEdHRTk3RHdwNk9oSW5VWWliSkUwSjBVTzg2S0hrQ2hIVkhm?=
 =?utf-8?B?MGZFeWd1anNzejBYWTUrNkxCU3lwazdTdG1Eb2I2U0JGdjZoQ1U5bVRnSHR3?=
 =?utf-8?B?TkpzVUc0bHFHVkl5bmdIUDVGakRTRkJSaHE4Mmd0ZURCZU5Zei8vRmVMS1pI?=
 =?utf-8?Q?rVsob9LOX0i+0x4izFUDUONjNqm5X6tBvv7wo0+PDAzQw?=
x-ms-exchange-antispam-messagedata-1: yVQJpDiu2kI3dg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7PAft3rzHtsb0HqYfZ828niEC1TJRlVN+vHNNl2TWkpUq5iy/zH58akZayjtFsx4wk5Fmn7c9A8gAPBDaKAUyRE8/v2rxkumYtVMo/fwutntPNPClwjsTIT+7MaXSc3R/QfeerbnSdBTI1UHlZD87IRCiPml0/5F35ef9IHtTeCquzfz+hI6NEPZt3+Kod6YjqPCZIRpekstkrUILBCn6BH7LHdI8qGtR/npvhZI2blszuOZSq/w+kfef2th87XV0Y5MGzxdUOj82pd3W53GtLccVGuwFn1qmvjPVLc7uw+Fq5uvsuKJ9WNE2t1kYRT2qZSWD26iBBM0G97Ioyk3A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj+yZaUu0bxIbCakxYx562fFjIIMHGZiWpMo3vYj6oE=;
 b=S+hk1O4FFAFvJ3hApSYGphmWFIs6aIZk9r8o25Np6rYY8I86FzP2L0/zG3HUecySaRzCWU25PLjYoZ4Udu3n4wANg68tDOySxsZ0zV00xydimYGYj4Hl3OW8I5cAszxK2++sHJ/rg2gLDyN5EB4ZCh8/91VjyrwyPeQkxbmBY9Vz78JBwxoT2vIm//vsA2V4PWSM6k+2+8ndvOnORNxNghuDu0Qx3/YabHBkE0/e9L9aHX1xaRDO0s+11fGG1+mL4QaRaw0zMgeYzz7Nx1KVsjgsRHs4ZhjxiVCtw58WJQAhOqhu1iWdYh2STfPXk2oAfcTyzwmPJEykI/sc8qVCaA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SJ0PR17MB4301.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 87126371-5359-4bad-a1bb-08de6fd86e0c
x-ms-exchange-crosstenant-originalarrivaltime: 19 Feb 2026 17:00:48.2559 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: axSvHVzP1PGGUqOUWpbLpW0g/yOotA8HFdDuxCL0x+F3iNOiXOhH8kBEpcJ6FUv4T8D90+9jH3khWyUBmtFmAA==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR17MB3731
Content-Type: text/plain; charset="utf-8"
Content-ID: <42D846E71DFBA542A5EFB958BF83EE0E@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=791
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2602130000 definitions=main-2602190152
X-Proofpoint-GUID: anPyJqTKZvnMRfsz4DTLxdjuWFMV2_QC
X-Proofpoint-ORIG-GUID: anPyJqTKZvnMRfsz4DTLxdjuWFMV2_QC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE1NCBTYWx0ZWRfX6RP3vbB3/G1H
 vPNXiaGsRNGMHi/oqYKv4vQbUyyIf1u0WZ/zERzZ/HlYHuX0WeeWvoNn1MoYShzrQzuAbOD9deB
 tpJvvw5SPqNuffBRD5AcKuLe9TO1Eib12QZCwcHar+U5fG/lORoPTlhAHl9Nc5GnOdwKrDXry4S
 Samuegq+zAsULdozs25KeMBNhf3rGOT9f17LnDj48hIFhtW/cpN0y1UQbYmi8GPRj9+qZY7OkGX
 B/LqZBt+3VPT36DoMSofMS5ZNyQ8Or2wskx8yuyctEVjfDA+HWEmb+BIawS+hHHqgMx9PNuxngH
 31OeX2W2SYN/Puvd9RNFwwkFph35/2ziaHRNSowyligZ6JyeMcJjodNlKmEcA/FrzEo8smpafLk
 +QDXonpebLPB97XL7ydEkkVUmsGWLsTz6Y5DCXFelg5jPL63hHu0ktQejTWO9PbL8t8nFt5IEpU
 dx81+vAZWP0kM7OnwZQ==
X-Authority-Analysis: v=2.4 cv=FoIIPmrq c=1 sm=1 tr=0 ts=699741c3 cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=X7Ea-ya5AAAA:8 a=5kbH1uW7I4_BE9JXpVIA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190154
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
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

PiBIZXJlIGFyZSBzb21lIHJlZmFjdG9yaW5nIGFuZCBmaXhlcywgbW9zdGx5IGluIG5ldC90YXAu
YyBJJ20gbWFraW5nIG9uDQo+IG15IHdheSB0byBpbXBsZW1lbnRpbmcgVEFQIGZkIG1pZ3JhdGlv
biAodGhyb3VnaCBVTklYIGRvbWFpbiBzb2NrZXQpLg0KPg0KPg0KPiB2MzoNCj4NCj4NCj4gMDE6
IGZpeCBjaGVja2luZywgc3dpdGNoIHRvIGludCB0eXBlIGZvciBxdWV1ZXMNCj4gMDg6IGRyb3Ag
TUFYX1RBUF9RVUVVRVMgY29uc3RhbnQNCj4gMDksMTA6IHByZWZlciBpbnQgdHlwZSBmb3IgcXVl
dWVzDQoNClJldmlld2VkLWJ5OiBCZW4gQ2hhbmV5IDxiY2hhbmV5QGFrYW1haS5jb20+DQoNCg==

