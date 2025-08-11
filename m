Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1C6CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 18:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulWoT-0006lR-26; Mon, 11 Aug 2025 14:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1ulWoN-0006ke-16
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:59:55 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1ulWoE-0002kI-2A
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:59:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A41A4A567DD;
 Mon, 11 Aug 2025 17:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029EBC4CEED;
 Mon, 11 Aug 2025 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754935176;
 bh=405QHhO4NCahEUrGU1Vp03wvAn++1kqDusaMJQHDKK0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BuNY51H3xy0Og3cMAatZOKUk1sqiHvL9Q4flts3d5vXxWJhtBKkjUtq8Li0wy/IAE
 CCXCmporFECcG+iEiO7OappadSvtz/6iFZ8HFa1abWQjb8BIFutx5TmUWu6sIwlmV7
 gX6BC6iXCIODfxmnXGyVg6c4NwkxC99FQ0zxIcCluMlIi+4+TX4E7gksxMPd753cnl
 LZfojRFqNTBE/l6rqFzrercbiQv31LdQzQ/5TKElk3ZObOTK3kjDsRxPQr37K/Vw2L
 SPYE01dd/VVy+ux4CIfzCbBM5h5unmj77dmFLNgyVrEe4LEH0odC0mwIGWxEiHHEyD
 dqzHGU0yrcPzw==
Date: Mon, 11 Aug 2025 17:59:34 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/26] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aJovhrGg6zxQC5V1@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=wei.liu@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Aug 07, 2025 at 04:39:25PM +0200, Magnus Kulke wrote:
> Hey all,
> 
[...]
> 
> - A discrete kernel ioctl "set_immediate_exit" (to avoid a race condition
>   when handling terminiation signals like ctrl-a x) has been tested and
>   proven to mitigate the problem. Since other consumers of /dev/mshv have
>   simular requirements as QEMU, we opted to iterate a bit more on the
>   respective kernel interface.
> 
> Magnus Kulke (25):
>   accel: Add Meson and config support for MSHV accelerator
>   target/i386/emulate: Allow instruction decoding from stream
>   target/i386/mshv: Add x86 decoder/emu implementation
>   hw/intc: Generalize APIC helper names from kvm_* to accel_*

This needs acks from KVM maintainers.

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

I only had a cursory look at this. I'm definitively not an expert on
RCU, so the more reviews we can get the better. To the best of my
(limited) knowledge, the code looks reasonable.

>   docs: Add mshv to documentation
>   MAINTAINERS: Add maintainers for mshv accelerator
> 

The rest looks okay.

> Praveen K Paladugu (1):
>   qapi/accel: Allow to query mshv capabilities
> 

This looks problematic and probably needs to be changed.

I really hope that we can commit as many patches as possible to QEMU
tree, so that we don't need to keep rebasing.

Thanks,
Wei

