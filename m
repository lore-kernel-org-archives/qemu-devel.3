Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6729FC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAks9-0006O2-Ln; Sun, 27 Sep 2026 05:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkre-0002s6-Oe; Sun, 27 Sep 2026 05:08:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkrc-0008J3-VP; Sun, 27 Sep 2026 05:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499961; bh=OJL6Jeh5LDavx0B4PSyVKcHMmaC2brGY8i2teKVWaxA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mp2zXna3YoBV1Mxm+Jq/FOaqp0rcLDsDxhU2VpYgZY2QtB9fBEiAgJL/3K5rXCeUV
 /XSuNZ1i8DdtHM0n9B5FaMjd7TdbtgKVEldEKvo0SxctJNMNzvw9sS+7FdixG3CIv1
 Jox5b+2Tx2Cazs6cjG9+NML6N97jF44yee/kqk0VNTPJY7gO/WT++7WYFcWDj8qAWA
 ghvUD8/FVu/BuO4OsNV7+OtgKTOUtp28RD21PDpbJVtK06xe19JXhejwI14VrB2y58
 cRRny9ZagDo4gzLXoJcdUx4EHAe4Xy7N/o+UKsjLnlyxFEfFbVlRLIthXFeg3Fvyad
 NvyhMZMBVTC8A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 97B2C1D8B26;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 91D264320DF;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F333B5E67D; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 85/86] accel/tcg: Set CF_NOIRQ during
 cpu_exec_step_atomic
Date: Sun, 27 Sep 2026 12:05:32 +0300
Message-ID: <20260927090540.102811-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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
index ad94f96b252..fdc65c1c33a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -563,7 +563,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
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


