Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9930CCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI5-0005IC-LR; Mon, 11 May 2026 14:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHh-0004q0-9c
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:18 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHf-0002u7-BO
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:16 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbe437b072so2660690a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523794; x=1779128594; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l2xdv/V1omlS3DieDctnUu0Uqp28rBCjJPIXTe0N9uY=;
 b=ijIEYLWzfET8aen0OUEqU8vKnRr6MujHcbUMj6ZMf3H+UEOeTwW3d0SqcSxOMCxmXI
 LrR1KQeKHqXIx4NhLZ4yMwLipTSnBJ1+0u+0Ze+xdJV/9PugLgMB6NTW4BDkCD5z+b9D
 WCD+vc0snAtEb4ZCh/3tkLDtszl5zDyAyik572+j5azr27lR458ZztAIl/DRKLu3C4Q9
 G7HBOI1fkGTE2d5ZHU3VXS1zFhg8hfJTijNalpA3zlPF4ts+ahr8tcoCqvtshh7QFeOJ
 vbfQocpC/jsJeGaskCsUFtzSQpLwv0eJIaBFS4Hm9off0BukzBvRuqvQcGxCdusFzpPD
 vybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523794; x=1779128594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l2xdv/V1omlS3DieDctnUu0Uqp28rBCjJPIXTe0N9uY=;
 b=MJ/wWIi7LfjiPyK5L3/63lJYMM+I8Qdpojaudk/apxs+I3S6VHubjOxTNQ4INoN03P
 VeOTqDOG0hr6IWB0rVKYHM7674vOsqiHTY4Pdm00VrvWziWbUbJtlgFTu4agmUs4zwq3
 nuyHAFbZ6nksJpTqrLAJL22y7lnesJEmiwwG4falB966vKOsEyXTRH2ldwPTvFjHPgOe
 RmXAlWohuuJdCG15W6BMAhwGDYN+SopUMc6uUpdkEQAhRsZwE/XSgVDwbYp7sGu6rUdF
 YrZQzj7Ber5g1fXi0Ehq2h5jELZVplEtueJIQfz5frHpKl7ji6hleT0zq0Sh6eUjgcyo
 IVcw==
X-Gm-Message-State: AOJu0Yx8G/P68A+tTnWMNFKYy85plkofAD/hw5v5x6eVyiG9vT+et4Zu
 4BcjnNY61gWu+2ev/cm2SCYH588TyX3/qkm1h0QKS76YbdLZ5rEaBGN3
X-Gm-Gg: Acq92OEEukBJVsuL+mFJruUI7XQWln42cJCn1E8fHJNVA8VUbHr96cN13JrGDNZ1uMs
 10v/mEcH/p1REavX+RbDghBxuhzYScYY9zs6+7I20ymc7raWRqNCwbtaaWxLd0b2On+3t+HiBTJ
 OGYJZwdbxtoZJsttr17SRUHvhOvqCL7oRvVxBQvvKsKFYoGQUoNAnTpyp6DAsLA5YV03DJ3AG5+
 e0PESRvoV5OTTCueqAl3usboGKcKsKtAbUhuOUlqTOUpxOozYx02/Fzel6Iwe9opwQu0bGwpKMy
 Zjl0HBCbDP/mSaWHbTDkE4Yk+0e8RTlm65XW0GBwvKxpgF2Tp76jhn0ahQ8Vt1oUcnsR2lk3o9v
 Cr0BMJfHAlwAW+AADM/zKfn5ao4+Fa9TMANsgaRx3sbiFfxi9Twfd9ETsNbS++napqOHUcntsui
 3tJDIHF1JCqk1yiKdHlXd6io6l94xtLerQKFDV2+kuhmCVqfJUxzbRdH9TFO/5AIN88rWpN25/o
 6zopLPlc+7WAzrMwIDw8vJaipjll73Ru6N+xLXmqWCPDGiYrj7ViMgakZjYQt3PVjgd
X-Received: by 2002:a05:6830:378a:b0:7dc:cdea:7d9 with SMTP id
 46e09a7af769-7e1df072f91mr14270527a34.22.1778523794165; 
 Mon, 11 May 2026 11:23:14 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:55 -0600
Subject: [PATCH v6 24/35] target/mips: add Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-24-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

QMAC.0x and QMACS.0x multiply the selected signed Q15 halfword lane
from rs by rt<15:0> and accumulate the Q31 product into the Octeon
HI/LO accumulator state.

QMAC updates the full 64-bit HI/LO accumulator. QMACS saturates the
32-bit Q31 result in LO and keeps HI<0> as the sticky saturation flag.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/helper.h               |  2 ++
 target/mips/tcg/octeon.decode      |  5 ++++
 target/mips/tcg/octeon_translate.c | 16 +++++++++++
 target/mips/tcg/op_helper.c        | 59 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 08fda55ae1..e93bc37903 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,6 +27,8 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
 DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
 DEF_HELPER_3(octeon_v3mulu, i64, env, i64, i64)
+DEF_HELPER_4(octeon_qmac, void, env, i64, i64, i32)
+DEF_HELPER_4(octeon_qmacs, void, env, i64, i64, i32)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 9c1fe8f4f1..5edcd95884 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -28,9 +28,12 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SEQI rt, rs, immediate
 # SNE rd, rs, rt
 # SNEI rt, rs, immediate
+# QMAC.0x rs, rt
+# QMACS.0x rs, rt
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
 &cmpi        rs rt imm
+&qmac        rs rt lane
 %bitfield_p  0:1 6:5
 @bitfield    ...... rs:5 rt:5 lenm1:5 ..... ..... . p=%bitfield_p
 
@@ -43,6 +46,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
+QMACS        011100 rs:5 rt:5 00000 000 lane:2 010010 &qmac
+QMAC         011100 rs:5 rt:5 00000 100 lane:2 010010 &qmac
 &r2          rs rt
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 2d836afddb..b41bc1f81e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -14,6 +14,8 @@
 #include "decode-octeon.c.inc"
 
 typedef void gen_helper_octeon_vmul(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
+typedef void gen_helper_octeon_qmac_fn(TCGv_ptr, TCGv_i64, TCGv_i64,
+                                       TCGv_i32);
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
@@ -156,6 +158,18 @@ static bool trans_SNEI(DisasContext *ctx, arg_SNEI *a)
     return do_seqi_snei(ctx, a, TCG_COND_NE);
 }
 
+static bool trans_qmac(DisasContext *ctx, arg_qmac *a,
+                       gen_helper_octeon_qmac_fn *helper)
+{
+    TCGv_i64 rs = tcg_temp_new_i64();
+    TCGv_i64 rt = tcg_temp_new_i64();
+
+    gen_load_gpr(rs, a->rs);
+    gen_load_gpr(rt, a->rt);
+    helper(tcg_env, rs, rt, tcg_constant_i32(a->lane));
+    return true;
+}
+
 static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 {
     gen_lx(ctx, a->rd, a->base, a->index, mop);
@@ -299,6 +313,8 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
 
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
+TRANS(QMAC,  trans_qmac, gen_helper_octeon_qmac);
+TRANS(QMACS, trans_qmac, gen_helper_octeon_qmacs);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 740c181d27..0a892e31a8 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -144,6 +144,65 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
 
+static int32_t octeon_mul_q15_q15(int16_t a, int16_t b, bool *overflow)
+{
+    if (a == INT16_MIN && b == INT16_MIN) {
+        *overflow = true;
+        return INT32_MAX;
+    }
+    return (int32_t)a * b * 2;
+}
+
+static int32_t octeon_sat32_acc_q31(int32_t acc, int32_t value,
+                                    bool *overflow)
+{
+    int64_t sum = (int64_t)acc + value;
+
+    if (sum > INT32_MAX) {
+        *overflow = true;
+        return INT32_MAX;
+    }
+    if (sum < INT32_MIN) {
+        *overflow = true;
+        return INT32_MIN;
+    }
+    return sum;
+}
+
+static int16_t octeon_qmac_lane(uint64_t rs, uint32_t lane)
+{
+    return (int16_t)(uint16_t)extract64(rs, lane * 16, 16);
+}
+
+void helper_octeon_qmac(CPUMIPSState *env, uint64_t rs, uint64_t rt,
+                        uint32_t lane)
+{
+    bool overflow = false;
+    int32_t product;
+    int64_t acc;
+
+    product = octeon_mul_q15_q15((int16_t)(uint16_t)rt,
+                                 octeon_qmac_lane(rs, lane), &overflow);
+    acc = deposit64(env->active_tc.LO[0], 32, 32, env->active_tc.HI[0]);
+    acc += product;
+
+    env->active_tc.LO[0] = (int64_t)(int32_t)acc;
+    env->active_tc.HI[0] = (int64_t)(int32_t)((uint64_t)acc >> 32);
+}
+
+void helper_octeon_qmacs(CPUMIPSState *env, uint64_t rs, uint64_t rt,
+                         uint32_t lane)
+{
+    bool overflow = env->active_tc.HI[0] & 1;
+    int32_t product;
+
+    product = octeon_mul_q15_q15((int16_t)(uint16_t)rt,
+                                 octeon_qmac_lane(rs, lane), &overflow);
+    env->active_tc.LO[0] = octeon_sat32_acc_q31(
+        (int32_t)(uint32_t)env->active_tc.LO[0], product, &overflow);
+    env->active_tc.HI[0] = overflow;
+}
+
 static void octeon_add_limb(uint64_t *sum, int limb_count,
                             uint64_t value, int limb)
 {

-- 
2.54.0


