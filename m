Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F95C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qQ-0004Zx-6U; Wed, 15 May 2024 03:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qM-0004Yn-Hb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:31 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qH-0000pt-Q9
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757265; x=1747293265;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GKIOVj4563Xwg5yAi0Ofm5P6tTAe9BSIi+5+5GummPQ=;
 b=iIspgF5wDixkr3DbFsWAkLjETNuQCCMvPy7o7bqCPzP1VcFUIDln0c02
 ol/JSvzMfFQRCsWRWRXRiGFit4vsdkEB/LVIzgN4wW/2gDyExWjhF7Nq4
 Cdr6gpapywv8Z3O2Nq2BhYd0+iM+X04BjASCR7ZZS2v779U6clv5XGHba
 rV4Z3atXL1D2vZVV2a5mho8AP1jPE5oPLn+rQvLYUZXXDpTOmTraKjXua
 xxwfjwaO0y8oYiromEfkHSjleIiNghSDjV2BhBQGvYiqHyll6ZjqiElkn
 pBP9bAmk8ntxTEindfEo8xiuc2yPXybjRZk3FYKWopBGaqWrWisjdnnvw A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12635438"
X-MGA-submission: =?us-ascii?q?MDHRUPpkh4kGvzUy8xrEy9SzgFOTzzfPzUDYC0?=
 =?us-ascii?q?iO0IpoLqiR9lNOfLs5gFLDNjCuWnLdz87SXniAhr5JHl2vgSGWfBzg3t?=
 =?us-ascii?q?k9mzfBM9V3Enr4R94y3kOQ9DqsLa6sIrMDZ7saiZxXthplUNW8W/mkqv?=
 =?us-ascii?q?iYt3j4RARfLY9RmPMoR+IdRA=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsfBInf5XmLssGOsNhq4teGLSx5MJGV108U4x4jzsT1e5q76c7LzrZQzIrg4FH3izO5Fnpp9gcaGHiDFE1lMm8Pz7IyBA1pQ9w+JUkAcoDHSv536ZG85OW+vlg7S8xFU0yEUouMJ/t0FXEOfgxeyfTRyXUfU7V+0MagswRC6DywgOiuEPCGXRrkQodcsEPjJL8k/jnOnqLzJ55cnn5LycIaBXHO5UtWivobSca+MFYDjG4rTOAJ+GnZJFIZTHAqBCuniwRos6jwvaPs7Bl1RcS5I6AJcYR5PX3mcBW1FbkLLnxcoejfWP/NBa0cjM4ZbQyOf/nvf6TYaqCzeFdhwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKIOVj4563Xwg5yAi0Ofm5P6tTAe9BSIi+5+5GummPQ=;
 b=cH5qPvwwB+xn3znXguiPWrREbYlEk1Ih3/bS/AN0G3yRb+PI4mF33HiiHdtwF0YpJpbKw8U28kf3LG1UGOn/pD+Bg7VBBVU0LGZgP6p5BWCRJRxmzy3zbZ2LGo7pmR0EPfDlm28k8aum7ko5FHMRXZLl8KezrocKzhd3siwSPD0OHe1Hp9Lpy5xD/qMRmO20NLeCpot0m4YCKOe74MYMzsw+HvR8jAQfdNSkBrp0H7bC+gvNKaA41LA949zwQm2d/Tqm9U1bA/azfKbJnavRvRabR6WDUj7JewxLvrw4xgxIIRZ6itUWMNYQZwvXWGYNk7fnDfOs7BtAQubJWSgQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 12/25] intel_iommu: add an internal API to find an
 address space with PASID
Thread-Topic: [PATCH ats_vtd v2 12/25] intel_iommu: add an internal API to
 find an address space with PASID
Thread-Index: AQHappd/JvyZoFH1rEa1gdjZ3Mno9Q==
Date: Wed, 15 May 2024 07:14:16 +0000
Message-ID: <20240515071057.33990-13-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: c35d33fb-7499-4b54-b1d4-08dc74aea1f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dzQxOXB0UWFwZWpzTVpVWnF1K2VrbWNpMENVUUptZjdpbGw2UlNNUmxuUlIz?=
 =?utf-8?B?TlBjOTN5M0V0cklnTVFvYVVWMFJGQkRXZUQ1WTU4bDNJYWY3UEdHSVh5Wndl?=
 =?utf-8?B?RG4vdWc2aHJ0WWdOT0JxNUl2NTNEdWplVGRjSStDbk44MTR6cGFGVXh3UHM2?=
 =?utf-8?B?ZnNFYzF2NnpTYTd0UFA2Zm9hNjF5N293cXEyUTBjSlJlazBZeFgrRUZ2YTBt?=
 =?utf-8?B?cFhFeWEwSGhoMi9Yem1ScGVPWEVQZkt3ZFJZTjhSNStDbEM2RGpkbzB1dHFN?=
 =?utf-8?B?WVhMQm1GOFEya1Rka201b1FoTEN2U1VBZXdHdUw3ZERrMldTZ2Fack1vb054?=
 =?utf-8?B?b3lXNDNzSHhvVGRNU05WNFgxMnZGV3NkY0tzREtlejl2VmJ5SitXaStGMjI3?=
 =?utf-8?B?Q29oeHYzSDI0ck1xL1ZnY1RFVG05M0d0OWNnbFpKZ29CUmdIUmNic3N4MDlN?=
 =?utf-8?B?QTdTSkh3dDNKTVIrQVp1cVBheTIvdzEyM3lUNkovd3lBVEJVNHdLUzdXOG1G?=
 =?utf-8?B?bUNRUmJrem1xSFRWWVZIVlN0UkdDbWRicXlyVHRsMnNnbVNSUkQ1ekYzR1dm?=
 =?utf-8?B?RUFSTnJoRGpEUE9DK3IxeFZFUHJFVCtjQlhueEFORVFBcGUwV2M3NUlzalA4?=
 =?utf-8?B?TWoreWluVWNUSzRvTlRQWVdYZWx5QUxPMW5OSmFFYm9VNzV4ajdKNUZoR3ZE?=
 =?utf-8?B?aFM1eWhRTG5vTXhVYStxb203UWtueGpIbTVoaXdkNDJGSy9jRXZUZEd5cDRy?=
 =?utf-8?B?MHROZ0tsQllEV0lyZUEzOGlTQzA5WUpRNTY5U29OZnViU3hjQUgyaDByVklX?=
 =?utf-8?B?UWxFVmIyNm5MSUpnQXQvS0JTZFZhM00yNnJ5U1Flbnh6RkVoR0lyUTRDTUhz?=
 =?utf-8?B?NyswaHBsK3hCNnZzcWxYelVONi9EMnBLR2lKYlBOZnhXOU83ZUNVY2dyNnVt?=
 =?utf-8?B?TjFDL0VnQWtWWXlKUS93SWExWE9KbGRsK3BzM1BYVzRDTERTVHl2b1l4WEJU?=
 =?utf-8?B?VWZmTGEwWGZYN3JIcEJQbjZvVllyK2ROZG9zKzBFbVFJLzRxdkRxcWxod01S?=
 =?utf-8?B?S2ZScVI1V05GNzZjU1dKQXJjdVE3aC85aUhiQjIyLzBIQzhJd0pjcGQxOGdi?=
 =?utf-8?B?ZzJEMDFEMFlSV1VtUURRWXgwV2VsbkhQWW4ycllXNXNRdDlKTUtmYk5RTGRZ?=
 =?utf-8?B?UjUvVnBTejl5VkxkbDNpNEFwMzByTGdhTEYrNlB5aTh4YU5MdEdZWWZlcWVa?=
 =?utf-8?B?bVVLcUxEQTdiekxRVFhVYys3V2M1dndvTlJHUzZzYlArVFNGMXJVMTdXTzZw?=
 =?utf-8?B?TnJ0eU5aUjA0MmFYc3ZMVFJHcjlrTDU4dndLLzh1a1FUL0lwWVlCOXFSR2VX?=
 =?utf-8?B?ODM0M0RnajlRQ1hqRlduSUExOFJIQUFnUU5kODNLZ0pkYVdqNitoRGh1SXdE?=
 =?utf-8?B?VW1OVjcwcjduOFhHNktGekJmcFkxRzlSY08yclBoVE9YbWJxdVJHajFmSFYz?=
 =?utf-8?B?YWlJbkJ1bkdpVlE4L3paUUo0N2ttQ3BaMWxvTTRqME9pa0krS2NOOUszWTFY?=
 =?utf-8?B?ZEZXbVY0VWp2VGZ6RmNvQWprdVNBNGJCMFlkZVg0V21zdVR0R1FIVStONTk3?=
 =?utf-8?B?L3VDZGZIQWVibzRNRmFMSWFYb0hJS2NveVFSUnp3NmY1em1qMzBMVEVkYjE0?=
 =?utf-8?B?RTVTbDlsM2gxMXFFUHRiSE9ZMnpiOGlCRVUrUWg1SkIxZU5OMlNCakhUK2Rj?=
 =?utf-8?B?aFRDVTJzbXNNUnUwTjdhRlZMbkYxNkhRNjVuei9xeWFQMkN3QlZYSGFKTzZh?=
 =?utf-8?B?c3FFblZheFJPeGpSNVdWUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjAwTkNuZnZEeWRQbjc2bTBXNXlRVTRlL0hUUnIzb2ZYNDUxQ1R1UHA4QUgx?=
 =?utf-8?B?UFNZeHczNlFGdHY4T2xXNytqRFZFRGVlbVBoODRFSW5jMURKdmhKWENVUVg3?=
 =?utf-8?B?M2NxS2Z1TlVtYjlLdUhVbFNRRyttWDZiYU92WEtwazdiYTd0K21ZT21XdzhR?=
 =?utf-8?B?UDlzTDFmR3BQbG1ONVBnRjg0ckRoMUpockxaVkVXZGtRT2JpcXRYSnBIRElF?=
 =?utf-8?B?eXhxNnIya2krTkowcFUyU0FRK1BJYXhlQmNMUGwxdTljdnZ5eU83NXZRT0lM?=
 =?utf-8?B?YWR2UmY1VVV3YjhvRG5uVnU2NE5lRldGTEhRWDE0d1l6MlFvem9odWRMVC81?=
 =?utf-8?B?d3Z4MTZXQ0thaThoUFowbFJrWXF3bEhxRVNkMmpCK240REV5VXBHZkVRTGZp?=
 =?utf-8?B?WFFUemc1eThCc0o2aTVxdC9wZW1RaU1UdldxWU5zdXFPV1ZmVUdIK2lBOUdK?=
 =?utf-8?B?aVlHa2NKc1N3T0tjRGN2L3BhNE5BMllFN3UrQUFRVHZsMDNudGRZTm93c1No?=
 =?utf-8?B?U0NjdWhNa3k2MUZWem50Nkw4WSs1ckVlbFRGS2VDWmxvL3V2TEkzeFJMOEI3?=
 =?utf-8?B?bGJtYzRRVHdZQjJXdHBOSlVuRUxtUCtHR2ZOSFIvam9MWFFsanlpZlpDM1V3?=
 =?utf-8?B?dFJRc1ljVUh1aWVYYTVzcEFhT2VQU2VRd2owbFFqOWJ4ZWxLUCtuQk5CdC85?=
 =?utf-8?B?dzhjYzJvZUtlbXF1YmhEYWplRSt1N1YzcTh3dWNqbmpuTmFqRW1jQjd6c1BH?=
 =?utf-8?B?bTlLTk1HdVp6Z3k2aUpCSCswNDl0dWxlRkNKaVFaVnJFUit4T1NDQnBDbU1v?=
 =?utf-8?B?M0tXaEZnU2hPSEVkRmpDQWtxZm1mL1h2OG40Ky9uTGtoNmVkR0JNSS9rdlRv?=
 =?utf-8?B?ZUwxcHd2MlhROUYwemcvMWRIVHYwWGtNUTNwRERZeHdrWTRPS1NRdUtNSG92?=
 =?utf-8?B?bXk2SkJIUHRFMFFPUUwrSFltazcxdXNIYWltOXg4TVVxRlJ2RlJDZzkzQmNm?=
 =?utf-8?B?Q2h4bGFaUzJZdTZ0MHRneW5qa2d3ZHBZb3A0THZjTXdYRkRSQng2cUloVkIr?=
 =?utf-8?B?d3V6bGxtRDNqZVJ4bE5xRVhzQTJRQk0zaHVvUkpDWUpqWldKeWVMcUQ5QXkx?=
 =?utf-8?B?Tmc0Y0Y2UFI2bHN3RnV0N1B6REJCOEVOdm1iTUZjZ3VJRUdyS0RYZzcyUU81?=
 =?utf-8?B?dFZ5U2w4dHUrcFFva0RabUFQL3pwYlVTdlJRQTBxRVRXcnVuSnNPdUF0OW5I?=
 =?utf-8?B?Y3g1T0lPSmRTMlZnNzNRSVVuOWgzQXU4WGNEVWlUN1BjUndSeU1vbFZ3UTI5?=
 =?utf-8?B?M1lIdGtFVEJsU2FLcTNRbWJrY3o5eXFYQ3QyVjJpVWlhMy9JTElkbVpxOVlQ?=
 =?utf-8?B?V0RBeGJiMDZSajk5bkUwVE4xVGFpdHlXV0JoR0Q1WVBYK1pYRVJTckpUWVpk?=
 =?utf-8?B?T21JaVJiRmkrWUt5STlMZ0txbG9GN0M5UTZ4dktoWVh2M0lIODgvSUl3MGNS?=
 =?utf-8?B?OHZBZExQNHVMS3dOcnJ6bVdDMjFqakpKMHBwNkE1V2RqczRUR0FqWEZWNHMv?=
 =?utf-8?B?b1pkNExzZmtodUlPZm5TS2lsMVkyUll1YlVlWURrR2VNc0JaVmxsbDU0VkFE?=
 =?utf-8?B?d1NHZ0g3azFvMVAvSmhUZTUwVWtld0c5YTYrNmF3bmQ1cmxSVEhWUkYva2VX?=
 =?utf-8?B?Q05PRjhyMlRxTFk3TVlWNXQra0lJd1Vod3hIRDE3ellkQmVBN25VUE92STMy?=
 =?utf-8?B?ZmhEWElnTS9EMHlyWnVHaUhPZy9mTUhud0pPa0Jxa3ZESXNIR1gwc3B2Qmti?=
 =?utf-8?B?R2N5U1pDZURjWTdKZm9HaFFtck5vYWZOYS8rRG94K3I0U1JadjBySmZkbi9x?=
 =?utf-8?B?MXVLeFRPNzhnNEY1VnhqN1VpQzZ6RVpFbVRESjZrdTBMSmhIYWlzY3hOdWgr?=
 =?utf-8?B?VEFkVjlacUVXUjR2MVUzYUxlRVJhcGVocnh1K201NkhqcS92bzl5SFc0elFj?=
 =?utf-8?B?aW5vT3dUTlZxYU9JUWpPQ3kyOEtFRTl0akphbEtvWG1USlhZc3hmMlJvcVZC?=
 =?utf-8?B?TWgxSlF6OXZvd0VDWlJiMXM0blgwUTlvaHljTTRMYXJoVG9ISnkrUGFKenk1?=
 =?utf-8?B?RFY1WTdHMkd0TXh3RmpjQVRTZld5Q3pML0JQblcraFhBUmpCNVZtN3YybTFP?=
 =?utf-8?Q?+WjKb9PsaUqA33qjAMwAziE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF59DFA9EF05D4FB801BC9E1BA70981@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35d33fb-7499-4b54-b1d4-08dc74aea1f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:16.9654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSYfXRee8q0HRwgvZKfIQENzSPcRCE8BV8TpDlkSegDh6xOEoL73PmDpL+xBsEZQ8uLncWzQMO+AR6Ckgj6SrVxH2K3O9rniW3WtNBjHvY9UH1dE+8LM2x4+1KYzt4he
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

VGhpcyB3aWxsIGJlIHVzZWQgdG8gaW1wbGVtZW50IHRoZSBkZXZpY2UgSU9UTEIgaW52YWxpZGF0
aW9uDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0
aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMzkg
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCAzYmI0ZDM4NWE4
Li4xNjYxMDM1MTBlIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC02NSw2ICs2NSwxMSBAQCBzdHJ1Y3QgdnRkX2FzX2tl
eSB7DQogICAgIHVpbnQzMl90IHBhc2lkOw0KIH07DQogDQorc3RydWN0IHZ0ZF9hc19yYXdfa2V5
IHsNCisgICAgdWludDE2X3Qgc2lkOw0KKyAgICB1aW50MzJfdCBwYXNpZDsNCit9Ow0KKw0KIHN0
cnVjdCB2dGRfaW90bGJfa2V5IHsNCiAgICAgdWludDY0X3QgZ2ZuOw0KICAgICB1aW50MzJfdCBw
YXNpZDsNCkBAIC0xOTMxLDI5ICsxOTM2LDMzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfaXNf
aW50ZXJydXB0X2FkZHIoaHdhZGRyIGFkZHIpDQogICAgIHJldHVybiBWVERfSU5URVJSVVBUX0FE
RFJfRklSU1QgPD0gYWRkciAmJiBhZGRyIDw9IFZURF9JTlRFUlJVUFRfQUREUl9MQVNUOw0KIH0N
CiANCi1zdGF0aWMgZ2Jvb2xlYW4gdnRkX2ZpbmRfYXNfYnlfc2lkKGdwb2ludGVyIGtleSwgZ3Bv
aW50ZXIgdmFsdWUsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncG9pbnRl
ciB1c2VyX2RhdGEpDQorc3RhdGljIGdib29sZWFuIHZ0ZF9maW5kX2FzX2J5X3NpZF9hbmRfcGFz
aWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEpDQogew0KICAgICBzdHJ1
Y3QgdnRkX2FzX2tleSAqYXNfa2V5ID0gKHN0cnVjdCB2dGRfYXNfa2V5ICopa2V5Ow0KLSAgICB1
aW50MTZfdCB0YXJnZXRfc2lkID0gKih1aW50MTZfdCAqKXVzZXJfZGF0YTsNCisgICAgc3RydWN0
IHZ0ZF9hc19yYXdfa2V5IHRhcmdldCA9ICooc3RydWN0IHZ0ZF9hc19yYXdfa2V5ICopdXNlcl9k
YXRhOw0KICAgICB1aW50MTZfdCBzaWQgPSBQQ0lfQlVJTERfQkRGKHBjaV9idXNfbnVtKGFzX2tl
eS0+YnVzKSwgYXNfa2V5LT5kZXZmbik7DQotICAgIHJldHVybiBzaWQgPT0gdGFyZ2V0X3NpZDsN
CisNCisgICAgcmV0dXJuIChhc19rZXktPnBhc2lkID09IHRhcmdldC5wYXNpZCkgJiYNCisgICAg
ICAgICAgIChzaWQgPT0gdGFyZ2V0LnNpZCk7DQogfQ0KIA0KLXN0YXRpYyBWVERBZGRyZXNzU3Bh
Y2UgKnZ0ZF9nZXRfYXNfYnlfc2lkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3Qgc2lkKQ0K
K3N0YXRpYyBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9nZXRfYXNfYnlfc2lkX2FuZF9wYXNpZChJbnRl
bElPTU1VU3RhdGUgKnMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQxNl90IHNpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQogew0KLSAgICB1aW50OF90
IGJ1c19udW0gPSBQQ0lfQlVTX05VTShzaWQpOw0KLSAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9h
cyA9IHMtPnZ0ZF9hc19jYWNoZVtidXNfbnVtXTsNCi0NCi0gICAgaWYgKHZ0ZF9hcyAmJg0KLSAg
ICAgICAgKHNpZCA9PSBQQ0lfQlVJTERfQkRGKHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwgdnRk
X2FzLT5kZXZmbikpKSB7DQotICAgICAgICByZXR1cm4gdnRkX2FzOw0KLSAgICB9DQorICAgIHN0
cnVjdCB2dGRfYXNfcmF3X2tleSBrZXkgPSB7DQorICAgICAgICAuc2lkID0gc2lkLA0KKyAgICAg
ICAgLnBhc2lkID0gcGFzaWQNCisgICAgfTsNCiANCi0gICAgdnRkX2FzID0gZ19oYXNoX3RhYmxl
X2ZpbmQocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLCB2dGRfZmluZF9hc19ieV9zaWQsICZzaWQpOw0K
LSAgICBzLT52dGRfYXNfY2FjaGVbYnVzX251bV0gPSB2dGRfYXM7DQorICAgIHJldHVybiBnX2hh
c2hfdGFibGVfZmluZChzLT52dGRfYWRkcmVzc19zcGFjZXMsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2dGRfZmluZF9hc19ieV9zaWRfYW5kX3Bhc2lkLCAma2V5KTsNCit9DQogDQot
ICAgIHJldHVybiB2dGRfYXM7DQorc3RhdGljIFZUREFkZHJlc3NTcGFjZSAqdnRkX2dldF9hc19i
eV9zaWQoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBzaWQpDQorew0KKyAgICByZXR1cm4g
dnRkX2dldF9hc19ieV9zaWRfYW5kX3Bhc2lkKHMsIHNpZCwgUENJX05PX1BBU0lEKTsNCiB9DQog
DQogc3RhdGljIHZvaWQgdnRkX3B0X2VuYWJsZV9mYXN0X3BhdGgoSW50ZWxJT01NVVN0YXRlICpz
LCB1aW50MTZfdCBzb3VyY2VfaWQpDQotLSANCjIuNDQuMA0K

