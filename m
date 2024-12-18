Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59412E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwod-0000OM-2n; Wed, 18 Dec 2024 11:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnt-0007nu-FM
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:41 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnW-0006r2-GB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:41 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa6997f33e4so1020822066b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538876; x=1735143676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xo7zkZdpfvYcJ6r/NMXHOepy4SIK5Z2dKxxcbjI2QMM=;
 b=iQ6gWRp3rd2UagrBJro8DXEe02cPOqchZu0Rh6GdiB/UOJZ8nSBhNZnIGLJNWMjsLG
 iISzw6mUE8sNdD1lvRexMeowJ20/pUuTnGVLxH3dCa4YQfk7aXH35wvVBh3bnjI00Ypr
 cj+wWtU4FF+Gl85IU7cp8F5Uxd+PzB5vuAvmKBRN16nG89dY3VPmZPwh0HDi/c2ClaZp
 XL0YzNBvGdq0RUZPTrZ99pnnFTKrwmM10P3fzUqrseYzPP9gR2W1l1I41Vq9yFgjbo4y
 L3jotgZwKEgXPGMjMkcYIky9QrV6h7ug1+DB4YnsHTSmgw9OaBSrXv0rUR6JqaCzxREr
 fdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538876; x=1735143676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xo7zkZdpfvYcJ6r/NMXHOepy4SIK5Z2dKxxcbjI2QMM=;
 b=qAgiOetEvaRoD355dkR//WWQgy6PUIgLWeCtRvU6R1KUZMTbWkUSvJPCO+xOdUi6L4
 L6MAxWwbkOTJJa9t13kaC+u5LzhdxzwrgI4+WyUJ20ZOR3Bci8Vez6DQ+XiEBzlvbH1q
 JEmdQh5IxkFLSV3Jjk0aBFf76ITxm6J0eH57o/QF6OV1+RWYGKHXT0iFC1ZkyWDLTT1n
 gfcci7wsLnM+9laRtW4zZ3F91nBnOGa4Iq9bB/7T8StGRdNMN27n1sPxD4Khor9PJKbU
 RW/BZwfpjbidVHlmaYN0cWHtncrmbuTLiNjM7zTWXb+0vx1nOwMrS0OGeyxdbPRNsbpp
 NYNQ==
X-Gm-Message-State: AOJu0YzaUz3I2KVfDaUWyrTX3uIDgpiar39JKUi5mefLgqyRLxrklsiD
 Fu3cGNaNXIDEQBFMWValQNueUUNB+Balm+jXPyR7iP0F9LUWsPyRrPchpK7WouA=
X-Gm-Gg: ASbGncuyMCIu8r/YXU2vvyuP7bDobraxNke/2v59BkRdcU6FJf+OMR8I0i50NRUm8m/
 fdASS5ibXCdfrMPsTvyAf48JQQ61YlmxQqJ2qhmK5AazWataBVOrAX0AIs831Tnpmfiy33yZDSb
 VwjLSl4+YN4tKnArteUv5iAwc35BWr4EzgeC4F0FnuMJdE+XbNFXUaNWhCqy5xqdmmvZNomh4xp
 7fAaIxfFVpNKbz+AS1zVxkFHI6Qrx6oXEX9wX17xWkGuc2rtNKOjsY=
X-Google-Smtp-Source: AGHT+IHeoSnKXsDEx5rMZZObT3eY0nGeZYbMQXLmq1crBUUsmNXh7AoEX5eyuZxO5S5xRhk3J9G35A==
X-Received: by 2002:a17:906:1c54:b0:aac:439:fc0 with SMTP id
 a640c23a62f3a-aac04391122mr92434666b.51.1734538876255; 
 Wed, 18 Dec 2024 08:21:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab960065dcsm576698566b.2.2024.12.18.08.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F34E85FBC6;
 Wed, 18 Dec 2024 16:21:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 19/27] tests/functional: remove hacky sleep from the tests
Date: Wed, 18 Dec 2024 16:20:55 +0000
Message-Id: <20241218162104.3493551-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

We have proper detection of prompts now so we don't need to guess with
sleep() sprinkled through the test. The extra step of calling halt is
just to flush the final bits of the log (although the last line is
still missed).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - avoid long lines by iterating through an array
  - drop time import
---
 tests/functional/test_aarch64_virt.py | 29 +++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index c967da41b4..453e84c39f 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -10,7 +10,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import time
 import os
 import logging
 
@@ -107,18 +106,22 @@ def common_aarch64_virt(self, machine):
                          'virtio-blk-device,drive=scratch')
 
         self.vm.launch()
-        self.wait_for_console_pattern('Welcome to Buildroot')
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
-        exec_command(self, 'dd if=/dev/hwrng of=/dev/vda bs=512 count=4')
-        time.sleep(0.1)
-        exec_command(self, 'md5sum /dev/vda')
-        time.sleep(0.1)
-        exec_command(self, 'cat /proc/interrupts')
-        time.sleep(0.1)
-        exec_command(self, 'cat /proc/self/maps')
-        time.sleep(0.1)
+
+        ps1='#'
+        self.wait_for_console_pattern('login:')
+
+        commands = [
+            ('root', ps1),
+            ('cat /proc/interrupts', ps1),
+            ('cat /proc/self/maps', ps1),
+            ('uname -a', ps1),
+            ('dd if=/dev/hwrng of=/dev/vda bs=512 count=4', ps1),
+            ('md5sum /dev/vda', ps1),
+            ('halt -n', 'reboot: System halted')
+        ]
+
+        for cmd, pattern in commands:
+            exec_command_and_wait_for_pattern(self, cmd, pattern)
 
     def test_aarch64_virt_gicv3(self):
         self.common_aarch64_virt("virt,gic_version=3")
-- 
2.39.5


