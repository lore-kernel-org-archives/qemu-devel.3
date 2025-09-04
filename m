Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8B3CA101C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu58I-0001kD-2i; Thu, 04 Sep 2025 04:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54x-0006VT-EB
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:25 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54S-00047t-Us
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:20 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b046f6fb230so120587266b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973511; x=1757578311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEFayKNVFnXVPmO4dwPqIX/9FJE7mupFd4n+Gsn2REk=;
 b=xIysAJawZH2S/b/ZwjoTNypa7PX0e/hdZanQpKKNjZ8Qfj9YLOcWqEk0WrnV3N+B9E
 c1dHlYamxVUxCZioGHpCl3HQyKIUJVppHYzT3gGp/1c9JN7E0F6Nx8Wt9rT6ln56N0R4
 s7ZH+V6uxtMHfASO4Bw4iKKf48MDIUpEg6PHrRiXfCMCmZA9zByt9/Wz9r40Q5Np24sA
 Z4YqU4pfz8Del6nClxtRjL/ezCyvoA5xD/KYuenHs9a7KXBd5we+cm0O4yjUEpi9ozTv
 fCpvpy2UCgBHlTgF1HS1No4XzYx08Cdi7z9a8+w5DB0O0QyaXYAUi9LZsPDsoFYygHBo
 lS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973511; x=1757578311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEFayKNVFnXVPmO4dwPqIX/9FJE7mupFd4n+Gsn2REk=;
 b=NGpns6rNmTkds7sNv066lY4SztuGzwg6suwLJ/X6VMdBAUuVRGlKZgsH2EUqHb7wks
 ZF/6B1xihFviJbpq9w+3y7gMDfwQE6leYooYqf0HxtHLii1sygpz+p9AjrdYO7cxcdzx
 WJc0tHPYUwNqUgrQYRnNtvFDBBMlTe9pms8/NoHz8EPvg6qDxOTcGxjwImDkt7baSHOm
 utvPyU8pMJJGbUI+jM4Ss3ejkxTSz8NMCGIotn6TALBuRgPmCcrUsjk42QHxO3XVGB31
 aHD12qymT00rFSsbCrfOn8r3a3DBQtTqhgYxnjU11TW2kXDI+3yT1u03oTRa/lRwu6sm
 hpjg==
X-Gm-Message-State: AOJu0YyHbwVN24p5p8zoqkAN+gv3R+BeJiV7j7ykIigF3Jwjj/PHMwuX
 B5Kn6HRk0gWJUUVbXWov8PNGaAW8bDnZQWaosbOjQ0g4kzIGo0sQyX2OBubT360yy1o=
X-Gm-Gg: ASbGncuO28SeG8aleF6yzyvIFxbaFerYGq7L9KfrL462OGVlf6EtDThQ3cYvEKmv8Yu
 fALMP6SqNKv8RPWgU/glaimeSnGFSL0DU0xeY1G0IuonnG9It/6E2CTUreXMikpV31GhiFS57xK
 4PsBSVyd9pEopHeJb+rIeavUv+wnw9noG7beHOTvvHmdoA4kPMVrKs7Asy8v5Tp2GzPsk042vvy
 fUMCthiPT7u0wiEBSRnQMBhdkDxS0FsugNMpAuuD9tduFSj3z3duPEUR4huT6FwtbMJtTSomQeo
 1V7kCZHnGnmy8g0XW3Kh1e7IUuU/MzYZekPE4elbqPb9wRCtpoz1U5Z0xNlbjQ0PS4BHuM/pShu
 olhLopCa/Qj21Eo9o2vGQDXY=
X-Google-Smtp-Source: AGHT+IFGA6yysX5rYii0EXHOc7wdrviuB8wTGOuSTKIEOmP0UAztX9Mp/wwZz0qOsZ6RV/4aH8D/dw==
X-Received: by 2002:a17:907:7241:b0:b04:38f2:9060 with SMTP id
 a640c23a62f3a-b0438f29593mr1159240066b.18.1756973510632; 
 Thu, 04 Sep 2025 01:11:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0426516668sm972126766b.46.2025.09.04.01.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2137060046;
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
Subject: [PATCH v2 032/281] tests/functional: Move sh4/sh4eb tests into
 target-specific folders
Date: Thu,  4 Sep 2025 09:07:06 +0100
Message-ID: <20250904081128.1942269-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
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
sh4 tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-21-thuth@redhat.com>
---
 MAINTAINERS                                       |  4 ++--
 tests/functional/meson.build                      | 15 ++-------------
 tests/functional/sh4/meson.build                  | 10 ++++++++++
 .../{test_sh4_r2d.py => sh4/test_r2d.py}          |  0
 .../{test_sh4_tuxrun.py => sh4/test_tuxrun.py}    |  0
 tests/functional/sh4eb/meson.build                |  5 +++++
 .../{test_sh4eb_r2d.py => sh4eb/test_r2d.py}      |  0
 7 files changed, 19 insertions(+), 15 deletions(-)
 create mode 100644 tests/functional/sh4/meson.build
 rename tests/functional/{test_sh4_r2d.py => sh4/test_r2d.py} (100%)
 rename tests/functional/{test_sh4_tuxrun.py => sh4/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/sh4eb/meson.build
 rename tests/functional/{test_sh4eb_r2d.py => sh4eb/test_r2d.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a55a20f6a5..eddec0058e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1736,8 +1736,8 @@ F: hw/pci-host/sh_pci.c
 F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 F: include/hw/timer/tmu012.h
-F: tests/functional/test_sh4*_r2d.py
-F: tests/functional/test_sh4_tuxrun.py
+F: tests/functional/sh4*/test_r2d.py
+F: tests/functional/sh4/test_tuxrun.py
 
 SPARC Machines
 --------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index abaa4e00fca..ce713509e32 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -30,10 +30,8 @@ subdir('riscv32')
 subdir('riscv64')
 subdir('rx')
 subdir('s390x')
-
-test_sh4_timeouts = {
-  'sh4_tuxrun' : 240,
-}
+subdir('sh4')
+subdir('sh4eb')
 
 test_x86_64_timeouts = {
   'acpi_bits' : 420,
@@ -56,15 +54,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_sh4_system_thorough = [
-  'sh4_r2d',
-  'sh4_tuxrun',
-]
-
-tests_sh4eb_system_thorough = [
-  'sh4eb_r2d',
-]
-
 tests_sparc_system_quick = [
   'sparc_migration',
 ]
diff --git a/tests/functional/sh4/meson.build b/tests/functional/sh4/meson.build
new file mode 100644
index 00000000000..56f824e1e71
--- /dev/null
+++ b/tests/functional/sh4/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_sh4_timeouts = {
+  'tuxrun' : 240,
+}
+
+tests_sh4_system_thorough = [
+  'r2d',
+  'tuxrun',
+]
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/sh4/test_r2d.py
similarity index 100%
rename from tests/functional/test_sh4_r2d.py
rename to tests/functional/sh4/test_r2d.py
diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/sh4/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_sh4_tuxrun.py
rename to tests/functional/sh4/test_tuxrun.py
diff --git a/tests/functional/sh4eb/meson.build b/tests/functional/sh4eb/meson.build
new file mode 100644
index 00000000000..25e9a6e4041
--- /dev/null
+++ b/tests/functional/sh4eb/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_sh4eb_system_thorough = [
+  'r2d',
+]
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/sh4eb/test_r2d.py
similarity index 100%
rename from tests/functional/test_sh4eb_r2d.py
rename to tests/functional/sh4eb/test_r2d.py
-- 
2.47.2


