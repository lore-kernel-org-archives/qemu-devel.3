Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1ADC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGS7-0000bZ-5f; Mon, 30 Jun 2025 11:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRc-0000Rq-CD
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:24 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRZ-0008Ec-CR
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:19 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ef8df09ce9so1061393fac.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297355; x=1751902155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlceHPyhFoGBS6k1Ha7sssoddrle3FjsPN6fMXf6Nt4=;
 b=zI56pnQDYgqkXfn8leK1gyqHMnN5Vz0hvNr7xcQrw2OaBuu+eVc0gcX5GQrJUik4xy
 IWM3ChvI1JcsDvAl+YeRkHgahz/rnZ+VtGcBsz1pSyK958++Mn/LFPXB3LQQZDheBlPf
 hqnsTl0eMG4HmWTJ+z1jebZ/PD5VfnUJQ3goCgjTXfPNptbP+NIw949JVuizKg7tFdXi
 G767mPquvf1XPMIDz+WivyihRWIEysuKkVXLUuOFrwSskFsXklzhtaPXOtttTWL28f1V
 lSGlgmb5784lW++2FUy41m/7jZ69aRkQ1tMuJMiEqgkhQjeRW98oGNJHorcUCcvJL76N
 W2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297355; x=1751902155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlceHPyhFoGBS6k1Ha7sssoddrle3FjsPN6fMXf6Nt4=;
 b=wrs9wobNFq0Mq0/dpoKet7vewiRyTFAlWmvfOTJj8y4CFo+o76OrePZOR7B9xCmhmd
 Xmkxn1nsGmpAUcJ9Api6SjJFrK04FGrHo91kT2me57jEuDp6EwjItNLSbKr/EzLKosKF
 MEPxg78p03Tj7fPHDZnV0RRTj/USFa6UvU64ZzmXkprhyaiK1qVS2iE9xUUW6AtmctGW
 qEjOj0yYwlCRgOVS5FHdyFMgaqIqlW9EWNDb+ouQF+b0kuZR/h3e9lpS0nq2IfRy9uan
 PpoHhLLYFBuPuz//DG2c5kJoDueMRs7DZoKsPKRfbMbZhBGuciufFKTLqbe4wvqOzuRi
 zPSw==
X-Gm-Message-State: AOJu0YyPICfkvxVskqHVS3c5Tcxha3wQPhONGCe3ea/eihepbjmF41K2
 u7PxOlaJCg2Lm3dSbTEHBwZCPCcMJx6OvXOdWmbbxRH/N3nWf/sGAGOGwxLjseFRnDhhzU5Orca
 qWahs
X-Gm-Gg: ASbGncsOBLIa84j4bgsVnqrSIXLuEKoYdRIs4sBVBPDraZvd7Y6tLYaUrg+hZNWbcRb
 yZK8VYjttadtsDoG744p3/xgZ6F7/zk6JWQTJ49R3sm2ezJPWj7f7mmBFJwcH0gWyShzPp8V0cy
 MH00txERCn2pjBXg4u07HVdAD6117/3EruEwTket9/I7ybFGBt4gow2zf+BiFwtqB+TfjUaV6hX
 y0x6CAndkgmm2UwjZQzetue7M9RkVxSqvskbh7RHJimSHyFbFKyMd4ueghcKx/zT55koRiySeQn
 qVHsm83mMHMpbCZik/D4jf4rxrmvbLTVfMybxqW7U3bUmnribtc20jLSesXjX3RAmST4IQ==
X-Google-Smtp-Source: AGHT+IFqTxfyMvAUmEBlnBJzbOh0qpph4WMzDBuktiRd+j7OXReAKN9ZGI6zE8DVqrYmRI9gd5ryWQ==
X-Received: by 2002:a05:6870:be97:b0:2ea:8c15:d6d7 with SMTP id
 586e51a60fabf-2efed6f3da6mr10067978fac.27.1751297355179; 
 Mon, 30 Jun 2025 08:29:15 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 17/29] tcg/optimize: Build and use o_bits in fold_exts
Date: Mon, 30 Jun 2025 09:28:43 -0600
Message-ID: <20250630152855.148018-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 86d958267a..103c94b12f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2013,7 +2013,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask, z_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
@@ -2022,17 +2022,19 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
     s_mask = t1->s_mask;
 
     switch (op->opc) {
     case INDEX_op_ext_i32_i64:
         s_mask |= INT32_MIN;
         z_mask = (int32_t)z_mask;
+        o_mask = (int32_t)o_mask;
         break;
     default:
         g_assert_not_reached();
     }
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
-- 
2.43.0


