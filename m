Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFDCC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJf-0000ae-1J; Mon, 23 Jun 2025 21:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJZ-0000Yy-HQ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:09 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJX-0005o2-UQ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:09 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso829294b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727946; x=1751332746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkgZSBtedJbrmOYNbCd3Ipd1R538BuXURl0DXnFRDDk=;
 b=SNLYE1Yv85JgCMnW7OTHSddUkcm74AC3y7xKlpSwKMg4wBrDMeUkcMvc0wH7MhtE6M
 UdjRyW4eHOxdaPexxRK+s6KTWo8E5e4Rrd+hXHQLv7P5tCCXLGh76gVz6P1kl6oBvrYv
 DJxUpavMEHcEj214gJO5R+uRpdVGbB5ZCUjXitlAiI4698wETRwYcR7VPDsqEpdcjOXo
 CWqX7Te8SM6q+3RaCYIVhb9iTkVzmdekRF5Gjy+HV+DIgxJhF3k+dyX22eqRtJadjaOB
 Y5k2MzYI2sX/GGgWaIcnOQm3CUtKV02TsqAKukfGm7uA+gVTG0nM9S+XepAbuKSeWGqO
 se6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727946; x=1751332746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkgZSBtedJbrmOYNbCd3Ipd1R538BuXURl0DXnFRDDk=;
 b=cpYbpgiYMnh96ActdSCsm6b8vayF4aU9ndGKJ8OshTLIhtbWpe1MQ+QPUZQfRtYFSc
 YAk9wiZz8qScz0UWxSIL4KMi2MWiI1BX5K20ZVr5JLF+msWLDYX4KZx1GTldoBPufGHs
 x3ImIXnHTCw1+BkCdSr+yt4fGP6DPd2UNjb4iChkaLSfX6BdvHKKmqPZbo/IfsX+W5Nd
 oYSnhRvWvRz8Y6Y4iA3q4dRteDkzFUeHec71PSquR7WAM74+au59IgU/A0EMKIVqzUzT
 cZlx8m5IwrlBzhnfrWn8cqHveAIZCNKY4dx0zGvYfu8PZ7FFYhFHMmneBjv4lvhpbqJo
 atsw==
X-Gm-Message-State: AOJu0Yy5PtuMwPzE0Un3C7ANNOSTQnLQs73vMi5yB55vUaaM2EbRPaoK
 M7Q/y3A6MsWaei1CVqE7sL3GxjwVGYpge/it3sPKP0Upm70nXXuj7DfpQljr4vj6mhVRSMPtv2n
 buMuNuHg=
X-Gm-Gg: ASbGnctTLMS+kEFBSY66PX/xQermFVd5p/cYQaCh5N3KiH4aVdbYrEjssEnigGvbR9U
 3eS3iUyBxRU89DVqsknYvevsivmfrir4RofthBEH9cKQRZ2c0cThzqSWMhmgG1dg3YEz9oMxbjh
 u/NXvcTxSaENrHnomi1kZLeRoTNz/RLCzJEVRdUh60kZxrzrzSeE+pqX+G8iLynnglO2UueAEwn
 YZ0RCB4B2gRTj+JoV5pFvJ4LIur7HT9M+XF6RxuTrRs4XcEs39V6a7A709+NIuhljOwkLdREthi
 st3sATuH7H2JcCK4FAuVL+GBx2cUHni1uMwKrT9Lsi1bfaea8d9Xt0ekez/zrpvlveoyoobPzQC
 Xn0oy7YxGBavgLKJJySAJjlRLuODX9e0=
X-Google-Smtp-Source: AGHT+IFj7Kb5nhNXNY7GQAzm6Htug+bYSR68nlKf++wI33retlEzvI50pSJsRz7r/ZLENposycYGNQ==
X-Received: by 2002:aa7:88c9:0:b0:748:2e7b:3308 with SMTP id
 d2e1a72fcca58-7490d764201mr21336793b3a.6.1750727946532; 
 Mon, 23 Jun 2025 18:19:06 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/11] tcg: Split out tcg_gen_gvec_dup_imm_var
Date: Mon, 23 Jun 2025 18:18:57 -0700
Message-ID: <20250624011859.112010-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h |  3 +++
 tcg/tcg-op-gvec.c                | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index c93d8b2356..ea0c87f4db 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -386,6 +386,9 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, TCGv_i64);
 
+void tcg_gen_gvec_dup_imm_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                              uint32_t oprsz, uint32_t maxsz, uint64_t imm);
+
 void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 9714eb902b..2d184547ba 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1897,11 +1897,17 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
+void tcg_gen_gvec_dup_imm_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                              uint32_t oprsz, uint32_t maxsz, uint64_t x)
+{
+    check_size_align(oprsz, maxsz, dofs);
+    do_dup(vece, dbase, dofs, oprsz, maxsz, NULL, NULL, x);
+}
+
 void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
                           uint32_t maxsz, uint64_t x)
 {
-    check_size_align(oprsz, maxsz, dofs);
-    do_dup(vece, tcg_env, dofs, oprsz, maxsz, NULL, NULL, x);
+    tcg_gen_gvec_dup_imm_var(vece, tcg_env, dofs, oprsz, maxsz, x);
 }
 
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
-- 
2.43.0


