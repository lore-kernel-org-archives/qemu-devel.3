Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38F9C624D6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONt-0001j6-Rb; Tue, 01 Sep 2026 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONl-0001Vj-N8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:33 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONk-0007N8-0t
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:33 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso734835766b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268709; x=1788873509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sJHgV7oPLtw/+NOO/79pyvwPiKhoKGcWmZoZ5oqpKb0=;
 b=Pjuo8FhflCDkBvnEJ6vqhxSqE8YlhdJgT/N6UdDcdySSgIArjG8mHXkqR3RPTYYC+Y
 uicVZ8aw5hkXwmxPiZXpn7Sg+OCCapiTqsgLQwhtXkJZPeUmxuot6V8hCh+bpuVNpAeJ
 UYQy0QbvDvt2IXNjKzbqEJXjWbje84sypnPsejm/LKBxq1f2FQDZID+f4tGEpvfcDjtQ
 KCSQxT2IWJrqEVyydik251RnWTIW7vQDMRI9eJ2x55gBDMBOQ+Z4A8ObZDCWCYQXh1Z5
 tYaAuNB6ID7R/jZITwfhNlPZDpyosfpeQ+s+IMJKpL1tVnDvLA20OxtBODK8nSsCTcV3
 3YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268709; x=1788873509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sJHgV7oPLtw/+NOO/79pyvwPiKhoKGcWmZoZ5oqpKb0=;
 b=Gb6Z7ggOwAcLO316iyy+dV0H6WTgkvwpVbzrnPTfZ04bEKkyyXkaOGW8Tv3YaGK/va
 EX3FJ6BR2zXNQP7s81wNATDJ8u0Q1s0dU6J8eGSE5+kBdedRL7yMQ42XgL5gf66vka+8
 NjX+X+IkGI3pSdGy2F3GhcxT47E2TlCwJuxjXqx5sdr26E5+n4mzhp9G1uL1ZGtDoMoj
 di4mxTK4WS9CwfqG7xxAkN7n+Smir3MC/6wrCbQkjcwLCYPNVa8c1OEoJtoMP3oqJ8v2
 emIgIAd6X0dtlFz5jhRjuwl5Lr/04PSJe5oqQlrIHwh4SDdmOA825zrtRw95kQaNDCNU
 7O0Q==
X-Gm-Message-State: AFuF++ndhNcYQLQBpzCjZYTCnxAq/wOsoKGqw8vDq0Ri8cCQd99xu8rb
 WoovDxqkdHiRazHyqUksBUEq+kNbUKZU1FobTJt+mU9aQmEFpi1ECfcbVv3lObV6hOpb82kwe3c
 WTaCIwy4=
X-Gm-Gg: AR+sD11ZsOPQOV9qU9bQCabL2Mr9ClIlPTQHWV5b1fp7nh+2UPaze72UBhBKR2Ska7B
 g8dSQTeT33ukEkLgrJ24MlQwfGluGnEfT2IaGFwZ4gSYMnudwCfpqahIsCoJo64WqgXbk5OAPMX
 Y97Wmf9dyLqp1UsvIjZZxNGAtNwzNHR0gGa5qPsFLXAMvsdyxL06zTMcnQY1SAiYPtz7jtC0+pc
 020rJbJGtU95fBm2E/96HfiXshBLxHVjQW8iWnQlxGJZgrf+VAkhZTvfjf15U0e+Qb8uCFcMFFs
 fB1ozqsggz+GNloNMy927K1M07WaYHCOxFIZbHWnSI8JUKI4DwTitNlq7Hrb/tox2DWkKKEIfAe
 Z/fUd4b4c+Ux+0jT3+dmZlDB5l8b6H8ytY1eMjdVwzlPF8jcANydn50r71uHU7QSfrfGTI20q6r
 gu61ul8fg8+BpUIsBd1zol2H25jdwBhssl08tDtP08zi2+kjuCFa+yPxGQczlr8pLuoBjaYhK72
 jgasJTEmQn6jt59ccIASfz+ek2cWA4ssw1YFxD/t+ByiHTPmzySl+2v2Ytjm90U4i/FLQ==
X-Received: by 2002:a17:907:6094:b0:c25:34c7:44d1 with SMTP id
 a640c23a62f3a-c255667bfc7mr2049066966b.0.1788268709248; 
 Tue, 01 Sep 2026 06:18:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/58] target/arm: Implement AESDIMC
Date: Tue,  1 Sep 2026 14:17:30 +0100
Message-ID: <20260901131732.2263947-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 31 +++++++++++++++++++++++++++++++
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/sve.decode      |  3 +++
 target/arm/tcg/translate-sve.c |  2 ++
 4 files changed, 37 insertions(+)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index ae677cdf209..07d008c1be5 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -224,6 +224,37 @@ void HELPER(crypto_aesemc)(void *vd, void *vn, void *vm, uint32_t desc)
     } while (s > 0);
 }
 
+void HELPER(crypto_aesdimc)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    intptr_t idx = simd_data(desc);
+    void *vm_idx = vm + idx * 16;
+    intptr_t s = opr_sz - 16;
+
+    do {
+        intptr_t base = ROUND_DOWN(s, 4 * 16);
+        AESState rk = *(AESState *)(vm_idx + base);
+        do {
+            AESState *ad = (AESState *)(vd + s);
+            AESState *st = (AESState *)(vn + s);
+            AESState t;
+
+            /* Like above: Arm AK comes first; api AK comes last */
+            if (HOST_BIG_ENDIAN) {
+                t.d[0] = st->d[1] ^ rk.d[1];
+                t.d[1] = st->d[0] ^ rk.d[0];
+                aesdec_ISB_ISR_IMC_AK(&t, &t, &aes_zero, false);
+                ad->d[0] = t.d[1];
+                ad->d[1] = t.d[0];
+            } else {
+                t.v = st->v ^ rk.v;
+                aesdec_ISB_ISR_IMC_AK(ad, &t, &aes_zero, false);
+            }
+            s -= 16;
+        } while (s >= base);
+    } while (s > 0);
+}
+
 /*
  * SHA-1 logical functions
  */
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 512054d2f5d..269ac515065 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -461,6 +461,7 @@ DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesemc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aesdimc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesd_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5832e0190c6..7030d81db7e 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1991,6 +1991,9 @@ AESD_idx        01000101 00 1 .. .10111011 ..... ...00   @aes2_4
 AESEMC          01000101 00 1 .. .11111010 ..... ....0   @aes2_2
 AESEMC          01000101 00 1 .. .11111010 ..... ...00   @aes2_4
 
+AESDIMC         01000101 00 1 .. .11111011 ..... ....0   @aes2_2
+AESDIMC         01000101 00 1 .. .11111011 ..... ...00   @aes2_4
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 64ff2345307..1098cf0b388 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8348,6 +8348,8 @@ TRANS_FEAT_STREAMING_IF(AESD_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesd_idx)
 TRANS_FEAT_STREAMING_IF(AESEMC, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesemc)
+TRANS_FEAT_STREAMING_IF(AESDIMC, aa64_sve_aes2, aa64_ssve_aes,
+                        do_aes2_idx, a, gen_helper_crypto_aesdimc)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-- 
2.43.0


