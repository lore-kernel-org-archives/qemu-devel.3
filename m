Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8CCCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE53-00068q-Qx; Wed, 29 Oct 2025 17:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE51-00067h-UF
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:51:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE4s-0007oI-5f
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:51:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47710acf715so1691135e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774684; x=1762379484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VF6T+XLbTiLYka39LvghXibf6nOWNgxaucYWDHScU80=;
 b=fJ/s+Gehu+q+SbRgZG9QndGgNadqbenu6zxbCP13ZTesILHJgSfIScobluCW/Qav11
 EEMRpi7x3WPI52ESEV9SCZ/5pOjI3zD5lPqo1hQqQPcAlProdLdxCXUPNzbAtUiWElYC
 eNsnjB8s/PQF8l4X1E9+/9fubalQlBH4bl8B3tYbdMIXUPPtuLRcgBou5S4VzQ1il8SN
 4aE+3ZxWIzyvA9GR0nvx7S/A0YOg+wI1hH1wxibmfPSp9rGxvQtwG4IO5e5z+ZjyOtnJ
 D8MGol+gRPUgHPEhJthhkmIid9xrxK8n4wj3tl2p61ZPcmIaMzVWo2qNiTXpzGQK+5M7
 p/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774684; x=1762379484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VF6T+XLbTiLYka39LvghXibf6nOWNgxaucYWDHScU80=;
 b=gSuNvfKn3pHMWXcqX594dU4+ibreCYq0fm49t4T4t7DTsdFEeAcXFZasAMHo616I1X
 GdMv6ampZs4LAzMtdsaZRxv2+9Vzc8gfim1p1gVPZ2+QOKX4o5WlCxPJOO9JDsB2o1tr
 F7X0MCVtcjQLxlBQQ92uE61Xd0TV1feNdI7++pLgKAs8TalhYkchg8RGLs2i7XYt8Dx1
 mutw4UqiC5qTzK9Y//RE4VY7u3vopsSMZYLQWmJjT63BeHtaWKPodLuuaw76MiTL02Ql
 LGCJUGG/TYeyo0bI0384FPiIfsNQnYvWXn1yY9jYK/1g2pRYZNP1VHCAqwWziso/JjKO
 9yug==
X-Gm-Message-State: AOJu0Yw/63/B6y7mSqeDcBgXsWtLAozSkdzOjhxCvNjVSJJYnKsGuOUp
 BIy3A9VU69B+Ppv2PWVS+882Sz23BQZSo23q49F2VEisK6bKC+qr4ByyHBJ0OYjV33hCgFWKnR2
 4Q9GKnEE=
X-Gm-Gg: ASbGnctqYl906Zlcg3omP1y7mWxE6V5cV7UlFrzN4KMbFDjtojUSU4E4a6XjXQT6mAr
 aog5QuDcKJlWWvRv78ftvlVuUw9IEi/AjqXDPW1PmIhRoobePhYgpMjh8jEknyg7Dkr2xqMYoej
 9mIhZvMaACm9uwTKmWTrJRBqDT8l+W5qqopG8XHlQL/s35b7nsof+bUDO99qg8QWTmIam8Q/Eks
 pHXOui94lDbwPIUD8F8wsnNX0iGOZQQ+NSmlFbnIQ2Qa33H6pbiy6G+7dLlkF2padjfU4JQkVpg
 YkqUhakIdVxFzf+N9XLGuMqgcHFDglHE+Je415u4GFTYW7mu5ozuG5cAy5qPXJy3+aLybonxlQj
 jKdaXAe5dOKZOgkO6ROlXjTABe9Fnn+uKZ7IS9BLPX8VxA1gaPMCxZHE8nyOPNeFm7F0bdgm33C
 /CCCnAiTlFlk5VQdO6Mv9RCo/8AaZOQygGRAS+D2GhigCnYmayRA==
X-Google-Smtp-Source: AGHT+IFiKaVhur9fLuRyMkLTbTbioPhvuTbUKvoJM274VHjz6E/+phYwnKoizGiLlN6cqpMB0N1o4A==
X-Received: by 2002:a05:600c:1ca5:b0:471:6f4:601f with SMTP id
 5b1f17b1804b1-4772686efeemr9424655e9.19.1761774684231; 
 Wed, 29 Oct 2025 14:51:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289e7ceasm4510895e9.13.2025.10.29.14.51.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:51:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 11/23] qemu/target_info: Add target_base_arm() helper
Date: Wed, 29 Oct 2025 22:39:48 +0100
Message-ID: <20251029214001.99824-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Add a helper to check whether the target base architecture
is ARM (either 32-bit or 64-bit).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210144.58108-3-philmd@linaro.org>
---
 include/qemu/target-info.h |  7 +++++++
 target-info.c              | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index e8fbdf19d53..62359622232 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -50,6 +50,13 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_base_arm:
+ *
+ * Returns whether the target architecture is ARM or Aarch64.
+ */
+bool target_base_arm(void);
+
 /**
  * target_arm:
  *
diff --git a/target-info.c b/target-info.c
index e567cb4c40a..24696ff4111 100644
--- a/target-info.c
+++ b/target-info.c
@@ -53,6 +53,17 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_base_arm(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_ARM:
+    case SYS_EMU_TARGET_AARCH64:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool target_arm(void)
 {
     return target_arch() == SYS_EMU_TARGET_ARM;
-- 
2.51.0


