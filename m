Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217D3CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXe8X-00015s-0e; Thu, 11 Jun 2026 08:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wXe8U-00015R-0q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:03:50 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wXe8S-0005re-3B
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:03:49 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A52756001A;
 Thu, 11 Jun 2026 12:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6742E1F00893;
 Thu, 11 Jun 2026 12:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781179426;
 bh=RNVcN/VujjYFB5nyvNG6F+/3nKsmKdNfzojfxyMYLZg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QgvCytS7lk0ptLuT5UkPX5E92/+Jy8fIw+XzB/mu6J5EyrEBHEiEwZv19Mv1f2zYM
 BUMs0XDlZbl+kTN+cnwoZy+Y3C0hW+e3t/h/Se1dwOPht2A5dyObg7gLOeZTJqdRTU
 QxWQOzGfoBFo7pKZOVz9aPd2P/gCHKqJzMOBHyrRxXpJEfLx/Uo7nC+YSMVxoTj4Qw
 h6hY3cON39qH9fsWHOGG/7szK4iXikVX/ZlAYr0spTMhT2uy/tQQOJGfFDoosIII+G
 mgYJh6jnwfOdq2nsYcQbAWeZiygwi8TajAx435wl8J/pWt0tbX7WPTbYUl66omlvRQ
 /gzrhPHNifYmQ==
Date: Thu, 11 Jun 2026 17:25:45 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Michael Roth <michael.roth@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] target/i386: SEV: Allow pflash devices with SEV-ES
 guests
Message-ID: <aiqgcGahFs1vtvJg@blrnaveerao1>
References: <20260602071213.2084388-1-naveen@kernel.org>
 <b7xwzrdt4zg5g45ufhqj46d3f4uezpy733gnsc7bv4cploxevz@rw327aciq2cg>
 <ailAARL2xS7qSNzL@blrnaveerao1>
 <etsmb632acnswvmkkwrjuzzqpxkiw3tac4rkyuadnmquylibhs@5gscftwr7cyv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <etsmb632acnswvmkkwrjuzzqpxkiw3tac4rkyuadnmquylibhs@5gscftwr7cyv>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 10, 2026 at 02:41:58PM -0500, Michael Roth wrote:
> On Wed, Jun 10, 2026 at 05:00:11PM +0530, Naveen N Rao wrote:
> > [+Sean]
> > 
> > Hi Mike,
> > 
> > On Tue, Jun 09, 2026 at 07:35:46PM -0500, Michael Roth wrote:
> > > On Tue, Jun 02, 2026 at 12:42:13PM +0530, Naveen N Rao (AMD) wrote:
> > > > KVM commit 66155de93bcf ("KVM: x86: Disallow read-only memslots for
> > > > SEV-ES and SEV-SNP (and TDX)"), and the subsequent commit d30d9ee94cc0
> > > > ("KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM")
> > > > stopped advertising KVM_CAP_READONLY_MEM support for encrypted guests
> > > > (KVM_X86_SEV_ES_VM and KVM_X86_SNP_VM), but not for KVM_X86_DEFAULT_VM
> > > > type SEV-ES guests. As a result of this, it is no longer possible to
> > > > start SEV-ES guests with any SEV feature enabled (in particular,
> > > > debug-swap) with pflash devices.
> > > > 
> > > > This is an issue since SEV-ES guests have historically used pflash
> > > > devices for OVMF. Guests on older KVM+Qemu are able to enable debug-swap
> > > > while using pflash devices, so work around the KVM limitation by
> > > > switching to using a VMA-based write protection. This allows
> > > > well-behaved SEV-ES guests to continue to work with pflash devices and
> > > > enable debug-swap. Mis-behaving guests trying to write to the protected
> > > > OVMF area will be killed.
> > > 
> > > Based on Sean's description, a write access to a read-only memslot would
> > > cause the vCPU to permanently spin on #NPFs if trying to write to it as
> > > MMIO due to #VC handler not triggering, and that's why we don't support
> > > read-only memslots. But since SEV-ES was previously working with pflash,
> > > it seems like it does not rely on this functionality...
> > 
> > Right, normal well-behaved SEV-ES/SNP guests work just fine as they 
> > don't write to any of the read-only areas.
> > 
> > > 
> > > So if OVMF isn't writing to write-protected memory, then it wouldn't be
> > > triggering the MMIO emulation path in the first place. And if we don't
> > > care about enabling the emulation path in this case... then I'm not sure
> > > the original reasons for not allowing it for SEV-ES/SNP are applicable.
> > 
> > Guest (not just OVMF) could try and write to the read-only area 
> > triggering this issue. A simple write to 0xc0000 from within the guest 
> > triggers this.
> 
> Is that still true even with this patch?
> 
>   commit 0f4a1e80989aca185d955fcd791d7750082044a2
>   Author: Kevin Loughlin <kevinloughlin@google.com>
>   Date:   Wed Mar 13 12:15:46 2024 +0000
>   
>       x86/sev: Skip ROM range scans and validation for SEV-SNP guests
>       
>       SEV-SNP requires encrypted memory to be validated before access.
>       Because the ROM memory range is not part of the e820 table, it is not
>       pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
>       to access this range, the guest must first validate the range.
>       
>       The current SEV-SNP code does indeed scan the ROM range during early
>       boot and thus attempts to validate the ROM range in probe_roms().
>       However, this behavior is neither sufficient nor necessary for the
>       following reasons:
> 
>       ...

Yes, that was mostly a change for SEV-SNP guests, and only to not have 
the kernel access those regions. Userspace is still free to access 
through /dev/mem.

> 
> but in that case, those private accesses didn't work because they were
> accessing legacy MMIO regions as private/encrypted even though none of the
> option ROMs were loaded into memory as encrypted, so they're basically just
> garbage/legacy regions we try to completely ignore on the guest-side now and
> any lingering cases should probably get the same treatment.
> 
> It would be nice to still be able to catch write accesses....but I think we
> still could (with the kernel changes discussed in my reply to Tom) if we
> really wanted that. But is that really a hard requirement? Personally, the
> -bios vs pflash argument thing makes this feel justified since -bios also
> let's the writes through silently, but maybe we can do better with kernel
> changes.

Indeed.

> 
> > 
> > > 
> > > It feels like KVM_CAP_READONLY_MEM is more like KVM_CAP_EMULATE_ON_WRITE,
> > > whereas we literally just need as actually slot that's permanently mapped
> > > in the NPT without write access.
> > > 
> > > Is that an accurate summary of the situation?
> > 
> > Yes, that sounds right to me.
> > 
> > > 
> > > If so, maybe we can introduce a KVM_CAP_READONLY_NO_MMIO that captures
> > > this and simply errors out if it hits the KVM_PFN_ERR_RO_FAULT.
> > 
> > That would certainly work.
> > 
> > > Or, for
> > > a QEMU-specific workaround, just have a pflash implementation that doesn't
> > > rely on KVM_MEM_READONLY for cases like this where we don't need MMIO
> > > emulation.
> > 
> > Not sure I follow that... are you suggesting that pflash use regular RW 
> > memslots and just let the write through?
> 
> Yes, isn't that basically what we're getting with -bios? At least this
> way we don't have the awkwardness of needing to randomly switch from -bios
> to pflash based on what SEV features the user selects, which is pretty
> bad.
> 
> But that was more of a last resort, maybe we haven't yet bottomed out on
> whether we could do things a bit more nicely with some kernel help as
> discussed elsewhere in this thread.

Yes, letting the writes through is simple enough as a last resort. The 
VMA based protection I have implemented here is the other option if we 
want to be able to prevent writes without KVM's help (but will likely 
need more work overall).


Thanks,
Naveen


