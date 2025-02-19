Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBE6C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 15:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklYo-0004TG-FB; Wed, 19 Feb 2025 10:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tklYf-0004OL-CD
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:00:18 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tklYb-000134-S0
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:00:16 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e0573a84fcso5843594a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 07:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739977211; x=1740582011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMpR8AXA7xfQaFhSLKNadFqD4qPYuFkWfolZ2f9L0LI=;
 b=UNywPUUSqCkwVTQIWlDytUjljJ2vIFnA0xe4BTw6cxd+XYVfmUIq6YwxOtzavGDucU
 DlaTwtFUN7/t7yJpvbQP/DCta537ZyyzbRtjpzsaIroxNGoSLOSKd0guQAgZF6BEYzr0
 /xf8gFzbhsi59soST4b42kGFskHuGcRwUCGyzvWCMIQIif413Wh65bBMMcQIDYnjtjGV
 m4tRXaYF4Q/q5UT++uk8QpZ7U6H/3X1Aw64Dc3du3cE0Uu1ktt7Ek39POYVZOrr+NAeF
 vlnMKv89+Obm/DCek1EAIOHFuyNRqP6soJGeVD1WmpB3RQ3U5AFsX+86JvADdWhLFq6H
 alpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739977211; x=1740582011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMpR8AXA7xfQaFhSLKNadFqD4qPYuFkWfolZ2f9L0LI=;
 b=BJIJ8unKcK4iF33YGejH5HEAwSde/mT8jnVoJ2WwPrkVWp4QeVhVwJg1g7ZudmBYa5
 ogSP2Gd8SM3iyf7nZBwV7I7GU0Pb16JY2U/O6LXJEMZWEqwA6cQaLJTGdXd4pTYHBY8z
 ZGn1Q2ad3+ZEEvj6G9th7why1YuJAfDgdbtSoPFB0RPqzcvs3cTfcklgpzcXyfnHylW/
 axcpjS66UddcqpnHdlM+1haS3KbUjOoBCTSG8LA5PFL40vIMCLQs+HP4Ni6AC4BHaI52
 kCMie5GdhPWl2hV47drAkdqckxZIk+OBFmaRwyqzz9T9j6Q4gewYlhQ0YCJzArt063NT
 siHA==
X-Gm-Message-State: AOJu0YwhYRLQWRAI3/Ebh6dPmS9b+SDFaAyJNDbR6TcDU4N9imTqB32r
 8S+HdNHI2jGvuqd9V+RGhhXOX/Af/twMJAMAcNPNpDu1ftREN3/2h2bLqSuWVvg=
X-Gm-Gg: ASbGncthUYM8aBE33U8yiR/4c1Xw7mgW1edbEFKjF/eLqEM5stzTWG0VwQh496YTlT4
 xsCZ3xioU+QfEH38+mwkexu4advh9YCTuZIGwRrhflrsJJKMA9K6UhWTJdYSkYSMyChkhUP4dMh
 caKh31C5pw0A4JogmlBe9oJtF3J7XqMnOWk8kMBM9JRmQnwz9wrOTWgLjEduH15x30xIhAJwW5j
 5AuFA/xn1Sa6BLg2CjoYXp/oni8W2t9gXJSwB+S1CmJ8rG2KK5XjMy77Z2p8kJMhVghAS0miCB4
 XQT8z1nqD8I1uc610A==
X-Google-Smtp-Source: AGHT+IFndkPE54WvwrVqpb6/WEB14JuiqcZTjRNleOGsUkPLJW3q1epdL/G7oLqOOV364qUyPWbVkA==
X-Received: by 2002:a17:907:7842:b0:ab7:cfe7:116f with SMTP id
 a640c23a62f3a-abb70d96544mr1839915166b.46.1739977211081; 
 Wed, 19 Feb 2025 07:00:11 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb72b519c5sm904303866b.173.2025.02.19.07.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 07:00:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61E84619C2;
 Wed, 19 Feb 2025 15:00:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] tests/functional: ensure we have a GPU device for tests
Date: Wed, 19 Feb 2025 15:00:08 +0000
Message-Id: <20250219150009.1662688-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219150009.1662688-1-alex.bennee@linaro.org>
References: <20250219150009.1662688-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

It's possible to build QEMU without support for the GL enabled GPU
devices and we can catch that earlier with an explicit check.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 06093c6b60..c9463d7285 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -91,6 +91,9 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
 
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
         gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on"
         weston_cmd = "vkmark -b:duration=1.0"
         weston_pattern = "vkmark Score"
-- 
2.39.5


