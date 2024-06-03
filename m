Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE90C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0k1-0006wm-3Y; Mon, 03 Jun 2024 02:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jz-0006v9-54
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:19 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jx-00071T-7Z
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394417; x=1748930417;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0lj8izfHYem3sgTsQJtxLtGdzGMHztq4df66p0nIbd0=;
 b=VfhILN9JaX3HmJIiiGPzp5W9rHdTQedknny/dHE7aDsT8hnVx6AC4YNx
 2ifTRReGDqLhV2BCe96KsoLIR13oKGHg/rO3AQYNjViuN9AyEJNDk+sUQ
 PYOsijKxWDQJvZuuqm3A1Bvber8HVcE32dFuxwuyrkqL6atf+ie5gjjSf
 tgSvRlE7ob8JrvSyJFkBgr7/EHTqpGrlB/QKWIhFxeex4a1xS9Ln+Pmaj
 f0r/E5rD1ofFNmYpnbCh5X+WNd8JTBtCjvp80dZkE7bcrc8OlPZ293Nh/
 aM23vhkuo46pqvzFirJNaGYkEynKUpFwgtvB9hGjyGb/y+Oq36Ht/HC1X w==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815892"
X-MGA-submission: =?us-ascii?q?MDEChmrP99g/INWBO2XY1sgCHxeEV/KiqAxell?=
 =?us-ascii?q?Q6koXuX9T/M+mhJk3lpgc2+ffTSwFoJvBDS1z7IDFOjntZ3PKDhQBxFm?=
 =?us-ascii?q?8S6m2wWW3uCbTuELFnM6a6M3HKawDEsmH1fOa+VrFt2JxqC/0k84Ml7f?=
 =?us-ascii?q?lAP2nj9nUB04FXClUlNHF4+Q=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAFPidFNeuMP0ATQYweNjavejAtT4wOdEUivUQbDdllDHcY2I9w2x1T4y1MMbHYkHGz0OO6U7Vy2g6v5gAXITyxybm+ISS973BynU00OKyUsEHExjx7LgcZYTtYJqu3IQh3A1+SW8aBTF+ppt4yib+nVdZavQ+bRelL3M7wDr2E6P5c3+6freExlqs+cC6EjLvNxIOD6vEymhUZgsKxR0SBvwBXli0a7NQErp70gnd5LEVeHeuASB/C0aHwYhowP7NW/aKGNaZd16Z6r846/BX1IiVTTDS4Q5VF1vTVcX95g4UuF/BmD9sygTkGV7/IGX3h0TwjxcSoHNGgSGnsM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lj8izfHYem3sgTsQJtxLtGdzGMHztq4df66p0nIbd0=;
 b=TmlDkJotorBTBDG2rX2dI4goXFAOc+1jW3oE9MkQMxstyoZQvHJDaDgcKW7379r5JSmxYy7/SVxMQRq2UTpn4X9CtD1IfPknJ++15NKvwc4AaaaGst101dkvo2Q9N80Pm65yB0+QVAw56qxAIxK/63egK/Aep7AkJj0UD6OyesE3egzMSG15yURd3qfhnsbN4Vh1aQZ+qYo00xCy0OyWWLVKc7Q+lMbQksD4fT8+TDcNAjEqysPA9kTfhyHKsSIk6k/U8Ri97/ZG2bBrJK1EH6h2RRUUejGXgtDaWCklR7SwiZHzd0V73OcagM/X1wZ3KcmjGEWg8GDewO45apkbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lj8izfHYem3sgTsQJtxLtGdzGMHztq4df66p0nIbd0=;
 b=Y/KCOXre9s/dwJPiFOQeubG2FEQppvCQhRqxqw/ViAzM56dH0MOLpg6EQU5CiIFYJvZ9kBZ9socp4FLhWeSGizpS446ecvCYmkFmqpmL93Aq1eXlHusD/xXRUChahEdgI6F2Ix2IAMIOSKTYYH0v0AOkVVWYfec0QLogbiZpJi0pnXKYS38GzAEp+BMaAcmyJAoLzHzBbJMxsBwXZRplIcs0s1K9EkxTX3lefIwHEOx8CCox5lavGn1qX+UivNkA5QnnavEDFDPzZ7ql/Fq0rSExMAfCp7iySOKSLB3lCdZbQkIfgHA4ZXRgumSLrsAHOUcwcEz1rccQ11ieteBs5Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8192.eurprd07.prod.outlook.com (2603:10a6:20b:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 05:59:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 22/22] intel_iommu: add support for ATS
Thread-Topic: [PATCH ats_vtd v5 22/22] intel_iommu: add support for ATS
Thread-Index: AQHatXtByK+MPvyRxk6nyjnkNV88Ag==
Date: Mon, 3 Jun 2024 05:59:55 +0000
Message-ID: <20240603055917.18735-23-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8192:EE_
x-ms-office365-filtering-correlation-id: eda0d791-07dc-4726-05fd-08dc83926469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dUhWUjd4QzdVQzRGQ2ZiYXM2NnhySlVia2p5cUJqS3p4Wk8xTEcrQ09jb0Zx?=
 =?utf-8?B?aGt6Z2FsckdHbkdWYlMySDVxVEVIUDNENjhqN2pZQUVUcDd2ek9oWk9IT0N6?=
 =?utf-8?B?UmZxWkZDZGtpbWI5L1F3dnJ5c0hydkZQZEdEaENvT0JmU2cwVW9zZnliN3Ri?=
 =?utf-8?B?WGJuaCt0dnFjcjY5TEF4eFJFd296blg1dlR4c0FRTmtpSjJqWWRvNlFsSUkr?=
 =?utf-8?B?RVMwQnVRZ0cyNW05TitBeGlHTHd1eHFrU3Y0NENjYTVlSUFLYzllYmVnZGxW?=
 =?utf-8?B?WVhubnFvTXpvQUtzdGNOZFJxMmE4dkMzNHZLOWNTN2hSVlFsd0lWZlZPanJL?=
 =?utf-8?B?a3RPTXlsVUphSTlNYWszUWFRVld3RmgvbTkyMU9WOFJzYmh1bFh4MVVJeG9t?=
 =?utf-8?B?TUJEd1VyT1JFem9wbFpaWElaZ09XMmhUSDB4dFNUZ0ZsekMwRDB2dUEwTXBk?=
 =?utf-8?B?eTBlb29JMExHOVY4enhoZ2prRHJObGd0RE5QQktySlh2QWFyNkRUbG9vOGZ3?=
 =?utf-8?B?VmpjZnJKSkFVTTRSVnhMNXRHUXJwc3l4ZWRVOVdpRkhwUUhTaWprRlRZaTh5?=
 =?utf-8?B?bTNYdzVDOVR5bnU1Y2x0TE5wZW1WYllMQ1dqVHZMQTBVOFNMM2VHeUZFZkVU?=
 =?utf-8?B?clpFTXF2RkFtUUdQMU9sRWpnOGJtbDM3RlNaQnR0NGRNV0NWb2V5M0t1czNs?=
 =?utf-8?B?Z1hvSlZjNUNhcDZqYkFLdFM5RHgwenNub3JYWFR0RTFZVllIdXVBeWlPbUxS?=
 =?utf-8?B?NDZZaDU1cmVpczk0a0F2QzNhSS84UzRidWNyOVlZS0dZemQydlNyNlhhdHp3?=
 =?utf-8?B?SythV21zNHpEZml3cmRpVzExWk1iSE9JUFVkTjdzNXRCYmVYMTg1MHVkbUc3?=
 =?utf-8?B?eVU4NjYwL0JJdHpVd1JDMUtBSzZoMTRjSmVrTUdNcG1Ec0hTQWVVYWNiTGk0?=
 =?utf-8?B?UGlPbFdwQ3dhK1A0ZEV3WnUwSnBvcGdyV3JVZkpDL1F6NGZTQVRoaUNSSExa?=
 =?utf-8?B?NXpHZ1ZYSXpsQWJhOStYcEo1Vjh1RWhHWTR5czVMUVRFT0dVeUVuNWU4Tndw?=
 =?utf-8?B?SlU5MmhxZTZscER0b2lmT3QrK0xYaWd2N0JaM0VYam94M0dVa2tvZkJPTWEw?=
 =?utf-8?B?ODF6MGFpd0Zwc1AydGZ0QkU4T0I4VG5ucTY2VFFSajlwcm9IY3ZGTXdTRG0x?=
 =?utf-8?B?VWM1bVl4WmU2a2JvbXMvSjlyUDJkU3NYbHhqVE53anI4VUhpeERwdUo4YXBv?=
 =?utf-8?B?cE1FYjZ2YXhhR1lodHhCS1kxcG1ubjAvOXByTmV6dDRHVU1rM2NwdXZDQjVa?=
 =?utf-8?B?Z2R1dmFvTXhnUjVKZHRYNlZpTTRrbHF4ZDBNS0pMa1dvQ21lMDB6UWZOb01v?=
 =?utf-8?B?b01DOTFlemhsUjJSVXM0eHRUL2U5ek94cHNVWUlGbzgyVzE0T1A3SDkzZ2J4?=
 =?utf-8?B?YS9uc0hXV3o4QlgzbEtsSi9ubmdYS2NtU0FjT0JyWGNENVhyM0dTVURoV05n?=
 =?utf-8?B?UkZoVkpLeHZsYzZGRnpZUUN4ZTZiYlNUWitJSmdNSFBqVXlCZWFpdVRSSER2?=
 =?utf-8?B?VnBOKzFKZUhwSlN0NlZ2eUk0YXhMMFZaWWNIUWJoYkRCTGxqZDJTS1pCYkVP?=
 =?utf-8?B?RDVubUhraE9HRTMzaEYxMG1mdHozN2djbkxCdDc2aCtnVm81c0RnZHJYRklr?=
 =?utf-8?B?bUQ4WGtRaFRqUzJrZUo4bjU3bllDUkRIbGZtNWNwd2VuQVJGTjBJV2tlNEV4?=
 =?utf-8?B?WnlhSTYrbVcvZEY2VW10SHJzekpGWTlCd0E1NFNqenBWWUJ3UGI4QkhWZUVT?=
 =?utf-8?B?UEp2RDcxMWVwZHA3ZGdqQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0RNLzRMSytSb1BUVTZwWVNpOStTMmFNdjJxWVo0bWwzYTc4ZlJRK2VZTVVQ?=
 =?utf-8?B?NFBMWGxkNDd2OWV4WjdiTXd6UEpGNEFveVJYdXhKQTlIbThzWit0QmRSRlE4?=
 =?utf-8?B?cUltd1Exei9GNVhQb1JlV1BGR2lsMHVOTFlDWllGVFREeld5TW5GL1ZQZklt?=
 =?utf-8?B?Mi83c3NqUXB5STdnVVhuRVBRTVdCUEIyeHFnZEdodWc0L0dFdG1XeFUvZGJ1?=
 =?utf-8?B?NzBqMTlXakt5QlBiWkY3L1VpcmxvY1NUblV3b3VRTjc2Ym0wbmNndEg5c0VL?=
 =?utf-8?B?bU02Y0pjOU05aHUrUWVVbkhyMU44RENpM2JZcFFqNnNlb2pBYk1oNnNxd0xV?=
 =?utf-8?B?SkJwYUgwbnVTTGowcFFvQ0JmdkE4Ymc3Q3FNRS9aSHYzb29vL3Q2YzZvZWxV?=
 =?utf-8?B?VEFDOTF4bDdoOE85bzlWM2xPOUhneTRZVDVyaHRoOUtDaWxLNWxkMnFXUG1V?=
 =?utf-8?B?Z0FBUkM5WFdMS1Y5Z0cxYWZ6QVpYTjFDWWhQOEcxWGJjM0xOYm4vN3lyemxx?=
 =?utf-8?B?QlltQkQvYy9OcGFONVNlTEROSmoxL2YxL1lvNDVIYWVRZ2w0bmF5cy8va1VL?=
 =?utf-8?B?MXR0bktoZEtHNkJCL2RZaElpSUZPbWwrMmZaU2NUc1k1V1VqbHp6bXpWZDJk?=
 =?utf-8?B?ZjFObkJObmk1OXEvd3dlT1ZjUlBPMEpNcjBhMXVZMEpuUDNvZllsVmxmWkdH?=
 =?utf-8?B?ZGptY3FzcXYzdEY4bkVhbjl2bVZ4U2NMZXZUMHIwTVg3c0NiaG5LZGdvUFNa?=
 =?utf-8?B?NjArYkduTmdEWmtyb1liZ0N5ckVPeU93aVNQejJ0a2hHYlpRV2FoRVlGVHBB?=
 =?utf-8?B?K0tjaDRncjR3WHh3OFY2bWdLc3FMOWFvTGV1WDcycHY5Mk9RZ0F2MXRkd0ZB?=
 =?utf-8?B?bFcvZ0cxRTFaVlRrb2E4SWgvVHc3NUlFTzdBQ2RteU1ndWlIRGYrQVVwWGgz?=
 =?utf-8?B?ekJCYytad2ViNEk2NUpYRkhlQitHY3VxQUl2aE8xUThoQjBXVG8vaHhZTGVl?=
 =?utf-8?B?aUlweGxsWWljUzN4M0I1T2VzN0UzQmVod2V3SXozblNsdTk3QkxyVFNRUmlD?=
 =?utf-8?B?N0lTYUJoNTRVcjA0R0ErZ0pwdFA5dCs2TzZicVVoVFo5TTdBVTNFTkJzS0NC?=
 =?utf-8?B?QTNqVWtJN3RIbVZTUGxhVVMwdWVGQmd2TEVBWnRLMHdhbisyb0FJcG45Wndp?=
 =?utf-8?B?TDZTaDRjUUF5N2lZalJVY2k2RHNjbE81Q3ZPdnVlWmRQWW5VeG1qdHNnNFN3?=
 =?utf-8?B?NGhNODE2UDhzNHdSSEtqVjFTRUR5d1NvY2tQV01lYkkzQUlFOTM4enFaTHB6?=
 =?utf-8?B?Q3Z0clNyWm5rcGRPRTNna1VxejRkUkNDcFErRm96MXFZdHNKRU9ycytiOWlY?=
 =?utf-8?B?UGczTjNWM3A1T1VYQzFtZ2JBZzFaYk0wUTl1VG5mb0wxYjZZVDFsZ1hSa1Fx?=
 =?utf-8?B?bHdFOEJzYXd4dmtKVlFleXJ1OU1PeXZNSnRWMFlWZDlrWjZta3huU1lIUkdp?=
 =?utf-8?B?cjBFSHNTZFN1ZjUzMDFJT3hIVFNSZWtyemlOcXRNK2w4T3Q1MXpVcUxaQ2tk?=
 =?utf-8?B?eWRHLzUrOHFiTTNuMkNVRldZZTcyS050aG1XZ0xqczM1Z3o0eVFGTlJKN0lE?=
 =?utf-8?B?ZlFNSWtYNHhhcnlaV2xTQlN0RkJQdlAxQVc2LzI5SDNEWXdKUGZ2YWVWTlVw?=
 =?utf-8?B?MmQzUVBVRFcvK3NkUThucjJJclE3cGJWVmhqZDAwTzNESkx4cms2WlEwM1hk?=
 =?utf-8?B?OHNTalhPYmxGS3ZPRFVLa0FjUzFpSDRFaDhvdHkxY0VaNFQ4TEZhVTgwUThO?=
 =?utf-8?B?ak5rN0V6R1dqZjdWZEdTNUtyMzlYdnZ2MzdCRWQ2cWhSRWxyUmxsZ0NSS0k0?=
 =?utf-8?B?NVRHTjQ2NXBEUWxHQnFsY0FkYWZQZjZBbFY1aGJFMUdsVllOanNHNDlJVGtx?=
 =?utf-8?B?T0lJZ0N6RE9ZVnUrVEdHZGo0MGZDVFUwaW8xSHRIVkRwS2gzak1VTWljTTk1?=
 =?utf-8?B?T09QdHU1T2MxcTVGZ0hUVm9VMmMzMmt5ZEYrNkZyVU9CRU1YaVZBUUozZnp6?=
 =?utf-8?B?V1JwREorL3F4UmpsTFJyTkZGZzBTNStldnhqU1FwaXlLSDFWa2Jlc0tCaCtm?=
 =?utf-8?B?QlRMNHU2NzBHMTN1TDY3RStTbnFuK25Eck1leiswUTcvZE4wSmVCRHdDMVdv?=
 =?utf-8?Q?h2K/r51H1oW8IhiGvhQNyJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC8FD73D46C6B54B942514F7C63666A2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda0d791-07dc-4726-05fd-08dc83926469
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:55.2314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQ0kj8z+50QyRfBBuGdWuMiV/eMp3evroqOVu2sVtX6ozEHDk4SnKxUalWnkT7IXDM4vI7mJjCW1ZoPiEHb2RY7RtoAKmXrfx9sCkHKdOibwAR+XSWUYVtMOhktMdcuP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8192
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgNzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIGh3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDczIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDFiYTQzZjU5YjUuLmQxMjQ0MTQz
MGYgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KQEAgLTUzODEsMTIgKzUzODEsMTAgQEAgc3RhdGljIHZvaWQgdnRkX3JlcG9y
dF9pcl9pbGxlZ2FsX2FjY2VzcyhWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCiAgICAgYm9vbCBp
c19mcGRfc2V0ID0gZmFsc2U7DQogICAgIFZURENvbnRleHRFbnRyeSBjZTsNCiANCi0gICAgYXNz
ZXJ0KHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05PX1BBU0lEKTsNCi0NCiAgICAgLyogVHJ5IG91dCBi
ZXN0IHRvIGZldGNoIEZQRCwgd2UgY2FuJ3QgZG8gYW55dGhpbmcgbW9yZSAqLw0KICAgICBpZiAo
dnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIGJ1c19uLCB2dGRfYXMtPmRldmZuLCAmY2UpID09
IDApIHsNCiAgICAgICAgIGlzX2ZwZF9zZXQgPSBjZS5sbyAmIFZURF9DT05URVhUX0VOVFJZX0ZQ
RDsNCi0gICAgICAgIGlmICghaXNfZnBkX3NldCAmJiBzLT5yb290X3NjYWxhYmxlKSB7DQorICAg
ICAgICBpZiAoIWlzX2ZwZF9zZXQgJiYgcy0+cm9vdF9zY2FsYWJsZSAmJiB2dGRfYXMtPnBhc2lk
ICE9IFBDSV9OT19QQVNJRCkgew0KICAgICAgICAgICAgIHZ0ZF9jZV9nZXRfcGFzaWRfZnBkKHMs
ICZjZSwgJmlzX2ZwZF9zZXQsIHZ0ZF9hcy0+cGFzaWQpOw0KICAgICAgICAgfQ0KICAgICB9DQpA
QCAtNjAwNCw2ICs2MDAyLDc1IEBAIHN0YXRpYyBJT01NVU1lbW9yeVJlZ2lvbiAqdnRkX2dldF9t
ZW1vcnlfcmVnaW9uX3Bhc2lkKFBDSUJ1cyAqYnVzLA0KICAgICByZXR1cm4gJnZ0ZF9hcy0+aW9t
bXU7DQogfQ0KIA0KK3N0YXRpYyBJT01NVVRMQkVudHJ5IHZ0ZF9pb21tdV9hdHNfZG9fdHJhbnNs
YXRlKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVUFjY2Vzc0ZsYWdzIGZsYWdzLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBpb21tdV9p
ZHgpDQorew0KKyAgICBJT01NVVRMQkVudHJ5IGVudHJ5Ow0KKyAgICBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hcyA9IGNvbnRhaW5lcl9vZihpb21tdSwgVlREQWRkcmVzc1NwYWNlLCBpb21tdSk7DQor
DQorICAgIGlmICh2dGRfaXNfaW50ZXJydXB0X2FkZHIoYWRkcikpIHsNCisgICAgICAgIHZ0ZF9y
ZXBvcnRfaXJfaWxsZWdhbF9hY2Nlc3ModnRkX2FzLCBhZGRyLCBmbGFncyAmIElPTU1VX1dPKTsN
CisgICAgICAgIGVudHJ5LmlvdmEgPSAwOw0KKyAgICAgICAgZW50cnkudHJhbnNsYXRlZF9hZGRy
ID0gMDsNCisgICAgICAgIGVudHJ5LmFkZHJfbWFzayA9IH5WVERfUEFHRV9NQVNLXzRLOw0KKyAg
ICAgICAgZW50cnkucGVybSA9IElPTU1VX05PTkU7DQorICAgICAgICBlbnRyeS5wYXNpZCA9IFBD
SV9OT19QQVNJRDsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIGVudHJ5ID0gdnRkX2lvbW11X3Ry
YW5zbGF0ZShpb21tdSwgYWRkciwgZmxhZ3MsIGlvbW11X2lkeCk7DQorICAgIH0NCisgICAgcmV0
dXJuIGVudHJ5Ow0KK30NCisNCitzdGF0aWMgc3NpemVfdCB2dGRfaW9tbXVfYXRzX3JlcXVlc3Rf
dHJhbnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHByaXZfcmVxLCBib29sIGV4ZWNf
cmVxLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
d2FkZHIgYWRkciwgc2l6ZV90IGxlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgcmVz
dWx0X2xlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgKmVycl9jb3VudCkNCit7DQorICAgIElPTU1VQWNjZXNzRmxhZ3MgZmxh
Z3MgPSBJT01NVV9BQ0NFU1NfRkxBR19GVUxMKHRydWUsICFub193cml0ZSwgZXhlY19yZXEsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaXZf
cmVxLCBmYWxzZSwgZmFsc2UpOw0KKyAgICBzc2l6ZV90IHJlc19pbmRleCA9IDA7DQorICAgIGh3
YWRkciB0YXJnZXRfYWRkcmVzcyA9IGFkZHIgKyBsZW5ndGg7DQorICAgIElPTU1VVExCRW50cnkg
ZW50cnk7DQorDQorICAgICplcnJfY291bnQgPSAwOw0KKw0KKyAgICB3aGlsZSAoKGFkZHIgPCB0
YXJnZXRfYWRkcmVzcykgJiYgKHJlc19pbmRleCA8IHJlc3VsdF9sZW5ndGgpKSB7DQorICAgICAg
ICBlbnRyeSA9IHZ0ZF9pb21tdV9hdHNfZG9fdHJhbnNsYXRlKGlvbW11LCBhZGRyLCBmbGFncywg
MCk7DQorICAgICAgICBpZiAoIUlPTU1VX1RMQl9FTlRSWV9UUkFOU0xBVElPTl9FUlJPUigmZW50
cnkpKSB7IC8qIFRyYW5zbGF0aW9uIGRvbmUgKi8NCisgICAgICAgICAgICBpZiAobm9fd3JpdGUp
IHsNCisgICAgICAgICAgICAgICAgLyogVGhlIGRldmljZSBzaG91bGQgbm90IHVzZSB0aGlzIGVu
dHJ5IGZvciBhIHdyaXRlIGFjY2VzcyAqLw0KKyAgICAgICAgICAgICAgICBlbnRyeS5wZXJtICY9
IH5JT01NVV9XTzsNCisgICAgICAgICAgICB9DQorICAgICAgICAgICAgLyoNCisgICAgICAgICAg
ICAgKiA0LjEuMiA6IEdsb2JhbCBNYXBwaW5nIChHKSA6IFJlbWFwcGluZyBoYXJkd2FyZSBwcm92
aWRlcyBhIHZhbHVlDQorICAgICAgICAgICAgICogb2YgMCBpbiB0aGlzIGZpZWxkDQorICAgICAg
ICAgICAgICovDQorICAgICAgICAgICAgZW50cnkucGVybSAmPSB+SU9NTVVfR0xPQkFMOw0KKyAg
ICAgICAgfSBlbHNlIHsNCisgICAgICAgICAgICAqZXJyX2NvdW50ICs9IDE7DQorICAgICAgICB9
DQorICAgICAgICByZXN1bHRbcmVzX2luZGV4XSA9IGVudHJ5Ow0KKyAgICAgICAgcmVzX2luZGV4
ICs9IDE7DQorICAgICAgICBhZGRyID0gKGFkZHIgJiAofmVudHJ5LmFkZHJfbWFzaykpICsgKGVu
dHJ5LmFkZHJfbWFzayArIDEpOw0KKyAgICB9DQorDQorICAgIC8qIEJ1ZmZlciB0b28gc21hbGwg
Ki8NCisgICAgaWYgKGFkZHIgPCB0YXJnZXRfYWRkcmVzcykgew0KKyAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQorICAgIH0NCisgICAgcmV0dXJuIHJlc19pbmRleDsNCit9DQorDQorc3RhdGljIHVp
bnQ2NF90IHZ0ZF9nZXRfbWluX3BhZ2Vfc2l6ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUpDQor
ew0KKyAgICByZXR1cm4gVlREX1BBR0VfU0laRTsNCit9DQorDQogc3RhdGljIFBDSUlPTU1VT3Bz
IHZ0ZF9pb21tdV9vcHMgPSB7DQogICAgIC5nZXRfYWRkcmVzc19zcGFjZSA9IHZ0ZF9ob3N0X2Rt
YV9pb21tdSwNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkID0gdnRkX2hvc3RfZG1hX2lv
bW11X3Bhc2lkLA0KQEAgLTYyMTAsNiArNjI3Nyw4IEBAIHN0YXRpYyB2b2lkIHZ0ZF9pb21tdV9t
ZW1vcnlfcmVnaW9uX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLA0KICAgICBpbXJjLT50
cmFuc2xhdGUgPSB2dGRfaW9tbXVfdHJhbnNsYXRlOw0KICAgICBpbXJjLT5ub3RpZnlfZmxhZ19j
aGFuZ2VkID0gdnRkX2lvbW11X25vdGlmeV9mbGFnX2NoYW5nZWQ7DQogICAgIGltcmMtPnJlcGxh
eSA9IHZ0ZF9pb21tdV9yZXBsYXk7DQorICAgIGltcmMtPmlvbW11X2F0c19yZXF1ZXN0X3RyYW5z
bGF0aW9uID0gdnRkX2lvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uOw0KKyAgICBpbXJjLT5n
ZXRfbWluX3BhZ2Vfc2l6ZSA9IHZ0ZF9nZXRfbWluX3BhZ2Vfc2l6ZTsNCiB9DQogDQogc3RhdGlj
IGNvbnN0IFR5cGVJbmZvIHZ0ZF9pb21tdV9tZW1vcnlfcmVnaW9uX2luZm8gPSB7DQpkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQppbmRleCAxYjBkODk1OGFkLi40NjExNThmNTg4IDEwMDY0NA0KLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCkBAIC0xOTQsNiArMTk0LDcgQEANCiAjZGVmaW5lIFZURF9FQ0FQX01ITVYg
ICAgICAgICAgICAgICAoMTVVTEwgPDwgMjApDQogI2RlZmluZSBWVERfRUNBUF9ORVNUICAgICAg
ICAgICAgICAgKDFVTEwgPDwgMjYpDQogI2RlZmluZSBWVERfRUNBUF9TUlMgICAgICAgICAgICAg
ICAgKDFVTEwgPDwgMzEpDQorI2RlZmluZSBWVERfRUNBUF9OV0ZTICAgICAgICAgICAgICAgKDFV
TEwgPDwgMzMpDQogI2RlZmluZSBWVERfRUNBUF9QU1MgICAgICAgICAgICAgICAgKDE5VUxMIDw8
IDM1KQ0KICNkZWZpbmUgVlREX0VDQVBfUEFTSUQgICAgICAgICAgICAgICgxVUxMIDw8IDQwKQ0K
ICNkZWZpbmUgVlREX0VDQVBfU01UUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQzKQ0KLS0gDQoy
LjQ1LjENCg==

