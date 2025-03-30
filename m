Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1862FC28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 15:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyu9m-0003FC-US; Sun, 30 Mar 2025 11:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tyu9Z-0003D4-9V
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 11:00:49 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tyu9T-0003Xa-RL
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 11:00:49 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id A4CE1161D9;
 Sun, 30 Mar 2025 17:00:38 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 476m_Sm8IbtQ; Sun, 30 Mar 2025 17:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1743346837;
 bh=aldgN7uGu0nwnnC/25qjNcSpsGX3Os2RWvYzn7la0no=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=NccYPiXYn13iqYejtCZ6dcV1U0y+u6+F1W8UW1YGS858a0Ddb0PUJJzNOqBFIj1Qk
 T3/EuVimb99A+Yq+rOIacvoIZIoxb/xOD5gTWfmPm07YjxaJR4Bpe2xIJIBfKzP459
 LOk7OiAAJWtfrQb63QwY0112GT07rQvkybnXEXtLI1AOoavDlgq/6nbAB/EuIBSKBC
 RwvYFeeq/nWtQGdlXB/JkMBljFA7vCH3vVQ9ASsslVA6dr0tHIz8lpIPjUYWrML4ch
 n7n5aZeXkhEdSdC4waKMd5gttauQYn4ojhXg/UveRCAKebwA2fE8zMeS9rGQ+B0xen
 PvzoRNKMN+GPw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 4F85316383;
 Sun, 30 Mar 2025 17:00:35 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Bernhard Beschow <shentey@gmail.com>, Matyas Bobek <bobekmat@fel.cvut.cz>
Subject: [WIP] QEMU FlexCAN controller support on iMX6,
 interrest in iMX8 and PCIe Virtio on iMX6/8
Date: Sun, 30 Mar 2025 17:01:01 +0200
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>
References: <202410021706.01967.pisa@fel.cvut.cz>
 <E4AF9EE3-C829-4E26-A3F0-91F627CB1BE1@gmail.com>
In-Reply-To: <E4AF9EE3-C829-4E26-A3F0-91F627CB1BE1@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202503301701.01670.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

Hello Bernhard,

thanks for interrest in the FlexCAN emulation for QEMU.

On Sunday 30 of March 2025 12:05:45 Bernhard Beschow wrote:
> Am 2. Oktober 2024 15:06:01 UTC schrieb Pavel Pisa <pisa@fel.cvut.cz>:
> >Dear Nikita and other,
> >
> >my student Matyas Bobek has chosen to work
> >on QEMU CAN support in a frame of his study
> >final project.
> >
> >We have identified iMX6 FlexCAN as the next interesting
> >CAN controller for emulation.
>
> I'd be interested in emulating FlexCAN as well! Is there any repository for
> a sneak preview?

Yes, Matyas Bobek's repository with work in progress is there

  https://gitlab.fel.cvut.cz/bobekmat/qemu-flexcan

I have tested his branch in January and it worked with QEMU
iMX6 and Linux kernel driver. He is continuing the work and
we have met last week when he did rebase to something around
v10.0.0-rc1 version. I have tested with next config at that time
and I have retested int again now after update

~/repo/qemu/qemu-flexcan-build/qemu-system-arm \
      -m 1G -M sabrelite -smp 4 \
      -kernel kernel-imx6q-sabrelite \
      -dtb imx6q-sabrelite.dtb \
      -initrd ramdisk.cpio \
      -serial mon:stdio \
      -nographic \
      -object can-bus,id=canbus0-bus \
      -machine canbus0=canbus0-bus -machine canbus1=canbus0-bus \
      -object can-host-socketcan,if=can0,canbus=canbus0-bus,id=canbus0-socketcan \

There is lot of prints and debug etc... But basic functionality,
enough to allow Linux driver to work is in place. 

> >One of our industrial partners
> >is using iMX6 based system with CAN and iMX6 SabreLite
> >is supported by QEMU. iMX6 is often used in industry
> >still and FlexCAN has use even for iMX8 emulation
> >if it is added into QEMU in the future.
>
> As luck would have it, QEMU will support i.MX 8M Plus in the upcoming
> release:
> <https://lore.kernel.org/qemu-devel/20250225180510.1318207-32-peter.maydell
>@linaro.org/> I'm more than happy to integrate FlexCAN emulation!

Great. At this moment the thesis target has been only FlexCAN
for iMX6 (that is without FD) but we have discussed that
code should be designed with extension to more FlexCAN controller
in the mind. Please, discuss with colleague what he sees
as realistic at this time. He has to submit thesis text
in May... But I would be happy if project continues at CTU
or elsewhere. It would be fair to find at least some basic
funding if the student continues on the project over holidays.
I have received no money for all my QEMU work for years
nor I expect that I find funding for that at CTU or
Skoda Auto or others using our services. I can find some
small money from my reserve from other projects.
DO you have some option for funding on your side?

Or the option is GSOC, QEMU is on the list as I see.
I am already mentor at NuttX and take such role
for RTEMS probably as well, I have lot of other duties
but I can accept co-mentor, consultant role for QEMU
GSoC if there is interrest.

As for QEMU core CAN subsystem and CAN FD,
it is prepared and work well for CTU CAN FD
emulation and even AMD Versal which builds
on base of our work.. 

> >In the preparatory work, we want to setup
> >shared directory between host and guest
> >kernel using 9P FS on PCI virtio.
> >
> >The development environment is based on current
> >mainline QEMU and mainline Linux kernel sources.
> >
> >We use standard QEMU options
> >
> >  -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir
> >
> >and the 1af4:1009 is seen by monitor command "info pci"
> >but on the guest kernel side only "16c3:abcd" DWC_usb3 / PCIe bridge
> >is seen but none from the mapped devices, virtio (1af4:1009),
> >CTU CAN FD, Kvaser CAN.
>
> Should be fixed in master / QEMU 10.0 by
> <https://lore.kernel.org/qemu-devel/20250225180510.1318207-30-peter.maydell
>@linaro.org/>

When I try

QEMU with

-virtfs local,path=shareddir,security_model=none,mount_tag=shareddir

on iMX6 sabrelite now, I can see the device on PCI/PCIe

lspci
00:00.0 Class 0604: 16c3:abcd
01:00.0 Class 0002: 1af4:1049

I can see interrupts

cat /proc/interrupts

290:          0          0          0          0   PCI-MSI 524288 Edge      virtio0-config
291:          0          0          0          0   PCI-MSI 524289 Edge      virtio0-requests

but when I try

mount -t 9p -o trans=virtio shareddir /mnt/shareddir

it stucks and no interrupts seems to arrive

cat /proc/interrupts

290:          0          0          0          0   PCI-MSI 524288 Edge      virtio0-config
291:          0          0          0          0   PCI-MSI 524289 Edge      virtio0-requests

I have tried even CTU CAN FD PCIe emulation. I can see the device on the lspci,
the first send frame passes but then it stucks. Receive does not see any mesaage.
I expect that at least on sabrelite there is something missing. May it be in
kernel devicetree or on QEMU side in PCI/PCIe interrupts.

But that is not so critical at this moment.

By the way, I would like to discuss QEMU interrupts for generic
FPGA mapping of our CTU CAN FD IP core (in addition to PCIe)

  https://github.com/ppisa/qemu/blob/net-can-ctucanfd-platform/hw/net/can/ctucan_mm.c#L144

where I have looked for help in past.
It would be very usesfull for us to have memory-mapped CTU CAN FD IP core
emulation with commad line attaching to Zynq and PolarFire...

> >The imx6q-sabrelite DTS is used with standard device-tree
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ar
> >ch/arm/boot/dts/nxp/imx/imx6q-sabrelite.dts
> >
> >We hope that all required drivers are enabled
> >in the kernel. But it is possible that something
> >has been overlooked.
> >
> >Do you have some hint or some kernel
> >and QEMU working example for iMX6 PCIe
> >device mapping?
>
> When adding a PCI device via command line, add `bus=dw-pcie` as an
> additional option as a workaround for earlier QEMUs.


Best wishes,

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

