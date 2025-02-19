Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86018C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 15:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklYv-0004XQ-54; Wed, 19 Feb 2025 10:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tklYg-0004PH-Po
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:00:20 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tklYc-00013l-E9
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:00:18 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso1028755166b.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739977213; x=1740582013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poeknxWi50g64JDj5A78TCHXdGRSIYJF5+UH+RyZNs4=;
 b=DQLm1A1b0P/WmzEQ9fhNRs4u7yf1vLOB7EhJlwVGOnHmvoN+qmRU8+H8867nRPm0CV
 MQyOwRkrhwXVYDfX0pt4k/CnkPOKx+bmRb7aDdNLsb7R+Al7W/5cXVFFt+sCLMFxymuS
 E6EScUh00YkHPA7ppagaup67mnTepcCBiVjH9QVUFXOgikorpLEGs5K9yqxxkVKJLOus
 aBdMbbE4wCZlg1gjoEPFatesT65GUaKm6y6l51ilnWI5ErRR7QAP2TIDs7C81m/OgnXM
 sCd9ENuCLr949JSBgakLjbxhuTMmtcdSIyjdeeZYUeDGHP83TR27ygITc12AkeO096VJ
 jPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739977213; x=1740582013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poeknxWi50g64JDj5A78TCHXdGRSIYJF5+UH+RyZNs4=;
 b=bkWDtikAVfvgAarsC3rn9/x6+/4g8+Lsyuj8kTXAszrwaqfZZa6hDP6IUSnvWZHlY9
 i/Wz3eMlazwB0+1vXFgsDpKiAKSgo4HctG0pC1jKubbmxboDZ1vY/tRaPoUkJMfUm/fz
 uMjzmzaXiFDHtBlp6EHUq6IE5MQFqHlD/jG+xJCKJ+Ou3uzOsoztGIRTWyQNzIKqaGtw
 S8hxvZlOaUiq8Ni8aG8Uaj7pC1QMSdxvJVhaRX++PqmKPxFhGQpq+44wUSzhGQKtTXjR
 C4M8BQqKqp1EyM+2/8WGSmGKXE+NtvkdnLVRUatjEfAchl5rb3HfmnTiCtDsKEL6HWKD
 EZJQ==
X-Gm-Message-State: AOJu0YwWtSs4bT4K5bg9CnJ3WGf5HO+pCOwbePN1cIxrhYFVz705vtNb
 Zqhpj/TJXU9BKEto1ALVy/WkqW9zj4Xusqe2b4Nt+puldStIW8tHtqtZyz5V2viQoTn4eGwoLq7
 VouQ=
X-Gm-Gg: ASbGnctwtlkMgGiD/eG6TUSWxWyMDWx4eIkirMSSZg0Dh2W9lNe6bZIJH/8ub4LRN8P
 pKevKD0HEguNhFVrRs2H0Qz1/pmVRqaY8rCmjdlEl+fAvdKICJUFECuAr9L2oLhw+yHSjYsieh/
 BzLvmOVwQe/PouBC9KgErTjO7u3HxPTOhK0EAGTXER5QjuLd4m0rv118NWwHJkzFCg4nh8CYCZc
 N+QgXPbQ8z1ZkDiW/KN8kxxF5cV+yXB8EOXxdgzy21iVXxg0NPvI6iUwK4795IYLBscuxZMY7bB
 begU4TcprN7haIifgQ==
X-Google-Smtp-Source: AGHT+IEbTW/LckbUhR2a1qrKFxTB42wG0pp1HKBb1VTi8lkagUCiOMQSDEKltfYxtPjCgeaEjX3rLw==
X-Received: by 2002:a17:907:9709:b0:ab7:d87f:665b with SMTP id
 a640c23a62f3a-abb70de2845mr1743803266b.48.1739977212695; 
 Wed, 19 Feb 2025 07:00:12 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb7e29be33sm843467366b.94.2025.02.19.07.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 07:00:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 76844619C8;
 Wed, 19 Feb 2025 15:00:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] tests/functional: expand tests to cover virgl
Date: Wed, 19 Feb 2025 15:00:09 +0000
Message-Id: <20250219150009.1662688-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219150009.1662688-1-alex.bennee@linaro.org>
References: <20250219150009.1662688-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Add two more test modes using glmark2-wayland to exercise the OpenGL
pass-through modes with virgl. Virgl can run with or without the
hostmem blob support.

We might want to eventually add more directed tests and individual
features later on but the glmark/vkmark tests are a good general
smoke test for accelerated 3D.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index c9463d7285..7a8471d1ca 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -89,6 +89,26 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
         full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {weston_cmd}"
         exec_command_and_wait_for_pattern(self, full_cmd, weston_pattern)
 
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_virgl_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
+        gpu_device = "virtio-gpu-gl-pci"
+        weston_cmd = "glmark2-wayland -b:duration=1.0"
+        weston_pattern = "glmark2 Score"
+        self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_virgl_blobs_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
+        gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on"
+        weston_cmd = "glmark2-wayland -b:duration=1.0"
+        weston_pattern = "glmark2 Score"
+        self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
+
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
 
-- 
2.39.5


