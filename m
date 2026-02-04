Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC19DEA7940
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhcB-0004hG-Di; Wed, 04 Feb 2026 13:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhc9-0004XB-9V
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhc6-0001B0-HD
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso1564265e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229709; x=1770834509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqLml2nu/7VBJP0h6Mc9LYlhdezvxWpHGFDA8dt6ujc=;
 b=UW113SPEziHGfOLnF1GTHiSKRjqnDwEaR8BWudOKi9J8uxHPfePsyPIYFoPlNWWYan
 FecwjG4ONbin9/6JX5YNBm95snGz4W+BvZ8bDaw0q1cGGJEzNpY1wkuAuV1nF3S9MMnF
 A+PSz8cDhGSWCW5rax+w/F0bexFIhfp+dBOYRrbFxTiFM+EsyeAPNYfd2+wD/mntjJLc
 SLjMVmUmqwYy8OPsQ7BdoJLHBS0bJB3jtO0mppNlcgA4pVswdJYkAfAQmLIf4JHUFgFT
 LDepyP6me/n3W65fz96Oi/JOPIb/G/30wpENlGRV/sPwStnX8YkQVVxV5RpePMsv2NDd
 0fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229709; x=1770834509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aqLml2nu/7VBJP0h6Mc9LYlhdezvxWpHGFDA8dt6ujc=;
 b=w2OCgCzz407ZQrJAiLg2ycMZRUDer6ViwUqTKCjGPElIYWrNHSzsorOOizJ0LVuxno
 D6Z1O3SXUDKxYz7ijqhE6G3t9L+ZZEZgZ5KA8sHEIR6r6dc0TZVkrPt68EPCB/1tQZiG
 e7HEp6WruDk7e/oHg8r48YtVFreuzxYhp7OeXSaiY0iUk5mtskEtSGskTVg1VQmXsyAj
 InOObj0iSEV+eBYVk349duduLSlmNxGUUszTvv+kHdyJVbZio4O+zdrQNn4nOChcW5/Y
 ONdYWmNpHk8nkiz8ZEkfd11YDslfN2jwW5mmDVenIXUAiqrxhJk5L0a6nXlHwFPUayc9
 XjiA==
X-Gm-Message-State: AOJu0Yyhp+0NrT1b1xLqtJDePNkfpIYauTFeVj6BiFTjgxpTyyh35eT5
 WFt/gu6jtDxxh5fFmgQrl3oncTjgjHxqehPLcRF5QqL6T94CrwJLD57gU72pXZmYXp29bizm2V7
 D29PM98Q=
X-Gm-Gg: AZuq6aJcam9pchAMqF5KuoaDut/X6kA73x7jV+4Gpa+OEhePeIJ7dSuVM/w96BcKv12
 icKtPiRMZlk5Ds90yE7yd49lrma/B/XtI3QIKpS0/6g3vHUBSI7T1BQeYYrMiKmRXMszDi0+Q6b
 HVGgOG3DWKHbf5Hyc8LsWs/M1IHFZ287gBXZnxszE88fsirGMuH2XvSByVWtnLskzUYBCX3Ajfq
 Wm3c5jwx7v9er+MHCzNMXp68u8g8K19sC/HH/pysI10QMY4MZv90kibtPj/m850UHvhr6Q+M0kQ
 I1k9AL67F3v+tUmWJQSX/c+FR8rk/U3Zz1sVCKHHpuOqqoY2VgZcxgupzPcTQZGCZDpMId9ENZl
 yZkHYmpkje+UGRy2mP8F5Pfomt1Bez8gtOxGVZDGYhsdt+nlAEVhxEWcCbHCPXe24eeSdi9NFwI
 dzpwXW/HT0755SyZ1v6DthaMbztNQSyWU8fbTyxNciaFD8hS0VYOuBvqsUOE/uWIdmZyXtwTI=
X-Received: by 2002:a05:600c:5884:b0:47e:e97e:11aa with SMTP id
 5b1f17b1804b1-483178e11bcmr2891685e9.4.1770229708476; 
 Wed, 04 Feb 2026 10:28:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d355a9sm2018755e9.6.2026.02.04.10.28.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:28:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 9/9] target/s390x: Expand TCGv type as 64-bit target
Date: Wed,  4 Feb 2026 19:27:22 +0100
Message-ID: <20260204182722.44062-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204182722.44062-1-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The s390x target is a 64-bit one, so we have these expansions
in the "tcg/tcg-op.h" header:

 . tcg_gen_qemu_ld_tl() -> tcg_gen_qemu_ld_i64()
 . tcg_gen_qemu_st_tl() -> tcg_gen_qemu_st_i64()

Use the expanded form which is more explicit when a target
isn't built for different words size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


