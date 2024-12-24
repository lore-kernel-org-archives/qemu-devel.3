Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280BDE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDm-0008QG-FC; Tue, 24 Dec 2024 15:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDF-0005kJ-4v
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:05 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDD-0002v6-KI
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:04 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21670dce0a7so73943235ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070942; x=1735675742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vqya82Y36HRWm92cvOJyTlH+EENkrrC20W65fSXxCcU=;
 b=eXpTnONWs0aX4C+2om94tOcjCyePDt1LgYEhQQs857PlM7M1IQBcBiiTwg8sR8CUav
 mAqiLCPE0pKSgmz7kgR39LHUFDmxnPpj5sPqA6ie2vM3UktJjlZ4Tlwrf+Zx+cVNNVl0
 +gDDXQ36xC8P45AE0fpfOxudjSb+B0eNCqU5mquJNyA/7EOK4wYf/YtFX3uscW5vIUxc
 bLDPwLdf369O2wvi4TJjRRni/A64yXrvT2PmoxPcRIu/kSOc372TUs0gTFGb4rKHyVkL
 rQ5HjrR6ZjWpoTwxQS0x9ZFbdK3vy2KBzmX+BzQntrzpzTjnDjdz/LGdYoYOrjSwAfrI
 WrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070942; x=1735675742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vqya82Y36HRWm92cvOJyTlH+EENkrrC20W65fSXxCcU=;
 b=RkuhOUzHOkKYARblQBlZEWJQa5CTXvVMXgBEPZzYdCOOg961rwoNV0c1vP3irmHBMi
 9Z6nZLU+x0zPZvkcJLCT5CbEts8A8X+XtCizSYOQBwDdHBy1FfEzi8fjr0gNJoLijuRn
 1roO3YlJnrYFN38rpsbZ03CjdXZH7Utcy/tFJvMJHdGGeTML105co7EbRzraJqhL/95B
 cvZ8pcSssv5+65mEi1Oo+Curuax4GWkYoY/A9mNO7kQaOx3OfwHljLeuU2hX+WD0NQ6b
 D0T8VivNjs4ZVGR/u8pgnyzWwG6i6j6kGhLMALLAfFMBrzlfkK74sn3DSm4St0c0yQgN
 3Whg==
X-Gm-Message-State: AOJu0YyqQ1ynORIMTnsmv1x/edLdVprbfjCx9BHiMHSwMd+5fdlRU0vc
 QPvOFM/3pF8IggWlzG3XrdmvzAugZGtr17p/WpC2+zUkzVDFh3IjV47HgMfbP3OpcM2dKE2RVCB
 wpzk=
X-Gm-Gg: ASbGnctjq2RaNYr8xHn5cjBOihUFyV5GhYpQhl14lW3sOOAS6fLYpAIBrbPjD51p1mR
 x6wepr3HIjYvUD6hARVH5PWZQdw5joyaplB9iLL6YDmvWK5poPsIWgwk5bLWvHdkZoBB4zPl5FT
 k2UzG2N49X0eE3FsFKjXQ19RA+n/BKMAp3gAA2sw3fVZW7qUXXfm7EZxQx5LU0Ux7rTTQBcuky0
 OYZTrhcdITXUx4NpHv1iBNDcAuk8qNegeEP+OY3wIfeCE778yxScX4kuP4zLJ8VX/wkT2CQ3dGP
 TBjco0DhflFXDoSUiSG3+4E9Ow==
X-Google-Smtp-Source: AGHT+IFucu0GdldQn4ABKa+alijv3j8VYtPBDwFxyjp/5RaR/PiQlGQL+p3mcrdl7GW8mGm9aN4j9w==
X-Received: by 2002:a05:6a21:9106:b0:1e0:d36b:ef5e with SMTP id
 adf61e73a8af0-1e5e0869165mr32263993637.46.1735070942351; 
 Tue, 24 Dec 2024 12:09:02 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 42/72] tcg/optimize: Use fold_masks_zs in fold_sextract
Date: Tue, 24 Dec 2024 12:04:51 -0800
Message-ID: <20241224200521.310066-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4090ffe12c..2d634c8925 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2507,31 +2507,25 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, s_mask_old;
+    TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t;
-
-        t = arg_info(op->args[1])->val;
-        t = sextract64(t, pos, len);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (ti_is_const(t1)) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                sextract64(ti_const_val(t1), pos, len));
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
-    z_mask = sextract64(z_mask, pos, len);
-    ctx->z_mask = z_mask;
-
-    s_mask_old = arg_info(op->args[1])->s_mask;
-    s_mask = sextract64(s_mask_old, pos, len);
-    s_mask |= MAKE_64BIT_MASK(len, 64 - len);
-    ctx->s_mask = s_mask;
+    s_mask_old = t1->s_mask;
+    s_mask = s_mask_old >> pos;
+    s_mask |= -1ull << (len - 1);
 
     if (0 && pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    z_mask = sextract64(t1->z_mask, pos, len);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
-- 
2.43.0


