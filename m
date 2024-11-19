Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EFCD591A6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 06:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDHLw-00015r-Dr; Tue, 19 Nov 2024 01:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLq-0000xN-SY; Tue, 19 Nov 2024 01:04:38 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLo-0004dU-Hm; Tue, 19 Nov 2024 01:04:38 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C2A0EA6263;
 Tue, 19 Nov 2024 09:04:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EAC2E1738D9;
 Tue, 19 Nov 2024 09:04:18 +0300 (MSK)
Received: (nullmailer pid 2368935 invoked by uid 1000);
 Tue, 19 Nov 2024 06:04:18 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 61/72] target/arm: Drop user-only special case in
 sve_stN_r
Date: Tue, 19 Nov 2024 09:04:02 +0300
Message-Id: <20241119060418.2368866-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

This path is reachable with plugins enabled, and provoked
with run-plugin-catch-syscalls-with-libinline.so.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241112141232.321354-1-richard.henderson@linaro.org>
(cherry picked from commit f27550804688da43c6e0d87b2f9e143adbf76271)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f1ee0e060f..904296705c 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6317,9 +6317,6 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
-#ifdef CONFIG_USER_ONLY
-        g_assert_not_reached();
-#else
         /*
          * At least one page includes MMIO.
          * Any bus operation can fail with cpu_transaction_failed,
@@ -6350,7 +6347,6 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
         return;
-#endif
     }
 
     mem_off = info.mem_off_first[0];
-- 
2.39.5


