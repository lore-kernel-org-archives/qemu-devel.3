Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190A8D5B87A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 00:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVJBa-0002t9-NF; Mon, 15 Dec 2025 19:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1vVJBZ-0002q5-2m
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:45:05 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1vVJBV-000563-S6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:45:04 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 2474724933;
 Tue, 16 Dec 2025 01:44:57 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id swdv44s000ae; Tue, 16 Dec 2025 01:44:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1765845895;
 bh=5c4YHfLcxsaEe4MN/NZTYMb08nxaQAtULrpjWw2jpvU=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=T+q3uxxmL3AQ/L3VWN56pQFZrm/4HAZ0ySMomnUQ5oIoTbPVKMBE7ycJzrAkFSdn+
 nnpRMc8sp9p/FcNwQv6UG4tlC5o0ER4OX7L8tPsyn1wIAiOVoIEcpRb1uHT4lILpBb
 SwAx2rtqntMU3xZBe2LSVoZphdiPrdBrp1fAPWF2TkWIPhUm3HvSst9Z7CQwFhlonc
 N3D4waeGPTsHkt56tYTNeGgz/4WeNoNdBZMeZxSNmyqpkdSR5PsWEa5Rhg70BtypvS
 SD8P77/XpPfutlRY/0Umvaqk3nicGCnvnloVYNpf8o4nLm14KcBCZ11TzUclR1mJ46
 wYU4xn/f8greQ==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 5DC6A247FA;
 Tue, 16 Dec 2025 01:44:55 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH v1 0/6] hw/arm/sabrelite: Add FlexCAN support
Date: Tue, 16 Dec 2025 01:44:54 +0100
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
In-Reply-To: <cover.1765826753.git.matyas.bobek@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202512160144.54648.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.699,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Dear Matyas Bobek and Bernhard Beschow,

On Monday 15 of December 2025 21:03:09 Maty=C3=A1=C5=A1 Bobek wrote:
> This series adds emulation of the FlexCAN CAN controller, version 2,
> found in NXP i.MX6 series SoCs. The controller is integrated into
> fsl-imx6 and the Sabrelite ARM board.

=46irst, thanks a lot to Matyas Bobek for finding the courage
and sending the FlexCAN series, finally, after keeping it updated
log time on his flexcan-series-XXX branches at his personal
QEMU development repository

  https://gitlab.fel.cvut.cz/bobekmat/qemu-flexcan/-/branches

Bernhard Beschow, thanks for expressing interrest in the project.
Your intererst helped Matyas Bobek to collect courage to send.
I have found that you have invested a lot in the CAN on
your imx8mp-flexcan and can-cleanup branches, thanks again

  https://github.com/shentok/qemu/branches

It is shame that long delay in sending of patches has
lead to some divergence of the effort.

I have gone through your changes and would be happy if the
effort can be joined and integrated into mainline.

I would prefer to help Matyas Bobek's series to be updated
in state that it passes review and then the FlexCAN
can be moved forward by you and others.

In long term, the extension to support FlexCAN3 would
be very usesfull. But that that is work for other thesis,
GSoC and or company funded project or developers.
I would be happy to provide my knowledge as the time
allows or look for students, etc.

As for the series and your (Bernhard Beschow) changes:

I have seen that you suggest some reordering of some
functions in the hw/net/can/flexcan.c file. If you think
that it is the better, more readable order for QEMU developers,
I would suggest and have plea to Matyas Bobek to proceed
with reorder. Same with tracepoints and debug prints
which could be updated into state that your or others
follow-up patches would not cause massive code movement
which complicates tracking and reading of the changes.

On the other hand, I have some arguments against unification
of memory FlexCAN access function and inlining register accesses
into them. We have already discused with Matyas Bobek that
for FlexCAN3 and other future changes it would worth to
separate registers from memory part etc. So I would kept
this separation. Making as much as possible of the core
opaque for its external use is right from my view point
on the other hand.

As for the CAN core changes, again there are some which
I see as good moves, some cleanup of long term unused original
structures which have been planned for another integration
into QEMU before simplification to pass review etc. On the other
hand, I would keep client state without const and with destructors
etc. Again, actual code is somehow usable in its actual form,
but from the long term perspective, I see the need for
back-pressure propagation, emulation of the highest priority
message (the lowest ID) exchange the first, etc. and I have some
plans for that. I do not think that CAN emulation is and will
be some real performance bottleneck in QEMU use for embedded
systems development so I would like to keep there space
for future more precise emulation.

Same with reset on the chip core level, I think that its
redundant call does not cause any performance problems,
but I would be happy if the controller codes are reusable
for wide scenarios. I have written and used LinCAN with
such controllers at time of ISA bus on PC. I would be happy if
we have mechanism how to map them on SoCs with FPGAs.
Unfortunately this valid and very usesfull feature

(
for example for our RTEMS effort on Zynq
  https://docs.rtems.org/docs/main/bsp-howto/can.html
and ideally even on PolarFire (as time allows) where even NuttX
can be tested and CI run
  https://github.com/apache/nuttx/tree/master/drivers/can
)

hit concrete wall in May, without any suggestion how to
make that needed use of QEMU for CI acceptable. =20

But our SJA1000 code is already used by Espressif in their
QEMU fork
  https://github.com/espressif/qemu/tree/esp-develop/hw/net/can
so there is more proven use out of PCI based cards. CTU CAN FD
is used mostly on FPGAs but here are MCUs with it so again,
even if the usability of mainline QEMU for FPGA development
would stay blocked, there are standard, hopefully non problematic,
regular machine code initiated uses of the CAN controllers
which are part of QEMU.

So I would be happy if we can thought about that wider use
to check that it would not be more problematic in future
if some code is optimized.

On the other hand, it is right that even in esp32_twai.c
case, the integration is based on RESETTABLE_CLASS
and esp32_twai_reset() calls can_sja_hardware_reset()
explicitly. So can_sja_hardware_reset() during can_sja_init()
is not strictly necessary.

Back to sabrelite FlexCAN support series.
In general I agree with the patch series and I have
consulted and reviewed it multiple times.
So it can be considered to be approved by me
that it is functionally OK as well as it respects
copyright requirements etc. I add my

Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>

As for individual formatting and may be some debug prints,
I would allow it to go in in its actual form and then reduce
these latter that we have state with more, may it be even
abundant, debug in mainline recorded. But I expect that
there could be more request for style and details from
more experienced QEMU developers.

There is one unresolved patch check report about
DEVICE_NATIVE_ENDIAN

+static const struct MemoryRegionOps flexcan_ops =3D {
+    .read =3D flexcan_mem_read,
+    .write =3D flexcan_mem_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 4,
+        .unaligned =3D true,
+        .accepts =3D flexcan_mem_accepts
+    },
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false
+    },
+};

But I do not know what I can suggest there. The device is
infernally accessed by 32-bits words and should be
mapped in native format because same core is used
on little-endian and may it be even bi-endian ARMs[*1]
and for sure on big-endian PowerPCs. We believe that
native endianness with host is the best option in this
case. Extending .valid.max_access_size to 8 is right
and probably require for 64-bit targets as I understand
from your patches.

[*1] as I have used bi-endian ARMs they mapped peripherals
often native way on 32-bit entities. So again, fixed
DEVICE_BIG_ENDIAN or DEVICE_LITTLE_ENDIAN is incorrect
in such case.

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

