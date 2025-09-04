Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63484CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu55w-0007TI-Cy; Thu, 04 Sep 2025 04:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54g-0006N4-5q
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54K-00043D-UC
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-afcb7ace3baso137843366b.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973503; x=1757578303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFEhhh8NSACPPy03lAUeW1WvXOIqiNIP9Gmw/5CKVpI=;
 b=pzzLfY7qD0RusmvLWQi6qIhUK5qTZsgYjX90c6w9sYL/esVsGSUkzXzx7KaxQU7BtW
 K5oeSQT/cL6nFA0fhgbaWuVZ2no3RwcrVuqTRiDe+bJ4c2Q6D0z/4xTJaQVpL4fchrFf
 EqBlig8boICIE7nUoodDs5pS2WwudMzre2Yo6DPiyn10nhC62GflOvV1BH5klfXwhwn5
 6liX4HuWMjmWIEqVfRS9Hd7wi10Y4MTCM1KCVNvD0ZY7ROPXytjYm/IY+awMEgacwZ3J
 gy1NycRCgUu6p01kSm0hhtGLH0xxK8luqkAWuAsiABpabKMooNOzBlYSbhcv32O1vKb3
 RwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973503; x=1757578303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFEhhh8NSACPPy03lAUeW1WvXOIqiNIP9Gmw/5CKVpI=;
 b=tw2ufiXRDTaVRIRFmwhXIueG7qaKT4MJZvTAKeL9VkZSFvvmktPnzisAoXq5sobFEH
 nuRzSe0JGcofQ4Y0kjb8us5JCza1kBSztbVPRrexpDvXMUNPZ2LOoS9sRLKN1NAQBgNQ
 omzMUKxHesBw3K6hFcS333sKKTjBjP7MW8smQvAXK/O1F4fhsKeAvdBdhIfDqaVMt2z0
 QxpD7OaJPlGrWmN9WWVgCHH6nmv/bUPXUYnmHJSLcTEzxqNUNJwLvRG67CPZH6Gvhnck
 LyDNmggeOE1oihhChZOOfNJzdOnAsAfHu7pkgcNvp39AVqe+8RoMcJvdKFbUr6M0SZOV
 QWfg==
X-Gm-Message-State: AOJu0Yxk4eFZtIZz9kS0keI3ERiIIgUmr/Fd8joOQnpIpLBXughw+19h
 QfNcshd/BiEDGpoQhg2F4jdJ7Kd8WueKtLKoT9LNZ6Jm3DCiyieupH2U14pgN09GBWo=
X-Gm-Gg: ASbGnctmDXtDurZnhcLJv9IKmPm1WsuJwspmhQp+iOEb1cdZliuYPDbwA2wZwyY46vh
 8PL7sCjbUNfuWznXja6o1Y+cg9Kiy2K3Kyk0eVHN6wHLwlS5OsWXDZx08BTWKURQX2jRiPqMNWM
 T62GBgayJRlao67rAxRsH2EshsxhRtChbi4wAb7dxdGqqTvCK8VpD2BijniX/lmPFWiWDsQbb1x
 NBD6hAEAF0Ib7f+a+++dIO4a3bKwALJZMHgNor/TcHtfGePeR6VKUceHshecfYO9pY57Xt9JXx3
 fxFtama9Xrolp6aaOfSijpPKi9OkKgqVgEMMLN0oGvBg0/I/CHo32vWuPyJn9xzixPX8uZ/s599
 a4pZ0CLE6pUW9Og9uju8d5ZUS4Fp66dXhzA==
X-Google-Smtp-Source: AGHT+IFlmoTtWtJZg3Geb0kfl+Z+ucuFEHRktCaxjXa7c0bTRextSI2xhSOy4rmatDTUkMpDVjITog==
X-Received: by 2002:a17:907:3e8f:b0:b04:6c19:ed8d with SMTP id
 a640c23a62f3a-b046c19eea9mr457804566b.26.1756973503102; 
 Thu, 04 Sep 2025 01:11:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4e50fbsm13438274a12.38.2025.09.04.01.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F0D1B5FA1B;
 Thu, 04 Sep 2025 09:11:29 +0100 (BST)
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
Subject: [PATCH v2 015/281] tests/functional/meson.build: Split timeout
 settings by target
Date: Thu,  4 Sep 2025 09:06:49 +0100
Message-ID: <20250904081128.1942269-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

We are going to move these settings into target-specific subfolders.
As a first step, split the big test_timeouts array up into individual
ones.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-4-thuth@redhat.com>
---
 tests/functional/meson.build | 50 +++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 38ae0d6cd3b..356aad12dee 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -10,7 +10,7 @@ if get_option('tcg_interpreter')
 endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
-test_timeouts = {
+test_aarch64_timeouts = {
   'aarch64_aspeed_ast2700' : 600,
   'aarch64_aspeed_ast2700fc' : 600,
   'aarch64_device_passthrough' : 720,
@@ -25,7 +25,9 @@ test_timeouts = {
   'aarch64_tuxrun' : 240,
   'aarch64_virt' : 360,
   'aarch64_virt_gpu' : 480,
-  'acpi_bits' : 420,
+}
+
+test_arm_timeouts = {
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
   'arm_aspeed_witherspoon' : 120,
@@ -44,24 +46,55 @@ test_timeouts = {
   'arm_replay' : 240,
   'arm_tuxrun' : 240,
   'arm_sx1' : 360,
-  'intel_iommu': 300,
+}
+
+test_mips_timeouts = {
   'mips_malta' : 480,
+}
+
+test_mipsel_timeouts = {
   'mipsel_malta' : 420,
   'mipsel_replay' : 480,
+}
+
+test_mips64_timeouts = {
   'mips64_malta' : 240,
+}
+
+test_mips64el_timeouts = {
   'mips64el_malta' : 420,
   'mips64el_replay' : 180,
-  'netdev_ethtool' : 180,
+}
+
+test_ppc_timeouts = {
   'ppc_40p' : 240,
+}
+
+test_ppc64_timeouts = {
   'ppc64_hv' : 1000,
   'ppc64_powernv' : 480,
   'ppc64_pseries' : 480,
   'ppc64_replay' : 210,
   'ppc64_tuxrun' : 420,
   'ppc64_mac99' : 120,
+}
+
+test_riscv64_timeouts = {
   'riscv64_tuxrun' : 120,
+}
+
+test_s390x_timeouts = {
   's390x_ccw_virtio' : 420,
+}
+
+test_sh4_timeouts = {
   'sh4_tuxrun' : 240,
+}
+
+test_x86_64_timeouts = {
+  'acpi_bits' : 420,
+  'intel_iommu': 300,
+  'netdev_ethtool' : 180,
   'virtio_balloon': 120,
   'x86_64_kvm_xen' : 180,
   'x86_64_replay' : 480,
@@ -404,6 +437,11 @@ foreach speed : ['quick', 'thorough']
                                build_by_default: false,
                                env: test_precache_env)
       precache_all += precache
+      if is_variable('test_' + target_base + '_timeouts')
+        time_out = get_variable('test_' + target_base + '_timeouts').get(test, 90)
+      else
+        time_out = 90
+      endif
 
       # Ideally we would add 'precache' to 'depends' here, such that
       # 'build_by_default: false' lets the pre-caching automatically
@@ -419,8 +457,8 @@ foreach speed : ['quick', 'thorough']
            env: test_env,
            args: [testpath],
            protocol: 'tap',
-           timeout: test_timeouts.get(test, 90),
-           priority: test_timeouts.get(test, 90),
+           timeout: time_out,
+           priority: time_out,
            suite: suites)
     endforeach
   endforeach
-- 
2.47.2


