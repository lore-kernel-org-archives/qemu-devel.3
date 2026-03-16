Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C7DF506D4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28Ls-0001lR-6F; Mon, 16 Mar 2026 09:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Lj-0001kx-Lk; Mon, 16 Mar 2026 09:51:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Lg-0008Vr-12; Mon, 16 Mar 2026 09:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773669061; bh=GIWFDMup7PnyDPuGpX26ynNi7qdwSuaGQV5k7Y/YIi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l1BOFgGsjaLR+9k0ksIrizmy3VDKFZ+uxmh6NxI/Z3NiDDCO8MOnqm89hBanM1kX6
 UiSECKP8xOjxeZDr015i+5AOBDbiy6EEKZ6vN+GeCpB4SMzRb6RQXViGOkH6MQBe/P
 vrGPdnRZjb5PRnMili9hm9zkd/bm51aIVcxZ1B0gxAmz/zjwX1aGJkZoRdlRBAD8WC
 LMmSeUAKeAkPttK7PWrft1ZsqdQaYsJ7pAcur7JNMa7JQEo8hCVA9sMak4okiAUtsU
 psv4C/B0m1Vzii25b7ak+m8RwpcxhNHnC7UH1rFdcb+Ay7/1JcVkDoUXHwkSGdoVWX
 MKDtX/eKbu5rw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 49A64193EEE;
 Mon, 16 Mar 2026 16:51:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D166E380938;
 Mon, 16 Mar 2026 16:51:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, rail5 <andrew@rail5.org>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 44/46] target/loongarch: Avoid recursive PNX exception
 on CSR_BADI fetch
Date: Mon, 16 Mar 2026 16:50:43 +0300
Message-ID: <20260316135104.119985-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260316164926@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260316164926@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: rail5 <andrew@rail5.org>

loongarch_cpu_do_interrupt() updates CSR_BADI by fetching the faulting
instruction with cpu_ldl_code_mmu().

For a PNX exception (instruction fetch prohibited by NX), fetching the
instruction at env->pc will fault with PNX again. This can lead to an
infinite exception loop.

Treat PNX like other instruction-fetch exceptions (PIF/ADEF) and do not
update CSR_BADI for it.

-Fixes: 410dfbf620a ("target/loongarch: Move TCG specified functions to tcg_cpu.c")
Fixes: d2cba6f7cea9 ("target/loongarch: Add other core instructions support")
Cc: qemu-stable@nongnu.org
Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit db2325f79481fab87211e5a287580d753f582cb8)
(Mjt: back-port to 10.0.x across v10.1.0-1187-g410dfbf620
 "target/loongarch: Move TCG specified functions to tcg_cpu.c")
(fixing the Fixes: tag)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 84b86da308..a5f6b7cdc5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -197,6 +197,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         }
         QEMU_FALLTHROUGH;
     case EXCCODE_PIF:
+    case EXCCODE_PNX:
     case EXCCODE_ADEF:
         cause = cs->exception_index;
         update_badinstr = 0;
@@ -217,7 +218,6 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_PIS:
     case EXCCODE_PME:
     case EXCCODE_PNR:
-    case EXCCODE_PNX:
     case EXCCODE_PPI:
         cause = cs->exception_index;
         break;
-- 
2.47.3


