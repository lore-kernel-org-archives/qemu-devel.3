Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA35C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLs8-0000aP-Tl; Wed, 29 May 2024 12:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLs7-0000Yb-2M
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLrx-0003I0-B2
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:50 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a033c2ed4so503816a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998979; x=1717603779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mFJU9rFkOCPkiRRJRVguUKwofFuR8N6rDGAXVArW6I=;
 b=LZXloJhgR4Jf3HrYJT7ZZ4BWg5EFNqZYDqtQlvZb1fddhPhdtSv+DyNVGqhcd8Z4lK
 6osD6EwRPEWPgWNjNQFDO79vEajgbshTPWF8ThE9IUyQ30tyNrAjCjwln7J1JIumn8TH
 qmlwsE0jxJu5csQNmWyrbUrkzGX8RoG10M5RDk3p7mzGCAzujW5qxB5Kz0WnO836qGUe
 UtX83dTW+AWDWQ94hr+GBXlHL4dwE7vVZmBgUqiyypDElXoAsNDb+l+fcqB8GuZjU09E
 QyalW9kZa10okgnSaY3GaZ1M2lfmIR+fwlwOPe4vMWamRxIsG3jk7ngnTMU+x54kGywq
 xq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998979; x=1717603779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mFJU9rFkOCPkiRRJRVguUKwofFuR8N6rDGAXVArW6I=;
 b=BILaK8N4RoCgwkV3nqaLwDXhjHG+OvRSuPUG6Uu6hME9qQDM51c1xJg4ZlBvjBONTx
 AJHUa1upMZhJptFYCHQGMBWYobfHLPn+gsSZ09idnkxkatX6L47kH9KAZRB0GJO6SYUq
 Shh5/zbCGxhh90Qr5huYf6x5iG5VMUqgqFSa7KpinJZuct5Ewo9LFOW3nlZg3tSAC8YT
 dPeD06wH0DQLIu4SAXDZSKlRCelu44aVX4kUnwEgy4N+0hzTPjkoY7dq6NKsGWbYhvp0
 L6Eg1QB4b/aOBTuHlg12+yOAUw0GX1ibozw3tpofnxYvaArp/rUoTWfCrZ+yo6c99jJO
 9axw==
X-Gm-Message-State: AOJu0Ywd5fudgqNF3hOq/vwZTCN3Ss4bIQP/T3FbDZMn0XAqfqX5KfcP
 CEJOwVhKm+ZxHRbIc8yX6hpgJm4wYmg++/+WlYQtzDKdPEJMqiLflKxbzTGSlAw=
X-Google-Smtp-Source: AGHT+IFsxxi3XEZMOrrucBbY5s02Z2MiIHPAW0u3VEpO5HwJVw0VM7Fc6xoUbd2t0lCmaG0bK91jtQ==
X-Received: by 2002:a50:c309:0:b0:578:6c08:88fb with SMTP id
 4fb4d7f45d1cf-5786c088c0bmr8728475a12.12.1716998978694; 
 Wed, 29 May 2024 09:09:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5785233bb04sm8555012a12.12.2024.05.29.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 688095F8E7;
 Wed, 29 May 2024 17:09:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 04/10] tests/vm: remove plain centos image
Date: Wed, 29 May 2024 17:09:28 +0100
Message-Id: <20240529160934.982373-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529160934.982373-1-alex.bennee@linaro.org>
References: <20240529160934.982373-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This isn't really used and we have lighter weight docker containers
for testing this stuff directly.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240521125314.1255403-5-alex.bennee@linaro.org>
---
 tests/vm/Makefile.include |  1 -
 tests/vm/centos           | 51 ---------------------------------------
 2 files changed, 52 deletions(-)
 delete mode 100755 tests/vm/centos

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index ac56824a87..13ed80f72d 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -45,7 +45,6 @@ vm-help vm-test:
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
 ifneq ($(GENISOIMAGE),)
-	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
 ifneq ($(EFI_AARCH64),)
 	@echo "  vm-build-ubuntu.aarch64         - Build QEMU in ubuntu aarch64 VM"
 	@echo "  vm-build-centos.aarch64         - Build QEMU in CentOS aarch64 VM"
diff --git a/tests/vm/centos b/tests/vm/centos
deleted file mode 100755
index d25c8f8b5b..0000000000
--- a/tests/vm/centos
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/usr/bin/env python3
-#
-# CentOS 8 Stream image
-#
-# Copyright 2018, 2022 Red Hat Inc.
-#
-# Authors:
-#  Fam Zheng <famz@redhat.com>
-#
-# This code is licensed under the GPL version 2 or later.  See
-# the COPYING file in the top-level directory.
-#
-
-import os
-import sys
-import subprocess
-import basevm
-import time
-
-class CentosVM(basevm.BaseVM):
-    name = "centos"
-    arch = "x86_64"
-    BUILD_SCRIPT = """
-        set -e;
-        cd $(mktemp -d);
-        export SRC_ARCHIVE=/dev/vdb;
-        sudo chmod a+r $SRC_ARCHIVE;
-        tar -xf $SRC_ARCHIVE;
-        make docker-test-block@centos9 {verbose} J={jobs} NETWORK=1;
-        make docker-test-quick@centos9 {verbose} J={jobs} NETWORK=1;
-    """
-
-    def build_image(self, img):
-        cimg = self._download_with_cache("https://cloud.centos.org/centos/8-stream/x86_64/images/CentOS-Stream-GenericCloud-8-20220125.1.x86_64.qcow2")
-        img_tmp = img + ".tmp"
-        subprocess.check_call(['cp', '-f', cimg, img_tmp])
-        self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
-        self.wait_ssh()
-        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
-        self.ssh_root_check("dnf update -y")
-        self.ssh_root_check("dnf install -y dnf-plugins-core")
-        self.ssh_root_check("dnf config-manager --set-enabled powertools")
-        self.ssh_root_check("dnf install -y podman make ninja-build git python3")
-        self.ssh_root("poweroff")
-        self.wait()
-        os.rename(img_tmp, img)
-        return 0
-
-if __name__ == "__main__":
-    sys.exit(basevm.main(CentosVM))
-- 
2.39.2


