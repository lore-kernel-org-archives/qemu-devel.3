Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9510F3C9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuqA-0000Tz-7n; Tue, 24 Feb 2026 11:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuq6-0000Tj-4t
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:00:46 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuq2-0001WE-5J
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:00:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKSiKWTFCeXw4UP4lSpKc4EN7MvZx4HvlaXNnwZNPVFnvisNbe4OkAnI1GT/yryYET8vThXcF4rs7OWKYy/S+dhsOJ5Gv//aX5SvghsyNMdod1zT1V0KAZB6lcXBX6Tk1xTYboZXhjNfLoCt3bv5qBi0YL0LSDA0GH2xopzhtmUcEM1f0ZOxpnmAGdPuPhMH4M3A0cJOAzOoYQn7YI2rlL5L2P09+xkh8eKOmv8l2a3arfR8iXB6AlkWppXyTNPJ5psaWho5fxD2jDxYmf7pX59nLbp0GASnW5c2IFjBEbRJnoXKVENnxJFtKDx93yKMPmCjHSFLtfFa4gqRNA10Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q69hNXwawucHKJ50UCJzoh38UoKFwQt2bN7/DFlbp1A=;
 b=JU1NlssrUSxua753rgiq/OMeR991CSdqjrye/SqzgOX60Dvl46DzYML2t8SmO7kGBEcZ4+OPTDV5GtbHLhgw4Pm2xwqw1wiZwMZv/D2mUUBTTp2x0Fk0+Fqo8+AgHlDOdoFUJHW9O4rbmllxlgArpAJuN6MTAXQC3FRE702u8gsO8UfT8GaQQYQeaZ2Hsx7QNfzASHEGvFMzqG1TkasdnGLxXk1DI/4pZJ0/0rVHHoBG2OISSxbS3UBs0mnGlKxo/ZPh/NMih87jv7u+VEeB92ob9+RXsXW+C3nBhgfsdxiqHzt3arXTgdlX/ILqDZpB3gmnWurkNTUNE8BvWqpWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q69hNXwawucHKJ50UCJzoh38UoKFwQt2bN7/DFlbp1A=;
 b=fy1HAgPmqms66dfdKs1Dh4FuM2mzg9valRYXdp9s6L3gAuzmwNN4/ZcG2E5MHFVOwwyx+SgQUymBvnJ0O19ccC7H/RNT9QkY7XZaI6B0TOaV43fjuE0pPZEGOdHero0Bbo9ZFXPOZri6XScMn683A3J/BD8O9bSae9yNvrJ2p0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:00:30 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:00:30 +0000
Message-ID: <8096590c-bf13-4e5e-8167-ab38a37180bc@epfl.ch>
Date: Tue, 24 Feb 2026 16:50:59 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/7] linux-user: make syscall emulation interruptible
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::26) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd94c19-6fca-4ad2-0d01-08de73bdd554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHlaQ2oweWZ0N2xlbnlsbEZoUE5yQnpHVjlvS01MTG1McVhjUHlQM25mUUpr?=
 =?utf-8?B?VWUyS1orRXJTTjZhNkd1Z3JCVDBTN0lYMEt5NUxRZndSRHl4LzVINWhwOE1n?=
 =?utf-8?B?clVVZ1YzOGxibzRJcTBtSWNGcmJVOFh1a1c2YnZKbElQRHM4ZVBaRnFSbW9m?=
 =?utf-8?B?bnY5UmVjN0xTWHVreDcyMlVpL011R0FLdWFnbHAyM3lTZU0vNnpqSGJ4UCtk?=
 =?utf-8?B?NU9RWXpYK3hoUmtPRnhVN3hPejN0WlZhNENZL3lyeFVuZ1RxZTY5K21ML3dr?=
 =?utf-8?B?RitjRGZ2UGJpd2IzVVVSd2toZlU1b2MwTjU4MUVISDlVMEZHNkhzdHBxYU1B?=
 =?utf-8?B?ZGZQcXRJdFdlVFVUSUV5UzNZbll6MGcrZXZwaFRMd1FCWEQva1JBZEFLbFFP?=
 =?utf-8?B?YzdKcGpvUlZBUENhY0JveVBaU0VFSmJEYUsrK0kvSU9PeG1USy9TbCt5eHhh?=
 =?utf-8?B?Qm0xMWpKL3JIdDl5K0pFaXhZMm1qZkI4R1ovenMvelRZUm1oZGhjSFhwTjBC?=
 =?utf-8?B?cXlYTzRRRkRVdUkzWnN3UDZOV2twNGtGYXpaNEhWTDVWRUhFVmdLMlkrcFFY?=
 =?utf-8?B?Z3RHWFBhQi9tai9zQXRRaHFsSzVZY1hLc1Nrd0NRZlJtZnJxU1pub3Y2YThF?=
 =?utf-8?B?L24wRWVIalliSU4wdTVLQlQycURidHNZTGZ1bUtuaDdWMEFjYUF1ZGc0ZVBM?=
 =?utf-8?B?UFRQSUFlOEpTR0lsVGc4TllKMmllM0FpWTJjR3UybHFGVnVRdUkvVkdLeTlq?=
 =?utf-8?B?ck4vR0l6ZkxTWU9Od1hSRmpkY3NqZkZ6RUI4QmpSNHNXWVFsU2o4YjlBaUc0?=
 =?utf-8?B?RzBBWjN5SnRyU3QwcktpcVlqY0pVWXUvbEdyMjR2VnRGNUFRK2hFc0JQVFNU?=
 =?utf-8?B?YVZ4WTNxN2JnbUZiYUwxT0NZN01HVzlQSlBaclRjWGVQMi9Wc1hOcWJmNG5a?=
 =?utf-8?B?bXJWSndjQjBCeEQydXBvcVduSTM2M3dZdkFmUW9TeFp1OXJVY2Q3NWhFMTU0?=
 =?utf-8?B?M0g1ZjZtZjdyN2hQMzZRU2Rzc0dQWHVJS2pPdU9FRDUrZCtSU09QOHJBZVZ3?=
 =?utf-8?B?citxcHRUdjlwcThnR2JGejE3RUh6ek1DTzZQV1h4Q0FiVWR2cmFyaEpRSVJw?=
 =?utf-8?B?UE1HVW90dVRralhzNGpiNmlZQ1pyVXRiek5YKy9Qckk3OHlBSUEzbEhmOHRU?=
 =?utf-8?B?TGVXWmlpTmJETGt1dnZySUpPWXBWeUxzWHBwajdhR1JxY29CeWthSDA5VTdL?=
 =?utf-8?B?R3BFRHFKWWN2dXJGdVZrY0hoLytvS1ZzMVVXNjVwNnl2NTgzVGRlVnlYUHBO?=
 =?utf-8?B?RE05THJBeGl2L3g3UmFCQ0w2R3l3aTArLzFWVFRLNWExTDM0TEc3VEljZHVN?=
 =?utf-8?B?RnBkcHU2UmRwU1B0Rm9TOFZGT3paeE1uZEFUeXFRdXgwNkNCQWZhek51cjFw?=
 =?utf-8?B?dGNHZHJkdW1pSEc4TnFhTHZ5ZVh3NzVzZnQ5dGc4Mzk0dzRoRzBYNXRDUE5Y?=
 =?utf-8?B?V0I2VWY1Zjd6T0ZUSVFtN1k4bzBTYTczOTZ3SUozOHpjRzV1WEZUWGNZS2c4?=
 =?utf-8?B?OEtzSVQ1cHJqcitUWTBIdmlEMXVSSytyYi9PUU94Wnc0Q24zb3FCWUgrK2xi?=
 =?utf-8?B?R1V6NjFJbmF5Q0RhdlBodUQ4ajNibTljY0krVUIwMDZqSEI5Rm5YM25BSHBU?=
 =?utf-8?B?QzFWOW1IV3NFNkZ0NzBtWUpyc0tQZzkzZjZvRjU5SVRsUW9xOG00MXJBTlUr?=
 =?utf-8?B?RDYvNWdIZDJBM3p1YlEvbW94OGcyV2hOV01KR3MreElmcldJMk80RjcxbjdN?=
 =?utf-8?B?NEJlMGxJWEJMeldpbTJYaGNrUFZXMkNqdzdWVktZM3J5emIvNUdtbXg1NEdR?=
 =?utf-8?B?RWMyNEdrRm80OGtodDI4UGFPc0I1TjVvUzZrNGhYQXJNdFNxMDVLRVdmdW9l?=
 =?utf-8?B?YmRqcXFRTFlNSEZEVU1CR2pLdkowaHRLMjdzOWFQa3JBWDhjQlJJKzlCM2Z6?=
 =?utf-8?B?dmRhd1Q5UVk2MWVYaXlyYm9KYlU4aWhlVWpiZlpFVkp4VnBzNktjRnFTdThN?=
 =?utf-8?B?MmZnRmJKSWFvdmRqRkVVTGd0N244eXhZK0pPVm10STlTbWNaelY4NzlpT3ZC?=
 =?utf-8?Q?Q0ss=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdOdnpoTWtrVStkODRsT2ZGU1REVjZYbXdscVlwMlJMWFNzVTZnZTc0T0NZ?=
 =?utf-8?B?dWpydEFWQXZxcUd6UFhsbStlMEZ4VHZIMnZEOG5uQXZXc3RxQWhyYlA5ZWo1?=
 =?utf-8?B?UFlTOURHcW5pRVY5djJ0dE1DejRRdVZ4bS82MzlMazY0RVY3citjSWNzR0pM?=
 =?utf-8?B?OXlFWktTcHVCRTgxUG0xS0dQc3h4QW5ndWdGUzdPMjFHVFJqckFNMjRaVzZP?=
 =?utf-8?B?NUo1Z3ROK1NXL2hWdTNyVStzcHVpZnFLSStkMGhBOVVrb1VqZi9SUm5keEJ6?=
 =?utf-8?B?MFNTV2lTSDNNU3FPSFFTRkU2MnRjTW5lc0JEeDh4dTVIODF3dUQ4bzhhRytF?=
 =?utf-8?B?T20xK2tOemdMOTVRcGZON2J2RzZiV2JFb082Q1VxQW9JQ2l6dTB5c3FVT1N2?=
 =?utf-8?B?OWZMR05XZVFWY0JpNDRiU2ZmdUNNdVFjb1RTeElpRGVDNFRWbTEwTWFFVFMv?=
 =?utf-8?B?M2FCTE4yelErRmwzMWZZZTZFckRWT24zdllPeTJwTzVmYno0emJiUXJaL2RO?=
 =?utf-8?B?MEh5MXJOQXYxMlRLS2JPTmpjVm1IaUkreWhCc0pZYVduMzQzSW5IcFUrSGFG?=
 =?utf-8?B?aFdBTFZwcmFCTTh6dDNUY1gzN0YrSXNIS214Q1Bjb2JVbVJXM051VUpSOWVU?=
 =?utf-8?B?Q1FldjdsSFV1WnhEVWUyZ0xyeFQwYzFJNVlvYm5qNC9qY25mTkJIY2VPdGl2?=
 =?utf-8?B?dmpqOHZENDdqQjMrRmlMVHMxS3M2NFhxVXpqOUpVWWt4WXE4QzNEY3BGZEdP?=
 =?utf-8?B?cmhtT2dJenVTcmMvb0xrK3BraUw2ODZCSGZtQ25QMWVzNDJaMkhxWFA2Z0No?=
 =?utf-8?B?dUhMTWhNQlBMNndhMURwdWVJdEJWcmtmSlVUM0dWdjRiVndzMjdKL1IrR29v?=
 =?utf-8?B?ZGhNWURHaEIyYzQ4bjBRR2NaT0V5d0JxSWpYMi84bFVMWWl1NHlWcDNHVU1u?=
 =?utf-8?B?VzlvT0Foa1NnWS9IM3NvNm1qcDhJTnRXWVNCWmJ3MGVkRWJxa0t5UDFFYUtY?=
 =?utf-8?B?VVlxbFY4c0dGWFdTZlA2eVE4cTllT202aThOVWdtdlcwWGh0eERleG5QZDh2?=
 =?utf-8?B?Nll6L3pvYUpIOVQxeFhZVUVDQ1RBSVpnL1dsREVkaVRwdmVkSjVURG9wazZB?=
 =?utf-8?B?c29mZFZJdVFJejNEWkdJTTJzaWF6a295VjEvNlZrR2d6MlJiZ1N1N1hLdVA0?=
 =?utf-8?B?OWNiQlMxQ1k1UHNkdW5HOUJiRG8rLzZlTC9VL0d6VnNHOGhhTzhZL1o5M3dN?=
 =?utf-8?B?c29HTnNtS1BtNm5aQWVOdTE5VnRBZGdHSGpEOFlnb0ZROUlJS0VCM2ZJbHVy?=
 =?utf-8?B?OFY1aEFyQmFuUC9PN0hGYjVxa1RYUHErNHpuSWJ6UG85MEI0NXV0eUhqL0Y3?=
 =?utf-8?B?TVNwbXdOQUNaREZvQnIwaC8yc3FyNlV4cVFqUWZQNHBsU09VbVByMDllTUFm?=
 =?utf-8?B?WmRyc0wyMnFsS1dXekd1SGRvUnZwSkFoU29QODkxTXFRaG9JWFpxSUpZVlpE?=
 =?utf-8?B?YmlyZElIT3NWdVBQZXQyRXAzS2lFVGdaVFhUTE02TmlwUXFtY1Q1dXZObUxN?=
 =?utf-8?B?THhtQmx5VmtnV1JHdEJ3ZDhrMEdrN1FibjlySnVaekExYlZpM3pmL1NvRThQ?=
 =?utf-8?B?bW1iU0FraTRnRmN4WXlzUmprNkJBZ3VqTzZYREdXeitBZk1TYy93QmQ2bnIv?=
 =?utf-8?B?RGg2bDEvYTBlYi8xNjFLQ3owRncyY1BzVHlXZUJNSVBrY2pRODRKd2M1Y0hr?=
 =?utf-8?B?ZjA5NC9GcVRpSk9GNDFyYkxwQ3MzTjhPMnVpOWJuNzZRK0hHOXl0MG5mVHNY?=
 =?utf-8?B?dFU2VDVNTjBkNjdsN2tiTWJSdzh4Q3l5aTkxQUNFZndndUE5WllCcEs1Q2M5?=
 =?utf-8?B?bnl1Sk9pRGpDR085K0FUUDJyQkI1aHJaVk5wejlURURuaHg2OHhGVHJTSVNC?=
 =?utf-8?B?b2tQd041ckwwSUxCcXdvSTZETXo1U3ZVMEUxUVdjTkFWR1d1d1FzY0JhWWJD?=
 =?utf-8?B?R3FxMmxUM1ZXRnZQTVdKVVkrMDBJdWJ2ZktLYThMc2p3KzMzZmJ5NWdPYzdo?=
 =?utf-8?B?UXMrajVsVW80a1ZpalptMHptZzBUTzV4UE9xWjdWNEZHQmhudDBpNTVIM09C?=
 =?utf-8?B?eWZCUGFaamdyN29OUVVqOHZZMzFCSWRJOTNoVnNzTTFweEcrRVN3NkZ6VmhD?=
 =?utf-8?B?NDNWaytOTnpnR21CQlBkWEFZQkI0N1FueFFGWkZMc1l5bWtFSXpoSmRMcWt4?=
 =?utf-8?B?aWoxWnp2Q0F6bEFUUDdiQ0VrUUNmNGt0VHAyZ1hRR3pLZFFPKy83bnl0MGtB?=
 =?utf-8?B?TUJUV05nL1M2YkRTeU5nQ0kydzhjTGZLT2ZtQ2l4dC9lL0ZvZlhOdz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd94c19-6fca-4ad2-0d01-08de73bdd554
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:00:29.9809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+fg9Sz3zVvcBqKodw6hp52vCiFFPeC1poOeKT7xpQYkuR3OkokoV+BbCbJF/E23mHBdP5hCm8OfbvW59oxyv/93ns1cIXOODps8+mmJ8yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The syscall emulation code previously wasn't interruptible via
cpu_loop_exit(), as this construct relies on a longjmp target that is not
live anymore in the syscall handling code. Consequently, longjmp() would
operate on a (potentially overwritten) stale jump buffer. This patch adds an additional
setjmp and the necessary handling around it to make longjmp() (and by
proxy cpu_loop_exit() safe to call even within a syscall context.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 linux-user/aarch64/cpu_loop.c      |  2 +-
 linux-user/alpha/cpu_loop.c        |  2 +-
 linux-user/arm/cpu_loop.c          |  2 +-
 linux-user/hexagon/cpu_loop.c      |  2 +-
 linux-user/hppa/cpu_loop.c         |  4 ++++
 linux-user/i386/cpu_loop.c         |  8 +++++---
 linux-user/include/special-errno.h |  8 ++++++++
 linux-user/loongarch64/cpu_loop.c  |  5 +++--
 linux-user/m68k/cpu_loop.c         |  2 +-
 linux-user/microblaze/cpu_loop.c   |  2 +-
 linux-user/mips/cpu_loop.c         |  5 +++--
 linux-user/or1k/cpu_loop.c         |  2 +-
 linux-user/ppc/cpu_loop.c          |  6 ++++--
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 linux-user/sh4/cpu_loop.c          |  2 +-
 linux-user/sparc/cpu_loop.c        |  4 +++-
 linux-user/syscall.c               | 16 ++++++++++++++++
 linux-user/xtensa/cpu_loop.c       |  3 +++
 19 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7f66a879ea..e7f643d69d 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -181,7 +181,7 @@ void cpu_loop(CPUARMState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->xregs[0] = ret;
             }
             break;
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index f93597c400..bef196b1f5 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)
                     env->pc -= 4;
                     break;
                 }
-                if (sysret == -QEMU_ESIGRETURN) {
+                if (sysret == -QEMU_ESIGRETURN || sysret == -QEMU_ESETPC) {
                     break;
                 }
                 /* Syscall writes 0 to V0 to bypass error check, similar
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 40aefc4c1d..19874f4c72 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -399,7 +399,7 @@ void cpu_loop(CPUARMState *env)
                                      0, 0);
                     if (ret == -QEMU_ERESTARTSYS) {
                         env->regs[15] -= env->thumb ? 2 : 4;
-                    } else if (ret != -QEMU_ESIGRETURN) {
+                    } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                         env->regs[0] = ret;
                     }
                 }
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 5711055aff..9464246e9e 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->gpr[HEX_REG_PC] -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[0] = ret;
             }
             break;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 972e85c487..bd3b67059b 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/compiler.h"
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
@@ -123,7 +124,10 @@ void cpu_loop(CPUHPPAState *env)
                 env->iaoq_b = env->iaoq_f + 4;
                 break;
             case -QEMU_ERESTARTSYS:
+                QEMU_FALLTHROUGH;
             case -QEMU_ESIGRETURN:
+                QEMU_FALLTHROUGH;
+            case -QEMU_ESETPC:
                 break;
             }
             break;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index f3f58576af..fe922fceb5 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)
     if (ret == -TARGET_EFAULT) {
         goto sigsegv;
     }
-    env->regs[R_EAX] = ret;
+    if (ret != -QEMU_ESETPC) {
+        env->regs[R_EAX] = ret;
+    }
 
     /* Emulate a ret instruction to leave the vsyscall page.  */
     env->eip = caller;
@@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
@@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
diff --git a/linux-user/include/special-errno.h b/linux-user/include/special-errno.h
index 4120455baa..1db757241a 100644
--- a/linux-user/include/special-errno.h
+++ b/linux-user/include/special-errno.h
@@ -29,4 +29,12 @@
  */
 #define QEMU_ESIGRETURN   513
 
+/*
+ * This is returned after a plugin has used the qemu_plugin_set_pc API, to
+ * indicate that the plugin deliberately changed the PC and potentially
+ * modified the register values. The main loop should not touch the guest
+ * registers for this reason.
+ */
+#define QEMU_ESETPC       514
+
 #endif /* SPECIAL_ERRNO_H */
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 26a5ce3a93..603fcc39c7 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
                 env->pc -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
                 /*
-                 * Returning from a successful sigreturn syscall.
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
                  * Avoid clobbering register state.
                  */
                 break;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 2c9f628241..b98ca8ff7b 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)
                                  0, 0);
                 if (ret == -QEMU_ERESTARTSYS) {
                     env->pc -= 2;
-                } else if (ret != -QEMU_ESIGRETURN) {
+                } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                     env->dregs[0] = ret;
                 }
             }
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 78506ab23d..06d92c0b90 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)
             if (ret == -QEMU_ERESTARTSYS) {
                 /* Wind back to before the syscall. */
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[3] = ret;
             }
             /* All syscall exits result in guest r14 being equal to the
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 2365de1de1..af98138eb2 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -140,8 +140,9 @@ done_syscall:
                 env->active_tc.PC -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
-                /* Returning from a successful sigreturn syscall.
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
+                /* Returning from a successful sigreturn syscall or from
+                   control flow diversion in a plugin callback.
                    Avoid clobbering register state.  */
                 break;
             }
diff --git a/linux-user/or1k/cpu_loop.c b/linux-user/or1k/cpu_loop.c
index 2167d880d5..e7e9929e6f 100644
--- a/linux-user/or1k/cpu_loop.c
+++ b/linux-user/or1k/cpu_loop.c
@@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)
                              cpu_get_gpr(env, 8), 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 cpu_set_gpr(env, 11, ret);
             }
             break;
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index b0b0cb14b4..1f8aae14bb 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -340,8 +340,10 @@ void cpu_loop(CPUPPCState *env)
                 env->nip -= 4;
                 break;
             }
-            if (ret == (target_ulong)(-QEMU_ESIGRETURN)) {
-                /* Returning from a successful sigreturn syscall.
+            if (ret == (target_ulong)(-QEMU_ESIGRETURN)
+                    || ret == (target_ulong)(-QEMU_ESETPC)) {
+                /* Returning from a successful sigreturn syscall or from
+                   control flow diversion in a plugin callback.
                    Avoid corrupting register state.  */
                 break;
             }
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index ce542540c2..eecc8d1517 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)
             }
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[xA0] = ret;
             }
             if (cs->singlestep_enabled) {
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 4929b32e1f..67d2a803fb 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)
                              env->regs[6], env->regs[7], 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->psw.addr -= env->int_svc_ilen;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[2] = ret;
             }
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 0c9d7e9c46..ee2958d0d9 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gregs[0] = ret;
             }
             break;
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7391e2add8..f054316dce 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
                               env->regwptr[2], env->regwptr[3],
                               env->regwptr[4], env->regwptr[5],
                               0, 0);
-            if (ret == -QEMU_ERESTARTSYS || ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ERESTARTSYS
+                    || ret == -QEMU_ESIGRETURN
+                    || ret == -QEMU_ESETPC) {
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)(-515)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d466d0e32f..99e1ed97d9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -43,6 +43,7 @@
 #include <linux/capability.h>
 #include <sched.h>
 #include <sys/timex.h>
+#include <setjmp.h>
 #include <sys/socket.h>
 #include <linux/sockios.h>
 #include <sys/un.h>
@@ -600,6 +601,9 @@ const char *target_strerror(int err)
     if (err == QEMU_ESIGRETURN) {
         return "Successful exit from sigreturn";
     }
+    if (err == QEMU_ESETPC) {
+        return "Successfully redirected control flow";
+    }
 
     return strerror(target_to_host_errno(err));
 }
@@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         return -QEMU_ESIGRETURN;
     }
 
+    /*
+     * Set up a longjmp target here so that we can call cpu_loop_exit to
+     * redirect control flow back to the main loop even from within
+     * syscall-related plugin callbacks.
+     * For other types of callbacks or longjmp call sites, the longjmp target
+     * is set up in the cpu loop itself but in syscalls the target is not live
+     * anymore.
+     */
+    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+        return -QEMU_ESETPC;
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index a0ff10eff8..7680e243bb 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/compiler.h"
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "user-internals.h"
@@ -185,6 +186,8 @@ void cpu_loop(CPUXtensaState *env)
                     env->pc -= 3;
                     break;
 
+                case -QEMU_ESETPC:
+                    QEMU_FALLTHROUGH;
                 case -QEMU_ESIGRETURN:
                     break;
                 }
-- 
2.53.0

