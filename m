Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB0EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBdw-0007f9-EL; Thu, 06 Jun 2024 07:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdu-0007eW-IQ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:54 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdr-0000s4-5z
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:54 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57aaaf0eb0dso657838a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674649; x=1718279449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpcnTdqQKukQ++vO/ujw32iSOTtYaTfkN4dkaQOCFyI=;
 b=iMWLeUOyOI2qtUqh3o6ui3IXigWThdCcmG9a9KXDPgaClT5kXjuIEkuynAIA+V7J9d
 6o+Ys3dK7Z/Ii7fYqTuSSjrWsnjwYm6YBTti0L92nVnzB0MbrRF8B98gRWKHT8Ykj4QO
 zXiN53DNijd+OiVVe9lHVWx1NTJrbkOSunASd5oKUmGT/Mcvb0l/OJKbZ9Ue3Aop2+Pn
 3Il+7zWGd7Qn+Jo04ZqzF8w6HTLCYVbbeWSkrK0mj1xpg5jvR3U0BrWW5Rp8K0HA1LAz
 gK1qZmaLJr2q61NaQUbiTvwA740B2z2zNN6O5yq21dK8GZMz+lE74hBGKBDsE1V4tKK2
 rfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674649; x=1718279449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpcnTdqQKukQ++vO/ujw32iSOTtYaTfkN4dkaQOCFyI=;
 b=Hu7W/5XEvRZPwBcVSnQB7ZbOIl82BQ5URsDqNoLOMiIsjgpcyvDHRHL5/hdfQeF9JU
 W3ZHB63V+BB7SFb22wF6G1RsR5x7BC1y9XT9Gv+DsAgOMcYH8ucuPQ54XyZa6MsAq6F6
 3vC8x3fcm47Qg8YRN0hYFgsHUW1BNEXZXgh1X1tI0l/z4nN5+Ee3ddKgheNGZMRTxQ6/
 OVZL8zgi4SVP//vN0SwV6WOKeZc4g14By/DE9eK96ZMYr3GC8lcqpE4u8ei/5TL2S2JL
 W2kifSg733wZViO17ru2ki4X/e8ZV1vF9VZfg2e+7Up02KDtN0AIJYl8Ok7bWkdX95Wj
 LH5A==
X-Gm-Message-State: AOJu0YzqUujpRPQNfNizWTVD++vLehD4f/23j4hqslRngOleOj6bSU9U
 1lCcCgezyC0pbz1gu8f0XM6DC3VgaURzosnGVORLPxHrMoC6Hda4gSabw0IZjSs=
X-Google-Smtp-Source: AGHT+IEKwntF50Ew6kzOJSBuECgJ4Zt5P8Ylq8bX1M51ptj97i2d8ZKRkXokrdKfU0um/OaxnEgDog==
X-Received: by 2002:a50:9b15:0:b0:56e:99e:1fac with SMTP id
 4fb4d7f45d1cf-57a8bccb38amr3217355a12.39.1717674649478; 
 Thu, 06 Jun 2024 04:50:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae205bb0sm935592a12.67.2024.06.06.04.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4730F5FA1C;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 04/12] tests/vm: remove plain centos image
Date: Thu,  6 Jun 2024 12:50:39 +0100
Message-Id: <20240606115047.421045-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

This isn't really used and we have lighter weight docker containers
for testing this stuff directly.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-5-alex.bennee@linaro.org>

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


