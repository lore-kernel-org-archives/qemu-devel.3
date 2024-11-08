Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF34D5C0EF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RAq-0007Ja-HB; Fri, 08 Nov 2024 10:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RAK-00064g-TX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RAI-0005lN-Dk
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso20611365e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080685; x=1731685485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbUeKq8wIPtd30sIyAicGmI1dVV7JgXeFSyihDqJX1Q=;
 b=fMTFArCMC/c5BpX2L//HRC1RrQRnPoXekNRoil8CzrLBbXE4BFuueAmY7HO9wXcFes
 3QxmrefhOEHntpa12h5168hGLu4EyhMDzSoRU/PO65S6JPCGgRvEfpSZzErcMPevnT+J
 Agbn4Ea2gC96SI2c5VcgHoVaqVhvqx3MSgfZ2nhRNTWDOm3HDiExth7pqd5ewhRHVpMn
 T5XaSCTgf0aPTDfebHvXePSX7AD7O55JxdSq+oMdSEfuslfCSkVcdzYFWLdjVoLxBxEJ
 N9cG8oCwKnaQN4FA0AAeeIH9qVCrEDd+KHaiIUCtOL68m1j1IfeO+YhQYt4rZxBpzwzS
 F2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080685; x=1731685485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbUeKq8wIPtd30sIyAicGmI1dVV7JgXeFSyihDqJX1Q=;
 b=BMyEJXGnvbMP51dHXHrn49k1+st25rXqX5R5d3F8ioHSuPAOcj0rhr+C5zHwshmSJy
 Tpni+CBOATYduuqJbt3kbRXqcavPU2meCgi2jN0fCGTe91OUIf9gDQ99Tr8rnmEq1Ozg
 iB1wuGBsTR+hdKntiFaF5OffPlzP8N4WN0M/BIlRLlATVsnsYgaklzLLGVibEWor9Js5
 erEozs8avAyReDiLXY0005G4NtIj0No7N1cGUFoNHZr/lpbcbVM57ThEi0FQ45APatnp
 xMU5du8iruC950SFJNa1IxVuj/mxul1bgt1kz5TRoEZrVJ0FMZyZVd0SASi1r2fFp8PC
 6ZHQ==
X-Gm-Message-State: AOJu0Yw2jTcxhHGxwoq1gcbkmLhiFcnRipewLXP4pjNWam3if0g+9mlx
 PshFBAQjWp95LBodeDkzP2vxzrzHKp3Npq9IpRFZghziq0z4yTBjI74JAtMVGz2kb3RPG1q367B
 +
X-Google-Smtp-Source: AGHT+IEJzY/T+wCxqzs5cx4Z3nsnVYk8LN5PVrt4Yhd6YV+ij6ncY6fMSy/htMRM/yDwBaGpoKrIZQ==
X-Received: by 2002:a05:600c:1c98:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-432b750a358mr28190085e9.19.1731080684756; 
 Fri, 08 Nov 2024 07:44:44 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c26e3sm75094025e9.33.2024.11.08.07.44.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:44:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/17] tests/functional: Add microblaze cross-endianness
 tests
Date: Fri,  8 Nov 2024 15:43:17 +0000
Message-ID: <20241108154317.12129-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Copy/paste the current tests, but call the opposite endianness
machines, testing:
- petalogix-s3adsp1800-le machine (little-endian CPU) on the
  qemu-system-microblaze binary (big-endian)
- petalogix-s3adsp1800-be machine (big-endian CPU) on the
  qemu-system-microblazeel binary (little-endian).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 .../functional/test_microblaze_s3adsp1800.py  | 21 +++++++++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 2b2f782270..7f5e8b6024 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -36,5 +36,26 @@ def test_microblaze_s3adsp1800_be(self):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    ASSET_IMAGE_LE = Asset(
+        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
+    def test_microblaze_s3adsp1800_le(self):
+        self.require_netdev('user')
+        self.set_machine('petalogix-s3adsp1800-le')
+        file_path = self.ASSET_IMAGE_LE.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
+        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + '/day13/')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 1aee5149fb..60543009ba 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -38,5 +38,24 @@ def test_microblazeel_s3adsp1800_le(self):
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
+    ASSET_IMAGE_BE = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day17.tar.xz'),
+        '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
+
+    def test_microblazeel_s3adsp1800_be(self):
+        self.set_machine('petalogix-s3adsp1800-be')
+        file_path = self.ASSET_IMAGE_BE.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'This architecture does not have '
+                                       'kernel memory protection')
+        # Note:
+        # The kernel sometimes gets stuck after the "This architecture ..."
+        # message, that's why we don't test for a later string here. This
+        # needs some investigation by a microblaze wizard one day...
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.45.2


