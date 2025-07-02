Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F37C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2gG-0006On-9l; Wed, 02 Jul 2025 14:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fk-00064a-JT
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fe-00032A-HK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so28787175e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482736; x=1752087536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MatxngaEO94wJIDihnh1PuQvEdZF8b672v9QuG9ABiI=;
 b=BDukuU1g0YRXMjA/61Vgcf4Hoh/kz26+T3WASyeNi7B5Ta63Q5W8HWESq61WCx6y12
 xrO4x2gDww+b7H4Ql+41CyeUCQsoaPbl8M1eISGE8jEI8t7dgO0AzRmXQfnnc2HtLcoH
 DRkCjoUflFLC++canHBUgEumwwqa5nhGh1MU8mQHG1W9UYmfjYkJpPCV0WGFxYXHWjFQ
 /Gd65aMse1wgf5/andPW92DLgAmJuG3+r6/xwpVWjISu7D5OICsmy9vO8yJ0BJbeBEAZ
 vl04SJbNvIqsREUpXMvCTNb0JkolalPtSn5TBtbu0UIUiqzdKcY6hLZk/nVX+9wTDZS6
 f8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482736; x=1752087536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MatxngaEO94wJIDihnh1PuQvEdZF8b672v9QuG9ABiI=;
 b=VWrCqldMCPAn5X+WLROfw8M0aGxMepGdlcRto2/PU5Dz3D80FX+Ts+DbvBmZVHPa1j
 yE9GLuM914A9OvYFFQRRbD+MQm+RYrBmHSsGZ6H9bSNgnX3K1sLGDRWbp8ttNKRtGJcf
 tSPN9mhfWs1gq/3oogR3EIuMtZ2QL0i5GOZoR7m3FraAyOnLFbbHljlq/hVo/stvabXy
 euWPC2KX2/ei8NylS+mCnkyDEHj5uLjNoCV6S6aNH/MHNVN4cxQ36NqyrF/454jxOLu7
 6k4IrKe6ePVwxUw6bcibCI+Z42DYgppgulBpQbuJcy8vefzpgABR9iJJPVFsxavil577
 AM/A==
X-Gm-Message-State: AOJu0YyHF4yIBbaWa3MhSkzRVTDWOSKh+IGgsyhOt/f55dSN3EQvd+DU
 P/G/oE3Bj8WXxsaNQyNwYGlBX5WW4KEy+Gqi/L8gjs9VckVdSEPyZQ8V+1v/WvoErKaeFOO4KsH
 7XQig
X-Gm-Gg: ASbGncutP1CZJ3mEjQeUXYP96AzqfJehZXJ1b5xjuXQUQX9Izv9XafjYCizC4gZWgdf
 Su5aa09trMibj37FHqqvtQrJRC+VxyTlICMpOJPg4eErxbt7aDq//q00MVAyopRil/EFOuir46Y
 6OYEc/k3QLLdRs9Nbm6OEChXwN5ZHLEoqdSgmsHMmqF1TUpwiAeCj0PEpYdq+TetV4L7DvpyDdC
 RJ+X1U5EJatWrtHoPcI9y/c8zdiaEaWo2sC2GjGFzZFFTceJljvktaYwrLKd4/6UxQ0ArjOzlnC
 n3eVOUGNgAlix8+N7Qlwq7r6a7XR3+AqpPqUwVtT1Dxb6F9L8FIFAckS4QLmDuGY6GCc+ZtZcl8
 rknx6BGo3jBHzU/MMutGhR+OVhS5nt3VN59Sp
X-Google-Smtp-Source: AGHT+IE2opsjASThgBn9ycPzNSz+DYIPc4j/4/1A5mDuAdK7SodASRJzG/8N0aRFLv57JeLoLi4vKw==
X-Received: by 2002:a05:600c:4751:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-454a9c7072fmr8183905e9.8.1751482736042; 
 Wed, 02 Jul 2025 11:58:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a98e942esm6338975e9.0.2025.07.02.11.58.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:58:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 44/65] accel/dummy: Factor dummy_thread_precreate() out
Date: Wed,  2 Jul 2025 20:53:06 +0200
Message-ID: <20250702185332.43650-45-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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


