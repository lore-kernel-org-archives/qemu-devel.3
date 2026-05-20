Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BBCCD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlYx-0007CU-JS; Wed, 20 May 2026 14:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYo-0006z8-1N
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:26 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYl-0000VU-Nd
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:25 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-366330b6751so4143294a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301342; x=1779906142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAosT0zOJ8eHcyZ5INON7Xq9l371iEzZ0qq0XCtPW+c=;
 b=bi94fMnM2P3pNj8edBduvhbLZGlnSLb54oyrpMgzI2YKOuusPjWFdaEDMH2yhVCOV3
 7U0Uh9s3oD7DYbYuXVfYzBesjZ3CLzuMLDvP691W972s45KywFihJSu1spd3mzxrUSBg
 f9uaadrJfsTRicVboPR/DJzG7H5SjuJCwNV/kYHYW4+DwBYZeq7cSg5glk7G7LehYGVy
 295EAV/c1Pp3j/5H+X3oec9wQYlPhHek5gnSz9nJwS38KuzK6eY3EKUAAEJpN4Y/oovW
 rLk6g+AgWWcUYvBfz8FndnG2SgvIAqGVumaOOx5MvK50v7AasbsqWHNAOs8t5onGyr1N
 husQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301342; x=1779906142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JAosT0zOJ8eHcyZ5INON7Xq9l371iEzZ0qq0XCtPW+c=;
 b=TEmLorfSVpUktGsVOP3sWui5e4l/cgEe7bp544asWzF1g/9he7rJA33MEsfX/ScM8c
 MJJbuDlpe97qFs6+QGegk//eJgMC57dXzowYmogeCnKi5ZzOGnDObDb+sLu8uzCvVrs4
 X5PqbjyfyCfKap5n2Jq5vPz8HId7oqHGXRKsFZ0gXPfiy2cQp+AEKfGjKVCF/npKTMTP
 pIhaQ0YNvimtLxxPh9+ou6SVS4inSUgh6OxFGQwoVEQ7d1nE4kkjGollOxLj+PbF3z/3
 PjSTv6LZiXgiDfywUMouGxGAGE+c8ZEAy/qzK7wVlv54A40Cm3DF0ykkSGWDVPkQ8JlE
 /EYg==
X-Gm-Message-State: AOJu0Yzx+nDPpveQ11JBlkaLn6Q/YJ0q/s4DRR3TKXDCTd/3Y2vxRKw1
 wV/IUXo0TrJn/dJRZwqYMA1nMJbMvfstZSIqh6vM2K4SMQWVqL7OI/GaBOT6qZfWwGVkQrHb8Vn
 O5JNR9mA=
X-Gm-Gg: Acq92OE7OjYQmydtVzEVtHnH6XePo/4XtOilf8ic8yKtRwpXkfbwg2mhSEoJui4p34M
 G8OAO7DuRkRuwVnpzNztBYJjSqJfmqxSL1ym53flVOpeeruCTzlu8YM5t8IV2g05NisLo6AXBAK
 AsgTPqvF6bVa6VE5TtX2Js5ghWDsar8TY+xtBpGL3AqzuZJ5RKd5KJ9T85Is+5Nmo2PCuRVLM9p
 mKMQqXL+W90OSVZ9McTOw0Y30UDXztZMEBfaHDVYIWR5x/7DQabTPblxMjvvmlSj075W6X2355A
 5GFesPdJYJjCqmQ+LP77CL7p8tSsi+6fziNFu4F43PbJpQBFhzpR70zoRMBc0WQtVFPQ5FHPSUX
 nXu3Mx1qUMUR5S1Fbope6FRW7MCkIFXuQtFexADGMcPiq73n0AcRF4hIdkULVciOkj4CESbsUqt
 uV4ZhiydfdSiiFxJ59fJ9fD38aQPnJ
X-Received: by 2002:a17:90b:350a:b0:369:a74b:28c5 with SMTP id
 98e67ed59e1d1-369e930bb1cmr10526266a91.19.1779301341702; 
 Wed, 20 May 2026 11:22:21 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 10/64] target/arm: Enable EnFPM bits for FEAT_FPMR
Date: Wed, 20 May 2026 11:21:19 -0700
Message-ID: <20260520182213.872945-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


