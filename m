Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA161C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHl2-0004pV-N5; Thu, 20 Jun 2024 09:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1sKFmU-00068U-1m; Thu, 20 Jun 2024 07:16:42 -0400
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2409::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1sKFmQ-0003qf-CU; Thu, 20 Jun 2024 07:16:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAPfQDeMKT3vBGBYRGXEx3WPKJjBZX/8mKNp+KYUVwzTJ1sSmmdn+NTv697nsbtIIFhS8+XnjycLCRY77Molt0QPy53ad2fyQk5V8xyigVNkURrVRremZyO9nNOBA5oA+1Symci1zTlRdXs8CNWisKbbvlCHk6G8y7K9HhLni7/mS2BC3oBsQSfpBVi7EdHuxWvUGcaHNz1Tb3QShrLc25g8rxOWydn4pKRIJJVThLx4zrtX8ZHVD0axsb3rbuUCWiAQqfBLmO7N3a4TWfIlzevTHtUzo6kCBilcPvJShqrG7NxYoiM8POYZRC8P6RNbVJS5EBMWJlOky38ALKWB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JYV5r9jQozpZTODbYlbPhY3oxRLQHLs3kkf++DbqA0=;
 b=ocgQgDrOpzvXoFxEu2266J3fv6OKUCKOxKO6Bx/Z9p84XbF2U9BTB4HhzDP9xchbMm0xOIR637Yqi7lmO37PVxmhAfIlihCEi+SsXZKtqjVvgo8qlTEcmY76v9GmTZYo0kGoHvesx3ReP6WxcdXRaMgtBuAXhwrE0bbg5O357pSP/UCK+DyO1Z2rB8bpL354rHl+LHpBNQ17/9Kqoexjz0k2kl6uu1vaDLgKNYG0tEIpzz6vvFFbWufoX9tmgEaZywqH9Xma9Z6mW+pCMw5zi6nXze5Pzsyee+7IXEZTCP9/wUd0JT0xzItG1QjFnRPvM5x+08besYeRKQL5aL4uIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JYV5r9jQozpZTODbYlbPhY3oxRLQHLs3kkf++DbqA0=;
 b=wqpAQBjBI0QFvFcE+4Ero8HhvLFWY0t+rNZGYYQkPmGTGjCToWRTjNvxxvupe2L/bOYyPtvyFna0yy19TI32wPFBPuCmMDaN/s2DrTXlDWcaJBbm69l0YlusXB2VRaROqzvSDoPs+PcJbzMDYvPW6EPdfpS2BvEW7mMXY4n2j2Y=
Received: from BN9P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::26)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 11:16:31 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::b4) by BN9P220CA0021.outlook.office365.com
 (2603:10b6:408:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Thu, 20 Jun 2024 11:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 11:16:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 06:16:30 -0500
Date: Thu, 20 Jun 2024 13:16:28 +0200
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>, 
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/timer/a9gtimer: Handle QTest mode in
 a9_gtimer_get_current_cpu
Message-ID: <ZnQPjL4HjevwHh8R@toto>
References: <20240618144009.3137806-1-zheyuma97@gmail.com>
 <47a6e9d2-27f6-4e45-9de3-c4766bdf2566@linaro.org>
 <CAFEAcA82T-hS0Armp6PVBkrywfqv+-u+L4z8rtrjBpnwvE8Hxg@mail.gmail.com>
 <12471213-83da-4226-ba2a-2b8b6452d46b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12471213-83da-4226-ba2a-2b8b6452d46b@linaro.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 34be9431-fe31-49fe-4ce2-08dc911a6fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|36860700010|1800799021|376011; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4lNpG/u6jcFyANEF4HwVkpBB9vRAaAxJq0PLfVZMseWoJLZ+dYhN3N3Ygy?=
 =?iso-8859-1?Q?JPOdPmee9rLyKTWatcE17aGCzX+h+kQCyeDfPqkhVGx6+QMzsmasFnkShk?=
 =?iso-8859-1?Q?xnDK96EfpcT9P5xxLWVw3RVKY35rlK0egA4rsGw5aDWGBNxhgzZZLGnbYl?=
 =?iso-8859-1?Q?IA18XhAra3ypsuG6F4JNqRpW8tAS9LlSSKAgUE1vyoox17Bsq8QjrSiCKu?=
 =?iso-8859-1?Q?3AO2BIK0xxgqrCTnXN1vXCIeWuhh+KWzRrGJz2JA0QGNblslURnAWu2LhA?=
 =?iso-8859-1?Q?1qx8A1GivlkgEb5AU3scAHi9FhEyp8dQeXaQ8ftdbUKi3/FZbnSH8EVSov?=
 =?iso-8859-1?Q?z59RSZmCXbT82HaEz4b0u6ZT+xbQ1umu9xLDvITZATn5ky2ZvUo088HdTo?=
 =?iso-8859-1?Q?umdp3KXKRzKbweVIooqaF7ahux3TXcJXz+jwS7rwvk6HWvfaNe0gb/WDPs?=
 =?iso-8859-1?Q?x6tTr5ouDg2A8C4U3xJUZiFYWzfzHWf3nFQE1ahB95ToWdNO8a95HU8E2Y?=
 =?iso-8859-1?Q?Y5GK8WoYs9zZPFSBdmWdS9D9ftGP1lllFnMppEHxdmZIW5/UxsQ11nTeUF?=
 =?iso-8859-1?Q?QtxGYIKkCiwwvwm1wIpVW8ke2nCPqmTMSKc4rlnYl305eWaVcktvznRHg+?=
 =?iso-8859-1?Q?gOr5py3jjUQlYC36uUm2QHw7PL6TXD+artefdwD2olYqe6MYgiFlyqa+9F?=
 =?iso-8859-1?Q?M03DRThzJKy+OAegeQKUDJmaOjP25P7pZTcmCdHCVyP5uoWehxF8XAX9Y7?=
 =?iso-8859-1?Q?lRld4Gd2qjtIWBZkxYNjBmkDV0PQFY5J6xHOl/qhQ5un/hUszJY7kIqeMT?=
 =?iso-8859-1?Q?2z2wixs2viinIkYOl+Rrpg9LbBy49CV6aSessFxdIzA1tUZCV7/pBCU2Qa?=
 =?iso-8859-1?Q?yj28P6DRlkTbwxUxpcQ1dwB+bMe38Ufq3SPJmaGoRkVIsLMURgtI3a1oPL?=
 =?iso-8859-1?Q?9V7hwGmNLZBzHy+GfWvqrXqe/omFvG6MtgrIEE5KBEIF5gtkfP35+uo58U?=
 =?iso-8859-1?Q?chwQ/KOhgJAIt0KtyDd2rTkgdX/c0DOignoyqw9ZzBOlG1lrwS2r1Sux4o?=
 =?iso-8859-1?Q?CcbgQW4VF+MZ3J9Nui1ffrUmwpEeJzdS5HCy3yT7xzk/ABUL02aR1bystA?=
 =?iso-8859-1?Q?+Q1CDGVUGqA0kFMUpgCjl4YG/LdQpz74fuDgB5pBrfPjQgj9T/wNT5l3c1?=
 =?iso-8859-1?Q?kunye9zYXMIpsuOBe+I7SIX5lvwVdfugbusLRIHnGk67/KfMYBsXmVNja3?=
 =?iso-8859-1?Q?2qsa0BqBSCrdOs7zg7CtpqyKUNAOWu1tyRjz/Tc324I3s8KxLKerNslwNO?=
 =?iso-8859-1?Q?JYo8UbmHinJGYLjQW19IoThEfBD9eML0TmleePaH43lBUYR/xXNAA/SDTy?=
 =?iso-8859-1?Q?bo4q4kUTRm+w/P36xXDqZLbH0ZCF816CfZsHVtZIDUc3RfW1ww8ntCLpjX?=
 =?iso-8859-1?Q?lPrex/yJiUX2oqz4il7/aE94ZRBpi2Cni9Ih/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 11:16:31.0242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34be9431-fe31-49fe-4ce2-08dc911a6fd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
Received-SPF: permerror client-ip=2a01:111:f403:2409::600;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Jun 2024 09:23:14 -0400
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
Reply-to:  "Edgar E. Iglesias" <edgar.iglesias@amd.com>
From:  "Edgar E. Iglesias" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 20, 2024 at 12:25:51PM +0200, Philippe Mathieu-Daudé wrote:
> On 20/6/24 12:10, Peter Maydell wrote:
> > On Tue, 18 Jun 2024 at 15:51, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > > 
> > > On 18/6/24 16:40, Zheyu Ma wrote:
> > > > This commit updates the a9_gtimer_get_current_cpu() function to handle
> > > > cases where QTest is enabled. When QTest is used, it returns 0 instead
> > > > of dereferencing the current_cpu, which can be NULL. This prevents the
> > > > program from crashing during QTest runs.
> > > > 
> > > > Reproducer:
> > > > cat << EOF | qemu-system-aarch64 -display \
> > > > none -machine accel=qtest, -m 512M -machine npcm750-evb -qtest stdio
> > > > writel 0xf03fe20c 0x26d7468c
> > > > EOF
> > > > 
> > > > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > > > ---
> > > >    hw/timer/a9gtimer.c | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> 
> 
> > > >        if (current_cpu->cpu_index >= s->num_cpu) {
> > > 
> > > That said, such accesses of @current_cpu from hw/ are dubious.
> > 
> > True, but I'm not sure we ever settled on the right way to avoid
> > them, did we?
> 
> No we didn't, it is still in my TODO list; we might discuss it
> when I post my RFC.
>

Yeah, this way of getting the core id is a problem when having multiple
ARM CPU subsystems (and for heterogenous cores).

IIRC, when I looked at what the GIC v2 HW does, the GIC exposes an AMBA
port for each CPU. In my mental model that would translate to exposing
multiple Memory Reginos (sysbus_init_mmio) and mapping the appropriate
device MR to each CPU AddressSpace.

We could also do it with memory attributes but I don't think the
master Ids are standardised enough to extract a core-index from
with out having SoC specific code,, at least not accross Xilinx devices.

I never looked at newer GIC versions nor the mmio mapped timers
though...

Cheers,
Edgar

