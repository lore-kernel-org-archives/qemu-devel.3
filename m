Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B29C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg7Q-0001yB-LP; Wed, 24 Apr 2024 13:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7O-0001xR-Sw
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7N-0005M4-F2
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e411e339b8so234425ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713978552; x=1714583352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39YtgjPga6zni7TyfrRqLQG7p9NAFXqRFglkaRLeOY8=;
 b=riY7IcgvqpyOOaYmLVHR+TEDUfAIXdU5SXlEvDEYFzxkJJJK4Tgs81O3lv4kGgDNRa
 O0bDTt7GcE5WtobBbwIapEagi1Bo3H9Q8H6DQLqlJbAI7dcweUXvPoQf8JLp4OyUdNWv
 jIvUolKhSRsel6/fQGf0PjP8ahP/8ZKXmKkCVxTkfbWhfG9KNF57uKd6Apxtc66OP0Ul
 aiWAmOKFGzNI5dsz3Z73PpMBaUI8ttI6MINBF9t34Y+TlAnH4M4fa4S3vOJkTWJaRqnK
 4r6UqlMeXGpuYY7P2rK28InvW6YRuvowkjTZMz2h6ZU2HPaCTRvndSkj3wAxRkYM9ZSM
 iOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978552; x=1714583352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39YtgjPga6zni7TyfrRqLQG7p9NAFXqRFglkaRLeOY8=;
 b=MCwpOOwciGlLAZs3P7kqq+gUrF7HctRPqR6XxBkKzPX3ZQSlhSvm7StnfUK9Rw7zxn
 mqCLb+5Dyaf2g95GXBaEtc90lcv5iTkThs75mCXDmpHZmv9IIRo6MePKOkHGpjyO6EoM
 U77vqNbNdVPwHxlHvA91jccAA/yMkmAmZOeliBY6WdGFlYo/lksIfAVcy2g6Bc19gxAO
 Zxf9NrmlLN18Px5kEqBOSfYJ1RgiBaXulqI98i+gyPkBfoQbVsh1WqjIgqW4XzU2AbJD
 KG0Q/oCvS5Bx12aIMjeNWwtmNLTXXNpnRuZQj2wExrwEgHSS+AXgV3KhfOfiNGMFXlgb
 Zfsw==
X-Gm-Message-State: AOJu0YxwNks/Bi+vUC9+AiDZyqe/t30rEoBN3x5vDin5nDb/vmmMge+z
 oDpIT8qaFYEJnh/qMSdqd3CzzeLteh5QbwFAWx+cinto5awbLVz0NKxvQ9q+IPhwFVy5U0X+Owi
 X
X-Google-Smtp-Source: AGHT+IEi3kaQhKL6ZwhR5d9UW/yKOsN8PNq3Jv+ifr5sUV3Xb+LjKF0Kd1q6M5LpjTtCHg82uZLKiw==
X-Received: by 2002:a17:902:e944:b0:1e3:dfdc:6972 with SMTP id
 b4-20020a170902e94400b001e3dfdc6972mr4491229pll.9.1713978552013; 
 Wed, 24 Apr 2024 10:09:12 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902e80800b001e0b5d49fc7sm12215489plg.161.2024.04.24.10.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:09:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Restrict translation disabled alignment check to
 VMSA
Date: Wed, 24 Apr 2024 10:09:03 -0700
Message-Id: <20240424170908.759043-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424170908.759043-1-richard.henderson@linaro.org>
References: <20240424170908.759043-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

For cpus using PMSA, when the MPU is disabled, the default memory
type is Normal, Non-cachable.

Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when translation disabled")
Reported-by: Clément Chigot <chigot@adacore.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Since v9 will likely be tagged tomorrow without this fixed,
Cc: qemu-stable@nongnu.org

---
 target/arm/tcg/hflags.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 5da1b0fc1d..66de30b828 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
     }
 
     /*
-     * If translation is disabled, then the default memory type is
-     * Device(-nGnRnE) instead of Normal, which requires that alignment
+     * With PMSA, when the MPU is disabled, all memory types in the
+     * default map is Normal.
+     */
+    if (arm_feature(env, ARM_FEATURE_PMSA)) {
+        return false;
+    }
+
+    /*
+     * With VMSA, if translation is disabled, then the default memory type
+     * is Device(-nGnRnE) instead of Normal, which requires that alignment
      * be enforced.  Since this affects all ram, it is most efficient
      * to handle this during translation.
      */
-- 
2.34.1


