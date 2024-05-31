Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340FAC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10A-0004c5-G9; Fri, 31 May 2024 08:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zo-0004R3-2f
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zj-0003UG-2m
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4211249fbafso18726055e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157064; x=1717761864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HB2ZPYPpq8qGuuaa+B56yerxjSQtKH6WnY6p4kzxYD4=;
 b=pV+egcUTXhusf92NPclhLLf4rpVraBbvmDK2KHZmPZ6FQVNh0QKQEbj19m+I0gspJJ
 vnl/5OiJ9UVOl5foGyTxziNsXv4DQ1akmNn/wtJLueQhX6K6EzvaXtuftRPxSFKck+ej
 oEXiyGnCUEGJcJCn3Q2bJ0Om2SxwrSFLmPLR/Jve6cv1XlfiSH/wtCmkxnlCPYmqW5hn
 4TF8qqW493oyNj7jUxXDKsz7FAEvxww4xzliKwbVFXh5X7Eka5v14MYKYi36dXf7X6vf
 1q3kId9uRZZD6aInGPsSJm+U1qv5qMZnf80iFM0xALgV8RRnhPeyoNg5+6KuKBfWYKp5
 bp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157064; x=1717761864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HB2ZPYPpq8qGuuaa+B56yerxjSQtKH6WnY6p4kzxYD4=;
 b=VL28YnySEz3//YeLJJYPPQeHYJOiVNEXDVmNCEknDx7rxwhG7wZjbhlNHskFnVvxNn
 zp9MWXZ08UaoivLKKussjSAbse0BbR7xHwGamcPU43fOzoX2yALhg1apiZM+IQUtCyZ3
 W/Cpn+4y83Y+A9cn4OiKXzWkjoMLVxFbGiiIBObRnZKUCRZqVe98+NqdirYoOSIJDDsT
 Xh2hx6/OH75E9+M1x0OUGRu/A7HaxwsRniOvOPPnoOV+mdZiGeUx7XHYan+T6gS4FZfN
 XAyMp+q3hKHirQdhAUmxUuu3zI3CQ3/3+gWn52qYHsUnXYA3VSdP14nzF1oriazHNC7N
 kaWg==
X-Gm-Message-State: AOJu0Ywq+qVR3tbTk+ZLjLbSP0ZbclZHbugqwCDX6d80YL2lyiGrxStE
 RUO6ksDhOwqV5LouVPWh3850NAvO3/txDPCYaRsbjafjkx89pv6orjbni8Kwbdg6FcsaP88Xmz7
 O
X-Google-Smtp-Source: AGHT+IEJ5oD8Ddb6lmUXryYPgc69dgBv1uEV77toPnJlZEXeXOrAnHjobVVXjAi3Nv5rF7vUi77wiw==
X-Received: by 2002:a05:600c:468f:b0:420:1125:dd79 with SMTP id
 5b1f17b1804b1-4212e0ade24mr16049075e9.31.1717157064671; 
 Fri, 31 May 2024 05:04:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/43] target/arm: Convert SMAX, SMIN, UMAX, UMIN to decodetree
Date: Fri, 31 May 2024 13:03:49 +0100
Message-Id: <20240531120401.394550-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-id: 20240528203044.612851-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 ++++++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1c448b4f7c9..bc98963bc5f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -918,6 +918,10 @@ SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 SRHADD_v        0.00 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
 URHADD_v        0.10 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
+SMAX_v          0.00 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
+UMAX_v          0.10 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
+SMIN_v          0.00 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
+UMIN_v          0.10 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9ef5de6755c..db6f59df176 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5460,6 +5460,10 @@ TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
 TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
 TRANS(SRHADD_v, do_gvec_fn3_no64, a, gen_gvec_srhadd)
 TRANS(URHADD_v, do_gvec_fn3_no64, a, gen_gvec_urhadd)
+TRANS(SMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smax)
+TRANS(UMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umax)
+TRANS(SMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smin)
+TRANS(UMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umin)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10925,8 +10929,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0xc: /* SMAX, UMAX */
-    case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
     case 0xf: /* SABA, UABA */
     case 0x12: /* MLA, MLS */
@@ -10959,6 +10961,8 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x09: /* SQSHL, UQSHL */
     case 0x0a: /* SRSHL, URSHL */
     case 0x0b: /* SQRSHL, UQRSHL */
+    case 0x0c: /* SMAX, UMAX */
+    case 0x0d: /* SMIN, UMIN */
     case 0x10: /* ADD, SUB */
     case 0x11: /* CMTST, CMEQ */
         unallocated_encoding(s);
@@ -10970,20 +10974,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0c: /* SMAX, UMAX */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smax, size);
-        }
-        return;
-    case 0x0d: /* SMIN, UMIN */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umin, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smin, size);
-        }
-        return;
     case 0xe: /* SABD, UABD */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uabd, size);
-- 
2.34.1


