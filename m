Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F0FC83F0C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGN-0007i5-6R; Fri, 04 Jul 2025 12:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFV-00055G-Fy
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFS-0006xY-7u
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d54214adso7695805e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646409; x=1752251209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YpD4dO0hgrJNOs9zFqHItKH2CmEpgYcn2PXcXrxeRP0=;
 b=b8G7GUnsrpClKXPoIHU869RFEiI6hVe19js1/l/rjJz5zSpt/XGdsmHxVODqeFkpqp
 xPR4eRb9sT9TRXzbc93oujIshdr1BrSNDroRMbPag7BCcNrhE7ayQP32lySn06Ke1WlW
 WcjYKPXihCKU+pQ22SnUr5ACe6iSM1ug0BvcXjldjpTMEdBDGjkfqjkn3Pkgp41Su+lU
 8lWmSYCTVPMec6nI/Tk+BH8xDo0UmvV6xSpPQsoaQ7ncPxmrJpzoTzut4/1XGrvDqHNC
 GptCL2YDeeEmR46wpLb4wHkX5NhdCy6R7C2GBczUgFPQwMotHBzL6ioXhB6ixqodpZqi
 HceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646409; x=1752251209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpD4dO0hgrJNOs9zFqHItKH2CmEpgYcn2PXcXrxeRP0=;
 b=rKMNEOTOlKMQoIWMYM1AWhoot/UZnE9xJ/l2M1W8QvTVr9QP3+WLqF+vv11hraFC5X
 /ZrkivgHapMHyKQU6Kv07xzgdifundthoIImcT2zzs/itU4e1hO641HTpfoshO4QHyJk
 2fQ9/gzx+2ieKDqnzlNAS57o6AfjzY/28uVp4TKUAn60M0z1JBbdEAWiugNIpFPOHW2F
 deVkc5ejoS9IAQAhKXd9pLA9bjwTOU1VASxHW0h6w0Tz/sAx+CHhjFLW9R8xw3Nnc7kR
 GZuh/m4Tmw2JndHFpMy54tsLROkXAVGVaNFQoNp443kx1nYpZ7Q5SlzsaxlGuMEwBEIp
 QmGA==
X-Gm-Message-State: AOJu0YxacS6jdla07lIlTEZ3ua3TsnQcTRrRxesxpCx9pmhykw4TWpq7
 NCasE34ZPWeonyY06rWCpvHQc2qdwNyo9JQEy8XX+3HbO/eB2R2LmyU1Vv+ZY+6dAHeCH7hL8aS
 d9SA1
X-Gm-Gg: ASbGncug+sas5eeK65kUvj43qTonU+0UuVVL+OocVkGrrTvvdjf6oRzlHJCLMx8WklT
 NORH3MvhPJZbAoFU1nVR9KRL7z6fAKjyi/nkHnApsbP47GV918HnYhh75mCjGBcU2ejJ8WrK9NB
 Y/tDLY2lBuw+T5wHQJBC93w5AKU242p0n9hJYHyIwrOprD4FikpUPLPXMn8jiYLJpHTlkLA1Prs
 cebUCDppj5rJN5vR0YQ+f1YEUf5tymOJbiPBUxVUXTdIhIBhQIAKLn1heZer6vTXtWM1kDLuIrx
 ppw9DjSHQSiyxONNvw4oeATp2UYHxBaMAUewwbLlRue/TCH9nZ/1Gss60BBESRSRONEb4+ZNEms
 I0q4=
X-Google-Smtp-Source: AGHT+IE0/4VzHYY0lKz2upQOQg1WVOVGsFeVIvVMiu1hF7We+HrLbHo4CQ8FpM4llunHP13vNAaC5w==
X-Received: by 2002:a05:600c:3e1a:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-454b3187c08mr40686785e9.30.1751646408739; 
 Fri, 04 Jul 2025 09:26:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 112/119] target/arm: Implement LUTI2, LUTI4 for SME2/SME2p1
Date: Fri,  4 Jul 2025 17:24:52 +0100
Message-ID: <20250704162501.249138-113-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-101-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h        | 24 ++++++++++
 target/arm/tcg/sme.decode      | 42 ++++++++++++++++
 target/arm/tcg/translate-sme.c | 56 ++++++++++++++++++++++
 target/arm/tcg/vec_helper.c    | 88 ++++++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 392bf7b9b5b..d9565c80697 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1188,3 +1188,27 @@ DEF_HELPER_FLAGS_4(gvec_uminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(gvec_urecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ursqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti2_1b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_1h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_1s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti2_2b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_2h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_2s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti2_4b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_4h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti2_4s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti4_1b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_1h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_1s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti4_2b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_2h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_2s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_luti4_4b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_4h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_luti4_4s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index f7e4143b7de..5a5b8ff8a5a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -945,3 +945,45 @@ ZERO_za         11000000 000011 110 .. 0000000000 00.   \
                 &zero_za ngrp=2 nvec=4 rv=%mova_rv off=%off1_x4
 ZERO_za         11000000 000011 111 .. 0000000000 00.   \
                 &zero_za ngrp=4 nvec=4 rv=%mova_rv off=%off1_x4
+
+### SME Lookup Table Read
+
+&lut            zd zn idx
+
+# LUTI2, consecutive
+LUTI2_c_1b      1100 0000 1100 11 idx:4    00 00 zn:5 zd:5      &lut
+LUTI2_c_1h      1100 0000 1100 11 idx:4    01 00 zn:5 zd:5      &lut
+LUTI2_c_1s      1100 0000 1100 11 idx:4    10 00 zn:5 zd:5      &lut
+
+LUTI2_c_2b      1100 0000 1000 11 idx:3  1 00 00 zn:5 .... 0    &lut zd=%zd_ax2
+LUTI2_c_2h      1100 0000 1000 11 idx:3  1 01 00 zn:5 .... 0    &lut zd=%zd_ax2
+LUTI2_c_2s      1100 0000 1000 11 idx:3  1 10 00 zn:5 .... 0    &lut zd=%zd_ax2
+
+LUTI2_c_4b      1100 0000 1000 11 idx:2 10 00 00 zn:5 ... 00    &lut zd=%zd_ax4
+LUTI2_c_4h      1100 0000 1000 11 idx:2 10 01 00 zn:5 ... 00    &lut zd=%zd_ax4
+LUTI2_c_4s      1100 0000 1000 11 idx:2 10 10 00 zn:5 ... 00    &lut zd=%zd_ax4
+
+# LUTI2, strided (must check zd alignment)
+LUTI2_s_2b      1100 0000 1001 11 idx:3  1 00 00 zn:5 zd:5      &lut
+LUTI2_s_2h      1100 0000 1001 11 idx:3  1 01 00 zn:5 zd:5      &lut
+
+LUTI2_s_4b      1100 0000 1001 11 idx:2 10 00 00 zn:5 zd:5      &lut
+LUTI2_s_4h      1100 0000 1001 11 idx:2 10 01 00 zn:5 zd:5      &lut
+
+# LUTI4, consecutive
+LUTI4_c_1b      1100 0000 1100 101 idx:3    00 00 zn:5 zd:5     &lut
+LUTI4_c_1h      1100 0000 1100 101 idx:3    01 00 zn:5 zd:5     &lut
+LUTI4_c_1s      1100 0000 1100 101 idx:3    10 00 zn:5 zd:5     &lut
+
+LUTI4_c_2b      1100 0000 1000 101 idx:2  1 00 00 zn:5 .... 0   &lut zd=%zd_ax2
+LUTI4_c_2h      1100 0000 1000 101 idx:2  1 01 00 zn:5 .... 0   &lut zd=%zd_ax2
+LUTI4_c_2s      1100 0000 1000 101 idx:2  1 10 00 zn:5 .... 0   &lut zd=%zd_ax2
+
+LUTI4_c_4h      1100 0000 1000 101 idx:1 10 01 00 zn:5 ... 00   &lut zd=%zd_ax4
+LUTI4_c_4s      1100 0000 1000 101 idx:1 10 10 00 zn:5 ... 00   &lut zd=%zd_ax4
+
+# LUTI4, strided (must check zd alignment)
+LUTI4_s_2b      1100 0000 1001 101 idx:2  1 00 00 zn:5 zd:5     &lut
+LUTI4_s_2h      1100 0000 1001 101 idx:2  1 01 00 zn:5 zd:5     &lut
+
+LUTI4_s_4h      1100 0000 1001 101 idx:1 10 01 00 zn:5 zd:5     &lut
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 9592f6a9960..d38b8a5ca23 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1697,3 +1697,59 @@ static bool trans_SEL(DisasContext *s, arg_SEL *a)
     }
     return true;
 }
+
+static bool do_lut(DisasContext *s, arg_lut *a,
+                   gen_helper_gvec_2_ptr *fn, bool strided)
+{
+    if (sme_sm_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           tcg_env, svl, svl, strided | (a->idx << 1), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(LUTI2_c_1b, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_1b, false)
+TRANS_FEAT(LUTI2_c_1h, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_1h, false)
+TRANS_FEAT(LUTI2_c_1s, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_1s, false)
+
+TRANS_FEAT(LUTI2_c_2b, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_2b, false)
+TRANS_FEAT(LUTI2_c_2h, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_2h, false)
+TRANS_FEAT(LUTI2_c_2s, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_2s, false)
+
+TRANS_FEAT(LUTI2_c_4b, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_4b, false)
+TRANS_FEAT(LUTI2_c_4h, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_4h, false)
+TRANS_FEAT(LUTI2_c_4s, aa64_sme2, do_lut, a, gen_helper_sme2_luti2_4s, false)
+
+TRANS_FEAT(LUTI4_c_1b, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_1b, false)
+TRANS_FEAT(LUTI4_c_1h, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_1h, false)
+TRANS_FEAT(LUTI4_c_1s, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_1s, false)
+
+TRANS_FEAT(LUTI4_c_2b, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_2b, false)
+TRANS_FEAT(LUTI4_c_2h, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_2h, false)
+TRANS_FEAT(LUTI4_c_2s, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_2s, false)
+
+TRANS_FEAT(LUTI4_c_4h, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_4h, false)
+TRANS_FEAT(LUTI4_c_4s, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_4s, false)
+
+static bool do_lut_s4(DisasContext *s, arg_lut *a, gen_helper_gvec_2_ptr *fn)
+{
+    return !(a->zd & 0b01100) && do_lut(s, a, fn, true);
+}
+
+static bool do_lut_s8(DisasContext *s, arg_lut *a, gen_helper_gvec_2_ptr *fn)
+{
+    return !(a->zd & 0b01000) && do_lut(s, a, fn, true);
+}
+
+TRANS_FEAT(LUTI2_s_2b, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti2_2b)
+TRANS_FEAT(LUTI2_s_2h, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti2_2h)
+
+TRANS_FEAT(LUTI2_s_4b, aa64_sme2p1, do_lut_s4, a, gen_helper_sme2_luti2_4b)
+TRANS_FEAT(LUTI2_s_4h, aa64_sme2p1, do_lut_s4, a, gen_helper_sme2_luti2_4h)
+
+TRANS_FEAT(LUTI4_s_2b, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti4_2b)
+TRANS_FEAT(LUTI4_s_2h, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti4_2h)
+
+TRANS_FEAT(LUTI4_s_4h, aa64_sme2p1, do_lut_s4, a, gen_helper_sme2_luti4_4h)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index d4ee6f4d29d..0603db09093 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3443,3 +3443,91 @@ void HELPER(gvec_ursqrte_s)(void *vd, void *vn, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+static inline void do_lut_b(void *zd, uint64_t *indexes, uint64_t *table,
+                            unsigned elements, unsigned segbase,
+                            unsigned dstride, unsigned isize,
+                            unsigned tsize, unsigned nreg)
+{
+    for (unsigned r = 0; r < nreg; ++r) {
+        uint8_t *dst = zd + dstride * r;
+        unsigned base = segbase + r * elements;
+
+        for (unsigned e = 0; e < elements; ++e) {
+            unsigned index = extractn(indexes, (base + e) * isize, isize);
+            dst[H1(e)] = extractn(table, index * tsize, 8);
+        }
+    }
+}
+
+static inline void do_lut_h(void *zd, uint64_t *indexes, uint64_t *table,
+                            unsigned elements, unsigned segbase,
+                            unsigned dstride, unsigned isize,
+                            unsigned tsize, unsigned nreg)
+{
+    for (unsigned r = 0; r < nreg; ++r) {
+        uint16_t *dst = zd + dstride * r;
+        unsigned base = segbase + r * elements;
+
+        for (unsigned e = 0; e < elements; ++e) {
+            unsigned index = extractn(indexes, (base + e) * isize, isize);
+            dst[H2(e)] = extractn(table, index * tsize, 16);
+        }
+    }
+}
+
+static inline void do_lut_s(void *zd, uint64_t *indexes, uint32_t *table,
+                            unsigned elements, unsigned segbase,
+                            unsigned dstride, unsigned isize,
+                            unsigned tsize, unsigned nreg)
+{
+    for (unsigned r = 0; r < nreg; ++r) {
+        uint32_t *dst = zd + dstride * r;
+        unsigned base = segbase + r * elements;
+
+        for (unsigned e = 0; e < elements; ++e) {
+            unsigned index = extractn(indexes, (base + e) * isize, isize);
+            dst[H4(e)] = table[H4(index)];
+        }
+    }
+}
+
+#define DO_SME2_LUT(ISIZE, NREG, SUFF, ESIZE) \
+void helper_sme2_luti##ISIZE##_##NREG##SUFF                             \
+    (void *zd, void *zn, CPUARMState *env, uint32_t desc)               \
+{                                                                       \
+    unsigned vl = simd_oprsz(desc);                                     \
+    unsigned strided = extract32(desc, SIMD_DATA_SHIFT, 1);             \
+    unsigned idx = extract32(desc, SIMD_DATA_SHIFT + 1, 4);             \
+    unsigned elements = vl / ESIZE;                                     \
+    unsigned dstride = (!strided ? 1 : NREG == 4 ? 4 : 8);              \
+    unsigned segments = (ESIZE * 8) / (ISIZE * NREG);                   \
+    unsigned segment = idx & (segments - 1);                            \
+    ARMVectorReg indexes;                                               \
+    memcpy(&indexes, zn, vl);                                           \
+    do_lut_##SUFF(zd, indexes.d, (void *)env->za_state.zt0, elements,   \
+                  segment * NREG * elements,                            \
+                  dstride * sizeof(ARMVectorReg), ISIZE, 32, NREG);     \
+}
+
+DO_SME2_LUT(2,1,b, 1)
+DO_SME2_LUT(2,1,h, 2)
+DO_SME2_LUT(2,1,s, 4)
+DO_SME2_LUT(2,2,b, 1)
+DO_SME2_LUT(2,2,h, 2)
+DO_SME2_LUT(2,2,s, 4)
+DO_SME2_LUT(2,4,b, 1)
+DO_SME2_LUT(2,4,h, 2)
+DO_SME2_LUT(2,4,s, 4)
+
+DO_SME2_LUT(4,1,b, 1)
+DO_SME2_LUT(4,1,h, 2)
+DO_SME2_LUT(4,1,s, 4)
+DO_SME2_LUT(4,2,b, 1)
+DO_SME2_LUT(4,2,h, 2)
+DO_SME2_LUT(4,2,s, 4)
+DO_SME2_LUT(4,4,b, 1)
+DO_SME2_LUT(4,4,h, 2)
+DO_SME2_LUT(4,4,s, 4)
+
+#undef DO_SME2_LUT
-- 
2.43.0


