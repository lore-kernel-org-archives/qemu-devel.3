Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538C7C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTo12-0005et-T9; Mon, 23 Jun 2025 16:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mclark@anarch128.org>)
 id 1uTo10-0005ed-FP
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:43:42 -0400
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mclark@anarch128.org>)
 id 1uTo0y-0007Vw-GI
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:43:42 -0400
Received: from [192.168.1.4] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 55NKhRTW3857775
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 20:43:30 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=fjQN8mj2 header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1750711411;
 bh=cmegmHhQZCHQU4kgU3vgO5ur5t4ZLU1mp0ZaQn0nX04=;
 h=Date:Subject:From:To:References:In-Reply-To:From;
 b=fjQN8mj2KNRe3YPeSs629vn0ioD4q5FtfTI1TQ6DDA7OU3DxO9ByNMJKYc5EdvoYE
 LNpkJ5hP3tQ1JTf5osa74JamGLeK519qBzq50RutEg/BMgQ7gX+LXJe+FlZxgv/nMH
 zkdAzGLEKc+VyiklYNIKcsCWEdMAEChhQQl6llO4TR7D+HxC/npjSGOI4fePo9r3e3
 j/sxpl3q+991SWoXIetIOGFwQIf5T+sBz9xVdLYCs0KJMmpvkI4Uob3KKVSkiPrss7
 4xPYoPv6ZsR4gRP3zrdsCKOBbupeorkuW5KBvPmPR996yWqHKxTgcddYehO3wK0OFk
 zB7uwZtt4lN0Q==
Message-ID: <39e96cbe-16f6-401c-a401-5eeb791eeab1@anarch128.org>
Date: Tue, 24 Jun 2025 08:43:21 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: page coloring and accelerated shadow paging
From: Michael Clark <mclark@anarch128.org>
To: qemu-devel <qemu-devel@nongnu.org>
References: <8fcfc520-e3e1-46d9-aeed-30ba6486f82a@anarch128.org>
Content-Language: en-US
In-Reply-To: <8fcfc520-e3e1-46d9-aeed-30ba6486f82a@anarch128.org>
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

Hi All,

On 6/23/25 08:47, Michael Clark wrote:
[snipped]

> btw this started as a sketch in a gist in June 20th of last year:
> 
> https://gist.github.com/michaeljclark/8f9b81e5e40488035dc252c9da3ecc2e
> 
> # the glyph architecture
> 
> current: https://metaparadigm.com/~mclark/glyph.pdf
> latest: https://metaparadigm.com/~mclark/glyph-20250622.pdf
> 
> a clean-slate, portable virtual machine designed for efficient binary
> translation to X86 system mode targeting features like SMAP, SMEP,
> APIC, TSC, and PCI-style message signaled interrupts, with a system
> model that favors simplicity e.g., only supervisor/user modes and no
> interrupt delegation. the fundamental architectural design elements,
> such as the variable length instruction packet format and split
> instruction and constant streams are in place, the 16-bit compressed
> opcodes are fully specified, and there is now the beginnings of a
> system or protected mode. yet there is still a lot of work for it to
> virtualize a target like X86+AVX-512 with address translation.
> 
> ## address translation
> 
> adopts a page table format designed for shadow paging on X86. the page
> translation system has a physical address permission check feature and
> adds PTE.T (translate bit) for optional hardware zoning of translation
> pages. in addition to virtual memory, the translation system performs
> optional per-page physical permission checks, and physical self-mapping
> validation with zoning for PTE pages that have the PTE.T bit set.
> 
> the architecture introduces the concept of a translation address which
> are addresses boxed with an address space prefix (AS) designed to
> provide a canonical address form for user and supervisor virtual
> addresses as well as physical addresses, to make it easier to implement
> meta-circular emulation for nested page translation with translation
> agnostic source and destination address spaces.

there were some errata related to the spec yesterday but the bones and
intention is there. as I haven't seen page tables deployed in this way
to check self maps in a physical tree; and the primary intent, which is
to set permission for PTE zones and page table page monitoring. so
there may be some more bugs when we try to test it out in a simulator.

- https://github.com/michaeljclark/glyph/
- https://metaparadigm.com/~mclark/glyph-20250623.pdf

errata:

- swap the supervisor and physical address space prefixes
   to be consistent with Linux kernel address space on x86-64.
- physical permission self-mapping check is only on leaf entries
- fix rename P bit to T bit in 64-bit page table entry structure

turns out that if we add an 'internal' AS it would be ..FFFE0000..
so we could think about adding an internal address space prefix.

Michael.

