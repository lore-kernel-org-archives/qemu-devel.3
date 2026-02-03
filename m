Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D077E7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 19:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnMDO-0007jc-Hi; Tue, 03 Feb 2026 14:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnMDM-0007hn-DD
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:37:32 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnMDJ-00071b-TW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:37:32 -0500
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
 by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 6135jP2S1204919; Tue, 3 Feb 2026 19:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=hy+x6XRZG5eIDw9lM30lTNTYYgQEy8QLwLv7sIGdssI=; b=
 cpOwGScIgDYN55MfCJvW8me2CzQKR3oC3SM/aSSLYByGE0p9k/2OjxqQCFwmZeZT
 Lbo0q/ACHjEJ3+XbSz2WJVQLyAgLtsH93qUkF5PF4PbyE/wmaS8AXk8WfD065AUO
 7MeisRIYEpwiBIANi6NnCw+yjh6c7f91nZkfH9RKQOLNzzEolABWsxPKStwP8zxb
 TrBQiZvbzt2LmdBILbN5jL1ZjWzt8fntlPRWWEc2odKnM7oVtyZ+2JhSt414b2uV
 wiABihdivynJ1Zkjq27PgJHkapfrVUv9dIhx1Mr/OC6+6G1kmCiIxdPh1Eu8BkdC
 fu76mv0BF1SlkHvOZxoRfA==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4c1avnuua5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 19:37:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 613J6JxP001052; Tue, 3 Feb 2026 14:37:26 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4c1dy37jm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 14:37:26 -0500
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 11:37:26 -0800
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 3 Feb 2026 13:37:25 -0600
Received: from CY3PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 3 Feb 2026 11:37:25 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by MW4PR17MB4340.namprd17.prod.outlook.com (2603:10b6:303:7a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 19:37:23 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 19:37:23 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v2 09/12] net/tap: move fds parameters handling to
 separate functions
Thread-Topic: [PATCH v2 09/12] net/tap: move fds parameters handling to
 separate functions
Thread-Index: AQHckWbHA3/3/G8pVEqYBhQljcERE7VxEmeA
Date: Tue, 3 Feb 2026 19:37:23 +0000
Message-ID: <65193BB6-0256-4E53-8923-8247FFBE93CB@akamai.com>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-10-vsementsov@yandex-team.ru>
In-Reply-To: <20260129213215.1405459-10-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|MW4PR17MB4340:EE_
x-ms-office365-filtering-correlation-id: 2d33556c-0122-4188-8be1-08de635ba7a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cERWNVQxN2lMbzI0cGVVOFBhWlpkaDdZcUlkNmp3QSs5djBEbWJ2RnlibU9j?=
 =?utf-8?B?WW10WUNGZCthQk9WTzlndWwvaU5zUTRQdHU1YlMrMEJhUWlMaTlTRDgwVEFV?=
 =?utf-8?B?UnpYa3ltcjJ2cnRSSDlnNm55T1B4WjFsUVlKMlBaOXdBUThEWS9YV1ZUcEYw?=
 =?utf-8?B?aWE1cnJONDBFSXhveHVGd3VWeVY5U1Z2VzVuVVV2U3hYRVFQTXUvZHlFQXBw?=
 =?utf-8?B?UTFaYzBxd0xBQTJXVlBIRVlNOXYyQ1JJRFZSaDl4aUNWQTFEZHVyVHNYWFgx?=
 =?utf-8?B?L1JINDlJZVdvL3REMmtvQTd1VCtNTlZxNUVWSkpGUmxLYm56SFZJbTAwUnVk?=
 =?utf-8?B?d0J6OFBlV29Hc1VSYWUwUXEzQk0zcHZzVGxCQkdTVmhVR1N0RmpndzdFK3lK?=
 =?utf-8?B?TmtlR05KWGFlbENoQW54dmY1SkVhN3dtNTJsTmFldFVYUUdkL3l6MDdyU2dG?=
 =?utf-8?B?a1FLeUZzSUtHZ3Yxb0FleEpzckkzbi9KY3BWM0FyRTUwbzhqdTlCVDFhV1I5?=
 =?utf-8?B?UDQ5eUpST2pLM2FTbWk2THB2dDNGcUFWdzhmNUEvRzduZWxUS0FaK2Q3amV3?=
 =?utf-8?B?Y1BHWktRUmd2ZjlSSE9TWTE4dUV0M1lDTmlGVENPVVBDSUlXVkZiR1NSNDNt?=
 =?utf-8?B?dGt0VHpVZEFKcDRnaWlFNjlOK283b28vR2xqRnp4L3UvK3BNbkFBeWp2ZXR6?=
 =?utf-8?B?VzdROEk1TWovSXF2K2xHUEgwU0hTY1RrN0xDdTdVN3d1eGZ0TnBaVGlQSWVJ?=
 =?utf-8?B?enJZMUNUZzlOeVhZdnEvK1l6MStEdDE3MXhOQmsrSjZOWFZDOGZMZzVUbUti?=
 =?utf-8?B?Y1hzc2c5ZzR3WVYrc3N4TVJNYU9lZTViQjAxMTdHcjZwV3ZBZ21FbWJlNmVS?=
 =?utf-8?B?bndXb0EzWmx0cDJ0bWJsd2daQjN2WjMvblE4NnIyK05kVG9jYTdUMjdWazZK?=
 =?utf-8?B?YU9OU25CYWc4dDNZZFNoUjh0Y2R3bXM2aDMwODVwNEZVeEdoSVJYTXd3a2hR?=
 =?utf-8?B?WXR5M1IrMnZielIyQ3prVGEwQ1RFbVorTGhqZlpyTlRJbU1OeURCOVVxcjl3?=
 =?utf-8?B?bFhKeldzbGJXZyt5eSt2bXNXUUJqK1U4VnMvcnJJbjJKVWNxakZDcU9xbEFB?=
 =?utf-8?B?QmVWRStmTSttK1phUlUxL3V4ckxFMVI5Y0llOHdEb3Q0TkI5RXJ4Nnc4ODhy?=
 =?utf-8?B?d2txcTl5eXdvdTdyMHh4dFF1YUhxMkFCcm9zekYyZnBRT2tyZExUQ1lzZUhY?=
 =?utf-8?B?TThKbmpPYVpwdHNxMEJxcGlJTlZYOGFPODN2RzhjYVR2Y2FSWEMzb3YyWjVP?=
 =?utf-8?B?YWM0VnVoZnhvOU9pTFNQdXNjclpaTEI3TnJMNDkvU1U2ZWFJbFFQeVA1S0xY?=
 =?utf-8?B?YThpTUIrNm9CbVhqK3EwTk5keXNkSk1vdVpoMk9oLzBWdkRiZDB0TXp2SDV2?=
 =?utf-8?B?RWlqeFBjbktMWVNwZFMvZGRKQlhaRE5RaGtUb1NWcFF3aThaWnNNTUZ1T2dL?=
 =?utf-8?B?NHhtdFBNUk94THVsdFZrTmlubGxWOXN4T0FsQ3pBeWdZMDMvNy94a3gvMFR4?=
 =?utf-8?B?a3MxdithYTF6bSt1WkNRYnRoYUpsK3BOQmVLVGZoYU9XMit0bzdvM2Fqd0ZK?=
 =?utf-8?B?QS9qVW9RSHRaV0RySnFRb21JVnZ1NUVmUDdpSFdrT2tYNmVZakh3Qll3bnhT?=
 =?utf-8?B?Z1c4VjFwQ0pPMGxSaVcveWRLL0oyQ3J3TWdqYmtJb1FCc1RwMnJIZGVwd1BC?=
 =?utf-8?B?bTFYaTVla3lzd2lidDdvZHpRVWRoMWtoUDJzU2pHYkNINEtPbm1xaDRyRVBt?=
 =?utf-8?B?VWxXV0lEbG5aa2FVNWtqMkl3QythRlZkWWF4VHBMRnlFTTV4eGZ4R0tSYzBL?=
 =?utf-8?B?UVFlVy94bFozZGlRZWp3WkJWNFBFRVRYMzhIRXQzN3Z1OUcyOU83VG5Wc0tN?=
 =?utf-8?B?dDl1VmJtNW1KNEtyK0xKRzdYMDN2R2hvSFh1R3BXd3pXMjZJbksxM1FGUUp1?=
 =?utf-8?B?aW1Rc1NNbmZ5ZEdkczVWVXZjRUJJNnJRV1BnMzRrbXI2a0N0TUI3eXdUSlB0?=
 =?utf-8?B?S2xTWUJJL2RRMHRjYWJMeElvWituZkVRUmk1QlMzL1cxaFF5d1l1WS9FV21D?=
 =?utf-8?B?UWdnalFCQjJvdHYzcHNQbmI1UVRZb1hFR1c4NlZZNFEyYTFjVHFHcVV4L2xB?=
 =?utf-8?Q?bVKpBsB9iDOQspU5tC47NpY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0FHZFA1SEdwOWp2ZjlYOEZSSGptNFlENWZIc1ZEYm5lQUV3VmtRK3poT2FU?=
 =?utf-8?B?dkJCU0dkdzczZWFkMFYyNEhEUkgwYlhsMzZVNmJlNUVWVGcyTTJvRFpnNzNU?=
 =?utf-8?B?b0hQQWgrWXU3ZjQ5a01JZkUzbWNCT1h5NUhBd0IrN1Y1eTN0QXhWTjRLZVhF?=
 =?utf-8?B?UzZ6aCs3TjhyaWx4WWx3OWk3Y0k3QXh3WDJHdUZnWWM2MDVoVFVhOGlhejk4?=
 =?utf-8?B?SWJqWkZ1bm5RUUxzR3gxdG1BdUVpNUw1bU81bW93MndHMkpOMHlUelZkS1N6?=
 =?utf-8?B?NXM5eW5HUWtCQVc0OG1UM3BKRDB3U3pLdkt1YUsxVElZc29yQ3FhWWx2Tmpx?=
 =?utf-8?B?QW1WMHpRNjVoWHpiTTJiWDNpZEE4SUJwNGpLWndxamV2OEM3QURTUlJobENo?=
 =?utf-8?B?dGZ1U2NCNnExWHFkSjF4dVJudGVUcXN0dFBTakY3eENEYVFRams5bHJaMFYy?=
 =?utf-8?B?c1U1MFdGMUhZYzcydnkzVWlxcnI1ck8zK1AvNmQ4UTNGR2FGanByLzNUT1l6?=
 =?utf-8?B?WVdFSFpvNlVjcCtiTzU4NVNLRFBsLzBuTm9iR2pobHhnRFdJeU1SQVNSbXNk?=
 =?utf-8?B?b1V6ZHZwejliOFAyODU2UkJPYjlEb3VGYjU0NG5nOVRsUHZySnRrdkZQam1q?=
 =?utf-8?B?UTdscVBOa0FyeFZ3QjZXNFd3V0lXTWdFL0xQQnVSNUVnWUtTbE8yOUY2R04r?=
 =?utf-8?B?SUc2aFFiWGh0ZW0zSjRpVTdrSThlRjV4bzJuWFhuYVZVUG9yV2VxT0o5SnRT?=
 =?utf-8?B?UlZaREVjbGxDR0JYZEFpejlrUU43Z0NsZ2dKM1FvSGJwczNFaUpRSHVEUVBw?=
 =?utf-8?B?OStCMU5xWmdWbHQ1QmdGbTRBbWdTSFF1cllpU3gzQjEvdFNBNmhIMFRJVThI?=
 =?utf-8?B?azVBTFg3em5IdFNKeDhkN0pxUldaZUlrUkI2aDV6R2swNWtVeEw2SldITk52?=
 =?utf-8?B?bldwcFJoS1M2M2tPTGNJTHNlTVNkZG9lMUdZL2NrblZqTi95S1FqZTBjcHgv?=
 =?utf-8?B?aFhwcjVWQXVQb1REa0I3TFpBS2orOW5GN0tTVUdZRUJxVUMyMmxFaU45dGNK?=
 =?utf-8?B?MVVodDE4dmdBK3kzZ1FpMDdPZEorT3RVdlR6Y1M3ZkhZZ0hYSDYzZHA3TWZt?=
 =?utf-8?B?eU5DeDRDSjgwbklZYlFzY1pJSXc0akl5REp4TEUxcWxGYXJldWY3Nis5Tnpq?=
 =?utf-8?B?emRSUEJBOGNOenc2c0NpNHNKSTYzeVhVTzhKRStKU1FHTmJnZlZwVVBFMVN4?=
 =?utf-8?B?dUV3VmhtbVA2NVI0VEQ4U1V4T1ZzWTRGN05IUVZpV0NoNkRRQ245Vnh1Mjc2?=
 =?utf-8?B?Wmhma3NaV0s4Qi8wZUFtMGJMZHkrZm5HeTFBVEplM1hScnVxWFU1eU9JaHlK?=
 =?utf-8?B?US8xTy9ha0k3bzNQeklhNDlQOUdqM2taZHhoNVI2RWlDQWlhelpoU3VQMUFv?=
 =?utf-8?B?b1J4M3RPekIvaGJUcHFUdS91Wm1VR0JsUEdGV1lrS0F4VmFzREg0Mm12Y2JM?=
 =?utf-8?B?elhLbGJVU2VQazBWSVFYMzloM2VQWHViVjk3S1RTVVFrdFZOZlpwQWVxWkhH?=
 =?utf-8?B?U2piUFgyYmZKTkRwQ09SbjgyZ3I4WTRCRkR5eWlVMm5KOENhaVFGVGlZcGxS?=
 =?utf-8?B?MFRrd2lvanhxMS9vSi9YTWlVeFF6VHFGWFRxa1pDbmJjN0xRRi9qNGMwR0lz?=
 =?utf-8?B?Uk01VXdQUm1KOWtaKzdpQ0JqM0FlTmNUT0Y1TUpVOUtZQXZBN05mTWZRR0RB?=
 =?utf-8?B?VUltV1NBWG05dGhxOFYxbk9LNTNzaHRnY2ZDUTJ0WEo3Ymhwa1RaaUsvSWhG?=
 =?utf-8?B?ZUpPNDBUUnJLUUVTMWp0Q0tGVGJISm9wUnVLSzlOenRUQi8wcHJTVVhvMFZJ?=
 =?utf-8?B?N1pRWmxFOGhzV3RNOFp5Z3JWSTh3RnZhU1dKT0FXZFhSL0dsT1ByZEtlYllo?=
 =?utf-8?B?K3ozdkNuVmpvNnJOZ3hWUUdud0dpSjJIMGlTYy9GSlc2RU9KdHRLaTBqWHRr?=
 =?utf-8?B?MFZSb2hEUnZBMmc5RWQ0c2x2L0lYeE5uSnFTRENIMEpqeUxQbzc4c1A0M2pa?=
 =?utf-8?B?MVpCek5mU0NkM1crMksxdU03NlRMSzEzNTI5RlNqUGF0ZWhZZGRKZWRlQ0x2?=
 =?utf-8?B?Rm1ydk8xVEFUcDl4bUxnVC9iUks5UmRNTmprUlFWcDJ2VHZNUnMyUGJjUDhB?=
 =?utf-8?B?V1V1UEE0ZHdmdjZORFYrMnpzeWVqYmhnNjl4cEF5SVNHQXNobWVWYkJxZ1RY?=
 =?utf-8?B?TTFIR3EyQ1hTUE9FYmNlNmFtS25YQjcyZUxreUNXa0tqWkIrekhpOWFRcUV2?=
 =?utf-8?B?c2NlRXZuSWN6Tm1HUjhhUmxXSzVOSTQ4ekJKZ2krcXJkbWNsYWViaXZFL0pV?=
 =?utf-8?Q?qXC/MxTZGJYr9fu/03wCk85yhC9AOUoAPEmp6ZotZtBNZ?=
x-ms-exchange-antispam-messagedata-1: 1faFZkCW2phNbg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9+8eOX9ueOVlwpWgIukcQTKk1iUrD0cZDKJzk8H79UyvucGGTLka5DzD7uxUDgEfvb/a39wPPVYIxrf9IKEqJOw6e8m15svdrYpVJHb86QYvkQ6PKR8178yxNxaOd8iJtHVT0k+G4vIix9ubs6t1jPm7bv1FkvdXudXu7X6bdqteI8d30+iyw4gxGgOFo1FXIOlxe86UZwkfR+nvw6wyLF2+CPvomo2neuPrU2ethVSCuEEA1LECJs68Zy2rfBKPMXLSK1ZM5T/+8l4ZSQ3NxgLhmd7gYiGbSfe1Sb3V4Gie1IVIjeInfb7uaxSRzYQdrXcadukB1C2OaeMPxCVEg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrKNHIyubw772F/cmHapTdwTBle4jSRKexpGJqpNBPs=;
 b=SGVdaJ0v6qIYAb3Zl0xBA6tvEUk90LdiLeU7iJor/FUlG6wIIgL0sCfmJB2jP0Qr5U2AjE+AsmVk+4zxWM6a+csHUoS2I9de9k8CpZd2g0laUruJo8TKx8rY1JSoClGo0ezfaXtVdU0ia2GRnhb31aq1vopark3Ju1x/X2v3sWxGNOA/2hVz95phtHkpbitl/p0pMyLXg4kJsYUxuT5Jp+ciUg/eTqe0GRgkpQ0GeLu7snISxDwuR1vZQjMV3jK3F7kl9SsLl4yjFp4mes35ffzR1y1RsKUXCo4XgGWsHGy5n5wm1AYX0SkgBH4+UTuPOZ5bLlMteXxQqGjeeorjOg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrKNHIyubw772F/cmHapTdwTBle4jSRKexpGJqpNBPs=;
 b=C6Qtv3iyGEV9bxPNlRNnU5PpSVYB4JrFm4xD/nPNp1uNtCJ0wRGey11tcnP15btcOV9nr7lzNrkSFr1ch0IYyFCRSYwTlMobenKhmIt1M5qEtfiICLaSL0FQwti+YP/61OoY2wT7mFOTcFM7p3QwNBH9QKoOydXUz0dZbN9H1bQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 2d33556c-0122-4188-8be1-08de635ba7a6
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2026 19:37:23.7853 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: QdntDLY7U2KuduRWPAH2SP5bkE8OtZPuDdWNzOUTFt/dA9MDWw1ayNSa8GTQzCY2hwBtyXc0gL4NwSh+Q20lIg==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR17MB4340
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7550A511A4AD544834E5EB70D5C00A5@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030155
X-Authority-Analysis: v=2.4 cv=Z+Hh3XRA c=1 sm=1 tr=0 ts=69824e77 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Dvqn7Cf1sefC9qGK0zQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9yBj2cp_XSSRnZ-mV_Zk8ne-nMujBOhj
X-Proofpoint-ORIG-GUID: 9yBj2cp_XSSRnZ-mV_Zk8ne-nMujBOhj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE1NiBTYWx0ZWRfX9hkqlZnzf8Ug
 j0Blm+naKem0a7P/GlyDStNVTNzR+tWBdwxivJtrTiPbrYGw2gonoNs+wcx3MqYsSiLPNOnRtjX
 ACNP9BWEd8y7TmrHeiBulZg7og49ZHJ2IZRjxN0xE97n2UqDvf4lQGC5PC56WUXDclxE+k7Qq4w
 KtEhmU7tIZ75GRcHa2McoBYWZNKAz67VqdKXjWXhjMEyvSIeYSTaUfoWS5stmABct66Q8jwfCFg
 KVB7UgIr/or4u574cs9GlypVmFFD8KGDFVyUH52AKzaw4QAxzSNfskm2jZWjNJmIR8iGG1uYojP
 Pl0FYTMNHxYTjQ+mKYltQDl5NnP52ti9CZBtMD3q7U+LN0w7UPIUvMF3rNwwBK3oG8CoQHhGe6h
 oSQCc1G9gapeD8gtUqsj7HNMOi4VbKPHeRMhNrGr66svz9De1Zr9lWQEbw+ULPwJMySmuMBEmEG
 tsN6X8gXZN9gA2G/WIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030156
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PiArc3RhdGljIGludCB0YXBfcGFyc2VfZmRzX2FuZF9xdWV1ZXMoY29uc3QgTmV0ZGV2VGFwT3B0
aW9ucyAqdGFwLCBpbnQgKipmZHMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApDQo+ICt7DQo+ICsgICAgdW5zaWduZWQgcXVldWVzOw0KPiArDQo+
ICsgICAgaWYgKHRhcC0+aGFzX3F1ZXVlcyArICEhdGFwLT5oZWxwZXIgKyAhIXRhcC0+ZmRzICsg
ISF0YXAtPmZkID4gMSkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJxdWV1ZXM9LCBo
ZWxwZXI9LCBmZHM9IGFuZCBmZD0gYXJlIG11dHVhbCBleGNsdXNpdmUiKTsNCj4gKyAgICAgICAg
cmV0dXJuIC0xOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGlmICh0YXAtPmhhc19xdWV1ZXMpIHsN
Cj4gKyAgICAgICAgaWYgKHRhcC0+cXVldWVzID4gSU5UX01BWCkgew0KPiArICAgICAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAicXVldWVzIGV4Y2VlZHMgbWF4aW11bSAlZCIsIElOVF9NQVgpOw0K
PiArICAgICAgICAgICAgcmV0dXJuIC0xOw0KPiArICAgICAgICB9DQo+ICsgICAgICAgIHF1ZXVl
cyA9IHRhcC0+cXVldWVzOw0KPiArICAgICAgICAqZmRzID0gTlVMTDsNCj4gKyAgICB9IGVsc2Ug
aWYgKHRhcC0+ZmQgfHwgdGFwLT5mZHMpIHsNCj4gKyAgICAgICAgcXVldWVzID0gbmV0X3BhcnNl
X2Zkcyh0YXAtPmZkID86IHRhcC0+ZmRzLCBmZHMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdGFwLT5mZCA/IDEgOiAwLCBlcnJwKTsNCj4gKyAgICAgICAgaWYgKCEqZmRzKSB7
DQo+ICsgICAgICAgICAgICByZXR1cm4gLTE7DQo+ICsgICAgICAgIH0NCj4gKyAgICB9IGVsc2Ug
aWYgKHRhcC0+aGVscGVyKSB7DQo+ICsgICAgICAgIGludCBmZCA9IG5ldF9icmlkZ2VfcnVuX2hl
bHBlcih0YXAtPmhlbHBlciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRhcC0+YnIgPzogREVGQVVMVF9CUklER0VfSU5URVJGQUNFLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCk7DQo+ICsgICAgICAgIGlmIChmZCA8IDAp
IHsNCj4gKyAgICAgICAgICAgIHJldHVybiAtMTsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAg
ICAgIHF1ZXVlcyA9IDE7DQo+ICsgICAgICAgICpmZHMgPSBnX25ldyhpbnQsIDEpOw0KPiArICAg
ICAgICAqKmZkcyA9IGZkOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGlmICgqZmRzICYmICF1bmJs
b2NrX2ZkcygqZmRzLCBxdWV1ZXMsIGVycnApKSB7DQo+ICsgICAgICAgIG5ldF9mcmVlX2Zkcygq
ZmRzLCBxdWV1ZXMpOw0KPiArICAgICAgICByZXR1cm4gLTE7DQo+ICsgICAgfQ0KPiArDQo+ICsg
ICAgcmV0dXJuIHF1ZXVlczsNCj4gK30NCg0KVGhpcyBjYXVzZXMgYSBidWlsZCBlcnJvciBpbiBt
eSBlbnZpcm9ubWVudDoNCg0KLi4vbmV0L3RhcC5jOiBJbiBmdW5jdGlvbiAnbmV0X2luaXRfdGFw
JzoNCi4uL25ldC90YXAuYzo5MDE6MTI6IGVycm9yOiAncXVldWVzJyBtYXkgYmUgdXNlZCB1bmlu
aXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0N
CiAgOTAxIHwgICAgIHJldHVybiBxdWV1ZXM7DQogICAgICB8ICAgICAgICAgICAgXn5+fn5+DQou
Li9uZXQvdGFwLmM6ODYzOjE0OiBub3RlOiAncXVldWVzJyB3YXMgZGVjbGFyZWQgaGVyZQ0KICA4
NjMgfCAgICAgdW5zaWduZWQgcXVldWVzOw0KICAgICAgfCAgICAgICAgICAgICAgXn5+fn5+DQoN
Ckxvb2tpbmcgYXQgdGhlIGNvZGUgaXMgc2VlbXMgbGlrZSBpdCB3b3VsZCBiZSBwb3NzaWJsZSBm
b3IgcXVldWVzIHRvIGJlIHVuc2V0DQpJZiAhaGFzX3F1ZXVlcyAmJiAhdGFwLT5mZCAmJiAhdGFw
LT5mZHMgJiYgIXRhcC0+aGVscGVyDQoNCkNhbiB3ZSBkZWZhdWx0IHRvIHF1ZXVlcyA9IDEsIG9y
IGlmIHRoYXQgaXNuJ3QgYXBwcm9wcmlhdGUgYWRkIGFuIGVsc2UgYmxvY2sgdGhhdCBwcmludHMg
YW4gZXJyb3IgYW5kIHJldHVybnMgLTE/DQoNClRoYW5rcywNCiAgICAgICAgQmVuDQoNCg==

