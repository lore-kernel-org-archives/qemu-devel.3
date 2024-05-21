Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA58C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Ozf-0003Aq-Sm; Tue, 21 May 2024 08:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9Oza-000345-QG
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:53:24 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OzY-0005gl-Mh
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:53:22 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59cf8140d0so698156366b.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716295998; x=1716900798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64oTeEEknftWnlD1tjCfqHLFzBsR/ZQm2nBN/sHWoTM=;
 b=F5wDs+9fr7+H+FH0u5HrxWwwpurmSUpjdzIiIS+kt/ohu34vGBJhnExqFZFgPD3YWB
 68hM1g2dagHH3lgIk7+GU6hco+M6/kcfX++33tlTEF3dzBL2ZUePHYz+kFt+6RqzW/Wk
 FaDeM/xSgGG9n8AWi1LzRIEVdiIBwlo9GT3CbmRFXwYAVmqrV3bpBw9Tl6wwyq5xGUKx
 0Gggp1Bn81JiL2JkFXUQ/2EM9DuUhCObTs8Sy2X6i4g9eRVyiKH6fSmtqKVh9j9oKrIe
 wRmm9oEm6JftSedWk1yoUqMxyLcNta0ko13dL3SW8GCPLNeb11+arSgkEsmfY9H0qmbS
 u1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295998; x=1716900798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64oTeEEknftWnlD1tjCfqHLFzBsR/ZQm2nBN/sHWoTM=;
 b=fLTwpAxL4qPdbhJ5vHDq7WZO2ic7nvDo+LUxcpRzT/nJU8fv+SdJkA/Qkeik4cWro6
 kqznPBR3i7S/iEfa9L+g2XTTCNNcbXC6/QENp8b3tnOOwtZMkj9GjTaZyDsxfcozjkzy
 0X4I3sxbhdfDjqVXH2TSB8rZKqJcMdAciyofrfXrYMjaD8Mhr0/12dOA8hNBLqpll+pk
 kozU5qOPIGqlMYccUtPam/jJJNfL6TdZJATY2WLD3nn6/nrqQ873FmGFmbmEYWa9hq3q
 k7iu3ko3Q3VMxOErB+quJ0FVgeqoOJUrndZy29cHgiCvwA36m9bqePW+6m+3TowECWNs
 EnCg==
X-Gm-Message-State: AOJu0Yx1U56NRP3k5NA6+ghd2UqerRmkOyZgs0yEXQRukzK5pEFiQhMW
 O4o+UtbN7rSKBRoXlsF5alqNvYQMzXYgt6O8q3genKv3MEk5To9Qt+KJpw+90hk=
X-Google-Smtp-Source: AGHT+IE/4w7eaFuB7C2sUWzss8e87GvGr/iC90wD/58AfkP6K/r4jRwA7Fz/2kkkWaLpERebGgM3hw==
X-Received: by 2002:a17:906:fa1b:b0:a5a:8b8c:6203 with SMTP id
 a640c23a62f3a-a5a8b8c6341mr1332386766b.45.1716295998202; 
 Tue, 21 May 2024 05:53:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5d10b3ef82sm539034466b.158.2024.05.21.05.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 05:53:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 256335FA1C;
 Tue, 21 May 2024 13:53:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] tests/vm: remove plain centos image
Date: Tue, 21 May 2024 13:53:14 +0100
Message-Id: <20240521125314.1255403-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521125314.1255403-1-alex.bennee@linaro.org>
References: <20240521125314.1255403-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

This isn't really used and we have lighter weight docker containers
for testing this stuff directly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


