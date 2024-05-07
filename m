Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D18C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NKu-00018b-KK; Tue, 07 May 2024 12:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4NKk-00015L-Oa
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:06:29 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4NKc-0002aF-T5
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715097979; x=1746633979;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NNUllArQBgbIPD0t6uRIzAKEY84luCGEyAHAex3eLtQ=;
 b=TofTwbf8tnxcVgROeEUvb88etaGp9bfiZd7fRvJExufw2HUZWwWWgKHw
 Ceb7raJfBylc2EGKIAMrlmXR+/fna6fEuablune5E9jkqlNekAwwJn0WZ
 KdhO5tN2CmJwj1dZhJ+m9ABky1/Anm98YX2rrn5srDeskIBByqWMg/tDd
 WsRPMDpkwo3x1elhGvewhfHRi/CWNWbNunKe2FPaeWxi9edNjJ0lOdVAF
 s4vTluabSQRwyd4JLfF6PFs7L1IoXGYsv5H92SkZ+1/lBKSJ2GWXqlawQ
 jsjv3wNRaj9oTC8RZXF6rzYGsX7Es4XZszkzuZLjY7jCQEdy5bR5CyJI9 g==;
X-CSE-ConnectionGUID: JkJis8EDTBWNveWEcxtrgA==
X-CSE-MsgGUID: yCaXBp5rQnSilYkF7OkbVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11029185"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; d="scan'208";a="11029185"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 09:05:55 -0700
X-CSE-ConnectionGUID: n1+O5quaTfqs+0PHD2/SdQ==
X-CSE-MsgGUID: PTh4TDbVROKsN29noVdevg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; d="scan'208";a="28653192"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 May 2024 09:05:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 09:05:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 09:05:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 09:05:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 09:05:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5XU0xB/SLMX1856yBZgIFtJILsSpA3WzUyvbhlzzcQocQuGUj5jRpY3Pp3Oynf7l7fQHYjbBsqCk3+ScxsuyzjjfOlovdzaDgdWLNwLhTxFyeUi8h69tSe+9nv2ulroBPBPzX9Me2E40QGHgt3QKqX5dRf+YnfnEw6aDFbs/VguDYLKpnnLKdoRpCTeuo4sRgk9+6v6vb7lZFyfg+y4RTr31m+B3N11EaDAZ+n6NVeu3bPdxQFbpdw1kzPIKLvHTRyqB7PpeDw0sSBolWF0Tq2tKEYxOdHo0InXLrYowq3Uod3njH2qLprIanshJjaXEN5jzZgogA/cWa7yVgqm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNUllArQBgbIPD0t6uRIzAKEY84luCGEyAHAex3eLtQ=;
 b=cIXWrMru73LNIsJcLYkhABdsb6J7NTUMAt5u7PXpbD5EGPk2X9V9NzzMINlSMxHwhKpCB2/LtuD8woMye5v1VBhIKSbaMe35ax8HnOVc5c3LonLclT1iAdw83WJBGZRlLpXk3Pz6FGN25LWwqbZK7KvXuwgQ7dyaSsMmcnrMUeW4uYrELFHiW5k0B9Wh80seni+SEW1htTw0vCllH0GB4mRPgUZlciBO8R6ESIHhdVLBbbEu7Gz4sjVxflCMT7IGw+DE0kQfkAdALAW3++7chr0uQISSKQLqTBZe3HC3BXVzCWWbzco4KtoL/KgsPPlcC099Y7EGc5Nk6iTV36KcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 16:05:50 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7544.029; Tue, 7 May 2024
 16:05:50 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>
Subject: RE: [PATCH] ui/gtk: Explicitly set the default size of new window
 when untabifying
Thread-Topic: [PATCH] ui/gtk: Explicitly set the default size of new window
 when untabifying
Thread-Index: AQHam3pZkemeOhX0gEqvV08Xr60niLGL6lkAgAANvCA=
Date: Tue, 7 May 2024 16:05:50 +0000
Message-ID: <PH8PR11MB6879CC01FED69C2965252F19FAE42@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240501034133.167321-1-dongwon.kim@intel.com>
 <CAJ+F1CKxB5CGkR=xvgR8X7sm2X+qW0sd3VE=uf01JRZcgOkyRg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKxB5CGkR=xvgR8X7sm2X+qW0sd3VE=uf01JRZcgOkyRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|PH0PR11MB7494:EE_
x-ms-office365-filtering-correlation-id: 681c6c43-6d1f-4777-8ad7-08dc6eaf90d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dHN4Sks2b3lhcWNxdG4vTWpndVNmMTNUZTQyTURYekNEWjR2RWgzU3pCS3gx?=
 =?utf-8?B?MHRNckp0ZEVYRE50Sjd3Q2Mzbk1DS29aVHE0a2dheE10WWRmOVlrV1U3NnFZ?=
 =?utf-8?B?U1BSQm5MOTNXcWpuZTA5eVJRZ3loaCtRNkpqL3QraDdKU2lBZ3kvdU9SalRL?=
 =?utf-8?B?VDNtMmZUTG0zdVhyNTllQ09kRG5PR1NVVVF4Ulo2Q2ZOUlFFREV3TEJIN2lu?=
 =?utf-8?B?WDlXMThNQTJZazh4VFd1RzFRREE4VEdUV3ZsVlpISERLeklRSkpUdU5jRDJz?=
 =?utf-8?B?NC9wUVdzeUsxb05hVDhtRFUrbFdxQmg0UGtMQUJaUXJFS3AyL0ZFWGl1YWJP?=
 =?utf-8?B?M2JGcjRTOW1sUmtaaFZwcXJBN1JVSUZLMlhVeVdnK1Y3cUZyWmdsNzczamZu?=
 =?utf-8?B?WUlVOVdCNkJsb21URVkvelNUZFdTSmZCdVlXeTl6VVYwL3E1bkkraWdaeHZB?=
 =?utf-8?B?d011M01jRk1lRWYxNU8rZVh5NHFhUXFjRm1jdlhqNjlBMkZEME15VmExZmlB?=
 =?utf-8?B?Qkx4UWtjZWE5QTJ2ZFhvOGFvRVZvOHJJWGc1eDlucGFLSEtseGxsZHFCNmpS?=
 =?utf-8?B?ZFBrYnZKNkU0T0tLeDA5dDZrdDlwSStHbnJIenNTU0ZNNmZkNTE0MHdjOEJp?=
 =?utf-8?B?Unp2TE9qR3NESFlZaVd0UDB3TUVPM3d3aUFpNDNjMXFYNjJDNGZxT2s4Nzla?=
 =?utf-8?B?K2NzN2gyeDhRTHNqVGEzam5ibExQbnJjTE1pSUZsZ2xkSURpWnZ6KzdqUGlO?=
 =?utf-8?B?QTFQcmZoVCtJU2R3RFU4eEFNZ0VSUUhYVnhTQTE0OGx4dEZ6NlRZU3dlQVZL?=
 =?utf-8?B?YWQxWkFkMXhWSW5PVDdTVjl1QmdnUnB0QTVRK1BmM0lCR0FzTDcxVlhrQWZz?=
 =?utf-8?B?a3pKUTU0YjVQWGpnZDUxdUZGTnN4OEsxcWV6UDBMak0veTVhTDFrTTFyRlpq?=
 =?utf-8?B?NUVKVXBqMEdxK0VBUGVmSWtwSDJsb2dKNEM5UDdyZHdld0wvMmsyM3FmMG80?=
 =?utf-8?B?NTY0cmw5UjZkZHZ1U2NWMXFjSVZ3OHQrZHU5Y0xEQ0pJMmtkZWF5QmN4ZXAr?=
 =?utf-8?B?MFRlK0QyNG9memo2K2dieE5CczdrT3hmblloVS82RVh6aUM1MlQ0emxFV1Fq?=
 =?utf-8?B?TFM2MDAwWUx6R2NLRzlxR2F5QkRhbUtHTlhpNVM5cnViQXpIclhZWW5zbEJH?=
 =?utf-8?B?TUFxRkRzai9xWDlBY2lLNngvdFp6QWVhVlRqOTVsUXdqc3FFNm5scUxtdDUv?=
 =?utf-8?B?TXp4a05BSVk5RUtMSzJscTdUSS9Ka2VUK05PQzFIREE2ZVlFL3RZNEV1VkMw?=
 =?utf-8?B?YkZlMzRONDEzSHlPQ29aY05JNGFZRDR3azJ4MFpVVnRJWDV4ZERVM1VyUXVR?=
 =?utf-8?B?Z2Q0cjQ2NHRYRjJsU1laVXRZSCtSSXVFU2hDVm1BdHBxKzFkV1lkU014dDBV?=
 =?utf-8?B?NU1pSzhQcGJhTHpUTjFJVjUvc3FUbkJWZVl0N29qN0FvYUNPZkpieVpLVmRO?=
 =?utf-8?B?Zm5QU09qZWNvdGNONDd5UHNiMkgrbUJtRDVyWWZJWG5nc3R2dWR5alg0L1p1?=
 =?utf-8?B?YVVLc21VWXdaN1FtNmNOTEtSWDJLa3dISGRqeVRnSS9rcEFEVSs4NThaaEw2?=
 =?utf-8?B?eGNZcHkyekJIZG1oVnRnVW44SUM0MXJsSHRIYVZKQzIxckNuRld0M094T2tF?=
 =?utf-8?B?QTh6bDNFNDJhQUVsODNhbnFHT1g1NEtJK3QxNjQvOGtLZkg4Mlo5TkFFWWxJ?=
 =?utf-8?B?YWdtODlZb2VwOUREWXQ1QmxFS1BsVFJiV2lqTzdSR0c5a0pLN3RaZUVMcXZr?=
 =?utf-8?B?cHRoSWp6ODhTaVdRVlBpUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2V6a1Y5a0NLY3N1NVN6WDZBR2RjVGpFZEoyNnhLcnRkdmQ1UHRCek5QMzA4?=
 =?utf-8?B?QkxDWW5OTjYzdXNvbUpkcVRrVkFUeDU0ZzR4MmFpWXNwQUdDdTNJSGZqbWtr?=
 =?utf-8?B?THNyeTg2TDJuNXd0RVhlbkpGR1Jscm5DSld5L29wVXplM3NyandsaXE0RzBv?=
 =?utf-8?B?dmM4cDgvK0REV3E4aTBOT3d6Y09UZHhmZnFNdDNjYzlHMGo1UUlPUmtxT3FQ?=
 =?utf-8?B?b2E1aW5NSUFVRUxaZzNMS2hMRXhiQUxGS0x1cUNJenpPZzhBUXM0ZVE2K1RK?=
 =?utf-8?B?TERwemk4b2I0aW01SEZrZ1cwSm1lYlVkRFQ3c1NaNHpla1FMdnhSOVdUSEo0?=
 =?utf-8?B?bSt6eTRYT2lFSSsraXJIdnpVcnY4eFlDWTEvZXdOMVpPdU15L1BLaTRDcFNi?=
 =?utf-8?B?Tm93aER5MjYzVG00S3p6emdQVGI5VExjWjZ5Z01sRFQ4bGFFM0YwelRrZzJT?=
 =?utf-8?B?RlhObGlLK2tmLzEwSitwOW5NR3JNVFp6V25RT3J6ZXVhdHF5NlhBNXNoTTBs?=
 =?utf-8?B?Mk1QSHVxUXl3OXFKbFlhWHRLU3VCbm9oMmVvbTB4eS9acStmWllkNW1VN0c4?=
 =?utf-8?B?UEgzcmxkaE9ySFc0YTJnTXZWZHMvL2NsM3VudkFpNXdLUWIzbXNXVDhoNmIr?=
 =?utf-8?B?TjNJOVdrNjN3SVNpTkZ1ajMwZzYzZjlrWUdrYXR1eWNwbi90QzBmN1MwVzBV?=
 =?utf-8?B?SkNsWGN4dnNuR0FkcTl2S1JIUTRqU2RpaDN3WkxzRGhzYVR1MDZKdFkzY09y?=
 =?utf-8?B?UUZHYVRXYnJmd1R4OTc3dHFEMEtQQWk3YjdsSTZUenZicStkUXlIQml5NW9o?=
 =?utf-8?B?aEdjYUJIbmhxTisybzIrMGo0ZW5tRzRhbHBZY256NnY0Y2hBREpRL0tjY3hP?=
 =?utf-8?B?cTZWNGIvMlB5UDFIK2drVndDT0NTdmFiaXE0WVhIWWdSdkx5V0FNdW90R283?=
 =?utf-8?B?N3JMQitCNVNSOTZqY3lxSnVMUTBVOEVxdGpGeGpyREh2UW0vM0pXT25lQnNp?=
 =?utf-8?B?b0E5TUdIY1YvNjByRVU2TzdYaUl6bFh6cEp0Yi9JcTBWSVIxK1R4eVBWU2x3?=
 =?utf-8?B?ZitmRnBUY3BKcFBMUno0NEFZclgvZjNBL0RJL1Y3bzdwdWpDLzJFRTc5YklV?=
 =?utf-8?B?MEJkdGJhcUhjbXQ4M0ZUeHlXNjBBaXNxZVpUNDBZYkRlNERWK0tCbTdjKy9U?=
 =?utf-8?B?c1FCbm82eU5nMnQ1ZFVkaVNDRnk0cU9oM3ZuNGMyNGZqQTl1MUFCcVhjSllx?=
 =?utf-8?B?eERlU3Z2b0x4ZXRJZjBDd2RtU2c1ekhqVnBWanA4OEZZYkplM2xxNGpWTU1X?=
 =?utf-8?B?QzhhRTlzRHBFV3E4a0pFWDA2T3dtVWVDaENpYklJaUNMaG9sQmllSnorVk1P?=
 =?utf-8?B?SGV1cjdIc3JzeUxjTTQzdlc4UXJmaE1IQkd5Skd0NWJyVmtsdEkxRDlmdkM0?=
 =?utf-8?B?WjY0T3dvLzVUbFdtNmQveDF1SG5XV3AyQ2dWaFE4bEV4VEFEVEdGSU5DSXZk?=
 =?utf-8?B?U0ZwaVF0bTg0SWlQYnhsT25md2xKVmJKc0VGd0ZiZ3gzdnY5R2tBaTNrYWFD?=
 =?utf-8?B?VWJpd3VWYnBhYnI0UEtpandaZjkyT2xzb0t3ZjBhS3RwYzVNN25jbk0yY0ZF?=
 =?utf-8?B?UW8zUHJiOWV3SllRYzJ5eDcwQ0d0N2pzaExJMTd4MWRzUm51S2x5cDgxY0FT?=
 =?utf-8?B?TmFwOFUwMkd2MjgyOTZMQS9DZ1VweEwrNXI1R3had0FFaWlmMGR4MmVPTDF1?=
 =?utf-8?B?YzhHZVEvME01MEtuYnU5TitqMHFmeno3RlNKMFRKdmgxWDcvaG96eFV6L1Z5?=
 =?utf-8?B?M2pXZ0RidmYyNlRTQlp0K2gwU1M0b0g1bkZhRmVrZytYOVJwc01MVGFydGdM?=
 =?utf-8?B?OXVHVGxtSDVZRXFPejNHckFnMVNQaHBwbWJYZ0pETWpKWmJrVXRrUzA3bWlX?=
 =?utf-8?B?WkUrbUduV1NFdWhCWU5QSHpFNmVYQzFnY2hveTFSSGlKRlZZN2ZaaXVHdW0z?=
 =?utf-8?B?NEFHN0xzZTdwNGU4dEFMM0NKb0VoR3hZMG9aOTFwNWpkQ1V1VjFZZDFFU2o4?=
 =?utf-8?B?R08yWktVb0dUZGhhVkI3UEk3NExuRkJ1TFF0djdWSnNsZ296RkY2bVh5SFFt?=
 =?utf-8?Q?cf8tK4N4Q8pUTn6Tbgh1SDDAs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681c6c43-6d1f-4777-8ad7-08dc6eaf90d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 16:05:50.7713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQ/3GC8OuXvhOAJ9ARx1Me2t1wAYzA+1hxyJmxBAEdEkKw4nVzJcNxB1Bcd6jCPrr8NzBM0mQx16F/8rU6jg0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgTWF5IDcsIDIwMjQgODoxMCBBTQ0KPiBUbzogS2ltLCBEb25nd29uIDxkb25nd29u
LmtpbUBpbnRlbC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IGtyYXhlbEByZWRo
YXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVpL2d0azogRXhwbGljaXRseSBzZXQgdGhl
IGRlZmF1bHQgc2l6ZSBvZiBuZXcgd2luZG93IHdoZW4NCj4gdW50YWJpZnlpbmcNCj4gDQo+IEhp
DQo+IA0KPiBPbiBXZWQsIE1heSAxLCAyMDI0IGF0IDc6NDfigK9BTSA8ZG9uZ3dvbi5raW1AaW50
ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBp
bnRlbC5jb20+DQo+ID4NCj4gPiBXaGVuIHVudGFiaWZ5aW5nLCB0aGUgZGVmYXVsdCBzaXplIG9m
IHRoZSBuZXcgd2luZG93IHdhcyBpbmFkdmVydGVudGx5DQo+ID4gc2V0IHRvIHRoZSBzaXplIHNt
YWxsZXIgdGhhbiBxdWFydGVyIG9mIHRoZSBwcmltYXJ5IHdpbmRvdyBzaXplIGR1ZSB0bw0KPiA+
IGxhY2sgb2YgZXhwbGljaXQgY29uZmlndXJhdGlvbi4gVGhpcyBjb21taXQgYWRkcmVzc2VzIHRo
ZSBpc3N1ZSBieQ0KPiA+IGVuc3VyaW5nIHRoYXQgdGhlIHNpemUgb2YgdW50YWJpZmllZCB3aW5k
b3dzIGlzIHNldCB0byBtYXRjaCB0aGUNCj4gPiBzdXJmYWNlIHNpemUuDQo+IA0KPiBGcm9tIGEg
cXVpY2sgdGVzdCwgSSBkb24ndCBzZWUgYSBkaWZmZXJlbmNlIG9mIGJlaGF2aW91ciBhZnRlciB0
aGUgcGF0Y2guIENvdWxkDQo+IHlvdSBoZWxwIG1lIHJlcHJvZHVjZSB0aGUgaXNzdWU/DQo+IA0K
PiBJIGFsc28gZG9uJ3QgdGhpbmsgaXQgaXMgY29ycmVjdCBmb3IgdHdvIHJlYXNvbnM6DQo+IC0g
dGhlIGlubmVyIGRpc3BsYXkgd2lkZ2V0IHNob3VsZCBjYXVzZSBhIHdpbmRvdyBzaXplIHJlY29u
ZmlndXJhdGlvbg0KPiAtIHRoZSB3aW5kb3cgc2l6ZSAhPSBkaXNwbGF5IHNpemUNCg0KW0tpbSwg
RG9uZ3dvbl0gT2ssIEkgc2VlIHRoaXMgaXMgaGFwcGVuaW5nIG9ubHkgd2hlbiB2aXJ0aW8tdmdh
IGRldmljZSBpcyB1c2VkIGxpa2UNCnFlbXUtc3lzdGVtLXg4Nl82NCAtbSAyMDQ4IC1lbmFibGUt
a3ZtIC1jcHUgaG9zdCAtc21wIGNvcmVzPTIgLWRyaXZlIGZpbGU9Li9PVk1GLmZkLGZvcm1hdD1y
YXcsaWY9cGZsYXNoIC1kZXZpY2UgdmlydGlvLXZnYSAtZGlzcGxheSBndGssZ2w9b24NCk1heWJl
IHNvbWUgc2V0dGluZyBvZiBkaW1lbnNpb25zIGlzIG1pc3NpbmcgaW4gdGhlcmU/IEkgd2lsbCB0
YWtlIGEgbG9vay4NCg0KPiANCj4gdGhhbmtzDQo+IA0KPiA+IENjOiBHZXJkIEhvZmZtYW5uIDxr
cmF4ZWxAcmVkaGF0LmNvbT4NCj4gPiBDYzogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUu
bHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gQ2M6IFZpdmVrIEthc2lyZWRkeSA8dml2ZWsua2FzaXJl
ZGR5QGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5r
aW1AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB1aS9ndGsuYyB8IDMgKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS91aS9ndGsu
YyBiL3VpL2d0ay5jDQo+ID4gaW5kZXggODEwZDdmYzc5Ni4uMjY5YjgyMDdkNyAxMDA2NDQNCj4g
PiAtLS0gYS91aS9ndGsuYw0KPiA+ICsrKyBiL3VpL2d0ay5jDQo+ID4gQEAgLTEzOTUsNiArMTM5
NSw5IEBAIHN0YXRpYyB2b2lkIGdkX21lbnVfdW50YWJpZnkoR3RrTWVudUl0ZW0gKml0ZW0sDQo+
IHZvaWQgKm9wYXF1ZSkNCj4gPiAgICAgIGlmICghdmMtPndpbmRvdykgew0KPiA+ICAgICAgICAg
IGd0a193aWRnZXRfc2V0X3NlbnNpdGl2ZSh2Yy0+bWVudV9pdGVtLCBmYWxzZSk7DQo+ID4gICAg
ICAgICAgdmMtPndpbmRvdyA9IGd0a193aW5kb3dfbmV3KEdUS19XSU5ET1dfVE9QTEVWRUwpOw0K
PiA+ICsgICAgICAgIGd0a193aW5kb3dfc2V0X2RlZmF1bHRfc2l6ZShHVEtfV0lORE9XKHZjLT53
aW5kb3cpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdXJmYWNl
X3dpZHRoKHZjLT5nZnguZHMpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdXJmYWNlX2hlaWdodCh2Yy0+Z2Z4LmRzKSk7DQo+ID4gICNpZiBkZWZpbmVkKENPTkZJ
R19PUEVOR0wpDQo+ID4gICAgICAgICAgaWYgKHZjLT5nZnguZXN1cmZhY2UpIHsNCj4gPiAgICAg
ICAgICAgICAgZWdsRGVzdHJveVN1cmZhY2UocWVtdV9lZ2xfZGlzcGxheSwgdmMtPmdmeC5lc3Vy
ZmFjZSk7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KPiA+DQo+IA0KPiANCj4gLS0NCj4gTWFy
Yy1BbmRyw6kgTHVyZWF1DQo=

