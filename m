Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B76DC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 00:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHuDR-0007vr-CH; Wed, 21 May 2025 20:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uHuDN-0007vS-55
 for qemu-devel@nongnu.org; Wed, 21 May 2025 20:55:17 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uHuDK-0007Vs-4Z
 for qemu-devel@nongnu.org; Wed, 21 May 2025 20:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1747875315; x=1779411315;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Xa2SanEulcq29/78NPPbCbLgvnGY+FU4zId/ax8KSLA=;
 b=tc56baqVJBsszg0uRR5N8027mKlqgpkqAtw/ydVUeM6Qu/S2FA5sFRrA
 r4RwwBPCgXhXw4Co+wVLWMkxfVsO3Dj1mjw4/MxK4UR8t+5Wj8kk743MD
 GpyFv1HaUlEMNZJKJkKFNnliZXfHBbtzJ2Gw0CPQS8WMfrw7GkIa3ZY8B
 R/LO6mTO+7fLBM+fM8pyVU73Tn9vm2RPemUNK4CGJKCvE2xcra5RBQjT1
 QXZxMXKvQfK8caYDViVSPjuNMDToG3616HsSM17aFp4nTeyPeFKaJXttf
 KdGnf/DRFsHu2LYoJWrWp4dQ78Ckv6seoRbzJOn+/QQ+rSWvMCtNjFwab w==;
X-CSE-ConnectionGUID: rQFD/ijgRRysmUW4LSsv6w==
X-CSE-MsgGUID: Vpz6IKkyQFq3ycxLObxTyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="67268079"
X-IronPort-AV: E=Sophos;i="6.15,304,1739804400"; d="scan'208";a="67268079"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 09:55:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDAQ8bLSuMxqqthMabw2idrlTmr7eemF2J0Oo28a2vHXHUcR9oL4ia0I0AqI4/WOOvF+K/W0ucGyH3zG++duT0M9bvor7YIUHwt3Hnh41LtEW8hQxprJkN4obV+IsNyDvCS+P3PHwDhCM3iUhlzM5GEH+TVngKaJKb5y0NWkNEH+H5Kw63oNSVaM+fREqP1eVCZtRifaC039nzTIO3aj75lDx/Q/F2uI4iJe68Yo1n4yq6BhyasGNGZO4tx7X+cF4EhM11eKL9hOHW9ONcIauIRlC+3SZl3HzjMe2SmTQdUx3GZT5AUo9VflMlZmm+GJLFOo03qYXTszNhC6RRBqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa2SanEulcq29/78NPPbCbLgvnGY+FU4zId/ax8KSLA=;
 b=yAgij6XzbA5g7aFJpfbD09Glu+Cm51kTZiVUEG+WfGp5AcRM8G8wuinblACBzjQOi0/mYkkNjKgybirWAxt/JTFzFh1cKiUrCvkgynjv34CXbnQbYCtnSo/r5CoUUuwDPT0HbzRv0uS869SkDrT9SSMICIYnUA/BBULTql8MEG9pYstG0mPhHgd8S83ZoZRmgeNIlM8HVdYHSRv24s4nMti7uL+D296Rp00MHRHk3EHhqgo1wQNoNcwvnkW5TYnDPn00PuvJy9eKo7PPKM4Z+flQ1KZbVllu0cuUzudRefamAluUgUmndLvuy/6MPYEooh9VnwrnKBGzHLjMGVPf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSOPR01MB12441.jpnprd01.prod.outlook.com (2603:1096:604:2de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 00:55:06 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 00:55:05 +0000
To: "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Thread-Topic: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Thread-Index: AQHbxQs15uH9M22qoU2fNrKRAYHbDrPczskAgABZVQCAAHXQAIAAQEoA
Date: Thu, 22 May 2025 00:55:05 +0000
Message-ID: <80ff85f3-1e75-43f9-aeff-99e5033e6090@fujitsu.com>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <26d8a22f-adfb-4990-8015-c24fd1304c8c@fujitsu.com>
 <aC3dJvwXK9eW1YO6@x1.local> <aC4_-nMc7FwsMf9p@gallifrey>
In-Reply-To: <aC4_-nMc7FwsMf9p@gallifrey>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSOPR01MB12441:EE_
x-ms-office365-filtering-correlation-id: 63a2c483-191e-42b3-d686-08dd98cb4ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Z0owQXhOR3V1KzZXaU5GT3VBTWM2blBUOEZaaTJ4WkRJUTJFR3BZTjJTYXZv?=
 =?utf-8?B?RlFSNEVFcEkrOWVDODZyQTcrcVN0TjhVV2QrSFJSdjMySUVvTzRFekhjQUtW?=
 =?utf-8?B?b29tTS9uamxsNXBSSTNBOXl2anJqaFpNMUwvVXErMlZyYkl2Sm12bmtzT1Jv?=
 =?utf-8?B?MVgwTUlqbHhWazZ1LzZJcytFUTBKcG1CUEZZL2R0UzY1WHArelJWSldBbkF1?=
 =?utf-8?B?QUl3U0VOS1FJY2dOSDdEclJRU2tqam9vS25PU2JYWEZPejFLSkFKMFRHMWYx?=
 =?utf-8?B?ZmIrV3dEdDZxSmxMaVlwWStDV1Y2TVdQS09RU3JFUXZVNmxHNHBZQlVBWFlH?=
 =?utf-8?B?a29aK3JubkNzNXlsZUJkNzdkb0hGVURLeklBRExobFdWSENOZHQ2VTJPVysr?=
 =?utf-8?B?YTJMYVY0VkpxNUIzRGhKL210YndGc2dlclphTDFpSWFzNC8wNWhlbDR1K3h3?=
 =?utf-8?B?V3ROQ2FiMVhGd3h6Tmk5UlUrcTArRERsaXAyQUhNMEpwYzdTOFExMXhLQVNx?=
 =?utf-8?B?KzNlT0xqS1JJTkFmZDRsZVVJSzd2aGIxdlh1WUpzSjJpam43YTVzRkpnZWV1?=
 =?utf-8?B?MFZIczRKTEJWWHpuUHRrSFBrUll5Um13OWdydVJqWTRnZTMrMlZyb2RQWU1B?=
 =?utf-8?B?OFZReDNzSVptRUJRRmRESXBXYll2eDR2R2gwMDRrTTVINEQydXpvR3laeTVY?=
 =?utf-8?B?S0NOSHJPcHNyYjVqcExvRnhZdkFpcUFOQkhZa1gvbEt1bHRVTmxORytzR1JI?=
 =?utf-8?B?SWR2S2J0SlVGRDdJOURLOWdjTEo5NzF0anZlLzlvUUpBU2lEN2lQTm0rOFdQ?=
 =?utf-8?B?dm9jZno1ek1yaSsvelNpVVhLR1I2eUt6YkEyN0N0M0ZTTlRtQzVPNklka1Bl?=
 =?utf-8?B?c1pIUmFjOTlZMVNHWHlmMWdITnpidWsySExtMnMyN0dkbVhnZklQMW9oaUpF?=
 =?utf-8?B?eHU2UGlMV1JxUDEyVWlKU1IvYTd4VC9wRlV5RjI1UnZzMHZ1WDk0a3hPODVh?=
 =?utf-8?B?SE5PK2ZkZ2Q4eGdnQStiMXRHRWZPRHJsQ0kwZDQ2b204czl2V3pjQWMyanhH?=
 =?utf-8?B?RzdCdE12MWRRcmgxSVdQaXBrenBxbC9WWXJJbzFmSzh5QmY3VUhRMWpiNjk2?=
 =?utf-8?B?Q3RMNVV3QldIZWZKdE5GY0NjYy9zNUFBYkVsV1Nhd3RuaVB0Kzd0RHNvbmVT?=
 =?utf-8?B?V3lWY0tEV1NjL1V6M2pkR0ZqTnRhT3poc29MbEtjZ2d4Q1orbHo2YXVDdklP?=
 =?utf-8?B?VGtvNUZNemluTFcybkhnSkNOYUI3L1NIaFprNXZnR1N2WFNQVzZPSHVmd0R0?=
 =?utf-8?B?d3c2ZnRiM0JqYlFFYUE0UjVaYTI3ajZUbzVjYnBZcUhLVmFDakQ1a1BOOE5m?=
 =?utf-8?B?ZmQ1aEFLdTgxWVJOK3RITXNYSTkwNzFVbUhnNUNMODdPUzNTWnEwWFYwaXBz?=
 =?utf-8?B?SEpuU2ZVc2lWVy9TYjAySHBHOVVhSWs3T0sxNWlmMWlMbUhzVFRteFM2TzFi?=
 =?utf-8?B?SzhVMGhHL3BuZWx1SkhKd2o3VlIvYWhNVVplMEZleVZ5R3VreE5jZnNRNVNG?=
 =?utf-8?B?dm9tU3phM3pyOUozLzBYR2ZOOTlQMWpwNTltS21pbFNsRjJNNVNObU9CRk9X?=
 =?utf-8?B?WU41OTREUVNJTnZqakgwQWZqbmpEUHpEMUx0T3BIS0JUc0QrcGc5NUVsUFhS?=
 =?utf-8?B?ODZGL2hwUWVvQlZKMGZIOXQ2RHlEZnNXb1FrdXF3VXBFTTFyOEdKY0pIMTA4?=
 =?utf-8?B?V09JbXE0bS9qOG9tTVhXenBncjcwSVphcWJCUGsyRnhQL2FoQmxSMEptMisx?=
 =?utf-8?B?ZW5vRERxcWZLWno0bkNyc1lrcnFCNzVTQk1jZG5JVXVMTzI0dzlpSjZPTko2?=
 =?utf-8?B?eGhOR3l3eVVXUjdzNGdOaDJRWGZ3Ympsa1BNOWtBWGNjcFNjNjdjdXhBUlJL?=
 =?utf-8?B?Rk8zbjFwMEJiTEtIWnR1azF3dlJQclVkV2dqUzh5dTFFclNsejUyOEVmSjBP?=
 =?utf-8?B?dCtsUUdOR0NOR3VpUFdnZ2JNTzJYMnFodk5YdElzMlRITExqcDJ1eklIUFJh?=
 =?utf-8?Q?TGpFiZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnpYeE1kYmtSNWNySEpDWHNoWUpBRGVrek9sRm14R0tKbUVEK3FpdEV0clZX?=
 =?utf-8?B?Q09SNlFLRkpUZGRIVElsaEhxV001dnJFOUtwNzlnRVBVQTVkaTBCNWVNTXl5?=
 =?utf-8?B?eDU0MjAzSzNyRHdaRkY0Rk82WGtFRVhraHBYVk9yY0xTaXlCUWlESzNWcnB6?=
 =?utf-8?B?K2hpVnhBaTlVQlNidkRzdGdEUElKOWxpL2hMV2VYdkxLWWJ1MWp3ckJJVDY1?=
 =?utf-8?B?TWxpT2RjZExLQS9nbEVmNEd6Q0h4TllHL1NMWHJDLzAzMmlIT09FYlBkaU8w?=
 =?utf-8?B?eERhSXFyTFJhNUNaSDZyQTVqenlpUEo1QUNzaDJINVowYzFMZms0RlgrNzN4?=
 =?utf-8?B?RGNsankxSFYxRDM1VFhnWU02U09qSWFiVkhtOEJ2Y0FUWG9rSnFad1FHd2N5?=
 =?utf-8?B?dHZEb2Nrb1F2dnVYMmlUT1RjYTJjZWV3WFJ0RDMrSEJpQ2ZOWWlMQWZGRURP?=
 =?utf-8?B?STBVL1Z0T0plTnR1RVhwZFFUUnNxR0Z4ZWVLc3RHQ3lTam91c3E0L2lMWnJt?=
 =?utf-8?B?VGY1Ukh6cjJLeUhMNm1Ib0hyUVVwem5mUWRvQVhtazE5V1o0TGlSMlVDVTh4?=
 =?utf-8?B?eWlEZTliVE9XNGd0WnhqeFBPMEdkcFRxVkhVV1I0TVphdjVVTi9UMW1nZkJH?=
 =?utf-8?B?WUplQVduQ2Z0aHRxR3A1aENhK21uTk81OWVCZUJ4T29IRWxXTUdTUmFwU1Rp?=
 =?utf-8?B?TkNtMjVhYVhObkNLOGlrQTc2ZCt2TlF2T3BpM2Njb0NQTFljNjBkM1dPTWZv?=
 =?utf-8?B?VHNKckFUYkI3M043NUcwOEw1TDlrbGZVSktraVU4bkZJT1hPdUNkNHc3OVlK?=
 =?utf-8?B?TzcwN2h5QTl3ZUU3aW84UGhKSjFpcXR6SWhta3NITUUwN0xwb1VjWi9FTjM1?=
 =?utf-8?B?YkZKOWE5Zmh0SENUaWQraEpKUFRWYWd0QUdISGxud2NxbXhzT2VoOGhUaEtK?=
 =?utf-8?B?aUVvOFV4dEJwNFY4NEpOSDVCalMzOWRNWndQNkZuZ3dINitMRk9iSHI0SXVO?=
 =?utf-8?B?TUVla1FlYzNheEhMU1NxV014a2FUdGJZa2NuVE9GejJuOElLUENLQ2ZmUFJh?=
 =?utf-8?B?b3FIZVBGUzNtczJBTTJRa2VMRXdIK1hSM1ZGSktFdkFua2dYK0ZNcm9KdEdn?=
 =?utf-8?B?RGJTRlhVSFE1S2FsUmM2akwweTFMMzlvOVlMczh5UU8xMXI2QnlPcW5Ba0No?=
 =?utf-8?B?WldqR0xNVjJxL0Y4alBxRmVHV1NlNkRXeFdNUFQ5SC9EZGlDQm9vbFhTdUJq?=
 =?utf-8?B?TE1rdnpMMURiYW9lS2FmRWpObU1MdmNWL1YyTWpGZFdhVHhLVkt2c1JXTFBz?=
 =?utf-8?B?VmZCcHNvWTlZTUJIRTVBaVJPU3BaaDgvVDJCUVVJcUFPY2twa1U3azBHMmtq?=
 =?utf-8?B?NjFjVkMydFdFWU5JV2F4ZGFMTVM3TzJGZzV0aUJUWFE1bS9uUWR3Y0o2ZFMr?=
 =?utf-8?B?UkRmbjZqbERJQTdvUmw1ZUY5Ynp3VHp4OGdIM3gwaHdWS29Fayt0aHhoMmJ4?=
 =?utf-8?B?LzlZb0Jqd3g4MGRlTVppa0l2NGJueC80QkJLTFFLSzVsak0vU0RiUUExb01U?=
 =?utf-8?B?azVWYmh2VjBlTmNaVHM4TzJlQWR1dytUcnVwSGxLT0pld0ZlUWpITWRhNElZ?=
 =?utf-8?B?MUpJNXBwMGlPNytMRlZwQnZGdjRQS0VWck9kc0Z4V0pVWnBXSUtaSU45UXNX?=
 =?utf-8?B?UE11R004SEVSNGx6ZFIzQmRqNVJ5cmhEOHNLQ3gvU1dueU5ZWkZ6NHM3SU5B?=
 =?utf-8?B?bWQrOGw4MjRaWnovQ3N5UTFsVW8rZ0IrNUZLTkg4aWdORDlobTZ4bitxdFVY?=
 =?utf-8?B?SndsK0o0MkdSU3RaQWdVQzVRUTlUUWg5MXlOMmJBbzE5R3FicndUekhhVmRx?=
 =?utf-8?B?Wm0zTktudHJ6Yy95L2Y5RVRLaThWTHZ4Uk96amM4Mk9hSkM4b1lhUUZBbUtR?=
 =?utf-8?B?bU1SMW11bWlQOWdMSXl2a05iZEdhcVNURzlhbk5FQ0dqMUdFdG92OVFGK0hk?=
 =?utf-8?B?QUt5bVBwb0FoS29BWEd4aTJHS3dCNmhOdEkrUW02TW9Ua3VDN3l5NlRrTVVl?=
 =?utf-8?B?c2owd1Job2VSUnljaFppY3ZmNWlRRDBKTFprT2haTUlEK0NFMUxrbHlEZnRm?=
 =?utf-8?B?U0NyQU53SXFTMFdPRDFDeS9MaFBraGxHa1VaQnlUSUFzZTduNVRxaDIrNkRj?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A87ADFB640256148A11353FED5E03DB0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DeQ2We3T4D8cODesfrGI98fbzbIvPZrYaqKz5lrJn782RnyziM/ts30z/Z/RpFgMyTJ9Um0HPJwJqwe6PPwHUGFIJRInOr7H90j/uRqSFAaLBEgPoPmHWCMwgKmfJNtp/V5ypAB9U5/EX8cgrsK6dySb3MCo1nksBDw9IvKJ/mg5VJz70xa4k14IGFiEz/tdDp7wZ+m+5ACS6N1Ru5WT+wgQgER0D24b6uM9P0OkkibbtdFrEu319aZdOPHQOr96dkMmvjbA8SI4Qi2f/5bQo0Uj8xvCh1pf9Vv8OwG7YEPOvcuOCS8tPnIF8gr6k0n3SpWC8WTJ0vzMw7vDLIoBCiMhffRnJ2zSK8CodoN9c7K48Uhrfs68CkF/K3luX1z/UJUn/fHrxFRPAXZtZcoG6hztGCV14e8KeyyRw0d4/KT9KvPZTxW5Exbn50h5CFFbrxnQhtPhQKxDjtZpDiD/5Adrzk88Fp3uaZQuk/ZJwGSbq6349X5A0LRjvUvE2JoRdysaX9/TJxPCcCmh7+8K+kpC8NKrlHw69LAwE5wX9GfmZCyi5hoT5II6KRzfsnNjIAUc/IVMjqeEAf/CDGLx4IM+VaZDUVHVp8k39+P3YE+AGEN6C9yervkfTZ0czqR4
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a2c483-191e-42b3-d686-08dd98cb4ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 00:55:05.8536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giANolk5vF7uAPvu4VTeAr/nOrW1CPnREKaYzSLgTe6g/DCWHgej3kKZbqTCH41jT/z6V4AKMkILzpi0/Oqbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12441
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=lizhijian@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDIyLzA1LzIwMjUgMDU6MDQsIERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgd3JvdGU6DQo+
ICogUGV0ZXIgWHUgKHBldGVyeEByZWRoYXQuY29tKSB3cm90ZToNCj4+IE9uIFdlZCwgTWF5IDIx
LCAyMDI1IGF0IDA4OjQzOjM3QU0gKzAwMDAsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0K
Pj4gWy4uLl0NCj4+Pj4gQWZ0ZXIgdGhpcyBjaGFuZ2UsIHNhbXBsZSBvdXRwdXQgKGRlZmF1bHQs
IG5vICItYSIgc3BlY2lmaWVkKToNCj4+Pj4NCj4+Pj4gICAgIFN0YXR1czogcG9zdGNvcHktYWN0
aXZlDQo+Pj4+ICAgICBUaW1lIChtcyk6IHRvdGFsPTQwNTA0LCBzZXR1cD0xNCwgZG93bj0xNDUN
Cj4+Pj4gICAgIFJBTSBpbmZvOg0KPj4+PiAgICAgICBCYW5kd2lkdGggKG1icHMpOiA2MTAyLjY1
DQo+Pj4+ICAgICAgIFNpemVzIChLQik6IHBzaXplPTQsIHRvdGFsPTE2Nzc3OTkyDQo+Pj4+ICAg
ICAgICAgdHJhbnNmZXJyZWQ9Mzc2NzMwMTksIHJlbWFpbj0yMTM2NDA0LA0KPj4+PiAgICAgICAg
IHByZWNvcHk9MywgbXVsdGlmZD0yNjEwODc4MCwgcG9zdGNvcHk9MTE1NjM4NTUNCj4+Pj4gICAg
ICAgUGFnZXM6IG5vcm1hbD05Mzk0Mjg4LCB6ZXJvPTYwMDY3MiwgcmF0ZV9wZXJfc2VjPTE4NTg3
NQ0KPj4+PiAgICAgICBPdGhlcnM6IGRpcnR5X3N5bmNzPTMsIGRpcnR5X3BhZ2VzX3JhdGU9Mjc4
Mzc4LCBwb3N0Y29weV9yZXE9NDA3OA0KPj4+DQo+Pj4gKEZlZWwgZnJlZSB0byBpZ25vcmUgbXkg
Y29tbWVudCBpZiB5b3UgaGF2ZSByZWFjaGVkIGEgY29uc2Vuc3VzLikNCj4+Pg0KPj4+IFB1dHRp
bmcgbXVsdGlwbGUgZmllbGRzIGluIG9uZSBsaW5lIGlzIGEgdHJ1ZSBuZWVkIGZvciBodW1hbiBy
ZWFkaW5nPw0KPj4NCj4+IEl0IGRlZmluaXRlbHkgaGVscHMgbWUgYnV0IEkgYWdyZWUgdGhhdCBj
YW4gYmUgc3ViamVjdGl2ZS4gIFNvIEknbSBoYXBweSB0bw0KPj4gY29sbGVjdCBvcGluaW9ucy4N
Cj4+DQo+PiBTbyBteSBhYm92ZSBsYXlvdXQgd2FzIHRyeWluZyB0byBsZXZlcmFnZSBtb3JlIG9u
IHNjcmVlbnMgd2hlcmUgd2lkdGggaXMNCj4+IGJpZ2dlciB0aGFuIHRoZSBoZWlnaHQgKHdoaWNo
IGlzIHByZXR0eSBtdWNoIHRoZSBkZWZhdWx0KS4NCj4gDQo+IEkgdGhpbmsgcGVyaGFwcyB0aGUg
cHJvYmxlbSB3aXRoIHRoZSBvbi1vbmUtbGluZSBsYXlvdXQgaXMgdGhhdCB0aGUgZ3JvdXBpbmcN
Cj4gaXMgd3Jvbmc7ICBncm91cGluZyBieSB1bml0IHByb2JhYmx5IGRvZXNuJ3QgbWFrZSBzZW5z
ZS4NCj4gDQo+IFNvIGl0IG1ha2VzIHNlbnNlIHRvIG1lIHRvIGhhdmU6DQo+ICAgICBTaXplczog
cHNpemU9NC9LQg0KPiAgICAgVHJhbnNmZXI6IHRvdGFsPTE2Nzc3OTkyIGtCIHRyYW5zZmVycmVk
PTM3NjczMDE5IGtCIHJlbWFpbj0xMTU2Mzg1NSBrQg0KPiAgICAgUGFnZXM6IG5vcm1hbD05Mzk0
Mjg4IHplcm89NjAwNjcyDQo+ICAgICBQYWdlIHJhdGVzOiB0cmFuc2ZlcnJlZD0xODU4NzUvcyBk
aXJ0aWVkPTI3ODM3OC9zDQo+ICAgICBPdGhlcjogZGlydHlfc3luYz0zIHBvc3Rjb3B5X3JlcT00
MDc4DQoNCg0KT2gsIEkgdm90ZSB0aGlzICEhLCBtb3JlIGNsZWFyIHRvIG1lLg==

