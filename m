Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F29C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MLZ-0007jS-Va; Thu, 03 Apr 2025 11:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLP-0007gl-TL
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLN-0000Ss-9q
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso6723105e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693539; x=1744298339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqdN6r/Pg42mUAWw+XorRCy8KmUUThhdk/vE08EOf5w=;
 b=A8uWizwiJVCdVonsOQKHBWxaXAzKczE2lYSC2HmWKKWM7hT0i0fEU5VH+x+dNAG/MX
 6roEnrQN7pwo/fCNUF3f/+YadzeRLlMmQec8doDAvwPEYZNBk0/ufDfRp2uprUk4biyT
 HceU0SPBNwY4YYR6ex4cXKIOk2rSpUF6aUdrSIViXp4rnqClEt04krZxmqD7HB2WsP2H
 VUzpMvqY6mHYBmfK9NlgBcAJED0LCgWaT2yrhF6E7P66U81DQ/tIbMi1Hqp8qgGB5GaI
 CJ4Nla5aYVZ8VhZl1UFLl1xgGs0Pr9LgaN0taHtBg8knNYKhPAHD3cHgHRk5Cq6oLfEx
 deRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693539; x=1744298339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqdN6r/Pg42mUAWw+XorRCy8KmUUThhdk/vE08EOf5w=;
 b=NCKP35P8GJuqdVyBVzd0wIrlhmc17bLfCOyeOnoA4QY4F7Jj5CCaNUh1CHxHQa1xqM
 Sxztv3Z0zfbMnrfjJwerwvmEQ5blTlAgwm3xdJtaAhuwyBBymIslqb/4GzDCW58Le1Ds
 urty0NbHmLuknsKxqxd4E8NQFPNxuUg7QzrLaQAXQ3IUJK3oX5Fs91r0IBO4alEZnIRm
 vtS0DFh1+39mrR4HhIIGrO/hedmGJoaWPmbD/U1z1ly2gXaengw1i8wdZo1dJFFCAHwH
 NgBju4CyZbzRSklGTiJgnUu7vXlRz2EyIEuBShphgvIWtg6Q3Ca+rxtIYe6flK52rowv
 I+NA==
X-Gm-Message-State: AOJu0YyYnT7/UIE+L1dciHRbyIieKVwzOSJzpM7U2lnfjhEKm6jw9GH8
 k0yeMcuIYzLwa40H9zVfl22h2wvJWmGYVfsw71TQ935Qf/xaB0P9Rx28f5eKS5SuLrepYNs8+gs
 d
X-Gm-Gg: ASbGncvwpjNEF61CruQslFNw0I/wxfN1ZmYN1f0EIFYsnkPF0gcsbuc3qz0EZZZzCeZ
 KoFXZ1oYZbi4LZknYMfHXhFO5el/qkYLsNOSL1c+XfU9E7c5mVUvgYQRKDSXBseuthiDBvaQL3R
 Mb1AzWsPxtVQ0LcQHin4QwP2vJWy/IgF5ZxBwggMGWoJLrTRVMniBAOXaMTsvq65GepmnTSbGbT
 5tX6b7tCD6TYCCLMqGEX3v4FpppxBNkSC3UdPWpjZl66xf68NfG0jjSmrkT36GpGeiAdiDF6AoF
 yFKtrRWHYgf3MuqYMzQ6JkZRjGujYTmbK2l3TdEejGUjMzhmg8tRpNIlpq1v3fNfnJhpJ2GQtL1
 1EhV+9Je7ikih0KW6+FU=
X-Google-Smtp-Source: AGHT+IEh9BvdhrVdanGsG8YWk+WZOjfYAlp+ePwfpgMmK+XVGGLeYRoL93GEDzbW7CbwvD3OG6Pyfg==
X-Received: by 2002:a05:600c:4688:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-43ec150afc2mr36198405e9.30.1743693539308; 
 Thu, 03 Apr 2025 08:18:59 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bbd9csm21247865e9.20.2025.04.03.08.18.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:18:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0 v2 04/14] tests/qtest: Skip Aarch64 VMapple machine
Date: Thu,  3 Apr 2025 17:18:19 +0200
Message-ID: <20250403151829.44858-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

First, the VMapple machine only works with the ARM 'host' CPU
type, which isn't accepted for QTest:

  $ qemu-system-aarch64 -M vmapple -accel qtest
  qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF

Second, the QTest framework expects machines to be createable
without specifying optional arguments, however the VMapple
machine requires few of them:

  $ qemu-system-aarch64 -M vmapple -accel qtest
  qemu-system-aarch64: No firmware specified

  $ qemu-system-aarch64 -M vmapple -accel qtest -bios /dev/null
  qemu-system-aarch64: No AUX device. Please specify one as pflash drive.

Restrict this machine with QTest so we can at least run check-qtest,
otherwise we get:

  $ make check-qtest-aarch64
  qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
  Broken pipe
  ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
  ...
   7/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp     ERROR      24.71s   killed by signal 6 SIGABRT
   2/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test     ERROR      71.23s   killed by signal 6 SIGABRT

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 2750067861e..fad307d125a 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1788,6 +1788,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
         if (!strncmp("xenfv", machines[i].name, 5) ||
             g_str_equal("xenpv", machines[i].name) ||
             g_str_equal("xenpvh", machines[i].name) ||
+            g_str_equal("vmapple", machines[i].name) ||
             g_str_equal("nitro-enclave", machines[i].name)) {
             continue;
         }
-- 
2.47.1


