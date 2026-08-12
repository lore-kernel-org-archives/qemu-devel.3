Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3106BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuARD-0002WH-Eq; Wed, 12 Aug 2026 11:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQb-0001bF-MD; Wed, 12 Aug 2026 10:59:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQY-0001hG-SF; Wed, 12 Aug 2026 10:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=pdpS/IWN7p2uqConUGhBNy/5z/AS4Yn3/zP+k4cVf2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MfnSJ8ILUUfiueI/xyqqIb684CzjMuwRN8RgoqF0UZIa2dLidzO4fseDnyI6wwsQO
 Tr5Pd07pCqShaRUXdDGIiLK5RxHGUeZZK7ir67rwTsFeGmV0WrRcNzb+suRO2hrdhx
 midFWeH6HBQ3Oesqr0fO2ssodQK9N0UyWwzZ0SIIYgU3GzXLaZ7PmlVq+Ss4Tx86dZ
 U1+85cIEkV6N8+wjYqFFB8ERJyWSPr89sExxXvkJ6dXfLdattRNkb5VNKpZBKzRCJ1
 JuydVbJPuptjb0Dcw/O8hT7xWzrD5z8E1YEHWu1nsysYByvodUmqyS1woGearhyvNF
 Ft2/e7H9rdQ6w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C14A1CA65E;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A7266409DA0;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1106A2FA17; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Christian Quante <christian@quante.one>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 090/120] target/i386: Update cc_op for SAHF
Date: Wed, 12 Aug 2026 17:49:13 +0300
Message-ID: <20260812144955.649205-90-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

Removing the call to gen_compute_eflags meant we no longer
updated cc_op after computing EFLAGS.

Cc: qemu-stable@nongnu.org
Fixes: da7649c6aeef ("target/i386/tcg: do not compute all flags for SAHF")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3537
Tested-by: Christian Quante <christian@quante.one>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit c25f69595ad052473463540f4d7944b9b73e94ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 8eca66b6967..8c2191595c2 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3774,10 +3774,13 @@ static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
         return gen_illegal_opcode(s);
     }
     tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
-    gen_neg_setcc(s, JCC_O << 1, cpu_cc_src);
-    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
+    gen_neg_setcc(s, JCC_O << 1, s->T1);
+    tcg_gen_andi_tl(s->T1, s->T1, CC_O);
     tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
-    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
+    tcg_gen_or_tl(s->T0, s->T0, s->T1);
+
+    decode->cc_src = s->T0;
+    decode->cc_op = CC_OP_EFLAGS;
 }
 
 static void gen_SALC(DisasContext *s, X86DecodedInsn *decode)
-- 
2.47.3


