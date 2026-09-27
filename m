Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA60C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmTw-0005wE-B5; Sun, 27 Sep 2026 06:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTs-0005gd-Le; Sun, 27 Sep 2026 06:51:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTr-0001Wk-5x; Sun, 27 Sep 2026 06:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506136; bh=0B8QvBlAAnZwt/lPniYUeVVwwW99+5DagjZ6fP7bnMQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Km7juITVJw04q/LNYymZ0W83ZxwD/NPMmdZKKDZE90/fqbVIU05BGy9kG2xAOjT1o
 z9uCBJSutBun8sbvzRQfqY1Za+KW+ApAngo5kF131INB1o95XsaqnyXJIIkitys5tq
 itV+M+32bjQZd4JfuEBwQUFgULRMmA2DKf2wNeG9oHU8nfh3JSEcTF0ZuLaKXO5kkL
 0DzSg0bC/U8HmCgcjjtOPbZrdjs/0FnboNTGcdVCwDBNIAuYTDs7iwA949QRJrWLjI
 IuqsjgUvhUY++ZvJ2P7hIfP8elUHx75m3klRHr0pfC5ge6TgVBIdS3o9ZZVlNQdXqW
 wHPwyBPl1w5jQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 704F61D8B7A;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6A02E432181;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 198085E7AC; Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 91/92] accel/tcg: Set CF_NOIRQ during
 cpu_exec_step_atomic
Date: Sun, 27 Sep 2026 13:48:07 +0300
Message-ID: <20260927104821.196183-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not go through the effort of grabbing the exclusive lock
only to check for interrupts and exit without making progress.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 460da0e55c31694156d545097569e1e14052cd46)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 257211235db..527102f783f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -566,7 +566,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
         /* Execute in a serial context. */
         s.cflags &= ~CF_PARALLEL;
         /* After 1 insn, return and release the exclusive lock. */
-        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | 1;
+        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_NOIRQ | 1;
+
         /*
          * No need to check_for_breakpoints here.
          * We only arrive in cpu_exec_step_atomic after beginning execution
-- 
2.47.3


