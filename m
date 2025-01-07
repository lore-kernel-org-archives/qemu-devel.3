Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ED9E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4c7-00073v-LQ; Tue, 07 Jan 2025 03:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4au-0001U3-Hl
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:44 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4al-0003ez-23
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:44 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2163b0c09afso219737095ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237134; x=1736841934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33uzY/fMYQ7ztpTEKkOze/Ge+z1qFulpPfwvxZ27FUE=;
 b=dTtObMebJSj4wBYqmBpsE/cMlytlFBGcY41MxLIVPFOJOxAfGU2gy7WoB99Qxfm1NY
 yTDIjxPstU6ucV7nMpOatf+1IH/xhDBCiLCQFV6oyZeU3nTnWEBjgvJcHXav2vlZlG3w
 98LjXzyxSV8ceEKMZ+TtBngyJZVkUbTN0VXzvNvOo56VoUBuylx6+CkQdrlQCeEr1AGe
 yQC/Er6VmTuH7d6WT5nFIMxXnJofI9wYnYsz/x4iKaTGrJnhT0vP4xWh/WVZ7c+TdGWv
 poeqzcqwr3cAn1cUVjh3rbRiLMd2VTB0GRa0PmQVS5H6adbGf8YVUU/D1x2CZhXPsdav
 rS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237134; x=1736841934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33uzY/fMYQ7ztpTEKkOze/Ge+z1qFulpPfwvxZ27FUE=;
 b=wX+SSs+R9nKQGjqlo1Ii9yJVE5cm+JNMXDXxuWi/Ox625irFV2KSI6JNiB4ObB/iVi
 t7fHw/IvXFuKHWm5Q8vq+3vL4IkYB+SWg3K3Zw9eDb4NPcC7wvdGBjG4H0Jyo7JxJC7H
 4kqCRFZ3hEQJPcNItMq9H6HvGPjAIQiFvE0agQrQZ+UV8DF5BUTuetnoB38nrmDK83if
 9KvZ11XDK1WcYJlelElD13LMTXyq4iuWAnCKZ6Sw73OrQIGygJswpWHVxo0dcdpJcWjg
 pKHdt6+2lHYkPaM1wNBjLkV6DhmxCFHDqH/SupUVIWfZ8i9r1zvrdHkUCkjRTFgOJFDo
 IBtw==
X-Gm-Message-State: AOJu0YyhIxsFSTCK4c8nZd2HKB24u1LxYHCEIZOIR15coJpHk0Qu5l0e
 dr3iREBOKR2a1VGUghCLAs5UTlUmnVYORZaquE6H1xtfodCZfa4A9jDI3SV2bK+/M0qJGjhKBn4
 u
X-Gm-Gg: ASbGncvyBIegq8vlRod6Rv2kZ/2EZ0LU0iOrVg+Q9bgvjZO8qTlzTCn3rRWEsSKsU2A
 seWuxO0KQ/H8y2Xn9QZ/IERPXFyOV9iuIsOg1tnkbJ4I5c/l880/bAxPtvP9dV0N4ugJJFUTDcD
 7/cWR/YoxEYK5ARvTT8JuPo1xDqvZEEDqgPaMZNGLMvFDDN+FHI45v00XcwMOCvGn14X7qtTdWU
 x4FWhyHr+BbgHxMRWNV9OMJaj9wrhP0aJ/2lqPKX0RkuOYQ18HMrl7sKLXq2eBEnQrKHycRU03t
 lO5nG3WPguuV7qXP4Q==
X-Google-Smtp-Source: AGHT+IESmNKf3zyMRBQwUNJoc/vX1NmJ9UNtd0O1WUJrfzqovWOOxTK0UoPLLCNwE+fq4jjbce4BPw==
X-Received: by 2002:a05:6a00:3c83:b0:727:99a8:cd31 with SMTP id
 d2e1a72fcca58-72abde0a79cmr88286577b3a.14.1736237133682; 
 Tue, 07 Jan 2025 00:05:33 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 75/81] tcg/arm: Fix constraints for sub
Date: Tue,  7 Jan 2025 00:01:06 -0800
Message-ID: <20250107080112.1175095-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
index 8e3448c7bd..52a1ca5a4e 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2010,12 +2010,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2278,10 +2274,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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


