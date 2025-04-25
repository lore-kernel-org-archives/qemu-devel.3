Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13ADC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ktc-0001dL-QB; Fri, 25 Apr 2025 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8Kta-0001cR-PO
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8KtY-0002oh-4K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:18 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so2394907b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594595; x=1746199395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BkGqEuOn61y/rqWawhxPHU+tldQWor40BhhDmmwEXQ=;
 b=SsBbCtFIw5iTUa0ymAkHo66jiTp5kKdO9N01HHUXtHnfwNJbkNqI6i6RstPmmyFDnT
 aSVhvlbHW+Yjt6NdJk8So55h0cY17MRmT5B01w4ASRm8ZGW1PF6FAnOlqYXLk5I/8JWZ
 n2iVgKNrT7QY26YPJIb/7YQhueq07XsxJ/X3gBSl/y0X/HO5KDB2u7NYEPGrzIrpxJAO
 4rEcKHqPR/Y0GuFP89jO+rSk6ON4PnwFiASILyr4kLbXVXE3kKk6siau7SyeESE98C8U
 jer68v5Wyay7R5YruE6m0dRjflcSj70vgvtu9N9yJa42SRE0SWuBTTnCkjgHt07POKQP
 X6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594595; x=1746199395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BkGqEuOn61y/rqWawhxPHU+tldQWor40BhhDmmwEXQ=;
 b=Pu4MqJ+y3SC2g+jxrOoyX68QHGq+eLnL7kJILvErLd7eKIejTDsCBaD5vKPDfptEUR
 5EE0woga+XAFZBoo62R5S45GjVYZNMMlQ+lDjmOnp/qXvWbCwYe4VVwAkyPvBqeDKlFO
 LyWFPSf+WWZaRuBssXk53zbc4Zx4YoBw31BydzVJPwi0scTURVYbVo5zYA4iKqcqAqq7
 Ku9lmuqE1KfLNODwDxlhPpqTBNIViUVCTQLhpmfPDls1ji8xV3+B56Huetr8o65Cl3Bi
 7KwH3ixaNmCB0gEnoz1LVLX9kak86/bgPVieTEQC/fcf4yrxu3IjPJFTmkWmsprwgyZ0
 DPiA==
X-Gm-Message-State: AOJu0YyWui5h1S4dqa51KYLUkDUsva13lz1OnpMh+IfTgqb/zUnse8+7
 np5orDcs4q43PVCT0XzfbYGXY/MwTv2xgHLVEVpiPL/5vGT7KkLVVP48zdo+JlQRDaFJwWt59uO
 t
X-Gm-Gg: ASbGncuHQ44QlfMUsVKUZEoZgT7ycjHjINa58Ulb/amR2/e+Wv5ge7a4fQ5Kepz2miZ
 hBOuBnvMGM0aGG32SdbC6P3ngU/hzTaZDNxYjLEZrxpTVMSlLsfzc9ncu/0VPZywISLfKICXb+E
 W2WlBwdVwlFxf0Aa6F0oNmNMOiURj4tNOUBMx+OSlEXFJ7iC3eODCOpxzpALjMzI438ByF/M0ZR
 0ywCV4uNb+4TNLf4Ndn0jsIailE5pXhbhQU7tg8IQV3V4zXXJVc43HdDbGKr8Twf/PDZ5ogI9tu
 Mc1L1LRyHmASptGoDeoQhrOfU8mnfhH1VSGLT71321/VjYFoB5ilxn6tgtVAF8uBDfcgULz//JQ
 =
X-Google-Smtp-Source: AGHT+IELV9pyia/nUpY3IQu+MOC4wI1IVoRqDgI26PXiGTuNeLoObFH+TkGyiarZXK4cngWJ0SvQ9w==
X-Received: by 2002:a05:6a00:18a2:b0:73e:598:7e5b with SMTP id
 d2e1a72fcca58-73fd6af4105mr3402564b3a.1.1745594594677; 
 Fri, 25 Apr 2025 08:23:14 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3390466b3a.106.2025.04.25.08.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 08:23:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
Subject: [PATCH 2/7] target/riscv: Pass ra to riscv_csrrw_do64
Date: Fri, 25 Apr 2025 08:23:06 -0700
Message-ID: <20250425152311.804338-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425152311.804338-1-richard.henderson@linaro.org>
References: <20250425152311.804338-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/riscv/csr.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6f1f69eba6..e9c2f95b6e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5516,7 +5516,8 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
 static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
                                        target_ulong *ret_value,
                                        target_ulong new_value,
-                                       target_ulong write_mask)
+                                       target_ulong write_mask,
+                                       uintptr_t ra)
 {
     RISCVException ret;
     target_ulong old_value = 0;
@@ -5546,7 +5547,7 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
     if (write_mask) {
         new_value = (old_value & ~write_mask) | (new_value & write_mask);
         if (csr_ops[csrno].write) {
-            ret = csr_ops[csrno].write(env, csrno, new_value, 0);
+            ret = csr_ops[csrno].write(env, csrno, new_value, ra);
             if (ret != RISCV_EXCP_NONE) {
                 return ret;
             }
@@ -5569,7 +5570,7 @@ RISCVException riscv_csrr(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
+    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0, 0);
 }
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
@@ -5581,7 +5582,7 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask);
+    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, 0);
 }
 
 static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
@@ -5647,9 +5648,7 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
      * accesses
      */
     target_ulong old_value;
-    ret = riscv_csrrw_do64(env, csrno, &old_value,
-                           (target_ulong)0,
-                           (target_ulong)0);
+    ret = riscv_csrrw_do64(env, csrno, &old_value, 0, 0, 0);
     if (ret == RISCV_EXCP_NONE && ret_value) {
         *ret_value = int128_make64(old_value);
     }
@@ -5681,7 +5680,7 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
     target_ulong old_value;
     ret = riscv_csrrw_do64(env, csrno, &old_value,
                            int128_getlo(new_value),
-                           int128_getlo(write_mask));
+                           int128_getlo(write_mask), 0);
     if (ret == RISCV_EXCP_NONE && ret_value) {
         *ret_value = int128_make64(old_value);
     }
-- 
2.43.0


