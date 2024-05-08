Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BC6C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 20:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4o4f-0001ZN-S9; Wed, 08 May 2024 16:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4o4e-0001ZB-AM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 16:39:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4o4b-000138-9P
 for qemu-devel@nongnu.org; Wed, 08 May 2024 16:39:35 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4304F4E6426;
 Wed, 08 May 2024 22:39:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yucvX9VFFfW9; Wed,  8 May 2024 22:39:28 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 51D1F4E63BF; Wed, 08 May 2024 22:39:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5010E746E3B;
 Wed, 08 May 2024 22:39:28 +0200 (CEST)
Date: Wed, 8 May 2024 22:39:28 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Sergio Lopez <slp@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 0/6] X86: Alias isa-bios area and clean up
In-Reply-To: <20240508175507.22270-1-shentey@gmail.com>
Message-ID: <bf76c488-c454-e893-89f5-94e78a8d0329@eik.bme.hu>
References: <20240508175507.22270-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 8 May 2024, Bernhard Beschow wrote:
> This series changes the "isa-bios" MemoryRegion to be an alias rather than a
> copy in the pflash case. This fixes issuing pflash commands in the isa-bios
> region which matches real hardware and which some real-world legacy bioses I'm
> running rely on. Furthermore, aliasing in the isa-bios area is already the

I wonder if this allows the guest to flash the bios now, replacing or 
breaking it which may be a new security issue. If so this may need some 
machine property to enable it or is that not a problem in practice?

Regards,
BALATON Zoltan

> current behavior in the bios (a.k.a. ROM) case, so this series consolidates
> behavior.
>
> For migration compatibility the aliasing is only performed on new versions of
> the q34 and pc machine types.
>
> v3:
> * Amend commit message with a diff of `info mtree` (Phil)
> * Add comments for bios memory regions (Phil)
>
> v2:
> * Don't leak bios memory regions (Phil)
> * Add compat machinery (Michael)
>
> Testing done:
> * `make check` with qemu-system-x86_64 (QEMU 8.2.2) installed. All tests
>  including migration tests pass.
> * `make check-avocado`
>
> Best regards,
> Bernhard
>
> Bernhard Beschow (6):
>  hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
>  hw/i386: Have x86_bios_rom_init() take X86MachineState rather than
>    MachineState
>  hw/i386/x86: Don't leak "isa-bios" memory regions
>  hw/i386/x86: Don't leak "pc.bios" memory region
>  hw/i386/x86: Extract x86_isa_bios_init() from x86_bios_rom_init()
>  hw/i386/pc_sysfw: Alias rather than copy isa-bios region
>
> include/hw/i386/pc.h  |  1 +
> include/hw/i386/x86.h | 17 +++++++++++++++-
> hw/i386/microvm.c     |  2 +-
> hw/i386/pc.c          |  1 +
> hw/i386/pc_piix.c     |  3 +++
> hw/i386/pc_q35.c      |  2 ++
> hw/i386/pc_sysfw.c    | 17 ++++++++++------
> hw/i386/x86.c         | 45 ++++++++++++++++++++++---------------------
> 8 files changed, 58 insertions(+), 30 deletions(-)
>
> --
> 2.45.0
>
>
>

