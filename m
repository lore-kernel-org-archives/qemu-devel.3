Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376AA606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=n5yWEPJi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3J3-0003V9-Oe; Mon, 16 Nov 2026 15:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Iv-0002hp-DI; Mon, 16 Nov 2026 15:27:53 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3It-0001TM-Pk; Mon, 16 Nov 2026 15:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=0MZgjF4tMoIKTt+lwNdvrl+shQhPMmGeOj4MSy77COA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n5yWEPJiGWO0goi0ohGeobJ0D9GJJkmfrCt9+kbafHo7FJ+gVnDWAbHYNh7lV8/V2
 unsK1FtuJ9Hz2hphgvQFCD0HtzFEO8OwJ4gmqsVMY2Zil6XB+UqvumRaXglbo8oNkt
 0m7SfCq/1/OsBfOwumFHL8vFpBtBo4KPaMkVmfceQaHgXWMPt7IF8CUi+CyQhxEv/9
 sYHNBtquRnk+39kupHEYFlrdLMT0uaAfVPZfDRqejgKEF303B00CHkcehxsnxDEwEe
 XbeqH3d3tC+207ipLsHjcgQd2uGXe7shZnquvFUxN5LTcoOf2gAkdqvaVrWm5Q8S7G
 skE6DIZocC1OA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2CECD1E71AC;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2955245FBD8;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AC820B8E74; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stian Halseth <stian@itx.no>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 23/63] accel/tcg: Do not flush and retry in place in
 tb_gen_code
Date: Mon, 16 Nov 2026 23:25:02 +0300
Message-ID: <20261116202554.535325-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stian Halseth <stian@itx.no>

When the code buffer is full in a serial context, tb_gen_code() flushes
it and retries in place. cpu_exec_loop() then chains its last_tb, now
freed, into the new TB. When that TB is invalidated, tb_jmp_unlink()
follows the stale entry and qemu crashes inside its SIGSEGV handler.

Always queue the flush and leave through cpu_loop_exit(), as before
commit ebf7a5d294a3. This also brings back the cleanup in
cpu_loop_exit() and cpu_exec_longjmp_cleanup() that the retry skipped.

Since commit 25e5c6a320db ("accel/tcg: Allow cross-page goto_tb
chaining in user-only builds"), user-only builds hit this easily,
e.g. qemu-sparc64 -tb-size 1 on a program writing next to its PLT.

Cc: qemu-stable@nongnu.org
Fixes: ebf7a5d294a3 ("accel/tcg: Improve buffer overflow in tb_gen_code")
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 3992091713eb51a4a1cf0a592a30ae9e856c6b55)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 328d96aba30..ea8257935ed 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -288,12 +288,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     assert_no_pages_locked();
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
-        /* flush must be done */
-        if (cpu_in_serial_context(cpu)) {
-            trace_tb_gen_code_buffer_overflow("tcg_tb_alloc");
-            tb_flush__exclusive_or_serial();
-            goto buffer_overflow;
-        }
+        /*
+         * Flush must be done.  Always exit the cpu loop so that the
+         * last_tb linkage within the inner cpu loop does not apply.
+         */
+        trace_tb_gen_code_buffer_overflow("tcg_tb_alloc");
         queue_tb_flush(cpu);
         mmap_unlock();
         /* Make the execution loop process the flush as soon as possible.  */
-- 
2.47.3


