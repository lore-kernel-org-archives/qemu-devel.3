Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC1FD3E77D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 22:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTSOt-0003rp-Id; Wed, 10 Dec 2025 17:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bschubert@ddn.com>)
 id 1vTSOp-0003lf-95; Wed, 10 Dec 2025 17:11:07 -0500
Received: from outbound-ip191b.ess.barracuda.com ([209.222.82.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bschubert@ddn.com>)
 id 1vTSOk-00013T-U2; Wed, 10 Dec 2025 17:11:07 -0500
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11021084.outbound.protection.outlook.com
 [40.93.194.84]) by mx-outbound20-251.us-east-2b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 10 Dec 2025 22:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQeVLs/M0UxSQA7Ls6kIP2t/JGcmwo7H5Cm7KGTkfR7QWrtX7GnbjRnWfVKkD/rXEh0PsPHeZF3Nn+Wd4PTj7gHCnBwlEsWbxO88CMd2vtwoVC9Jc9rTbAAQxyQMd2mqFLlgRLKV8N1MtNTry/j4oVw2wb6jSCQjADe+Lw+z0DPyOG6lhizsNPdPNS0hynElnI+Rk/urxmMzHUJ0WCeqqtC/uFF125QEkxAgXWS1nsjrgCbBrAOL67PvMmQpi38Y/hGaDozOJ34pwVZYDd8mM2XZwsqHbWPxLwt0MzkNCjmCaa6rlaAa+FXqAKq8WqspqBjD0ZEgaNFULo4flhZ5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHpa1HhqdYTLqpQ9QJXJdurRMQ55DT3j6onswGQr4C8=;
 b=MBhSGAA9L1h7YMWRFagLKaC3nL8uCuguT1zMWnhfGnkxHsDZgNr4HY9WlOJ+7dn3yQgl3QUMjZVaLm9G43eIXOP/cIV9ydWzM/+f9BVehwjpC5P9WvqJG5fce2lFyXykR97JvE+zTm4a9g3uARblqISHutchQyFv+yU9yxDdL10OjkgW5EBQ1argzYU8Q+V5TzlzHFp2T2TYO1ihipfKsmoul52j/LxiI6UxbLzetPoNeniq06wF52RyPZFtXqzQgrD4rTBjr9J5Sx/rFPZDVzkcNstF2w6X/Hn2ZNP4MCV851zMC9ewYSY+w5jRQh/k0/ExvSuPVsEHF4DXlRhvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHpa1HhqdYTLqpQ9QJXJdurRMQ55DT3j6onswGQr4C8=;
 b=NxBj5UkDy7lxpXJC9k23blQCXVDGQEtMLOpvsEBMe/mbQN77DRAVWaXpvLxOcUf6xPKc5IcUnB9aEATfWGkkcsd9BOHjW8WZO/7lEo/D3LPwHhiudncQysXryNMoDFGSv+eUjUbj+0LJYbol4X/6XPqd+N/4a/ivLewxAOCizMA=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SN7PR19MB6972.namprd19.prod.outlook.com (2603:10b6:806:2a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 22:10:51 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 22:10:51 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Brian Song <hibriansong@gmail.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com"
 <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for QEMU
 FUSE Exports
Thread-Topic: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Thread-Index: AQHb9oDe2/mwNJp7TkWecWngdBHPObUcVq0A
Date: Wed, 10 Dec 2025 22:10:50 +0000
Message-ID: <6ef9f104-3a04-4065-8e57-40dc3ace98cd@ddn.com>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
In-Reply-To: <20250716183824.216257-2-hibriansong@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SN7PR19MB6972:EE_
x-ms-office365-filtering-correlation-id: de46fc42-970c-4a4c-e3b5-08de3838fac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|19092799006|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cERXSytVRFB5ZUIzaGptTmRLVGhkaDIyaElWTjBpNG1KV1lBbEV0dmFvTTFT?=
 =?utf-8?B?eC9OSU5ZRWhVdTZPS3RUd1RjSkw0QjVMUk5TTCt4SWFkMXViMnNVUkl6THdo?=
 =?utf-8?B?c1VUK0g1SlA5dzQ4R2lKY1pKV0VHQzdzZ1lYL1U3Sm1kQmhVenNvTWFET0dE?=
 =?utf-8?B?TnpmWVVseDNCUHFFdHJmS21HNkx5R0JmUW5ZQlUrVUtjanlwQVFwS3QwaE5z?=
 =?utf-8?B?bk05bERaUlAxckJBQWZIVytXcTlRMWJyZXFqMW9iYWw0MGRGVjJYNDBvOWpT?=
 =?utf-8?B?ZUE0S21NYnloQXIxajVMcXRHRHRjV0N0WGFudVo0bTR1WG5pd0Y3ZS85aFU2?=
 =?utf-8?B?dzNydWtaWGhnc3J0SkhLdjI0K3praUZQMHVLa0IzcDMrOWs2b3VnZDFrVUNh?=
 =?utf-8?B?NStrdFBvUUV0Qk9LUDloa0g2N3M1ak4vRHd5VE1PSUI3bVYwTTQvOThmdG03?=
 =?utf-8?B?eGlvZWVzaGx4YnlqeXltMEFmMnkwMStMOVZmRW0vWDNtc2d0M1dSVmdJTmpM?=
 =?utf-8?B?eDkyL1JGelZZR09icXFGNHlyNEJxa2ZoSEQyTFBja0ljZXUzcnVsOHIzTzJu?=
 =?utf-8?B?NUxqQVRrOVVoRXpVWlRpa2dPQ1lYaVdqT016bkRoZ3hid3NnMTBzU210Z3Bv?=
 =?utf-8?B?eUh6ZFpKYmxncFVzUDREcTRHRVlKRWdUTlE1ZnRpYmpDbjQxQ05aZjhCYW5I?=
 =?utf-8?B?N1VJd0pNNlBtSXFyL0hqcHQxa0lYRVJISGJsbjRDS2NjK0QrVjdYaCs1Y1Vi?=
 =?utf-8?B?cGZES3lGR21mYzVxcy80K29uaXhlK3RXMFREcVdnUG42c1NFWnhFYm9DaWNh?=
 =?utf-8?B?ZzlZWUVpVGc4amEzTXl2aEd5dVhWdHNmWjFrZ0xseWxvQ3doNnd4OUhXOHlF?=
 =?utf-8?B?QVVFZDBxakVFdVFNYUZ4dXJlcEhLaW5wdVUrdDZTL1pRWXRXMWU1Tk1TL1J4?=
 =?utf-8?B?Y0xVUVdPUWlraEtGMWhReEFCcWp1YWwybUJJaHZnVWxkMGFUdlBXaCtlT1E2?=
 =?utf-8?B?WFFIY3c2d1g1T3pzbERscjVWUmF4VDFXTHc2aTFYOGtiTHhpVEVlVHZCRjdW?=
 =?utf-8?B?MmZ6enNORTN5UjFtd3VybTkvN3dCSmhWZmZPdmJwSEc1WkxIUnFtdE1KYk5M?=
 =?utf-8?B?RVZ3NGZLWFo2VHlwaVJ1c3Y0WkQxN0JSSjROaEJMb2FsYXhkczdzYmVOSEtO?=
 =?utf-8?B?S1I5dXpudlliR3pCRld3YlJHQVJ4R3NlSzFVaDdGN2lLQmVUaWJuajBuRU1L?=
 =?utf-8?B?MmhnUjkxZGtibmxwMTdHQUpiNkoyZjlwQ1VPN3V1akFNUC9CQjcyQlF2VTJq?=
 =?utf-8?B?SHZwSEZlTmtoOGEvakYxby8vSzg4dm1JY01oWlF3VTFLdXdsUGlMQnB6cW8x?=
 =?utf-8?B?Smc1RythN3RGaEdBTTRwMjhmcTN6OHlKUHFLQlRQNUp2S1YrUUFCMlVVRzBa?=
 =?utf-8?B?bldZTkFMWGVpZDVWWmFpRWVQUERjYnJQVzhHTHU3MFA3SnhkQVhjT1VMUzMw?=
 =?utf-8?B?MGIwWmE5M2RQMWdqUDE2cUg5QklGcWdUbTJ2VnB6UmlvOGdXSGlHMGhHaXBP?=
 =?utf-8?B?WEFQaHIzd25nMU1JTTNwcWtRVWxmb3JpUzNCdjZSM1VZU0hxemh3UEtNdFht?=
 =?utf-8?B?QlNiMG9sOWpCTEpIWTBnSURjdE4ycUxZOFpDbmFQdnVlakFjZG5uSlMwWWpo?=
 =?utf-8?B?R0VwTFZLWFB5bzEvc203ZWN0QlNYQnIwSFo0WWExTE1yemJrcnV4UTBSeGV4?=
 =?utf-8?B?NWYzTGJrNE1YWVA2RzZxTFF5N0FpWE9DWTQ2Vlp4T3BSMU5OREEyOVVEMGZW?=
 =?utf-8?B?QkdYR1NFVUJwT2pYM3VMOTFEUlNuckh5MXQ0TkZWQmlyUEZCbCt3VmRPYXlP?=
 =?utf-8?B?TmtxZTJ5TUFqQ0cxRHpBVmxtLzBJb0ZTbzNKZHYvZU5CWnpuRlEvTDdOMmdv?=
 =?utf-8?B?UnFKeFJxQThOTjdXSmxqTXZLNzBmWTVMN2ZXL2Ywc0dZWXVzMENOUC9qaS9E?=
 =?utf-8?B?OC9XYWlQZ2VBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR19MB3864.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(19092799006)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGRDcGlOY0RBNWpyMUt6Wml1R2Z0bDkwTE9BRVY2VXF2Y0R5REkwV0lmc3dW?=
 =?utf-8?B?NFRkKzh1NDV3SG14WFFxajJES2VIQ2NKaFVJQXg3bnlaRm5GbHdvRVRHQmgv?=
 =?utf-8?B?VG9Ic2FpLzZMTTdGc0JkNHZZSllTbkYrZFVyc01LYlRvaWpSNkFTVXdoa0NE?=
 =?utf-8?B?VDlEOFRzRFpXekJqTGsxTGRKaFVtWWhTb0hxMUhkaC85Ykc2MkRwWkp3UEY0?=
 =?utf-8?B?MTRlMWxtZnQ0aVBpQm52VStwQk5uUmc3VFhkU09wYStGSGViV1FlaURwcVJH?=
 =?utf-8?B?UnVwZTlHZmZ4NnRpQW43TktOUS9jb1oyUURIREVpVHBLakpmYTN0a3g0VjA1?=
 =?utf-8?B?RkpNdG41ZjVQdk1HTzRqYlNkQWFzZGlnaytXRDVTQ2ViSXJoY0tmdVpQekY5?=
 =?utf-8?B?YmtlVkFncitORHlQMmUzbmRaN3R0b2xHL2dQcDc5RnVmdzAxdGZZSVhTMTkv?=
 =?utf-8?B?QXlyMlB5cDZBV3Zjckd4R3J2OVRWNExFb08rRnhlRG1GaHB1aTA1QXcvOUsr?=
 =?utf-8?B?c1dtZExmaWNMang5SmoxWGdTVUlkV1ZvT01idENpWHRJZFZGRTRvYjJOSVMr?=
 =?utf-8?B?OGhuOU12VWQvcFVtQkdPUlJWU3VQS09lUTdyKy9kUTJJM1VPaHRoVzlvbmFn?=
 =?utf-8?B?VXh4NkhDckFUNmpqVWR5S1Bkbzk0R1pXb0NKLzNHdkNYQmVUbm9TT3VlRWpW?=
 =?utf-8?B?Z3VzTFlKMHBUY1hGVHNCMDFodEZvZ3ptNllhcjBFcDNnZW04cENRVzFaalY3?=
 =?utf-8?B?Z2RadERTVUt2TkNRVlNSNVFsbnpzWEl5Qi9ONnNHRmRrQlZvMElhZ1JqYU5H?=
 =?utf-8?B?WFc0T2hscklpSW8rQ3htZHpBR2ZTazY5YXlmWkRJbU4xVUpzdVBicmlvUUtk?=
 =?utf-8?B?RkIxL2ZpMFYyeXM0SU1QdXcrektQWGxEcEdENVRhSE5tY0IyRW11bmVYcWFt?=
 =?utf-8?B?RVNLOWxYRWd1dFY3WnE0MDd3bUtzTkdlQWcxbmFacmZKaEdoa1diU016RnpS?=
 =?utf-8?B?N0ZPaG5MZTZKOHJDVzV0N3dRbkttbExlRHdLa3JsTzIxQytSNzVicGVvSlQr?=
 =?utf-8?B?aFdFUktkclJ1aWVIQ3RuTkVWVUcraVVvTDlzbVFLdHJ2NDlmcnFDSGFXTlpj?=
 =?utf-8?B?dVlWc2JlNXMyOEwxWUZKcVFyTEFWejFtb2RrMmd5TU1NT0RZOTFIWUVIdDda?=
 =?utf-8?B?ZXB5WFVCTUJCVW5aWUhFMnFEelZBY3RyZGdYMWR2VWdIVTlpbUJ4eUwwd2Vt?=
 =?utf-8?B?aW1uQ0t4cWdEMyszajhncmNBdTN0T3UvQ2ZJOEFkaE1LblFLMmZnWjZvRnJm?=
 =?utf-8?B?NVZsaFNRRUowUFI4dm9kV1BrK3pPenFmMC9MTjFvRStsSmJoLzRwNFlCZ0VB?=
 =?utf-8?B?Wk80c2MrZmhEbmFjZFZVZmZtRGpyakJuK0diV1NoWHo1dUg4YldrN0E5SDNG?=
 =?utf-8?B?SUhtZ2gwRUM2UTZ5Wjd5TFozTkdLZUNtaDl1Zk9Namp5TkFCY2hKbmxqcmpC?=
 =?utf-8?B?NHpRSWpuKzMxa053MS9nRTJkdk4rR0NiK1RiMWs2T3BCN0xTbytxY09uaDNL?=
 =?utf-8?B?ckJteGJkaHhVblBibjNyRC9yMk5EcDlWd1pXSGZEbUgrYytVbzdwWG9FNzZr?=
 =?utf-8?B?ays5ZGNRSE9lcXdqN3dXR0lpbU1VN3hPbXNRY1N0MC9OaytqZzJaZ3VjcGNj?=
 =?utf-8?B?NkVwM0hjNEFTRzY1VjJmUjg0YlpUY3YxT0tIcjhLcU00SGF3YlRQbXFUckt0?=
 =?utf-8?B?TW4zakFYZks2T2k1NFpGQXhMUHN6d0ZzOUszQlpKZzcvOFhDNWZlbDFIRVFR?=
 =?utf-8?B?Q2xraW5hTGZVek4vK0FuWG1SbVhmZFYrVHVRN3oxRDlmWElscCtvVldxWDEr?=
 =?utf-8?B?Q3V5YTBHM1l4OGI3ZldYMkpyL0ZSU1Zpa0JwNHoyWjFpNi9KcWs0NzR3bUhO?=
 =?utf-8?B?SjZpdmVUcmlsOCs5eWx6ZnVUYUhVcllmTDZhUHphalJvZ2lBeEo5L3EvdWtj?=
 =?utf-8?B?Y2tudHRyUUFNVlhiTE9wVkFadUxWd2tKU20zRFoxN0hXbENXa2RtL3hNKzJN?=
 =?utf-8?B?SysxU2VVZjhHTXBoNmZWbFJ3dGxWNlBpaklNQU5LY2F2bUxINHpITGVhaktC?=
 =?utf-8?B?MkJDWnB2cHVsZGhZVDdqVnFtNVJ2NDZERmMweklhTDh5dHdQQVd1eW1OQjJY?=
 =?utf-8?Q?2nAyg7qmKVEJYjklE7cXmCo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EE031298EE1624C80D5DB7EECBEB40C@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AmSIHUaNdzJLEzDWpozoDd6JFyoXd8M+LGnDBrkY49Qhclk6X4VIOMavmJICMx4/fGoea5f907Z7UdbwkEJE8ngJQVv0CKGPFFSSJc1G3BLubR6GboGLj7gcVtrsFnPkPkInveWGzJ87lmCGOD8Hwo8gWW+T5ODxuYS32RyRDp/enefztpdL1xwxU/EMIdh7EYh3OyLgqBmwlYXNRIRe3T2doRUBFSDUYcQJghDUm+RxWXK/+kEJaNRkt2a4U+vfkxME3QpuizsqvSN0SFfsM9nQp3H95DEh2uAF7SMaebNI34JQOWRxTtEXFCYhSg6WkTenPey761rpVF5bHjnNwynCm3ZVcd5n/T/APahW2ZfLU8K3bLxc1vueCKpYkV5e2Yliun0XPN9XKXm34s30RDVismyMKhfzqofwSAqRRa+Ty0doZR9DVDoiH/qYANxPFvzETR4ZYkOaQcvGj1IyBcUd3WOApZMn1gyRIn8z/DbxH9j3KQyQLRYqf+cqd3TJuetGwr+qpBfK1y5BR8VS6DB75LaU0JafuhZ9Hi8/2abYhHkiWw3wQ0pjt4C2D3A9YvcQlmFmqQsjEkT5EdDSsLotWArlaq+5Ex/j6Z7zIJnKjTcmhE6Zomv5Mclz2Ht58pSs8dbwBwUwXwR+VYOjQg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de46fc42-970c-4a4c-e3b5-08de3838fac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 22:10:50.9236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OxuPxlShk+tAA+1OUcHZ4HkhOQ63KpHrWz5LaYGXYQcHdh/rHdjPhJ12Efm0wY+p08gVDJaKDqcyq/LdcCl0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6972
X-BESS-ID: 1765404653-105371-7674-14301-1
X-BESS-VER: 2019.1_20251209.1901
X-BESS-Apparent-Source-IP: 40.93.194.84
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGphZAVgZQ0NjAzDgtLdnQNN
 nYwtDYzMIiJS3J1MLQwDzR0DjJxNxAqTYWANa6lWFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.269571 [from 
 cloudscan13-190.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Received-SPF: pass client-ip=209.222.82.124; envelope-from=bschubert@ddn.com;
 helo=outbound-ip191b.ess.barracuda.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgQnJpYW4gZXQgYWwsDQoNCj4gK3N0YXRpYyB2b2lkIGZ1c2VfdXJpbmdfY3FlX2hhbmRsZXIo
Q3FlSGFuZGxlciAqY3FlX2hhbmRsZXIpDQo+ICt7DQo+ICsgICAgRnVzZVJpbmdFbnQgKmVudCA9
IGNvbnRhaW5lcl9vZihjcWVfaGFuZGxlciwgRnVzZVJpbmdFbnQsIGZ1c2VfY3FlX2hhbmRsZXIp
Ow0KPiArICAgIEZ1c2VRdWV1ZSAqcSA9IGVudC0+cTsNCj4gKyAgICBDb3JvdXRpbmUgKmNvOw0K
PiArICAgIEZ1c2VFeHBvcnQgKmV4cCA9IGVudC0+cS0+ZXhwOw0KPiArDQo+ICsgICAgaW50IGVy
ciA9IGNxZV9oYW5kbGVyLT5jcWUucmVzOw0KPiArICAgIGlmIChlcnIgIT0gMCkgew0KPiArICAg
ICAgICAvKiBUT0RPIGVuZF9jb25uIHN1cHBvcnQgKi8NCj4gKw0KPiArICAgICAgICAvKiAtRU5P
VENPTk4gaXMgb2sgb24gdW1vdW50ICAqLw0KPiArICAgICAgICBpZiAoZXJyICE9IC1FSU5UUiAm
JiBlcnIgIT0gLUVPUE5PVFNVUFAgJiYNCj4gKyAgICAgICAgICAgIGVyciAhPSAtRUFHQUlOICYm
IGVyciAhPSAtRU5PVENPTk4pIHsNCj4gKyAgICAgICAgICAgIGZ1c2VfZXhwb3J0X2hhbHQoZXhw
KTsNCg0KDQp3aGF0IGFjdHVhbGx5IGhhcHBlbmVkIHRvIHRoZXNlIHBhdGNoZXM/IEkgZG9uJ3Qg
c2VlIGl0IG1lcmdlZCBpbiB0aGUgDQpxZW11IHJlcG8/IFRoZXJlIGlzIGFuIGlzc3VlIGhlcmUu
IEkga25vdyB3ZSBoYWQgZGlzY3Vzc2VkIC1FQUdBSU4gYW5kIA0KLUVJTlRSLiBBY3R1YWxseSB0
aGlzIG5lZWRzIHRvIGJlIHNwZWNpYWxseSBoYW5kbGVkLCBhdCBsZWFzdA0KRlVTRV9JT19VUklO
R19DTURfUkVHSVNURVIsIGJlY2F1c2UgaXQgY2FuIGFycml2ZSBiZWZvcmUgRlVTRV9JTklUDQpp
cyBwcm9jZXNzZWQgYW5kIHRoZW4ga2VybmVsIHdpbGwgcmV0dXJuIC1FQUdBSU4uDQoNCmh0dHBz
Oi8vZ2l0aHViLmNvbS9saWJmdXNlL2xpYmZ1c2UvcHVsbC8xMzg3L2NvbW1pdHMvMzRmM2RlYzk3
Y2NlNTA4NjQyNjc5Y2IxYjg3NGU5OWVkMzZkODE1OA0KDQpJIG5lZWQgdG8gc3BsaXQgdGhpcyB1
cCBpdCBhbHNvIGluY2x1ZGVzIHNvbWUgb3RoZXIgcmVmYWN0b3JpbmcuDQoNCg0KVGhhbmtzLA0K
QmVybmQNCg==

