Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C8EC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgAc-0003Yq-Ul; Mon, 23 Jun 2025 08:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAL-0003IR-Kw
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAJ-00015Z-Nx
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso32242415e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681245; x=1751286045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y66de3esKoxe7Lq7nXgyyvCOXzL/4wNdUP/QM7Hg6f4=;
 b=ldciURYTOm5WO7LytwRDyyl11r0PXpTRuS04+9YnvZqUA53SZ9chP4UOUb/Kcppzft
 7g/2U8IvEhiBCOBRzi4pgYuZbr39L8rhdFD1jJDU3aQR1IOSqmlRXZyNN4RiXvihNx4Y
 /Ijflf4l6aAmL3ULXn8ujwsD5GXF/d7shnAEBqc9Jcd9eHNmil0/TrjnAJTYxRSCt4+R
 mYE0twcg+5ze+Gpxv+Retw+hEGlgl6AS5hIPkFMxLgBjyRvq+bCw0Jkyd9bMkMX500Gm
 ZrDK8+J3z9x9I2kHqNuesT6zGMOKpda1rdZRtXGxXxANTPEjr8ODdmRh5BNpctH6+26f
 bjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681245; x=1751286045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y66de3esKoxe7Lq7nXgyyvCOXzL/4wNdUP/QM7Hg6f4=;
 b=RlUNsBkf8EGk3OsfADd4quA/crqBFmAJk+a3tVQqDUkURHkd/dH9XcF9c2o1Uo4FRi
 /bTa37ve92HFRmVTTFd29E80h5arOteHXHhttYySz82t+p5rS1DnKt9vgRm46dV0Ip5m
 oSyDI/ZXD9CtOzeSZBP/ffe/ORIMWPDOkh38a3nYevWPQ2E+7IFpCsfn/A24KT2+EZCY
 dV2iMCpsdReW5ysZe0Cj97Pvd7ueysLdz1F5mtfuCgX5OV033uU+YoWSVQQ3+foMJ7sx
 IJB0+nY+rDsoK8XBUI1Nkk0OsiHHCtukvvXvQDOzS803e8VsvyGeKB6ePgYlRQwdEQOL
 MO6Q==
X-Gm-Message-State: AOJu0Yym9pSHj4PQB/P0+uoKqfW2tFD8N27Ked8qffi/AFjvzjZtWdza
 Z66e6N3BGlsQihS6wmY5xXcWvWmmUmCDcTdY97JYcMxUxzAWPcHxnUqvAe5u3MCHvAw+HDjMgjG
 VasjR
X-Gm-Gg: ASbGnctTEdCfwZ5ScFqo6rqyhhcgI9zlhqNUrMHKHZEDU8W6BKNk3jU29MLCYtezUgw
 hJNg0pPWhwl+BWXCgtladwbX72pE0qAmfGjB0s4vhDoT+3cblxZoKCVhNEN678YpamDQHoNqiC3
 /5Zh5EYmhx9C3GIlTOl2HVHLdl4ZN12jwGjstWCdhkP6fYpBuUrk31oCgWhhm4L7sZ17hgOjCTf
 lJLrWCljHLQkvew1yutPyd+Pe+EMOKWNeTyktQJAnLKjJgpTNL9XaeQW9UowddpYS2aJuo//4Hv
 jkZ+K5XpW5ytG5OWrJK+WTWAZcLmLu8v1BAiBBjvabD3qkspr6LByZc/Qf8+E38vIVYLMv6c8oT
 2dSSiKIixgwsSPgpYWMhY2eNOgNa2AXBQ7Key
X-Google-Smtp-Source: AGHT+IEID5av1fp7z71GMDcrtgYTt/iBmDplBK/iwcImMCZA+DLu+Yd9shEYZ/xuGkpZgY5IEvOhLw==
X-Received: by 2002:a05:600c:c1c8:20b0:450:d3b9:4ba2 with SMTP id
 5b1f17b1804b1-453659d4330mr62504005e9.24.1750681245056; 
 Mon, 23 Jun 2025 05:20:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c0fcsm9565403f8f.62.2025.06.23.05.20.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 23/26] tests/functional: Restrict nested Aarch64 Xen test
 to TCG
Date: Mon, 23 Jun 2025 14:18:42 +0200
Message-ID: <20250623121845.7214-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Currently QEMU only support accelerating EL0 and EL1, so features
requiring EL2 (like virtualization) or EL3 must be emulated with TCG.

On macOS this test fails:

  qemu-system-aarch64: mach-virt: HVF does not support providing Virtualization extensions to the guest CPU

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


