Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C16C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 05:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkciK-0001C4-3I; Wed, 19 Feb 2025 00:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkciH-0001Bu-W1
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 00:33:38 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkciF-0000Dd-2W
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 00:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1739943215; x=1771479215;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9rvaRLlHA59+uQgUw8/EJXlJMObDkDJFQuWSls1i/xY=;
 b=L9eQZZOthaLslafo4eRhdX3nhFgpGISsgZ3Ur4zh3md6g7RiWUJDCYev
 XE+3BXnH8z114EZRSoIPis32tcJNlBFo6f1D4kCetA6fcmDr9jPWTaPO5
 rPT1MoQ4aPjS2/1Sh/25PfMqlRvkfZTSNnQfNh/Hnk009ujKKxEioPt07
 7ZXaXF0cEC2BTCDSPHjLPQbOEoXT8dvkJs9yIHnrgbjH0I0E6gCRjPA9n
 OwNNtA9jBsWjtlbzuGDOsB7fl4gvpZie9eUFRL/lZth79oIoJ1GnPJDi+
 JLBFPWbdCc5/HFtnrynpyzVWf01nTV0NCHwlVdxSl1qdVK8jemLKyY9mJ g==;
X-CSE-ConnectionGUID: 4z1KifJFTsKH4kgmBZeQbg==
X-CSE-MsgGUID: sbJTiMryRHqMvE/V25zo8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57879870"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="57879870"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 14:33:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlAVZCm/MDoKr6KNhAqqSQZOGo8vr9DB5RUyNr4QVwr8XxjdJDQ9yyMmfZ7YiizNTpvRLsUYAWFbedlWFG2P/IleT53FYITI2VELLtNsW4oiUV2pa5HG2GC0DkXWgGEMV1Hj+VIXLWM2UYHRu4IOmT5bH5WYTPzSYFOzNKKHcIQmlbI6yqopDnHbWVgdbchEZT0SZFz+cgZnNFH48+wu2UmeGF2L3RxzbYdny3rDLOUi01OTFlp8yZ8gp2WLHCp1x18L8n4/SLf4PNyfrUmsDPKjOtNzzUZBThkloM/CnAxxqt9ioarZj8MH7uq6uzpbjoN1fHddD2c8Zub3rvPhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rvaRLlHA59+uQgUw8/EJXlJMObDkDJFQuWSls1i/xY=;
 b=wX1hCLSti7fPFZ9MLuncCaizPbO861nltQNcThhc8JjuKBYebNQhcguvIwFJlRObcC8jyb3JsX4RYN93Yb/cXQ8mysBd1O/D7sIvVhQIMJLBL7MZEaDSEy2ERSyxgANh3kNZCKhUEieW9I2RcfgS6Y4jORKTCmkJghzvROpfwhAz+duQFvN6ha82OXXWJHdi+T5sQA3BzSPn4iU7yDPX69dzjnE/c5dcMgHJBpTvlsRzD7GQlKtdbeykwvn/7SfskmpltN7ym7aVdetees7jecBncZPZtCNjmwpKXKmr2ELg1BNXsr1zmlgfDJk6WkyDWYHtLzEPF/EWUC7/XUfCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB10318.jpnprd01.prod.outlook.com (2603:1096:400:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 05:33:26 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 05:33:26 +0000
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
CC: Li Zhijian via <qemu-devel@nongnu.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
Thread-Topic: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
Thread-Index: AQHbgdin9ucJjH+lxkGFy3eIGQ0wErNNjYMAgAAbGgCAAHNIAA==
Date: Wed, 19 Feb 2025 05:33:26 +0000
Message-ID: <ea265434-7842-4556-9a99-98ce42b6c1f1@fujitsu.com>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
 <20250218074345.638203-2-lizhijian@fujitsu.com> <87zfij7yob.fsf@suse.de>
 <Z7UMcIQ4QrcXqwK3@x1.local>
In-Reply-To: <Z7UMcIQ4QrcXqwK3@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB10318:EE_
x-ms-office365-filtering-correlation-id: 8acf38b6-b4b3-43c0-c2d4-08dd50a6ef32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WjlzVEdGMkQ0OUdFa1pNR1JxV3h0Q0tROXVUTWNDbzh5TEduVmV3VExjdXU0?=
 =?utf-8?B?bURzWXJNQlFGaEJOeUZpd3A1eGNUa054ak9hUnkvTHdFbFBxY2dUUVlhbVBQ?=
 =?utf-8?B?SDBmQ2ZEZitpeHhId1hqSjR3cFp5SjkzaHc1ZDJ1NFVqOTRYa1JTRmJPeHVG?=
 =?utf-8?B?SGg0ekM2K3U2Mmx1Tm9zUnV1ZzBTcGFiMlplUFJBdmQ4R2xaTFp3OVRmdkl6?=
 =?utf-8?B?bVNjcnRjMDUzR2NjNFNoWlprb3F5T2I5YVlUbTc4L0swODFtMVJ2UkhIaVly?=
 =?utf-8?B?VkpLbEl0NnJMdENlVmZnaHJNUzBTS0x1MVpmVzdhWnJ1cmxyd0k5MDJXY2Q3?=
 =?utf-8?B?alFnYnhJaDY5em40bWxvUUlNQUFWRG0rNEpkbFZiNGZnckdZTUpSN2VtQk92?=
 =?utf-8?B?NkZsWWUwazB5cVBrbHptbCt6QTEzQmZUajB2TFlFb1hrbkRWWS8wWEZKRlls?=
 =?utf-8?B?bWNkQkZCeTJQVjdiVURUNmh5WGlQSEMwaW85bWFsdEs2VzNTREpudWkvWkkv?=
 =?utf-8?B?VzdaS3h0bFMvejM1NlZldkNTV0tjVkZSd0tlalhnZ3duNC9nRFhYbnVKVVlS?=
 =?utf-8?B?UHl3cXhacDNxQ3FydGRDL3ZibEFoTmNWVUVSM3hqSjRJSG1VWU92Z0NQRXlh?=
 =?utf-8?B?VXFPT3ZqK1ZiQkVBSzhIbnpHSit4dkNTZHBXc3VFMUNOcFhNUURZdUt1TEdC?=
 =?utf-8?B?OE5vVXVUdGViTTZwZllnMU8xQ2d2aUUrMEw1SDYrMzRnL25pUGg1LzcxM3pY?=
 =?utf-8?B?eW51ZmtwWlFTdFY4OWNGUWpRYmcrZk8vTCtKemNrTHNha05IK0dlai83ckpl?=
 =?utf-8?B?WG5nMUwrTnpNRDNTazRBaUFhTlFWWVp2ZUZPL3JRM1BjTmZ5QTZRZUZoRFBp?=
 =?utf-8?B?YmY3RXZCTDE0WEJsTnlyN0trZ3NkY3lOZ0ZpTWdJVFRZajc3N0NuM25CaUdY?=
 =?utf-8?B?aCtOYmdFTTQ5NEcySUYydjJySG5MbVdzRnBZSEhBSlcvNnlpTlpEY0h5VXY2?=
 =?utf-8?B?TDV3eW83QU4zMVVyRElYdk9BMWJPNTlQOFB4S09wTW1JemJPMGprRlhSWXdY?=
 =?utf-8?B?WGFNQ0xhTUkxYXJiVFNadTBoVHNQWDloNFdHd0hiTXBjN1F0djlFRUVOTnZQ?=
 =?utf-8?B?cHdON25aVzF2UVFXOTh2REJuRHNUdlVNNDZMc2lXWHhlZDc0U2w3RzVoYW8w?=
 =?utf-8?B?dVhpVzliMXdDWEtLRUpMMWYveGpackc0STR1Mk50S0tVODlnTFlmcFpkR1FI?=
 =?utf-8?B?R1JuK1g3ZHBTdlpQM2x0eTNVcUtudGlnaWpJV3ZEUWIrdWtpVVQzZGtwK2sw?=
 =?utf-8?B?Y016RXZCL3kwVC9scDNLUDRMWE1mdGNhNExobkI4ZTFHRlZabVRNQVBYaFo4?=
 =?utf-8?B?bkQzMUc2OXAxNEZBLzlacTZzSFVRR25RWWpQaCs0cmxsd0F3L3BWWVZ0cDBJ?=
 =?utf-8?B?RVhTQTYrT3UyYmJGbncyWVdOTUk4a2FMSjNCR2V0RjBPQzZWTTUwV1VkeGJU?=
 =?utf-8?B?dlFTZzhrUkh0bmhvVUVIMWFMUVFHd29CVW80ajRkUDRmZ1R0M1YzemFicWx0?=
 =?utf-8?B?MHNITXlqMFZXWnhBTXpJdG80K1ZSSEc1a2NJMVJnYWtnZ3h4ZGMxK0E4aGFt?=
 =?utf-8?B?cGs4Smo4aHgxTStDQ2RxVjdmSDJWQ3orTFpiVjM5ZG1jTzdsZ2JCbjNtQlhR?=
 =?utf-8?B?RnJ6U3hTTmZTNWNtUFB6UHI2aVhUb2dWTXI4YTIxZ00rMmZyQTRwNW9LYjZM?=
 =?utf-8?B?ZW1FSW5vNWFOSGNJbkp2TTd3ejkvKzFqU3Y4bmhJV09qeHkrazAremdyQXZk?=
 =?utf-8?B?LytXd2NJZk1aSFp2RmFEVG8xazErOXFlK2NaSHZESi9Pd1RiUmpkd2hqTytj?=
 =?utf-8?B?Qnp0VVo4NGgrc2JzT2l5KyttSEZkTjMwM0c4TnphcGdoQ0NwZlBVT2h0NHNP?=
 =?utf-8?B?OWdseFNKaUcrVjVwMWhYcHZrTmZLTGJmVXFwd1V3aWxLV3oyZEFlSUllQW54?=
 =?utf-8?B?QXh3NGkzR0JnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDM3STJ1OHFuWkJvZjN4ODhmQWQ4U0pFdFZuVERoMlArZnNpTjVLRHNnVkpE?=
 =?utf-8?B?RDlVNFhpVGwxQnA3WFJITmMrTm5RQWhTb1REWnNuS0J4QmUrZlhpdTFGSUZK?=
 =?utf-8?B?S3dNR3BCclV5WXdoYUFTM0dmTFBSblBYaVBpb0ZsNGV0YW1KNjhRaUp5eENT?=
 =?utf-8?B?TGV3NnRzMjhybWcwRDcyTWNmUWRlUzZTSkJub3dob0w0cjZMbXIvSFRGWFd0?=
 =?utf-8?B?ME45NGFLdmtzN2M3d3IvbDhpT0hweWlkNE9qalROMFRNZDRpaG9mckRGUjBI?=
 =?utf-8?B?VEROR1N0cnZJdkJxMk50UVN5MXVTby8wT29xMnFZOFBiUnBsdW9MbE1hNG8r?=
 =?utf-8?B?NC9aR1Z4WmVpclNBQmlVVE1xRjFLamNCKzM3WTQ3elJKb0JHc3VVazA3aHg0?=
 =?utf-8?B?aWR3Vzl4Nk5rQk83RGh3UUFOeVlvR1dtWDg5enBEbm5KTDVrSDgwbyswcitZ?=
 =?utf-8?B?NEpkMDZWdHI4dDJpd3RGK0JGY3VIMTEvTkZWQWNFSFprTm5wMkxXQ1pNbkpa?=
 =?utf-8?B?NGZRSU5tRDhuSkljakZ3NG93SGRFZDJqakFtVUJzeWZRQWpjclZYTjZ3RFhL?=
 =?utf-8?B?aVM1WWhMd1Z0d3l2RVJuQURTa053V2VNUzJ5cEo4Q29mNjlkbGRpTzQydEx6?=
 =?utf-8?B?QVFRRW5jNUpKKzhIZDNKRGdxN2dUcWpKMUZ4SFAya09nYXdwbk1nbUJQT2Zx?=
 =?utf-8?B?N3FudUxkNUp3d3B0Z2RvRXk5QWwzWlVUVjJZcTRqdFJGSXZscDlPK3JtTy8x?=
 =?utf-8?B?NldzNmZFVC82eVlVTGJuYjUwbk9BYlZtYVhzT04vZG9xcTNrbjlheVkwSnlU?=
 =?utf-8?B?VGRkNUczamVRY0JzMWhhTG5Lb0liVjZCaVRsQnlZbndKMW4wTDlTeDIybzVn?=
 =?utf-8?B?cFplUzdZWENoM0Z6YWVtbEViZy9idFI1YUlsNEVyTng1MnQ5VG85TE5MVkNK?=
 =?utf-8?B?K09wVWxQNDhOWlhQa3hqK0NJakV5TEFrbVczOGVudnlCeXAwTEV2OVFiaGkr?=
 =?utf-8?B?emtNZEo4NFlkdCtaTWpQelVuNzM1SmdiZDZzWjJrbkp5RE1ORWg5djlHaG5G?=
 =?utf-8?B?a3hqVFQ2WkZVZjM4bzlETW5JbmVkQ1A5Mzl2WVFkOGhCdnR6TVhnZUxtVnMz?=
 =?utf-8?B?Ly9ocGRjOFBJV1JIT0NYM3RDL0ZTeW0veGpEeVh6eHFKZmFvSTc1OTRVZ2l4?=
 =?utf-8?B?R3pDQmNPR3doTGFQZHFJVE54b0NBVHlxZ0E1OGVDamNtTlp2b0VRWHFpTitq?=
 =?utf-8?B?cnd5Q1JjSDROLzZUQmlkVWhDcjV3dHFTN2k1eXZlU1g2am5QcSt5bENRLy9X?=
 =?utf-8?B?Rll5bWxzak82alJlY1BRUy9ZWkk4RVp5MC85Tk5seHJ6NWNTOVN6Vk1SNG5n?=
 =?utf-8?B?Nm1SZUJiSENVRTZDVEg0SkJoM1ZhZ2I0dzNsM0FVekU1RFcrY3N4TGFLUmsx?=
 =?utf-8?B?czdNbU1NbXkxeWVUNGhRZzN3V1NXYk9OaVNWSXpXL0dvNzlHNUdCMEZYVU9L?=
 =?utf-8?B?ZWhLbnhzRnNzRitXMUV1dFdyNy9Od3dEYlo2UTBsaGxWb3J4ZDlpenM5OUdL?=
 =?utf-8?B?WHUxSitMZ05VQkdwL0h5S2FMUWw5c0NaUy9uMGFYci9TRGtWdUJHWkNnaGE5?=
 =?utf-8?B?c3d4am03Z0pPcnFzT0d3UGd1VlJKbHlSTkd5VnhVUUNObFJwRzQ1NVorSFNr?=
 =?utf-8?B?QVVJN3dFREJKMW9VaUJvTFBUbFNZTGxxTTIzVGNjMzNtMUs0N0g2VVY4bXJv?=
 =?utf-8?B?MzJ6c0pHMnBTWXBYRVNrTHRjYklxMGdhODFIeWlGbjJOazVCU1l4alVIZkZB?=
 =?utf-8?B?QjNVVE9sMFRUSE5DKzVkYitaODNDaW9xMFFIblpQOERtdGJQcUduaForSkRw?=
 =?utf-8?B?dkdrdWttZnJkUGl1K0RSZXFDbEY2dzB1NXVxTGg1U0M0ZDRSN2hMK2trMkJj?=
 =?utf-8?B?MmNEK1hva0sxVGVqZjNMaHlRaUtQc1lJRUh5TGFaOTMzNHV6b0FqUjR4TlJw?=
 =?utf-8?B?ZWpLd0U0b0t3Uk5xZXpYY043RjFHRis2RzB4NExNRS9DMzRvUXYrelhkK3p5?=
 =?utf-8?B?T1JUaDFKZDNhU1JMd296dnhYbFB3SXlRYlU0VmxaUUJSU3pvZWFwV2FuME4x?=
 =?utf-8?B?SVllT1pPODhMd3ZOK3hPSFNQdGQxbUdlUldkZDZHWjFqQWJvaGlLTTRmSjJl?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E270B2D5E0A9BA4BBF85FDE4C2E1FBDB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mHDXQHAxGz6yifOZGXcrcIctjjDCL7ctKWPJ540Ca6Cz6dso6zOc71DgswlnNLX/P0D75hEg5EBJCzDc7ueB50qt3DEJ9BWKdVlKvOpWSovhEZvqcBy2xFZlJ8P0f40PlDYRDT9cOqvlW0+YGCQAj5w26IZkaHh9PkNvfE228mzlR/uYXSx1GREBrW6JSORlMLopOsXvN/3+dSR8VNJR/D4IVCO8In9+4GejgvNVV7cEM7/b+GvraQ5mlvbtE2XZKokT9yvMIe9DbIERKx43nmrQHoBCs5DndB3R5xk3WWAUCKlQbO8WhmuLpCIfzBTi72EOCREYj1xg7NXA1r+giGVbwImUsiQ6kmUYys4XQJE8nDdmJ11Tdkp0VP0sVrnx+Y9VUH/lSUczFio5QtkGVLNPLBxrwCXvjjX/+BzEWBYAMKWfxKmwwskbl388ARNVOV6Js45WABKPSGmkqwDDMWpz8G1UCbAlSw6UJute6F5+mUGtPPaJTNuwrWoXb22j/i6hSlDuyYATzIECz15VgCmebKuw5pM0dWT1zA6ItO52yTRn6d/nhL/lSM91OK/CP0AzyYNI8QqWnNtYYujZkBu0zZvtykzXr6Qpd18kL431jETHYwrVzf447yOTakbb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acf38b6-b4b3-43c0-c2d4-08dd50a6ef32
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 05:33:26.4248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TATWEkV2tz868Uw4vIOc1pFAC5Tlr+KBVvZwNd2irFydSWisCbtJUwGClXK0Uw+GuvddT09MRufXwbmDFIgyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10318
Received-SPF: pass client-ip=68.232.152.246;
 envelope-from=lizhijian@fujitsu.com; helo=esa2.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQoNCk9uIDE5LzAyLzIwMjUgMDY6NDAsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBUdWUsIEZlYiAx
OCwgMjAyNSBhdCAwNjowMzo0OFBNIC0wMzAwLCBGYWJpYW5vIFJvc2FzIHdyb3RlOg0KPj4gTGkg
WmhpamlhbiB2aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4gd3JpdGVzOg0KPj4NCj4+PiBUaGlz
IHF0ZXN0IHJlcXVpcnMgdGhlcmUgaXMgUlhFIGxpbmsgaW4gdGhlIGhvc3QuDQo+Pj4NCj4+PiBI
ZXJlIGlzIGFuIGV4YW1wbGUgdG8gc2hvdyBob3cgdG8gYWRkIHRoaXMgUlhFIGxpbms6DQo+Pj4g
JCAuL25ldy1yZG1hLWxpbmsuc2gNCj4+PiAxOTIuMTY4LjIyLjkzDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+Pj4gLS0tDQo+Pj4g
VGhlIFJETUEgbWlncmF0aW9uIHdhcyBicm9rZW4gYWdhaW4uLi5kdWUgdG8gbGFjayBvZiBzdWZm
aWNpZW50IHRlc3QvcXRlc3QuDQo+Pj4NCj4+PiBJdCdzIHVyZ2x5IHRvIGFkZCBhbmQgZXhlY3V0
ZSBhIHNjcmlwdCB0byBlc3RhYmxpc2ggYW4gUkRNQSBsaW5rIGluDQo+Pj4gdGhlIEMgcHJvZ3Jh
bS4gSWYgYW55b25lIGhhcyBhIGJldHRlciBzdWdnZXN0aW9uLCBwbGVhc2UgbGV0IG1lIGtub3cu
DQo+Pj4NCj4+PiAkIGNhdCAuL25ldy1yZG1hLWxpbmsuc2gNCj4+PiBnZXRfaXB2NF9hZGRyKCkg
ew0KPj4+ICAgICAgICAgIGlwIC00IC1vIGFkZHIgc2hvdyBkZXYgIiQxIiB8DQo+Pj4gICAgICAg
ICAgICAgICAgICBzZWQgLW4gJ3MvLipbWzpibGFuazpdXWluZXRbWzpibGFuazpdXSpcKFteWzpi
bGFuazpdL10qXCkuKi9cMS9wJw0KPj4+IH0NCj4+Pg0KPj4+IGhhc19zb2Z0X3JkbWEoKSB7DQo+
Pj4gICAgICAgICAgcmRtYSBsaW5rIHwgZ3JlcCAtcSAiIG5ldGRldiAkMVtbOmJsYW5rOl1dKlwk
Ig0KPj4+IH0NCj4+Pg0KPj4+IHN0YXJ0X3NvZnRfcmRtYSgpIHsNCj4+PiAgICAgICAgICBsb2Nh
bCB0eXBlDQo+Pj4NCj4+PiAgICAgICAgICBtb2Rwcm9iZSByZG1hX3J4ZSB8fCByZXR1cm4gJD8N
Cj4+PiAgICAgICAgICB0eXBlPXJ4ZQ0KPj4+ICAgICAgICAgICgNCj4+PiAgICAgICAgICAgICAg
ICAgIGNkIC9zeXMvY2xhc3MvbmV0ICYmDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIGZv
ciBpIGluICo7IGRvDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWyAtZSAi
JGkiIF0gfHwgY29udGludWUNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBb
ICIkaSIgPSAibG8iIF0gJiYgY29udGludWUNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBbICIkKDwiJGkvYWRkcl9sZW4iKSIgPSA2IF0gfHwgY29udGludWUNCj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbICIkKDwiJGkvY2FycmllciIpIiA9IDEgXSB8
fCBjb250aW51ZQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhhc19zb2Z0
X3JkbWEgIiRpIiAmJiBicmVhaw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJkbWEgbGluayBhZGQgIiR7aX1fJHR5cGUiIHR5cGUgJHR5cGUgbmV0ZGV2ICIkaSIgJiYgYnJl
YWsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgZG9uZQ0KPj4+ICAgICAgICAgICAgICAg
ICAgaGFzX3NvZnRfcmRtYSAiJGkiICYmIGVjaG8gJGkNCj4+PiAgICAgICAgICApDQo+Pj4NCj4+
PiB9DQo+Pj4NCj4+PiByeGVfbGluaz0kKHN0YXJ0X3NvZnRfcmRtYSkNCj4+PiBbWyAiJHJ4ZV9s
aW5rIiBdXSAmJiBnZXRfaXB2NF9hZGRyICRyeGVfbGluaw0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+ICAgdGVz
dHMvcXRlc3QvbWlncmF0aW9uL25ldy1yZG1hLWxpbmsuc2ggfCAgMzQgKysrKysrKysNCj4+PiAg
IHRlc3RzL3F0ZXN0L21pZ3JhdGlvbi9wcmVjb3B5LXRlc3RzLmMgIHwgMTAzICsrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTM3IGluc2VydGlvbnMoKykN
Cj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9taWdyYXRpb24vbmV3LXJkbWEt
bGluay5zaA0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi9uZXct
cmRtYS1saW5rLnNoIGIvdGVzdHMvcXRlc3QvbWlncmF0aW9uL25ldy1yZG1hLWxpbmsuc2gNCj4+
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4IDAwMDAwMDAwMDAwLi5jYTIwNTk0ZWFh
ZQ0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi90ZXN0cy9xdGVzdC9taWdyYXRpb24vbmV3
LXJkbWEtbGluay5zaA0KPj4+IEBAIC0wLDAgKzEsMzQgQEANCj4+PiArIyEvYmluL2Jhc2gNCj4+
PiArDQo+Pj4gKyMgQ29waWVkIGZyb20gYmxrdGVzdHMNCj4+PiArZ2V0X2lwdjRfYWRkcigpIHsN
Cj4+PiArCWlwIC00IC1vIGFkZHIgc2hvdyBkZXYgIiQxIiB8DQo+Pj4gKwkJc2VkIC1uICdzLy4q
W1s6Ymxhbms6XV1pbmV0W1s6Ymxhbms6XV0qXChbXls6Ymxhbms6XS9dKlwpLiovXDEvcCcNCj4+
PiArfQ0KPj4+ICsNCj4+PiAraGFzX3NvZnRfcmRtYSgpIHsNCj4+PiArCXJkbWEgbGluayB8IGdy
ZXAgLXEgIiBuZXRkZXYgJDFbWzpibGFuazpdXSpcJCINCj4+PiArfQ0KPj4+ICsNCj4+PiArc3Rh
cnRfc29mdF9yZG1hKCkgew0KPj4+ICsJbG9jYWwgdHlwZQ0KPj4+ICsNCj4+PiArCW1vZHByb2Jl
IHJkbWFfcnhlIHx8IHJldHVybiAkPw0KPj4+ICsJdHlwZT1yeGUNCj4+PiArCSgNCj4+PiArCQlj
ZCAvc3lzL2NsYXNzL25ldCAmJg0KPj4+ICsJCQlmb3IgaSBpbiAqOyBkbw0KPj4+ICsJCQkJWyAt
ZSAiJGkiIF0gfHwgY29udGludWUNCj4+PiArCQkJCVsgIiRpIiA9ICJsbyIgXSAmJiBjb250aW51
ZQ0KPj4+ICsJCQkJWyAiJCg8IiRpL2FkZHJfbGVuIikiID0gNiBdIHx8IGNvbnRpbnVlDQo+Pj4g
KwkJCQlbICIkKDwiJGkvY2FycmllciIpIiA9IDEgXSB8fCBjb250aW51ZQ0KPj4+ICsJCQkJaGFz
X3NvZnRfcmRtYSAiJGkiICYmIGJyZWFrDQo+Pj4gKwkJCQlyZG1hIGxpbmsgYWRkICIke2l9XyR0
eXBlIiB0eXBlICR0eXBlIG5ldGRldiAiJGkiICYmIGJyZWFrDQo+Pj4gKwkJCWRvbmUNCj4+PiAr
CQloYXNfc29mdF9yZG1hICIkaSIgJiYgZWNobyAkaQ0KPj4+ICsJKQ0KPj4+ICsNCj4+PiArfQ0K
Pj4+ICsNCj4+PiArcnhlX2xpbms9JChzdGFydF9zb2Z0X3JkbWEpDQo+Pj4gK1tbICIkcnhlX2xp
bmsiIF1dICYmIGdldF9pcHY0X2FkZHIgJHJ4ZV9saW5rDQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3Rz
L3F0ZXN0L21pZ3JhdGlvbi9wcmVjb3B5LXRlc3RzLmMgYi90ZXN0cy9xdGVzdC9taWdyYXRpb24v
cHJlY29weS10ZXN0cy5jDQo+Pj4gaW5kZXggMTYyZmE2OTUzMTguLmQyYTFjOWM5NDM4IDEwMDY0
NA0KPj4+IC0tLSBhL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi9wcmVjb3B5LXRlc3RzLmMNCj4+PiAr
KysgYi90ZXN0cy9xdGVzdC9taWdyYXRpb24vcHJlY29weS10ZXN0cy5jDQo+Pj4gQEAgLTk4LDYg
Kzk4LDEwNSBAQCBzdGF0aWMgdm9pZCB0ZXN0X3ByZWNvcHlfdW5peF9kaXJ0eV9yaW5nKHZvaWQp
DQo+Pj4gICAgICAgdGVzdF9wcmVjb3B5X2NvbW1vbigmYXJncyk7DQo+Pj4gICB9DQo+Pj4gICAN
Cj4+PiArc3RhdGljIGludCBuZXdfcmRtYV9saW5rKGNoYXIgKmJ1ZmZlcikgew0KPj4+ICsgICAg
Ly8gQ29waWVkIGZyb20gYmxrdGVzdHMNCj4+PiArICAgIGNvbnN0IGNoYXIgKnNjcmlwdCA9DQo+
Pj4gKyAgICAgICAgIiMhL2Jpbi9iYXNoXG4iDQo+Pj4gKyAgICAgICAgIlxuIg0KPj4+ICsgICAg
ICAgICJnZXRfaXB2NF9hZGRyKCkge1xuIg0KPj4+ICsgICAgICAgICIgICAgaXAgLTQgLW8gYWRk
ciBzaG93IGRldiBcIiQxXCIgfFxuIg0KPj4+ICsgICAgICAgICIgICAgc2VkIC1uICdzLy4qW1s6
Ymxhbms6XV1pbmV0W1s6Ymxhbms6XV0qXFwoW15bOmJsYW5rOl0vXSpcXCkuKi9cXDEvcCdcbiIN
Cj4+PiArICAgICAgICAifVxuIg0KPj4+ICsgICAgICAgICJcbiINCj4+PiArICAgICAgICAiaGFz
X3NvZnRfcmRtYSgpIHtcbiINCj4+PiArICAgICAgICAiICAgIHJkbWEgbGluayB8IGdyZXAgLXEg
XCIgbmV0ZGV2ICQxW1s6Ymxhbms6XV0qXFwkXCJcbiINCj4+PiArICAgICAgICAifVxuIg0KPj4+
ICsgICAgICAgICJcbiINCj4+PiArICAgICAgICAic3RhcnRfc29mdF9yZG1hKCkge1xuIg0KPj4+
ICsgICAgICAgICIgICAgbG9jYWwgdHlwZVxuIg0KPj4+ICsgICAgICAgICJcbiINCj4+PiArICAg
ICAgICAiICAgIG1vZHByb2JlIHJkbWFfcnhlIHx8IHJldHVybiAkP1xuIg0KPj4+ICsgICAgICAg
ICIgICAgdHlwZT1yeGVcbiINCj4+PiArICAgICAgICAiICAgIChcbiINCj4+PiArICAgICAgICAi
ICAgICAgICBjZCAvc3lzL2NsYXNzL25ldCAmJlxuIg0KPj4+ICsgICAgICAgICIgICAgICAgIGZv
ciBpIGluICo7IGRvXG4iDQo+Pj4gKyAgICAgICAgIiAgICAgICAgICAgIFsgLWUgXCIkaVwiIF0g
fHwgY29udGludWVcbiINCj4+PiArICAgICAgICAiICAgICAgICAgICAgWyBcIiRpXCIgPSBcImxv
XCIgXSAmJiBjb250aW51ZVxuIg0KPj4+ICsgICAgICAgICIgICAgICAgICAgICBbIFwiJCg8JGkv
YWRkcl9sZW4pXCIgPSA2IF0gfHwgY29udGludWVcbiINCj4+PiArICAgICAgICAiICAgICAgICAg
ICAgWyBcIiQoPCRpL2NhcnJpZXIpXCIgPSAxIF0gfHwgY29udGludWVcbiINCj4+PiArICAgICAg
ICAiICAgICAgICAgICAgaGFzX3NvZnRfcmRtYSBcIiRpXCIgJiYgYnJlYWtcbiINCj4+PiArICAg
ICAgICAiICAgICAgICAgICAgcmRtYSBsaW5rIGFkZCBcIiR7aX1fJHR5cGVcIiB0eXBlICR0eXBl
IG5ldGRldiBcIiRpXCIgJiYgYnJlYWtcbiINCj4+PiArICAgICAgICAiICAgICAgICBkb25lXG4i
DQo+Pj4gKyAgICAgICAgIiAgICAgICAgaGFzX3NvZnRfcmRtYSBcIiRpXCIgJiYgZWNobyAkaVxu
Ig0KPj4+ICsgICAgICAgICIgICAgKVxuIg0KPj4+ICsgICAgICAgICJ9XG4iDQo+Pj4gKyAgICAg
ICAgIlxuIg0KPj4+ICsgICAgICAgICJyeGVfbGluaz0kKHN0YXJ0X3NvZnRfcmRtYSlcbiINCj4+
PiArICAgICAgICAiW1sgXCIkcnhlX2xpbmtcIiBdXSAmJiBnZXRfaXB2NF9hZGRyICRyeGVfbGlu
a1xuIjsNCj4+PiArDQo+Pj4gKyAgICBjaGFyIHNjcmlwdF9maWxlbmFtZVtdID0gIi90bXAvdGVt
cF9zY3JpcHRYWFhYWFgiOw0KPj4+ICsgICAgaW50IGZkID0gbWtzdGVtcChzY3JpcHRfZmlsZW5h
bWUpOw0KPj4+ICsgICAgaWYgKGZkID09IC0xKSB7DQo+Pj4gKyAgICAgICAgcGVycm9yKCJGYWls
ZWQgdG8gY3JlYXRlIHRlbXBvcmFyeSBmaWxlIik7DQo+Pj4gKyAgICAgICAgcmV0dXJuIDE7DQo+
Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICsgICAgRklMRSAqZnAgPSBmZG9wZW4oZmQsICJ3Iik7DQo+
Pj4gKyAgICBpZiAoZnAgPT0gTlVMTCkgew0KPj4+ICsgICAgICAgIHBlcnJvcigiRmFpbGVkIHRv
IG9wZW4gZmlsZSBzdHJlYW0iKTsNCj4+PiArICAgICAgICBjbG9zZShmZCk7DQo+Pj4gKyAgICAg
ICAgcmV0dXJuIDE7DQo+Pj4gKyAgICB9DQo+Pj4gKyAgICBmcHJpbnRmKGZwLCAiJXMiLCBzY3Jp
cHQpOw0KPj4+ICsgICAgZmNsb3NlKGZwKTsNCj4+PiArDQo+Pj4gKyAgICBpZiAoY2htb2Qoc2Ny
aXB0X2ZpbGVuYW1lLCAwNzAwKSA9PSAtMSkgew0KPj4+ICsgICAgICAgIHBlcnJvcigiRmFpbGVk
IHRvIHNldCBleGVjdXRlIHBlcm1pc3Npb24iKTsNCj4+PiArICAgICAgICByZXR1cm4gMTsNCj4+
PiArICAgIH0NCj4+PiArDQo+Pj4gKyAgICBGSUxFICpwaXBlID0gcG9wZW4oc2NyaXB0X2ZpbGVu
YW1lLCAiciIpOw0KPj4+ICsgICAgaWYgKHBpcGUgPT0gTlVMTCkgew0KPj4+ICsgICAgICAgIHBl
cnJvcigiRmFpbGVkIHRvIHJ1biBzY3JpcHQiKTsNCj4+PiArICAgICAgICByZXR1cm4gMTsNCj4+
PiArICAgIH0NCj4+PiArDQo+Pj4gKyAgICBpbnQgaWR4ID0gMDsNCj4+PiArICAgIHdoaWxlIChm
Z2V0cyhidWZmZXIgKyBpZHgsIDEyOCAtIGlkeCwgcGlwZSkgIT0gTlVMTCkgew0KPj4+ICsgICAg
ICAgIGlkeCArPSBzdHJsZW4oYnVmZmVyKTsNCj4+PiArICAgIH0NCj4+PiArICAgIGlmIChidWZm
ZXJbaWR4IC0gMV0gPT0gJ1xuJykNCj4+PiArICAgICAgICBidWZmZXJbaWR4IC0gMV0gPSAwOw0K
Pj4+ICsNCj4+PiArICAgIGludCBzdGF0dXMgPSBwY2xvc2UocGlwZSk7DQo+Pj4gKyAgICBpZiAo
c3RhdHVzID09IC0xKSB7DQo+Pj4gKyAgICAgICAgcGVycm9yKCJFcnJvciByZXBvcnRlZCBieSBw
Y2xvc2UoKSIpOw0KPj4+ICsgICAgfSBlbHNlIGlmICghV0lGRVhJVEVEKHN0YXR1cykpIHsNCj4+
PiArICAgICAgICBwcmludGYoIlNjcmlwdCBkaWQgbm90IHRlcm1pbmF0ZSBub3JtYWxseVxuIik7
DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICsgICAgcmVtb3ZlKHNjcmlwdF9maWxlbmFtZSk7DQo+
IA0KPiBUaGUgc2NyaXB0IGNhbiBiZSBwdXQgc2VwYXJhdGVseSBpbnN0ZWFkIGlmIGhhcmQtY29k
ZWQgaGVyZSwgcmlnaHQ/DQoNCg0KU3VyZSwgSWYgc28sIEkgd29uZGVyIHdoZXRoZXIgdGhlIG1p
Z3JhdGlvbi10ZXN0IHByb2dyYW0gaXMgYWJsZSB0byBrbm93IHdoZXJlIGlzIHRoaXMgc2NyaXB0
Pw0KDQoNCj4gDQo+Pj4gKw0KPj4+ICsgICAgcmV0dXJuIDA7DQo+Pj4gK30NCj4+PiArDQo+Pj4g
K3N0YXRpYyB2b2lkIHRlc3RfcHJlY29weV9yZG1hX3BsYWluKHZvaWQpDQo+Pj4gK3sNCj4+PiAr
ICAgIGNoYXIgYnVmZmVyWzEyOF0gPSB7fTsNCj4+PiArDQo+Pj4gKyAgICBpZiAobmV3X3JkbWFf
bGluayhidWZmZXIpKQ0KPj4+ICsgICAgICAgIHJldHVybjsNCj4+PiArDQo+Pj4gKyAgICBnX2F1
dG9mcmVlIGNoYXIgKnVyaSA9IGdfc3RyZHVwX3ByaW50ZigicmRtYTolczo3Nzc3IiwgYnVmZmVy
KTsNCj4+PiArDQo+Pj4gKyAgICBNaWdyYXRlQ29tbW9uIGFyZ3MgPSB7DQo+Pj4gKyAgICAgICAg
Lmxpc3Rlbl91cmkgPSB1cmksDQo+Pj4gKyAgICAgICAgLmNvbm5lY3RfdXJpID0gdXJpLA0KPj4+
ICsgICAgfTsNCj4+PiArDQo+Pj4gKyAgICB0ZXN0X3ByZWNvcHlfY29tbW9uKCZhcmdzKTsNCj4+
PiArfQ0KPj4+ICsNCj4+PiAgIHN0YXRpYyB2b2lkIHRlc3RfcHJlY29weV90Y3BfcGxhaW4odm9p
ZCkNCj4+PiAgIHsNCj4+PiAgICAgICBNaWdyYXRlQ29tbW9uIGFyZ3MgPSB7DQo+Pj4gQEAgLTk2
OCw2ICsxMDY3LDEwIEBAIHN0YXRpYyB2b2lkIG1pZ3JhdGlvbl90ZXN0X2FkZF9wcmVjb3B5X3Nt
b2tlKE1pZ3JhdGlvblRlc3RFbnYgKmVudikNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
dGVzdF9tdWx0aWZkX3RjcF91cmlfbm9uZSk7DQo+Pj4gICAgICAgbWlncmF0aW9uX3Rlc3RfYWRk
KCIvbWlncmF0aW9uL211bHRpZmQvdGNwL3BsYWluL2NhbmNlbCIsDQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIHRlc3RfbXVsdGlmZF90Y3BfY2FuY2VsKTsNCj4+PiArI2lmZGVmIENPTkZJ
R19SRE1BDQo+Pj4gKyAgICBtaWdyYXRpb25fdGVzdF9hZGQoIi9taWdyYXRpb24vcHJlY29weS9y
ZG1hL3BsYWluIiwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICB0ZXN0X3ByZWNvcHlfcmRt
YV9wbGFpbik7DQo+Pj4gKyNlbmRpZg0KPj4+ICAgfQ0KPj4+ICAgDQo+Pj4gICB2b2lkIG1pZ3Jh
dGlvbl90ZXN0X2FkZF9wcmVjb3B5KE1pZ3JhdGlvblRlc3RFbnYgKmVudikNCj4+DQo+PiBUaGFu
a3MsIHRoYXQncyBkZWZpbml0ZWx5IGJldHRlciB0aGFuIG5vdGhpbmcuIEknbGwgZXhwZXJpbWVu
dCB3aXRoIHRoaXMNCj4+IGxvY2FsbHksIHNlZSBpZiBJIGNhbiBhdCBsZWFzdCBydW4gaXQgYmVm
b3JlIHNlbmRpbmcgYSBwdWxsIHJlcXVlc3QuDQo+IA0KPiBXaXRoIHlvdXIgbmV3bHkgYWRkZWQg
LS1mdWxsLCBJSVVDIHdlIGNhbiBhZGQgd2hhdGV2ZXIgd2Ugd2FudCB0aGVyZS4NCj4gRS5nLiB3
ZSBjYW4gYWRkIC0tcmRtYSBhbmQgaWZmIHNwZWNpZmllZCwgbWlncmF0aW9uLXRlc3QgYWRkcyB0
aGUgcmRtYSB0ZXN0Lg0KPiANCj4gT3IuLiBza2lwIHRoZSB0ZXN0IHdoZW4gdGhlIHJkbWEgbGlu
ayBpc24ndCBhdmFpbGFibGUuDQo+IA0KPiBJZiB3ZSBjb3VsZCBzZXBhcmF0ZSB0aGUgc2NyaXB0
IGludG8gYSBmaWxlLCBpdCdsbCBiZSBiZXR0ZXIuICBXZSBjb3VsZA0KPiBjcmVhdGUgc2NyaXB0
cy9taWdyYXRpb24gZGlyIGFuZCBwdXQgYWxsIG1pZ3JhdGlvbiBzY3JpcHRzIG92ZXIgdGhlcmUs
DQoNCldlIGhhdmUgYW55IG90aGVyIGV4aXN0aW5nIHNjcmlwdD8gSSBkaWRuJ3QgZmluZCBpdCBp
biBjdXJyZW50IFFFTVUgdHJlZS4NCg0KDQo+IHRoZW4NCj4gaW4gdGhlIHRlc3QgaXQgdHJpZXMg
dG8gZGV0ZWN0IHJkbWEgbGluayBhbmQgZmV0Y2ggdGhlIGlwIG9ubHkNCg0KSXQgc2hvdWxkIHdv
cmsgd2l0aG91dCByb290IHBlcm1pc3Npb24gaWYgd2UganVzdCAqZGV0ZWN0KiBhbmQgKmZldGNo
IGlwKi4NCg0KRG8geW91IGFsc28gbWVhbiB3ZSBjYW4gc3BsaXQgbmV3LXJkbWEtbGluay5zaCB0
byAyIHNlcGFyYXRlIHNjcmlwdHMNCi0gYWRkLXJkbWEtbGluay5zaCAjIG9wdGlvbmFsbHksIGV4
ZWN1dGUgYnkgdXNlciBiZWZvcmUgdGhlIHRlc3QgKHJlcXVpcmUgcm9vdCBwZXJtaXNzaW9uKQ0K
LSBkZXRlY3QtZmV0Y2gtcmRtYS5zaCAjIGV4ZWN1dGUgZnJvbSB0aGUgbWlncmF0aW9uLXRlc3QN
Cg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiAoYWthLCB3ZSdkDQo+IGJldHRlciBrZWVwIHRoZSB0
ZXN0IGl0c2VsZiBub3QgcmVseSBvbiByb290IHBlcm1pc3Npb24uLikuDQo+IA==

