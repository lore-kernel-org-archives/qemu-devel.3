Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479F3C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKl8-0002aH-Bf; Fri, 29 Mar 2024 18:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkt-0002Vy-TD
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkr-0003Uy-0b
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:22 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e0b213efa3so21814295ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751479; x=1712356279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0QfsALuaN0+wWbot0bFHlDdwooZi0EKVcDM5oK6qSA=;
 b=E2BZFz8X9Ll812UVTMSHE+x1+FFkAY8CiSNNE4lozFAve7Bq0y37R0+5uojWS3G9/J
 qAY/9aapIWp19VuG4IyUMyhJRS/hOT1wgh9Q9YFSDXSrZ15RObouXfCZgBCz9BHJHrWZ
 Jm2x+Ki/AIAO6T2lo9xoMIHvOVvqFMs+jlM5QSTUzYoIHaqdIiqQ5aebyQ9oOjYPN95t
 UXc11kTREtCikPGVYATwk/ua+p0zErKcmyn5gFBLdOXNRj+YmOY+BUtqDXTjyKs48tIg
 /f/eFuHY7Yzdag0e+UkMHR3rLL+4JxQ2m8wbMM6hpvwbmnVERPtYSOSuOiPphg1LpDOi
 /CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751479; x=1712356279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0QfsALuaN0+wWbot0bFHlDdwooZi0EKVcDM5oK6qSA=;
 b=l7Ii9C24xM9qaJf1eVb5EcUam0vTJiFtEZzjPTKLARcvSJCEKtffMI9aJHCOhm3c2T
 RB+58dKnraAQALBrboLcAIRKdBQQUmABn1kSDe6IpFiv4h41jSf+XBFBQwcY6XKrbCCG
 veWfJa3qVxKrtUQikP7Lx6nGcFIgLaJRNG4uIcBrF0Y2dj8dfydoGZc9mGkTHlSp/5IM
 cTnnjuMjJTc8//zyNkhQ5CogzZUz8mls352IDEQngEWPD/3L5ttEpiMz0gTu8shN4QN0
 7tDqtSoT4B0atLn2ab+55+iJZwSIddAB1irn9qv8GSTFhpGUjF+H6gmulPmGHmZSL6iA
 qWUQ==
X-Gm-Message-State: AOJu0YwOxusN/LnwLS6b5u/dWev7hkQ0GNL05hvSBqWOFYbqoHlwzlSu
 +4iKH0R0SuOu2kUHys+telAPGw4fiahqD9WFsWUltcQdFho1EbHvx8NM3VRflM4pmJSDzeHMkxO
 s
X-Google-Smtp-Source: AGHT+IHUL0UQkStIFR8EEn8tksKpQw+pyMGfzB4ERbnaiud/Bdf/8vf+lc0OWKteXtpIrOnGtNIKUg==
X-Received: by 2002:a17:902:d508:b0:1e0:cdbf:24c2 with SMTP id
 b8-20020a170902d50800b001e0cdbf24c2mr4463190plg.29.1711751479284; 
 Fri, 29 Mar 2024 15:31:19 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
Subject: [PULL 03/18] target/hppa: Handle unit conditions for wide mode
Date: Fri, 29 Mar 2024 12:30:56 -1000
Message-Id: <20240329223111.1735826-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Sven Schnelle <svens@stackframe.org>

Wide mode provides two more conditions, add them.

Fixes: 59963d8fdf42 ("target/hppa: Pass d to do_unit_cond")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240321184228.611897-1-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f875d76a23..2cb91956da 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -967,11 +967,22 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
 
     switch (cf >> 1) {
     case 0: /* never / TR */
-    case 1: /* undefined */
-    case 5: /* undefined */
         cond = cond_make_f();
         break;
 
+    case 1: /* SBW / NBW */
+        if (d) {
+            tmp = tcg_temp_new_i64();
+            tcg_gen_subi_i64(tmp, res, d_repl * 0x00000001u);
+            tcg_gen_andc_i64(tmp, tmp, res);
+            tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80000000u);
+            cond = cond_make_0(TCG_COND_NE, tmp);
+        } else {
+            /* undefined */
+            cond = cond_make_f();
+        }
+        break;
+
     case 2: /* SBZ / NBZ */
         /* See hasless(v,1) from
          * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
@@ -996,6 +1007,16 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
+    case 5: /* SWC / NWC */
+        if (d) {
+            tcg_gen_andi_i64(cb, cb, d_repl * 0x80000000u);
+            cond = cond_make_0(TCG_COND_NE, cb);
+        } else {
+            /* undefined */
+            cond = cond_make_f();
+        }
+        break;
+
     case 6: /* SBC / NBC */
         tcg_gen_andi_i64(cb, cb, d_repl * 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, cb);
-- 
2.34.1


