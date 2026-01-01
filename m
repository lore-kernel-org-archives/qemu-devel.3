Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A07FEED612
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 14:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbJXe-000367-0Z; Thu, 01 Jan 2026 09:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJXb-00035H-JD
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:20:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJXZ-0001ES-F5
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:20:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9E591596A03;
 Thu, 01 Jan 2026 15:20:34 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id NmBo6jXqRfou; Thu,  1 Jan 2026 15:20:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9AABC5969FF; Thu, 01 Jan 2026 15:20:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9972D5969FA;
 Thu, 01 Jan 2026 15:20:32 +0100 (CET)
Date: Thu, 1 Jan 2026 15:20:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/7] ati-vga: Implement PM4_BUFFER_CNTL register
In-Reply-To: <20260101035555.1300511-4-chad@jablonski.xyz>
Message-ID: <06149317-8f88-7424-ebe9-c226cee1f711@eik.bme.hu>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-4-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Wed, 31 Dec 2025, Chad Jablonski wrote:
> The PM4_BUFFER_CNTL register is used to set up the CCE FIFO. These are
> straightforward reads and writes. Future CCE patches make use of this
> state.

This register does not seem to be documented in Rage 128 Pro register 
reference and the ATI M6/RV100 seems to have different bits. Since the CCE 
is mostly used by Radeon drivers and there seem to be differences I wonder 
if it's worth implementing CCE for Rage 128 when it's not the same as the 
Radeon one and should we insted target Radeon CCE instead? I only know 
about the MacOS driver that uses CCE with Rage128 (maybe some Windows and 
more advanced Linux drivers exist) but all almost all Radeon drivers use 
CCE so that seems more important to me. What do you think? Did you 
consider the differences between Radeon CCE?

Regards,
BALATON Zoltan

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      | 11 +++++++++++
> hw/display/ati_cce.h  |  4 ++++
> hw/display/ati_regs.h | 12 ++++++++++++
> 3 files changed, 27 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index e291926470..a4bef92efd 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -535,6 +535,11 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>          */
>         s->cce.microcode.raddr = s->cce.microcode.addr;
>         break;
> +    case PM4_BUFFER_CNTL:
> +        val = ((s->cce.buffer_mode & 0xf) << 28) |
> +              (s->cce.no_update << 27) |
> +              (s->cce.buffer_size_l2qw & 0x7ffffff);
> +        break;
>     default:
>         break;
>     }
> @@ -979,6 +984,12 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
>         s->cce.microcode.addr += 1;
>         break;
>     }
> +    case PM4_BUFFER_CNTL: {
> +        s->cce.buffer_size_l2qw = data & 0x7ffffff;
> +        s->cce.no_update = (data >> 27) & 1;
> +        s->cce.buffer_mode = (data >> 28) & 0xf;
> +        break;
> +    }
>     default:
>         break;
>     }
> diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
> index f2ef1345de..25a2430c60 100644
> --- a/hw/display/ati_cce.h
> +++ b/hw/display/ati_cce.h
> @@ -21,6 +21,10 @@ typedef struct ATIPM4MicrocodeState {
>
> typedef struct ATICCEState {
>     ATIPM4MicrocodeState microcode;
> +    /* BufferCntl */
> +    uint32_t buffer_size_l2qw;
> +    bool no_update;
> +    uint8_t buffer_mode;
> } ATICCEState;
>
> #endif /* ATI_CCE_H */
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index d7127748ff..4d1ccc1434 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -378,7 +378,19 @@
> #define PC_BUSY                                 0x80000000
>
> #define BUS_MASTER_DIS                          0x00000040
> +
> +
> +/* PM4_BUFFER_CNTL buffer mode bit constants */
> #define PM4_BUFFER_CNTL_NONPM4                  0x00000000
> +#define PM4_BUFFER_CNTL_192PIO                  0x00000001
> +#define PM4_BUFFER_CNTL_192BM                   0x00000002
> +#define PM4_BUFFER_CNTL_128PIO_64INDBM          0x00000003
> +#define PM4_BUFFER_CNTL_128BM_64INDBM           0x00000004
> +#define PM4_BUFFER_CNTL_64PIO_128INDBM          0x00000005
> +#define PM4_BUFFER_CNTL_64BM_128INDBM           0x00000006
> +#define PM4_BUFFER_CNTL_64PIO_64VCBM_64INDBM    0x00000007
> +#define PM4_BUFFER_CNTL_64BM_64VCBM_64INDBM     0x00000008
> +#define PM4_BUFFER_CNTL_64PIO_64VCPIO_64INPIO   0x0000000f
>
> /* DP_DATATYPE bit constants */
> #define DST_8BPP                                0x00000002
>

