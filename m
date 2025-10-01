Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01C5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v443G-0004YY-RE; Wed, 01 Oct 2025 17:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v443A-0004Xa-DI; Wed, 01 Oct 2025 17:07:48 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4431-0004zf-7x; Wed, 01 Oct 2025 17:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlSaSiiKoOWLuXCFC38m4ktAKo6TMm8X1VFZfZdiklfgYj5/hMRzLeQUDA/VVibz/8L+WGzwULutZufjehK09fcdMjD9exLsSmPDPI1fiVNzvRfMM8Xg/GiuQeKAtwERyeGugIabfzt8eF8DYj+73BBlWyTZk1DLfM1aVit2L2SICQwDeyFybLZ88qWam57plsrEss5s7hfxteBnAduH56Vear7bGRAOc8YkX0AyHSb7/2jQuN2MqrvGTtqR1Kfzcd2VH1PgU0xMTei3tgb56ARXUS1EFQmFD73yj0emh/q6rMXJ4SPtOIeFGVQejU1sY9wBBBA8VD8STaNZFZCdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA3M67DuPOVQR5zOG0JejO4TCnd77tZcrHdD8vfMsTE=;
 b=ndLOeClvoiYc22b0mFwLD2QmuJL0rTe/x7CF803buBa1L7vnjISU7daU+E2feSFiuIDDVnR4OTxPWP2zC0TybGaN4WLh8uh6WypRGW3D50f+sxD5aA0mqs1Die2gm3dHfKEry3uHsXIUkRRNoihRYrSItxl/vkuEi0Xo5ATdop/P97nSdcA2RWmZECb/V8QsPldMq68pURdqMow12ctN39j5uXrSHwPQxIz7sK36Gx6VxoOyrMhOz9bg3PvzxVFCz7fO61pjKvLp6atc6NTCxJj27qG9jCVRjeXhV9gUZaH4ONAP7PenT3HNyhi3YPDIArR+EP9KMfWCekgdCswNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA3M67DuPOVQR5zOG0JejO4TCnd77tZcrHdD8vfMsTE=;
 b=fLkfZiQ69fyRjJjEWP9YyOnioXPTvtS8NThjSvnnNCjZEF3nUf78dKZVq3mHXyhx2FTWeS0j1jpzwYMggrT6fwE5Diz1gSCGgDSC7odjbbIv57UGguprWKLdb8tKLgDjIJtfc+QF+KUkc/Dn2Ca72H1RLcse3StqurQHmn46vXE=
Received: from BN9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::19)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::987) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 1 Oct
 2025 21:07:12 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::91) by BN9P221CA0014.outlook.office365.com
 (2603:10b6:408:10a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 21:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 21:07:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 1 Oct
 2025 14:07:07 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Oct
 2025 16:07:06 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Oct 2025 14:07:05 -0700
Date: Wed, 1 Oct 2025 23:07:03 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Alistair Francis
 <alistair@alistair23.me>, Vikram Garhwal <vikram.garhwal@bytedance.com>
Subject: Re: [PATCH 0/7] Register API leaks fixes
Message-ID: <aN2X9wQnCbSkDT21@XFR-LUMICHEL-L2.amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
 <dfad3af6-15a7-4913-8cd2-556c32e537eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfad3af6-15a7-4913-8cd2-556c32e537eb@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: f372385e-99ac-46e1-c9a3-08de012e7ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a09mUjE2Qkd5Q1dpc3MycnVMSHVmQzJiL0FjcEtQbTVBWmxqZittSjY3cXFk?=
 =?utf-8?B?d3hKOTJqNjIrZnNvblpXYmw5VytJOUFmZEtnaHdmVGVJMHJ5U09HbXJCV241?=
 =?utf-8?B?ZWxrVEJDVmY1WUtsMXVCWmtLZmRiZXNPOTl0WVB2L2VjUkVuUUtyMy9ydHFS?=
 =?utf-8?B?dU9yMUZXSWRORUNSWFdqcVhZeG1CTERTSXJPcTZoNWVuM094dUYxMVNtOWND?=
 =?utf-8?B?MGVEYWhUV3U1NG8rY3RIWldwUFlyZjkvWVZ5UCthZEVhY2hNTFhucjBORzVB?=
 =?utf-8?B?NTl5Wk9wc1NUS1RCMEZvMDJCN0o5c0RDN20zUnQrc0g2OGNqeGtLSm0wT21h?=
 =?utf-8?B?OUd6L0dUUzN2NFYrTno5QU5NeDVTN2RGdGpySWpJYmdaZ200dzV4R09VWm9r?=
 =?utf-8?B?UkR3V0lka0IwakJlTU94bnF6UU5UOWdFZEFQTjZWOTFmNlgwRXFSQ1dmYlNp?=
 =?utf-8?B?dTEweGNkajVVVWVqK0dQcTRWc1g5V3lVb2gzbmxDc2MydXlRUmJlQ1Z4TW52?=
 =?utf-8?B?MDBQaDY0bDZzT1lyUU1ycERBdzBzSjVTZWpBdGFabVlIYm9hcmJONEdiSFcx?=
 =?utf-8?B?anAwa3IyRk9xVEFMeUFGS3hDL2FCalRKMHoveENjVlJQVW5mU2VwdmdqYm1s?=
 =?utf-8?B?MGQwTGg5RHQ0bVNQVVFFUEo4b1M3dXRHRnN2MXlUQ25UVUErOTVZTndCUXF1?=
 =?utf-8?B?RU5JMGdwamJFWGV1MU83TVZOSW5ZQ3Y4VVJKNEs5MkE3elNoQ01ydlY3Lzd6?=
 =?utf-8?B?bFZESDFoZ1JRbzJJMHE2eFZ1bFRkWjhBUFRsTEhXTWlhSkpIUG8wMklzWis4?=
 =?utf-8?B?aGprZHV4NGNESTVLdlRmUUJDaEhDWE1vVmpTS0wxS1RZRXlOYTkzTFZ4T1My?=
 =?utf-8?B?RHJTMytqRmJBckE5SFFnWDVoUGJyd1BSeWk1UE9MUTlkK0JnZG9FY0NNUDVN?=
 =?utf-8?B?SFZJWVZ5dDdBVkJmZjFUY1J4ZE93RlRQaXFXMlh6dmlyTFlQbFNjYzNORWtF?=
 =?utf-8?B?Tk9JbW01aVJHWGNYOUp4TjByQnpEMGdWZFNTQ2xhaGJrSHM0NGx3aUFQUmxG?=
 =?utf-8?B?NFZEWVlXSjQySzNGZVhoeVF6cU9BYjhzalNyVUUxb1NienZLWVZ6SUJiL2hT?=
 =?utf-8?B?YlczK0ZBZFdUTDh0ODRhY0N0Z2xNcE5reTdCQXJPWHl0SWEyTi9aWGliQ1o0?=
 =?utf-8?B?SFFqa0xBVHZ5Vm03cTdweTVzbkNzcGZHbDZoRGdRZHNVSmJoMnFxS1pIRUMy?=
 =?utf-8?B?UnFKSVEweW9WVHJLbkxPSTBWeThQS1RGT3B2Y3BoTzRXSlNUbXBjREQ5M0pF?=
 =?utf-8?B?QnpLRk1GZ2NzaGhFVW9JSWltTjhFNmhVWjJHQTVVbElPVWxBL2tCaGJtTWto?=
 =?utf-8?B?azVNMHpaVEt3NEZZZmFqMlBKd0pHMDZiRTR0VjN5cGxjLzA5RnFyK0QzVVFS?=
 =?utf-8?B?b29sVG50ZE90SXhSTE1IcnhmOFgwVWlnWnpBdDhnUllUYmlMdVpibCtTNzNy?=
 =?utf-8?B?NHUzWjlwNmtZOWRsbzhQNmsyb0xTbEhiUVNwWm9Ec0JvMTZtUzNXbHIwK0di?=
 =?utf-8?B?S0VldXpHdWtvZUZ6eSttRjA1eTBuRkg0bUdiejdlaUMwc3JqbmwyV2FteXc0?=
 =?utf-8?B?bmhCNXdqd1pKME8ySWIva2pDMThXZXV5b3EzNUVKOUlqOVgzSkhGbTNZZkEv?=
 =?utf-8?B?bDBxSnltWVB1dHFiMzROZ1dkbWNiTXpOTUM5WjE0a201c2FYOHFMWWc2N0FM?=
 =?utf-8?B?L3BKOHA4cy8rUTZBNEpMeWNyM0RnUWNzNW5peGxEaVdBY2dyVWJDelRFUStS?=
 =?utf-8?B?amdnMkxDM0pKRHVjTC9OQ1A4MHZZNkpaT3JmblZxcThGZWRmUlFuMzAxYU9K?=
 =?utf-8?B?N25ZNHc1NmlTU0oxYWNuOEV5ZE5TbDAvMDladFlxZGhvZ0YveG9TaEJHYkli?=
 =?utf-8?B?K1NYRzdtbmVOUUtBK0gzbnhVcGxxR2YyUWVaTDBQZmptZDQxMk9wWVpmZHdi?=
 =?utf-8?B?dGpDOHFSTXBQRFJNdmdtUVNoU005bU9IbWNsb0ozZjlJbGNpUkl4a1p6UFN1?=
 =?utf-8?B?c21OYWNhV04xeTB5amsvOUxwWjZSVWtvWUpUeGtQMERkcElyRHdBbE44aG9N?=
 =?utf-8?Q?dEv4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:07:07.3524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f372385e-99ac-46e1-c9a3-08de012e7ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Luc.Michel@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 12:19 Mon 29 Sep     , Philippe Mathieu-Daudé wrote:
> Hi Luc,
> 
> On 17/9/25 13:44, Luc Michel wrote:
> > Based-on: 20250912100059.103997-1-luc.michel@amd.com ([PATCH v5 00/47] AMD Versal Gen 2 support)
> 
> 
> > Note: this series is based on my Versal 2 series. It modifies the CRL
> > device during the register API refactoring. It can easily be rebased on
> > master if needed.
> 
> Couldn't apply locally:
> 
> $ b4 shazam -t 20250912100059.103997-1-luc.michel@amd.com
> [...]
> $ b4 shazam -t 20250917114450.175892-1-luc.michel@amd.com
> Applying: hw/core/register: remove the REGISTER device type
> Patch failed at 0001 hw/core/register: remove the REGISTER device type
> error: patch failed: hw/core/register.c:317
> error: hw/core/register.c: patch does not apply
> 
> If it isn't too much work, I'd appreciate a v2 based on master
> so I can include in my next hw-misc pull request.

I messed up patch 2, this is why it does not apply cleanly.

I'll send a v2 to fix this. As discuted off-list with Phil, it will be
still based on the Versal 2 series. This is to avoid a new rebase of the
Versal 2 series as it is fully reviewed and can probably be merged as-is.

Thanks

Luc

