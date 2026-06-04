Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83859CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoC-0006jg-7Z; Thu, 04 Jun 2026 19:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo8-0006eL-TO
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo5-0007sN-I9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bf237e1433so15377585ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616940; x=1781221740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMq64cpca08GVKd7Jpufwu6Mpqw06YbTJ94bxInMeec=;
 b=PQkKpVsw47paIo5dC1xf/BkBr5pYk47FD7+5e+3zmjwWuz+mvXgLxaEavrALw6QzP8
 LfZL/mTwDrLWJm6vkiKSaWW4bg1rYw1lazv2h7LaxmpTA72m7z4ZvifsegnuG63ZsJb7
 muhwf6Xn3RtwWN1/khhTAMk/63qItB+8ftRcvShh2eBbco0x3aivI0bhQXnMN9xllDkV
 1wp7Lo9YEuXIA/alZ0y3nBQOMnbVohv5cLLhRFiyTdU7awo+2QwQnO2JM8LEpPJFhHPq
 HEVwAS6VfDI7lM+XfpWXB+Xkd8xDpPlaxbU1fuEVKqWfnYq4jFy/+CbU1EFmDvsC0uJm
 Jdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616940; x=1781221740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kMq64cpca08GVKd7Jpufwu6Mpqw06YbTJ94bxInMeec=;
 b=lYIh2U4XjjCTS7AxdKvewWh9Wj59caVtPKPu8WDOiflfwRGzvat51HviR5Y1FfJFS5
 bDLRQWIILX5RqbWa10xRfQLKbzsY9iGxt9GhmS0Q/qsM6Fqd3NFaYzbzsGMuxcAMRxd2
 ZkL7LSejm+Ppe4GkpXyyLVzxQib0UD+YTBjxvw2N5uSKNyDGK3j7Y5vIHKkwCqqZwV26
 8ibN276xVW3RkAwvsVwDF3oMB6HYUJ+hDr10dI9elN5A58N2JAYT4hWI3bhE19lvMJqb
 NRy6e9O4t5Vw/ysmogzZJ95kyIF5MSlUYvClU+p7hX3NNvK1kNDRG4xs1SlAXlCrVvNt
 zD0Q==
X-Gm-Message-State: AOJu0YxS5dkhlIsyrlhdcUOKduANyKN2gGAC5RhPCS//I06vbhaulTmb
 7Jnjc3LfDOgwuim12+bdbcIwbx+qOda0TnUyEfFwILGELBwxvDCmm3iRRZkCcUa6/6rLsJrPuTk
 mipvzHnQ=
X-Gm-Gg: Acq92OF2GoMGMOthqw6jnsrldXiclVHYhVjOmA/NqV2ymMEFuOE54c7EpALWSOpRnsL
 rJrNCK5ssPnB3bhONMJB8zFhmh2MCQftlDQ/BUpxYtMOTRPGBKbk+BzxNSAa5uRN1ilwZFqxad/
 EYk1O0LHGWAgS06zJSku6/BQl+vW1IRitESltNiQcWDJ9g/9WnT2DjmiO3tMFjECYuhNnNHWg19
 P8ZHbyQkuZFJXEkb2+LyMCJyvtV8g2TxLE35P4pUixV6jBgckZxj3Wju53dTG7dZeyqiQPDWFxT
 l/NxR65pvaR2C+pJHLQWX6zo/vzmfjU2Y4Ee3liKYtI6vqofnO6BUw7RJHn+q53IsBF4o+47dds
 ixLbYVRrsxR0a1e0RGa7xtquEGygceYTH3RGnBEu0BNZ6iRmhrlZQZGW/QLBhqKh8W6Axd/MPQK
 KU5AlBybZy5l8GM3ATLYbJcJ3EjhnxgoYaUwZd9dcaG9p+hyYvBQ==
X-Received: by 2002:a17:902:e78c:b0:2b0:c59f:3b58 with SMTP id
 d9443c01a7336-2c1e80ff880mr7038795ad.9.1780616939934; 
 Thu, 04 Jun 2026 16:48:59 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:48:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/25] target/arm: Implement SVE reverse doublewords (zeroing)
Date: Thu,  4 Jun 2026 16:48:35 -0700
Message-ID: <20260604234852.573178-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/tcg/sve_helper.c    | 4 ++++
 target/arm/tcg/translate-sve.c | 2 ++
 target/arm/tcg/sve.decode      | 1 +
 3 files changed, 7 insertions(+)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 59e4bad05f..847c49d784 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -971,6 +971,7 @@ DO_ZPZ_D(sve_revw_d, uint64_t, wswap64)
 void HELPER(sme_revd_q)(void *vd, void *vn, void *vg, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    bool zeroing = simd_data(desc) & 1;
     uint64_t *d = vd, *n = vn;
     uint8_t *pg = vg;
 
@@ -980,6 +981,9 @@ void HELPER(sme_revd_q)(void *vd, void *vn, void *vg, uint32_t desc)
             uint64_t n1 = n[i + 1];
             d[i + 0] = n1;
             d[i + 1] = n0;
+        } else if (zeroing) {
+            d[i + 0] = 0;
+            d[i + 1] = 0;
         }
     }
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c3903d8fcc..ad9d30d92d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3089,6 +3089,8 @@ TRANS_FEAT(REVW_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
 
 TRANS_FEAT(REVD_m, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
            gen_helper_sme_revd_q, a, 0)
+TRANS_FEAT(REVD_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           gen_helper_sme_revd_q, a, 1)
 
 TRANS_FEAT(SPLICE, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz,
            gen_helper_sve_splice, a, a->esz)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 867ae2916e..45f8633fd3 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -734,6 +734,7 @@ REVB_z          00000101 .. 1001 00 101 ... ..... .....         @rd_pg_rn
 REVH_z          00000101 .. 1001 01 101 ... ..... .....         @rd_pg_rn
 REVW_z          00000101 .. 1001 10 101 ... ..... .....         @rd_pg_rn
 RBIT_z          00000101 .. 1001 11 101 ... ..... .....         @rd_pg_rn
+REVD_z          00000101 00 1011 10 101 ... ..... .....         @rd_pg_rn_e0
 
 # SVE vector splice (predicated, destructive)
 SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
-- 
2.43.0


