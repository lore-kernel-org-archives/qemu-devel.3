Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12D6C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXhgk-0003nu-96; Wed, 07 Feb 2024 08:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXhgd-0003mS-Dw
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:10:00 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXhgX-00026T-Oj
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:09:58 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 415144E609B;
 Wed,  7 Feb 2024 14:09:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4Bj3plOR_DI0; Wed,  7 Feb 2024 14:09:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4ECC94E601E; Wed,  7 Feb 2024 14:09:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4D0A57456B4;
 Wed,  7 Feb 2024 14:09:47 +0100 (CET)
Date: Wed, 7 Feb 2024 14:09:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, shentey@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v2 4/8] isa: fix ISA_SUPERIO dependencies
In-Reply-To: <20240207111411.115040-5-pbonzini@redhat.com>
Message-ID: <197003d2-7994-6560-f4f0-8997d17e1c41@eik.bme.hu>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 7 Feb 2024, Paolo Bonzini wrote:
> ISA_SUPERIO does not provide an ISA bus, so it should not select the symbol:
> instead it requires one.  Among its users, VT82C686 is the only one that
> is a PCI-ISA bridge and does not already select ISA_BUS.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/isa/Kconfig | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 7884179d08b..5df3c09cd51 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -15,7 +15,7 @@ config I82378
>
> config ISA_SUPERIO
>     bool
> -    select ISA_BUS
> +    depends on ISA_BUS
>     select PCKBD
>     select PARALLEL
>     select SERIAL_ISA
> @@ -47,6 +47,7 @@ config PIIX
>
> config VT82C686
>     bool
> +    select ISA_BUS
>     select ISA_SUPERIO
>     select ACPI
>     select ACPI_SMBUS
>

