Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A28C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmjN-0004Nu-Uh; Mon, 08 Jul 2024 07:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmjB-000415-Tx
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:18 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmj6-0007rr-5m
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720438812; x=1751974812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xQVM7ylMlGKzxRaBVpQZpqXD9KGA8oCWP93OVr5usyQ=;
 b=u8Hag+pJfDP/S2Ct+sjZKxXA53O7XU+0ATXpcvePhGgbc8eVnV/Flmyw
 mEhmVbVbm1rXKr+9BFnGWyDRMgvfGUArO3YXYi+SysWDtmJDFzLhiNkvO
 McTIRDVz2Ef8KbRHYZm8UGjcFf/VLkPkA8VvWso9dleszWn0f7YKf9JbC
 /T/VlIthuo/qd3opdETTP2tc04uHFdf8SO1ZGYDRlhbYjshD/3VtlFzNB
 f7YFdHriqFLp7BoxLLRA3Rsi3k6Xgt0UN210LVWuv3/t5rWRqrvqjVzTI
 G7VZJoshqSV9pk7tz6UXZ6ijhVGQ2l1iTTuoTiZyL500b5ztRs5eQ3JTv Q==;
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; d="scan'208";a="16077477"
X-MGA-submission: =?us-ascii?q?MDEA7u1XtJwC04CN3vh+0fhaLBoa9W7HsmJZpq?=
 =?us-ascii?q?jvSKGvonBSfTxzN1pe/XEcJ9w9vEJGrzCDPH8ivUC+DIhj9ZZKR9QTis?=
 =?us-ascii?q?N5uqcbf2neWi0Zgea4BBtcqxSDubcJMBeP+L6tAOTz7N9mC/T5BbiHml?=
 =?us-ascii?q?wNg2rnT0/qzl1lTyuqNYUqPA=3D=3D?=
Received: from mail-vi1eur03lp2110.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.110])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 13:39:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diyPNUNr9Iq7gvKYklrjGuqsDcctOVYRU3+SVTgqjrjOWIfVm9XIEdIcvfA6/mPc8rbB4hqts4A8+3KvVWamNwEaE9ApXLQbv6xRsUY4HQUBLaLE59HRnSWA5Fw7+Kwk2grlE3AsLWdb5v77POfeY7tr8xHpLdDY9AS9dK+daOfN2NaEtkrWb8ihcC7QPNyJzluUI/ozpuc0LlJn4aSFNFO0awMoraEvB6Y8B7sNL0aJVyU7O0YD7gOpKXHCWnwzh76JgFoQi7O3Apc1FlbwfmVHrIy3qURiy4G++VRmbfJ0UuyKnKp20w4MmcjjTtIHII9Knu0MP7wQT5vzbHSdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQVM7ylMlGKzxRaBVpQZpqXD9KGA8oCWP93OVr5usyQ=;
 b=Vb2COn001I1r8BD1vvM6XWfwtLem1kW76yoZ7uM7R9eVuPexvxSGfw4J0iL+tHp6lcmatDqAzB1jq2YLfP4KyXJCaUWMxNST3oQBaJH326y88R1DKXaolRSSTqTMF2fV6aZDn86PQ6Ux6YQqGw4a5ITfKrGmpAjeH0bJGBhBg2IdrF4W6R3qiHH7VCdtdKTn91/cq8b8bqbSwBTO9CXjsNCXtrZY/9BgFUXADy3eEv2CAPe6FUMoK7eGiHNKn3zirqaY8LwzySq7KHeD8ePnEAs8xzruouQBZ9QolAZjmTQmgnXlB5E+fst+guBpoHn2FL9CyUaYYJMYLXq5aBgLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQVM7ylMlGKzxRaBVpQZpqXD9KGA8oCWP93OVr5usyQ=;
 b=oj7Kbzcz8OnvPnCbTVHZuUXPzTh/P1/j4ZWmhHRSIRoaY+pKL10SxUkmLGBaAl7iIveEwBR28lyKWI4hyWu/Iyj7eOj4Y3hfRukcgcehZDiJw1brdyDzotvaSNECDXB8sGSaElwE3DTNB7sQyFSi0UTzRzCnJx5Z/qHgiFQRv1xrZ8XJmqrMm15iVuoWpCzOkXaTimLY+h2f8kOyLAqxRxXIt4cpIDpm30XDB1UrWWVv2EOuxgQkRAkodh/48p4ef2aRS7+ETxQTXbpmBiFD8V2YYWHcMw3Wm0wQSqGvaXXBUR7SFAMKSjjfw77xPgN0KlC/VI9zdaq4RET3Y4tGeg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7400.eurprd07.prod.outlook.com (2603:10a6:20b:2a4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18; Mon, 8 Jul
 2024 11:39:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Mon, 8 Jul 2024
 11:39:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v5 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Thread-Topic: [PATCH  v5 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Thread-Index: AQHa0SuNdXrKd5AlR0+pdFBq0nmsCw==
Date: Mon, 8 Jul 2024 11:39:54 +0000
Message-ID: <20240708113908.19535-3-clement.mathieu--drif@eviden.com>
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7400:EE_
x-ms-office365-filtering-correlation-id: 1ff73dd2-0028-4898-9c1b-08dc9f42af7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QjVHYmpCWjZ6d1hmdk5YZVdRNE5oN1lGcFF1akRWYVhaSjFkQUEyandHWXBw?=
 =?utf-8?B?VHV6ZlZuVFdYWk9qOGxvelF6SEFGc1NkZzQxVnZkanRreTJoR1gxK3hBU2Ev?=
 =?utf-8?B?Z3BZeFdFYUxmZ3hSMmtoVkI4NUZhc0VRWDBXOWRDKzZtY2VyeEowVFVCSWox?=
 =?utf-8?B?Unc5Tys5QnNScVhzMXZwMWFpQm96ejllcFhKL0hlZktoRFcvQjNNR1hJSlpI?=
 =?utf-8?B?b0ovOVY5ZVlwV2RZcC9MMzhpbzIzRG1hdHJQaDVHU1FmTHlCeG1mWFdRVHB0?=
 =?utf-8?B?RThHYkNzQytqZFpibS9BMkVwbVErblh2ZENzS0NrMW5BV01xSWQ5czhRYlgv?=
 =?utf-8?B?VE9TSU8yRXd0S3lIWXFLWWpTdG56THdPQlBUMDNzNmJOQ1FBcHRlQVhjbG9x?=
 =?utf-8?B?dEoxOW9BdERGSmVOSmRhSnBxL1Uxc2JIMThLQ0Y2NllVL08vK1BJRTFadCt1?=
 =?utf-8?B?T0NkdnlZeWs4S2dmNjllajZTd3NlYVZEcW9GaDJNL1FySmJ6b09lT25nVXo2?=
 =?utf-8?B?N1FsTU5GR3BPTWwwRWJXei81SUMwWHFrU2hHSHVJTnc3Q3FQanFJdDlKQjhq?=
 =?utf-8?B?amtoNG1qcmE4U2o0N1lNeFAybENrcmVSUzFMdHJNa0NkWmpsSGxuWm9BS01P?=
 =?utf-8?B?c1AvbXdSa2N6dEUxNmFjZ3JpREdmZlFYYTZab0F1VFI5VTVzSWZFNXR6VVRj?=
 =?utf-8?B?aWhIVzlVTlpzUnQ4b21ZNkRaK3cxVXU1TllOZHF3R1JuYjFXMUVueU11bmRS?=
 =?utf-8?B?V2lMdVlxcVNNQVA4MjZSZjd1aGh6ZTJRLy9takZLalpacEpvV0dqQUhOSWls?=
 =?utf-8?B?aFUrZTFPSFVCTnpzM3VhR1I0YUlST0NqOFhGcHM3dk92aFdpMTdhMXpEeFVZ?=
 =?utf-8?B?SjR1ellYNXhrUkFOYi9ZTW92amtleTVMVExjbTdhTkhySDhjSGtvNCt1Y3RC?=
 =?utf-8?B?WS9PZEtpeFd0U3A4N0RRakZvREt0bmlSR2tFODU0MWEwVXBlS21IWC93V3hJ?=
 =?utf-8?B?Vkdsc2FNbjU2NGlNalRRUWZEN3cwNW0wYUFoOXFZOHg4UzBHdWs1eDJ4aDBC?=
 =?utf-8?B?amtEMmpZY0UrT2pjVzQ5eDAzMDdpUE5uQ3BJSmR3RVlwN2tTOVM1d2tjbWY5?=
 =?utf-8?B?bUszOG0yaEFIQk9HT1NVc2NXVXFTakdFSU0xazV3eHJRaTdVRWpndTIvNkk0?=
 =?utf-8?B?dkxwbVhvNG1xZEhjZ3BITTVKU0RrSHhNQzRoQ3NLVWdyamEzSmh1RWlIVkJi?=
 =?utf-8?B?WGRPcWlTSU95WlZyY2U2YW1ndjB6MGVacVVxYStrNnh6SllYY2JZclNpR3BS?=
 =?utf-8?B?VTArZHUyUmVEdmVSRU96WXdpZXR6OGxWcWVEdFF4c2UxVng2ZTNLOVFwdDVH?=
 =?utf-8?B?ZjVFaWdFQlVDalJLdGxMYUJsbHB2UEwwTnhFS3lYaXJ5dWlUSWZUZXMyUzN2?=
 =?utf-8?B?RkwxUEY5Yno2SnU2VjNtOFZXR1hDTWVRUERqMFYxcHM5Q1d1Q1o0TkFFNy9M?=
 =?utf-8?B?SE8wNEQ2VDR1ckZSSWdCem9RaDQxSEJTUHJ5NFY3QTFYVExHeVgrdkRGTExr?=
 =?utf-8?B?N0p5Qko1b3NKVzNHbko5OFlESi9pdEtsV1pTcjFITEtTeldxdW9oRnJmWHY2?=
 =?utf-8?B?V1FYaVM5UmplNm4rK1RoZUNIZ2dwZUV1VFVrcXdIdTVlZWJTOXBXQ0UwSGM2?=
 =?utf-8?B?TlhXTXRxQjZqbUxCa0h3T1FiU1FFRzVGK1J6ZlVDdjJ6bEljQm9QZE5ad21D?=
 =?utf-8?B?RThvTVJmL0RweGZWWkhqazVudDdRaExTdiszMzFsa0MxbGZvdEJDRGpZbG5o?=
 =?utf-8?B?ajB0cml2YTNuR1cwVDB0K0RkNmhuVENZRjlzSFQ4VHAxd3ptYytXT2R2TkRx?=
 =?utf-8?B?SDZCOEFMa2Y3bjRwZDJmL2tXamdJZGNqcms4M2VYbFhkOHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aldDYTRoTHBVdm1aN2ZzOVdNS2VVU3dBNDhCVWlUTFZZQ3A1YkJEdnJmRnpz?=
 =?utf-8?B?bEU3YjBDNW95RFdWbTEwdHdBbXFCRko0Z2w3V1B2akgrWWtiTzFacUgxUU5Q?=
 =?utf-8?B?bVNaQUxqWGZMaGhLOVNuMDJ4ajdUMHZaWDEwaXhQeW1aV3RTVCtNVVpDUm9K?=
 =?utf-8?B?ZE1ZRzFaMDIzRnhhUERPcFk1YVJEdnp3S0NNZEdsdlpyS3dLNmdBaDFLWFVr?=
 =?utf-8?B?blRrSVE1RlBpZ1o4Z05ERURlaldWOXN1ZjlNNjEybFdaa0dZN3FoUDJla1Fz?=
 =?utf-8?B?dXpIRXpPYnhycUdvSGs0RzNBQktvR0FLOStTWHdQVHBrSUp6S1daRkZzaUdm?=
 =?utf-8?B?N3p6S29RRlhwSkdnMHJaMVcvS1BXNnZjN1VWMDBzVWl1WVJ3ek95VCtkWjM3?=
 =?utf-8?B?Z0ZGWEpJSUIvZGk1NGV1VUlxdlFaYXBqNm9nMS9tajVETEhsZUZGMVRLVStu?=
 =?utf-8?B?bUczQWtMK0lmbTBtZk5xZ1hQYmhQbk9ZQmZsNlRiUmkzT0M0dHNhbHJuNy8y?=
 =?utf-8?B?bDVNV0xGZnVzZm1uZFFmSDBUclBqM0tjOUg5RHZUY0FxWisyZnZlNStUbitm?=
 =?utf-8?B?bWlSb2IzczgwUTBoNGVzQUlqRk9NM1FNaWZyU0gvelJacXBPL1hNQUppZTd5?=
 =?utf-8?B?VTV3S2IzeWp6Y1JnY1c1RDNiZVMyNEZOcElZc04rWktocWVHOE5ZUTh2SVpa?=
 =?utf-8?B?cWJPWTVBb2FuU1pPL25nMDBMbTdQTkFMVHJWSlowOEd5dnpuZHBTMWEwVjlN?=
 =?utf-8?B?WDhOcnA4YTlpWVJkOU15Zy8wVHBWUHdKbnlod1ZGaHBibDRZQU01bTkrTjcr?=
 =?utf-8?B?Y3gvTSt2ajJBenhLWGtiZGE4TnVza1pKRkhYRGRmcFRpN3BKRkdicjBSN0w5?=
 =?utf-8?B?ZFBFcitNYkU4b3o4RElLYXRKRjhGaHc4bllQdit3ck02KzAvSTNybmtqN3pQ?=
 =?utf-8?B?c0NZWmtWQWloVGRtVEdmWGErWEdnSzVSZXpTMWZDVmlDdTc4N2hidmQ3Z2Zw?=
 =?utf-8?B?elRDWTdxS3ZVOXRCREk0UzZ5ajFyakdwL1dXRzdpeENqN1psc2cycXVqWElV?=
 =?utf-8?B?cWszNGRjSkJhYmVhZ3lDVEZGeDdRMkdBNmhDY080S1F2UE02TnBQTkVhU3o1?=
 =?utf-8?B?M1E0NU84bTNCN2hDZjVXVlRyZ1NGU3hMUGFYcnRpUGVuWUJHSDQ2WW9zSW5a?=
 =?utf-8?B?NVhZaGlrdFJmT1prSkNHamtDMnJxdWV3MEoxT1pkZjIyS3FWNFBvYmROVllO?=
 =?utf-8?B?VDNwZEJ2b3hvcEJ0Mmc4UU1ucHo2SVJBajhnZk9aSzZYYU00VlJBSXdtQ0NZ?=
 =?utf-8?B?ZUxKVU5qWE81WTgrZXJ1RTVGNEZGemxBanA3ZlBRNlBHQjJnOWZuZVhLcjlT?=
 =?utf-8?B?blFpRm54ZEpOQzVQSzdsT2s1UnhUaERBRCtrRGpuT1JWaTNjZlY2OFFUNDR1?=
 =?utf-8?B?ZExOVHIxdXlMQXVocjhSSWY2R0N1dThDdkZTYnJVSEk0NXdOcnRDSzdBV1Fr?=
 =?utf-8?B?M042SVh1WkVGYmxtay9EeHkvbUJlRDNDQkdBUnA1OG1qWGxJMjBLdHUwa29x?=
 =?utf-8?B?NnJjMFZKZTJhSGgybXZqMmRWQWlsbDN5WkU2Vm5DRGRPL2QxYVh6VW1jQ0ZV?=
 =?utf-8?B?QlROVXFUYWtHbjJFQVloSzFsQW1GUnFXWmpSd1h3djNYakl6amNoeS96Qks5?=
 =?utf-8?B?ZUJOOWxQamhETHUwb3VFR1FPekgrUWMwaGZXME5PMTEzVWg0TGQ2Wkdua0pj?=
 =?utf-8?B?SWljMXhySmJYK3d4M1BJTTlzaEV6M2daTDFRSERJa1RZS3JVMkxEdDkrVTZV?=
 =?utf-8?B?eEQ0cjNRd3JtOHpQVzVJSkw0NjVVa2dnQXdFTk05a2RVa1lIUGRoSk9jUEZm?=
 =?utf-8?B?ellpYXVJcXZYTnBzOTkwYWVzTkFYRDZXSXNIcm5YTzk3elFJb1FMMkFBTlFF?=
 =?utf-8?B?by9KQ0M5RUswZlByWVhxazQwSm5xYW9jeVc5aTgrY2g3TTJyRkI5eXdHdklh?=
 =?utf-8?B?UEhrSEYrN1pwWlpqcDRhMjNkenlyakxqRVh5ekVwbHErRVpJSWc3TTBuYk1N?=
 =?utf-8?B?QXBjY1NHK1IwaGk2ODZOaHg0VWJLWXdsQjJRUzJRVVRNOUpBbnNPQ1dWbUxy?=
 =?utf-8?B?VmovNVlOZHRGVWprWlJDQTNQdWpiTVYxMDNOOFkzYWxXd3dHQkR1RDl5VUU3?=
 =?utf-8?Q?GsDDfmaNSj1f4b4ScyOdJGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CBBB09A47AF9C4BB29D2F88CE1436F2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff73dd2-0028-4898-9c1b-08dc9f42af7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:39:54.0565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwgmdMLQ9ypHrY6cf7Cmzxwaeco4/aXiCmPYou2HO5wNJlCfApCgjyaVqstPLgWGZatT0/aDaHX61sFGsGMVa2AW1Q4Fuiz4nTRt+0RlEqmFNdjujV3Q1J+GPVNfyEWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7400
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZXNlIDIgbWFjcm9zIGFyZSBmb3IgaGlnaCA2NC1iaXQgb2YgdGhlIEZSQ0Qg
cmVnaXN0ZXJzLg0KRGVjbGFyYXRpb25zIGhhdmUgdG8gYmUgbW92ZWQgYWNjb3JkaW5nbHkuDQoN
ClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwg
NCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggY2JjNDAzMDAzMS4uZmFlYTIzZThkNiAxMDA2
NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtMjY0LDEwICsyNjQsMTAgQEANCiAjZGVmaW5lIFZU
RF9GUkNEX0ZSKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZmVUxMKSA8PCAzMikNCiAjZGVmaW5l
IFZURF9GUkNEX1NJRF9NQVNLICAgICAgIDB4ZmZmZlVMTA0KICNkZWZpbmUgVlREX0ZSQ0RfU0lE
KHZhbCkgICAgICAgKCh2YWwpICYgVlREX0ZSQ0RfU0lEX01BU0spDQotLyogRm9yIHRoZSBsb3cg
NjQtYml0IG9mIDEyOC1iaXQgKi8NCi0jZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgo
dmFsKSAmIH4weGZmZlVMTCkNCiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZh
bCkgJiAweGZmZmZVTEwpIDw8IDQwKQ0KICNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAg
KCgodmFsKSAmIDB4MVVMTCkgPDwgMzEpDQorLyogRm9yIHRoZSBsb3cgNjQtYml0IG9mIDEyOC1i
aXQgKi8NCisjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4weGZmZlVM
TCkNCiAjZGVmaW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZhbCkgJiAweGZmZmZVTEwp
IDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9ucyAqLw0KLS0gDQoy
LjQ1LjINCg==

