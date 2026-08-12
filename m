Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197F8C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8pW-000827-AH; Wed, 12 Aug 2026 09:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8lI-0003na-Vc; Wed, 12 Aug 2026 09:12:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8lF-0006Xw-Fo; Wed, 12 Aug 2026 09:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=cl3qhEN/Rs94YLn4srZ1XiXoPYjFb3UpN+BopXpx+M4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kS1/q/C5E1W2aMyMd7vXzmVmt8a7uYHzf3qK0eswgckC+VCE8fYSyDoYLMKqJjJX4
 isKcTlTgH0ZqTPMgfzXkFxP99Ab12h193xYKAjX7YCF5h4EhJzwFPZdY2aXrrXIKJO
 xinoR/S1iYl1kjrVpnocIqRVJRMhcoVnKG25Ci5sXNZhzwbAn7tyEhmAIydHh4u0BE
 OMXoZ5ezcIOWDSS12a34psVL5Tdi7sVDt2tPY5mWU2hJXeq9OdE1z657I/o/dfDGx+
 K4eIwhEJCZ7Oh0OgxrsSJWuLjlxrxosZdWS6zBPbNO7zbnONO+ICFst4Ok5UoIjAeQ
 9BAxs4znP30aA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D9A3A1CA4E3;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B886409BC6;
 Wed, 12 Aug 2026 16:03:16 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D8A402F95C; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 100/102] linux-user/sh4: Deliver SIGILL on invalid
 instruction
Date: Wed, 12 Aug 2026 16:02:15 +0300
Message-ID: <20260812130233.621965-100-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

From: Mikulas Patocka <mpatocka@redhat.com>

On invalid instruction, deliver SIGILL rather than crashing the whole
process unconditionally.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit bc4681990bb6b065e78e7564cb431e44dd148b88)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index ee9eff3428a..8caf86b8422 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -64,6 +64,13 @@ void cpu_loop(CPUSH4State *env)
             cpu_exec_step_atomic(cs);
             arch_interrupt = false;
             break;
+        case 0x180:
+            /* Illegal instruction */
+            /* fallthrough */
+        case 0x1a0:
+            /* Illegal instruction in delay slot */
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
+            break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
             cpu_dump_state(cs, stderr, 0);
-- 
2.47.3


