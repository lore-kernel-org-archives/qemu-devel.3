Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E61D78797
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAW3-0004sa-AB; Thu, 21 Nov 2024 11:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVc-0004af-FB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVR-000804-6n
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:23 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so9434465e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208292; x=1732813092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxsyHUj0CjMAJckEMjfPh5iL1r4gSQpQMh/4JVL/FpM=;
 b=TVw1RAAdkmIVxDk2qaRteHdksauV2Hx8LTy494uHuv6I2tlpSC61l3ewGt898NKUp9
 +HmZ7biyynRKCiPxI66c7dnokhiS3dp6nD4h4RY9lfzgtpVOj3+ET0RW+sB5skSPkhVJ
 lXyZ42gfE8oq8oZ8keqm9Bpr8nGUbmxtD7uixWqdkZwpcIKRqPsOBMCrzb6WgXjz4tTS
 tqBZ+Ht7oy/+coL95Y2AnKlZ6MIsVpb2/PTwQvp8s4MKYN+srxWwIa9L8I5Bz8dmI+K+
 i2Bj7wLY1nz4B00U1zWNqXHu124zbxxk8qpcz493RbiP5BJkJfyfQhQuGLu+jT467Dsh
 vxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208292; x=1732813092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxsyHUj0CjMAJckEMjfPh5iL1r4gSQpQMh/4JVL/FpM=;
 b=cVbeAStF8DZtMzhaRslbfYeaoJeEJobLbzT6kOUw3m8q6XAdnKjWwR7vQn0n59nt8Q
 W+TDnHrhZ3hZYwj0IrwVqJycDTy67a0W1dPpre9KQXnQOD8x6j0t5Ylkp1mygXnQZNHQ
 BR4FaVAv6hPGJSXkyrjOCA3WhH29fGVT6WKTbF58ilfBqx7NCYuqYVvjpZfHQM9JBtlN
 OpMCBZY0DfX6zEawLlK9oDjb1um8Su89ON4o0/EtIfnOMteUQ12xyxXCobnzlj39EIQ6
 BUJbT1efmkZUSKGJ2smPToQbRWdyjG89byyNOm+GSq/O/bEkv1ebw8iusTdJ8upQgsXS
 R1qQ==
X-Gm-Message-State: AOJu0YxWVpbYhfng2fJQzW5CHg92vXrwPMKgmSAr65EPrwZ9wGqV0W0w
 HxhuO17Px+OC2Jr517hTN0t0uvuDpG0zEdXLMMjL+rzfyTpMu4bF0O29FKf5EuM=
X-Gm-Gg: ASbGnctzc1mwQhbEcrFQFPY51ED/niZD0b1k6l0KmGMnXFvC7GlxucAi9M9IggeUcZb
 sP5N2h1HtjjUcKlnr53ZKfYWdQHdwDJL4Ybf0fFwtod25cVghEfrZiIyjpE8538YoEsySSyTCTw
 AWYEq+ODL2HeQjnzlSZpbY80e1LUl5hyxWcoBHvL0UZVcuN+gxL/TZfGo//j+omSzbkknEyG0ZB
 ltO716Aqc8lWaIVj4AUfbrkazFEaUlfd1VFcMDKy2QFqEu6
X-Google-Smtp-Source: AGHT+IFYs3QtoxgIt/+5OM9BelmjkZEGfNgGDmSqDdf0VdJBwG7FyC49LZevuXDWvLDf7cnqliB+8g==
X-Received: by 2002:a05:600c:3b25:b0:431:680e:95ff with SMTP id
 5b1f17b1804b1-433489b1b15mr67531905e9.9.1732208291580; 
 Thu, 21 Nov 2024 08:58:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463aba6sm61641465e9.34.2024.11.21.08.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E10F05FBC0;
 Thu, 21 Nov 2024 16:58:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 05/39] tests/functional: remove leftover :avocado: tags
Date: Thu, 21 Nov 2024 16:57:32 +0000
Message-Id: <20241121165806.476008-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

These tags are not honoured under the new functional test harness.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-6-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_arm_bpim2u.py   | 20 --------------------
 tests/functional/test_arm_orangepi.py | 27 ---------------------------
 2 files changed, 47 deletions(-)

diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index 2f9fa145e3..35ea58d46c 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -37,11 +37,6 @@ class BananaPiMachine(LinuxKernelTest):
         '5b41b4e11423e562c6011640f9a7cd3bdd0a3d42b83430f7caa70a432e6cd82c')
 
     def test_arm_bpim2u(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:bpim2u
-        :avocado: tags=accel:tcg
-        """
         self.set_machine('bpim2u')
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.extract_from_deb(deb_path,
@@ -64,11 +59,6 @@ def test_arm_bpim2u(self):
         os.remove(dtb_path)
 
     def test_arm_bpim2u_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:bpim2u
-        """
         self.set_machine('bpim2u')
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.extract_from_deb(deb_path,
@@ -105,11 +95,6 @@ def test_arm_bpim2u_initrd(self):
         os.remove(initrd_path)
 
     def test_arm_bpim2u_gmac(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:bpim2u
-        :avocado: tags=device:sd
-        """
         self.set_machine('bpim2u')
         self.require_netdev('user')
 
@@ -160,11 +145,6 @@ def test_arm_bpim2u_gmac(self):
 
     @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
     def test_arm_bpim2u_openwrt_22_03_3(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:bpim2u
-        :avocado: tags=device:sd
-        """
         self.set_machine('bpim2u')
         # This test download a 8.9 MiB compressed image and expand it
         # to 127 MiB.
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index d2ed5fcc82..6d57223a03 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -49,11 +49,6 @@ class BananaPiMachine(LinuxKernelTest):
         '20d3e07dc057e15c12452620e90ecab2047f0f7940d9cba8182ebc795927177f')
 
     def test_arm_orangepi(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=accel:tcg
-        """
         self.set_machine('orangepi-pc')
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.extract_from_deb(deb_path,
@@ -75,11 +70,6 @@ def test_arm_orangepi(self):
         os.remove(dtb_path)
 
     def test_arm_orangepi_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:orangepi-pc
-        """
         self.set_machine('orangepi-pc')
         deb_path = self.ASSET_DEB.fetch()
         kernel_path = self.extract_from_deb(deb_path,
@@ -115,12 +105,6 @@ def test_arm_orangepi_initrd(self):
         os.remove(initrd_path)
 
     def test_arm_orangepi_sd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=accel:tcg
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        """
         self.set_machine('orangepi-pc')
         self.require_netdev('user')
         deb_path = self.ASSET_DEB.fetch()
@@ -167,11 +151,6 @@ def test_arm_orangepi_sd(self):
 
     @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
     def test_arm_orangepi_armbian(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        """
         self.set_machine('orangepi-pc')
         # This test download a 275 MiB compressed image and expand it
         # to 1036 MiB, but the underlying filesystem is 1552 MiB...
@@ -208,12 +187,6 @@ def test_arm_orangepi_armbian(self):
 
     @skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
     def test_arm_orangepi_uboot_netbsd9(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:orangepi-pc
-        :avocado: tags=device:sd
-        :avocado: tags=os:netbsd
-        """
         self.set_machine('orangepi-pc')
         # This test download a 304MB compressed image and expand it to 2GB
         deb_path = self.ASSET_UBOOT.fetch()
-- 
2.39.5


