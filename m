Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC97CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOgR-0007f2-De; Wed, 10 Jun 2026 15:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wXOgP-0007er-RN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:33:50 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wXOgM-0007mu-S5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:33:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsINBU42Bmks4DEylGcvn4B8wKGBJ4s7rBvL80Jo67qyMqphkEeHzsDOm6R41728DMyCTR9/hSb4r3GluWUEnYKuvSKbXu8m9zdn33PsM7zjebohSDs/PvtVu4I5xzG8/geY/Jd+FlrLl/udkz8uqr4RN/htHCWIsLhQqmmzyeQ1KL4WGiBxV8Ma1sv0q0mOYENuvQ5/24iC8fMw5p27cRtXF6iK2Uv9+m0d5w1T1mBYbPL86/VmErjKe+8UJWyi574aGzxi/Q5ayLWlbCwOXvZKHXDvAPwIgDIpzM5WwRYLZuD3NGaSZJbLCTf4OFppHqMCl1ifsOkDpfIHcRlhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHiIpZVTOV0TltnD7WzA4hinsTlZpkqo3LatBmAzpIw=;
 b=cIw15vMS2w8zKLbRdfyLjthfd6+4ZjdkpI+Tm7GmdjPZpMKHT4orJ+rtJ23sS94Lbo37xMZkBzvBIMNkSgvg/94oXSNcP7J/jWMdl2nzBn3YReroQDCYrD7lHlsAEO2uMF1qVzS+Ag1LWgocbrBxs7E0a4zFZCYFk7tR7t3t1mjCRtL7MxxZpj6htAwNhsLGqrnv8Ow8eBXv3+LRoMDdrgQI1uetyua5zTWuAmNjLG2+8tZVKfa+/t/SP9r1y7kFvu75/VbuaGUYlfMstDG51gga8hdMeCipEjKmLq8gco87PdXKKtfk7EM8sI3z+ryBkKGxZX929TPOHLEYL0x/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHiIpZVTOV0TltnD7WzA4hinsTlZpkqo3LatBmAzpIw=;
 b=OaSL4IM9sGSa+lt5mjIe++BoEV+oN3Mu9+6sqgVGGZLaaEP83146TD0DgobqbXGX2bLz4AdXkwfftKnnY1DDuSSSIQzsR3OgELK0jeppZ+Ua7T1CgRrMiZz3DE1X061p2Feao3BnzS95NIyh+fscIGEWQUJmut88yZ68JklQaH0=
Received: from CH0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:610:e5::22)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 19:33:38 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::41) by CH0PR03CA0257.outlook.office365.com
 (2603:10b6:610:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 19:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 19:33:37 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 14:33:37 -0500
Date: Wed, 10 Jun 2026 14:33:20 -0500
From: Michael Roth <michael.roth@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
CC: Naveen N Rao <naveen@kernel.org>, Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, Nikunj A Dadhania <nikunj@amd.com>, Roy Hopkins
 <roy.hopkins@randomman.co.uk>, Srikanth Aithal <srikanth.aithal@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] target/i386: SEV: Allow pflash devices with SEV-ES
 guests
Message-ID: <mlvawqkbrcucfylk3cigfs3fnh37njaea3l3hvt3dnu5xl73am@x6ixj57thfjk>
References: <20260602071213.2084388-1-naveen@kernel.org>
 <b7xwzrdt4zg5g45ufhqj46d3f4uezpy733gnsc7bv4cploxevz@rw327aciq2cg>
 <ailAARL2xS7qSNzL@blrnaveerao1>
 <88d332b0-8756-444a-9d32-53299a0ebfa8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88d332b0-8756-444a-9d32-53299a0ebfa8@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7707bf27-3b1a-4f86-36c8-08dec7272b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|11063799006|4143699003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FoupdQ6dCOtes44k9nOqAIbFb7qeyS3YDiVWpdo0BJEfksB7+GRPFdg34OTZh5Ome86TL6D8IzIinxg55OJqxILvT7N6nmCRiuJbQ2sO8HJaw59N8yJFJK5RW3/CUs+EbzTISG4dvIJQ9YZAHQrtmtzym0w+bFvyAUBkt4wYqoFI2Uf76HnxkY2lEEXqfq8fnOWNzGiMuahRuJbZkiLavTh3HOv7tmab3TFjJcK2e6D1oPpZyHvKNH+Z80hKAhOZmXW+diSQ7m2ngZeF2dyY3Drevhb1GSS3JYc6lMgAn6YDv7lKOuICrvl6QlIuOX0xFLlgrDxsAMk5pjO7k4HRUd9zePviquEVs2ZqABdsMYmIMumYKnbgzf6jspwPMjA26ybKKKn/IC49Ji7mthEJgL+8Thyb2JuyfZFheAcxG+q3Ocp9/kFW2h7Hv08polFaTjstFcW5DoHCsm4xmWpJTesfk28caTdogXYOB46vy0KmowFmz/Qk0BPL60yXMcXfancTA7vS8A4GhlDghXSektf2TL/K5DZhD4Wev2OhzWs+K4XsPDpzyRBHDrlarrvcaA4qQI7WLtH+LkVWdOHgBhdO7H8MNbiLNP8gp2gECG2jlE9zDpI6Zx6eLcWNy6Nr5uGsru88Q2VSk4jbkzRR8GlP6ZMS0AEz8jobPq/pr52ienjlqZqFGpNjL0tDJ2ElZ6SbOIuhcnaGbg4bXxlbbdVPvi1+t/e55joQ7LVBhgk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(11063799006)(4143699003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T4EZufJdmK83dQEgAUDACJdufDvFHCsIAbwRF7qUZH6ZRZDrNJDqiEbHomyx9pqULHInPyoaqjuEzauvpZaFP4Aww38DzJG9LG4c3vvFdBBJoDhgykzEXSiS4Zib726K4lBgLG8j6XaA88v47XNNato1TCV6PkV2rcEe3QBzJS065W/yesXU/t8dfjCJJ/wB/lScZqNVQz6d+oB9eb8c6PczzZdzuq1kCsSeYkfC75d4i7oSFxXWoac9OUmI6hl1VfI9XP1DcEhXR3RDSxuApt7Fr7N1MP/PP7atPC1mwJ/tyglLKNN3R0Da3n1X56aSVXcqjW5S4o7PhE4guUcFTDXBpVsr9stbV1VggGhthD4ISrPZTlJa2oAHHUSkmKYd3Mq8Wo7MBGHrZFteH8AaHvVwGDl0P/5phfRir7zCteGeALNhUNj/cCeAhHgMFkcB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 19:33:37.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7707bf27-3b1a-4f86-36c8-08dec7272b41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 10, 2026 at 09:52:00AM -0500, Tom Lendacky wrote:
> On 6/10/26 06:30, Naveen N Rao wrote:
> > [+Sean]
> > 
> > Hi Mike,
> > 
> > On Tue, Jun 09, 2026 at 07:35:46PM -0500, Michael Roth wrote:
> >> On Tue, Jun 02, 2026 at 12:42:13PM +0530, Naveen N Rao (AMD) wrote:
> >>> KVM commit 66155de93bcf ("KVM: x86: Disallow read-only memslots for
> >>> SEV-ES and SEV-SNP (and TDX)"), and the subsequent commit d30d9ee94cc0
> >>> ("KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM")
> >>> stopped advertising KVM_CAP_READONLY_MEM support for encrypted guests
> >>> (KVM_X86_SEV_ES_VM and KVM_X86_SNP_VM), but not for KVM_X86_DEFAULT_VM
> >>> type SEV-ES guests. As a result of this, it is no longer possible to
> >>> start SEV-ES guests with any SEV feature enabled (in particular,
> >>> debug-swap) with pflash devices.
> >>>
> >>> This is an issue since SEV-ES guests have historically used pflash
> >>> devices for OVMF. Guests on older KVM+Qemu are able to enable debug-swap
> >>> while using pflash devices, so work around the KVM limitation by
> >>> switching to using a VMA-based write protection. This allows
> >>> well-behaved SEV-ES guests to continue to work with pflash devices and
> >>> enable debug-swap. Mis-behaving guests trying to write to the protected
> >>> OVMF area will be killed.
> >>
> >> Based on Sean's description, a write access to a read-only memslot would
> >> cause the vCPU to permanently spin on #NPFs if trying to write to it as
> >> MMIO due to #VC handler not triggering, and that's why we don't support
> >> read-only memslots. But since SEV-ES was previously working with pflash,
> >> it seems like it does not rely on this functionality...
> > 
> > Right, normal well-behaved SEV-ES/SNP guests work just fine as they 
> > don't write to any of the read-only areas.
> 
> Yes they do. There is specific support to make a direct GHCB MMIO
> request because of the lack of the #VC exception (see
> OvmfPkg/QemuFlashFvbServicesRuntimeDxe/QemuFlashDxe.c).

With that change in place, it seems like we don't have remaining guest-side
code for ES/SNP guests that relies on emulate-on-write in OVMF for private
MMIO (seems like it never would have worked properly anyway).

It's possible we still rely on emulate-on-write for writes to shared MMIO
ranges though. But in that case I don't see why it wouldn't be okay to
continue to just forward the corresponding write-faults to userspace as
KVM_EXIT_MMIO events since QEMU can access shared memory just fine.

It's only the private MMIO that would misbehave because the emulation
path ... but I'm a little confused on this, because we'd still get #NPFs
due to the write protection... and it looks like this would trigger a
KVM_EXIT_MEMORY_FAULT to QEMU... so if QEMU really wanted to catch this
case... which seems to be the only one that's indicative of misbehavior,
we could just terminate if the access is to a read-only memslot and we
are running an ES/SNP guest... so if that's all that's holding us back
on the kernel side, we could directly start re-advertising
KVM_CAP_READONLY_MEM, or some new variant of it where userspace needs to
be aware of these additional considerations for private MMIO.

I think maybe the case that Sean is referencing in his commit, where we
can't make use of MMIO stub entries to trigger #VC, comes into play 
when QEMU switches the memory region from romd_mode to !romd_mode, which
then unmaps the memslot and relies on the noslot MMIO handling. That's
where private MMIO would stop triggering the (desired) QEMU crash, but
KVM would catch this too as an #NPF, and this would also be forwarded
to userspace as a KVM_EXIT_MEMORY_FAULT... so just like the above, if
we accept that private MMIO is not possible, and only want to actively
catch it so we can crash the guest or warn... then we can handle this
the same as above and error if the KVM_EXIT_MEMORY_FAULT is for a
private access to a GPA range backed by a read-only memslot...

*maybe* the fault info would need some flag to indicate that this is MMIO
since we do allow implicit conversions via KVM_EXIT_MEMORY_FAULT in general.
and userspace might like some way to easily differentiate between the
good/bad conversions without tracking to much state, but wouldn't that
work in theory at least?

Thanks,

Mike

> 
> Thanks,
> Tom
> 
> > 
> >>
> >> So if OVMF isn't writing to write-protected memory, then it wouldn't be
> >> triggering the MMIO emulation path in the first place. And if we don't
> >> care about enabling the emulation path in this case... then I'm not sure
> >> the original reasons for not allowing it for SEV-ES/SNP are applicable.
> > 
> > Guest (not just OVMF) could try and write to the read-only area 
> > triggering this issue. A simple write to 0xc0000 from within the guest 
> > triggers this.
> > 
> >>
> >> It feels like KVM_CAP_READONLY_MEM is more like KVM_CAP_EMULATE_ON_WRITE,
> >> whereas we literally just need as actually slot that's permanently mapped
> >> in the NPT without write access.
> >>
> >> Is that an accurate summary of the situation?
> > 
> > Yes, that sounds right to me.
> > 
> >>
> >> If so, maybe we can introduce a KVM_CAP_READONLY_NO_MMIO that captures
> >> this and simply errors out if it hits the KVM_PFN_ERR_RO_FAULT.
> > 
> > That would certainly work.
> > 
> >> Or, for
> >> a QEMU-specific workaround, just have a pflash implementation that doesn't
> >> rely on KVM_MEM_READONLY for cases like this where we don't need MMIO
> >> emulation.
> > 
> > Not sure I follow that... are you suggesting that pflash use regular RW 
> > memslots and just let the write through?
> > 
> > 
> > Thanks,
> > Naveen
> > 
> >> There's actually another case in hw/nvram/nrf51_nvm.c where this
> >> would be applicable. I guess it could be done automatically for the
> >> confidential VM case to retain cmdline compatibility...though you're
> >> wanting to add the debugswap feature anyway so not sure how important that
> >> aspect is.
> >>
> >> Thanks,
> >>
> >> Mike
> >>
> >>>
> >>> Enable VMA protection and set the memory to be RO when adding the KVM
> >>> memory slot. Because pflash devices support command-mode, change VMA
> >>> protection to RW when tearing down the KVM memory slot. KVM
> >>> SEV_LAUNCH_UPDATE also requires memory to be RW, so disable the
> >>> protection when calling that.
> >>>
> >>> Print a warning when switching to VMA-based protection so that it is
> >>> clear that KVM itself isn't supporting readonly memory, and that a
> >>> workaround is in place. Users can plan on switching to using '-bios'.
> >>>
> >>> Finally, drop the check rejecting SEV-ES guests with SEV features so 
> >>> that debug-swap can be enabled.
> >>>
> >>>
> >>> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> >>> ---
> >>> Background discussion on this issue:
> >>> http://lore.kernel.org/r/aUq9_cUDWeEW_qli@google.com
> >>>
> >>> This series depends on VMSA features support:
> >>> http://lore.kernel.org/r/cover.1779281646.git.naveen@kernel.org
> >>>
> >>>
> >>> - Naveen
> >>>
> >>>
> >>>  include/system/kvm.h     |  5 ++++
> >>>  include/system/kvm_int.h |  1 +
> >>>  accel/kvm/kvm-all.c      | 52 +++++++++++++++++++++++++++++++++++++++-
> >>>  hw/i386/pc_sysfw.c       | 19 +++++++++------
> >>>  target/i386/sev.c        | 21 +++++++++++-----
> >>>  5 files changed, 84 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/include/system/kvm.h b/include/system/kvm.h
> >>> index 5fa33eddda38..585058bd6f1c 100644
> >>> --- a/include/system/kvm.h
> >>> +++ b/include/system/kvm.h
> >>> @@ -555,6 +555,8 @@ uint32_t kvm_dirty_ring_size(void);
> >>>  
> >>>  void kvm_mark_guest_state_protected(void);
> >>>  
> >>> +void kvm_enable_ro_mem_vma_protection(void);
> >>> +
> >>>  /**
> >>>   * kvm_hwpoisoned_mem - indicate if there is any hwpoisoned page
> >>>   * reported for the VM.
> >>> @@ -568,6 +570,9 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
> >>>  
> >>>  int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
> >>>  
> >>> +void kvm_set_memory_readonly(void *addr, size_t len);
> >>> +void kvm_set_memory_readwrite(void *addr, size_t len);
> >>> +
> >>>  /* argument to vmfd change notifier */
> >>>  typedef struct VmfdChangeNotifier {
> >>>      int vmfd;
> >>> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> >>> index 0876aac938d3..0e083a56ce2a 100644
> >>> --- a/include/system/kvm_int.h
> >>> +++ b/include/system/kvm_int.h
> >>> @@ -123,6 +123,7 @@ struct KVMState
> >>>      OnOffAuto kernel_irqchip_split;
> >>>      bool sync_mmu;
> >>>      bool guest_state_protected;
> >>> +    bool guest_wants_ro_mem_vma_protection;
> >>>      uint64_t manual_dirty_log_protect;
> >>>      /*
> >>>       * Older POSIX says that ioctl numbers are signed int, but in
> >>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> >>> index 96f90ebb240f..4208df5b25ac 100644
> >>> --- a/accel/kvm/kvm-all.c
> >>> +++ b/accel/kvm/kvm-all.c
> >>> @@ -1629,6 +1629,42 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
> >>>      return kvm_set_memory_attributes(start, size, 0);
> >>>  }
> >>>  
> >>> +static void kvm_set_memory_flags(void *addr, size_t len, int flags)
> >>> +{
> >>> +    if (mprotect(addr, len, flags)) {
> >>> +        error_report("failed to apply memory protection "
> >>> +                     "(0x%" HWADDR_PRIx "+0x%" PRIx64 ") error '%s'",
> >>> +                     (hwaddr)addr, len, strerror(errno));
> >>> +        exit(1);
> >>> +    }
> >>> +}
> >>> +
> >>> +void kvm_set_memory_readonly(void *addr, size_t len)
> >>> +{
> >>> +    if (kvm_state->guest_wants_ro_mem_vma_protection) {
> >>> +        kvm_set_memory_flags(addr, len, PROT_READ);
> >>> +    }
> >>> +}
> >>> +
> >>> +void kvm_set_memory_readwrite(void *addr, size_t len)
> >>> +{
> >>> +    if (kvm_state->guest_wants_ro_mem_vma_protection) {
> >>> +        kvm_set_memory_flags(addr, len, PROT_READ | PROT_WRITE);
> >>> +    }
> >>> +}
> >>> +
> >>> +static bool kvm_mem_wants_vma_protection(MemoryRegion *mr)
> >>> +{
> >>> +    if (!memory_region_is_ram(mr) &&
> >>> +        (mr->readonly || mr->rom_device) &&
> >>> +        !kvm_readonly_mem_allowed &&
> >>> +        kvm_state->guest_wants_ro_mem_vma_protection) {
> >>> +            return true;
> >>> +    }
> >>> +
> >>> +    return false;
> >>> +}
> >>> +
> >>>  /* Called with KVMMemoryListener.slots_lock held */
> >>>  static void kvm_set_phys_mem(KVMMemoryListener *kml,
> >>>                               MemoryRegionSection *section, bool add)
> >>> @@ -1642,7 +1678,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
> >>>      void *ram;
> >>>  
> >>>      if (!memory_region_is_ram(mr)) {
> >>> -        if (writable || !kvm_readonly_mem_allowed) {
> >>> +        if (writable || (!kvm_readonly_mem_allowed &&
> >>> +                         !kvm_state->guest_wants_ro_mem_vma_protection)) {
> >>>              return;
> >>>          } else if (!mr->romd_mode) {
> >>>              /* If the memory device is not in romd_mode, then we actually want
> >>> @@ -1697,6 +1734,10 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
> >>>                  kvm_slot_sync_dirty_pages(mem);
> >>>              }
> >>>  
> >>> +            if (kvm_mem_wants_vma_protection(mr)) {
> >>> +                kvm_set_memory_readwrite(mem->ram, mem->memory_size);
> >>> +            }
> >>> +
> >>>              /* unregister the slot */
> >>>              g_free(mem->dirty_bmap);
> >>>              mem->dirty_bmap = NULL;
> >>> @@ -1746,6 +1787,10 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
> >>>              }
> >>>          }
> >>>  
> >>> +        if (kvm_mem_wants_vma_protection(mr)) {
> >>> +            kvm_set_memory_readonly(mem->ram, mem->memory_size);
> >>> +        }
> >>> +
> >>>          start_addr += slot_size;
> >>>          ram_start_offset += slot_size;
> >>>          ram += slot_size;
> >>> @@ -4771,6 +4816,11 @@ void kvm_mark_guest_state_protected(void)
> >>>      kvm_state->guest_state_protected = true;
> >>>  }
> >>>  
> >>> +void kvm_enable_ro_mem_vma_protection(void)
> >>> +{
> >>> +    kvm_state->guest_wants_ro_mem_vma_protection = true;
> >>> +}
> >>> +
> >>>  int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
> >>>  {
> >>>      int fd;
> >>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> >>> index 1a41a5972bd0..9590458e00c5 100644
> >>> --- a/hw/i386/pc_sysfw.c
> >>> +++ b/hw/i386/pc_sysfw.c
> >>> @@ -254,13 +254,18 @@ void pc_system_firmware_init(PCMachineState *pcms,
> >>>          }
> >>>      } else {
> >>>          if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
> >>> -            /*
> >>> -             * Older KVM cannot execute from device memory. So, flash
> >>> -             * memory cannot be used unless the readonly memory kvm
> >>> -             * capability is present.
> >>> -             */
> >>> -            error_report("pflash with kvm requires KVM readonly memory support");
> >>> -            exit(1);
> >>> +            if (sev_es_enabled() && !sev_snp_enabled()) {
> >>> +                warn_report("pflash not supported with SEV-ES guests, "
> >>> +                            "attempting VMA based protection");
> >>> +            } else {
> >>> +                /*
> >>> +                 * Older KVM cannot execute from device memory. So, flash
> >>> +                 * memory cannot be used unless the readonly memory kvm
> >>> +                 * capability is present.
> >>> +                 */
> >>> +                error_report("pflash with kvm requires KVM readonly memory support");
> >>> +                exit(1);
> >>> +            }
> >>>          }
> >>>  
> >>>          pc_system_flash_map(pcms, rom_memory);
> >>> diff --git a/target/i386/sev.c b/target/i386/sev.c
> >>> index f04ae4e91f3e..82cf2c562729 100644
> >>> --- a/target/i386/sev.c
> >>> +++ b/target/i386/sev.c
> >>> @@ -550,12 +550,6 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
> >>>              return -1;
> >>>          }
> >>>      } else {
> >>> -        if (sev_features && sev_es_enabled()) {
> >>> -            error_setg(errp,
> >>> -                       "%s: SEV features are not supported with SEV-ES at this time",
> >>> -                       __func__);
> >>> -            return -1;
> >>> -        }
> >>>          if (sev_features & SVM_SEV_FEAT_SNP_ACTIVE) {
> >>>              error_setg(errp,
> >>>                         "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
> >>> @@ -2024,6 +2018,15 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> >>>          return -1;
> >>>      }
> >>>  
> >>> +    /*
> >>> +     * Use VMA-based protection for SEV-ES guests that enable any
> >>> +     * SEV feature, since KVM does not advertise readonly memory
> >>> +     * support for non-default type SEV guests.
> >>> +     */
> >>> +    if (sev_es_enabled() && SEV_COMMON(cgs)->sev_features) {
> >>> +        kvm_enable_ro_mem_vma_protection();
> >>> +    }
> >>> +
> >>>      if (!cgs->ready) {
> >>>          /*
> >>>           * SEV uses these notifiers to register/pin pages prior to guest use,
> >>> @@ -2111,7 +2114,13 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
> >>>      if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
> >>>          int ret;
> >>>  
> >>> +        /*
> >>> +         * KVM requires these pages to be RW, so remove VMA RO protection
> >>> +         * for the duration of SEV_LAUNCH_UPDATE if using SEV features.
> >>> +         */
> >>> +        kvm_set_memory_readwrite(ptr, len);
> >>>          ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
> >>> +        kvm_set_memory_readonly(ptr, len);
> >>>          if (ret < 0) {
> >>>              return ret;
> >>>          }
> >>>
> >>> base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
> >>> prerequisite-patch-id: dc27ad6297d47d063b04fa797c1b8203ee97d9c8
> >>> prerequisite-patch-id: 603eff49233c4b0483e7c405754b95aa455dd38c
> >>> prerequisite-patch-id: d4085e72ecfb0fbf977f7358d1edd29951b93784
> >>> prerequisite-patch-id: f6f201825b1e56f89a87a26bc457b3e6018aee49
> >>> prerequisite-patch-id: 08d79cec4c3f117178be8f6c866ff1be08e971f3
> >>> prerequisite-patch-id: c112bccab9ab9cee2d0227516fc857590b99a75b
> >>> prerequisite-patch-id: f42fd829d0ea4909537e722477057a4013a247ab
> >>> prerequisite-patch-id: 67136368ed1d2fa0ae55fee4368a7bd1fe394368
> >>> prerequisite-patch-id: 08349bb1e0e11ee1518a9041771302c97866b5cd
> >>> -- 
> >>> 2.54.0
> >>>
> >>>
> 

