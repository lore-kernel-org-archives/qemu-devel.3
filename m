Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E92CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298H-00079O-O6; Fri, 26 Sep 2025 10:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298F-00078c-Rk
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2988-0005dP-2N
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e317bc647so15089975e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895731; x=1759500531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Aub0nVeKDypnEosBAZhauPvYLD0GV/ykfag+qkNYCrU=;
 b=uXbCU6ETuUK94hrbQb5Y3wtHFvcPl7CogCCVpEa1aScS5WHeOmTtB4JvOnUHzrtCYP
 zaB3YJgyOnwzLDN3Ej5CBzan8rlYNYwFNndsAa/htL0jVxjxzCYv9a7qYGtynZsEbvQm
 1sF8v9Bf6vaeu9GMs5/C3j2YSqzY1BvxrogVRxT9nvZrBWQlFy3hS67/sI9fga82dW6D
 gcXSywC/+nhaUDZ4Hc4Uaz4aBW6auZKRBO7AkJ6pBXHMAKanrQw1N6aI4niQyyfM2rxm
 Bco2cfnnLFFUfuWZ/7NwVPhdEEYR7Cu1iiG/J79FhRnA5F8i5joya1BWc9KlcbP43poU
 vFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895731; x=1759500531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aub0nVeKDypnEosBAZhauPvYLD0GV/ykfag+qkNYCrU=;
 b=p4S7IwELR7kKDru2oBAXIlFnM/zuVB/t5EnlLUCwGcUf1e3v51CciosDFEzcJFHlxk
 RBRN4yQuJ6kzF5VUunT3x331D4IRMk0ackPaGvBREU15MOIzklcy4HAR/SXyNWcOPBRS
 4c5e0mouDqwN7/61y9vYSUq7XKT+8ze0OioAITTRbjho40Cmr1FEFau5hR2TWSttro55
 hJsMcpM5V4OT3ctUochFXrgrw4b3Uhy1JwgWY+/ImvMmG0/DgXOZkcBotxnHyza7bxx/
 mTB3Yflg28t11DBhyZh1ecEldGNu+rCvr36sJugaL8gv2IKcMyBb8uF571eGI553tEaI
 +GAg==
X-Gm-Message-State: AOJu0YyZv5bAuvYc8cUcA4oxwqFt9mzSuahc7ZX9YM0dHJdAKcgcIyb2
 h4dejA5p4dKedCf4OA8xiIEE3LyIfnmtKd0SKKPJp84U4OvBlcRgEg3eNS5jdNlJp3KL+S6P2xn
 A/rYn
X-Gm-Gg: ASbGncskC1HRvNrQWNLn/AfyQc7JIlritaDZn8GWX9CvrTaKNljm7XG+dsLb2NF3BxX
 kgE+4sZ8bKGDS8Zvoz+dnzRAwEm6p/J9Af+LoUeiaIbFddKincUEtF4jMhk7PNu2bpB9/rFB4hR
 Skz3WJRB7gXdfYyQvcQorgefY5SLhRsQqm+SzA+p7MUktEiODRA/F9eYQ7EAR4ozmX1YF2fvm9P
 VYWfaRJwRik0eaNbLCCXnK5+yibtH7Y1OpFN05jYoZUKS8sOAZzV5jkSXF5RG4Hmg9l7zQlz9s5
 zoJ3YnDRlJxmxSDTwBwvJDFeCeUfMXfYVifsM6fpRjgY7upFVygPP4hL5BBIcIlPsaqJFpaJEFB
 ELjnvcOAyzuj4uSxCU3bXN+BBAy/1
X-Google-Smtp-Source: AGHT+IFmde5bhCain99h9qKHekJ4l7v/p00ytAq0jM1Hdu+l/yBG74LKE6hH8Fc+IJ1i2lArMRV0bA==
X-Received: by 2002:a05:600c:6306:b0:46d:9d28:fb5e with SMTP id
 5b1f17b1804b1-46e329ab29cmr77139855e9.5.1758895731199; 
 Fri, 26 Sep 2025 07:08:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/44] target/arm: Move compare_u64 to helper.c
Date: Fri, 26 Sep 2025 15:08:04 +0100
Message-ID: <20250926140844.1493020-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We will use this function beyond kvm.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  3 +++
 target/arm/helper.c    | 11 +++++++++++
 target/arm/kvm.c       | 11 -----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0f7df97b993..1d958dbf685 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2004,4 +2004,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
 
+/* Compare uint64_t for qsort and bsearch. */
+int compare_u64(const void *a, const void *b);
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c44294711f8..009f8d6fa1c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -40,6 +40,17 @@
 
 static void switch_mode(CPUARMState *env, int mode);
 
+int compare_u64(const void *a, const void *b)
+{
+    if (*(uint64_t *)a > *(uint64_t *)b) {
+        return 1;
+    }
+    if (*(uint64_t *)a < *(uint64_t *)b) {
+        return -1;
+    }
+    return 0;
+}
+
 uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     assert(ri->fieldoffset);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c1ec6654ca6..5a75ff59271 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -718,17 +718,6 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
     memory_region_ref(kd->mr);
 }
 
-static int compare_u64(const void *a, const void *b)
-{
-    if (*(uint64_t *)a > *(uint64_t *)b) {
-        return 1;
-    }
-    if (*(uint64_t *)a < *(uint64_t *)b) {
-        return -1;
-    }
-    return 0;
-}
-
 /*
  * cpreg_values are sorted in ascending order by KVM register ID
  * (see kvm_arm_init_cpreg_list). This allows us to cheaply find
-- 
2.43.0


