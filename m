Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E37C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaDh-0007cR-IJ; Fri, 06 Jun 2025 12:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaDA-0006h2-RH
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaD9-0003TS-5L
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so28320925e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228389; x=1749833189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW26fCg8e+Q3GYcnecMlFtDKq9fMUnTMjzlwEj1wdjA=;
 b=sTaNhiP1t1wyZwI4e6Yz+dcEyAkc+6pDsug32zFhoFKCnoWOmBwv2AqFVGZBYPsQKc
 VZUrXu/Nmk4Zhyk0ee9lzTlH70QoUozEOhafY25mD7MO44bga2Hgw/qSp4hnMVSGgBcz
 je99eEv5eQG8UlYFrSau2o8Ht7VefXRVypF3Qt03BO8kUyrICv6soud57Tuj/BADWYH/
 VikAAjDv4ksSeJ3S8yh0AjHvJ6QQRelM/ZyHWpGKZqJOSDJ3n/kUHdujdzgq+wkUfOln
 Gb7cD1/oSMuIwIZnGiw6cKMS6rBtuyKguBipHRYBql17a8HMM15SA4JoFwW7kJl/ZZYa
 fW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228389; x=1749833189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eW26fCg8e+Q3GYcnecMlFtDKq9fMUnTMjzlwEj1wdjA=;
 b=t7VnXefRIRsL/Ixhy13FTdi8Y8b8vgBXqjO9mLrAI/sRaMs7CRcfuIvqmoZ58m64/Z
 MTpSxTxqjRO4J6Q7R2+p1QXgrXJ/Cp435j1UIypxktyeq7E8aKfNez9sxvg8R+pDPQKX
 ePNHKKPhlAlBxshnBI1uVDJ+5npjRLUi63ddN6qwVatJJkkbiPrW1n92xEM62ZBKJC1w
 BiXAuNJtAbdD4v7OIp3AFsqw3jbEr+OkXolOZjKCICDP1iBN/0nVXWZVRL7dB5seqFcZ
 z5gsJES1HQqf2u/6ldtTKcQNrDBAm9LxzA0wdCnosJCWCKc9wujtdv6qEmncCMsQT04b
 2Rwg==
X-Gm-Message-State: AOJu0YzMCTSUk/zrDQIh2bKN1tFkQ0UT4l0v1m9Qc9z65Cogkm15LyRa
 Ykb8TbAoegeAaILIsDqxx/F4CLinzSUHS6TwRUL9eW26WitJgTzKNAfP3hBVkCj87yd+7yvF/Jb
 p+8a+CuzlnQ==
X-Gm-Gg: ASbGncsptRgS4wKq8bIIjzuMNfMaqnci0/BST0+MeNWgcZFENV3zn56nrCS6Llw+6H7
 aq1YACPCRWTw0rQ7TOSq1YCSAmVFTOxsyzpID8Z7yq+emPJjt+oLNkHKHicnLGEtfKUK/yte9Cd
 vSiYvDQL/LsOCP474Yhw+clXiWQrvb6La2FOvimuR1BHUKxWf2DVj2iPV4o+gsbOj2qwof/mRA9
 1vPFfp9LFr062Xabb+Scm9073sSe1fcmcylp/706pNOgA9gxdiBvNQRlMig7OqVU0X9rQCsSSW6
 VrsiwoJbTTr+RzTIKEUjlsbhgOtUXycVDkHlflN7KGpihsAsYh6SmlOiLrrFNeg4fIwkuIgdRf1
 D1D3o2XeB4nCUNM+BUpwLGTGwSX1bllDlVZpvzQ==
X-Google-Smtp-Source: AGHT+IF1Xyh5ySTeGryGVO8X6wrK5tj6OGPjTAzvu3QggZoLJOffrJgC6E+IBq3/p1Y7rNQVqnfLdw==
X-Received: by 2002:a05:600c:6209:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-4520141a7f4mr37452095e9.28.1749228389139; 
 Fri, 06 Jun 2025 09:46:29 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730c66a1sm26841725e9.27.2025.06.06.09.46.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:46:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 17/19] accel/kvm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri,  6 Jun 2025 18:44:16 +0200
Message-ID: <20250606164418.98655-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
 accel/kvm/kvm-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index e5c15449aa6..39334997fb1 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -63,16 +63,6 @@ static void *kvm_vcpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void kvm_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, kvm_vcpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
 {
     return !kvm_halt_in_kernel();
@@ -94,7 +84,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = kvm_start_vcpu_thread;
+    ops->cpu_thread_routine = kvm_vcpu_thread_fn;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->cpus_are_resettable = kvm_cpus_are_resettable;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
-- 
2.49.0


