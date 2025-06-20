Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883E1C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfMi-0004cC-2p; Fri, 20 Jun 2025 13:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLL-0002HT-Cn
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLJ-0004ag-SC
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so15755545e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439756; x=1751044556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/XNfWiSbWGdYBzuDNRVlb7gdtXynRKks1ss0p+cqNk=;
 b=FimvPl6M829GfveQCYaJCnTwEka9HJ2tPwj/ZtDuS5+VGSSYHrxoChOye/U69d85AQ
 0i2yWUZUYS9VztX9N+eI5uOIHTNZDRryoJGvMlYODbCHnvdsqFVinf2wANp6ZmstfW9R
 parehNuE7+pfFIpCpD/wz/7lPSMUM1jW8ZkxcujQT1Ujh/zhB9Dw1QF/Uh5aUdddIlga
 zO5Bds791XbpzjXUuR/kTwI/8PqcsdOTe1hBHmoEIs8XhI9upDaQpQEWljSO/C5O68rx
 1c2KzCCS5Jm1BbopPHrX/tE2/xjoTJ0/D7sHgAMWOoG1DEkG2T63fNEEyvPk86B3zS9x
 CAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439756; x=1751044556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/XNfWiSbWGdYBzuDNRVlb7gdtXynRKks1ss0p+cqNk=;
 b=bXatlEAmg2I7boHLu5rjqvvQKsao99w7sOSuIBuvug/EdM4wzPi7IUQx1+gbGUrf/7
 jm6lml4LrhSN1ZJ7RK9jVXv3XoyifvoBC/C/Zx2hVIDzNJUy/3Hw1qrErr1F2jZsdoOC
 Tpn7DmUlU/BUnSHb0F68D/edHyoDhKpx1lrekypGUbU6Rg0lAeVT63E6F4sf/9z4poWJ
 d+eqYpkDuPUlr/QNxbEUmGxpIHStNHbLrpeSMbJfdWMhwvInJxvuWxUEnH5yp3FTorae
 wiilW61FFYICguefUDukEE3ZG31Z7GYnq3zWIT37Ox+hEdhEXS3QruEt/svdRRtfqEEO
 K8jg==
X-Gm-Message-State: AOJu0Yzgj/5CcaFBLwL1iZ85nYpdNwHEdUr+8L3aZ+bGSzJ9tE50Q2mq
 EVO9I1mvVq8Ue+esv5GcODVh4qjR+QzhMTQacOTRF6prBZR1xkkDIAGc+aVZpdFJrYize1I5QQS
 5g8UdFuA=
X-Gm-Gg: ASbGncvbmsdaRQZVRRQPDxHhyJhFAFUxGX4R48kdNVciZMyF3Y7a6ZzwvB0W9H7OC75
 X7ZIsvDUmCDGJYsiJUWErmobu6TOC96Sr5d8s4GoWfhpMZ11BnhBnnhS6gv48L3kuSgeguuqMnO
 vB9YqDefKS84E+guzopbu59KFtdbNPAVW6tvZat+3OBGqHvTtj/okv8q/IAO07kgEi9o0G9LCQa
 DIDL+9/q5akS+zIERscjxN7BKOPi/tXQDrOpuD26b6U+V1fp5s9fAYuaFOrGBPHh3LNzITA8VTd
 zY5XjOvfexaL4tTQ09EZXjcAHgh2ztQi55DGpzN6nKNa79Bknw7QUgm4H8wER/PZjnEw2L6fjM0
 eu/uzNLckMH888lCyp0IH20wGYn5ZVIJLDG7g
X-Google-Smtp-Source: AGHT+IFqTDFU0GFlbnDKdZz9ByBEWlL5tE+h96kZ5Cdpf8wDUVYMCGy3BnwXmGHu7siEzuvDUyeJvQ==
X-Received: by 2002:a05:600c:4754:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-453656baaadmr32312825e9.32.1750439756086; 
 Fri, 20 Jun 2025 10:15:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb692sm31618745e9.2.2025.06.20.10.15.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:55 -0700 (PDT)
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
Subject: [RFC PATCH v2 27/48] accel/dummy: Factor dummy_thread_precreate() out
Date: Fri, 20 Jun 2025 19:13:20 +0200
Message-ID: <20250620171342.92678-28-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
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

Initialize the semaphore before creating the thread,
factor out as dummy_thread_precreate().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/cpus.h |  1 +
 accel/dummy-cpus.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/system/cpus.h b/include/system/cpus.h
index 3226c765d01..bfaa339dd73 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -8,6 +8,7 @@ void cpus_register_accel(const AccelOpsClass *i);
 const AccelOpsClass *cpus_get_accel(void);
 
 /* accel/dummy-cpus.c */
+void dummy_thread_precreate(CPUState *cpu);
 
 /* Create a dummy vcpu for AccelOpsClass->create_vcpu_thread */
 void dummy_start_vcpu_thread(CPUState *);
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 867276144fa..7c34e6c0fc5 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -64,15 +64,21 @@ static void *dummy_cpu_thread_fn(void *arg)
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


