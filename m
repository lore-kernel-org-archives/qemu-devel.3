Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941FDE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMC-0008Oi-JZ; Thu, 19 Dec 2024 23:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM6-0008Li-ES
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM4-0006Hs-QH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so16998485ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667871; x=1735272671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTlIt3yFdh4Ary2wfKIiByPP+3BeXY1y055wil8BQG4=;
 b=KIhTgOVKsSd22foZ9vs/aHRxaxE48BQcZ0Vt+bs5mvbrsu2UD0MoQfA7Ytqizkg7nc
 XAJWUPR4KokSXNlfvWpPl53xWjyA9gJ2yhixGFwjSHcbHTEI89tY9VmUXEUnmDJ865FM
 fgaWYDks5kmkWNk34dUjPOBRcDv9nivrF+oHWNsYt+WYdF0uMpdxCn2xdY3z2PsYySTc
 NxY6hwc+nwWjIVEY0w3asPx0QGb/G3iFQ8KMEexOTPMU8otSmq+k5QPHui4iCeHtlthe
 cwRl8n3pr0zaYST2CJohTse/TEsWS6UrY3F1HTGULs0Xu+Y1uJVhkU/Yz3KZ4Zl+qWDo
 WetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667871; x=1735272671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTlIt3yFdh4Ary2wfKIiByPP+3BeXY1y055wil8BQG4=;
 b=qdstZ0LvFZRxY4uMTKbxENqVVhwTlk1ufZTAPQO6FHxEAkRoG+xbSzOkn7qHS58Ld+
 VUagd7HEEEnGSX5+m81jF4WHx8oVYQabl/53kT7PDiu9o/7GZHo3vuVngs422UliEeHx
 V/bCS40ueaEwxVRutIF7zto1iLjWkiD9x/3G0b1z0X7OccjQb0cFaaH/H5T9+J/e4LQx
 LyWsLeuhuZrX47s2jB+FVutnmxR/flrNmyyBHvc6yi1dyE2elfTwJz6gTuWdSKdoMq63
 /C3CzpbSpd62JyMprEUa0C4WFVcwRG5V9XTEd76hLgO01++1+XOgoai04oUbZ1KatX1i
 DqPA==
X-Gm-Message-State: AOJu0Yw5FGmxH/D3sf8meP3yFlJbeOK1X5Pf3Xf9Oha+le/KgBtGe+zn
 wH/Z4JVIOa8sJfGqTRVjua7M7ZrIvQ5qyMAhrMXda7WnAg5unr9jPsRK+3i9sXpW1zbOlBVtfUk
 6
X-Gm-Gg: ASbGncv06wc+ct/w5qOxpSJHpJ/7oY/3Kism5AqbWqNWKfNNJoFDiItmUeRUJpBUwbH
 f5V+1KTrNNQ0ofTjUvXKAaAQlE5pcJEFMvxiEOQojyydzofo+vMJoOQZWUEO+BSgHOcOETUGsEX
 CuLB7sg6YhZZm/pIj98Co1Li7R2OnaiVVhz5bxT4F9cYYg+W0f2wKedYhOGk0Qi04fqZfVoD7Xr
 gv/7v10NvpwgbqCmB5GXejS3yBa4BcS7si3r96jsdfmfYpUWbCeVrvncjvtN2c=
X-Google-Smtp-Source: AGHT+IErVWvRssLTHoUjaQpMD6UvykhWjrOCrC43l8VUNG5IfnOijDAmYT3MgMl2RR0XUJgFDYyDIg==
X-Received: by 2002:a17:90b:2543:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2f452e372edmr2051809a91.21.1734667871434; 
 Thu, 19 Dec 2024 20:11:11 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/51] tcg/optimize: Use fold_masks_zs in fold_bswap
Date: Thu, 19 Dec 2024 20:10:21 -0800
Message-ID: <20241220041104.53105-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
Always set s_mask along the BSWAP_OS path, since the result is
being explicitly sign-extended.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c73410232b..b8e9ded821 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1495,16 +1495,15 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 static bool fold_bswap(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, sign;
+    TempOptInfo *t1 = arg_info(op->args[1]);
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t = arg_info(op->args[1])->val;
-
-        t = do_constant_folding(op->opc, ctx->type, t, op->args[2]);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (t1->is_const) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                do_constant_folding(op->opc, ctx->type,
+                                                    t1->val, op->args[2]));
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
-
+    z_mask = t1->z_mask;
     switch (op->opc) {
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -1532,18 +1531,17 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
         /* If the sign bit may be 1, force all the bits above to 1. */
         if (z_mask & sign) {
             z_mask |= sign;
-            s_mask = sign << 1;
         }
+        /* The value and therefore s_mask is explicitly sign-extended. */
+        s_mask = sign << 1;
         break;
     default:
         /* The high bits are undefined: force all bits above the sign to 1. */
         z_mask |= sign << 1;
         break;
     }
-    ctx->z_mask = z_mask;
-    ctx->s_mask = s_mask;
 
-    return fold_masks(ctx, op);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_call(OptContext *ctx, TCGOp *op)
-- 
2.43.0


