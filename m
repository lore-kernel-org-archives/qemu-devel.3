Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51151E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzY-0000bO-Q1; Fri, 10 Jan 2025 08:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz7-0008OI-N3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:36 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz5-0005e8-Md
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:33 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso341970266b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515410; x=1737120210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGvy/F1fDgUfBPiL+7E48KKTfhRYEDJs/NtU4xaiBlE=;
 b=lnluB3VBm9toKUmLeoDotqmW9OpAvHj/GyAg8InnvLEKWjERCbw1ZTQxAO3ySYQSLA
 F3RJ3t1sauxl5LHUO6frHYLAFtcHKEujLBi++y8jzn7NON4Qskmr9PUfLwqsE/Sx5YDE
 JXXPiLoh7z3A2QzaAPr9rdF1Mh/8vIT9CTYH9wdviiwmKBdkGaRwKHVpToTHiJC3nVU8
 1VRTXWX9wR5n+Gz/kenejXbVk5k+ihJgVohNrMUlAS1vjrGKZIIicjH53bHL2/FkVtRo
 SwZu3PjzpQ9vWodIK2gFMM+nl+ihxJF9PUC05t5vaT3eAc02uWDzMEO+bcIKeOXiFs4A
 Tsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515410; x=1737120210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGvy/F1fDgUfBPiL+7E48KKTfhRYEDJs/NtU4xaiBlE=;
 b=PN07trIMCfKdArqbg1OCXLG6ug3fPSvKQPAfDqNtxgTS7+SJ5VITAp27TvAQh/rcG8
 Bz1Y1OispnwNMcjUll/aY2ud6FjAtFskPhOmlrRD94R/NvxNjhJhK+apJgLJ9TnTgc0z
 Xft6vyU5Y7yvJbYnEh7mTyq6Tc37EYyNhzKKxXYpXSp+7B1/JX4u+ixI5fza8PT1Lg3o
 /jTF8M5VJuZwhW1FIuW9AoUdHKCfBZgVYxeKEcykXud9sIykl7FD3BM/dwdfa8q1/wXn
 d5HEHKGZ62XICZ9mYo5XF3WH0637WCrl6ZEnctgDlAdf03tJQq1oAP1PT3O1lI9+eyLT
 DZrw==
X-Gm-Message-State: AOJu0Yy/+eC/qMtysal+c+bfg3x2yWyZ1MeWmWWVUqPCDqTp+yTWWoPt
 v8DsKdAZVkHXQthgtQfzkwoUNspy9dggAkMpiOyPdrrfRGMGnLf6wiUrpewwdjU=
X-Gm-Gg: ASbGncsMYa3q9GpXNSdrvndBh/Fx/dgnwm+cbMv+Zc4nObgvr6oEJpYfWncTXGlG7am
 Wj8BAAGrbA3dOftVjnChnDOVU77OmRyzZu5wGvu0xc7AGMrBIzFQlyggso3ijJd6mXonrA4kmoC
 S2d7KcEcYc3zSzc86aBno/f2uC+uqmJ8mAMaMr663nzaIRKDMtXAs0g+lbJEdF24gQpx9hH3s9F
 5IbqyyIFuDsIkJi81posSNq2MJPF7PbQwEaJC6NGs+cGlmiquFin2o=
X-Google-Smtp-Source: AGHT+IGK+OQjIipK8usb50DfwIcKeth8Fp1e/TcG1ftxE7PJOe8V7DxJ7fpnKXaUkcWvhQeWduuGyA==
X-Received: by 2002:a17:907:3e91:b0:aaf:74b3:80db with SMTP id
 a640c23a62f3a-ab2ab670608mr825065266b.3.1736515410220; 
 Fri, 10 Jan 2025 05:23:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95615a6sm168041366b.94.2025.01.10.05.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB32C5F9CC;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 20/32] tests/functional: update tuxruntest to use uncompress
 utility
Date: Fri, 10 Jan 2025 13:17:42 +0000
Message-Id: <20250110131754.2769814-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Use the utility functions to reduce code duplication.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-21-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index 7227a83757..41a4945a14 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -73,17 +73,7 @@ def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
         Fetch the TuxBoot assets.
         """
         kernel_image =  kernel_asset.fetch()
-        disk_image_zst = rootfs_asset.fetch()
-
-        disk_image = self.scratch_file("rootfs.ext4")
-
-        check_call(['zstd', "-f", "-d", disk_image_zst,
-                    "-o", disk_image],
-                   stdout=DEVNULL, stderr=DEVNULL)
-        # zstd copies source archive permissions for the output
-        # file, so must make this writable for QEMU
-        os.chmod(disk_image, stat.S_IRUSR | stat.S_IWUSR)
-
+        disk_image = self.uncompress(rootfs_asset)
         dtb = dtb_asset.fetch() if dtb_asset is not None else None
 
         return (kernel_image, disk_image, dtb)
-- 
2.39.5


