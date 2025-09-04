Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F330ECA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu57E-0000be-0D; Thu, 04 Sep 2025 04:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54r-0006Qv-Ns
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:20 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54P-00046U-UH
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b0473327e70so122729566b.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973508; x=1757578308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omV0Vr4nYXMtMeXSQYoBuMjm05IYf3r1DGykbz6eHk0=;
 b=L8B1XdrHxhtpz0AQN2KkL47ysytT/deI9iv4Al2yKsCJCCWxxu2+JW2eEhkbYOhw7H
 FeKojj0sFIyFJXTDrm0Zn9YkQ9Zg1W+m0dwnWNfyrTHQXEmbrT+9Afivi1JG2iPnVZw1
 5I+144N8+Uz8jKp8U0/vgf72FGEsnaiQCGCOgKDcEmtTRhJ2SlhkYzjAO70pKeee2xos
 nF+ltSifYn4WyDa/WDebEBlwc5iayIGThOTqAT8QybcXtLBIuavqExAI5OJjPQm6Hg7f
 TqqCf8s3iNMYF0ATIRyUOxg0ndTWNZs6dd6ISyfKgz6EtDz2FC8ehpDYFZK0buw4FT1k
 TTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973508; x=1757578308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omV0Vr4nYXMtMeXSQYoBuMjm05IYf3r1DGykbz6eHk0=;
 b=NckQdCl2zRoaDOaT9UiRhCAjQdCevw2EKf4gO+JyDPn1OVsGujvvYM7EHhpbc3RwxZ
 89juQMbcCepGCRjiR5MZB/TggEhAPvNzueb4epdtkeMBgwAXBcCRHWN2UuXL7GJJuCi3
 M4PJxDeOARDwVRCPo/N1PNTzryHBlQyv1XrqJfnAy51CEKe7912IeNcsslUafzK7d0xA
 P+XQ+3FSiwzAD5f7Tw45vWxChqwCTKr5Ku+acTRVhTsIqvY/E//DCj9q+FFDnkHdZVjh
 jnRIo+Cq+oMtsgDHwmA4gjKabq8B0py6v8EUJL1kMGLgIbBNaWz0Fk4kMaAOpQRLgAHM
 PoNQ==
X-Gm-Message-State: AOJu0YwcqMXjrQvt6YImWXdjnAqowVFZW1DL3bcIWSJRMrhzWVD3XuPh
 qUF6L3RXa+/QqIn7sxDn5wCeVIQJlPnX/B8pStlTEOiF5+FEUT10blx98vwNCVQvkPE=
X-Gm-Gg: ASbGncthAOCRZ+ewxj2aoTsiJ0+quyxOuRf0sI4QjMtOd3Yqc+aYvB4EvpzdTKyio8v
 BG9E8UXOua46tmGNWCslBx0rg5EO7pKQxTI5PGvsSaSr9QAaBV2OFvej7WgVpk9KJdabxoxojYP
 v73RZH9V7lzscog8TynGD79NreIkvCQtxPL/ne4KN8mkZuevE5hAnRxAwQ/XxGMMv1Cbjfc3uvv
 CU7Dc1s2GgonerW1c/euUaG4hMGXLUlBSc/pOX+70HBhS/oiEl7gdk5vzkOldRIc33bZR0Gzaei
 7AlYgETBKdbBUyukKpL9pVmfR0mZC46scUfu8Du6ctjajwydrtIzSvJMn+EGa9FQVBx7rnw8xUh
 olgq14TIv43Z1aIZepWgAFJc=
X-Google-Smtp-Source: AGHT+IFABY+GNZll4Er2gNXt3l+Crhs6fVMAbrNAexTY49T7TJMEwSOPjIndEkqPytMN7BQSr89N5A==
X-Received: by 2002:a17:907:3cd2:b0:afe:9777:ed0e with SMTP id
 a640c23a62f3a-b01af2e15camr1761502866b.0.1756973508120; 
 Thu, 04 Sep 2025 01:11:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b046f888b95sm275965566b.34.2025.09.04.01.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B85DB5FAA7;
 Thu, 04 Sep 2025 09:11:30 +0100 (BST)
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
Subject: [PATCH v2 021/281] tests/functional: Move hppa tests into
 architecture specific folder
Date: Thu,  4 Sep 2025 09:06:55 +0100
Message-ID: <20250904081128.1942269-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Thomas Huth <thuth@redhat.com>

The tests/functional folder has become quite crowded, thus move the
avr tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-10-thuth@redhat.com>
---
 MAINTAINERS                                                  | 2 +-
 tests/functional/hppa/meson.build                            | 5 +++++
 .../{test_hppa_seabios.py => hppa/test_seabios.py}           | 0
 tests/functional/meson.build                                 | 5 +----
 4 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 tests/functional/hppa/meson.build
 rename tests/functional/{test_hppa_seabios.py => hppa/test_seabios.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d01afcbea6d..2e1754912f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1273,7 +1273,7 @@ F: include/hw/pci-host/astro.h
 F: include/hw/pci-host/dino.h
 F: pc-bios/hppa-firmware.img
 F: roms/seabios-hppa/
-F: tests/functional/test_hppa_seabios.py
+F: tests/functional/hppa/test_seabios.py
 
 LoongArch Machines
 ------------------
diff --git a/tests/functional/hppa/meson.build b/tests/functional/hppa/meson.build
new file mode 100644
index 00000000000..a3348370884
--- /dev/null
+++ b/tests/functional/hppa/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_hppa_system_quick = [
+  'seabios',
+]
diff --git a/tests/functional/test_hppa_seabios.py b/tests/functional/hppa/test_seabios.py
similarity index 100%
rename from tests/functional/test_hppa_seabios.py
rename to tests/functional/hppa/test_seabios.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 81eaa9c218c..8f85c13d3d1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,7 @@ subdir('aarch64')
 subdir('alpha')
 subdir('arm')
 subdir('avr')
+subdir('hppa')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -78,10 +79,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_hppa_system_quick = [
-  'hppa_seabios',
-]
-
 tests_i386_system_quick = [
   'i386_migration',
 ]
-- 
2.47.2


