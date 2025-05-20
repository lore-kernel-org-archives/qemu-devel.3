Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF62DC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQsx-0007pB-Bp; Tue, 20 May 2025 13:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHQsv-0007oy-UE
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:36:13 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHQst-0007yE-1M
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:36:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EE0F85C571A;
 Tue, 20 May 2025 17:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B369C4CEE9;
 Tue, 20 May 2025 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747762568;
 bh=XVQ9ZqWWyhCr39OttYO/hxC4ZBpo/F2gAlm2ZR7Ocbs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HiCxf1XqcoqPoMnqDJAtG7oFqHO3o6RKp4iZHPJJa5G0HUouHF5k24FBLVgpDIpFO
 8OtLuc1nSYyb/kBGK5DyPHCUh1f0Ktr13pU2fiTaulpB+PjYIRp4rEXxHUsA6hvjDP
 esqT1Pe0G+ehRfAp5VyLh3uGpO9P2L6xOdiAA8E98KxUYWs2ui4xOvNLjNJnbFwj3w
 WiWlZfvlLPyPW69WDbDozVWspSr+tfnw5QnCBP1KMjuUjgys+pPN0OIay2eaGWU1yP
 eaDWVosw22y4ohVFc3oScalD9iIxHKHHoCyrnDuGuVpx6zFTYyMEDdTo3D7xPnGAHw
 qZlVAoVQXJ3hw==
Date: Tue, 20 May 2025 17:36:07 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 03/25] target/i386/mshv: Add x86 decoder/emu
 implementation
Message-ID: <aCy9h-hDHLFzdUXg@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-4-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-4-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=wei.liu@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 01:29:56PM +0200, Magnus Kulke wrote:
> The MSHV accelerator requires a x86 decoder/emulator in userland to
> emulate MMIO instructions. This change contains the implementations for
> the generalized i386 instruction decoder/emulator.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
[...]
> +bool x86_read_segment_descriptor(CPUState *cpu,
> +                                 struct x86_segment_descriptor *desc,
> +                                 x86_segment_selector sel)
> +{
> +    target_ulong base;
> +    uint32_t limit;
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    target_ulong gva;
> +    /* int ret; */

Unused code. Please drop.

> +
> +    memset(desc, 0, sizeof(*desc));
> +
> +    /* valid gdt descriptors start from index 1 */
> +    if (!sel.index && GDT_SEL == sel.ti) {
> +        return false;
> +    }
> +
> +    if (GDT_SEL == sel.ti) {
> +        base = env->gdt.base;
> +        limit = env->gdt.limit;
> +    } else {
> +        base = env->ldt.base;
> +        limit = env->ldt.limit;
> +    }
> +
> +    if (sel.index * 8 >= limit) {
> +        return false;
> +    }
> +
> +    gva = base + sel.index * 8;
> +    emul_ops->read_mem(cpu, desc, gva, sizeof(*desc));
> +
> +    return true;
> +}
> +
> +bool x86_write_segment_descriptor(CPUState *cpu,
> +                                  struct x86_segment_descriptor *desc,
> +                                  x86_segment_selector sel)
> +{
> +    target_ulong base;
> +    uint32_t limit;
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    /* int ret; */

Unused code. Please drop.

> +    target_ulong gva;
> +
> +    if (GDT_SEL == sel.ti) {
> +        base = env->gdt.base;
> +        limit = env->gdt.limit;
> +    } else {
> +        base = env->ldt.base;
> +        limit = env->ldt.limit;
> +    }
> +
> +    if (sel.index * 8 >= limit) {
> +        return false;
> +    }
> +
> +    gva = base + sel.index * 8;
> +    emul_ops->write_mem(cpu, desc, gva, sizeof(*desc));
> +
> +    return true;
> +}
> +
[...]
> +
> +target_ulong linear_addr(CPUState *cpu, target_ulong addr, X86Seg seg)
> +{
> +    int ret;
> +    target_ulong linear_addr;
> +
> +    /* return vmx_read_segment_base(cpu, seg) + addr; */

Unused code.

Thanks,
Wei.

> +    ret = linearize(cpu, addr, &linear_addr, seg);
> +    if (ret < 0) {
> +        error_report("failed to linearize address");
> +        abort();
> +    }
> +
> +    return linear_addr;
> +}
> +
> +target_ulong linear_addr_size(CPUState *cpu, target_ulong addr, int size,
> +                              X86Seg seg)
> +{
> +    switch (size) {
> +    case 2:
> +        addr = (uint16_t)addr;
> +        break;
> +    case 4:
> +        addr = (uint32_t)addr;
> +        break;
> +    default:
> +        break;
> +    }
> +    return linear_addr(cpu, addr, seg);
> +}
> +
> +target_ulong linear_rip(CPUState *cpu, target_ulong rip)
> +{
> +    return linear_addr(cpu, rip, R_CS);
> +}
> -- 
> 2.34.1
> 

