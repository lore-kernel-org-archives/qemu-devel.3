Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD22CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPj-0008A2-E4; Sat, 16 May 2026 20:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOh-0007DS-K3
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:31 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOZ-0004vl-Gc
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-836ed29d1e5so408771b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977814; x=1779582614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAosT0zOJ8eHcyZ5INON7Xq9l371iEzZ0qq0XCtPW+c=;
 b=rYBXiCwRzwHU7n8pK14lruj0Kyfqjwk5fjT9HeP/VWin4Ld95lQYOda31ohdd1YT6G
 R0ELPzoWYVr92burPOaBn6xHz0Eou7qqB7B+TEXWKg6fxUsvsMdQmjqTP3ag71STOxUI
 thUnnqwjxN9BmQglh0fnCLcY4Tu/0hY55b71wV8Ak4oC5va++KxPZecmSwl7PCv80kdR
 EdGLIaCs/+S8AOVxZTEehxXk/S/8zvOwQYK8p9eoAwh/eNiFeHjjWTF0xcI6kCkjUcfy
 aEFQZhVN71gNd7u+5G4CtVX6CR7qn+nDy+eLYdzo9rl6ddOYoQ/r5F1gRmAuTsGdls1h
 rJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977814; x=1779582614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JAosT0zOJ8eHcyZ5INON7Xq9l371iEzZ0qq0XCtPW+c=;
 b=p6XjFAUoWGHQf6P+JHvRDze0Gj7yc8HaW9fWTYz5IRFGkTtDKs+9vovzYy4SFNnZT8
 kRPkzYnU6GFM+AgvBuXBRL0/yfY1moH3i+8eBMfWdI3Qo17Vv9gMojis//1Z5g4IQuG0
 jclXJRR65s0n/qqfKfhoB3n2CX+mLkwwU0Vg40Ki/NOGBR6eqk3ZQdMsP/R14cV7OUAr
 2WetaUfi53KqAJ4sDW+RhOBlkD4W+H82DvT6bI2BuNjHfd/ZY6yvv+LE105P97hfY7CJ
 D48q7rc2ib3zH9Y6MRiGmD70qGxmqQKc4RpkTeDDMjCJJDpOPlxFdLjU/Mid5SJd4eLX
 nGzA==
X-Gm-Message-State: AOJu0Yy1qVjEY27rFqx0n06tbPJ1z47ZeVtPp5o8DAAxG4ta1/RHxOuY
 bdyy21EyzBA6Ckx1NA26WVJ0pq+owRj7VBq4ZM2NHMW+aK9z5/6vF5QqizUBI+UtV5/PPYPGfbp
 BNxW5
X-Gm-Gg: Acq92OE7kB2Fw2pqK9WYwVJgBr8qUdwTxlL3bjrrNLU1CndSQRgzWLTLE4qG9SSexU4
 tK7HXoLvD3j4jHgcZTIwDXWS7XYnwms/wFQ/RQb8LpNtjy3lSqMbcrc2mNqegpEBUS5zNlbZhAd
 fkz577aq1RGosGLdmimv5KWsFay/f5JEMCbcBNTsK22fSEMzUMw0VInZ2Fu8lr3AsyGAoFmEivD
 CLvbzvVhR2ogZDiODam9te/MwY0T4Z4hjNzY/5HCCljSlUkLV0BaeoDOYBIBtZEWbL2Et2rl/yY
 84ClREOcfkjwxXjfeoKXZ9ZEmNA04cRpTs5iuri9p6b19+d6BzhPajbW4Tv44XnBkUnFxAVcY2p
 sB3gDc/YLouw4pIHKpk2hi8O1VZAUvUPhwpHL7U60NuJvbp9oPo2ayw9s21uJJ3kAcxes38gH6l
 rONTcBWWcZccFD8anWcvG6VyeVC3i0
X-Received: by 2002:a05:6a00:94ed:b0:81f:4e6a:7276 with SMTP id
 d2e1a72fcca58-83f33c9400amr9378250b3a.14.1778977813546; 
 Sat, 16 May 2026 17:30:13 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 11/63] target/arm: Enable EnFPM bits for FEAT_FPMR
Date: Sat, 16 May 2026 17:29:10 -0700
Message-ID: <20260517003002.321430-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ae1dd42dc4..7eb7031294 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -787,6 +787,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_mec, cpu)) {
             valid_mask |= SCR_MECEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            valid_mask |= SCR_ENFPM;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -3973,6 +3976,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_gcs, cpu)) {
         valid_mask |= HCRX_GCSEN;
     }
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        valid_mask |= HCRX_ENFPM;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -4046,6 +4052,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
         if (cpu_isar_feature(aa64_gcs, cpu)) {
             hcrx |= HCRX_GCSEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            hcrx |= HCRX_ENFPM;
+        }
         return hcrx;
     }
     if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
-- 
2.43.0


