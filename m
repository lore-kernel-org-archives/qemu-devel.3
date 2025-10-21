Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A17CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJUf-0004n3-SN; Tue, 21 Oct 2025 17:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJUZ-0004m3-KP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJUX-0002xD-CZ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so1723765e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080519; x=1761685319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGsMkVpjo/FJHdJoOY2mGhnpaGdDSXbai5OydODTaYY=;
 b=GPydu0nZXumx5M9FIttY4Zq3c06yBAmZN5m3BafRcjfWYsnQMMTysx+wvHXmJ97L+4
 GCOOk6WhqtxpKIe5IRj2jkRMw3/00TrdS0HLJNcJ3LPnB0DJWwKQgFDSTGIIjTwDong9
 iPU1S7xyFs+Qkeg2vgHzeXvsbR9jkxPju6fPRNibeldIyZOy07fj0RLQHxECPmlOjs/N
 jrI8p8DrTtcXG6OJGHO7Z/5Ox1ovfTKPQ+KxEo8StnVz7f0HsOVwtEdw4OU7U6XIM7p4
 o6C4VdKs9MZR/1Qz0d7jzU2yrMUrng6TCWqNGgM690KKw0KLBSNRUVRAn75wJCZtR+8R
 G1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080519; x=1761685319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGsMkVpjo/FJHdJoOY2mGhnpaGdDSXbai5OydODTaYY=;
 b=sGYX3oUH/R4b7rjTBbdYuy1JXz36YXoocUvb1L64kZhwGaIN7i6kcWwcvkTTfM+Bv/
 o1sBqQwIJqT3S/PRVjLpNwJqQiQlXk1/IYJ2EqGRxUC2Db3oiWKDQLYP3jWc01iohPAp
 sVbgzrqvhygEjSjypbwuI3/J3N69+RrbPwCO6OOKDJ5PfY+PC+1Cn8wpPWSsxnzrISiT
 tTwW3pdxCzuTusK8LO5jYmzGkwGMrfkbYMWl0oz2dUFgkKRV1m1rwFtYmSN7jbWksjt3
 7+bByk8RXGbG14NEnSQJGyFeIslpl/K2HH0AehK+5yoJFK1Cnc3OBFVl9N17WNB9B7Xk
 v3ew==
X-Gm-Message-State: AOJu0YxSmnio5cCciWkFmZozvrqYWKGrSCUpOCb68f0XiQh1iBqsQHnV
 5uV/8/zhwSmu9SnkkRCXqveDN98QvxvABIldNfuTJCf3OGGugzNsWbFbC0oxT4omdqRZ0YbAely
 PzRyL6cY=
X-Gm-Gg: ASbGncuGBYgNKXCl+x0Z2ZPPEt9GEk98bQ+wZVp+ISClOCKj7fakjg4GIGagHtsmbU5
 VBpvwzOhqWVngIQ1V1kZU/s4dCa7OVXf6i8cp4k+7QSqlBeYTsTMtW4OBKdk63dnsqPxFOZoiHK
 rD3Sc6wDajwW2JsQBbyqCnoRdaFl9wrxOlglDsJXykIw/tGBh8Quz7HncH5OwSXQrLFI0hgff42
 JRyHIZeEXQaExTofxB3RLEMbx+KHIZTb4gjxUPMFSqylBoAp5WeL4nCiCBHxnrs1CvYgILDBgnL
 I6QSkRkqmXYDgZzetB+U/tL0B1Sdf229XB3o/apS9jhAnSnwiaZN1yM4w937Lj3eV5dj8sAMmsn
 UczpQ/LU5U/uiPaUNjjnK1LfW+hhZ5UsGVbB6PJkjr+GMAaqeLJlMb9/rRZ7UcRdvcldtknTjmA
 +VjsY/pATnmEzII6Iqdp5U1Hpf4BBVd6OSgZCiFaQBPPp2u5VHNvocakaf6dAD
X-Google-Smtp-Source: AGHT+IHSMMPfQjlspTu2har5xD223jvfvApgfGIDcrRlWkd/AzEEkwZfWUduEFdHX+8haurbMMQ47w==
X-Received: by 2002:a5d:5d8a:0:b0:3ee:1368:a921 with SMTP id
 ffacd0b85a97d-42853278c2cmr854024f8f.28.1761080519142; 
 Tue, 21 Oct 2025 14:01:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f88sm21127833f8f.7.2025.10.21.14.01.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:01:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 10/19] qemu/target_info: Add target_aarch64() helper
Date: Tue, 21 Oct 2025 23:01:34 +0200
Message-ID: <20251021210144.58108-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Add a helper to distinct whether the binary is targetting
Aarch64 or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 984fba3f42d..e8fbdf19d53 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -57,4 +57,11 @@ bool target_big_endian(void);
  */
 bool target_arm(void);
 
+/**
+ * target_aarch64:
+ *
+ * Returns whether the target architecture is Aarch64.
+ */
+bool target_aarch64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 40716bf4051..e567cb4c40a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -57,3 +57,8 @@ bool target_arm(void)
 {
     return target_arch() == SYS_EMU_TARGET_ARM;
 }
+
+bool target_aarch64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_AARCH64;
+}
-- 
2.51.0


