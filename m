Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ECAC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUr-0006Cz-6c; Fri, 20 Jun 2025 09:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUj-00066K-AT
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUh-0004yD-Sa
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so9814495e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424962; x=1751029762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V640ljTD2H/6yk77CGg8pqgiDQ7Rk/byXNy/qGehgeE=;
 b=kXEbevRhvpba/YdO1ed65S3u9QgjQRfftfnA4cF0WhM5bAhjDO2+zoD993uK0RHDsM
 CzenPvDr/+kIKhC+mlOIsvdC1c6gFO/vyaMZrawroZnStV52cXDSTD2ZiEVBMC5+3kw5
 BXUS0vFV1Jv+AZVsPZOxntkpJRnDuTtK054pPXLnaSGLSC3l6Pw36e8RPveA4kGgAijH
 Cdn6AM3jH8VmBQAai/UFko+wqajrVWAP/7VJgt3GYdu+IHejg7s7+rpdsnV5I3Zr2fZ/
 qK4hAx/zMCPGmB0Ftoj5E3UB0bAp63HjnAkdGiUf+C5n2WN1ScApdPuaQDKoNuZNIDqT
 /VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424962; x=1751029762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V640ljTD2H/6yk77CGg8pqgiDQ7Rk/byXNy/qGehgeE=;
 b=d3UamdwPAR9YNUgRvALkXqUwjcY0UWdVvT+0AYRvroz2JRSqwpcJmlByBNpL2IULBw
 vJ61U/W+QMObYwsOqe8KBHi0XubiPc5ctn0ONQhF3r83glJyuBeAsUdAYeFvdBFfIwnR
 sDSEaMtFGnHYRJ620Pw5xo62zsLycy5QTnyytKWc+xGIM0tXdSdqqAepFbC8hdMcnzJe
 LkBA8rNCmiLFpwIxc9xWug3xGYJNxlQn5hwuajSZtzaLMWikJ4c7+CoVZ6EFaJ6xT/eU
 qiZGtbv9lUyR2jmM5zZp4yD+JP5To5staxmtBhHOeqFGaK8B9IR8CbBhU/h++A7P/Hhd
 EJ0w==
X-Gm-Message-State: AOJu0Ywhwaxd8ef1lI77HaXxSw68euVZhfZWwlOiBMYWrH3xTkSW5JeQ
 Ra9R12+V18Moio9LsaouteUK3UrUL7EaGeWO3ioojr2eB4DY6W8UtYsAjDCw8V4CVyo2vULUx3+
 R+H4ARFE=
X-Gm-Gg: ASbGncsHQWGBwDUWiD63aX/a6YUPqZ9EuPzFos2Ru8WIrzSWY712Pej4VD2cSvUKHO9
 GrvlH+r7t/Ltj9L+shF+nNR6aVHisW59cB2sWdHUYC5PRIYfFPPkOogG4DmhEsZkWjNUy/+pURU
 cljKiRgXI5LVcv7LAkUzTbkVcxcM+gyKkR43ays1qMjGJFljd5U8QU5Ueq5KF1ZMBX/T6c4HM3k
 wN9sVts+RaBX9+qReO4IEDuH5nngcNSZfB5Y/HkN4Px5JQl5E7O7mLf3y0+t5QeonL0VJ9JSnP5
 BJpc+hzLCQ4n0uI7JDCi3+KWgFl3f1x18GppLfgoN5WXWbxN5EBuukOXnbxSn9NKM3CWLDgAJDe
 kAcI6duTkVSPi+YEanXShnoEr3gQHgwtM1rv7
X-Google-Smtp-Source: AGHT+IGgGpF8T6F/eU2syTxh0rLMvaVCXrLMi432W+jy74ylNB4a4nTNwHJAEpagSMq8fk2NTIgxGQ==
X-Received: by 2002:a05:6000:65a:b0:3a6:d579:b78e with SMTP id
 ffacd0b85a97d-3a6d579b7f8mr393678f8f.46.1750424962155; 
 Fri, 20 Jun 2025 06:09:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646dc66fsm24808055e9.18.2025.06.20.06.09.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:09:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 23/26] tests/functional: Restrict nexted Aarch64 Xen test
 to TCG
Date: Fri, 20 Jun 2025 15:07:06 +0200
Message-ID: <20250620130709.31073-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On macOS this test fails:

  qemu-system-aarch64: mach-virt: HVF does not support providing Virtualization extensions to the guest CPU

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_aarch64_xen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/test_aarch64_xen.py
index 339904221b0..261d796540d 100755
--- a/tests/functional/test_aarch64_xen.py
+++ b/tests/functional/test_aarch64_xen.py
@@ -33,6 +33,7 @@ def launch_xen(self, xen_path):
         """
         Launch Xen with a dom0 guest kernel
         """
+        self.require_accelerator("tcg") # virtualization=on
         self.set_machine('virt')
         self.cpu = "cortex-a57"
         self.kernel_path = self.ASSET_KERNEL.fetch()
-- 
2.49.0


