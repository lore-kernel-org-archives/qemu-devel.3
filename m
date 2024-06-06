Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0B3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBdv-0007ek-0N; Thu, 06 Jun 2024 07:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdt-0007do-02
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdr-0000s2-0w
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:52 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a23997da3so927720a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674649; x=1718279449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V07znrvdRFwEAUR5EgS7ba6UEaksyiSIzdQoYp5zxU4=;
 b=VJoG9raPDnnVTZX5Tf2MDry3bMH+bQxvfAV/HYMoRcAQQcipB+7HDIg3A9HZbYwHcs
 119mAXa+U2ym3MHb07fmkrbaC7BkUFo/snEVibCuRt10aJEjiqMufyuTHxDuICc97BYh
 G6+i8qotvR3w1Ku2l50B91AoEPKtgQ/QnfqfgsYnSDZuxC+MnaKGk7m/moLPtEkCVccq
 YgNva1WGvLF2O1JQO0SY4kGvF8VcT9vhdyhA65uGwQvSpLRN5ni/BKf2scvh+jWXs0e7
 pGaQbMEa+JGeKNdjX7TG4d5jaAet6DJqZP7+OE4v2LpgErV1Sap8HZ1wEoI3Oyq31Jjo
 dObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674649; x=1718279449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V07znrvdRFwEAUR5EgS7ba6UEaksyiSIzdQoYp5zxU4=;
 b=CKu6h68F1CAc9ATbX6IqDUptufY17tHGjhhccTB+8OmqPyy6wLj+KEiAxWsKbKMVpS
 EdsmnClOS6Cnb6GnX9cqPzdV07SHfQhB6V5CnRUVFNyMYITURMj9Rf0vsu1BD7qQ6OrM
 iTSzNyfn3Mfg6w0h0ixsXOq/esJsRsxwAKi8jF2Dd5sp2Q615/dqJh7AQMKbDRuqSK3j
 lshH2SlSOzeoUYmS2xVs+XeTiy4TJw/DiDCGzGnwLc0MqEGZbOzu7rqztbKNzHVYJD1k
 F+3uO4XbdjYl/CDxQmjJSPSEH0Khto5ZOP0izhlsaDitYBjCW6yGNgXEUjeoWVJQ5qRd
 tUKA==
X-Gm-Message-State: AOJu0YxNLoFL2TIRtFcsIFgsl0vpWWEt2a4yFzLg/Tm/AvZTCu0POTX8
 oY3ymChdz3VT605wbpHMYp4P0CZcpNlzYxgbeMdMsWErR46BXcOfTyHGQBEDVdU=
X-Google-Smtp-Source: AGHT+IHtzOy2r7FhPLLm0vR33xqbfmBM11C9QMEk7+j6KZxqS86GNVD9ZHwvFGm4Fkf94EisyFBbZg==
X-Received: by 2002:a50:c35b:0:b0:579:cd46:cbfd with SMTP id
 4fb4d7f45d1cf-57a8b6a7297mr3251684a12.18.1717674649237; 
 Thu, 06 Jun 2024 04:50:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae13dc46sm970909a12.52.2024.06.06.04.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DCB15FA1B;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/12] tests/vm: update centos.aarch64 image to 9
Date: Thu,  6 Jun 2024 12:50:38 +0100
Message-Id: <20240606115047.421045-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

As Centos Stream 8 goes out of support we need to update. To do this
powertools is replaced by crb and we don't over specify the python3 we
want.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-4-alex.bennee@linaro.org>

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


