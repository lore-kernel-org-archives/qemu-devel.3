Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE52C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxW8-0004Ee-Mh; Mon, 17 Aug 2026 09:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxW4-0004CN-P9; Mon, 17 Aug 2026 09:36:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxW0-0007QK-Sq; Mon, 17 Aug 2026 09:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=0z2aPcbsxoidpzPxhzUDXO5Cly3EPPu7ADnQ5pCGkPI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RwvQbDCGoAPHLku6hjERqVeWpPwn8ynGpI6qAt5Z/yzfX7V1HLwaORFA2909w+ttg
 sH3TVbLfhGqvio09c1uoC0z69ghmq/qVC5X+/a67NY1jo/H9qar6FoXU3Ik0FvhV5F
 seZP9q6haVq9mHBxrK05OxIfpAt2PqY8GluSaj4/BMTAulPFzU4ALf9XdqkBXhughB
 L1jboV0ShBszapm44NGMfWGj4m/AeCZ8VmBi68Leu4AlL8bOB5jY47Vjo2Ja0S4uTK
 TvlouRWX35XJ5p+NCL56BN+NwnllxfZqINpNsJgTo+o12WNTylOvRu+s/5iOmX2niw
 uiyf0d6WUR0WQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4495D1CBCC4;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F67540D421;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B2C6830F92; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ido Plat <Ido.Plat1@ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 117/135] target/s390x/tcg: Set STCK/STCKF
 condition code after the store
Date: Mon, 17 Aug 2026 16:34:27 +0300
Message-ID: <20260817133451.2384630-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

STORE CLOCK [FAST] to an inaccessible address aborts QEMU:

  $ qemu-s390x ./stckf
  ERROR:cc_helper.c:128:cc_calc_addu: assertion failed: (carry_out <= 1)

op_stck() sets the condition code with gen_op_movi_cc() before the
output operand store, which is deferred to wout_m1_64(). Assigning a
constant condition code discards the lazy CC values, so the optimizer
drops the writes that produced them. When the store then raises an
exception, the instruction is suppressed and
s390x_restore_state_to_opc() reinstates the cc_op recorded at the start
of STCK[F], but cc_src/cc_dst now hold stale values, so the next
condition code evaluation reads garbage.

Fix by performing the store manually. The alternative of not discarding
in gen_op_movi_cc() keeps the inputs live, but results in less optimal
code.

Reported-by: Ido Plat <Ido.Plat1@ibm.com>
Fixes: 434c91a5f4ed ("target-s390: Convert STCK")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260714203206.363028-2-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 2c32c273da6d4ecead76441adf96cb685f31df3c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index ec730ee0919..bd3fa8d6a5a 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -884,8 +884,8 @@
     C(0xe32f, STRVG,   RXY_a, Z,   la2, r1_o, new, m1_64, rev64, 0)
 
 /* STORE CLOCK */
-    F(0xb205, STCK,    S,     Z,   la2, 0, new, m1_64, stck, 0, IF_IO)
-    F(0xb27c, STCKF,   S,     SCF, la2, 0, new, m1_64, stck, 0, IF_IO)
+    F(0xb205, STCK,    S,     Z,   la2, 0, new, 0, stck, 0, IF_IO)
+    F(0xb27c, STCKF,   S,     SCF, la2, 0, new, 0, stck, 0, IF_IO)
 /* STORE CLOCK EXTENDED */
     F(0xb278, STCKE,   S,     Z,   0, a2, 0, 0, stcke, 0, IF_IO)
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 6aa1f30d587..68c7acaabcc 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4085,7 +4085,9 @@ static DisasJumpType op_stap(DisasContext *s, DisasOps *o)
 static DisasJumpType op_stck(DisasContext *s, DisasOps *o)
 {
     gen_helper_stck(o->out, tcg_env);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUQ);
     /* ??? We don't implement clock states.  */
+    /* Set the CC after the store; a suppressed store must preserve it. */
     gen_op_movi_cc(s, 0);
     return DISAS_NEXT;
 }
-- 
2.47.3


