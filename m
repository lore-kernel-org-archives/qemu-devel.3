Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E41109448B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 17:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3zpz-0006YS-NZ; Sat, 21 Mar 2026 13:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w3zpx-0006Xw-5v; Sat, 21 Mar 2026 13:10:09 -0400
Received: from out-173.mta0.migadu.com ([2001:41d0:1004:224b::ad])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w3zpt-0000XH-95; Sat, 21 Mar 2026 13:10:08 -0400
Message-ID: <7c4ce7f4-7a50-40e3-b80f-e776eaac4984@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1774112999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfMUkxEIRNh0tPbSS5ioPEQH7Id9RaRMDb59lAXqzO0=;
 b=GxIAb+TkeWZb2bjig9S5KyugH0jz82kqmIyj1trUD86LGRN3Pi0IORVVkX4SkFkW4I+pKS
 qiDNa/c2z+P2zooZ4veWzVNER9qxjUUT+9iAl2fCWTPcdfEJ6DcKHpBPgX6V6415yj0u+N
 dREiEm5kKQNZABd3YjbaUajrxoQUKRY=
Date: Sun, 22 Mar 2026 01:09:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH rfc] hvf: arm: Inject SEA when executing insn in invalid
 memory range
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@csgraf.de
References: <20260315163840.30741-1-zenghui.yu@linux.dev>
 <CAFEAcA_kj1eRpjMYDF4b6hD1_P0+PazzdHFfTJFj=Hn231DBGA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <CAFEAcA_kj1eRpjMYDF4b6hD1_P0+PazzdHFfTJFj=Hn231DBGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ad;
 envelope-from=zenghui.yu@linux.dev; helo=out-173.mta0.migadu.com
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

Hi Peter,

On 3/20/26 6:52 PM, Peter Maydell wrote:
> On Sun, 15 Mar 2026 at 16:39, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> >
> > It seems that hvf doesn't deal with the abort generated when guest tries to
> > execute instructions outside of the valid physical memory range, for
> > unknown reason. The abort is forwarded to userspace and QEMU doesn't handle
> > it either, which ends up with faulting on the same instruction infinitely.
> >
> > This was noticed by the kvm-unit-tests/selftest-vectors-kernel failure:
> >
> >   timeout -k 1s --foreground 90s /opt/homebrew/bin/qemu-system-aarch64 \
> >     -nodefaults -machine virt -accel hvf -cpu host \
> >     -device virtio-serial-device -device virtconsole,chardev=ctd \
> >     -chardev testdev,id=ctd -device pci-testdev -display none \
> >     -serial stdio -kernel arm/selftest.flat -smp 1 -append vectors-kernel
> >
> >   PASS: selftest: vectors-kernel: und
> >   PASS: selftest: vectors-kernel: svc
> >   qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
> >   qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
> >   qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
> >   [...]
> >
> > It's apparent that the guest is braindead and it's unsure what prevents hvf
> > from injecting an abort directly in that case. Try to deal with the insane
> > guest in QEMU by injecting an SEA back into it in the EC_INSNABORT
> > emulation path.
> 
> Shouldn't that be an AddressSize fault, not an external abort?

I should have described this problem more clearly, see below.

> My guess would be that hvf is handing us the EC_INSNABORT
> cases for the same reason it hands us EC_DATABORT cases --
> we might have some ability to emulate the access. We probably
> also get this for cases like "guest tries to execute out of
> an MMIO device".
> 
> What happens for a data access to this kind of
> out-of-the-physical-memory-range address? Does hvf
> pass it back to us, or handle it internally?
> 
> Is the problem here a bogus virtual address from the guest's
> point of view, or a valid virtual address that the guest's
> page tables have translated to an invalid (intermediate)
> physical address ?

After adding `--trace "hvf_vm_map" --trace "hvf_vm_unmap"` to the
testing command line, I got:

hvf_vm_map paddr:0x0000000000000000 size:0x04000000 vaddr:0x112a34000
flags:0x05/R-X
hvf_vm_map paddr:0x0000000004000000 size:0x04000000 vaddr:0x116a38000
flags:0x05/R-X
hvf_vm_map paddr:0x0000000040000000 size:0x08000000 vaddr:0x10aa30000
flags:0x07/RWX

The guest then maps a VA 0xffffc000 to IPA 0x48000000 (an IPA that
hasn't been "registered" to hvf by hv_vm_map(), and I imprecisely refer
to it as an insn in invalid memory range) and sets PC to 0xffffc000,
expecting to receive an insn abort with IFSC equals to 0x10 (i.e., an
SEA). So the problem here is "a valid virtual address that the guest's
page tables have translated to an invalid (intermediate) physical
address".

This is what check_vectors()/check_pabt_init()/check_pabt() have tested,
if you can be bothered to have a look at kvm-unit-tests. ;-)

As for the AddressSize fault, I checked that on M1, we expose
ID_AA64MMFR0_EL1.PARange as 0b0001 to guest, so the advertised PA size
is 36bits (i.e., 64GB).

After hacking KUT to let the guest map a VA to IPA 0x1000000000 (an IPA
right after 64GB) and execute an insn on that VA, the guest receives an
insn abort with IFSC equals to 0x03 (Hello, AddressSize fault!). We can
_infer_ from that that the AddressSize fault is injected internally by
hvf.

I haven't tried the "data access" side, sorry. Without some docs
describing which syndromes can be forwarded to userspace, and more
importantly, given my limited understanding of hvf, I think I'd better
stop making incomplete hacks (like this patch) to hvf. :-)

> > Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> > ---
> >  target/arm/hvf/hvf.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > index aabc7d32c1..54d6ea469c 100644
> > --- a/target/arm/hvf/hvf.c
> > +++ b/target/arm/hvf/hvf.c
> > @@ -2332,9 +2332,32 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
> >          bool ea = (syndrome >> 9) & 1;
> >          bool s1ptw = (syndrome >> 7) & 1;
> >          uint32_t ifsc = (syndrome >> 0) & 0x3f;
> > +        uint64_t ipa = excp->physical_address;
> > +        AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
> > +        hwaddr xlat;
> > +        MemoryRegion *mr;
> > +
> > +        cpu_synchronize_state(cpu);
> >
> >          trace_hvf_insn_abort(env->pc, set, fnv, ea, s1ptw, ifsc);
> >
> > +        /*
> > +         * TODO: If s1ptw, this is an error in the guest os page tables.
> > +         * Inject the exception into the guest.
> > +         */
> > +        assert(!s1ptw);
> > +
> > +        mr = address_space_translate(as, ipa, &xlat, NULL, false,
> > +                                     MEMTXATTRS_UNSPECIFIED);
> > +        if (unlikely(!memory_region_is_ram(mr))) {
> 
> This doesn't look like the right kind of check, given the
> stated problem. Addresses can be in range but not have RAM.
> 
> > +            uint32_t syn;
> > +
> > +            /* inject an SEA back into the guest */
> > +            syn = syn_insn_abort(arm_current_el(env) == 1, ea, false, 0x10);
> > +            hvf_raise_exception(cpu, EXCP_PREFETCH_ABORT, syn, 1);
> > +            break;
> > +        }
> > +
> >          /* fall through */
> 
> This "fall through" remains not correct, I think, and it's kind
> of a big part of the problem here -- if we get an EC_INSNABORT
> handed to us by hvf, then we could:
>  * stop execution, exiting QEMU (as a "situation we can't
>    handle and don't know what to do with")
>  * advance the PC over the insn (questionable...)
>  * feed some kind of exception into the guest
> 
> but "continue execution of the guest without changing PC at all"
> is definitely wrong. A fix for this problem ought to involve
> changing the EC_INSNABORT case so that it no lenger does that
> "fall through to default" at all.

I completely agree with this. Thanks for your suggestion, Peter!

Zenghui

