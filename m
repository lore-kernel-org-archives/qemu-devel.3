Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6BCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6EkL-0001uU-HO; Tue, 07 Oct 2025 16:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v6EkJ-0001uM-Bg
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:57:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v6EkH-0004AV-J0
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:57:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B061656F2FF;
 Tue, 07 Oct 2025 22:57:15 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id PjCNcFv6UpII; Tue,  7 Oct 2025 22:57:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9E5B356F2CA; Tue, 07 Oct 2025 22:57:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C31856F2A3;
 Tue, 07 Oct 2025 22:57:13 +0200 (CEST)
Date: Tue, 7 Oct 2025 22:57:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com
Subject: Re: [PATCH] ati-vga: Fix framebuffer mapping by using hardware-correct
 aperture sizes
In-Reply-To: <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
Message-ID: <2203259a-9ea3-f19d-1a81-b0c208dcd02f@eik.bme.hu>
References: <20251001034616.3017119-1-chad@jablonski.xyz>
 <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
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

On Tue, 7 Oct 2025, BALATON Zoltan wrote:
> Hello,
>
> Thanks for the contribution.
>
> On Tue, 30 Sep 2025, Chad Jablonski wrote:
>> Real Rage 128 cards always request 64MB for their linear (framebuffer)
>> aperture. This is regardless of the amount of physical VRAM on the
>> board. This is required for 64MB alignment which is important given the
>> 26-bit addressing in src and dst registers.
>> 
>> This discrepancy caused X to segfault or display garbage depending on
>> the version tested. X expects this 64MB alignment.
>
> The documentation does not mention 64MB alignment. It says apertures must be 
> on a 32MB boundary and src and dst offsets are 128 bit aligned but maybe I 
> don't have the right documentation for these chips or don't get what it 
> means.
>
>> This was confirmed by testing against the behavior of real 16MB and 32MB
>> Rage 128 cards.
>> 
>> Real Radeon R100 cards request 128MB for linear aperture. This was
>> tested against a Radeon 7200 with 64MB of VRAM.
>
> Can you check what the CONFIG_APER_SIZE register contains on these cards? Do 
> all Rage 128 (and Pro) cards have 64MB and Radeon 7xxx/M6 have 128MB? The 
> documentation is again not clear on this because it lists default value of 
> 0x2000000 for CONFIG_APER_SIZE on Rage 128 Pro and nothing for Radeon but in 
> a figure it shows this should contain both VRAM and AGP areas that suggests 
> 64MB but it's possible that the documentation is wrong.
>
>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>> ---
>> hw/display/ati.c     | 26 ++++++++++++++++++++++++--
>> hw/display/ati_int.h |  1 +
>> 2 files changed, 25 insertions(+), 2 deletions(-)
>> 
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index f7c0006a87..db189e0767 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -30,9 +30,13 @@
>> #include "ui/console.h"
>> #include "hw/display/i2c-ddc.h"
>> #include "trace.h"
>> +#include "qemu/units.h"
>> 
>> #define ATI_DEBUG_HW_CURSOR 0
>> 
>> +#define ATI_RAGE128_LINEAR_APERTURE_SIZE (64 * MiB)
>> +#define ATI_RADEON_LINEAR_APERTURE_SIZE (128 * MiB)

Also maybe call it ATI_R100_APER_SIZE instead of RADEON as later Radeons 
probably increased this.

Regards,
BALATON Zoltan

