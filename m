Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAA6E8B39D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHq-0007aK-AV; Wed, 04 Feb 2026 00:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHk-0007Yb-8P
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:42 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHi-00081Z-Lq
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:39 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35338b3dd31so2979045a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182315; x=1770787115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIZ+8DhFMV5di51oJwROCHq2vvo+jCjrZCBVlKzi/NE=;
 b=FVzDPrbMwtOnExXgQUXcuH/WR+FQIMSPk3O9S/LORUsMJvj/YRCocqEwDbEF0Qz0p7
 LmTKxZfU3PNbh+CnJnE1oo9oAoBLKFwCtQIwbZoPyrmq6Jk6Y0vsMgSVSkab4Xf9tCZL
 5/1ECyyPy6BWgg2eZZyHR34VgCNhePktoLs9OIlusRGsbkm7bwlrptd27TTcJ3reYmz/
 L+ukWewxBa+OTZu3F0Ffauwt/O+rbRkyZ+IrD+DvZ/fwXQ5hR/wKKQcX+Hbd/YrkAvVz
 ekrlMEgqWukXAiRcbEH86YskM8xX9kQTxY55shxADCI7EXMTnfmEmuVJuDBEv5TxFdWb
 2K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182315; x=1770787115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FIZ+8DhFMV5di51oJwROCHq2vvo+jCjrZCBVlKzi/NE=;
 b=AuocF7Eg0YMD10iiY2bT3Kv5kBsguaMpq/OLqgw2ukh+JMRDmcq/vw0gbwhQiUxpAp
 jt7la4VDq9jZRYOXLhIvFMGgJtgIzDa9jJU0SEd1UJzBB+2NauIiDWN0DLtHy2wj05+1
 3bHlK9XqcNol25h5hsh9nHhYMN2GrRlwKYU3MGOakiosu+9gM4MTi6YthsMQ9LyrJBr3
 MbM8GQwxx890t0slXuIyMsyPHGPN9poUsl3Q6xdkupxfDoJlPR1KCFHXKwg+/zQyEPv1
 083ulY2odQl4A+AR8W7aE0Om357I/q9phkOjdQzDTSAZEI7vwBq+keapVV2/u9QKX4lZ
 fGIA==
X-Gm-Message-State: AOJu0Yx9/g4ScAgIGIBsBhyWNgmOfsmvyU7xBmS/TW6JrghQm95EHLTc
 WR+ZkvXMGvU8+AlvXt4z+D/5uNxY7WTBL8Wzvt1tvVlHMSFYezEGq9XNcA7udfJ1tSyiMLdp2Yz
 YdagSEnRvFVR0mP/wuAfPybRkIBz3uLiPoV39R+9rgOkQ/HkBCRGfJuhIoBjOQyNRptDJeVNeqF
 aeq5l4psRCEqhmIT12Kje0YrNZNIOCrY6gzxPr2u2VqjOM
X-Gm-Gg: AZuq6aLenkKiyEUd3duJgIOozfPcDHoNEd9vFpJInWgbaY8BxJOm7bwu0s/Uopac/LO
 QeP3SUIQAULYa16qIG/5Vqt46As6kxOPXR/rtPzJX2sVBo+1AJg+aRQffWynUhHZiqPB2C1Xfxi
 AS6eE+vsdSR5cHQfX7YSTBnxYoh49v20MWSMzRLGFFLNoRietrHdWXuxVniamNx7iBS63JdoMvX
 FeNtUHnl2Decsb4LntazNrnhaVbDa7PK6ZG56rurlc1ILJVVyP2j+bA1Mif8egSLqtjXEdZQ9L+
 /6UPQi6/nPT5U/Wa39Ub6Hw5jCUChehYXev23ESlARyImbrQMgDc3Za5FF7c6oIO9+aWUkvxAli
 UVu+F5ISAEFlsBVDhxcwk4PPMMMR8oLmWM3mLmTca15+xQ7Xc53fqzHCqagIt4qpIIkL4o1PW2R
 3B3IlQtPYVqzG8pROBiGv83Oe19FJfpLT+hl+lSnmXKI2f0fu5MRr5PUd/CvVxAnKgw5vf28z0+
 seNt2rCzr7kcZ8=
X-Received: by 2002:a17:90b:4b92:b0:34a:8e4b:5b52 with SMTP id
 98e67ed59e1d1-354870ab6b5mr1401822a91.8.1770182315076; 
 Tue, 03 Feb 2026 21:18:35 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:34 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 10/19] target/riscv: rvv: Make vfncvtbf16.f.f.w support
 BF16 to OFP8 conversion for Zvfofp8min extension
Date: Wed,  4 Feb 2026 13:17:46 +0800
Message-ID: <20260204051756.667397-11-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1036.google.com
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

According to the Zvfofp8min extension, the vfncvtbf16.f.f.w instruction
supports BF16 to OFP8 conversion without satuation when SEW is 8.
And the VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: BF16 to OFP8.e4m3
* altfmt = 1: BF16 to OFP8.e5m2

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 9aafd4d2ef..16f4403909 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -67,11 +67,20 @@ static bool trans_fcvt_s_bf16(DisasContext *ctx, arg_fcvt_s_bf16 *a)
 static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
 {
     REQUIRE_FPU;
-    REQUIRE_ZVFBFMIN(ctx);
 
-    if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
+    if (opfv_narrow_check(ctx, a) &&
+        ((ctx->sew == MO_16 && ctx->cfg_ptr->ext_zvfbfmin) ||
+         (ctx->sew == MO_8 && ctx->cfg_ptr->ext_zvfofp8min))) {
+        gen_helper_gvec_3_ptr *fn;
         uint32_t data = 0;
 
+        if (ctx->sew == MO_16) {
+            fn = gen_helper_vfncvtbf16_f_f_w;
+        } else {
+            fn = ctx->altfmt ? gen_helper_vfncvtbf16_f_f_w_ofp8e5m2 :
+                               gen_helper_vfncvtbf16_f_f_w_ofp8e4m3;
+        }
+
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -81,8 +90,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
                            ctx->cfg_ptr->vlenb,
-                           ctx->cfg_ptr->vlenb, data,
-                           gen_helper_vfncvtbf16_f_f_w);
+                           ctx->cfg_ptr->vlenb, data, fn);
         finalize_rvv_inst(ctx);
         return true;
     }
-- 
2.52.0


