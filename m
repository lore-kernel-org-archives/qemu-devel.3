Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603EBC7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfMj-0004qp-KJ; Fri, 20 Jun 2025 13:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLz-0003Y8-SA
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLx-0004gB-Oi
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so17094225e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439796; x=1751044596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bscCZhJPor6p9xOGYxKsyHkSJQbAuOk7LsWMwFm7sCY=;
 b=NRNZLHw4/c3rizi8krRI6YzQwaFqPBbZZWLKCp2aHXE675QRht6WGMVkShK6W9+VkJ
 mqoh0HOrprJuPbObSySYzPSf2xFStyzTTjjLJXxRWNiN2svgoy0Xr30XSCPBzG6nK5Af
 nFuCtFhuxlwpMMKY7YLzHjBsGH/daPDvnViCLDcwtpAK810vtngW/79mSDyImiKuqCkc
 9ChPNQbZ+nwr5Y360VrbxDyU4nhS71oogF5LqblOLvPWbwa7v71Xkuh1r+5rNd9MLMl8
 DTBqDEmqc3t7AbHa+8VwIqLlnCHP+Tyheiw2d0CVyJiBFBDjuwjmAWYJAC/C9z3Zi+n3
 V+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439796; x=1751044596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bscCZhJPor6p9xOGYxKsyHkSJQbAuOk7LsWMwFm7sCY=;
 b=RmMrLMJhXQNRhFLyHnr0Zraz8KDHd5lppf78IVd84zZ5JqI/+cZarDOQ4127VucasS
 GyBfbjU8ehs9hrHFsO3yuvGi3JU1GRCsyykzG2IFKUwkvTAR+6U/ECZAdKXAQ4AGldcb
 qbL10mHpTNnMefXVRYXPs/B475KAKlTjeXRM5ejlbZ4FH8F8zFV/nFYPYjGmF0Y0BQvA
 cgkZ05jNCD2zDNOVnim6hjDY9PYVGrVQ4Ry1VuDxmNHGdoTrxI2paNnWP8KdRKjAXayA
 cmky4OHzcEYMAK1gVYFB76PcZk1fyyJY7/K5NbH795IQKBHRksn2M5inf3izUdh8L7h2
 DkTA==
X-Gm-Message-State: AOJu0Yw+PjfLOKXfFRnMofUCI8aCxs2wtuSq1Fs142APa5EWOqqsj1s2
 P3jIqywJ0RnUtvGUM9svFCaZKruuwvbz3R5iKTtVRNbA++3DKN3xcuAyUlZ9dXDAKICQpxPfkPS
 DEXxP4s8=
X-Gm-Gg: ASbGncsLQcXhTiwHibmtueq0tQLVfLQ8lHtdHpjlaDTi0J3hKR/N0ALBXWfxr0dz72k
 bM14poJg5UZwfLnU31c7S1ffX4Ala3b4ZbonXW8PR5RbXaNA7+PtjuUs9dvX1mGHll/jsdb20OI
 soBMJ5TBoZysbMasdxD+j6/1Niq79IbPMyBToRK4z2DE8saviDsk6ddVinBEgLRt9B55yzeYDYI
 50tX3lK9KO9ol3e8C1xw1yD6ougfMJttZHsgynQNTioc8YUVO3xVC3Dkn9CiTXH2WyXj2qrhgK8
 PQGDa0ragOcNCl2b6z4ej9ATw+zR9T9xHNseUEvcO0QrHZ8Fdw/IKJcES3gY9k818E8CcZTZi49
 6wi3RLpDWJuKr0j+e7qnilG9AOSMRxGOdSAQOCK/oi74+TA4=
X-Google-Smtp-Source: AGHT+IHW4TOzsOZCNJMNEx4Adz4KtLDndz5p9iwamV7rd0SQLzyTQ42FpsKAxmdD8EwMt9JSqP2KwQ==
X-Received: by 2002:a05:600c:3115:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-453654cbfdbmr39329235e9.10.1750439795791; 
 Fri, 20 Jun 2025 10:16:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646d14ddsm30933445e9.10.2025.06.20.10.16.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 35/48] accel/nvmm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri, 20 Jun 2025 19:13:28 +0200
Message-ID: <20250620171342.92678-36-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 target/i386/nvmm/nvmm-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 21443078b72..bef6f61b776 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -61,16 +61,6 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void nvmm_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 /*
  * Abort the call to run the virtual processor by another thread, and to
  * return the control to that thread.
@@ -85,7 +75,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = nvmm_start_vcpu_thread;
+    ops->cpu_thread_routine = qemu_nvmm_cpu_thread_fn;
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
 
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
-- 
2.49.0


