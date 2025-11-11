Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8530CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIs0R-0006kc-BF; Tue, 11 Nov 2025 12:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzv-0005eM-6N
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:39 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzo-0003wo-Sg
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:38 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso2668466b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881451; x=1763486251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZMwWbtKQTc6Q3ZtN4h7bVMTPaVkNFFvuf+COb9bjfU=;
 b=vJGcYHSAS9KJSdhtYLbojz1kY8w0szNj/rc93Y0qFdTHTZKkZ1iebqyKH5oOKU1ZaQ
 xwEO7sQ/mS1IUD5nMDPQnJDBEgraoAsuJldj41JHahU4UJU9+/yDGENNp1PmL6wOlfm7
 AiLSsZ9ZIQYVv/tqpTZAFm9EOUgqlKUo+7+FRgNCtyU2nxEhRLnRpxiYt6ijr1d0INf3
 9AqNMSXWc/PWiPXQVrc46BFqnXTjRAs7H9ijfDuK7K5xz6krN26otZSXaYL0lfIBGYXq
 YfmWOniq5TEP9Zy0knfJbEddxG009V2AtI0kQb0cifDq70HEgcdDjuSRjTbd7f2ey7dU
 wdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881451; x=1763486251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nZMwWbtKQTc6Q3ZtN4h7bVMTPaVkNFFvuf+COb9bjfU=;
 b=Z/PFfv2w9VfpZkKRYzWYaLUZOuSfFFabwVC0GGFsnRWB//+jSQ+AC5q43qQJs/Sb44
 KG9hT+CxWEk92x7TXQSFvBy2pS4WONmOeBzeHbkAM+KY15mbPWJW1PTNwCvUUhpqin9g
 KMupwzK2nxOFB50Fm7r6osssOUsDmtn41s/AjIAmJ0QkrVsAb2PULr+kBUEyWRU4nfmD
 JXbJztYzXGJzdcOwjczVWxZ+BHIoowUPHHatqOI1p742xhWp10QG6/YfELWvtoU4p/nr
 AZCZtqyUmgSNbGpGPNq1/V6x6zftvkcGkwRgDFiN76GaMjA8ia1eNOhGpEhSrpCajD0e
 XHiQ==
X-Gm-Message-State: AOJu0Yx1wHTAcJZBO4WLD4LI2hQBPUVCS5/TxuaZRvhlGnIw7DMvAjjB
 sNkjjv+DR6ADqgHeA6B19N0cR2rbCP+amTDK5AoFIaGOX6ix8WkFY5GY6Kobqz7xqt4=
X-Gm-Gg: ASbGncsvxmxCEANexlrovbdipkk7gRgnpdTBEnNLkomk284AYCIf5IpIvO5hsVn0JVa
 /mdKf5N0iK8Jv/rAUbyS5ylfmBEbAUzgGZ9t7bCnA0+IblyaRJpFR5vvEPFXYePNWsQUBm/IsW1
 6gxNPDGJcoCmurM86wXirwdemjLu795Y0yfC8CyUM/R8Ud+KTHJk+lqaRTRzUDSi+Ax2Bj5uXCT
 nEr3ntG9LXC1cmDj4oMdwDdPDCgCva1SF3+swyT0FFqW7az3Dy8Ks4FSTodljFexW0B047TajGL
 4gpjlKiFaMM1m1YM4O0PnLn8KRS7uVJOrlRedG0R7StQRrSJWETxhwQoJuSBkKL3/vYvBse7OKW
 e3GEN3aIY6kZUWjf5RNKu/g3h2Yi+uCZVAPW4K9yvE5YpgCQM8pXVkl9npNdBEaLzCFUNK4eFBE
 6fThx5ZCazMWU=
X-Google-Smtp-Source: AGHT+IHpNAt2V8+AORBuuAqUyA75hRz+rrrEjKiJpRx/I98f+26R4Gbnm5i7A58XG2tYPLuzU5R85A==
X-Received: by 2002:a17:907:2687:b0:b0e:d477:4972 with SMTP id
 a640c23a62f3a-b72e031a2famr1319077666b.25.1762881450948; 
 Tue, 11 Nov 2025 09:17:30 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72dbe7c783sm1130913566b.50.2025.11.11.09.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:17:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2ED165FAED;
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
Subject: [PATCH 07/16] tests: move test_xen assets to share.linaro.org
Date: Tue, 11 Nov 2025 17:17:14 +0000
Message-ID: <20251111171724.78201-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111171724.78201-1-alex.bennee@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 tests/functional/aarch64/test_xen.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/functional/aarch64/test_xen.py b/tests/functional/aarch64/test_xen.py
index 261d796540d..f7bde5859ec 100755
--- a/tests/functional/aarch64/test_xen.py
+++ b/tests/functional/aarch64/test_xen.py
@@ -25,8 +25,7 @@ class BootXen(LinuxKernelTest):
     XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
 
     ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-         'download?path=%2F&files=linux-5.9.9-arm64-ajb'),
+        ('https://share.linaro.org/downloadFile?id=RRahAWwAwYKTZQd'),
         '00366fa51ea957c19462d2e2aefd480bef80ce727120e714ae48e0c88f261edb')
 
     def launch_xen(self, xen_path):
@@ -55,8 +54,7 @@ def launch_xen(self, xen_path):
         wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
 
     ASSET_XEN_4_11 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb'),
+        ('https://share.linaro.org/downloadFile?id=ALU4n2NGGYbE4fO'),
         'b745c2631342f9fcc0147ddc364edb62c20ecfebd430e5a3546e7d7c6891c0bc')
 
     def test_arm64_xen_411_and_dom0(self):
@@ -66,8 +64,7 @@ def test_arm64_xen_411_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_14 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb'),
+        ('https://share.linaro.org/downloadFile?id=os4zSXPl7WW4lqX'),
         'e930a3293248edabd367d5b4b3b6448b9c99c057096ea8b47228a7870661d5cb')
 
     def test_arm64_xen_414_and_dom0(self):
@@ -77,8 +74,7 @@ def test_arm64_xen_414_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_15 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-upstream-4.15-unstable.deb'),
+        ('https://share.linaro.org/downloadFile?id=jjjG4uTp2wuO4Ks'),
         '2a9a8af8acf0231844657cc28baab95bd918b0ee2d493ee4ee6f8846e1358bc9')
 
     def test_arm64_xen_415_and_dom0(self):
-- 
2.47.3


