Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0F3C531EA
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 23:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtDSv-0002jw-T9; Thu, 19 Feb 2026 18:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vtDSu-0002jo-5Q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 18:29:48 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vtDSr-0006y6-Vs
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 18:29:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3F45E596A1A;
 Fri, 20 Feb 2026 00:29:41 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id N2SNegRZUwfV; Fri, 20 Feb 2026 00:29:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 00CE15969FC; Fri, 20 Feb 2026 00:29:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF8F55969F4;
 Fri, 20 Feb 2026 00:29:38 +0100 (CET)
Date: Fri, 20 Feb 2026 00:29:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/8] memory: Remove most _nomigrate variants
In-Reply-To: <cover.1770253186.git.balaton@eik.bme.hu>
Message-ID: <51705354-164e-1d89-5119-9e8a41bfa8ae@eik.bme.hu>
References: <cover.1770253186.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 5 Feb 2026, BALATON Zoltan wrote:
> v4:
> - separate patch converting Sun machines from memory_region_init_ram_nomigrate
> - split helper to init ram into two functions: setup and error_propagate
> - also use memory_region_init_io in memory_region_init_ram_device_ptr
>
> v3:
> - rebased on master after some patches were merged
> - drop some more line from memory-region-housekeeping.cocci
> - added comment to explain what factored out helper does
> - some more clean ups included
>
> BALATON Zoltan (8):
>  hw/display/{cg3,tcx}: Do not use memory_region_init_rom_nomigrate()
>  memory: Remove memory_region_init_rom_nomigrate()
>  sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
>  memory: Remove memory_region_init_ram_nomigrate()
>  memory: Factor out common ram region initialization
>  memory: Add internal memory_region_register_ram function
>  memory: Shorten memory_region_init_ram_device_ptr and
>    memory_region_init_rom_device
>  memory: Factor out more common ram region initialization
>
> docs/devel/memory.rst                         |   9 +-
> hw/display/cg3.c                              |   6 +-
> hw/display/tcx.c                              |  11 +-
> hw/display/vga.c                              |   4 +-
> hw/sparc/sun4m.c                              |  15 +-
> hw/sparc64/sun4u.c                            |   9 +-
> hw/xtensa/xtfpga.c                            |   4 +-
> include/system/memory.h                       |  49 ----
> .../memory-region-housekeeping.cocci          |  47 ---
> system/memory.c                               | 269 ++++++------------
> 10 files changed, 120 insertions(+), 303 deletions(-)

Ping?

