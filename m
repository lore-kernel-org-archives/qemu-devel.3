Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F006C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UD-000462-2G; Tue, 28 May 2024 16:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Th-00036j-UP
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:27 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TS-0003jm-Ue
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:25 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8e819cf60so1079061b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928269; x=1717533069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlzLgB/Z9BImPgB1p/HCUMNJ/jlabUcBxkUVwL2nYL0=;
 b=XLzMZxE29FQjceQ0PnRZUePWFi7T+OCHSCzT+AEvwIyWRLhFx/QaCTfni9Xq1c0wOg
 ZlTpV3uIrBqiwYp9PIfYwzE+HGIYmm6451p5au81EgLUelJ1dRq99KY5Lo9JLYD0PMuM
 jvNNShUll2lE4/2nMqRiPLv/YL5QCdVMBHLffAuBmArVxb7QNJxmuppopT58CE9YIyRz
 vu8A/4SN11V0HeyMW6SiKXh4xGQOanxqxtqvMXaDPj0sJ94k2vFsM69R1hTziIANmJY4
 3U9FcgYStw02UB27odIGqtXJccqrR89eDu0Ph8HyUDTGya+sYGQckDGpgQgB7DqO8U+s
 BKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928269; x=1717533069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlzLgB/Z9BImPgB1p/HCUMNJ/jlabUcBxkUVwL2nYL0=;
 b=TyjWtre8x5Jmb/qsjwjL4+6IWcLaRu3NEb14ap0ydYJodbZSUeNOA+8GXaXhWOV2Fn
 tuUGInNd+8fbvfoUZjFPt2m/rbsBtw20iPqiHb8Prz6x6UKwP92jtEULjQIfkhTFVO0e
 Q/0FCdysgB1Lpcld9GdZ5OwDvxZdGQ+gNR4EVnSaylUi8ZeTemwA2T1trgrvfpbhihD9
 D7s+S/fvwXCmNyDkM2mDbR5ydbX9toum4c9lapaA842smxfHyCpY3OVKf9awqixkRaq8
 AdGoZuWY2lUv6ofgu8YVsfz5GCkWHSB2xLAortsq7Ug2ILkHcFgmd64QJ7WUeSVwiWH3
 xIsQ==
X-Gm-Message-State: AOJu0YwcxOvM9qA/Wm5RBH6XQZJCLx8/Zg07VQYzRkxym+wm1+aKQ0hp
 E6KM7xY2WbZ89skbp5o/FnjRrGqtKCMVBHzYUuDrDl3Yk8oB7ZN9c6+h7XcGxBtvSJph5Yzq7E/
 8
X-Google-Smtp-Source: AGHT+IFmxqmJjDznYDx1AHnjb8DK5pSUIr5yStMaasIurlJOpdX1V3Qvubq61D8b5srjmYfXI0QbhA==
X-Received: by 2002:a05:6a00:2a0f:b0:6f8:b1dc:d980 with SMTP id
 d2e1a72fcca58-6f8f3f9074fmr17925526b3a.31.1716928268656; 
 Tue, 28 May 2024 13:31:08 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 26/33] target/arm: Convert SMAX, SMIN, UMAX,
 UMIN to decodetree
Date: Tue, 28 May 2024 13:30:37 -0700
Message-Id: <20240528203044.612851-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 ++++++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1c448b4f7c..bc98963bc5 100644
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
index 9ef5de6755..db6f59df17 100644
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


