Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B03C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSA-0000cp-7R; Mon, 30 Jun 2025 11:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0000SH-AP
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:28 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0008D1-Fz
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:20 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c16e658f4so1155440a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297345; x=1751902145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5c+91NkfpqJwYGyED+jYrmkB7CYyaOBwzdlo8NQO7hw=;
 b=Ov4nUR7366BItrK6VFRBjkZIzhc1vNZF29VcE7++PsrgcoKZv6T4SXRJsUu6xB+ry9
 MsilsF72ifz56rx/5Iqcq/uzoYOKONXQVVQa9a4up943Ao3hY1r3TYUDRYwoYiPug2+Y
 NnfYn0pQcVWyJgJIG/exC2PO++9ABMAePdygzBoZUwcKzR7e8nUcGIeIN8B66Vu35OAB
 2kj6ErUjfLxv/uJMCpl0Q5EV35ZFO8uOvz5chabGF6KLcQCiIvi9rxQXwfwZrVeMzCfX
 wBZRK59w/CIWdgsg3KjTxRZbAyx3ue1ZzeLPi4mZfucIpVFAaDrnvxCVcc7Qo3zkjB0B
 veSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297345; x=1751902145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5c+91NkfpqJwYGyED+jYrmkB7CYyaOBwzdlo8NQO7hw=;
 b=WnrcPkxWkLV0gz7QNYLzdR0IuUeOzzntLTXR3bA96An1pwnvEiHIo1yqNoQ97wgL0v
 VajdXkPUQz5HpfJdU92cwZE9C+t8lTWG8L/qT7JyLyhFvh1xEEHmIRlvsanGBV79055e
 oB/2i7ffj4hSW1C9Vuu4fuNbxOQrjB+GdZe64IS7uAwCnDpzm0CcGpTqM0BdSdFjBtaM
 L7/6WjMnciDukoOR9rihYZ5Cz+2BuCrULQOn3+ebFyqAezkaPCI6arY5YYZp4wTCm6V9
 DyVUHEWOaO/1Lg7M7fXGm7zrLFNkcbWzCY5bh119vCasbd6fGxDuJL0O7rpmZkwhWE5G
 jBPg==
X-Gm-Message-State: AOJu0YwQ2W0mYtaYQuPmqEqNSUBhgUvmX/yTeA8R/c6Ee01i0ErdpocA
 XXVvKOBgwNZIxbJDEsfBVID0G95qgmW9XWoodjooShtQUd3yEGVw1C+hxkbr179lzl+hSmGA3L7
 HI3rB
X-Gm-Gg: ASbGnctnUpMs/ky9kcjjFOUUYHTVFL3hxfmIUMzKckmpOBzwhwHJont1oJrISRKfYiW
 NP7+oeM9LECxxVDlUrf+kt+JwHp6seC8rEfQicGesj3O+m9ynAtGaCDlXKdULw4cPXhg5pUQiIx
 69AyLUSE2NCYXghEOqhTvaYEI73hixG6MxFBJmMHF5XFCw1tsVxKt/dD3EDRnCW5GITWkd7yYI8
 t1TNN8oKPiXGgUVGCLHOsEAaOMCeqSJpC0un0K9gTziv0oL7o6eWWGYUlVcdbEZzKpYQ6tJzlDK
 ZPPFh3y9wC1Ba3kM5KGfuTa4RoVx/bnC3uaGS1DVlhor8fvW1HT+jlAJRuFyQpcNKGAIkQ==
X-Google-Smtp-Source: AGHT+IFPLbVctIP/ybUtl71PMLJlYJg/MJ6iJ0JNXcbYMsPHJoBBZly/RRZD4jXylJR8WU6RtETdfw==
X-Received: by 2002:a05:6830:6f86:b0:739:f13a:6f41 with SMTP id
 46e09a7af769-73afc731dccmr10535206a34.25.1751297345501; 
 Mon, 30 Jun 2025 08:29:05 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 09/29] tcg/optimize: Build and use z_bits and o_bits in fold_not
Date: Mon, 30 Jun 2025 09:28:35 -0600
Message-ID: <20250630152855.148018-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
 tcg/optimize.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 29d1f29124..d22396f6d7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2251,10 +2251,14 @@ static bool fold_nor(OptContext *ctx, TCGOp *op)
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
 {
+    TempOptInfo *t1;
+
     if (fold_const1(ctx, op)) {
         return true;
     }
-    return fold_masks_s(ctx, op, arg_info(op->args[1])->s_mask);
+
+    t1 = arg_info(op->args[1]);
+    return fold_masks_zos(ctx, op, ~t1->o_mask, ~t1->z_mask, t1->s_mask);
 }
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
-- 
2.43.0


