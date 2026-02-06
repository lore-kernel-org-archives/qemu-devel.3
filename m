Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F82EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQS7-00089Q-J7; Fri, 06 Feb 2026 13:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQS5-00082q-T9
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:21:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQS4-0005Av-0g
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:21:09 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso28823195e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402065; x=1771006865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzES1qng8rWM3+acoSyUBkVai5xaMJnvu2yQlPPQ03I=;
 b=uI4jHFXIxSCp20HFnl59aShDpoIewDYJQlCY/S+khBDNFxwXd54TfzPXUr94rAmAPo
 9FFzNp/ihrAbPeuibSMEGU72FuzkO4QrL0jEsQNRFJLb6eu2/Y7SMd38fCiwg5DSYssW
 0Ki/PIFeAV4RmxTwKruQP5lokUfq8GbCBMf809DsA2bSCbaB7Dy0AmauoujJ+XoRR2gj
 lhdzrenCHZFVUpVpilmbchVg6rWkhxnika9RdMVkhkyOwDVFPjb18Aod8yPzxkaBs94e
 P5tWFUXxE06io14tSdtNxNtN9+BqCxbImsGWh0eQbW1QgxEAqmgAOhpgD40h7zvrgumz
 9jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402065; x=1771006865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wzES1qng8rWM3+acoSyUBkVai5xaMJnvu2yQlPPQ03I=;
 b=ksC8+XfbB1z5eXbxTTqyBBsGoz42blbS5CrOjShYTQhiXCWeH3maQWGYr5/gR/bMt1
 hKeKCi3/nCfN2pP4KRitJz85Bw93UJpdh3xSW/7/U/8Atu8JhbAF5T0kC1Rw63KR2BGE
 TCtMI9KnSA9iMXL403SlAc8dbN3HWDwJKnbWy61Jb/VpNc2NTmhuo10DSCKSipSGaL2B
 Z8K/3km1UjXZrbiANALS5kwyDR4JoliAEav+HtbVBC5C6Hg6dzS6/24F4MMwgGYwo/Sc
 TckqjERzfOJWpicXlaI7tegT7CXtNfUBf5V51+Of7pXvXZ8suMxwx6kAKBi3JgBhw3cg
 m/0w==
X-Gm-Message-State: AOJu0YzlH4hw7BgCfziqYfz4zGe143SlsywBy12qQSbYFw7YhfOJNprS
 dqd0OxR5diI+gZLiA6tYp/1YaD0IspCv8hNxsuu9qmsrxnVz6450QXXoChSrcL2dOLRGj+Mj8wO
 saF5fFAU=
X-Gm-Gg: AZuq6aKt4rbKpgyuEsLpNgvYaQAYKG3f3/cfSJjpBHnYjT/flitF+RN5JINECm1QggV
 1wFlLqwIBvbDMQaWCaMkixRLiGByKqPBughl5l4DcW3R1KeMBFSuidcDFGz1hnq/kWiod15f+gT
 u45GUaPXNeQLlgO6hZ5qToCyS1CgV9iOPmLFNV8K/gEaLQwl2igd9adw4NFR/yTAK1s34ZkWb5c
 m4fnbsZHL640zWcFDYvHSHmtIYDQUNHi2Ag8eS07/vuvwkAtBkQFqclMhoQvz1iUdcfclzG3AO1
 DohuMNV7hRnxrGiiiIdfpRVVP4Rwme2bsI/M0nWdbRbO0rd4b30to9JRsY0pOAUQpMwhwkWeYMC
 y1vZ2LSy8p5xoJbhYZ0mAWX3g+3zONAyTJnBRehOkFdumNYUSWE6CSFQNvoss4Y21cK+f0Nbvxc
 HFEohMGqeq2u3/nGzM0BnjWsjkQfvp4P57WQcHvdMuRf26kX3pX358ikkw0GH8OjTuRz2dXqQ=
X-Received: by 2002:a05:6000:2210:b0:435:92c6:d556 with SMTP id
 ffacd0b85a97d-4362933ec62mr6116926f8f.16.1770402065436; 
 Fri, 06 Feb 2026 10:21:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd1bcsm6372721f8f.12.2026.02.06.10.21.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:21:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/10] target/s390x: Expand tcg_gen_qemu_ld/st_tl() as
 64-bit target
Date: Fri,  6 Feb 2026 19:19:52 +0100
Message-ID: <20260206181953.18683-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The s390x target is a 64-bit one, so we have these expansions
in the "tcg/tcg-op.h" header:

 . tcg_gen_qemu_ld_tl() -> tcg_gen_qemu_ld_i64()
 . tcg_gen_qemu_st_tl() -> tcg_gen_qemu_st_i64()

Use the expanded form which is more explicit when a target
isn't built for different words size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 54 ++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 437f5a4aeb7..4dabd49840f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1259,7 +1259,7 @@ static DisasJumpType op_asi(DisasContext *s, DisasOps *o)
 
     o->in1 = tcg_temp_new_i64();
     if (non_atomic) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic addition in memory. */
         tcg_gen_atomic_fetch_add_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -1270,7 +1270,7 @@ static DisasJumpType op_asi(DisasContext *s, DisasOps *o)
     tcg_gen_add_i64(o->out, o->in1, o->in2);
 
     if (non_atomic) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -1281,7 +1281,7 @@ static DisasJumpType op_asiu64(DisasContext *s, DisasOps *o)
 
     o->in1 = tcg_temp_new_i64();
     if (non_atomic) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic addition in memory. */
         tcg_gen_atomic_fetch_add_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -1293,7 +1293,7 @@ static DisasJumpType op_asiu64(DisasContext *s, DisasOps *o)
     tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
 
     if (non_atomic) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -1374,7 +1374,7 @@ static DisasJumpType op_ni(DisasContext *s, DisasOps *o)
     o->in1 = tcg_temp_new_i64();
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic operation in memory. */
         tcg_gen_atomic_fetch_and_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -1385,7 +1385,7 @@ static DisasJumpType op_ni(DisasContext *s, DisasOps *o)
     tcg_gen_and_i64(o->out, o->in1, o->in2);
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -1917,8 +1917,8 @@ static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
         mop = ctz32(l + 1) | MO_BE;
         /* Do not update cc_src yet: loading cc_dst may cause an exception. */
         src = tcg_temp_new_i64();
-        tcg_gen_qemu_ld_tl(src, o->addr1, get_mem_index(s), mop);
-        tcg_gen_qemu_ld_tl(cc_dst, o->in2, get_mem_index(s), mop);
+        tcg_gen_qemu_ld_i64(src, o->addr1, get_mem_index(s), mop);
+        tcg_gen_qemu_ld_i64(cc_dst, o->in2, get_mem_index(s), mop);
         gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, src, cc_dst);
         return DISAS_NEXT;
     default:
@@ -2747,15 +2747,15 @@ static DisasJumpType op_ld16u(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_ld32s(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_tl(o->out, o->in2, get_mem_index(s),
-                       MO_BESL | s->insn->data);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
+                        MO_BESL | s->insn->data);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ld32u(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_tl(o->out, o->in2, get_mem_index(s),
-                       MO_BEUL | s->insn->data);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
+                        MO_BEUL | s->insn->data);
     return DISAS_NEXT;
 }
 
@@ -3087,7 +3087,7 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_tl(o->out, o->in2, MMU_REAL_IDX, s->insn->data);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, MMU_REAL_IDX, s->insn->data);
     return DISAS_NEXT;
 }
 #endif
@@ -3506,7 +3506,7 @@ static DisasJumpType op_oi(DisasContext *s, DisasOps *o)
     o->in1 = tcg_temp_new_i64();
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic operation in memory. */
         tcg_gen_atomic_fetch_or_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -3517,7 +3517,7 @@ static DisasJumpType op_oi(DisasContext *s, DisasOps *o)
     tcg_gen_or_i64(o->out, o->in1, o->in2);
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -4334,7 +4334,7 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->in1, o->in2, MMU_REAL_IDX, s->insn->data);
+    tcg_gen_qemu_st_i64(o->in1, o->in2, MMU_REAL_IDX, s->insn->data);
 
     if (s->base.tb->flags & FLAG_MASK_PER_STORE_REAL) {
         update_cc_op(s);
@@ -4367,8 +4367,8 @@ static DisasJumpType op_st16(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_st32(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->in1, o->in2, get_mem_index(s),
-                       MO_BEUL | s->insn->data);
+    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
+                        MO_BEUL | s->insn->data);
     return DISAS_NEXT;
 }
 
@@ -4836,7 +4836,7 @@ static DisasJumpType op_xi(DisasContext *s, DisasOps *o)
     o->in1 = tcg_temp_new_i64();
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic operation in memory. */
         tcg_gen_atomic_fetch_xor_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -4847,7 +4847,7 @@ static DisasJumpType op_xi(DisasContext *s, DisasOps *o)
     tcg_gen_xor_i64(o->out, o->in1, o->in2);
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -5291,7 +5291,7 @@ static void wout_m1_16(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static void wout_m1_16a(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_BEUW | MO_ALIGN);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUW | MO_ALIGN);
 }
 #define SPEC_wout_m1_16a 0
 #endif
@@ -5305,7 +5305,7 @@ static void wout_m1_32(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static void wout_m1_32a(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_BEUL | MO_ALIGN);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUL | MO_ALIGN);
 }
 #define SPEC_wout_m1_32a 0
 #endif
@@ -5816,7 +5816,7 @@ static void in2_m2_32u(DisasContext *s, DisasOps *o)
 static void in2_m2_32ua(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_BEUL | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUL | MO_ALIGN);
 }
 #define SPEC_in2_m2_32ua 0
 #endif
@@ -5862,16 +5862,16 @@ static void in2_mri2_16u(DisasContext *s, DisasOps *o)
 static void in2_mri2_32s(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_tl(o->in2, gen_ri2(s), get_mem_index(s),
-                       MO_BESL | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s),
+                        MO_BESL | MO_ALIGN);
 }
 #define SPEC_in2_mri2_32s 0
 
 static void in2_mri2_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_tl(o->in2, gen_ri2(s), get_mem_index(s),
-                       MO_BEUL | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s),
+                        MO_BEUL | MO_ALIGN);
 }
 #define SPEC_in2_mri2_32u 0
 
-- 
2.52.0


