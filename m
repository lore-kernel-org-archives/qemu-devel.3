Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D089C48292
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkF0-00027W-E1; Sun, 04 Feb 2024 16:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEy-00027M-Jt
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:28 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEw-0003Wx-T4
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:28 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d7881b1843so33273865ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082885; x=1707687685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cadphwjaQtxJbfsAaQ8Tf54zJ/KIUtYE/z1XZRnv4ls=;
 b=ku22g3nGIuWxxSCPbBcJd3oPlrdueh62068hPqewhZklqkBz2mPJbmvHFeuMmIytOb
 4jGvXhrIaQungek92sEULLt94mGB/V5tmbp2bP4VkIyUgCyukuT9BxeUeOLAaqFUnLfm
 e5udlxLwS+pUrP9qGqplr/tQdTOEN0ztvXejetLCDobFnCQExV90YHKSag5CGXj8RKtN
 O3ZLop0KJbGxMZEAIUZB6xBT8qkQkFY2zovNlMcrQv1ZijCbWEIlNsYi3xHcS0f2ZnlN
 04xtOIli9vLxpj1nzVmXE2x4i25aw/+qK5eJS1KO/ifgukFym/Hd7L6EG8ktczkSxBk2
 0wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082885; x=1707687685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cadphwjaQtxJbfsAaQ8Tf54zJ/KIUtYE/z1XZRnv4ls=;
 b=LV1kPRqyaOyUXYaQvYjGG66LXUDJcipBy2gqYe5bBnALyyth/sRGCzZUJ+EMa6Zgdt
 pX54+wFYnamhZdluixORgcTNBK+QAOlzAPd7XEBrGk7qyDApS90oj4phZ5npfJFMowCR
 nOaH0G1NUZYbuArzpxe54cRZwUF6+MOw3sZO/OCvFK5NZeCSywk1pMWTHzblFRHjlJVK
 NiJQSwwzVr5382MJ4nUguYQxjsjE0pCWODltzBmMpUAPWkEJhVsF6tdxwP+dpalr6A07
 qXv2enLpCy273OOn8NZQ8VIsE63MoolYzmItJcR7q7m8zQsjj8z+WxQ8/43tbL6xRMKW
 YK+w==
X-Gm-Message-State: AOJu0Yyjc0esvimY77p7njT9CdF+Qsvce0PTVospSB0MZ6zLENyipD7C
 ydiuJHT+ZbyeUiKYEcBdZu+DEpPdV9STxaXTPmKJTKU5dShoaQcxF040Me/SH13p67r5Lbv+99i
 01YU=
X-Google-Smtp-Source: AGHT+IEOuxDtOA1wPqxiBKny206cm8t6NnjgPgrsVN8qfgf+ERS/4J+cIr5uzknZ9k3+ZYGDn/Bojg==
X-Received: by 2002:a17:902:d34d:b0:1d9:5ed4:ec07 with SMTP id
 l13-20020a170902d34d00b001d95ed4ec07mr9583863plk.52.1707082885716; 
 Sun, 04 Feb 2024 13:41:25 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/39] target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
Date: Mon,  5 Feb 2024 07:40:27 +1000
Message-Id: <20240204214052.5639-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

These are all test-and-compare type instructions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a5fd9cccaa..05fd29589c 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -754,10 +754,10 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
     case CC_OP_TM_64:
         switch (mask) {
         case 8:
-            cond = TCG_COND_EQ;
+            cond = TCG_COND_TSTEQ;
             break;
         case 4 | 2 | 1:
-            cond = TCG_COND_NE;
+            cond = TCG_COND_TSTNE;
             break;
         default:
             goto do_dynamic;
@@ -768,11 +768,11 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
     case CC_OP_ICM:
         switch (mask) {
         case 8:
-            cond = TCG_COND_EQ;
+            cond = TCG_COND_TSTEQ;
             break;
         case 4 | 2 | 1:
         case 4 | 2:
-            cond = TCG_COND_NE;
+            cond = TCG_COND_TSTNE;
             break;
         default:
             goto do_dynamic;
@@ -854,18 +854,14 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         c->u.s64.a = cc_dst;
         c->u.s64.b = tcg_constant_i64(0);
         break;
+
     case CC_OP_LTGT_64:
     case CC_OP_LTUGTU_64:
-        c->u.s64.a = cc_src;
-        c->u.s64.b = cc_dst;
-        break;
-
     case CC_OP_TM_32:
     case CC_OP_TM_64:
     case CC_OP_ICM:
-        c->u.s64.a = tcg_temp_new_i64();
-        c->u.s64.b = tcg_constant_i64(0);
-        tcg_gen_and_i64(c->u.s64.a, cc_src, cc_dst);
+        c->u.s64.a = cc_src;
+        c->u.s64.b = cc_dst;
         break;
 
     case CC_OP_ADDU:
-- 
2.34.1


