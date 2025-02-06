Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A93FC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1gK-0006ju-UF; Thu, 06 Feb 2025 08:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1g3-0006QW-BV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:12:20 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1g0-0008JU-IT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:12:19 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso6253545e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847530; x=1739452330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeunrBTdlxarEESrVvUOHeU40/m+EAzAKhgKeitt+so=;
 b=dss3fVcmHATTQ1/Bp3Wb77WX4Mh7qATOZMRhrok0CI4Y63kkcplkBPlHxT7Y4UZEAH
 2ATEZeKct4xC3Ymnd3IN9oxiHR4I30xcVie3b0mnnZ/Nh/f+PYnIcxaJGSowRfuW0B20
 gFHJLjShQUbTr+D7b1F3oxfVfAxpFdU3knNPytt8s2b0G5fWM727/VkrbIwLmqyLxGFF
 AVC53Nf5QV4C+j1JAZdbU/6E3W1AVaL047E35LjdUJgnDH5R2YBApws8vf+uSxXq7ND9
 a7gygurW6PiBjBwaoQE90dI9pXCJXt1ccNdqplEOxsIX7lMdmrwtwprZh+Gj0Om+Pe7m
 cycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847530; x=1739452330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeunrBTdlxarEESrVvUOHeU40/m+EAzAKhgKeitt+so=;
 b=NmM30i0l+CRzICChEEWBk2C2Ko9ogrBsES/mQLiVUStyD3RclfQKjYC31qDEWz9Tls
 Pg4/eoDib12+OXu77ZhHwi/cXTpM+Jp+9DLLXCl8dVRZu6lvc5C83iVMLNQdt2J4CqcQ
 a3zL85VX9XZRUDoJvka4I1BA3PfZQbcmbglJDvlonhgxRQOJHcWEkTssGD92CprGvvK9
 LYRZ3kFsC+hIVuPHIfq0fgs0IEzNoHDPcV1E7jU2KuOuUSXp3P7bQqgyAFMm2afuMRbn
 HlIOPFA0V4zm524QLVxj8urKNLzKh0QhQCYutHNl60rSRZBjZZMeuXvo4j38BWE9dRAy
 f+XQ==
X-Gm-Message-State: AOJu0YxAeE3hKIrWteroffgwwJ9Nq0LPpiqY1iZfYixrbuH8FRRyTSdy
 iXAdU8ahLtWvig+8ee2nxRAdVcRRiaNQ0d/kv5foH2HcMAkLhZj56a7IkM9RdF7ZIQR5IbzCl26
 huTA=
X-Gm-Gg: ASbGnctlPQhAuAg8P/iEldI8h2qM6vSNoowSIVsDfwHJ+iIWcd0/S5CsCpluGDWcBHJ
 06O2lnFNHg7izSemveBHh8umySJPLWnusJmFbC3px9VtZYue2Yxkg0ymxVoSgnKI5nH9NnM5qIm
 F7JjIS6w4kqwWUL7oVkNqD+kwmRxk20c7hO78C+BDKdiSC4EujlW6G9rG8YSFX9H+AEen67qVWu
 OyaXrxAysmYhbdiW0I7OSkSBhd+FyXLXu5KbBuHUHnELU1eCCK59D9iPFwVgLaQkdumzFTW5llk
 r5HSnyXt0FMDHakoa1doP1RbU5DzK5PH5k/Yq0JOxZ4pl5tdO2Fmi/ztf2jNLlQbHg==
X-Google-Smtp-Source: AGHT+IH0aKteGCFajoI341OTjLprksXaY2VWE9YgwgRJzCeJuPAJpZtQB6h5U6OWJvd5Gxz4Bh4P3Q==
X-Received: by 2002:a5d:64e5:0:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-38db48a9dcemr5085557f8f.11.1738847529776; 
 Thu, 06 Feb 2025 05:12:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dcb0e92sm18665985e9.24.2025.02.06.05.12.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:12:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 15/16] tests/functional: Have microblaze tests inherit
 common parent class
Date: Thu,  6 Feb 2025 14:10:51 +0100
Message-ID: <20250206131052.30207-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Have the MicroblazeMachine class being common to both
MicroblazeBigEndianMachine and MicroblazeLittleEndianMachine
classes. Move the xmaton and ballerina tests to the parent class.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .../functional/test_microblaze_s3adsp1800.py  | 23 +++++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 29 ++-----------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index c4226f49cf3..177c8a685bc 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -7,6 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
@@ -20,6 +21,10 @@ class MicroblazeMachine(QemuSystemTest):
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
+    ASSET_IMAGE_LE = Asset(
+        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
     def do_ballerina_be_test(self, machine):
         self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
@@ -34,6 +39,24 @@ def do_ballerina_be_test(self, machine):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    def do_xmaton_le_test(self, machine):
+        self.require_netdev('user')
+        self.set_machine(machine)
+        self.archive_extract(self.ASSET_IMAGE_LE)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
+        tftproot = self.scratch_file('day13')
+        self.vm.add_args('-nic', f'user,tftp={tftproot}')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
+        wait_for_console_pattern(self, 'buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
+
+class MicroblazeBigEndianMachine(MicroblazeMachine):
+
     def test_microblaze_s3adsp1800_legacy_be(self):
         self.do_ballerina_be_test('petalogix-s3adsp1800')
 
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 60aab4a45e8..56645bd0bb2 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -7,34 +7,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest
 
+from test_microblaze_s3adsp1800 import MicroblazeMachine
 
-class MicroblazeelMachine(QemuSystemTest):
-
-    timeout = 90
-
-    ASSET_IMAGE_LE = Asset(
-        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
-        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
-
-    def do_xmaton_le_test(self, machine):
-        self.require_netdev('user')
-        self.set_machine(machine)
-        self.archive_extract(self.ASSET_IMAGE_LE)
-        self.vm.set_console()
-        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
-        tftproot = self.scratch_file('day13')
-        self.vm.add_args('-nic', f'user,tftp={tftproot}')
-        self.vm.launch()
-        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
-        wait_for_console_pattern(self, 'buildroot login:')
-        exec_command_and_wait_for_pattern(self, 'root', '#')
-        exec_command_and_wait_for_pattern(self,
-                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
-                '821cd3cab8efd16ad6ee5acc3642a8ea')
+class MicroblazeLittleEndianMachine(MicroblazeMachine):
 
     def test_microblaze_s3adsp1800_legacy_le(self):
         self.do_xmaton_le_test('petalogix-s3adsp1800')
-- 
2.47.1


