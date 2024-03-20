Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF0EC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2Qx-00076z-Dg; Wed, 20 Mar 2024 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balbi@kernel.org>) id 1rn2Qu-000768-0A
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:21:08 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balbi@kernel.org>) id 1rn2Qq-0007ru-2Q
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:21:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8113461073;
 Wed, 20 Mar 2024 20:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A78C433F1;
 Wed, 20 Mar 2024 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710966062;
 bh=gYnRr5zNdsSRItA32o+m5syJ2AZGwvS4kK1/Sewk4GQ=;
 h=From:To:Cc:Subject:Date:From;
 b=KrCRmai66drbt062i/qDRjZPyKfsji3g99ujvtQuXvndllzhVZZKugBYdR4HSavVO
 VcY9TK4zU4kLmH+djH7lrmelvm9Z7eUnJFwi6W1Bm1t5O/S7OJgzDZYWNBuvrI3wUU
 ISkMZCNaqO4fN5pPBYMJdHFQIzd6R6JEaMKJNp2Re5OXdkMWjHkSV23b2IcwjshZ6c
 KihmWNsa3wLm4yUVFnToNSiV2qs5wW4wop8AVJeIUqf469OWi+po6gIaXf+zEABH+9
 6F1SKEegPQZXfPTmQ1d8LQYFG4QMpd+K9tsY3aBWi+F8IQSl6bqN18smRZZo02WYjK
 i8FoWu4JJdQxQ==
From: Felipe Balbi <balbi@kernel.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>,
	Felipe Balbi <balbi@kernel.org>
Subject: [PATCH v2 0/2] Add support for STM32G0 SoC family
Date: Wed, 20 Mar 2024 22:20:58 +0200
Message-ID: <20240320202100.820228-1-balbi@kernel.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=balbi@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi all,

These two patches add support for STM32G0 family and nucleo-g071rb
board. Patches have been tested with minimal embedded rust examples.

Changes since v1:

  - Patch 1:
    - Convert tabs to spaces (checkpatch.pl)
    - Correct lines longer than 80 characters (checkpatch.pl)
    - Correct num-prio-bits (Samuel Tardieu)
    - Correct num-irqs (Found reviewing RM0444)

  - Patch 2:
    - Convert tabs to spaces (checkpatch.pl)

Felipe Balbi (2):
  hw/arm: Add support for stm32g000 SoC family
  hw/arm: Add nucleo-g071rb board

 MAINTAINERS                    |  13 ++
 hw/arm/Kconfig                 |  12 ++
 hw/arm/meson.build             |   2 +
 hw/arm/nucleo-g071rb.c         |  70 +++++++++
 hw/arm/stm32g000_soc.c         | 253 +++++++++++++++++++++++++++++++++
 include/hw/arm/stm32g000_soc.h |  62 ++++++++
 6 files changed, 412 insertions(+)
 create mode 100644 hw/arm/nucleo-g071rb.c
 create mode 100644 hw/arm/stm32g000_soc.c
 create mode 100644 include/hw/arm/stm32g000_soc.h

-- 
2.44.0


