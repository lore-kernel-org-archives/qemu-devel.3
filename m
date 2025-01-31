Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C6C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDl-0007IR-KL; Fri, 31 Jan 2025 16:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDj-0007BO-1W
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDh-0007rs-44
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso28074925e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357591; x=1738962391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5CNBPU1P4v/ShPK33kQ6y31CBTCaAZhUebKc6WsLh0=;
 b=lDBic3GQHlcUqS1Qq1rPBqox8DeYIIUGfphf4yxiTi0fpamWW1Qnk+EW4bJNGKyvdL
 myAqS22CkCEHGm5ys6V2UDirYD2mgJ85L+/RqI4IHGDlZ1+AxqMfdwZCHlf8VzFXZKAZ
 7Lh0IfuK46ND3JOB3ZGPyFnaI4LByjG9/AopzNT5av5nzv86Ya5c/0sfOzSZPjJQRJcl
 THq4/N/UOJitkWoGzcdeeC0PrH48MLtzcpvCTXMKHWpNITqrmEoGahYn105AwfGGWgGn
 Ies3VqhDUfDvQY45ByCtiK/xINXCHNHJ1erHBW0ab31f/wrywEUqOzdwhuY0u13jLIWD
 HSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357591; x=1738962391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5CNBPU1P4v/ShPK33kQ6y31CBTCaAZhUebKc6WsLh0=;
 b=hHuUjWC/2dP7ERjjMf4Za/8g7AQbm+718z3HEaLxkv4H6H1D817viBLyPwRwWVwltW
 V5NMn3mnj+GlfX2WfGd5ppapC2m/fjDwR7M2Efb1MZUBt/Adj1ND3Drgbm1DEHGZeV/z
 DCnabJYSGgb1aOtIXYqP3T3fsgh+oHKJAjboAbmXdWppeD0iKCpqK+fwxHM9x151MEFO
 ay0+bGuGHlgMmpScwIYKaTDSkZbuovHfn8zozWgxd72Dg4ot/KJ9CXzQF9zS36yc4EYU
 P6Egoyta6HoNADr3u54OD9JtroRb0LSx4kxNj1ILpnrqrcxidzoNij90rw9wHeFnagIo
 F5fQ==
X-Gm-Message-State: AOJu0Yw8UedByQIS90lUNmiAJV22+3R8oIqVrOAcq/NnxfHdL60BCaqe
 S+K3sDmzwfF/V8PMHJkpnZ60YUpDJ+1tjIKGqIkE+HF6nBsFo+ggNfdfrkohL7K2JCscrkn/10y
 hi5A=
X-Gm-Gg: ASbGncu/SGmNaLVutKX0dqj1B3Ey7l2C0qpwRF1qODf60EKvpYDFwsDGmhiSSvR0Qeu
 SwaCVMMP2TOYYaQiqpF3792uskzQnlNRU8Qc4Df5ZP39sDs4aLiEldt0mtfCWnEPU/a9gAOs5I+
 kr0WetxBMqSCwhLElP6XFDdoSF0RNWENzYQN9Z5BuiMjCpYQpNz9fsa6R+JXQ6wE5g1pkoLUlu/
 3AYryfWe9/8Paxe2vYYIrwSkMB5nt4EppVnzCvZSS8KuGNP7CJophshjhAaXKV2e00txv1wAMXq
 y3POY0xl0woTFPrmSRVJnKkuqQcXCSTq/JltZediq6tj/z+f0+dKJnICJBA0I++Edg==
X-Google-Smtp-Source: AGHT+IF6Qss+U0I+UaYYlddIFCecbwVQ+lOYZYhE29hOQPeaaTBCjp6Ahtw+FHD0tNeWv1PvM0jajA==
X-Received: by 2002:a05:6000:4008:b0:38a:88be:bcb5 with SMTP id
 ffacd0b85a97d-38c51932095mr10227457f8f.5.1738357590983; 
 Fri, 31 Jan 2025 13:06:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df51sm104244225e9.30.2025.01.31.13.06.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 14/36] hw/ipack: Clarify KConfig symbols
Date: Fri, 31 Jan 2025 22:04:57 +0100
Message-ID: <20250131210520.85874-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Split IPACK Kconfig key as {IPACK, TPCI200, IP_OCTAL_232}

  - IPack is a bus
  - TPCI200 is a PCI device providing an IPack bus
  - IP-Octal232 is an IPack device plugged on an IPack bus

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20250121155526.29982-3-philmd@linaro.org>
---
 hw/char/Kconfig                | 5 +++++
 hw/char/meson.build            | 2 +-
 hw/ipack/Kconfig               | 4 ++++
 hw/ipack/meson.build           | 3 ++-
 tests/qtest/libqos/meson.build | 4 +++-
 tests/qtest/meson.build        | 4 +++-
 6 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 4b73a803bf3..1dc20ee4c2c 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -78,3 +78,8 @@ config GOLDFISH_TTY
 
 config SHAKTI_UART
     bool
+
+config IP_OCTAL_232
+    bool
+    default y
+    depends on IPACK
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 1750834385a..ed3529cbbb7 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -4,7 +4,7 @@ system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
-system_ss.add(when: 'CONFIG_IPACK', if_true: files('ipoctal232.c'))
+system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_uart.c'))
diff --git a/hw/ipack/Kconfig b/hw/ipack/Kconfig
index f8da24a62be..28d668727c8 100644
--- a/hw/ipack/Kconfig
+++ b/hw/ipack/Kconfig
@@ -1,4 +1,8 @@
 config IPACK
     bool
+
+config TPCI200
+    bool
+    select IPACK
     default y if PCI_DEVICES
 	    depends on PCI
diff --git a/hw/ipack/meson.build b/hw/ipack/meson.build
index 26567f1068e..e4805228926 100644
--- a/hw/ipack/meson.build
+++ b/hw/ipack/meson.build
@@ -1 +1,2 @@
-system_ss.add(when: 'CONFIG_IPACK', if_true: files('ipack.c', 'tpci200.c'))
+system_ss.add(when: 'CONFIG_IPACK', if_true: files('ipack.c'))
+system_ss.add(when: 'CONFIG_TPCI200', if_true: files('tpci200.c'))
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 46f130ccfdb..1ddaf7b095b 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -32,7 +32,6 @@ libqos_srcs = files(
         'i2c-omap.c',
         'igb.c',
         'sdhci.c',
-        'tpci200.c',
         'virtio.c',
         'virtio-balloon.c',
         'virtio-blk.c',
@@ -70,6 +69,9 @@ endif
 if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
   libqos_srcs += files('riscv-iommu.c')
 endif
+if config_all_devices.has_key('CONFIG_TPCI200')
+  libqos_srcs += files('tpci200.c')
+endif
 
 libqos = static_library('qos', libqos_srcs + genh,
                         build_by_default: false)
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 94b28e5a534..e60e92fe9de 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -286,7 +286,6 @@ qos_test_ss.add(
   'e1000-test.c',
   'eepro100-test.c',
   'es1370-test.c',
-  'ipoctal232-test.c',
   'lsm303dlhc-mag-test.c',
   'isl_pmbus_vr-test.c',
   'max34451-test.c',
@@ -317,6 +316,9 @@ qos_test_ss.add(
 if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
   qos_test_ss.add(files('virtio-serial-test.c'))
 endif
+if config_all_devices.has_key('CONFIG_IP_OCTAL_232')
+  qos_test_ss.add(files('ipoctal232-test.c'))
+endif
 
 if host_os != 'windows'
   qos_test_ss.add(files('e1000e-test.c'))
-- 
2.47.1


