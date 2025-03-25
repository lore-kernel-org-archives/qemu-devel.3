Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CECC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twy7h-0004Ym-Vd; Tue, 25 Mar 2025 02:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy7f-0004Y8-Pl; Tue, 25 Mar 2025 02:50:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy7c-0001dB-69; Tue, 25 Mar 2025 02:50:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9B375107D61;
 Tue, 25 Mar 2025 09:49:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3DECA1D5E70;
 Tue, 25 Mar 2025 09:50:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 305B057028; Tue, 25 Mar 2025 09:50:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joe Komlodi <komlodi@google.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.17 28/34] util/cacheflush: Make first DSB unconditional
 on aarch64
Date: Tue, 25 Mar 2025 09:50:23 +0300
Message-Id: <20250325065031.3263718-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.17-20250325094839@cover.tls.msk.ru>
References: <qemu-stable-7.2.17-20250325094839@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Joe Komlodi <komlodi@google.com>

On ARM hosts with CTR_EL0.DIC and CTR_EL0.IDC set, this would only cause
an ISB to be executed during cache maintenance, which could lead to QEMU
executing TBs containing garbage instructions.

This seems to be because the ISB finishes executing instructions and
flushes the pipeline, but the ISB doesn't guarantee that writes from the
executed instructions are committed. If a small enough TB is created, it's
possible that the writes setting up the TB aren't committed by the time the
TB is executed.

This function is intended to be a port of the gcc implementation
(https://github.com/gcc-mirror/gcc/blob/85b46d0795ac76bc192cb8f88b646a647acf98c1/libgcc/config/aarch64/sync-cache.c#L67)
which makes the first DSB unconditional, so we can fix the synchronization
issue by doing that as well.

Cc: qemu-stable@nongnu.org
Fixes: 664a79735e4deb1 ("util: Specialize flush_idcache_range for aarch64")
Signed-off-by: Joe Komlodi <komlodi@google.com>
Message-id: 20250310203622.1827940-2-komlodi@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e6c38d2ab55d66c74ceade5699e22cabe9058d22)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/cacheflush.c b/util/cacheflush.c
index 2c2c73e085..9b1debd1c1 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -264,9 +264,11 @@ void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
         for (p = rw & -dcache_lsize; p < rw + len; p += dcache_lsize) {
             asm volatile("dc\tcvau, %0" : : "r" (p) : "memory");
         }
-        asm volatile("dsb\tish" : : : "memory");
     }
 
+    /* DSB unconditionally to ensure any outstanding writes are committed. */
+    asm volatile("dsb\tish" : : : "memory");
+
     /*
      * If CTR_EL0.DIC is enabled, Instruction cache cleaning to the Point
      * of Unification is not required for instruction to data coherence.
-- 
2.39.5


