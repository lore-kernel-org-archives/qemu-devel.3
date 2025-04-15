Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFBDC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lvh-0000jN-31; Tue, 15 Apr 2025 15:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luo-00008A-0p
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luh-000835-Ks
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so6948487b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745142; x=1745349942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHpl3TQ1gAJNluoeZYF2B9bVi2xRa/fgeCq2ywDqjJY=;
 b=Ezj42WZJXPYh1Ywvye/TeBj9sfBAWae6lJT1VwJwwtzlj5DvXko31Cwu/KwETIikDa
 Eqo2piSrZk+DnVtDajkRuQ46pdpz2huZvXsHE2FWG/NWlGx4mQLKwv4TdUYhkssLEcWs
 MLiQpjNvZ5REbvzI7SRCLpwvzYfEtF7/M+1NiZrjte1vy4IrPuLhxCdXi4oNsGKgMpIn
 FnzgJuJMVatMApOQgwq9gdPqJ8OE+Xe9q/QQlrD0aPpMT/TOeN1v4nIAiUMCGjj1JqnI
 iIT6RhjsKq8xeGmLzRQmczctr6eMvRkoZxUy/3Y/58c2K+8CUBR5ea0R8D3aNskZY5Kj
 dAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745142; x=1745349942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHpl3TQ1gAJNluoeZYF2B9bVi2xRa/fgeCq2ywDqjJY=;
 b=LG3GEQqRD7EStFoAM+IGjEH3s3hBbFL9upwi/Weou7wjslPOHW0l+/v3K862+bt67j
 QYPuUaf0OinaepW+YoZXMOLg75HOCqY1LVt/IioF7OFjVyaQAC7tlsGiWtA5aKhkylb8
 tV7S4oq0zYRRjvC9A7irrikkKVxcFKSO+fPdbXWPI4gNbuHhxbvTZuVihuVl/c3Bodd0
 AcMkd3OymKdAsTzYlGrDmRU10tYTuXo/lltIFLqcpsrbI9hsmQaBxh/9Ib+06NAjR+sW
 f+0eLNyZE37U9nZHPm+G1FiKznQFfUaNglE2DZdDZ4Y+lDxd4b88AoZ8DHD6jpmphlwf
 e3BA==
X-Gm-Message-State: AOJu0YwJuah+pyyMoNUM7RyrWxocOi7KJ2JKdDWEsBV+eBsss4sq6fqK
 Hpb7ZL1ApbLavv/HBjt0HF5p61jCHbnvfrBtOAma+cbC6gYr1rPf4eBxiAPPv65hjkfZoDnmZjj
 t
X-Gm-Gg: ASbGncvsuxSqfIdi8D0A4KUuZUhOHaFNHXO+6OXLyfCRj0fLTLY6dvDQObqrdS0aDXb
 CZnV4FeR3idORjwQLo9JtCueYExicZAmDcN/TX3noMw+IzNg8LILc161VefGUJzYnqoeN/Ho29T
 AM8h7JXI4qD7mrkylzH7qesn2FSdh/n/XQ01etUrh+XyCGqaKcxFfS6Yk0KO5JTxfkQ5aHW965l
 ondUiia/4IDGuMe198kaOVrqvArCY++bCOW/hCY+JyyUEZP7B0258pIIymTkq2CwNU+/I5waSDw
 KfrhI9iKypZ+Mx1NO8Wjq83U/wGw1Hv4dZPig9//AH/MDVwx76+i7OyZje+9BWleNNfLkfcwSQ4
 =
X-Google-Smtp-Source: AGHT+IEGg9FjEvQgaAjMMPCcWE8J/glIzc0yxOjicjHImTrtYyo3gn0WRWUNOGAvup23Bho55WDCfA==
X-Received: by 2002:a05:6a00:3908:b0:736:34a2:8a18 with SMTP id
 d2e1a72fcca58-73c1fb5799amr906666b3a.24.1744745141621; 
 Tue, 15 Apr 2025 12:25:41 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 028/163] tcg/arm: Fix constraints for sub
Date: Tue, 15 Apr 2025 12:22:59 -0700
Message-ID: <20250415192515.232910-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

In 7536b82d288 we lost the rI constraint that allowed the use of
RSB to perform reg = imm - reg.  At the same time, drop support
for reg = reg - imm, which is now transformed generically to
addition, and need not be handled by the backend.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target-con-set.h |  1 +
 tcg/arm/tcg-target.c.inc     | 11 ++++-------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tcg/arm/tcg-target-con-set.h b/tcg/arm/tcg-target-con-set.h
index 229ae258ac..f46a8444fb 100644
--- a/tcg/arm/tcg-target-con-set.h
+++ b/tcg/arm/tcg-target-con-set.h
@@ -30,6 +30,7 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rIN)
 C_O1_I2(r, r, ri)
+C_O1_I2(r, rI, r)
 C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, 0, w)
 C_O1_I2(w, w, w)
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 8e9edeb7c6..47c09ff2b1 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1984,12 +1984,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
     case INDEX_op_sub_i32:
         if (const_args[1]) {
-            if (const_args[2]) {
-                tcg_out_movi32(s, COND_AL, args[0], args[1] - args[2]);
-            } else {
-                tcg_out_dat_rI(s, COND_AL, ARITH_RSB,
-                               args[0], args[2], args[1], 1);
-            }
+            tcg_out_dat_imm(s, COND_AL, ARITH_RSB,
+                            args[0], args[2], encode_imm_nofail(args[1]));
         } else {
             tcg_out_dat_rIN(s, COND_AL, ARITH_SUB, ARITH_ADD,
                             args[0], args[1], args[2], const_args[2]);
@@ -2234,10 +2230,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
+    case INDEX_op_sub_i32:
+        return C_O1_I2(r, rI, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
-- 
2.43.0


