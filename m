Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A9CC47DA9
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9KB-00068j-LD; Sun, 28 Jan 2024 12:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9J3-0002z9-SC; Sun, 28 Jan 2024 12:51:00 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9J2-0000ov-8T; Sun, 28 Jan 2024 12:50:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A0D2F4810A;
 Sun, 28 Jan 2024 20:51:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 315C26D526;
 Sun, 28 Jan 2024 20:50:40 +0300 (MSK)
Received: (nullmailer pid 812422 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Vineet Gupta <vineetg@rivosinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 61/71] linux-user/riscv: Adjust vdso signal frame cfa
 offsets
Date: Sun, 28 Jan 2024 20:50:24 +0300
Message-Id: <20240128175035.812352-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

A typo in sizeof_reg put the registers at the wrong offset.

Simplify the expressions to use positive addresses from the
start of uc_mcontext instead of negative addresses from the
end of uc_mcontext.

Reported-by: Vineet Gupta <vineetg@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 1b21fe27e75a59bfe2513f5abcc6a18cfc35cfc8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
index 1ad1e5cbbb..c2ce2a4757 100755
Binary files a/linux-user/riscv/vdso-32.so and b/linux-user/riscv/vdso-32.so differ
diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
index 83992bebe6..ae49f5b043 100755
Binary files a/linux-user/riscv/vdso-64.so and b/linux-user/riscv/vdso-64.so differ
diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
index a86d8fc488..c37275233a 100644
--- a/linux-user/riscv/vdso.S
+++ b/linux-user/riscv/vdso.S
@@ -101,12 +101,12 @@ endf __vdso_flush_icache
 	.cfi_startproc simple
 	.cfi_signal_frame
 
-#define sizeof_reg	(__riscv_xlen / 4)
+#define sizeof_reg	(__riscv_xlen / 8)
 #define sizeof_freg	8
-#define B_GR	(offsetof_uc_mcontext - sizeof_rt_sigframe)
-#define B_FR	(offsetof_uc_mcontext - sizeof_rt_sigframe + offsetof_freg0)
+#define B_GR	0
+#define B_FR	offsetof_freg0
 
-	.cfi_def_cfa	2, sizeof_rt_sigframe
+	.cfi_def_cfa	2, offsetof_uc_mcontext
 
 	/* Return address */
 	.cfi_return_column 64
-- 
2.39.2


