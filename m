Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74D2CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXcZ-0001zs-Kx; Thu, 14 Aug 2025 09:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcM-0001nF-Kh
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:03:42 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcK-00055I-7E
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:03:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e2e618a98so723933b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176615; x=1755781415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yp6GjOVr5sFSu+DGzVCc+heSPSS1fAAC7M3WZ7lFas=;
 b=PrSW7HjfMN8woCbZ/B3ORMCGhXyNHIu0BJ5uXGqokPIDsgs/iTxywq6hlbaZ7NOOsE
 KnmDr7ojpXkn3wOXtJRR6XX7vDuKAcPENZo6R/fb6hZ+OuIhyqqvZSxGxAnjEGSrBaxE
 iijivDnvOKoMmowY2p+HoBbl0uVHqnP2u5BQrxR4zNRf9Wa5yEWrteGaGw+E3IYa5r4Z
 EFV5Fv1Nrvt6Ai/WE+NXmkTtBLUUuMZAbPv2QlSCbKmE8Ez8EgfA+qzAuPWNMZKaO1Mu
 0j8wK3IYnrEYSWBZfFKleBhfb0MMHSsnnFm7wzaEOitw9QGr8K6TFZglDWmTdYnEHLVn
 oRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176615; x=1755781415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yp6GjOVr5sFSu+DGzVCc+heSPSS1fAAC7M3WZ7lFas=;
 b=jnzTWtRT94gUyvS3zGxljFOUD8qCuOmBSblcfwB+VU6qVEZQ0FD9bZ+B2+Y1//gAbt
 AxPaY0QQhduNYh3Z7kg6IRVvdTCfjDP5tQwbSXZucix7t6vOeFA5X/4NjEUrPLe9uzmx
 zMqGRfAFIi9xtmQW3pIlCaoiMMNaSko59dNC0RvG7Fyiyu4jP5HUxI0id8fLxEjyqHDv
 JKxyN5krar8SIZ6HFMJmpzy9Laq+pv5NO3BhvyZ7MEvorMBLRvgYN7Cw7uQ5WQDCfkFv
 GQMpamLS7WNRWnR0xq+F0vz5I1nlp6VGV5J2g/lsaSw/qEIw0RK/KjX2vcDzVDg66k/6
 Dxaw==
X-Gm-Message-State: AOJu0Yzs5FxObtZJbjM+T7LBKU3xFs8CqA4/h+OjEoU25mZY7XIL1AVC
 ciu7HJCIe8pHZ0m94+9hcfac8WLeN7W+Z8g0IA7xwoFwTiZyXlmSYEIMywW1fWcyM+bFbhMWr6S
 53oWPKg4=
X-Gm-Gg: ASbGncvOP2nTmxSWabfpZKxBksJmENlA5/xsY6O59SDWo55WOo1jxDtiAV/J6R9yBCi
 Nbf+0SNRMHj6IoiDWtXR03uhWFa+yNKmpA5oUlXmjISLudfkqpKlI2uRAGWbqQ547baMZavWkNZ
 s2EwVEyLj1PLRNEFpdtgCwhOTxy5/grQ17jMWM6lTD9fLtqC29ZRIk5fDAFRHzRdjE4NolCvyEu
 yy4MHu1I+epmdqLlDNI2a6Ir3PXqkxSxH7Pgw/W3gTmbVzpnMcin94gqdhmGFRIDThbFC5c3y36
 gcte57jPBj438DuFxonTp6BWRGWuHgI8uF8DxBuLvKCtZmxTG8ookegT72fUe1lxgHsOn7ZVgJj
 PIU/olOyyldWrHJmTIaq9woM+R0MvAkFJ2wpchh/szNV8EXw=
X-Google-Smtp-Source: AGHT+IFOC0GrVvjWN9ArDtg6B4W1m8X3ZTuXEPQhDMMDlj2ImnQHbJKuKAvBLAvloAAY6281VHG0Nw==
X-Received: by 2002:a05:6a21:6d95:b0:220:7cd5:e803 with SMTP id
 adf61e73a8af0-240bd220406mr4524143637.21.1755176614440; 
 Thu, 14 Aug 2025 06:03:34 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:03:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 45/85] target/arm: Support page protections for GCS mmu
 indexes
Date: Thu, 14 Aug 2025 22:57:12 +1000
Message-ID: <20250814125752.164107-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Take read and write from the s1perms.gcs bit computed
by the Arm pseudocode.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ee887d9a02..3c84f0f024 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1584,12 +1584,16 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
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
 
@@ -2236,6 +2240,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


