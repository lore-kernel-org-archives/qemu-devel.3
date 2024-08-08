Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CBAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 01:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbsBN-0000od-Mq; Wed, 07 Aug 2024 21:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbsBM-0000kh-Kg
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 21:43:12 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbsBK-00082c-T0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 21:43:12 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-75a6c290528so356664a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 18:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723081389; x=1723686189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgUVD11CvGzRcJQDPC2J6X92VppyV08YSDBK35UJlK4=;
 b=ARD5YEzERpyaq6QpeDqYhbmIre88u3i0JWyxlBp5igOoDQyJJ2XmguU0ZacVnVgclE
 ucvtLq9Ykkj5+lvh0AjR31vQkPv/w3EPQLqohO5iWFv8MBGZZLWuL7vChnQfKNlqK0s8
 pmv9DcJQg2U/tHD1/H3D0U3s2vzsi72YoMjeq/9NLMGC5B+dlsnGfbw/i2SsnzyD7rU2
 m9DJ0D/zsZZ1oDIQY90syz5acBPivhUtZNdXjhwbNk6XlvSm5Ef+yVcXPf3+5B6ink1B
 h3lXaDU5jZSFXz1YtD1XqnjEfJrefZHOPkZ7/epVyPIQloDnW2pc0uuqCoaXlcR21gTI
 skZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723081389; x=1723686189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tgUVD11CvGzRcJQDPC2J6X92VppyV08YSDBK35UJlK4=;
 b=BAAu9iiQgQA183YJ2TtqlLZqqHPWt49qZZpbePxWTP9dP3Kdv7Yzn3o9++yazFU6rx
 JytxPcMsupeUzAEwv7qRWRi9gw+OdG2OAv6FRTyfepoB5uH8CusQPMrmVKRi5zj4SNBq
 IOKzh2wE4ZRLhs8JZoU9P84hdgcdnBinfTJbvAUkdY2lstkDXg4iWe5a3EY7235K4pMh
 +RqqV6n8fs1y5/exauev4Ftju6N9AbpOWLJvH+jKIpv9LP2V4V4WGSVJcVu3kj4Ren84
 /NGiGqDRlG0Byb5Omox/JuJHryDzEqBNn8QeV9r0nhcJg+KYVeImVPHOFE+zzxPQz/av
 RXGw==
X-Gm-Message-State: AOJu0YzUSyHjyi5OB1WILKTs3AI01wy0lfB11qQcese5/Q7vkgWztLwz
 O8yiHyniYHTFNLIH/6qsG8rdbcZX5Iguq8d41EeMB2By1k0t7mdmqRLvERo7TDPS5/xTo8FALNY
 NVjU=
X-Google-Smtp-Source: AGHT+IETKoh8Vnkn+1zW2nV5QeOqsLytBkJSU5yH6wVW3TgOvoxgfVa6nfExfobPM7K2iyNSimm9+Q==
X-Received: by 2002:a17:902:ced1:b0:1fd:ac9f:4050 with SMTP id
 d9443c01a7336-200952641a4mr5920075ad.35.1723081389165; 
 Wed, 07 Aug 2024 18:43:09 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929abd1sm112724035ad.271.2024.08.07.18.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:43:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/1] tcg/ppc: Sync tcg_out_test and constraints
Date: Thu,  8 Aug 2024 11:43:00 +1000
Message-ID: <20240808014300.65269-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808014300.65269-1-richard.henderson@linaro.org>
References: <20240808014300.65269-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Ensure the code structure is the same for matching constraints
and emitting code, lest we allow constants that cannot be
trivially tested.

Cc: qemu-stable@nongnu.org
Fixes: ad788aebbab ("tcg/ppc: Support TCG_COND_TST{EQ,NE}")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2487
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <44328324-af73-4439-9d2b-d414e0e13dd7@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7f3829beeb..3553a47ba9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -325,9 +325,11 @@ static bool tcg_target_const_match(int64_t sval, int ct,
             if ((uval & ~0xffff) == 0 || (uval & ~0xffff0000ull) == 0) {
                 return 1;
             }
-            if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32
-                ? mask_operand(uval, &mb, &me)
-                : mask64_operand(uval << clz64(uval), &mb, &me)) {
+            if (uval == (uint32_t)uval && mask_operand(uval, &mb, &me)) {
+                return 1;
+            }
+            if (TCG_TARGET_REG_BITS == 64 &&
+                mask64_operand(uval << clz64(uval), &mb, &me)) {
                 return 1;
             }
             return 0;
@@ -1749,8 +1751,6 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
 
     if (type == TCG_TYPE_I32) {
         arg2 = (uint32_t)arg2;
-    } else if (arg2 == (uint32_t)arg2) {
-        type = TCG_TYPE_I32;
     }
 
     if ((arg2 & ~0xffff) == 0) {
@@ -1761,12 +1761,11 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
         tcg_out32(s, ANDIS | SAI(arg1, dest, arg2 >> 16));
         return;
     }
-    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
-        if (mask_operand(arg2, &mb, &me)) {
-            tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
-            return;
-        }
-    } else {
+    if (arg2 == (uint32_t)arg2 && mask_operand(arg2, &mb, &me)) {
+        tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
+        return;
+    }
+    if (TCG_TARGET_REG_BITS == 64) {
         int sh = clz64(arg2);
         if (mask64_operand(arg2 << sh, &mb, &me)) {
             tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
-- 
2.43.0


