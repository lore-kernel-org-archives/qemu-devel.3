Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3809CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 19:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vACHR-0006jO-3w; Sat, 18 Oct 2025 15:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACHB-0006ZT-Dy; Sat, 18 Oct 2025 15:07:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACH9-00017o-Ev; Sat, 18 Oct 2025 15:07:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 58B2E15F7A3;
 Sat, 18 Oct 2025 22:06:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 19F322F060C;
 Sat, 18 Oct 2025 22:07:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gabriel Brookman <brookmangabriel@gmail.com>,
 =?UTF-8?q?Andreas=20H=C3=BCttel?= <andreas.huettel@ur.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 22/23] target/hppa: correct size bit parity for fmpyadd
Date: Sat, 18 Oct 2025 22:06:57 +0300
Message-ID: <20251018190702.1178893-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

For the fmpyadd instruction on the hppa architecture, there is a bit
used to specify whether the instruction is operating on a 32 bit or
64 bit floating point register. For most instructions, such a bit is 0
when operating on the smaller register and 1 when operating on the
larger register. However, according to page 6-57 of the PA-RISC 1.1
Architecture and Instruction Set Reference Manual, this convention is
reversed for the fmpyadd instruction specifically, meaning the bit is
1 for operations on 32 bit registers and 0 for 64 bit registers. See
also page 6-18 (fig. 6-8) and 6-19 (table 6-16), where the f field
for FMPYADD and FMPYSUB is documented. Previously, QEMU decoded this
operation as operating on the other size of register, leading to bugs
when translating the fmpyadd instruction. This patch fixes that issue.

Reported-by: Andreas Hüttel <andreas.huettel@ur.de>
Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3096
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-ID: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
[PMD: Add documentation refs mentioned by Andreas K. Huettel]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit cea82f8cdd07697a48ae1c4e026707463f432a45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 4eaac750ea..13c6a55bf2 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -365,10 +365,10 @@ fstd            011100 ..... ..... .. ............1.    @ldstim11
 &mpyadd         rm1 rm2 ta ra tm
 @mpyadd         ...... rm1:5 rm2:5 ta:5 ra:5 . tm:5     &mpyadd
 
-fmpyadd_f       000110 ..... ..... ..... ..... 0 .....  @mpyadd
-fmpyadd_d       000110 ..... ..... ..... ..... 1 .....  @mpyadd
-fmpysub_f       100110 ..... ..... ..... ..... 0 .....  @mpyadd
-fmpysub_d       100110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpyadd_f       000110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpyadd_d       000110 ..... ..... ..... ..... 0 .....  @mpyadd
+fmpysub_f       100110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpysub_d       100110 ..... ..... ..... ..... 0 .....  @mpyadd
 
 ####
 # Conditional Branches
-- 
2.47.3


