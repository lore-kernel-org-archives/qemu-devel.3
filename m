Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD8AC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 20:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9slL-0005Fg-6D; Wed, 22 May 2024 16:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s9slI-0005DD-P2; Wed, 22 May 2024 16:40:36 -0400
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s9slG-0003CH-KR; Wed, 22 May 2024 16:40:36 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 73AD720616;
 Wed, 22 May 2024 22:40:29 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id JhllZ0NXvaL2; Wed, 22 May 2024 22:40:28 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id CCA9320528;
 Wed, 22 May 2024 22:40:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr CCA9320528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1716410428;
 bh=UN1akvvFl2+VTqqnu9gWREufKJAhjqwwuabgunfm6bQ=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=08Jkhu7YjBs0Bg8Uml73RSps2PA4TaLjn7t34Uh+Vie2eqb536bT/ZaW2X6COZ8Rl
 R47FDQgDRgcbjOj3i1ipMINiIFye7fJkmMmLPykoD2Qlm6K+SFVNiFSYfW/eym5QSl
 v3qkvsXBlOJRRGv+tAADKWbkUWu5DzE72g39jliI=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id ncjvFZfnhpbU; Wed, 22 May 2024 22:40:28 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 7FF0D2051F;
 Wed, 22 May 2024 22:40:27 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/3] Connect STM32L4x5 USART devices to the EXTI
Date: Wed, 22 May 2024 22:39:37 +0200
Message-ID: <20240522204020.203905-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

STM32L4x5 EXTI was handling only configurable interrupts
(such as those coming from STM32L4x5 SYSCFG which was the
only device connected to the EXTI).
This patch adds support for direct line interrupts and
connects the existing STM32L4x5 USART devices to the EXTI.
The patch also corrects the handling of configurable line
interrupts in the EXTI.

Changes from v1 (2nd commit):
- add STM32L4x5 EXTI status fields `irq_levels` to track
configurable irq levels and do edge detection
- use `qemu_set_irq` instead of qemu_irq_raise/lower

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/misc: In STM32L4x5 EXTI, consolidate 2 constants
  hw/misc: In STM32L4x5 EXTI, handle direct and configurable interrupts
  hw/arm: In STM32L4x5 SOC, connect USART devices to EXTI

 include/hw/misc/stm32l4x5_exti.h |  6 ++++--
 hw/arm/stm32l4x5_soc.c           | 24 +++++++++++-------------
 hw/misc/stm32l4x5_exti.c         | 31 ++++++++++++++++++++++---------
 3 files changed, 37 insertions(+), 24 deletions(-)

--=20
2.43.2


