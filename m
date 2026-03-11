Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482FA112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PPI-00029u-0u; Wed, 11 Mar 2026 15:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PPG-000295-VH; Wed, 11 Mar 2026 15:39:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PPF-0000m5-Cv; Wed, 11 Mar 2026 15:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257670; bh=Oj8BN/M4HEAm0OcI5+WySxkFpddjnuNaWZfoCR5+BJ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Nxjcvl6ANAJ4fCGNJdGhXqgDMckLm14lgcYxbU6HQJ+MLI8aLr/UDQ2c+lvEk8siz
 APmqgO8fS2JwxmGAKU3ST8vV7E+gPqIr18trmxU8uoPPWVHJsdUKZBgA3qrGE6dob3
 94J48jeOD7XXKyVdVV+w9wlks6hJuOUJHasUn2AaCVulODb1QmWcdQQRONi1rhDRvU
 u9GbXxkGGROpWGH5Cnhe2xH20ovTAA7v7Iervgw3hQfC4YsFSHdBYgg2/XYFY0c01a
 wVuRLqti2VH7zPPLDxknt2Cy/EcAp07Ip8PslhdZPuzZeEimfj5ExerciJ8b12Dny3
 05DOCNTF23rPA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8442219211B;
 Wed, 11 Mar 2026 22:34:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 922F437C480;
 Wed, 11 Mar 2026 22:35:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, rail5 <andrew@rail5.org>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 51/53] target/loongarch: Avoid recursive PNX exception
 on CSR_BADI fetch
Date: Wed, 11 Mar 2026 22:34:44 +0300
Message-ID: <20260311193449.1096110-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
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

Fixes: 410dfbf620a ("target/loongarch: Move TCG specified functions to tcg_cpu.c")
Cc: qemu-stable@nongnu.org
Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit db2325f79481fab87211e5a287580d753f582cb8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 8615e03d14..e777139712 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -109,6 +109,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         }
         QEMU_FALLTHROUGH;
     case EXCCODE_PIF:
+    case EXCCODE_PNX:
     case EXCCODE_ADEF:
         cause = cs->exception_index;
         update_badinstr = 0;
@@ -129,7 +130,6 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_PIS:
     case EXCCODE_PME:
     case EXCCODE_PNR:
-    case EXCCODE_PNX:
     case EXCCODE_PPI:
         cause = cs->exception_index;
         break;
-- 
2.47.3


