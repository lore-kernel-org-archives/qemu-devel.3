Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B179CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpe-0008Q8-1A; Mon, 17 Nov 2025 06:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpa-0008KZ-93
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpU-0005i0-6m
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:37 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so19325425e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380531; x=1763985331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCObaqAbinD7KhsOP46zwmYSxm2YKTey6+ugit7HEQk=;
 b=ALPlya6uzZW3ukeSgyoT7pOdP71nh2sVdeiQ9zA6OwZHUQP+YYm0Ic7TSDzQyX/NXF
 NFTK33qNqthCNfkZL47Xug3GwRXccJ95ctWRTvSOv6+K+S0m3DE17XuFP3l4Lc7om5Wp
 ANAxhVjCm9x3r263hHTkQgz5Sni9lTMIwa1ryi84RIBfjMRc2t9zxb6dZKfHsQ4bFCmK
 Bs4DSYimOxE7qPeoHjoV3AHWD7Y0nWJh/+X8h1iMF9OjJSS+RiWiXAp91rLuPMGzExO8
 Wn8dcTmY9HqLqSZpiyrMvwTsimkYNtCQ2nhuohBTMdRKOZ3zX7BQRf5JRA5Nv/bMXM1b
 xdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380531; x=1763985331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FCObaqAbinD7KhsOP46zwmYSxm2YKTey6+ugit7HEQk=;
 b=FkIRHVpWdvBUwzEIromriJTh37phG9d9QzoVZqtikyLv6tELHalK7+iAimzX98OfPb
 Y7xgWugLKGlQN33DrmTzjhxKrghxS6wEdqwYEDJPmtZR5p7fHyF+8lb4TFT3H0hJelIf
 Zo4C408T1Dnnbix0SGVuBkQvyaWftDprKvN2QwzAg7vNVEIbPZgeA0/Dle3eRiUzgAQt
 J+X0NwZIfHn9EkH4L7Zu8mzDSQuCvXBrj/mJYm5RNg9HWI9eQykl7p12FpP3FLK6lgQb
 l4+3H52cRvBm/aT0wDCmnCmZfp2C6dcfoMDFiBFqx3BUzCh4LoScOOBkfvsnA2aaofSk
 v7xw==
X-Gm-Message-State: AOJu0YzwnQN4WfOUJDWjvMKq4CstDPoJWOva5AIXs0scPHFJxYclU8DO
 ExdEZO5NT65ta3cLycjk5iyh8b5PigXRXkJHK68iZmRjEvvhog9dI3pLbulAXb/ntxA=
X-Gm-Gg: ASbGncuyYEOOToNtTLUbP9coY9vCL1lw5ZINwLjin5X+phH/mCKPozuEvBArWrP9TDa
 5ENUS2hgJj93c31PUPOznXA2g/goXL0F2ij8qd3m8Kx6dBqE3P6iKYSXpH2iSg6TM8t/2RADqMB
 T5AuB63tocn11wMqLd0D+DtoaikKjNq4n9qxKSJ6r2egW6reY/XS1PtIqC9KJX49znBwaYqIzA8
 wGmJyAdDViBHlMO1sVYhIv1yRCpjHazu3bWXQxv2lekHiqAffD1DqtJZPCHzm6igVtr6coqe0vX
 88gWu69zSmRE8kakRyGsa0DpgKheBa/6VmWlRHc4KuNtSBxvcPEcAYyQh2KwZqtlQSoq6hZAfyC
 CGSuRKu6tF1qKy8BXlXnoiFMHEKgHaZgbuIMBHURKUU3hDqIp2uwdF55LiTYRwG6m21ZcUKwgSi
 KW
X-Google-Smtp-Source: AGHT+IHY5ZW7slDHeduf0BbaZP7/4sghMucY8A7TA7mUGcJEP3u1zxUEoyUQhJi6FUBSJkj6jQ9LHg==
X-Received: by 2002:a05:600c:450f:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-4778fe4a05emr126134275e9.16.1763380530575; 
 Mon, 17 Nov 2025 03:55:30 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779525d2bcsm161132535e9.5.2025.11.17.03.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14AAB5F94D;
 Mon, 17 Nov 2025 11:55:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH v3 08/18] tests: move test_netdev_ethtool to share.linaro.org
Date: Mon, 17 Nov 2025 11:55:13 +0000
Message-ID: <20251117115523.3993105-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20251113102525.1255370-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_netdev_ethtool.py | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tests/functional/x86_64/test_netdev_ethtool.py b/tests/functional/x86_64/test_netdev_ethtool.py
index ee1a397bd24..ac8a92512cf 100755
--- a/tests/functional/x86_64/test_netdev_ethtool.py
+++ b/tests/functional/x86_64/test_netdev_ethtool.py
@@ -16,16 +16,10 @@ class NetDevEthtool(QemuSystemTest):
     # Runs in about 17s under KVM, 19s under TCG, 25s under GCOV
     timeout = 45
 
-    # Fetch assets from the netdev-ethtool subdir of my shared test
-    # images directory on fileserver.linaro.org.
-    ASSET_BASEURL = ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/'
-                     'download?path=%2Fnetdev-ethtool&files=')
-    ASSET_BZIMAGE = Asset(
-        ASSET_BASEURL + "bzImage",
-        "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
-    ASSET_ROOTFS = Asset(
-        ASSET_BASEURL + "rootfs.squashfs",
-        "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")
+    ASSET_BZIMAGE = Asset("https://share.linaro.org/downloadFile?id=QD37GYYAJhGOgVe",
+                          "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
+    ASSET_ROOTFS = Asset("https://share.linaro.org/downloadFile?id=YAqnr0W8fruDh3f",
+                         "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")
 
     def common_test_code(self, netdev, extra_args=None):
         self.set_machine('q35')
-- 
2.47.3


