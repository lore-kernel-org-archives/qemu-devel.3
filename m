Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E717FC61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaDd-00078t-RI; Fri, 06 Jun 2025 12:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaD2-0006PG-Hh
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaD0-0003T8-V6
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so16131195e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228381; x=1749833181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbtuoNgudglhJLlyI30gSCpvbQM9+V/yqMDBe9lx7qs=;
 b=hVuujyKdyyIAP6ytRfpgU3VDmYoxca4MIxiAMEqr1ka+iOnzItZhU+jA1hNWN8wIU4
 B+FCqdIYWKddSsHYTEqQL8HfEwxZwXdutfwMgOq7fZS4HFshYBXx/GcP5ZdzzOEBODkp
 KtZAhZL1iIHGmSn9abOsmcY5I58vW8Vci3suvjyeeTBn48BLy8jy3VfwjIN3yD6QbOIJ
 t5npfDard+QjYSbJ76Uqn8INmr0IF7i2dgZIF8lbC7CuakgpDSq6J0jVkulz/ddih0hy
 3KaJ95gaKZZhYm6POBK/+RKCAgwJQIWS4m9YbfolhHjlux8GWXJ8Q+C5T1yQGuPbYfBL
 ebtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228381; x=1749833181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbtuoNgudglhJLlyI30gSCpvbQM9+V/yqMDBe9lx7qs=;
 b=VGKWk/Vo4qYWKu63o5MqBLKvM2Ym6AI2Fevv4Xb0Ixr9lVhE+CkgTlnGdJvsQlhMn/
 +VJS/VBjSw1yOJgvFTIAJbqzUL6kCoLc9szaSLNuSeY0HlKPx2jLj7Gc7OOpDS2s2k2V
 CD2x3QMsUV5yYwgzzIBO56WF2YMBVELJd09r3KcF742J+KnJlV6+QZUebQMVPVEmx6a9
 e2DdjwLkZcnjtnOymXQbG23n4CjbzZl1CBM1OkEdHiPjscnvlo00ZtTji4Tnz+k1iqDH
 dnjChvMHPJysLB7uxP1VHf0V2ar6cYw352gZQRCu6UCyxeLy1p8brB8TNGrZKPTIbsHk
 wRsg==
X-Gm-Message-State: AOJu0YyIoaTX7BerTat95gsrk3L0teTyULM0Z9ysr2bUt4J8NyzqEg8M
 80XrqllCekJzlnzkjRXlW3BsXFvgyEwXsCm1oNIP/y7d7rGHMDAUhwPF7h5hvTOJAQ4Z4FtMuG1
 GUm1vvbiZYw==
X-Gm-Gg: ASbGncsMNv4Ylz8zfdPyXcOuKU4kZORh5VvVlayjHizgcxHRCSYdejj3X2UeXshefsb
 AljeTemZu9A4m7RVRnUadfbCcGD9JThpjfHB0AxJQXKjqKj+JjqhrlVMuMvWamJk0lB49jZauph
 KOVYHIaTMqZzcvRked/PdaLdABdZJfnd8R85DwwFZlzIfHOUc9V9MwxnxmM/B+rtPfiNgREgE0Y
 NYbe7bnYUlbhLrNnufft52QFdG5Gl1tMo1xC3b+L9QgNmSAk9MjBep3bLxI070rkOjjwlfcnQG0
 0pQdo0Z/DUjK7U7bSslPhQ66hasKITDVpKY/ziNjmRQZBCiIuCxV6CxWbcDmZjByWwqim5Ph7w7
 3Y0o9s9ziH5zgW+LWEuP8HTAm5PY1WN8EhBCJdw6y2hpG1GMh
X-Google-Smtp-Source: AGHT+IEX0vp0R6AZjVX0jvBAykDp95VYAjSi/tS+ematIm1d+CVc6TcqdSLJHPOWKplR01lEw3YgYw==
X-Received: by 2002:a05:600c:8b11:b0:450:c210:a01b with SMTP id
 5b1f17b1804b1-4520136993amr46814795e9.17.1749228381060; 
 Fri, 06 Jun 2025 09:46:21 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464e7fsm2341760f8f.96.2025.06.06.09.46.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:46:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 16/19] accel/hvf: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri,  6 Jun 2025 18:44:15 +0200
Message-ID: <20250606164418.98655-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index f4a983d1328..d9b533820c5 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -458,22 +458,6 @@ static void *hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void hvf_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    /*
-     * HVF currently does not support TCG, and only runs in
-     * unrestricted-guest mode.
-     */
-    assert(hvf_enabled());
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
@@ -580,7 +564,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = hvf_start_vcpu_thread;
+    ops->cpu_thread_routine = hvf_cpu_thread_fn,
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
-- 
2.49.0


