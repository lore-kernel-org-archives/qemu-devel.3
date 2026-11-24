Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE20606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVwcI-0006v7-GO; Tue, 24 Nov 2026 14:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xVwcF-0006uS-Td; Tue, 24 Nov 2026 14:55:48 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xVwcD-0002OZ-SX; Tue, 24 Nov 2026 14:55:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 93A9F60C6FC;
 Tue, 24 Nov 2026 20:55:42 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id zYI6LnLtzwr5; Tue, 24 Nov 2026 20:55:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 762D160C532; Tue, 24 Nov 2026 20:55:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7489813C290;
 Tue, 24 Nov 2026 20:55:40 +0100 (CET)
Date: Tue, 24 Nov 2026 20:55:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/ppc/amigaone: Invalidate TBs on NVRAM write
In-Reply-To: <20261124180138.69682-1-philmd@oss.qualcomm.com>
Message-ID: <2705feeb-a484-4e20-b60d-2f6f0e4177fd@eik.bme.hu>
References: <20261124180138.69682-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-172697045-1795550140=:91208"
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-172697045-1795550140=:91208
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 24 Nov 2026, Philippe Mathieu-Daudé wrote:
> The NVRAM is a ROM device, mapped in romd mode, so the guest can
> execute from it. Its write callback stores the byte with a direct
> store, which TCG does not see: translated blocks of the byte survive.

This is an NVRAM where no code should be stored so inlike with a ROM this 
can never happen in practice

> Flush the written byte, as the other models (TYPE_PFLASH_CFI01/2
> and TYPE_NRF51_NVM) do.

but for consistency I guess it's OK even if not needed.

Acked-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> Cc: qemu-stable@nongnu.org
> Fixes: addff513a10e ("ppc/amigaone: Implement NVRAM emulation")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> hw/ppc/amigaone.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 2e94e80b5692..9b60782172ff 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -109,6 +109,7 @@ static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
>     uint8_t *p = memory_region_get_ram_ptr(&s->mr);
>
>     p[addr] = val;
> +    memory_region_flush_rom_device(&s->mr, addr, 1);
>     if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
>         error_report("%s: could not write %s", __func__, blk_name(s->blk));
>     }
>
--3866299591-172697045-1795550140=:91208--

