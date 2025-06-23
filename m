Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A90C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgCZ-0005SZ-6E; Mon, 23 Jun 2025 08:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAV-0003a2-80
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:21:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAT-00017t-5Q
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so47711665e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681255; x=1751286055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYUPy6c9pCrsEaCpnIHygEtzD7GwjrL4VzsD7TAXMX4=;
 b=k8xT4zvzkwxHX7rXPIOG4kXTie7djOwtkXy2+psn46jLX0a2lB/9k7uMx4pzfvOhB+
 TQPrISjxxCW3MgpeiWyKccTAXLcLr5GgSFD4TVtah/yE9MqBgXR7GNhsQmAzBLpDk2Jj
 fgsAd51v1mejvlClPuOLiQSSjRv9i351wh9vyjglajtJKIByuzd19tdBkA4uRlrywzYO
 wIqhjFv54ijtH8KWVLrnP96JGgt/B158k+osDl+jO4DCrWFlqzN8bqD6K5m1umMii6U4
 nQ4kbpX+7vhNO1lDP89IX/f0W305p9/z/x3yZ9zvlLRA6NnfVnR3a6+4R4u/5zme3TlY
 rm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681255; x=1751286055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYUPy6c9pCrsEaCpnIHygEtzD7GwjrL4VzsD7TAXMX4=;
 b=oNZoPMpS6y5kwgpEdw86Rj/UxFapFgC56/eKluHk5shTek12/FTzAHLzKlHaMl0btn
 nmMS2Sbhcc7sNS83NdciYglWWPUoGXUJoODr6Vc1CtPCRt6Zsp5qOGo7hSj4JGqtn+Im
 zCNkVhT32jmr1X6SGfC+BpNesjIES93KG/P5hSsvFUyP+EjBJRLQ2IgChHEJNMzkwN2e
 Kil9HBXxLUntw6P27Ds3e8rCL2ElFbeY9AIyfYmN+5SsWXmvWwiYsC7+d2fgKQgFbCjX
 POfp8sUrXSq60Yg+XQ7xT7XS/BRl8/co+DQ1Fo9OjVLGML1MlaYA6WHe/XHQ/9wgHwr/
 w8MQ==
X-Gm-Message-State: AOJu0YxCl6VDSXtcN6QRWkeJiDXmo5XKBMopifQZRyrfWQrt0GB5wrV+
 ywXwvpNYTTjyk2zanCcOEsMY6Oin9OPrPJSstlEVCW/2fXeuduQ7K9ruBgGXAmtX/E3p/jW8/TQ
 Lu45o
X-Gm-Gg: ASbGncv5wLr2AzomlHSUAWD3jCMITj5pgZFYVt6ugZxEyIe1+xrhovc6mBjvAeLblzg
 stSaXpG6IdAMbaz8asevQy8LYdRGcjGaZyUKJywI9Lc8WTl8FGFLc35ytQi6aW+tyx4EqValEYm
 2PcVx/6KQH0dtMIp5EXK1fUNyegOEPd27FCHKhN+lbCEJ9CyAIUAyvSP1Ze0P92dXe9BH8Lv7EX
 vo/uxjyAoMYHGJjDpv/x7ehxpn2eNizccVs/aHyw+QJFNKoxVHCgIYiHoVvjBbdRK1MKel6BSKS
 e1tkx2k99rd0TKxS+LIL//+KXShMo+7CH+PqaYzqrhPp4TY3orMRpFIY2xrt/TICqtNuLpumYiU
 /e8FVT48Nba8kt5aPJH6LauV/wyUS3SlE4Txc0ju68npcW8o=
X-Google-Smtp-Source: AGHT+IGT6YWtiD9z6rC4lmVWjBSvzyqzKhJAfYphN1oZr29sjiHZbaoLUEt5rTgirbEWO1WecJkvgA==
X-Received: by 2002:a05:600c:4512:b0:453:5c30:a1d0 with SMTP id
 5b1f17b1804b1-4536e0da765mr56200145e9.21.1750681255141; 
 Mon, 23 Jun 2025 05:20:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e2036094sm2263838f8f.99.2025.06.23.05.20.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:54 -0700 (PDT)
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
Subject: [PATCH v3 25/26] tests/functional: Add hvf_available() helper
Date: Mon, 23 Jun 2025 14:18:44 +0200
Message-ID: <20250623121845.7214-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 python/qemu/utils/__init__.py          | 2 +-
 python/qemu/utils/accel.py             | 8 ++++++++
 tests/functional/qemu_test/testcase.py | 6 ++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__.py
index 017cfdcda75..d2fe5db223c 100644
--- a/python/qemu/utils/__init__.py
+++ b/python/qemu/utils/__init__.py
@@ -23,7 +23,7 @@
 from typing import Optional
 
 # pylint: disable=import-error
-from .accel import kvm_available, list_accel, tcg_available
+from .accel import hvf_available, kvm_available, list_accel, tcg_available
 
 
 __all__ = (
diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
index 386ff640ca8..376d1e30005 100644
--- a/python/qemu/utils/accel.py
+++ b/python/qemu/utils/accel.py
@@ -82,3 +82,11 @@ def tcg_available(qemu_bin: str) -> bool:
     @param qemu_bin (str): path to the QEMU binary
     """
     return 'tcg' in list_accel(qemu_bin)
+
+def hvf_available(qemu_bin: str) -> bool:
+    """
+    Check if HVF is available.
+
+    @param qemu_bin (str): path to the QEMU binary
+    """
+    return 'hvf' in list_accel(qemu_bin)
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 50c401b8c3c..2082c6fce43 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -23,7 +23,7 @@
 import uuid
 
 from qemu.machine import QEMUMachine
-from qemu.utils import kvm_available, tcg_available
+from qemu.utils import hvf_available, kvm_available, tcg_available
 
 from .archive import archive_extract
 from .asset import Asset
@@ -317,7 +317,9 @@ def require_accelerator(self, accelerator):
         :type accelerator: str
         """
         checker = {'tcg': tcg_available,
-                   'kvm': kvm_available}.get(accelerator)
+                   'kvm': kvm_available,
+                   'hvf': hvf_available,
+                  }.get(accelerator)
         if checker is None:
             self.skipTest("Don't know how to check for the presence "
                           "of accelerator %s" % accelerator)
-- 
2.49.0


