Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBBCCCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 19:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vACHT-0006ji-Tm; Sat, 18 Oct 2025 15:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACHJ-0006cl-ML; Sat, 18 Oct 2025 15:07:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACHE-00018K-62; Sat, 18 Oct 2025 15:07:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C98415F7A4;
 Sat, 18 Oct 2025 22:06:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 31E372F060D;
 Sat, 18 Oct 2025 22:07:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 23/23] linux-user/microblaze: Fix little-endianness
 binary
Date: Sat, 18 Oct 2025 22:06:58 +0300
Message-ID: <20251018190702.1178893-12-mjt@tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

MicroBlaze CPU model has a "little-endian" property, pointing to
the @endi internal field. Commit c36ec3a9655 ("hw/microblaze:
Explicit CPU endianness") took care of having all MicroBlaze
boards with an explicit default endianness, so later commit
415aae543ed ("target/microblaze: Consider endianness while
translating code") could infer the endianness at runtime from
the @endi field, and not a compile time via the TARGET_BIG_ENDIAN
definition. Doing so, we forgot to make the endianness explicit
on user emulation, so there all CPUs are started with the default
"little-endian=off" value, leading to breaking support for little
endian binaries:

  $ readelf -h ./hello-world-mbel
  ELF Header:
    Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
    Class:                             ELF32
    Data:                              2's complement, little endian

  $ qemu-microblazeel ./hello-world-mbel
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)

Fix by restoring the previous behavior of starting with the
builtin endianness of the binary:

  $ qemu-microblazeel ./hello-world-mbel
  Hello World

Cc: qemu-stable@nongnu.org
Fixes: 415aae543ed ("target/microblaze: Consider endianness while translating code")
Reported-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20251006173350.17455-1-philmd@linaro.org>
(cherry picked from commit 91fc6d8101de97c588e0a4263cf4f6148b3e702a)
(Mjt: adapt for missing v10.1.0-38-gaf880af8d4
 "linux-user: Move get_elf_cpu_model to target/elfload.c")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 8a8f1debff..cab4c9187c 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -9,6 +9,7 @@
 #define MICROBLAZE_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
-    return "any";
+    return TARGET_BIG_ENDIAN ? "any,little-endian=off"
+                             : "any,little-endian=on";
 }
 #endif
-- 
2.47.3


