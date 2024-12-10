Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39973E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL39y-0006ST-TR; Tue, 10 Dec 2024 11:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tL39u-0006QO-B5
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:32:26 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tL39r-0000kJ-J2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:32:26 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id B398247D27;
 Tue, 10 Dec 2024 17:32:17 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id FvlgVPhNnQuD; Tue, 10 Dec 2024 17:32:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1733848335;
 bh=CUUf/pgxCxR/P5WTixYT03ckS20UsQ2du+3dDPRL63w=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=sGT4woNK/XngQyRrFFq/p7hn0heM8/Kn71c1bd+6LFmlosR9dM1VLibZeBKc7kTRs
 BTk38HQoqF1kJnKKtG0WeR/010TWsR3gWFK+PIw/IYw/9AUM99b9cY/EESCqbWql5g
 Aptw1x2pkVj6MCVzQE3WBdDhPCj0cYLo63MaYSZXOq2smhyhj00jg71cqQhh+xu/GT
 7IziePdsY/SDlEbCLHI87JnKDu1XjantqhMMDZnm8OXO+3TXqumOIQ/nx2LBMZd7b2
 5ggz7FokBWYC9C3OGndnwi6ul4oLy6qw+6OkvBTSQhbihdUKKxjk3y67VRdkmoMdQX
 ro3kizfEP/XJw==
Received: from [10.0.3.185] (unknown [80.188.199.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id D3287479EC;
 Tue, 10 Dec 2024 17:32:14 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC/WIP 0/3] WIP CTU CAN FD IP core mapping to the platform bus
Date: Tue, 10 Dec 2024 17:32:54 +0100
User-Agent: KMail/1.9.10
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
 <CAFEAcA9FcCr1Zz+N+QkZUC5q0o+02GRje6YqRQy5d6v55D0CgA@mail.gmail.com>
In-Reply-To: <CAFEAcA9FcCr1Zz+N+QkZUC5q0o+02GRje6YqRQy5d6v55D0CgA@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202412101732.54857.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.61,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Peter,

On Tuesday 10 of December 2024 11:08:53 Peter Maydell wrote:
> On Mon, 9 Dec 2024 at 23:33, Pavel Pisa <pisa@fel.cvut.cz> wrote:
> > our CTU CAN FD IP core is used on many FPGA platforms
> > and has been even tapeout on some other university
> > and even prototypes of the massive production chips
> > (support for that organized by our former student
> > in his company).
> >
> > But actual QEMU emulation targets only PCI/PCIe mapping in
> >
> >   hw/net/can/ctucan_pci.c
> >
> > of the core in
> >
> >   hw/net/can/ctucan_core.c
> >
> > I would like to add support to map the core at fixed position for
> > SoCs and command line controlled location for FPGA targets.
>
> Command line instantiation of devices at command line
> controlled addresses and with command line connection
> of IRQ lines is basically something we do not
> currently support. There is some prototype/design work
> going on about generic "create a machine from
> the command line" handling, which would inevitably
> involve allowing the user to specify addresses and IRQ
> lines. But I don't really want to see ad-hoc device-specific
> additions of small parts of similar functionality.
>
> If there's a SoC that QEMU models that has this CAN
> controller, then it's the SoC model (written in C)
> that defines where it is mapped in memory and what
> IRQ lines it is wired up to.

There should be such SoC in some time even in public.
I understand that in such case the mapping should
be part of its support.

But main area of the CTU CAN FD IP core use
are FPGAs for now, Xilinx Zynq and above, Intel/Altera
SoC+FPGAs, actual next target to test is Microchip
PolarFire on BeagleV-Fire which allows to develop
and test driver for Linux, NuttX and RTEMS on the single
chip. And it would be great if there is option to
run that on CI and have (still simplified - no bitrate
miscmatch check etc) model for SW development with QEMU.

And CTU CAN FD does not belong to the core Zynq or PolarFire
support in such cases. So even this actual solution is usable
in such cases. But as I have expected, it is not so welcomed
in mainline... which is why I attempt to find what can be done.

Do you consider the the proposed trick (target object specified by
"irqctrl" parameter on commad line and then resolved by
object_resolve_path_at()) as unacceptable for mainline?

Another problem is if the qemu_irq can be copied in ctucan_mm_realize.
I have tried even another solution where chip core kept pointer
to qemu_irq in the bus integration wrapper (PCI/PCIe and platform).

But even for mainlined PCI/PCIe CTU CAN FD support I would like
to update support to provide real "or" operation between IRQs
outputs from individual controllers to PCI/PCIe interrupt link.
So in this case, I would be happy to hear if I can reuse
qemu_irq and some routing or if I should define own mechanism
to activate callback provided by the bus integration wrapper
from the core emulation code. But may it be some pin logic
already implemented in QEMU can be used there.

Best wishes,

                Pavel

PS: does somebody have some experience, information for
use of "16c3:abcd" DWC_usb3 / PCIe bridge on i.MX6 Sabre
Litte, I have sent plea for help two months ago without
any respone and it would help our another CAN controller
development project, iMX6 FlexCAN support.
 
--
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

