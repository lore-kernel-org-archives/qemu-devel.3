Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AAAE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPe3-0008OU-Mo; Wed, 11 Dec 2024 11:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPd8-00055x-9h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:08 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPd5-0001LP-7J
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:05 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467777d7c83so20585631cf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934722; x=1734539522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBi50fBjO71qRLAMWMSi4czuRa2YaRF8EoteBaucdNo=;
 b=CH2GlJL4ok/nBk8GUaWx1tV6Q4l1CgV1laArdwFimhQvrr0XcWkwLP9Dolo01in0as
 5l3uZpppGJal5lbfwlWRb6MsNx8qXpP9gYnCQaucHY4DRvQH2oM8atiIB2BOsZVRnuCq
 LT19zBpTKYQUuZdwOlnV9fYGqoMxTOY/aC9WML2MqrEVEOLGii2QzL7SK4/SLx/OlWIj
 H12BX/n4uEzpy3NGV4aopHZjg9sdBGTws7DKa9g1OCLePhMzqmRQN12FQp/SDuIae60g
 R2M8/ZtYANoztXi+v5tIB+VNr5vm+4tVZ9LPAKft8Wc3/nxYAIah9UXcQNdWAnVDFx6e
 lzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934722; x=1734539522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBi50fBjO71qRLAMWMSi4czuRa2YaRF8EoteBaucdNo=;
 b=v/M19PdXZ7RGCG9FJ+JC4aTidvHQeAiWwjN74IgCC0XtEWWDHK2p2ZDHoVgBxqxkef
 RsML/iaKVfBQNI6NswLkBIN0a+r8j96PA4E5pCxvpssjiN0cDhaWgWgsMvP7Br1gA8ls
 To6QwWCNXSrY+SsB9ChVCHWdp5WIrJYzH4t3TOFslVsfKi72QZnJnetVI+jxtSSOvUcZ
 yzKqnvX3Ua0r+6xmpzkK8yWMNHIpCpzQHAw7tXldOjVtdQCMjF56YZ9YruJ/b+NToKtA
 pXbmT6SUm7LNY6HpZ3U4DgCd5b4VXtoNTgbJMmRD/tRPWS2bbZUP1AMw1v/ME6+7Hd00
 nDug==
X-Gm-Message-State: AOJu0YwPtWRjWA1H9g2/0ww7jPQ08tWkTYexrLtnKf0qlxmkbTfqSTp9
 VjGp7kRrGX/NbWqOglJJ8VNVI16i53Wgx2Z7/jWqRp3JfzM8UEVRiiun3b0Y3nk0pap+CjwBs+8
 4RelqpspV
X-Gm-Gg: ASbGncvjITy03WhXMURUtEcBZ1KCEiCMR4DIMcYYgRtwDzn/gpO3ibsaAnz9Wzo+Jx5
 zqSDS9X4ku07ebC4ATn1H1mJihw2Lwk8zk/RaXaB7Y/qU5imN7pHDISdrmk+T1AMSnMkA13fRJC
 IAYVKUX+l+EqvvfePr1fwZohY5XLVi9+Vah14d9n3IdLTDmQ0z+TcKE3d7E8OhBceOOow+8x51/
 5vDN1zCTd+CnpnD7eZQovvTwYHmYQkRFJycFv9Pcz1ChRbQAb+wzCEvw9xr9Q==
X-Google-Smtp-Source: AGHT+IGk1R+BzOsTCVVWQrZ6xuftVUNYG3N5YMqNz69NOYMC258Pve8wdXViHX4o5bF73TJj+W1kxw==
X-Received: by 2002:a05:622a:9009:b0:466:9f89:3d72 with SMTP id
 d75a77b69052e-46795423575mr6616651cf.36.1733934722165; 
 Wed, 11 Dec 2024 08:32:02 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 20/69] target/arm: Introduce fp_access_check_scalar_hsd
Date: Wed, 11 Dec 2024 10:29:47 -0600
Message-ID: <20241211163036.2297116-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

Provide a simple way to check for float64, float32,
and float16 support, as well as the fpu enabled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 62 ++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9c6365f5ef..4e47b8a804 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1239,6 +1239,27 @@ static bool fp_access_check(DisasContext *s)
     return true;
 }
 
+/*
+ * Return <0 for non-supported element sizes, with MO_16 controlled by
+ * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
+ */
+static int fp_access_check_scalar_hsd(DisasContext *s, MemOp esz)
+{
+    switch (esz) {
+    case MO_64:
+    case MO_32:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return -1;
+        }
+        break;
+    default:
+        return -1;
+    }
+    return fp_access_check(s);
+}
+
 /*
  * Check that SVE access is enabled.  If it is, return true.
  * If not, emit code to generate an appropriate exception and return false.
@@ -6628,22 +6649,10 @@ static bool trans_FCSEL(DisasContext *s, arg_FCSEL *a)
 {
     TCGv_i64 t_true, t_false;
     DisasCompare64 c;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
 
-    switch (a->esz) {
-    case MO_32:
-    case MO_64:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        return false;
-    }
-
-    if (!fp_access_check(s)) {
-        return true;
+    if (check <= 0) {
+        return check == 0;
     }
 
     /* Zero extend sreg & hreg inputs to 64 bits now.  */
@@ -6894,22 +6903,15 @@ TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
 
 static bool trans_FMOVI_s(DisasContext *s, arg_FMOVI_s *a)
 {
-    switch (a->esz) {
-    case MO_32:
-    case MO_64:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        return false;
-    }
-    if (fp_access_check(s)) {
-        uint64_t imm = vfp_expand_imm(a->esz, a->imm);
-        write_fp_dreg(s, a->rd, tcg_constant_i64(imm));
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+    uint64_t imm;
+
+    if (check <= 0) {
+        return check == 0;
     }
+
+    imm = vfp_expand_imm(a->esz, a->imm);
+    write_fp_dreg(s, a->rd, tcg_constant_i64(imm));
     return true;
 }
 
-- 
2.43.0


