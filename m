Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B0BF4644B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25ay-0003XH-GJ; Mon, 16 Mar 2026 06:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w25at-0003We-5z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:54:43 -0400
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w25aq-0008Nz-6s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:54:42 -0400
Message-ID: <588a9b07-72d7-4222-851a-f174b1949839@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1773658477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8JbMHGnwWRxCCU8ruAi7a09uWr6H7vzF0Xd2uPfYpc=;
 b=DinX83dpT+by+KFknbJDDVGycBBX+7AEIuE2dtdaQWTU2yQJU+ojzuVP1RKR+gu9cTgmhm
 0K4W/owoiTMdvuMKIpbkJ3rX0hwgI1rvmVp2R6zvtI4PRPJBA9vlLtuddP+OWBCSNP7QIB
 YfS0jFZ15LYUsRD30NEvSVCjwSWDWRs=
Date: Mon, 16 Mar 2026 18:54:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH rfc] hvf: arm: Inject SEA when executing insn in invalid
 memory range
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org
References: <20260315163840.30741-1-zenghui.yu@linux.dev>
 <87ikawnmcq.fsf@draig.linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <87ikawnmcq.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::bc;
 envelope-from=zenghui.yu@linux.dev; helo=out-188.mta0.migadu.com
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

Hi Alex,

On 3/16/26 5:40 PM, Alex Bennée wrote:
> Zenghui Yu <zenghui.yu@linux.dev> writes:
> 
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
> 
> Have you got patches for teaching kvm-unit-tests about hvf or are you
> running these all manually? I tried building on the Mac we have but it
> failed the build and the docs only mention x86.

No more patches. This is how I build and test it on my M1:

./configure --arch=aarch64 --page-size=16k --cross-prefix=aarch64-elf-
make && make standalone
QEMU=qemu-system-aarch64 ACCEL=hvf ./run_tests.sh

The command line above is copied from logs/selftest-vectors-kernel.log.

> >   PASS: selftest: vectors-kernel: und
> >   PASS: selftest: vectors-kernel: svc
> >   qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
> >   qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
> >   qemu-system-aarch64: 0xffffc000: unhandled exception ec=0x20
> 
> I think this is running:
> 
>   static bool check_pabt(void)
>   {
>           enum vector v = check_vector_prep();
> 
>           install_exception_handler(v, ESR_EL1_EC_IABT_EL1, pabt_handler);
> 
>           test_exception("adrp	x9, check_pabt_invalid_paddr\n"
>                          "add	x9, x9, :lo12:check_pabt_invalid_paddr\n"
>                          "ldr	x9, [x9]\n",
>                          "blr	x9\n",
>                          "", "x9", "x30");
> 
>           install_exception_handler(v, ESR_EL1_EC_IABT_EL1, NULL);
> 
>           return pabt_works;
>   }
> 
> which is expecting 0x21 - instruction abort at the same exception level.
> I wonder why there is the difference.

It's the guest that executes an instruction outside of the valid memory
range. From hypervisor's perspective, it's an instruction abort from a
lower EL, so we get the syndrome saying that EC=0x20. We then decide
that we should emulate the hardware behavior by injecting an SEA into
the insane guest.

And from guest's perspective, it's an instruction abort caused by itself
(thus EC=0x21 - instruction abort taken without a change in EL).

> >   [...]
> >
> > It's apparent that the guest is braindead and it's unsure what prevents hvf
> > from injecting an abort directly in that case. Try to deal with the insane
> > guest in QEMU by injecting an SEA back into it in the EC_INSNABORT
> > emulation path.
> >
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
> > +            uint32_t syn;
> > +
> > +            /* inject an SEA back into the guest */
> > +            syn = syn_insn_abort(arm_current_el(env) == 1, ea, false, 0x10);
> > +            hvf_raise_exception(cpu, EXCP_PREFETCH_ABORT, syn, 1);
> > +            break;
> > +        }
> > +
> >          /* fall through */
> >      }
> >      default:
> 
> I need the check the exception paths for KVM and TCG. I guess for the
> KVM case it is all in the kernel?

Yup, in kvm_handle_guest_abort().

Thanks,
Zenghui

