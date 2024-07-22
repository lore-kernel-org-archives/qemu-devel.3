Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B04DC3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqq8-0005dS-1M; Mon, 22 Jul 2024 07:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq5-0005UF-HD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:21 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq3-0002RJ-4y
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:21 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77e5929033so412109466b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646257; x=1722251057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/uzwaGj2Fi8+Yx5qy3aEaskQ+qw83w2a8whjBsiJBo=;
 b=l0AFLjkxU3lP1p+y3t5/Dp16CmSqSHRt6aJl8bsPEuy9Fet+BGa97uUuFV0vw6UQIZ
 +z+2h395kl2OaThtl45sFt98WTksSZLekX5rIz8zRLsDEhJyMIOFT79BU654nLKStEfc
 KaAP/U3lTF2/57cjsHJ6C6g4vVuukO9EP3B3tQrjZga2eZfgRnSC8qRBIWCkXmmqmrYV
 KpuE4llUjunNEqllB4RrwhevKMndytABWUQWGAjDlLlFf/zYiC/RrelFEJ3qgVa4SaTy
 9SGnP9wA6UOIiRO4uNw96K6G4njwKGa245RDHzLtoyvifT0SYwHAJ25sEdL6gIbmYY+q
 Itmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646257; x=1722251057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/uzwaGj2Fi8+Yx5qy3aEaskQ+qw83w2a8whjBsiJBo=;
 b=w20uA4LzjCqL3oYYZ8uJ6TQr1Eqmk9ILMJy/3cisrjPiegalu/Q5XSJhexvlmFx/SA
 vERNSNDj/4owIbTvkmubQhyzxk27s5Odx3e+seuGEJ6xlbr3Tb060+DcuRlH1bIfMs0D
 uZHD/0IUmWf40j1VDim5RzIhkG7VQNoeCLkwEjbNrweVgy6E9mGbrVInMD7odJpD+a17
 ikd34S9WxEhLpSgbVA6AkxBPiBPGBtX2JOHMgtG9Y21AsaIVG7BJzVpZNeJALuputcId
 fdQfl13xsOKpQbzTxdC6j+ksYN0PoPMiJPtGwztCxgi+YMKsma3t1EuigS3Xomx3h7ps
 XSSg==
X-Gm-Message-State: AOJu0YxGl0Azu4rYoD9uBdjFK/tqCEofI6HSa4mmUVR8F1RB0ZNbIMzL
 /FVpTNXvp1tDL7cPn0nRNsIP/ZPKJxBZ4QISxhYY8pP34Qt+VMVG1rNAkVi0ci0=
X-Google-Smtp-Source: AGHT+IGcx6QjwgQQzfy7J4OCAwZq4UqoIFDkRKAkVR/8em8ttK8yKn4whMa/AQRIqYF6/TW30EiwWw==
X-Received: by 2002:a17:907:2dab:b0:a72:7603:49ef with SMTP id
 a640c23a62f3a-a7a4c1216ffmr469782566b.35.1721646257367; 
 Mon, 22 Jul 2024 04:04:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a81cd53d6sm2675266b.139.2024.07.22.04.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BCAA05F931;
 Mon, 22 Jul 2024 12:04:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/16] tests/avocado: Remove non-working sparc leon3 test
Date: Mon, 22 Jul 2024 12:03:59 +0100
Message-Id: <20240722110413.118418-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

From: Thomas Huth <thuth@redhat.com>

The test has been marked as broken more than 4 years ago, and
so far nobody ever cared to fix it. Thus let's simply remove it
now ... if somebody ever needs it again, they can restore the
file from an older version of QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Clément Chigot <chigot@adacore.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240710111755.60584-1-thuth@redhat.com>
[AJB: fix MAINTAINERS]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-3-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..d5ff6c2498 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1727,7 +1727,6 @@ S: Maintained
 F: hw/sparc/leon3.c
 F: hw/*/grlib*
 F: include/hw/*/grlib*
-F: tests/avocado/machine_sparc_leon3.py
 
 S390 Machines
 -------------
diff --git a/tests/avocado/machine_sparc_leon3.py b/tests/avocado/machine_sparc_leon3.py
deleted file mode 100644
index e61b223185..0000000000
--- a/tests/avocado/machine_sparc_leon3.py
+++ /dev/null
@@ -1,37 +0,0 @@
-# Functional test that boots a Leon3 machine and checks its serial console.
-#
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado import skip
-
-
-class Leon3Machine(QemuSystemTest):
-
-    timeout = 60
-
-    @skip("Test currently broken")
-    # A Window Underflow exception occurs before booting the kernel,
-    # and QEMU exit calling cpu_abort(), which makes this test to fail.
-    def test_leon3_helenos_uimage(self):
-        """
-        :avocado: tags=arch:sparc
-        :avocado: tags=machine:leon3_generic
-        :avocado: tags=binfmt:uimage
-        """
-        kernel_url = ('http://www.helenos.org/releases/'
-                      'HelenOS-0.6.0-sparc32-leon3.bin')
-        kernel_hash = 'a88c9cfdb8430c66650e5290a08765f9bf049a30'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_path)
-
-        self.vm.launch()
-
-        wait_for_console_pattern(self, 'Copyright (c) 2001-2014 HelenOS project')
-        wait_for_console_pattern(self, 'Booting the kernel ...')
-- 
2.39.2


