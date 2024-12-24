Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7F7E7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDK-0005yA-RA; Tue, 24 Dec 2024 15:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDE-0005UV-8C
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:04 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDC-0002uw-Nw
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:03 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166360285dso57567695ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070941; x=1735675741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwVb6jhXptH+wLf21qGtM54iqz3y5j9Rj2TRVse+NVA=;
 b=WWeS8WFURnZjaMYNS9eNduIxP238ZCMB6E05CnUMKBaWPFgE7Ujcus8iZX7mvjcbIu
 eqyXxUdRLuOW6k0T+QL4fCeWvv8yiL1+IaT8DbDlm9u6YToTr5A49GktY4EO7hJwXKaf
 8TQwvqy6sFjQgxhLE163FpHn72AmukUS9zrfhwVenCcwC2CPpgrq2F/ae5RpATIGHL0G
 o9RjlS22hLtD1RlvxXHyethbbHkFmGR2Qi3BozoUqJB+f1kIW/OMcKcbWEVV6VppzHZO
 WhROEYNk5VbzbEfvipXrJWdLwbn1UWbmI6fzYZazjqHSR7nzcLMgEVtbJ+80hh/ln5X1
 bmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070941; x=1735675741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwVb6jhXptH+wLf21qGtM54iqz3y5j9Rj2TRVse+NVA=;
 b=scP85/MniSCP9rM5rtmL0cBfW5orvTVK8jfy8heNTh7vpzQUf1sJ+1O8EaTBbq9RZx
 i+ygo79AiGGo2amIbEJqV4h7krpSuxx4tF7EDe5bV1+PG3Vt6kpmMoc4p6nWNw2bvnL5
 ZKLkTWJVVszokVp7GYXUyLwwQZKMOqaMyOr0rksmSvPjrn4L4iFFnq+E2DNiiWaPWQ+W
 M2fnVAHp0u9geRUknZ2EvMpB0nk7gXj55caVHaXuwDUxttInAPXTMSxeLaVFV44lDikH
 /dagoTmN9rTXbzdU1N/cSkaSIn8Y+8INi/KEit8h+I6m3lVLdev6tsesiAfSr2gvs59U
 lrwA==
X-Gm-Message-State: AOJu0YyDSrJo+npDOgAhLBgAavFBO4WBnO1bqWVwakEKDFji6swpyZf2
 um4C5A+sDsLwJHEdvhH5lthpI0x6xpH9JIpltMuvPSNv8m0B8tnYh3EAWRqYs0fPEzJBNcvkFJ5
 +KLY=
X-Gm-Gg: ASbGncvqLETjiUthTBKrAmsQMWxXJ+XN7P6FBWl0RiPX5A2uyMu3Hyb1EjRVmVRXsll
 0SgiMQjq4NT1i5za0INGYteEVFVaKsFxZGenoJV/jH0EqH4NCziB70m2aeS4Jr/kvAONIfglB9E
 aWsrI4kz3kUBO9s7T7Q155aUHVZC9lfJuIiF3ZYYq0zl1zy/aLe0E1uDcCOPUNbOUS9sIOAtyln
 eTG+eVF460vpskWJNsYWKp35jEAYFINHPeCivTfLqqEdjNC8wd6wF7oV9hUizPaKxxNOkHU0hdq
 qoBX5KNMP/+FTgYbIr0P6Bqsjw==
X-Google-Smtp-Source: AGHT+IF711Co5HyMxZFjBqxV4pnrC/foHncNzw8ma9uvp/Ur0azeyf6aYk6Wa2ze6jk5Fz8BNiDT1Q==
X-Received: by 2002:a05:6a21:9994:b0:1db:ef68:e505 with SMTP id
 adf61e73a8af0-1e5e05a9ef2mr30884582637.20.1735070941285; 
 Tue, 24 Dec 2024 12:09:01 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 41/72] tcg/optimize: Use finish_folding in fold_cmpsel_vec
Date: Tue, 24 Dec 2024 12:04:50 -0800
Message-ID: <20241224200521.310066-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ccdac7b7d7..4090ffe12c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2501,7 +2501,7 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
     if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
         op->args[5] = tcg_invert_cond(op->args[5]);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


