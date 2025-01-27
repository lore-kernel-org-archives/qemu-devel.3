Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06158C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcP5o-0003AC-Nc; Mon, 27 Jan 2025 08:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tcP5L-00035Y-8J; Mon, 27 Jan 2025 08:23:34 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tcP5I-0003In-67; Mon, 27 Jan 2025 08:23:26 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 130854E6004;
 Mon, 27 Jan 2025 14:23:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yknCaIevVlOO; Mon, 27 Jan 2025 14:23:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 136854E6001; Mon, 27 Jan 2025 14:23:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1172874577C;
 Mon, 27 Jan 2025 14:23:19 +0100 (CET)
Date: Mon, 27 Jan 2025 14:23:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 6/6] hw/loader: Pass ELFDATA endian order argument to
 load_elf()
In-Reply-To: <20250127113824.50177-7-philmd@linaro.org>
Message-ID: <cf92f7c0-9fc5-0b55-d14e-b4d9fd64d553@eik.bme.hu>
References: <20250127113824.50177-1-philmd@linaro.org>
 <20250127113824.50177-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-678307236-1737984199=:99138"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-678307236-1737984199=:99138
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 27 Jan 2025, Philippe Mathieu-Daudé wrote:
> Rather than passing a boolean 'is_big_endian' argument,
> directly pass the ELFDATA, which can be unspecified using
> the ELFDATANONE value.
>
> Update the call sites:
>  0                 -> ELFDATA2LSB
>  1                 -> ELFDATA2MSB
>  TARGET_BIG_ENDIAN -> TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> Sorry, couldn't find good ways to split this patch...
> ---
> include/hw/loader.h            | 2 +-
> hw/core/loader.c               | 5 ++---
> hw/alpha/dp264.c               | 4 ++--
> hw/hppa/machine.c              | 4 ++--
> hw/i386/multiboot.c            | 4 ++--
> hw/i386/x86-common.c           | 4 ++--
> hw/loongarch/boot.c            | 2 +-
> hw/m68k/an5206.c               | 2 +-
> hw/m68k/mcf5208.c              | 2 +-
> hw/m68k/q800.c                 | 2 +-
> hw/m68k/virt.c                 | 2 +-
> hw/microblaze/boot.c           | 6 ++++--
> hw/mips/boston.c               | 2 +-
> hw/mips/fuloong2e.c            | 2 +-
> hw/mips/loongson3_virt.c       | 2 +-
> hw/mips/malta.c                | 5 +++--
> hw/mips/mipssim.c              | 3 ++-
> hw/openrisc/boot.c             | 2 +-
> hw/pci-host/raven.c            | 4 ++--
> hw/ppc/e500.c                  | 2 +-
> hw/ppc/mac_newworld.c          | 5 +++--
> hw/ppc/mac_oldworld.c          | 4 ++--
> hw/ppc/pegasos2.c              | 8 ++++----
> hw/ppc/ppc405_boards.c         | 2 +-
> hw/ppc/ppc440_bamboo.c         | 3 ++-
> hw/ppc/sam460ex.c              | 2 +-
> hw/ppc/spapr.c                 | 8 ++++----
> hw/ppc/virtex_ml507.c          | 4 ++--
> hw/s390x/ipl.c                 | 6 +++---
> hw/sparc/leon3.c               | 2 +-
> hw/sparc/sun4m.c               | 5 +++--
> hw/sparc64/sun4u.c             | 6 +++---
> hw/tricore/triboard.c          | 2 +-
> hw/tricore/tricore_testboard.c | 2 +-
> hw/xtensa/sim.c                | 3 ++-
> hw/xtensa/xtfpga.c             | 3 ++-
> 36 files changed, 67 insertions(+), 59 deletions(-)
--3866299591-678307236-1737984199=:99138--

