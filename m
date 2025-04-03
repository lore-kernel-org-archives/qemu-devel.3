Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5DEC36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RF7-0003yT-1E; Thu, 03 Apr 2025 16:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RF6-0003yI-0n
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:32:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RF4-00042g-5u
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:32:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so8424185e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712368; x=1744317168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGswViVnnb77pop0AHAfmo4nHoQCnlrKr2lNkpeHI/g=;
 b=Y3FXd3MpOBD2xUC4hMS3N7an1JUPIjCdWo2arIB0xNseED/Ol3LGpUtt7UU7g1/ZLI
 LibpJWaBL1JgkqZdlNTn3iJLnTf7Yslmx4c39McWP0036evjcQEN6e+z/PKX1RF+9fAD
 5YjrGIDeYxQmIi3WXgaN/qFo7CKVBl9aaVy+Jd/17/lTArcpGsX7iZRSfQu2APEscz8q
 h9b76pSWA9arfJalshQLa3QvtwOorbKK/zWBfcWcAhLrgNSoQdmJt8AN7swGYeLsCr2o
 N0tTkdc668fgBV9a0Bb3p1KrTQN5u7a7ku1jgJajwnd73AoAPjpywxNt8P6apAz2Qwrl
 uFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712368; x=1744317168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGswViVnnb77pop0AHAfmo4nHoQCnlrKr2lNkpeHI/g=;
 b=wZKEFD+3Yu8pSxasOyULqNJ5+WiYUBUBkFrR2NBux5m0HbRo2GjwosyuK4wLTdE1oV
 uKjbU+291UYx7YkKTHe+ZEojDHh3RZ0ImZTzmOndtDkzhskx6NScVaqKAxEUJg4/x26W
 Jr4s+JYTw6+txsM/mSRYSDztQJmJVYJejB2UevD6ikr5oKrWvfqcQz/kNdz7YWkIZj0Z
 itLynAiTDFLyYRcGgM4ka7WwxshFX97mFwLuFUzAj8wV1gc0zjxFOJzCuRzhwt+QGlg6
 JrUQ0ZzRnm4TEpib8Sa2HDSfcYbZ4pfFvdWezuNBVonvqE97exFv8SCr8qfwZzo8RHzd
 tidA==
X-Gm-Message-State: AOJu0YyMnls58NMeaq0zWJ942YXh/wPFcz5Uw9aQyHrGzON5plXbIcFs
 hK7HECZlGSNx00U3BczV8W9kRW0HSeAhZ6MGXxatQTR5HNue7gtvO85F7DnmhH4ehfg5wvhqjU7
 8
X-Gm-Gg: ASbGncvtN+qv+ATCJbf83iC2s4sansKBvaRb1bC4zd2gFCuUg3wCAvIJ6bevCaRloO8
 OATpYbKKlL0ReZlw7tFF1y0b5lCA9ehwGXg/tLtfgFPjOpX8h2FQjreyMrqZ39kTN4usgdDQG8t
 n2ae4KXa5DKoUzmY2glQ+K5Ptb/W4nOA49YjaR7ufri4u34kgBp6pqS1WlpMbcU3Fo4chWJD9IW
 FxS9QDItkEKrzNu3YBMmoEeAhJQACakNZ2SUwrR+/H8LFgUnvzv6fBozYpIaFWkDjbGzXH5PJFc
 rd0XE/HV1c/QbWBc8SWpWURPp8/aP60DaMUDkwxheuZ1k7J5HqjuXDfa53RaMNsHhZVQqGDoFnQ
 BZlXO5oq79Fm/0Hiy4UExIPUO
X-Google-Smtp-Source: AGHT+IE5/ZI6EM+luxv3kFtX1kBmoAZ6GZYPFB9qVadZ5lGZn+NLX9l/VUj1PqYTg0FxXNA2sfv/Rg==
X-Received: by 2002:a05:600c:1827:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-43ebeda3c57mr33607555e9.0.1743712368451; 
 Thu, 03 Apr 2025 13:32:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b6778sm2581591f8f.46.2025.04.03.13.32.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:32:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-for-10.0 v3 1/5] tests/functional/test_aarch64_rme_virt: fix
 sporadic failure
Date: Thu,  3 Apr 2025 22:32:37 +0200
Message-ID: <20250403203241.46692-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403203241.46692-1-philmd@linaro.org>
References: <20250403203241.46692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This test was randomly failing on our CI, and on dev machines,
especially with QEMU debug builds.

From the information collected, it's related to an implementation choice
in edk2 QEMU virt support. The workaround is to disable KASLR, to avoid
accessing protected memory.
Note: this is *not* needed for the similar test_aarch64_rme_sbsaref.

More information is available on the associated GitLab issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2823
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250328183816.2687925-1-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/functional/test_aarch64_rme_virt.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index f4ad4d33d58..a1abf584f0e 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -87,7 +87,9 @@ def test_aarch64_rme_virt(self):
         self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
         self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
         self.vm.add_args('-netdev', 'user,id=net0')
-        self.vm.add_args('-append', 'root=/dev/vda')
+        # We need to add nokaslr to avoid triggering this sporadic bug:
+        # https://gitlab.com/qemu-project/qemu/-/issues/2823
+        self.vm.add_args('-append', 'root=/dev/vda nokaslr')
 
         self.vm.launch()
         # Wait for host VM boot to complete.
-- 
2.47.1


