Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279AAC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 10:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDi65-0004LB-LB; Sun, 02 Jun 2024 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixinyu20s@ict.ac.cn>)
 id 1sDi61-0004K5-Ry
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 06:05:50 -0400
Received: from smtp84.cstnet.cn ([159.226.251.84] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lixinyu20s@ict.ac.cn>)
 id 1sDi5z-0001Ns-3S
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 06:05:49 -0400
Received: from lxy-MS-7D25.loongson.cn (unknown [114.242.206.180])
 by APP-05 (Coremail) with SMTP id zQCowACnNBLoQ1xmCG3sDg--.50475S2;
 Sun, 02 Jun 2024 18:05:28 +0800 (CST)
From: lixinyu20s@ict.ac.cn
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 Xinyu Li <lixinyu@loongson.cn>, Xinyu Li <lixinyu20s@ict.ac.cn>
Subject: [PATCH] target/i386: fix memory opsize for Mov to/from Seg
Date: Sun,  2 Jun 2024 18:05:28 +0800
Message-Id: <20240602100528.2135717-1-lixinyu20s@ict.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnNBLoQ1xmCG3sDg--.50475S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1rXry5WryrZr4xWF17ZFb_yoW5JF45pF
 9rCry8trs7ZFW8A34fCF4DJr1UJwn5KF4Ik3WSvrs5XF93tw1Yq3WYvr4kWFyrAay8K34x
 twn09rW7Aay8JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeEfOUUUUU
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: pol0x0t1xsi2g6lf3hldfou0/
Received-SPF: pass client-ip=159.226.251.84; envelope-from=lixinyu20s@ict.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Xinyu Li <lixinyu@loongson.cn>

This commit fixes an issue with MOV instructions (0x8C and 0x8E)
involving segment registers by explicitly setting the memory operand
size to 16 bits. It introduces a new flag X86_SPECIAL_MovSeg to handle
this specification correctly.

Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>
---
 target/i386/tcg/decode-new.c.inc | 12 ++++++++++--
 target/i386/tcg/decode-new.h     |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0ec849b003..ab7dbb45f9 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -202,6 +202,7 @@
 #define avx_movx .special = X86_SPECIAL_AVXExtMov,
 #define sextT0 .special = X86_SPECIAL_SExtT0,
 #define zextT0 .special = X86_SPECIAL_ZExtT0,
+#define movseg .special = X86_SPECIAL_MovSeg,
 
 #define vex1 .vex_class = 1,
 #define vex1_rep3 .vex_class = 1, .vex_special = X86_VEX_REPScalar,
@@ -1576,9 +1577,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0x89] = X86_OP_ENTRY3(MOV, E,v, G,v, None, None),
     [0x8A] = X86_OP_ENTRY3(MOV, G,b, E,b, None, None),
     [0x8B] = X86_OP_ENTRY3(MOV, G,v, E,v, None, None),
-    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None),
+    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None, movseg),
     [0x8D] = X86_OP_ENTRY3(LEA, G,v, M,v, None, None, noseg),
-    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,v, None, None),
+    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,v, None, None, movseg),
     [0x8F] = X86_OP_GROUPw(group1A, E,v),
 
     [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
@@ -2514,6 +2515,13 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         s->override = -1;
         break;
 
+    case X86_SPECIAL_MovSeg:
+        if (decode.op[0].unit == X86_OP_INT && decode.op[0].has_ea) {
+            decode.op[0].ot = MO_16;
+        } else if (decode.op[1].unit == X86_OP_INT && decode.op[1].has_ea) {
+            decode.op[1].ot = MO_16;
+        }
+
     default:
         break;
     }
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 51ef0e621b..f29f5de7d1 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -203,6 +203,8 @@ typedef enum X86InsnSpecial {
     /* When loaded into s->T0, register operand 1 is zero/sign extended.  */
     X86_SPECIAL_SExtT0,
     X86_SPECIAL_ZExtT0,
+    /* Memory operand size of Mov to/from Seg is MO_16 */
+    X86_SPECIAL_MovSeg,
 } X86InsnSpecial;
 
 /*
-- 
2.34.1


