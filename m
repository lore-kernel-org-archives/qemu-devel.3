Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3773C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeJF-0003RU-FS; Fri, 24 May 2024 19:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeI8-0008Cf-HV
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHv-0006uj-AY
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8edff35a0so1240063b3a.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593113; x=1717197913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/faNa0CqV173A6w0C5UtLu2pSxJR/tRzvusot9qONxA=;
 b=I3hR9zdD7rW2vxZ0Y3Q/XoeY2a+qc07bMM4Lt8mhWnXi60JeVHjB1xpVNSm9MbF8TQ
 RTZeqzB1JzFSRy7fXhnHQE7fNS/uoo8MPr/GZhOD23MjURUMxDybiVJsAemdrgd0MtiP
 1IWunvrWfYpFKONtFo+QAgcpCnag3n0w/HrrJDwB0oPh55iui3+IUWO9rW4gWMWsk+Vb
 GekLB29cQWrdJJj0h57VoHH9nvKHe8F033ox7PDJm+oKgH81QM2d/H5sjFmcyqz7phSe
 82iouL+Etrz/wL3XkMSPUQ4X67ndMRR2DUbfXM5OUosLk3g97J9egITZcHrzhpYk/cE3
 7mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593113; x=1717197913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/faNa0CqV173A6w0C5UtLu2pSxJR/tRzvusot9qONxA=;
 b=n+HVR8DbUjz+EjLuJaJs/np/7STIyhbnX0HBuZ6YyJ2KtfZTswNe0oKT0V9BsVyg1b
 K8g/qScVHOSG1cVCHq05mpt1pOj5YlvvvF36/z8baCdVkyLCW5x5C0JZWE5VRXlzX2n9
 rnVRfGOBwlDap5Im90OhHnVFx4bw017vrMfvSlP367ROWcGmMRMubiluUySX34OnYpdY
 XfNEj5KTqeXVg2kCQ/ziR/eD3jLoA4iUTvcXNv8MsXWEE9QHZYBvFGqzUgXF4e6rLXPu
 mF6t32fKq+gAeC6aOGs1rVCim2VLAwJ7n3V+ZE2atJwIW3Z5weHzVgZKuqgNbJ0EwdTg
 AAuQ==
X-Gm-Message-State: AOJu0YyrngONIWucGAO2lLF/zpp207bpcsRCBj/yqYkTkvOlH4SmyUWQ
 rbBKsQVWZRLZB1o6ax/GVHFCmP05SvlIlyhniTspIOQyhoAdHmVdgMHZQWvRcLrpU1R/CTcV4la
 C
X-Google-Smtp-Source: AGHT+IH55GZDk0tQe0CmQJ55TdO1H+X874DuPsADINcShphfGhKuZB5Q2iRIiwtrwzF90sY58tYiCQ==
X-Received: by 2002:a05:6a00:4007:b0:6f3:f963:505f with SMTP id
 d2e1a72fcca58-6f8f2a4b288mr3943265b3a.5.1716593112998; 
 Fri, 24 May 2024 16:25:12 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 57/67] target/arm: Convert SHSUB, UHSUB to decodetree
Date: Fri, 24 May 2024 16:21:11 -0700
Message-Id: <20240524232121.284515-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e33d91fd0a..b1bbcb144e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -914,6 +914,8 @@ CMTST_v         0.00 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 CMEQ_v          0.10 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
+SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
+UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 63f7a59f94..6571b999f4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5456,6 +5456,8 @@ TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
 TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
 TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
 TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
+TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
+TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10923,7 +10925,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         }
         /* fall through */
     case 0x2: /* SRHADD, URHADD */
-    case 0x4: /* SHSUB, UHSUB */
     case 0xc: /* SMAX, UMAX */
     case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
@@ -10949,6 +10950,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
+    case 0x04: /* SHSUB, UHSUB */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
     case 0x07: /* CMGE, CMHS */
@@ -10967,13 +10969,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x04: /* SHSUB, UHSUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhsub, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shsub, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


