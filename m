Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A6DC54E67
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 10:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlnw0-0001i6-7n; Sun, 17 Mar 2024 06:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnvx-0001hJ-Jm; Sun, 17 Mar 2024 06:40:05 -0400
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnvu-00010v-R6; Sun, 17 Mar 2024 06:40:05 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 149E3A06DC;
 Sun, 17 Mar 2024 11:39:59 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id LF9tRo2h-9DW; Sun, 17 Mar 2024 11:39:58 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 9F25EA084B;
 Sun, 17 Mar 2024 11:39:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 9F25EA084B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1710671998;
 bh=z8vP61lOqCHtPIe/NMBtNrdjHVIxDoNiy4/4Xzg3S5o=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=QXXWQoJnJAWu1igVq/rk9IRMaWIH8tHuQTj1+R1vCNVwEwPM09UdjGMePFiMw/teJ
 pOr0ExBUf4IoHnGMib9vIFbCTtfmj9ct3u3Tfbdk6elIsOjp8OhQ/IXXmA5s93aSSS
 /hKwhCITgN6LHJlsMwKWL5tJV9eauJNQgmKCXIuw=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id hO9EbYk_ZZsy; Sun, 17 Mar 2024 11:39:58 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 3778DA06DC;
 Sun, 17 Mar 2024 11:39:58 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PATCH 1/7] hw/misc/stm32l4x5_rcc: Propagate period when enabling a
 clock
Date: Sun, 17 Mar 2024 11:39:12 +0100
Message-Id: <20240317103918.44375-2-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
References: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The "clock_set_mul_div" function doesn't propagate the clock period to
the children if it is changed (e.g. by enabling/disabling
a clock multiplexer).
This was overlooked during the implementation due to late changes.

This commit propagates the change if the multiplier or divider changes.

The usart tests will ensure that this behavior will not regress.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/misc/stm32l4x5_rcc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index bc2d63528b..4725ba4f1c 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -59,7 +59,12 @@ static void clock_mux_update(RccClockMuxState *mux, bo=
ol bypass_source)
         freq_multiplier =3D mux->divider;
     }
=20
-    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
+    if ((mux->out->multiplier !=3D freq_multiplier) ||
+        mux->out->divider !=3D mux->multiplier) {
+        clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
+        clock_propagate(mux->out);
+    }
+
     clock_update(mux->out, clock_get(current_source));
=20
     src_freq =3D clock_get_hz(current_source);
--=20
2.34.1


