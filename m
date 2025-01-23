Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FCAC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 09:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tatty-00059c-9l; Thu, 23 Jan 2025 04:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1tattv-00059L-G6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:53:27 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1tattr-0002n6-2t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:53:27 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N8ttFs024624;
 Thu, 23 Jan 2025 01:53:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7n5i/SWE9I27yys4zArWquwjKdT2QLuD33dne2ZE4
 fs=; b=0ooBxOIDjyMeZcxaqlWBcI0L3+/aK0+DyNYJAe1dQD/NDXOs/kvewn27B
 ooZH2lrnq2ldg0tzr71UnNm8bo5s/4x1V8N7odWXvjZT29F6/ozkSB4ZfywcmIdp
 C8zBIgJbJmiLWA/8XZGtmNRHZGZL2+ReDJQvHjm0g8eTRxrgJze6UGXrDHi6ETX1
 z0UfZlFwt7A26DKYKJQHjU2v1AWjc8epRykp7oe7fCAcVGDixcKb8OnXtDx5txmI
 4riB22MfUYkHvTZg8oRSLfaKjJa/wlgUfYXGwcEmAtzFctwdXnCpnYyP2qkcH4RM
 byVLq5gk/cb7NwGpThvNmpT9Kb6cQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17011025.outbound.protection.outlook.com [40.93.12.25])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 448k852v9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 01:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n62U9Qcqb9ipqlc7Jsj6HP9CpQ0vpVifS78wwvz4wi9khm1fkELSva7STPi7sK7T5mIww8wF1wjdb/mD8dQOOOeQpfsmf+W0EBdwS0ehBmoduHfoNMlK8q3KRhokFFUmJn8Lmh2PsRX4YtzEdyWcH5sFJXT4MeYf+I6PkhKRsXtMAv48nm04mMl8BvDcfxVtaB+S5Hft5T9NeoXgtk/DcByxMtiQlbe+lfHPZnaZa+ef5Z8xewgzsu78ScO2LF5cMhXyAxwSrGDiNFRLRjfvPB7xHUs9pB9VXWNq4Mlwa3BZ6p8xxY1NznaZqQiGSSIQV5Ou4pELtkh2yOZXt1Dvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n5i/SWE9I27yys4zArWquwjKdT2QLuD33dne2ZE4fs=;
 b=mwjhH/zjJBLCBBLvsry82c82/ADEBsbhTZxRmBEfQQpjr3cl915pt1XUIvXNuc0P/zMYcynZbtI416tPKywzpB2re4ZX2XavLo1XFn7LNohetsxhcFF1BWOWQ+ONEDJf5c5DaXLYnhdsI6bzXS6sFpfrLTrBPVTx63nV3k9hk77KMALgOqanGKiN/xM4MAe34UvjRWg0m09lxb8wc9MUZZEr0xdEfYCfiIKWpi2wF+iR2HcPx7jeqquvLOL2lbv9MF25QMWtFv6oIrYStFiM1lrSEKzGiLa7vboDf2Ht4g9137bpU1i/c9tN4oWs2QJNdKgJpOKt3ERGxyFR1Y5bhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n5i/SWE9I27yys4zArWquwjKdT2QLuD33dne2ZE4fs=;
 b=hAAnXzdwmcFHsRt4p9a9IxYdSA2UVd+0DXakoarl5uArcC2oPA+ehZxJq/ECT7kMROjPN5jOcvOdU8+U6tiVk3KA+sIYL56aYr/2Dvjq2pXzIRDpec9ol/CyxVE6LnOE9Q3Xzq3GDA2eHK3uw4XR7Y32u8kPyHmoSDbXf73k6U8fRhYfSR1AChhRgnbjwQ04jU/J4pcsPUsI0max8UhJHase85maCesdXAqpq7jbm3HF4A4aXQjCaDuGhz8zAZhZSrcVkLFUCT+drcgArxMgDk6Lj1b/y+hW2Os7/QIAsxbTLSDgtf9SGtlk8eXcL5Ms2gTfAF8NEAdc5TVfrj6sNQ==
Received: from CO6PR02MB7555.namprd02.prod.outlook.com (2603:10b6:303:b3::20)
 by DS7PR02MB9460.namprd02.prod.outlook.com (2603:10b6:8:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 09:53:16 +0000
Received: from CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::cab5:29a2:97ac:ef9]) by CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::cab5:29a2:97ac:ef9%2]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 09:53:16 +0000
From: Shivam Kumar <shivam.kumar1@nutanix.com>
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] Fix race in live migration failure path
Thread-Topic: [RFC PATCH] Fix race in live migration failure path
Thread-Index: AQHbY0dxbhiAa4q+s0eX0DbBG5ink7MP+z4AgATu6gCADccyAIAAYLEAgAEgmIA=
Date: Thu, 23 Jan 2025 09:53:16 +0000
Message-ID: <35F19D15-7FD0-43D1-B6A0-2FBB5FD9313B@nutanix.com>
References: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
 <87frlqerxp.fsf@suse.de> <Z4U_emPVDfTb1VmF@x1n>
 <0C92F4E5-56EE-4036-927C-2F06F9F29252@nutanix.com> <Z5EfapuXuV7oFL7A@x1n>
In-Reply-To: <Z5EfapuXuV7oFL7A@x1n>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR02MB7555:EE_|DS7PR02MB9460:EE_
x-ms-office365-filtering-correlation-id: 6e375f84-b321-4466-dc63-08dd3b93c266
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEs4M1p5cWtlL3lxaFJJOHNVMHFSVE9vVTM3Rm9DM2ZMSS90RDIzdnVGeFdh?=
 =?utf-8?B?cTZYeDk3VWtaQjBNR0d6anFGSXhNaERLRjkvZGlGRWZVT21kTnp5R0M5dUQr?=
 =?utf-8?B?YjNiZVJDbzBqRTdhS3gzakNQOWRhK3lCY1MyeENveU1YNkZDY20zUGcrbVZW?=
 =?utf-8?B?U0xEZk84akV3dVZmc2VzT1lDRGlBT1A0NHRZdUl1R2NDYmc5RkdwdVdYZ3RK?=
 =?utf-8?B?M1hZSmQ1VGFndWlCOVVEb3VQWXJERk9KSFR1U1hob1puSkVZejRwN3laS1M5?=
 =?utf-8?B?czk4TGFaVjdqUWc2UHVqTjNxRTM5ZzdSRUJDbDhpOHdlaHpjTXZONEhRQU40?=
 =?utf-8?B?VVJOS1ZUcU51bVM3ZjVSeGoyREgzLzJNcXk4dVRhMjdyVHBoRVByUzdQeHE0?=
 =?utf-8?B?S0ZNV0w1OTZocVI0UklhbTFpQ3NmV1RsRlB0VTBBU3lmR09EOXRRUFdrQzh1?=
 =?utf-8?B?aWZCTldON1JBSXZqNXpTSUx0OERldExGeEtMVEI5VjBZWE43aXFRNFNmWDBU?=
 =?utf-8?B?bU1uMHdzc1VTMHJidndKekRoZzdKS2thN2hlVldRZ1dvUk84V2FCRC9kcnBy?=
 =?utf-8?B?bXhVQlR5QUxhdUNxTWZhZFZSamQ5cHo0RGhsYm51NXlVZmY3NVZLS3NzQzlD?=
 =?utf-8?B?SmdubVV0VHNCSWZxTEFaT05PbG9XQzJUSi9Ca0hRVndlVWxqV3pRNWt2TE1Z?=
 =?utf-8?B?aEFZYk55cXMvMEdVYU0ydlZic1pvVUtnSjFzWGhlL3BTYU5WaXNsRWZxNFFx?=
 =?utf-8?B?NDJWeDUwN2Ftc0lndzFYNy9IeWZwQ1haTWlIdGFRREE0dzY3RUo1aExYam1j?=
 =?utf-8?B?NHNMOEU4bHdGOE1wUUJwdlVNcS9pL0x2eXlRYkpoZWVqWXI1R0tPQ3c3TDV4?=
 =?utf-8?B?bWhQMk0wNWpHNEhzcGhZaWIxczgxTG53MmJwZmZXTTFZUjZwMER6ME93TEJ3?=
 =?utf-8?B?a0ZpRGtPUlRocncvOWtSeXFmNGhlSm5ETE1LalUrVVYwaEswZnJJNlViOHJP?=
 =?utf-8?B?bzNXKzk2anpIdGs3MTRaS3JJL1RRUEZ3bkMxdDA2ODRsUFpnOFF5d0ozcFpm?=
 =?utf-8?B?MGo5cHJaTlZWVnZKdUFBMHlkazAvN3VsdHZvWDZZSFdJNjF1S3ZJdU9zWVZH?=
 =?utf-8?B?Y2ppTG82WDhydHFaYzNXY25wRnRTbTBXYmxGRExGc3Y1ZmlLRmRBSy9pUW9N?=
 =?utf-8?B?a3JJRCtOVVJFSzFZNHZ6V3UzZlF6UEQ0Mkc0cEJCbXhqdHdXRXV5Unh4L2k5?=
 =?utf-8?B?aFVLN01xN2sxc3JXVjRlWFkwa0RwTStxQkpCUmk5QlE0RkF6Q3hpeGhYQm0r?=
 =?utf-8?B?SmVuWGNtSGRrMG5TWndBZ0hvb2pXS1N5TVBkRnArVmpXaU5BUDRxVFZ2Mkxk?=
 =?utf-8?B?ZmJlaHg0ODNBeGJkR2JTek14L09STm1xQzNaTEUyb1kwTEpFSURVaTNqcFNG?=
 =?utf-8?B?RnN5RGVyR01pN3FkZTEvS2lKMU9ZRlNvMFVsamVENWY2NHprZTRWYzV4UDhP?=
 =?utf-8?B?dGNRYWkyQmNRMUdRQjRoTGY0aW94enZUckhTVml2UVc1cVF2SG10cWMraWVI?=
 =?utf-8?B?WE94TlJMQkRIQ3hGWXozekl0ZEo5QkFFdW9pQldmd1BHbU1sblNjclVLQVdn?=
 =?utf-8?B?SGcvNXhOSVlrRk5pNndWdlYrYm9YdGI2L3JGYkxQRk9sU2wvZWd0emVVcmJD?=
 =?utf-8?B?dmFmbTVJcnFzT2tDVHd5QkFqSGNqRzU2Zk1tOWNreCt2WjRBYmFWNW1YRWpH?=
 =?utf-8?B?dTlMVVllOVVvekpFZWgyWFlwTVBaanIvMjA1QnJzejJzd013VEIybVhWU3dR?=
 =?utf-8?B?OHpBVWlXbllCeUQ0SDdEcHYvaHVYK1o0VC9ONlFjYVZjNDU4dWVUSE40WFpX?=
 =?utf-8?B?MEx3SkpVQzBwYkJUMGhOTDdaNEFXdHgwbHNteUNDZ1dIZnVacFRSdGMrS2Fw?=
 =?utf-8?Q?VJhXJy1SkzhmgjxvMXtfFKhSkEuarcUw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR02MB7555.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXc3L3UydzZVK205bjVhUGQ1MVJLUWI0RDY1Z3lLT0pjem80dmhKZTlpZ0lT?=
 =?utf-8?B?K2JqYjNxL3VzbHJhUzh3TmI1K2g5RDZ4SFkvMFNwMHZkT05KS0d1bENOMERM?=
 =?utf-8?B?MzYrOHNvVDlwZEZaMnptWUJBNkxhWHQxNmpuak5SRkhOODh1bmV0dGZqWkhJ?=
 =?utf-8?B?eW1qVVdXalY0cGhqUmQ4ME9nTFhFd0dKeDgzaGtjNkh2Sml4aGpKKy9VOE9M?=
 =?utf-8?B?dUVESnJDc0x4NjV5UHJ0eHd4MldyT0ROTmJiMS8xKzFrZXRyMUhMRW5qR3Vs?=
 =?utf-8?B?eWVOVHRXMkdkcGdvZXMvTnhacjQydDVzRDloNXhKL2o3TmgweU5jR3RGNFNw?=
 =?utf-8?B?UitmdWlpQm1MTEFyOEJRS1VrRjgwTkRYWlRUSW1WVy8xQUM4TDRZVXlRYzIr?=
 =?utf-8?B?djJFUEtXWUdkSDMyUFdTbWRHYWk2LzdnTE5CczlRL3g1cXEyaWpsVjZ5dWlG?=
 =?utf-8?B?eUdtYnl5M0FVQmh4d0wxTEEvQmwxU0sreEFNQ1QyakordGNYc21pNEFOM2J5?=
 =?utf-8?B?NTBWd1V6VEs0b3FIM0tmOC9ZWkFLZmtiWDhwdGR2WTN4blp2ZUJrd29hNGtC?=
 =?utf-8?B?U1VPQS9TRStrM2RBRTkxRmVUQURnOTFxOGlBaG42L0RtcE9Nc0J0d1dQKzhu?=
 =?utf-8?B?K0dReXI2MExQY3VlQVN2eEVVNDNjNkRCUU1xd3AzbGFmelFFVXdMVHRLckZp?=
 =?utf-8?B?WDFHRDZRVGhYVVRzTnl2ZllmRElFTWJqL0J2ZS9vRGxOYUsxRGVSVVQ0WFVZ?=
 =?utf-8?B?d3RYdlNQVUpFK25wQUdIUXVINkNwOHVtTUd6Tjk5dFViVXhSSmZCazVwQU9J?=
 =?utf-8?B?YU1lR3hXRjUrNUFUUkd4dG4zYmFVdVBVajlqRThkQW9HTkR2dzNJU0E5dnlH?=
 =?utf-8?B?Z3BMNk5lNlFaNzF5ZDMzdi9kSFozMm82M1gvak5RRzRzeEZ1UTlvbGtKZGp5?=
 =?utf-8?B?bHc5TDFxRnYwY2NYQnZSV1dZbzluY0V1WWU4ZGN0dG53ZThlb1lxQjc5ZEM4?=
 =?utf-8?B?ckpxSzByd3JERVE1ZFRjSXZLOHVJL3hxeDcyN0R5eFNMY0MraU1ZREFDN09a?=
 =?utf-8?B?ZktRVCtWdkJJYkN5djRlL3J3MlIvbmdleldoTkhuREV6U2U0Z1B1RzhEL3lL?=
 =?utf-8?B?bGJGS0llaVFqM2Vydm5Ud04zTU0vS2lvekVCNDJndFpWb1VoN0VMMmxiZXE5?=
 =?utf-8?B?MWNPNWV0LytTdm9zSG1kYmROelhGM3ZyQjZacmZmU2RMS09aYWFmc01YYktH?=
 =?utf-8?B?UzlJUlF4UVVISG5va2lJRGlXQlAwUWhSaHhhTGNpMlNrY2JnZDB5Y1FteFdC?=
 =?utf-8?B?TGw4cmtYUUxuc0dIVmRFRkd2V1Y0aXl3eDk5SmpKdHhlbFZ5RzhKQytJMlYx?=
 =?utf-8?B?NkhhaVpXOXRqT2hNMmZkZkNRN3RFaVdNUHF1Uzk3VjduMGdmT0N6U1VtWkw4?=
 =?utf-8?B?ZGZ6RloxYVgzTk5DeXBPKzMwZUhzSlpXWVZCeFFRZVVKdDJLbUlBTDRkL1Zj?=
 =?utf-8?B?Tjlnd3p0b3VsMU9wVnZyVGxldCt1a1BBU01oemIxUEVyaERjTXBOd2tKUmxR?=
 =?utf-8?B?OGJOUTFZVlFFTm1VNVU0b2dCRnpGTC93VGZkRmE1dTNSZGZJZWpDYnNIVG9z?=
 =?utf-8?B?UGFPQXp2WmRLMzFKbVIwZFlDSFFtZktEVDd5dmpuSVA4NHBUenVacHJaWEhk?=
 =?utf-8?B?UUJaVmlvWWNpcjdybjBlaWZNQ20wZVJucklnWm8weDhHM1BZR1I2Z2tSNVhQ?=
 =?utf-8?B?eVVaZVJIdnBBMFZ5NUVZWUZCSTlOb1B6cjJFWmFndVNWaWhwSytwY3ZzNEhS?=
 =?utf-8?B?MVFVNlRWRG1SRXBQRHd6YnRUNWhGRVUvKzdGYWtNSUZaOEkwMGR6MnkyQTFL?=
 =?utf-8?B?V1h3ZFNJZWI1SW9WTXlNV2RLTENPNDZFTUlWZml1RWZwLzdLYkdveWFDQnEx?=
 =?utf-8?B?Wlh0NEpoNXVtaUNCL1hLWnQxKzdNTmhldXE1dk9HSlg5NXpmeURxRGhDMFZv?=
 =?utf-8?B?TzI3WmJYZmY5VFVzdllWZUFVSlhnaHY2Mm5uNU0zSUk0ZWdFUmI2MmhscWZF?=
 =?utf-8?B?T3RuNHVLak5JWnFzbXZkUWVZM25FQUllWkhwRnIwZklFWVlnUkMvNmtTTVpO?=
 =?utf-8?B?ZHhqRUtiM2tCOGQvRENPTVIxOWxaaThZK0pSZml3ZGM3RVhxM1M3U25MeGUy?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FA40B3C9B2FB944B99641653BDE5B75@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB7555.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e375f84-b321-4466-dc63-08dd3b93c266
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 09:53:16.3848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xro4krzq0jsSLFgQHJ+SWldKYYrNKp28d//OnnZ6SU6SAf0c8DbqX5S8P3Peo/mL8S9FAV28Dr0FMXrLQlno0pDls2oWPF4k+7W2T7lbEzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9460
X-Authority-Analysis: v=2.4 cv=acybnQot c=1 sm=1 tr=0 ts=6792118e cx=c_pps
 a=+Uvz/0742UIoYwQyQT1M/g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=863rkvaMuLDyCJakE10A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q-5SxIewepPnW14smTPvRSoBtyCNWtH9
X-Proofpoint-ORIG-GUID: q-5SxIewepPnW14smTPvRSoBtyCNWtH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=shivam.kumar1@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gT24gMjIgSmFuIDIwMjUsIGF0IDEwOjEw4oCvUE0sIFBldGVyIFh1IDxwZXRlcnhAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJT046IEV4dGVybmFs
IEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEhpLCBTaGl2YW0sDQo+IA0KPiBPbiBX
ZWQsIEphbiAyMiwgMjAyNSBhdCAxMDo1NDoxN0FNICswMDAwLCBTaGl2YW0gS3VtYXIgd3JvdGU6
DQo+PiBUaGVyZSBpcyBvbmUgcGxhY2Ugd2hlcmUgd2Ugc2V0IHRoZSBtaWdyYXRpb24gc3RhdHVz
IHRvIEZBSUxFRCBidXQgd2UgZG9u4oCZdCBzZXQNCj4+IHMtPmVycm9yLCBpLmUuIGluIHNhdmVf
c25hcHNob3Qgd29ya2Zsb3csIHBsZWFzZSBjaGVjayBxZW11X3NhdmV2bV9zdGF0ZSBidXQNCj4+
IG5vdCBzdXJlIHNldHRpbmcgcy0+ZXJyb3IgaW4gdGhpcyBjYXNlIGlzIHBvc3NpYmxlIChvciBy
ZXF1aXJlZCksIGFzIGl0IHNlZW1zIGENCj4+IGRpZmZlcmVudCB3b3JrZmxvdyB0byBtZS4NCj4g
DQo+IFllcyBpdCdzIHZlcnkgZGlmZmVyZW50IGluZGVlZC4gIEkgbWF5IG5vdCB5ZXQgZnVsbHkg
Z2V0IHRoZSBjaGFsbGVuZ2Ugb24NCj4gaG93IHN3aXRjaGluZyB0byBzLT5lcnJvciAoaW1wbGll
cyBGQUlMSU5HKSB3b3VsZCBhZmZlY3QgdGhpcyBvbmUsIHRob3VnaC4NCj4gSSBtZWFuLCBpbiBx
ZW11X3NhdmV2bV9zdGF0ZSgpIGl0IHRyaWVzIHRvIGZldGNoIHFlbXVmaWxlIGVycm9ycyB3aXRo
Og0KPiANCj4gICAgcmV0ID0gcWVtdV9maWxlX2dldF9lcnJvcihmKTsNCj4gDQo+IElJVUMgd2Ug
Y291bGQgYWxzbyB0cnkgdG8gZmV0Y2ggcy0+ZXJyb3IganVzdCBsaWtlIHdoYXQgbWlncmF0aW9u
IHRocmVhZA0KPiBkb2VzLCBhbmQgaWYgaXQgc2V0cyBtZWFucyBpdCdzIGZhaWxpbmc/DQpZZXMs
IEkgY2FuIGp1c3Qgc2V0IHMtPmVycm9yIGluIHFlbXVfc2F2ZXZtX3N0YXRlLg0KQEAgLTE2ODYs
NyArMTY4Niw2IEBAIHN0YXRpYyBpbnQgcWVtdV9zYXZldm1fc3RhdGUoUUVNVUZpbGUgKmYsIEVy
cm9yICoqZXJycCkNCi0gICAgICAgIHN0YXR1cyA9IE1JR1JBVElPTl9TVEFUVVNfRkFJTEVEOw0K
KyAgICAgICBzLT5lcnJvciA9ICplcnJwOw0KQnV0IG15IHF1ZXN0aW9uIHdhczogaXMgbWlncmF0
ZV9mZF9jbGVhbnVwIGNhbGxlZCAod2hlcmUgd2Ugd2lsbCBzZXQgdGhlIHN0YXR1cw0KdG8gRkFJ
TEVEIGlmIHMtPmVycm9yIGlzIHNldCkgaW4gdGhlIHNuYXBzaG90IHdvcmtmbG93PyANCj4gDQo+
PiANCj4+IEluIGFkZGl0aW9uLCBvbmUgcG90ZW50aWFsbHkgcmVhbCBwcm9ibGVtIHRoYXQgSSBz
ZWUgaXMgdGhpcyBjb21tZW50IGluDQo+PiBtaWdyYXRpb25fZGV0ZWN0X2Vycm9yOg0KPj4gLyoN
Cj4+ICogRm9yIHBvc3Rjb3B5LCB3ZSBhbGxvdyB0aGUgbmV0d29yayB0byBiZSBkb3duIGZvciBh
DQo+PiAqIHdoaWxlLiBBZnRlciB0aGF0LCBpdCBjYW4gYmUgY29udGludWVkIGJ5IGENCj4+ICog
cmVjb3ZlcnkgcGhhc2UuDQo+PiAqLw0KPj4gTGV0J3Mgc2F5IGlmIHdlIHNldCBzLT5lcnJvciBh
dCBzb21lIHBsYWNlIGFuZCB0aGVyZSB3YXMgYSBmaWxlIGVycm9yIG9uIGVpdGhlcg0KPj4gc291
cmNlIG9yIGRlc3RpbmF0aW9uIChxZW11X2ZpbGVfZ2V0X2Vycm9yX29ial9hbnkgcmV0dXJucyBh
IHBvc2l0aXZlIHZhbHVlDQo+IA0KPiBUaGlzIGlzIHRyaXZpYWwsIGJ1dCBJIHN1cHBvc2UgeW91
IG1lYW50IHMvcG9zaXRpdmUvbmVnYXRpdmUvIGhlcmUuLiBhcw0KPiBxZW11ZmlsZSdzIGxhc3Rf
ZXJyb3Igc2hvdWxkIGFsd2F5cyBiZSBuZWdhdGl2ZSwgaWl1Yy4NCj4gDQo+PiB3aGVuIGNhbGxl
ZCBieSBtaWdyYXRpb25fZGV0ZWN0X2Vycm9yKS4gV2UgZXhwZWN0IG1pZ3JhdGlvbiB0byBmYWls
IGluIHRoaXMNCj4+IGNhc2UgYnV0IG1pZ3JhdGlvbiB3aWxsIGNvbnRpbnVlIHRvIHJ1biBzaW5j
ZSBwb3N0LWNvcHkgbWlncmF0aW9uIGlzIHRvbGVyYW50DQo+PiB0byBmaWxlIGVycm9ycz8NCj4g
DQo+IFllcyBpdCBjYW4gaGFsdCBhdCBwb3N0Y29weV9wYXVzZSgpLiAgSSdtIG5vdCB5ZXQgdW5k
ZXJzdGFuZCB3aHkgaXQncyBhbg0KPiBpc3N1ZSB0byB1c2luZyBzLT5lcnJvciwgdGhvdWdoLg0K
PiANCj4gSW4gZ2VuZXJhbCwgSSdtIHRoaW5raW5nIHdoZXRoZXIgd2UgY291bGQgYWxzbyBjaGVj
ayBzLT5lcnJvciBpbiBkZXRlY3QNCj4gZXJyb3IgcGF0aCBsaWtlIHRoaXM6DQo+IA0KPiA9PT04
PD09PQ0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL21pZ3JhdGlvbi5jIGIvbWlncmF0aW9uL21p
Z3JhdGlvbi5jDQo+IGluZGV4IDJkMWRhOTE3YzcuLmZiZDk3Mzk1ZTAgMTAwNjQ0DQo+IC0tLSBh
L21pZ3JhdGlvbi9taWdyYXRpb24uYw0KPiArKysgYi9taWdyYXRpb24vbWlncmF0aW9uLmMNCj4g
QEAgLTMwMTUsMTcgKzMwMTUsMTcgQEAgc3RhdGljIE1pZ1RockVycm9yIG1pZ3JhdGlvbl9kZXRl
Y3RfZXJyb3IoTWlncmF0aW9uU3RhdGUgKnMpDQo+ICAgICByZXQgPSBxZW11X2ZpbGVfZ2V0X2Vy
cm9yX29ial9hbnkocy0+dG9fZHN0X2ZpbGUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcy0+cG9zdGNvcHlfcWVtdWZpbGVfc3JjLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZsb2NhbF9lcnJvcik7DQo+IC0gICAgaWYgKCFyZXQpIHsN
Cj4gLSAgICAgICAgLyogRXZlcnl0aGluZyBpcyBmaW5lICovDQo+IC0gICAgICAgIGFzc2VydCgh
bG9jYWxfZXJyb3IpOw0KPiAtICAgICAgICByZXR1cm4gTUlHX1RIUl9FUlJfTk9ORTsNCj4gLSAg
ICB9DQo+IC0NCj4gLSAgICBpZiAobG9jYWxfZXJyb3IpIHsNCj4gKyAgICBpZiAocmV0KSB7DQo+
ICsgICAgICAgIC8qIFBhc3NvdmVyIHFlbXVmaWxlIGVycm9ycyB0byBzLT5lcnJvciAqLw0KPiAr
ICAgICAgICBhc3NlcnQobG9jYWxfZXJyb3IpOw0KPiAgICAgICAgIG1pZ3JhdGVfc2V0X2Vycm9y
KHMsIGxvY2FsX2Vycm9yKTsNCj4gICAgICAgICBlcnJvcl9mcmVlKGxvY2FsX2Vycm9yKTsNCj4g
ICAgIH0NCj4gDQo+ICsgICAgaWYgKCFtaWdyYXRlX2hhc19lcnJvcihzKSkgew0KPiArICAgICAg
ICByZXR1cm4gTUlHX1RIUl9FUlJfTk9ORTsNCj4gKyAgICB9DQo+ICsNCj4gICAgIGlmIChzdGF0
ZSA9PSBNSUdSQVRJT05fU1RBVFVTX1BPU1RDT1BZX0FDVElWRSAmJiByZXQpIHsNCj4gICAgICAg
ICAvKg0KPiAgICAgICAgICAqIEZvciBwb3N0Y29weSwgd2UgYWxsb3cgdGhlIG5ldHdvcmsgdG8g
YmUgZG93biBmb3IgYQ0KPiBAQCAtMzAzNyw2ICszMDM3LDggQEAgc3RhdGljIE1pZ1RockVycm9y
IG1pZ3JhdGlvbl9kZXRlY3RfZXJyb3IoTWlncmF0aW9uU3RhdGUgKnMpDQo+ICAgICAgICAgLyoN
Cj4gICAgICAgICAgKiBGb3IgcHJlY29weSAob3IgcG9zdGNvcHkgd2l0aCBlcnJvciBvdXRzaWRl
IElPKSwgd2UgZmFpbA0KPiAgICAgICAgICAqIHdpdGggbm8gdGltZS4NCj4gKyAgICAgICAgICoN
Cj4gKyAgICAgICAgICogVE9ETzogdXBkYXRlIEZBSUxFRCBvbmx5IHVudGlsIHRoZSBlbmQgb2Yg
bWlncmF0aW9uIGluIEJILg0KPiAgICAgICAgICAqLw0KPiAgICAgICAgIG1pZ3JhdGVfc2V0X3N0
YXRlKCZzLT5zdGF0ZSwgc3RhdGUsIE1JR1JBVElPTl9TVEFUVVNfRkFJTEVEKTsNCj4gICAgICAg
ICB0cmFjZV9taWdyYXRpb25fdGhyZWFkX2ZpbGVfZXJyKCk7DQo+ID09PTg8PT09DQo+IA0KPiBJ
IGtlcHQgYSBUT0RPIGFib3ZlLCBJIHdvdWxkIGhvcGUgaWYgeW91IHJld29ya2VkIGV2ZXJ5dGhp
bmcgdG8gcm91dGUNCj4gZXJyb3JzIHRvIHMtPmVycm9yLCB0aGVuIHdlIGNhbiBtb3ZlIHRoaXMg
dG8gdGhlIGNsZWFudXAgQkggdG8gYXZvaWQgdGhlDQo+IHJhY2UuDQo+IA0KPiBEbyB5b3UgdGhp
bmsgdGhhdCBjb3VsZCB3b3JrPw0KDQpJIG1lYW50OiBpbiBjYXNlIG9mIHBvc3QtY29weSwgd2hh
dCBpZiB3ZSBoYXZlIGFub3RoZXIgZXJyb3Igc29tZXdoZXJlIGFuZA0Kcy0+ZXJyb3Igd2FzIHNl
dCwgYnV0IHRoZW4gd2UgYWxzbyBzYXcgYSBmaWxlIGVycm9yIHdoZW4gd2UgY2FsbGVkDQpxZW11
X2ZpbGVfZ2V0X2Vycm9yX29ial9hbnkuIEluIHRoaXMgY2FzZSwgbWlncmF0aW9uIHNob3VsZCBm
YWlsIElNTyBidXQgaXQNCndvdWxkIGJlIHBhdXNlZCBpbnN0ZWFkLCByaWdodD8=

