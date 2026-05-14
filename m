Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FC4CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa20-0001hY-Hv; Thu, 14 May 2026 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa18-0000tO-Qy
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa11-00044N-Ef
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:38 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e36bb16a92so3543297a34.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780297; x=1779385097; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OOQNSVDXETD0OLv+e8ch0YmX2+eDo5mSilihDkBflZ8=;
 b=gn0Rr21jV36QYafM+Z4KNMLErMrsHns302teK8gb9IYIRG2Ex4tb2CVCiuLvTbWNGE
 23Qa8LMI4t1h/Maoat6l7SfJU9qRB604d2x1x//NAnbmEaMcKSXG7hkkbuRIcnqLhh+u
 k3mU86Z5q/urJjd99yzl9vBXyN8vH0HPcz9JNrA+gNguBYMrPJZ1tly1+NzdaS/NyrpO
 l3qDitK1o5TZG156LcMroznC6T3pF8Xtx5rZc7m1NfyHSsHql1KfFC7zXgoDYiL2I6Lo
 xFBZVjGXppBdgZZQuOChZs1P42m8koucGdQHepQhIzQuTZAfg7kDFr8ryIzN1KUHND4W
 glHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780297; x=1779385097;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OOQNSVDXETD0OLv+e8ch0YmX2+eDo5mSilihDkBflZ8=;
 b=ML2t60qSYZZJ+Yus4Dl1v2UKktohJvkW7+4kuL6u1/3CFksweMAf1kwvKZWoLVgWcd
 3oyS3RoQrzUXc35kkjcT8aIbq/xucEACd/j2qxy8y3svmZEI/TgtxjDF7NRK5imo2GwW
 OQqc8gClS3ikJ5bjVHDNF1zgU3HjJFKTXW+TAsfI7Ic9vC1E/HRLedk1fOPouUYKjeBQ
 ZpvUb0e9WzcdtsvcASUcygKgA+I90CGiLD+itcVBcDa2O17hM56bUrxB4/MKJJ/c0mYR
 E8cMiDXnFJLZRvZxBo8g+No/+cd5deyVeK47KO9vYnb1j2XgVgWIqf/gFVH8BNspNfFV
 2Etg==
X-Gm-Message-State: AOJu0Yym4Uet5Qhach+FLzWIRdnFQH9h5bCzWTg27unB4lfe9D+oSYfP
 Vn1JZr6IQmixxlOAjYBmCkpcpcXRjtzkOjFDeBF95+W8srwBgneUJVwR+6xkKQ==
X-Gm-Gg: Acq92OH0rAjoXEWNDASVxK14w6bXdnAp6Pkf36C2+0Fa483JCV2ki+TOjFGILRDF6EG
 yQQfkYduPTuHsGr9BsIvcP27m+qpRfPHvon9lN+pXAkx63uF12giQpLQh7Cc5cm2GKpmRrL7kML
 u7Btz7PBeAiHhnLL8nTu9++tFKsMtinDRyb8qfOmRjPcKI3OJUL00zkBRJWoirA8F+dT/eZSPcN
 T1+5KLcWyVZCCxYHkE0HpBrxo7TEUWMvB6rnbXCWgVFLCn+FMd1PVXQzeUtXQs5mhhVhP3m7UYE
 yYBgOQG2OZaMQXF7cq0XDgQ8fqC3HEAWmdVaEKvG8lZgglT3C1hYEjDSCAzAnn1GXAwhbbNZfet
 zz31khRTUGk4x6nX4KP2K2sZah9XplbOgF58UwDa23RNLgglvmBs/L+Fq4WcnL/K3iwd1tbHOK+
 BCfOiDoTikQ0HWC2CltyjbXmM0Y0kRaV5tXALUZuj26aAVdd0ZMfm/UFh7gNTGe61mY+LeDoBAN
 qHN1tQjcGzo5t50hE15IQ0mmSmgXvARW/4keBOVIRHrlK2iDR9jQEmzWBpZb+cuUHZ84qilUzV5
 bX0=
X-Received: by 2002:a05:6820:8c2:b0:67e:2fcc:fa99 with SMTP id
 006d021491bc7-69c9bfc7bf1mr243183eaf.55.1778780297217; 
 Thu, 14 May 2026 10:38:17 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:13 -0600
Subject: [PATCH v7 24/35] target/mips: add Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-24-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32b.google.com
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
index 2cdb7e4e76..989762fffc 100644
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
index 775f758369..f5c976db0d 100644
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
@@ -178,6 +192,8 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
+TRANS(QMAC,  trans_qmac, gen_helper_octeon_qmac);
+TRANS(QMACS, trans_qmac, gen_helper_octeon_qmacs);
 
 static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
 {
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


