Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0590CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf7w-0005dt-4W; Wed, 20 May 2026 07:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf7h-0005Is-Rm
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:30:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf7f-0004ja-Ri
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:30:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso4225929f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276598; x=1779881398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VudyhCqFqn00XWcXAdbaOBPRFSCZrAzrPoD3IIkReWM=;
 b=vzubYs1wZEvWZL3TMntcycVlOlfi2DX0HjKdykM7R8HtXq2dqKF6RPt5fDze1HeRJ6
 rYkevJZesFJyjFYPgTAlO9advMh6a4b+eCSR9k5qTE5ulO+YjmLySVkKj7+QJ3rFGp8B
 IrAgfR9OBH4/Ng1dfZgoQyDyv3o2kaDgtylCXLWkPE1Iu5sawplLGglGQ1fBOy9OOiil
 bEHF42ggdrqF2UPEMFdoWRM7Ho7wGRJW+HofeRsDbMHfiAlcj/cxybDqyBFFweXxaGQ1
 gRx90QNoO9kV/l7r4/it9imNuQqti0lQkAfQnLxKUeEbif6JR/5IvqTIPQzguj1T7YmE
 4w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276598; x=1779881398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VudyhCqFqn00XWcXAdbaOBPRFSCZrAzrPoD3IIkReWM=;
 b=YBLvFYNvD+jnWehyAbXNkGWGqhqiZ+RroLSC70iYjxMPBZ98H7OKn5wiAt/KOJgym6
 fWXVEGI4xDyHM1dPAXMn0HmbEsdax5T9lSUbau9M98kMSJ/m4NFlsjFOJZ66C78SHXUV
 tI3UGt38vrO3lplGAxLnVu5Cq9O64X/eiG03nsXe7vD0LRe8p4iGtmlwx6m6HTqeAj7A
 Hp4INjIbC67HN7kpAvX8KhYbHZFcMUE47Jv3WB+Wx13jT7vw5LEBGc3ea/3ZBB7dOhnA
 LR1hFvTJQtrb58DvYdZha0rN868RB22Afj61bTDb2rfgIHl6pktGYjiB2IpCreFIDzFt
 Te9Q==
X-Gm-Message-State: AOJu0YxuYWtF3C7fIy6ogCxrrfftku3T88O3PBr0/IxH7MmaYQE6cANO
 CKAxtt2rU+kfFfqtdZNa6HquBdCE15UxXoUszaKuPq6g7/a6cdvcXm8Zez2eqipIA9JUhYs0z0Y
 69uo74Os=
X-Gm-Gg: Acq92OG08VjiHqBtwzUViBbQpWG4hpuIFL8fNZtGsglJ/Eu84FzfpeNFjvvEpJrLwGB
 agH0zA5Tp31e0b2jseeZa2khvoZVLOsnrji/RHzibKYQO4Uwa3TU7SXlUr8xOuEMRC7ZhjXUIvi
 rLUn75jH7srSsw7txAZPOVV4kjke262+1hrRZjfzcMNEP1ZsOXdkw9MjZO5AToen0Of8WvdNzmE
 W3EGrkSvbQMwyzR7p9vp9G+POtNk3jWAt1Jo7G1hAHPYSfPITsd3dDxssaDiDLQg+JU3H9zl2VK
 yQLFk+1QjEgyq/bFI5zM4XgPnRgZhUdra+jneOShW/4k8D3eqB/iNI/ZvG1bsNs0gwGuz8BqX3G
 UuGEXZWiwju8l7IuFv+q4pJbMFVzUNITP+nUOiMNhS4rhTIPQixxdgpFn++l/1AUQUJ7KliTjOd
 JNTAiOMYaWjY0p/aCMPbQnxlEcx1p/1fVrTb048hryTusGbiNh35leGXoKff1LLtdFaXAeKmoFw
 uNA4w==
X-Received: by 2002:a05:600c:34c4:b0:48a:89d9:a419 with SMTP id
 5b1f17b1804b1-48fe60ecdafmr379757965e9.11.1779272459520; 
 Wed, 20 May 2026 03:20:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6b9efsm196021825e9.5.2026.05.20.03.20.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 23/24] target/mips: add Octeon QMAC instructions
Date: Wed, 20 May 2026 12:18:04 +0200
Message-ID: <20260520101807.9971-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

QMAC.0x and QMACS.0x multiply the selected signed Q15 halfword lane from
rs by rt<15:0> and accumulate the Q31 product into the Octeon HI/LO
accumulator state.

QMAC updates the full 64-bit HI/LO accumulator. QMACS saturates the
32-bit Q31 result in LO and keeps HI<0> as the sticky saturation flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Add min32/max32 in trans_QMACS()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 ++
 target/mips/tcg/octeon_translate.c | 62 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 4d0ad058347..2d02b4e0bc3 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -28,6 +28,8 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SEQI rt, rs, immediate
 # SNE rd, rs, rt
 # SNEI rt, rs, immediate
+# QMAC.0x rs, rt
+# QMACS.0x rs, rt
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
 &cmpi        rs rt imm
@@ -43,6 +45,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
+QMACS        011100 rs:5 rt:5 00000 000 lane:2 010010
+QMAC         011100 rs:5 rt:5 00000 100 lane:2 010010
 
 &r2          rs rt
 @r2          ...... rs:5 rt:5 ..... ..... ...... &r2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 04e51538f93..684236b1a87 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -356,3 +356,65 @@ static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_QMAC(DisasContext *ctx, arg_QMAC *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /* Saturate -0x8000 * -0x8000 * 2 = 0x80000000 -> 0x7fffffff */
+    tcg_gen_smin_i64(t0, t0, tcg_constant_i64(INT32_MAX));
+
+    /* HI:LO += t0 */
+    tcg_gen_concat32_i64(t1, cpu_LO[0], cpu_HI[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_sextract_i64(cpu_LO[0], t0, 0, 32);
+    tcg_gen_sextract_i64(cpu_HI[0], t0, 32, 32);
+    return true;
+}
+
+static bool trans_QMACS(DisasContext *ctx, arg_QMACS *a)
+{
+    TCGv_i64 min32 = tcg_constant_i64(INT32_MIN);
+    TCGv_i64 max32 = tcg_constant_i64(INT32_MAX);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /*
+     * Saturate -0x8000 * -0x8000 * 2 = 0x80000000 -> 0x7fffffff.
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_smin_i64(t1, t0, max32);
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, t1);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+
+    /*
+     * LO = sat32(LO + t0)
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_ext32s_i64(t0, cpu_LO[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_smin_i64(cpu_LO[0], t0, max32);
+    tcg_gen_smax_i64(cpu_LO[0], cpu_LO[0], min32);
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, cpu_LO[0]);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+    return true;
+}
-- 
2.53.0


