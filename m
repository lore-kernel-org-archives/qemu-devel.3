Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04ECE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOly-0002ze-RU; Sun, 22 Dec 2024 11:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0002dy-JR
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:20 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlR-0003Cf-CF
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:12 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21634338cfdso44206715ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884708; x=1735489508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUYADiY3+WTGRvCL/U/4AVuD6yzbpDWFFsVQejGxj8k=;
 b=LMQfckOasfIFv+UiEp8m+NXgs0Sj4aUg7uDCIyKeen4FRBjlug4yIoe8hbCET7aPeI
 UxByj+VT76hqdoasZ2+NJFtMU7fKEol8JHFqk4m20tQN9usDOawVUC8aJqD8O3Gquth5
 4rYhnUIj5A6OkpBzK2mlKIeaUJ3sdE4rl43nAEurIMCdqX0+Qlu7QgZpi4U2K4kN1B/W
 3SrIsse4olVFgnHMnnZ3pfmePGx+x30ZS/btil/aM7lNtTg+ewBH/aoS7L1OBhVGNFYG
 0Rhd1nn3WBmIjirKK0RkjBw+qeyzZ61colZyfJAa2Xwx8E31rLYtpncIvQT5DBMkms/k
 ca1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884708; x=1735489508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUYADiY3+WTGRvCL/U/4AVuD6yzbpDWFFsVQejGxj8k=;
 b=uR1K4FnY9cWlrr94+3FKTrDTnn9AabGQkM1MbAY/OQFOwj21wsccpXmG/MXuGU7D5/
 wqXlCjotu9N/NhaXKX+WyygC6Jt/ELVnFHN5PqMI0zcBrcpzF6wCXY+JSLXkjSvZIgMO
 72CWGkme9Pqo11hNTxa9xo5/KZM3bXJvaVSMGlvYq/d7Gy8gKx/192HdXF78X4rx0JsU
 p7d9HWvSFS8SO3Cd92vJyZlcJ2FVDXTtW9AR8pR38smnSI52weX+4gQ564hi0PFNsUsx
 eKb2fvSStDtH/TRqg5YXJ5Q9GQ/d2iClKbanGDH4hqb4VnWFzATnlS7s9kGoKckkBxsU
 Qjvg==
X-Gm-Message-State: AOJu0YyU/JAfMVe6ubiGFP0nCF5Hzq1XN67yhMON+GfzyWJLnRWNuBzx
 /I+VVhswSCBPDavC4g7XE/M+oq05if1n/hcpZgvSAxNHk2hO5mKtlkHy8kKLTQYzeg7U92Djtfc
 +gx0=
X-Gm-Gg: ASbGncuYg8ywAmy4T+nfDgmn6KZwiYpqhTcgYbJUfvSRXAUORGCMmaA0PGaW+yT7jPf
 TJyyMCN2bMIpLb8/nXThc5WgowBOkAe7nbjBTuXvnLNyPzg2lnMBeirZ6yMhbnGPzZjrEMkDrNa
 KQ4mGIausZjZ4cubDXFX/Eu+dG2IDtpw0mo1D8S0fueq1aU4/hDm4Ti/B2nSKwJOm5B00VNNUJe
 QfkS3R/mLUM36sf7pdy6ZuMnyB9VGXu8CaWqlX9vI16d8QrI1p1d3Gipe266OM=
X-Google-Smtp-Source: AGHT+IGiI91iCt3xVyQiwBGeonJBl1If8r9zgeV7ydn5l6dXhYSPI6p1fO/4bINLNKi+gbmLuychug==
X-Received: by 2002:a17:903:120d:b0:216:5af7:5a8e with SMTP id
 d9443c01a7336-219e6ebdc17mr141166635ad.26.1734884708146; 
 Sun, 22 Dec 2024 08:25:08 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 32/51] tcg/optimize: Use finish_folding in fold_remainder
Date: Sun, 22 Dec 2024 08:24:27 -0800
Message-ID: <20241222162446.2415717-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index dce68ff2cd..c44356cf73 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2135,7 +2135,7 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
         fold_xx_to_i(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
-- 
2.43.0


