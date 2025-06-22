Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81044C7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 20:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTRb8-0001Ft-Ay; Sun, 22 Jun 2025 16:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mclark@anarch128.org>)
 id 1uTRb5-0001Fg-VW
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 16:47:27 -0400
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mclark@anarch128.org>)
 id 1uTRb4-0007ln-2O
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 16:47:27 -0400
Received: from [192.168.1.4] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 55MKlKMR3792594
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 20:47:23 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=dO449B6R header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1750625244;
 bh=/Zq9O3YclOKm26FthjRjfkjPrr4RcoLYEob6Erd3Yak=;
 h=Date:To:From:Subject:From;
 b=dO449B6RZVE/qIQeL3ym9ZG+0Mju7sopsykv3XTR95K7WPkpR0TLR5+Dfkh1AOSuz
 /nGNN+jH/DQfBAlMFLhsRWQcuxvbWDUq9apn6rPeLJ72Ug/Xbe7GcnH3XJPwfX7dRG
 Ud4gKGYn0QWFDhWQMF2XCzHKFPHE7DouUS776/lZxSSX5CQyLVQxuXlVqIOoB0fpOV
 rn8iCYGZAewcHmojZ00xuWE3UD4N6OAnZ6CeeSj3mCeQ0o+9yMyNJCpGrRfGEu8K7Q
 vtE1+VL3P1et4cS9ZEPnH8/qMeoQboapiJbLyzyfkd0qKQ+UA24YjPESuyNvA5u4Kj
 zzTGVw+U+cBVw==
Message-ID: <8fcfc520-e3e1-46d9-aeed-30ba6486f82a@anarch128.org>
Date: Mon, 23 Jun 2025 08:47:15 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
From: Michael Clark <mclark@anarch128.org>
Subject: page coloring and accelerated shadow paging
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=mclark@anarch128.org; helo=anarch128.org
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

Hi QEMU Folks,

# background

I'm sending this out here because if I was a QEMU developer I'd like
to read about this, as it is informed by working on QEMU and other
simulators and emulators. this work is by-no-means complete. in fact,
it is just the beginning, but there is enough present for feedback.
in particular an early revision of the virtual memory system design.

# overview

a new system that is not yet in a simulator but documents some
interesting concepts such as canonicalized 'translation addresses'
possessing address space prefixes to ease meta-circular emulation of
physical and virtual memory. the core is designed to make shadow-paging
efficient as a foreign page table architecture, but there are
extended 'features' that would need to be in hardware to be fast.
the intention is that the address space prefixes are in registers to
address the "address space narrowing problem". there is also an
intention to add an as yet undefined MIPS-inspired TLB miss handler,
so that the page walker logic can be in software. this is to to make
adding support for foreign page table formats much easier. and when
translated to native code most of it will be cache miss latency anyway.

btw this started as a sketch in a gist in June 20th of last year:

https://gist.github.com/michaeljclark/8f9b81e5e40488035dc252c9da3ecc2e

# the glyph architecture

current: https://metaparadigm.com/~mclark/glyph.pdf
latest: https://metaparadigm.com/~mclark/glyph-20250622.pdf

a clean-slate, portable virtual machine designed for efficient binary
translation to X86 system mode targeting features like SMAP, SMEP,
APIC, TSC, and PCI-style message signaled interrupts, with a system
model that favors simplicity e.g., only supervisor/user modes and no
interrupt delegation. the fundamental architectural design elements,
such as the variable length instruction packet format and split
instruction and constant streams are in place, the 16-bit compressed
opcodes are fully specified, and there is now the beginnings of a
system or protected mode. yet there is still a lot of work for it to
virtualize a target like X86+AVX-512 with address translation.

## address translation

adopts a page table format designed for shadow paging on X86. the page
translation system has a physical address permission check feature and
adds PTE.T (translate bit) for optional hardware zoning of translation
pages. in addition to virtual memory, the translation system performs
optional per-page physical permission checks, and physical self-mapping
validation with zoning for PTE pages that have the PTE.T bit set.

the architecture introduces the concept of a translation address which
are addresses boxed with an address space prefix (AS) designed to
provide a canonical address form for user and supervisor virtual
addresses as well as physical addresses, to make it easier to implement
meta-circular emulation for nested page translation with translation
agnostic source and destination address spaces.

## capabilities checks

adds overlay permissions for page table colors 'colorperms' which cause
faults during address translation. also 'colorcaps' and 'colormatrix'
add capability checks at execute time and are not part of page table
translation. colorcaps is used to control use of system instructions
based on page color. colormatrix is used to control source and target
page capabilities for loads, stores, and branches. goal: allow load,
store, and branch permission restrictions via source and destination
page color pair forwarding. requires the micro-architecture to track
source:target page colors for branch retirement permission checks.

## toolchain and debug strategy

developing three simulators (Python, C, Go) for cross-validation, with
plans for a Python assembler mainly to avoid binutils during early
bring-up. the assembler and linker need to support capabilities with
graph coloring to augment section permissions with section colors.
operating system kernels and runtime loaders will also need support.

Regards,
Michael.

