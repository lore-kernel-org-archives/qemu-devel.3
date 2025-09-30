Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3758ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 21:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hRd-0005oF-UJ; Tue, 30 Sep 2025 16:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1v3hRc-0005o4-8L
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:59:32 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1v3hRS-0001bY-Ln
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:59:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AC54760370;
 Tue, 30 Sep 2025 20:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117EEC4CEF0;
 Tue, 30 Sep 2025 20:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759265951;
 bh=YwAOuioIIR5I1oaq12o9gZBYaQxDk23GLCuikdfznPg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DWaeB9vv01yTrgVb3aGHvssuJiiYGi28TNMTrbbDAuyxa3jAxRvnQBxML8LrEY168
 P/Dngg6NQxJKTwmWVEhzFe18RrPPZi8RTTjyWuJlMQ3Rc72NnyYVAw5O7faacOfECy
 IOC4XPJy00fzxezAFVCkLXxv3aR458cwJXNu1PZNFQNHgjuvoarJHVMoH5Tj5xuxdX
 rdxF3rU4rV9ZjgoVU/799vz/bxViKceXlK3YU9LXxalO7ZpxRc2crpb1JrH47e6XkA
 LgWzwOMF75hg0V8e9iD2xmu7KQ5KW5ntgZHOWWdu7eNXQcMKTnUlHt0r2GTetmZaUN
 weR5YWwHHs37Q==
Date: Tue, 30 Sep 2025 20:59:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aNxEncZikGbv39hf@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 06:48:20PM +0200, Magnus Kulke wrote:
> Hello all,
> 
> This is the fourth revision of a patch set implementing an accelerator
> for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in
> various scenarios. Thanks for the feedback to the previous revision, I
> tried to incorporate those. The changes in the currenct patchset beyond
> the suggested fixes are mostly related to the replacement of retired
> ioctl calls that will not part of the upstreamed MSHV kernel driver.

Externally we follow Microsoft's convention of calling Linux the "root
partition" in this setup. "Dom0" is an internal term. We drew parallels
to Xen at the beginning of the project.

> Magnus Kulke (26):
>   accel: Add Meson and config support for MSHV accelerator
>   target/i386/emulate: Allow instruction decoding from stream
>   target/i386/mshv: Add x86 decoder/emu implementation
>   hw/intc: Generalize APIC helper names from kvm_* to accel_*
>   include/hw/hyperv: Add MSHV ABI header definitions
>   linux-headers/linux: Add mshv.h headers
>   accel/mshv: Add accelerator skeleton
>   accel/mshv: Register memory region listeners
>   accel/mshv: Initialize VM partition
>   accel/mshv: Add vCPU creation and execution loop
>   accel/mshv: Add vCPU signal handling
>   target/i386/mshv: Add CPU create and remove logic
>   target/i386/mshv: Implement mshv_store_regs()
>   target/i386/mshv: Implement mshv_get_standard_regs()
>   target/i386/mshv: Implement mshv_get_special_regs()
>   target/i386/mshv: Implement mshv_arch_put_registers()
>   target/i386/mshv: Set local interrupt controller state
>   target/i386/mshv: Register CPUID entries with MSHV
>   target/i386/mshv: Register MSRs with MSHV
>   target/i386/mshv: Integrate x86 instruction decoder/emulator
>   target/i386/mshv: Write MSRs to the hypervisor
>   target/i386/mshv: Implement mshv_vcpu_run()
>   accel/mshv: Handle overlapping mem mappings
>   target/i386/mshv: Use preallocated page for hvcall
>   docs: Add mshv to documentation
>   MAINTAINERS: Add maintainers for mshv accelerator
> 
> Praveen K Paladugu (1):
>   qapi/accel: Allow to query mshv capabilities
> 

I've gone through this patch series and it generally looks good to me.

   Acked-by: Wei Liu <wei.liu@kenrel.org>

It would be great if we can merge this soon so we can do more testing
and implement other missing features.

Wei

