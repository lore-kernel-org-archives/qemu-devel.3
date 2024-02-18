Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E0C48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 16:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbjmS-00034Y-9u; Sun, 18 Feb 2024 11:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rbjmQ-00034B-GD
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 11:12:38 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rbjmN-0005dP-Kp
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 11:12:38 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 780184E6012;
 Sun, 18 Feb 2024 17:12:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ru_ph4c1UrVb; Sun, 18 Feb 2024 17:12:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 333D04E6005; Sun, 18 Feb 2024 17:12:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3144A7456B4;
 Sun, 18 Feb 2024 17:12:30 +0100 (CET)
Date: Sun, 18 Feb 2024 17:12:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH 0/5] Implement port 92 in south bridges
In-Reply-To: <20240218131701.91132-1-shentey@gmail.com>
Message-ID: <35e05c51-6a06-1830-972b-42332e7b7b56@eik.bme.hu>
References: <20240218131701.91132-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Sun, 18 Feb 2024, Bernhard Beschow wrote:
> This series attempts to make QEMU's south bridge families PIIX, ICH9, and VIA
> 82xx more self-contained by integrating IO port 92 like the originals do.
>
> In QEMU, the IO port is currently instantiated as a dedicated device in common
> PC code. While this works and even results in less code, it seems cleaner to
> model the behavior of the real devices. For example, software running on the
> Malta machine, which uses PIIX4, needs to take port 92 into account, even if it
> doesn't use it (does it?). Moreover, the FDC37M81x used in the original Malta
> machine provides a port 92 too, which can be activated. If QEMU implemented the
> FDC37M81x more closely, one could check if Yamon (or any alternative boot
> loader) deals correctly with these ports.

Maybe that's unlikely as this register is for controlling A20 line of 
Intel CPUs so probably there's no use for it in a MIPS or PPC board but 
I'm not sure if it may be used for something else.

> Moving port 92 into the south bridges might also help with configuration-driven
> machine creation. In such a scenario it is probably desirable if machine code
> had less of its own idea of which devices it creates.

The direction is probably good as these chips have a pin for A20 control 
and handle the register themselves but I'm not sure this series is the 
right way. One immediate problem is that TYPE_PORT92 has state which is in 
the migration stream so moving it elsewhere would break migration which 
would need to be handled. Does this series handle that? I'm not sure it's 
worth the effort though if it results in more comlex code. If the 
migration issue is handled, then I think we should get rid of TYPE_PORT92 
completely and just add the one reg and qemu_irq modeling the output pin 
as qemu_gpio to the south bridge implementations directly, not embedding a 
separate object for it as these south bridges may already have some io 
region for ports and state where the reg can be stored so it could be 
added there instead of just moving the TYPE_PORT92 there. But with the 
migration issue it's probably easier to just leave it as it is now. Even 
if this would model the real chip better, it would result in more code and 
complexity in QEMU so not sure it's a good idea because of that.

> Moving port 92 from
> machine code into a potentially user-creaeable device (where it is part of per
> datasheet) seems like a good direction. Of course, machine code still wires up
> port 92 and I don't have a good idea on how to make this user-configurable.
> Such insights might provide some input for discussions around
> configuration-driven machine creation.

That's a generic problem for dynamic or declarative machine creation to 
solve. Likely the machine description will also need to describe the 
connections between devices, not just what devices to instantiate. So 
that's not specific to port92. As we're not there yet it's also not urgent 
to touch this port92 stuff.

Maybe I overestimate the migration issue as I'm not familiar with that so 
if others think it's not an issue then I'm not against this series as it 
would bring the model closer to the actual hardware but then go all the 
way and get rid of TYPE_PORT92 and just implement it in the south bridges. 
But due to how it's currently done and how that's now baked in because of 
backward compatibility requrement for migration, I'm not sure it would 
really simplify the code, so we may need to live with what we have now. 
But let me know if I'm wrong and missed something.

Regards,
BALATON Zoltan

> This series is structured as follows: Patch 1 moves TYPE_PORT92 into the isa
> directory to make it reusable by other architectures. It also adds a
> configuration switch. Patch 2 integrates TYPE_PORT92 into the PC south bridges
> and adapts PC code accordingly. While at it, patch 3 cleans up wiring of the
> A20 line with the keyboard controller. Patch 4 simply adds TYPE_PORT92 to the
> VIA south bridges which is also needed when using the VIA south bridges in the
> pc machine.
>
> Testing done:
> * `qemu-system-x86_64 -M {q35,pc},i8042={true,false} ...`
>  -> `info mtree` confirms port92 to be present iff i8042=true
> * `make check`
> * `make check-avocado`
> * Start amigaone and pegasos2 machines as described in
>    https://patchew.org/QEMU/20240216001019.69A524E601F@zero.eik.bme.hu/
>  -> no regressions compared to master
>
> Best regards,
> Bernhard
>
> Bernhard Beschow (5):
>  hw/isa/meson.build: Sort alphabetically
>  hw/i386/port92: Allow for TYPE_PORT92 to be embedded in devices
>  hw/isa: Embed TYPE_PORT92 in south bridges used in PC machines
>  hw/i386/pc: Inline i8042_setup_a20_line() and remove it
>  hw/isa/vt82c686: Embed TYPE_PORT92
>
> include/hw/i386/pc.h          |  7 +------
> include/hw/input/i8042.h      |  1 -
> include/hw/isa/port92.h       | 30 ++++++++++++++++++++++++++++++
> include/hw/southbridge/ich9.h |  4 ++++
> include/hw/southbridge/piix.h |  3 +++
> hw/i386/pc.c                  | 21 ++++++++++++++-------
> hw/i386/pc_piix.c             |  9 +++++++--
> hw/i386/pc_q35.c              |  8 +++++---
> hw/input/pckbd.c              |  5 -----
> hw/isa/lpc_ich9.c             |  9 +++++++++
> hw/isa/piix.c                 |  9 +++++++++
> hw/{i386 => isa}/port92.c     | 14 +-------------
> hw/isa/vt82c686.c             |  7 +++++++
> hw/i386/Kconfig               |  1 +
> hw/i386/meson.build           |  3 +--
> hw/i386/trace-events          |  4 ----
> hw/isa/Kconfig                |  6 ++++++
> hw/isa/meson.build            |  3 ++-
> hw/isa/trace-events           |  4 ++++
> 19 files changed, 104 insertions(+), 44 deletions(-)
> create mode 100644 include/hw/isa/port92.h
> rename hw/{i386 => isa}/port92.c (91%)
>
> --
> 2.43.2
>
>
>

