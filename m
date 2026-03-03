Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A609AEDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxYfI-00080w-N7; Tue, 03 Mar 2026 17:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxYfE-000803-P5; Tue, 03 Mar 2026 17:56:28 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxYfC-0007ah-4z; Tue, 03 Mar 2026 17:56:27 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6FDC4596A10;
 Tue, 03 Mar 2026 23:56:22 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lbblxVITQwYH; Tue,  3 Mar 2026 23:56:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6030A596A18; Tue, 03 Mar 2026 23:56:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5E013596A0A;
 Tue, 03 Mar 2026 23:56:20 +0100 (CET)
Date: Tue, 3 Mar 2026 23:56:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 11/13] hw/char/serial: Keep MemoryRegionOps private
In-Reply-To: <20260303222143.142741-12-shentey@gmail.com>
Message-ID: <8a363801-914d-7870-3b1b-a4c9182ba4cc@eik.bme.hu>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-12-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 3 Mar 2026, Bernhard Beschow wrote:
> Rather than requiring users of TYPE_SERIAL to initialize the MMIO region
> themselves, make it generic enough to be configured via properties. This
> makes TYPE_SERIAL more self-contained and prepares it for being turned
> into a SysBusDevice.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> include/hw/char/serial-mm.h |  3 --
> include/hw/char/serial.h    |  4 +-
> hw/char/diva-gsp.c          |  5 ---
> hw/char/serial-isa.c        |  1 -
> hw/char/serial-mm.c         | 51 -------------------------
> hw/char/serial-pci-multi.c  |  5 ---
> hw/char/serial-pci.c        |  1 -
> hw/char/serial.c            | 76 ++++++++++++++++++++++++++++++-------
> 8 files changed, 66 insertions(+), 80 deletions(-)
>
> diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
> index 0076bdc061..4c18e2a609 100644
> --- a/include/hw/char/serial-mm.h
> +++ b/include/hw/char/serial-mm.h
> @@ -39,9 +39,6 @@ struct SerialMM {
>     SysBusDevice parent;
>
>     SerialState serial;
> -
> -    uint8_t regshift;
> -    uint8_t endianness;
> };

This effectively makes TYPE_SERIAL the same as TYPE_SERIAL_MM so you could 
just merge the two and have everything embed a SERIAL_MM device. But the 
idea here is to make TYPE_SERIAL a superclass of all serial devices and 
SERIAL_MM is the memory mapped version. Memory mapped devices are usually 
SysBusDevices but others are not so this seems to be trying to model 
things in the wrong way. Maybe you could just add accessor functions to 
TYPE_SERIAL to get the memory regions and use that from subclasses to 
avoid poking in the state struct and not try to reuse SysBusDevice for 
this.

Regards,
BALATON Zoltan

