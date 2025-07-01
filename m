Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE59C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDc-0003NR-Du; Tue, 01 Jul 2025 10:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDZ-0003JF-B7
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDU-00078S-US
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453608ed113so34698655e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381051; x=1751985851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MatxngaEO94wJIDihnh1PuQvEdZF8b672v9QuG9ABiI=;
 b=gQzvLSNWxtcLY3vBvXA/FkBVfiLBKOifgpOduJXSX1kIVh3PWDzwile1g9tTmI2kXZ
 dQ8bwx7egV18z2z1wLnQxCWxWDIe33c7h8nrod+TS21ZDwPdPje822WpsOUByv+h4YEc
 w0DOOGNJ0Wwtp0on2ouQHwbvSYRUfGUXvZPiu9oinRfg4mn5qQnDSMwKiXAJDwrYHYC8
 g5pvSAkqBrZQTht3g+m3YwFVfciAreuuqiT5ahyBp6N+25ZiT4xSVK0/Ezc62RZaV4My
 O1gWdzagXB/mVBmlekOws1xT2r9B6y5pu7E5AqY9QQMjIPjoDEJUX7/mepvYFFYJkk+7
 hwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381051; x=1751985851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MatxngaEO94wJIDihnh1PuQvEdZF8b672v9QuG9ABiI=;
 b=aAYkwaNheOKE3thQsCEbElQRvQexbcttZcqf02NYkkMLlyRatuFFWmZqvLjtpmr7sU
 dIV4McnuM60AAzPQVM5u5tjgOJ+Rkh0ZwAKDASYhUOMxxT+SGLIXGWNOapSc7ap+JWti
 Qot7XRz83MiQlvQO0ZlKxq4XbpC0IIASX1BEr6XvAYGLs9zvLr5qtK3VXnoQxQ2FuE5T
 HQM27tYWEvDonRnT3VTzJSsakifkGFwSckSL6vUOo9tnhy/bmFnkWMya83WrskDZEUx4
 lh9HPJBoUiIphTQj0Uco6Cjch0EKbiiibU8iMWJpKJwy3BC4RqJmtPnOEcRnt4PeQr0J
 hrVQ==
X-Gm-Message-State: AOJu0YwgsY4q4aQRhuRe0U8nVT15i8epANgODK7S831TjvNAxfJOPVQv
 CNUkqV0Ge5xlbCaUgCcvnQ7sU+NZOLXXb9w725rQQrfG7AqTxITQkfAFcvHRMFwrlaDbWjnbZkk
 b1iCh
X-Gm-Gg: ASbGncss9/TfPRsD5r9QwwM19N+3fzOlDE8n3YknbsLPnwyrQOn2yG8GXeb9xkqKa7K
 NEOCgZjgLSCXmRpKertdgx7iZfs1n00WJ6iL+neyNGDQ17zcJQtK9EiKUsTGTZl3z8aASD6WafS
 bk92iCtPR9mOad3D965ntOkFuFfdleBK9DBNibjWF2IljMRan3LJ4i9O6zahR9k9KOQPQQ2xixQ
 gX7ZGpOtQUnj5NxWl4wrBgwzhyJ7c/pChK60834NqHUuZz80mH0zqtJEufBUqs8R2RVKMq/i/qu
 +7hniKIflL0cT3NCoG5G8PN1vWA6as+m0jrBnkdwE0Fp1j8geSZspn6saKTNh7VOW60w+s8WWL7
 yLnKXrBaHnRQjU49PkGcPIWXMCsd3DpqhbfKr
X-Google-Smtp-Source: AGHT+IGw5rPHjpISVw26dEzltenFT4Cnsx6hYgdH9zQ3japwcN2nv7b5duxzpoQhqUahoNxExV9ZTA==
X-Received: by 2002:a05:600c:8712:b0:453:86cc:739c with SMTP id
 5b1f17b1804b1-4539188f383mr153768655e9.1.1751381050541; 
 Tue, 01 Jul 2025 07:44:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6d50sm200949905e9.30.2025.07.01.07.44.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 44/68] accel/dummy: Factor dummy_thread_precreate() out
Date: Tue,  1 Jul 2025 16:39:52 +0200
Message-ID: <20250701144017.43487-45-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


