Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DDECDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZGF-0004st-Ic; Wed, 24 Jun 2026 21:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGB-0004pY-U1
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGA-0008Rw-44
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c7f123b1acso9537415ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782352324; x=1782957124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqjKU3c+leYpt9e4i6lXk+cebj4pDBPglHOLDzf6M38=;
 b=xJE3q372X71ObTRssLlEAEQyQDgoPnBlKrbdYH7DBTBTrRq8LknIhulMX4fEkoPexZ
 XXvEEl8xXyvCpzXHsN8/iIVNAxGBI9gXdOw+LEPmbpvv/t+lEtbaIC+FPRyArJSyk1hA
 vFnifKCZd8UfhWZnDMGRTRV2cq6EKY4x7w4JBjGl6oLnC5M9A+YvyFFHSSlUgyssJ2rj
 AuG2Qt3i5UFg6cTYZc8vmWEOstdRgInqqsYR4fVhNoDaR5wvM2bQgCtKY2i42K9D/usT
 RCqifflTbOFteIyqAyv97l/7VZoRAujs0ppXJIyiJR8WJFKnkzZx8aP58QGa5PDFA62r
 QKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352324; x=1782957124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kqjKU3c+leYpt9e4i6lXk+cebj4pDBPglHOLDzf6M38=;
 b=QoHjTC/c63sIvcHt9iFiQgQv2R/cKtqxV95FV94QrOsN9E+FMmJqIoqOgqjIqMcx26
 NyqEvDk6CPSHH1RWzMSaUCwecW4Q+rzRQ0ZXWTsUfvXLT4GnV3A9uzRyu+WJkzXBlFh7
 SS7khrWpPcG8v1oAMdEhl3ufrexbFKQHVAH+C+tWGuaz51wT+54QZpKs6fWwwJChEVOF
 OdyEq5BwNPVuWswbVbuN9otEbDMvissaZ9+qG6ePYLsIKBUvd58rPaJnuCBhT83ijOgz
 3l/1cnQ1fxhrWPluR8+tZfR/R2LAqftWUO0EBo4cnWWjFvXwvqM+mjNfxzeebjAXV1wJ
 Qvlg==
X-Gm-Message-State: AOJu0Yz5Z8TdQEJIqDlVFFSHJlGMpJ3BqHsVqPnLasyRBsDqBAwv2GUk
 /0XGMvx8xN2dZlEtXVVapeOKqga6EvVIJQurI1BmfurbzzZTyNXceNUAUgnDI7P3c+CX7EfIKBJ
 XArjV
X-Gm-Gg: AfdE7clSQErxK60DuDQaQ3oggeq+vtWVGnjSUkBy0wftwnptTHa+RVRv7j7IzJDoEWj
 vI/uj5vX5joA11Fjs+61crPtT5McTzCO/foc6Rf2JWMxfUKWDSI1QA4MYo3rUIILVfmdJKWa//j
 t/fqXwwBCcbYv1PpIuc4MrrNthqg8NKnxbNgictC8mjNLtrcjq+E+dsFVT3RlKczs+aVUV8Qbtu
 Gk6hpqIN4FMS2ueRgcYvKt+vgQ5CWovlnYNm5I9P6yTdT76B3VOzOJzooUndbCHFF0VFhvd3Poo
 lMwCdIpkzYO3UyONHZJOincLzMTPoqrQrMBtfa4fjnImAQaabPYegNi+nmc/TOuAFTw5mtvlQM8
 ypq9E5m8WJyQU56hjjjuV4K3f2AFVImaZGO6ur8SMXplHFv6MM6+9M6tSWfWhUgruQ1tGnqjJHX
 8qFUCblXyC1unJBg9AtrdCVG5N7hBpirMEfu3aLdZXsHw7QQBylg==
X-Received: by 2002:a17:902:ffcb:b0:2c2:f675:32c5 with SMTP id
 d9443c01a7336-2c7fc73e595mr6490945ad.29.1782352324464; 
 Wed, 24 Jun 2026 18:52:04 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8908sm9060635ad.8.2026.06.24.18.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 18:52:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/10] target/arm: Implement FDOT (multiple,
 multiple and single, FP8 to FP16)
Date: Wed, 24 Jun 2026 18:51:53 -0700
Message-ID: <20260625015159.719300-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org>
References: <20260625015159.719300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/arm/tcg/translate-sme.c | 9 +++++++++
 target/arm/tcg/sme.decode      | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 98f6eb0b70..3174b10c30 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1196,6 +1196,15 @@ static bool do_fdot_fp8(DisasContext *s, arg_azz_n *a, bool multi)
 TRANS_FEAT(FDOT_n1_sb, aa64_sme_f8f32, do_fdot_fp8, a, false)
 TRANS_FEAT(FDOT_nn_sb, aa64_sme_f8f32, do_fdot_fp8, a, true)
 
+static bool do_fdot_hb(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp8(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                          0, 0, multi, gen_helper_gvec_fdot_hb);
+}
+
+TRANS_FEAT(FDOT_n1_hb, aa64_sme_f8f16, do_fdot_hb, a, false)
+TRANS_FEAT(FDOT_nn_hb, aa64_sme_f8f16, do_fdot_hb, a, true)
+
 static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index c6e22c4999..fbf5f3720d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -456,6 +456,9 @@ FMLAL_n1_hb     11000001 001 1 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
 FMLAL_n1_hb     11000001 001 0 .... 0 .. 010 ..... 001 ..   @azz_nx1_o2x2 n=2
 FMLAL_n1_hb     11000001 001 1 .... 0 .. 010 ..... 001 ..   @azz_nx1_o2x2 n=4
 
+FDOT_n1_hb      11000001 001 0 .... 0 .. 100 ..... 01 ...   @azz_nx1_o3 n=2
+FDOT_n1_hb      11000001 001 1 .... 0 .. 100 ..... 01 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -585,6 +588,9 @@ FDOT_nn_sb      11000001 101 ...01 0 .. 100 ...01 10 ...    @azz_4x4_o3
 FMLAL_nn_hb     11000001 101 ....0 0 .. 010 ....1 000 ..    @azz_2x2_o2x2
 FMLAL_nn_hb     11000001 101 ...01 0 .. 010 ...01 000 ..    @azz_4x4_o2x2
 
+FDOT_nn_hb      11000001 101 ....0 0 .. 100 ....1 00 ...    @azz_2x2_o3
+FDOT_nn_hb      11000001 101 ...01 0 .. 100 ...01 00 ...    @azz_4x4_o3
+
 &az_n           n off rv zm
 @az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
                 &az_n n=2 rv=%mova_rv zm=%zn_ax2
-- 
2.43.0


