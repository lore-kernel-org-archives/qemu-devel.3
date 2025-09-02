Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A15CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 15:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utT2m-0003Ns-Ad; Tue, 02 Sep 2025 11:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utT2N-0003Kd-Df; Tue, 02 Sep 2025 11:35:13 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utT2H-0005Mv-9V; Tue, 02 Sep 2025 11:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbEuk7Bj2+qfBePZKkS/79EsS3m7HDjKmd/I2pwadU9G+Kg1JaM1O+CkVUAOK6rOsxMWg1Yyy9n9qKcT63Isz/EthSwVDrMaUboerU0Vo4hxYGZlZbQM3tyYhqIPawZ9NkgDDZaoDYPkTobkLqp4gP+Bh8za+Ce4koWalCCdJhXzZl1mI396l8N8sug10STVYGC66dUmggfy+61LQsC9ibkiTb6iU+Y8hdAXY9Q6ztnr3d/af2/eKnGyvUtZLQKyEHlJKZk2XFgu13vXJlB5elI8EaEL+GWZS3J4tY3sEAGLyYqYJo6KabNC0lWSbVwcY5DslbptMUsIHoir2LabRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXeAbAfz1Jem7UjEg5gEURvIvYCcVaIHTNl3jYsEiPU=;
 b=GqVRiV7yn/Xmq5ytc5oKBtVsC413UubbGVlZK1XomL6uri4OH+BbaVjuFlBY+VHFUSHb8Lq78twXNi91atG+JkLeuIAfobeA2br8SlKOCfYqaijaDisWpYSHd23gPK9xyWd6dHpoKSi4tVlR1VrPZYQUyaUheU/Kk5u29FjC5XjTP+E/M7ST8bbm+HCCJz9Km723gZMagFJiN1S/sHTFXLrN4GKbK2hAVup/NEoyh4UhmzuhxwFvA9ZtbthcZc0X6QNzVwrborrpA+CLs6vgUafK/2CcdkiAaTjX+BH9423VeWIYW8q5SkqMclO+nCgCd9s0Y5hpVvQG2mZbg1l3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXeAbAfz1Jem7UjEg5gEURvIvYCcVaIHTNl3jYsEiPU=;
 b=LyDkAqnZ9DYahNrM5KUWek9wlTk6ejTgxCtL48DiklfXWpmWG5Ds1gz3/P0p8w1wUWPXoT/wcNWGxeE6OE8f1ZgWwHrEWDEfxjL1KWWPZEP21BXUlZtnD2hRcPY+NjenpVARCI4Vmj4j3Xi71ynlkhtTqromkFtbIzcmQawF/DlVvuVRphqDTQMaWcOjeA8JPzhZnmnd3eOCZJw5agVZ+oAKquw7ErQkXQmNEvlwECPRhiRbpoC38SeelcpJTUrhLMOWcE5wX4WVzZ+Hth3CUaSYka2/QlDvsa9oVzhwHdBiSDOxL83xRjBfyaHE85/Zwx4dgbWQSKcosAocck8KsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB6087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 15:34:49 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:34:49 +0000
Message-ID: <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
Date: Tue, 2 Sep 2025 17:34:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:610:75::35) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 42514f29-5e0b-45bb-83fe-08ddea3640bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3BXVnFHNm1udFQ1cXk5bjYvMjRIOWlGVlhjbG9XelhaMUhCNUI4clZIVUFx?=
 =?utf-8?B?dUE2WFBObVZBYVU1Q0ZuOTZTdEkyUXp5d1pLTmFsbXFVSFp2Mk15d295VVRW?=
 =?utf-8?B?S0dUVnFibXhaTkxFTTlDcEpVQ21ab1duaWZ3L2NhdHU1aW9vMWJQWHR1VFZw?=
 =?utf-8?B?LzBUVlFsRnExajI5dmZWcWZtdnFuSXZlL1NLQTh0RTZJeHdUcVp4bjZGQmpG?=
 =?utf-8?B?cFF4cjB1Mkh4cStjOWUycHlMOHREQjhPTTdjN010S09FcVR3QS9Vb2ZudXFB?=
 =?utf-8?B?QzFqVEgweDNnMU1UM1I5UzJLUHVDR1EzVzYzcmdJVndiMmpwUVR6ZUVHaU1S?=
 =?utf-8?B?QlB2dlNyN044TmxxVDFvNHRrV0FmSk5uTTR6eS9DZmh6VzdxbXM0Y212RWF1?=
 =?utf-8?B?VXp3aHlsWlZIUjhDVnNRWXdYcG9TR1dvbWFuNXltWXU5a0xRNmh4Qk9rZ2xk?=
 =?utf-8?B?Tjljc2dMd0RVcHArZTZaOHJrcG5OZHBrVGJWRkFWNFhVaXVVYTBWWk9DYlJU?=
 =?utf-8?B?UlVtdG9OaXVFU1VySFVUQlE5WEptY1JCbkVVd2pQZVNhN3BwNENlWGlBUDRw?=
 =?utf-8?B?K3dIeVBwTlA1ZGhnbDRWaE8wclh4WlR1TGNTQ1dRTHl0dFkrcUpyVDFTU3RZ?=
 =?utf-8?B?a1VrMFBobHlUY1g1K2c0ZGxzQlBrTWdYTXpZeWlJaGpYdThtaTF0NlhKd1ZE?=
 =?utf-8?B?VVhSckd4ZjhMajJEMFptSTVjM042OEZWeWx6MVVJamZBNzRGMDZkL3ZIVWVh?=
 =?utf-8?B?cVl3VEgwTmxmMXlhYkU3NWpTd3dpQUVYb25ONy9ub2cweUp2QituWGJGZW9P?=
 =?utf-8?B?UDRqS0dadkdnWUV4Z05mbDRkb1lrbURqeEtJZ0NEY2hwUkZoc3lXT29QcUtO?=
 =?utf-8?B?VXJBd3dldjBIelI2YUdsU3hVZjNiZWV3SW8xQkNCRmJkbjlBVGFoRTh1R25a?=
 =?utf-8?B?dXpZeUhUeWpQaDhITGhiS2ZzcXZjSDU4V25JK0p0azVvSlZDRFNCVW5GWWty?=
 =?utf-8?B?Y3ZtVlVpV3NqaFRsRHZCQms4ZlQ4MFdYNys2UGZ1Z1N0eVVVN0I5b0djZjFy?=
 =?utf-8?B?bFp4ckN3OVUyUXVjeUs3ak5qTlMvSnJmcytBTWVaa0Y4VVhnZnFRSFVjZlhC?=
 =?utf-8?B?YjA1QUYwWE9RNGkyUXRqd0g0SW5pMG4venhNUVp4VnZYckdScDNjeUUzQ0gz?=
 =?utf-8?B?S1M2Nzl1R1l5ODUzelpGV3pvSGRTQmJ2bXRqNUl2ZTBrak9vSjNlUUxPUW03?=
 =?utf-8?B?WmszMHFaMFVTU3l4YXFHOTRQenpCMVd6NjJrY0JyMTJqdXg2NHVrelJCbmVD?=
 =?utf-8?B?SGc4Y3dSWENtSUk4Zm1wZVhabDdiZnRWUS8wTC9aZGxPV2x3Y1kyU0xjUGVw?=
 =?utf-8?B?RVRBYmJQNk1HeU9vQnBQdEg0aUVuVVp1U3BzaGNtKzRCSUNqakZmejRpZXg4?=
 =?utf-8?B?WitsQ3AvR2lSMmRmbmxhTVJ2dGhTMm1iRDdvTFphcCt3UllwaHU4WVFVQTN3?=
 =?utf-8?B?NHprcTMvWkYxRnlncGMzK0NHOW9tUE4zZDlESi9iem1xdStKbHNxanRvRXZ1?=
 =?utf-8?B?b0pQRDJmbnNvRHQxN3ZZWk81U3A4N3Z4UFpFSGZqWWhlakdSZnBOZjVnUC9y?=
 =?utf-8?B?NUhnVGx0VmZPRlNkMnlmS1VCWWNScXpBdGxDZzdpODF0ZW5YTWpJOXNER0JJ?=
 =?utf-8?B?aThySzMzRyt3ckNabjF3ZnRnaGp6UFVsV3BvNHg5NGVLM1dzcFZQU2thVkIx?=
 =?utf-8?B?N245cEhYb0JGUDBKM2N4dStJd0psdkxGVjViMlcwNzQwdnI3MEZ2ZkpnQ1hk?=
 =?utf-8?B?UHRxK2VhZnZzVEVrV1g2WHI5UkQ4VmQxOTdtR2FzKzBacmlNZXRvVnNHa3Q3?=
 =?utf-8?B?NkYxMmc2WU5BbTNGQmsxRnp3T3puYkxHa3IrN25HbVloUU1IWGZFaDlTN3NL?=
 =?utf-8?Q?eKz9nXCl1k8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJwUklFTlZBTDU0TnFIWUgzU0tpS2RBeDdVaFBXbnpIZWlsRS84ekJmQkVH?=
 =?utf-8?B?SEpCd3NqSzJ3VUhqVTBBdFBaeklhaThtNFNXdDZPamxBempCK3pQbGxvUzJk?=
 =?utf-8?B?dHNzTm9BdTFIb0ZlMFVXTkR1ekdnMHQ0N3hwK0ZaSDIzUUZObkQwY0NCMktY?=
 =?utf-8?B?ZlFoOUpHdDdYcGN2d0pzWFpUdDVVYVNYaFZlQ0RJOWpBVUgwK2oxWGdvV2la?=
 =?utf-8?B?L1hXL2xFUEpCY2RuUHg0aSt6bHdoVlpmcC9pYzlrNGdyeUJqcEZWR3BQQitH?=
 =?utf-8?B?K2Y1S1l0eG1vNzl4Q3JQaUhobHp0L2dYMG8wYmhBRVVMK3FKY0ozSkxrZlZq?=
 =?utf-8?B?bDQ4YjBxTXV5S0pma05tQ1NYc2c4VVB1SEl0K3U5SnkzR2dROGJpcmd6S2I5?=
 =?utf-8?B?SEx6b0N1THQ5QjdQQnhDSjdOWElKaURtaEcrdlZBMkN3Rzc4SGV5eEU4dysy?=
 =?utf-8?B?OEo0SHZ6b1M2TlQwRThRNGJKU3ZLdFEwaFhGZW4wMk9idUhEWlpKek1qWFhU?=
 =?utf-8?B?ZTVSczk4L3F2Qkt6QXIxV01FNENHMitqbDFPcEZFc1VGNFg2UllXdU04NTFM?=
 =?utf-8?B?Q3hUeGU1Y1VpT3VSRHA0ZXRmVnJIQmRtN2N6aUJ4d0dOc1RIN0liMkxMSjhy?=
 =?utf-8?B?aTh5czdIeGNIYi9CNVplLzBERlBseHZVYmNxc0tlVmY5T2U0T0ozclhBMEl3?=
 =?utf-8?B?SjluS09Ea0lyTEVHUXdrSlhmbStrZTNMQXltVUhHR1BmWTFvenJyb1B2OWdH?=
 =?utf-8?B?R0dPWUNBbEdrT1B0Q1ZuMGJRQ3dsd0NGcVljdUh5UmIyWnNVSFgyVGprVmRC?=
 =?utf-8?B?UTZtTGFlS3VJTHRoUUdMMTREVEJxcEloTjNKNVpmTldXY0wwMXZzeXdjbVBP?=
 =?utf-8?B?NGk0aXBuNjFKREFPRmFibXppUGQwTUVGMU5lNGxWRVUrWU92aUtnelZSSHNY?=
 =?utf-8?B?eUt6ZE1mUW5DY0pseW1UZnVOUXpNdFBzT0NDeFE1ZkE1c2Nob0srTEVSc0lV?=
 =?utf-8?B?cnVqS2J4a1VLdTIrcjZ2NXFwMzJhMWszOUpGTW9WVjNFcGVGYW5Hc0JseElE?=
 =?utf-8?B?eGxDMjVLMXBkWUlWeHVyVjFtL1BHNDdvRkNLZTU4Q0hGN3JzN0xCV2t5MEdD?=
 =?utf-8?B?MWU4VytocnQ0L1VWKzBCNVBVQlAwN2Y3d291OE5MWU03V3BmRmpqQ2ozNkk3?=
 =?utf-8?B?aDU1MVd2Rit6VG5nMFk1TkpyaUJOeDJSVkZMcGpBL01FSS9kemJveUZ5VjlS?=
 =?utf-8?B?bndmazkwUHgwL3Y1NytLUUxPY01CSHpjSG1qU3BRVEdOblhMQm00bXMvYXJD?=
 =?utf-8?B?UU8renlMOUpIZEltck14ZldRMURieUk3alBLN25acEFxZk0ySkxIRVBGei8z?=
 =?utf-8?B?c09ZSS9SN080M1pYVG5GaGMrdVlXTG4vTGNSQXE2ZDVXQXd0N29PU3BjbGdM?=
 =?utf-8?B?UFZlS2tSRmNvZVJTWnVUeFd1QzgveTBwQURXZm04bGRGekVwMUlJa2FkZHJ0?=
 =?utf-8?B?NHFmN3VoaURqRU03YVo4V2J2bVR1OFRvTGpvNERseGtQTDlnQURESEZnN2wx?=
 =?utf-8?B?Y0RIZ0c1SXFpbDBjQmZ2NmZ5a1I1cGhYOGMrQVpLWWZUQXZDbjdyekowS3Bo?=
 =?utf-8?B?QnJGOFNMMVZxOXAybSs5MnMwbU14TWRzTk1aRldZNVJscXd1YmNGVXBhMWpU?=
 =?utf-8?B?RFZ6bUVHbzB6eDBydnhKbnhNQ2RvdTZUYy9MZUFCbjhQRkU3Y2ZmdTc3UnFn?=
 =?utf-8?B?N0lTYmdNSnJ6eDdGZDEzM1l1VVI3SDMyT0FMVGg5cEdadzBxdFBDV0Fla3dR?=
 =?utf-8?B?Vm13N0dEdkVOUXBSeldZM2h2STBVS0tXeWNueDk4MmEvWTBHWncvb25HbUVP?=
 =?utf-8?B?cjJyRmdtZDhhbHNrU0R4RGxBUnBRVXJsZkFhWkRuS29kU1k2cFZBMDdIUlp6?=
 =?utf-8?B?bys1c1dHVDVHTWpKUVpIUyswNjNQRW9iaU1JUEJTeTFhN29kd01ldDlXc2Fm?=
 =?utf-8?B?UjBnWmxQMWYza0xsOTFOU2E4cVBYT0VWdWNvMTZ1eEJzNTdzTTF6c1ZhM3hD?=
 =?utf-8?B?dHQ5M09oVG9oTVpEN0NrMFAwTlkxbkJrOWR6MlZYNmFXZCtSa0RqRFdCYllN?=
 =?utf-8?B?WEFJVEpmR2ZGazN6VnIwRkpjYU5PcDZMVjQ0QVhYWUVhbDEvZEErWmNwSHJF?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42514f29-5e0b-45bb-83fe-08ddea3640bc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:34:49.4315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hC0VRYiBmk8+uVLHXwheEDSpMgMryH2rJrdaXUQWRZqAbB909LGvjOAk8sVZb6QnPURvYWf3io1O2UMaFrwoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6087
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
> On 1/9/25 07:56, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The power-of-2 rule applies to the user data area, not the complete
>> block image. The latter can be concatenation of boot partition images
>> and the user data.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/sd/sd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 8c290595f0..16aee210b4 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, Error
>> **errp)
>>               return;
>>           }
>>   -        blk_size = blk_getlength(sd->blk);
>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>           if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>               int64_t blk_size_aligned = pow2ceil(blk_size);
>>               char *blk_size_str;
> 
> This seems to break the tests/functional/arm/test_aspeed_rainier.py
> test due to mmc-p10bmc-20240617.qcow2 size:
> 
> Command: /builds/qemu-project/qemu/build/qemu-system-arm -display none -
> vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -
> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
> chardev:console -drive file=/builds/qemu-project/qemu/functional-cache/
> download/
> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
> Output: qemu-system-arm: Invalid SD card size: 16 GiB
> SD card size has to be a power of 2, e.g. 16 GiB.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
> 

Hmm, then the test was always wrong as well. I suspect the aspeed is
enabling boot partitions by default, and the image was created to pass
the wrong alignment check. Where / by whom is the image maintained?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

