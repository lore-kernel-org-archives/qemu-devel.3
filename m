Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0A5E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlx-0002yL-LH; Sun, 22 Dec 2024 11:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlY-0002fl-Ms
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0003DK-8h
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:16 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-219f8263ae0so3324755ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884711; x=1735489511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lUoYR6nKXENDg58VCViQ5sw+cgNSYq12wwtR8MB1B0=;
 b=xzb9w1D8lQTndSxX/Zp6nAAwluLR5coLpncX9zGKlaXE5qAeNaMPjOUyly2XZSYD+o
 q1hJnE6x+B/tuoJhc+9tehaaAXDIA8Rf8ybi4NtehJd9FNJEcDklQgNFfAtVOopzTNx6
 AC/zKUeU00RoaKd/T0g+lWlONT4GRAKUo0QYDkNzyeypN0w3gwWC0m+qLpJxrvfMq9Ze
 L449HwuDUp1k1FoMrNeVWwjHjZoILqgg96L9eJs5qswPa9EWxtMCUfxGRF0v4u+Ksf1N
 WJljhNEarKG2o5c2/gEXvAEIX1ka6zf6BkingUdhCy979Zs5Ib/LQGBsnLyrDA36NqmC
 6g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884711; x=1735489511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lUoYR6nKXENDg58VCViQ5sw+cgNSYq12wwtR8MB1B0=;
 b=XeUGJPAnenjNKuA2ZvqEgkJu+A5FBxCE9AlxmwFd7HQgpPlNITY4RP/+wAH3W0SjKl
 lB0s3VdyYVZPBxV4pdDgx0mPlKcBDiY5q3V9QEek99l2vtLHiyAQjCsOmU4l80qdW3mf
 uNZkSuQM5KkdsiT73ZzUKwVqto7K7qMxhYvAqRsHBdHyWY2tng9PKl/KVv2UmEh8K2Uo
 M1cz8n4zPEyTj3m+ojq7taeQY92tUWo9vvsMu6Yerh0laGNXreqSLGlnzErjs4IbQ5qp
 sIdubaXadBYpXaU5os1XDsrNVxxjPZB9mcUjQap7S4sYPOF5zwSIlxGMz61LBsC2psIr
 5z3g==
X-Gm-Message-State: AOJu0YzLooKjyk3GLu85EEyxkrfp9UAoQcMdggiTxtPjVMFyXaEQpom/
 xTXtqYOTZEFU/sHUKwUxUgdVX3OENF0pbDsNdd2Ex9B6dt+xfcwGvnrJ5ATL5Epo6au7VFYcXc6
 k4F8=
X-Gm-Gg: ASbGnct8eitKFgyTiree0Gkoq9iBDwv2JsScFACiCH0OtC0pLzgegRYEA79ar+uLpiP
 k9Gy6viSC9Bw0RNYEEZq4iE9gE2Tu3mZkZ7Cv/rhBUtpoUgImpl+S5Qh+vKQBbv7CKADNMDIufu
 Cwdrc56bkwOJxD56O5YUbtsXrbqEVFD3K+jSyuzDNf3Qv7BVDaOSW8eHOGBdFgurAHNm63vXN97
 F0X37ad1jWBdSMSToZK9rzZ0ZDqZ85LSl0qEul3eKiHJ0CvzR9Uf9Cp6lhN5wk=
X-Google-Smtp-Source: AGHT+IFiGlORJK6dhlUGRLMcnAhqHn+dDK/KrN5KPUIxAdRkDs5vNdYRxoxuOhZ7LXU2IjtnK8+AGA==
X-Received: by 2002:a17:902:ebc9:b0:212:fa3:f627 with SMTP id
 d9443c01a7336-219e6e9f9a2mr141309185ad.16.1734884711136; 
 Sun, 22 Dec 2024 08:25:11 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 37/51] tcg/optimize: Use finish_folding in fold_cmp_vec
Date: Sun, 22 Dec 2024 08:24:32 -0800
Message-ID: <20241222162446.2415717-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index e5c46dd6e2..db26cc347d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2463,7 +2463,7 @@ static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
     if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
         op->args[3] = tcg_swap_cond(op->args[3]);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


