Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246DFCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIs0Q-0006fV-PM; Tue, 11 Nov 2025 12:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzt-0005dE-VK
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:38 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzo-0003wG-6k
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:37 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so547967066b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881450; x=1763486250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPdQm12yC36NDao0BppUosTnYIa4jpYkMli2ixai1T4=;
 b=oY2HrC3PeDa9V3WcQ5rPsrLRo8xZdcTrOCT/3SavGlI2GsbV4nCJrz+HX9JSbf7xwB
 vFyK9zG4jQmaGZbJ8SrrPCBhxE3AbdEL4LP1fu3rIUvpuzt0GYTV3Em9NCN4QDhxisRW
 XlDDxFEdQOxJdzKor5OksI5NZFjWeJt6ezPtSu3Q/Tqcm//C6VsCd5QnvD2NkwuAikiC
 gU2/sy6gaOLgsRhuRX5uePy2JdwsFuv0bcegMdmypZPUVIpb3xSx4phrrID0mbu77pV/
 0Z2njYz++3+sS9oq1nif9n45IoS/qJpMlyBEL3Q4Ht1TUvFeBzbLMMPtKiJQOET6OOxz
 B8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881450; x=1763486250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OPdQm12yC36NDao0BppUosTnYIa4jpYkMli2ixai1T4=;
 b=xPUp1bwot231oqCQdepYprSjtrlxrLFoS+02ngDh06ssJpQfQ64WLV5XI8UXWJ4HJ5
 OSHHaAvaEqTHiQIWTOPvM/BFmF5LhOBR5aVLMfmz7QslnX9lMZOhwrI+i+6vzAcG+XsJ
 /4VjQCNXgTzyDHz4incTKi9GG2trJ1BP2Ac2ql5RylwiaQFgKX/1VaVjSEtz+ckXhmMX
 mW2CxA+s3FdrZRxuhCmidFD9tzRtOou6KDitLrJ+g4iyVrxmy9L1oMEygF+ZMzJRNn3p
 ZSqx3XVEai41S/ZtYQ9DnHBhc9MByF9EjFodMTPzcjZrR45BhLNKZCVjekwHHZXFXSYe
 hkNQ==
X-Gm-Message-State: AOJu0YzfoFklx9dA9iQM+jeFT/461SSGkSijYfd8sJMTxDV2sgV3NdOo
 qB+j8unOs/GF/po0WRL/YF5pIbLVTfRBg+NTAKVEciswp7x32wvMbxoektCDYE/MCjs=
X-Gm-Gg: ASbGnctRSEFOS7L1swJ5M1wysaGHdRQrquXa3D+4DpWtEIW+G+mGDyswSJBxmvVSwCd
 9Pr/75/EFsPzLicG4uZSoUvoTpz4ZuKZUxNYRyMh5N+8uOgd1TvQBMJvSsz6M+JL7/z/BO8sEIy
 PUVUdoKj3NlYDo8JvTedxY1YweVOOwgA0IEBuj6lMTSrqPL3QKp0CZsaKj8q2a0kfLXXpCkGT5p
 7UejsauCNNOBq0rKufy/rpkMTjD50Ejt0Dj/Aa2uBlkncjKwztXx6SB/SasQHL6m/tLYsCM+sSf
 oqP6VvWozWOjQbOP/MRYKkyN+U51Nb7gPXF9MLTibNt46ilQQKgoOzLlpQdPGMlKlNzMtm9GGmd
 gftamTMh2J2ehAkVbpR2i55OEQGcuVDm8pyje7xRmU6Z9/bQKIiF97DMRnN9K+31/F7QMr8KV22
 VVyrMhb88vmfA=
X-Google-Smtp-Source: AGHT+IH+rK2GA7uh5HKBO1jaj3tI3CfVnhRFhz9xjXbKspzP5ImutQx+E55V77jS1UOrApsTg4GEug==
X-Received: by 2002:a17:907:5ca:b0:b4e:b7ee:deea with SMTP id
 a640c23a62f3a-b72e031ca37mr1457232266b.27.1762881450222; 
 Tue, 11 Nov 2025 09:17:30 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf97d0f3sm1467793866b.48.2025.11.11.09.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:17:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5DB95601A6;
 Tue, 11 Nov 2025 17:17:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH 09/16] tests: move test_netdev_ethtool to share.linaro.org
Date: Tue, 11 Nov 2025 17:17:16 +0000
Message-ID: <20251111171724.78201-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111171724.78201-1-alex.bennee@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
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


