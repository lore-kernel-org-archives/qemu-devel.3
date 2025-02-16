Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79C7C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxB-0005YU-8p; Sun, 16 Feb 2025 18:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwb-0004Du-Dk
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:05 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwW-0006RW-DS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:01 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220d601886fso48379275ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748054; x=1740352854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5D1ooWpMQNpS4VfZLYdNBwbBFgDBM2YAK2voHTDWR/E=;
 b=TD9EjofGdKl5w8QeD6/r4nzqOIp9aKJkNbov7FUVCKn5fk6OKLE19qioSTTGeSj+WP
 oD07jjxjdSlM2FjGUo200UgdB6uWJfG9+BpTtKT0576vDor+FBelnz/pFbmYrP9qZ7yn
 1d/cqScKjpQZ8GkuGp3SVEPPvZ/ZsYVHX/ejP8MnQ/6yy+rYPv2qtmLKHyzbY3tAOBQo
 pUEJmrnkBnNiq/3vJq4lSXjKXc4jsFVXMWF2tH/DsAM1+EPs8VRXJhzGYcw2dWucT//z
 z3qGYVUCjwFpdGUvEEWCOQ86Yj8ghxx0y9N/6XweiG/shomjVG3VzBsictXNFM2aRB/8
 3HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748054; x=1740352854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5D1ooWpMQNpS4VfZLYdNBwbBFgDBM2YAK2voHTDWR/E=;
 b=fdURJSmkiQABAiuMpYqe0kH+deDk6SdLVK2yKXOLvXAONlFFjZ+FjSBZMsiYW5l8s1
 NXheILB08aq8uaa2AODUMVt83Utzl/nXUX2zRKF3ggXFuOi7/94gqD6KInQpr7JLuT/5
 Jb9wJDnO+oq0BUJLAOE/d7qiTOpeFv8UzmDpLoHW+oUiyaYHyFSvCIlR/Afr2E6rlnaL
 otyeHnMzEjMeXWjjs3J6+YeSUEgp2J3LjCPydTRs7WcWCLKeyR+xODSNEEcde8Ga9umk
 /MXBlecXO9se/uufFYbbAjEjza8p1BtHpztPEZ3iAEaqe1dcTqoG4vzZHOBEwDBIDjpj
 i/kg==
X-Gm-Message-State: AOJu0YxDAHjVWcGxcTZIY3Y5Ud/TeJ8mYIStFInSd3T4tvpA55YiOJkB
 O6awHJuHiV9w6r4WOb1Pvbu7aL06ICEQhwCHqODYl6w5Dd7AudBdOcX64l4D//Hk/hdXZEcmXeD
 J
X-Gm-Gg: ASbGncvjXmXkPehCOOZiO15AR8XJE0xtmcbHN7fSAJV2fFypgZSrbOoaGBrIxzrCbXU
 mLbV2pU/t6cJG3eStpxoGMPrexxCNhLfRkRSLXB4DUuXBciSWG7bAJ/bK8JgIFgdFPDI6WftG52
 gQGUs8RGmzRyPARNUyzAwC3m4j0TOtZ5QoASdMC7TOH1hS2aqyi/fQvOq95i9Q+OnGE4st8jlv3
 2Y7vrKwBXN/8F8nWdP35WoadcZ4Ne04VS7wpF9588boy2V2JDncFWPsfsnvVjA0E1xVKiedUJC3
 v3iu1uKQhLpNuORtgRDaxJUWJEKVCk2Gbng0Ogx2amUSrPQ=
X-Google-Smtp-Source: AGHT+IEof5PqzRcAuLvYbPMMvffcaBgIiage2Cfn3Asc13XkpawOLO8vQlFSFvklRFywN+ohd6UMmQ==
X-Received: by 2002:a17:902:e850:b0:21f:90ae:bf83 with SMTP id
 d9443c01a7336-221040d75d2mr114530525ad.44.1739748053890; 
 Sun, 16 Feb 2025 15:20:53 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 131/162] target/tricore: Use tcg_gen_addcio_i32 for
 gen_addc_CC
Date: Sun, 16 Feb 2025 15:09:40 -0800
Message-ID: <20250216231012.2808572-132-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/tricore/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5ae685cc5b..2036ac2cd6 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -1345,15 +1345,11 @@ static inline void gen_addi_CC(TCGv ret, TCGv r1, int32_t con)
 
 static inline void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
 {
-    TCGv carry = tcg_temp_new_i32();
-    TCGv t0    = tcg_temp_new_i32();
+    TCGv t0     = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
 
-    tcg_gen_movi_tl(t0, 0);
-    tcg_gen_setcondi_tl(TCG_COND_NE, carry, cpu_PSW_C, 0);
     /* Addition, carry and set C/V/SV bits */
-    tcg_gen_add2_i32(result, cpu_PSW_C, r1, t0, carry, t0);
-    tcg_gen_add2_i32(result, cpu_PSW_C, result, cpu_PSW_C, r2, t0);
+    tcg_gen_addcio_i32(result, cpu_PSW_C, r1, r2, cpu_PSW_C);
     /* calc V bit */
     tcg_gen_xor_tl(cpu_PSW_V, result, r1);
     tcg_gen_xor_tl(t0, r1, r2);
-- 
2.43.0


