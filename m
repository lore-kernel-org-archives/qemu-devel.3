Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94933C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbpjy-0001D4-5c; Wed, 07 Aug 2024 19:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbpjw-00018n-Ac
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:06:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbpju-0002X8-Hj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:06:44 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d2d7e692eso380689b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723072001; x=1723676801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgUVD11CvGzRcJQDPC2J6X92VppyV08YSDBK35UJlK4=;
 b=FlugMf3ZrrxocjFz+74ke4rMNjMp83/4srKkWXDEvx4Um+gq0VnucMtxyTweBhhnB/
 gK8II3u2B7iOmCBIbELbJrB+/ShCgqRRGjhqTBLB3nlRX/p0Cyicd5MLk4ZIb8Pc596z
 HI6sQDVB3NseCeJ+J5uPP7uKh+lVLA6gSc92USx98+cDLD3u4Wdy0tpDQHPYUohSjP2R
 +iW2KiKAcAHRC1V3I4lh+MdeX9kgVOQ5juNnrHwsTsl2v/9CQLdvtblpaTE8sf+Vno99
 NcKtXinzWy3JiXgFkc17+mu7k7cfbJjTQJjqED+jUbuaRdKZbwyvJtA1OftgfnGY5zxU
 L0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723072001; x=1723676801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tgUVD11CvGzRcJQDPC2J6X92VppyV08YSDBK35UJlK4=;
 b=WY8GkKBEipbWsT4WihtLfiiXies/CSqcPp5upzxncDeGgbwocX7WzsVdNQruGoOKze
 PqvG1LUwoBna5la/B0c/ratUK4U3Tn8ZfMWha5UTFwlMhSJTNyU7IFCeWPc8SVIKrSln
 2FyadNXYizQVWPo8+U+tjhS15EVs8r8xjPgEuntTpwyZ9NdcwR5l/GewkmreBTsdFjqz
 hcIS9cSYxSYwef7gSkFrORPStTuqBmV/VSXNddgRExbDvwHJhsEyX/1ZqJ2f63nn/fk3
 6L0lxU4JMQNfOj2lL/nSp+PGib7LGD2zpTDEP2cnvHHzDzZ8fdGffSidbL8Vfkni77+Q
 SkDw==
X-Gm-Message-State: AOJu0YzOOtFn7syXv+CPxjgRaOdYpIGeL5z4zFN2IkaTBwEWiVKvSSuy
 y3iQ1B116aFHoU9yxJ4DJVRAx5Z/LyVl8W2RheCMESflcqEqGz/lfXL5hUrCg23D+2xm/k5J0fN
 On8A=
X-Google-Smtp-Source: AGHT+IFC1dMs4ux/VtFotQ5z/VOU5kWNuk5HIO7Wrvp8iEnQvUrN7M71R6fTty/j+KmHgFZVHW1xuw==
X-Received: by 2002:a05:6a20:564f:b0:1c6:fa87:774b with SMTP id
 adf61e73a8af0-1c6fa87794amr711836637.39.1723072000038; 
 Wed, 07 Aug 2024 16:06:40 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3b35f4esm2123187a91.40.2024.08.07.16.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 16:06:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/1] tcg/ppc: Sync tcg_out_test and constraints
Date: Thu,  8 Aug 2024 09:06:29 +1000
Message-ID: <20240807230629.31520-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807230629.31520-1-richard.henderson@linaro.org>
References: <20240807230629.31520-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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


