Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643A0C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1p-0003um-7P; Fri, 17 Jan 2025 13:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1m-0003td-DE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:06 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1i-0007dq-JB
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2156e078563so33559485ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138301; x=1737743101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxnsbTwT3uqKOnkSfZkbXFJ/XlGe3xqFKdhh2O6cYGc=;
 b=Lf+0lnSaUqQOCgiEeKOu7olNiyl+vZjcbgAO7odHy74+LKtdbIcWdmrHzdSFRBJdf2
 lozg+peV5eL1VokKbwPwszmTCLbbBQuw3tPA/v8VaSEld1f51dWlZjScdOKiFy3/g9r4
 qUcNzwbVyzX+s2lNIaPFUmzoI+R2iZG/F44yLohnP1SqKFKnGTQy/VALo2SaXloSI05V
 vB0OzzwXfAQkSVDT0yFsCYotuKHEssn1U/XVKwhoSJQL7BhYgn/UuH2owEDMF0J06Z1U
 oGIA4W92PDZjUseXd7SCQC/3DLhSGuu2EHIxh18CZ4Qt47tx1+7KWLB0/oCtn990UAM+
 gpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138301; x=1737743101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxnsbTwT3uqKOnkSfZkbXFJ/XlGe3xqFKdhh2O6cYGc=;
 b=iwDePuZaL/hFF3epP785ezpniaGldYA9BpiDIXSbBMDui6X0+DG+QsE5fkdfhSx8fr
 4g5vG8Pq0qwhG3QuUZOoWBN+S31LRBYgbMnoZJaUyWHNJDtiYxS9QYbcSVvJAEmn2l7X
 tnPZ/rlEdVd+PXIOaCuivSqmnHXwU157tEQVgjloMKkMVH+vqGqg1mfc9bsUNqp+lFeP
 ciTExctiSUpAGMQ1wAeetlJba0eGeirHYuICgDIiPEhikAFeugmP/3SrGjDaT13UIqa5
 2E+32Rq+ImlLjL3RHO9GQBuMfzv5/ejocotdHN/XGKGBbROf3FUR35ghXe2g440WUZFy
 qaQw==
X-Gm-Message-State: AOJu0Yyb8Dd3DJ2JwDMMfmRCatwut9z4ip+Lk9BN00naUfn4i4PV9lGt
 mfBuPHeabk1CQTZY3BV5HUBQDd0APuHQV2BQ4khBHWpe7RCF/FmhRmlN4sym6DOYMwW425eCY22
 O
X-Gm-Gg: ASbGncv8mqDjq/A2oXsmMoAyFMnvcOonpL/gJOxKfpCmYP4/3aAFH47fBWCcwPe0FTa
 FeBBafklZwZGd+NusSi7gnJWpvqJXOlwOmknsECzeuWcPv/yRWrXtYoFnTYm1lMwP+Szt+ZNEqW
 M28T1EZSdSKSizVfaJw0QvB0BaYK5YPCLnqjO0i+5RuzaYNBzHCxi9ij/3xuJGZ0X7dV2Q81tK5
 TWbcLe7ri2AeVczpnVTBEVi3Foge1ydN90ogggaJBvgqc09p7lY2GFqjw5AzN+yziSHUFIF4cHm
 OKj6txokDaxR6Qk=
X-Google-Smtp-Source: AGHT+IEeDxQfNq5cuJwak+R2DxJrojAne3rXFTMR1jUAV8/Jr5bTFudzdf1iwVgmxfzayBZCJlgZ0Q==
X-Received: by 2002:a17:902:f645:b0:215:9379:4650 with SMTP id
 d9443c01a7336-21c355ce65amr57547915ad.42.1737138301159; 
 Fri, 17 Jan 2025 10:25:01 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/68] tcg: Move tcg_op_insert_{after,
 before} decls to tcg-internal.h
Date: Fri, 17 Jan 2025 10:23:52 -0800
Message-ID: <20250117182456.2077110-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

These are not particularly useful outside of optimization passes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h  | 4 ----
 tcg/tcg-internal.h | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index fe053296ac..5d96cdfc30 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -854,10 +854,6 @@ void tcg_gen_call7(void *func, TCGHelperInfo *, TCGTemp *ret,
 
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
-TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
-                            TCGOpcode opc, unsigned nargs);
-TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
-                           TCGOpcode opc, unsigned nargs);
 
 /**
  * tcg_remove_ops_after:
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 072b36d85c..a648ee7a0e 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -106,4 +106,9 @@ void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
+TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
+                            TCGOpcode opc, unsigned nargs);
+TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
+                           TCGOpcode opc, unsigned nargs);
+
 #endif /* TCG_INTERNAL_H */
-- 
2.43.0


