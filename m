Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C74C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbVU-0006pJ-3g; Fri, 20 Jun 2025 09:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbV0-0006Md-Q0
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUz-00050y-6s
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so10893665e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424974; x=1751029774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML487RZEtX6RDPbX3JUchrWHyom2/STG3MUfjQAASi4=;
 b=IT057k3uHPK2jXPABWZBFBSIB+izc1o8hMUcx8/yTkbKDneHtD5b2YVkxeSqDpEmyY
 Raf5RDBNTiq2k92x/DOt6dRPrVhnAzx0XkuFUR8BtL3ZdXwoYX86RuGgDfXyQ+hIKca3
 AX+o5u4M0qJwx0AhXg4Zp0badcrniEavpS7kzUNyqUwhNZmJpZTQ9dMr/4XSZxYD3s/2
 Z8ctbfNNFIg6mcPvjc6mQsVbCJhe+pJVjqXFTO3yrO6R9xxVMHudrziF0WjnGEuJ+aAh
 J8TA+mWtXCVf4jxYcolqHtwR7mPp03Fa9kdb1w7Ob8BLGhb9QUprvfnPDCx1fReQE3op
 t0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424974; x=1751029774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ML487RZEtX6RDPbX3JUchrWHyom2/STG3MUfjQAASi4=;
 b=iHDUro0XxYtYi4MK1iUuG9+98k8V64qBJPUcjGcGnRBSVkeHdFc/BrS+d5zLtQySN0
 XEaI4F3Mmo8153wl/5xPCcl3vu182XQ9Du2+zxHUUhDTV9fHwX+mtWQ3lR5gShFlhPQd
 4f3nF9BzS7yyuiWB3f8PEWleGCHMaovWv8K9ScQmyUsdXRS3008zWq9cdJ+K9MQnG9uH
 DHNUFnWrmbKQYHX3dan4AKb25TkFYB3026P1gwn/2OLHZATiWxt6F4QpZoczimhMU0B/
 IikzAcmQ9TC3uvsTYtqmSAIsxbmyzVL7CZl8pivY8ZOWSEiNmXFWpnCTCoHgG53EvQsx
 6lvw==
X-Gm-Message-State: AOJu0YyUHL3LFrLzlVnjadTE28k0EpXx6p+hjyXAWR5EDLrCbzhZpuYB
 Nrf3tsxSMmAGICocWh7fOLJwrbSsQtKLVVunjyLhLZvttowCvnCBxrJN6hcO38RTLflFpI0KsUi
 LP7HxFmE=
X-Gm-Gg: ASbGncscjo2UhYBz3XKlca0dk0BFepDe2ACtwadmTkvt/bpv17eC+jhUxK2fMYqXtzw
 ZozJyaDM7lCw8m8vMpzca4dqXxjmKjUDS5ESAF4cmtBAVQqX2llKrt2S4fy0LHeSJ//E7DcaF7V
 Thbg6gxFO8FuVv8wpG2p1sVmjRt3UMs9hdlTuq1Hb3/OQgk2/sf47RQFopiIx3EfMoMBpmsOAP6
 hzro6TcXjsJBnpjM6rakafFUXyHQMX30rpAmp1GbOkiJ3++dtA1kE+6hJaLOegBdgqlsLo9Jz+7
 kSCKteMsq6aZepy/IE1htM2grO/SI93eY0MJLjesfi14fad6UlrpVKkTy+pUoo4dCaL7HectxId
 afhBx/v6O7/5uz/oqcrA9XsbGoLVb/ioLF9/P
X-Google-Smtp-Source: AGHT+IFoaiSq8p/vZ15JMywutihLdhiyx/4+KTYgXl1gSeqr94tnRyEi672b3w+H0TV5kZSUiEuYRg==
X-Received: by 2002:a05:600c:3542:b0:451:e394:8920 with SMTP id
 5b1f17b1804b1-453659edd18mr24577215e9.27.1750424974566; 
 Fri, 20 Jun 2025 06:09:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45359a09ee6sm38434125e9.1.2025.06.20.06.09.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:09:34 -0700 (PDT)
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
Subject: [PATCH v2 25/26] tests/functional: Add hvf_available() helper
Date: Fri, 20 Jun 2025 15:07:08 +0200
Message-ID: <20250620130709.31073-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


