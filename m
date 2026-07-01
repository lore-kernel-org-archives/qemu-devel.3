Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE897C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weu0F-0008PC-6c; Wed, 01 Jul 2026 08:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weu0D-0008Oy-BO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:25:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weu0A-0007NX-Ky
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:25:17 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E7F59596708;
 Wed, 01 Jul 2026 14:25:10 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lZUPU0qfakRy; Wed,  1 Jul 2026 14:25:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6AAF5596707; Wed, 01 Jul 2026 14:25:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6977D596704;
 Wed, 01 Jul 2026 14:25:08 +0200 (CEST)
Date: Wed, 1 Jul 2026 14:25:08 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/7] ati-vga: CCE engine setup and PIO packet processing
In-Reply-To: <20260606195216.2524314-1-chad@jablonski.xyz>
Message-ID: <019e542e-0a9d-84cd-593f-357a38b8f9aa@eik.bme.hu>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

Hello,

On Sat, 6 Jun 2026, Chad Jablonski wrote:
> This series implements CCE engine setup and PIO packet submission/processing
> for the Rage 128 and Radeon. This forms the foundation for full CCE support
> for both chips in the future.

Sorry, I did not have time to review this but AFAIU this is more of an RFC 
now as it does not work with any drivers yet so you'll follow up with more 
patches anyway.

> CCE engine microcode loading is shared across Rage 128 and Radeon. Microcode
> is stored but not executed in this series. Type-0/1/2 packets are handled by
> fixed-function hardware and do not require microcode. Ring buffer (BM modes)
> and Type 3 packet processing will follow in future series.

I was wondering if anything wants to read the microcode. If not we could 
just ignore the writes and not store the data and just log when something 
tried to read. (Or just do nothing for it as uniplemented register 
accesses are already logged.) Or are you aware something that needs the 
read registers?

> There are differences between CCE setup for Rage 128 and Radeon. Patch 2
> introduces chip-specific register handlers. The packet processing itself in
> patch 7 is reusable for both chips.
>
> The plan for the next series is to tackle BM modes for Radeon. Differences
> between the two chips start to become larger in the BM modes.

So far we handled these differences within the same function with if on 
model. The differences added by this series does not seem large enough to 
not fit in an if to keep the single functions but if we go with separate 
functions instead then maybe the existing ifs should also be removed and 
split into the model specific functions with the common one named 
ati_common_reg_* then? The current series only converts new registers so 
I'd either use ifs with the single handler function or convert everything 
to stay consistent.

Regards,
BALATON Zoltan

> Hardware tests available at:
> r128: https://codeberg.org/cjab/ati-tests/src/commit/1ec2dc95d4ed8d11504723b8298847af9b5be075/tests/r128/cce.c
> r100: https://codeberg.org/cjab/ati-tests/src/commit/1ec2dc95d4ed8d11504723b8298847af9b5be075/tests/r100/cce.c
>
> Tested on Rage 128 Pro Ultra (PCI 1002:5446) and
> Radeon QY (RV100) (PCI 1002:5159).
>
> Changes from v2:
> - MM_INDEX and MM_DATA are not available through ati_reg_write
> - Use ati_int.h header instead of creating a new one
> - Drop PM4_STAT register implementation for now. It will be easier to more
>  accurately implement with BM modes.
> - Introduce chip-specific register handlers
> - Combine PM4_BUFFER_CNTL and PM4_MICRO_CNTL patches
> - Add CCE mode registers for r100
> - PM4_MICROCODE_DATAH is one bit wider for r100
> - Testing on r100 showed that GUI MMIO is not disabled in CCE mode. Now
>  gated for r128 only.
> - Small style fixes
>
> Changes from v1:
> - Rebased onto master (no longer depends on HOST_DATA series)
>
> Chad Jablonski (7):
>  ati-vga: Extract ati_reg_write() from ati_mm_write()
>  ati-vga: Chip-specific register handlers
>  ati-vga: Implement CCE microcode register handling
>  ati-vga: Implement CCE mode registers for r128
>  ati-vga: Implement CCE mode registers for r100
>  ati-vga: Disable GUI engine MMIO writes when CCE enabled (r128 only)
>  ati-vga: Process Type-0/1/2 CCE packets via PIO
>
> hw/display/ati.c        | 505 +++++++++++++++++++++++++++-------------
> hw/display/ati_cce.c    | 154 ++++++++++++
> hw/display/ati_int.h    |  73 ++++++
> hw/display/ati_regs.h   |  15 ++
> hw/display/meson.build  |   3 +-
> hw/display/trace-events |   9 +
> 6 files changed, 598 insertions(+), 161 deletions(-)
> create mode 100644 hw/display/ati_cce.c
>
>

