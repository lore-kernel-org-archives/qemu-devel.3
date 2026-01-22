Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C30C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 12:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vitiz-0003hm-Le; Thu, 22 Jan 2026 07:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1vitiu-0003g9-Hk; Thu, 22 Jan 2026 07:23:41 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1vitir-000863-LV; Thu, 22 Jan 2026 07:23:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlxWUY2MbyB846IpKb/6qUFvF7lkDLeTzaO+lpoq2Oxqq67OeTbpd57WYjai9tBW4J2EzX9gt/LTR1tnPSfDf7ZzWP0FrJAGXHBZZ/KPYsM7K2EyDdAWSCEpV585zccgl2fbdvwJoOjv5uv4ee2Bz55LQnKU3eU8tn1mCA/4rzAA3K8ilDksfjnDRMNZaVZWXmP8j49Gd9gwHWMChiVy1R9upRjTvk1L5CopE2Qh4RzghDHHIDOSQ51kdsvIQ8c1PFnBR3qNqloRvKkWh0ttiPvi2LEkIbwEPTXpMGmfXR0tuj4MIu5+U4KtzT2FyGVOX1/3ZB8KcAnmQjy+qpL6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCH13PiA039xDW8mM351GwNjJMV85uTm8ruXU3C1Lpg=;
 b=ohpDBVV23HiHaP05OT3oNbwq0QwD9xUUkS0J6Xb5mmjzmRD+yoXzn4lND4gfNKJDVepV6KHj1T9KEYKgpnG90rgkeiUFZY7gaFP4l3VwvBOGMCeBrvD6EbR8Ppw9jehdfEdK6ozE3myEJOnww6HunuPmdaVMaMJ6H4vanATIecVKGAmwsJIc+oOQHC9LkKoDF3ZPh3AnPpIZx0AUwDw754NITz6WCpNstPxFGNfBN2uyg9ZlBBwCkt7eoHtv1YgCScSxOaw2Szzj9VjCMXCl6h/X1cQh66k7QBJNb8/jR5tZg2h92+hQyoF6di1+g+y/TXkaaG2G4CaodNSz2jhn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCH13PiA039xDW8mM351GwNjJMV85uTm8ruXU3C1Lpg=;
 b=L36VmSMBE3osyONqb8DOWdJ6rkZ5W89InKuzs93R47CwueegtVbK6YxKNYfDmIE0vsjNi+PQbSs1lJHh2jln9j/du2GVDPXnQXakeA7dG7ITfbkzuUfPbHYadMa0M+q5SlnLM0VZjeQSXbF3fRnrwfbbaSAFJoLM+T0ezhGCABrvNfl6Sort8KzZ9dUsyFbBwUx0Fe1220DwSn984KRISRGK2yARRc692ei2UOdPCiGndWLeX6POe8qq24f8m4wD0YQdX/72Lv3dVwsd08cWLWoaLtQfc7s3uJQaWQ3w2bnsID5mw+CfirHooD6mtUtg2N9+4zy19Z6X+ufcZogtsQ==
Received: from DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 by AS4PR08MB7807.eurprd08.prod.outlook.com (2603:10a6:20b:51a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:23:30 +0000
Received: from DBBPR08MB10697.eurprd08.prod.outlook.com
 ([fe80::2318:7df7:a744:15d2]) by DBBPR08MB10697.eurprd08.prod.outlook.com
 ([fe80::2318:7df7:a744:15d2%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:23:30 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: "jean-louis@dupond.be" <jean-louis@dupond.be>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
CC: "hreitz@redhat.com" <hreitz@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "vsementsov@yandex-team.ru" <vsementsov@yandex-team.ru>, "eblake@redhat.com"
 <eblake@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Den Lunev
 <den@virtuozzo.com>, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH] block/qcow2-bitmap: remove inconsistent bitmaps when
 loading
Thread-Topic: [PATCH] block/qcow2-bitmap: remove inconsistent bitmaps when
 loading
Thread-Index: AQHcijEBVEmfG+2NzEK88XM4OUkPjrVcrlsAgAFxF4A=
Date: Thu, 22 Jan 2026 12:23:30 +0000
Message-ID: <216bf3a35b02efe521d58e7cf4f22ba44ea22cb5.camel@virtuozzo.com>
References: <20260120171226.1042260-1-polina.vishneva@virtuozzo.com>
 <c2f9fc69-034b-4dc3-a92f-d43e13a5dfed@dupond.be>
In-Reply-To: <c2f9fc69-034b-4dc3-a92f-d43e13a5dfed@dupond.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR08MB10697:EE_|AS4PR08MB7807:EE_
x-ms-office365-filtering-correlation-id: 841bb739-5dce-455b-695c-08de59b10d6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VU5TOER1TlF5SkhVZ29CcGRYSlBIMm5vbW91azJ5WXdtY1BxTU1PUDRoU0NL?=
 =?utf-8?B?TnhrNC9vbUV4NTFCcVJoRHlPVm81ODNqZVFlSzJjQitxWlA2Wk9DRkVZRFpK?=
 =?utf-8?B?TjFrNHUzdE9EMFNLUXgyQm5VSkIyV3FtMTRMMjhEbFAwVWNQWFdRT1RqWUhj?=
 =?utf-8?B?V0R3aDZON1ZlODRKZVl5bTdEQW50S1JMdXpXTlZFYmticy9EclZrRk9OdXo1?=
 =?utf-8?B?S2hlTURHVWZCblFzdmRzeDkyRGJneDNqZG1UM3JSQ3NpMy9UV094WEJyd3Vs?=
 =?utf-8?B?UzVrTGlIM0VzZG1nT2JBcFBUTHVZSDZKN2p6SGxQaE1RWkp6MDlzQ0hmbUov?=
 =?utf-8?B?Y1prUVFKNDBubkVZeGhGbmNta2NMUHFqQmRuekhDV1VaWEdpd1RUOVZYZkxJ?=
 =?utf-8?B?THlWd2dqNVM4NGdCcyt0eXNzMGNPVkFsZDdtMXlSUGVNWjM3bkZYUmdxYXJN?=
 =?utf-8?B?RkVFUnF5c0pnVXY1ZEFhckhTa0FHaDlYZjhIUGtSZnRCMzBqaEJNdVNidHlH?=
 =?utf-8?B?RW5iTEFyOGJmWGZXZ2Q5b0JDN2ZKRHdhRVZ6R0l0RGlkc0t1QUs5YjNMcFRX?=
 =?utf-8?B?dEFPenJXS2Z5NEsxdUxBYlR4THZMUitJTzZ0QzF2akZZYkxpdTVoOTN2MW5S?=
 =?utf-8?B?RlBmaGx3TFpPWjFuNmdZTHUzVXdyaG5qQUtyNmYvRWhHZldoaGpuaVVRWlVS?=
 =?utf-8?B?R0lCQ2M3ZmpTWjdKMDVmSFRiVFpLbDIrTm1QWWlacSs1RVBFNVl3NUduQVdt?=
 =?utf-8?B?L3hCZDhIcVl4SGFGZFVEVHBaSUVPYlZDdVl0cG9OelpLT093TXRhL1ZtM202?=
 =?utf-8?B?Rkg0eW1XQ0lqSGxVc2pheWVaLzBsRXExcXIySFlUekQwYW8xRHJGSUlTOGN5?=
 =?utf-8?B?QjVod2tlN3N6ejZ0WGUza1FaaTZBcTFWMnJMYXZJUy84RTluTTZxUjVWVTFC?=
 =?utf-8?B?QnF6VFFSYjBEUkJ0Rm5qM1BtVlAySC9TbWhmeVdVMzhWREJKVUwwUGZXSzJn?=
 =?utf-8?B?UW02SHBjRXVRSTNDa1lsZTBxZEg4N01pblVYYXdaQmk0ZU1aRFMvdmlXQ3Ju?=
 =?utf-8?B?Nlh4QWNMYkMyQmo2eGczeVFPbExkWEhBVVRvU3hCNmJOaE5DMXBENzFYYU5V?=
 =?utf-8?B?R1NJbkNsa01xVGx2akJnRlZ5MzA1MU1LQ2c4MWJyZmUxT2tQbWdoNkdwZGl4?=
 =?utf-8?B?WTk5WHROc2VmNlpNYUJ0bDUyNkV2c09Pc3crVFl1QUlBSyttbVRiUWlTbitZ?=
 =?utf-8?B?L2ZZRkRZOUVjZzVZZ3ROcVVIaTRaamJhbWNjNEFNSFloM1A2VW5lZXgzTjNq?=
 =?utf-8?B?VzEzMGVrSXVxYTFZMWt3d0VwOHhGOEQ5eEtMTzdGV0xDWUFtbXZJVXB1dmRB?=
 =?utf-8?B?b1cvN3FHN29ibHYxa3YySjU1cXJzL0lFalhqalp2T1ZCWkRETWdwclYwVUU1?=
 =?utf-8?B?aUVQQmE4WXM2aTBPMXlPclE2cWpTNHJvcVcxSmNCdkRZU0o5WTI3V0gzemIv?=
 =?utf-8?B?UlAvTWdSTFdFSjBsMC9QUC9qTlJNR0xPanVSWUw3NzVXQmRYWk9nZ0szK1RT?=
 =?utf-8?B?ajNpYWNPMWZmQ1d4Q09GZEpGT2VSK0ZnUUk5UjU3Zk9ISStWbm9uSiszNC9i?=
 =?utf-8?B?WW1BOEpLaEFkd0MyVzd5bzNQb0FZUEJ3NFpXYktpWXJ0WEpsc0l0bGtGcnA3?=
 =?utf-8?B?Y21wVlJwWTNmVUl6aFdYTy96eVJLbDI3VTBQUlBLWE1aQi9IMGZJclVEeVZn?=
 =?utf-8?B?c01yUUhsZjN0WnFtK21jNkQyVVA1c2pkS2g0bzQ2Rjh3S2w5UElWamorWWZ5?=
 =?utf-8?B?LzFBNVRheEtDRVRSd3JPWFJGY1dLeE9OSlAwRmhwdFhxRFc4dlZaN05teC80?=
 =?utf-8?B?bno3eTZtbE1USHpyUkRJUXhCYnFIbjVwRVpQUXhLdUoycGprWDM4WnNRY3ZI?=
 =?utf-8?B?NXpPZlVWSis3UktFd2ZqUWxHWHBhZDgvQlc5dWlwUnpYL21KcWZzb3BEQ005?=
 =?utf-8?B?Z3BpMDMrTFM2NVhNNGN4Z09HZFpZZ1JZamJLK3h1QVk1UXBpUUFIbTlsOUdW?=
 =?utf-8?B?UmFVRGVVQTZraWNINWVQVE1kQWFHTGp3Vmt4ZFdOZTM4cVplZ3Q0clZvQ2tR?=
 =?utf-8?B?WEl0V2VMN0RPSEFaYmozWElDZ0N3UzQwSCtPQXVFS3ppM1Z1Yi9KeW1SRDZZ?=
 =?utf-8?Q?yP9mRtYOkuKeAT70yrz4J3M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10697.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1g0WW1VWm04a1VhQnA3TlBRWjBvakpIa3RjUDBxTWFuVFhqbWpLT3dkbjd1?=
 =?utf-8?B?YWFSaDRoN2xGaGM3WVZMUGg5akFRUkVXY2lFTElEVWpieXdlTU5IVW1EeVdK?=
 =?utf-8?B?MmwzaTVKaVlYSnBZa0g4REp3YzJHQ2FiS0s3UGU1M2ZRbjJraVhEaU9LcW91?=
 =?utf-8?B?WHpHc2h3YjhYaC9nb3ZDeGtvdDZ1cnNYNWJzV25HL2tsS1ZEYWRjNVpWQk1i?=
 =?utf-8?B?dUJBMEhqa2ZnK2FQay9RUkgwUTBsTWhXZXVMU25RZmFNaHRheXNkS3hSSkNO?=
 =?utf-8?B?Um1yajgrNTRoQldYRmcxenNUOXVPcXZmT0lUT2NYVlhkalhuWWU1RFNrbUky?=
 =?utf-8?B?Qy9CYTVyMElhbllEeWdZM2J4V0xRUldTb1lVSlE0QjBoWUt1T0FYVk5Wa3BH?=
 =?utf-8?B?SS9NSHpkL0ZqSnZoUGNLQXRYM01hMHd6OW5lOCtFUi9WN2J4K291R0NHMkl0?=
 =?utf-8?B?SWJUYm15NHMzSU0yeXhUYkw0OVl3UmZTSWhicS9XNVpIS0ZzaUlFSlRvdFZF?=
 =?utf-8?B?ZWYwWEZKVy9RWkpCdUk1TnVYNU9xS21EREh6dFZIN3NEQXlXcjVlV014SGVv?=
 =?utf-8?B?MlVPNkNmdmZ5SnRkQkR6SWFNTHNGc2NETXNSOGg1ZWZ3RnVwNGRaVGdLNUEx?=
 =?utf-8?B?bkE4VGxkRmorNVFablBoUWk0QWwzWER2aXE2MFlsMTBXWkVtT2x4QUhrMkRY?=
 =?utf-8?B?dzdLRmw0MEZrekRzUFJucVpaWkI5TXpHNG5OMGsxR3NNSGFkcnRkY3FUaTln?=
 =?utf-8?B?YVhzdFpIMUN4V1hSWjFkcG5ldW56dFNwSVFDM2JvY0s0MjdmK2xQbHhmbW9w?=
 =?utf-8?B?ZEpocW9OZEVvcDZGK29VNlA3dDNrbURGU1ZPN2Y3bmhJV3VYZk9vZDNlRGtl?=
 =?utf-8?B?RnVVb3Y1OVBKOTVraU5JVkxTYlBUNE5jREwrRDN0ZmhjNEhrRU1HS0FVamdr?=
 =?utf-8?B?dkdoNW5WclZMV09mQmFsMFl1ai9ESSswOGJ0ZEJzVFNVcW8vdEl3U29RdDJT?=
 =?utf-8?B?dUJEeTd6bzBVVWZsVzI3VytFb0w1UkxEbDNIcTcxOXNqUlBIZFVkRCs5Tld6?=
 =?utf-8?B?QzhHR0tTYk9UQjhocmJZWVJSck5xL2hyUkJ2V3RuMFB3UnZpVElKMkRMc2Yr?=
 =?utf-8?B?cS9kMUpjVTBrOVBSNkpHZUpwdURya3FCK29TbGovNnlJS0ZWaXI1L1k2SXpo?=
 =?utf-8?B?U21DNDh0RndtT2ZGMGgyK1FIbEM3bnNDVm5xRlYyM09SZDNJbzNhSU1oKytl?=
 =?utf-8?B?YWpBTUNTbUV3elNyam5Sem5USVdYTFlsMG9RRS9iU3NYTTNkV2RwVFVzelNG?=
 =?utf-8?B?eEFDN2QwQlUwU0hFSkpuK1BkVUpkRlhsb1hCOVRIUWhtU3ZGSWxZSFA1TTVO?=
 =?utf-8?B?SzhIVGZnTzVvUDZXa1lWOHhiZXFTeExpWnFHa1k3Q3VXQXFFS3k1WWNGNnZT?=
 =?utf-8?B?azRVMVZ3YnlsVDRQcHZhQURWN0VPTmxqN3I3cmY2eHFBQlgyOUg4Y1VIOGk0?=
 =?utf-8?B?RzloVEMwZkVzWHpMQ1FvdkVHZkVGeVJHdm00Z01WRG5tT3lBNXQ1TjJRdktO?=
 =?utf-8?B?YUhTNTNOQnNYaHcvY29ZOUdyYU5OdlFCQjM4b1IxNmpqS3JZdGxRbzZPTFZN?=
 =?utf-8?B?K2tVTjhBVWZwTm5HbGlUSkxjRW5nOVgvNHJvWlVLQjdjSzBmTG52b0JSSGwx?=
 =?utf-8?B?TERiczBXR1hjOWYrbFFrUlVVMTh3a0xlME1nWVg0Q2owY2RPRU9Hb0xyajNM?=
 =?utf-8?B?Nzd6Ukd1M0JucVgvb3g5VEVvOEgwdTFWbXBmZmdlN1U1NWwrSlVLZ0IvWmJE?=
 =?utf-8?B?SUkzbXY1SkNpNngySytSVTF2Snh5bEVEYWV3MHZ6Y0UwSis5SElxeUdNWEF1?=
 =?utf-8?B?YkxzVTRVaytnU0RaMzl2RGxqMWxIL29CQThBRERPbmZFR1ZDazRoVUVrdDdP?=
 =?utf-8?B?NStxUHp3MnZnMnBnRU5BMDFMUzl0dDNzUjlWa3RkVUxvTndBRTBpV3VtTC9E?=
 =?utf-8?B?ZTlnRTFSL0UxUllzc0xtaUJmWmwwSUttTm5HSXMxNHRLMUNHblczQXRyZzU2?=
 =?utf-8?B?bXlFSXBTdkt5RWFRYy9wUjB5UWJLWjY3c25FQS90MU1xem5yci9LTS9MaE11?=
 =?utf-8?B?ZExEaDlyUVJTY05JZXcza0kvWDJ0M1lIZlhlZU5lOG5vYU82OWdTM0xuUi8r?=
 =?utf-8?B?bDYxOTRHaExZYVVjMUl6akJJUlZDU2pYbkVVcytKN0VqZVl3T0hIYURTQWhw?=
 =?utf-8?B?V2laeUwzRFFsUll5TFdHOE1xa096YzF3Vk5IZnJwVDUvT2JDTHlJRi9ORUxU?=
 =?utf-8?B?Q3FGcWNqSkh3QUxUbXVEU1RoT3IySzZoN0JYVkx1QlA3YmpWanR4SDJyKzFn?=
 =?utf-8?Q?9mIMvCRAV9Ha9fNg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7B69469826AA4479FE5FE4A6856375A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841bb739-5dce-455b-695c-08de59b10d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 12:23:30.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsWVAUKavnDRJGbU7uTStGwF781r8K4GzsS5NMD41rjux4D5D22CucOc/WfeCYTm8ZFi6PSwAZuRUBm2M7Cbnpb3/7hP394TQJyKDtHe4RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7807
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=polina.vishneva@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDI2LTAxLTIxIGF0IDE1OjIyICswMTAwLCBKZWFuLUxvdWlzIER1cG9uZCB3cm90
ZToNCj4gV291bGQgdGhpcyBhbHNvIHNvbHZlIGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2pl
Y3QvcWVtdS8tL2lzc3Vlcy8yOTA5IA0KPiBwZXJoYXBzPw0KDQpVbmZvcnR1bmF0ZWx5LCBpdCB3
b24ndCwgYmVjYXVzZSBpbiB5b3VyIGNhc2UgdGhlIGVycm9yIGhhcHBlbnMgaW4NCmluIGJpdG1h
cF9saXN0X2xvYWQoKSwgYmVmb3JlIHdlIGV2ZW4gc3RhcnQgdHJhdmVyc2luZyB0aGUgYml0bWFw
cy4NCkFsc28gdGhlc2UgY2hhbmdlcyBvbmx5IGFmZmVjdCBpbl91c2UgYml0bWFwcywgaWYgdGhl
eSBhcmUgY29ycnVwdGVkDQppbiBzb21lIG90aGVyIHdheSwgbm90aGluZyB3aWxsIGNoYW5nZS4N
Cg0KPg0KPiBPbiAyMC8wMS8yMDI2IDE4OjIwLCBQb2xpbmEgVmlzaG5ldmEgd3JvdGU6DQo+ID4g
KyAgICAgICAgICAgICAqIHdoZW5iZHJ2X2RpcnR5X2JpdG1hcF9jaGVjaygpIGNvdWxkIGJlIGNh
bGxlZCBvbiBhIGJpdG1hcA0KPiBTbWFsbCB0eXBvIGhlcmUgYnR3IDopDQoNClRoYW5rcyENCg0K
QmVzdCByZWdhcmRzLA0KUG9saW5hLg0K

