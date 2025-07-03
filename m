Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1905C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHij-00053X-W4; Thu, 03 Jul 2025 07:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfn-0006qY-8q
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHff-0003aC-89
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:06 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so6516497f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540401; x=1752145201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MatxngaEO94wJIDihnh1PuQvEdZF8b672v9QuG9ABiI=;
 b=SIyXHrLuz7MeeClBR1nwAcqQiuU0k70kJDxv1nn2Rp9ncY3OSOKEazHTHEzfiG1B8b
 vwW3dGNFnySmjJ2LefskfkAdHqtInBgLbjzWJLpCT6CRw+LELyomwAtli8re09yRw44l
 xmMroA+CNuB0+VrFhHWfwv7vM7zd87tiqJwAqzEx+C92aXh88vQp8Qh0yP4Ym/29r4vV
 eJ5MTGnKBQQG5F2x14gNs1GyNLmU6gi4ekPt5YkV2GyCBVH2jSfF+jOLduD5wNy7iVCx
 YzgRUk2S5UjQ2ePerH2OhEp8t7IKXVkEanJTxy8RInO22xq4u1ajKUzTXKggl4gxd1jQ
 dwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540401; x=1752145201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MatxngaEO94wJIDihnh1PuQvEdZF8b672v9QuG9ABiI=;
 b=UHpdrrjuaOQkH9NJSz58XoPsSu7Eq8is2uf3ymBEVgFo967tqKqiQpRBvxBH6QoFgj
 7ZxVl2wpf4CzVab5SJd/qDLNe7XjSnP3WywHRmqtxFxSNosWbYbYxYmlF08sAVbMh9Zs
 rf6kVsl/74AvvPRHdbMX9j49BFgzjpg35nUt2v/K48r/583IBoccepwvU7sQ5yywyO72
 T5rRB1ESISEIRVRhOrT8S5EzTAYuNLBWiZF5KfuNuoB5b/wpJsVOBbpBVkGHM/7oIx2W
 E2uN8sNSO+GSkoDdUPTuWFmVpa3SPPx2oWYVa8EwKvQANb3SZ1AyRsIypqjAnUW98X4o
 yR5w==
X-Gm-Message-State: AOJu0YyoZK+Mlnf2l8vfFAHpkjrhklbNtuuNJCn0sAuOEK8BuDF8izHU
 N0K+fXl8qTZtpAzHJhNj81xeiIn4pjIhB6Tb9N2/fDAooSJwsuFFNKN4uepKnIC+bNu3jBhf3QO
 iSCqYyb8=
X-Gm-Gg: ASbGncs88TgswV/8P8MGd21/TZXshr6XRRdv/UGgZbM/iKNIP2cd8K4y6lK+DoJuEKb
 5TITMgjJhPMWElhzlkkYJPc/7/m4cy1ZFwOUyRMA+lxNHnMb+pnMZ8nla5SbXM29e4AxX1qGiBe
 UFJ2YF/BKXhsOcebm5nvCuwmFcHdKe105S/VSIEJNQA5V0fxKjd/1wemQwZ68zXLat8oRqumx5h
 y5nSi4KS5IyZ+v8wyfx4cPZddsJS4B4N0U8WnoM7F6LthZMMX2lY6y3oGj63JIH02Q8Su8bDAQx
 /JVD2YFGwLZTcBDTOT1Npgy0gGTTtghLszeBIAJRIqllUOclzJSF3csszX2A6c0j5UNtW0RO7lr
 rQj2stTrCPxI=
X-Google-Smtp-Source: AGHT+IEb87tlXA/8eGOwxvjDb6DUjurmHoTXreDjZy8v6I2Ff8ndoUXgQehkRndFFAluWuvIfQDt3A==
X-Received: by 2002:a05:6000:2481:b0:3a4:fc3f:b7fd with SMTP id
 ffacd0b85a97d-3b1fe2de84dmr4668675f8f.19.1751540401208; 
 Thu, 03 Jul 2025 04:00:01 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e61f48sm18613334f8f.93.2025.07.03.04.00.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 49/69] accel/dummy: Factor dummy_thread_precreate() out
Date: Thu,  3 Jul 2025 12:55:15 +0200
Message-ID: <20250703105540.67664-50-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Initialize the semaphore before creating the thread,
factor out as dummy_thread_precreate().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/dummy-cpus.h |  1 +
 accel/dummy-cpus.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/accel/dummy-cpus.h b/accel/dummy-cpus.h
index d18dd0fdc51..c3af710ee8c 100644
--- a/accel/dummy-cpus.h
+++ b/accel/dummy-cpus.h
@@ -9,6 +9,7 @@
 #ifndef ACCEL_DUMMY_CPUS_H
 #define ACCEL_DUMMY_CPUS_H
 
+void dummy_thread_precreate(CPUState *cpu);
 void dummy_start_vcpu_thread(CPUState *cpu);
 
 #endif
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 03cfc0fa01e..2cbc3fecc93 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -65,15 +65,21 @@ static void *dummy_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+void dummy_thread_precreate(CPUState *cpu)
+{
+#ifdef _WIN32
+    qemu_sem_init(&cpu->sem, 0);
+#endif
+}
+
 void dummy_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
+    dummy_thread_precreate(cpu);
+
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, dummy_cpu_thread_fn, cpu,
                        QEMU_THREAD_JOINABLE);
-#ifdef _WIN32
-    qemu_sem_init(&cpu->sem, 0);
-#endif
 }
-- 
2.49.0


