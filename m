Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FDACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcI2-0006fS-JP; Tue, 02 Jun 2026 23:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI0-0006cc-La
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHy-0003bp-6w
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8424b00710aso1882326b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457345; x=1781062145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hybuRnEGHy4OhooGWsJlCMASzdQIhfUBKdru7X7Ws0c=;
 b=O2M5090gNE/AGd/YFicqxK0K/22SPomsEpo8fELBIoKZFatNfvt38+Xp+MLPXRaTUl
 5iYFHHBUqz0XiD52gk4ZsG9B6E0+asWwI4M5IFKCT1lSTZ5ym/JdGIpeCmfyemC2dQXe
 9hiraRZcDqaET3gxaEjt0ySdsXkiKEMj0PVLLb5nTJxk+luGVKXaEdnS+VStvtsBeDI0
 WyYZ7G67gzgM+jD7sDcWmkWR5QR8+tcsBOoxWhlu6drg5xcv6iZTA/GowuHj2/WMs+Qf
 vt+hIKjEzShMrWRmLt9yy0jK9jBpjwUF+onjPWSg3jWhX0a2RpINcdoHxwhBR1jrt0WM
 DWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457345; x=1781062145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hybuRnEGHy4OhooGWsJlCMASzdQIhfUBKdru7X7Ws0c=;
 b=lVp2OjxFIeZpuiaYyRCuqXeLRwwRKy+/uJLNvdMOqYrZ+8ZdmBn+eN2HgF7Uh9AeVA
 Juw8JGyrCACIE8Bn9AW7b7u014vk8qvusWbTV6UBvfaMYV1d/hv20y4LHE4ZpPm99fR7
 xLIstvkBOh+om3q+arBuTxmNSff3YkKIavRQrKpNaLWGcddnUkKtEWDv1KnDFBMyX9u3
 rocJfcMlYxitn8E2rihq/4lrskNFmqvxRligLD47VKj0z62psYwM+jKUWKbKBaXqetli
 HC/pj5m+NC+9OukDyqB8Lw6t7xB93eX6k3/bvwYOxwh80ssG81x1nD8TeM+sMoUXsy4v
 42yQ==
X-Gm-Message-State: AOJu0YxoC4Yd8MwxoauB03PW7UiEpEdLkIrb8YdjW+ugQ3BCxK1roQCp
 s+SS3MJmsM+BPA/szFtvEbGFeThilp8tzSbXVPmmHnxzgMpwDPJTWVLdi2cg4FtimvRz/XqfFgW
 1WnMcuxE=
X-Gm-Gg: Acq92OHj5XchNZoaEGlcY1ss0nX54z0RZcBgq1WXtD9DqichbUKflOIUhvPBMQ49Zsi
 ZlLSPJ9YqBgGG80mzTD9w9zPdHTzVPnRUh5wUbwTVk2SxQgzQ7Ldd+UgD8P1xUAwPpY1AyRIaYT
 r0GK1d7V7PyDFdwGd3UNUZC6yMXGMSIXicPUTX6GPAMXnk88/REqciF12XXTkRGFj59ZxiCvnv/
 +Shq8qGrAhp4AHuX/mVoGDcdp1jTp/o9Nh1c11lzGG6sTYllzyUA1chGEN5TkYVjCsTqFVnPXM3
 eymvDFUqp8Xu1mOA5S4RJTPA4dQTjsdvx/eEX4QzBWl3IR5PzHjAHVf7sGThyRcVN5aIhNRvAl6
 oZ3NPD9szaiVkrNVVxbKapvvoKtNC+rD96nxcyG87Hfww11ptQL2rlPpXO9vxhpJgweJCiaHcEE
 Zkq7APGvzg8zCHf+EEQHaiTGMjVP3wjUS1iPh/tzw=
X-Received: by 2002:a05:6a00:887:b0:842:6004:3fda with SMTP id
 d2e1a72fcca58-84284ee93bfmr1624864b3a.25.1780457344799; 
 Tue, 02 Jun 2026 20:29:04 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 12/45] target/arm: Implement F1CVT, F1CVTLT, F2CVT,
 F2CVTLT for SVE
Date: Tue,  2 Jun 2026 20:28:21 -0700
Message-ID: <20260603032855.106930-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sve.c   |  9 +++++++++
 target/arm/tcg/sve.decode        |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 718463422b..3021dafd44 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -9,3 +9,4 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 0f3c279696..75c89203fe 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -168,6 +168,22 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_cvt_finish(env, &ctx);
 }
 
+void HELPER(sve2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H2(i)] = fcvt_fp8_to_f16(n[H1(2 * i + ctx.high)],
+                                   input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
 void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 718a21de70..c47e79637e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4082,6 +4082,15 @@ static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
     return true;
 }
 
+TRANS_FEAT_STREAMING_IF(F1CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvt_hb, false, false)
+TRANS_FEAT_STREAMING_IF(F2CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvt_hb, true, false)
+TRANS_FEAT_STREAMING_IF(F1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvt_hb, false, true)
+TRANS_FEAT_STREAMING_IF(F2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvt_hb, true, true)
+
 TRANS_FEAT_STREAMING_IF(BF1CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvt, false, false)
 TRANS_FEAT_STREAMING_IF(BF2CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e7984fa8e0..ca110f4bc1 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1091,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+F1CVT           01100101 00 001 000 001100 ..... .....          @rd_rn_e0
+F2CVT           01100101 00 001 000 001101 ..... .....          @rd_rn_e0
+F1CVTLT         01100101 00 001 001 001100 ..... .....          @rd_rn_e0
+F2CVTLT         01100101 00 001 001 001101 ..... .....          @rd_rn_e0
+
 BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
 BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
-- 
2.43.0


