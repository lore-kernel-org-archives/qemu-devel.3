Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04779CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lcq-0005hM-0G; Mon, 22 Sep 2025 14:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lcD-00059v-Or
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lby-0004R8-SU
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:21 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77f35113821so1180760b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567005; x=1759171805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePluHC0H/NP5Mr3iGwvDk85qezCPg64S4ISl6e9Zi/A=;
 b=e302XKQG3JBdA35jxSU00tuIHvF3OcwwGQR+KIIr+onwM3Eu3Fy05IfebnxnszQrAh
 IRz+Xo35R7kye+vCCWfos/WJJzQ9gH92E9Jtz+9MikwJFEpP5y40Z6pe/bv5gFu55nmQ
 GfgbH1W9bnEbi5w1iBNUl8CZ9Lv4FWRgtBZJ0dx8iruG/MlUc1xLHQVexp3Wm0Bl6j0F
 Dhe8h+3cyXgTsHkFoSHt2cNyEg2pwWqtVmoL8lCxTr6ZzNJw7wOfyk9wzf295JPOShew
 xjckfwzQYwmi5qAcz+KYWcBvQMn1bxALnGt0D3cyIe2ibmu/YL+Nn2wcz/yHBnxyo/SI
 VWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567005; x=1759171805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePluHC0H/NP5Mr3iGwvDk85qezCPg64S4ISl6e9Zi/A=;
 b=BKb0VOmLHXWZNRYQ5oGVwDP5RW1eBoPOcZoZWkWtLp/GSAvi73sSlXpPFG3zRwYJxL
 xrUAfltQLGaemLKiuKbKr++c7gFrrNv1WFp8wVad8JumnFVtBYydT6FlvEMvioOiQ86f
 NGZbwcr9EM7GZH8Kp3A7IB+9x6F2fIckhblplJwsuh4TcUx8CG+jjXyKKIsS6oiYGz9+
 1t1nF09abCo3X8Oe5IQH/fkF9g5BL116yuhfvmTIjLa5QWZJoP8F+HHx7Zqi00RPkRdv
 uZIyCts3MzCQqCTMA0QeWizhQZsHZs5l8svwvhiZr27BjAVCU6wvBLBIcpQ6iMuDVOU+
 2zOA==
X-Gm-Message-State: AOJu0YwsX+X/CutOZNz5N56go4jLtIRM8qL8J+EWaEM2RK56RHj8CyHL
 Cj1mVS5u9MmW/NZQlIn0MfOxjFtIRSFrJxhgyeJ2v7AnGbQ7OUaU9jdeL3iEZ79tQMVGefvu++0
 hXkZI
X-Gm-Gg: ASbGncttW5rgPXj6KevzRt7VznCMBTaPwb2gM5EI3Lqz5jHZ/itHe0WinwmOxTKiuXt
 OJsYtX+9DHWlKGaqm5BEGRruEHUHTSGMzwEFSziNX+heGd7Kz0QiADsgiXA49Tr9lnbtKZNllcE
 Qhc+JKT+tMbc4r6iMKegC0XGPxbNHrDP62+Qv9mZHgCBUR/HcmbPcint/IRpQ/DyhEkdvmZP8uO
 Xwv/cWcaZjM2xAhj8n96b/YoKM/eaeLiwkDt3oIoqJ2XPljzhAiV4yhvXgEsoRV3gqTwSu1bBoE
 Lf++Gt/mZgOwenLPpziatCsc+RVswWp2l8nlVkrQOBSqfZwWT9bCpdYa7imqniZcBEst/tyHwDz
 q6C7hMO9OxYQS+YH37/ZlLDUg4MZk
X-Google-Smtp-Source: AGHT+IGznF8vcVQNXZl4n9D3ByK1OCWQV3jQPV9q8x3fqNxGF0QHJqlcnKvu+5n4I0uMT/aiD2DANg==
X-Received: by 2002:a05:6a00:1887:b0:77f:1a7e:7bc0 with SMTP id
 d2e1a72fcca58-77f1a7e85b8mr10602472b3a.31.1758567005232; 
 Mon, 22 Sep 2025 11:50:05 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 32/76] target/arm: Support page protections for GCS mmu
 indexes
Date: Mon, 22 Sep 2025 11:48:40 -0700
Message-ID: <20250922184924.2754205-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Take read and write from the s1perms.gcs bit computed
by the Arm pseudocode.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 16ca2b6187..bfa0aeb4c0 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1583,12 +1583,16 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         }
     }
 
-    if (perm & PAGE_WXN) {
+    if (regime_is_gcs(mmu_idx)) {
+        /*
+         * Note that the one s1perms.gcs bit controls both read and write
+         * access via AccessType_GCS.  See AArch64.S1CheckPermissions.
+         */
+        perm = (perm & PAGE_GCS ? PAGE_READ | PAGE_WRITE : 0);
+    } else if (perm & PAGE_WXN) {
         perm &= ~PAGE_EXEC;
     }
 
-    /* TODO: FEAT_GCS */
-
     return perm & PAGE_RWX;
 }
 
@@ -2241,6 +2245,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              */
             prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
                                        result->f.attrs.space, out_space);
+        } else if (regime_is_gcs(mmu_idx)) {
+            /*
+             * While one must use indirect permissions to successfully
+             * use GCS instructions, AArch64.S1DirectBasePermissions
+             * faithfully supplies s1perms.gcs = 0, Just In Case.
+             */
+            prot = 0;
         } else {
             int xn = extract64(attrs, 54, 1);
             int pxn = extract64(attrs, 53, 1);
-- 
2.43.0


