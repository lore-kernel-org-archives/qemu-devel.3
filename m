Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73033C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 05:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWq8S-0001D2-49; Wed, 02 Jul 2025 01:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWq8Q-0001Ca-Ig
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:35:54 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWq8N-0007KZ-Ki
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:35:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2BDF2A53012;
 Wed,  2 Jul 2025 05:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D104C4CEEE;
 Wed,  2 Jul 2025 05:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751434547;
 bh=tn27C7oEGDtOs3nSBi1Wd2oAjTDmSKsuFabo/zXVBkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AU3FXmLdV8yQmtzSScl8LzoiOjYMq6vV0E4wu+wM97KUasZCi4Y9H42Dbve6Rv0gh
 1Akv9E+LNX70+nIP3EQcROWiKsSkGOaHDMBSGHyF26vdwy98pfl2fQORCo7vPIGxxV
 /N7618/JQVfrfFuOPDNwMbtVFWNx2It7QwoOPegiAwYGbET5McUcJoHyxfSoDNsuLN
 MYkrWYDy0/opT9wIGfEzRuVXEt2X85J5cK1J0YVuyX6snTYe3qQ7OPJsLpB+XLs1gk
 TMTuD6hdQVSk6gF1lbWiNM5dKdf7yvKISHhAnOjERbF1kUF8VO/KaUQPuqyYiGoCCD
 SMWYckRpWYeiQ==
Date: Wed, 2 Jul 2025 05:35:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aGTFMn9Ua__KbGIO@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=wei.liu@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 01, 2025 at 07:28:07PM +0200, Magnus Kulke wrote:
> Hey all,
> 
[...]
> 
> Magnus Kulke (27):
>   accel: Add Meson and config support for MSHV accelerator
>   target/i386/emulate: Allow instruction decoding from stream
>   target/i386/mshv: Add x86 decoder/emu implementation
>   hw/intc: Generalize APIC helper names from kvm_* to accel_*
>   include/hw/hyperv: Add MSHV ABI header definitions
>   accel/mshv: Add accelerator skeleton
>   accel/mshv: Register memory region listeners
>   accel/mshv: Initialize VM partition
>   accel/mshv: Register guest memory regions with hypervisor
>   accel/mshv: Add ioeventfd support
>   accel/mshv: Add basic interrupt injection support
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
>   target/i386/mshv: Handle HVMSG_X64_HALT vm exit
>   accel/mshv: Workaround for overlappig mem mappings
>   docs: Add mshv to documentation

Thanks for posting this, Magnus.

I skimmed through the code and found some cosmetic issues, but overall
the code looks sensible to me.

Wei

