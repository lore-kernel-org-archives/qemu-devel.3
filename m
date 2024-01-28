Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C968AC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9Jl-0004gQ-EM; Sun, 28 Jan 2024 12:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9J7-00033l-5z; Sun, 28 Jan 2024 12:51:01 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9J4-0000pp-WE; Sun, 28 Jan 2024 12:51:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FA714810B;
 Sun, 28 Jan 2024 20:51:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C75E66D527;
 Sun, 28 Jan 2024 20:50:40 +0300 (MSK)
Received: (nullmailer pid 812425 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joseph Burt <caseorum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 62/71] tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct
Date: Sun, 28 Jan 2024 20:50:25 +0300
Message-Id: <20240128175035.812352-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Joseph Burt <caseorum@gmail.com>

When tcg_out_qemu_st_{index,direct} were merged, the direct case for
MO_64 was omitted, causing qemu_st_i64 to be encoded as 0xffffffff due
to underflow when adding h.base and h.index.

Fixes: 1df6d611bdc2 ("tcg/arm: Introduce HostAddress")
Signed-off-by: Joseph Burt <caseorum@gmail.com>
Message-Id: <20240121211439.100829-1-caseorum@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 9f6523e8e4689cafdbed7c10b7cf7c775b5a607b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index fc78566494..a9aa8aa91c 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1662,6 +1662,9 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg datalo,
             } else {
                 tcg_out_strd_r(s, h.cond, datalo, h.base, h.index);
             }
+        } else if (h.index < 0) {
+            tcg_out_st32_12(s, h.cond, datalo, h.base, 0);
+            tcg_out_st32_12(s, h.cond, datahi, h.base, 4);
         } else if (h.index_scratch) {
             tcg_out_st32_rwb(s, h.cond, datalo, h.index, h.base);
             tcg_out_st32_12(s, h.cond, datahi, h.index, 4);
-- 
2.39.2


