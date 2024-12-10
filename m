Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1423AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL264-0004Fo-Bf; Tue, 10 Dec 2024 10:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL262-0004FD-9Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:22 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL260-0008Jy-PL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:21 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb5ac06111so1062855b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844260; x=1734449060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4YBmpSdInFRyiSQAIBGpD3jWrB1OjvXqUyp17I9peK8=;
 b=NfocZI5CtR13hW0edQ6piERUB9mCSI9aOWdAs9Jys3bpLHf9UyRpoEB1fHnez68fSs
 pdVRrcTRvdD+IJuHY8iMRF7Enwqy534LUmAn3ZYACgbD+b50q7yx2yeOZFB4do9pHAsl
 P3fnb3dYTGgJb1v7ilHoPgjZ6tpCo/yslQUypGRdQNi21o6gwqqipwj/fNxL7MSZ0qq/
 bg1EIWp722NbehXrg1FNbdQ/kX3v34ra/2RogAWhZTLN5mbTyOwLdNTyI4yQ7SwDJtqn
 JYY/uwxCnvSODk49g68kfPtdDXUeALknm+K6CQBC8vizIKupmCDx2+5IRqEal4JjFeHE
 Mzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844260; x=1734449060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YBmpSdInFRyiSQAIBGpD3jWrB1OjvXqUyp17I9peK8=;
 b=iRgXqrY9WrgDYy1eXXq35offZD9wo2p47EJD9zUxajHs7AriVJLTxVFOn1FoyEgIRp
 IpbFR2mA2I0XLVWeQwN74TtQG8f7V5yuHldVIExO51nMwix9QFOeW3n53kRyK5MQ3Y2C
 PG626Sj833CLNX475T/Qy0FZek7WTFuKcwU098/cIvSdXHgW8YnIqCq2Ui69nDINnAzM
 wpFOLOs3bLRMH3ZBVU80RJeTQXCSnc+nU/jof3e6QcDVQ3MosqoGOHaAk6p1gqFPI8QM
 V6BNxuZtouuzEfdGnt6w3NdQA8j2dmwNYzHg/j1yJNfGvUfOdM9EkB1qAI51Ylb6tN+u
 xI9g==
X-Gm-Message-State: AOJu0YwLZS8fEFuigO4E2WKayDoNsu2CEfOOqHzQpKhoJ27PirYNK4Gf
 abxHaZvtuHrctFgRz1wxHhBRRep5t/bTCS744Rs3aqwYhD/KMK8+8aV5kii//xIP/yNfvOLYnIu
 isOXzjgOL
X-Gm-Gg: ASbGncstPiaZPZADIhXm8VxXdYF3ywXuR6jrgHtPIsxpXRjAROMZRDxK/OXPj/7dRvN
 jU+IwfO2B1UlVoqSf/kjj3jk9bKb0JlR3WvU/axIuO2baUpqMXCL8pST7FZC9VqCfhBUcH28b2F
 jgGi51tiRJdSBhS4tfywiYUoEVrnrEbrVCS1pv6ls2lrtz+DyUQHru+EQbCv7AozmoDn0L1yRgL
 gONiGg3nKGdEEhea2t5XHJHznLN8Uz8rH2Ry5D7VPbM9TfBoAdQFRTSu+nlwA==
X-Google-Smtp-Source: AGHT+IG3bW9N0M7RFbCCWj+hoaEM60C9OFLyPtQyostibkz7dA6wqBUD+nMs1WUJWhicYxMiKhPzgw==
X-Received: by 2002:a05:6808:192a:b0:3e6:402:d228 with SMTP id
 5614622812f47-3eb66de9f97mr4103839b6e.13.1733844259694; 
 Tue, 10 Dec 2024 07:24:19 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/46] tcg/optimize: Use fold_masks_z in fold_count_zeros
Date: Tue, 10 Dec 2024 09:23:24 -0600
Message-ID: <20241210152401.1823648-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 tcg/optimize.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3363ebd48c..c97ec10989 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1088,7 +1088,6 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
     return fold_masks_zsa(ctx, op, z_mask, s_mask, -1);
 }
 
-__attribute__((unused))
 static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
 {
     return fold_masks_zsa(ctx, op, z_mask, smask_from_zmask(z_mask), -1);
@@ -1592,9 +1591,9 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
     default:
         g_assert_not_reached();
     }
-    ctx->z_mask = arg_info(op->args[2])->z_mask | z_mask;
-    ctx->s_mask = smask_from_zmask(ctx->z_mask);
-    return false;
+    z_mask |= arg_info(op->args[2])->z_mask;
+
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_ctpop(OptContext *ctx, TCGOp *op)
-- 
2.43.0


