Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92330CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNT-0003Tp-7u; Wed, 10 Apr 2024 03:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMW-0001qC-Pv; Wed, 10 Apr 2024 03:27:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMU-0004o5-UH; Wed, 10 Apr 2024 03:27:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA0145D69F;
 Wed, 10 Apr 2024 10:25:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7DF1AB02DF;
 Wed, 10 Apr 2024 10:23:07 +0300 (MSK)
Received: (nullmailer pid 4191789 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 47/87] target/hppa: exit tb on flush cache instructions
Date: Wed, 10 Apr 2024 10:22:20 +0300
Message-Id: <20240410072303.4191455-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Sven Schnelle <svens@stackframe.org>

When the guest modifies the tb it is currently executing from,
it executes a fic instruction. Exit the tb on such instruction,
otherwise we might execute stale code.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20240319161921.487080-5-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit ad1fdacd1b936557514dd72c2079a80be0c2dfb4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 5412ff9836..f58455dfdb 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -144,9 +144,9 @@ getshadowregs   1111 1111 1111 1101 1110 1010 1101 0010
 nop             000001 ----- ----- -- 11001010 0 -----         # fdc, disp
 nop_addrx       000001 ..... ..... -- 01001010 . -----  @addrx # fdc, index
 nop_addrx       000001 ..... ..... -- 01001011 . -----  @addrx # fdce
-nop_addrx       000001 ..... ..... --- 0001010 . -----  @addrx # fic 0x0a
-nop_addrx       000001 ..... ..... -- 01001111 . 00000  @addrx # fic 0x4f
-nop_addrx       000001 ..... ..... --- 0001011 . -----  @addrx # fice
+fic             000001 ..... ..... --- 0001010 . -----  @addrx # fic 0x0a
+fic             000001 ..... ..... -- 01001111 . 00000  @addrx # fic 0x4f
+fic             000001 ..... ..... --- 0001011 . -----  @addrx # fice
 nop_addrx       000001 ..... ..... -- 01001110 . 00000  @addrx # pdc
 
 probe           000001 b:5 ri:5 sp:2 imm:1 100011 write:1 0 t:5
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 15a8bfd48c..ccf03b1ce7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2337,6 +2337,13 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
     return true;
 }
 
+static bool trans_fic(DisasContext *ctx, arg_ldst *a)
+{
+    /* End TB for flush instruction cache, so we pick up new insns. */
+    ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    return trans_nop_addrx(ctx, a);
+}
+
 static bool trans_probe(DisasContext *ctx, arg_probe *a)
 {
     TCGv_i64 dest, ofs;
-- 
2.39.2


