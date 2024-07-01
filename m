Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC607C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa5-0003CN-Kh; Mon, 01 Jul 2024 12:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZA-0000kE-9w
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ5-0005RY-Tp
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so19250075e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850057; x=1720454857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WcptyOOEUYTd0t/bHxTS3PyzqFwxPQNZMLdE2NJrMms=;
 b=Fawhr6n1S++cvcs1JdEczzIOQsRvMyOHg9cvpjU8v51ep9UC4GNA18Eq4hiluffV2X
 foEnq3qcVS9Jkmqh3Rtc7yG/K6XPbJYYOOVgPcu0cE7SNkzALaeaqFs/WjA67IjjRVqR
 9gle5L8hcv1/QloeJxtv5KHl1RY9kz/uGXyGsix0rL+GYUOqXFd/TJURTzWWncDU052v
 Z+2RdFsWD8fFI+J2/yHhfR1QApvfkIftVZcg9RQrnZCDF3LmkfEJ8cGIBw0pRVT4mRO6
 sOaYWMK2Z+ka5PS0pR+0tgu1NEEhwYq5aewfOCdmRl36e3nzRe+mAEgrDkXAVBZxZtV/
 F82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850057; x=1720454857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcptyOOEUYTd0t/bHxTS3PyzqFwxPQNZMLdE2NJrMms=;
 b=aY1IgNdtGQc/KLoe9yb4okKF3CaV0YgjC0lNFlGQGSsDClbB5oifL44ZjH4UEoG+y4
 hbCPYHP0rtl90tmzUHBQ+J33MsiXjbwal8fL2V5Y0C5MjOKbQW2c5YT5d5Y/YuLyWs/x
 QNEkuPJiKHgmR0kiY8Qzkkun//jAvZ7UbUYjWsO0hI17nwz0eTFLgd8Q3YvSJGGsz+xi
 V1LtdpoyggkfymnnS+BCly4hv2qklc9tiSRhEgFaOG42qMJXXYTiDZGQVf10xW0VJDOn
 w/4kL8e5ovYal7zcnZC3K0kFJgo2Buxdf/3s6r96SFlMKa6jWeJxCslLKPAFcV1efcLb
 bL5A==
X-Gm-Message-State: AOJu0YwBPzYrIVHqOlHjO2LPIF92BGZxnQ4z8pWF+XQNtkpKiN6QH2s2
 cqKbCt9YfCsZJS6uGRJdiv+Sp6U2xJdCswdtw9PJ8ecSEe7REMVL/9LNjHUuY5Y3ADcys34Up0V
 h0Ls=
X-Google-Smtp-Source: AGHT+IFGusX3IeNQFhmA8sflo4QrkJLtn32+qBhWfVa4orfCyTJeIp9mLj4O51OWrakrb1ClPUoj6Q==
X-Received: by 2002:a05:600c:48a2:b0:421:7ab8:59c with SMTP id
 5b1f17b1804b1-42579862523mr61227905e9.10.1719850057420; 
 Mon, 01 Jul 2024 09:07:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/29] target/arm: Convert BFMMLA, SMMLA, UMMLA,
 USMMLA to decodetree
Date: Mon,  1 Jul 2024 17:07:15 +0100
Message-Id: <20240701160729.1910763-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Message-id: 20240625183536.1672454-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 36 ++++++++--------------------------
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 15344a73de4..b2c7e36969e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -952,6 +952,10 @@ UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 USDOT_v         0.00 1110 100 ..... 10011 1 ..... ..... @qrrr_s
 BFDOT_v         0.10 1110 010 ..... 11111 1 ..... ..... @qrrr_s
 BFMLAL_v        0.10 1110 110 ..... 11111 1 ..... ..... @qrrr_h
+BFMMLA          0110 1110 010 ..... 11101 1 ..... ..... @rrr_q1e0
+SMMLA           0100 1110 100 ..... 10100 1 ..... ..... @rrr_q1e0
+UMMLA           0110 1110 100 ..... 10100 1 ..... ..... @rrr_q1e0
+USMMLA          0100 1110 100 ..... 10101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 95be862dde4..2697c4b305b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5605,6 +5605,10 @@ TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
 TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfdot)
+TRANS_FEAT(BFMMLA, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfmmla)
+TRANS_FEAT(SMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_smmla_b)
+TRANS_FEAT(UMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_ummla_b)
+TRANS_FEAT(USMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usmmla_b)
 
 static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
 {
@@ -10949,15 +10953,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int rot;
 
     switch (u * 16 + opcode) {
-    case 0x04: /* SMMLA */
-    case 0x14: /* UMMLA */
-    case 0x05: /* USMMLA */
-        if (!is_q || size != MO_32) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_i8mm, s);
-        break;
     case 0x18: /* FCMLA, #0 */
     case 0x19: /* FCMLA, #90 */
     case 0x1a: /* FCMLA, #180 */
@@ -10972,19 +10967,16 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = dc_isar_feature(aa64_fcma, s);
         break;
-    case 0x1d: /* BFMMLA */
-        if (size != MO_16 || !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_bf16, s);
-        break;
     default:
     case 0x02: /* SDOT (vector) */
     case 0x03: /* USDOT */
+    case 0x04: /* SMMLA */
+    case 0x05: /* USMMLA */
     case 0x10: /* SQRDMLAH (vector) */
     case 0x11: /* SQRDMLSH (vector) */
     case 0x12: /* UDOT (vector) */
+    case 0x14: /* UMMLA */
+    case 0x1d: /* BFMMLA */
     case 0x1f: /* BFDOT / BFMLAL */
         unallocated_encoding(s);
         return;
@@ -10998,15 +10990,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x04: /* SMMLA, UMMLA */
-        gen_gvec_op4_ool(s, 1, rd, rn, rm, rd, 0,
-                         u ? gen_helper_gvec_ummla_b
-                         : gen_helper_gvec_smmla_b);
-        return;
-    case 0x05: /* USMMLA */
-        gen_gvec_op4_ool(s, 1, rd, rn, rm, rd, 0, gen_helper_gvec_usmmla_b);
-        return;
-
     case 0x8: /* FCMLA, #0 */
     case 0x9: /* FCMLA, #90 */
     case 0xa: /* FCMLA, #180 */
@@ -11051,9 +11034,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         return;
 
-    case 0xd: /* BFMMLA */
-        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_bfmmla);
-        return;
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


