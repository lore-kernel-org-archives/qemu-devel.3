Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54521C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 06:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzA5s-0001JN-E4; Tue, 23 Apr 2024 02:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1rzA5q-0001Iw-MS
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 02:57:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1rzA5n-0007gy-RR
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 02:57:30 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N1IHqw016800;
 Mon, 22 Apr 2024 23:57:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=633RbLr/W3f
 O1OSmwY8jB4cfpavdflOQu8MUDUZgjfY=; b=Q5Y8qjrofKQ7F6dE+pQ9TMp1KCD
 vlGq2lASDcviFSovBHHMQABRTWJUeCUN8NxRAtgBfTqK7Z4Rd0TBVyfCZZTfo99V
 WnVT0yBS9y5Xq8LiRxafaWZhobw8b6ZnqA/k5qaQnIPWd+1dUVe9v/VFwVkmmxz7
 8/s3XA2TiOX+XxukYxDPKRFvqWykUaUWzg9P8NxP2lQwF9EPkJGaep1lLpOiPTbz
 NUqO765/cujE4Eg29FbrR/UQsGKavHl7cS90yHlHI3cd68/Cf4p1a/vanj4uJWf1
 zX+0ukcvjadoDIqR245crbISIdGJcDkEJkDLKNXQ2EDPb2EiKbE7rqhoQPA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xmcsdd2sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Apr 2024 23:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB7pFG3LYBsJ4AdfIsxlkpfescFAfUhDij496RhKJxXaUIrCLnksWDJoWU9UXKkTI7Mnw3/KeI6vRAIog++dsyY1Y5cEGIsfaffWUxjslJzkeRyaEuSuuFuwCjMaNG8ebyyKhzBQeAbun5FJiFZ6UQKaeNR9MyOQdon6A7tiT9JNHjDP9voONvFWZJFj3TMVXVJiEBHdQrIuz2CeAsdh+kx9KV3ZJ4eFFOU2F5CnILGlgHN28ktc2NH/xOsp+xgP4wyAzXeHpMS1uF9pXSO+qLBtCDBUk3WaC0A6SBoLmbYG6o8qk+VDNEByYm585/QLLZg/dwRh10RPfZNhw6bnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=633RbLr/W3fO1OSmwY8jB4cfpavdflOQu8MUDUZgjfY=;
 b=A3ymVhs13Xi7irP7OXKRlOiQ/Es5rvVydkE1WpvgaZvwYJ4wkmx7uw5sy9/2oCUsX5MEggjPZKvPW5cdGRyk1OTY2e8VBFizpsN2xC6dtHxL+RMGxWxRn+u14g6fHrzimmraAu7eI9AycWgDyiDkCtEcsklgwwKsZf9I6frlngsrYk+rNNhtQaUpWkNoJFH0p2lD3ZBRiCcUuhJ7FPHzMxyoSwATOrmFpcERuJa1uEj2AkF+nkbk857WDgE3Ns1RmpnK4ZKMSluglAFShyQdMmVcN2Ff//MzSu/5yKTsBLr12qUqigGHSFn0sVA3ul0+K+Tn6PIeU0ASweG66otbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=633RbLr/W3fO1OSmwY8jB4cfpavdflOQu8MUDUZgjfY=;
 b=c69H7ld8I4idxJ6JcnL7XxzoIUsMaXNVt6ahv8Ic1vn07bj5/NNdK2hMBiUPS0D/mVx0MVvGYTFEp4ORYguXJKomm4x74bhU9T4bAXYqjshPhKoC01l8bdPmzTvBcG8C2uhpiY4I9QHo1wHxF2V4yOV7ChhH+3BjfZwl4cLmScTyShHViu7vD6ZplgG+bCknZwUKhHwsJbQ640PjmDchCDTVc/YFRDiui2Brj+zMZy8CzFPV7l4PrYOM3PUQXnvBUUpyOJDo+RQrK23ETsb9gN3imUSPMooCVOzOXAzWlmxLSNmU858uafWLXVAaQ4IGi6ttPaVV8tnt3xJeXEFgUA==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CH3PR02MB10011.namprd02.prod.outlook.com (2603:10b6:610:1a0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:57:17 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:57:17 +0000
From: Manish Mishra <manish.mishra@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "christopher.r.blevins@intel.com" <christopher.r.blevins@intel.com>,
 "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>,
 "lei4.wang@intel.com" <lei4.wang@intel.com>
Subject: Re: Missing features in QEMU SapphireRapid definition
Thread-Topic: Missing features in QEMU SapphireRapid definition
Thread-Index: AQHajvt7Oszp7Zi3CUut2jW9h6hLMbF1eJ0l
Date: Tue, 23 Apr 2024 06:57:17 +0000
Message-ID: <PH0PR02MB738400F34A65A61D2D843F44F6112@PH0PR02MB7384.namprd02.prod.outlook.com>
References: <PH0PR02MB7384F448F73756EDE574A306F6092@PH0PR02MB7384.namprd02.prod.outlook.com>
In-Reply-To: <PH0PR02MB7384F448F73756EDE574A306F6092@PH0PR02MB7384.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7384:EE_|CH3PR02MB10011:EE_
x-ms-office365-filtering-correlation-id: e04668f5-5430-4fa1-665c-08dc63629d1a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?VEtPMkxUL2lnV0p4OFJmWWIzczB4RE1jWEZIUlVtM1lSWHJyZ2JEaVVLVlQw?=
 =?utf-8?B?RU56LzU1Uy9QMWpQcjMwL1ZMY2JXRVF5RXVFZENqdmNUVnhCNTZ6Mm5Kakcv?=
 =?utf-8?B?S2kvWS9tMzlRYmVoeWErMitQcnFjM1JocnRVcWtJYXBDZEU1Rys1dmVjUjJv?=
 =?utf-8?B?Sk1Za3BMcXAxa0tQOHV4VHZadmZ0QmRTZzU5UW92WDlOYlNLQkJKK1YveW5S?=
 =?utf-8?B?UUt5a0pNd21NQmw3L25zTUJxOGZtay9UNDlrTHlrZ3dQeGhvMENUZjdaMHZD?=
 =?utf-8?B?OUN1MFJ6bm5tSjZEUUJiRmFUbTVvakxPVytxdWNDVFlzUWhnL3BmajFrWkNP?=
 =?utf-8?B?UStwa0hPRlcyWEIxRnp5dCtXN252WXhHNWlnQ1ZQNG1tdXJZcXNaWlRSM2tW?=
 =?utf-8?B?aXNPb0R3azVuVVZRNGFJV1VPZ3FEUU9pM1NVQjJmT3FzaTdTLzIxZ1ZKbHBE?=
 =?utf-8?B?dk9PN2FTc0hvQ1NRZFpLbTArclExc3hZaW1Fd2U1TGdzM1M1YkFPRjNvZnh3?=
 =?utf-8?B?QTN6Y2hocXREWGdyL2NwcXdtMFRpL3RkbE91L3Zodnp5aXdrY2JmYmtYMit6?=
 =?utf-8?B?TWlnUGUveDk5ZUFRSmJzemY3NlVJK1kyeGhqODluWTdJWCtNNHB6QTM2RUdt?=
 =?utf-8?B?SlRSdHhpaWM0cDFYZmxDT2VLMTlEdDhldXR5bk4xYytVSzhPcjNoRnhVSFpU?=
 =?utf-8?B?ZjE4MFR2MFlpczFMQWhscGc0bnBhWDBOYnFFQjBoWWVtbGJHOGJIaW5UOGxl?=
 =?utf-8?B?c2toRzRoV01aQmFrYzg0VWdBWWVqNmJ6aDlFZk0ra0VrdGZiWGhzdndwcHZn?=
 =?utf-8?B?WUNPWVQ4NmNvMGxFa0RmTkZmaDVHRXp2RnlIUEVXY0FYWFdsZ1kxUlYzSHBY?=
 =?utf-8?B?OVJPRitYUVFBMnVtV09LWlF1QTJTejR2eHVUY0s2djE2Z1JWNThEQUp2RDh6?=
 =?utf-8?B?VUFNaTFZd05OYTlIV29NU0dwNGE3S0l5UEQ4UWZFR2dKc212Zyt0bFo2NnRM?=
 =?utf-8?B?K2dncWFSRnUzUWtyZTA3NTBFNmxkQ2hhYVRoazRXZVBsam1oRlh5NXFMbC9G?=
 =?utf-8?B?b1ZibDFGaWs1OVNlTXd1cGNCd25EaFNzS0FxNytLc1NXbVZFMTZIaDJtK1RG?=
 =?utf-8?B?SEdKV2RKOTdjYlhEL1hWVlJvTTZTSUR5SzE2UTkyVU8rMzlINStLbFJYVnJX?=
 =?utf-8?B?dW5zdUZ0WEJ6WU4rVWxtYjRwUUNGendrdFlxeDRSeXMrQVpRTGVLd1J0UmJV?=
 =?utf-8?B?RWF5R1cyWmxuODh5aWxXb3BEZ0dXNXcyNkFNMWRWelZoSmRncE42QS9wWTlR?=
 =?utf-8?B?SE9Fayt0R1JQdW1vcGV4RnJ2Q3kvamdWSllDdEJNdHQvbkZpSjEyRUw4dWtk?=
 =?utf-8?B?ZEgyVlNUR3R2QVBSZTE2cmZKQU0rL2JPYi83ellkVy9qZGdoUWpCZUV4ZkFP?=
 =?utf-8?B?TmE0dFl5SVdGdDdlRGJIUDdtTEdQaVB0Y2l2S2orbHdRWXRRcG9RRDBrVENG?=
 =?utf-8?B?RVFucGl0L280WEdWTVZuUnpvWjkwTTY4Uy9DTFNVV3pabGMwcFYyWVIyN3c2?=
 =?utf-8?B?dmh2bEZiNWFzVmRMVWRPTFdXcTNrT205TCt3dmsrc1BqVmtvZW42c0NzaUxM?=
 =?utf-8?B?clhNZE5KelM5VjgxTW1Zc0F0VmdvanNXT2FKYSswVDN2Ym5FeU5TZWV6TXl5?=
 =?utf-8?B?MzZvWDIzSzRoYUxlVTQybXNCVzEzUVJFVkY0c3QyOTVqUHVXYXNCb2FRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW9qd1Iyb1c5bXpuL0V6U1d0RDhqSStWY002a3ZEd2R4UTJxMHRkeTE3cmpK?=
 =?utf-8?B?SUhUZk9VTUl1dlFiRzdDZ2hOR1o4b1JKZisxWDk2SlpNc2VyaitvSjVGSVVY?=
 =?utf-8?B?VDhKdnpxWU50OXFLem1sWHZBeU41V0grQm0wempYZ2NvTjFQckhXS05WRjFW?=
 =?utf-8?B?alhiZlRNT3JkRFBnSFZMWkF5UFRxaWVYZ2V6eDBSaFZ2OFdIZXJYcWluT29q?=
 =?utf-8?B?amhvSVkxMnkzTWVuMlp4VEh5L3VHNjFaMlVlNFRYemJWSGZwUmJYQkhXR2VV?=
 =?utf-8?B?cWxORVQxSUVsNkxUNi9lYkU2QVA1TDVNbDNsQ2xaZXF6SWFqRVUra3lBaFJ3?=
 =?utf-8?B?MFdKU3VQSlpIK2hEWk9LRUgzdkRoVjdWK1I0bm1QalVTdWh2bWhjaVhFbGVm?=
 =?utf-8?B?VXVSOU1FL1lHSVg2VFNnMDh6aDNJL2hKVEIvMmM0Y3pmb3Vvbm5QNFVVT0xM?=
 =?utf-8?B?aVFWOXpUWGt4OTRCN3B0QUxQQzY1YTlad0lseE11a2pvK1VBUEt6UEF1cysr?=
 =?utf-8?B?OUhKSnFQb2pjSi8rSFJDeTFQb3lZU0F2WmgxdUJ3ZWJveTduUDR2eWIwNGhx?=
 =?utf-8?B?alkzNDMxZXpXWU9EQW5RV2wyRk1FcXdKSkEvOUQrdkR2dzdnVk9Bdkx2TWJa?=
 =?utf-8?B?bWEzTjVGSXpDOUZUbitVVTBhcXYzSGhVbERUYStWUTNDZGMyaTY0Sm1NNk1h?=
 =?utf-8?B?c05GNk5xeUk4K1c0OFRvMFNqNFNRZmkyMVFpckE1QjQwc3hGYTZrS3ZUOXpm?=
 =?utf-8?B?aFpOOGNTRWltNVZDSnJwbEJicHBzMzA1Y2Fwcm9uY3RPQXlZakUrbjExcVBD?=
 =?utf-8?B?bWNuQmUyalZDMUZqcjhhNktzTWExZndNZTVYMHd1eDUyTnJDSmNSaHNnVzNZ?=
 =?utf-8?B?YWY4MDJWeVVidzZwVHVMQ1BTTXFQUVdnMk5QQzFBT3BxRllHMUpnVHM2ajcx?=
 =?utf-8?B?OHd0VWJ5ZkRnbWJyU1E1aUJPUERZc0k2UnlienBFZ1ZaRUtxVlU1RVdQNVB3?=
 =?utf-8?B?Mm5XSTMrdlN4c3dzSS9jTUNzenhxT09YZ0xsK3FZZWoxRUUveU9Gc1BsWEw3?=
 =?utf-8?B?b1pCV3pZNlZtNE0rYlIxVGN3SkVyWWJzYTMzVmFWRm1mMFI2TG92NUQwRUVX?=
 =?utf-8?B?ZEdlZCt5aWJERDhObHNwZVRtcTVnNXRXSkJPUSt2dXJQTkN3anFnbmkxSFhN?=
 =?utf-8?B?RWJoUEFUS3M5STNQOVEwRHZlSjRPNzZrM214KzJxVmtTckFwM0ZLNmk1OG9Q?=
 =?utf-8?B?M1J6Wll1T0k0Z3MwTnJsSlVFaGtUWks0TE1yU0ozMkUxbnNkamZCK1ZFelJo?=
 =?utf-8?B?VnI3WC9kU0pGb2JPRWFza2UyZmdTTUN5UUhyYUlqeGo4WjFHOVlWM3N0RElo?=
 =?utf-8?B?eENZcElQeTBYdElmM3NIOFdIbThId3RIYStLTHl3TS9Xa0NLbmRPcENPQmRM?=
 =?utf-8?B?djJtTkp1cmhscUxaRGJvYkdNejNlNEgwTCtYSHVhakRaTWtvbmlTcmxBVzNT?=
 =?utf-8?B?UHFvVE5YTGxMOG56OFp1WkJmWWZ2MTVvTWp2R3BZQ2ZUcGkyTUxDUEsrMUpT?=
 =?utf-8?B?ME5BWnAwMjlpZWpBcStNbnRmTkhSM3RvSWhFaTVLL3lkcllJc0hONmFlbmx6?=
 =?utf-8?B?d3MwNlhrSUI5NmVvMnplR3NYaEFjK0R5R2x6Qnh5bDFaNUwzTldTbHJDSTBk?=
 =?utf-8?B?blVLbzgya0ZuRVZRSUxvbFRWak81N0FYbXhEc01ka3kzbW0yM3BzdFFGL2Yr?=
 =?utf-8?B?blJKbGdoZFh6N1VOeW9JeExmalJMUU9Wb2pIV1hyUkZXUDU2bXhZaHVPdzRH?=
 =?utf-8?B?cGFHQUdPZmQ2RG1zS1hkS1ZIdWxoUnJFVmV3L0ZTK2wwbllidGUyR1RVbFFv?=
 =?utf-8?B?TXFtVUg3R1ZUYjdjaUkrN0VXenlyMGNZTVZoS2VFTVBxeGQxOTl2ZDBENjdn?=
 =?utf-8?B?Z0RXTERtN2w0U0x1aFl3ODJrVnNMWlBpUGdxK1luVmt4SngvNnNDenJaSTgr?=
 =?utf-8?B?bUIrUDVSeDkvcCsrbnBQaU1yM3hHT0lkaWhkZkUyMlVXLy9wb3dlN3BDaGpy?=
 =?utf-8?B?UXRCK2QrL3JkbTQzL2dNaDg4ZWJhbTlFNHl1NWszeTNOalJYYkZQYUNMN3Ni?=
 =?utf-8?B?czZ1QjNBWFkwMHR1MG1TWXMzenVlZEhDSGh5dmY3ZlB6SFVhaDhYN2QxY1Jj?=
 =?utf-8?B?cmFsTkhNeWF4WHE1VXJIMFZ5Z1R5NGJrNU5pR1VycWpnd2F3Rjg3YmxXL3Rx?=
 =?utf-8?B?cUI2QzlQbEpYTkVqVmtPUmtEaGJnPT0=?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR02MB738400F34A65A61D2D843F44F6112PH0PR02MB7384namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04668f5-5430-4fa1-665c-08dc63629d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 06:57:17.3419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHMyhcKRHaWcCq0EhPLHCSuFaN6lyZGDZ26wVbXwd/h2mY2w6ogK+BCw7qJb0RVHcuKm9pRI8IdLXnB9e4vfK88JHZdooHp2LrSwBYha2uM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10011
X-Proofpoint-ORIG-GUID: sYeNKSz-9kB69fdPMZGIUIrWr3bdp6v4
X-Proofpoint-GUID: sYeNKSz-9kB69fdPMZGIUIrWr3bdp6v4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--_000_PH0PR02MB738400F34A65A61D2D843F44F6112PH0PR02MB7384namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgRXZlcnlvbmUsDQoNCldlIHNlZSBmZXcgZmVhdHVyZXMgbGlrZSBtb3ZkaXJpLCBtb3ZkaXJp
NjRiLCBjbGRlbW90ZSBhcmUgcHJlc2VudCBvbiBTYXBwaGlyZVJhcGlkIG5vZGVzIGFuZCBhcmUg
YWxzbyBtZW50aW9uZWQgYXMgc3VwcG9ydGVkIGluIGludGVsIG1hbnVhbC4gIEJ1dCB0aGVzZSBh
cmUgbWlzc2luZyBmcm9tIHRoZSBRRU1VIGRlZmluaXRpb24gb2YgU2FwcGhpcmVSYXBpZCBDUFVz
IGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0LzdlYjA2MWIwNmU5N2FmOWE4ZGE3
ZjMxYjgzOWQ3ODk5N2FlNzM3ZmMuIFRoZXJlIG1heSBiZSBvdGhlciBmZWF0dXJlcyB0b28gbWlz
c2luZyBidXQgd2Ugd2VyZSBwYXJ0aWN1bGFybHkgaW50ZXJlc3RlZCBpbiB0aGVzZSB0aHJlZS4g
U28ganVzdCB3YW50ZWQgdG8gdW5kZXJzdGFuZCBpZiB0aGVyZSBpcyBhbnkgcmVhc29uIGZvciB0
aGlzLiAgQW55IGhlbHAgb24gdGhpcyB3aWxsIGJlIHJlYWxseSBhcHByZWNpYXRlZC4g8J+Yig0K
DQpUaGFua3MNCg0KTWFuaXNoIE1pc2hyYQ0KDQo=

--_000_PH0PR02MB738400F34A65A61D2D843F44F6112PH0PR02MB7384namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6b2ZmaWNlIiB4
bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTp3b3JkIiB4bWxuczptPSJo
dHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL29mZmljZS8yMDA0LzEyL29tbWwiIHhtbG5zPSJo
dHRwOi8vd3d3LnczLm9yZy9UUi9SRUMtaHRtbDQwIj4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPG1l
dGEgbmFtZT0iR2VuZXJhdG9yIiBjb250ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQg
bWVkaXVtKSI+DQo8c3R5bGU+PCEtLQ0KLyogRm9udCBEZWZpbml0aW9ucyAqLw0KQGZvbnQtZmFj
ZQ0KCXtmb250LWZhbWlseToiQ2FtYnJpYSBNYXRoIjsNCglwYW5vc2UtMToyIDQgNSAzIDUgNCA2
IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6QXB0b3M7DQoJcGFub3NlLTE6MiAx
MSAwIDQgMiAyIDIgMiAyIDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseToiQXBwbGUgQ29s
b3IgRW1vamkiOw0KCXBhbm9zZS0xOjAgMCAwIDAgMCAwIDAgMCAwIDA7fQ0KLyogU3R5bGUgRGVm
aW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3JtYWwNCgl7
bWFyZ2luOjBjbTsNCglmb250LXNpemU6MTEuMHB0Ow0KCWZvbnQtZmFtaWx5OiJBcHRvcyIsc2Fu
cy1zZXJpZjt9DQphOmxpbmssIHNwYW4uTXNvSHlwZXJsaW5rDQoJe21zby1zdHlsZS1wcmlvcml0
eTo5OTsNCgljb2xvcjojNDY3ODg2Ow0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7fQ0KLk1z
b0NocERlZmF1bHQNCgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0LW9ubHk7DQoJZm9udC1zaXplOjEx
LjBwdDsNCgltc28tbGlnYXR1cmVzOm5vbmU7fQ0KQHBhZ2UgV29yZFNlY3Rpb24xDQoJe3NpemU6
NjEyLjBwdCA3OTIuMHB0Ow0KCW1hcmdpbjo3Mi4wcHQgNzIuMHB0IDcyLjBwdCA3Mi4wcHQ7fQ0K
ZGl2LldvcmRTZWN0aW9uMQ0KCXtwYWdlOldvcmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPg0KPC9o
ZWFkPg0KPGJvZHkgbGFuZz0iRU4tSU4iIGxpbms9IiM0Njc4ODYiIHZsaW5rPSIjOTY2MDdEIiBz
dHlsZT0id29yZC13cmFwOmJyZWFrLXdvcmQiPg0KPGRpdiBjbGFzcz0iV29yZFNlY3Rpb24xIj4N
CjxkaXYgaWQ9Im1haWwtZWRpdG9yLXJlZmVyZW5jZS1tZXNzYWdlLWNvbnRhaW5lciI+DQo8ZGl2
Pg0KPGRpdj4NCjxwPkhpIEV2ZXJ5b25lLDxvOnA+PC9vOnA+PC9wPg0KPHA+V2Ugc2VlIGZldyBm
ZWF0dXJlcyBsaWtlIG1vdmRpcmksIG1vdmRpcmk2NGIsIGNsZGVtb3RlIGFyZSBwcmVzZW50IG9u
IFNhcHBoaXJlUmFwaWQgbm9kZXMgYW5kIGFyZSBhbHNvIG1lbnRpb25lZCBhcyBzdXBwb3J0ZWQg
aW4gaW50ZWwgbWFudWFsLiAmbmJzcDtCdXQgdGhlc2UgYXJlIG1pc3NpbmcgZnJvbSB0aGUgUUVN
VSBkZWZpbml0aW9uIG9mIFNhcHBoaXJlUmFwaWQgQ1BVcw0KPGEgaHJlZj0iaHR0cHM6Ly9naXRo
dWIuY29tL3FlbXUvcWVtdS9jb21taXQvN2ViMDYxYjA2ZTk3YWY5YThkYTdmMzFiODM5ZDc4OTk3
YWU3MzdmYyIgdGFyZ2V0PSJfYmxhbmsiIHRpdGxlPSJodHRwczovL2dpdGh1Yi5jb20vcWVtdS9x
ZW11L2NvbW1pdC83ZWIwNjFiMDZlOTdhZjlhOGRhN2YzMWI4MzlkNzg5OTdhZTczN2ZjIj4NCmh0
dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0LzdlYjA2MWIwNmU5N2FmOWE4ZGE3ZjMx
YjgzOWQ3ODk5N2FlNzM3ZmM8L2E+LiBUaGVyZSBtYXkgYmUgb3RoZXIgZmVhdHVyZXMgdG9vIG1p
c3NpbmcgYnV0IHdlIHdlcmUgcGFydGljdWxhcmx5IGludGVyZXN0ZWQgaW4gdGhlc2UgdGhyZWUu
IFNvIGp1c3Qgd2FudGVkIHRvIHVuZGVyc3RhbmQgaWYgdGhlcmUgaXMgYW55IHJlYXNvbiBmb3Ig
dGhpcy4gJm5ic3A7QW55IGhlbHAgb24gdGhpcyB3aWxsDQogYmUgcmVhbGx5IGFwcHJlY2lhdGVk
LiA8c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDsi
PiYjMTI4NTIyOzwvc3Bhbj48bzpwPjwvbzpwPjwvcD4NCjxwPlRoYW5rczxvOnA+PC9vOnA+PC9w
Pg0KPHA+TWFuaXNoIE1pc2hyYTxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
Jm5ic3A7PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwv
Ym9keT4NCjwvaHRtbD4NCg==

--_000_PH0PR02MB738400F34A65A61D2D843F44F6112PH0PR02MB7384namp_--

