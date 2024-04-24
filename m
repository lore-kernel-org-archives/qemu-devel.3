Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB26EC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg7T-0001zA-QX; Wed, 24 Apr 2024 13:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7Q-0001yE-Ru
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7P-0005MJ-4D
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e8bbcbc2b7so502215ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713978553; x=1714583353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KHDjww4pw6BIJWGas2p/P5rVjL2rJzApCM5JT+Uks+8=;
 b=L9hVKtCBjyBW7kK5z0F0c7Jliqi/V/L/B8taIJdcDewTKlhM1011FFVloxSVAqHD7V
 RQKXD+7T5Es6U1/tit6Oqu/iwZaEREOcDPXXMofVDdio0MscPWT6wOsfORxZB5vgOkj1
 GwcXQRBWaCH4jcpl7pAwM+BD6oOdsgmPICq0bSuVfT+BF0f/H0uildMqeyp6vgUWLad5
 n2PN+vB9hNqs2cxCMGUwZCywu8DjDa7lXNRalgLf2emmUWqWg4tcFxWvlRpQT7f4zul7
 l7XUKXW0wjVq/p/ooTc3qYjj3Ckt81UxDbQL0slDZejRyLeTiOG6H429eJ6NLbGFuFRu
 HmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978553; x=1714583353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHDjww4pw6BIJWGas2p/P5rVjL2rJzApCM5JT+Uks+8=;
 b=kMjHpcY6vDekv5wp2NwYr4x1aGdkY5eKmI4Js3WpB0yFbLa/FpSCVcuT+NLa+NO/4v
 Q2y1KEJkha+D3hO1dEe2vT/t+fB3LFQXG6ctWmC4aO/qQ8ikAkh3WTn6XHaWiBl1HoEL
 uH8vPzhFDpU3B37Q1GZe6Qlcm2XoiQevfYLoaniYMD/Tuc+uGF9C0z3Ta2N8tSqo8R4i
 NtwzpJ2gUZdMR89deSq1seHZJzMWQm5dePUTwp/G9EKHF8Yz2TdQ5xGnEV+9A2myb8wZ
 yxvhUV9CN/Y/3t0Ky/4SNfVV3Rkr8Wwvb0CXSkLCgFbt+Bs0oNYDIVKtCvVEgmc9FHaa
 4HcA==
X-Gm-Message-State: AOJu0YxXIZkIPEt5G6KcVHaDVJl3xAx7OiHucPeierXkBFk8nFlYl6h9
 Pe+XACUJ7QlFAaM+drGmPBIA0uqCvk/ODZPXu/sgbAfft0b2MmmJMVWxSvzgQANtAcGBySCZESY
 R
X-Google-Smtp-Source: AGHT+IGEumGdugEFeniZ8yzLJX4wL3yCOpTmXuZOT12XMIQq6P3rc/eVhpARI88J8eCNT1AFg29o8A==
X-Received: by 2002:a17:903:284:b0:1e0:dc6e:45d6 with SMTP id
 j4-20020a170903028400b001e0dc6e45d6mr4460721plr.60.1713978553551; 
 Wed, 24 Apr 2024 10:09:13 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902e80800b001e0b5d49fc7sm12215489plg.161.2024.04.24.10.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:09:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] tcg: Add write_aofs to GVecGen3i
Date: Wed, 24 Apr 2024 10:09:04 -0700
Message-Id: <20240424170908.759043-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424170908.759043-1-richard.henderson@linaro.org>
References: <20240424170908.759043-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


