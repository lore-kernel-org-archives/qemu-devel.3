Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B376CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 01:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1wrg-0003LB-5r; Thu, 25 Sep 2025 21:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1wrc-0003Ko-Jj
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 21:03:08 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1wrV-0002kk-Ha
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 21:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1758848581; x=1790384581;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=j4aG70Xq1oWw2bUVIyI4r66EWdjrkjp9ifZiqSC+9Sg=;
 b=xR6sAiIRZCqmaWiK1PdtnCWAONa6jr6h2VTJ2UVgF3onee/L3z1ubRQ0
 2SSRc7m6nJrHVEDHUkre/4R6/yVWlVcWa0jdi4CWHFZZc9ulisdNllI/k
 w4KbjMbnSAi9jC+2b5loq3qdetmIiyNTvn24gIlDjo1qDZ4LRZqMuEHMh
 2llqXgm+8CUgAU51M088M2YcO4YNfnkHOCk+45wOUR4OVB16ZUvz1QQCq
 PQvi7yEl6NfO5gpnyoNBq23hbEbfkdS+gvEY3CFfuGd37MOilH8gOEyuq
 SFsHpqcvxUjBstvbUgGNvQY8omx0Cqbw7VlsGg5EWJ7TeiaJJ7k01u7wk w==;
X-CSE-ConnectionGUID: gFJ2RB9eSNS4NyrBvEBdQQ==
X-CSE-MsgGUID: P3efsYwLTQaEqSttAqDRDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="176668747"
X-IronPort-AV: E=Sophos;i="6.18,293,1751209200"; d="scan'208";a="176668747"
Received: from mail-japaneastazon11010002.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 10:02:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwRQ5pRDXjaNUMppaqcYUXflkue8i90fWtj/GZIZeV7enn2Or7818NL7T9qILUzeAQpvWe7zb4P0v+js6UGhipha2sYcAussXbMvTFtyrM7Xe5Nrt1jFhJ6tpgl9fQXoCALtiupDORYMtS33cVui3JJeiu27flNMmj5G0nPMK35Z/mtsMsxEvH24bPu5C713nObCiNLg+EI8UeEKxUc52sidfsZsP66ff85IHVJiI8s2aivnSZpm/Xyy3e+AqsSPimrUflCOoqCIYiKb07kgLcba3GwtOSe55o98j3r8v0diLpixXSUl3uoOvVJDP6kwIOdYaouIW3fzQ+yejpnnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4aG70Xq1oWw2bUVIyI4r66EWdjrkjp9ifZiqSC+9Sg=;
 b=CAoexGTwDrySxSiAbLjd3hOWt9fwIyq3/BVnAste16fyHkPD0mwOYvc9ZFB9HValtQ2Xe/jkBkts9d4oVp0nvL4Im54w0bLolEmBbaFVGQCc1vdeiOHIwWz/5WMBvk+KOohPb2y/g2YF9ncQ0jcnx5adpW0BzhgyiW0JTnLzGU9CjiGXapNq+PJC53DH3AnuEDZZie+oalkRYHSbnVxEqXarCM5X2FY9RRnyKo/fJBJG3jM2V32iYKlXdS59/AaKegBvu8/iOBvKwZSRG11wf4nQunuF2p/829HHE0XhOTn/m25//YktHJaf48yr68q/HCeR5XqphluegIBAfmd1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4aG70Xq1oWw2bUVIyI4r66EWdjrkjp9ifZiqSC+9Sg=;
 b=JM453XA7nEjF+msbY6GdCb/wFM/o/R+PLS9InhQyM7fw4LCDZgW0/yomHa+MKYwhy7BuSKmQ6cyXDm5WxAy8kkoZ7q22A0Pv5DfIeJPylAGS7O8zjvy6/MuKmEc2rE+R4GvHPw/X9Wqn3C3qe2ANEWUUgrrGr8TkIDYNZIUBcXqTgPzkkU1r4w6G7lWg55G8wXX78Xz/0Wb86B6dqjBzxGMeC+ChQC6WuZpwKnKdkYSe5FEwD5X2L8SUqNK1otgrIKZKLqN/c0/dS1KLEyEIWjCjN9fPTO2pXgKyWCAeDVvA1RZFiZb1N5cI17M9fHgQUR6hctQRF45gMEyVZqZLow==
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by TYCPR01MB6687.jpnprd01.prod.outlook.com (2603:1096:400:9c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 01:02:42 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 01:02:42 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>, Yury Kotov
 <yury-kotov@yandex-team.ru>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 3/9] migration/rdma: Allow qemu_rdma_wait_comp_channel
 work with thread
Thread-Topic: [PATCH RFC 3/9] migration/rdma: Allow
 qemu_rdma_wait_comp_channel work with thread
Thread-Index: AQHcF5WSLEx9rlAzvEasae+B3HmZfLSk01mA
Date: Fri, 26 Sep 2025 01:02:42 +0000
Message-ID: <dc7a95d9-31a2-48c9-bc5e-19820808f532@fujitsu.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-4-peterx@redhat.com>
In-Reply-To: <20250827205949.364606-4-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|TYCPR01MB6687:EE_
x-ms-office365-filtering-correlation-id: c81bf7dd-54c7-49cf-ab6c-08ddfc98656d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MmlvNWIvWVRjQ1NOblNtNlN1TnUweHRBNVNEM0ZJNk9tQXZ6c0U0T2RIci8x?=
 =?utf-8?B?RE1aM2w2TnViNzJWM3hkRC9ZUFRTbXV1SnEzbFkzeFlVbFVlZi9yR0ZtZUNJ?=
 =?utf-8?B?S2pEY3RiSEJPcVZZYTZIVUNvdEM3Um9UUSs1cEVuMEZLWjhYQ2QyTGJ0Z2l2?=
 =?utf-8?B?ellmdWhoZnNhT0UxMmdJTHcxNHpPUFVqV01hUjRxWTNseDdPNnlITHBDYmxm?=
 =?utf-8?B?L04zMXA5c1FOT1lWYStDOUsySG5xUnFLczZmTG9zL3hoLzZhV0ZlTlZ2Rnd0?=
 =?utf-8?B?QTg0bm1vL0IyV2VFUkdkR2M1OThTZTd5TldVdDFZNzJGNklDRitrNFp0MmZ6?=
 =?utf-8?B?TDNBS0lmajNIQkN3N1NGaElOakdTSmtZbU96WEsyanh0RTJEaXZjbHVXUTMx?=
 =?utf-8?B?UnRhRkpkSTJWR3B2SFJIK2JhSkdxYVIrdE5pcU02Q2wyQjdrelVVWmY0ZTVQ?=
 =?utf-8?B?NFB4UGp4T2tWTGVzZmtqRXRoZVB2NUt3OWl3U1kzRTV0VFFKYzRIb3BGcS9o?=
 =?utf-8?B?MFR1dnV4RlRqOGFjU1NTaWhvVExKTGJIS2MrQlJMVUV3cUJpWUxaTy85a0Nn?=
 =?utf-8?B?MDVzZlovNmYwQk5YaEFDS3VZT1Qra2NnWTB4Lzh2TFBxY3BIY3o0Rkh5UGR6?=
 =?utf-8?B?ZWRyb09tUkp1TmZCcjFwY3d1QlJXR2l4aXlPUjhOMFh1WjUrYWNZbzJXQndB?=
 =?utf-8?B?Z2NZTEp5dVo2TFJERGY5WmI1ODZpUWRaWjFFRDRsMVpWbTc4T2lMc2NheU15?=
 =?utf-8?B?WXFtR3I1cENjMVg0S0lzcDBvclpLV0pNamhpeTdoVU9lYmc4K1pkSTlwVzQ1?=
 =?utf-8?B?SDBPR2drTmM0cHlZYzdVdlRNM1dMSkFVTW9tL0xjVWFWclRKKzNpSDBxSzVq?=
 =?utf-8?B?R1FWRWRtN04wUTRGMENNVkxYMUI1ODhlamYza2hhRlcreUdDQVE2eXZ4ZzN5?=
 =?utf-8?B?OGlzQ3Z5bko1RFl3NW1WdXQ4cWpXbG51WUh1VVNTV0VKYnoycUNHM2ZpK0lM?=
 =?utf-8?B?ZExPazhVZkVFbTN5NFVDYXNrR3BkUlo3cFVpdm1QQndVQzEweEN6eWtLQ2VZ?=
 =?utf-8?B?RnFtQXpaWDJkaWxKamlpcXdrL2ZCbWJzclRJWTRuWGJRVEtzM01BdnM3QlQ1?=
 =?utf-8?B?UzZMV1VhcE0rQ2JHR2tvU3I5by9VdFAvNlJ4OVRpYkZtS1E1WDZ5eEdiMDNC?=
 =?utf-8?B?Mm8zVExmMWxxdGlWRmFSdFZ2QjdsbXlqaGdIUmJxWEZoTjRyWXAvZzFsNW5H?=
 =?utf-8?B?ZmxuMkRPdk9wUjhSaUE5NXNGcjN4d25vRjlEQXptWXlZQnVwSXlSNWxxSFFz?=
 =?utf-8?B?TE9ycEhEOXF5RlZ1S1l0S0FydFFDVU5JRHN0TXZnUVdrdkNwbjVrejRoNUtP?=
 =?utf-8?B?LzJIb3YxVzFnSEdvZXVUQlJGa1kxN3N5RzNZZERzbDcyalhrTGF3VEUrU3Zq?=
 =?utf-8?B?Q05MTmN2TElnaEpNc0JwK3d0bVpsaTljU3pzbzhVS0lQNmxpZkswM29WY05Q?=
 =?utf-8?B?ZTVQTjBiQ1VFV3o1RmpVTTExMjFPQnRYaDFiK3lDUVpveTFCcHNldlAyQlZ3?=
 =?utf-8?B?VEVzV0NVWE81dU9SakJMMHphbDZaaTgvRlN5RHc5REdiRkJNOTNtZ1VUa3J0?=
 =?utf-8?B?S0FXS3NMTng2YWJ3Mkp0VlZpS1JsZElWalYxN0dDZWJ3U1FDVkk3UHA0eitJ?=
 =?utf-8?B?czBjTVFIVndqYkFFTmxKL3B0QWpORy9zb29VbWMrWmtnK1dEQjVLTzJ2Mzky?=
 =?utf-8?B?bEF1Tm1QNVlnUUxVOEpPWEU2Wm5SRlk1WlVYYWJ1RVZyWmV0QktJd1FPYUhT?=
 =?utf-8?B?WlRzc2RPalZQcVRQV3VKRUtKMTBhNTM4YTBMQTFkOGp6WUpyOUYwMDlHTlgy?=
 =?utf-8?B?ZEt6Q29KUHQwRFdPam9CMUJ4Z09VRmkyMldKMVhYS0Q2TklkdVprZTYrUjhk?=
 =?utf-8?B?ZEZPbmtsMGZ1SjIxQ0w5TTNNOG5nU2FLVGlIN2FsYWpGMnRkV01PakdvQXpp?=
 =?utf-8?B?UFBkcVJ3bHh1dHQ4bEJ3T09Mejdta0d5djRNQVVUQWIrUFB6a1NVaDgxaU9Y?=
 =?utf-8?Q?nzaVWT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSCPR01MB13050.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUlkOEkzM2hGY0RncWw1c2xpYXJUdmZnTDFJdUhoSE5CS29pTGxJVHpuckFT?=
 =?utf-8?B?ZlhRL05vOEt4RHY5UkV0NlJ3MXZLem1xSlkzMm04R2JtTUc5U3VwakNUK3pX?=
 =?utf-8?B?ZmdjUHJuL09YZmp5Y2xKMnJaL0k3QU5HZUs2V0QzUXYzVXV0VkdjTkxScjIx?=
 =?utf-8?B?bmpJWkJ1K0plM2orRy8xMVBwYXBnOS8zMmRtejFqRys1Nk9Ib0ZaalpnVjc2?=
 =?utf-8?B?anFHTjlPWFlQSGdycndCTW52NXh3Y1ljU0ZqbzBqa0ZuTXMzeHVoa2RSMDhI?=
 =?utf-8?B?Z3pKOTAraEQ3RWRXNkdJQjU4ekdxTVA3NmMzd0dnKzhDL21ZdlhPZzVjWEV1?=
 =?utf-8?B?QjVyT3E0TmNQNkRZNlFPYW5PNFNTcGQ5c1VadFFvWVk1WllqcWVCNEdEQ0t1?=
 =?utf-8?B?RU8xZzNjMzBFaGV6S2VGRnJkdVgyMkx5TjUxU29rQUgwZUZzdW1hc0lZUWRt?=
 =?utf-8?B?YzMrSS91SWZOdjFyelVjZ1cyQUhNaDZtNnFPUWcreFVGU0NwdFNjNHN4VVJZ?=
 =?utf-8?B?TzF5RSs2WUFmOHRVYStwcVkxcHhaV2pVdVZGWVpib1ZmWnMwY3hONFRBWXZX?=
 =?utf-8?B?cld5YUE1YTFlQXhYcE5MeXFTR0c0dXRRbCtTVXhWUStwK21GL0kxSHA4SDc3?=
 =?utf-8?B?WVlOZVBPMUFwVzQ5ZFNob2R3d3lRZ0dsMEVBWUZubllwUWZDOUxab3VCNnRn?=
 =?utf-8?B?R2E5SHZNMW9kNTliTFB3ZkYrbVk5Y1lScm1HOWgycGVBQ2draG1WdU96SHl0?=
 =?utf-8?B?S0wvKzBYVDdack5nS3lCRUU2ZFRTYkxTM0plU3IwQjRkdkRoQ0JuZHVSY3pF?=
 =?utf-8?B?ejNQdldtak9BNklwT2F0bUZhQXNvaUZvY2hKbTFMMXhCcXp0ZXZHZFlQTi9T?=
 =?utf-8?B?NGZ5NGxqbC9ONnpoU1BnL21uL1lBM29IWmZFM280VWtUNUtUWjBuY3lQSWtP?=
 =?utf-8?B?dCtIWEJqUTlYMm5KQnZwcTI3RFNuWGQza21OZmRZM1hKeXF1Q3NhTWQ5RTZ4?=
 =?utf-8?B?bHl2QUZrWGRzamNrT3dWNWwrRE8vSlNpUXdZeDhlbWwwQ0FLcnFIeFpoWThi?=
 =?utf-8?B?S01OVjF2ZitILzF5c3o2ZmlwNXNFMUUzdktYbVZMQ2l0U2s4TG9zYzErSDIw?=
 =?utf-8?B?enIxQnhJcTZDMXlaVzZoYjRLYS9xSVF2MmJrbndmaXNidDRhUlJMN1QxUVdW?=
 =?utf-8?B?a0dUekZKcGlKaG5KWm95VlZVM1N4emNlQ3NpNGFPNWVBQXB1bTI5dHc1NjFa?=
 =?utf-8?B?eUtzOWFvZFBLZXJLMDFCTXdIS2FOc0ZYVU5nR3RyUngyZUVXeVJRSFBJak5L?=
 =?utf-8?B?ZFZFZVdoZFg3RHJGVjFxVWRERjhDajYxNmROc3UxSzhMTXpCTkJZQ2htdHVG?=
 =?utf-8?B?VE4zTm5pZnZnVTkvbk9XTWs0bERFb2lQcEdpKytQK1M2UkhtVE5NKy9IS3Nn?=
 =?utf-8?B?VTJKZmgvZE1yVGZzZlJwZ2Z2QlhWaFhLVlFVbXVyVlU4L29GUUplSUl3Mmho?=
 =?utf-8?B?bTQxK3JtaGhXSE9ucG5ycUNjdktrM0lLNDRaOTZWbHZ4b3hTdXZPeW1oSEE3?=
 =?utf-8?B?NjhNS2EzYk5uVXNzeGpibXVGVk82QlFiaXVUMlMvMGh6SmxiTU1XSkozNEdT?=
 =?utf-8?B?amJQUHpTWklmNjAzTVlnakM1SVozZUI3cHFFN25VL1JlOXJVZEU0YmVrL0dH?=
 =?utf-8?B?U201anNhVUN4YitIM3JQMkJGcXd6UWpudkl5MXJURmdWTktudEF3Y2hoT0JN?=
 =?utf-8?B?U3dsZXZydEtWdWw1Yy9BRHdyUUloLzBqcDNReEI0UTZZWWpSS2FJUkZPei8x?=
 =?utf-8?B?UVo1TnFPVGNGajhGRHU5cXYwVFFUeVMxaTJjL05DRC9yaFJ2TjJqWHMrbnJD?=
 =?utf-8?B?U2xCTUtvWURrbHVYN01pWExQaENkVGJrdHpKRkQzS3UyVjhzeHVkdWN2OTlW?=
 =?utf-8?B?anN5aXBJb0dJblBkNWZOeWU4UmJ6S1hKaHlHeTJtMXpmWTFSYklHTGd1NUQv?=
 =?utf-8?B?UUxRTC9ETEIxdGdyNUZOSzJsSHd4V1NoODViK3VJSW9ERHp1Y0FoSGMrZWhl?=
 =?utf-8?B?cUdYSmtaQSsvVzNhS1RjMUVRRDRNaXExSm9EVkIxWkNXZ291b0t1Nmp0VEJx?=
 =?utf-8?B?czJIbTczS2J4V0NVVFl5WGVBT00yQmZmTlFEdWQyNmdnYmhRVlh1Vm02WCtJ?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C37236EB029E94EBCA15D496777DA02@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z3lmmxtdyuG9fbf5h15wPPQsEY4SWi8VkihAzuid/+im3Z8ps7IruHEmqyC0TFRAI4rDi0W3TN8uunhbrkzcc0DKBBIsShuiAo91YG9jbXLJBOk2NS3erIE3w5YaQBU4SWskKAr/+UZAUq6WV1TGOi/DmHWB3WRiytjiNJMuE5eyNx9gqKn9lW6qxisebAvnJqprVD6AftyspkDM9O1+e4/Btygjd/K27F8geOyLZ4u8aVG4+sdj6L4z4xLSIDEPhykqoph5NI1Xd1ZztNJ4IEIEkRhZ9cjnfCpDBVNuEajPStRLDCTfWTrGO3Xyc4Aqew3T4PPz4QDbXkIX51FxIhi8iLP5hl7AZjyeN0uyeVCM9ZEyIedStzdi7Y7n89TZGkqYUlfcwGB9Hru7EHEt8y4zHadOhVLlgxAaDZL9+l1PlbKdIRbq4z50v9/qNJLuyTw0bRG8QG16Vt3o/EOyTikH1ItQQZAh0RtJDoKGcEEileQ2o3X95tIIegkEkkfGODRlglHZBzshvM5f52I9qIwJeEO3NkCGHtdgahev+LTjUK4wSUdbdmGZw9c7lJIMZBxRK1In/g9M+XYqCajLcbGC2qjMadsEweyIufa1ivbdNKJVet1pj7cZt8abJ2hj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81bf7dd-54c7-49cf-ab6c-08ddfc98656d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 01:02:42.2903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hDhVzPkESCxg9jDtiTEy15etYC1gdOf7XBP+XOOYN0pD/ZVNNqjEDPfDpHufwFN47FUmgwijwv2vSJblA78PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6687
Received-SPF: pass client-ip=216.71.158.38; envelope-from=lizhijian@fujitsu.com;
 helo=esa18.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDI4LzA4LzIwMjUgMDQ6NTksIFBldGVyIFh1IHdyb3RlOg0KPiBJdCdzIGFsbW9zdCB0
aGVyZSwgZXhjZXB0IHRoYXQgY3VycmVudGx5IGl0IHJlbGllcyBvbiBhIGdsb2JhbCBmbGFnIHNo
b3dpbmcNCj4gdGhhdCBpdCdzIGluIGluY29taW5nIG1pZ3JhdGlvbi4NCj4gDQo+IENoYW5nZSBp
dCB0byBkZXRlY3QgY29yb3V0aW5lIGluc3RlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRl
ciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCAz
ICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0K
PiBpbmRleCBlNjgzNzE4NGM4Li5lZDRlMjBiOTg4IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24v
cmRtYS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gQEAgLTEzNTcsNyArMTM1Nyw4IEBA
IHN0YXRpYyBpbnQgcWVtdV9yZG1hX3dhaXRfY29tcF9jaGFubmVsKFJETUFDb250ZXh0ICpyZG1h
LA0KPiAgICAgICAgKiBzbyBkb24ndCB5aWVsZCB1bmxlc3Mgd2Uga25vdyB3ZSdyZSBydW5uaW5n
IGluc2lkZSBvZiBhIGNvcm91dGluZS4NCj4gICAgICAgICovDQo+ICAgICAgIGlmIChyZG1hLT5t
aWdyYXRpb25fc3RhcnRlZF9vbl9kZXN0aW5hdGlvbiAmJg0KPiAtICAgICAgICBtaWdyYXRpb25f
aW5jb21pbmdfZ2V0X2N1cnJlbnQoKS0+c3RhdGUgPT0gTUlHUkFUSU9OX1NUQVRVU19BQ1RJVkUp
IHsNCj4gKyAgICAgICAgbWlncmF0aW9uX2luY29taW5nX2dldF9jdXJyZW50KCktPnN0YXRlID09
IE1JR1JBVElPTl9TVEFUVVNfQUNUSVZFICYmDQo+ICsgICAgICAgIHFlbXVfaW5fY29yb3V0aW5l
KCkpIHsNCj4gICAgICAgICAgIHlpZWxkX3VudGlsX2ZkX3JlYWRhYmxlKGNvbXBfY2hhbm5lbC0+
ZmQpOw0KPiAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgLyogVGhpcyBpcyB0aGUgc291cmNl
IHNpZGUsIHdlJ3JlIGluIGEgc2VwYXJhdGUgdGhyZWFkDQo=

