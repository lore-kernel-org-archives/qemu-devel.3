Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855E2E98FA6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 03:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgPc-0000ea-40; Wed, 08 Apr 2026 23:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPa-0000eJ-Qe
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPZ-0003sf-DF
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:34 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b2ae8a0103so3024235ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 20:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775706632; x=1776311432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skSN8swTI7EkG7MjAECKBkEvBElR0vgImQ1L9hy0ps4=;
 b=I3HjK2Y+j8jlLwvol61wGCpZya+FPLFckil8EoO8TbfdhPbVGxq4queqmTYtljYOGX
 blPdCsCw01/QmqImMQ3oDTv3GtNCbol8zSKURTCI/yPxeIoVDxBQnZTrTbqg4aSfe8Pm
 80eSyjmxNb2Zg2g7+PhqbGAyatfUXOW/TeqweooCB0vgNi3IyRQTqqnn2YjiPJuzlBpa
 AgHNGfu5d3p0rdv7BCTWtf1iqRUveumH62/XrTadm1taBSb1cvjXykmnIBARK0KJjRm3
 sXpbb32UhZi0xuxeGp5zqeoWqXEFwiybi8A1CKbfJNh4YbxayM3SxS0d4xX/nHDagLn8
 Ly+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775706632; x=1776311432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=skSN8swTI7EkG7MjAECKBkEvBElR0vgImQ1L9hy0ps4=;
 b=DKqh0GTspmKKgZnp6pMEDmsLOwr0gkFqmhO5gO6LI5+l0E97U9yXmnXFALvhsz9Vnm
 mdws2Dk+lUFf9g2eusmKw+7wEY89EZn73KYw7EioqsvXETUsF0iN6JYf/CtO1RMA5CYJ
 oCUWW44y94Yb1JhqBh7z+LZA6DyrLwgHSn2v5R33Cj6lO2Z64KV60isZ/HJxEI5F4bd2
 mq/ctUPP+eAIhJzQskDUEktbSNVjV7MAEj8ROOyV9sh2/J+Iu4fDi73ZmrtiGpFYJ7zG
 4ULw/5eyW2XKQ1Lu282SY50V8lYfUhf1POSHIL2ICoByYCuVfTlU574KqQ4mkhszz6dl
 HKtQ==
X-Gm-Message-State: AOJu0Yx+s4zgvmCvX7IwKQpRBCIedhlM/XJ8b2dB/DhWgcwIOKKMveMy
 Kv6M6GEgbKYo+qmAyQGRtYKp31KgsAlF6RYh1EpKES50jixJq/NmaMS3SfI0hwEYKBCEdWIKEL6
 1E3SOyic=
X-Gm-Gg: AeBDievVpVV9pGI1krbCPhX+TsV+1kIJgQwOwhOh0KpIej4BXGfwBnKbgCxx+lriZQq
 CUD6ZrY+AiRP/LLRCcTv9Gf+7jFCJrkYXxzOihSei6bTFo065WOFHfD86RgbpL1QSRlUAbhiWFm
 /DvqQw33O/us4ZoS7nNtp8P6OT6B4oqBJ8lIacLhVsMrpXG/DFs1FstItUI+nzTqxuoiF3ZuDaJ
 rTYFH0X2643ZD3mFuaytLlREtQhX/hLWTOsCrUyAOml9boNVilr1yd5VZP4iOsqpCONcXA+fpAX
 L4NIoqZG+UNhV30WjBfg2TgjBya5Jl7OdpMhpssckBzotGvHIiuDPOwxvpR62M5qqcGmUGveBOW
 Ngx/6LdtwnwQ3DZKToUutO5+vWbLUt7hFwx1e7RCvXyNiQi/kO+QIRq+WPFArSm5ooZZBeJMYGD
 F88pzmFFh3qXaY9Cn4oByrpe+4Ov1CLMfxDbdLd0kGD1avisGQbEy/NvCW
X-Received: by 2002:a17:902:cf10:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2b2c73acaeamr20502745ad.22.1775706631956; 
 Wed, 08 Apr 2026 20:50:31 -0700 (PDT)
Received: from stoup.. (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2745c480dsm277830605ad.0.2026.04.08.20.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 20:50:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
Subject: [PATCH v2 3/7] target/arm: Segregate target-specific user-only fields
Date: Thu,  9 Apr 2026 13:50:11 +1000
Message-ID: <20260409035015.132370-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409035015.132370-1-richard.henderson@linaro.org>
References: <20260409035015.132370-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

In CPUARMState, we have one field that is only used for
AArch32 and one that is only used for AArch64.  Use one
more ifdef to avoid adding both at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..b11a31c807 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -812,12 +812,13 @@ typedef struct CPUArchState {
     const struct arm_boot_info *boot_info;
     /* Store GICv3CPUState to access from this struct */
     void *gicv3state;
-#else /* CONFIG_USER_ONLY */
-    /* For usermode syscall translation.  */
-    bool eabi;
+#elif defined(TARGET_AARCH64)
     /* Linux syscall tagged address support */
     bool tagged_addr_enable;
-#endif /* CONFIG_USER_ONLY */
+#else
+    /* For usermode syscall translation.  */
+    bool eabi;
+#endif /* !CONFIG_USER_ONLY */
 } CPUARMState;
 
 static inline void set_feature(CPUARMState *env, int feature)
-- 
2.43.0


