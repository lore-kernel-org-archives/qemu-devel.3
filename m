Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95C6C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10B-0004dO-4D; Fri, 31 May 2024 08:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zo-0004R4-2q
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zj-0003UK-1q
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4212a3e82b6so6985655e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157065; x=1717761865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1DLv8txiSDUOHgRBJTM+iegbOX+DHZ0A+L/IfqxCwms=;
 b=YvK8f0jTI7PlO1OcyKGN0iVGlZwYULja4GiCbELbC+V2jH9imKuNKwMYkipDYvaIxD
 I2SnhlNTKxjC0V9a7ZrQtZrxcR7BC0wSJFapAPJ5mjjhDACrM09bvI2nTXccr/aiCEgS
 yy0EhTGDx0JW/aRqzjkZG2q8Cd+PEhcrqa3n/q3KmSvTmvjMSc1fMdN8pQFgqjUnnw39
 ZQkuk7V1jDszoysokgkjaS46l4OnrudUZr3rXt8OlcVeJKF0l0bKuDqKFEAkaVSdqxJY
 whZNA6j4WaT7uVpn0q89xuNsIddH1BphS6GBzU5EUg1ibDjL6hInqIFHdgwBD2QqMguz
 TiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157065; x=1717761865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DLv8txiSDUOHgRBJTM+iegbOX+DHZ0A+L/IfqxCwms=;
 b=dtQSDRzdTwc6kzJB4QudxSxY9Qhb9vPry+lzRzMKq+U45u3gzIcTpa9igpvaLHN2w7
 oMBKkcBbpjqacMT4fgeK/zgLCMqJpmhptiIh2v5hF4LrHBUbbkNV2nuuApJceZZj3fd+
 xT5F8Do0Ob0crxjTXLgfLkZypU37X0+q3IskU/WB32+JCkbQ0pIiwVmvbRlAeIiRi+ec
 7hMA0ovsSP7JAv3n8BuWHM/88Z8aXgt2DIDIbCi1ytNgTQ43au1DozoNekHU601CIA0H
 +wnjkwppEio5IpA1C8pG5N+FqezyIytte68fdDHFesiXBXZZgnscWtCuclcJd6QMb+dY
 gxSQ==
X-Gm-Message-State: AOJu0YzFyjWpQW+dEUZbQBMcH2xQgrb6p9bmaAvvZ6ru9+cGdAXhcaG4
 FdZjeI0xE8Y0TSUk7Xen17rxdnAqYUjLg/xHlzz/Ook8y5W3wRwp+y+5Z9llCQGy06CGdUW89Rz
 2
X-Google-Smtp-Source: AGHT+IG0CKjXp5MGG0tU0i7PWy01WNAUytp3EuDOHOZu0lvwL5O6aWr6Zda6aV5mZQ5gnyl1znWsHQ==
X-Received: by 2002:a05:600c:4f4d:b0:418:9d4a:1ba5 with SMTP id
 5b1f17b1804b1-421280dfabbmr40835495e9.6.1717157065295; 
 Fri, 31 May 2024 05:04:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/43] target/arm: Convert SABA, SABD, UABA, UABD to decodetree
Date: Fri, 31 May 2024 13:03:50 +0100
Message-Id: <20240531120401.394550-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Message-id: 20240528203044.612851-28-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 ++++++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bc98963bc5f..07b604ec30d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -922,6 +922,10 @@ SMAX_v          0.00 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
 UMAX_v          0.10 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
 SMIN_v          0.00 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
 UMIN_v          0.10 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
+SABD_v          0.00 1110 ..1 ..... 01110 1 ..... ..... @qrrr_e
+UABD_v          0.10 1110 ..1 ..... 01110 1 ..... ..... @qrrr_e
+SABA_v          0.00 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
+UABA_v          0.10 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index db6f59df176..61afbc434fe 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5464,6 +5464,10 @@ TRANS(SMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smax)
 TRANS(UMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umax)
 TRANS(SMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smin)
 TRANS(UMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umin)
+TRANS(SABA_v, do_gvec_fn3_no64, a, gen_gvec_saba)
+TRANS(UABA_v, do_gvec_fn3_no64, a, gen_gvec_uaba)
+TRANS(SABD_v, do_gvec_fn3_no64, a, gen_gvec_sabd)
+TRANS(UABD_v, do_gvec_fn3_no64, a, gen_gvec_uabd)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10929,8 +10933,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0xe: /* SABD, UABD */
-    case 0xf: /* SABA, UABA */
     case 0x12: /* MLA, MLS */
         if (size == 3) {
             unallocated_encoding(s);
@@ -10963,6 +10965,8 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQRSHL, UQRSHL */
     case 0x0c: /* SMAX, UMAX */
     case 0x0d: /* SMIN, UMIN */
+    case 0x0e: /* SABD, UABD */
+    case 0x0f: /* SABA, UABA */
     case 0x10: /* ADD, SUB */
     case 0x11: /* CMTST, CMEQ */
         unallocated_encoding(s);
@@ -10974,20 +10978,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0xe: /* SABD, UABD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uabd, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sabd, size);
-        }
-        return;
-    case 0xf: /* SABA, UABA */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uaba, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_saba, size);
-        }
-        return;
     case 0x13: /* MUL, PMUL */
         if (!u) { /* MUL */
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
-- 
2.34.1


