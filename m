Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E6CE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMU-0008VA-CU; Thu, 19 Dec 2024 23:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMH-0008Q6-0m
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:26 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMF-0006Lo-Lk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:24 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fd2ff40782so1278039a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667882; x=1735272682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9O0R53WBozPK/I6haxAxuHnNfQ0ZmBvA6nPgwPPpwik=;
 b=piVosxdpT6WLwOZs8QxDhzHhPI8KxA8qWCBExNg16MbW/sc6SWhMj7R9DUXMdco5ql
 E3kADkR5D/oM77YnytrA6rYbDYV374RghkO1Jyrz8HWL8juzE8YrDoyUrJJWK2pCPCb/
 eh9jnahdKVFGtmJyeauDYpsyoA1rGIKmos1Y5gAH1CxUbUVLcPKLYTR3wyycDvkpqgxA
 QJgju0Sls7dVSYYm0BbM4nu0KPEXqUPDT+ICLY24q8ueKbKVhvRQxVw2WNeW7GG0Geb8
 TXc+jrf0x2XTiLCelFrtHoE+6yw5eJoBiQeyJhXarUX0gjE3GAYJ33+Ws6wf+zJXqcKj
 YxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667882; x=1735272682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9O0R53WBozPK/I6haxAxuHnNfQ0ZmBvA6nPgwPPpwik=;
 b=LgH1gEP1HXLNVc7PjiKrsvvWd+I677RRL5eokR0JDvD1yCb9iwRToOf4kVgrDsRgVA
 TEY6keszZNWtIEVrSE5VTdz5charwHVzsjaM0D+n+BkNU9xPVPuutjImDEqIcEfqTv4s
 GUsFL4JkSywH3HJnFP6aKAr1bqgOdB6/9GjK+Oe4+SSHlwOhZ5fs9YDmjYQLEe3MzDr0
 w1dIP+2M71juXCbB0NKMdwqJbXJas4BWDZjvSuQf6QdWdy4gyZvQNXDrYUNip9U0qlIZ
 VOvxWAW8pRhRQmwlsMIFwu1M5xGRmRZYVgIHcOssc+7Ew595ODjmS0oFEZvRVBKj9Oow
 7oOQ==
X-Gm-Message-State: AOJu0YzG2fHRqft+EEyGZMywy6b1dBdMgCA/O/pdg0F3IErm0QSwznMc
 FDFyn/OEMfxdEKTQN7RqECXM8PrV/spg+6rStKZTLLUch97i0JjRoCROIpxlSdyzArpG+eVLgJq
 m
X-Gm-Gg: ASbGncuBz5QoiU5jUyZCybz1tf+2XanCNegRwtxi25LE+bTFjg27XdjdP9lgVoDsz/4
 ze/fCSRQlGtZ8b9QA4WHDChaARPKRp9nDDfUYPfah1BuUj5V2CDbeStJupwHLtuGQz2Eu7n8kMv
 SG4m2YP0ZVsQnG7xzqhsc1IktHpq5W3pcaT/2YXPUoFjFBbnCTnsahTTXUwku6stxhZOmaBuCft
 rP861NOqscMOUGFa4xZLBn9EszGQItHoploHoYmQOYMcFD2aVcxbpijWXc1Xgk=
X-Google-Smtp-Source: AGHT+IEd8C1N8uBkeX24a5/gVcchpvtipU8dtfpuwnSuqI+ag4wfq0dtTFgJIQpKmXZBfCkYWIyQXw==
X-Received: by 2002:a17:90b:2e0b:b0:2ee:c4f2:a76d with SMTP id
 98e67ed59e1d1-2f452e4ce1amr2034024a91.21.1734667882366; 
 Thu, 19 Dec 2024 20:11:22 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 24/51] tcg/optimize: Use fold_masks_z in fold_neg_no_const
Date: Thu, 19 Dec 2024 20:10:36 -0800
Message-ID: <20241220041104.53105-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c206c0f40d..baf545df24 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2061,14 +2061,9 @@ static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
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


