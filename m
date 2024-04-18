Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D8C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVti-0008Au-0p; Thu, 18 Apr 2024 13:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtf-00089L-4h; Thu, 18 Apr 2024 13:50:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtd-0007RS-9i; Thu, 18 Apr 2024 13:50:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6AF5B5FD63;
 Thu, 18 Apr 2024 20:49:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A3461B9339;
 Thu, 18 Apr 2024 20:49:56 +0300 (MSK)
Received: (nullmailer pid 947812 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zack Buhman <zack@buhman.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 090/116] target/sh4: mac.w: memory accesses are 16-bit
 words
Date: Thu, 18 Apr 2024 20:49:20 +0300
Message-Id: <20240418174955.947730-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zack Buhman <zack@buhman.org>

Before this change, executing a code sequence such as:

           mova   tblm,r0
           mov    r0,r1
           mova   tbln,r0
           clrs
           clrmac
           mac.w  @r0+,@r1+
           mac.w  @r0+,@r1+

           .align 4
  tblm:    .word  0x1234
           .word  0x5678
  tbln:    .word  0x9abc
           .word  0xdefg

Does not result in correct behavior:

Expected behavior:
  first macw : macl = 0x1234 * 0x9abc + 0x0
               mach = 0x0

  second macw: macl = 0x5678 * 0xdefg + 0xb00a630
               mach = 0x0

Observed behavior (qemu-sh4eb, prior to this commit):

  first macw : macl = 0x5678 * 0xdefg + 0x0
               mach = 0x0

  second macw: (unaligned longword memory access, SIGBUS)

Various SH-4 ISA manuals also confirm that `mac.w` is a 16-bit word memory
access, not a 32-bit longword memory access.

Signed-off-by: Zack Buhman <zack@buhman.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240402093756.27466-1-zack@buhman.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit b0f2f2976b4db05351117b0440b32bf0aac2c5c6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 81f825f125..f3e08028f2 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -817,10 +817,10 @@ static void _decode_opc(DisasContext * ctx)
             TCGv arg0, arg1;
             arg0 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
-                                MO_TESL | MO_ALIGN);
+                                MO_TESW | MO_ALIGN);
             arg1 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
-                                MO_TESL | MO_ALIGN);
+                                MO_TESW | MO_ALIGN);
             gen_helper_macw(tcg_env, arg0, arg1);
             tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
             tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
-- 
2.39.2


