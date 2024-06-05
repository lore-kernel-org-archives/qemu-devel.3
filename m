Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EE1C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydf-0001hb-Au; Wed, 05 Jun 2024 17:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydd-0001gh-Sw
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydb-0003pQ-8F
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70257104b4dso253683b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624662; x=1718229462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2yO0OdwYwim1ELk61/r9M0BgP3RevAymtCd4BW+mUg=;
 b=C5sXjkJrHcGgFk6Iy9VsTm/Rzk0ZOoOLfp/5lI4l/W7kD8W2gn3xgbqG0i9ikgICGY
 zyoa27+xf3ON8UAAquVUiZa4gPY+iinpd8CuTz3w8xoSKEZq4mXyUdit8ZSCVWpoQ+YR
 krhopU2TEZ/ejlfx9Dv7Qnfxxz0Wg0IyeWkmXDdRN0ysbUEywFRQFQvaS+1aGTZqxqzp
 Y3VApKcKJ8euT8vEnqkOo/FL8bDNYv3tLgkoScdlj+uyOtvgJPJjvpu1MD8mkEpWcAAS
 wdct4NjoREsPM5t01VpsgoWJn+47ug6ttvl87knbsG+SV7Ij+PGF0wULUuSmu5v9SlBL
 bosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624662; x=1718229462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2yO0OdwYwim1ELk61/r9M0BgP3RevAymtCd4BW+mUg=;
 b=nvKr7wY4F57gWuknqR2X+Y4K95T8CEJUlLwr87kYbo59jc+Jt/rIl3Awnq2lmWwfVO
 +X1X3jW4UzlBnekr7MXG6xqT/A213YkZOT2FKnn3ObrmkucWC4N5H/Ha/ushVy8tF1Xy
 jDYD1DydCllp8i2uMCjftyAG9N/yaV4GXuFQRnTY2H7Ki4OiZxwPqH77xzuUxyl6BQbT
 wh6btsMVG8HDN0oXf+e02vWmjSvqmsM+vR6M61aDjM1qwSXEeiUKWQiwUIyOSoqYZg72
 MsEOe0okI79U+vXaa9oNA4jSg5Lqo/jFyh/dQ21uHPeb0ngxX0u8EAEI/6USYzf6CUR9
 GW7g==
X-Gm-Message-State: AOJu0YynYNSnYbX1MGBXGf68gLL2OuH+Rh1j5pb0buKY1zC0Y7FP+sVr
 0uPFPAOYfZHW1Ludj0FJFYV6rBfCODaZjmHnVF4sE0a+dWUC1c/zOSFk2Upsv+4l4bj5wPrP5fP
 r
X-Google-Smtp-Source: AGHT+IEl/gmz8C8p2fQIpILq9cBuc2a+Yjza6lYj98ekcyFmfr+72nCp36ubnPhACf5+/IHfuMGQ4w==
X-Received: by 2002:a05:6a00:228e:b0:6f8:e3ed:d299 with SMTP id
 d2e1a72fcca58-703e59e799emr4495840b3a.27.1717624661643; 
 Wed, 05 Jun 2024 14:57:41 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 01/10] target/s390x: Change help_goto_direct to work on
 displacements
Date: Wed,  5 Jun 2024 14:57:30 -0700
Message-Id: <20240605215739.4758-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In preparation for CF_PCREL, reduce reliance on absolute values.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c81e035dea..f25ae02a4e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1073,13 +1073,15 @@ struct DisasInsn {
 /* ====================================================================== */
 /* Miscellaneous helpers, used by several operations.  */
 
-static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
+static DisasJumpType help_goto_direct(DisasContext *s, int64_t disp)
 {
+    uint64_t dest = s->base.pc_next + disp;
+
     update_cc_op(s);
     per_breaking_event(s);
     per_branch(s, tcg_constant_i64(dest));
 
-    if (dest == s->pc_tmp) {
+    if (disp == s->ilen) {
         return DISAS_NEXT;
     }
     if (use_goto_tb(s, dest)) {
@@ -1105,7 +1107,8 @@ static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
 static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
                                  bool is_imm, int imm, TCGv_i64 cdest)
 {
-    uint64_t dest = s->base.pc_next + (int64_t)imm * 2;
+    int64_t disp = (int64_t)imm * 2;
+    uint64_t dest = s->base.pc_next + disp;
     TCGLabel *lab;
 
     /* Take care of the special cases first.  */
@@ -1120,7 +1123,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         if (c->cond == TCG_COND_ALWAYS
             || (dest == s->pc_tmp &&
                 !(s->base.tb->flags & FLAG_MASK_PER_BRANCH))) {
-            return help_goto_direct(s, dest);
+            return help_goto_direct(s, disp);
         }
     } else {
         if (!cdest) {
-- 
2.34.1


