Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A88C27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:41:24 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf6I-0006IY-Dk; Fri, 07 Jun 2024 15:18:10 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf6F-000655-TK; Fri, 07 Jun 2024 15:18:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf6D-00038Z-JZ; Fri, 07 Jun 2024 15:18:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 234136E570;
 Fri,  7 Jun 2024 22:14:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4BF6DE2769;
 Fri,  7 Jun 2024 22:14:00 +0300 (MSK)
Received: (nullmailer pid 529475 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair23@gmail.com>,
 Eric DeVolder <eric_devolder@yahoo.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 66/71] disas/riscv: Decode all of the pmpcfg and
 pmpaddr CSRs
Date: Fri,  7 Jun 2024 22:13:47 +0300
Message-Id: <20240607191356.529336-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
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

From: Alistair Francis <alistair23@gmail.com>

Previously we only listed a single pmpcfg CSR and the first 16 pmpaddr
CSRs. This patch fixes this to list all 16 pmpcfg and all 64 pmpaddr
CSRs are part of the disassembly.

Reported-by: Eric DeVolder <eric_devolder@yahoo.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Fixes: ea10325917 ("RISC-V Disassembler")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240514051615.330979-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 915758c537b5fe09575291f4acd87e2d377a93de)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv.c b/disas/riscv.c
index e236c8b5b7..297cfa2f63 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2190,7 +2190,22 @@ static const char *csr_name(int csrno)
     case 0x0383: return "mibound";
     case 0x0384: return "mdbase";
     case 0x0385: return "mdbound";
-    case 0x03a0: return "pmpcfg3";
+    case 0x03a0: return "pmpcfg0";
+    case 0x03a1: return "pmpcfg1";
+    case 0x03a2: return "pmpcfg2";
+    case 0x03a3: return "pmpcfg3";
+    case 0x03a4: return "pmpcfg4";
+    case 0x03a5: return "pmpcfg5";
+    case 0x03a6: return "pmpcfg6";
+    case 0x03a7: return "pmpcfg7";
+    case 0x03a8: return "pmpcfg8";
+    case 0x03a9: return "pmpcfg9";
+    case 0x03aa: return "pmpcfg10";
+    case 0x03ab: return "pmpcfg11";
+    case 0x03ac: return "pmpcfg12";
+    case 0x03ad: return "pmpcfg13";
+    case 0x03ae: return "pmpcfg14";
+    case 0x03af: return "pmpcfg15";
     case 0x03b0: return "pmpaddr0";
     case 0x03b1: return "pmpaddr1";
     case 0x03b2: return "pmpaddr2";
@@ -2207,6 +2222,54 @@ static const char *csr_name(int csrno)
     case 0x03bd: return "pmpaddr13";
     case 0x03be: return "pmpaddr14";
     case 0x03bf: return "pmpaddr15";
+    case 0x03c0: return "pmpaddr16";
+    case 0x03c1: return "pmpaddr17";
+    case 0x03c2: return "pmpaddr18";
+    case 0x03c3: return "pmpaddr19";
+    case 0x03c4: return "pmpaddr20";
+    case 0x03c5: return "pmpaddr21";
+    case 0x03c6: return "pmpaddr22";
+    case 0x03c7: return "pmpaddr23";
+    case 0x03c8: return "pmpaddr24";
+    case 0x03c9: return "pmpaddr25";
+    case 0x03ca: return "pmpaddr26";
+    case 0x03cb: return "pmpaddr27";
+    case 0x03cc: return "pmpaddr28";
+    case 0x03cd: return "pmpaddr29";
+    case 0x03ce: return "pmpaddr30";
+    case 0x03cf: return "pmpaddr31";
+    case 0x03d0: return "pmpaddr32";
+    case 0x03d1: return "pmpaddr33";
+    case 0x03d2: return "pmpaddr34";
+    case 0x03d3: return "pmpaddr35";
+    case 0x03d4: return "pmpaddr36";
+    case 0x03d5: return "pmpaddr37";
+    case 0x03d6: return "pmpaddr38";
+    case 0x03d7: return "pmpaddr39";
+    case 0x03d8: return "pmpaddr40";
+    case 0x03d9: return "pmpaddr41";
+    case 0x03da: return "pmpaddr42";
+    case 0x03db: return "pmpaddr43";
+    case 0x03dc: return "pmpaddr44";
+    case 0x03dd: return "pmpaddr45";
+    case 0x03de: return "pmpaddr46";
+    case 0x03df: return "pmpaddr47";
+    case 0x03e0: return "pmpaddr48";
+    case 0x03e1: return "pmpaddr49";
+    case 0x03e2: return "pmpaddr50";
+    case 0x03e3: return "pmpaddr51";
+    case 0x03e4: return "pmpaddr52";
+    case 0x03e5: return "pmpaddr53";
+    case 0x03e6: return "pmpaddr54";
+    case 0x03e7: return "pmpaddr55";
+    case 0x03e8: return "pmpaddr56";
+    case 0x03e9: return "pmpaddr57";
+    case 0x03ea: return "pmpaddr58";
+    case 0x03eb: return "pmpaddr59";
+    case 0x03ec: return "pmpaddr60";
+    case 0x03ed: return "pmpaddr61";
+    case 0x03ee: return "pmpaddr62";
+    case 0x03ef: return "pmpaddr63";
     case 0x0780: return "mtohost";
     case 0x0781: return "mfromhost";
     case 0x0782: return "mreset";
-- 
2.39.2


