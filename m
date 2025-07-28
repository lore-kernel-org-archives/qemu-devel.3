Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EAAC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSUf-0004nA-02; Mon, 28 Jul 2025 14:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPQ-0004ro-5z
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:28 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPI-0002oL-Js
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:07 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b420b87cb04so381284a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726621; x=1754331421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cK/l0R+IQu4PJARiJoF6ivzv5QfPnUn4zekRDzw57vM=;
 b=oFKqQXCSJQB2nNQYjwrbPbVH4xbJbnZDLCedgMHyTt7KF7yiSK3g9CgbobOZ1uVohR
 btrcRgSmGmj0in4fEByt5y+gDNFqZKGSTM8LmN0tRfKQTgsppZNGIvrSeJfV45My5+DI
 gIc9jf1dxMbg13M3q9APCTX7bjSYrJcPYZl1xuBiN8k8A6DM3tTdZqM5OV7ICk4lXtNt
 Vu88SBRTGFiZrt4yfc57LBh58sqgmDsrRqRGW0QU2qOFP+DzfL8rc60ueG+hSIpOO1AZ
 oPz+bdvUM8szSjnJlM9zGDoYBMNOgVZQlRp3Wi89+3R24dlVBTwhO5IDtRNEURXSSRqW
 MH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726621; x=1754331421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cK/l0R+IQu4PJARiJoF6ivzv5QfPnUn4zekRDzw57vM=;
 b=b8PaRqqf6TKbMHfLqAdmmtaV/vch2c7uquEootHIV4dGosmZwFGnxQUw4K/Hx9YJ92
 1kkFC+zXUGciGpnwosw3WHVg425hG5TZDRgw0UBcypwalKceoEm33hyH+pTj30RfAYRE
 4fFzJ0qUMHzUEdymqdp7T/rffCsfWGBOLkpKQgSTkO5z41Csep+wUi0zRAXFBppXKBKP
 dv1SwcD9FzfG53xKXvnFO6wJaEdpzj8hE/lYR9el9yZJB31PuuioB6Ga5Za7zm7eIdGq
 OBl/wYTT6nSDKwnda/mUJTcrOOcjQXHzFvb71aJvd2iKZXAG7T4LGO7iAM9RFETqp2Q2
 sg3Q==
X-Gm-Message-State: AOJu0YwSagJl1MHUJwpbabWsadrQXaUzPzS2WCuZ/O4TrBxbCzO41Tt+
 FzIYnvuorV3ysOd44JiW2eXkObsFzXUqn0rxFInuG42rfJbaJjg1SbI890xh6j+Q+hJ+kQGjrGJ
 hFQxN
X-Gm-Gg: ASbGnct0/DGLpdMT6L0GljAnagUNjQmuR1C6UKE9DEEW6AR1UcBSQNtjOLQhhvBQiMA
 9xYcmG30H915d+v+BCgI4r7Dp5f/1riCNv8ascFhxB7VHIX2yEMUX1zoINabx094xeSq60ZPGt5
 tRrnJG0HZOJ6CcH0V82YcSaOytkSC+IONj2kHK5PBbi3CU2xuT2iEdiJzmyZ6nkaR+nCZsDYBmj
 okdpnWKXiQRbQ9RYUE8hkmZw3UOMVMRYlv4Q5Lp357zkOkxsFaQ2GT9eRLE2bJF/dYrfhulE9VI
 ds2FqL+NMFDCj8XDAOkJ+5uGdeqBt7vO6poiK3EvdfCyD58cFfoHcMvxqk4GcP5E/UcbKwG3Tis
 KP1XpM+ouY7tCi1LR5TGRkIjWtW5yApkQ6HtuvVHmpO71MxHnEihk5/BTf4UV2qKqBPC0BCaZhk
 v/4UA6uXQetA==
X-Google-Smtp-Source: AGHT+IGJyI+r7XO61hMCtEXbjek3vbkRi2ba0/SllpB7ys/0M4xowAQKa2UQrO+4ig90mDO5tzyfJA==
X-Received: by 2002:a05:6a20:6a23:b0:233:f0c6:a8a4 with SMTP id
 adf61e73a8af0-23d701a8a06mr24320561637.31.1753726620691; 
 Mon, 28 Jul 2025 11:17:00 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:17:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 5/9] target/arm/sme: Reset ZA state in aarch64_set_svcr()
Date: Mon, 28 Jul 2025 08:16:46 -1000
Message-ID: <20250728181650.165114-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-6-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit fccb49182e23bd359092f7ab09bc7e60a0fff71a)
---
 target/arm/helper.c     | 12 ++++++++++++
 target/arm/sme_helper.c | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 94a6f431a9..37e018e765 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6447,6 +6447,18 @@ void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
     if (change & R_SVCR_SM_MASK) {
         arm_reset_sve_state(env);
     }
+
+    /*
+     * ResetSMEState.
+     *
+     * SetPSTATE_ZA zeros on enable and disable.  We can zero this only
+     * on enable: while disabled, the storage is inaccessible and the
+     * value does not matter.  We're not saving the storage in vmstate
+     * when disabled either.
+     */
+    if (change & new & R_SVCR_ZA_MASK) {
+        memset(env->zarray, 0, sizeof(env->zarray));
+    }
 }
 
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 56a8fbe691..247c2823ac 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -44,18 +44,6 @@ void helper_set_pstate_za(CPUARMState *env, uint32_t i)
         return;
     }
     aarch64_set_svcr(env, 0, R_SVCR_ZA_MASK);
-
-    /*
-     * ResetSMEState.
-     *
-     * SetPSTATE_ZA zeros on enable and disable.  We can zero this only
-     * on enable: while disabled, the storage is inaccessible and the
-     * value does not matter.  We're not saving the storage in vmstate
-     * when disabled either.
-     */
-    if (i) {
-        memset(env->zarray, 0, sizeof(env->zarray));
-    }
     arm_rebuild_hflags(env);
 }
 
-- 
2.43.0


