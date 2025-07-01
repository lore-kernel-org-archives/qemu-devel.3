Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5B9C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDB-0002kJ-8J; Tue, 01 Jul 2025 10:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcD7-0002gb-RB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcD1-000768-Mp
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a528243636so3635690f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381021; x=1751985821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5D49Z9XCFxUaDjkyBITf0w2sDJEmWM2AObcY1hT7No=;
 b=CbI1g+kIU/uHw4mnuhAknYMFY45Orn02vqfmaU8OXFwU/7R+YNzC9UH35GEuJCqvTs
 jBERDdnK+2hbayMKXyBXBbSXy1gCJ4mMcbG1QS6H4yslOa9EiQsPWb+cn9OP+3HLhTAr
 NG6UsFUqn2Hgt65n7XbM8n9AKu6Xzz0OrsnC16C9rXhkVJelMphAQWpamKW5MGoKSeVx
 /FSjXcW7aZx2QaQZsH8/rq+Q6eEuoX9otU9RsafE2R6tbnj/V9mvGfeovdRvSUsoR0Jo
 k2JhIhi+VQouebrQH7nt8kYMsVEtySZ5uxsElhN6CKyuF6prGpv8JGiC3R+hQsLsUTdW
 HTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381021; x=1751985821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5D49Z9XCFxUaDjkyBITf0w2sDJEmWM2AObcY1hT7No=;
 b=GRvwf5qLhUTuNOHAOMiXncbVWKh20dAk+YjuiMeR2Q6Jh0GN19oahceFdE77QjUYzy
 c17oTc+gZfunNrgCtCoMsEFMamWs1iQPYUyhHcnsvniHfB2Iqo25GvF96Zbj51MQBpqU
 UWgcoG8T0MJRBKxUA8kRAc04XOuDDyBrY8EvH3JfYzS2HfzJd/J2J2EezMYhTI44Q96C
 7TjJgyzynx+40bv1Cb3KVJn2C+MKJY+vzuTCMzynBemVK1fpf0TULf8346dHQPc5k3Wq
 NzOHaHatU6g+nOzs1Yl8oPMVO9Jtv1K75sTONa11kSjZm6lMyv84JadyjvwtIS00plvl
 n5LQ==
X-Gm-Message-State: AOJu0Yz0If+yL7cgOEyEKp4h0RSDq6DIfokPW76UyK4rNhI7ASau8u+/
 H4s6MS34/Ww/JXHAekO3FB6Hh6EvY6sTOUy0nNBGo5WHSf/TQHTF8yoKzAO4NYtHGPKrgKAEtPG
 lpJmC
X-Gm-Gg: ASbGnctVcZYnAv9gZmT713nZIeTWp73t1uouRZLXUAAQ8UGFiSrPPwd2hZEzgMCfHYF
 qW584nzud3EsZOEbGfntp5yz0mcIIQJPXRm/TvIb9lv6ri39TM630Q3qFkEmVaWzxYIBg4wSFRV
 mU85T3sXtFhvVGNtjpK/c3zffxKXr0Dbhc6/Yp8Uig6CRTX8fjtg+6rpa21iuCmn0588aYJpq5H
 X/c9qbpxKU/QCMz80p7tBTmnFfCwOo8ZilyqBdoyg7F6gZ35s62mK8pYumQMYVIGTJXuj5Ed/jM
 PGEZ2Pjg9LFJrvmQwgtrkNclmvlTQWuWoZ9mgu799nqPx3KxIy0NmCQG7iF1W+h/2YwKKeXBx24
 idh4KUAq2h4yw8L4XMNGwKRz20C95CAjj5hwi
X-Google-Smtp-Source: AGHT+IFAnWxMJPRJxeCqSPcNXzKttmyIo/hxKdhWVvFtL09cmOIBoivMAXNOgTshJCs+453vRvYAjQ==
X-Received: by 2002:adf:b60b:0:b0:3a6:d7ec:c701 with SMTP id
 ffacd0b85a97d-3a8ffcc9eccmr11495743f8f.30.1751381020816; 
 Tue, 01 Jul 2025 07:43:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7386sm13321652f8f.20.2025.07.01.07.43.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 38/68] accel/system: Document
 cpu_synchronize_state_post_init/reset()
Date: Tue,  1 Jul 2025 16:39:46 +0200
Message-ID: <20250701144017.43487-39-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h | 8 ++++++++
 include/system/hw_accel.h  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 6f9aebbee8f..14113bb5c10 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -43,6 +43,14 @@ struct AccelOpsClass {
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
+    /**
+     * synchronize_post_reset:
+     * synchronize_post_init:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers to the hardware accelerator
+     * (QEMU is the reference).
+     */
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
     /**
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 574c9738408..fa9228d5d2d 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -28,6 +28,14 @@
 void cpu_synchronize_state(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+/**
+ * cpu_synchronize_post_reset:
+ * cpu_synchronize_post_init:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers to the hardware accelerator
+ * (QEMU is the reference).
+ */
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
-- 
2.49.0


