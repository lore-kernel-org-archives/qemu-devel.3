Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD954C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFR-000086-2p; Thu, 02 May 2024 01:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFK-0008SY-7x
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:42 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFB-0002fY-UT
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:41 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5af03aa8814so5103533eaf.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628673; x=1715233473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH/q0WCjN3MJHGH0D+l3dpNzf1frODIUflx11LUrBRY=;
 b=cPHxv6hcEc3AD4eUUzqAbdntZyQyEkbmI8N3JZAkD301cQEmybkNi2HTZtTlNwSXfo
 sWixZ7W7nwglgb95C4OY3NSwJZJI+DkLmAeB1NBgMcMdX9UbeC28DcLnLja2BlVfiCHT
 yrRYdYbVOlKTcrln+EYFgU0byxJlWm19XW4423lu6Lmqx7ZVo9b+jHc9RRseQjUm5PK4
 XAZ64b833TZYLWJ5LNRw/ij7vGJ8tZNOyDz1sawws7wx5wBpU80r8ZoHZYc3V+w8zTtk
 RNE5CSdRbSezbpOUZlo/cxAJ1k/oT1KDAVfNWS1ATCUH98/ov8UIj0C9VTMdvUo/a+Nq
 u4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628673; x=1715233473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lH/q0WCjN3MJHGH0D+l3dpNzf1frODIUflx11LUrBRY=;
 b=jRfD0Ds/1p1L8v/yULVjECOim6MC25OIzBGl5oq31hV0wNT1Hc3WfMY0kg1vjE24m5
 Y2BqMWP5i9uW9ZrWjHFW3mRB1MA4X1MmnY075bbf3LPiwKc+ihy3/sekt40yK9TtZLWI
 I12/LvWUz+GIBxxqk86Z00PKR2tkAsVnPIS1kG/Qh80TFUf0PHtydv/0mcqIgY6Fs0pJ
 z4zEVfxoS7RtLsqNZ2xjMkgpXMIZvMDt0d04CQ2YGjuuU18SkNO1XlvM5LatQXO7aTTb
 VKGpeMBOZbTAfCv6DZSA77K9tmhSIkk6s0PaNZa4b3R/0d7ctdRmJ2BlPKW+T7V6s06Z
 VtvA==
X-Gm-Message-State: AOJu0YwnueLr/A+/vSXDSZ2Xx8vuZtkcYnvcoudq1DX1O+ti/01gw9rY
 V7S6sWrKHETgBW/F7WdIksT0wmtvCFoMRMHSWTpxoWf7C7KId0osMkSMeOcmrcZ/pGrPkr/l601
 r
X-Google-Smtp-Source: AGHT+IFEwkMLP+G4tT1k3bBEE8C7flV9A6ZdLtnPVB4vxaA1tLzyBEYdf2dsyGfRW6qq0KzdvHgxeQ==
X-Received: by 2002:a05:6358:481a:b0:17e:69a1:a797 with SMTP id
 k26-20020a056358481a00b0017e69a1a797mr5551981rwn.30.1714628672730; 
 Wed, 01 May 2024 22:44:32 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 13/14] target/s390x: Adjust check of noreturn in translate_one
Date: Wed,  1 May 2024 22:44:16 -0700
Message-Id: <20240502054417.234340-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

If help_op is not set, ret == DISAS_NEXT.
Shift the test up from surrounding help_wout, help_cout
to skipping to out, as we do elsewhere in the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 7cf2920aec..8e9c0847e3 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6343,14 +6343,15 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
     if (insn->help_op) {
         ret = insn->help_op(s, &o);
+        if (ret == DISAS_NORETURN) {
+            goto out;
+        }
     }
-    if (ret != DISAS_NORETURN) {
-        if (insn->help_wout) {
-            insn->help_wout(s, &o);
-        }
-        if (insn->help_cout) {
-            insn->help_cout(s, &o);
-        }
+    if (insn->help_wout) {
+        insn->help_wout(s, &o);
+    }
+    if (insn->help_cout) {
+        insn->help_cout(s, &o);
     }
 
     /* io should be the last instruction in tb when icount is enabled */
-- 
2.34.1


