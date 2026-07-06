Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B8BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wghq5-0000m1-Jh; Mon, 06 Jul 2026 07:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1wghq2-0000k4-Kz; Mon, 06 Jul 2026 07:50:14 -0400
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1wghpz-0004VP-Ax; Mon, 06 Jul 2026 07:50:14 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 9313C1662B;
 Mon, 06 Jul 2026 13:50:02 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id RBYDT1sX9--Q; Mon,  6 Jul 2026 13:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1783338256;
 bh=CZwBV97eGUbAzqXmCYBT7gftrTK0/zgKDJ2ZFaLmZS4=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=s7CsxiVBWhFZtlGM0bHUkM4vxlzip36NgR2LgM/Ze4Sc6d1T9nZBDwdasC635Y9Og
 WzzFkbDRLAPcuZvVigJM2TQNHHsMGdX/J1ykGTOEDM3lrtsk2zcSHAAuRyuzwrQf7L
 DIJP6r02cUzf61XRseyBrh8u9WaZYgbbxUNxIkQjRi7baZFbynlHIJrgk8cddwFPsJ
 I5sv+FliPyFqRGm1GrD3Yu0NTTtFbRnHooZ5aCuV7HswV4ZFgKf9uRiYor5qCkOihG
 J3/d9oMlT0JxMGzXcoVmnHmyvdCZ47QlQJh7T6O3v0ZtzfzxNbL5rR+GpvUVe9jr5h
 mOEL8Wxv1n3zQ==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 7560016462;
 Mon, 06 Jul 2026 13:44:15 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH v2 0/5] hw/arm/fsl-imx8mp: Add inital FlexCAN support
Date: Mon, 6 Jul 2026 13:44:14 +0200
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Philippe =?utf-8?q?Mathieu-Daud=C3=A9?=" <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Jean-Christophe Dubois" <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20260702184038.178196-1-shentey@gmail.com>
In-Reply-To: <20260702184038.178196-1-shentey@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202607061344.14505.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=2001:718:2:1516::210:153;
 envelope-from=pisa@fel.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.97, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Dear Bernhard,

On Thursday 02 of July 2026 20:40:33 Bernhard Beschow wrote:
> Now that FlexCAN emulation has landed in master, let's add it to imx8mp-evk
> as well. While the real i.MX8M Plus supports CAN FD which isn't emulated
> yet, the non-FD mode works well under Linux: It is possible to use `cangen`
> and `candump` either way on the host and on the guest, as described in
> docs/system/devices/can.rst.
>
> This series consists of five patches where the first four are preparations.
> The last patch integrates FlexCAN into the i.MX8M Plus SoC and EVK board.
> The first preparation addresses the review comment from [1], and could be
> applied independently.
>
> It would be nice if this series could make it into 11.1.
>
> Testing done:
> * Start imx8mp-evk and run `cangen can0` there. Observe on the host that
> `candump vcan0` prints the traffic.
> * `make check`
>
> v2:
> Thanks for the very helpful and super quick review, Phil! Here we go:
> * Add patch "hw/net/can/flexcan: Wire clock control module via link
> property" * Have separate MemoryRegionOps for 32 and 64 bit
>
> [1]
> https://lore.kernel.org/qemu-devel/77d5891c-de12-467e-8746-02fe43121e3e@oss
>.qualcomm.com/ ---
> base-commit: a59157f98f0b69b0bbdb26bc15fbc4d6c8060799
>
> Bernhard Beschow (5):
>   hw/net/can/flexcan: Wire clock control module via link property
>   hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
>   hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
>   hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
>   hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk
>
>  docs/system/arm/imx8m.rst   |  1 +
>  include/hw/arm/fsl-imx8mp.h |  8 ++++
>  include/hw/net/flexcan.h    |  4 +-
>  hw/arm/fsl-imx6.c           |  5 ++-
>  hw/arm/fsl-imx8mp.c         | 38 ++++++++++++++++
>  hw/arm/imx8mp-evk.c         | 64 ++++++++++++++++++++++-----
>  hw/misc/imx8mp_ccm.c        |  3 ++
>  hw/net/can/flexcan.c        | 88 ++++++++++++++++++++++++++++++-------
>  hw/arm/Kconfig              |  1 +
>  9 files changed, 182 insertions(+), 30 deletions(-)

Thanks for the work. I have tested the series on the top
of your imx8mp-flexcan branch, commit

  3b7289419cac5b712faeadf6b4a6203579d08f76

with our test setup for iMX6

  qemu-system-arm -m 1G -M sabrelite -smp 4 ...

and it worked as intended. I have looked at all patches
from your series and I do not see anything problematic.

You can add my confirmation to the series and or individual
patches

Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>

By the way, I have noticed your iMX53 branch. We have some
old kits for this because we used it for yet another generation
of medical infusion system prototypes/instruments fully
functional demonstrators but before final HW design with
safety.

The fully realized and produced systems with iMX1 there
https://www.pikron.com/pages/devel/medinst.html

Functional demonstrators with iMX53 there
https://onimed.cz/wp-content/uploads/2021/02/medicina.png

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

