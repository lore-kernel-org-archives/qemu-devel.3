Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB3CC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfI-0002Tf-9W; Tue, 30 Apr 2024 12:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf2-0002O9-KQ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:56 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qew-0005cV-CE
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:56 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2de2f5ca076so67908451fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495729; x=1715100529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=etAp6WZx3h8E7CdT4MY1xTM+Yr9ybGh3o76qjoMWZ7I=;
 b=EAn1tIRbHHPifbTloLjokwlt8L0/YnteFZOglwE7gk6DVDXQYXsYvx9Bo5JTyPUAq0
 1PFhQm1TpXtV0sozpt4YvcLmeSWyitNtR+LyyrDGh3Ff74p+D6FI12ENYGAnJx7imYgU
 G9NYaQ7dFL2m8dlwiKoV/IoiQMCpXdapOcqeoM4nlIKT5Hieoj2wc/lLM5SqTty80D/i
 vetjS/m2uITjW2ELo0X6htxcgkp7BNq9ArRjyRKX4m1/pY4z2rTc93PAgCksYZGY5J0K
 3Vg2mnSGgOlYr0vSr34TUgonbQq/joDNkidTCZTqIHGQbBdzHhkHtrubfY+eFTko/7SK
 1RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495729; x=1715100529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etAp6WZx3h8E7CdT4MY1xTM+Yr9ybGh3o76qjoMWZ7I=;
 b=NWLVu8dnbN1s65iFwG/4v5JclEcmInhyOXF9ddF7eybgpCXPIptqapPGrB1xJx2oTD
 xmkJRzentI+JQJoCC+Z4s1Nmta1QxYN87MmDoAcyJvP98zKnCDIBlg5p0bcGPUfP6PBd
 8iIUpMQQGMmDjKqZ2rUQummUHHcs1Kyl207af3wmWwg97KwRPIJ87fFegB5ljifpwx+X
 bBrpCGi7RPvKSVN+4QAnb8CUZHGGHH994iiD1jD7Tk9d31R1Zz80Scz9yjLOCoAwyr1l
 5lkAYMREkcImsSK24IwW4LuicUOKj4XpeMx2Dyzjyqu3q3jmwHI2nCtPzIELTIIyr6wR
 Xt5g==
X-Gm-Message-State: AOJu0YzJf5/QPE1ZsJzmHqEcffRDgmUHFCdMZ0utgd6pXY75RuWqdiNR
 SYMAnuPZP72rj8yy2S2rD6svD+VIeKyV0cy6BBmwIm9Ytkks0Qo8zfla58tp8aKfdFuZQ3FwLhI
 P
X-Google-Smtp-Source: AGHT+IESMWhT1ql19q9o0XQ+ynjxz1EL7+sQAo+D39ZQs0PYRpLLw2g80SbwuPrzZZwXP2WfmK1oEg==
X-Received: by 2002:a2e:b611:0:b0:2dc:bd10:2944 with SMTP id
 r17-20020a2eb611000000b002dcbd102944mr111053ljn.53.1714495728637; 
 Tue, 30 Apr 2024 09:48:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/21] tests/avocado: update sunxi kernel from armbian to 6.6.16
Date: Tue, 30 Apr 2024 17:48:30 +0100
Message-Id: <20240430164842.4074734-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

The Linux kernel 5.10.16 binary for sunxi has been removed from
apt.armbian.com. This means that the avocado tests for these machines
will be skipped (status CANCEL) if the old binary isn't present in
the avocado cache.

Update to 6.6.16, in the same way we did in commit e384db41d8661
when we moved to 5.10.16 in 2021.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2284
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20240415151845.1564201-1-peter.maydell@linaro.org
---
 tests/avocado/boot_linux_console.py | 70 ++++++++++++++---------------
 tests/avocado/replay_kernel.py      |  8 ++--
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 180ac17326e..c35fc5e9ba2 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -646,12 +646,12 @@ def test_arm_cubieboard_initrd(self):
         :avocado: tags=accel:tcg
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
@@ -690,12 +690,12 @@ def test_arm_cubieboard_sata(self):
         :avocado: tags=accel:tcg
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
@@ -872,13 +872,13 @@ def test_arm_bpim2u(self):
         :avocado: tags=machine:bpim2u
         :avocado: tags=accel:tcg
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
-                   'linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
 
@@ -899,13 +899,13 @@ def test_arm_bpim2u_initrd(self):
         :avocado: tags=accel:tcg
         :avocado: tags=machine:bpim2u
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
-                   'linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
@@ -946,13 +946,13 @@ def test_arm_bpim2u_gmac(self):
         """
         self.require_netdev('user')
 
-        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
-                   'linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = ('/usr/lib/linux-image-current-sunxi/'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = ('/usr/lib/linux-image-6.6.16-current-sunxi/'
                     'sun8i-r40-bananapi-m2-ultra.dtb')
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
@@ -1049,12 +1049,12 @@ def test_arm_orangepi(self):
         :avocado: tags=accel:tcg
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
 
         self.vm.set_console()
@@ -1075,12 +1075,12 @@ def test_arm_orangepi_initrd(self):
         :avocado: tags=machine:orangepi-pc
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
@@ -1121,12 +1121,12 @@ def test_arm_orangepi_sd(self):
         self.require_netdev('user')
 
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
                       'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 2c81412dbad..232d287c272 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -203,12 +203,12 @@ def test_arm_cubieboard_initrd(self):
         :avocado: tags=machine:cubieboard
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
-        deb_hash = '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
+                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
+        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-5.10.16-sunxi')
-        dtb_path = '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
-- 
2.34.1


