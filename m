Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C354D637A7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 02:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBm90-0008EA-Ad; Thu, 14 Nov 2024 21:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tBm8u-0008Dl-Dt
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 21:33:04 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tBm8s-0000MW-EK
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 21:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1731637983; x=1763173983;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XfUMey7kwCN8Hv7O8YXtBh0WYIMOH9QSu4dvVTsOVPE=;
 b=LMwqqZMGiPuknIHJefmOiSezv3hDgXVXSvHeuK/tmaea39fCgkvbwUsr
 0FSSkM/Enj2d5YBPa4EET/XlSpWn8BT30ZbqsI+CSaKeWp6CFQzGyJtDW
 y7CM2TWXwjmWntQepvR3M+s4M6PvdqzGdccshgjLXl5WW4pxtkUgIKjlZ
 mk7R6OVMKOTBdq/XtIrQTyjSh5FqDavKRxp9NS700gMqEchsbPW5rV9Nm
 dmD1BTvxsAmUpzQDKhcCx8SKLOQReI/H0U3Puj/bTkZnWHdgHGAQR8cAf
 +npSnkTa1HFQrd5ijYqkgcBBI1B5xE8Zek9ULa8euLNECfdRBu4CMgjVM g==;
X-CSE-ConnectionGUID: /ue5LiCbSzWfZciEOCzQ7w==
X-CSE-MsgGUID: JRegouXaQ2yMiYqMp4QFhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="142637090"
X-IronPort-AV: E=Sophos;i="6.12,155,1728918000"; d="scan'208";a="142637090"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2024 11:32:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7KIyeXpKGAShkgvctDb0cNKV+sFtzWNdmZr6eXScN9yLutpAJykfby+3gQyhTSHN5JLBfkKsCQSFeZ1EhCnucxVp8KMz1Ip09W+BdD/XWr+KQfT4cvMvCZkChHd2SwjMyhjAMH4etLuLtigFVHQbhiuMaT9pjwfY1p11AkE8C3ZIR/cM6VfaAXkjwM9q5YuBoXVyUXwhfzE+Alge62ArStUb5yF6XGORbJwVSopJMppZEIqMcil/1y2MssBIHGC/G4dcKmQZWNMQeXPP5isvRZg0YyKTGZWNYsSkJUswXgFFLBqGbiTY2OZXK433k5458DR0SgkS9W9J8hVtnD7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfUMey7kwCN8Hv7O8YXtBh0WYIMOH9QSu4dvVTsOVPE=;
 b=k2OSxlnEWbAd9cwutCITGWA4qVuxOVXhe8rJrLxHAhgvGnKWkPhJ2OcSPgNE7uImV4634ypez3zi6jMUpcf7Ui7od9c8NX1Rj2PP/0wc6J/LrrwLd0qhdMSDKm5r5NOTH3u8bsZrYRTGi51J+J6Hq470JtIi8lFNAahvlLEDAVvhtw8qajUyYPFBwlMh9CtbN2TjXR+K0SB2f/V757RGceR1w8RErrwOiPk5DFbRnbwB28gFRQ3ktNxLMkGGAo7xlmZUnxOhVByU5FmyeignvEAZjegCe5Rm5pxKj+4OZrVWWI4wS2Ju1IIQmxHW772pSQMnDVF4eEKP7I30Qf59fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY1PR01MB10754.jpnprd01.prod.outlook.com (2603:1096:400:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 02:32:33 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 02:32:33 +0000
To: Zhang Chen <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>
CC: Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update my email address for COLO
Thread-Topic: [PATCH] MAINTAINERS: Update my email address for COLO
Thread-Index: AQHbNOJ3ctlsbdZRD0aZ7B4T34NsQLK3o3iA
Date: Fri, 15 Nov 2024 02:32:33 +0000
Message-ID: <fd1e1692-7c69-4dcd-bb09-5a2081178082@fujitsu.com>
References: <20241112084038.6352-1-chen.zhang@intel.com>
In-Reply-To: <20241112084038.6352-1-chen.zhang@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY1PR01MB10754:EE_
x-ms-office365-filtering-correlation-id: 049cd35e-bf75-4f6f-06c0-08dd051dc293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZmZyVWUxN2YxcmNhNGJVb01mRzVXaXA5cjlyVUdEM2dVRVZrN21CU2lOTDJW?=
 =?utf-8?B?c25VQ1pqMzVFYWZyUmRmQnBsa2xWeWozTk10Um8rSGpnUW1VeWF2eG9jRVpO?=
 =?utf-8?B?ci9LV0NMakZIN0NNVFluUHJKSCtPM3hmZVVNMnJ5K1ZLWi8vakw0SDZRRHk4?=
 =?utf-8?B?aDBnUFZyMWkvUGtSS3RxTjl3NUVTQThSb2dvKzBKbzJ1RmUvdnNBVjQwR2NN?=
 =?utf-8?B?bEovMTBWNmFibnNZVVg3aUdQbmZjOHprbThHL0l2dmFneXkxYzJQcFMrN0M5?=
 =?utf-8?B?Y2hROHYyd3krRmxVNUJ3K09VTzY5aUlNVXVUZlZxL1hGOEpwNnVHWTFuYmJl?=
 =?utf-8?B?Y3QwSzZUV0VXNHQ4Z0U0d1pxbzhWK3hmSXR2azdUY1ZuR3lCSHNNRnU4ZEYw?=
 =?utf-8?B?eExhRUJHQjJxbk9Wa0J1bGdUM0NSU0l0SGRMczdWRkpZM2tmMWhZR0hxZ2JB?=
 =?utf-8?B?U3UrZ0hFcThCa01UTk1VZVFBcXJqeCtUZXM2L0tjL1VmZnl0R1JRcW05YVl6?=
 =?utf-8?B?OVNveUY0WjN0NEVEUzEwVlFBZnB2dHZMelZvOWh6R1A2Z0JWU2VML0RpSG8w?=
 =?utf-8?B?dWlKM3djOW0rQUQzeTJ5Y2hVMXNOczlKa1ZwakYvclRUN3Uvai93eWp6R2Qy?=
 =?utf-8?B?NzBlUktPZWYyVEhjTGZEcVdnYUJ0eDRiUk9uSXFNVzZrS0diVFlmNjFWWVcz?=
 =?utf-8?B?bG1IcVM2UUlHT1hpRHB0TTNzajRJbndtLzhtV2F0WTJpMFlrYWpwcUFHbktr?=
 =?utf-8?B?Qm14RDJXNkZRSTNhRlNFd0hOQzBVOFo3dTFNcEpYMk5IR0NrcUppVXBrN0h6?=
 =?utf-8?B?N2JyMm9uaDVJbFJ0SUZWQjYvRjBJUkNXYkhROW5SZ3RGZzJVMSt6SVBlbnJ0?=
 =?utf-8?B?OU53ZVJnZEh6U1ovRW9GOSs4SmZVcU56UGNieGZsdXg3aUdJcmpKb2xDS1Q5?=
 =?utf-8?B?bkdFbThhc0ZXZDJWY2JiM0tkNUZsMFM5NkgxdHRBbWdlZ1FlS0xtNU42bk5X?=
 =?utf-8?B?VGFROVFhd3RkVUZDc3FBdjVCNVcvRVkwaERFVlg5SUQrQ2NIcjhqTWdBcDFH?=
 =?utf-8?B?bmJxSDFoTmFsZ05udVowb3hxQWRyeEprd0d0WjVZczFjN1NObDJCKzRUTDR4?=
 =?utf-8?B?NGZhejdIV1pHUXk2SUhSZWtJQmhmUnkrN3hnWDVjMzBMYzhzSXdZVWZ3UWVk?=
 =?utf-8?B?d2FxNXA1U1diT2Uwcko0V08yNlUva1lDR3lwbURhQzJ0bU9USC80Qmtxa1pV?=
 =?utf-8?B?TXdONVJOc0dtRnI3M29RQWZJbXRpendSaWxGbHdqL2tTL1hPYXc5dnR4TjVu?=
 =?utf-8?B?NHFlQVJnMU1QeVpMSldSNTQyV25iUkhTNDM5b0tNSXJRN09tMnFzQlB4bTlK?=
 =?utf-8?B?ZDBvWG96L2x6cGM2UG9WQWx2OFd5b1JWN0tZV0Z2V0k3MWg3MFp5TEJwMVRF?=
 =?utf-8?B?Y2JabGlON21jV3NwblVNbEh6dzdrNXQ0akE4SDBNUmQ4TWY1bVIrcm9nTHky?=
 =?utf-8?B?V0pKU1VxMnppSXVlb3o1OVZnZmV5SVFPMkFmVUhHMnYwcjh2NGNqSUcwVldv?=
 =?utf-8?B?Y3RYMVZIb0VaTGFZWkJGQkxpZ21uQkpoOHR6SUo2dTVELzZ6SGZsdzBaMzZz?=
 =?utf-8?B?ZWtqeEQ4NWZ5eUJFUWVCTVB2dVlZMTBKbitiQmFDUGdGUW1kTEhWaHcyYzQv?=
 =?utf-8?B?M3BacHgwR2pOeC9HM2VIbVZ6aVJ1dnJxcVV1R21pTmRFNUU3aXFpeXZWNDlM?=
 =?utf-8?B?V0ZsbCs5bFgrdzFnemxrVy9iUi9DRy9lRlRITXZlS1N0MmJ6UDFGNWUvcXU2?=
 =?utf-8?B?Q1l2SHJqSlNYUnlOVk5ocU5NWThKRzAxK2FyWERhYmlMS1lZMUc2cklvdG4x?=
 =?utf-8?B?WnByODF2VHpZNEtFK1dyVC9UN2ZJc0N2YjZGZ1h2eERQZ0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3BybDlRUmY0VnB0SjNKVTFRSXZZamdjakRIdkFHejU1TGxnOE1Yd0Q5dnlP?=
 =?utf-8?B?S1JPUmdXU1pWbDcxcldsSCtBSFhkSms1bzdEbmlyamtSQldxNVVOc2Z4WGlQ?=
 =?utf-8?B?V0tqem94Z0Y2Z1RTK09oQTJLV0Yrc21hN01ldFFYZWZBb2FSbnBzOHBsR3ZK?=
 =?utf-8?B?bjE4T0J5RjZCdXpnRFdMS3JZYzRUVkR2TXZVU2RYcmx3a0lSSmZUM3Vod1du?=
 =?utf-8?B?WU5sV1ZWamloQlBuZ3lDZFFsZTY2Q1ZmQW1RVm10V3FrQThaeXg0WnFkSFNa?=
 =?utf-8?B?K21kN1ZDYUErUFRoUW80Qkw5T2tESzJXbkNkQzZRQkRwZ1lmVTZIdlUrT2Zu?=
 =?utf-8?B?Z29nMWc2a1V4SkhxcmQrTjI5NFI5TlliRlc4M2JhYnc1VkZhWHptc2plR2V3?=
 =?utf-8?B?RzIrTlVLb0drV3kyY2Z0YkRSbzZYak9YKzAxait2OWxUQlh5dDk3OE5id2Zz?=
 =?utf-8?B?TmVFaDdrTlJCZFdIakRBRy81MUQrV3EyUW1mZlNJc1Y1aFN1ZVF0OWhyYVFz?=
 =?utf-8?B?b2lMQjF0NnQzbW0rMWI1Z3FOMUVsaGdXa1VyN1FRbE4xTms1c25QNHJRTzM0?=
 =?utf-8?B?TzFGS1JzRkhobkkwNG9oYjVxWFZYYUk0Zzc5a2NBSEZWa3hHMmdtNlMrRm01?=
 =?utf-8?B?OFp3bjhvTjMrMTBmcGNIY25HY25lUnJUSFRIQkZtTS81WUtLYTJvME5CK2FH?=
 =?utf-8?B?cTdHODFJZ1hQeXVwQm15SDFuM1hNVEI4WmpzeWlwQWJIdXpBKzMxWFhlVWx4?=
 =?utf-8?B?T3ZBRGxvcGxRRkhQSjRIU0ZtZ0ZxbHpwUnFieUN5dTNrcFF2cHV2TThlUFcy?=
 =?utf-8?B?VElzQ0dmN0ZDSTdqTTlZd2pUOG1SNEUrQWhDVllGS1hzclNsZ25vWTllQ2cr?=
 =?utf-8?B?ZEFSL0FFQ05UM1EzSDc5Z2R3NitDSjJWRzd4SGZxWjFGV3FobEZPQnc0akt6?=
 =?utf-8?B?Qm5uUVdEWWtTU2drUEVTSXFkd1VWZnlQWHhYeU8xK2RxWEdaMGk4K2pXU1dG?=
 =?utf-8?B?SzJXQVRlNVEwdjU1cVdZOE1uMTFsR2ZaYU9WbjN3VTZxaHhwMHA2TjBIdHFs?=
 =?utf-8?B?VEdHMng4R2pMekhFejhydy9ucnpHK002VTg5NXBkeWNScWtJM0J5SFFWeit5?=
 =?utf-8?B?a1ZaaEVqTHh2QnA5Q0NrcVl1M3p5aXF4ZGdQbGdQb3JFTUppem02R3pjWjg0?=
 =?utf-8?B?SDVEcHJmSDBHbkdNRHBXS3JTYXB1MGwySHdYWXVGa1JycEN4K3hzdEppektj?=
 =?utf-8?B?NFgrdzc3QU5NcUtJa1B2TVQvTDBaWDM3ejVoY0MySFRtOFdUL0NGKzJjRnhs?=
 =?utf-8?B?M2xzcGJSUXJMMmZnMXlDMGpxUU5TODRSTXMrMWJQMkdHcFZHK0lIT0pMSjZ0?=
 =?utf-8?B?NEQwM1prcHBVanJkalc2a0p4ZDAzVFBrbENVWGFkWWYrbFk0dnFwMkxxZmxV?=
 =?utf-8?B?aDcrUmhURVBTMzRubytMS2FNUjRKdS9nUWdrWkpDRmNnY0pUMkx0emFqUlpm?=
 =?utf-8?B?Q1NPK29yenUrQW9CUnRha1RoNVZKeXloTWN4VmdHeXlXdnhxVE1aZnVEY1lU?=
 =?utf-8?B?U0xUZTJzblZ6QXFydFV3RG00RERIZ2xYUFArZHp1UXhkWnA5bjJSNEtpWVdQ?=
 =?utf-8?B?VnBmYTY3RXBLVE56d0hRMktIWFJPUHROUi8xRDVIWnJQbXJsSzhiL2M1cERm?=
 =?utf-8?B?RnJydjdFZ2IyU0ZHVUs0eTNSbVFGVVVyWnRsYXpJaE9OTXorUXQ1WkpScURw?=
 =?utf-8?B?S2JBL3NpeFNQVmJWbHdCSmRpaXJIZmI5L2NHZDZXNm5aOXBqeDZrTjM5K3hI?=
 =?utf-8?B?SjhWOVVJOWVWU0RmTU0xbEQ0ZXF6UGxtQkZLZmN5Mkd4cEV1bHFHdG40N3Jy?=
 =?utf-8?B?eXlYN1Fpd01Lc1NPR2QvdHRYMDZQbjhMY0JsVXFVemphZVV2RkFqSTZodHo1?=
 =?utf-8?B?L1FLUlBGSmZDVzFHZitYbkxOeWdkeXYzaVVFMHVMWUVURFBFQnNOdnhSRjdS?=
 =?utf-8?B?UzhTQ1hNUUdDOWx6dmpwVS8yRGFnYVNIZDlNODdlemR5T2FLM3ZmTHNqK1pX?=
 =?utf-8?B?NFR6RllRY1VaU3JoN0dwTDlTYUxkRE5VbjA0a1E4bGN5V2tGVHlYVG0zK0pH?=
 =?utf-8?B?YWJrUVZPNnpDSVd1UnU4UEZFRWNaRkVqNk5ydXRmV0EyUnFUazlmdjRMaEQx?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A45F3FD0E510A2489A67B5A09DB6218D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kD1aqJ6Y0GaWHsVxQkaIX+J86BO1Oc7cRg+hclEPnyLqF8+hW35qVpeh7J2aiD8bU2VmJHnhTif1BJElk8/VspaiTqBVQ9jCz9wHwSzSMFBAWKAbgMa6RkFAb9ZZyL+8kHSm/HDU8id7wSPKGW599TWXgEnyBjhezgrPohzXcHUiZqoYMbvFLbRTWXPplU0dxzdOYTMP5DuL2YDNrM6jfdLsYTCyyVXui+tO0EYijGp1PxezRycAthEfli8MRlD7UvH3cqGH0vWb1TinN7++ANH4c7TUpNlhrVEG3C+/1TT/7/qsDwJ+f1pJbrHlPIIVhAomOJWLs/Q/1KNkgqMEd32zPs6JQ4OfuMhR5Ymsgcmo9e0zFv3CaleXIR2w0suruiKVIBXYhbEqjAsn23KHAgL4musSF+skF3y81cSCf5hFVazfZi2Bbd93gFdWYG0shfaS7pSsxCnYUR3aGr3nrQWvg3znrNf9Bo3E2b8TJ0Re76/bnet1wQcsjb2xxhh8lxwWr0CGeJzrSBs3wAdlCoY1hgrp1EmYf80JVNbhXXgbZ8xUiOxUGJGGRnGQ0YRNW1qReGJiXJUIxlJ47RB1B4+ejsxl3UPWjCjgxMV3dkNxsKi6F7PTdDiBCvlUfmgW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049cd35e-bf75-4f6f-06c0-08dd051dc293
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 02:32:33.2914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBZUsMwWLZWGqqPKETU3L7sGUnKHd2Wg9NhfWuXfL/4fJ2e5ScxJLPNtmm1UU6geQxfWJCYnmsQiiSTrWQfKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10754
Received-SPF: pass client-ip=216.71.158.38; envelope-from=lizhijian@fujitsu.com;
 helo=esa18.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDEyLzExLzIwMjQgMTY6NDAsIFpoYW5nIENoZW4gd3JvdGU6DQo+IFNpZ25lZC1vZmYt
Ynk6IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KDQoNClJldmlld2VkLWJ5OiBM
aSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KPiAtLS0NCj4gICBNQUlOVEFJ
TkVSUyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGlu
ZGV4IDA5NTQyMGY4YjAuLjNmMTA1MjlkOWMgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+
ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0zNTU5LDcgKzM1NTksNyBAQCBGOiBpbmNsdWRlL21p
Z3JhdGlvbi9mYWlsb3Zlci5oDQo+ICAgRjogZG9jcy9DT0xPLUZULnR4dA0KPiAgIA0KPiAgIENP
TE8gUHJveHkNCj4gLU06IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiArTTog
WmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gICBNOiBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+DQo+ICAgUzogU3VwcG9ydGVkDQo+ICAgRjogZG9jcy9jb2xvLXBy
b3h5LnR4dA==

