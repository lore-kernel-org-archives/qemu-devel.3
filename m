Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8F1C54722
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5HY-0003hS-Nh; Thu, 22 Aug 2024 06:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5HW-0003gy-VN
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:43:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh5HV-0001AN-EV
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 06:43:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3717de33d58so323933f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724323383; x=1724928183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4qja5+51Vsbcc1haEmPRmBh3XPr17SQDcwk8vlpqiY=;
 b=sAzIgTYkYfg1N4hVgk9wCtZqeTLjO1Asu1nuJkLFr/vWsn9txJZ39rKP24F+suTqdo
 4im3GitPSoSM8430wHBO84L0wbSiKKbgX0zAyhoeKffBV8n/mxchJ+eHRWBRyfGaMjhN
 yHDAlDyMfA390NLdUn97NA9zwW3SwF09fqWQQn/yoO8vB19SLh36s/MXdqFiTvTKorkN
 gMVAm+GTELDjeB+Nc5GnjO9Dvj5XaxdDHZS6Aqj4K6Mc9VKAzkZI4IgR56XrtILGKT6c
 ew4jhTCrcAsH/4OUG/lruarYf6eV+uplCvKr6YIQ03CLS/tsTEEFbMqoiEGwatUMDnoZ
 xZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724323383; x=1724928183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4qja5+51Vsbcc1haEmPRmBh3XPr17SQDcwk8vlpqiY=;
 b=Hn3LB451cOf8kahrR02/FFMcrEbmipf9sjq3yv6hsxsoa9wAOp5IZlERKG1F3MUk7Y
 GK9n8zMe3Ucl/N9Me/RV8Y7JK+CCVSMu1Rd8inA/2lrnKJLWkerJlPKtrVhwDoB9b5sb
 m9QUb7E/ediOeRYpxZQxRPpKPZF0zs7XGabnb9/QJCl7hqLnwGSTYRx5G1bSdKc4fz5U
 kF+adbzfSHyFaqBqSWLeuOQT9Rufolea1nZT0EtL1pJI36XKshGg0g42Uus1Z4xDzrbb
 UWf+eEV0ftK3DRh8gFi03tA/AjNsjpb3ynyzE0MJT6Br0Id4tTy19S2LgVtLMa78OL2+
 a/ag==
X-Gm-Message-State: AOJu0YzV7S7udMtMgluQPJ+Lui7M755fZIF7brMt7V+QI15/R0CS5mNa
 neIrAl7hbB8227eqHcy2bhmZ1pYAN5D8F1nlPvJXV30lo/lmo2rhuWccoiNsOZ+zXuIxep8fyIo
 I
X-Google-Smtp-Source: AGHT+IF0M+b74v//fn+N9BgIx7kVUqUFVrOuIAXQCZAln2TTRZNILk9OTMYGMZIZQTZxAqiak1mLBw==
X-Received: by 2002:a05:6000:b09:b0:371:937a:326c with SMTP id
 ffacd0b85a97d-372fd73184amr2755660f8f.57.1724323382727; 
 Thu, 22 Aug 2024 03:43:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730821a92csm1344234f8f.93.2024.08.22.03.43.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 03:43:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 3/3] tests/avocado: Remove unused QemuUserTest class
Date: Thu, 22 Aug 2024 12:42:38 +0200
Message-ID: <20240822104238.75045-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822104238.75045-1-philmd@linaro.org>
References: <20240822104238.75045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The single test that was using the QemuUserTest class
has been converted to the functional test framework.
This class is now unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/avocado_qemu/__init__.py | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 0d57addfea..0e4ecea7a0 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -17,7 +17,7 @@
 import uuid
 
 import avocado
-from avocado.utils import process, ssh
+from avocado.utils import ssh
 from avocado.utils.path import find_command
 
 from qemu.machine import QEMUMachine
@@ -384,23 +384,6 @@ def tearDown(self):
         super().tearDown()
 
 
-class QemuUserTest(QemuBaseTest):
-    """Facilitates user-mode emulation tests."""
-
-    def setUp(self):
-        self._ldpath = []
-        super().setUp('qemu-')
-
-    def add_ldpath(self, ldpath):
-        self._ldpath.append(os.path.abspath(ldpath))
-
-    def run(self, bin_path, args=[]):
-        qemu_args = " ".join(["-L %s" % ldpath for ldpath in self._ldpath])
-        bin_args = " ".join(args)
-        return process.run("%s %s %s %s" % (self.qemu_bin, qemu_args,
-                                            bin_path, bin_args))
-
-
 class LinuxSSHMixIn:
     """Contains utility methods for interacting with a guest via SSH."""
 
-- 
2.45.2


