Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C5BC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LtB-0003Pb-DT; Tue, 07 May 2024 10:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lso-0003Dd-R7
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4LsY-0001M1-Fr
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1edc696df2bso24108585ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092391; x=1715697191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvLDyjlftTGN0sw83s7qIPiInOydYZwm2rP4d6xfyvo=;
 b=dxC0XAMBJOtlJriEprTskAWg/NlFcijet/Rx21dlNGpid79X9G5QHDd6vcIzsGpQpu
 rgOvtKCZ7HGs8UOZmGDhM8O9Alhta0nvFd40uY2chAc3/n9y0Z4jzeibzbIE6tbEFky4
 RiYRrjwSEm0nx+Mot/+8OQKlqfkt6MXMYev9ZuijiYAWnMZ2g6pzzYIK9aAyD6e3qPch
 qB4nh5XYROjG0FqnKazg4HuOCaeFEIl5foRBlkNi5NuDmwlMYKBTZsrJ0zkvc51Xejli
 a3nERbKxyDT3tr7rXh6rDuOrnKQXjOMOlVSQD8Rhwmf2932rJZT0tvToeSGnaMQodQiu
 KOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092391; x=1715697191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvLDyjlftTGN0sw83s7qIPiInOydYZwm2rP4d6xfyvo=;
 b=UnYY4Zv9TEDZVhInaOHkKzEA+Rrh3+Mmha8EG7toMV7IJ5zCkIeNQrUqa/2FsElyHc
 bnhpBdYV9IatVHhlWsImDdjwDQSCM9ctBauqxsJw8vr5ByAIDMsPeoVaWVlgK1es8BF/
 c4L8dRDa6Jw8hyf13mq6SNdJd3/yRRHKYxVCV/0SySVNMP8Po7yMyg2Vq6jks6rcjslO
 2e+BpihehP7WOVASXPBTMQ+K8w0GkIfxO3NCMfLSpUkzSmpACZllCvxqltPYqb9q80kL
 DVpGMI3wAxnQWW9JBzqMYijG0tKBvBTCEo7+SU8jZqIgMGiCh1/YMBHik5pCR6U2ZP9v
 98MA==
X-Gm-Message-State: AOJu0YyBN7Nbr8g6qT/DjzC3foD4dzn+99sZdF44fsaWavQW1I+OCsGb
 +c1ujqCg6yU6u6OHQ3YH1pnh3VeBP6hXjkHHto4F6rGLvzlH8V4mFDgUm+EcmQgKAhuxNrqX2MK
 n
X-Google-Smtp-Source: AGHT+IE4N3bp++WKJOGHjWoDAbTPM/uEkZXhZEPAsNfaaL1c0qngapjijJlcw2ledXD6WhH+bTyNjg==
X-Received: by 2002:a17:902:b948:b0:1ea:cc:b59e with SMTP id
 h8-20020a170902b94800b001ea00ccb59emr13029089pls.19.1715092391536; 
 Tue, 07 May 2024 07:33:11 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/9] tcg: Add write_aofs to GVecGen3i
Date: Tue,  7 May 2024 07:33:01 -0700
Message-Id: <20240507143309.5528-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h |  2 ++
 tcg/tcg-op-gvec.c                | 30 ++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 4db8a58c14..65553f5f97 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -183,6 +183,8 @@ typedef struct {
     bool prefer_i64;
     /* Load dest as a 3rd source operand.  */
     bool load_dest;
+    /* Write aofs as a 2nd dest operand.  */
+    bool write_aofs;
 } GVecGen3i;
 
 typedef struct {
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index bb88943f79..0308732d9b 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -785,7 +785,8 @@ static void expand_3_i32(uint32_t dofs, uint32_t aofs,
 }
 
 static void expand_3i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                          uint32_t oprsz, int32_t c, bool load_dest,
+                          uint32_t oprsz, int32_t c,
+                          bool load_dest, bool write_aofs,
                           void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, int32_t))
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
@@ -801,6 +802,9 @@ static void expand_3i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         }
         fni(t2, t0, t1, c);
         tcg_gen_st_i32(t2, tcg_env, dofs + i);
+        if (write_aofs) {
+            tcg_gen_st_i32(t0, tcg_env, aofs + i);
+        }
     }
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
@@ -944,7 +948,8 @@ static void expand_3_i64(uint32_t dofs, uint32_t aofs,
 }
 
 static void expand_3i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                          uint32_t oprsz, int64_t c, bool load_dest,
+                          uint32_t oprsz, int64_t c,
+                          bool load_dest, bool write_aofs,
                           void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, int64_t))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
@@ -960,6 +965,9 @@ static void expand_3i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         }
         fni(t2, t0, t1, c);
         tcg_gen_st_i64(t2, tcg_env, dofs + i);
+        if (write_aofs) {
+            tcg_gen_st_i64(t0, tcg_env, aofs + i);
+        }
     }
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
@@ -1102,7 +1110,8 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
  */
 static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                           uint32_t bofs, uint32_t oprsz, uint32_t tysz,
-                          TCGType type, int64_t c, bool load_dest,
+                          TCGType type, int64_t c,
+                          bool load_dest, bool write_aofs,
                           void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec,
                                       int64_t))
 {
@@ -1118,6 +1127,9 @@ static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         }
         fni(vece, t2, t0, t1, c);
         tcg_gen_st_vec(t2, tcg_env, dofs + i);
+        if (write_aofs) {
+            tcg_gen_st_vec(t0, tcg_env, aofs + i);
+        }
     }
 }
 
@@ -1471,7 +1483,7 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
          */
         some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_3i_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
-                      c, g->load_dest, g->fniv);
+                      c, g->load_dest, g->write_aofs, g->fniv);
         if (some == oprsz) {
             break;
         }
@@ -1483,18 +1495,20 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         /* fallthru */
     case TCG_TYPE_V128:
         expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
-                      c, g->load_dest, g->fniv);
+                      c, g->load_dest, g->write_aofs, g->fniv);
         break;
     case TCG_TYPE_V64:
         expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
-                      c, g->load_dest, g->fniv);
+                      c, g->load_dest, g->write_aofs, g->fniv);
         break;
 
     case 0:
         if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_3i_i64(dofs, aofs, bofs, oprsz, c, g->load_dest, g->fni8);
+            expand_3i_i64(dofs, aofs, bofs, oprsz, c,
+                          g->load_dest, g->write_aofs, g->fni8);
         } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_3i_i32(dofs, aofs, bofs, oprsz, c, g->load_dest, g->fni4);
+            expand_3i_i32(dofs, aofs, bofs, oprsz, c,
+                          g->load_dest, g->write_aofs, g->fni4);
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno);
-- 
2.34.1


