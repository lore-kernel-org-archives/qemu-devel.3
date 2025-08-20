Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CE7CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoiFp-0001ws-Ly; Wed, 20 Aug 2025 08:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoiFl-0001wO-Tb; Wed, 20 Aug 2025 08:49:21 -0400
Received: from mail-dm6nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2415::605]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoiFi-0005w1-Li; Wed, 20 Aug 2025 08:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlKhdsOXcaFYOpfh4kbvcQ6cn2AJPVGj3e3spnsIR1sDxOwe3P0YsquqONiHrWJ6Oq/NqCYNKLt20AIPxWhWBWfKlbCvxt9/vtXKV+eL6VFfiUOpWTdVfERsfqY8WzG9qsYv/cjpj7C2nCezBcY1zWNrqzndByaRXbTe0BthSIEkOj2zrxKQCVZdzITTEODfIKIJVK0LuEC6jGCivYryIkwoXoVFk6yVt4wnZMl3vc3YHxglp9b8DN/PnsQMPFKfRlKg7rvUjlQGypJMc6P2y+DCrwdWcJvPUB/NRkl8qkVKMrqiqEEfX3RGpIw6BsgGWZgb/QIHL5hjGxBqhcULBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP134N7lCms9gq6iJODDFNyCZsAr27Em+QrET3QEuSA=;
 b=lK2rbQQSGl7IxtSbRW4aVg9t0KsDiJofWrOIQ6kAOMYOH7j9hD1RBMwcC06b5odS0HeuFanmczRI5lXA4JGk7CFqk8XYRrmlxlF3SKO2yoVhHzShWMVXpw0kejgnJ4jpjop1nDkzBFys9oEzeAKiHQi4Pg+2wL4FoKzfnbpYp2CYL7zMHIMPzXLGxM1tCJTRiyVqONKigPKG1wOq9RouY/T6PNPuNmy+1toF1nj/TLPU5rvVwUh9kmGw5XfjBydd0KCn3a5CWu7gzCWlEyv0Y6GVowfzEmU23xpbQ1dOSZSV2rHPupenCqbWnGv+rdd447NhFbmotrrK6EbXqxYxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP134N7lCms9gq6iJODDFNyCZsAr27Em+QrET3QEuSA=;
 b=0fLQfCNnRKH7O3ePTe1435k4IPO+UyUW57xkPO7TsOPeefLd97jeEq0u5BXUZOLIheg6qYNazci7S6yS79jDVoM2glPbHcc+6Sg6oxucjvCX9ToVvdqn3ndWWnMjgajvHDkrKMG847bdxx6OKQDv6rsfrXYApufrriL2uQluo5w=
Received: from BYAPR07CA0024.namprd07.prod.outlook.com (2603:10b6:a02:bc::37)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 12:49:10 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::72) by BYAPR07CA0024.outlook.office365.com
 (2603:10b6:a02:bc::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 12:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 12:49:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 07:49:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 05:49:07 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Aug 2025 07:49:06 -0500
Date: Wed, 20 Aug 2025 14:49:03 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>, Markus Armbruster
 <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 20/47] hw/arm/xlnx-versal: refactor CPU cluster creation
Message-ID: <aKXEP5rnpL1KkPvr@XFR-LUMICHEL-L2.amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
 <20250820082549.69724-21-luc.michel@amd.com>
 <9a47da92-1d12-4eda-9c18-235f93bca8b5@linaro.org>
 <e7090f12-ba40-4495-b80f-0f85b45a7434@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7090f12-ba40-4495-b80f-0f85b45a7434@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 767d0013-c1c2-41f4-7b66-08dddfe7f504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTd2bGtYSysrcWoxejREbmhjWExjcUQwakUzNVVWeVgxblk3d3Zmb0RweHNq?=
 =?utf-8?B?dHJybi9qdGsxNXkyeFNNWE9oS0swaVFOQWcxc1pNTE9NYW5NaElpc3gvWjJO?=
 =?utf-8?B?WENCZEFveGVZWG1KcVBJN2xvQ2xZV0N4ajBxeFVqdVZIdGlnUExhenljdmRl?=
 =?utf-8?B?Q1FFbDhsa09aYXRTaWxCV1kwVjdHK0RlSDBSVXJQc0xVekdrQVpDd1lWVkF6?=
 =?utf-8?B?L2dZdG9XOW9hSU8xa2V4WkcrdFptNHorKzNYMnlHQ3FON1dTQzAxUHkzMjdq?=
 =?utf-8?B?SDF2K2l5YjY2QWIwdHJpek1XQWNwQUg0Z3JPa1VWK1ZZRDFBOUY4RnA4MUNz?=
 =?utf-8?B?SE1hVVZFcmJJeVhscWpZSHpXM2x1M2V4dHg3aEk0dXhnUkUvMjlYVFd1WFFa?=
 =?utf-8?B?WWFQbHoydlN6NVVWNWM4VXJrUWsydVlNZjZ3c3pKMnMvVFdZMlpZTTZocFVU?=
 =?utf-8?B?S1BkVFhtdjRVbzdsait5ZHUrWFhlSVJPdUM1eTkxT0RwZE0vVVpKcXVCZUQ4?=
 =?utf-8?B?eTBQL0kvYVhTeklUaEhrUFBVQTc3RHd4ZzhXSDFlYytycEZSamxGWGhFODRz?=
 =?utf-8?B?M1FrZHlrUDdLWnRRbnRVVmdFdGt6cVgzbFN6TnppNlhYcGEwVGhvVlpLTUt2?=
 =?utf-8?B?Kzk0eHlZSlhJYkpmVWZIcjBmMUFjajhwTTdweUdzbTFpTUdDM0x6dzlEQXAz?=
 =?utf-8?B?QTBOU0t0Mk54REo3Wmg0TndBR1pZOXp3U0dFMjZIckxJeGh0cG9kaldjcjAy?=
 =?utf-8?B?aCs1TzdlR1Fqc1JpT0J5RWlEdmUvczQ5RHZRUnYrN3plNjhHeGJDL2g4a05W?=
 =?utf-8?B?RVR5Qm1qM3VuWDd3RFAzNTlFSkgxSVh0SmptZlo1UFQ5cXZmb1FBWWZKWWww?=
 =?utf-8?B?NUtuZ2xTMnBBN1dKZ2U4bjRlaEROVC9XSXIwSVJkS2QvUTdQTkx2cVN4Q2hy?=
 =?utf-8?B?YitPZFFEN0lmT0xiUUVVZGpYeU81YkNheTZ4NStROWFwMG0zU2h4dmtJdElD?=
 =?utf-8?B?ZkFoRkppQkxTNGdaZFFaOEVWTkhxcHpwZktTclJXYXdYNnRlK3NDak1pRFR5?=
 =?utf-8?B?YTdrNjN5K3FxUldDZDZxL3ZFT2FENDluRGR2N0g4cVJhRmxTeVRqdTN2a1ho?=
 =?utf-8?B?UnpyQytEdVJKRjVNanp4NFY1NUlnZENzb1hDZWhTTWQwVnBaVmdRQmpVYUly?=
 =?utf-8?B?eVdOMmp1VHBXYTFvVDg2aDB2cExobG5hakNVb0hJSzJsSG9UMHVnN1ZnenVD?=
 =?utf-8?B?OGw1ckZXVXh3bkE3TDJ4c0FJaUc5RnpISUpiT0Mwek5BTG8rdFIrYzdvM0Fw?=
 =?utf-8?B?WTlFa1pYaXQwNGQ3Q20vTzNhT0dqZnlYMXpVMndIODIrMWY5bTNSYXEzVyt4?=
 =?utf-8?B?czYxQm1KK3VmZ1VUVnkzcUxIRWJSS0gvK2t5UUpCRnQ5ZXg4VFl6Q1MvOU5O?=
 =?utf-8?B?eFpZL3hHV2ZlcFJqME5YR1IrZmJhUTFOeFU4bWY0UHF3ZWZFS0JaTW5FRDM3?=
 =?utf-8?B?dElGNTFuR3I2MWw1cEFtYVpxeTZVTzI0aXo4OTNnNHNLVk9tQkZGVzA3ekFS?=
 =?utf-8?B?TzFJYldVZE5SRHV5ZU9Tdk02azgrM25EZnYrdFVxWU5LNXR5WHJncEF6NmNv?=
 =?utf-8?B?a3I5YjhLdjU2eEdSMCtZUTJQTUlnMmViSXpwVEQrdnFaTzROdXN2M2JyNmlr?=
 =?utf-8?B?blkySnBQd1pad2NHNkorYTVOOHVPaHdEWm1qWG1VWlZUM29QbGV6SDc2Q0sy?=
 =?utf-8?B?OVdpTUY0eUlZUkx1T2l3REVoTkI2NVdhbnAyVHFSTVg0a1Uvc2JBcDVVT2hO?=
 =?utf-8?B?Sm4xd3BpbEd3RyttbEJkMWpkNTVxOGY2N1RQYWNQcG1ZSjR6U0RXQ0c0N1hL?=
 =?utf-8?B?eHJ3SmN2bEw1dUVORkV0d1dkaHB0MVlFbjB0aHlGOXkyWXhNeE5VSlhLWXYx?=
 =?utf-8?B?SmxOMnZnVHh3bmxsVFBrZ3NLdVUzb00vMWEyTVdQekh6MGt4WHNuQWdTSHpQ?=
 =?utf-8?B?dC9CeWJwR3hCSjJOZnkvMDlBUVVvQmZKODFZNXdDcEg2QmV5RFhBRnZFUHlE?=
 =?utf-8?Q?yNTmiA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:49:09.6282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 767d0013-c1c2-41f4-7b66-08dddfe7f504
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
Received-SPF: permerror client-ip=2a01:111:f403:2415::605;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 14:21 Wed 20 Aug     , Philippe Mathieu-Daudé wrote:
[snip]
> > > -    arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
> > > +    arm_load_kernel(ARM_CPU(qemu_get_cpu(0)), machine, &s->binfo);
> > 
> > We'd like to restrict qemu_get_cpu() to generic accelerator code, where
> > what type of scheduled vCPU doesn't matter. And forbid this API under
> > hw/, because it triggers odd bugs in heterogenous context (we can
> > instanciate vCPU in random order, and hot[un]plug them, changing their
> > id). Besides hw/ normally have knowledge of how to directly address a
> > CPU (how/where it is wired). So I'm not really keen on adding another
> > qemu_get_cpu() call here. Can't we keep references in VersalVirt (at
> > least for the booting cpu)?
> 
> Otherwise simpler to use the constant QOM path:
> 
>   booting_cpu = ARM_CPU(object_resolve_path("/machine/fpd/apu/cpu[0]"));

Sure I can do something in that vein. I'll add an accessor to the SoC
interface, as I did for other peripherals.

Luc

