Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388B9C3065A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 11:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNVwK-0004Ou-GE; Sat, 29 Jun 2024 07:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sNVwD-0004M4-HX; Sat, 29 Jun 2024 07:08:14 -0400
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sNVwB-0002p9-Em; Sat, 29 Jun 2024 07:08:13 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 217008086B;
 Sat, 29 Jun 2024 13:08:08 +0200 (CEST)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id e3PP30qfhFP0; Sat, 29 Jun 2024 13:08:07 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id B022280873;
 Sat, 29 Jun 2024 13:08:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr B022280873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1719659287;
 bh=NoGIA+QH14p3U8EC14WujZvLi7NaMTSA4QkQhjA5IfQ=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=tuamVQ42IJf3iHotnkrN4JIGA6ZQr+GLwKGwRl4v3LuPpqkRHwjTbAK8+LGIdhocR
 mRRYczC80lnCMhD9PHXDSaJrzxyRECjsVi++16K16bdwypZCh3VxhG1hunY6cI/sqg
 g8O27XUJn2wTUiVql51AeXgv1E6S48XfZ0Gibcg0=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id LyqsnLqfoI1j; Sat, 29 Jun 2024 13:08:07 +0200 (CEST)
Received: from inesv-Inspiron-3501.. (unknown
 [IPv6:2a02:1808:284:73f9:f191:56:9ba9:96d9])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 87AA380840;
 Sat, 29 Jun 2024 13:08:06 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/2] hw/misc: Fix STM32L4x5 EXTI interrupts
Date: Sat, 29 Jun 2024 13:07:07 +0200
Message-ID: <20240629110800.539969-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
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

STM32L4x5 EXTI was incorrectly expecting alternating interrupts.
This patch adds a new field to track IRQ levels to actually
*detect* edges.
It also corrects existing QTests which were modifying the IRQ lines'
levels.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (2):
  hw/misc: In STM32L4x5 EXTI, correct configurable interrupts
  tests/qtest: Ensure STM32L4x5 EXTI state is correct at the end of
    QTests

 include/hw/misc/stm32l4x5_exti.h    |  2 ++
 hw/misc/stm32l4x5_exti.c            | 28 +++++++++++++---------------
 tests/qtest/stm32l4x5_exti-test.c   |  8 ++++++++
 tests/qtest/stm32l4x5_syscfg-test.c |  2 +-
 4 files changed, 24 insertions(+), 16 deletions(-)

--=20
2.43.2


