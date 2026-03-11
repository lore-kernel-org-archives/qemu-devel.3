Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA774112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L6f-0006wT-6R; Wed, 11 Mar 2026 11:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L6A-0005RS-AB; Wed, 11 Mar 2026 11:03:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L68-00046V-Ln; Wed, 11 Mar 2026 11:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241304; bh=JNL2rIu2vfEaYsIMtje72Dk25oI+UsT0THp6K99zEqc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rGPy4ahtfN2/EewjLBRs84wrSkA2jchG4PnSRpkevgGrmvvUpu05aFfcv/Y02Uxw0
 fPiZlCCC9XBb+DqjOOYvKGWgY1wgbSkbQ8f8xN2NCJ2oNFDNKtXjY8ULa2qLgznqv3
 2CkyQFhsac+EO3ykQtx4DEg3NZGzMuplxYpbclJPe+th3MNcJQtyw6odz4KtByU3HI
 POeity09nnyhGjRoHNaZK2g7rxKSLlURUJK5QRfB3n3k1xqtD4ibr6bUwn9hOn7Huu
 6dHxQPQQ/saOxdnbsMO6e7ICDIqh9EdNpvprnjHEWDHiW0ic97RQpdXmuUsdaEP3zJ
 EdxDRp6VspbNw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9B736191E50;
 Wed, 11 Mar 2026 18:01:44 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E69137C2A2;
 Wed, 11 Mar 2026 18:02:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 18/44] hw/misc/virt_ctrl: Fix incorrect trace event in
 read operation
Date: Wed, 11 Mar 2026 18:01:50 +0300
Message-ID: <20260311150221.1084186-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

The virt_ctrl_read() function currently invokes trace_virt_ctrl_write()
instead of trace_virt_ctrl_read(). This results in read operations
appearing as write operations in the trace output, which is misleading
during debugging and analysis.

Replace the incorrect trace call with the proper read-specific trace
event to accurately reflect the hardware behavior.

Fixes: 0791bc02b8fb ("m68k: add a system controller")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260111184915.1363318-1-visitorckw@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 8608ed356ef90815cc5bcf04fcdbde987fd24bca)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index a210a5924c..ee31b10210 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -43,7 +43,7 @@ static uint64_t virt_ctrl_read(void *opaque, hwaddr addr, unsigned size)
         break;
     }
 
-    trace_virt_ctrl_write(s, addr, size, value);
+    trace_virt_ctrl_read(s, addr, size, value);
 
     return value;
 }
-- 
2.47.3


