Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573C1E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbL-0006yB-54; Thu, 02 Jan 2025 13:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb4-0006vy-QP
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:05 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb0-000571-Tc
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:00 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215770613dbso117110815ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841217; x=1736446017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dv1D0o1BRRNeMC2UJChBwH/iB31bEyOmqEsQs64+U2o=;
 b=lUfq6gb2uDJoEqNzzAlG2cbXALhvxXCYu9+PGapCs7w5+GvDa3Qyx/RwJR45cVGnnH
 7Y5/IR6VyPoGnIP3W/V/ryOEiHx0DTdkmN/AC5/HUGmq1vhDWUMkPyqj0AZqfSXgLPrQ
 CuZ/NkM67ztM2sPkjasZGy6XBm8HbD1zSqBcnZPI+fRcCPZIoLJ+DN9ThWhEUTPpfzL4
 EU7+0UhgbEoFNq9HIvRFK65fPlTgMSVASIvNJk7LUkFEcH1MLXttrPuUPuZLNmisT1du
 CHv53rQYk7gYiVqoY3Tie98RBtwKPDd8Jh6CcFaSNFLC92tBzC31rPyMxl2wEwNVKx+d
 14ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841217; x=1736446017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dv1D0o1BRRNeMC2UJChBwH/iB31bEyOmqEsQs64+U2o=;
 b=PqV/t1zpXxE9dGmylEc2zAA5NdZkMDH7lBVvOlyh2tHnPo+Xd8fZO23/3GMJe+nCzp
 oxNqrmO3p6Lb6J3AC5+46+pTIWcf9+QdVuTWGdTDp1K2RfzU0tPpajJQyQthmji0fcDK
 TL55kJdN9rwST480MEHrCiVC3seUPb8yKyZJB8dn8pvFUjePg9dhBPfn5ndp27mNWauz
 7T8Egwfs/cCYf+VsjPUH3J6wkKx4nJ2iSJ6KY5ooXya9dQxhMTRJKa5l6oY0yoz9gOHX
 Vq5m2GdiMbR9suTFXrJd10jcUx6kOpoEb4LdTY0Gf15Nf8WpXr1idDuoPFun4C9wCVtU
 YNrQ==
X-Gm-Message-State: AOJu0Yw25MLVki2p+NNr9lDa+wSke5z/rmlLNhkK2+r9f0bskNP/Pf3O
 WLq0faleZXEmCt8jQLThZokaB0jRZojfkU4Nx6xMmbMMM4bwjK1lTxspuVVFMM99RBVutEJ0hSM
 r
X-Gm-Gg: ASbGncsZ4rIUxfatJ6QhMD0pGBcPZqsanwRcUGfnsQOgDlYL2bZrdpga6Rpmq2b1nCr
 oeJkdJdEBD8jZdBf/FCjALIYmgMF1qRNzdJ4j/TakiIn4q70ccW86bQYf0FDYQz1LZX7lRvKzoy
 9rPsmnpQFW9ABf3ItVug8GRr9GOX6is65OEe4otc0e7uORsTWwyFErudTVWA7PheQSlVYAxzNJx
 T0f7Ahs7XrqJiMR21DuEunP7mLhAkiv72HrSCO6ovTSX2xY6pLr2siTBpPExw==
X-Google-Smtp-Source: AGHT+IFH3JAMY+DGDt7y4PRI7FV4dLta+tBmGbyVCLeEpkhA1Aoviapk4rm8rgYPm0Vgszd7BxPT0w==
X-Received: by 2002:a05:6a00:4090:b0:727:3cd0:1167 with SMTP id
 d2e1a72fcca58-72abdebbdc0mr68482171b3a.21.1735841217444; 
 Thu, 02 Jan 2025 10:06:57 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.06.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:06:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/73] tcg: Add TCGHelperInfo.out_type
Date: Thu,  2 Jan 2025 10:05:42 -0800
Message-ID: <20250102180654.1420056-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Steal bits from out_kind to not increase the size of the structure.
Both types only require a few bits anyway.
Fill in the field in init_call_layout, but don't use it yet.
Void calls get TCG_TYPE_I32, as there is no void type to use.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h | 3 ++-
 tcg/tcg.c                 | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 909fe73afa..7730826867 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -58,7 +58,8 @@ struct TCGHelperInfo {
     unsigned flags              : 8;
     unsigned nr_in              : 8;
     unsigned nr_out             : 8;
-    TCGCallReturnKind out_kind  : 8;
+    TCGCallReturnKind out_kind  : 4;
+    TCGType out_type            : 4;
 
     /* Maximum physical arguments are constrained by TCG_TYPE_I128. */
     TCGCallArgumentLoc in[MAX_CALL_IARGS * (128 / TCG_TARGET_REG_BITS)];
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f8c4394e1d..9a1e85ba41 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1138,20 +1138,27 @@ static void init_call_layout(TCGHelperInfo *info)
         break;
     case dh_typecode_i32:
     case dh_typecode_s32:
+        info->nr_out = 1;
+        info->out_kind = TCG_CALL_RET_NORMAL;
+        info->out_type = TCG_TYPE_I32;
+        break;
     case dh_typecode_ptr:
         info->nr_out = 1;
         info->out_kind = TCG_CALL_RET_NORMAL;
+        info->out_type = TCG_TYPE_PTR;
         break;
     case dh_typecode_i64:
     case dh_typecode_s64:
         info->nr_out = 64 / TCG_TARGET_REG_BITS;
         info->out_kind = TCG_CALL_RET_NORMAL;
+        info->out_type = TCG_TYPE_I64;
         /* Query the last register now to trigger any assert early. */
         tcg_target_call_oarg_reg(info->out_kind, info->nr_out - 1);
         break;
     case dh_typecode_i128:
         info->nr_out = 128 / TCG_TARGET_REG_BITS;
         info->out_kind = TCG_TARGET_CALL_RET_I128;
+        info->out_type = TCG_TYPE_I128;
         switch (TCG_TARGET_CALL_RET_I128) {
         case TCG_CALL_RET_NORMAL:
             /* Query the last register now to trigger any assert early. */
-- 
2.43.0


