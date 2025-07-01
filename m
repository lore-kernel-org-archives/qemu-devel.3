Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59A6C8303D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDM-0002zm-22; Tue, 01 Jul 2025 10:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDI-0002xB-Bv
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDG-00077D-C8
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so3784027f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381036; x=1751985836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFCbZLFh6s5gvUITNzPlcEyRjZnGKZlhwWXK151kWbs=;
 b=sN15M4IA97mNnyqSGaMKksolscUa5cNDZ+t7voA37JV2pddx1uSUFtUaHaLiAwWMHk
 Nt9QrDWZ/AIPXg3VjpYmyIv/P98XGFW6VDthhQSntoZMU/LRyLiXGrFaRXUYF5hq9aYL
 xS2LiJaSC8eDMW+lC9MX+spBvMaHjehCRPaeDm0D26yAU6Ki1tcEC3cvRi/NS9a2kzIB
 qYns4WWCYwcyIMiwXbiB8pFRb3yPygGGpX2hAgRvBDX138n7aPafiga0m2R/CXgWOp2S
 pfVIqVgGcBsci3TsPw7PPmZpt8lT2JRubGtjVEI2MR9e72yfD36i7swFHq3bLk88pQt3
 J1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381036; x=1751985836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFCbZLFh6s5gvUITNzPlcEyRjZnGKZlhwWXK151kWbs=;
 b=ccxCbJru0gkOs7vn4pFBp1AGguIWV8Eb0wIfUHgohVtfM1h13Ha1dzbtRUs1wdCRqZ
 kY61RsvYqK7iXTUpcx/SBbYj59H8DWLNVLzwo63/v2iHOjys0l0jRhaJ3W5WZaNqPtaW
 RGWaLzHtwHNI+OTRzd0B2ByLK1oK2T26FRjM5wR5DjTy6R8gj1/pMZbwhS+WfiZIJmAo
 NxAGbKLa6W2o5qW9YjUXGPZpOyT76DqoCivodI60fA52yqt4yLWAjh0k6FsS6JCswSek
 FdC0y//Ugmf9Y8ssqTTDNB1VXnWoUZlBsFQe2HV0dbNsab+ktxs3iorh0NSy28Z7/54A
 PBVQ==
X-Gm-Message-State: AOJu0YxDxSrDol9d4BVFrZRsff4hKkRKrlRMETxzbkT+jj+UrfFxCY4t
 Ra4flkM5WWA6zUTe4bt0NmmRHOCI3wEpYt2E8ayZS8qpbI1fkUoM13pmpAyYfM8VkqAK6ccELYW
 W2uJr
X-Gm-Gg: ASbGncvlNTGWaCuAObCv7A3Bi6HZQTR5scUHJl9NyFUz2eMF+hmYWpmixC2LwzoB1ym
 U67SGEeLimzxrsC+do3seNbWJkDEizx+4iDKMfmDnGKnhKYBvjOkTEC4sdzdsbYkl3AEhflapXc
 fh8RL9suRbmckaQBcv7j0RGMAaqEjUzg9GVt7hDQxaV/JIJdw/v/s5bRnwZdbEAExWWLHZDi7Im
 Bd7OAih5d3dsj18fr830Z5dPXN+3vxfggKwrP9iaP+N1OeXww2N/QcJNRnhlVLDuWgri6ubE7bl
 3VzrAs1PrDpmZiOO0KaLos9539vThJ4/fmN0AF/c2JQR8/XXtTC7CXuQ5/P6mQxjYKpuMJIPKt7
 sj+G+jNZ0a6aRXh8Qy6e+fS6ARzmF8aC/zk8gkqjIv+e0VEU=
X-Google-Smtp-Source: AGHT+IFOTbskEVRdVyr2VPYQ8HCH+54/ldz8ZH9pvO+AnV9itN4fvGKp1fQja6eg68GYO1rLqxpOJQ==
X-Received: by 2002:a05:6000:240d:b0:3a5:7895:7f6b with SMTP id
 ffacd0b85a97d-3afa1b09aa8mr2475669f8f.7.1751381036136; 
 Tue, 01 Jul 2025 07:43:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e595d1sm13591058f8f.71.2025.07.01.07.43.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 41/68] accel/system: Introduce hwaccel_enabled() helper
Date: Tue,  1 Jul 2025 16:39:49 +0200
Message-ID: <20250701144017.43487-42-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

hwaccel_enabled() return whether any hardware accelerator
is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index fa9228d5d2d..49556b026e0 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -39,4 +39,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


