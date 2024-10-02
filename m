Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FAACF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0vQ-0008Vl-20; Wed, 02 Oct 2024 11:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sw0vO-0008VM-DD
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:05:58 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sw0vK-0003GA-HI
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:05:58 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 13E453A408;
 Wed,  2 Oct 2024 17:05:49 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id HLa_EXDG2ejY; Wed,  2 Oct 2024 17:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1727881546;
 bh=+t4Ct48h3uXjz7yaHBzHssJlhzgCNmriDar/m7TGElM=;
 h=From:To:Subject:Date:From;
 b=b2tfi1nD8LODmqCx5GNGHH6DZ4jEx4cngtkbX+9kwjSnMBu2Bv0JwEfb03GFvvq4r
 tt/wMrgS20AmXaG9X58m50gd6fmpEpMP4Xo44NtdKkI+p2H9bHYvfyUhz7bZyGkH2y
 //fdnZpsbwrk62uvSUSjW7fjueGpNO6a7gC+WzsVRIkuWCJ8Z+rkHjfUzF4Cy5gsqW
 JnI43kYMrhQA/wfWdaq3d0eyN3H2EnloObpLvL5vFQxJVNjY1EnmBRoVNG25l1YeGh
 qAUH9dG8X45E51++7rqNXmukHSvwJXcZM+8hNemR0DZNkU9ZrBANEhEF+26XQtBcnu
 WzkhBNCHTRmsw==
Received: from [147.32.86.119] (unknown [147.32.86.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 8B4183A2D4;
 Wed,  2 Oct 2024 17:05:46 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>, qemu-devel@nongnu.org,
 Matyas Bobek <bobekmat@fel.cvut.cz>
Subject: Plea for advice with PCIe on QEMU for iMX6 and plan to add FlexCAN
 controller support
Date: Wed, 2 Oct 2024 17:06:01 +0200
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202410021706.01967.pisa@fel.cvut.cz>
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

Dear Nikita and other,

my student Matyas Bobek has chosen to work
on QEMU CAN support in a frame of his study
final project.

We have identified iMX6 FlexCAN as the next interesting
CAN controller for emulation. One of our industrial partners
is using iMX6 based system with CAN and iMX6 SabreLite
is supported by QEMU. iMX6 is often used in industry
still and FlexCAN has use even for iMX8 emulation
if it is added into QEMU in the future.

In the preparatory work, we want to setup
shared directory between host and guest
kernel using 9P FS on PCI virtio.

The development environment is based on current
mainline QEMU and mainline Linux kernel sources.

We use standard QEMU options

  -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir

and the 1af4:1009 is seen by monitor command "info pci"
but on the guest kernel side only "16c3:abcd" DWC_usb3 / PCIe bridge
is seen but none from the mapped devices, virtio (1af4:1009),
CTU CAN FD, Kvaser CAN.

The imx6q-sabrelite DTS is used with standard device-tree

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/nxp/imx/imx6q-sabrelite.dts

We hope that all required drivers are enabled
in the kernel. But it is possible that something
has been overlooked.

Do you have some hint or some kernel
and QEMU working example for iMX6 PCIe
device mapping?

Thanks in advance.

Best wishes,

                Pavel
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

