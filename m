Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B4DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26U-0004Qe-5F; Tue, 10 Dec 2024 10:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26O-0004Ji-7H
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:46 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26K-0008My-TB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:43 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb5ac06111so1063009b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844277; x=1734449077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nd8zzXVe2AyFlBxa8S9FpLDGt59eCBt05NGc//xJzXA=;
 b=Mcso2TnhOhPxO4UiKj8j82OqYlN0VYqLqtOqTtcJTNOZokDnKVi63Ch5sSNET6GKSF
 ChnW5DodrTDWeRGzmXWUAtvVtDrgwECWRcsog8yH1MgoAvD1kOxwq6QiQeSKOEXIqhvI
 hNlO8RCAMoalRS/co7efb2iB+Y6yzKuF+8kDBu5XfsprWDrEVinS27btuz7xq16sMUgK
 PEarHhEH5DMY1hQlkqwSDqVfJdmi3sSAjs4YkA1Thg2phbGjFIMtIAF8aFqRcGQZhRtP
 55uB5p0NOSTzp+6Vnc8OYfY6Ql26fNzkt0K+Y3TkBNFNgeS8iMyfy8ogDBCbZZvsie9q
 3qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844277; x=1734449077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd8zzXVe2AyFlBxa8S9FpLDGt59eCBt05NGc//xJzXA=;
 b=XTRNo4Jnp7Jj4DlEbvdp+k5tJ9toO6sLYMLGvwph351gEn4gSHEBFC0EFjXLrMTrA0
 isnvjU4t9V56SOUzmUFxsICqBor3oU1VPylzReSbmsBlJ1fe7xVYvViksgHmSc5tdXeP
 f6MG9+HiwoDyLwYJW7a9NaIGSLc3HmNnoffQoUQHBFva9jcblf8Ln0BdSxYqtQpdbReS
 b0+qP8oIbfE7SKGuB7o4ET4/XqUbWUuBbA6mkz/oscXNwsubEM4+We3QHqZO9mdT4lCY
 u5Q6AZ/u/1ir8s3TE8RqGOhso8Wwwxb/itp5T2tjbwVN2ENBy9ZlB2mobdlPyUuFqGbm
 wIdA==
X-Gm-Message-State: AOJu0YzTyb74YSHvRYA+2MFwiKgN4TMwugbWK4kTHUjVntytwnxdbqjq
 AUQJNQ/nF3v43vfpEb958wlI5q3q1WD26hCA42LYpPdyoMP7Nx9ietNDokqLL3jMWIbEgyLTs2C
 wgBAs+JDT
X-Gm-Gg: ASbGncvL0fdI0D4TgUbygn9Axy/zIat1NWdvsu3O9ryV0Q0+I05+LWiTdTKw8WLKVvb
 fwbmLYpyobx7EImhs0tRS5Ta/9AtL43V7CH1bhl8Y4SNxfoG9+e1TpP88QGwmMQtTe++H99no7q
 3KjypDQgojk1v7+JIeWfsB1SBoDegbbhYt8e+3vacKk8vh/hURdmfImFk0E5nwptRsdWofs+1D1
 7Q46UBZNdSVkBcWRg4ftEyhiv7AbVVrHoUC4QE98mTzrz4ux/sUCu51rdFBQw==
X-Google-Smtp-Source: AGHT+IE1onDNT40JKUVLSwGeF8urx++cDJdDcqtQACI4Jux9v8haZn9GMQNk7ZqhyQAcRlFr3UMRiw==
X-Received: by 2002:a05:6808:1825:b0:3eb:5dcc:67aa with SMTP id
 5614622812f47-3eb66db43e2mr2761777b6e.2.1733844276778; 
 Tue, 10 Dec 2024 07:24:36 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/46] tcg/optimize: Use fold_masks_z in fold_neg_no_const
Date: Tue, 10 Dec 2024 09:23:37 -0600
Message-ID: <20241210152401.1823648-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 924ee165ba..cc3dc91d3f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2027,14 +2027,9 @@ static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
 {
     /* Set to 1 all bits to the left of the rightmost.  */
     uint64_t z_mask = arg_info(op->args[1])->z_mask;
-    ctx->z_mask = -(z_mask & -z_mask);
+    z_mask = -(z_mask & -z_mask);
 
-    /*
-     * Because of fold_sub_to_neg, we want to always return true,
-     * via finish_folding.
-     */
-    finish_folding(ctx, op);
-    return true;
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_neg(OptContext *ctx, TCGOp *op)
-- 
2.43.0


