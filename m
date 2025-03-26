Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A20C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 21:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txYPD-0001lD-GT; Wed, 26 Mar 2025 17:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txYP5-0001jY-6D
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 17:35:16 -0400
Received: from mail-dm6nam10on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2413::620]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txYP1-0004Ip-2M
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 17:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlyAK6lFhQakhekVVqGOQiaOCAznFv71k9u+tCflxa6NO6MtNikYBCgLEG8EHRAOb+RwbAGkqAPxyHPRktAw7ppBBawSjGpsK5nspJgxoJPtVXzRoNA1kZkfdc9GkG9n+B69g07U5dfGxBDGVo9vP/d3/RYStKKddjW/DnBJWjQFVQ/6Q/rjMSKYfZRdbImhyseTrqa9diMJv44lTfEQc+0Y0Hdln50cEj3BgCKCHvEvqN7z4x+UAbY/IvCy/vWdTp+GdfVfQKFj77G3mi4EMZbs0ppCbZn2wx6UAuIZ6y7NrrcTdfVawOft1/V6IjNpY2KFgkH9VaNabqh3AwLRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8rxtdSuH7tt9iphOba/A+XscdmANaNCEHaM0+6BTms=;
 b=qvyBDLEyX9tVu0VCDe5NTmIOdLmt/K2OKDF1Pj1lKgSDqInsJJgIx+0cn8rcmARQKyxLYPH6xJ5zMsz7IRzjr0MhTyxZOC0NY9YljRpyOOvl5+o4Nbl4ibJZ9GfGydqqtPxhwCtpJYrB+dFj0eiK1FU3N2NiifW8w1BlDNVWE/y/RE1s88NRPW30hLuVn10u4o9HHyPLMH9erpE8XGBTp6Af3hvl7zivocakqbyrIRCYrVAgxvfj/Y2JUqR1aXia2wyqMqgH6K+eSgB+mwAm3iigJbP2FIPrJr+Ed3CWMs4kJakBjOepj22UmGQvacqp+Kz+hQ1CqA7Sa3+unpQfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8rxtdSuH7tt9iphOba/A+XscdmANaNCEHaM0+6BTms=;
 b=wX+tIluSMzp0c/vXc2se/nEkHrLDN65YdnVEAvX2ouY1+J5OU3FRQBstyVs4pnu58OdfWk4htigbbpl3gMdYlMb+yACRpe5WDLGVxqreh9RbpcV7jBZwO1J12DolHcXYz+u1+SUIeRerO4vbMRYNeqYdoM+RM81SHqe7hyWNR/k=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 21:34:59 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::b6) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 21:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 21:34:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 16:34:58 -0500
Date: Wed, 26 Mar 2025 16:34:43 -0500
From: Michael Roth <michael.roth@amd.com>
To: Fabiano Rosas <farosas@suse.de>
CC: Tom Lendacky <thomas.lendacky@amd.com>, <qemu-devel@nongnu.org>, Peter Xu
 <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>, "David
 Hildenbrand" <david@redhat.com>
Subject: Re: [PULL 2/8] migration: ram block cpr blockers
Message-ID: <20250326213443.jl3r77hqh6gy2h4w@amd.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-3-farosas@suse.de>
 <829e27d6-eb6b-8a26-e982-0ba936888c6a@amd.com>
 <9576dc01-e26c-1fc4-6534-ac79c71331b5@amd.com>
 <174301860426.2151434.16431559419990134889@amd.com>
 <87msd7a6td.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87msd7a6td.fsf@suse.de>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: e2eab541-6c4d-464a-1e15-08dd6cae0f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MAxlyaZHtzR7QDX9dwhvxqeapQw6P9Ry8vJ1MzbmeDCQ6qRIM4AF7Jm8Ffx/?=
 =?us-ascii?Q?x7x+x4fvVdFldAClSYj75GQ1XxoNzviIKAZqXyi3LvpVm5d0bo4eq3UZsTKQ?=
 =?us-ascii?Q?mhNogCGx5cZTzjcMdert0eZerYyS4bm8KlAcob2qYwuiUiTZ4yW2No2s6dpU?=
 =?us-ascii?Q?P5WXOdpEmQjIlP8q1qZZX8+71vKhgQGoR8NQguM4ePKFpF4QKxdcSMf2ibVO?=
 =?us-ascii?Q?z5tRIlIMW1diVre9ayb3tPQkLK2AilZZY5+C/WNVr3c35ZNikbLORUP99zEk?=
 =?us-ascii?Q?fxiBtrkrZBiv0NvCdsI2kqvH6nG0SuJUKzMN9/EKvHUMT831jyMKtjVDuW2+?=
 =?us-ascii?Q?liN2nNgC9PewaAtucjwszvbfdfUUQwjqfIDwmMgOpx6mr/CcHIAlGoZSANT+?=
 =?us-ascii?Q?qr/Vfr8wxirJystMVVTzk6KiREISphQqSZiq74Bz7gBc6xTyYRaAMV+dDBlI?=
 =?us-ascii?Q?3fu3qgG3BiidhC2ZMX6DxLY/nRHr/wbQCVt9Ar3p9q1xjJi5Tmdf1ojtZ93K?=
 =?us-ascii?Q?b8KLNyc0MpwA22Jg0Ek4R237dlLbkmRGeAfY2IsC0jNtC3D1Tw3+EqsBUXfG?=
 =?us-ascii?Q?+fp7WpedC2vowBixwn0uhTY6bZpZ51czx/YArJo/2vuIs2GI6AFrr6WKbgXr?=
 =?us-ascii?Q?L9XRc4D6bxvfXlkgWBIBHT1hjveMcwhV+cT5Ji2caR62h66gL0D3kqU3Q8uM?=
 =?us-ascii?Q?kaXfNSMzXRibtiX/H6NO/SYEgsz/r84Zx0J3b1TMlIqyuxN1c7aFcbmeNyjk?=
 =?us-ascii?Q?LzqSW6yPwgiOrSF3tU3oZp2W7hz7fMlU/OUBsXDzmQ1Uihbe4SsslLCB+CFP?=
 =?us-ascii?Q?8S5xNckMegLVeCehH3Mp48Yfb0BaFkZjQsFSdZuCCTH9ymEeV0lT0MXp1fda?=
 =?us-ascii?Q?UOhOnAVUZzwBPOWjezfqS81Y93G+izUy1ZuIjgoEVhBpRGpoS/fiHh9PbgQi?=
 =?us-ascii?Q?yhDAeUg05bbROuokrYzYsjPYzYdpPqEUvqqLQtQ25JZeVK7onpVcM52AtFih?=
 =?us-ascii?Q?EKv3HLuAVla8tLX4dfhoTEa14uCaJVfg4oPUAOvgn6VW+Sb8l1pz7C0qAsw2?=
 =?us-ascii?Q?H8ORW0IgS/z1ILBYNaBzGz4ugE+rrVqx6H9z4RYoGGuM16cfChBzBZgB/rix?=
 =?us-ascii?Q?6/IXroXhmwOd9/Y54UdohR+BvJKBAV0ItWg15pTJX3p+OCVuRJNsNR/C7op/?=
 =?us-ascii?Q?1jpRB1qnSvQDfsAHRV4tuIDpnxpgZpyyLU/AN/89KQulFquL4Ew3hdC9i+Uu?=
 =?us-ascii?Q?9xEnP969kjhMCw9bkGC1HV7Z/eJEcwUQKet88tBmnnU2n5VDmJGmfMCJ3WQI?=
 =?us-ascii?Q?jq8IKnlYIqmMhC1fwj5hw8j5jhO88xn8tEyHo32aSE2JUIAp3P1slpH8loaS?=
 =?us-ascii?Q?3+Wihx3QFALFVm9wgv7V6tqeEK+xD91urQYwbiKgfhthTp2oFkXlESMhZPix?=
 =?us-ascii?Q?m21h7IeUeB7lq/jKVcE4m43Dl7v7mXZlQKG8BgYhea3PDkI4SKyWnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 21:34:59.2154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eab541-6c4d-464a-1e15-08dd6cae0f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
Received-SPF: permerror client-ip=2a01:111:f403:2413::620;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Wed, Mar 26, 2025 at 05:13:50PM -0300, Fabiano Rosas wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > Quoting Tom Lendacky (2025-03-26 14:21:31)
> >> On 3/26/25 13:46, Tom Lendacky wrote:
> >> > On 3/7/25 12:15, Fabiano Rosas wrote:
> >> >> From: Steve Sistare <steven.sistare@oracle.com>
> >> >>
> >> >> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
> >> >> in the migration stream file and recreate them later, because the physical
> >> >> memory for the blocks is pinned and registered for vfio.  Add a blocker
> >> >> for volatile ram blocks.
> >> >>
> >> >> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
> >> >> sufficient for CPR, but it has not been tested yet.
> >> >>
> >> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> >> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> >> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> >> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> >> Message-ID: <1740667681-257312-1-git-send-email-steven.sistare@oracle.com>
> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >> ---
> >> >>  include/exec/memory.h   |  3 ++
> >> >>  include/exec/ramblock.h |  1 +
> >> >>  migration/savevm.c      |  2 ++
> >> >>  system/physmem.c        | 66 +++++++++++++++++++++++++++++++++++++++++
> >> >>  4 files changed, 72 insertions(+)
> >> > 
> >> > This patch breaks booting an SNP guest as it triggers the following
> >> > assert:
> >> > 
> >> > qemu-system-x86_64: ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.
> >> > 
> 
> Usually this means the error has already been set previously, which is
> not allowed.
> 
> >> > I tracked it to the err_setg() call in ram_block_add_cpr_blocker().
> >> > It looks like the error message is unable to be printed because
> >> > rb->cpr_blocker is NULL.
> >> > 
> >> > Adding aux-ram-share=on to the -machine object gets me past the error and
> >> > therefore the assertion, but isn't that an incompatible change to how an
> >> > SNP guest has to be started?
> >> 
> >> If I update the err_setg() call to use the errp parameter that is passed
> >> into ram_block_add_cpr_blocker(), I get the following message and then
> >> the guest launch terminates:
> >> 
> 
> The usage at ram_block_add_cpr_blocker() is correct, the cpr_blocker
> gets initialized and registered as a migration blocker. The errp only
> becomes relevant later when migration starts and the error condition is
> met.
> 
> >> qemu-system-x86_64: Memory region pc.bios is not compatible with CPR.
> >> share=on is required for memory-backend objects, and aux-ram-share=on is
> >> required.
> 
> Since errp is an &error_fatal, it causes QEMU to exit, so this^ error
> message is bogus.
> 
> >> 
> >> The qemu parameters I used prior to this patch that allowed an SNP guest
> >> to launch were:
> >> 
> >> -machine type=q35,confidential-guest-support=sev0,memory-backend=ram1
> >> -object memory-backend-memfd,id=ram1,size=16G,share=true,prealloc=false
> >> 
> >> With these parameters after this patch, the launch fails.
> >
> > I think it might be failing because the caller of
> > ram_block_add_cpr_blocker() is passing in &error_abort, but if the
> > error_setg() is call on a properly initialized cpr_blocker value then
> > SNP is still able to boot for me.
> > I'm not sure where the best spot is
> > to initialize cpr_blocker, it probably needs to be done before either
> > ram_block_add_cpr_blocker() or ram_block_del_cpr_blocker() are callable,
> > but the following avoids the reported crash at least:
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 44dd129662..bff0fdcaac 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -4176,6 +4176,7 @@ void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
> >          return;
> >      }
> >
> > +    rb->cpr_blocker = NULL;
> 
> Could it be the cpr_blocker already got set at ram_block_add() in the
> RAM_GUEST_MEMFD path?

That seems to be the case: in some cases ram_block_add() sets cpr_blocker
when (new_block->flags & RAM_GUEST_MEMFD) is true, and then soon after
when ram_block_add_cpr_blocker() is called on the same RAMBlock:

  2025-03-26T21:08:15.092427Z qemu-system-x86_64: warning: ram_block_add: new_block 0x55c247e4c880 new_block->cpr_blocker (nil) name ram1
  
  2025-03-26T21:08:15.124710Z qemu-system-x86_64: warning: ram_block_add: new_block 0x55c2480fde00 new_block->cpr_blocker (nil) name pc.bios
  2025-03-26T21:08:15.126190Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c2480fde00 rb->cpr_blocker 0x55c2480fe050 name pc.bios
  2025-03-26T21:08:15.138582Z qemu-system-x86_64: warning: ram_block_add: new_block 0x55c247e3c1e0 new_block->cpr_blocker (nil) name pc.rom
  2025-03-26T21:08:15.138938Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c247e3c1e0 rb->cpr_blocker 0x55c247e3c890 name pc.rom
  
  2025-03-26T21:08:16.185577Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c248db9200 rb->cpr_blocker (nil) name /rom@etc/acpi/tables
  2025-03-26T21:08:16.187140Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c248085620 rb->cpr_blocker (nil) name /rom@etc/table-loader
  2025-03-26T21:08:16.188029Z qemu-system-x86_64: warning: ram_block_add_cpr_blocker: rb 0x55c2480ce220 rb->cpr_blocker (nil) name /rom@etc/acpi/rsd

-Mike

> 
> >      error_setg(&rb->cpr_blocker,
> >                 "Memory region %s is not compatible with CPR. share=on is "
> >                 "required for memory-backend objects, and aux-ram-share=on is "
> >
> > -Mike
> >
> >> 
> >> Thanks,
> >> Tom
> >> 
> >> > 
> >> > Thanks,
> >> > Tom
> >> > 
> >> >>
> >> >> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >> >> index 78c4e0aec8..d09af58c97 100644
> >> >> --- a/include/exec/memory.h
> >> >> +++ b/include/exec/memory.h
> >> >> @@ -3203,6 +3203,9 @@ bool ram_block_discard_is_disabled(void);
> >> >>   */
> >> >>  bool ram_block_discard_is_required(void);
> >> >>  
> >> >> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
> >> >> +void ram_block_del_cpr_blocker(RAMBlock *rb);
> >> >> +
> >> >>  #endif
> >> >>  
> >> >>  #endif
> >> >> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> >> >> index 0babd105c0..64484cd821 100644
> >> >> --- a/include/exec/ramblock.h
> >> >> +++ b/include/exec/ramblock.h
> >> >> @@ -39,6 +39,7 @@ struct RAMBlock {
> >> >>      /* RCU-enabled, writes protected by the ramlist lock */
> >> >>      QLIST_ENTRY(RAMBlock) next;
> >> >>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> >> >> +    Error *cpr_blocker;
> >> >>      int fd;
> >> >>      uint64_t fd_offset;
> >> >>      int guest_memfd;
> >> >> diff --git a/migration/savevm.c b/migration/savevm.c
> >> >> index 5c4fdfd95e..ce158c3512 100644
> >> >> --- a/migration/savevm.c
> >> >> +++ b/migration/savevm.c
> >> >> @@ -3514,12 +3514,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
> >> >>      qemu_ram_set_idstr(mr->ram_block,
> >> >>                         memory_region_name(mr), dev);
> >> >>      qemu_ram_set_migratable(mr->ram_block);
> >> >> +    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
> >> >>  }
> >> >>  
> >> >>  void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
> >> >>  {
> >> >>      qemu_ram_unset_idstr(mr->ram_block);
> >> >>      qemu_ram_unset_migratable(mr->ram_block);
> >> >> +    ram_block_del_cpr_blocker(mr->ram_block);
> >> >>  }
> >> >>  
> >> >>  void vmstate_register_ram_global(MemoryRegion *mr)
> >> >> diff --git a/system/physmem.c b/system/physmem.c
> >> >> index 8c1736f84e..445981a1b4 100644
> >> >> --- a/system/physmem.c
> >> >> +++ b/system/physmem.c
> >> >> @@ -70,7 +70,10 @@
> >> >>  
> >> >>  #include "qemu/pmem.h"
> >> >>  
> >> >> +#include "qapi/qapi-types-migration.h"
> >> >> +#include "migration/blocker.h"
> >> >>  #include "migration/cpr.h"
> >> >> +#include "migration/options.h"
> >> >>  #include "migration/vmstate.h"
> >> >>  
> >> >>  #include "qemu/range.h"
> >> >> @@ -1903,6 +1906,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> >> >>              qemu_mutex_unlock_ramlist();
> >> >>              goto out_free;
> >> >>          }
> >> >> +
> >> >> +        error_setg(&new_block->cpr_blocker,
> >> >> +                   "Memory region %s uses guest_memfd, "
> >> >> +                   "which is not supported with CPR.",
> >> >> +                   memory_region_name(new_block->mr));
> >> >> +        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> >> >> +                                  MIG_MODE_CPR_TRANSFER,
> >> >> +                                  -1);
> >> >>      }
> >> >>  
> >> >>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
> >> >> @@ -4094,3 +4105,58 @@ bool ram_block_discard_is_required(void)
> >> >>      return qatomic_read(&ram_block_discard_required_cnt) ||
> >> >>             qatomic_read(&ram_block_coordinated_discard_required_cnt);
> >> >>  }
> >> >> +
> >> >> +/*
> >> >> + * Return true if ram is compatible with CPR.  Do not exclude rom,
> >> >> + * because the rom file could change in new QEMU.
> >> >> + */
> >> >> +static bool ram_is_cpr_compatible(RAMBlock *rb)
> >> >> +{
> >> >> +    MemoryRegion *mr = rb->mr;
> >> >> +
> >> >> +    if (!mr || !memory_region_is_ram(mr)) {
> >> >> +        return true;
> >> >> +    }
> >> >> +
> >> >> +    /* Ram device is remapped in new QEMU */
> >> >> +    if (memory_region_is_ram_device(mr)) {
> >> >> +        return true;
> >> >> +    }
> >> >> +
> >> >> +    /*
> >> >> +     * A file descriptor is passed to new QEMU and remapped, or its backing
> >> >> +     * file is reopened and mapped.  It must be shared to avoid COW.
> >> >> +     */
> >> >> +    if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
> >> >> +        return true;
> >> >> +    }
> >> >> +
> >> >> +    return false;
> >> >> +}
> >> >> +
> >> >> +/*
> >> >> + * Add a blocker for each volatile ram block.  This function should only be
> >> >> + * called after we know that the block is migratable.  Non-migratable blocks
> >> >> + * are either re-created in new QEMU, or are handled specially, or are covered
> >> >> + * by a device-level CPR blocker.
> >> >> + */
> >> >> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
> >> >> +{
> >> >> +    assert(qemu_ram_is_migratable(rb));
> >> >> +
> >> >> +    if (ram_is_cpr_compatible(rb)) {
> >> >> +        return;
> >> >> +    }
> >> >> +
> >> >> +    error_setg(&rb->cpr_blocker,
> >> >> +               "Memory region %s is not compatible with CPR. share=on is "
> >> >> +               "required for memory-backend objects, and aux-ram-share=on is "
> >> >> +               "required.", memory_region_name(rb->mr));
> >> >> +    migrate_add_blocker_modes(&rb->cpr_blocker, errp, MIG_MODE_CPR_TRANSFER,
> >> >> +                              -1);
> >> >> +}
> >> >> +
> >> >> +void ram_block_del_cpr_blocker(RAMBlock *rb)
> >> >> +{
> >> >> +    migrate_del_blocker(&rb->cpr_blocker);
> >> >> +}
> >>

