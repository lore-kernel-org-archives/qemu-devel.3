Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93257C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU57-0005Y0-2C; Mon, 27 May 2024 02:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU3i-0003ds-5P; Mon, 27 May 2024 02:42:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU3V-0007PF-9e; Mon, 27 May 2024 02:42:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3D2826A3FB;
 Mon, 27 May 2024 09:41:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 88433D83F3;
 Mon, 27 May 2024 09:40:57 +0300 (MSK)
Received: (nullmailer pid 50298 invoked by uid 1000);
 Mon, 27 May 2024 06:40:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 13/19] target/i386: fix operand size for DATA16 REX.W
 POPCNT
Date: Mon, 27 May 2024 09:40:44 +0300
Message-Id: <20240527064056.50205-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
References: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

According to the manual, 32-bit vs 64-bit is governed by REX.W
and REX ignores the 0x66 prefix.  This can be confirmed with this
program:

    #include <stdio.h>
    int main()
    {
       int x = 0x12340000;
       int y;
       asm("popcntl %1, %0" : "=r" (y) : "r" (x)); printf("%x\n", y);
       asm("mov $-1, %0; .byte 0x66; popcntl %1, %0" : "+r" (y) : "r" (x)); printf("%x\n", y);
       asm("mov $-1, %0; .byte 0x66; popcntq %q1, %q0" : "+r" (y) : "r" (x)); printf("%x\n", y);
    }

which prints 5/ffff0000/5 on real hardware and 5/ffff0000/ffff0000
on QEMU.

Cc: qemu-stable@nongnu.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 41c685dc59bb611096f3bb6a663cfa82e4cba97b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2b0df7bcfa..c4016314fb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -415,16 +415,6 @@ static inline MemOp mo_stacksize(DisasContext *s)
     return CODE64(s) ? MO_64 : SS32(s) ? MO_32 : MO_16;
 }
 
-/* Select only size 64 else 32.  Used for SSE operand sizes.  */
-static inline MemOp mo_64_32(MemOp ot)
-{
-#ifdef TARGET_X86_64
-    return ot == MO_64 ? MO_64 : MO_32;
-#else
-    return MO_32;
-#endif
-}
-
 /* Select size 8 if lsb of B is clear, else OT.  Used for decoding
    byte vs word opcodes.  */
 static inline MemOp mo_b_d(int b, MemOp ot)
@@ -6788,12 +6778,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
-        if (s->prefix & PREFIX_DATA) {
-            ot = MO_16;
-        } else {
-            ot = mo_64_32(dflag);
-        }
-
+        ot = dflag;
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_extu(ot, s->T0);
         tcg_gen_mov_tl(cpu_cc_src, s->T0);
-- 
2.39.2


