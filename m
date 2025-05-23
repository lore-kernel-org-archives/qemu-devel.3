Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2395CC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHoO-000676-Pi; Thu, 22 May 2025 22:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uIHoF-0005rK-Fz
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:06:58 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uIHoC-00087B-78
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1747966013; x=1779502013;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=il0Xy5ZOhmmhdvwMdIhObiLVB6qvXNAdHI5WYd0eCUA=;
 b=LaOeiAkRKngGe0mafyIESOr1hQynEEalc4S0hf0YtWyauHGcjTUnamhp
 V3iknZYctUhfI7VHrnJm4d62UIzJP2iqGCzwI5U+1zHZ8EiAWXpXQH2T+
 MqQuvwwusK8V48LMkjNdCyGqMdtzZUPokQBuqYkzX658CLLjNV/dGPIAy
 PPA9w92p/0RM8j+KRZp8ShDRep20WHKWkADhsj6aWlQk4M5Kvpct5ct83
 PaVYJBwOLMZIxGYNq7ttneRuAkq5H7KY+XjRpi8bthEZwC6vt52Rr2SWz
 rq0rqu97UDmfHMsbtuVc+eGlagGzCGtAON/nMCXlmk2JuJQ5ufQ8/ps+u A==;
X-CSE-ConnectionGUID: pDWOdBCRQQa0q/9yqWprgQ==
X-CSE-MsgGUID: euFnmUP8Rr6Y4/zpjwMhdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="156249160"
X-IronPort-AV: E=Sophos;i="6.15,307,1739804400"; d="scan'208";a="156249160"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 11:06:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSYrBKbCZuksR4j5Sh3r6DMtZKdC+4U1J+lVEd/U9Yj5XcMGw5mqE+R5bt1/RYUxwB2xJEjo9LCRT0KiFcO2Hz/qcMMKx0LKRNEVosaITavyRJtoMRu6PrkZTBYEmL+oOw7Yw4+Y6qR6HaEIqsP1opXgeoHz462o00ZHJR5ev83EkSJPvmb1okIxqWiftXEjPvWkIQ/P9lgEsBNissBeehuM+w3W3PFJ/aFHRlceABPuAqqdTtySY5ghqTZKaHZpGDv6Yq66hfKYwGMA2Mua4mYFJrGx72+X/bSdtmHhRXAtHkhjXjS5hMnDBOXhMdzE1d1CM+pWrALz7zyHf8hykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il0Xy5ZOhmmhdvwMdIhObiLVB6qvXNAdHI5WYd0eCUA=;
 b=peq/v+4zCZAIAQgnbw8PJJ9hiLM5QRZGdDL6OPCepmUbc39uVh8j6JJAnFx26BhaeNN/jo+i1obS9WFAYdnfn5oQcOab3r+jGuHEAJj4DRSotAtcaOqvxyrfqQA5SWZk6/0zTtfr0IJ9Dj73LULkSwpk66mNSBmyczo57Sw6+CQYzgkyiSwL41flyi20+afJ24v87UfCVzvaN84hia7h9AuuLM5WOwBx/Zp7+bqrwsMuLClPX/2anVdJ/49YxpVMyVld8zSCJajcbE/ylCMnDPSRgfsYcEMKme1zTVw0/BfADh2wRLT+SZ4dK5WogbVnk/LCralHe4fKWiD1IiMMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS9PR01MB15686.jpnprd01.prod.outlook.com (2603:1096:604:3c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 02:06:43 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 02:06:42 +0000
To: Peter Xu <peterx@redhat.com>
CC: "Dr. David Alan Gilbert" <dave@treblig.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Thread-Topic: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Thread-Index: AQHbxQs15uH9M22qoU2fNrKRAYHbDrPczskAgABZVQCAAHXQAIAAQEoAgADPB4CAANdQgA==
Date: Fri, 23 May 2025 02:06:42 +0000
Message-ID: <7e3b7343-fbfc-43a4-a0c6-eb9c037da4d3@fujitsu.com>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <26d8a22f-adfb-4990-8015-c24fd1304c8c@fujitsu.com>
 <aC3dJvwXK9eW1YO6@x1.local> <aC4_-nMc7FwsMf9p@gallifrey>
 <80ff85f3-1e75-43f9-aeff-99e5033e6090@fujitsu.com>
 <aC8jkx-PnaJsuUB5@x1.local>
In-Reply-To: <aC8jkx-PnaJsuUB5@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS9PR01MB15686:EE_
x-ms-office365-filtering-correlation-id: c7a8dda4-0522-4796-5e88-08dd999e7657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ODVCZmE4SGZWRHRFSHlVOHpWaVoxSGpPR1N1TXR2VUNBMzlFSktqUG9NRHhn?=
 =?utf-8?B?b0xUSWlHRVdyaExKSmpwL3k4aVQ3Z3FWWUJXRlZDdy80STludzhiSVVxWUl4?=
 =?utf-8?B?OXNSRGtQaFVxYTZ2YjBwUlNNbm95dXRXVFJFcnlkM1RndjRRUlByYVpGNUlh?=
 =?utf-8?B?dldXQ3FEZEplRVUxZkl3emdEcTAvRzcvVEVzdEZ5YVV6d3ZRYkI1blJoQjIx?=
 =?utf-8?B?OGZVaW9rVVdmc3R3QUZzcEtYTE1YSUsvc0c1TzJSYzdZbjU2aHNYT0VIY2FO?=
 =?utf-8?B?dXNXUjJWZXZZYnpEL3pCc2g1cTI1UEVhdzZDbW1sa3JJL3hOekxzOG1ManRl?=
 =?utf-8?B?Qy9jaXkvbkViNFA0R3JEem9mUUFraUFVbzhvRGRGZ21WbU1ESmJiM08wVVZi?=
 =?utf-8?B?ZVg0aGNBQ21jTHkwRkkxS2V2SG9tTDhhb1RlUzU0NHFUSllRSHpiSzhMTGJx?=
 =?utf-8?B?aHhjTUtNSk1EeVFIdG05eUpOcy9rS2lZRzd4aGk1N3ZQRVowRldLYUxwclFn?=
 =?utf-8?B?T0RXZll1cDJRZVYrcFltaVVHWmd0NGxFdjRYUU1BOE1YbVBHQWZTeDhZRDlZ?=
 =?utf-8?B?eTRXd05jT0RsU3FNZHhaOUo4aVJpdTBnTks0R1JVak00RDBGQ3orY3BFWXVx?=
 =?utf-8?B?Y0NFbmVKZUdESGZjRkRYQi9xTDBvNjdtT09yeFFhemNGV3ZiN3RJWW1UL1ZC?=
 =?utf-8?B?em1HclVheXYvYjZHMjdZTXJLTTZWT21hTWFsemFRRG93aFhYY1VINmlSRXNG?=
 =?utf-8?B?ZTFVZ0FzeTllaGRJc1pBMXNLQUZXTUhIaTRDK1hrM1hCS2IvS0hMdmZWTTJS?=
 =?utf-8?B?UGkrTjUrbVdndDdqTGthZFA1a01jK0t0TE9LSnZLdldtQ2ZGQUsrdVE4U2F6?=
 =?utf-8?B?SFRFSUlqeUdtYUZUdTRnNlUzZkZkVXJ0YWpxelBRekF2cnh0cnlQazd3RldW?=
 =?utf-8?B?SVBZME44c0tmdWhqL2dsTXc0NzZqNENhdG51UXB4VXpYeW5weHdIaXFLYUky?=
 =?utf-8?B?a0psUUNva2QxcWw0cXI1Ym8wbmE5eTFQOCtEZDNWaklINGwxdUYrRFFFNlli?=
 =?utf-8?B?Qk83TC9lYVpUTjhlMkZ6Y3RjWnFwdWRtUlpKQUR2bklycXUrMlAyZWVXU3FW?=
 =?utf-8?B?YmozZXRhYzFVL0hDbHpkWUF2NVowdVBmcC9ocHJjZ25aalVSV3ZXSDdLOStL?=
 =?utf-8?B?Um9GaFNsUmJSQ3BUYXhqWnRNWEc4MldiUERyUmFRWHhtQXhJb296dTlReW9h?=
 =?utf-8?B?UjRxYTZseXZTMG5UbDgrNTRESFk4dlpWUkg5REVBd295aUUrLzhFMFp5NTV1?=
 =?utf-8?B?ZHpTbHNVQ0g3Q2xBREt3ajVnTzNTSFFWekt5US90cTVvM2I2dGhoVTRYbmFO?=
 =?utf-8?B?ZGc2N0JFOWhpOGN4a1l5bXNRYlBScUE1QWxLK1F6YnBNaUFOcDF2N0M4MjBp?=
 =?utf-8?B?Sm5SZHRBdUpOVDl3bm96bTJaajdWWm1tZmtiWndiL3ppMG05R3RJcTNSdHlq?=
 =?utf-8?B?UnBGU0JXWnJ5UFVkVGZieFhFWk1lQkJsbnVEUUN5eVphR25RaWdpZEQxL0Jl?=
 =?utf-8?B?c2EwSkoya2VYVFVyU3AxazdGbHFQQ2NMTkg1UVNPV2VwT1NPa3NjdWRueXlF?=
 =?utf-8?B?Tm4vWWJRbks1ekIzTlNPSHVncWxGL1hnZ3Jsb0FPQjYwTXR0bHIyM3I3bWxk?=
 =?utf-8?B?MkVBZ1IvbDJ0S2QzcTlzdHR2YmNWTHNxTVlHc2RtMHJwbUx1eW1qbTZhang0?=
 =?utf-8?B?T2VMOGVkRmZnWTdId2lhdmJ4OWh3N3QvTHFqT3lEaFlhQ2VFR2ViODkxNHo5?=
 =?utf-8?B?L21QakRLRzJybUlzVlZtZFU0RnlVR3ZuSjY3Z0tveHNTV0xQM2RKUmVuem9s?=
 =?utf-8?B?S0NnbzVkZElWMnEzUEcwK2xpbENEWVRna0dtdlM4UW4rREdIanhFQjViaEpz?=
 =?utf-8?B?aFFvZzJ5d01mZXV1dWgvWWo0OXN0eTRXdzRzUC9FVHA2WHJvSUVMR0dSbC9G?=
 =?utf-8?B?Tmw2L2lSNXZtL3g3a1FFL2wrTnhNbG9CTkhxWjYvSXJlcHlQMWhxdjVhOEhu?=
 =?utf-8?Q?i0/x3Z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUVTQUZYODI1eFdob3FpTGtNbVNTZFNydFgzS0hzSDJjMEZmN3lsTTYwNUQr?=
 =?utf-8?B?bzdiRzFXRDFqZng1eFhBNFUzbEJhdXRtd0Rxczl3MXNrWEZ4aWVaanowMW81?=
 =?utf-8?B?WFFWZkdnZ1BHTnNWVVpYYy91OStCbG1QUjRGK1pFMXZ4UDdQZFhSMXg2SEJO?=
 =?utf-8?B?MzllMnQrQ1FWWTB3SUg2MzVGQiszR0hmeVlicWZGL3ZuVm5TejFOekpUbXhY?=
 =?utf-8?B?L1B4dmhZbmNiY0hqYUFlZ3dNMDU2bFl4YklnaWZEbWFyRWdyVE9qY3ppOXAz?=
 =?utf-8?B?S080TEoyQ2hoS1ZlYlpsclQxWGNxaFlsOVpQYTFCck9qZWs3c2dQZzZkMEo1?=
 =?utf-8?B?ZXBJSlBLTVZYRlhyc2FoRk9rUmUzekRKVFhYT1RKWkxLejliMmJrTUIzN3Nr?=
 =?utf-8?B?WUdvTGJteXEveUNZZFZLbTErbjZZVHhhT2hDaWQ4T2t2N0Q0TXlUbUNFVFNH?=
 =?utf-8?B?c0NwN3Y4Y1ZVem5CY3Z6ZmJndEhEeXJ4TndGNGpHQnVjenNrd0FmNFdnLzk4?=
 =?utf-8?B?SDFkbzF3VE1PMnlqengzWmx5M0NOMzBoeEVyUWo1UUl2SStlSExmN1pBN241?=
 =?utf-8?B?bkNYVWs3akhNSXZ0aFBhVVpaVy90aXVjVFRNZzcvd3BsSlRGNE9tMU02cHdh?=
 =?utf-8?B?ZHNHQTM4TVAwem9KaEhxZlFnT2VwRk52NVl3cHZKcUdySGFUQjlnRTBISSt0?=
 =?utf-8?B?K2lucXBmby9QSXh1ZkZrcE52dnVHVCtSTUhReWdxSlRkMjJvY2ZXK1Y1bkNL?=
 =?utf-8?B?aFhRdUZkNS9iTENZMFM1T3U4VFIvd1YwNlUvSXpaMWdEbzk0UUZ2VWlXQ2Nn?=
 =?utf-8?B?ZnhNM1EyMUNjZ2xpcURzeUNqRHpqeStEZ2NaSkgwb0FONGNUNmkvQTlhTG50?=
 =?utf-8?B?c3B1Z1JNT0hrSTN4Zm9NRnBPMy91V3FEUDJKajNJYUVJbGhkN1AybEx1L0o1?=
 =?utf-8?B?NzU5bUpwWGtDMnAvNVhHQXdZdmYxRjdzMWl1elJlYU91bUNJLzJqMHRsNkxE?=
 =?utf-8?B?K0cyQzJKUldCL0NjOE01U0JLRTVldkVxOUoxQk5PQXd6eEl3MmJzQ3ZUYnZH?=
 =?utf-8?B?cFFZTTNQOFdiR09vYk13aEwvTXoxRGZVN05XdnpZK2toVE55cHEzdXJkMHJ0?=
 =?utf-8?B?dmIzT1o4cHFSWWI3VS9zSTJiWXV4eEhxQUlySW9RcnFGRUlNMVFxa3pJMkxy?=
 =?utf-8?B?ZEYzNGtSUjNYbU5XbDlYajBwUkNFbUZiOHNXZWxyQ2VSK2h5ZXkrdmdrL0Zi?=
 =?utf-8?B?Vm8xYXd4cHVMKzRPWlJNUktoV2VQRGdmY1p4TVNRMUR6Vmt6M3lXN1k1MWRt?=
 =?utf-8?B?LzUySmFLaThxYm5Nb2NBM0RaM3BuZUZET3V5aU0zRUsvU1lUckJMWlZHd3Ir?=
 =?utf-8?B?czAxUmlkTll1OGs4cytpVEpYcEtEMEhmQTMyWG9rVGNyVTcyV2M5N05pVWI4?=
 =?utf-8?B?SVNaSmV5Yk9FZ3EvN0NPRlJjOTQ1UW9MZnVSRzdNbkViT3JLMEdlSzFMMk1z?=
 =?utf-8?B?UWdjRUhvQWEzL2NNcDZ5SzBpUHZhazBGako2Q1M4bjloZ1piUGRGT2VEZ2ZY?=
 =?utf-8?B?Tm01SmI1WGtxaEtuK3VzVUdoYmZOUEhzbXNrVUhQT1ZDc2hJblp6TWUvRnht?=
 =?utf-8?B?N3FCcTZ1MW5Gemw4T2xUeTEraFdaaU1TVlNGTGNqd2p6N1ZmdmxGdHNCQkNq?=
 =?utf-8?B?c0VIV0NnMXJsRk5PMWlTbEFrTWZvUEpJM1dsaE15Ry9heGtJRE5nRURQQmJk?=
 =?utf-8?B?TUhHa2VvYzdZVFVDcjRLRUJjNUxKTWR0Yi9nWVdEQkp4MTdOd3QvMVZvR0o0?=
 =?utf-8?B?NkdQYXhXWWZjNlh1aVptS1BHdWFwSzBiZ2NlUXV5cFd5N1laZ2RYbVhxOHB1?=
 =?utf-8?B?bjJsWE5JQldtUFdqSXBRQ3VqanJmcEZrK3FmY21GM2JvTE1KNlBjYm9IYTEx?=
 =?utf-8?B?OE9HTEp4Z2pKL1J1QjR1WDRZZjA1WmFQQTVyZEtENlZnbkFFMkZUaHhQOUti?=
 =?utf-8?B?ZXpCRTI1dUNDaXg4cnZ1MUtuRHZiQk84Y1hYbnBjcUxnKzN3YTRHN1pHWXRt?=
 =?utf-8?B?bStOd3Z0eGkyOWprU3gyR3RtbDlSb1lBb0hWUnB2ZjU0d3ErNEdPSndzb0J0?=
 =?utf-8?B?UFByNncyOVBUeUNCOTFzbW12UjlLTlBLK25HMWR4MjUwUUJaMStXZlB2QzFY?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DEBDBA9ADA6264793CF5E553E8C058C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JDe7Vg71rrk19XdPU7FXuTrn8uSK6QRBa7a+nYezuPh4yLVyELDirkVNMF3N62VW2OEEz9Uc/iCXxYwTcWbVddKGAJaAcP/aptv0BMk4HtFEgvQZKQaypL+AUVUgpRaXM4q2avhfgtNe0649fhAh2gDqtmQf7gWSkQvXR1e5DIH1Lku9Z/2DUS1CTPsLMGtrJzkXCut9f3eqzNc8/KSsYjUtJCLcuRc0znHQY1TTA6VYhz0n/4U3TEGjE8R6breNbt9nafnfgTeoo7D0HGaVRZWgR0D9i08QFTavWNS32jyZPNjh7vh+2YqrbGMPg5koqY3zRpvxcQ/uX4oGY44rmBC0mtcBsovlinTR+88h/jSA5eOnZU+pAk7IFTddsnvcETuxkjl1X4L6TjzV+v222q9pEhCBGauFgISY4oAmVzoO8+iw1/XNcrsGW9kFqqw4CLbCM/H5DggBVdV90xg2RJQ+mtIj/liFT6zEbZcLj1a9wbnE5ax5VQh4+YqgIp60ACc/6HQMCAscbZ3rFSsSMWxBCdo67ZkTbc2lfqV4R3OJ7JBinpkjG6MfXZ63BYWcJzQqG1dt+byRVCCIeo+lKQC6GuK6/5SoNO3quHavarj4AOhUqTdhP/M93tm9C0tf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a8dda4-0522-4796-5e88-08dd999e7657
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 02:06:42.5683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFcKEUF2BYP3GzwpfXOjkxwU5oP0RxVDuB4ONFAI7xubQlQsvRGo77bBuYoHboY6W1TY4l46jsa2RPKywwEoDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15686
Received-SPF: pass client-ip=216.71.158.34; envelope-from=lizhijian@fujitsu.com;
 helo=esa17.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDIyLzA1LzIwMjUgMjE6MTYsIFBldGVyIFh1IHdyb3RlOg0KPiBJIGZvbGxvd2VkIHVw
IHdpdGggRGF2ZSdzIGlkZWEsIGJ1dCB0aGVuIGFkZGVkIGFsbCBlbnRyaWVzIGludG8gaXQsIGJl
bG93Lg0KPiANCj4gICAgU3RhdHVzOiBwb3N0Y29weS1hY3RpdmUNCj4gICAgVGltZSAobXMpOiB0
b3RhbD00MDUwNCwgc2V0dXA9MTQsIGRvd249MTQ1DQo+ICAgIFJBTSBpbmZvOg0KPiAgICAgIFRo
cm91Z2hwdXQgKE1icHMpOiA2MTAyLjY1DQo+ICAgICAgU2l6ZXMgKEtpQik6ICAgICAgICBwYWdl
c2l6ZT00LCB0b3RhbD0xNjc3Nzk5Mg0KPiAgICAgIFRyYW5zZmVycyAoS2lCKTogICAgdHJhbnNm
ZXJyZWQ9Mzc2NzMwMTksIHJlbWFpbj0yMTM2NDA0DQo+ICAgICAgICBDaGFubmVscyAoS2lCKTog
ICBwcmVjb3B5PTMsIG11bHRpZmQ9MjYxMDg3ODAsIHBvc3Rjb3B5PTExNTYzODU1DQo+ICAgICAg
ICBQYWdlIFR5cGVzOiAgICAgICBub3JtYWw9OTM5NDI4OCwgemVybz02MDA2NzINCj4gICAgICBQ
YWdlIFJhdGVzIChwcHMpOiAgIHRyYW5zZmVyX3JhdGU9MTg1ODc1LCBkaXJ0eV9yYXRlPTI3ODM3
OA0KDQoNClJlZ2FyZGluZyB0aGUgInRyYW5zZmVyX3JhdGUiIGFuZCAiZGlydHlfcmF0ZSIgZmll
bGRzOg0KV291bGQgaXQgYmUgY2xlYXJlciB0byBkcm9wIHRoZSAiX3JhdGUiIHN1ZmZpeCBzaW5j
ZSB0aGUgY2F0ZWdvcnkgaGVhZGVyDQoiUGFnZSBSYXRlcyAocHBzKSIgYWxyZWFkeSBpbXBsaWVz
IHRoZXkgYXJlIHJhdGUgbWV0cmljcz8NCg0KDQo+ICAgICAgT3RoZXJzOiAgICAgICAgICAgICBk
aXJ0eV9zeW5jcz0zLCBwb3N0Y29weV9yZXE9NDA3OA0KPiANCj4gTG9naWNhbGx5IEkgc2hvdWxk
IGhhdmUgbW92ZWQgIlRocm91Z2hwdXQiIG91dCwgYmVjYXVzZSB0aGF0IHNob3VsZCBhbHNvDQo+
IGluY2x1ZGUgYWxsIG90aGVyIHRoaW5ncyAobm9uLXJhbSBpdGVyYXRvcnMsIGRldmljZSBzdGF0
ZXMpLiAgQnV0IGN1cnJlbnRseQ0KPiBpdCdzIGFuIGVudHJ5IHVuZGVyIGluZm8tPnJhbS4uIHNv
IEkga2VwdCBpdCB0aGVyZS4NCj4gDQo+IEl0IGFsc28gaGFzIHRoZSAidG90YWwiIGluICJTaXpl
cyIgdG8gbWFrZSB0aGUgbmV4dCBsaW5lIHNob3J0ZXINCj4gKG1lYW53aGlsZSwgInRvdGFsIiBp
cyBhbHNvIGEgY29uc3RhbnQgc2l6ZSBsaWtlICJwc2l6ZSIpLCB0aGUgaG9wZSBpcyBpdCdzDQo+
IHN0aWxsIGNsb3NlIGVub3VnaCB0byByZWFkIHdoZW4gcmVhZGluZyAiVHJhbnNmZXJzIiBvbiB0
aGUgbmV4dCBsaW5lLg0KPiANCj4gSSBhbHNvIHByb3ZpZGVkIGZ1cnRoZXIgaW5kZW50cyB0byAi
Q2hhbm5lbHMiIGFuZCAiUGFnZSBUeXBlcyIgYmVjYXVzZSB0aGV5DQo+IHNob3VsZCBiZSB0YWtl
biBhcyBzdWItY2xhc3Mgb2YgIlRyYW5zZmVyIi4NCj4gDQo+IEhvdyBpcyB0aGlzPyAgU2luY2Ug
d2UncmUgYXQgaXQsIEkgY2FuIHNlbmQgYSBmb2xsb3cgdXAgcGF0Y2ggYWZ0ZXIgd2UNCj4gcmVh
Y2ggYSBjb25zZW5zdXMgKEkgbWF5IGFsc28gaW5jbHVkZSB0aGF0IGluIGFub3RoZXIgc2VyaWVz
IHdoZXJlIEknbGwNCj4gZnVydGhlciBhZGQgdGhpbmdzIGludG8gSE1QOyBJJ20gbG9va2luZyBh
dCBtYWtpbmcgYmxvY2t0aW1lIHRvIHJlcG9ydCBwYWdlDQo+IGxhdGVuY2llcyB0b28pLg0KDQoN
CllvdXIgcmV2aXNlZCBsYXlvdXQgYWxpZ25zIHdlbGwgd2l0aCBteSBwcmVmZXJlbmNlcy4gQWNr
ZWQuDQoNCg0KVGhhbmtz

