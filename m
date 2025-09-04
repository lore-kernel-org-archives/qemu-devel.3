Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612C0CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu58n-0003H3-44; Thu, 04 Sep 2025 04:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu550-0006Wh-7l
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:29 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54V-00049h-6O
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:25 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afeec747e60so137366766b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973513; x=1757578313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtgYk8tL09X7evEehKpRVdQ+nFs0oLJoTM08eLIHHIc=;
 b=f8UdJ4yA7QIyJlZ/xSU9PRHA1RfjCZLZ1pO4SoGUSiGbInnsupUv2ROht8EDM6LZwd
 NtbMMdqJ9IA6OSBMyOJmWMs1iNKd9OcMdkHqHxR4t8gHHDzsjRQX8MfOICRVm5sDH9Dj
 DO7MwUSIWpNUrxel3bKb34ohR+1XniY1dJQ+UM/LWmyt7ZbMH0ftlY3Yw2AbpOv/14w1
 r3LEie+Czje8TUT5J5+dTQANX7ZUeG51JSVmKivvnDOnFRzLz5ZJ241nuxIFItbfnmqq
 29ngHZSyY/W4QRdotkwNJMC80i0OGxqMr1lOzWL8Wzuy62nZyNtchVllUno4MxpDoUuj
 nUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973513; x=1757578313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtgYk8tL09X7evEehKpRVdQ+nFs0oLJoTM08eLIHHIc=;
 b=n6B3HxbK0b1vs61vRA58o55XWbsc2RY5jplUgCtDNsmrWeECfLDjot0ouQwIuSu64V
 ewb93x+AgyIsA+D/fvUWVRjkQZ6P8vSS3K/j6z+y++CFzZ6EIZb9dAvagEnUfGNdHlnQ
 TZc5qLmCHM2s1riRzXSIjmN0yXO2raTnpVQFnN5gMxn9j9SxA9wwanNsMmu/JvNeoIXu
 +R+N1OT1Zo2bn6mO5/72aq1SS8qPAS4b9ZP4j1dbsmyeAFTbN/AHwdG5DAVbeOPeH433
 NG+BJXNhIMsyYj9grHcJJF7+sSI/HYYX+QVg6nSZUgAfrLKR1If3GUrdZLIRXiX24wbR
 VeEA==
X-Gm-Message-State: AOJu0YwrX7cuk5m0fnafhI5HcdZOIvhd0RX46kLlbPvCAiYGGZN/QnD0
 REFoSUmnLNFg2NRlTVF74lAd0OMKizHPBa2lhMbmbxoFLhQDyscePbJJ8ocaKh6k8Vp8tLKMDKb
 HrJ9jQYNOYQ==
X-Gm-Gg: ASbGnct2mseF1qHW8PuvGrarGNemyaKumKgKAVO2leqkQutuueY32VPt0SdrGEN00CB
 l0KGmS+KrrVYGsq+Qnwdfl/+iMAkGb7FhQBZV4Z/ZFSeA5W+WIDzUPf+35jctbTtvkKjFXaTLS2
 UOFVkR5iCNES/P5g7nASuPOgXKM+6Rl415xqnWNln+Euxb3oik5OyWAs8aCBU6CN8KselTCgz6G
 Nls0JxcPwhbLpkcaUEYy5EKGqMTp/wD8fJH8M+HqTL3GD/CQ+GOjctyGTt4NLBGp1VE1SBmyCIL
 AsBSc4t/lPXclGoSGJI4VfUARwckB8HxgjWJ/8d8I7jz+1KX77hq7kMkvPqkZkXezgdm2m640cq
 9ZgCjjmQHaqel84/z24lUITo+6KtQg4xqsjCD+kaccnFw
X-Google-Smtp-Source: AGHT+IGYskyBYR3n5Q9uI+8AP0+1GXixN328LvmrggmBgoiP7mVHjL06ko8pn8Trl6ZXEys7FI6f0Q==
X-Received: by 2002:a17:907:daa:b0:b04:8420:b6ef with SMTP id
 a640c23a62f3a-b048420c5b0mr91846366b.61.1756973513129; 
 Thu, 04 Sep 2025 01:11:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b017e4b9ed7sm1280476466b.90.2025.09.04.01.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02D196000B;
 Thu, 04 Sep 2025 09:11:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 031/281] tests/functional: Move s390x tests into
 target-specific folders
Date: Thu,  4 Sep 2025 09:07:05 +0100
Message-ID: <20250904081128.1942269-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
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

From: Thomas Huth <thuth@redhat.com>

The tests/functional folder has become quite crowded, thus move the
s390x tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-20-thuth@redhat.com>
---
 MAINTAINERS                                         |  6 +++---
 tests/functional/meson.build                        | 13 +------------
 tests/functional/s390x/meson.build                  | 13 +++++++++++++
 .../test_ccw_virtio.py}                             |  0
 .../test_pxelinux.py}                               |  0
 .../{test_s390x_replay.py => s390x/test_replay.py}  |  0
 .../test_topology.py}                               |  0
 .../{test_s390x_tuxrun.py => s390x/test_tuxrun.py}  |  0
 8 files changed, 17 insertions(+), 15 deletions(-)
 create mode 100644 tests/functional/s390x/meson.build
 rename tests/functional/{test_s390x_ccw_virtio.py => s390x/test_ccw_virtio.py} (100%)
 rename tests/functional/{test_s390x_pxelinux.py => s390x/test_pxelinux.py} (100%)
 rename tests/functional/{test_s390x_replay.py => s390x/test_replay.py} (100%)
 rename tests/functional/{test_s390x_topology.py => s390x/test_topology.py} (100%)
 rename tests/functional/{test_s390x_tuxrun.py => s390x/test_tuxrun.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6410a5f5fd..4a55a20f6a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1797,7 +1797,7 @@ S: Supported
 F: hw/s390x/
 F: include/hw/s390x/
 F: configs/devices/s390x-softmmu/default.mak
-F: tests/functional/test_s390x_*
+F: tests/functional/s390x
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
@@ -1811,7 +1811,7 @@ F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: docs/devel/s390-dasd-ipl.rst
-F: tests/functional/test_s390x_pxelinux.py
+F: tests/functional/s390x/test_pxelinux.py
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
@@ -1865,7 +1865,7 @@ F: hw/s390x/cpu-topology.c
 F: target/s390x/kvm/stsi-topology.c
 F: docs/devel/s390-cpu-topology.rst
 F: docs/system/s390x/cpu-topology.rst
-F: tests/functional/test_s390x_topology.py
+F: tests/functional/s390x/test_topology.py
 
 X86 Machines
 ------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7e7a6aa0c93..abaa4e00fca 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -29,10 +29,7 @@ subdir('ppc64')
 subdir('riscv32')
 subdir('riscv64')
 subdir('rx')
-
-test_s390x_timeouts = {
-  's390x_ccw_virtio' : 420,
-}
+subdir('s390x')
 
 test_sh4_timeouts = {
   'sh4_tuxrun' : 240,
@@ -59,14 +56,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_s390x_system_thorough = [
-  's390x_ccw_virtio',
-  's390x_pxelinux',
-  's390x_replay',
-  's390x_topology',
-  's390x_tuxrun',
-]
-
 tests_sh4_system_thorough = [
   'sh4_r2d',
   'sh4_tuxrun',
diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
new file mode 100644
index 00000000000..030b116039c
--- /dev/null
+++ b/tests/functional/s390x/meson.build
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_s390x_timeouts = {
+  'ccw_virtio' : 420,
+}
+
+tests_s390x_system_thorough = [
+  'ccw_virtio',
+  'pxelinux',
+  'replay',
+  'topology',
+  'tuxrun',
+]
diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
similarity index 100%
rename from tests/functional/test_s390x_ccw_virtio.py
rename to tests/functional/s390x/test_ccw_virtio.py
diff --git a/tests/functional/test_s390x_pxelinux.py b/tests/functional/s390x/test_pxelinux.py
similarity index 100%
rename from tests/functional/test_s390x_pxelinux.py
rename to tests/functional/s390x/test_pxelinux.py
diff --git a/tests/functional/test_s390x_replay.py b/tests/functional/s390x/test_replay.py
similarity index 100%
rename from tests/functional/test_s390x_replay.py
rename to tests/functional/s390x/test_replay.py
diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/s390x/test_topology.py
similarity index 100%
rename from tests/functional/test_s390x_topology.py
rename to tests/functional/s390x/test_topology.py
diff --git a/tests/functional/test_s390x_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_s390x_tuxrun.py
rename to tests/functional/s390x/test_tuxrun.py
-- 
2.47.2


