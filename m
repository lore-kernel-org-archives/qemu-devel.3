Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD8AC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBsa-00078E-BK; Mon, 03 Jun 2024 13:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsH-0006yk-HH
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsD-000082-Q3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42134bb9677so30891995e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437211; x=1718042011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8/BJyXyrU77noN4L93DWeN1oQ/59GUmwfEPrUYZCUU=;
 b=f2II2XO8HgHaNZq4UMojs/6smd4EqcAuvoe/qgrocubgkrBKyCC6oSpzYkJMLb4W0o
 FcykFkqFgCH3ScXSzIoOM9oGO1PmwlKpMDdVl+1KR2h7TwcnI+RbVlVU9HAkguj8NXe8
 tNC/chHKucIGtn8yuou9bmpuiG+M4V0VkijLXu6cxjIzMKH49orUA/j7I+A9f9AK10Tf
 OWoDI9RjlC74/ZD20ODC8xnYW1SN7loMTBDtOSHBchJCDIKcGzYtvcqn3t3B6sSCyhsf
 r+ooZ9XF9kaL7NM6mHZog6z6VGaCvEx31Q2G0fDjCVvXy/pSxgaODH0D9iiRANvsPSkt
 BzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437211; x=1718042011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8/BJyXyrU77noN4L93DWeN1oQ/59GUmwfEPrUYZCUU=;
 b=B0HfzcM+/wl9iCyENaxY8vio2gmtBoGfu9cjRGKrNy5u/zG+tF+LEiJF6aOrtH+hSI
 UL4sd3i2F0Qh/k2FpgzrNqHoynl28rKP7gn0HgfPIyy7wHwiRUosS/j/Ijs4bCSwoSLr
 tcOtjlgYYB65m7IrmTKjpOthOkgkUrkCxr5MtAkJIUafPUAPrff4fEoifW71sas/cLPJ
 99izzoULe+20WnBBNzNnK7ijhqsq0CGEV9t32rFNLhS90M8nZ7edwvBz5tkIw6xXXxUc
 BEMNsP1a07PBkBojCY4dG9VAhkHLtSJbtUfd+omhRNdhOMFCKefuqknJUzVTqD3zK84R
 sEKA==
X-Gm-Message-State: AOJu0YxdVRfmIGa2bhsMpBU5oATSnlouqkCE9UAfne4R3FcKeL+IGm7V
 Hm9kupDc1oj6ums71aeLh+Yo3nUBe1Wuzj4zBHlluQQlTEdosLqi7IGkbxRexGQ=
X-Google-Smtp-Source: AGHT+IG15AeO1aPjVnU9qyxTMBNIMtIAMWvRDUW2vwFY1/R5hr0KrpEJY0PbI2uHtzG7N7HQM5qFLw==
X-Received: by 2002:a05:600c:4595:b0:421:1717:2cf0 with SMTP id
 5b1f17b1804b1-4212e08b5f9mr101285805e9.24.1717437211033; 
 Mon, 03 Jun 2024 10:53:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04ca9b0sm9261489f8f.26.2024.06.03.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3EAD5F8F9;
 Mon,  3 Jun 2024 18:53:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 03/12] tests/vm: update centos.aarch64 image to 9
Date: Mon,  3 Jun 2024 18:53:19 +0100
Message-Id: <20240603175328.3823123-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

As Centos Stream 8 goes out of support we need to update. To do this
powertools is replaced by crb and we don't over specify the python3 we
want.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240521125314.1255403-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240529160934.982373-4-alex.bennee@linaro.org>
---
 tests/vm/centos.aarch64 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/vm/centos.aarch64 b/tests/vm/centos.aarch64
index 3f58de1e64..fcf9e08c87 100755
--- a/tests/vm/centos.aarch64
+++ b/tests/vm/centos.aarch64
@@ -25,9 +25,9 @@ DEFAULT_CONFIG = {
     'cpu'          : "max",
     'machine'      : "virt,gic-version=max",
     'install_cmds' : (
-        "dnf config-manager --set-enabled powertools, "
+        "dnf config-manager --enable crb, "
         "dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo, "
-        "dnf install -y make ninja-build git python38 gcc gcc-c++ flex bison "\
+        "dnf install -y make ninja-build git python3 gcc gcc-c++ flex bison "\
             "glib2-devel pixman-devel zlib-devel docker-ce.aarch64, "
         "systemctl enable docker, "
     ),
@@ -38,10 +38,10 @@ DEFAULT_CONFIG = {
 
 
 class CentosAarch64VM(basevm.BaseVM):
-    name = "centos8.aarch64"
+    name = "centos9.aarch64"
     arch = "aarch64"
-    image_name = "CentOS-Stream-GenericCloud-8-20220125.1.aarch64.qcow2"
-    image_link = "https://cloud.centos.org/centos/8-stream/aarch64/images/"
+    image_name = "CentOS-Stream-GenericCloud-9-20230501.0.aarch64.qcow2"
+    image_link = "https://cloud.centos.org/centos/9-stream/aarch64/images/"
     image_link += image_name
     BUILD_SCRIPT = """
         set -e;
-- 
2.39.2


