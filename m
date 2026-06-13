Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85D2CD98D6
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV5y-0001Z2-E1; Sat, 13 Jun 2026 16:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5t-0001WK-22; Sat, 13 Jun 2026 16:36:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV5q-0003D5-In; Sat, 13 Jun 2026 16:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382962; bh=RRilm8J/FA34uAbj7pNEW/b/xFYBDEIAPFSEmcy+wOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=icNRQL3WGh8mtYBzCljROb/csD1RgpgrJQ1IzVLKoy2Ypt6yZcJnyRtqcGBUAUdy+
 841u8laXK2LZTCbzVJzK5Q0DxnqienrdwiobeD6rPQhxgnq9lGbQZGfDtrtP2uicCP
 ULEa/4t9atD7LtBGuXTlcP+RLUUTpunlmo2dIIfKy/WeUboNDgdldWLCXqFYWKfArO
 zK4UlYInYA84ZEKF+X4aGIA2wWd94WqV+d33V756il4oORWsPOR4paDXmbg7pidc12
 TSMF8Q48eSAdnbdzTCNoHml4QvvEUwI1v5jaCP+YYyDb+NdQeVSwzwbjahAajJH08v
 DDPNURWhpT1ng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC0891B6EDF;
 Sat, 13 Jun 2026 23:36:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1CDE33CE931;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 05/72] target/riscv: Allow mseccfg access based on
 ext_zicfilp
Date: Sat, 13 Jun 2026 23:34:31 +0300
Message-ID: <20260613203542.1809153-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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

From: Zishun Yi <vulab@iscas.ac.cn>

The Zicfilp extension adds the MLPE field to the mseccfg CSR. According
to the RISC-V Privileged Specification, mseccfg exists if any extension
that adds a field to it is implemented.

Currently, the `have_mseccfg()` predicate function checks for Smepmp,
Zkr, and Smmpm, but misses Zicfilp. As a result, if a CPU is configured
with `zicfilp=true` but without the other extensions, accessing the
mseccfg CSR will incorrectly raise an illegal instruction exception.

This patch adds the missing check for `ext_zicfilp` to ensure the CSR
is properly accessible when the Zicfilp extension is enabled.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2561/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260511072705.3015986-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 249483623242c1b9ad4a1600083bea534620917a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 29dd596ae4..51e668b46d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -770,6 +770,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     if (riscv_cpu_cfg(env)->ext_smmpm) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_zicfilp) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
-- 
2.47.3


