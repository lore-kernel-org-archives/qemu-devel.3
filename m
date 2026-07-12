Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4F6C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilhC-0003wo-EQ; Sun, 12 Jul 2026 00:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilh9-0003mG-W3; Sun, 12 Jul 2026 00:21:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilh8-0007BX-91; Sun, 12 Jul 2026 00:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=7sn6D8T0oh26eT6b9Kq8wyK87q1ciKICgmcw/SvJuVQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P6AkqhljPYp4MHYgTFm2HU2XIcQMeY954oxORYb/QK/TvGfMReCqQskdQKjKjwCkH
 eNLwEy3TnpySypTqFjfTEshwEjs9bL8wOZDKVJl7AiqJJo6V4McXUaxkht4hMlHjgM
 ThkEcCKqMQMOivdabUI8KGjd3HK2BMQjtmLAUAhWbUWpDwO+J39aLJ/IHRe8kmqlKp
 /wBXTskspBd36qlMn0kwDV9tTZeTSb/R5whvV7LP+4Hi22w7VUAHAE3XvaF+aVQVkK
 AEdlUXs8p/S6o1xiSD7I6eGEL9UUhhIk5ZkCj0Pjq1L2rwevA+KnN2l5lFksGZV0Lm
 f7mAt3ydDUPMA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 159F71C0C14;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 494D73EB974;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9BD0F1342B; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 57/75] tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
Date: Sun, 12 Jul 2026 07:15:15 +0300
Message-ID: <20260712041539.108341-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For NE we need to invert EQ, not swap operands.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3589
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260623140609.645445-1-richard.henderson@linaro.org>
(cherry picked from commit c56ebd64b82aa4d4a4e2144abbf9568ef593b836)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 879f66f2555..743a6838392 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2054,19 +2054,36 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                 default:
                     g_assert_not_reached();
                 }
-                break;
-            }
-
-            insn = cmp_vec_insn[cond][lasx][vece];
-            if (insn == 0) {
-                TCGArg t;
-                t = a1, a1 = a2, a2 = t;
-                cond = tcg_swap_cond(cond);
-                insn = cmp_vec_insn[cond][lasx][vece];
-                tcg_debug_assert(insn != 0);
+            } else {
+                switch (cond) {
+                case TCG_COND_EQ:
+                case TCG_COND_LE:
+                case TCG_COND_LEU:
+                case TCG_COND_LT:
+                case TCG_COND_LTU:
+                    insn = cmp_vec_insn[cond][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+                    break;
+                case TCG_COND_GE:
+                case TCG_COND_GEU:
+                case TCG_COND_GT:
+                case TCG_COND_GTU:
+                    insn = cmp_vec_insn[tcg_swap_cond(cond)][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a2, a1));
+                    break;
+                case TCG_COND_NE:
+                    /* ne -> not(eq) */
+                    insn = cmp_vec_insn[TCG_COND_EQ][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+                    insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a0, a0));
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
             }
         }
-        goto vdvjvk;
+        break;
     case INDEX_op_add_vec:
         tcg_out_addsub_vec(s, lasx, vece, a0, a1, a2, const_args[2], true);
         break;
-- 
2.47.3


