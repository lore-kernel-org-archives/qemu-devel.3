Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAAFC83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiu-0005oI-P1; Thu, 03 Jul 2025 07:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgW-00081l-5E
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgQ-0003xb-Lf
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so3869818f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540448; x=1752145248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJV4IXnKJHt8hWaUBPPZ6mJUKwfXPExjXmNVkOYEHB0=;
 b=oACxigDffrbuS+yd6ighggs9foOgIyDAPO2akOyyPsPMdI0TrmZ4kKkFCfjyk/x9ln
 XkKuTD33VHMxWYyExMWBUtQWuv8O3uCfH2/l2UFELik1sh/Y3npq9nFQi6zWvs+RY2hg
 Tt0UlWvNd0zjYtmeK1QO1zGhhBFeTUtEc24Uy7Sz8LfxDN1la3uWjWAhGtaza+7sids/
 elEXvInhlbD2HvvoWzU7qx1W0WJxeNJ3qrn4wJgezNp4PHmn/jTOldccEg1mbPkZ9K/9
 VKKeMzAvSUgJTt6Q4n7p9xRWQyLlgIK6XntnrkNWA3I76UmV5dX4g5/6FlgrzjGNLEtj
 yK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540448; x=1752145248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJV4IXnKJHt8hWaUBPPZ6mJUKwfXPExjXmNVkOYEHB0=;
 b=q/lFQr6jpcS0bVRqUTEg6Iyi8f0/HFW8mRmH8EKZdXIykG6tLKoghI967exzMOTQ2I
 FCE7qOmQFdvkDlcKBlOyvXZK3/sg4EKmd3mBT3I0ujTKiaDRoMBk9ScFADbPLVoPD/mC
 kNqk1/vI/NBUboN4cIm8frdBTW4Lk0vVg1jAt9vLW80kri4plZPLM/9Zq23c2HuCVq62
 56w5/mmcmza9XQECwSiZyYruSS0P/zKpLnpsHiLQOXG8tPqX9YNZo8bmvrGPu20ycO28
 BBwKXPbRtuCJi/9Sl/fv0vyvvwxDo0LUF/ADB04agifVPIM2BsO+W2ZJZSPwcepqUXZD
 JQPA==
X-Gm-Message-State: AOJu0YzkYJi3vGqCpPkfAwejgRE5GxYlRa0p+22XvgsbTQtlBN254hrH
 XTxG4CAX+vx8hhGLRVR/tR+CLDZzhYGSq5a9cbfQilyFAwHWBfW/SblJWcu0N5HCkjEBHj2/wjJ
 U76EWKP8=
X-Gm-Gg: ASbGncv6BZzjwcZpC8u6Z7PSeTAN7UEOCrb+o97URDLi2HfNQH01KkYBpG5fzQLIrkU
 SoIlUIL0m19/6Mra6BVQLl/e2bdYcwDPI1D9rSzXxCGs3/NbjNsfcdhcIHALc/NouMnkpXRhlal
 8hpLKrm66EyLOoS/MGB/ZRfYWv2W5Ks/t1xGYOmtPI1W7mPL1uXDlXxSdk90ozAgz7dutPoQJHy
 hpZ9G+35K6XI/KwwHClcHNtGBbBGp+9HQTD+eelKW8uV+Bs8POst1r+FJRD1QSdHkMpJ+yp+Joq
 l7fh/hqdIUkP9mLWT1574vl7XfreS6aWiQCEDhIwE8KnO/bm10ULLrLc22Ix6D8XVCEkLmQOcKA
 bBHjKhz/xPgQ=
X-Google-Smtp-Source: AGHT+IHqlssT48uJmEPZ4O3QCmimDjy4zBtYSgC8cT/L+FfgYjN8oU142izdLTVwVo9xkf1rmJVshw==
X-Received: by 2002:a05:6000:4610:b0:3a4:e609:dc63 with SMTP id
 ffacd0b85a97d-3b1ff1473bdmr5354926f8f.20.1751540448033; 
 Thu, 03 Jul 2025 04:00:48 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e72b6sm18616881f8f.15.2025.07.03.04.00.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v5 58/69] accel/whpx: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Thu,  3 Jul 2025 12:55:24 +0200
Message-ID: <20250703105540.67664-59-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/whpx/whpx-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 011810b5e50..8cbc6f4e2d8 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -61,16 +61,6 @@ static void *whpx_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void whpx_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static void whpx_kick_vcpu_thread(CPUState *cpu)
 {
     if (!qemu_cpu_is_self(cpu)) {
@@ -87,7 +77,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = whpx_start_vcpu_thread;
+    ops->cpu_thread_routine = whpx_cpu_thread_fn;
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
 
-- 
2.49.0


