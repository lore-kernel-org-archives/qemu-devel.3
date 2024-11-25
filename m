Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEAFD58D5E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatw-00043x-Ta; Mon, 25 Nov 2024 10:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatu-00041z-0O
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:22 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFats-0001nk-1L
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:21 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38241435528so2978816f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548078; x=1733152878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0Jv+RuwZ4qU8JN4denFC5y9n9dFSvMC6CsXxTRmdVk=;
 b=epor75q1wX4WGtCVDHWWhae1sso0zGdxIXhDFE9qGdmDP5YKzOAtQZbGxBW5Z7Bsp9
 ThttssYRTD3TeMGBrRS1sGol/9ru/fUajmA1s/C8mF7h7LP0MSNSVJNrc9lBbsLtPlJW
 82xgwygn2NCxKld6JabRnpmbJQUBfDApQ9nkwV3qmH5jRZb7ESwo06fBQKR8qVZoQ0qH
 So/S/2VBlZ2ZCDGShuayvuUfFS9eT/UOKXi44qt2SEa4hpZ633twzCCqfEa/Nt58zeC+
 nxs5qwqIIy65blZ0VZILU1skP2OA7DI4pkq8odd9tDqR/h0HwZKJWqNQPH9krsGAGZWS
 v9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548078; x=1733152878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0Jv+RuwZ4qU8JN4denFC5y9n9dFSvMC6CsXxTRmdVk=;
 b=nogdauVf36/hzAirXFDW1scD5Es4P+MN0e8hCWy+5zw1g24LPz6idz6MucNVNxAf7p
 tzg4tD7KbK88m/jK1P6iQ+wieZ7YjA0FKWCw+FON7gAK5tihCMlEenwzSjvi0pQ6pxXm
 BNuzc3KEdDL3JndKBZN6djjiFSajbNhmHaSZ5YGeScHmruD3N8yH/SU4QkdPhkoTl51z
 yOu0ptYZ6/r01p8SxNwt4EYHmrg0+zy6aQA47L7ZKsVuuHM6Z+Z46DhZ43AprfYb0Fqj
 kes2FxX3+qUL3CDcvpo10i2NEJ9L76U8iPf1eKqP45FsdyetfFrJW2JtksCrxzJB22I7
 R7BQ==
X-Gm-Message-State: AOJu0YwxAWwZtW/l0sz7PNZbFlKWI+jBbouOcAzi9ACabGPPkU6L3WL6
 KdJfO9npb0nVVTlilNe1ULRLGjQ/OUAZbUOfR51RIIMNHvTTMqU6H3Va3twAhqw0MO/Rg4AbEi5
 4
X-Gm-Gg: ASbGncuJoUK5xAaVCK/3FSA/JvjH77X7NsOoETUc21y3AghV+Lxefdug+UPs564SiM3
 u0WXko6lTSvYEESX/1d2iwF46zzRrprNDoxFu6bDyea8oxxYw3p20awdMku/EtHS6KuoYWpuiwD
 HI7kzjhOWiSB/whyXmOpGHTSq4dNNQ3Yurl8NuDlTM9VJ9taJ8HaSHKz+pWlZlHISM2hVOEAc0p
 3C2cSK0O3tap/UN1aNZ+B7IXkGQhEsdWkP1aUnDyHkiDBtp
X-Google-Smtp-Source: AGHT+IF8HNQBJFCwpfegBfbz3ISlIuQVCPRvhZ2vsBWTnn8MXg6hhvUrEjkbzSRUyNf5T3m7pO762A==
X-Received: by 2002:a05:6000:1fab:b0:382:4aa0:e728 with SMTP id
 ffacd0b85a97d-38260b46dd6mr11847210f8f.1.1732548078384; 
 Mon, 25 Nov 2024 07:21:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde1107csm133489385e9.15.2024.11.25.07.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CBB863ACC;
 Mon, 25 Nov 2024 15:21:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PULL 28/28] tests/functional: Remove sleep workarounds from Aspeed
 tests
Date: Mon, 25 Nov 2024 15:21:05 +0000
Message-Id: <20241125152105.2100395-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Cédric Le Goater <clg@redhat.com>

These were introduced in the avocado tests to workaround read issues
when interacting with console. They are no longer necessary and we can
use the expected "login:" string or the command prompt now. Drop the
last use of exec_command.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241122090322.1934697-4-clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index c2c152229b..d88170ac24 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -14,7 +14,6 @@
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
-from qemu_test import exec_command
 from qemu_test import has_cmd
 from qemu_test.utils import archive_extract
 from zipfile import ZipFile
@@ -136,10 +135,8 @@ def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'
         self.wait_for_console_pattern('lease of 10.0.2.15')
         # the line before login:
         self.wait_for_console_pattern(pattern)
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
-        exec_command(self, "passw0rd")
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, 'passw0rd', '#')
 
     def do_test_arm_aspeed_buildroot_poweroff(self):
         exec_command_and_wait_for_pattern(self, 'poweroff',
@@ -158,7 +155,7 @@ def test_arm_ast2500_evb_buildroot(self):
         self.vm.add_args('-device',
                          'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
         self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
-                                                'Aspeed AST2500 EVB')
+                                                'ast2500-evb login:')
 
         exec_command_and_wait_for_pattern(self,
              'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
@@ -188,7 +185,8 @@ def test_arm_ast2600_evb_buildroot(self):
                          'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
         self.vm.add_args('-device',
                          'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
-        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 'Aspeed AST2600 EVB')
+        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00',
+                                                'ast2600-evb login:')
 
         exec_command_and_wait_for_pattern(self,
              'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
@@ -209,8 +207,8 @@ def test_arm_ast2600_evb_buildroot(self):
         exec_command_and_wait_for_pattern(self,
              'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
              'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
-        exec_command(self, 'i2cset -y 3 0x42 0x64 0x00 0xaa i');
-        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+             'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#');
         exec_command_and_wait_for_pattern(self,
              'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
              '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
-- 
2.39.5


