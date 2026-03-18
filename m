Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D110775F8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ueo-0003fx-9N; Wed, 18 Mar 2026 13:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w2ueh-0003Wv-7v
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:26:04 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w2ued-00035Y-Ms
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=/olRhX5pFoDu+tYbzhI4ASoNp7OIFwcPkPog163aEKs=; b=cCOHoKQIzIFoG9x
 7aIoRwRwqKzsfFXRtARWWqGXsD53+Y3zFNMkhrjXbaNcoeiyCH4D1S2H6d+p8SEmeLrhP+g46V/mj
 hAw96Mi01O/z9VCMtJENARqfbIoMTVHvKbUVbtyx/5fadWTk/uVlcKCeOJ2V38CouwBPOBi4TI+PP
 Ws=;
Date: Wed, 18 Mar 2026 18:29:34 +0100
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/6] target/hppa: Always map 64-bit firmware at
 0xfffffff0f0000000
Message-ID: <abrgUScX-TuaJoqp@hive.localdomain>
References: <20260317195149.8386-1-deller@kernel.org>
 <20260317195149.8386-4-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317195149.8386-4-deller@kernel.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/03/26, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> I checked on a physical A500, C3700 and C8000 machine and all load their
> 64-bit PDC (Firmware) at 0xfffffff0f0000000, independed if the CPU uses
> 40 or 44 physical address bits.
> For qemu we will do the same and load the 64-bit SeaBIOS-hppa at the
> same address for our emulated machines.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  target/hppa/mem_helper.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index a4b382069d..ffbad8acfd 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -27,6 +27,7 @@
>  #include "exec/target_page.h"
>  #include "exec/helper-proto.h"
>  #include "hw/core/cpu.h"
> +#include "hw/hppa/hppa_hardware.h"
>  #include "trace.h"
>  
>  hwaddr hppa_abs_to_phys_pa1x(uint8_t phys_addr_bits, vaddr addr)
> @@ -66,12 +67,13 @@ hwaddr hppa_abs_to_phys_pa2_w0(uint8_t phys_addr_bits, vaddr addr)
>          /*
>           * PDC address space:
>           * Figures H-10 and H-11 of the parisc2.0 spec do not specify
> -         * where to map into the 64-bit PDC address space.
> -         * We map with an offset which equals the 32-bit address, which
> -         * is what can be seen on physical machines too.
> +         * where to map into the 64-bit PDC address space, but verification
> +         * on physical A500, C3700 and C8000 machines show that PDC is always
> +         * mapped at 0xfffffff0f0000000, independed if the CPU has 40 or 44
> +         * physical bits.
>           */
>          addr = (uint32_t)addr;
> -        addr |= -1ull << (phys_addr_bits - 4);
> +        addr |= ((uint64_t) FIRMWARE_HIGH) << 32;
>      }
>      return addr;
>  }
> -- 
> 2.53.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

