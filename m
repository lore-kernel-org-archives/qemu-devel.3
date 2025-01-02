Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01D3E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPba-00074a-Ss; Thu, 02 Jan 2025 13:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbG-0006yX-Oy
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbB-00058K-Gv
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:11 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163dc5155fso155960025ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841226; x=1736446026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tZNuCKxzVy4h1cgrq7+uWPj4SLLD6iJ8Nf3UNQrxKyo=;
 b=doAemeL9Rhr+TFSgKweS8lrKwNtUfs38lm+K/K2R2ivi4CEPH8JJPdhtKXKPvBhQ9e
 9ytm3ImbHtZSPJc6/aarSMTGAnCCrFjTzRN1FfndJ82nEip1B0IdyM9re+ZXtHRDv8Rz
 U9MFbfJJEmWDAkRM8aZN4hjz0oc3feuCBh7/6a5kfEJjUhOzD9d1boXJRcwXbhMxGX4d
 Lk6uXcgheNODntuZjHVoWI+a6kktWPT3ehUl37B8CAUa+ndDH2huWlbef77lYHJX/nFy
 tVUvEuKiiMGH8fAScqSuLwhzVwx9vh8rshO8sJL4YOA+gcLuViUKZPmMpPMh+fAHSxeY
 S8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841226; x=1736446026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZNuCKxzVy4h1cgrq7+uWPj4SLLD6iJ8Nf3UNQrxKyo=;
 b=T+lZDztpUivfScS3NIDmA9Zfks8OpegGGQf/K2XBWpwNqenLAZEjz/lGhGCyY+BTTH
 0scRIJ4dkLTJpIce40jd18ebWXCG1M23ZGKzP4m3mjjx3kd9FktKpGNLyZmSOGNZqWrd
 Chh8wVE7cOs794y0FhnsHxuyvwnH4YVTvCHPiW7q1C7LcEEksXHPR+/kN0PxO5pJ/IUX
 MnsUf0BD5Hl41UA/viBIsoPcInS41Thpmv6OIXhg1ZNNVKOLOfuXKsTTEp63aPH52Hzs
 8KraNmIVw9+q74bMOsnNbPMAFfkNUwVIySuL1As41y+dgtU1Md3zOUmTGJdrChlMKfQ2
 ukjg==
X-Gm-Message-State: AOJu0Yy4gu0NHP6nH3bm2m/m+wEhKXIYRGjJRvMc3BdCuhq1hI2D1t4D
 XxDsYdNll3gYUVgJ6aU1kupqi3zkEIjZzeY5YEHFDm3g7FZtkhebPfguARtDmiLGjrm/7u3I11e
 I
X-Gm-Gg: ASbGncsNqp3Hu1Ii8k2KQuAf2bEWJtIZz36QaKtFRDY6r1UunTu7JTDtAfADIGpSjTJ
 7ZtR+HbN2nSoCpHBXOZ1tefeF+0HBO4lWFuyZnGnriKtUazAaegEEjsi5FC5dmN4kWUxWd7p8av
 7mRd4Axw7pfLOq3K1vqEdAQAdVMCsaKIBb56Cy2u8sGdEbILzHWtFtgvUB3YEIrJzwS0wZSuJku
 hly9oCSlpTaNEGRDQQ8BbbBBmGm+rWZtZO14MC3CNrt8dX5bCyKVC5pDEeQBw==
X-Google-Smtp-Source: AGHT+IHOEnnSnlxyj4pjNqNW2QiEgaQrczouZsRQftuv7H+E5du/LCal/nPi5aUZZIxuaDCvSvaCHQ==
X-Received: by 2002:a05:6a00:2405:b0:725:aa5d:f217 with SMTP id
 d2e1a72fcca58-72abdd912fdmr58560968b3a.7.1735841225925; 
 Thu, 02 Jan 2025 10:07:05 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/73] target/i386: Use tcg_op_deposit_valid
Date: Thu,  2 Jan 2025 10:05:53 -0800
Message-ID: <20250102180654.1420056-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Avoid direct usage of TCG_TARGET_deposit_*_valid.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ab416627b7..a2b940a5c3 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -25,10 +25,8 @@
  */
 #ifdef TARGET_X86_64
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
-#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i64_valid
 #else
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
-#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i32_valid
 #endif
 
 #define MMX_OFFSET(reg)                        \
@@ -3449,7 +3447,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     }
 
     /* Compute high part, including incoming carry.  */
-    if (!have_1bit_cin || TCG_TARGET_deposit_tl_valid(1, TARGET_LONG_BITS - 1)) {
+    if (!have_1bit_cin || tcg_op_deposit_valid(TCG_TYPE_TL, 1, TARGET_LONG_BITS - 1)) {
         /* high = (T0 << 1) | cin */
         TCGv cin = have_1bit_cin ? decode->cc_dst : decode->cc_src;
         tcg_gen_deposit_tl(high, cin, s->T0, 1, TARGET_LONG_BITS - 1);
@@ -3501,7 +3499,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     }
 
     /* Save incoming carry into high, it will be shifted later.  */
-    if (!have_1bit_cin || TCG_TARGET_deposit_tl_valid(1, TARGET_LONG_BITS - 1)) {
+    if (!have_1bit_cin || tcg_op_deposit_valid(TCG_TYPE_TL, 1, TARGET_LONG_BITS - 1)) {
         TCGv cin = have_1bit_cin ? decode->cc_dst : decode->cc_src;
         tcg_gen_deposit_tl(high, cin, s->T0, 1, TARGET_LONG_BITS - 1);
     } else {
-- 
2.43.0


