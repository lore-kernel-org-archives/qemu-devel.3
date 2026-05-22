Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D313CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXl3-0007sa-Oq; Fri, 22 May 2026 17:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkY-0006vG-4S; Fri, 22 May 2026 17:49:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkW-0002cx-ED; Fri, 22 May 2026 17:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486559; bh=6ttS+OBwVuSJGHZkrgJNbxyeLpBThZnjePJjP1+Z0zg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QaahfwGXb8g9rjZChZnqC2kr/9P4bzh2kAajkA0OaJP757Y3r5SsfxXDdFqDEUWX/
 VXMKFbJRy1gTECpXXTmEEysiJQPFPHkbfyjDQvRz7Hr6j3eHeafiQ1FFTAFGE+wWWK
 1Aiefdh6fSRk7OPi2b+EyqRBQb/WRKj9APSN3EjoAEpfm60R8r/1XMdwGosrbn9K5D
 6LE0BLoaKwWNqe3i8FYS8GigLThMnoOJiL21WKbwtQwMTLrsYXORKzMwCHlBWzDDIH
 3ihJU1MBA3d6aYVPs+6OGtpr7tmZa5Rg+jvGjoYmG23F2DCYBeZZ7EqmAMQPdT5Yt1
 Ii3wUeD0shKeA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91C0A1AFB63;
 Sat, 23 May 2026 00:49:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B8D5B3B71B2;
 Sat, 23 May 2026 00:49:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 109/149] target/microblaze: Fix endianness used to
 disassemble
Date: Sat, 23 May 2026 00:48:41 +0300
Message-ID: <20260522214923.807017-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

MicroBlaze CPU model has a "little-endian" property, pointing to
the @endi internal field. Commit c36ec3a9655 ("hw/microblaze:
Explicit CPU endianness") took care of having all MicroBlaze
boards with an explicit default endianness (similarly with
commit 91fc6d8101d for linux-user binaries), so later commit
415aae543ed ("target/microblaze: Consider endianness while
translating code") could infer the endianness at runtime from
the @endi field, and not a compile time via the TARGET_BIG_ENDIAN
definition. Doing so, we forgot to propagate that runtime change
to the disassemble_info structure. Do it now to display the
opcodes in correct endianness order.

Cc: qemu-stable@nongnu.org
Fixes: 415aae543ed ("target/microblaze: Consider endianness while translating code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-3-philmd@linaro.org>
(cherry picked from commit 41c417290df91c31a70adeb8f5271896a8c5f802)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 22231f09e6..965eedbfaf 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -237,8 +237,8 @@ static void mb_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_microblaze;
     info->print_insn = print_insn_microblaze;
-    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
-                                     : BFD_ENDIAN_LITTLE;
+    info->endian = MICROBLAZE_CPU(cpu)->cfg.endi ? BFD_ENDIAN_LITTLE
+                                                 : BFD_ENDIAN_BIG;
 }
 
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.47.3


