Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFF5C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiC3Q-0000Kr-9U; Wed, 12 Feb 2025 07:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiC03-0003it-Jr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:37:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBzv-0000dO-Pc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:37:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso47055575e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 04:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739363861; x=1739968661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03rJTTNBd3cp6/LXAuK3umtC787I9nHxNQm0tFuSG4M=;
 b=CKvdeYlwJMI2BNNu3xsP4O4azVu0WKlyUgLaFK6GE9iWxXOPt0MtM4m8qloKltuVK9
 u9/b26kAFb0U2pFs7PKFqKFK4tRqPFHutdzVbjGVmNFEmt9yfJgbMwkzJifwnkJmYw9l
 HWDoC67JJt6tMSTmuF1lZqk+HTZliVhnHwAaW2Q0hi01FtA9KKweU4MJj93Dla6fUS1c
 WszeussVKZIDrHiRn5i6SsW/8uf/+Z3XrKKceopaiHaqUxQNqA+GametzC3b5yRx17Io
 6888Jc8QG2wrmTbHtrIeemqwfv2Bnm6qQD+YSROMyhKtCoX4YKJKfXzvVuycKk5hpMAj
 2cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739363861; x=1739968661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03rJTTNBd3cp6/LXAuK3umtC787I9nHxNQm0tFuSG4M=;
 b=QlUj+S38bhCW3oYdDQoJU9Z72QRe3oxdZXqaNZ/ANHBd5eOX1MGL5AfumnlLtYCII0
 aAtTUJngqZxY6zaCd+swELwUDlt1UpmNrzX/IhCOzE+OSVPefk2rzP6FCMiAfRzbuOgz
 Xz0BX67YuaT153/YgTM1I+KwlqOTYQaYDIBxLTSYmb3fESk+iZOk+rPRylhkvbaZ94L8
 it2nO2jJQqmPVrqf61Dwuyqcu0Bmj9/f/spHUd9NYDZdXUlWjSuJ4OI/xTjDTw+VWRRB
 mtndU2lR+MIIPBxKemE6nY1IT99wIitKtNgJTrV3UKwOnti5krVx+um1muUFCI19nqYz
 Spdg==
X-Gm-Message-State: AOJu0YzC0oAquceNWvf+8I+QUlGkts5h9VU6YN/ElZ9UISr5+qm6Ik2P
 FpTwyE9HT4aLG0Q2JjcpUSqSltFiItC/G/+AxgPwtSb0HypNZ+Xr1+LWm2d1w6qoJt0bWxCGJE7
 yhk0=
X-Gm-Gg: ASbGncu9gRDMup8cKzdNPQhrLbSWyBPlyNpiDr9gR1vfLAesSfySpr414HrWOUx/pIR
 M6QRZtJy8QsMxm6m5jCnbbReanKl4lu4SwtuN1lBGihfK5VThOxWlpviJ9cQ9i+N/fkEbjHYRt0
 Qg/2WwbPzOdpuZArweK7xH0mzMBbj0K86ufwT+BhVX9lARsCBkgZwfS6noY/JcBGbSq2aPg0KSj
 uJ2bpOIZyvSBUJxyT765i+KUPpt6nB/+2fJZsyyZ9jpZnx4ZJ5+R3zsLWd9EA00jNWy+y5RgiaU
 A03GYiJr+PSx7jI6XiLIH6gPCxe5n7nBQl5VOWw36/OcD+CuRc+mpplJ+IrFQwPewQ==
X-Google-Smtp-Source: AGHT+IFQ6CKULX/T9LcHsAuAEWGDnWWuovw2HizT4H2oQKqNQDmU3OxIuoVqJoFoELb99UhDRbUatw==
X-Received: by 2002:a05:6000:1f8f:b0:38d:cdac:fc02 with SMTP id
 ffacd0b85a97d-38dea256d2fmr2139711f8f.4.1739363860684; 
 Wed, 12 Feb 2025 04:37:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcaf3e4bcsm14359226f8f.41.2025.02.12.04.37.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 04:37:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 08/10] tests/functional: Allow microblaze tests to take a
 machine name argument
Date: Wed, 12 Feb 2025 13:36:57 +0100
Message-ID: <20250212123659.52764-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212123659.52764-1-philmd@linaro.org>
References: <20250212123659.52764-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Make microblaze tests a bit more generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250206131052.30207-14-philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 7 +++++--
 tests/functional/test_microblazeel_s3adsp1800.py | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index fac364b1ea9..c4226f49cf3 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -20,8 +20,8 @@ class MicroblazeMachine(QemuSystemTest):
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800_be(self):
-        self.set_machine('petalogix-s3adsp1800')
+    def do_ballerina_be_test(self, machine):
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
@@ -34,5 +34,8 @@ def test_microblaze_s3adsp1800_be(self):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    def test_microblaze_s3adsp1800_legacy_be(self):
+        self.do_ballerina_be_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 5d353dba5d2..715ef3f79ac 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -21,9 +21,9 @@ class MicroblazeelMachine(QemuSystemTest):
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800_le(self):
+    def do_xmaton_le_test(self, machine):
         self.require_netdev('user')
-        self.set_machine('petalogix-s3adsp1800')
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
@@ -38,5 +38,8 @@ def test_microblazeel_s3adsp1800_le(self):
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
+    def test_microblaze_s3adsp1800_legacy_le(self):
+        self.do_xmaton_le_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.47.1


